
import {pluck, map} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { Observable, Subject ,  forkJoin } from 'rxjs';
import { PaginationInfo, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { DataStoreService, CommonHttpService, AuthService } from '../../../@core/services';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { AlertService } from '../../../@core/services/alert.service';
import { HomeDashboardService } from '../home-dashboard.service';
import { NgxPaginationModule } from 'ngx-pagination'
import { MatSelectModule } from '@angular/material/select';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';

@Component({
    selector: 'dashboard-myrejectedclosedapp',
    templateUrl: './dashboard-myrejectedclosedapp.component.html',
    styleUrls: ['./dashboard-myrejectedclosedapp.component.scss'],
    imports:[MatSortModule,NgxPaginationModule,RouterLink,MatSelectModule,FormsModule,CommonModule],
    standalone: true
})
export class DashboardMyrejectedclosedappComponent implements OnInit {

  myApplicationList$!: Observable<any>;
  @Input()
  eventSubject$!: Subject<string>;
  totalRecords$!: Observable<number>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  getUsersList: any[] = [];
  selectedJurisdictionPerson: any;
  selectedJurisdictionApplication: any;
  user: any;
  countyFilter: any;
  applicationNumber: any;
  applications: any[] = [];
  jurisdictionApplications: any[] = [];
  filteredJurisdictionApplications: any[] = [];
  statusDropdownItems: any[] = [];
  countyList$!: Observable<DropdownModel[]>;
  commentInfo: any;
  d: any;

  constructor(private _alertService: AlertService,
    private _dataStoreService: DataStoreService,
    private _commonService: CommonHttpService,
    private _authService: AuthService,
    private _router: Router,
    private _dashboardService: HomeDashboardService) { }

  ngOnInit() {
    this.user = this._authService.getCurrentUser();
    this.eventSubject$.subscribe((data) => {
      if (data === 'refresh') {
        this.getApplications(1);
      }
    });
    this.getApplications(1);
    this.loadStatusDropdown();
    this.loadCountyDropdown();
    this.listenForReopen();
  }

  listenForReopen() {
    this._dashboardService.assignSupervisorListener$.subscribe(data => {
      if (data.event === 'ASSIGNMENT') {
        this.selectedJurisdictionPerson = data.selectedUser;
        this.assignToSupervisor();
      }
    });
  }

  loadStatusDropdown() {
    this.statusDropdownItems = [
      { text: 'Pending', value: '{Pending,Incomplete}'},
      { text: 'Accepted', value: '{Accepted}' },
      { text: 'Submitted', value: '{For Assignment,For Acceptance,For Approval}' },
      { text: 'Approved', value: '{Approved,Provisionally Approved}' },
      { text: 'Closed', value: '{Closed}' },
      { text: 'Rejected', value: '{Rejected}' }
    ];
  }

  loadCountyDropdown() {
    const source = forkJoin([
      this._commonService.create(
        {
          where: {
            activeflag: '1',
            state: 'MD'
          },
          order: 'countyname asc',
          nolimit: true
        },
        'admin/county/countylist'
      )
    ]).pipe(map(res => {
      return {
        countyList: res[0].map(
          (item: { countyname: any; countyid: any; }) =>
            new DropdownModel({
              text: item.countyname,
              value: item.countyid
            })
        )
      };
    }));
    this.countyList$ = source.pipe(pluck('countyList'));
  }
 
  getApplications(pageNo: number) {
    const county = this.countyFilter ? this.countyFilter : null;
    const countyOptions = {
        requesttype: 'jurisdiction',
        jurisdiction: county,
        application_status: '{Rejected,Closed}'
      };


    this._commonService.endpointUrl = 'publicproviderapplicant/getassignedlist'
    const body = new PaginationRequest({
      where: countyOptions,
      page: pageNo,
      nolimit: true,
      method: 'post',
      count: -1
    });
    this._commonService.getPagedArrayList(body).subscribe(result => {
      this.applications = result.data;
      this.filterApplications();
    });
  }
  
  filterApplications() {
    if (this.applicationNumber) {
      this.filteredJurisdictionApplications = this.applications.filter(item => item.applicant_id.indexOf(this.applicationNumber) >= 1);
    } else {
      this.filteredJurisdictionApplications = this.applications;
    }
  }

  pageChanged(pageNo: number) {
    this.getApplications(pageNo);
  }



  routToCaseWorker(item: DSDSActionDetails) {
    this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
      const dsdsActionsSummary = response[0];
      if (dsdsActionsSummary) {
        this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
        this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
        const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/report-summary';
        this._router.navigate([currentUrl]);
      }
    });
  }

  listMyApps() {
    this.getApplications(1);
  }
  selectSupervisor(row: any) {
    this.selectedJurisdictionPerson = row;
  }


  sendApplicationInfo() {
    this._commonService.endpointUrl = 'publicproviderapplicant';
    this._commonService
    .patch(this.selectedJurisdictionApplication.applicant_id, {
      application_status: 'Pending',
      application_decision: 'Pending',
      applicant_id: this.selectedJurisdictionApplication.applicant_id,
    })
    .subscribe();
  }

  getReopen(application: any) {
    this.selectedJurisdictionApplication = application;
    if (this.user.role.name !== 'LDSS_SUPERVISOR') {
      this.getRoutingUser();
    } else {
      this._commonService.getArrayList(
        {
          method: 'post',
          count: -1,
          where: {
            tosecurityuserid: this._authService.getCurrentUser().user.securityusersid,
            applicantid: this.selectedJurisdictionApplication.applicant_id ? this.selectedJurisdictionApplication.applicant_id : null,
          }
        },
        'publicproviderapplicant/reopenpublicapplication'
      ).subscribe(res => {
        if (res) {
          this._alertService.success('Re-Assignment successful!');
          this.getApplications(1);
        }
      });
    }
  }

  getRoutingUser() {
    (<any>$('#reopen-application')).modal('show');
    this.getUsersList = [];
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'PRASS' },
          method: 'post',
          count: -1
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe(result => {
        this.getUsersList = result.data;
        const data: any = {};
        data['event'] = 'LIST_USERS';
        data['users'] = result.data.filter(
          users => users.userid !== this._authService.getCurrentUser().user.securityusersid
        );
        this._dashboardService.assignSupervisorListener$.next(data); 
      });
  } 

  resetFilter() {
    this.applicationNumber = null;
    this.filterApplications();
  }

  assignToSupervisor() {
    this._commonService.getArrayList(
      {
        method: 'post',
        count: -1,
        where: {
          tosecurityuserid: this.selectedJurisdictionPerson.userid,
          applicantid: this.selectedJurisdictionApplication.applicant_id ?  this.selectedJurisdictionApplication.applicant_id : null,
        }
      },
      'publicproviderapplicant/reopenpublicapplication'
    ).subscribe(res => {
      this._alertService.success('Assignment successful!');
      (<any>$('#reopen-application')).modal('hide');
      this.getApplications(1);
    });
  }

  showComment(item: any) {
    this.commentInfo = item.routeddescription ? item.routeddescription : 'No comments found!';
    this._dashboardService.assignCommentListener$.next(this.commentInfo);
  }
   
}


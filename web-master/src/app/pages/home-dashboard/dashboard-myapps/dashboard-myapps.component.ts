import { Component, OnInit, Input, Injector } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { Observable, Subject } from 'rxjs';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { DataStoreService, CommonHttpService, AuthService } from '../../../@core/services';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { AlertService } from '../../../@core/services/alert.service';
import { HomeDashboardService } from '../home-dashboard.service';
import { MatRadioModule } from '@angular/material/radio';
import { FormsModule } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';
import { RoleGuard } from '../../../@core/guard';


@Component({
    selector: 'dashboard-myapps',
    templateUrl: './dashboard-myapps.component.html',
    styleUrls: ['./dashboard-myapps.component.scss'],
    imports:[MatSortModule,RouterLink,MatRadioModule,FormsModule,MatFormFieldModule,MatInputModule,CommonModule],
    standalone: true
})
export class DashboardMyappsComponent implements OnInit {

  myApplicationList$!: Observable<any>;
  @Input()
  eventSubject$!: Subject<string>;
  totalRecords$!: Observable<number>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  getUsersList: any[] = [];
  selectedPerson: any;
  selectedApplication: any;
  user: any;
  filterType: any;
  applicationNumber: any;
  applications: any[] = [];
  filteredApplications: any[] = [];
  statusDropdownItems: any[] = [];
  canproviderapproval!: boolean;
  
  private _roleGuard: RoleGuard;
  private _alertService: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonService: CommonHttpService;
  private _authService: AuthService;
  private _router: Router;
  private _dashboardService: HomeDashboardService;

  constructor(private injector : Injector) {
      this._roleGuard = this.injector.get<RoleGuard>(RoleGuard);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._router = this.injector.get<Router>(Router);
      this._dashboardService = this.injector.get<HomeDashboardService>(HomeDashboardService);
    }

  ngOnInit() {
    this.user = this._authService.getCurrentUser();
    const resourcePermission = this._roleGuard.getPermissionsList();
    this.canproviderapproval = (resourcePermission.filter((data: { name: string; }) => data.name === 'manage_provider_approval').length > 0);
    this.eventSubject$.subscribe((data) => {
      if (data === 'refresh') {
        this.getApplications(1);
      }
    });
    this.getApplications(1);
    this.loadStatusDropdown();
    this.listenForAssignment();
  }

  loadStatusDropdown() {
    this.statusDropdownItems = [
      { text: 'Pending', value: '{Pending,Rejected,Incomplete}'},
      { text: 'Accepted', value: '{Accepted}' },
      { text: 'Submitted', value: '{For Assignment,For Acceptance,For Approval}' },
      { text: 'Approved', value: '{Approved,Provisionally Approved}' }
    ];
  }

  listenForAssignment() {
    this._dashboardService.assignUserListener$.subscribe(data => {
      if (data.event === 'ASSIGNMENT') {
        this.selectedPerson = data.selectedUser;
        this.assignNewUser();
      }
    });
  }


  getApplications(pageNo: number) {
    const filterType = this.filterType ? this.filterType.value : null;
    let filterOptions;
    if (filterType) {
      filterOptions = {
        requesttype: 'dashboard',
        activeflag: 1,
        application_status: filterType 
      };
    } else {
      filterOptions = {
        requesttype: 'dashboard',
        activeflag: 1
      };
    }

    this._commonService.endpointUrl = 'publicproviderapplicant/getassignedlist'
    const body = new PaginationRequest({
      where: filterOptions,
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
      this.filteredApplications = this.applications.filter(item => item.applicant_id.indexOf(this.applicationNumber) >= 1);
    } else {
      this.filteredApplications = this.applications;
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

  selectPerson(row: any) {
    this.selectedPerson = row;
  }
  assignNewUser() {
    if (this.selectedPerson && this.selectedApplication) {
      const eventcode = this.selectedPerson.rolecode === 'LDSSHSW' ? 'PHSWS' : 'PRWS';
      var payload = {
        eventcode: eventcode,
        tosecurityusersid: this.selectedPerson.userid,
        objectid: this.selectedApplication.applicant_id,
        typeofobj: this.selectedApplication.inapplicationphase ? 'Application' : 'Pre-App'
      }
      this._commonService.create(
        payload,
        'publicproviderapplicant/publicproviderapplicantrouting'
      ).subscribe(
        (response) => {
          this._alertService.success('Assignment successful!');
          (<any>$('#application-assign')).modal('hide');
          this.sendApplicationInfo();
        },
        (error) => {
          this._alertService.error('Unable to save ownership');
        });
    }

  }

  sendApplicationInfo() {
    this._commonService.endpointUrl = 'publicproviderapplicant';
    this._commonService
    .patch(this.selectedApplication.applicant_id, {
      application_status: 'Pending',
      application_decision: 'Pending',
      applicant_id: this.selectedApplication.applicant_id,
    })
    .subscribe((data) => { 
      this.selectedApplication = null;
      this.getApplications(1);
    });
  }

  getRoutingUser(application: any) {
    this.selectedApplication = application;
    (<any>$('#application-assign')).modal('show');
    this.getUsersList = [];
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'PRRWHW' },
          method: 'post'
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
        this._dashboardService.assignUserListener$.next(data); 
      });
  } 

  resetFilter() {
    this.applicationNumber = null;
    this.filterApplications();
  }

}

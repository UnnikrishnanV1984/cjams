
import {of as observableOf,  Subject ,  Observable } from 'rxjs';
import { Component, OnInit, Input, Injector } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { PaginationInfo } from '../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, AlertService, SessionStorageService, AuthService } from '../../@core/services';
import { Router } from '@angular/router';
import { DSDSActionDetails } from '../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../@core/entities/constants';
import { AppConstants } from '../../@core/common/constants';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../case-worker/_entities/caseworker.data.constants';
import { IntakeStore } from '../_utils/intake-utils.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'default-dashboard',
    templateUrl: './default-dashboard.component.html',
    styleUrls: ['./default-dashboard.component.scss'],
    standalone: false
})
export class DefaultDashboardComponent implements OnInit {

    servicerequestnumber: any = '';
    caseTypeInp: any = '';
    searchResult: any = [];
    caseWorker: any;
    caseType: any;
    myirForm!: FormGroup;
    @Input() paginationInfo: PaginationInfo;
    caseList$!: Observable<any[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    pageStream$ = new Subject<number>();
    caseworkerList: any[] = [];
    disableFind!: boolean;
    isAudtLogVisible = false;

      private _formBuilder: FormBuilder;
      private _commonService: CommonHttpService;
      private _dataStoreService: DataStoreService;
      private _router: Router;
      private _alertService: AlertService;
      private _session: SessionStorageService;
      private _authService: AuthService;
      
      constructor( private injector : Injector ) {
          this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
          this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
          this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
          this._router = this.injector.get<Router>(Router);
          this._alertService = this.injector.get<AlertService>(AlertService);
          this._session = this.injector.get<SessionStorageService>(SessionStorageService);
          this._authService = this.injector.get<AuthService>(AuthService);

         this.paginationInfo = new PaginationInfo(); 
        }
    caseworkerpageurl = '/pages/case-worker/';
    ngOnInit() {
      this.isAudtLogVisible = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
      this.getTaggedCase(1);
      this.myirForm = this._formBuilder.group({
        filterIR: ['All']
      });
      this.pageStream$.subscribe(data => {
        this.paginationInfo.pageNumber = data;
      });
    }

    pageChanged(pageInfo: any) {
      this.paginationInfo.pageNumber = pageInfo;
      this.paginationInfo.pageSize = 10;
      this.getTaggedCase(pageInfo);
    }


    getTaggedCase(page:any) {
      this.disableFind = true;

      this._commonService
        .getSingle(
          {

            limit: 10,
            page: page,
            count: -1,
            method: 'get'
          },
          'userreference/listuserreference?filter'
        ).subscribe(data => {
          if (data && data.data && data.count) {
            this.totalRecords$ = (page === 1) ? observableOf(data.count) : this.totalRecords$;
          }
          if (data && data.data) {
            this.searchResult = data.data;
            this.disableFind = false;
            this.caseList$ = observableOf(this.searchResult);
          }
        });
    }

    routeToCase(item:DSDSActionDetails) {
        this.clearSession();
        if (item.objecttypekey === 'Service') {
          this.routToServiceCase(item);
        } else if (item.objecttypekey === 'Adoption') {
          this.routToAdoptionCase(item);
        } else if (item.objecttypekey === 'Referral') {
          this.routToIntake(item);
        } else if (item.objecttypekey === 'CPS AR') {
          this.routToCpsCase(item);
        } else if (item.objecttypekey === 'CPS IR') {
          this.routToCpsCase(item);
        }
      }

      routToServiceCase(item: DSDSActionDetails) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
          this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttypekey);
        }
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.objectid + '/casetype';
        this._commonService.getAll(url).subscribe((response) => {
          const dsdsActionsSummary = response[0];
          if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = this.caseworkerpageurl + item.objectid + '/' + item.casenumber + '/dsds-action/person-cw';
            this._router.navigate([currentUrl]);
          }
        });
      }

      routToCpsCase(item: DSDSActionDetails) {
        this._commonService
          .getSingle(
            {
              intakeserviceid: item.objectid,
              isaccepted: true,
              isrejected: false,
              rejectreason: 'Accepted',
              method: 'post'
            },
            'Areateammemberservicerequests/updateassignedstatus'
          )
          .subscribe(
            (result:any) => {
              this._commonService.getById(item.casenumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
                const dsdsActionsSummary = response[0];
                if (dsdsActionsSummary) {
                  this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                  this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                  const currentUrl = this.caseworkerpageurl + item.objectid + '/' + item.casenumber + '/dsds-action/report-summary';
                  this._router.navigate([currentUrl]);
                }
              });
            },
            (error) => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
          );
      }

      routToAdoptionCase(item: DSDSActionDetails) {
        this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
        this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
        this._session.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.startdate);
        this._session.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        if (item) {
          this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        }
        this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response2) => {
          const dsdsActionsSummary = response2[0];
          if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            // TO DO : DEB As discussed with management we are parking this link but we are working on separate branch after extensive testing this will
            // be available for user
            const currentUrl = this.caseworkerpageurl + item.objectid + '/' + item.casenumber + '/dsds-action/person-cw';
            this._router.navigate([currentUrl]);
          }
        });
      }

      routToIntake(item: any) {
        this._dataStoreService.removeItem('intake');
        const intake = Object.create(IntakeStore);
        intake.number = item.casenumber;
        intake.action = 'edit';
        this._dataStoreService.setObj('intake', intake);
        const url = '/pages/newintake/my-newintake/' + intake.number;
        this._dataStoreService.clearStore();
        this._dataStoreService.clearStoreWithout();
        this._router.navigate([url], { skipLocationChange: true });
      }

      clearSession() {
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._dataStoreService.removeItem('intake');
        this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        this._session.removeItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
        this._session.removeItem(CASE_STORE_CONSTANTS.Adoption_START_DATE);
      }

      deleteTag(data:any) {
        this._commonService.endpointUrl = 'userreference';
        this._commonService.remove(data.userreferenceid).subscribe(
            (result) => {
                this._alertService.success('Untagged successfully');
                this.getTaggedCase(1);
            },
            (err) => {
                console.error(err);
            }
        );
    }


}

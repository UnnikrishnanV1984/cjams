
import { of as observableOf, Observable, Subject } from 'rxjs';
import { Component, OnInit, Input, Injector } from '@angular/core';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { IntakeStore } from '../../_utils/intake-utils.service';
import { FormGroup, FormBuilder, Validators, ValidatorFn, ValidationErrors } from '@angular/forms';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { CaseSearchService } from '../case-search.service';
import { CommonHttpService, DataStoreService, AlertService, SessionStorageService, AuthService } from '../../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { AppConstants } from '../../../@core/common/constants';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { environment } from '../../../../../src/environments/environment';
import { config } from '../../../../../src/environments/config';

@Component({
    selector: 'case-search-list',
    templateUrl: './case-search-list.component.html',
    styleUrls: ['./case-search-list.component.scss'],
    standalone: false
})
export class CaseSearchListComponent implements OnInit {

  servicerequestnumber: any = '';
  caseTypeInp: any = '';
  searchResult: any = [];
  caseWorker: any;
  caseType: any;
  isLoading: boolean = false;
  myirForm!: FormGroup;
  caseSearchForm!: FormGroup;
  @Input() paginationInfo: PaginationInfo;
  caseList$: Observable<any[]> = new Observable<any[]>();
  totalRecords$: Observable<number> = new Observable<number>();
  canDisplayPager$: Observable<boolean> = new Observable<boolean>();
  pageStream$ = new Subject<number>();
  caseworkerList: any[] = [];
  disableFind: boolean = false;
  isAudtLogVisible = false;
  servicereqsearchurl = 'servicerequestsearches/usersservicerequestwithrestricteduser?data';
  caseworkerurl = '#/pages/case-worker/';
  restrictedcaseenable: boolean = false;
  isExpungementSuperUser: number = 0;


  private _caseSearchService: CaseSearchService;
  private _formBuilder: FormBuilder;
  private _commonService: CommonHttpService;
  private _dataStoreService: DataStoreService;
  private _router: Router;
  private route: ActivatedRoute;
  private _alertService: AlertService;
  private _session: SessionStorageService;
  private _authService: AuthService;

  constructor(private injector: Injector) {
    this._caseSearchService = this.injector.get<CaseSearchService>(CaseSearchService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.paginationInfo = new PaginationInfo();
  }

  ngOnInit() {
    this.restrictedcaseenable = config.restrictedcaseenable && environment.envName !== 'Production';
    this.isAudtLogVisible = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR) || this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.caseType = 'Empty';
    this.getCaseWorkerList();
    this.myirForm = this._formBuilder.group({
      filterIR: ['All']
    });
    this.caseSearchForm = this._formBuilder.group({
      caseWorker: null,
      servicerequestnumber: null,
      caseTypeInp: null,
      isExpunged: false
    }, { validators: this.atLeastTwo(Validators.required) });
    this.pageStream$.subscribe(data => {
      this.paginationInfo.pageNumber = data;
    });
    this.caseTypeInp = '';
    this.caseWorker = null;
    this.loadFormCache();
    this.isExpungementSuperUser = this._authService.isExpungementSuperUser();
  }

  atLeastTwo = (validator: ValidatorFn) =>
    (group: FormGroup): ValidationErrors | null => {
      const controls = group.controls;
      const isCaseNumber = !validator(controls.servicerequestnumber);
      const validFields = Object.keys(controls).filter(
        (k) => !validator(controls[k])
      );

      if (isCaseNumber) {
        return null;
      }

      const isValid = validFields.length >= 2 && !validator(controls.caseTypeInp);

      return isValid ? null : { atLeastTwo: true };
    };

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo;
    this.paginationInfo.pageSize = 10;
    this.triggerCaseSearch(pageInfo);
  }

  resetSearchResult() {
    this.searchResult = null;
    this.caseType = null;
  }
  caseSearch(page: any) {
    const control = this.caseSearchForm.get('isExpunged');
    const isExpunged = control ? control.value : false;
    if(isExpunged) {
      this.triggerExpungedCaseSearch(page);
    } else {
      this.triggerCaseSearch(page)
    }
  }
  uncheckIsExpunged() {
    if(!this.servicerequestnumber && this.isExpungementSuperUser === 1) {
      this.caseSearchForm.controls.isExpunged.patchValue(false);
    }

    if(this.servicerequestnumber) {
      this.caseWorker = '';
      this.searchResult = null;
    }
  }

  onChangeWorker() {
    if(this.caseWorker) {
      this.servicerequestnumber = '';
      this.caseSearchForm.controls.isExpunged.patchValue(false);
      this.searchResult = null;
    }
  }

  triggerCaseSearch(page: any) {
    if (this.caseSearchForm.valid) {
      const reqData = {
        'actiontype': this.caseTypeInp,
        'servicerequestnumber': this.servicerequestnumber.trim(), 'workername': this.caseWorker
      };
      this._commonService
        .getSingle(
          {

            limit: 10,
            sortorder: this.paginationInfo.sortBy,
            sortcolumn: this.paginationInfo.sortColumn,
            page: page,
            count: -1,
            where: reqData,
            method: 'get'
          },
          'servicerequestsearches/myCaseSearch?data'
        ).subscribe(data => {
            if (data && data.count) {
              this.totalRecords$ = (page === 1) ? observableOf(data.count) : this.totalRecords$;
            }
            if (data && data.data) {
              this.searchResult = data.data;
              this.disableFind = false;
              this.caseList$ = observableOf(this.searchResult);
            }
          });
    }
  }

  triggerExpungedCaseSearch(page: number) {
    if (this.caseSearchForm.valid) {
      const reqData = {
        'actiontype': this.caseTypeInp,
        'servicerequestnumber': this.servicerequestnumber.trim(), 'workername': this.caseWorker,
        isExpungementSuperUser: 1
      };
      this._commonService
        .getSingle(
          {

            limit: 10,
            sortorder: this.paginationInfo.sortBy,
            sortcolumn: this.paginationInfo.sortColumn,
            page: page,
            count: -1,
            where: reqData,
            method: 'get'
          },
          CaseWorkerUrlConfig.EndPoint.Dashboard.MyExpungedCaseSearch
        ).subscribe(data => {
          if (data && data.count) {
            this.totalRecords$ = (page === 1) ? observableOf(data.count) : this.totalRecords$;
          }
          if (data && data.data) {
            this.searchResult = data.data.map((item:any) => {
              item.isExpunged = true;
              return item;
            });
            this.disableFind = false;
            this.caseList$ = observableOf(this.searchResult);
          }
        });
    }
  }

  tagCase(caseInfo: any) {
    const request = {
      objectid: caseInfo.intakeserviceid,
      objecttypekey: caseInfo.srtype,
      casenumber: caseInfo.servicerequestnumber,
      legalguardian: caseInfo.legalguardian && caseInfo.legalguardian.length ? caseInfo.legalguardian[0].personname : null,
      worker: caseInfo.workername
    };

    this._commonService.create(request, 'userreference/addreference').subscribe((item) => {
      if (item) {
        this._alertService.success(item);
      }
    });
    this.triggerCaseSearch(1);

  }

  clear() {
    this.servicerequestnumber = '';    
    this.caseTypeInp = '';
    this.caseWorker = null;
    this.saveSearchRequest();
    this.searchResult = [];
    this.caseSearchForm.controls.isExpunged.patchValue(false);
    this.totalRecords$ = observableOf(0);
  }

  getCaseWorkerList() {
    this._commonService
      .getPagedArrayList(
        {
          where: { appevent: 'ALL' },
          method: 'post'
        },
        'Intakedastagings/getroutingusers'
      ).subscribe(result => {
        this.caseworkerList = result.data;
      });
  }

  onSearchCase() {
    const caseId = this.servicerequestnumber;
    if (!caseId) {
      return;
    }
    this.searchResult = [];
    this._caseSearchService.searchCase(caseId, 'AR', this.servicereqsearchurl).subscribe(ardata => {
      if (ardata?.count) {
        ardata?.data?.forEach((element: any) => {
          element.caseType = 'CPS-AR';
          this.searchResult.push(element);
        });
      }
    });
    this._caseSearchService.searchCase(caseId, 'servicecase', 'servicerequestsearches/getservicecase?data').subscribe(scdata => {
      if (scdata?.count) {
        scdata?.data?.forEach((element: any) => {
          element.caseType = 'Service Case';

          this.searchResult.push(element);
        });
      }
    });
    this._caseSearchService.searchCase(caseId, null, this.servicereqsearchurl).subscribe(cpsdata => {
      if (cpsdata?.count) {
        cpsdata?.data?.forEach((element: any) => {
          element.caseType = 'NON CPS';
          this.searchResult.push(element);
        });

      }
    });
    this._caseSearchService.searchCase(caseId, 'IR', this.servicereqsearchurl).subscribe(irdata => {
      if (irdata?.count) {
        irdata?.data.forEach((element: any) => {
          element.caseType = 'CPS-IR';

          this.searchResult.push(element);
        });
      }
    });


    this._caseSearchService.searchCase(caseId, 'servicecase', 'servicerequestsearches/getadoptioncase?data').subscribe(adoptiondata => {
      if (adoptiondata && adoptiondata.count) {
        adoptiondata.data.forEach((element: any) => {
          element.caseType = 'Adoption';

          this.searchResult.push(element);
        });
      }
    });
  }

  routeToCase(item: any) {
    this._session.setItem('cpsSkipApproval', 'false');
    if ((item.restrictedstatus === 'EXCLUDE') || (item.restrictedstatus === 'INCLRES' && this.restrictedcaseenable)) {
      (<any>$('#exclude')).modal('show');
    }
    else if (item.srtype === 'Service') {
      this.routToServiceCase(item);
    } else if (item.srtype === 'Adoption') {
      this.routToAdoptionCase(item);
    } else if (item.srtype === 'Referral') {
      this._dataStoreService.setObj('intake', item);
      this.routToIntake(item);
    } else if (item.srtype === 'CPS AR') {
      this.routToCpsCase(item);
    } else if (item.srtype === 'CPS IR') {
      this.routToCpsCase(item);
    }
  }

  routToServiceCase(item: DSDSActionDetails) {
    this._session.removeItemWithOutTab('ISADOPTION');
    this._session.setTabKeyKey(item.servicerequestnumber);
    this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
    if (item) {
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttypekey);
    }
    const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.intakeserviceid + '/casetype';
    this._commonService.getAll(url).subscribe((response) => {
      this.handleToRouteToDesiredPageFn(response, item);
    });
  }

  routToCpsCase(item: DSDSActionDetails) {
    this._session.removeItemWithOutTab('ISADOPTION');
    this._session.setTabKeyKey(item.servicerequestnumber);
    this._commonService
      .getSingle(
        {
          intakeserviceid: item.intakeserviceid,
          isaccepted: true,
          isrejected: false,
          rejectreason: 'Accepted',
          method: 'post'
        },
        'Areateammemberservicerequests/updateassignedstatus'
      )
      .subscribe(
        (result) => {
          this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((resp) => {
            this.handleToRouteToDesiredPageFn(resp, item);
          });
        },
        (error) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }

  private handleToRouteToDesiredPageFn(response: any, item: DSDSActionDetails) {
    const dsdsActionsSummary = response[0];
    if (dsdsActionsSummary) {
      this.setDsdsActionsSummary(dsdsActionsSummary, item);
    }
  }

  setDsdsActionsSummary(dsdsActionsSummary: any, item: DSDSActionDetails) {
    this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
    this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
    const currentUrl = this.caseworkerurl + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/report-summary';
    window.open(currentUrl);
  }

  routToAdoptionCase(item: DSDSActionDetails) {
    this._session.setTabKeyKey(item.servicerequestnumber);
    this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
    this._session.setItem('ISADOPTION', true);
    this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
    this._session.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.startdate);
    this._session.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
    if (item) {
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
    }
    this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
      const dsdsActionsSummary = response[0];
      if (dsdsActionsSummary) {
        this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
        this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
        const currentUrl = this.caseworkerurl + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/adoption-persons';
        window.open(currentUrl);
      }
    });
  }

  routToIntake(item: any) {
    this._dataStoreService.removeItem('intake');
    const intake = Object.create(IntakeStore);
    intake.number = item.servicerequestnumber;
    intake.action = 'edit';
    this._dataStoreService.setObj('intake', intake);
    this._session.setObj('intake', intake);
    this._dataStoreService.clearStore();
    this._dataStoreService.clearStoreWithout();
    window.open('#/pages/newintake/my-newintake/' + intake.number + '/' + intake.action);
  }

  clearSession() {
    this._dataStoreService.removeItem(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO);
    this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this._dataStoreService.removeItem('intake');
    this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
    this._session.removeItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    this._session.removeItem(CASE_STORE_CONSTANTS.Adoption_START_DATE);
  }

  openAuditLog(item: any) {
    const caseId = item.intakeserviceid;
    const caseNumber = item.servicerequestnumber;
    this._session.setObj('caseSearchItem', item);
    this.saveSearchRequest();
    this._router.navigate(['../case-log/' + caseId + '/' + caseNumber], { relativeTo: this.route });
  }

  saveSearchRequest() {
    const caseSearchRequest = {
      servicerequestnumber: this.servicerequestnumber,
      caseWorker: this.caseWorker,
      caseTypeInp: this.caseTypeInp
    };
    this._session.setObj('caseSearchRequest', caseSearchRequest);
  }

  loadFormCache() {
    const caseSearchRequest = this._session.getObj('caseSearchRequest');
    if (caseSearchRequest) {
      this.servicerequestnumber = caseSearchRequest.servicerequestnumber;
      this.caseWorker = caseSearchRequest.caseWorker;
      this.caseTypeInp = caseSearchRequest.caseTypeInp;
      this.triggerCaseSearch(1);
    }
  }

  onSorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.triggerCaseSearch(1);
  }

}

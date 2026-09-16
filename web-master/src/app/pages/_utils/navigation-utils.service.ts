import { Injectable } from '@angular/core';
import { AppConstants } from '../../@core/common/constants';
import { SessionStorageService, CommonHttpService, DataStoreService, AuthService } from '../../@core/services';
import { Router } from '@angular/router';
import { IntakeUtils, IntakeStore } from './intake-utils.service';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../case-worker/_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import { HomeDashboardUrlConfig } from '../home-dashboard/home-dashbaord.url.config';
import { PaginationRequest } from '../../@core/entities/common.entities';
import { Subject } from 'rxjs';

export class PersonInfoStore {
  personId!: string;
  sourceID!: string;
  clientId!: number;
  placementId!: number;
  removalId!: number;
  fromIVtab: boolean = false;
  source!: string;
  action!: string;
  data: any;
  searchData: any;
}

@Injectable()
export class NavigationUtils {
  public dsdsActionTabSwitch$ = new Subject<any>();
  constructor(private _sessionStorage: SessionStorageService,
    private _router: Router,
    private _intakeUtils: IntakeUtils,
    private _commonService: CommonHttpService,
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService) { }

    householdmemberurl = '/household-members/list';
    caseworkerurl = '#/pages/case-worker/';

  public openEditPersonInfo(personId: string, caseType: string, uniqueNumber: string, data: any) {
    const personInfo = Object.create(PersonInfoStore);
    personInfo.source = caseType;
    personInfo.sourceID = uniqueNumber;
    personInfo.personId = personId;
    personInfo.action = AppConstants.ACTIONS.EDIT;
    personInfo.data = data;
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
    localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
    this.navigateToPersonInfo();
  }

  public openViewPersonInfo(personId: string, caseType: string, uniqueNumber: string, data: any) {
    const personInfo = Object.create(PersonInfoStore);
    personInfo.source = caseType;
    personInfo.sourceID = uniqueNumber;
    personInfo.personId = personId;
    personInfo.action = AppConstants.ACTIONS.VIEW;
    personInfo.data = data;
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
    localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
    this.navigateToPersonInfo();
  }

  public openViewPersonHealthSummaryInfo(personId: string, caseType: string, uniqueNumber: string, data: any, extras?: any) {
    const personInfo = Object.create(PersonInfoStore);
    personInfo.source = caseType;
    personInfo.sourceID = uniqueNumber;
    personInfo.personId = personId;
    personInfo.action = AppConstants.ACTIONS.VIEW;
    personInfo.data = data;
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
    localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
    this.navigateToHealthSummary(extras);
  }

  public openNewPersonInfo(caseType: string, uniqueNumber: string, data: any, searchdata = {}) {
    const personInfo = Object.create(PersonInfoStore);
    personInfo.source = caseType;
    personInfo.sourceID = uniqueNumber;
    personInfo.personId = null;
    personInfo.action = AppConstants.ACTIONS.ADD;
    personInfo.data = data;
    personInfo.searchData = searchdata;
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
    this.navigateToPersonInfo();
  }

  public openEditFinance(personId: string,clientId: number,placementId: any,removalId: any, fromIVtab: boolean, caseType: string, uniqueNumber: string, data: any) { // NOSONAR
    const personInfo = Object.create(PersonInfoStore);
    personInfo.source = caseType;
    personInfo.sourceID = uniqueNumber;
    personInfo.clientId = clientId;
    personInfo.placementId = placementId;
    personInfo.removalId = removalId;
    personInfo.fromIVtab = fromIVtab;
    personInfo.personId = personId;
    personInfo.action = AppConstants.ACTIONS.EDIT;
    personInfo.data = data;
    this._dataStoreService.setData('beaconrequestdetailsid', data.beaconrequestdetailsid);
    this._dataStoreService.setData('ssn', data.ssn);
    this._dataStoreService.setData('personId', personId);
    this._dataStoreService.setData('sourcetrackingid', data.sourcetrackingid);
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
    this.navigateToFinance();
  }


  private navigateToPersonInfo() {
    this._router.navigate(['/pages/person-info-cw']);
  }

  private navigateToFinance() {
    this._router.navigate(['/pages/person-info-cw/finance']);
  }

  private navigateToHealthSummary(extras?: any) {
    if (extras?.path) {
      this._router.navigate(['/pages/person-info-cw/health/immunization'], { queryParams: { updatedon: extras.updatedon } });
    } else {
      this._router.navigate(['/pages/person-info-cw/health/person-health-summary']);
    }
  }

  navigateToHealthMedicationPsychotropic() {
    this._router.navigate(['pages/person-info-cw/health/medication-psychotropic']);
  }

  clearNavigationInfo() {
    this._dataStoreService.removeItem(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO);
    localStorage.removeItem('navigationInfo');
  }

  getNavigationInfo(): any {
    const info = this._dataStoreService.getObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO);
    if(info){
      return info;
    }
    else {
      const value: string | null = localStorage.getItem('navigationInfo');
      return value ? JSON.parse(value) : null;
    }
  }

  setNavigationInfo(personInfo: PersonInfoStore): void {
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
    localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
  }

  loadPreviousState() {
    const navigationInfo = this.getNavigationInfo();
    if (navigationInfo) {
      switch (navigationInfo.source) {
        case AppConstants.CASE_TYPE.INTAKE:
          this.loadIntakePage(); // Already intake number has stored in session storage
          break;
        case AppConstants.CASE_TYPE.CPS_CASE:
          this.loadCasePage(navigationInfo.sourceID, navigationInfo.data.caseNumber);
          break;
        case AppConstants.CASE_TYPE.SERVICE_CASE:
          if (navigationInfo.fromIVtab === true){
            this.loadTitleIVE(navigationInfo.clientId, navigationInfo.removalId, navigationInfo.placementId);
          }
           else{
            this._sessionStorage.setItem('ISSERVICECASE', true);
            this.loadCasePage(navigationInfo.sourceID, navigationInfo.data.caseNumber);
           }
          break;
        case AppConstants.CASE_TYPE.ADOPTION_CASE:
          this.loadAdoptionCasePage(navigationInfo.sourceID, navigationInfo.data.caseNumber);
          break;
        case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION:
          this.loadPublicProviderApplicantPage(navigationInfo.sourceID);
          break;
        case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER:
          this.loadPublicProviderPage(navigationInfo.sourceID);
          break;
        case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL:
          this.loadPublicProviderReferralPage(navigationInfo.sourceID);
          break;
        case AppConstants.DA_TYPE_TEXT.SERVICE_CASE: /* To redirect Childremoval page */
          this.loadChilRemovPage(navigationInfo.sourceID, navigationInfo.data.caseNumber);
          break;
      }
    } else {
      // To do should go to dashboard based upon respective role
    }
  }

  getPersonRequestParam() {
    const navigationInfo = this.getNavigationInfo();
    const requestParam: any = {
      personid: null,
      intakeserviceid: null,
      intakenumber: null,
      objecttypekey: null,
      objectid: null,// managing service case also,
      servicecaseid: null
    };

    if (navigationInfo) {
      requestParam.personid = navigationInfo.personId;
      switch (navigationInfo.source) {
        case AppConstants.CASE_TYPE.INTAKE:
          requestParam.intakenumber = navigationInfo.sourceID;
          break;
        case AppConstants.CASE_TYPE.CPS_CASE:
          requestParam.intakeserviceid = navigationInfo.sourceID;
          break;
        case AppConstants.CASE_TYPE.SERVICE_CASE:
          requestParam.servicecaseid = navigationInfo.sourceID;
          break;
        case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER:
        case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION:
        case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL:
          requestParam.intakenumber = navigationInfo.sourceID;
          break;
        case AppConstants.DA_TYPE_TEXT.SERVICE_CASE: /* Setting intakeserviceid to load person info */
          requestParam.intakeserviceid = navigationInfo.sourceID
          requestParam.servicecaseid = navigationInfo.sourceID
          break;
      }
    }

    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let iscaseexpunged = this._dataStoreService.getData('iscaseexpunged')
    requestParam['isExpungementSuperUser'] = isExpungementSuperUser;
    requestParam['iscaseexpunged'] = iscaseexpunged;
    
    return requestParam;
  }

  getPersonRequest() {
    const navigationInfo = this.getNavigationInfo();
    let requestParam: any;
    if (navigationInfo) {
      switch (navigationInfo.source) {
        case AppConstants.CASE_TYPE.INTAKE:
          requestParam = {
            intakenumber: navigationInfo.sourceID
          };
          break;
        case AppConstants.CASE_TYPE.CPS_CASE:
          requestParam.intakeserviceid = navigationInfo.sourceID;
          break;
        case AppConstants.CASE_TYPE.SERVICE_CASE:
          requestParam.servicecaseid = navigationInfo.sourceID;
          break;
      }
    }
    return requestParam;
  }

  private loadIntakePage() {
    const intake = this._dataStoreService.getObj('intake');
    const url = '/pages/newintake/my-newintake/' + intake.number + '/' + intake.action + '/person-cw/list';
    this._router.navigate([url]);
  }

  private loadTitleIVE(clientId: number, removalId: number, placementId: number) {
    const url = 'pages/title4e/foster-car/' + clientId + '/' + removalId;
    this._router.navigate([url]);
  }

  private loadCasePage(caseId: string, caseNumber: string) {
    const currentUrl = '/pages/case-worker/' + caseId + '/' + caseNumber + '/dsds-action/person-cw';
    this._router.navigate([currentUrl]);
  }

  private loadChilRemovPage(caseId: string, caseNumber: string) {
    const currentUrl = '/pages/case-worker/' + caseId + '/' + caseNumber + '/dsds-action/child-removal/details';
    this._router.navigate([currentUrl]);
  }
  private loadAdoptionCasePage(caseId: string, caseNumber: string) {
    const currentUrl = '/pages/case-worker/' + caseId + '/' + caseNumber + '/dsds-action/adoption-persons';
    this._router.navigate([currentUrl]);
  }

  private loadPublicProviderPage(providerID: string) {
    const currentUrl = '/pages/provider-management/new-public-provider/' + providerID + this.householdmemberurl;
    this._router.navigate([currentUrl]);
  }

  private loadPublicProviderApplicantPage(applicantNumber: string) {
    const currentUrl = '/pages/provider-applicant/new-public-applicant/' + applicantNumber + this.householdmemberurl;
    this._router.navigate([currentUrl]);
  }

  private loadPublicProviderReferralPage(applicantNumber: string) {
    const currentUrl = '/pages/provider-referral/new-public-referral/' + applicantNumber + this.householdmemberurl;
    this._router.navigate([currentUrl]);
  }

  openRespectiveItem(item: any) {
    this._sessionStorage.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this._sessionStorage.setTabKeyKey(item.danumber);
    switch (item.datype) {
      case 'Service Case':
        case 'ROA-CPS': // CDM-10288 - ROA-CPS case is opening blank intake on clicking so commented out line 268
      case 'Request for services':
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.SERVICE_CASE);
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.intakeserviceid + '/casetype';
        this._commonHttpService.getAll(url).subscribe((response) => {
          this.handleOpenUrlFn(response, item);
        });
        break;
      case 'Information and Referral': {
        this._dataStoreService.removeItem('intake');
        const intake = Object.create(IntakeStore);
        intake.number = item.danumber;
        intake.action = 'edit';
        this._dataStoreService.setObj('intake', intake);
        this._dataStoreService.clearStore();
        this._dataStoreService.clearStoreWithout();
        window.open('#/pages/newintake/my-newintake/' + intake.number + '/' + intake.action + '/narrative');
        break;
      }
      // case 'ROA-CPS':
      case 'Intake': {
        let intk = this._dataStoreService.getObj('intake');
        this._dataStoreService.removeItem('intake');
        const intake = Object.create(IntakeStore);
        intake.number = item.danumber;
        intake.action = 'edit';
        this._dataStoreService.setObj('intake', intake);
        window.open('#/pages/newintake/my-newintake/' + intake.number + '/' + intake.action + '/narrative');
        this._dataStoreService.removeItem('intake');
        this._dataStoreService.setObj('intake', intk);
        break;
      }
      case 'Child Protective Services':
        this._sessionStorage.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._commonHttpService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((resp) => {
          this.handleOpenUrlFn(resp, item);
        });
        break;
        case 'Adoption Case':
          this.getAdoptionDataAndLoadCase(item.danumber);
          break;
    }
  }

  private handleOpenUrlFn(response: any, item: any) {
    const dsdsActionsSummary = response[0];
    if (dsdsActionsSummary) {
      this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
      this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
      const currentUrl = this.caseworkerurl + item.intakeserviceid + '/' + item.danumber + '/dsds-action/report-summary';
      window.open(currentUrl);
    }
  }

  getModuleType() {
    const navigationInfo = this.getNavigationInfo();
    let moduleType = '';
    if (navigationInfo) {
      switch (navigationInfo.source) {
        case AppConstants.CASE_TYPE.INTAKE:
          moduleType = 'Intake';
          break;
        case AppConstants.CASE_TYPE.CPS_CASE:
          moduleType = 'servicerequest';
          break;
        case AppConstants.CASE_TYPE.SERVICE_CASE:
          moduleType = 'servicecase';
          break;
      }

      return moduleType;
    }
  }
  routToServiceCase(item: any) {
      this._sessionStorage.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
      this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
    this._commonService.getById(item.casenumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
      const dsdsActionsSummary = response[0];
      if (dsdsActionsSummary) {
          this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
          this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
          localStorage.setItem('iveagency','IV-E');
          const currentUrl =  this.caseworkerurl + item.servicecaseid + '/' + item.casenumber + '/dsds-action/person-cw';
         window.open(currentUrl);
      }
  });
  }

  public loadFostcareIVE(clientId: number, removalId: number, placementId?: number | null) {
    const url = '#/pages/title4e/foster-car/' + clientId + '/' + removalId;
    window.open(url);
  }

  getAdoptionDataAndLoadCase(caseNumber: string) {
    this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myDsdsActions.adoptioncaselist}?data`;
        const inputRequest = { casenumber: caseNumber, actiontype: 'servicecase'  };
        const body = new PaginationRequest({
        page: 1,
        limit: 10,
        where: inputRequest,
        method: 'get',
        count: -1
    });
   this._commonService.getPagedArrayList(body).subscribe(data => {
            const adoptionItems = data.data;
            if (Array.isArray(adoptionItems) && adoptionItems.length > 0) {
              this.routToAdoptionCase(adoptionItems[0]);
            }
    });
}
routToAdoptionCase(item: any) {
    this._sessionStorage.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this._sessionStorage.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
    this._sessionStorage.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
    this._sessionStorage.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.startdate);
    this._sessionStorage.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
    if (item) {
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
    }
    this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
        const dsdsActionsSummary = response[0];
        if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);

            if (item.statustypekey === 'Closed') {
                const currentUrl = this.caseworkerurl + item.adoptioncaseid + '/' + item.adoptioncasenumber + '/dsds-action/disposition';
                window.open(currentUrl);
            } else {
                const currentUrl = this.caseworkerurl + item.adoptioncaseid + '/' + item.adoptioncasenumber + '/dsds-action/adoption-persons';
                window.open(currentUrl);
            }
        }
    });
}



}
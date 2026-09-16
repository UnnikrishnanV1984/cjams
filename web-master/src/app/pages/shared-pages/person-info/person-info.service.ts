import { Injectable } from '@angular/core';
import { NavigationUtils, PersonInfoStore } from '../../_utils/navigation-utils.service';
import { Observable ,  Subject } from 'rxjs';
import { AppConstants } from '../../../@core/common/constants';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, AuthService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import moment from 'moment';
import { ObjectUtils } from '../../../@core/common/initializer';
import { SessionStorageService } from '../../../@core/services/storage.service';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';

@Injectable({providedIn: 'root'})
export class PersonInfoService {

  personInfo: any;
  workInfo: any;
  assetInfo: any;
  incomeInfo: any;
  setPersonFlag: boolean = false;
  setpersonid: any;
  person: any;
  empActionText: string;
  aliasList :any= [];
  isClosed = false;
  public personInfoListener$ = new Subject<any>();
  public personActionListener$ = new Subject<any>();
  public personInfoWorkListener$ = new Subject<any>();
  public workInfoListener$ = new Subject<any>();
  public assetInfoListener$ = new Subject<any>();
  public incomeInfoListener$ = new Subject<any>();
  public personDobListener$ = new Subject<any>();
  servicecasetxt = 'Service Case';
  constructor(private _navigationUtils: NavigationUtils,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private storage: SessionStorageService,
    private _authService: AuthService) {
      this.setPersonFlag = false;
      this.empActionText = 'ADD';
  }
  getPersonDetails(getpersonlistreq?: any): Observable<any> {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let requestparams = getpersonlistreq ? getpersonlistreq : this._navigationUtils.getPersonRequestParam();
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    requestparams['isExpungementSuperUser'] = isExpungementSuperUser;
    requestparams['iscaseexpunged'] = iscaseexpunged;

    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: requestparams
        }),
        url + '?filter'
      );
  }

  getCareGiverPersonChildInfo(request: { serviceid: any; personid: any; }) {
    return this._commonHttpService
      .create(request, 'People/getCareGiverPersonChildInfo');
  }
  getcaregiverchildinfo(request: { serviceid: any; personid: any; }) {
    return this._commonHttpService
      .create(request, 'People/getcaregiverchildinfo');
  }


  manageSENHistory(data: any) {
    console.log('Managing SEN history data:', data);
    return this._commonHttpService.create(data, CommonUrlConfig.EndPoint.PERSON.ManageSenHistory);
  }

  getSENHistoryByPersonId(personId: string): Observable<any> {
    return this._commonHttpService.getArrayList(
      {
        where: { personId: personId },
        method: 'get'
      },
      CommonUrlConfig.EndPoint.PERSON.GetSenPersonById
    );
  }

  getInvolvedPersons() {
    const casedetails = this._navigationUtils.getPersonRequestParam();
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    let where;
    if (casedetails.servicecaseid !== undefined && casedetails.servicecaseid !== null) {
          where = {
            objecttypekey : 'servicecase',
            objectid : casedetails.servicecaseid
          };
        }
        else{
          where = casedetails;
        }
        where['isExpungementSuperUser'] = isExpungementSuperUser;
        where['iscaseexpunged'] = iscaseexpunged;

    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          'where': where
        }),
        url + '?filter'
      );
  }
  setPersonId(personId: any) {
    this.setpersonid = personId;
    this.setPersonFlag = true;
  }

  setPerson(child: any) {
    this.person = child;
  }

  getPerson() {
    return this.person;
  }

  resetPersonId() {
    this.setpersonid = null;
    this.setPersonFlag = false;
  }

  getPersonId() {
    if (this.setPersonFlag === true) {
      return this.setpersonid;
    }
    return this._navigationUtils.getPersonRequestParam().personid;
  }

  updatePersonId(personid: string) {
    const navigationInfo: any = this._navigationUtils.getNavigationInfo();
    navigationInfo.personId = personid;
    navigationInfo.action = AppConstants.ACTIONS.EDIT;
    if (this.getIntakeNumber()) {
      navigationInfo.sourceID = this.getIntakeNumber();
    }
    this._navigationUtils.setNavigationInfo(navigationInfo);
  }

  getSearchData() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.searchData) {
      return navigationInfo.searchData;
    }
    return null;
  }
  getTitle(): string | null {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.action) {
      return navigationInfo.action;
    }
    return '';
  }


  isNew() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.action && navigationInfo.action === AppConstants.ACTIONS.ADD) {
      return true;
    }
    return false;
  }

  goBack() {
    this._navigationUtils.loadPreviousState();
  }
  setPersonDob(Dob: any) {
    this.personDobListener$.next(Dob);
  }
  setPersonInfo(personInfo: any) {
    this.personInfo = personInfo;
    this.personInfoListener$.next(this.personInfo);
  }
  getPersonInfo() {
    return this.personInfo;
  }
  getCaseNumber() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.source === AppConstants.CASE_TYPE.CPS_CASE) {
      return navigationInfo.data.caseNumber;
    } else {
      return null;
    }
  }
  getCaseId() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.source === AppConstants.CASE_TYPE.CPS_CASE) {
      return navigationInfo.sourceID;
    } else {
      return null;
    }
  }

  getServiceCaseId() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.source === AppConstants.CASE_TYPE.SERVICE_CASE) {
      return navigationInfo.sourceID;
    } else {
      return null;
    }
  }

  getIntakeNumberByServiceCaseID(): Observable<any> {
    return this._commonHttpService.getArrayList({
      where: {
         serviceCaseId: this.getServiceCaseId(),
         activeflag: 1
      }, method: 'get'
    }, 'servicecase/getintakeserviceid?filter');

  }

  getIntakeNumber() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.source === AppConstants.CASE_TYPE.INTAKE) {
      return navigationInfo.sourceID;
    } else if (navigationInfo && (navigationInfo.source === AppConstants.MODULE_TYPE.PUBLIC_PROVIDER
      || navigationInfo.source === AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL
      || navigationInfo.source === AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION)) {
      return navigationInfo.sourceID;
    } else {
      return null;
    }
  }

  getPurposeId() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    if (navigationInfo && navigationInfo.data) {
      return navigationInfo.data.purposeId;
    } else {
      return null;
    }
  }
  deletePersonnarrativeDetails(data: { personemploymentid: any; }) {
    const workdetails = {
      personemploymentid: data.personemploymentid,
      delete: 1
    };
    const result = {
      pid: this.getPersonId(),
      intakeserviceid: this.getCaseId(),
      workdetails: workdetails,
      intakenumber: this.getIntakeNumber()
    };
    return this._commonHttpService.create(result, 'People/addupdatepersonnarrative');
  }
  deletePersonworkDetails(data: { personworkcarrergoalid: any; personemploymentid: any; personemployerdetailid: any; }) {
    const workdetails = {
      personworkcarrergoalid: data.personworkcarrergoalid,
      personemploymentid: data.personemploymentid,
      personemployerdetailid: data.personemployerdetailid,
      delete: 1
    };
    const result = {
      pid: this.getPersonId(),
      intakeserviceid: this.getCaseId(),
      workdetails: workdetails,
      intakenumber: this.getIntakeNumber()
    };
    return this._commonHttpService.create(result, 'People/addupdatepersonwork');
  }
  savePersonnarrativeDetails(data: any) {
    const result = {
      pid: this.getPersonId(),
      intakeserviceid: this.getCaseId(),
      workdetails: data,
      intakenumber: this.getIntakeNumber()
    };
    return this._commonHttpService.create(result, 'People/addupdatepersonnarrative');
  }
  saveSupportOrderDetails(data: any) {
    data.addupdatefinancesupportorder.personid = this.getPersonId();
    return this._commonHttpService.create(data, 'People/addupdatefinancesupportorder');
  }
  saveAssetDetails(data: any) {
    data.where.personid = this.getPersonId();
    return this._commonHttpService.create(data, 'People/personaddupdatefinanceasset');
  }
  savePersonIncomeDetails(data: any) {
    data.addupdatefinanceincome.personid = this.getPersonId();
    data.addupdatefinanceincome.deemedparent.verifiedparentpersonid = this.getPersonId();
    return this._commonHttpService.create(data, 'People/addupdatefinanceincome');
  }
  savePersonworkDetails(data: any) {
    const workdetails = {
      personworkcarrergoalid: data.personworkcarrergoalid,
      personemploymentid: data.personemploymentid,
      personemployerdetailid: data.personemployerdetailid,
      delete: (data.personemployerdetailid) ? 2 : 0,
      employerdetails: {
        employername: data.employername,
        currentemployer: data.currentemployer,
        noofhours: data.noofhours,
        duties: data.duties,
        startdate: data.startdate || null,
        enddate: data.enddate || null,
        reasonforleaving: data.reasonforleaving
      },
      employeraddress: {
        address1: data.address1,
        address2: data.address2,
        cityname: data.cityname,
        statetypekey: data.statetypekey,
        countytypekey: data.countytypekey,
        zip5no: data.zip5no
      },
      occupationdetails: {
        clienttitle: data.clienttitle,
        emplymenttypekey: data.emplymenttypekey,
        workschedule: data.workschedule,
        income: data.income || null,
        wagefreqtypekey: data.wagefreqtypekey
      },
      careergoaldetails: {
        careergoals: data.careergoals
      },
      supervisordetails: {
        supervisorfirstname: data.supervisorfirstname,
        supervisormiddlename: data.supervisormiddlename,
        supervisorlastname: data.supervisorlastname,
        supervisorsuffixtypekey: data.supervisorsuffixtypekey,
        supervisorprefixtypekey: data.supervisorprefixtypekey
      },
      contactdetails: {
        email: data.emailList,
        workphone: data.phoneNumberList
      }
    };
    const result = {
      pid: this.getPersonId(),
      intakeserviceid: this.getCaseId(),
      workdetails: workdetails,
      intakenumber: this.getIntakeNumber()
    };
    return this._commonHttpService.create(result, 'People/addupdatepersonwork');

  }
  savePersonDetails(personData: any, intakeData: any, caseInfo?: {} | undefined) {
    if(!this._navigationUtils.getNavigationInfo()){
      this.ifNoNavigationInfo(caseInfo);
    }
    personData.drugexposednewbornflag = this.drugexposednewbornflagFn(personData);
    personData.probationsearchconductedflag = this.probationsearchconductedflagFn(personData);
    personData.safehavenbabyflag = this.safehavenbabyflagFn(personData);
    personData.isqualifiedalien = this.isqualifiedalienFn(personData);
    personData.citizenalenageflag = this.citizenalenageflagFn(personData);
    personData.isapproxdob = this.isapproxdobFn(personData);
    personData.isapproxdod = this.isapproxdodFn(personData);

    this.setMaritalstatusFn(personData);

    const servicecaseid = this.checkCaseInfoFn(caseInfo, personData, intakeData);

    const data = {
      pid: caseInfo?null:this.getPersonId(),
      intakeserviceid: caseInfo? intakeData.intakeserviceid:this.getCaseId(),
      intakenumber: caseInfo? intakeData.intakenumber:this.getIntakeNumber(),
      persondetails: personData,
      servicecaseid
     };

    this.ifNotIntakenumberFn(personData, intakeData, caseInfo, data);
    personData.clientflag = personData.clientflag ? personData.clientflag : 1;

     this.persontypeselectedFn(personData);
     this.checkSubstanceexposednewbornflagFn(data);

    this._dataStoreService.setData('QUICK_PERSON_ID',null);
    return this._commonHttpService.create(data, 'People/addupdatepersoncw');
  }
  private safehavenbabyflagFn(personData: { safehavenbabyflag: any; }): any {
    return personData.safehavenbabyflag ? 'true' : 'false';
  }

  private probationsearchconductedflagFn(personData: { probationsearchconductedflag: any; }): any {
    return (personData.probationsearchconductedflag) ? 1 : 0;
  }

  private drugexposednewbornflagFn(personData: { drugexposednewbornflag: any; }): any {
    return (personData.drugexposednewbornflag) ? 1 : 0;
  }

  private isapproxdodFn(personData: any): any {
    return (personData.isapproxdod) ? 1 : 0;
  }

  private isapproxdobFn(personData: any): any {
    return (personData.isapproxdob) ? 1 : 0;
  }

  private citizenalenageflagFn(personData: any): any {
    return (personData.citizenalenageflag === 'null') ? '0' : personData.citizenalenageflag;
  }

  private isqualifiedalienFn(personData: any): any {
    return (personData.isqualifiedalien === 'null') ? '0' : personData.isqualifiedalien;
  }

  private ifNotIntakenumberFn(personData: any, intakeData: any, caseInfo: any, data: { pid: any; intakeserviceid: any; intakenumber: any; persondetails: any; servicecaseid: any; }) {
    if (!personData.intakenumber && intakeData && !caseInfo) {
      data.intakenumber = intakeData.intakenumber;
      personData.intakenumber = intakeData.intakenumber;
      data.intakeserviceid = intakeData.intakeserviceid;
      data.servicecaseid = this.getServiceCaseId();
      personData.servicecaseid = this.getServiceCaseId();
    }
  }

  private checkSubstanceexposednewbornflagFn(data: { pid: any; intakeserviceid: any; intakenumber: any; persondetails: any; servicecaseid: any; }) {
    if (data.persondetails.substanceexposednewbornflag === 1) {
      data.persondetails.senstatusflag = 1;
      this.checkSubstanceexposednewbornflagFnIfCon(data);
      data.persondetails.substanceexposednewborntimetamp = data.persondetails.substanceexposednewborntimetamp ? data.persondetails.substanceexposednewborntimetamp : new Date();
    }
  }

  private checkSubstanceexposednewbornflagFnIfCon(data: { pid: any; intakeserviceid: any; intakenumber: any; persondetails: any; servicecaseid: any; }) {
    if (data.persondetails.substanceexposednewbornsourcetypekey === 2957) {
      data.persondetails.substanceexposednewbornsourceid = data.persondetails.substanceexposednewbornsourceid ? data.persondetails.substanceexposednewbornsourceid : data.intakeserviceid;
    } else if (data.persondetails.substanceexposednewbornsourcetypekey === 2952) {
      data.persondetails.substanceexposednewbornsourceid = data.persondetails.substanceexposednewbornsourceid ? data.persondetails.substanceexposednewbornsourceid : data.servicecaseid;
    } else if (data.persondetails.substanceexposednewbornsourcetypekey === 2954) {
      data.persondetails.substanceexposednewbornsourceid = data.persondetails.substanceexposednewbornsourceid ? data.persondetails.substanceexposednewbornsourceid : data.intakenumber;
    }
  }

  private persontypeselectedFn(personData: any) {
    const persontypeselected = this._dataStoreService.getData('QUICK_PERSON_ID');
    if (persontypeselected?.persontype === 'QP') {
      personData.clientflag = 1;
      personData.qpid = persontypeselected.quickpersonid;
      personData.qptype = persontypeselected.persontype;
    } else {
      personData.clientflag = personData.clientflag ? personData.clientflag : 1;
      personData.qpid = null;
      personData.qptype = null;
    }
  }

  private checkCaseInfoFn(caseInfo: any, personData: any, intakeData: any) {
    let servicecaseid: any;
    if (caseInfo) {
      personData.caseInfo = caseInfo;
      personData.intakenumber = intakeData.intakenumber;
      if (caseInfo.objectType === this.servicecasetxt) {

        servicecaseid = this._dataStoreService.getData('CASEUID');
        personData.servicecaseid = servicecaseid;
      }
    }
    else {
      personData.caseInfo = this.getCaseInfo();
      personData.personid = this.getPersonId();
      personData.intakenumber = this.getIntakeNumber();
    }
    return servicecaseid;
  }

  private setMaritalstatusFn(personData: any) {
    let maritalstatus;
    if (personData.maritalstatustypekey) {
      maritalstatus = {
        // 'informallivingcomments': 'PARENT',
        // 'adrhomephone': '1234524',
        // 'statustypekey': personData.maritalstatustypekey,
        // 'marriageplace': 'marriageplace',
        // 'divorceplace': 'divorceplace',
        // 'firstname': 'firstname'
        'statustypekey': personData.maritalstatustypekey,
        'marriageplace': personData.marriageplace,
        'divorceplace': personData.divorceplace,
        'maritalstartdate': personData.maritalstartdate,
        'maritalenddate': personData.maritalenddate,
        'childrenno': personData.numberofchildren,
        'maritalcomments': personData.maritalcomments,
        'spouseprefix': personData.spouseprefix,
        'spousefirstname': personData.spousefirstname,
        'spousemiddlename': personData.spousemiddlename,
        'spouselastname': personData.spouselastname,
        'spousesuffix': personData.spousesuffix,
        'spousehomenumber': personData.spousehomenumber,
        'spouseofficenumber': personData.spouseofficenumber,
        'spouseofficeextension': personData.spouseofficeextension,
        'spouseaddress1': personData.spouseaddress1,
        'spouseAddress2': personData.spouseAddress2,
        'spousecity': personData.spousecity,
        'spousestate': personData.spousestate,
        'spousecounty': personData.spousecounty,
        'spousezipcode': personData.spousezipcode
      };
    }
    personData.maritalstatus = maritalstatus;
    return maritalstatus;
  }

  private ifNoNavigationInfo(caseInfo: any) {
    const personInfo = new PersonInfoStore();
    if (caseInfo?.objectType) {
      this.objectTypeCheck(caseInfo, personInfo);
    }
    this._navigationUtils.setNavigationInfo(personInfo);
  }

  private objectTypeCheck(caseInfo: any, personInfo: PersonInfoStore) {
    if (caseInfo?.objectType === this.servicecasetxt) {
      personInfo.source = 'SERVICE_CASE';
    } else if (caseInfo?.objectType === 'Case') {
      personInfo.source = 'CPS_CASE';
    } else if (caseInfo?.objectType === 'Intake') {
      personInfo.source = 'INTAKE';
    }
    personInfo.sourceID = caseInfo.objectNumber;
  }

  setWorkInfo(workInfo: {}) {
    this.workInfo = workInfo;
    this.workInfoListener$.next(this.workInfo);
  }
  setAssetInfo(assetInfo: any) {
    this.assetInfo = assetInfo;
    this.assetInfoListener$.next(this.assetInfo);
  }
  setIncomeInfo(incomeInfo: any) {
    this.incomeInfo = incomeInfo;
    this.incomeInfoListener$.next(this.incomeInfo);
  }
  reloadworkDetails(flag: any) {
    this.personInfoWorkListener$.next(flag);
  }

  getRoleList() {
    return this._commonHttpService.getArrayList(
      {
        where: {
          activeflag: 1,
          datypeid: this.getPurposeId() // need to add purpose for both intake and case
        },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .UserActorTypeUrl + '?filter'
    );
  }

  calculateAge(dob: string | number | Date) {
    let age = 0;
    if (dob && moment(new Date(dob), 'MM/DD/YYYY', true).isValid()) {
      const rCDob = moment(new Date(dob), 'MM/DD/YYYY').toDate();
      age = moment().diff(rCDob, 'years');
    }
    return age;
  }

  searchPresonWithCritera(searchCriteria: any) {
    ObjectUtils.removeEmptyProperties(searchCriteria);
    return this._commonHttpService
      .getPagedArrayList(
        {
          where: searchCriteria,
          method: 'post'
        },
        'globalpersonsearches/getEnhancedPersonSearchData'
      );
  }

  searchPersonWithSsnCritera(searchCriteria: any) {
    ObjectUtils.removeEmptyProperties(searchCriteria);
    return this._commonHttpService
      .getPagedArrayList(
        {
          where: searchCriteria,
          method: 'post'
        },
        'globalpersonsearches/getPersonssnvalidation'
      );
  }

  getCaseInfo() {
    const navigationInfo = this._navigationUtils.getNavigationInfo();
    const caseInfo: any = {objectType : null, objectNumber: null};
    if (navigationInfo && navigationInfo.source === AppConstants.CASE_TYPE.INTAKE) {
      caseInfo['objectType'] = 'Intake';
      caseInfo['objectNumber'] = navigationInfo.sourceID;
    } else if (navigationInfo && navigationInfo.source === AppConstants.CASE_TYPE.SERVICE_CASE) {
      caseInfo['objectType'] = this.servicecasetxt;
      caseInfo['objectNumber'] = navigationInfo.data.caseNumber;
    } else if (navigationInfo && navigationInfo.source === AppConstants.CASE_TYPE.CPS_CASE) {
      caseInfo['objectType'] = 'Case';
      caseInfo['objectNumber'] = navigationInfo.data.caseNumber;
    } else {
      caseInfo['objectType'] = 'OTHER';
      caseInfo['objectNumber'] = navigationInfo.sourceID;
    }

    return caseInfo;
  }

  getClosed() {
    const currentStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
    const da_status = this.storage.getItem('da_status');
    const isView = this.storage.getItem('isView');
    if (da_status === 'Closed' || da_status === 'Completed' || currentStatus === 'Closed' || currentStatus === 'Completed' || isView === 'true') {
        return true;
    } else {
        return false;
    }
  }

}

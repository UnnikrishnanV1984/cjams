import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService, SessionStorageService,AuthService } from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { AppConstants } from '../../../@core/common/constants';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
import { PersonInfoService } from '../person-info/person-info.service';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';

@Injectable()
export class InvolvedPersonsService {

  constructor(private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _session: SessionStorageService,
    private _navigationUtils: NavigationUtils, private _personInfoService: PersonInfoService,
    private _authService: AuthService) {

  }

  getReportSummary() {
    const isServicecase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    const caseid = this.getCaseUuid();
    if (caseid && isServicecase) {
        return this._commonHttpService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + caseid);
    }
    return null;
  }
  getInvolvedPerson(page: number, limit: number) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: limit,
          nolimit: limit?true:false,
          method: 'get',
          where: this.getRequestParam()
        }),
        url + '?filter'
      );


  }

  removeInvolvedPersons(person: any) {
    const personId = (person && person.personid) ? person.personid : null;
    const url = 'People/deleteInvolvedPerson';
    let param;
    if (personId) {
    
      const personParam = { personid: personId, method: 'post' };
      const request = { ...this.getRequestParam(), ...personParam };

      return this._commonHttpService.getSingle(request, url);
    } else {
      return null;
    }
  }

  getRequestParam() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let inputRequest: Object = {};
    const caseID = this.getCaseUuid();
    const source = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.SOURCE_PAGE);
    switch (source) {
      case AppConstants.MODULE_TYPE.CASE:
        if (this.isServiceCase()) {
          inputRequest = {
            objectid: caseID,
            objecttypekey: 'servicecase',
            servicecaseid: caseID
          };
        } else {
          inputRequest = {
            intakeserviceid: caseID,
            isExpungementSuperUser: isExpungementSuperUser,
             'iscaseexpunged': iscaseexpunged
          };
        }
        break;
      case AppConstants.MODULE_TYPE.ADOPTION_CASE:
          inputRequest = {
            intakeserviceid: caseID,
            isExpungementSuperUser: isExpungementSuperUser,
             'iscaseexpunged': iscaseexpunged
          };
        break;
      case AppConstants.MODULE_TYPE.INTAKE:
        inputRequest = {
          intakenumber: this.getIntakeNumber(),
          isExpungementSuperUser: isExpungementSuperUser,
           'iscaseexpunged': iscaseexpunged
        };
        break;
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER:
        inputRequest = {
          intakenumber: this._dataStoreService.getData('PROVIDER_ID'),
          providerid: this._dataStoreService.getData('PROVIDER_ID')
        };
        break;
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION:
        inputRequest = {
          intakenumber: this._dataStoreService.getData('APPLICANT_NUMBER'),
          applicantNumber: this._dataStoreService.getData('APPLICANT_NUMBER')
        };
        break;
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL:
        inputRequest = {
          intakenumber: this._dataStoreService.getData('REFERRAL_NUMBER'),
          referralNumber: this._dataStoreService.getData('REFERRAL_NUMBER')
        };
        break;
      default:
        if (caseID) {
          if (this.isServiceCase()) {
            inputRequest = {
              objectid: caseID,
              objecttypekey: 'servicecase',
              servicecaseid: caseID
            };
          } else {
            inputRequest = {
              intakeserviceid: caseID,
              isExpungementSuperUser: isExpungementSuperUser,
               'iscaseexpunged': iscaseexpunged
            };
          }
        } else if (this.getIntakeNumber()) {
          inputRequest = {
            intakenumber: this.getIntakeNumber(),
            isExpungementSuperUser: isExpungementSuperUser,
             'iscaseexpunged': iscaseexpunged
          };
        }
        break;
    }
  
    return inputRequest;
  }

  isServiceCase() {
    return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
  }

  isIntakeMode() {
    return this.getIntakeNumber() ? true : false;
  }

  getIntakeNumber() {
    const intakeStore = this._dataStoreService.getObj('intake');
    if (intakeStore && intakeStore.number) {
      return intakeStore.number;
    } else {
      return null;
    }
  }

  getIntakeServiceId() {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let caseUUID = null;
    if (caseInfo) {
      caseUUID = caseInfo.intakeserviceid;
    }
    return caseUUID;
  }
  getCaseUuid() {
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if (caseID) {
      return caseID;
    }
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let caseUUID = null;
    if (caseInfo) {
      caseUUID = caseInfo.intakeserviceid;
    }
    return caseUUID;
  }

  getCaseNumber() {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let caseNumber = null;
    if (caseInfo) {
      caseNumber = caseInfo.da_number;
    }
    return caseNumber;
  }

  getUniqueNumber() {
    const source = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.SOURCE_PAGE);
    switch (source) {
      case AppConstants.MODULE_TYPE.CASE:
        return this.getCaseUuid();
      case AppConstants.MODULE_TYPE.ADOPTION_CASE:
        return this.getCaseUuid();
      case AppConstants.MODULE_TYPE.INTAKE:
        return this.getIntakeNumber();
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION:
        return this._dataStoreService.getData('APPLICANT_NUMBER');
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER:
        return this._dataStoreService.getData('PROVIDER_ID');
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL:
        return this._dataStoreService.getData('REFERRAL_NUMBER');


    }
  }

  getSource() {
    const source = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.SOURCE_PAGE);
    if (source === AppConstants.MODULE_TYPE.CASE) {
      if (this.isServiceCase()) {
        return AppConstants.CASE_TYPE.SERVICE_CASE;
      } else {
        return AppConstants.CASE_TYPE.CPS_CASE;
      }
      // need to add condition for adoption case
    } else {
      return source;
    }
  }

  getData() {
    const data = {
      purposeId: null,
      caseNumber: null
    };
    if (this.isIntakeMode()) {
      const intakePurpose = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
      if (intakePurpose && intakePurpose.code !== 'ROACPS') {
        data.purposeId = intakePurpose.value;
      }
    } else {
      data.purposeId = this._dataStoreService.getData('da_typeid');
      data.caseNumber = this.getCaseNumber();
    }
    return data;
  }

  editPerson(personId: string, isProgramAreaOoh?: boolean, isActiveOoh?: boolean) {
    const data: any = this.getData();
    data['isProgramAreaOoh'] = isProgramAreaOoh;
    data['isActiveOoh'] = (isActiveOoh !== null) ? isActiveOoh : false;
    this._navigationUtils.openEditPersonInfo(personId, this.getSource(), this.getUniqueNumber(), data);
  }

  newPerson(searchdata = {}) {
    this._navigationUtils.openNewPersonInfo(this.getSource(), this.getUniqueNumber(), this.getData(), searchdata);
  }

  viewPerson(personId: string) {
    this._navigationUtils.openViewPersonInfo(personId, this.getSource(), this.getUniqueNumber(), this.getData());
  }

  viewPersonHealthSummary(personId: string, extras?: any) {
    this._navigationUtils.openViewPersonHealthSummaryInfo(personId, this.getSource(), this.getUniqueNumber(), this.getData(), extras);
  }

  //
  newSDRPerson(selectedPerson: any) {

    /*
      set personbasicdetails
    */
    const personbasicdetails: any = {};
    personbasicdetails.firstname = selectedPerson.firstname;
    personbasicdetails.lastname = selectedPerson.lastname;
    personbasicdetails.middlename = selectedPerson.middlename;
    personbasicdetails.dob = selectedPerson.dob;
    personbasicdetails.dangerlevel = selectedPerson.dangerlevel;
    personbasicdetails.suffix = selectedPerson.suffix;
    personbasicdetails.prefix = selectedPerson.prefix;
    personbasicdetails.ssnno = selectedPerson.ssn;
    personbasicdetails.ssnverified = selectedPerson.ssnverified;
    personbasicdetails.mdm_id = selectedPerson.mdm_id;
    personbasicdetails.gendertypekey = selectedPerson.gendertypekey;
    personbasicdetails.cjamspid = selectedPerson.cjamspid;
    personbasicdetails.primarylanguage = selectedPerson.primarylanguage;
    personbasicdetails.ethnicity = selectedPerson.ethnicity;
    personbasicdetails.nationality = selectedPerson.nationality;
    personbasicdetails.race = selectedPerson.race;
    personbasicdetails.stateid = selectedPerson.stateid;
    personbasicdetails.primarycitizenship = selectedPerson.primarycitizenship;
    personbasicdetails.alienstatustypekey = selectedPerson.alienstatus;
    personbasicdetails.alienregistrationtext = selectedPerson.aliennumber;
    personbasicdetails.cisclientid = selectedPerson.cisclientid;

    personbasicdetails.alias = selectedPerson.alias;

    selectedPerson.personbasicdetails = personbasicdetails;
    this._personInfoService.setPersonInfo(selectedPerson);
    this._navigationUtils.openNewPersonInfo(this.getSource(), this.getUniqueNumber(), this.getData());
  }


  editSDRPerson(selectedPerson: any) {

    this._navigationUtils.openEditPersonInfo(selectedPerson.personid, this.getSource(), this.getUniqueNumber(), this.getData());
  }

  updateInProviderInfo() {
    const source = this.getSource();
    let flowType: string = '';
    switch (source) {
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL:
        flowType = 'inquiry';
        break;
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION:
        flowType = 'application';
        break;
      case AppConstants.MODULE_TYPE.PUBLIC_PROVIDER:
        flowType = 'provider';
        break;
    }

    if (flowType) {
      const data = {
        type: flowType,
        objectid: this.getUniqueNumber()
      };
      this._commonHttpService.create({ where: data }, 'publicproviderapplicant/updatepersondata').subscribe();
    }

  }
}

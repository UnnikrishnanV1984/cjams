import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService, SessionStorageService ,  AuthService} from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
import { AppConstants } from '../../../@core/common/constants';


@Injectable()
export class QuickPersonHistoryService {
  source!: string;
  constructor(private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _session: SessionStorageService,
    private _navigationUtils: NavigationUtils,
  private _authService: AuthService) {
    

  }

  getPersonsList() {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: {  objecttypekey: 'servicecase' , objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
        // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
      );
  }

  getInvolvedPerson(page: number, limit: number,personid: string) {

    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: limit,
          method: 'get',
          where: this.getRequestParam(personid)
        }),
        'quickpersonhistory/list?filter'
      );


  }
  getInvolvedPersonWithPersonID(page: number, limit: number,personid: string) {

    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: limit,
          method: 'get',
          where: this.getRequestParam(personid)
        }),
        'People/getallpersonrelationbyprovidedpersonid?filter'
      );


  }
  getRequestParam(personid: string) {
    var inputRequest: any;
    const caseID = this.getCaseUuid();
    this.source = this.getSource();
    if (this.isServiceCase()) {
      inputRequest = {
        objectid: caseID,
        objecttypekey: 'servicecase',
      };
    } else if (this.isIntakeMode()) {
      inputRequest = {
        intakenumber: this.getIntakeNumber()
      };
     
    } else {
      inputRequest = {
        intakeserviceid: caseID
      };
    }
    if(personid) {
      inputRequest.personid=personid;
    }


    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    inputRequest.isExpungementSuperUser= isExpungementSuperUser;
    inputRequest.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
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
    if (this.isIntakeMode()) {
      return this.getIntakeNumber();
    } else {
      return this.getCaseUuid();
    }
  }

  getSource() {

    if (this.isServiceCase()) {
     return AppConstants.CASE_TYPE.SERVICE_CASE;
    } else if (this.isIntakeMode()) {
      return AppConstants.CASE_TYPE.INTAKE;
    } else {
      return AppConstants.CASE_TYPE.CPS_CASE;
    }
    // need to add condition for adoption case
  }


  getPersonRelations(personid: string) {
    return this._commonHttpService
      .getAll('People/getpersonrelations?filter={"where":{"personid":"' + personid + '"}}');
  }


}

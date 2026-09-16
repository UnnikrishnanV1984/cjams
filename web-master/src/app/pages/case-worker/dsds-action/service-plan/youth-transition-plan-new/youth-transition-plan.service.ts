import { Injectable, EventEmitter } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../../@core/services';
import { AppConstants } from '../../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
@Injectable({providedIn: 'root'})
export class YouthTransitionPlanService {

  isCaseWorker = false;
  isSuperVisor = false;

  youthtransitionplanid!: string;
  clientid!: string;
  intakeserviceid!: string;
  daNumber!: string;
  sevicecaseid!: string;
  selectedPlan: any;
  displayorder = 'insertedon desc';

  onGetPerson: EventEmitter<any> = new EventEmitter();
  onGetYTPData: EventEmitter<any> = new EventEmitter();

  constructor(private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService) {
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isSuperVisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
  }

  patchData(jsontype: any, jsondata: any) {
    const payload: any = {};
    payload['youthtransitionplanid'] = this.youthtransitionplanid;
    payload['startdate'] = jsondata.startdate;
    payload['enddate'] = jsondata.enddate;
    payload[jsontype] = jsondata;
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    return this._commonHttpService.patch(
      this.youthtransitionplanid,
      payload,
      'youthtransitionplan'
    );
  }


  getYTPPlanList(clientID: any) {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: {
            clientid: clientID,
            intakeserviceid: this.intakeserviceid
          },
          order: this.displayorder
        }),
        'youthtransitionplan/list' + '?filter'
      );
  }

  getYTPPlanEduList(clientID: any) {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: {
            personid: clientID 
          },
          order: this.displayorder
        }),
        'personeducation/educationlist' + '?filter'
      );
  }

  getYTPPlanProviderList(clientID: any) {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: {
            personid: clientID 
          },
          order: this.displayorder
        }),
        'personphycisianinfo/getproviderinfo' + '?filter'
      );
  }

  getYTPPlanEmploymentList(clientID: any) {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: {
            personid: clientID 
          },
          order: this.displayorder
        }),
        'People/getpersonwork?filter'
      );
  }

  getYTPAddress(add1: any, add2: any,city: any, state: any, zip: any) {
    let addressCheck = ' ';
    if(add1) {
      addressCheck += add1;
    } 
    if(add2) {
      addressCheck += ' ' + add2;
    } 
    if(city) {
      addressCheck += ' ' + city;
    } 
    if(state) {
      addressCheck += ' ' + state;
    } 
    if(zip) {
      addressCheck += ' ' + zip;
    } 
    return addressCheck;
  }

  getYTPPlanHealtList(clientID: any) {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: {
            personid: clientID 
          },
          order: this.displayorder
        }),
        'personhealthinsurance/list?filter'
      );
  }

  getPermanencyPlanList() {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'permanencyplan/list?filter'
      )
  }

  getPersonName(id: any) {
    var personList = this._dataStoreService.getData('PERSONLIST-CASE-PLAN');
    if (personList && Array.isArray(personList)) {
      const person = personList.find(item => item.personid === id);
      return (person) ? (person.firstname + ' ' + person.lastname) : '';
    }
    return '';
  }

  createYTP(clientID: any, startdate: any, enddate: any, data: any) {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.create(
      {
        clientid: clientID,
        intakeserviceid: this.intakeserviceid,
        startdate: startdate,
        enddate: enddate,
        approvalstatuskey: 'Draft',
        insertedby: this._authService?.getCurrentUser()?.user?.securityusersid,
        updatedby: this._authService?.getCurrentUser()?.user?.securityusersid,
        ...data
      },
      'youthtransitionplan/'
    );
  }

  copyYTP(clientID: any, data: any) {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.create(
      {
        clientid: clientID,
        intakeserviceid: this.intakeserviceid,
        approvalstatuskey: 'Draft',
        ...data
      },
      'youthtransitionplan/'
    );
  }

  getYTPSummary(clientID: any) {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: {
            personid: clientID,
            servicecaseid: this.intakeserviceid

          }
        }),
        'permanencyplan/list' + '?filter'
      );
  }

  public processTabState(tabs: any, selectedPlan: any) {
    tabs.forEach((tab: any) => {
      const selectedPlanTabItem = selectedPlan?.[tab.keyName];
      if (selectedPlanTabItem && selectedPlanTabItem.isCompleted) {
        tab.isCompleted = true;
      } else {
        tab.isCompleted = false;
      }

    });

    return tabs;
  }


}
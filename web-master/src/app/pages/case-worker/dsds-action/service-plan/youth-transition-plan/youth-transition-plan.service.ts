import { Injectable, EventEmitter } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../../@core/services';
import { AppConstants } from '../../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';

@Injectable()
export class YouthTransitionPlanService {

  isCaseWorker = false;
  isSuperVisor = false;

  youthtransitionplanid!: string;
  clientid!: string;
  intakeserviceid!: string;
  daNumber!: string;
  sevicecaseid!: string;
  selectedPlan: any;

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
    payload[jsontype] = jsondata;
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
          order: 'insertedon desc'
        }),
        'youthtransitionplan/list' + '?filter'
      );
  }

  getPersonName(id: any) {
    var personList = this._dataStoreService.getData('PERSONLIST-CASE-PLAN');
    if (personList && Array.isArray(personList)) {
      const person = personList.find(item => item.personid === id);
      return (person) ? (person.firstname + ' ' + person.lastname) : '';
    }
    return '';
  }

  createYTP(clientID: any) {
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.create(
      {
        clientid: clientID,
        intakeserviceid: this.intakeserviceid,
        approvalstatuskey: 'Draft'
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
    tabs.forEach((tab: { keyName: string | number; isCompleted: boolean; }) => {
      const selectedPlanTabItem = selectedPlan[tab.keyName];
      if (selectedPlanTabItem && selectedPlanTabItem.isCompleted) {
        tab.isCompleted = true;
      } else {
        tab.isCompleted = false;
      }

    });

    return tabs;
  }


}

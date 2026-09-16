import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService,AuthService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Router } from '@angular/router';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';

@Injectable()
export class PlacementGapService {

  private gapid!: string;
  constructor(private _httpService: CommonHttpService, private _dataStoreService: DataStoreService,
    private _route: Router,  private _authService: AuthService)  { }

  getGapId() {
    return this.gapid;
  }

  setGapId(gapId: any) {
    this.gapid = (gapId) ? gapId : null;
  }

  getGapDisclosureDetails(reqParams: any) {
    return this._httpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          where: reqParams,
          method: 'get'
        }),
        'gapdisclosure/getguardianship' + '?filter'
      );
  }

  getInvolvedPerson() {

    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }

    return this._httpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          method: 'get',
          where: this.getRequestParam()
        }),
        url + '?filter'
      );
  }

  getRequestParam() {
    let inputRequest: Object;
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const isServiceCase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    if (isServiceCase) {
      inputRequest = {
        objectid: caseID,
        objecttypekey: 'servicecase'
      };
    } else {
      inputRequest = {
        intakeserviceid: caseID,
        'isExpungementSuperUser': isExpungementSuperUser,
        'iscaseexpunged': iscaseexpunged
      };
    }
    
    return inputRequest;
  }

  checkDataAvailability() {
    const permanecyplanid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
    const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    if (!permanecyplanid) {
      const currentUrl = '/pages/case-worker/' + id + '/' + daNumber + '/dsds-action/sc-permanency-plan';
      this._route.navigate([currentUrl]);
    }
  }

}

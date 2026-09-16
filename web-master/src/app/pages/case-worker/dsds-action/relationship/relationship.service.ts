import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';

@Injectable()
export class RelationshipService {

  constructor(private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService) {

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

  getPersonRelations(personid: string) {
    return this._commonHttpService
      .getAll('People/getpersonrelations?filter={"where":{"personid":"' + personid + '"}}');
  }


}

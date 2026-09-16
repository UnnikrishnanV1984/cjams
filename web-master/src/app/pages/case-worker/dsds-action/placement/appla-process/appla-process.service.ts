
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Injectable()
export class ApplaProcessService {

  constructor(private service: CommonHttpService,
    private _dataStoreService: DataStoreService) { }


  getPage(page: number) {
    return this.service
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: 40,
          where: {
            objecttypekey: 'servicecase',
            objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
            description: 'APPLA'
          },
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment + '?filter'
      ).pipe(
      map((result) => {
        return { data: result.data, count: result.count };
      }));
  }
}

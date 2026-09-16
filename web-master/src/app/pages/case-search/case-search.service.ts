import { Injectable } from '@angular/core';
import { CommonHttpService } from '../../@core/services';

@Injectable()
export class CaseSearchService {

  constructor(private _commonService: CommonHttpService) { }

  searchCase(caseId: any, caseType: string | null, url: string | undefined) {
    let reqData;
    if (caseType === 'servicecase') {
      reqData =  { casenumber : caseId, actiontype : caseType } ;
    } else {
      reqData =  { servicerequestnumber : caseId, actiontype : caseType } ;
    }
    return this._commonService
    .getSingle(
      {

        limit: 10,
        order: 'desc',
        page: 1,
        count: -1,
        where: reqData,
        method: 'get'
      },
      url
    );
  }
}

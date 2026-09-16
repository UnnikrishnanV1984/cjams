import { Injectable } from '@angular/core';
import { CommonHttpService } from '../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';

@Injectable()
export class PersonProfileService {

  
  constructor(private _commonHttpService: CommonHttpService) { }

  getMaritalStatusList() {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        order: 'typedescription'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .MartialStatusTypeUrl + '?filter'
    );
  }

  getStateList() {
    return this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .StateListUrl + '?filter'
    );
  }
  getCountyList() {
    return this._commonHttpService.create(
      {
        nolimit: true,
        order: 'countyname asc'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList
    );
  }

  getGenderList() {
    return this._commonHttpService.create(
      {
        where: { activeflag: 1 },
        method: 'post',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .GenderTypeUrl + '/genderlist'
    );
  }

  

  

}

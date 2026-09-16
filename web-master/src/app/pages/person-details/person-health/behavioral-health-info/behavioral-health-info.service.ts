
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GenericService, CommonHttpService } from '../../../../@core/services';
import { BehaviouralHealthInfo } from '../../../../@core/common/models/involvedperson.data.model';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../../@core/entities/common.entities';

@Injectable()
export class BehavioralHealthInfoService {

  behaviorHealth$ = new Observable<any[]>();

  constructor(private _service: GenericService<BehaviouralHealthInfo>,
    private _commonHttpService: CommonHttpService) { }

  addUpdatebehaviorHealthInfo(behaviorHealth: any) {
    return this._commonHttpService.create(behaviorHealth, CommonUrlConfig.EndPoint.PERSON.MEDICAL.BehaviorHealthInfoAdd);
  }

  getbehaviorHealth(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.MEDICAL.BehaviorHealthInfoList + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result,
        count: result.length > 0 ? result[0].totalcount : 0,
        canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.behaviorHealth$ = source.pipe(pluck('data'));
    return source;
  }

  delete(behaviorHealthid: any) {
    this._service.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.BehaviorHealthInfoDelete;
    return this._service.remove(behaviorHealthid);
  }

  set behaviorHealth(behaviorHealth: Observable<any[]>) {
    this.behaviorHealth$ = behaviorHealth;
  }

  get behaviorHealth(): Observable<any[]> {
    return this.behaviorHealth$;
  }


}


import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GenericService, CommonHttpService } from '../../../../@core/services';
import { HealthExamination } from '../../../../@core/common/models/involvedperson.data.model';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../../@core/entities/common.entities';

@Injectable()
export class HealthExaminationService {

  healthExamInfo$ = new Observable<any[]>();

  constructor(private _service: GenericService<HealthExamination>,
    private _commonHttpService: CommonHttpService) { }

  addUpdateHealthExamInfo(healthExamInfo: any) {
    return this._commonHttpService.create(healthExamInfo, CommonUrlConfig.EndPoint.PERSON.MEDICAL.HealthExamInfoAdd);
  }

  getHealthExamInfo(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.MEDICAL.HealthExamInfoList + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result,
        count: result.length > 0 ? result[0].totalcount : 0,
        canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.healthExamInfo$ = source.pipe(pluck('data'));
    return source;
  }

  delete(healthExamInfoid: any) {
    this._service.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.HealthExamInfoDelete;
    return this._service.remove(healthExamInfoid);
  }

  set healthExamInfo(healthExamInfo: Observable<any[]>) {
    this.healthExamInfo$ = healthExamInfo;
  }

  get healthExamInfo(): Observable<any[]> {
    return this.healthExamInfo$;
  }

}

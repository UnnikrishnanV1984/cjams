
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HealthInsuranceInformation } from '../../../../@core/common/models/involvedperson.data.model';
import { GenericService, CommonHttpService } from '../../../../@core/services';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../../@core/entities/common.entities';

@Injectable()
export class HealthInsuranceInformationService {

  healthInsInfo$ = new Observable<any[]>();

  constructor(private _service: GenericService<HealthInsuranceInformation>,
    private _commonHttpService: CommonHttpService) { }

  addUpdateHealthInsuranceInfo(healthInsInfo: any) {
    return this._commonHttpService.create(healthInsInfo, CommonUrlConfig.EndPoint.PERSON.MEDICAL.HealthInsInfoAdd);
  }

  getHealthInsInfo(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.MEDICAL.HealthInsInfoList + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result,
        count: result.length > 0 ? result[0].totalcount : 0,
        canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.healthInsInfo$ = source.pipe(pluck('data'));
    return source;
  }

  delete(healthInsInfoid: any) {
    this._service.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.HealthInsInfoDelete;
    return this._service.remove(healthInsInfoid);
  }

  set healthInsInfo(healthInsInfo: Observable<any[]>) {
    this.healthInsInfo$ = healthInsInfo;
  }

  get healthInsInfo(): Observable<any[]> {
    return this.healthInsInfo$;
  }

}

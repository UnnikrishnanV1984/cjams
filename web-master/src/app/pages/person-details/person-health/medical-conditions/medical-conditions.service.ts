
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GenericService, CommonHttpService } from '../../../../@core/services';
import { MedicalConditions } from '../../../../@core/common/models/involvedperson.data.model';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../../@core/entities/common.entities';

@Injectable()
export class MedicalConditionsService {

  medicalConditionInfo$ = new Observable<any[]>();

  constructor(private _service: GenericService<MedicalConditions>,
    private _commonHttpService: CommonHttpService) { }

  addUpdatemedicalCondition(medicalCondition: any) {
    return this._commonHttpService.create(medicalCondition, CommonUrlConfig.EndPoint.PERSON.MEDICAL.medicalConditionInfoAdd);
  }

  getmedicalCondition(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.MEDICAL.medicalConditionInfoList + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result,
        count: result.length > 0 ? result[0].totalcount : 0,
        canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.medicalConditionInfo$ = source.pipe(pluck('data'));
    return source;
  }

  delete(medicalConditionid: any) {
    this._service.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.medicalConditionInfoDelete;
    return this._service.remove(medicalConditionid);
  }

  set medicalCondition(medicalCondition: Observable<any[]>) {
    this.medicalConditionInfo$ = medicalCondition;
  }

  get medicalCondition(): Observable<any[]> {
    return this.medicalConditionInfo$;
  }

}

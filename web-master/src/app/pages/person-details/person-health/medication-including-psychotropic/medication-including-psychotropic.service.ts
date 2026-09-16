
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GenericService, CommonHttpService } from '../../../../@core/services';
import { Medication } from '../../../../@core/common/models/involvedperson.data.model';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../../@core/entities/common.entities';

@Injectable()
export class MedicationIncludingPsychotropicService {

  medicationInfo$ = new Observable<any[]>();

  constructor(private _service: GenericService<Medication>,
    private _commonHttpService: CommonHttpService) { }

  addUpdatemedition(medication: any) {
    return this._commonHttpService.create(medication, CommonUrlConfig.EndPoint.PERSON.MEDICAL.medicationInfoAdd);
  }

  getmedication(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.MEDICAL.medicationInfoList + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result,
        count: result.length > 0 ? result[0].totalcount : 0,
        canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.medicationInfo$ = source.pipe(pluck('data'));
    return source;
  }

  delete(medicationid: any) {
    this._service.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.medicationInfoDelete;
    return this._service.remove(medicationid);
  }

  set medication(medication: Observable<any[]>) {
    this.medicationInfo$ = medication;
  }

  get medication(): Observable<any[]> {
    return this.medicationInfo$;
  }


}

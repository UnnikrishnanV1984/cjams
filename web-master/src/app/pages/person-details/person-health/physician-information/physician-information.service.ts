
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Physician } from '../../../../@core/common/models/involvedperson.data.model';
import { GenericService, CommonHttpService } from '../../../../@core/services';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { Observable } from 'rxjs';

@Injectable()
export class PhysicianInformationService {

  physician$ = new Observable<Physician[]>();

  constructor(private _service: GenericService<Physician>,
    private _commonHttpService: CommonHttpService) { }


  addUpdatePhysicianInfo(physicianInfo: any) {
    return this._commonHttpService.create(physicianInfo, CommonUrlConfig.EndPoint.PERSON.MEDICAL.PhysicianInfoAdd);
  }

  getPhysicianInfo(paginationRequest: PaginationRequest, pageinfosize: any) {
    const source = this._commonHttpService.getPagedArrayList(paginationRequest,
      CommonUrlConfig.EndPoint.PERSON.MEDICAL.PhysicianInfoList + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result,
        count: result.length > 0 ? result[0].totalcount : 0,
        canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
      };
    }),share(),);
    this.physician$ = source.pipe(pluck('data'));
    return source;
  }

  delete(physicianInfoid: any) {
    this._service.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.PhysicianInfoDelete;
    return this._service.remove(physicianInfoid);
  }

  set physician(physician: Observable<Physician[]>) {
    this.physician$ = physician;
  }

  get physician(): Observable<Physician[]> {
    return this.physician$;
  }

}

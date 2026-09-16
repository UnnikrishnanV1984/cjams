import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';

@Injectable()
export class PersonTransportService {

  constructor(private _service: GenericService<any>) { }

  getTransportations(personid: any, paginationInfo: PaginationInfo): Observable<any> {
    return this._service.getPagedArrayList({
      method: 'get',
      where: {
        intakeserviceid: null,
        personid: personid
      },
      page: paginationInfo.pageNumber,
      limit: paginationInfo.pageSize

    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Transport.TransportationList);
  }

}

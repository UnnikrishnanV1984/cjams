import { Injectable } from '@angular/core';
import { GenericService } from '../../../../@core/services';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

@Injectable()
export class PlacementSummaryService {

  constructor(private _service: GenericService<any>) { }


  getPlacementSummaryList(status: string, paginationInfo: PaginationInfo): Observable<any> {

    return this._service.getArrayList(
      {
        limit: paginationInfo.pageSize,
        page: paginationInfo.pageNumber,
        where: paginationInfo.where,
        method: 'get',
        status: status
      },
      CommonUrlConfig.EndPoint.PERSON.SUMMARIES.PlacementSummary
    );
  }

}

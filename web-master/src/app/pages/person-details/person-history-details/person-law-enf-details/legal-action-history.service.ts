import { Injectable } from '@angular/core';
import { GenericService } from '../../../../@core/services';
import { LegalActionHistory } from '../../../../@core/common/models/involvedperson.data.model';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

@Injectable()
export class LegalActionHistoryService {

  constructor(private _service: GenericService<LegalActionHistory>) { }

  getLegalActionHistory(paginationInfo: PaginationInfo) {
    return this._service.getPagedArrayList(
      {
        limit: paginationInfo.pageSize,
        order: paginationInfo.sortBy,
        page: paginationInfo.pageNumber,
        count: paginationInfo.total,
        where: paginationInfo.where,
        method: 'get'
      },
      'intakeservicerequestpetition/clientcentriclegalactionhistory?filter'
    );
  }

}

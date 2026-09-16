import { Injectable } from '@angular/core';
import { GenericService } from '../../../../@core/services';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

@Injectable()
export class ContactNoteSummaryService {

  constructor(private _service: GenericService<any>) { }


  getContactNoteSummaryList(paginationInfo: PaginationInfo) {

    return this._service.getArrayList(
      {
        limit: paginationInfo.pageSize,
        page: paginationInfo.pageNumber,
        where: paginationInfo.where,
        method: 'get'
      },
      'Intakeservicerequestevaluations/listContactSummary?filter'
    );
  }

}

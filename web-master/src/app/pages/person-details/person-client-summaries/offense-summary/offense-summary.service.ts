import { Injectable } from '@angular/core';
import { GenericService } from '../../../../@core/services';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

@Injectable()
export class OffenseSummaryService {


  offenseSummaryList: any = null;
  constructor(private _service: GenericService<any>) { }


  getOffenseSummaryList(personid: any, paginationInfo: PaginationInfo) {
    const where = {
      personid: personid
    };
    return this._service.getArrayList(
      {
        limit: paginationInfo.pageSize,
        page: paginationInfo.pageNumber,
        where: where,
        method: 'get'
      },
      'Intakeservicerequestevaluations/listComplaintSummary?filter'
    );
  }

}

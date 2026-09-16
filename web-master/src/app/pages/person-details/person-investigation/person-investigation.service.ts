import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';
import { PaginationInfo } from '../../../@core/entities/common.entities';

@Injectable()
export class PersonInvestigationService {

  constructor(private _service: GenericService<any>) { }


  getInvestigationList(personid: string, paginationInfo: PaginationInfo) {
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
      'Intakeservicerequestevaluations/listContactSummary?filter'
    );
  }

}

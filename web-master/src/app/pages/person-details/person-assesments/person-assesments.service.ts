import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';

@Injectable()
export class PersonAssesmentsService {

  constructor(private _service: GenericService<any>) { }


  getAssesmentList(paginationInfo: PaginationInfo) {

    return this._service.getArrayList(
      {
        limit: paginationInfo.pageSize,
        page: paginationInfo.pageNumber,
        where: paginationInfo.where,
        count: -1,
        method: 'get'
      },
      CommonUrlConfig.EndPoint.PERSON.AssessmentListPerUser
    );
  }

}

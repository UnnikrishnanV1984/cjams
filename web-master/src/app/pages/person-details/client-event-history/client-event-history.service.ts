import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';
import { ClientEventHistory } from '../../../@core/common/models/involvedperson.data.model';
import { PaginationInfo } from '../../../@core/entities/common.entities';


@Injectable()
export class ClientEventHistoryService {

  constructor(private _service: GenericService<ClientEventHistory>) { }

  // /api/intakeservicerequestevaluations/listClientEventHistory?filter={"where":{"personid": "c1f3202b-9e38-45cb-9191-8922d6adf815","foldersearch":null,"statussearch":null},"page":1,"limit":10}
  getClientEventHistory(paginationInfo: PaginationInfo) {
    return this._service.getPagedArrayList(
      {
        limit: paginationInfo.pageSize,
        order: paginationInfo.sortBy,
        page: paginationInfo.pageNumber,
        count: paginationInfo.total,
        where: paginationInfo.where,
        method: 'get'
      },
      'Intakeservicerequestevaluations/listClientEventHistory?filter'
    );
  }

}

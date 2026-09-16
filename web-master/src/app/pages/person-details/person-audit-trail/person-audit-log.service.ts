import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';

@Injectable()
export class PersonAuditLogService {

  constructor(private _service: GenericService<any>) { }


  getAuditLogs(personid: any) {
    const where = {
      personid: personid
    };
    return this._service.getArrayList(
      {
        limit: 10,
        page: 1,
        where: where,
        method: 'get'
      },
      'People/listpersonauditlogs?filter'
    );
  }

}
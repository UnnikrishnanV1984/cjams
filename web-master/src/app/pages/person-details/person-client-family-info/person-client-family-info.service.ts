import { Injectable } from '@angular/core';
import { FamilyInfo } from '../../../@core/common/models/involvedperson.data.model';
import { Observable } from 'rxjs';
import { GenericService } from '../../../@core/services/generic.service';

@Injectable()
export class PersonClientFamilyInfoService {

  constructor(private _service: GenericService<any>) { }

  updateFamilyInfo(familyInfo: FamilyInfo): Observable<any> {
    return this._service.create(familyInfo, 'personfamilyinfo/addupdate');
  }

  getFamilyInfo(personid: string) {
    const where = {
      personid: personid,
      activeflag: 1
    };
    return this._service.getPagedArrayList(
      {
        limit: 1,
        page: 1,
        count: 1,
        where: where,
        method: 'get'
      },
      'personfamilyinfo/list?filter'
    );
  }

  getPrimarySourceOfIncomes(): Observable<any[]> {
    return this._service.getArrayList(
      {
        method: 'get',
        nolimit: true
      },
      'Personprimaryincometype/getvalues?filter'
    );
  }

}

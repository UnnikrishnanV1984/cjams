import { Injectable } from '@angular/core';
import { CommonHttpService, CommonDropdownsService } from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { Subject } from 'rxjs';

@Injectable()
export class PersonDisabilityService {

  person: any;
  public disability$ = new Subject<any>();
  constructor(
    private _commonHttpService: CommonHttpService,
    private _commonDropDownService: CommonDropdownsService
    ) {
  }

  createDisability(disabilityData: any) {
    disabilityData.disabilityflag = disabilityData.disabilityflag ? 1 : 0;
    return this._commonHttpService
      .create(disabilityData, 'persondisability/addupdate');
  }

  deleteDisability(personDisabilityID: any) {
    const data = { persondisabilityid: personDisabilityID };
    return this._commonHttpService
      .create(data, 'persondisability/delete');
  }

  getDisabilityTypes() {
    return this._commonDropDownService.getListByTableID('97');
  }

  getDisabilityConditions() {
    return this._commonDropDownService.getListByTableID('104');
  }

  getDisabilityList(personid: any, param?: any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: { personid: personid, startDate: param?.startDate, endDate: param?.endDate }
        }),
        'People/getpersondisability?filter'
      );
  }

  getDisabilityHistory(personid: any) {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: {
            personid: personid,
            status: 'Inactive'
          }
        }),
        'People/getpersondisability?filter'
      );
  }
}
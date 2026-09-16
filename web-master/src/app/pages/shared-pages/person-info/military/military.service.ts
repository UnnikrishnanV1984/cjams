
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { NavigationUtils } from '../../../_utils/navigation-utils.service';
import { Observable ,  Subject } from 'rxjs';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services';
import { PersonInfoService } from '../person-info.service';
import { Military } from '../../../admin/general/_entities/general.data.models';


@Injectable()
export class MilitaryService {

  personId: any;
  public militaryPersonType$ = new Observable<Military[]>();
  public isShowAddMilitary$ = new Subject<any>();
  public selectedMilitary$ = new Subject<any>();

  constructor(private _navigationUtils: NavigationUtils,
    private _commonHttpService: CommonHttpService,
    private _personService: PersonInfoService) {
      this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
  }


  saveMilitaryInfo(data:any) {
    return this._commonHttpService.create(data, 'personmilitaryservices/addupdate');
}

  getMilitaryList() {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: this.personId },
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        'personmilitaryservices/militarylist' + '?filter'
      ).pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0
        };
      }),share(),);
    this.militaryPersonType$ = source.pipe(pluck('data'));
  }

  isShowAddMilitaryEnabled(value:any) {
    this.isShowAddMilitary$.next(value);
  }

  getAddress(model:any) {
    this.selectedMilitary$.next(model);
  }
}

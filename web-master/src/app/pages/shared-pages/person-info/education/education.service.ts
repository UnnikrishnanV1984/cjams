
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { NavigationUtils } from '../../../_utils/navigation-utils.service';
import { Observable ,  Subject } from 'rxjs';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services';
import { PersonInfoService } from '../person-info.service';
import { Education } from '../../../admin/general/_entities/general.data.models';

@Injectable()
export class EducationInfoService {
  personId: any;
  public educationPersonType$ = new Observable<Education[]>();
  public isShowAddEducation$ = new Subject<any>();
  public selectedEducation$ = new Subject<any>();

  constructor(private _navigationUtils: NavigationUtils,
    private _commonHttpService: CommonHttpService,
    private _personService: PersonInfoService) {
      this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
  }

  saveEducationInfo(data:any) {
    return this._commonHttpService.create(data, 'personeducation/addupdate');
  }

  getEducationList() {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: this._personService.getPersonId() },
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        'personeducation/educationlist' + '?filter'
      ).pipe(map((result: any) => {
        // Handle personEducation, ensuring it's an array or defaulting to an empty array
        const personEducationList = Array.isArray(result.personEducation) 
          ? result.personEducation 
          : this.wrapResultInArray(result); // Wrap in an array if it's an object

        // Process each education record
        personEducationList.forEach((element: any) => {
          if (element.bidadded === 1 && element.bestdetermination && element.bestdetermination.bestDeterminationList) {
            let le = element.bestdetermination.bestDeterminationList.length;
            if (le > 0 && element.bestdetermination.bestDeterminationList[le-1].determinationvalue === 0) {
              element.startdate = null;
              element.enddate = null;
              element.statustypekey = null;
            }
          }
        });
        return {
          data: result,
          count: result.totalcount || 0 // Use totalcount if present, default to 0
        };
      }), share());

    this.educationPersonType$ = source.pipe(pluck('data'));
}

  private wrapResultInArray(result:any) {
        return (result.personEducation ? [result.personEducation] : []);
  }

  isShowAddEducationEnabled(value:any) {
    this.isShowAddEducation$.next(value);
  }

  getEducation(model:any) {
    this.selectedEducation$.next(model);
  }

}
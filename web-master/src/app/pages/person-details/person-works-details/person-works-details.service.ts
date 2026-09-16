
import {map, pluck, share} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Employer } from '../../../@core/common/models/involvedperson.data.model';
import { CommonHttpService } from '../../../@core/services';
import { HttpService } from '../../../@core/services/http.service';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { PaginationRequest } from '../../../@core/entities/common.entities';

@Injectable()
export class PersonWorksDetailsService {

  employer$  = new Observable<Employer[]>();

  constructor(private _commonHttpService: CommonHttpService,
    private _httpService: HttpService) { }

    addUpdateEmployer(employer: any) {
      return this._commonHttpService.create(employer, CommonUrlConfig.EndPoint.PERSON.WORK.AddUpdateEmployer);
    }

    getEmployerList(paginationRequest: PaginationRequest, pageinfosize: number) {
      const source = this._commonHttpService.getPagedArrayList(paginationRequest,
        CommonUrlConfig.EndPoint.PERSON.WORK.ListEmployer + '?filter'
      ).pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0,
          canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
        };
      }),share(),);
      this.employer$ = source.pipe(pluck('data'));
      return source;
    }

    getCarrerList(paginationRequest: PaginationRequest, pageinfosize: number) {
      return this._commonHttpService.getPagedArrayList(paginationRequest,
        CommonUrlConfig.EndPoint.PERSON.WORK.ListCarrer + '?filter'
      ).pipe(map((result: any) => {   // NOSONAR  
        return {        // below function has similar implemtation on line no 28 and it has only 3 lines hence marking it as No Sonar.
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0,
          canDisplayPager: result.length > 0 ? result[0].totalcount > pageinfosize : false
        };
      }),share(),);
    }

    deleteEmployer(employerid: any) {
      this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.WORK.DeleteEmployer;
      return this._commonHttpService.remove(employerid);
    }

    addUpdateCarrer(carrer: any) {
      return this._commonHttpService.create(carrer, CommonUrlConfig.EndPoint.PERSON.WORK.AddUpdateCarrer);
    }

}

import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { DataStoreService, CommonHttpService } from '../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../_entities/caseworker.data.constants';

@Injectable()
export class DsdsActionResolverService {
  constructor(private _dataStoreService: DataStoreService,  private _commonService: CommonHttpService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {  
    return this.getWorkLoad(this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID));
  }
  getWorkLoad (caseid: any) {   
    return this._commonService.getArrayList({where: { servicecaseid: caseid}, method: 'get'}, 'Caseassignments/getworkload?filter')
}

}
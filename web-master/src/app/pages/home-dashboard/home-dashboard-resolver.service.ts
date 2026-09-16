
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';
import { CommonHttpService } from '../../@core/services';
import { PaginationRequest } from '../../@core/entities/common.entities';
import { HomeDashboardUrlConfig } from './home-dashbaord.url.config';

@Injectable()
export class DashboardDataResolverService implements Resolve<any> {
  
  constructor( private _commonHttpService: CommonHttpService,) { }
  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    return this.getAllGridData();
  }

  getAllGridData() {
    return forkJoin([this.getServiceCase(),this.getAdoptionCase()]
        ).pipe(
      map(([serviceCaseRecord,adoptionCaseRecord]) => {
        
        let serviceCaseList = [];
        if (serviceCaseRecord) {
            serviceCaseList = serviceCaseRecord;
        }

        let adoptionCaseList = [];
        if (adoptionCaseRecord) {
            adoptionCaseList = adoptionCaseRecord;
        }
        
        return { 
                 serviceCaseData: serviceCaseList,
                 adoptionCaseData: adoptionCaseList
                };
      }));
  }

  getIROrAR(action: any) {
    var inputRequest = {actiontype : action}
    return  this._commonHttpService.getArrayList(
        new PaginationRequest({
            where: inputRequest,
            method: 'get',
            page: 1,
            limit: 10
        }),
        HomeDashboardUrlConfig.EndPoint.myDsdsActions.DSDSActionDetailsUrl + '?data'
    );
  }

  getServiceCase() {
    var inputRequest = {  actiontype: 'servicecase', status: 'Open' }
    return  this._commonHttpService.getArrayList(
        new PaginationRequest({
            where: inputRequest,
            method: 'get',
            page: 1,
            limit: 10
        }),
        HomeDashboardUrlConfig.EndPoint.myDsdsActions.DSDSServiceDetailsUrl + '?data'
    );
  }

  getAdoptionCase() {
    var inputRequest = {  actiontype: 'servicecase', status: 'All' }
    return  this._commonHttpService.getArrayList(
        new PaginationRequest({
            where: inputRequest,
            method: 'get',
            page: 1,
            limit: 10
        }),
        HomeDashboardUrlConfig.EndPoint.myDsdsActions.adoptioncaselist + '?data'
    );
  }


  
  


}
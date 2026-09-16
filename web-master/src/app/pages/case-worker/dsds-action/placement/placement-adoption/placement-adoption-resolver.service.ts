
import {of as observableOf,  Observable ,  forkJoin } from 'rxjs';

import {map, concatMap} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, RouterStateSnapshot, ActivatedRoute, Router } from '@angular/router';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { PlacementAdoptionService } from './placement-adoption.service';

@Injectable()
export class PlacementAdoptionResolverService {
  daNumber!: string;
  caseuid!: string;
  childId!: string;
  id!: string;
  constructor(private _authService: AuthService, private _commonHttpService: CommonHttpService, private _dataStoreService: DataStoreService,
    private route: ActivatedRoute, private _router: Router, private _placementAdoptionService: PlacementAdoptionService,
    private _session: SessionStorageService) {
  }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    this.childId = this._dataStoreService.getData('adoptedchildId');
    
    return forkJoin([this.getadoptiondata1(),this._authService.initAuthService('adoptionplanning')]).pipe(map((result) => {
      return {
       adoptiondata : result[0],
       authdetails : result[1]
      };
    }));
  }

  getAdoptionplanning(): Observable<any> {
    this.childId = this._dataStoreService.getData('adoptedchildId');
    
    return forkJoin([this.getadoptiondata1(),this._authService.initAuthService('adoptionplanning')]).pipe(map((result) => {
      return {
       adoptiondata : result[0],
       authdetails : result[1]
      };
    }));    
  }

  private getTprRecommendationList() {
    const caseuid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);

    return  this._commonHttpService
    .getSingle(
        new PaginationRequest({
            where: {
                intakeserviceid: caseuid,
                intakeservicerequestactorid: this.childId
            },
            method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.TprRecommendationList + '?filter'
    );
  }

  getAdoptionData() {
    const user = this._authService.getCurrentUser();
    if (user.role.name === 'apcs') {
      const transkey = this._session.getItem('transkey');
      const transid = this._session.getItem('transid');
      this._placementAdoptionService.getPermanencyPlanId(1, 100, transkey, transid).subscribe(data => {
        const permanencyPlanId = (data && data.length) ? data[0].permanencyplanid : null;
        this._placementAdoptionService.getPlacementConfig(1, 100, permanencyPlanId).subscribe(
          res => {
            if (res.length && res[0] && res[0].placements && res[0].placements.length) {
              const placement = res[0];
              this._dataStoreService.setData(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, placement['adoptionplanningid']);
              this._dataStoreService.setData(CASE_STORE_CONSTANTS.TPR_RECOMMENDATION_ID, placement['tprrecommendationid']);
              this._dataStoreService.setData(CASE_STORE_CONSTANTS.ADOPTION_AGREEMENT_ID, placement['adoptionagreementid']);
              this._dataStoreService.setData(CASE_STORE_CONSTANTS.PERMANENCY_PLAN_ID, placement['permanencyplanid']);
            }
          }
        );
      });
    }
  }
  getadoptiondata1() {
    const transkey = this._session.getItem('transkey');
    const transid = this._session.getItem('transid');
    if (transid && transkey) {
      return this._placementAdoptionService.getPermanencyPlanId(1, 100, transkey, transid).pipe(concatMap((data) => {
        const permanencyPlanId = (data && data.length) ? data[0].permanencyplanid : null;
        return this._placementAdoptionService.getPlacementConfig(1, 100, permanencyPlanId).pipe(concatMap(res=>{
          if (res.length && res[0] && res[0].placements && res[0].placements.length) {
            const placement = res[0];
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, placement['adoptionplanningid']);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.TPR_RECOMMENDATION_ID, placement['tprrecommendationid']);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.ADOPTION_AGREEMENT_ID, placement['adoptionagreementid']);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.PERMANENCY_PLAN_ID, placement['permanencyplanid']);
          }
          return observableOf(true);
        }));
      }));
    } else {
      return observableOf(null);
    }
  }
}

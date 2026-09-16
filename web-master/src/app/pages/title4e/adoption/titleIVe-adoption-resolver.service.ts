
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CommonHttpService, AuthService} from '../../../@core/services';
import { ActivatedRouteSnapshot, RouterStateSnapshot, ActivatedRoute } from '@angular/router';
import { Observable ,  forkJoin, of } from 'rxjs';

@Injectable()
export class AdoptionResolverService {

  constructor(private _commonHttpService: CommonHttpService, private activatedRoute: ActivatedRoute, private auth: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    return this.getAdoptionEligibilityInfo(route);
  }
  getAdoptionEligibilityInfo(route:any):Observable<any> {
    var client_id= route.params['clientid'];
    var removalid= route.params['removalId'];
    if (removalid && removalid !== 'null') {
        return forkJoin([this._commonHttpService.getAll(
            'iveadoption/adoption/adoption-eligibility-worksheet/' + client_id + '/' + removalid
        ), this.auth.initAuthService('iveadoption')]).pipe(map((result) => {
            return {
                adoptioneligibilitydata: result[0],
                userresources: result[1]
            };
        }));
    }
    return of(null);
}
}

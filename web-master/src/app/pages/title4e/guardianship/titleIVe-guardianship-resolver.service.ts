
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { CommonHttpService, AuthService } from '../../../@core/services';
import { Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';

@Injectable()
export class GuardianshipResolverService {

  constructor(private _commonHttpService: CommonHttpService, private router: Router,
     private auth: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    return this.getGapInfo(route);
  }

  getGapInfo(route:any) {
    var client_id=  route.params['clientid'];
    var removalId=  route.params['removalId'];
    return forkJoin([this._commonHttpService.getAll(
            'ivegap/gap/gap-eligibility-worksheet/' + client_id + '/' + removalId
            ),
           this.auth.initAuthService('ivegap') ]).pipe(map((result) => {
          return {
            gapeligibilityworksheet: result[0],
            userresources: result[1]
          };
        }));

}
}

import {forkJoin as observableForkJoin,  Observable } from 'rxjs';

import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { ServiceCasePlacementsService } from './service-case-placements.service';
import { AuthService } from '../../../../@core/services';

@Injectable()
export class ServiceCasePlacementsResolverService implements Resolve<any> {

  constructor(private _service: ServiceCasePlacementsService,private auth: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
   return observableForkJoin([
    this._service.getChildRemovalInfoAndPlacements(),
    this.auth.initAuthService('placement')
  ]).pipe(map((result) => {
    return {
     childremovainfo : result[0],
     authdetails : result[1]
      };
    }))   
  }
 
}

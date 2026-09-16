
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { ChildRemovalService } from './child-removal.service';
import { Observable ,  forkJoin } from 'rxjs';
import { AuthService } from '../../../../@core/services';

@Injectable()
export class ChildRemovalResolverService implements Resolve<any> {

  constructor(private _service: ChildRemovalService, private auth: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    return forkJoin([this._service.getPersonsAndChildRemovalInfo(),
      this.auth.initAuthService('childremoval')]).pipe(map((result) => {
        return {
         childremovainfo : result[0],
         authdetails : result[1]
        };
      }))
  }

  getChildRemoval(): Observable<any> {
    return forkJoin([this._service.getPersonsAndChildRemovalInfo(),
      this.auth.initAuthService('childremoval')]).pipe(map((result) => {
        return {
         childremovainfo : result[0],
         authdetails : result[1]
        };
      }))
  }
}

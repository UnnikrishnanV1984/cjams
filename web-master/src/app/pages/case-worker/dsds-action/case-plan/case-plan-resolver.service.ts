import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { CasePlanService } from './case-plan.service';
import { Observable } from 'rxjs';

@Injectable()
export class CasePlanResolverService implements Resolve<any> {

  constructor(private _service: CasePlanService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {

    return this._service.getPersonsAndChildRemovalInfo();
  }
}

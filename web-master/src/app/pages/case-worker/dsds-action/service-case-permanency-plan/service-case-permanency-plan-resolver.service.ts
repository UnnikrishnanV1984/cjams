import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { ServiceCasePermanencyPlanService } from './service-case-permanency-plan.service';

@Injectable()
export class ServiceCasePermanencyPlanResolverService implements Resolve<any> {

  constructor(private _service: ServiceCasePermanencyPlanService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {

    return this._service.getChildRemovalInfoAndPlacements();
  }
}

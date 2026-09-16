import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { CompliantDetailsService } from './compliant-details.service';
import { Observable } from 'rxjs';

@Injectable()
export class CompliantDetailsResolverService implements Resolve<any> {

  constructor(private _service: CompliantDetailsService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any>  {
    const complaintid: any = route.paramMap.get('complaintid');
    return this._service.getComplaintDetails(complaintid);
  }

}

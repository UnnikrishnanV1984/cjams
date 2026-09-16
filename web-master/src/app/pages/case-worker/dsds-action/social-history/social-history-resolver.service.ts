import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { SocialHistoryService } from './social-history.service';
import { Observable } from 'rxjs';

@Injectable()
export class SocialHistoryResolverService implements Resolve<any> {

  constructor(private _service: SocialHistoryService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {

    return this._service.getPersonsAndChildRemovalInfo();
  }
}

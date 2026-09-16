import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { AuthService } from '../../../../@core/services';
@Injectable()
export class CWAssignmentResolverService {

  constructor(private auth: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any>{
    return this.auth.initAuthService('assignment');     
  }

  getAssignment(): Observable<any> {
    return this.auth.initAuthService('assignment'); 
  }

}
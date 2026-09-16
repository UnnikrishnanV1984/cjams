import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { AuthService } from '../../@core/services/auth.service';


@Injectable()
export class FinanceResolverService {

  constructor(private auth: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any>{
    return this.auth.initAuthService('finance');     
  }

  getFinance(): Observable<any> {
    return this.auth.initAuthService('finance');      
  }

}
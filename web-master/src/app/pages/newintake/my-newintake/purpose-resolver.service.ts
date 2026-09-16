import { Injectable } from '@angular/core';
import { CommonHttpService, AuthService } from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { NewUrlConfig } from '../newintake-url.config';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { IntakePurpose } from './_entities/newintakeModel';

@Injectable()
export class PurposeResolverService implements Resolve<IntakePurpose[]> {

  constructor(private _commonHttpService: CommonHttpService,
    private _authService: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<IntakePurpose[]> {

    return this.getPurposeList();
  }

  getPurpose(): Observable<IntakePurpose[]> {
    return this.getPurposeList();    
  }

  getPurposeList() {
    const checkInput = {
      nolimit: true,
      where: { teamtypekey: this._authService.getAgencyName() },
      method: 'get',
      order: 'description'
    };
    return this._commonHttpService.getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.IntakePurposes + '/list?filter');
  }

}

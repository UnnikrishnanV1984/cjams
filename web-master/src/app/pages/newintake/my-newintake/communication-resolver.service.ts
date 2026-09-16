import { Injectable } from '@angular/core';
import { CommonHttpService, AuthService } from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { NewUrlConfig } from '../newintake-url.config';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { IntakeCommunication } from './_entities/newintakeModel';

@Injectable()
export class CommunicationResolverService implements Resolve<IntakeCommunication[]> {

  constructor(private _commonHttpService: CommonHttpService,
    private _authService: AuthService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<IntakeCommunication[]> {

    return this.getCommunicationList();
  }

  getCommunicationList() {
    const checkInput = {
      nolimit: true,
      where: { teamtypekey: this._authService.getAgencyName() },
      method: 'get',
      order: 'description'
    };
    return this._commonHttpService.getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.IntakeCommunications + '/list?filter');
  }

}

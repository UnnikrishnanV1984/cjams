import { Injectable } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { Subject } from 'rxjs';
import { RoutingUser } from '../../provider-applicant/new-applicant/_entities/existingreferralModel';

@Injectable()
export class RouteUserService {

  public selectedUserOnAssign$ = new Subject<RoutingUser>();
  constructor(private _commonHttpService: CommonHttpService) { }

  public getRoutingUsersList(appevent: string) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: appevent },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      );
  }

  broardCastSelectedUsers(user: RoutingUser) {
    this.selectedUserOnAssign$.next(user);
  }

}

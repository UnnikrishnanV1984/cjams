import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { DataStoreService, CommonHttpService } from '../../../../@core/services';
import { IntakeStoreConstants } from '../my-newintake.constants';
import { PaginationRequest } from '../../../../@core/entities/common.entities';

@Injectable()
export class IntakeDecisionResolverService implements Resolve<any> {
  id!: string;
  constructor(private _dataStoreService: DataStoreService, private _commonHttpService: CommonHttpService) {

  }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    this.id = this._dataStoreService.getData(IntakeStoreConstants.intakenumber);
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          nolimit: true,
          where: {
            intakeservicerequesttypeid: '',
            intakeservicerequestsubtypeid: '',
            agencycode: 'DJS',
            intakenumber: this.id,
            target: 'Intake'
          },
          method: 'get'
        }),
        'admin/assessmenttemplate/getintakeassessment?filter'
      );
  }
}

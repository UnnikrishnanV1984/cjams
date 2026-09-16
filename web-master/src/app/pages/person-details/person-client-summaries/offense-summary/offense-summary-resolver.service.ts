import { Injectable } from '@angular/core';
import { OffenseSummaryService } from './offense-summary.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

@Injectable()
export class OffenseSummaryResolverService {

  constructor(private _service: OffenseSummaryService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const personid =  route.parent?.parent?.parent?.paramMap.get('personid');
    return this._service.getOffenseSummaryList(personid, new PaginationInfo());
  }

}

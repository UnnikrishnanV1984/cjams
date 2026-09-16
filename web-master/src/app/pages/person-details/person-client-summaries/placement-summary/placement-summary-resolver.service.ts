import { Injectable } from '@angular/core';
import { PlacementSummaryService } from './placement-summary.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { PersonDetailsService } from '../../person-details.service';

@Injectable()
export class PlacementSummaryResolverService {

  constructor(private _service: PlacementSummaryService, private personService: PersonDetailsService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const personid =  route.parent?.parent?.parent?.paramMap.get('personid');
    const personstatus = this.personService.personStatus;
    const paginationInfo = new PaginationInfo();
    paginationInfo.where = { personid: personid, personstatus: personstatus };
    return this._service.getPlacementSummaryList('all', paginationInfo);
  }

}

import { Injectable } from '@angular/core';
import { ReviewSummaryService } from './review-summary.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { PersonDetailsService } from '../../person-details.service';

@Injectable()
export class ReviewSummaryResolverService {

  constructor(private _service: ReviewSummaryService, private personService: PersonDetailsService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const personid = route.parent?.parent?.parent?.paramMap.get('personid');
    const personstatus = this.personService.personStatus;
    const paginationInfo = new PaginationInfo();
    paginationInfo.where = { personid: personid, personstatus: personstatus };
    return this._service.getReviewSummaryList(paginationInfo);
  }

}

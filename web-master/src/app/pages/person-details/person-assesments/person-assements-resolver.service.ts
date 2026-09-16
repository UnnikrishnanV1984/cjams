import { Injectable } from '@angular/core';
import { PersonAssesmentsService } from './person-assesments.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { PersonDetailsService } from '../person-details.service';

@Injectable()
export class PersonAssementsResolverService {

  constructor(private _service: PersonAssesmentsService, private _personService: PersonDetailsService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const personid = route.parent?.parent?.paramMap.get('personid');
    const personStatus = this._personService.personStatus;
    const paginationInfo = new PaginationInfo();
    paginationInfo.where = {
      personid: personid, personstatus: personStatus, agencycode: 'DJS',
      intakeservicerequesttypeid: '', intakeservicerequestsubtypeid: '',
      target: 'Intake'
    };
    return this._service.getAssesmentList(paginationInfo);
  }

}

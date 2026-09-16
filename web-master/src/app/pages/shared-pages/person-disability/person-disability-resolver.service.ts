import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { PersonBasicDetail } from '../../../@core/common/models/involvedperson.data.model';
import { PersonDetailsService } from '../../person-details/person-details.service';
import { Observable } from 'rxjs';

@Injectable()
export class PersonDisabilityResolverService implements Resolve<PersonBasicDetail> {

  constructor(private _service: PersonDetailsService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<PersonBasicDetail> {
    const personid = route.paramMap.get('personid');
    this._service.personid = personid;
    return this._service.getPersonDetails(personid);
  }
}

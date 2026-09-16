import { Injectable } from '@angular/core';
import {
  Resolve,
  RouterStateSnapshot,
  ActivatedRouteSnapshot
} from '@angular/router';
import { Observable } from 'rxjs';
import { RelationshipService } from './relationship.service';
import { PersonRelation } from '../../../@core/common/models/involvedperson.data.model';

@Injectable()
export class RelationshipResolverService implements Resolve<PersonRelation[]> {

  constructor(private _service: RelationshipService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<PersonRelation[]>  {
    const personid = route.parent?.parent?.parent?.paramMap.get('personid');
    return this._service.getPersonRelations(personid);
  }

}

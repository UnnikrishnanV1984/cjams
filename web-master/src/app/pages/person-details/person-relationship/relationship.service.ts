import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';
import { Observable } from 'rxjs';
import { PersonRelation } from '../../../@core/common/models/involvedperson.data.model';
import { PersonDetailsService } from '../person-details.service';

@Injectable()
export class RelationshipService {

  private _relativePersons: PersonRelation[] = [];
  constructor(private _service: GenericService<PersonRelation>, private personService: PersonDetailsService) { }

  getPersonRelations(personid: any): Observable<PersonRelation[]> {
    return this._service
      .getAll('People/getpersonrelations?filter={"where":{"personid":"' + personid + '"}}');
  }

  set relativePersons(relativePersons: PersonRelation[]) {
    this._relativePersons = relativePersons;
  }

  get relativePersons(): PersonRelation[] {
    return this._relativePersons;
  }

  addRelation(relation: PersonRelation) {
    return this._service.create(relation, 'People/addrelation');
  }

  updateRelation(personRelation: PersonRelation) {
    return this._service.patchWithoutid(personRelation, 'People/updaterelation');
  }

  deleteRelation(personrelationid: string) {
    const relation = { personrelationid: personrelationid };
    return this._service.patchWithoutid(relation, 'People/deleterelation');
  }







}

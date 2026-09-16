import { Injectable } from '@angular/core';
import { GenericService } from '../../../../@core/services';
import { SubstanceAbuse } from '../../../../@core/common/models/involvedperson.data.model';
import { PersonDetailsService } from '../../person-details.service';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { Observable } from 'rxjs';

@Injectable()
export class SubstanceAbuseService {

  constructor(private _service: GenericService<SubstanceAbuse>,
    private _personDetailService: PersonDetailsService) { }

  getSubstanceAbuseDetails(): Observable<SubstanceAbuse[]> {
    return this._service.getArrayList({
      where: {
        personid: this._personDetailService.person.personid
      },
      page: 1,
      limit: 10,
      method: 'get'
    }, CommonUrlConfig.EndPoint.PERSON.MEDICAL.personabuseList);
  }

  saveOrUpdateSubstanceAbuse(substanceAbuse: any) {
    substanceAbuse.personid = this._personDetailService.person.personid;
    return this._service.create(substanceAbuse, CommonUrlConfig.EndPoint.PERSON.MEDICAL.personabuseAddUpdate);
  }
}

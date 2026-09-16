import { Injectable } from '@angular/core';
import { PersonDocumentsService } from './person-documents.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { PersonDetailsService } from '../person-details.service';

@Injectable()
export class PersonDocumentsResolverService {

  constructor(private _service: PersonDocumentsService, private _personService: PersonDetailsService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const personid = route.parent?.parent?.paramMap.get('personid');
    const personStatus = this._personService.personStatus;
    const paginationInfo = new PaginationInfo();
    paginationInfo.where = {
      personid: personid,
      foldersearch: null, statussearch: null, personstatus: personStatus
    };
    return this._service.getDocumentsList(paginationInfo);
  }

}

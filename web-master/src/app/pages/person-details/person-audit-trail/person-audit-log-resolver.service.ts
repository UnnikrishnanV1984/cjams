import { Injectable } from '@angular/core';
import { PersonAuditLogService } from './person-audit-log.service';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable()
export class PersonAuditLogResolverService {

  constructor(private _service: PersonAuditLogService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const personid =  route.parent?.parent?.paramMap.get('personid');
    return this._service.getAuditLogs(personid);
  }

}

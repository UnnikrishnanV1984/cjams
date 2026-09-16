import { Injectable } from '@angular/core';
import { ClientAppointmentsService } from './client-appointments.service';
import { Observable } from 'rxjs';
import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';

@Injectable()
export class ClientAppointmentsResolverService {

  constructor(private _service: ClientAppointmentsService) { }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<any> {
    const personid =  route.parent?.parent?.paramMap.get('personid');
    return this._service.getappointmentList(personid);
  }

}

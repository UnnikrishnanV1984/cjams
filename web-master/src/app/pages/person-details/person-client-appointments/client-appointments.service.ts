import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';

@Injectable()
export class ClientAppointmentsService {

  appointmentList: any = null;
  constructor(private _service: GenericService<any>) { }

  getappointmentList(personid: any) {
    const where = {
      personid: personid
    };
    return this._service.getArrayList(
      {
        limit: 20,
        page: 1,
        count: 1,
        where: where,
        method: 'get'
      },
      'servicerequestappointment/personappointmentlist?filter'
    );
  }

}

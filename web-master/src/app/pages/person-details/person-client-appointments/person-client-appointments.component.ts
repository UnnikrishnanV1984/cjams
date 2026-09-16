import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ClientAppointmentsService } from './client-appointments.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-client-appointments',
    templateUrl: './person-client-appointments.component.html',
    styleUrls: ['./person-client-appointments.component.scss'],
    standalone: false
})
export class PersonClientAppointmentsComponent {

  appointments: any[] = [];
  totalRecords: any;
  completionNotes = null;
  constructor(private router: Router,
    private route: ActivatedRoute,
    private _service: ClientAppointmentsService) {
    this.route.data.subscribe(response => {
      this.appointments = response.appointmentList;
    });
  }

  openAppointmentComments(appointment: any) {
    this.completionNotes = appointment.notes;
  }
  routeToCase(item: any) {
    const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/appointment';
    this.router.navigate([currentUrl]);
  }

}

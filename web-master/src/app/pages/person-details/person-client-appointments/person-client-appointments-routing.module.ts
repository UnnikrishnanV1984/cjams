import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonClientAppointmentsComponent } from './person-client-appointments.component';
import { ClientAppointmentsResolverService } from './client-appointments-resolver.service';

const routes: Routes = [
  {
    path: '',
    component: PersonClientAppointmentsComponent,
    resolve: {
      appointmentList: ClientAppointmentsResolverService
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonClientAppointmentsRoutingModule { }

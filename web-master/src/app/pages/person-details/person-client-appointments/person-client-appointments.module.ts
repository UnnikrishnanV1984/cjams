import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule} from '@angular/forms';
import { QuillModule } from 'ngx-quill';
import { PersonClientAppointmentsRoutingModule } from './person-client-appointments-routing.module';
import { PersonClientAppointmentsComponent } from './person-client-appointments.component';
import { ClientAppointmentsService } from './client-appointments.service';
import { ClientAppointmentsResolverService } from './client-appointments-resolver.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    QuillModule.forRoot(),
    PersonClientAppointmentsRoutingModule,
    PaginationModule
  ],
  declarations: [PersonClientAppointmentsComponent],
  providers: [ClientAppointmentsService, ClientAppointmentsResolverService]
})
export class PersonClientAppointmentsModule { }

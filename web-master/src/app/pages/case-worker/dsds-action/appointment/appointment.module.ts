import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AppointmentComponent } from './appointment.component';
import { AppointmentRoutingModule } from './appointment-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
@NgModule({
  imports: [
    CommonModule,
    AppointmentRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    PaginationModule
  ],
  declarations: [
    AppointmentComponent
  ],
  providers: []
})
export class AppointmentModule { }

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ServiceFosterCareComponent } from './service-foster-care.component';
import { ServiceFosterCareRoutingModule } from './service-foster-care-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
@NgModule({
  imports: [
    CommonModule,
    ServiceFosterCareRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
  ],
  declarations: [
    ServiceFosterCareComponent
  ],
  providers: []
})
export class ServiceFosterCareModule { }

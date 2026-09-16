import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { VendorPayFileCalendarRoutingModule } from './vendor-pay-file-calendar-routing.module';
import { VendorPayFileCalendarComponent } from './vendor-pay-file-calendar.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    VendorPayFileCalendarRoutingModule,
    FormMaterialModule,
    SharedPipesModule
  ],
  declarations: [VendorPayFileCalendarComponent]
})
export class VendorPayFileCalendarModule { }

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PaymentScheduleRoutingModule } from './payment-schedule-routing.module';
import { PaymentScheduleComponent } from './payment-schedule.component';

import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { PaymentScheduleService } from './payment-schedule.service';
import { PaymentScheduleDocumentComponent } from './payment-schedule-document/payment-schedule-document.component';
import { DocumentsModule } from '../documents/documents.module';
import { PaymentSlipDocumentComponent } from './payment-slip-document/payment-slip-document.component';
import { IntakeUtils } from '../../_utils/intake-utils.service';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    PaymentScheduleRoutingModule,
    PaginationModule,
    DocumentsModule
  ],
  declarations: [PaymentScheduleComponent, PaymentScheduleDocumentComponent, PaymentSlipDocumentComponent],
  exports: [PaymentScheduleComponent],
  providers: [PaymentScheduleService, IntakeUtils]
})
export class PaymentScheduleModule { }

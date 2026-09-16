import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PaymentScheduleComponent } from './payment-schedule.component';
import { PaymentScheduleDocumentComponent } from './payment-schedule-document/payment-schedule-document.component';
import { PaymentSlipDocumentComponent } from './payment-slip-document/payment-slip-document.component';

const routes: Routes = [{
  path: '',
  component: PaymentScheduleComponent,
  children: [
    {
      path: 'payment-schedule-document',
      component: PaymentScheduleDocumentComponent
    },
    {
      path: 'payment-slip-document',
      component: PaymentSlipDocumentComponent
    }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PaymentScheduleRoutingModule { }

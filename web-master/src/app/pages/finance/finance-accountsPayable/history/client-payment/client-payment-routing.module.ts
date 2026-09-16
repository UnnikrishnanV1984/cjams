import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ClientPaymentComponent } from './client-payment.component';
import { ClientPaymentResultComponent } from './client-payment-result/client-payment-result.component';
import { ClientPaymentDetailsComponent } from './client-payment-details/client-payment-details.component';

const routes: Routes = [
  {
    path: '',
    component: ClientPaymentComponent,
    children: [
      {
        path: 'search',
        component: ClientPaymentResultComponent
      },
      {
        path: 'details',
        component: ClientPaymentDetailsComponent
      },
      {
        path: '**',
        redirectTo: 'search'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ClientPaymentRoutingModule { }

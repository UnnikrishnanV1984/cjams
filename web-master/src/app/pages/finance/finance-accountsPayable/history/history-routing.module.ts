import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HistoryComponent } from './history.component';
import { PaymentHistoryReportComponent } from './payment-history-report/payment-history-report.component';

const routes: Routes = [
  {
    path: '',
    component: HistoryComponent,
    children: [
      {
        path: 'funding-source-allocation',
        loadChildren: () => import( './funding-source-allocation/funding-source-allocation.module').then(m => m.FundingSourceAllocationModule)
      },
      {
        path: 'client-payment',
        loadChildren: () => import( './client-payment/client-payment.module').then(m => m.ClientPaymentModule)
      },
      {
        path: 'payment-report',
        component: PaymentHistoryReportComponent
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
export class HistoryRoutingModule { }

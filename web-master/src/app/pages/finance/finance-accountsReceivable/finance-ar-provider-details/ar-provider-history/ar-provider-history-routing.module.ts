import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ArProviderHistoryComponent } from './ar-provider-history.component';
import { OffsetReceiptComponent } from './offset-receipt/offset-receipt.component';
import { HistoryOverpaymentsComponent } from './history-overpayments/history-overpayments.component';

const routes: Routes = [
  {
    path: '',
    component: ArProviderHistoryComponent,
    children: [
      {
        path: 'overpayments',
        component: HistoryOverpaymentsComponent
      },
      {
        path: 'receipt/:receivabledetailid',
        component: OffsetReceiptComponent
      },
      {
        path: '**',
        redirectTo: 'overpayments'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ArProviderHistoryRoutingModule { }

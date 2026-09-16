import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProviderPaymentMgmtComponent } from './provider-payment-management.component';

const routes: Routes = [
  {
    path: '',
    component: ProviderPaymentMgmtComponent,
    children: [
      {
        path: '',
        redirectTo: 'cfe-payment',
        pathMatch: 'full'
      },
      {
        path: 'cfe-payment',
        loadChildren: () => import('./cfe-payment/cfe-payment.module').then(m => m.CfePaymentModule)
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProviderPaymentMgmtRoutingModule { }

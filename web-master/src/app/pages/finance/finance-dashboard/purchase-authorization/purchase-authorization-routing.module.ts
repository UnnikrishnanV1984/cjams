import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PurchaseAuthorizationComponent } from './purchase-authorization.component';

const routes: Routes = [
  {
    path: '',
    component: PurchaseAuthorizationComponent,
    /* children: [
      {
        path: 'funding-purchase-authorization',
        component: FundingPurchaseAuthorizationComponent
      },
      {
        path: 'payment-purchase-authorization',
        component: PaymentPurchaseAuthorizationComponent
      },
      {
        path: '**',
        redirectTo: 'funding-purchase-authorization'
      }
    ]*/
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PurchaseAuthorizationRoutingModule { }

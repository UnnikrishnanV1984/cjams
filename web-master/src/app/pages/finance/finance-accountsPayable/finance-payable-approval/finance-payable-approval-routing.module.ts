import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinancePayableApprovalComponent } from './finance-payable-approval.component';
import { FinancialApprovalComponent } from './financial-approval/financial-approval.component';
import { PaymentApprovalComponent } from './payment-approval/payment-approval.component';
import { DirectorApprovalComponent } from './director-approval/director-approval.component';

const routes: Routes = [
  {
    path: '',
    component: FinancePayableApprovalComponent,
    children: [
      {
        path: 'financial',
        component: FinancialApprovalComponent
      },
      {
        path: 'payment',
        component: PaymentApprovalComponent
      },
      {
        path: 'director',
        component: DirectorApprovalComponent
      },
      {
        path: '**',
        redirectTo: 'financial'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinancePayableApprovalRoutingModule { }

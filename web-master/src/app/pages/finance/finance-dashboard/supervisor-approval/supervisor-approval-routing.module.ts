import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SupervisorApprovalComponent } from './supervisor-approval.component';

const routes: Routes = [
  {
    path: '',
    component: SupervisorApprovalComponent,
    /*children: [
      {
        path: 'funding-disbursement',
        component: FundingDisbursementComponent
      },
      {
        path: 'payment-disbursement',
        component: PaymentDisbursementComponent
      },
      {
        path: '**',
        redirectTo: 'funding-disbursement'
      }
    ]*/
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SupervisorApprovalRoutingModule { }

import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ChildAccountsTabComponent } from './child-accounts/child-accounts.component';
import { InterestTransactionsComponent } from './interest-transactions/interest-transactions.component';
import { CostReimbursementComponent } from './cost-reimbursement/cost-reimbursement.component';
import { ChildAccountsComponent } from './child-accounts.component';

const routes: Routes = [
  {
      path: '',
      component: ChildAccountsComponent,
      children: [
        {
          path: '', redirectTo: "child-accounts", pathMatch: 'full'
        },
        {
          path: 'child-accounts',
          component: ChildAccountsTabComponent,
        },
        {
          path: 'child-accounts/:id',
          component: ChildAccountsTabComponent,
        },
        {
          path: 'interest-transactions',
          component: InterestTransactionsComponent,
        },
        {
          path: 'cost-reimbursement',
          component: CostReimbursementComponent,
        }
      ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ChildAccountsRoutingModule { }

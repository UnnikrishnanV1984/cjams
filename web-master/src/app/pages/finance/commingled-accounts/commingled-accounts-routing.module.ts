import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CommingledAccountsTabComponent } from './commingled-accounts/commingled-accounts.component';
import { InterestTransactionsComponent } from './interest-transactions/interest-transactions.component';
import { CommingledAccountsComponent } from './commingled-accounts.component';

const routes: Routes = [
  {
    path: '',
    component: CommingledAccountsComponent,
    children: [
      {
        path: '', redirectTo: "commingled-accounts", pathMatch: 'full'
      },
      {
        path: 'commingled-accounts',
        component: CommingledAccountsTabComponent,
      },
      {
        path: 'interest-transactions',
        component: InterestTransactionsComponent,
      }]
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CommingledAccountsRoutingModule { }

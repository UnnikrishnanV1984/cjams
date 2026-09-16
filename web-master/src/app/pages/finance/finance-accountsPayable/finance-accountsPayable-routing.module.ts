import { RoleGuard } from '../../../@core/guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceAccountsPayableComponent } from './finance-accountsPayable.component';
import { FinanceAccountsPayableSearchViewComponent } from './finance-accountsPayable-search-view/finance-accountsPayable-search-view.component';

const routes: Routes = [
  {
    path: '',
    component: FinanceAccountsPayableComponent,
    canActivate: [RoleGuard],
    children: [
      { path: 'showFinanceAccountsPayableDetails/:id', component: FinanceAccountsPayableSearchViewComponent }
    ],
    data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
  },
  {
    path: 'ancillary',
    loadChildren: () => import( './payable-ancillary/payable-ancillary.module').then(m => m.PayableAncillaryModule)
  },
  {
    path: 'history',
    loadChildren: () => import( './history/history.module').then(m => m.HistoryModule)
  },
  {
    path: 'approval',
    loadChildren: () => import( './finance-payable-approval/finance-payable-approval.module').then(m => m.FinancePayableApprovalModule)
    // './finance-payable-approval/finance-payable-approval.module').then(m => m.FinancePayableApprovalModule'
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceAccountsPayableRoutingModule { }

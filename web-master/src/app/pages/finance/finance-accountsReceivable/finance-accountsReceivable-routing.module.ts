import { RoleGuard } from '../../../@core/guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceAccountsReceivableComponent } from './finance-accountsReceivable.component';
import { FinanceAccountsReceivableSearchResultComponent } from './finance-accountsReceivable-search-result/finance-accountsReceivable-search-result.component';

const routes: Routes = [
  {
    path: '',
    component: FinanceAccountsReceivableComponent,
    canActivate: [RoleGuard],
    children: [
      // { path: 'showFinanceAccountsPayableDetails/:id', component: FinanceAccountsReceivableSearchViewComponent }
      { path: 'search-result', component: FinanceAccountsReceivableSearchResultComponent },
      { path: 'provider/:providerid', loadChildren: () => import( './finance-ar-provider-details/finance-ar-provider-details.module').then(m => m.FinanceArProviderDetailsModule) },
      { path: '**', redirectTo: 'search-result' }
    ],
    data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceAccountsReceivableRoutingModule { }

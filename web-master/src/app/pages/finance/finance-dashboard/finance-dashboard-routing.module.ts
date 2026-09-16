import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceDashboardComponent } from './finance-dashboard.component';
import { RoleGuard } from '../../../@core/guard';

const routes: Routes = [{
  path: '',
  canActivate: [RoleGuard],
  component: FinanceDashboardComponent,
  children: [
    {
      path: 'finance-dashboard',
      component: FinanceDashboardComponent
    },
   /* {
      path: 'conserved-ac-balance-alert',
      component: ConservedAcBalanceAlertComponent
    },
    {
      path: 'director-approval',
      component: DirectorApprovalComponent
    },
    {
      path: 'supervisor-approval',
      loadChildren: () => import( './supervisor-approval/supervisor-approval.module#SupervisorApprovalModule'
    },
    {
      path: 'purchase-authorization',
      loadChildren: () => import( './purchase-authorization/purchase-authorization.module#PurchaseAuthorizationModule'
    },
    {
      path: 'commingled-transaction-approval',
      component: CommingledTransactionApprovalComponent
    },
    {
      path: 'ancillary-adjustment',
      component: AncillaryPaymentAdjustmentComponent
    },
    {
      path: '**',
      redirectTo: 'writeoff-approval'
    }*/],
    data: {
      title: ['Finance Module'],
      desc: 'Maryland department of human services',
      screen: { current: 'case-worker', key: 'finance-module', includeMenus: true, modules: [], skip: false }
     }
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceDashboardRoutingModule { }

import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceComponent } from './finance.component';
import { RoleGuard } from '../../@core/guard';
import { FinanceResolverService } from './finance-resolver-service';

const routes: Routes = [
    {
        path: '',
        component: FinanceComponent,
        // resolve: {
        //     result: FinanceResolverService
        //   },
        canActivate: [RoleGuard],
        children: [
            { path: 'finance-dashboard', loadChildren: () => import( './finance-dashboard/finance-dashboard.module').then(m => m.FinanceDashboardModule) },
            { path: 'finance-accountsPayable', loadChildren: () => import( './finance-accountsPayable/finance-accountsPayable.module').then(m => m.FinanceAccountsPayableModule) },
            { path: 'finance-accountsReceivable', loadChildren: () => import( './finance-accountsReceivable/finance-accountsReceivable.module').then(m => m.FinanceAccountsReceivableModule) },
            { path: 'finance-adjustment', loadChildren: () => import( './finance-adjustment/finance-adjustment.module').then(m => m.FinanceAdjustmentModule) },
            { path: 'finance-placement', loadChildren: () => import( './finance-placement/finance-placement.module').then(m => m.FinancePlacementModule) },
            { path: 'finance-guardianship', loadChildren: () => import( './finance-guardianship/finance-guardianship.module').then(m => m.FinanceGuardianshipModule) },
            { path: 'finance-adoption', loadChildren: () => import( './finance-adoption/finance-adoption.module').then(m => m.FinanceAdoptionModule) },
            { path: 'child-accounts', loadChildren: () => import( './child-accounts/child-accounts.module').then(m => m.ChildAccountsModule) },
            { path: 'commingled-accounts', loadChildren: () => import( './commingled-accounts/commingled-accounts.module').then(m => m.CommingledAccountsModule) },
            { path: 'receipt-fast-entry', loadChildren: () => import( './receipt-fast-entry/receipt-fast-entry.module').then(m => m.ReceiptFastEntryModule) },
            { path: 'ssi-ssa-tracking', loadChildren: () => import( './ssi-ssa-tracking/ssi-ssa-tracking.module').then(m => m.SsiSsaTrackingModule) },
            { path: 'finance-foster-care-rate', loadChildren: () => import( './finance-foster-care-rate/finance-foster-care-rate.module').then(m => m.FinanceFosterCareRateModule) },
            { path: 'funding-allocation', loadChildren: () => import( './finance-accountsPayable/history/funding-source-allocation/funding-source-allocation.module').then(m => m.FundingSourceAllocationModule) },
            { path: 'reference', loadChildren: () => import( './reference/reference.module').then(m => m.ReferenceModule) },
            { path: 'provider-checklist', loadChildren: () => import( './reference/provider-checklist/provider-checklist.module').then(m => m.ProviderChecklistModule) },
            { path: 'vendor-pay-file-calendar', loadChildren: () => import( './vendor-pay-file-calendar/vendor-pay-file-calendar.module').then(m => m.VendorPayFileCalendarModule)},
            { path: 'finance-provider-contract-rate', loadChildren: () => import( './finance-provider-contract-rate/finance-provider-contract-rate.module').then(m => m.FinanceProviderContractRateModule) },
            { path: '**', redirectTo: 'finance-dashboard' }
        ],
        data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class FinanceRoutingModule { }
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceArProviderDetailsComponent } from './finance-ar-provider-details.component';
import { ArProviderComponent } from './ar-provider/ar-provider.component';
import { ArProviderOverpaymentsComponent } from './ar-provider-overpayments/ar-provider-overpayments.component';
import { ArProviderPaymentPlanComponent } from './ar-provider-payment-plan/ar-provider-payment-plan.component';
import { ArProviderDocumentsComponent } from './ar-provider-documents/ar-provider-documents.component';

const routes: Routes = [
  {
    path: '',
    component: FinanceArProviderDetailsComponent,
    children: [
      {
        path: 'details',
        component: ArProviderComponent
      },
      {
        path: 'overpayments',
        component: ArProviderOverpaymentsComponent
      },
      {
        path: 'payment-plan',
        component: ArProviderPaymentPlanComponent
      },
      {
        path: 'history',
        loadChildren: () => import( './ar-provider-history/ar-provider-history.module').then(m => m.ArProviderHistoryModule)
      },
      {
        path: 'documents',
        component: ArProviderDocumentsComponent
      },
      {
        path: '**',
        redirectTo: 'details'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceArProviderDetailsRoutingModule { }

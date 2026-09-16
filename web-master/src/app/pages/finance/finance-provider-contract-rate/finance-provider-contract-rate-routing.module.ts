import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceProviderContractRateComponent } from './finance-provider-contract-rate.component';

const routes: Routes = [
  {
    path: '',
    component: FinanceProviderContractRateComponent,
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceProviderContractRateRoutingModule { }

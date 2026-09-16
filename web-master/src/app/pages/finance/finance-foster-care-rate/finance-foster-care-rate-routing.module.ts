import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceFosterCareRateComponent } from './finance-foster-care-rate.component';

const routes: Routes = [
  {
    path: '',
    component: FinanceFosterCareRateComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceFosterCareRateRoutingModule { }

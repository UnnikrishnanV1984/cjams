import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceAdjustmentComponent } from './finance-adjustment.component';
import { AdjustmentResultComponent } from './adjustment-result/adjustment-result.component';
import { PlacementAdjustmentComponent } from './placement-adjustment/placement-adjustment.component';

const routes: Routes = [
  {
  path: '',
  component: FinanceAdjustmentComponent,
  children: [
    {
      path: 'search',
      component: AdjustmentResultComponent
    },
    {
      path: 'payment-adjustment',
      component: PlacementAdjustmentComponent
    },
    {
      path: '**',
      redirectTo: 'search'
    }
  ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceAdjustmentRoutingModule { }

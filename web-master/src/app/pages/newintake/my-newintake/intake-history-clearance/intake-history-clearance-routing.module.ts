import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeHistoryClearanceComponent } from './intake-history-clearance.component';

const routes: Routes = [
  {
    path: '',
    component: IntakeHistoryClearanceComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeHistoryClearanceRoutingModule { }

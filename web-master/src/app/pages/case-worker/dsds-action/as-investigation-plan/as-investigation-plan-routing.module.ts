import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AsInvestigationPlanComponent } from './as-investigation-plan.component';

const routes: Routes = [{
  path: '',
  component: AsInvestigationPlanComponent
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AsInvestigationPlanRoutingModule { }

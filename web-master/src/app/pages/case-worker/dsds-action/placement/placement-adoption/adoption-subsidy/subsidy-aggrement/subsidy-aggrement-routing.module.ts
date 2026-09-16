import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SubsidyAggrementComponent } from './subsidy-aggrement.component';

const routes: Routes = [{
  path: '',
  component: SubsidyAggrementComponent,
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SubsidyAggrementRoutingModule { }

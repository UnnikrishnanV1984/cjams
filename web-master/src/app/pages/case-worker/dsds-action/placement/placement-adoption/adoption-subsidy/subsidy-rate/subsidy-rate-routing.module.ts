import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SubsidyRateComponent } from './subsidy-rate.component';

const routes: Routes = [{
  path: '',
  component: SubsidyRateComponent,
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SubsidyRateRoutingModule { }

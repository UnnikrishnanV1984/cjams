import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ServicePlanCoreComponent } from './service-plan-core.component';

const routes: Routes = [{
  path:'', component: ServicePlanCoreComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ServicePlanCoreRoutingModule { }

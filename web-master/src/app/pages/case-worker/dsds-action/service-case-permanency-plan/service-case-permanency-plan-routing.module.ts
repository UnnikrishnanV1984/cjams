import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ServiceCasePermanencyPlanComponent } from './service-case-permanency-plan.component';
import { ServiceCasePermanencyPlanResolverService } from './service-case-permanency-plan-resolver.service';
import { PermanencyPlanFormComponent } from './permanency-plan-form/permanency-plan-form.component';
import { PermanencyListComponent } from './permanency-list/permanency-list.component';
import { PermanencyPlanResolverService } from './service-case-permanencyplan-resolver.service';

const routes: Routes = [{
  path: '',
  component : ServiceCasePermanencyPlanComponent,
  resolve: {
    config: ServiceCasePermanencyPlanResolverService,
    result: PermanencyPlanResolverService
  },
  children: [
    {
      path: '',
      component: PermanencyListComponent,
    },
    {
      path: 'form',
      component: PermanencyPlanFormComponent,
    },
    {
      path: 'placement',
      loadChildren: () => import( '../placement/placement.module').then(m => m.PlacementModule),
    }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ServiceCasePermanencyPlanRoutingModule { }

import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InvestigationPlanComponent } from './investigation-plan.component';
import { InvestigationPlanSearchComponent } from './investigation-plan-search/investigation-plan-search.component';
import { InvestigationPlanActivityComponent } from './investigation-plan-search/investigation-plan-activity/investigation-plan-activity.component';
import { InvestigationPlanSuggestedTaskComponent } from './investigation-plan-search/investigation-plan-suggested-task/investigation-plan-suggested-task.component';
import { InvestigationPlanDeleteActivityComponent } from './investigation-plan-search/investigation-plan-delete-activity/investigation-plan-delete-activity.component';
import { InvestigationPlanTaskComponent } from './investigation-plan-search/investigation-plan-task/investigation-plan-task.component';
import { InvestigationResolverService } from './investigation-plan-resolver.service';

const routes: Routes = [{
  path: '',
  component: InvestigationPlanComponent,
  resolve:{
    result: InvestigationResolverService
  }
},
{
  path: 'plan-search',
  component: InvestigationPlanSearchComponent,
  resolve:{
    result: InvestigationResolverService
  }
},
{
  path: 'plan-activity/:investigationID',
  component: InvestigationPlanActivityComponent,
  resolve:{
    result: InvestigationResolverService
  }
},
{
  path: 'plan-suggested/:investigationID',
  component: InvestigationPlanSuggestedTaskComponent,
  resolve:{
    result: InvestigationResolverService
  }
},
{
  path: 'plan-delete/:investigationID',
  component: InvestigationPlanDeleteActivityComponent,
  resolve:{
    result: InvestigationResolverService
  }
},
{
  path: 'plan-task/:investigationID/:loadNumber',
  component: InvestigationPlanTaskComponent,
  resolve:{
    result: InvestigationResolverService
  }
},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class InvestigationPlanRoutingModule { }

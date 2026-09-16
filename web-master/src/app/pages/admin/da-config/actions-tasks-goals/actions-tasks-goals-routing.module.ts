import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ActionsTasksGoalsComponent } from './actions-tasks-goals.component';


const routes: Routes = [
  {
    path: '',
    component: ActionsTasksGoalsComponent,
    children: [
      { path: 'dsds-action-mapping-categories', loadChildren: () => import( './dsds-action-mapping-categories/dsds-action-mapping-categories.module').then(m => m.DsdsActionMappingCategoriesModule) },
      { path: 'dsds-action-goals', loadChildren: () => import( './dsds-action-goals/dsds-action-goals.module').then(m => m.DsdsActionGoalsModule) },
      { path: 'dsds-action-tasks', loadChildren: () => import( './dsds-action-tasks/dsds-action-tasks.module').then(m => m.DsdsActionTasksModule) },
      { path: 'dsds-action-mappings', loadChildren: () => import( './dsds-action-mappings/dsds-action-mappings.module').then(m => m.DsdsActionMappingsModule) },
      {path: '', redirectTo: 'dsds-action-mapping-categories', pathMatch: 'full'}
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ActionsTasksGoalsRoutingModule { }

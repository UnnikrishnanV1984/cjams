import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../../../@core/guard';
import { DaConfigComponent } from './da-config.component';

const routes: Routes = [
  {
    path: '',
    component: DaConfigComponent,
    canActivate: [RoleGuard],
    children: [
      { path: '', loadChildren: () => import( './actions-tasks-goals/actions-tasks-goals.module').then(m => m.ActionsTasksGoalsModule) },
      { path: 'actions-tasks-goals', loadChildren: () => import( './actions-tasks-goals/actions-tasks-goals.module').then(m => m.ActionsTasksGoalsModule) },
      { path: 'allegations', loadChildren: () => import( './allegations/allegations.module').then(m => m.AllegationsModule) },
      { path: 'custom-forms', loadChildren: () => import( './custom-forms/custom-forms.module').then(m => m.CustomFormsModule) },
      { path: 'da-type-config', loadChildren: () => import( './da-type-config/da-type-config.module').then(m => m.DaTypeConfigModule) },
      { path: 'provider-contracting', loadChildren: () => import( './provider-contracting/provider-contracting.module').then(m => m.ProviderContractingModule) },
      { path: 'review-da', loadChildren: () => import( './review-da/review-da.module').then(m => m.ReviewDaModule) }
    ]
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DaConfigRoutingModule { }

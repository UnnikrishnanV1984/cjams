import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ProviderContractingComponent } from './provider-contracting.component';


const routes: Routes = [
  {
    path: '',
    component: ProviderContractingComponent,
    children: [
      { path: 'doc-types', loadChildren: () => import( './doc-types/doc-types.module').then(m => m.DocTypesModule) },
      { path: 'doc-details', loadChildren: () => import( './doc-details/doc-details.module').then(m => m.DocDetailsModule) },
      { path: 'pa-tasks', loadChildren: () => import( './pa-tasks/pa-tasks.module').then(m => m.PaTasksModule) },
      { path: 'pa-activities', loadChildren: () => import( './pa-activities/pa-activities.module').then(m => m.PaActivitiesModule) },
      { path: 'pa-mapping', loadChildren: () => import( './pa-mapping/pa-mapping.module').then(m => m.PaMappingModule) },
      {path: '', redirectTo: 'doc-types', pathMatch: 'full'}
    ]
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProviderContractingRoutingModule { }

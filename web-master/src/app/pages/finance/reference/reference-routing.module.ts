import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ReferenceComponent } from './reference.component';

const routes: Routes = [
  {
    path: '',
    component: ReferenceComponent,
    children: [
      {
        path: 'provider-checklist',
        loadChildren: () => import( './provider-checklist/provider-checklist.module').then(m => m.ProviderChecklistModule)
      }
    ]
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReferenceRoutingModule { }

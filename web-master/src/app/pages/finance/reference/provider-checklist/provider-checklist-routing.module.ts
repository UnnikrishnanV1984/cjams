import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProviderChecklistComponent } from './provider-checklist.component';
import { ProviderChecklistResultComponent } from './provider-checklist-result/provider-checklist-result.component';

const routes: Routes = [
  {
    path: '',
    component: ProviderChecklistComponent,
    children: [
        {
          path: 'search',
          component: ProviderChecklistResultComponent
        },
        {
          path: '**',
          redirectTo: 'search'
        }
      ]
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProviderChecklistRoutingModule { }

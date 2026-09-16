import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ProviderSearchComponent } from './provider-search.component';

const routes: Routes = [
  {
    path: '',
    component: ProviderSearchComponent,
    children: []
   }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProviderSearchRoutingModule { }

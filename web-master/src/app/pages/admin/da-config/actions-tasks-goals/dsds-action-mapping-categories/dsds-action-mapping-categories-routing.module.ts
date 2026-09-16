import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DsdsActionMappingCategoriesComponent } from './dsds-action-mapping-categories.component';

const routes: Routes = [
  {
    path: '',
    component: DsdsActionMappingCategoriesComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DsdsActionMappingCategoriesRoutingModule { }

import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DsdsActionMappingsComponent } from './dsds-action-mappings.component';
import { AddEditDSDSActionMappingComponent } from './add-edit-dsds-action-mapping.component';

const routes: Routes = [
  {
      path: '',
      component: DsdsActionMappingsComponent
  },
  {
    path: ':id',
    component: AddEditDSDSActionMappingComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DsdsActionMappingsRoutingModule { }

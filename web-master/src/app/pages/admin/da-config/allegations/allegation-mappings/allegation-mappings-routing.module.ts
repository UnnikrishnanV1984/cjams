import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AllegationMappingsComponent } from './allegation-mappings.component';
import { AddEditAllegationMappingComponent } from './add-edit-allegation-mapping.component';

const routes: Routes = [
  {
    path: '',
    component: AllegationMappingsComponent,
  },
  {
    path: ':id',
    component: AddEditAllegationMappingComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AllegationMappingsRoutingModule { }

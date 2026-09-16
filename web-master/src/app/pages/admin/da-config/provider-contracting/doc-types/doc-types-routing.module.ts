import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { DocTypesComponent } from './doc-types.component';
import { AddEditDocTypesComponent } from './add-edit-doc-types.component';


const routes: Routes = [
  {
      path: '',
      component: DocTypesComponent,
      children: [
        { path: 'add-edit-doc-types/:id', component: AddEditDocTypesComponent, },
      ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DocTypesRoutingModule { }

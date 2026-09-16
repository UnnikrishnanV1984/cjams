import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AddEditDaTypeConfigComponent } from './add-edit-da-type-config.component';
import { DaTypeConfigComponent } from './da-type-config.component';

const routes: Routes = [
  {
    path: '',
    component: DaTypeConfigComponent,
    children: [
      {
        path: 'add-edit-da-type-config/:id', component: AddEditDaTypeConfigComponent
      }
    ]
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DaTypeConfigRoutingModule { }

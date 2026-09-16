import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AddEditDaActionTypeComponent } from './add-edit-da-action-type.component';
import { ManageDsdsActionTypeComponent } from './manage-dsds-action-type.component';

const routes: Routes = [
    {
      path: '',
      component: ManageDsdsActionTypeComponent,
      children: [
        { path: 'add-edit-da-action-type/:id', component: AddEditDaActionTypeComponent },
      ]
    }
  ];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ManageDsdsActionTypeRoutingModule {
}

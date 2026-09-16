import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddEditManageDaGroupComponent } from './add-edit-manage-da-group/add-edit-manage-da-group.component';
import { RoleGuard } from '../../../@core/guard';
import { ManageDaGroupComponent } from './manage-da-group.component';

const routes: Routes = [
  {
    path: '',
    component: ManageDaGroupComponent,
    canActivate: [RoleGuard],
    children: [
      { path: 'add-edit-manage-da-group/:id', component: AddEditManageDaGroupComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ManageDaGroupRoutingModule { }

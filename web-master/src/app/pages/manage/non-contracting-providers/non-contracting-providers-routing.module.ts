import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NonContractingProvidersComponent } from './non-contracting-providers.component';
import { RoleGuard } from '../../../@core/guard';
import { AddEditNonContractingProvidersComponent } from './add-edit-non-contracting-providers/add-edit-non-contracting-providers.component';

const routes: Routes = [
  {
    path: '',
    component: NonContractingProvidersComponent,
    canActivate: [RoleGuard],
    children: [
      { path: 'add-edit-non-contracting-providers/:id', component: AddEditNonContractingProvidersComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class NonContractingProvidersRoutingModule { }

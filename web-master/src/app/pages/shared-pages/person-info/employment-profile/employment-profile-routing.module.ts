import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { EmploymentProfileComponent } from './employment-profile.component';
import { AddEmploymentComponent } from './add-employment/add-employment.component';
import { ListEmploymentComponent } from './list-employment/list-employment.component';

const routes: Routes = [
  {
    path: '',
    component: EmploymentProfileComponent
  },
  {
    path: 'add',
    component: AddEmploymentComponent
  },
  {
    path: 'list',
    component: ListEmploymentComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EmploymentProfileRoutingModule { }

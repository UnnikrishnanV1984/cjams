
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { EducationComponent } from './education.component';
import {AddEducationComponent} from './add-education/add-education.component'

const routes: Routes = [
  {
    path: '',
    component: EducationComponent
  },
  {
    path: 'add',
    component: AddEducationComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EducationRoutingModule { }
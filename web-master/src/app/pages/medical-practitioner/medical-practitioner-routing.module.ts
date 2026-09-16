import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MedicalPractitionerComponent } from './medical-practitioner.component';

const routes: Routes = [
  {
    path: '',
    component: MedicalPractitionerComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MedicalPractitionerRoutingModule { }

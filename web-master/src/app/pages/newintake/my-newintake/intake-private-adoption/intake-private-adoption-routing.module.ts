import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakePrivateAdoptionComponent } from './intake-private-adoption.component';

const routes: Routes = [
  {
    path: '',
    component: IntakePrivateAdoptionComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakePrivateAdoptionRoutingModule { }

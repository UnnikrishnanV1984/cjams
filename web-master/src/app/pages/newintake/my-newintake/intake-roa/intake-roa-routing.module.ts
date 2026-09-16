import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeRoaComponent } from './intake-roa.component';

const routes: Routes = [
  {
    path: '',
    component: IntakeRoaComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeRoaRoutingModule { }

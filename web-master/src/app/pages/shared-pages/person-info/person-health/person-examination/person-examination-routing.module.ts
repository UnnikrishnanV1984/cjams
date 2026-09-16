import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ExaminationCwComponent } from './examination-cw/examination-cw.component';

const routes: Routes = [{
  path: '',
  component: ExaminationCwComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonExaminationRoutingModule { }

import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ApAcaFormComponent } from './ap-aca-form.component';

const routes: Routes = [{
  path: '',
  component: ApAcaFormComponent,
  children: []
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ApAcaFormRoutingModule { }

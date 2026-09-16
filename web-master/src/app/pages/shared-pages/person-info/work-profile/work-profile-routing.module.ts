import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WorkProfileComponent } from './work-profile.component';

const routes: Routes = [{
  path: '',
  component: WorkProfileComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonProfileRoutingModule { }

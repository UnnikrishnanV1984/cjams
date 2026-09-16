import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ApAdoptionEffortsComponent } from './ap-adoption-efforts.component';

const routes: Routes = [{
  path: '',
  component: ApAdoptionEffortsComponent,
  children: []
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ApAdoptionEffortsRoutingModule { }

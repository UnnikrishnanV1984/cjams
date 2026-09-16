import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InfoDisruptionComponent } from './info-disruption.component';

const routes: Routes = [
  {
    path: '',
    component: InfoDisruptionComponent
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class InfoDisruptionRoutingModule { }

import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Eighteen21Component } from './eighteen21.component';

const routes: Routes = [
  {
    path: '',
    component: Eighteen21Component
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class Eighteen21RoutingModule { }

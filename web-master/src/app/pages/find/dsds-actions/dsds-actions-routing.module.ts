import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { DsdsActionsComponent } from './dsds-actions.component';

const routes: Routes = [
  {
    path: '' , component: DsdsActionsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DsdsActionsRoutingModule { }

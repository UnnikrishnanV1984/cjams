import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DsdsActionGoalsComponent } from './dsds-action-goals.component';

const routes: Routes = [
  {
    path: '',
    component: DsdsActionGoalsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DsdsActionGoalsRoutingModule { }

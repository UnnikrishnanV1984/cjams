import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DsdsActionTasksComponent } from './dsds-action-tasks.component';

const routes: Routes = [
  {
      path: '',
      component: DsdsActionTasksComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DsdsActionTasksRoutingModule { }

import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AllegationTasksComponent } from './allegation-tasks.component';

const routes: Routes = [
  {
    path: '',
    component: AllegationTasksComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AllegationTasksRoutingModule { }

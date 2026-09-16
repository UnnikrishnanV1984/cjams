import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { PaTasksComponent } from './pa-tasks.component';


const routes: Routes = [
  {
      path: '',
      component: PaTasksComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PaTasksRoutingModule { }

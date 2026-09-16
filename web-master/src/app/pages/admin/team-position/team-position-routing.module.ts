import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { TeamPositionComponent } from './team-position.component';

const routes: Routes = [
  {
    path: '',
    component: TeamPositionComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TeamPositionRoutingModule { }

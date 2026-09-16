import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CourtActionsComponent } from './court-actions.component';

const routes: Routes = [
  {
    path: '',
    component: CourtActionsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CourtActionsRoutingModule { }

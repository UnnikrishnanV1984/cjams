import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonStatusSummaryComponent } from './person-status-summary.component';

const routes: Routes = [
  {
    path: '',
    component: PersonStatusSummaryComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonStatusSummaryRoutingModule { }

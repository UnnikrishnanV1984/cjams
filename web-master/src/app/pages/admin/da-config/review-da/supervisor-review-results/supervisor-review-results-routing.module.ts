import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { SupervisorReviewResultsComponent } from './supervisor-review-results.component';

const routes: Routes = [
  {
      path: '',
      component: SupervisorReviewResultsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SupervisorReviewResultsRoutingModule { }

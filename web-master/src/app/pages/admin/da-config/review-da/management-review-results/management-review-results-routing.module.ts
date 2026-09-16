import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ManagementReviewResultsComponent } from './management-review-results.component';

const routes: Routes = [
  {
      path: '',
      component: ManagementReviewResultsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ManagementReviewResultsRoutingModule { }

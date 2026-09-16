import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AddEditEdlReviewResultsComponent } from './add-edit-edl-review-results.component';
import { EdlReviewResultsComponent } from './edl-review-results.component';

const routes: Routes = [
  {
      path: '',
      component: EdlReviewResultsComponent,
      children: [
        { path: 'add-edit-edl-review-results/:id', component: AddEditEdlReviewResultsComponent, },
      ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EdlReviewResultsRoutingModule { }

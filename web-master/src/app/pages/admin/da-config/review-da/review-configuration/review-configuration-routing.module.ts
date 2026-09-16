import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { CoEdlReviewComponent } from './co-edl-review/co-edl-review.component';
import { EdlReviewComponent } from './edl-review/edl-review.component';
import { ManagementReviewComponent } from './management-review/management-review.component';
import { ReviewConfigurationComponent } from './review-configuration.component';
import { SupervisorReviewComponent } from './supervisor-review/supervisor-review.component';

const routes: Routes = [
  {
    path: '',
    component: ReviewConfigurationComponent,
    children: [
      { path: 'supervisor-review', component: SupervisorReviewComponent, },
      { path: 'co-edl-review', component: CoEdlReviewComponent, },
      { path: 'edl-review', component: EdlReviewComponent, },
      { path: 'management-review', component: ManagementReviewComponent, },
      {path: '', redirectTo: 'supervisor-review', pathMatch: 'full'}
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReviewConfigurationRoutingModule { }

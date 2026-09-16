import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ReviewDaComponent } from './review-da.component';

const routes: Routes = [
  {
    path: '',
    component: ReviewDaComponent,
    children: [
      { path: 'review-configuration', loadChildren: () => import( './review-configuration/review-configuration.module').then(m => m.ReviewConfigurationModule) },
      { path: 'edl-review-results', loadChildren: () => import( './edl-review-results/edl-review-results.module').then(m => m.EdlReviewResultsModule) },
      { path: 'management-review-results', loadChildren: () => import( './management-review-results/management-review-results.module').then(m => m.ManagementReviewResultsModule) },
      { path: 'supervisor-review-results', loadChildren: () => import( './supervisor-review-results/supervisor-review-results.module').then(m => m.SupervisorReviewResultsModule) },
      {path: '', redirectTo: 'review-configuration', pathMatch: 'full'}
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReviewDaRoutingModule { }

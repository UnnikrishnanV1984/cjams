import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonClientSummariesComponent } from './person-client-summaries.component';
import { OffenseSummaryComponent } from './offense-summary/offense-summary.component';
import { ContactNoteSummaryComponent } from './contact-note-summary/contact-note-summary.component';
import { PlacementSummaryComponent } from './placement-summary/placement-summary.component';
import { ReviewSummaryComponent } from './review-summary/review-summary.component';
import { OffenseSummaryResolverService } from './offense-summary/offense-summary-resolver.service';
import { ContactNoteSummaryResolverService } from './contact-note-summary/contact-note-summary-resolver.service';
import { PlacementSummaryResolverService } from './placement-summary/placement-summary-resolver.service';
import { ReviewSummaryResolverService } from './review-summary/review-summary-resolver.service';

const routes: Routes = [
  {
    path: '',
    component: PersonClientSummariesComponent,
    children: [
      {
        path: 'offense', component: OffenseSummaryComponent,
        resolve: {
          offensSummaries: OffenseSummaryResolverService
        }
      },
      {
        path: 'contact-notes', component: ContactNoteSummaryComponent,
        resolve: {
          contactNotes: ContactNoteSummaryResolverService
        }
      },
      {
        path: 'placement', component: PlacementSummaryComponent,
        resolve: {
          placementList: PlacementSummaryResolverService
        }
      },
      {
        path: 'review', component: ReviewSummaryComponent,
        resolve: {
          reviewList: ReviewSummaryResolverService
        }
      },
      { path: '**', redirectTo: 'offense' }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonClientSummariesRoutingModule { }

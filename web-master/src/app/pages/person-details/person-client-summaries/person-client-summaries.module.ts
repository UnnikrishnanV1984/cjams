import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonClientSummariesRoutingModule } from './person-client-summaries-routing.module';
import { PersonClientSummariesComponent } from './person-client-summaries.component';
import { OffenseSummaryComponent } from './offense-summary/offense-summary.component';
import { ContactNoteSummaryComponent } from './contact-note-summary/contact-note-summary.component';
import { PlacementSummaryComponent } from './placement-summary/placement-summary.component';
import { ReviewSummaryComponent } from './review-summary/review-summary.component';
import { OffenseSummaryService } from './offense-summary/offense-summary.service';
import { OffenseSummaryResolverService } from './offense-summary/offense-summary-resolver.service';
import { ContactNoteSummaryService } from './contact-note-summary/contact-note-summary.service';
import { ContactNoteSummaryResolverService } from './contact-note-summary/contact-note-summary-resolver.service';
import { ReviewSummaryService } from './review-summary/review-summary.service';
import { ReviewSummaryResolverService } from './review-summary/review-summary-resolver.service';
import { PlacementSummaryService } from './placement-summary/placement-summary.service';
import { PlacementSummaryResolverService } from './placement-summary/placement-summary-resolver.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
@NgModule({
  imports: [
    CommonModule,
    PersonClientSummariesRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    MatInputModule,
    MatSelectModule,
    PaginationModule
  ],
  declarations: [PersonClientSummariesComponent, OffenseSummaryComponent, ContactNoteSummaryComponent, PlacementSummaryComponent, ReviewSummaryComponent],
  providers: [OffenseSummaryService,
    OffenseSummaryResolverService,
    ContactNoteSummaryService,
    ContactNoteSummaryResolverService,
    ReviewSummaryService,
    ReviewSummaryResolverService,
    PlacementSummaryService,
    PlacementSummaryResolverService
  ]
})
export class PersonClientSummariesModule { }

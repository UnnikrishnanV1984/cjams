import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { CoEdlReviewComponent } from './co-edl-review/co-edl-review.component';
import { EdlReviewComponent } from './edl-review/edl-review.component';
import { ManagementReviewComponent } from './management-review/management-review.component';
import { ReviewConfigurationRoutingModule } from './review-configuration-routing.module';
import { ReviewConfigurationComponent } from './review-configuration.component';
import { SupervisorReviewComponent } from './supervisor-review/supervisor-review.component';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    ReviewConfigurationRoutingModule,
    FormsModule,
    ReactiveFormsModule, SharedPipesModule
  ],
  declarations: [ReviewConfigurationComponent, SupervisorReviewComponent, EdlReviewComponent, ManagementReviewComponent, CoEdlReviewComponent]
})
export class ReviewConfigurationModule { }

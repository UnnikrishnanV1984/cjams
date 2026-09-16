import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { SupervisorReviewResultsRoutingModule } from './supervisor-review-results-routing.module';
import { SupervisorReviewResultsComponent } from './supervisor-review-results.component';

@NgModule({
  imports: [
    CommonModule,
    SupervisorReviewResultsRoutingModule, ReactiveFormsModule, PaginationModule, FormsModule, ControlMessagesModule, SortTableModule, SharedPipesModule, SharedDirectivesModule
  ],
  declarations: [SupervisorReviewResultsComponent]
})
export class SupervisorReviewResultsModule { }

import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { ManagementReviewResultsRoutingModule } from './management-review-results-routing.module';
import { ManagementReviewResultsComponent } from './management-review-results.component';

@NgModule({
  imports: [
    CommonModule,
    ManagementReviewResultsRoutingModule, ReactiveFormsModule, PaginationModule, FormsModule, ControlMessagesModule, SortTableModule, SharedPipesModule, SharedDirectivesModule
  ],
  declarations: [ManagementReviewResultsComponent]
})
export class ManagementReviewResultsModule { }

import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { AddEditEdlReviewResultsComponent } from './add-edit-edl-review-results.component';
import { EdlReviewResultsRoutingModule } from './edl-review-results-routing.module';
import { EdlReviewResultsComponent } from './edl-review-results.component';



@NgModule({
  imports: [
    CommonModule,
    EdlReviewResultsRoutingModule,
    FormsModule, ReactiveFormsModule, PaginationModule, ControlMessagesModule, SortTableModule, SharedPipesModule, SharedDirectivesModule],
  declarations: [EdlReviewResultsComponent, AddEditEdlReviewResultsComponent],
  exports: [EdlReviewResultsComponent],
})
export class EdlReviewResultsModule { }

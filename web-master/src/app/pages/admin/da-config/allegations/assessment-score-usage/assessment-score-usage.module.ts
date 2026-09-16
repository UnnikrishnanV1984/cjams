import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { AssessmentScoreUsageRoutingModule } from './assessment-score-usage-routing.module';
import { AssessmentScoreUsageComponent } from './assessment-score-usage.component';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    AssessmentScoreUsageRoutingModule,
    ControlMessagesModule,
    ReactiveFormsModule,
    FormsModule,
    SortTableModule,
    PaginationModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [AssessmentScoreUsageComponent]
})
export class AssessmentScoreUsageModule { }

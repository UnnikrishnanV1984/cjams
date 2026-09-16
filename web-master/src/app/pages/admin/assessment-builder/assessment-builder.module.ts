import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { AssessmentBuilderRoutingModule } from './assessment-builder-routing.module';
import { AssessmentBuilderComponent } from './assessment-builder.component';

@NgModule({
  imports: [
    CommonModule,
    AssessmentBuilderRoutingModule,
    PaginationModule,
    ControlMessagesModule,
    FormsModule,
    ReactiveFormsModule,
    NgSelectModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [AssessmentBuilderComponent]
})
export class AssessmentBuilderModule { }

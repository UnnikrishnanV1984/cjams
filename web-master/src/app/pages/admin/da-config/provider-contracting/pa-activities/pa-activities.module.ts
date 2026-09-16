import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { PaActivitiesRoutingModule } from './pa-activities-routing.module';
import { PaActivitiesComponent } from './pa-activities.component';

@NgModule({
  imports: [
    CommonModule,
    PaActivitiesRoutingModule,
    ControlMessagesModule,
    PaginationModule,
    FormsModule,
    ReactiveFormsModule,
    SortTableModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [PaActivitiesComponent]
})
export class PaActivitiesModule { }

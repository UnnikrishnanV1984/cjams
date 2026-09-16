import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { DsdsActionTasksRoutingModule } from './dsds-action-tasks-routing.module';
import { DsdsActionTasksComponent } from './dsds-action-tasks.component';

@NgModule({
  imports: [
    CommonModule,
    DsdsActionTasksRoutingModule,
    ControlMessagesModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    SortTableModule,
    SharedDirectivesModule,
    SharedPipesModule
  ],
  declarations: [DsdsActionTasksComponent]
})
export class DsdsActionTasksModule { }

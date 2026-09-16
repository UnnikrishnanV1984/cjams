import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { PaTasksRoutingModule } from './pa-tasks-routing.module';
import { PaTasksComponent } from './pa-tasks.component';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    PaTasksRoutingModule,
    ControlMessagesModule,
    PaginationModule,
    FormsModule,
    ReactiveFormsModule,
    SortTableModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [PaTasksComponent]
})
export class PaTasksModule { }

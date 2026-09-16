import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { AllegationTasksRoutingModule } from './allegation-tasks-routing.module';
import { AllegationTasksComponent } from './allegation-tasks.component';

@NgModule({
  imports: [
    CommonModule,
    AllegationTasksRoutingModule,
    ControlMessagesModule,
    PaginationModule,
    FormsModule,
    ReactiveFormsModule,
    SortTableModule,
    SharedDirectivesModule,
    SharedPipesModule
  ],
  declarations: [AllegationTasksComponent]
})
export class AllegationTasksModule { }

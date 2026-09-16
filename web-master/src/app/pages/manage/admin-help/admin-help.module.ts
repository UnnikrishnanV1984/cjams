import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { AdminHelpRoutingModule } from './admin-help-routing.module';
import { AdminHelpComponent } from './admin-help.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@NgModule({
  imports: [
    CommonModule,
    AdminHelpRoutingModule,
    PaginationModule,
    FormsModule,
    SharedDirectivesModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    SortTableModule,
    // A2Edatetimepicker
  ],
  declarations: [AdminHelpComponent]
})
export class AdminHelpModule { }

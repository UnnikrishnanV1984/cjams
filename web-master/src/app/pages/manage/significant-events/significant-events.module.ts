import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SignificantEventsRoutingModule } from './significant-events-routing.module';
import { SignificantEventsComponent } from './significant-events.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
  imports: [
    CommonModule,
    SignificantEventsRoutingModule,
    PaginationModule,
    FormsModule,
    SharedDirectivesModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    SortTableModule,
    MatFormFieldModule,
    MatDatepickerModule
    // A2Edatetimepicker
  ],
  declarations: [SignificantEventsComponent]
})
export class SignificantEventsModule { }

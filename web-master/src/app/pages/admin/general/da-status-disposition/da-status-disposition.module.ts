import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { DaStatusDispositionRoutingModule } from './da-status-disposition-routing.module';
import { DaStatusDispositionComponent } from './da-status-disposition.component';
import { DispositionCodeComponent } from './disposition-code/disposition-code.component';
import { StatusTypeComponent } from './status-type/status-type.component';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
  imports: [
    CommonModule,
    DaStatusDispositionRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    SortTableModule,
    SharedPipesModule,
    ReactiveFormsModule,
    // A2Edatetimepicker,
    MatDatepickerModule,
    MatFormFieldModule
  ],
  declarations: [DaStatusDispositionComponent, StatusTypeComponent, DispositionCodeComponent],
  exports: [DaStatusDispositionComponent, PaginationModule],
  providers: []
})
export class DaStatusDispositionModule { }

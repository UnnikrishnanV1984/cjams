import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { RegulationLibraryRoutingModule } from './regulation-library-routing.module';
import { RegulationLibraryComponent } from './regulation-library.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
  imports: [
    CommonModule,
    RegulationLibraryRoutingModule,
    PaginationModule,
    FormsModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    NgSelectModule,
    SharedPipesModule,
    SortTableModule,
    MatFormFieldModule,
    MatDatepickerModule
    // A2Edatetimepicker
  ],
  declarations: [RegulationLibraryComponent]
})
export class RegulationLibraryModule { }

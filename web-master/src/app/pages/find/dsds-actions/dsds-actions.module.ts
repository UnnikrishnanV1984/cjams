import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PageHeaderModule } from '../../../shared';
import { DsdsActionsResultComponent } from './dsds-actions-result/dsds-actions-result.component';
import { DsdsActionsRoutingModule } from './dsds-actions-routing.module';
import { DsdsActionsSearchComponent } from './dsds-actions-search/dsds-actions-search.component';
import { DsdsActionsComponent } from './dsds-actions.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
  imports: [
    CommonModule,
    PageHeaderModule,
    DsdsActionsRoutingModule,
    FormsModule,
    PaginationModule,
    // A2Edatetimepicker,
    ReactiveFormsModule,
    NgSelectModule,
    SharedPipesModule,
    MatDatepickerModule,
    MatFormFieldModule
  ],
  declarations: [DsdsActionsComponent, DsdsActionsResultComponent, DsdsActionsSearchComponent]
})
export class DsdsActionsModule { }

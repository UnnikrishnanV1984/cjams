import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { DsdsActionMappingCategoriesRoutingModule } from './dsds-action-mapping-categories-routing.module';
import { DsdsActionMappingCategoriesComponent } from './dsds-action-mapping-categories.component';

@NgModule({
  imports: [
    CommonModule,
    DsdsActionMappingCategoriesRoutingModule,
    ControlMessagesModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    SortTableModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [DsdsActionMappingCategoriesComponent]
})
export class DsdsActionMappingCategoriesModule { }

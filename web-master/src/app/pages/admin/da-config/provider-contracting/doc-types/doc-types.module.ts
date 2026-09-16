import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { AddEditDocTypesComponent } from './add-edit-doc-types.component';
import { DocTypesRoutingModule } from './doc-types-routing.module';
import { DocTypesComponent } from './doc-types.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    DocTypesRoutingModule,
    PaginationModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    SortTableModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [DocTypesComponent, AddEditDocTypesComponent],
  exports: [AddEditDocTypesComponent]
})
export class DocTypesModule { }

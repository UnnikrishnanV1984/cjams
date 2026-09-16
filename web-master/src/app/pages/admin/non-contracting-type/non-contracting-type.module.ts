import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { NonContractingTypeRoutingModule } from './non-contracting-type-routing.module';
import { NonContractingTypeComponent } from './non-contracting-type.component';


@NgModule({
  imports: [CommonModule,
    NonContractingTypeRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    ControlMessagesModule,
    SortTableModule,
    SharedPipesModule,
    SharedDirectivesModule],
  declarations: [NonContractingTypeComponent]
})
export class NonContractingTypeModule { }

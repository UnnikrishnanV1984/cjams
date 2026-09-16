import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { DocDetailsRoutingModule } from './doc-details-routing.module';
import { DocDetailsComponent } from './doc-details.component';


@NgModule({
  imports: [
    CommonModule,
    DocDetailsRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    SortTableModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [DocDetailsComponent]
})
export class DocDetailsModule { }

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CaseSearchRoutingModule } from './case-search-routing.module';
import { CaseSearchComponent } from './case-search.component';
import { FormMaterialModule } from '../../@core/form-material.module';
import { MatRadioModule } from '@angular/material/radio';
import { CaseSearchService } from './case-search.service';
import { NgxPaginationModule } from 'ngx-pagination';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { CaseSearchListComponent } from './case-search-list/case-search-list.component';
import { AuditTrailModule } from '../shared-pages/audit-trail/audit-trail.module';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
@NgModule({
  imports: [
    CommonModule,
    CaseSearchRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    NgxPaginationModule,
    PaginationModule,
    NgSelectModule,
    AuditTrailModule,
    SortTableModule
  ],
  declarations: [CaseSearchComponent, CaseSearchListComponent],
  exports: [ ],
  providers: [CaseSearchService]
})
export class CaseSearchModule { }

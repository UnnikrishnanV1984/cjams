import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CaseAuditTrailRoutingModule } from './case-audit-trail-routing.module';
import { CaseAuditTrailComponent } from './case-audit-trail.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';


@NgModule({
  imports: [
    CommonModule,
    CaseAuditTrailRoutingModule,
    FormMaterialModule,
    PaginationModule,
    SortTableModule,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  providers:[provideNgxMask()],
  declarations: [
    CaseAuditTrailComponent
  ]
})
export class CaseAuditTrailModule { }
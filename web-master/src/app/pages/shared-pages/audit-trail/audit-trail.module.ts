import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AuditTrailRoutingModule } from './audit-trail-routing.module';
import { AuditTrailComponent } from './audit-trail.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { DemographicLogsComponent } from './demographic-logs/demographic-logs.component';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

import { NgSelectModule } from '@ng-select/ng-select';

@NgModule({
  imports: [
    CommonModule,
    AuditTrailRoutingModule,
    FormMaterialModule,
    SharedPipesModule,
    PaginationModule,
    SortTableModule,
    NgSelectModule
  ],
  declarations: [AuditTrailComponent, DemographicLogsComponent]
})
export class AuditTrailModule { }

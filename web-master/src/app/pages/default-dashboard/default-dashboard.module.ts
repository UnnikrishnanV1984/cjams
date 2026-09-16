import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DefaultDashboardRoutingModule } from './default-dashboard-routing.module';
import { DefaultDashboardComponent } from './default-dashboard.component';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../@core/form-material.module';
import { NgxPaginationModule } from 'ngx-pagination';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { AuditTrailModule } from '../shared-pages/audit-trail/audit-trail.module';

@NgModule({
  imports: [
    CommonModule,
    DefaultDashboardRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    NgxPaginationModule,
    PaginationModule,
    NgSelectModule,
    AuditTrailModule
  ],
  declarations: [
    DefaultDashboardComponent
  ]
})
export class DefaultDashboardModule { }

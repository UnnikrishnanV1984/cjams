import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ServiceCasePermanencyPlanRoutingModule } from './service-case-permanency-plan-routing.module';
import { ServiceCasePermanencyPlanComponent } from './service-case-permanency-plan.component';
import { ChildWrapperComponent } from './child-wrapper/child-wrapper.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { MatMenuModule } from '@angular/material/menu';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatRadioModule } from '@angular/material/radio';

import { ServiceCasePermanencyPlanService } from './service-case-permanency-plan.service';
import { ServiceCasePermanencyPlanResolverService } from './service-case-permanency-plan-resolver.service';
import { PermanencyPlanFormComponent } from './permanency-plan-form/permanency-plan-form.component';
import { PermanencyListComponent } from './permanency-list/permanency-list.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { ChildRemovalService } from '../child-removal/child-removal.service';
import { PersonDisabilityService } from '../../../shared-pages/person-disability/person-disability.service';
import { PermanencyPlanResolverService } from './service-case-permanencyplan-resolver.service';
import { AuditLogsComponent } from '../../../shared-pages/audit-logs/audit-logs.component';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';


@NgModule({
  imports: [
    CommonModule,
    ServiceCasePermanencyPlanRoutingModule,
    FormMaterialModule,
    MatMenuModule,
    MatRadioModule,
    MatFormFieldModule,
    PaginationModule,
    SortTableModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [ServiceCasePermanencyPlanComponent, ChildWrapperComponent, PermanencyPlanFormComponent, PermanencyListComponent,AuditLogsComponent],
  providers: [ServiceCasePermanencyPlanResolverService, ServiceCasePermanencyPlanService, ChildRemovalService, PersonDisabilityService,PermanencyPlanResolverService
]
})
export class ServiceCasePermanencyPlanModule { }

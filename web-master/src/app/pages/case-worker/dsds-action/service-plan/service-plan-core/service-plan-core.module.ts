import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ServicePlanCoreRoutingModule } from './service-plan-core-routing.module';
import { ServicePlanCoreComponent } from './service-plan-core.component';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ServiceCaseManagementModule } from '../../../../shared-pages/service-case-management/service-case-management.module';
import { QuillModule } from 'ngx-quill';
import { GoalComponent } from '../goal/goal.component';
import { ObjectiveComponent } from '../objective/objective.component';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatSelectModule } from '@angular/material/select';
import { MatInputModule } from '@angular/material/input';
import { EBPReferralMadeComponent } from './ebp-referral-made/ebp-referral-made.component';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';


@NgModule({
  imports: [
    CommonModule,
    ServicePlanCoreRoutingModule,
    ServiceCaseManagementModule,
    FormMaterialModule,
    MatTooltipModule,
    SortTableModule,
    QuillModule.forRoot(),
    PaginationModule,
    PaginationModule,
    MatSelectModule,
    MatInputModule,
    MatFormFieldModule,
    MatTableModule,
    MatTabsModule,
    SignatureFieldModule
  ],
  declarations: [ServicePlanCoreComponent, GoalComponent, ObjectiveComponent, EBPReferralMadeComponent]
 
})
export class ServicePlanCoreModule { }

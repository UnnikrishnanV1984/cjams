import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
// import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { CjamsDashboardRoutingModule } from './cjams-dashboard-routing.module';
import { CjamsDashboardComponent } from './cjams-dashboard.component';
// import { DashAssignCaseComponent } from './dash-assign-case/dash-assign-case.component';
// import { DashIntakeSummaryComponent } from './dash-intake-summary/dash-intake-summary.component';
// import { DashPreIntakeComponent } from './dash-pre-intake/dash-pre-intake.component';
// import { QuillModule } from 'ngx-quill';
import { IntakeUtils } from '../_utils/intake-utils.service';
// import { CwIntakeReferalsComponent } from './cw-intake-referals/cw-intake-referals.component';
// import { CwAssignCaseComponent } from './cw-assign-case/cw-assign-case.component';
// import { CwApprovalComponent } from './cw-approval/cw-approval.component';
// import { CwAssessmentComponent } from './cw-assessment/cw-assessment.component';
// import { IvECasesComponent } from './iv-e-cases/iv-e-cases.component';
// import { HomeDashboardModule } from '../home-dashboard/home-dashboard.module';
// import { CwAssignServiceCaseComponent } from './cw-assign-service-case/cw-assign-service-case.component';
// import { CwAssignAdoptionCaseComponent } from './cw-assign-adoption-case/cw-assign-adoption-case.component';
import { NgSelectModule } from '@ng-select/ng-select';
// import { DashMyIntakeSummaryComponent } from './dash-my-intake-summary/dash-my-intake-summary.component';
// import { CwWorkloadComponent } from './cw-workload/cw-workload.component';
import { HighchartsChartModule } from 'highcharts-angular';
import { IntakeConfigService } from '../newintake/my-newintake/intake-config.service';
import { PurposeResolverService } from '../newintake/my-newintake/purpose-resolver.service';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
// import { CwLdssInboxComponent } from './cw-ldss-inbox/cw-ldss-inbox.component';
// import { CwApprovalCaseWorkerComponent } from './cw-approval-caseworker/cw-approval-caseworker.component';
import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';
import { InvolvedPersonsService } from '../shared-pages/involved-persons/involved-persons.service';
import { MatTooltipModule } from '@angular/material/tooltip';

@NgModule({
    imports: [
        FormsModule,
        ReactiveFormsModule,
        PaginationModule,
        CommonModule,
        MatSelectModule,
        MatDatepickerModule,
        MatFormFieldModule,
        MatInputModule,
        // MatCheckboxModule,
        CjamsDashboardRoutingModule,
        SortTableModule,
        // QuillModule.forRoot(),
        // HomeDashboardModule,
        NgSelectModule,
        HighchartsChartModule,
        SharedPipesModule,
        SharedDirectivesModule,
        MatTooltipModule
    ],
    declarations: [
        CjamsDashboardComponent,
        // DashPreIntakeComponent,
        // DashIntakeSummaryComponent,
        // IvECasesComponent,
        // DashAssignCaseComponent,
        // CwIntakeReferalsComponent,
        // CwAssignCaseComponent,
        // CwApprovalComponent,
        // CwAssessmentComponent,
        // CwAssignServiceCaseComponent,
        // CwAssignAdoptionCaseComponent,
        // DashMyIntakeSummaryComponent,
        // CwWorkloadComponent,
        // CwLdssInboxComponent,
        // CwApprovalCaseWorkerComponent
    ],
    providers: [IntakeUtils, IntakeConfigService, PurposeResolverService, InvolvedPersonsService]
})
export class CjamsDashboardModule { }

import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RoleGuard } from '../../@core/guard';
import { CjamsDashboardComponent } from './cjams-dashboard.component';
// import { DashAssignCaseComponent } from './dash-assign-case/dash-assign-case.component';
// import { DashIntakeSummaryComponent } from './dash-intake-summary/dash-intake-summary.component';
// import { DashPreIntakeComponent } from './dash-pre-intake/dash-pre-intake.component';
// import { CwAssignCaseComponent } from './cw-assign-case/cw-assign-case.component';
// import { CwApprovalComponent } from './cw-approval/cw-approval.component';
// import { CwIntakeReferalsComponent } from './cw-intake-referals/cw-intake-referals.component';
// import { CwAssessmentComponent } from './cw-assessment/cw-assessment.component';
// import { IvECasesComponent } from './iv-e-cases/iv-e-cases.component';
// import { CwAssignServiceCaseComponent } from './cw-assign-service-case/cw-assign-service-case.component';
// import { CwAssignAdoptionCaseComponent } from './cw-assign-adoption-case/cw-assign-adoption-case.component';
// import { DashMyIntakeSummaryComponent } from './dash-my-intake-summary/dash-my-intake-summary.component';
// import { CwWorkloadComponent } from './cw-workload/cw-workload.component';
import { PurposeResolverService } from '../newintake/my-newintake/purpose-resolver.service';
// import { CwLdssInboxComponent } from './cw-ldss-inbox/cw-ldss-inbox.component';
// import { CwApprovalCaseWorkerComponent } from './cw-approval-caseworker/cw-approval-caseworker.component';

const routes: Routes = [
    { path: '', component: CjamsDashboardComponent, canActivate: [RoleGuard] },
    // { path: 'pre-intakes', component: DashPreIntakeComponent, canActivate: [RoleGuard] },
    {
        path: 'pre-intakes',
        loadComponent: () => import('./dash-pre-intake/dash-pre-intake.component').then(m => m.DashPreIntakeComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'intake-summary', component: DashIntakeSummaryComponent, canActivate: [RoleGuard] },
    {
        path: 'intake-summary',
        loadComponent: () => import('./dash-intake-summary/dash-intake-summary.component').then(m => m.DashIntakeSummaryComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'my-intake-summary', component: DashMyIntakeSummaryComponent, canActivate: [RoleGuard]},
    {
        path: 'my-intake-summary',
        loadComponent: () => import('./dash-my-intake-summary/dash-my-intake-summary.component').then(m => m.DashMyIntakeSummaryComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'assign-case', component: DashAssignCaseComponent, canActivate: [RoleGuard] },
    {
        path: 'assign-case',
        loadComponent: () => import('./dash-assign-case/dash-assign-case.component').then(m => m.DashAssignCaseComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-assign-case', component: CwAssignCaseComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-assign-case',
        loadComponent: () => import('./cw-assign-case/cw-assign-case.component').then(m => m.CwAssignCaseComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-assign-service-case', component: CwAssignServiceCaseComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-assign-service-case',
        loadComponent: () => import('./cw-assign-service-case/cw-assign-service-case.component').then(m => m.CwAssignServiceCaseComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-assign-adoption-case', component: CwAssignAdoptionCaseComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-assign-adoption-case',
        loadComponent: () => import('./cw-assign-adoption-case/cw-assign-adoption-case.component').then(m => m.CwAssignAdoptionCaseComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-approval', component: CwApprovalComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-approval',
        loadComponent: () => import('./cw-approval/cw-approval.component').then(m => m.CwApprovalComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-approval-caseworker', component: CwApprovalCaseWorkerComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-approval-caseworker',
        loadComponent: () => import('./cw-approval-caseworker/cw-approval-caseworker.component').then(m => m.CwApprovalCaseWorkerComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-intake-referals', component: CwIntakeReferalsComponent,
    //     // resolve: {
    //     //     purposeList: PurposeResolverService,
    //     // },
    //     canActivate: [RoleGuard]
    // },
    {
        path: 'cw-intake-referals',
        loadComponent: () => import('./cw-intake-referals/cw-intake-referals.component').then(m => m.CwIntakeReferalsComponent),
        canActivate: [RoleGuard],
        resolve: {
            purposeList: PurposeResolverService,
        },
    },
    // { path: 'cw-assessment', component: CwAssessmentComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-assessment',
        loadComponent: () => import('./cw-assessment/cw-assessment.component').then(m => m.CwAssessmentComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'iv-e-cases', component: IvECasesComponent, canActivate: [RoleGuard] },
    {
        path: 'iv-e-cases',
        loadComponent: () => import('./iv-e-cases/iv-e-cases.component').then(m => m.IvECasesComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-workload', component: CwWorkloadComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-workload',
        loadComponent: () => import('./cw-workload/cw-workload.component').then(m => m.CwWorkloadComponent),
        canActivate: [RoleGuard]
    },
    // { path: 'cw-ldss-inbox', component: CwLdssInboxComponent, canActivate: [RoleGuard] },
    {
        path: 'cw-ldss-inbox',
        loadComponent: () => import('./cw-ldss-inbox/cw-ldss-inbox.component').then(m => m.CwLdssInboxComponent),
        canActivate: [RoleGuard]
    },
    
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class CjamsDashboardRoutingModule { }

import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DsdsActionComponent } from './dsds-action.component';
import { AppConstants } from '../../../@core/common/constants';
import { DsdsActionResolverService } from './dsds-action-resolver.service';
import { Form1080AComponent } from '../../../shared/shared-components/forms/form-1080-a/form-1080-a.component';
import { Form1080BComponent } from '../../../shared/shared-components/forms/form-1080-b/form-1080-b.component';
import { Form1080CComponent } from '../../../shared/shared-components/forms/form-1080-c/form-1080-c.component';
import { RoleGuard } from '../../../@core/guard';
const routes: Routes = [
    {
        path: '',
        component: DsdsActionComponent,
        resolve: {
            result: DsdsActionResolverService
          },
        canActivate: [RoleGuard],
        canActivateChild: [RoleGuard],
        children: [
             { path: '', loadChildren: () => import( './report-summary/report-summary.module').then(m => m.ReportSummaryModule)  },
            // { path: 'allegation', component: AllegationComponent },
            // {path : 'alternative-response-summary', component: AlternativeResponseSummaryComponent },
               { path: 'assessment',  loadChildren: () => import( './assessment/assessment.module').then(m => m.AssessmentModule)  },
               { path: 'cw-assignments', loadChildren: () => import( './cw-assignments/cw-assignments.module').then(m => m.CwAssignmentsModule)  },
              { path: 'kinship', loadChildren: () => import( './kinship/kinship.module').then(m => m.KinshipModule)},
            //  { path: 'adult-assessment', loadChildren: () => import( './adult-assessment/adult-assessment.module').then(m => m.AdultAssessmentModule'},
            //  { path: 'adult-assessment/adult-caseworker-assessment',  loadChildren: () => import( './adult-assessment/adult-caseworker-assessment/adult-caseworker-assessment.module').then(m => m.AdultCaseworkerAssessmentModule'  },
              { path: 'assessment/case-worker-view-assessment', loadChildren: () => import( './assessment/case-worker-view-assessment/case-worker-view-assessment.module').then(m => m.CaseWorkerViewAssessmentModule)  },
              { path: 'assessment/view-assessment', loadChildren: () => import( './assessment/view-assessment/view-assessment.module').then(m => m.ViewAssessmentModule)  },
              {
                 path: 'attachment', loadChildren: () => import( './attachment/attachment.module').then(m => m.AttachmentModule)
              },
              {
                 path: 'attachment/:type',
                 loadChildren: () => import( './attachment/attachment.module').then(m => m.AttachmentModule)
             },
             { path: 'form1080a', component: Form1080AComponent },
             { path: 'form1080b', component: Form1080BComponent },
             { path: 'form1080c', component: Form1080CComponent },
             { path: 'form1080a/:id', component: Form1080AComponent },
             { path: 'form1080b/:id', component: Form1080BComponent },
             { path: 'form1080c/:id', component: Form1080CComponent },
            // { path: 'cross-reference', loadChildren: () => import( './cross-reference/cross-reference.module').then(m => m.CrossReferenceModule' },
             { path: 'disposition', loadChildren: () => import( './disposition/disposition.module').then(m => m.DispositionModule) },
             // { path: 'case-plan', component: CasePlanComponent },
             { path: 'case-plan', loadChildren: () => import( './case-plan/case-plan.module').then(m => m.CasePlanModule) },
             { path: 'social-history', loadChildren: () => import( './social-history/social-history.module').then(m => m.SocialHistoryModule) },
            // { path: 'history',  loadChildren: () => import( './history/history.module').then(m => m.HistoryModule' },
                {
                    path: 'investigation-plan',
                    loadChildren: () => import( './investigation-plan/investigation-plan.module').then(m => m.InvestigationPlanModule)
                },
                {
                    path: 'person-cw',
                    loadChildren: () => import( '../../shared-pages/involved-persons/involved-persons.module').then(m => m.InvolvedPersonsModule),
                    data: { source: AppConstants.MODULE_TYPE.CASE }
                },
                { 
                    path: 'adoption-persons', 
                    loadChildren: () => import( '../../shared-pages/involved-persons/involved-persons.module').then(m => m.InvolvedPersonsModule),
                    // data: { source: AppConstants.MODULE_TYPE.ADOPTION_CASE }
                    data: { source: AppConstants.MODULE_TYPE.CASE }
                },
             { path: 'recording', loadChildren: () => import( './recording/recording.module').then(m => m.RecordingModule) },
            //{ path: 'as-recording', loadChildren: () => import( './as-recording/as-recording.module').then(m => m.AsRecordingModule' },
             { path: 'referral', loadChildren: () => import( './referral/referral.module').then(m => m.ReferralModule) },
            //{ path: 'as-referral', loadChildren: () => import( './adult-referral/adult-referral.module').then(m => m.AdultReferralModule' },
              // { path: 'report-summary',  loadChildren: () => import( './report-summary/report-summary.module').then(m => m.ReportSummaryModule'  },
             { path: 'narrative', loadChildren: () => import( './narrative/narrative.module').then(m => m.NarrativeModule) },
             { path: 'report-summary-djs', loadChildren: () => import( './report-summary-djs/report-summary-djs.module').then(m => m.ReportSummaryDjsModule) },
             { path: 'time-line-view',  loadChildren: () => import( './time-line-view/time-line-view.module').then(m => m.TimeLineViewModule) },
             { path: 'time-line-view-djs',  loadChildren: () => import( './time-line-view-djs/time-line-view-djs.module').then(m => m.TimeLineViewDjsModule) },
             { path: 'plan', loadChildren: () => import( './plan/plan.module').then(m => m.PlanModule) },
             { path: 'maltreatment-information', loadChildren: () => import( './maltreatment-information/maltreatment-information.module').then(m => m.MaltreatmentInformationModule) },
            // { path: 'as-maltreatment-information', loadChildren: () => import( './as-maltreatment-information/as-maltreatment-information.module').then(m => m.AsMaltreatmentInformationModule' },
             { path: 'investigation-findings', loadChildren: () => import( './investigation-findings/investigation-findings.module').then(m => m.InvestigationFindingsModule) },
             { path: 'alternative-response-summary', loadChildren: () => import( './alternative-response-summary/alternative-response-summary.module').then(m => m.AlternativeResponseSummaryModule) },
             //{ path: 'adult-placement', loadChildren: () => import( './adult-placement/adult-placement.module').then(m => m.AdultPlacementModule) },
            //  { path: 'djs-placement', loadChildren: () => import( './djs-placement/djs-placement.module').then(m => m.DjsPlacementModule' },
             { path: 'sdm', loadChildren: () => import( './sdm/sdm.module').then(m => m.SdmModule) },
             { path: 'case-adult-screen-tool', loadChildren: () => import( './case-adult-screen-tool/case-adult-screen-tool.module').then(m => m.CaseAdultScreenToolModule) },
             { path: 'child-removal', loadChildren: () => import( './child-removal/child-removal.module').then(m => m.ChildRemovalModule) },
             { path: 'court', loadChildren: () => import( './court/court.module').then(m => m.CourtModule) },
             { path: 'service-plan', loadChildren: () => import( './service-plan/service-plan.module').then(m => m.ServicePlanModule) },
             //{ path: 'as-service-plan', loadChildren: () => import( './as-service-plan/as-service-plan.module').then(m => m.AsServicePlanModule' },
             { path: 'appointment', loadChildren: () => import( './appointment/appointment.module').then(m => m.AppointmentModule) },
             { path: 'legal-action-history',loadChildren: () => import( './legal-action-history/legal-action-history.module').then(m => m.LegalActionHistoryModule) },
            // { path: 'entities', loadChildren: () => import( './entities/entities.module').then(m => m.EntitiesModule' },
            { path: 'case-audit-trail', loadChildren:() => import('./case-audit-trail/case-audit-trail.module').then(m=>m.CaseAuditTrailModule)},
            // { path: 'ar-case-closure', loadChildren: () => import( './ar-case-closure/ar-case-closure.module').then(m => m.ArCaseClosureModule },
             { path: 'investigation-findings-as', loadChildren: () => import( './investigation-findings-as/investigation-findings-as.module').then(m => m.InvestigationFindingsAsModule) },
             { path: 'transport', loadChildren: () => import( './transport/transport.module').then(m => m.TransportModule) },
             //{ path: 'as-oas', loadChildren: () => import( './as-oas/as-oas.module').then(m => m.AsOasModule' },
             //{ path: 'as-invstgn-plan', loadChildren: () => import( './as-investigation-plan/as-investigation-plan.module').then(m => m.AsInvestigationPlanModule' },
             { path: 'oh-placement', loadChildren: () => import( './out-of-home-placement/out-of-home-placement.module').then(m => m.OutOfHomePlacementModule) },
             { path: 'foster-care', loadChildren: () => import( './foster-care/foster-care.module').then(m => m.FosterCareModule) },
            // { path: 'monthly-report', loadChildren: () => import( './as-monthly-report/as-monthly-report.module').then(m => m.AsMonthlyReportModule' },
             { path: 'kinship-placement', loadChildren: () => import( './placement/kinship/kinship.module').then(m => m.KinshipModule) },
             // { path: 'visitor', loadChildren: () => import( './visitor/visitor.module').then(m => m.VisitorModule' },
             { path: 'court-action', loadChildren: () => import( './court-actions/court-actions.module').then(m => m.CourtActionsModule) },
            // { path: 'djs-restitution', loadChildren: () => import( './djs-restitution/djs-restitution.module').then(m => m.DjsRestitutionModule' },
             { path: 'placement-menu', loadChildren: () => import( './placement-menu/placement-menu.module').then(m => m.PlacementMenuModule) },
             { path: 'service-child-removal', loadChildren: () => import( './child-removal-list/child-removal-list.module').then(m => m.ChildRemovalListModule) },
             { path: 'service-foster-care', loadChildren: () => import( './service-foster-care/service-foster-care.module').then(m => m.ServiceFosterCareModule) },
             { path: 'family-findings', loadChildren: () => import('./family-findings/family-findings.module').then(m => m.FamilyFindingsModule) },
             { path: 'placement', loadChildren: () => import( './placement/placement.module').then(m => m.PlacementModule) },
             { path: 'relationship', loadChildren: () => import( '../../shared-pages/relationship-new/relationship-new.module').then(m => m.RelationshipNewModule) },
             { path: 'collateral', loadChildren: () => import( '../../shared-pages/collateral-new/collateral-new.module').then(m => m.CollateralNewModule) },
             { path: 'participation', loadChildren: () => import( './participations/participations.module').then(m => m.ParticipationsModule) },
             { path: 'payments',  loadChildren: () => import( './payments/payments.module').then(m => m.PaymentsModule)},
             { path: 'sc-placements', loadChildren: () => import( './service-case-placements/service-case-placements.module').then(m => m.ServiceCasePlacementsModule)},
             { path: 'sc-permanency-plan', loadChildren: () => import( './service-case-permanency-plan/service-case-permanency-plan.module').then(m => m.ServiceCasePermanencyPlanModule)},
             { path: 'in-home-service', loadChildren: () => import( './in-home-service/in-home-service.module').then(m => m.InHomeServiceModule)},
             { path: 'payment-history', loadChildren: () => import( './payment-history/payment-history.module').then(m => m.PaymentHistoryModule)},
             { path: 'provider-profile', loadChildren: () => import( './provider-profile/provider-profile.module').then(m => m.ProviderProfileModule)}
        ],
        data: {
            title: ['MDTHINK - Case Worker'],
            desc: 'Maryland department of human services',
            screen: { current: 'case-worker', [decodeURIComponent(atob('a2V5'))]: 'caseworker-module', includeMenus: true, modules: [], skip: false }
           }//encoded the variable key
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DsdsActionRoutingModule { }
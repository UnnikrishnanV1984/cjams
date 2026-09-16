import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MyNewintakeComponent } from './my-newintake.component';
import { MyNewintakeResolverService } from './my-newintake-resolver.service';
import { PurposeResolverService } from './purpose-resolver.service';
import { AppConstants } from '../../../@core/common/constants';
import { RoleGuard } from '../../../@core/guard';
import { PersonResolverService } from './person-resolver.service';
import { CommunicationResolverService } from './communication-resolver.service';

const routes: Routes = [
    {
        path: ':id/:mode',
        component: MyNewintakeComponent,
        resolve: {
            intake: MyNewintakeResolverService,
            communicationList: CommunicationResolverService,
            purposeList: PurposeResolverService,
            involvedPersonsList : PersonResolverService
        },
        canActivate: [RoleGuard],
        children: [
            {
                path: 'attachment',
                loadChildren: () => import( './intake-attachments/intake-attachments.module').then(m => m.IntakeAttachmentsModule),
            },
            {
                path: 'contact',
                loadChildren: () => import( '../../case-worker/dsds-action/recording/recording.module').then(m => m.RecordingModule),
            },
            {
                path: 'caseaudittrail',
                loadChildren: () => import( '../../case-worker/dsds-action/case-audit-trail/case-audit-trail.module').then(m => m.CaseAuditTrailModule),
            },
            {
                path: 'decision',
                loadChildren: () => import( './intake-decision/intake-decision.module').then(m => m.IntakeDecisionModule),
            },
            {
                path: 'disposition',
                loadChildren: () => import( './intake-disposition/intake-disposition.module').then(m => m.IntakeDispositionModule),
            },
            {
                path: 'entity',
                loadChildren: () => import( './intake-entities/intake-entities.module').then(m => m.IntakeEntitiesModule),
            },
            {
                path: 'person-cw',
                loadChildren: () => import( '../../shared-pages/involved-persons/involved-persons.module').then(m => m.InvolvedPersonsModule),
                data: { source: AppConstants.MODULE_TYPE.INTAKE }
            },

            {
                path: 'sdm',
                loadChildren: () => import( './intake-sdm/intake-sdm.module').then(m => m.IntakeSdmModule),
            },
             {
                 path: 'service-type',
                 loadChildren: () => import( './intake-service-type/intake-service-type.module').then(m => m.IntakeServiceTypeModule),
             },
             {
                 path: 'intake-referral',
                 loadChildren: () => import( './intake-referral/intake-referral.module').then(m => m.IntakeReferralModule),
             },
            {
                path: 'narrative',
                loadChildren: () => import( './newintake-narrative/newintake-narrative.module').then(m => m.NewintakeNarrativeModule),
            },
            {
                path: 'payment-schedule',
                loadChildren: () => import( '../../shared-pages/payment-schedule/payment-schedule.module').then(m=> m.PaymentScheduleModule),
                //loadChildren: () => import( 'app/pages/shared-pages/payment-schedule/payment-schedule.module').then(m=> m.PaymentScheduleModule),
                data: {
                    pageSource: AppConstants.PAGES.INTAKE_PAGE
                }
            },
            {
                path: 'roa',
                loadChildren: () => import( './intake-roa/intake-roa.module').then(m => m.IntakeRoaModule),
            },
            { path: 'relationship', loadChildren: () => import( '../../shared-pages/relationship-new/relationship-new.module').then(m => m.RelationshipNewModule) 
            },
			{
                path: 'history-clearance',
                loadChildren: () => import( './intake-history-clearance/intake-history-clearance.module').then(m => m.IntakeHistoryClearanceModule)
            },
            {
                path: 'adoption-subsidy',
                loadChildren: () => import( './intake-private-adoption/intake-private-adoption.module').then(m => m.IntakePrivateAdoptionModule)
            }
              ],
            data: {
                title: ['MDTHINK - Case Intake'],
                desc: 'Maryland department of human services',
                screen: { current: 'intake', key: 'myintake-module', includeMenus: true,  modules: [], skip: false }
            }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class MyNewintakeRoutingModule { }

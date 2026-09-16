import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../@core/guard';
import { PagesComponent } from './pages.component';
import { PersonInfoService } from './shared-pages/person-info/person-info.service';
import { NavigationUtils } from './_utils/navigation-utils.service';
import { IntakeUtils } from './_utils/intake-utils.service';
import { ReleaseNoteAccessResolver } from './release-note/release-note-resolver.service';

const routes: Routes = [
    {
        path: '',
        component: PagesComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'admin', loadChildren: () => import( './admin/admin.module').then(m => m.AdminModule) },
             { path: 'staff-management', loadChildren: () => import( './shared-pages/staff-mangement/staff-mangement.module').then(m => m.StaffMangementModule) },
             { path: 'newintake', loadChildren: () => import( './newintake/newintake.module').then(m => m.NewintakeModule) },
             { path: 'manage', loadChildren: () => import( './manage/manage.module').then(m => m.ManageModule) },
             { path: 'find', loadChildren: () => import( './find/find.module').then(m => m.FindModule) },
             { path: 'finance', loadChildren: () => import( './finance/finance.module').then(m => m.FinanceModule) },
              { path: 'case-worker', loadChildren: () => import( './case-worker/case-worker.module').then(m => m.CaseWorkerModule) },
             { path: 'case-search', loadChildren: () => import( './case-search/case-search.module').then(m => m.CaseSearchModule) },
             { path: 'home-dashboard', loadChildren: () => import( './home-dashboard/home-dashboard.module').then(m => m.HomeDashboardModule) },
            //  { path: 'transport-dboard', loadChildren: () => import( './transport-dboard/transport-dboard.module').then(m => m.TransportDboardModule' },
             { path: 'cjams-dashboard', loadChildren: () => import( './cjams-dashboard/cjams-dashboard.module').then(m => m.CjamsDashboardModule) },
             { path: 'calendar', loadChildren: () => import( './user-calendar/user-calendar.module').then(m => m.UserCalendarModule) },
             { path: 'notification', loadChildren: () => import( './notification/notification.module').then(m => m.NotificationModule) },
             { path: 'report', loadChildren: () => import( './report/report.module').then(m => m.ReportModule) },
             { path: 'resource', loadChildren: () => import( './resource/resource.module').then(m => m.ResourceModule) },
             { path: 'help', loadChildren: () => import( './help/help.module').then(m => m.HelpModule) },
             { path: 'services', loadChildren: () => import( './requested-service/requested-service.module').then(m => m.RequestedServiceModule) },
             { path: 'person-search', loadChildren: () => import( './person-search/person-search.module').then(m => m.PersonSearchModule) },
             { path: 'person-details', loadChildren: () => import( './person-details/person-details.module').then(m => m.PersonDetailsModule) },
             { path: 'person-info-cw', loadChildren: () => import( './shared-pages/person-info/person-info.module').then(m => m.PersonInfoModule) },
             { path: 'nytd-extract', loadChildren: () => import( './shared-pages/nytd-extract/nytd-extract.module').then(m => m.NytdExtractModule) },
             { path: 'placement-validation', loadChildren: () => import( './placement-validations/placement-validations.module').then(m => m.PlacementValidationsModule) },
             { path: 'title4e', loadChildren: () => import( './title4e/title4e.module').then(m => m.Title4eModule) },
             { path: 'reports', loadChildren: () => import( './generate-reports/generate-reports.module').then(m=>m.GenerateReportsModule) },
             { path: 'provider-search', loadChildren: () => import( './provider-search/provider-search.module').then(m => m.ProviderSearchModule) },
             { path: 'default-dashboard', loadChildren: () => import( './default-dashboard/default-dashboard.module').then(m => m.DefaultDashboardModule) },
             { path: 'reports/nytd', loadChildren: () => import( './../lib/nytd/nytd.module').then(m => m.NytdModule) },
             { path: 'provider-payment-management', loadChildren: () => import( './provider-payment-management/provider-payment-management.module').then(m => m.ProviderPaymentMgmtModule) },
             { path: 'contact-support', loadChildren: () => import( './contactlog-releasenotes/contactlog-releasenotes.module').then(m => m.ContactlogReleasenotesModule) },
             { path: 'release-notes', loadComponent: () => import( './release-note/release-note.component').then(m => m.ReleaseNoteComponent), resolve: { access: ReleaseNoteAccessResolver } },
             { path: 'psychotropicprescription-review', loadChildren: () => import( './psychotropicprescription-review/psychotropicprescription-review.module').then(m => m.PsychotropicprescriptionReviewModule) },
             { path: 'psychotropicprescription-report', loadChildren: () => import( './psychotropicprescription-review/psychotropicprescription-report/psychotropicprescription-report.module').then(m => m.PsychotropicprescriptionreportModule) },
             { path: 'beacon', loadChildren: () => import( './beacon/beacon.module').then(m => m.BeaconModule) }
        ],
        data: {
            screen: { modules: ['pages', 'menus'], skip: false }
        }
    }
];

@NgModule({
    imports: [
        RouterModule.forChild(routes)
    ],
    exports: [RouterModule],
    providers : [PersonInfoService, NavigationUtils, IntakeUtils],
})
export class PagesRoutingModule { }

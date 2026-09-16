import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonDetailsComponent } from './person-details.component';
import { RoleGuard } from '../../@core/guard';
import { PersonEducationDetailsComponent } from './person-education-details/person-education-details.component';
import { PersonWorksDetailsComponent } from './person-works-details/person-works-details.component';
import { PersonAddressDetailsComponent } from './person-address-details/person-address-details.component';
import { PersonDetailsService } from './person-details.service';
import { PersonDetailsResolverService } from './person-details-resolver.service';
import { PersonBasicDetailsService } from './person-basic-details/person-basic-details.service';
import { PersonEducationDetailsService } from './person-education-details/person-education-details.service';
import { PersonWorksDetailsService } from './person-works-details/person-works-details.service';

const routes: Routes = [
  {
    path: ':action/:personid',
    component: PersonDetailsComponent,
    children: [
      // { path: '', loadChildren: () => import( './person-basic-details/person-basic-details.module').then(m => m.PersonBasicDetailsModule' },
      { path: 'contact-detail', loadChildren: () => import( './contact-details/contact-details.module').then(m => m.ContactDetailsModule) },
      { path: 'basic', loadChildren: () => import( './person-basic-details/person-basic-details.module').then(m => m.PersonBasicDetailsModule) },
      { path: 'alerts', loadChildren: () => import( './person-alerts/person-alerts.module').then(m => m.PersonAlertsModule) },
      { path: 'health', loadChildren: () => import( './person-health/person-health.module').then(m => m.PersonHealthModule) },
      { path: 'education', component: PersonEducationDetailsComponent },
      { path: 'work', component: PersonWorksDetailsComponent },
      { path: 'relationship', loadChildren: () => import( './person-relationship/person-relationship.module').then(m => m.PersonRelationshipModule) },
      { path: 'address', component: PersonAddressDetailsComponent },
      { path: 'legal-actions', loadChildren: () => import( './person-history-details/person-history-details.module').then(m => m.PersonHistoryDetailsModule) },
      { path: 'client-event-history', loadChildren: () => import( './client-event-history/client-event-history.module').then(m => m.ClientEventHistoryModule) },
      { path: 'restitution', loadChildren: () => import( './person-restitution/person-restitution.module').then(m => m.PersonRestitutionModule) },
      { path: 'client-family-info', loadChildren: () => import( './person-client-family-info/person-client-family-info.module').then(m => m.PersonClientFamilyInfoModule) },
      { path: 'client-appointments', loadChildren: () => import( './person-client-appointments/person-client-appointments.module').then(m => m.PersonClientAppointmentsModule) },
      { path: 'client-summaries', loadChildren: () => import( './person-client-summaries/person-client-summaries.module').then(m => m.PersonClientSummariesModule) },
      { path: 'transport', loadChildren: () => import( './person-transport/person-transport.module').then(m => m.PersonTransportModule) },
      { path: 'other-agencies', loadChildren: () => import( './person-other-agencies/person-other-agencies.module').then(m => m.PersonOtherAgenciesModule) },
      { path: 'audit-trail', loadChildren: () => import( './person-audit-trail/person-audit-trail.module').then(m => m.PersonAuditTrailModule) },
      { path: 'assesments', loadChildren: () => import( './person-assesments/person-assesments.module').then(m => m.PersonAssesmentsModule) },
      { path: 'documents', loadChildren: () => import( './person-documents/person-documents.module').then(m => m.PersonDocumentsModule) },
      { path: 'investigation', loadChildren: () => import( './person-investigation/person-investigation.module').then(m => m.PersonInvestigationModule) },
      { path: 'physcial-attributes', loadChildren: () => import( './physical-attributes/physical-attributes.module').then(m => m.PhysicalAttributesModule) },
      { path: 'youth-status', loadChildren: () => import( './person-youthstatus/person-youthstatus.module').then(m => m.PersonYouthstatusModule) },
      { path: 'status-summary', loadChildren: () => import( './person-status-summary/person-status-summary.module').then(m => m.PersonStatusSummaryModule) },
      // { path: 'probation', loadChildren: () => import( './person-probation/person-probation.module').then(m => m.PersonProbationModule) },
      { path: '**', redirectTo: 'basic' }
    ],
    canActivate: [RoleGuard],
    data: {
      screen: { modules: ['pages', 'menus'], skip: false }
    },
    resolve: {
      personDetails: PersonDetailsResolverService
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
  providers: [PersonDetailsService, PersonDetailsResolverService, PersonBasicDetailsService, PersonEducationDetailsService, PersonWorksDetailsService]
})
export class PersonDetailsRoutingModule { }

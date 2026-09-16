import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { YouthTransitionPlanComponent } from './youth-transition-plan.component';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
import { YouthTransitionPlanRoutingModule } from './youth-transition-plan-routing.module';
import { YTPClientSelectorComponent } from './ytp-client-selector/ytp-client-selector.component';
import { PersonService } from '../../in-home-service/person.service';
import { YtpSummaryComponent } from './ytp-summary/ytp-summary.component';
import { YtpDocumentationComponent } from './ytp-documentation/ytp-documentation.component';
import { YtpThoughtsAndIdeasComponent } from './ytp-thoughts-and-ideas/ytp-thoughts-and-ideas.component';
import { YtpSupportiveRelationshipsComponent } from './ytp-supportive-relationships/ytp-supportive-relationships.component';
import { YtpHealthComponent } from './ytp-health/ytp-health.component';
import { YtpMoneyManagementComponent } from './ytp-money-management/ytp-money-management.component';
import { YtpHousingComponent } from './ytp-housing/ytp-housing.component';
import { YtpEducationComponent } from './ytp-education/ytp-education.component';
import { YtpEmploymentComponent } from './ytp-employment/ytp-employment.component';
import { ShortTermGoalsModule } from './shared-feature/short-term-goals/short-term-goals.module';
import { QaListComponent } from './shared-feature/qa-list/qa-list.component';
import { YouthTransitionPlanService } from './youth-transition-plan.service';
import { ChildRemovalService } from '../../child-removal/child-removal.service';
import { PersonDisabilityService } from '../../../../shared-pages/person-disability/person-disability.service';
import { SpecificHealthIssuesComponent } from './ytp-health/specific-health-issues/specific-health-issues.component';
import { DocumentUploadListComponent } from './shared-feature/document-upload-list/document-upload-list.component';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { AuditDataModule } from '../../../../../shared/shared-components/audit-data/audit-data.module';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { ShareFeaturesModule } from '../../../../shared-pages/person-info/share-features/share-features.module';
import { NewYouthTransitionPlanModule } from '../youth-transition-plan-new/youth-transition-plan.module';
@NgModule({
  imports: [
    CommonModule,
    YouthTransitionPlanRoutingModule,
    FormMaterialModule,
    ShortTermGoalsModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    SharedPipesModule,
    AuditDataModule,
ShareFeaturesModule,
    SharedDirectivesModule,
    NewYouthTransitionPlanModule
  ],
  declarations: [
    YouthTransitionPlanComponent,
    YTPClientSelectorComponent,
    YtpSummaryComponent,
    YtpThoughtsAndIdeasComponent,
    YtpDocumentationComponent,
    YtpSupportiveRelationshipsComponent,
    YtpHealthComponent,
    YtpMoneyManagementComponent,
    YtpHousingComponent,
    YtpEducationComponent,
    YtpEmploymentComponent,
    QaListComponent,
    SpecificHealthIssuesComponent,
    DocumentUploadListComponent
  ],
  providers: [
    PersonService,
    YouthTransitionPlanService,
    ChildRemovalService,
    PersonDisabilityService
  ]
})
export class YouthTransitionPlanModule { }
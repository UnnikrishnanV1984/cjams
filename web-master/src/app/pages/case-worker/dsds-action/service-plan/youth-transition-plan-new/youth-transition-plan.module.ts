import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { YouthTransitionPlanComponent } from './youth-transition-plan.component';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
import { YouthTransitionPlanRoutingModule } from './youth-transition-plan-routing.module';
import { YTPClientSelectorComponent } from './ytp-client-selector/ytp-client-selector.component';
import { PersonService } from '../../in-home-service/person.service';
import { YtpSummaryComponent } from './ytp-summary/ytp-summary.component';
import { YtpDocumentationComponent } from './ytp-documentation/ytp-documentation.component';
import { YtpSupportiveRelationshipsComponent } from './ytp-supportive-relationships/ytp-supportive-relationships.component';
import { YtpHealthComponent } from './ytp-health/ytp-health.component';
import { YtpMoneyManagementComponent } from './ytp-money-management/ytp-money-management.component';
import { YtpHousingComponent } from './ytp-housing/ytp-housing.component';
import { YtpEducationComponent } from './ytp-education/ytp-education.component';
import { YtpCommunityComponent } from './ytp-community/ytp-community.component';
import { YtpTransportComponent } from './ytp-transport/ytp-transport.component';
import { YtpEmploymentComponent } from './ytp-employment/ytp-employment.component';
import { YtpMeetingComponent } from './ytp-meeting/ytp-meeting.component';
import { ShortTermGoalsModule } from './shared-feature/short-term-goals/short-term-goals.module';
import { MeetingGoalsModule } from './shared-feature/meeting-goals/meeting-goals.module';
import { EducationGoalsModule } from './shared-feature/education-goals/education-goals.module';
import { QaListComponent } from './shared-feature/qa-list/qa-list.component';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
// import {A2Edatetimepicker} from 'ng2-eonasdan-datetimepicker';
import { YouthTransitionPlanService } from './youth-transition-plan.service';
import { ChildRemovalService } from '../../child-removal/child-removal.service';
import { PersonDisabilityService } from '../../../../shared-pages/person-disability/person-disability.service';
import { SpecificHealthIssuesComponent } from './ytp-health/specific-health-issues/specific-health-issues.component';
import { DocumentUploadListComponent } from './shared-feature/document-upload-list/document-upload-list.component';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { ToDoActionItemsModule } from './shared-feature/to-do-action-items/to-do-action-items.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { SharedComponentsModule } from '../../../../../shared/shared-components/shared-components.module';
import { MatTimepickerModule } from '@angular/material/timepicker';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';

import { YtpHelpPopoverComponent } from './ytp-help-popover/ytp-help-popover.component';
import { YtpFosterCareGaurdianshipChecklistComponent } from './ytp-fc-gs-checklist/ytp-fc-gs-checklist.component';
import { ShareFeaturesModule } from '../../../../shared-pages/person-info/share-features/share-features.module';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { YtpFcgsAuditComponent } from './ytp-fcgs-audit/ytp-fcgs-audit.component';
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { DocumentUploadListSharedModule } from '../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { AuditDataModule } from '../../../../../shared/shared-components/audit-data/audit-data.module';

export const MY_MOMENT_FORMATS = {
  parseInput: 'MM/DD/YYYY h:mm A',
  fullPickerInput: 'MM/DD/YYYY h:mm A',
  datePickerInput: 'MM/DD/YYYY h:mm A',
  timePickerInput: 'h:mm A',
  monthYearLabel: 'MMM YYYY',
  dateA11yLabel: 'LL',
  monthYearA11yLabel: 'MMMM YYYY',
};
@NgModule({
  imports: [
    CommonModule,
    YouthTransitionPlanRoutingModule,
    FormMaterialModule,
    ShortTermGoalsModule,
    MeetingGoalsModule,
    EducationGoalsModule,
    ToDoActionItemsModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    // A2Edatetimepicker,
    // SharedComponentsModule,
    PaginationModule,
    SharedPipesModule,
    ShareFeaturesModule,
    PopoverModule,
    NgxMaskDirective,
    NgxMaskPipe,
    MatMomentDatetimeModule, MatDatetimepickerModule,
    MatTimepickerModule,
    OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule, DocumentUploadListSharedModule, AttachmentUploadsharedModule, SignatureFieldModule,
    AuditDataModule
  ],
  declarations: [
    YouthTransitionPlanComponent, 
    YTPClientSelectorComponent,
    YtpSummaryComponent,
    YtpDocumentationComponent,
    YtpSupportiveRelationshipsComponent,
    YtpHealthComponent,
    YtpMoneyManagementComponent,
    YtpHousingComponent,
    YtpEducationComponent,
    YtpCommunityComponent,
    YtpEmploymentComponent,
    YtpTransportComponent,
    YtpMeetingComponent,
    QaListComponent,
    SpecificHealthIssuesComponent,
    DocumentUploadListComponent,
    YtpHelpPopoverComponent,
    YtpFosterCareGaurdianshipChecklistComponent,
    YtpFcgsAuditComponent
  ],
  exports:[
    YtpHelpPopoverComponent
  ],
  providers: [
    PersonService,
    YouthTransitionPlanService,
    ChildRemovalService,
    PersonDisabilityService,
    provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }
  ]
})
export class NewYouthTransitionPlanModule { }
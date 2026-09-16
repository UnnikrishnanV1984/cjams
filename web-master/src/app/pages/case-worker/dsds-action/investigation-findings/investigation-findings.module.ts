import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { InvestigationFindingsRoutingModule } from './investigation-findings-routing.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { InvestigationFindingsComponent } from './investigation-findings.component';
import { InvestigationAppealComponent } from './investigation-appeal/investigation-appeal.component';
import { InvestigationComaComponent } from './investigation-coma/investigation-coma.component';
import { QuillModule } from 'ngx-quill';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { MatTooltipModule } from '@angular/material/tooltip';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { InvestigationSummaryReportComponent } from './investigation-summary-report/investigation-summary-report.component';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { YouthTransitionPlanModule } from '../service-plan/youth-transition-plan/youth-transition-plan.module';
import { InvestigationFindingsResolverService } from './investigation-findings-resolver';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';

@NgModule({
  imports: [
    CommonModule,
    InvestigationFindingsRoutingModule,
    MatTooltipModule,
    FormMaterialModule, ControlMessagesModule, NgSelectModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    QuillModule.forRoot(),
    ControlMessagesModule,
    SharedPipesModule,
    YouthTransitionPlanModule,
    // ShareFeaturesModule,
    // SharedComponentsModule,
    NgxMaskDirective,
    NgxMaskPipe,
    GlobalPopupModule,
    DocumentUploadListSharedModule, AttachmentUploadsharedModule
   ],
  declarations: [InvestigationFindingsComponent, InvestigationAppealComponent, InvestigationComaComponent, InvestigationSummaryReportComponent],
  exports: [InvestigationSummaryReportComponent],
  providers:[InvestigationFindingsResolverService,provideNgxMask()]
})
export class InvestigationFindingsModule { }
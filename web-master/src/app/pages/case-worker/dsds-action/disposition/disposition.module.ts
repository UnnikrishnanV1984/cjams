import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DispositionComponent } from './disposition.component';
import { DispositionRoutingModule } from './disposition-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import {InvestigationReportComponent} from '../disposition/investigation-report/investigation-report.component';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { DispositionResolverService } from './disposition-resolver.service';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { CpsDocLetterModule } from '../../../../pages/newintake/my-newintake/intake-document-creator/cps-doc-letter/cps-doc-letter.module';

@NgModule({
  imports: [
    CommonModule,
    DispositionRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot(),
    PaginationModule,
    NgSelectModule,
    // SharedComponentsModule,
    GlobalPopupModule, DocumentUploadListSharedModule, AttachmentUploadsharedModule, 
    CpsDocLetterModule
  ],
  declarations: [
    DispositionComponent,
    InvestigationReportComponent
  ],
  providers: [DispositionResolverService]
})
export class DispositionModule { }

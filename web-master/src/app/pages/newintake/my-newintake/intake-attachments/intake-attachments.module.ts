import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeAttachmentsRoutingModule } from './intake-attachments-routing.module';
import { IntakeAttachmentsComponent } from './intake-attachments.component';
import { AudioRecordComponent } from './audio-record/audio-record.component';
import { VideoRecordComponent } from './video-record/video-record.component';
import { ImageRecordComponent } from './image-record/image-record.component';
import { AttachmentUploadComponent } from './attachment-upload/attachment-upload.component';
import { AttachmentDetailComponent } from './attachment-detail/attachment-detail.component';
import { EditAttachmentComponent } from './edit-attachment/edit-attachment.component';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PdfViewerModule } from 'ng2-pdf-viewer';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective, NgxfUploaderService } from 'ngxf-uploader';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { MatMenuModule } from '@angular/material/menu';
// import { SharedComponentsModule } from './../../../../shared/shared-components/shared-components.module';
import { ScanAttachemntComponent } from './scan-attachemnt/scan-attachemnt.component';
import { ScanSharedAttachementModule } from './../../../../shared/shared-components/scan-shared-attachement/scan-shared-attachement.module';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
@NgModule({
  imports: [
    CommonModule,
    IntakeAttachmentsRoutingModule,
    SharedPipesModule,
    FormMaterialModule,
    PdfViewerModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    ControlMessagesModule,
    // A2Edatetimepicker,
    NgSelectModule,
    PaginationModule,
    SortTableModule,
    MatMenuModule,
    // SharedComponentsModule,
    ScanSharedAttachementModule,
    DocumentUploadListSharedModule,
    AttachmentUploadsharedModule

  ],
  declarations: [IntakeAttachmentsComponent,
    AudioRecordComponent,
    VideoRecordComponent,
    ImageRecordComponent,
    AttachmentDetailComponent,
    AttachmentUploadComponent,
    AttachmentDetailComponent,
    EditAttachmentComponent,
    ScanAttachemntComponent

  ],
  providers: [SpeechRecognitionService, SpeechRecognizerService, NgxfUploaderService]
})
export class IntakeAttachmentsModule { }

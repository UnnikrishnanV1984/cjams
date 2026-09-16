import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { AttachmentDetailComponent } from './attachment-detail/attachment-detail.component';
import { AttachmentRoutingModule } from './attachment-routing.module';
import { AttachmentUploadComponent } from './attachment-upload/attachment-upload.component';
import { AttachmentComponent } from './attachment.component';
import { AudioRecordComponent } from './audio-record/audio-record.component';
import { ImageRecordComponent } from './image-record/image-record.component';
import { VideoRecordComponent } from './video-record/video-record.component';
import { ScanAttachmentComponent } from './scan-attachment/scan-attachment.component';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { EditAttachmentComponent } from './edit-attachment/edit-attachment.component';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatTooltipModule } from '@angular/material/tooltip';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import {AttachmentResolverService} from './attachment-resolver-service'
import { MatMenuModule } from '@angular/material/menu';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { AttachmentService } from './attachment.service';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { ScanSharedAttachementModule } from '../../../../shared/shared-components/scan-shared-attachement/scan-shared-attachement.module';

@NgModule({
    imports: [
        CommonModule,
        AttachmentRoutingModule,
        MatCheckboxModule,
        MatTooltipModule,
        MatMenuModule,
        FormsModule,
        ReactiveFormsModule,
        // A2Edatetimepicker,
        ControlMessagesModule,
        NgSelectModule, SharedPipesModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        FormMaterialModule,
        PaginationModule,
        SortTableModule,
        // SharedComponentsModule,
        NgxMaskDirective,
        NgxMaskPipe,
         DocumentUploadListSharedModule, AttachmentUploadsharedModule, ScanSharedAttachementModule
    ],
    
    declarations: [
        AttachmentComponent,
        VideoRecordComponent,
        ImageRecordComponent,
        AudioRecordComponent,
        ScanAttachmentComponent,
        AttachmentUploadComponent,
        AttachmentDetailComponent,
        EditAttachmentComponent
    ],
    providers:[AttachmentResolverService, AttachmentService, provideNgxMask()]
})
export class AttachmentModule { }
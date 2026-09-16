import { NgModule } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { RecordingRoutingModule } from './recording-routing.module';
import { NotesComponent } from './notes/notes.component';
import { FamilyInvolvementMeetingComponent } from '../../../../../../src/app/pages/case-worker/dsds-action/recording/family-involvement-meeting/family-involvement-meeting.component';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { RecordingComponent } from './recording.component';
import { ResourceConsultComponent } from './resource-consult/resource-consult.component';
import { QuillModule } from 'ngx-quill';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { DocumentUploadListComponent } from './document-upload-list/document-upload-list.component';
import { AttachmentUploadComponent } from './attachment-upload/attachment-upload.component';
import { VisitationLogComponent } from './visitation-log/visitation-log.component';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { RecordingResolverService } from './recording-resolver-service';
import { CommonControlsModule } from '../../../../shared/modules/common-controls/common-controls.module';
import { ToastrModule, ToastrService } from 'ngx-toastr';
import { DeactivateGuard } from './notes/deactivate-guard';
import { NgxEditorModule } from "ngx-editor";
import { MatMenuModule } from '@angular/material/menu'
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { TransferHistoryApprovedService } from '../../../../shared/services/transfer-history-approved.service';
import { NgxMaskDirective, NgxMaskPipe, provideNgxMask } from 'ngx-mask';
import {MatTimepickerModule} from '@angular/material/timepicker';
import { MatTooltipModule } from '@angular/material/tooltip';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';

@NgModule({
  imports: [
    CommonModule,
    CommonControlsModule,
    RecordingRoutingModule,
    CommonModule,
    MatSelectModule,
    ReactiveFormsModule,
    PopoverModule,
    FormsModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatCardModule,
    MatInputModule,
    MatNativeDateModule,
    MatRadioModule,
    
    ControlMessagesModule,
    NgSelectModule,
    PaginationModule,
    // A2Edatetimepicker,
    SharedPipesModule,
    QuillModule.forRoot(),
    PaginationModule,
    NgxMaskDirective,
     NgxMaskPipe,
    SharedDirectivesModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    MatListModule,
    MatExpansionModule,
    SortTableModule,
    MatProgressSpinnerModule,
    ToastrModule.forRoot({
      positionClass :'toast-bottom-full-width'
    }),
    NgxEditorModule,
    MatMenuModule,
    MatTimepickerModule,
    // SharedComponentsModule,
    MatTooltipModule,
    FormMaterialModule,
    DocumentUploadListSharedModule, AttachmentUploadsharedModule, GlobalPopupModule
  ],
  declarations: [RecordingComponent, NotesComponent, FamilyInvolvementMeetingComponent, ResourceConsultComponent
    ,DocumentUploadListComponent
    ,AttachmentUploadComponent
    , VisitationLogComponent],
  providers: [DatePipe, ToastrService, RecordingResolverService, DeactivateGuard, 
    TransferHistoryApprovedService,provideNgxMask()
  ],
})
export class RecordingModule { }
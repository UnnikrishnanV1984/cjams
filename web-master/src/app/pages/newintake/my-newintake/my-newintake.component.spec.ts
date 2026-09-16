import { CommonModule } from '@angular/common';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import {
  MatButtonModule,
  MatDatepickerModule,
  MatFormFieldModule,
  MatInputModule,
  MatNativeDateModule,
  MatRadioModule,
  MatSelectModule,
  MatTabsModule,
} from '@angular/material';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule, PopoverModule, TimepickerModule } from 'ngx-bootstrap';
import { ImageCropperComponent } from 'ngx-image-cropper';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { TrumbowygNgxModule } from 'trumbowyg-ngx';

import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import {
  AttachmentDetailComponent,
} from '../../case-worker/dsds-action/attachment/attachment-detail/attachment-detail.component';
import {
  AttachmentUploadComponent,
} from '../../case-worker/dsds-action/attachment/attachment-upload/attachment-upload.component';
import { AudioRecordComponent } from '../../case-worker/dsds-action/attachment/audio-record/audio-record.component';
import { ImageRecordComponent } from '../../case-worker/dsds-action/attachment/image-record/image-record.component';
import { VideoRecordComponent } from '../../case-worker/dsds-action/attachment/video-record/video-record.component';
import { IntakeAssessmentComponent } from './intake-assessment/intake-assessment.component';
import { EditAttachmentComponent } from './intake-attachments/edit-attachment/edit-attachment.component';
import { IntakeAttachmentsComponent } from './intake-attachments/intake-attachments.component';
import { IntakeCommunicationsComponent } from './intake-communications/intake-communications.component';
import { IntakeComplaintTypeComponent } from './intake-complaint-type/intake-complaint-type.component';
import {
  PdfPeaceOrderAppealLetterComponent,
} from './intake-complaint-type/pdf-peace-order-appeal-letter/pdf-peace-order-appeal-letter.component';
import { IntakeCrossRefferenceComponent } from './intake-cross-refference/intake-cross-refference.component';
import { IntakeDispositionComponent } from './intake-disposition/intake-disposition.component';
import { IntakeEntitiesComponent } from './intake-entities/intake-entities.component';
import { IntakeEvaluationFieldsComponent } from './intake-evaluation-fields/intake-evaluation-fields.component';
import { IntakePersonSearchComponent } from './intake-persons-involved/intake-person-search.component';
import { IntakePersonsInvolvedComponent } from './intake-persons-involved/intake-persons-involved.component';
import { MyNewintakeRoutingModule } from './my-newintake-routing.module';
import { MyNewintakeComponent } from './my-newintake.component';
import { NewintakeNarrativeComponent } from './newintake-narrative/newintake-narrative.component';

describe('MyNewintakeComponent', () => {
    let component: MyNewintakeComponent;
    let fixture: ComponentFixture<MyNewintakeComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
            // tslint:disable-next-line:max-line-length
            imports: [
                CommonModule,
                MatDatepickerModule,
                MatNativeDateModule,
                MatFormFieldModule,
                MatInputModule,
                MatSelectModule,
                MatButtonModule,
                MatRadioModule,
                MatTabsModule,
                MyNewintakeRoutingModule,
                FormsModule,
                ReactiveFormsModule,
                PaginationModule,
                TimepickerModule,
                ControlMessagesModule,
                SharedDirectivesModule,
                SharedPipesModule,
                NgSelectModule,
                ImageCropperComponent,
                SortTableModule,
                
                TrumbowygNgxModule.withConfig({
                    svgPath: '../../../../assets/images/icons.svg'
                }),
                A2Edatetimepicker,
                
                PopoverModule,
                NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective
            ],
            declarations: [
                MyNewintakeComponent,
                MyNewintakeComponent,
                NewintakeNarrativeComponent,
                IntakePersonsInvolvedComponent,
                IntakeEntitiesComponent,
                // IntakeServiceSubtypeComponent,
                IntakeAssessmentComponent,
                IntakeCrossRefferenceComponent,
                IntakeCommunicationsComponent,
                IntakeAttachmentsComponent,
                IntakePersonSearchComponent,
                AudioRecordComponent,
                VideoRecordComponent,
                ImageRecordComponent,
                AttachmentUploadComponent,
                AttachmentDetailComponent,
                EditAttachmentComponent,
                IntakeDispositionComponent,
                IntakeEvaluationFieldsComponent,
                IntakeComplaintTypeComponent,
                PdfPeaceOrderAppealLetterComponent
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(MyNewintakeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

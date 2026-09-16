import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import {
  AttachmentDetailComponent,
} from '../../../case-worker/dsds-action/attachment/attachment-detail/attachment-detail.component';
import {
  AttachmentUploadComponent,
} from '../../../case-worker/dsds-action/attachment/attachment-upload/attachment-upload.component';
import { AudioRecordComponent } from '../../../case-worker/dsds-action/attachment/audio-record/audio-record.component';
import { ImageRecordComponent } from '../../../case-worker/dsds-action/attachment/image-record/image-record.component';
import { VideoRecordComponent } from '../../../case-worker/dsds-action/attachment/video-record/video-record.component';
import { IntakeAssessmentComponent } from '../intake-assessment/intake-assessment.component';
import { IntakeCommunicationsComponent } from '../intake-communications/intake-communications.component';
import { IntakeComplaintTypeComponent } from '../intake-complaint-type/intake-complaint-type.component';
import {
  PdfPeaceOrderAppealLetterComponent,
} from '../intake-complaint-type/pdf-peace-order-appeal-letter/pdf-peace-order-appeal-letter.component';
import { IntakeCrossRefferenceComponent } from '../intake-cross-refference/intake-cross-refference.component';
import { IntakeDispositionComponent } from '../intake-disposition/intake-disposition.component';
import { IntakeEntitiesComponent } from '../intake-entities/intake-entities.component';
import { IntakeEvaluationFieldsComponent } from '../intake-evaluation-fields/intake-evaluation-fields.component';
import { IntakePersonSearchComponent } from '../intake-persons-involved/intake-person-search.component';
import { IntakePersonsInvolvedComponent } from '../intake-persons-involved/intake-persons-involved.component';

import { MyNewintakeComponent } from '../my-newintake.component';
import { NewintakeNarrativeComponent } from '../newintake-narrative/newintake-narrative.component';
import { EditAttachmentComponent } from './edit-attachment/edit-attachment.component';
import { IntakeAttachmentsComponent } from './intake-attachments.component';
import { IntakeServiceSubtypeComponent } from '../../../provider-referral/new-referral/intake-service-subtype/intake-service-subtype.component';

xdescribe('IntakeAttachmentsComponent', () => {
    let component: IntakeAttachmentsComponent;
    let fixture: ComponentFixture<IntakeAttachmentsComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [
        IntakeAttachmentsComponent,
        MyNewintakeComponent,
        NewintakeNarrativeComponent,
        IntakePersonsInvolvedComponent,
        IntakeEntitiesComponent,
        IntakeServiceSubtypeComponent,
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
    ],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(IntakeAttachmentsComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

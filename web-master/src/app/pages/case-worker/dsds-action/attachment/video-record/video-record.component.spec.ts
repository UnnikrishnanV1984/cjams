import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective, NgxfUploaderService } from 'ngxf-uploader';

import { CoreModule } from '../../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { AttachmentDetailComponent } from '../attachment-detail/attachment-detail.component';
import { AttachmentUploadComponent } from '../attachment-upload/attachment-upload.component';
import { AttachmentComponent } from '../attachment.component';
import { AudioRecordComponent } from '../audio-record/audio-record.component';
import { ImageRecordComponent } from '../image-record/image-record.component';
import { VideoRecordComponent } from './video-record.component';

describe('VideoRecordComponent', () => {
    let component: VideoRecordComponent;
    let fixture: ComponentFixture<VideoRecordComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [
        VideoRecordComponent,
        AttachmentDetailComponent,
        AttachmentComponent,
        VideoRecordComponent,
        ImageRecordComponent,
        AudioRecordComponent,
        AttachmentUploadComponent,
        AttachmentDetailComponent,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective
    ],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        AttachmentDetailComponent],
    providers: [NgxfUploaderService, provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(VideoRecordComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

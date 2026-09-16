import { CommonModule } from '@angular/common';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective, NgxfUploaderService } from 'ngxf-uploader';

import { CoreModule } from '../../../../../@core/core.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { AttachmentRoutingModule } from '../attachment-routing.module';
import { AttachmentUploadComponent } from './attachment-upload.component';

describe('AttachmentUploadComponent', () => {
    let component: AttachmentUploadComponent;
    let fixture: ComponentFixture<AttachmentUploadComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [AttachmentUploadComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        CommonModule,
        AttachmentRoutingModule,
        FormsModule,
        ReactiveFormsModule,
        A2Edatetimepicker,
        ControlMessagesModule,
        NgSelectModule,
        SharedPipesModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        NgxMaskDirective,
        NgxMaskPipe],
    providers: [NgxfUploaderService, provideNgxMask(), provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AttachmentUploadComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

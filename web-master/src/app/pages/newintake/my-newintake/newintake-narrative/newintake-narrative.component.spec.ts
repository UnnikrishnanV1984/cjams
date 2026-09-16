import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { ComponentLoaderFactory, PaginationModule, PopoverConfig, PopoverModule, PositioningService } from 'ngx-bootstrap';
import { NgxfUploaderService } from 'ngxf-uploader';

import { CoreModule } from '../../../../@core/core.module';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { NewintakeNarrativeComponent } from './newintake-narrative.component';

describe('NewintakeNarrativeComponent', () => {
    let component: NewintakeNarrativeComponent;
    let fixture: ComponentFixture<NewintakeNarrativeComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [NewintakeNarrativeComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule,
        PopoverModule],
    providers: [SpeechRecognizerService, NgxfUploaderService, SpeechRecognitionService, PopoverConfig, ComponentLoaderFactory, PositioningService, provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(NewintakeNarrativeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

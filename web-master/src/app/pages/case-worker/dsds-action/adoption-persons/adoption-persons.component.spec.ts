import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgxfUploaderService } from 'ngxf-uploader';

import { CoreModule } from '../../../../@core/core.module';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { AdoptionPersonsComponent } from './adoption-persons.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PopoverConfig, PopoverModule } from 'ngx-bootstrap/popover';
import { ComponentLoaderFactory } from 'ngx-bootstrap/component-loader';
import { PositioningService } from 'ngx-bootstrap/positioning';

describe('AdoptionPersonsComponent', () => {
    let component: AdoptionPersonsComponent;
    let fixture: ComponentFixture<AdoptionPersonsComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [AdoptionPersonsComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        // A2Edatetimepicker,
        RouterModule,
        PopoverModule],
    providers: [SpeechRecognizerService, NgxfUploaderService, SpeechRecognitionService, PopoverConfig, ComponentLoaderFactory, PositioningService, provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AdoptionPersonsComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

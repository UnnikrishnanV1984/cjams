import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { FormLetterTemplateComponent } from './form-letter-template.component';
import { FormLetterTemplateModule } from './form-letter-template.module';
import { LibraryDocumentComponent } from './library-document.component';
import { MergeTemplateDocumentMappingComponent } from './merge-template-document-mapping.component';
import { MergeTemplateDocumentComponent } from './merge-template-document.component';

describe('FormLetterTemplateComponent', () => {
    let component: FormLetterTemplateComponent;
    let fixture: ComponentFixture<FormLetterTemplateComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [FormLetterTemplateComponent, LibraryDocumentComponent, MergeTemplateDocumentComponent, MergeTemplateDocumentMappingComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        FormLetterTemplateModule,
        NgSelectModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(FormLetterTemplateComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

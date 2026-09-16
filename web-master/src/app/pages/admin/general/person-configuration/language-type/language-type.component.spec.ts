import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { AdminSharedModule } from '../../../_shared/admin-shared.module';
import { LanguageTypeComponent } from './language-type.component';

describe('LanguageTypeComponent', () => {
    let component: LanguageTypeComponent;
    let fixture: ComponentFixture<LanguageTypeComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [LanguageTypeComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule, AdminSharedModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(LanguageTypeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

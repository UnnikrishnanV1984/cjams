import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { NonContractingTypeComponent } from './non-contracting-type.component';

describe('NonContractingTypeComponent', () => {
    let component: NonContractingTypeComponent;
    let fixture: ComponentFixture<NonContractingTypeComponent>;
    let expected: 'nonContractingType';
    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [NonContractingTypeComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(NonContractingTypeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });
    afterEach(() => {
        // No content or function to call or add
    });

    it('should create', () => {
        expect((component)).toBeTruthy();
    });
});

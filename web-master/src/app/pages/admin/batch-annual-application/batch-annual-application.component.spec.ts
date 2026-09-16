import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BatchAnnualApplicationComponent } from './batch-annual-application.component';
import { RouterTestingModule } from '@angular/router/testing';
import { CoreModule } from '../../../@core/core.module';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule, PaginationConfig } from 'ngx-bootstrap';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';

describe('BatchAnnualApplicationComponent', () => {
    let component: BatchAnnualApplicationComponent;
    let fixture: ComponentFixture<BatchAnnualApplicationComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [BatchAnnualApplicationComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule],
    providers: [PaginationConfig, provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(BatchAnnualApplicationComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../../../shared/modules/control-messages/control-messages.module';
import { InvestigationPlanExceptionTaskComponent } from './investigation-plan-exception-task.component';

describe('InvestigationPlanExceptionTaskComponent', () => {
    let component: InvestigationPlanExceptionTaskComponent;
    let fixture: ComponentFixture<InvestigationPlanExceptionTaskComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [InvestigationPlanExceptionTaskComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(InvestigationPlanExceptionTaskComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

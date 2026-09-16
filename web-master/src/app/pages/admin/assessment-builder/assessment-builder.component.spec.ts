import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { AssessmentBuilderComponent } from './assessment-builder.component';

describe('AssessmentBuilderComponent', () => {
    let component: AssessmentBuilderComponent;
    let fixture: ComponentFixture<AssessmentBuilderComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [AssessmentBuilderComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule, SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AssessmentBuilderComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

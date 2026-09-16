import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../../../../shared/modules/control-messages/control-messages.module';
import { InvolvedPersonClearingCheckDmhComponent } from './involved-person-clearing-check-dmh.component';

describe('InvolvedPersonClearingCheckDmhComponent', () => {
    let component: InvolvedPersonClearingCheckDmhComponent;
    let fixture: ComponentFixture<InvolvedPersonClearingCheckDmhComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [InvolvedPersonClearingCheckDmhComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(InvolvedPersonClearingCheckDmhComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

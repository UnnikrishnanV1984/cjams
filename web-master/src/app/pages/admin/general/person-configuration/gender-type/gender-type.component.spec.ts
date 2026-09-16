import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { AdminSharedModule } from '../../../_shared/admin-shared.module';
import { GenderTypeComponent } from './gender-type.component';

describe('GenderTypeComponent', () => {
    let component: GenderTypeComponent;
    let fixture: ComponentFixture<GenderTypeComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [GenderTypeComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule, AdminSharedModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(GenderTypeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

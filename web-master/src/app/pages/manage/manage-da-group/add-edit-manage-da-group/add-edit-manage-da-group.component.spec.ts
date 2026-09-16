import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { BsDatepickerModule, PaginationModule } from 'ngx-bootstrap';

import { CoreModule } from '../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { AddEditManageDaGroupComponent } from './add-edit-manage-da-group.component';

describe('AddEditManageDaGroupComponent', () => {
    let component: AddEditManageDaGroupComponent;
    let fixture: ComponentFixture<AddEditManageDaGroupComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [AddEditManageDaGroupComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule,
        BsDatepickerModule.forRoot()],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AddEditManageDaGroupComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

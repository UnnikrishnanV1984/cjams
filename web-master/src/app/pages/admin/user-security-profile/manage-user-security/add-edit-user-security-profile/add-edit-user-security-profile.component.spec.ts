import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../../@core/core.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { ManageUserSecurityComponent } from '../manage-user-security.component';
import { AddEditUserSecurityProfileComponent } from './add-edit-user-security-profile.component';
import { EquipmentComponent } from './equipment/equipment.component';
import { RolesLoginDetailsComponent } from './roles-login-details/roles-login-details.component';
import { UserProfileComponent } from './user-profile/user-profile.component';

describe('AddEditUserSecurityProfileComponent', () => {
    let component: AddEditUserSecurityProfileComponent;
    let fixture: ComponentFixture<AddEditUserSecurityProfileComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [AddEditUserSecurityProfileComponent, ManageUserSecurityComponent, UserProfileComponent, RolesLoginDetailsComponent, EquipmentComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AddEditUserSecurityProfileComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

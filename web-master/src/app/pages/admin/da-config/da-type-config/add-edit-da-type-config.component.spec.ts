import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../@core/core.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { AddEditDaTypeConfigComponent } from './add-edit-da-type-config.component';
import { DaTypeConfigComponent } from './da-type-config.component';
import { DefaultAccessListComponent } from './default-access-list/default-access-list.component';
import { DispositionComponent } from './disposition/disposition.component';
import { DocTypeComponent } from './doc-type/doc-type.component';
import { EntityConfigComponent } from './entity-config/entity-config.component';
import { ManageAlertsComponent } from './manage-alerts/manage-alerts.component';
import { PersonRolesComponent } from './person-roles/person-roles.component';
import { UserRolesComponent } from './user-roles/user-roles.component';

describe('AddEditDaTypeConfigComponent', () => {
    let component: AddEditDaTypeConfigComponent;
    let fixture: ComponentFixture<AddEditDaTypeConfigComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [
        AddEditDaTypeConfigComponent,
        DaTypeConfigComponent,
        AddEditDaTypeConfigComponent,
        PersonRolesComponent,
        DispositionComponent,
        DefaultAccessListComponent,
        EntityConfigComponent,
        UserRolesComponent,
        DocTypeComponent,
        ManageAlertsComponent
    ],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        // A2Edatetimepicker,
        SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AddEditDaTypeConfigComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

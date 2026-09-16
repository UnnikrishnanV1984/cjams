import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { TreeModule } from '@ali-hm/angular-tree-component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { AddEditEquipmentSearchDetailComponent } from './add-edit-equipment-search-detail.component';
import { EquipmentManagementComponent } from './equipment-management.component';
import { EquipmentSearchDetailComponent } from './equipment-search-detail.component';
import { EquipmentSearchComponent } from './equipment-search.component';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

describe('EquipmentManagementComponent', () => {
    let component: EquipmentManagementComponent;
    let fixture: ComponentFixture<EquipmentManagementComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [EquipmentManagementComponent, EquipmentSearchComponent, EquipmentSearchDetailComponent, AddEditEquipmentSearchDetailComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        TreeModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        // A2Edatetimepicker,
        SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(EquipmentManagementComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

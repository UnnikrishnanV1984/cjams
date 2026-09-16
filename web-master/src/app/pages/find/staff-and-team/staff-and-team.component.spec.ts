import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { TreeModule } from '@ali-hm/angular-tree-component';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule, PaginationConfig } from 'ngx-bootstrap';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { StaffAndTeamDetailsComponent } from './staff-and-team-details/staff-and-team-details.component';
import { StaffAndTeamReasignComponent } from './staff-and-team-reasign/staff-and-team-reasign.component';
import { StaffAndTeamResultComponent } from './staff-and-team-result/staff-and-team-result.component';
import { StaffAndTeamSearchComponent } from './staff-and-team-search/staff-and-team-search.component';
import { StaffAndTeamComponent } from './staff-and-team.component';

describe('StaffAndTeamComponent', () => {
    let component: StaffAndTeamComponent;
    let fixture: ComponentFixture<StaffAndTeamComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [StaffAndTeamComponent, StaffAndTeamSearchComponent, StaffAndTeamResultComponent, StaffAndTeamDetailsComponent, StaffAndTeamReasignComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule,
        TreeModule],
    providers: [PaginationConfig, provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(StaffAndTeamComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

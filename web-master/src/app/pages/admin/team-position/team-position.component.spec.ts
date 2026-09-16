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
import { TeamPositionComponent } from './team-position.component';
import { TeamSetupDetailComponent } from './team-setup-detail.component';
import { TeamSetupTreeComponent } from './team-setup-tree.component';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

describe('TeamPositionComponent', () => {
    let component: TeamPositionComponent;
    let fixture: ComponentFixture<TeamPositionComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [TeamPositionComponent, TeamSetupTreeComponent, TeamSetupDetailComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        TreeModule,
        // A2Edatetimepicker,
        SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(TeamPositionComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

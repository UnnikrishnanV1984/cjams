import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { TreeModule } from '@ali-hm/angular-tree-component';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { TeamSetupTreeComponent } from './team-setup-tree.component';

describe('TeamSetupTreeComponent', () => {
    let component: TeamSetupTreeComponent;
    let fixture: ComponentFixture<TeamSetupTreeComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [TeamSetupTreeComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule, TreeModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(TeamSetupTreeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

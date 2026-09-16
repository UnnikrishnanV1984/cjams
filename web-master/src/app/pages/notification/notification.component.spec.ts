import { CommonModule } from '@angular/common';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule, PaginationConfig } from 'ngx-bootstrap';

import { CoreModule } from '../../@core/core.module';
import { PageHeaderModule } from '../../shared';
import { ControlMessagesModule } from '../../shared/modules/control-messages/control-messages.module';
import { NotificationBroadcastMsgComponent } from './notification-broadcast-msg/notification-broadcast-msg.component';
import { NotificationResultComponent } from './notification-result/notification-result.component';
import { NotificationRoutingModule } from './notification-routing.module';
import { NotificationViewComponent } from './notification-view/notification-view.component';
import { NotificationComponent } from './notification.component';

describe('NotificationComponent', () => {
    let component: NotificationComponent;
    let fixture: ComponentFixture<NotificationComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [NotificationComponent, NotificationComponent, NotificationViewComponent, NotificationResultComponent, NotificationBroadcastMsgComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule,
        CommonModule,
        NotificationRoutingModule,
        PaginationModule,
        FormsModule,
        CommonModule,
        PageHeaderModule,
        ReactiveFormsModule,
        ControlMessagesModule],
    providers: [PaginationConfig, provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(NotificationComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

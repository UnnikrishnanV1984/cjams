import { CommonModule } from '@angular/common';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { PageHeaderModule } from '../../../shared';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { NotificationRoutingModule } from '../notification-routing.module';
import { NotificationResultComponent } from './notification-result.component';
import { NotificationComponent } from '../../case-worker/notification/notification.component';
import { NotificationViewComponent } from '../notification-view/notification-view.component';
import { NotificationBroadcastMsgComponent } from '../notification-broadcast-msg/notification-broadcast-msg.component';

describe('NotificationResultComponent', () => {
    let component: NotificationResultComponent;
    let fixture: ComponentFixture<NotificationResultComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
            // imports: [
            //     RouterTestingModule,
            //     CoreModule.forRoot(),
            //     HttpClientModule,
            //     FormsModule,
            //     ReactiveFormsModule,
            //     PaginationModule,
            //     NgSelectModule,
            //     A2Edatetimepicker,
            //     RouterModule,
            //     CommonModule,
            //     PageHeaderModule,
            //     ControlMessagesModule
            // ],
            imports: [CommonModule, NotificationRoutingModule, PaginationModule, FormsModule, CommonModule, PageHeaderModule, ReactiveFormsModule, ControlMessagesModule],
            declarations: [NotificationComponent, NotificationViewComponent, NotificationResultComponent, NotificationBroadcastMsgComponent]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(NotificationResultComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});

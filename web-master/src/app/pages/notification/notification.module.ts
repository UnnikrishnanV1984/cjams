import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatOptionModule } from '@angular/material/core';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { PageHeaderModule } from '../../shared';
import { ControlMessagesModule } from '../../shared/modules/control-messages/control-messages.module';
import { NotificationBroadcastMsgComponent } from './notification-broadcast-msg/notification-broadcast-msg.component';
import { NotificationEntitesComponent } from './notification-entites/notification-entites.component';
import { NotificationResultComponent } from './notification-result/notification-result.component';
import { NotificationRoutingModule } from './notification-routing.module';
import { NotificationViewComponent } from './notification-view/notification-view.component';
import { NotificationComponent } from './notification.component';

@NgModule({
    imports: [CommonModule, NotificationRoutingModule, NgSelectModule, PaginationModule, FormsModule, MatFormFieldModule, MatSelectModule, MatOptionModule, CommonModule, PageHeaderModule, ReactiveFormsModule, ControlMessagesModule],
    declarations: [NotificationComponent, NotificationViewComponent, NotificationResultComponent, NotificationBroadcastMsgComponent, NotificationEntitesComponent]
})
export class NotificationModule {}

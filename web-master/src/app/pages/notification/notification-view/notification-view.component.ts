import { Component, Input } from '@angular/core';
import { DataStoreService } from '../../../@core/services';
import { NotificationResult } from '../_entities/notification-entity.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'notification-view',
    templateUrl: './notification-view.component.html',
    standalone: false
})
export class NotificationViewComponent {
    @Input()
    selectedNotification!: NotificationResult |null | undefined;
    constructor(private _dataStoreService: DataStoreService) {}

    closePopup() {
        this._dataStoreService.setData('notification', true);
    }
}


import {of as observableOf,  Observable } from 'rxjs';
import { Component, OnInit } from '@angular/core';

import { ObjectUtils } from '../../../@core/common/initializer';
import { PaginationRequest, PaginationInfo } from '../../../@core/entities/common.entities';
import { GenericService } from '../../../@core/services/generic.service';
import { NotificationResult, NotificationSearch } from '../_entities/notification-entity.module';
import { NotificationUrlConfig } from '../notification.url.config';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'notification-result',
    templateUrl: './notification-result.component.html',
    styleUrls: ['./notification-result.component.scss'],
    standalone: false
})
export class NotificationResultComponent implements OnInit {
    paginationInfo: PaginationInfo = new PaginationInfo();
    notificationResultData$!: Observable<NotificationResult[]>;
    totalResulRecords$!: Observable<number>;
    notificationSearch: NotificationSearch;
    selectedRecord: NotificationResult;
    selectedDeleteRowID!: string;
    constructor(private _service: GenericService<NotificationResult>) {
        this._service.endpointUrl = NotificationUrlConfig.EndPoint.notification.notificationResult;
        this.notificationSearch = new NotificationSearch();
        this.selectedRecord = new NotificationResult();
    }

    ngOnInit() {
        this.getNotificationData(1, this.notificationSearch);
    }
    getNotificationData(pageNo: number, modal: NotificationSearch) {
        this.notificationSearch = modal;
        modal = Object.assign(new NotificationSearch(), modal);
        ObjectUtils.removeEmptyProperties(modal);
        const body: PaginationRequest = {
            limit: 10,
            page: pageNo,
            where: modal,
            method: 'post'
        };
        this._service.getPagedArrayList(body)
            .subscribe(data => {
                this.notificationResultData$ = observableOf(data.data);
                if (pageNo === 1) {
                    this.totalResulRecords$ = observableOf(data.count);
                }
            });
    }
    pageChanged(page: number) {
        this.paginationInfo.pageNumber = page;
        this.getNotificationData(page, this.notificationSearch);
    }
    selectNotification(selectedData: NotificationResult) {
        this.selectedRecord = selectedData;
    }
    selectDeleteNotification(selectedRowID: string) {
        this.selectedDeleteRowID = selectedRowID;
    }
    deleteSelectedNotification() {
      //No operation needed here 
    }

}

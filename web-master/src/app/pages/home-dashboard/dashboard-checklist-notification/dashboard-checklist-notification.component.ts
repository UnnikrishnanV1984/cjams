
import {map, share, pluck} from 'rxjs/operators';
import { PaginationRequest } from './../../../@core/entities/common.entities';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { CheckListNotificationDetails } from '../_entities/home-dash-entities';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-checklist-notification',
    templateUrl: './dashboard-checklist-notification.component.html',
    styleUrls: ['./dashboard-checklist-notification.component.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,CommonModule],
    standalone: true
})
export class DashboardChecklistNotificationComponent implements OnInit {
    paginationInfo: PaginationInfo = new PaginationInfo();
    getCheckListNotificationList$!: Observable<CheckListNotificationDetails[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    constructor(private _commonService: CommonHttpService) {}

    ngOnInit() {
        this.getCheckListNotification(1);
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo;
        this.getCheckListNotification(this.paginationInfo.pageNumber);
    }
    getCheckListNotification(pageNumber: number) {
        this.paginationInfo.pageNumber = pageNumber;
        const checkList = this._commonService
            .getPagedArrayList(
                new PaginationRequest({ count: -1, where: {}, limit: this.paginationInfo.pageSize, method: 'post', page: this.paginationInfo.pageNumber }),
                'Usernotifications/getactivitytaskbyremindate'
            ).pipe(
            map((result) => {
                return {
                    data: result.data,
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize
                };
            }),
            share(),);
        this.getCheckListNotificationList$ = checkList.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = checkList.pipe(pluck('count'));
            this.canDisplayPager$ = checkList.pipe(pluck('canDisplayPager'));
        }
    }
}

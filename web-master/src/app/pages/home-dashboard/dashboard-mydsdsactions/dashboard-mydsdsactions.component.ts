
import {pluck} from 'rxjs/operators';



import { Component, Input, OnInit } from '@angular/core';
import { Observable, Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, AuthService } from '../../../@core/services';
import { HomeDashboardUrlConfig } from '../home-dashbaord.url.config';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { Router } from '@angular/router';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';
import { MatRadioModule } from '@angular/material/radio';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatSortModule } from '@angular/material/sort';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-mydsdsactions',
    templateUrl: './dashboard-mydsdsactions.component.html',
    styleUrls: ['./dashboard-mydsdsactions.component.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,CommonModule,MatRadioModule,MatFormFieldModule,MatInputModule,MatButtonModule],
    standalone: true
})
export class DashboardMydsdsactionsComponent implements OnInit {
    dsdsActionList$!: Observable<any>;
    @Input()
    eventSubject$!: Subject<string>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    isDjs = false;
    status = 'all';
    servicerequestnumber!: string;

    constructor(private _dataStoreService: DataStoreService,
        private _commonService: CommonHttpService,
        private _router: Router,
        private authService: AuthService) { }

    ngOnInit() {
        this.eventSubject$.subscribe((data) => {
            if (data === 'refresh') {
                this.getDsdsActionData(1);
            }
        });
        this.getDsdsActionData(1);
        this.isDjs = this.authService.isDJS();
    }

    getDsdsActionData(pageNo: number) {
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myDsdsActions.DSDSActionDetailsUrl}?data`;
        const body = new PaginationRequest({
            where: {
                servicerequestnumber: this.servicerequestnumber,
                status: this.status
            },
            page: pageNo,
            limit: 10,
            method: 'get',
            count: -1,
            order: 'servicerequestnumber asc'
        });
        const source = this._commonService.getPagedArrayList(body)

        this.dsdsActionList$ = source.pipe(pluck('data'));
        if (pageNo === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
        }
    }

    pageChanged(pageNo: number) {
        this.getDsdsActionData(pageNo);
    }
    routToCaseWorker(item: DSDSActionDetails) {
        this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            let routeTo = 'report-summary';
            if (dsdsActionsSummary.teamtypekey && dsdsActionsSummary.teamtypekey === 'DJS') {
                routeTo = 'report-summary-djs';
            }
            const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/' + routeTo;
            this._router.navigate([currentUrl]);
        });
    }

    onSearchCase() {
        this.getDsdsActionData(1);
    }
}

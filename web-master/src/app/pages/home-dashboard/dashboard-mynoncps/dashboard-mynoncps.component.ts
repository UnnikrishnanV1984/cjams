
import {pluck, share} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable, Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { CommonHttpService, DataStoreService, AuthService } from '../../../@core/services';
import { AlertService } from '../../../@core/services/alert.service';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { HomeDashboardUrlConfig } from '../home-dashbaord.url.config';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatTableModule } from '@angular/material/table';
import { CommonModule } from '@angular/common';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatRadioModule } from '@angular/material/radio';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSortModule } from '@angular/material/sort';

@Component({
    selector: 'dashboard-mynoncps',
    templateUrl: './dashboard-mynoncps.component.html',
    styleUrls: ['./dashboard-mynoncps.component.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,MatTableModule,CommonModule,MatTooltipModule,MatRadioModule,ReactiveFormsModule,MatFormFieldModule,MatInputModule,MatButtonModule],
    standalone: true
})
export class DashboardMynoncpsComponent implements OnInit {

    nonCpsIntakeList$!: Observable<any>;
    @Input()
    eventSubject$!: Subject<string>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    inputRequest!: any;
    currentStatus!: string;
    myNonCpsForm!: FormGroup;
    agency!: string;
    servicerequestnumber!: string;
    constructor(
        private _formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService,
        private _commonService: CommonHttpService,
        private _router: Router,
        private _authService: AuthService
    ) { }

    ngOnInit() {
        this.agency = this._authService.getAgencyName();
        this.myNonCpsForm = this._formBuilder.group({
            filterNonCPS: ['All']
        });
        this.eventSubject$.subscribe((data) => {
            if (data === 'refresh') {
                this.getNonCps(1, 'All');
            }
        });
        this.getNonCps(1, 'All');
    }

    getNonCps(pageNo: number, status: any) {
        this.currentStatus = status;
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myDsdsActions.DSDSActionDetailsUrl}?data`;
        if (status === 'inprogress') {
            this.inputRequest = { servicerequestnumber: this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber , actiontype: null, status: 'inprogress' };
        } else if (status === 'pending') {
            this.inputRequest = { servicerequestnumber: this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber , actiontype: null, status: 'pending' };
        } else if (status === 'closed') {
            this.inputRequest = { servicerequestnumber: this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber , actiontype: null, status: 'closed' };
        } else {
            this.inputRequest = { servicerequestnumber: this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber , actiontype: null };
        }
        const body = new PaginationRequest({
            where: this.inputRequest,
            page: pageNo,
            limit: 10,
            method: 'get',
            count: -1
        });
        const source = this._commonService.getPagedArrayList(body).pipe(share());

        this.nonCpsIntakeList$ = source.pipe(pluck('data'));
        if (pageNo === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
        }
    }

    pageChanged(pageNo: number) {
        this.getNonCps(pageNo, this.currentStatus);
    }
    listMyNonCPSCase(event: any) {
        const status = event.value;
        this.getNonCps(1, status);
    }
    acceptedCase(data: DSDSActionDetails) {
        this._commonService
            .getSingle(
                {
                    intakeserviceid: data.intakeserviceid,
                    isaccepted: true,
                    isrejected: false,
                    rejectreason: 'Accepted',
                    method: 'post'
                },
                'Areateammemberservicerequests/updateassignedstatus'
            )
            .subscribe(
                (result) => {
                    (<any>$('#accept-case')).modal('hide');
                    this._alertService.success('Accepted Successfully');
                    this.getNonCps(1, 'All');
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    routToCaseWorker(item: DSDSActionDetails) {
        this._commonService
            .getSingle(
                {
                    intakeserviceid: item.intakeserviceid,
                    isaccepted: true,
                    isrejected: false,
                    rejectreason: 'Accepted',
                    method: 'post'
                },
                'Areateammemberservicerequests/updateassignedstatus'
            )
            .subscribe(
                (result) => {
                    this._commonService.getById(item.servicerequestnumber.trim(), CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
                        const dsdsActionsSummary = response[0];
                        if (dsdsActionsSummary) {
                            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                            const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/report-summary';
                            this._router.navigate([currentUrl]);
                        }
                    });
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    onSearchCase() {
        this.getNonCps(1, this.currentStatus);
    }
}

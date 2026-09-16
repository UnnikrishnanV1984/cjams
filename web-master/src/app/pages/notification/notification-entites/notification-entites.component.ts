
import { share, pluck } from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { Observable,  Subject } from 'rxjs';

import { AppUser } from '../../../@core/entities/authDataModel';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { AuthService, CommonHttpService, DataStoreService, GenericService, SessionStorageService } from '../../../@core/services';
import { EntityNotification, NotificationResult } from '../_entities/notification-entity.module';
import { NotificationUrlConfig } from '../notification.url.config';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'notification-entites',
    templateUrl: './notification-entites.component.html',
    standalone: false
})
export class NotificationEntitesComponent implements OnInit {
    @Input() notify!: Subject<string>;
    notificationResultData$!: Observable<EntityNotification[]>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    totalResulRecords$!: Observable<number>;
    sourceDropdownItem: any[] = [];
    searchFormGroup!: FormGroup;
    startDate = null;
    endDate = null;
    source = null;
    selectedRecord!: EntityNotification;
    selectedDeleteRow!: EntityNotification;
    private token: AppUser;
    isBroadCastMessage = false;
    caseworkerpageurl = '/pages/case-worker/';
    reportsummaryurl = '/dsds-action/person-cw/list';
    constructor(
        private _dataStoreService: DataStoreService,
        private _router: Router,
        private _formBuilder: FormBuilder,
        private _service: GenericService<EntityNotification>,
        private _commonService: CommonHttpService,
        private _sessionStorage: SessionStorageService,
        private _authService: AuthService) {
        this._service.endpointUrl = NotificationUrlConfig.EndPoint.notification.notificationResult;
        this.token = this._authService.getCurrentUser();
    }
    ngOnInit() {
        const role = this._authService.getCurrentUser();
        if (role.role.name === 'superuser') {
            this.isBroadCastMessage = true;
        }
        this.loadSources();
        this.getNotificationData(1);
        this.initiateSearchForm()
    }

    onSearch() {
        this.startDate = this.searchFormGroup.get('startDate')?.value;
        this.endDate = this.searchFormGroup.get('endDate')?.value;
        this.source = this.searchFormGroup.get('source')?.value;
        this.getNotificationData(1, { startdate: this.startDate, enddate: this.endDate, source: this.source });
    }

    clearFilter() {
        this.searchFormGroup.reset()
        this.getNotificationData(1);
    }

    initiateSearchForm() {
        this.searchFormGroup = this._formBuilder.group({
            startDate: [this.startDate],
            endDate: [this.endDate],
            source: [this.source],
        })
    }


    routeToImmunization(item: any) {
        this._sessionStorage.setTabKeyKey(item.servicerequestnumber);
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.intakeserviceid + '/casetype';
        this._commonService.getAll(url).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                // common person for cw
                const currentUrl = this.caseworkerpageurl + item.intakeserviceid + '/' + item.servicerequestnumber + this.reportsummaryurl;
                this._router.navigate([currentUrl], { queryParams: { pid: item.entityid, updatedon: new Date(item.updatedon).toISOString().split('T')[0], path: '/immunization' } });
            }
        });
    }

    loadSources() {
        this._commonService.getPagedArrayList(
            {
                method: 'get',
                nolimit: true,
                where: { referencetypeid: 500503 }
            },
            'referencevalues?filter'
        ).subscribe(sources => {
            if (sources && Array.isArray(sources)) {
                this.sourceDropdownItem = sources;
            }
        });
    }

    getNotificationData(pageNo: number, opts?: any) {
        const body: PaginationRequest = {
            limit: 10,
            page: pageNo,
            where: { isexternalentity: true, ...opts },
            method: 'post'
        };
        const source = this._service.getPagedArrayList(body).pipe(share());
        this.notificationResultData$ = source.pipe(pluck('data'));
        if (pageNo === 1) {
            this.totalResulRecords$ = source.pipe(pluck('count'));
        }
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.getNotificationData(this.paginationInfo.pageNumber);
    }
    selectNotification(selectedData: EntityNotification) {
        this.selectedRecord = selectedData;
    }
    selectDeleteNotification(selectedRow: EntityNotification) {
        this.selectedDeleteRow = selectedRow;
    }
    updateNotification(notification: EntityNotification) {
        this._commonService.endpointUrl = NotificationUrlConfig.EndPoint.notification.updateNotification;
        const body = {
            usernotificationid: notification.usernotificationid
        };
        if (!notification.isread) {
            this._commonService.create(body).subscribe((data) => {
                if (data === 'Success') {
                    notification.isread = true;
                } else {
                    notification.isread = false;
                }
            });
        }
    }
    deleteSelectedNotification() {
        this._commonService.endpointUrl = NotificationUrlConfig.EndPoint.notification.deleteNotification;
        const body = {
            usernotificationid: this.selectedDeleteRow.usernotificationid
        };

        this._commonService.create(body).subscribe((data) => {
            if (data === 'Success') {
                this.getNotificationData(this.paginationInfo.pageNumber);
            }
        });
    }
}

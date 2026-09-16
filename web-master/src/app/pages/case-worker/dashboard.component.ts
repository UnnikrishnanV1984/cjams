import { map, debounceTime } from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { Component, OnInit, Injector } from '@angular/core';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { Subject } from 'rxjs';

import { AppUser } from '../../@core/entities/authDataModel';
import { DynamicObject, PaginationInfo } from '../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../@core/entities/constants';
import { AlertService } from '../../@core/services/alert.service';
import { AuthService } from '../../@core/services/auth.service';
import { GenericService } from '../../@core/services/generic.service';
import { AppConfig } from '../../app.config';
import { ColumnSortedEvent } from '../../shared/modules/sortable-table/sort.service';
import { DSDSActionDetails } from './_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from './case-worker-url.config';
import { CommonHttpService, DataStoreService, SessionStorageService } from '../../@core/services';
import { Router } from '@angular/router';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard',
    templateUrl: './dashboard.component.html',
    styleUrls: ['./dashboard.component.scss'],
    standalone: false
})
export class DashboardComponent implements OnInit {
    attachedUrl!: string;
    rowId!: number;
    userType!: string;
    paginationInfo: PaginationInfo = new PaginationInfo();
    caseClosedPaginationInfo: PaginationInfo = new PaginationInfo();
    dsdsActionDetails: DSDSActionDetails[] = [];
    totalRecords!: number;
    dsdsActionClosedDetails: DSDSActionDetails[] = [];
    totalClosedRecords!: number;
    dynamicObject!: DynamicObject;
    uploadedFile: any;
    progress: { percentage: number | undefined } = { percentage: 0 };
    private token: AppUser;
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    private pageSubject$ = new Subject<number>();
    isServiceCase: any;

    private _commonHttpService: CommonHttpService;
    private _uploadService: NgxfUploaderService;
    private _alertService: AlertService;
    private _service: GenericService<DSDSActionDetails>;
    private _authService: AuthService;
    private _router: Router;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;

    constructor( private injector: Injector){
        this._commonHttpService= injector.get<CommonHttpService>(CommonHttpService);
        this._uploadService= injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._alertService= injector.get<AlertService>(AlertService);
        this._service= injector.get<GenericService<DSDSActionDetails>>(GenericService);
        this._authService= injector.get<AuthService>(AuthService);
        this._router = injector.get<Router>(Router);
        this._dataStoreService= injector.get<DataStoreService>(DataStoreService);
        this.storage= injector.get<SessionStorageService>(SessionStorageService);
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'servicerequestnumber asc';
        const role = this._authService.getCurrentUser();
        if (role.role.name !== 'provider') {
            this.getPage();
            this.getClosedPage();
        } else {
            this.userType = role.role.name;
        }
    }

    getPage() {
        this.pageStream$.pipe(map((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObject, page: pageNumber };
        }));

        this.searchTermStream$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObject = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }

    onSortedCaseCloded($event: ColumnSortedEvent) {
        this.caseClosedPaginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.caseClosedPaginationInfo.pageNumber);
    }

    getClosedPage() {
        this.pageStream$.pipe(map((pageNumber) => {
            this.caseClosedPaginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObject, page: pageNumber };
        }));

        this.searchTermStream$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObject = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);
    }

    pageCaseClodedChanged(event: any) {
        this.caseClosedPaginationInfo.pageNumber = event.page;
        this.caseClosedPaginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.caseClosedPaginationInfo.pageNumber);
    }

    private loadCaseList(params: any) {
        let url: string;
        const role = this._authService.getCurrentUser();
        if (role.role.name === 'apcs') {
            this.userType = role.role.name;
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.SupervisorReviewListUrl;
        } else {
            this.userType = role.role.name;
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.DSDSActionDetailsUrl;
        }
        return this._service.getPagedArrayList(
            {
                limit: this.paginationInfo.pageSize,
                order: this.paginationInfo.sortBy,
                page: params.page,
                count: this.paginationInfo.total,
                method: 'get',
                where: params.search
            },
            url + '?data'
        );
    }

    private loadClosedCaseList(params: any) {
        let url: string;
        const role = this._authService.getCurrentUser();
        if (role.role.name === 'apcs') {
            this.userType = role.role.name;
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.SupervisorClosedReviewListUrl;

            return this._service.getPagedArrayList(
                {
                    limit: this.caseClosedPaginationInfo.pageSize,
                    order: this.caseClosedPaginationInfo.sortBy,
                    page: params.page,
                    count: this.caseClosedPaginationInfo.total,
                    method: 'get',
                    where: params.search
                },
                url + '?data'
            );
        }
    }
    openUpload(id: any) {
        this.rowId = id;
        (<any>$('#upload-attachment')).modal('show'); // NOSONAR
    }

    uploadFile(file: any): void {
        if (!(file instanceof File)) {
            return;
        }
        this.uploadedFile = file;
    }

    humanizeBytes(bytes: number): string {
        if (bytes === 0) {
            return '0 Byte';
        }
        const k = 1024;
        const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
        const i: number = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    saveAttachment() {
        this._uploadService
            .upload({
                url: AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=Provider',
                headers: new HttpHeaders()
                    .set('ctype', 'file')
                    .set('srno', 'Provider'),
                filesKey: ['file'],
                files: this.uploadedFile,
                process: true
            })
            .subscribe(
                (response) => {
                    if (response.status) {
                        this.progress.percentage = response.percent;
                    }
                    if (response.status === 1 && response.data) {
                        this._alertService.success('File Uploaded Succesfully!');
                        this.attachedUrl = response.data.s3bucketpathname;
                        (<any>$('#upload-attachment')).modal('hide'); //NOSONAR
                    }
                },
                (err) => {
                    console.error(err);
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }

    routToCaseWorker(item: DSDSActionDetails) {
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        let url = '';
        if (this.isServiceCase) {
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.intakeserviceid + '/casetype';
        } else {
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicerequestnumber;
        }
        this._commonHttpService.getAll(url).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/report-summary';
            this._router.navigate([currentUrl]);
        });
    }

    onNativeDrop(event: DragEvent) {
        event.preventDefault();
        if (event.dataTransfer?.files) {
            const droppedFiles: File[] = Array.from(event.dataTransfer.files);
            this.uploadFile(droppedFiles); 
        }
    }
}

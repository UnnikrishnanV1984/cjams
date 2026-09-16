import {pluck, share} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { Observable,  Subject } from 'rxjs';
import { Router } from '@angular/router';

import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { HomeDashboardUrlConfig } from '../home-dashbaord.url.config';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import moment from 'moment';
import { ExcelService } from '../excel.service';
import { CustomTableModule } from '../../../shared/shared-components/custom-table/custom-table.module';
import { CustomTableActionsModule } from '../../../shared/shared-components/custom-table-actions/custom-table-actions.module';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';
@Component({
    //tslint:disable-next-line:component-selector
    selector: 'dashboard-mytasks',
    templateUrl: './dashboard-mytasks.component.html',
    styleUrls: ['./dashboard-mytasks.component.scss'],
    imports:[MatSortModule,CustomTableModule,ReactiveFormsModule,CustomTableActionsModule,CommonModule],
    standalone: true
})
export class DashboardMytasksComponent implements OnInit {

    @Input() eventSubject$!: Subject<string>;
    taskList$: Observable<any> = new Observable<any>();
    totalRecord$: Observable<number> = new Observable<number>();
    paginationInfo: PaginationInfo = new PaginationInfo();
    myirForm!: FormGroup;

    myTasklist: any[] = [];
    myTaskDetailsData: any[] = [];
    myTaskDetailsColumns: string[] =[];
    myTaskDetailsKeys: string[] = [];
    searchandsortquery: any;
    searchquery : any;
    totalcount: number = 0;
    selectedStatus = 'All';
    myTasklistExport: any[] = [];

    statuslist = [
        { label: 'ALL', count: 0, value: 'All' },
        { label: 'OPEN', count: 0, value: 'Open' },
        { label: 'COMPLETED', count: 0, value: 'Completed' },
        { label: 'PENDING', count: 0, value: 'Pending' }
    ];

    columnStyleMap = ['Due Date', 'Due Status', 'Task Status'];

    constructor(private _commonService: CommonHttpService,
        private _router: Router,
        private storage: SessionStorageService,
        private _dataStoreService: DataStoreService,
        private _formBuilder: FormBuilder,
        private excelService: ExcelService) { }

    ngOnInit() {
        this.myirForm = this._formBuilder.group({
            filter: ['Nex30']
        });
        this.gettaskList(1, this.selectedStatus);
        this.eventSubject$?.subscribe(data => {
            if (data === 'refresh') {
                this.gettaskList(1, this.selectedStatus);
            }
        });
    }

    selectStatus(status: any) {
        this.searchandsortquery = this.searchquery;
        this.selectedStatus = status.value;
        this.paginationInfo.pageNumber = 1;
        this.gettaskList(1, status.value, false);
    }

    getNextNDaysData(): void {
        this.paginationInfo.pageNumber = 1;
        this.gettaskList(1, 'All');
        this.selectedStatus = 'All';
    }

    gettaskList(pageNo?: number, taskStatus?: any, updateActionCount: boolean = true, pageSize? : number) {
        // updateActionCount param is used to load action button values 
        // pageSize param is used to page limit while export to excel data.
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myTasks.myTasksURL}`;
        const body = new PaginationRequest({
            where: {
                filtertype: this.myirForm.value.filter ? this.myirForm.value.filter : 'Nex30',
                sortorder: this.searchandsortquery?.sortDirection ? this.searchandsortquery?.sortDirection : 'asc',
                sortcolumn: this.searchandsortquery?.sortColumn ? this.searchandsortquery?.sortColumn : 'Due Date',
                searchobj: this.searchandsortquery ? this.searchandsortquery : {},
                status: taskStatus ?? null,
                exportlimit : pageSize ?? null
            },
            limit: 10,
            method: 'post',
            page: pageNo
        });
        this.searchquery = this.searchandsortquery;
        const source = this._commonService.getPagedArrayList(body).pipe(share());
        this.taskList$ = source.pipe(pluck('data'));
        this.taskList$.subscribe(data => {
            if(pageSize) {
                // pageSize will be passed for export data to excel.
                this.myTasklistExport = data;
                const exportData = this.myTasklistExport.map(({ servicerequestnumber, legalguardian,task,duedate,duestatus,taskstatustype }) => ({ servicerequestnumber, legalguardian,task,duedate,duestatus,taskstatustype }));
                this.excelService.exportAsExcelFile(exportData, 'MyTask');
            } else {
                this.myTasklist = data;
                this.loadMyTaskList();
                this.searchandsortquery = {};
    
                // getting count values from data stream
                this.totalcount = data[0]?.count;
                if (updateActionCount) {
                    this.updateStatuslistValue(data);
                }
            }
           
        }
        
        );
        if (pageNo === 1) {
            this.totalRecord$ = source.pipe(pluck('count'));
        }

    }

    updateStatuslistValue(data: any) {
        this.statuslist = this.statuslist.map(item => {
            let count = 0;
            switch (item.label) {
                case 'ALL':
                    count = data[0]?.count ?? 0;
                    break;
                case 'OPEN':
                    count = data[0]?.opencount ?? 0;
                    break;
                case 'COMPLETED':
                    count = data[0]?.completedcount ?? 0;
                    break;
                case 'PENDING':
                    count = data[0]?.inprogresscount ?? 0;
                    break;
            }
            return { ...item, count };
        });
    }

    private commonRedirectionUrlFn(dsdsActionsSummary: any, id: any, caseid: any) {
        if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = '/pages/case-worker/' + id + '/' + caseid + '/dsds-action/report-summary';
            this._router.navigate([currentUrl]);
        }
    }

    loadMyTaskList() {
        const columnMapping = {
            'Case Number': 'servicerequestnumber',
            'Head of Household': 'legalguardian',
            'Task': 'task',
            'Due Date': 'duedate',
            'Due Status': 'duestatus',
            'Task Status': 'taskstatustype'
        };
        let sortedList = this.myTasklist;
        this.myTaskDetailsData = this.myTasklist;
        this.myTaskDetailsData = this.returnSortedListDataFn(sortedList)

        this.myTaskDetailsColumns = Object.keys(this.myTaskDetailsData?.[0] || columnMapping)
        this.myTaskDetailsKeys = Object.keys(this.myTaskDetailsData?.[0] || columnMapping)
    }

    // Assosiated to loadlistDetails method
    private returnSortedListDataFn(sortedList: any[]): any[] {
        return sortedList?.map((e) => ({
            'Case Number': e.servicerequestnumber,
            'Head of Household': e.legalguardian,
            'Task': e.task,
            'Due Date': e.duedate ? moment(e.duedate).format('MM/DD/YYYY') : "",
            'Due Status': e.duestatus,
            'Task Status': e.taskstatustype
        }));
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.sortColumn = pageInfo.query.sortColumn;
        this.paginationInfo.sortBy = pageInfo.query.sortDirection;
        this.searchandsortquery = this.searchquery;
        this.gettaskList(pageInfo.page,this.selectedStatus, false);

    }

    onSortedlist(event: any) {
     
        event = JSON.parse(event);
        this.paginationInfo.sortBy = event.sortDirection;
        this.paginationInfo.sortColumn = this.renameColumnName(event.sortColumn);
        this.searchandsortquery.sortDirection = event.sortDirection;
        this.searchandsortquery.sortColumn = this.renameColumnName(event.sortColumn);
        this.gettaskList(this.paginationInfo.pageNumber,this.selectedStatus, false);
    }

    renameColumnName(col: any) {
        if(col === 'Case Number'){
            return 'Case Numebr';
        }
        return col === 'Task Status' ? 'Status' : col;

    }

    routToCaseWorker(event: any) {
        const data = JSON.parse(event);
        const item = this.myTasklist?.find(i => i.servicerequestnumber === data["Case Numebr"]);
        if (item.servicecaseid) {
            this.storage.setTabKeyKey(item.servicerequestnumber);
            this.storage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecaseid + '/casetype';
            this._commonService.getAll(url).subscribe((response) => {
                const dsdsActionsSummary = response[0];
                this.commonRedirectionUrlFn(dsdsActionsSummary, item.servicecaseid, item.servicerequestnumber);
            });
        } else {
            this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
                const dsdsActionsSummary = response[0];
                this.commonRedirectionUrlFn(dsdsActionsSummary, item.intakeserviceid, item.servicerequestnumber);
            });
        }
    }

    callApi(query: any) {
        const data = JSON.parse(query)
        this.searchandsortquery = data;
        this.paginationInfo.pageNumber = 1;
        this.gettaskList();
        this.selectedStatus = 'All';
    }

    exportTOExcel() {
        this.gettaskList(1,this.selectedStatus, false, this.totalcount);
    }

}




import { Component, Input, OnInit, ViewChild, ElementRef } from '@angular/core';
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
import { SelectionModel } from '@angular/cdk/collections';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { ExcelService } from '../excel.service';
import { environment } from '../../../../../src/environments/environment';
import { config } from '../../../../../src/environments/config';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatTooltip } from '@angular/material/tooltip';
import { MatRadioModule } from '@angular/material/radio';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
 
declare var $: any;
export interface CaseList {
    approvaldate: string;
    county: string;
    datereceived: any;
    intakedaterecieved: any;
    datestarted: any;
    displayname: string;
    duedate: string;
    foldertype: string;
    groupnumber: string;
    accepteddate: string;
    isfatality: string;
    fatalityinfo: any;
    ismaltreatment: string;
    intakeserviceid: string;
    legalguardian: any;
    personcjamspid: string;
    restrictstatus: string;
    routedon: string;
    servicerequestnumber: string;
    srsubtype: string;
    srtype: string;
    status: string;

}
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-myir',
    templateUrl: './dashboard-myir.component.html',
    styleUrls: ['./dashboard-myir.component.scss', '../dashboard-common.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,MatTableModule,CommonModule,MatTooltip,MatRadioModule,ReactiveFormsModule,MatFormFieldModule,MatInputModule,MatButtonModule],
    standalone: true
})
export class DashboardMyirComponent implements OnInit {
    myIRIntakeList$!: Observable<any>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    inputRequest!: any;
    currentStatus!: string;
    myirForm!: FormGroup;
    agency: any;
    servicerequestnumber!: string | null;
    searchStrem: any = '';
    private searchTermStream$ = new Subject<string>();
    myIRIntakeList: any;
    totalRecords: any;
    selection = new SelectionModel<CaseList>(true, []);
    sortData: any;
    @ViewChild(MatPaginator)
    paginator!: MatPaginator;
    @ViewChild(MatSort)
    sort!: MatSort;
    @ViewChild('input')
    input!: ElementRef;
    export = false;
    dataSource = new MatTableDataSource<CaseList>();
    isLoading = false;
    displayedColumns: string[] = ['servicerequestnumber', 'srtype', 'focusname', 'legalguardian', 'intakedaterecieved', 'datereceived', 'approvaldate', 'open_closed', 'jurisdiction'];
    restrictedcaseenable!: boolean;

    constructor(
        private _formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService,
        private _commonService: CommonHttpService,
        private _router: Router,
        private _authService: AuthService,
        private excelService: ExcelService
    ) { }

    ngOnInit() {
        this.restrictedcaseenable = config.restrictedcaseenable && environment.envName !== 'Production';
        this.agency = this._authService.getAgencyName();
        this.myirForm = this._formBuilder.group({
            filterIR: ['inprogress']
        });
        this.sortData = {
            active: "focusname",
            direction: "asc"
        };
        this.getIR(1, 'inprogress');
    }

    ExportTOExcel() {
        this.export =true;
        this.getIR(1,this.myirForm.value.filterIR);
        
    }
    
    customSort(event: any){
        this.sortData=event;
        this.getIR(1,this.myirForm.value.filterIR);
        this.paginationInfo.pageNumber=1;
    }
    getIR(pageNo: number, status: any) {
        setTimeout(() => {
            this.isLoading = true;
        });
        this.currentStatus = status;
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myDsdsActions.DSDSActionDetailsUrl}?data`;
        if (status === 'inprogress') {
            this.inputRequest = { actiontype: 'IR', status: 'inprogress', sort: this.sortData };
        } else if (status === 'pending') {
            this.inputRequest = { actiontype: 'IR', status: 'pending', sort: this.sortData };
        } else if (status === 'closed') {
            this.inputRequest = { actiontype: 'IR', status: 'closed', sort: this.sortData };
        } else if (status === 'All') {
            this.inputRequest = { actiontype: 'IR', sort: this.sortData };
        } else {
            this.inputRequest = { actiontype: 'IR' };
        }
        if (this.searchStrem) {
            this.inputRequest['servicerequestnumber'] = this.searchStrem;
        }
        if(this.export){
            this.inputRequest['totalNumber'] = this.totalRecords;
        }
        const body = new PaginationRequest({
            where: this.inputRequest,
            page: pageNo,
            limit: 10,
            method: 'get',
            count: -1
        });
        this._commonService.getPagedArrayList(body).subscribe(data => {
            
            if(this.export){
                this.excelService.exportAsExcelFile(data.data, 'downloadIRCase');
                this.export = false;
                this.isLoading = false;
            } else {
                this.myIRIntakeList=data.data;
                this.dataSource.data = this.myIRIntakeList as CaseList[];
                if (pageNo === 1) {
                    this.totalRecords = data.count;
                }
                this.isLoading = false;
            }
        });


    }

    pageChanged(pageNo: number) {
        this.getIR(pageNo, this.currentStatus);
    }
    listMyIrCase(event: any) {
        const status = event.value;
        this.getIR(1, status);
    }
    routToCaseWorker(item: DSDSActionDetails) {
        this._dataStoreService.setObj('responsetimerduedatelist', null);
        const isExpungementSuperUser =  this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged') ?? 0;
        if(item.restrictstatus === 'EXCLUDE' || (item.restrictstatus === 'INCLRES' && this.restrictedcaseenable)){
            $('#exclude').modal('show');
            return
        }
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
                    this._commonService.getById(item.servicerequestnumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
                        const dsdsActionsSummary = response[0];
                        if (dsdsActionsSummary) {
                            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                            if (item.open_closed === 'Closed') {
                                const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/disposition';
                                this._router.navigate([currentUrl]);
                            } else {
                                const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/report-summary';
                                this._router.navigate([currentUrl]);
                            }

                        }
                    });
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );

    }
    acceptedCase(modal: DSDSActionDetails) {
        this._commonService
            .getSingle(
                {
                    intakeserviceid: modal.intakeserviceid,
                    isaccepted: true,
                    isrejected: false,
                    rejectreason: 'Accepted',
                    method: 'post'
                },
                'Areateammemberservicerequests/updateassignedstatus'
            )
            .subscribe(
                (result) => {
                    this._alertService.success('Accepted Successfully');
                    this.getIR(1, this.currentStatus);
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    onSearchCase() {
        this.searchStrem = this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber;
        this.getIR(1, this.currentStatus);
    }

    resetFilter() {
        this.myirForm.patchValue({ filterIR: 'inprogress' });
        this.searchStrem = null;
        this.servicerequestnumber = null;
        this.getIR(1, 'inprogress');
        this.paginationInfo.pageNumber = 1;
    }
}

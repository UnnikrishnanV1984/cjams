import { Component, Input, OnInit, ViewChild, ElementRef } from '@angular/core';
import { FormBuilder, FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable, Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { CommonHttpService, DataStoreService, AuthService } from '../../../@core/services';
import { AlertService } from '../../../@core/services/alert.service';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { SelectionModel } from '@angular/cdk/collections';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { ExcelService } from '../excel.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatRadioModule } from '@angular/material/radio';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';

export interface CaseList {
    servicerequestnumber: string;
    classkey: string;
    maltreators: any[];
    legalguardian: any[];
    reporteddate: string;
    assigneddate: string;
    status: string;
    finding: string;
    intakeserviceid: string;
    county: string;
    selectedCaseforRemoval: any;

}
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-myappealcase',
    templateUrl: './dashboard-myappealcase.component.html',
    styleUrls: ['./dashboard-myappealcase.component.scss', '../dashboard-common.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,MatTableModule,CommonModule,MatRadioModule,MatFormFieldModule,MatInputModule,MatButtonModule],
    standalone: true
})
export class DashboardMyappealcaseComponent implements OnInit {
    myIRIntakeList$!: Observable<any>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    inputRequest!: any
    currentStatus!: string;
    agency: any;
    servicerequestnumber!: string | null;
    searchStrem: any;
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
    // selectedAppealForClosure: any;
    displayedColumns: string[] = ['servicerequestnumber', 'classkey', 'maltreators', 'legalguardian', 'reporteddate', 'closeddate', 'assigneddate', 'action', 'jurisdiction'];
    focusname!: string | null;
    // , 'finding'

    constructor(
        private _formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService,
        private _commonHttpService: CommonHttpService,
        private _router: Router,
        private _authService: AuthService,
        private excelService: ExcelService
    ) { }

    ngOnInit() {
        this.agency = this._authService.getAgencyName();
        this.sortData = {
            active: 'closeddate',
            direction: 'asc'
        };
        this.currentStatus = 'REVIEW';
        this.getAppeals(1);
    }

    ExportTOExcel() {
        this.export = true;
        this.getAppeals(1, true);

    }

    customSort(event: any) {
        this.sortData = event;
        this.getAppeals(1);
        this.paginationInfo.pageNumber = 1;
    }
    getAppeals(pageNo: number, isExportToExcel: boolean = false) {
        setTimeout(() => {
            this.isLoading = true;
        });
        this._commonHttpService.endpointUrl = `servicerequestsearches/getappeal?filter`;

        this.inputRequest = { 
            sort: this.sortData , 
            currentStatus: this.currentStatus 
        };
        if (this.searchStrem) {
            this.inputRequest['servicerequestnumber'] = this.searchStrem;
        }
        if(this.focusname){
            this.inputRequest['focusname'] = this.focusname ? this.focusname : null;
        }
       
        if (this.export) {
            this.inputRequest['totalNumber'] = this.totalRecords;
        }
        const body = new PaginationRequest({
            where: this.inputRequest,
            page: pageNo,
            nolimit:isExportToExcel,
            limit: isExportToExcel ? 1000 : 10,
            method: 'get',
            count: -1
        });
        this._commonHttpService.getArrayList(body).subscribe(data => {
            if (this.export) {
                this.checkIfGetAppealDashboardFn(data);
                this.export = false;
                this.isLoading = false;
            } else {
                this.dataSource.data = [];
                this.checkElseGetAppealDashboardFn(data, pageNo);
                this.isLoading = false;
            }
        });
    }

    private checkElseGetAppealDashboardFn(data: any[], pageNo: number) {
        if (data && data.length > 0) {
            if (data[0].getappealdashboard && data[0].getappealdashboard.length > 0) {
                this.myIRIntakeList = data[0].getappealdashboard.map((ele: any) => {
                 
                    if (ele.maltreators && ele.maltreators.length > 0) {
                        ele.maltreators = ele.maltreators.map((d: { name: any; }) => d.name).join(', ');
                    }
                    return ele;
                });
                this.dataSource.data = this.myIRIntakeList as CaseList[];
                if (pageNo === 1 && data[0].getappealdashboard && data[0].getappealdashboard.length > 0) {
                    this.totalRecords = data[0].getappealdashboard[0].totalcount;
                }
            }
        }
    }

    private checkIfGetAppealDashboardFn(data: any[]) {
        if (data && data.length > 0) {
            if (data[0].getappealdashboard && data[0].getappealdashboard.length > 0) {
                const dashboardlist = data[0].getappealdashboard.map((ele1: any) => {
                  
                    if (ele1.maltreators && ele1.maltreators.length > 0) {
                        ele1.maltreators = ele1.maltreators.map((d: { name: any; }) => d.name).join(', ');
                    }
                    return ele1;
                });
                const exportData = dashboardlist.map((expData: any) => {
                    return {
                        'CASE NUMBER': expData.servicerequestnumber,
                        'TYPE': expData.classkey,
                        'FOCUS': expData.maltreators,
                        'HEAD OF HOUSEHOLD': expData.legalguardian,
                        'INVESTIGATION CLOSED DATE': expData.reporteddate,
                        'DATE ASSIGNED': expData.assigneddate,
                        'STATUS': expData.status,
                        'COUNTY': expData.county
                    };
                });
                this.excelService.exportAsExcelFile(exportData, 'downloadAppealCase');
            }
        }
    }

    pageChanged(pageNo: number) {
        this.getAppeals(pageNo);
    }

    routToCaseWorker(item: DSDSActionDetails) {
        this._commonHttpService
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
                    this._commonHttpService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
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

    onSearchCase() {
        this.searchStrem = this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber;
        this.getAppeals(1);
    }

    onSearchFocusName() {
        this.focusname = this.focusname ? this.focusname.trim() : this.focusname;
        this.getAppeals(1);
    }

    resetFilter() {
        this.searchStrem = null;
        this.servicerequestnumber = null;
        this.focusname = null;
        this.getAppeals(1);
        this.paginationInfo.pageNumber = 1;
    }

    changeStatus(event: any) {
        this.getAppeals(1);
    }

    //Closing the status for Dashboard Appeal cases 
    closeDashboardAppealCaseStatus(item: any){
        const payload = {
            routingid: item.routingid,
            activeflag: 0,
            objectid:item.intakeserviceid,
            actiondatetime:  new Date()
        };
        this._commonHttpService.patch(
        item.routingid,
          payload,
          'routing/completeappeal'
        ).subscribe(
          response => {
            this._alertService.success('Successfully updated status!');
            this.getAppeals(1);
          },
          error => {
            this._alertService.error('Error in updating status!');
          }
        );
      }
}

import { Component, OnInit, ViewChild, ElementRef, Injector, Input } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AlertService } from '../../../@core/services/alert.service';
import { CommonHttpService, DataStoreService, AuthService, SessionStorageService } from '../../../@core/services';
import { Router } from '@angular/router';
import { HomeDashboardUrlConfig } from '../home-dashbaord.url.config';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { Observable, Subject } from 'rxjs';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { DSDSActionDetails } from '../../case-worker/_entities/caseworker.data.model';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { SelectionModel } from '@angular/cdk/collections';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { ExcelService } from '../excel.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PersonInformationComponent } from '../person-information/person-information.component';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatRadioModule } from '@angular/material/radio';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
export interface CaseList {
    caseid: string;
    enddate: string;
    legalguardian: any;
    statustypekey: string;
    programarea: any;
    adoptioncasenumber: string;
    startdate: string;
    accepteddate: string;
    isfatality: string;
    fatalityinfo: any;
    ismaltreatment: string;


}
@Component({
    selector: 'dashboard-myadoptioncase',
    templateUrl: './dashboard-myadoptioncase.component.html',
    styleUrls: ['./dashboard-myadoptioncase.component.scss', '../dashboard-common.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,MatTableModule,CommonModule,PersonInformationComponent,MatTooltipModule,MatRadioModule,ReactiveFormsModule,MatFormFieldModule,MatInputModule,MatButtonModule],
    standalone: true
})
export class DashboardMyadoptioncaseComponent implements OnInit {
    currentStatus!: string;
    export = false;
    inputRequest!: any;
    searchStrem: string | null = null;
    myIRIntakeList$!: Observable<any>;
    totalRecords$!: Observable<number>;
    myserviceForm!: FormGroup;
    private searchTermStream$ = new Subject<string>();
    paginationInfo: PaginationInfo = new PaginationInfo();
    agency: any;
    servicerequestnumber!: string | null;
    myCaseList: any;
    totalRecords: any;
    selection = new SelectionModel<CaseList>(true, []);
    sortData: any;
    @ViewChild(MatPaginator)
    paginator!: MatPaginator;
    @ViewChild(MatSort)
    sort!: MatSort;
    @ViewChild('input')
    input!: ElementRef;

    dataSource = new MatTableDataSource<CaseList>();
    isLoading = false;
    displayedColumns: string[] = ['adoptioncasenumber', 'childdetails', 'startdate', 'enddate', 'statustypekey'];
    caseworkerpageurl = '/pages/case-worker/';

    private _formBuilder: FormBuilder;
    private _alertService: AlertService;
    private _dataStoreService: DataStoreService;
    private _commonService: CommonHttpService;
    private _router: Router;
    private _authService: AuthService;
    private _session: SessionStorageService;
    private excelService: ExcelService;

    constructor(private injector : Injector){
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._router = this.injector.get<Router>(Router);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this.excelService = this.injector.get<ExcelService>(ExcelService);
    }

    ngOnInit() {
        this.agency = this._authService.getAgencyName();
        this.myserviceForm = this._formBuilder.group({
            filterIR: ['inprogress']
        });
        this.sortData = {
            active: 'childdetails',
            direction: 'asc'
        };
        this.getIR(1, 'inprogress');
        this._dataStoreService.setData('ADOPTIONCASEDASHBOARD-LOADED', false);
    }

    customSort(event: any) {
        this.sortData = event;
        this.getIR(1, this.myserviceForm.value.filterIR);
        this.paginationInfo.pageNumber = 1;
    }
    ExportTOExcel() {
        this.export = true;
        this.getIR(1, this.myserviceForm.value.filterIR);

    }

    getIR(pageNo: number, status: any) {
        setTimeout(() => {
            this.isLoading = true;
        });
        this.currentStatus = status;
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myDsdsActions.adoptioncaselist}?data`;
        if (status === 'inprogress') {
            this.inputRequest = { servicerequestnumber: this.searchStrem, actiontype: 'servicecase', status: 'open', sort :  this.sortData };
        } else if (status === 'pending') {
            this.inputRequest = { servicerequestnumber: this.searchStrem, actiontype: 'servicecase', status: 'pending', sort :  this.sortData };
        } else if (status === 'closed') {
            this.inputRequest = { servicerequestnumber: this.searchStrem, actiontype: 'servicecase', status: 'closed', sort :  this.sortData };
        } else if (status === 'All') {
            this.inputRequest = { servicerequestnumber: this.searchStrem, actiontype: 'servicecase', sort :  this.sortData  };
        } else {
            this.inputRequest = { casenumber: this.searchStrem, actiontype: 'servicecase' };
        }
        if (this.export) {
            this.inputRequest['totalNumber'] = this.totalRecords;
        }

        const body = new PaginationRequest({
            page: pageNo,
            limit: 10,
            where: this.inputRequest,
            method: 'get',
            count: -1
        });
       this._commonService.getPagedArrayList(body).subscribe((data: any) => {

            if (this.export) {
                this.excelService.exportAsExcelFile(data.data, 'downloadAdoptionCase');
                this.export = false;
                this.isLoading = false;
            } else {
                this.myCaseList = data.data;
                this.dataSource.data = this.myCaseList as CaseList[];
                this.isLoading = false;
                if (pageNo === 1) {
                    this.totalRecords = data.count;
                    this._dataStoreService.setData('ADOPTIONCASEDASHBOARD-COUNT', this.totalRecords);
                    this._dataStoreService.setData('ADOPTIONCASEDASHBOARD-LOADED', true);
                }
            }
        });


    }
    onSearchCase() {
        this.searchStrem = this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber;
        this.getIR(1, 'search');
    }
    listMyIrCase(event: any) {
        const status = event.value;
        this.getIR(1, status);
    }
    routToCaseWorker(item: DSDSActionDetails) {
        this._session.setTabKeyKey(item.servicerequestnumber);
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttypekey);
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
                    this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response: any) => {
                        const dsdsActionsSummary = response[0];
                        if (dsdsActionsSummary) {
                            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                            // To be developed : DEB As discussed with management we are parking this link but we are working on separate branch after extensive testing this will
                            // be available for user
                            const currentUrl = this.caseworkerpageurl + item.caseid + '/' + item.servicecasenumber + '/dsds-action/person-cw';
                            this._router.navigate([currentUrl]);
                        }
                    });
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );

    }

    routToCaseWorker1(item: DSDSActionDetails) {
        this._session.setTabKeyKey(item.adoptioncasenumber);
        this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
        this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
        this._session.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.startdate);
        this._session.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        }
        this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response: any) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                // To be developed : DEB As discussed with management we are parking this link but we are working on separate branch after extensive testing this will
                // be available for user
                if (item.statustypekey === 'Closed') {
                    const currentUrl = this.caseworkerpageurl + item.adoptioncaseid + '/' + item.adoptioncasenumber + '/dsds-action/disposition';
                    this._router.navigate([currentUrl]);
                } else {
                    const currentUrl = this.caseworkerpageurl + item.adoptioncaseid + '/' + item.adoptioncasenumber + '/dsds-action/adoption-persons';
                    this._router.navigate([currentUrl]);
                }
            }
        });
    }
    pageChanged(pageNo: number) {
        this.getIR(pageNo, this.currentStatus);
    }
    resetFilter() {
        this.searchStrem = null;
        this.servicerequestnumber = null;
        this.paginationInfo.pageNumber = 1;
        this.myserviceForm.patchValue({ filterIR: 'inprogress' });
        this.getIR(1, 'inprogress');
    }
}

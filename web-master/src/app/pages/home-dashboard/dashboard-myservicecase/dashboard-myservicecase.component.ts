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
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { SelectionModel } from '@angular/cdk/collections';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { ExcelService } from '../excel.service';
import { environment } from '../../../../../src/environments/environment';
import { config } from '../../../../../src/environments/config';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatRadioModule } from '@angular/material/radio';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
export interface ServiceCaseList {
    county: string;
    caseid: string;
    enddate: string;
    legalguardian: any;
    open_closed: string;
    programarea: any;
    servicecasenumber: string;
    startdate: string;
    accepteddate: string;
    isfatality: string;
    fatalityinfo: any;
    ismaltreatment: string;
}
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-myservicecase',
    templateUrl: './dashboard-myservicecase.component.html',
    styleUrls: ['./dashboard-myservicecase.component.scss', '../dashboard-common.scss'],
    imports:[MatSortModule,PaginationModule,FormsModule,MatTableModule,CommonModule,MatTooltipModule,MatRadioModule,ReactiveFormsModule,MatFormFieldModule,MatInputModule,MatButtonModule],
    standalone: true
})
export class DashboardMyservicecaseComponent implements OnInit {
    currentStatus!: string;
    inputRequest!: any;
    searchStrem: any | null = '';
    myCaseList$!: Observable<any>;
    totalRecords$!: Observable<number>;
    myserviceForm!: FormGroup;
    private searchTermStream$ = new Subject<string>();
    paginationInfo: PaginationInfo = new PaginationInfo();
    agency: any;
    servicerequestnumber!: string | null;
    myServiceCaseList: any;
    totalRecords: any;
    selection = new SelectionModel<ServiceCaseList>(true, []);
    sortData: any;
    @ViewChild(MatPaginator)
    paginator!: MatPaginator;
    @ViewChild(MatSort)
    sort!: MatSort;
    @ViewChild('input')
    input!: ElementRef;
    export = false;
    caseworkerpageurl = '/pages/case-worker/';
    dataSource = new MatTableDataSource<ServiceCaseList>();
    isLoading = false;
    displayedColumns: string[] = ['servicecasenumber', 'legalguardian', 'programarea', 'startdate', 'enddate', 'open_closed', 'jurisdiction', 'responsibilitytypekey'];
    restrictedcaseenable!: boolean;

    private _formBuilder: FormBuilder;
    private _alertService: AlertService;
    private _dataStoreService: DataStoreService;
    private _commonService: CommonHttpService;
    private _router: Router;
    private _authService: AuthService;
    private _session: SessionStorageService;
    private excelService: ExcelService;

    constructor(private injector: Injector){
        this._formBuilder= this.injector.get<FormBuilder>(FormBuilder);
        this._alertService= this.injector.get<AlertService>(AlertService);
        this._dataStoreService= this.injector.get<DataStoreService>(DataStoreService);
        this._commonService= this.injector.get<CommonHttpService>(CommonHttpService);
        this._router= this.injector.get<Router>(Router);
        this._authService= this.injector.get<AuthService>(AuthService);
        this._session= this.injector.get<SessionStorageService>(SessionStorageService);
        this.excelService= this.injector.get<ExcelService>(ExcelService);
 }

    ngOnInit() {
        this.restrictedcaseenable = config.restrictedcaseenable && environment.envName !== 'Production';
        this.agency = this._authService.getAgencyName();
        this.myserviceForm = this._formBuilder.group({
            filterCase: ['Open']
        });
        this.sortData = {
            active: "legalguardian",
            direction: "asc"
        };
       this.getCase(1,'Open');
    }
    
    ExportTOExcel() {
        this.export =true;
        this.getCase(1,this.myserviceForm.value.filterCase);
        
    }

    customSort(event: any) {
        this.sortData = event;
        this.getCase(1, this.myserviceForm.value.filterCase);
        this.paginationInfo.pageNumber=1;
    }

    getCase(pageNo: number, status: any) {
        setTimeout(() => {
            this.isLoading = true;
        });
        if(!this.export){
          this.dataSource.data = [];
        }
        this.currentStatus = status;
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.myDsdsActions.DSDSServiceDetailsUrl}?data`;
        if (status === 'Open') {
            this.inputRequest = {  actiontype: 'servicecase', status: 'Open', sort :  this.sortData };
        } else if (status === 'Closed') {
            this.inputRequest = {  actiontype: 'servicecase', status: 'Closed', sort :  this.sortData };
        } else if (status === 'All') {
           this.inputRequest = { actiontype: 'servicecase', status: null , sort :  this.sortData};
        } else {
            this.inputRequest = {  actiontype: 'servicecase', status: null , sort :  this.sortData};
         }

        if (this.searchStrem) {
            this.inputRequest['servicerequestnumber'] = this.searchStrem;
        }

        if(this.export){
            this.inputRequest['totalNumber'] = this.totalRecords;
        }

        const activeModuleNav = this._session.getItem('activeModuleNav');
        if(activeModuleNav == 'Qualified Individual' ||  activeModuleNav == 'FTDM/QI Supervisor' || activeModuleNav == 'FTDM Facilitator') {
            this.inputRequest['currentrole'] = activeModuleNav;
        }

        const body = new PaginationRequest({
            where: this.inputRequest,
            page: pageNo,
            limit: 10,
            method: 'get',
            count: -1
        });

        this._commonService.getPagedArrayList(body).subscribe((data: any) => {
            if(this.export){
                this.excelService.exportAsExcelFile(data.data, 'downloadServiceCase');
                this.export = false;
                this.isLoading = false;
            } else {
                this.myServiceCaseList = data.data;
           
                this.dataSource.data = this.myServiceCaseList as ServiceCaseList[];
                if (pageNo === 1) {
                    this.totalRecords = data.count;
                    this._dataStoreService.setData('SERVICECASEDASHBOARD-COUNT', this.totalRecords);
                    this._dataStoreService.setData('SERVICECASEDASHBOARD-LOADED', true);
                }
                this.isLoading = false;
            }
        });


    }
    onSearchCase() {
        this.searchStrem = this.servicerequestnumber ? this.servicerequestnumber.trim() : this.servicerequestnumber;
        this.getCase(1, 'search');
    }

    listMyCase(event: any) {
        const status = event.value;
        this.getCase(1, status);
    }
    routToCaseWorker(item: DSDSActionDetails) {
        this._session.setTabKeyKey(item.servicerequestnumber);
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._session.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
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
        if(item.restrictstatus === 'EXCLUDE' || (item.restrictstatus === 'INCLRES' && this.restrictedcaseenable)){
            (<any>$('#exclude')).modal('show');
        }else{
            this._session.setTabKeyKey(item.servicecasenumber);
            this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            if (item) {
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttypekey);
                const caseType = item?.programareabyservicecase?.[0]?.intakedastagingdtls?.General?.PurposeName;
                this._dataStoreService.setData('Case Type', caseType);
            }
            const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.caseid + '/casetype';
            this._commonService.getAll(url).subscribe((response: any) => {
                const dsdsActionsSummary = response[0];
                this.validateIfDsdsActionsSummary(dsdsActionsSummary, item);
            });
        }
    }
    private validateIfDsdsActionsSummary(dsdsActionsSummary: any, item: DSDSActionDetails) {
        if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            if (this._session.getItem('activeModuleRole') == null && this._session.getItem('selectedModuleRole') !== null) {
                this._session.setItem('activeModuleRole', this._session.getItem('selectedModuleRole'));
            }
            if (item.open_closed === 'Closed') {
                const currentUrl = this.caseworkerpageurl + item.caseid + '/' + item.servicecasenumber + '/dsds-action/disposition';
                this._router.navigate([currentUrl]);
            } else {
                const currentUrl = this.caseworkerpageurl + item.caseid + '/' + item.servicecasenumber + '/dsds-action/report-summary';
                this._router.navigate([currentUrl]);
            }
        }
    }

    pageChanged(pageNo: number) {
        this.getCase(pageNo, this.currentStatus);
    }

    resetFilter() {
        this.searchStrem = null;
        this.servicerequestnumber = null;
        this.getCase(1, 'Open');
        this.paginationInfo.pageNumber = 1;
        this.myserviceForm.patchValue({ filterCase: 'Open' });
    }
}
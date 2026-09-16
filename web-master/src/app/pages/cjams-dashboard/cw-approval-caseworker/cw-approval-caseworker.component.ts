
import {map, mergeMap, startWith, debounceTime} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Subject ,  Observable, merge } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { AssignedCase, ReviewGridModal, ReviewCase, RoutingUser } from '../_entities/dashBoard-datamodel';
import { DashBoard } from '../cjams-dashboard-url.config';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { AuthService, DataStoreService, SessionStorageService, LocalStorageService, AlertService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { PersonInformationComponent } from '../../home-dashboard/person-information/person-information.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { RouterLink } from '@angular/router';
import { MatSortModule } from '@angular/material/sort';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-approval',
    templateUrl: './cw-approval-caseworker.component.html',
    styleUrls: ['./cw-approval-caseworker.component.scss'],
    imports:[SortTableModule,MatSortModule,MatSelectModule,MatCheckboxModule,PaginationModule,FormsModule,CommonModule,PersonInformationComponent,MatDatepickerModule,ReactiveFormsModule,RouterLink,MatFormFieldModule,MatInputModule,MatSelectModule],
    standalone: true
})
export class CwApprovalCaseWorkerComponent implements OnInit {
    subscriber: any[] = [];
    endpointUrl!: string;
    currentUrl!: string;
    paginationInfo: PaginationInfo = new PaginationInfo();
    casepaginationInfo: PaginationInfo = new PaginationInfo();
    totalRecords!: number;

    workloadForm!: FormGroup;

    roleDetails!: AppUser;
    workloadsearch!: boolean;
    unitdropdownValue!: boolean;
    workerdropdownValue!: boolean;
    caseType$!: Observable<DropdownModel[]>;
    statisticsrequest!: Object;
    inputRequestXLDoc!: Object;
    showXLIcon!: boolean;
    isShowPiChart!: boolean;
    showWorkLoadTable = true;
    showPagination = true;
    user: any;
    caseWorkerList: any;
    teamList: any;
    departmentList: any;
    chart: any;
    chart1: any;
    assignedCaseForm!: FormGroup;
    selectedPerson: any;
    serviceRequestId!: string;

    mergeUsersList: RoutingUser[] = [];
    assignedStatus!: boolean;
    isSupervisor!: boolean;
    selectedResponsibilityType!: string | null;
    zipCodeIndex!: number;
    appealStatus!: boolean;
    getServicereqid!: string;
    zipCode!: string;
    isGroupId = false;
    isGroup = false;
    isCPSAR!: boolean;
    servreqsubtype!: string;
    supervisorReviewStatus!: boolean;
    totalRecordsAssingedCase!: number;
    getUsersList!: RoutingUser[];
    originalUserList!: RoutingUser[];
    totalRecordsCaseReview!: number;
    totalRecordsSupervisor!: number;
    assignedSearchCriteria: any;
    reviewSearchCriteria: any;
    previousPage!: number;
    dynamicObjectAssignCase: DynamicObject = {};
    reviewPaginationInfo: PaginationInfo = new PaginationInfo();
    dynamicObjectReviewToSupervisor: DynamicObject = {};
    dynamicObjectCaseReview: DynamicObject = {};
    assingedCaseSummary!: AssignedCase[];

    responsibilityTypeDropdownItems$!: Observable<DropdownModel[]>;
    reviewToSupervisor: any[] = [];
    totalReviewToSupervisor!: ReviewGridModal[];
    tobeassignedPaginationInfo: PaginationInfo = new PaginationInfo();
    onGoingPaginationInfo: PaginationInfo = new PaginationInfo();
    reviewCases: ReviewCase[] = [];
    roleId!: AppUser;
    supervisorList: Array<any[]> = [];
    private pageStreamOnGoing$ = new Subject<number>();
    private searchTermStreamOnGoing$ = new Subject<DynamicObject>();
    casetotalRecords: any;
    workerName: string | null = null;
    intitalLoadTeams: boolean = true;
    intitalLoadUnitWorker: boolean = true;
    teamtypekey!: string;
    workersList: any[] = [];
    childList$!: Observable<any[]>;
    getroutinguserurl = 'Intakedastagings/getroutingusers';
    servicecase = 'Service Case';
    caseworkerpageurl = '#/pages/case-worker/';
    constructor(
        private _commonService: CommonHttpService,
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _dataStoreService: DataStoreService,
        private _session: SessionStorageService,
        private _localstorage: LocalStorageService,
        private _alertService: AlertService) { }

    ngOnInit() {
        this.roleId = this._authService.getCurrentUser();
        this.paginationInfo.sortColumn = 'startdate';
        this.paginationInfo.sortBy = 'desc';
        this.roleDetails = this._authService.getCurrentUser();
        if(this.roleDetails && this.roleDetails.role && this.roleDetails.role.teamtypekey){
            this.teamtypekey = this.roleDetails.role.teamtypekey;
          }
        this.user = this._localstorage.getObj('userProfile');
        this.paginationInfo.sortColumn = 'receiveddate';
        this.paginationInfo.sortBy = 'desc';
        this.formAssignInitilize();
        this.workloadForm.patchValue({
            toworkerid: this.roleId.user.userprofile.securityusersid,
            startdate: new Date(new Date().getTime() - (7 * 24 * 60 * 60 * 1000)) ,
            enddate: new Date()
        });
        this.loadSupervisor();
        this.assignedToSupervisor(1);
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.getCaseTypeList();
        this.getCountyList();
    }
    formAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: [''],
            securityusersid: [''],
            dateFrom: [''],
            dateTo: ['']
        });
        this.workloadForm = this.formBuilder.group({
            servicecasenumber: null,
            localdeptid: [''],
            teamid: [null],
            toworkerid: [null],
            startdate: [null],
            enddate: [null],
            statuscode: [null],
            casetype: [null],
            serreqno: ['']
        });
    }


    getCaseTypeList() {
        this.caseType$ = this._commonService.getArrayList({
            where: { referencetypeid: '752', teamtypekey: 'CW' },
            method: 'get'
        }, 'referencetype/gettypes?filter').pipe(map((item) => {
            return item.map((res) =>
                new DropdownModel({
                    text: res.description,
                    value: res.value_text
                }));
        }));
    }

    getworkerlist() {
        this.subscriber[2] = this._commonService.getPagedArrayList(new PaginationRequest({ where: { appevent: 'INVR' }, method: 'post' }), this.getroutinguserurl)
            .subscribe(result => {
                this.caseWorkerList = result.data;
                this.caseWorkerList = this.caseWorkerList.filter((res: { issupervisor: any; agencykey: string; }) => !res.issupervisor && res.agencykey === 'CW');
            });
    }
    getdepartmentlist() {
        this.subscriber[6] = this._commonService.getPagedArrayList(new PaginationRequest({
            where: { activeflag: 1, teamtypekey: 'LDSS' },
            method: 'get', nolimit: true
        }), 'manage/team/list?filter').subscribe((result) => {
            this.departmentList = result.data;
            if (!this.unitdropdownValue) {
                this.workloadForm.controls['statuscode'].patchValue('open');
                if (this.roleDetails.user.userprofile.teammemberassignment.teammember.team.teamtypekey !== 'LDSS') {
                    const parentteamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.parentteamid;
                    this.workloadForm.controls['localdeptid'].patchValue(parentteamid);
                } else {
                    const teamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.id;
                    this.workloadForm.controls['localdeptid'].patchValue(teamid);
                }
            }
            this.getteamlist();
        });
    }

    getCountyList() {
        this._commonService.getArrayList({
            where: {},
            order: 'countyname',
            nolimit: true,
            method: 'get'
        }, 'admin/county?filter').subscribe((item) => {
            this.departmentList = item;
            if (!this.unitdropdownValue) {
                this.workloadForm.controls['statuscode'].patchValue('open');
                if (this.roleDetails.user.userprofile.teammemberassignment.teammember.team.teamtypekey !== 'LDSS') {
                    const parentteamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.countyid;
                    this.workloadForm.controls['localdeptid'].patchValue(parentteamid);
                } else {
                    const teamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.id;
                    this.workloadForm.controls['localdeptid'].patchValue(teamid);
                }
            }
            this.getteamlist();
        });
    }
    onSorted($event: any) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        const sortColumn = $event.sortColumn;
        this.reviewToSupervisor = this.totalReviewToSupervisor;
        if ($event.sortDirection === 'asc') {
            this.reviewToSupervisor.sort((a: any, b: any) => a[sortColumn].localeCompare(b[sortColumn]));
        } else {
            this.reviewToSupervisor.sort((a: any, b: any) => b[sortColumn].localeCompare(a[sortColumn]));
        }
    }

    getteamlist() {
        const id = this.workloadForm.get('localdeptid')?.value;
        this.workloadForm.get('teamid')?.patchValue('');
        this.workloadForm.get('toworkerid')?.patchValue(this.intitalLoadTeams ? this.roleId.user.userprofile.securityusersid : '');
        this.intitalLoadTeams = false;
        this.workloadForm.get('teamid')?.disable();
        this.workloadForm.get('toworkerid')?.disable();
        const obj: any = {
            activeflag: 1
        };
        if (id !== '' && id !== undefined && id !== null) {
            obj['countyid'] = id;
        } else {
            obj['countyid'] = null;
        }
        const teamTypeK = (typeof this.user.teamtypekey === 'string') ? this.user.teamtypekey.toUpperCase() : this.user.teamtypekey;
        obj['teamtypekey'] = this.teamtypekey ? this.teamtypekey : teamTypeK;
        this.subscriber[3] = this._commonService.getPagedArrayList(new PaginationRequest({
            where: obj, method: 'get', nolimit: true
        }
        ), 'manage/team/list?filter')
            .subscribe(result => {
                this.teamList = result.data;
                this.workloadForm.get('teamid')?.enable();
                if (!this.workloadsearch) {
                    const teamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.id;
                    this.workloadForm.controls['teamid'].patchValue(teamid);
                }
                this.loadUnitWorkers();
            });
    }

    loadUnitWorkers() {
        const id = this.workloadForm.get('teamid')?.value;
        this.workloadForm.get('toworkerid')?.patchValue(this.intitalLoadUnitWorker ? this.roleId.user.userprofile.securityusersid : '');
        this.intitalLoadUnitWorker = false;
        this.workloadForm.controls['casetype'].patchValue('');
        const obj = {
            teamid: id === '' ? null : id,
            filtertypekey: 'worker'
        };
        this.subscriber[7] = this._commonService.getPagedArrayList(new PaginationRequest({
            where: obj,
            method: 'get',
            nolimit: true
        }), 'manage/team/getteamusers?filter').subscribe((result: any) => {
            this.caseWorkerList = result;
            this.workloadForm.get('toworkerid')?.enable();

            this.workloadsearch = true;
            this.unitdropdownValue = true;
            this.workerdropdownValue = true;
        });
    }
   
    selectPersonForAssign(checkBox: any, row: any) {
        if (checkBox.checked) {
            const userData = { userid: row.userid, username: row.username };
            this.workersList.push(userData);
        } else {
           this.workersList = this.workersList.filter(worker => worker.userid !== row.userid);
        }
    }
    isChildResponsibilityTypeSelected(user: any){
        const responsibilitytypekey = this.workersList.filter(worker => worker.userid === user.userid);
        if(responsibilitytypekey.length){
            if(responsibilitytypekey[0].responsibilitytypekey === 'child'){
                return true;
            }
        }
        return false;
    }
    getPersonsList(caseId: any) {
        this.childList$ = this._commonService.getPagedArrayList(
            {
                page: 1,
                limit: 20,
                method: 'get',
                where: { 'caseid': caseId }
            }, 'Caseassignments/getresponsibilitychild?filter').pipe(map((item: any) => {
                return item;
            }));
    }

    changeResponsibility(event: any, user: any) {
        const isWokerAvailable = this.workersList.find(worker => worker.userid === user.userid);
        if (isWokerAvailable) {
            this.workersList.forEach(worker => {
                if (worker.userid === user.userid) {
                    worker.responsibilitytypekey = event.value;
                }
            });
        } else {
            this._alertService.error('please select the worker');
            event.source.value = null;
        }

    }

    addChild(event: any, user: any) {
        const isWokerAvailable = this.workersList.find(worker => worker.userid === user.userid);
        if (isWokerAvailable) {
            this.workersList.forEach(worker => {
                if (worker.userid === user.userid) {
                    worker.child = event.value.map((item: any) => ({
                        intakeservicerequestactorid: item
                    }));
                }
            });
        }
    }

    assignedToSupervisor(selectPage: number) {
        this.supervisorReviewStatus = true;
        this.appealStatus = false;
        this.isGroupId = false;
        const pageSource = this.pageStreamOnGoing$.pipe(map((pageNumber) => {
            this.onGoingPaginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObjectReviewToSupervisor, page: pageNumber };
        }));

        const searchSource = this.searchTermStreamOnGoing$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObjectReviewToSupervisor = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);

        var serreqnoRequest = this.workloadForm.value.serreqno;
        var toworkeridRequest = this.workloadForm.value.toworkerid;
        var teamidRequest = this.workloadForm.value.teamid;

        if(serreqnoRequest !== null && serreqnoRequest !== ''){
            toworkeridRequest = null;
            teamidRequest = null;
        }
        // SonarQube - Remove this useless assignment to variable "source".
        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectReviewToSupervisor,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                this.assignedSearchCriteria = {
                    role: this.roleId.role.description === 'Supervisor,CW' ? 'CWSP' : '',
                    serreqno: this.workloadForm.value.serreqno,
                    securityusersid: toworkeridRequest,
                    dateFrom: this.workloadForm.value.startdate ? this.workloadForm.value.startdate : null,
                    dateTo: this.workloadForm.value.enddate ? this.workloadForm.value.enddate : null,
                    teamid: teamidRequest
                };
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.onGoingPaginationInfo.pageSize50,
                        page: selectPage,
                        method: 'post',
                        where: this.assignedSearchCriteria
                    }),
                    DashBoard.EndPoint.AssinedCase.CaseWorkerReviewUrl
                );
            }),)
            .subscribe((result) => {
                this.reviewToSupervisor = result.data;
                this.totalReviewToSupervisor = result.data;
                if (this.onGoingPaginationInfo.pageNumber === 1) {
                    this.totalRecordsSupervisor = result.count;
                }
            });
    }
    onGoingPageChanged(pageInfo: any) {
        this.onGoingPaginationInfo.pageNumber = pageInfo.page;
        this.onGoingPaginationInfo.pageSize50 = pageInfo.itemsPerPage;
        if (this.onGoingPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.assignedToSupervisor(this.onGoingPaginationInfo.pageNumber);
    }
    getRoutingUser(modal: AssignedCase) {
        this.getServicereqid = modal.servicereqid;
        this.zipCode = modal.incidentlocation;
        this.getUsersList = [];
        this.originalUserList = [];
        this.isGroup = modal.isgroup;
        this.isCPSAR = false;
        this.servreqsubtype = modal.servreqsubtype;
        if (modal.servreqsubtype === 'CPS-AR') {
            this.isCPSAR = true;
            this.getResponsibilityType();
        }
        let appEvent = 'INTR';
        if (this.roleId.role.name === AppConstants.ROLES.KINSHIP_INTAKE_WORKER || this.roleId.role.name === AppConstants.ROLES.KINSHIP_SUPERVISOR) {
            appEvent = 'KINR';
        }
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent },
                    method: 'post'
                }),
                this.getroutinguserurl
            )
            .subscribe((result) => {
                this.getUsersList = result.data;
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
            });
    }
    getResponsibilityType() {
        this.responsibilityTypeDropdownItems$ = this._commonService.getArrayList({}, 'responsibilitytype').pipe(map((result) => {
            return result.map(
                (res) =>
                    new DropdownModel({
                        text: res.typedescription,
                        value: res.responsibilitytypekey
                    })
            );
        }));
    }
    private loadSupervisor() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTR' },
                    method: 'post'
                }),
                this.getroutinguserurl
            )
            .subscribe(result => {
                this.supervisorList = result['data'];
                this.assignedCaseForm.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
            });
    }
    supervisorChange() {
        this.assignedToSupervisor(1);
    }
    listUser(assigned: string) {
        this.selectedPerson = '';
        this.getUsersList = [];
        this.mergeUsersList = [];
        this.getUsersList = this.originalUserList;
        if (assigned === 'TOBEASSIGNED') {
            if (this.servreqsubtype === 'CPS-AR') {
                this.isCPSAR = true;
            }
            this.getUsersList = this.getUsersList.filter((res) => {
                if (res.issupervisor === false) {
                    this.isSupervisor = false;
                    return res;
                }
            });
            this.reusableListUserFn();
        } else {
            this.isCPSAR = false;
            this.selectedResponsibilityType = null;
            this.getUsersList = this.getUsersList.filter((res) => {
                if (res.issupervisor === true) {
                    this.isSupervisor = true;
                    return res;
                }
            });

            this.reusableListUserFn();
        }
    }
    // Assosiated with listUser function
    private reusableListUserFn() {
        this.getUsersList.forEach((data) => {
            if (data.homelocationcode === this.zipCode || data.worklocationcode === this.zipCode) {
                this.mergeUsersList.push(data);
                this.zipCodeIndex = this.getUsersList.indexOf(data);
                this.getUsersList.splice(this.zipCodeIndex, 1);
            }
        });
        if (this.mergeUsersList !== undefined) {
            this.getUsersList = this.mergeUsersList.concat(this.getUsersList);
        }
    }

    routToCaseWorker(item: any) {
        const daNumber = item.servicerequestnumber.split(' ');
        this._session.setTabKeyKey(daNumber[0]);
        this._dataStoreService.setData('appevent', item.appevent);
        const caseTypeUrl = this.returnCaseTypeUrlFn(item);

        if(!caseTypeUrl){
            return;
        }

        if (this.isGroupId === true) {
            this.serviceRequestId = item.intakeserviceid;
        } else {
            this.serviceRequestId = item.servicereqid;
        }
        if (item.servreqtype === this.servicecase) {
            this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        }
       
        this._commonService.getById(daNumber[0], CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            if(response.length > 0) {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            }
            const currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/' + caseTypeUrl;
            window.open(currentUrl);
        });
    }
    // Assosiate to
    private returnCaseTypeUrlFn(item: any) {
        let caseTypeUrl = '';
        switch (item.appevent) {
            case 'PPLR':
            case 'GAYR':
                caseTypeUrl = this.checkPPLROrGAYRFn(item);
                break;
            case 'CORR':
                caseTypeUrl = 'court/petition-detail';
                break;
            case 'TPRR':
                caseTypeUrl = 'sc-permanency-plan';
                break;
            case 'PWCR':
                caseTypeUrl = 'sdm';
                break;
            case 'CHRR':
                caseTypeUrl = 'child-removal/details';
                break;
            case 'IHSA':
                caseTypeUrl = 'in-home-service/service-agreement';
                break;
            case 'SPLAN':
                caseTypeUrl = this.checkSPLANFn(item);
                break;
            case 'CPLAN3':
                caseTypeUrl = 'case-plan/case-plan-three';
                break;
            case 'CPLAN2':
                caseTypeUrl = 'case-plan/case-plan-two';
                break;
            case 'YTP':
                caseTypeUrl = 'service-plan/youth-transition-plan-new';
                break;
            case 'PLTR':
                caseTypeUrl = this.checkPLTRFn(item);
                break;
            case 'GADR':
            case 'GASR':
            case 'GAARR':
            case 'GAAR':
            case 'GARR':
                caseTypeUrl = this.checkGADR_GASR_GAARR_GAAR_GARR_Fn(item, caseTypeUrl); 
                break;
            case 'ABLR':
            case 'ADPR':
                caseTypeUrl = this.checkABLR_ADPR(item);
                break;
            case 'AARR':
            case 'ASAR':
            case 'ADSR':
                caseTypeUrl = this.checkAARR_ASAR_ADSR(item);
                break;
            case 'ADYR':
                this.checkADYR(item);
                break;
            case 'PCAUTH':
                caseTypeUrl = this.checkPCAUTH(item);
                break;
            case 'SCDR':
                caseTypeUrl = this.checkSCDR(item);
                break;
            case 'ACDR':
                this.checkACDR(item);
                break;
            case 'GAAP':
                caseTypeUrl = this.checkGAAP(item);
                break;
            case 'EXPR':
                this._session.setItem('Expungement_Obj_ID', item.objectid);
                caseTypeUrl = 'investigation-findings';
                break;
            case 'INDR':
                caseTypeUrl = 'disposition';
                break;
            case 'ARSM':
                caseTypeUrl = 'alternative-response-summary';
                break;
            default:
                if (item.eventdescription === 'Assessment' || item.eventdescription === 'assessment') {
                    this.routeReviewCase(item);
                } else {
                    caseTypeUrl = 'report-summary';
                }
            }
        return caseTypeUrl;
    }

    private checkADYR(item: any) {
        this._session.setItem('transid', item.objectid);
        this._session.setItem('transkey', 'annualreview');
        this._session.setItem('Placement-Review-Id', item.objectid);
        this.routToCaseWorker1(item);
    }
    
    private checkPCAUTH(item: any) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.servreqtype === this.servicecase);
        this._session.setItem('PurchaseAuthorization', item.client_id);
        this._session.setItem('PurchaseAuthorizationServiceLog', item.service_log_id);
        return 'service-plan/service-log-activity/referred-services';
    }
    
    private checkSCDR(item: any) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._session.setItem(CASE_STORE_CONSTANTS.DISPOSITIONID_FOR_APPROVAL, item.objectid);
        return 'disposition';
    }
    
    private checkACDR(item: any) {
        this.routToCaseWorker1(item);
        this._session.setItem('transkey', 'suspension');
    }
    
    private checkGAAP(item: any) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._session.setItem(CASE_STORE_CONSTANTS.GAP_APPLICATION_ID, item.objectid);
        this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
        return 'placement/placement-gap/application';
    }

    private checkAARR_ASAR_ADSR(item: any) {
        let caseTypeUrl = '';
        this._session.setItem('transid', item.objectid);
        this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, item.permanencyplanid);
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
    
        if (item.appevent === 'ASAR') {
            if (item.servreqtype === 'Adoption Case') {
                this.routToCaseWorker1(item);
                this._session.setItem('transkey', 'subsidy');
            } else {
                caseTypeUrl = 'placement/adoption/adoption-subsidy/agreement';
                this._session.setItem('transkey', 'subsidy');
            }
        } else if (item.appevent === 'AARR') {
            caseTypeUrl = 'placement/adoption/adoption-subsidy/agreement';
            this._session.setItem('transkey', 'agreementrate');
        } else if (item.appevent === 'ADSR') {
            if (item.servreqtype === 'Adoption Case') {
                this.routToCaseWorker1(item);
                this._session.setItem('transkey', 'suspension');
            } else {
                caseTypeUrl = 'placement/adoption/adoption-subsidy/suspention-payment';
                this._session.setItem('transkey', 'suspension');
            }
        }
        
        return caseTypeUrl;
    }

    private checkABLR_ADPR(item: any) {
        this._session.setItem('transid', item.objectid);
        this._session.setItem('transkey', item.appevent === 'ABLR' ? 'breakthelink' : 'planning');
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, item.permanencyplanid);
        return item.appevent === 'ABLR' ? 'placement/adoption/break-the-line' : 'placement/adoption/planning/checklist';
    }

    private checkGADR_GASR_GAARR_GAAR_GARR_Fn(item: any, caseTypeUrl: string) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
        if (item.appevent === 'GADR') {
            this._session.setItem('Placement-Gap-Disclosure-Id', item.objectid);
            caseTypeUrl = 'placement/placement-gap/disclosure-checklist';
        } else if (item.appevent === 'GASR') {
            this._session.setItem('Placement-Suspension-Id', item.objectid);
            caseTypeUrl = 'placement/placement-gap/assignments';
        } else if (['GAARR', 'GAAR', 'GARR'].includes(item.appevent)) {
            this._session.setItem('Placement-Agreement-Rate-Id', item.objectid);
            this._session.setItem(CASE_STORE_CONSTANTS.APPROVAL_EVENT_CODE, item.appevent);
            caseTypeUrl = 'placement/placement-gap/agreement';
        }
        return caseTypeUrl;
    }

    private checkPLTRFn(item: any) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        }
        return 'sc-placements/list';
    }

    private checkSPLANFn(item: any) {
        this._session.setItem(CASE_STORE_CONSTANTS.SERVICEPLAN_ID, item.entityid);
        return 'service-plan/sc-gc';
    }

    private checkPPLROrGAYRFn(item: any) {
        let caseTypeUrl = '';
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        const isCW = this._authService.isCW();
        if (isCW) {
            if (item.appevent === 'PPLR') {
                caseTypeUrl = 'sc-permanency-plan';
            }
            if (item.appevent === 'GAYR') {
                this._session.setItem('Placement-Review-Id', item.objectid);
                this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
                caseTypeUrl = 'placement/placement-gap/annual-reviews';
            }
        } else {
            caseTypeUrl = 'placement-menu/placement/permanency-plan';
        }
        return caseTypeUrl;
    }

    routeReviewCase(item: AssignedCase) {
        this.serviceRequestId = item.servicereqid;
        const daNumber = item.servicerequestnumber.split(' ');
        this._session.setTabKeyKey(daNumber[0]);
        this._commonService.getById(daNumber[0], CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            if(response.length > 0) {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            }
            if (item.servreqtype === this.servicecase) {
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            }
            if (item.appevent === 'GADR') {
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/placement/placement-gap/disclosure-checklist';
            } else {
                this._dataStoreService.setData('assesment-type', item.typename);
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/assessment';
            }
            if (item.typename === 'APPLA') {
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/sc-permanency-plan/placement/appla/list';
            }
            if (item.typename === 'Shelter Care Authorization and Date of Hearing') {
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/child-removal/details';
            }
           window.open(this.currentUrl);
        });
    }


    routToCaseWorker1(item: any) {
        this._session.setTabKeyKey(item.servicerequestnumber);
        this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
        this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
        this._session.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.reporteddate);
        this._session.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        this._session.setItem('ISSERVICECASE', false);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        }
        this._commonService.getById(item.servicereqid, CaseWorkerUrlConfig.EndPoint.Dashboard.AdoptionActionSummary).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                // To be developed : DEB As discussed with management we are parking this link but we are working on separate branch after extensive testing this will
                // be available for user
                let currentUrl = '';
                if (item.appevent === 'ASAR') {
                    currentUrl = this.caseworkerpageurl + item.servicereqid + '/' + item.servicerequestnumber + '/dsds-action/placement/adoption/adoption-subsidy/agreement';
                } else if (item.appevent === 'ADSR') {
                    currentUrl = this.caseworkerpageurl + item.servicereqid + '/' + item.servicerequestnumber + 
                                    '/dsds-action/placement/adoption/adoption-subsidy/suspention-payment';
                } else if (item.appevent === 'ADYR') {
                    currentUrl = this.caseworkerpageurl + item.servicereqid + '/' + item.servicerequestnumber + 
                                    '/dsds-action/placement/adoption/adoption-subsidy/adoption-annual-reviews';
                } else if (item.appevent === 'ACDR') {
                    this._session.setItem(CASE_STORE_CONSTANTS.DISPOSITIONID_FOR_APPROVAL, item.objectid);
                    currentUrl = this.caseworkerpageurl + item.servicereqid + '/' + item.servicerequestnumber + '/dsds-action/disposition';
                }
                 window.open(currentUrl);
            }
        });
    }

    clearSearch() {
        this.workloadForm.reset();
        this.assignedToSupervisor(1);
    }

    onSearchAssignCase(event: any, serviceCase: any) {
        this.assignedToSupervisor(1);
    }

    groupShow(groupIndex: any, item: any) {
        // No data or function to call
    }

}
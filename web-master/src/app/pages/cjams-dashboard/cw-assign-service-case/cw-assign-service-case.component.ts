
import {mergeMap, map, startWith, debounceTime, switchMap} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators} from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { Subject ,  Observable, EMPTY, merge } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { AssignedCase, ReviewGridModal, ReviewCase, RoutingUser, ChildList } from '../_entities/dashBoard-datamodel';
import { DashBoard } from '../cjams-dashboard-url.config';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { AuthService, AlertService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
// import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
const REFRESH_COUNT = 5;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-assign-service-case',
    templateUrl: './cw-assign-service-case.component.html',
    styleUrls: ['./cw-assign-service-case.component.scss'],
    imports:[SortTableModule,MatSortModule,MatSelectModule,MatCheckboxModule,ReactiveFormsModule,PaginationModule,FormsModule,CommonModule],
    standalone: true
})
export class CwAssignServiceCaseComponent implements OnInit {
    assignedCaseForm!: FormGroup;
    assignServiceCaseForm!: FormGroup;
    teamForm!: FormGroup;
    selectedPerson: any;
    serviceRequestId!: string;
    mergeUsersList: RoutingUser[] = [];
    assignedStatus!: string;
    isSupervisor!: boolean;
    statusDesc: any;
    selectedResponsibilityType!: string | null;
    zipCodeIndex!: number;
    appealStatus!: boolean;
    getServicereqid!: string;
    getServicecaseid!: string;
    assingedServiceCaseSummary!: any[];
    zipCode!: string;
    isGroupId = false;
    isGroup = false;
    servreqsubtype!: string;
    supervisorReviewStatus!: boolean;
    totalRecordsAssingedCase!: number;
    getUsersList: RoutingUser[] = [];
    originalUserList: RoutingUser[] = [];
    totalRecordsCaseReview!: number;
    totalRecordsSupervisor!: number;
    assignedSearchCriteria: any;
    reviewSearchCriteria: any;
    previousPage!: number;
    statusDropdownItems$!: Observable<DropdownModel[]>;
    appealPaginationInfo: PaginationInfo = new PaginationInfo();
    dynamicObjectAssignCase: DynamicObject = {};
    dynamicObjectAppeal: DynamicObject = {};
    reviewPaginationInfo: PaginationInfo = new PaginationInfo();
    dynamicObjectReviewToSupervisor: DynamicObject = {};
    dynamicObjectCaseReview: DynamicObject = {};
    assingedCaseSummary: any;
    paginationInfo: PaginationInfo = new PaginationInfo();
    responsibilityTypeDropdownItems$: DropdownModel[] = [];
    reviewToSupervisor: ReviewGridModal[] = [];
    tobeassignedPaginationInfo: PaginationInfo = new PaginationInfo();
    onGoingPaginationInfo: PaginationInfo = new PaginationInfo();
    reviewCases: ReviewCase[] = [];
    roleId!: AppUser;
    private searchTermStreamAppeal$ = new Subject<DynamicObject>();
    private pageStreamAppeal$ = new Subject<number>();
    private pageStreamOnGoing$ = new Subject<number>();
    private searchTermStreamOnGoing$ = new Subject<DynamicObject>();
    private searchTermStreamAssignCase$ = new Subject<DynamicObject>();
    private pageStreamAssgine$ = new Subject<number>();
    private appealIntakeReqId!: string;
    role!: string;
    roleList: any;
    programArea!: any[];
    workersList: any[] = [];
    programSubArea!: any[];
    programSubAreaList!: any[];
    teamtypekey!: string;
    teamid!: string;
    teamList: Array<any> = [];
    serviceCaseDetails: any;
    supervisorList: any[] = [];
    refreshCounter = 0;
    usernotificationsGetEndPoint = 'Usernotifications/getSingle';
    usernotificationsAddEndPoint = 'Usernotifications/Add';
    getroutingusersurl = 'Intakedastagings/getroutingusers';
    childList: ChildList[] = [];
    serviceCaseResponse: any;
    responsibilityevent: any;
    private _commonService: CommonHttpService;
    private formBuilder: FormBuilder;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private _router: Router;
    private _alertService: AlertService;
    private route: ActivatedRoute;
    private router: Router;
    private _session: SessionStorageService;
    disableprogram!: boolean;
    disableassign: boolean = false;
    constructor(private injector : Injector) {
        this._commonService= this.injector.get<CommonHttpService>(CommonHttpService);
        this.formBuilder= this.injector.get<FormBuilder>(FormBuilder);
        this._authService= this.injector.get<AuthService>(AuthService);
        this._router = this.injector.get<Router>(Router);
        this._dataStoreService= this.injector.get<DataStoreService>(DataStoreService);
        this._alertService= this.injector.get<AlertService>(AlertService);
        this.route= this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.router= this.injector.get<Router>(Router);
        this._session= this.injector.get<SessionStorageService>(SessionStorageService);
     }
    ngOnInit() {
        this.teamtypekey = this._authService.getCurrentUser().role.teamtypekey;
        this.getTeamList();
        this.roleList = AppConstants.ROLES;
        this.statusDesc = { 'OPEN': 'OPEN', 'ASSGN': 'ASSIGNED' };
        this.roleId = this._authService.getCurrentUser();
        const tma = this.roleId.user.userprofile.teammemberassignment;
        const assignments = Array.isArray(tma) ? tma : [tma];
        this.teamid = assignments[0]?.teammember?.teamid;
        this.role = this._authService.getCurrentUser().role.name;
        this.paginationInfo.sortColumn = 'servicerequestnumber';
        this.paginationInfo.sortBy = 'desc';
        this.paginationInfo.pageSize = 10;
        this.tobeassignedPaginationInfo.pageSize = 10;
        this.formAssignInitilize();
        this.loadSupervisor();
        this.getAssignServiceCase(1, 'OPEN');

        this.initAssignServiceFormGroup();
        this.teamForm.controls['teamid'].patchValue(this.teamid);
    }

    private loadProgramAreaDropdowns(servicerequesttypekey: string) {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { servicerequestsubtypekey: servicerequesttypekey },
                    method: 'get',
                    nolimit: true
                }),
                'agencyprogramarea/list?filter'
            )
            .subscribe((result) => {
                if (result && Array.isArray(result) && result.length) {
                    this.programArea = result[0].programarea;
                    this.programSubArea = result[0].subprogram;
                    this.programSubAreaList = result[0].subprogram;
                }
            });
    }

    onProgramAreaChange(e: any){
        const value = e.value;
        if(value === 'KIN' ){
          this.programSubArea = this.programSubAreaList.filter((area) =>["INF", "FOR"].includes(area.subprogramkey));
        } else {
            this.programSubArea = this.programSubAreaList;
        }
    }

    getAssignCase(selectPage: number, assigned: string) {
        this.assignedCaseForm.patchValue({
            serreqno: ''
        });
        this.assignedStatus = assigned;
        this.appealStatus = false;
        this.supervisorReviewStatus = false;
        this.isGroupId = false;
        const pageSource = this.pageStreamAssgine$.pipe(map((pageNumber) => {
            this.tobeassignedPaginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObjectAssignCase, page: pageNumber };
        }));

        const searchSource = this.searchTermStreamAssignCase$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObjectAssignCase = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);
        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectAssignCase,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((_params: { search: DynamicObject; page: number }) => {
                if (this.assignedCaseForm.value.serreqno === '') {
                    this.assignedSearchCriteria = {
                        serreqno: '',
                        assigned: this.assignedStatus,
                        sortcolumn: this.paginationInfo.sortColumn,
                        sortorder: this.paginationInfo.sortBy
                    };
                } else {
                    this.assignedSearchCriteria = {
                        serreqno: this.assignedCaseForm.value.serreqno,
                        assigned: this.assignedStatus,
                        sortcolumn: 'reporteddate', sortorder: 'desc'
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.assignedSearchCriteria
                    }),
                    'Intakedastagings/getroutedda'
                );
            }),)
            .subscribe((result) => {
                result.data.forEach((item) => {
                    item.isCollapsed = true;
                });
                this.assingedCaseSummary = result.data;
                if (this.paginationInfo.pageNumber === 1) {
                    this.totalRecordsAssingedCase = result.count;
                }
            });
    }
    private loadSupervisor() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTR' },
                    method: 'post'
                }),
                this.getroutingusersurl
            )
            .subscribe(result => {
                this.supervisorList = result['data'];
                this.assignedCaseForm.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
            });
    }
    supervisorChange() {
        this.getAssignServiceCase(1, this.assignedStatus);
    }
    getTeamList() {
        this._commonService.getArrayList({
            method: 'get',
            page: 1,
            order: 'teamnumber asc',
            where: {
                activeflag: 1,
                teamtypekey: this.teamtypekey,
                teamid: null
            }
        }, 'manage/team/getteamlist?filter').subscribe((item) => {
            this.teamList = item;
        });
    }
    teamChange() {
        this.getRoutingUserforServiceCase(this.serviceCaseDetails);
    }
    pageAssignedChanged(pageInfo: any) {
        this.tobeassignedPaginationInfo.pageNumber = pageInfo.page;
        this.tobeassignedPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.tobeassignedPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.getAssignCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus);
    }
    formAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: [''],
            securityusersid: ['']
        });
        this.teamForm = this.formBuilder.group({
            teamid: ['']
        });
    }
    onSorted($event: any) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.getAssignServiceCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus);
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

        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectReviewToSupervisor,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((_params: { search: DynamicObject; page: number }) => {
                if (this.assignedCaseForm.value.serreqno === '') {
                    this.assignedSearchCriteria = {
                        serreqno: ''
                    };
                } else {
                    this.assignedSearchCriteria = {
                        serreqno: this.assignedCaseForm.value.serreqno
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.onGoingPaginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.assignedSearchCriteria
                    }),
                    DashBoard.EndPoint.AssinedCase.SupervisorReviewUrl
                );
            }),)
            .subscribe((result) => {
                this.reviewToSupervisor = result.data;
                if (this.onGoingPaginationInfo.pageNumber === 1) {
                    this.totalRecordsSupervisor = result.count;
                }
            });
    }
    onGoingPageChanged(pageInfo: any) {
        this.onGoingPaginationInfo.pageNumber = pageInfo.page;
        this.onGoingPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.onGoingPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.assignedToSupervisor(this.onGoingPaginationInfo.pageNumber);
    }
    caseReview(selectPage: number) {
        this.supervisorReviewStatus = true;
        this.appealStatus = false;
        this.isGroupId = false;
        const pageSource = this.pageStreamOnGoing$.pipe(map((pageNumber) => {
            this.reviewPaginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObjectCaseReview, page: pageNumber };
        }));

        const searchSource = this.searchTermStreamOnGoing$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObjectCaseReview = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);

        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectCaseReview,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((_params: { search: DynamicObject; page: number }) => {
                if (this.assignedCaseForm.value.serreqno === '') {
                    this.assignedSearchCriteria = {
                        serreqno: '',
                        eventcode: 'ASST'
                    };
                } else {
                    this.reviewSearchCriteria = {
                        serreqno: this.assignedCaseForm.value.serreqno,
                        eventcode: 'ASST'
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.reviewPaginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.reviewSearchCriteria
                    }),
                    DashBoard.EndPoint.AssinedCase.CaseReviewUrl + '?filter'
                );
            }),)
            .subscribe((result: any) => {
                this.reviewCases = result.data.result;
                if (this.reviewPaginationInfo.pageNumber === 1) {
                    this.totalRecordsCaseReview = result.data.count;
                }
            });
    }

    getPersonsList() {
        this._commonService.getPagedArrayList(
            {
                page: 1,
                limit: 20,
                method: 'get',
                where: { 'caseid': this.getServicecaseid }
            }, 'Caseassignments/getresponsibilitychild?filter').subscribe((item: any) => {
                this.childList = item;
            });
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
            this.childList.forEach((child: any) => {
                event.value.forEach((value: string) => {
                    if(child.intakeservicerequestactorid == value){
                        child.isselected = user.userid;
                    } else if(child.isselected == user.userid){
                        child.isselected = null;
                    }
                })
            })
        }
        console.info("child", event.value, this.workersList)
    }

    caseReviewPageChanged(pageInfo: any) {
        this.reviewPaginationInfo.pageNumber = pageInfo.page;
        this.reviewPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.reviewPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.caseReview(this.reviewPaginationInfo.pageNumber);
    }
    getRoutingUser(modal: AssignedCase) {
        this.getServicereqid = modal.servicereqid;
        this.zipCode = modal.incidentlocation;
        this.getUsersList = [];
        this.workersList = [];
        this.originalUserList = [];
        this.isGroup = modal.isgroup;
        this.servreqsubtype = modal.servreqsubtype;
        this.getResponsibilityType();
        let appEvent = 'INVR';
        if (this.roleId.role.name === AppConstants.ROLES.KINSHIP_INTAKE_WORKER || this.roleId.role.name === AppConstants.ROLES.KINSHIP_SUPERVISOR) {
            appEvent = 'KINR';
        }
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent },
                    method: 'post'
                }),
                this.getroutingusersurl
            )
            .subscribe((result) => {
                this.getUsersList = result.data;
                this.refreshCounter++;
                if (this.getUsersList.length === 0) {
                    if (this.refreshCounter !== REFRESH_COUNT) {
                        this.getRoutingUser(modal);
                    }
                }
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
            });
    }


    initAssignServiceFormGroup() {
        this.assignServiceCaseForm = this.formBuilder.group({
            programkey: [null, Validators.required],
            subprogramkey: [null, Validators.required]
        });
    }

    getRoutingUserforServiceCase(modal: any) {
        this.serviceCaseDetails = modal;
        this.getServicecaseid = modal.servicecaseid;
        this.getUsersList = [];
        this.originalUserList = [];
        this.workersList = [];
        this.isGroup = modal.isgroup;
        this.servreqsubtype = modal.servreqsubtype;
        this.getResponsibilityType();
        this.getPersonsList();
        const appEvent = 'INVR';
        if(modal.intakedastagingdtls && modal.intakedastagingdtls.length > 0 && modal.intakedastagingdtls[0].intakedastagingdtls.General.PurposeName == "Kinship Navigation") {
            this.disableprogram = true;
        } else {
            this.disableprogram = false;
        }
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent, teamid: this.teamForm.controls['teamid'].value || null },
                    method: 'post'
                }),
                this.getroutingusersurl
            )
            .subscribe((result) => {
                this.getUsersList = result.data;
                this.refreshCounter++;
                if (this.getUsersList.length === 0) {
                    if (this.refreshCounter !== REFRESH_COUNT) {
                        this.getRoutingUserforServiceCase(this.serviceCaseDetails);
                    }
                } else {
                    this.refreshCounter = 0;
                }
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
            });
        if (modal.program && Array.isArray(modal.program) && modal.program.length) {
            this.assignServiceCaseForm.patchValue({ 'programkey': modal.program[0].programkey });
            this.assignServiceCaseForm.patchValue({ 'subprogramkey': modal.subprogram[0].subprogramkey });
        }

        this.loadProgramAreaDropdowns(modal.servicerequesttypekey);
    }
    getResponsibilityType() {
        this._commonService.getArrayList({}, 'responsibilitytype/').subscribe((result) => {
            this.responsibilityTypeDropdownItems$ = result.map(r => {
                return {
                    text: r.typedescription,
                    value: r.responsibilitytypekey
                }
            });

        });
    }
    listUser(assigned: string) {
        this.selectedPerson = '';
        this.getUsersList = [];
        this.mergeUsersList = [];
        this.getUsersList = this.originalUserList;
        if (assigned === 'TOBEASSIGNED') {
            this.getUsersList = this.getUsersList.filter((res) => {
                if (res.issupervisor === false) {
                    this.isSupervisor = false;
                    return res;
                }
            });
            this.getUsersListLoopFn();
        } else {
            this.selectedResponsibilityType = null;
            this.getUsersList = this.getUsersList.filter((res) => {
                if (res.issupervisor === true) {
                    this.isSupervisor = true;
                    return res;
                }
            });

            this.getUsersListLoopFn();
        }
    }
    // Associated with listUser function
    private getUsersListLoopFn() {
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

    selectResponsibilityType(typevalue: any) {
        this.selectedResponsibilityType = typevalue;
    }

    assignServiceCaseUser() {
    if (this.assignServiceCaseForm.invalid) {
        this._alertService.error(
            'Please select Program Area and Program Sub Area.'
        );
        return;
    }

        this.disableassign = true;
        if (this.workersList && this.workersList.length) {
            this.assignServiceCasetoworker();
        } else {
            this.disableassign = false;
            this._alertService.error('Please select a person');
        }
    }
    assignServiceCasetoworker() {
        let responsibility = 0;
        let nochild = false;
        this.workersList.forEach(worker => {
            if (worker.responsibilitytypekey === 'family') {
                responsibility ++
            }
            if (worker.responsibilitytypekey === 'child' && !(worker.child && worker.child.length > 0)) {
                nochild = true;
            }
        });
        if (nochild){
            this.disableassign = false;
            return this._alertService.error('Please select the child.');
        }
        if ( responsibility == 0 ){
            this.disableassign = false;
            this._alertService.error('No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned.');
        }else if ( responsibility > 1 ){
            this.disableassign = false;
            this._alertService.error('No more than one family worker can be assigned to the same case.');
        } else {
            this.assignServiceCaseToUser();
        }
    }
    assignServiceCaseToUser() {
        const model = {
            appeventcode: 'SRVC',
            servicecaseid: this.getServicecaseid,
            assigneduserid: this.selectedPerson.userid,
            programkey: (this.assignServiceCaseForm.get('programkey')?.value) ? this.assignServiceCaseForm.get('programkey')?.value : null,
            subprogramkey: (this.assignServiceCaseForm.get('subprogramkey')?.value) ? this.assignServiceCaseForm.get('subprogramkey')?.value : null,
            assignedusers: this.workersList
        };

        const data = [];
        this.workersList.forEach((item) => {
            if (!item.responsibilitytypekey){
                data.push(item);
            }
            if(item.responsibilityevent) {
                item.responsibilityevent = null;
            }
        });
        if (!data.length) {
            this._commonService
            .create(model,
                'servicecase/assigncase'
            )
            .subscribe((_result) => {
                const activeSenChild = this.serviceCaseDetails.intakedastagingdtls[0].intakedastagingdtls.persons.filter((person: { senstatusflag: number; }) => person?.senstatusflag === 1);
                if(activeSenChild && activeSenChild.length){
                    const cjamspid = activeSenChild[0].cjamspid;
                    const notificationData:any ={}
                    this.handleIfCjamspidFn(cjamspid, notificationData);
                }
                
                this._alertService.success('Service Case assigned successfully!');
                this.getAssignServiceCase(1, 'OPEN');
                this.closeServiceCAsePopup();
               
            });
        } else {
            this.disableassign = false;
            this._alertService.error('Please Fill Responsibility');
        }
    }
    // Assosiated with assignServiceCaseToUser method
    private handleIfCjamspidFn(cjamspid: any, notificationData: any) {
        if (cjamspid) {
            const victimname = this.serviceCaseDetails?.intakedastagingdtls[0]?.intakedastagingdtls?.sdm?.allegedvictim[0]?.victimname ? this.serviceCaseDetails?.intakedastagingdtls[0]?.intakedastagingdtls?.sdm?.allegedvictim[0]?.victimname : '';
            notificationData.isexternalentity = 'false';
            notificationData.subject = `Active Substance Exposed New Born (${victimname} / ${cjamspid}) is added to case ${this.serviceCaseDetails.servicecasenumber}`;
            notificationData.priorityleveltypekey = 'High';
            notificationData.usernotificationtypekey = 'System';
            notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
            notificationData.securityusersid = this._authService.getCurrentUser().user.securityusersid;
            notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
            notificationData.objectcasenumber = this.serviceCaseDetails.servicecasenumber;
            notificationData.objecttype = 'servicecase';
            notificationData.objectid =  this.getServicecaseid;
            notificationData.servicerequestnumber = this.serviceCaseDetails.servicecasenumber;
            notificationData.body = victimname + " is added as a Active Birth Match Client in this Case.";
            this._commonService.create(notificationData, this.usernotificationsGetEndPoint).subscribe((result) => {
                if (result && result.length === 0) {
                    this._commonService.create(notificationData, this.usernotificationsAddEndPoint).subscribe((_result1) => {
                        this.workersList.forEach((data) => {
                            this.createNotificationToWorker(notificationData, data);
                        });
                    });
                }
            });
        }
    }

    createNotificationToWorker(notification: any, data: any){
        const url = this.returnNotificationToWorkerUrlFn(notification);
        this._commonService.getAll(url).subscribe(
            (response) => {
                const dsdsActionsSummary = response[0];
                const familyworker = dsdsActionsSummary.responsibleworkers.find((worker: { responsibilitytypekey: string; }) => worker.responsibilitytypekey === 'family');
                const supervisorId = familyworker.supervisorid;
                notification.insertedby = this._authService.getCurrentUser().user.securityusersid;
                notification.securityusersid = data.userid;
                notification.updatedby = this._authService.getCurrentUser().user.securityusersid;
                this._commonService.create(notification, this.usernotificationsGetEndPoint).subscribe((res) => {
                    if(res && res.length === 0){
                        this._commonService.create(notification, this.usernotificationsAddEndPoint).subscribe((_result) => {
                            notification.insertedby = this._authService.getCurrentUser().user.securityusersid;
                            notification.securityusersid = supervisorId;
                            notification.updatedby = this._authService.getCurrentUser().user.securityusersid;
                            this._commonService.create(notification, this.usernotificationsGetEndPoint).pipe(
                                switchMap(response1 => {
                                    return this.createNotification(response1, notification);
                                }),
                            ).subscribe(() => {
                                data["done"] = true;
                                const allDone = !this.workersList.filter(worker => worker.done).length;
                                if(allDone){
                                    this.workersList = [];
                                }
                            })
                        })
                    }
                })
            },
            _error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                return null;
            }
        );
    }
    private returnNotificationToWorkerUrlFn(notification: any) {
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const servicecaseid = caseInfo?.servicecaseid ? caseInfo.servicecaseid : notification.objectid;
        return CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + servicecaseid + '/casetype';
    }

    createNotification(response1: any, notification: any){
        if (response1.length === 0) {
            return this._commonService.create(notification, this.usernotificationsAddEndPoint);
        } else {
            return EMPTY; // No need to do anything if notification already exists
        }
    }

    closeServiceCAsePopup() {
        this.disableassign = false;
        (<any>$('#intake-servicecaseassign')).modal('hide');
    }


    assignUser() {
        if (this.selectedPerson) {
            if (this.selectedResponsibilityType) {
                this.assignCaseToUser();
            } else {
                this._alertService.warn('Please select Responsibility');
            }
        } else {
            this._alertService.warn('Please select a person');
        }
    }
    assignCaseToUser() {
        let isError = true;
        this.workersList.forEach((item) => {
            if(item.responsibilitytypekey && item.responsibilitytypekey === 'family'){
                isError = false;
            }
        });
        if(isError){
            this._alertService.error("No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned")
            return;
        }
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        appeventcode: 'SRVC',
                        serreqid: this.getServicereqid,
                        assigneduserid: this.selectedPerson.userid,
                        isgroup: this.isGroup,
                        responsibilitytypekey: this.selectedResponsibilityType
                    },
                    method: 'post'
                }),
                'Intakedastagings/routeda'
            )
            .subscribe(() => {
                this._alertService.success('Case assigned successfully!');
                this.getAssignCase(1, 'OPEN');
                this.closePopup();
            });
    }
    closePopup() {
        (<any>$('#intake-caseassign')).modal('hide');
    }

    selectPerson(checkBox: any, row: any) {
        this.selectedPerson = row;
        if (checkBox.checked) {
            const userData = { userid: row.userid, username: row.username };
            this.workersList.push(userData);
        } else {
            this.workersList.forEach(worker => {
                if(worker.userid == row.userid) {
                    this.responsibilityevent = worker.responsibilityevent; 
                }
            });
            this.workersList = this.workersList.filter(worker => worker.userid !== row.userid);
            this.childList.forEach((child: any) => {
                if(child.isselected ==  row.userid) {
                    child.isselected = null;
                }
            });            
            if(this.responsibilityevent) {
                this.responsibilityevent.source.value = null;
            }
        }

    }

    routToCaseWorker(item: AssignedCase) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (this.isGroupId === true) {
            this.serviceRequestId = item.intakeserviceid;
        } else {
            this.serviceRequestId = item.servicecaseid;
        }
        this._session.setTabKeyKey( item.servicecasenumber);
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.intakeserviceid);
        }
        this._commonService.getAll(CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecaseid + '/casetype').subscribe((response) => {
            const dsdsActionsSummary = response[0];
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = '/pages/case-worker/'  + item.servicecaseid + '/' + item.servicecasenumber + '/dsds-action/report-summary';
            this._router.navigateByUrl('/', { skipLocationChange: true }).then(() => this._router.navigate([currentUrl]));
        });
    }

    onSearchAssignCase(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        if (this.appealStatus === true) {
            this.dynamicObjectAppeal[field] = { like: '%25' + value + '%25' };
            if (!value) {
                delete this.dynamicObjectAppeal[field];
            }
            this.searchTermStreamAppeal$.next(this.dynamicObjectAppeal);
        } else if (this.supervisorReviewStatus === true) {
            this.dynamicObjectReviewToSupervisor[field] = { like: '%25' + value + '%25' };
            if (!value) {
                delete this.dynamicObjectReviewToSupervisor[field];
            }
            this.searchTermStreamOnGoing$.next(this.dynamicObjectReviewToSupervisor);
        } else {
            this.dynamicObjectAssignCase[field] = { like: '%25' + value + '%25' };
            if (!value) {
                delete this.dynamicObjectAssignCase[field];
            }
            this.searchTermStreamAssignCase$.next(this.dynamicObjectAssignCase);
        }
    }

    getAssignServiceCase(selectPage: number, assigned: string, stage?: string) {
        if (stage === 'INTIAL') {
            this.assignedCaseForm.patchValue({
                serreqno: ''
            });
            this.assignedCaseForm.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
        }
        this.assingedServiceCaseSummary = [];
        this.assignedStatus = assigned;
        this.appealStatus = false;
        this.supervisorReviewStatus = false;
        this.isGroupId = false;
        const pageSource = this.pageStreamAssgine$.pipe(map((pageNumber) => {
            this.tobeassignedPaginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObjectAssignCase, page: pageNumber };
        }));

        const searchSource = this.searchTermStreamAssignCase$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObjectAssignCase = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);
        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectAssignCase,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((_params: { search: DynamicObject; page: number }) => {
                if (this.assignedCaseForm.value.serreqno === '') {
                    this.assignedSearchCriteria = {
                        servicecaseno: '',
                        status: this.assignedStatus,
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid
                    };
                } else {
                    this.assignedSearchCriteria = {
                        servicecaseno: this.assignedCaseForm.value.serreqno,
                        status: this.assignedStatus,
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'get',
                        where: this.assignedSearchCriteria

                    }),
                    'Intakedastagings/servicecaseassignlist?filter'
                );
            }),)
            .subscribe((result) => {
                this.mergeMapResponseFn(result, assigned);
            });
    }

    initialUpperCase(string: any) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }

    // Associated with getAssignServiceCase function
    private mergeMapResponseFn(result: any, assigned: string) {
        this.assingedCaseSummary = result;
        if (this.assingedCaseSummary && this.assingedCaseSummary.length) {
            this.totalRecordsAssingedCase = result[0].totalcount;
        }
        else{
            this.totalRecordsAssingedCase = 0;
        }
        if (this.assingedCaseSummary) {
            if (assigned === 'OPEN') {
                this.assingedServiceCaseSummary = this.assingedCaseSummary.filter((data: { statustypekey: string; }) =>
                    data.statustypekey === 'OPEN'
                );
            } else {
                this.assingedServiceCaseSummary = this.assingedCaseSummary.filter((data: { statustypekey: string; }) =>
                    data.statustypekey !== 'OPEN'
                );
            }
            this.assingedServiceCaseSummaryLoopFn();
        }
    }
    // Associated with getAssignServiceCase function
    private assingedServiceCaseSummaryLoopFn() {
        this.assingedServiceCaseSummary.forEach(v => {
            if (v.legalguardian && v.legalguardian.length) {
                v.legalguardian = v.legalguardian.map((x: { personname: any; }) => x.personname).join(', ');
            } else {
                v.legalguardian = '';
            }
            if (v.intakedastagingdtls && v.intakedastagingdtls.length > 0) {
                if (v.intakedastagingdtls[0]?.intakedastagingdtls?.General?.intakeservice[0]?.description === 'I&R') {
                    v.subprograms = v.intakedastagingdtls[0].intakedastagingdtls.General.intakeservice[0].description + ' ' + this.initialUpperCase(v.intakedastagingdtls[0].intakedastagingdtls.General.intakeservice[v.intakedastagingdtls[0].intakedastagingdtls.General.intakeservice.length - 1].description);
                } else {
                    v.subprograms = [...new Set(v.intakedastagingdtls[0].intakedastagingdtls?.General?.intakeservice.map((item: { description: any; }) => this.initialUpperCase(item.description)))].map(x => x).join(' ');
                }
            }
        });
    }

    pageServiceCaseAssignedChanged(pageInfo: any) {
        this.tobeassignedPaginationInfo.pageNumber = pageInfo.page;
        this.tobeassignedPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.tobeassignedPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.getAssignServiceCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus);
    }
    formServiceCaseAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: ['']
        });
    }
    onServiceCaseSorted($event: any) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
    }
    routeToCase() {
        this.router.navigate(['../cw-assign-case'], { relativeTo: this.route });
    }
    routeToAdoptionCase() {
        this.router.navigate(['../cw-assign-adoption-case'], { relativeTo: this.route });
    }

    changeResponsibility(event: any, user: any) {
        const isWokerAvailable = this.workersList.find(worker => worker.userid === user.userid);
        if (isWokerAvailable) {
            this.workersList.forEach(worker => {
                if (worker.userid === user.userid) {
                    worker.responsibilitytypekey = event.value;
                    worker.responsibilityevent = event;
                    
                }
            });
            this.childList.forEach((child: any) => {
                if(child.isselected == user.userid) {
                    child.isselected = null;
                }
            })
        } else {
            this._alertService.error('please select the worker');
            event.source.value = null;
        }

    }
    refreshUser() {
        this.getRoutingUserforServiceCase(this.serviceCaseDetails);
    }
}
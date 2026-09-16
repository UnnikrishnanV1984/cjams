
import {startWith, mergeMap, map, debounceTime} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import { Subject ,  Observable, merge } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { AssignedCase, ReviewGridModal, ReviewCase, RoutingUser, Appeal, ChildList } from '../_entities/dashBoard-datamodel';
import { DashBoard } from '../cjams-dashboard-url.config';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { AuthService, AlertService, DataStoreService, GenericService, SessionStorageService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { Assignments } from '../../case-worker/dsds-action/cw-assignments/assignments.data.model';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { PersonInformationComponent } from '../../home-dashboard/person-information/person-information.component';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
const REFERSH_COUNT = 5;
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-assign-case',
    templateUrl: './cw-assign-case.component.html',
    styleUrls: ['./cw-assign-case.component.scss'],
    imports:[SortTableModule,MatSortModule,MatFormFieldModule,MatInputModule,MatSelectModule,MatDatepickerModule,ReactiveFormsModule,MatCheckboxModule,PaginationModule,FormsModule,CommonModule,PersonInformationComponent],
    standalone: true
})
export class CwAssignCaseComponent implements OnInit {
    assignedCaseForm!: FormGroup;
    assignCaseForm!: FormGroup;
    appealForm!: FormGroup;
    selectedPerson: any;
    serviceRequestId!: string;
    mergeUsersList: RoutingUser[] = [];
    assignedStatus!: boolean;
    isSupervisor!: boolean;
    selectedResponsibilityType!: string | null;
    zipCodeIndex!: number;
    appealStatus!: boolean;
    getServicereqid!: string;
    selectedCaseForAssignment!: string;
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
    assingedCaseSummary: any[] = [];
    paginationInfo: PaginationInfo = new PaginationInfo();
    responsibilityTypeDropdownItems!: DropdownModel[];
    reviewToSupervisor!: ReviewGridModal[];
    tobeassignedPaginationInfo: PaginationInfo = new PaginationInfo();
    onGoingPaginationInfo: PaginationInfo = new PaginationInfo();
    reviewCases: ReviewCase[] = [];
    roleId!: AppUser;
    teamList: Array<any> = [];
    private searchTermStreamAppeal$ = new Subject<DynamicObject>();
    private pageStreamAppeal$ = new Subject<number>();
    private pageStreamOnGoing$ = new Subject<number>();
    private searchTermStreamOnGoing$ = new Subject<DynamicObject>();
    private searchTermStreamAssignCase$ = new Subject<DynamicObject>();
    private pageStreamAssgine$ = new Subject<number>();
    private appealIntakeReqId!: string;
    role!: string;
    teamid!: string;
    selectedteamid!: string;
    teamForm!: FormGroup;
    roleList: any;
    seletedUserData!: AssignedCase;
    teamtypekey!: string;
    status!: string | null;
    supervisorList: any[] = [];
    refreshCounter = 0;
    filterOnCompletedTab!: string;
    tabName!: string;
    assignmentsList$!: Observable<Assignments[]>;
    assignmentListData: any;
    workersList: any[] = [];
    childList!: ChildList[];
    programArea!: any[];
    programSubArea!: any[];
    responsibilityevent: any;
    private _commonService: CommonHttpService;
    private formBuilder: FormBuilder;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private _intakeUtils: IntakeUtils;
    private _appealService: GenericService<Appeal>;
    private _alertService: AlertService;
    private route: ActivatedRoute;
    private _session: SessionStorageService;
    private router: Router;
    disableassign: boolean = false;
    constructor(private injector : Injector) {
        this._commonService= this.injector.get<CommonHttpService>(CommonHttpService);
        this.formBuilder= this.injector.get<FormBuilder>(FormBuilder);
        this._authService= this.injector.get<AuthService>(AuthService);
        this._dataStoreService= this.injector.get<DataStoreService>(DataStoreService);
        this._intakeUtils= this.injector.get<IntakeUtils>(IntakeUtils);
        this._appealService= this.injector.get<GenericService<Appeal>>(GenericService);
        this._alertService= this.injector.get<AlertService>(AlertService);
        this.route= this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.router= this.injector.get<Router>(Router);
        this._session= this.injector.get<SessionStorageService>(SessionStorageService);
     }
    getroutingusersurl = 'Intakedastagings/getroutingusers';
    ngOnInit() {
        this.teamtypekey = this._authService.getCurrentUser().role.teamtypekey;
        this.getTeamList();
        this.roleList = AppConstants.ROLES;
        this.roleId = this._authService.getCurrentUser();
        const tma = this.roleId.user.userprofile.teammemberassignment;
        const assignments = Array.isArray(tma) ? tma : [tma];
        this.teamid = assignments[0]?.teammember?.teamid; 
        this.selectedteamid = this.teamid;
        this.role = this._authService.getCurrentUser().role.name;
        this.paginationInfo.sortColumn = 'reporteddate';
        this.paginationInfo.sortBy = 'desc';
        this.formAssignInitilize();
        this.loadSupervisor();
        this.getAssignCase(1, false, this.status);
        this.appealFormInitialize();
        this.appealForm.get('dispositioncode')?.valueChanges.subscribe((result) => {
            if (result === 'ScreenOUT') {
                this.appealForm.patchValue({ dispositioncode: '' });
                this._alertService.error('Screen out can not be selected');
            }
        });
        this.teamForm.controls['teamid'].setValue(this.selectedteamid);
        this.filterOnCompletedTab = 'all';
    }


    calculatedays(recieveddate: any) {
        var servicedays = 0;
        if(recieveddate !== null ){
            const date2 = new Date(recieveddate);
            const date1 = new Date();
            const diff = Math.abs(date1.getTime() - date2.getTime());
            servicedays = Math.ceil(diff / (1000 * 3600 * 24));
        }
        return  servicedays;
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
        }, 'manage/team/getteamlist?filter').subscribe((items) => {
            this.teamList = items.map( item  => item);

         });
    }
    teamChange() {
        this.selectedteamid = this.teamForm.controls['teamid'].value;
        this.getRoutingUser(this.seletedUserData);
    }
    onClose() {
        this.selectedteamid = this.teamid; // reset
        this.teamForm.controls['teamid'].setValue(this.selectedteamid);
    }
    appealFormInitialize() {
        this.appealForm = this.formBuilder.group({
            appealdate: ['', [Validators.required]],
            dispositioncode: ['', [Validators.required]],
            remarks: ['', [Validators.required]]
        });
    }
    getAssignCase(selectPage: number, assigned: boolean, status?: any, stage?: string, tabname?: string) {
        if (status === 'Closed' || status === 'Completed') {
            this.status = status;
        } else {
            this.status = null;
        }
        if (stage === 'Intial') {
            this.assignedCaseForm.patchValue({
                serreqno: ''
            });
            this.assignedCaseForm.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
        }
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
                        sortorder: this.paginationInfo.sortBy,
                        status: this.status,
                        securityusersid: this.returnSecurityusersidFn(),
                        filter: this.filterOnCompletedTab
                    };
                } else {
                    this.assignedSearchCriteria = {
                        serreqno: this.assignedCaseForm.value.serreqno,
                        assigned: this.assignedStatus,
                        sortcolumn: 'reporteddate', sortorder: 'desc',
                        status: this.status,
                        securityusersid: this.returnSecurityusersidFn(),
                        filter: this.filterOnCompletedTab
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
                if(!tabname || tabname == this.tabName) {
                    this.assingedCaseSummary = result.data.filter( x => {
                        return !( 
                        (x.servreqtype === 'CHILD' && x.servreqsubtype === 'Default') ||
                        (x.servreqtype === 'Request for services')
                        )}
                    );
                    if (this.paginationInfo.pageNumber === 1) {
                        this.assingedCaseSummary = result.data;
                        this.totalRecordsAssingedCase = result.count;
                    }
                }
            });
    }
    // Associated with getAssignCase function
    private returnSecurityusersidFn() {
        return (this.assignedCaseForm.value.securityusersid === '') ? this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid;
    }

    pageAssignedChanged(pageInfo: any) {
        this.tobeassignedPaginationInfo.pageNumber = pageInfo.page;
        this.tobeassignedPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.tobeassignedPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.getAssignCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus, this.status);
    }
    formAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: [''],
            securityusersid: ['']
        });
        this.teamForm = this.formBuilder.group({
            teamid: ['']
        });
        this.assignCaseForm = this.formBuilder.group({
            programkey: [null],
            subprogramkey: [null]
        });
    }
    onSorted($event: any) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.getAssignCase(this.paginationInfo.pageNumber, this.assignedStatus, this.status);
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
    supervisorChange() {
        this.getAssignCase(1, this.assignedStatus, this.status);
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
        this.seletedUserData = modal;
        this.getServicereqid = modal.servicereqid;
        this.selectedCaseForAssignment = modal.servicerequestnumber;
        this.zipCode = modal.incidentlocation;
        this.getUsersList = [];
        this.originalUserList = [];
        this.workersList = [];
        this.isGroup = modal.isgroup;
        this.servreqsubtype = modal.servreqsubtype;
        this.getResponsibilityType();
        this.getAssignmentsList();
        this.getPersonsList(modal.servicereqid);
        let appEvent = 'INVR';
        if (this.roleId.role.name === AppConstants.ROLES.KINSHIP_INTAKE_WORKER || this.roleId.role.name === AppConstants.ROLES.KINSHIP_SUPERVISOR) {
            appEvent = 'KINR';
        }
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent , teamid: this.selectedteamid || null},
                    method: 'post'
                }),
                this.getroutingusersurl
            )
            .subscribe((result) => {
                this.getUsersList = result.data;
                this.refreshCounter++;
                if (this.getUsersList.length === 0) {
                    if (this.refreshCounter !== REFERSH_COUNT) {
                        this.getRoutingUser(this.seletedUserData);
                    }
                } else {
                    this.refreshCounter = 0;
                }
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
            });
            if (modal.servreqsubtype) {
                const programkey = modal.servreqsubtype.split('-')[0]; 
                const subprogramkey = modal.servreqsubtype.split('-')[1];
                this.assignCaseForm.patchValue({ 'programkey': programkey });
                this.assignCaseForm.patchValue({ 'subprogramkey': subprogramkey });
            }
    
            this.loadProgramAreaDropdowns('');
    }
    getAppealRoutingUser(modal: AssignedCase) {
        this.seletedUserData = modal;
        this.getServicereqid = modal.servicereqid;
        this.selectedCaseForAssignment = modal.servicerequestnumber;
        this.zipCode = modal.incidentlocation;
        this.getUsersList = [];
        this.originalUserList = [];
        this.isGroup = modal.isgroup;
        this.servreqsubtype = modal.servreqsubtype;
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'APPL' , teamid: this.selectedteamid || null},
                    method: 'post'
                }),
                this.getroutingusersurl
            )
            .subscribe((result) => {
                this.getUsersList = result.data;
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
            });
    }
    getResponsibilityType() {
        this._commonService.getArrayList({}, 'responsibilitytype/').pipe(map((result) => {
            return result.map(
                (res) =>
                    new DropdownModel({
                        text: res.typedescription,
                        value: res.responsibilitytypekey
                    })
            );
        })).subscribe(result => {
            this.responsibilityTypeDropdownItems = result;
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

    assignUser() {
        this.disableassign = true;
        this.assignCaseToUser();
        this.onClose();
    }
    assignCaseToUser() {
        let responsibility = 0;
        let nochild = false;
        this.workersList.forEach((item) => {
            if(item.responsibilitytypekey === 'family'){
                responsibility ++
            }
            if (item.responsibilitytypekey === 'child' && !(item.child && item.child.length > 0) ) {
                nochild = true;
            }
            if(item.responsibilityevent) {
                item.responsibilityevent = null;
            }
        });
        if(nochild) {
            this.disableassign = false;
            return this._alertService.error('Please select the child.');
        }
        if(responsibility == 0){
            this.disableassign = false;
            this._alertService.error("No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned.")
        } else if (responsibility > 1 ){
            this.disableassign = false;
            this._alertService.error('No more than one family worker can be assigned to the same case.');
        } else {
            this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        appeventcode: 'INVT',
                        serreqid: this.getServicereqid,
                        assigneduserid: this.selectedPerson.userid,
                        isgroup: this.isGroup,
                        assignedusers: this.workersList,
                    },
                    method: 'post'
                }),
                'Intakedastagings/routeda'
            )
            .subscribe((_result) => {
                this._alertService.success('Case assigned successfully!');
                // Check if the assigned case was restricted, if yes then give access to the assigned worker also
                this.checkAndAssignRestrictedCase();
                this.getAssignCase(1, false, this.status);
                this.closePopup();
            });
        }
    }

    assignAppealUser() {
        if (this.selectedPerson) {
            this.assignCaseToAppealUser();
        } else {
            this._alertService.warn('Please select a person');
        }
        this.onClose();
    }

    assignCaseToAppealUser() {
        this._commonService
            .create(
                   {
                        objectid:  this.getServicereqid,
                        intakeserviceid:  this.getServicereqid,
                        eventcode: 'APPL',
                        status: 'Review',
                        comments: '',
                        notifymsg: 'Appeal Review',
                        tosecurityusersid: this.selectedPerson.userid,
                        routeddescription: 'Appeal Review'
                    }, 'routing/routingupdate'
            ).subscribe((_result) => {
                this._alertService.success('Case assigned successfully!');
                // Check if the assigned case was restricted, if yes then give access to the assigned worker also
                this.checkAndAssignRestrictedCase();
                this.getAssignCase(1, true, this.status);
                this.closePopup();
            });
    }

    closePopup() {
        this.disableassign = false;
        $('#intake-caseassign').modal('hide');
        $('#intake-caseassign-completed').modal('hide');
    }
    getPersonsList(caseId: any) {
        this._commonService.getPagedArrayList(
            {
                page: 1,
                limit: 20,
                method: 'get',
                where: { 'caseid': caseId }
            }, 'Caseassignments/getresponsibilitychild?filter').subscribe((item: any) => {
                this.childList = item;
            });
    }
    selectPersonForAssign(checkBox: any, row: any) {
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
    isChildResponsibilityTypeSelected(user: any){
        const responsibilitytypekey = this.workersList.filter(worker => worker.userid === user.userid);
        if(responsibilitytypekey.length){
            if(responsibilitytypekey[0].responsibilitytypekey && responsibilitytypekey[0].responsibilitytypekey === 'child'){
                return true;
            }
        }
        return false;
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
    }

    selectPerson(row: any) {
        this.selectedPerson = row;
    }
    getAppeal(selectPage: number, appealStatus: boolean) {
        this.assignedCaseForm.patchValue({
            serreqno: ''
        });
        this.appealStatus = appealStatus;
        this.supervisorReviewStatus = false;
        this.isGroupId = false;
        const pageSource = this.pageStreamAppeal$.pipe(map((pageNumber) => {
            this.appealPaginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObjectAppeal, page: pageNumber };
        }));

        const searchSource = this.searchTermStreamAppeal$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObjectAppeal = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);

        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectAppeal,
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
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.assignedSearchCriteria
                    }),
                    'Intakedastagings/getappealda'
                );
            }),)
            .subscribe((result) => {
                this.assingedCaseSummary = result.data;
                if (this.paginationInfo.pageNumber === 1) {
                    this.totalRecordsAssingedCase = result.count;
                }
            });
    }
    appealPageChanged(pageInfo: any) {
        this.appealPaginationInfo.pageNumber = pageInfo.page;
        this.appealPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.appealPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.getAppeal(this.appealPaginationInfo.pageNumber, this.appealStatus);
    }
    routToCaseWorker(item: any) {
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (this.isGroupId === true) {
            this.serviceRequestId = item.intakeserviceid;
        } else {
            this.serviceRequestId = item.servicereqid;
        }
        const daNumber = item.servicerequestnumber.split('(');
        const danumbertrim = daNumber[0].trim()
        this._commonService.getById(daNumber[0], CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            if(response.length > 0) {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            }
            const currentUrl = '#/pages/case-worker/' + this.serviceRequestId + '/' + danumbertrim + '/dsds-action/report-summary';
            window.open(currentUrl);
        });
    }
    openAppeal(modal: any) {
        this.appealIntakeReqId = modal.servicereqid;
        this.statusDropdownItems$ = this._commonService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        intakeserviceid: '7da1e14f-6714-4cc4-b2ef-ae8d9af53959',
                        statuskey: 'Approved'
                    },
                    method: 'get'
                }),
                'daconfig/servicerequesttypeconfigdispositioncode/getdispositionlist?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.dispositioncode
                        })
                );
            }));
    }
    saveAppeal() {
        const appeal = this.appealForm.value;
        appeal.intakeserviceid = this.appealIntakeReqId;
        appeal.status = 'Approved';
        this._appealService.create(appeal).subscribe(
            (_result: any) => {
                this._alertService.success('Your intake has been appealed successfully.');
                $('#case-appeal').click();
                this.appealForm.reset();
                this.getAppeal(1, true);
                $('#appeal-modal').modal('hide');
            },
            (_err: any) => {
                this._alertService.success('Unable to appeal your intake. Please try again!');
            }
        );
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
    routeToServiceCase () {
        this.router.navigate(['../cw-assign-service-case'], { relativeTo: this.route });
        }


    routeToAdoptionCase () {
        this.router.navigate(['../cw-assign-adoption-case'], { relativeTo: this.route });
        }

    /**
     * Restricted case logic
     * If the just assigned case was restricted then 
     * the assigned case worker will be given access as well
     */
    checkAndAssignRestrictedCase() {
        let activeflag = 0 ;
        const selectedcaseworkerid: any[] = [];
        selectedcaseworkerid.push(this.selectedPerson.userid);
        this._intakeUtils.isRestrictedItem(this.getServicereqid)
        .subscribe(
            (response) => {
                if (response.length > 0) {
                    activeflag = 1;
                    // Means it's in restricted items list
                    this._intakeUtils.createRestrictedItem(this.getServicereqid, 'SERVICE', selectedcaseworkerid, activeflag)
                    .subscribe(
                        (_response1) => {
                            $('#restrict-item-assign-ack').modal('show');
                        }
                    )
                }
            }
        );
    }

    refreshUser() {
        this.refreshCounter = 0;
        this.getRoutingUser(this.seletedUserData);
        
    }

    tabInfo(onToBeAssignedTabFlag: any, tabName: any){
        this.tabName = tabName;
        if(onToBeAssignedTabFlag){
            this.paginationInfo.sortColumn = 'reporteddate';
            this.paginationInfo.sortBy = 'desc';
        }
        else{
            this.paginationInfo.sortColumn = 'assigneddate';
            this.paginationInfo.sortBy = 'desc';
        }

    }

    checkIfAllIFRO(finalFindings:any){
        //Checking if any case has all investigation findings with final findings as ruled out. These cases cannot be appealed(D-24116)
        let result = false;
        if(Array.isArray(finalFindings) && finalFindings.length){
            if(finalFindings.filter(finding => finding.investigationfindingtypekey).length ===
            finalFindings.filter(finding => finding.investigationfindingtypekey === 'RO').length){
                result = true;}
        }
        return result;
    }

        getAssignmentsList() {
        this.assignmentsList$ = this._commonService.getArrayList(
            {
                where: { servicecaseid: this.getServicereqid },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        );
        this.assignmentsList$.subscribe(data => {
            if (data) {
                this.assignmentListData = data;
            }
        });
    }

    groupShow(groupIndex: any, item: any) {
        // No data or function to call
    }
}

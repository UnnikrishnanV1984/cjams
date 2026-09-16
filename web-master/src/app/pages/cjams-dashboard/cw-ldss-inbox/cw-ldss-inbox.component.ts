
import {mergeMap, map, debounceTime, startWith} from 'rxjs/operators';

import { Component, OnInit  } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Subject, Observable, merge } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { ReviewGridModal, ReviewCase, RoutingUser } from '../_entities/dashBoard-datamodel';
import { DashBoard } from '../cjams-dashboard-url.config';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { AuthService, AlertService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-ldss-inbox',
    templateUrl: './cw-ldss-inbox.component.html',
    styleUrls: ['./cw-ldss-inbox.component.scss'],
    imports:[SortTableModule,MatSortModule,MatSelectModule,MatCheckboxModule,ReactiveFormsModule,PaginationModule,FormsModule,CommonModule],
    standalone: true
})
export class CwLdssInboxComponent implements OnInit {
    assignedCaseForm!: FormGroup;
    assignServiceCaseForm!: FormGroup;
    teamForm!: FormGroup;
    selectedPerson: any;
    selectedPersonIR: any;
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
    assingedServiceCaseSummary: any[] = [];
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
    responsibilityTypeDropdownItems: any[] = [];
    responsibilityTypeDropdownItems$!: Observable<any[]>;
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
    programArea: any[] = [];
    workersList: any[] = [];
    programSubArea: any[] = [];
    teamtypekey!: string;
    teamid!: string;
    teamList: Array<any> = [];
    serviceCaseDetails: any;
    departmentList: Array<any>  = [];
    caseType$!: Observable<DropdownModel[]>;
    ldssSearchForm!: FormGroup;
    cpsIRServicecaseid: any;
    childList$!: Observable<any[]>;
    constructor(
        private _commonService: CommonHttpService,
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _dataStoreService: DataStoreService,
        private _alertService: AlertService,
        private _session: SessionStorageService
    ) { }

    ngOnInit() {
        this.formAssignInitilize();
        this.teamtypekey = this._authService.getCurrentUser().role.teamtypekey;
        this.getTeamList();
        this.getAssignServiceCase(1, null, 'startdate', 'desc');
        this.getCountyList();
        this.getCaseTypeList();
        this.roleList = AppConstants.ROLES;
        this.statusDesc = { 'OPEN': 'OPEN', 'ASSGN': 'ASSIGNED' };
        this.roleId = this._authService.getCurrentUser();
        const tma = this.roleId.user.userprofile.teammemberassignment;
        const assignments = Array.isArray(tma) ? tma : [tma];
        this.teamid = assignments[0]?.teammember?.teamid;
        this.role = this._authService.getCurrentUser().role.name;
        this.paginationInfo.pageSize = 10;
        this.tobeassignedPaginationInfo.pageSize = 10;
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
                }
            });
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
            mergeMap((params: { search: DynamicObject; page: number }) => {
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
            });
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
        this.getRoutingUsers(this.serviceCaseDetails);
    }
    getCountyList() {
        this._commonService.create({ where: {},
          order: 'countyname',
          nolimit: true,
        }, 'admin/county/countylist').subscribe((item) => {
          this.departmentList = item;
        });
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
            serreqno: ['']
        });
        this.teamForm = this.formBuilder.group({
            teamid: ['']
        });
        this.ldssSearchForm = this.formBuilder.group({
            servicecasenumber: [''],
            statuscode: ['pending'],
            casetype: [''],
            localdepartment: [''],
            localdeptid: ['']
        });
    }
    onSorted($event: any) {
        this.getAssignServiceCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus, $event.sortDirection, $event.sortColumn);
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
            mergeMap((params: { search: DynamicObject; page: number }) => {
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
    
    getRoutingUser(modal: any) {
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
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.setUsersList(result);
            });
            if (modal.program && Array.isArray(modal.program) && modal.program.length) {
                this.assignServiceCaseForm.patchValue({ 'programkey': modal.program[0].programkey });
                this.assignServiceCaseForm.patchValue({ 'subprogramkey': modal.subprogram[0].subprogramkey });
            }
    }

    setUsersList(result: any){
        this.getUsersList = result.data;
        this.originalUserList = this.getUsersList;
        this.listUser('TOBEASSIGNED');
    }

    initAssignServiceFormGroup() {
        this.assignServiceCaseForm = this.formBuilder.group({
            programkey: [null],
            subprogramkey: [null]
        });
    }

    getRoutingUsers(modal: any) {
        this.serviceCaseDetails = modal;
        this.getServicecaseid = modal.servicecaseid;
        this.cpsIRServicecaseid = modal.servicecaseid;
        this.getUsersList = [];
        this.originalUserList = [];
        this.workersList = [];
        this.isGroup = modal.isgroup;
        this.servreqsubtype = modal.servreqsubtype;
        this.getResponsibilityType();
        const appEvent = 'INVR';
        this.getPersonsList(modal.servicecaseid);
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent, teamid: this.teamForm.controls['teamid'].value || null },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.setUsersList(result);
            });
        if (modal.program && Array.isArray(modal.program) && modal.program.length) {
            this.assignServiceCaseForm.patchValue({ 'programkey': modal.program[0].programkey });
            this.assignServiceCaseForm.patchValue({ 'subprogramkey': modal.subprogram[0].subprogramkey });
        }

        this.loadProgramAreaDropdowns(modal.servicerequesttypekey);
    }
    getResponsibilityType() {
        this._commonService.getArrayList({}, 'responsibilitytype/').subscribe((result) => {
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

    assignServiceCaseUser() {
        if (this.workersList) {

            this.assignServiceCaseToUser();

        } else {
            this._alertService.warn('Please select a person');
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
            if (!item.responsibilitytypekey) {
                data.push(item);
            }
        });
        if (!data.length) {
            this._commonService
            .create(model,
                'servicecase/assigncase'
            )
            .subscribe((result) => {
                this._alertService.success('Service Case assigned successfully!');
                this.getAssignServiceCase(1, 'OPEN');
                this.closeServiceCAsePopup();
            });
        } else {
            this._alertService.error('Please Fill Responsibility');
        }
    }

    closeServiceCAsePopup() {
        (<any>$('#intake-servicecaseassign')).modal('hide');
    }


    assignUser() {
        if (this.selectedPersonIR) {
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
                        appeventcode: 'INVT',
                        serreqid: this.cpsIRServicecaseid,
                        assigneduserid: this.selectedPersonIR.userid,
                        isgroup: this.isGroup || false,
                        responsibilitytypekey: this.selectedResponsibilityType
                    },
                    method: 'post'
                }),
                'Intakedastagings/routeda'
            )
            .subscribe(() => {
                this._alertService.success('Case assigned successfully!');
                this.getAssignServiceCase(1, null, 'startdate', 'desc');
                this.closePopup();
            });
    }
    closePopup() {
        (<any>$('#intake-caseassign')).modal('hide');
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
    selectPerson(checkBox: any, row: any) {
        this.selectedPerson = row;
        if (checkBox.checked) {
            const userData = { userid: row.userid, username: row.username };
            this.workersList.push(userData);
        } else {
            this.workersList = this.workersList.filter(worker => worker.userid !== row.userid);
        }

    }
    irCasePersonSelete(Modal: any) {
        this.selectedPersonIR = Modal;
    }

    routToCaseWorker(item: any) {
        if (item.casetype.toLowerCase() === 'servicecase') {
            this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
          } else {
            this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, false);
            this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
          }
          if (this.isGroupId === true) {
            this.serviceRequestId = item.intakeserviceid;
        } else {
            this.serviceRequestId = item.servicecaseid;
        }
        if (item.casetype.toLowerCase() ===  'adoptioncase') {
            this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
            this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
            this._session.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.startdate);
            this._session.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        }
        const daNumber = item.servicecasenumber.split(' ');
        this._commonService.getAll(CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecaseid + '/casetype').subscribe((response) => {
            const dsdsActionsSummary = response[0];
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            let currentUrl = '';
            if (item.casetype.toLowerCase() ===  'adoptioncase') {
                 currentUrl = '#/pages/case-worker/' + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/adoption-persons';
            } else {
                currentUrl = '#/pages/case-worker/' + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/person-cw';
            }
            window.open(currentUrl);
        });
    }

    getAssignServiceCase(selectPage: number, assigned: any, sortBy?: string, sortColumn?: string) {
        this.assignedSearchCriteria = Object.assign({
            servicecaseno: this.assignedCaseForm.value.serreqno,
            status: this.assignedStatus,
            sortcolumn: sortColumn,
            sortorder: sortBy
        }, this.ldssSearchForm.value);
        this.assingedServiceCaseSummary = [];
        this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'get',
                        where: this.assignedSearchCriteria

                    }),
                    'Intakedastagings/getldsscasetransferlist?filter'
                ).subscribe((result) => {
                this.assingedCaseSummary = result;
                this.assingedServiceCaseSummary = result['data'];
                this.totalRecordsAssingedCase = result['count'];
                this.assingedServiceCaseSummary.forEach(v => {
                    if (v.legalguardian && v.legalguardian.length) {
                      v.legalguardian = v.legalguardian.map((x: any) => x.personname).join(', ');
                    } else {
                      v.legalguardian = '';
                    }
                  });
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
    onServiceCaseSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
    }
    getdepartmentlist() {
        this._commonService.getPagedArrayList(new PaginationRequest({
          where: { activeflag: 1, teamtypekey: 'LDSS' },
          method: 'get', nolimit: true
        }), 'manage/team/list?filter').subscribe((result) => {
          this.departmentList = result.data;
        });
    }
    getCaseTypeList() {
        this.caseType$ = this._commonService.getArrayList({
          where: { referencetypeid: '752', teamtypekey: 'CW'},
          method: 'get'
        }, 'referencetype/gettypes?filter').pipe(map((item) => {
          return item.map((res) =>
          new DropdownModel({
            text: res.description,
            value: res.value_text
          }));
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
}




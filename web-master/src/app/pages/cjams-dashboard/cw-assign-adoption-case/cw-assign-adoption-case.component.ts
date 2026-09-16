
import {mergeMap, startWith, map, debounceTime} from 'rxjs/operators';

import { Component, OnInit, Injector } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { Subject ,  Observable, merge } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { AssignedCase, ReviewGridModal, ReviewCase, RoutingUser } from '../_entities/dashBoard-datamodel';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { AuthService, AlertService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatSelectModule } from '@angular/material/select';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-assign-adoption-case',
    templateUrl: './cw-assign-adoption-case.component.html',
    styleUrls: ['./cw-assign-adoption-case.component.scss'],
    imports:[SortTableModule,MatSortModule,MatCheckboxModule,MatSelectModule,ReactiveFormsModule,PaginationModule,FormsModule,CommonModule],
    standalone: true
})
export class CwAssignAdoptionCaseComponent implements OnInit {
    assignedCaseForm!: FormGroup;
    assignAdoptionCaseForm!: FormGroup;
    teamForm!: FormGroup;
    selectedPerson: any;
    adoptionRequestId!: string;
    mergeUsersList: RoutingUser[] = [];
    assignedStatus!: string;
    isSupervisor!: boolean;
    zipCodeIndex!: number;
    getadoptionreqid!: string;
    getadoptioncaseid!: string;
    assingedAdoptionCaseSummary: any[] = [];
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
    dynamicObjectAssignCase: DynamicObject = {};
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
    workersList: any[] = [];
    teamtypekey!: string;
    teamid!: string;
    teamList: Array<any> = [];
    adoptionCaseDetails: any;
    supervisorList: any[] = [];

    private _commonService: CommonHttpService;
    private formBuilder: FormBuilder;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private _alertService: AlertService;
    private route: ActivatedRoute;
    private router: Router;
    private _session: SessionStorageService;

    constructor(private injector:Injector){
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.router = this.injector.get<Router>(Router);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
     }

    ngOnInit() {
        this.teamtypekey = this._authService.getCurrentUser().role.teamtypekey;
        this.getTeamList();
        this.roleList = AppConstants.ROLES;
        this.roleId = this._authService.getCurrentUser();
        const tma = this.roleId.user.userprofile.teammemberassignment;
        const assignments = Array.isArray(tma) ? tma : [tma];
        this.teamid = assignments[0]?.teammember?.teamid; 
        this.role = this._authService.getCurrentUser().role.name;
        this.paginationInfo.sortColumn = 'updatedon';
        this.paginationInfo.sortBy = 'desc';
        this.paginationInfo.pageSize = 10;
        this.tobeassignedPaginationInfo.pageSize = 10;
        this.formAssignInitilize();
        this.loadSupervisor();
        this.getAssignAdoptionCase(1, 'TBA');
        this.teamForm.controls['teamid'].patchValue(this.teamid);
    }

    private loadSupervisor() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTR' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.supervisorList = result['data'];
                this.assignedCaseForm.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
            });
    }
    supervisorChange() {
        this.getAssignAdoptionCase(1, this.assignedStatus);
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
        this.getRoutingUserforAdoptionCase(this.adoptionCaseDetails);
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
        this.getAssignAdoptionCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus);
    }


    getRoutingUserforAdoptionCase(modal: any) {
        this.adoptionCaseDetails = modal;
        this.getadoptioncaseid = modal.adoptioncaseid;
        this.getUsersList = [];
        this.originalUserList = [];
        const appEvent = 'ADPC';
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent, teamid: this.teamForm.controls['teamid'].value || null },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.getUsersList = result.data;
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
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

    assignAdoptionCaseUser() {
        if (this.workersList && this.workersList.length) {
                this.assignAdoptionCaseToUser();
        } else {
            this._alertService.warn('Please select a person');
        }
    }
    assignAdoptionCaseToUser() {
        const model = {
            appeventcode: 'ADPC',
            adoptioncaseid: this.getadoptioncaseid,
            assignedusers: this.workersList
        };
        this._commonService
        .create(model,
            'adoptioncase/assigncase'
        )
        .subscribe((result) => {
            this._alertService.success('Adoption Case assigned successfully!');
            this.getAssignAdoptionCase(1, 'TBA');
            this.closeAdoptionCAsePopup();
            this.workersList = [];
        });
    }

    closeAdoptionCAsePopup() {
        $('#intake-adoptioncaseassign').modal('hide');
    }
    selectPerson(checkBox: any, row: any) {
        if (checkBox.checked) {
            const userData = { userid: row.userid, username: row.username };
            this.workersList.push(userData);
        } else {
            this.workersList = this.workersList.filter(worker => worker.userid !== row.userid);
        }

    }

    routToCaseWorker(item: AssignedCase) {
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
        this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
        this._session.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.startdate);
        this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
        this._session.setItem(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        }
        
        this._commonService.getById(item.adoptioncasenumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);

                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                // To be developed : DEB As discussed with management we are parking this link but we are working on separate branch after extensive testing this will
                // be available for user
                if (item.statustypekey === 'Closed') {
                    const currentUrl = '#/pages/case-worker/' + item.adoptioncaseid + '/' + item.adoptioncasenumber + '/dsds-action/disposition';
                    window.open(currentUrl);
                } else {
                    const currentUrl = '#/pages/case-worker/' + item.adoptioncaseid + '/' + item.adoptioncasenumber + '/dsds-action/adoption-persons';
                    window.open(currentUrl);
                }
            }
        });
    }

    onSearchAssignCase(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObjectAssignCase[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObjectAssignCase[field];
        }
        this.searchTermStreamAssignCase$.next(this.dynamicObjectAssignCase);
    }
    getAssignAdoptionCase(selectPage: number, assigned: string, stage?: string) {
        if (stage === 'INTIAL') {
            this.assignedCaseForm.patchValue({
                serreqno: ''
            });
            this.assignedCaseForm.controls['securityusersid'].patchValue(this.roleId.user.userprofile.securityusersid);
        }
        this.assingedAdoptionCaseSummary = [];
        this.totalRecordsAssingedCase = 0;
        this.assignedStatus = assigned;
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
                if (this.assignedCaseForm.value.serreqno === '' || this.assignedCaseForm.value.serreqno === ' ' || this.assignedCaseForm.value.serreqno == null ) {
                    this.assignedSearchCriteria = {
                        adoptioncasenumber: '',
                        status: this.assignedStatus,
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid
                      
                    };
                } else {
                    this.assignedSearchCriteria = {
                        adoptioncasenumber: this.assignedCaseForm.value.serreqno,
                        status: this.assignedStatus,
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.tobeassignedPaginationInfo.pageSize,
                        page: selectPage,
                        method: 'get',
                        where: this.assignedSearchCriteria

                    }),
                    'Intakedastagings/adoptioncaseassignlist?filter'
                );
            }),)
            .subscribe((result) => {
                this.mergeMapResponseFn(result, assigned);
            });
    }

    // Associated with getAssignAdoptionCase function
    private mergeMapResponseFn(result: any, assigned: string) {
        this.assingedCaseSummary = result;
        if (this.assingedCaseSummary && this.assingedCaseSummary.length) {
            this.totalRecordsAssingedCase = result[0].totalcount;
        }
        if (this.assingedCaseSummary) {
            if (assigned === 'TBA') {
                this.assingedAdoptionCaseSummary = this.assingedCaseSummary.filter((data: { statustypekey: string; }) => data.statustypekey === 'TBA'
                );
            } else {
                this.assingedAdoptionCaseSummary = this.assingedCaseSummary.filter((data: { statustypekey: string; }) => data.statustypekey !== 'TBA'
                );
            }
        }
    }

    //imp
    pageAdoptionCaseAssignedChanged(pageInfo: any) {
        this.tobeassignedPaginationInfo.pageNumber = pageInfo.page;
        this.tobeassignedPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.tobeassignedPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.getAssignAdoptionCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus);
    }
    formAdoptionCaseAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: ['']
        });
    }
    onAdoptionCaseSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
    }
    routeToCase() {
        this.router.navigate(['../cw-assign-case'], { relativeTo: this.route });
    }

    routeToServiceCase () {
        this.router.navigate(['../cw-assign-service-case'], { relativeTo: this.route });
        }

}



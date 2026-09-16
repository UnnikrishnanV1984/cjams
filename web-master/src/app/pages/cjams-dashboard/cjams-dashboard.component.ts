
import {mergeMap, map, startWith, debounceTime} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable, Subject, merge } from 'rxjs';

import { DropdownModel, DynamicObject, PaginationInfo, PaginationRequest } from '../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, GenericService } from '../../@core/services';
import { AlertService } from '../../@core/services/alert.service';
import { AuthService } from '../../@core/services/auth.service';
import { ColumnSortedEvent } from '../../shared/modules/sortable-table/sort.service';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import { Appeal, AssignedCase, BroadCostMessage, IntakeSummary, PreIntakeAssign, RoutingUser, ReviewGridModal, ReviewCase, Prior } from './_entities/dashBoard-datamodel';
import { DashBoard } from './cjams-dashboard-url.config';
import { IntakeUtils } from '../_utils/intake-utils.service';
import { AppUser } from '../../@core/entities/authDataModel';
import { AppConstants } from '../../@core/common/constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cjams-dashboard',
    templateUrl: './cjams-dashboard.component.html',
    styleUrls: ['./cjams-dashboard.component.scss'],
    standalone: false
})
export class CjamsDashboardComponent implements OnInit {
    intakeSummaryForm!: FormGroup;
    assignedCaseForm!: FormGroup;
    appealForm!: FormGroup;
    preIntakeForm!: FormGroup;
    paginationInfo: PaginationInfo = new PaginationInfo();
    tobeassignedPaginationInfo: PaginationInfo = new PaginationInfo();
    appealPaginationInfo: PaginationInfo = new PaginationInfo();
    preIntakePaginationInfo: PaginationInfo = new PaginationInfo();
    onGoingPaginationInfo: PaginationInfo = new PaginationInfo();
    reviewPaginationInfo: PaginationInfo = new PaginationInfo();
    intakesSummary: any[] = [];
    assingedCaseSummary: any[] = [];
    reviewToSupervisor: any[] = [];
    getUsersList: RoutingUser[] = [];
    mergeUsersList: RoutingUser[] = [];
    getIntakeUsers: RoutingUser[] = [];
    originalUserList: RoutingUser[] = [];
    supervisorList: RoutingUser[] = [];
    totalRecords!: number;
    totalRecordsAssingedCase!: number;
    totalRecordsAssignedStatus!: number | null;
    totalRecordsAppeal!: number;
    totalRecordsPreIntake!: number;
    totalRecordsSupervisor!: number;
    totalRecordsCaseReview!: number;
    dynamicObjectIntakeSummary: DynamicObject = {};
    dynamicObjectAssignCase: DynamicObject = {};
    dynamicObjectPreIntake: DynamicObject = {};
    dynamicObjectAppeal: DynamicObject = {};
    dynamicObjectReviewToSupervisor: DynamicObject = {};
    dynamicObjectCaseReview: DynamicObject = {};
    currentStatus!: string;
    previousPage!: number;
    intakeSearchCriteria: any;
    assignedSearchCriteria: any;
    preIntakeSearchCriteria: any;
    reviewSearchCriteria: any;
    assignedStatus!: boolean;
    preIntakeStatus!: string;
    selectedPerson: any;
    selectedResponsibilityType!: string | null;
    selectIntake: any;
    isSupervisor!: boolean;
    ispreIntake!: boolean;
    getServicereqid!: string;
    getPreIntake!: PreIntakeAssign;
    showBroadCostMessage!: BroadCostMessage;
    preIntakeSummary: AssignedCase[] = [];
    statusDropdownItems$!: Observable<DropdownModel[]>;
    isGroup = false;
    zipCode!: string;
    zipCodeIndex!: number;
    userTypeKey!: string;
    appealStatus!: boolean;
    isGroupId = false;
    serviceRequestId!: string;
    supervisorReviewStatus!: boolean;
    isCPSAR!: boolean;
    servreqsubtype!: string;
    currentUrl!: string;
    roleId!: AppUser;
    responsibilityTypeDropdownItems$!: Observable<DropdownModel[]>;
    private searchTermStreamIntake$ = new Subject<DynamicObject>();
    private searchTermStreamAssignCase$ = new Subject<DynamicObject>();
    private searchTermStreamPreIntake$ = new Subject<DynamicObject>();
    private searchTermStreamAppeal$ = new Subject<DynamicObject>();
    private searchTermStreamOnGoing$ = new Subject<DynamicObject>();
    private pageStreamIntake$ = new Subject<number>();
    private pageStreamAssgine$ = new Subject<number>();
    private pageStreamPreIntake$ = new Subject<number>();
    private pageStreamAppeal$ = new Subject<number>();
    private pageStreamOnGoing$ = new Subject<number>();

    // appealSaveButton: boolean;
    private appealIntakeReqId!: string;
    reviewCases: ReviewCase[] = [];
    priorItem$!: Observable<Prior[]>;
    caseworkerpageurl = '/pages/case-worker/';
    reportsummaryurl = '/dsds-action/report-summary';

    private _authService: AuthService;
    private _alertService: AlertService;
    private _commonService: CommonHttpService;
    private _appealService: GenericService<Appeal>;
    private formBuilder: FormBuilder;
    private _router: Router;
    private _dataStoreService: DataStoreService;
    private _intakeUtils: IntakeUtils;

    constructor(private injector:Injector){
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._appealService = this.injector.get<GenericService<Appeal>>(GenericService);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._router = this.injector.get<Router>(Router);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
        this._appealService.endpointUrl = 'intakeservicerequestappeal/add';
    }

    ngOnInit() {
        if (this._authService.getCurrentUser().role.teamtypekey === 'DJS') {
            const url = '/pages/cjams-dashboard/pre-intakes';
            this._router.navigate([url]);
        }
        if (this._authService.getCurrentUser().role.teamtypekey === 'CW' || this._authService.getCurrentUser().role.teamtypekey === 'FNS') {
            const url = '/pages/cjams-dashboard/cw-intake-referals';
            this._router.navigate([url]);
        }
        if (this._authService.getCurrentUser().role.teamtypekey === 'IV-E') {
            const url = '/pages/cjams-dashboard/iv-e-cases';
            this._router.navigate([url]);
        }
        
        this.roleId = this._authService.getCurrentUser();
        this.paginationInfo.sortColumn = 'receiveddate';
        this.paginationInfo.sortBy = 'desc';
        this.formIntakeSummaryInitilize();
        this.appealFormInitialize();
        this.formAssignInitilize();
        this.formPreIntakeInitilize();
        // this.getIntakeSummary(1, 'pending');
        this.getAssignCase(1, false);
        // this.getPreIntakeSummary(1, 'PREINRU', false);
        const role = this._authService.getCurrentUser();
        if (role.role.name === 'apcs' || role.role.name === 'provider') {
            this.getBroadCostMessage();
        }

        if (role.role && role.role.teamtypekey === 'CW') {
            this.userTypeKey = 'CW';
        }
        this.appealForm.get('dispositioncode')?.valueChanges.subscribe((result) => {
            if (result === 'ScreenOUT') {
                this.appealForm.patchValue({ dispositioncode: '' });
                this._alertService.error('Screen out can not be selected');
            }
        });
        this.selectedResponsibilityType = null;
    }
    appealFormInitialize() {
        this.appealForm = this.formBuilder.group({
            appealdate: ['', [Validators.required]],
            dispositioncode: ['', [Validators.required]],
            remarks: ['', [Validators.required]]
        });
    }
    formIntakeSummaryInitilize() {
        this.intakeSummaryForm = this.formBuilder.group({
            intakenumber: ['']
        });
    }
    formAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: ['']
        });
    }
    formPreIntakeInitilize() {
        this.preIntakeForm = this.formBuilder.group({
            intakenumber: ['']
        });
    }
    getIntakeSummary(selectPage: number, status: string) {
        this.currentStatus = status;
        const pageSource = this.pageStreamIntake$.pipe(map((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            return {
                search: this.dynamicObjectIntakeSummary,
                page: pageNumber
            };
        }));

        const searchSource = this.searchTermStreamIntake$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObjectIntakeSummary = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);
        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectIntakeSummary,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                if (this.intakeSummaryForm.value.intakenumber === '') {
                    this.intakeSearchCriteria = {
                        intakenumber: '',
                        status: this.currentStatus,
                        sortcolumn: this.paginationInfo.sortColumn,
                        sortorder: this.paginationInfo.sortBy
                    };
                } else {
                    this.intakeSearchCriteria = {
                        intakenumber: this.intakeSummaryForm.value.intakenumber,
                        status: this.currentStatus,
                        sortcolumn: this.paginationInfo.sortColumn,
                        sortorder: this.paginationInfo.sortBy
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.intakeSearchCriteria
                    }),
                    'Intakedastagings/listdadetails'
                );
            }),)
            .subscribe((result) => {
                this.intakesSummary = result.data;
                this.intakesSummary = this.intakesSummary.map((item) => {
                    return this.checkTimeleftFn(item);  
                });
                if (this.paginationInfo.pageNumber === 1) {
                    this.totalRecords = result.count;
                }
            });
    }
    // Associated with getIntakeSummaryfunction 
    private checkTimeleftFn(item: IntakeSummary) {
        const timeleft = item.timeleft;
        if (timeleft) {
            item.timeelapsed = false;
            let _timeleft = timeleft.split(':');
            if (_timeleft.length > 1) {
                if (Number(_timeleft[0]) < 0) {
                    item.timeelapsed = true;
                }
                item.timeleft = Math.abs(Number(_timeleft[0])) + ' Hr(s) ' + _timeleft[1] + ' Min(s)';
            } else {
                _timeleft = this.timeleftLenghtZeroFn(_timeleft, timeleft, item);
            }
        }
        return item;
    }
    // Associated with checkTimeleftFn function
    private timeleftLenghtZeroFn(_timeleftTemp: any, timeleft: string, item: IntakeSummary) {
        const timeLeftValue = _timeleftTemp.split(' ');
        let _timeleft = timeLeftValue;
        if (_timeleft.length > 1) {
            if (Number(_timeleft[0]) < 0) {
                item.timeelapsed = true;
            }
            if (_timeleft[1].startsWith('d')) {
                item.timeleft = Math.abs(Number(_timeleft[0])) + ' Day(s)';
            } else if (_timeleft[1].startsWith('m')) {
                item.timeleft = Math.abs(Number(_timeleft[0])) + ' Month(s)';
            }
        }
        return _timeleft;
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.getIntakeSummary(this.paginationInfo.pageNumber, this.currentStatus);
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.getIntakeSummary(this.paginationInfo.pageNumber, this.currentStatus);
    }
    onSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObjectIntakeSummary[field] = {
            like: '%25' + value + '%25'
        };
        if (!value) {
            delete this.dynamicObjectIntakeSummary[field];
        }
        this.searchTermStreamIntake$.next(this.dynamicObjectIntakeSummary);
    }

    onSortedCaseCloded($event: ColumnSortedEvent) {
        this.tobeassignedPaginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStreamAssgine$.next(this.tobeassignedPaginationInfo.pageNumber);
    }

    getAssignCase(selectPage: number, assigned: boolean) {
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
                        assigned: this.assignedStatus
                    };
                } else {
                    this.assignedSearchCriteria = {
                        serreqno: this.assignedCaseForm.value.serreqno,
                        assigned: this.assignedStatus
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
                if(this.assignedStatus) {
                    this.totalRecordsAssignedStatus = result.count;
                } else {
                    this.totalRecordsAssignedStatus = null;
                }
            });
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

    getAppeal(selectPage: number, appealStatus: boolean) {
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

    pageAssignedChanged(pageInfo: any) {
        this.tobeassignedPaginationInfo.pageNumber = pageInfo.page;
        this.tobeassignedPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.tobeassignedPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.getAssignCase(this.tobeassignedPaginationInfo.pageNumber, this.assignedStatus);
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
                this.getUsersList = result.data;
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
            });
    }

    getResponsibilityType() {
        this.responsibilityTypeDropdownItems$ = this._commonService.getArrayList({}, 'responsibilitytype/').pipe(map((result) => {
            return result.map(
                (res) =>
                    new DropdownModel({
                        text: res.typedescription,
                        value: res.responsibilitytypekey
                    })
            );
        }));
    }

    private returnIntakeUsersFn(users: any): RoutingUser[] {
        return users.filter((res: any) => {
            if (!res.issupervisor) {
                this.isSupervisor = false;
                return res;
            }
        });
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
            this.getUsersList = this.returnIntakeUsersFn(this.getUsersList);
            this.getUsersListLoopFn();
        } else {
            this.isCPSAR = false;
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

    selectPerson(row: any) {
        this.selectedPerson = row;
    }
    selectResponsibilityType(item: any) {
        this.selectedResponsibilityType = item;
    }
    assignUser() {
        if (this.selectedPerson) {
            if (this.isCPSAR) {
                if (this.selectedResponsibilityType) {
                    this.assignCaseToUser();
                } else {
                    this._alertService.warn('Please select Responsibility');
                }
            } else {
                this.assignCaseToUser();
            }
        } else {
            this._alertService.warn('Please select a person');
        }
    }

    assignCaseToUser() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        appeventcode: 'INVT',
                        serreqid: this.getServicereqid,
                        assigneduserid: this.selectedPerson.userid,
                        isgroup: this.isGroup,
                        responsibilitytypekey: this.selectedResponsibilityType
                    },
                    method: 'post'
                }),
                'Intakedastagings/routeda'
            )
            .subscribe((result) => {
                this._alertService.success('Case assigned successfully!');
                this.getAssignCase(1, false);
                this.closePopup();
            });
    }

    routToCaseWorker(item: AssignedCase) {
        if (this.isGroupId === true) {
            this.serviceRequestId = item.intakeserviceid;
        } else {
            this.serviceRequestId = item.servicereqid;
        }
        const daNumber = item.servicerequestnumber.split(' ');
        this._commonService.getById(daNumber[0], CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            if(response.length > 0) {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            }
            const currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + this.reportsummaryurl;
            this._router.navigate([currentUrl]);
        });
    }

    getPreIntakeSummary(selectPage: number, status: string, ispreintake: boolean) {
        this.preIntakeStatus = status;
        this.ispreIntake = ispreintake;
        const pageSource = this.pageStreamPreIntake$.pipe(map((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObjectPreIntake, page: pageNumber };
        }));

        const searchSource = this.searchTermStreamPreIntake$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObjectPreIntake = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);
        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectPreIntake,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                if (this.preIntakeForm.value.intakenumber === '') {
                    this.preIntakeSearchCriteria = {
                        ispreintake: true,
                        intakenumber: '',
                        status: status
                    };
                } else {
                    this.preIntakeSearchCriteria = {
                        ispreintake: true,
                        intakenumber: this.preIntakeForm.value.intakenumber,
                        status: status
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.preIntakeSearchCriteria
                    }),
                    'Intakedastagings/listdadetails'
                );
            }),)
            .subscribe((result) => {
                this.preIntakeSummary = result.data;
                if (this.paginationInfo.pageNumber === 1) {
                    this.totalRecordsPreIntake = result.count;
                }
            });
    }

    pageChangedPreIntake(pageInfo: any) {
        this.preIntakePaginationInfo.pageNumber = pageInfo.page;
        this.preIntakePaginationInfo.pageSize = pageInfo.itemsPerPage;
        this.getPreIntakeSummary(this.preIntakePaginationInfo.pageNumber, this.preIntakeStatus, this.ispreIntake);
    }

    onSortedPreIntake($event: ColumnSortedEvent) {
        this.preIntakePaginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStreamPreIntake$.next(this.preIntakePaginationInfo.pageNumber);
    }
    onSearchPreIntake(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObjectPreIntake[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObjectPreIntake[field];
        }
        this.searchTermStreamPreIntake$.next(this.dynamicObjectPreIntake);
    }
    getAssignIntakeUser(modal: any) {
        this.getPreIntake = modal;
        this.selectIntake = null;
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'SITR' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.getIntakeUsers = result.data;
                this.getIntakeUsers = this.returnIntakeUsersFn(this.getIntakeUsers);
            });
    }

    selectIntaker(row: any) {
        this.selectIntake = row;
    }
    assignIntaker(modal: any) {
        if (this.selectIntake) {
            this._commonService
                .getPagedArrayList(
                    new PaginationRequest({
                        where: {
                            appeventcode: modal,
                            intakenumber: this.getPreIntake.intakenumber,
                            assigneduserid: this.selectIntake.userid
                        },
                        method: 'post'
                    }),
                    'Intakedastagings/assignintake'
                )
                .subscribe((result) => {
                    this._alertService.success('Intake assigned successfully!');
                    if (modal === 'SITR') {
                        this.getPreIntakeSummary(1, 'PREINRU', false);
                    } else if (modal === 'INTR') {
                        this.getIntakeSummary(1, 'approved');
                        $('#case-complete-tab').click();
                    }
                    this.closePopup();
                });
        } else {
            this._alertService.warn('Please select a person');
        }
    }

    closePopup() {
        (<any>$('#intake-caseassign')).modal('hide');   // NOSONAR
        (<any>$('#assign-preintake')).modal('hide');    // NOSONAR
        (<any>$('#reopen-intake')).modal('hide');   // NOSONAR
    }
    routToIntake(intakeId: string) {
        this._intakeUtils.redirectIntake(intakeId);
    }
    getBroadCostMessage() {
        const userid = this._authService.getCurrentUser().userId;
        this._commonService.getSingle(
            {
                method: 'get',
                where: { userid: userid }
            },         
             'announcement/getuserannouncement?filter'
            ).subscribe((result) => {
            if (result !== null) {
                (<any>$('#broadcoastmessage')).modal('show');   // NOSONAR
                this.showBroadCostMessage = result;
            }
        });
    }
    acceptAnnouncement() {
        this._commonService.endpointUrl = 'announcement/acceptannouncement';
        (<any>$('#broadcoastmessage')).modal('hide');   // NOSONAR
        this._commonService
            .patch(this.showBroadCostMessage.userannouncementid, {
                id: this.showBroadCostMessage.userannouncementid
            })
            .subscribe();
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
            (result: any) => {
                this._alertService.success('Your intake has been appealed successfully.');
                $('#case-appeal').click();
                this.appealForm.reset();
                this.getAppeal(1, true);
                (<any>$('#appeal-modal')).modal('hide');    // NOSONAR
            },
            (err: any) => {
                this._alertService.success('Unable to appeal your intake. Please try again!');
            }
        );
    }

    groupShow(row: any, id: any) {
        this.isGroupId = true;
        this.assingedCaseSummary[row].isCollapsed = !this.assingedCaseSummary[row].isCollapsed;
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
            mergeMap((params: { search: DynamicObject; page: number }) => {
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

    caseReviewPageChanged(pageInfo: any) {
        this.reviewPaginationInfo.pageNumber = pageInfo.page;
        this.reviewPaginationInfo.pageSize = pageInfo.itemsPerPage;
        if (this.reviewPaginationInfo.pageNumber !== 1) {
            this.previousPage = pageInfo.page;
        }
        this.caseReview(this.reviewPaginationInfo.pageNumber);
    }
    routeReviewCase(item: any) {
        this.serviceRequestId = item.intakeserviceid;
        const daNumber = item.servicerequestnumber.split(' ');
        this._commonService.getById(daNumber[0], CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            if(response.length > 0) {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            }

            if (item.appevent === 'GADR') {
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/placement/placement-gap/disclosure-checklist';
            } else {
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + this.reportsummaryurl;
            }
            this._router.navigate([this.currentUrl]);
        });
    }
    getPrior(intakenumber: any) {
            this.priorItem$ = this._commonService
            .getArrayList(
                {
                    where: {'intakenumber' : intakenumber},
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.Dashboard.GetPrior + '?filter'
            );
    }
    routToCase(daNumber: string, intakeserviceid: any) {
        (<any>$('#priorDetails')).modal('hide');    // NOSONAR
        this._commonService.getById(daNumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = this.caseworkerpageurl + intakeserviceid + '/' + daNumber + this.reportsummaryurl;
            this._router.navigate([currentUrl]);
        });
    }
}

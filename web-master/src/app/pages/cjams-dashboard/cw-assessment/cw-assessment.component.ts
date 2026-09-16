
import {debounceTime, map, mergeMap, startWith} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Subject ,  Observable, merge } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { AssignedCase, ReviewGridModal, ReviewCase, RoutingUser } from '../_entities/dashBoard-datamodel';
import { DashBoard } from '../cjams-dashboard-url.config';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { AlertService, AuthService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { PersonInformationComponent } from '../../home-dashboard/person-information/person-information.component';
import { RouterLink } from '@angular/router';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-assessment',
    templateUrl: './cw-assessment.component.html',
    styleUrls: ['./cw-assessment.component.scss'],
    imports:[SortTableModule,MatSortModule,MatSelectModule,MatCheckboxModule,PaginationModule,FormsModule,CommonModule,PersonInformationComponent,ReactiveFormsModule,RouterLink],
    standalone: true
})
export class CwAssessmentComponent implements OnInit {

    assignedCaseForm!: FormGroup;
    selectedPerson: any;
    mergeUsersList: RoutingUser[] = [];
    serviceRequestId!: string;
    currentUrl!: string;
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
    getUsersList: RoutingUser[] = [];
    originalUserList: RoutingUser[] = [];
    totalRecordsCaseReview!: number;
    totalRecordsSupervisor!: number;
    assignedSearchCriteria: any;
    reviewSearchCriteria: any;
    previousPage!: number;
    dynamicObjectAssignCase: DynamicObject = {};
    reviewPaginationInfo: PaginationInfo = new PaginationInfo();
    dynamicObjectReviewToSupervisor: DynamicObject = {};
    dynamicObjectCaseReview: DynamicObject = {};
    assingedCaseSummary: AssignedCase[] = [];
    paginationInfo: PaginationInfo = new PaginationInfo();
    responsibilityTypeDropdownItems$!: Observable<DropdownModel[]>;
    reviewToSupervisor: ReviewGridModal[] = [];
    tobeassignedPaginationInfo: PaginationInfo = new PaginationInfo();
    onGoingPaginationInfo: PaginationInfo = new PaginationInfo();
    reviewCases: any[] = [];
    supervisorList: Array<any> = [];
    roleId!: AppUser;
    ipaduser: boolean = false;
    workersList: any[] = [];
    childList$!: Observable<any[]>;
    private pageStreamOnGoing$ = new Subject<number>();
    private searchTermStreamOnGoing$ = new Subject<DynamicObject>();
    constructor(
        private _commonService: CommonHttpService,
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _dataStoreService: DataStoreService,
        private _session: SessionStorageService,
        private _alertService: AlertService) { 

        }
    caseworkerpageurl = '#/pages/case-worker/';
    ngOnInit() {
        this.roleId = this._authService.getCurrentUser();
        this.paginationInfo.sortColumn = 'receiveddate';
        this.paginationInfo.sortBy = 'desc';
        this.formAssignInitilize();
        this.loadSupervisor();
        this.caseReview(1);
        if(navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
            this.ipaduser = true;
        }
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
    }

    formAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: [''],
            securityusersid: ['']
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

        merge(searchSource, pageSource).pipe(
            startWith({
                search: this.dynamicObjectCaseReview,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                if (this.assignedCaseForm.value.serreqno === '') {
                    this.assignedSearchCriteria = {
                        servicerequestnumber: '',
                        eventcode: 'ASST',
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid
                    };
                } else {
                    this.assignedSearchCriteria = {
                        servicerequestnumber: this.assignedCaseForm.value.serreqno,
                        eventcode: 'ASST',
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid
                    };
                }
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.reviewPaginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.assignedSearchCriteria
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

    
    onSearchCase(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        if (this.appealStatus === true) {
            this.dynamicObjectCaseReview[field] = { like: '%25' + value + '%25' };
            if (!value) {
                delete this.dynamicObjectCaseReview[field];
            }
            this.searchTermStreamOnGoing$.next(this.dynamicObjectCaseReview);
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
            this.searchTermStreamOnGoing$.next(this.dynamicObjectAssignCase);
        }
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
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.getUsersList = result.data;
                this.originalUserList = this.getUsersList;
                this.listUser('TOBEASSIGNED');
            });
    }
    private loadSupervisor() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTRS' },
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
        this.caseReview(1);
    }

    selectPersonForAssign(checkBox: any, row: { userid: any; username: any; }) {
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
            this.handleUserCheckFn();
        } else {
            this.listuserelsecheck();
 
        }
    }
    private handleUserCheckFn() {
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

listuserelsecheck(){
    this.isCPSAR = false;
    this.selectedResponsibilityType = null;
    this.getUsersList = this.getUsersList.filter((res) => {
        if (res.issupervisor === true) {
            this.isSupervisor = true;
            return res;
        }
    });

    this.handleUserCheckFn();
}
    routeReviewCase(item: AssignedCase) {
        this.serviceRequestId = item.intakeserviceid;
        const daNumber = item.servicerequestnumber.split(' ');
        this._session.setTabKeyKey(daNumber[0]);
        let url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + daNumber[0];
        if (item.intakeservreqtypekey == CASE_TYPE_CONSTANTS.SC_SERVICE_CASE) {
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.intakeserviceid + '/casetype';
        } else if (item.intakeservreqtypekey == CASE_TYPE_CONSTANTS.ADOPTION) {
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.AdoptionActionSummary + '/' + item.intakeserviceid;
        }

        this._commonService.getAll(url).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            if(dsdsActionsSummary.da_county) {
                this._session.setItem('casecountyid', dsdsActionsSummary.da_county);
            }
            if (item.intakeservreqtypekey === 'Service Case') {
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
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/sc-permanency-plan/placement/appla/list';
            }

            window.open(this.currentUrl);
        });
    }

}

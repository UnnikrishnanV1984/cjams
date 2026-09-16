
import {debounceTime, map, mergeMap, startWith} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Subject, merge, Observable } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
import { AssignedCase, ReviewGridModal, ReviewCase, RoutingUser } from '../_entities/dashBoard-datamodel';
import { DashBoard } from '../cjams-dashboard-url.config';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { AuthService, DataStoreService, SessionStorageService, AlertService, LocalStorageService } from '../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { InvolvedPersonsService } from '../../shared-pages/involved-persons/involved-persons.service';
import { PersonInfoService } from '../../shared-pages/person-info/person-info.service';
import { Router, RouterLink } from '@angular/router';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { PersonInformationComponent } from '../../home-dashboard/person-information/person-information.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-approval',
    templateUrl: './cw-approval.component.html',
    styleUrls: ['./cw-approval.component.scss'],
    imports:[SortTableModule,MatSelectModule,MatCheckboxModule,PaginationModule,FormsModule,CommonModule,PersonInformationComponent,MatDatepickerModule,ReactiveFormsModule,RouterLink,MatFormFieldModule,MatInputModule],
    standalone: true
})
export class CwApprovalComponent implements OnInit {

    assignedCaseForm!: FormGroup;
    selectedPerson: any;
    serviceRequestId!: string | undefined;
    currentUrl!: string;
    mergeUsersList: RoutingUser[] = [];
    assignedStatus!: boolean;
    isSupervisor!: boolean;
    currentUser!: string;
    selectedResponsibilityType!: string | null;
    zipCodeIndex!: number;
    appealStatus!: boolean;
    getServicereqid!: string;
    zipCode!: string;
    isGroupId = false;
    isGroup = false;
    isCPSAR!: boolean;
    maxDate = new Date();
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
    reviewToSupervisor: any[] = [];
    tobeassignedPaginationInfo: PaginationInfo = new PaginationInfo();
    onGoingPaginationInfo: PaginationInfo = new PaginationInfo();
    reviewCases: ReviewCase[] = [];
    roleId!: AppUser;
    ipaduser: boolean = false;
    supervisorList: any = [];
    caseTypeUrl: any = '';
    workersList: any[] = [];
    childList$!: Observable<any[]>;
    private pageStreamOnGoing$ = new Subject<number>();
    private searchTermStreamOnGoing$ = new Subject<DynamicObject>();
    
    private _commonService: CommonHttpService;
    private _personInfoService: PersonInfoService;
    private formBuilder: FormBuilder;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private _session: SessionStorageService;
    private _localStorage: LocalStorageService;
    private _involvedPersonsService: InvolvedPersonsService;
    private _alertService: AlertService;
    private readonly router: Router;

    constructor(private injector: Injector) {
        this._commonService = this.injector.get < CommonHttpService > (CommonHttpService);
        this._personInfoService = this.injector.get < PersonInfoService > (PersonInfoService);
        this.formBuilder = this.injector.get < FormBuilder > (FormBuilder);
        this._authService = this.injector.get < AuthService > (AuthService);
        this.router = this.injector.get<Router>(Router);
        this._dataStoreService = this.injector.get < DataStoreService > (DataStoreService);
        this._session = this.injector.get < SessionStorageService > (SessionStorageService);
        this._localStorage = this.injector.get < LocalStorageService > (LocalStorageService);
        this._involvedPersonsService = this.injector.get < InvolvedPersonsService > (InvolvedPersonsService);
        this._alertService = this.injector.get < AlertService > (AlertService);
    }
    reportsummary = 'report-summary';
    adoptioncase = 'Adoption Case';
    servicecase = 'Service Case';
    caseworkerpageurl = '#/pages/case-worker/';

    ngOnInit() {
        this.roleId = this._authService.getCurrentUser();
        this.paginationInfo.sortColumn = 'receiveddate';
        this.paginationInfo.sortBy = 'desc';
        if(this.roleId && this.roleId.user && this.roleId.user.userprofile){
            const user = this.roleId.user.userprofile;
            this.currentUser = (user.lastname?user.lastname:'') +',    ' +(user.firstname?user.firstname:'');
        }
        if(navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
            this.ipaduser = true;
        }
        this.formAssignInitilize();
        this.loadSupervisor();
        this.assignedToSupervisor(1);
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
    }
    formAssignInitilize() {
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: [''],
            securityusersid: [''],
            dateFrom: [''],
            dateTo: ['']
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
//SonarQube - Removed the useless assignment to variable "source".
merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObjectReviewToSupervisor,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                if (this.assignedCaseForm.value.serreqno === '') {
                    this.assignedSearchCriteria = {
                        serreqno: '',
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? 
                                                this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid,
                        dateFrom: this.assignedCaseForm.value.dateFrom ? this.assignedCaseForm.value.dateFrom : null,
                        dateTo: this.assignedCaseForm.value.dateTo ? this.assignedCaseForm.value.dateTo : null
                    };
                } else {
                    this.assignedSearchCriteria = {
                        serreqno: this.assignedCaseForm.value.serreqno,
                        securityusersid: (this.assignedCaseForm.value.securityusersid === '') ? 
                                                this.roleId.user.userprofile.securityusersid : this.assignedCaseForm.value.securityusersid,
                        dateFrom: this.assignedCaseForm.value.dateFrom ? this.assignedCaseForm.value.dateFrom : null,
                        dateTo: this.assignedCaseForm.value.dateTo ? this.assignedCaseForm.value.dateTo : null
                    };
                }

                this.assignedSearchCriteria['role'] = this.roleId.role.key;

                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.onGoingPaginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.assignedSearchCriteria
                    }),
                    this.roleId.role.name.toLowerCase() === 'field' ? DashBoard.EndPoint.AssinedCase.CaseWorkerReviewUrl :  DashBoard.EndPoint.AssinedCase.SupervisorReviewUrl
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
                    where: { appevent: 'INTRS' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.supervisorList = result['data'];
                if(this.supervisorList && this.supervisorList?.length && this.supervisorList?.length>0){
                    this.supervisorList = this.supervisorList.filter((item: { username: string | null; }) => (item?.username !=null && item?.username !== ""));
                }
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
    // Associated with listUsermethod
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

    routToCaseWorker(item: any) {
        if (this.currentUser && this.currentUser === item['submitteduser']) {
            this._alertService.error("User cannot approve their own requests");
            return;
        }
        const daNumber = item.servicerequestnumber.split(' ');
        this._session.setTabKeyKey(daNumber[0]);
        this._dataStoreService.setData('appevent', item.appevent);
        this.caseTypeUrl = this.reportsummary.toString();
        let isRouted = false;
        switch(item.appevent) {
            case 'SENCHECK': 
                break;
            case 'PPLR':
            case 'GAYR':
                this.caseTypeUrl = this.ifAppeventIsPPLROrGAYRFn(item, this.caseTypeUrl);
                break;
            case 'CORR':
                this.caseTypeUrl = 'court/petition-detail';
                break;
            case 'TPRR':
                this.caseTypeUrl = 'sc-permanency-plan';
                break;
            case 'PWCR':
                this.caseTypeUrl = 'sdm';
                break;
            case 'CHRR':
                this.caseTypeUrl = 'child-removal/details';
                this._session.setItem(CASE_STORE_CONSTANTS.CHILDREMOVAL_ID , item.objectid);
                break;
            case 'IHSA':
                this.caseTypeUrl = 'in-home-service/service-agreement';
                break;
            case 'MPAI':
            case 'MPIA':
                this.caseTypeUrl = 'person-cw/list';
                this._localStorage.setItem(CASE_STORE_CONSTANTS.PERSON_MOVE_ID , item.objectid);
                break;
            case 'SPLAN':
                this._session.setItem(CASE_STORE_CONSTANTS.SERVICEPLAN_ID , item.entityid);
                this.caseTypeUrl = 'service-plan/sc-gc';
                break;
            case 'CPLAN3':
                this.caseTypeUrl = 'case-plan/case-plan-three';
                break;
            case 'CPLAN2':
                this.caseTypeUrl = 'case-plan/case-plan-two';
                break;
            case 'YTP':
                this.caseTypeUrl = 'service-plan/youth-transition-plan-new';
                break;
            case 'PLTR':
                this.caseTypeUrl = this.ifAppeventIsPLTPFn(this.caseTypeUrl, item);
                break;
            case 'GADR':
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this._session.setItem('Placement-Gap-Disclosure-Id', item.objectid);
                this.caseTypeUrl = 'placement/placement-gap/disclosure-checklist';
                this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
                break;
            case 'GASR':
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this._session.setItem('Placement-Suspension-Id', item.objectid);
                this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
                this.caseTypeUrl = 'placement/placement-gap/assignments';
                break;
            case 'GAARR':
            case 'GAAR':
            case 'GARR':
                this.caseTypeUrl = this.ifAppeventIsGAARRFn(item, this.caseTypeUrl);
                break;
            case 'ABLR':
                this._session.setItem('transid', item.objectid);
                this._session.setItem('transkey', 'breakthelink');
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this.caseTypeUrl = 'placement/adoption/break-the-line';
                this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, item.permanencyplanid);
                break;
            case 'ADPR':
                this._session.setItem('transid', item.objectid);
                this._session.setItem('transkey', 'planning');
                this._session.setItem('adoptionplanningpersonid', item.entityid);
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, item.permanencyplanid);
                this.caseTypeUrl = 'placement/adoption/planning/checklist';
                break;
            case 'AARR':
            case 'ASAR':
            case 'ADSR':
                this._session.setItem('transid', item.objectid);
                this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PERMANENCYPLANID, item.permanencyplanid);
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                if(!this.ifAppeventIsASARFn(item, this.caseTypeUrl) || !this.ifAppeventIsAARRFn(item, this.caseTypeUrl) || !this.ifAppeventIsADSRFn(item, this.caseTypeUrl)) {
                    return;
                }
                
                break;
            case 'ADYR':
                this._session.setItem('transid', item.objectid);
                this._session.setItem('transkey', 'annualreview');
                this._session.setItem('Placement-Review-Id', item.objectid);
                isRouted = true;
                this.routToCaseWorker1(item);
                break;
            case 'PCAUTH':
            case 'PCAUTHR':
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, (item.servreqtype === this.servicecase));
                this._session.setItem('PurchaseAuthorization', item.client_id);
                this._session.setItem('PurchaseAuthorizationServiceLog', item.service_log_id);
                this.caseTypeUrl = 'service-plan/service-log-activity/referred-services';
                break;
            case 'SCDR':
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this._session.setItem(CASE_STORE_CONSTANTS.DISPOSITIONID_FOR_APPROVAL, item.objectid);
                this.caseTypeUrl = 'disposition';
                break;
            case 'ACDR':
                this.routToCaseWorker1(item);
                this._session.setItem('transkey', 'suspension');
                isRouted = true;
                break;
            case 'GAAP':
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this._session.setItem(CASE_STORE_CONSTANTS.GAP_APPLICATION_ID, item.objectid);
                this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
                this.caseTypeUrl = 'placement/placement-gap/application';
                break;
            case 'EXPR':
                this._session.setItem('Expungement_Obj_ID', item.objectid);
                this.caseTypeUrl = 'investigation-findings';
                break;
            case 'INDR':
                this.caseTypeUrl = 'disposition';
                break;
            case 'ARSM':
                this.caseTypeUrl = 'alternative-response-summary';
                break;
            case 'Assessment':
            case 'assessment':
                this.routeReviewCase(item);
                isRouted = true;
                break;
            case 'QPDR':
                this.caseTypeUrl = '/person-cw/list';
                break;
            case 'CPSRTSV':
            case 'CPSRTS':
                this._session.setItem('cpsSkipApproval', 'true');
                this.caseTypeUrl = this.reportsummary;
                break;
            default:
                this.caseTypeUrl = this.reportsummary;
                break;
        } 
        if(item.appevent == 'SENSCP') {
            this.caseTypeUrl = 'service-plan/plan-of-safecare';
        }        

        if (this.isGroupId === true) {
            this.serviceRequestId = item.intakeserviceid;
        } else {
            this.serviceRequestId = item.servicereqid;
        }
        let isServiceCase = false;
        if (item.servreqtype === this.servicecase) {
            isServiceCase = true;
            this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        }
        
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + this.serviceRequestId + '/casetype';
       
      this.routToCaseWorkerContinue(daNumber,item,isServiceCase,isRouted,url);
    }

    routToCaseWorkerContinue(daNumber: any, item: any, isServiceCase: any, isRouted: any, url: any) {
        if(item.servreqsubtype == 'Intake') {
            this.routToCaseWorkerContinue1(daNumber,item,isServiceCase,isRouted);
       } else {

          this._commonService.getAll(url).subscribe((response) => {
          const dsdsActionsSummary = response[0];
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, item.servicereqid);
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            this._session.setItem('casecountyid', dsdsActionsSummary.da_county);
            if (item.appevent === 'SENCHECK') {
                this.senCheck(item,dsdsActionsSummary,isServiceCase); 
                return;
            }
            const currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/' + this.caseTypeUrl;
            
            //Form 1080
            if(item.appevent === 'FORM1080') {
                this.form1080ApprovalRouting(item);
                return;
            }
            
            if (!isRouted) {
                window.open(currentUrl);
            }
          });
       }
    }

    routToCaseWorkerContinue1(daNumber: any, item: any, isServiceCase: any, isRouted: any) {
        this._commonService.getById(daNumber[0], CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            if(response.length > 0) {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, item.servicereqid);
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                if (item.appevent === 'SENCHECK') {
                    this.senCheck(item,dsdsActionsSummary,isServiceCase); 
                    return;
                }
            }
            const currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/' + this.caseTypeUrl;
            
            //Form 1080
            if(item.appevent === 'FORM1080') {
                this.form1080ApprovalRouting(item);
                return;
            }
            
            if (!isRouted) {
                window.open(currentUrl);
            }
        });
    }

    form1080ApprovalRouting(item: any) {
        let attachmentsUrl = `${'#/pages/case-worker/'}${item.servicereqid}/${item.servicerequestnumber}/dsds-action/attachment`;
        if(item.servreqsubtype === 'Intake') {
            attachmentsUrl = `${'#/pages/newintake/my-newintake/'}${item.servicerequestnumber}/edit/attachment`;
        }
        const formsTabUrl = `${attachmentsUrl}`;
        window.open(formsTabUrl);
    }

    // Associated with routToCaseWorker method
    private senCheck(item: any,dsdsActionsSummary: any,isServiceCase: any) {
        this._dataStoreService.setData('dsdsActionsSummary',dsdsActionsSummary);
        let getpersonlistreq;
        let caseType: any;

        if (isServiceCase) {
            getpersonlistreq = { "personid": item.entityid,"intakeserviceid": null,"intakenumber": null,"objecttypekey": 'servicecase',"objectid": null,"servicecaseid": item.servicereqid };
            caseType = AppConstants.CASE_TYPE.SERVICE_CASE;
        } else {
            getpersonlistreq = { "personid": item.entityid,"intakeserviceid": item.servicereqid,"intakenumber": null,"objecttypekey": null,"objectid": null,"servicecaseid": null };
            caseType = AppConstants.CASE_TYPE.CPS_CASE;
        }
        this._personInfoService.getPersonDetails(getpersonlistreq).subscribe(response => {
            if (response) {
                this._dataStoreService.setData(AppConstants.GLOBAL_KEY.SOURCE_PAGE,AppConstants.MODULE_TYPE.CASE);
                this._personInfoService.setPersonInfo(response);
                this._involvedPersonsService.viewPerson(item.entityid);
                const personInfo = {
                    source: caseType,sourceID: item?.servicereqid,
                    intakeserviceid: ((item.servreqsubtype !== AppConstants.CASE_TYPE.SERVICE_CASE) ? item?.servicereqid : undefined),
                    personId: item?.entityid,action: AppConstants.ACTIONS.VIEW,data: {
                        purposeId: dsdsActionsSummary?.da_typeid,
                        caseNumber: item?.servicerequestnumber,
                        isProgramAreaOoh: false
                    }
                };
                this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO,personInfo);
                localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
            }
        });
    }

    // Associated with routToCaseWorker method
    private ifAppeventIsGAARRFn(item: AssignedCase, caseTypeUrl: string) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
        this._session.setItem('Placement-Agreement-Rate-Id', item.objectid);
        this._session.setItem(CASE_STORE_CONSTANTS.APPROVAL_EVENT_CODE, item.appevent);
        if (['GAARR', 'GARR'].includes(item.appevent)) {
            this.caseTypeUrl = 'placement/placement-gap/rate';
        } else {
            this.caseTypeUrl = 'placement/placement-gap/agreement';
        }
        return this.caseTypeUrl;
    }
    // Associated with routToCaseWorker method
    private ifAppeventIsPLTPFn(caseTypeUrl: string, item: AssignedCase) {
        this.caseTypeUrl = 'sc-placements/list';
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        }
        return this.caseTypeUrl;
    }
    // Associated with routToCaseWorker method
    private ifAppeventIsPPLROrGAYRFn(item: AssignedCase, caseTypeUrl: string) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        const isCW = this._authService.isCW();
        if (isCW) {
            if (item.appevent === 'PPLR') {
                this.caseTypeUrl = 'sc-permanency-plan';
            }
            if (item.appevent === 'GAYR') {
                this._session.setItem('Placement-Review-Id', item.objectid);
                this._session.setItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, item.permanencyplanid);
                this.caseTypeUrl = 'placement/placement-gap/annual-reviews';
            }
        } else {
            this.caseTypeUrl = 'placement-menu/placement/permanency-plan';
        }
        return this.caseTypeUrl;
    }
    // Associated with routToCaseWorker method
    private ifAppeventIsASARFn(item: AssignedCase, caseTypeUrl: string) {
        if (item.appevent === 'ASAR') {
            if (item.servreqtype === this.adoptioncase) {
                this.routToCaseWorker1(item);
                this._session.setItem('transkey', 'adoptionsubsidy');
                return false;
            } else {
                this.caseTypeUrl = 'placement/adoption/adoption-subsidy/agreement';
                this._session.setItem('transkey', 'subsidy');
            }
            return true;
        }
        return true;
    }
    // Associated with routToCaseWorker method
    private ifAppeventIsAARRFn(item: AssignedCase, caseTypeUrl: string) {
        if (item.appevent === 'AARR') {
            if (item.servreqtype === this.adoptioncase) {
                this.routToCaseWorker1(item);
                this._session.setItem('transkey', 'adoptionagreementrate');
                return false;
            } else {
                this.caseTypeUrl = 'placement/adoption/adoption-subsidy/rate';
                this._session.setItem('transkey', 'agreementrate');
            }
            return true;
        }
        return true;
    }
    // Associated with routToCaseWorker method
    private ifAppeventIsADSRFn(item: AssignedCase, caseTypeUrl: string) {
        if (item.appevent === 'ADSR') {
            if (item.servreqtype === this.adoptioncase) {
                this.routToCaseWorker1(item);
                this._session.setItem('transkey', 'suspension');
                return false;
            } else {
                this.caseTypeUrl = 'placement/adoption/adoption-subsidy/suspention-payment';
                this._session.setItem('transkey', 'suspension');
            }
            return true;
        }
        return true;
    }

    routeReviewCase(item: AssignedCase) {
        this.serviceRequestId = item.objectid;
        const daNumber = item.servicerequestnumber.split(' ');
        this._session.setTabKeyKey(daNumber[0]);
        this._commonService.getById(daNumber[0], CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            if(response.length > 0) {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                if(item.servreqtype==='CHILD'){
                    if(dsdsActionsSummary && dsdsActionsSummary.intakeserviceid){
                        this.serviceRequestId = dsdsActionsSummary.intakeserviceid;
                    }
                }
            }
            if (item.intakeservreqtypekey === this.servicecase  || item.servreqtype === this.servicecase) {
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            }
            if (item.appevent === 'GADR') {
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/dsds-action/placement/placement-gap/disclosure-checklist';
            } else {
                this._dataStoreService.setData('assesment-type', item.typename);
                let serviceRequestId = this.serviceRequestId;
                if (item.intakeservreqtypekey === this.servicecase  || item.servreqtype === this.servicecase) {
                    serviceRequestId = item.servicereqid;
                }
                this.currentUrl = this.caseworkerpageurl + serviceRequestId + '/' + daNumber[0] + '/dsds-action/assessment';
            }
            if (item.typename === 'APPLA') {
                this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                this.currentUrl = this.caseworkerpageurl + this.serviceRequestId + '/' + daNumber[0] + '/sc-permanency-plan/placement/appla/list';
            }
            if(item.typename === 'Shelter Care Authorization and Date of Hearing'){
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
                // To be decided : DEB As discussed with management we are parking this link but we are working on separate branch after extensive testing this will
                // be available for user
                    let  currentUrl = '';
                    if (item.appevent === 'ASAR') {
                      currentUrl = this.caseworkerpageurl + item.servicereqid + '/' + item.servicerequestnumber + '/dsds-action/placement/adoption/adoption-subsidy/agreement';
                    } else if (item.appevent === 'AARR') {
                        currentUrl = this.caseworkerpageurl + item.servicereqid + '/' + item.servicerequestnumber + '/dsds-action/placement/adoption/adoption-subsidy/rate';
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

    clearSearch(){
        this.assignedCaseForm.reset();
        this.assignedToSupervisor(1);
    }

    onSearchAssignCase(event: any, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.assignedToSupervisor(1);
    }

    groupShow(groupIndex: any, item: any) {
        //No data or function to call or add
    }

}


import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit, AfterViewInit, Injector } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable, forkJoin, of } from 'rxjs';
import _ from 'lodash';
import { HttpClient } from '@angular/common/http';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { PaginationInfo, PaginationRequest, PersonPaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService, GenericService, SessionStorageService, AlertService, CommonDropdownsService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { HttpService } from '../../../../@core/services/http.service';
import { AppConfig } from '../../../../app.config';
import { Assessments, GetintakAssessment, InvolvedPerson, RoutingInfo } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { Placement } from '../service-plan/_entities/service-plan.model';
import { ChildRoles } from '../child-removal/_entities/childremoval.model';
import { YouthInvolvedPersons } from '../involved-persons/_entities/involvedperson.data.model';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS, CASE_ASSESSMENT_FORMS_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { AssessmentService } from './assessment.service';
import { environment } from '../../../../../environments/environment';
import { AppConstants } from '../../../../@core/common/constants';
import moment from 'moment';
import { ExcelService } from '../../../home-dashboard/excel.service';
import { AssessmentResolverService } from './assessment-resolver-service';

declare var Formio: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'assessment',
    templateUrl: './assessment.component.html',
    styleUrls: ['./assessment.component.scss'],
    standalone: false
})
export class AssessmentComponent implements OnInit, AfterViewInit {
    internalAssessments: any[] = [];
    id: string;
    daNumber: string;
    assessmmentName!: string;
    startAssessment$!: Observable<Assessments[]>;
    data$!: Observable<Assessments[]>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    formBuilderUrl!: string;
    safeUrl!: SafeResourceUrl;
    showAssesment = -1;
    placementInfo: any;
    getAsseesmentHistory: GetintakAssessment[] = [];
    templateComponentData: any;
    templateSubmissionData: any;
    getScoreOnClose!: boolean;
    refreshForm: any;
    involvedPersons: InvolvedPerson[] = [];
    youthInvolvedPersons: YouthInvolvedPersons[] = [];
    routingInfo: RoutingInfo[] = [];
    routingSupervisors: any[] = [];
    placement: Placement[] = [];
    relationName: ChildRoles[] = [];
    childDetail: ChildRoles[] = [];
    roleId!: AppUser;
    isCansfShow = false;
    dsdsActionsSummary$!: Observable<any>;
    showAppla = false;
    notApplicableScore!: string;
    agency!: string;
    isCW!: boolean;
    isDjs!: boolean;
    hasMDInitialRisk = false;
    isSubmittedDrai = false;
    assessmentTemplateId: any;
    assessmentTemplateIdForDelete : any;
    isServiceCase!: string;
    assesType!: string;
    hasChildRemovalHappened: any;
    isViewCase = false;
    eductionDetatils: any[] = [];
    personRelations: any;
    contactrecording: any;
    drugList: any[] = [];
    serviceplanlist: any;
    isClosed = false;
    drugListAOD: any;
    childList: any;
    CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
    removalChildList: any;
    childRemovalInfo: any;
    personList: any[] = [];
    isReadonly= true;
    isLoading!: boolean;
    moduleview: any;
    isDeleteDisabled = false;
    isEditDisabled = false;
    isStartDisabled = false;
    isDeleteViewable = true;
    isEditViewable = true;
    isSupervisor = false;
    roleTypeKey!: string | undefined;
    auditlogTrail: any[] = [];
    auditlogTrailExpand: any;
    auditlogSafecTrail: any;
    ready = false;
    filterauditlogInfo: any;
    auditNullValues: boolean = false;
    auditUpdatedOn: any;
    auditUpdatedEmail: any;
    auditUpdatedBy: any;
    sheltercareauthstr = 'Shelter Care Authorization and Date of Hearing';
    viewassessment = 'view-assessment';
    placementrequestforma = 'PLACEMENT REQUEST FORM - ATTACHMENT A' ;
    qualifiedindividualassessmentb = 'QUALIFIED INDIVIDUAL (QI) ASSESSMENT - ATTACHMENT B';
    facilitatedmeetingreferralform = 'FACILITATED MEETING REFERRAL FORM';
    cansoutofhomeplacementservice = 'CANS-OUT OF HOME PLACEMENT SERVICE';
    sextraffickingscreeninginterview = 'SEX TRAFFICKING(CST) SCREENING INTERVIEW';
    revisionData: any;
    hasFamilyAccessToCase: boolean =false;
    isOOH: boolean = false;
    iscaseexpunged: any = 0;
    county: any;
    allRoutingUsers: any[] = [];

    private readonly route: ActivatedRoute;
    private readonly _commonService: CommonHttpService;
    public readonly sanitizer: DomSanitizer;
    private readonly _http: HttpService;
    private readonly _httpclient: HttpClient;
    private readonly _dataStoreService: DataStoreService;
    private readonly _router: Router;
    private readonly storage: SessionStorageService;
    private readonly _authService: AuthService;
    private readonly _alertService: AlertService;
    private readonly _commonDDService: CommonDropdownsService;
    private readonly _assessmentService: AssessmentService;
    private readonly excelService: ExcelService;

    constructor(private readonly _service: GenericService<Assessments>, private readonly injector : Injector, private assessmentResolverService: AssessmentResolverService) {
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.sanitizer = this.injector.get<DomSanitizer>(DomSanitizer);
        this._http = this.injector.get<HttpService>(HttpService);
        this._httpclient = this.injector.get<HttpClient>(HttpClient);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
        this._assessmentService = this.injector.get<AssessmentService>(AssessmentService);
        this.excelService = this.injector.get<ExcelService>(ExcelService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);

        this.id = this._commonDDService.getStoredCaseUuid();
        this.daNumber = this._commonDDService.getStoredCaseNumber();
        // this.route.data.subscribe((data:any) => {
        //     if (data && data.hasOwnProperty('result')) {
        //       this._authService.setAuthDetail('assessment',data.result);
        //     }
        // });
    }
    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.assessmentResolverService.getAssessment().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('assessment',data);
            }
        })
        this.resetfbToken();
        this.moduleview = this._authService.isModuleAccessable('assessment', 'assessment');
        this.isDeleteDisabled = this._authService.isDisabled('assessment','assessment.assessments.delete');
        this.isEditDisabled = this._authService.isDisabled('assessment','assessment.assessments.edit');
        this.isStartDisabled = this._authService.isDisabled('assessment','assessment.assessments.add');
        this.isDeleteViewable = this._authService.isView('assessment','assessment.assessments.delete');
        this.isEditViewable = this._authService.isView('assessment','assessment.assessments.edit');
        this.isLoading = false;
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        this.assesType = this._dataStoreService.getData('assesment-type');
        this.roleId = this._authService.getCurrentUser();
        this.getUserCounty();
        this.roleTypeKey = this.roleId?.user?.userprofile?.teammemberassignment?.teammember?.roletypekey;
          //QRTP Role check
         const activeTab = this.storage.getItem('activeModuleNav');
          if(activeTab === 'Qualified Individual') {
              this.roleTypeKey = 'QUINW';
          } else if(activeTab === 'FTDM/QI Supervisor') {
              this.roleTypeKey = 'FTDMQIS';
          } else if(activeTab === 'FTDM Facilitator') {
              this.roleTypeKey = 'FTDMFW';
          }
        this.agency = this._authService.getAgencyName();
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        const activeModuleRole = this.storage.getItem('activeModuleRole');
        if (activeModuleRole === 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
          this.isReadonly = false;
        } else {
        this.isReadonly = this._authService.readonlyButton('read_only_access','caseworker-contacts-notes-add-new');}
        if (this.agency === 'CW') {
            this.isCW = true;
        } else {
            this.isCW = false;
        }
        if(activeTab == 'Approve' && this.isReadonly && !this.isEditDisabled) {
            this.isEditDisabled = true;
        }
        this.isDjs = this._authService.isDJS();
        this.getChildRemoval();
        this.getAssessmentPrefillData();
        this.getPage(1);
        this.getActionSummary();
        this.getPlacementInfoList();
        this.getEducationInfo();
        this.getContactRecordings();
        this.getAssignmentsList()
        this.internalAssessments = this._assessmentService.getInternalAssessments()



       const da_status = this.storage.getItem('da_status');
           if (da_status) {
            if (da_status === 'Closed' || da_status === 'Completed') {
                this.isClosed = true;
            } else {
                this.isClosed = false;
            }
        }

    }
    ngAfterViewInit() {
        const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
        if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
            this.isViewCase = true;
            (<any>$(':button')).prop('disabled', true);
            (<any>$('span')).css({'pointer-events': 'none',
                        'cursor': 'default',
                        'opacity': '0.5',
                        'text-decoration': 'none'});
            (<any>$('i')).css({'pointer-events': 'none',
                                    'cursor': 'default',
                                    'opacity': '0.5',
                                    'text-decoration': 'none'});
            (<any>$('th a')).css({'pointer-events': 'none',
                                    'cursor': 'default',
                                    'opacity': '0.5',
                                    'text-decoration': 'none'});
        }
    }

    resetfbToken() {
        const templateUrl = environment.formBuilderHost + `/user/login`;
        this._httpclient
            .post(
                templateUrl,
                {
                    // data: {
                    //     email: environment.formBuilderUserId,
                    //     pswd: decodeURIComponent(atob(this.storage.getItem('formBuilderPassword'))) ? decodeURIComponent(atob(this.storage.getItem('formBuilderPassword'))) : null
                    // }
                },
                { observe: 'response' }
            )
            .subscribe(res => {
                this.storage.setObj('fbToken', res.headers.get('x-jwt-token'));
            });
    }

    getIntakeDRAIAssessmentDetails() {
        const involvedPersons = this.involvedPersons;
        if (involvedPersons && involvedPersons.length) {
            const personid = involvedPersons.filter(data => data.rolename === 'Youth');
            this._commonService
                .getArrayList(
                    {
                        method: 'get',
                        where: {
                            personid: personid && personid.length ? personid[0].personid : ''
                        }
                    },
                    'Intakeservicerequests/prepopasmtdrai?filter'
                )
                .subscribe((response) => {
                    this._dataStoreService.setData('DRAI_PREFILL', response);
                });
        }
    }

    filterAssessments(array: any) {
        const CPSIR = CASE_ASSESSMENT_FORMS_CONSTANTS.CPS_IR;
        const SERVICECASE = CASE_ASSESSMENT_FORMS_CONSTANTS.SERVICE_CASE;
        const storeData = this._dataStoreService.getCurrentStore();
        if (storeData.teamtypekey === 'CW' || storeData.ISSERVICECASE) {
            let resArray;
            if (storeData.ISSERVICECASE) {
                resArray = array.filter(function (item: { description: string; }) {
                    return SERVICECASE.includes(item.description);
                });
                resArray = this.checkShelterPlacement(array, resArray);
                return resArray;
            } else if (storeData.dsdsActionsSummary && storeData.dsdsActionsSummary.da_subtype && storeData.dsdsActionsSummary.da_subtype === 'CPS-IR') {
                resArray = array.filter(function (item: { description: string; }) {
                    return CPSIR.includes(item.description);
                });
                resArray = this.checkShelterPlacement(array, resArray);
                return resArray;
            } else if (storeData.dsdsActionsSummary && storeData.dsdsActionsSummary.da_subtype && storeData.dsdsActionsSummary.da_subtype === 'CPS-AR') {
                resArray = array.filter(function (item: { description: string; }) {
                    return CPSIR.indexOf(item.description) !== -1;
                });
                resArray = this.checkShelterPlacement(array, resArray);
                return resArray;
            } else {
                return array;
            }

        } else {
            return array;
        }

    }

    checkShelterPlacement(array: any, resArray: any) {
        const hasShelterAssessment = array.find((item: { description: string; intakassessment: any; }) => (item.description === this.sheltercareauthstr && item.intakassessment && item.intakassessment.length));
        if (hasShelterAssessment) {
            resArray.push(hasShelterAssessment);
        }
        return resArray;
    }

    getPage(page: number) {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        let inputRequest: Object;
        this._http.overrideUrl = false;
        this._http.baseUrl = AppConfig.baseUrl;
        if (this.isServiceCase) {
            inputRequest = {
                objecttypekey: 'servicecase',
                objectid: this.id
                // objectid: '1ab13583-6d94-4929-92e0-09723df839f3'
            };
        } else {
            inputRequest = {
                servicerequestid: this.id,
                categoryid: null,
                subcategoryid: null,
                targetid: null,
                assessmentstatus: null,
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        }
        const source = this.getPageList(page, inputRequest);
        this.hasMDInitialRisk = false;
        this.startAssessment$ = source.pipe(pluck('data'));
        this.data$ = source.pipe(pluck('data'));
        this.showAssessmentValidation();
        this.safeCAssessmentValidation();
        this.draiAssessmentValidation();
        if (page === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
        }
    }
    getPageList(page: number, inputRequest: Object) {
        return this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: page,
                    limit: this.paginationInfo.pageSize25,
                    where: inputRequest,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment + '?filter'
            ).pipe(
                map(result => {
                    const data = this.filterAssessments(result.data);
                    const pdsFormDataIndex = data.findIndex((x: { description: string; }) => x.description == "PADS Form");

                    if (data.filter((x: { description: string; }) => x.description === "PADS Form").length) {
                        const pdsData = data.splice(pdsFormDataIndex, 1);
                        data.unshift(...pdsData);
                    }
                    const aodFormData = data.filter((x: { description: string; intakassessment: any; }) => x.description == "AOD Form" && x.intakassessment && x.intakassessment.length);
                    if (!aodFormData.length) {
                        const aodFormIndex = data.findIndex((x: { description: string; }) => x.description == "AOD Form");
                        data.splice(aodFormIndex, 1);
                    }
                    if (data.filter((x: any) => x.description === "DOMESTIC VIOLENCE LETHALITY SCREEN FOR DHS LEGACY").length) {
                        const domesticDataIndex =  data.findIndex((x: any) => x.description == "DOMESTIC VIOLENCE LETHALITY SCREEN FOR DHS LEGACY");
                        const domesticData = data.splice(domesticDataIndex, 1);
                        const lapAssessmentDataIndex =  data.findIndex((x: any) => x.description == "LAP (Lethality Assessment Program)");
                        data.splice(lapAssessmentDataIndex + 1,0,domesticData[0])
                    }
                    if (data.filter((x: any) => x.description === "SEX TRAFFICKING(CST) SCREENING INTERVIEW").length) {
                        const sexDataIndex =  data.findIndex((x: any) => x.description == "SEX TRAFFICKING(CST) SCREENING INTERVIEW");
                        const sexData = data.splice(sexDataIndex, 1);
                        const qyitAssessmentDataIndex =  data.findIndex((x: any) => x.description == "Quick Youth Indicators for Trafficking (QYIT)");
                        data.splice(qyitAssessmentDataIndex + 1,0,sexData[0])
                    }
                    if(data.find((x: any) => x.description == "SAFE-C")?.intakassessment?.length)
                    {
                        const safecDataCount = data.find((x: any) => x.description == "SAFE-C")?.intakassessment?.filter((y: any) => y.assessmentstatustypekey == "Accepted").length;
                        this._dataStoreService.setData('safecDataCount', safecDataCount);
                    } else {
                        this._dataStoreService.setData('safecDataCount', 0);
                    }
                    return { data: data, count: data && data.length ? data : 0 };
                }),
                share(),);
    }
    showAssessmentValidation() {
        this.data$.subscribe((result: any) => {
            if (result) {
                let index = 0;
                let selectedAssesment: any;
                for (let i = 0; i < result.length; i++) {
                    this.handleIfMFIRAFn(result, i);
                    if (result[i].description === this.assesType) {
                        selectedAssesment = result[i];
                        index = i;
                        break;
                    }
                }
                if (selectedAssesment) {
                    this.showAssessment(index, selectedAssesment.intakassessment);
                }
            }
        });
    }
    // Assosiated with showAssessmentValidation method
    private handleIfMFIRAFn(result: any, i: number) {
        if (result[i].description && (result[i].description === 'MFIRA')) {
            if (result[i].intakassessment && result[i].intakassessment.length && result[i].intakassessment.length > 0) {
                this.hasMDInitialRisk = true;
            }
        }
    }

    safeCAssessmentValidation() {
        this.startAssessment$.subscribe(list => {
            const assessmentSafeC = list.find(element => element.description === 'SAFE-C');
            if (assessmentSafeC && assessmentSafeC.intakassessment && assessmentSafeC.intakassessment.length > 0) {
                const approvedAssessment = assessmentSafeC.intakassessment.find(data => {
                    if (data.assessmentstatustypekey === "Accepted" && data.submissiondata && data.submissiondata.displaysafetyplan) {
                        return true;
                    }
                    else {
                        return false;
                    }
                });
                if (approvedAssessment && approvedAssessment.updateddate) {
                    this._dataStoreService.setData('safetyassessmentcompletiondate', approvedAssessment.updateddate);
                }
                else {
                    this._dataStoreService.setData('safetyassessmentcompletiondate', null);
                }

            }

        });
    }
    draiAssessmentValidation() {
        if (this._authService.isDJS()) {
            this.startAssessment$.subscribe(list => {
                const intakeDRAI = list.find(element => element.description === 'Intake Detention Risk Assessment Instrument');
                if (intakeDRAI && intakeDRAI.intakassessment && intakeDRAI.intakassessment.length > 0) {
                    const submittedAssessment = intakeDRAI.intakassessment.find(data => data.assessmentstatustypekey === 'Submitted');
                    this.isSubmittedDrai = submittedAssessment ? true : false;
                } else {
                    this.isSubmittedDrai = false;
                }
            });
        }
    }
    private getActionSummary() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this.dsdsActionsSummary$ = this._commonService
            .getById(this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${this.iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).pipe(
            map(res => {
                return res[0];
            }),
            share(),);
        this.dsdsActionsSummary$.subscribe(response => {
            if(response) {
                const dobChid = response['persondob'];
                this.isCansfShow = this.getAge(dobChid) >= 5 ? true : false;
                this.showAppla = this.getAge(dobChid) < 16 ? true : false;
            }
        });
    }
    private getAge(dobChid: string | number | Date) {
        dobChid = new Date(dobChid);
        const calculateYear = new Date().getFullYear();
        const calculateMonth = new Date().getMonth();
        const calculateDay = new Date().getDate();

        const birthYear = dobChid.getFullYear();
        const birthMonth = dobChid.getMonth();
        const birthDay = dobChid.getDate();

        let age = calculateYear - birthYear;
        const ageMonth = calculateMonth - birthMonth;
        const ageDay = calculateDay - birthDay;

        if (ageMonth < 0 || (ageMonth === 0 && ageDay < 0)) {
            age = age - 1;
        }
        return age;
    }

    startAssessment_v2(assessmentName: any, mode: any) {
        this._dataStoreService.setData('CASEWORKER_SERVICE_PLAN_LIST', this.serviceplanlist);
        this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', assessmentName);
        this._router.navigate([this.viewassessment], {relativeTo : this.route});
    }

    startAssessment(assessment: any, mode: string | undefined) {
        if (!this.isLoading) {
            if (this._authService.isDJS() && assessment.description === 'DRAI Follow Up') {
                if (!this.isSubmittedDrai) {
                    this._alertService.error('Please Submit Intake DRAI');
                    return false;
                }
            }
            assessment.mode = mode;
            this._dataStoreService.setData('CASEWORKER_SERVICE_PLAN_LIST', this.serviceplanlist);
            this._dataStoreService.setData('CASEWORKER_INVOLVED_PERSON', this.involvedPersons);
            this._dataStoreService.setData('CASEWORKER_PERSON_RELATIONS', this.personRelations);
            this._dataStoreService.setData('CASEWORKER_YOUTH_INVOLVED_PERSON', this.youthInvolvedPersons);
            this._dataStoreService.setData('CASEWORKER_ROUTING_INFO', this.routingInfo);
            this._dataStoreService.setData('CASEWORKER_SUPERVISORS', this.routingSupervisors);
            this._dataStoreService.setData('CASEWORKER_PLACEMENT', this.placement);
            this._dataStoreService.setData('CASEWORKER_SELECTED_ASSESSMENT', assessment);
            this._dataStoreService.setData('CASEWORKER_CHILD_DETAIL', this.childDetail);
            this._dataStoreService.setData('CASEWORKER_DRUG_LIST', this.drugList);
            if(this.isSupervisor && assessment.mode === 'start'){
                this._alertService.warn('Please change the role from supervisor approval to case worker.');
            }
            else{
                this.routeToAssessment(assessment);
            }
        }
    }

    reviseAssesments() {
        this.revisionData.assessmentid = null;
        this.revisionData.submissionid = null;
        this.revisionData.submissiondata.isCompleted = false;
        this.revisionData.assessmentstatustypekey = null;
        this.revisionData.submissiondata.assessmentStaus = 'InProcess';
        this.revisionData.submissiondata.youthplacementservice.assessmentstatus = null;
        this.revisionData.submissiondata.youthplacementservice.assessmentStaus = 'InProcess';
        this.revisionData.submissiondata.youthproviderservice = null;
        this.revisionData.submissiondata.youthplacementservice.caseworkercomments=null;
        this.revisionData.submissiondata.youthplacementservice.assessmentapprovaldate=null;
        this.revisionData.submissiondata.youthplacementservice.supervisorcomments=null;
        this.revisionData.submissiondata.youthplacementservice.caseworkersignature=null;
        this.revisionData.submissiondata.youthplacementservice.supervisorsignature=null;
        this.revisionData.submissiondata.youthplacementservice.caseworkersigneddate=null;
        this.startAssessment(this.revisionData,'start');
        (<any>$('#revise-assessment-popup')).modal('hide');
     }

    routeToAssessment(assessment: any) {
        switch (true) {
            case assessment.description === 'cans-v2':
            case assessment.titleheadertext === 'cans-v2':
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'cans-v2');
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === this.placementrequestforma:
            case assessment.titleheadertext === this.placementrequestforma:
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', this.placementrequestforma);
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === this.qualifiedindividualassessmentb:
            case assessment.titleheadertext === this.qualifiedindividualassessmentb:
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', this.qualifiedindividualassessmentb);
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === this.facilitatedmeetingreferralform:
            case assessment.titleheadertext === this.facilitatedmeetingreferralform:
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', this.facilitatedmeetingreferralform);
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === this.cansoutofhomeplacementservice:
            case assessment.titleheadertext === this.cansoutofhomeplacementservice:
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', this.cansoutofhomeplacementservice);
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === 'MFIRA':
            case assessment.titleheadertext === 'MFIRA':
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'MFIRA');
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === 'AOD Form':
            case assessment.titleheadertext === 'AOD Form':
            case assessment.description === 'AOD/PADS Form':
            case assessment.titleheadertext === 'AOD/PADS Form':
                this._dataStoreService.setData('CASEWORKER_DRUG_LIST_AOD', this.drugListAOD);
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'AOD Form');
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === 'PADS Form':
            case assessment.titleheadertext == "PADS Form":
                this._dataStoreService.setData('CASEWORKER_DRUG_LIST_PADS', this.drugListAOD);
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'PADS Form');
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === this.sextraffickingscreeninginterview:
            case assessment.titleheadertext === this.sextraffickingscreeninginterview:
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', this.sextraffickingscreeninginterview);
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === 'SAFE-C':
            case assessment.titleheadertext === 'SAFE-C':
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'SAFE-C');
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case assessment.description === 'LAP (Lethality Assessment Program)':
            case assessment.titleheadertext === 'LAP (Lethality Assessment Program)':
                 this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'LAP (Lethality Assessment Program)');
                 this._router.navigate([this.viewassessment], { relativeTo: this.route });
                    break;
            case assessment.description === 'SAFE-C OHP':
            case assessment.titleheadertext === 'SAFE-C OHP':
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'SAFE-C OHP');
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            case (assessment.description === 'Quick Youth Indicators for Trafficking (QYIT)'):
            case assessment.titleheadertext === 'Quick Youth Indicators for Trafficking (QYIT)':
                this._dataStoreService.setData('SELECTED_ASSESSMENT_NAME', 'Quick Youth Indicators for Trafficking (QYIT)');
                this._router.navigate([this.viewassessment], { relativeTo: this.route });
                break;
            default:
                this._router.navigate(['case-worker-view-assessment'], { relativeTo: this.route });
                break;
        }
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize25 = pageInfo.itemsPerPage;
        this.getChildRemoval();
        this.getPage(this.paginationInfo.pageNumber);
    }

    showAssessment(id: number, row: any) {
        this.getAsseesmentHistory = row;
        if (this.showAssesment !== id) {
            this.showAssesment = id;
        } else {
            this.showAssesment = -1;
        }
    }
    actionIconDisplay(modal: any, status: string): boolean {
        if (status === 'View') {
            return modal.assessmentstatustypekey !== 'Open' && modal !== null;
        } else if (status === 'Edit') {
            return this.checkStatusTypeKey(modal);
        } else if (status === 'Print') {
            return modal.assessmentstatustypekey !== 'Open' && modal !== null;
        } else if (status === 'InProcess') {
            return modal.assessmentstatustypekey === 'InProcess' && modal !== null;
        }
        return false;
    }

    checkStatusTypeKey(modal: any) {
        const cwstatusList = ['Accepted']; // Rejected is removed based on UAT team request on 03072019
        const supStatusList = ['Open', 'Accepted'];
        if (modal.assessmentstatustypekey == 'Review' && modal.name == 'SAFE-C') {
            return true;
        }
        if (!this.isSupervisor && modal.assessmentstatustypekey === 'Review') {
            return false;
        }
        return (!cwstatusList.includes(modal.assessmentstatustypekey) && modal !== null) || (this.roleId.role.name === 'apcs' && !supStatusList.includes(modal.assessmentstatustypekey));
    }

    auditLog(assessmentid: any) {
        this.getAuditInformation(assessmentid);
        this.getFilterAuditInformation(assessmentid);
        (<any>$('#audit-log')).modal('show');
    }

    CheckIfObject(value: null)
    {
        return value !== null ? typeof(value) : '';
    }

    getAuditInformation(assessmentid: any) {
        this._commonService.getPagedArrayList(
          new PaginationRequest({
            limit: 30,
            page: 1,
            method: 'get',
            where: {
              columnid: 'assessmentid',
              tableid:  'assessment_history',
              objectid: assessmentid
          }

          }),
          'servicecase/getauditlog?filter').subscribe((result) => {
            if (result && result.data) {
                if (this.assessmentTemplateId === '1ce7d8ae-e13f-4ed3-a074-ea203935a1aa') {
                    result.data.forEach((eData) => {
                        if (eData?.modifieddata && eData?.modifieddata.data) {
                            eData.modifieddata.data = eData.modifieddata.data.filter((eeData: any) =>
                                !['activeflag', 'actorrelationshipid'].includes(eeData.key)
                            );
                        }
                    });
                }
                this.auditNullValues = true;
                result.data = this.sortResultsByKey(result.data);
                this.formatingAuditTrail(result.data);
                this.formatingAuditTrailTime(result.data);
            }
        });
    }

    sortResultsByKey(data: any) {
        const sortedData = data;
        if (sortedData.length > 0) {
            for (const element of sortedData) {
                const _data = element.modifieddata.data;
                const uniqueArray = _data.filter((value: any, index: any) => {
                    return index === _data.findIndex((obj: any) => {
                        return JSON.stringify(obj) === JSON.stringify(value);
                    });
                });
                element.modifieddata.data = uniqueArray.sort((e1: { key: string; }, e2: { key: string; }) =>
                    e1.key.toLowerCase().localeCompare(e2.key.toLowerCase()));
            }
        }
        return sortedData;
    }
    getFilterAuditInformation(assessmentid: any) {
        this._commonService.getPagedArrayList(
          new PaginationRequest({
            limit: 30,
            page: 1,
            method: 'get',
            where: {
              columnid: 'assessmentid',
              tableid:  'assessment_history',
              objectid: assessmentid
          }

          }),
          'servicecase/getauditlog?filter').subscribe((result) => {
            if (result && result.data) {
                if (this.assessmentTemplateId === '1ce7d8ae-e13f-4ed3-a074-ea203935a1aa') {
                    result.data.forEach((resultItem) => {
                        if (resultItem?.modifieddata && resultItem?.modifieddata.data) {
                            resultItem.modifieddata.data = resultItem.modifieddata.data.filter((eResultItem: any) =>
                                !['activeflag', 'actorrelationshipid'].includes(eResultItem.key)
                            );
                        }
                    });
                }

                result.data = this.sortResultsByKey(result.data);
                this.formatingAuditTrailTime(result.data);
                this.filterauditlogInfo = result.data;

            }
        });
    }


    formatingAuditTrail (data: any) {
        data.forEach((item: any) => {
            if (item.modifieddata && item.modifieddata.data && item.modifieddata.data.length) {
                item.modifieddata.data.forEach((element: { new_value: any; old_value: any; }) => {
                    const modifiedElement = this.getElementValues(element);
                    element.new_value = modifiedElement.new_value;
                    element.old_value = modifiedElement.old_value;

                });
            }
        })
        this.formatAuditInfo(data);
    }

    getElementValues(element: any) {
        let new_value = element.new_value;
        let old_value = element.old_value;
        if (element.key == "dangerInfluencesIdentified") {
            switch (element.new_value) {
                case 'safetydecision1':
                    new_value = 'Child Is Safe (Influences 1-18 Marked No)';
                    break;
                case 'safetydecision2':
                    new_value = 'Child Is Conditionally Safe (Any Influences 1-16 Is Checked And There Is A Completed Safety Plan That Is Signed By All Parties)';
                    break;
                case 'safetydecision3':
                    new_value = 'Child Is Conditionally Safe (Any Influences 17-18 Is Checked Yes All Actions In A Required Case Staffing Have Been Implemented)';
                    break;
                case 'safetydecision4':
                    new_value = 'Child Is Unsafe'
                    break;

            }

            switch (element.old_value) {
                case 'safetydecision1':
                    old_value = 'Child Is Safe (Influences 1-18 Marked No)';
                    break;
                case 'safetydecision2':
                    old_value = 'Child Is Conditionally Safe (Any Influences 1-16 Is Checked And There Is A Completed Safety Plan That Is Signed By All Parties)';
                    break;
                case 'safetydecision3':
                    old_value = 'Child Is Conditionally Safe (Any Influences 17-18 Is Checked Yes All Actions In A Required Case Staffing Have Been Implemented)';
                    break;
                case 'safetydecision4':
                    old_value = 'Child Is Unsafe'
                    break;

            }
        }
        if (element.key == "safeccaregivers") {
            if (element.new_value && element.new_value.length) {
                new_value = element.new_value.toString()
            }
            if (element.old_value && element.old_value.length) {
                old_value = element.old_value.toString()
            }
        }

        return {
            new_value: new_value,
            old_value: old_value
        }
    }

    formatAuditInfo(data: any){
        if (!this.auditNullValues) {
            this.auditlogTrailExpand = data;
            return;
        }
        this.formatingAuditTrailTime(data);
        this.auditlogSafecTrail = data;
        if (this.handleAuditLogTrailCondFn()) {
            return;
        }
        this.handleAuditTrail()
        // this.auditlogTrail.forEach(audit => {
        //     if (audit?.modifieddata?.data) {
        //         let count = 0;
        //         const _newdata = [];
        //         for (let i = 0; i < audit.modifieddata.data.length; i++) {
        //             if (audit.modifieddata.data[i]?.new_value) {
        //                 _newdata.push(audit.modifieddata.data[i]);
        //                 count++;
        //                 if (count === 2) {
        //                     break;
        //                 }
        //             }
        //         }
        //         audit.modifieddata.data = _newdata;
        //     }
        // });
        // }
        // } else {
        //   this.auditlogTrailExpand = data;
        // }
    }
    // Assosiated with formatAuditInfo method
    handleAuditTrail() {
        this.auditlogSafecTrail.forEach((audit: any) => {
            if (audit?.modifieddata?.data) {
                audit.modifieddata.data = this.filterModifiedData(audit.modifieddata.data);
            }
        });
    }
    // Assosiated with formatAuditInfo method
    filterModifiedData(dataArray: any) {
        const filteredData = [];
        let count = 0;

        for (const item of dataArray) {
            if (item?.new_value) {
                filteredData.push(item);
                count++;
                if (count === 2) {
                    break;
                }
            }
        }

        return filteredData;
    }
    // Assosiated with formatAuditInfo method
    private handleAuditLogTrailCondFn() {
        return (!this.auditlogSafecTrail || this.auditlogSafecTrail.length === 0);
    }

    formatingAuditTrailTime(sortresult: any) {
        sortresult.forEach((el: any) => {
            const a = el.modifieddata ? el.modifieddata.data : null;
            if (a && a.length) {
                a.forEach((element: { new_value: any; old_value: any; }) => {
                    const modifiedElement = this.formatElementValues(element);
                    element.new_value = modifiedElement.new_value;
                    element.old_value = modifiedElement.old_value;
                });
            }
        })
    }

    formatElementValues(element: any) {
        let new_value = element.new_value;
        let old_value = element.old_value;
        if (element.key.includes('date') || element.key.includes('dob')) {
            new_value = this.handleDateFn(element, new_value);
            if (element.old_value && moment(element.old_value).isValid()) {
                old_value = this.getDateFormatted(element.old_value);
            }
        }
        if (element.key.includes('time')) {
            new_value = this.handleTimeFn(element, new_value);
            if (element.old_value && moment(element.old_value).isValid()) {
                old_value = this.getTimeFormatted(element.old_value);
            }
        }
        if (this.handleToCheckStatusFn(element)) {
            new_value = this.handleDateTimeFn(element, new_value);
        }

        return {
            new_value: new_value,
            old_value: old_value
        }
    }
    // Assosiated with formatElementValues method
    private handleDateFn(element: any, new_value: any) {
        if (element.new_value && moment(element.new_value).isValid()) {
            new_value = this.getDateFormatted(element.new_value);
        }
        return new_value;
    }
    // Assosiated with formatElementValues method
    private handleTimeFn(element: any, new_value: any) {
        if (element.new_value && moment(element.new_value).isValid()) {
            new_value = this.getTimeFormatted(element.new_value);
        }
        return new_value;
    }
    // Assosiated with formatElementValues method
    private handleDateTimeFn(element: any, new_value: any) {
        if (element.new_value && moment(element.new_value).isValid()) {
            new_value = this.getDateTimeFormatted(element.new_value);
        }
        return new_value;
    }
    // Assosiated with formatElementValues method
    private handleToCheckStatusFn(element: any) {
        return element.key.includes('dob') || element.key.includes('approvedon') || element.key.includes('submittedon') || element.key.includes('rejectedon');
    }

  getDateFormatted(date:any){
    if(date){
      return moment(date).format('MM/DD/YYYY');
    }else{
      return '';
    }
  }


  getTimeFormatted(date:any){
    if(date){
      return moment(date).format('h:mm A');
    }else{
      return '';
    }
  }

    auditlogTrailOpen(i: any, index: string | number) {
        this.auditNullValues = false;
        this.formatingAuditTrail(this.filterauditlogInfo);
        const auditdata = this.auditlogTrailExpand[index].modifieddata.data;
        let newAuditLog: any = [];
        if (auditdata?.length > 0) {
            for (const ad of auditdata) {
                newAuditLog = this.formatAuditLog(newAuditLog, ad, i);
                }
        }
        if (newAuditLog) {
            this.excelService.exportAsExcelFile(newAuditLog, 'assessmenthistory');
        }
    }

    formatAuditLog(newAuditLog: any, ad: any, i: any) {
        const newAuditLogRecodrd: any = {};
        if (this.newValueCheck(ad)) {
            newAuditLogRecodrd.Display_Name = ad.display_name.toUpperCase();
            newAuditLogRecodrd.New_Value = '';
            newAuditLogRecodrd.Old_Value = '';
            newAuditLogRecodrd.UpdatedBy = i.updatedby;
            newAuditLogRecodrd.UpdatedOn = i.updatedon;
            newAuditLog.push(newAuditLogRecodrd);
            if (ad.new_value?.length > 0) {
                for (let index = 0; index < ad.new_value?.length; index++) {
                    newAuditLog.push(this.setNewAuditLogRecord1(newAuditLogRecodrd, ad, index));
                }
            }
            else {
                newAuditLog.push(this.setNewAuditLogRecord2(newAuditLogRecodrd, ad));
            }
        }
        else {
            newAuditLog.push(this.setNewAuditLogRecord3(newAuditLogRecodrd, ad, i));
        }

        return newAuditLog;
    }

    newValueCheck(ad: { new_value: any; key: string; }){
        if (ad.new_value !== null && ad.new_value !== undefined && typeof (ad.new_value) === 'object' && ad.key !== 'routingsupervisors'){
            return true;
        } else {
            return false;
        }
    }

    setNewAuditLogRecord1(newAuditLogRecord: any, ad: any, index: number) {
        const newvalue = (ad.new_value !== null && ad.new_value !== undefined) ? JSON.stringify(ad.new_value[index]) : '';
        const oldvalue = (ad.old_value !== null && ad.old_value !== undefined) ? JSON.stringify(ad.old_value[index]) : '';

        newAuditLogRecord.Display_Name = '';
        newAuditLogRecord.New_Value = newvalue;
        newAuditLogRecord.Old_Value = oldvalue;

        return newAuditLogRecord;
    }

    setNewAuditLogRecord2(newAuditLogRecord: any, ad: { new_value: null | undefined; old_value: null | undefined; }) {
        const newvalue = (ad.new_value !== null && ad.new_value !== undefined) ? JSON.stringify(ad.new_value) : '';
        const oldvalue = (ad.old_value !== null && ad.old_value !== undefined) ? JSON.stringify(ad.old_value) : '';
        newAuditLogRecord.Display_Name = '';
        newAuditLogRecord.New_Value = newvalue;
        newAuditLogRecord.Old_Value = oldvalue;
        return newAuditLogRecord;
    }

    setNewAuditLogRecord3(newAuditLogRecord: any, ad: any, i: { updatedby: any; updatedon: any; }) {
        newAuditLogRecord.Display_Name = ad.display_name;
        newAuditLogRecord.New_Value = (ad.new_value !== null && ad.new_value !== undefined) ? ad.new_value.toString() : '';
        newAuditLogRecord.Old_Value = (ad.old_value !== null && ad.old_value !== undefined) ? ad.old_value.toString() : '';
        newAuditLogRecord.UpdatedBy = i.updatedby;
        newAuditLogRecord.UpdatedOn = i.updatedon;

        return newAuditLogRecord;
    }


    download(assessment: any){
        let intakenumber = null;
        if (this.isServiceCase) {
            const list = this._dataStoreService.getData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER);
            intakenumber = (Array.isArray(list) && list.length) ? list[0].intakenumber : null;
        } else {
            intakenumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.INTAKE_NUMBER);
        }
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['assessment'],
                'intakenumber': intakenumber,
                status: 'intake',
                assessment: assessment
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonService.download('evaluationdocument/generateintakedocument', modal)
            .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = `Assessment.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
        });
    }

    getPrintTitle(modal: { assessmentstatustypekey: string; name: string; }) {
        if (this.isDjs) {
            if (modal.assessmentstatustypekey === 'InProcess' && modal.name === 'intakeDetentionRiskAssessmentInstrument') {
                return 'Print Provisional DRAI';
            } else if (modal.assessmentstatustypekey === 'Submitted' && modal.name === 'intakeDetentionRiskAssessmentInstrument') {
                return 'Print Completed DRAI';
            } else {
                return 'Print';
            }
        } else {
            return 'Print';
        }
    }

    private getAssessmentPrefillData() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let involvedpersonreqobj = {};
        let getpersonlistreq = {};
        let routinginfoparam = {};
        if (this.isCW && this.isServiceCase) {
            involvedpersonreqobj = { servicecaseid: this.id };
            routinginfoparam = { servicecaseid: this.id };
            getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
        } else {
            involvedpersonreqobj = { intakeservreqid: this.id };
            routinginfoparam = { intakeserviceid: this.id };
            getpersonlistreq = { intakeserviceid: this.id, isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged };
        }

        let url = '';
    
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        this.isLoading = true;
        forkJoin([
            this._commonService.getPagedArrayList(
                new PersonPaginationRequest({
                    page: 1,
                    limit: 20,
                    personpagelimit: 50,
                    method: 'get',
                    where: getpersonlistreq
                }),
                url + '?filter'
            ),
            this._commonService.getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 50,
                    method: 'get',
                    where: routinginfoparam
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.RoutingInfoList
            ),
            this._commonService.getPagedArrayList(
                {
                    where: {
                        intakeserviceid: this.id
                    },
                    page: 1,
                    limit: 50,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementListUrl + '?filter'
            ),
            this._commonService.getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: involvedpersonreqobj
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            ),
            this._commonService.getById(this.id, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.YouthInvolvedPersonListUrl),
            this._commonService.getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get',
                    where: { intakeserviceid: this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.getpersonrelationbyintakeservice + '?filter'
            ),
            this._commonService.getArrayList(
                new PaginationRequest({
                    where: { appevent: 'ASST' },
                    method: 'post'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.SupervisorList
            ),
            this._commonService.getArrayList(
                {
                    where: {
                        tablename: 'substancetype',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                'referencetype/gettypes' + '?filter'
            ),
            this._commonService.getArrayList(
                {
                    where: {
                        caseid : this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)
                    },
                    method: 'get',
                },
                'serviceplan/listbyallrelation?filter'
            ),
            this._commonService.getPagedArrayList(
                new PaginationRequest({
                page: 1,
                limit: 20,
                method: 'get',
                where: this.getChildRemovalRequestParam()
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
                // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            ),
            this._commonService.getSingle(
            {
                where: this.getChildRemovalRequestParam(),
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                .GetChildRemovalList + '?filter'
            ),
            this._commonService.getArrayList(
                {
                    where:{objectid: this.id},
                    method: 'get',
                },
                'People/getallcaregiverpersonids?filter'
            )
            ]).subscribe((result:any) => {
            this.isLoading = false;
            this.involvedPersons = result[0]['data'];
            this.setStartAssessment();
            this.routingInfo = result[1][0] ? result[1][0]['routinginfo'] : [];
            this._dataStoreService.setData('caseUserDetails', this.routingInfo);
            if(result[6] && result[6]['data']){
                this.allRoutingUsers = result[6]['data'];
                this.setRoutingSupervisors();
            }
            this.placement = result[2]['data'];
            this.relationName = [];
            this.relationName = result[3].data;
            this.youthInvolvedPersons = result[4];
            this.drugList = [];
            this.serviceplanlist = result[8];
            this.personList = result[9]['data'];
            this.childRemovalInfo = result[10];
            if(result[11] && result[11].length && Array.isArray(result[11])){
                const careGiverPersonIds: any[] = []
                result[11].forEach(item => {
                    careGiverPersonIds.push(item.personid)
                })
                this._dataStoreService.setData('ALL_CAREGIVERS_IN_CASE',careGiverPersonIds);
            }
            this.updatePersonListWithChildRemoval();
            this.getRemovalChildList();
            if (result[7] && result[7].length && Array.isArray(result[7])) {
                // Sample Response
                // description: "Baby - Amphetamines"
                // ref_key: "BAS"
                // referencetypeid: "55"
                // value_text: "Baby - Amphetamines"
                this.drugList = result[7].map(drug => drug.value_text);
                this.drugListAOD = result[7];
            }
            this.setChildDetail();
            // this.childDetail = [];
            // if (this.relationName && this.relationName.length > 0) {
            //     this.relationName.map(res => {
            //         if (res.roles) {
            //             const checkRC = res.roles.filter(role => role.intakeservicerequestpersontypekey === 'RC');
            //             if (checkRC.length) {
            //                 this.childDetail.push(res);
            //             }
            //         }
            //     });
            // }
            // Get relationship from another API and override with existing object.
            const personRelations = result[5];
            this.personRelations = result[5];
            this.involvedPersons.forEach(person => {
                const filteredPerson = _.filter(personRelations, { cjamspid: person.cjamspid });
                person.relationship = _.get(filteredPerson, '0.relation.0.description');
            });

        if (this._authService.isDJS()) {
            this.getIntakeDRAIAssessmentDetails();
        }
        });
    }
    setStartAssessment() {
        const filtereddata = this.involvedPersons.filter(item => {
            return item.programarea && item.programarea.filter(prog => ['OOH'].includes(prog.programkey)).length > 0
        });
        if (filtereddata.length === 0) {
            this.isOOH = false;
            this.startAssessment$.subscribe(list => {
                const finindex = list.findIndex(x => x.description == "Casey Life Skills Assessment");
                if (finindex >= 0 && list[finindex].intakassessment?.length === 0) {
                    list.splice(finindex, 1);
                }
                this.startAssessment$ = of(list);
            });
        }
        else{
            this.isOOH = true;
        }
    }
    setChildDetail() {
        this.childDetail = [];
        if (this.relationName && this.relationName.length > 0) {
            this.relationName.forEach(res => {
                if (res.roles) {
                    const checkRC = res.roles.filter(role => role.intakeservicerequestpersontypekey === 'RC');
                    if (checkRC.length) {
                        this.childDetail.push(res);
                    }
                }
            });
        }
    }
    isIconDisabled(modal: any) {
        if (this.roleId.role.name === 'apcs') {
            if (modal.assessmentstatustypekey === 'InProcess' || modal.assessmentstatustypekey === 'Rejected' || modal.assessmentstatustypekey === 'Accepted') {
                return 'icon-disabled';
            }
        }
        
        return '';
        
    }
    confirmDelete(data: any) {
        this.assessmentTemplateIdForDelete = data;
        (<any>$('#delete-assessment-popup')).modal('show'); // NOSONAR
    }

    confirmRevision(data: any) {
        this.revisionData = data;
        (<any>$('#revise-assessment-popup')).modal('show'); // NOSONAR
    }

    deleteAssessment() {
        this._commonService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.DeleteAssessment;
        this._commonService.create({
            assessmentid: this.assessmentTemplateIdForDelete.assessmentid,
            assessmenttemplateid: this.assessmentTemplateIdForDelete.assessmenttemplateid,
            servicecaseid: this.assessmentTemplateIdForDelete.servicecaseid,
            assessmentstatustypekey1: this.assessmentTemplateIdForDelete.assessmentstatustypekey
            // method: 'post'
        })
            .subscribe(
                response => {
                    if (response) {
                        this._alertService.success(
                            'Assessment deleted successfully'
                        );
                        (<any>$('#delete-assessment-popup')).modal('hide'); // NOSONAR
                        this.getChildRemoval();
                        this.getAsseesmentHistory = [];
                        this.getPage(1);
                        this.showAssesment = -1;
                    }
                },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }

    getDateTimeFormatted(date:any){
        if(date) {
          if(date.includes('T')) {
            return moment(date).format('MM/DD/YYYY - h:mm:ss A');
          } else {
              return date;
          }
        } else {
          return '';
        }
      }

    getChildRemoval() {
        this._commonService
            .getSingle(
                {
                    where: { intakeserviceid: this.id },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .GetChildRemovalList + '?filter'
            )
            .subscribe(result => {
                if (result && result.length) {
                    this.hasChildRemovalHappened = result.some((item: { approvalstatus: string; }) => item.approvalstatus === 'Approved');
                } else {
                    this.hasChildRemovalHappened = false;
                }
            });
    }

    getContactRecordings() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    where: {isExpungementSuperUser: isExpungementSuperUser,iscaseexpunged: this.iscaseexpunged},
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.id + '?data'
            )
            .subscribe((result) => {
                this.contactrecording = result.data;
                let latest_Flag = false;
                if (this.contactrecording && this.contactrecording.length) {
                    this.contactrecording.forEach((rec: { recordingtype: string; progressnotereasontypekey: string; description: any; }) => {
                        if (rec.recordingtype === 'Note' && rec.progressnotereasontypekey == 'CC' && latest_Flag === false) {
                            let formatcontactNotes = rec.description;
                            formatcontactNotes = formatcontactNotes.toString();
                            this._dataStoreService.setData('contact_action_info', formatcontactNotes);
                            latest_Flag = true;
                            return true;
                        }
                        return false;
                    });
                }
            });
    }


    getPlacementInfoList() {
            return this._commonService
              .getPagedArrayList(
                new PaginationRequest({
                  page: 1,
                  limit: 20,
                  method: 'get',
                  where: { servicecaseid:  this.id  },
                }),
                'placement/getplacementbyservicecase?filter'
              ).subscribe(result => {
                if (result && result.data) {
                    this.placementInfo = result.data;
                    this._dataStoreService.setData('CASEWORKER_PLACEMENT_INFO', this.placementInfo);
                }
            });
    }

    getEducationInfo() {
        this._commonService.getArrayList({
            where: {
                object_id: this.id
            },
            method: 'get',
        }, 'personeducation/educationlistforassessment?filter').subscribe( response => {
            this.eductionDetatils = response;
            this._dataStoreService.setData('CASEWORKER_EDUCATION_INFO', this.eductionDetatils);
        });
    }

    getRemovalChildList() {
     // Get Removal child list
     if (this.personList && this.personList.length) {
        this.childList = this.personList.filter(child => {
            let childFound = false;
            if (child.roles && child.roles.length) {
                child.roles.forEach((role: { intakeservicerequestpersontypekey: string; }) => {
                    const childCategory = this.CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
                    if (childCategory) {
                        childFound = true;
                        return true;
                    }
                    return false;
                });
            }
            return childFound;
            });
        }
        this._dataStoreService.setData('REMOVAL_CHILD_LIST', this.childList);
    }

    getChildRemovalRequestParam() {

        let requestData;
        if (this.isServiceCase) {
          requestData = {
            objectid: this.id,
            objecttypekey: 'servicecase'
          };

        } else {
          requestData = { intakeserviceid: this.id };
        }
        return requestData;
    }

    updatePersonListWithChildRemoval() {

        if (this.childRemovalInfo && this.childRemovalInfo.length) {
          this.childRemovalInfo.forEach((removalInfo: any) => {
            this.personList.forEach(person => {
              if (person.personid === removalInfo.personid) {
                  this.getUpdatedPerson(person,removalInfo);
              }
            });
          });

        }
      }
      qrtppartbreassessment(data: any){
        data.assessmentid = null;
        data.submissionid = null;
        data.assessmentstatustypekey = null; // 'InProcess','Accepted'
        data.submissiondata.assessmentStaus = null;
        data.submissiondata.placementinfo.qiassessmenttype ='R' ;
        data.submissiondata.placementinfo.qiassessmentstartdate = null;
        data.submissiondata.placementinfo.sinature =null;
        data.submissiondata.placementinfo.qiname =null;
        data.submissiondata.placementinfo.submittedon = null;
        data.submissiondata.placementinfo.date = null;
        data.submissiondata.placementinfo.qiassessmentenddate = null;
        this.startAssessment(data,'start')

     }
     getUpdatedPerson(person: any, removalInfo: any) {
        person.removalStatus = removalInfo.approvalstatus ? removalInfo.approvalstatus : 'Draft';
        person.intakeservreqchildremovalid = removalInfo.intakeservreqchildremovalid;
        if (removalInfo.exitdate && person.removalStatus === 'Approved') {
            person.removalStatus = null;
            person.intakeservreqchildremovalid = null;
            person.enableNewRemoval = true;
        }

        if (!removalInfo.exitdate && person.removalStatus === 'Approved') {
            person.enableEndRemoval = true;
        } else if (removalInfo.exitdate && person.removalStatus === 'Review') {
            person.enableEndRemoval = true;
        } else {
            person.enableEndRemoval = false;
        }
        person.removalInfo = removalInfo;
        person.removalHistory = JSON.parse(JSON.stringify(this.childRemovalInfo.filter((removalHistory: { personid: any; }) => removalHistory.personid === person.personid)));
        person.hasHistory = person.removalHistory.length ? true : false;
        return person;
    }
 
    checkforeassessment(data: any){
        if(data.assessmentstatustypekey != 'Completed'){
            return;
        }
        if(data.activeplacement){
            const completeddate = new Date(data.activeplacement)
            if(data.personage <=12){

            completeddate.setMonth(completeddate.getMonth() + 4);

            if (new Date() > new Date(completeddate)){
                return true
            }
            else {
                return false;
            }
        } else{
            completeddate.setMonth(completeddate.getMonth() + 10);

            if (new Date() > new Date(completeddate)){
                return true
            }
            else {
                return false;
            }
        }
        }
    //   }

      }


    getAssignmentsList() {
        this._commonService.getArrayList(
            {
                where: { servicecaseid: this.id },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        ).subscribe(data => {
            if (data) {
                const fam = data.filter(item => item.enddate == null);
                if (fam && fam.length > 0 && this.roleTypeKey == 'QUINW') {
                    fam.forEach(element => {
                        this.handleIfKeyIsFamilyOrChildOrAdminFn(element);
                    })
                }
            }

        });
    }
    // Assosiated with getAssignmentsList method
    private handleIfKeyIsFamilyOrChildOrAdminFn(element: any) {
        const _key = element.responsibilitytypekey;
        if (_key && (_key === 'family' || _key === 'child' || _key === 'administrative')) {
            if (element.toworkerdetails) {
                const familyAssignmentWorker = element.toworkerdetails.filter((a: { securityusersid: string; }) => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
                if (familyAssignmentWorker.length > 0) {
                    this.hasFamilyAccessToCase = true;
                }
            }
        }
    }

    validateDomesticViolenceAssement(data: { assessmentstatustypekey: string; },assessment: { description: string; }) {
        return !((data.assessmentstatustypekey === "InProcess") && (assessment.description === "DOMESTIC VIOLENCE LETHALITY SCREEN FOR DHS LEGACY"))
    }
    showHistory(assessmentid: any) {
        this.auditlogTrail = [];
        this._commonService.getPagedArrayList(
          new PaginationRequest({
            limit: 30,
            page: 1,
            method: 'get',
            where: {
              columnid: 'assessmentid',
              tableid:  'assessment_history',
              objectid: assessmentid
            }
          }),
          'servicecase/getauditlog?filter').subscribe((result: any) => {
            if (result && result.data) {
              this.auditlogTrail = result.data;
              this.ready = true;
            } else {
              this.auditlogTrail = [];
            }
            if (this.ready) {
              (<any>$('#history-popup')).modal('show');
            }
          });
      }


      closeModal() {
        (<any>$('#audittrail-expand')).modal('hide');
        (<any>$('#history-popup')).modal('hide');
      }

    getUserCounty() {
        const profileCounty: any = this.roleId?.user?.userprofile?.userprofileaddress?.[0]?.county;
        if (profileCounty) {
            this.county = profileCounty;
            this.setRoutingSupervisors();
            return;
        }
        const filter: any = {};
        this._service
            .getAll('admin/county/getusercounty?data=' + encodeURIComponent(JSON.stringify(filter)))
            .subscribe({
                next: res => {
                    const userCounty: any = res && res.length > 0 ? res[0] : null;
                    this.county = userCounty?.countyname ?? this.returnTeamCountyNameFn();
                    this.setRoutingSupervisors();
                },
                error: () => {
                    this.county = this.returnTeamCountyNameFn();
                    this.setRoutingSupervisors();
                }
            });
    }

    // County on the user's team member assignment, used when neither the user profile
    private returnTeamCountyNameFn(): any {
        return this.roleId?.user?.userprofile?.teammemberassignment?.teammember?.team?.county?.countyname;
    }

    private setRoutingSupervisors() {
        if (!this.allRoutingUsers.length || !this.county) {
            return;
        }
        this.routingSupervisors = this.allRoutingUsers.filter(
            (sup: any) => sup.juridiction == this.county && sup.roledesc.includes('Supervisor'));
    }

}

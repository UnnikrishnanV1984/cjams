
import {of as observableOf,  Observable ,  forkJoin ,  Subscription ,  Subject, EMPTY } from 'rxjs';

import {pluck, share, map, switchMap} from 'rxjs/operators';
import {
    AfterContentInit,
    AfterViewInit,
    ChangeDetectorRef,
    Component,
    OnDestroy,
    OnInit,
    AfterViewChecked,
    Injector,
    ViewChild
    

} from '@angular/core';
import {
    AbstractControl,
    FormBuilder,
    FormControl,
    FormGroup,
    Validators
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
// import html2canvas from 'html2canvas';
import jsPDF from 'jspdf';
import moment from 'moment';
import * as _ from 'lodash';
import { AppConstants } from '../../../@core/common/constants';
import { ControlUtils } from '../../../@core/common/control-utils';
import { ObjectUtils } from '../../../@core/common/initializer';
import { AppUser } from '../../../@core/entities/authDataModel';
import { HttpService } from '../../../@core/services/http.service';
import {
    DropdownModel,
    PaginationRequest,
    PaginationInfo,
    ListDataItem
} from '../../../@core/entities/common.entities';
import {
    CommonDropdownsService,
    DataStoreService,
    GenericService,
    SessionStorageService
} from '../../../@core/services';
import { AlertService } from '../../../@core/services/alert.service';
import { AuthService } from '../../../@core/services/auth.service';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { SpeechRecognizerService } from '../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import {
    ChildList,
    Prior,
    RoutingUser
} from '../../cjams-dashboard/_entities/dashBoard-datamodel';
import { IntakeStore, IntakeUtils } from '../../_utils/intake-utils.service';
import { NewUrlConfig } from '../newintake-url.config';
import { IntakeConfigService } from './intake-config.service';
import {
    IntakeTabConfig
} from './intake-tab-config';
import {
    IntakeStoreConstants,
    MyNewintakeConstants
} from './my-newintake.constants';
import {
    CpsDocInput,
    CrossReference,
    CrossReferenceSearchResponse,
    FinalIntake,
    GeneralNarative,
    IntakeDATypeDetail,
    IntakePurpose,
    IntakeTemporarySaveModel,
    InvolvedPerson,
    Narrative,
    NarrativeIntake,
    Notes,
    ReviewStatus,
    Sdm,
    SdmData,
    SubType,
    IntakeCommunication
} from './_entities/newintakeModel';
import {
    Agency,
    ApproveIntakeResponse,
    CourtDetails,
    DATypeDetail,
    DelayForm,
    DelayResponse,
    General,
    GeneratedDocuments,
    IntakeAppointment,
    IntakeScreen,
    IntakeService,
    IntakeServiceSubtype,
    Person,
    SAOResponse
} from './_entities/newintakeSaveModel';
import { SpeechRecognitionService } from '../../../@core/services/speech-recognition.service';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { DatePipe } from '@angular/common';
import { IntakeDispositionComponent } from './intake-disposition/intake-disposition.component';
import { environment } from '../../../../environments/environment';
import { config } from '../../../../environments/config';
import { Assignments } from '../../case-worker/dsds-action/cw-assignments/assignments.data.model';
import { OwlDateTimeComponent } from '@danielmoncada/angular-datetime-picker';
import { Html2CanvasService } from '../../../@core/services/html2canvas.service';

declare let require: any;
declare let html2pdf: any;

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'my-newintake',
    templateUrl: './my-newintake.component.html',
    styleUrls: ['./my-newintake.component.scss'],
    standalone: false
})
export class MyNewintakeComponent
    implements OnInit, AfterViewInit, AfterContentInit, OnDestroy, AfterViewChecked {
    @ViewChild('picker2') picker2!: OwlDateTimeComponent<any>;
    departmentActionIntakeFormGroup!: FormGroup;
    generalResourceFormGroup!: FormGroup;
    saoResponseForm!: FormGroup;
    dispositionDelayForm!: FormGroup;
    draftReasonFormGroup!: FormGroup;
    intakeCommunication: IntakeCommunication[] = [];
    intakeServices: IntakeService[] = [];
    intakeServicesRequired = true;
    // intakeId: string;
    sdmDispositionCall!: string;
    draftReason: any;
    draftId: string;
    btnDraft!: boolean;
    isAutoSaveFlag: boolean = false;
    lastUpdatedTime: any = null;
    maxReceivedDate!: moment.Moment | null;
    intakeNumber: string | null;
    current_route!: string;
    intakeNumberNarrative!: string;
    isSDMdisplayed!: boolean;
    isVoluntaryPlacement = false;
    isDisplayOtherAgency!: boolean;
    generalResource: any[] = [];
    status: any;
    isStatus: boolean = false;
    general: General = new General();
    generalRecievedDate!: DelayResponse | null;
    reviewstatus: ReviewStatus = new ReviewStatus();
    reviewStatusCheck: any;
    cwIntakeWorkerButton!: boolean;
    private pageSubject$ = new Subject<number>();
    narrative: NarrativeIntake = new NarrativeIntake();
    paginationInfo: PaginationInfo = new PaginationInfo();
    readOnly!: boolean;
    // addAttachement: AttachmentIntakes[] = [];
    // intakeScreen: IntakeScreen = new IntakeScreen();
    addedCrossReference: CrossReferenceSearchResponse[] = [];
    selectedYouth?: InvolvedPerson | null=null;
    focusPerson?: InvolvedPerson | null = null;
    // addedPersons: InvolvedPerson[] = [];
    // addedEntities: InvolvedEntitySearchResponse[] = [];
    addedIntakeDATypeDetails: IntakeDATypeDetail[] = [];
    preIntakeSupDicision = '';
    // evalFields: EvaluationFields[];
    communicationFields: Notes[] = [];
    saoResponse!: SAOResponse;
    petitionDetails: any[] = [];
    scheduledHearings: any[] = [];
    isPetionDetailsSubmited = false;
    courtDetails!: CourtDetails;
    intakeAppointment: IntakeAppointment[] = [];
    // recordings: ContactTypeAdd[] = [];
    // Person: Person[] = [];
    // addNarrative: Narrative;
    addSdm!: Sdm;
    selectteamtypekey!: string;
    intakeServiceGrid!: boolean;
    intakeInfoNreffGrid!: boolean;
    intakeservice: IntakeService[] = [];
    intakeIandRservice: IntakeService[] = [];
    iandrCheck=false;
    intakeservicesubtype: IntakeServiceSubtype[] = [];
    intakeInfoReffTypes: any[] = [];
    otherAgencyControlName!: AbstractControl;
    isDjs = false;
    isAS = false;
    checkValidation!: boolean;
    saveIntakeBtn!: boolean;
    iskinshippurpose: boolean = false;
    // intakeType: string;
    // disposition: DispostionOutput[];
    purposeList: IntakePurpose[] = [];
    // createdCases: ComplaintTypeCase[];
    selectedPurpose!: DropdownModel;
    selectedAgency!: DropdownModel;
    roleValue = false;
    isPurposeNotCPS = false;
    isRcvdDtBeforeDob = false;
    pdfFiles: {
        fileName: string;
        images: { image: string; height: any; name: string }[];
    }[] = [];
    resourcePoplabel!: string;
    roleId!: AppUser;
    roletypekey:any;
    submitResourceObject!: GeneralNarative;
    downloadInProgress = false;
    reviewStatus!: string;
    cpsdocData: CpsDocInput = new CpsDocInput();
    viewKinship!: boolean;
    viewSafeHaven!: boolean;
    isKinshipSafehaven!: string;
    serviceCheckboxId!: any;
    delayFormData!: DelayForm;
    checkConditionForDelay = false;
    zipCode!: string;
    supervisorsList: RoutingUser[] = [];
    intakersList: RoutingUser[] = [];
    selectedSupervisor!: string;
    selectedIntaker!: string;
    isManualRouting!: string;
    isKinship = true;
    isSENflag = false;
    finalIntake: any = new FinalIntake();
    accessStatus!: boolean;
    subServiceTypes: SubType[] = [];
    // timeLeft: string;
    selectedIntakeServices: IntakeService[] = [];
    viewAscrs!: boolean;
    // ascrsScore: number;
    isCW = false;
    isPreIntake = false;
    isCLW = false;
    clwStatus: any;
    signedOffDate!: string;
    isPurposeWithAgency = true;
    genratedDocumentList: GeneratedDocuments[] = [];
    // intakedetailList: any;
    pathwayChange = false;
    initialSdm = new SdmData();
    showSubmit!: boolean;
    // scoresSubject$: Subject<AssessmentScores> = new Subject<AssessmentScores>();
    kinshipNavigator: string | null = null;
    priorItem$?: Observable<Prior[] | undefined>;
    isPurposeChanged = false;
    notification!: string | null;
    currentLanguage!: string;
    intakeSourceList$!: Observable<DropdownModel[]>;
    intakeCommunication$!: Observable<DropdownModel[]>;
    intakeAgencies$!: Observable<DropdownModel[]>;
    intakePurpose$!: Observable<DropdownModel[]>;
    warranttypes: any[] = [];
    saveasdraftReason: any[] = [];
    youthStatus!: string;
    personid!: string;
    currentPurpose: any;
    resubmissionPopupFlag: boolean = false;
    newPurpose: any;
    Kinshipcheck:boolean=false;
    isIAndRSelected: boolean = false;
    intakeSubServices: any[] = [];
    purposeSource!: string;
    currentPurposeValue!: string;
    recognizing: boolean;
    speechData: string;
    speechRecogninitionOn: boolean;
    voluntaryPlacementDropDown: any;
    // assessmentInput: IntakeDATypeDetail;
    // for HTML BINDING
    ROUTED_CLW = AppConstants.INTAKE_CONSTANTS.ROUTED_CLW;
    SAO_DOUCUMENT_GENERATED =
        AppConstants.INTAKE_CONSTANTS.SAO_DOUCUMENT_GENERATED;
    SAO_RESPONSE_CLOSED = AppConstants.INTAKE_CONSTANTS.SAO_RESPONSE_CLOSED;
    SAO_RESPONSED = AppConstants.INTAKE_CONSTANTS.SAO_RESPONSED;
    HEARING_SCHEDULED = AppConstants.INTAKE_CONSTANTS.HEARING_SCHEDULED;
    RESTITUTION_COMPLETED = AppConstants.INTAKE_CONSTANTS.RESTITUTION_COMPLETED;
    PETITIONS_SUBMITED = AppConstants.INTAKE_CONSTANTS.PETTIION_SUBMITED;
    HEARING_DETAILS = AppConstants.INTAKE_CONSTANTS.HEARING_SCHEDULED;
    COURT_ACTIONS_TO_BE_UPDATED =
        AppConstants.INTAKE_CONSTANTS.COURT_ACTIONS_TO_BE_UPDATED;
    appevent: any;
    modal: any;
    closeCWCae!: boolean;
    isClearenceHistory!: boolean;

    WAITNG_FOR_COURT_HEARING =
        AppConstants.INTAKE_CONSTANTS.WAITNG_FOR_COURT_HEARING;
    SAO_CLOSED = AppConstants.INTAKE_CONSTANTS.SAO_CLOSED;
    WAITNG_FOR_CASE_WORKER =
        AppConstants.INTAKE_CONSTANTS.WAITNG_FOR_CASE_WORKER;
    currentDate = new Date();
    clw = {
        documentGenerated: false,
        saoResponsed: false,
        pettionSubmited: false,
        hearingScheduled: false,
        hearingDetailUpdated: false,
        courtDetailUpdated: false
    };
    INTAKE_TABS = AppConstants.INTAKE_TABS;

    tabDisplay = {
        saoResponse: false,
        petitionDetails: false,
        scheduleHearings: false,
        courtActions: false,
        narrative: false,
        personsInvolved: false,
        sdm: false,
        evaluationFields: false,
        appointments: false,
        entities: false,
        serviceSubType: false,
        complaintsType: false,
        assessments: false,
        crossReference: false,
        notes: false,
        djsNotes: false,
        intakeReferral: false,
        attachments: false,
        disposition: false,
        decision: false,
        legalAction: false
    };
    isRFS = false;
    store: any;
    agencyTabOrder: {
        id?: string | undefined;
        title?: string;
        name?: string;
        role?: string[];
        route?: string;
        resource?: string[]; 
        securityKey?: string;
    }[] = [];
    intakeStore: IntakeStore;
    loadHTML!: boolean;
    intake: any;
    commonInvolvedPersons: any;
    referralSubmission!: boolean;
    dataStoreSubscription!: Subscription;
    caseCreated: any[] = [];
    attachmentCreated: any[] = [];
    attachementRequired: any[] = [];
    categoryList: any[] = [];
    missingSubCategory: any[] = [];
    subCategoryClassificationType$!: Observable<any[]>;
    subCategoryList: any[] = [];
    subType: any[] = [];
    approveIntakeResponse: ApproveIntakeResponse[] = [];
    isIntakeWorker = false;
    userRole!: AppUser;
    intakeCountyList$!: Observable<DropdownModel[]>;
    intakeCountyList: any[] = [];
    recievingIntakeCountyList: any[] = [];
    djsValidationMessages: any;
    narrativestatus: any;
    intakeErrorMessage!: string | null;
    selectedCheckbox!: string;
    selectedServiceCaseId: string | null = null;
    serviceCaseNumber: any;
    adoptionCaseNumber: any;
    exitingServiceCaseList: any;
    familyCaseData: any; // holds approve intakes response which is a family case
    isIntakeFromSupervisor = false;
    serviceTypeRequested: any;
    suggestedTypeResource: any;
    isEVPA = false;
    autosaveTimmer!: Subscription;
    saveInProgress = false;
    isrestricteditem = false;
    canUserRestrictItems = false;
    intakeChessieid = null;
    autoSaveIntervalTimer!: NodeJS.Timer | null;
    autoSaveInitiated: any;
    mergeUsersList: RoutingUser[] = [];
    getUsersList: RoutingUser[] = [];
    selectedteamid!: string;
    originalUserList: RoutingUser[] = [];
    isSupervisor!: boolean;
    selectedResponsibilityType!: string | null;
    zipCodeIndex!: number;
    selectedPerson!: any;
    responsibilityTypeDropdownItems: DropdownModel[] = [];
    teamForm!: FormGroup;
    teamList: Array<any> = [];
    teamid!: string;
    teamtypekey: any;
    seletedUserData: any;
    assignServiceCaseForm!: FormGroup;
    assignCaseForm!: FormGroup;
    serviceCaseResponse: any;
    adoptionCaseResponse: any;
    programArea: any[] = [];
    workersList: any[] = [];
    programSubArea: any[] = [];
    programSubAreaList: any[] = [];
    narrativeUpdatedTime: any;
    cpsResponseOffset!: number; // in hours
    dispcode: any;
    supDisposition: any;
    unknown!: boolean;
    submisionHistory: any;
    needSubmissionHistory = true;
    intakStatus!: string;
    intakeIsOpen: boolean;
    isIndependentLiving!: boolean;
    currentForm: any;
    isIndependentLivingInValid!: boolean;
    unSyncedMDMPersons: any;
    override!: IntakeDispositionComponent;
    enableCaseConnectClose!: boolean;
    isASCRS!: boolean;
    isIntakeApprove!: boolean;
    id: string;
    caseNumber: any;
    serviceCase: any;
    caseDate: any;
    servicecaseid: any;
    quickidentified!: boolean;
    intakeServiceId: any;
    countyDropDownItems: any;
    intakeTransferForm!: FormGroup;
    intakeTransferStatusForm!: FormGroup;
    intakeTransferAssignForm!: FormGroup;
    countId!: string | undefined | null;
    transferHistory: any;
    intakeWorkerList: RoutingUser[] = [];
    transferHistoryApproved: any;
    transferReason: any;
    rejectionReason: any;
    supervisorsCollection: any[] = [];
    supervisorsCollectionfortransfer: any[] = [];
    involevedPerson: InvolvedPerson[] = [];
    senChild: InvolvedPerson[] = [];
    isUnderReview: boolean = false;
    disableApproveBtn: boolean = false;
    issamecountyuser: boolean = false;  
    disableIntakeServicesType : boolean = false;
    checkforrequired: boolean=false;
    narrativepresent!: boolean;
    countySupervisorsList: any[] = [];
    displayValidationMessages: boolean = false;
    selfApproval: boolean = false;
    isSubTypeSelected? : boolean;
    mynewintake = 'my-newintake';
    inhomeservices = 'In Home Services';
    gettypesurl = 'referencetype/gettypes';
    listfilterurl = '/list?filter';
    requestforservices = 'Request for services';
    adoptionsubsidy = 'adoption-subsidy';
    privateadoptionsubsidy = 'Private Adoption Subsidy';
    historyclearance = 'history-clearance';
    cpshistoryclearance = 'CPS History Clearance';
    reasonfordelaypopupid = '#reason-for-delay';
    dtwithtimeformat = 'MM/DD/YYYY hh:mm:ss A';
    informationandreferral = 'Information and Referral';
    kinshipnavigation = 'Kinship Navigator';
    intakeerrorpopupid = '#intake-error';
    allegedvictim = 'Alleged Victim';
    dtformat1 = 'MM/DD/YYYY';
    addpersonnotifymsg = 'Please add a person to submit intake';
    fillyouthwarrantnotifymsg = 'Please fill Youth Warrant Details!';
    fillinterstatecompact = 'Please fill Interstate compact ';
    getroutingusersurl = 'Intakedastagings/getroutingusers';
    intakerefferal = 'intake-refferal';
    saoresponse = 'sao-response';
    saopetition = 'sao-petition';
    reportsummaryurl = '/dsds-action/report-summary';
    purposechangepopupid = '#purpose-change';
    approveintakeackmtpopupid = '#approve-intake-ackmt';
    approveintakeackmtservicecasepopupid = '#approve-intake-ackmt-service-case';
    approveintakeackmtadoptioncasepopupid = '#approve-intake-ackmt-adoption-case';
    assignLatePopup = '#assign-later-popup';
    caseworkerpageurl = '#/pages/case-worker/';
    selectapersonmsg = 'Please select a person';
    tryagainlatermsg = 'Please try again later';
    validationmsg = 'Please enter valid ';
    supDecisionNarrative = 'Navigate to Narrative';
    supDecisionWorker = 'Return to Worker';
    kinshipstring = 'Kinship Navigation Services';
    intakesubmitmsg = 'Intake Submitted Successfully!';
    saveintakeurl = '/pages/newintake/new-saveintake';
    notificationurl = 'Usernotifications/getSingle';    
    persondetailcwurl = 'People/getpersondetailcw?filter';
    notificationaddurl = 'Usernotifications/Add';
    servicecasesuccessmsg = 'Service Case assigned successfully!';
    assignlatermsg = 'Until this case is assigned to a worker, the case will be assigned to you the supervisor';
    inprogress = 'In Progress';
    errorFrom: string = '';
    returntoworker!: boolean;
    navigatetonarrative!: boolean;
    showaddendumnarrative: any;
    overriderequest!: boolean;
    casealreadycreated: boolean =false;
    hideTransferBtn: boolean = false;
    displayProgramSelectionValidationMessage: boolean = false;
    childList: ChildList[] = [];
    isChildPresentTemp: any;
    typeOfCaseAssign!: string;
    responsibilityevent: any;
    addendumNarrativeDetails: any = {
        addendumNarrativeCreatedAt: '',
        addendumNarrativeUpdatedAt: '',
        addendumNarrativeCreatedBy: '',
        addendumNarrativeUpdatedBy: '',
        addendumNarrativeCreatedByInfo: '',
        addendumNarrativeUpdatedByInfo: ''
    };
    existingfamilyassignment = '#existing-family-assignment-popup';
    private readonly _router: Router;
    private readonly route: ActivatedRoute;
    private readonly formBuilder: FormBuilder;
    private readonly _authService: AuthService;
    private readonly _alertService: AlertService;
    private readonly _commonHttpService: CommonHttpService;
    private readonly _commonDDService: CommonDropdownsService;
    private readonly speechRecognizer: SpeechRecognizerService;
    private readonly _dataStoreService: DataStoreService;
    private readonly _sessionStorage: SessionStorageService;
    private readonly _intakeConfig: IntakeConfigService;
    private readonly _intakeService: IntakeUtils;
    private readonly _speechRecognitionService: SpeechRecognitionService;
    private html2canvas:Html2CanvasService;

    ismergecase = false;
    assignmentsList$!: Observable<Assignments[]>;
    assignmentListData: any;
    hasActiveFamilyAssignment = false;
    responsibility!: number;
    nochild!: boolean;
    disableassign: boolean = false;
    draftReasonList!: Observable<any[]>;
    timeInterval: number = 5;
    multiYearSelector: boolean = true;
    personprogramids: any[] = [];
    addendumnarrativeupdated: any;

    //Form 1080 
    form1080aData: any = [];
    involvedPersonData: any = [];
    iscaseexpunged: any;
    
    constructor(
        private readonly cd: ChangeDetectorRef,
        private readonly injector : Injector,
        private readonly _genericServiceNarative: GenericService<GeneralNarative>,
        private readonly _datePipe: DatePipe,
        private readonly _http: HttpService,
        private readonly cdRef: ChangeDetectorRef
    ) {
        this._router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
        this.speechRecognizer = this.injector.get<SpeechRecognizerService>(SpeechRecognizerService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._intakeConfig = this.injector.get<IntakeConfigService>(IntakeConfigService);
        this._intakeService = this.injector.get<IntakeUtils>(IntakeUtils);
        this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
        
        this.speechRecogninitionOn = false;
        this.speechData = '';
        this.intakeIsOpen = false;
        this.recognizing = false;
        this._dataStoreService.setData(IntakeStoreConstants.INTAKE_IS_CLOSED, false);
        this.buildFormGroup();
        this.draftId = this._sessionStorage.getObj(
            IntakeStoreConstants.intakenumber
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.intakenumber,
            this.draftId
        );
        this.store = this._dataStoreService.getCurrentStore();
        localStorage.setItem('storeInfo', JSON.stringify(this.store));
        this.intakeStore = this._dataStoreService.getObj('intake');
        this._dataStoreService.setData(
            IntakeStoreConstants.IntakeAction,
            this.intakeStore.action
        );
        this.intakeNumber = this.intakeStore.number;
        this.route.data.subscribe((response: any) => {
            if (response && response.intake && response.intake.data && response.intake.data.length > 0 && response.intake.data[0].jsondata &&response.intake.data[0].jsondata.General && response.intake.data[0].jsondata.General.addendumNarrativeCreatedAt) {
                this.addendumNarrativeDetails = {
                    addendumNarrativeCreatedAt:  response.intake.data[0].jsondata.General.addendumNarrativeCreatedAt,
                    addendumNarrativeUpdatedAt:  this.isValidDate(response.intake.data[0].jsondata.General.addendumNarrativeUpdatedAt) ? response.intake.data[0].jsondata.General.addendumNarrativeUpdatedAt : null,
                    addendumNarrativeCreatedBy:  response.intake.data[0].jsondata.General.addendumNarrativeCreatedBy,
                    addendumNarrativeUpdatedBy:  response.intake.data[0].jsondata.General.addendumNarrativeUpdatedBy,
                    addendumNarrativeCreatedByInfo:  response.intake.data[0].jsondata.General.addendumNarrativeCreatedByInfo,
                    addendumNarrativeUpdatedByInfo:  response.intake.data[0].jsondata.General.addendumNarrativeUpdatedByInfo
                };  
            } else {
                this.addendumNarrativeDetails = {
                    addendumNarrativeCreatedAt: '',
                    addendumNarrativeUpdatedAt: '',
                    addendumNarrativeCreatedBy: '',
                    addendumNarrativeUpdatedBy: '',
                    addendumNarrativeCreatedByInfo: '',
                    addendumNarrativeUpdatedByInfo: ''
                };
            }
            if (response?.intake?.data?.length > 0 && ['ROACPS', 'Information and Referral', 'Request for services'].includes(response?.intake?.data[0]?.jsondata?.General?.PurposeName)) {
                if (response?.intake?.data[0]?.jsondata?.sdm) {
                    response.intake.data[0].jsondata.sdm.isroh = true;
                    response.intake.data[0].jsondata.sdm.isar = false;
                    response.intake.data[0].jsondata.sdm.isir = false;
                    response.intake.data[0].jsondata.sdm.cpsResponseType = null;
                }
            }
            this.intake = response.intake;
            this._intakeConfig.setPurposeList(response.purposeList);
            this._intakeConfig.setCommunicationList(response.communicationList); // @TM: communication drop-down resolver
            this.purposeList = this._intakeConfig.getPurposeList();
            this.intakeCommunication = this._intakeConfig.getCommunicationList();

            this.fixNarrativeHistoryClearanceText();

            this.commonInvolvedPersons = response.involvedPersonsList;
            if(this.commonInvolvedPersons == undefined){
                this.getcommonInvolvedPerson();
            }
            const general = this.store[
                IntakeStoreConstants.general
            ];
            if(general){
                const inputsource  = general.InputSource
                this.departmentActionIntakeFormGroup.patchValue({
                   InputSource:inputsource,
                   Purpose:general.Purpose
            });
        }
            // Set the received date on data store for other tabs to access
            if (this.intake && this.intake.data && this.intake.data[0]) {
                this._dataStoreService.setData(
                    IntakeStoreConstants.receivedDate,
                    this.intake.data[0].daterecieved
                );
                this.intakStatus = this.intake.data[0].reviewstatus;
                if (!this.intakStatus || (this.intakStatus.toLowerCase() === 'review' || this.intakStatus.toLowerCase() === 'draft')) { 
                    this.intakeIsOpen = true; 
                }
                this._dataStoreService.setData(IntakeStoreConstants.INTAKE_IS_CLOSED, !this.intakeIsOpen);
                this._dataStoreService.setData(
                    IntakeStoreConstants.INTAKE_STATUS,
                    this.intake.data[0].reviewstatus
                );
            }
        });
        this._intakeService.notesUpdated$.subscribe(_data => {
            this.processRecordingsList();
        });
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    }

    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this._intakeService.intakeTabSwitch$.subscribe( data => {
              this.current_route = data;
        });

        this.enableCaseConnectClose = environment.enableCaseConnectClose;
        this.loadDroddowns();
        this.isIntakeApprove = false;

        this.current_route = 'narrative';
        this.userRole = this._authService.getCurrentUser();
        if (
            this.intakeStore.action === 'add' &&
            this.userRole.role.name === AppConstants.ROLES.SUPERVISOR
        ) {
            this.isIntakeFromSupervisor = true;
        }
        this.isASCRS = false;
        this.isIntakeWorker =
            this.userRole.role.name === AppConstants.ROLES.INTAKE_WORKER;
        this.statusChangedSetFn();
        this.referralSubmission = false;
        const __this = this;
        $('#docu-View').on('hidden.bs.modal', function () {
            __this._dataStoreService.setData('loadhtml', false);
        });


        this.loadServiceTypeDropDown();
        this.loadSuggestTypeDropDown();
        this.getintakesnapshotrecord();
        this.checkRoleIdFn();
        this.listPurpose({
            text: '',
            value: this._authService.getAgencyName()
        });
        if (!this.draftId) {
            this.loadDefaults();
            this.listService({ text: 'Select', value: '' });
        }
        this.otherAgencyControlName = this.departmentActionIntakeFormGroup.get('otheragency') as AbstractControl;
        this.communicationFields = this.store[
            IntakeStoreConstants.communicationFields
        ];
        this.checkReviewStatusFn();
        this.departmentActionIntakeFormGroup.patchValue({
            Agency: this._authService.getAgencyName()
        });
        this.actionToPerformFn();
        this.listenForPersonChange();
        this.getSubCategory();
        this.currentLanguage = 'en-US';
        this.speechRecognizer.initialize(this.currentLanguage);
        this.notification = null;
        if (this.isDjs) {
            this.IfDjsSetIntakeActionFn();
        }
        this.checkSEN();
        this.listenForEAVPA();
        this.onReceivedDateChange();
        if (this.isCW) {
            this.listenForQuickAddPerson();
        }

        // Decide who can restrict cases
        if (
            this.userRole.role.name === AppConstants.ROLES.SUPERVISOR
        ) {
            this.canUserRestrictItems = true;
        }

        if (this.intakeNumber) {
            this.getIsRestrictItem();
            this.restrictedItemAuditLog();
        }

        this.teamForm = this.formBuilder.group({
            teamid: ['']
        });
        this.assignServiceCaseForm = this.formBuilder.group({
            programkey: [{ value: '', disabled: this.iskinshippurpose }],
            subprogramkey: [{ value: '', disabled: this.iskinshippurpose }]
        });
        this.assignCaseForm = this.formBuilder.group({
            programkey: [{ value: '', disabled: true }],
            subprogramkey: [{ value: '', disabled: true }]
        });
        this._dataStoreService.setData('isCPSHistoryClearanceChecked', false);
        this.getCounty();

        this._getCaseDetails();
        this.initiateAutoSave();
        this.getTrasferHistory();
        this.currentForm = this.store[IntakeStoreConstants.addNarrative];

        //Form 1080
        this.getForm1080A();
        if (this._router.url.endsWith('attachment')) {
            this.current_route = 'attachment';
            let url = `/pages/newintake/my-newintake/${this.intakeNumber}/edit/attachment`;
            this._router.navigate([url]);
        }
        if (this._router.url.endsWith('relationship')) {
            this.current_route = 'relationship';
            let url = `/pages/newintake/my-newintake/${this.intakeNumber}/edit/relationship`;
            this._router.navigate([url]);
        }
        if (this._router.url.endsWith('/person-cw/list')) {
            this.current_route = 'person-cw';
            let url = `/pages/newintake/my-newintake/${this.intakeNumber}/edit/person-cw/list`;
            this._router.navigate([url]);
        }
    }
    // Associated to ngOnInit function
    // private selectPersonTabIntakeFn() {
    //     if (this._dataStoreService.getData(IntakeStoreConstants.SELECT_PERSON_TAB_INTAKE) && this.agencyTabOrder && this.agencyTabOrder.length > 0) {
    //         var personTab = this.agencyTabOrder.filter(agencyTab => agencyTab.id === 'person-cw');
    //         if (personTab && personTab.length > 0) {
    //             this.onTabClick(personTab[0]);
    //         }
    //         this._dataStoreService.setData(IntakeStoreConstants.SELECT_PERSON_TAB_INTAKE, false);
    //     }
    // }
    // Associated to ngOnInit function
    private actionToPerformFn() {
        if (this.intakeStore.action === 'edit' || this.intakeStore.action === 'add') {
            this.populateIntake();
        } else if (this.intakeStore.action === 'view' && this.isDjs) {
            this.populateIntake();
        } else {
            this.checkDjsOrOtherToShowTabsFn();
        }
    }
    // Associated to ngOnInit function
    private checkRoleIdFn() {
        this.roleId = this._authService.getCurrentUser();
        this.roletypekey = this.roleId?.user?.userprofile?.teammemberassignment?.teammember?.teammemberroletype?.roletypekey;
        if (this.roleId.role.key === 'CWKN') {
            this.isKinship = false;
        }
        if (this.roleId.role.key === 'CWKA') {
            this.isKinship = false;
        }
        if (this.roleId.role.teamtypekey === 'DJS') {
            this.isDjs = true;
        }
        if (this.intake?.data[0] && this.intake?.data[0].jsondata?.General?.PurposeName === 'Kinship Navigation') {
            this.iskinshippurpose = true;
        }       
        if (this.roleId.role.teamtypekey === 'AS') {
            this.validateCountyIdAndPatchFn();
        }
        if (this.roleId.role.teamtypekey === 'CW') {
            this.isCW = true;
        }
        if (this.roleId &&
            this.roleId.role &&
            this.roleId.role.name === AppConstants.ROLES.COURT_WORKER) {
            this.isCLW = true;
        }
    }
    // Associated to ngOnInit function
    private checkReviewStatusFn() {
        if (this.roleId.role.name === AppConstants.ROLES.SUPERVISOR &&
            (this.reviewStatus === 'Review' || this.reviewStatus === 'Reopen')) {
            this.departmentActionIntakeFormGroup.controls.Agency.disable();
            this.departmentActionIntakeFormGroup.controls.Purpose.disable();
            this.departmentActionIntakeFormGroup.controls.InputSource.disable();
            this.departmentActionIntakeFormGroup.controls.RecivedDate.disable();
            this.departmentActionIntakeFormGroup.controls.isOtherAgency.disable();
        }
    }
    // Associated to ngOnInit function
    private IfDjsSetIntakeActionFn() {
        this._intakeConfig.setintakeAction(this.intakeStore.action);
        if (this.addedIntakeDATypeDetails &&
            this.addedIntakeDATypeDetails.length > 0) {
            const datypedetails = this.addedIntakeDATypeDetails[0];
            if (this.intakeStore.action === 'edit' &&
                datypedetails.DAStatus === 'Approved' &&
                this.userRole.role.name === AppConstants.ROLES.SUPERVISOR) {
                this._intakeConfig.setintakeAction('view');
                (<any>$(':button')).prop('disabled', true); // NOSONAR
            }
        }
    }
    // Associated to ngOnInit function
    private checkDjsOrOtherToShowTabsFn() {
        const usercounty = this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.team.countyid;
        this.countId = usercounty;
        if (usercounty && !this.departmentActionIntakeFormGroup.get('countyid')?.value && !this.readOnly) {
            this.departmentActionIntakeFormGroup.patchValue({ countyid: usercounty });
        }
        this.departmentActionIntakeFormGroup.controls.countyid.disable();
        if (this.isDjs) {
            this.onReceivedDateChange();
            this.initializeDJSTabs();
        } else {
            this.initializeTabs();
        }

        this._dataStoreService.setData(
            IntakeStoreConstants.childfatality,
            'no'
        );
    }
    // Associated to ngOnInit function
    private validateCountyIdAndPatchFn() {
        this.departmentActionIntakeFormGroup.controls['countyid'].setValidators([Validators.required]);
        this.departmentActionIntakeFormGroup.controls['countyid'].updateValueAndValidity();
        this.isAS = true;
        if (this.roleId.user.userprofile.userprofileaddress &&
            this.roleId.user.userprofile.userprofileaddress.length) {
            this.departmentActionIntakeFormGroup.controls['countyid'].patchValue(
                this.roleId.user.userprofile.userprofileaddress[0].countyid
            );
        }
    }
    // Associated to ngOnInit function
    private statusChangedSetFn() {
        this.dataStoreSubscription = this._dataStoreService.currentStore.subscribe(
            storeObj => {
                if (storeObj[IntakeStoreConstants.statusChanged] &&
                    this.isDjs) {
                    this._dataStoreService.setData(
                        IntakeStoreConstants.statusChanged,
                        false
                    );
                    this.getYouthStaus();
                }
            }
        );
    }

    fixNarrativeHistoryClearanceText() {
        if (this.intake && Array.isArray(this.intake.data) && this.intake.data.length > 0 && this.intake.data[0].jsondata && this.intake.data[0].jsondata.General) {
            if (this.intake.data[0].jsondata.General.Narrative) {
                this.intake.data[0].jsondata.General.Narrative.replace(/(\\n)/g, '<br>');
                const n = this.intake.data[0].jsondata.General.Narrative.replace(/(\\r)/g, '');
                this.intake.data[0].narrative = n;
                this.intake.data[0].jsondata.General.Narrative = n;
            }
            if (this.intake.data[0].jsondata.General.cpsHistoryClearance) {
                this.intake.data[0].jsondata.General.cpsHistoryClearance.replace(/(\\n)/g, '<br>');
                const h = this.intake.data[0].jsondata.General.cpsHistoryClearance.replace(/(\\r)/g, '');
                this.intake.data[0].jsondata.General.cpsHistoryClearance = h;
            }
        }
    }

    revertApprovedIntake(){
        this._http.post( NewUrlConfig.EndPoint.Intake.RevertApprovedIntake, {
            'intakenumber': this.intakeNumber
        }).subscribe( ( response ) => {
            if(response.data && response.data[0] && response.data[0].revertapprovedintake === 'SUCCESS'){
                this._alertService.success('Please approve again after a decision is made about case')
            }else{
                this._alertService.error('Intake approved should be reversed, contact support');
            }
            const url = `/pages/cjams-dashboard/cw-intake-referals`;
            setTimeout(() => this._router.navigate([url]), 1500);
        });

    }

    listenForEAVPA() {
        this._intakeConfig.intakeDecision$.subscribe((data) => {
            let selectedIntakeService: any[] = [];
            selectedIntakeService = this.selectedIntakeServices.filter(item => item.description === this.inhomeservices);
            if (selectedIntakeService && selectedIntakeService.length > 0) {
                const selectedServiceTypeItem = selectedIntakeService[0].intakeservsubtype.filter((item: { intakeservsubtypekey: any; }) => item.intakeservsubtypekey === data);
                const removeServiceTypeItem = selectedIntakeService[0].intakeservsubtype.filter((item: { intakeservsubtypekey: string; }) => item.intakeservsubtypekey === 'VP');
                if (selectedServiceTypeItem) {
                    this.intakeservicesubtype = [];
                    this.intakeservicesubtype = selectedServiceTypeItem;
                    this.isSelectedSubtypeItems(selectedServiceTypeItem[0]);
                    if (removeServiceTypeItem) {
                        this.intakeServiceSubtypeUnchecked(removeServiceTypeItem[0]);
                        this.intakeServiceSubtypeChecked(selectedServiceTypeItem[0]);
                    }
                }
            }
        });
    }

    ngAfterViewInit() {
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
        this.cd.detectChanges();
        if (this.isDjs) {
            if (this.intakeStore.action === 'view') {
                (<any>$(':button')).prop('disabled', true); // NOSONAR
            }
        }
    }

    ngAfterContentInit() {
        $('.btnNext').click(function () {
            $('.click-triggers > .active')
                .next('li')
                .find('a')
                .trigger('click');
        });

        $('.btnPrevious').click(function () {
            $('.click-triggers > .active')
                .prev('li')
                .find('a')
                .trigger('click');
        });

        $('#intake-cps-doc').on('shown.bs.modal', () => {
            this.genCpsIntakeDoc('generate');
        });
    }

    getYouthStaus() {
        if (this.selectedYouth) {
            let personid: any = null;
            if (this.selectedYouth.Pid) {
                personid = this.selectedYouth.Pid.startsWith(
                    AppConstants.PERSON.TEMP_ID
                )
                    ? null
                    : this.selectedYouth.Pid;
            }

            this._intakeService
                .getFocusPersonStatus(personid, null, this.intakeNumber)
                .subscribe(statuses => {
                    const status = statuses.map(s => s.description);
                    this.youthStatus = status.toString();
                    this._dataStoreService.setData(
                        IntakeStoreConstants.youthStatus,
                        status
                    );
                });
        }
    }
    // DJS-017 Complaint Received Date - should be auto-populated with the Received date from the referral screen
    onReceivedDateChange() {
        this.departmentActionIntakeFormGroup.get('RecivedDate')?.valueChanges.subscribe(receiveddate => {
                if (receiveddate instanceof Date) {
                    this._dataStoreService.setData(
                        IntakeStoreConstants.receivedDate,
                        receiveddate
                    );
                } else if (receiveddate && receiveddate.format()) {
                    this._dataStoreService.setData(
                        IntakeStoreConstants.receivedDate,
                        receiveddate.format()
                    );
                }
            });
    }

    navigateToStatusPage() {
        const url = `/pages/person-details/edit/${
            this.selectedYouth?.Pid
            }/youth-status`;
        this._router.navigate([url]);
    }

    buildFormGroup() {
        this.departmentActionIntakeFormGroup = this.formBuilder.group(
            {
                Source: [''],
                InputSource: ['', Validators.required],
                RecivedDate: [
                    new Date(),
                    [Validators.required, Validators.minLength(1)]
                ],
                CreatedDate: [new Date()],
                Author: [''],
                LegalGuardian: [''],
                HeadofHousehold: [''],
                IntakeNumber: [''],
                Agency: ['all', Validators.required],
                Purpose: ['', Validators.required],
                PurposeName: [''],
                countyid: [''],
                countydesc: [''],
                IntakeService: [''],
                IntakeServiceSubtype: [''],
                voluntaryPlacementType: [''],
                otheragency: ['', Validators.maxLength(50)],
                isOtherAgency: false,
                islocalreferal: [0],
                iAndRsubtype: [''],
                referalcomments: [''],
                nonreferalreason: [''],
                queAdditionDate: [
                    new Date(),
                    [Validators.required, Validators.minLength(1)]
                ],
                receiveddelay: [''],
                submissiondelay: [''],
                /* Kinship Navigator */
                servicerequest: [[]],
                suggestedresource: [[]]
            },
            { validators: this.dateFormat }
        );
        this.generalResourceFormGroup = this.formBuilder.group({
            helpDescription: ['']
        });
        this.saoResponseForm = this.formBuilder.group({
            signedOffDate: ['', Validators.required]
        });
        this.dispositionDelayForm = this.formBuilder.group({
            fiveDaysDelay: [''],
            twentyFivedaysDelay: ['']
        });
        this.draftReasonFormGroup = this.formBuilder.group({
            draftReason: ['']
        });
        this._authService.setIntakeReadOnly(
            [this.departmentActionIntakeFormGroup,
            this.generalResourceFormGroup,
            this.saoResponseForm,
            this.dispositionDelayForm,
            this.draftReasonFormGroup
           ]);
        this.intakeTransferForm = this.formBuilder.group({
            approvedby: [null, Validators.required],
            sendingcountyid: [null],
            receivingcountysupervisor: [null],
            transferreason: [null, Validators.required],
            intakenumber: [this.intakeNumber],
            transferdate: [null],
            receivingcountyid: [null, Validators.required],
            approvalstatus: [null]
        });

        this.intakeTransferStatusForm = this.formBuilder.group({
            sendingcountyid: [null],
            approvedby: [null],
            transferreason: [null, Validators.required],
            intakenumber: [this.intakeNumber],
            transferdate: [null],
            receivingcountyid: [null, Validators.required],
            approvalstatus: [null],
            rejectionreason: [null],
            receivingcountysupervisor:[null],
            requestedby:[null],
            intaketransferid:[null]
        });

        this.intakeTransferAssignForm = this.formBuilder.group({
            approvalstatus:[null],
            sendingcountyid: [null],
            receivingcountyworker:[null, Validators.required],
            intakenumber:[null],
            intaketransferid:[null],
            approvedby: [null],
            receivingcountyid: [null],
            receivingcountysupervisor:[null],
            transferreason: [null]
        });
    }
    dateFormat(group: FormGroup) {
        if (
            group.controls.RecivedDate.value !== '' &&
            group.controls.RecivedDate.value !== null
        ) {
            if (group.controls.RecivedDate.value > new Date()) {
                return { futureDate: true };
            }
            return null;
        }
    }
    getSupervisorApprovalInfo() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        
        this.hideTransferBtn = false;
        const userinfo = this._authService.getCurrentUser();
        const currentuser = userinfo.user.securityusersid;
        this._http.post(CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CpsIntakeReport, {
            'intakenumber': this.intakeNumber,
            'isExpungementSuperUser': isExpungementSuperUser,
            'iscaseexpunged': this.iscaseexpunged
        }).subscribe((response) => {

            this._authService.addRemoveReadOnlyResources('INTAKE');
            this.readOnly = !(this._authService.readonlyButton('read_only_access', ''));

            this.submisionHistory = response && response.data ? response.data.getsupervisorapprovaldetails : [];
            this._dataStoreService.setData('submissionHistory',this.submisionHistory);


            const screenedincase = this.submisionHistory?.find((item: { status: string; }) => item.status === 'Accepted')
            if (screenedincase) {
                this.casealreadycreated = true
            } else {
                this.casealreadycreated = false
            }
            if (this.submisionHistory?.length >= 2) {
                this.hideTransferBtn = (!(this.submisionHistory[this.submisionHistory?.length-1].status == 'Review' && this.submisionHistory[this.submisionHistory?.length-1].intakerecommendation == 'Scrnin') && !(this.submisionHistory[this.submisionHistory?.length-1].supdecision == 'Return to Worker' && this.submisionHistory[this.submisionHistory?.length-1].status == this.inprogress && 
                this.submisionHistory[this.submisionHistory?.length-1].intakerecommendation == 'Scrnin') && (this.submisionHistory[this.submisionHistory?.length-2].supdecision == 'screenout') || (this.submisionHistory[this.submisionHistory?.length-2].supdecision == 'Scrnin') || (this.submisionHistory[this.submisionHistory?.length-2].supdecision == 'scrnin') || (this.submisionHistory[this.submisionHistory?.length-1].intakerecommendation == 'Scrnin' && this.submisionHistory[this.submisionHistory?.length-1].status == 'Review'));
            }
            const reviewSubmission = this.returnReviewSubmissionFn();

            if (reviewSubmission && reviewSubmission.fromid && reviewSubmission.fromid == currentuser) {
                this.selfApproval = true;
            }
            this.showaddendumnarrative = this.returnShowAddendumNarrativeFn();
            if (this.checkIfIsUnderReviewConditionFn()) {
                this.isUnderReview = true;
                this._dataStoreService.setData(IntakeStoreConstants.isaddendumnarrativeupdated,this.addendumnarrativeupdated);
            }

            if (this.submisionHistory && Array.isArray(this.submisionHistory)) {
                this.ifSubmisionHistoryConditionFn();

            }
            //This field is only for disposition tab to pull all status dropdown values for intake worker
            //So that user can see Accepted status for Closed cases           
            this.validateCountrIdFn();
        });
    }
    // Associated to getSupervisorApprovalInfo function
    private validateCountrIdFn() {
        const countyId = this.departmentActionIntakeFormGroup.getRawValue().countyid;
        const usercounty = this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.team.countyid;
        if (countyId && usercounty && countyId == usercounty) {
            this.issamecountyuser = true;
        } else {
            this.issamecountyuser = false;
        }
        this._dataStoreService.setData(IntakeStoreConstants.dispositionReadOnly, this.readOnly);
        if (this.readOnly) {
            this.departmentActionIntakeFormGroup.disable();
        }
        if (this._dataStoreService.getData(IntakeStoreConstants.SELECT_PERSON_TAB_INTAKE) && this.agencyTabOrder && this.agencyTabOrder.length > 0) {
            let personTab = this.agencyTabOrder.filter(agencyTab => agencyTab.id === 'person-cw');
            if (personTab && personTab.length > 0) {
                this.onTabClick(personTab[0]);
            }
            this._dataStoreService.setData(IntakeStoreConstants.SELECT_PERSON_TAB_INTAKE, false);
        }
    }

    // Associated to getSupervisorApprovalInfo function
    private ifSubmisionHistoryConditionFn() {
        const servNum = this.submisionHistory[0].servicerequestnumber;
        const isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        const isnavigatetonarrative = this.submisionHistory.find((item: { supdecision: string; eventcode: string; activeflag: number; }) => (item.supdecision === this.supDecisionNarrative && item.eventcode === 'INTR' && item.activeflag === 1));
        const returntoworker = this.submisionHistory.find((item: { supdecision: string; activeflag: number; }) => (item.supdecision === this.supDecisionWorker
            && item.activeflag == 1));
        if (returntoworker) {
            this.returntoworker = true;
        }
        if (isnavigatetonarrative) {
            this.navigatetonarrative = true;
        }

        if (isnavigatetonarrative && isSupervisor) {
            this.departmentActionIntakeFormGroup.controls.InputSource.enable();
            this.departmentActionIntakeFormGroup.controls.Purpose.disable();
        }
        if (this.returntoworker) {
            this.departmentActionIntakeFormGroup.controls.InputSource.enable();
            this.departmentActionIntakeFormGroup.controls.Purpose.disable();
        }
        //@Debashis :  When ever we change any think to Intake we make modify event code to XXXX is a change
        //  eventcode is INTR and status is acepted means you can not change anythink in Intake
        const initialCaseAssignment = this.submisionHistory.find((item: { typedescription: string; eventcode: string; }) => (item.typedescription === 'Reopen'
            || item.typedescription === 'Accepted' || item.typedescription === 'Closed'
            || item.typedescription === 'Routed to Servicecase') && item.eventcode === 'INTR');
        const navigatetonarrative = this.submisionHistory.find((item: { supdecision: string; eventcode: string; activeflag: number; }) => (item.supdecision === this.supDecisionNarrative) && item.eventcode === 'INTR' && item.activeflag === 1);
        const returnworker = this.submisionHistory.find((item: { typedescription: string; activeflag: number; }) => (item.typedescription === this.inprogress) && item.activeflag === 1 && !isSupervisor);
        this.checkTypeDescriptionFn(navigatetonarrative, isSupervisor, returnworker, initialCaseAssignment, servNum);
    }
    // Associated to getSupervisorApprovalInfo function
    private checkIfIsUnderReviewConditionFn() {
        return this.submisionHistory && this.submisionHistory?.length > 0 && (this.submisionHistory[this.submisionHistory?.length - 1].typedescription === 'Reopen' || this.submisionHistory[this.submisionHistory?.length - 1].typedescription === 'Review' || this.submisionHistory[this.submisionHistory?.length - 1].supdecision === this.supDecisionNarrative);
    }
    // Associated to getSupervisorApprovalInfo function
    private returnShowAddendumNarrativeFn(): any {
        return this.submisionHistory?.find((item: { supdecision: string; typedescription: string; }) => (item.supdecision === this.supDecisionNarrative || item.typedescription === this.inprogress));
    }
    // Associated to getSupervisorApprovalInfo function
    private returnReviewSubmissionFn() {
        return this.submisionHistory?.find((item: { typedescription: string; activeflag: number; eventcode: string; }) => item.typedescription === 'Review' && item.activeflag === 1 && item.eventcode === 'INTR');
    }
    // Associated to getSupervisorApprovalInfo function
    private checkTypeDescriptionFn(navigatetonarrative: any, isSupervisor: boolean, returnworker: any, initialCaseAssignment: any, servNum: any) {
        if (this.submisionHistory && this.submisionHistory?.length > 0 && (this.submisionHistory[this.submisionHistory?.length - 1].typedescription === 'Closed' || this.submisionHistory[this.submisionHistory?.length - 1].typedescription === 'Accepted')) {
            this.readOnly = true;
        } else if ((navigatetonarrative && isSupervisor) || returnworker) {
            this.readOnly = false;
        } else if (this.checkInitialCaseAssignmentFlafFn(initialCaseAssignment)) {
            this.readOnly = true;
        } else {
            this.readOnly = true;
            if (!servNum) {
                this.readOnly = !(this._authService.readonlyButton('read_only_access', ''));
            }
        }
    }
    // Associated to getSupervisorApprovalInfo function
    private checkInitialCaseAssignmentFlafFn(initialCaseAssignment: any) {
        if (initialCaseAssignment && initialCaseAssignment.typedescription === 'Accepted' && initialCaseAssignment.activeflag === 1) {
            return true;
        } else if (initialCaseAssignment && initialCaseAssignment.typedescription === 'Routed to Servicecase') {
            return true;
        } else if (initialCaseAssignment && initialCaseAssignment.typedescription === 'Reopen' && this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)) {
            return true;
        } else if (this.isPreIntake && this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)) { //if isPreIntake == false then code should be readonly
            return true;
        } else if (initialCaseAssignment && initialCaseAssignment.typedescription === 'Closed' && initialCaseAssignment.activeflag === 1) { //if isPreIntake == false then code should be readonly
            return true;
        } else {
            return false;
        }
    }

    private loadDroddowns() {
        this.getSupervisorApprovalInfo();
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 154, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            )
            .subscribe(data => {
                this.voluntaryPlacementDropDown = data;
            });
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {},
                NewUrlConfig.EndPoint.Intake.CommunicationUrl
            ),
            // this._commonHttpService.getArrayList(
            //     {},
            //     NewUrlConfig.EndPoint.Intake.IntakeServiceRequestInputTypeUrl
            // ),
            this._commonHttpService.getArrayList(
                {},
                NewUrlConfig.EndPoint.Intake.IntakeAgencies
            ),
            this._commonHttpService.create(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.MDCountryListUrl
            )
        ]).pipe(
            map(result => {
                return {
                    sourceList: result[0].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.intakeservreqinputsourceid
                            })
                    ),
                    agenciesList: result[1].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.teamtypekey,
                                additionalProperty: res.ismanualrouting
                            })
                    ),
                    countyList: result[2].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyid
                            })
                    )
                };
            }),
            share());
        this.intakeSourceList$ = source.pipe(pluck('sourceList'));
        this.intakeCountyList$ = source.pipe(pluck('countyList'));
        this.intakeCountyList$.subscribe(data => {
            this.intakeCountyList = data;


        });
        this.intakeAgencies$ = source.pipe(pluck('agenciesList'));
        this.intakeAgencies$.subscribe();
    }
    selectVoluntaryPlacement(_event: any) {
        this.setVolountaryStoreValues();
    }
    onChangeCounty(event: any) {
        this.setVolountaryStoreValues();
        this.departmentActionIntakeFormGroup.patchValue({ countydesc: event.label.trim() });
    }
    resetVPAStoreValues() {
        this._dataStoreService.setData('countyId', null);
        this._dataStoreService.setData('voluntryPlacementType', null);
        this._dataStoreService.setData('isEVPA', null);
    }
    getCountyId(id: any) {
        this.intakeCountyList$.subscribe(data => {
            this.intakeCountyList = data;
            const selectedCounty = this.intakeCountyList.find(county => county.value === id);
            if (selectedCounty) {

                this._dataStoreService.setData(
                    'countyId',
                    selectedCounty.text ? selectedCounty.text : null
                );
            } else {
                this._dataStoreService.setData(
                    'countyId',
                    null
                );
            }

        });
        return true;
    }
    getcountyname(id: any){
        const selectedCounty = this.intakeCountyList.find(county => county.value === id);
        if (selectedCounty) {

            return selectedCounty.text;
        
        
        }
    }
    setVolountaryStoreValues() {
        const countyId = this.departmentActionIntakeFormGroup.getRawValue()
            .countyid;
        this.getCountyId(countyId);
        const voluntryPlacementType = this.departmentActionIntakeFormGroup.getRawValue()
            .voluntaryPlacementType;
        this._dataStoreService.setData(
            'voluntryPlacementType',
            voluntryPlacementType
        );
        const placementFlag = (voluntryPlacementType === 'VPA') ? true : false;
        this._intakeConfig.isVoluntaryPlacementEnabled(placementFlag);

    }
    private listenForPersonChange() {
        this._dataStoreService.currentStore.subscribe(store => {
            if (store) {
                if (store[IntakeStoreConstants.addedPersons]) {
                    this.processSelectedYouth();
                    this.processLegalGuardian();
                    this.processFocusPerson();
                    this.checkSEN();
                }
                this.loadHTML = store[IntakeStoreConstants.loadHTML];
            }
        });
    }

    private loadDefaults() {
        this._dataStoreService.setData('intakenumber', this.intakeNumber);
        this.departmentActionIntakeFormGroup.patchValue({
            IntakeNumber: this.intakeNumber
        });
        this._authService.currentUser.subscribe(userInfo => {
            const currentAuthor = this.departmentActionIntakeFormGroup.get('Author')?.value;
            const isEmptyAuthor = !currentAuthor || currentAuthor.trim() === '';
            if (userInfo && userInfo.user && isEmptyAuthor) {
                this.departmentActionIntakeFormGroup.patchValue({
                    Author: userInfo.user.userprofile.displayname
                        ? userInfo.user.userprofile.displayname
                        : ''
                });
            }
        });
    }
    changeOtherAgency(event: any) {
        if (event.target.checked) {
            this.isDisplayOtherAgency = true;
        } else {
            this.isDisplayOtherAgency = false;
            this.departmentActionIntakeFormGroup.patchValue({
                otheragency: ''
            });
        }
    }
    listPurpose(agency: DropdownModel) {
        if (agency.value && agency.value !== 'all') {
            this.selectedAgency = Object.assign({}, new DropdownModel());
            const items = agency.value.split('~');
            this.selectedAgency.value = items[0];
            this.isManualRouting = items[1];
            if (this.selectedAgency.value === 'CW') {
                this.isManualRouting = this.roleId.user.userprofile
                    .ismanualrouting
                    ? this.roleId.user.userprofile.ismanualrouting + ''
                    : 'true';
            }
        } else {
            this.selectedAgency = agency;
        }

        this._dataStoreService.setData(
            IntakeStoreConstants.agency,
            this.selectedAgency.value
        );
        const teamtypekey = this.selectedAgency.value;
        this.departmentActionIntakeFormGroup.patchValue({
            Purpose: ''
        });
        this.intakeServiceGrid = false;
        this.intakeInfoNreffGrid = false;
        const checkInput = {
            nolimit: true,
            where: { teamtypekey: teamtypekey },
            method: 'get',
            order: 'description'
        };
        this.intakePurpose$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest(checkInput),
                NewUrlConfig.EndPoint.Intake.IntakePurposes + this.listfilterurl
            )
            .pipe(map(result => {
                if (this.selectteamtypekey) {
                    this.departmentActionIntakeFormGroup.controls[
                        'Purpose'
                    ].setValue(this.selectteamtypekey);
                    const items = this.selectteamtypekey.split('~');

                    if (items.length === 1) {
                        this.isPurposeWithAgency = false;
                    }
                }
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.description,
                            value: res.intakeservreqtypeid,
                            additionalProperty: 'CW'
                        })
                );
            }));
        this._dataStoreService.setData(
            IntakeStoreConstants.intakeServiceGrid,
            this.intakeServiceGrid
        );
    }

    listService(purpose: any) {
        this.currentPurposeValue = purpose.value;
        if (purpose.label && purpose.label !== '') {
            this.isRFS =
                this.isAS && purpose.label === this.requestforservices
                    ? true
                    : false;
        }
        this.intakeServiceGrid = false;
        this.intakeInfoNreffGrid = false;
        this._dataStoreService.setData(
            IntakeStoreConstants.ChildProtection,
            false
        );
        if (purpose && purpose.label === this.requestforservices) {
            (<any>$('#intakeNarrative')).click(); // NOSONAR
            this._dataStoreService.setData(
                IntakeStoreConstants.ChildProtection,
                true
            );
        }
        if (purpose.value) {
            this.isPurposeChanged = true;
            const items = purpose.value.split('~');
            const serDescription = items[0];
            const purposeobj: any = this.getSelectedPurpose(serDescription);
            this._dataStoreService.setData(
                IntakeStoreConstants.purposeSelected,
                {
                    text: purposeobj.description,
                    value: serDescription,
                    code: purposeobj.intakeservreqtypekey
                }
            );
            this.selectteamtypekey = serDescription;
            this.needSubmissionHistory =  !(this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL));
            this.checkIfIsCWFn(serDescription);
            this.ifPurposeValueFn(serDescription);
        } else {
            this.intakeServiceGrid = false;
        }
        this.initializeTabs();
        this._dataStoreService.setData(
            IntakeStoreConstants.intakeServiceGrid,
            this.intakeServiceGrid
        );
    }
    // Associated to listService function
    private ifPurposeValueFn(serDescription: any) {
        if (this.ifSerDescriptionConditionFn(serDescription)) {
            this.intakeservice = [];
            this.intakeServiceGrid = true;
            this._commonHttpService
                .getArrayList(
                    new PaginationRequest({
                        nolimit: true,
                        where: {
                            teamtypekey: this.selectedAgency
                                ? this.selectedAgency.value
                                : '',
                            activeflag: 1,
                            intakeservreqtypeid: serDescription
                        },
                        method: 'get'
                    }),
                    NewUrlConfig.EndPoint.Intake.Intakeservs +
                    this.listfilterurl
                )
                .subscribe(
                    result => {
                        this.intakeServsApiResponseFn(result);
                    },
                    err => {
                        console.error(err);
                    }
                );
        } else if (serDescription === '619c4dcf-ef22-4fc4-9269-d7678e8a8f6a') {
            this.intakeInfoReffTypes = [];
            this.intakeInfoNreffGrid = true;
            this._commonHttpService
                .getArrayList(
                    new PaginationRequest({
                        nolimit: true,
                        where: {
                            teamtypekey: this.selectedAgency
                                ? this.selectedAgency.value
                                : '',
                            activeflag: 1,
                            intakeservreqtypeid: serDescription
                        },
                        method: 'get'
                    }),
                    NewUrlConfig.EndPoint.Intake.Intakeservs +
                    this.listfilterurl
                )
                .subscribe(
                    result => {
                        this.intakeInfoReffTypes = result;
                    },
                    err => {
                        console.error(err);
                    }
                );
        }
    }
    // Associated to listService function
    private ifSerDescriptionConditionFn(serDescription: any) {
        return serDescription === 'd207bdd4-f281-4ec8-949c-8fd9657227f9' || serDescription === '9d1c2be9-72af-4527-a603-45913feff080'  ||
        serDescription === '7933508f-0350-4552-be50-350598a387a7';
    }
    // Associated to listService function
    private checkIfIsCWFn(serDescription: any) {
        if (this.isCW) {
            this.listServiceSubtype(serDescription);
        }
    }
    // Associated to listService function
    private intakeServsApiResponseFn(result: any[]) {
        if (result && result.length > 4) {
            const temp = result[2];
            result[2] = result[3];
            result[3] = temp;
        }
        const subServices = ["Informal","Formal" ]
                            this.intakeServices = result.filter((service) => !subServices.includes(service.description)).sort((a, b) => a.intakeservid > b.intakeservid ? 1 : -1 );
                            this.intakeSubServices = result.filter((service) => subServices.includes(service.description)); 

        const general = this.store[IntakeStoreConstants.general];
        if (this.isCW && general && general.intakeservice.length) {
            if (general.intakeservice.length > 0 &&
                general.intakeservice[0].intakeservtypekey &&
                general.intakeservice[0].intakeservtypekey === 'NONCPS') {
                this.departmentActionIntakeFormGroup.disable();
            }
            this.selectedIntakeServices = [];
            this.intakeServsApiIfGeneralFn(general);
        }
    }
    // Associated to listService function
    private intakeServsApiIfGeneralFn(general: any) {
        if(general?.intakeservice?.[0]?.description === 'I&R' || general?.intakeservice?.[0]?.description === 'Kinship Navigation Services') {
            this.intakeServicesRequired = false;
        }
        this.intakeServices.forEach(res => {
            if (res.description === general.intakeservice[0].description) {
                this.selectedIntakeServices.push(res);
                this.intakeservicesubtype =
                    general.intakeservice[0].intakesubservice;
        this.isVoluntaryPlacement = !!(this.intakeservicesubtype &&
                                                this.intakeservicesubtype.find(
                                                    subtype => subtype.intakeservsubtypekey ===
                                                    'VP'
                                                ));
               
                this._intakeConfig.isVoluntaryPlacementEnabled(this.isVoluntaryPlacement);
                if (this.intakeservicesubtype &&
                    (this.intakeservicesubtype[0]
                        .intakeservsubtypekey ===
                        'INRL' ||
                        this.intakeservicesubtype[0]
                            .intakeservsubtypekey ===
                        'FKC' ||
                        this.intakeservicesubtype[0]
                            .intakeservsubtypekey ===
                        'SGP' ||
                        res.intakeservtypekey === 'NONCPS')) {
                    this.kinshipNavigator = this.intakeservicesubtype[0].typedescription;
                }

    this.isIndependentLiving = !!(this.intakeservicesubtype &&
                    this.intakeservicesubtype.find(
                        subtype => subtype.intakeservsubtypekey ===
                            'ILAC'
                    ));
                
            }
        });
    }

    selectService(event: any, selectedItem: any, Type: any) {

        this.intakeServicesRequired=false
        if(Type === 'intakeIandRSubtype'){
            const label = event.value ?? '';

            selectedItem = {
                "intakeservsubtype": [],
                "intakeservid": 'a6114db3-48b8-43dc-bdfe-7efb327cc0ba',
                "description": label,
                "intakeservtypekey": null
            }
        } else {
            this.iandrCheck=false;
        }        
        this.serviceCheckboxId = '';
        this.selectedCheckbox = selectedItem.description;
        if(selectedItem?.description =='I&R' && selectedItem?.intakeservid=='a6114db3-48b8-43dc-bdfe-7efb327cc0ba'){
            this.iandrCheck=true;
            this.intakeServicesRequired = false
        }
        if(selectedItem?.description =='Kinship Navigation Services'){
            this.intakeServicesRequired = false
        }

        this.kinshipNavigator = null;
        this.emptyKinship();
        this.handleToCheckTypeFn(Type, event, selectedItem);
        this.departmentActionIntakeFormGroup.controls['voluntaryPlacementType'].reset();
        this.departmentActionIntakeFormGroup.controls['voluntaryPlacementType'].clearValidators();
        this.departmentActionIntakeFormGroup.controls['voluntaryPlacementType'].updateValueAndValidity();
        if(Type === 'intakeServices' && selectedItem?.description === this.kinshipstring){
            this.departmentActionIntakeFormGroup.controls['iAndRsubtype'].patchValue('');
        }
        this._intakeConfig.isVoluntaryPlacementEnabled(false);
        this.isVoluntaryPlacement = false;
        this.isIndependentLiving = false;

            const intakeServices = this.intakeservice.filter(item => item.intakeservid);
                this._dataStoreService.setData(
                    IntakeStoreConstants.intakeService,
                    intakeServices
                );
    }
    // Associated to selectService function
    private handleToCheckTypeFn(Type: any, event: any, selectedItem: any) {
        if (Type === 'intakeServices') {
            this.isIAndRSelected = this.iandrCheck && event.target.checked;
            this.intakeIandRservice = [];
        }
        if ((Type === 'intakeIandRSubtype' && (event?.value === 'formal' || event?.value === 'informal')) || event.target.checked) {
            this.checkRoleConditionFn(selectedItem, Type);

            this._router.navigate(['./narrative'], { relativeTo: this.route });
            this.current_route = 'narrative';
        } else {
            this.selectServiceElseConditionFn(selectedItem);
            if (Type === '') {
                this.intakeIandRservice = this.handleIntakeServiceDataFn(selectedItem, this.intakeIandRservice);
            } else {
                this.intakeservice = this.handleIntakeServiceDataFn(selectedItem, this.intakeservice);
            }
        }
    }
    // Associated to selectService function
    private handleIntakeServiceDataFn(selectedItem: any, data: any) {
        return data.map((item: any) => {
            if (item.intakeservid !== selectedItem.intakeservid) {
                return item;
            } else {
                return new IntakeService();
            }
        });
    }

    private checkRoleConditionFn(selectedItem: any, Type: any) {
        if (this.isCW) {
            this.ifCWInSelectServiceFn(selectedItem, Type);
        } else {
            const intakeItem = this.intakeservice.filter((item) => item.description === selectedItem.description);
            if (!intakeItem.length) {
                this.intakeservice.push(selectedItem);
            }
        }
        const role = this._authService.getCurrentUser();
        if (role.role.name !== AppConstants.ROLES.SUPERVISOR) {
            if (selectedItem.assessmenttemplateid) {
                this.serviceCheckboxId = selectedItem.intakeservid;
                (<any>$('#assessment-tab')).click(); // NOSONAR
                this._dataStoreService.setData(
                    IntakeStoreConstants.intakeService,
                    this.intakeservice
                );
            }
        }
    }

    // Associated to selectService function
    private selectServiceElseConditionFn(selectedItem: any) {
        if (this.isCW && selectedItem.description === this.cpshistoryclearance) {
            if (this.agencyTabOrder.length &&
                this.agencyTabOrder.length > 1 &&
                this.agencyTabOrder[2].id === this.historyclearance) {
                this.agencyTabOrder.splice(2, 1);
                this.showSubmit = false;
            }
        } else if (this.isCW && selectedItem.description === this.privateadoptionsubsidy
            && this.agencyTabOrder.length && this.agencyTabOrder.length > 1 &&
            this.agencyTabOrder[2].id === this.adoptionsubsidy) { this.agencyTabOrder.splice(2, 1); }
        if (selectedItem.intakeservsubtype &&
            selectedItem.intakeservsubtype.length) {
            const selectedService = <IntakeService>selectedItem;
            const selServIndex = this.selectedIntakeServices.indexOf(
                selectedService
            );
            if (selServIndex !== -1) {
                this.selectedIntakeServices.splice(selServIndex, 1);
            }
        }
    }
    // Associated to selectService function
    private ifCWInSelectServiceFn(selectedItem: any, Type: any) {
        this.intakeservicesubtype = [];
        if (this.agencyTabOrder.length && this.agencyTabOrder.length > 1 &&
            this.agencyTabOrder[2].id === this.adoptionsubsidy &&
            selectedItem.description !== this.privateadoptionsubsidy) { this.agencyTabOrder.splice(2, 1); }
        if (this.agencyTabOrder.length && this.agencyTabOrder.length > 1 &&
            this.agencyTabOrder[2].id === this.historyclearance &&
            selectedItem.description !== this.cpshistoryclearance) {
            this.agencyTabOrder.splice(2, 1);
            this.showSubmit = false;
        }
        if (Type === 'intakeServices') {
          this.intakeservice = []; 
        }
        this.intakeservice.push(selectedItem);
        this.handleSetDataFn(selectedItem);
        this.kinshipNavigator = null;
        if (selectedItem.intakeservsubtype &&
            selectedItem.intakeservsubtype.length) {
            this.selectedIntakeServices.push(<IntakeService>(
                selectedItem
            ));
        } else{
            this.selectedIntakeServices =[];
        }
        if (selectedItem.description === this.inhomeservices) {
            // (<any>$('#ihm-sub-type-popup')).modal('show');
            // this.departmentActionIntakeFormGroup.controls[
            //     'IntakeServiceSubtype'
            // ].setValidators([Validators.required]);
            this.departmentActionIntakeFormGroup.controls['IntakeServiceSubtype'].updateValueAndValidity();
        } else {
            this.departmentActionIntakeFormGroup.controls['IntakeServiceSubtype'].clearValidators();
            this.departmentActionIntakeFormGroup.controls['IntakeServiceSubtype'].updateValueAndValidity();
        }
        if (selectedItem.description === this.cpshistoryclearance) {
            this.isClearenceHistory = true;
            const intakeTabConfigData = IntakeTabConfig.find((item: any) => item.id === this.historyclearance);
            if(intakeTabConfigData) {
                this.agencyTabOrder.splice(
                    2,
                    0,
                    intakeTabConfigData
                );
            }
            this.showSubmit = false;
        } else {
            this.cpshistoryclearanceElseFn(selectedItem);
        }
    }
    // Associated to selectService function
    private handleSetDataFn(selectedItem: any) {
        if (selectedItem?.description === "I&R") {
            this._dataStoreService.setData('showRequesterDetails', true);
        } else {
            this._dataStoreService.setData('showRequesterDetails', false);
        }
        if (this.intakeservice.find(item => item.description === this.cpshistoryclearance)) {
            this._dataStoreService.setData('isCPSHistoryClearanceChecked', true);
        } else {
            this._dataStoreService.setData('isCPSHistoryClearanceChecked', false);
        }
        if (['formal', 'informal', 'I&R', this.kinshipstring].includes(selectedItem?.description)) {
            this.kinshipNavigator = this.newPurpose?.label || this.kinshipnavigation;
        }
    }

    // Associated to ifCWInSelectServiceFn function
    private cpshistoryclearanceElseFn(selectedItem: any) {
        if (this.agencyTabOrder.length && this.agencyTabOrder.length > 1 &&
            this.agencyTabOrder[2].id === this.adoptionsubsidy &&
            selectedItem.description !== this.privateadoptionsubsidy) { this.agencyTabOrder.splice(2, 1); } else if (selectedItem.description === this.privateadoptionsubsidy) {
                const intakeTabConfigData = IntakeTabConfig.find(
                    item => item.id === this.adoptionsubsidy
                );
                if(intakeTabConfigData) {
                    this.agencyTabOrder.splice(
                        2,
                        0,
                        intakeTabConfigData
                    );
                }
            }
    }

    selectIntakeServiceSubType(event: any,_selectedServiceTypeItem: any,selectedServiceSubTypeItem: any) {
        if (event.target.checked) {
            this.isSubTypeSelected = true;
            this.intakeServiceSubtypeChecked(selectedServiceSubTypeItem);
        } else {
            this.isSubTypeSelected = false;
            this.intakeServiceSubtypeUnchecked(selectedServiceSubTypeItem);
        }
        this.departmentActionIntakeFormGroup.controls['voluntaryPlacementType'].reset();
        this.departmentActionIntakeFormGroup.controls['voluntaryPlacementType'].clearValidators();
        this.departmentActionIntakeFormGroup.controls['voluntaryPlacementType'].updateValueAndValidity();
        this._intakeConfig.isVoluntaryPlacementEnabled(false);
    }

    intakeServiceSubtypeUnchecked(selectedServiceSubTypeItem: any) {
        if (selectedServiceSubTypeItem.intakeservsubtypekey === 'VP') {
            this.isVoluntaryPlacement = false;
            this._dataStoreService.setData('voluntryPlacementType', null);
        }
        if (selectedServiceSubTypeItem.intakeservsubtypekey === 'ILAC') {
            this.isIndependentLiving = false;
        }
        this.intakeservicesubtype = [];
        this.kinshipNavigator = null;
        this.emptyKinship();
    }

    intakeServiceSubtypeChecked(selectedServiceSubTypeItem: any) {
        if (selectedServiceSubTypeItem.intakeservsubtypekey === 'VP') {
            this.isVoluntaryPlacement = true;
        } else {
            this.isVoluntaryPlacement = false;
            this._dataStoreService.setData('voluntryPlacementType', null);
        }

        if (selectedServiceSubTypeItem.intakeservsubtypekey === 'ILAC') {
            this.isIndependentLiving = true;
        } else {
            this.isIndependentLiving = false;
        }
        this.intakeservicesubtype = [];
        this.intakeservicesubtype.push(selectedServiceSubTypeItem);
        this.intakeservice[0].intakesubservice = Object.assign(
            [],
            this.intakeservicesubtype
        );
        if (
            selectedServiceSubTypeItem.intakeservsubtypekey === 'INRL' ||
            selectedServiceSubTypeItem.intakeservsubtypekey === 'FKC' ||
            selectedServiceSubTypeItem.intakeservsubtypekey === 'SGP'
        ) {
            this.kinshipNavigator =
                selectedServiceSubTypeItem.typedescription;
        } else {
            this.kinshipNavigator = null;
            this.emptyKinship();
        }
    }

    emptyKinship() {
        this.departmentActionIntakeFormGroup.patchValue({
            islocalreferal: '',
            referalcomments: '',
            nonreferalreason: '',
            servicerequest: '',
            suggestedresource: ''
        });
    }

    isSelectedSubtypeItems(modal: any) {
        
        if(!(this.intakeservicesubtype && this.intakeservicesubtype.length > 0 && this.intakeservicesubtype[0]?.intakeservsubtypekey=='SGP' && this.submisionHistory )){
            this.filterNonSGPTypeFn();
        }       
        const index = this.intakeservicesubtype
            ? this.intakeservicesubtype.findIndex(
                item =>
                    item.intakeservsubtypekey === modal.intakeservsubtypekey
            )
            : -1;
        if (index >= 0) {
            return true;
        } else {
            return false;
        }
    }
    // Assosiated to isSelectedSubtypeItems function
    private filterNonSGPTypeFn() {
        const subtypeList = this.selectedIntakeServices[0]['intakeservsubtype'];
        for (let i = subtypeList.length - 1; i >= 0; i--) {
            if (subtypeList[i].intakeservsubtypekey === 'SGP') {
                subtypeList.splice(i, 1);
            }
        }
    }

    viewAssessment(_modal: any) {
        (<any>$('#assessment-tab')).click(); // NOSONAR
    }

    isSelectedItems(modal: any, type: any) {
        const services = type === 'intakeSubServices' ? this.intakeIandRservice : this.intakeservice;
        const index = services.findIndex(
            item => (item.intakeservid === modal.intakeservid || (item.intakeservtypekey && item.intakeservtypekey === modal.intakeservtypekey ) )
            // intakeservtypekey is null for I&R services. Therefore, gotta use intakeservid for uniqueness
        );
        if (index >= 0) {
            return true;
        } else {
            return false;
        }
    }

    savenAssignPreIntake() {
        const data = this.store[IntakeStoreConstants.preIntakeSupDicision];
        if (data === 'Approved' || data === 'Rejected') {
            this.preIntakeSupDicision = data;
        }
        if (this.preIntakeSupDicision === 'Approved') {
            const Istatus = 10; // Approved
            this.referralSubmission = this._intakeConfig.isFlowToCaseSupervisor();
            if (this.referralSubmission) {
                this.submitIntakeFromReferral(
                    this._intakeConfig.selectedPurpose,
                    'INTR'
                );
            } else {
                const intakeWorkerId = this.store[
                    IntakeStoreConstants.assingedIntakeWokerId
                ];
                if (intakeWorkerId) {
                    this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(),'DRAFT', true);
                    setTimeout(() => this.assignIntaker('SITR', Istatus), 3000);
                } else {
                    this._alertService.warn('Please select a intake worker');
                }
            }
        } else if (this.preIntakeSupDicision === 'Rejected') {
            const Istatus = 3; // Rejected
            this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(), 'DRAFT', true);
            setTimeout(() => this.assignIntaker('SITR', Istatus), 3000);
        } else {
            this._alertService.warn('Please select a status.');
        }
    }

    submitIntakeFromReferral(selectedPurpose: any, appevent: string) {
        const disposition = this.store[IntakeStoreConstants.createdCases];
        if (
            selectedPurpose ===
            MyNewintakeConstants.REFERRAL.WAIVER_FROM_ADUL_COURT
        ) {
            disposition.forEach((dis: any) => {
                dis.DADisposition = 'FPTSAO';
                dis.supDisposition = 'FPTSAO';
                dis.dispositioncode = 'FPTSAO';
                dis.supStatus = 'Approved';
                dis.DAStatus = 'Approved';
                dis.intakeserreqstatustypekey = 'Approved';
                dis.DaTypeKey = dis.serviceTypeID;
                dis.DasubtypeKey = dis.subServiceTypeID;
                dis.ServiceRequestNumber = dis.caseID;
            });
        } else if (
            selectedPurpose ===
            MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION
        ) {
            disposition.forEach((dis: any) => {
                dis.DADisposition = 'PCS';
                dis.supDisposition = 'PCS';
                dis.dispositioncode = 'PCS';
                dis.supStatus = 'Approved';
                dis.DAStatus = 'Approved';
                dis.intakeserreqstatustypekey = 'Review';
                dis.DaTypeKey = dis.serviceTypeID;
                dis.DasubtypeKey = dis.subServiceTypeID;
                dis.ServiceRequestNumber = dis.caseID;
            });
        } else if (
            selectedPurpose === MyNewintakeConstants.REFERRAL.INTERSTATE_COMPACT
        ) {
            disposition.forEach((dis: any) => {
                dis.DADisposition = 'PCSICJRP';
                dis.supDisposition = 'PCSICJRP';
                dis.dispositioncode = 'PCSICJRP';
                dis.supStatus = 'Approved';
                dis.DAStatus = 'Approved';
                dis.intakeserreqstatustypekey = 'Review';
                dis.DaTypeKey = dis.serviceTypeID;
                dis.DasubtypeKey = dis.subServiceTypeID;
                dis.ServiceRequestNumber = dis.caseID;
            });
        }
        this._dataStoreService.setData(
            IntakeStoreConstants.disposition,
            disposition
        );
        this.approveIntake(new General(), appevent);
    }

    checkfordelay(modal: any, appeventcode: any) {
        const recivedDate = new Date(modal.RecivedDate);
        const currentDate = new Date();
        const status = appeventcode === 'INTR' ? 'supreview' : '';
        const receiveddelayreason = '';
        this.generalRecievedDate = null;
        if ((status === 'supreview' && appeventcode === 'INTR') || appeventcode === 'DRAFT') {
            if (recivedDate.getTime() + 5 * 24 * 60 * 60 * 1000 <= currentDate.getTime()) {
                this.generalRecievedDate = {
                    isreceiveddelay: true,
                    issubmitdelay: false,
                    message: 'Received date greater than 5 days'
                };
            }
            if (recivedDate.getTime() + 25 * 24 * 60 * 60 * 1000 <= currentDate.getTime()) {
                this.generalRecievedDate = {
                    isreceiveddelay: false,
                    issubmitdelay: true,
                    message: 'Submitted date greater than 25 days'
                };
            }
        }
    }
    submitIntake(modal: General, appevent: string, isApprove: boolean) {
        this.checkforrequired = true;
        if (isApprove) {
    const disposition = this.store[IntakeStoreConstants.disposition];
    if (!disposition?.length || !disposition[0]?.supDisposition) {
        this._alertService.error('Please select Supervisor Decision');
        return;
    }

            this.disableApproveBtn = true;
        }
        this.getcommonInvolvedPerson();
        const addedPersons = this.store[IntakeStoreConstants.addedPersons] ? this.store[IntakeStoreConstants.addedPersons] : [];
        const intakesdmcheck = this.store[IntakeStoreConstants.intakeSDM];
        const cpsresponseType: any = intakesdmcheck?.cpsResponseType === 'CPS-AR' || intakesdmcheck?.cpsResponseType === 'CPS-IR';
        if (intakesdmcheck?.screeningRecommend === 'accept_as_noncps' && this.returntoworker && this.caseNumber) {
            this._alertService.error('Case cannot be converted to Non CPS as there is a CPS case already connected with this intake');
            this.disableApproveBtn = false;
            return;
        }
        if(!['ROACPS', 'Information and Referral', 'Request for services'].includes(this.store[IntakeStoreConstants.purposeSelected]?.code)) {
        const quickPersonsHistory = this.store[IntakeStoreConstants.quickPersonsHistory] ? this.store[IntakeStoreConstants.quickPersonsHistory] : [];
        const validPersonsForAV = addedPersons.filter((person: any) => {
            const rolesAV = person.personRole.find((item: { rolekey: string; }) => item.rolekey === 'AV');
            return this.reusableValidPersonConditionFn(rolesAV);
        });
        const validPersonsForAM = addedPersons.filter((person: any) => {
            const rolesAM = person.personRole.find((item: { rolekey: string; }) => item.rolekey === 'AM');
            return this.reusableValidPersonConditionFn(rolesAM);
        });
        const validPersonsForCHILD = addedPersons.filter((person: any) => {
            const rolesCH = person.personRole.find((item: { rolekey: string; }) => item.rolekey === 'CHILD');
            return this.reusableValidPersonConditionFn(rolesCH);
        });
        this.quickPersonsHistoryFIlterFn(quickPersonsHistory, validPersonsForAV, validPersonsForAM, validPersonsForCHILD);

        let validPersonsForIPL = false;
    validPersonsForIPL = validPersonsForAV.length && validPersonsForAM.length && validPersonsForCHILD.length;

        if (!validPersonsForIPL && (cpsresponseType)) {
            return this.checkCpsResponseTypeConditionFn(validPersonsForAV, validPersonsForAM)
        }
    }
        if (this.intakeServicesRequired && modal.PurposeName === 'Kinship Navigation') {
            this._alertService.warn('Please select Kinship Navigation type');
            return;
        }

        this.handleIsarOrIsirFn(intakesdmcheck, appevent, isApprove, cpsresponseType);
    }
    private handleIsarOrIsirFn(intakesdmcheck: any, appevent: string, isApprove: boolean, cpsresponseType: any) {
        if ((intakesdmcheck?.isar || intakesdmcheck?.isir) && (cpsresponseType)) {
            this.getInvolvedPerson(appevent, isApprove);
        } else {
            this.newSubmitIntake(appevent, isApprove);
        }
    }

    // Associated to submitIntake function
    private reusableValidPersonConditionFn(data: any[]) {
        if (data) {
            return true
        } else {
            return false;
        }
    }
    // Associated to submitIntake function
    private quickPersonsHistoryFIlterFn(quickPersonsHistory: any, validPersonsForAV: any, validPersonsForAM: any, validPersonsForCHILD: any) {
        quickPersonsHistory?.filter((person: any) => {
            const rolesAV = person?.quickpersonroleconfig?.find((item: { actortypekey: string; }) => item.actortypekey === 'AV');
            if (rolesAV) {
                validPersonsForAV.push(person);
                return true;
            } else {
                return false;
            }
        });
        quickPersonsHistory?.filter((person: any) => {
            const rolesAM = person?.quickpersonroleconfig?.find((item: { actortypekey: string; }) => item.actortypekey === 'AM');
            if (rolesAM) {
                validPersonsForAM.push(person);
                return true;
            } else {
                return false;
            }
        });
        quickPersonsHistory?.filter((person: any) => {
            const rolesCH = person?.quickpersonroleconfig?.find((item: { actortypekey: string; }) => item.actortypekey === 'CHILD');
            if (rolesCH) {
                validPersonsForCHILD.push(person);
                return true;
            } else {
                return false;
            }
        });
    }
    // Associated to submitIntake function
    private checkCpsResponseTypeConditionFn(validPersonsForAV: any[], validPersonsForAM: any[]) {
        if(!validPersonsForAV.length && !validPersonsForAM.length){
            this._alertService.error('Alleged Maltreator and Alleged Victim are mandatory to submit for supervisor Approval.');
        }else if(!validPersonsForAV.length){
            this._alertService.error('Alleged Victim is mandatory to submit for supervisor Approval.');
        }else if(!validPersonsForAM.length){
            this._alertService.error('Alleged Maltreator is mandatory to submit for supervisor Approval.');
        }else {
            this._alertService.error('CHILD is mandatory to submit for supervisor Approval.');
        }
        return false;
    }

    newSubmitIntake(appevent: string, isApprove: boolean) {
        let modal = this.departmentActionIntakeFormGroup.getRawValue();
        this.isIntakeApprove = isApprove;
        if (this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.CHILD_PROTECTION_SERVICES)) {
            this.checkfordelay(modal, appevent);
            if (this.generalRecievedDate && (this.generalRecievedDate.isreceiveddelay || this.generalRecievedDate.issubmitdelay)) {
                const form = this.dispositionDelayForm.getRawValue();
                this.reasonForDelayFn(form);
            }
        } else {
            modal.receiveddelay = 'N/A';
            modal.submissiondelay = 'N/A';
        }
        if (this.store[IntakeStoreConstants.addNarrative]) {
            this.ifAddNarrativeConditionFn(modal);
        }
        if(['ROACPS', 'Information and Referral', 'Request for services'].includes(this.store[IntakeStoreConstants.purposeSelected]?.code)) {
            this.checkValidation = this.sdmValidation();
        } else {
            this.checkValidation = this.conditionalValidation();
        }
        const disposition = this.store[IntakeStoreConstants.disposition];

        /*
        // Family case validtion now happeing on approve intake api itself
         if (this.checkValidation && this.roleId.user.userprofile.teamtypekey === 'CW' && this.roleId.role.name === AppConstants.ROLES.SUPERVISOR) {
            if (this.intakeservicesubtype && this.intakeservicesubtype.filter((item) => item.intakeservsubtypekey === 'FPS').length && disposition[0].supStatus === 'Approved') {
                this.getPrior(this.intakeNumber);
                (<any>$('#priorDetails')).modal('show');
                this.checkValidation = false;
            }
        } */
        this.checkValidationFn(isApprove, disposition, modal, appevent);
    }
    // Associated to newSubmitIntake function
    private reasonForDelayFn(form: any) {
        if (
            (this.generalRecievedDate?.isreceiveddelay && (form?.fiveDaysDelay?.length === 0)) || 
            (this.generalRecievedDate?.issubmitdelay && (form?.twentyFivedaysDelay?.length === 0))
        ) {
            (<any>$(this.reasonfordelaypopupid)).modal('show'); // NOSONAR
        }
    }
    // Associated to newSubmitIntake function
    private checkValidationFn(isApprove: boolean, disposition: any, modal: General, appevent: string) {
        if (this.checkValidation) {
            // Added rejected status (to visible in intake worker dashboard)
            if (isApprove && disposition[0].supStatus !== 'Reopen') {
                this.ifNotReopenFn(modal, appevent);
            } else {
                this.mainIntake(modal, appevent, true, true);
            }
        } else {
            this.disableApproveBtn = false;
        }
    }
    // Associated to newSubmitIntake function
    private ifNotReopenFn(modal: General, appevent: string) {
        if (this.userRole && this.userRole.user && this.userRole.user.userprofile && this.userRole.user.userprofile.displayname) {
            if (this.userRole.user.userprofile.displayname === modal.Author) {
                this._alertService.error('Please request a different supervisor to approve the Intake you created.');
            }
            else {
                this.approveIntake(modal, appevent);
            }
        }
        else {
            this._alertService.error('Current User info is missing, please try from dashboard again');
        }
    }
    // Associated to newSubmitIntake function
    private ifAddNarrativeConditionFn(modal: General) {
        modal.requesteraddress1 = this.store[IntakeStoreConstants.addNarrative].requesteraddress1;
        modal.requesteraddress2 = this.store[IntakeStoreConstants.addNarrative].requesteraddress2;
        modal.requestercity = this.store[IntakeStoreConstants.addNarrative].requestercity;
        modal.requesterstate = this.store[IntakeStoreConstants.addNarrative].requesterstate;
        modal.requestercounty = this.store[IntakeStoreConstants.addNarrative].requestercounty;
        modal.requestercountyname = this.store[IntakeStoreConstants.addNarrative].requestercountyname;
        modal.isacknowledgementletter = this.store[IntakeStoreConstants.addNarrative].isacknowledgementletter
            ? 1
            : 0;
    }

    submitReviewIntake() {
        const disposition = this.store[IntakeStoreConstants.disposition];
        if (this.selectedSupervisor) {
            this.finalIntake.review.assignsecurityuserid = this.selectedSupervisor;
            this.finalIntake.review.ismanualrouting = true;
            if (this.roleId.role.key) {
                this.finalIntake.intake.userrole = this.roleId.role.key;
            }
            if (disposition[0].intakeserreqstatustypekey === 'Closed') {
                this.approveIntake(this.departmentActionIntakeFormGroup.value, 'INTR');
                this._alertService.success(this.intakesubmitmsg, true);
            } else {
                if(this.returntoworker){     
                    this.finalIntake.intake.General.isoverriderequest =true;             
                    const casedetails =this._dataStoreService.getData(IntakeStoreConstants.SELECTED_INTAKE_CASE_DETAILS);
                    if(casedetails){
                    this.finalIntake.intake.General.casedetails =casedetails;
                    }

                } else{
                    this.finalIntake.intake.General.isoverriderequest = false;
                }
                this.createIntake(this.finalIntake, true).subscribe();
                this._alertService.success(this.intakesubmitmsg, true);
                setTimeout(() => {
                    this._router.navigate([this.saveintakeurl]);
                }, 1000);
            } 
            (<any>$('#list-supervisor')).modal('hide');// NOSONAR
        } else {
            this._alertService.error('Please select Supervisor');
        }
    }

    submitIntakewithIntakers(Intaker: string) {
        if (Intaker === '1') {
            if (this.selectedIntaker) {
                this.finalIntake.review.assignIntakeuserid = this.selectedIntaker;
                this.finalIntake.review.ismanualrouting = true;
                this.createIntake(this.finalIntake, true).subscribe();
                (<any>$('#list-intaker')).modal('hide');// NOSONAR
            } else {
                this._alertService.error('Please select Intertaker');
            }
        } else {
            this.createIntake(this.finalIntake, true).subscribe();
            (<any>$('#list-intaker')).modal('hide');// NOSONAR
        }
    }

    submitPreIntake(modal: General, appevent: string) {
        if (this.isDjs) {
            const message = this._intakeConfig.djsInfoValidation();
            if (message.status) {
                this.djsValidationMessages = message;
                const nojury = message.No_Jurisdiction.map((data, index) => {
                    return this.reusableNojuryInsuffinfoFn(index, data);
                });
                const insuffinfo = message.Insufficient_Information.map(
                    (data, index) => {
                        return this.reusableNojuryInsuffinfoFn(index, data);
                    }
                );
                const nojuryhtml = `<div class="col-sm-12" *ngIf="message?.No_Jurisdiction?.length > 0">
                <h4> No Jurisdiction</h4>
                <ul class="mat-error" >
                        ${nojury.toString()}
                </ul>
        </div>`;
                const insufficehtml = `
        <div class="col-sm-12" *ngIf="message?.Insufficient_Information?.length > 0">
                <h4>Insufficient Information</h4>
                <ul class="mat-error" >
                   ${insuffinfo.toString()}
                </ul>
        </div>`;
                this.narrativestatus = this.returnNarrativeStatusFn(message, nojuryhtml, insufficehtml);
                (<any>$('#djs-validation-popup')).modal('show'); // NOSONAR
                return false;
            }
        }
        this.mainIntake(modal, appevent, false, true);
    }
    // Associated to submitPreIntake function
    private reusableNojuryInsuffinfoFn(index: any, data: any) {
        if (index === 0) {
            return data;
        }
        return '<br>' + data;
    }
    // Associated to mainIntake function
    private returnNarrativeStatusFn(message: any, nojuryhtml: string, insufficehtml: string): any {
        return (message.No_Jurisdiction && message.No_Jurisdiction.length
            ? nojuryhtml
            : '') +
            (message.Insufficient_Information &&
                message.Insufficient_Information.length
                ? insufficehtml
                : '');
    }

    submitPreIntakecaseClose(_modal: General, narrative: any) {
        const disposition = this.store[IntakeStoreConstants.createdCases];
        if (disposition && disposition.length > 0) {
            disposition.forEach((dis: any) => {
                dis.DADisposition = 'ISI';
                dis.supDisposition = 'ISI';
                dis.dispositioncode = 'ISI';
                dis.supStatus = 'Closed';
                dis.DAStatus = 'Closed';
                dis.intakeserreqstatustypekey =
                    '642f18b0-ef6e-4d4b-9871-acc0734f3f5a';
                dis.DaTypeKey = dis.serviceTypeID;
                dis.DasubtypeKey = dis.subServiceTypeID;
                dis.ServiceRequestNumber = dis.caseID;
            });
            this._dataStoreService.setData(
                IntakeStoreConstants.disposition,
                disposition
            );
        }
        this._dataStoreService.setData(
            IntakeStoreConstants.insufficientInfoNarrative,
            narrative
        );
        this.approveIntake(new General, 'INTR');
    }
    draftIntake(modal: General, appevent: string, toshowmessage: boolean) {
        if (this.store[IntakeStoreConstants.addNarrative]) {
            modal.requesteraddress1 = this.store[
                IntakeStoreConstants.addNarrative
            ].requesteraddress1;
            modal.requesteraddress2 = this.store[
                IntakeStoreConstants.addNarrative
            ].requesteraddress2;
            modal.requestercity = this.store[
                IntakeStoreConstants.addNarrative
            ].requestercity;
            modal.requesterstate = this.store[
                IntakeStoreConstants.addNarrative
            ].requesterstate;
            modal.requestercounty = this.store[
                IntakeStoreConstants.addNarrative
            ].requestercounty;
            modal.requestercountyname = this.store[
                IntakeStoreConstants.addNarrative
            ].requestercountyname;
            modal.isacknowledgementletter = this.store[
                IntakeStoreConstants.addNarrative
            ].isacknowledgementletter
                ? 1
                : 0;
        }
        this.mainIntake(modal, appevent, false, toshowmessage);
    }
    mainIntake(modal: General, appevent: string, isSubmitReview: boolean, toshowmessage: boolean) {
        this.modal = modal;
        this.appevent = appevent;
        if (this.isCW && !this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.CHILD_PROTECTION_SERVICES)) {
            modal.receiveddelay = 'N/A';
            modal.submissiondelay = 'N/A';
        }
        if (this.departmentActionIntakeFormGroup.status !== 'INVALID') {
            // Changes for UAT Defect 06781
            this.ifStatusIsNotInvalidFn(appevent, modal, toshowmessage, isSubmitReview);
        } else {
            ControlUtils.validateAllFormFields(
                this.departmentActionIntakeFormGroup
            );
            if (this.departmentActionIntakeFormGroup.get('InputSource')?.hasError('required')) {
                this._alertService.error('Please enter the communication');
            } else {
                this._alertService.warn('Please enter the mandatory fields.');
            }
        }
    }
    // Associated to mainIntake function
    private ifStatusIsNotInvalidFn(appevent: string, modal: General, toshowmessage: boolean, isSubmitReview: boolean) {
        if (appevent === 'DRAFT') {
            this.checkValidation = true;
        } else {
            if(['ROACPS', 'Information and Referral', 'Request for services'].includes(this.store[IntakeStoreConstants.purposeSelected]?.code)) {
                this.checkValidation = this.sdmValidation();
            } else {
                this.checkValidation = this.conditionalValidation();
            }
        }
        if (this.checkValidation) {
            this.general = Object.assign(new General(), modal);
            if (this.roleId.role.name === 'apcs') {
                this.general.supervisorflag = 'Y';
            } else {
                this.general.supervisorflag = 'N';
            }
            this.general.offenselocation = this.zipCode;
            this.general.intakeservice = this.intakeservice;
            if (this.isCW &&
                this.intakeservicesubtype &&
                this.intakeservicesubtype.length) {
                this.general.intakeservice[0].intakesubservice = Object.assign(
                    [],
                    this.intakeservicesubtype
                );
            }
            const recDate = new Date(modal.RecivedDate);
            this.general.RecivedDate = moment(recDate).format(this.dtwithtimeformat); // MAR - Removed UTC reference
            ObjectUtils.removeEmptyProperties(this.general);
            const disposition = this.store[IntakeStoreConstants.disposition];
            // @DP - For In Home Service
            if (this.intakeservice &&
                this.intakeservice.length &&
                this.intakeservice[0].description === this.inhomeservices) {
                this.subServiceTypesFn(disposition);
            }
            this.statusIsNotInvalidFnIfCWFn(disposition);
            const intake = this.mapIntakeScreenInfo(this.general);
            const role = this._authService.getCurrentUser();
            const validateFocuspersonCaseDJS = this.returnValidateFocuspersonCaseDJSFn(role);
            const reviewstatus = this.reviewstatusFn(appevent);
            this.checkAppeventFn(appevent, role, reviewstatus);
            this.ifDispositionFn(role, reviewstatus, disposition);
            if (intake) {
                const intakeSaveModel: any = this.ifIntakeInStatusIsNotInvalidFn(reviewstatus, validateFocuspersonCaseDJS, disposition);
                intakeSaveModel.narrative = Object.assign(
                    intake.NarrativeIntake
                );
                this.delayFormDataFn(intakeSaveModel);
                intakeSaveModel.officelocation = this._dataStoreService.getData(IntakeStoreConstants.USER_COUNTY);
                const finalIntake = this.traffickingupdateFn(intakeSaveModel, reviewstatus, role);

                this.checkCloseCWCaeFn(finalIntake, toshowmessage, isSubmitReview, role, appevent);
            }
        }
    }
    // Associated to mainIntake function
    private ifIntakeInStatusIsNotInvalidFn(reviewstatus: any, validateFocuspersonCaseDJS: boolean, disposition: any) {
        if (this.genratedDocumentList) {
            this.genratedDocumentList.forEach(document => {
                document.isSelected = false;
            });
        }
        const communication = this._dataStoreService.getData(IntakeStoreConstants.REFERALSOURCE);
        this.general.communicationDescription = (communication) ? communication.label : '';
        this._dataStoreService.setData(
            IntakeStoreConstants.general,
            this.general
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.reviewstatus,
            reviewstatus
        );
        const intakeSaveModel = new IntakeTemporarySaveModel(this.returnIntakeSaveModelFn(reviewstatus, validateFocuspersonCaseDJS));

        if (disposition && disposition.length > 0) {
            intakeSaveModel.DAType = {
                DATypeDetail: disposition
            };
        }
        return intakeSaveModel;
    }
    // Associated to mainIntake function
    private traffickingupdateFn(intakeSaveModel: any, reviewstatus: { appevent: string; status: string; commenttext: string; ispreintake: boolean; }, role: AppUser) {
        const intakeStore = this._intakeService.getIntakeStore();
        if ((!intakeStore.traffickingupdate || intakeStore.traffickingupdate == undefined) && intakeSaveModel.sdm) {
            intakeSaveModel.sdm.traffickingupdated = false;
        }
        if ((!intakeStore.maltreatmentupdated || intakeStore.maltreatmentupdated == undefined) && intakeSaveModel.sdm) {
            intakeSaveModel.sdm.maltreatmentupdated = false;
        }

        let childFatality = this._dataStoreService.getData(IntakeStoreConstants.childfatalityUpdate);
        if(childFatality?.isUpdated) {
            if(intakeSaveModel?.sdm) {
                intakeSaveModel.sdm.childfatalityupdated = 'yes';
                this._dataStoreService.setData(IntakeStoreConstants.childfatalityUpdate, {...childFatality, isUpdated: false });
            }
        } else {
             if(intakeSaveModel?.sdm) {
                intakeSaveModel.sdm.childfatalityupdated = 'no';
             }
        }
        const finalIntake = {
            intake: intakeSaveModel,
            review: reviewstatus
        };
        if (this.isDjs &&
            (role.role.name === AppConstants.ROLES.INTAKE_WORKER ||
                role.role.name ===
                AppConstants.ROLES.KINSHIP_INTAKE_WORKER)) {
            this.isManualRouting = 'true';
        }
        if (this.isAS &&
            role.role.name === AppConstants.ROLES.INTAKE_WORKER) {
            this.isManualRouting = 'true';
        }
        return finalIntake;
    }
    // Associated to mainIntake function
    private checkAppeventFn(appevent: string, role: AppUser, reviewstatus: { appevent: string; status: string; commenttext: string; ispreintake: boolean; }) {
        if ((appevent === 'SITR' || appevent === 'DRAFT') &&
            role.role.name === AppConstants.ROLES.OFFICE_PROFFESSIONAL) {
            reviewstatus.appevent = appevent;
            reviewstatus.status = 'supreview';
            reviewstatus.ispreintake = true;
        }
        if (this.roleId.role.name ===
            AppConstants.ROLES.KINSHIP_INTAKE_WORKER ||
            this.roleId.role.name ===
            AppConstants.ROLES.KINSHIP_SUPERVISOR) {
            reviewstatus.appevent = 'KINR';
        }
    }
    // Associated to mainIntake function
    private delayFormDataFn(intakeSaveModel: IntakeTemporarySaveModel) {
        if (this.delayFormData && this.delayFormData.fiveDays) {
            intakeSaveModel.General.receiveddelay = this.delayFormData.fiveDays;
            intakeSaveModel.General.submissiondelay = '';
        }

        if (this.delayFormData &&
            this.delayFormData.twentyFiveDays) {
            intakeSaveModel.General.submissiondelay = this.delayFormData.twentyFiveDays;
            intakeSaveModel.General.receiveddelay = '';
        }

        if (this.delayFormData &&
            this.delayFormData.fiveDays &&
            this.delayFormData.twentyFiveDays) {
            intakeSaveModel.General.receiveddelay = this.delayFormData.fiveDays;
            intakeSaveModel.General.submissiondelay = this.delayFormData.twentyFiveDays;
        }
    }
    // Associated to mainIntake function
    private checkCloseCWCaeFn(finalIntake: any, toshowmessage: boolean, isSubmitReview: boolean, role: AppUser, appevent: string) {
        this.closeCWCae = this._dataStoreService.getData(
            IntakeStoreConstants.closeintakecw
        );
        if (this.closeCWCae && this.appevent !== 'INTR') {
            this.createIntake(finalIntake, toshowmessage).subscribe();
            if (toshowmessage) {
                this._alertService.success('Completed successfully.');
            }
        } else if (this.checkIsManualANdRoleNameFn(isSubmitReview, role)) {
            this.finalIntake = Object.assign({}, finalIntake);
            this.loadSupervisor();
        } else {
            this.waiverFromAdulCourtFn(appevent, finalIntake, toshowmessage);
        }
    }
    // Associated to mainIntake function
    private checkIsManualANdRoleNameFn(isSubmitReview: boolean, role: AppUser) {
        return this.isManualRouting === 'true' &&
            isSubmitReview &&
            (role.role.name === AppConstants.ROLES.INTAKE_WORKER ||
                role.role.name === AppConstants.ROLES.CASE_WORKER ||
                role.role.name === AppConstants.ROLES.KINSHIP_INTAKE_WORKER);
    }
    // Associated to mainIntake function
    private reviewstatusFn(appevent: string) {
        return {
            appevent: appevent,
            status: appevent === 'INTR' ? 'supreview' : '',
            commenttext: '',
            ispreintake: this.isPreIntake
        };
    }
    
    // Associated to mainIntake function
    private statusIsNotInvalidFnIfCWFn(disposition: any) {
        if (this.isCW) {
            if (this.addSdm) {
                this.addSdmFn(disposition);
            } else {
                this.general.Iscps = null;
            }
        }
    }
    // Associated to mainIntake function
    private waiverFromAdulCourtFn(appevent: string, finalIntake: any, toshowmessage: boolean) {
        if (appevent !== 'DRAFT' &&
            appevent !== 'CLWDRAFT' &&
            this.isDjs &&
            (this._intakeConfig.selectedPurposeIs(
                MyNewintakeConstants.REFERRAL
                    .WAIVER_FROM_ADUL_COURT
            ) ||
                this._intakeConfig.selectedPurposeIs(
                    MyNewintakeConstants.REFERRAL
                        .ADULT_HOLD_DETENTION
                ))) {
            this.submitIntakeFromReferral(this._intakeConfig.getIntakePurpose()?.intakeservreqtypekey,'INTR');
        } else {
            this.createIntake(finalIntake, toshowmessage).subscribe();
        }
    }
    // Associated to mainIntake function
    private returnIntakeSaveModelFn(reviewstatus: any, validateFocuspersonCaseDJS: boolean): IntakeTemporarySaveModel {
        return {
            reasonforDraft: this.saveasdraftReason,
            crossReference: this.addedCrossReference,
            persons: this.store[IntakeStoreConstants.addedPersons],
            entities: this.store[IntakeStoreConstants.addedEntities],
            agency: this.store[IntakeStoreConstants.agency],
            intakeDATypeDetails: this.addedIntakeDATypeDetails,
            recordings: this.store[IntakeStoreConstants.communications],
            General: this.store[IntakeStoreConstants.general],
            narrative: this.store[IntakeStoreConstants.addNarrative],
            clwStatus: this.clwStatus,
            signedOffDate: this.signedOffDate,
            disposition: this.store[IntakeStoreConstants.disposition],
            attachement: this.store[IntakeStoreConstants.attachments],
            evaluationFields: this.isDjs
                ? this.modifyEvalFields()
                : null,
            appointments: this.store[IntakeStoreConstants.intakeappointment],
            reviewstatus: reviewstatus,
            createdCases: this.store[IntakeStoreConstants.createdCases],
            sdm: this.store[IntakeStoreConstants.intakeSDM],
            saoResponseDetail: this.store[IntakeStoreConstants.saoResponse],
            petitionDetails: this.store[IntakeStoreConstants.petitionDetails],
            scheduledHearings: this.store[IntakeStoreConstants.scheduledHearings],
            courtDetails: this.store[IntakeStoreConstants.courtDetails],
            communicationFields: this.store[IntakeStoreConstants.communicationFields],
            preIntakeDispo: this.store[IntakeStoreConstants.preIntakeDisposition],
            generatedDocuments: this.store[IntakeStoreConstants.generatedDocuments],
            adultScreenTool: this._dataStoreService.getData(
                IntakeStoreConstants.adultScreenTool
            ),
            focuspersoncasedetails: validateFocuspersonCaseDJS
                ? this.modifyinterStateCompactDetails()
                : [],
            paymentSchedule: this._dataStoreService.getData(
                IntakeStoreConstants.paymentSchedule
            ),
            unknownPersons: this._dataStoreService.getData(
                IntakeStoreConstants.addedUnkPersons
            ),
            identifiedPersons: this._dataStoreService.getData(
                IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS
            ),
            placement: this._dataStoreService.getData(
                IntakeStoreConstants.addedPlacement
            ),
            reasonintakeinterview: this._dataStoreService.getData(
                IntakeStoreConstants.reasonintakeinterview
            ),
            complaintInfoReview: this._dataStoreService.getData(
                IntakeStoreConstants.complaintInfoReview
            ),
            detentionOpened: this._dataStoreService.getData(
                IntakeStoreConstants.detentionOpened
            ),
            roacps: this._dataStoreService.getData(
                IntakeStoreConstants.roacps
            ),
            clearhistory: this._dataStoreService.getData(
                IntakeStoreConstants.clearhistory
            ),
            privateadoption: this._dataStoreService.getData(
                IntakeStoreConstants.PRIVATE_ADOPTION
            ),
            userrole: this.roleId.role.key ? this.roleId.role.key : '',
            officelocation: this._dataStoreService.getData(
                IntakeStoreConstants.USER_COUNTY
            )
        };
    }
    // Associated to mainIntake function
    private ifDispositionFn(role: AppUser, reviewstatus: any, disposition: any) {
        if (disposition && disposition.length > 0) {
            if (role.role.name === AppConstants.ROLES.SUPERVISOR) {
                reviewstatus.commenttext = disposition[0].supComments
                    ? disposition[0].supComments
                    : '';
                reviewstatus.status = disposition[0].supStatus;
            } else {
                reviewstatus.commenttext = disposition[0].comments
                    ? disposition[0].comments
                    : '';
            }
        }
    }
    // Associated to mainIntake function
    private addSdmFn(disposition: any) {
        if (disposition &&
            disposition.length &&
            disposition[0]) {
            disposition[0].issubtypekey = true;
        }
        this.general.Iscps = this.addSdm.iscps
            ? this.addSdm.iscps
            : null;
        if (this.subServiceTypes &&
            disposition &&
            disposition.length &&
            disposition[0]) {
            this.subServiceTypes.forEach(item => {
                if (this.addSdm.cpsResponseType ===
                    item.classkey) {
                    disposition[0].DasubtypeKey =
                        item.servicerequestsubtypeid;
                }
            });
        }
    }

    private CompleteSAO(finalIntake: any) {
        this._commonHttpService
            .create(finalIntake, NewUrlConfig.EndPoint.Intake.saoComplete)
            .subscribe(
                _response => {
                    this.onReload();
                    this._alertService.success(
                        'Sao Details Closed successfully!'
                    );
                },
                _error => {
                    this._alertService.error(
                        'Unable to close, please try again.'
                    );
                    return false;
                }
            );
    }

    checkSEN() {
        this.isSENflag = false;
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const intakesdmcheck = this.store[IntakeStoreConstants.intakeSDM];
        const qpaddedPersons = this.store[IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS];

        if (intakesdmcheck && intakesdmcheck.cpsResponseType &&
            (intakesdmcheck.cpsResponseType === 'CPS-AR' ||
                intakesdmcheck.cpsResponseType === 'CPS-IR')) {       // @TM: CPS IR & CPS AR over-ride SEN cases
            this.isSENflag = false;
        } else if (intakesdmcheck && intakesdmcheck.riskofHarm &&
            (ObjectUtils.checkTrueProperty(intakesdmcheck.riskofHarm) ?? 0) >= 1) {
            this.isSENflag = true;
        } else if (addedPersons) {
            addedPersons.map((item: { drugexposednewbornflag: number; }) => {
                // @TM: Set ROH (Risk of Harm) flag for 'strictly' SEN (Substance Exposed New-born) case
                if (item.drugexposednewbornflag === 1) {
                    this.isSENflag = true;
                }
            });
        } else if (qpaddedPersons) {
            qpaddedPersons.map((qpItem: { drugexposednewbornflag: number; }) => { 
                if (qpItem.drugexposednewbornflag === 1) {
                    this.isSENflag = true;
                }
            });
        }
    }

    createIntake(finalIntake: any, toshowmessage: boolean): Observable<string> {

        finalIntake.intake.sdm = finalIntake.intake.sdm
            ? finalIntake.intake.sdm
            : { isar: true };
        
        if(this.showaddendumnarrative){
            finalIntake = this.createintakefnforshowaddendumnarrative(finalIntake)
        
    }    
        this._dataStoreService.setData('addendumnarrativeInitial', finalIntake.intake.General.addendumNarrative);
        this.saveInProgress = true;

        this._commonHttpService
            .create(
                finalIntake,
                NewUrlConfig.EndPoint.Intake.SendtoSupervisorreviewUrl
            )
            .subscribe(
                response => {
                    this.saveInProgress = false;
                    this.addendumNarrativeDetails = {
                        addendumNarrativeCreatedAt:  finalIntake.intake.General.addendumNarrativeCreatedAt,
                        addendumNarrativeUpdatedAt:  finalIntake.intake.General.addendumNarrativeUpdatedAt,
                        addendumNarrativeCreatedBy:  finalIntake.intake.General.addendumNarrativeCreatedBy,
                        addendumNarrativeUpdatedBy:  finalIntake.intake.General.addendumNarrativeUpdatedBy,
                        addendumNarrativeCreatedByInfo:  finalIntake.intake.General.addendumNarrativeCreatedByInfo,
                        addendumNarrativeUpdatedByInfo:  finalIntake.intake.General.addendumNarrativeUpdatedByInfo
                    };
                    this.checkSEN();
                    if (this.closeCWCae && this.appevent !== 'DRAFT') {
                        this.approveIntake(this.modal, this.appevent);
                    } else if (
                        !this.isCLW &&
                        (response?.data?.isreceiveddelay ||
                            response?.data?.issubmitdelay)
                    ) {
                        (<any>$('#disposition-tab')).click(); // NOSONAR
                        this.generalRecievedDate = response.data;

                        // (<any>$(this.reasonfordelaypopupid)).modal('show');
                    } else {
                        this.sendtoSupervisorreviewApiResponseFn(finalIntake, toshowmessage);
                        return observableOf('success');
                    }
                },
                _error => {
                    this.saveInProgress = false;
                    this._alertService.error(
                        'Unable to save intake, please try again.'
                    );

                    return EMPTY;
                }
            );
        return EMPTY;

    }
    // Associated to createIntake function
    private createintakefnforshowaddendumnarrative(finalIntake: any){
        const userinfo = this._authService.getCurrentUser();
        const currentDate = moment(new Date()).format('MM/DD/YYYY hh:mm A');
        if (!this.addendumNarrativeDetails.addendumNarrativeCreatedAt && !this._dataStoreService.getData(IntakeStoreConstants.addNarrative)) {
            finalIntake.intake.General.addendumNarrativeCreatedAt = this._dataStoreService.getData(IntakeStoreConstants.addNarrative).addendumNarrativeCreatedAt ? this._dataStoreService.getData(IntakeStoreConstants.addNarrative).addendumNarrativeCreatedAt : currentDate;
            finalIntake.intake.General.addendumNarrativeUpdatedAt = this._dataStoreService.getData(IntakeStoreConstants.addNarrative).addendumNarrativeUpdatedAt ? this._dataStoreService.getData(IntakeStoreConstants.addNarrative).addendumNarrativeUpdatedAt : currentDate;
            finalIntake.intake.General.addendumNarrativeCreatedBy = userinfo.user.securityusersid;
            finalIntake.intake.General.addendumNarrativeUpdatedBy = userinfo.user.securityusersid;
            finalIntake.intake.General.addendumNarrativeCreatedByInfo = userinfo.user.userprofile.fullname;
            finalIntake.intake.General.addendumNarrativeUpdatedByInfo = userinfo.user.userprofile.fullname;
        } else {
            finalIntake.intake.General.addendumNarrativeCreatedAt = this.addendumNarrativeDetails.addendumNarrativeCreatedAt;
            finalIntake.intake.General.addendumNarrativeCreatedBy = this.addendumNarrativeDetails.addendumNarrativeCreatedBy;
            finalIntake.intake.General.addendumNarrativeCreatedByInfo = this.addendumNarrativeDetails.addendumNarrativeCreatedByInfo;
            this.addendumNarrativeFn(finalIntake, currentDate, userinfo);
     } 
     return finalIntake;  
    }
    private sendtoSupervisorreviewApiResponseFn(finalIntake: any, toshowmessage: boolean) {
        if (finalIntake.review.appevent === 'CLWDRAFT') {
            this.onReload();
            this.btnDraft = true;
            this._dataStoreService.setData(IntakeStoreConstants.IS_DRAFT, this.btnDraft);
            this._alertService.success(
                'Sao Details saved successfully!'
            );
        } else if (finalIntake.review.appevent !== 'DRAFT') {
            if (this.isCW &&
                finalIntake &&
                finalIntake.intake.sdm) {
                this.IsCWAndHasFinalINtakeDataFn(finalIntake);
            } else {
                this.onReload();
            }
            this.btnDraft = false;
            this._dataStoreService.setData(IntakeStoreConstants.IS_DRAFT, this.btnDraft);
        } else {
            if (toshowmessage) {
                this.toshowmessageFn();
            } else {
                if (this.btnDraft === true && !this.resubmissionPopupFlag && this.status === 'INTR' && this.roleId.role.name !== 'apcs') {
                    this.resubmissionPopupFlag = true;
                    (<any>$('#re-submission-popup')).modal('show'); // NOSONAR
                }
            }
            const intakeStore = this._intakeService.getIntakeStore();
            intakeStore.action = 'edit';
            this._intakeService.setIntakeStore(intakeStore);
            this.btnDraft = true;
            this._dataStoreService.setData(IntakeStoreConstants.IS_DRAFT, this.btnDraft);
            this.currentForm = this.store[IntakeStoreConstants.addNarrative];
        }
    }
    // Associated to createIntake function
    private IsCWAndHasFinalINtakeDataFn(finalIntake: any) {
        if ((this.intakeservice &&
            this.intakeservice.length &&
            this.intakeservice[0].description !==
            this.inhomeservices &&
            this.intakeservice[0].description !== 'I&R' &&
            this.intakeservice[0].description !== this.kinshipstring)) {
            // @TM: By-pass SDM for In-Home Services
            this.saveInitialSdm(
                finalIntake.intake.sdm
            ).subscribe(_data => {
                this.onReload();
            });
        } else {
            const isReturn = finalIntake ? this.ifFinalIntakeFn(finalIntake) : false;
            this.onReload(isReturn);
        }
    }
    // Associated to createIntake function
    private ifFinalIntakeFn(finalIntake: any) {
        return (finalIntake.review ? this.ifStatusFn(finalIntake) : false);
    }
    // Associated to createIntake function
    private ifStatusFn(finalIntake: any) {
        return (finalIntake.review.status ? this.returnStatusForReopenFn(finalIntake) : false);
    }
    // Associated to createIntake function
    private returnStatusForReopenFn(finalIntake: any) {
        return (finalIntake.review.status === 'Reopen' ? true : false);
    }
    // Associated to createIntake function
    private toshowmessageFn() {
        if (this.btnDraft === true) {
            if (!this.resubmissionPopupFlag && this.status === 'INTR' && this.roleId.role.name !== 'apcs') {
                this.resubmissionPopupFlag = true;
                (<any>$('#re-submission-popup')).modal('show'); // NOSONAR
            }
            const intakeStore = this._intakeService.getIntakeStore();
            intakeStore.traffickingupdate = false;
            intakeStore.maltreatmentupdated = false;
            this._intakeService.setIntakeStore(intakeStore);
            this._alertService.success(
                'Intake updated successfully!'
            );
        } else {
            const intakeStore = this._intakeService.getIntakeStore();
            intakeStore.traffickingupdate = false;
            intakeStore.maltreatmentupdated = false;
            this._intakeService.setIntakeStore(intakeStore);
            this._alertService.success(
                'Intake saved successfully!'
            );
        }
    }

    saveInitialSdm(sdm: any) {
        sdm.reportdate = null;
        const initialSdm = {
            sdmdata: this.store[IntakeStoreConstants.intakeSDM],
            intakenumber: this.intakeNumber,
            servicerequestid: null
        };
        this._dataStoreService.setData(
            IntakeStoreConstants.intakeSDM,
            initialSdm
        );
        return this._commonHttpService.create(
            initialSdm,
            NewUrlConfig.EndPoint.Intake.IntakeSdmCreateUrl
        );
    }

    approveIntake(modal: General, appevent: string) {
        modal.Source = modal.Source ? modal.Source : modal.InputSource;
        modal.AgencyCode = 'CW';
        if (this.departmentActionIntakeFormGroup.status !== 'INVALID') {
            if(['ROACPS', 'Information and Referral', 'Request for services'].includes(this.store[IntakeStoreConstants.purposeSelected]?.code)) {
                this.checkValidation = this.sdmValidation();
            } else {
                this.checkValidation = this.conditionalValidation();
            }
            return this.ifCheckValidationFn(appevent)
        }
    }
    // Associated to approveIntake function
    private supervisorApprovalApiResponseFn(response: any, finalIntake: any) {
        if (response &&
            response.data &&
            response.data.data) {
                this.addendumNarrativeDetails = {
                    addendumNarrativeCreatedAt:  finalIntake.intake.General.addendumNarrativeCreatedAt,
                    addendumNarrativeUpdatedAt:  finalIntake.intake.General.addendumNarrativeUpdatedAt,
                    addendumNarrativeCreatedBy:  finalIntake.intake.General.addendumNarrativeCreatedBy,
                    addendumNarrativeUpdatedBy:  finalIntake.intake.General.addendumNarrativeUpdatedBy,
                    addendumNarrativeCreatedByInfo:  finalIntake.intake.General.addendumNarrativeCreatedByInfo,
                    addendumNarrativeUpdatedByInfo:  finalIntake.intake.General.addendumNarrativeUpdatedByInfo
                };
            if (this.pathwayChange) {
                this.ifPathwayChangeFn(response, finalIntake);
            } else if (this.intakeservice && this.intakeservice.length && this.intakeservice[0].description === this.privateadoptionsubsidy
                && finalIntake.intake.disposition && finalIntake.intake.disposition.length &&
                (finalIntake.intake.disposition[0].supDisposition !== 'OvrScrnout' &&
                    finalIntake.intake.disposition[0].supDisposition !== 'ScreenOUT' &&
                    finalIntake.intake.disposition[0].supDisposition !== 'rejected')) {
                if (response.data.data && response.data.data.length) {
                    this.createAdoptionCase(response.data.data);
                } else {
                    this._alertService.error('Intake could not be approved.');
                }
            } else {
                this.ifIntakeDispositionFn(finalIntake, response);
            }
        } else {
            this._alertService.error(
                'Unable to approve intake, please try again.'
            );
        }
    }
    // Associated to approveIntake function
    private ifIntakeDispositionFn(finalIntake: any, response: any) {
        if (this.isCW && finalIntake.intake.disposition && finalIntake.intake.disposition.length) {
            const supervisorDecisionCode = finalIntake.intake.disposition[0].supDisposition;
            if (supervisorDecisionCode === 'OvrScrnout' ||
                supervisorDecisionCode === 'ScreenOUT' ||
                supervisorDecisionCode === 'rejected') {
                (<any>$('#screenout-intake-ackmt')).modal('show'); // NOSONAR
            } else {
                this.showApproveIntakeAckmnt(
                    response.data.data, finalIntake
                );
            }
        } else {
            this.showApproveIntakeAckmnt(
                response.data.data, finalIntake
            );
        }

        this.btnDraft = false;
        this._dataStoreService.setData(IntakeStoreConstants.IS_DRAFT, this.btnDraft);
    }
    // Associated to approveIntake function
    private ifPathwayChangeFn(response: any, finalIntake: any) {
        if (this.intakeservice[0]
            .description !==
            this.inhomeservices) {
            // @TM: By-pass SDM for In-Home Services
            this.saveInProgress = true;
            this.saveInitialSdm(
                this.addSdm
            ).subscribe(_data => {
                this.saveInProgress = false;
                this.showApproveIntakeAckmnt(
                    response.data.data, finalIntake
                );
                this.btnDraft = false;
                this._dataStoreService.setData(IntakeStoreConstants.IS_DRAFT, this.btnDraft);
            });
        }
    }
    // Associated to approveIntake function
    private ifAddNarrativeFn(intakeSaveModel: any) {
        const addNarrative = this.store[IntakeStoreConstants.addNarrative];
        if (addNarrative) {
            intakeSaveModel.narrative = this.retrunNarrativeObjectDataFn(addNarrative);
            intakeSaveModel.General.Firstname = addNarrative.Firstname
                ? addNarrative.Firstname
                : '';

            intakeSaveModel.General.Middlename = addNarrative.Middlename
                ? addNarrative.Middlename
                : '';
            intakeSaveModel.General.Lastname = addNarrative.Lastname
                ? addNarrative.Lastname
                : '';
            intakeSaveModel.General.AgencyCode = 'CW';
            intakeSaveModel.General.Source = intakeSaveModel.General
                .InputSource
                ? intakeSaveModel.General.InputSource
                : '';
            intakeSaveModel.General.isacknowledgementletter = addNarrative.isacknowledgementletter === true ? 1 : 0;
        }
    }
    // Associated to approveIntake function
    private ifIntakeModelSdmFn(intakeSaveModel: any, intakeStore: IntakeStore) {
        // if (intakeSaveModel.sdm && intakeSaveModel.sdm.isfinalscreenin
        //     && intakeSaveModel.sdm.isfinalscreenin === 'Ovr_as_noncps') {
        //     intakeSaveModel.sdm.isfinalscreenin = 'true';
        // }
        if (intakeSaveModel.sdm) {
            intakeSaveModel.sdm.isroh = false;
            this.ifNotIsarIsirFn(intakeSaveModel);
            if ((!intakeStore?.traffickingupdate || intakeStore?.traffickingupdate == undefined) && intakeSaveModel.sdm) {
                intakeSaveModel.sdm.traffickingupdated = false;
            }
            if ((!intakeStore.maltreatmentupdated || intakeStore.maltreatmentupdated == undefined) && intakeSaveModel.sdm) {
                intakeSaveModel.sdm.maltreatmentupdated = false;
            }
        }
    }
    // Associated to approveIntake function
    private ifNotIsarIsirFn(intakeSaveModel: any) {
        if (!intakeSaveModel.sdm.isar && !intakeSaveModel.sdm.isir) {
            if (intakeSaveModel.sdm.cpsResponseType) {
                intakeSaveModel.sdm.isroh = false;
            } else if ((intakeSaveModel.sdm.riskofHarm && (ObjectUtils.checkTrueProperty(intakeSaveModel.sdm.riskofHarm) ?? 0) >= 1)
                || (intakeSaveModel.sdm.noImmediateList
                    && intakeSaveModel.sdm.noImmediateList.isnoimmed_substantial_risk) ||
                (intakeSaveModel.sdm.noImmediateList
                    && intakeSaveModel.sdm.noImmediateList.isnoimmed_risk_harm) || 
                    (['ROA-CPS', 'Information and Referral', 'Request for services'].includes(this.intake?.data[0]?.jsondata?.General?.PurposeName))) { 
                intakeSaveModel.sdm.isroh = true;
                intakeSaveModel.sdm.isar = false;
                intakeSaveModel.sdm.isir = false;
                intakeSaveModel.sdm.cpsResponseType = null;
            }
        }
    }
    // Associated to approveIntake function
    private returnIntakeSaveModelDataFn(disposition: any, general: General, reviewstatus: any, validateFocuspersonCaseDJS: boolean) {
        return {
            CrossReferences: this.addedCrossReference
                ? this.addedCrossReference.map(
                    item => new CrossReference(item)
                )
                : [],
            persondetails: {
                Person: this.store[IntakeStoreConstants.addedPersons]
            },
            entities: this.store[IntakeStoreConstants.addedEntities],
            createdCases: this.store[IntakeStoreConstants.createdCases],
            intakeDATypeDetails: this.store[IntakeStoreConstants.disposition],
            recordings: this.store[IntakeStoreConstants.communications],
            attachement: this.store[IntakeStoreConstants.attachements],
            disposition: disposition,
            General: general,
            narrative: null,
            evaluationFields: this.isDjs
                ? this.modifyEvalFields()
                : null,
            appointments: this.store[IntakeStoreConstants.intakeappointment],
            DAType: {
                DATypeDetail: this.store[IntakeStoreConstants.disposition]
            },
            reviewstatus: reviewstatus,
            Allegations: this.isDjs ? this.formatAllegations() : [],
            sdm: this.store[IntakeStoreConstants.intakeSDM],
            clwStatus: null,
            generatedDocuments: this.store[IntakeStoreConstants.generatedDocuments],
            communicationFields: this.store[IntakeStoreConstants.communicationFields],
            adultScreenTool: this._dataStoreService.getData(
                IntakeStoreConstants.adultScreenTool
            ),
            focuspersoncasedetails: validateFocuspersonCaseDJS
                ? this.modifyinterStateCompactDetails()
                : [],
            paymentSchedule: this._dataStoreService.getData(
                IntakeStoreConstants.paymentSchedule
            ),
            unknownPersons: this._dataStoreService.getData(
                IntakeStoreConstants.addedUnkPersons
            ),
            identifiedPersons: this._dataStoreService.getData(
                IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS
            ),
            placement: this._dataStoreService.getData(
                IntakeStoreConstants.addedPlacement
            ),
            reasonintakeinterview: this._dataStoreService.getData(
                IntakeStoreConstants.reasonintakeinterview
            ),
            insufficientInfoNarrative: this._dataStoreService.getData(
                IntakeStoreConstants.insufficientInfoNarrative
            ),
            complaintInfoReview: this._dataStoreService.getData(
                IntakeStoreConstants.complaintInfoReview
            ),
            detentionOpened: this._dataStoreService.getData(
                IntakeStoreConstants.detentionOpened
            ),
            roacps: this._dataStoreService.getData(
                IntakeStoreConstants.roacps
            ),
            clearhistory: this._dataStoreService.getData(
                IntakeStoreConstants.clearhistory
            ),
            privateadoption: this._dataStoreService.getData(
                IntakeStoreConstants.PRIVATE_ADOPTION
            ),
            officelocation: this._dataStoreService.getData(
                IntakeStoreConstants.USER_COUNTY
            )            
        };
    }
    // Associated to approveIntake function
    private retrunNarrativeObjectDataFn(addNarrative: any) {
        return [{ ...this.narrativeObjectData1Fn(addNarrative), ...this.narrativeObjectData2Fn(addNarrative) }];
    }
    // Associated to approveIntake function
    private narrativeObjectData1Fn(addNarrative: any) {
        return {
            Firstname: addNarrative.Firstname ? addNarrative.Firstname : '',
            Lastname: addNarrative.Lastname ? addNarrative.Lastname : '',
            Middlename: addNarrative.Middlename ? addNarrative.Middlename : '',
            PhoneNumber: addNarrative.PhoneNumber ? addNarrative.PhoneNumber : '',
            PhoneNumberExt: addNarrative.PhoneNumberExt ? addNarrative.PhoneNumberExt : '',
            requesteraddress1: addNarrative.requesteraddress1 ? addNarrative.requesteraddress1 : '',
            requesteraddress2: addNarrative.requesteraddress2 ? addNarrative.requesteraddress2 : '',
            requestercity: addNarrative.requestercity ? addNarrative.requestercity : '',
            requesterstate: addNarrative.requesterstate ? addNarrative.requesterstate : '',
            requestercounty: addNarrative.requestercounty ? addNarrative.requestercounty : ''
        };
    }
    // Associated to approveIntake function
    private narrativeObjectData2Fn(addNarrative: any) {
        return {
            requestercountyname: addNarrative.requestercountyname ? addNarrative.requestercountyname : '',
            offenselocation: addNarrative.offenselocation ? addNarrative.offenselocation : '',
            ZipCode: addNarrative.ZipCode ? addNarrative.ZipCode : '',
            Role: addNarrative.Role ? addNarrative.Role : '',
            RoleName: addNarrative.RoleName ? addNarrative.RoleName : '',
            organization: addNarrative.organization ? addNarrative.organization : '',
            title: addNarrative.title ? addNarrative.title : '',
            incidentlocation: addNarrative.incidentlocation ? addNarrative.incidentlocation : '',
            incidentdate: addNarrative.incidentdate ? addNarrative.incidentdate : '',
            isapproximate: addNarrative.isapproximate ? addNarrative.isapproximate : false,
            email: addNarrative.email ? addNarrative.email : ''
        };
    }
    // Associated to approveIntake function
    private ifCheckValidationFn(appevent: string) {
        let modal = this.departmentActionIntakeFormGroup.getRawValue()
        modal.Source = modal.Source ? modal.Source : modal.InputSource;
        modal.AgencyCode = 'CW';
        if (this.checkValidation) {
            const general = Object.assign(new General(), modal);
            general.offenselocation = this.zipCode;
            general.intakeservice = this.intakeservice;
            this.intakesubserviceFn(general);
            const recDate = new Date(modal.RecivedDate);
            general.RecivedDate = moment(recDate).format(this.dtwithtimeformat);
            general.Purpose = this.store[
                IntakeStoreConstants.purposeSelected
            ].value;
            const General_OBJ = this.store['general'];
            this.ifGeneralFn(general, General_OBJ);
            const sdmvalue = this.store[IntakeStoreConstants.intakeSDM];
            const intakeStore = this._intakeService.getIntakeStore();
            sdmvalue.isoverriderequest = this.returnIsoverriderequestFn(general);
            if (this.navigatetonarrative || this.returntoworker) {
                const casedetails = this._dataStoreService.getData(IntakeStoreConstants.SELECTED_INTAKE_CASE_DETAILS);
                general.casedetails = casedetails;
                general.isoverriderequest = true;
                sdmvalue.isoverriderequest = true;
                this.overriderequest = true;
              }
            this._dataStoreService.setData(
                IntakeStoreConstants.intakeSDM,
                sdmvalue
            );
            if (sdmvalue.screeningRecommend === 'accept_as_noncps' && general.isoverriderequest  && this.caseNumber) {
                this._alertService.error('Case cannot be converted to Non CPS as there is a CPS case already connected with this intake');
                this.disableApproveBtn = false;
                return;
            }
            ObjectUtils.removeEmptyProperties(general);
            const intake = this.mapIntakeScreenInfo(general);
            const disposition = this.store[
                IntakeStoreConstants.disposition
            ];
            if (
                this.roleId.role.name ===
                AppConstants.ROLES.KINSHIP_INTAKE_WORKER ||
                this.roleId.role.name ===
                AppConstants.ROLES.KINSHIP_SUPERVISOR
            ) {
                appevent = 'KINR';
            }
            const reviewstatus = {
                appevent: appevent,
                status: disposition ? disposition[0]?.supStatus : null,
                commenttext: '',
                youthstatuseventcode: '',
                ispreintakeapproved: false
            };
            this.ifDispositionInCheckValidationFn(disposition, reviewstatus);

            this.interstateCompactFn(reviewstatus);
            this.addedPersonMapFn();
            this.ifDispositionAndNotDJSFn(disposition);
            this.ifCWInCheckValidationFn(disposition, general);
            const communication = this._dataStoreService.getData(IntakeStoreConstants.REFERALSOURCE);
            general.communicationDescription = this.returnCommunicationLabelFn(communication);
            this._dataStoreService.setData(
                IntakeStoreConstants.disposition,
                disposition
            );
            const roleId = this._authService.getCurrentUser();
            const validateFocuspersonCaseDJS = this.returnValidateFocuspersonCaseDJSFn(roleId);
            this.ifIntakeInCheckValidationFn(disposition, general, reviewstatus, validateFocuspersonCaseDJS, intakeStore, intake);
        } else {
            ControlUtils.validateAllFormFields(
                this.departmentActionIntakeFormGroup
            );
            if (this.departmentActionIntakeFormGroup.get('InputSource')?.hasError('required')) {
                this._alertService.error('Please input communication');
            } else {
                this._alertService.warn('Please input the mandatory fields.');
            }
        }
    }
    // Associated to approveIntake function
    private intakesubserviceFn(general: any) {
        if (this.ifCWAndIntakeservicesubtypeFn()) {
            general.intakeservice[0].intakesubservice = Object.assign(
                [],
                this.intakeservicesubtype
            );
        }
    }
    // Associated to approveIntake function
    private returnCommunicationLabelFn(communication: any): any {
        return (communication) ? communication.label : '';
    }
    // Associated to approveIntake function
    private ifCWAndIntakeservicesubtypeFn() {
        return this.isCW && this.intakeservicesubtype && this.intakeservicesubtype.length;
    }
    // Associated to approveIntake function
    private returnIsoverriderequestFn(general: any): any {
        return general.isoverriderequest ? general.isoverriderequest : false;
    }
    // Associated to approveIntake function
    private ifDispositionAndNotDJSFn(disposition: any) {
        if (!this.isDjs && disposition && disposition.length > 0) {
            disposition.map((item: { intakeMultipleDispositionDropdown: never[]; supMultipleDispositionDropdown: never[]; }) => {
                item.intakeMultipleDispositionDropdown = [];
                item.supMultipleDispositionDropdown = [];
            });
        }
    }
    // Associated to approveIntake function
    private interstateCompactFn(reviewstatus: { appevent: string; status: any; commenttext: string; youthstatuseventcode: string; ispreintakeapproved: boolean; }) {
        if (this._intakeConfig.getIntakePurpose()?.intakeservreqtypekey ===
            MyNewintakeConstants.REFERRAL.INTERSTATE_COMPACT) {
            const createdCases = this.store[IntakeStoreConstants.createdCases];
            createdCases.forEach((createdCase: any) => {
                if (createdCase.isyouthincustody) {
                    reviewstatus.youthstatuseventcode = 'InCustody';
                }
            });
        } else if (this._intakeConfig.getIntakePurpose()?.intakeservreqtypekey ===
            MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION ||
            this._intakeConfig.getIntakePurpose()?.intakeservreqtypekey ===
            MyNewintakeConstants.REFERRAL.WAIVER_FROM_ADUL_COURT) {
            reviewstatus.ispreintakeapproved = true;
        }
    }
    // Associated to approveIntake function
    private ifDispositionInCheckValidationFn(disposition: any, reviewstatus: { appevent: string; status: any; commenttext: string; youthstatuseventcode: string; ispreintakeapproved: boolean; }) {
        if (disposition && disposition.length > 0) {
            const role = this._authService.getCurrentUser();
            if (role.role.name === AppConstants.ROLES.SUPERVISOR) {
                reviewstatus.commenttext = disposition[0].supComments
                    ? disposition[0].supComments
                    : '';
            } else {
                reviewstatus.commenttext = disposition[0].comments
                    ? disposition[0].comments
                    : '';
            }
        }
    }
    // Associated to approveIntake function
    private ifIntakeInCheckValidationFn(disposition: any, general: any, reviewstatus: any, validateFocuspersonCaseDJS: boolean, intakeStore: IntakeStore, intake: any) {
        if (intake) {
            const intakeSaveModel = this.returnIntakeSaveModelDataFn(disposition, general, reviewstatus, validateFocuspersonCaseDJS);

            this.ifIntakeModelSdmFn(intakeSaveModel, intakeStore);
            this.ifAddNarrativeFn(intakeSaveModel);
            intakeSaveModel.officelocation = this._dataStoreService.getData(IntakeStoreConstants.USER_COUNTY);
            const finalIntake: any = {
                intake: intakeSaveModel,
                review: reviewstatus
            };
            if (this.selectteamtypekey) {
                const purpose: any = this.selectteamtypekey.indexOf('~') !== -1
                ? this.selectteamtypekey.split('~')[0] : this.selectteamtypekey;
                const selectedPurpose = this.getSelectedPurpose(purpose);
                this.ifSelectedPurposeFn(selectedPurpose, finalIntake);
            }

            // @DP - For In Home Service
            if (this.intakeservice &&
                this.intakeservice.length &&
                this.intakeservice[0].description === this.inhomeservices) {
                this.subServiceTypesFn(disposition);
            }

            //ASCRS-Adoption Search Contact and Reunion Services check
            if (finalIntake && finalIntake.intake && finalIntake.intake.General &&
                finalIntake.intake.General.intakeservice && finalIntake.intake.General.intakeservice.length &&
                finalIntake.intake.General.intakeservice[0] && finalIntake.intake.General.intakeservice[0].intakeservtypekey === 'ASCRS') {
                this.isASCRS = true;
            } else {
                this.isASCRS = false;
            }
            
            if(this.showaddendumnarrative){
                finalIntake.intake.General.casealreadycreated=this.casealreadycreated;
                finalIntake.intake.General.isaddendumnarrativeupdated = this._dataStoreService.getData(IntakeStoreConstants.isaddendumnarrativeupdated);
                this.createintakefnforshowaddendumnarrative(finalIntake)
        }
            this._dataStoreService.setData('addendumnarrativeInitial', finalIntake.intake.General.addendumNarrative);
            this.saveInProgress = true;
            this._commonHttpService
                .create(
                    finalIntake,
                    NewUrlConfig.EndPoint.Intake.SupervisorApprovalUrl
                )
                .subscribe(
                    response => {
                        this.saveInProgress = false;
                        this.supervisorApprovalApiResponseFn(response, finalIntake);
                    },
                    _error => {
                        this.saveInProgress = false;
                        this._alertService.error(
                            'Unable to approve intake, please try again.'
                        );

                        return false;
                    }
                );
        }
    }
    // Associated to ifIntakeInCheckValidationFn function
    private addendumNarrativeFn(finalIntake: { intake: any; review: any; }, currentDate: string, userinfo: AppUser) {
        if (finalIntake.intake.General.addendumNarrative != this._dataStoreService.getData(IntakeStoreConstants.addNarrative).addendumNarrative) {
            finalIntake.intake.General.addendumNarrativeUpdatedAt = currentDate;
            finalIntake.intake.General.addendumNarrativeUpdatedBy = userinfo.user.securityusersid;
            finalIntake.intake.General.addendumNarrativeUpdatedByInfo = userinfo.user.userprofile.fullname;
        } else {
            const intakenarrative = this._dataStoreService.getData(IntakeStoreConstants.addNarrative);
            const narrativeUpdatedDate = intakenarrative && intakenarrative.addendumNarrativeUpdatedAt && this.isValidDate(intakenarrative.addendumNarrativeUpdatedAt) ? intakenarrative.addendumNarrativeUpdatedAt : null;
            
            finalIntake.intake.General.addendumNarrativeUpdatedAt = narrativeUpdatedDate ? moment(narrativeUpdatedDate).format('MM/DD/YYYY hh:mm A') : null;
            finalIntake.intake.General.addendumNarrativeUpdatedBy = this.addendumNarrativeDetails.addendumNarrativeUpdatedBy;
            finalIntake.intake.General.addendumNarrativeUpdatedByInfo = this.addendumNarrativeDetails.addendumNarrativeUpdatedByInfo;
        }
    }
    // Associated to approveIntake function
    private ifCWInCheckValidationFn(disposition: any, general: any) {
        if (this.isCW && disposition && general) {
            if (disposition[0]?.dispositioncode === disposition[0]?.supDisposition) {
                general.isDisposition = false;
            } else {
                general.isDisposition = true;
            }
            this.approveIntakeAddSdmFn(disposition, general);
        }

        
    }
    // Associated to approveIntake function
    private approveIntakeAddSdmFn(disposition: any, general: any) {
        if (this.addSdm) {
            disposition[0].issubtypekey = true;
            general.Iscps = this.addSdm.iscps
                ? this.addSdm.iscps
                : null;
            if (this.subServiceTypes) {
                this.subServiceTypes.forEach(serviceTypeItem => {
                    if (this.addSdm.cpsResponseType ===
                        serviceTypeItem.classkey) {
                        disposition[0].DasubtypeKey =
                        serviceTypeItem.servicerequestsubtypeid;
                    }
                });
            }
        } else {
            general.Iscps = null;
        }
    }

    // Associated to approveIntake function
    private addedPersonMapFn() {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        addedPersons.map((item: any) => {
            item.Pid = item.Pid ? item.Pid : '';
            if (item.emailID) {
                item.contactsmail = item.emailID;
            } else {
                item.contactsmail = [];
            }
            if (item.phoneNumber) {
                item.contacts = item.phoneNumber;
            } else {
                item.contacts = [];
            }
            if (item.personAddressInput) {
                item.address = item.personAddressInput;
            } else {
                item.address = [];
            }
        });
    }
    // Associated to approveIntake function
    private ifGeneralFn(general: any, General_OBJ: any) {
        if (General) {
            this.requesterAddressFn(general, General_OBJ);
            general.offenselocation = General_OBJ['offenselocation'] ? General_OBJ['offenselocation'] : null;
            general.casedetails = General_OBJ['casedetails'] ? General_OBJ['casedetails'] : null;
            general.isoverriderequest = General_OBJ['isoverriderequest'] ? General_OBJ['isoverriderequest'] : null;
            if (general.isoverriderequest) {
                this.overriderequest = true;
            }
        }
    }
    // Associated to approveIntake function
    private requesterAddressFn(general: any, General_OBJ: any) {
        general.requesteraddress1 = General_OBJ['requesteraddress1'] ? General_OBJ['requesteraddress1'] : null;
        general.requesteraddress2 = General_OBJ['requesteraddress2'] ? General_OBJ['requesteraddress2'] : null;
        general.requestercity = General_OBJ['requestercity'] ? General_OBJ['requestercity'] : null;
        general.requesterstate = General_OBJ['requesterstate'] ? General_OBJ['requesterstate'] : null;
        general.requestercounty = General_OBJ['requestercounty'] ? General_OBJ['requestercounty'] : null;
        general.requestercountyname = General_OBJ['requestercountyname'] ? General_OBJ['requestercountyname'] : null;
    }
    // Associated to approveIntake function
    private ifSelectedPurposeFn(selectedPurpose: IntakePurpose | null, finalIntake: any) {
        if (selectedPurpose) {
            if (selectedPurpose.description ===
                this.informationandreferral || (selectedPurpose.description === this.requestforservices &&
                    this.intakeservice &&
                    this.intakeservice.length &&
                    this.intakeservice[0].description === this.cpshistoryclearance)) {
                finalIntake.review['isfromintake'] = true;
                finalIntake.review['isclosecase'] = true;
            }
        }
    }
    // Associated to mainIntake and approveIntake function
    private subServiceTypesFn(disposition: any) {
        if (this.subServiceTypes) {
            this.subServiceTypes.forEach(item => {
                if (this.intakeservice[0].intakeservtypekey ===
                    item.classkey) {
                    if (disposition && disposition.length) {
                        disposition[0].DasubtypeKey =
                            item.servicerequestsubtypeid;
                    }
                }
            });
        }
    }
    // Associated to mainIntake and approveIntake function
    private returnValidateFocuspersonCaseDJSFn(role: AppUser) {
        return this.isDjs &&
            (role.role.name === AppConstants.ROLES.SUPERVISOR ||
                role.role.name === AppConstants.ROLES.INTAKE_WORKER ||
                role.role.name ===
                AppConstants.ROLES.OFFICE_PROFFESSIONAL);
    }

    onReload(isReturn?: any) {
        if(isReturn){
            this.returnToWorkerAcknowledged();
        }else {
            let url = '';
            if (this.isCLW) {
                url = '/pages/sao-dashboard';
            } else if (this.roleId.role.name === AppConstants.ROLES.SUPERVISOR) {
                if (this.isIntakeFromSupervisor) {
                    url = '/pages/cjams-dashboard/my-intake-summary';
                } else {
                    url = this._intakeService.loadIntakeDashboard();
                }
            } else {
                url = this.saveintakeurl;
            }
            this._alertService.success(this.intakesubmitmsg);
            this._router.navigate([url]);
        }
    }

    getSubCategory() {
        if (this.store[IntakeStoreConstants.purposeSelected]) {
            const purpose = this.store[IntakeStoreConstants.purposeSelected];
            this.subType = this.store[IntakeStoreConstants.createdCases];
            if (this.subType && this.subType.length > 0) {
                const purposeSubType = this.subType[0].subServiceTypeID;
                this.subCategoryClassificationType$ = this._commonHttpService
                    .getArrayList(
                        {
                            where: {
                                intakeservicerequesttypeid: purpose.value,
                                intakeservicerequestsubtypeid: purposeSubType,
                                agencycode: 'AS',
                                target: 'Intake'
                            },
                            method: 'get'
                        },
                        'admin/assessmenttemplate/listassessmenttemplate?filter'
                    ).pipe(
                    map(result => {
                        return result;
                    }));
                this.subCategoryClassificationType$.subscribe(result => {
                    this.listassessmentTemplateResponseFn(result);
                });
            }
        }
    }
    // Associated to getSubCategory function
    private listassessmentTemplateResponseFn(result: any[]) {
        if (result && result.length > 0) {
            this.subCategoryList = [];
            for (const element of result) {
                if (element.isrequired === true) {
                    this.subCategoryList.push(element);
                }
            }
        }
        this._dataStoreService.setData(
            'categorySubType',
            this.subCategoryList
        );
    }

    processLegalGuardian() {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const legalGuardian: any = [];
        if (addedPersons && addedPersons.length > 0) {
            addedPersons.map((item: any) => {
                if (item && item.personRole && Array.isArray(item.personRole)) {
                    this.pushLegalGuardianDataFn(item, legalGuardian);
                }

            });
        }
        this.departmentActionIntakeFormGroup.patchValue({
            LegalGuardian: legalGuardian.toString()
        });
    }
    // Associated to processLegalGuardian function
    private pushLegalGuardianDataFn(item: any, legalGuardian: any[]) {
        const roleArray = item.personRole;
        roleArray.forEach((role: any) => {
            if (role.rolekey === 'LG') {
                const firstname = item.Firstname ? item.Firstname : '';
                const lastname = item.Lastname ? item.Lastname : '';
                const fullname = firstname + ' ' + lastname;
                legalGuardian.push(fullname);
            }
        });

        if (item.isheadofhousehold) {
            this.departmentActionIntakeFormGroup.patchValue({
                HeadofHousehold: item.fullName
            });
        }
    }

    /* isOtherThanRiskHarmSelected() {
        const sdmForm = this.store[IntakeStoreConstants.intakeSDM];
        const phyAbuse = sdmForm.physicalAbuse;
        const sexAbuse = sdmForm.sexualAbuse;
        const genNeglect = sdmForm.generalNeglect;
        const unattChild = sdmForm.unattendedChild;

        const isPhyAbuse = (phyAbuse.ismalpa_suspeciousdeath || phyAbuse.ismalpa_nonaccident ||
            phyAbuse.ismalpa_injuryinconsistent || phyAbuse.ismalpa_insjury || phyAbuse.ismalpa_childtoxic
            || phyAbuse.ismalpa_caregiver) ? true : false;
        const isSexAbuse = (sexAbuse.ismalsa_sexualmolestation || sexAbuse.ismalsa_sexualact
            || sexAbuse.ismalsa_sexualexploitation || sexAbuse.ismalsa_physicalindicators) ? true : false;
        const isGenNeglect = (sdmForm.isnegfp_cargiverintervene || sdmForm.isnegab_abandoned ||
            sdmForm.isnegmn_unreasonabledelay ||
            unattChild.isneguc_leftunsupervised || unattChild.isneguc_leftaloneinappropriatecare || unattChild.isneguc_leftalonewithoutsupport ||
            genNeglect.isneggn_suspiciousdeath || genNeglect.isneggn_signsordiagnosis || genNeglect.isneggn_inadequatefood || genNeglect.isneggn_childdischarged) ? true : false;
        return isPhyAbuse || isSexAbuse || isGenNeglect;
    } */

    validateMaltreatmentOverScreenin(sdmForm: any){
        
        if(sdmForm && (ObjectUtils.checkTrueProperty(sdmForm?.physicalAbuse) >= 1 ||
        ObjectUtils.checkTrueProperty(sdmForm.sexualAbuse) >= 1 ||
        ObjectUtils.checkTrueProperty(sdmForm.generalNeglect) >= 1 ||
        ObjectUtils.checkTrueProperty(sdmForm.arGeneralNeglect) >= 1 ||
        sdmForm.isnegfp_cargiverintervene || sdmForm.isnegab_abandoned ||
        ObjectUtils.checkTrueProperty(sdmForm.unattendedChild) >= 1 ||
        sdmForm.isnegmn_unreasonabledelay ||
        sdmForm.ismenab_psycologicalability ||
        sdmForm.ismenng_psycologicalability ||
        ObjectUtils.checkTrueProperty(sdmForm.riskofHarm) >= 1)
        ){
          return true;  
        }else {
            return false;
        }
    }
    
    sdmValidation(): boolean {
                const intakeSDMObj = this.store[IntakeStoreConstants.intakeSDM];
      if ((intakeSDMObj?.selecttrafficking?.includes('LT') || intakeSDMObj?.selecttrafficking?.includes('ST')) && intakeSDMObj.confirmtrafficking === 'Yes' && this.general.PurposeName !== 'Child Protective Services') {
            this.intakeErrorMessage =
                'Labor/Sex Trafficking referrals are ineligible for Service Case response. Please change Purpose to CPS and complete the intake as an IR';
            $(this.intakeerrorpopupid).modal('show'); 
            return false;
         }
        const narrative = this.store[IntakeStoreConstants.addNarrative];
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const addedUnkPersons = this.store[IntakeStoreConstants.addedUnkPersons];
        const addedQuickPersons = this.store[IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS];
        this.caseCreated = this.store[IntakeStoreConstants.createdCases];
        let isChildPresent = false;
        const isHeadofHousehold = false;
        const isLegalGardianPresent = false;
        if(!this.handleAddedPersonsInConditionalValidationFn(addedPersons, isHeadofHousehold, isChildPresent, addedUnkPersons, isLegalGardianPresent, addedQuickPersons)) {
            return false;
        }
        
        if ((this.store[IntakeStoreConstants.purposeSelected]?.code === this.requestforservices) && (!this.handleIfRequestforservicesFn(this.store[IntakeStoreConstants.addedPersons]))) {
            return false;
        }
        if(!this.handleIfCodeIsROSfn(this.store[IntakeStoreConstants.roacps], this.store[IntakeStoreConstants.purposeSelected])) {
            return false;
        }
        const clearHistoryService = (this.intakeservice && this.intakeservice.length > 0) ? this.intakeservice[0] : null;
        if(this.isCW && !this.handleIfCpshistoryclearanceFn(this.store[IntakeStoreConstants.purposeSelected], this.store[IntakeStoreConstants.clearhistory], clearHistoryService)) {
            return false;
        }
        if ((!intakeSDMObj?.childfatality) && (!intakeSDMObj?.confirmtrafficking)) {
            this.intakeErrorMessage =
                'Child Fatality/Concerns for Trafficking under SDM must have a selection!';
            (<any>$(this.intakeerrorpopupid)).modal('show'); // NOSONAR
            return false;
        }
        if (!intakeSDMObj?.childfatality) {
            this.intakeErrorMessage =
                'Child fatality under SDM must have a selection!';
            (<any>$(this.intakeerrorpopupid)).modal('show'); // NOSONAR
            return false;
        }
        if (!intakeSDMObj?.confirmtrafficking) {
            this.intakeErrorMessage =
                'Concern for Trafficking under SDM must have a selection!';
            (<any>$(this.intakeerrorpopupid)).modal('show'); // NOSONAR
            return false;
        }
        if (this.returnIfSelecttraffickingFn(intakeSDMObj)) {
            this.intakeErrorMessage =
                'Trafficking  dropdown under SDM must have a selection!';
            (<any>$(this.intakeerrorpopupid)).modal('show'); // NOSONAR
            return false;
        }
        return true;
    }

    conditionalValidation(): boolean {
        // @TM - mandatory check for alleged incident date
        const narrative = this.store[IntakeStoreConstants.addNarrative];
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const addedUnkPersons = this.store[IntakeStoreConstants.addedUnkPersons];
        const addedQuickPersons = this.store[IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS];
        const intakeSDMObj = this.store[IntakeStoreConstants.intakeSDM];
        const roacps = this.store[IntakeStoreConstants.roacps];
        this.caseCreated = this.store[IntakeStoreConstants.createdCases];
        let isChildPresent = false;
        const isHeadofHousehold = false;
        const isLegalGardianPresent = false;
        this.handleDADispositionFn();
        const validMaltreatment = this.validateMaltreatmentOverScreenin(intakeSDMObj);
        const isSDMConfigured = this.agencyTabOrder.find(tab => tab.id === 'sdm');

        if(!this.commonInvolvedPersonsValidation(narrative)){
            return false;
        }
        
        if(!this.checkroacps(narrative,roacps)){
               return false;
           }

        if(!this.handleIfSDMConfiguredInConditionalValidationFn(isSDMConfigured, intakeSDMObj, validMaltreatment)) {
            return false;
        }

        //1080 Refinement
        // const validation1080 = this.check1080(intakeSDMObj); // NOSONAR -- As per latest B-230047 user story requirement No alert is displaying
        // if(!validation1080) {
        //     return false;
        // }

        /* if (this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.RISK_OF_HARM_INTAKE)) {
            if (intakeSDMObj && this.isOtherThanRiskHarmSelected()) {
                this.intakeErrorMessage = 'Please change purpose as Child Protection Services as the SDM Maltreatment have selection that makes this Intake irrelevant to Risk of Harm';
                (<any>$(this.intakeerrorpopupid)).modal('show');
                return false;
            }
        } */

        if(!this.handleKinshipPurposeCheck()) {
            return false;
        }

        this.handleIfIntakeserviceHasDataFn();

        if(!this.handleAddedPersonsInConditionalValidationFn(addedPersons, isHeadofHousehold, isChildPresent, addedUnkPersons, isLegalGardianPresent, addedQuickPersons)) {
            return false;
        }
        isChildPresent = this.isChildPresentTemp;
        this.handleIfCpsResponseTypeInConditionalValidationFn(intakeSDMObj);

        if(!this.handleIfRoleIsCWorDJSorASInConditionalValidationFn(roacps, isChildPresent, narrative, addedPersons)) {
            return false;
        }

        const roleId = this._authService.getCurrentUser();
        const disposition = this.store[IntakeStoreConstants.disposition];
        if(!this.checkRolenameCond1InConditionalValidationFn(roleId, disposition, addedPersons)) {
            return false;
        }

        const validateIfRoleIsAS = this.handleIfRoleIsASInConditionalValidationFn();

        if(validateIfRoleIsAS === 'true') {
            return true;
        } else if(validateIfRoleIsAS === false) {
            return false;
        }

        if(!this.handleIfRoleIsNotDjsInConditionalValidationFn()) {
            return false;
        }
        
        if(!this.checkRolenameCond2InConditionalValidationFn(roleId)) {
            return false;
        }

        if(!this.checkRolenameCond3InConditionalValidationFn(roleId)) {
            return false;
        }
        
        if (this.addSdm && this.pathwayChange && !this.addSdm.comments) {
            this._alertService.error('Please fill pathway change comments.');
            return false;
        }
        return true;
    }

    // Assosiated to conditionalValidation method
    private commonInvolvedPersonsValidation(narrative: any){
        let commonInvolvedPersons = this.commonInvolvedPersons?.data || [];
        let quickPersonsHistory = this.store[IntakeStoreConstants.quickPersonsHistory] || [];
        if(commonInvolvedPersons.length || quickPersonsHistory.length) {
            const persons: any[] = this.getperson(commonInvolvedPersons, quickPersonsHistory);
            if(persons.length) {
                const youngestPerson = persons.reduce((min, current) => {
                    let minDate = new Date(min.dob);
                    let currentDtae = new Date(current.dob);
                    return currentDtae > minDate ? current : min;
                });
                let incidentdate = moment(narrative.incidentdate);
                let dateOfbirth = moment(youngestPerson.dob);
                let diff = dateOfbirth.diff(incidentdate, 'months');
                if(diff >= 10) {
                    this.intakeErrorMessage =
                        'Please confirm that the incident date recorded in this intake record is correct. The date of alleged maltreatment cannot be more than 10 months prior to the date of birth of the alleged victim. Please enter a valid date and, if the exact date is unknown, check the ‘Approximate Date’ box';
                        (<any>$(this.intakeerrorpopupid)).modal('show'); // NOSONAR
                        this.errorFrom = 'incident';
                        return false;
                }
            }
        }
        return true;
    }

    private getperson(commonInvolvedPersons: any, quickPersonsHistory: any){
        const persons: any[] = [];
        for (let value of  commonInvolvedPersons) {
            let role = value.roles.filter((item: any) => item.intakeservicerequestpersontypekey === 'AV');
            if(role.length) {
                persons.push(value);
            }
        }
        for (let value of  quickPersonsHistory) {
            let role = value.quickpersonroleconfig.filter((item: any) => item.actortypekey === 'AV');
            if(role.length) {
                persons.push(value);
            }
        }
        return persons;
    }

    // Assosiated to conditionalValidation method
    private handleKinshipPurposeCheck(){
        if(this.Kinshipcheck) {
            const intakeservices = this.store[IntakeStoreConstants.intakeService];
            if(intakeservices && ((intakeservices.some((item: { description: string; }) => item?.description === "informal" || item?.description === "formal")) || intakeservices[0]?.description !== 'I&R')){
                return true;
            }else{
                this._alertService.error('Please select Kinship type.');
                return false;
            }
        } else {
            return true;
        }
    }

    // Assosiated to conditionalValidation method
    private handleDADispositionFn() {
        const DADisposition = this.store[IntakeStoreConstants.disposition];
        if (DADisposition && DADisposition.length > 0) {
            DADisposition.forEach((disp: { dispositioncode: any; supDisposition: any; }) => {
                this.dispcode = disp.dispositioncode;
                this.supDisposition = disp.supDisposition;
            });
        }
    }
    // Assosiated to conditionalValidation method
    private handleIfRoleIsASInConditionalValidationFn() {
        const checkOtheragency = this.departmentActionIntakeFormGroup.value.isOtherAgency && this.departmentActionIntakeFormGroup.value.otheragency === '';
        if (checkOtheragency) {
            this._alertService.error(
                'Please fill request from other agency'
            );
            return false;
        }
        if (!this.isAS || !this.isIntakeWorker) {
            return true;
        }
        this.attachmentCreated = this.store[
            IntakeStoreConstants.attachements
        ];
        if (!this.caseCreated || this.caseCreated.length === 0) {
            return true;
        }
        if (this.checkIfServiceTypeValueFn()) {
            this.getSubCategory();
            if (this.returnAttachmentCreatedConFn()) {
                if (this.returnSubCategoryListCondFn()) {
                    this._alertService.error('Please add attachments');
                    return false;
                }
                this.handleIfAttachmentCreatedLengthIsZeroFn();
                return false;
            }
            this.handleAttachmentCreatedLoopFn();
            if (!this.categoryList || this.categoryList.length === 0) {
                return 'true';
            }
            this.handleIfAttachmentCreatedLengthIsNotZeroFn();
            return false;
        }
        return true
    }
    // Assosiated to conditionalValidation method
    private returnAttachmentCreatedConFn() {
        return (!this.attachmentCreated || this.attachmentCreated.length === 0);
    }
    // Assosiated to conditionalValidation method
    private returnSubCategoryListCondFn() {
        return (!this.subCategoryList || this.subCategoryList.length === 0);
    }
    // Assosiated to conditionalValidation method
    private handleIfAttachmentCreatedLengthIsNotZeroFn() {
        this.missingSubCategory = [];
        for (const element of this.categoryList) {
            this.missingSubCategory.push(
                element.titleheadertext
            );
        }
        (<any>$('#not-generated-subcategories')).modal('show'); // NOSONAR
    }
    // Assosiated to conditionalValidation method
    private handleIfAttachmentCreatedLengthIsZeroFn() {
        this.missingSubCategory = [];
        for (const element of this.subCategoryList) {
            this.missingSubCategory.push(
                element.titleheadertext
            );
        }
        (<any>$('#not-generated-subcategories')).modal('show'); // NOSONAR
    }
    // Assosiated to conditionalValidation method
    private handleAttachmentCreatedLoopFn() {
        this.attachementRequired = this.store['categorySubType'];
        this.categoryList = [...this.attachementRequired];
        this.attachmentCreated.forEach(created => {
            const foundDoc = this.attachementRequired.find(
                required => required.assessmenttemplateid ===
                    created.documentattachment
                        .assessmenttemplateid
            );
            if (foundDoc) {
                this.categoryList.splice(
                    this.categoryList.indexOf(foundDoc),
                    1
                );
            }
        });
    }
    // Assosiated to conditionalValidation method
    private checkIfServiceTypeValueFn() {
        return (this.caseCreated[0].serviceTypeValue === 'Provider' ||
            this.caseCreated[0].subSeriviceTypeValue ===
            'Project Home ' ||
            this.caseCreated[0].subSeriviceTypeValue ===
            'Adult Foster Care');
    }
    // Assosiated to conditionalValidation method
    private handleIfRoleIsNotDjsInConditionalValidationFn() {
        if (this.isDjs) {
            return true;
        }
        const addNarrative = this.store[IntakeStoreConstants.addNarrative];
        if (addNarrative.Narrative === '') {
            this._alertService.error('Please fill narrative');
            return false;
        }

        if (this.returnIfCpsHistoryClearanceIsNullFn(addNarrative)) {
            this._alertService.error('Please fill CPS history clearance');
            return false;
        }

        if (addNarrative.requestercity === '') {
            this._alertService.error('Please fill city');
            return false;
        }

        if (addNarrative.requesterstate === '') {
            this._alertService.error('Please fill state');
            return false;
        }

        if (addNarrative.requestercounty === '') {
            this._alertService.error('Please fill county');
            return false;
        }

        if(!this.anonymousReporterOrUnknownReporterFn(addNarrative)) {
            return false;
        }
        // }
        return true;
    }
    // Assosiated to conditionalValidation method
    private anonymousReporterOrUnknownReporterFn(addNarrative: any) {
        const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-z]{2,}$/;
        if (this.returnIfAnonymousReporterOrUnknownReporter(addNarrative)) {
            if (
                addNarrative.Firstname === '' ||
                addNarrative.Lastname === ''
            ) {
                this._alertService.error(
                    'Please enter reporter details to submit this intake.'
                );
                return false;
            }

            if(addNarrative.email !== '' && !regex.test(addNarrative.email)){
                this._alertService.error(
                    'Please enter Valid email to submit this intake.'
                );
                return false;
            }
        } else if (!addNarrative.RefuseToShareZip && this.intakeInfoNreffGrid) {
            if (addNarrative.ZipCode === '') {
                this._alertService.error(
                    'Please fill zip code in narrative'
                );
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private returnIfAnonymousReporterOrUnknownReporter(addNarrative: any) {
        return !addNarrative.IsAnonymousReporter &&
            !addNarrative.IsUnknownReporter &&
            !this.intakeInfoNreffGrid;
    }
    // Assosiated to conditionalValidation method
    private returnIfCpsHistoryClearanceIsNullFn(addNarrative: any) {
        return addNarrative.cpsHistoryClearance === '' || addNarrative.cpsHistoryClearance === null;
    }
    // Assosiated to conditionalValidation method
    private handleIfIntakeserviceHasDataFn() {
        if (this.intakeservice.length > 0) {
            const service = this.intakeservice[0];
            const isInHomeService =
                service.description === this.inhomeservices ? true : false;
            if (isInHomeService) {
                this.departmentActionIntakeFormGroup.controls['IntakeServiceSubtype'].setValidators([Validators.required]);
            } else {
                this.departmentActionIntakeFormGroup.controls['IntakeServiceSubtype'].clearValidators();
                this.departmentActionIntakeFormGroup.controls['IntakeServiceSubtype'].updateValueAndValidity();
            }
        }
    }
    // Assosiated to conditionalValidation method
    private handleIfSDMConfiguredInConditionalValidationFn(isSDMConfigured: any, intakeSDMObj: any, validMaltreatment: boolean) {
        if (isSDMConfigured ) {
            if(!this.handleIfIntakeSDMObjCond1Fn(intakeSDMObj)) {
                return false;
            }

            if(!this.handleIfIntakeSDMObjCond2Fn(intakeSDMObj, validMaltreatment)) {
                return false;
            }    
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfIntakeSDMObjCond2Fn(intakeSDMObj: any, validMaltreatment: any) {
        if(!validMaltreatment && (this.dispcode !== 'ScreenOUT' || this.supDisposition === 'Scrnin' || this.supDisposition === 'Ovrscrnin')){
            this.intakeErrorMessage =
                'Please select alteast one Maltreatment type to proceed.';
            (<any>$(this.intakeerrorpopupid)).modal('show'); // NOSONAR
            return false;
        }
        if(this.transferHistory){
          let count = 0;
            this.transferHistory.forEach((item: { receivingcountyworkername: string; })=>{
              if(item.receivingcountyworkername === 'Assign')  {
                     count ++;
        }

            })
         if(count>0){
            this.intakeErrorMessage =
            'Please review and approve the Transfer request and assign to an intake worker to review and submit for the Intake review to perform this action.';
         $(this.intakeerrorpopupid).modal('show'); // NOSONAR
         return false;
        }
         }

        if (intakeSDMObj && (intakeSDMObj.isfinalscreenin === true || intakeSDMObj.isfinalscreenin === 'true') && (intakeSDMObj.immediate === '' || intakeSDMObj.immediate === null )) {
            this.intakeErrorMessage =
                'Response Time Decision under SDM must be updated!';
          $(this.intakeerrorpopupid).modal('show'); // NOSONAR
            return false;
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfIntakeSDMObjCond1Fn(intakeSDMObj: any) {    // NOSONAR
        if (!intakeSDMObj) {
            this.intakeErrorMessage =
            'Provider Involved Maltreatment under SDM must have a selection!';
            $(this.intakeerrorpopupid).modal('show'); 
            return false;
        }
        if (intakeSDMObj && !intakeSDMObj.childfatality) {
            this.intakeErrorMessage =
                'Child fatality under SDM must have a selection!';
            $(this.intakeerrorpopupid).modal('show'); 
            return false;
        }
        if (intakeSDMObj && intakeSDMObj.isseriousphysicalinjury == null) {
            this.intakeErrorMessage =
                'Near-Death/Serious Physical Injury under SDM must have a selection!';
            $(this.intakeerrorpopupid).modal('show'); 
            return false;
        }
        if (intakeSDMObj && !intakeSDMObj.maltreatment) {
            this.intakeErrorMessage =
                'Provider Involved Maltreatment under SDM must have a selection!';
            $(this.intakeerrorpopupid).modal('show'); 
            return false;
        }
        if (intakeSDMObj && !intakeSDMObj.confirmtrafficking) {
            this.intakeErrorMessage =
                'Concern for Trafficking under SDM must have a selection!';
            $(this.intakeerrorpopupid).modal('show');
            return false;
        }
        if (this.returnIfSelecttraffickingFn(intakeSDMObj)) {
            this.intakeErrorMessage =
                'Trafficking  dropdown under SDM must have a selection!';
           $(this.intakeerrorpopupid).modal('show');
            return false;
        } else if(intakeSDMObj?.selecttrafficking){
            let selecttraffic = '';
            if (Array.isArray(intakeSDMObj.selecttrafficking)) {
                intakeSDMObj.selecttrafficking.forEach((selectval: any, index: any) => {
                    selecttraffic =	index == 0 ? selectval : (selecttraffic + ','+selectval);
                });
                intakeSDMObj.selecttrafficking = selecttraffic
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private returnIfSelecttraffickingFn(intakeSDMObj: any) {
        return intakeSDMObj && intakeSDMObj.confirmtrafficking === 'Yes' && (!intakeSDMObj?.selecttrafficking || intakeSDMObj?.selecttrafficking?.length == 0);
    }
    // Assosiated to conditionalValidation method
    private checkRolenameCond3InConditionalValidationFn(roleId: any) {
        if (!this.returnCheckRolenameCond3InConditionalValidationFn(roleId)) {
            return true;
        }
        const law_enforcement = this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.REFERRAL.LAW_ENFORCEMENT);
        const interstate_compact = this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.REFERRAL.INTERSTATE_COMPACT);
        const adult_hold_detention = this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION);

        if (law_enforcement) {
            if(!this.handleLawenforcementCondFn()) {
                return false;
            }
        }
        if (interstate_compact) {
            if(!this.handleInterstateCompactCondFn()) {
                return false;
            }            
        }
        if (adult_hold_detention) {
            const resedentialStatus = this._dataStoreService.getData(
                'ResedentialPlacementStatus'
            );
            if (resedentialStatus) {
                this._alertService.warn(
                    'Youth already in Residential Placement. Adult Hold cannot be processed.'
                );
                return false;
            }
            const addedPlacement = this.store[
                IntakeStoreConstants.addedPlacement
            ];
            if (!addedPlacement) {
                this._alertService.warn(
                    'Please add placement for Adult Hold.'
                );
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleReturnIfCreatedCasesInInterstatecompactCond(createdCases: any, focusPersoncasedetails: any) {
        if (!focusPersoncasedetails) {
            this._alertService.error(
                this.fillinterstatecompact +
                createdCases[0].subSeriviceTypeValue +
                ' details!'
            );
            return false;
        }
        const icjformvalid = this.store[
            IntakeStoreConstants
                .FocuspersonCaseDetailsFormValid
        ];
        if (!icjformvalid) {
            this._alertService.error(
                this.fillinterstatecompact +
                createdCases[0].subSeriviceTypeValue +
                ' details!'
            );
            return false;
        }
        if (
            createdCases[0].subSeriviceTypeValue ===
            MyNewintakeConstants.Intake
                .ICJRequisitionDuetoWarrant
        ) {
            if (
                !focusPersoncasedetails.requisitiontypekey
            ) {
                this._alertService.error(
                    this.fillinterstatecompact +
                    createdCases[0]
                        .subSeriviceTypeValue +
                    ' details!'
                );
                return false;
            }
        } else if (!focusPersoncasedetails.maxdateofexpiration) {
            this._alertService.error(
                this.fillinterstatecompact +
                createdCases[0].subSeriviceTypeValue +
                ' details!'
            );
            return false;
        }
        if(!this.handleReturnIfResidingwithdetailsInInterstatecompactCond(createdCases, focusPersoncasedetails)) {
            return false;
        }
        return true
    }
    // Assosiated to conditionalValidation method
    private handleReturnIfResidingwithdetailsInInterstatecompactCond(createdCases: any, focusPersoncasedetails: any) {
        if (!focusPersoncasedetails.demandingstate && !focusPersoncasedetails.countyid) {
            this._alertService.error(this.fillinterstatecompact + createdCases[0].subSeriviceTypeValue + ' details!');
            return false;
        }
        if (!focusPersoncasedetails.residingwithdetails) {
            this._alertService.error(this.fillinterstatecompact + createdCases[0].subSeriviceTypeValue + ' details!');
            return false;
        }
        if (focusPersoncasedetails.residingwithdetails && focusPersoncasedetails.residingwithdetails.length <= 0) {
            this._alertService.error(this.fillinterstatecompact + createdCases[0].subSeriviceTypeValue + ' details!');
            return false;
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleInterstateCompactCondFn() {
        const createdCases = this.store[
            IntakeStoreConstants.createdCases
        ];
        if (!createdCases || createdCases.length === 0) {
            return true;
        }
        if (this.returnIfCreatedCasesInInterstatecompactCond(createdCases)) {
            const focusPersoncasedetails = this.store[
                IntakeStoreConstants.FocuspersonCaseDetails
            ];
            if(!this.handleReturnIfCreatedCasesInInterstatecompactCond(createdCases, focusPersoncasedetails)) {
                return false;
            }
            // } else {
            //     this._alertService.error(
            //         this.fillinterstatecompact +
            //         createdCases[0].subSeriviceTypeValue +
            //         ' details!'
            //     );
            //     return false;
            // }
        }
        // }
        return true;
    }
    // Assosiated to conditionalValidation method
    private returnIfCreatedCasesInInterstatecompactCond(createdCases: any) {
        return (createdCases[0].subSeriviceTypeValue ===
            MyNewintakeConstants.Intake
                .ICJRequisitionDuetoWarrant ||
            createdCases[0].subSeriviceTypeValue ===
            MyNewintakeConstants.Intake.ICJReceivingProbation ||
            createdCases[0].subSeriviceTypeValue ===
            MyNewintakeConstants.Intake.ICJReentry);
    }
    // Assosiated to conditionalValidation method
    private returnIfWarranttypeIsNonDelinquent(lawenforcementdetails: any) {
        return lawenforcementdetails.warranttype ===
            'Non-Delinquent' &&
            (lawenforcementdetails.isdetaintheyouth === null ||
                lawenforcementdetails.isdetaintheyouth ===
                undefined ||
                lawenforcementdetails.isdetaintheyouth === '');
    }
    // Assosiated to conditionalValidation method
    private handleLawenforcementCondFn() {
        const lawenforcementdetails = this.store[
            IntakeStoreConstants.FocuspersonCaseDetails
        ];
        if (!lawenforcementdetails) {
            this._alertService.error(
                this.fillyouthwarrantnotifymsg
            );
            return false;
        }
        if (lawenforcementdetails.iswritwarrant) {
            if (!lawenforcementdetails.warranttype) {
                this._alertService.error(
                    this.fillyouthwarrantnotifymsg
                );
                return false;
            }
            if (this.returnIfWarranttypeIsNonDelinquent(lawenforcementdetails)) {
                this._alertService.error(
                    this.fillyouthwarrantnotifymsg
                );
                return false;
            }
            if (!lawenforcementdetails.warranttypedetails) {
                this._alertService.error(
                    this.fillyouthwarrantnotifymsg
                );
                return false;
            }
            if (lawenforcementdetails.warranttypedetails <= 0) {
                this._alertService.error(
                    this.fillyouthwarrantnotifymsg
                );
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private returnCheckRolenameCond3InConditionalValidationFn(roleId: any) {
        return (this.isDjs && (roleId.role.name === AppConstants.ROLES.SUPERVISOR || roleId.role.name === AppConstants.ROLES.INTAKE_WORKER || roleId.role.name === AppConstants.ROLES.OFFICE_PROFFESSIONAL));
    }
    // Assosiated to conditionalValidation method
    private checkRolenameCond2InConditionalValidationFn(roleId: any) {
        if (this.returnCheckRolenameCond2InConditionalValidationFn(roleId)) {
            const evalFields = this._dataStoreService.getData(
                IntakeStoreConstants.evalFields
            );
            if (evalFields && evalFields.length > 0) {
                const mcaspreq = evalFields.filter((data: { isMcapsReq: any; }) => data.isMcapsReq);
                if (mcaspreq && mcaspreq.length > 0) {
                    const mcaspcompleted = evalFields.filter((data: { MCASPCompleted: any; }) => data.MCASPCompleted);
                    if (!mcaspcompleted || mcaspcompleted.length === 0) {
                    // } else {
                        this._alertService.error(
                            'Please complete MCASP RISK ASSESSMENT'
                        );
                        return false;
                    }
                }
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private returnCheckRolenameCond2InConditionalValidationFn(roleId: any) {
        return (this.isDjs &&
            !this._intakeConfig.selectedPurposeIs(
                MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION
            ) &&
            (roleId.role.name === AppConstants.ROLES.INTAKE_WORKER ||
                (roleId.role.name === AppConstants.ROLES.SUPERVISOR &&
                    this.intakeStore.action === 'add')));
    }
    // Assosiated to conditionalValidation method
    private checkRolenameCond1InConditionalValidationFn(roleId: any, disposition: any, addedPersons: any) {
        const roleName = roleId.role.name;
        const isSupervisor = roleName === AppConstants.ROLES.SUPERVISOR;
        const isOfficeProfessional = roleName === AppConstants.ROLES.OFFICE_PROFFESSIONAL;

        if (!isOfficeProfessional && !isSupervisor) {
            if (!disposition || disposition.length === 0) {
                this._alertService.error('Please fill status and decision');
                return false;
            }
            if(!this.checkFirstDispositionDataFn(disposition[0])) {
                return false;
            }
        } else if (isSupervisor) {
            if(!this.IfisSupervisorFn(addedPersons, disposition)) {
                return false;
            }
            // } else {
            //     this._alertService.error('Please fill status and disposition');
            //     return false;
            // }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private checkFirstDispositionDataFn(disposition: any) {
        const firstDispositionData = disposition;
        if (!firstDispositionData.dispositioncode || !firstDispositionData.intakeserreqstatustypekey) {
            this._alertService.error('Please fill status and disposition');
            return false;
        }
        if (this.general.PurposeName === this.informationandreferral) {
            if (!firstDispositionData.intakeAction) {
                this._alertService.error('Please select Action Taken');
                return false; //Action Taken is mandatory for information and referral cases
            } 
            if (!firstDispositionData.agencyType) {
                this._alertService.error('Please select Agency Type');
                return false; //Agency Type is mandatory for information and referral cases
            }
        }
        if (firstDispositionData.restitution && this.isPaymentScheduleEmpty()) {
            this._alertService.error('Please add payment schedules.');
            return false;
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private IfisSupervisorFn(addedPersons: any, disposition: any) {
        if (!disposition || disposition.length === 0) {
            this._alertService.error('Please fill status and disposition');
            return false;
        }

        const firstDispositionData = disposition[0];
        const timeLeft = this.store[IntakeStoreConstants.timeleft];

        if (!firstDispositionData.supStatus) {
            this._alertService.error('Please select the status');
            return false;
        }

        // Non CPS we don't want the delay reason
        if (!this._intakeConfig.isNonCPS() && timeLeft === 'Overdue' && !firstDispositionData.reason) {
            this._alertService.error(
                'Please input the reason for delay'
            );
            return false;
        }

        if (!firstDispositionData.supDisposition) {
            this._alertService.error(
                'Please select case, decision and then save'
            );
            return false;
        }
        // D-11889 - CJAMS - CW -  Decision Tab
        if ((firstDispositionData.supDisposition !== firstDispositionData.dispositioncode) && !firstDispositionData.supComments) {
            this._alertService.error(
                'Please fill the comments in decision'
            );
            return false;
        }
        if (firstDispositionData.supRestitution && this.isPaymentScheduleEmpty()) {
            this._alertService.error(
                'Please add payment schedules.'
            );
            return false;
        }
        
        if (this.roleId.role.teamtypekey === 'CW' && this.isFPSIntakeServiceSubtype(disposition)) {
                if (!this.validateChildAge(addedPersons)) {
                    this._alertService.error(
                        'To be able to accept, there must be one adult(18 and over) and one child(birth to 18 years) in the case'
                    );
                    return false;
                }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private isFPSIntakeServiceSubtype(disposition: any) {
        return (this.intakeservicesubtype &&
            this.intakeservicesubtype.filter(
                item => item.intakeservsubtypekey === 'FPS'
            ).length &&
            disposition[0].supStatus === 'Approved');
    }
    // Assosiated to conditionalValidation method
    private isPaymentScheduleEmpty(): boolean {
        const scheduledPayments = this.store[IntakeStoreConstants.paymentSchedule];
        return !scheduledPayments || scheduledPayments.length === 0;
    }
    // Assosiated to conditionalValidation method
    private handleIfRoleIsCWorDJSorASInConditionalValidationFn(roacps: any, isChildPresent: boolean, narrative: any, addedPersons: any) {
        if (!this.isCW) {
            if(!this.handleIfNotCWfn()) {
                return false;
            }
            return true
        }
        const purpose = this.store[IntakeStoreConstants.purposeSelected];
        const service = (this.intakeservice && this.intakeservice.length > 0) ? this.intakeservice[0] : null;
        const clearHistory = this.store[IntakeStoreConstants.clearhistory];

        if(!this.handleIfCpshistoryclearanceFn(purpose, clearHistory, service)) {
            return false;
        }

        // D-15457/Aug22:-CHESIE/Business teams do not want 'add child' validation for this.requestforservices
        if(!this.handleIfCodeIsNotROACPSorKingshipnavigationFn(purpose, isChildPresent)) {
            return false;
        }
        if (this.isPurposeNotCPS) {
            this.isPurposeNotCPS = false; // reset the value
            this._alertService.error(
                'Choose Child Protective Services as the Purpose'
            );
            return false;
        }
        if (this.isRcvdDtBeforeDob) {
            this.isRcvdDtBeforeDob = false; // reset the value
            this._alertService.error(
                'Received Date has to be after the Date Of Birth of the Child'
            );
            return false;
        }

        // @TM: Date of Alleged Incident validation
        if(!this.handleIfAllegedIncidentValidationFn(purpose, narrative, addedPersons)) {
            return false;
        }

        if(!this.handleIfIAndRsubtypeIsEmpty(narrative, purpose)) {
            return false;
        }

        if (this.departmentActionIntakeFormGroup.get('IntakeService')?.value && this.selectedCheckbox === this.inhomeservices && !this.departmentActionIntakeFormGroup.get('IntakeServiceSubtype')?.value) {
            this._alertService.error('Please select In-Home Service subtype to submit intake');
            return false;
        }

        if(!this.handleIfCodeIsROSfn(roacps, purpose)) {
            return false;
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfCodeIsROSfn(roacps: any, purpose: any) {
        if (purpose?.code === 'ROACPS') {
            if (!roacps) {
                this._alertService.error('Please fill in the ROA CPS tab details to submit intake.');
                return false;
            }
            if (!roacps.servicerequested) {
                this._alertService.error('Please fill Type of Services Requested  under ROA CPS tab.');
                return false;
            }
            if (!roacps.statetype) {
                this._alertService.error('Please fill state type  under ROA CPS tab.');
                return false;
            }
            if (roacps.statetype === 'instate' && !roacps.cpsid) {
                this._alertService.error('Please fill cpsid  under ROA CPS tab.');
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfIAndRsubtypeIsEmpty(narrative: any, purpose: any) {
        if (purpose && purpose.code === this.kinshipnavigation && this.isIAndRSelected && this.departmentActionIntakeFormGroup.controls['iAndRsubtype'].value == '') {
            if (this.reuseCondIfRoleIsREPfn(narrative)) {
                this._alertService.error(
                    'Please select I&R Sub Type to submit intake'
                );
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfAllegedIncidentValidationFn(purpose: any, narrative: any, addedPersons: any) {
        if (purpose && purpose.code === 'CHILD') {
            if (!narrative.incidentdate || (narrative.incidentdate && narrative.incidentdate === '')) {
                this._alertService.error(
                    'Please enter Date of Alleged Incident under Narrative tab to submit intake'
                );
                return false;
            }
        }

        if (purpose && purpose.code === this.requestforservices) {
            if(!this.handleIfRequestforservicesFn(addedPersons)) {
                return false;
            }
        }

        if (purpose && purpose.code !== this.informationandreferral) {
            if (this.reuseCondIfRoleIsREPfn(narrative)) {
                this._alertService.error(
                    'Please select Role under Narrative tab to submit intake'
                );
                return false;
            }
        }
        
        return true;
    }
    // Assosiated to conditionalValidation method
    private reuseCondIfRoleIsREPfn(narrative: any) {
        return (!narrative.IsAnonymousReporter && !narrative.IsUnknownReporter && (!narrative.Role || (narrative.Role && (narrative.Role === '' || narrative.Role === 'Rep'))));
    }
    // Assosiated to conditionalValidation method
    private handleIfCodeIsNotROACPSorKingshipnavigationFn(purpose: any, isChildPresent: any) {
        if (purpose && purpose.code !== this.informationandreferral && purpose.code !== 'ROACPS' && purpose.code !== this.requestforservices && purpose.code !== this.kinshipnavigation) {
            if (!isChildPresent && !this.isClearenceHistory) {
                if (this.dispcode !== 'ScreenOUT' && !this.unknown && !this.quickidentified) {
                    this._alertService.error('Please add Child.');
                    return false;
                }
            }
            if (this.roleValue === false && !this.isClearenceHistory && !this.unknown && this.dispcode !== 'ScreenOUT' ||
                this.roleValue === false && !this.isClearenceHistory && !this.quickidentified && this.dispcode !== 'ScreenOUT') {
                this._alertService.error(
                    'Please add Reported Child as primary role.'
                );
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfRequestforservicesFn(addedPersons: any) {
        if (this.intakeservice?.length === 0 || (this.intakeservice?.length > 0 && !this.intakeservice[0]?.description)) {
                this._alertService.error(
                    'Please select atleast one Service type to proceed further '
                );
                return false;
        } else if (this.returnHandleIfRequestforservicesCond1Fn()) {
                this._alertService.error(
                    'Please select In-Home Service subtype to proceed further '
                );
                return false;
        } else if (this.returnHandleIfRequestforservicesCond2Fn()) {
                const pvtadchild = addedPersons.filter((person: any) => {
                    const validRoles = person.personRole.find((item: { rolekey: string; }) => item.rolekey === 'PVTADPCHILD');
                    if (validRoles) {
                        return true;
                    } else {
                        return false;
                    }
                });
                if (!pvtadchild.length) {
                    this._alertService.error(
                        'Private Adoption Subsidy can only be availed by child with role \'Private Adoptive Child\'.'
                    );
                    return false;
                }
        }
        if(!this.handleIfIndependentLivingCond(addedPersons)) {
            return false
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private returnHandleIfRequestforservicesCond2Fn() {
        return (this.intakeservice &&
            this.intakeservice.some(item => (item.description === this.privateadoptionsubsidy)));
    }
    // Assosiated to conditionalValidation method
    private returnHandleIfRequestforservicesCond1Fn() {
            return (this.intakeservice && this.intakeservice?.some(
                item => (item?.description === this.inhomeservices && (item?.intakesubservice === undefined  || this.isSubTypeSelected === false))));      
    }
    // Assosiated to conditionalValidation method
    private handleIfIndependentLivingCond(addedPersons: any) {
        if (this.isIndependentLiving) {
            const validPersonsForIPL = addedPersons.filter((person: any) => {
                const validAge = moment().diff(person.Dob, 'years', true) >= 16;
                const validRoles = person.personRole.find((item: { rolekey: string; }) => item.rolekey === 'CHILD');
                if (validAge && validRoles) {
                    return true;
                } else {
                    return false;
                }
                });
            if (!validPersonsForIPL.length) {
                this._alertService.error(
                    'Independent Living is allowed only for Child(ren) greater than 16 years old.'
                );
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfCpshistoryclearanceFn(purpose: any, clearHistory: any, service: any) {
        if (purpose?.code === this.requestforservices && service?.description === this.cpshistoryclearance) {
            if (!clearHistory) {
                this._alertService.error('Please fill in the CPS History Clearance tab details to submit intake.');
                return false;
            }
            if (!clearHistory.reason) {
                this._alertService.error('Please fill Reason for CPS History Clearance.');
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfNotCWfn() {
        if (this.isDjs) {
            if (this.roleValue === false) {
                this._alertService.error('Please add user of role Youth.');
                return false;
            }
        } else if (this.isAS) {
            if (this.roleValue === false) {
                if (
                    this.caseCreated &&
                    this.caseCreated.length > 0 &&
                    this.caseCreated[0].serviceTypeValue !== 'Provider'
                ) {
                    this._alertService.error(
                        'Please add Reported Adult as primary role.'
                    );
                }
                return false;
            }
        }
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfCpsResponseTypeInConditionalValidationFn(intakeSDMObj: any) {
        if (intakeSDMObj && intakeSDMObj.cpsResponseType &&
            (intakeSDMObj.cpsResponseType === 'CPS-AR' ||
                intakeSDMObj.cpsResponseType === 'CPS-IR')) { // @TM: CPS IR & CPS AR over-ride SEN cases
            this.isSENflag = false;
        } else if (intakeSDMObj && intakeSDMObj.riskofHarm &&
            (ObjectUtils.checkTrueProperty(intakeSDMObj.riskofHarm) ?? 0) >= 1) {
            this.isSENflag = true;
        }
    }
    // Assosiated to conditionalValidation method
    private handleAddedPersonsInConditionalValidationFn(addedPersons: any, isHeadofHousehold: boolean, isChildPresent: boolean, addedUnkPersons: any, isLegalGardianPresent: boolean, addedQuickPersons: any) {
        if (this.isAddedPersonsEmpty(addedPersons)) {
            return this.handleEmptyAddedPersons(addedUnkPersons, addedQuickPersons);
        }
        const addPersonTempData = this.checkIfHeadOfHousehold(addedPersons);

        return this.processAddedPersons(addedPersons, addPersonTempData, isChildPresent, isLegalGardianPresent);
    }
    // Assosiated to conditionalValidation method
    private processAddedPersons(
        addedPersons: any,
        isHeadofHousehold: boolean,
        isChildPresent: boolean,
        isLegalGardianPresent: boolean
    ): boolean {
        addedPersons?.map((item: any) => {
            // @TM: Set ROH (Risk of Harm) flag for SEN (Substance Exposed New-born) case
            if (item.drugexposednewbornflag === 1) {
                this.isSENflag = true;
            } else {
                this.isSENflag = false;
            }
            if (this.isDjs) {
                if (item.Role === 'Youth') {
                    this.roleValue = true;
                }
                return true;
            }
            const roles = item.personRole;
            isChildPresent = this.handleIfUnknownPersonsTempInConditionalValidationFn(item, roles, isChildPresent); 
            isChildPresent = this.handleIfAddedQuickPersonsTempInConditionalValidationFn(isChildPresent);
            isChildPresent = this.handleIfPersonroleInConditionalValidationFn(item, isChildPresent);
            this.isChildPresentTemp = isChildPresent;
            this.handleIfFetalalcoholspctrmdisordflagFn(item);

            const isLG = roles.some((role: { rolekey: string; }) => role.rolekey === 'LG');

            if (isLG) {
                this.departmentActionIntakeFormGroup.patchValue({
                    LegalGuardian: item.fullName
                });
            }
            if (!this.caseCreated || this.caseCreated.length === 0) {
                return true
            }
            if (this.caseCreated[0].serviceTypeValue === 'Provider') {
                if (this.isAS) {
                    if (item.Role === 'PA') {
                        this.roleValue = true;
                    } else {
                        this.roleValue = false;
                        this._alertService.error(
                            'Please add Provider Applicant as primary role.'
                        );
                        return false;
                    }
                }
            }
        });
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfFetalalcoholspctrmdisordflagFn(item: any) {
        if (item.Role === 'RC' && (item.drugexposednewbornflag || item.fetalalcoholspctrmdisordflag)) {
            if (!this._intakeConfig.selectedPurposeIs(
                MyNewintakeConstants.PURPOSE
                    .CHILD_PROTECTION_SERVICES
            )) {
                this.isPurposeNotCPS = true;
            }

            if (!_.isEmpty(item.Dob)) {
                const receivedDt = this.departmentActionIntakeFormGroup.getRawValue()
                    .RecivedDate;
                const DobDt = moment(item.Dob, this.dtformat1);
                if (moment(receivedDt).isBefore(DobDt)) {
                    this.isRcvdDtBeforeDob = true;
                }
            }
        }
    }
    // Assosiated to conditionalValidation method
    private handleIfPersonroleInConditionalValidationFn(item: any, isChildPresent: boolean) {
        const personrole = item.personRole;
        personrole.map((person: { rolekey: string; }) => {
            if ([
                'BIOCHILD',
                'CHILD',
                'NVC',
                'OTHERCHILD',
                'PAC',
                'RC'
            ].includes(person.rolekey)) {
                isChildPresent = true;
                this.roleValue = true;
            }
            if (person.rolekey === 'AV') {
                isChildPresent = true;
                this.roleValue = true;
            }
            if (person.rolekey === 'RA' || item.Role === 'CLI') {
                this.roleValue = true;
            }
        });
        return isChildPresent;
    }
    // Assosiated to conditionalValidation method
    private handleIfAddedQuickPersonsTempInConditionalValidationFn(isChildPresent: boolean) {
        const addedQuickPersonsTemp = this._dataStoreService.getData(
            IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);
        if (addedQuickPersonsTemp) {
            addedQuickPersonsTemp.forEach((element: any) => {
                const qpchild = element.quickpersonroleconfig?.filter((rol: any) => rol.description === 'Child');
                if (qpchild) {
                    isChildPresent = true;
                    this.roleValue = true;
                }
                const qpav = element.quickpersonroleconfig?.filter((rol: any) => rol.description === this.allegedvictim);
                if (qpav) {
                    this.roleValue = true;
                }
            });
        }
        return isChildPresent;
    }
    // Assosiated to conditionalValidation method
    private handleIfUnknownPersonsTempInConditionalValidationFn(item: any, roles: any, isChildPresent: boolean) {
        if (item.Role === undefined) {
            // quick for a blocker issue
            item.Role =
                item.personRole !== undefined
                    ? item.personRole.role
                    : '';
            if (roles && roles.length > 0) {
                item.Role = roles[0].rolekey;
            }
        }
        const unknownPersonsTemp = this._dataStoreService.getData(
            IntakeStoreConstants.addedUnkPersons);
        if (unknownPersonsTemp) {
            unknownPersonsTemp.forEach((element: { role: string; }) => {
                if (element.role === 'Child') {
                    isChildPresent = true;
                    this.roleValue = true;
                }
            });
        }
        return isChildPresent;
    }
    // Assosiated to conditionalValidation method
    private handleEmptyAddedPersons(addedUnkPersons: any, addedQuickPersons: any): boolean {
        this.handleIfAddedUnkPersonsFn(addedUnkPersons); 
        if (!addedQuickPersons || addedQuickPersons.length === 0) {
            if (this.dispcode === 'ScreenOUT') {
                if (this.supDisposition === 'Scrnin' || this.supDisposition === 'Ovrscrnin'){
                    this._alertService.error(this.addpersonnotifymsg);
                    return false;
                }
            } else {
                this._alertService.error(this.addpersonnotifymsg);
                return false;
            }
        }
        this.handleIfAddedQuickPersonsFn(addedQuickPersons);
        return true;
    }
    // Assosiated to conditionalValidation method
    private handleIfAddedQuickPersonsFn(addedQuickPersons: any) {
        if (!addedQuickPersons) {
            this.quickidentified = false;
            if (this.dispcode === 'ScreenOUT') {
                if (this.supDisposition === 'Scrnin' || this.supDisposition === 'Ovrscrnin') {
                    this._alertService.error(this.addpersonnotifymsg);
                    return false;
                }
            } else {
                this._alertService.error(this.addpersonnotifymsg);
                return false;
            }
        } else {
            addedQuickPersons.forEach((person: any) => {
                const qproles = person?.quickpersonroleconfig?.filter((rol: { description: string; }) => rol.description === 'Child' || rol.description === this.allegedvictim);
                if (qproles) {
                    this.quickidentified = true;
                    this.roleValue = true;
                } else {
                    this.quickidentified = false;
                    if (this.dispcode === 'ScreenOUT') {
                        if (this.supDisposition === 'Scrnin' || this.supDisposition === 'Ovrscrnin') {
                            this._alertService.error(this.addpersonnotifymsg);
                            return false;
                        }
                    } else {
                        this._alertService.error(this.addpersonnotifymsg);
                        return false;
                    }
                }
            });
        }
        
    }
    // Assosiated to conditionalValidation method
    private handleIfAddedUnkPersonsFn(addedUnkPersons: any) {
        if (addedUnkPersons && addedUnkPersons.length > 0) {
            addedUnkPersons.map((person: any) => {
                if (person.role === 'Child' || person.role === this.allegedvictim) {
                    this.unknown = true;
                } else {
                    this.unknown = false;
                    if (this.dispcode !== 'ScreenOUT') {
                        this._alertService.error(this.addpersonnotifymsg);
                        return false;
                    }
                    if (this.returDispositionInhandleIfAddedUnkPersonsFn()) {
                        this._alertService.error(this.addpersonnotifymsg);
                        return false;
                    }
                }
            });
        }
    }
    // Assosiated to conditionalValidation method
    private returDispositionInhandleIfAddedUnkPersonsFn() {
        return (this.supDisposition === 'Scrnin' || this.supDisposition === 'Ovrscrnin');
    }
    // Assosiated to conditionalValidation method
    private isAddedPersonsEmpty(addedPersons: any) {
        return (!addedPersons || addedPersons.length === 0);
    }
    // Assosiated to conditionalValidation method
    private checkIfHeadOfHousehold(addedPersons: any): boolean {
        const headofhouseholdlist = addedPersons.filter((person: any) => person.isheadofhousehold === true);
        return headofhouseholdlist.length === 0;
    }

    getSelectedPurpose(purposeID: any) {
        if (this.purposeList) {

            const purpose = this.purposeList.find(
                puroposeItem => puroposeItem.intakeservreqtypeid === purposeID
            );
            return purpose ? purpose : this.purposeList[0];
        }
        return null;
    }

    private mapIntakeScreenInfo(model: General): IntakeScreen {
        const intakeScreen = new IntakeScreen();
        const addNarrative = this.store[IntakeStoreConstants.addNarrative];
        if (addNarrative) {
            model.cpsHistoryClearance = addNarrative.cpsHistoryClearance;
            model.Narrative = addNarrative.Narrative;
            model.IsAnonymousReporter = addNarrative.IsAnonymousReporter;
            model.IsUnknownReporter = addNarrative.IsUnknownReporter;
            model.RefuseToShareZip = addNarrative.RefuseToShareZip;
            model.offenselocation = addNarrative.offenselocation;
            model.narrativeUpdatedDate = addNarrative.narrativeUpdatedDate;
            model.addendumNarrative =addNarrative.addendumNarrative;
            model.isaddendumnarrativeupdated =addNarrative.isaddendumnarrativeupdated;
            intakeScreen.NarrativeIntake = [].concat.apply(
                Object.assign({
                    Firstname: addNarrative.Firstname,
                    Lastname: addNarrative.Lastname,
                    Middlename: addNarrative.Middlename,
                    PhoneNumber: addNarrative.PhoneNumber,
                    PhoneNumberExt: addNarrative.PhoneNumberExt,
                    ZipCode: addNarrative.ZipCode,
                    Role: addNarrative.Role,
                    RoleName: addNarrative.RoleName,
                    organization: addNarrative.organization,
                    title: addNarrative.title,
                    incidentlocation: addNarrative.incidentlocation,
                    incidentdate: addNarrative.incidentdate,
                    isapproximate: addNarrative.isapproximate,
                    email: addNarrative.email,
                })
            );
        }

        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        if (addedPersons) {
            intakeScreen.Person = addedPersons.map((item: any) => {
                ObjectUtils.removeEmptyProperties(item);
                return new Person(item);
            });
        }

        intakeScreen.EvaluationField = this.store[
            IntakeStoreConstants.evalFields
        ];
        intakeScreen.Appointments = this.store[
            IntakeStoreConstants.intakeappointment
        ];

        if (this.addedIntakeDATypeDetails) {
            intakeScreen.DAType.DATypeDetail = this.addedIntakeDATypeDetails.map(
                item => new DATypeDetail(item)
            );
        }

        const addedCrossReference = this.store[
            IntakeStoreConstants.addedCrossReference
        ];
        if (addedCrossReference) {
            intakeScreen.CrossReferences = addedCrossReference.map(
                (item: any) => new CrossReference(item)
            );
        }

        intakeScreen.Recording.Recordings = this.store[
            IntakeStoreConstants.communications
        ];
        intakeScreen.General = model;
        // intakeScreen.Allegations = [].concat.apply(
        //     [],
        //     this.addedIntakeDATypeDetails.map(item => { return item.Allegations;})
        // );
        intakeScreen.Allegations = this.addedIntakeDATypeDetails?.flatMap(item => item.Allegations);
        
        const addedEntities = this.store[IntakeStoreConstants.addedEntities];
        if (addedEntities) {
            intakeScreen.Agency = addedEntities.map((item: any) => new Agency(item));
        }
        intakeScreen.AttachmentIntake = this.store[
            IntakeStoreConstants.attachments
        ];

        return intakeScreen;
    }

    private populateIntake() {
        const roleDls = this._authService.getCurrentUser();
        const intakeId = this.store[IntakeStoreConstants.intakenumber];
    if (this.intake && Array.isArray(this.intake.data) && this.intake.data.length > 0) {
        if (intakeId) {
            this.handleIfIntakeCountInPopulateIntakeFn(roleDls);
            if (this.isDjs) {
                this.initializeDJSTabs();
            } else {
                this.initializeTabs();
            }
        } 
    } else {
            this.loadDefaults();
            const usercounty =  this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.team.countyid;
            this.countId = usercounty;
            if (usercounty && !this.departmentActionIntakeFormGroup.get('countyid')?.value && !this.readOnly ) {
                this.departmentActionIntakeFormGroup.patchValue({countyid:usercounty});
            }
            this.departmentActionIntakeFormGroup.controls.countyid.disable();
        }
        
    }
    // Assosiated to populateIntake method
    private handleIfIntakeCountInPopulateIntakeFn(roleDls: AppUser) {
        if (this.intake.count) {
            const response = this.intake;
            this.btnDraft = true;
            this._dataStoreService.setData(IntakeStoreConstants.IS_DRAFT, this.btnDraft);
            this.clwStatus = response.data[0].clwstatus;
            this.signedOffDate = response.data[0].signedOffDate;
            this.isPreIntake = response.data[0].ispreintake;
            this.intakeChessieid = response.data[0].intakechessieid;
            this.reviewStatusCheck = response.data[0].reviewstatus;
            if (response?.data[0]?.jsondata?.General?.intakeservice[0]?.description === 'I&R') {
                this.iandrCheck = true;
                this.isIAndRSelected = true;
            }
            if (response?.data[0]?.jsondata?.General?.Purpose == '7933508f-0350-4552-be50-350598a387a7~CW' || response?.data[0]?.jsondata?.General?.Purpose == '7933508f-0350-4552-be50-350598a387a7') {
                this.Kinshipcheck = true;
            }

            this.kinshipNavigator = null;

            if (['formal', 'informal'].includes(response?.data[0]?.jsondata?.General?.iAndRsubtype)) {
                this.kinshipNavigator = response?.data[0]?.jsondata?.General?.PurposeName || this.kinshipnavigation;
            }
            
            this._dataStoreService.setData(
                IntakeStoreConstants.ispreintake,
                response.data[0].ispreintake
            );
            this._dataStoreService.setData(
                IntakeStoreConstants.timeleft,
                response.data[0].timeleft
            );
            this.handleJsondataInPopulateIntakeFn(response, roleDls);
        } else {
            this._alertService.error(
                'Unable to fetch saved intake details.'
            );
            this.loadDefaults();
        }
    }
    // Assosiated to populateIntake method
    private handleJsondataInPopulateIntakeFn(response: any, roleDls: AppUser) {
        if (response.data[0].jsondata) {
            const intakeModel = response.data[0].jsondata;
            if (intakeModel.reviewstatus && intakeModel.reviewstatus.status) {
                this.status = intakeModel.reviewstatus.appevent;
                this.isStatus = true;
            }
            this._dataStoreService.setData(
                IntakeStoreConstants.intakeModel,
                intakeModel
            );
            this.addedCrossReference = intakeModel.crossReference;
            this.saveasdraftReason = intakeModel.reasonforDraft;
             this.addendumnarrativeupdated = intakeModel.General.isaddendumnarrativeupdated;           

            const addedPersons = this.handleCommonInvolvedPersonsFn(intakeModel);

            this.addedIntakeDATypeDetails =
                intakeModel.intakeDATypeDetails;
            this.handleIfDjsInPopulateIntakeFn(intakeModel);
            const general = this.handleGeneralFn(intakeModel);
            this.onReceivedDateChange();
            this.intakeNumber = intakeModel.General.IntakeNumber;
            this._dataStoreService.setData(
                IntakeStoreConstants.preIntakeDisposition,
                intakeModel.preIntakeDispo
            );
            this.reviewstatus = intakeModel.reviewstatus;
            this.cwIntakeWorkerButton = (intakeModel.reviewstatus && intakeModel.reviewstatus.status) === 'supreview';
            this.communicationFields = intakeModel.communicationFields;
            const { isPreIntake, status } = this.handleIfIntakemodal(intakeModel);
            const narrativeDetails = new Narrative();
            this.handleNarrativeFn(intakeModel, narrativeDetails, general);
            this.narrativeUpdatedTime = general.narrativeUpdatedDate ? general.narrativeUpdatedDate : null;
            this.intakeAppointment = intakeModel.appointments;
            this.genratedDocumentList = intakeModel.generatedDocuments;
            this.handleSetstatusFnStatusCheckAndIfCWFn(general, narrativeDetails, intakeModel, addedPersons);
            this.processSelectedYouth();
            this.processFocusPerson();
            this.afterDataStoreSet();
            this.handleScoresAndDispositionFn(intakeModel, response, general, roleDls);
            this.patchFormGroup(general);
            this.prepareCpsDocDetails(general.InputSource);
            ControlUtils.markFormGroupTouched(
                this.departmentActionIntakeFormGroup
            );
            let rcPerson = [];
            rcPerson = addedPersons.filter(
                (person: any) => person.Role === 'RC'
            );
            this.handleSelectedYouthAndSdmFn(intakeModel, rcPerson);
            this.checkHeaderEditability(isPreIntake, status); // Changes for UAT Defect 06781
        } else {
            this.loadDefaults();
            const usercounty = this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.team.countyid;
            this.countId = usercounty;
            if (usercounty && !this.departmentActionIntakeFormGroup.get('countyid')?.value && !this.readOnly) {
                this.departmentActionIntakeFormGroup.patchValue({ countyid: usercounty });
            }
            this.departmentActionIntakeFormGroup.controls.countyid.disable();
        }
    }
    // Assosiated to populateIntake method
    private handleSelectedYouthAndSdmFn(intakeModel: any, rcPerson: any[]) {
        if (!intakeModel.sdm) {
            rcPerson.forEach(res => {
                if (res.dateofdeath) {
                    this._dataStoreService.setData(
                        IntakeStoreConstants.childfatality,
                        'yes'
                    );
                } else {
                    this._dataStoreService.setData(
                        IntakeStoreConstants.childfatality,
                        'no'
                    );
                }
            });
        }
        if (this.isDjs && this.selectedYouth) {
            this.getYouthStaus();
            if (intakeModel.focuspersoncasedetails &&
                intakeModel.focuspersoncasedetails.length >= 0) {
                this._dataStoreService.setData(
                    IntakeStoreConstants.FocuspersonCaseDetailsFormValid,
                    true
                );
                this._dataStoreService.setData(
                    IntakeStoreConstants.FocuspersonCaseDetails,
                    intakeModel.focuspersoncasedetails[0]
                );
            }
        }
    }
    // Assosiated to populateIntake method
    private handleScoresAndDispositionFn(intakeModel: any, response: any, general: any, roleDls: AppUser) {
        if (intakeModel.preIntakeDispo) {
            this.preIntakeSupDicision =
                intakeModel.preIntakeDispo.status;
        }
        if (intakeModel.sdm) {
            intakeModel.sdm.datesubmitted =
                response.data[0].datesubmitted;
            this._dataStoreService.setData(
                IntakeStoreConstants.intakeSDM,
                intakeModel.sdm
            );
        }

        this.handleGeneralAgencyFn(general);
        this.handleToCheckAppeventFn(roleDls, general);
        if (general.safeHavenAssessmentScore &&
            general.safeHavenAssessmentScore >= 1) {
            this.viewSafeHaven = true;
        }
        if (general.kinshipAssessmentScore &&
            general.kinshipAssessmentScore >= 1) {
            this.viewKinship = true;
        }
        if (general.ascrsScore && general.ascrsScore >= 1) {
            this.viewAscrs = true;
        }
    }
    // Assosiated to populateIntake method
    private handleToCheckAppeventFn(roleDls: AppUser, general: any) {
        if (this.returnIfINTRorKINRfn()) {
            this.saveIntakeBtn = true;
        }
        if (this.reviewstatus &&
            this.reviewstatus.appevent === 'SITR' &&
            roleDls.role.name ===
            AppConstants.ROLES.OFFICE_PROFFESSIONAL) {
            this.saveIntakeBtn = true;
        }
        if (general.safeHavenAssessmentScore &&
            general.safeHavenAssessmentScore >= 1) {
            this.viewSafeHaven = true;
        }
        if (general.kinshipAssessmentScore &&
            general.kinshipAssessmentScore >= 1) {
            this.viewKinship = true;
        }
        if (general.ascrsScore && general.ascrsScore >= 1) {
            this.viewAscrs = true;
        }
        this.intakeservice = general.intakeservice;
        this._dataStoreService.setData(
            IntakeStoreConstants.intakeService,
            this.intakeservice
        );

        if (this.reviewstatus &&
            this.reviewstatus.appevent === 'INTR') {
            this.saveIntakeBtn = true;
        }
        if (this.reviewstatus &&
            this.reviewstatus.appevent === 'SITR' &&
            roleDls.role.name ===
            AppConstants.ROLES.OFFICE_PROFFESSIONAL) {
            this.saveIntakeBtn = true;
        }
    }
    // Assosiated to populateIntake method
    private returnIfINTRorKINRfn() {
        return (this.reviewstatus &&
            this.reviewstatus.appevent === 'INTR') ||
            (this.reviewstatus &&
                this.reviewstatus.appevent === 'KINR');
    }
    // Assosiated to populateIntake method
    private handleGeneralAgencyFn(general: any) {
        if (general.Agency) {
            const purpose = general.Purpose &&
                general.Purpose.indexOf('~') !== -1
                ? general.Purpose.split('~')[0]
                : general.Purpose;
            const selectedPurpose: any = this.getSelectedPurpose(
                purpose
            );
            const purposeDescription = selectedPurpose
                ? selectedPurpose.description
                : '';
            this.showSubmit =
                this.showSubmit ||
                [this.informationandreferral
                    // 'ROACPS'
                ].includes(
                    selectedPurpose.intakeservreqtypekey
                );
            if (this.isCW && this.isSupervisor && this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.ROA_CPS)) {
                this.showSubmit = true;
            }
            this.handleListServiceFn(purposeDescription, general);
            this.selectteamtypekey = general.Purpose;
            this.intakeservice = general.intakeservice;
            this._dataStoreService.setData(
                IntakeStoreConstants.intakeService,
                this.intakeservice
            );
        }
    }
    // Assosiated to populateIntake method
    private handleListServiceFn(purposeDescription: string, general: any) {
        if (this.isDjs) {
            this.listService({
                text: purposeDescription,
                value: general.Purpose,
                label: general.Purpose.label
                    ? general.Purpose.label
                    : purposeDescription
            });
        } else {
            this.listService({
                text: '',
                value: general.Purpose
            });
        }
    }

    // Assosiated to populateIntake method
    private handleSetstatusFnStatusCheckAndIfCWFn(general: any, narrativeDetails: Narrative, intakeModel: any, addedPersons: any[]) {
        if (this.reviewStatusCheck === 'Approved' || this.reviewStatusCheck === 'APPROVED') {
            this._dataStoreService.setData(
                IntakeStoreConstants.reviewstatus,
                this.reviewstatus
            );
        }
        this.handleSetDataServiceFn(general, narrativeDetails, intakeModel, addedPersons);
        if (this.isCW) {
            this._dataStoreService.setData(
                IntakeStoreConstants.intakeSDM,
                intakeModel.sdm
            );
            if (intakeModel.sdm) {
                this.cpsResponseOffset = this.calculateResponseOffset(intakeModel.sdm);
                this.processRecordingsList();
                this._dataStoreService.setData(
                    IntakeStoreConstants.childfatalityUpdate,
                    {value: intakeModel.sdm.childfatality, isUpdated: false}
                );
                this._dataStoreService.setData(
                    IntakeStoreConstants.childfatality,
                    intakeModel.sdm.childfatality
                );
            }
        }
    }
    // Assosiated to populateIntake method
    private handleSetDataServiceFn(general: any, narrativeDetails: Narrative, intakeModel: any, addedPersons: any[]) {
        this._dataStoreService.setData(
            IntakeStoreConstants.general,
            general
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.addNarrative,
            narrativeDetails
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.preIntakeDisposition,
            intakeModel.preIntakeDispo
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.createdCases,
            intakeModel.createdCases
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.intakenumber,
            intakeModel.General.IntakeNumber
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.addedPersons,
            addedPersons
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.evalFields,
            intakeModel.evaluationFields
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.intakeappointment,
            intakeModel.appointments
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.communications,
            intakeModel.recordings
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.generatedDocuments,
            intakeModel.generatedDocuments
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.saoResponse,
            intakeModel.saoResponseDetail
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.courtDetails,
            intakeModel.courtDetails
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.petitionDetails,
            intakeModel.petitionDetails
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.scheduledHearings,
            intakeModel.scheduledHearings
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.completedHearings,
            intakeModel.completedHearings
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.communicationFields,
            intakeModel.communicationFields
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.addedEntities,
            intakeModel.entities
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.adultScreenTool,
            intakeModel.adultScreenTool
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.paymentSchedule,
            intakeModel.paymentSchedule
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.addedUnkPersons,
            intakeModel.unknownPersons
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS,
            intakeModel.identifiedPersons
        );
        this._dataStoreService.setData(
            IntakeStoreConstants.addedPlacement,
            intakeModel.placement
        );
    }
    // Assosiated to populateIntake method
    private handleNarrativeFn(intakeModel: any, narrativeDetails: any, general: any) {
        if (intakeModel.narrative && intakeModel.narrative.length > 0) {
            this.handleIntakeModelNarrativeDetailsFn(narrativeDetails, intakeModel);
        }

        narrativeDetails.Narrative = general.Narrative;
        narrativeDetails.draftId = this.draftId;
        narrativeDetails.IsAnonymousReporter =
            general.IsAnonymousReporter === true ? true : false;
        narrativeDetails.IsUnknownReporter =
            general.IsUnknownReporter === true ? true : false;
        narrativeDetails.RefuseToShareZip =
            general.RefuseToShareZip === true ? true : false;
        narrativeDetails.requesteraddress1 =
            general.requesteraddress1;
        narrativeDetails.requesteraddress2 =
            general.requesteraddress2;
        narrativeDetails.requestercity = general.requestercity;
        narrativeDetails.requesterstate = general.requesterstate;
        narrativeDetails.requestercounty = general.requestercounty;
        narrativeDetails.requestercountyname = general.requestercountyname;
        narrativeDetails.offenselocation = general.offenselocation;
        narrativeDetails.isacknowledgementletter = general.isacknowledgementletter
            ? true
            : false;
        narrativeDetails.narrativeUpdatedDate = general.narrativeUpdatedDate ? general.narrativeUpdatedDate : null;
        narrativeDetails.cpsHistoryClearance = general.cpsHistoryClearance ? general.cpsHistoryClearance : null;
        narrativeDetails.addendumNarrative = general.addendumNarrative ? general.addendumNarrative : null;
        narrativeDetails.addendumNarrativeUpdatedAt = this.isValidDate(general.addendumNarrativeUpdatedAt) ? general.addendumNarrativeUpdatedAt : null;
    }
    // Assosiated to populateIntake method
    private handleIntakeModelNarrativeDetailsFn(narrativeDetails: Narrative, intakeModel: any) {
        narrativeDetails.Firstname = intakeModel.narrative
            ? intakeModel.narrative[0].Firstname
            : '';
        narrativeDetails.Middlename = intakeModel.narrative
            ? intakeModel.narrative[0].Middlename
            : '';
        narrativeDetails.Lastname = intakeModel.narrative
            ? intakeModel.narrative[0].Lastname
            : '';
        narrativeDetails.ZipCode = intakeModel.narrative
            ? intakeModel.narrative[0].ZipCode
            : '';
        narrativeDetails.PhoneNumber = intakeModel.narrative
            ? intakeModel.narrative[0].PhoneNumber
            : '';
        narrativeDetails.PhoneNumberExt = intakeModel.narrative
            ? intakeModel.narrative[0].PhoneNumberExt
            : '';
        narrativeDetails.incidentlocation = intakeModel.narrative
            ? intakeModel.narrative[0].incidentlocation
            : '';
        narrativeDetails.incidentdate = intakeModel.narrative
            ? intakeModel.narrative[0].incidentdate
            : '';
        narrativeDetails.isapproximate = intakeModel.narrative
            ? intakeModel.narrative[0].isapproximate
            : false;
        narrativeDetails.email = intakeModel.narrative
            ? intakeModel.narrative[0].email
            : '';
        narrativeDetails.Role = intakeModel.narrative
            ? intakeModel.narrative[0].Role
            : '';
        narrativeDetails.RoleName = intakeModel.narrative
            ? intakeModel.narrative[0].RoleName
            : '';
        narrativeDetails.organization = intakeModel.narrative
            ? intakeModel.narrative[0].organization
            : '';
        narrativeDetails.title = intakeModel.narrative
            ? intakeModel.narrative[0].title
            : '';
    }
    // Assosiated to populateIntake method
    private handleIfIntakemodal(intakeModel: any) {
        let isPreIntake = false;
        let status = '';
        if (intakeModel) {
            if (intakeModel.reviewstatus) {
                isPreIntake = intakeModel.reviewstatus.ispreintake;
                status = intakeModel.reviewstatus.status;
            }
            if (intakeModel.DAType &&
                intakeModel.DAType.DATypeDetail &&
                intakeModel.DAType.DATypeDetail.length) {
                this.reviewStatus = intakeModel.DAType.DATypeDetail[0].DAStatus;
                // Resetting review status if intake event is draft
                if (intakeModel.reviewstatus && intakeModel.reviewstatus.appevent === 'DRAFT') {
                    this.reviewStatus = intakeModel.reviewstatus.status;
                }
                this._dataStoreService.setData(
                    IntakeStoreConstants.disposition,
                    intakeModel.DAType.DATypeDetail
                );
            } else if (intakeModel.reviewstatus) {
                this.reviewStatus = intakeModel.reviewstatus.status;
                this._dataStoreService.setData(
                    IntakeStoreConstants.disposition,
                    intakeModel.disposition
                );
            }
        }
        return { isPreIntake, status };
    }
    // Assosiated to populateIntake method
    private handleGeneralFn(intakeModel: any) {
        const general = intakeModel.General;
        if (this.isCW) {
            this._dataStoreService.setData(
                IntakeStoreConstants.roacps,
                intakeModel.roacps
            );
            const isCPSHistoryClearance = general &&
                general.intakeservice &&
                general.intakeservice.length &&
                general.intakeservice.find(
                    (service: any) => service.description ===
                        this.cpshistoryclearance
                );

            if (isCPSHistoryClearance) {
                this.isClearenceHistory = true;
                this._dataStoreService.setData(
                    IntakeStoreConstants.clearhistory,
                    intakeModel.clearhistory
                );
                const intakeTabConfigData = IntakeTabConfig.find(
                    item => item.id === this.historyclearance
                );
                if(intakeTabConfigData) {
                    this.agencyTabOrder.splice(
                        2,
                        0,
                        intakeTabConfigData
                    );
                }
                this.showSubmit = true;
            }

            const isPrivateAdoptionSubsidy = general &&
                general.intakeservice &&
                general.intakeservice.length &&
                general.intakeservice.find(
                    (service: any) => service.description ===
                        this.privateadoptionsubsidy
                );
            if (isPrivateAdoptionSubsidy) {
                this._dataStoreService.setData(
                    IntakeStoreConstants.PRIVATE_ADOPTION,
                    intakeModel.privateadoption
                );
                const intakeTabConfigData = IntakeTabConfig.find(
                    item => item.id === this.adoptionsubsidy
                )
                if(intakeTabConfigData) {
                    this.agencyTabOrder.splice(
                        2,
                        0,
                        intakeTabConfigData
                    );
                }
            }
        }
        return general;
    }
    // Assosiated to populateIntake method
    private handleIfDjsInPopulateIntakeFn(intakeModel: any) {
        if (!this.isDjs &&
            intakeModel.General.Purpose.indexOf('~') === -1) {
            intakeModel.General.Purpose =
                intakeModel.General.Purpose +
                '~' +
                intakeModel.General.AgencyCode;
        }
        if (this.isDjs) {
            this._dataStoreService.setData(
                IntakeStoreConstants.reasonintakeinterview,
                intakeModel.reasonintakeinterview
            );
            this._dataStoreService.setData(
                IntakeStoreConstants.insufficientInfoNarrative,
                intakeModel.insufficientInfoNarrative
            );
            this._dataStoreService.setData(
                IntakeStoreConstants.complaintInfoReview,
                intakeModel.complaintInfoReview
            );
            this._dataStoreService.setData(
                IntakeStoreConstants.detentionOpened,
                intakeModel.detentionOpened
            );
        }
    }
    // Assosiated to populateIntake method
    private handleCommonInvolvedPersonsFn(intakeModel: any) {
        let addedPersons = [];
        if (this.isCW) {
            if (this.commonInvolvedPersons
                && this.commonInvolvedPersons.data
                && this.commonInvolvedPersons.data.length) {
                this.unSyncedMDMPersons = this.commonInvolvedPersons.data.filter((person: { is_mdm_sync: boolean; }) => person.is_mdm_sync === false);
                if (this.unSyncedMDMPersons && this.unSyncedMDMPersons.length) {
                    $('#mdm-check').modal('show');
                }
                addedPersons = this.commonInvolvedPersons.data.map((person: any) => {
                    return this._intakeConfig.mapOldJsonData(person);
                });
            }

        } else {
            addedPersons = intakeModel.persons
                ? intakeModel.persons
                : this.returnIsEqualFlagIfTrueFn(intakeModel);
        }
        return addedPersons;
    }
    // Associated to initiateAutoSave function
    private returnPersondetailsFn(intakeModel: any) {
        return (intakeModel.persondetails ? intakeModel.persondetails.Person : []);
    }
    // Added for UAT Defect 06781
    checkHeaderEditability(isPreIntake: boolean, status: string) {
        if (
            this.roleId.role.name === AppConstants.ROLES.INTAKE_WORKER &&
            (isPreIntake || status === 'supreview')
        ) {
            this.departmentActionIntakeFormGroup.disable();
            this.departmentActionIntakeFormGroup.controls?.iAndRsubtype?.enable();
            this.departmentActionIntakeFormGroup.controls?.servicerequest?.enable();
            this.departmentActionIntakeFormGroup.controls?.suggestedresource?.enable();
            this.departmentActionIntakeFormGroup.controls?.suggestedTypeResource?.enable();
            this.departmentActionIntakeFormGroup.controls?.islocalreferal?.enable();
            this.departmentActionIntakeFormGroup.controls?.referalcomments?.enable();
            this.departmentActionIntakeFormGroup.controls?.nonreferalreason?.enable();
        } else if (this.roleId.role.name === AppConstants.ROLES.INTAKE_WORKER) {
            this.departmentActionIntakeFormGroup.enable();
            this.departmentActionIntakeFormGroup.controls.countyid.disable();
        } else if (
            this.roleId.role.name !== AppConstants.ROLES.OFFICE_PROFFESSIONAL
        ) {
            this.departmentActionIntakeFormGroup.disable();
            this.departmentActionIntakeFormGroup.controls?.iAndRsubtype?.enable();
        }
    }

    private patchFormGroup(general: General = new General()) {
        const recDate = new Date(general.RecivedDate);

        this.general.RecivedDate = moment(recDate).format(this.dtwithtimeformat);
        recDate.setUTCHours(0);
        recDate.setHours(23, 59, 59, 0);

        this.maxReceivedDate = general.CreatedDate ?  moment(general.CreatedDate) : null;
        this.departmentActionIntakeFormGroup.patchValue({
            ...this.departmentActionIntakeFormData1Fn(general),
            ...this.departmentActionIntakeFormData2Fn(general)
        });
        const usercounty =  this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.team.countyid;
        this.countId = usercounty;
        if (usercounty && !this.departmentActionIntakeFormGroup.get('countyid')?.value && !this.readOnly ) {
            this.departmentActionIntakeFormGroup.patchValue({'countyid': usercounty});
        }
        this.departmentActionIntakeFormGroup.controls.countyid.disable();
        if (general.voluntaryPlacementType === 'EVPA') {
            this.isEVPA = true;
            this._dataStoreService.setData('isEVPA', this.isEVPA);
        } else {
            this._dataStoreService.setData('isEVPA', null);
        }
        this.setVolountaryStoreValues();
        this.getTrasferHistory();
        if (this.departmentActionIntakeFormGroup.value.isOtherAgency) {
            this.otherAgencyControlName.enable();
        }
    }
    // Associated to patchFormGroup function
    private departmentActionIntakeFormData2Fn(general: General): { [key: string]: any; } {
        return {
            isOtherAgency: general.isOtherAgency
                ? general.isOtherAgency
                : false,
            islocalreferal: general.islocalreferal ? general.islocalreferal : 0,
            referalcomments: general.referalcomments
                ? general.referalcomments
                : '',
            nonreferalreason: general.nonreferalreason
                ? general.nonreferalreason
                : '',
            receiveddelay: general.receiveddelay ? general.receiveddelay : '',
            submissiondelay: general.submissiondelay
                ? general.submissiondelay
                : '',
            servicerequest: general.servicerequest
                ? general.servicerequest
                : '',
            suggestedresource: general.suggestedresource
                ? general.suggestedresource
                : '',
            voluntaryPlacementType: general.voluntaryPlacementType
                ? general.voluntaryPlacementType
                : ''
        };
    }
    // Associated to patchFormGroup function
    private departmentActionIntakeFormData1Fn(general: General): { [key: string]: any; } {
        return {
            Source: general.Source ? general.Source : '',
            InputSource: general.InputSource ? general.InputSource : '',
            RecivedDate: new Date(this.general.RecivedDate),
            CreatedDate: general.CreatedDate ? general.CreatedDate : '',
            Author: general.Author ? general.Author : '',
            LegalGuardian: general.LegalGuardian ? general.LegalGuardian : '',
            IntakeNumber: general.IntakeNumber ? general.IntakeNumber : '',
            Agency: general.Agency ? general.Agency : '',
            countyid: general.countyid ? general.countyid : null,
            countydesc: general.countydesc ? general.countydesc : null,
            Purpose: general.Purpose ? general.Purpose : '',
            PurposeName: general.PurposeName ? general.PurposeName : '',
            otheragency: general.otheragency ? general.otheragency : '',
            iAndRsubtype: general.iAndRsubtype ? general.iAndRsubtype : ''
        };
    }

    genCpsIntakeDoc(action: string) {
        this._dataStoreService.setData(
            IntakeStoreConstants.cpsDocument,
            action
        );
    }

    collectivePdfCreator() {
        this.downloadInProgress = true;
        const pdfList = [
            'Appeal-Letter',
            'Formal-Action-Letter',
            'Formal-Action-Letter-Complaint',
            'Process-Letter'
        ];
        pdfList.forEach(element => {
            this.downloadCasePdf(element);
        });
    }
    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages: any = source.getElementsByClassName('pdf-page');
        let pageImages: any[] = [];
        for (let i = 0; i < pages.length; i++) {
            const pageName = pages.item(i).getAttribute('data-page-name');
            const isPageEnd = pages.item(i).getAttribute('data-page-end');
            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then(canvas => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
                if (isPageEnd === 'true') {
                    this.pdfFiles.push({
                        fileName: pageName,
                        images: pageImages
                    });
                    pageImages = [];
                }
            });
        }
        this.convertImageToPdf();
    }
    convertImageToPdf() {
        this.pdfFiles.forEach(pdfFile => {
            const doc: any = new jsPDF();
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG', 0, 0);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
     $('#intake-complaint-pdf1').modal('hide'); 
        this.pdfFiles = [];
        this.downloadInProgress = false;
    }

    submitResource(_resourcePoplabel: any) {
        this.submitResourceObject = Object.assign({}, new GeneralNarative());
        if (this.resourcePoplabel === 'CONTACT NUMBER') {
            this.submitResourceObject.controlindex = 0;
            this.submitResourceObject.helptext = this.generalResourceFormGroup.get('helpDescription')?.value;
        } else if (this.resourcePoplabel === 'CREATED DATE') {
            this.submitResourceObject.controlindex = 1;
            this.submitResourceObject.helptext = this.generalResourceFormGroup.get('helpDescription')?.value;
        } else if (this.resourcePoplabel === 'COMMUNICATION') {
            this.submitResourceObject.controlindex = 2;
            this.submitResourceObject.helptext = this.generalResourceFormGroup.get('helpDescription')?.value;
        } else if (this.resourcePoplabel === 'AGENCY') {
            this.submitResourceObject.controlindex = 3;
            this.submitResourceObject.helptext = this.generalResourceFormGroup.get('helpDescription')?.value;
        } else if (this.resourcePoplabel === 'PURPOSE') {
            this.submitResourceObject.controlindex = 4;
            this.submitResourceObject.helptext = this.generalResourceFormGroup.get('helpDescription')?.value;
        } else if (this.resourcePoplabel === 'RECEIVED DATE') {
            this.submitResourceObject.controlindex = 5;
            this.submitResourceObject.helptext = this.generalResourceFormGroup.get('helpDescription')?.value;
        }
        const jsonData = Object.assign({}, this.submitResourceObject);
        const submitResourceURL = 'Helptexts/addupdate';
        this._genericServiceNarative
            .create(jsonData, submitResourceURL)
            .subscribe((_response: any) => {
                (<any>$('#save-edit-resource-popup')).modal('hide'); // NOSONAR
                this.loadDefaults();
            });
    }

    prepareCpsDocDetails(input: string) {
        this.cpsdocData.intakePurpose = this.intakeServiceGrid;
        if (this.intakeCommunication) {
            this.intakeCommunication.forEach(data => {
                if (data.intakeservreqinputtypeid === input) {
                    this.cpsdocData.InputSource = data.description;
                    this._dataStoreService.setData(
                        IntakeStoreConstants.REFERALSOURCE,
                        {label: this.cpsdocData.InputSource || input}
                    );
                }
            });
        }
    }

    onChangeSupervisor(supervisor: RoutingUser) {

        this.selectedSupervisor = supervisor.userid;
    }

    private listServiceSubtype(intakeservreqtypeid: any) {
        const checkInput = {
            include: 'servicerequestsubtype',
            nolimit: true,
            where: { intakeservreqtypeid: intakeservreqtypeid },
            method: 'get'
        };
        this._commonHttpService
            .getArrayList(
                new PaginationRequest(checkInput),
                NewUrlConfig.EndPoint.Intake.DATypeUrl + '/?filter'
            )
            .subscribe(result => {
                this.subServiceTypes = result[0].servicerequestsubtype;
            });
    }

    private loadSupervisor() {
        const userinfo = this._authService.getCurrentUser();
        const currentuser = userinfo.user.securityusersid;
        this.selectedSupervisor = '';
        let appEvent = 'INTR';
        if (
            this.roleId.role.name === AppConstants.ROLES.KINSHIP_INTAKE_WORKER ||
            this.roleId.role.name === AppConstants.ROLES.KINSHIP_SUPERVISOR
        ) {
            appEvent = 'KINR';
        }
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent },
                    method: 'post'
                }),
                this.getroutingusersurl
            )
            .subscribe(result => {
                setTimeout(() => {
                this.supervisorsList = result.data;
                this.supervisorsList = this.supervisorsList.filter(
                    res => (res.agencykey === this.selectedAgency.value &&  res.userid != currentuser)
                );
                if (
                    this.isDjs &&
                    this.supervisorsList &&
                    this.supervisorsList.length === 1
                ) {
                    this.selectedSupervisor = this.supervisorsList[0].userid;
                    this.submitReviewIntake();
                } else if (this.informationandreferral && this.appevent == 'INTR' && this.finalIntake.intake.General['PurposeName'] === this.informationandreferral && !this.iandrCheck) {
                    this.finalIntake.review['isclosecase'] = true;
                    this.finalIntake.review['status'] = 'Closed';
                    this.approveIntake(this.departmentActionIntakeFormGroup.getRawValue(),'INTR');
                    this._alertService.success('Intake Submitted successfully!');
                    setTimeout(() => {
                        this._router.navigate([this.saveintakeurl]);
                    }, 1000);
        
                } else if (this.appevent == 'INTR' && this.finalIntake.intake.General.intakeservice && this.finalIntake.intake.General.intakeservice.length && this.finalIntake.intake.General.intakeservice[0].intakeservtypekey == 'CPSHC' && !this.iandrCheck) {
                    this.finalIntake.review['isclosecase'] = true;
                    this.finalIntake.review['status'] = 'Closed';
                    this.approveIntake(this.departmentActionIntakeFormGroup.getRawValue(),'INTR');
                } else {
                    $('#list-supervisor').modal('show'); 
                }
            }, 2000);
            });
    }

    onChangeIntaker(intaker: RoutingUser) {
        this.selectedIntaker = intaker['userid'];
    }

    private loadIntaker() {
        this._commonHttpService
            .getAll('Intakedastagings/getIntakeUsers?filter={}')
            .subscribe(result => {
                this.intakersList = result;
            });
    }

    accessRights() {

        if (this.roleId.role.name === AppConstants.ROLES.SUPERVISOR) {
            this.ifRoleSupervisorFn();
        } else if (this.roleId.role.name === AppConstants.ROLES.INTAKE_WORKER
            || this.roleId.role.name === AppConstants.ROLES.CASE_WORKER) {
            this.accessStatus =
                (this.reviewStatus === 'Review' &&
                    this.reviewstatus.appevent === 'INTR') ||
                this.reviewStatus === 'Approved' ||
                this.reviewStatus === 'Closed';
        } else if (
            this.roleId.role.name === AppConstants.ROLES.OFFICE_PROFFESSIONAL
        ) {
            this.accessStatus =
                this.reviewStatus === 'Approved' ||
                this.reviewStatus === 'Closed';
        }
        if (!this._intakeConfig.getiseditIntake()) {
            this.accessStatus = false;
        }

        this._dataStoreService.setData(IntakeStoreConstants.ACCESS_STATUS,this.accessStatus);
    }
    // Associated to accessRights function
    private ifRoleSupervisorFn() {
        if (this.isPreIntake) {
            this.accessStatus = this.reviewStatus !== 'supreview';
        } else {
            const acceptableStatusList = ['Review', 'Approved', 'Reopen'];
            const notFound = acceptableStatusList.indexOf(this.reviewStatus) === -1;
            this.accessStatus = notFound;
            if (this.reviewStatus === 'Approved' || this.reviewStatus === 'Closed') {
                this.accessStatus = true;
            }
        }
        if (this.isIntakeFromSupervisor && this.isDjs) {
            this.accessStatus = false;
        }
    }

    validateIRAR(sdm: any) {
        if (sdm && sdm.scnRecommendOveride !== '') {
            if (sdm.scnRecommendOveride === 'Ovrscrnin') {
                sdm.isir = true;
                sdm.isar = false;
            }
            if (sdm.scnRecommendOveride === 'OvrScrnout') {
                sdm.isir = false;
                sdm.isar = true;
            }
        } else {
            if (sdm && sdm.cpsResponseType === 'CPS-AR') {
                sdm.isir = false;
                sdm.isar = true;
            }
        }
    }

    goToHome() {
        let url = '';

        if (this.isCLW) {
            url = '/pages/sao-dashboard';
        } else {
            url = this.saveintakeurl;
        }

        this._router.navigate([url]);
    }

    processSelectedYouth() {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        if (addedPersons) {
            const personYouth = addedPersons.find((person: { Role: string; }) => person.Role === 'Youth');
            if (personYouth) {
                if (
                    !this.selectedYouth ||
                    personYouth.fullName !== this.selectedYouth.fullName
                ) {
                    this.selectedYouth = personYouth;
                    this._dataStoreService.setData(
                        IntakeStoreConstants.youthid,
                        personYouth.Pid
                    );
                }
                return personYouth.fullName;
            } else {
                this.selectedYouth = null;
            }
        }

        return null;
    }

    processFocusPerson() {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        if (addedPersons) {
            let personRole  = '';
            if (this.isAS) {
                personRole  = 'RA';
            }
            const personFound = addedPersons.find((person: { Role: string; }) => person.Role === personRole);
            if (personFound) {
                this.focusPerson = personFound;
                return personFound.fullName;
            } else {
                this.focusPerson = null;
            }
        }
        return null;
    }

    listAllegations(purposeID: any) {
        const checkInput = {
            where: { intakeservreqtypeid: purposeID },
            method: 'get',
            nolimit: true,
            order: 'name'
        };
        this._commonHttpService
            .getArrayList(
                new PaginationRequest(checkInput),
                NewUrlConfig.EndPoint.Intake.allegationsUrl + '?filter'
            ).pipe(
            map(result => {
                return result;
            }))
            .subscribe();
    }

    assignIntaker(modal: any, status: any) {
        const intakeWorkerId = this.store[
            IntakeStoreConstants.assingedIntakeWokerId
        ];
        if (intakeWorkerId) {
            this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        where: {
                            appeventcode: modal,
                            intakenumber: this.intakeNumber,
                            assigneduserid: intakeWorkerId,
                            status: status
                        },
                        method: 'post'
                    }),
                    'Intakedastagings/assignintake'
                )
                .subscribe(_result => {
                    this._alertService.success('Intake assigned successfully!');
                    const dashboardURL = '/pages/cjams-dashboard';
                    setTimeout(() => {
                        this._router.navigate([dashboardURL]);
                    }, 2000);
                });
        } else {
            this._alertService.warn('Please select a intake worker');
        }
    }
    submitDocuments() {
        if (this.saoResponseForm.invalid) {
            this._alertService.warn('Please select a SAO response date');
            return false;
        }
        this.genratedDocumentList = this.store[
            IntakeStoreConstants.generatedDocuments
        ];
        if (!this.genratedDocumentList) {
            this.showDocumentGenerateErrorMessage();
            return false;
        }
        const notGeneratedRequiredDocs = this.genratedDocumentList.filter(
            document => document.isRequired && !document.isGenerated
        );
        if (notGeneratedRequiredDocs.length !== 0) {
            this.showDocumentGenerateErrorMessage();
            return false;
        }
        this.signedOffDate = this.saoResponseForm.getRawValue().signedOffDate;
        this.clwStatus = this.SAO_DOUCUMENT_GENERATED;
       $('#document-complete-modal').modal('hide');
        this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(), 'CLWDRAFT', true);
    }

    private showDocumentGenerateErrorMessage() {
        this._alertService.error('Please generate required Documents');
      $('#document-complete-modal').modal('hide');
    }

    private submitSAOResponse() {
        const saoResponseData: SAOResponse = this._dataStoreService.getData(
            IntakeStoreConstants.saoResponse
        );
        if (!saoResponseData) {
            this._alertService.error('Please fill the required sao responses');
            return false;
        }

        if (!saoResponseData.saoresponsedate) {
            this._alertService.error('Please select the sao response date');
            return false;
        }

        if (!saoResponseData.saoresponsestatustypekey) {
            this._alertService.error('Please select the sao response status');
            return false;
        }

        if (!saoResponseData.saoresponseconditiontypekey) {
            this._alertService.error('Please select the sao condition');
            return false;
        }
        if (saoResponseData.saoresponsestatustypekey === 'PF') {
            this.clwStatus = this.SAO_RESPONSED;
        } else {
            this.clwStatus = AppConstants.INTAKE_CONSTANTS.SAO_RESPONSE_CLOSED;
        }
        this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(), 'CLWDRAFT', true);
    }

    submitPetitionDetails() {
        this.isPetionDetailsSubmited = true;
        this.clwStatus = this.PETITIONS_SUBMITED;
        this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(), 'CLWDRAFT', true);
    }

    submitScheduledHearings() {
        this.clwStatus = this.HEARING_SCHEDULED;
        this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(), 'CLWDRAFT', true);
    }

    backToDashboard() {
        this._router.navigate(['/cjams-dashboard/assign-case']);
    }

    modifyinterStateCompactDetails() {
        let interstatecompactedetails = [
            this.store[IntakeStoreConstants.FocuspersonCaseDetails]
        ];
        if (
            !interstatecompactedetails ||
            !Array.isArray(interstatecompactedetails)
        ) {
            interstatecompactedetails = [];
        } else {
            if (
                interstatecompactedetails &&
                interstatecompactedetails.length > 0
            ) {
                this.ifInterstatecompactedetailsFn(interstatecompactedetails);
            }
        }
        const modifiedinterstatecompactedetails = JSON.parse(
            JSON.stringify(interstatecompactedetails)
        );
        if (
            !modifiedinterstatecompactedetails ||
            modifiedinterstatecompactedetails.length <= 0
        ) {
            return [];
        }
        return modifiedinterstatecompactedetails;
    }

    private ifInterstatecompactedetailsFn(interstatecompactedetails: any[]) {
        if (interstatecompactedetails[0]) {
            interstatecompactedetails[0].intakenumber = this.intakeNumber;
            if (this._intakeConfig.selectedPurposeIs(
                MyNewintakeConstants.REFERRAL.LAW_ENFORCEMENT
            )) {
                this.ifLawEnforcementFn(interstatecompactedetails);
            }
            if (this._intakeConfig.selectedPurposeIs(
                MyNewintakeConstants.REFERRAL.INTERSTATE_COMPACT
            )) {
                this.residingwithdetailsMapFn(interstatecompactedetails);
            }
        }
    }

    private residingwithdetailsMapFn(interstatecompactedetails: any[]) {
        const persondetails = interstatecompactedetails[0].residingwithdetails;
        if (persondetails && persondetails.length > 0) {
            interstatecompactedetails[0].residingwithdetails = persondetails.map((key: any) => {
                    if (typeof key === 'string' ||
                        key instanceof String) {
                        const person = this.getAddedPersonNames(
                            key
                        );
                        return {
                            personid: key,
                            firstName: person.Firstname,
                            middlename: person.Middlename,
                            lastName: person.Lastname
                        };
                    } else {
                        const person = this.getAddedPersonNames(
                            key.personid
                        );
                        return {
                            personid: key.personid,
                            firstName: person.Firstname,
                            middlename: person.Middlename,
                            lastName: person.Lastname
                        };
                    }
                }
            );
        }
    }

    private ifLawEnforcementFn(interstatecompactedetails: any[]) {
        if (interstatecompactedetails[0].warranttype &&
            interstatecompactedetails[0].warranttype ===
            'Delinquent') {
            interstatecompactedetails[0].isdetaintheyouth = true;
        }
        if (interstatecompactedetails[0].warranttype &&
            interstatecompactedetails[0].warranttypedetails &&
            interstatecompactedetails[0].warranttypedetails
                .length > 0) {
            const warranttypedetails = interstatecompactedetails[0].warranttypedetails;
            if (warranttypedetails &&
                warranttypedetails.length > 0) {
                const modified = warranttypedetails.map((key: any) => {
                    if (typeof key === 'string' ||
                        key instanceof String) {
                        return {
                            warranttypekey: key,
                            warranttype: interstatecompactedetails[0]
                                .warranttype
                        };
                    } else {
                        return {
                            warranttypekey: key.warranttypekey,
                            warranttype: interstatecompactedetails[0]
                                .warranttype
                        };
                    }
                });
                interstatecompactedetails[0].warranttypedetails = modified;
            }
        }
    }

    getAddedPersonNames(key: any) {
        const personsList = this.store[IntakeStoreConstants.addedPersons];
        return personsList.find((item: any, index: any) => {
            const personid = item.Pid
                ? item.Pid
                : AppConstants.PERSON.TEMP_ID + index;
            if (personid === key) {
                return item;
            }
        });
    }

    modifyEvalFields() {
        let evalFields = this.store[IntakeStoreConstants.evalFields];
        if (!evalFields || !Array.isArray(evalFields)) {
            evalFields = [];
        }
        const modifiedEvalFields = JSON.parse(JSON.stringify(evalFields));
        if (!modifiedEvalFields || modifiedEvalFields.length <= 0) {
            return [];
        }
        modifiedEvalFields.forEach((evalField: any) => {
            if (evalField && evalField.offenselocation) {
                this.zipCode = '' + evalField.offenselocation;
            }
            const allegations = this.getAllegationsMapFn(evalField);
            this.waivedoffenseMapFn(evalField, allegations);
            this.modifyEvalDateFieldsFn(evalField);
            evalField.zipcode = evalField.zipcode ? evalField.zipcode : null;
            switch (evalField.allegedoffenseknown) {
                case 0: {
                    evalField.enddate = null;
                    break;
                }
                case 1: {
                    evalField.enddate = null;
                    evalField.begindate = null;
                    break;
                }
                case 2: {
                    break;
                }
            }
        });
        return modifiedEvalFields;
    }
    // Associated to modifyEvalFields function
    private modifyEvalDateFieldsFn(evalField: any) {
        evalField.yearsofage = evalField.yearsofage
            ? evalField.yearsofage
            : null;
        evalField.arrestdate = evalField.arrestdate
            ? evalField.arrestdate
            : null;
        evalField.complaintreceiveddate = evalField.complaintreceiveddate
            ? evalField.complaintreceiveddate
            : null;
        evalField.begindate = evalField.begindate
            ? evalField.begindate
            : null;
        evalField.enddate = evalField.enddate ? evalField.enddate : null;
    }
    // Associated to modifyEvalFields function
    private waivedoffenseMapFn(evalField: any, allegations: any) {
        if (evalField.waiverpetitionid && evalField.waivedoffense) {
            evalField.waivedoffense = allegations.map((waivedoffense: any) => {
                if (waivedoffense.allegationid) {
                    return {
                        allegationid: waivedoffense.allegationid,
                        allegationtype: MyNewintakeConstants.Intake.waivedOffenseType
                    };
                } else {
                    return {
                        allegationid: waivedoffense,
                        allegationtype: MyNewintakeConstants.Intake.waivedOffenseType
                    };
                }
            });
        } else {
            evalField.waivedoffense = [];
        }
    }

    private getAllegationsMapFn(evalField: any) {
        const allegations = evalField.allegedoffense;
        if (allegations) {
            evalField.allegedoffense = allegations.map((allegation: any) => {
                if (allegation.allegationid) {
                    return {
                        allegationid: allegation.allegationid,
                        allegationtype: MyNewintakeConstants.Intake.allegedOffenseType
                    };
                } else {
                    return {
                        allegationid: allegation,
                        allegationtype: MyNewintakeConstants.Intake.allegedOffenseType
                    };
                }
            });
        }
        return allegations;
    }

    formatAllegations(): Array<any> {
        const allegations: any = [];
        const createdCases = this.store[IntakeStoreConstants.createdCases];
        createdCases.forEach((createdCase: any) => {
            createdCase.choosenAllegation.forEach((allegation: any) => {
                allegations.push({
                    DaNumber: createdCase.caseID,
                    AllegationId: allegation.allegationID,
                    AllegationName: allegation.allegationValue,
                    Indicators: allegation.indicators
                });
            });
        });

        return allegations;
    }

    submitDelayForm() {
        if (this.dispositionDelayForm.dirty) {
            const delayReason = {
                fiveDays: this.dispositionDelayForm.get('fiveDaysDelay')?.value,
                twentyFiveDays: this.dispositionDelayForm.get('twentyFivedaysDelay')?.value
            };
            this.delayFormData = delayReason;
            this.checkConditionForDelay = true;
          $(this.reasonfordelaypopupid).modal('hide');
            const isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
            if(!isSupervisor ){
            this.submitIntake(this.departmentActionIntakeFormGroup.value, 'INTR', this.isIntakeApprove);
            }
        } else {
            this.checkConditionForDelay = false;
            this._alertService.warn('Please enter a valid reason.');
        }
    }
    private getCLWTabOrder() {
        let tabOrder;
        switch (this.clwStatus) {
            case AppConstants.INTAKE_CONSTANTS.SAO_DOUCUMENT_GENERATED:
            case AppConstants.INTAKE_CONSTANTS.SAO_RESPONSE_CLOSED:
                tabOrder = [this.intakerefferal, 'document', this.saoresponse];
                break;
            case AppConstants.INTAKE_CONSTANTS.SAO_RESPONSED:
                tabOrder = [
                    this.intakerefferal,
                    'document',
                    this.saoresponse,
                    this.saopetition
                ];
                break;
            case AppConstants.INTAKE_CONSTANTS.PETTIION_SUBMITED:
                tabOrder = [
                    this.intakerefferal,
                    'document',
                    this.saoresponse,
                    this.saopetition,
                    'sao-schedule'
                ];
                break;
            case AppConstants.INTAKE_CONSTANTS.HEARING_SCHEDULED:
            case AppConstants.INTAKE_CONSTANTS.COURT_HEARING_CONTINUANCE:
            case AppConstants.INTAKE_CONSTANTS.COURT_ACTION_SUSTAINED:
            case AppConstants.INTAKE_CONSTANTS.SAO_CLOSED:
            case AppConstants.INTAKE_CONSTANTS.RESTITUTION_COMPLETED:
                tabOrder = [
                    this.intakerefferal,
                    'document',
                    this.saoresponse,
                    this.saopetition,
                    'sao-schedule',
                    'sao-hearing'
                ];
                break;
            default:
                tabOrder = [this.intakerefferal, 'document'];
                break;
        }
        return tabOrder;
    }
    private initializeDJSTabs() {
        const user = this._authService.getCurrentUser();

        let tabOrder = this._intakeConfig.getDJSTabOrder();

        if (user.role.name === AppConstants.ROLES.COURT_WORKER) {
            tabOrder = this.getCLWTabOrder();
        }
        const tabOrderData: any = tabOrder
            .map(tabId => {
                return IntakeTabConfig.find(
                    item =>
                        item.id === tabId &&
                        item.role.indexOf(user.role.name) !== -1
                );
            })
            .filter(tab => tab);

            if(tabOrderData) {
                this.agencyTabOrder = tabOrderData;
            }
        const purpose = this._intakeConfig.getIntakePurpose();

        if (
            purpose &&
            purpose.description ===
            MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION &&
            user.role.name === AppConstants.ROLES.OFFICE_PROFFESSIONAL
        ) {
            const intakeTabConfigData = IntakeTabConfig.find(item => item.id === 'assessment');
            if(intakeTabConfigData) {
                this.agencyTabOrder.splice(
                    2,
                    0,
                    intakeTabConfigData
                ); // For enabling assessment tab for Office Professional in Adult Hold.
            }
        }

        if (
            this._router.url.endsWith(this.mynewintake) &&
            user.role.name === AppConstants.ROLES.COURT_WORKER
        ) {
            const indexToLoad = this.agencyTabOrder.length - 1;
            this._router.navigate([this.agencyTabOrder[indexToLoad].route], {
                relativeTo: this.route
            });
        } else if (
            this._router.url.endsWith(this.mynewintake) ||
            this.isPurposeChanged
        ) {
            this.isPurposeChanged = false;
            this._router.navigate([this.agencyTabOrder[0].route], {
                relativeTo: this.route
            });
        }
        this.accessRights();
    }

    private initializeTabs() {
        const user = this._authService.getCurrentUser();
        const isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        const agencyTabOrder = this._intakeConfig.getCWTabOrder();
        if(isSupervisor && agencyTabOrder && !agencyTabOrder.includes('caseaudittrail')){
            agencyTabOrder.push('caseaudittrail');
        }
        const tabOrder = agencyTabOrder;
        const intakeresourcelist = user.resources.filter(resource => (resource.name === 'intake_read_only_access' || resource.name === 'intake_full_access'));
        const intakeresourcename = intakeresourcelist && intakeresourcelist.length > 0 ? intakeresourcelist[0].name : null;
        this.tabOrderFn(tabOrder, intakeresourcename, user);
        const isCPSHistoryClearance = this.intakeservice.find(
            service => service.description === this.cpshistoryclearance
        );
        const intakeTabConfigData: any = IntakeTabConfig.find(item => item.id === this.historyclearance);
        if (isCPSHistoryClearance && intakeTabConfigData) {

            this.agencyTabOrder.splice(
                2,
                0,
                intakeTabConfigData
            );
        }
        const isPrivateAdoptionSubsidy = this.intakeservice.find(
            service => service.description === this.privateadoptionsubsidy
        );
        const intakeTabConfigData1: any = IntakeTabConfig.find(item => item.id === this.adoptionsubsidy);
        if (isPrivateAdoptionSubsidy && intakeTabConfigData1) {
            this.agencyTabOrder.splice( 2, 0, intakeTabConfigData1);
        }
        if (
            this._router.url.endsWith(this.mynewintake) ||
            this.isPurposeChanged
        ) {
            this.isPurposeChanged = false;
            const toPerson = this._dataStoreService.getData(IntakeStoreConstants.NAVIGATE_TO_PERSON);
            this.ifToPersonFn(toPerson);
        }
        this.accessRights();
    }
    // Associated to initializeTabs function
    private tabOrderFn(tabOrder: string[], intakeresourcename: any, user: AppUser) {
        const orderData: any = tabOrder
            .map(tabId => {
                return IntakeTabConfig.find(
                    item => item.id === tabId &&
                        (item.resource.indexOf(intakeresourcename) !== -1 ||
                            item.role.indexOf(user.role.name) !== -1)
                );
            })
            .filter(tab => tab);

            if(orderData) {
                this.agencyTabOrder = orderData;
            }
    }
    // Associated to initializeTabs function
    private ifToPersonFn(toPerson: any) {
        if (toPerson) {
            const tab = this.agencyTabOrder.find(item => item.id === 'person-cw');
            this._dataStoreService.setData(IntakeStoreConstants.NAVIGATE_TO_PERSON, false);
            this._router.navigate([(tab && tab.route) ? tab.route : ''], {
                relativeTo: this.route
            });
        } else {
            this._router.navigate([this.agencyTabOrder[0].route], {
                relativeTo: this.route
            });
        }
    }

    private afterDataStoreSet() {
        let sdm = this.store[IntakeStoreConstants.intakeSDM];
        if (sdm) {
            sdm = Object.assign(sdm, sdm.physicalAbuse);
            sdm = Object.assign(sdm, sdm.sexualAbuse);
            sdm = Object.assign(sdm, sdm.generalNeglect);
            sdm = Object.assign(sdm, sdm.arGeneralNeglect);
            sdm = Object.assign(sdm, sdm.unattendedChild);
            sdm = Object.assign(sdm, sdm.riskofHarm);
            sdm = Object.assign(sdm, sdm.screenOut);
            sdm = Object.assign(sdm, sdm.screenIn);
            sdm = Object.assign(sdm, sdm.immediateList);
            sdm = Object.assign(sdm, sdm.noImmediateList);
            sdm = Object.assign(sdm, sdm.disqualifyingCriteria);
            sdm = Object.assign(sdm, sdm.disqualifyingFactors);

            this.cpsResponseTypeFn(sdm);

            if (sdm.maltreatment === 'yes') {
                sdm.ismaltreatment = true;
            } else {
                sdm.ismaltreatment = false;
            }
            this.ifChildfatalityFn(sdm);
            this.screeningRecommendFn(sdm);

            this.addSdm = sdm;
            if (this.addSdm.changePathway) {
                this.pathwayChange = true;
            }
            const createdCases = this.store[IntakeStoreConstants.createdCases];
            if (this.roleId.role.name !== AppConstants.ROLES.SUPERVISOR) {
                this.ifScreeningRecommendFn(sdm, createdCases);
            } else {
                if (sdm && 
                    sdm.scnRecommendOveride &&
                    createdCases &&
                    createdCases.length
                ) {
                    createdCases[0].intakeserreqstatustypekey = 'Review';
                    createdCases[0].dispositioncode = sdm.screeningRecommend;
                    createdCases[0].supDisposition = sdm.scnRecommendOveride;
                    createdCases[0].supStatus = 'Approved';
                    this.ifScnRecommendOverideFn(sdm, createdCases);
                }
            }
        }
        this.genratedDocumentList = this.store[
            IntakeStoreConstants.generatedDocumentDownloadKey
        ];
    }
    // Associated to afterDataStoreSet function
    private ifScnRecommendOverideFn(sdm: any, createdCases: any) {
        if (sdm.scnRecommendOveride !== this.sdmDispositionCall) {
            this.sdmDispositionCall = sdm.scnRecommendOveride;
            this._dataStoreService.setData(
                IntakeStoreConstants.createdCases,
                createdCases
            );
        }
    }
    // Associated to afterDataStoreSet function
    private ifScreeningRecommendFn(sdm: any, createdCases: any) {
        if (sdm.screeningRecommend &&
            createdCases &&
            createdCases.length) {
            createdCases[0].dispositioncode = sdm.screeningRecommend;
            createdCases[0].intakeserreqstatustypekey = 'Review';
            if (sdm.screeningRecommend !== this.sdmDispositionCall) {
                this.sdmDispositionCall = sdm.screeningRecommend;
                this._dataStoreService.setData(
                    IntakeStoreConstants.createdCases,
                    createdCases
                );
            }
        }
    }
    // Associated to afterDataStoreSet function
    private screeningRecommendFn(sdm: any) {
        if (sdm.screeningRecommend === 'ScreenOUT') {
            sdm.isrecsc_screenout = true;
            sdm.isrecsc_scrrenin = false;
        } else {
            sdm.isrecsc_screenout = false;
            sdm.isrecsc_scrrenin = true;
        }
    }
    // Associated to afterDataStoreSet function
    private ifChildfatalityFn(sdm: any) {
        if (this.store[IntakeStoreConstants.childfatality] === true
            || this.store[IntakeStoreConstants.childfatality] === 'yes') {
            sdm.ischildfatality = true;
        } else {
            sdm.ischildfatality = false;
        }
    }
    // Associated to afterDataStoreSet function
    private cpsResponseTypeFn(sdm: any) {
        if (sdm.cpsResponseType) {
            if (sdm.cpsResponseType === 'CPS-IR') {
                sdm.isir = true;
                sdm.isar = false;
            } else {
                this.validateIRAR(sdm);
            }
        } else {
            this.validateIRAR(sdm);
        }
    }

    changeLocalDept(model: any) {
        if (model && model === '0') {
            this.departmentActionIntakeFormGroup.controls[
                'nonreferalreason'
            ].setValidators([Validators.required]);
            this.departmentActionIntakeFormGroup.controls[
                'nonreferalreason'
            ].updateValueAndValidity();
        } else {
            this.departmentActionIntakeFormGroup.controls[
                'nonreferalreason'
            ].clearValidators();
            this.departmentActionIntakeFormGroup.controls[
                'nonreferalreason'
            ].updateValueAndValidity();
        }
    }

    ngOnDestroy(): void {
        this._speechRecognitionService.destroySpeechObject();
        this.dataStoreSubscription.unsubscribe();
        if (this.autosaveTimmer) {
            this.autosaveTimmer.unsubscribe();
        }
        this.autoSaveInitiated = false;
        const interval = this._dataStoreService.getData('intervalTimer');
        clearInterval(interval);
        this._dataStoreService.setData('intervalTimer', null);
    }
    private validateChildAge(involvedPerson: InvolvedPerson[]): boolean {
        let isValidAge = true;

        const getPerson = involvedPerson.filter((person: any) => {
            const tempChildAge: any = this.getAge(person.Dob);
            return person.Role !== 'CHILD' && person.Role !== 'RC' && tempChildAge !== '' && tempChildAge >= 18;
        });
        if (!getPerson.length) {
            isValidAge = false;
        }
        return isValidAge;
    }

    private getAge(dateValue: any) {
        if (
            dateValue &&
            moment(new Date(dateValue), this.dtformat1, true).isValid()
        ) {
            const rCDob = moment(new Date(dateValue), this.dtformat1).toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return '';
        }
    }
    getPrior(intakenumber: any) {
        this.priorItem$ = this._commonHttpService
            .getArrayList(
                {
                    where: { intakenumber: intakenumber },
                    method: 'get'
                },
                NewUrlConfig.EndPoint.Intake.GetPrior + '?filter'
            ).pipe(
            map(res => {
                if (res.length) {
                    return res
                        .filter(item => item.role === 'Reported Child')
                        .map(service => {
                            service.servicecases = service.servicecases
                                ? service.servicecases.filter(
                                    (servicecase: any) =>
                                        servicecase.subservice ===
                                        'Family Preservation Services'
                                )
                                : [];
                            service.cpsfindings = service.cpsfindings
                                ? service.cpsfindings.filter(
                                    (servicecase: any) =>
                                        servicecase.subservice ===
                                        'Family Preservation Services'
                                )
                                : [];
                            return service;
                        });
                }
            }));
    }
    routToCase(daNumber: string, intakeserviceid: any) {
       $('#priorDetails').modal('hide'); 
        this._commonHttpService
            .getById(
                daNumber,
                NewUrlConfig.EndPoint.Intake.DsdsActionSummaryUrl
            )
            .subscribe(response => {
                const dsdsActionsSummary = response[0];
                this._dataStoreService.setData(
                    'da_status',
                    dsdsActionsSummary.da_status
                );
                this._dataStoreService.setData(
                    'teamtypekey',
                    dsdsActionsSummary.teamtypekey
                );
                const currentUrl =
                    '/pages/case-worker/' +
                    intakeserviceid +
                    '/' +
                    daNumber +
                    this.reportsummaryurl;
                this._router.navigate([currentUrl]);
            });
    }
    createNewCase(modal: General, appevent: string) {
        $('#priorDetails').modal('hide'); 
        this.approveIntake(modal, appevent);
    }

    onRefferalDropDownChange(purpose: any) {
        this.currentPurposeValue = purpose.value;

        this.isPurposeChanged = true;
        this._dataStoreService.setData(IntakeStoreConstants.purposeSelected, {
            text: purpose.label,
            value: purpose.value
        });
        this.initializeDJSTabs();
    }

    purposeChange(newPurpose: any, purposeSource: string) {
        this.newPurpose = newPurpose;
        this.purposeSource = purposeSource;
                this._dataStoreService.setData(IntakeStoreConstants.purposeSelected, {
            text: newPurpose.label,
            value: newPurpose.value
        });
        if (this.currentPurposeValue) {
            this.currentPurpose = this._dataStoreService.getData(
                IntakeStoreConstants.purposeSelected
            );
            $(this.purposechangepopupid).modal('show');
        } else {
            this.changePurpose();
        }
        if( this.newPurpose?.value=='7933508f-0350-4552-be50-350598a387a7~CW'){
            this.Kinshipcheck=true;
        }else{
            this.Kinshipcheck=false;
            this.departmentActionIntakeFormGroup.controls['iAndRsubtype'].patchValue('');
        }        
    }

    changePurpose() {
        if(this.newPurpose?.label === "Kinship Navigation ") {
            this.intakeServicesRequired = true;
        } else {
            this.intakeServicesRequired = false;
        }
        this._dataStoreService.setData(IntakeStoreConstants.intakeSDM, null);
        this._sessionStorage.setObj(IntakeStoreConstants.intakeSDM, null);
        this._dataStoreService.setData(IntakeStoreConstants.evalFields, null);
        this._dataStoreService.setData(IntakeStoreConstants.createdCases, null);
        this._dataStoreService.setData(IntakeStoreConstants.disposition, null);
        this._dataStoreService.setData(IntakeStoreConstants.intakeService, null);
        this._dataStoreService.setData(IntakeStoreConstants.roacps, null);
        this.kinshipNavigator=null;
          
        if(this.newPurpose?.label === "Information and Referral ") {
            this._dataStoreService.setData('showRequesterDetails', true);
        }else {
            this._dataStoreService.setData('showRequesterDetails', false);
        }
            
        this.intakeservice = [];
        this.isIAndRSelected = false;
        this.intakeservicesubtype = [];
        if (this.purposeSource === 'referral') {
            this.onRefferalDropDownChange(this.newPurpose);
        } else {
            if (this.isCW) {
                const purpose = this.newPurpose.value.split('~')[0];
                const selectedPurpose: any = this.getSelectedPurpose(purpose);
                this.showSubmit = [
                    this.informationandreferral
                    // 'ROACPS'
                ].includes(selectedPurpose.intakeservreqtypekey);
                if (this.isCW && this.isSupervisor  && this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.ROA_CPS)) {
                    this.showSubmit = true;
                }
                const obj = this.purposeList.find(item => item.intakeservreqtypeid === purpose);
                this.departmentActionIntakeFormGroup.patchValue(
                    { PurposeName: (obj) ? obj.description : '' },
                    { emitEvent: false }
                );
            }
            this.listService(this.newPurpose);
        }
        $(this.purposechangepopupid).modal('hide');
    }

    resetToPreviosPurpose() {
        this.newPurpose = null;
        this.departmentActionIntakeFormGroup.patchValue(
            {
                Purpose: this.currentPurposeValue
            },
            { emitEvent: false }
        );
        $(this.purposechangepopupid).modal('hide');
    }

    showApproveIntakeAckmnt(approveIntakeResponse: any, finalIntake: any) {
        this.approveIntakeResponse = approveIntakeResponse;
        const djsmessage = this._intakeConfig.djsInfoValidation();
        if (this.isDjs && djsmessage.status) {
            $('#close-intake-ackmt').modal('show'); 
            return true;
        }
        const roaCPS = this.store[IntakeStoreConstants.roacps];
        if (this.closeCWCae || ( roaCPS && ((roaCPS.statetype === 'instate' && roaCPS.cpsid != null) || ['roaundercourt','sisteragency'].includes( roaCPS.statetype)))) {

            this._alertService.success('Completed successfully.', true);
            let url = `/pages/newintake/new-saveintake`;
            if (this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)) {
                url = `/pages/cjams-dashboard/cw-intake-referals`;
            }
            this._router.navigate([url]);
        } else if (( roaCPS && ['instate'].includes( roaCPS.statetype) && roaCPS.cpsid == null)) {
           $('#selectcpsid').modal('show'); 
        }
        else {
            return this.showApproveIntakeAckmntElseCondFn(approveIntakeResponse, roaCPS, finalIntake);
        }
    }
    // Associated to showApproveIntakeAckmnt function
    private showApproveIntakeAckmntElseCondFn(approveIntakeResponse: any, roaCPS: any,  finalIntake: any) {
        if (approveIntakeResponse &&
            Array.isArray(approveIntakeResponse) &&
            approveIntakeResponse.length) {
            const finalCaseData = approveIntakeResponse.find(
                caseData => (caseData.hasOwnProperty('isfamilycase') &&
                    caseData.isfamilycase === 1) || this.isSENflag || (roaCPS && roaCPS.statetype === 'outofstate') || this.isASCRS
            );
            if (finalCaseData) {
                let lastIntake = finalIntake;
                let isoverriderequest  =finalIntake.intake.General.isoverriderequest   
                if (finalIntake.intake.General.PurposeName !== 'Kinship Navigation') { //Keeping finalInatke deatils for Kinship
                    lastIntake = '';
                }
                this.validateFamilyCaseAvailable(finalCaseData, lastIntake, isoverriderequest);
                // exit the flow;
                return;
            } else {
                this.getRoutingUser();
                this.getTeamList();
                this.getPersonsList(approveIntakeResponse[0]?.responseintakeserviceid);
                if(finalIntake.intake.General.Purpose !== '619c4dcf-ef22-4fc4-9269-d7678e8a8f6a~CW') {
                    this.loadProgramAreaDropdowns('');
                    this.approveintakeackmtfn();
                }
            }
        }
    }

    private approveintakeackmtfn() 
    {
        if (this.approveIntakeResponse && this.approveIntakeResponse[0]) {
            this.assignCaseForm.patchValue({
                programkey: this.approveIntakeResponse[0].progrmkey,
                subprogramkey: this.approveIntakeResponse[0].subprogrmkey
            });
        }
        $(this.approveintakeackmtpopupid).modal('show'); 
    }
    

    approveIntakeAcknowledged() {
        $(this.assignLatePopup).modal('show');
        this.typeOfCaseAssign = 'intake_approval'
    }

    successFullAssignLaterIntake(){
        $(this.approveintakeackmtpopupid).modal('hide');
        if (!this.isDjs) {
            this._intakeService.loadCaseAssignDashboard();
        } else {
            // for DJS, there is  flow will go CLW
            this.onReload();
        }
    }

    selectCommunication($event: any) {

        this._dataStoreService.setData(
            IntakeStoreConstants.REFERALSOURCE,
            $event
        );
    }

    activateSpeechToText(): void {
        this.recognizing = true;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                // listener
                value => {
                    this.speechData = value;
                    const comments = this.draftReasonFormGroup.getRawValue()
                        .draftReason;
                    this.draftReasonFormGroup.patchValue({
                        draftReason: comments + ' ' + this.speechData
                    });
                },
                // errror
                err => {
                    console.error(err);
                    this.recognizing = false;
                    if (err.error === 'no-speech') {
                        this.notification = `No speech has been detected. Please try again.`;
                        this._alertService.warn(this.notification);
                        this.activateSpeechToText();
                    } else if (err.error === 'not-allowed') {
                        this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    } else if (err.error === 'not-microphone') {
                        this.notification = `Microphone is not available. Plese verify the connection of your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    }
                },
                // completion
                () => {
                    this.speechRecogninitionOn = true;

                    this.activateSpeechToText();
                }
            );
        } else {
            this.recognizing = false;
            this.deActivateSpeechRecognition();
        }
    }
    deActivateSpeechRecognition() {
        this.speechRecogninitionOn = false;
        this._speechRecognitionService.destroySpeechObject();
    }

    submitDraftReason() {
        const sdmdata = this.store[IntakeStoreConstants.intakeSDM];
        const intakeStore = this._intakeService.getIntakeStore();
        if (intakeStore.traffickingupdate && sdmdata.confirmtrafficking == 'Yes' && (!sdmdata?.selecttrafficking || sdmdata?.selecttrafficking?.length == 0)) {
            this._alertService.error('Trafficking  dropdown under SDM must have a selection!');
        } else {
            this.isAutoSaveFlag = false;
            const currTime = new Date().getTime();
            this.saveasdraftReason = this.saveasdraftReason
                ? this.saveasdraftReason
                : [];
            const draftReasonObj = { comments: undefined, time: currTime };
            this.saveasdraftReason.push(draftReasonObj);
            if (!this.readOnly) {
                this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(), 'DRAFT', true);
            }
        }
    }

    closeIntakeError(from?: string) {
                $(this.intakeerrorpopupid).modal('hide'); 
        this.intakeErrorMessage = null;
        if(from === 'incident') {
            this._router.navigate(['disposition'], { relativeTo: this.route });
            this.current_route = 'disposition';
            this.errorFrom = '';
            setTimeout(() => {
                this._router.navigate(['narrative'], { relativeTo: this.route });
                this.current_route = 'narrative';
            }, 30);
            this._dataStoreService.setData('NarrativeDateChange', {isUpdated: true});
        }
    }

    selectCase(caseId: any) {
        this.selectedServiceCaseId = caseId;
    }

    createAdoptionCase(approveIntakeResponse: any) {
        this.approveIntakeResponse = approveIntakeResponse;
        if (this.approveIntakeResponse && this.approveIntakeResponse[0].message === 'SUCCESS') {
        const adoptionCaseData = {
            intakeserviceid: this.approveIntakeResponse[0].responseintakeserviceid,
            intakeNumber: this.intakeNumber,
            fromIntake: true,
            source: 'intake'
        };
        this._commonHttpService
            .create(adoptionCaseData, 'adoptioncase/createadoptioncase')
            .subscribe(response => {
                if (response && response[0].message === 'Success') {
                    this.adoptionCaseResponse = response;
                    this.adoptionCaseNumber = response[0].adoptioncasenumber;
                    this.openAdoptionCaseAcknowledge(response[0].adoptioncasenumber);
                } else {
                    this._alertService.error('Intake approved, but Adoption Case could not be created.');
                }
            });
        }

    }
    createOrMergeServiceCase() {
        let isNewCase: any;
        if (!this.selectedServiceCaseId) {
            this._alertService.error('Please select an option to proceed');
            return;
        }
        if (this.selectedServiceCaseId === 'NEW_CASE') {
            this.selectedServiceCaseId = null;
            isNewCase = 1;
        } else {
            isNewCase = 0;
        }
        const serviceCaseData = {
            servicecaseid: this.selectedServiceCaseId,
            intakeserviceid: this.familyCaseData.responseintakeserviceid,
            isnewcase: isNewCase,
            subtypekey: 'IHM', // INHOME SERVICES,
            source: 'intake',
            personprogramids: this.personprogramids
        };
        this._commonHttpService
            .create(serviceCaseData, 'servicecase/createservicecase')
            .subscribe(response => {

                this.serviceCaseResponse = response;
                this.serviceCaseNumber = response[0].servicecaseno;
                this.hideHistoryOfFmailyCase();
                this.getPersonsList(this.serviceCaseResponse[0].caseid);
                if (isNewCase) {
                    this.ismergecase = false;
                } else {
                   this.ismergecase = true;
                   this.getservicecaseassignments(response[0].caseid);
                }
                this.openServiceCaseAcknowledge(response[0].servicecaseno);
            });


    }
    getservicecaseassignments(serviceCaseNumber: any) {
        this.assignmentsList$ = this._commonHttpService.getArrayList(
            {
                where: { servicecaseid: serviceCaseNumber },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        );
        this.assignmentsList$.subscribe(data => {
            if (data) {
                this.assignmentListData = data;
                const fam = this.returnFamFn();
                this.hasActiveFamilyAssignment = fam.length > 0 ? true : false;
            }
        });
    }

    private returnFamFn() {
        return this.assignmentListData.filter((item: { responsibilitytypekey: any; enddate: null; }) => String(item.responsibilitytypekey).toLowerCase() == 'family' && item.enddate == null);
    }

    ngAfterViewChecked() {
        (<any>$('#NONCPS')).prop('disabled', true); // NOSONAR
    }

    validateFamilyCaseAvailable(caseData: any, finalIntake: any, isoverriderequest: any) {
        this.familyCaseData = caseData;
        this._commonHttpService
            .getSingle(
                {
                    where: {
                        intakeserviceid: caseData.responseintakeserviceid,
                        subtypekey: 'IHM',
                        source: 'intake',
                        isoverriderequest  :isoverriderequest              
                    },
                    method: 'get'
                },
                'intakeservreqchildremoval/servicecasevalidation?filter'
            )
            .subscribe(scResponse => {
                if (scResponse && scResponse.data && scResponse.data.length) {
                    if (finalIntake !== '') { // For Kinship Cases
                        this.personprogramids =[];
                        finalIntake.intake.persondetails.Person.forEach((actor: any) => {
                            const personData = {
                                personid: actor.Pid,
                                objectid: caseData.responseintakeserviceid
                            };                            
                            this.kinshiprespnsefn(personData,scResponse);
                        });                        
                    }
                
                    if (scResponse.isavailable === 1) {
                        this.openHistoryOfFamilyCase(scResponse.data);
                    } else {
                        this.ismergecase = false;
                        this.serviceCaseResponse = scResponse.data;
                        this.getPersonsList(this.serviceCaseResponse[0].caseid);
                        this.openServiceCaseAcknowledge(
                            scResponse.data[0].servicecaseno
                        );
                    }
                }
                
                
                
            });
    }
    private kinshiprespnsefn(personData: any,scResponse: any)
    {
        const errorAssignments = this.getProgramAssignments(personData);
        errorAssignments.subscribe((res) => { //Each assignment with wrong servicecase info here
            if (res && Array.isArray(res) && res.length) {
                res.forEach(item => {
                    this.processErrorAssignmentsfn(item,scResponse,personData);
                });
            }
        }, (_err) => {
            this._alertService.error('Unable to process request.');
        });        
    }

    private processErrorAssignmentsfn(item: any,scResponse: any,personData: any) {
        item.personprogramarea.forEach((element: any) => { //Two forEach in case we add more functionality
            const data = {
                personprogramid: element.personprogramid,
                personid: element.personid,
                startdate: element.startdate,
                programkey: element.programkey,
                subprogramkey: element.subprogramkey ? item.subprogramkey : 'NON',
                endreasonkey: element.endreasonkey ? item.endreasonkey : null,
                enddate: element.enddate ? item.enddate : null,
                casenumber: scResponse.data[0].servicecaseno,
                securityusersid: this.userRole.user.securityusersid,
                objectid: scResponse.data[0].caseid,
                clientmergeid: element.clientmergeid ? item.clientmergeid : null,
                objecttypekey: element.objecttypekey ? item.objecttypekey : 'servicecase',
                ifpsatriskflag: element.ifpsatriskflag ? item.ifpsatriskflag : 0
            };
            this.personprogramids.push(element.personprogramid);
            this.updateProgramAssignment(data).subscribe((_response) => { //Updating program assignments with correct case number/object id
            this.getProgramAssignments(personData);
            }, (_error) => {
                this._alertService.error('Unable to process request.');
            });
        });
    }



    getProgramAssignments(personData: any) { //Function to check for active program assignments for each person
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { objectid: personData.objectid, personid: personData.personid,isExpungementSuperUser:isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged },
                    method: 'get',
                    nolimit: true
                }),
                'Personprogramareas/getpersonprogramarea?filter'
            )
    }

    updateProgramAssignment(data: any) { //Function to update program assignments
        const url = 'Personprogramareas/addupdate';
        return this._commonHttpService.create(data, url);
    }

    openServiceCaseAcknowledge(serviceCaseNumber: any) {
        this.serviceCaseNumber = serviceCaseNumber;
        this.getRoutingUser();
        this.getTeamList();
        this.loadProgramAreaDropdowns('IHM');
        this.personprogramids = [];
        
    if (this.serviceCaseResponse && this.serviceCaseResponse[0]) {
            this.assignServiceCaseForm.patchValue({
                programkey: this.serviceCaseResponse[0].progrmkey,
                subprogramkey: this.serviceCaseResponse[0].subprogrmkey
            });
        }
        (<any>$(this.approveintakeackmtservicecasepopupid)).modal('show'); // NOSONAR
    }
    openAdoptionCaseAcknowledge(adoptionCaseNumber: any) {
        this.adoptionCaseNumber = adoptionCaseNumber;
        this.getRoutingUser();
        this.getTeamList();
        (<any>$(this.approveintakeackmtadoptioncasepopupid)).modal('show'); // NOSONAR
    }

    // openMergeServiceCaseAcknowledge(serviceCaseNumber) {
    //     this.serviceCaseNumber = serviceCaseNumber;
    //     (<any>$('#approve-intake-ackmt-merge-service-case')).modal('show'); // NOSONAR
    // }

    openHistoryOfFamilyCase(caseList: any) {
        this.exitingServiceCaseList = caseList;
        (<any>$('#serviceCaseHistory')).modal('show'); // NOSONAR
    }

    hideHistoryOfFmailyCase() {
        (<any>$('#serviceCaseHistory')).modal('hide'); // NOSONAR
    }

    approveIntakeAcknowledgedWithServiceCase() {
        if(this.ismergecase && this.hasActiveFamilyAssignment) {
            $(this.approveintakeackmtservicecasepopupid).modal('hide');  
            this.typeOfCaseAssign = '';
            this._router.navigate([
                '/pages/cjams-dashboard/cw-intake-referals'
            ]);      
        } else {
            $(this.assignLatePopup).modal('show');
            this.typeOfCaseAssign = 'approval_intake_service_case'
        }
    }

    assignLaterPopupSubmit(){
        this.disableassign = true;
        const userInfo = this._authService.getCurrentUser();
        const userid = userInfo.user.userprofile.securityusersid;
        if(this.typeOfCaseAssign === 'intake_approval') {
            const serviceId =  this.approveIntakeResponse[0].responseintakeserviceid;
            this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        assignlater: true,
                        appeventcode: 'INVT',
                        serreqid: serviceId,
                        assigneduserid: userid,
                        programkey: (this.assignCaseForm.get('programkey')?.value) ? this.assignCaseForm.get('programkey')?.value : null,
                        subprogramkey: (this.assignCaseForm.get('subprogramkey')?.value) ? this.assignCaseForm.get('subprogramkey')?.value : null,
                        isgroup: false,
                        assignedusers: [{userid: userid, responsibilitytypekey: "family"}]
                    },
                    method: 'post'
                }),
                'Intakedastagings/routeda'
                )
                .subscribe((_result) => {
                    $(this.assignLatePopup).modal('hide');
                    this.successFullAssignLaterIntake();
                    this.typeOfCaseAssign = '';
                    this.disableassign = false;
                });
        } else if(this.typeOfCaseAssign === 'approval_intake_service_case') {
            const serviceCaseId = this.serviceCaseResponse[0].caseid;
            const model = {
                assignlater: true,
                appeventcode: 'SRVC',
                servicecaseid: serviceCaseId,
                assigneduserid: userid,
                programkey: (this.assignServiceCaseForm.get('programkey')?.value) ? this.assignServiceCaseForm.get('programkey')?.value : null,
                subprogramkey: (this.assignServiceCaseForm.get('subprogramkey')?.value) ? this.assignServiceCaseForm.get('subprogramkey')?.value : null,
                assignedusers: [{userid: userid, responsibilitytypekey: "family"}]
            };

            this._commonHttpService
            .create(model,
                'servicecase/assigncase'
            )
            .subscribe((_result) => {
                $(this.assignLatePopup).modal('hide');
                this.successfullServiceCaseAssignLater();                
                this.typeOfCaseAssign = '';
                this.disableassign = false;
            });            
        } else if (this.typeOfCaseAssign === 'approval_intake_adoption_case') {
            const adoptionCaseId = this.adoptionCaseResponse[0].caseid;

            const model = {
                appeventcode: 'ADPC',
                assigneduserid: userid,
                adoptioncaseid: adoptionCaseId,
                assignedusers: [{userid}]
            };
            this._commonHttpService
            .create(model,
                'adoptioncase/assigncase'
            )
            .subscribe((_result) => {
                $(this.assignLatePopup).modal('hide');
                this.approveIntakeAcknowledgedWithAdoptionCase();                
                this.typeOfCaseAssign = '';
            });
        }
    }

    successfullServiceCaseAssignLater(){
        $(this.approveintakeackmtservicecasepopupid).modal('hide');
        this._router.navigate([
            '/pages/cjams-dashboard/cw-assign-service-case'
        ]);
    }

    approveIntakeAcknowledgedWithAdoptionCase() {
        (<any>$(this.approveintakeackmtadoptioncasepopupid)).modal('hide'); // NOSONAR
        this._router.navigate([
            '/pages/cjams-dashboard/cw-assign-adoption-case'
        ]);
    }


    openServiceCase(serviceCase: any) {
        this._sessionStorage.setTabKeyKey( serviceCase.servicerequestnumber);
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + serviceCase.servicecaseid  + '/casetype';
        this._commonHttpService.getAll(url).subscribe((response) => {
          const dsdsActionsSummary = response[0];
          if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = this.caseworkerpageurl + serviceCase.servicecaseid + '/' + serviceCase.servicecasenumber + '/dsds-action/person-cw';
            window.open(currentUrl);
          }
        });
    }



    loadServiceTypeDropDown() {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 155, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            )
            .subscribe(data => {
                this.serviceTypeRequested = data;
            });
    }

    loadSuggestTypeDropDown() {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 156, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            )
            .subscribe(data => {
                this.suggestedTypeResource = data;
            });
    }
    returnToWorkerAcknowledged() {
        this._alertService.success('Intake Returned Successfully!', true);
        this._router.navigate(['/pages/cjams-dashboard/cw-intake-referals']);
    }
    screenOutAcknowledged() {
        (<any>$('#screenout-intake-ackmt')).modal('hide'); // NOSONAR
        this._alertService.success(this.intakesubmitmsg, true);
        this._router.navigate(['/pages/cjams-dashboard/cw-intake-referals']);
    }
    // redirectToServiceCase(item) {
    //     this.hideHistoryOfFmailyCase();
    //     const redirectUrl = '/pages/case-worker/' + item.servicecaseid + '/' + item.servicecasenumber + this.reportsummaryurl;
    //     this._router.navigate([redirectUrl]);
    // }
    initiateAutoSave() {
                if(!this.autoSaveInitiated && this.current_route === 'narrative') {
                    this.autoSaveInitiated = true;
                    this.autoSaveIntervalTimer = setInterval(() => {
                        const isNarrativeFormInVaid = this._dataStoreService.getData('isNarativeFormInValid');
                        const addedNarrative = this.store[IntakeStoreConstants.addNarrative];
                        const isEqualFlag = this.currentForm ? this.returnIsEqualFlagIfTrueFn(addedNarrative) : false;
                        this.ifCurrentRouteIsNarrativeFn(isNarrativeFormInVaid, isEqualFlag);
                    }, config.AutoSaveTimer);
                    this._dataStoreService.setData('intervalTimer', this.autoSaveIntervalTimer);
                }
    }
    // Associated to initiateAutoSave function
    private ifCurrentRouteIsNarrativeFn(isNarrativeFormInVaid: any, isEqualFlag: boolean) {
        if ((!this.store[IntakeStoreConstants.REFERALSOURCE]
            || !this.store[IntakeStoreConstants.purposeSelected] || isNarrativeFormInVaid) && !isEqualFlag) {
            this._alertService.error('Auto Save Cannot be triggered as the mandatory fields are not filled.');
        } else {
            if (!isEqualFlag) {
                this.autoSaveAsDraft();
            }
        }
    }
    // Associated to initiateAutoSave function
    private returnIsEqualFlagIfTrueFn(addedNarrative: any) {
        return this.currentForm.Narrative === addedNarrative.Narrative ? true : false;
    }

    onTabClick(tab: any) {
            this.checkforrequired = true;
            this._intakeService.intakeTabSwitch$.next(tab.id);
            // CHECK to see if intake communication and purpose fields are filled in. If not disable tab clicks
            ControlUtils.validateAllFormFields(this.departmentActionIntakeFormGroup);
            const addedNarrative = this.store[IntakeStoreConstants.addNarrative];
            let narrativeNotPresent = true;
            if ( addedNarrative && addedNarrative.Narrative && addedNarrative.Narrative !== '') {
                narrativeNotPresent = false;
            }
            else {
                this.narrativepresent = false;
            }            
            if (this.departmentActionIntakeFormGroup.invalid || narrativeNotPresent ) {
                this._alertService.error('Please update required fields before switching to another tab.');
            }
            if(this.current_route !== 'narrative' && this.autoSaveInitiated) {
                this.autoSaveInitiated = false;
                const interval = this._dataStoreService.getData('intervalTimer');
                clearInterval(interval);
                this._dataStoreService.setData('intervalTimer', null);
                this.autoSaveIntervalTimer = null;
                this.ifCurrentRouteNotNarrativeFn(narrativeNotPresent, tab); 
              
            } else if (tab.id === 'person-cw' || tab.id === 'contact' ) {
                // @Simar: Multirole issue-This is not necessary since now Case Worker can swith context to take Intakes
                this.ifCurrentRouteIsPersonCWFn();

                // this route should happen only on success. draftintake should return and observable.
                this._router.navigate([tab.route], { relativeTo: this.route });
                this.current_route = tab.route;

            } else if (tab.id === 'disposition' ) {
                const isSDMConfigured = this.agencyTabOrder.find(tabOrder => tabOrder.id === 'sdm');
                const sdm = this.store[IntakeStoreConstants.intakeSDM];
                if (isSDMConfigured && sdm && sdm.scnRecommendOveride && !this.readOnly) {
                     this.submitDraftReason();
                }
                this._router.navigate([tab.route], { relativeTo: this.route });
                this.current_route = tab.route;

            } 
            else {
                // if form is valid move to next tab
                this._router.navigate([tab.route], { relativeTo: this.route });
                this.current_route = tab.route;

            }



    }
    // Associated to onTabClick function
    private ifCurrentRouteIsPersonCWFn() {
        if ((!this.reviewstatus.status) || (this.reviewstatus.status === '')) {
            if (!this.readOnly) {
                this.submitDraftReason();
            }
        }
    }
    // Associated to onTabClick function
    private ifCurrentRouteNotNarrativeFn(narrativeNotPresent: boolean, tab: any) {
        if (this.departmentActionIntakeFormGroup.invalid || narrativeNotPresent) {
            this._alertService.error('Please update required fields before switching to another tab.');
        } else { //CIDM-4129
            if ((!this.reviewstatus.status) || (this.reviewstatus.status === '')) {
                if (!this.readOnly) {
                    this.submitDraftReason();
                }
            }
            this._router.navigate([tab.route], { relativeTo: this.route });
            this.current_route = tab.route;
        }
    }

    listenForQuickAddPerson() {
        // this._intakeConfig.quickAddPersonListener$.subscribe(data => {
        //     // if (!this.readOnly){
        //     //     this.autoSaveAsDraft();
        //     // }

        // });
    }

    getIsRestrictItem() {
        if(this.intakeNumber) {
            this._intakeService.isRestrictedItem(this.intakeNumber)
                .subscribe(
                    (response) => {
                        if (response.length > 0) {
                            this.isrestricteditem = true;
                        }
                    }
                );
        }
    }

    restrictedItemAuditLog() {
        if(this.intakeNumber) {
            this._intakeService.restrictedItemAuditLog(this.intakeNumber)
                .subscribe();
        }
    }

    confirmRestrictItem() {
        const userinfo = this._authService.getCurrentUser();
        let activeflag = 0;
        if (!this.isrestricteditem) {
            activeflag = 1;
        }
        const selectedcaseworkerid: any[] = [];
        selectedcaseworkerid.push({userid: userinfo.user.securityusersid});
        this._intakeService.createRestrictedItem(this.intakeNumber, 'INTAKE', selectedcaseworkerid, activeflag)
            .subscribe(
                (_response) => {
                    // If originally false then we just successfully applied restriction
                    if (!this.isrestricteditem) {
                        this._alertService.success('Restriction applied successfully.');
                    } else {
                        this._alertService.success('Restriction removed successfully.');
                    }
                    // Revert the restriction flag
                    this.isrestricteditem = !this.isrestricteditem;
                    (<any>$('#confirm-restrict-item')).modal('hide'); // NOSONAR
                },
                (_error) => {
                    this._alertService.warn('Error in updating restriction.');
                }
            );

    }

    cancelRestrictItem() {
        (<any>$('#confirm-restrict-item')).modal('hide'); // NOSONAR
    }

    getRoutingUser() {
        this.getResponsibilityType();
        let appEvent = 'INVR';
        if (this.roleId.role.name === AppConstants.ROLES.KINSHIP_INTAKE_WORKER || this.roleId.role.name === AppConstants.ROLES.KINSHIP_SUPERVISOR) {
            appEvent = 'KINR';
        }
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent, teamid: this.selectedteamid || null },
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
    loadStateDropdownItems(stateId: any, _countyId: any) {
        this._commonHttpService
            .create(
                {
                    where: {
                        activeflag: '1',
                        state: stateId
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                'admin/county/countylist'
            )
            .subscribe(result => {
               this.countyDropDownItems = result;
            });
      }
    getResponsibilityType() {
        this._commonHttpService.getArrayList({}, 'responsibilitytype/').pipe(map((result) => {
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
        this.isSupervisor = assigned !== 'TOBEASSIGNED';
        if (assigned === 'TOBEASSIGNED') {
            this.ifToBeAssignedFn();
        } else {
            this.selectedResponsibilityType = null;
            this.getUsersList = this.getUsersList.filter((res) => res.issupervisor === true);

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
    }
    // Associated to listUser function
    private ifToBeAssignedFn() {
        this.getUsersList = this.getUsersList.filter((res) => res.issupervisor === false);
        this.getUsersList.forEach((userData) => {
            if (userData.homelocationcode === this.zipCode || userData.worklocationcode === this.zipCode) {
                this.mergeUsersList.push(userData);
                this.zipCodeIndex = this.getUsersList.indexOf(userData);
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

    selectPerson(row: any) {
        this.selectedPerson = row;
    }

    assignUser() {
        this.disableassign = true;
        if (this.workersList && this.workersList.length) {
            this.assignUserValidation();
            if (this.nochild){
                this.disableassign = false;
                return this._alertService.error('Please select the child.');
            }
            if (this.responsibility == 0 ){
                this.disableassign = false;                        
                this._alertService.error('No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned.');                        
            }else if ( this.responsibility > 1 ){
                this.disableassign = false;
                this._alertService.error('No more than one family worker can be assigned to the same case.');
            } else {
                this.assignCaseToUser();
            }                    
        } else {
            this.disableassign = false;
            this._alertService.error(this.selectapersonmsg);
        }
    }
    assignUserValidation() {  
        this.responsibility = 0;      
        this.nochild = false;
        this.workersList.forEach(worker => {
            if (worker.responsibilitytypekey === 'family') {
                this.responsibility ++
            }
            if (worker.responsibilitytypekey === 'child' && !(worker.child && worker.child.length > 0)) {
                this.nochild = true
            }
            if(worker.responsibilityevent) {
                worker.responsibilityevent = null;
            }
        });
    }
    assignCaseToUser() {
        if (!this.approveIntakeResponse || this.approveIntakeResponse.length === 0) {
            this.disableassign = false;
            return;
        }
        if(!this.assignCaseForm.get('programkey')?.value || !this.assignCaseForm.get('subprogramkey')?.value){
            this.displayProgramSelectionValidationMessage = true;
            this.disableassign = false;
            return;
        }
            const caseid = this.approveIntakeResponse[0].responseservicereqnum;
            const serviceId =  this.approveIntakeResponse[0].responseintakeserviceid;
            this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        where: {
                            appeventcode: 'INVT',
                            serreqid: serviceId,
                            programkey: (this.assignCaseForm.get('programkey')?.value) ? this.assignCaseForm.get('programkey')?.value : null,
                            subprogramkey: (this.assignCaseForm.get('subprogramkey')?.value) ? this.assignCaseForm.get('subprogramkey')?.value : null,                
                            assigneduserid: this.selectedPerson.userid,
                            isgroup: false,
                            assignedusers: this.workersList
                        },
                        method: 'post'
                    }),
                    'Intakedastagings/routeda'
                )
                .subscribe((_result) => {
                    // console.info(result,"result-==-==--==--=")
                    this.senChild?.forEach((item) => {
                        const notificationData:any ={}
                        notificationData.objectid = this.id;
                        notificationData.isexternalentity = 'false'
                        notificationData.subject = `Active Substance Exposed New Born (${item.fullname?.replace("'", " ").trim()} / ${item.cjamspid}) is added to case ${caseid}`;
                        notificationData.priorityleveltypekey = 'High'
                        notificationData.usernotificationtypekey = 'System'
                        notificationData.insertedby =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.securityusersid =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.updatedby =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.objectcasenumber = caseid;
                        notificationData.servicerequestnumber = serviceId;
                        notificationData.body =  item.fullname?.trim() + " is added as a Active Birth Match Client in this Case.";
                
                        
                        this.handleNotificationurlApiFn(notificationData, caseid);
                    })
                    this.senChild?.forEach((item: any) => {
                        const notificationData:any ={}
                        notificationData.objectid = this.id;
                        notificationData.isexternalentity = 'false'
                        notificationData.subject = `Active Substance Exposed New Born (${item.fullname.replace("'", " ").trim()} / ${item.cjamspid}) is added to case ${caseid}.A service case connect needs to be completed.`;
                        notificationData.priorityleveltypekey = 'High'
                        notificationData.usernotificationtypekey = 'System'
                        notificationData.insertedby =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.securityusersid =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.updatedby =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.objectcasenumber = caseid;
                        notificationData.servicerequestnumber = serviceId;
                        notificationData.body =  item.fullname.trim() + " is added as Substance Exposed NewBorn in this Case. A service case need to be created";

                        
                        this.handleNotificationurlApiFn(notificationData, caseid);
                    })
                    this.senChild?.forEach((item: any) => {
                        const notificationData:any ={}
                        notificationData.objectid = this.id;
                        notificationData.isexternalentity = 'false'
                        notificationData.subject = `Active Substance Exposed New Born (${item.fullname.replace("'", " ").trim()} / ${item.cjamspid}) is added to case ${caseid}.A service case connect needs to be completed.`;
                        notificationData.priorityleveltypekey = 'High'
                        notificationData.usernotificationtypekey = 'System'
                        notificationData.insertedby =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.securityusersid =  this.submisionHistory[0].fromid;
                        notificationData.updatedby =  this._authService.getCurrentUser().user.securityusersid;
                        notificationData.objectcasenumber = caseid;
                        notificationData.servicerequestnumber = serviceId;
                        notificationData.body =  item.fullname.trim() + " is added as Substance Exposed NewBorn in this Case. A service case need to be created";
                
                        
                        this.handleNotificationurlApiFn(notificationData, caseid);

                        if(this.workersList && this.workersList.length) {
                           this.workersList.forEach((data) => {
                             this.createNotificationToWorker(notificationData, data);
                           });
                        }
                    })
                    this._alertService.success('Case assigned successfully!', true);
                    this.disableassign = false;
                    (<any>$(this.approveintakeackmtpopupid)).modal('hide'); // NOSONAR
                    this.checkAndAssignRestrictedCase(caseid);
                    const url = `/pages/cjams-dashboard/cw-intake-referals`;
                    this._router.navigate([url]);

                });
        // }
    }
    // Assosiated to assignCaseToUser method
    private handleNotificationurlApiFn(notificationData: any, caseid: string) {
        this._commonHttpService.create(notificationData, this.notificationurl).pipe(
            switchMap(data => {
                return this.handleReusableCreateNotificationFn(notificationData, data);
            }),
            switchMap(_res => {
                if (this.selectedPerson) {
                    notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
                    notificationData.securityusersid = this.selectedPerson.userid;
                    notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
                    return this._commonHttpService.create(notificationData, this.notificationurl);
                } else {
                    return EMPTY; // No selected person, no need to proceed
                }
            }),
            switchMap(data => {
                return this.handleReusableCreateNotificationFn(notificationData, data);
            }),
            switchMap(_data => {
                const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + caseid;
                return this._commonHttpService.getAll(url);
            }),
            switchMap(response => {
                const dsdsActionsSummary = response[0];
                if (dsdsActionsSummary) {
                    notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
                    notificationData.securityusersid = dsdsActionsSummary.responsibleworkers[0].supervisorid;
                    notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
                    return this._commonHttpService.create(notificationData, this.notificationurl);
                }
                else {
                    return EMPTY; // No selected person, no need to proceed
                }
            }),
            switchMap(dataa => {
                return this.handleReusableCreateNotificationFn(notificationData, dataa);
            })
        ).subscribe();
    }
    // Assosiated to assignCaseToUser method
    private handleReusableCreateNotificationFn(notificationData: any, data: any) {
        if (data.length === 0) {
            return this._commonHttpService.create(notificationData, this.notificationaddurl);
        } else {
            return EMPTY; // No need to do anything if notification already exists
        }
    }
    
    createNotificationToWorker(notification: any, data: any){

        notification.insertedby = this._authService.getCurrentUser().user.securityusersid;
        notification.securityusersid = data.userid ?  data.userid : this.selectedPerson.userid;
        notification.updatedby = this._authService.getCurrentUser().user.securityusersid;
        this._commonHttpService.create(notification, this.notificationurl).subscribe((res) => {
            if(res && res.length === 0){
                this._commonHttpService.create(notification, this.notificationurl).subscribe((_result) => {
                    notification.insertedby = this._authService.getCurrentUser().user.securityusersid;
                    notification.securityusersid = data.userid ?  data.userid : this._authService.getCurrentUser().user.securityusersid;
                    notification.updatedby = this._authService.getCurrentUser().user.securityusersid;
                    this._commonHttpService.create(notification, this.notificationurl).pipe(
                        switchMap(response1 => {
                            return this.handleReusableCreateNotificationFn(response1, notification);
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
    }

    checkAndAssignRestrictedCase(caseid: any) {
        let activeflag = 0;
        const selectedcaseworkerid: any = [];
        selectedcaseworkerid.push(this.selectedPerson.userid);
        this._intakeService.isRestrictedItem(caseid)
            .subscribe(
                (response) => {
                    if (response.length > 0) {
                        activeflag = 1;
                        // Means it's in restricted items list
                        this._intakeService.createRestrictedItem(caseid, 'SERVICE', selectedcaseworkerid, activeflag)
                            .subscribe(
                                () => {
                                    (<any>$('#restrict-item-assign-ack')).modal('show'); // NOSONAR
                                    this._alertService.success('Case is restricted for assigned case woker!');

                                });
                    }
                }
            );
    }

    getTeamList() {
        this.teamtypekey = this._authService.getCurrentUser().role.teamtypekey;
        const tma = this.roleId.user.userprofile.teammemberassignment;
        const assignments = Array.isArray(tma) ? tma : [tma];
        this.teamid = assignments[0]?.teammember?.teamid;
        this.selectedteamid = this.teamid;
        this.teamForm.controls['teamid'].setValue(this.selectedteamid);
        this._commonHttpService.getArrayList({
            method: 'get',
            page: 1,
            order: 'teamnumber asc',
            where: {
                activeflag: 1,
                teamtypekey: this.teamtypekey,
                teamid: null
            }
        }, 'manage/team/getteamlist?filter').subscribe((items) => {
            this.teamList = items.map(item => item);

        });
    }
    teamChange() {
        this.selectedteamid = this.teamForm.controls['teamid'].value;
        this.getRoutingUser();
    }
    assignServiceCaseUser() {
        this.disableassign = true;
        if(!this.assignServiceCaseForm.get('programkey')?.value || !this.assignServiceCaseForm.get('subprogramkey')?.value){
            this.displayProgramSelectionValidationMessage = true;
            this.disableassign = false;
        } else {
            if (this.workersList && this.workersList.length) {
                this.assignServiceCaseUserValidation(); 
                return;   
            } else {
                this.disableassign = false;
                this._alertService.warn(this.selectapersonmsg);
            }
        }
    }
    assignServiceCaseUserValidation() {
        this.assignUserValidation();
        if (this.nochild){
            this.disableassign = false;
            return this._alertService.error('Please select the child.');
        }
        if (this.responsibility == 0 ){
            if(this.ismergecase) {
                if(!this.hasActiveFamilyAssignment) {
                    this.disableassign = false;
                    return this._alertService.error('No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned.');
                }
            } else {
                this.disableassign = false;
                this._alertService.error('No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned.');
            }
        }else if (this.responsibility > 1 ){
            this.disableassign = false;
            this._alertService.error('No more than one family worker can be assigned to the same case.');
        } else {
            if(this.ismergecase && this.hasActiveFamilyAssignment) {  
                this.disableassign = false;                      
                $(this.existingfamilyassignment).modal('show');
                return;
            }
            else {
                this.assignServiceCaseToUser();
            }
        }
    }

    existingfamilyassignmentpopupsubmit() {
        this.assignServiceCaseToUser();
        $(this.existingfamilyassignment).modal('hide');
    }

    assignAdoptionCaseUser() {
        if (this.workersList && this.workersList.length) {

            this.assignAdoptionCaseToUser();

        } else {
            this._alertService.warn(this.selectapersonmsg);
        }
    }
    assignAdoptionCaseToUser() {
        const adoptionCaseId = this.adoptionCaseResponse[0].caseid;

        const model = {
            appeventcode: 'ADPC',
            // assigneduserid: this.selectedPerson.userid,
            adoptioncaseid: adoptionCaseId,
            assignedusers: this.workersList
        };
        this._commonHttpService
        .create(model,
            'adoptioncase/assigncase'
        )
        .subscribe((_result) => {
            this._alertService.success('Adoption Case assigned successfully!', true);
            (<any>$(this.approveintakeackmtadoptioncasepopupid)).modal('hide'); // NOSONAR
            const url = `/pages/cjams-dashboard/cw-intake-referals`;
            this._router.navigate([url]);
        });
    }
    assignServiceCaseToUser() {
        const serviceCaseId = this.serviceCaseResponse[0].caseid;
        const caseid = this.serviceCaseResponse[0].servicecaseno;
        const model = {
            appeventcode: 'SRVC',
            servicecaseid: serviceCaseId,
            assigneduserid: this.selectedPerson.userid,
            programkey: (this.assignServiceCaseForm.get('programkey')?.value) ? this.assignServiceCaseForm.get('programkey')?.value : null,
            subprogramkey: (this.assignServiceCaseForm.get('subprogramkey')?.value) ? this.assignServiceCaseForm.get('subprogramkey')?.value : null,
            assignedusers: this.workersList
        };
        const data: any[] = [];
        this.workersList.forEach((item) => {
            if (!item.responsibilitytypekey) {
                    data.push(item);
            }
            if(item.responsibilityevent) {
                item.responsibilityevent = null;
            }
        });
        if (!data.length) {
            this._commonHttpService
                .create(model,
                    'servicecase/assigncase'
                )
            .subscribe((_result) => {
                                        
                let isExpungementSuperUser= this._authService.isExpungementSuperUser();
                let url = '';
                if(isExpungementSuperUser=== 1) {
                    url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl + '?filter';
                } else {
                    url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl + '?filter';
                }
                this._commonHttpService
                    .getPagedArrayList(
                        new PaginationRequest({
                            page: 1,
                            limit: 100,
                            nolimit: true,
                            method: 'get',
                            where: {
                                intakenumber: this.intakeNumber,
                                isExpungementSuperUser: isExpungementSuperUser,
                                'iscaseexpunged': this.iscaseexpunged
                            }
                        }),
                        url
                    ).subscribe(response => {
                        if (response && response.data && response.data.length) {
                            this.involevedPerson = response?.data.filter(filterPersonData => filterPersonData.relationship !== 'SELF');
                            this.senChild = response.data.filter(filterSenData => filterSenData.senstatusflag === 1);
                            this.handleSenChildCondFn(caseid, serviceCaseId);
                            
                        } else {
                            this._alertService.success(this.servicecasesuccessmsg, true);
                            (<any>$(this.approveintakeackmtservicecasepopupid)).modal('hide'); // NOSONAR
                            const url1 = `/pages/cjams-dashboard/cw-intake-referals`;
                            this._router.navigate([url1]);
                        }
                        this.disableassign = false;

                    });
            });
            this._alertService.success(this.servicecasesuccessmsg);
            (<any>$(this.approveintakeackmtservicecasepopupid)).modal('hide'); // NOSONAR
            const url2 = `/pages/cjams-dashboard/cw-intake-referals`;
            this._router.navigate([url2]);
        } else {
            this.disableassign = false;
            this._alertService.error('Please Fill Responsibility');
        }
    }
    // Assosiated to assignServiceCaseToUser method
    private handleSenChildCondFn(caseid: any, serviceCaseId: any) {
        if (this.senChild && this.senChild.length) {
            this.handleSenChildLoopFn(caseid, serviceCaseId);
        } else {
            this.reusableNavigateFn();
        }
    }
    // Assosiated to assignServiceCaseToUser method
    private handleSenChildLoopFn(caseid: any, serviceCaseId: any) {
        this.senChild.forEach((item) => {
            const notificationData: any = {};
            notificationData.objectid = this.id;
            notificationData.isexternalentity = 'false';
            notificationData.subject = `Active Substance Exposed New Born (${item.fullname?.replace("'", " ").trim()} / ${item.cjamspid}) is added to case ${caseid}`;
            notificationData.priorityleveltypekey = 'High';
            notificationData.usernotificationtypekey = 'System';
            notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
            notificationData.securityusersid = this._authService.getCurrentUser().user.securityusersid;
            notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
            notificationData.objectcasenumber = caseid;
            notificationData.servicerequestnumber = serviceCaseId;
            notificationData.body = item.fullname?.trim() + " is added as a Active Birth Match Client in this Case.";

            // console.info((notificationData))
            this._commonHttpService.create(notificationData, this.notificationurl).subscribe(data => {
                if (data.length === 0) {
                    this._commonHttpService.create(notificationData, this.notificationaddurl).subscribe(_res => {
                        if (this.workersList.length) {
                            notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
                            notificationData.securityusersid = this.workersList[0].userid;
                            notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
                            this._commonHttpService.create(notificationData, this.notificationurl).subscribe(_result => {
                                this.handleNotificationaddCreateApiFn(notificationData, serviceCaseId);
                            });
                        } else {
                            this._alertService.success(this.servicecasesuccessmsg, true);
                            (<any>$(this.approveintakeackmtservicecasepopupid)).modal('hide'); // NOSONAR
                            const url1 = `/pages/cjams-dashboard/cw-intake-referals`;
                            this._router.navigate([url1]);
                        }
                    });
                } else {
                    this._alertService.success(this.servicecasesuccessmsg, true);
                    (<any>$(this.approveintakeackmtservicecasepopupid)).modal('hide'); // NOSONAR
                    const url2 = `/pages/cjams-dashboard/cw-intake-referals`;
                    this._router.navigate([url2]);
                }
            });
        });
    }
    // Assosiated to assignServiceCaseToUser method
    private handleNotificationaddCreateApiFn(notificationData: any, serviceCaseId: any) {
        this._commonHttpService.create(notificationData, this.notificationaddurl).subscribe(_res => {
            const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + serviceCaseId + '/casetype';
            this._commonHttpService.getAll(url).subscribe(response => {
                const dsdsActionsSummary = response[0];
                if (dsdsActionsSummary) {
                    notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
                    notificationData.securityusersid = dsdsActionsSummary.responsibleworkers[0].supervisorid;
                    notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
                    this._commonHttpService.create(notificationData, this.notificationurl).subscribe(data => {
                        if (data.length === 0) {
                            this._commonHttpService.create(notificationData, this.notificationaddurl).subscribe(() => {
                                this.reusableNavigateFn();
                            });
                        } else {
                            this.reusableNavigateFn();
                        }
                    });
                }
                else {
                    this.reusableNavigateFn();
                }
            });
        });
    }

    private reusableNavigateFn() {
        this._alertService.success(this.servicecasesuccessmsg, true);
        (<any>$(this.approveintakeackmtservicecasepopupid)).modal('hide'); // NOSONAR
        const url = `/pages/cjams-dashboard/cw-intake-referals`;
        this._router.navigate([url]);
    }
    getPersonsList(caseId: any) {
        this._commonHttpService.getPagedArrayList(
            {
                page: 1,
                limit: 20,
                method: 'get',
                where: { 'caseid': caseId }
            }, 'Caseassignments/getresponsibilitychild?filter').subscribe((item: any) => {
                this.childList =  item;
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
                event.value.forEach((value: any) => {
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
    private loadProgramAreaDropdowns(servicerequesttypekey: string) {
        this._commonHttpService
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
                this.cd.detectChanges();
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

    calculateResponseOffset(sdmInfo: any) {
        if (sdmInfo) {
            /* SDM Counter info
             isnoimmed_physicalabuse-- Physical abuse-response within 24 hours
             isnoimmed_sexualabuse -- Sexual abuse-response within 24 hours
             isnoimmed_neglectresponse --- Neglect-response within 5 days
             isnoimmed_mentalinjury --- Mental injury-response within 5 days
             isnoimmed_screeninoverride --- Screen-in Override
             isnoimmed_risk_harm --There is Risk ofHarm. Response within 5 days.
             isnoimmed_substantial_risk -- There is Risk of Harm for a Substance Exposed Newborn. Response within 48 hours.
             isnoimmed_risk_harm -- There is Risk of Harm. Response within 5 days.
             */

            if (sdmInfo.isnoimmed_physicalabuse || sdmInfo.isnoimmed_sexualabuse) {
                return 24;
            }

            if (sdmInfo.isnoimmed_substantial_risk) {
                return 48;
            }

            if (sdmInfo.isnoimmed_neglectresponse || sdmInfo.isnoimmed_mentalinjury || sdmInfo.isnoimmed_risk_harm) {
                return 24 * 5;  // 5 days
            }
        }
        return 0;
    }

    processRecordingsList() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const neededRoles = ['AV', 'CHILD', 'LG'];
        if (this.commonInvolvedPersons && this.commonInvolvedPersons.data
            && Array.isArray(this.commonInvolvedPersons.data)) {
            const needToContactPersons = this.commonInvolvedPersons.data.filter((person: any) => {
                if (person.roles.find((role: { intakeservicerequestpersontypekey: string; }) => neededRoles.indexOf(role.intakeservicerequestpersontypekey) !== -1)) {
                    return true;
                } else {
                    return false;
                }
            }).map((filteredPerson: any) => filteredPerson.roles[0].intakeservicerequestactorid);

            this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        page: this.paginationInfo.pageNumber,
                        limit: 100,
                        where: { intakeservicerequestactorids: needToContactPersons, isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged },
                        method: 'get'
                    }),
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.intakeNumber + '?data'
                )
                .subscribe((result) => {
                    if (result && Array.isArray(result.data)) {
                        this.getAllDaRecordingApiResponseFn(result, needToContactPersons);

                    }
                });
        }

    }
    // Associated to listUser function
    private getAllDaRecordingApiResponseFn(result: ListDataItem<any>, needToContactPersons: any) {
        const acceptedRecordings = result.data.filter(recording => {
            return ((recording.recordingtype === 'Face To Face' ||
                recording.recordingtype === 'Initialfacetoface' ||
                recording.recordingtype === 'Phone')
                && (recording.attemptind !== null));
        }
        );
        const recordingInfo = needToContactPersons.map((requestactorid: any) => {
            let isCompleted;
            for (const recodringInfo of acceptedRecordings) {
                const found = recodringInfo.contactparticipant.filter((participant: any) => participant.intakeservicerequestactorid === requestactorid);
                if (found && found.length > 0) {
                    isCompleted = true;
                    break;
                } 
            }
            return { requestactorid: requestactorid, completed: isCompleted };
        });

        if (needToContactPersons.length && needToContactPersons.length === recordingInfo.filter((info: any) => info.completed).length) {
            this.cpsResponseOffset = 0;
        } else {
            const intakeModel = this._dataStoreService.getData(
                IntakeStoreConstants.intakeModel
            );
            this.cpsResponseOffset = this.calculateResponseOffset(intakeModel.sdm);
        }
    }

    autoSaveAsDraft() {
        this.lastUpdatedTime = moment().format('MMM Do YY, h:mm:ss a');
        this.isAutoSaveFlag = true;
        if (this.isCW
            && this._authService.selectedRoleIs(AppConstants.ROLES.INTAKE_WORKER)
            && this.departmentActionIntakeFormGroup.status !== 'INVALID'
            && !this.closeCWCae
            ) {     
                   const addedNarrative = this.store[IntakeStoreConstants.addNarrative];
                   // Setting
                   if ( addedNarrative && addedNarrative.Narrative && addedNarrative.Narrative !== '') {
                        if ((!this.reviewstatus.status) || (this.reviewstatus.status === '') || (this.reviewstatus.status === 'Reopen')) {
                            if(!this.readOnly){
                              this.draftIntake(this.departmentActionIntakeFormGroup.getRawValue(), 'DRAFT', true);
                            }
                        }
                   }
        }
    }
    getCounty() {
        this._commonHttpService.getArrayList({ method: 'get', where : {}}, 'tb_provider/getFinanceCounty' + '?filter').subscribe((result) => {
          if (result !== null) {
              const userCounty = Array.isArray(result) && result.length ? result[0].countyname : '';
              this._dataStoreService.setData(IntakeStoreConstants.USER_COUNTY, userCounty);
          }
        });
      }
      closeModal() {
        (<any>$('#selectcpsid')).modal('hide'); // NOSONAR
        this._router.navigate([`pages/newintake/my-newintake/roa`]);
      }

    onActivate(elementRef: any) {
        if (elementRef.supervisoverridedecision === null && this.intake && this.intake.data && this.intake.data.length) {
            this.override = elementRef;
            this.override.intakeapproveddate = this.intake.data[0].dateclosed;
        }
    }

    private _getCaseDetails(){
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const url = 'Intakedastagings/getCasebyIntake';
            this._commonHttpService.post({'intakenumber':this.intakeNumber,
                'isExpungementSuperUser': isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged}, url).subscribe(
                (response) => {
                    const actionData = {"IR":"CPS-IR","AR":"CPS-AR"};
                    if(response.length){
                        this.getCasebyIntakeApiResponseFn(response, actionData);
                        this.serviceCase =  this.serviceCase.filter((x: any)=> x != undefined);
                        this._dataStoreService.setData('caseType', this.serviceCase[0]);
                        this.caseDate = moment(response[0].reporteddate).format(this.dtformat1);
                        if(response[0].actiontype =="IR"  || response[0].actiontype == "AR"){
                            this.servicecaseid = response[0].intakeserviceid;
                        } else {
                            this.servicecaseid = response[0].servicecaseid;
                        }
                        this._dataStoreService.setData(IntakeStoreConstants.SELECTED_INTAKE_CASE_DETAILS, {
                            caseNumber: this.caseNumber,
                            servicecaseid: this.servicecaseid,
                            serviceCase: this.serviceCase,
                            caseDate: this.caseDate
                        });
                        this.intakeServiceId = response[0].intakeserviceid;
                    }
        })
    }
 // Associated to _getCaseDetails function
    private getCasebyIntakeApiResponseFn(response: any, actionData: any) {
        if ((response[0].activeflag && response[0].actiontype == "N") || !response[0].activeflag || (response[0].activeflag && !response[0].actiontype)) {
            this.caseNumber = response[0].casenumber;
        } else if (response[0].activeflag && actionData[response[0].actiontype]) {
            this.caseNumber = response[0].servicerequestnumber;
        }
        this.serviceCase = response[0].activeflag && response[0].actiontype == '1' ? response.map((x: { programkey: string; subprogramkey: string; }) => {
            if (x.programkey && x.subprogramkey) {
                return x.programkey + '-' + x.subprogramkey;
            }
        }) : [actionData[response[0].actiontype] || 'Service Case'];
    }

    routeToCase(){
        let restrictedcasestatus;
        if(this.serviceCase.length && this.serviceCase[0] === "Service Case") {
            this._sessionStorage.setTabKeyKey(this.caseNumber);
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CPS_CASE_ID, this.intakeServiceId);
        }
        this._sessionStorage.setItem('cpsSkipApproval', 'false');
        this._commonHttpService.getById(this.servicecaseid , CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsCaseStatusUrl).subscribe((response) => {
          if (response && response.length) {
            restrictedcasestatus = response[0].getrestrictedcasestatus;
            if (restrictedcasestatus == 'EXCLUDE') {
                this._alertService.warn('User Cannot Access this Case');
                return ;
            } else {
                const url = this.caseworkerpageurl + this.servicecaseid + '/' + this.caseNumber + this.reportsummaryurl;
                window.open(url);
            }    
          } else {
            const url = this.caseworkerpageurl + this.servicecaseid + '/' + this.caseNumber + this.reportsummaryurl;
            window.open(url);
          }
        });
        
        
    }

   transferIntakeModal() {
    this.displayValidationMessages =false;
    ['approvedby', 'receivingcountyid', 'transferreason'].forEach((item) => {
        this?.intakeTransferForm?.get(item)?.clearValidators();
        this?.intakeTransferForm?.get(item)?.updateValueAndValidity();
    }); 
        this.intakeTransferForm.reset();
        this.loadRecivingJurisdiction();
        this.countysupervisorlist()
        const userinfo = this._authService.getCurrentUser();
        this.intakeTransferForm.patchValue({
            approvedby: userinfo.user.userprofile.supervisorid
        }) ;
        (<any>$('#transfer-intake')).modal('show'); // NOSONAR
    }
    
    loadRecivingJurisdiction(){
        this.intakeCountyList$.subscribe((data) => {
            const countyId = this.departmentActionIntakeFormGroup.getRawValue().countyid;
            this.recievingIntakeCountyList = data.filter((county) => county.value !== countyId);
        })
    }

    transferIntakeforApproval() {
        this.displayValidationMessages =false;
        ['approvedby', 'receivingcountyid', 'transferreason'].forEach((item) => {
            this?.intakeTransferForm?.get(item)?.setValidators([Validators.required]);
            this?.intakeTransferForm?.get(item)?.updateValueAndValidity();
        });
        if (this.intakeTransferForm.invalid) {
            this.displayValidationMessages =true;
            this.intakeTransferForm.markAllAsTouched();
            return;
        }
        const countyId = this.departmentActionIntakeFormGroup.getRawValue().countyid;
        const purposeId = this.departmentActionIntakeFormGroup.getRawValue().Purpose;
        const userinfo = this._authService.getCurrentUser();
        this.intakeTransferForm.patchValue({
            sendingcountyid: countyId,
            transferdate: this.currentDate,
            approvalstatus: 15
        })
        const formData = this.intakeTransferForm.getRawValue();
        formData.intakenumber = this.intakeNumber
        formData.securityusersid = userinfo.user.securityusersid;
        formData.purposeid = purposeId;
        this._commonHttpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.AddUpdate).subscribe(
            (response) => {
                if (response) {
                  this._alertService.success('Transfer request has been sent for approval');
                  this.getTrasferHistory();
                  (<any>$('#transfer-intake')).modal('hide'); // NOSONAR
                } else {
                  this._alertService.warn(this.tryagainlatermsg);
                }
            },
            (_error) => {
                this._alertService.warn(this.tryagainlatermsg);
            }
        );
    }

    loadSupervisorList() {
        this._commonHttpService.getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'CWIF' },
                method: 'post'
            }),
            this.getroutingusersurl
        )
        .subscribe(result => {
            this.supervisorsList = result.data;
            this.supervisorsList = this.supervisorsList.filter(
                users => users.rolecode === 'SP'
            );
        });
    }

    getTrasferHistory() {

        const formData = {
            intakenumber: this.intakeNumber,
            page : 1,
            limit : 20,
            method: 'get'
        }

        this._commonHttpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.GetByIntakeNumber).subscribe(
            (response) => {
                this.transferHistory = response.map((item: any)=>{
                    if(item.approvalstatus === 'Approved' && !item.receivingcountyworker && (this.roleId.role.key==='CWSP' || this.roletypekey ==='CWSP')){
                        item.receivingcountyworkername = 'Assign'
                    }
                    return item;
                });
                this.transferHistoryApproved = this.transferHistory ? this.transferHistory.filter((history: any) => history.approvalstatus === 'Review') : [];
                this._dataStoreService.setData('transferHistory', this.transferHistoryApproved);
                const countyId = this.departmentActionIntakeFormGroup.getRawValue().countyid;
                const userinfo = this._authService.getCurrentUser();
                const usercounty = this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.team.countyid;
                this._dataStoreService.setData('transferHistorycountyid', countyId);
                this._dataStoreService.setData('authorstatus', (this.departmentActionIntakeFormGroup.get('Author')?.value == userinfo.user.userprofile.fullname || this.departmentActionIntakeFormGroup.get('Author')?.value == userinfo.user.userprofile.displayname));

                if(this.transferHistoryApproved && this.transferHistoryApproved.length > 0) {
                    if(usercounty === countyId && this._dataStoreService.getData('authorstatus')) {
                        this.disableIntakeServicesType = false;
                    } else {
                        this.disableIntakeServicesType = true;
                        this.readOnly = true;
                    }
                } else {
                    if(usercounty !== countyId) {
                        this.disableIntakeServicesType = true;
                        this.readOnly = true;
                    }
                }
            },
            (_error) => {
                this._alertService.warn(this.tryagainlatermsg);
            }
        );
        
    }

    openStatusModal(data: any, rs: any){
        this.displayValidationMessages =false;
        ['receivingcountyid', 'transferreason', 'rejectionreason','receivingcountysupervisor'].forEach((item) => {
            this?.intakeTransferStatusForm?.get(item)?.clearValidators();
            this?.intakeTransferStatusForm?.get(item)?.updateValueAndValidity();
        }); 
        this.intakeTransferStatusForm.reset();
        this.loadSupervisorList();
        this.onChangeJurisdiction(data.receivingcountyid, rs);
        (<any>$('#transfer-intake-status')).modal('show'); // NOSONAR
        this.intakeTransferStatusForm.controls['receivingcountyid'].patchValue(data.receivingcountyid);
        this.intakeTransferStatusForm.controls['receivingcountysupervisor'].patchValue(null);
        this.intakeTransferStatusForm.controls['transferreason'].patchValue(data.transferreason);
        this.intakeTransferStatusForm.controls['requestedby'].patchValue(data.requestoridrequestorid);
        this.intakeTransferStatusForm.controls['intaketransferid'].patchValue(data.intaketransferid);
    }

    selectedApprove(selectedCase: any) {
        this.displayValidationMessages =false;
       if (selectedCase === 'A') {
        this.intakeTransferStatusForm.controls['receivingcountysupervisor'].setValidators([Validators.required]);
        this.intakeTransferStatusForm.controls['receivingcountysupervisor'].updateValueAndValidity();
        this.intakeTransferStatusForm.controls['rejectionreason'].clearValidators();
        this.intakeTransferStatusForm.controls['rejectionreason'].updateValueAndValidity();
    } else {
        this.intakeTransferStatusForm.controls['rejectionreason'].setValidators([Validators.required]);
        this.intakeTransferStatusForm.controls['receivingcountysupervisor'].clearValidators();
        this.intakeTransferStatusForm.controls['receivingcountysupervisor'].updateValueAndValidity();
        this.intakeTransferStatusForm.controls['rejectionreason'].updateValueAndValidity();
       }
    }

    onChangeJurisdiction(id: any, rs: any){
        this.supervisorsCollection = [];
        if(id){
            const formData = {
                v_countyid: (rs && rs === 'receivingSupervisor') ? id : this.departmentActionIntakeFormGroup.getRawValue().countyid, 
                v_roletypekey: null,
                method: 'post'
            }
            this._commonHttpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.GetSupervisorByCountyId)
            .subscribe(result => {

                const supervisorsCollection = result[0].getsupervisorsbycounty;
                const filterSupervisors  =supervisorsCollection.filter((item: { roletypekey: string; })=>item.roletypekey =='CWSP');
                const sortedordersupervisors = _.sortBy(filterSupervisors,'fullname');
                this.supervisorsCollection = sortedordersupervisors;
            });
        }
    }
    
    transferIntakeforStatusApproval() {
        this.displayValidationMessages =false;
        ['receivingcountyid', 'transferreason'].forEach((item) => {
			this?.intakeTransferStatusForm?.get(item)?.setValidators([Validators.required]);
			this?.intakeTransferStatusForm?.get(item)?.updateValueAndValidity();
		});
        const _value = this?.intakeTransferStatusForm?.controls['approvalstatus']?.value;
        if(_value){
            const _item = _value === '17'?'rejectionreason':'receivingcountysupervisor';
            if(_item){
                this?.intakeTransferStatusForm?.get(_item)?.setValidators([Validators.required]);
                this?.intakeTransferStatusForm?.get(_item)?.updateValueAndValidity();
            }
        }
        if (this.intakeTransferStatusForm.invalid) {
            this.displayValidationMessages =true;
            this.intakeTransferStatusForm.markAllAsTouched();
            return;
        }
        const countyId = this.departmentActionIntakeFormGroup.getRawValue().countyid;
        const userinfo = this._authService.getCurrentUser();
        this.intakeTransferStatusForm.patchValue({
            sendingcountyid: countyId,
            transferdate: this.currentDate
        })
        const formData = this.intakeTransferStatusForm.getRawValue();
        formData.securityusersid = userinfo.user.securityusersid;
        formData.intakenumber = this.intakeNumber;
        formData.approvedby = userinfo.user.securityusersid;
       
        this._commonHttpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.AddUpdate).subscribe(
            (response) => {
                if (response) {
                if(this.intakeTransferStatusForm.controls['approvalstatus'].value === "16"){
                    this._alertService.success('Transfer request has been approved');
                    this.departmentActionIntakeFormGroup.patchValue({
                        countyid: formData.receivingcountyid
                    });
                }else{
                    this._alertService.success('Transfer request has been rejected');
                }
                    this.getTrasferHistory();
                  (<any>$('#transfer-intake-status')).modal('hide'); // NOSONAR
                } else {
                  this._alertService.warn(this.tryagainlatermsg);
                }
            },
            (_error) => {
                this._alertService.warn(this.tryagainlatermsg);
            }
        );
    }

    openIntakeAssign(data: any){
        this.displayValidationMessages =false;
        this?.intakeTransferAssignForm?.get('receivingcountyworker')?.clearValidators();
	    this?.intakeTransferAssignForm?.get('receivingcountyworker')?.updateValueAndValidity();
        this.intakeTransferAssignForm.reset();
        this.loadIntakeWorkers();
        this.intakeTransferAssignForm.controls['intaketransferid'].patchValue(data.intaketransferid);
        this.intakeTransferAssignForm.controls['approvedby'].patchValue(data.approverid);
        this.intakeTransferAssignForm.controls['receivingcountyid'].patchValue(data.receivingcountyid);
        this.intakeTransferAssignForm.controls['receivingcountysupervisor'].patchValue(data.receivingcountysupid);
        this.intakeTransferAssignForm.controls['transferreason'].patchValue(data.transferreason);
        this.onChangeJurisdiction(data.receivingcountyid, '');
        (<any>$('#transfer-intake-assign')).modal('show'); // NOSONAR
    
    }

    private loadIntakeWorkers() {

        this._commonHttpService
      .getPagedArrayList(
        {
          where: { appevent: 'INTUSERS' },
          method: 'post'
        },
        this.getroutingusersurl
      ).subscribe(result => {
        this.intakeWorkerList = result.data;
      });
    
    }

    transferIntakeforAssign(){
        this.displayValidationMessages =false;
        this?.intakeTransferAssignForm?.get('receivingcountyworker')?.setValidators([Validators.required]);
        this?.intakeTransferAssignForm?.get('receivingcountyworker')?.updateValueAndValidity();
        if (this.intakeTransferAssignForm.invalid) {
            this.displayValidationMessages =true;
            this.intakeTransferAssignForm.markAllAsTouched();
            return;
        }
        const countyId = this.departmentActionIntakeFormGroup.getRawValue().countyid;
        const userinfo = this._authService.getCurrentUser();
        this.intakeTransferAssignForm.patchValue({
            sendingcountyid: countyId,
            approvalstatus: 18            
        })
        const formData = this.intakeTransferAssignForm.getRawValue();
        const  receivingcountyworkerid = formData.receivingcountyworker;
         const intakeworker: any= this.intakeWorkerList.find(item=>item.userid === receivingcountyworkerid);
        this.departmentActionIntakeFormGroup.patchValue({
        Author : intakeworker.username
    })
        formData.securityusersid = userinfo.user.securityusersid;
        formData.intakenumber = this.intakeNumber;
        formData.updatedby = userinfo.user.securityusersid;


        this._commonHttpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.AddUpdate).subscribe(
            (response) => {
                if (response) {
                  this._alertService.success('Transfer request has been sent for approval');
                  this.getTrasferHistory();
                  this.departmentActionIntakeFormGroup.controls['countyid'].patchValue(
                    formData.receivingcountyid
                   );
                  (<any>$('#transfer-intake-assign')).modal('hide'); // NOSONAR
                } else {
                  this._alertService.warn(this.tryagainlatermsg);
                }
            },
            (_error) => {
                this._alertService.warn(this.tryagainlatermsg);
            }
        );
    }

    /**
     * Transfer reason popup open
     * @param listItem 
     */
     openTrasferReasoneDialog(listItem: any): void {
         if(listItem.transferreason){
             this.transferReason = listItem.transferreason;
         }else{
            this.transferReason = "No Transfer reason found";
         }
        this.transferReason = this.transferReason.replace(/''/g, `'`);
        (<any>$('#trasfr-reason-dialog')).modal('show'); // NOSONAR
    }


    openRejectionReasoneDialog(listItem: any): void {
        if(listItem.rejectionreason){
            this.rejectionReason = listItem.rejectionreason;
        }else{
           this.rejectionReason = "";
        }
       this.rejectionReason = this.rejectionReason.replace(/''/g, `'`);
       (<any>$('#rejection-reason-dialog')).modal('show'); // NOSONAR
   }


    
  getInvolvedPerson(appevent: string, isApprove: boolean) {
    
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where:{
            intakenumber: this.intakeNumber,
            isExpungementSuperUser: isExpungementSuperUser,
            'iscaseexpunged': this.iscaseexpunged
          }
        }),        
        url + '?filter'
      ).subscribe(response => {
        if (response && response.data && response.data.length) {
            this.involvedPersonData = response?.data; //Need for 1080 check, but moving forward can use for other scenarios too
            this.involevedPerson = response?.data.filter(data => data.relationship !== 'SELF');
            this.senChild = response.data.filter(data => data.senstatusflag === 1);
          }

          this.newSubmitIntake(appevent, isApprove);
      })
  }
  countysupervisorlist(){
       const countyids  =this.departmentActionIntakeFormGroup.get('countyid')?.value ;
       this.supervisorsCollectionfortransfer = [];
        const formData = {
            v_countyid: countyids,
            v_roletypekey: null,
            method: 'post'
        }
        this._commonHttpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.GetSupervisorByCountyId)
        .subscribe(result => {
            const supervisorsCollectionfortransfer = result[0].getsupervisorsbycounty;
            const filterSupervisors =supervisorsCollectionfortransfer.filter((item: { roletypekey: string; })=>item.roletypekey ==='CWSP');
            const sortedordersupervisors = _.sortBy(filterSupervisors,'fullname');
            this.supervisorsCollectionfortransfer = sortedordersupervisors;
        });
        
}

checktransferdisable() {
    const userinfo = this._authService.getCurrentUser();
    const countyid = this.departmentActionIntakeFormGroup.get('countyid')?.value;
    if (countyid === userinfo.user.userprofile.teammemberassignment.teammember.team.countyid){
        if(userinfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey =='CWSP'){
            let isAssignmentToBeDone = this.transferHistory?.some((e: { receivingcountyworkername: string; }) => e.receivingcountyworkername === 'Assign');
            return isAssignmentToBeDone ? true : false;
        }
        else if(this.departmentActionIntakeFormGroup.get('Author')?.value == userinfo.user.userprofile.fullname || this.departmentActionIntakeFormGroup.get('Author')?.value == userinfo.user.userprofile.displayname )
            {
                return false;
            } 
        else {
            return true;
            }
    } 
    else {
        return true;
    }

}
checkreview(){
    const userinfo = this._authService.getCurrentUser();
    const countyid = this.departmentActionIntakeFormGroup.get('countyid')?.value;
    if ((countyid === userinfo.user.userprofile.teammemberassignment.teammember.team.countyid) &&
     (userinfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey =='CWSP')){
     return true;   
    } else {return false;}

}
Checkforsupervisor(data: any){
   const userinfo = this._authService.getCurrentUser();
   if((data.receivingcountyid == userinfo.user.userprofile.teammemberassignment.teammember.team.countyid) && (userinfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey =='CWSP'))
    {
        return false;
   } else {return true;}
 }
 getcommonInvolvedPerson(){
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 100,
        nolimit: true,
        method: 'get',
        where:{
          intakenumber: this.intakeNumber,
          isExpungementSuperUser: isExpungementSuperUser,
          'iscaseexpunged': this.iscaseexpunged
        }
      }),      
      url+ '?filter'
    ).subscribe(response => {
      if (response && response.data && response.data.length) {
          this.commonInvolvedPersons = response;
        }   
 })
}

intakeTransferFormErrorsMessage(ControlName: any, displayName: any){
	if(this.intakeTransferForm.controls[ControlName].status =='INVALID' ){
	return (ControlName==='receivingcountyid') ? 'Please select receiving jurisdiction' : this.validationmsg + displayName;
	}
}

intakeTransferStatusFormErrorsMessage(ControlName: any, displayName: any){
    const msg = (ControlName==='receivingcountysupervisor') ? 'Please select receiving supervisor' : this.validationmsg + displayName;
	if(this.intakeTransferStatusForm.controls[ControlName].status =='INVALID' ){
	    return (ControlName==='receivingcountyid') ? 'Please select receiving jurisdiction' : msg;
	}
}

getErrorsMessage(ControlName: any, displayName: any){
	if(this.intakeTransferAssignForm.controls[ControlName].status =='INVALID' ){
    return (ControlName==='receivingcountyworker') ? 'Please select intake worker' : this.validationmsg + displayName;
	}
}
    intakerecommendationtext(description: any) {
        if (description === 'Scrnin' || description === 'scrnin') {
            return ('Screened In');
        } else if (description?.toLowerCase() === 'screenout') {
            return ('Screened Out')
        } else if (description == this.supDecisionWorker) {
            return (this.supDecisionWorker);
        } else if (description == this.supDecisionNarrative) {
            return (this.supDecisionNarrative);
        } else if (description == 'progress roa' || description == 'Progress ROA' ){
            return ('Progress ROA')
        }
    }
    private checkroacps(narrative: any, roacps: any){
        if(this.showaddendumnarrative){
        if(!narrative?.addendumNarrative && !(roacps && roacps?.statetype === 'instate')){
            this.intakeErrorMessage =
            'Please add values in Addendum Narrative';
            (<any>$(this.intakeerrorpopupid)).modal('show'); // NOSONAR
            return false;

        }
        
    }
    return true;
    }
    

    getForm1080A() {
        const inputRequest = {
            objectid: [this.id,this.intakeNumber],
        };
        this._genericServiceNarative.getArrayList(
            new PaginationRequest({
                where: inputRequest,
                method: "get",
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.List + "?filter"
        ).subscribe(
            (response) => {
                if (response) {
                    this.form1080aData = response;
                }
            },
            (error) => {
                this._alertService.warn('Error retrieving Form 1080A data');
            }
        );
    }

    isValidDate(dateObject: any){
        return dateObject ? new Date(dateObject).toString().toLowerCase() !== 'invalid date' : false;
    }


    /*

    if (!validPersonsForIPL && (intakesdmcheck?.cpsResponseType === 'CPS-AR' || intakesdmcheck?.cpsResponseType === 'CPS-IR')) {
        return this.checkCpsResponseTypeConditionFn(validPersonsForAV, validPersonsForAM)
    }

    private checkCpsResponseTypeConditionFn(validPersonsForAV: any[], validPersonsForAM: any[]) {
        if(!validPersonsForAV.length && !validPersonsForAM.length){
            this._alertService.error('Alleged Maltreator and Alleged Victim are mandatory to submit for supervisor Approval.');
        }else if(!validPersonsForAV.length){
            this._alertService.error('Alleged Victim is mandatory to submit for supervisor Approval.');
        }else if(!validPersonsForAM.length){
            this._alertService.error('Alleged Maltreator is mandatory to submit for supervisor Approval.');
        }else {
            this._alertService.error('CHILD is mandatory to submit for supervisor Approval.');
        }
        return false;
    }

    */

    getControlByIndexFn(index: string): FormControl {
        return this.departmentActionIntakeFormGroup.controls[index] as FormControl;
    }

    showResourcePopup(data: any) {
        // No data or function to call
    }

    getConditionForSectionFn() {
        return this.selectedIntakeServices.length 
        && this.intakeServiceGrid 
        && this.departmentActionIntakeFormGroup?.controls['Purpose']?.value !== '7933508f-0350-4552-be50-350598a387a7~CW'
    }

    openPicker() {
        this.picker2.open();
    }

    onPickerClosed(event: any, controlName: string) {
        const control = this.departmentActionIntakeFormGroup.get(controlName);
        const selectedDate = control?.value;
        if (selectedDate) {
        const maxDate: any = this.maxReceivedDate;
        if (selectedDate > maxDate) {
            control.setValue(maxDate);
        }
        }
    }

    getintakesnapshotrecord() {
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: {
                        intakenumber: this.intakeNumber
                    }
                },
                'Intakedastagings/getintakesnapshotrecord?filter'
            )
            .subscribe((response: any) => {
                const intakeFormData: any = response && response.length ? response[0] : null;
                if (intakeFormData && intakeFormData.jsondata && intakeFormData.jsondata.disposition) {
                    this._dataStoreService.setData('intakesnapshotrecorddisposition', intakeFormData.jsondata.disposition);
                }
            });
    }

}
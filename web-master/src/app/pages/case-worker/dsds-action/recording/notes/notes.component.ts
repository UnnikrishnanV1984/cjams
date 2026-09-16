import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit, OnDestroy, ViewEncapsulation, Injector, ChangeDetectorRef,ViewChild} from '@angular/core';
import { AbstractControl, FormBuilder, FormControl, FormGroup, ValidationErrors, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import moment from 'moment';
import { Observable ,  forkJoin ,  Subject } from 'rxjs';
import { ObjectUtils } from '../../../../../@core/common/initializer';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, AuthService, CommonHttpService, ValidationService, DataStoreService, SessionStorageService, GlobalPopupService } from '../../../../../@core/services';
import {
    CaseWorkerContactRoles, CaseWorkerRecording, CaseWorkerRecordingEdit, CaseWorkerRecordingType,
    ProgressNoteRoleType, SearchRecording
} from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Attachment } from '../../attachment/_entities/attachment.data.models';
import category from '../_configurations/category.json';
import sortByData from '../_configurations/sortBy.json';
import status from '../_configurations/status.json';
import type from '../_configurations/type.json';
import _ from 'lodash';
import { ContactParticipant, ParticipantType, ReasonForContact, RecordingNotes } from '../_entities/recording.data.model';
import { SpeechRecognitionService } from '../../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { DsdsService } from '../../_services/dsds.service';
import jsPDF from 'jspdf';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { AppConstants } from '../../../../../@core/common/constants';
import { IntakeStoreConstants } from '../../../../newintake/my-newintake/my-newintake.constants';
import { MatRadioChange } from '@angular/material/radio';
import { AppConfig } from '../../../../../app.config';
import { config } from '../../../../../../environments/config';
import { ToastrService } from 'ngx-toastr';
import { HttpClient } from '@angular/common/http';
import { Editor, Toolbar } from 'ngx-editor';
import { TransferHistoryApprovedService } from '../../../../../shared/services/transfer-history-approved.service';
import { UploadSharedService } from '../../../../../../../src/app/@core/services/upload-shared.service';
import { GLOBAL_MESSAGES } from '../../../../../../../src/app/@core/entities/constants';
import { GenericService } from '../../../../../../../src/app/@core/services/generic.service';
import { NewUrlConfig } from '../../../../../../../src/app/pages/newintake/newintake-url.config';
import { GlobalPopupComponent } from '../../../../../../../src/app/shared/shared-components/global-popup/global-popup.component';
import { HttpService } from '../../../../../../../src/app/@core/services/http.service';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    encapsulation: ViewEncapsulation.None,
    selector: 'notes',
    templateUrl: './notes.component.html',
    styleUrls: ['./notes.component.scss'],
    standalone: false
})
export class NotesComponent implements OnInit, OnDestroy {
    @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent;
    searchparams: any;
    recordingSubTypeDropDown: any;
    startEndTimeValidator!: boolean;
    searchParamArr: any[] = [];
    searchParameter: any;
    attachmentGrid$!: Observable<Attachment[]>;
    dateValidation = true;
    viewEdit!: string;
    currentDate: Date = new Date();
    categoryForm!: FormGroup;
    updateAppend!: FormGroup;
    commentForm!: FormGroup;
    courtForm!: FormGroup;
    source!: string;
    sourceEdited!: string | null;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    id!: string;
    disableSave!: boolean;
    lastUpdatedTime: any = null;
    daNumber!: string;
    multipleRoles!: string;
    recordingForm!: FormGroup;
    emailForm!: FormGroup;
    searchCategoryForm!: FormGroup;
    saveButton!: boolean;
    isCW!: boolean;
    isInvolvePerson!: boolean;
    isotherPerson!: boolean;
    isUploadClicked!: boolean;
    recordingCategory = false;
    contactpurpose = false;
    notetext = false;
    searchWorkerName = false;
    searchContactType = false;
    searchLocation = false;
    sortBy = false;
    recordDate = false;
    contactDate = false;
    autoSaveError : boolean = false;
    paginationInfo: PaginationInfo = new PaginationInfo();
    recordingedit: CaseWorkerRecordingEdit = new CaseWorkerRecordingEdit();
    editRecord: RecordingNotes | null = null;
    viewRecord: RecordingNotes = new RecordingNotes();
    appendNoteControl!: AbstractControl | null;
    typeDropdown: DropdownModel[] = [];
    statusDropdown: DropdownModel[] = [];
    categoryDropdown: DropdownModel[] = [];
    sortDropDown: DropdownModel[] = [];
    userInfo!: AppUser;
    addNotes: RecordingNotes = new RecordingNotes();
    recordingDetail!: CaseWorkerRecording;
    recording: RecordingNotes[] = [];
    totalRecords$!: Observable<number>;
    totalRecords!: number;
    canDisplayPager$!: Observable<boolean>;
    recordingType$!: Observable<CaseWorkerRecordingType[]>;
    recordType: any;
    contactRoles$!: Observable<CaseWorkerContactRoles[]>;
    participantType$!: Observable<ParticipantType[]>;
    progressNoteRoleType: ProgressNoteRoleType[] = [];
    focusProgressNoteRoleType: ProgressNoteRoleType[] = [];
    personNameDescription: string[] = [];
    focurPersonNameDescription: string[] = [];
    duration!: string;
    isCourtDetails = false;
    autoSaveFlag = false;
    progressNoteActor : Array<any> = [];
    private readonly pageSubject$ = new Subject<number>();
    private recordSearch = new SearchRecording();
    reasonForContactResponse!: Array<ReasonForContact[]>;
    motivationalInterviewOptions:Array<any> = []; 
    reasonForContact: ReasonForContact[] = [];
    personRoles : Array<any> = [];
    collateralPersons: any[] = [];
    involvedPersons: any[] = [];
    focusInvolvedPersons: any[] = [];
    originalFocusInvolvedPersons : any[] = [];
    originalInvolvedPersons: any[] = [];
    edittimeduration = false;
    isSerachResultFound!: boolean;
    minDate = new Date();
    maxDate = new Date();
    actors: any[] = [];
    Others = { intakeservicerequestactorid: 'Others' };
    initiateText!: boolean;
    currentDescription: any = null;
    attempText!: boolean;
    initialFace = false;
    stateValuesDropdownItems$!: Observable<DropdownModel[]>;
    CountyValuesDropdownItems$!: Observable<DropdownModel[]>;
    recognizing = false;
    speechRecogninitionOn!: boolean;
    notification!: string;
    agency!: string;
    currentLanguage!: string;
    enableAppend = false;
    isServiceCase = false;
    personinvolved: any[] = [];
    selectedNotes!: string;
    selectedNotesForView!: string;
    pageNumber!: number;
    histData: any[] = [];
    userRole: any;
    isIntakeWorker!: boolean;
    uploadedDocuments: any = [];
    personid= '';
    attachmenttype= 'case';
    uploadType= 'note';
    isDateCheck = false;
    isDate24Check = false;
    calculatedContactDuration!: string;
    calculatedTravelDuration!: string;
    tempData: any[] = [];

    // Least and max date for a contact note to be added
    maxContactDate = new Date(); // Max date will always be todays date
    minContactDate = new Date(); // Min date will vary depending on Intake or Case received date

    // Filter, Search or Sort
    // Filter, Search or Sort
    selectedActionType!: string | null;
    downldSrcURL!: string;
    baseUrl: string;
    personContacted = false;
    insertedByDetails!: any[];
    caseType!: string;
    entityType!: string;
    selectedRecord: any;
    isClosed = false;
    isAddEdit = false;
    householdPeopleLoaded!: boolean;
    collateralsLoaded!: boolean;
    waitingForLoading!: boolean;
    qualityForm!: FormGroup;
    toolbar:any=AppConstants.NARRATIVE_TEMP.TOOLBAR_CONFIG;
    isReadonly= true;
    savedisable = false;
    over5Days = "Within 24 Hrs - Can Edit. \n 24 Hrs to 5 Days - Add Addendum. \n After 5 Days - Only View."
    isfilterUsed!: boolean;
    // @ViewChild('myPopover')
    // myPopover: Popover;
    isCareDisabled = false;
    isEditDisabled = false;
    isAddDisabled = false;
    errormessage!: string;
    autoSaveInitiated: any;
    autoSaveIntervalTimer!: any;
    autoSavedRecordsExist!: boolean;
    viewQualityCare: boolean = false;
    navigationUrl!: string;
    checkPageNavigationFlag: boolean = false;
    contactNotesSavedl: boolean = false;

    //Ngx-Editor
    editor!: Editor;
    editorHtml: any; 
    toolbarEditor: Toolbar = [
        ['bold', 'italic'],
        ['underline', 'strike'],
        ['ordered_list', 'bullet_list'],
        [{ heading: ['h4', 'h5', 'h6'] }],
        ['align_left', 'align_center', 'align_right', 'align_justify']
    ];
    load:boolean = false;
    intakeNumber:any;
    checkmandatory: boolean = false;
    // hasFamilyAccessToCase: boolean = false;
    recordingspopupid = '#myModal-recordings';
    uploadattachmentpopupid = '#upload-attachment';
    savecontactnotestr = 'save-contact-note';
    downloadcontactnotestr = 'download-contact-note';
    savenoteaddendumstr = 'save-note-addendum';
    recordingswaitingpopupid = '#myModal-recordings-waiting';
    facetoface = 'Face To Face';
    weeklyvisits = 'Weekly Visits';
    contactsaveerrorpopupid = '#ContactSaveError';
    dtformat = 'MM/DD/YYYY';
    retrynotesid: any;
    retrydoc: any;
    notesListCheck: any;
    isFileInProgress: boolean = false;
    isMotivationInterviewSelected : boolean = false; 
    private wasMISelected = false;
    isDelay: boolean = false;
    isActiveOOH: boolean = false;
    holidays = [];

    private readonly formBuilder: FormBuilder;
    private readonly route: ActivatedRoute;
    private readonly _commonHttpService: CommonHttpService;
    private readonly http: HttpClient;
    public _authService: AuthService;
    private readonly _alertService: AlertService;
    private readonly _route: Router;
    private readonly _speechRecognitionService: SpeechRecognitionService;
    private readonly speechRecognizer: SpeechRecognizerService;
    private readonly _dsdsService: DsdsService;
    private readonly _dataStoreService: DataStoreService;
    private readonly _session: SessionStorageService;
    private readonly toastr: ToastrService;
    private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;
    private readonly _globalPopupService: GlobalPopupService;
    private readonly cdr: ChangeDetectorRef;
    private shareduploadService: UploadSharedService;
    private readonly _httpService: HttpService;
    private _service: GenericService<any>
    constructor(private injector: Injector) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.http = this.injector.get<HttpClient>(HttpClient);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._route = this.injector.get<Router>(Router);
        this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this.speechRecognizer = this.injector.get<SpeechRecognizerService>(SpeechRecognizerService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this.toastr = this.injector.get<ToastrService>(ToastrService);
        this._transferHistoryApprovedService = this.injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);
        this._globalPopupService = this.injector.get<GlobalPopupService>(GlobalPopupService);
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this.shareduploadService = this.injector.get<UploadSharedService>(UploadSharedService);
        this._service = this.injector.get<any>(GenericService);
        this._httpService = this.injector.get<any>(HttpService);
        this.baseUrl = AppConfig.baseUrl;
        this.route.queryParams.subscribe(params => {
            this.retrydoc = params['retrydocument'];
            this.retrynotesid = params['retryid'];
        });
    }

    ngOnInit() {
        this.editor = new Editor();
        this.isDelay = false;
        this.isCareDisabled = this._authService.isDisabled('contacts', 'contacts.notes.qualitycare');
        this.isEditDisabled = this._authService.isDisabled('contacts', 'contacts.notes.edit');
        this.isAddDisabled = this._authService.isDisabled('contacts', 'contacts.notes.addnew');
        this.viewEdit = 'Add';
        this.householdPeopleLoaded = false;
        this.collateralsLoaded = false;
        this.waitingForLoading = false;
        this.startEndTimeValidator = false;
        this.userRole = this._authService.getCurrentUser();
        if (this.userRole?.role?.name !== AppConstants.ROLES.SUPERVISOR) {
            const activeModuleRole = this._session.getItem('activeModuleRole');
            this.isReadonly = this._authService.readonlyButton('read_only_access', 'caseworker-contacts-notes-add-new');
            if (['CJAMS_SSA_FTDM_FACILITATOR','CJAMS_SSA_QUALIFIED_INDIVIDUAL' ,'CJAMS_SSA_FTDM_QI_SUPERVISOR'].includes(activeModuleRole)) {
                this.isReadonly = this.compareWithResponsibleworkers(this.userRole.user.email);
            }
        }
        this.getHolidays();
        this.getContactLocationsDropDown();
        this.id = this.getCaseUuid();

        this.caseType = this.getCurrentCaseType();
        this.entityType = this.getEntityType();
        this.daNumber = this.getCaseNumber();
        this.source = this.getCurrentCaseType();
        this.isIntakeWorker =
            this.userRole.role.name === AppConstants.ROLES.INTAKE_WORKER;

        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.isServiceCase = this._dsdsService.isServiceCase();
        this.agency = this._authService.getAgencyName();
        this.currentLanguage = 'en-US';
        this.addContactNotesAudit('open-contact-note', null);
        this.isUploadClicked = false;
        this.speechRecognizer.initialize(this.currentLanguage);
        this.statusDropdown = <any>status;
        this.typeDropdown = <any>type;
        this.categoryDropdown = <any>category;
        this.sortDropDown = <any>sortByData;
        this.isCW = this._authService.isCW();
        this.getStateDropdown();
        this.getCountyDropdown();
        this.formInitilize();
        this.pageSubject$.subscribe((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            this.getPage(this.paginationInfo.pageNumber);
        });
        this.getPage(1);
        this.recordingDropDown();
        this.attachmentDropdown();
        this.getInvolvedPerson();
        this.getcollateral();
        this.getReasonForContact();
        this.appendNoteControl = this.recordingForm.get('appendtitle');
        this.userInfo = this._authService.getCurrentUser();

        this.setMinContactDate();

        this.statusCheckFn();

        this.formInvolvedPersonsDropDown();
        $('body').on('shown.bs.modal', this.recordingspopupid, function () {
            $('#myModal-recordings .modal-body').scrollTop(0);
        });
        if (this.userRole.role.name === 'CJAMS_SSA_FTDM_FACILITATOR' || 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this._authService.readonlyPage('read_only_access', 'contact-note-edit-mode',
                [this.courtForm, this.emailForm, this.updateAppend, this.commentForm]);
        }
        else {
            this._authService.readonlyPage('read_only_access', 'contact-note-edit-mode',
                [this.courtForm, this.emailForm, this.updateAppend, this.commentForm, this.recordingForm]);
        }
        this._authService.setIntakeReadOnly([this.courtForm, this.emailForm, this.categoryForm, this.updateAppend, this.commentForm, this.recordingForm]);
        if(this.isIntakeMode() && this._transferHistoryApprovedService.getTrasferHistory()) {
            this.isClosed = true;
        }
        this._globalPopupService.resetData();
        this.shareduploadService.uploadFileProgress$.subscribe(uploadprogress => {
            if(uploadprogress?.length){
                if(uploadprogress.every((ele: any) => ele.progress == 100)){
                 this.isFileInProgress = false;
                }else{
                 this.isFileInProgress = true;
                }
            }
        });
    }
    // Assosiated to ngOnInit methodd
    private statusCheckFn() {
        const da_status = this._session.getItem('da_status');
        if (da_status) {
            this.isClosed = false;
            if (da_status === 'Closed' || da_status === 'Completed') {
                this.isClosed = true;
            }
        }

        const currentStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
        if (currentStatus) {
            this.isClosed = false;
            if (currentStatus === 'Closed' || currentStatus === 'Completed' || currentStatus === 'Accepted') {
                this.isClosed = true;
            }
        }
    }

    compareWithResponsibleworkers(userDetail: any){
        let activeMod = "";
        if (this._session.getItem('activeModuleRole') === 'CJAMS_SSA_FTDM_FACILITATOR') {
            activeMod = "FTDM Facilitator"; }
        else if (this._session.getItem('activeModuleRole') === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL') {
            activeMod = "Qualified Individual"; }
        else if (this._session.getItem('activeModuleRole') === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            activeMod = "FTDM/QI Supervisor"; }

        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const tempArray: any[] = [];
        let isReadonly = false;
        if(caseInfo && caseInfo.responsibleworkers){
            for (let i = 0; i < caseInfo.responsibleworkers.length; i++) {
                if(caseInfo.responsibleworkers[i].enddate == null && caseInfo.responsibleworkers[i].email === userDetail
                    && caseInfo?.responsibleworkers[i]?.teamname === activeMod){
                    tempArray.push(caseInfo.responsibleworkers[i]);
                }
            }
            if(tempArray.length !== 0){
                isReadonly=true;}
            else{isReadonly=false;}
        }
        return isReadonly;
    }

    setMinContactDate() {
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        var receivedDate, intakeRecDate, incidentDate;

        if (this.isIntakeMode()) {
            // For intake min contact date will be minimum of Intake recieved, Incident date
            receivedDate = this._dataStoreService.getData(IntakeStoreConstants.receivedDate);
            const an = this._dataStoreService.getData(IntakeStoreConstants.addNarrative);
            incidentDate = an.incidentdate;
        } else {
            // For case min contact date will be minimum of the three dates: Intake recieved, Incident date, Narrative updated date
            if (caseInfo) {
                receivedDate = caseInfo.da_receiveddate;
                intakeRecDate = caseInfo.da_intakedaterecieved;
                incidentDate = caseInfo.da_reporterincidentdate;
            }
        }
     
        var dates: any = [];
        if(receivedDate){
            dates.push(new Date(receivedDate));}
        if(intakeRecDate){
            dates.push(new Date(intakeRecDate));}
        if(incidentDate){
            dates.push(new Date(incidentDate));}
        this.minContactDate=new Date(Math.min.apply(null,dates));
    }

    setNotes(record: any) {
        this.selectedRecord = record;
        if (record && record.description) {
            this.selectedNotes = record.description;
        } else {
            this.selectedNotes = '';
        }

        if(record && record?.notedetails?.length > 0){
            record.notedetails.forEach((rowData: any) => {
                rowData.description = rowData.description.replace(/&nbsp;/g, ' ')
            })
        }
    }


    getFullName(person: any) {
        const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach((key: any) => {
          if(person && person.hasOwnProperty(key)){
          if ( (person[key] != null) && (person[key] !== 'null') && (person[key] !== '') ) {
            name = name + person[key] + ' ';
          }}
        });
        return name.trim();
      }
    
      getChildRoles(person: any) {
          let role = '';
          person.childroles.forEach((key: any) => {
            if ( key.typedescription) {
                role = role + key.typedescription + ' , ';
            }
          });
          return role.trim();
      }

    private formInitilize() {
        this.recordingForm = this.formBuilder.group(
            {
                progressnotetypeid: ['', Validators.required],
                progressnotesubtypeid: [null],
                contactdate: ['', Validators.required],
                locationname: [''],
                documentpropertiesid: [''],
                firstname: [''],
                lastname: [''],
                address1: [''],
                address2: '',
                city: [''],
                state: '',
                county: '',
                zipcode: [''],
                email: ['', ValidationService.mailFormat],
                phonenumber: [''],
                initiationindicator: ['', Validators.required],
                attemptindicator: ['', Validators.required],
                description: [{ value: '', disabled: false }, Validators.required],
                appendtitle: [''],
                starttime: [{ value: null, disabled: true }],
                endtime: [{ value: null, disabled: true }],
                intakeservicerequestactorid: [''],
                focuspersonintakeservicerequestactorid: ['', Validators.required],
                progressnotereasontypekey: ['', Validators.required],
                travelhours: ['', Validators.maxLength(3)],
                travelminutes: ['', Validators.maxLength(2)],
                durationhours: [{ value: null, disabled: true }, Validators.maxLength(3)],
                durationminutes: [{ value: null, disabled: true }, Validators.maxLength(2)],
                progressnotepurposetypekey: [null],
                progressnoteroletype: [null],
                progressnoteid: [null],
                others: null,
                mioptions : [''],
                delayreasons: [null]
            },
            { validators: this.checkTimeValidation }
        );

        this.courtForm = this.formBuilder.group({
            issuedesc: [''],
            safetydesc: [''],
            services_childdesc: [''],
            services_parentdesc: [''],
            permanencystepdesc: [''],
            placementdesc: [''],
            educationdesc: [''],
            healthdesc: [''],
            socialareadesc: [''],
            financialliteracydesc: [''],
            familyplanningdesc: [''],
            skillissuedesc: [''],
            transitionplandesc: ['']
        });

        this.updateAppend = this.formBuilder.group({
            appendtitle: ['', Validators.required]
        });

        this.searchCategoryForm = this.formBuilder.group(
            {
                draft: [''],
                type: [''],
                datefrom: [new Date(), Validators.required],
                dateto: [new Date(), Validators.required],
                contactdatefrom: [new Date(), Validators.required],
                contactdateto: [new Date(), Validators.required],
                progressnotereasontypekey: [''],
                note: [''],
                workerName: [''],
                insertedby: [''],
                sortBy: ['contactdate'],
                sortDir: ['desc'],
                recordingsubtype: [null],
                recordingtype: [null],
                intakeservicerequestactorids: [null]
            },
            {
                validators: [ValidationService.checkDateRange('starttime', 'endtime')]
            }
        );

        this.categoryForm = this.formBuilder.group({
            category: ['']
        });

        this.emailForm = this.formBuilder.group({
            email: ['', [ValidationService.mailFormat, Validators.required]]
        });

        this.commentForm = this.formBuilder.group({
            description: ['', [Validators.required]]
        });

        this.qualityForm = this.formBuilder.group({
            qualityofcaretochildtext: [''],
            adjustmentfostercaretext: [''],
            screeningfortheservicetext: [''],
            ischildgotoshool: ['']
        });

        this.recordingForm.get('progressnotereasontypekey')?.valueChanges.subscribe(() => {
            this.checkDelay();
        });

        this.recordingForm.get('contactdate')?.valueChanges.subscribe(() => {
            this.checkDelay();
        });

        this.recordingForm.get('progressnotetypeid')?.valueChanges.subscribe(() => {
            this.checkDelay();
        });

        this.recordingForm.get('starttime')?.valueChanges.subscribe(() => {
            this.checkDelay();
        });

        this.recordingForm.get('endtime')?.valueChanges.subscribe(() => {
            this.checkDelay();
        });

    }

    openAddendum() {
        $('#CommentDialog').modal('show');
        $(this.uploadattachmentpopupid).modal('hide');
        this.addContactNotesAudit('add-note-addendum', null);
    }

    addContactNotesAudit(key: any, refkeyid: any){
        let username;
        let refkey;
        const objectid = this.getCaseNumber();
        const objectType = this.getCurrentCaseType();
        this._authService.currentUser.subscribe((userInfo) => {
            username = userInfo.user.securityusersid;
        });
        if (key === 'open-contact-note' || key === 'add-contact-note' || key === 'leave-from-contact-note' || key === 'back-contact-note' || key === 'close-contact-note'){
            refkey = username;
        }  else if (key === 'edit-contact-note' || key === 'view-contact-note' || key === this.savecontactnotestr ){
            refkey = refkeyid;
        } else if (key === 'add-note-addendum' || key === this.downloadcontactnotestr) {
            refkey = refkeyid ? refkeyid : username;
        }
        const comment = {
            securityusersid: username,
            logtype: key,
            referenceid: refkey ? refkey : refkeyid,
            objectype: objectType,
            objectid: objectid,
            description: key
        };
        this._commonHttpService.create(comment, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddDetailedAudit).subscribe();

    }

    saveAddendum() {
        let username;
        let userid;
        this._authService.currentUser.subscribe((userInfo) => {
            username = userInfo.user.userprofile.displayname;
            userid = userInfo.user.securityusersid;
        });
        const comment = {
            progressnoteid: this.editRecord?.progressnoteid,
            description: this.commentForm.getRawValue().description,
            insertedby: userid,
            updatedby: userid,
            insertedon: new Date(),
            isaddendum: 1,
            displayname: username
        };
        this._commonHttpService.create(comment, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddComments).subscribe(
            (result) => {
                $('#CommentDialog').modal('hide');
                this.commentForm.reset();
                if (this.editRecord?.notedetails && this.editRecord?.notedetails.length) {
                    this.editRecord?.notedetails.push(comment);
                } else {
                    this.editRecord!.notedetails = [];
                    this.editRecord?.notedetails.push(comment);
                }
                this.sanatizeDescriptionDataFn(this.editRecord?.notedetails);
                this.editRecording(this.editRecord, 'Edit', 'draftEdit', false, false);
                if(result && result.progressnotedetailid) {
                    this.addContactNotesAudit(this.savenoteaddendumstr,result.progressnotedetailid);
                } else {
                    this.addContactNotesAudit(this.savenoteaddendumstr,null);
                }
            },
            (error) => {
                this.addContactNotesAudit(this.savenoteaddendumstr,null);
            }
        );
    }

    saveQualityCare() {
        const qualityCare = {
            progressnoteid: this.viewRecord.progressnoteid,
            qualityofcaretochildtext: this.qualityForm.getRawValue().qualityofcaretochildtext,
            screeningfortheservicetext: this.qualityForm.getRawValue().screeningfortheservicetext,
            adjustmentfostercaretext: this.qualityForm.getRawValue().adjustmentfostercaretext,
            ischildgotoshool: this.qualityForm.getRawValue().ischildgotoshool
        };
        this._commonHttpService.create(qualityCare, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddQualityCare).subscribe(
            (_result) => {
                this._alertService.success('Quality care data saved successfully!');
                $('#iframe-Quality-care').modal('hide');
                this.getPage(1);
            }
        );
    }

    addOtherPerson() {
        this.recordingForm.patchValue({
            others: ''
        });
        this.recordingForm.controls['intakeservicerequestactorid'].clearValidators();
        this.recordingForm.controls['intakeservicerequestactorid'].updateValueAndValidity();
        this.recordingForm.controls['others'].setValidators([Validators.required]);
        this.recordingForm.controls['others'].updateValueAndValidity();
        this.isotherPerson = true;
    }

    removeOtherPerson() {
        this.recordingForm.patchValue({
            others: null
        });
        this.recordingForm.controls['intakeservicerequestactorid'].setValidators([Validators.required]);
        this.recordingForm.controls['intakeservicerequestactorid'].updateValueAndValidity();
        this.recordingForm.controls['others'].clearValidators();
        this.recordingForm.controls['others'].updateValueAndValidity();
        this.isotherPerson = false;
    }

    // To be developed : We should have delcare a composit object but
    private setInitialFaceToFace(recording: any) {
        if (recording.recordingtype === 'Initialfacetoface') {
            this.initialFace = true;
        }
        if (recording && recording.contactparticipant && recording.contactparticipant.length) {
            this.recordingForm.patchValue({
                firstname: recording.contactparticipant[0].firstname,
                lastname: recording.contactparticipant[0].lastname,
                address1: recording.contactparticipant[0].address1,
                address2: recording.contactparticipant[0].address2,
                city: recording.contactparticipant[0].city,
                state: recording.contactparticipant[0].state,
                county: recording.contactparticipant[0].county,
                zipcode: recording.contactparticipant[0].zipcode,
                email: recording.contactparticipant[0].email,
                phonenumber: recording.contactparticipant[0].phonenumber,
            });
        }
        this.checkChangeDateValue(this.recordingForm.controls['contactdate'].value);
    }

    private getInvolvedPerson() {
        if (this.personRoles && this.personRoles.length === 0) {
            let isExpungementSuperUser= this._authService.isExpungementSuperUser();
            let url = '';
            if(isExpungementSuperUser=== 1) {
                url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
            } else {
                url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
            }
            const inputRequest = this.getRequestParam();
            this._commonHttpService
                .getPagedArrayList(
                    {
                        where: inputRequest,
                        page: 1,
                        limit: 100,
                        nolimit: true,
                        method: 'get'
                    },
                    url + '?filter'
                )
                .subscribe((itm) => {
                    if (itm.data) {
                        this.personRoles = [];
                        itm.data.forEach((list) => {
                            return this.personRoles.push({
                                intakeservicerequestactorid: list.roles ? list.roles[0].intakeservicerequestactorid : null,
                                ishousehold: list.ishousehold,
                                displayname: list.fullname,
                                personname: this.getFullName(list),
                                role: list.roles,
                                firstname: list.firstname,
                                lastname: list.lastname,
                                middlename: list.middlename,
                                personid: list.personid,
                                programarea : list.programarea,
                                hasActiveOOH : this.checkProgramAreaHasOOH(list?.programarea)
                            });
                        });
                    }
                    this.householdPeopleLoaded = true;
                    this.formInvolvedPersonsDropDown();

                });
        }
    }

    checkProgramAreaHasOOH(programAreas: any[]): boolean {
        if (!Array.isArray(programAreas)) {
            return false;
        }

        return programAreas.some((p: any) => p?.programkey === 'OOH');
    }
    

    getcollateral() {
        if (this.collateralPersons && this.collateralPersons.length === 0) {
            const request = {
                objectid: this.getCaseUuid(),
                objecttype: 'case'
            };
            this._commonHttpService.getArrayList(
                {
                    where: request,
                    method: 'get',
                    nolimit: true
                },
                'collateral/list?filter'
            ).subscribe(res => {
                if (res && res.length && res[0].getcollateraldetails && res[0].getcollateraldetails.length) {
                    this.collateralPersons = res[0].getcollateraldetails;
                }
                this.collateralsLoaded = true;
                this.formInvolvedPersonsDropDown();
            });
        }
    }

    formInvolvedPersonsDropDown() {
        this.involvedPersons = [];
        this.focusInvolvedPersons = [];
        this.personRoles.forEach(personRole => {
            this.involvedPersons.push({
                involvedPersonId: personRole.intakeservicerequestactorid,
                displayName: (personRole.displayname === null ? personRole.displayname : personRole.displayname.trim()),
                isCollateral: false,
                role: personRole.role,
                personid: personRole.personid,
                programarea: personRole.programarea, 
                hasActiveOOH: personRole.hasActiveOOH  
            });

            if(personRole['ishousehold'] === 1){
                this.focusInvolvedPersons.push({
                    involvedPersonId: personRole.intakeservicerequestactorid,
                    displayName: (personRole.displayname === null ? personRole.displayname : personRole.displayname.trim()),
                    isCollateral: false,
                    role: personRole.role,
                    firstname: personRole.firstname,
                    lastname: personRole.lastname,
                    middlename: personRole.middlename,
                    programarea: personRole.programarea,  
                    personid: personRole.personid
                });
            }
        });
        this.collateralPersons.forEach(collateralPerson => {
            this.involvedPersons.push({
                involvedPersonId: collateralPerson.collateralid,
                displayName: (collateralPerson.fullname===null ? collateralPerson.fullname : collateralPerson.fullname.trim()),
                isCollateral: true,
                role : collateralPerson.collateralroleconfig,
                personid: collateralPerson.collateralid,
            });
        });

        this.originalFocusInvolvedPersons = [...this.focusInvolvedPersons];
        this.originalInvolvedPersons = [...this.involvedPersons];

        if (this.isMotivationInterviewSelected) {
            this.applyMIFilter();
        }

        if(this.waitingForLoading && this.householdPeopleLoaded && this.collateralsLoaded){
            this.waitingForLoading = false;
            this.cancelRecording();
            $(this.recordingswaitingpopupid).modal('hide');
        }

        this.involvedPersons.sort(function(a,b){
            return a.displayName.localeCompare(b.displayName)});

        return true;
    }

    private applyMIFilter() {
        const miKeys = new Set(['FPSMI', 'CSMI', 'MI']);

        // Filter focusInvolvedPersons (Subject of contact dropdown)
        const miFilteredFocusPersons = this.originalFocusInvolvedPersons.filter(item =>
            Array.isArray(item.programarea) &&
            item.programarea.some((pa: any) => miKeys.has(pa.subprogramkey))
        );

         this.focusInvolvedPersons = miFilteredFocusPersons;

        // Filter involvedPersons (Involved Persons dropdown)
        // Exclude collaterals and keep only persons with MI subprogramkey
        const miFilteredInvolvedPersons = this.originalInvolvedPersons.filter(item =>
            !item.isCollateral &&
            Array.isArray(item.programarea) &&
            item.programarea.some((pa: any) => miKeys.has(pa.subprogramkey))
        );

         this.involvedPersons =   miFilteredInvolvedPersons;
    }

    getStateDropdown() {
        this.stateValuesDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                'States?filter'
            ).pipe(
                map(result => {
                    return result.map(
                        res =>
                            new DropdownModel({
                                text: res.statename,
                                value: res.stateid
                            })
                    );
                }));
    }
    getCountyDropdown() {
        this.CountyValuesDropdownItems$ = this._commonHttpService
            .create(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                'admin/county/countylist'
            ).pipe(
                map(result => {
                    return result.map((res: any) =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyid
                            })
                    );
                }));
    }

    getReasonForContact() {
        const responseData = this._commonHttpService.getSingle({}, 'Progressnotereasontypes?filter={"nolimit":true}').pipe(map((itm) => {
            return itm;
        }));
        responseData.subscribe(data => {
            this.reasonForContactResponse = data;
            this.reasonForContact = data;
        });
    }
    getReasonForContactBySubtype(id: string | number) {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW' },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetProgressNoteMiOptions + '?filter'
            ).subscribe((data) => {
                this.motivationalInterviewOptions = data;
            });
    }
    getPage(page: number) {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.recordSearch.progressnotereasontypekey = this.searchCategoryForm.getRawValue().progressnotereasontypekey ?
            this.searchCategoryForm.getRawValue().progressnotereasontypekey.join() : '';
        ObjectUtils.removeEmptyProperties(this.recordSearch);

        this.handleIfIntakeservicerequestactoridsFn();

        if (this.recordSearch.note) {
            this.recordSearch.note = this.recordSearch.note.split('\'').join('');
        }
        this.recordSearch.isExpungementSuperUser = isExpungementSuperUser;
        this.recordSearch.iscaseexpunged = iscaseexpunged;
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize50,
                    where:  this.recordSearch,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.id + '?data'
            )
            .subscribe((result) => {
                this.recording = result.data;
                this.handleRecordingDataIfContactparticipantFn();

                this.recording.forEach(objrecord => {
                    this.checkFocusPersonAndPersonnameFn(objrecord);
                });

                if (this.recording) {
                    this.recording.forEach((record) => {
                        this.getEndTimeFromTotalTime(record);
                        record.duration = this.calculateContactDurationForViewRecord(record);
                    });
                }
                this.getInsertedUser(this.id);
                this.notesListCheck = this.recording.find(item => item.progressnoteid === this.retrynotesid);
                if (this.notesListCheck && this.retrynotesid) {
                    this.editRecording(this.notesListCheck, 'Edit', 'draftEdit', true, true);
                    this.retrynotesid = null;
                }
                this.pageNumber = page;
                if (page === 1) {
                    this.totalRecords = result.data.length ? result.data[0].totalcount : 0;
                }
                this.cdr.detectChanges()
            });
    }
    // Assosiated to getPage method
    private checkFocusPersonAndPersonnameFn(objrecord: RecordingNotes) {
        const focusperson: any = [];
        if (objrecord['focusperson'] && objrecord['focusperson']['focuspersonjson'] && Array.isArray(objrecord['focusperson']['focuspersonjson'])) {
            objrecord['focusperson'] = [...objrecord['focusperson']['focuspersonjson']];
            objrecord['focusperson'].forEach((objpart: any) => {
                const index = focusperson.findIndex((temp: { participanttypekey: string; collateralid: any; contactparticipantid: any; }) => temp.participanttypekey === 'COLLATERAL' &&
                    temp.collateralid === objpart.collateralid && temp.contactparticipantid === objpart.contactparticipantid);
                if (index > -1) {
                    focusperson[index].typedescription = focusperson[index].typedescription + ', ' + objpart.typedescription;
                }
                else {
                    focusperson.push(objpart);
                }
            });
        }
        objrecord['focusperson'] = [...focusperson];

        objrecord['focusperson'] && objrecord['focusperson'].map((res: { [x: string]: any; intakeservicerequestactorid: any; }) => {

            const tempPerson = this.personRoles.find((person) => {
                return person['intakeservicerequestactorid'] === res.intakeservicerequestactorid;
            });

            if (tempPerson && tempPerson['personname'] !== null && tempPerson['personname'] !== undefined && tempPerson['personname'] !== '') {
                res['personname'] = tempPerson['personname'];
            }
        });
    }
    // Assosiated to getPage method
    private handleRecordingDataIfContactparticipantFn() {
        this.recording.forEach(objrecord => {
            const contactparticpant: ContactParticipant[] = [];
            if (objrecord.contactparticipant && Array.isArray(objrecord.contactparticipant)) {
                objrecord.contactparticipant.forEach(objpart => {
                    const index = contactparticpant.findIndex(temp => temp.participanttypekey === 'COLLATERAL' &&
                        temp.collateralid === objpart.collateralid && temp.contactparticipantid === objpart.contactparticipantid);
                    if (index > -1) {
                        contactparticpant[index].typedescription = contactparticpant[index].typedescription + ', ' + objpart.typedescription;
                    }
                    else {
                        contactparticpant.push(objpart);
                    }
                });
            }
            objrecord.contactparticipant = [...contactparticpant];
        });
    }
    // Assosiated to getPage method
    private handleIfIntakeservicerequestactoridsFn() {
        if (this.recordSearch.intakeservicerequestactorids && this.recordSearch.intakeservicerequestactorids.length) {
            this.updateRecordSearch();
        }
    }

    getInsertedUser(id: any) {
        this._commonHttpService.getArrayList({
            where: {
                entitytypeid: id
            },
            method: 'get'
        }, 'admin/progressnote/getCaseWorkerList?filter').subscribe(response => {
            if (response && response.length > 0) {
                this.insertedByDetails = response;
            }
        });
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageSubject$.next(this.paginationInfo.pageNumber);
    }

    changeSelectedActionType(event: MatRadioChange) {


        if (event.value === 'SORT') {

            //clear fields if filter not used
            if(!this.isfilterUsed){
                this.resetSearchForm();
                this.resetAllSearchFlags();
            }
            this.sortBy = true;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.recordDate = false;
            this.contactDate = false;
            this.notetext = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;
            this.isfilterUsed = false;
        } else if (event.value === 'SEARCH') {
            this.resetSearchForm();
            this.resetAllSearchFlags();
            this.sortBy = false;
            this.searchWorkerName = false;
            this.notetext = true;
            this.contactpurpose = false;
            this.recordDate = false;
            this.contactDate = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;
        } else {
            // Filter by default
            this.resetSearchForm();
            this.resetAllSearchFlags();
            this.isfilterUsed=true;
        }
    }

    resetSelectedActionType() {
        this.selectedActionType = null;
        this.categoryForm.controls['category'].reset();
        this.minDate=new Date();
        this.maxDate =new Date();

        // Get all the default results
        this.resetSearchForm();
        this.resetAllSearchFlags();
        this.getPage(1);
    }

    resetAllSearchFlags() {
        this.sortBy = false;
        this.notetext = false;
        this.searchWorkerName = false;
        this.contactpurpose = false;
        this.recordDate = false;
        this.recordingCategory = false;
        this.contactDate = false;
        this.searchContactType = false;
        this.searchLocation = false;
        this.personContacted = false;
    }

    resetSearchForm() {
        this.isSerachResultFound = true;
        this.searchCategoryForm.reset();
        this.recordSearch = Object.assign({});
        this.searchCategoryForm.patchValue({ draft: '', type: '' });
        this.displaySearch();
    }

    getData() {
        return {
            draft: 'Draft',
            type: 'Type',
            datefrom: 'Data From',
            dateto: ' Data To',
            contactdatefrom: 'Contact Data From',
            contactdateto: 'Contact Data To',
            progressnotereasontypekey: 'Contact Purpose',
            note: 'Note',
            workerName: 'WorkerName',
            insertedby: 'Worker Name',
            recordingsubtype: 'Contact Location',
            recordingtype: 'Type Of Contact',
            intakeservicerequestactorids: ' Person Contacted',
            sortBy: 'Sort By',
            sortDir: 'Sort Direction'
        };
    }

    displaySearch() {
        this.searchParameter = this.searchCategoryForm.getRawValue();
        var x;
        const dataMap: any = this.getData();
        this.searchParamArr = [];
        for (x in this.searchParameter) {
            const data = dataMap[x] + ':' + this.setTransFromData(x, this.searchParameter[x]);
            if (this.searchParameter[x]) {
                this.searchParamArr.push(data);
            }

        }
        this.searchparams = this.searchParamArr.join(',');
    }
    setTransFromData(x: string, value: string | any[]) {
        if (x === 'contactdatefrom') {
            return value;
        }
        if (x === 'contactdateto') {
            return value;
        }
        const values = '';
        if (x === 'progressnotereasontypekey' && value && value.length) {
            return this.returnProgressnotereasontypekeyFn(value, values);
        }
        if (x === 'insertedby') {
            return this.returnIfInsertedByFn(value, values);
        }
        if (x === 'recordingsubtype') {
            return this.returnIfRecordingsubtypeFn(value, values);
        }
        if (x === 'recordingtype') {
            return this.returnIfRecordingtypeFn(value, values);
        }
        if (x === 'intakeservicerequestactorids' && value && value.length) {
            return this.returnIfIntakeservicerequestactoridsFn(value, values);
        }

        return value;
    }
    // Assosiated to setTransFromData function
    private returnIfIntakeservicerequestactoridsFn(value: any, values: string) {
        for (const key in value) {
            if (this.personRoles) {
                const data = this.personRoles.filter((item: { intakeservicerequestactorid: any; }) => item.intakeservicerequestactorid === value[key]);
                if (data && data.length) {
                    values = values + ',' + data[0].displayname;
                }
            }

        }
        return values;
    }
    // Assosiated to setTransFromData function
    private returnIfRecordingtypeFn(value: any, values: string) {
        const progressnote = this.recordType.filter((item: { progressnotetypeid: any; }) => item.progressnotetypeid === value);
        if (progressnote && progressnote.length) {
            values = progressnote[0].description;
        }
        return values;
    }
    // Assosiated to setTransFromData function
    private returnIfRecordingsubtypeFn(value: any, values: string) {
        const progressnote = this.recordingSubTypeDropDown.filter((item: { progressnotetypeid: any; }) => item.progressnotetypeid === value);
        if (progressnote && progressnote.length) {
            values = progressnote[0].description;
        }
        return values;
    }
    // Assosiated to setTransFromData function
    private returnProgressnotereasontypekeyFn(value: any, values: string) {
        for (const key in value) {
            const arr = this.reasonForContact.filter((item: { progressnotereasontypekey: any; }) => item.progressnotereasontypekey === value[key]);
            if (arr && arr.length) {
                values = values + ',' + arr[0].typedescription;
            }
        }
        return values;
    }
    // Assosiated to setTransFromData function
    private returnIfInsertedByFn(value: any, values: string) {
        if (this.insertedByDetails && this.insertedByDetails.length > 0) {
            const progressnote = this.insertedByDetails.filter((item) => item.userid === value);
            if (progressnote && progressnote.length) {
                values = progressnote[0].fullname;
            }
        }
        return values;
    }

    getKey(value: any) {
        var x;
        const getDataFnData: any = this.getData();
        for (x in getDataFnData) {
            if (getDataFnData[x] === value) {
                return x;
            }
        }
    }
    clearSearchParam(param: any) {
        var key = param.split(':')[0];
        key = this.getKey(key);
        this.searchCategoryForm.controls[key].setValue('');
        this.searchRecording(this.searchCategoryForm.value);
    }

    changeCategory(event: any) {

        // @Simar - This is scary code, refactor this whole logic if possible -- eventually! hopefully!
        // Just moving the Sort & Search into changeSelectedActionType based on radio button selection
        // All the remaining drop down values in category will work for filering as before
        if (event.value === 'Sortby') { // Removed this value from category dropdown

        } else if (event.value === 'CaseWorkerName') {
            this.sortBy = false;
            this.searchWorkerName = true;
            this.contactpurpose = false;
            this.recordDate = false;
            this.contactDate = false;
            this.notetext = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;


        } else if (event.value === 'Contactpurpose') {
            this.sortBy = false;
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = true;
            this.recordDate = false;
            this.contactDate = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;
        } else if (event.value === 'RecordingCategory') {
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.recordingCategory = true;
            this.recordDate = false;
            this.contactDate = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;
        } else if (event.value === 'RecordingDate') {
            this.sortBy = false;
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.recordDate = true;
            this.contactDate = false;
            this.recordingCategory = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;
        } else if (event.value === 'ContactDate') {
            this.sortBy = false;
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.contactDate = true;
            this.recordDate = false;
            this.recordingCategory = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;
        } else if (event.value === 'ContactLocation') {
            this.sortBy = false;
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.contactDate = false;
            this.recordDate = false;
            this.recordingCategory = false;
            this.searchContactType = false;
            this.searchLocation = true;
            this.personContacted = false;
        } else if (event.value === 'TypeofContact') {
            this.sortBy = false;
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.contactDate = false;
            this.recordDate = false;
            this.recordingCategory = false;
            this.searchContactType = true;
            this.searchLocation = false;
            this.personContacted = false;
        } else if (event.value === 'PersonContacted') {
            this.sortBy = false;
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.contactDate = false;
            this.recordDate = false;
            this.recordingCategory = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = true;
            this.formInvolvedPersonsDropDown();
        } else {
            this.sortBy = false;
            this.notetext = false;
            this.searchWorkerName = false;
            this.contactpurpose = false;
            this.recordDate = false;
            this.recordingCategory = false;
            this.contactDate = false;
            this.searchContactType = false;
            this.searchLocation = false;
            this.personContacted = false;
            this.getPage(1);
        }
    }
    recordingSubType(progressnotetypeid: string, recordingtype?: string) {
        const progressNoteTypeKey = progressnotetypeid.split('~');

        if (progressNoteTypeKey[1] === 'Court approved Trial Home Visit') {
            this.isCourtDetails = true;
        } else {
            this.isCourtDetails = false;
        }
        if (progressNoteTypeKey[1] === 'Initialfacetoface' || progressNoteTypeKey[1] === this.facetoface || progressNoteTypeKey[1] === 'Hand deliverd'
            || progressNoteTypeKey[1] === this.weeklyvisits || progressNoteTypeKey[1] === 'Walk-in' ||
            recordingtype === 'Initialfacetoface' || recordingtype === this.facetoface
            || recordingtype === this.weeklyvisits || recordingtype === 'Walk-in' || recordingtype === 'Hand deliverd'|| this.isMotivationInterviewSelected) {
            this.recordingForm.get('starttime')?.setValidators([Validators.required]);
            this.recordingForm.get('starttime')?.updateValueAndValidity({ onlySelf: true, emitEvent: false });
            this.recordingForm.get('endtime')?.setValidators([Validators.required]);
            this.recordingForm.get('endtime')?.updateValueAndValidity({ onlySelf: true, emitEvent: false });
            //Location
            this.recordingForm.get('progressnotesubtypeid')?.setValidators([Validators.required]);
            this.recordingForm.get('progressnotesubtypeid')?.updateValueAndValidity({ onlySelf: true, emitEvent: false });
            this.startEndTimeValidator = true;
        } else {
            this.startEndTimeValidator = false;
            this.recordingForm.get('starttime')?.clearValidators();
            this.recordingForm.get('starttime')?.updateValueAndValidity({ onlySelf: true, emitEvent: false });
            this.recordingForm.controls['endtime'].clearValidators();
            this.recordingForm.controls['endtime'].updateValueAndValidity({ emitEvent: false });
            //Location
            this.recordingForm.controls['progressnotesubtypeid'].clearValidators();
            this.recordingForm.controls['progressnotesubtypeid'].updateValueAndValidity({ emitEvent: false });
        }

        // @Simar
        // This does not make sense to make an API call for Contact locations every single time Contact Type changes
        // So making this call just once at the init to polulate this dropdown
        // the dropdown can be disabled as needed, no need to make the get call again

        if (progressNoteTypeKey[1] !== 'Initialfacetoface') {
            this.initialFace = false;
        } else {
            this.initialFace = true;
        }
    }
    searchRecording(modal: SearchRecording) {
        this.displaySearch();
        if (modal.contactdateto) {
            modal.contactdateto = moment(modal.contactdateto)
                .format();
        }
        if (modal.contactdatefrom) {
            modal.contactdatefrom = moment(modal.contactdatefrom)
                .format();
        }
        if (modal.dateto) {
            modal.dateto = moment(modal.dateto)
                .format();
        }
        if (modal.datefrom) {
            modal.datefrom = moment(modal.datefrom)
                .format();
        }
        this.recordSearch = modal;
        this.paginationInfo.pageNumber=1;
        this.getPage(1);
    }
    personRoleTypeChange(model: string) {
        if (model === 'IP') {
            this.recordingForm.controls['intakeservicerequestactorid'].setValidators([Validators.required]);
            this.recordingForm.controls['intakeservicerequestactorid'].updateValueAndValidity();
        } else {
            this.recordingForm.controls['intakeservicerequestactorid'].clearValidators();
            this.recordingForm.controls['intakeservicerequestactorid'].updateValueAndValidity();
        }
    }

    changePersonInvolved(item: any) {
        this.personinvolved = item.map((res: any) => {
            return {
                subtancekey: res,
                others: ''
            };
        });
    }

    personRoleList(model: string | any[]) {
        if (this.involvedPersons && this.involvedPersons.length === 0) {
            this.getInvolvedPerson();
            this.getcollateral();
            this.formInvolvedPersonsDropDown();
        }
        if (model) {
            const removalReasonItems = this.involvedPersons.filter((item) => {
                if (model.includes(item.involvedPersonId)) {
                    return item;
                }
            });
            this.changePersonInvolved(model);
            this.personNameDescription = removalReasonItems.map((res) => {
                return res.displayName;
            });
            this.multipleRoles = '';
            const progressNoteRoleType = this.returnProgressNoteRoleTypeDataFn(model);
            this.progressNoteRoleType = progressNoteRoleType;

            this.isActiveOOH = false;
            if(removalReasonItems.some(item => item.hasActiveOOH)){
                this.isActiveOOH = true;
            }
            this.checkDelay();
        }
    }
    // Assosiated to personRoleList method
    private returnProgressNoteRoleTypeDataFn(model: any) {
        return model.map((res: any) => {
            if (this.multipleRoles === '') {
                this.multipleRoles = this.multipleRoles + '' + res;
            } else {
                this.multipleRoles = this.multipleRoles + ', ' + res;
            }
            const selectedPerson = this.involvedPersons ? this.involvedPersons.find(item => item.involvedPersonId === res) : null;

            const selectedPersonValue = selectedPerson ? this.returnCollateralDataFn(selectedPerson) : null;
            return {
                intakeservicerequestactorid: res, participanttypekey: selectedPersonValue
            };
        });
    }
    // Assosiated to personRoleList method
    private returnCollateralDataFn(selectedPerson: any) {
        return (selectedPerson.isCollateral ? 'COLLATERAL' : 'IP');
    }

    focusPersonRoleList(model: any) {
        if (this.focusInvolvedPersons && this.focusInvolvedPersons.length === 0) {
            this.getInvolvedPerson();
            this.getcollateral();
            this.formInvolvedPersonsDropDown();
        }
        if (model) {
            const removalReasonItems = this.focusInvolvedPersons.filter((item) => {     //  NOSONAR     // This function has less than 3 lines of identical code.
                if (model.includes(item.involvedPersonId)) {
                    return item;
                }
            });
            this.changePersonInvolved(model);
            this.focurPersonNameDescription = removalReasonItems.map((res) => {
                return res.displayName;
            });

            this.multipleRoles = '';
            const progressNoteRoleType = this.returnFocusInvolvedPersonsFn(model);
            this.focusProgressNoteRoleType = progressNoteRoleType;

            const selectedContactPurpose = this.recordingForm.get('progressnotereasontypekey')?.value;
            if (selectedContactPurpose && selectedContactPurpose.includes('MDICT')){ //CDM-44474
                this.addPersonDataForMedicationPopup(progressNoteRoleType);
            }
        }
    }
    // Assosiated to focusPersonRoleList method
    private returnFocusInvolvedPersonsFn(model: any) {
        return model.map((res: any) => {
            if (this.multipleRoles === '') {
                this.multipleRoles = this.multipleRoles + '' + res;
            } else {
                this.multipleRoles = this.multipleRoles + ', ' + res;
            }
            const selectedPerson = this.focusInvolvedPersons ? this.focusInvolvedPersons.find(item => item.involvedPersonId === res) : null;
            const selectedPersonValue = (selectedPerson.isCollateral ? 'COLLATERAL' : 'IP') ;
            return {
                ...selectedPerson, intakeservicerequestactorid: res, participanttypekey: selectedPerson ? selectedPersonValue : null
            };
        });
    }

    checkTimeValidation(group: FormGroup): ValidationErrors | null {

        return null;
    }

    getContactTotalTime(recording: any) {
        return (recording.durationhours||recording.durationminutes) ? (recording.durationhours + ':' + recording.durationminutes) : null;
    }

    checkVpnConnection() {
        return new Promise((resolve, reject) => {
            return this.http.request('get', window.location.origin, {}).subscribe(
                (_response) => {
                    resolve(true)
                }, (err) => {
                    if (err.status === 200) { // Response status will be 304 and status key in the response will be 200
                        resolve(true)
                    } else {
                        resolve(false)
                    }
                });
        })
    }

    validateNotesforReopenServiceCase(model: any) {
        return new Promise((resolve, reject) => {
            return  this._commonHttpService.create(model, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.ValidateContactNotes).subscribe(
                (result) => {
                    resolve(result[0]);
                }, (err) => {
                    resolve(
                        { message: 'Contact date selected is not within the program assignment dates of the selected persons involved. Please select a valid contact date.',
                          success: false})
                });
        })
    }

    // 'recording' variable is basically just the raw value of recordingForm
    async saveRecording(recording: any, saveType: string, isAutoSave?: boolean | undefined, isNavigate?: boolean | undefined) {
        this.disableSave = true;
        this.savedisable = false;
        this.checkmandatory = true;

        if(!this.handleResultInSaveRecordingFn()) {
            return;
        }

        if(!this.handleAutoSaveMsgInSaveRecordingFn(isAutoSave)) {
            return;
        }

        let validateContactNotes: any = { message: 'success', success: true }

        validateContactNotes = await this.handleIfIntakeservicerequestactoridFn(recording, validateContactNotes);

        if (!validateContactNotes.success) {
            this.errormessage = validateContactNotes.message;
            $(this.contactsaveerrorpopupid).modal('show');
            this.savedisable = false;
            this.disableSave = false;
            return;
        }

        if (this.checkParticipantsRole(saveType, recording)) {
            this.handleCheckParticipantsRoleFn(recording, saveType, isAutoSave, isNavigate);
        } else {
            this.savedisable = false;
        }
    }
    // Assosiated to saveRecording method
    private handleCheckParticipantsRoleFn(recording: any, saveType: string, isAutoSave: any, isNavigate: any) {
        if (recording.contactdate) {
            recording.contactdate = moment(recording.contactdate).format();
        }
        // The matinput time is text so need to turn it to timestamp
        if (recording.starttime != null && recording.endtime != null) {
            recording.starttime = this.convertMatinputTimeToTimestamp(recording.contactdate, recording.starttime);
            recording.endtime = this.convertMatinputTimeToTimestamp(recording.contactdate, recording.endtime);
        }

        const progressNoteTypeKey = this.recordingForm.get('progressnotetypeid')?.value.split('~');
        recording.progressnotetypeid = progressNoteTypeKey[0];
        if (recording.attemptindicator !== null) {
            recording.attemptindicator = recording.attemptindicator === 'yes' ? true : false;
        }
        if (recording.initiationindicator !== null) {
            recording.initiationindicator = recording.initiationindicator === 'yes' ? true : false;
        }

        this.addNotes = Object.assign(
            this.handleAddNotesPayloadFn(saveType, recording, isAutoSave),
            recording
        );

        if (!this.recordingForm.value.documentpropertiesid) {
            delete this.addNotes.documentpropertiesid;
        }
        if (this.editRecord) {
            this.addNotes.notedetails = this.editRecord.notedetails;
        }

        if (this.addNotes) {
            this.addNotes.description = this.addNotes.description.replace(/‘/g, "'").replace(/’/g, "'").toString();
        }
        this.handleGlobalPopupAndAddRecording(isAutoSave,isNavigate);

    }

    // Assosiated to saveRecording method
    private handleGlobalPopupAndAddRecording(isAutoSave: any, isNavigate: any) : void {
        const selectedContactPurpose = this.recordingForm.get('progressnotereasontypekey')?.value;
        if (selectedContactPurpose.includes('MDICT') && this.tempData.length > 0) {
                this._globalPopupService.setMedicalPrescribedData(this.tempData, true);
                setTimeout(() => {
                    this.handleAddRecordingApiFn(isAutoSave, isNavigate);
                }, 5000);
        } else {
            this.handleAddRecordingApiFn(isAutoSave, isNavigate);
        }
    }


    // Assosiated to saveRecording method
    private handleAddRecordingApiFn(isAutoSave: any, isNavigate: any) {
        this._commonHttpService.create(this.addNotes, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddRecordingUrl).subscribe(
            (result) => {
                if (result && result.progressnoteid) {
                    this._alertService.success(!isAutoSave ? 'Contact details saved successfully!'
                        : 'Contact auto saved successfully! Please continue typing and click \'SAVE\' to complete.');
                    if (isNavigate) {
                        this.checkPageNavigationFlag = true;
                        this._route.navigate([this.navigationUrl]);
                        return;
                    }
                    if (!isAutoSave) {
                        this.addContactNotesAudit(this.savecontactnotestr, result.progressnoteid);
                    }
                    this.savedisable = true;
                    this.lastUpdatedTime = moment(result.updatedon).format('MMM Do YY, h:mm:ss a');
                    this.currentDescription = result.description;
                    this.autoSaveFlag = isAutoSave ? true : false;

                    let message = `Contact Notes last saved successfully at ` + this.lastUpdatedTime;
                    if (this.autoSaveFlag) {
                        this.addContactNotesAudit('autosave-contact-note', result.progressnoteid);
                        message += `. Please continue typing and click 'SAVE' button to complete.`;
                    }
                    this.toastr.clear();
                    this.toastr.success(message, '', { enableHtml: true, tapToDismiss: false, disableTimeOut: false, positionClass: 'toast-bottom-full-width', timeOut: 3000 });

                    this.disableSave = false;
                    this.recordingForm.patchValue({
                        progressnoteid: result.progressnoteid
                    });
                    this.viewEdit = 'Edit';
                    this.handleIfNotAutoSaveFn(isAutoSave);
                    if(this.isServiceCase) {
                        this.getrohsenuntimelycriteria(result.progressnoteid);
                    }
                    if (this.isUploadClicked) {
                        this.isUploadClicked = false;
                        this._route.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment/attachment-upload']);
                    }

                } else {
                    this._alertService.error('Contact notes was not saved successfully. Please try again later.');
                    this.disableSave = false;
                    this.addContactNotesAudit(this.savecontactnotestr, null);
                }
            },
            (error) => {
                this.savedisable = false;
                this.disableSave = false;
                this.addContactNotesAudit(this.savecontactnotestr, null);
                this._alertService.error('Contact notes was not saved successfully. Please try again later.');
            }
        );
    }

    getrohsenuntimelycriteria(progressnoteid: any) {      
        this._commonHttpService
        .getArrayList(
            {
                where: {
                    servicecaseid  : this.id,
                    progressnoteid: progressnoteid,
                    objecttype : 'progressnote'
                },
                method: 'get'
            },
            NewUrlConfig.EndPoint.Intake.Rohsenuntimelycriteria + '?filter' /* Separate API invoked for SEN Untimely Report */
        ).subscribe(data => {
            if(data && data.length > 0) {
                this.globalPopupRef.showSenUntimelyPopupAlert('Contact',data);
            }            
        });
    }

    // Assosiated to saveRecording method
    private handleIfNotAutoSaveFn(isAutoSave: any) {
        if (!isAutoSave) {
            this.autoSaveInitiated = false;
            if (this.autoSaveIntervalTimer) {
                clearInterval(this.autoSaveIntervalTimer);
                this.autoSaveIntervalTimer = null;
            }
            this.initiateAutoSave(true); // after Manual save, auto trigger should be reset. so,stopping and restarting timmer.


            this.recordingForm.markAsPristine();
            $('#notes-manual-save-msg').modal('show');
        }
    }
    // Assosiated to saveRecording method
    private handleAddNotesPayloadFn(saveType: string, recording: any, isAutoSave: any) {
        return {
            contactparticipant: this.progressNoteRoleType,
            focusperson: this.focusProgressNoteRoleType,
            entitytypeid: this.id,
            savemode: saveType === 'SAVE' ? 1 : 0,
            contacttrialvisit: this.courtForm.value,
            entitytype: this.entityType,
            stafftype: 1,
            instantresults: 1,
            contactstatus: recording.attemptindicator === true ? false : true,
            drugscreen: false,
            description: recording.detail,
            traveltime: recording.travelhours ? recording.travelhours + ':' + recording.travelminutes : '',
            totaltime: this.getContactTotalTime(recording),
            uploadedfile: this.uploadedDocuments,
            isAutoSave
        };
    }
    // Assosiated to saveRecording method
    private async handleIfIntakeservicerequestactoridFn(recording: any, validateContactNotes: any) {
        if (this.isServiceCase && recording.intakeservicerequestactorid && recording.intakeservicerequestactorid.length > 0) {

            const personids: any = [];
            recording.intakeservicerequestactorid.map((element: any) => {
                this.involvedPersons.forEach(f => {
                    if (f.involvedPersonId === element) {
                        personids.push(f.personid);
                    }
                });
            });

            const modal = {
                contactdate: recording.contactdate,
                servicecaseid: this.id,
                personids: personids
            };
            validateContactNotes = await this.validateNotesforReopenServiceCase(modal);
        }
        return validateContactNotes;
    }

    // Assosiated to saveRecording method
    private async handleResultInSaveRecordingFn() {
        const result = await this.checkVpnConnection();
        if (!result) {
            this._alertService.warn('Please check your internet and VPN connection');
            this.errormessage = 'Please check our internet and VPN connection';
            $(this.contactsaveerrorpopupid).modal('show');
            this.savedisable = false;
            this.disableSave = false;
            return false;
        }
        return true;
    }
    // Assosiated to saveRecording method
    private handleAutoSaveMsgInSaveRecordingFn(isAutoSave: any) {

        const autoSaveMsg = 'for the auto save feature to work';
        const genericMsg = 'to proceed further';

        if (this.recordingForm.controls['progressnotereasontypekey'].invalid) {
            this.errormessage = `Contact Purpose field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        if (this.recordingForm.controls['progressnotetypeid'].invalid) {
            this.errormessage = `Contact Type field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }

        if (!this.handleAutoSaveMsgInSaveRecordingCond1Fn(isAutoSave, autoSaveMsg, genericMsg)) {
            return false;
        }

        if (this.recordingForm.controls['initiationindicator'].invalid) {
            this.errormessage = `Contact was initiated/received field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }

        if (!this.handleAutoSaveMsgInSaveRecordingCond2Fn(isAutoSave, autoSaveMsg, genericMsg)) {
            return false;
        }

        return true;
    }
    // Assosiated to saveRecording method
    private handleAutoSaveMsgInSaveRecordingCond1Fn(isAutoSave: any, autoSaveMsg: any, genericMsg: any) {

        if (this.recordingForm.controls['contactdate'].invalid) {
            this.errormessage = `Contact Date field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        if (this.recordingForm.controls['starttime'].invalid) {
            this.errormessage = `Contact Start Time field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        if (this.recordingForm.controls['endtime'].invalid) {
            this.errormessage = `Contact End Time field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        if (this.recordingForm.controls['progressnotesubtypeid'].invalid) {
            this.errormessage = `Contact Location field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        return true;
    }
    // Assosiated to saveRecording method
    private handleAutoSaveMsgInSaveRecordingCond2Fn(isAutoSave: any, autoSaveMsg: any, genericMsg: any) {
        if (this.recordingForm.controls['attemptindicator'].invalid) {
            this.errormessage = `Contact was Attempted/Completed field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        if (this.recordingForm.controls['focuspersonintakeservicerequestactorid'].invalid) {
            this.errormessage = `Subject of the contact field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        if (this.recordingForm.controls['description'].invalid) {
            this.errormessage = `Notes field is mandatory ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            return this.reusableContactPopupFn();
        }
        if (!this.recordingForm.get('others')?.value &&
            !(this.recordingForm.get('intakeservicerequestactorid')?.value && this.recordingForm.get('intakeservicerequestactorid')?.value.length > 0)) {
            this.errormessage = `Atleast one Involved Person or Other Person should be added for any ` +
                `type of contacts ${isAutoSave ? autoSaveMsg : genericMsg}.Please fill the required field`;
            this._alertService.error('');
            return this.reusableContactPopupFn();
        }
        return true;
    }
    // Assosiated to saveRecording method
    private reusableContactPopupFn() {
        $(this.contactsaveerrorpopupid).modal('show');
        this.savedisable = false;
        this.disableSave = false;
        return false;
    }

    returnList(event: any) {
        if (event) {
            this.addContactNotesAudit('close-contact-note', null);
        } else {
            this.addContactNotesAudit('back-contact-note', null);
        }
        this.isDelay = false;
        this.currentDescription = null;
        this.autoSaveError = false;
        this.isAddEdit = false;
        this.autoSaveInitiated = false;
        this.toastr.clear();
        if (this.autoSaveIntervalTimer) {
            clearInterval(this.autoSaveIntervalTimer);
            this.autoSaveIntervalTimer = null;
        }
        this.cancelRecording();
        this.recordingForm.reset({}, { emitEvent: false });
        this.recordingForm.controls['starttime'].disable({ emitEvent: false });
        this.recordingForm.controls['endtime'].disable({ emitEvent: false });
        this.isMotivationInterviewSelected = false;
        this.getPage(1);
    }

    downloadContact(recording: any) {
        this.addContactNotesAudit(this.downloadcontactnotestr, recording.progressnoteid);
        const modal = {
            count: -1,
            where: {
                documenttemplatekey: ['contactpdf'],
                entitytype: this.entityType,
                caseNumber: this.daNumber,
                entitytypeid: this.id,
                progressnoteid: recording.progressnoteid
            },
            method: 'post'
        };
        this._commonHttpService.getSingle(modal, 'evaluationdocument/generateintakedocument').subscribe((data) => {
            if (data) {
                window.open(data.data[0].documentpath, '_blank');
            }
        });
    }

     viewRecording(recording: any) {
        this.viewRecord = recording;
        
        const reasonKey = recording.progressnotereasontypekey;
        let reasons: string[] = [];

        if (Array.isArray(reasonKey)) {
            reasons = reasonKey;
        } else if (typeof reasonKey === 'string' && reasonKey.length > 0) {
            reasons = reasonKey.split(',').map((x: string) => x.trim());
        }
    
        if(reasons.includes('MI')){
            this.isMotivationInterviewSelected = true;
            this.getReasonForContactBySubtype('5471');
        }
        this.addContactNotesAudit('view-contact-note', recording.progressnoteid);
        this.updateAppend.disable();
        this._commonHttpService.getPagedArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetRecordingDetailUrl + '/' + recording.progressnoteid)
            .subscribe((result) => {
                result.data[0]['progressnoteroletypeview'] = result.data[0]['progressnoteroletype'].map((item: any) => item.contactroletypekey);
                this.recordingDetail = result.data[0];
                if (this.recordingDetail?.['focusperson']) {
                    this.recordingDetail['focusperson'] = this.recordingDetail['focusperson']['focuspersonjson'];
                    this.recordingDetail['focusperson'] && this.recordingDetail['focusperson'].map((res: { [x: string]: any; intakeservicerequestactorid: any; }) => {   // NOSONAR // Less then 3 lines of identical code.

                        const tempPerson = this.personRoles.find((person) => {
                            return person['intakeservicerequestactorid'] === res.intakeservicerequestactorid;
                        });

                        if (tempPerson?.['personname'] !== null && tempPerson['personname'] !== undefined && tempPerson['personname'] !== '') {
                            res['personname'] = tempPerson['personname'];
                        }
                    });
                }
                if (this.recordingDetail?.progressnotedetail?.length) {
                    this.sanatizeDescriptionDataFn(this.recordingDetail?.progressnotedetail);
                    let notes = this.recordingDetail.progressnotedetail;
                    let filteredNotes: any[] = [];
                    notes = _.orderBy(notes, ['effectivedate'], ['desc']);
                    filteredNotes = notes.filter(item => item.isaddendum === 1);
                    if (filteredNotes.length && !filteredNotes[0]) {
                        filteredNotes = [];
                    }
                    if (notes.find(item => item.isaddendum === 0)) {
                        filteredNotes.push(notes.find(item => item.isaddendum === 0));
                    }
                    filteredNotes = _.orderBy(filteredNotes, ['effectivedate'], ['asc']);
                    this.recordingDetail.progressnotedetail = filteredNotes;
                    this.recordingDetail.uploadedfile = this.recordingDetail.uploadedfile === null ? this.viewRecord.uploadedfile : this.recordingDetail.uploadedfile;
                }
            });
        //
        this.calculatedContactDuration = this.calculateContactDurationForViewRecord(recording);
        this.calculatedTravelDuration = this.calculateTravelDurationForViewRecord(recording);
    }

    private sanatizeDescriptionDataFn(descriptionData: any) {
        descriptionData?.forEach((rowData: any) => {
            rowData.description = rowData.description.replaceAll(/&nbsp;/g, ' ');
        });
    }

    qualityRecording(recording: any) {
        
        this.isDate7DaysOld(recording.recordingdate);
        this.isDate24hoursOld(recording.recordingdate);
        this.viewQualityCare = !(this.isDate24Check);
        this.viewRecord = recording;
        this.qualityForm.patchValue(this.viewRecord);

    }

    downloadFile(s3bucketpathname: any) {

        // 4200
        s3bucketpathname = s3bucketpathname.replace(/,/g, '');
        this.downldSrcURL = '/api' + s3bucketpathname;

        window.open(this.downldSrcURL, '_blank');
    }

    closePopovers(element: any) {
        element.hide();
    }

    downloadContactsLogRreport() {
        const req = {
            username: this.userRole.user.userprofile.fullname,
            usertitle: this.userRole.role.description,
            currentdate: this.currentDate,
            localdepartment: '',
            unit: '',
            name: '',
            danumber: this.daNumber,
            casetype: this.caseType,
            intakeserviceid: this.id,
            searchjson: this.recordSearch
        };

        const payload = {
            method: 'post',
            count: -1,
            page: 1,
            limit: 20,
            where: req,
            documntkey: [
                'contactslogreport'
            ]
        };

        this._commonHttpService.create(payload, 'admin/progressnote/getcontactslogreport').subscribe(
            response => {
                setTimeout(() => window.open(response.data.documentpath), 2000);
            });
    }

    editRecording(recording: any, viewEdit: string, typeOfEdit: string, enableToaster: boolean, editTrigger: boolean) {
        if (editTrigger) {
            this.addContactNotesAudit('edit-contact-note', recording.progressnoteid);
        }
        if (enableToaster) {
            const message = `Contact Notes last saved date & time : ` + moment(recording.updatedon).format('MMM Do YY, h:mm:ss a');
            this.toastr.clear();
            this.toastr.success(message, '', { enableHtml: true, tapToDismiss: false, disableTimeOut: true, positionClass: 'toast-bottom-full-width' });
        }
        const reasonKey = recording.progressnotereasontypekey;
        let reasons: string[] = [];

        if (Array.isArray(reasonKey)) {
            reasons = reasonKey;
        } else if (typeof reasonKey === 'string' && reasonKey.length > 0) {
            reasons = reasonKey.split(',').map((x: string) => x.trim());
        }
    
        if(reasons.includes('MI')){
            this.isMotivationInterviewSelected = true;
            this.applyMIFilter();
            this.enableMotivationalInterview();
        }

        this.isDate7DaysOld(recording.recordingdate);
        this.isDate24hoursOld(recording.recordingdate);
        this.currentDescription = recording.detail;
        this.isAddEdit = true;
        this.recording = [];
        this.autoSaveInitiated = false;
        this.initiateAutoSave(viewEdit === 'Edit' && this.isDate24Check);
        this.startEndTimeValidator = false;
        this.uploadedDocuments = [];
        this.uploadedDocuments = recording.uploadedfile && recording.uploadedfile.data ? recording.uploadedfile.data : [];
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.PRO_NOTE_ID, recording.prognotetypeid);

        // @Simar - this variable is only used for VIEWING the record in readonly mode.
        // It is referred in the modal --> myModal-recordings-view-readonly
        // Not sure why it's called editRecord, but moving the view logic to viewRecording()
        this.editRecord = recording;
        this.sanatizeDescriptionDataFn(this.editRecord?.notedetails);
        this.sourceEdited = this.getSourceData(this.editRecord);

        this._dataStoreService.setData(CASE_STORE_CONSTANTS.CONTACT_NOTES_SAVE_ENABLED, (this.isDateCheck && !this.isDate24Check));


        this.viewEdit = viewEdit;

        this.updateAppend.enable();


        if (typeOfEdit === 'draftEdit') {
            this.handleDraftEditFn(recording);
        } else {
            this.recordingForm.reset();
        }

        // Patch the start and end time
        /**
         * Removing 'Z' at end of the Date Object to produce Start and End time as per the response
         */


        this.handleToPatchStarttimeAndEndtime(recording);



        this.computeContactDuration();

        this.handleContactstatusFn(recording);
        this.handleInitiateindFn(recording);
        this.setInitialFaceToFace(recording);
    }
    // Assosiated to editRecording method
    private handleInitiateindFn(recording: any) {
        if (recording.initiateind !== null) {
            this.recordingForm.patchValue({
                initiationindicator: recording.initiationindicator === true ? 'yes' : 'no'
            });
            this.initiateText = false;
        } else {
            this.initiateText = true;
        }
    }
    // Assosiated to editRecording method
    private handleContactstatusFn(recording: any) {
        if (recording.contactstatus !== null) {
            this.recordingForm.patchValue({
                attemptindicator: recording.contactstatus === false ? 'yes' : 'no'
            });
            this.attempText = false;
        } else {
            this.attempText = true;
        }
    }
    // Assosiated to editRecording method
    private handleToPatchStarttimeAndEndtime(recording: any) {
        if (recording.starttime || recording.endtime) {
            // Note:- DO NOT CHANGE THIS START TIME /END TIME CODE WITHOUT PROPER APPROVAL
            // D-16611(DM)/D-16612(APP)-Start Time and End Time issue
            // 1) Timezone has been defaulted to 'EST' at server level
            // 2) Changing start/end time here , will force the browser to default to UTC (4 hrs ahead of EST)
            this.recordingForm.patchValue({
                starttime: moment(recording.starttime).format('HH:mm:ss'),
                endtime: moment(recording.endtime).format('HH:mm:ss'),
            },
                { emitEvent: false }
            );
        }
    }
    // Assosiated to editRecording method
    private handleDraftEditFn(recording: any) {
        const address = this.returnAddressDataFn(recording);
        const param = Object.assign(
            {
                progressnotereasontypekey: [],
                description: recording.detail,
                travelhours: recording.traveltime ? recording.traveltime.split(':')[0] : '',
                travelminutes: recording.traveltime ? recording.traveltime.split(':')[1] : '',
                durationhours: recording.traveltime ? recording.traveltime.split(':')[0] : '',
                durationminutes: recording.traveltime ? recording.traveltime.split(':')[1] : ''
            },
            recording,
            address && address.length > 0 && address[0] ? address[0] : ''
        );
        param.progressnotereasontypekey = recording.progressnotereasontypekey.split(',');
        if(param.progressnotereasontypekey.includes('MI')){
            this.isMotivationInterviewSelected = true;
            this.getReasonForContactBySubtype('5471');
            param.mioptions = recording?.mioptions?.split(',');
        }
        this.recordingForm.patchValue(param);
        if (recording.progressnotetypeid) {
            this.recordingForm.patchValue({
                progressnotetypeid: recording.progressnotetypeid + '~' + recording.recordingtype,
                description: this.sanitizeNotes(recording.description)
            });
        }
        if (recording.progressnotecontacttrialvisit && recording.progressnotecontacttrialvisit.length) {
            this.courtForm.patchValue(recording.progressnotecontacttrialvisit[0]);
        }
        const serviceReqId: any[] = [];
        const focusServiceReqId: any[] = [];
        this.personNameDescription = [];
        this.focurPersonNameDescription = [];
        this.handleContactparticipantMapFn(recording, serviceReqId);

        this.handleFocuspersonMapFn(recording, focusServiceReqId);

        this.focusProgressNoteRoleType = recording.focusperson;


        this.recordingForm.controls['intakeservicerequestactorid'].patchValue(serviceReqId);
        this.recordingForm.controls['focuspersonintakeservicerequestactorid'].patchValue(focusServiceReqId);
        if (recording.progressnotesubtypeid) {
            this.recordingSubType(recording.progressnotesubtypeid);
        }

        if (recording.recordingtype === 'Court approved Trial Home Visit') {
            this.isCourtDetails = true;
        } else {
            this.isCourtDetails = false;
        }
    }
    // Assosiated to editRecording method
    private handleFocuspersonMapFn(recording: any, focusServiceReqId: any[]) {
        recording.focusperson && recording.focusperson.map((res: any) => {

            const tempPerson = this.personRoles.find((person) => {
                return person['intakeservicerequestactorid'] === res.intakeservicerequestactorid;
            });

            if (tempPerson && tempPerson['personname'] !== null && tempPerson['personname'] !== undefined && tempPerson['personname'] !== '') {
                this.focurPersonNameDescription.push(tempPerson['personname']);
            }
            focusServiceReqId.push(res.intakeservicerequestactorid);
        });
    }
    // Assosiated to editRecording method
    private handleContactparticipantMapFn(recording: any, serviceReqId: any[]) {
        recording.contactparticipant && recording.contactparticipant.map((res: any) => {
            let temp = '';
            if (res.middlename !== null && res.middlename !== undefined && res.middlename !== '') {
                temp = res.firstname + ' ' + res.middlename + ' ' + res.lastname;
            } else {
                temp = res.firstname + ' ' + res.lastname;
            }
            if (temp !== null && temp !== undefined && temp !== '') {
                this.personNameDescription.push(temp);
            }
            serviceReqId.push(res.intakeservicerequestactorid);
            this.personRoleList(serviceReqId);
        });
    }
    // Assosiated to editRecording method
    private returnAddressDataFn(recording: any) {
        return recording.contactparticipant && recording.contactparticipant.map((res: any) => {
            if (res.participanttypekey === 'Oth') {
                return {
                    firstname: res.firstname,
                    lastname: res.lastname,
                    address1: res.address1,
                    address2: res.address2,
                    city: res.city,
                    state: res.state,
                    zipcode: res.zipcode,
                    email: res.email,
                    phonenumber: res.phonenumber
                };
            }
        });
    }

    changeMinit(val: Event, name: any) {
        const model = (val.target as HTMLInputElement).value;
        const minit = Number(model);
        if (minit && minit > 59) {
            this._alertService.warn('Please enter valid time');
            if (name === 'duration') {
                this.recordingForm.controls['durationminutes'].reset();
                this.setEndData();
            } else if (name === 'travel') {
                this.recordingForm.controls['travelminutes'].reset();
            }
        } else {
            if (name === 'duration') {
                this.setEndData();
            }
        }
    }

    getEndTimeFromTotalTime(recording: any){
        if (recording.old_id && recording.starttime) {
            this.recordingForm.patchValue({ starttime: moment(recording.starttime).format('HH:mm:ss') });
            var startdate = moment(recording.starttime);
            if (recording.totaltime) {
                var totaltime = recording.totaltime.split(":");
                if (totaltime && Array.isArray(totaltime) && totaltime.length > 1) {
                    recording.endtime = moment(startdate).add(totaltime[0], 'hours').add(totaltime[1], 'minutes');
                    return recording.endtime;
                }
            }
        }
    }


    getStartTime() {
        const val = this.recordingForm.getRawValue().starttime;
        if (val === '' || val === null) {
            this.recordingForm.controls['durationhours'].reset();
            this.recordingForm.controls['durationminutes'].reset();
        }
        const progressNoteTypeKey = this.recordingForm.get('progressnotetypeid')?.value?.split('~');
        if (!(progressNoteTypeKey[1] === 'Initialfacetoface' || progressNoteTypeKey[1] === this.facetoface
            || progressNoteTypeKey[1] === this.weeklyvisits || progressNoteTypeKey[1] === 'Walk-in' || this.isMotivationInterviewSelected)) {
            this.recordingForm.controls['endtime'].setValue(val);
        }
        this.computeContactDurationFun();
        if(this.isMotivationInterviewSelected){
            if(this.recordingForm.getRawValue().endtime){
                this.getEndTime();
            }
        }
    }

    getEndTime() {
        const start = this.recordingForm.getRawValue().starttime;
        const end = this.recordingForm.getRawValue().endtime;
      
        if (!start) {
          this._alertService.warn('Please enter start time');
          this.recordingForm.patchValue({
            endtime: null
          });
          return;
        }
      
        if (start > end) {
          this._alertService.warn('End time should be greater than the start time');
          this.recordingForm.patchValue({
            endtime: null
          });
          return;
        }
      
        if(this.recordingForm.controls['progressnotereasontypekey'].value.includes('MI')){
        const diff = this.calculateContactDurationForMIRecord(this.recordingForm);
      
        if (!diff) {
          this._alertService.warn('Duration must be at least 15 minutes when Motivation interview options are selected');
          this.recordingForm.patchValue({
            endtime: null
          });
          return;
        }
    }
      
        if (end === '' || end === null) {
          this.recordingForm.controls['durationhours'].reset();
          this.recordingForm.controls['durationminutes'].reset();
        }
      
        this.computeContactDurationFun();
      }
    setEndData() {
        const minit = this.recordingForm.controls['durationminutes'].value;
        const hour = this.recordingForm.controls['durationhours'].value;
        const calminits = (hour * 60) + Number(minit);
        const start_date = moment(this.recordingForm.value.starttime, 'HH:mm:ss');
        if (minit && hour && start_date) {
            const enddate = start_date.add(moment.duration(calminits, 'minutes'));
            this.recordingForm.controls['endtime'].setValue(enddate);
        }
    }


    addNew() {
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.CONTACT_NOTES_SAVE_ENABLED, false);
        this.addContactNotesAudit('add-contact-note', null);
        if (!this.householdPeopleLoaded || !this.collateralsLoaded) {
            $(this.recordingswaitingpopupid).modal('show');
            this.waitingForLoading = true;
            this.recording = [];

        }
        else {
            this.cancelRecording();
            $(this.recordingswaitingpopupid).modal('hide');
            this.recording = [];
        }
        this.isAddEdit = true;
        this.autoSaveError = true;
        this.autoSaveInitiated = false;
        this.recordingForm.patchValue({ description: '' });
        this.recordingForm.patchValue({ description: null });
        this.initiateAutoSave(true);
    }
    
    initiateAutoSave(enableFlag: any) {
        if(enableFlag && !this.autoSaveInitiated){
            this.autoSaveIntervalTimer = setInterval(() => {
                if (this.recordingForm.dirty && this.recordingForm.valid && (this.currentDescription !== this.recordingForm.getRawValue().description)) {
                    this.saveRecording(this.recordingForm.getRawValue(), 'DRAFT', true);
                } else if (this.autoSaveError && this.recordingForm.controls['description'].dirty && !this.recordingForm.valid) {
                    this._alertService.error('Please enter all mandatory fields before entering notes to enable auto save.');
                    this.savedisable = false;
                    this.disableSave = false;
                    return;
                }
            }, config.AutoSaveTimer);
            this._dataStoreService.setData('autoSaveTimerid', this.autoSaveIntervalTimer);
            this.autoSaveInitiated = true;
        }
    }

    cancelRecording() {
        this.currentDescription = null;
        this.autoSaveError = false;
        this.autoSaveInitiated = false;
        if (this.autoSaveIntervalTimer) {
            clearInterval(this.autoSaveIntervalTimer);
            this.autoSaveIntervalTimer = null;
        }
        this.waitingForLoading = false;
        this.editRecord = null;
        this.sourceEdited = null;
        this.isDate24Check = true;
        this.uploadedDocuments = [];
        this.savedisable = false;
        this.formInvolvedPersonsDropDown();
        $(this.recordingspopupid).modal('hide');
        $('#myModal-recordings-edit').modal('hide');
        $(this.uploadattachmentpopupid).modal('hide');
        this._speechRecognitionService.destroySpeechObject();
        this.recordingForm.reset({}, { emitEvent: false });
        this.recordingForm.controls['starttime'].disable({ emitEvent: false });
        this.recordingForm.controls['endtime'].disable({ emitEvent: false });
        this.courtForm.reset();
        this.progressNoteActor = [];
        this.updateAppend.reset();
        this.duration = '';
        this.isSerachResultFound = false;
        this.isCourtDetails = false;
        this.viewEdit = 'Add';
        this.progressNoteRoleType = [];
        this.focusProgressNoteRoleType = [];
    }

    close() {
        this.waitingForLoading = false;
        this.editRecord = null;
        this.sourceEdited = null;
        this.isDate24Check = true;
        this.uploadedDocuments = [];
        this.formInvolvedPersonsDropDown();
        $(this.recordingspopupid).modal('hide');
        $('#myModal-recordings-edit').modal('hide');
        $(this.uploadattachmentpopupid).modal('hide');
        this._speechRecognitionService.destroySpeechObject();
        this.recordingForm.reset({}, { emitEvent: false });
        this.recordingForm.controls['starttime'].disable({ emitEvent: false });
        this.recordingForm.controls['endtime'].disable({ emitEvent: false });
        this.courtForm.reset();
        this.progressNoteActor = [];
        this.updateAppend.reset();
        this.duration = '';
        this.isSerachResultFound = false;
        this.isCourtDetails = false;
        this.viewEdit = 'Add';
        this.progressNoteRoleType = [];
        this.focusProgressNoteRoleType = [];
        this.resetSelectedActionType();
        this.isAddEdit = false;
    }

    private getContactLocationsDropDown() {
        // The API expects an id that is not used for filtering at all (use Face-to-face 786495b2-c779-4cc4-b812-6a8439bfa96e if needed)
        // So passng an empty value for prognotetypeid to get locations as in reality lacation values always seem the same list
        this._commonHttpService.getArrayList({},
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.ListProgressSubTypeUrl + '?prognotetypeid=' + ''
        ).subscribe(response => {
            if (response && Array.isArray(response) && response.length) {
                this.recordingSubTypeDropDown = response;
            }
        });
    }

    private recordingDropDown() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.ListProgressTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true
                }),
                'Contactroletypes' + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { objecttypekey: 'CPT' },
                    order: 'displayorder',
                    nolimit: true,
                    method: 'get'
                }, 'Participanttypes' + '?filter'
            )/*,
                // The API expects an id that is not used for filtering at all (use Face-to-face 786495b2-c779-4cc4-b812-6a8439bfa96e if needed)
                // So passng an empty value for prognotetypeid to get locations as in reality lacation values always seem the same list
               */
        ]).pipe(
            map((result) => {
                return {
                    recordingType: result[0],
                    contactRoles: result[1],
                    participantType: result[2]
                };
            }),
            share());
        this.recordingType$ = source.pipe(pluck('recordingType'));
        this.contactRoles$ = source.pipe(pluck('contactRoles'));
        this.participantType$ = source.pipe(pluck('participantType'));
        // Not sure why this was named recordingsubtype, when its actually just contact locations list
        // this.recordingSubTypeDropDown$ = source.pluck('contactLocations');

        this.recordingType$.subscribe((res) => {
            this.recordType = res;
        });

    }
    private attachmentDropdown() {
        const inputreq = {
            objectid: this.isServiceCase ? null : this.id,
            servicecaseid: this.isServiceCase ? this.id : null,
            objecttypekey: this.isServiceCase ? 'Servicecase' : 'ServiceRequest',
            page: 1,
            limit: 10
        };
        this.attachmentGrid$ = this._commonHttpService.getArrayList(
            new PaginationRequest({
                nolimit: true,
                method: 'get',
                where: inputreq,
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter'
        );
    }
    checkInitialFaceToFace() {
        let isInitialFTF: RecordingNotes[] = [];
        {
            const result = this.recording;
            isInitialFTF = result.filter((res) => res.recordingtype === 'Initialfacetoface');
            this.recordingType$.subscribe((res) => {
                const progressnote = res.filter((item) => item.progressnotetypekey === 'Initialfacetoface');
                if (!isInitialFTF.length && progressnote.length && this.userInfo.role.teamtypekey === 'CW') {
                    this.initialFace = true;
                    this.recordingForm.get('progressnotesubtypeid')?.enable();
                    this.isCourtDetails = false;
                    this.recordingForm.patchValue({
                        progressnotetypeid: progressnote[0].progressnotetypeid + '~' + progressnote[0].progressnotetypekey
                    });
                    this._alertService.error('Initial Face to Face is Mandatory');
                }
            });
        }
    }
    checkParticipantsRole(saveType: any, recording: any) {
        const progressNoteTypeKey = this.recordingForm.get('progressnotetypeid')?.value.split('~');

        if (progressNoteTypeKey[1] === 'Initialfacetoface' && saveType === 'SAVE' && recording.attemptindicator && recording.attemptindicator === 'no') {
            const avPersonRoles = [];

            this.personRoles.forEach((result) => {
                if (result.role) {
                    const avrole = result.role.filter((res: { intakeservicerequestpersontypekey: string; }) => res.intakeservicerequestpersontypekey === 'AV' || res.intakeservicerequestpersontypekey === 'CHILD');
                    if (avrole.length) {
                        avPersonRoles.push(avrole[0]);
                    }
                }

            });
            if (avPersonRoles.length) {
                return true;
            } else {
                this._alertService.error('Please select atleast one alleged victim or child.');
                return false;
            }
        } else {
            return true;
        }
    }

    ngOnDestroy() {
        this.editor.destroy();
        const timerid = this._dataStoreService.getData('autoSaveTimerid');
        this.toastr.clear();
        clearInterval(timerid);
        this.addContactNotesAudit('leave-from-contact-note', null);
        this._dataStoreService.setData('autoSaveTimerid', null);
        this._speechRecognitionService.destroySpeechObject();
        this.pageSubject$.unsubscribe();
    }

    activateSpeechToText(): void {
        this.recognizing = true;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                // listener
                (value) => {
                    const speechData = value;
                    const currentData = this.recordingForm.get('description')?.value;
                    const finalData = [currentData, speechData].join(' ');
                    this.recordingForm.patchValue({ description: finalData });

                },
                // errror
                (err) => {
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

    async downloadPdf() {
        // No content to add or call
    }

    convertImageToPdf() {
        this.pdfFiles.forEach((pdfFile) => {
            let doc: any = null;
            doc = new jsPDF();


            const width = doc.internal.pageSize.getWidth() - 10;
            const heigth = doc.internal.pageSize.getHeight() - 10;
            pdfFile.images.forEach((image, index) => {

                doc.addImage(image, 'JPEG', 3, 5, width, heigth);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
        this.pdfFiles = [];

    }


    startDateChanged(investigationForm: any) {
        const empForm = investigationForm.getRawValue();
        this.minDate = new Date(empForm.contactdatefrom);
    }

    endDateChanged(investigationForm: any) {
        const empForm = investigationForm.getRawValue();
        this.maxDate = new Date(empForm.contactdateto);
    }

    redirectToUpload() {
        this.isUploadClicked = true;
        this.saveRecording(this.recordingForm.value, 'SAVE');
    }
    getContactPurpose(purpose: any) {
        let result = '';
        if (Array.isArray(purpose)) {
            result = this.handleIfPurposeIsArrayFn(purpose, result);
            return result;
        } else if (purpose && purpose.indexOf(',') !== -1) {
            result = this.handleIfPurposeIndexGreaterThanZeroFn(purpose, result);
            return result;
        } else {
            const reason = this.reasonForContact.find(item => purpose === item.progressnotereasontypekey);
            if (reason) {
                result = result + reason.typedescription;
            }
            return result;
        }
    }

    getMiOptions(options?: string): string {
        if (!options) return '';
      
        const list = options.split(',').map((x: string) => x.trim());
      
        return list
          .map((element: string) => {
            const reason = this.motivationalInterviewOptions
              .find(item => item.ref_key === element);
            return reason?.description;
          })
          .filter(Boolean)
          .join(',');
      }
    // Assosiated to getContactPurpose method
    private handleIfPurposeIndexGreaterThanZeroFn(purpose: any, result: string) {
        let list = purpose.indexOf(',') !== -1 ? purpose.split(',') : purpose;
        list = (Array.isArray(list)) ? list : [];
        list.forEach((element: any, index: any) => {
            const reason = this.reasonForContact.find(item => element === item.progressnotereasontypekey);
            if (reason) {
                result = (index < (list.length) && index > 0) ? (result + ',' + reason.typedescription) : (result + reason.typedescription);
            }
        });
        return result;
    }
    // Assosiated to getContactPurpose method
    private handleIfPurposeIsArrayFn(purpose: any[], result: string) {
        purpose.forEach((element, index) => {
            const reason = this.reasonForContact.find(item => element === item.progressnotereasontypekey);
            if (reason) {
                result = (index < (purpose.length) && index > 0) ? (result + ',' + reason.typedescription) : (result + reason.typedescription);
            }
        });
        return result;
    }

    sendEmail() {
        const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        if (this.emailForm.valid) {
            const request = {
                email: this.emailForm.getRawValue().email,
                caseNumber: caseID,
                objectid: this.id,
                objecttype: this.getEntityType(),
                body: document.getElementById('contactEmailData')?.innerHTML
            };
            this._commonHttpService.create(request, 'admin/progressnote/sendemailcontact').subscribe(
                (result) => {
                    this._alertService.success('Email Sent successfully!');
                    this.emailForm.reset();
                    $('#iframe-Send-Email').modal('hide');

                }
            );
        } else {
            this._alertService.error('Please enter valid email address!');
        }
    }
    getCasePlanDataByLogType(referenceId: any, logType: any) {
        return this._commonHttpService.getArrayList(
            {
                where: {
                    activeflag: '1',
                    referenceid: referenceId,
                    logType: logType
                },
                method: 'get',
                nolimit: true
            },
            'auditlog/list?filter');
    }

    getHist(prognotetypeid: any) {
        this.histData = [];
        this.autoSavedRecordsExist = false;
        this.getCasePlanDataByLogType(prognotetypeid, 'PNOTE')
            .subscribe(
                (response) => {
                    if (response.length > 0) {
                        for (let element of response) {
                            if (element && element.insertedby !== "00000000-0000-0000-0000-000000000000") {
                                element.metadata.displayname = element.displayname;
                                element.metadata.insertedon = element.insertedon;
                                element.metadata.contactType = this.getContactType(element.metadata.progressnotetypeid);
                                element.metadata.purposeString = this.getContactPurpose(element.metadata.progressnotereasontypekey);
                                element.metadata.calculatedTravelDuration = this.calculateTravelDurationForViewRecord(element.metadata);
                                element.metadata.recordingsubtype = element.contactdetails && element.contactdetails.length
                                    ? element.contactdetails[0].recordingsubtype : '';
                                this.histData.push(element.metadata);
                            }
                            else {
                                this.autoSavedRecordsExist = true;
                            }
                        }
                        this.cdr.detectChanges();
                    }
                }
            );
    }

    getContactType(progressnotetypeid: any) {
        let result;
        if (this.recordType) {
            const progressnote = this.recordType.filter((item: { progressnotetypeid: any; }) => item.progressnotetypeid === progressnotetypeid);
            if (progressnote && progressnote.length) {
                result = progressnote[0].description;
            }
        }
        return result;
    }
    getLocationType(locationname: any) {
        let result;

        if (this.recordingSubTypeDropDown) {
            const progressnote = this.recordingSubTypeDropDown.filter((item: any) => item.progressnotesubtypeid === locationname);
            if (progressnote && progressnote.length) {
                result = progressnote[0].description;
            }
        }
        return result;
    }
    getPersonName(intakeservicerequestactorid: string) {
        const person = this.personRoles.find(p => p.intakeservicerequestactorid === intakeservicerequestactorid);
        if (person) {
            return person.personname;
        }
    }

    getDataDiffdays(recordingdate: any, days: any) {

        const now = moment(new Date()); // todays date
        const end = this.addWeekdays(recordingdate, days); // adding 5 days to recording date
        if (moment(recordingdate).isSameOrBefore(now) && moment(end).isAfter(now, 'minute')) {
            return true;
        } else {
            return false;
        }

    }

    get24HoursDiff(recordingdate: any) {
        return this.getDataDiffdays(recordingdate, 1);
    }

    getDataDiff5days(recordingdate: any) {
        return this.getDataDiffdays(recordingdate, 5); // Checks if today is recordingdate plus 5 days excluding weekends.[Check out addWeekdays()]
    }


    isDate24hoursOld(recordingdate: any) {
        this.isDate24Check = this.get24HoursDiff(recordingdate);
    }



    isDate7DaysOld(recordingdate: any) {
        this.isDateCheck = this.getDataDiff5days(recordingdate);
    }

    addWeekdays(date: any, days: any) {
        date = moment(date); // clone
        while (days > 0) {
            date = date.add(1, 'days');
            // decrease "days" only if it's a weekday.
            if (date.isoWeekday() !== 6 && date.isoWeekday() !== 7) {
                days -= 1;
            }
        }
        return date;
    }

    getRequestParam() {
        let inputRequest;
        const caseID = this.getCaseUuid();
        this.source = this.getCurrentCaseType();
        this.caseType = this.getCurrentCaseType();
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        if (this.isServiceCaseData()) {
            inputRequest = {
                objectid: caseID,
                objecttypekey: 'servicecase'
            };
        } else if (this.isIntakeMode()) {
            inputRequest = {
                intakenumber: this.getIntakeNumber(),
                'isExpungementSuperUser': isExpungementSuperUser,
                'iscaseexpunged': iscaseexpunged
            };

        } else {
            inputRequest = {
                intakeserviceid: caseID,
                'isExpungementSuperUser': isExpungementSuperUser,
                'iscaseexpunged': iscaseexpunged
            };
        }
        
        return inputRequest;
    }


    getCaseNumber() {
        const daNumber = this.route?.snapshot?.parent?.parent?.parent?.parent?.parent?.params['daNumber'];
        if (!daNumber) {
            const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
            return (caseInfo) ? caseInfo.da_number : null;
        }
        return daNumber;
    }

    getCaseUuid() {
        let caseID = this.route?.snapshot?.parent?.parent?.parent?.parent?.parent?.params['id'];
        if (!caseID) {
            caseID = this.getIntakeNumber();
        }
        return caseID;
    }
    isAdoptionCase() {
        if (this._session.getItem(CASE_STORE_CONSTANTS.CASE_TYPE) === AppConstants.CASE_TYPE.ADOPTION_CASE) {
            return true;
        }
        const dsds = this._dataStoreService.getData('dsdsActionsSummary');
        if (dsds && dsds.adoptioncasenumber != null) {
            return true;
        }
        return false;
    }
    isServiceCaseData() {
        return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    }

    isIntakeMode() {
        return this.getIntakeNumber() ? true : false;
    }

    getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
            this.intakeNumber = intakeStore.number
            return intakeStore.number;
        } else {
            return null;
        }
    }
    getCurrentCaseType() {
        if (this.isServiceCaseData()) {
            return 'Service Case';
        } else if (this.isIntakeMode()) {
            return 'Intake';
        } else if (this.isAdoptionCase()) {
            return 'Adoption Case';
        } else {
            return 'CPS';
        }
    }

    getEntityType() {
        let entitytype = '';
        if (this.isIntakeMode()) {
            entitytype = 'intake';
        } else if (this.isServiceCaseData()) {
            entitytype = 'servicecase';
        } else if (this.isAdoptionCase()) {
            entitytype = 'adoption';
        } else {
            entitytype = 'intakeservicerequest';
        }
        return entitytype;
    }

    /**
     * Contact date time related stuff
     * @Simar: Redoing entirely how contact data and time works
     */
    validateTimeFields(): boolean {
        const recordingForm = this.recordingForm.getRawValue();
        if (!recordingForm.contactdate) {
            this.timeValidationAlert('Please enter contact date.');
            return false;
        } else if (this.startEndTimeValidator && !recordingForm.starttime) {
            this.timeValidationAlert('Please enter start time.');
            return false;
        } else if (this.startEndTimeValidator && !recordingForm.endtime &&
            this.recordingForm.controls['endtime'].dirty) {
            // need this dirty check on end date so that don't trigger alert messages even before user has had chance to enter value
            this.timeValidationAlert('Please enter end time.');
            return false;
        }
        return true;
    }

    timeValidationAlert(message: string) {
        this._alertService.error(message);
    }

    setupTimeChangeSubscribers() {
        this.recordingForm.controls['endtime'].valueChanges
            .subscribe(form => {
                this.computeContactDurationFun();
            });
        this.recordingForm.controls['starttime'].valueChanges
            .subscribe(form => {
                this.computeContactDurationFun();
            });
    }

    computeContactDurationFun() {
        if (this.validateTimeFields()) {
            this.computeContactDuration();
        }
    }

    _keyUpcontactEndTime(event: any) {
        const startTimeD = this.recordingForm.getRawValue().starttime;
        const endTimeD = this.recordingForm.getRawValue().endtime;

        if (startTimeD > endTimeD) {
            this.timeValidationAlert('Start Time must be before End Time!');
            this.dateValidation = true;
        } else {
            this.dateValidation = false;
        }
    }

    computeContactDuration() {
        const startTime = moment(moment(this.recordingForm.getRawValue().contactdate).format(this.dtformat) + ' ' + this.recordingForm.getRawValue().starttime);
        const endTime = moment(moment(this.recordingForm.getRawValue().contactdate).format(this.dtformat) + ' ' + this.recordingForm.getRawValue().endtime);
        const now = new Date();
        if (startTime.isAfter(now)) {
            this.timeValidationAlert('Future time is not allowed!');
            this.dateValidation = true;
            return;
        }
        if (endTime.isAfter(now)) {
            this.timeValidationAlert('Future time is not allowed!');
            this.dateValidation = true;
            return;

        }
        else {
            const computedDuration: any = moment.duration(endTime.diff(startTime));

            if (computedDuration['_data'] && this.recordingForm.getRawValue().starttime && this.recordingForm.getRawValue().endtime) {
                this.recordingForm.controls['durationhours'].patchValue((computedDuration['_data'].hours));
                this.recordingForm.controls['durationminutes'].patchValue((computedDuration['_data'].minutes));
            }
            this.dateValidation = false;
        }
        this.dateValidation = false;
    }

    calculateContactDurationForViewRecord(recording: any) {
        const _startTime = moment(`${moment(recording.contactdate).format(this.dtformat)} ${moment(recording.starttime).format('HH:mm:ss')}`,`${this.dtformat} HH:mm:ss`);
        const _endTime = moment(`${moment(recording.contactdate).format(this.dtformat)} ${moment(recording.endtime).format('HH:mm:ss')}`,`${this.dtformat} HH:mm:ss`);

        const computedDuration: any = moment.duration(_endTime.diff(_startTime));
        if (computedDuration['_data']) {
            return computedDuration['_data'].hours + ' Hr(s) ' + computedDuration['_data'].minutes + ' Min(s)';
        }
        return '';
    }

    calculateTravelDurationForViewRecord(recording: any) {
        // @Simar: I honestly don't understand why the Travel Time is returned in field called 'descripton'
        // But for now extracting the hours and mins from the string description field
        const travelhours = recording.traveltime ? recording.traveltime.split(':')[0] : '0';
        const travelminutes = recording.traveltime ? recording.traveltime.split(':')[1] : '0';
        return travelhours + ' Hr(s) ' + travelminutes + ' Mins(s)';
    }

    convertMatinputTimeToTimestamp(date: any, time: any) {
        return moment(moment(date).format(this.dtformat) + ' ' + time).format();
    }

    setupTimePayload(recording: any) {
        const startTime = moment(recording.contactdate).format(this.dtformat) + ' ' + recording.starttime;
        const endTime = moment(recording.contactdate).format(this.dtformat) + ' ' + recording.starttime;
        recording.starttime = moment(startTime).format();
        recording.endtime = moment(endTime).format();
        return recording;
    }

    changeContactDate(val: any) {
        const value = (val.target as HTMLInputElement).value;
        this.checkChangeDateValue(value);
        this.computeContactDuration();
    }

    checkChangeDateValue(value: any) {
        if (value) {
            this.recordingForm.controls['starttime'].enable();
            this.recordingForm.controls['endtime'].enable();
        } else {
            this.recordingForm.controls['starttime'].setValue('');
            this.recordingForm.controls['endtime'].setValue('');
            this.recordingForm.controls['starttime'].disable();
            this.recordingForm.controls['endtime'].disable();
        }
    }



    getSourceData(editRecord: any) {
        if (editRecord && editRecord.entitytype) {
            if (editRecord.entitytype.toLowerCase() === 'intake') {
                return 'Intake';
            } else if (editRecord.entitytype.toLowerCase() === 'intakeservicerequest') {
                return 'CPS';
            } else if (editRecord.entitytype.toLowerCase() === 'servicecase') {
                return 'Service Case';
            } else if (editRecord.entitytype.toLowerCase() === 'adoption') {
                return 'Adoption';
            }
        }
        return ''
    }

    getLocation(record: any) {
        if (record) {
            const recordData = Object.assign({}, record);
            if (recordData.recordingsubtype === 'Other') {
                return recordData.locationname;
            } else {
                return recordData.recordingsubtype;
            }
        }
        return '';
    }

    updateRecordSearch() {
        const listOfactorids: any = [];
        this.recordSearch.intakeservicerequestactorids.forEach(id => {
            if (this.personRoles && this.personRoles.length) {
                const personRole = this.personRoles.find(role => role.intakeservicerequestactorid === id);
                if (personRole && personRole.role && personRole.role.length) {
                    personRole.role.forEach((item: { intakeservicerequestactorid: any; }) => {
                        listOfactorids.push(item.intakeservicerequestactorid);
                    });
                    this.recordSearch.intakeservicerequestactorids = listOfactorids;
                }
            }
        })
    }

    downloadContactPDF() {
        this.addContactNotesAudit(this.downloadcontactnotestr, null);
        this.recordSearch.progressnotereasontypekey =
            this.searchCategoryForm.getRawValue().progressnotereasontypekey ?
                this.searchCategoryForm.getRawValue().progressnotereasontypekey.join() : '';
        ObjectUtils.removeEmptyProperties(this.recordSearch);

        if (this.recordSearch.intakeservicerequestactorids && this.recordSearch.intakeservicerequestactorids.length) {
            this.updateRecordSearch();
        }
        const modal = {
            count: -1,
            where: {
                ...this.recordSearch,
                documenttemplatekey: ['contactpdf'],
                entitytype: this.entityType,
                caseNumber: this.daNumber,
                entitytypeid: this.id
            },
            method: 'post'
        };
        this._commonHttpService.getSingle(modal, 'evaluationdocument/generateintakedocument').subscribe((data) => { //NOSONAR   // This function has less than 3 lines of duplicate code.
            if (data) {
                window.open(data.data[0].documentpath, '_blank');
            }
        });
    }

    public trackByFunc(index: any, item: any) {
        return index;
    }

    getPersonRoleDescription(role: any) {
        if (role) {
            if (role.hasOwnProperty("description")) {
                return role.description;
            } else if (role.hasOwnProperty("typedescription")) {
                return role.typedescription;
            }
        } else {
            return;
        }
    }
    showComma(array: any, index: any){
       if((array.length - 1) === index){
           return false;
       }else {
           return true;
       }
    }

    checkPageNavigation(nextUrl: any) {
        this.navigationUrl = nextUrl;
        $('#contact-notes-unsaved-alert').modal('show');
    }

    navigateAfterSave(modal: any) {
        this.clearPageNavigationPopup();
        if (!modal) {
            this.checkPageNavigationFlag = true;
            this._route.navigate([this.navigationUrl]);
            return;
        }
        this.saveRecording(this.recordingForm.value, 'SAVE', false, true);
    }

    clearPageNavigationPopup() {
        $('#contact-notes-unsaved-alert').modal('hide');
    }


    uploadclosed(event: any){
        if(event){
        this.load = true;
        }
    }

    updateLoad() {
        this.load = false;
    }

    onPaste(e: any) {
        e.preventDefault();
        this.sanitizeNotes(this.recordingForm.controls['description'].value);
    }

    sanitizeNotes(noteText:any) {
        const div: any = document.createElement('div');
        div.innerHTML = noteText;
        div.querySelectorAll('[target="_blank"]').forEach((el: any) => {
            el.replaceWith(el.getAttribute("href"));
            this.recordingForm.controls['description'].setValue(div.innerHTML);
        });

        return div.innerHTML;
    }
    refreshpage() {
        const uploadFiles = this.shareduploadService.getUploadFileProgress()
        this._session.setItem('refreshuploadfiles', JSON.stringify(uploadFiles));
        if (this.isFileInProgress) {
            this.returnList(true);
            // this._service.getdsdsactionsummary();
        } else {
            window.location.reload();
        }
    }
    getControlByIndexFn(index: string, formname: any): FormControl {
        return formname.controls[index] as FormControl;
      }

    addConditionsAudit(key: any, refkeyid: any) {
        let username;
        let objectType;

        objectType = 'Medication-Psychotropic';
        if (key == 'Yes') {
            key = "yes-popup-medication-psychotropic";
        } else {
            key = "no-popup-medication-psychotropic";
        }

        this._authService.currentUser.subscribe((userInfo) => {
            username = userInfo.user.securityusersid;
        });
        const comment = {
            securityusersid: username,
            logtype: key,
            referenceid: refkeyid,
            objectype: objectType,
            description: key
        };
        this._commonHttpService.create(comment, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddDetailedAudit);

    }

    addPersonDataForMedicationPopup(progressNoteRoleType: any) {
        this.tempData = [];
        for (const element of progressNoteRoleType) {
            const isChildOOH = element.programarea?.filter((item: any) => item.programkey === 'OOH');
            if(isChildOOH?.length > 0) {
              this.tempData.push({ name: this._globalPopupService.capitalizeWords(element.displayName), id: element.personid, alerttype: 'Medication-Psychotropic' });
            }
        }
    }

    downloadLargeFileView(source: any) {
        if (source.ecmsdocumentid !== '' )
         {
          const where = {
            "docId": source.ecmsdocumentid ,
            "filename":  source.originalfilename
          }
          const endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileViewFromEDMS;
          this._commonHttpService
          .create(
            {
              method: 'post',
              where
            },
            endpointUrl + '?filter'
          ).subscribe(
              (response) => {
                const result = (typeof response === 'string') ? JSON.parse(response) : response;
                const s3bucketpathname = result?.downloadUrl?.replace(/,/g, '');
                if (!s3bucketpathname) {
                  this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                  return;
                }
                window.open(s3bucketpathname, '_blank');
              },
              (error) => {
                  this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              }
          );
        }     
      }

      resetCommentForm() {
        $('#CommentDialog').modal('hide');
        this.commentForm.reset();
      }

      getHolidays() {
        this._httpService
            .get(
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetHolidaysURL
            )
            .subscribe({
                next: (result: any) => {
                    this.holidays = (result || []).map((x: any) => x.holidaydate?.split('T')[0]);
                },
                error: (err: any) => {
                    console.error('Error fetching holidays:', err);
                    this.holidays = [];
                }
            });
      }

    /** This functions is used figure out the business day logic.
     * Adds business days while:
     * - skipping weekends
     * - skipping holidays
     * - preserving exact time
     */
    addBusinessDays(startDate: Date, businessDays: number, holidays: string[] = []): Date {
        const result = new Date(startDate);
        let addedDays = 0;
        while (addedDays < businessDays) {
            result.setDate(result.getDate() + 1); // sets to next calendar day
            const day = result.getDay();
            const year = result.getFullYear();// yyyy-MM-dd
            const month = String(result.getMonth() + 1).padStart(2, '0');
            const date = String(result.getDate()).padStart(2, '0');
            const dateString = `${year}-${month}-${date}`;
            const isWeekend = day === 0 || day === 6;
            const isHoliday = holidays.includes(dateString);

            // count only valid business day
            if (!isWeekend && !isHoliday) {
                addedDays++;
            }
        }
        return result;
    }

    // This function checks for delay validation logic and shows up delayed reasons accordingly.
    checkDelay() {
        this.isDelay = false;
        const contactDateValue = this.recordingForm?.get('contactdate')?.value;
        const startTime = this.recordingForm?.get('starttime')?.value;
        const endTime = this.recordingForm?.get('endtime')?.value;
        const selectedContactPurpose = this.recordingForm?.get('progressnotereasontypekey')?.value;
        const selectedContactType = this.recordingForm?.get('progressnotetypeid')?.value;
        const hasMonthlyvisit = selectedContactPurpose?.includes('MV'); // Monthly Visit
        const hasContactType = selectedContactType?.toLowerCase()?.includes('face');// Face to Face OR Initial Face to Face
        const delayReasonControl = this.recordingForm?.get('delayreasons');

        // validation
        if (!contactDateValue || !startTime || !endTime) {
            this.isDelay = false;
            delayReasonControl?.clearValidators();
            delayReasonControl?.updateValueAndValidity();
            return;
        }

        // Contact Start Datetime
        const contactDateTime = new Date(contactDateValue);
        const [startHour, startMinute] = startTime.split(':');
        contactDateTime.setHours(Number(startHour), Number(startMinute), 0, 0); // Setting Contact Start Datetime

        // Contact End Datetime
        const contactDateEndTime = new Date(contactDateValue);
        const [endHour, endMinute] = endTime.split(':');
        contactDateEndTime.setHours(Number(endHour), Number(endMinute), 0, 0); // Setting Contact end Datetime

        // Current datetime
        const currentDateTime = new Date();

        // Prevent future dates/times
        const isFutureTime = contactDateTime > currentDateTime || contactDateEndTime > currentDateTime;

        if (isFutureTime) {
            this.isDelay = false;
            delayReasonControl?.clearValidators();
            delayReasonControl?.updateValueAndValidity();
            return;
        }

        // Calculate threshold datetime: Contact datetime + 5 business days
        const thresholdDateTime = this.addBusinessDays(contactDateEndTime, 5, this.holidays);

        /**
         * Delay logic
         *
         * Example:
         * Contact: 05/08/2026 1:30 PM
         * Threshold: 05/15/2026 1:30 PM
         * Weekend: excluded
         * Holidays: no
         *
         * Delay becomes TRUE only AFTER:
         * 05/15/2026 1:31 PM
         */
        this.isDelay = currentDateTime > thresholdDateTime && hasMonthlyvisit && hasContactType && this.isActiveOOH;
        if (this.isDelay) {
            delayReasonControl?.setValidators([Validators.required]);
        } else {
            delayReasonControl?.clearValidators();
        }
        delayReasonControl?.updateValueAndValidity();
    }

    onSelectOfprogressnotereasontypekey(value: any) {
        const isMISelected = value.includes('MI');

        // Call API only once when MI is newly selected
        if (isMISelected && !this.wasMISelected) {
            this.getReasonForContactBySubtype('5471');
        }

        this.addMotivationalInterviewValidations(isMISelected);
        this.wasMISelected = isMISelected;
    }
    

    onCloseViewModal(){
       this.isMotivationInterviewSelected = false; 
    }

    calculateContactDurationForMIRecord(recording: any) {
        const _startTime = moment(
          `${moment(recording.controls.contactdate.value).format(this.dtformat)} ${moment(recording.controls.starttime.value, ['HH:mm', 'HH:mm:ss']).format('HH:mm:ss')}`,
          `${this.dtformat} HH:mm:ss`
        );
      
        const _endTime = moment(
          `${moment(recording.controls.contactdate.value).format(this.dtformat)} ${moment(recording.controls.endtime.value, ['HH:mm', 'HH:mm:ss']).format('HH:mm:ss')}`,
          `${this.dtformat} HH:mm:ss`
        );
      
        const diffMs = _endTime.diff(_startTime);
      
        // Check if duration is at least 15 minutes
        if (diffMs >= 15 * 60 * 1000) {
          const duration = moment.duration(diffMs);
          const hours = Math.floor(duration.asHours());
          const minutes = duration.minutes();
      
          return `${hours} Hr(s) ${minutes} Min(s)`;
        }
      
        return ''; // less than 15 minutes
      }


    addMotivationalInterviewValidations(isMISelected: boolean) {
        if (isMISelected) {
            this.enableMotivationalInterview();
        } else {
            this.disableMotivationalInterview();
        }
    }

private enableMotivationalInterview() {
    this.isMotivationInterviewSelected = true;
    
    this.recordingForm.get('mioptions')?.setValidators([Validators.required]);
    this.recordingForm.get('mioptions')?.updateValueAndValidity();
    
    this.recordingForm.get('starttime')?.setValidators([Validators.required]);
    this.recordingForm.get('starttime')?.updateValueAndValidity({ onlySelf: true, emitEvent: false });
    
    this.recordingForm.get('endtime')?.setValidators([Validators.required]);
    this.recordingForm.get('endtime')?.updateValueAndValidity({ onlySelf: true, emitEvent: false });
    
    this.startEndTimeValidator = true;
    this.applyMIFilter();
}

private disableMotivationalInterview() {
    this.isMotivationInterviewSelected = false;
    this.recordingForm.patchValue({ mioptions: '' });
    this.recordingForm.get('mioptions')?.setValidators(null);
    this.recordingForm.get('mioptions')?.updateValueAndValidity({ emitEvent: false });
    this.startEndTimeValidator = false;
    
    this.recordingForm.get('starttime')?.clearValidators();
    this.recordingForm.get('starttime')?.updateValueAndValidity({ onlySelf: true, emitEvent: false });
    
    this.recordingForm.controls['endtime'].clearValidators();
    this.recordingForm.controls['endtime'].updateValueAndValidity({ emitEvent: false });

    // Restore both full lists
    this.focusInvolvedPersons = this.originalFocusInvolvedPersons.map(item => ({
        ...item,
        intakeservicerequestactorid: item.involvedPersonId
    }));
    this.involvedPersons = [...this.originalInvolvedPersons];
}
    

}

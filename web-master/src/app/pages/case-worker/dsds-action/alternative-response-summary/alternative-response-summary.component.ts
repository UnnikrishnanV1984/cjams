
import { timer as observableTimer, Observable, forkJoin } from 'rxjs';
import { share, pluck, map } from 'rxjs/operators';
import { Component, OnInit, OnDestroy, ViewChild, ElementRef, Renderer2, Injector } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { isCaseUuid } from '../../../../@core/common/initializer';
import { ControlUtils } from '../../../../@core/common/control-utils';
import { CheckboxModel, DropdownModel, PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { ComarFindings } from '../investigation-findings/investigation-summary-report/investigation-summary-report-config';
import { CaseWorkReportSummary, Illegalactivity, ReportSummary, PersonAddress, DSDSActionSummary } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { SpeechSynthesizerService } from '../../../../shared/modules/web-speech/shared/services/speech-synthesizer.service';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import jsPDF from 'jspdf';
import moment from 'moment';
import _ from 'lodash';
import { AppConstants } from '../../../../@core/common/constants';
import { SubmitForReview, InvestigationFinding, CheckList, PersonComar } from '../investigation-findings/_entities/investigation-finding-data.models';
import { RoutingUser } from '../../../provider-referral/new-private-referral/_entities/existingreferralModel';
import { DispositionAddModal } from '../disposition/_entities/disposition.data.models';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { InvolvedPerson } from '../involved-persons/_entities/involvedperson.data.model';
import { config } from '../../../../../environments/config';
// import html2canvas from 'html2canvas';
import { MatTableDataSource } from '@angular/material/table';
import { GlobalPopupComponent } from '../../../../shared/shared-components/global-popup/global-popup.component';
import { Html2CanvasService } from '../../../../@core/services/html2canvas.service';
import { AlternativeResponseSummaryResolverService } from './alternative-response-summary-resolver-service';


declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'alternative-response-summary',
    templateUrl: './alternative-response-summary.component.html',
    styleUrls: ['./alternative-response-summary.component.scss'],
    standalone: false
})
export class AlternativeResponseSummaryComponent implements OnInit, OnDestroy {
    @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent;
    disableNo!: boolean;
    disableAddress!: boolean;
    downloadInProgress!: boolean;
    documentsToDownload: string[] = [];
    isServiceCase: any;
    id: string;
    isCW!: boolean;
    daNumber: string;
    caseclosuresummaryid!: string;
    paginationInfo: PaginationInfo = new PaginationInfo();
    possibleIllegalActivityDropdown!: FormArray;
    reportSummaryForm!: FormGroup;
    ARCaseSummaryForm!: FormGroup;
    ARSummaryReportForm!: FormGroup;
    closureSubTypeItems: DropdownModel[] = [];
    illegalActivityDd = false;
    countyList = [];
    significantEventDd = false;
    investigation!: InvestigationFinding[];
    uploadedDocuments = [];
    isuploadedDocuments = [];
    significantEventDropdownItems$!: Observable<DropdownModel[]>;
    reasonDropDown!: any[];
    statusDropDown!: any[];
    statusTempDropDown!: any[];
    serviceDropDown!: any[];
    dsdsActionsSummary = new DSDSActionSummary();
    reviewCheckListForm!: FormGroup;
    sourceDropdownItems$!: Observable<DropdownModel[]>;
    possibleCheckboxItems: CheckboxModel[] = [];
    reportSummary?: ReportSummary;
    LegalGuardian!: string;
    reportSummaryDangerAddress!: PersonAddress;
    private selectedIllegalActivities: string[] = [];
    private speaking = false;
    private paused = false;
    private voiceNotStarted = true;
    missinglegalRole!: any[];
    involvedPersons$!: Observable<any[]>;
    countyid!: string;
    isLGPresent!: boolean;
    clientrefrdservicesdisabled!: boolean;
    statuslistdisabled!: boolean;
    involevedUnkPerson: any[] = [];
    involvedChildren: any[] = [];
    involvedOthers: any[] = [];
    involvedPersons: any[] = [];
    selectedParticipant!: any[];
    reviewCheckList!: CheckList[];
    selectedChild!: any[];
    isUnkPresent!: boolean;
    AssessmentParticipanttext: boolean = false;
    userRole!: AppUser;
    caseWorkerName!: AppUser;
    isAs!: boolean;
    isCaseWorker!: boolean;
    isSupervisor!: boolean;
    speechRecogninitionOn: boolean;
    speechData: string;
    currentLanguage!: string;
    submitForReview = new SubmitForReview();
    currentSpeechRecInput!: string;
    isMandatory: any;
    notification!: string;
    recognizing = false;
    ARAssessmentClosureDate!: Date;
    AssessmentParticipant!: any[];
    savedParticipants!: any[];
    disableView = false;
    nameTest!: string;
    investigationFind: any;
    reportflag = -1;
    isapprove!: boolean;
    dsdsobject: any;
    currentDate = new Date();
    printData: any = {};
    selectedallegedperson: any;
    maltreator: any;
    supervisorApprovalDetails = [];
    reportcomarfindings: any;
    comarFindingsKey: any;
    personComar = new PersonComar();
    involevedPerson$!: Observable<InvolvedPerson[]>;
    children: any = [];
    others: any = [];
    autoSaveIntervalTimer!: NodeJS.Timer;
    autoSaveInitiated: boolean = false;
    currentfindings: any;
    lastUpdatedTime: any = null;
    isARAutoSaveFlag: boolean = false;
    isARCaseSummaryAutoSaveFlag: boolean = false;
    currentARCaseSummary: any;
    sdmData : any;

    @ViewChild('appButton')
    apButton!: ElementRef;
    @ViewChild('rjButton')
    rjButton!: ElementRef;

    arStatus: string = '';
    investigationAllegationList: any;

    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    investigationFindingForm!: FormGroup;
    submitBtn = false;
    savedIndividual!: any[];
    arsummaryStatus!: string;
    selectedSupervisor!: string;
    supervisorsList!: any[];
    isClosed = false;

    dispositionFormGroup!: FormGroup;
    statusDropdownItems$!: Observable<DropdownModel[]>;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    private dispositionDropdownItems!: DropdownModel[];
    private daType!: string;
    isChildNotDead = true;
    servicelist: any = [];
    moduleview: any;

    form1080c_alert = '#form1080c-alert';
    investigationpopupid = '#checklist-investigation-findings-review';
    gettypesurl = 'referencetype/gettypes';
    mentalinjuryabuse = 'MENTAL INJURY- ABUSE';
    mentalinjuryneglect = 'MENTAL INJURY- NEGLECT';
    physicalabuse = 'PHYSICAL ABUSE';
    sexualabuse = 'SEXUAL ABUSE';
    dtformat = 'MM/DD/YYYY';
    displayorder = 'displayorder ASC';

    form1080aDataSource!: MatTableDataSource<string>;
    form1080bDataSource!: MatTableDataSource<string>;
    form1080cDataSource!: MatTableDataSource<string>;

    ischildfatality = false;
    isseriousphysicalinjury = false;
    ismaltreatment = false;
    form1080cData: any = [];
    intakesdmproviderlength : any;
    isSenChildExists: boolean = false;

    private route: ActivatedRoute;
    private formBuilder: FormBuilder;
    public _authService: AuthService;
    private _alertService: AlertService;
    private _commonHttpService: CommonHttpService;
    private _reportSummaryService: GenericService<ReportSummary>;
    private _dataStoreService: DataStoreService;
    private _speechSynthesizer: SpeechSynthesizerService;
    private speechRecognizer: SpeechRecognizerService;
    private _speechRecognitionService: SpeechRecognitionService;
    private _renderer: Renderer2;
    private _dispositionAddService: GenericService<DispositionAddModal>;
    private _router: Router;
    private storage: SessionStorageService
    safeCDataSource!: MatTableDataSource<string>;
    mfiraDataSource!: MatTableDataSource<string>;

    constructor(private injector: Injector, private html2canvas:Html2CanvasService, private arSummaryResolverService: AlternativeResponseSummaryResolverService) {
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this.formBuilder = injector.get<FormBuilder>(FormBuilder);
        this._authService = injector.get<AuthService>(AuthService);
        this._alertService = injector.get<AlertService>(AlertService);
        this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
        this._reportSummaryService = injector.get<GenericService<ReportSummary>>(GenericService);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._speechSynthesizer = injector.get<SpeechSynthesizerService>(SpeechSynthesizerService);
        this.speechRecognizer = injector.get<SpeechRecognizerService>(SpeechRecognizerService);
        this._speechRecognitionService = injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this._renderer = injector.get<Renderer2>(Renderer2);
        this._dispositionAddService = injector.get<GenericService<DispositionAddModal>>(GenericService);
        this._router = injector.get<Router>(Router);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.speechRecogninitionOn = false;
        this.speechData = '';
        // this.route.data.subscribe(data => {
        //     if (data && data.hasOwnProperty('result')) {
        //         this._authService.setAuthDetail('arsummary', data.result);
        //     }
        // });
    }
    ngOnInit() {
        this.arSummaryResolverService.getArSummary().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('arsummary', data);
            }
        })
        this.moduleview = this._authService.isModuleAccessable('arsummary', 'arsummary');
        this._speechSynthesizer.initSynthesis();
        this.userRole = this._authService.getCurrentUser();
        this.caseWorkerName = this._authService.getCurrentUser();
        this.speechRecognizer.initialize(this.currentLanguage);
        this.selectedParticipant = [];
        this.selectedChild = [];
        this.initARCaseSummaryForm();
        this.initARSummaryReportForm();
        this.loadReasonDropDown();
        this.loadStatusDropDown();
        this.loadServiceDropDown();
        const store = this._dataStoreService.getCurrentStore();
        if (store['dsdsActionsSummary']) {
            this.dsdsActionsSummary = store['dsdsActionsSummary'];
            this.daType = this.dsdsActionsSummary.da_typeid;             //SonarQube changes store['dsdsActionsSummary'] check is done already so need to check the conditions again
            this.loadStatuses();
            this.getFindingList();
        } else {
            this.getActionSummary();
        }
        if (this._authService.isCW()) {
            this.isCW = true;
            this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
            this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        }
        this.possibleIllegalActivityDropdown = this.formBuilder.array([this.formBuilder.control(false)]);
        if (this.id !== '0') {
            this.listReportSummary(this.id);
        }
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.PossibleCheckList + '?filter'
            ),
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.Source + '?filter'
            )
        ]).pipe(
            map(result => {
                return {
                    intakeServiceRequestIllegalActivityTypes: result[0].map(
                        res =>
                            new CheckboxModel({
                                text: res.typedescription,
                                value: res.intakeservicerequestillegalactivitytypekey,
                                isSelected: false
                            })
                    ),
                    intakeServiceRequestInputTypes: result[1].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.intakeservreqinputtypeid
                            })
                    )
                };
            }),
            share());
        this.sourceDropdownItems$ = source.pipe(pluck('intakeServiceRequestInputTypes'));
        this._dataStoreService.currentStore.subscribe(storeResponse => {
            if (storeResponse['da_status'] === 'Closed') {
                ControlUtils.disableElements($('#Involved-Persons').children());
            }
            if (storeResponse['countyid']) {
                this.countyid = storeResponse['countyid'];

            }
        });
        this.initFindingsForm();
        this.getCountyList();
        this.getARSummaryCase();

        const da_status = this.storage.getItem('da_status');
        this.isClosed = false;
        if (da_status === 'Closed' || da_status === 'Completed') {
            this.isClosed = true;
        }
        this.dispositionFormGroup = this.formBuilder.group({
            statusid: [''],
            dispositionid: ['', Validators.required],
            closingcodetypekey: [null],
            reviewcomments: [''],
            tosecurityuserid: [null],
        });
        this.existingForm();
        this.initiateAutoSave(true);

        this.loadLegislativeDropDown();
        this.emergncyStiuationDropDown();
        this.forResonNotProvidedDropDown();
        this._gelegislativetData();

          // loading sdm data
          this.getSDM();
          // get form1080A data
          this.getForm1080C();
          this.getInvolvedPersons();
    }

    private getInvolvedPersons() {
        let intakeserviceid  = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this._commonHttpService
        .getPagedArrayList( new PaginationRequest({
            method: 'get',
            page: 1, limit : 20,
            where: { intakeserviceid: intakeserviceid }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
        ).subscribe(response => {
            if (response && response.data.length) {
                let senChild = response.data.filter(item => item.senstatusflag === 1);
                if(senChild.length) {
                    this.isSenChildExists = true;
                    this.reviewCheckListForm.patchValue({ activeSenService: this.dsdsActionsSummary?.servicecasenumber ? true : false });
                    // dsdsActionsSummary
                }
            }
        });
    }

      // Get Form 1080 C Data
      getForm1080C() {
        const intakeNumber = this._dataStoreService.getData("da_intakenumber");
        const inputRequest = {
            objectid: [this.id, intakeNumber],
        };
        this._commonHttpService.getArrayList(
            new PaginationRequest({
                where: inputRequest,
                method: "get",
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080c.List + "?filter"
        ).subscribe(
            (response) => {
                if (response) {
                    this.form1080cData = response;
                }
            },
            (error) => {
                this._alertService.warn('Error retrieving Form 1080C data');
            }
        );
    } 


    initiateAutoSave(enableFlag: any, formData?: any, index?: any) {
        let diffFlag = true;
        let ARCaseSummaryDiffFlag = true;
        const expungementDiffFlag = true;
        if (!enableFlag) {
            return;
        }
        if (this.autoSaveInitiated) {
            return;
        }
        this.autoSaveInitiated = true;
        this.autoSaveIntervalTimer = setInterval(() => {
            // AR Investigation Auto Save
            const diffArray: any[] = [];
            const latestFindings = this.investigationFindingForm.getRawValue().allegedperson;
            diffFlag = _(this.currentfindings).differenceWith(latestFindings, _.isEqual).isEmpty();
            if (!diffFlag) {
                latestFindings.forEach((element: any) => {
                    if (!this.currentfindings.includes(element)) {
                        diffArray.push(element);
                    }
                });
            }
            if (enableFlag && !diffFlag && !this.isClosed && !this._authService.isDisabled('arsummary', 'arsummary.narrativesummary.save')) {
                diffArray.forEach(() => {
                    this.saveInvestigation(true);
                });
            }
            // AR Case Summary Auto Save
            const latestARCaseSummary = this.ARCaseSummaryForm.getRawValue();
            ARCaseSummaryDiffFlag = _.isEqual(this.currentARCaseSummary, latestARCaseSummary);
            if (enableFlag && !ARCaseSummaryDiffFlag && this.arsummaryStatus !== 'Approved' && this.arsummaryStatus !== 'Review' && !this.isClosed && !this._authService.isDisabled('arsummary', 'arsummary.summary.save')) {
                this.saveARCAseSummary('summarySave', null, true);
            }

        }, config.AutoSaveTimer);
        this._dataStoreService.setData('ARInvestigationTimer', this.autoSaveIntervalTimer);
    }
    existingForm() {
        setTimeout(() => {
            this.currentfindings = this.investigationFindingForm.getRawValue().allegedperson;
            this.currentARCaseSummary = this.ARCaseSummaryForm.getRawValue();
        }, 3000);
    }
    private getActionSummary() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this._commonHttpService.getById(this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe(
            (response) => {
                this.dsdsActionsSummary = response[0];
                if (this.dsdsActionsSummary) {
                    this.getFindingList();
                } else {
                    this._alertService.error('DSDS Action Summary is Empty, Please Check Your Data.');
                }
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    private checkListMandatory() {
        this.isMandatory = {
            initialfacetoface: false,
            safec: false,
            cansf: false,
            mfira: false,
            personrole: false,
            lateinitialcontact: false,
        };
        this.reviewCheckList.forEach((review) => {
            if (review.taskname === 'initalfacetoface' && review.isvalid === 1) {
                this.isMandatory.initialfacetoface = true;
            } else if (review.taskname === 'Safe C Assessment' && review.isvalid === 1) {
                this.isMandatory.safec = true;
            } else if (review.taskname === 'CANS-F assessment' && review.isvalid === 1) {
                this.isMandatory.cansf = true;
            } else if (review.taskname === 'MFIRA assessment' && review.isvalid === 1) {
                this.isMandatory.mfira = true;
            } else if (review.taskname === 'Personrole' && review.isvalid === 1) {
                this.isMandatory.personrole = true;
            } else if (review.taskname === 'lateinitialcontact' && review.isvalid === 1) {
                this.isMandatory.personrole = true;
            }
        });
    }

    conditionCheckList(): boolean {
        this.enableLegislativeDropDwn();
        if (this.reviewCheckList && this.reviewCheckList.length) {
            return this.ischecklistvalid();
        } else {
            return false;
        }
    }
    ischecklistvalid() {
        let result = false;
        const { islateinitialcontact, isFacetoFace, personRole } = this.returnIschecklistvalidFn();
        let _islateinitialcontact = true;
        if (((!(!(this?.reviewCheckListForm?.controls?.initalfacetoface?.value) && (this?.caseclosure))) && this.showLateInitialContact()) && (!islateinitialcontact)) {
            _islateinitialcontact = false;
        }
        const safec = this.returnSafecReviewList();
        const safecohp =  this.returnSafecOHPReviewList();
        const mifra = this.returnMifraReviewList();
        const isChildDead = this.returnisChildDeadList();
        if (((isFacetoFace || this.caseclosure) && personRole && isChildDead && _islateinitialcontact && this.dropDwnValidation())
            || ((isFacetoFace || this.caseclosure) && personRole && _islateinitialcontact && !isChildDead && (safec || safecohp) && mifra && this.dropDwnValidation())) {
                result = true;
        }


        if(((this.isSenChildExists && this.reviewCheckListForm.controls['activeSenService'].value) || 
        (!this.isSenChildExists && !this.reviewCheckListForm.controls['activeSenService'].value)) && result) {
            result = true;
        } else {
            result = false;
        }

        return result;
    }

    // Assosiated with ischecklistvalid method
    private returnIschecklistvalidFn() {
        const isFacetoFace = this.reviewCheckList.find(item => item.taskname === 'initalfacetoface' && item.status === 'YES' && item.shownoshow === 'YES');
        const personRole = this.reviewCheckList.find(item => item.taskname === 'Personrole' && item.status === 'YES' && item.shownoshow === 'YES');
        const islateinitialcontact = this.reviewCheckList.find(item => item.taskname === 'lateinitialcontact'
            && (item.status === 'YES' && item.shownoshow === 'YES') || item.shownoshow === 'NO');
        return { islateinitialcontact, isFacetoFace, personRole };
    }

    returnSafecOHPReviewList() {
        return this.reviewCheckList && this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'SAFE-C OHP' && item.status === 'Accepted'));
    }

    returnSafecReviewList() {
        return this.reviewCheckList && this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'SAFE-C' && item.status === 'Accepted'));
    }

    returnMifraReviewList() {
        return this.reviewCheckList && this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'MFIRA' && item.status === 'Accepted'));
    }

    returnisChildDeadList() {
        return this.reviewCheckList && this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'initalfacetoface' && item.isvalid === 0));
    }

    showLateInitialContact() {
        return this.reviewCheckList && this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'lateinitialcontact' && item.shownoshow === 'YES'));
    }

    displayLesgisLativeDropDwn = false;
    enableLegislativeDropDwn() {
        const today = moment(new Date()).format("YYYY-MM-DD");
        const _duedate = moment(this.dsdsActionsSummary.da_duedate).format("YYYY-MM-DD");
        if (this.dsdsActionsSummary && this.dsdsActionsSummary.da_daystogo === '0') {
            if (_duedate < today) {
                this.displayLesgisLativeDropDwn = true;
            }
            else {
                this.displayLesgisLativeDropDwn = false;
            }
        } else {
            this.displayLesgisLativeDropDwn = false;
        }
    }

    dropDwnValidation() {
        if (this.displayLesgisLativeDropDwn !== true) {
            return true;
        }
        if (!this.dsdsActionsSummary || this.dsdsActionsSummary?.da_daystogo !== '0') {
            return true;
        }

        const legislativeReq_ = this.reviewCheckListForm.controls.legislativeReq.value;
        const forResonNotProvided_ = this.reviewCheckListForm.controls.forResonNotProvided.value;
        const emergncyStiuation_ = this.reviewCheckListForm.controls.emergncyStiuation.value;
        if (legislativeReq_ === "DAEERR") {
            return true;
        } else if (legislativeReq_ === "FRARNP" && forResonNotProvided_) {
            return true;
        } else if (legislativeReq_ === "EMEPRE" && emergncyStiuation_) {
            return true;
        } else if (legislativeReq_ === "SDNRAA") {
            return true;
        } else if (legislativeReq_ === "ROAPNG") {
            return true;
        } else {
            return false;
        }
    }

    safeCDisplayedColumns: string[] = ['name']; 
    mfiraDisplayedColumns: string[] = ['name'];
    form1080Columns: string[] = ['name'];

    reviewCheck() {
        this.saveARCAseSummary('summarySave');
        this.commarValidation();
        if (!this.submitBtn) {
            this._alertService.error('Please Complete Maltreatment Allegation');
            return;
        }
        const intakeNumber = this._dataStoreService.getData("da_intakenumber");
        this._commonHttpService.getArrayList(
            new PaginationRequest({
                where: { intakeserviceid: this.id, intakeNumber : intakeNumber },
                method: 'get'
            }),
            'Investigationfindings/getfacetofacedetails?filter'
        ).subscribe((result) => {
            this.reviewCheckList = result;
            this.safeCDataSource = new MatTableDataSource(result[1].safecmissingchild);
            this.mfiraDataSource = new MatTableDataSource(result[1].miframissingchild);
            this.form1080aDataSource = new MatTableDataSource(result[1].form1080achild);
            this.form1080bDataSource = new MatTableDataSource(result[1].form1080bchild);
            this.form1080cDataSource = new MatTableDataSource(result[1].form1080cchild);
            const isChildDead = this.reviewCheckList.find(item => item.taskname === 'initalfacetoface' && item.isvalid === 0);
            this.isChildNotDead = true;
            if (isChildDead) {
                this.isChildNotDead = false;
            }
            this.updatereviewlistform();         //SonarQube move this logic to seperate function                           

            const commar = this.submitForReview.allegedperson.filter((data) => data.investigationfindings === null);
            if (commar.length > 0) {
                this._alertService.warn('Please select investigation finding');
            } else {
                // CIDM-8246 Added logic for not to show Review checklist pop up when mandatory fields are not entered.
                if (!this.ARCaseSummaryForm.controls['closuretypekey'].valid || !this.ARCaseSummaryForm.controls['referralreason'].valid) {
                    $(this.investigationpopupid).modal('hide'); 
                } else {
                    $(this.investigationpopupid).modal('show');
                     //checking if Form 1080 C is entered or not
                  this.form1080cCheck();
                }
            }
        },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    form1080cCheck() : void {
        if(!this.checkForm1080CFilled()){
            const riskOfHarm=  this._dataStoreService.getData('IsRiskofHarm');
            if((this.isServiceCase && !riskOfHarm) || (!this.isServiceCase)) {
                this.globalPopupRef.showGlobalPopupAlert('Form 1080 C Alert','Please complete and submit the 1080 C form. The 1080 Series is located in the Forms sub-tab of the Documents tab.');
            } 
        }
    }

    updatereviewlistform() {
        const isFacetoFace = this.reviewCheckList.find(item => item.taskname === 'initalfacetoface' && item.status === 'YES' && item.shownoshow === 'YES');
        const personRole = this.reviewCheckList.find(item => item.taskname === 'Personrole' && item.status === 'YES');
        const islateinitialcontact = this.reviewCheckList.find(item => item.taskname === 'lateinitialcontact' && item.status === 'YES');
        const safec = this.reviewCheckList.find(item => item.taskname === 'SAFE-C' && item.status === 'Accepted');
        const safecohp = this.reviewCheckList.find(item => item.taskname === 'SAFE-C OHP' && item.status === 'Accepted');
        const mifra = this.reviewCheckList.find(item => item.taskname === 'MFIRA' && item.status === 'Accepted');
        const cansf = this.reviewCheckList.find(item => item.taskname === 'cans-v2' && item.status === 'Accepted');

        this.reviewCheckListForm.patchValue({ initalfacetoface: false });
        if (isFacetoFace) {
            this.reviewCheckListForm.patchValue({ initalfacetoface: true });
        }
        this.reviewCheckListForm.patchValue({ personrole: false });
        if (personRole) {
            this.reviewCheckListForm.patchValue({ personrole: true });
        }
        this.reviewCheckListForm.patchValue({ lateinitialcontact: false });
        if (islateinitialcontact) {
            this.reviewCheckListForm.patchValue({ lateinitialcontact: true });
        }
        this.reviewCheckListForm.patchValue({ safec: false });
        if (safec || safecohp) {
            this.reviewCheckListForm.patchValue({ safec: true });
        }
        this.reviewCheckListForm.patchValue({ mfira: false });
        if (mifra) {
            this.reviewCheckListForm.patchValue({ mfira: true });
        }
        this.reviewCheckListForm.patchValue({ canf: false });
        if (cansf) {
            this.reviewCheckListForm.patchValue({ canf: true });
        }

       this.updateForm1080ReviewChecklistForm();

    }

    updateForm1080ReviewChecklistForm() :void {
        const form1080AFlag =  this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080a'  && item.status === 'Yes' && item.shownoshow === 'YES'));
        const form1080BFlag = this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080b'  && item.status === 'Yes' && item.shownoshow === 'YES'));
        const form1080CFlag = this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080c'  && item.status === 'Yes' && item.shownoshow === 'YES'));

        this.reviewCheckListForm.patchValue({ form1080a: false });
        if (form1080AFlag) {
            this.reviewCheckListForm.patchValue({ form1080a: true });
        }

        this.reviewCheckListForm.patchValue({ form1080b: false });
        if (form1080BFlag) {
            this.reviewCheckListForm.patchValue({ form1080b: true });
        }

        this.reviewCheckListForm.patchValue({ form1080c: false });
        if (form1080CFlag) {
            this.reviewCheckListForm.patchValue({ form1080c: true });
        }
    }

    initARCaseSummaryForm() {
        this.ARCaseSummaryForm = this.formBuilder.group({
            neglect: [''],
            physical_abuse: [''],
            sexual_abuse: [''],
            mental_injury: [''],
            reason: [null],
            caseclosuresummaryid: [null],
            intakeserviceid: [null],
            referralreason: [null, Validators.required],
            riskissues: [null],
            recommendation: [null],
            interventionissues: [null],
            statusList: this.formBuilder.array([]),
            clientrefrdservices: [null],
            ARAssessmentClosureDate: [null],
            closuretypekey: [null, Validators.required],
            closuresubtypekey: [null],
            notes: [null],
            participants: [null]
        });

    }

    initARSummaryReportForm() {
        this.ARSummaryReportForm = this.formBuilder.group({
            personid: [null],
            allegation: [[]],
            investigationallegationid: [''],
            victim_explanation: [''],
            sibling_explanation: [''],
            guardian_explanation: [''],
            maltreator_explanation: [''],
            med_assessmnts: [''],
            expert_assessmnts: [''],
            law_enforcement_inv: [''],
            collateral_interviews: [''],
            criminal_history_inv: [''],
            home_conditions: [''],
        });
    }

    private initFindingsForm() {
        this.investigationFindingForm = this.formBuilder.group({
            jointinvestigation: false,
            summary: ['', Validators.required],
            remarks: [''],
            investigationid: [''],
            allegedperson: this.formBuilder.array([])
        });
        this.reviewCheckListForm = this.formBuilder.group({
            initalfacetoface: false,
            safec: false,
            canf: false,
            mfira: false,
            personrole: false,
            lateinitialcontact: false,
            legislativeReq: [''],
            emergncyStiuation: [''],
            forResonNotProvided: [''],
            notes: '',
            form1080a: [{value: false, disabled: true}],
            form1080b: [{value: false, disabled: true}],
            form1080c: [{value: false, disabled: true}],
            activeSenService: [{value: false, disabled: true}],
        });
    }

    getFindingList() {
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize,
                    where: {
                        investigationid: this.dsdsActionsSummary.da_investigationid
                    },
                    method: 'get'
                }),
                'Investigationallegations/getmaltreatmentfinding?filter'
            )
            .subscribe((res) => {
                if (res) {
                    this.investigation = res;
                    if (this.investigation.length > 0) {
                        this.submitBtn = true;
                    }
                    this.investigationAllegationList = res;
                    this.setFormValues();
                    if (this.investigation && Array.isArray(this.investigation) && this.investigation[0]) {
                        this.investigationFindingForm.patchValue({
                            jointinvestigation: this.investigation[0].jointinvestigation,
                            summary: this.investigation[0].investigationsummary,
                            remarks: this.investigation[0].notes

                        });
                    }
                }
            });
    }

    setFormValues() {
        const control: any = this.formBuilder.array([]);
        this.investigationFindingForm.removeControl('allegedperson');
        this.investigation.forEach((x, index) => {
            if (x.maltreators) {
                control.push(this.buildInvestigationForm(x, index));
            }
        });
        this.investigationFindingForm.addControl('allegedperson', control);
    }

    private buildInvestigationForm(x: any, index: any): FormGroup {
        const investFind: any = this.buildinvestform(x);
        let maltreatmentkey = '';
        let investFindType = null;
        let intentionalInjuryDesc = null;
        let findingComments = null;
        let isharm = null;
        let isHarmSubstantial = null;
        let harmDesc = null;
        if (x.findings) {
            maltreatmentkey = x.findings.map((item: { investigationfindingtypekey: any; }) => item.investigationfindingtypekey);
            investFindType = x.findings.map((item: { investigationfindingtypekey: any; }) => item.investigationfindingtypekey);
            intentionalInjuryDesc = x.findings.map((item: { intentionalinjurydesc: any; }) => item.intentionalinjurydesc);
            findingComments = x.findings.map((item: { findingcomments: any; }) => item.findingcomments);
            isharm = x.findings.map((item: { isharm: any; }) => item.isharm);
            isHarmSubstantial = x.findings.map((item: { isharmsubstantial: any; }) => item.isharmsubstantial);
            harmDesc = x.findings.map((item: { harmdesc: any; }) => item.harmdesc);
        }
        investFind.controls['maltreatmentkey'].patchValue(maltreatmentkey);
        investFind.controls['investigationfindingtypekey'].patchValue(investFindType);
        investFind.controls['intentionalinjurydesc'].patchValue(intentionalInjuryDesc);
        investFind.controls['findingcomments'].patchValue(findingComments);
        investFind.controls['isharm'].patchValue(isharm);
        investFind.controls['isharmsubstantial'].patchValue(isHarmSubstantial);
        investFind.controls['harmdesc'].patchValue(harmDesc);

        let maltreatorName = '';
        let relationShip = null;
        let displayname = null;
        let intakeservicerequestactorid: any = null;
        let maltreatmentid: any = null;
        if (x.maltreators) {
            maltreatorName = (x.maltreators[0]?.displayname) ? x.maltreators[0].displayname : '';
            relationShip = x.maltreators.map((item: { relationship: any; }) => item.relationship);
            displayname = x.maltreators.map((item: { displayname: any; }) => item.displayname);
            intakeservicerequestactorid = x.maltreators.map((item: { intakeservicerequestactorid: any; }) => item.intakeservicerequestactorid);
            maltreatmentid = x.maltreatmentid;
        }
        investFind.controls['maltreatorName'].patchValue(maltreatorName);
        investFind.controls['relationship'].patchValue(relationShip);
        investFind.controls['allegation'].patchValue(displayname);
        investFind.controls['intakeservicerequestactorid'].patchValue(intakeservicerequestactorid);
        investFind.controls['maltreatmentid'].patchValue(maltreatmentid);
        const alleagation = this.investigationAllegationList.find((al: { maltreatmentid: any; }) => al.maltreatmentid === maltreatmentid);

        let appealData = null;
        if (alleagation) {
            const maltreators = alleagation.maltreators ? alleagation.maltreators : null;
            appealData = maltreators.find((mal: { intakeservicerequestactorid: any; }) => intakeservicerequestactorid.includes(mal.intakeservicerequestactorid));
            if (appealData) {
                const hasHeader = !!appealData.scdecisiontypekey;
                const hasOverride = !!appealData.overridefindingtypekey;
                investFind.controls['isAppealDone'].patchValue(hasHeader);
                investFind.controls['isFinalizeDone'].patchValue(hasOverride);

            }
        }
        investFind['maltreator'] = x.maltreators[0];
        return investFind;
    }

    buildinvestform(x: any) {
        return this.formBuilder.group({
            personid: x.personid ? x.personid : '',
            investigationallegationid: x.investigationallegationid ? x.investigationallegationid : null,
            personname: x.personname ? x.personname : '',
            name: x.name ? x.name : '',
            relationship: '',   //x.relationship ? x.relationship : '',
            maltreatmentkey: '',
            investigationfindingtypekey: '',
            allegation: '',     //x.allegation ? x.allegation : '',
            intentionalinjurydesc: '',
            findingcomments: '',
            isharm: '',
            isharmsubstantial: '',
            harmdesc: '',
            investigationfindings: '',
            ischildfatality: x.ischildfatality ? x.ischildfatality : 0,
            victim_explanation: x.victim_explanation ? x.victim_explanation : '',
            sibling_explanation: x.sibling_explanation ? x.sibling_explanation : '',
            guardian_explanation: x.guardian_explanation ? x.guardian_explanation : '',
            maltreator_explanation: x.maltreator_explanation ? x.maltreator_explanation : '',
            med_assessmnts: x.med_assessmnts ? x.med_assessmnts : '',
            expert_assessmnts: x.expert_assessmnts ? x.expert_assessmnts : '',
            law_enforcement_inv: x.law_enforcement_inv ? x.law_enforcement_inv : '',
            collateral_interviews: x.collateral_interviews ? x.collateral_interviews : '',
            criminal_history_inv: x.criminal_history_inv ? x.criminal_history_inv : '',
            home_conditions: x.home_conditions ? x.home_conditions : '',
            intakeservicerequestactorid: null,
            isAppealDone: false,
            isFinalizeDone: false,
            maltreatmentid: null,
            maltreatorName: ''

        });
    }

    openReportDialog(index: any): void {
        this.reportflag = index;
    }

    commarValidation() {
        this.submitForReview = Object.assign(new SubmitForReview(), this.investigationFindingForm.value);
        this.submitForReview.investigationid = this.dsdsActionsSummary.da_investigationid;
        if (this.investigation && Array.isArray(this.investigation) && this.investigation.length) {
            this.submitForReview.maltreatmentid = this.investigation[0].maltreatmentid;
        }

        if (this.submitForReview.allegedperson) {
            this.submitForReview.allegedperson = this.submitForReview.allegedperson.map((data) => {
                return Object.assign({
                    personid: data.personid,
                    investigationallegationid: data.investigationallegationid,
                    ischildfatality: Number(data.ischildfatality),
                    victim_explanation: data.victim_explanation,
                    sibling_explanation: data.sibling_explanation,
                    guardian_explanation: data.guardian_explanation,
                    maltreator_explanation: data.maltreator_explanation,
                    med_assessmnts: data.med_assessmnts,
                    expert_assessmnts: data.expert_assessmnts,
                    law_enforcement_inv: data.law_enforcement_inv,
                    collateral_interviews: data.collateral_interviews,
                    criminal_history_inv: data.criminal_history_inv,
                    home_conditions: data.home_conditions,
                });
            });
        }
    }

    saveInvestigation(isAutoSave?: any) {
        this.commarValidation();
        if (this.ARSummaryReportForm.valid) {
            this.investigationFindingForm.markAsPristine();
            this._commonHttpService.create(this.submitForReview, 'investigationmaltreatment/addfindings').subscribe(
                (result) => {
                    this.currentfindings = this.investigationFindingForm.getRawValue().allegedperson;
                    if (!isAutoSave) {
                        this.isARAutoSaveFlag = false;
                        this._alertService.success('AR summary saved successfully!');
                        this.getFindingList();
                    } else {
                        this.lastUpdatedTime = moment().format('MMM Do YY, h:mm:ss a');
                        this.isARAutoSaveFlag = true;
                        this._alertService.success('AR summary auto saved successfully! Please continue typing and click \'SAVE\' to complete.');
                    }
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    getCountyList() {
        this._commonHttpService.create({
            where: {
                activeflag: '1',
                state: 'MD'
            },
            order: 'countyname asc',
            nolimit: true
        }, 'admin/county/countylist').subscribe((item) => {
            if (item && item.length) {
                this.countyList = item.filter((res: { countyid: string; }) => res.countyid === this.countyid);
            }
        });
    }

    async downloadCasePdf(_val: any) {
        const pages: any = document.getElementsByClassName('pdf-page');
        let pageImages: any = [];
        for (let i = 0; i < pages.length; i++) {
            const pageName = pages.item(i).getAttribute('data-page-name');
            const isPageEnd = pages.item(i).getAttribute('data-page-end');
            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
                if (isPageEnd === 'true') {
                    this.pdfFiles.push({ fileName: pageName, images: pageImages });
                    pageImages = [];
                }
            });
        }
        this.convertImageToPdf();
    }

    convertImageToPdf() {
        this.pdfFiles.forEach((pdfFile) => {
            let doc: any = null;
            if (pdfFile.fileName === 'AR Summary Report') {
                doc = new jsPDF('landscape');
            } else {
                doc = new jsPDF();
            }

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
        $('#docu-View').modal('hide'); // NOSONAR
        this.pdfFiles = [];
        this.downloadInProgress = false;
    }

    arSummaryPrint() {
        this.downloadInProgress = true;
        this.nameTest = 'TEST';
        const pdfList = this.documentsToDownload;
        pdfList.forEach((element) => {
            this.downloadCasePdf(element);
        });
        $('#arSummaryPrint').modal('show'); // NOSONAR
    }

    closeView() {
        $('#arSummaryPrint').modal('show'); // NOSONAR
    }

    onChangeIllegalActivityMain($event: any) {
        this.illegalActivityDd = $event.target.checked;
        if (this.illegalActivityDd) {
            this.buildCheckBox();
        } else {
            this.selectedIllegalActivities = [];
        }
    }
    changeSignificantEvent($event: any) {
        this.significantEventDd = $event.target.checked;
        if (this.significantEventDd) {
            this.reportSummaryForm.patchValue({
                significantkey: this.reportSummary?.servicerequestincidenttypekey ? this.reportSummary?.servicerequestincidenttypekey : ''
            });
        } else {
            this.reportSummaryForm.value.significantkey = null;
        }
    }
    onChangeIllegalActivity($event: any) {
        if ($event.target.checked) {
            this.selectedIllegalActivities.push($event.target.value);
        } else {
            this.selectedIllegalActivities.splice($event.target.value, 1);
        }
    }
    saveReportSummary() {
        const userId = this._authService.getCurrentUser().userId;
        const caseWorkReportSummary = new CaseWorkReportSummary();
        caseWorkReportSummary.servicerequestincidenttypekey = this.reportSummaryForm.value.significantkey ? this.reportSummaryForm.value.significantkey : null;
        const addedItems = this.selectedIllegalActivities.map(id => {
            const illegalactivity: any = this.reportSummary?.intakeservicerequestillegalactivity?.filter((item, index, array) => {
                return item.intakeservicerequestillegalactivitytypekey === id;
            });
            if (!illegalactivity.length) {
                return new Illegalactivity({
                    activeflag: 1,
                    effectivedate: new Date(),
                    insertedby: userId,
                    intakeservicerequestillegalactivitytypekey: id,
                    intakeservicerequestid: this.reportSummary?.intakeserviceid,
                    updatedby: userId
                });
            } else {
                return new Illegalactivity({
                    activeflag: 1,
                    effectivedate: new Date(),
                    insertedby: userId,
                    intakeservicerequestillegalactivitytypekey: id,
                    intakeservicerequestid: this.reportSummary?.intakeserviceid,
                    intakeservicerequestillegalactivityid: this.reportSummary?.intakeservicerequestillegalactivity?.[0].intakeservicerequestillegalactivityid,
                    updatedby: userId
                });
            }
        });
        caseWorkReportSummary.intakeservicerequestillegalactivity = [];
        caseWorkReportSummary.intakeservicerequestillegalactivity.push(...addedItems);
        caseWorkReportSummary.suspiciousdeath = this.reportSummaryForm.value.suspiciousdeath;
        caseWorkReportSummary.missingpersons = this.reportSummaryForm.value.missingpersons;
        caseWorkReportSummary.effectivedate = new Date();
        this._commonHttpService.update(this.reportSummary?.intakeserviceid ??'', caseWorkReportSummary, CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary?.UpdateReportSummary).subscribe(
            responce => {
                this._alertService.success('Report summary updated successfully');
                this.listReportSummary(this.id);
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    readNarrative() {
        if (this.voiceNotStarted) {
            const narrativeText = $('#reportSummaryNarrative').text();
            this._speechSynthesizer.speak(narrativeText, 'en-US');
            this.voiceNotStarted = false;
            this.paused = false;
            this.speaking = true;
        } else if (this.speaking) {
            this._speechSynthesizer.pause();
            this.paused = true;
            this.speaking = false;
        } else if (this.paused) {
            this._speechSynthesizer.resume();
            this.paused = false;
            this.speaking = true;
        }
    }

    private formInitilizer(reportSummary: ReportSummary) {
        this.reportSummaryForm = this.formBuilder.group({
            suspiciousdeath: [reportSummary?.suspiciousdeath ? reportSummary?.suspiciousdeath : false],
            missingpersons: [reportSummary?.missingpersons ? reportSummary?.missingpersons : false],
            significantkey: [reportSummary?.servicerequestincidenttypekey ? reportSummary?.servicerequestincidenttypekey : '']
        });
    }
    private listReportSummary(id: string) {
        this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + this.id).subscribe(result => {
            this.reportSummary = result;
            if (this.reportSummary?.narrative) {
                this.reportSummary.narrative = this.reportSummary?.narrative.replace('<a', '<a target="_blank"');
            }
            const reportSummaryDanger = this.reportSummary?.intakeservicerequestactor.filter(item => {
                return item?.actor?.Person?.dangerlevel === 1;
            });
            this.disableNo = false;
            if (reportSummaryDanger.length !== 0) {
                this.disableNo = true;
            }
            const reportSummaryDangerAddress = this.reportSummary?.intakeservicerequestactor.filter(item => {
                return (
                    item?.actor?.Person?.personaddress?.filter(res => {
                        return res.danger === true;
                    }).length !== 0
                );
            });
            if (reportSummaryDangerAddress.length !== 0) {
                this.disableAddress = true;
            } else {
                this.disableAddress = false;
            }
            if (result.servicerequestincidenttypekey) {
                this.significantEventDd = true;
            }
            if (result.intakeservicerequestillegalactivity?.length) {
                this.illegalActivityDd = true;
            }
            this.possibleIllegalActivityDropdown = this.buildCheckBox();
        });
        if (this._authService.isCW()) {
            this.isCW = true;
            this.legalGuardianCheck();
            this.getInvolvedUnkPerson();
        }
    }

    legalGuardianCheck() {
        this.isLGPresent = false;
        this.missinglegalRole = [];
        this.involvedPersons$ = this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeservreqid: this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            ).pipe(
                share(),
                pluck('data'));
        this.involvedPersons$.subscribe((items) => {
            if (items) {
                if ((['CPS-IR', 'CPS-AR'].includes(this.dsdsActionsSummary?.da_subtype)) && !(this?.reviewCheckListForm?.controls?.initalfacetoface?.value)) {
                    this.caseclosureuntimely(items);
                }
                this.getInvolvedChildrenAndOthers(items);
                items.forEach((item) => {
                    const roles = item.roles;
                    roles.forEach((element: { intakeservicerequestpersontypekey: string; }) => {
                        if (element.intakeservicerequestpersontypekey === 'LG') {
                            this.missinglegalRole.push(item);
                        }
                    });

                });
            }
            if (!(this.missinglegalRole && this.missinglegalRole.length > 0)) {
                this.isLGPresent = true;
                $('#legal-guardian-role').modal('show');
            } 
        });
    }

    getInvolvedUnkPerson() {
        this.isUnkPresent = false;
        // intakeserviceid is bound to a uuid parameter, so an unresolved CASE_UID
        // 400s instead of returning an empty list. The isCW() block that calls this
        // sits outside the listReportSummary subscribe, so this.id is unchecked.
        if (!isCaseUuid(this.id)) {
            return;
        }
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeserviceid: this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .UnkPersonList + '?filter'
            )
            .subscribe(data => {
                this.involevedUnkPerson = data;
                if (this.involevedUnkPerson) {
                    const unkPersonList = this.involevedUnkPerson.filter(item => item.isNew);
                    if (unkPersonList && unkPersonList.length > 0) {
                        this.isUnkPresent = true;
                        $('#legal-guardian-role').modal('show'); 
                    }
                }
            });
    }

    private buildCheckBox(): FormArray {
        let selectedIllActs: any[] = [];
        if (this.reportSummary?.intakeservicerequestillegalactivity && this.reportSummary?.intakeservicerequestillegalactivity.length) {
            selectedIllActs = this.reportSummary?.intakeservicerequestillegalactivity.map(item => {
                return item.intakeservicerequestillegalactivitytypekey;
            });
        }
        this.selectedIllegalActivities = selectedIllActs;
        return ControlUtils.buildCheckBoxGroup(this.formBuilder, this.possibleCheckboxItems, selectedIllActs);
    }

    getInvolvedChildrenAndOthers(invlovedPersonsList: any) {
        invlovedPersonsList.map((item: any, $index: any) => {
            if (
                item.rolename !== 'AV' &&
                item.rolename !== 'AM' &&
                item.rolename !== 'CHILD' &&
                item.rolename !== 'RC' &&
                item.rolename !== 'BIOCHILD' &&
                item.rolename !== 'NVC' &&
                item.rolename !== 'OTHERCHILD' &&
                item.rolename !== 'PAC'

            ) {
                this.involvedOthers.push(item);
            } else {
                this.involvedChildren.push(item);
            }

            const checkExist = this.involvedPersons?.filter(data => data.personid === item.personid);
            if (checkExist && checkExist.length === 0) {
                this.involvedPersons.push(item);
            }

            if (item.rolename === 'LG') {
                this.LegalGuardian = (this.LegalGuardian ? this.LegalGuardian : '') + ($index !== 0 ? ', ' : '') + item.firstname + ' ' + item.lastname;
            }
        });
        this.getARSummaryCase();
    }

    loadReasonDropDown() {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 101, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {
                this.reasonDropDown = data;

            });
    }

    loadStatusDropDown() {

        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 102, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {

                this.closureSubTypeItems = data.map(
                    res =>
                        new DropdownModel({
                            text: res.value_text,
                            value: res.ref_key
                        })
                );

                const status = <FormArray>this.ARCaseSummaryForm.controls['statusList'];
                this.closureSubTypeItems.forEach(c => {
                    status.push(new FormControl(false));
                });
                this.statusDropDown = data;
            });
    }

    unchecksubtypes() {
        const status = <FormArray>this.ARCaseSummaryForm.controls['statusList'];
        this.closureSubTypeItems.forEach(function (c, index) {
            status.removeAt(0);
        });
        this.closureSubTypeItems.forEach(function (c, index) {
            status.push(new FormControl(false));
        });
    }

    loadServiceDropDown() {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 103, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {
                this.serviceDropDown = data;
            });
    }

    getRiskDropDown(array: any) {
        const riskDropDown: any[] = [];
        if (array && array.length) {
            array.forEach((data: any) => {
                const obj = data;
                riskDropDown.push(obj);
            });
        }
        return riskDropDown ? riskDropDown : [];
    }


    setRiskDropDown(array: any) {
        const riskDropDown: any[] = [];
        if (array && array.length) {
            const arryriskdropdown = array.split(',');
            arryriskdropdown.forEach((data: any) => {
                riskDropDown.push(data);
            });
        }
        return riskDropDown ? riskDropDown : [];
    }

    chooseAssessmentParticipant(event: any, child: any, isChild: any) {
        let participantObj;
        if (event.checked) {
            this.AssessmentParticipanttext = false;
            participantObj = {
                intakeservicerequestactorid: child.intakeservicerequestactorid,
                ischild: isChild
            };
        } else if (!event.checked && this.AssessmentParticipant && this.AssessmentParticipant.length) {
            this.AssessmentParticipanttext = true;
            for (let i = 0; i < this.AssessmentParticipant.length; i++) {
                if (this.AssessmentParticipant[i].intakeservicerequestactorid === child.intakeservicerequestactorid) {
                    this.AssessmentParticipant.splice(i, 2);
                }
            }
        }
        if (!(this.AssessmentParticipant && this.AssessmentParticipant.length)) {
            this.AssessmentParticipant = [];
        } 
        if (event.checked) {
            this.AssessmentParticipant.push(participantObj);
        } else {
            const index = this.AssessmentParticipant.findIndex(p => p.intakeservicerequestactorid === child.intakeservicerequestactorid);
            this.selectedChild.splice(index, 1);
        }
    }
    chooseChildren(event: any, child: any) {
        if (event.checked) {
            this.selectedChild.push(child.intakeservicerequestactorid);
        } else {
            const selectedItem = child.intakeservicerequestactorid;
            const index = this.selectedParticipant.indexOf(selectedItem);
            this.selectedChild.splice(index, 1);
        }
    }
    chooseParticipant(event: any, participant: any) {
        if (event.checked) {
            this.selectedParticipant.push(participant.intakeservicerequestactorid);
        } else {
            const selectedItem = participant.intakeservicerequestactorid;
            const index = this.selectedParticipant.indexOf(selectedItem);
            this.selectedParticipant.splice(index, 1);
        }
    }

    getdata(persons: any) {
        if (persons) {
            this.getMaltreatorInfo(persons); //SonarQube - moved this to seperate function
        }
        if (!this.maltreator) {
            this.maltreator = [];
            this.maltreator.displayname = 'Unnamed Unnamed';
            this.maltreator.gendertypedesc = 'Unkown';
            if (this.investigationFind && this.investigationFind.maltreator) {
                this.maltreator.cjamspid = this.investigationFind.maltreator.cjamspid;
            }
        }
    }
    getMaltreatorInfo(persons: any) {
        const allegedarray = persons.filter((person: { personid: any; }) => person.personid === this.investigationFind.value.personid);
        this.selectedallegedperson = allegedarray[0];

        if (this.selectedallegedperson && this.selectedallegedperson.race) {
            let allegedrace = Array.isArray(this.selectedallegedperson.race) ? this.selectedallegedperson.race : [];
            allegedrace = allegedrace.map((item: { value_text: any; }) => item.value_text);
            allegedrace = Array.from((new Set(allegedrace)).values());
            this.selectedallegedperson.raceList = [...allegedrace];
        }
        var mal: any;
        if (this.investigationFind.maltreator) {
            persons.forEach((person: { personid: any; }) => {
                if (person.personid === this.investigationFind.maltreator.personid) {
                    mal = person;
                    mal['displayname'] = this.getFullName(person);
                }
            });
        }
        this.maltreator = mal;
        if (this.maltreator && this.maltreator.race) {
            let maltreatorrace = Array.isArray(this.maltreator.race) ? this.maltreator.race : [];
            maltreatorrace = maltreatorrace.map((item: { value_text: any; }) => item.value_text);
            maltreatorrace = Array.from((new Set(maltreatorrace)).values());
            this.maltreator.raceList = [...maltreatorrace];
        }
    }

    getFullName(person: any) {
        const nameKeys = ['prefx', 'firstname', 'middlename', 'lastname', 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
            if (person && person.hasOwnProperty(key)) {
                if (person[key] != null && person[key] != 'null' && person[key] != '') {
                    name = name + person[key] + ' ';
                }
            }
        });
        return name;
    }

    getcomardata() {
        if (!this.investigationFind?.value?.investigationfindings) {
            return;
        }
        const key = this.investigationFind.value.investigationfindings[0].investigationfindingtypekey;
        const type = this.investigationFind.value.name ? this.investigationFind.value.name.toUpperCase() : this.investigationFind.value.name;

        if (key === 'ID') { //SonarQube code complexity change - moved the entire logic to multiple small functions
            this.getComarFindingsKeyID(type);
        }

        if (key === 'RO') {
            this.getComarFindingsKeyRO(type);
        }

        if (key === 'UD') {
            this.getComarFindingsKeyUD(type);

        }
    }

    getComarFindingsKeyID(type: string) {
        if (type === this.mentalinjuryabuse) {
            this.comarFindingsKey = 'MENTAL-INJURY-ABUSE-ID';
        } else if (type === this.mentalinjuryneglect) {
            this.comarFindingsKey = 'MENTAL-INJURY-NEGLECT-ID';
        } else if (type === 'NEGLECT') {
            this.comarFindingsKey = 'NEGLECTID';
        } else if (type === this.physicalabuse) {
            this.comarFindingsKey = 'PHYSICAL-ABUSEID';
        } else if (type === this.sexualabuse && this.investigationFind.value.sextrafficking === 0) {
            this.comarFindingsKey = 'SEXUAL-ABUSEID';
        } else if (type === this.sexualabuse && this.investigationFind.value.sextrafficking === 1) {
            this.comarFindingsKey = 'SEX-TRAFFICKING-INDICATED';
        }
    }

    getComarFindingsKeyRO(type: string) {
        if (type === this.mentalinjuryabuse) {
            this.comarFindingsKey = 'MENTAL-INJURY-ABUSE-RO';
        } else if (type === this.mentalinjuryneglect) {
            this.comarFindingsKey = 'MENTAL-INJURY-NEGLECT-RO';
        } else if (type === 'NEGLECT') {
            this.comarFindingsKey = 'NEGLECTRO';
        } else if (type === this.physicalabuse) {
            this.comarFindingsKey = 'PHYSICAL-ABUSERO';
        } else if (type === this.sexualabuse && this.investigationFind.value.sextrafficking === 0) {
            this.comarFindingsKey = 'SEXUAL-ABUSERO';
        } else if (type === this.sexualabuse && this.investigationFind.value.sextrafficking === 1) {
            this.comarFindingsKey = 'SEX-TRAFFICKING-RULED-OUT';
        }
    }

    getComarFindingsKeyUD(type: string) {
        if (type === this.mentalinjuryabuse) {
            this.comarFindingsKey = 'MENTAL-INJURY-ABUSE-UD';
        } else if (type === this.mentalinjuryneglect) {
            this.comarFindingsKey = 'MENTAL-INJURY-NEGLECT-UD';
        } else if (type === 'NEGLECT') {
            this.comarFindingsKey = 'NEGLECTUD';
        } else if (type === this.physicalabuse) {
            this.comarFindingsKey = 'PHYSICAL-ABUSEUD';
        } else if (type === this.sexualabuse && this.investigationFind.value.sextrafficking === 0) {
            this.comarFindingsKey = 'SEXUAL-ABUSEUD';
        } else if (type === this.sexualabuse && this.investigationFind.value.sextrafficking === 1) {
            this.comarFindingsKey = 'SEX-TRAFFICKING-UNSUBSTANTIATED';
        }
    }

    victimInfo(person: InvolvedPerson[]) {

        this.personComar.victimname = '';
        this.personComar.caretakername = '';
        this.personComar.victimdob = null;
        let victimdob = null;

        if (person) {
            const careTaker = person.filter((res) => {
                return res.roles.length && res.roles.filter((role) => role.intakeservicerequestpersontypekey === 'CARTKR').length;
            });
            this.personComar.caretakername = '';
            if (careTaker.length > 0) {
                this.personComar.caretakername = careTaker[0].firstname + ' ' + careTaker[0].lastname;
            }

            this.personComar.victimdob = null;
            const personData: any = person.filter((item) => item.personid === this.investigationFind.value.personid);
            if (personData.length > 0) {
                this.personComar.victimdob = new Date(personData[0].dob);
                if (this.personComar.victimdob) {
                    victimdob = moment(this.personComar.victimdob).format(this.dtformat);
                }
            }

            this.personComar.victimname = this.investigationFind.value.personname;
        }
        this.reportcomarfindings = _.cloneDeep(ComarFindings.ComarFindingsList[this.comarFindingsKey]);

        const harmchild = (this.investigationFind.value.investigationfindings[0]?.isharm === 1 ? 'Yes' : 'No');
        const riskofharm = (this.investigationFind.value.investigationfindings[0]?.isharmsubstantial === 1 ? 'Yes' : 'No');
        const caretakername = this.investigationFind.value.investigationfindings[0]?.omissiondesc ? this.investigationFind.value.investigationfindings[0].omissiondesc : '';

        if (this.reportcomarfindings) {
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${comar?.victimname}', this.personComar.victimname);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${comar?.victimdob}', victimdob);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${harmchild}', harmchild);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${riskofharm}', riskofharm);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${circumstancescomments}',
                this.investigationFind.value.investigationfindings[0].harmdesc);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${intentionalinjurydesc}',
                this.investigationFind.value.investigationfindings[0].intentionalinjurydesc);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${comar?.caretakername}', caretakername);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${findingcomments}',
                this.investigationFind.value.investigationfindings[0].findingcomments);
        }
    }

    getErrorsMessage(ControlName: any, displayName: any) {
        if (this.ARCaseSummaryForm?.controls[ControlName].status === 'INVALID') {
            return 'Please enter valid ' + displayName
        }
    }

    getSupervisorApprovalInfo() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        if (this.id) {
            this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        page: 1,
                        limit: 100,
                        where: {
                            servicerequestid: this.id
                        },
                        method: 'get'
                    }),
                    'Intakeservicerequestdispositioncodes/GetHistory?filter'
                )
                .subscribe((item) => {
                    if (item) {
                        this._dataStoreService.setData('SupervisorApprovalDetails', item.data);
                    }

                }
                );
        }
    }
    getChildrenInvolved(person: InvolvedPerson[]) {
        this.children = [];
        if (person) {
            this.children = person.filter((item) => (item.rolename === 'CHILD'));
        }
        this._dataStoreService.setData('ChildrenInvolved', this.children);
    }

    getOthersInvolved(person: InvolvedPerson[]) {
        this.others = [];
        if (person) {

            this.others = person.filter((res) => {
                const tempRole = res.roles.filter((role) => {
                    if ((role.intakeservicerequestpersontypekey !== 'AM' && role.intakeservicerequestpersontypekey !== 'LG' && role.intakeservicerequestpersontypekey !== 'AV' && role.intakeservicerequestpersontypekey !== 'CHILD')) {
                        res.rolename = role.typedescription;
                        return true;
                    }
                });
                return res.roles.length && tempRole.length;
            })
        }
        this._dataStoreService.setData('OthersInvolved', this.others);
    }

    getCountyName(id: any) {
        const countyvalue: any = this.countyList.filter((countyId: {countyid: any}) => countyId.countyid === id);
        if (countyvalue[0]) {
            return countyvalue[0].countyname;
        }
        return '';
    }

    getPrintData(investigationFind: any) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.dsdsobject = this._dataStoreService.getData('object');
        this.investigationFind = investigationFind;

        this.investigation = investigationFind.getRawValue();
        this.getdata(this.involvedPersons);

        this.getcomardata();
        this.getChildrenInvolved(this.involvedPersons);
        this.getOthersInvolved(this.involvedPersons);
        this.victimInfo(this.involvedPersons);

        this.printData['currentDate'] = moment(this.currentDate).format(this.dtformat);
        this.printData['dsdsobject'] = this.dsdsobject ? this.dsdsobject : null;
        this.printData['countyname'] = this.getCountyName(this.dsdsobject?.countyid ? this.dsdsobject.countyid : null);
        this.printData['investigationFind'] = this.investigationFind.getRawValue();
        this.printData['investigation'] = this.investigation;
        this.printData['maltreator'] = this.maltreator ? this.maltreator : null;
        this.printData['selectedallegedperson'] = this.selectedallegedperson ? this.selectedallegedperson : null;
        this.printData['supervisorApprovalDetails'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_SUPERVISOR_APPROVAL);
        this.printData['reportcomarfindings'] = this.reportcomarfindings ? this.reportcomarfindings.value : null;
        this.printData['children'] = this.involvedChildren.filter(child => child.isChecked === true && child.rolename === 'CHILD');
        this.printData['others'] = this.involvedPersons.filter(person => person.isChecked === true && person.rolename !== 'CHILD');
        this.printData['referralReason'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_REFERRAL_REASON);
        this.printData['assessmentdate'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_ASSESSMENT_DATE);
        this.printData['closureDate'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_CLOSURE_DATE);
        this.printData['recommendation'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_RECOMMENDATION);
        this.printData['reason'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_REASON_TEXT);
        this.printData['closuretype'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_CLOSURE_TYPE);
        this.printData['riskissues'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_RISK_ISSUES);
        this.printData['notes'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_NOTES);
        this.printData['status'] = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_STATUS);
        const serviceninterventions = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_SERVICES_INTERVENTIONS);
        this.printData['servicelist'] = serviceninterventions;

        this.printData['ClosureDate'] = this.printData['ClosureDate'] ? moment(this.printData['ClosureDate']).format(this.dtformat) : null
        if (this.printData['supervisorApprovalDetails'] == null || this.printData['supervisorApprovalDetails'] === undefined) {
            this.printData['supervisorApprovalDetails'] = [];
        }
        this.printData['supervisorApprovalDetails'].map((element: any) => {
            element.displaydate = element.displaydate ? moment(element.displaydate).format(this.dtformat) : '';
        });
        this.printData['others'].map((element: any) => {
            element.dob = this.getDOB(element.dob);
        });

        this.printData['children'].map((element: any) => {
            element.dob = this.getDOB(element.dob);
        });
    }

    getDOB(dob: any) {
        return dob ? moment(dob).format(this.dtformat) : '';
    }

    async downloadARSummaryPdf(investigationFind: any) {
        this.getPrintData(investigationFind);
        const inputRequest: any = {
            investigationsummaryreport: this.printData,
            isheaderrequired: false,
            documntkey: 'invsummaryreport'
        };
        inputRequest['name'] = 'AR Summary Report-' + (this.dsdsobject ? this.dsdsobject.da_number : '');

        inputRequest.investigationsummaryreport['dsdsobject'].da_receiveddate = inputRequest.investigationsummaryreport['dsdsobject'].da_receiveddate ? moment(inputRequest.investigationsummaryreport['dsdsobject'].da_receiveddate).format(this.dtformat) : '';
        inputRequest.investigationsummaryreport['maltreator'].dob = inputRequest.investigationsummaryreport['maltreator'].dob ? moment(inputRequest.investigationsummaryreport['maltreator'].dob).format(this.dtformat) : '';
        inputRequest.investigationsummaryreport['assessmentdate'] = inputRequest.investigationsummaryreport['assessmentdate'] ? moment(inputRequest.investigationsummaryreport['assessmentdate']).format(this.dtformat) : '';

        const payload = {
            method: 'post',
            count: -1,
            page: 1,
            limit: 20,
            where: inputRequest,
        };
        this._commonHttpService.create(payload, 'Investigationfindings/downloadInvestigationSummaryReport').subscribe(
            (response) => {
                if (response) {
                    window.open(response.data.documentpath, '_blank');
                }
            }
        );
    }

    saveARCAseSummary(arStatus: string, caseCreatedDate?: any, isAutosave?: any) {
        this.ARCaseSummaryForm.markAllAsTouched();
        if (!this.isCaseValid()) {
            return;
        }

        this.ARCaseSummaryForm.patchValue({
            participants: this.AssessmentParticipant ? this.AssessmentParticipant : [],
            caseclosuresummaryid: this.caseclosuresummaryid
        });

        const ARCaseSummaryData = this.ARCaseSummaryForm.getRawValue();
        if (arStatus === 'summarySave') {
            ARCaseSummaryData.isapprove = false;
        } else if (arStatus === 'Submitted') {
            ARCaseSummaryData.assignsecurityuserid = this.selectedSupervisor;
            ARCaseSummaryData.isapprove = true;
        } else if (arStatus === 'accepted') {
            ARCaseSummaryData.isapprove = true;
        } else if (arStatus === 'Rejected') {
            ARCaseSummaryData.isapprove = true;
        }
        ARCaseSummaryData.arStatus = arStatus;
        this.statusTempDropDown = [];
        ARCaseSummaryData.statusList.forEach((item: any, index: any) => {
            if (item) {
                this.statusTempDropDown.push(this.closureSubTypeItems[index].value);
            }
        });
        ARCaseSummaryData.closuresubtypekey = this.statusTempDropDown;
        ARCaseSummaryData.intakeserviceid = this.id;
        ARCaseSummaryData.interventionissues = this.getRiskDropDown(ARCaseSummaryData.interventionissues);
        ARCaseSummaryData.intakeserreqstatustypeid = this.dispositionFormGroup.getRawValue().statusid.split('~')[1];
        ARCaseSummaryData.dispostionid = this.dispositionFormGroup.getRawValue().dispositionid;

        this._commonHttpService
            .create(ARCaseSummaryData, 'caseclosuresummary/addupdate')
            .subscribe(response => {
                $('#list-supervisor').modal('hide'); // NOSONAR
                this.currentARCaseSummary = this.ARCaseSummaryForm.getRawValue();
                if (!isAutosave) {
                    this.isARCaseSummaryAutoSaveFlag = false;
                    this.getARSummaryCase();
                    this.updateARStatus(arStatus);
                } else {
                    this.lastUpdatedTime = moment().format('MMM Do YY, h:mm:ss a');
                    this.isARCaseSummaryAutoSaveFlag = true;
                    this.arStatus = 'Saved';
                    this._alertService.success('AR case summary auto saved successfully. Please continue typing and click \'SAVE\' to complete.');
                }
            });
    }
    isCaseValid() {
        if (!this.ARCaseSummaryForm.controls['referralreason'].valid) {
            this._alertService.error('Referral reason is required');
            return false;
        }

        if (!this.ARCaseSummaryForm.controls['closuretypekey'].valid) {
            // CIDM-8246: Removed arStatus check here as we need to show error message when case closure information is not given
            this._alertService.error('Closure status is required');
            return false;
        }

        if (!this.AssessmentParticipant) {
            this.AssessmentParticipanttext = true;
            this._alertService.error('Please select a participant');
            return false;
        }
        if (this.AssessmentParticipant && this.AssessmentParticipant.length === 0) {
            this.AssessmentParticipanttext = true;
            this._alertService.error('Please select a participant');
            return false;
        }

        return true;
    }

    updateARStatus(arStatus: string) {
        if ('Submitted' === arStatus) {
            this.arStatus = 'Submitted';
            this._alertService.success('AR case summary submitted for approval');
        } else if ('summarySave' === arStatus) {
            this.arStatus = 'Saved';
            this._alertService.success('AR case summary saved successfully');
        } else if ('accepted' === arStatus) {
            this.arStatus = 'Approved';
            this._alertService.success('AR case summary Approved successfully');
            this.closeCase();
        } else if ('Rejected' === arStatus) {
            this.arStatus = 'Rejected';
            this._alertService.success('AR case summary Rejected successfully');
        }
    }

    activateSpeechToText(type: string): void {
        this.currentSpeechRecInput = type;
        this.recognizing = true;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                (value) => {
                    this.speechData = value;
                    switch (type) {
                        case 'q1':
                            const comments = this.ARCaseSummaryForm.getRawValue().serviceProvidedAddress;
                            this.ARCaseSummaryForm.patchValue({ serviceProvidedAddress: comments + ' ' + this.speechData });
                            break;
                        case 'q2':
                            const comments1 = this.ARCaseSummaryForm.getRawValue().issuesRequiring;
                            this.ARCaseSummaryForm.patchValue({ issuesRequiring: comments1 + ' ' + this.speechData });
                            break;
                        case 'q3':
                            const comments2 = this.ARCaseSummaryForm.getRawValue().recommendationforFamily;
                            this.ARCaseSummaryForm.patchValue({ recommendationforFamily: comments2 + ' ' + this.speechData });
                            break;
                        default: break;
                    }
                },
                // errror
                (err) => {
                    console.error(err);
                    this.recognizing = false;
                    if (err.error === 'no-speech') {
                        this.notification = `No speech has been detected. Please try again.`;
                        this._alertService.warn(this.notification);
                        this.activateSpeechToText(type);
                    } else if (err.error === 'not-allowed') {
                        this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    } else if (err.error === 'not-microphone') {
                        this.notification = `Microphone is not available. Please verify the connection of your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    }
                },
                // completion
                () => {
                    this.speechRecogninitionOn = true;

                    this.activateSpeechToText(type);
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

    ngOnDestroy(): void {
        this._speechRecognitionService.destroySpeechObject();
        clearInterval(this._dataStoreService.getData('ARInvestigationTimer'));
    }

    isChildParticipantSelected(childActorId: any) {
        if (this.savedParticipants && this.savedParticipants.length) {
            this.savedParticipants.forEach((data, $index) => {
                if (data.intakeservicerequestactorid === childActorId) {
                    return true;
                }
            });
        }
        return false;
    }

    onChangeClosureStatus(value: string) {
        if (value === 'ONGS' || value === 'RRMS') {
            this.clientrefrdservicesdisabled = true;
            this.ARCaseSummaryForm.patchValue({ clientrefrdservices: '' });
            this.statuslistdisabled = true;
            this.unchecksubtypes();
        } else if (value === 'CONS') {
            this.clientrefrdservicesdisabled = false;
            this.statuslistdisabled = true;
            this.unchecksubtypes();
        } else if (value === 'LDSS') {
            this.clientrefrdservicesdisabled = true;
            this.ARCaseSummaryForm.patchValue({ clientrefrdservices: '' });
            this.statuslistdisabled = false;
        }
    }

    getARSummaryCase() {

        this.savedParticipants = [];
        this.savedIndividual = [];
        this._commonHttpService.getSingle({
            where: {
                intakeserviceid: this.id
            },
            method: 'get',
            page: 1,
            limit: 10
        }, 'caseclosureparticipant/getcaseclosurelist?filter').subscribe((item) => {

            if (!item) {
                return;
            }
            const summaryData = item?.length && Array.isArray(item) ? item[0] : null;

            if (summaryData) {
                this.buildARCaseSummaryForm(summaryData);
            }

            this.ARAssessmentClosureDate = summaryData.closuredate;

            this.caseclosuresummaryid = summaryData.caseclosuresummaryid;
            this.updateParticipants(summaryData);
            this.AssessmentParticipant = [];
            if (this.savedParticipants?.length && this.involvedChildren?.length) {
                this.updateAssessmentSavedParticipants();
            }
            if (this.savedIndividual?.length && this.involvedPersons?.length) {
                this.updateAssessmentSavedIndividualParticipants();
            }
            this.setARNarrativeStatus(summaryData);

            this.getSupervisorApprovalInfo();
            if (summaryData.interventionissues) {
                const riskData = this.setRiskDropDown(summaryData.interventionissues);
                this.ARCaseSummaryForm.patchValue({ interventionissues: riskData });
            }

            if (summaryData.clientrefrdservices) {
                const clientrefrdservicesdata = this.setRiskDropDown(summaryData.clientrefrdservices);
                this.ARCaseSummaryForm.patchValue({ clientrefrdservices: clientrefrdservicesdata });
            }

            setTimeout(() => {
                this.disableArSummaryForCaseWorker(summaryData);
            }, 0)

            setTimeout(() => {
                this.disableArSummaryForNonCaseWorker(summaryData);
            }, 0)
            this.updateStatusList(summaryData);
        });

    }

    buildARCaseSummaryForm(summaryData: any) {
        this._dataStoreService.setData('ARReferralReason', summaryData.referralreason);
        this._dataStoreService.setData('ARClosureDate', summaryData.closuredate);
        this._dataStoreService.setData('ARAssessmentDate', this.reportSummary?.insertedon);
        this._dataStoreService.setData('ARRecommendation', summaryData.recommendation);
        this._dataStoreService.setData('ARReasonText', summaryData.reason);
        const closuretype = this.reasonDropDown?.filter((res) => res.ref_key === summaryData.closuretypekey);
        if (closuretype && closuretype[0]) {
            this._dataStoreService.setData('ARClosureType', closuretype[0].description);
        }
        this._dataStoreService.setData('ARRiskIssues', summaryData.riskissues);
        this._dataStoreService.setData('ARNotes', summaryData.notes);


        if (summaryData.interventionissues && summaryData.interventionissues.length > 0) {
            const splitted: string[] = summaryData.interventionissues.split(",");
            splitted.forEach(element => {
                const item = this.serviceDropDown.filter((res) => element === res.ref_key);
                if (item && item.length) {
                    this.servicelist.push(item[0].description);
                }
            });
        }
        this._dataStoreService.setData('ARServicesInterventions', this.servicelist);

        this.ARCaseSummaryForm = this.formBuilder.group({
            reason: summaryData.reason,
            caseclosuresummaryid: summaryData.caseclosuresummaryid,
            intakeserviceid: summaryData.intakeserviceid,
            referralreason: summaryData.referralreason,
            riskissues: summaryData.riskissues,
            recommendation: summaryData.recommendation,
            statusList: this.formBuilder.array([]),
            clientrefrdservices: null,
            closuretypekey: summaryData.closuretypekey,
            ARAssessmentClosureDate: summaryData.closuredate,
            interventionissues: null,
            notes: summaryData.notes,
            participants: summaryData.participants ? summaryData.participants : null
        });

    }

    updateParticipants(summaryData: any) {
        if (summaryData.childparticipant) {
            for (const child of summaryData.childparticipant) { //SonarQube fix - changed it to `for-of` loop instead of a `for` loop.
                if (child) {
                    this.savedParticipants.push(child);
                }
            }
        }

        if (summaryData.individualparticipant) {
            for (const participant of summaryData.individualparticipant) {
                if (participant) {
                    this.savedIndividual.push(participant);
                }
            }
        }
    }

    updateAssessmentSavedParticipants() {
        if (this.savedParticipants[0]?.intakeservicerequestactorid) {
            for (const child of this.involvedChildren) {
                for (const savedParticipant of this.savedParticipants) {
                    if (child.intakeservicerequestactorid === savedParticipant.intakeservicerequestactorid) {
                        child.isChecked = true;
                        const participantObj = {
                            intakeservicerequestactorid: child.intakeservicerequestactorid,
                            ischild: 1
                        };
                        this.AssessmentParticipant.push(participantObj);
                    }
                }
            }
        }
    }

    updateAssessmentSavedIndividualParticipants() {
        if (this.savedIndividual[0]?.intakeservicerequestactorid) {
            for (const person of this.involvedPersons) {
                for (const saved of this.savedIndividual) {
                    if (person.intakeservicerequestactorid === saved.intakeservicerequestactorid) {
                        person.isChecked = true;
                        const participantObj = {
                            intakeservicerequestactorid: person.intakeservicerequestactorid,
                            ischild: 0
                        };
                        this.AssessmentParticipant.push(participantObj);
                    }
                }
            }
        }
    }

    setARNarrativeStatus(summaryData: any) {
        if (summaryData.closuretypekey === 'CONS') {
            this.statuslistdisabled = true;
        } else if (summaryData.closuretypekey === 'ONGS') {
            this.statuslistdisabled = true;
        } else if (summaryData.closuretypekey === 'LDSS') {
            this.statuslistdisabled = false;
        } else if (summaryData.closuretypekey === 'RRMS') {
            this.statuslistdisabled = true;
        }

        if (summaryData.routingstatustypeid === 15) {
            this.arsummaryStatus = 'Review';
        } else if (summaryData.routingstatustypeid === 16) {
            this.arsummaryStatus = 'Approved';
        } else if (summaryData.routingstatustypeid === 17) {
            this.arsummaryStatus = 'Rejected';
        } else {
            this.arsummaryStatus = 'Draft';
        }
        this._dataStoreService.setData('ARNarrativeStatus', this.arsummaryStatus);

    }
    disableArSummaryForCaseWorker(summaryData: any) {
        if (summaryData.disableArSummary && this.isCaseWorker) {
            this.apButton.nativeElement.disabled = true;
            this._renderer.addClass(this.apButton.nativeElement, 'disabled');
            this._renderer.addClass(this.apButton.nativeElement, 'btn');
            this._renderer.removeClass(this.apButton.nativeElement, 'btn-pri');
            if (summaryData.routingstatustypeid) {
                if (summaryData.routingstatustypeid === 15) {
                    this.arStatus = 'Submitted';
                } else if (summaryData.routingstatustypeid === 16) {
                    this.arStatus = 'Approved';

                } else if (summaryData.routingstatustypeid === 17) {
                    this.arStatus = 'Rejected';
                }
            }
        }
    }

    disableArSummaryForNonCaseWorker(summaryData: any) {
        if (summaryData.disableArSummary && !this.isCaseWorker) {
            if (summaryData.routingstatustypeid) {
                if (summaryData.routingstatustypeid === 15) {
                    this.arStatus = 'Submitted';
                } else if (summaryData.routingstatustypeid === 16) {
                    this.apButton.nativeElement.disabled = true;
                    this.rjButton.nativeElement.disabled = true;
                    this.arStatus = 'Approved';
                    this._renderer.addClass(this.apButton.nativeElement, 'disabled');
                    this._renderer.addClass(this.apButton.nativeElement, 'btn');
                    this._renderer.removeClass(this.apButton.nativeElement, 'btn-pri');
                    this._renderer.addClass(this.rjButton.nativeElement, 'disabled');
                    this._renderer.addClass(this.rjButton.nativeElement, 'btn');
                    this._renderer.removeClass(this.rjButton.nativeElement, 'btn-pri');
                } else if (summaryData.routingstatustypeid === 17) {
                    this.arStatus = 'Rejected';
                    this.apButton.nativeElement.disabled = true;
                    this.rjButton.nativeElement.disabled = true;
                    this._renderer.addClass(this.apButton.nativeElement, 'disabled');
                    this._renderer.addClass(this.apButton.nativeElement, 'btn');
                    this._renderer.removeClass(this.apButton.nativeElement, 'btn-pri');
                    this._renderer.addClass(this.rjButton.nativeElement, 'disabled');
                    this._renderer.addClass(this.rjButton.nativeElement, 'btn');
                    this._renderer.removeClass(this.rjButton.nativeElement, 'btn-pri');
                }
            }
        }

    }

    updateStatusList(summaryData: any) {
        const status = <FormArray>this.ARCaseSummaryForm.controls['statusList'];
        this.closureSubTypeItems.forEach(function (closuresubtype, index) {
            let resp = summaryData.closuresubtypekey;
            if (resp === null || resp === undefined) {
                resp = '';
            }
            const temp = resp.split(',');
            temp.map(function (sub: any, subindex: any) {
                if (closuresubtype.value === sub) {
                    status.push(new FormControl(true));
                }
            });
            if (status.length === index) {
                status.push(new FormControl(false));
            }
        });
    }


    loadSupervisor() {
        this.selectedSupervisor = '';
        const appEvent = 'INTR';
        const legislativeRequest = {

            legislativeid: this.legislative ? this.legislative.legislativeid : null,
            intakeserviceid: this.id,

            isinitialfacetoface: this.reviewCheckListForm.controls.initalfacetoface.value,
            isapprovedmfira: this.reviewCheckListForm.controls.mfira.value,
            isapprovedsafec: this.reviewCheckListForm.controls.safec.value,
            isapprovecansf: this.reviewCheckListForm.controls.canf.value,
            isvictimperpetrator: this.reviewCheckListForm.controls.personrole.value,
            islateinitialcontact: this.reviewCheckListForm.controls.lateinitialcontact.value,
            islegislativereporting: this.reviewCheckListForm.controls.legislativeReq.value,
            isdataentrynotes: this.reviewCheckListForm.controls.notes.value,
            isreasonnotprovided: this.reviewCheckListForm.controls.forResonNotProvided.value,
            isemergency: this.reviewCheckListForm.controls.emergncyStiuation.value,
            ...FormData
        }
        this._commonHttpService.getArrayList({
            legislative: legislativeRequest, method: 'post'
        },
            'legislative/addupdate').subscribe((item) => {
                this._gelegislativetData();
            })

        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.supervisorsList = result.data;
            });
        if (this.reviewCheckList && this.reviewCheckList.length > 0) {
            const checkList = this.conditionCheckList();
            $(this.investigationpopupid).modal('hide'); // NOSONAR
            if (checkList) {
                this.loadStatuses();
                $('#intake-caseassign').modal('show'); // NOSONAR
            }
        } else {
            $(this.investigationpopupid).modal('hide'); // NOSONAR
        }
    }
    onChangeSupervisor(supervisor: RoutingUser) {

        this.selectedSupervisor = supervisor.userid;
    }

    saveDisposition() {
        const dispositionModal = new DispositionAddModal();
        dispositionModal.disposition = Object.assign({
            intakeserviceid: this.id,
            intakeserreqstatustypeid: this.dispositionFormGroup.getRawValue().statusid.split('~')[1],
            dispostionid: this.dispositionFormGroup.value.dispositionid,
            reviewcomments: this.dispositionFormGroup.value.reviewcomments,
            closingcodetypekey: this.dispositionFormGroup.value.closingcodetypekey,
            supervisorid: this.dispositionFormGroup.getRawValue().tosecurityuserid,
            dateseen: new Date()
        });
        dispositionModal.investigation = {
            summary: '',
            filelocdesc: null,
            appevent: 'INVR'
        };
        this._dispositionAddService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.DispositionAddUrl;
        this._dispositionAddService.create(dispositionModal).subscribe(
            (response: any) => {
                this.dispositionFormGroup.reset();
                $('#intake-caseassign').modal('hide'); // NOSONAR
                this._alertService.success('Disposition updated successfully');
                observableTimer(2000).subscribe(() => {
                    this._router.routeReuseStrategy.shouldReuseRoute = function () {
                        return false;
                    };
                    const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/disposition';
                    this._router.navigateByUrl(currentUrl).then(() => {
                        this._router.navigated = false;
                        this._router.navigate([currentUrl]);
                    });
                });
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    private loadStatuses() {
        this.statusDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        intakeservreqtypeid: this.daType,
                        servicerequestsubtypeid: this.daType
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.StatusUrl + '?filter'
            ).pipe(
                map((result) => {
                    return result.map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.intakeserreqstatustypekey + '~' + res.intakeserreqstatustypeid
                            })
                    );
                }));
        this.statusDropdownItems$.subscribe(data => {
            const completeStatus: any = data.find(item => item.text === 'Completed');
            this.dispositionFormGroup.patchValue({
                statusid: completeStatus.value
            });
            this.loadDispositon(completeStatus.value);
            this.dispositionFormGroup.get('statusid')?.disable();
        });
    }
    loadDispositon(statusId: any) {
        const statusKey = statusId.split('~')[0];
        this.dispositionDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        statuskey: statusKey,
                        intakeservreqtypeid: this.daType,
                        servicerequestsubtypeid: this.daType
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.DispositionUrl + '?filter'
            ).pipe(
                map((result) => {
                    return result.map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.servicerequesttypeconfigiddispostionid
                            })
                    );
                }));
        this.dispositionDropdownItems$.subscribe(data => {
            this.dispositionDropdownItems = data;
            if (data && data.length) {
                const closuerDispositon = data.find(item => item.text === 'Recommend for closure');
                if (closuerDispositon) {
                    this.dispositionFormGroup.patchValue({
                        dispositionid: closuerDispositon.value
                    });
                }
            }
        });
    }
    confirmDisposition() {
        this.saveDisposition();

    }
    cancelConfirmDisposition() {
        $('#status-disposition').modal('show'); // NOSONAR
    }

    closeCase() {
        const intakeserreqstatustypeid = this.dispositionFormGroup.getRawValue().statusid.split('~')[1];
        const dispostionid = this.dispositionFormGroup.getRawValue().dispositionid;
        const closeCase = {
            intakeserreqstatustypeid: intakeserreqstatustypeid,
            dispostionid: dispostionid,
            intakeserviceid: this.id,
            caseclosuresummaryid: this.caseclosuresummaryid
        };
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: closeCase,
                    method: 'get'
                }), 'caseclosuresummary/updatedisposition?filter'
            ).subscribe(result => {
                this._alertService.success('Investigation closed successfully!', true);
                const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/disposition';
                this._router.navigate([currentUrl]);
            });
    }

    legislativeReq_list: any[] = [];
    loadLegislativeDropDown() {
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    referencetypeid: 5466,
                    teamtypekey: 'CW',
                    order: this.displayorder
                }
            },
            this.gettypesurl + '?filter'
        )
            .subscribe((item) => {
                this.legislativeReq_list = item;
            });

    }

    emergncyStiuation_list: any[] = [];
    emergncyStiuationDropDown() {
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    referencetypeid: 5468,
                    teamtypekey: 'CW',
                    order: this.displayorder
                }
            },
            this.gettypesurl + '?filter'
        )
            .subscribe((item) => {
                this.emergncyStiuation_list = item;
            });

    }

    forResonNotProvided_list: any[] = [];
    forResonNotProvidedDropDown() {
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    referencetypeid: 5467,
                    teamtypekey: 'CW',
                    order: this.displayorder
                }
            },
            this.gettypesurl + '?filter'
        )
            .subscribe((item) => {
                this.forResonNotProvided_list = item;
            });

    }

    emergncyStiuation_enable = false;
    forResonNotProvided_enable = false
    notes_enable = false;
    legislativeReq_Change() {
        if (this.reviewCheckListForm.value.legislativeReq == 'EMEPRE') {
            this.emergncyStiuation_enable = true;
        }
        else {
            this.emergncyStiuation_enable = false;
        }
        if (this.reviewCheckListForm.value.legislativeReq == 'FRARNP') {
            this.forResonNotProvided_enable = true;
        }
        else {
            this.forResonNotProvided_enable = false;
        }
        if (this.reviewCheckListForm.value.legislativeReq == 'DAEERR') {
            this.notes_enable = true;
        }
        else {
            this.notes_enable = false;
        }
    }

    legislative: any;
    _gelegislativetData() {
        this._commonHttpService.getArrayList(
            {
                where: { intakeserviceid: this.id },
                method: 'get',
                nolimit: true
            },
            'legislative/list?filter'
        ).subscribe(result => {
            if (result && result[0]) {
                this.legislative = result[0];
                this.legislative = this.legislative || {};
            }
        })
    }

    caseclosure: boolean = false;
    caseclosureuntimely(persons: any) {
        this.caseclosure = false;
        const _persons: any[] = [];
        persons?.forEach((p: any) => {
            p?.roles?.forEach((r: any) => {
                if (!_persons.includes(p.personid) &&
                    ['ICC', 'AV'].includes(r?.intakeservicerequestpersontypekey) ||
                    ((p?.ishousehold === 1) && ((r?.intakeservicerequestpersontypekey === 'CHILD') ||
                        ((r?.intakeservicerequestpersontypekey === 'OTHERCHILD') &&
                            (JSON.parse(JSON.stringify(p?.dangerous[0]))?.initialresponse !== 0))))
                ) {
                    _persons.push(p.personid);
                }
            });
        });
        if (_persons?.length > 0) {
            this._commonHttpService.getArrayList(
                {
                    where: { v_entitytypeid: this.id },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetCaseClosureRecordings + '?filter'
            ).subscribe((result: any) => {
                this.getCaseClosureRecordingsRespFn(result, _persons);
            });
        }
    }

    // Assosiated with caseclosureuntimely method
    private getCaseClosureRecordingsRespFn(result: any, _persons: any[]) {
        result?.forEach((res: any) => {
            if (!this.caseclosure) {
                const _recordings: any[] = [];
                res?.contactparticipant?.forEach((p: { personid: any; }) => {
                    if (!_recordings.includes(p.personid)) {
                        _recordings.push(p.personid);
                    }
                });
                if (_persons.every(r => _recordings.includes(r))) {
                    this.caseclosure = true;
                }
            }
        });
    }
    get investigationFindingFormListControls() {
        return (this.investigationFindingForm.get('allegedperson') as FormArray)?.controls ?? [];
    }
    getSDM() {
        // Both sdm endpoints filter on a uuid column, so an unresolved this.id reaches
        // Postgres as 22P02 and the api flattens that into a bare 400.
        if (!isCaseUuid(this.id)) {
            return;
        }
        let sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmvaluesUrl;
    let requestParam;
    if (this.isServiceCase) {
        sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmServiceCaseUrl; //'servicecase/getservicecasesdm';
        requestParam = {
            servicecaseid: this.id
        };
    } else {
        requestParam = {
            servicerequestid: this.id
        };
    }
    this._commonHttpService
        .getArrayList(
            {
                method: 'get',
                where: requestParam
            },
            sdmUrl + '?filter'
        )
        .subscribe((res) => {
            if (res && res.length > 0) {
              if (this.isServiceCase) {
                const i = res[0].getservicecasesdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                this.sdmData = res[0].getservicecasesdm[i];
              } else {
                const i = res[0].getintakeservicerequestsdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                this.sdmData = res[0].getintakeservicerequestsdm[i];
              }
              if (this.sdmData) {
                this.ischildfatality = this.sdmData?.ischildfatality;
                this.isseriousphysicalinjury = this.sdmData?.isseriousphysicalinjury;
                this.ismaltreatment = this.sdmData?.ismaltreatment;
                this.intakesdmproviderlength = this.sdmData?.provider?.length;
              }
            }
        });
      }


    private reusableValidPersonConditionFn(data: any[]) {
        if (data) {
            return true
        } else {
            return false;
        }
    }

    // Checking if Form1080 C is available for Case closure
  checkForm1080CFilled() : boolean {
      
    const validPersonsForAV = this.involvedPersons.filter(person => {
    const rolesAV = person.roles.find((item: any) => item.intakeservicerequestpersontypekey === 'AV');
    return this.reusableValidPersonConditionFn(rolesAV);
    });

    const oohPersons = validPersonsForAV.filter(person =>
        person.programarea?.some((program: any) => program.programkey === "OOH")
    );


    let response = true;
     if(this.ischildfatality || this.isseriousphysicalinjury || 
            (this.ismaltreatment && oohPersons && oohPersons.length > 0)) {
      let data = this.form1080cData;
      let isForm1080Done = false;
      if(data.length>0) {
          isForm1080Done = data.some((form: any) => form.status === 'Approved');
          if(!isForm1080Done){
            response = false;
          }
      } else {
        response = false;
      }

    } 
    return response;
  }

  onCloseForm1080cAlert() : void {
     $(this.form1080c_alert).modal('hide'); 
   }
     
  trackByFn(index: number, item: any): number {
    return index; 
  }
  
}
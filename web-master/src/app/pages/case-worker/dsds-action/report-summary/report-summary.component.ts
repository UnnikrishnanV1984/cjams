
import { pluck, map, share } from 'rxjs/operators';
import { Component, OnInit, OnDestroy, ViewChild, Injector } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ControlUtils } from '../../../../@core/common/control-utils';
import { CheckboxModel, DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService, SessionStorageService, ValidationService, CommonDropdownsService, GlobalPopupService } from '../../../../@core/services';
import { Observable, forkJoin } from 'rxjs';

import { CaseWorkReportSummary, Illegalactivity, ReportSummary, PersonAddress, DSDSActionSummary } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { SpeechSynthesizerService } from '../../../../shared/modules/web-speech/shared/services/speech-synthesizer.service';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import moment from 'moment';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { Narrative, IntakeCommunication, CpsDocInput } from '../../../newintake/my-newintake/_entities/newintakeModel';
import { IntakeStoreConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { CpsDocLetterComponent } from '../../../newintake/my-newintake/intake-document-creator/cps-doc-letter/cps-doc-letter.component';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
import { PersonInfoService } from '../../../../../app/pages/shared-pages/person-info/person-info.service';
import _ from 'lodash';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { ReportSummaryResolverService } from './report-summary-resolver-service';

declare const $: any;
@Component({
    selector: 'report-summary',
    templateUrl: './report-summary.component.html',
    styleUrls: ['./report-summary.component.scss'],
    standalone: false
})
export class ReportSummaryComponent implements OnInit, OnDestroy {
    disableNo!: boolean;
    disableAddress!: boolean;
    dangerousself!: boolean;
    dangerousaddress!: boolean;
    id: string;
    // CIDM-3416 county codes for 4180
    /*
    Baltimore County -- 1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b,
    Carrol County -- c3fa7975-4ee2-4c4f-90b7-e485e2da63a1,
    Frederick County -- d0a6f218-4dee-45c3-b842-be7446a5ef41,
    Prince George’s County and -- c81be790-a79d-40ac-a38d-abd4dd5a81f6
    Montgomery County -- f6ab02d5-c386-4659-8810-687fc191a967
    */
    textMarkUpNarrative!: SafeHtml;
    addendumNarrative!: SafeHtml;
    county_codes = ['1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1', 'd0a6f218-4dee-45c3-b842-be7446a5ef41', 'c81be790-a79d-40ac-a38d-abd4dd5a81f6', 'f6ab02d5-c386-4659-8810-687fc191a967'];
    isCW!: boolean;
    daNumber: string;
    caseclosuresummaryid!: string;
    possibleIllegalActivityDropdown!: FormArray;
    reportSummaryForm!: FormGroup;
    ARCaseSummaryForm!: FormGroup;
    closureSubTypeItems: DropdownModel[] = [];
    illegalActivityDd = false;
    countyList: any[] = [];
    significantEventDd = false;
    notPlacedChildList: any;
    significantEventDropdownItems$!: Observable<DropdownModel[]>;
    reasonDropDown: any[] = [];
    statusDropDown: any[] = [];
    statusTempDropDown: any[] = [];
    serviceDropDown: any[] = [];
    sourceDropdownItems$!: Observable<DropdownModel[]>;
    reporterRoleList: any[] = [];
    possibleCheckboxItems: CheckboxModel[] = [];
    reportSummary?: ReportSummary;
    LegalGuardian!: string;
    reportSummaryDangerAddress!: PersonAddress;
    selectedIllegalActivities: string[] = [];
    speaking = false;
    paused = false;
    voiceNotStarted = true;
    involvedPersons$!: Observable<any[]>;
    countyid!: string;
    reporterFirstName!: string;
    reporterLastName!: string;
    reporterPhone!: string;
    reporterPhoneExt!: string;
    reporteEmail!: string;
    reporterUnknown!: string;
    isLGPresent!: boolean;
    clientrefrdservicesdisabled!: boolean;
    statuslistdisabled!: boolean;
    involevedUnkPerson: any[] = [];
    involvedChildren: any[] = [];
    involvedOthers: any[] = [];
    involvedPersons: any[] = [];
    selectedParticipant: any[] = [];
    personsInvolved: any[] = [];
    selectedChild: any[] = [];
    isUnkPresent!: boolean;
    userRole!: AppUser;
    isAs!: boolean;
    isRequestService!: boolean;
    speechRecogninitionOn: boolean;
    speechData: string;
    currentLanguage!: string;
    currentSpeechRecInput!: string;
    notification!: string;
    recognizing = false;
    disableSubmitforApproval = false;
    disableSubmitforApprovalSkip2 = false;
    ARAssessmentClosureDate!: string;
    AssessmentParticipant: any[] = [];
    savedParticipants: any[] = [];
    dsdsActionsSummary = new DSDSActionSummary();
    maltreatmentInformation: any[] = [];
    isInfantnotReported!: boolean;
    needToSafeInfants: any[] = [];
    infants: any[] = [];
    ageAtReferralList: { personid: any; incidentage: any; }[] = [];
    communicationList: any;
    isServiceCase: any;
    hohPersonName!: string;
    populatedIntake = false;
    narrativePresent = false;
    unSyncedMDMPersons: any[] = [];
    disableCPSIntakeReport = false;
    intakeflag = false;
    alertMessageFor15Days = false;
    alertMessageFor30Days = false;
    currentdatecheck = new Date();
    reviewStatus: any;
    emailForm!: FormGroup;
    intakeCommunication: IntakeCommunication[] = [];
    cpsdocData: CpsDocInput = new CpsDocInput();
    isAdoption = false;
    moduleview: any;
    @ViewChild(CpsDocLetterComponent)
    cpsDoc!: CpsDocLetterComponent;
    isUnconfirmed!: boolean;
    ageAtReferralUpdated: any;
    casedetailsobj = {
        caseNumber: "",
        servicecaseid: "",
        serviceCase: [],
        caseDate: ""
    };
    birthMatchMessage!: string;
    senNotificationMessage!: string;
    birthMatchIds: any[] = [];
    senNotificationPersonIds: any[] = [];
    isClosed = false;
    currentStatus: any;
    chkAllegedVictim!: boolean | null;
    selectAllegedVictimReason1: any;
    selectAllegedVictimReason2: any;
    selectAllegedVictimReason3: any;
    chkOtherChild!: boolean | null;
    selectOtherChildReason1: any;
    selectOtherChildReason2: any;
    selectOtherChildReason3: any;
    chkCaregiver!: boolean | null;
    selectCaregiverReason1: any;
    selectCaregiverReason2: any;
    selectCaregiverReason3: any;
    cpsresponsetimeractionsid: any = '';
    saveCpsresponsetimeractionsid: any = '';
    updatedOn: any;
    showhistoryTable!: boolean;
    responseTimerDueDate: any;
    reason: any;
    allegedVictimreasonDropDown1: any[] = [];
    allegedVictimreasonDropDown2: any[] = [];
    allegedVictimreasonDropDown3: any[] = [];
    otherChildrenreasonDropDown1: any[] = [];
    otherChildrenreasonDropDown2: any[] = [];
    otherChildrenreasonDropDown3: any[] = [];
    caregiverreasonDropDown1: any[] = [];
    caregiverreasonDropDown2: any[] = [];
    caregiverreasonDropDown3: any[] = [];
    prevSkipList: any[] = [];
    skipname: any;
    showlegislativecontent!: boolean;
    recording: any[] = [];
    hidedropdowns!: boolean;
    serviceCaseId: any;
    assignmentlist: any[] = [];
    responseTimerDueDateList: any;
    hideskipbtn!: boolean;
    showapprovebtn!: boolean;
    hideallegeddropdown!: boolean;
    hideotherchilddropdown!: boolean;
    hidecaregiverdropdown!: boolean;
    disableskipbtn!: boolean;
    isSupervisor = false;

    enableAllegedDataEntryErrorReason!: boolean;
    enableChildrenDataEntryErrorReason!: boolean;
    enableCaregiverDataEntryErrorReason!: boolean;
    cpsResponseTimerList: any;
    hasSavedResponseTimerRecord: boolean = false;
    showSkip3Label: boolean = false;
    openHospitalizationRecords: any[] = [];
    hospitalizationlist: any[] = [];
    hospitalpopupid = '#hospital-info';

    isselectAllegedmultiple!: boolean;
    isselectChildrenmultiple!: boolean;
    isselectCaregivermultiple!: boolean;
    hasFamilyAccessToCase: boolean = false;
    hasFamilyAccessCase: boolean = false;
    caseworkerFamilyAccess: boolean = false;
    hasSkip3: boolean = false;
    cpsActionSelectedSupervisor!: string;
    caseWorkerComment: any;
    supervisorComment: any;
    hasSaveForApproval: boolean = false;
    hasSkipForApproval: boolean = false;
    canSaveResponseTimer: boolean = true;
    supervisorsList: any[] = [];
    cpsSkipApproval: any;
    fromoverduelink: boolean = false;
    dtformat = 'MM/DD/YYYY';
    legalguardianrolepopupid = '#legal-guardian-role';
    clientNamesForEbp: any = '';
    
    dtwithtimeformat = "YYYY-MM-DD H:m:s a";
    responsetimeoverduepopupid = '#responsetime-overdue';
    gettypesurl = 'referencetype/gettypes';
    cpsresponsetimeraddupdateurl = 'cpsresponsetimeractions/addupdate';
    errmsg = 'Error in updating restriction.';
    mandatoryErrorMsg = 'Select all mandatory fields.';
    overduepopupid = '#overdue-Popup';
    notificationData: any[] = [];
    careGiverMessages: any[] = [];
    legalguardianrolepopupData: any;
    tempData: any[] = [];

    private route: ActivatedRoute;
    private formBuilder: FormBuilder;
    private _authService: AuthService;
    private _alertService: AlertService;
    private _commonHttpService: CommonHttpService;
    private _dataStoreService: DataStoreService;
    private _speechSynthesizer: SpeechSynthesizerService;
    private speechRecognizer: SpeechRecognizerService;
    private _speechRecognitionService: SpeechRecognitionService;
    private storage: SessionStorageService;
    private sanitize: DomSanitizer;
    private _router: Router;
    private _personService: PersonInfoService;
    private _commonDDService: CommonDropdownsService;
    private _globalPopupService: GlobalPopupService;
    iscaseexpunged: any;
    isInitialLoad: boolean = true;

    constructor(private _reportSummaryService: GenericService<ReportSummary>, private injector: Injector,private reportSummaryResolverService: ReportSummaryResolverService) {

        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._speechSynthesizer = this.injector.get<SpeechSynthesizerService>(SpeechSynthesizerService);
        this.speechRecognizer = this.injector.get<SpeechRecognizerService>(SpeechRecognizerService);
        this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.sanitize = this.injector.get<DomSanitizer>(DomSanitizer);
        this._router = this.injector.get<Router>(Router);
        this._personService = this.injector.get<PersonInfoService>(PersonInfoService);
        this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.speechRecogninitionOn = false;
        this.speechData = '';
        this.route.data.subscribe((data: any) => {
        if (data && data.hasOwnProperty('result')) {
            this._authService.setAuthDetail('summary', data.result);
        }
        });
        this._globalPopupService = this.injector.get<GlobalPopupService>(GlobalPopupService);

    }
    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        if(this.iscaseexpunged == undefined) {
            this.getcaseexpungedflag();
        }
        this.moduleview = this._authService.isModuleAccessable('summary', 'summary');
        this.cpsSkipApproval = (this.storage.getItem('cpsSkipApproval')) ? this.storage.getItem('cpsSkipApproval') : 'false';
        this._speechSynthesizer.initSynthesis();
        this.userRole = this._authService.getCurrentUser();
        this.speechRecognizer.initialize(this.currentLanguage);
        this.selectedParticipant = [];
        this.selectedChild = [];
        this.ageAtReferralUpdated = false;
        this.getcpsresponsetimerActions(true);

        this.isInitialLoad = true;
        this._dataStoreService.currentStore.subscribe(storeObj => {
            if (this.isInitialLoad && storeObj['responsetimerduedatelist']) {
                 this.getresponsetimerduedate();
                 this.isInitialLoad = false;
            }            
        });
        this.initARCaseSummaryForm();
        this.loadReasonDropDown();
        this.loadReporterRole();
        this.loadStatusDropDown();
        this.loadServiceDropDown();
        setTimeout(() => {
            this.getInvolvedPerson();
        }, 2000);
        this._getCaseDetails();
        this.roleChecks();
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        if (this.isServiceCase) {
            this.getChildRemoval();
        }
        this.possibleIllegalActivityDropdown = this.formBuilder.array([this.formBuilder.control(false)]);
        if (this.id !== '0') {
            this.listReportSummary(this.id);
        }
        this.getDropdowmItems();
        const store = this._dataStoreService.getCurrentStore();
        localStorage.setItem('storeInfo', JSON.stringify(store));
        localStorage.setItem('CASE_UID', this.id);
        localStorage.setItem('DA_NUMBER', this.daNumber);
        if (store['da_status'] === 'Closed') {
            ControlUtils.disableElements($('#Involved-Persons').children());
        }
        if (store['countyid']) {
            this.countyid = store['countyid'];

        }
        if (store['dsdsActionsSummary']) {
            this.dsdsActionsSummary = store['dsdsActionsSummary'];
        }


        if ((this.dsdsActionsSummary.da_type === 'Request for services' || this.dsdsActionsSummary.da_type === 'Provider') && (this._authService.getAgencyName() === 'CW')) {
            this.disableCPSIntakeReport = true;
        }

        this.getCountyList();
        this.getARSummaryCase();
        this.populateIntake(this._dataStoreService.getData('da_intakenumber'));

        this.emailForm = this.formBuilder.group({
            email: ['', [ValidationService.mailFormat, Validators.required]]
        });
        this.getCommunicationList();
        this.checkIntakenumber();
        this.checkIsClosed();
    }

    private getcaseexpungedflag() {
      const isExpungementSuperUser = this._authService.isExpungementSuperUser();
      const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      if(isExpungementSuperUser == 1) {
          const reqData = {
          'objectid': id,
          'objecttype': 'Case'
          };
          this._commonHttpService
          .getSingle(
              {
              order: 'desc',
              where: reqData,
              method: 'get'
              },
              'Intakeservicerequests/getcaseexpungedflag?filter'
          ).subscribe(data => {
              if (data && data.length) {
                  console.log(data,'isexpunged');
                  this._dataStoreService.setData('iscaseexpunged',data[0].iscaseexpunged);
                  this.iscaseexpunged = data[0].iscaseexpunged;
              } 
          });
      } else {
          this._dataStoreService.setData('iscaseexpunged',0);
          this.iscaseexpunged = 0;
      }
   }

    roleChecks() {
        if (this.userRole.role.name == 'apcs') {
            this.isSupervisor = true;
        }
        if (this.userRole.role.teamtypekey === 'AS') {
            this.isAs = true;
        }
    }

    getDropdowmItems() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get'
                }),
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.PossibleCheckList}?filter`
            ),
            this._commonHttpService.getArrayList(
                new PaginationRequest({
                    where: { activeflag: 1 },
                    method: 'get'
                }),
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.Source}?filter`
            )
        ]).pipe(
            map((result: any) => {
                if (result && result.length) {
                    return {
                        intakeServiceRequestIllegalActivityTypes: result[0].map((res: { typedescription: any; intakeservicerequestillegalactivitytypekey: any; }) =>
                                new CheckboxModel({
                                    text: res.typedescription,
                                    value: res.intakeservicerequestillegalactivitytypekey,
                                    isSelected: false
                                })
                        ),
                        intakeServiceRequestInputTypes: result[1].map((res: { description: any; intakeservreqinputtypeid: any; }) =>
                                new DropdownModel({
                                    text: res.description,
                                    value: res.intakeservreqinputtypeid
                                })
                        )
                    };
                } else {
                    return {
                        intakeServiceRequestIllegalActivityTypes: null,
                        intakeServiceRequestInputTypes: null
                    };
                }
            }),
            share());
        this.sourceDropdownItems$ = source.pipe(pluck('intakeServiceRequestInputTypes'));
    }

    checkIntakenumber() {
        if (this.isServiceCase) {
            const list = this._dataStoreService.getData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER);
            const intakenumber = (Array.isArray(list) && list.length && list[0]) ? list[0].intakenumber : null;
            this.populatedIntake = intakenumber ? true : false;
        } else {
            const intakenumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.INTAKE_NUMBER);
            this.populatedIntake = intakenumber ? true : false;
        }
    }

    checkIsClosed() {
        setTimeout(() => {
            const da_status = this.storage.getItem('da_status');
            this.currentStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
            if (da_status || this.currentStatus) {
                if (da_status === 'Closed' || da_status === 'Completed' || this.currentStatus === 'Closed' || this.currentStatus === 'Completed') {
                    this.isClosed = true;
                } else {
                    this.isClosed = false;
                }
            }
        }, 2000)
    }

    loadSupervisor() {
        if (!this.supervisorsList || (this.supervisorsList && this.supervisorsList.length == 0)) {
            this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        where: { appevent: 'INTR' },
                        method: 'post'
                    }),
                    'Intakedastagings/getroutingusers'
                )
                .subscribe((result: { data: any[]; }) => {
                    this.supervisorsList = result.data;
                });
        }
    }

    getFindingList() {
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    where: {
                        investigationid: this.dsdsActionsSummary.da_investigationid
                    },
                    method: 'get'
                }),
                'Investigationallegations/getmaltreatmentfinding?filter'
            )
            .subscribe((iFindings: any) => {
                if (iFindings && Array.isArray(iFindings) && iFindings.length > 0) {
                    this.checkForInfantAndToddler(iFindings);
                }
            });
    }

    private _getCaseDetails() {
        let intakenumber = null;
        if (this.isServiceCase) {
            const list = this._dataStoreService.getData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER);
            let listArraySort = list.sort((a: { reporteddate: string; }, b: { reporteddate: any; }) => a.reporteddate.localeCompare(b.reporteddate));
            listArraySort = listArraySort.reverse();
            intakenumber = (Array.isArray(listArraySort) && listArraySort.length && listArraySort[0]) ? listArraySort[0].intakenumber : null;
        } else {
            intakenumber = this._dataStoreService.getData('da_intakenumber');
        }
        this.getCaseByIntake(intakenumber);

    }

    getCaseByIntake(intakenumber: any) {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const url = 'Intakedastagings/getCasebyIntake';
        this._commonHttpService.post({'intakenumber': intakenumber,
        'isExpungementSuperUser': isExpungementSuperUser,
        'iscaseexpunged': this.iscaseexpunged}, url).subscribe(
            (response) => {
                if (response.length) {
                    this.checkCaseDetails(response);
                }
            })
    }

    checkCaseDetails(response: any) {
        const actionData: any = { "IR": "CPS-IR", "AR": "CPS-AR" };
        if ((response[0].activeflag && response[0].actiontype == "N") || !response[0].activeflag || (response[0].activeflag && !response[0].actiontype)) {
            this.casedetailsobj.caseNumber = response[0].casenumber;
        } else if (response[0].activeflag && actionData[response[0].actiontype]) {
            this.casedetailsobj.caseNumber = response[0].servicerequestnumber;
        }
        this.casedetailsobj.serviceCase = response[0].activeflag && response[0].actiontype == '1' ? response.map((x: { programkey: string; subprogramkey: string; }) => {
            if (x.programkey && x.subprogramkey) {
                return x.programkey + '-' + x.subprogramkey
            }
        }) : [actionData[response[0].actiontype] || 'Service Case'];
        this.casedetailsobj.serviceCase = this.casedetailsobj.serviceCase.filter(x => x != undefined);
        this.casedetailsobj.caseDate = moment(response[0].reporteddate).format(this.dtformat);
        this.setServiceCaseId(response);
    }
    setServiceCaseId(response: any) {
        if (response[0].actiontype == "IR" || response[0].actiontype == "AR") {
            this.casedetailsobj.servicecaseid = response[0].intakeserviceid;
        } else {
            this.casedetailsobj.servicecaseid = response[0].servicecaseid;
        }
    }

    async previewCpsDoc() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let intakenumber: string | null = null;
        if (this.isServiceCase) {
            const list = this._dataStoreService.getData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER);
            let listArraySort = list.sort((a: { reporteddate: string; }, b: { reporteddate: any; }) => a.reporteddate.localeCompare(b.reporteddate));
            listArraySort = listArraySort.reverse();
            intakenumber = (Array.isArray(listArraySort) && listArraySort.length && listArraySort[0]) ? listArraySort[0].intakenumber : null;
        } else {
            intakenumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.INTAKE_NUMBER);
        }
        if (String(intakenumber).startsWith('CW')) { // if migrated case
            this.intakeflag = true;         
            if (this.cpsDoc) {
                await this.cpsDoc.downloadCPSIntakePdf();
            }
            return;
        }
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['intakereport'],
                status: 'intake',
                'intakenumber': intakenumber,
                caseNumber: this.casedetailsobj.caseNumber,
                servicecaseid: this.casedetailsobj.servicecaseid,
                caseDate: this.casedetailsobj.caseDate ? this.getDateFormat(this.casedetailsobj.caseDate) : null,
                serviceCase: this.casedetailsobj.serviceCase,
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
            .subscribe((res: any) => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                const pre = 'CPS_Intake_Report-';
                const ext = '.pdf';
                link.download = `${pre}` + intakenumber + `${ext}`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
    }

    populateIntake(intakenumber: any) {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonHttpService
            .create(
                {
                    page: 1,
                    limit: 10,
                    where: {
                        intakenumber: intakenumber,
                        'isExpungementSuperUser': isExpungementSuperUser,
                        'iscaseexpunged': this.iscaseexpunged
                    }
                },
                NewUrlConfig.EndPoint.Intake.IntakenapshotReport /* Separate API invoked for Intakereport Report */
            ).subscribe((data: any) => {
                const response = data;
                let addedPersons = [];
                const narrativeDetails = new Narrative();
                if (response && response.data && response.data.length > 0 && response.data[0]) {
                    this.intakeflag = true;
                    const intakeModel = response.data[0].jsondata;
                    const general = intakeModel.General;
                    addedPersons = this.getAddedPersons(intakeModel);
                    this.handleReviewStatus_Closed_ApprovedFn(intakeModel, narrativeDetails, general);
                    this.handleIfNArrativeAndIsCpsHistoryClearanceFn(general, narrativeDetails);
                    narrativeDetails.IsAnonymousReporter = general.IsAnonymousReporter === true ? true : false;
                    narrativeDetails.IsUnknownReporter = general.IsUnknownReporter === true ? true : false;
                    narrativeDetails.RefuseToShareZip = general.RefuseToShareZip === true ? true : false;
                    narrativeDetails.requesteraddress1 = general.requesteraddress1;
                    narrativeDetails.requesteraddress2 = general.requesteraddress2;
                    narrativeDetails.requestercity = general.requestercity;
                    narrativeDetails.requesterstate = general.requesterstate;
                    narrativeDetails.requestercounty = general.requestercounty;
                    narrativeDetails.isacknowledgementletter = general.isacknowledgementletter ? true : false;
                    this.prepareCpsDocDetails(general.InputSource);
                    this._dataStoreService.setData(IntakeStoreConstants.REFERALSOURCE, { label: general.InputSource });
                    this._dataStoreService.setData(IntakeStoreConstants.general, general);
                    this._dataStoreService.setData(IntakeStoreConstants.intakeSDM, intakeModel.sdm);
                    this._dataStoreService.setData(IntakeStoreConstants.addedPersons, addedPersons);
                    this._dataStoreService.setData(IntakeStoreConstants.reviewstatus, this.reviewStatus);
                    this._dataStoreService.setData(IntakeStoreConstants.evalFields, intakeModel.evaluationFields);
                    this.checkRiskofHarmCase(intakeModel.sdm);
                } else {
                    this._dataStoreService.setData(IntakeStoreConstants.addNarrative, '');
                }
            });
    }

    checkRiskofHarmCase(sdm: any) : void {
        let isROHFlag;
        const isROHFlagCheck = sdm && sdm.riskofHarm ? ObjectUtils.checkTrueProperty(sdm.riskofHarm) : 0;
        if (isROHFlagCheck >= 1) {
            isROHFlag = true;
        }
       if(!(sdm?.isir || sdm?.isar) && (sdm?.isnegrh_exposednewborn || isROHFlag)){
        this._dataStoreService.setData('IsRiskofHarm', true);
       } else {
        this._dataStoreService.setData('IsRiskofHarm', false);
       }

    }

    // Assosiated with populateIntake function
    private handleIfNArrativeAndIsCpsHistoryClearanceFn(general: any, narrativeDetails: Narrative) {
        if (general.Narrative && general.Narrative != null && general.Narrative !== '') {
            narrativeDetails.Narrative = this.fixNarrativeHistoryClearanceText(general.Narrative);
        }
        if (general.Narrative && general.addendumNarrative != null && general.addendumNarrative !== '') {
            narrativeDetails.addendumNarrative = this.fixNarrativeHistoryClearanceText(general.addendumNarrative);
            this.addendumNarrative = narrativeDetails.addendumNarrative;
        }
        if (general.cpsHistoryClearance && general.cpsHistoryClearance !== null && general.cpsHistoryClearance !== '') {
            narrativeDetails.cpsHistoryClearance = this.fixNarrativeHistoryClearanceText(general.cpsHistoryClearance);
        }
    }
    // Assosiated with populateIntake function
    private handleReviewStatus_Closed_ApprovedFn(intakeModel: any, narrativeDetails: Narrative, general: any) {
        this.reviewStatus = intakeModel.reviewstatus.status;
        if (this.reviewStatus === 'Closed' ||
            this.reviewStatus === 'Approved') {
            narrativeDetails.Firstname = general.Firstname;
            narrativeDetails.Middlename = general.Middlename;
            narrativeDetails.Lastname = general.Lastname;
            narrativeDetails.ZipCode = general.offenselocation;
        } else {
            if (intakeModel.narrative && intakeModel.narrative.length > 0 && intakeModel.narrative[0]) {
                this.handleIfNarrativeFn(narrativeDetails, intakeModel);
            }
        }
    }
    // Assosiated with populateIntake function
    private handleIfNarrativeFn(narrativeDetails: Narrative, intakeModel: any) {
        narrativeDetails.Firstname = intakeModel.narrative ? intakeModel.narrative[0].Firstname : '';
        narrativeDetails.Middlename = intakeModel.narrative ? intakeModel.narrative[0].Middlename : '';
        narrativeDetails.Lastname = intakeModel.narrative ? intakeModel.narrative[0].Lastname : '';
        narrativeDetails.ZipCode = intakeModel.narrative ? intakeModel.narrative[0].ZipCode : '';
        narrativeDetails.PhoneNumber = intakeModel.narrative ? intakeModel.narrative[0].PhoneNumber : '';
        narrativeDetails.incidentlocation = intakeModel.narrative ? intakeModel.narrative[0].incidentlocation : '';
        narrativeDetails.incidentdate = intakeModel.narrative ? intakeModel.narrative[0].incidentdate : '';
        narrativeDetails.isapproximate = intakeModel.narrative ? intakeModel.narrative[0].isapproximate : '';
        narrativeDetails.email = intakeModel.narrative ? intakeModel.narrative[0].email : '';
    }

    setNarrativeDetails(intakeModel: { General: any; narrative: string | any[]; }) {
        const narrativeDetails = new Narrative();
        const general = intakeModel.General;
        if (this.reviewStatus === 'Closed' ||
            this.reviewStatus === 'Approved') {
            narrativeDetails.Firstname = general.Firstname;
            narrativeDetails.Middlename = general.Middlename;
            narrativeDetails.Lastname = general.Lastname;
            narrativeDetails.ZipCode = general.offenselocation;
        } else {
            if (intakeModel.narrative &&
                intakeModel.narrative.length > 0 && intakeModel.narrative[0]) {
                narrativeDetails.Firstname = this.getFirstname(intakeModel);
                narrativeDetails.Middlename = this.getMiddlename(intakeModel);
                narrativeDetails.Lastname = this.getLastname(intakeModel);
                narrativeDetails.ZipCode = this.getZipCode(intakeModel);
                narrativeDetails.PhoneNumber = this.getPhoneNumber(intakeModel);
                narrativeDetails.incidentlocation = this.getincidentlocation(intakeModel);
                narrativeDetails.incidentdate = this.getincidentdate(intakeModel);
                narrativeDetails.isapproximate = this.getisapproximate(intakeModel).narrative ? intakeModel.narrative[0].isapproximate : '';
                narrativeDetails.email = this.getemail(intakeModel)
            }
        }
        if (general.Narrative && general.Narrative !== null && general.Narrative !== '') { narrativeDetails.Narrative = this.fixNarrativeHistoryClearanceText(general.Narrative); }
        if (general.cpsHistoryClearance && general.cpsHistoryClearance !== null && general.cpsHistoryClearance !== '') {
            narrativeDetails.cpsHistoryClearance = this.fixNarrativeHistoryClearanceText(general.cpsHistoryClearance);
        }
        narrativeDetails.IsAnonymousReporter = this.booleanCheck(general.IsAnonymousReporter);
        narrativeDetails.IsUnknownReporter = this.booleanCheck(general.IsUnknownReporter);
        narrativeDetails.RefuseToShareZip = this.booleanCheck(general.RefuseToShareZip);
        narrativeDetails.requesteraddress1 = general.requesteraddress1;
        narrativeDetails.requesteraddress2 = general.requesteraddress2;
        narrativeDetails.requestercity = general.requestercity;
        narrativeDetails.requesterstate = general.requesterstate;
        narrativeDetails.requestercounty = general.requestercounty;
        narrativeDetails.isacknowledgementletter = this.booleanCheck(general.isacknowledgementletter);
        this._dataStoreService.setData(IntakeStoreConstants.addNarrative, narrativeDetails);

    }

    getAddedPersons(intakeModel: any) {
        return intakeModel.persons ? intakeModel.persons : this.getPersonDetails(intakeModel);
    }
    getPersonDetails(intakeModel: any) {
        return intakeModel.persondetails ? intakeModel.persondetails.Person : [];
    }

    getFirstname(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].Firstname : '';
    }
    getMiddlename(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].Middlename : '';
    }
    getLastname(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].Lastname : '';
    }
    getZipCode(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].ZipCode : '';
    }
    getPhoneNumber(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].PhoneNumber : '';
    }
    getincidentlocation(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].incidentlocation : '';
    }
    getincidentdate(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].incidentdate : '';
    }
    getisapproximate(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].isapproximate : '';
    }
    getemail(intakeModel: any) {
        return intakeModel.narrative ? intakeModel.narrative[0].email : '';
    }

    booleanCheck(inputData: boolean) {
        return inputData === true ? true : false;
    }


    getCommunicationList() {
        const checkInput = {
            nolimit: true,
            where: { teamtypekey: this._authService.getAgencyName() },
            method: 'get',
            order: 'description'
        };
        return this._commonHttpService.getArrayList(new PaginationRequest(checkInput), `${NewUrlConfig.EndPoint.Intake.IntakeCommunications}/list?filter`).subscribe((data: any) => {
            this.intakeCommunication = data;
            const general = this._dataStoreService.getData(IntakeStoreConstants.general);
            if (general && general.InputSource) {
                this.prepareCpsDocDetails(general.InputSource);
            }
        });
    }
    prepareCpsDocDetails(input: string) {
        if (this.intakeCommunication) {
            this.intakeCommunication.forEach(data => {
                if (data.intakeservreqinputtypeid === input) {
                    this.cpsdocData.InputSource = data.description;
                    this._dataStoreService.setData(
                        IntakeStoreConstants.REFERALSOURCE,
                        { label: this.cpsdocData.InputSource || input }
                    );
                }
            });
        }
    }

    sendEmail() {
        const caseID = this._dataStoreService.getData('da_intakenumber');
        if (this.emailForm.valid) {
            const request = {
                email: this.emailForm.getRawValue().email,
                caseNumber: caseID,
                body: document.getElementById('CPS-Intake-Report')?.innerHTML
            };
            this._commonHttpService.create(request, 'Intakeservicerequestpurposes/sendemailcontact').subscribe(
                (result) => {
                    this._alertService.success('Email Sent successfully!');
                }
            );
        } else {
            this._alertService.error('Please enter valid email address!');
        }
    }

    printCasePdf(element: string) {
        $('#cps-doc').modal('hide');
        const printContents = document.getElementById('CPS-Intake-Report')?.innerHTML;
        const popupWin: any = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
        popupWin.document.open();
        popupWin.document.write(`
      <html>
        <head>
          <title>CPS Intake Report</title>
          <style>
          .section-header {
            height: 25px;
            border: 1px solid black;
            text-align: center;
            padding-bottom: 15px;
            background-color: #556080;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .section-body table td{border: 1px solid #ccc; padding: 5px;}
        .section-lable {
            text-align: left;
            padding-right: 15px;
            font-weight: 600;
            margin-bottom: 5px;
        }.section-value {
            min-height: 22px;
            padding-left: 0px;
        }
        .sizeA4 {
                width: 21cm;
                height: 29.7cm;
            }.margin-wrapper {
                margin-left: 1.2cm;
                margin-right: 1.2cm;
            }
            .pdf-page .row {
                margin-left: 0px;
                margin-right: 0px;
            }
            .align-center {
                text-align: center
            }
            </style>
        </head>
    <body onload="window.print();window.close()">${printContents}</body>
      </html>`);
        popupWin.document.close();
    }
    private checkForInfantAndToddler(iFindings: any[]) {
        const indicatedFindings = this.getIndicatedFindings(iFindings);
        if (indicatedFindings && Array.isArray(indicatedFindings) && indicatedFindings.length > 0) {
            if (this.infants.length > 0) {
                this.infants.forEach((infant, index) => {
                    const malTreatedPerson = indicatedFindings.find(ifData => ifData.personid === infant.personid);
                    if (!malTreatedPerson) {
                        this.needToSafeInfants.push(infant);
                    }

                });
                if (this.needToSafeInfants.length > 0) {
                    this.isInfantnotReported = true;
                    // setting alert data for global popup
                    this.legalguardianrolepopupDataFn();

                    $(this.legalguardianrolepopupid).modal('show');
                } else {
                    this.isInfantnotReported = true;
                }
            } else {
                this.isInfantnotReported = false;
            }
        }
    }

    getIndicatedFindings(iFindings: any[]) {
        return iFindings.filter(item => {
            if (item.findings && item.findings.length) {
                const indicatedData = item.findings.find((data: { investigationfindingtypekey: string; }) => data.investigationfindingtypekey === 'ID');
                if (indicatedData) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        });
    }

    private getAge(dateValue: string | number | Date) {
        if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
            const rCDob = moment(new Date(dateValue), this.dtformat).toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return '';
        }
    }

    initARCaseSummaryForm() {
        this.ARCaseSummaryForm = this.formBuilder.group({
            reason: [null],
            caseclosuresummaryid: [null],
            intakeserviceid: [null],
            referralreason: [null],
            riskissues: [null],
            recommendation: [null],
            interventionissues: [null],
            statusList: this.formBuilder.array([]),
            clientrefrdservices: [null],
            closuretypekey: [null],
            closuresubtypekey: [null],
            notes: [null],
            participants: [null]
        });

    }
    getCountyList() {
        this._commonHttpService.create({
            where: {
                activeflag: '1',
                state: 'MD'
            },
            order: 'countyname asc',
            nolimit: true
        }, 'admin/county/countylist').subscribe((item: any[]) => {
            if (item && item.length) {
                this.countyList = item.filter((res) => res.countyid === this.countyid);
            }
        });
    }

    getAssignmentsList() {
        this._commonHttpService.getArrayList(
            {
                where: { servicecaseid: this.id },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        ).subscribe((data: any) => {
            if (data) {
                this.checkAssignmentsList(data);
            }
        });
    }

    checkAssignmentsList(data: any[]) {
        this.checkCaseAccess(data);

        const checkAccessList = data.filter(item => (item.enddate === null || moment(item.enddate) >= moment(new Date())))
        checkAccessList.forEach(element => {
            const familyAssignmentWorker = element.toworkerdetails.filter((a: { securityusersid: string; }) => (a.securityusersid === this._authService.getCurrentUser().user.securityusersid));

            const familyAssignmentSup = element.toworkerdetails.filter((a: { supervisorid: string; }) => (a.supervisorid === this._authService.getCurrentUser().user.securityusersid))
            if (familyAssignmentWorker.length > 0 || familyAssignmentSup.length > 0) {
                this.hasFamilyAccessCase = true;
            }
            if(familyAssignmentWorker.length > 0 ) {
                this.caseworkerFamilyAccess =  true;
                this.getServicePlans();
            }
        })
        const fam = data.filter(item => String(item.enddate == null));
        const childCategory = this.county_codes.find(category => category === fam[0]?.countyid);
        if (childCategory) {
            if (moment(this.currentdatecheck).format(this.dtformat) === '08/31/2021' || moment(this.currentdatecheck).format(this.dtformat) === '08/31/2022' || moment(this.currentdatecheck).format(this.dtformat) === '08/31/2023') {
                this.alertMessageFor30Days = true;
                $(this.legalguardianrolepopupid).modal('show');
            }
            if (moment(this.currentdatecheck).format(this.dtformat) === '09/15/2021' || moment(this.currentdatecheck).format(this.dtformat) === '09/15/2022' || moment(this.currentdatecheck).format(this.dtformat) === '09/15/2023') {
                this.alertMessageFor15Days = true;
                $(this.legalguardianrolepopupid).modal('show');
            }
        }
    }
    checkCaseAccess(data: any[]) {
        const checkAccessList = this.returnActiveFamilyList(data);
        const checkFamilyOrAdminAccessList = this.returnActiveFamilyorAdminList(data); 
        this.storage.setItem('hasFamilyAccessToCase', false);
        checkAccessList.forEach((element: any) => {
            const familyAssignmentWorker = element.toworkerdetails?.filter((a: { securityusersid: string; }) => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
            if (familyAssignmentWorker.length > 0) {
                this.hasFamilyAccessToCase = true;
            }
        })
        if(checkFamilyOrAdminAccessList && checkFamilyOrAdminAccessList.length > 0) {
            checkFamilyOrAdminAccessList.forEach((element: any) => {
                const familyAssignmentWorker = element.toworkerdetails?.filter((a: any) => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
                if (familyAssignmentWorker.length > 0) {
                    this.storage.setItem('hasFamilyAccessToCase', true);
                }
            })
        }
        if (this.isSupervisor && (this.showSkip3Label || this.hasSaveForApproval) && this.cpsSkipApproval === 'true') {
            this.hasFamilyAccessToCase = true;
        }
    }


    returnActiveFamilyList(data: any) {
        return data.filter((item: any) => item.responsibilitytypekey === "family" && (item.enddate === null || moment(item.enddate) >= moment(new Date())));
    }

    returnActiveFamilyorAdminList(data: any) {
        return data.filter((item: any) => (item.responsibilitytypekey === "family" || item.responsibilitytypekey === "administrative" || item.responsibilitytypekey === "child") && (item.enddate === null || moment(item.enddate) >= moment(new Date())));
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
            const illegalactivity = this.reportSummary?.intakeservicerequestillegalactivity?.filter((item, index, array) => {
                return item.intakeservicerequestillegalactivitytypekey === id;
            }) ?? [];
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
                    intakeservicerequestillegalactivityid: (this.reportSummary?.intakeservicerequestillegalactivity
                        && this.reportSummary?.intakeservicerequestillegalactivity.length && this.reportSummary?.intakeservicerequestillegalactivity[0].intakeservicerequestillegalactivityid) ? this.reportSummary?.intakeservicerequestillegalactivity[0].intakeservicerequestillegalactivityid : null,
                    updatedby: userId
                });
            }
        });
        caseWorkReportSummary.intakeservicerequestillegalactivity = [];
        caseWorkReportSummary.intakeservicerequestillegalactivity.push(...addedItems);
        caseWorkReportSummary.suspiciousdeath = this.reportSummaryForm.value.suspiciousdeath;
        caseWorkReportSummary.missingpersons = this.reportSummaryForm.value.missingpersons;
        caseWorkReportSummary.effectivedate = new Date();
        this._commonHttpService.update(this.reportSummary?.intakeserviceid ??'', caseWorkReportSummary, CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.UpdateReportSummary).subscribe(
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
            this._speechSynthesizer.cancel();
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
            suspiciousdeath: [reportSummary.suspiciousdeath ? reportSummary.suspiciousdeath : false],
            missingpersons: [reportSummary.missingpersons ? reportSummary.missingpersons : false],
            significantkey: [reportSummary.servicerequestincidenttypekey ? reportSummary.servicerequestincidenttypekey : '']
        });
    }

    isPersonAddressDangerous(person: any) {
        const address = (person && person.actor && person.actor.Person && person.actor.Person.personaddress) ? person.actor.Person.personaddress : null;
        if (address && address.length) {
            return (
                address.filter((res: { danger: boolean; }) => {
                    return res.danger === true;
                }).length !== 0
            );
        } else {
            return false;
        }
    }

    fixNarrativeHistoryClearanceText(narr: string) {
        let n: string = narr;
        if (n) {
            n = n.replace(/(\\n)/g, '<br>');
            n = n.replace(/(\\r)/g, '');
            n = n.replace(/&nbsp;/g, ' ')
        }
        return n;
    }
    private listReportSummary(id: string) {
        const caseid = this.getCaseId();
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        if (caseid) {           
            this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + caseid)
            .subscribe((result: any) => {
                if (result) {
                    if (!isExpungementSuperUser) { 
                        this.handleReportSummaryResultFn(result);
                    } else {
                        this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ExpungedReportSummary + caseid)
                        .subscribe((resultencr: any) => {
                            if (resultencr) {
                                this.handleReportSummaryResultFn(resultencr);
                            } else {
                                this.handleReportSummaryResultFn(result);
                            }
                        });
                    }
                }
            });
        }
        this.checkIsCW();
    }
    // Assosiated to listReportSummary method
    private handleReportSummaryResultFn(result: any) {
        result.intakeservices = (result?.jsondata && result?.jsondata?.General && result?.jsondata?.General?.intakeservice?.length > 0) ? this.getSubprograms(result?.jsondata?.General?.intakeservice) : null;
        result.jsonData = null;
        result.reporterRoleName = this.reporterRoleList?.find(x => x.ref_key === result.reporterroletypekey)?.description || null;
        this.reportSummary = result;
        this._dataStoreService.setData('reportSummaryData', this.reportSummary);
       if(result.countyid) {
          this.storage.setItem('casecountyid', result.countyid);
       }
        this.isRequestService = (this.reportSummary?.intakeservicerequesttype && this.reportSummary?.intakeservicerequesttype.description === 'Request for services') ? true : false;
        this._dataStoreService.setData('CurrentSupervisor',
            (result?.userprofile) ? this.getSecurityusersid(result?.userprofile) : '');
        this.checkReportSummary();
        this.possibleIllegalActivityDropdown = this.buildCheckBox();
    }

    getCaseId() {
        const isServicecase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        const cpscaseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CPS_CASE_ID);
        return (isServicecase) ? cpscaseid : this.id;
    }

    checkReportSummary() {
        if (this.reportSummary && this.reportSummary?.narrative) {
            this.reportSummary.narrative = this.reportSummary?.narrative.replace('<a', '<a target="_blank"').replace(/'+'/g, '\'');
            this.narrativePresent = true;
            this.reportSummary.narrative = this.fixNarrativeHistoryClearanceText(this.reportSummary?.narrative);
            
            // FIX: Do not bypass security. Just assign the string.
            // this.textMarkUpNarrative = this.sanitize.bypassSecurityTrustHtml(this.reportSummary?.narrative);
            this.textMarkUpNarrative = this.reportSummary.narrative;
        }
        const reportSummaryDanger = this.reportSummary?.intakeservicerequestactor.filter(item => {
            if (item.actor) {
                if (item.actor.Person) {
                    return item.actor.Person.dangerlevel === 1;
                }
            }
        });
        if (reportSummaryDanger?.length !== 0) {
            this.disableNo = true;
        } else {
            this.disableNo = false;
        }
        const reportSummaryDangerAddress = this.reportSummary?.intakeservicerequestactor.filter(item => {
            if (item.actor) {
                return (
                    item.actor.Person?.personaddress?.filter(res => {
                        return res.danger === true;
                    }).length !== 0
                );
            }
        });
        if (reportSummaryDangerAddress?.length !== 0) {
            this.disableAddress = true;
        } else {
            this.disableAddress = false;
        }
        if (this.reportSummary?.servicerequestincidenttypekey) {
            this.significantEventDd = true;
        }
        if (this.reportSummary?.intakeservicerequestillegalactivity?.length) {
            this.illegalActivityDd = true;
        }
    }
    checkIsCW() {
        if (this._authService.isCW()) {
            this.isCW = true;
            this.legalGuardianCheck();
            this.getInvolvedUnkPerson();
        }
    }

    getSecurityusersid(userprofile: { securityusersid: any; }) {
        return userprofile.securityusersid ? userprofile.securityusersid : '';
    }
    getSubprograms(result: any) {
        let subprograms = '';
        if (result && result.length > 0) {
            if (result[0].description === 'I&R') {
                subprograms = result[0].description + ' ' + this.initialUpperCase(result[result.length - 1].description);
            } else {
                subprograms = [...new Set(result.map((item: { description: any; }) => this.initialUpperCase(item.description)))].map(x => x).join(' ');
            }
        }
        return subprograms;
    }
    initialUpperCase(string: any) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
    getChildRemoval() {
        this._commonHttpService
            .getSingle(
                {
                    where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID), 'objecttypekey': 'servicecase', isgroup: 1 },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .GetChildRemovalList + '?filter'
            ).subscribe((data: any) => {
                if (data && data.length) {
                    const approvedRemoval = data.filter((item: any) => {
                        if (item.childremoval && item.childremoval.length && item.childremoval[0]) {
                            const removal = item.childremoval[0];
                            return (removal.approvalstatus === 'Approved') ? true : false;
                        } else {
                            return false;
                        }
                    });
                    this.placementCheck(approvedRemoval);
                }
            });
    }

    placementCheck(removedChild: any[]) {
        forkJoin([this.getPlacementInfoList(1, 10), this.getPermanencyPlanList()]).subscribe(([placementData, plans]: any) => {
            const placmentArray: any[] = [];
            removedChild.forEach(child => {
                const cjamsPid = child.cjamspid;
                const personName = child.personname;
                let isActivePlacement = null;
                if (child.childremoval && child.childremoval.length) {
                    isActivePlacement = this.checkActivePlacement(child, placementData, plans, isActivePlacement)
                }
                const childPlacement = { 'cjamsPid': cjamsPid, 'personName': personName, 'isActivePlacement': isActivePlacement };
                placmentArray.push(childPlacement);

            });
            this._dataStoreService.setData('placment_check', placmentArray);
            this.notPlacedChildList = placmentArray.filter(placment => !placment.isActivePlacement);
            if (this.notPlacedChildList && this.notPlacedChildList.length) {
                this.legalguardianrolepopupDataFn();
            }
        });
    }

    checkActivePlacement(child: any, placementData: any, plans: any, isActivePlacement: any) {
        child.childremoval.forEach((rem: { exitdate: any; }) => {
            if (rem.exitdate) {
                isActivePlacement = true;
            } else {
                isActivePlacement = null;
                if (placementData && placementData.data && placementData.data.length) {
                    const placementList = placementData.data;
                    placementList.forEach((placement: any) => {
                        isActivePlacement = this.checkPlacements(child, placement, isActivePlacement, plans);
                    });
                }
            }
        });
        return isActivePlacement;
    }

    checkPlacements(child: { cjamspid: any; personid: any; }, placement: { placements: any; cjamspid: any; }, isActivePlacement: boolean, plans: any) {
        const placements = placement.placements;
        placements.forEach((plmnt: { routingstatus: string; enddate: any; }) => {
            if (((child.cjamspid).toString() === placement.cjamspid)
                && (plmnt.routingstatus === 'Approved' || plmnt.routingstatus === 'Review')
                && !plmnt.enddate) {
                isActivePlacement = true;
            } else {
                const permPlans = JSON.parse(JSON.stringify(plans));
                if (Array.isArray(permPlans)) {
                    const childPlan = permPlans.find(item => item.personid === child.personid);
                    if (childPlan && Array.isArray(childPlan.permanencyplans)) {
                        const activePP = childPlan.permanencyplans.find((item: { status: string; }) => item.status === 'Approved');
                        if (activePP) {
                            isActivePlacement = true;
                        }
                    }
                }
            }
        });
        return isActivePlacement;
    }

    getPlacementInfoList(pageNumber: number, limit: number) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: pageNumber,
                    limit: limit,
                    method: 'get',
                    where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
                }),
                'placement/getplacementbyservicecase?filter'
                // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            );
    }

    private getInvolvedPerson() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let url = '';

        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        let inputRequest;
        this.isUnconfirmed = false;
        if (this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE)) {
            inputRequest = {
                objectid: this.id,
                objecttypekey: 'servicecase',
                isExpungementSuperUser:isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        } else {
            inputRequest = {
                intakeserviceid: this.id,
                isExpungementSuperUser:isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        }
        forkJoin([
            this._commonHttpService
                .getPagedArrayList(
                    {
                        where: inputRequest,
                        page: 1,
                        limit: 50,
                        nolimit: true,
                        method: 'get'
                    },
                    `${url}?filter`
                )]).subscribe((result) => {
                    if (result.length && result[0] && result[0].data) {

                        this.personsInvolved = result[0].data;
                        this.handlePersonsInvolvedFn();
                        this.getcaregiverchildinfo();
                        this.ageAtReferralList = [];
                        this.personsInvolved.forEach(person => {
                            this.ageAtReferralList.push({
                                personid: person.personid, incidentage: person.incidentage
                            });
                        });
                        let activePersonFlag = true;
                        this.personsInvolved.forEach(item => {
                            if (item.programarea?.length > 0) {
                                activePersonFlag = false;
                            }
                        });
                        if (activePersonFlag) {
                            this._globalPopupService.setIdentifyActivePersons(true);     
                        } 
                        if (!this.ageAtReferralUpdated) {
                            this.updateAgeAtReferral();
                        }
                        this.checkPersonInvolved();
                        this.setChildDataForGlobalPopup(this.personsInvolved);
                    }
                });
    }
    // Assosiated with getInvolvedPerson method
    private handlePersonsInvolvedFn() {
        let pids: any[] = [];
        if (this.personsInvolved?.length > 0) {
            this.personsInvolved.forEach(p => {
                if (!pids?.includes(p?.personid)) {
                    pids.push(p?.personid);
                }
            });
            if (pids?.length > 0) {
                this?.getpregnants(pids);
            }
        }
    }

    checkPersonInvolved() {

        let openhospital = null;

        const currentDate = moment(new Date()).format(this.dtwithtimeformat);
        const currentSelDate = moment(currentDate, this.dtwithtimeformat);

        const dangerAddress = this.personsInvolved.filter(person => person.dangeraddress === true || person.dangeraddress === 1);
        const dangerSelf = this.personsInvolved.filter(person => person.dangerous && person.dangerous.length && person.dangerous[0] && (person.dangerous[0].isdangertoworker === 1));
        openhospital = this.personsInvolved?.filter(person => person.hospitaldetails && person.hospitaldetails.length && (!person.hospitaldetails[0]?.notificationdate || currentSelDate.diff(moment(person.hospitaldetails[0]?.notificationdate), 'days') >= 30));



        this.dangerousself = dangerSelf && dangerSelf.length ? true : false;
        this.dangerousaddress = dangerAddress && dangerAddress.length ? true : false;
        this.unSyncedMDMPersons = this.personsInvolved.filter(person => person.is_mdm_sync === false);
        if (this.unSyncedMDMPersons && this.unSyncedMDMPersons.length && this.dsdsActionsSummary.da_status !== 'Completed') {
            this.setshowlegislativecontent();
        }
        else {
            const store = this._dataStoreService.getCurrentStore();
            if (store?.object?.da_subtype === "CPS-AR" || store?.object?.da_subtype === "CPS-IR") {
                this.setshowlegislativecontent();
                this.serviceCaseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
                this.checkWorkload();
            }
            else {
                this.showlegislativecontent = false;
            }
        }

        this.UnconfirmedpersonsProcess(openhospital, currentSelDate);
        this.showBirthmatchMessage();
        this.notificationMessage();
        this.caseconnectpopupmessage();
    }

    UnconfirmedpersonsProcess(openhospital: any[], currentSelDate: any) {
        this.tempData = [];
        let hospitalList: any[] = [];
        let filterChildRoleRecords: any[] = [];
        const isUnconfirmedpersons = this.personsInvolved.filter(person => person.clientflag === 0);
        if (isUnconfirmedpersons && isUnconfirmedpersons.length > 0) {
            this.isUnconfirmed = true;
            $(this.legalguardianrolepopupid).modal('show');
        }
        if (openhospital && openhospital.length > 0 && this.isServiceCase) {
            openhospital.forEach(item => {
                const notificationDt = moment(item.hospitaldetails[0].notificationdate).format(this.dtwithtimeformat);
                const notificationDateformat = moment(notificationDt, this.dtwithtimeformat);
                if (this.checkIfChild(item)) {
                    if (this.checkHospitalDetailsCondFn(item, currentSelDate, notificationDateformat)) {
                        filterChildRoleRecords.push(item);
                        hospitalList.push(item.hospitaldetails[0]);
                    }
                }
            });
            if (filterChildRoleRecords && filterChildRoleRecords.length) {
                this.openHospitalizationRecords = filterChildRoleRecords;
                this.hospitalizationlist = hospitalList;

                this.setHopitalizationDataForGlobalPopup(this.openHospitalizationRecords, this.hospitalizationlist);
                
            }
        }
    }

    private setHopitalizationDataForGlobalPopup(openHospitalizationRecords: any, hospitalizationlist: any): void {
        const data = {
            'openHospitalizationRecords': openHospitalizationRecords,
            'hospitalizationlist': hospitalizationlist
        }
        this._globalPopupService.sethospitalizationData(data);
    }

    private setChildDataForGlobalPopup(personsInvolved: any[]) {
        if (!personsInvolved?.length) return;
        const personDetails = personsInvolved.filter(person =>
            person?.primarylanguageid === 'UNKN' &&            
            !this.isWithinLast5Days(person?.effectivedate)
        );
            this._globalPopupService.getChilderNames(personDetails);
    }

    private isWithinLast5Days(effectiveDate: any): boolean {
        if (!effectiveDate) return false;
        const now = new Date();
        const eff = /^\d{4}-\d{2}-\d{2}$/.test(String(effectiveDate))
            ? new Date(`${effectiveDate}T00:00:00`)
            : new Date(effectiveDate);
        if (isNaN(eff.getTime())) return false;
        const diffDays = (now.getTime() - eff.getTime()) / (1000 * 60 * 60 * 24);
        return diffDays >= 0 && diffDays <= 5;
    }

    private checkHospitalDetailsCondFn(item: any, currentSelDate: any, notificationDateformat: moment.Moment) {
        return (item.hospitaldetails && item.hospitaldetails.length && (item.hospitaldetails[0].notificationdate == null || currentSelDate.diff(moment(notificationDateformat), 'days') >= 30));
    }

    setshowlegislativecontent() {
        const stdate = moment(this.dsdsActionsSummary.da_receiveddate, this.dtwithtimeformat);
        const currenDate = moment(new Date()).format(this.dtwithtimeformat);
        const endDate = moment(currenDate, this.dtwithtimeformat);
        const resultdt = endDate.diff(stdate, 'days');
        if (this.responseTimerDueDateList?.malt_type === 'NEGLECT' && this.dsdsActionsSummary.da_status !== 'Completed' && resultdt >= 11 && this.hasFamilyAccessToCase && (this.responseTimerDueDateList?.responsetimer_status === 'Running' || this.responseTimerDueDateList?.responsetimer_status === 'Delay') && !this.hasSkip3 && (this.cpsResponseTimerList?.length === 0 || (this.cpsResponseTimerList?.length > 0 && this.cpsResponseTimerList[0].cpsresponsetimeractiontype !== 'Save') || this.isSupervisor)) {
            this.loadSupervisor();
            $(this.responsetimeoverduepopupid).modal('show');
            this.showlegislativecontent = true;
        }
        if (this.responseTimerDueDateList?.malt_type === 'ABUSE' && this.dsdsActionsSummary.da_status !== 'Completed' && resultdt >= 7 && this.hasFamilyAccessToCase && (this.responseTimerDueDateList?.responsetimer_status === 'Running' || this.responseTimerDueDateList?.responsetimer_status === 'Delay') && !this.hasSkip3 && (this.cpsResponseTimerList?.length === 0 || (this.cpsResponseTimerList?.length > 0 && this.cpsResponseTimerList[0].cpsresponsetimeractiontype !== 'Save') || this.isSupervisor)) {
            this.loadSupervisor();
            $(this.responsetimeoverduepopupid).modal('show');
            this.showlegislativecontent = true;
        }
    }
    checkWorkload() {
        this._commonHttpService.getArrayList({
            where: { servicecaseid: this.serviceCaseId ? this.serviceCaseId : this.id },
            method: 'get'
        },
            'Caseassignments/getworkload?filter'
        )
            .subscribe((result: any[]) => {
                if (result && result.length > 0) {
                    this.assignmentlist = result.filter((s: { responsibilitytypekey: any; }) => s?.responsibilitytypekey?.includes('family'));
                    if (this.assignmentlist && this.assignmentlist.length > 0) {
                        this.setshowlegislativecontent1();
                    }
                }
            });
    }

    setshowlegislativecontent1() {
        const stdate = moment(this.dsdsActionsSummary.da_receiveddate, this.dtwithtimeformat);
        const currenDate = moment(new Date()).format(this.dtwithtimeformat);
        const endDate = moment(currenDate, this.dtwithtimeformat);
        const resultdt = endDate.diff(stdate, 'days');
        if (this.responseTimerDueDateList?.malt_type === 'NEGLECT' && this.dsdsActionsSummary.da_status !== 'Completed' && resultdt >= 11 && this.hasFamilyAccessToCase && (this.responseTimerDueDateList?.responsetimer_status === 'Running' || this.responseTimerDueDateList?.responsetimer_status === 'Delay') && !this.hasSkip3 && ((!this.isSupervisor && this.cpsResponseTimerList?.length === 0) || (this.cpsResponseTimerList?.length > 0 && this.cpsResponseTimerList[0].cpsresponsetimeractiontype !== 'Save') || (this.isSupervisor && this.cpsSkipApproval === 'true'))) {
            this.loadSupervisor();
            $(this.responsetimeoverduepopupid).modal('show');
            this.showlegislativecontent = true;
        }
        this.checkAbuseType(resultdt);
    }

    checkAbuseType(resultdt: number) {
        if (this.responseTimerDueDateList?.malt_type === 'ABUSE' && this.dsdsActionsSummary.da_status !== 'Completed' && resultdt >= 7 && this.hasFamilyAccessToCase && (this.responseTimerDueDateList?.responsetimer_status === 'Running' || this.responseTimerDueDateList?.responsetimer_status === 'Delay') && !this.hasSkip3 && ((!this.isSupervisor && this.cpsResponseTimerList?.length === 0) || (this.cpsResponseTimerList?.length > 0 && this.cpsResponseTimerList[0].cpsresponsetimeractiontype !== 'Save') || (this.isSupervisor && this.cpsSkipApproval === 'true'))) {
            this.loadSupervisor();
            $(this.responsetimeoverduepopupid).modal('show');
            this.showlegislativecontent = true;
        }
    }
    showBirthmatchMessage() {
        setTimeout(() => {
            this.tempData = [];
            this.birthMatchMessage = ''
            this.personsInvolved.forEach(item => {
                if (!this.isClosed && item.birthmatchdetails !== null && item.birthmatchdetails[0].birthmatchflag === 1 && item.birthmatchdetails[0].nevershowagain === null && (moment().diff(moment(item.birthmatchdetails[0].birthmatchupdatedon), 'days')) < 60) {
                    const id = item.birthmatchdetails[0].personbirthmatchid;
                    this.birthMatchIds.push(id);
                    this.birthMatchMessage += item.fullname + ' is added as a Active Birth Match Client in this Case. <br>';
                    this.tempData.push({ name: this._globalPopupService.capitalizeWords(item.fullname), id: id, alerttype: 'Birth-Match' });

                }
            })
            if(this.tempData.length > 0) {
                this._globalPopupService.setMedicalPrescribedData(this.tempData);
            }
        }, 500);
    }
    notificationMessage() {
        setTimeout(() => {
            this.tempData = [];
            this.personsInvolved.forEach(item => {
                if (!this.isClosed && item.senstatusflag === 1 && this.hasFamilyAccessCase) {
                    this.tempData.push({ name: this._globalPopupService.capitalizeWords(item.fullname), id: item.personid, alerttype: 'Substance-New-Born' });

                    this.senNotificationPersonIds.push(item.personid);
                    this.senNotificationMessage += item.fullname + ' is added as a Active Substance New Born Client in this Case. <br>';
                }
                if (this.senNotificationMessage !== '') {
                    if (item.sennotifications && item.sennotifications.length) {
                        this.checkNotification(item);
                    } 
                }
            });
            if(this.tempData.length > 0) {
                this._globalPopupService.setMedicalPrescribedData(this.tempData);
            }
        }, 500)
    }
    caseconnectpopupmessage() {
        setTimeout(() => {
            this.tempData = [];
            this.personsInvolved.forEach(item => {
                if (!this.isClosed && item.senstatusflag === 1 && this.hasFamilyAccessCase && this.dsdsActionsSummary.caseconnectsent == 0) {
                    this.tempData.push({ name: this._globalPopupService.capitalizeWords(item.fullname), id: item.personid, alerttype: 'Substance-New-Born-Caseconnect' });

                     this.senNotificationPersonIds.push(item.personid);
                    this.senNotificationMessage += 'An Active Substance Exposed New Born is added to the case. A service case connect needs to be completed. <br>';
                }
                
            });
            if(this.tempData.length > 0) {
                this._globalPopupService.setcaseconnectsen(this.tempData);
            }
        }, 500)
    }
    checkNotification(item: any) {
        const filterSen = item.sennotifications.filter((a: any) => a.workerdetails === this._authService.getCurrentUser().user.securityusersid)
        if (filterSen && filterSen.length && filterSen[0].nevershowagain) {
            this.tempData = this.tempData.filter((data: any) => data.id !== item.personid)
        } 
    }

    updateAgeAtReferral() {
        if (this.ageAtReferralList && this.ageAtReferralList.length
            && this.involvedPersons && this.involvedPersons.length) {
            this.involvedPersons.forEach(person => {
                const matchedPerson = this.ageAtReferralList.find((item: {personid: any}) => item.personid === person.personid);
                if (matchedPerson) {
                    person.incidentage = matchedPerson.incidentage;
                }
            })
            this.ageAtReferralUpdated = true;

        }
    }

    getcaregiverchildinfo() {
        this.careGiverMessages = [];
        this._personService.getcaregiverchildinfo({
            serviceid: this._commonDDService.getStoredCaseUuid(),
            personid: (this.personsInvolved && this.personsInvolved.length > 0) ? this.personsInvolved[0].personid : null
        }).subscribe((res: any) => {
            this.careGiverMessages = res;
            if (this.careGiverMessages && this.careGiverMessages.length > 0) {
                $(this.legalguardianrolepopupid).modal('show');
            }
        });
    }

    legalGuardianCheck() {
        this.isLGPresent = false;
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 50,
                    nolimit: true,
                    method: 'get',
                    where: this.getRequestParam()
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            ).subscribe((result: { data: any; }) => {
                const items = result.data;
                if (items) {
                    this.getInvolvedChildrenAndOthers(items);
                    if (!this.ageAtReferralUpdated) {
                        this.updateAgeAtReferral();
                    }
                }

                this.infants = items.filter((person: { dob: any; }) => {
                    const childAge: any = this.getAge(person.dob);
                    if (childAge <= 3) {
                        return true;
                    } else {
                        return false;
                    }
                });
            });
    }
    ifChildExist() {
        if (this.involvedPersons && this.involvedPersons.length) {
            let childCount = 0;
            this.involvedPersons.forEach(person => {
                const isChildExist = this.checkIfChild(person);
                if (isChildExist) {
                    childCount = childCount + 1;
                }
            });
            return childCount ? true : false;
        } else {
            return true;
        }
    }
    checkIfChild(child: { roles: any[]; }) {
        if (child && child.roles && child.roles.length) {
            const isChild = child.roles.find(role => role.intakeservicerequestpersontypekey === 'AV' || role.intakeservicerequestpersontypekey === 'CHILD');
            return isChild ? true : false;
        } else {
            return false;
        }
    }

    getRoleDescription(roles: any[]) {
        if (roles && roles.length) {
            const roleArray = roles.filter(role => role.intakeservicerequestpersontypekey === 'AV' || role.intakeservicerequestpersontypekey === 'CHILD');
            let roleDesc = '';
            if (roleArray && roleArray.length) {
                roleArray.forEach((role, index) => {
                    roleDesc = roleDesc + role.typedescription + ((index !== (roleArray.length - 1)) ? ', ' : '');
                });
            }
            return roleDesc ? roleDesc : null;

        } else {
            return null;
        }
    }

    getInvolvedUnkPerson() {
        this.isUnkPresent = false;
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeserviceid: this.id ,  isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged}
                }),
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.UnkPersonList}?filter`
            )
            .subscribe((data: any[]) => {
                this.involevedUnkPerson = data;
                if (this.involevedUnkPerson) {
                    const unkPersonList = this.involevedUnkPerson.filter(item => item.isNew);
                    if (unkPersonList && unkPersonList.length > 0) {
                        this.isUnkPresent = true;
                        $(this.legalguardianrolepopupid).modal('show');
                    }
                }
            });
    }

    getRequestParam() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        let inputRequest: Object;
        if (this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE)) {
            inputRequest = {
                objectid: this.id,
                objecttypekey: 'servicecase'
            };
        } else {
            inputRequest = {
                intakeservreqid: this.id,
                'isExpungementSuperUser': isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        }
        return inputRequest;
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

    getInvolvedChildrenAndOthers(invlovedPersonsList: any[]) {
        invlovedPersonsList.map((item, $index) => {
            this.checkPersonRole(item);
            if (item.rolename === 'LG') {
                this.LegalGuardian = (this.LegalGuardian ? this.LegalGuardian : '') + ($index !== 0 ? ', ' : '') + item.firstname + ' ' + item.lastname;
            }
        });

        this.checkHOH(invlovedPersonsList);
    }

    checkPersonRole(item: any) {
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
            this.involvedPersons.push(item);
        } else {
            this.involvedChildren.push(item);
            this.involvedPersons.push(item);
        }
    }

    checkHOH(invlovedPersonsList: any[]) {
        const reportSummaryHOH = invlovedPersonsList.filter(item => {
            return item.isheadofhousehold === true;
        });
        if (reportSummaryHOH && reportSummaryHOH.length !== 0) {
            this.hohPersonName = reportSummaryHOH[0] && reportSummaryHOH[0].fullname ? reportSummaryHOH[0].fullname : '';
        } else {
            this.hohPersonName = '';
            const store = this._dataStoreService.getCurrentStore();
            if (store['da_status'] !== 'Closed' && store['da_status'] !== 'Completed') {
                this.isLGPresent = true;
                this.legalguardianrolepopupDataFn();
            }
        }
    }

    loadReasonDropDown() {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 101, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                this.reasonDropDown = data;

            });
    }

    loadReporterRole() {

        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 165, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {
                this.reporterRoleList = data;

            });
    }

    loadStatusDropDown() {

        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 102, teamtypekey: 'CW' },
                    method: 'get'
                },
                `${this.gettypesurl}?filter`
            ).subscribe((data: any) => {

                this.closureSubTypeItems = data.map((res: { value_text: any; ref_key: any; }) =>
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
            ).subscribe((data: any) => {
                this.serviceDropDown = data;

            });

    }

    getRiskDropDown(array: any) {
        const riskDropDown: any = [];
        if (array && array.length) {
            array.forEach((data: any) => {
                const obj = data;
                riskDropDown.push(obj);
            });
        }
        return riskDropDown ? riskDropDown : [];
    }


    setRiskDropDown(array: string) {
        const riskDropDown: any = [];
        if (array && array.length) {
            const arryriskdropdown = array.split(',');
            arryriskdropdown.forEach(data => {
                riskDropDown.push(data);
            });
        }
        return riskDropDown ? riskDropDown : [];
    }

    chooseAssessmentParticipant(event: { checked: any; }, child: { intakeservicerequestactorid: any; }, isChild: any) {
        const participantObj = {
            intakeservicerequestactorid: child.intakeservicerequestactorid,
            ischild: isChild
        };
        if (this.AssessmentParticipant && this.AssessmentParticipant.length) {
            // AssessmentParticipant Array Null Check
        } else {
            this.AssessmentParticipant = [];
        }
        if (event.checked) {
            this.AssessmentParticipant.push(participantObj);
        } else {
            const index = this.AssessmentParticipant.findIndex(p => p.intakeservicerequestactorid === child.intakeservicerequestactorid);
            this.selectedChild.splice(index, 1);
        }
    }
    chooseChildren(event: { checked: any; }, child: { intakeservicerequestactorid: any; }) {
        if (event.checked) {
            this.selectedChild.push(child.intakeservicerequestactorid);
        } else {
            const selectedItem = child.intakeservicerequestactorid;
            const index = this.selectedParticipant.indexOf(selectedItem);
            this.selectedChild.splice(index, 1);
        }
    }
    chooseParticipant(event: { checked: any; }, participant: { intakeservicerequestactorid: any; }) {
        if (event.checked) {
            this.selectedParticipant.push(participant.intakeservicerequestactorid);
        } else {
            const selectedItem = participant.intakeservicerequestactorid;
            const index = this.selectedParticipant.indexOf(selectedItem);
            this.selectedParticipant.splice(index, 1);
        }
    }

    getChildName(childList: any[]) {
        let childNameList = '';
        if (childList && childList.length) {
            childList.forEach((child, index) => {
                childNameList = childNameList + ' "' + child.personName + '"' + ((index !== childList.length - 1) ? ', ' : '');
            });
        }
        return childNameList;
    }

    saveARCAseSummary(caseCreatedDate?: any) {
        this.ARCaseSummaryForm.patchValue({
            participants: this.AssessmentParticipant ? this.AssessmentParticipant : [],
            caseclosuresummaryid: this.caseclosuresummaryid
        });
        const ARCaseSummaryData = this.ARCaseSummaryForm.getRawValue();
        this.statusTempDropDown = [];
        ARCaseSummaryData.statusList.forEach((item: any, index: any) => {
            if (item) {
                this.statusTempDropDown.push(this.closureSubTypeItems[index].value);
            }
        });
        ARCaseSummaryData.closuresubtypekey = this.statusTempDropDown;
        ARCaseSummaryData.intakeserviceid = this.id;
        ARCaseSummaryData.interventionissues = this.getRiskDropDown(ARCaseSummaryData.interventionissues);

        if (ARCaseSummaryData) {
            this._commonHttpService
                .create(ARCaseSummaryData, 'caseclosuresummary/addupdate')
                .subscribe(() => {
                    this._alertService.success('AR case  summary submitted successfully');
                });
        }
    }

    activateSpeechToText(type: any): void {
        this.currentSpeechRecInput = type;
        this.recognizing = type;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                // listener
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


    ngAfterViewChecked() {
        if (this.narrativePresent) {
            const cnData = document.getElementById('reportSummaryNarrative');
            if(cnData) {
                const cn = cnData?.children;
                for (const element of Array.from(cn)) {
                    if (element.tagName == 'pre' || element.tagName == 'PRE') {
                        element.setAttribute('style', 'white-space: pre-line;');
                    }
                }
            }
        }
    }

    ngOnDestroy(): void {
        this._speechRecognitionService.destroySpeechObject();
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
        if (value === 'ONGS') {
            this.clientrefrdservicesdisabled = true;
            this.ARCaseSummaryForm.patchValue({ clientrefrdservices: '' });
            this.statuslistdisabled = true;
            this.unchecksubtypes();
        } else if (value === 'CONS') {
            this.clientrefrdservicesdisabled = false;
            this.statuslistdisabled = true;
            this.unchecksubtypes();
        } else if (value === 'LDSS' || value === 'RRMS') {
            this.clientrefrdservicesdisabled = true;
            this.ARCaseSummaryForm.patchValue({ clientrefrdservices: '' });
            this.statuslistdisabled = false;
            if (value === 'RRMS') {
                this.unchecksubtypes();
            }
        }
    }

    getARSummaryCase() {
        this._commonHttpService.getArrayList({
            where: {
                intakeserviceid: this.id
            },
            method: 'get',
            page: 1,
            limit: 10
        }, 'caseclosuresummary?filter').subscribe((item: any) => {

            if (item && item.length && item[0]) {
                this.patchARCaseSummaryForm(item);
                const status = <FormArray>this.ARCaseSummaryForm.controls['statusList'];
                this.closureSubTypeItems.forEach(function (closuresubtype, index) {
                    let resp = item[0].closuresubtypekey;
                    if (resp === null || resp === undefined) {
                        resp = '';
                    }
                    const temp = resp.split(',');
                    temp.forEach(function (sub: any, subindex: any) {
                        if (closuresubtype.value === sub) {
                            status.push(new FormControl(true));
                        }
                    });
                    if (status.length === index) {
                        status.push(new FormControl(false));
                    }
                });

                if (item[0].closuretypekey) {
                    this.onChangeClosureStatus(item[0].closuretypekey);
                }
            }
        });

    }
    patchARCaseSummaryForm(item: any) {
        this.ARCaseSummaryForm = this.formBuilder.group({
            reason: item[0].reason,
            caseclosuresummaryid: item[0].caseclosuresummaryid,
            intakeserviceid: item[0].intakeserviceid,
            referralreason: item[0].referralreason,
            riskissues: item[0].riskissues,
            recommendation: item[0].recommendation,
            statusList: this.formBuilder.array([]),
            clientrefrdservices: null,
            closuretypekey: item[0].closuretypekey,
            interventionissues: null,
            notes: item[0].notes,
            participants: item[0].participants ? item[0].participants : null
        });
        this.caseclosuresummaryid = item[0].caseclosuresummaryid;
        this.savedParticipants = item[0].participants;
        if (item[0].interventionissues) {
            const riskData = this.setRiskDropDown(item[0].interventionissues);
            this.ARCaseSummaryForm.patchValue({ interventionissues: riskData });
        }

        if (item[0].clientrefrdservices) {
            const clientrefrdservicesdata = this.setRiskDropDown(item[0].clientrefrdservices);
            this.ARCaseSummaryForm.patchValue({ clientrefrdservices: clientrefrdservicesdata });
        }
    }



    getServicePlans() {
      
        this._commonHttpService.getArrayList({
            where: {
                caseid: this.id,
                casetype: 'reportsummary'
            },
            method: 'get',
            page: 1,
            limit: 10
        }, 'serviceplan/ebpplandetails?filter').subscribe((item) => {
            if(item && item.length){
                this.clientNamesForEbp = _.uniqBy(item, 'clientid');
                // isebpreferralmade
                if(this.clientNamesForEbp && this.caseworkerFamilyAccess) {
                    this.tempData = [];
                    this.clientNamesForEbp?.forEach((_item: any) => {
                        this.tempData.push({ name: this._globalPopupService.capitalizeWords(_item.client_nm), id: _item.clientid, alerttype: 'EBP-Warning-Message' });
                    });

                    if(this.tempData.length > 0){                        
                        this._globalPopupService.setMedicalPrescribedData(this.tempData);
                    }
                }
            }
        });

    }

    getPermanencyPlanList() {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    nolimit: true,
                    method: 'get',
                    where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
                }),
                'permanencyplan/list?filter'
                // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            ).pipe(map(data => data));
    }

    getDateFormat(date: any) {
        if (date) {
            return moment(date).format(this.dtformat);
        } else {
            return '';
        }
    }
    birthMatchDisplay() {
        if (this.birthMatchIds.length > 0) {
            this._commonHttpService
                .create({ personbirthmatchids: this.birthMatchIds }, 'People/updatebirthmatch')
                .subscribe();
        }
    }

    createNotification(notoficationArray: any, item: any) {
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const notificationData:any ={}
        notificationData.objectid = this.id;
        notificationData.isexternalentity = 'false'
        notificationData.subject = `Active Substance Exposed New Born (${item.fullname.replace("'", " ").trim()} / ${item.cjamspid}) is added to case ${caseInfo.da_number}`;
        notificationData.priorityleveltypekey = 'High'
        notificationData.usernotificationtypekey = 'System'
        notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
        notificationData.securityusersid = this._authService.getCurrentUser().user.securityusersid;
        notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
        notificationData.objectcasenumber = caseInfo.da_number;
        notificationData.servicerequestnumber = caseInfo.da_number;
        notificationData.body = `${item.fullname.trim()} is added as a Active Birth Match Client in this Case.`;

        this._commonHttpService.create(notificationData, 'Usernotifications/getSingle').subscribe((res) => {
            if(res && res.length === 0){
                this._commonHttpService.create(notificationData, 'Usernotifications/Add').subscribe(() => {
                    this.handleNotoficationArrayLoopFn(notoficationArray, notificationData);
                })
            }
        });
    }
    // Assosiated to createNotification method
    private handleNotoficationArrayLoopFn(notoficationArray: any, notificationData: any) {
        notoficationArray.forEach((notification: any) => {
            const userId = notification.toworkerdetails[0].securityusersid;
            const supervisorId = notification.toworkerdetails[0].supervisorid;
            notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
            notificationData.securityusersid = userId;
            notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
            this._commonHttpService.create(notificationData, 'Usernotifications/getSingle').subscribe((resp) => {
                if (resp && resp.length === 0) {
                    this._commonHttpService.create(notificationData, 'Usernotifications/Add').subscribe(() => {
                        this.reusableNotificationAddServiceFn(notificationData, supervisorId);
                    });
                } else {
                    this.reusableNotificationAddServiceFn(notificationData, supervisorId);
                }
            });
        });
    }
    // Assosiated to createNotification method
    private reusableNotificationAddServiceFn(notificationData: any, supervisorId: any) {
        notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
        notificationData.securityusersid = supervisorId;
        notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
        this._commonHttpService.create(notificationData, 'Usernotifications/getSingle').subscribe((result) => {
            if (result && result.length === 0) {
                this._commonHttpService.create(notificationData, 'Usernotifications/Add');
            }
        });
    }

    submitOverdue() {

        if ((!this.hideallegeddropdown && this.allegedVictimreasonDropDown1 && this.allegedVictimreasonDropDown1?.length > 0 && this.selectAllegedVictimReason1 == undefined) ||
            (this.allegedVictimreasonDropDown2 && this.allegedVictimreasonDropDown2?.length > 0 && this.selectAllegedVictimReason2 == undefined && !this.enableAllegedDataEntryErrorReason) ||
            (this.allegedVictimreasonDropDown3 && this.allegedVictimreasonDropDown3?.length > 0 && this.selectAllegedVictimReason3 == undefined) ||
            (!this.hideotherchilddropdown && this.otherChildrenreasonDropDown1 && this.otherChildrenreasonDropDown1?.length > 0 && this.selectOtherChildReason1 == undefined) ||
            (this.otherChildrenreasonDropDown2 && this.otherChildrenreasonDropDown2?.length > 0 && this.selectOtherChildReason2 == undefined && !this.enableChildrenDataEntryErrorReason) ||
            (!this.hidecaregiverdropdown &&  this.caregiverreasonDropDown1 && this.caregiverreasonDropDown1?.length > 0 && this.selectCaregiverReason1 == undefined)
        ) {
            this._alertService.error(this.mandatoryErrorMsg);
            return;
        }

        if (this.caregiverreasonCheck()) {
            this._alertService.error(this.mandatoryErrorMsg);
            return;
        }

        if (!this.cpsActionSelectedSupervisor) {
            this._alertService.error(this.mandatoryErrorMsg);
            return;
        }
        this.submitresponse();
    }

    caregiverreasonCheck() {
        if ((this.caregiverreasonDropDown2 && this.caregiverreasonDropDown2?.length > 0 && this.selectCaregiverReason2 == undefined && !this.enableCaregiverDataEntryErrorReason) ||
            (this.caregiverreasonDropDown3 && this.caregiverreasonDropDown3?.length > 0 && this.selectCaregiverReason3 == undefined)
        ) {
            return true;
        } else {
            return false;
        }
    }

    submitresponse() {
        let obj;
        if (this.cpsresponsetimeractionsid !== "") {
            this.skipname?.split(" ");
            obj = {
                cpsresponsetimeractionsid: null,
                isskipped: false,
                cpsresponsetimeractiontype: "Save",
                allegedvictimcontact: this.chkAllegedVictim,
                otherchildrencontact: this.chkOtherChild,
                initialcaregivercontact: this.chkCaregiver,
                intakeserviceid: this.id,
                securityuserid: this._authService.getCurrentUser().user.securityusersid,
                reason: this.reason,
                cpsresponsetimerreason1: this.selectAllegedVictimReason1,
                cpsresponsetimerreason2: this.selectAllegedVictimReason2,
                cpsresponsetimerreason3: this.selectAllegedVictimReason3,
                cpsresponsetimerreason4: this.selectOtherChildReason1,
                cpsresponsetimerreason5: this.selectOtherChildReason2,
                cpsresponsetimerreason6: this.selectOtherChildReason3,
                cpsresponsetimerreason7: this.selectCaregiverReason1,
                cpsresponsetimerreason8: this.selectCaregiverReason2,
                cpsresponsetimerreason9: this.selectCaregiverReason3,
                caseworkercomments: this.caseWorkerComment,
                supervisorid: this.cpsActionSelectedSupervisor,
                approvalstatus: 15
            };
        }
        else {
            obj = {
                cpsresponsetimeractionsid: null,
                isskipped: false,
                cpsresponsetimeractiontype: "Save",
                allegedvictimcontact: this.chkAllegedVictim,
                otherchildrencontact: this.chkOtherChild,
                initialcaregivercontact: this.chkCaregiver,
                intakeserviceid: this.id,
                securityuserid: this._authService.getCurrentUser().user.securityusersid,
                reason: this.reason,
                cpsresponsetimerreason1: this.selectAllegedVictimReason1,
                cpsresponsetimerreason2: this.selectAllegedVictimReason2,
                cpsresponsetimerreason3: this.selectAllegedVictimReason3,
                cpsresponsetimerreason4: this.selectOtherChildReason1,
                cpsresponsetimerreason5: this.selectOtherChildReason2,
                cpsresponsetimerreason6: this.selectOtherChildReason3,
                cpsresponsetimerreason7: this.selectCaregiverReason1,
                cpsresponsetimerreason8: this.selectCaregiverReason2,
                cpsresponsetimerreason9: this.selectCaregiverReason3,
                caseworkercomments: this.caseWorkerComment,
                supervisorid: this.cpsActionSelectedSupervisor,
                approvalstatus: 15

            };
        }
        this._commonHttpService.create(obj, this.cpsresponsetimeraddupdateurl).subscribe(response => {
            this._alertService.success('Response submitted successfully');
            setTimeout(() => {
                $(this.responsetimeoverduepopupid).modal('hide');
            }, 100)
        },
            (error) => {
                this._alertService.warn(this.errmsg);
            });

        $(this.overduepopupid).modal('hide');
    }

    savetheOverdue() {
        const obj = {
            cpsresponsetimeractionsid: null,
            isskipped: true,
            cpsresponsetimeractiontype: "Skip 2",
            allegedvictimcontact: this.chkAllegedVictim,
            otherchildrencontact: this.chkOtherChild,
            initialcaregivercontact: this.chkCaregiver,
            intakeserviceid: this.id,
            securityuserid: this._authService.getCurrentUser().user.securityusersid,
            reason: this.reason,
            cpsresponsetimerreason1: this.selectAllegedVictimReason1,
            cpsresponsetimerreason2: this.selectAllegedVictimReason2,
            cpsresponsetimerreason3: this.selectAllegedVictimReason3,
            cpsresponsetimerreason4: this.selectOtherChildReason1,
            cpsresponsetimerreason5: this.selectOtherChildReason2,
            cpsresponsetimerreason6: this.selectOtherChildReason3,
            cpsresponsetimerreason7: this.selectCaregiverReason1,
            cpsresponsetimerreason8: this.selectCaregiverReason2,
            cpsresponsetimerreason9: this.selectCaregiverReason3,
        };
        this._commonHttpService.create(obj, this.cpsresponsetimeraddupdateurl).subscribe(response => {
            this._alertService.success('Response submitted successfully');
            setTimeout(() => {
                $(this.responsetimeoverduepopupid).modal('hide');
            }, 1000)
        },
            (error) => {
                this._alertService.warn(this.errmsg);
            });

        $(this.overduepopupid).modal('hide');

    }
    closeOverduePopup(autoSkip: boolean) {
        if (autoSkip && !this.showlegislativecontent) {
            return;
        }

        let obj;
        if (this.cpsresponsetimeractionsid !== "") {
            const skipsplit = this.skipname?.split(" ");
            const skipsplitval = skipsplit ? parseInt(skipsplit[1]) + 1 : '';

            obj = {
                cpsresponsetimeractionsid: null,
                isskipped: true,
                cpsresponsetimeractiontype: "Skip " + '' + skipsplitval,
                allegedvictimcontact: this.chkAllegedVictim,
                otherchildrencontact: this.chkOtherChild,
                initialcaregivercontact: this.chkCaregiver,
                intakeserviceid: this.id,
                securityuserid: this._authService.getCurrentUser().user.securityusersid,
                reason: this.reason,
                cpsresponsetimerreason1: this.selectAllegedVictimReason1,
                cpsresponsetimerreason2: this.selectAllegedVictimReason2,
                cpsresponsetimerreason3: this.selectAllegedVictimReason3,
                cpsresponsetimerreason4: this.selectOtherChildReason1,
                cpsresponsetimerreason5: this.selectOtherChildReason2,
                cpsresponsetimerreason6: this.selectOtherChildReason3,
                cpsresponsetimerreason7: this.selectCaregiverReason1,
                cpsresponsetimerreason8: this.selectCaregiverReason2,
                cpsresponsetimerreason9: this.selectCaregiverReason3,

            };
        }
        else {
            obj = {
                cpsresponsetimeractionsid: null,
                isskipped: true,
                cpsresponsetimeractiontype: "Skip 1",
                allegedvictimcontact: this.chkAllegedVictim,
                otherchildrencontact: this.chkOtherChild,
                initialcaregivercontact: this.chkCaregiver,
                intakeserviceid: this.id,
                securityuserid: this._authService.getCurrentUser().user.securityusersid,
                reason: this.reason,
                cpsresponsetimerreason1: this.selectAllegedVictimReason1,
                cpsresponsetimerreason2: this.selectAllegedVictimReason2,
                cpsresponsetimerreason3: this.selectAllegedVictimReason3,
                cpsresponsetimerreason4: this.selectOtherChildReason1,
                cpsresponsetimerreason5: this.selectOtherChildReason2,
                cpsresponsetimerreason6: this.selectOtherChildReason3,
                cpsresponsetimerreason7: this.selectCaregiverReason1,
                cpsresponsetimerreason8: this.selectCaregiverReason2,
                cpsresponsetimerreason9: this.selectCaregiverReason3,


            };
        }
        this.disableSubmitforApproval = true;
        this._commonHttpService.create(obj, this.cpsresponsetimeraddupdateurl).subscribe(response => {
            this.closeOverdueRolePopup();
            setTimeout(() => {
                $(this.responsetimeoverduepopupid).modal('hide');
            }, 100)
            const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/recording/notes';
            setTimeout(() => {
                this._router.navigateByUrl('/', { skipLocationChange: true }).then(() => this._router.navigate([currentUrl]));
            }, 1000);
        },
            (error) => {
                this._alertService.warn(this.errmsg);
                this.disableSubmitforApproval = false;
            });

    }


    clickOnIdentifyActiveOk() {
        $('#identify-active-persons').modal('hide');
    }

    closeOverdueRolePopup() {
        $(this.legalguardianrolepopupid).modal('hide');
    }

    closeTimerPopup() {
        if (!this.isSupervisor) {
            if (this.showapprovebtn) {
                this.sendForApproval();
            } else {
                this.closeOverduePopup(true);
            }
        } else {
            setTimeout(() => {
                $(this.responsetimeoverduepopupid).modal('hide');
            }, 1000)
        }
    }

    getcpsresponsetimerActions(model: boolean) {
        const obj = {
            "intakeserviceid": this.id
        }
        this._commonHttpService.create(obj, 'cpsresponsetimeractions/list').subscribe((response: any) => {
            if (response?.data?.length > 0) {
                this.cpsResponseTimerList = response.data;
                this.hasSavedResponseTimerRecord = true;
                this.checkCpsResponsetimeractions(response);
            } else {
                this.hasSavedResponseTimerRecord = false;
                this.cpsResponseTimerList = [];
                if (response.data === undefined) {
                    this.hideskipbtn = true;
                }
                this.showlegislativecontentflag();
            }
            if (model) {
                this.getAssignmentsList();
            }
        },
            (error) => {
                this._alertService.warn(this.errmsg);
            }
        );

    }
    checkCpsResponsetimeractions(response: { data: any; }) {
        this.skipFlags();
        this.hideallegeddropdownflag();
        this.hideotherchilddropdownflag();
        this.hidecaregiverdropdownflag();
        this.checkResponseTimerActionType();
        this.checkSkip1Response(response);
        this.checkSkip2Response(response);
        this.checkPrevSkipList(response)
        const saveddetails = response.data[0];
        if (saveddetails && !saveddetails.isskipped && !this.isSupervisor) {
            setTimeout(() => {
                $(this.responsetimeoverduepopupid).modal('hide');
            }, 100)
        }

        this.selectedAllegedVictimReason1FromService(581, saveddetails.cpsresponsetimerreason1);
        this.selectedAllegedVictimReason2FromService(582, saveddetails.cpsresponsetimerreason2);

        this.selectedOtherChildReason1FromService(584, saveddetails.cpsresponsetimerreason4);
        this.selectedOtherChildReason2FromService(585, saveddetails.cpsresponsetimerreason5);

        this.selectedCaregiverReason1FromService(587, saveddetails.cpsresponsetimerreason7);
        this.selectedCaregiverReason2FromService(588, saveddetails.cpsresponsetimerreason8);

        this.selectAllegedVictimReason1 = saveddetails.cpsresponsetimerreason1;
        this.selectOtherChildReason1 = saveddetails.cpsresponsetimerreason4;
        this.selectCaregiverReason1 = saveddetails.cpsresponsetimerreason7;

        setTimeout(() => {
            this.selectAllegedVictimReason2 = this.isJson(saveddetails.cpsresponsetimerreason2) ? JSON.parse(saveddetails.cpsresponsetimerreason2) : saveddetails.cpsresponsetimerreason2;
            this.selectOtherChildReason2 = this.isJson(saveddetails.cpsresponsetimerreason5) ? JSON.parse(saveddetails.cpsresponsetimerreason5) : saveddetails.cpsresponsetimerreason5;
            this.selectCaregiverReason2 = this.isJson(saveddetails.cpsresponsetimerreason8) ? JSON.parse(saveddetails.cpsresponsetimerreason8) : saveddetails.cpsresponsetimerreason8;
        }, 1000);

        setTimeout(() => {
            this.selectAllegedVictimReason3 = saveddetails.cpsresponsetimerreason3;
            this.selectOtherChildReason3 = saveddetails.cpsresponsetimerreason6;
            this.selectCaregiverReason3 = saveddetails.cpsresponsetimerreason9;
        }, 2000);

        if (!this.chkAllegedVictim) {
            this.allegedVictimChange('580');
        }
        if (!this.chkOtherChild) {
            this.otherChildChange('583');
        }
        if (!this.chkCaregiver) {
            this.caregiverChange('586');
        }
    }

    showlegislativecontentflag() {
        const stdate = moment(this.dsdsActionsSummary.da_receiveddate, this.dtwithtimeformat);
        const currenDate = moment(new Date()).format(this.dtwithtimeformat);
        const endDate = moment(currenDate, this.dtwithtimeformat);
        const resultdt = endDate.diff(stdate, 'days');
        if (this.responseTimerDueDateList?.malt_type === 'NEGLECT' && resultdt >= 11 && this.dsdsActionsSummary.da_status !== 'Completed' && this.hasFamilyAccessToCase && (this.responseTimerDueDateList?.responsetimer_status === 'Running' || this.responseTimerDueDateList?.responsetimer_status === 'Delay') && !this.hasSkip3 && (this.cpsResponseTimerList?.length === 0 || (this.cpsResponseTimerList?.length > 0 && this.cpsResponseTimerList[0].cpsresponsetimeractiontype !== 'Save') || this.isSupervisor)) {
            this.hideskipbtn = false;
            this.loadSupervisor();
            $(this.responsetimeoverduepopupid).modal('show');
            this.showlegislativecontent = true;
        }
        if (this.responseTimerDueDateList?.malt_type === 'ABUSE' && resultdt >= 7 && this.dsdsActionsSummary.da_status !== 'Completed' && this.hasFamilyAccessToCase && (this.responseTimerDueDateList?.responsetimer_status === 'Running' || this.responseTimerDueDateList?.responsetimer_status === 'Delay') && !this.hasSkip3 && (this.cpsResponseTimerList?.length === 0 || (this.cpsResponseTimerList?.length > 0 && this.cpsResponseTimerList[0].cpsresponsetimeractiontype !== 'Save') || this.isSupervisor)) {
            this.hideskipbtn = false;
            this.loadSupervisor();
            $(this.responsetimeoverduepopupid).modal('show');
            this.showlegislativecontent = true;
        }
    }

    skipFlags() {
        const checkSkip2 = this.cpsResponseTimerList.filter((item: { cpsresponsetimeractiontype: string; }) => item.cpsresponsetimeractiontype === 'Skip 2');
        const checkSkip3 = this.cpsResponseTimerList.filter((item: { cpsresponsetimeractiontype: string; }) => item.cpsresponsetimeractiontype === 'Skip 3');

        if (checkSkip2.length > 0 && checkSkip3.length === 0) {
            this.showSkip3Label = true;
        }

        if (checkSkip3.length > 0) {
            this.hasSkip3 = true;
        }
    }
    hideallegeddropdownflag() {
        if (this.cpsResponseTimerList[0].allegedvictimcontact !== undefined && this.cpsResponseTimerList[0].allegedvictimcontact !== null) {
            this.chkAllegedVictim = (this.cpsResponseTimerList[0].allegedvictimcontact == 'true' || this.cpsResponseTimerList[0].allegedvictimcontact == 'Y') ? true : false;
            if (this.chkAllegedVictim) {
                this.hideallegeddropdown = true;
            } else {
                this.hideallegeddropdown = false;
            }
        }
    }

    hideotherchilddropdownflag() {
        if (this.cpsResponseTimerList[0].otherchildrencontact !== undefined && this.cpsResponseTimerList[0].otherchildrencontact !== null) {
            this.chkOtherChild = (this.cpsResponseTimerList[0].otherchildrencontact == 'true' || this.cpsResponseTimerList[0].otherchildrencontact == 'Y') ? true : false;
            if (this.chkOtherChild) {
                this.hideotherchilddropdown = true;
            } else {
                this.hideotherchilddropdown = false;
            }
        }
    }

    hidecaregiverdropdownflag() {
        if (this.cpsResponseTimerList[0].initialcaregivercontact !== undefined && this.cpsResponseTimerList[0].initialcaregivercontact !== null) {
            this.chkCaregiver = (this.cpsResponseTimerList[0].initialcaregivercontact == 'true' || this.cpsResponseTimerList[0].initialcaregivercontact == 'Y') ? true : false;
            if (this.chkCaregiver) {
                this.hidecaregiverdropdown = true;
            } else {
                this.hidecaregiverdropdown = false;
            }
        }
    }
    checkResponseTimerActionType() {
        if ((this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Save' || this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Skip 2' || this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Skip 3') && (this.cpsResponseTimerList[0].approvedby === null || this.cpsResponseTimerList[0].approvedby === "")) {
            this.checkResponseTimerActions();
        } else if (this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Save' && this.cpsResponseTimerList[0].approvedby !== null && this.cpsResponseTimerList[0].routingstatustypeid === 16) {
            this.canSaveResponseTimer = false;
        }
    }
    checkResponseTimerActions() {
        if ((this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Save') && this.cpsResponseTimerList[0].approvedby === null) {
            this.hasSaveForApproval = true;
        }
        if (this.checkCpsresponsetimeractiontypeFn()) {
            this.showSkip3Label = true;
        } else {
            this.showSkip3Label = false;
        }
        if (this.isSupervisor && (this.hasSaveForApproval || this.showSkip3Label) && !this.fromoverduelink) {
            this.fromoverduelink = false;
        } else {
            this.fromoverduelink = true;
        }
        if (this.cpsResponseTimerList[0].routingstatustypeid === 17) {
            this.canSaveResponseTimer = true;
        } else if (this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Skip 2') {
            this.canSaveResponseTimer = true;
        } else {
            this.canSaveResponseTimer = false;
        }

        this.saveCpsresponsetimeractionsid = this.cpsResponseTimerList[0].cpsresponsetimeractionsid;
        this.caseWorkerComment = this.cpsResponseTimerList[0].caseworkercomments;
        this.reason = this.cpsResponseTimerList[0].reason;
        if (this.isSupervisor && this.cpsSkipApproval === 'true') {
            this.showlegislativecontent = true;
            this.loadSupervisor();
            $(this.responsetimeoverduepopupid).modal('show');
        }
    }
    // Assosiated with checkResponseTimerActions method
    private checkCpsresponsetimeractiontypeFn() {
        return ((this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Skip 2' || this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Skip 3') && (this.cpsResponseTimerList[0].approvedby === null || this.cpsResponseTimerList[0].approvedby === ""));
    }

    checkSkip1Response(response: any) {
        if (response.data.length === 1 && response.data[0].cpsresponsetimeractiontype === 'Skip 1') {
            const time = moment.duration("04:00:00");
            this.fromoverduelink = true;
            const date = moment(response.data[0].updatedon, this.dtwithtimeformat);
            const correcthrs = date.subtract(time);
            const duration = moment.duration(moment().diff(correcthrs));
            const hours = duration.asHours();
            if (hours < 24) {
                this.hideskipbtn = true;
                this.showapprovebtn = false;
                setTimeout(() => {
                    $(this.responsetimeoverduepopupid).modal('hide');
                }, 1000)
            }
            else {
                this.hideskipbtn = false;
                this.showapprovebtn = true;
            }
        }
    }

    checkSkip2Response(response: any) {
        if (response.data.length === 2 && response.data[0].cpsresponsetimeractiontype === 'Skip 2') {
            const time = moment.duration("04:00:00");
            const date = moment(response.data[0].updatedon, this.dtwithtimeformat);
            const correcthrs = date.subtract(time);
            const duration = moment.duration(moment().diff(correcthrs));
            const hours = duration.asHours();
            if ((hours < 120 && !this.isSupervisor) || (this.isSupervisor && response.data[0].approvedby)) {
                this.hideskipbtn = true;
                this.showapprovebtn = false;
                setTimeout(() => {
                    $(this.responsetimeoverduepopupid).modal('hide');
                }, 1000)
            } else {
                this.hideskipbtn = false;
            }
            if (this.isSupervisor && (this.hasSaveForApproval || this.showSkip3Label)) {
                this.fromoverduelink = false
            } else {
                this.fromoverduelink = true;
            }
        }
    }
    checkPrevSkipList(response: any) {
        this.prevSkipList = response.data.filter((s: { isskipped: any; }) => s.isskipped);
        if (this.prevSkipList && this.prevSkipList.length) {
            this.cpsresponsetimeractionsid = this.prevSkipList[0].cpsresponsetimeractionsid;
            this.updatedOn = this.prevSkipList[0].updatedon;
            this.skipname = this.prevSkipList[0].cpsresponsetimeractiontype;
        }
    }

    isJson(str: string) {
        try {
            JSON.parse(str);
        } catch (e) {
            return false;
        }
        return true;
    }

    allegedVictimChange(id: string | number) {

        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                this.allegedVictimreasonDropDown1 = data;

            });
    }
    otherChildChange(id: string | number) {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                this.otherChildrenreasonDropDown1 = data;

            });
    }
    caregiverChange(id: string | number) {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW' },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                this.caregiverreasonDropDown1 = data;

            });
    }

    selectedAllegedVictimReason1FromService(id: number, selectedvalue: string) {
        if (selectedvalue === "VDER") {
            this.enableAllegedDataEntryErrorReason = true;
        }
        else {
            this.enableAllegedDataEntryErrorReason = false;
        }
        if (selectedvalue === "VWCR") {
            this.isselectAllegedmultiple = true;
        }
        else {
            this.isselectAllegedmultiple = false;
        }

        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                if (this.selectAllegedVictimReason2 && this.selectAllegedVictimReason2.length && this.selectAllegedVictimReason2.includes('[')) {
                    const selectedval = JSON.parse(this.selectAllegedVictimReason2).length;
                    if (selectedval >= 1) {
                        const arrayval = JSON.parse(this.selectAllegedVictimReason2);
                        this.selectAllegedVictimReason2 = arrayval;
                    }
                }

                this.allegedVictimreasonDropDown2 = data;
                this.allegedVictimreasonDropDown3 = [];
            });
    }

    selectedAllegedVictimReason1(id: any, selectedvalue: string) {
        this.allegedVictimreasonDropDown2 = [];
        this.allegedVictimreasonDropDown3 = [];
        this.selectAllegedVictimReason2 = null;
        this.selectAllegedVictimReason3 = null;
        if (selectedvalue === "VDER") {
            this.enableAllegedDataEntryErrorReason = true;
        }
        else {
            this.enableAllegedDataEntryErrorReason = false;
        }
        if (selectedvalue === "VWCR") {
            this.isselectAllegedmultiple = true;
        }
        else {
            this.isselectAllegedmultiple = false;
        }

        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                this.allegedVictimreasonDropDown2 = data;
                this.selectAllegedVictimReason2 = undefined;
                this.allegedVictimreasonDropDown3 = [];
                this.selectAllegedVictimReason3 = undefined;

            });
    }
    selectedAllegedVictimReason2FromService(id: number, selectedvalue: any) {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                this.allegedVictimreasonDropDown3 = data;

            });
    }
    selectedAllegedVictimReason2(id: any, selectedvalue: any) {
        this.allegedVictimreasonDropDown3 = [];
        this.selectAllegedVictimReason3 = null;
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data: any) => {
                this.allegedVictimreasonDropDown3 = data;
                this.selectAllegedVictimReason3 = undefined;

            });
    }
    selectedOtherChildReason1FromService(id: number, selectedvalue: string) {
        if (selectedvalue === "ODER") {
            this.enableChildrenDataEntryErrorReason = true;
        } else {
            this.enableChildrenDataEntryErrorReason = false;
        }
        if (selectedvalue === "OWCR") {
            this.isselectChildrenmultiple = true;
        }
        else {
            this.isselectChildrenmultiple = false;
        }
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {

            if (this.selectOtherChildReason2 && this.selectOtherChildReason2.length && this.selectOtherChildReason2.includes('[')) {
                const selectedval = JSON.parse(this.selectOtherChildReason2).length;
                if (selectedval >= 1) {
                    const arrayval = JSON.parse(this.selectOtherChildReason2);
                    this.selectOtherChildReason2 = arrayval;
                }
            }
            this.otherChildrenreasonDropDown2 = data;
            this.otherChildrenreasonDropDown3 = [];
            this.selectOtherChildReason3 = undefined;

        });
    }
    selectedOtherChildReason1(id: any, selectedvalue: string) {
        this.otherChildrenreasonDropDown2 = [];
        this.otherChildrenreasonDropDown3 = [];
        this.selectOtherChildReason2 = null;
        this.selectOtherChildReason3 = null;
        if (selectedvalue === "ODER") {
            this.enableChildrenDataEntryErrorReason = true;
        } else {
            this.enableChildrenDataEntryErrorReason = false;
        }
        if (selectedvalue === "OWCR") {
            this.isselectChildrenmultiple = true;
        }
        else {
            this.isselectChildrenmultiple = false;
        }
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {
            this.otherChildrenreasonDropDown2 = data;
            this.selectOtherChildReason2 = undefined;
            this.otherChildrenreasonDropDown3 = [];
            this.selectOtherChildReason3 = undefined;

        });
    }
    selectedOtherChildReason2FromService(id: number, selectedvalue: any) {
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {
            this.otherChildrenreasonDropDown3 = data;
        });
    }
    selectedOtherChildReason2(id: any, selectedvalue: any) {
        this.otherChildrenreasonDropDown3 = [];
        this.selectOtherChildReason3 = null;
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {
            this.otherChildrenreasonDropDown3 = data;
            this.selectOtherChildReason3 = undefined;

        });
    }

    selectedCaregiverReason1FromService(id: number, selectedvalue: string) {
        if (selectedvalue === "CDER") {
            this.enableCaregiverDataEntryErrorReason = true;
        } else {
            this.enableCaregiverDataEntryErrorReason = false;
        }
        if (selectedvalue === "CWCR") {
            this.isselectCaregivermultiple = true;
        }
        else {
            this.isselectCaregivermultiple = false;
        }
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {

            if (this.selectCaregiverReason2 && this.selectCaregiverReason2.length && this.selectCaregiverReason2.includes('[')) {
                const selectedval = JSON.parse(this.selectCaregiverReason2).length;
                if (selectedval >= 1) {
                    const arrayval = JSON.parse(this.selectCaregiverReason2);
                    this.selectCaregiverReason2 = arrayval;
                }
            }

            this.caregiverreasonDropDown2 = data;
            this.caregiverreasonDropDown3 = [];
        });
    }

    selectedCaregiverReason1(id: any, selectedvalue: string) {
        this.caregiverreasonDropDown2 = [];
        this.caregiverreasonDropDown3 = [];
        this.selectCaregiverReason2 = null;
        this.selectCaregiverReason3 = null;
        if (selectedvalue === "CDER") {
            this.enableCaregiverDataEntryErrorReason = true;
        } else {
            this.enableCaregiverDataEntryErrorReason = false;
        }
        if (selectedvalue === "CWCR") {
            this.isselectCaregivermultiple = true;
        }
        else {
            this.isselectCaregivermultiple = false;
        }
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {
            this.caregiverreasonDropDown2 = data;
            this.selectCaregiverReason2 = undefined;
            this.caregiverreasonDropDown3 = [];
            this.selectCaregiverReason3 = undefined;
        });
    }
    selectedCaregiverReason2FromService(id: number, selectedvalue: any) {

        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {
            this.caregiverreasonDropDown3 = data;
        });
    }

    selectedCaregiverReason2(id: any, selectedvalue: any) {
        this.caregiverreasonDropDown3 = [];
        this.selectCaregiverReason3 = null;
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data: any) => {
            this.caregiverreasonDropDown3 = data;
            this.selectCaregiverReason3 = undefined;

        });
    }


    getresponsetimerduedate() {
        const response = this._dataStoreService.getObj('responsetimerduedatelist');
        this.responseTimerDueDateList = response.data;
        if (moment(this.responseTimerDueDateList?.responsetimer_duedate) > moment(new Date())) {
            this.responseTimerDueDateList.responsetimer_status = 'Stopped';
        }
        const time = moment.duration("04:00:00");
        const date = moment(this.responseTimerDueDateList?.responsetimer_duedate, this.dtwithtimeformat);
        this.responseTimerDueDate = date.subtract(time);
        if (this.hasSavedResponseTimerRecord) {
            return;
        }

        if (this.fromoverduelink) {
            this.chkAllegedVictim = null;
            this.chkCaregiver = null;
            this.chkOtherChild = null;

        }
        this.allegedDropdowns(response);
        this.otherChildDropdowns(response);
        this.caregiverDropdowns(response);
        this.allegedVictimChange('580');
        this.otherChildChange('583');
        this.caregiverChange('586');
    }

    allegedDropdowns(response: any) {
        if (this.chkAllegedVictim === undefined || this.chkAllegedVictim === null) {
            this.chkAllegedVictim = (response?.data?.alleged_victim_contact_sw === 'Y') ? true : false;
            if (this.chkAllegedVictim) {
                this.hideallegeddropdown = true;
                this.hidedropdowns = true;
            } else {
                this.hideallegeddropdown = false;
            }
        }
    }

    otherChildDropdowns(response: any) {
        if (this.chkOtherChild === undefined || this.chkOtherChild === null) {
            this.chkOtherChild = (response?.data?.other_children_contact_sw === 'Y') ? true : false;
            if (this.chkOtherChild) {
                this.hideotherchilddropdown = true;
                this.hidedropdowns = true;
            } else {
                this.hideotherchilddropdown = false;
                this.hidedropdowns = true;
            }
        }
    }

    caregiverDropdowns(response: any) {
        if (this.chkCaregiver === undefined || this.chkCaregiver === null) {
            this.chkCaregiver = (response?.data?.icc_contact_sw === 'Y') ? true : false;
            if (this.chkCaregiver) {
                this.hidecaregiverdropdown = true;
                this.hidedropdowns = true;
            } else {
                this.hidecaregiverdropdown = false;
                this.hidedropdowns = true;
            }
        }
    }

    cancelPopup() {
        $(this.responsetimeoverduepopupid).modal('hide');

    }
    sendForApproval() {
        let obj;
        if (this.cpsresponsetimeractionsid !== "") {
            const skipsplit = this.skipname.split(" ");
            const skipsplitval = parseInt(skipsplit[1]) + 1;
            if (skipsplitval >= 3) {
                this.disableskipbtn = true;
            } else {
                this.disableskipbtn = false;
            }

            obj = {
                cpsresponsetimeractionsid: null,
                isskipped: true,
                cpsresponsetimeractiontype: "Skip " + '' + skipsplitval?.toString(),
                allegedvictimcontact: this.chkAllegedVictim,
                otherchildrencontact: this.chkOtherChild,
                initialcaregivercontact: this.chkCaregiver,
                intakeserviceid: this.id,
                securityuserid: this._authService.getCurrentUser().user.securityusersid,
                reason: this.reason,
                cpsresponsetimerreason1: this.selectAllegedVictimReason1,
                cpsresponsetimerreason2: this.selectAllegedVictimReason2,
                cpsresponsetimerreason3: this.selectAllegedVictimReason3,
                cpsresponsetimerreason4: this.selectOtherChildReason1,
                cpsresponsetimerreason5: this.selectOtherChildReason2,
                cpsresponsetimerreason6: this.selectOtherChildReason3,
                cpsresponsetimerreason7: this.selectCaregiverReason1,
                cpsresponsetimerreason8: this.selectCaregiverReason2,
                cpsresponsetimerreason9: this.selectCaregiverReason3,
                approvalstatus: this.isSupervisor ? '16' : '15'

            };
        }

        this.storage.setItem('cpsSkipApproval', 'false');

        // uncomment this block while working
        this.disableSubmitforApprovalSkip2 = true;
        this._commonHttpService.create(obj, 'cpsresponsetimeractions/skip2routing').subscribe(response => {
            if (this.isSupervisor) {
                this._alertService.success('Skip 2 Approved successfully');
                setTimeout(() => {
                    $(this.responsetimeoverduepopupid).modal('hide');
                }, 100)
            } else {
                this.savetheOverdue();
            }
            this.getcpsresponsetimerActions(false);

        },
            (error) => {
                this._alertService.warn(this.errmsg);
                this.disableSubmitforApprovalSkip2 = false;
            });

        $(this.overduepopupid).modal('hide');
    }

    cpsResponseTimerSaveRouting(status: number) {

        if (status === 17 && !this.supervisorComment) {
            this._alertService.warn('Supervisor comment is required to reject the save');
            return;
        }
        const obj = {
            cpsresponsetimeractionsid: this.saveCpsresponsetimeractionsid,
            data: {
                approvalstatus: status,
                supervisorcomments: this.supervisorComment
            }
        }

        this._commonHttpService.create(obj, 'cpsresponsetimeractions/saverouting').subscribe(response => {
            this.storage.setItem('cpsSkipApproval', 'false');
            if (status === 17) {
                this._alertService.success('Request rejected successfully');
            } else if (status === 16) {
                this._alertService.success('Request approved successfully');
            }
            $(this.responsetimeoverduepopupid).modal('hide');
            this.getcpsresponsetimerActions(false);
        },
            (error) => {
                this._alertService.warn(this.errmsg);
            });

        $(this.overduepopupid).modal('hide');

    }

    pregnants: any[] = [];
    getpregnants(pids: any) {
        this.pregnants = [];
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 50,
                    nolimit: true,
                    method: 'get',
                    where: { v_pids: pids }
                }),
                'personsexualinfo/getpregnants?filter'
            ).subscribe((res: any) => {
                if (res && res[0]?.getpregnants?.length > 0) {
                    res[0]?.getpregnants?.forEach((e: { pregnant: any; }) => {
                        if (!this?.pregnants?.includes(e.pregnant)) {
                            this?.pregnants?.push(e.pregnant);
                        }
                    });
                    if (this.pregnants?.length > 0) {
                        ($(this.legalguardianrolepopupid)).modal('show');
                    }
                }
            });
    }

    legalguardianrolepopupDataFn(): void {
            this.legalguardianrolepopupData = {
                'isLGPresent': this.isLGPresent ?? null,
                'isUnkPresent': this.isUnkPresent ?? null,
                'careGiverMessages': this.careGiverMessages ?? null,
                'alertMessageFor15Days': this.alertMessageFor15Days ?? null,
                'alertMessageFor30Days': this.alertMessageFor30Days ?? null,
                'isInfantnotReported': this.isInfantnotReported ?? null,
                'needToSafeInfants': this.needToSafeInfants ?? null,
                'notPlacedChildList': this.notPlacedChildList ?? null,
                'pregnants': this.pregnants ?? null,
                'isUnconfirmed': this.isUnconfirmed ?? null
    
            }
            this._globalPopupService.setlegalGuardianRoleData(this.legalguardianrolepopupData);            
    }
    changeSupervisor(event: any) {
        // No data or function to call
    }


}

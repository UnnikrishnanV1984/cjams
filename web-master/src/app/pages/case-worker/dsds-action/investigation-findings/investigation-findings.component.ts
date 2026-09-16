
import {timer as observableTimer,  Observable ,  Subject ,  forkJoin, of } from 'rxjs';
import {map, catchError} from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { AfterViewChecked, ChangeDetectorRef, Component, OnInit, OnDestroy, ViewChild, Injector } from '@angular/core';
import { FormArray, FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';
import { config } from '../../../../../environments/config';
import { isCaseUuid, ObjectUtils } from '../../../../@core/common/initializer';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { CommonHttpService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { AuthService } from '../../../../@core/services/auth.service';
import { GenericService } from '../../../../@core/services/generic.service';
import { AppConfig } from '../../../../app.config';
import { RoutingUser } from '../../../cjams-dashboard/_entities/dashBoard-datamodel';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { DSDSActionSummary } from '../../_entities/caseworker.data.model';
import { DispositionAddModal } from '../disposition/_entities/disposition.data.models';
import { Allegedperson, CheckList, InvestigationComar, InvestigationFinding,
    InvestigationFindings, InvestigationFindingType, InvolvedPerson, SubmitForReview } from './_entities/investigation-finding-data.models';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { AppConstants } from '../../../../@core/common/constants';
import _ from 'lodash';
import moment from 'moment';
import { DocumentUploadListSharedComponent } from '../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { MatTableDataSource } from '@angular/material/table';
import { GlobalPopupComponent } from '../../../../../../src/app/shared/shared-components/global-popup/global-popup.component';
import { InvestigationFindingsResolverService } from './investigation-findings-resolver';

declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-findings',
    templateUrl: './investigation-findings.component.html',
    styleUrls: ['./investigation-findings.component.scss'],
    standalone: false
})
export class InvestigationFindingsComponent implements OnInit, AfterViewChecked, OnDestroy {
    @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent;
    investigationAllegedPerson$ = new Subject<Allegedperson[] | null>();
    investigationComar$ = new Subject<InvestigationComar>();
    paginationInfo: PaginationInfo = new PaginationInfo();
    investigationFindingDropDown!: InvestigationFindingType[];
    id: string;
    isServiceCase!: any;
    activeModule: any = null;
    notification!: string;
    approvalStatus!: string | null;
    showExpungement!: boolean;
    isAppealWorker!: boolean;
    isManualExpunge!: boolean;
    roleId!: AppUser;
    alertMessage!: string;
    ReviewStatus: any;
    maltreatmentData: any;
    maltreatments: any;
    investigationFindingForm!: FormGroup;
    lastUpdatedTime : any = null;
    isInvAutoSaveFlag: boolean = false;
    isAppealAutoSaveFlag: boolean = false;
    isExpungementAuoSaveFlag: boolean = false;
    appealDelayForm!: FormGroup;
    investigationFindingFormGroup!: FormGroup;
    appealFormGroup!: FormGroup;
    reviewCheckListForm!: FormGroup;
    investigationfindingid: any;
    investigationType!: InvestigationFindings[];
    submitForReview = new SubmitForReview();
    investigationFinding: InvestigationFinding = new InvestigationFinding();
    dsdsActionsSummary = new DSDSActionSummary();
    investigation!: InvestigationFinding[];
    allegedperson!: InvestigationFinding[];
    recognizing = '';
    quillToolbar = AppConstants.NARRATIVE.TOOLBAR_CONFIG;
    speechRecogninitionOn!: boolean;
    speechData!: string;
    submitBtn = false;
    selectedSupervisor: any;
    currentfindings: any;
    currentAppeal: any;
    currentExpungement: any;
    autoSaveInitiated: boolean = false;
    supervisorsList!: RoutingUser[];
    findingsList: Allegedperson[] = [];
    personInfo: InvolvedPerson[] = [];
    viewMaltreatementKey!: string | null | undefined;
    daNumber: string;
    findingAssesors : any[] = [];
    reviewCheckList: CheckList[] = [];
    dispositionFormGroup!: FormGroup;
    expungementForm!: FormGroup;
    expungmentMessage!: string;
    isExpungementExist!: boolean;
    statusDropdownItems$!: Observable<DropdownModel[]>;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    reasonDropdownItems$!: Observable<DropdownModel[]>;
    closeCaseDropdownItems$!: Observable<DropdownModel[]>;
    private daType: string;
    private dispositionDropdownItems!: DropdownModel[];
    isMandatory: any;
    showConferenceType!: number | null;
    conferenceTypeTitle!: string;
    isFinalize!: boolean;
    appealData: any;
    investigationAllegationList: any;
    appealInvestigation: any;
    isView!: boolean;
    initialFinding!: string;
    intakeserviceid: string;
    isNarrativeSaved!: boolean;
    appealFindingKey: any;
    isUnsubstantiated!: boolean;
    showCaseTypeForms!: boolean;
    maltreatorsAppeal: any;
    juristictionList$!: Observable<any[]>;
    hearingReasonList: any[] = [];
    judiLocationList: any[] = [];
    judiAddressList: any[] = [];
    uploadedFile: any[] = [];
    expert_assessmnts_attachment: any[] = [];
    med_assessmnts_attachment: any[] = [];
    law_enforcement_attachment: any[] = [];
    token: AppUser;
    appealDocument: any;
    toDeleteAttachment: any;
    enableoah!: boolean;
    enablecc!: boolean;
    enablecsa!: boolean;
    enablecoa!: boolean;
    enablesc!: boolean;
    showFinalize!: boolean;
    reasonDropDown: any;
    allegedMaltreatorName!: string;
    MaltreatmentType!: string;
    // servicecaseid: string;
    isCaseworker: any;
    isSupervisor: any;
    investigationFindingType!: string;
    juridictionList: any;
    courtdataValid: any = { sc: null, oah: null, cc: null, csa: null, coa: null };
    appealDocumentList: any[] = [];
    showAppeal!: boolean;
    reportflag: any = null;
    finalizeFormGroup!: FormGroup;
    MaltreatmentsInfo: any[] = [];
    allegationData: any;
    isClosed = false;
    isChildNotDead = true;
    cisData: any;
    modelFooterHidden = false;
    isNotReadonly = true;
    sdmData : any;
    hasAccessToCase: boolean = false;
    

    // No appeal reasons
    // noAppealReasons = ['Time expired', 'Maltreator Voluntarily did not appeal'];

    unapprove = false;
    noMAfoundMsg = true;
    pageLoaded = false;
    unsubstantiatedPopUp!: boolean;
    indicatedPopUp!: boolean;
    removeMaltreatorPopUp!: boolean;
    removeROFindingsPopUp!: boolean;
    doNotExpungePopUp!: boolean;
    expungementStatusStep!: number;
    allegedMaltreator!: string;
    previousExpungementStatus!: string | null;
    canExpungeRuledOut!: boolean;
    moduleview: any;
    isSummaryDiabled= false;
    isExpungeDisabled = false;
    autoSaveIntervalTimer!: NodeJS.Timer;
    maltreatmentAllegationList: any;
    maltreatmentTypeAuditList: any;
    maltreatmentAllegationIdVar: any;
    expungeJustificationList$!: Observable<any[]>;
    expungementUpdatedUsername: any;
    expungementUpdatedOn: any;
    victimRelation: any;
    victimDetails: any[] = [];
    maltreatorDetails: any[] = [];
    maltreatorRelationSet: boolean = false;
    legislative:any;
    uploadedFiles: any[] = [];
    isAppealModalOpen: boolean = false;
    selectedAppealIndex!: number;
    investigationpopupid = '#investigation-appeal';
    appealstabid = '#appeals-tab';
    investigationmaltreatmentaddfindingsurl = 'investigationmaltreatment/addfindings';
    dtformat = 'MMM Do YY, h:mm:ss a';
    investigationreviewpopup = '#checklist-investigation-findings-review';
    intakecaseassignpopupid = '#intake-caseassign';
    circuitcourt = 'Circuit Court';
    expungementalertpopupid = '#expungement-status-alert';
    displayorder = 'displayorder ASC';
    gettypesurl = 'referencetype/gettypes';
    isMaltreatmentMissing: boolean = false;
    missedMaltreatment: number = 0;
    permanencyPlanHistoryData!: string[];
    previousFatality = '';
    commentAuditTrailArray: any[] = [];
    currentCommentTrail: any[] = [];
    childFatality:any;
    dod: any;
    sdmChildFatality!: number;
    sdmAllegation: any;
    uploadNumber: any;
    editMode: any;
    reportMode: any;
    maxDate: any;
    requestForService: any;
    adultManditory: any;
    ischildfatality = false;
    isseriousphysicalinjury = false;
    ismaltreatment = false;
    intakesdmproviderlength : any;
    form1080cData: any[] = [];
    involvedPerson: any[] = [];

    retrydoc: boolean = false;
    @ViewChild(DocumentUploadListSharedComponent) documentuploaded!: DocumentUploadListSharedComponent;

    private _alertService: AlertService;
    private _dataStoreService: DataStoreService;
    private _formBuilder: FormBuilder;
    private formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private route: ActivatedRoute;
    private _router: Router;
    private _changeDetect: ChangeDetectorRef;
    private _dispositionAddService: GenericService<DispositionAddModal>;
    public _authService: AuthService;
    private _uploadService: NgxfUploaderService;
    private _speechRecognitionService: SpeechRecognitionService;
    private _session: SessionStorageService;
    private readonly storage: SessionStorageService;
    safeCDataSource!: MatTableDataSource<string>;
    mfiraDataSource!: MatTableDataSource<string>;
    form1080aDataSource!: MatTableDataSource<string>;
    form1080bDataSource!: MatTableDataSource<string>;
    form1080cDataSource!: MatTableDataSource<string>;
    isSenChildExists: boolean = false;
    expandFindingForm!: boolean;
    maltreatorsIndex: any;
    iscaseexpunged: any = 0;


    constructor(private injector: Injector,private investigationFindingsResolverService: InvestigationFindingsResolverService){
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._router = this.injector.get<Router>(Router);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._dispositionAddService = this.injector.get<GenericService<DispositionAddModal>>(GenericService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);

        // this.route.data.subscribe((data: any) => {
        //     if (data && data.hasOwnProperty('result')) {
        //         this._authService.setAuthDetail('investigationfinding', data.result);
        //     }
        // });
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        const dataStore = this._dataStoreService.getData('dsdsActionsSummary');
        this.token = this._authService.getCurrentUser();
        this.daType = dataStore ? dataStore.da_typeid : '';
        this.isCaseworker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        this.ReviewStatus = {};
        this.intakeserviceid = dataStore ? dataStore.intakeserviceid : '';
        if (this.id === undefined) {
            this.id = this.intakeserviceid;
        }

        this.reasonDropDown = ['Withdrawn', 'Settled', 'Postponed'];
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    }



    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.investigationFindingsResolverService.getInvestigationfinding().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('investigationfinding', data);
            }
        })
        this.isServiceCase = this._session.getItem('ISSERVICECASE');
        this.activeModule = this._session.getItem('activeModuleNav');
        this.route.queryParams.subscribe((params: any) => {
            this.retrydoc = params['retrydocument'];
        });
        this.moduleview = this._authService.isModuleAccessable('investigationfinding', 'investigationfinding');
        this.isSummaryDiabled = this._authService.isDisabled('investigationfinding','investigationfinding.investigationfindings.summaryreport');
        this.isExpungeDisabled = this._authService.isDisabled('investigationfinding','investigationfinding.expungement.expunge');
        this.showExpungement = false;
        this.previousExpungementStatus = null;
        this.setInitialFlags();
        this.formInitilize();
        this.investigationFindings();
        this.getJurisdictionList();
        this.getHearingReasonList();
        this.getJudiLocationList();
        this.getquickperson();
        this.getJudiAddressList();
        this.getJuridictionList();
        this.getAppealDocumentList();
        this.dispositionHistory();
        this.loadExpungementJustificationDropDown();
        this.loadLegislativeDropDown();
        this.emergncyStiuationDropDown();
        this.forResonNotProvidedDropDown();
        this._gelegislativetData();
        this.getAssignmentsList();
        const store = this._dataStoreService.getCurrentStore();
        if (store['dsdsActionsSummary']) {
            this.dsdsActionsSummary = store['dsdsActionsSummary'];
            if (this.dsdsActionsSummary) {
                this.getInvestigationData();
            }
            this.getCISData();
        } else {
            this.getActionSummary();
        }
        this.getInvolvedPerson();
        

        setTimeout(()=>{
            this.investigationAllegedPerson$.subscribe((findings: any) => {
                if (findings) {
                this.findingsList = [];
                this.findingsList = findings;
                this.submitReview(); } else {
                    this.getFindingList();
                }
            });
        }, 3000);

        if (this.isSupervisor) {
           $('#expungementDetails').click();
        }

        this.initiateAutoSave(true);

           // loading sdm data
        this.getSDMDetails();
        // get form1080A data
        this.getForm1080C();
        // get involved person details
        this.getInvolvedPersonDetail();

        this.route.queryParams.subscribe((params: any) => {
            if (params['retrydocument']) {
                setTimeout(() => {
                this.expandFindingForm = true;
                const i = this.maltreatorsIndex;
                const investigationFind = (this.investigationFindingForm.get('allegedperson') as FormArray).at(i);
                this.loadAppealData(investigationFind?.value?.isFinalizeDone, investigationFind?.value?.isAppealDone, investigationFind?.value?.maltreatmentid, investigationFind, investigationFind?.value?.intakeservicerequestactorid, i)  
                }, 5000);                
            }
        });
        this.getInvolvedPersons();
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
            (response: any) => {
                if (response) {
                    this.form1080cData = response;
                }
            },
            (_error: any) => {
                this._alertService.warn('Error retrieving Form 1080C data');
            }
        );
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
        ).subscribe((response: any) => {
            if (response && response.data.length) {
                let senChild = response.data.filter((item: any) => item.senstatusflag === 1);
                if(senChild.length) {
                    this.isSenChildExists = true;
                    this.reviewCheckListForm.patchValue({ activeSenService: this.dsdsActionsSummary?.servicecasenumber ? true : false });
                   
                }
            }
        });
    }

      getSDMDetails() {
            // The sdm endpoints filter on a uuid column, so an unresolved this.id
            // reaches Postgres as 22P02 and the api flattens that into a bare 400.
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
            .subscribe((res: any) => {
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

    ngAfterViewChecked() {
        this._changeDetect.detectChanges();
    }

    async getInvestigationData() {
        await this.getFindingList();
        this.getCheckList();
        this.getMaltreatmentInfo();
        this.getMaltreatments();
    }

    safeCDisplayedColumns: string[] = ['name'];
    mfiraDisplayedColumns: string[] = ['name'];
    form1080Columns: string[] = ['name'];

    setInitialFlags() {
        const activeModuleRole = this._session.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.isNotReadonly = false;
        } else {
            this.isNotReadonly = this._authService.readonlyButton('read_only_access', 'readonly-invest-find');
        }

        this.roleId = this._authService.getCurrentUser();
        if (this.roleId) {
            const roleName = ObjectUtils.getNestedObject(this.roleId, ['role', 'name']);
            if (roleName === AppConstants.ROLES.APPEAL_USER) {
                this.isAppealWorker = true;
            }
        }

        this._authService.hasAccess('Manual Expungment').subscribe((result: any) => {
            this.isManualExpunge = result;
        });

        const da_status = this._session.getItem('da_status');
        if (da_status) {
            if (da_status === 'Closed' || da_status === 'Completed') {
                this.isClosed = true;
            } else {
                this.isClosed = false;
            }
        }
    }
    
  uploadclosed(event: any){
        if(event){
            this.documentuploaded.closeupload();
        }
    }
    existingForm(){
        setTimeout(()=>{
        this.currentfindings = this.investigationFindingForm.getRawValue().allegedperson;
        this.currentAppeal = this.appealFormGroup.getRawValue();
        this.currentExpungement = this.expungementForm.getRawValue();
        }, 3000);
    }
    initiateAutoSave(enableFlag: any, formData?: any, index?: any) {
    if(enableFlag) {
        if(!this.autoSaveInitiated){
            this.autoSaveInitiated = true;
            this.setAutoSaveIntervalTimer();
            this._dataStoreService.setData('investigationFindingsTimer', this.autoSaveIntervalTimer);
        }
     }

    }
    setAutoSaveIntervalTimer(){ 
        let diffFlag = true;
        this.autoSaveIntervalTimer = setInterval(() => {
            if (this.isNotReadonly) {
        const diffArray: any[] = [];
        const latestFindings = this.investigationFindingForm.getRawValue().allegedperson;
        diffFlag = _(this.currentfindings).differenceWith(latestFindings, _.isEqual).isEmpty();
        if(!diffFlag){
            latestFindings.forEach((element: any) => {
                if(!this.currentfindings.includes(element)){
                    diffArray.push(element);
                }
            });
        }
        if(!diffFlag && (this.isCaseworker || this.isAppealWorker || this.isSupervisor)
            && !((this.showAppeal || this.isClosed) && !this.isAppealWorker)){
            diffArray.forEach(formData => {
                this.saveInvestigation(formData, true);
            });
            }
            this.autoSaveAppeal();
            this.autoSaveExpungement();
            }
        }, config.AutoSaveTimer);
    }
    // Assosiated to setAutoSaveIntervalTimer method
    private checkLatestFindingsFn() {
        let diffFlag = true;
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
        if (!diffFlag && (this.isCaseworker || this.isAppealWorker || this.isSupervisor)
            && !((this.showAppeal || this.isClosed) && !this.isAppealWorker)) {
            diffArray.forEach(formData => {
                this.saveInvestigation(formData, true);
            });
        }
    }

    autoSaveAppeal(){
        let appealDiffFlag =  true;
        const latestAppeals = this.appealFormGroup.getRawValue();
        appealDiffFlag = _.isEqual(_.omit(this.currentAppeal, ['type']), _.omit(latestAppeals, ['type']));
        if(!appealDiffFlag && ((this.showAppeal || this.isClosed) && this.isAppealWorker)){
            this.saveAppeal(true);
        }
    }
    autoSaveExpungement(){
        let expungementDiffFlag = true;
        const latestExpungement = this.expungementForm.getRawValue();
        expungementDiffFlag = _.isEqual(this.currentExpungement, latestExpungement);
        if(!expungementDiffFlag){
            this.confirmExpungement(true);
        }
    }
    filterReason(reasonText: any) {
        const result =  this.reasonDropDown?.filter((item: any) => {
           return item === reasonText.value_text;
        });
        return (result && result.length) ? true : false;
    }

    formInitilize() {
        this.initFindingsForm();
        this.reviewCheckListForm = this.formBuilder.group({
            initalfacetoface: false,
            safec: [{ value: false, disabled: true }],
            canf: false,
            mfira: false,
            personConfirmed: [{ value: false, disabled: true }],
            relationConfirmed: [{ value: false, disabled: true }],
            lateinitialcontact: [{ value: false, disabled: true }],
            legislativeReq:['', Validators.required],
            emergncyStiuation:['', Validators.required],
            forResonNotProvided:['', Validators.required],
            notes:'',
            form1080a : [{ value: false, disabled: true }],
            form1080b : [{ value: false, disabled: true }],
            form1080c : [{ value: false, disabled: true }],
            activeSenService: [{ value: false, disabled: true }],
        });
        this.expungementForm = this.formBuilder.group({
            expungementStatus: [null],
            expungementid: [null],
            investigationfindingid: [null],
            isunsubstansiated: [null],
            isindicated:  [null],
            isremovemaltreator:  [null],
            isremoverofindings:[null],
            donotexpunge:  [null],
            manualexpunge:  [null],
            unsubstansiateddate:  [null],
            indicateddate:  [null],
            removemaltreatordate:  [null],
            resultoflawenforcement:  [null],
            investigationfinding: [null],
            appealfinding: [null],
            finalfinding: [null],
            activeflag: [1],
            investigationnarrative: [null],
            intakeserviceid : [null],
            maltreatmentid : [null],
            intakeservicerequestactorid: [null],
            reason: [null],
            justification: [null],
            updatedon: [null],
            fullname: [null],

        });
        this.expungementForm.patchValue({intakeserviceid: this.id});
        this.dispositionFormGroup = this.formBuilder.group({
            statusid: [''],
            dispositionid: ['', Validators.required],
            closingcodetypekey: [null],
            reviewcomments: [''],
            supervisorid: [null]
        });
        this.initAppealForm();
    }
    private initAppealForm() {

        this.appealDelayForm = this.formBuilder.group({
            delay_reason: [null]
        });
        this.appealFormGroup = this.formBuilder.group({
            scicesentdate: [null],
            scconfheldflag: [null],
            scdecisiontypekey: [null],
            scconferencedetail: [null],
            scconferencedate: [null],
            scappealed: [null],
            type: [null],
            sentdate: [null],
            oahearingdatesetflag: [null],
            hearingdate: [null],
            oanorhearingreason: [null],
            hearingdecision: [null],
            hearingdecisiondate: [null],
            details: [null],
            casenumber: [null],
            appealedflag: [null],
            stayrequestedflag: [null],
            staygrantedflag: [null],
            hearingdecisiontypekey: [null],
            courtdecisionflag: [null],
            compileddate: [null],
            overridedate: [null],
            overrideby: [this._authService.getCurrentUser().user.userprofile.firstname + ' ' + this._authService.getCurrentUser().user.userprofile.lastname],
            overridefindingtypekey: [null],
            overridecomments: [null],
            overrideapprflag: [null],
            scisappealed: [null],
            scappealedby: [null],
            scappealeddate: [null],
            oaldssname: [null],
            oaappellentatrny: [null],
            oalocaldept: [null],
            oarunningmotion: [null],
            ccldssname: [null],
            ccappellentatrny: [null],
            coaldssname: [null],
            coaappellentatrny: [null],
            csaldssname: [null],
            csaappellentatrny: [null],
            csanotifiedtodirector: [null],
            csacertiorari: [null],
            oaicesentdate: [null],
            oahearingdate: [null],
            clientroleid: [null],
            oahearingdecision: [null],
            oahearingdecisiondate: [null],
            oadetails: [null],
            ccstayrequestedflag: [null],
            ccstaygrantedflag: [null],
            ccappealedflag: [null],
            cchearingdecisiontypekey: [null],
            cchearingdecisiondate: [null],
            ccdetails: [null],
            csastayrequestedflag: [null],
            csastaygrantedflag: [null],
            csaappealedflag: [null],
            csahearingdecisiontypekey: [null],
            csahearingdecisiondate: [null],
            csadetails: [null],
            oaappealedflag: [null],
            oacasenumber: [null],
            oacasenumberlast8digit: [null],
            cccasenumber: [null],
            cccasenumberlast8digit: [null],
            csacasenumber: [null],
            csacasenumberlast8digit: [null],
            coajuridiction: [null],
            oajuridiction: [null],
            ccjuridiction: [null],
            csajuridiction: [null],
            cccourtdecisionflag: [null],
            cccompileddate: [null],
            csacourtdecisionflag: [null],
            coastayreqflag: [null],
            coastaygrantedflag: [null],
            coaappealedflag: [null],
            coahearingdecisiontypekey: [null],
            coahearingdecisiondate: [null],
            coadetails: [null],
            coacase: [null],
            coacourtdecisionflag: [null],
            coacompileddate: [null],
            coacasenumber: [null],
            coacasenumberlast8digit: [null],
            isvictim: [null],
            csacompileddate: [null],
            csaarguementheld: [null],
            csaarguementnotheldreason: [null],
            ccwhoappealed: [null],
            csawhoappealed: [null],
            ccnotifiedtodirector: [null],
            ccldssnotifieddate: [null],
            csaldssnotifieddate: [null],
            cccicuitcourtkey: [null],
            scsummarymailed: [null],
            scappealedsetdate: [null],
            scisappealformsent: [null],
            cchearingheld: [null],
            cchearingreason: [null],
            cclocationofhearing: [null],
            coacertioraristatus: [null],
            coacertgranteddate: [null],
            coacertdenieddate: [null],
            oahearingheld: [null],
            oahearingheldreason: [null],
            cchearingheldreason: [null],
            oalocationofhearing: [null],
            oasummarydecisionfiledflag: [null],
            oasummarydecisionfileddate: [null],
            csalocationofhearing: [null],
            coalocationofhearing: [null],
            oamodificationsmade: [null],
            oahearingnarrative: [null],
            oatranslator: [null],
            oarunningmotiondate: [null],
            oamaltreatorunnamedflag: [null],
            oacompiledwithoah: [null],
            scmaltreatmenttypeid:[null],
            oahmaltreatmenttypeid : [null],
            ccmaltreatmenttypeid: [null],
            csmaltreatmenttypeid: [null],
            coamaltreatmenttypeid: [null]
        });
        this.finalizeFormGroup = this.formBuilder.group({
            scicesentdate: [null],
            scconfheldflag: [null],
            scdecisiontypekey: [null],
            scconferencedetail: [null],
            scconferencedate: [null],
            scappealed: [null],
            type: [null],
            sentdate: [null],
            oahearingdatesetflag: [null],
            hearingdate: [null],
            oanorhearingreason: [null],
            hearingdecision: [null],
            hearingdecisiondate: [null],
            details: [null],
            casenumber: [null],
            appealedflag: [null],
            stayrequestedflag: [null],
            staygrantedflag: [null],
            hearingdecisiontypekey: [null],
            courtdecisionflag: [null],
            compileddate: [null],
            overridedate: [null],
            overrideby: [this._authService.getCurrentUser().user.userprofile.firstname + ' ' + this._authService.getCurrentUser().user.userprofile.lastname],
            overridefindingtypekey: [null],
            overridecomments: [null],
            scisappealed: [null],
            scappealedby: [null],
            scappealeddate: [null],
            oaldssname: [null],
            oaappellentatrny: [null],
            oalocaldept: [null],
            oarunningmotion: [null],
            ccldssname: [null],
            ccappellentatrny: [null],
            coaldssname: [null],
            coaappellentatrny: [null],
            csaldssname: [null],
            csaappellentatrny: [null],
            csanotifiedtodirector: [null],
            csacertiorari: [null],
            oaicesentdate: [null],
            oahearingdate: [null],
            clientroleid: [null],
            oahearingdecision: [null],
            oahearingdecisiondate: [null],
            oadetails: [null],
            ccstayrequestedflag: [null],
            ccstaygrantedflag: [null],
            ccappealedflag: [null],
            cchearingdecisiontypekey: [null],
            cchearingdecisiondate: [null],
            ccdetails: [null],
            csastayrequestedflag: [null],
            csastaygrantedflag: [null],
            csaappealedflag: [null],
            csahearingdecisiontypekey: [null],
            csahearingdecisiondate: [null],
            csadetails: [null],
            oaappealedflag: [null],
            oacasenumber: [null],
            oacasenumberlast8digit: [null],
            cccasenumber: [null],
            cccasenumberlast8digit: [null],
            csacasenumber: [null],
            csacasenumberlast8digit: [null],
            coajuridiction: [null],
            oajuridiction: [null],
            ccjuridiction: [null],
            csajuridiction: [null],
            cccourtdecisionflag: [null],
            cccompileddate: [null],
            csacourtdecisionflag: [null],
            coastayreqflag: [null],
            coastaygrantedflag: [null],
            coaappealedflag: [null],
            coahearingdecisiontypekey: [null],
            coahearingdecisiondate: [null],
            coadetails: [null],
            coacase: [null],
            coacourtdecisionflag: [null],
            coacompileddate: [null],
            coacasenumber: [null],
            coacasenumberlast8digit: [null],
            isvictim: [null],
            csacompileddate: [null],
            csaarguementheld: [null],
            csaarguementnotheldreason: [null],
            ccwhoappealed: [null],
            csawhoappealed: [null],
            ccnotifiedtodirector: [null],
            ccldssnotifieddate: [null],
            csaldssnotifieddate: [null],
            cccicuitcourtkey: [null],
            scsummarymailed: [null],
            scappealedsetdate: [null],
            scisappealformsent: [null],
            cchearingheld: [null],
            cchearingreason: [null],
            cclocationofhearing: [null],
            coacertioraristatus: [null],
            coacertgranteddate: [null],
            coacertdenieddate: [null],
            oahearingheld: [null],
            oahearingheldreason: [null],
            cchearingheldreason: [null],
            oalocationofhearing: [null],
            oasummarydecisionfiledflag: [null],
            oasummarydecisionfileddate: [null],
            csalocationofhearing: [null],
            coalocationofhearing: [null],
            oamodificationsmade: [null],
            oahearingnarrative: [null],
            oatranslator: [null],
            oarunningmotiondate: [null],
            oamaltreatorunnamedflag: [null],
            oacompiledwithoah: [null],
            finalizeddate: [null],
            scmaltreatmenttypeid: [null],
            oahmaltreatmenttypeid : [null],
            ccmaltreatmenttypeid: [null],
            csmaltreatmenttypeid: [null],
            coamaltreatmenttypeid: [null]
        });
    }

    private initFindingsForm() {
        this.investigationFindingForm = this.formBuilder.group({
            jointinvestigation: false,
            summary: [''],
            remarks: [''],
            investigationid: [''],
            allegedperson: this._formBuilder.array([]),
            commentAuditTrail: []
        });
    }


    setChildFatility(panelData: any) {
        this.childFatality = this.investigation.find((x: any) => x.personid === panelData.value.personid);
        this.dod = this.personInfo.find(x => x.personid === panelData.value.personid);     
    }

    checkFatality() {
        if ((this.childFatality && this.childFatality.ischildfatality === 1) ||
            (this.sdmChildFatality === 1 && this.dod && this.dod.dateofdeath) || (this.sdmChildFatality === 0 && this.dod && this.dod.dateofdeath && new Date(this.dod.dateofdeath).getTime() > new Date(this.dsdsActionsSummary.da_receiveddate).getTime())) {
            return true;
        } else {
            return false;
        }
    }

    setFormValues() {
        const control: any = new FormArray([]);
        this.investigationFindingForm.removeControl('allegedperson');
        this.investigation && this.investigation.forEach((x, index) => {
            const found = this.maltreatmentData.filter((ele: { allegationid: string; }) => ele.allegationid === x.allegationid).length > 0;
            const maltreators = x.maltreators ? x.maltreators : [];
            if (maltreators.length > 0 && found) {
                const y = x;
                maltreators.forEach( mal => {
                    y.maltreators = [];
                    y.maltreators.push(mal);
                });
                control.push(this.buildInvestigationForm(y, index));
            }
        });
        if (this.retrydoc) {
            const investigationallegationmaltreatorsid = this.storage.getItem('investigationallegationmaltreatorsid');
            this.maltreatorsIndex = this.investigation?.findIndex((item: any) => item?.maltreators[0]?.investigationallegationmaltreatorsid === investigationallegationmaltreatorsid);
            this.retrydoc = false;
        }  
        this.investigationFindingForm.addControl('allegedperson', control);
        this.existingForm();
    }

    private buildInvestigationForm(x: any, index: any): FormGroup {
        const expungmentStatusObj = ( Array.isArray(x.maltreators) && x.maltreators && x.maltreators.length) ?  x.maltreators.find((data: { activeflag: number; }) => data.activeflag === 1) : null;
        const investFind: any = this.getInvestFind(x,expungmentStatusObj);
        const investFindType = this.getinvestFindType(x);
        investFind.controls['investigationfindingtypekey'].patchValue(investFindType);
        const intentionalInjuryDesc = this.getintentionalInjuryDesc(x);
        investFind.controls['intentionalinjurydesc'].patchValue(intentionalInjuryDesc);
        const findingComments = this.getfindingComments(x);
        investFind.controls['findingcomments'].patchValue(findingComments);
        const commentAuditTrailData = this.getCommentAuditTrail(x);
        this.investigationFindingForm.get('commentAuditTrail')?.patchValue(commentAuditTrailData);
        const isharm = this.getisharm(x);
        investFind.controls['isharm'].patchValue(isharm ? true : false);
        const isHarmSubstantial = this.getisHarmSubstantial(x);

        investFind.controls['isharmsubstantial'].patchValue(isHarmSubstantial ? true : false);
        const harmDesc = this.getharmDesc(x);
        investFind.controls['harmdesc'].patchValue(harmDesc);
        const relationShip = this.getrelationShip(x);
        investFind.controls['relationship'].patchValue(relationShip);
        const displayname = this.getdisplayname(x);
        investFind.controls['allegation'].patchValue(displayname);
        const intakeservicerequestactorid = x.maltreators ? x.maltreators.map((item: { intakeservicerequestactorid: any; }) => item.intakeservicerequestactorid) : null;
        investFind.controls['intakeservicerequestactorid'].patchValue(intakeservicerequestactorid);
        const maltreatmentid = this.getmaltreatmentid(x);
        investFind.controls['maltreatmentid'].patchValue(maltreatmentid);
        const alleagation = this.getalleagation(maltreatmentid);

        let appealData = null;
        if (alleagation) {
            const maltreators = alleagation.maltreators ? alleagation.maltreators : [];
            appealData = maltreators.find((mal: { intakeservicerequestactorid: any; }) => intakeservicerequestactorid.includes(mal.intakeservicerequestactorid));
            if (appealData) {
                const hasHeader = !!appealData.scdecisiontypekey;
                const hasOverride = !!appealData.overridefindingtypekey;
                investFind.controls['isAppealDone'].patchValue(hasHeader);
                investFind.controls['isFinalizeDone'].patchValue(hasOverride);

            }
        }
        const investigationFindings = x.findings ? x.findings : null;
        investFind.controls['investigationfindings'].patchValue(investigationFindings);
        const findings = this.getFindings(investFind);
        const maltreator = this.getMaltreator(x);
        let courtdecision = findings;
        let appealcourtdecision = null;

        if (maltreator) {
            investFind.patchValue({
                dispositionnarrative: maltreator.dispositionnarrative
            });
            courtdecision = this.getcourtdecision(courtdecision, maltreator);
            appealcourtdecision = this.getappealcourtdecision(maltreator);
        }

        investFind.patchValue({
            maltreatmentkey: courtdecision,
            maltreatmentkey2: appealcourtdecision
        });
        if (findings && !this.isAppealWorker && this.showAppeal) {
            investFind.get('maltreatmentkey')?.disable();
        }
        if (investFind.controls['maltreatmentkey3'].value) {
            investFind.get('maltreatmentkey3')?.disable();
        }
        investFind['maltreator'] = x.maltreators[0];
        return investFind;
    }
    getFindings(investFind: any){
        return investFind.getRawValue().maltreatmentkey ? investFind.getRawValue().maltreatmentkey : null;
    }
    getCommentAuditTrail(x: { commentaudittrail: any; }){
        if (x.commentaudittrail) {
            this.commentAuditTrailArray = x.commentaudittrail ?? [];
        }
        return x.commentaudittrail ? x.commentaudittrail : this.commentAuditTrailArray;
    }
    getMaltreator(x: any){
        return Array.isArray(x.maltreators) ? x.maltreators.find((data: { activeflag: number; }) => data.activeflag === 1) : null;
    }
    getInvestFind(x: any, expungmentStatusObj: any) {

        return  this._formBuilder.group({
            personid: this.nullCheck(x.personid),
            investigationallegationid: this.nullCheck(x.investigationallegationid),
            personname: this.nullCheck(x.personname),
            insertedon: x.insertedon,
            name: x.name ? x.name : '',
            dispositionnarrative: x.dispositionnarrative ? x.dispositionnarrative : null,
            relationship: x.relationship ? x.relationship : '',
            maltreatmentkey: (x.findings && Array.isArray(x.findings)) ? x.findings.map((item: { investigationfindingtypekey: any; }) => item.investigationfindingtypekey) : '',
            maltreatmentkey1: (x.findings && Array.isArray(x.findings)) ? x.findings.map((item: { investigationfindingtypekey: any; }) => item.investigationfindingtypekey) : '',
            maltreatmentkey2: '',
            maltreatmentkey3: (x.findings && Array.isArray(x.findings)) ? x.findings.map((item: { finalfinding: any; }) => item.finalfinding) : '',
            investigationfindingtypekey: '',
            reporteddate: x.reporteddate ? x.reporteddate : null,
            intakeservicerequestactorid: x.intakeservicerequestactorid ? x.intakeservicerequestactorid : null,
            investigationfindingid: (x.findings && Array.isArray(x.findings)) ? x.findings.map((item: { investigationfindingid: any; }) => item.investigationfindingid) : '',
            allegation: x.allegation ? x.allegation : '',
            intentionalinjurydesc: '',
            findingcomments: '',
            isharm: '',
            isharmsubstantial: '',
            harmdesc: '',
            investigationfindings: '',
            ischildfatality: this.getischildfatality(x),
            prevchildfatality: this.getischildfatality(x),
            showfatality: false,
            fatalitycomments: this.getfatalitycomments(x),
            victim_explanation: this.getvictimexplanation(x),
            sibling_explanation: this.getsiblingexplanation(x),
            guardian_explanation: this.getguardianexplanation(x),
            maltreator_explanation: this.getmaltreatorexplanation(x),
            med_assessmnts: this.getmedassessmnts(x),
            expert_assessmnts: this.getexpertassessmnts(x),
            law_enforcement_inv: this.getlawenforcementinv(x),
            collateral_interviews: this.getcollateralinterviews(x),
            criminal_history_inv: this.getcriminalhistoryinv(x),
            home_conditions: this.gethomeconditions(x),
            sextrafficking: this.getsextrafficking(x),
            isAppealDone: false,
            isFinalizeDone: false,
            maltreatmentid: this.getmaltreatmentid(x),
            expungementflag: this.getexpungementflag(expungmentStatusObj),
            isunsubstansiated: this.getisunsubstansiated(x),
            isindicated: this.getisindicated(x),
            isremovemaltreator: this.getisremovemaltreator(x),
            isremoverofindings: this.getisremoverofindings(x),
            expert_assessmnts_attachment: this.getexpertassessmntsattachment(x),
            med_assessmnts_attachment: this.getmedassessmntsattachment(x),
            law_enforcement_attachment: this.getlawenforcementattachment(x),
        });
    }

    nullCheck(inputData: any){
        return inputData ? inputData : '';
    }

    getischildfatality(x: any) {
        return x.commentaudittrail && x.commentaudittrail.length ? x.ischildfatality : null;
    }

    getfatalitycomments(x: any) {
        return x.fatalitycomments ? x.fatalitycomments : ''; 
    }

    getvictimexplanation(x: any) { 
        return x.victim_explanation ? x.victim_explanation : ''; 
    }
    getsiblingexplanation(x: any) { 
        return x.sibling_explanation ? x.sibling_explanation : ''; 
    }
    getguardianexplanation(x: any) { 
        return x.guardian_explanation ? x.guardian_explanation : ''; 
    }
    getmaltreatorexplanation(x: any) { 
        return x.maltreator_explanation ? x.maltreator_explanation : ''; 
    }
    getmedassessmnts(x: any) { 
        return x.med_assessmnts ? x.med_assessmnts : ''; 
    }
    getexpertassessmnts(x: any) { 
        return x.expert_assessmnts ? x.expert_assessmnts : ''; 
    }
    getlawenforcementinv(x: any) { 
        return x.law_enforcement_inv ? x.law_enforcement_inv : ''; 
    }
    getcollateralinterviews(x: any) { 
        return x.collateral_interviews ? x.collateral_interviews : ''; 
    }
    getcriminalhistoryinv(x: any) { 
        return x.criminal_history_inv ? x.criminal_history_inv : ''; 
    }
    gethomeconditions(x: any) { 
        return x.home_conditions ? x.home_conditions : ''; 
    }
    getsextrafficking(x: any) { 
        return x.sextrafficking != null ? x.sextrafficking : ''; 
    }
    getmaltreatmentid(x: any) { 
        return x.maltreatmentid ? x.maltreatmentid : null; 
    }
    getexpungementflag(expungmentStatusObj: any) { 
        return (expungmentStatusObj && expungmentStatusObj.expungementflag) ? expungmentStatusObj.expungementflag : ''; 
    }
    getisunsubstansiated(x: any) { 
        return (Array.isArray(x.expungements) && x.expungements && x.expungements.length && x.expungements.filter((item: { isunsubstansiated: any; }) => item.isunsubstansiated) && x.expungements.filter((item: any) => item.isunsubstansiated).length) ? true : ''; 
    }
    getisindicated(x: any) { 
        return (Array.isArray(x.expungements) && x.expungements && x.expungements.length && x.expungements.filter((item: { isindicated: any; }) => item.isindicated) && x.expungements.filter((item: any) => item.isindicated).length) ? true : ''; 
    }
    getisremovemaltreator(x: any) { 
        return (Array.isArray(x.expungements) && x.expungements && x.expungements.length && x.expungements.filter((item: { isremovemaltreator: any; }) => item.isremovemaltreator) && x.expungements.filter((item: any) => item.isremovemaltreator).length) ? true : '';
    }
    getisremoverofindings(x: any) { 
        return (Array.isArray(x.expungements) && x.expungements && x.expungements.length && x.expungements.filter((item: { isremoverofindings: any; }) => item.isremoverofindings) && x.expungements.filter((item: { isremoverofindings: any; }) => item.isremoverofindings).length) ? true : ''; 
    }
    getexpertassessmntsattachment(x: any) { 
        return (Array.isArray(x.expert_assessmnts_attachment)) ? [x.expert_assessmnts_attachment] : [[]]; 
    }
    getmedassessmntsattachment(x: any) { 
        return (Array.isArray(x.med_assessmnts_attachment)) ? [x.med_assessmnts_attachment] : [[]]; 
    }
    getlawenforcementattachment(x: any) { 
        return (Array.isArray(x.law_enforcement_attachment)) ? [x.law_enforcement_attachment] : [[]]; 
    }
    getinvestFindType(x: any) { 
        return x.findings ? x.findings.map((item: { investigationfindingtypekey: any; }) => item.investigationfindingtypekey) : null; 
    }
    getintentionalInjuryDesc(x: any) { 
        return x.findings ? x.findings.map((item: { intentionalinjurydesc: any; }) => item.intentionalinjurydesc) : null; 
    }
    getfindingComments(x: any) { 
        return x.findings ? x.findings.map((item: { findingcomments: any; }) => item.findingcomments) : null; 
    }
    getisharm(x: any) { 
        return x.findings ? x.findings.map((item: { isharm: any; }) => item.isharm) : null; 
    }
    getisHarmSubstantial(x: any) { 
        return x.findings ? x.findings.map((item: { isharmsubstantial: any; }) => item.isharmsubstantial) : null; 
    }
    getharmDesc(x: any) { 
        return x.findings ? x.findings.map((item: { harmdesc: any; }) => item.harmdesc) : null; 
    }
    getrelationShip(x: any) { 
        return x.maltreators ? x.maltreators.map((item: { relationship: any; }) => item.relationship) : null; 
    }
    getdisplayname(x: any) { 
        return x.maltreators ? x.maltreators.map((item: { displayname: any; }) => item.displayname) : null; 
    }
    getintakeservicerequestactorid(x: any) { 
        return x.maltreators ? x.maltreators.map((item: { intakeservicerequestactorid: any; }) => item.intakeservicerequestactorid) : null; 
    }
    getalleagation(maltreatmentid: any) { 
        return this.investigationAllegationList.find((al: { maltreatmentid: any; }) => al.maltreatmentid === maltreatmentid); 
    }

    getcourtdecision(courtdecision: any, maltreator: any) {
        courtdecision = (maltreator.scdecisiontypekey) ? maltreator.scdecisiontypekey : courtdecision;
        courtdecision = (maltreator.oahearingdecision) ? maltreator.oahearingdecision : courtdecision;
        courtdecision = (maltreator.cchearingdecisiontypekey) ? maltreator.cchearingdecisiontypekey : courtdecision;
        courtdecision = (maltreator.csahearingdecisiontypekey) ? maltreator.csahearingdecisiontypekey : courtdecision;
        courtdecision = (maltreator.coahearingdecisiontypekey) ? maltreator.coahearingdecisiontypekey : courtdecision;
        courtdecision = (maltreator.overridefindingtypekey) ? maltreator.overridefindingtypekey : courtdecision;
        return courtdecision;
    }

    getappealcourtdecision(maltreator: any) {
        if (maltreator.overridefindingtypekey) {
            return maltreator.overridefindingtypekey;
        }
        if (maltreator.coahearingdecisiontypekey) {
            return maltreator.coahearingdecisiontypekey;
        }
        if (maltreator.csahearingdecisiontypekey) {
            return maltreator.csahearingdecisiontypekey;
        }
        if (maltreator.cchearingdecisiontypekey) {
            return maltreator.cchearingdecisiontypekey;
        }
        if (maltreator.oahearingdecision) {
            return maltreator.oahearingdecision;
        }
        return maltreator.scdecisiontypekey || null;
    }

    investigationFindings() {
        this._commonHttpService.getSingle({order: 'displayorder',  where: {teamtypekey: 'CW'}, method: 'get'}, 'investigationfindingtype?filter').subscribe((res: any) => {
            this.investigationFindingDropDown = res;
        });
    }

    async getFindingList(): Promise<void> {
        return new Promise((resolve, reject) => {
            const isExpungementSuperUser =  this._authService.isExpungementSuperUser();
            const request = new PaginationRequest({
                page: this.paginationInfo.pageNumber,
                limit: this.paginationInfo.pageSize,
                where: {
                    investigationid: this.dsdsActionsSummary.da_investigationid
                },
                method: 'get'
            });
            if (isExpungementSuperUser === 0) {
                this._commonHttpService
                    .getArrayList(
                        request,
                        'Investigationallegations/getmaltreatmentfinding?filter'
                    )
                    .subscribe({
                        next: (res: any) => {
                            if (res) {
                                this.pageLoaded = true;
                                this.investigation = res;
                                this.submitBtn = this.investigation.length > 0;
                                const maltreatorData = this.investigation.filter(investigationitem => investigationitem?.maltreators?.length > 0);
                                this.noMAfoundMsg = maltreatorData.length <= 0;
                                this.investigationAllegationList = res;
                                if (this.isAppealModalOpen) {
                                    this.uploadedFile = this.investigationAllegationList[this.selectedAppealIndex]?.documentprop !== null ? this.investigationAllegationList[this.selectedAppealIndex]?.documentprop : [];
                                }
                                this.isAppealModalOpen = false;
                                this.setMaltreatmentTypeAudit();
                                this.setReviewStatuses();
                                this.setIsNarrativeSaved();
                                this.objectId = this?.appealData?.investigationallegationmaltreatorsid;
                            } else {
                                this.noMAfoundMsg = true;
                                this.pageLoaded = true;
                            }
                            resolve();
                        },
                        error: (err: any) => reject(err),
                    });
            } else {
                forkJoin([
                    this._commonHttpService
                        .getArrayList(
                            request,
                            'Investigationallegations/getmaltreatmentfinding?filter'
                        )
                        .pipe(catchError(() => of([]))),
                    this._commonHttpService
                        .getArrayList(
                            request,
                            'Investigationallegations/getexpungedmaltreatmentfinding?filter'
                        )
                        .pipe(catchError(() => of([])))
                ]).subscribe({
                    next: ([res1, res2]) => {

                        const res1List = res1 || [];
                        const res2List = res2 || [];
                    
                        // collect investigationallegationid from res1
                        const res1Ids = new Set(
                            res1List.map((item : any) => item?.investigationallegationid)
                        );
                    
                        // keep only res2 records NOT present in res1
                        const filteredRes2 = res2List.filter(
                            item => !res1Ids.has(item?.investigationallegationid)
                        );
                    
                        // final merged result
                        const res = [...res1List, ...filteredRes2];
                    
                        if (res && res.length) {
                            this.pageLoaded = true;
                            this.investigation = res;
                            this.submitBtn = this.investigation.length > 0;
                            const maltreatorData = this.investigation.filter(investigationitem => investigationitem?.maltreators?.length > 0);
                            this.noMAfoundMsg = maltreatorData.length <= 0;                    
                            this.investigationAllegationList = res;                    
                            if (this.isAppealModalOpen) {
                                this.uploadedFile = this.investigationAllegationList[this.selectedAppealIndex]?.documentprop !== null ? this.investigationAllegationList[this.selectedAppealIndex]?.documentprop : [];
                            }
                            this.isAppealModalOpen = false;
                            this.setMaltreatmentTypeAudit();
                            this.setReviewStatuses();
                            this.setIsNarrativeSaved();
                            this.objectId = this?.appealData?.investigationallegationmaltreatorsid;
                        } else {
                            this.noMAfoundMsg = true;
                            this.pageLoaded = true;
                        }
                        resolve();
                    },                    
                    error: (err : any) => {
                        this.noMAfoundMsg = true;
                        this.pageLoaded = true;
                        reject(err);
                    }
                });
            }
        });
    }

    setIsNarrativeSaved(){
        if (this.investigation && Array.isArray(this.investigation) && this.investigation[0]) {
            this.investigationFindingForm.patchValue({
                jointinvestigation: this.investigation[0].jointinvestigation,
                summary: this.investigation[0].investigationsummary,
                remarks: this.investigation[0].notes
            });
            const narrative = this.investigation[0].investigationsummary;
            this.isNarrativeSaved = (narrative && narrative.length > 0) ? true : false;
        }
    }

    getquickperson() {
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        let intakeserviceid = null;
        let intakenumber = '';
        if (caseInfo) {
          intakeserviceid = caseInfo.intakeserviceid;
          intakenumber = caseInfo.intakenumber;
        }
        const request = {
            objectid: intakeserviceid ? intakeserviceid : intakenumber,
            objecttype: intakeserviceid ? 'case' : 'intake',
            intakenumber: intakenumber
        };
        this._commonHttpService.getArrayList(
          {
            where: request,
            method: 'get',
            nolimit: true
          },
          'quickperson/list?filter'
        ).subscribe((data: any) => {
          if (data && data.length && data[0].getquickpersondetails && data[0].getquickpersondetails.length) {
                this.reviewCheckListForm.patchValue({ personConfirmed: false });
          } else {
            this.reviewCheckListForm.patchValue({ personConfirmed: true });
          }
        });
      }

    setReviewStatuses() {
        this._commonHttpService.getArrayList(
            {
                nolimit: true,
                method: 'get',
                where: {

                    intakeserviceid: this.id === undefined ? this.intakeserviceid : this.id
                }
            },
            'expungement/getexpungementreviewstatus?filter').subscribe((data: any) => {
                if(data.length){
                    data.forEach((item: any) => {
                        this.ReviewStatus[item.investigationfindingid] = item.status;
                    });
                }
        });
    }

    openAppeanModal() {
        this.appealDelayForm.reset();
       $(this.investigationpopupid).modal('show');
       $(this.appealstabid).click();
    }

    loadFinalizeData(maltreatmentid: string, investigationFind: any,intakeservicerequestactorid: any = null, index: number = -1) {
        this.allegedMaltreatorName = investigationFind.getRawValue().allegation;
        this.MaltreatmentType = investigationFind.getRawValue().name;
        this.investigationFindingType = investigationFind.getRawValue().maltreatmentkey;
        this.showFinalize = false;
        this.appealFormGroup.reset();
        this.appealInvestigation = this.investigationAllegationList.find((al: { maltreatmentid: string; }) => al.maltreatmentid === maltreatmentid);
        this.appealFindingKey = (this.appealInvestigation && Array.isArray(this.appealInvestigation.findings)) ? this.appealInvestigation.findings[0].investigationfindingtypekey : null;
        this.setMaltreatorsAppeal();

        this.appealDocument = this.appealInvestigation.documentprop;
        this.appealData = this.maltreatorsAppeal.find((mal: { intakeservicerequestactorid: any; activeflag: number; }) => (intakeservicerequestactorid.includes(mal.intakeservicerequestactorid) && mal.activeflag === 1));
        let courtdecision = '';
        let requestedDate = new Date();
        if (this.appealData) {
            courtdecision = this.appealDataCourtDecision(courtdecision);
            requestedDate = this.appealDataRequestedDate(requestedDate);
        }
        if (!this.appealData.overridefindingtypekey) {
            this.appealData.overridefindingtypekey = this.investigationFindingType;
        }
        this.appealData.requestedDate = requestedDate;
        let finalizeddate = requestedDate;
        if (this.appealInvestigation.maltreators && this.appealInvestigation.maltreators.length > 0) {
            const mal = this.appealInvestigation.maltreators.find((malt: { activeflag: number; finalizeddate: null; }) => malt.activeflag === 1 && malt.finalizeddate !== null);
            if (mal) { finalizeddate = mal.finalizeddate; }
        }
        if(this.appealInvestigation.findings) {
        this.appealInvestigation.findings.forEach((item: any) => {
                     const f = this.investigationFindingDropDown.find(i => i.investigationfindingtypekey === courtdecision);
                     if (f) { this.initialFinding = f.description; }
                });
            }
        this.uploadedFile = this.appealInvestigation.documentprop ? this.appealInvestigation.documentprop : [];
        this.finalizeFormGroup.patchValue(this.appealData);
        this.finalizeFormGroup.enable();
        this.unapprove = false;
        if (this.appealData.overrideapprflag) {
            this.unapprove = true;
            this.finalizeFormGroup.disable();
        }
        this.finalizeFormGroup.patchValue({
            finalizeddate : finalizeddate
        });
        this.validateAppealsFlow();
       $('#finalize-appeal').modal('show');
    }
    setMaltreatorsAppeal(){
        this.maltreatorsAppeal = this.appealInvestigation.maltreators ? this.appealInvestigation.maltreators : null;
        this.maltreatorsAppeal = this.maltreatorsAppeal.map((appeal: any) => {
            appeal.iscoapresent = (appeal.coacompileddate) ? true : false;
            appeal.iscsapresent = (appeal.csacompileddate && ( !appeal.coacompileddate)) ? true : false;
            appeal.isccpresent = this.getisccpresent(appeal);
            appeal.isoahpresent = this.getisoahpresent(appeal);
            appeal.isscpresent = this.getisscpresent(appeal);
            return appeal;
         });
    }
    getisccpresent(appeal: { cccompileddate: any; csacompileddate: any; coacompileddate: any; }){
        return (appeal.cccompileddate && ( !appeal.csacompileddate || !appeal.coacompileddate)) ? true : false;
    }
    getisoahpresent(appeal: { oaicesentdate: any; cccompileddate: any; csacompileddate: any; coacompileddate: any; }){
        return (appeal.oaicesentdate && ( !appeal.cccompileddate || !appeal.csacompileddate || !appeal.coacompileddate)) ? true : false;
    }
    getisscpresent(appeal: { scicesentdate: any; oaicesentdate: any; cccompileddate: any; csacompileddate: any; coacompileddate: any; }){
        return (appeal.scicesentdate && (!appeal.oaicesentdate || !appeal.cccompileddate || !appeal.csacompileddate || !appeal.coacompileddate)) ? true : false;
    }
    appealDataCourtDecision(courtdecision: any) {
        courtdecision = (this.appealData.scdecisiontypekey) ? this.appealData.scdecisiontypekey : courtdecision;
        courtdecision = (this.appealData.oahearingdecision) ? this.appealData.oahearingdecision : courtdecision;
        courtdecision = (this.appealData.cchearingdecisiontypekey) ? this.appealData.cchearingdecisiontypekey : courtdecision;
        courtdecision = (this.appealData.csahearingdecisiontypekey) ? this.appealData.csahearingdecisiontypekey : courtdecision;
        courtdecision = (this.appealData.coahearingdecisiontypekey) ? this.appealData.coahearingdecisiontypekey : courtdecision;
        courtdecision = (this.appealData.overridefindingtypekey) ? this.appealData.overridefindingtypekey : courtdecision;
        return courtdecision;
    }
    appealDataRequestedDate(requestedDate: any) {
        requestedDate = (this.appealData.coacompileddate) ? this.appealData.coacompileddate : requestedDate;
        requestedDate = (this.appealData.csacompileddate && (!this.appealData.coacompileddate)) ? this.appealData.csacompileddate : requestedDate;
        requestedDate = (this.appealData.cccompileddate && (!this.appealData.csacompileddate || !this.appealData.coacompileddate)) ? this.appealData.cccompileddate : requestedDate;
        requestedDate = (this.appealData.oaicesentdate && (!this.appealData.cccompileddate || !this.appealData.csacompileddate || !this.appealData.coacompileddate)) ?
            this.appealData.oaicesentdate : requestedDate;
        requestedDate = (this.appealData.scicesentdate && (!this.appealData.oaicesentdate || !this.appealData.cccompileddate || !this.appealData.csacompileddate ||
            !this.appealData.coacompileddate)) ? this.appealData.scicesentdate : requestedDate;

        return requestedDate;
    }

    maltreatmentValidation() {
        this.MaltreatmentsInfo = [];
        this.isMaltreatmentMissing = false;
        if (this.personInfo && this.personInfo.length) {
            const abusedChildList = this.getAbusedChildList();
            const  allegedMaltreators = this.getAllegedMaltreators();
            if (abusedChildList) {
                abusedChildList.forEach(person => {
                    this.maltreatmentCheck(person,allegedMaltreators);
                });
            }

        }


        if (this.maltreatorRelationSet) {
            this.reviewCheckListForm.patchValue({ relationConfirmed: this.maltreatorRelationSet });
         } else {
             this.reviewCheckListForm.patchValue({ relationConfirmed: false });
         }
        if (this.isMaltreatmentMissing) {
            return false;
        } else {
            return true;
        }

    }
    maltreatmentCheck(person: any,allegedMaltreators: any) {
        const maltreatmentArray: any[] = [];
        this.missedMaltreatment = 0;
        if (this.maltreatmentData && this.maltreatmentData.length) {
            this.maltreatmentData.forEach((maltreatment: any) => {
                allegedMaltreators.forEach((maltreator: any) => {
                    const isMaltreatmentAdded = this.getIsMaltreatmentAdded(maltreatment, maltreator, person);
                    const allegedMaltreatment = this.getAllegedMaltreatment(maltreatment, maltreator, person);
                    const maltreatmentObj = this.getMaltreatmentObj(allegedMaltreatment, maltreator, isMaltreatmentAdded, maltreatment);
                    maltreatmentArray.push(maltreatmentObj);
                });

            });
        }
        const personObj = {
            'personId': person.personid, 'personName': person.firstname + ' ' +
                person.lastname, 'maltreatments': maltreatmentArray, 'missedMaltreatments': this.missedMaltreatment
        };
        this.MaltreatmentsInfo.push(personObj);
    }

    getIsMaltreatmentAdded(maltreatment: any, maltreator: any, person: any) {
        return this.investigation && this.investigation.length ?
        this.investigation.find(investigation => investigation.name === maltreatment.name && investigation.personid === person.personid
            && investigation.maltreators && investigation.maltreators.length > 0
            && (investigation.maltreators[0].personid === maltreator.personid)) : null;
    }
    getAllegedMaltreatment(maltreatment: any, maltreator: any, person: any) {
        return this.allegationData && this.allegationData.length ?
        this.allegationData.find((investigation: any) => (investigation.investigationallegation && investigation.investigationallegation.length > 0 && investigation.investigationallegation[0].maltreators && investigation.investigationallegation[0].maltreators.length
            && (investigation.investigationallegation[0].maltreators[0].personid === maltreator.personid)
            ? investigation.investigationallegation[0].allegationname === maltreatment.name : false) && investigation.personid === person.personid) : null;

    }

    getMaltreatmentObj(allegedMaltreatment: any, maltreator: any, isMaltreatmentAdded: any, maltreatment: { name: any; }) {
        let isMaltreatmentNotApplicable = false;
        let isMaltreatorSame = false;
        if (allegedMaltreatment && allegedMaltreatment.investigationallegation && allegedMaltreatment.investigationallegation.length) {
            allegedMaltreatment.investigationallegation.forEach((allg: any) => {
                if (allg.maltreators && allg.maltreators.length && allg.maltreators[0].personid) {
                    if (maltreator.personid === allg.maltreators[0].personid) {
                        isMaltreatorSame = true;
                        isMaltreatmentNotApplicable = false;
                    }
                }
                if (allg.isnotapplicable) {
                    isMaltreatmentNotApplicable = true;
                }
            });
        }
        this.setMaltreatmentMissing(isMaltreatmentAdded, isMaltreatmentNotApplicable, isMaltreatorSame);

        return {
            'maltreatmentName': maltreatment.name,
            'maltreator': maltreator.firstname + ' ' + maltreator.lastname,
            'isMaltreatmentAdded': this.getMaltreatmentAdded(isMaltreatmentAdded, isMaltreatmentNotApplicable, isMaltreatorSame)
        };
    }

    setMaltreatmentMissing(isMaltreatmentAdded: any, isMaltreatmentNotApplicable: any, isMaltreatorSame: any){
        if (!isMaltreatmentAdded && !isMaltreatmentNotApplicable && !isMaltreatorSame) {
            this.missedMaltreatment = this.missedMaltreatment + 1;
            this.isMaltreatmentMissing = true;
        }
    }
    getMaltreatmentAdded(isMaltreatmentAdded: any, isMaltreatmentNotApplicable: any, isMaltreatorSame: any){
        return ((isMaltreatmentAdded || isMaltreatmentNotApplicable) && isMaltreatorSame) ? true : false;
    }

    getAbusedChildList(){
        return this.personInfo.filter(person => {
            const roles = (Array.isArray(person.roles)) ? person.roles : [];
            return roles.some(role => ['AV'].includes(role.intakeservicerequestpersontypekey));
        });
    }

    getAllegedMaltreators(){
        let  allegedMaltreators = this.personInfo.filter(person => {
            const roles = (Array.isArray(person.roles)) ? person.roles : [];
            return roles.some(role => ['AM'].includes(role.intakeservicerequestpersontypekey));
        });
        allegedMaltreators = allegedMaltreators && allegedMaltreators.length ? allegedMaltreators : [];
        return allegedMaltreators;
    }

    getMaltreatments() {
        this._commonHttpService.getArrayList(
            {
                nolimit: true,
                method: 'get',
                where: {

                    investigationid: this.dsdsActionsSummary.da_investigationid
                }
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
        ).subscribe( (data: any) => {
             this.maltreatments = data;
        });
    }

    getMaltreatmentInfo() {
        this._commonHttpService.getArrayList(
            {
                nolimit: true,
                method: 'get',
                where: {
                    intakeservicereqtypeid: this.dsdsActionsSummary.da_typeid,
                    intakeservicereqsubtypeid: this.dsdsActionsSummary.da_subtypeid,
                    investigationid: this.dsdsActionsSummary.da_investigationid
                }
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.GetMaltreatementTypeUrl + '?filter'
        ).subscribe( (data: any) => {
             this.maltreatmentAllegationList = _.cloneDeep(data);
             this.maltreatmentData = data;             
             this.getmaltreatmentData();
        });
    }

    getmaltreatmentData() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    
        // servicerequestid is bound to a uuid parameter, so skip the call rather than
        // 400 on an unresolved id -- the allegation half of the forkJoin still runs.
        const sdm$ = isCaseUuid(this.id)
            ? this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: {
                        servicerequestid: this.id
                    }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmvaluesUrl + '?filter'
            )
            : of([]);
    
        const allegationRequest = {
            where: { investigationid: this.dsdsActionsSummary.da_investigationid },
            method: 'get'
        };
    
        let allegation$;
    
        if (isExpungementSuperUser === 0) {
            allegation$ = this._commonHttpService.getArrayList(
                allegationRequest,
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
            );
        } else {
            allegation$ = forkJoin([
                this._commonHttpService
                    .getArrayList(
                        allegationRequest,
                        CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
                    )
                    .pipe(catchError(() => of([]))),
                this._commonHttpService
                    .getArrayList(
                        allegationRequest,
                        'Investigationallegations/getexpungedinvestigationallegation?filter'
                    )
                    .pipe(catchError(() => of([])))
            ]).pipe(
                map(([res1, res2]) => [...(res1 || []), ...(res2 || [])])
            );
        }
    
        forkJoin([sdm$, allegation$]).subscribe(list => {
            if (list && list.length) {
                this.processOutput(list);
            }
        });
    }
    processOutput(list: any) {
        if (list[1]) {
            this.allegationData = list[1];
        }
        if (list[0]) {
            const resp = list[0];
            if (resp) {
                if (resp.length > 0 && resp[0].getintakeservicerequestsdm &&
                    resp[0].getintakeservicerequestsdm.length > 0) {
                    this.handleSdmDataFn(resp);
                }
                this.setFormValues();
            }
        }
    }

    private handleIfSdmfn(sdm: any) {
        this.sdmChildFatality = sdm.intakesnapshotdata?.sdm?.ischildfatality ? 1 : 0;
        this.physicalAbuseCheck(sdm);
        this.sexualAbuseCheck(sdm);
        this.mentalAbuseCheck(sdm);
        this.mentalNeglectCheck(sdm);
        if (!this.returnSdmCondFn(sdm)) {
            if (this.maltreatmentData && this.maltreatmentData.length) {
                const index = this.maltreatmentData.findIndex((p: { name: string; }) => p.name === 'Neglect');
                if (index >= 0) {
                    this.maltreatmentData.splice(index, 1);
                }
            }
         }
    }
    // Assosiated with getSDM method
    private returnSdmCondFn(sdm: any) {
        return (sdm.isnegmn_unreasonabledelay || sdm.isneguc_leftunsupervised || sdm.isneguc_leftaloneinappropriatecare || sdm.isneguc_leftalonewithoutsupport || sdm.isnegab_abandoned ||
            sdm.isnegfp_cargiverintervene || sdm.isnegrh_treatmenthealthrisk || sdm.isneggn_inadequatesupervision || sdm.isneggn_inadequateclothing || sdm.isneggn_exposuretounsafe ||
            sdm.isneggn_childdischarged || sdm.isneggn_inadequatefood || sdm.isneggn_signsordiagnosis || sdm.isneggn_suspiciousdeath);
    }
    // Assosiated with getSDM method
    private physicalAbuseCheck(sdm: any) {
        if (!(sdm.ismalpa_suspeciousdeath || sdm.ismalpa_nonaccident || sdm.ismalpa_injuryinconsistent ||
            sdm.ismalpa_insjury || sdm.ismalpa_childtoxic || sdm.ismalpa_caregiver|| sdm.ismalpa_labortrafficking)) {
            if (this.maltreatmentData && this.maltreatmentData.length) {
                const index = this.maltreatmentData.findIndex((p: { name: string; }) => p.name === 'Physical Abuse');
                if (index >= 0) {
                    this.maltreatmentData.splice(index, 1);
                }
            }
        }
    }
    // Assosiated with getSDM method
    private sexualAbuseCheck(sdm: any) {
        if (!(sdm.ismalsa_sexualmolestation || sdm.ismalsa_sexualact ||
            sdm.ismalsa_sexualexploitation || sdm.ismalsa_physicalindicators || sdm.ismalsa_sex_trafficking)) {
            if (this.maltreatmentData && this.maltreatmentData.length) {
                const index = this.maltreatmentData.findIndex((p: { name: string; }) => p.name === 'Sexual Abuse');
                if (index >= 0) {
                    this.maltreatmentData.splice(index, 1);
                }
            }
        }
    }
    // Assosiated with getSDM method
    private mentalAbuseCheck(sdm: any) {
        if (!sdm.ismenab_psycologicalability) {
            const index = this.maltreatmentData.findIndex((p: { name: string; }) => p.name === 'Mental Injury- Abuse');
            if (this.maltreatmentData && this.maltreatmentData.length) {
                if (index >= 0) {
                    this.maltreatmentData.splice(index, 1);
                }
            }
        }
    }
    // Assosiated with getSDM method
    private mentalNeglectCheck(sdm: any) {
        if (!sdm.ismenng_psycologicalability) {
            if (this.maltreatmentData && this.maltreatmentData.length) {
                const index = this.maltreatmentData.findIndex((p: { name: string; }) => p.name === 'Mental Injury- Neglect');
                if (index >= 0) {
                    this.maltreatmentData.splice(index, 1);
                }
            }
        }
    }

    getSDM() {
        // See getSDMDetails above -- servicerequestid is bound to a uuid parameter.
        if (!isCaseUuid(this.id)) {
            return;
        }
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: {
                        servicerequestid: this.id
                    }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmvaluesUrl + '?filter'
            )
            .subscribe((res: any) => {
                if (res && res.length > 0 && res[0].getintakeservicerequestsdm &&
                    res[0].getintakeservicerequestsdm.length > 0) {
                    this.handleSdmDataFn(res);
                }
            });
    }

    private handleSdmDataFn(res: any[]) {
        const sdm = res[0].getintakeservicerequestsdm.find((item: { pathwaystatus: string; }) => item.pathwaystatus === 'Accepted');
        if (sdm) {
            this.handleIfSdmfn(sdm);
        }
    }

    loadAppealData(finalized: boolean, appealed: boolean, maltreatmentid: string, investigationFind: any, intakeservicerequestactorid: any = null, index: number = -1) {
        const expungementFlag = investigationFind.getRawValue().expungementflag;
        if (expungementFlag) {
            this.alertMessage = 'Cannot Appeal as Expungement is done for this record.';
          $('#alert-modal').modal('show');
            return;
        }

        this.maltreatmentAllegationIdVar = investigationFind.getRawValue().investigationallegationid;
        this.allegedMaltreatorName = investigationFind.getRawValue().allegation;
        this.MaltreatmentType = investigationFind.getRawValue().name;
        this.investigationFindingType = investigationFind.getRawValue().maltreatmentkey;
        this.showFinalize = false;
        this.appealFormGroup.reset();
        this.appealInvestigation = this.investigationAllegationList.find((al: { maltreatmentid: string; }) => al.maltreatmentid === maltreatmentid);
        this.appealFindingKey = (this.appealInvestigation && Array.isArray(this.appealInvestigation.findings)) ? this.appealInvestigation.findings[0].investigationfindingtypekey : null;
         this.setMaltreatorsAppeal();
         this.appealDocument = this.appealInvestigation.documentprop;
        this.appealData = this.maltreatorsAppeal.find((mal: { intakeservicerequestactorid: any; activeflag: number; }) => (intakeservicerequestactorid.includes(mal.intakeservicerequestactorid) && mal.activeflag === 1));
        this.uploadedFile = this.appealInvestigation.documentprop ? this.appealInvestigation.documentprop.filter((item: { rootobjecttypekey: string; }) => item.rootobjecttypekey === ((this.appealFindingKey === 'UD') ? 'supervisor' : 'oah')) : [] ;
        this.patchAppealForm(this.appealData, finalized, appealed);
        this.validateAppealsFlow();
        this.currentAppeal = this.appealFormGroup.getRawValue();
       $(this.investigationpopupid).modal('show');
       $(this.appealstabid).click();
        this.isAppealModalOpen = true;
        this.selectedAppealIndex = index;
        this.getFindingList();
    }
    onUnsAppealedChange($event: any) {
        this.showCaseTypeForms = $event.checked;
    }
    patchAppealForm(appealData: any, finalized: boolean, appealed: boolean) {
        this.appealFormGroup.reset();
        this.appealFormGroup.patchValue(this.appealData);
        this.prepareOAHdata();
        this.prepareCCdata();
        this.prepareCSAdata();
        this.prepareCOAdata();
        this.prepareSCdata();
        const appealedBy = this.appealData.scappealedby;
        const maltreator = this.appealData.displayname;
        this.isUnsubstantiated = (this.appealFindingKey === 'UD') ? true : false;
        if (this.isUnsubstantiated) {
            this.showConferenceType = 5;
            this.appealFormGroup.patchValue({ type: 5, scappealedby: (appealedBy && appealedBy !== '') ? appealedBy : maltreator });
          	this.appealFormGroup.get('oaicesentdate')?.disable();
            this.appealFormGroup.get('type')?.disable();
        } else {
            this.showConferenceType = null;
            this.appealFormGroup.patchValue({ type: null });
            this.appealFormGroup.get('type')?.enable();
        }
        this.showCaseTypeForms = (this.appealFindingKey !== 'UD') ? true : false;
        this.isFinalize = appealed && !finalized;
        this.isView = appealed && finalized;
    }

    getFindingDescription(findingsId: string) {
        const findingsData = this.investigationFindingDropDown.filter( item => item.investigationfindingtypekey === findingsId);
        if (findingsData && findingsData.length) {
            return findingsData[0].description;
        } else {
            return '';
        }
    }

    getInvolvedPerson() {
        const isExpungementSuperUser =  this._authService.isExpungementSuperUser();
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize,
                    where: {
                        intakeserviceid: this.id === undefined ? this.intakeserviceid : this.id,
                        isExpungementSuperUser: isExpungementSuperUser,
                        iscaseexpunged: this.iscaseexpunged
                    },
                    method: 'get'
                }),
                'People/getpersondetail?filter'
            )
            .subscribe((res: any) => {
                if (res.data) {
                    this.personInfo = res.data;
                    if((['CPS-IR', 'CPS-AR'].includes(this.dsdsActionsSummary?.da_subtype)) && !(this.reviewCheckListForm?.controls?.initalfacetoface?.value)) {
                        this.caseclosureuntimely(res?.data);
                    }
                    this.checkPersonDetails();

                    if (this.victimDetails && this.victimDetails.length && this.maltreatorDetails && this.maltreatorDetails.length) {
                        this.getInvolvedPersonWithPersonID(this.victimDetails,this.maltreatorDetails);
                    }
                }
            });
    }
    getPermanencyPlanHistoryData(investigationFind: any, displaymode: any){
        this.currentCommentTrail = this.commentAuditTrailArray.filter(e => e.maltreatmentID === investigationFind.getRawValue().maltreatmentid);
    }
    checkPersonDetails(){
        const abusedChildList = this.personInfo.filter(person => {
            const roles = (Array.isArray(person.roles)) ? person.roles : [];
            return roles.some(role => ['AV'].includes(role.intakeservicerequestpersontypekey));
        });
        const allegedMaltreators = this.personInfo.filter(person => {
            const roles = (Array.isArray(person.roles)) ? person.roles : [];
            return roles.some(role => ['AM'].includes(role.intakeservicerequestpersontypekey));
        });
        if (allegedMaltreators && allegedMaltreators.length) {
            allegedMaltreators.forEach(maltreator => {
                const check = this.maltreatorDetails.filter(x=>x === maltreator.personid)
                if(check.length === 0){
                this.maltreatorDetails.push(maltreator.personid);
                }
            });
        }

        if (abusedChildList && abusedChildList.length) {
            abusedChildList.forEach(maltreator => {
                this.victimDetails.push(maltreator.personid);
            });
        }
    }

    getCISData() {
        if (this.dsdsActionsSummary && this.dsdsActionsSummary.hascisdata) {
            this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    where: { referralid: this.daNumber },
                    method: 'get'
                }),
                'Investigationfindings/getCisData?filter'
            )
            .subscribe((result: any) => {
                this.cisData = result;
                this.initFindingsForm();
            });
        }

    }
    openMalTreatmentTypePopup(maltreatmentkey: any, malTreatName: any, canOpenOpopup: any) {
        if (maltreatmentkey && malTreatName) {
            const investigation = this.investigation.filter((item) => item.investigationallegationid === malTreatName.investigationallegationid);
            const investComar = {
                investigationfinding: investigation[0],
                involvedPerson: this.personInfo,
                maltreatmentkey: maltreatmentkey,
                isInitialLoad: canOpenOpopup,
                displayMode: (this.roleId.role.name === 'apcs') ? 'view' : 'edit'
            };
            this.investigationComar$.next(investComar);
        }
    }
    maltreatmentType(event: any, malTreatName: any) {
        if(this.submitForReview && this.submitForReview.allegedperson){
            this.updateSubmitForReviewInnerHtml();
        }
        if (malTreatName.value) {
            this.openMalTreatmentTypePopup(event.value, malTreatName.value, true);
        } else {
            this.openMalTreatmentTypePopup(event.value, malTreatName, false);
        }
    }
    openReportDialog(index: any, investigationfinding: any): void {
        this._dataStoreService.setData('investigationfindingauditlist', this.getMaltreatmentTypeAudit(investigationfinding.getRawValue().investigationallegationid));
        this.reportflag = index;
    }

    closeReportDialog() {
        this.reportflag = null;
    }

    actionIconDisplay(malTreatName: any, displayMode: any): boolean {
        const investigation = this.investigation ? this.investigation.filter((item) => item.investigationallegationid === malTreatName.value.investigationallegationid) : [];
        const findingsList = this.findingsList.filter((res) => res.investigationallegationid === malTreatName.value.investigationallegationid);
        if ((findingsList.length > 0) || (investigation.length && investigation[0].findings !== null)) {
            return true;
        }
        return false;
    }
    viewComar(malTreatName: any, displayMode = 'edit'): void {
        if (malTreatName.value) {
            const investigation = this.investigation.filter((item) => item.investigationallegationid === malTreatName.value.investigationallegationid);
            const findingsList = this.findingsList.filter((res) => res.investigationallegationid === malTreatName.value.investigationallegationid);
            if (findingsList.length > 0) {
                this.viewMaltreatementKey = findingsList[0].investigationfindingtypekey;
            } else if (investigation[0].findings !== null) {
                this.viewMaltreatementKey = investigation[0].findings[0].finalfinding ? investigation[0].findings[0].finalfinding : investigation[0].findings[0].investigationfindingtypekey;
            }
            const investComar: any = {
                investigationfinding: investigation[0],
                involvedPerson: this.personInfo,
                maltreatmentkey: this.viewMaltreatementKey,
                isInitialLoad: true,
                displayMode
            };
            this.investigationComar$.next(investComar);
        }
    }

    submitReview() {
            this.commarValidation();
            this._commonHttpService.create(this.submitForReview, this.investigationmaltreatmentaddfindingsurl).subscribe(
                (_result: any) => {
                    this._alertService.success('Investigation findings saved successfully!');
                    this.closePopup();
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    saveInvestigation(investigationFind: any, isAutoSave?: any, index?: any) {
        const expungementFlag = investigationFind.expungementflag;
        if (expungementFlag) {
            this.alertMessage = 'Cannot Save as Expungement is done for this record.';
          $('#alert-modal').modal('show');
            return;
        }
        if (!investigationFind.relationship[0]) {
            this._alertService.warn('No Relationship established between Victim and Maltreator!');
        }
        if (this.investigationFindingForm.valid) {
            const currFatality = parseInt(investigationFind.ischildfatality);
            this.currentCommentTrail = this.commentAuditTrailArray.filter(e =>  e.maltreatmentID === investigationFind.maltreatmentid);

            this.handleCurrentCommentTrailDataFn(currFatality, investigationFind);


            this.investigationFindingForm.get('commentAuditTrail')?.patchValue(this.commentAuditTrailArray);

            this.commarValidation();
            this.submitForReview.allegedperson = this.submitForReview.allegedperson.filter((item: {personid: any;}) => item.personid === investigationFind.personid)
            this.investigationFindingForm.markAsPristine();
            this._commonHttpService.create(this.submitForReview, this.investigationmaltreatmentaddfindingsurl).subscribe(
                (_result: any) => {
                    this.currentfindings = this.investigationFindingForm.getRawValue().allegedperson;
                    if(!isAutoSave){
                    this._alertService.success('Investigation findings saved successfully!');
                    this.isInvAutoSaveFlag = false;
                    this.closePopup();
                    } else {
                        this.lastUpdatedTime = moment().format(this.dtformat);
                        this.isInvAutoSaveFlag = true;
                        this._alertService.success('Investigation findings Auto Saved successfully! Please continue typing and click \'SAVE\' to complete.');
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._alertService.error('Please enter Investigation Narrative');
        }
    }
    // Assosiated with saveInvestigation method
    private handleCurrentCommentTrailDataFn(currFatality: number, investigationFind: any) {
        if (this.currentCommentTrail.length === 0) {
            this.commentAuditTrailArray.push({
                updatedby: this._authService.getCurrentUser().user.userprofile.firstname + ' ' + this._authService.getCurrentUser().user.userprofile.lastname,
                updatedon: new Date().toISOString(),
                latestFatalityValue: currFatality,
                previousFatalityValue: 3,
                comment: investigationFind.fatalitycomments,
                maltreatmentID: investigationFind.maltreatmentid
            });
        } else {
            const latestRecord = this.commentAuditTrailArray
                .filter(e => e.maltreatmentID === investigationFind.maltreatmentid)
                .reduce((latest, current) => {
                    return (latest.updatedon > current.updatedon) ? latest : current;
                }, { updatedon: new Date(0).toISOString() });
            const currFatalityComment = investigationFind.fatalitycomments;
            if ((parseInt(latestRecord.latestFatalityValue) !== currFatality || latestRecord.comment !== currFatalityComment) && Object.keys(latestRecord).length > 0) {
                this.commentAuditTrailArray.unshift({
                    updatedby: this._authService.getCurrentUser().user.userprofile.firstname + ' ' + this._authService.getCurrentUser().user.userprofile.lastname,
                    updatedon: new Date().toISOString(),
                    latestFatalityValue: currFatality,
                    previousFatalityValue: latestRecord ? parseInt(latestRecord.latestFatalityValue) : '',
                    comment: currFatalityComment,
                    maltreatmentID: investigationFind.maltreatmentid
                });
            }
        }
    }

    selectPerson(row: any) {
        this.selectedSupervisor = row;
    }
    loadSupervisor() {
        this.selectedSupervisor = '';


        if(!this.reviewCheckListForm.controls.personConfirmed.value || !this.reviewCheckListForm.controls.relationConfirmed.value) {
            this._alertService.error('All the above indicated mandatory fields must be completed to proceed further');
            return;
        }

        const legislativeRequest = {

            legislativeid: this.legislative ? this.legislative.legislativeid : null,
            intakeserviceid: this.id,

            isinitialfacetoface: this.reviewCheckListForm.controls.initalfacetoface.value,
            islateinitialcontact: this.reviewCheckListForm.controls.lateinitialcontact.value,
            isapprovedmfira: this.reviewCheckListForm.controls.mfira.value,
            isapprovedsafec: this.reviewCheckListForm.controls.safec.value,
            isapprovecansf: this.reviewCheckListForm.controls.canf.value,
            isallpersons: this.reviewCheckListForm.controls.personConfirmed.value,
            isallegedvicitm:this.reviewCheckListForm.controls.relationConfirmed.value,
            islegislativereporting:this.reviewCheckListForm.controls.legislativeReq.value,
            isdataentrynotes:this.reviewCheckListForm.controls.notes.value,
            isreasonnotprovided:this.reviewCheckListForm.controls.forResonNotProvided.value,
            isemergency:this.reviewCheckListForm.controls.emergncyStiuation.value,
            ...FormData
          }
          this._commonHttpService.getArrayList({
            legislative: legislativeRequest, method: 'post'
          },
            'legislative/addupdate').subscribe((_item: any) => {
              this._gelegislativetData();
            })

        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'CWIF' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result: any) => {
                this.supervisorsList = result.data;
                this.supervisorsList = this.supervisorsList.filter(
                    users => users.rolecode === 'SP'
                );
                if (this.supervisorsList && this.supervisorsList.length) {
                    const reviewer = this.dsdsActionsSummary.da_assignedby;
                    const selectedSupervisor = this.supervisorsList.find(user => user.username === reviewer);
                    if (selectedSupervisor) {
                        this.dispositionFormGroup.patchValue({supervisorid: selectedSupervisor.userid });
                    }
                }


            });
        if (this.reviewCheckList.length > 0) {
            const checkList = this.conditionCheckList();
           $(this.investigationreviewpopup).modal('hide');
            if (checkList) {
                this.loadStatuses();

               $(this.intakecaseassignpopupid).modal('show');
            }
        } else {
           $(this.investigationreviewpopup).modal('hide');
        }
    }

    _gelegislativetData(){
        this._commonHttpService.getArrayList(
          {
            where: {intakeserviceid: this.id},
            method: 'get',
            nolimit: true
          },
          'legislative/list?filter'
        ).subscribe((result: any) =>{
          if(result && result[0]){
            this.legislative = result[0];
            this.legislative = this.legislative || {};
          }
        })
      }
    conditionCheckList(): boolean {

    this.enableLegislativeDropDwn();
        if (this.reviewCheckList && this.reviewCheckList.length) {
            return this.validateReviewChecklist();
        } else {
            return false;
        }
    }

    validateReviewChecklist() {
        const isFacetoFace = this.isFacetoFaceFlag();
        let _islateinitialcontact = true;
        if(this.CheckReviewCheckListCondFn()) {
            _islateinitialcontact = false;
        }
        const approvedsafec = this.approvedsafecFlag();
        const safec = approvedsafec && approvedsafec.length;
        const approvedsafecohp = this.approvedsafecohpFlag();
        const safecohp = approvedsafecohp && approvedsafecohp.length;
        const mfira = this.mfiraFlag();
        const isChildDead = this.isChildDeadFlag();

        if(this.isSenChildExists && !this.reviewCheckListForm.controls['activeSenService'].value) {
            return  false;
        }

        return this.returnReviewChecklist(isFacetoFace, isChildDead, _islateinitialcontact, safec, safecohp, mfira);
    }


    returnReviewChecklist(isFacetoFace: any, isChildDead: any, _islateinitialcontact: any, safec: any, safecohp: any, mfira: any) {
        if(this.isSenChildExists && !this.reviewCheckListForm.controls['activeSenService'].value) {
            return  false;
        }

        if ((isFacetoFace || this.caseclosure) && isChildDead && _islateinitialcontact && (safec || safecohp) && mfira && this.dropDwnValidation()) {
            return true;
        } else if ((isFacetoFace || this.caseclosure) && _islateinitialcontact && !isChildDead && (safec || safecohp) && mfira && this.dropDwnValidation()) {
            return true;
        } else {
            return false;
        }
    }




    // Assosiated with validateReviewChecklist method
    private CheckReviewCheckListCondFn() {
        return ((!(!(this?.reviewCheckListForm?.controls?.initalfacetoface?.value) && (this?.caseclosure))) && this.showLateInitialContact()) && (!this.islateinitialcontactFlag());
    }

    isFacetoFaceFlag(){
        return this.reviewCheckList.find(item => item.taskname === 'initalfacetoface' && item.status === 'YES' && item.shownoshow === 'YES');
    }
    islateinitialcontactFlag() {
        return this.reviewCheckList.find(item => item.taskname === 'lateinitialcontact' && ((item.status === 'YES' && item.shownoshow === 'YES') || item.shownoshow === 'NO'));
    }
    approvedsafecFlag() {
        return this.reviewCheckList.filter(item => item.taskname === 'SAFE-C' && item.status === 'Accepted');
    }
    approvedsafecohpFlag() {
        return this.reviewCheckList.filter(item => item.taskname === 'SAFE-C OHP' && item.status === 'Accepted' && item.shownoshow === 'YES');
    }
    mfiraFlag() {
        return this.reviewCheckList.find(item => item.taskname === 'MFIRA' && item.status === 'Accepted' && item.shownoshow === 'YES');
    }
    isChildDeadFlag() {
        return this.reviewCheckList.find(item => item.taskname === 'initalfacetoface' && item.isvalid === 0);
    }

    showLateInitialContact(){
        return this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'lateinitialcontact' && item.shownoshow === 'YES'));
    }

    form1080AFlag(){
        return this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080a'  && item.status === 'Yes' && item.shownoshow === 'YES'));
    }

    form1080BFlag(){
        return this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080b'  && item.status === 'Yes' && item.shownoshow === 'YES'));
    }

    form1080CFlag(){
        return this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080c'  && item.status === 'Yes' && item.shownoshow === 'YES'));
    }

    displayLesgisLativeDropDwn = false;
    enableLegislativeDropDwn(){
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

    dropDwnValidation(){
        if (this.displayLesgisLativeDropDwn) {
            if (this.dsdsActionsSummary && this.dsdsActionsSummary.da_daystogo === '0') {
                const legislativeReq_ = this.reviewCheckListForm.controls.legislativeReq.value;
                const forResonNotProvided_ = this.reviewCheckListForm.controls.forResonNotProvided.value;
                const emergncyStiuation_ = this.reviewCheckListForm.controls.emergncyStiuation.value;
                if (legislativeReq_) {
                    return this.checkLegislativeReq(legislativeReq_, forResonNotProvided_, emergncyStiuation_);
                }
            } else {
                return true;
            }
        } else {
            return  true;
        }
    }
    checkLegislativeReq(legislativeReq_: any, forResonNotProvided_: any, emergncyStiuation_: any) {
        if (legislativeReq_ == "DAEERR") {
            return true;
        } else if (legislativeReq_ == "FRARNP" && forResonNotProvided_) {
            return true;
        } else if (legislativeReq_ == "EMEPRE" && emergncyStiuation_) {
            return true;
        } else if (legislativeReq_ == "SDNRAA") {
            return true;
        } else if (legislativeReq_ == "ROAPNG") {
            return true;
        } else {
            return false;
        }
    }
    commarValidation() {
        this.submitForReview = Object.assign(new SubmitForReview(), this.investigationFindingForm.value); // Saving the form data
        this.submitForReview.investigationid = this.dsdsActionsSummary.da_investigationid;
        if (this.investigation[0]) {
            this.submitForReview.maltreatmentid = this.investigation[0].maltreatmentid;
        }

        if (this.submitForReview.allegedperson) {
            this.submitForReview.allegedperson.forEach((item) => {
                this.findingsList.forEach((res) => {
                    if (item.investigationallegationid === res.investigationallegationid) {
                        item.investigationfindings = [];
                        this.setFindingAssesors(res);
                        const invFinding = this.getInvFinding(res);
                        item.investigationfindings.push(
                            Object.assign(invFinding)
                        );
                    }
                });
            });
            this.submitForReview.allegedperson = this.submitForReview.allegedperson.map((data) => {
                data.med_assessmnts_attachment.forEach((element: { objectid: string; objecttypekey: string; }) => {
                    element.objectid = data.investigationallegationid;
                    element.objecttypekey = 'InvestigationFindingMed';
                });
                data.expert_assessmnts_attachment.forEach((element: { objectid: string; objecttypekey: string; }) => {
                    element.objectid = data.investigationallegationid;
                    element.objecttypekey = 'InvsFindPhysican';
                });
                data.law_enforcement_attachment.forEach((element: { objectid: string; objecttypekey: string; }) => {
                    element.objectid = data.investigationallegationid;
                    element.objecttypekey = 'InvsFindlawEnforcement';
                });
                return Object.assign({
                    personid: data.personid,
                    investigationallegationid: data.investigationallegationid,
                    investigationfindings: data.investigationfindings,
                    ischildfatality: data.ischildfatality,
                    fatalitycomments : data.fatalitycomments,
                    showfatality: data.showfatality,
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
                    med_assessmnts_attachment: data.med_assessmnts_attachment,
                    expert_assessmnts_attachment: data.expert_assessmnts_attachment,
                    law_enforcement_attachment: data.law_enforcement_attachment
                });
            });

        }
    }
    setFindingAssesors(res: any){
        if (!res.isfindingassessor) {
            this.findingAssesors = [];
        } else {
            this.findingAssesors = [
                {
                    professiontypekey: res.professiontypekey,
                    isassessor: 1,
                    firstname: res.firstname,
                    lastname: res.lastname,
                    comments: res.assessorcomments
                },
                {
                    isassessor: 0,
                    securityusersid: res.securityusersid,
                    comments: res.caseworkercomments,
                    professiontypekey: null
                }
            ];
        }
    }
    getInvFinding(res: any){
        return {
            investigationfindingtypekey: res.investigationfindingtypekey ? res.investigationfindingtypekey : '',
            intentionalinjurydesc: res.intentionalinjurydesc ? res.intentionalinjurydesc : '',
            findingcomments: res.findingcomments ? res.findingcomments : '',
            isharm: res.isharm ? res.isharm : '',
            isharmsubstantial: res.isharmsubstantial ? res.isharmsubstantial : '',
            harmdesc: res.harmdesc ? res.harmdesc : '',
            omissiondesc: res.omissiondesc ? res.omissiondesc : '',
            findingassesors: this.findingAssesors,
        }
    }
    reviewCheck() {
        const isValid = this.maltreatmentValidation();
        let isValidChildFatality = true;

        const control = <FormArray>this.investigationFindingForm.controls['allegedperson'];
        for(const element of control.controls){
            if (this.isAppealWorker && element.get('prevchildfatality')?.value !== element.get('ischildfatality') && element.get('fatalitycomments')?.value === '') {
                isValidChildFatality = false;
            }
        }

        if (!isValidChildFatality) {
            this._alertService.warn('Please select a value for Contributing Factor in the Fatality');
            return;
        }
        if (!isValid) {
           $('#maltreatment-validation-modal').modal('show');
            return;
        }
        this.commarValidation();
        this._commonHttpService.create(this.submitForReview, this.investigationmaltreatmentaddfindingsurl).subscribe(
            (_result: any) => {
                const isFacetoFace = this.isFacetoFaceFlag();
                const islateinitialcontact =this.islateinitialcontactFlag();
                const approvedsafec = this.approvedsafecFlag();
                const safec =  approvedsafec && approvedsafec.length ? true : false;
                const approvedsafecohp = this.approvedsafecohpFlag();
                const safecohp =  approvedsafecohp && approvedsafecohp.length ? true : false;
                const mfira = this.mfiraFlag();
                const form1080a = this.form1080AFlag();
                const form1080b = this.form1080BFlag();
                const form1080c = this.form1080CFlag();
                const cansf = this.reviewCheckList.find(item => item.taskname === 'cans-v2' && item.status === 'Accepted');
                const isChildDead = this.isChildDeadFlag();
                this.isChildNotDeadFlag(isChildDead);
                const form1080Paramters = { form1080a,form1080b,form1080c};
                this.patchReviewCheckListForm(isFacetoFace, islateinitialcontact, safec, safecohp, mfira, cansf, form1080Paramters);
                this.checkInvestigationFindings();
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    isChildNotDeadFlag(isChildDead: any){
        if (isChildDead) {
            this.isChildNotDead = false;
        } else {
            this.isChildNotDead = true;
        }
    }

    patchReviewCheckListForm(isFacetoFace: any, islateinitialcontact: any, safec: any, safecohp: any, mfira: any, cansf: any, form1080Paramters: any){
        this.reviewCheckListForm.patchValue({ initalfacetoface: isFacetoFace ? true : false,
            lateinitialcontact:  islateinitialcontact ? true : false,
            safec: (safec || safecohp) ? true : false,
            mfira: mfira ? true : false,
            canf : cansf ? true: false,
            form1080a : form1080Paramters.form1080a ? true : false,
            form1080b : form1080Paramters.form1080b ? true : false,
            form1080c : form1080Paramters.form1080c ? true : false
        })
    }

    checkInvestigationFindings() {
        const commar = this.submitForReview.allegedperson.filter((data) => data.investigationfindings === null);
        const commarChild = this.submitForReview.allegedperson.filter((data) => {
            this.childFatality = this.investigation.find((x) => x.personid === data.personid);
            this.dod = this.personInfo.find(x => x.personid === data.personid);
            if(this.checkFatality() && data.ischildfatality === null){
                return data;
            }
        });
        if (commar.length > 0) {
            this.handleCommarDataFn();
        } else if (commarChild.length > 0) {
            this._alertService.warn('Please select Contributing Factor in the Fatality');
        } else {
            if (this.submitForReview && this.submitForReview.allegedperson) {
                this.updateSubmitForReviewInnerHtml();
            }
            this.checkListMandatory();
           $(this.investigationreviewpopup).modal('show');

           //checking if Form 1080 C is entered or not
            this.checkForm1080CValidation();
        }
    }

    updateSubmitForReviewInnerHtml() : void {
        this.submitForReview.allegedperson.forEach(data => {
            const docInvestigationallegationid = document.getElementById(data.investigationallegationid);
            if (docInvestigationallegationid) {
                docInvestigationallegationid.innerHTML = '';
            }
        });
    }

    checkForm1080CValidation() : void {
        if(!this.checkForm1080CFilled()){
            const caseType = this._session.getItem('CASE_TYPE'); 
            const riskOfHarm=  this._dataStoreService.getData('IsRiskofHarm');
            if((caseType === 'SERVICE CASE' && riskOfHarm) || caseType !== 'SERVICE CASE') {
                this.globalPopupRef.showGlobalPopupAlert('Form 1080 C Alert','Please complete and submit the 1080 C form. The 1080 Series is located in the Forms sub-tab of the Documents tab.');
            } 
          }
    }

    getInvolvedPersonDetail(){
        const agency = this._authService.getAgencyName();
        let getpersonlistreq = {};        
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        
        if (agency === 'CW' && this.isServiceCase) {
          getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
        } else {
          getpersonlistreq = { intakeserviceid: this.id, 'isExpungementSuperUser': isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged};
        }

        let url = '';
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        this._commonHttpService.getPagedArrayList(
          new PaginationRequest({
            page: 1,
            limit: 20,
            method: 'get',
            where: getpersonlistreq
          }),
          url + '?filter'
        ).subscribe((response: any) => {
          if (response && response.data && response.data.length) {
            this.involvedPerson = response.data;
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

    const validPersonsForAV = this.involvedPerson.filter(person => {
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

    // Assosiated with checkInvestigationFindings method
    private handleCommarDataFn() {
        this._alertService.warn('Please select investigation finding');
        if (this.submitForReview && this.submitForReview.allegedperson) {
            this.submitForReview.allegedperson.forEach(data => {
                const docInvestigationallegationid = document.getElementById(data.investigationallegationid);
                if (docInvestigationallegationid) {
                    docInvestigationallegationid.innerHTML = 'Please select Findings';
                }
            });
        }
    }

    reviewCheck_View(){
        this.reviewCheckListForm.patchValue({ initalfacetoface: this.legislative.isinitialfacetoface });
        this.reviewCheckListForm.patchValue({ lateinitialcontact: this.legislative.islateinitialcontact });
        this.reviewCheckListForm.patchValue({ safec: this.legislative.isapprovedsafec });
        this.reviewCheckListForm.patchValue({ mfira: this.legislative.isapprovedmfira });
        this.reviewCheckListForm.patchValue({ canf: this.legislative.isapprovecansf });
        this.reviewCheckListForm.patchValue({ personConfirmed: this.legislative.isallpersons });
        this.reviewCheckListForm.patchValue({ relationConfirmed: this.legislative.isallegedvicitm });
        this.reviewCheckListForm.patchValue({ legislativeReq: this.legislative.islegislativereporting });
        this.reviewCheckListForm.patchValue({ notes: this.legislative.isdataentrynotes });
        this.reviewCheckListForm.patchValue({ emergncyStiuation: this.legislative.isemergency });
        this.reviewCheckListForm.patchValue({ forResonNotProvided: this.legislative.isreasonnotprovided });

        this.legislativeReq_Change();

       $(this.investigationreviewpopup).modal('show');
    }
    getCheckList() {
        const intakeNumber = this._dataStoreService.getData("da_intakenumber");
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    where: { intakeserviceid: this.id, intakeNumber : intakeNumber },
                    method: 'get'
                }),
                'Investigationfindings/getfacetofacedetails?filter'
            )
            .subscribe((result: any) => {
                this.reviewCheckList = result;
                this.safeCDataSource = new MatTableDataSource(result[1].safecmissingchild);
                this.mfiraDataSource = new MatTableDataSource(result[1].miframissingchild);
                this.form1080aDataSource = new MatTableDataSource(result[1].form1080achild);
                this.form1080bDataSource = new MatTableDataSource(result[1].form1080bchild);
                this.form1080cDataSource = new MatTableDataSource(result[1].form1080cchild);
            });
    }
    closePopup() {
       $(this.intakecaseassignpopupid).modal('hide');
       $(this.investigationreviewpopup).modal('hide');
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
            map((result: any) => {
                return result.map((res: any) => new DropdownModel({
                            text: res.description,
                            value: res.servicerequesttypeconfigiddispostionid
                        })
                );
            }));
        this.dispositionDropdownItems$.subscribe((data: any) => { this.dispositionDropdownItems = data; });
    }
    onFatalityChange(event: any, investigation: any, index: any) {
        const control = <FormArray>this.investigationFindingForm.controls['allegedperson'];
        control.controls[index].get('fatalitycomments')?.reset();
        control.controls[index].patchValue({showfatality : false});
        if (event.value === 1) {
            const selectedPerson = this.personInfo.filter(person => person.personid === investigation.value.personid);
            if (selectedPerson && selectedPerson.length && !selectedPerson[0].dateofdeath) {
                // const control = <FormArray>this.investigationFindingForm.controls['allegedperson'];
                // control.controls[index].patchValue({ ischildfatality: 0 });
                this._alertService.error('Please select person date of death');
            }
        }
    }
    confirmDisposition() {
        this.saveDisposition();

    }
    cancelConfirmDisposition() {
       $('#status-disposition').modal('show');
    }
    saveDisposition() {
        const dispositionModal = new DispositionAddModal();
        dispositionModal.disposition = Object.assign({
            intakeserviceid: this.id,
            intakeserreqstatustypeid: this.dispositionFormGroup.getRawValue().statusid.split('~')[1],
            dispostionid: this.dispositionFormGroup.value.dispositionid,
            reviewcomments: this.dispositionFormGroup.value.reviewcomments,
            closingcodetypekey: this.dispositionFormGroup.value.closingcodetypekey,
            dateseen: new Date(),
            supervisorid: this.dispositionFormGroup.value.supervisorid,
            notifymsg: 'Disposition Submitted '
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
               $(this.intakecaseassignpopupid).modal('hide');
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
            (error: any) => {
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
            map((result: any) => {
                return result.map(
                    (res: any) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.intakeserreqstatustypekey + '~' + res.intakeserreqstatustypeid
                        })
                );
            }));
            this.statusDropdownItems$.subscribe((data: any) => {
                const completeStatus: any = data.find((item: any) => item.text === 'Completed');
                this.dispositionFormGroup.patchValue({
                    statusid : completeStatus.value
                });
                this.loadDispositon(completeStatus.value);
                this.dispositionFormGroup.get('statusid')?.disable();
            });
    }
    private getActionSummary() {        
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonHttpService.getById(this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${this.iscaseexpunged}`, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe(
            (response: any) => {
                this.dsdsActionsSummary = response[0];
                if (this.dsdsActionsSummary) {
                    this.daType = this.dsdsActionsSummary.da_typeid;
                    this.getFindingList();
                    this.getCheckList();
                    this.getMaltreatmentInfo();
                } else {
                    this._alertService.error('DSDS Action Summary is Empty, Please Check Your Data.');
                }
            },
            (_error: any) => {
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
        };
        this.reviewCheckList.forEach((review) => {
            if (review.taskname === 'initalfacetoface' && review.isvalid === 1) {
                this.isMandatory.initialfacetoface = true;
            } else if (review.taskname === 'Safe C Assessment' && review.isvalid === 1) {
                this.isMandatory.safec = true;
            } else if (review.taskname === 'lateinitialcontact' && review.isvalid === 1) {
                this.isMandatory.safec = true;
            } else if (review.taskname === 'CANS-F assessment' && review.isvalid === 1) {
                this.isMandatory.cansf = true;
            } else if (review.taskname === 'MFIRA assessment' && review.isvalid === 1) {
                this.isMandatory.mfira = true;
            }
            else if (review.taskname === 'Personrole' && review.isvalid === 1) {
                this.isMandatory.personrole = true;
            }
        });
    }
    onConfDecisonChange(event: any) {
        if (['UD', 'ID'].includes(event.value)) {
            this.appealFormGroup.get('scappealed')?.enable();
        } else {
            this.appealFormGroup.get('scappealed')?.disable();
        }
    }

    onConfTypeChange(event: any) {
       $(this.appealstabid).click();
        this.appealFormGroup.reset();
        this.appealFormGroup.patchValue({ type: event.value });
        this.appealFormGroup.get('oaicesentdate')?.disable();
        this.appealFormGroup.get('oahearingdecision')?.disable();
        this.appealFormGroup.get('oahearingdecisiondate')?.disable();
        const fileList = (this.appealDocument && Array.isArray(this.appealDocument)) ? this.appealDocument : [];

        switch (event.value) {
            case '1':
                this.conferenceTypeTitle = 'OAH';
                this.showConferenceType = 1;
                this.prepareOAHdata();
                this.appealFormGroup.get('oaicesentdate')?.enable();
                this.appealFormGroup.get('oahearingdecision')?.enable();
                this.appealFormGroup.get('oahearingdecisiondate')?.enable();
                this.uploadedFile = fileList.filter(item => item.rootobjecttypekey === 'oah');
                break;
            case '2':
                this.conferenceTypeTitle = this.circuitcourt;
                this.showConferenceType = 2;
                this.prepareCCdata();
                this.uploadedFile = fileList.filter(item => item.rootobjecttypekey === 'circuitcourt');
                break;
            case '3':
                this.conferenceTypeTitle = 'CSA';
                this.showConferenceType = 3;
                this.prepareCSAdata();
                this.uploadedFile = fileList.filter(item => item.rootobjecttypekey === 'courtspecial');
                break;
            case '4':
                this.conferenceTypeTitle = 'COA';
                this.showConferenceType = 4;
                this.prepareCOAdata();
                this.uploadedFile = fileList.filter(item => item.rootobjecttypekey === 'coa');
                break;
            case '5':
                this.conferenceTypeTitle = 'SC';
                this.showConferenceType = 5;
                this.prepareSCdata();
                this.appealFormGroup.get('scappealed')?.disable();
                this.uploadedFile = fileList.filter(item => item.rootobjecttypekey === 'supervisor');
                break;
            default:
                this.showConferenceType = -1;
                break;

        }
        this.currentAppeal = this.appealFormGroup.getRawValue();
    }

    saveBtn(isAutoSave?: any){
        const uindex = this.uploadedFile.length - 1;
        this.uploadAttachment(uindex, isAutoSave,'','','')

    }
    objectId:any;
    saveAppeal(isAutoSave?: any) {

        this.findInvalidControls(this.appealFormGroup);
        if (this.appealFormGroup.invalid) {
            this._alertService.warn('Please fill mandatory fields.');
        } else {
            const formValue = this.appealFormGroup.getRawValue();
            let reqJSON = Object.assign({}, this.appealData);
            reqJSON.investigationallegationmaltreatorsid = this.appealData.investigationallegationmaltreatorsid;
            reqJSON = this.prepareReqJson(reqJSON, formValue);
            reqJSON.investigationallegationmaltreatorsid = this.appealData.investigationallegationmaltreatorsid;
            reqJSON.attachment = this.appealData.documentprop;
            reqJSON.intakeservicerequestactorid = this.appealData.intakeservicerequestactorid;
            reqJSON.allegationid = this.appealInvestigation.investigationallegationid;
            this.updateAppealHistory(reqJSON, isAutoSave, formValue);
        }
    }
    updateAppealHistory(reqJSON: any, isAutoSave: any, formValue: any){
        this._commonHttpService.create(reqJSON, 'Investigationallegationmaltreators/updateappealhistory').subscribe((_res: any) => {
            this.currentAppeal = this.appealFormGroup.getRawValue();
            if(!isAutoSave){
                this.isAppealAutoSaveFlag = false;
                this._alertService.success('Appeal saved successfully');
               $(this.investigationpopupid).modal('hide');
                this.getFindingList();
                setTimeout(()=> {
                    if(formValue.ccmaltreatmenttypeid !== null || formValue.oahmaltreatmenttypeid !== null || formValue.coamaltreatmenttypeid !== null || formValue.csmaltreatmenttypeid !== null || formValue.scmaltreatmenttypeid !== null) {
                        const investigation = this.investigation.filter((item) => item.investigationallegationid === this.maltreatmentAllegationIdVar);
                        const investComar = {
                            investigationfinding: investigation[0],
                            involvedPerson: this.personInfo,
                            maltreatmentkey: this.investigationFindingType,
                            isInitialLoad: true,
                            displayMode: (this.roleId.role.name === 'apcs') ? 'view' : 'edit'
                        };
                        this.investigationComar$.next(investComar);
                    }
                }, 2000);
            } else {
                this.getFindingList();
                this.lastUpdatedTime = moment().format(this.dtformat);
                this.isAppealAutoSaveFlag = true;
                this._alertService.success('Appeal auto saved successfully! Please continue typing and click \'SAVE APPEAL\' to complete.');
            }
        });
    }
    prepareReqJson(reqJSON: any, formValue: any){
        switch (this.conferenceTypeTitle) {
            case this.circuitcourt:
                reqJSON.ccstayrequestedflag = this.getOneOrZero(formValue.ccstayrequestedflag);
                reqJSON.ccstaygrantedflag = this.getOneOrZero(formValue.ccstaygrantedflag);
                reqJSON.ccappealedflag = this.getOneOrZero(formValue.ccappealedflag);
                reqJSON.cchearingdecisiontypekey = formValue.cchearingdecisiontypekey;
                reqJSON.cchearingdecisiondate = formValue.cchearingdecisiondate;
                reqJSON.ccdetails = formValue.ccdetails;
                reqJSON.cccasenumber = formValue.cccasenumber;
                reqJSON.cccasenumberlast8digit = formValue.cccasenumberlast8digit;
                reqJSON.cccourtdecisionflag = this.getOneOrZero(formValue.cccourtdecisionflag);
                reqJSON.cccompileddate = formValue.cccompileddate;
                reqJSON.ccldssname = formValue.ccldssname;
                reqJSON.ccappellentatrny = formValue.ccappellentatrny;
                reqJSON.ccwhoappealed = formValue.ccwhoappealed;
                reqJSON.ccnotifiedtodirector = formValue.ccnotifiedtodirector;
                reqJSON.ccldssnotifieddate = formValue.ccldssnotifieddate;
                reqJSON.cchearingheld = formValue.cchearingheld;
                reqJSON.cchearingreason = formValue.cchearingreason;
                reqJSON.cclocationofhearing = formValue.cclocationofhearing;
                reqJSON.cccicuitcourtkey = formValue.cccicuitcourtkey;
                reqJSON.cchearingheldreason = formValue.cchearingheldreason;
                reqJSON.ccjuridiction = formValue.ccjuridiction;
                reqJSON.ccmaltreatmenttypeid = formValue.ccmaltreatmenttypeid;
                break;
            case 'CSA':
                reqJSON.csastayrequestedflag = this.getOneOrZero(formValue.csastayrequestedflag);
                reqJSON.csastaygrantedflag = this.getOneOrZero(formValue.csastaygrantedflag);
                reqJSON.csaappealedflag = this.getOneOrZero(formValue.csaappealedflag);
                reqJSON.csahearingdecisiontypekey = formValue.csahearingdecisiontypekey;
                reqJSON.csahearingdecisiondate = formValue.csahearingdecisiondate;
                reqJSON.csadetails = formValue.csadetails;
                reqJSON.csacasenumber = formValue.csacasenumber;
                reqJSON.csacasenumberlast8digit = formValue.csacasenumberlast8digit;
                reqJSON.csacourtdecisionflag = this.getOneOrZero(formValue.csacourtdecisionflag);
                reqJSON.csacompileddate = formValue.csacompileddate;
                reqJSON.csaldssnotifieddate = formValue.csaldssnotifieddate;
                reqJSON.csawhoappealed = formValue.csawhoappealed;
                reqJSON.csaarguementheld = formValue.csaarguementheld;
                reqJSON.csaarguementnotheldreason = formValue.csaarguementnotheldreason;
                reqJSON.csaldssname = formValue.csaldssname;
                reqJSON.csaappellentatrny = formValue.csaappellentatrny;
                reqJSON.csanotifiedtodirector = formValue.csanotifiedtodirector;
                reqJSON.csalocationofhearing = formValue.csalocationofhearing;
                reqJSON.csajuridiction = formValue.csajuridiction;
                reqJSON.csmaltreatmenttypeid = formValue.csmaltreatmenttypeid;
                break;
            case 'COA':
                reqJSON.coastayreqflag = this.getOneOrZero(formValue.coastayreqflag);
                reqJSON.coastaygrantedflag = this.getOneOrZero(formValue.coastaygrantedflag);
                reqJSON.coaappealedflag = this.getOneOrZero(formValue.coaappealedflag);
                reqJSON.coahearingdecisiontypekey = formValue.coahearingdecisiontypekey;
                reqJSON.coahearingdecisiondate = formValue.coahearingdecisiondate;
                reqJSON.coadetails = formValue.coadetails;
                reqJSON.coacasenumber =  formValue.coacasenumber;
                reqJSON.coacasenumberlast8digit = formValue.coacasenumberlast8digit;
                reqJSON.coacourtdecisionflag = this.getOneOrZero(formValue.coacourtdecisionflag);
                reqJSON.coacompileddate = formValue.coacompileddate;
                reqJSON.csaldssname = formValue.csaldssname;
                reqJSON.coacertioraristatus = formValue.coacertioraristatus;
                reqJSON.coacertgranteddate = formValue.coacertgranteddate;
                reqJSON.coacertdenieddate  = formValue.coacertdenieddate;
                reqJSON.csaappellentatrny = formValue.csaappellentatrny;
                reqJSON.coaldssname = formValue.coaldssname;
                reqJSON.coaappellentatrny = formValue.coaappellentatrny;
                reqJSON.coalocationofhearing = formValue.coalocationofhearing;
                reqJSON.coajuridiction = formValue.coajuridiction;
                reqJSON.coamaltreatmenttypeid = formValue.coamaltreatmenttypeid;
                break;
            case 'SC': {
                reqJSON.scicesentdate = formValue.scicesentdate;
                reqJSON.scconfheldflag = this.getOneOrZero(formValue.scconfheldflag);
                reqJSON.scdecisiontypekey = formValue.scdecisiontypekey;
                reqJSON.scconferencedetail = formValue.scconferencedetail;
                reqJSON.scconferencedate = formValue.scconferencedate;
                reqJSON.scisappealed = formValue.scisappealed;
                reqJSON.scappealedby = formValue.scappealedby;
                reqJSON.scappealeddate = formValue.scappealeddate;
                reqJSON.scdecisiontypekey = formValue.scdecisiontypekey;
                reqJSON.scappealedsetdate = formValue.scappealedsetdate;
                reqJSON.scisappealformsent = formValue.scisappealformsent;
                reqJSON.scsummarymailed = formValue.scsummarymailed;
                reqJSON.scmaltreatmenttypeid = formValue.scmaltreatmenttypeid;
                break;
            }
            case 'OAH':
                reqJSON.oahearingdatesetflag = formValue.oahearingdatesetflag;
                reqJSON.oahearingdate = formValue.oahearingdate;
                reqJSON.oahearingdecision = formValue.oahearingdecision;
                reqJSON.oahearingdecisiondate = formValue.oahearingdecisiondate;
                reqJSON.oacasenumber = 'DHS-' +  ( formValue.oajuridiction ? formValue.oajuridiction : '' ) + '-' + ( formValue.oacasenumberlast8digit ? formValue.oacasenumberlast8digit : '' );
                reqJSON.oacasenumberlast8digit = formValue.oacasenumberlast8digit;
                reqJSON.oaicesentdate = formValue.oaicesentdate;
                reqJSON.oanorhearingreason = formValue.oanorhearingreason;
                reqJSON.oadetails = formValue.oadetails;
                reqJSON.oaappealedflag = this.getOneOrZero(formValue.oaappealedflag);
                reqJSON.oaldssname = formValue.oaldssname;
                reqJSON.oaappellentatrny = formValue.oaappellentatrny;
                reqJSON.oalocaldept = formValue.oalocaldept;
                reqJSON.oarunningmotion = formValue.oarunningmotion;
                reqJSON.oahearingnarrative = formValue.oahearingnarrative;
                reqJSON.oamodificationsmade = formValue.oamodificationsmade;
                reqJSON.oarunningmotiondate = formValue.oarunningmotiondate;
                reqJSON.oamaltreatorunnamedflag = formValue.oamaltreatorunnamedflag;
                reqJSON.oacompiledwithoah = formValue.oacompiledwithoah;
                reqJSON.oatranslator = formValue.oatranslator;
                reqJSON.oahearingheld = formValue.oahearingheld;
                reqJSON.oahearingheldreason = formValue.oahearingheldreason;
                reqJSON.oalocationofhearing = formValue.oalocationofhearing;
                reqJSON.oasummarydecisionfiledflag = formValue.oasummarydecisionfiledflag;
                reqJSON.oasummarydecisionfileddate = formValue.oasummarydecisionfileddate;
                reqJSON.oajuridiction = formValue.oajuridiction;
                reqJSON.oahmaltreatmenttypeid = formValue.oahmaltreatmenttypeid;
                break;
        }
        return reqJSON;
    }
    getOneOrZero(inputflag: any){
        return inputflag ? 1 : 0;
    }
    approveOrUnapprove() {
        if (this.unapprove) {
            this.finalizeFormGroup.enable();
            this.unapprove = !this.unapprove;
        } else {
            this.saveFinalize(1);
        }
    }
    saveFinalize(overrideFlag: any) {

        this.findInvalidControls(this.finalizeFormGroup);
        if (this.finalizeFormGroup.invalid) {
            this._alertService.warn('Please fill mandatory feilds.');
        } else {
            if (overrideFlag) {
                this.unapprove = !this.unapprove;
            }
            const formValue = this.finalizeFormGroup.getRawValue();
            const reqJSON = Object.assign({}, this.appealData);
            reqJSON.investigationallegationmaltreatorsid = this.appealData.investigationallegationmaltreatorsid;
            reqJSON.overrideapprflag = overrideFlag;
            reqJSON.overridecomments = formValue.overridecomments;
            reqJSON.overridefindingtypekey = formValue.overridefindingtypekey;
            reqJSON.finalizeddate = formValue.finalizeddate;
            reqJSON.finalizeflag = true;
            this._commonHttpService.create(reqJSON, 'Investigationallegationmaltreators/updateappeal').subscribe((_res: any) => {
                this._alertService.success( 'Appeal finalized successfully');
               $('#finalize-appeal').modal('hide');
                this.getFindingList();
            });
        }
    }
    getJurisdictionList() {
        this.juristictionList$ = this._commonHttpService.create({
            order: 'countyname asc',
            nolimit: true
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList);
    }

    getHearingReasonList() {
        this._commonHttpService.getArrayList({
            method: 'get',
            where: { tablename: 'orderdescription', teamtypekey: 'CW' }
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes + '?filter').subscribe((data: any) => {
            this.hearingReasonList = data;
        });
    }
    getAppealDocumentList() {
        this._commonHttpService.getArrayList({
            method: 'get',
            where: { tablename: 'appealdocuments', teamtypekey: 'CW' }
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes + '?filter').subscribe((data: any) => {
            this.appealDocumentList = data;
            this.appealDocumentList.forEach((element,index) => {
                if (this.appealDocumentList[index].ref_key == 'NOC' || this.appealDocumentList[index].ref_key == 'SOC') {
                    this.appealDocumentList[index].description = this.appealDocumentList[index].description + 'x'
                }
            });

        });
    }

    getJuridictionList() {
        this._commonHttpService.getArrayList({
            method: 'get',
            where: { tablename: 'jurisdictioncode', teamtypekey: 'CW' }
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes + '?filter').subscribe((data: any) => {
            this.juridictionList = data;
        });
    }
    getJudiLocationList() {
        this._commonHttpService.getArrayList({
            method: 'get',
            where: { tablename: 'jurilocation', teamtypekey: 'CW' },
            order: 'value_text ASC'
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes + '?filter').subscribe((data: any) => {
            this.judiLocationList = data;
        });
    }
    getJudiAddressList() {
        this._commonHttpService.getArrayList({
            order: 'attorneyname asc',
            method: 'get',
            where: {}
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.attorneyaddress + '?filter').subscribe((data: any) => {
            this.judiAddressList = data;
        });
    }

    prepareSCdata() {
        this.appealFormGroup.patchValue({
            scicesentdate: this.appealData.scicesentdate ? new Date(this.appealData.scicesentdate) : null,
            scdecisiontypekey: this.appealData.scdecisiontypekey,
            scconferencedate: this.appealData.scconferencedate ? new Date(this.appealData.scconferencedate) : null,
            scappealedby: (this.appealData && (this.appealData.scappealedby || this.appealData.scappealedby === '')) ? this.appealData.scappealedby : this.appealData.displayname,
            scconfheldflag: this.appealData.scconfheldflag,
            scappealeddate: this.appealData.scappealeddate ? new Date(this.appealData.scappealeddate) : null,
            scisappealed: this.appealData.scisappealed,
            scconferencedetail: this.appealData.scconferencedetail,
            scappealedsetdate: this.appealData.scappealedsetdate ? new Date(this.appealData.scappealedsetdate) : null,
            scisappealformsent: this.appealData.scisappealformsent,
            scsummarymailed: this.appealData.scsummarymailed,
            scmaltreatmenttypeid: this.appealData.scmaltreatmenttypeid ? this.appealData.scmaltreatmenttypeid : null

        });
    }
    extractfromCaseNumber(data: any, controlName: any) {
    if (data) {
      const splitArray  = data.split('-', 3);
      const juridiction = (splitArray && splitArray.length && splitArray.length >= 2 ) ? splitArray[1] : '';
      const last8digit = (splitArray && splitArray.length && splitArray.length >= 3 ) ? splitArray[2] : '';
      switch (controlName) {
          case 'juridiction':
              return juridiction;
          case 'last_8_digit':
              return last8digit ;
          default:
              return last8digit;
      }
     } else {
         return '';
     }
    }
    prepareOAHdata() {
        this.appealFormGroup.patchValue({
            oaicesentdate: this.appealData.oaicesentdate ? new Date(this.appealData.oaicesentdate) : null,
            oacasenumber: this.appealData.oacasenumber,
            oacasenumberlast8digit: this.extractfromCaseNumber(this.appealData.oacasenumber, 'last_8_digit'),
            oahearingdecisiondate: this.appealData.oahearingdecisiondate ? new Date(this.appealData.oahearingdecisiondate) : null,
            oaldssname: this.appealData.oaldssname,
            oahearingdatesetflag: this.appealData.oahearingdatesetflag,
            oaappellentatrny: this.appealData.oaappellentatrny,
            oanorhearingreason: this.appealData.oanorhearingreason,
            oaappealedflag: this.appealData.oaappealedflag,
            oalocaldept: this.appealData.oalocaldept,
            oarunningmotion: this.appealData.oarunningmotion,
            oadetails: this.appealData.oadetails,
            oahearingnarrative: this.appealData.oahearingnarrative,
            oamodificationsmade: this.appealData.oamodificationsmade,
            oarunningmotiondate:  this.appealData.oarunningmotiondate ? new Date(this.appealData.oarunningmotiondate) : null,
            oamaltreatorunnamedflag: this.appealData.oamaltreatorunnamedflag,
            oacompiledwithoah: this.appealData.oacompiledwithoah,
            oatranslator: this.appealData.oatranslator,
            oahearingheld: this.appealData.oahearingheld,
            oahearingheldreason: this.appealData.oahearingheldreason,
            oalocationofhearing: this.appealData.oalocationofhearing,
            oasummarydecisionfiledflag: this.appealData.oasummarydecisionfiledflag,
            oasummarydecisionfileddate: this.appealData.oasummarydecisionfileddate ? new Date(this.appealData.oasummarydecisionfileddate) : null,
            oahearingdate: this.appealData.oahearingdate ? new Date(this.appealData.oahearingdate) : null,
            oahearingdecision: this.appealData.oahearingdecision,
            oajuridiction: this.extractfromCaseNumber(this.appealData.oacasenumber, 'juridiction'),
            oahmaltreatmenttypeid: this.appealData.oahmaltreatmenttypeid ? this.appealData.oahmaltreatmenttypeid : null
        });
    }

    prepareCCdata() {
        this.appealFormGroup.patchValue({
            cchearingdecisiondate:  this.appealData.cchearingdecisiondate ? new Date(this.appealData.cchearingdecisiondate) : null,
            cchearingdecisiontypekey: this.appealData.cchearingdecisiontypekey,
            cccicuitcourtkey: this.appealData.cccicuitcourtkey,
            cccasenumber: this.appealData.cccasenumber,
            cccasenumberlast8digit: this.extractfromCaseNumber(this.appealData.cccasenumber, 'last_8_digit'),
            ccldssname: this.appealData.ccldssname,
            ccappellentatrny: this.appealData.ccappellentatrny,
            ccwhoappealed: this.appealData.ccwhoappealed,
            cccourtdecisionflag: this.appealData.cccourtdecisionflag,
            ccappealedflag: this.appealData.ccappealedflag,
            ccnotifiedtodirector: this.appealData.ccnotifiedtodirector,
            ccldssnotifieddate: this.appealData.ccldssnotifieddate ? new Date(this.appealData.ccldssnotifieddate) : null,
            ccdetails: this.appealData.ccdetails,
            cccompileddate:  this.appealData.cccompileddate ? new Date(this.appealData.cccompileddate) : null,
            cchearingreason: this.appealData.cchearingreason,
            cchearingheld: this.appealData.cchearingheld,
            cclocationofhearing: this.appealData.cclocationofhearing,
            ccjuridiction: this.extractfromCaseNumber(this.appealData.cccasenumber, 'juridiction'),
            ccmaltreatmenttypeid: this.appealData.ccmaltreatmenttypeid ? this.appealData.ccmaltreatmenttypeid : null
        });
}

    prepareCSAdata() {
        this.appealFormGroup.patchValue({
            csacompileddate: this.appealData.csacompileddate ? new Date(this.appealData.csacompileddate) : null,
            csaarguementheld: this.appealData.csaarguementheld,
            csaarguementnotheldreason: this.appealData.csaarguementnotheldreason,
            csahearingdecisiontypekey: this.appealData.csahearingdecisiontypekey,
            csaldssname: this.appealData.csaldssname,
            csacasenumber: this.appealData.csacasenumber,
            csacasenumberlast8digit: this.extractfromCaseNumber(this.appealData.csacasenumber, 'last_8_digit'),
            csaappellentatrny: this.appealData.csaappellentatrny,
            csahearingdecisiondate: this.appealData.csahearingdecisiondate,
            csacourtdecisionflag: this.appealData.csacourtdecisionflag,
            csanotifiedtodirector: this.appealData.csanotifiedtodirector,
            csaldssnotifieddate: this.appealData.csaldssnotifieddate ? new Date(this.appealData.csaldssnotifieddate) : null,
            csaappealedflag: this.appealData.csaappealedflag,
            csadetails: this.appealData.csadetails,
            csawhoappealed: this.appealData.csawhoappealed,
            csalocationofhearing: this.appealData.csalocationofhearing,
            csajuridiction: this.extractfromCaseNumber(this.appealData.csacasenumber, 'juridiction'),
            csmaltreatmenttypeid: this.appealData.csmaltreatmenttypeid ? this.appealData.csmaltreatmenttypeid : null
        });
    }

    prepareCOAdata() {
        this.appealFormGroup.patchValue({
            coacompileddate:  this.appealData.coacompileddate ? new Date(this.appealData.coacompileddate) : null,
            coacertioraristatus: this.appealData.coacertioraristatus,
            coacertgranteddate: this.appealData.coacertgranteddate ? new Date(this.appealData.coacertgranteddate) : null,
            coacertdenieddate: this.appealData.coacertdenieddate ? new Date(this.appealData.coacertdenieddate) : null,
            coahearingdecisiontypekey: this.appealData.coahearingdecisiontypekey,
            coaldssname: this.appealData.coaldssname,
            coacasenumber: this.appealData.coacasenumber,
            coacasenumberlast8digit: this.extractfromCaseNumber(this.appealData.coacasenumber, 'last_8_digit'),
            coaappellentatrny: this.appealData.coaappellentatrny,
            coahearingdecisiondate: this.appealData.coahearingdecisiondate,
            coacourtdecisionflag: this.appealData.coacourtdecisionflag,
            coaappealedflag: this.appealData.coaappealedflag,
            coadetails: this.appealData.coadetails,
            coalocationofhearing: this.appealData.coalocationofhearing,
            coajuridiction: this.extractfromCaseNumber(this.appealData.coacasenumber, 'juridiction'),
            coamaltreatmenttypeid: this.appealData.coamaltreatmenttypeid ? this.appealData.coamaltreatmenttypeid : null
        });
     }

    validateAppealsFlow() {
        this.enablesc = false;
        this.enableoah = false;
        this.enablecc = false;
        this.enablecsa = false;
        this.enablecoa = false;
        this.setCourtdataValidFlags();
        if (this.courtdataValid.sc) {
            this.enablesc = true;
            this.enableoah = true;
            this.enablecc = this.isUnsubstantiatedFalseTrue();
            this.enablecsa = this.isUnsubstantiatedFalseTrue();
            this.enablecoa = this.isUnsubstantiatedFalseTrue();
            this.showConferenceType = 5;
            this.conferenceTypeTitle = 'SC';
        }
        if (this.courtdataValid.oah) {
            this.enablesc = false;
            this.enableoah = true;
            this.enablecc = true;
            this.enablecsa = this.isUnsubstantiatedFalseTrue();
            this.enablecoa = this.isUnsubstantiatedFalseTrue();
            this.showConferenceType = 1;
            this.conferenceTypeTitle = 'OAH';
        }
        if (this.courtdataValid.cc) {
            this.enablesc = false;
            this.enableoah = false;
            this.enablecc = true;
            this.enablecsa = true;
            this.enablecoa = this.isUnsubstantiatedFalseTrue();
            this.showConferenceType = 2;
            this.conferenceTypeTitle = this.circuitcourt;
        }
        if (this.courtdataValid.csa) {
            this.enablesc = false;
            this.enableoah = false;
            this.enablecc = false;
            this.enablecsa = true;
            this.enablecoa = true;
            this.showConferenceType = 3;
            this.conferenceTypeTitle = 'CSA';
        }
        if (this.courtdataValid.coa) {
            this.enablesc = false;
            this.enableoah = false;
            this.enablecc = false;
            this.enablecsa = false;
            this.enablecoa = true;
            this.showConferenceType = 4;
            this.conferenceTypeTitle = 'COA';
        }
        if (!this.courtdataValid.sc && !this.courtdataValid.oah && !this.courtdataValid.cc && !this.courtdataValid.csa && !this.courtdataValid.coa) {
            this.courtdataValid.oah = this.isUnsubstantiatedFalseTrue();
            this.courtdataValid.sc = this.isUnsubstantiatedTrueFalse();
            this.conferenceTypeTitle = (this.isUnsubstantiated) ? 'SC' : 'OAH';
            this.showConferenceType = (this.isUnsubstantiated) ? 5 : 1;
            this.enablesc = this.isUnsubstantiatedTrueFalse();
            this.enableoah = this.isUnsubstantiatedFalseTrue();
            this.enablecc = this.isUnsubstantiatedFalseTrue();
            this.enablecsa = this.isUnsubstantiatedFalseTrue();
            this.enablecoa = this.isUnsubstantiatedFalseTrue();
        }
        this.prepareOAHdata();
        this.disableformOption();

    }

    isUnsubstantiatedFalseTrue(){
        return this.isUnsubstantiated ? false : true;
    }

    isUnsubstantiatedTrueFalse(){
        return this.isUnsubstantiated ? true : false;
    }

    setCourtdataValidFlags() {
        this.courtdataValid.sc = (this.appealData && this.appealData.scicesentdate) ? true : false;
        this.courtdataValid.oah = (this.appealData && this.appealData.oaicesentdate) ? true : false;
        this.courtdataValid.cc = (this.appealData && this.appealData.cccompileddate) ? true : false;
        this.courtdataValid.csa = (this.appealData && this.appealData.csacompileddate) ? true : false;
        this.courtdataValid.coa = (this.appealData && this.appealData.coacompileddate) ? true : false;
    }

    uploadFile(data: { file: File; category: any; subCategory: any; date: any; }): void {
        const  file: File = data.file;
        const  category = data.category;
        const  subCategory = data.subCategory;
        const  date = data.date;
        if (this.showConferenceType && this.showConferenceType <= 5 && this.showConferenceType >= 1) {


            if (!(file instanceof Array)) {
                return;
            }
            file.map((item, index) => {
                const fileExt = item.name
                    .toLowerCase()
                    .split('.')
                    .pop();
                if (
                    fileExt === 'mp3' ||
                    fileExt === 'ogg' ||
                    fileExt === 'wav' ||
                    fileExt === 'acc' ||
                    fileExt === 'flac' ||
                    fileExt === 'aiff' ||
                    fileExt === 'mp4' ||
                    fileExt === 'mov' ||
                    fileExt === 'avi' ||
                    fileExt === '3gp' ||
                    fileExt === 'wmv' ||
                    fileExt === 'mpeg-4' ||
                    fileExt === 'pdf' ||
                    fileExt === 'txt' ||
                    fileExt === 'docx' ||
                    fileExt === 'doc' ||
                    fileExt === 'xls' ||
                    fileExt === 'xlsx' ||
                    fileExt === 'jpeg' ||
                    fileExt === 'jpg' ||
                    fileExt === 'png' ||
                    fileExt === 'ppt' ||
                    fileExt === 'pptx' ||
                    fileExt === 'gif' ||
                     fileExt === 'cr2' ||
                     fileExt === 'rtf'
                ) {
                    this.uploadedFileUpdate(item, category, subCategory, date, fileExt);
                } else {
                    this._alertService.error(fileExt + ' format can\'t be uploaded');
                }
            });
        } else {
            this._alertService.warn('Please select a appeal type.');
        }
    }
    uploadedFileUpdate(item: any, category: any, subCategory: any, date: any, fileExt: any) {
        const isExist = this.uploadedFile.filter((data: any) => (data === item));
        if (isExist.length === 0) {
            this.uploadedFile.push(item);
        }
        const uindex = this.uploadedFile.length - 1;
        if (!this.uploadedFile[uindex].hasOwnProperty('percentage')) {
            this.uploadedFile[uindex].percentage = 1;
        }
        this.uploadAttachment(uindex, true, category, subCategory, date);
        const audio_ext = ['mp3', 'ogg', 'wav', 'acc', 'flac', 'aiff'];
        const video_ext = ['mp4', 'avi', 'mov', '3gp', 'wmv', 'mpeg-4'];
        if (audio_ext.indexOf(fileExt) >= 0) {
            this.uploadedFile[uindex].attachmenttypekey = 'Audio';
        } else if (video_ext.indexOf(fileExt) >= 0) {
            this.uploadedFile[uindex].attachmenttypekey = 'Video';
        } else {
            this.uploadedFile[uindex].attachmenttypekey = 'Document';
        }
    }
    downloadFile(s3bucketpathname: any) {
        s3bucketpathname = s3bucketpathname.replace(/,/g, '');
        const downldSrcURL =  '/api' + s3bucketpathname;
        window.open(downldSrcURL, '_blank');
    }
    navigatetoattachements() {
        this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment/attachment-upload']);
    }
    uploadAttachment(index: any,isAutoSave: any,category: any,subCategory: any,date: any) {

        let uploadUrl = '';
        if(category !== ''&& subCategory !== '' && date !== ''){
        uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber+ '&objecttypekey=' + 'investigation';

        this._uploadService
            .upload({
                url: uploadUrl,
                headers: new HttpHeaders().set('ctype', 'file'),
                filesKey: ['file'],
                files: this.uploadedFile[index],
                process: true,
            })
            .subscribe(
                (response: any) => {
                    if (response.status) {
                        this.uploadedFile[index].percentage = response.percent;
                    }
                    if (response.status === 1 && response.data) {
                        this.appealDataDocument(response, subCategory, index, category, date);
                    }

                }, (_err: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.uploadedFile.splice(index, 1);
                }
            );
    }}

    appealDataDocument(response: any, subCategory: any, index: any, category: any, date: any){
        const documentInfo = response.data;
        documentInfo.documentdate = documentInfo.date;
        documentInfo.title = subCategory;
        documentInfo.objecttypekey = 'investigation';
        if (this.showConferenceType === 1) {
            documentInfo.rootobjecttypekey = 'oah';
        } else if (this.showConferenceType === 2) {
            documentInfo.rootobjecttypekey = 'circuitcourt';
        } else if (this.showConferenceType === 3) {
            documentInfo.rootobjecttypekey = 'courtspecial';
        } else if (this.showConferenceType === 4) {
            documentInfo.rootobjecttypekey = 'coa';
        } else if (this.showConferenceType === 5) {
            documentInfo.rootobjecttypekey = 'supervisor';
        } else {
            documentInfo.rootobjecttypekey = '';
        }
        documentInfo.activeflag = 1;
        documentInfo.servicerequestid = null;
        this.uploadedFile[index] = { ...this.uploadedFile[index], ...documentInfo };

        const attachment = Object.assign({
            intakeserviceid: this.id,
            documentattachment: {
                attachmentclassificationsubtypekey: subCategory,
                attachmentclassificationtypekey: category,
                attachmenttypekey: "Document",
                actualdocumentdate: moment(date).toDate()
            },
            attachment: [this.uploadedFile[index]]
        });

        this.appealData.documentprop = (this.appealData && Array.isArray(this.appealData.documentprop)) ? this.appealData.documentprop : [];
        this.appealData.documentprop.push(attachment);
    }

    openAppealDelayPopup(appeal: any) {
       $('#appeal-delay-popup').modal('show');
    }

    confirmDeleteAttachment(attachment: any) {
        this.toDeleteAttachment = attachment;
        this.deleteAttachment();
    }
    deleteAttachment() {
        this.uploadedFile = this.uploadedFile.filter(data => data.documentpropertiesid !== this.toDeleteAttachment.documentpropertiesid);
       $('#delete-attachment-popup').modal('hide');
    }
    public findInvalidControls(form: FormGroup) {
        const invalid = [];
        const controls = form.controls;
        for (const name in controls) {
            if (controls[name].invalid) {
                invalid.push(name);
            }
        }

        return invalid;
    }

    disableformOption() {
        this.appealFormGroup.enable();
        if (!this.enablesc) {
            this.appealFormGroup.get('scsummarymailed')?.disable();
            this.appealFormGroup.get('scappealedsetdate')?.disable();
            this.appealFormGroup.get('scisappealformsent')?.disable();
            this.appealFormGroup.get('scicesentdate')?.disable();
            this.appealFormGroup.get('scconfheldflag')?.disable();
            this.appealFormGroup.get('scdecisiontypekey')?.disable();
            this.appealFormGroup.get('scconferencedetail')?.disable();
            this.appealFormGroup.get('scconferencedate')?.disable();
            this.appealFormGroup.get('scappealed')?.disable();
            this.appealFormGroup.get('scisappealed')?.disable();
            this.appealFormGroup.get('scappealedby')?.disable();
            this.appealFormGroup.get('scappealeddate')?.disable();
            this.appealFormGroup.get('scmaltreatmenttypeid')?.disable();
        }

        if (!this.enableoah) {
            this.appealFormGroup.get('oahearingdatesetflag')?.disable();
            this.appealFormGroup.get('oanorhearingreason')?.disable();
            this.appealFormGroup.get('oaldssname')?.disable();
            this.appealFormGroup.get('oaappellentatrny')?.disable();
            this.appealFormGroup.get('oalocaldept')?.disable();
            this.appealFormGroup.get('oarunningmotion')?.disable();
            this.appealFormGroup.get('oaicesentdate')?.disable();
            this.appealFormGroup.get('oahearingdate')?.disable();
            this.appealFormGroup.get('oahearingdecision')?.disable();
            this.appealFormGroup.get('oahearingdecisiondate')?.disable();
            this.appealFormGroup.get('oadetails')?.disable();
            this.appealFormGroup.get('oaappealedflag')?.disable();
            this.appealFormGroup.get('oacasenumber')?.disable();
            this.appealFormGroup.get('oacasenumberlast8digit')?.disable();
            this.appealFormGroup.get('oahearingnarrative')?.disable();
            this.appealFormGroup.get('oamodificationsmade')?.disable();
            this.appealFormGroup.get('oarunningmotiondate')?.disable();
            this.appealFormGroup.get('oamaltreatorunnamedflag')?.disable();
            this.appealFormGroup.get('oatranslator')?.disable();
            this.appealFormGroup.get('oahearingheld')?.disable();
            this.appealFormGroup.get('oahearingheldreason')?.disable();
            this.appealFormGroup.get('oalocationofhearing')?.disable();
            this.appealFormGroup.get('oasummarydecisionfiledflag')?.disable();
            this.appealFormGroup.get('oasummarydecisionfileddate')?.disable();
            this.appealFormGroup.get('oajuridiction')?.disable();
            this.appealFormGroup.get('oacompiledwithoah')?.disable();
            this.appealFormGroup.get('oahmaltreatmenttypeid')?.disable();
        }

        if (!this.enablecc) {
            this.appealFormGroup.get('ccldssname')?.disable();
            this.appealFormGroup.get('ccappellentatrny')?.disable();
            this.appealFormGroup.get('ccstayrequestedflag')?.disable();
            this.appealFormGroup.get('ccstaygrantedflag')?.disable();
            this.appealFormGroup.get('ccappealedflag')?.disable();
            this.appealFormGroup.get('cchearingdecisiontypekey')?.disable();
            this.appealFormGroup.get('cchearingdecisiondate')?.disable();
            this.appealFormGroup.get('ccdetails')?.disable();
            this.appealFormGroup.get('cccasenumber')?.disable();
            this.appealFormGroup.get('cccasenumberlast8digit')?.disable();
            this.appealFormGroup.get('cccourtdecisionflag')?.disable();
            this.appealFormGroup.get('cccompileddate')?.disable();
            this.appealFormGroup.get('ccwhoappealed')?.disable();
            this.appealFormGroup.get('ccnotifiedtodirector')?.disable();
            this.appealFormGroup.get('ccldssnotifieddate')?.disable();
            this.appealFormGroup.get('cccicuitcourtkey')?.disable();
            this.appealFormGroup.get('cchearingheld')?.disable();
            this.appealFormGroup.get('cchearingreason')?.disable();
            this.appealFormGroup.get('cclocationofhearing')?.disable();
            this.appealFormGroup.get('ccjuridiction')?.disable();
            this.appealFormGroup.get('ccmaltreatmenttypeid')?.disable();
        }
        if (!this.enablecsa) {
            this.appealFormGroup.get('csaldssname')?.disable();
            this.appealFormGroup.get('csaappellentatrny')?.disable();
            this.appealFormGroup.get('csanotifiedtodirector')?.disable();
            this.appealFormGroup.get('csacertiorari')?.disable();
            this.appealFormGroup.get('csastayrequestedflag')?.disable();
            this.appealFormGroup.get('csastaygrantedflag')?.disable();
            this.appealFormGroup.get('csaappealedflag')?.disable();
            this.appealFormGroup.get('csahearingdecisiontypekey')?.disable();
            this.appealFormGroup.get('csahearingdecisiondate')?.disable();
            this.appealFormGroup.get('csadetails')?.disable();
            this.appealFormGroup.get('csacasenumber')?.disable();
            this.appealFormGroup.get('csacasenumberlast8digit')?.disable();
            this.appealFormGroup.get('csacourtdecisionflag')?.disable();
            this.appealFormGroup.get('csacompileddate')?.disable();
            this.appealFormGroup.get('csawhoappealed')?.disable();
            this.appealFormGroup.get('csaldssnotifieddate')?.disable();
            this.appealFormGroup.get('csaarguementheld')?.disable();
            this.appealFormGroup.get('csaarguementnotheldreason')?.disable();
            this.appealFormGroup.get('csalocationofhearing')?.disable();
            this.appealFormGroup.get('csajuridiction')?.disable();
            this.appealFormGroup.get('csmaltreatmenttypeid')?.disable();
        }
        if (!this.enablecoa) {
            this.appealFormGroup.get('coaldssname')?.disable();
            this.appealFormGroup.get('coaappellentatrny')?.disable();
            this.appealFormGroup.get('coastayreqflag')?.disable();
            this.appealFormGroup.get('coastaygrantedflag')?.disable();
            this.appealFormGroup.get('coaappealedflag')?.disable();
            this.appealFormGroup.get('coahearingdecisiontypekey')?.disable();
            this.appealFormGroup.get('coahearingdecisiondate')?.disable();
            this.appealFormGroup.get('coadetails')?.disable();
            this.appealFormGroup.get('coacase')?.disable();
            this.appealFormGroup.get('coacourtdecisionflag')?.disable();
            this.appealFormGroup.get('coacompileddate')?.disable();
            this.appealFormGroup.get('coacasenumber')?.disable();
            this.appealFormGroup.get('coacasenumberlast8digit')?.disable();
            this.appealFormGroup.get('coacertioraristatus')?.disable();
            this.appealFormGroup.get('coacertgranteddate')?.disable();
            this.appealFormGroup.get('coacertdenieddate')?.disable();
            this.appealFormGroup.get('coalocationofhearing')?.disable();
            this.appealFormGroup.get('coajuridiction')?.disable();
            this.appealFormGroup.get('coamaltreatmenttypeid')?.disable();
        }
    }

    showFinalizeSection() {
        this.showFinalize = true;
    }

    onChangesummaryDecision() {
        this.appealFormGroup.patchValue({'oarunningmotion': null});
        this.appealFormGroup.patchValue({'oasummarydecisionfileddate': null});
    }

    onChangemaltreatorUnnamed(event: any, formControlName: any) {
         if (event.checked) {
             const obj: any = {};
             obj[formControlName] = 'Unnamed';
             this.appealFormGroup.patchValue(obj);
         }
    }

    getInvolvedPersonWithPersonID(victimList: any, maltreatorlist: any) {
         return this._commonHttpService
             .getPagedArrayList(
                 new PaginationRequest({
                     page: 1,
                     limit: 100,
                     method: 'get',
                     where: {
                        intakeserviceid: this.id,
                        victimList: victimList,
                        maltreatorlist: maltreatorlist
                     }
                 }),
                 'People/getAllPersonRelationsForSdm?filter'
                 ).subscribe((response: any) => {
                    if (response && Array.isArray(response) && response.length) {
                        this.victimRelation = response[0].allrelationshipdetails;
                        const requiredRelation = this.victimDetails.length * this.maltreatorDetails.length;
                        if (this.victimRelation && this.victimRelation.length  && this.victimRelation.length >= requiredRelation) {
                           this.maltreatorRelationSet = true;
                        } else {
                            this.maltreatorRelationSet = false;
                        }

                   }
                   });
        }


    dispositionHistory() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    where: {
                        servicerequestid: this.id
                    },
                    method: 'get'
                }),
                'Intakeservicerequestdispositioncodes/GetHistory?filter'
            )
            .subscribe(
                (result: any) => {
                    const history = (result.data) ? result.data : [];
                    this.showAppeal = false;
                    if (history && history.length > 0) {
                        const isCompleted = history.find((dispo: any) => (dispo.dispstatus === 'Completed') && (dispo.routingstatus === 'Approved'));
                        if (isCompleted) {
                        this.showAppeal = true;
                        }
                    }


                    return result.data;
                }
            );
    }
    
    getAssignmentsList() {
        this._commonHttpService.getArrayList(
            {
                where: { servicecaseid: this.id },
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Consent.GetAssignments
        ).subscribe(data => {
            if (data) {
                const checkAccessList = data.filter((item: any) =>
                    item.enddate === null || moment(item.enddate) >= moment(new Date())
                );

                if (checkAccessList && checkAccessList.length > 0) {
                    checkAccessList.forEach((element: any) => {
                        const familyAssignmentWorker = element.toworkerdetails.filter((a: any) =>
                            a.securityusersid === this._authService.getCurrentUser().user.securityusersid
                        );

                        if (familyAssignmentWorker && familyAssignmentWorker.length > 0) {
                            this.hasAccessToCase = true;
                            return;
                        }
                    });
                } else {
                    this.hasAccessToCase = false;
                    this.isNotReadonly = false;
                    this.expungementForm.disable();
                }
            }
        });
    }

    getReviewStatus(formControl: any) {
        const investigationfindingid =  formControl.get('investigationfindingid')?.value ?  formControl.get('investigationfindingid')?.value  : null;
        if ( this.ReviewStatus && this.ReviewStatus[investigationfindingid] ) {
            return this.ReviewStatus[investigationfindingid];
        }
    }

    setReviewStatus(investigationfindingid: any) {

            this._commonHttpService.getSingle(
                    {
                      count: -1,
                      limit: 10,
                      page: 1,
                      method: 'get',
                      where: { investigationfindingid: investigationfindingid}
                    }
                    , 'expungement/getexpungement?filter').subscribe((res: any) => {
                    if (res && res.length && res[0].getexpungement && res[0].getexpungement.expungement && res[0].getexpungement.expungement.length) {
                        const length = res[0].getexpungement.expungement.length;
                        const expungement = res[0].getexpungement.expungement[length - 1];
                        this.ReviewStatus[investigationfindingid] = expungement.status;
                    }

                });

    }
    resetExpungementValues() {
        this.expungementForm.reset();
        this.approvalStatus = null;
        this.investigationfindingid = null;
        this.isExpungementExist = false;
        this.expungementForm.enable();
        this.showExpungement = false;
    }
    loadExpungement(formControl: any) {
        this.resetExpungementValues();
        const intakeservicerequestactorid: any = formControl.get('intakeservicerequestactorid')?.value ? formControl.get('intakeservicerequestactorid')?.value : null;
        const maltreatmentkey1: any = formControl.get('maltreatmentkey1')?.value ?  formControl.get('maltreatmentkey1')?.value  : null;
        const maltreatmentkey2: any = formControl.get('maltreatmentkey2')?.value ?  formControl.get('maltreatmentkey2')?.value  : null;
        const maltreatmentkey3: any = formControl.get('maltreatmentkey3')?.value ?  formControl.get('maltreatmentkey3')?.value  : null;
        const investigationfindingid: any =  formControl.get('investigationfindingid')?.value ?  formControl.get('investigationfindingid')?.value  : null;
        const maltreatmentid: any =  formControl.get('maltreatmentid')?.value ?  formControl.get('maltreatmentid')?.value  : null;
        const maltreatmentType =  formControl.get('name')?.value ?  formControl.get('name')?.value  : null;
        // CIDM-10864: B-226710 - Temporary Suspension of CJAMS Daily Expungement Batch
         if(maltreatmentType == 'Sexual Abuse') {
             this.isNotReadonly = false;
             this.expungementForm.disable();
         }

        this.expungementForm.patchValue({investigationfinding: maltreatmentkey1});
        this.expungementForm.patchValue({appealfinding: maltreatmentkey2});
        this.expungementForm.patchValue({finalfinding: maltreatmentkey3});
        this.expungementForm.patchValue({ maltreatmentid: maltreatmentid});
        this.expungementForm.patchValue({ investigationfindingid: investigationfindingid});
        this.expungementForm.patchValue({ intakeservicerequestactorid: intakeservicerequestactorid});

        if (investigationfindingid) {
            this.investigationfindingid = investigationfindingid;
            this.getExpungement(investigationfindingid);
        } else {
            this.expungmentMessage = 'Cannot Expunge as the Investigation is not completed.';
           $('#expunge-alert').modal('show');
            return;
        }

        this.showExpungement = true;
        this.setAllegedMaltreator(formControl);
        this.currentExpungement = this.expungementForm.getRawValue();

    }
    setAllegedMaltreator(formControl: any) {
        if (formControl.get('expungementflag')?.value && formControl.get('expungementflag')?.value !== '' && (
            (formControl.get('isunsubstansiated')?.value && formControl.get('isunsubstansiated')?.value !== '') ||
            (formControl.get('isindicated')?.value && formControl.get('isindicated')?.value !== '') ||
            (formControl.get('isremovemaltreator')?.value && formControl.get('isremovemaltreator')?.value !== '') ||
            (formControl.get('isremoverofindings')?.value && formControl.get('isremoverofindings')?.value !== ''))) {
            this.allegedMaltreator = 'Unnamed';
        } else if (formControl.get('allegation')?.value && formControl.get('allegation')?.value.length && formControl.get('allegation')?.value[0]) {
            this.allegedMaltreator = formControl.get('allegation')?.value[0];
        } else {
            this.allegedMaltreator = '';
        }
    }
    
    getElapedYears(reportedDate: any) {
        if (reportedDate) {
        const reportedDateFormatted = new Date(reportedDate);
        const yearsDiff = Date.now() - reportedDateFormatted.getTime();
        const date = new Date(yearsDiff); // miliseconds from epoch
        return Math.abs(date.getUTCFullYear() - 1970);
        } else {
            return null;
        }
    }

    investigationFindingDesc(id: any) {
        if (id && this.investigationFindingDropDown && this.investigationFindingDropDown.length) {
            const finding = this.investigationFindingDropDown.filter(item => item.investigationfindingtypekey === id);
            if (finding && finding.length) {
                return finding[0].description;
            }
        } else {
            return null;
        }
    }
    resetExpungement() {
        this.showExpungement  = false;
        this.expungementForm.enable();
        this.expungementForm.reset();
    }

    resetExpungementForm() {
        this.expungementForm.enable();
        this.expungementForm.patchValue({expungementStatus : null});
        this.expungementForm.patchValue({donotexpunge: null});
        this.expungementForm.patchValue({manualexpunge: null});
        this.expungementForm.patchValue({resultoflawenforcement: null});
        this.expungementForm.patchValue({investigationnarrative: null});
    }

    getExpungement(investigationId: any) {

        this._commonHttpService.getSingle(
            {
                count: -1,
                limit: 10,
                page: 1,
                method: 'get',
                where: { investigationfindingid: investigationId }
            }
            , 'expungement/getexpungement?filter').subscribe((res: any) => {
                if (res && res.length && res[0].getexpungement) {
                    this.canExpungeRuledOut = res[0].getexpungement.canexpungerouledout===1?true:false;
                    if(res[0].getexpungement.expungement && res[0].getexpungement.expungement.length){
                        this.checkExpungement(res);
                    }
                } else {
                    this.approvalStatus = 'No Data';
                }

            });

    }
    checkExpungement(res: any) {
        const length = res[0].getexpungement.expungement.length;
        const expungement = res[0].getexpungement.expungement[length - 1];
        if (expungement && expungement.status && expungement.status !== 'Review') {
            this.approvalStatus = expungement.status;
        }
        if (expungement && expungement.expungementid) {
            this.checkPrevExpngStatus(expungement);
            this.expungementForm.patchValue(expungement);

            this.investigation.forEach(element => {
                const invdtl: any = element;
                if (invdtl.expungements !== null && invdtl.expungements.length > 0) {
                    invdtl.expungements.map((item: { expungementid: any; fullname: any; }) => {
                        if (item.expungementid === this.expungementForm.getRawValue().expungementid) {
                            this.expungementForm.patchValue({ fullname: item.fullname })
                        }
                    })
                }
            })
            this.isExpungementExist = true;
        }
    }

    checkPrevExpngStatus(expungement: { isunsubstansiated: any; isindicated: any; isremovemaltreator: any; isremoverofindings: any; }) {
        const isunsubstansiated = expungement.isunsubstansiated;
        const isindicated = expungement.isindicated;
        const isremovemaltreator = expungement.isremovemaltreator;
        const isremoverofindings = expungement.isremoverofindings;
        let expungementStatus = null;
        if (isunsubstansiated) {
            expungementStatus = 'isunsubstansiated';
        } else if (isindicated) {
            expungementStatus = 'isindicated';
        } else if (isremovemaltreator) {
            expungementStatus = 'isremovemaltreator';
        } else if (isremoverofindings) {
            expungementStatus = 'isremoverofindings';
        }
        this.previousExpungementStatus = expungementStatus;
        this.expungementForm.patchValue({ expungementStatus: expungementStatus });
    }

    confirmExpungement(isAutoSave?: any) {
        const expungementStatus =  this.expungementForm.getRawValue().expungementStatus;
        this.isExpungementExist = true;
        const finalfinding = this.expungementForm.getRawValue().finalfinding;
        const intakeservicerequestactorid = this.expungementForm.getRawValue().intakeservicerequestactorid;
        const finalFindingValue = finalfinding;
        this.expungementForm.patchValue({intakeservicerequestactorid : intakeservicerequestactorid});
        this.expungementForm.patchValue({ intakeserviceid: this.id});
        this.expungementForm.patchValue({ investigationfindingid : this.investigationfindingid});
        this.expungementForm.patchValue({finalfinding: finalFindingValue});
        switch (expungementStatus) {
            case 'isunsubstansiated' :
                                      this.expungementForm.patchValue({isunsubstansiated: true});
                                      this.expungementForm.patchValue({finalfinding: 'UD'});
                                      break;
            case 'isindicated' :
                                      this.expungementForm.patchValue({isindicated: true});
                                      this.expungementForm.patchValue({finalfinding: 'ID'});
                                      break;
            case 'isremovemaltreator' :
                                      this.expungementForm.patchValue({isremovemaltreator: true});
                                      break;
            case 'isremoverofindings' :
                                      this.expungementForm.patchValue({isremoverofindings: true});
                                      break;
            default:
                   break;
        }
        const expungeFormData = this.expungementForm.getRawValue();
        if(expungeFormData.donotexpunge === false && !expungeFormData.justification) {
            this._alertService.error('Justification is mandatory!');
            return;
        }

        if (this.expungementForm.valid) {
            this._commonHttpService.create(expungeFormData, 'expungement/addupdate').subscribe(
                (_result: any) => {
                    if(!isAutoSave){
                    this.isExpungementAuoSaveFlag = false;
                    this._alertService.success('Expungement saved successfully!');
                    }
                    else{
                    this.lastUpdatedTime = moment().format(this.dtformat);
                    this.isExpungementAuoSaveFlag = true;
                    this._alertService.success('Expungement Auto Saved successfully! Please continue typing and click \'SAVE\' to complete.');
                    }
                    if (this.investigationfindingid) {
                        this.getExpungement(this.investigationfindingid);
                    }
                    this.currentExpungement = this.expungementForm.getRawValue();
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.isExpungementExist = false;
                }
            );
        } else {
            this._alertService.error('Please select atleast one Radio Button to enable auto save.');
        }
    }

    onChangeExpungementStatus() {
        const expungementStatus =  this.expungementForm.getRawValue().expungementStatus;
        if (expungementStatus) {
        this.expungementForm.patchValue({ 'donotexpunge' : null});
       $(this.expungementalertpopupid).modal('show');
        this.expungementStatusStep = 1;
        }
        this.unsubstantiatedPopUp = false;
        this.indicatedPopUp = false;
        this.removeMaltreatorPopUp = false;
        this.removeROFindingsPopUp = false;
        this.doNotExpungePopUp = false;
        switch(expungementStatus){
            case 'isunsubstansiated':
                this.unsubstantiatedPopUp = true;
                break;
            case 'isindicated':
                this.indicatedPopUp = true;
                break;
            case 'isremovemaltreator':
                this.removeMaltreatorPopUp = true;
                break;
            case 'isremoverofindings':
                this.removeROFindingsPopUp = true;
                break;
            default:
                break;
        }

    }

    onDoNotExpunge(modal: any){
        this.unsubstantiatedPopUp = false;
        this.indicatedPopUp = false;
        this.removeMaltreatorPopUp = false;
        this.removeROFindingsPopUp = false;
        this.doNotExpungePopUp = false;
        this.expungementStatusStep = 0;
        if(this.expungementForm.getRawValue().donotexpunge){
            this.doNotExpungePopUp = true;
           $(this.expungementalertpopupid).modal('show');
            this.expungementStatusStep = 1;
        }
        else{
       $(this.expungementalertpopupid).modal('hide');
        }
        if(!modal.checked && this.expungementForm.getRawValue().expungementid === null) {
            this.expungementForm.patchValue({donotexpunge: null})
        }

        if(modal.checked) {
            this.expungementForm.patchValue({justification: null})
        }
    }

    resetExpungementStatus(){
        this.expungementStatusStep = 0;
       $(this.expungementalertpopupid).modal('hide');
        if(this.doNotExpungePopUp){
            this.expungementForm.patchValue({ 'donotexpunge' : null});
        } else{
            this.expungementForm.patchValue({ 'expungementStatus' : null});
        }
    }

    acceptedExpungementStatusPopUp(){
        if (this.expungementStatusStep === 2 && (this.removeMaltreatorPopUp || this.doNotExpungePopUp)){
            this.hideAlertPopup();
        }
        else if((this.unsubstantiatedPopUp || this.indicatedPopUp) && this.expungementStatusStep === 4){
            this.hideAlertPopup();
        }
        else if (this.removeROFindingsPopUp){
            if (this.canExpungeRuledOut && this.expungementStatusStep === 4) {
                this.hideAlertPopup();
            }
            else if (!this.canExpungeRuledOut && this.expungementStatusStep === 3) {
                this.hideAlertPopup();
                this.expungementForm.patchValue({ 'expungementStatus': null });
            }
            else{
                this.expungementStatusStep++;
            }
        }
        else {
            this.expungementStatusStep++;
        }
    }

    hideAlertPopup(){
        this.expungementStatusStep = 0;
       $(this.expungementalertpopupid).modal('hide')
    }

    manualExpungementCheckChange(){
        if (this.expungementForm.getRawValue().manualexpunge) {
           $('#manual-expungement-alert').modal('show');
        }
    }

    resetManualExpungementCheck(){
        this.expungementForm.patchValue({ 'manualexpunge' : null});
    }

    ngOnDestroy() {
        this._speechRecognitionService.destroySpeechObject();
        clearInterval(this._dataStoreService.getData('investigationFindingsTimer'));
    }

    activateSpeechToText(type: any): void {
        this.recognizing = type;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                (value: any) => {
                    this.speechData = value;
                    switch (type) {
                        case 'resultoflawenforcement':
                          const resultoflawenforcement = this.expungementForm.getRawValue().resultoflawenforcement;
                          this.expungementForm.patchValue({ resultoflawenforcement: resultoflawenforcement + ' ' + this.speechData });
                          break;
                        case 'investigationnarrative':
                          const investigationnarrative = this.expungementForm.getRawValue().investigationnarrative;
                          this.expungementForm.patchValue({ investigationnarrative: investigationnarrative + ' ' + this.speechData });
                          break;

                        default: break;
                      }

                },
                (err: any) => {
                    this.recognizing = '';
                    if (err.error === 'no-speech') {
                        this.notification = `No speech has been detected. Please try again.`;
                        this._alertService.warn(this.notification);
                        this.activateSpeechToText(type);
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

                    this.activateSpeechToText(type);
                }
            );
        } else {
            this.recognizing = '';
            this.deActivateSpeechRecognition();
        }
    }
    deActivateSpeechRecognition() {
        this.speechRecogninitionOn = false;
        this._speechRecognitionService.destroySpeechObject();
    }

    routingUpdate(status: any) {
        const objId = this._session.getItem('Expungement_Obj_ID');
        const comment = 'Expungment ' + status + ' Sucessfully';
        const routingObject = {
            objectid: objId ? objId : null,
            eventcode: 'EXPR',
            status: status,
            comments: comment,
            notifymsg: comment,
            routeddescription: comment
        };
        this.approvalStatus = status;
        this._commonHttpService.create(routingObject, 'routing/routingupdate').subscribe((_res: any) => {
            this._alertService.success( 'Expungment ' + status + ' Sucessfully');
            if (this.investigationfindingid) {
                this.setReviewStatus(this.investigationfindingid);
            }
        }, (error: any) => {
            console.error(error);
        });
    }
    changeSupervisor($event: any) {

        if ($event && $event.value) {
            this._commonHttpService.create({
                appeventcode: 'INVT',
                objectid: this.id,
                fromuserid: $event.value
            }, 'routing/changereviewer')
                .subscribe();

        }

    }

    onOAHearingHeldChange() {
        this.appealFormGroup.patchValue({ oahearingheldreason : null});
    }

    onOAMotionValueChange() {
        this.appealFormGroup.patchValue({ oarunningmotiondate : null});
    }

    onCOAChangeCertiorariStatus() {
        this.appealFormGroup.patchValue({ coacertgranteddate : null});
        this.appealFormGroup.patchValue({ coacertdenieddate : null});
    }

    onCCHearingHeldCHange() {
        this.appealFormGroup.patchValue({ cchearingheldreason : null});
    }

    onChangeCSAArguementHeld() {
        this.appealFormGroup.patchValue({ csaarguementnotheldreason : null});
    }

    hideModalFooter() {
        this.modelFooterHidden = true;
    }
    showModalFooter(){
        this.modelFooterHidden = false;
    }

    getAllegationName(allegationid: any) {
        if(this.maltreatmentAllegationList) {
            return (this.maltreatmentAllegationList.find((item: { allegationid: any; }) => item.allegationid === allegationid)).name;
        } else {
            setTimeout(()=>{
                return (this.maltreatmentAllegationList.find((item: { allegationid: any; }) => item.allegationid === allegationid)).name;
            }, 3000);
        }
    }

    setMaltreatmentTypeAudit() {
        this.maltreatmentTypeAuditList = [];
        this.investigationAllegationList.map((item: { investigationallegationid: any; investigationallegation_audit: any; }) => {
            this.maltreatmentTypeAuditList.push({
                id : item.investigationallegationid,
                data : item.investigationallegation_audit ? item.investigationallegation_audit : []
            })
        })
    }

    getMaltreatmentTypeAudit(maltreatmentallegationid: any) {
        const lst = this.maltreatmentTypeAuditList.find((item: { id: any; }) => item.id === maltreatmentallegationid)
        return lst.data;
    }

loadExpungementJustificationDropDown() {
    this.expungeJustificationList$ = this._commonHttpService.getArrayList({
        nolimit: true,
        where: { referencetypeid: 5000},
        method: 'get'
      }, 'referencevalues?filter').pipe(map((result: any) => {
        return result;
    }));
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
            .subscribe((item: any) => {
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
            .subscribe((item: any) => {
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
            .subscribe((item: any) => {
                this.forResonNotProvided_list = item;
            });

    }

    emergncyStiuation_enable = false;
    forResonNotProvided_enable = false
    notes_enable = false;
    legislativeReq_Change(){
      if(this.reviewCheckListForm.value.legislativeReq == 'EMEPRE') {
        this.emergncyStiuation_enable = true;
      }
      else{
        this.emergncyStiuation_enable = false;
      }
      if(this.reviewCheckListForm.value.legislativeReq == 'FRARNP') {
        this.forResonNotProvided_enable = true;
      }
      else{
        this.forResonNotProvided_enable = false;
      }
      if(this.reviewCheckListForm.value.legislativeReq == 'DAEERR') {
        this.notes_enable = true;
      }
      else{
        this.notes_enable = false;
      }
    }

    caseclosure: boolean = false;
    caseclosureuntimely(persons: any) {
        this.caseclosure = false;
            const _persons: any[] = [];
            persons?.forEach((p: { roles: any; personid: any; }) => {
                    p?.roles?.forEach((r: any) => {
                        if(this.returnPersonsCondFn(_persons, p, r)
                            ) {
                        _persons.push(p.personid);
                        }
                });
            });
            if(_persons?.length > 0) {
                this._commonHttpService.getArrayList(
                  {
                      where: { v_entitytypeid: this.intakeserviceid },
                      method: 'get'
                  },
                  CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetCaseClosureRecordings + '?filter'
                ).subscribe ((result : any)=>{
                    result?.forEach((r: any) => {
                        if(!this.caseclosure) {
                            this.handleIfNotCaseclosureFn(r, _persons);
                        }
                    });
                });
            }
    }
    // Assosiated with caseclosureuntimely method
    private handleIfNotCaseclosureFn(r: any, _persons: any[]) {
        const _recordings: any[] = [];
        r?.contactparticipant?.forEach((p: { personid: any; }) => {
            if (!_recordings.includes(p.personid)) {
                _recordings.push(p.personid);
            }
        });
        if (_persons.every(r1 => _recordings.includes(r1))) {
            this.caseclosure = true;
        }
    }
    // Assosiated with caseclosureuntimely method
    private returnPersonsCondFn(_persons: any[], p: any, r: any) {
        return (!_persons.includes(p.personid) &&
            ['ICC', 'AV'].includes(r?.intakeservicerequestpersontypekey) ||
            ((p?.ishousehold === 1) && ((r?.intakeservicerequestpersontypekey === 'CHILD') ||
                ((r?.intakeservicerequestpersontypekey === 'OTHERCHILD') &&
                    (JSON.parse(JSON.stringify(p?.dangerous[0]))?.initialresponse !== 0)))));
    }

    get allegedPersonArray() {
        const control = this.investigationFindingForm.get('allegedperson');
        return control instanceof FormArray ? control.controls : [];
    }

    get investigationFindingFormListControls() {
        return (this.investigationFindingForm.get('allegedperson') as FormArray)?.controls ?? [];
    }

    onChangeCOACertiorariStatus() {
        // No data or function to call
    }

    isRecognizing(value: any): boolean {
        return this.recognizing === value;
      }
    
    get isInitialFaceToFaceEnabled(): boolean {
        return this.reviewCheckListForm?.controls?.initalfacetoface?.value === true && this.caseclosure;
    }
}
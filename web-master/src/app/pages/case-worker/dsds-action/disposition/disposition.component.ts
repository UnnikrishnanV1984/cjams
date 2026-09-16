
import {EMPTY,  forkJoin,  Observable} from 'rxjs';

import {map, tap} from 'rxjs/operators';
import { DispositionAddModal, InvestigationSummary, General, ChildRemoval } from './_entities/disposition.data.models';
import { GenericService } from './../../../../@core/services/generic.service';
import { DataStoreService } from './../../../../@core/services/data-store.service';
import { CaseWorkerUrlConfig } from './../../case-worker-url.config';
import { Component, OnInit, AfterViewInit, ViewChild, Injector, ChangeDetectorRef } from '@angular/core';
import { Validators, FormBuilder, FormGroup, ValidatorFn, AbstractControl, ValidationErrors, FormArray  } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import jsPDF from 'jspdf';
import moment from 'moment';

import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService } from '../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { PaginationInfo, DropdownModel } from './../../../../@core/entities/common.entities';
import { CaseWorkerHistory, Assessment, DSDSActionSummary, ReportSummary } from './../../_entities/caseworker.data.model';
import { AuthService } from '../../../../@core/services/auth.service';
import { MyNewintakeConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { SessionStorageService } from '../../../../@core/services/storage.service';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { IntakeStoreConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { Narrative, IntakeCommunication, CpsDocInput } from '../../../newintake/my-newintake/_entities/newintakeModel';
import { AppConstants } from '../../../../@core/common/constants';
import { ValidationService } from '../../../../@core/services';
import { isCaseUuid, ObjectUtils } from '../../../../@core/common/initializer';
import { CpsDocLetterComponent } from '../../../newintake/my-newintake/intake-document-creator/cps-doc-letter/cps-doc-letter.component';
// import html2canvas from 'html2canvas';
import { MatTableDataSource } from '@angular/material/table';
import { CheckList } from '../investigation-findings/_entities/investigation-finding-data.models';
import { GlobalPopupComponent } from '../../../../shared/shared-components/global-popup/global-popup.component';
import { Html2CanvasService } from '../../../../@core/services/html2canvas.service';
import { DispositionResolverService } from './disposition-resolver.service';

declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'disposition',
    templateUrl: './disposition.component.html',
    styleUrls: ['./disposition.component.scss'],
    standalone: false
})
export class DispositionComponent implements OnInit, AfterViewInit {
    @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent;
    daNumber: number;
    dsdsActionsSummary = new DSDSActionSummary();
    id: string;
    dispositionFormGroup!: FormGroup;
    dispositionReopenFormGroup!: FormGroup;
    reopenRequestFormGroup!: FormGroup;
    reviewCheckListForm!: FormGroup;
    getHistory$!: Observable<CaseWorkerHistory[]>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    statusDropdownItems$!: Observable<DropdownModel[]>;
    programTypeDropdownItems$!: Observable<DropdownModel[]>;
    reopenServiceCaseTypes$!: Observable<DropdownModel[]>;
    statusDropdownItems: any[] = [];
    intakeCommunication: IntakeCommunication[] = [];
    isHeadoHouseholdCheckForKinship = false;
    cpsdocData: CpsDocInput = new CpsDocInput();
    closeCaseDropdownItems$!: Observable<DropdownModel[]>;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    programCodeItems$!: Observable<DropdownModel[]>;
    formalSupport$!: Observable<DropdownModel[]>;
    dispositionDropdownItems!: DropdownModel[];
    programCodeDescription: string[] = [];
    programCodeSelection: any[] = [];
    dispositionStatus: any;
    adultManditory = false;
    requestForService = false;
    disableCPSIntakeReport = false;
    careHomeApplication = false;
    private daType: string;
    private daSubTypeId: string;
    isDjs = false;
    isCW = false;
    showProgramCode = false;
    enableAdultDisposition = false;
    isDefaultsLoaded = false;
    showFamilySupport = false;
    disableConfirmClosureButton = false;
    isSupervisor!: boolean;
    roleId!: AppUser;
    approvalStatusForm!: FormGroup;
    isAS = false;
    dsdsActionSummary: DSDSActionSummary = new DSDSActionSummary();
    currentDate = new Date();
    investigationSummary!: InvestigationSummary;
    generalSummary!: General;
    assessmentSummary: Assessment[] = [];
    childRemovalSummary: ChildRemoval[] = [];
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    isServiceCase!: string;
    mifraRequiredorNot: boolean = false;
    isArCase!: boolean;
    isProgramingType!: boolean;
    disporitioncode: string[] = [];
    checklistItems: any[] = [];
    caregiversInCase!: string;
    personIDcheck!: string;
    isChildOrNotCheck = false;
    CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
    allChecked!: boolean;
    selectedDisposition: any;
    numberofChildren: boolean = false;
    selectedStatus: any;
    approvalDispositionId: any;
    intakedata: any[] = [];
    intakeflag= false;
    reviewStatus: any;
    countyAddress: any;
    countyid: any;
    county: any;
    emailForm!: FormGroup;
    daSubType!: string;
    ARSummaryApproved!: boolean;
    supervisorsList: any[] = [];
    childRemovalList: any[] = [];
    isAppealWorker!: boolean;
    isClosed = false;
    isAdoptionCase!: boolean;
    vendorlist: any;
    agencylist: any;
    moduleview: any;
    selectedNotes: any;
    children: any[] = [];
    serviceprogramkey: any[] = [];
    teamList: Array<any> = [];
    caseWorkerList: any;
    teamtypekey!: string;
    userInfo!: AppUser;
    disableReopenCaseBtn: boolean = false;
    isActiontype: boolean = false;
    onlyOnePersonCheck: boolean = false;
    reopenServiceCaseTypesList: any;
    currentDispositionId: any;
    casedetailsobj: any = {caseNumber: "",
    servicecaseid: "",
    serviceCase: [],
    caseDate: ""
    };
    isChildNotDead = true;
    isIVEApprovalNeeded : boolean = false;
    @ViewChild(CpsDocLetterComponent)
    cpsDoc!: CpsDocLetterComponent;
    actionType_: any = false;
    isface2face: boolean = false;
    isReadonly!: boolean;
    restrictAccesstoIVEusers: boolean = true;
    isReview: boolean = false;
    ccrData: Array<any> = [];
    isEBPreferralmade: boolean = false;
    
    routingstatus = '"routingstatus":"Review"';
    closecase = 'Close Case';
    gettypesurl = 'referencetype/gettypes?filter';
    closerchecklistpopupid = '#closer-checklist';
    statusdispositionpopupid = '#status-disposition';
    reopensubmissionopoupid = '#reopen-submission';
    dispositionapproved = 'Disposition Approved';
    dispositionrejected = 'Disposition Rejected';
    investigationfindingspopupid = '#checklist-investigation-findings-review';
    displayorder = 'displayorder ASC';
    refgettypesurl ='referencetype/gettypes';
    personList: any[] = [];
    personlistforservicelog:any[] = [];
    childVictimList:any[] = [];
    involvedPersons: any;
    safeCDisplayedColumns: string[] = ['name']; 
    mfiraDisplayedColumns: string[] = ['name'];

    ischildfatality = false;
    isseriousphysicalinjury = false;
    ismaltreatment = false;
    form1080cData: any = [];
    intakesdmproviderlength : any;

    form1080aDataSource!: MatTableDataSource<string>;
    form1080bDataSource!: MatTableDataSource<string>;
    form1080cDataSource!: MatTableDataSource<string>;
    reviewCheckList: CheckList[] = [];
    form1080Columns: string[] = ['name'];

    private formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _dispositionAddService: GenericService<DispositionAddModal>;
    private _dataStoreService: DataStoreService;
    public _authService: AuthService;
    private storage: SessionStorageService;
    private html2canvas:Html2CanvasService;
    private _reportSummaryService: GenericService<ReportSummary>;
    private cdr: ChangeDetectorRef;
    safeCDataSource!: MatTableDataSource<string>;
    mfiraDataSource!: MatTableDataSource<string>;
    form1080AFlag : any;
    form1080BFlag : any;
    form1080CFlag : any;
    isSenChildExists: boolean = false;
    senuntimelyreasonslist: any;
    senUntimelyForm: FormGroup = new FormGroup({});
    facetofacelist: any;
    safeclist: any;
    mfiralist: any;
    showsenuntimelysection: boolean = false;
    sdmDetails: any = {};
    iscaseexpunged: any = 0;
    senuntimelydiabled: boolean = false;

    constructor(private injector : Injector, private dispositionResolverService: DispositionResolverService){
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dispositionAddService = this.injector.get<GenericService<DispositionAddModal>>(GenericService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
        this._reportSummaryService = this.injector.get<GenericService<ReportSummary>>(GenericService);
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

        // this.route.data.subscribe(data => {
        //     if (data && data.hasOwnProperty('result')) {
        //         this._authService.setAuthDetail('decision', data.result);
        //     }
        // });
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        const dataStore = this._dataStoreService.getData('dsdsActionsSummary');
        this.daType = dataStore ? dataStore.da_typeid : '';
        this.daSubTypeId = dataStore ? dataStore.da_subtypeid : '';
        this.dsdsActionSummary = dataStore;
    }
    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.dispositionResolverService.getDecision().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('decision', data);
            }
        })
        this.moduleview = this._authService.isModuleAccessable('decision', 'decision');
        this.userInfo = this._authService.getCurrentUser();
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        this.teamtypekey = this._authService.getCurrentUser().role.teamtypekey;
        this.getServicePlans();
        this.isAdoptionCaseCheck();
        this.getSDM();
        this.checklistItems = [
                {
                    id: 15,
                    name: 'No clients have an open program assignment',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 7,
                    name: 'All Placements have been end-dated',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 8,
                    name: 'All Homes Removals have been end-dated',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 9,
                    name: 'All Service Log Records (both agency and Referred) have been end-dated',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 10,
                    name: 'All Adoption/Guardianship Subsidy payments have an end-date that does not exceed the date of case closing',
                    isChecked: false,
                    autofilled: false,
                    show: true
                },
                {
                    id: 17,
                    name: 'All Adoption Subsidy payments have an end-date that does not exceed the date of case closing',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 11,
                    name: 'All Service Log payments have been completed',
                    isChecked: false,
                    autofilled: false,
                    show: true
                },
                {
                    id: 12,
                    name: 'All Placement Validations have been completed',
                    isChecked: true,
                    autofilled: false,
                    show: true
                },
                {
                    id: 16,
                    name: 'All Provider payments have been completed',
                    isChecked: false,
                    autofilled: false,
                    show: true
                },
                {
                    id: 13,
                    name: 'All IV-E eligibility determinations have been completed',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 14,
                    name: 'All Placement changes have Supervisory Approval',
                    isChecked: true,
                    autofilled: true,
                    show: true
                },
                {
                    id: 1,
                    name: 'All open living arrangements have been end-dated for all clients. ',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 2,
                    name: `No clients have an open legal custody record of committed or Co-Committed to DSS, Guardianship to DSS,
         Delinquency, Voluntary Placement Agreement, Shelter Care or Committed to Another State.`,
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 3,
                    name: 'A SAFE-C or SAFE-C OHP has been completed for all applicable children and the assessment has supervisory approval',
                    isChecked: true,
                    autofilled: true,
                    show: true
                },
                {
                    id: 5,
                    name: 'There are no incomplete MFRA’s or MFIRA’s pending supervisory approval',
                    isChecked: true,
                    autofilled: true,
                    show: true
                },
                {
                    id: 4,
                    name: 'All Safety Plans have Supervisory Approval(If applicable)',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 6,
                    name: 'There are no incomplete INFS Progress Reviews or INFS Progress Reviews pending supervisory approval',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 18,
                    name: 'All persons are Confirmed *',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 19,
                    name: 'One case head need to be identified *',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 20,
                    name: 'At least one child need to identified *',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 21,
                    name: 'Every person must have a Living Arrangement ',
                    isChecked: true,
                    autofilled: true,
                    show: true
                },
                {
                    id: 22,
                    name: 'Initial contact with the caregiver was completed *',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id:23,
                    name: 'No Person with "Unknown" Marital Status.',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 24,
                    name: 'All service logs have been completed with an “actual” start/end date.',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 25,
                    name: 'Approved Form 1080 A.',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 26,
                    name: 'Approved Form 1080 B.',
                    isChecked: false,
                    autofilled: true,
                    show: true
                },
                {
                    id: 27,
                    name: 'Approved Form 1080 C.',
                    isChecked: false,
                    autofilled: true,
                    show: true
                }
                 
            ];
        this.loadClosureData();
        this.getTeamList();
        this.initializeDispositionForm();
        this.getAssessments();
        this.getChildRemoval();
        this.getInvolvedPerson();
        this._getCaseDetails();
        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
            this.approvalDispositionId = this.storage.getItem(CASE_STORE_CONSTANTS.DISPOSITIONID_FOR_APPROVAL);
        }
        this.approvalStatusForm = this.formBuilder.group({
            routingstatus: [''],
            comments: [''],
            objid: ['']
        });
        this._dataStoreService.setData(IntakeStoreConstants.communications , this._dataStoreService.getData('da_intakenumber'));
        if(!this.isAdoptionCase) {
            this.populateIntake(this._dataStoreService.getData('da_intakenumber'));
        }
        this.dsdsActionsSummary = this._dataStoreService.getData('dsdsActionsSummary');
        this.isARCase();
        this._dataStoreService.currentStore.subscribe((store) => {
         if (store['dsdsActionsSummary']) {
                this.dsdsActionsSummary = store['dsdsActionsSummary'];
                this.daType = this.dsdsActionsSummary.da_typeid;

                if (!this.isDefaultsLoaded) {
                    this.loadStatuses();
                    this.isDefaultsLoaded = true;
                }
            }
        });
        this.checkDsdsActionsSummary();
        this.isDjs = this._authService.isDJS();
        this.isCW = this._authService.isCW();
        this.isAS = this._authService.isAS();
        this.loadStatuses();
        this.loadSupervisor();
        if (!this.isAS) {
            this.loadCloseCase();
        }
        this.dispositionHistory();
        this.loadCheckListItems();
        this.programType();
        this.loadReopenServiceTypes();
        this.emailForm = this.formBuilder.group({
            email: ['', [ValidationService.mailFormat, Validators.required]]
        });
        this.getCommunicationList();
        this.roleId = this._authService.getCurrentUser();
        this.checkAppealWorker();
        this.setClosedFlag();
        this._authService.readonlyPage('read_only_access', 'caseworker-disposition-add',
        [this.dispositionFormGroup, this.approvalStatusForm, this.emailForm]);
        this.getHistory$.subscribe(data=>{
            if(data?.length > 0 && data[0]?.dispstatus === 'Return to Worker') {
                this.disableReopenCaseBtn = true;
            }
            if (data?.length !== 0 && JSON.stringify(data).includes(this.routingstatus)) { this.isReview = true }
            else { this.isReview = false; }
        });
        this.reopenServiceCaseTypes$.subscribe(data=>{
            this.reopenServiceCaseTypesList = data;
        });
        this._gelegislativetData(); 
        this.setReadOnlyFlag();
        this.getInvolvedPersons();
        
        const caseid = this.getCaseId();
        if (caseid) {
            this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + caseid)
                .subscribe((result: any) => {
                    if (result) {
                        const purpose = result?.intakeservicerequesttype?.description;
                        if(['ROA-CPS', MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL, MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES].includes(purpose) || (purpose === 'Child Protective Services' && this.isServiceCase)) {
                            this.getTrafficking(caseid);
                        }
                    }
                });
        }
        // this.getrohsenuntimelycriteria();

    }
    
    getrohsenuntimelycriteria() {    
        const req = {
            servicecaseid  : this.id,
            inputsource : 'caseclosure'
        }
        this._commonHttpService.create(
            req,
            NewUrlConfig.EndPoint.Intake.Senuntimelyreasoncreteriaupdate /* Separate API invoked for SEN Untimely Report */
        ).subscribe(data => {
            if(data && data.length > 0) {
                this._commonHttpService
                .getArrayList(
                    {
                        where: {
                            servicecaseid  : this.id,
                            objecttype : 'caseclosure'
                        },
                        method: 'get'
                    },
                    NewUrlConfig.EndPoint.Intake.Rohsenuntimelycriteria + '?filter' /* Separate API invoked for SEN Untimely Report */
                ).subscribe(data => {
                    if(data && data.length > 0) {
                        this.senuntimelyreasonslist = data; 
                        this.showsenuntimelysection = true;
                        this.showSenUntimelyPopupAlert(this.senuntimelyreasonslist);
                    }
                });
            }
        });  
    }

    showSenUntimelyPopupAlert(senuntimelylist: any): void {
        this.loadDropDownsAsObservable().subscribe();
        this.senUntimelyForm = this.formBuilder.group({
            childlist: this.formBuilder.array([])
        });
        this.buildSENForm(senuntimelylist);
        this.senuntimelyreasonslist = senuntimelylist;
    }

    buildSENForm(senuntimelylist: any[]) {
        const arr = this.childlist;

        senuntimelylist.forEach(item => {
            arr.push(
            this.formBuilder.group({
                clientname: [item.clientname],
                cjamspid: [item.cjamspid],
                f2fctrl: [{value: !!item.progressnoteid, disabled: true}],
                f2fcontactuntimelydone: [item.f2fcontactuntimelydone],
                f2fcontactuntimelydonereason: [item.f2fcontactuntimelydonereason],
                safecctrl: [{value: !!item.safecassessmentid, disabled: true}],
                safecuntimelydone: [item.safecuntimelydone],
                safecuntimelydonereason: [item.safecuntimelydonereason],
                mfiractrl: [{value: !!item.mfiraassessmentid, disabled: true}],
                mfirauntimelydone: [item.mfirauntimelydone],
                mfirauntimelydonereason: [item.mfirauntimelydonereason],
                otherf2fcomments: [item.otherf2fcomments],
                othersafeccomments: [item.othersafeccomments],
                othermfiracomments: [item.othermfiracomments],
                personid: [item.personid],
                servicecaseid: [item.servicecaseid],
                progressnoteid: [item.progressnoteid],
                safecassessmentid: [item.safecassessmentid],
                mfiraassessmentid: [item.mfiraassessmentid],
                startdate: [item.startdate],
            }, { validators: this.senUntimelyReasonValidator })
            );
        });
    }

    private readonly senUntimelyReasonValidator: ValidatorFn =
            (group: AbstractControl): ValidationErrors | null => {
            const f2fctrl = group.get('f2fctrl')?.value;
            const f2fDone = group.get('f2fcontactuntimelydone')?.value;
            const f2fReason = group.get('f2fcontactuntimelydonereason')?.value;
            const safecctrl = group.get('safecctrl')?.value;
            const safecDone = group.get('safecuntimelydone')?.value;
            const safecReason = group.get('safecuntimelydonereason')?.value;
            const mfiractrl = group.get('mfiractrl')?.value;
            const mfiraDone = group.get('mfirauntimelydone')?.value;
            const mfiraReason = group.get('mfirauntimelydonereason')?.value;  
            if(!f2fctrl || !safecctrl ||  !mfiractrl) {
                this.senuntimelydiabled = true;
            }

            if (f2fctrl && f2fDone && !f2fReason) {
                return {f2fReasonRequired: true };
            }

            if (safecctrl && safecDone && !safecReason) {
                return {safecReasonRequired: true };
            }

            if (mfiractrl && mfiraDone && !mfiraReason) {
                return {mfiraReasonRequired: true };
            }   

        return null;
    };
              

    get childlist(): FormArray {
        return this.senUntimelyForm.get('childlist') as FormArray;
    }

    private loadDropDownsAsObservable(): Observable<any> {
        const displayorder = 'displayorder ASC';
        const referencevaluesurl = 'referencevalues?filter';

        return forkJoin([
            this._commonHttpService.getArrayList({ nolimit: true, where: { referencetypeid: 500801 }, order: displayorder, method: 'get' }, referencevaluesurl),
            this._commonHttpService.getArrayList({ nolimit: true, where: { referencetypeid: 500802 }, order: displayorder, method: 'get' }, referencevaluesurl),
            this._commonHttpService.getArrayList({ nolimit: true, where: { referencetypeid: 500803 }, order: displayorder, method: 'get' }, referencevaluesurl),
        ]).pipe(
            tap(([facetoface, safec, mfira]) => {
            this.facetofacelist = facetoface.sort(this.sortOtherSpecifyLast);
            this.safeclist = safec.sort(this.sortOtherSpecifyLast);
            this.mfiralist = mfira.sort(this.sortOtherSpecifyLast);
            })
        );
    }

    private readonly sortOtherSpecifyLast = (a: { description?: string }, b: { description?: string }): number => {
        const da = String(a?.description ?? '');
        const db = String(b?.description ?? '');
        if (da === 'Other') return 1;
        if (db === 'Other') return -1;
        return da.localeCompare(db);
    };

    hasSenErrors() {
        return this.childlist.controls.some(child => 
            child.hasError('safecReasonRequired') || 
            child.hasError('f2fReasonRequired') || 
            child.hasError('mfiraReasonRequired')
        );     
    }

    saveSenUntimely(){
        const children = this.senUntimelyForm.get('childlist') as FormArray;
        children.controls.forEach((child: any) => {
            const f2fcontactuntimelydonereason = child.get('f2fcontactuntimelydonereason').value;
            const otherf2fcomments = child.get('otherf2fcomments');
            if (f2fcontactuntimelydonereason === 'OTR') {
                otherf2fcomments?.setValidators([Validators.required]);
            } else {
                otherf2fcomments?.clearValidators();
                otherf2fcomments?.setValue(null); 
            }
            otherf2fcomments?.updateValueAndValidity();
            const safecuntimelydonereason = child.get('safecuntimelydonereason').value;
            const othersafeccomments = child.get('othersafeccomments');
            if (safecuntimelydonereason === 'OTR') {
                othersafeccomments?.setValidators([Validators.required]);
            } else {
                othersafeccomments?.clearValidators();
                othersafeccomments?.setValue(null); 
            }
            othersafeccomments?.updateValueAndValidity();
            const mfirauntimelydonereason = child.get('mfirauntimelydonereason').value;
            const othermfiracomments = child.get('othermfiracomments');

            if (mfirauntimelydonereason === 'OTR') {
                othermfiracomments?.setValidators([Validators.required]);
            } else {
                othermfiracomments?.clearValidators();
                othermfiracomments?.setValue(null);
            }
            othermfiracomments?.updateValueAndValidity();
        });
        if(this.senUntimelyForm.invalid){
            return;
        }
        const req = {
            where:{data: this.childlist.getRawValue()}
        }
        this._commonHttpService.create(req, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.addsenuntimelycompletionreason).subscribe(
            (result) => {
               this._alertService.success('Sen Untimely Reasons saved successfully');
            },
            (error) => {
                console.log(GLOBAL_MESSAGES.ERROR_MESSAGE);
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

    isAdoptionCaseCheck(){
        const caseType = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
            this.getAssignmentsList();
            this.getAgreementListing();
        } else {
            this.isAdoptionCase = false;
        }
    }

    isARCase(){
        if (this.dsdsActionSummary) {
            this.daSubType = this.dsdsActionSummary.da_subtype;
            this.getCheckList();
            if (this.daSubType === 'CPS-AR') {
                this.isArCase = true;
                this.checkForARSummaryApproved();
            } else {
                this.isArCase = false;
            }
        }
    }

    checkDsdsActionsSummary(){
        if ((this.dsdsActionsSummary.da_type === 'Maltreatment Intake') && (this._authService.getAgencyName() === 'AS')) {
            this.dispositionFormGroup.get('reviewcomments')?.setValidators([Validators.required]);
            this.dispositionFormGroup.get('closingcodetypekey')?.setValidators([Validators.required]);
            this.dispositionFormGroup.updateValueAndValidity();
            this.adultManditory = true;
        }
        if (this.dsdsActionsSummary.programarea && this.dsdsActionsSummary.programarea.length) {
            this.dsdsActionsSummary.programarea.forEach(element => {
                this.serviceprogramkey.push(element);
            });
        }

        if ((this.dsdsActionsSummary.da_type === 'Request for services' || this.dsdsActionsSummary.da_type === 'Provider') && (this._authService.getAgencyName() === 'CW')) {
            this.disableCPSIntakeReport = true;
        }
        if ((this.dsdsActionsSummary.da_type === 'Request for services' || this.dsdsActionsSummary.da_type === 'Provider') && (this._authService.getAgencyName() === 'AS')) {
            this.dispositionFormGroup.get('reviewcomments')?.setValidators([Validators.required]);
            this.dispositionFormGroup.get('closingcodetypekey')?.setValidators([Validators.required]);
            this.dispositionFormGroup.updateValueAndValidity();
            this.requestForService = true;
        }
    }

    checkAppealWorker() {
        if (this.roleId) {
            const roleName = ObjectUtils.getNestedObject(this.roleId, ['role', 'name']);
            if (roleName === AppConstants.ROLES.APPEAL_USER) {
                this.isAppealWorker = true;
            }
        }
    }

    setClosedFlag() {
        const da_status = this.storage.getItem('da_status');
        const da_status1 = this._dataStoreService.getData('da_status');
        if (da_status || da_status1) {
            if ((da_status === 'Closed' || da_status === 'Completed') || (da_status1 === 'Closed' || da_status1 === 'Completed')) {
                this.isClosed = true;
                this.dispositionFormGroup.disable();
            } else {
                this.isClosed = false;
            }
        }
    }

    setReadOnlyFlag() {
        const activeModuleRole = this.storage.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.isReadonly = false;
        } else if (activeModuleRole == 'IV-E Eligibility Administrator Assistant' || activeModuleRole == 'IV-E Eligibility Analyst' || activeModuleRole == 'IV-E Eligibility Quality Assurance') {
            this.restrictAccesstoIVEusers = false;
        } else {
            this.isReadonly = this._authService.readonlyButton('read_only_access', 'caseworker-disposition-add');
        }
    }
    
    getCommunicationList() {
        const checkInput = {
          nolimit: true,
          where: { teamtypekey: this._authService.getAgencyName() },
          method: 'get',
          order: 'description'
        };
        return this._commonHttpService.getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.IntakeCommunications + '/list?filter').subscribe(data => {
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
                        {label: this.cpsdocData.InputSource || input}
                    );
                }
            });
        }
    }

    getCountyDetails() {
        this._commonHttpService.create({}, 'admin/county/countylist').subscribe(data => {
            if (data) {
                this.intakeflag = true;
                this.countyAddress = data.filter((list: { countyid: any; }) => list.countyid === this.countyid);
                if (this.countyAddress.length > 0) {
                    this.county = this.countyAddress[0].countyname;
                    this._dataStoreService.setData('countyId', this.county);
                }
            }
        });
    }

    fixNarrativeHistoryClearanceText(narr: any) {
            let n: string = narr;
            if (n) {
                n = n.replace(/(\\n)/g, '<br>');
                n = n.replace(/(\\r)/g, '');
            }
            return n;
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
                        iscaseexpunged: this.iscaseexpunged
                    }
                },
                NewUrlConfig.EndPoint.Intake.IntakenapshotReport /* Separate API invoked for Intakereport Report */
            ).subscribe(data => {
                const response = data;
                if (response && response.data && response.data[0]) {
                    this.checkResponse(response);
                } else {
                    this.intakeflag = true;
                }
            });
    }

    checkResponse(response: any) {
        let addedPersons = [];
        const narrativeDetails = new Narrative();
        this.intakeflag = false;
        const intakeModel = response.data[0].jsondata;
        const general = intakeModel.General;
        this.countyid = general.countyid;
        this.getCountyDetails();
        this.countyid = general.countyid;
        addedPersons = intakeModel.persons ? intakeModel.persons : this.getPerson(intakeModel);
        this.reviewStatus = intakeModel.reviewstatus.status;
        if (this.reviewStatus === 'Closed' ||
            this.reviewStatus === 'Approved') {
            narrativeDetails.Firstname = general.Firstname;
            narrativeDetails.Middlename = general.Middlename;
            narrativeDetails.Lastname = general.Lastname;
            narrativeDetails.ZipCode = general.offenselocation;
        } else {
            if (intakeModel.narrative &&
                intakeModel.narrative.length > 0) {
                narrativeDetails.Firstname = intakeModel.narrative[0].Firstname;
                narrativeDetails.Middlename = intakeModel.narrative[0].Middlename;
                narrativeDetails.Lastname = intakeModel.narrative[0].Lastname;
                narrativeDetails.ZipCode = intakeModel.narrative[0].ZipCode;
                narrativeDetails.PhoneNumber = intakeModel.narrative[0].PhoneNumber;
                narrativeDetails.incidentlocation = intakeModel.narrative[0].incidentlocation;
                narrativeDetails.incidentdate = intakeModel.narrative[0].incidentdate;
                narrativeDetails.isapproximate = intakeModel.narrative[0].isapproximat;
                narrativeDetails.email = intakeModel.narrative[0].email;

            }
        }
        if (general.Narrative && general.Narrative != null && general.Narrative !== '') { narrativeDetails.Narrative = this.fixNarrativeHistoryClearanceText(general.Narrative); }
        if (general && general.cpsHistoryClearance && general.cpsHistoryClearance !== null && general.cpsHistoryClearance !== '') {
            narrativeDetails.cpsHistoryClearance = this.fixNarrativeHistoryClearanceText(general.cpsHistoryClearance);
        }
        narrativeDetails.IsAnonymousReporter = this.isAnonymousReporter(general);
        narrativeDetails.IsUnknownReporter = this.isUnknownReporter(general);
        narrativeDetails.RefuseToShareZip = this.refuseToShareZip(general);
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
        this._dataStoreService.setData(IntakeStoreConstants.addNarrative, narrativeDetails);
        this._dataStoreService.setData(IntakeStoreConstants.evalFields, intakeModel.evaluationFields);
    }


    getPerson(intakeModel: { persondetails: { Person: any; }; }){
        return intakeModel.persondetails ? intakeModel.persondetails.Person : [];
    }

    isAnonymousReporter(general: { IsAnonymousReporter: boolean; }){
        return general.IsAnonymousReporter === true ? true : false;
    }

    isUnknownReporter(general: { IsUnknownReporter: boolean; }){
        return general.IsUnknownReporter === true ? true : false;
    }

    refuseToShareZip(general: { RefuseToShareZip: boolean; }){
        return general.RefuseToShareZip === true ? true : false;
    }

      sendEmail () {
        const caseID = this._dataStoreService.getData('da_intakenumber');
        if (this.emailForm.valid) {
            const bodyData = document.getElementById('CPS-Intake-Report');
        const request: any = {
            email : this.emailForm.getRawValue().email,
            caseNumber: caseID,
            body: bodyData?.innerHTML
        };
        this._commonHttpService.create(request, 'Intakeservicerequestpurposes/sendemailcontact').subscribe(
            (_result) => {
                this._alertService.success('Email Sent successfully!');
            }
        );
     } else {
            this._alertService.error('Please enter valid email address!');
        }
    }

      printCasePdf(element: string) {
        $('#intake-cps-doc1').modal('hide');
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

    ngAfterViewInit() {
        const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
        if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
            $(':button').prop('disabled', true);
            $('span').css({'pointer-events': 'none',
                        'cursor': 'default',
                        'opacity': '0.5',
                        'text-decoration': 'none'});
            $('i').css({'pointer-events': 'none',
                                    'cursor': 'default',
                                    'opacity': '0.5',
                                    'text-decoration': 'none'});
            $('th a').css({'pointer-events': 'none',
                                    'cursor': 'default',
                                    'opacity': '0.5',
                                    'text-decoration': 'none'});
        }
    }
    onChangeDispositon(event: any) {
        this.selectedDisposition = this.dispositionDropdownItems.find(item => item.value === event.value);
    }

    loadDispositon(statusId: any, event: any) {
        this.selectedStatus = this.statusDropdownItems.find(item => item.text === event.label);
        if (!this.isAS) {
            this.loadDispositionNonAS(statusId);
        } else {
            this.loadDispositionAS(statusId);
        }
        this.dispositionDropdownItems$.subscribe(data => { this.dispositionDropdownItems = data; });
    }

    loadDispositionNonAS(statusId: string) {
        const statusKey = statusId.split('~')[0];
        this.dispositionDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        statuskey: statusKey, //
                        intakeservreqtypeid: this.daType,
                        servicerequestsubtypeid: this.daSubTypeId
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.DispositionUrl + '?filter'
            ).pipe(
                map((result) => {
                    return result.map(
                        (res) => {
                            return {
                                text: res.description,
                                value: res.servicerequesttypeconfigiddispostionid,
                                code: res.dispositioncode
                            };
                        }
                    ).filter(statusItem => {
                        if (this.isCW && (this.daSubType === 'CPS-IR')) {
                            return this.checkStatus(statusItem);
                        } else if (this.isCW && (this.daSubType === 'CPS-AR' && !this.ARSummaryApproved)) {
                            return this.checkStatus(statusItem);
                        } else {
                            return true;
                        }
                    });
                }));
    }

    checkStatus(statusItem: { text: any; value?: any; code?: any; }){
        if (this.roleId.role.name === AppConstants.ROLES.APPEAL_USER) {
            return (statusItem.text === 'Screen Out') ? true : false;
        } else {
            return (statusItem.text !== this.closecase) ? true : false;
        }
    }

    loadDispositionAS(statusId: string) {
        const statusKey = statusId.split('~')[0];
        if (statusKey === 'Closed') {
            this.getProgramCode();
            this.showProgramCode = true;
        } else {
            this.showProgramCode = false;
        }
        this.dispositionDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        statuskey: statusKey, //
                        intakeservreqtypeid: this.daType,
                        servicerequestsubtypeid: this.daSubTypeId
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.DispositionUrl + '?filter'
            ).pipe(
                map((result) => {
                    if (result && result.length) {
                        result.forEach((item) => {
                            this.disporitioncode[item.servicerequesttypeconfigid] = item.dispositioncode;
                        });
                    }
                    return result.map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.servicerequesttypeconfigid + '~' + res.servicerequesttypeconfigiddispostionid
                            })
                    );
                }));
    }

    showReason(value: string) {
        if (value === 'false') {
            this.showFamilySupport = true;
            this.getFormalSupport();
        } else {
            this.showFamilySupport = false;
        }

    }

    findCaregiverContact(){
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonHttpService
                  .getPagedArrayList(
                      new PaginationRequest({
                          page: null,
                          limit: null,
                          nolimit: true,
                          where: {isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged},
                          method: 'get'
                      }),
                      CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.id + '?data'
                  )
                  .subscribe((result) => {
                      const recording = result.data;
                      let contactparticpants = [];
      
                      recording.forEach(note => {
                        contactparticpants = note.contactparticipant;
                       
                      if (contactparticpants) { 
                        const caregiver = contactparticpants.find((particpant: { personid: string; }) => particpant.personid === this.caregiversInCase);
                        const noCareGiverDetails = contactparticpants.find((particpant: { personid: string; }) => particpant.personid === this.personIDcheck);
                                        
                         if(caregiver){
                            this.checklistItems.forEach(item => {
                                if ((item.id === 22) || (noCareGiverDetails && !this.isChildOrNotCheck)) {
                                    item.isChecked = true ;
                                }
                             });
                        }
                    }
                        
                      });
                  });
      }

    getFormalSupport() {
        this.formalSupport$ = this._commonHttpService
        .getArrayList(
            new PaginationRequest({
                nolimit: true,
                where: {
                    tablename: 'DispostionInformalSupport',
                    teamtypekey: 'AS'
                },
                method: 'get'
            }),
            this.gettypesurl
        ).pipe(
        map((result) => {
            return this.mapDropdownModel(result);
        }));
    }
    openConfirmationPopup() {
        $(this.closerchecklistpopupid).modal('hide');
        $('#confirmation-popup').modal('show');
    }

    confirmDisposition() {
        const disposition: any = this.dispositionDropdownItems.find(item => item.value === this.dispositionFormGroup.value.dispositionid);

        if (this.isCW && (this.isServiceCase || this.isAdoptionCase)) {
            if (disposition.text === this.closecase) {
                this.getrohsenuntimelycriteria();
                $(this.statusdispositionpopupid).modal('hide');
                $(this.closerchecklistpopupid).modal('show');
            } else {
                this.saveDisposition();
            }
        } else {
            this.checkConfirmDisposition(disposition);
        }
    }
    checkConfirmDisposition(disposition: { text: string; }){
        if (disposition.text === this.closecase) {
            if (!this.adultManditory) {
                $(this.statusdispositionpopupid).modal('hide');
                $('#confirm-disposition').modal('show');
            }
            if (this.adultManditory) {
                this._commonHttpService.getSingle({
                    where: {
                        'intakeserviceid': this.id
                    },
                    method: 'get'
                }, 'intakeservicerequestdispositioncodes/taskcloseddisposition?filter').subscribe((result) => {
                    if (result) {
                        this.checkDisposition(result);
                        $(this.statusdispositionpopupid).modal('hide');
                        $('#confirm-disposition-AS').modal('show');
                    }
                });
            }
        } else {
            this.saveDisposition();
        }
    }
    checkDisposition(result: any){
        this.dispositionStatus = result.filter((data: { activitytaskname: string; }) => data.activitytaskname === 'Client Assessment Form (716 A)' || data.activitytaskname === 'Investigation Outcomes Form (716 B)');
        result.map((list: { activitytaskname: string; status: string; }) => {
            if (list.activitytaskname === 'Client Assessment Form (716 A)' || list.activitytaskname === 'Investigation Outcomes Form (716 B)') {
                if (list.status === 'Open') {
                    this.enableAdultDisposition = true;
                }
            }
        });
    }
    cancelConfirmDisposition() {
        $(this.statusdispositionpopupid).modal('show');
    }

    loadClosureData() {
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get',
                    count: -1,
                    where: { 'caseId' : this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.getcaseclosureUrl+'?filter'
            ).subscribe((result) => {
                this.ccrData = result;
                this.loadCheckListItems();
            });
    }
    
    reviewClosure(){
        const dispositionModal = new DispositionAddModal();
        dispositionModal.disposition = Object.assign({
            intakeserviceid: this.id,
            caseid: this.id,
            objecttype:this.isAdoptionCase ? 'adoptioncase' : 'servicecase',
            status: 'CCR_Review',
            casenumber: this.daNumber, //this.casedetailsobj.caseNumber,
            supervisorid: this.dispositionFormGroup.value.supervisorid ? this.dispositionFormGroup.value.supervisorid : '',
            intakeserreqstatustypeid: this.dispositionFormGroup.value.statusid.split('~')[1],
            dispostionid: this.isAS ? this.dispositionFormGroup.value.dispositionid.split('~')[1] : this.dispositionFormGroup.value.dispositionid,
        });
        
        this._dispositionAddService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.caseClosureDispositionUrl;
        this._dispositionAddService.create(dispositionModal).subscribe(
            (response: any) => {
                this._alertService.success('Case Closure Request Sent To IV-E Supervisor Successfully');
                this.loadClosureData();
            },
            (error: any) => {
                this._alertService.error('Error while submiting to supervisor');
            }
        );
    }

    saveDisposition() {
        this.disableConfirmClosureButton =true;
        this.updateChecked();
        if(!this.allChecked) {
            this.disableConfirmClosureButton =false;
            return;
        }        
        const dispositionModal = this.getDispositionModal();
        this._dispositionAddService.create(dispositionModal).subscribe(
            (response: any) => {
                if(this.showsenuntimelysection) {
                    this.saveSenUntimely();
                }
                $('#confirmation-popup').modal('hide');
                this.dispositionFormGroup.reset();
                $(this.statusdispositionpopupid).modal('hide');
                $(this.closerchecklistpopupid).modal('hide');
                this.disableConfirmClosureButton = false;
                if (this.roleId.role.name === AppConstants.ROLES.APPEAL_USER) {
                this.routingUpdate(null);
                }
                this._alertService.success('Disposition updated successfully');
                this.dispositionHistory();
            },
            (error: any) => {
                this.disableConfirmClosureButton = false;
                if (this.isCW && this.isServiceCase && this.allChecked) {
                    this.allChecked = false;
                    this.openConfirmationPopup();
                    this._alertService.success('Disposition updated successfully');
                } else {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            }
        );
    }
    getDispositionModal(){
        const dispositionModal = new DispositionAddModal();
        dispositionModal.disposition = Object.assign({
            intakeserviceid: this.id,
            servicecaseid: this.id,
            supervisorid: this.dispositionFormGroup.value.supervisorid ? this.dispositionFormGroup.value.supervisorid : '',
            intakeserreqstatustypeid: this.dispositionFormGroup.value.statusid.split('~')[1],
            dispostionid: this.isAS ? this.dispositionFormGroup.value.dispositionid.split('~')[1] : this.dispositionFormGroup.value.dispositionid,
            reviewcomments: this.dispositionFormGroup.value.reviewcomments,
            closingcodetypekey: this.dispositionFormGroup.value.closingcodetypekey,
            programcode: this.showProgramCode ? this.programCodeSelection : [],
            issupport: this.showProgramCode ? this.dispositionFormGroup.value.issupport : null,
            supporttypekey: this.showFamilySupport ? this.dispositionFormGroup.value.supporttypekey : null,
            dateseen: new Date()
        });
        dispositionModal.investigation = {
            summary: '',
            filelocdesc: null,
            appevent: 'INVR'
        };
        if (this.dsdsActionSummary.da_subtype === 'IHAS' || this.dsdsActionSummary.da_subtype === 'SSTA') {
            dispositionModal.disposition.intakeservtypekey = this.dsdsActionSummary.da_subtype;
            dispositionModal.disposition.reqforservdispostion = this.disporitioncode[this.dispositionFormGroup.value.dispositionid.split('~')[0]];
            dispositionModal.disposition.reqforservstatus = this.dispositionFormGroup.value.statusid.split('~')[0];
            dispositionModal.disposition.programtype = this.dispositionFormGroup.value.programtype;
            dispositionModal.disposition.receiveddate = new Date();
        }
        this._dispositionAddService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.DispositionAddUrl;
        if (this.isCW && this.isServiceCase) {
            delete dispositionModal.disposition.intakeserviceid;
            delete dispositionModal.disposition.intakeserreqstatustypeid;
            delete dispositionModal.disposition.dispostionid;
            dispositionModal.disposition.servicecaseid = this.id;
            dispositionModal.disposition.intakeserreqstatustypekey = this.selectedDisposition.code;
            dispositionModal.disposition.dispositioncode = this.selectedStatus.code;
            dispositionModal.investigation.appevent = 'SCDR';
            this._dispositionAddService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.ServiceCaseDispositionAddUrl;
        } else if (this.isCW && this.isAdoptionCase) {
            delete dispositionModal.disposition.intakeserviceid;
            delete dispositionModal.disposition.intakeserreqstatustypeid;
            delete dispositionModal.disposition.dispostionid;
            delete dispositionModal.disposition.servicecaseid;
            delete dispositionModal.disposition.reviewcomments;
            dispositionModal.disposition.comments = this.dispositionFormGroup.value.reviewcomments;
            dispositionModal.disposition.assignsecurityuserid = this.dispositionFormGroup.value.supervisorid;
            dispositionModal.disposition.adoptioncaseid = this.id;
            dispositionModal.disposition.intakeserreqstatustypekey = this.selectedDisposition.code;
            dispositionModal.disposition.dispositioncode = this.selectedStatus.code;
            dispositionModal.investigation.appevent = 'ACDR';
            this._dispositionAddService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.AdoptionCaseDispositionAddUrl;
        }
        return dispositionModal;
    }
    submitReopenDisposition() {
        
        const dispositionModal = new DispositionAddModal();
        dispositionModal.disposition = Object.assign({
            intakeserviceid: this.id,
            servicecaseid: this.id,
            supervisorid: this.reopenRequestFormGroup.value.supervisorid ? this.reopenRequestFormGroup.value.supervisorid : '',
            reviewcomments: this.reopenRequestFormGroup.value.comments,
            reopenreasonkey: this.reopenRequestFormGroup.value.reopenreasonkey,
            supporttypekey: this.showFamilySupport ? this.reopenRequestFormGroup.value.supporttypekey : null,
            dateseen: new Date()
        });

        dispositionModal.investigation = {
            summary: '',
            filelocdesc: null,
            appevent: 'INVR'
        };
        
        dispositionModal.disposition.servicecaseid = this.id;
        dispositionModal.disposition.intakeserreqstatustypekey = 'Reopen';
        dispositionModal.disposition.dispositioncode = 'Inprogress';
        dispositionModal.investigation.appevent = 'SCDR';
        this._dispositionAddService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.ServiceCaseDispositionAddUrl;
    
        this._dispositionAddService.create(dispositionModal).subscribe(
            (response: any) => {
                this.reopenRequestFormGroup.reset();
                this.disableReopenCaseBtn = true;
                this._alertService.success('Servicecase Reopen sent for approval successfully');
                $(this.reopensubmissionopoupid).modal('hide');
                setTimeout(() => {
                    this.refreshPage();
                }, 2000);
            },
            (error: any) => {
                this._alertService.success('Something went wrong. Please try again later');
            }
        );
    }
    routingSubmit(daHistModal: any) {
        if(daHistModal.dispstatus === 'Return to Worker' && this.approvalStatusForm.getRawValue().routingstatus === 'Approved') {
            this.currentDispositionId = daHistModal.servicecasedispositionid;
            this.dispositionReopenFormGroup.patchValue({reopenreasonkey: daHistModal.reopenreasonkey });
            $('#reopen-disposition').modal('show');
        } else {
            this.routingUpdate(daHistModal)
        }
    }
    routingUpdate(daHistModal: any) {
        if (this.isCW && this.roleId.role.name !== AppConstants.ROLES.APPEAL_USER) {
            if (this.approvalStatusForm.controls['routingstatus'].value !== 'Rejected' && this.approvalStatusForm.controls['routingstatus'].value !== 'Approved') {
                this._alertService.error('Please select the approval status');
                return;
            }
        }
        let routingObject = {};
        if (daHistModal) {
            routingObject = this.getRoutingObject(daHistModal);
        }
        if (this.isCW && this.roleId.role.name === AppConstants.ROLES.APPEAL_USER) {
            routingObject = {
                objectid: this.id,
                intakeserviceid: this.id,
                eventcode: 'APPL',
                status: 'Approved',
                comments: '',
                notifymsg: 'Appeal Approved',
                routeddescription: 'Appeal Approved'
            };
        }
        this.updateKnishipProgramAssignment(daHistModal);
        this._commonHttpService.create(routingObject, 'routing/routingupdate').subscribe((res) => {
            if(this.caseclosure) {
                this.updatecpsresponsetimeruntimely();
            }
            this._alertService.success('saved successfully!');
            this.closePopup();
            this.dispositionHistory();
            setTimeout(() => {
                this.refreshPage();
            }, 2000);
        });
    }

    updateKnishipProgramAssignment(daHistModal: any){
        if (this.approvalStatusForm.controls['routingstatus'].value == 'Approved' && daHistModal.disposition == 'Close Case' &&
         this.involvedPersons && Array.isArray(this.involvedPersons.data)) {
            this.involvedPersons.data.forEach((person: { personid: any; }) => { //This block checks for active KINSHIP assignments
                const programAssignments = this.getProgramAssignments(person.personid);
                programAssignments.subscribe((res) => {
                    if (res && Array.isArray(res) && res.length) {
                        const KINProgramAreas = res
                            .map(item => (item.personprogramarea ?? []).filter((area: { programkey: string; enddate: null; casenumber: any; }) => area.programkey === 'KIN' && area.enddate === null && this.casedetailsobj.caseNumber === area.casenumber))
                                    .reduce((acc, curr) => acc.concat(curr), []);
                        if (KINProgramAreas && KINProgramAreas.length) { //If KINSHIP assignments are found, it will close them
                            KINProgramAreas.forEach((item: any) => {
                                const data = this.returnkinshipData(item);
                                this.updateProgramAssignment(data).subscribe((response) => {
                                    this.getProgramAssignments(person.personid);
                                }, (error) => { 
                                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                                });
                            });
                        }
                    }
                }, (err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                });
            });
        }
    }

    private returnkinshipData(item: any) {
        return {
            personprogramid: item.personprogramid,
            personid: item.personid,
            startdate: item.startdate,
            programkey: item.programkey,
            subprogramkey: item.subprogramkey ? item.subprogramkey : 'NON',
            endreasonkey: '3396',
            enddate: moment().format('YYYY-MM-DD'),
            securityusersid: this.userInfo.user.securityusersid,
            objectid: item.objectid,
            casenumber: item.casenumber,
            clientmergeid: item.clientmergeid ? item.clientmergeid : null,
            objecttypekey: item.objecttypekey ? item.objecttypekey : 'servicecase',
            ifpsatriskflag: item.ifpsatriskflag ? item.ifpsatriskflag : 0
        };
    }

    getRoutingObject(daHistModal: any) {
        let routingObject = {};
        const status = this.approvalStatusForm.controls['routingstatus'].value;
        const comments =  (status === 'Approved') ? this.dispositionapproved : this.approvalStatusForm.controls['comments'].value;
        const notifymsg = (status === 'Approved') ? this.dispositionapproved : this.dispositionrejected;
        const routeddescription = (status === 'Approved') ? this.dispositionapproved : this.dispositionrejected;
        routingObject = {
            objectid: daHistModal.intakeservicerequestdispositioncodeid,
            intakeserviceid: this.id,
            eventcode: 'INDR',
            status: status,
            comments: comments,
            notifymsg: notifymsg,
            routeddescription: routeddescription
        };
        if (this.isCW && this.isAdoptionCase) {
            const statusAdp = this.approvalStatusForm.controls['routingstatus'].value;
            routingObject = {
                'objectid': daHistModal.adoptioncasedispositionid,
                'eventcode': 'ACDR',
                'status': statusAdp,
                'comments': comments,
                'notifymsg': notifymsg,
                'routeddescription': routeddescription
            };
        } else if (this.isCW && this.isServiceCase) {
            const statusSC = this.approvalStatusForm.controls['routingstatus'].value;
            routingObject = {
                'objectid': daHistModal.servicecasedispositionid,
                'eventcode': 'SCDR',
                'status': statusSC,
                'comments': comments,
                'notifymsg': notifymsg,
                'routeddescription': routeddescription
            };
        }
        return routingObject;
    }
    updateProgramAssignment(data: any) { //Function to update program assignments
        const url = 'Personprogramareas/addupdate';
        return this._commonHttpService.create(data, url);
    }
    private _getCaseDetails(){
        const intakenumber = this.getintakenumber();
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const url = 'Intakedastagings/getCasebyIntake';
        this._commonHttpService.post(
            {'intakenumber':intakenumber,
            'isExpungementSuperUser': isExpungementSuperUser, 'iscaseexpunged': this.iscaseexpunged}, url).subscribe(
                (response) => {
                    if(this.dsdsActionsSummary && (this.dsdsActionsSummary.da_subtype == "CPS-IR" || this.dsdsActionsSummary.da_subtype == "CPS-AR")){
                        this.actionType_ = true;
                    } else {
                        this.actionType_ = false;
                    }
                    if(response.length && response.length > 0){
                        this.checkCaseDetails(response);
                    }
                    if (response.length && response.length > 0 && response[0].actiontype == "IR") { this.isActiontype = true; } else { this.isActiontype = false; }
        })
    }
    getintakenumber() {
        let intakenumber = null;
        if (this.isServiceCase) {
            const list = this._dataStoreService.getData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER);
            if (list && list.length) {
                let listArraySort = list.sort((a: { reporteddate: string; }, b: { reporteddate: any; }) => a.reporteddate.localeCompare(b.reporteddate));
                listArraySort = listArraySort.reverse();
                intakenumber = (Array.isArray(listArraySort) && listArraySort.length && listArraySort[0]) ? listArraySort[0].intakenumber : null;
            }
        } else {
            intakenumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.INTAKE_NUMBER);
        }
        return intakenumber;
    }
    checkCaseDetails(response: any) {
        const actionData: any = { "IR": "CPS-IR", "AR": "CPS-AR" };
        this.setCaseNumber(response);
        this.casedetailsobj.serviceCase = response[0].activeflag && response[0].actiontype == '1' ? response.map((x: { programkey: string; subprogramkey: string; }) => {
            if (x.programkey && x.subprogramkey) {
                return x.programkey + '-' + x.subprogramkey
            }
        }) : [actionData[response[0].actiontype] || 'Service Case'];
        this.casedetailsobj.serviceCase = this.casedetailsobj.serviceCase.filter((x: any) => x != undefined);
        this.casedetailsobj.caseDate = moment(response[0].reporteddate).format('MM/DD/YYYY');
        if (response[0].actiontype == "IR" || response[0].actiontype == "AR") {
            this.casedetailsobj.servicecaseid = response[0].intakeserviceid;
        } else {
            this.casedetailsobj.servicecaseid = response[0].servicecaseid;
        }
    }
    setCaseNumber(response: any){
        const actionData: any = { "IR": "CPS-IR", "AR": "CPS-AR" };
        if ((response[0].activeflag && response[0].actiontype == "N") || !response[0].activeflag || (response[0].activeflag && !response[0].actiontype)) {
            this.casedetailsobj.caseNumber = response[0].casenumber;
        } else if (response[0].activeflag && actionData[response[0].actiontype]) {
            this.casedetailsobj.caseNumber = response[0].servicerequestnumber;
        }
    }

    previewCpsDoc() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        if(String(this.dsdsActionsSummary.intakenumber).startsWith('CW')){ // if migrated case
            if(this.cpsDoc){
                this.cpsDoc.downloadCPSIntakePdf();
            }
            return ;
        }
        let intakenumber: any = null;
        if (this.isServiceCase) {
            const list = this._dataStoreService.getData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER);
            intakenumber = (Array.isArray(list) && list.length) ? list[0].intakenumber : null;
        } else {
            intakenumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.INTAKE_NUMBER);
        }
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['intakereport'],
                status: 'intake',
                'intakenumber': intakenumber,
                caseNumber: this.casedetailsobj.caseNumber,
                servicecaseid: this.casedetailsobj.servicecaseid,
                caseDate: this.casedetailsobj.caseDate,
                serviceCase: this.casedetailsobj.serviceCase,
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
            .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = `CPS_Intake_Report-` + intakenumber + `.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
    }
    private initializeDispositionForm() {
        this.dispositionFormGroup = this.formBuilder.group({
            statusid: [''],
            dispositionid: ['', Validators.required],
            closingcodetypekey: [null],
            reviewcomments: [''],
            programCode: [''],
            issupport: [null],
            supporttypekey: [null],
            programtype: [''],
            supervisorid: [null]
        });
        this.dispositionReopenFormGroup = this.formBuilder.group({
            statusid: ['Open', Validators.required],
            dispositionid: ['Accepted', Validators.required],
            reviewcomments: ['', Validators.required],
            caseworkerid: ['', Validators.required],
            responsibilitytypekey: ['family', Validators.required],
            teamid: ['', Validators.required],
            reopenreasonkey: ['', Validators.required],
        });
        this.reopenRequestFormGroup = this.formBuilder.group({
            reopenreasonkey: ['', Validators.required],
            comments: ['', Validators.required],
            supervisorid: ['', Validators.required]
        });
        this.reviewCheckListForm = this.formBuilder.group({
            initalfacetoface: [{value:false,disabled:true}],
            safec: [{value:false,disabled:true}],
            canf: [{value:false,disabled:true}],
            mfira: [{value:false,disabled:true}],
            personrole: [{value:false,disabled:true}],
            personConfirmed: [{value:false,disabled:true}],
           // relationConfirmed: false,
            lateinitialcontact: [{value:false,disabled:true}],
            legislativeReq:[''],
            emergncyStiuation:[''],
            forResonNotProvided:[''],
            notes:'',
            form1080a : [{value:false,disabled:true}],
            form1080b : [{value:false,disabled:true}],
            form1080c : [{value:false,disabled:true}],
            activeSenService: [{value:false,disabled:true}],
        });
    }
    
    private dispositionHistory() {
        if (this.isCW && this.isAdoptionCase) {
            this.getHistory$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize250,
                    where: {
                        adoptioncaseid: this.id
                    },
                    method: 'get'
                }),
                'adoptioncasedisposition/getadoptioncasedisposition?filter'
            );
        } else if (this.isCW && this.isServiceCase) {
            this.getHistory$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize250,
                    where: {
                        servicecaseid: this.id
                    },
                    method: 'get'
                }),
                'servicecasedisposition/getservicecasedisposition?filter'
            ).pipe(
                map(
                    (result) => {
                        const data = result;
                        if (data.length && data.length > 0 && data[0].routingstatus == this.routingstatus) { this.isReview = true }
                        else { this.isReview = false; }
                        return result;
                    },
                    (error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                ));
        } else {

            this.getHistory$ = this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        page: this.paginationInfo.pageNumber,
                        limit: this.paginationInfo.pageSize250,
                        where: {
                            servicerequestid: this.id
                        },
                        method: 'get'
                    }),
                    'Intakeservicerequestdispositioncodes/GetHistory?filter'
                ).pipe(
                map(
                    (result) => {
                        const data = result.data;
                        if (data.length !== 0 && JSON.stringify(data).includes(this.routingstatus)) { this.isReview = true }
                        else { this.isReview = false; }
                        return result.data;
                    },
                    (error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                ));
        }
    }
    getCheckList() {
        const intakeNumber = this._dataStoreService.getData("da_intakenumber");
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    where: { intakeserviceid: this.id, intakeNumber : intakeNumber, isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged},
                    method: 'get'
                }),
                'Investigationfindings/getfacetofacedetails?filter'
            )
            .subscribe((result) => {
                const check = result.find(item => (item.taskname === 'lateinitialcontact' && item.shownoshow === 'YES'));
                this.safeCDataSource = new MatTableDataSource(result[1].safecmissingchild);
                this.mfiraDataSource = new MatTableDataSource(result[1].miframissingchild);
                this.form1080aDataSource = new MatTableDataSource(result[1].form1080achild);
                this.form1080bDataSource = new MatTableDataSource(result[1].form1080bchild);
                this.form1080cDataSource = new MatTableDataSource(result[1].form1080cchild);
                this.reviewCheckList = result;
                this.updateForm1080ReviewCheckListValuesForServiceCase();
                //Form1080 service case closure review checklist
                this.getSDMDetails();
                if (check) {
                  this.isface2face = true;
                } else {
                    this.isface2face = false;
                }
            });
    }

    updateForm1080ReviewCheckListValuesForServiceCase () : void {
        this.form1080AFlag =  this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080a'  && item.status === 'Yes' && item.shownoshow === 'YES'));
        this.form1080BFlag = this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080b'  && item.status === 'Yes' && item.shownoshow === 'YES'));
        this.form1080CFlag = this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080c'  && item.status === 'Yes' && item.shownoshow === 'YES'));
    }

    private loadStatuses() {
        this.statusDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        intakeservreqtypeid: this.daType,
                        servicerequestsubtypeid: this.daSubTypeId
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.StatusUrl + '?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) => {
                        return {
                            text: res.description,
                            value: res.intakeserreqstatustypekey + '~' + res.intakeserreqstatustypeid,
                            code: res.intakeserreqstatustypekey
                        };
                    }
                ).filter(statusItem => {
                    if ((this.isCW && this.daSubType === 'CPS-IR' ) ||
                        (this.isCW && this.daSubType === 'CPS-AR' && !this.ARSummaryApproved)){
                        if (this.roleId.role.name === AppConstants.ROLES.APPEAL_USER) {
                            return this.closedStatus(statusItem);
                        } else {
                            return this.notClosedStatus(statusItem);
                        }
                    } else {
                        return true;
                    }
                });
            }));
        this.statusDropdownItems$.subscribe(data => { this.statusDropdownItems = data; });
    }

    closedStatus(statusItem: { text: any; value?: string; code?: any; }){
        if (statusItem.text === 'Closed') {
            return true;
        } else {
            return false;
        }
    }
    notClosedStatus(statusItem: { text: any; value?: string; code?: any; }){
        if (statusItem.text !== 'Completed' && statusItem.text !== 'Closed') {
            return true;
        } else {
            return false;
        }
    }
    private programType() {
        this.programTypeDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        tablename: 'programtype',
                        teamtypekey: 'AS'
                    },
                    method: 'get'
                }),
                this.gettypesurl
            ).pipe(
            map((result) => {
                return this.mapDropdownModel(result);
            }));
    }

    mapDropdownModel(result: any) {
        return result.map(
            (res: any) =>
                new DropdownModel({
                    text: res.description,
                    value: res.ref_key
                })
        );
    }

    private loadReopenServiceTypes() {  
        this.reopenServiceCaseTypes$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        tablename: 'reopencase',
                        teamtypekey: 'CW'
                    },
                    method: 'get'
                }),
                this.gettypesurl
            )
            .pipe(
                map((result) => {   
                    return this.mapDropdownModel(result);
                }));
    }
    private loadCloseCase() {
        this.closeCaseDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get'
                }),
                'closingcodetype?filter'
            ).pipe(
            map((result) => {
                return this.mapCaseCloseDropDown(result);
            }));
    }
    getProgramCode() {
        this.programCodeItems$ = this._commonHttpService
        .getArrayList(
            new PaginationRequest({
                nolimit: true,
                method: 'get',
                where: { 'tablename' : 'DispostionProgramCode', 'teamtypekey' : 'AS' }
            }),
            this.gettypesurl
        ).pipe(
        map((result) => {       
            return  this.mapDropdownModel(result);
        }));
    }
    programCode(eve: any) {
        const event: any = eve;
        this.programCodeItems$.subscribe(data => {
            if (data) {
                const removalReasonItems = data.filter(item => {
                    if (event.value.includes(item.value)) {
                        return item;
                    }
                });
                this.programCodeDescription = removalReasonItems.map(
                    res => res.text
                );
            }
        });

        this.programCodeSelection = event.value.map((sel: any) => {
            return {
                programcodetypekey: sel
            };
        });
    }

    clearDisposition() {
        this.dispositionFormGroup.reset();
        this.dispositionDropdownItems$ = EMPTY;
        this.isProgramingType = false;
        this.initializeDispositionForm();
        this.showProgramCode = false;
        this.showFamilySupport = false;
        this.programCodeDescription = [];
    }

    loadAdultCloseCase(event: any, labelname: any) {
        if (labelname === 'Waiting List') {
            this.isProgramingType = true;
            this.dispositionFormGroup.controls['programtype'].setValidators([Validators.required]);
            this.dispositionFormGroup.controls['programtype'].updateValueAndValidity();
            this.dispositionFormGroup.controls['closingcodetypekey'].clearValidators();
            this.dispositionFormGroup.controls['closingcodetypekey'].updateValueAndValidity();
        } else {
            this.isProgramingType = false;
            this.dispositionFormGroup.controls['programtype'].clearValidators();
            this.dispositionFormGroup.controls['programtype'].updateValueAndValidity();
            this.dispositionFormGroup.controls['closingcodetypekey'].setValidators([Validators.required]);
            this.dispositionFormGroup.controls['closingcodetypekey'].updateValueAndValidity();
        }
        if (event) {
            const statusID = this.dispositionFormGroup.get('statusid')?.value.split('~')[1];
            this.closeCaseDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get',
                    count: -1,
                    where: { 'intakeserreqstatustypeid' : statusID, 'servicerequesttypeconfigid' : event.split('~')[0] }
                }),
                'daconfig/servicerequesttypeconfigdispositioncode/getclosingcodelist?filter'
            ).pipe(
            map((result) => {       
               return this.mapCaseCloseDropDown(result);
            }));
        }
    }

    mapCaseCloseDropDown(result: any) {
        return result.map(
            (res: any) =>        
                new DropdownModel({
                    text: res.description,
                    value: res.closingcodetypekey
                })
        );
    }


    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages: any = source.getElementsByClassName('pdf-page');
        let pageImages: any[] = [];
        for (let i = 0; i < pages.length; i++) {

            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
            });
        }
        const pageName = 'pageName';
        this.pdfFiles.push({ fileName: pageName, images: pageImages });
        pageImages = [];
        this.convertImageToPdf();

    }
    convertImageToPdf() {
        this.pdfFiles.forEach((pdfFile) => {
            const doc: any = new jsPDF();
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG', 0, 0);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
        $('#cps-doc').modal('hide');
        this.pdfFiles = [];
    }

    doPerformApproval(d: any) {

        if (this.isSupervisor) {
            for (let i = 0; i < d.length - 1; i++) {
                if (d[i].routingstatus === 'Review') {
                    return d[i];
                }
            }
            return null;
        }
    }

    updateChecked() {
        const unChecked = this.checklistItems.filter(item => (!item.isChecked && item.show && item.id !== 21 && item.id !== 25 && item.id !== 26 && item.id !== 27)) //Changes for CDM-36154        
        this.allChecked = !unChecked.length;
        if(!this.allChecked) {
            this.disableConfirmClosureButton =true;
        } 
        else {
            this.disableConfirmClosureButton = false;
        }
    }

    loadCheckListItems() {
        let programareaTemp = Array.isArray(this.serviceprogramkey) ? this.serviceprogramkey : [];
        let subprogramKey  = Array.isArray(this.serviceprogramkey) ? this.serviceprogramkey : [];
        subprogramKey = subprogramKey.map(item => item.subprogramkey); 
        let programarea = programareaTemp.map(item => item.programkey);
        programarea = [...new Set(programarea)];
        const iveStatus = this.ccrData.map(item=>item.ivereviewstatus)
        const oohspecific = [1, 2, 3, 5, 7, 8, 9, 10, 11, 12, 13, 14, 18];
        const ihspecific = [2, 5, 18, 24, 28];
        const adoptioncase = [15, 9, 17, 16, 13];
        const kinshipNavigator = [18,19,20,21,22];
        this.checklistItems.forEach(item => {
            if(iveStatus.includes('CCR_Approved') && item.id===13){
                item.isChecked = true;
            }
            if (this.isAdoptionCase) {
                item.show = this.checkadoptioncase(adoptioncase, item);
            } else {
                this.handleIfNotAdoptionCaseFn(ihspecific, kinshipNavigator, programarea, item, oohspecific, subprogramKey);
            }
        });
    }
    
    // Assosiated with loadCheckListItems method
    private handleIfNotAdoptionCaseFn(ihspecific: number[], kinshipNavigator: number[], programarea: any[], item: any, oohspecific: number[], subprogramKey: any[]) {
        if (this.childRemovalList && this.childRemovalList.length > 0) {
            ihspecific.push(13);
            kinshipNavigator.push(13);
        }
        if (programarea.includes('OOH')) {
            item.show = this.checkoohspecific(oohspecific, item);
        } else if (subprogramKey.includes('KN') && programarea.length == 1 && this.isHeadoHouseholdCheckForKinship && this.numberofChildren) {
            item.show = this.checkkinshipNavigator(kinshipNavigator, item);
        } else {
            item.show = this.checkihspecific(ihspecific, item);
        }
    }

    showAndUpdateForm1080ReviewChecklistForServiceCase() : void {   
        let displayForm1080Checklist = false;
        const validPersonsForAV = this.involvedPersons?.data?.filter((person: any) => {
            const rolesAV = person.roles.find((item: any) => item.intakeservicerequestpersontypekey === 'AV');
            return this.reusableValidPersonConditionFn(rolesAV);
            });

        const oohPersons = validPersonsForAV?.filter((person: any) =>
            person.programarea?.some((program: any) => program.programkey === "OOH")
        );

       
            
        if(this.ischildfatality || this.isseriousphysicalinjury || 
            (this.ismaltreatment && oohPersons && oohPersons.length > 0)) {
                displayForm1080Checklist = true;
            }

        const riskOfHarm =  this._dataStoreService.getData('IsRiskofHarm');
        if(this.isServiceCase && !riskOfHarm){
            displayForm1080Checklist = false;
        }

       this.checkListItemForm1080(displayForm1080Checklist);
    }

    checkListItemForm1080 (displayForm1080Checklist : any) : void {
        this.checklistItems?.forEach(item => {
            if(item.id === 25){
                item.isChecked = this.form1080AFlag ? true : false;
                item.show = displayForm1080Checklist;
            } else if(item.id === 26){
                item.isChecked = this.form1080BFlag ? true : false;
                item.show = displayForm1080Checklist;
            } 
            else if(item.id === 27){
                item.isChecked = this.form1080CFlag ? true : false;
                item.show = displayForm1080Checklist;
            } 
        });
    }

    checkadoptioncase(adoptioncase: any, item: any){
        return (adoptioncase.includes(item.id)) ? true : false
    }
    checkoohspecific(oohspecific: any, item: { id: any; }){
        return (oohspecific.includes(item.id)) ? true : false;
    }

    checkkinshipNavigator(kinshipNavigator: any, item: { id: any; }){
        return (kinshipNavigator.includes(item.id)) ? true : false;
    }

    checkihspecific(ihspecific: any, item: { id: any; }){
        return (ihspecific.includes(item.id)) ? true : false;
    }

    checkForARSummaryApproved() {
        this._commonHttpService.getSingle({
            where: {
                intakeserviceid: this.id
            },
            method: 'get',
            page: 1,
            limit: 10
        }, 'caseclosureparticipant/getcaseclosurelist?filter').subscribe((item) => {
        if (item) {
            const summaryData =  item.length && Array.isArray(item) ? item[0] : null;
            if (summaryData) {
                if (summaryData.routingstatustypeid === 16) {
                    this.ARSummaryApproved = true;
                }
            }
        }});
    }

    getServicePlans() {
        this._commonHttpService.getArrayList({
            where: {
                caseId: this.daNumber,
                caseType: 'closure'
            },
            method: 'get',
            page: 1,
            limit: 10
        }, CaseWorkerUrlConfig.EndPoint.DSDSAction.Disposition.ebpcaseclosuredetailsUrl + '?filter').subscribe((item) => {
            if(item && item.length && item[0].count == 0){
                this.isEBPreferralmade = true;
                this.checklistItems.forEach(_item => {
                    if (_item.id === 24 && _item.show) {
                        _item.isChecked = true ;
                    }
                 });
            }
        });

    }

   
    loadSupervisor() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'CWIF' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
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
    }

    changeSupervisor($event: any) {
        if ($event && $event.value) {
            this._commonHttpService.create({
                appeventcode: this.isServiceCase === 'true' ? 'SRVC' : 'INVT',
                objectid: this.id,
                fromuserid: $event.value
            }, 'routing/changereviewer').subscribe();

        }
    }
    getAssessments() {
        let inputRequest: Object;
        if (this.isServiceCase) {
            inputRequest = {
                objecttypekey: 'servicecase',
                objectid: this.id
            };
        } else {
            const isExpungementSuperUser = this._authService.isExpungementSuperUser();
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
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: this.paginationInfo.pageSize25,
                    where: inputRequest,
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment + '?filter'
            )
            .subscribe(result => {
                const list = result.data;
                this.checkAssessmentList(list);
            });
    }

    checkAssessmentList(list: any) {
        const safec = list.filter((item: { description: string; }) => item.description.toUpperCase() === 'SAFE-C');
        let safecList = safec && safec.length && safec[0].intakassessment ? safec[0].intakassessment : [];
        safecList = safecList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
        const safecohp = list.filter((item: { description: string; }) => item.description.toUpperCase() === 'SAFE-C OHP');
        let safecohpList = safecohp && safecohp.length && safecohp[0].intakassessment ? safecohp[0].intakassessment : [];
        safecohpList = safecohpList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
        this.updateChecklist(list,safecohpList, safecList);
        this.updateChecked();
    }
    updateChecklist(list: any, safecohpList: any, safecList: any){
        let isSafeAssDone = false;
        if (safecohpList.length > 0 || safecList.length > 0) 
        {
            isSafeAssDone = true;
        }
        const ismfradone = this.assessmentCompletion(list, 'MARYLAND FAMILY RISK REASSESSMENT');
        const ismifradone = this.assessmentCompletion(list, 'MFIRA');

        this.checklistItems.forEach(item => {
            this.checklistItemsDataIfIdIsEqualToThreeFn(item, isSafeAssDone);
            if (item.id === 4) {
                item.isChecked = isSafeAssDone;
            }
            if (item.id === 5) {
                item.isChecked = (ismifradone && ismfradone);
            }
        });
    }

    private checklistItemsDataIfIdIsEqualToThreeFn(item: any, isSafeAssDone: boolean) {
        if (item.id === 3) {
            if (this.onlyOnePersonCheck) {
                item.isChecked = true;
            } else {
                item.isChecked = isSafeAssDone;
            }
        }
    }

    assessmentCompletion(list: any, assessmentname: any) {
        const assessment = list.find((item: { description: string; }) => item.description.toUpperCase() === assessmentname);
        let submissionlist = assessment && Array.isArray(assessment.intakassessment) ? assessment.intakassessment : [];
        submissionlist = submissionlist.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey !== 'Accepted' && item.assessmentstatustypekey !== 'Rejected');
        if (submissionlist.length > 0) {
            this.mifraRequiredorNot = true;
            return false;
        } else {
            this.mifraRequiredorNot = false;
           return true;
        }
    }

    getPlacementInfoList() {
        const currentCaseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get',
                    where: { servicecaseid: currentCaseId },
                }),
                'placement/getplacementbyservicecase?filter'
            ).subscribe(result => {
                const list = Array.isArray(result.data) ? result.data : [];
                if (list.length) {
                    let isLAPending = false;
                    let isPRPLpending = false;
                    let islaapprovalpending = false;
                    let isprplapprovalpending = false;
                    list.forEach(item => {
                        const placements = Array.isArray(item.placements) ? item.placements : [];
                        const ischild = this.isChildCheck(item);
                        isLAPending = this.isLAPendingCheck(placements, ischild, isLAPending);
                        isPRPLpending = this.isPRPLpendingCheck(placements, currentCaseId, isPRPLpending);
                        islaapprovalpending = this.islaapprovalpendingCheck(placements, islaapprovalpending);
                        isprplapprovalpending = this.isprplapprovalpendingCheck(placements, isprplapprovalpending);
                    });
                    this.updateChecklistWithPlacements(isLAPending, isPRPLpending, isprplapprovalpending);
                } else {
                    this.updateChecklistWithoutPlacement();
                }
                this.updateChecked();
            });
    }

    isChildCheck(item: { personid: any; }) {
        let childCategory;
        let ischild = false;
        if (this.children && this.children.length > 0) {
            childCategory = this.children.find(child => child === item.personid);
            if (childCategory && childCategory.length > 0) {
                ischild = true;
            }
        }
        return ischild;
    }
    isLAPendingCheck(placements: any, ischild: any, isLAPending: any){
        const isAnyInvalidLA = placements.some((ele: { livingenddate: null; enddate: null; placementtypekey: string; }) => ele.livingenddate === null && ele.enddate === null && ele.placementtypekey === 'LA');
        if (isAnyInvalidLA && ischild) {
            isLAPending = true;
        } 
        return isLAPending;
    }
    isPRPLpendingCheck(placements: any, currentCaseId: any, isPRPLpending: any){
        const isAnyInvalidPRPL = placements.some((ele: { enddate: null; placementtypekey: string; servicecaseid: any; isvoided: number; }) => 
            ele.enddate === null && 
            ele.placementtypekey === 'PRPL' && 
            ele.servicecaseid === currentCaseId &&
            ele.isvoided === 0);
        if (isAnyInvalidPRPL) {
            isPRPLpending = true;
        }
        return isPRPLpending;
    }
    islaapprovalpendingCheck(placements: any, islaapprovalpending: any){
        const isLAapproved = placements.some((ele: { livingenddate: null; placementtypekey: string; routingstatus: string; }) => ele.livingenddate !== null && ele.placementtypekey === 'LA' && ele.routingstatus !== 'Approved');
        if (isLAapproved) {
            islaapprovalpending = true;
        }
        return islaapprovalpending;
    }
    isprplapprovalpendingCheck(placements: any, isprplapprovalpending: any){
        const isprplapproved = placements.some((ele: { placementtypekey: string; routingstatus: string; }) => ele.placementtypekey === 'PRPL' && ele.routingstatus !== 'Approved');
        if (isprplapproved) {
            isprplapprovalpending = true;
        }
        return isprplapprovalpending;
    }
    updateChecklistWithPlacements(isLAPending: any, isPRPLpending: any, isprplapprovalpending: any){
        this.checklistItems.forEach(item => {
            if (item.id === 1) {
                item.isChecked = this.checkFlag(isLAPending) ;
            }
            if (item.id === 7) {
                item.isChecked = this.checkFlag(isPRPLpending);
            }
            if (item.id === 14) {
                item.isChecked = this.checkFlag(isprplapprovalpending);
            }
        });
    }
    updateChecklistWithoutPlacement(){
        this.checklistItems.forEach(item => {
            if (item.id === 1) {
                item.isChecked = true;
            }
            if (item.id === 7) {
                item.isChecked = true;
            }
            if (item.id === 14) {
                item.isChecked = true;
            }
        });
    }
    checkFlag(flag: any){
        return (flag) ? false : true;
    }
    getChildRemoval(groupByPerson: number = 0) {
        const requestData = { ...this.getRequestParam(), ...{ isgroup: groupByPerson } };
        this._commonHttpService
            .getSingle(
                {
                    where: requestData,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .GetChildRemovalList + '?filter'
            ).subscribe(result => {
                const list = Array.isArray(result) ? result : [];
                this.childRemovalList = list;
                const isServiceCase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
               
                if(isServiceCase){
                 this.isIVEApprovalNeeded = this.childRemovalList.some((child) => (child.servicecaseid === this.id) && 
                     (child.approvalstatus ==='Approved'
                    && child.exitdate === null
                    || child.exitdate && moment(new Date()).diff(moment(child.exitdate).format('MM/DD/YYYY'),'years',true) < 2))
                } else if(this.isAdoptionCase){
                    this.isIVEApprovalNeeded = true ;
                }

                if (list.length) {
                    this.checkIfListDataInGetChildRemovalFn(list);
                } else {
                    this.checklistItems.forEach(item => {
                        if (item.id === 8) {
                            item.isChecked = true;
                        }
                        if(item.id === 13 && !this.isIVEApprovalNeeded) {
                            item.show = false;
                        }
                    });
                }
                this.updateChecked();
            });
    }

    // Assosciated with getChildRemoval method
    private checkIfListDataInGetChildRemovalFn(list: any[]) {
        const noexitdate = list.some(item => item.exitdate === null && item.servicecasenumber === this.daNumber);
        const isvalid = (noexitdate) ? false : true;
        this.checklistItems.forEach(item => {
            if (item.id === 8) {
                item.isChecked = isvalid;
            }
            if (!this.isAdoptionCase && item.id === 13) {
                item.show = true;
            }
            if (item.id === 13 && !this.isIVEApprovalNeeded) {
                item.show = false;
            }
        });
    }

    getRequestParam() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const isServiceCase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        let requestData;
        if (isServiceCase) {
            requestData = {
                objectid: intakeserviceid,
                objecttypekey: 'servicecase',
                isExpungementSuperUser:isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };

        } else {
            requestData = { intakeserviceid: intakeserviceid, isExpungementSuperUser:isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged};
        }
        
        return requestData;
    }
    getInvolvedPerson() {
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
                    limit: 10,
                    method: 'get',
                    where: this.getRequestParam()
                }),
                url + '?filter'
                ).subscribe(result => {
                    if((['CPS-IR', 'CPS-AR'].includes(this.dsdsActionsSummary?.da_subtype)) && !(this?.reviewCheckListForm?.controls?.initalfacetoface?.value)) {
                        this.caseclosureuntimely(result?.data);
                    }
                    this.checkPersonDetails(result);
                    this.involvedPersons = result;
            });
    }
    checkPersonDetails(result: any){
        const persons = result.data;
        const livingArrangementListCheck = result.data;
        this.personList = [];
        this.personlistforservicelog = [];
        this.childVictimList = [];
        const onlychildcategory = ['CHILD'];
        const validcustodylist = ['DSSDDA', 'DSSDHMH', 'DSSDJS', 'DSSDJSDHMH', 'DSS', 'GUARDDSS', 'DJJ', 'SHLTRDSS', 'OTHRAGENCY'];
        if (persons && persons.length) {
            const isUnconfirmedpersons = persons.filter((person: { clientflag: number; }) => person.clientflag === 0);
            const isheadofhouseholdCheck = persons.filter((person: { isheadofhousehold: any; }) => person.isheadofhousehold);
            this.personProgramCheck(persons);
            this.personLACheck(livingArrangementListCheck);
            this.personChildRoleCheck(persons, onlychildcategory);
            this.headOfHouseCheck(isheadofhouseholdCheck);
            this.unConfirmedPersonCheck(isUnconfirmedpersons, isheadofhouseholdCheck);
            this.personRolesCheck(persons);
            this.personVendorList();
            this.personAgencyList();
            this.personListCheck(this.personList, validcustodylist);
            this.childVictimListCheck(this.childVictimList);

        }
        this.getPlacementInfoList();
    }

    personProgramCheck(persons: any){
        if (persons && persons.length == 1) {
            persons.forEach((p: { programarea: any; }) => {
                if (p.programarea) {
                    const programcheck = p.programarea;
                    programcheck.forEach((element: { subprogramkey: string; }) => {
                        if (element.subprogramkey == 'KN' && programcheck.length == 1) {
                            this.onlyOnePersonCheck = true;
                        }
                    });
                }

            })

        }
    }
    personLACheck(livingArrangementListCheck: any){
        livingArrangementListCheck.forEach((i: { personid: any; ishousehold: number; }) => {
            if (i.personid && i.ishousehold == 1) {
                this.getLivingArrangementDetails(i.personid)
            }
            if (i.personid) {
                this.getInvolvedPersonWithPersonID(i.personid)
            }
        })
    }

    personChildRoleCheck(persons: any, onlychildcategory: any){
        persons.map((item: { roles: any; }) => {
            if (item.roles && Array.isArray(item.roles) && item.roles.length > 0) {
                item.roles.forEach((role: any) => {
                    const childCategory = onlychildcategory.find((category: any) => category === role.intakeservicerequestpersontypekey);
                    if (childCategory) {
                        this.numberofChildren = true;
                    }
                })
            }
        })
    }
    headOfHouseCheck(isheadofhouseholdCheck: any){
        isheadofhouseholdCheck.forEach((per: { programarea: any; }) => {
            if (per.programarea) {
                const programcheck = per.programarea;
                programcheck.forEach((element: { subprogramkey: string; }) => {
                    if (element.subprogramkey == 'KN' && programcheck.length == 1) {
                        this.isHeadoHouseholdCheckForKinship = true;
                        this.loadCheckListItems();
                    }
                });
            }

        })
    }
    unConfirmedPersonCheck(isUnconfirmedpersons: any, isheadofhouseholdCheck: any){
        if (!(isUnconfirmedpersons && isUnconfirmedpersons.length > 0)) {
            this.checklistItems.forEach(item => {
                if (item.id === 18) {
                    item.isChecked = true;
                }
                if (isheadofhouseholdCheck && isheadofhouseholdCheck.length > 0) {
                    if (item.id === 19) {
                        item.isChecked = true;
                    }
                }
            });
            this.updateChecked();
            this.getquickperson();
        }
    }
    personRolesCheck(persons: any){
        persons.map((item: any) => {
            if (item.roles && Array.isArray(item.roles) && item.roles.length > 0) {
                item.roles.forEach((role: { intakeservicerequestpersontypekey: string; }) => {
                    const childCategory = this.CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
                    if (childCategory) {
                        this.children.push(item.personid);
                    }
                });
            }
            this.personlistforservicelog.push(item.cjamspid);
            if (!item.rolename || item.rolename === '') {

                if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
                    item.rolename = item.roles[0].intakeservicerequestpersontypekey;
                }
            }
            this.checkActorId(item);
            this.checkVictimRole(item);
        });
    }
    checkActorId(item: any){
        if (item.rolename === 'AV' || item.rolename === 'CHILD') {
            if (!item.intakeservicerequestactorid) {
                if (item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
                    item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
                }
            }
            this.personList.push(item.intakeservicerequestactorid);
        }
    }
    checkVictimRole(item: any) {
        const roles = Array.isArray(item.roles) ? item.roles : [];
        const atleastOneChildAvailable = roles.some((ele: { intakeservicerequestpersontypekey: string; }) => ['CHILD'].includes(ele.intakeservicerequestpersontypekey));
        if (atleastOneChildAvailable) {
            this.checklistItems.forEach(itemList => {
                if (itemList.id === 20) {
                    itemList.isChecked = true;
                }
            });
            this.updateChecked();
        }

        const isvictim = roles.some((ele: { intakeservicerequestpersontypekey: string; }) => ['AV', 'CHILD'].includes(ele.intakeservicerequestpersontypekey));
        if (isvictim) {
            this.childVictimList.push(item.personid);
        }
    }
    personVendorList() {
        this.vendorlist = [];
        const vssource = this.getVendorList(this.personlistforservicelog);
        vssource.subscribe((data: any) => {
            this.vendorlist = data['servicelogData'];
            this.checkallservicelog();
        });

    }
    personAgencyList() {
        this.agencylist = [];
        const slsource = this.getServiceLogList(this.personlistforservicelog);
        slsource.subscribe((data: any) => {
            const list = Array.isArray(data['servicelogData']) ? data['servicelogData'] : [];
            this.agencylist = list;
            this.checkallservicelog();
        });
    }

    personListCheck(personList: any, validcustodylist: any){
        const source = this.getLegalCustody(personList);
            source.subscribe(res => {
                if (res && res.length) {
                    const custodyDetails = this.getCustodyDetails(res);
                    if (custodyDetails.length) {
                        const isvalid = custodyDetails.some((ele: { legalcustodytypekey: any; todate: null; servicecaseid: string; }) => (validcustodylist.includes(ele.legalcustodytypekey)) && ele.todate === null && ele.servicecaseid === this.id);
                        this.checklistItems.forEach(item => {
                            if (item.id === 2) {
                                item.isChecked = !isvalid;
                            }
                        });
                    } else {
                        this.checklistItems.forEach(item => {
                            if (item.id === 2) {
                                item.isChecked = true;
                            }
                        });
                    }
                    this.updateChecked();
                }
            });
    }

    getCustodyDetails(res: any){
        return Array.isArray(res[0].getlegalcustodymultiplepersons) ? res[0].getlegalcustodymultiplepersons : [];
    }

    childVictimListCheck(childVictimList: any){
        const pasource = this.getProgramAssignmentList(childVictimList);
            pasource.subscribe((res) => {
                if (res && Array.isArray(res) && res.length) {
                    const isexist = res.filter(item => {
                        const area = this.getArea(item);
                        const valid = area.some(ele => ele.enddate === null && ele.objectid === this.id);
                        return (valid) ? true : false;
                    });
                    this.checklistItems.forEach(item => {
                        if (item.id === 15) {
                            item.isChecked = (isexist.length) ? false : true;
                        }
                    });
                    this.updateChecked();
                }
            });
    }

    getArea(item: { personprogramarea: any; }){
        return Array.isArray(item.personprogramarea) ? item.personprogramarea : [];
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
        ).subscribe(data => {
          if (data && data.length && data[0].getquickpersondetails && data[0].getquickpersondetails.length) {
            this.checklistItems.forEach(item => {
                if (item.id === 18) {
                    item.isChecked = false;
                }
            });
            this.loadCheckListItems();
          }
        });
      }



    checkallservicelog() {
        if (this.vendorlist && this.agencylist) {
            let agencylistcompleted = false;
            let vendorlistcompleted = false;
            if (this.agencylist.length) {
                const valid = this.agencylist.some((item: { actual_end_date: null; }) => item.actual_end_date === null);
                agencylistcompleted = !valid;
            } else {
                agencylistcompleted = true;
            }

            if (this.vendorlist.length) {
                const valid = this.vendorlist.some((item: { actual_end_date: null; }) => item.actual_end_date === null);
                vendorlistcompleted = !valid;
            } else {
                vendorlistcompleted = true;
            }

            this.checklistItems.forEach(item => {
                if (item.id === 9) {
                    item.isChecked = (vendorlistcompleted && agencylistcompleted);
                }
            });
            this.updateChecked();
        }
    }

    getLegalCustody(childActorIds: any) {
        return this._commonHttpService.getArrayList({
          method: 'get',
          where: {
            personid: childActorIds
          }
        }, 'legalcustody/getlegalcustodymultiple?filter');
      }

      getServiceLogList(cids: any) {
        return this._commonHttpService.getArrayList(
          {
            where: { daNumber: this.daNumber, client_id: cids },
            method: 'get',
            nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.servicelogmultipelist + '?filter'
        );
      }


      getInvolvedPersonWithPersonID(personList: any) {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    method: 'get',
                    where: { 
                        'objectid': this.id,
                        'objecttypekey': 'servicecase',
                        'personid': personList,
                        isExpungementSuperUser: isExpungementSuperUser,
                        iscaseexpunged: this.iscaseexpunged
                    }
                }),
                'People/getallpersonrelationbyprovidedpersonid?filter'
            ).subscribe((response) => {
                if (response && Array.isArray(response)) {
                    let programarea = Array.isArray(this.serviceprogramkey) ? this.serviceprogramkey : [];
                    let subprogramKey  = Array.isArray(this.serviceprogramkey) ? this.serviceprogramkey : [];
                    subprogramKey = subprogramKey.map(item => item.subprogramkey); 
                    programarea = programarea.map(item => item.programkey);
                     const caregiver = response.find(element => element.caregiverflag === 1);
                     this.caregiversInCase = caregiver ? caregiver.person2id : null;
                     this.personIDcheck = personList;
                     if (subprogramKey.includes('KN') && programarea.length == 1 && this.isHeadoHouseholdCheckForKinship && this.numberofChildren){
                     this.findCaregiverContact()}
                      
                  }});
    }  

    getAssignmentsList() {
        this._commonHttpService.getArrayList(
            {
                where: { adoptioncaseid:  this.id },
                method: 'get'
            },
            'Caseassignments/getassignmentstatus?filter'
        ).subscribe(data => {
            const list = Array.isArray(data) ? data : [];
            const valid = list.some(item => item.endate === null);
            this.checklistItems.forEach(item => {
                if (item.id === 15) {
                    item.isChecked = (valid) ? false : true;
                }
            });
        });
    }

    getAgreementListing() {
        this._commonHttpService
            .getSingle(
                new PaginationRequest({
                    where: { adoptioncaseid: this.id },
                    method: 'get',
                    page: 1,
                    limit: 10
                }),
                'adoptioncaseagreement/list?filter'
            )
            .subscribe(res => {
                if (res && res.length && Array.isArray(res)) {
                    const obcj = res[0];
                    const agreementList = obcj.getadoptioncaseagreementlist;
                    if (agreementList && agreementList.length) {
                        const length = agreementList.length - 1;
                        const agreement = agreementList[length];
                        if (agreement.agreementrate) {
                            const agreementRate = Array.isArray(agreement.agreementrate) ? agreement.agreementrate : [];
                            this.checkAgreementRate(agreementRate);
                        }
                    }
                }
            });
    }
    checkAgreementRate(agreementRate: any) {
        const valid = agreementRate.some((item: any) => {
            const curr = new Date();
            const edate = new Date(item.enddate);
            let validitem = false;
            if (item.enddate === null || curr < edate) { validitem = true; }
            return validitem;
        });
        this.checklistItems.forEach(item => {
            if (item.id === 17) {
                item.isChecked = (valid) ? false : true;
            }
        });
    }
    getProgramAssignmentList(personlist: any) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { objectid: this.id, personid: personlist },
                    method: 'get',
                    nolimit: true
                }),
                'Personprogramareas/getmultiplepersonprogramarea?filter'
            );
    }
    getProgramAssignments(personID: any) { //Function to check for active program assignments for each person
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { objectid: this.id, personid: personID },
                    method: 'get',
                    nolimit: true
                }),
                'Personprogramareas/getpersonprogramarea?filter'
            )
    }
    getLivingArrangementDetails(personlist: any) {
        let livingArrangementList: any[] = [];
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: { personid: personlist },
                    page: 1, 
                    limit: 10
                }),
                'livingarrangement/list?filter'
                ).subscribe((data : any) => {
                    if (data) {
                      livingArrangementList = data;
                      this.checkLAList(livingArrangementList);
                   } 
                });
    }
    checkLAList(livingArrangementList: any) {
        if (livingArrangementList && livingArrangementList.length) {
            livingArrangementList.forEach((item: { livingstartdate: any; }) => {
                if (!item.livingstartdate) {
                    this.checklistItems.forEach(Listitem => {
                        if (Listitem.id === 21) {
                            Listitem.isChecked = false;
                        }
                    });
                }
            })
        } else {
            this.checklistItems.forEach(itemL1 => {
                if (itemL1.id === 21) {
                    itemL1.isChecked = false;
                }
            });
        }
    }

    getVendorList(personlist: any) {

        return this._commonHttpService.getArrayList(
            {
                where: { daNumber: this.daNumber, clientid: personlist },
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.multivendorServiceLog + '?filter'
        );
    }
    getTeamList() {
        this._commonHttpService.getArrayList({
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

     loadCaseWorker(teamid: any) {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { 
                        filtertypekey: 'worker', 
                        teamid: teamid ? teamid: null
                    },
                    method: 'get',
                    nolimit: true
                }),
                '/manage/team/getteamusers?filter'
            )
            .subscribe(result => {
                this.caseWorkerList = result;
            });
        }
        
    teamChange(teamid: any) {
        this.loadCaseWorker(teamid);
    }

    reopenServiceCaseDisposition() {

        if(this.dispositionReopenFormGroup.invalid) {
            this._alertService.error('Please fill all the mandatory fields')
            return;
        }

        const formData = this.dispositionReopenFormGroup.getRawValue();
            formData.servicecasedispositionid = this.currentDispositionId;
            formData.servicecaseid = this.id;

        this._commonHttpService.create(formData, 'servicecasedisposition/reopenservicecase')
        .subscribe(response => {
            
            if(!response.success) {
                this._alertService.error(response.message);
                return;
            }

            this.storage.setItem('da_status', 'Open');
            this._alertService.success('Service case reopened successfully');
            
            setTimeout(() => {
                this.refreshPage();
            }, 2000);
        });

    }

    refreshPage() {
        window.location.reload();
    }

    declineReopenConfirmPopup() {
        $('#reopen-servicecase-confirm-popup').modal('hide');
    }

    declineReopenSubmissionPopup() {
        $(this.reopensubmissionopoupid).modal('hide');
    }

    showReopenSubmissionPopup() {
        this.declineReopenConfirmPopup();
        this.isSupervisor ? $('#reopen-disposition').modal('show') : $(this.reopensubmissionopoupid).modal('show')
    }

    getReopenReasonText(input: any) {
        if(input) {
            const item = this.reopenServiceCaseTypesList?.find((element: { value: any; }) => element.value === input);
            return (item && item?.text) ? item.text : '' 
        } else {
            return;
        }
    }

    daHistory_:any=[];
    viewButton(dahistory: any) {
        this.reviewCheckListForm.controls['legislativeReq'].disable();
        this.reviewCheckListForm.controls['notes'].disable();
        this.reviewCheckListForm.controls['emergncyStiuation'].disable();
        this.reviewCheckListForm.controls['forResonNotProvided'].disable();


        this.loadLegislativeDropDown();
        this.emergncyStiuationDropDown();
        this.forResonNotProvidedDropDown();
        this.daHistory_ = dahistory;
        this.reviewCheck_View();
        
        this.approvalStatusForm.patchValue({
            routingstatus: this.daHistory_?.routingstatus ? this.daHistory_.routingstatus : '',
            comments: this.daHistory_.rejectioncomments? this.daHistory_.rejectioncomments: ''
        });
        $(this.investigationfindingspopupid).modal('show');
    }
    emergncyStiuation_enable = false;
    forResonNotProvided_enable = false
    notes_enable = false;
    legis_ref: any;
    legislativeReq_Change(){
        if (this.reviewCheckListForm.value.legislativeReq) { this.legis_ref = this.reviewCheckListForm.value.legislativeReq; }
        if (this.legis_ref == 'EMEPRE') {
            this.emergncyStiuation_enable = true;
        }
        else {
            this.emergncyStiuation_enable = false;
        }
        if (this.legis_ref == 'FRARNP') {
            this.forResonNotProvided_enable = true;
        }
        else {
            this.forResonNotProvided_enable = false;
        }
        if (this.legis_ref == 'DAEERR') {
            this.notes_enable = true;
        }
        else {
            this.notes_enable = false; 
      }
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
                this.refgettypesurl + '?filter'
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
                this.refgettypesurl + '?filter'
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
                this.refgettypesurl + '?filter'
            )
            .subscribe((item) => {
                this.forResonNotProvided_list = item;
            });

    }

    closePopup() {
        $(this.investigationfindingspopupid).modal('hide');
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
    legislative_dll = false;
    reviewCheck_View() {
        if (this.legislative && this.legislative.legislativeid) {
            this.form1080AFlag =  this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080a'  && item.status === 'Yes' && item.shownoshow === 'YES'));
            this.form1080BFlag = this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080b'  && item.status === 'Yes' && item.shownoshow === 'YES'));
            this.form1080CFlag = this.reviewCheckList.length && this.reviewCheckList.find(item => (item.taskname === 'form1080c'  && item.status === 'Yes' && item.shownoshow === 'YES'));
    
            if(this.legislative.isallegedvicitm) {
               this.reviewCheckListForm.patchValue({ personrole: this.legislative.isallegedvicitm }); 
            } else {
               this.reviewCheckListForm.patchValue({ personrole: this.legislative.isvictimperpetrator });
            }
            this.reviewCheckListForm.patchValue({ initalfacetoface: this.legislative.isinitialfacetoface });
            this.reviewCheckListForm.patchValue({ safec: this.legislative.isapprovedsafec });
            this.reviewCheckListForm.patchValue({ mfira: this.legislative.isapprovedmfira });
            this.reviewCheckListForm.patchValue({ canf: this.legislative.isapprovecansf });
            this.reviewCheckListForm.patchValue({ personConfirmed: this.legislative.isallpersons });
            this.reviewCheckListForm.patchValue({ lateinitialcontact: this.legislative.islateinitialcontact });
            
                
            this.updateForm1080FormValues();

            this.reviewCheckListForm.patchValue({ legislativeReq: this.legislative.islegislativereporting });
            this.reviewCheckListForm.patchValue({ notes: this.legislative.isdataentrynotes });
            this.reviewCheckListForm.patchValue({ emergncyStiuation: this.legislative.isemergency });
            this.reviewCheckListForm.patchValue({ forResonNotProvided: this.legislative.isreasonnotprovided });
            this.legis_ref = this.legislative.islegislativereporting;
            this.legislativeReq_Change();
            if (this.legislative && this.legislative.islegislativereporting !== '' && this.legislative.islegislativereporting !== null ) {
                this.legislative_dll = true;
            } else { this.legislative_dll = false; }
        }

        $(this.investigationfindingspopupid).modal('show');
        this.reviewCheckContinue();
      
    }

    updateForm1080FormValues() : void {
        this.reviewCheckListForm.patchValue({ form1080a: false });
        if (this.form1080AFlag) {
            this.reviewCheckListForm.patchValue({ form1080a: true });
        }

        this.reviewCheckListForm.patchValue({ form1080b: false });
        if (this.form1080BFlag) {
            this.reviewCheckListForm.patchValue({ form1080b: true });
        }

        this.reviewCheckListForm.patchValue({ form1080c: false });
        if (this.form1080CFlag) {
            this.reviewCheckListForm.patchValue({ form1080c: true });
        }
    }

    reviewCheckContinue() : void {
        //checking if Form 1080 C is entered or not
        if(!this.checkForm1080CFilled()){
            const riskOfHarm=  this._dataStoreService.getData('IsRiskofHarm');
            if((this.isServiceCase && !riskOfHarm) && !this.isServiceCase) {
                this.globalPopupRef.showGlobalPopupAlert('Form 1080 C Alert','Please complete and submit the 1080 C form. The 1080 Series is located in the Forms sub-tab of the Documents tab.');
            }
        }
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

        const validPersonsForAV = this.involvedPersons.data.filter((person: any) => {
        const rolesAV = person.roles.find((item: any) => item.intakeservicerequestpersontypekey === 'AV');
        return this.reusableValidPersonConditionFn(rolesAV);
        });

        const oohPersons = validPersonsForAV.filter((person: any) =>
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

    enableSubmitbtn = false;
    appRej_radBtn() {
        if (this.approvalStatusForm.getRawValue().routingstatus === 'Approved') {
            this.enableSubmitbtn = true;
        } else if (this.approvalStatusForm.getRawValue().routingstatus === 'Rejected' && this.approvalStatusForm.getRawValue().comments !== '') {
            this.enableSubmitbtn = true;
        } else {
            this.enableSubmitbtn = false;
        }
    }

    caseclosure: boolean = false;
    caseclosureuntimely(persons: any) {
        this.caseclosure = false;
            const _persons: any[] = [];
            persons?.forEach((p: any) => {
                    p?.roles?.forEach((r: any) => {
                        if(this.returnPersonsCondFn(_persons, p, r)) {
                        _persons.push(p.personid);
                        }
                });
            });
            if(_persons?.length > 0) {
                this._commonHttpService.getArrayList(
                  {
                      where: { v_entitytypeid: this.id },
                      method: 'get'
                  },
                  CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetCaseClosureRecordings + '?filter'
                ).subscribe ((result : any)=>{
                    this.handleGetCaseClosureRecordingsResultFn(result, _persons);
                });
            }
    }
    // Assosiated with caseclosureuntimely method
    private handleGetCaseClosureRecordingsResultFn(result: any, _persons: any[]) {
        result?.forEach((r: any) => {
            if (!this.caseclosure) {
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
        });
    }
    // Assosiated with caseclosureuntimely method
    private returnPersonsCondFn(_persons: any[], p: any, r: any) {
        return (!_persons.includes(p.personid) &&
            ['ICC', 'AV'].includes(r?.intakeservicerequestpersontypekey) ||
            ((p?.ishousehold === 1) && ((r?.intakeservicerequestpersontypekey === 'CHILD') ||
                ((r?.intakeservicerequestpersontypekey === 'OTHERCHILD') &&
                    (JSON.parse(JSON.stringify(p?.dangerous[0]))?.initialresponse !== 0)))));
    }

    updatecpsresponsetimeruntimely() {
        this._commonHttpService.patch(this.id, {}, 'Intakeservicerequests/updatecpsresponsetimeruntimely')
            .subscribe(res => {
                // No content to add or call // NOSONAR
            }, err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
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

    // Get sdm data
    getSDMDetails() {
        // The sdm endpoints filter on a uuid column, so an unresolved this.id reaches
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
                let sdmData;
                if (res && res.length > 0) {
                  if (this.isServiceCase) {
                    const i = res[0].getservicecasesdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                    sdmData = res[0].getservicecasesdm[i];
                  } else {
                    const i = res[0].getintakeservicerequestsdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                    sdmData = res[0].getintakeservicerequestsdm[i];
                  }
                  if (sdmData) {
                    this.ischildfatality = sdmData?.ischildfatality;
                    this.isseriousphysicalinjury = sdmData?.isseriousphysicalinjury;
                    this.ismaltreatment = sdmData?.ismaltreatment;
                    this.intakesdmproviderlength = sdmData?.provider?.length;

                    //update form 1080 review checklist
                    this.showAndUpdateForm1080ReviewChecklistForServiceCase()
                  }
                }
            });
      }

      getTrafficking(caseid: any) {
        this._commonHttpService
        .create(
            {
                method: 'post',
                where: {
                    objectid: caseid,
                    sdmid: this.sdmDetails ? this.sdmDetails?.intakeservicerequestsdmid : ''
                }
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.Sdmtraffickingvalid
            ).subscribe((item) => {
                this.checklistItems.push({
                    id: 28,
                    name: 'Concerns for Trafficking selection required in SDM, please choose Yes or No. If Yes, specify the Trafficking type',
                    isChecked: false,
                    autofilled: true,
                    show: true
                });
                this.checklistItems.forEach(_item => {
                    if (_item.id === 28) {
                        if (item?.data[0]?.isvalid) {
                            _item.isChecked = true;
                            _item.name = 'Concern for Trafficking selection completed in SDM';
                            _item.show = true;
                        }
                    }
                 });
                 this.cdr.detectChanges();
            }); 
        }

        getCaseId() {
            const isServicecase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
            const cpscaseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CPS_CASE_ID);
            return (isServicecase) ? cpscaseid : this.id;
        }

        getSDM() {
            // Called from ngOnInit, before anything has confirmed CASE_UID holds a
            // real case id. See getSDMDetails above for why a non-uuid 400s.
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
                    if (res && res.length > 0 && res[0].getservicecasesdm && res[0].getservicecasesdm.length > 0) {
                        const sdm = res[0].getservicecasesdm.find((item: { pathwaystatus: string; }) => item.pathwaystatus === 'Accepted');
                        if (sdm) {
                            this.sdmDetails = sdm;
                        }
                    }
                });
        }
}
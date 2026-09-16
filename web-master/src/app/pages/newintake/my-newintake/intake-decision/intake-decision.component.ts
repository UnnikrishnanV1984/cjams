
import {of as observableOf, EMPTY,  Observable } from 'rxjs';
import {share, pluck, map} from 'rxjs/operators';
import { AfterViewChecked, AfterViewInit, ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest, PaginationInfo, DynamicObject } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, CommonDropdownsService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { DispositionCode, DispostionOutput, InvolvedPerson, AssessmentScores } from '../_entities/newintakeModel';
import { DelayResponse, General, MembersInMeeting, EvaluationFields } from '../_entities/newintakeSaveModel';
import { NewUrlConfig } from './../../newintake-url.config';
import { DispositionConfig } from './_configurations/reason';
import { RoutingUser } from '../../../cjams-dashboard/_entities/dashBoard-datamodel';
import { Router, ActivatedRoute } from '@angular/router';
import { IntakeStoreConstants, MyNewintakeConstants } from '../my-newintake.constants';
import { IntakeConfigService } from '../intake-config.service';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AppConstants } from '../../../../@core/common/constants';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'intake-decision',
    templateUrl: './intake-decision.component.html',
    styleUrls: ['./intake-decision.component.scss'],
    standalone: false
})
export class IntakeDecisionComponent implements OnInit, AfterViewInit, AfterViewChecked {
    // @Input() dispositionInput$ = new Subject<string>();
    // @Input() dispositionOutPut$ = new Subject<DispostionOutput[]>();
    // @Input() dispositionRetrive$ = new Subject<DispostionOutput[]>();
    // @Input() timeReceived$ = new Subject<string>();
    // @Input() purposeToDispOutput$ = new Subject<string>();
    // @Input() isDateDelayed$ = new Subject<DelayResponse>();
    // @Input() delayformValue$ = new Subject<DelayForm>();
    // @Input() general$ = new Subject<General>();
    general!: General;
    // @Input() agencyStatus$ = new Subject<string>();
    // @Input() createdCaseInputSubject$ = new Subject<ComplaintTypeCase[]>();
    // @Input() offenceCategoriesInputSubject$ = new Subject<any>();
    // tslint:disable-next-line:no-input-rename
    // @Input('addedPersonsChange') addedPersonsChanges$ = new Subject<InvolvedPerson[]>();
    // tslint:disable-next-line:no-input-rename
    // @Input('appointmentOutputSubject') appointmentOutputSubject$ = new Subject<IntakeAppointment[]>();
    // tslint:disable-next-line:no-input-rename
    // @Input('appointmentInputSubject') appointmentInputSubject$ = new Subject<IntakeAppointment[]>();
    // tslint:disable-next-line:no-input-rename
    // @Input('isPreIntake') isPreIntake$ = new Subject<boolean>();
    // tslint:disable-next-line:no-input-rename
    // @Input('evalFields') evalFields$ = new Subject<EvaluationFields[]>();
    intakeNumber = '';
    // tslint:disable-next-line:no-input-rename
    // @Input('decision') decision$ = new Subject<string>();
    // tslint:disable-next-line:no-input-rename
    // @Input('preIntakedisposition') preIntakedisposition$ = new Subject<PreIntakeDisposition>();
    // tslint:disable-next-line:no-input-rename
    // @Input('preIntakedispositionReciv') preIntakedispositionReciv$ = new Subject<PreIntakeDisposition>();
    // @Input('scoresSubject') scoresSubject$ = new Subject<AssessmentScores>();
    show = false;
    assmentScores: AssessmentScores = new AssessmentScores();
    evalFields: EvaluationFields[] = [];
    isPreIntake = false;
    createdCase: DispostionOutput[] = [];
    offenceCategories$!: Observable<DropdownModel[]>;
    offenceCategories: any[] = [];
    statusDropdownItems$!: Observable<DropdownModel[]>;
    intakeRecomendations$!: Observable<DropdownModel[]>;
    dispositionList: DispositionCode[] = [];
    dispositionDropDown: DropdownModel[] = [];
    supDispositionDropDown: DropdownModel[] = [];
    disposition!: string;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    dispositionFormGroup!: FormGroup;
    preIntakeDispositionFormGroup: FormGroup;
    dispositionDelayForm!: FormGroup;
    caseForm!: FormGroup;
    date = new Date();
    serviceTypeId!: string;
    showReason = false;
    supervisorUser!: boolean;
    timeReceived!: string;
    showStatus = true;
    daTypeSubType!: string;
    generalRecievedDate!: DelayResponse;
    role!: AppUser;
    agencyStatus!: string;
    intakePurpose: any;
    showBehalfOfRequester = false;
    actionDropdown: DropdownModel[] = [];
    initRecomentdationDropdown: DropdownModel[] =[];
    supMultipleDispositionDropdown: DropdownModel[] =[];
    intakeWorker!: MembersInMeeting;
    intakeWorkerId!: string;
    intakeWorkerList: any[] = [];
    mother!: InvolvedPerson | null;
    father!: InvolvedPerson | null;
    youth!: InvolvedPerson | null;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    intakersList$!: Observable<RoutingUser[]>;
    intakerinMind!: RoutingUser;
    showScreen1 = false;
    showScreen2 = false;
    showScreen3 = false;
    showScreen4 = false;
    commonDispositionStatusData!: DispostionOutput;
    jurisdiction = { id: '', name: '' };
    toShowReason = false;
    countyid!: string;
    intakeWorkerName!: string;
    system = {
        ageInValid: false, youthValid: false, parentsValid: false,
        jurisdictionValid: false, offenceValid: false, status: '', reason: ''
    };
    store: any;
    enableTextarea = false;
    completionNotes!: string;
    flowToCaseSupervisor = false;
    isDetention!: boolean;
    notes: any;
    youthStatus: any[] = [];
    detentionDescription!: string;
    notesPlaceholder = 'Detention Notes...';
    hasRestitution = false;
    removePaymentSchedules!: boolean;
    isReopen = false;
    isInsufficientInfo = false;
    reopenComments = '';
    djsValidationMessages: any;
    getDetainStatus = false;
    disableDetainbutton = false;
    reasonDisableDetainbutton = '';
    atdDetentionTypesList: DropdownModel[] = [];
    assigndetbutton = 'Assign Detention';
    atdDetentionType: any;
    isMD!: boolean;
    isDPSCS!: boolean;
    notesReq!: boolean;
    isMDlabel = true;
    isDPSCSlabel= true;
    isIntakeFromSupervisor = false;
    intakesrstatusuuid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a';
    getdispositionlisturl = 'daconfig/servicerequesttypeconfigdispositioncode/getdispositionlist?filter';
    private readonly _commonHttpService: CommonHttpService;
    private readonly formBuilder: FormBuilder;
    public readonly  _authService: AuthService;
    private readonly _changeDetect: ChangeDetectorRef;
    private readonly _alertService: AlertService;
    private readonly _router: Router;
    private readonly _dataStoreService: DataStoreService;

    constructor(
        private readonly injector : Injector,
        private readonly _dropDownService: CommonDropdownsService,
        private readonly _intakeConfig: IntakeConfigService,
        private readonly route: ActivatedRoute) {
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._router = this.injector.get<Router>(Router);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        
        this.store = this._dataStoreService.getCurrentStore();
        this.preIntakeDispositionFormGroup = new FormGroup({
            completionNotes: new FormControl()
         });
        this.route.data.subscribe(response => {
            const result = response.items;
            if (result) {
                this.getDRAIScore(result);
                this.getMCAPScore(result);
            }
        });
    }

    // checkDetainStatusFromDRAI() {
    //     if (this.assmentScores && this.assmentScores.DRAI && (this.assmentScores.DRAI.AD === 'Detain' || this.assmentScores.DRAI.AD === 'Detention Alternative')) {
    //         const prevdetainstatus = this.store[IntakeStoreConstants.detentionOpened];
    //         if (prevdetainstatus && prevdetainstatus.detained) {
    //             this.getDetainStatus = false;
    //         } else {
    //             if (this.assmentScores.DRAI.AD === 'Detain') {
    //                 this.assigndetbutton = 'Assign Detention';
    //             } else if (this.assmentScores.DRAI.AD === 'Detention Alternative') {
    //                 this.assigndetbutton = 'Assign ATD';
    //             }
    //             this.getDetainStatus = true;
    //         }
    //     } else {
    //         this.getDetainStatus = false;
    //     }
    // }

    getDRAIScore(result: any) {
        if (result && result.data) {
            result.data.forEach((element: { titleheadertext: string; intakassessment: string | any[]; }) => {
                if (element.titleheadertext === 'Intake Detention Risk Assessment Instrument') {
                    if (element.intakassessment && element.intakassessment.length > 0) {
                        const latestDrai = element.intakassessment[0].submissiondata;
                        const scores = {
                            score: latestDrai.score,
                            value: latestDrai.value,
                            AD: latestDrai.AD,
                            SD: latestDrai.SD,
                            SD2: latestDrai.SD2
                        };
                        this.assmentScores.DRAI = scores;
                    }
                }
            });
        }
    }
    getMCAPScore(result: any) {
        result?.data?.forEach((element: { titleheadertext: string; intakassessment: string | any[]; }) => {
            if (element.titleheadertext === 'MCASP Risk Assessment') {
                if (element?.intakassessment?.length > 0) {
                    const latestMcasp = element.intakassessment[0].submissiondata;
                    const scores = {
                        dhs: latestMcasp?.dhs1,
                        shs: latestMcasp?.shs2,
                        risklevel: latestMcasp?.risklevel
                    };
                    this.assmentScores.MCASP = scores;
                    if (latestMcasp.Complete) {
                        let evalfields = this._dataStoreService.getData(IntakeStoreConstants.evalFields);
                        if (evalfields?.length > 0) {
                            evalfields = evalfields.map((data: any) => {
                                data.MCASPCompleted = true;
                                return data;
                            });
                            this._dataStoreService.setData(IntakeStoreConstants.evalFields, evalfields);
                        }
                    }
                }
            }
        });
    }

    ngOnInit() {
        const role = this._authService.getCurrentUser();
        this.role = role;
        this._dataStoreService.currentStore.subscribe(storeObj => {
            const youthStatus = storeObj[IntakeStoreConstants.youthStatus];
            this.getCurrentStoreObjectFn(storeObj, youthStatus);
        });
        this.show = false;
        this.intakeNumber = this.store[IntakeStoreConstants.intakenumber];
        this.loadIntaker(1);
        this.loadIntakeRecomendations();
        this.actionDropdown = DispositionConfig.config.action;
        this.initRecomentdationDropdown = DispositionConfig.config.initialRecomendation;
        this.setScreenToShow();
        // this.agencyStatus$.subscribe((res) => {
        this.agencyStatus = this.store[IntakeStoreConstants.agency];
        this.flowToCaseSupervisor = this._intakeConfig.isFlowToCaseSupervisor();
        // });
        this.dispositionForm();

        // this.dispositionInput$.subscribe((res) =>
        {
            const purposeSelected = this.store[IntakeStoreConstants.purposeSelected];
            if (purposeSelected) {
                this.serviceTypeId = purposeSelected.value;
            }
        }// );

        this.listAllegations();
        // this.isPreIntake$.subscribe(data =>
        {
            this.isPreIntake = this.store[IntakeStoreConstants.ispreintake];
            this.setScreenToShow();
        } // );

        // Validation for close case with insufficient info
        if (this._authService.isDJS() && (this.showScreen2 || this.isIntakeFromSupervisor)) {
            const message = this._intakeConfig.djsInfoValidation();
            this.insufficientInfoFn(message);
        }


        // this.preIntakedispositionReciv$.subscribe(data =>
        {
            const preIntakeDisposition = this._dataStoreService.getData(IntakeStoreConstants.preIntakeDisposition);
            this.ifPreIntakeDispositionFn(preIntakeDisposition);
        } // );

        // this.createdCaseInputSubject$.subscribe((response) =>
        {
            this.ifShowScreen1Fn();
        } // );

        if (role.role.name === 'apcs') {
            this.supervisorUser = true;
            this.dispositionFormGroup.get('intake');
        } else {
            this.supervisorUser = false;
        }
        // this.dispositionOutPut$.subscribe((data) =>
        {
            const disposition = this._dataStoreService.getData(IntakeStoreConstants.disposition);
            const roleId = this._authService.getCurrentUser();
            if (roleId.role.name === 'apcs') {
                this.supervisorUser = true;
                this.showStatus = false;
            } else {
                this.supervisorUser = false;
            }
            if (disposition?.length > 0) {
                this.commonDispositionStatusData = disposition[0];
                this.ifDispositionDAStatusFn(disposition);
            }
        } // );

        // this.timeReceived$.subscribe((time) =>
        {
            this.timeReceived = this._dataStoreService.getData(IntakeStoreConstants.timeleft);
            this.enableReasonfordelay();
        } // );

        // this.purposeToDispOutput$.subscribe((resp) =>
        {
            const purpose = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
            this.daTypeSubType = purpose ? purpose.value : '';
            this.statusDropdownItems$ = EMPTY;
            this.checkDaTypeSubTypeFn();
        } // );

        // this.appointmentOutputSubject$.subscribe((data) =>
        {
            const intakeappointment = this.store[IntakeStoreConstants.intakeappointment];
            this.ifIntakeappointmentFN(intakeappointment);
            
        } // );

        // this.addedPersonsChanges$.subscribe((addedPersons) =>
        {
            const addedPersons = this.store[IntakeStoreConstants.addedPersons];
            this.mother = null;
            this.father = null;
            this.youth = null;
            if (addedPersons) {
                addedPersons.forEach((person: any) => {
                    this.getPersonRole(person);
                });
            }
            this.estimateSytemRecomendation();
        } // );

        // this._dataStoreService.currentStore.subscribe(storeData =>
        {
            if (this.store[IntakeStoreConstants.evalFields]) {
                this.evalFieldsFn();
            }
        } // );
        // this.evalFields$.subscribe((data) =>
        {
            this.evalFieldsFn();
            this.estimateSytemRecomendation();
        }// );
        this.checkIfDjsFn();
    }

    private ifShowScreen1Fn() {
        let createdCases = [];
        let dispositioncreatedCases = [];
        if (this.showScreen1 && !this.isIntakeFromSupervisor) { // Intake Supervison
            createdCases = this._dataStoreService.getData(IntakeStoreConstants.disposition);
        } else {
            dispositioncreatedCases = this._dataStoreService.getData(IntakeStoreConstants.disposition);
            this.ifDispositioncreatedCasesFn(dispositioncreatedCases);
            createdCases = this._dataStoreService.getData(IntakeStoreConstants.createdCases);
        }
        this.dispositionFormGroup.patchValue({
            intakeserreqstatustypekey: ''
        });
        // to get the label for datype
        this.getIntakePurposeFn();
        // end of - to get the label for datype
        this.ifCreatedCaseConditionFn(createdCases, dispositioncreatedCases);
    }

    private checkIfDjsFn() {
        if (this._authService.isDJS() && this.showScreen2 && this.isInsufficientInfo) {
            setTimeout(() => {
                this.showScreen2CheckFn();
            }, 1000);
        }
        if (this._authService.isDJS()) {
            this.checkDetainStatusFromDRAI();
        }
    }

    private getIntakePurposeFn() {
        const checkInput = {
            nolimit: true,
            where: { teamtypekey: 'all' },
            method: 'get',
            order: 'description'
        };
        this._commonHttpService.getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.IntakePurposes + '/list?filter').subscribe((result) => {
            this.intakePurpose = result;
        });
    }

    private getCurrentStoreObjectFn(storeObj: DynamicObject, youthStatus: any) {
        if (this.role.role.name === AppConstants.ROLES.SUPERVISOR) {
            this.isIntakeFromSupervisor = storeObj[IntakeStoreConstants.IntakeAction] === 'add';
        }
        this.isDetention = youthStatus?.includes?.('Detention') ?? false;
    }

    private showScreen2CheckFn() {
        const model = new DropdownModel();
        // Closing case for insufficient information
        model.text = 'Closed';
        model.value = this.intakesrstatusuuid;
        this.statusDropdownItems$ = observableOf([model]);
        this.dispositionFormGroup.patchValue({
            intakeserreqstatustypekey: this.intakesrstatusuuid
        });
        this.dispositionFormGroup.get('intakeserreqstatustypekey')?.disable();
        this.changeDisp();
    }

    private checkDaTypeSubTypeFn() {
        if (this.daTypeSubType === '619c4dcf-ef22-4fc4-9269-d7678e8a8f6a') {
            this.showBehalfOfRequester = true;
            const model = new DropdownModel();
            model.text = 'Closed';
            model.value = 'Closed';
            this.statusDropdownItems$ = observableOf([model]);
            this.dispositionFormGroup.patchValue({
                intakeserreqstatustypekey: 'Closed'
            });
            this.onChangeTaskStatus('Closed');
        } else {
            this.showBehalfOfRequester = false;
            this.dispositionFormGroup.get('intakeserreqstatustypekey')?.enable();
            this.loadDropdown();
        }
    }

    private evalFieldsFn() {
        const complaints = this._dataStoreService.getData(IntakeStoreConstants.evalFields);
        this.evalFields = (complaints && complaints.length > 0) ? complaints : [];
        if (this.jurisdiction && this.evalFields.length > 0 && this.jurisdiction.id !== this.evalFields[0].countyid) {
            if (this.countyid !== this.evalFields[0].countyid) {
                this.countyid = this.evalFields[0].countyid;
                this.getjurisdiction(this.evalFields[0].countyid);
            }
        }
    }

    private ifIntakeappointmentFN(intakeappointment: any) {
        if (intakeappointment && intakeappointment.length > 0) {
            const firstAppointment = intakeappointment[0];
            this.intakeWorkerId = firstAppointment.intakeWorkerId;
            this._dataStoreService.setData(IntakeStoreConstants.assingedIntakeWokerId, this.intakeWorkerId);

            if (this.intakeWorkerList.length > 0 && typeof this.getIntakeWorkerName === 'function') {
                const intakeWorkerNameObj = this.getIntakeWorkerName();
                if (intakeWorkerNameObj) {
                    this.intakeWorkerName = intakeWorkerNameObj.username;
                }
            }
        }
    }

    private ifDispositioncreatedCasesFn(dispositioncreatedCases: any[]) {
        if (dispositioncreatedCases?.length > 0) {
            if (dispositioncreatedCases[0].DAStatus === 'Reopen') {
                this.reopenComments = dispositioncreatedCases[0].reason;
                this.isReopen = true;
            }
        }
    }

    private ifDispositionDAStatusFn(disposition: any) {
        if (disposition[0].DAStatus) {
            this._commonHttpService
                .getArrayList(
                    new PaginationRequest({
                        nolimit: true,
                        where: {
                            intakeservreqtypeid: disposition[0].DAStatus,
                            servicerequestsubtypeid: this.daTypeSubType
                        },
                        method: 'get'
                    }),
                    'Intakeservicerequestdispositioncodes/getstatuslist?filter'
                )
                .subscribe((result) => {
                    this.dispositionList = result;
                    if (disposition?.length > 0) {
                        this.ifIntakeserreqstatustypekeyFn(disposition);
                        this.ifSupStatusFn(disposition);
                    }
                });
        }
    }

    private ifSupStatusFn(disposition: any) {
        if (disposition[0].supStatus) {
            this.supOnChangeTaskStatus(disposition[0].supStatus);
            this.dispositionFormGroup.patchValue({
                reason: disposition[0].reason,
                supStatus: disposition[0].supStatus,
                supDisposition: disposition[0].supDisposition,
                supComments: disposition[0].supComments
            });
        }
    }

    private ifIntakeserreqstatustypekeyFn(disposition: any) {
        if (disposition[0].intakeserreqstatustypekey) {
            this.createdCase = disposition;
            if (!this.showScreen1) {
                this.onChangeTaskStatus(disposition[0].intakeserreqstatustypekey);
            }
            this.dispositionFormGroup.patchValue({
                intakeserreqstatustypekey: disposition[0].intakeserreqstatustypekey,
                supStatus: disposition[0].supStatus ? disposition[0].supStatus : '',
                dispositioncode: disposition[0].dispositioncode,
                comments: disposition[0].comments,
                intakeAction: disposition[0].intakeAction
            });
        }
    }

    private ifCreatedCaseConditionFn(createdCases: any[], dispositioncreatedCases: any[]) {
        if (createdCases && (!this.showScreen1 || this.isIntakeFromSupervisor)) {
            this.createdCase = [];
            let createdCaseTemp: any;
            createdCases.forEach((item) => {
                createdCaseTemp = this.returnCreatedCaseDataFn(item);
                if (dispositioncreatedCases?.length > 0) {
                    const dispo = dispositioncreatedCases.find((data) => data.ServiceRequestNumber === createdCaseTemp.ServiceRequestNumber);
                    createdCaseTemp.intakeserreqstatustypekey = this.returnIntakeserreqstatustypekeyFn(createdCaseTemp, dispo);
                    createdCaseTemp.dispositioncode = this.returnDispositioncodeFn(createdCaseTemp, dispo);
                    createdCaseTemp.dispositioncodestatus = this.returnDispositioncodestatusFn(createdCaseTemp, dispo);
                    createdCaseTemp.dispositioncodedesc = this.returnDispositioncodedescFn(createdCaseTemp, dispo);
                    createdCaseTemp.dispositioncodestatusdesc = this.returnDispositioncodestatusdescFn(createdCaseTemp, dispo);
                    createdCaseTemp.restitution = this.returnRestitutionFn(createdCaseTemp, dispo);
                }
                this.createdCase.push(createdCaseTemp);
                // this.createdCase.dispositioncode: '',
                // this.createdCase.intakeserreqstatustypekey: '',
                this.ifCreatedCaseFn();
            });
        }
    }

    private returnRestitutionFn(createdCase: any, dispo: any): any {
        return createdCase.restitution ? createdCase.restitution : dispo.restitution;
    }

    private returnDispositioncodestatusdescFn(createdCase: any, dispo: any): any {
        return createdCase.dispositioncodestatusdesc ? createdCase.dispositioncodestatusdesc : dispo.dispositioncodestatusdesc;
    }

    private returnDispositioncodedescFn(createdCase: any, dispo: any): any {
        return createdCase.dispositioncodedesc ? createdCase.dispositioncodedesc : dispo.dispositioncodedesc;
    }

    private returnDispositioncodestatusFn(createdCase: any, dispo: any): any {
        return createdCase.dispositioncodestatus ? createdCase.dispositioncodestatus : dispo.dispositioncodestatus;
    }

    private returnDispositioncodeFn(createdCase: any, dispo: any): any {
        return createdCase.dispositioncode ? createdCase.dispositioncode : dispo.dispositioncode;
    }

    private returnIntakeserreqstatustypekeyFn(createdCase: any, dispo: any): any {
        return createdCase.intakeserreqstatustypekey ? createdCase.intakeserreqstatustypekey : dispo.intakeserreqstatustypekey;
    }

    private ifCreatedCaseFn() {
        if (this.createdCase.length > 0) {
            if (this.createdCase[0].intakeserreqstatustypekey && !this.showScreen1) {
                this.onChangeTaskStatus(this.createdCase[0].intakeserreqstatustypekey);
            }
            if (this.createdCase[0].supStatus) {
                this.supOnChangeTaskStatus(this.createdCase[0].supStatus);
            }
            this.dispositionFormGroup.patchValue({
                intakeserreqstatustypekey: this.createdCase[0].intakeserreqstatustypekey ? this.createdCase[0].intakeserreqstatustypekey : '',
                dispositioncode: this.createdCase[0].dispositioncode ? this.createdCase[0].dispositioncode : '',
                supStatus: this.createdCase[0].supStatus ? this.createdCase[0].supStatus : '',
                supDisposition: this.createdCase[0].supDisposition ? this.createdCase[0].supDisposition : ''
            });
            this.changeDisp();
        }
    }

    private returnCreatedCaseDataFn(item: any) {
        return {
            ServiceRequestNumber: item.caseID,
            DaTypeKey: item.serviceTypeID,
            subSeriviceTypeValue: item.subSeriviceTypeValue,
            DasubtypeKey: item.subServiceTypeID,
            DAStatus: '',
            DADisposition: '',
            Summary: '',
            dispositioncode: item.dispositioncode ? item.dispositioncode : '',
            dispositioncodestatus: item.dispositioncodestatus ? item.dispositioncodestatus : '',
            intakeserreqstatustypekey: item.intakeserreqstatustypekey ? item.intakeserreqstatustypekey : '',
            comments: '',
            ReasonforDelay: '',
            supStatus: item.supStatus ? item.supStatus : '',
            supDisposition: item.supDisposition ? item.supDisposition : '',
            supComments: '',
            intakeMultipleDispositionDropdown: [],
            intakeMultipleDispositionStatusDropdown: [],
            supMultipleDispositionDropdown: [],
            supMultipleDispositionStatusDropdown: [],
            GroupNumber: item.GroupNumber ? item.GroupNumber : null,
            GroupReasonType: item.GroupReasonType ? item.GroupReasonType : null,
            GroupComment: item.GroupComment ? item.GroupComment : null,
            dispositioncodedesc: item.dispositioncodedesc ? item.dispositioncodedesc : '',
            dispositioncodestatusdesc: item.dispositioncodestatusdesc ? item.dispositioncodestatusdesc : '',
            restitution: item.restitution,
            isYouthIndependentLive: '',
            captureReason: ''
        };
    }

    private ifPreIntakeDispositionFn(preIntakeDisposition: any) {
        if (preIntakeDisposition) {
            this.system.status = preIntakeDisposition.systemRecmdatnStatus;
            this.system.reason = preIntakeDisposition.systemRecmdatn;
            if (preIntakeDisposition.status === 'Approved') {
                this.toShowReason = false;
            } else if (preIntakeDisposition.status === 'Rejected') {
                this.toShowReason = true;
            }
            this.preIntakeDispositionFormGroup.patchValue({
                status: preIntakeDisposition.status,
                reason: preIntakeDisposition.reason,
                comment: preIntakeDisposition.comment
            });
        }
    }

    private insufficientInfoFn(message: { message: any[]; status: boolean; No_Jurisdiction: any[]; Insufficient_Information: any[]; }) {
        if (message.status) {
            this.djsValidationMessages = message;
            this.isInsufficientInfo = true;
            const nojury = message.No_Jurisdiction.map((data, index) => {
                if (index === 0) {
                    return data;
                }
                return '<br>' + data;
            });
            const insuffinfo = message.Insufficient_Information.map((dataa, indexx) => {
                if (indexx === 0) {
                    return dataa;
                }
                return '<br>' + dataa;
            });
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
            setTimeout(() => {
                this.insufficientSetTimeoutFn(message, nojuryhtml, insufficehtml);
            }, 1000);
        } else {
            this.isInsufficientInfo = false;
            this.dispositionFormGroup.get('intakeserreqstatustypekey')?.enable();
        }
    }

    private insufficientSetTimeoutFn(message: { message: any[]; status: boolean; No_Jurisdiction: any[]; Insufficient_Information: any[]; }, nojuryhtml: string, insufficehtml: string) {
        let insfcntInfo = '' + (message.Insufficient_Information && message.Insufficient_Information.length) ? insufficehtml : '';
        const narrativestatus = (message.No_Jurisdiction && message.No_Jurisdiction.length) ? nojuryhtml : insfcntInfo ;
        this.dispositionFormGroup.patchValue({
            comments: narrativestatus
        });
    }

    ngAfterViewInit() {
        // this.isDateDelayed$.subscribe((item) => {
        //     this.generalRecievedDate = item;
        //     (<any>$('#reason-for-delay')).modal('show');
        //     // console.log('calculated time', item);
        // });
        // this.general$.subscribe((item) => {
        this.general = this.store[IntakeStoreConstants.general];
        // this.general = item;
        // });
        if (this._authService.isDJS() && !this._intakeConfig.getiseditIntake()) {
                (<any>$(':button')).prop('disabled', true); // NOSONAR
        }
    }
    ngAfterViewChecked() {
        this._changeDetect.detectChanges();
    }

    toggleDetetionStatus() {
        if (!this.detentionDescription) {
            this._alertService.warn('Please enter Detention notes.');
            return;
        }
        const request: any = {
            personid: this.store[IntakeStoreConstants.youthid],
            focuspersonstatustypekey: 'DET',
            status: '',
            intakeserviceid: null,
            intakenumber: this.intakeNumber,
            opennotes: null,
            closenotes: null
        };

        if (!this.isDetention) {
            request.status = 'Open';
            request.opennotes = this.detentionDescription;
        } else {
            request.status = 'Closed';
            request.closenotes = this.detentionDescription;
        }

        this._commonHttpService.create(request, CommonUrlConfig.EndPoint.PERSON.YOUTHSTATUS.UpdateStatus).subscribe(result => {
            this._alertService.success('Youth Status Updated successfully!');
            this._dataStoreService.setData(IntakeStoreConstants.statusChanged, true);
            $('#detention-notes').modal('hide');
        }, error => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        });
    }

    openDetentionNotesPopup() {
        this.detentionDescription = '';
        $('#detention-notes').modal('show');
    }

    setMCASPRiskLevel(risklevel: string): string {
        switch (risklevel) {
            case 'h':
            case 'H':
                return 'High';
            case 'l':
            case 'L':
                return 'Low';
            case 'm':
            case 'M':
                return 'Moderate';
            default:
                return risklevel;
        }
    }



    getAllegedOffence(offence: any) {

        if (offence) {
            const selectedAlegationId = (offence.allegationid) ? offence.allegationid : offence;
            const Offence = this.offenceCategories.find((offenceCategory) => offenceCategory.allegationid === selectedAlegationId);
            if (Offence) {
                return Offence.name;
            }
        }

        return null;
    }

    private isAgeBarExceeds() {
        if (!this.evalFields || this.evalFields.length === 0) {
            return false;
        }
        const complaint = this.evalFields[0];
        if (complaint && complaint.allegedoffense && this.offenceCategories.length > 0) {
            

            if (!complaint.age) {
                return true;
            }
            let allegationIds: any = [];
            if (complaint.allegedoffense) {
                allegationIds = complaint.allegedoffense.map(offence => offence.allegationid);
            }
            const selectedAllegations = this.offenceCategories.filter(allegation => {
                return this.checkAllegationidFoundFn(allegationIds.indexOf(allegation.allegationid))

            });

            if (selectedAllegations) {
                const filteredAges = selectedAllegations
                    .map(allegation => {
                        return this.returnAllegationDataFn(allegation);
                    })
                    .filter(age => age !== null && this.checkAgeFn(age)); 
                            return filteredAges.length > 0;
            }
        }
        return false;
    }
    // Assosiated to isAgeBarExceeds method
    private returnAllegationDataFn(allegation: any): any {
        return (allegation && allegation.agecutoff ? allegation.agecutoff : null);
    }

    private checkAllegationidFoundFn(found: any) {
        if (found === - 1) {
            return false;
        } else {
            return true;
        }
    }

    private checkAgeFn(age: any){
        if (age) {
            return true;
        } else {
            return false;
        }
    }

    private estimateSytemRecomendation() {
        this.system = {
            ageInValid: false, youthValid: false, parentsValid: false,
            jurisdictionValid: false, offenceValid: false, status: 'Accept', reason: 'Meeting criteria'
        };
        this.system.ageInValid = this.isAgeBarExceeds();
        if (this.youth) {
            this.system.youthValid = true;
        }
        if (this.mother || this.father) {
            this.system.parentsValid = true;
        }
        if (this.jurisdiction.name !== '' || !this._intakeConfig.isComplaintNeeded()) {
            this.system.jurisdictionValid = true;
        }
        if (this.evalFields && this.evalFields.length > 0) {
            // to do validate for all complaints
            if ((this.evalFields && this.evalFields[0].allegedoffense && this.evalFields[0].allegedoffense.length > 0)) {
                this.system.offenceValid = true;
            }
        } else if (!this._intakeConfig.isComplaintNeeded()) {
            this.system.offenceValid = true;
        }
        if (this.system.ageInValid) {
            this.system.status = 'Reject';
            this.system.reason = 'Not meeting age criteria';
        }
        if ((!this.system.youthValid) || (!this.system.jurisdictionValid) || (!this.system.offenceValid) || (!this.system.parentsValid)) {
            this.system.status = 'Reject';
            this.system.reason = 'Insufficient information';
        }
    }

    listAllegations() {
        const checkInput = {
            where: { intakeservreqtypeid: this.serviceTypeId },
            method: 'get',
            nolimit: true,
            order: 'name'
        };
        this._commonHttpService
            .getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.allegationsUrl + '?filter')
            .subscribe((result) => {
                this.offenceCategories = result;
                return result;
            });

    }

    setScreenToShow() {
        this.showScreen1 = false;
        this.showScreen2 = false;
        this.showScreen3 = false;
        this.showScreen4 = false;
        if (this.role.role.name === 'apcs' && this.isPreIntake) {
            this.showScreen3 = true;
        } else if (this.role.role.name === 'apcs' && !this.isPreIntake) {
            this.showScreen1 = true;
        } else if (this.role.role.name !== 'apcs') {
            this.showScreen2 = true;
        }
    }

    dispositionForm() {
        this.dispositionFormGroup = this.formBuilder.group({
            intakeserreqstatustypekey: ['', Validators.required],
            mdcasesearch: [''],
            dpscssafety: [''],
            dispositioncode: ['', Validators.required],
            statusdate: [this.date],
            duedate: [this.date],
            completiondate: [this.date],
            dateseen: null,
            financial: [''],
            seenwithin: [this.date],
            edl: [''],
            jointinvestigation: [''],
            investigationsummary: [''],
            visitinfo: [''],
            supStatus: [''],
            supDisposition: [''],
            supComments: [''],
            comments: [''],
            reason: [''],
            isDelayed: [false],
            intakeAction: ['']
        });
        this.preIntakeDispositionFormGroup = this.formBuilder.group({
            systemRecmdatnStatus: [''],
            systemRecmdatn: [''],
            status: [''],
            reason: [''],
            comment: [''],
        });
        this.dispositionDelayForm = this.formBuilder.group({
            fiveDaysDelay: [''],
            twentyFivedaysDelay: ['']
        });
        this.caseForm = this.formBuilder.group({
            caseid: [''],
            dispositionStatus: [''],
            dispositionSubStatus: [''],
            restitution: ['']
        });
    }

    onChangeMD(modal: any) {
        if(modal === 'yes') {
            this.isMD = true;
            this.isMDlabel = false;
        } else {
            this.isMD = false;
            this.isMDlabel = true;
        }
    this.setValidatorOutcomeNotes(modal);
    this._dataStoreService.setData(IntakeStoreConstants.MDCASESEARCH, modal);
    }

    onChangeDPSCS(modal: any) {
        if(modal === 'yes') {
            this.isDPSCS = true;
            this.isDPSCSlabel = false;
        } else {
            this.isDPSCS = false;
            this.isDPSCSlabel = true;
        }
        this.setValidatorOutcomeNotes(modal);
        this._dataStoreService.setData(IntakeStoreConstants.DPSCSSAFETY, modal);
    }
	setValidatorOutcomeNotes(modal: any) {
        if (this.dispositionFormGroup.controls['dpscssafety'].value === 'yes' && (this.dispositionFormGroup.controls['mdcasesearch'].value === 'yes')) {
            this.dispositionFormGroup.get('comments')?.setValidators([Validators.required]);
            this.dispositionFormGroup.get('comments')?.updateValueAndValidity();
            this.notesReq = true;
        } else {
            this.dispositionFormGroup.get('comments')?.clearValidators();
            this.dispositionFormGroup.get('comments')?.updateValueAndValidity();
            this.notesReq = false;
        }
    }
    loadIntakeRecomendations() {
        this.intakeRecomendations$ = this._commonHttpService.getArrayList({}, NewUrlConfig.EndPoint.Intake.intakeRecomendations);
    }

    loadDropdown() {
        this.statusDropdownItems$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    where: {
                        intakeservreqtypeid: this.daTypeSubType,
                        servicerequestsubtypeid: this.daTypeSubType
                    },
                    method: 'get'
                }),
                'Intakeservicerequestdispositioncodes/getstatuslist?filter'
            ).pipe(
            map((result) => {
                this.dispositionList = result;
                return this.returnResultFn(result);
            }));
    }
    // Assosiated with loadDropdown method
    private returnResultFn(result: any[]): DropdownModel[] {
        return result.map(
            (res) => new DropdownModel({
                text: res.description,
                value: res.intakeserreqstatustypekey
            })
        );
    }

    onChangeTaskStatus(statusId: any) {
        if (this.createdCase?.length > 0) {
            this.createdCase.forEach((item: any) => {
                item.DAStatus = statusId;
                item.intakeMultipleDispositionDropdown = [];
                if (item.issubtypekey) {
                    item.DasubtypeKey = null;
                }

                const url = { url: this.getdispositionlisturl };
                if (this.isInsufficientInfo) {
                    url.url = 'intakeservicerequestdispositioncodes/getclosecasestatusdisposition?filter';
                }

                this._commonHttpService
                    .getArrayList(
                        new PaginationRequest({
                            nolimit: true,
                            where: {
                                intakeservreqtypeid: item.DaTypeKey,
                                servicerequestsubtypeid: item.DasubtypeKey ? item.DasubtypeKey : item.DaTypeKey,
                                statuskey: statusId
                            },
                            method: 'get'
                        }),
                        url.url
                    )
                    .subscribe((result) => {
                        if (result?.length > 0) {
                            this.dispositionDropDown = this.returnDispositionlistResFn(result);
                        }
                    });
            });
        }
    }

    supPreIntakeStatusSelected(val: Event, event: number) {
        const id = (val.target as HTMLInputElement).value;
        if (event === 1) {
            this._dataStoreService.setData(IntakeStoreConstants.preIntakeSupDicision, id);
            if (id === 'Approved') {
                this.toShowReason = false;
            } else if (id === 'Rejected') {
                this.toShowReason = true;
            }
            this._commonHttpService
                .getArrayList(
                    new PaginationRequest({
                        nolimit: true,
                        where: {
                            intakeservreqtypeid: this.serviceTypeId,
                            servicerequestsubtypeid: this.serviceTypeId,
                            statuskey: id
                        },
                        method: 'get'
                    }),
                    this.getdispositionlisturl
                )
                .subscribe((result) => {
                    this.supMultipleDispositionDropdown = this.returnDispositionlistResFn(result);
                    this.dispositionDropDown = this.supMultipleDispositionDropdown;
                });
        } else if (event === 2) { /* do something */
        } else if (event === 3) { /* do something */}
        this.preIntakeDispositionFormGroup.patchValue({
            systemRecmdatn: this.system.reason,
            systemRecmdatnStatus: this.system.status
        });
        this._dataStoreService.setData(IntakeStoreConstants.preIntakeDisposition, this.preIntakeDispositionFormGroup.value);
    }

    supOnChangeTaskStatus(id: any) {
        this.changeDisp();
        this.createdCase.forEach((item: any) => {
            item.DAStatus = id;
            item.supMultipleDispositionDropdown = [];
            if (id === 'Approved' && !this.isIntakeFromSupervisor) {
                item.supDispositiondesc = item.dispositioncodedesc;
                item.supDisposition = item.dispositioncode;
                item.DAsubdispositiondesc = item.dispositioncodestatusdesc;
                item.supRestitution = item.restitution;
                item.DAsubdisposition = item.dispositioncodestatus;
                item.DADisposition = item.dispositioncode;
                item.reason = 'From Approval';
            } else {
                this._commonHttpService
                    .getArrayList(
                        new PaginationRequest({
                            nolimit: true,
                            where: {
                                intakeservreqtypeid: item.DaTypeKey,
                                servicerequestsubtypeid: item.DasubtypeKey,
                                statuskey: id
                            },
                            method: 'get'
                        }),
                        this.getdispositionlisturl
                    )
                    .subscribe((result) => {
                        this.dispositionDropDown = this.returnDispositionlistResFn(result);
                        if (id === 'Reopen') {
                            const nmi = this.dispositionDropDown[0];
                            item.supDispositiondesc = nmi.text;
                            item.supDisposition = nmi.value;
                            item.DAsubdispositiondesc = '';
                            item.supRestitution = null;
                            item.DAsubdisposition = item.supDispositiondesc;
                        }
                    });
            }
        });
    }

    private returnDispositionlistResFn(result: any[]): DropdownModel[] {
        return result.map(
            (res) => new DropdownModel({
                text: res.description,
                value: res.dispositioncode,
                additionalProperty: res.servicerequesttypeconfigiddispostionid
            })
        );
    }

    onChangeSupDispoType(daSubtypeval: any) {
        const daSubtype = daSubtypeval.value;
        const isLawEnforcement = this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.REFERRAL.LAW_ENFORCEMENT); 
                                                                        // Peace Order Request Authorized should be removed on new disposition code.
        if (daSubtype === 'IAD' && isLawEnforcement) {
            this.hasRestitution = true;
        } else {
            this.hasRestitution = false;
        }
        if (daSubtype === 'RIS') {
            this.enableTextarea = true;
            this.caseForm.patchValue({ dispositionSubStatus: [''] });
        } else {
            this.createdCase.forEach((item) => {
                item.supMultipleDispositionStatusDropdown = [];
                this._commonHttpService
                    .getArrayList(
                        new PaginationRequest({
                            nolimit: true,
                            where: {
                                servicerequesttypeconfigiddispostionid: daSubtypeval.additionalProperty
                            },
                            method: 'get'
                        }),
                        'daconfig/servicerequesttypeconfigdispositioncode/getsubdispositionlist?filter'
                    )
                    .subscribe((result) => {
                        this.supDispositionDropDown = result.map(
                            (res) =>
                                new DropdownModel({
                                    text: res.value_text,
                                    value: res.ref_key,
                                    additionalProperty: res.servicerequestdispositionsubtypeconfigid
                                })
                        );
                    });
            });
            this.enableTextarea = false;
            this.caseForm.patchValue({ dispositionSubStatus: ['null'] });
        }
    }

    removeSchedulePayments() {
        this.removePaymentSchedules = true;
        this.SaveCaseDetails(this.caseForm.getRawValue());
        this._dataStoreService.setData(IntakeStoreConstants.paymentSchedule, []);
        (<any>$('#confirm-remove-payments')).modal('hide'); // NOSONAR
    }

    SaveCaseDetails(caseform: any) {
        const caseid = caseform.caseid;
        let confirmRemovePaymentSchedules: any = false;
        this.createdCase.forEach((item) => {
            if (item.ServiceRequestNumber === caseid) {
                if (this.supervisorUser) {
                    confirmRemovePaymentSchedules = item.restitution && !caseform.restitution && !this.removePaymentSchedules;
                    if (confirmRemovePaymentSchedules) {
                        (<any>$('#confirm-remove-payments')).modal('show'); // NOSONAR
                        return;
                    }
                    item.DADisposition = caseform.dispositionStatus.value;
                    item.supDisposition = caseform.dispositionStatus.value;
                    item.supDispositiondesc = caseform.dispositionStatus.text;
                    item.supRestitution = caseform.restitution;
                    this.ifSupervisorUserAndRISCheckFn(caseform,item);
                    
                } else {
                    item.DADisposition = caseform.dispositionStatus.value;
                    item.dispositioncode = caseform.dispositionStatus.value;
                    item.dispositioncodedesc = caseform.dispositionStatus.text;
                    item.restitution = caseform.restitution;
                    this.ElseSupervisorUserAndRISCheckFn(caseform, item);
                }

            }
        });
        if (!confirmRemovePaymentSchedules) {
            if (caseform.restitution) {
                const URL = '/pages/newintake/my-newintake/payment-schedule';
                this._router.navigate([URL]);
            }
            this.changeDisp();
            this.caseForm.reset();
        }
        this.removePaymentSchedules = false;
        this.hasRestitution = false;
    }

    private ElseSupervisorUserAndRISCheckFn(caseform: any, item: DispostionOutput) {
        if (caseform.dispositionStatus.value === 'RIS') {
            item.dispositioncodestatus = caseform.dispositionSubStatus;
            item.dispositioncodestatusdesc = caseform.dispositionSubStatus;
        } else {
            item.dispositioncodestatus = caseform.dispositionSubStatus.additionalProperty;
            item.dispositioncodestatusdesc = caseform.dispositionSubStatus.text;
        }
    }

    private ifSupervisorUserAndRISCheckFn(caseform: any, item: DispostionOutput) {
        if (caseform.dispositionStatus.value === 'RIS') {
            item.DAsubnotes = caseform.dispositionSubStatus;
        } else {
            item.DAsubdisposition = caseform.dispositionSubStatus.additionalProperty;
            item.DAsubdispositiondesc = caseform.dispositionSubStatus.text;
        }
    }

    openNotes(textval: any) {
        this.completionNotes = textval;
    }

    changeDisp() {
        if (this.createdCase && this.createdCase.length > 0) {
            this.createdCase.forEach((item) => {
                item.intakeserreqstatustypekey = this.returnDispChangeIntakeserreqstatustypekeyFn();
                item.comments = this.returnDispChangeCommentsFn();
                item.intakeAction = this.returnDispChangeIntakeActionFn();
                item.supStatus = this.returnDispChangeSupStatusFn();
                item.supComments = this.returnDispChangeSupCommentsFn();
                item.reason = this.returnDispChangeReasonFn();
            });
            if (this.isInsufficientInfo) {
                if (this.createdCase && this.createdCase.length > 0) {
                    this.createdCase.forEach(data => {
                        data.comments = this.returnDispChangeCommentsFn();
                        data.dispositioncodedesc = 'Insufficient Information';
                        data.dispositioncode = 'ISI';
                        data.DADisposition = 'ISI';
                        data.supDisposition = 'ISI';
                        data.supStatus = 'Closed';
                        data.DAStatus = 'Closed';
                        data.intakeserreqstatustypekey = this.intakesrstatusuuid; //SonarQube - removed the self assignments
                    });
                }
                this._dataStoreService.setData(IntakeStoreConstants.insufficientInfoNarrative, this.dispositionFormGroup.value.comments);
            }
            this._dataStoreService.setData(IntakeStoreConstants.disposition, this.createdCase);
        }
    }
    private returnDispChangeReasonFn(): string {
        return this.dispositionFormGroup.value.reason ? this.dispositionFormGroup.value.reason : '';
    }

    private returnDispChangeSupCommentsFn(): string {
        return this.dispositionFormGroup.value.supComments ? this.dispositionFormGroup.value.supComments : '';
    }

    private returnDispChangeSupStatusFn(): string {
        return this.dispositionFormGroup.value.supStatus ? this.dispositionFormGroup.value.supStatus : '';
    }

    private returnDispChangeIntakeActionFn(): string {
        return this.dispositionFormGroup.value.intakeAction ? this.dispositionFormGroup.value.intakeAction : '';
    }

    private returnDispChangeCommentsFn(): string {
        return this.dispositionFormGroup.value.comments ? this.dispositionFormGroup.value.comments : '';
    }

    private returnDispChangeIntakeserreqstatustypekeyFn(): string {
        return this.dispositionFormGroup.value.intakeserreqstatustypekey ? this.dispositionFormGroup.value.intakeserreqstatustypekey : '';
    }

    enableReasonfordelay() {
        if (this.timeReceived === 'Overdue') {
            this.dispositionFormGroup.patchValue({ isDelayed: true });
            this.showReason = true;
            this.dispositionFormGroup.get('reason')?.setValidators([Validators.required]);
            this.dispositionFormGroup.get('reason')?.updateValueAndValidity();
        } else {
            this.dispositionFormGroup.get('reason')?.clearValidators();
            this.dispositionFormGroup.get('reason')?.updateValueAndValidity();
            this.dispositionFormGroup.patchValue({ isDelayed: false });
        }
    }
    submitDelayForm() {
        (<any>$('#reason-for-delay')).modal('hide'); // NOSONAR
    }

    getPersonRole(person: InvolvedPerson) {
        if (person.RelationshiptoRA === 'mother') {
            this.mother = person;
        } else if (person.RelationshiptoRA === 'father') {
            this.father = person;
        } else if (person.Role === 'Youth') {
            this.youth = person;
        }

    }

    loadIntaker(pageNumber: number) {
        const source = this._commonHttpService
            .getPagedArrayList(
                {
                    limit: this.paginationInfo.pageSize,
                    // order: this.paginationInfo.sortBy,
                    page: pageNumber,
                    // count: this.paginationInfo.total,
                    // where: this.involvedPersonSearch,
                    method: 'get'
                },
                'Intakedastagings/getIntakeUsers?filter'
            ).pipe(
            map((result) => {
                this.intakeWorkerList = result.data;
                if (this.intakeWorkerId) {
                    if (this.getIntakeWorkerName()) {
                        this.intakeWorkerName = this.getIntakeWorkerName().username;
                    }
                }

                return {
                    data: result.data,
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize
                };
            }),
            share(),);
        this.intakersList$ = source.pipe(pluck('data'));
        if (pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.loadIntaker(this.paginationInfo.pageNumber);
    }

    intakerChoosen(intaker: RoutingUser) {
        this.intakerinMind = intaker;
    }

    selectIntaker() {
        this.intakeWorkerId = this.intakerinMind.userid;
        this.updateIntakeWorkerInAllAppointments(this.intakeWorkerId);
    }

    assignIntaker(modal: any) {
        if (this.intakeWorkerId) {
            this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        where: {
                            appeventcode: modal,
                            intakenumber: this.intakeNumber,
                            assigneduserid: this.intakeWorkerId
                        },
                        method: 'post'
                    }),
                    'Intakedastagings/assignintake'
                )
                .subscribe((result: any) => {
                    this._alertService.success('Intake assigned successfully!');
                    this.closePopup();
                    const dashboardURL = '/pages/cjams-dashboard';
                    this._router.navigate([dashboardURL]);
                });
        } else {
            this._alertService.warn('Please select a intake worker');
        }
    }

    closePopup() {
        (<any>$('#list-intank')).modal('hide'); // NOSONAR
    }

    getjurisdiction(id: string) {
        if (id && id !== '') {
            this._commonHttpService.create({
                where: { state: 'MD', countyid: id },
                order: 'countyname asc', nolimit: true
            }, NewUrlConfig.EndPoint.Intake.MDCountryListUrl).subscribe((data) => {
                if (data && data.length > 0) {
                    this.jurisdiction = { id: data[0].countyid, name: data[0].countyname };
                    this.estimateSytemRecomendation();
                }
            });
        }
        return 'adf';
    }

    // getDetentionStatusFromAssessement() {
    //     this._commonHttpService.getArrayList({
    //         where: { intakenumber: this.intakeNumber, assessmentname: 'intakeDetentionRiskAssessmentInstrument', fieldname: 'SD' },
    //         order: 'countyname asc', nolimit: true, method: 'get'
    //     }, CommonUrlConfig.EndPoint.PERSON.YOUTHSTATUS.AssessmentValue + '?filter').subscribe((data) => {
    //         if (data) {
    //             // this.getDetainStatus = data;
    //         }
    //     });
    // }

    getIntakeWorkerName() {
        const intakeWorker = this.intakeWorkerList.find(iw => iw.userid === this.intakeWorkerId);
        if (intakeWorker) {
            return intakeWorker;
        }
        return null;
    }

    updateIntakeWorkerInAllAppointments(intakeWorkerId: any) {
        const appointments = this.store[IntakeStoreConstants.intakeappointment];
        if (appointments) {
            appointments.forEach((item: { intakeWorkerId: any; }) => {
                item.intakeWorkerId = intakeWorkerId;
            });
        }
        this._dataStoreService.setData(IntakeStoreConstants.intakeappointment, appointments);
        this._dataStoreService.setData(IntakeStoreConstants.assingedIntakeWokerId, intakeWorkerId);
    }

    checkDetainStatusFromDRAI() {
        if (this.assmentScores && this.assmentScores.DRAI && (this.assmentScores.DRAI.AD === 'Detain' || this.assmentScores.DRAI.AD === 'Detention Alternative')) {
            if (this.assmentScores.DRAI.AD === 'Detain') {
                this.assigndetbutton = 'Assign Detention';
            } else if (this.assmentScores.DRAI.AD === 'Detention Alternative') {
                this.assigndetbutton = 'Assign ATD';
                this._dropDownService.getDropownsByTable('ATDPlacementType').subscribe((data) => {
                    this.atdDetentionTypesList = data.map((res) => {
                        return new DropdownModel({
                            text: res.description,
                            value: res.ref_key
                        });
                    });
                });
            }
            const prevdetainstatus = this.store[IntakeStoreConstants.detentionOpened];
            if (prevdetainstatus && prevdetainstatus.detained) {
                this.getDetainStatus = true;
                this.disableDetainbutton = true;
                this.reasonDisableDetainbutton = 'Assigned';
            } else {
                this.getDetainStatus = true;
                this.disableDetainbutton = false;
                this.getResedentialStatus();
            }
        } else {
            this.getDetainStatus = false;
        }
    }

    getResedentialStatus() {
        this._commonHttpService.getArrayList(
            { where: { personid: this.youth?.Pid }, nolimit: true, method: 'get' },
            'placement/placementresidential?filter').subscribe(result => {
                if (result[0].residentialexists) {
                    this.disableDetainbutton = true;
                    this.reasonDisableDetainbutton = 'Youth is already in Residential Placement';
                } else {
                    this.disableDetainbutton = false;
                    this.reasonDisableDetainbutton = '';
                }
            });
    }

    assignDetentionPopup() {
        if (this.assmentScores.DRAI.AD !== 'Detain') {
            (<any>$('#ATDdetention-dropdown')).modal('show'); // NOSONAR
        } else {
            this.AssignDetention();
        }
    }

    AssignDetention() {
        const request = {
            intakenumber: this.intakeNumber,
            placementworkertype: this.assmentScores.DRAI.AD === 'Detain' ? 'DET' : 'ADT'
        };
        this._commonHttpService.create(request, CommonUrlConfig.EndPoint.PERSON.YOUTHSTATUS.AssignDetention).subscribe(result => {
            this._dataStoreService.setData(IntakeStoreConstants.detentionOpened,
                { detained: true, atdDetentionType: this.atdDetentionType});
            this._alertService.success('Intake Assigned to Placement successfully!');
            this.disableDetainbutton = true;
            this.reasonDisableDetainbutton = 'Assigned';
            const element: HTMLElement | null = document.getElementById('saveasdraftbutton');
            element?.click();
        }, error => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        });
    }

    canDisplayPager(pagination: any): boolean {
        return pagination?.canDisplayPager ?? false;
    }    
}

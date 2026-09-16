
import {of as observableOf, fromEvent as observableFromEvent,  Observable ,  Subscription } from 'rxjs';

import {map} from 'rxjs/operators';
import {
    AfterViewInit,
    ChangeDetectorRef,
    Component,
    Injector,
    Input,
    NgZone,
    OnDestroy,
    OnInit,
    ViewChild,
    ViewEncapsulation,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators, AbstractControl, FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';
import { ControlUtils } from '../../../../@core/common/control-utils';

import { AppUser } from '../../../../@core/entities/authDataModel';
import { DynamicObject, DropdownModel } from '../../../../@core/entities/common.entities';
import { REGEX } from '../../../../@core/entities/constants';
import { DataStoreService, GenericService, CommonDropdownsService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { AuthService } from '../../../../@core/services/auth.service';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { ActionContext } from '../../../../shared/modules/web-speech/shared/model/strategy/action-context';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { NewUrlConfig } from '../../newintake-url.config';
import { AttachmentUpload, ResourcePermission, ReviewStatus } from '../_entities/newintakeModel';
import { IntakeStoreConstants, MyNewintakeConstants } from '../my-newintake.constants';

import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { IntakeUtils } from '../../../_utils/intake-utils.service';
import { IntakeConfigService } from '../intake-config.service';
import moment from 'moment';
import { AppConstants } from '../../../../@core/common/constants';
import { QuillEditorComponent } from 'ngx-quill';
import { PopoverDirective } from 'ngx-bootstrap/popover';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { TransferHistoryApprovedService } from '../../../../shared/services/transfer-history-approved.service';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';
import { HttpService } from '../../../../@core/services/http.service';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'newintake-narrative',
    templateUrl: './newintake-narrative.component.html',
    styleUrls: ['./newintake-narrative.component.scss', '../../../../../styles/trumbowyg.scss'],
    encapsulation: ViewEncapsulation.None,
    standalone: false
})
export class NewintakeNarrativeComponent implements OnInit, AfterViewInit, OnDestroy {
    subscription!: Subscription;
    @ViewChild('quill') divView!: QuillEditorComponent;
    // @Input()
    // narrativeInputSubject$ = new Subject<Narrative[]>();
    // @Input()
    // intakeNumberNarrative: string;
    // @Input()
    // narrativeOutputSubject$ = new Subject<Narrative>();
    // @Input()
    // draftId: string;
    // @Input()
    // finalNarrativeText$ = new Subject<string>();
    @Input()
    // reviewStatus$ = new Subject<string>();
    // tslint:disable-next-line:no-input-rename
    // @Input('purposeStatus')
    // purposeStatus$ = new Subject<string>();
    // @Input()
    // purposeSubject$: Subject<string>;
    // @Input()
    // zipCodeSubject$: Subject<number>;
    // @Input()
    // agencyType$: Subject<string>;
    // @Input()
    // general$: Subject<General>;
    CountyValuesDropdownItems$!: Observable<DropdownModel[]>;
    stateValuesDropdownItems$!: Observable<DropdownModel[]>;
    offenceLocation!: number;
    audioCollection: AttachmentUpload[] = [];
    intakeNarrativeForm!: FormGroup;
    addIdentifiedFormGroup!: FormGroup;
    speechRecogninitionOn: boolean;
    isCPRPurposeSelected!: boolean;
    speechData: string;
    notification!: string | null;
    finalTranscript = '';
    recognizing = false;
    roleName!: AppUser;
    addressAnalysis: any[] = [];
    actionContext: ActionContext = new ActionContext();
    currentLanguage!: string;
    firstNameControlName!: AbstractControl;
    middleNameControlName!: AbstractControl;
    lastNameControlName!: AbstractControl;
    ZipCodeControlName!: AbstractControl;
    suggestedAddress$!: Observable<any[]>;
    maxDate = new Date();
    tooltip!: string | undefined | null;
    @ViewChild('myPopover')
    myPopover!: PopoverDirective;
    @ViewChild('clearancePopover')
    clearancePopover!: PopoverDirective;
    showRequesterDetails!: boolean;
    agencyType!: string;
    showZipCode = true;
    selectedPurpose!: string;
    stateId!: string;
    Countydropdown!: boolean;
    reviewstatus: ReviewStatus = new ReviewStatus();
    isNarativeDisabled = false;
   /*  quillToolbar: {
        toolbar: (
            | string[]
            | { header: number }[]
            | { list: string }[]
            | { script: string }[]
            | { indent: string }[]
            | { direction: string }[]
            | { size: (string | boolean)[] }[]
            | { header: (number | boolean)[] }[]
            | ({ color: any[]; background?: undefined } | { background: any[]; color?: undefined })[]
            | { font: any[] }[]
            | { align: any[] }[])[];
    }; */
    quillToolbar: any= AppConstants.NARRATIVE_TEMP.TOOLBAR_CONFIG;
    store: DynamicObject;
    dataStroeSubscription!: Subscription;
    baseUrl!: string;
    addedIdentifiedPersons: any;
    agency!: string;
    genderList: any[] = [];
    narrativeCont: any;
    cpsHistoryCont: any;
    reporterRoles: any[] = [];
    currentNarrativeText: any;
    currentCPSHistoryText: any;
    narrativeUpdatedDate!: Date;
    currentStatus!: string;
    isClosed!: boolean;
    formchangelistener!: Subscription;
    personAgeCheck = 0; 
    substanceclassDropDownItems$!: Observable<any[]>;
    babysubstanceclassDropDownItems$!: Observable<any[]>;
    babySubstanceOther = false;
     babysubstanceList = ['BOTH', 'BPD', 'BPCP', 'BMTD', 'BMJA', 'BHOI', 'BESY', 'BCOC', 'BBS', 'BAS', 'FASD', 'BTN', 'BTNR', 'BENZO', 'OPIA']; 
     qproleDropdownItems$!:  Observable<any[]>;
    disableIntakeServicesType =false;
    navigatetonarrative: any;
    intakenumber!: string;
    submisionHistory: any;
    returntoworker!: boolean;
    showaddendumnarrative: any;
    nonNarrativeId = '#divNonEditNarrative';
    narrativeId = '#divEditNarrative';
    addendumNarrativeUpdatedAt!: Date;

    private readonly formBuilder: FormBuilder;
    private readonly _commonDropdownService: CommonDropdownsService;
    private readonly speechRecognizer: SpeechRecognizerService;
    private readonly _alertService: AlertService;
    private readonly _changeDetect: ChangeDetectorRef;
    private readonly _uploadService: NgxfUploaderService;
    private readonly _authService: AuthService;
    private readonly route: ActivatedRoute;
    private readonly _speechRecognitionService: SpeechRecognitionService;
    private readonly zone: NgZone;
    private readonly _storeService: DataStoreService;
    private readonly intakeUtils: IntakeUtils;
    private readonly _intakeConfig: IntakeConfigService;
    private readonly _commonHttpService: CommonHttpService;
    private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;

    constructor(
        private readonly injector: Injector,
        private readonly _resourceService: GenericService<ResourcePermission>,
        private readonly _router: Router,
        private readonly _http: HttpService,
    ) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
        this.speechRecognizer = this.injector.get<SpeechRecognizerService>(SpeechRecognizerService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this.zone = this.injector.get<NgZone>(NgZone);
        this._storeService = this.injector.get<DataStoreService>(DataStoreService);
        this.intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
        this._intakeConfig = this.injector.get<IntakeConfigService>(IntakeConfigService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._transferHistoryApprovedService = this.injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);

        this.speechRecogninitionOn = false;
        this.speechData = '';
        this.store = this._storeService.getCurrentStore();
    }

    ngOnInit() {
        this.agency = this._authService.getAgencyName();
        this.narrativeForm();
        this.currentLanguage = 'en-US';
        this.speechRecognizer.initialize(this.currentLanguage);
        this.notification = null;
        this.getStateDropdown();
        this.getGenderList();
        this.getReporterRolesList();
        this.getSupervisorApprovalInfo();
        this.roleName = this._authService.getCurrentUser();
        $(this.nonNarrativeId).hide();
        $(this.narrativeId).show();
        const reviewStatus = this.store[IntakeStoreConstants.reviewStatus];
        if (this.roleName.role.name === 'apcs' && (reviewStatus === 'Review' || reviewStatus === 'Reopen' || reviewStatus === 'Accepted' || reviewStatus === 'Closed')) {
            this.disableFormBasedOnStatusFn();
        }

        const narrative = this.store[IntakeStoreConstants.addNarrative] ? this.store[IntakeStoreConstants.addNarrative] : {};
        if(this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL)) {
            if (narrative.RefuseToShareZip === true) {
                this.intakeNarrativeForm.controls['ZipCode'].clearValidators();
            } else {
                this.intakeNarrativeForm.controls['ZipCode'].setValidators([Validators.required]);
            }   
        }

        this.countryCheckFn();

        this.intakeNarrativeForm.get('IsUnknownReporter')?.valueChanges.subscribe((IsUnknownReporter) => {
            this._storeService.setData(IntakeStoreConstants.isUnknownReporter, IsUnknownReporter);
        });
        this.intakeNarrativeForm.get('addendumNarrative')?.valueChanges.subscribe((addendumNarrative) => {
            this._storeService.setData(IntakeStoreConstants.addendumNarrative, addendumNarrative);
        });

        this.agencyType = this.store[IntakeStoreConstants.agency];
        const general = this.store[IntakeStoreConstants.general];
        if (general) {
            this.intakeNarrativeForm.patchValue({
                offenselocation: general.offenselocation
            });
        }

        this.firstNameControlName = this.intakeNarrativeForm.get('Firstname') as AbstractControl;
        this.middleNameControlName = this.intakeNarrativeForm.get('Middlename') as AbstractControl;
        this.lastNameControlName = this.intakeNarrativeForm.get('Lastname') as AbstractControl;
        this.ZipCodeControlName = this.intakeNarrativeForm.get('ZipCode') as AbstractControl;
        if (this.store[IntakeStoreConstants.intakenumber] !== '0') {
            this.ifCurrentStoreDataCheckFn();
        }

        this.listenForPurposeChanges();
        this.detectFormValueChanges();

        this.getquickperson();
        this.qproleDropdownItems$ = this._commonDropdownService.getPickListByName('cpsroles');
        this.substanceclassDropDownItems$ = this._commonDropdownService.getPickListByName('substancetype');
        this.babysubstanceclassDropDownItems$ = this.substanceclassDropDownItems$.pipe(map(arr =>  
          arr.filter(item => this.babysubstanceList.includes(item.ref_key))
        ));
        this.setupChangeSubscribers();
        this.drugexposednewbornflagFn();

        this.currentStatus = this._storeService.getData(IntakeStoreConstants.INTAKE_STATUS);
        const navigatetonarrative=this._storeService.getData(IntakeStoreConstants.navigatetonarrative);
        if(navigatetonarrative){
        window.location.reload();
        }
        this.currentStatusCheckFn();

        this.subscription = observableFromEvent(document, 'keypress').subscribe(_e => {
            this._storeService.setData(IntakeStoreConstants.addNarrative, this.intakeNarrativeForm.getRawValue());
        });

        if(this._transferHistoryApprovedService.getTrasferHistory()) {
            this.isClosed = true;
            this.intakeNarrativeForm.disable();
            this.addIdentifiedFormGroup.disable();
        }
     setTimeout(() => this.onNarrativeSelectionChanged(), 3000);
    }

    private drugexposednewbornflagFn() {
        this.addIdentifiedFormGroup.get('drugexposednewbornflag')?.valueChanges.subscribe(
            changeFlag => {
                if (changeFlag) {
                    this.addIdentifiedFormGroup.controls['drugexposedtypekey'].setValidators([Validators.required]);
                    this.addIdentifiedFormGroup.controls['drugexposedtypekey'].updateValueAndValidity();
                } else {
                    this.addIdentifiedFormGroup.controls['drugexposedtypekey'].clearValidators();
                    this.addIdentifiedFormGroup.controls['drugexposedtypekey'].updateValueAndValidity();
                }
            });
    }

    private currentStatusCheckFn() {
        if (!this.navigatetonarrative && this.currentStatus === 'Closed' || this._storeService.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)) {
            this.intakeNarrativeForm.disable();
            this.addIdentifiedFormGroup.disable();
            this.isClosed = true;
        } else {
            this.intakeNarrativeForm.enable();
            this.addIdentifiedFormGroup.enable();
            this.isClosed = false;
        }
    }

    private ifCurrentStoreDataCheckFn() {
        this.narrativeTooltip();
        const narrative = this.store[IntakeStoreConstants.addNarrative] ? this.store[IntakeStoreConstants.addNarrative] : {};

        let isIncidentDateRequired = this._storeService.getData('NarrativeDateChange');
        if(isIncidentDateRequired?.isUpdated) {
            narrative.incidentdate = '';
        } else {
            narrative.incidentdate = narrative.incidentdate ? new Date(narrative.incidentdate) : '';
        }
        this._storeService.setData('NarrativeDateChange', { isUpdated: false });
        this.intakeNarrativeForm.patchValue(narrative);
        if (narrative.requesterstate) {
            this.loadCounty(narrative.requesterstate);
        }
        this.narrativeCont = narrative.Narrative;
        this.cpsHistoryCont = narrative.cpsHistoryClearance;
        this.narrativeUpdatedDate = narrative.narrativeUpdatedDate ? narrative.narrativeUpdatedDate : null;
        this.addendumNarrativeUpdatedAt =narrative.addendumNarrativeUpdatedAt ? narrative.addendumNarrativeUpdatedAt : null;
        if (this.narrativeCont) {
            this.narrativeCont = this.narrativeCont.replace(/''/g, `'`);
            this.intakeNarrativeForm.patchValue({
                Narrative: this.narrativeCont
            });
        }
        if (this.cpsHistoryCont) {
            this._storeService.setData('isCPSHistoryClearanceChecked', true);
            this.cpsHistoryCont = this.cpsHistoryCont.replace(/''/g, `'`);
            this.intakeNarrativeForm.patchValue({
                cpsHistoryClearance: this.cpsHistoryCont
            });
        } else {
            this._storeService.setData('isCPSHistoryClearanceChecked', false);
        }
        if (narrative.IsUnknownReporter === true) {
            this.firstNameControlName.disable();
            this.middleNameControlName.disable();
            this.lastNameControlName.disable();
        }
        if (narrative.RefuseToShareZip === true) {
            this.ZipCodeControlName.disable();
        }
        this._authService.setIntakeReadOnly([this.intakeNarrativeForm]);
    }

    private countryCheckFn() {
        this.intakeNarrativeForm.get('requesterstate')?.valueChanges.subscribe((result) => {
            if (result === 'MD') {
                this.Countydropdown = true;
            } else {
                this.Countydropdown = false;
            }
        });
        this.intakeNarrativeForm.get('offenselocation')?.valueChanges.subscribe((zipCode) => {

            this._storeService.setData(IntakeStoreConstants.zipcode, zipCode);
        });
    }

    private disableFormBasedOnStatusFn() {
        $(this.nonNarrativeId).show();
        $(this.narrativeId).hide();
        this.intakeNarrativeForm.controls.IsAnonymousReporter.disable();
        this.intakeNarrativeForm.controls.IsUnknownReporter.disable();
        this.intakeNarrativeForm.controls.Firstname.disable();
        this.intakeNarrativeForm.controls.Middlename.disable();
        this.intakeNarrativeForm.controls.Lastname.disable();
        this.intakeNarrativeForm.controls.PhoneNumber.disable();
        this.intakeNarrativeForm.controls.PhoneNumberExt.disable();
        this.intakeNarrativeForm.controls.ZipCode.disable();
        this.intakeNarrativeForm.controls.RefuseToShareZip.disable();
        this.intakeNarrativeForm.controls.offenselocation.disable();
        this.intakeNarrativeForm.controls.isacknowledgementletter.disable();
    }

    listenForPurposeChanges() {
        this.dataStroeSubscription = this._storeService.currentStore.subscribe(store => {

            if (store[IntakeStoreConstants.purposeSelected]) {

                const purposeSelected = store[IntakeStoreConstants.purposeSelected];
                const storePurposeId = purposeSelected.value;
                if (storePurposeId !== this.selectedPurpose) {
                    this.handleIfNotEqualToSelectedPurposeFn(storePurposeId);

                }
            }

        });
    }
    // Assosiated with listenForPurposeChanges method
    private handleIfNotEqualToSelectedPurposeFn(storePurposeId: any) {
        this.selectedPurpose = storePurposeId;
        // below line is resetting anonymous reporter and unknown reporter on page init
        // this.resetAnoymousorUnknownUser();
        if (this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.CHILD_PROTECTION_SERVICES)) {
            this.ZipCodeControlName.disable();
            this.isCPRPurposeSelected = true;
        } else {
            this.isCPRPurposeSelected = false;
        }
        if (this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL)) {
            this.showRequesterDeteails();
        } else {
            this.showRequesterDetails = false;
        }
        if (this._intakeConfig.selectedPurposeIs(MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL)
        ) {
            this.showZipCode = false;
        } else {
            this.showZipCode = true;
        }
    }

    showRequesterDeteails(): void{
        this.showRequesterDetails = true;
        this.firstNameControlName.enable();
        this.middleNameControlName.enable();
        this.lastNameControlName.enable();
        this.ZipCodeControlName.enable();
        this.intakeNarrativeForm.patchValue({IsUnknownReporter : false});
    }

        detectFormValueChanges() {
        this.formchangelistener = this.intakeNarrativeForm.valueChanges.subscribe(() => {
            this.intakeNarrativeForm.get('Narrative')?.valueChanges.subscribe((text) => { this.speechData = text; });

            ControlUtils.validateAllFormFields(this.intakeNarrativeForm);
            this._storeService.setData(IntakeStoreConstants.addNarrative, this.intakeNarrativeForm.getRawValue());

        });
    }
    ngAfterViewInit() {
        const self = this;
        this.zone.run(() => {
            $('.trumbowyg-textarea')
                .trumbowyg()
                .on('tbwfocus', function () {
                    self.openPopover();
                });
        });
    }
    loadCounty(state: any) {
        this._commonDropdownService.getPickListByMdmcode(state).subscribe(countyList => {
          this.CountyValuesDropdownItems$ = observableOf(countyList);
        });
      }
    getCountyDropdown() {
        this.CountyValuesDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        activeflag: '1',
                        mdmcode: {"like": "MD~%25","options":"i"}
                    },
                    order: 'countyname asc',
                    method: 'get',
                    nolimit: true
                },
                'admin/county?filter'
            ).pipe(
            map(result => {
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyname
                        })
                );
            }));
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
                            value: res.stateabbr
                        })
                );
            }));
    }
    openPopover() {
        this.myPopover.show();
    }
    closePopover() {
        this.myPopover.hide();
    }
    openClearancePopover() {
        this.clearancePopover.show();
    }
    closeClearancePopover() {
        this.clearancePopover.hide();
    }
    private narrativeForm() {
        this.intakeNarrativeForm = this.formBuilder.group({
            Firstname: ['', [Validators.compose([Validators.pattern('^[^0-9]*$')])]],
            Middlename: [''],
            Lastname: ['', [Validators.compose([Validators.pattern('^[^0-9]*$')])]],
            // Lastname: ['',[Validators.compose([Validators.pattern('^[a-zA-Z]*$')])]],
            // Since this has been defined as Text in database
            Narrative: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            cpsHistoryClearance: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR, Validators.maxLength(6000)]],
            Role: ['Rep'],
            RoleName: '',
            IsAnonymousReporter: false,
            IsUnknownReporter: false,
            PhoneNumber: [''],
            PhoneNumberExt: [''],
            requesteraddress1: [null, [Validators.maxLength(100)]],
            requesteraddress2: [null],
            requestercity: [null],
            requesterstate: [null],
            requestercounty: [null],
            requestercountyname: [null],
            narrativeUpdatedDate: [null],
            isacknowledgementletter: true,
            ZipCode: [''],
            RefuseToShareZip: false,
            offenselocation: [''],
            incidentlocation: [''],
            incidentdate: [''],
            isapproximate: false,
            email: ['',Validators.email],
            reporterrole: [''],
            organization: [null],
            title: [null],
            addendumNarrative :[null],
            addendumNarrativeUpdatedAt :[null],
            isaddendumnarrativeupdated :false
        });
        this.addIdentifiedFormGroup = this.formBuilder.group({
            firstname: ['', Validators.required],
            lastname: ['', Validators.required],
            dob: [null],
            gender: [''],
            ssn: [''],
            age: [''],
            qprole: ['', Validators.required],
            qprolename: '',
            drugexposednewbornflag:'',
            drugexposedtypekey: [''],
            otherdrugs: [''],
        });
    }
    onChange(event: any) {
        if (!this.intakeNarrativeForm.get('Firstname')?.valid) {
            this.intakeNarrativeForm.get('Firstname')?.setValue('');
        }
        if (!this.intakeNarrativeForm.get('Lastname')?.valid) {
            this.intakeNarrativeForm.get('Lastname')?.setValue('');
        }

        this._storeService.setData(IntakeStoreConstants.addNarrative, this.intakeNarrativeForm.getRawValue());
    }
    resetAnoymousorUnknownUser() {
        this.intakeNarrativeForm.get('IsUnknownReporter')?.setValue(null);
        this.intakeNarrativeForm.get('IsAnonymousReporter')?.setValue(null);
    }
    isAnoymousorUnknownUser() {
        const IsUnknownReporter = this.intakeNarrativeForm.getRawValue().IsUnknownReporter;
        const IsAnonymousReporter = this.intakeNarrativeForm.getRawValue().IsAnonymousReporter;
        if (IsUnknownReporter || IsAnonymousReporter) {
            return true;
        } else {
            return false;
        }
    }

    changeReport(event: any, type: string) {
        if (type === 'Anonymous') {
            if (event.target.checked) {
                this.intakeNarrativeForm.value.IsAnonymousReporter = true;
                this.intakeNarrativeForm.value.IsUnknownReporter = false;
                this.firstNameControlName.disable();
                this.middleNameControlName.disable();
                this.lastNameControlName.disable();
                this.intakeNarrativeForm.patchValue({
                    Role: '',
                    organization: '',
                    title: '',
                    // Firstname: '',
                    // Lastname: '',
                    IsUnknownReporter: false
                });
            } else {
                this.firstNameControlName.enable();
                this.middleNameControlName.enable();
                this.lastNameControlName.enable();
                this.intakeNarrativeForm.patchValue({
                    Role: 'Rep'
                });
                this.intakeNarrativeForm.value.IsAnonymousReporter = false;
            }
        } else if (type === 'Unknown') {
            if (event.target.checked) {
                this.intakeNarrativeForm.value.IsUnknownReporter = true;
                this.intakeNarrativeForm.value.IsAnonymousReporter = false;
                this.firstNameControlName.disable();
                this.middleNameControlName.disable();
                this.lastNameControlName.disable();
                this.intakeNarrativeForm.patchValue({
                    Role: '',
                    Firstname: '',
                    Middlename: '',
                    Lastname: '',
                    organization: '',
                    title: '',
                    IsAnonymousReporter: false
                });
            } else {
                this.firstNameControlName.enable();
                this.middleNameControlName.enable();
                this.lastNameControlName.enable();
                this.intakeNarrativeForm.patchValue({
                    Role: '',
                    Firstname: '',
                    Middlename: '',
                    Lastname: '',
                    organization: '',
                    title: '',
                    IsAnonymousReporter: false
                });
                this.intakeNarrativeForm.value.IsUnknownReporter = false;
            }
        } else if (type === 'RefuseZip') {
            if (event.target.checked) {
                this.ZipCodeControlName.disable();
                this.intakeNarrativeForm.controls['ZipCode'].clearValidators();
                this.intakeNarrativeForm.patchValue({
                    ZipCode: ''
                });
            } else {
                this.intakeNarrativeForm.controls['ZipCode'].setValidators([Validators.required]);
                this.ZipCodeControlName.enable();
                this.intakeNarrativeForm.patchValue({
                    ZipCode: ''
                });
            }
        }
        if (type === 'Unknown' && event.target.checked) {
            this.intakeNarrativeForm['controls'].isacknowledgementletter.setValue(false);
            this.intakeNarrativeForm['controls'].isacknowledgementletter.disable();
        } else {
            this.intakeNarrativeForm['controls'].isacknowledgementletter.enable();
        }

        this._storeService.setData(IntakeStoreConstants.addNarrative, this.intakeNarrativeForm.getRawValue());
    }
    ngOnDestroy() {
        this.checkForNarrativeContent();
        this.checkForCPSHistoryContent();
        this._speechRecognitionService.destroySpeechObject();
        this.formchangelistener.unsubscribe();
    }

    activateSpeechToText(): void {
        this.recognizing = true;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                // listener
                (value) => {
                    const speechData = value;
                    const currentData = this.intakeNarrativeForm.get('Narrative')?.value;
                    const finalData = [currentData, speechData].join(' ');
                    this.intakeNarrativeForm.patchValue({ Narrative: finalData });
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
    getSuggestedAddress() {
        if (this.intakeNarrativeForm.value.requesteraddress1 &&
            this.intakeNarrativeForm.value.requesteraddress1.length >= 3) {
            this.suggestAddress();
        }
    }

    suggestAddress() {
        this._commonHttpService
            .getArrayListWithNullCheck(
                {
                    method: 'post',
                    where: {
                        prefix: this.intakeNarrativeForm.value.requesteraddress1,
                        cityFilter: '',
                        stateFilter: '',
                        geolocate: '',
                        geolocate_precision: '',
                        prefer_ratio: 0.66,
                        suggestions: 25,
                        prefer: 'MD'
                    }
                },
                NewUrlConfig.EndPoint.Intake.SuggestAddressUrl
            ).subscribe(
                (result: any) => {
                    if (result.length > 0) {
                        this.suggestedAddress$ = observableOf(result);
                    } else {
                        this.suggestedAddress$ = observableOf([]);
                    }
                }
            );
    }
    selectedAddress(model: any) {
        this.intakeNarrativeForm.patchValue({
            requesteraddress1: this.returnStreetDataFn(model),
            requestercity: this.returnCityDataFn(model),
            requesterstate: this.returnStateDataFn(model)
        });
        const addressInput = {
            street: this.returnStreetDataFn(model),
            street2: '',
            city: this.returnCityDataFn(model),
            state: this.returnStateDataFn(model),
            zipcode: '',
            match: 'invalid'
        };
        this._commonHttpService
            .getSingle(
                {
                    method: 'post',
                    where: addressInput
                },
                NewUrlConfig.EndPoint.Intake.ValidateAddressUrl
            )
            .subscribe(
                (result) => {
                    if (result[0].analysis) {
                        this.addressValidationResponseFn(result);
                    }
                },
                (error) => {
                    console.error(error);
                }
            );
    }

    private returnStateDataFn(model: any) {
        return model.state ? model.state : '';
    }

    private returnCityDataFn(model: any): any {
        return model.city ? model.city : '';
    }

    private returnStreetDataFn(model: any) {
        return model.streetLine ? model.streetLine : '';
    }

    private addressValidationResponseFn(result: any) {
        this.intakeNarrativeForm.patchValue({
            offenselocation: result[0].components.zipcode ? result[0].components.zipcode : ''
        });
        this.loadCounty(this.intakeNarrativeForm.value.requesterstate);
        if (result[0].metadata.countyName) {
            this._commonHttpService.getArrayList(
                {
                    nolimit: true,
                    where: { referencetypeid: 306, mdmcode: {"like": this.intakeNarrativeForm.value.requesterstate + "~%25","options":"i" }, description: result[0].metadata.countyName }, method: 'get'
                },
                'referencevalues?filter'
            ).subscribe(
                (resultresp) => {
                    if (resultresp[0]) {
                        this.intakeNarrativeForm.patchValue({
                            requestercounty: resultresp[0].ref_key,
                            requestercountyname: result[0].metadata.countyName
                        });
                    }
                }
            );
        }
    }

    onOptionSelected(event: MatAutocompleteSelectedEvent): void {
        const selectedOption = event.option.viewValue;
        const addobj = selectedOption.split(",")[1].split(" ")
        const obj = {
            city: addobj.slice(1, -1).join(" "),
            state: addobj[addobj.length - 1],
            streetLine: selectedOption.split(",")[0],
            text: selectedOption}
            this.selectedAddress(obj);
    }

    validateAddressResponse() {
        const addressInput = {
            street: this.intakeNarrativeForm.value.requesteraddress1 ? this.intakeNarrativeForm.value.requesteraddress1 : '',
            street2: this.intakeNarrativeForm.value.requesteraddress2 ? this.intakeNarrativeForm.value.requesteraddress2 : '',
            city: this.intakeNarrativeForm.value.City ? this.intakeNarrativeForm.value.City : '',
            state: this.intakeNarrativeForm.value.State ? this.intakeNarrativeForm.value.State : '',
            zipcode: this.intakeNarrativeForm.value.Zip ? this.intakeNarrativeForm.value.Zip : '',
            match: 'invalid'
        };

        this.addressAnalysis = [];
        this._commonHttpService
            .getSingle(
                {
                    method: 'post',
                    where: addressInput
                },
                NewUrlConfig.EndPoint.Intake.ValidateAddressUrl
            )
            .subscribe(
                (result) => {
                    if (result[0].analysis) {
                        this.pushResponseAddressDataFn(result);
                    }
                },
                (error) => {
                    console.error(error);
                }
            );
    }




    private pushResponseAddressDataFn(result: any) {
        this.intakeNarrativeForm.patchValue({
            Zip: result[0].components.zipcode ? result[0].components.zipcode : '',
            County: result[0].metadata.countyName ? result[0].metadata.countyName : '',
            county: result[0].metadata.countyName ? result[0].metadata.countyName : ''
        });

        if (result[0].analysis.dpvMatchCode) {
            this.addressAnalysis.push({
                text: result[0].analysis.dpvMatchCode
            });
        }
        if (result[0].analysis.dpvFootnotes) {
            this.addressAnalysis.push({
                text: result[0].analysis.dpvFootnotes
            });
        }
        if (result[0].analysis.dpvCmra) {
            this.addressAnalysis.push({
                text: result[0].analysis.dpvCmra
            });
        }
        if (result[0].analysis.dpvVacant) {
            this.addressAnalysis.push({
                text: result[0].analysis.dpvVacant
            });
        }
        if (result[0].analysis.active) {
            this.addressAnalysis.push({
                text: result[0].analysis.active
            });
        }
        if (result[0].analysis.ewsMatch) {
            this.addressAnalysis.push({
                text: result[0].analysis.ewsMatch
            });
        }
        if (result[0].analysis.lacslinkCode) {
            this.addressAnalysis.push({
                text: result[0].analysis.lacslinkCode
            });
        }
        if (result[0].analysis.lacslinkIndicator) {
            this.addressAnalysis.push({
                text: result[0].analysis.lacslinkIndicator
            });
        }
        if (result[0].analysis.suitelinkMatch) {
            this.addressAnalysis.push({
                text: result[0].analysis.suitelinkMatch
            });
        }
        if (result[0].analysis.footnotes) {
            this.addressAnalysis.push({
                text: result[0].analysis.footnotes
            });
        }
    }

    private narrativeTooltip() {
        this._resourceService
            .getArrayList(
                {
                    method: 'get',
                    where: {
                        resourcetype: [3],
                        parentid: '5c70b495-4a13-4b70-83fa-ab0e2b341cb8'
                        // parentid: 'f9c6ea93-5699-4df2-b7a9-92c32b9b325c'
                    }
                },
                NewUrlConfig.EndPoint.Intake.ResourceTooltipUrl + '?filter'
            )
            .subscribe((result) => {
                if (result) {
                    result.forEach((item) => {
                        if (item.name === 'Narrative') {
                            this.tooltip = item.tooltip;
                            return true;
                        }
                        return false;
                    });
                }
            });
    }
    getGenderDescription(genderKey: any) {
        if (this.genderList && Array.isArray(this.genderList)) {
            const gender = this.genderList.filter(item => item.gendertypekey === genderKey);
            if (gender && gender.length) {
                return gender[0].typedescription;
            } else {
                return '';
            }
        }
    }
    addIdentified() {
        const person = this.addIdentifiedFormGroup.getRawValue();
        if (
            person.firstname.length > 0 ||
            person.lastname.length > 0 ||
            person.dob.length > 0 ||
            person.gender.length > 0 ||
            person.ssn.length > 0 ||
            person.age.length > 0) {
            let persons = this._storeService.getData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);
            if (!persons) {
                persons = [];
            }
            person.id = new Date().getTime();
            person.isAdded = false;
            persons.push(person);
            this._storeService.setData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS, persons);
            this.addedIdentifiedPersons = this._storeService.getData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);
            (<any>$('#add-identified')).modal('hide'); // NOSONAR
            this.addIdentifiedFormGroup.reset();
            this.addIdentifiedFormGroup.patchValue({
                firstname: '',
                lastname: '',
                dob:  person.dob ? moment(person.dob).format('YYYY-MM-DD') : null,
                gender: '',
                ssn: '',
                age: '',
                qprole: [''],
                drugexposednewbornflag:'',
                drugexposedtypekey: [''],
                otherdrugs: [''],
            });
            this._intakeConfig.quickAddPersonListener$.next('QP');
        } else {
            this._alertService.warn('Fill the required fields for Quick Person Details.');
        }
    }


    deleteIdentified(person: any) {
            let persons = this._storeService.getData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);
            if(persons) {
                persons = persons.filter((item: { quickpersonid: any; }) => person.quickpersonid !== item.quickpersonid);
            }
            this._storeService.setData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS, persons);
            this.addedIdentifiedPersons = this._storeService.getData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);
            this._commonHttpService.remove( person.quickpersonid , {}, 'quickperson/deletequickperson').subscribe(() => {
            this._alertService.success('Quick Person deleted successfully'); 
                this.getquickperson();
            });
        }
 
    narrativeOnFocus() {
        // No data or function call or add
    }
    searchIdentified(person: any, type?: string) {
            if(type == 'QP') {
                person.persontype = type;
                person.clientflag = 1;
                this._storeService.setData('QUICK_PERSON_ID',person);
            } else {
                this._storeService.setData('QUICK_PERSON_ID',null);
            }
        this._storeService.setData(IntakeStoreConstants.PERSON_TO_SEARCH, person);
        const intake = this._storeService.getObj('intake');
        const url = '/pages/newintake/my-newintake/' + intake.number + '/' + intake.action + '/person-cw/find-individual/search';
        this._router.navigate([url]);
    }
    getGenderList() {
        this._commonHttpService.create(
            {
                where: { activeflag: 1 },
                method: 'post',
                nolimit: true
            },
            NewUrlConfig.EndPoint.Intake.GenderTypeUrl + '/genderlist'
        ).subscribe(data => {
            this.genderList = data.filter((dataItem: { gendertypekey: string; }) => dataItem.gendertypekey !== 'TG' && dataItem.gendertypekey !== 'U'&& dataItem.gendertypekey !== '99'&& dataItem.gendertypekey !== '88');
        });
    }

    getReporterRolesList() {
        this._commonHttpService.getArrayList({
            method: 'get',
            where: { tablename: 'reporterroles', teamtypekey: 'CW' }
        }, NewUrlConfig.EndPoint.Intake.GetTypes + '?filter').subscribe(data => {
            this.reporterRoles = data;
        });
    }

    calculateAge(dob: any) {

        if (dob && moment(new Date(dob), 'MM/DD/YYYY', true).isValid()) {
            const rCDob = moment(new Date(dob), 'MM/DD/YYYY').toDate();
            const age: any = { years: 0, months: 0, days: 0, totalMonths: 0, duration: null };
            age.years = (moment().diff(rCDob, 'years', false)) ? moment().diff(rCDob, 'years', false) : 0;
            age.totalMonths = (moment().diff(rCDob, 'months', false)) ? moment().diff(rCDob, 'months', false) : 0;
            age.months = (age.totalMonths - (age.years * 12)) ? age.totalMonths - (age.years * 12) : 0;
            age.days = (moment().diff(rCDob, 'days', false)) ? moment().diff(rCDob, 'days', false) : 0;
            age.duration = moment.duration(moment(Date.now()).diff(moment(rCDob)));
            const ddays = (age.duration.days()) ? age.duration.days() : 0;
            const personAge = `${age.years} years ${age.months} month(s) ${ddays} day(s)`;
            this.personAgeCheck = age.days;
            this.addIdentifiedFormGroup.controls['age'].setValue(personAge);
        } else {
            this.personAgeCheck = 0;
        }

        this.addIdentifiedFormGroup.get('dob')?.valueChanges.subscribe(
            changeFlag => {
                    this.addIdentifiedFormGroup.controls['drugexposedtypekey'].clearValidators();
                    this.addIdentifiedFormGroup.controls['drugexposedtypekey'].updateValueAndValidity();
                    this.addIdentifiedFormGroup.controls['drugexposednewbornflag'].clearValidators();
                    this.addIdentifiedFormGroup.controls['drugexposednewbornflag'].updateValueAndValidity();
                    this.dobchange();
                 
        });

        // return age;
    }

    onCPSHistorySelectionChanged(event: any) {
        if (event.range == null) {
            this.checkForCPSHistoryContent();
        }
    }

    checkForCPSHistoryContent() {
        this.currentCPSHistoryText = this.intakeNarrativeForm.getRawValue().cpsHistoryClearance;
        if (this.cpsHistoryCont !== this.currentCPSHistoryText && this.currentCPSHistoryText !== '') {

            this.cpsHistoryCont = this.currentCPSHistoryText;
        }
    }

    onNarrativeSelectionChanged() {
            this.checkForNarrativeContent();
            this.intakeNarrativeForm.updateValueAndValidity();
            const invalidflag = this.intakeNarrativeForm.invalid;
            this._storeService.setData('isNarativeFormInValid', invalidflag);
            this.intakeUtils.narrativeUpdated$.next('UPDATED');
    }

    checkForNarrativeContent() {
        this.currentNarrativeText = this.intakeNarrativeForm.getRawValue().Narrative;
        if (this.narrativeCont !== this.currentNarrativeText && this.currentNarrativeText !== '') {

            this.narrativeCont = this.currentNarrativeText;
            this.narrativeUpdatedDate = new Date();
            const narrativeInfo = this._storeService.getData(IntakeStoreConstants.addNarrative);
            narrativeInfo.narrativeUpdatedDate = this.narrativeUpdatedDate;
            this.intakeNarrativeForm.patchValue({
                narrativeUpdatedDate: this.narrativeUpdatedDate
            });
            this._storeService.setData(IntakeStoreConstants.addNarrative, narrativeInfo);
        }
    }
    

    onaddendumNarrativeSelectionChanged(){
        this.addendumNarrativeUpdatedAt =new Date();
        const narrativeInfo = this._storeService.getData(IntakeStoreConstants.addNarrative);
        narrativeInfo.addendumNarrativeUpdatedAt = this.addendumNarrativeUpdatedAt;
        narrativeInfo.isaddendumnarrativeupdated = true;
        this.intakeNarrativeForm.patchValue({
            addendumNarrativeUpdatedAt: this.addendumNarrativeUpdatedAt,
            isaddendumnarrativeupdated:true
        });
        this._storeService.setData(IntakeStoreConstants.addNarrative, narrativeInfo);
        this._storeService.setData(IntakeStoreConstants.isaddendumnarrativeupdated,true);
    }

    isCPSHistoryClearanceChecked() {
        return this._storeService.getData('isCPSHistoryClearanceChecked');
    }

    selectRole(event: any, page: string) {
        if(page == 'n') {
            const roleobj = this.reporterRoles.find(item => item.ref_key === event.value);
            this.intakeNarrativeForm.patchValue({ RoleName: (roleobj) ? roleobj.description : '' });
        } else {
           const roleobj = this.reporterRoles.find(item => item.ref_key === event.value);
            this.addIdentifiedFormGroup.patchValue({ qprolename: (roleobj) ? roleobj.description : '' });
        }

        this.onNarrativeSelectionChanged();
    }

    setupChangeSubscribers() {
        this.addIdentifiedFormGroup.controls['drugexposedtypekey'].valueChanges
          .subscribe(() => {
            this.babySubstanceOther = false;
            const substances: any[] = this.addIdentifiedFormGroup.controls['drugexposedtypekey'].value;
            if (substances) {
              substances.forEach(item => {
                if (item === 'BOTH') {
                  this.babySubstanceOther = true;
                }
              });
            }
          });
      }

    getquickperson() {
         
        const request = {
            objectid: this.store[IntakeStoreConstants.intakenumber] ,
            objecttype: 'intake',
            caseid: null
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
            this.addedIdentifiedPersons = data[0].getquickpersondetails; 
            this._storeService.setData(IntakeStoreConstants.quickPersonsHistory, data[0].getquickpersondetails)
            this._storeService.setData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS, this.addedIdentifiedPersons);
            this.addedIdentifiedPersons = this._storeService.getData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);       
          } else {
            this.addedIdentifiedPersons = [];
          }
          this._intakeConfig.quickAddPersonCount$.next(this.addedIdentifiedPersons.length);
          this.getquickpersonHistory();
        });
      }

      getquickpersonHistory() {
        const caseInfo = this._storeService.getData('dsdsActionsSummary');
        let intakeserviceid = null;
        let intakenumber = this._storeService.getData('intakenumber') ?  this._storeService.getData('intakenumber') : this._storeService.getData('da_intakenumber') ;
        if (caseInfo) {
          intakeserviceid = caseInfo.intakeserviceid;
          intakenumber = caseInfo.intakenumber;
        }
        const request = {
            objectid: intakenumber ? intakenumber : intakeserviceid , 
            objecttype: intakenumber ? 'intake' : 'case'
        };
        this._commonHttpService.getArrayList(
          {
            where: request,
            method: 'get',
            nolimit: true
          },
          'quickpersonhistory/list?filter'
        ).subscribe(data => {
           if (data && data.length) {
            //this._storeService.setData(IntakeStoreConstants.quickPersonsHistory, data)
           }
        });
      }

      savequickperson() {
        if (this.addIdentifiedFormGroup.valid) {
    
          const qpFormData = this.addIdentifiedFormGroup.getRawValue();
          if (!qpFormData.qprole && (!qpFormData.firstname || !qpFormData.lastname)) {
            this._alertService.error('Please fill First Name and Last Name or Role');
            return false;
          }
     
          qpFormData.caseid = null;
          qpFormData.intakenumber = this.store[IntakeStoreConstants.intakenumber];
          qpFormData.objecttype = 'intake'; 
          qpFormData.quickpersonroleconfig = qpFormData.qprole.map((item: any) =>  { return {'actortypekey' : item  }  }); 
          if(qpFormData.drugexposednewbornflag){ 
            qpFormData.quickpersonsubstconfig = qpFormData.drugexposedtypekey.map((item: any) =>  { return {'substanceclasskey' : item }  }); 
          }//else 
         //qpFormData.quickpersonsubstconfig = null;
          this._commonHttpService.create(qpFormData, 'quickperson/addupdate').subscribe(() => {
            this._alertService.success('Quick person added and saved successfully');
            (<any>$('#add-identified')).modal('hide'); // NOSONAR
            this.addIdentifiedFormGroup.reset();
             this.getquickperson();
          });
         
          this._intakeConfig.quickAddPersonListener$.next('QP');
        } else {
          this._alertService.error('Please fill required feilds');
        }
      } 

      dobchange() {
        this.addIdentifiedFormGroup.patchValue({
          drugexposednewbornflag: null,
          drugexposedtypekey: '' 
          });
      }
    getSupervisorApprovalInfo() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._storeService.getData('iscaseexpunged');     
        this.intakenumber = this._storeService.getData('intakenumber') ? this._storeService.getData('intakenumber') : this._storeService.getData('da_intakenumber');
        this._http.post(CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CpsIntakeReport, {
            'intakenumber': this.intakenumber,
            'isExpungementSuperUser': isExpungementSuperUser,
            'iscaseexpunged': iscaseexpunged
        }).subscribe((response) => {
            this.submisionHistory = response && response.data ? response.data.getsupervisorapprovaldetails : [];
            if (this.submisionHistory && Array.isArray(this.submisionHistory)) {
                this.showaddendumnarrative = this.submisionHistory.find(item => (item.supdecision === 'Navigate to Narrative' || item.typedescription === 'In Progress'));
                const isnavigatetonarrative = this.submisionHistory.find(item => (item.supdecision === 'Navigate to Narrative' && item.eventcode === 'INTR'));
                const returntoworker = this.submisionHistory.find(item => (item.supdecision === 'Return to Worker'));
                this.workerAndNarrativeCheckFn(returntoworker, isnavigatetonarrative);
            }
        });
    }
    
    private workerAndNarrativeCheckFn(returntoworker: any, isnavigatetonarrative: any) {
        if (returntoworker) {
            this.returntoworker = true;
            $(this.nonNarrativeId).hide();
            $(this.narrativeId).show();
            this.intakeNarrativeForm.controls.Narrative.disable();
            this.isNarativeDisabled = true;
        }
        if (isnavigatetonarrative) {
            this.navigatetonarrative = true;
            if (this.navigatetonarrative) {
                $(this.nonNarrativeId).hide();
                $(this.narrativeId).show();
                this.isNarativeDisabled = true;
                this.intakeNarrativeForm.controls.IsAnonymousReporter.enable();
                this.intakeNarrativeForm.controls.IsUnknownReporter.enable();
                this.intakeNarrativeForm.controls.Narrative.disable();
                this.intakeNarrativeForm.controls.Firstname.enable();
                this.intakeNarrativeForm.controls.Middlename.enable();
                this.intakeNarrativeForm.controls.Lastname.enable();
                this.intakeNarrativeForm.controls.PhoneNumber.enable();
                this.intakeNarrativeForm.controls.PhoneNumberExt.enable();
                this.intakeNarrativeForm.controls.ZipCode.enable();
                this.intakeNarrativeForm.controls.RefuseToShareZip.enable();
                this.intakeNarrativeForm.controls.offenselocation.enable();
                this.intakeNarrativeForm.controls.isacknowledgementletter.enable();


            }
        }
    }

    getControlByIndexFn(index: string): FormControl {
        return this.intakeNarrativeForm.controls[index] as FormControl;
    }
}
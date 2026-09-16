

import {map} from 'rxjs/operators';
import { AfterViewInit, ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, Validators } from '@angular/forms';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { Observable ,  forkJoin } from 'rxjs';
import _ from 'lodash';
import moment from 'moment';
import { CommonUrlConfig } from '../../../../../../app/@core/common/URLs/common-url.config';
import { PetitionList, CourtOrderList, Checklist, CourtOrderAdd, HearingDetails, Qrtpcourtorder } from '../_entities/court.data.model';
import { AlertService } from '../../../../../@core/services/alert.service';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AuthService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { SpeechRecognitionService } from '../../../../../@core/services/speech-recognition.service';
import { NgxfUploaderService } from 'ngxf-uploader';
import { AppConfig } from '../../../../../app.config';
import { HttpHeaders } from '@angular/common/http';
import { AppConstants } from '../../../../../@core/common/constants';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { CourtResolverService } from '../court-resolver-service';
declare var $: any;
import { ActivatedRoute, Router } from '@angular/router';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'court-order',
    templateUrl: './court-order.component.html',
    styleUrls: ['./court-order.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})

export class CourtOrderComponent implements OnInit,AfterViewInit {
    isRequiredParentOrLegalGuardianSection: boolean = false;
    isRequiredParentOrLegalGuardianButton: boolean = false;
    healthcaredecisionmakerinformationidhcdmflag0Fields: any=null;
    deletehdcm: boolean = false;
    courtOrderFormGroup!: FormGroup;
    psychotropiccounty: any;
    countyname: any;
    showhcdmtaboncounty: boolean = false;
    expandQtrReportCrds: boolean = false;
    approvalStatusForm!: FormGroup;
    QrtpcourtOrderFormGroup!:FormGroup;
    healthCareDecisionMakerForm!:FormGroup;
    isPopUpActivated = false;
    hearingTypesRequiredForReasonableEffort = ['CR', 'CC', 'PPR', 'PP', 'QRTPRH', 'REH', 'GR'];
    id!: string;
    isHearingFill!: boolean;
    healthcaredecisionaddvalidation: boolean =false;
    qrtpplacementhearing!: boolean
    hearingOutpcomeDetails$!: Observable<DropdownModel[]>;
    childPermanencyPlanData!: Observable<DropdownModel[]>;
    personsappeared$!: Observable<DropdownModel[]>;
    petitonListDetails: PetitionList = new PetitionList();
    selectedPetition: PetitionList | undefined = new PetitionList();
    petitionList: PetitionList[] = [];
    courtOrderList!: CourtOrderList;
    courtOrderColang: Checklist[] = [];
    courtOrderCopp: Checklist[] = [];
    healthcaredecision :Checklist[] = [];
    personsAppeared :Checklist[] =[];
    courtOrderCoho: Checklist[] = [];
    courtDetailsList: CourtOrderList[] = [];
    hearingDetails: HearingDetails = new HearingDetails();
    hearingData: any[] = [];
    clientname :any;
    casenumber:any;
    approvalDisable!: boolean;
    caseNumber!: string;
    dob:any;
    disableotheroptions: boolean =false;
    hearingtypeArray: string[] = [];
    hearingstatustypeArray: string[] = [];
    roleId!: AppUser;
    isSupervisor!: boolean;
    isRouting!: boolean;
    isSupervisorSubmit!: boolean;
    viewCourt!: boolean;
    countyList: Array<any> = [];
    tprDetailsForm!: FormGroup;
    everadoptedsingleparentcheck: any;
    tprRecommendationList: any;
    tprListDetails: any;
    petitionDetailsFortpr: any;
    displayValidationMessages= false;
    recognizing = false;
    speechRecogninitionOn!: boolean;
    speechData!: string;
    notification!: string;
    enableAppend = false;
    uploadedFile: any[] = [];
    minDate: any;
    token!: AppUser;
    deleteAttachmentIndex!: number;
    childPermanencyPlanKey!: string | null;
    isClosed = false;
    familyStructure: any;
    childRemovaltype: any;
    childremovalList: any;
    childRemovalEpisodeList: any[] = [];
    involvedPerson: any[] = [];
    filterTprPartents: any[] = [];
    remainingPeople: any[] = [];
    methodServiceDropdownItems$!: Observable<DropdownModel[]>;
    HealthCareDecisionDropdownItems$!: Observable<DropdownModel[]>;
    AuthorizedHcdmDropdownItems$!: Observable<DropdownModel[]>;
    appealDecisionDropdownItems$!: Observable<DropdownModel[]>;
    terminationtypDropdownItems$!: Observable<DropdownModel[]>;
    hearingOutpcomeDetails!: DropdownModel[];
    personAppeared1!: DropdownModel[];
    isEditDisabled = false;
    isCourtOrderEditable!: boolean;
    showothertext=false;
    isReadonly= false;
    parent2info= false;
    selectedhearingtype: any;
    selectedhearingstaustype: any;
    intakeservreqcourtorderid!: string | undefined;
    courtcasenumber: any;
    objecttypekey = '';
    objectId: any
    isDocumentView=true;
    ivespecialist = 'IV-E Specialist';
    gettypesurl = 'referencetype/gettypes';
    dtformat = 'MM/DD/YYYY';
    ivesupervisor = 'IV-E Supervisor';
    daStatus = '';
    setRemovalEpisodeDate= false;
    courtOrderintakeservreqcourtorderid :any;
    bulkHearing: any = [];
    isEdit=false;
    showhcdmdeleteicon :boolean=false;
    ReasonableEffortsMade = 'Reasonable efforts were made to finalize the child\'s permanency plan';
    ReasonableEffortsNotMade = 'Reasonable efforts were not made to finalize the child\'s permanency plan';
    uploadNumber: any;
    editMode: any;
    reportMode: any;
    selectedHearing: any;
    address = {  disable: true, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
    address2 = {  disable: true, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
    isTPR : boolean = false;
    @ViewChild(DocumentUploadListSharedComponent) documentuploaded!: DocumentUploadListSharedComponent;
    isReasonableEffortMade= false;
    // tslint:disable-next-line:max-line-length
    // tslint:disable-next-line:max-line-length

    private readonly _formBuilder: FormBuilder;
    private readonly _commonHttpService: CommonHttpService;
    private readonly _alertService: AlertService;
    public _authService: AuthService;
    private readonly _datastore: DataStoreService;
    private readonly storage: SessionStorageService;
    private cdr: ChangeDetectorRef;

    private readonly router: Router;
    private readonly route: ActivatedRoute;
    retrydoc: boolean = false;
    iscaseexpunged: any = 0;

    constructor(
        private injector: Injector,
        private readonly _speechRecognitionService: SpeechRecognitionService,
        private readonly _uploadService: NgxfUploaderService,
        private readonly _courtResolverService: CourtResolverService
    ) {
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._datastore = this.injector.get<DataStoreService>(DataStoreService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this.router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    }
  
   ngAfterViewInit(): void {

    $('#termination-ofparental').on('hidePrevented.bs.modal', () => {

        if (this.tprDetailsForm?.dirty) {

            $('#termination-ofparental').addClass('modal-greyed');

            $('#unsaved-work-popup').modal('show');
        }
    });

    $('#unsaved-work-popup').on('hidden.bs.modal', () => {
        $('#termination-ofparental').removeClass('modal-greyed');
    });
    }

    ngOnInit() {
        this.iscaseexpunged = this._datastore.getData('iscaseexpunged');
        this.route.queryParams.subscribe(params => {
            this.retrydoc = params['retrydocument'];
          });
        this._authService.hasAccess('Court_Order_FA').subscribe(result => {
            this.isCourtOrderEditable = result;
          }) ;
        this.isEditDisabled = this._authService.isDisabled('court','court.courtorder.edit');
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.caseNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.token = this._authService.getCurrentUser();
        this.loadDropDownList();
        this.getUserCounty();
        this.getCountyList();
        this.getChildRemoval();
        this.initializeForm();
        this.hearingOutcome();
        this.childPermanencyPlan();
        this.getPetitionDetailsList(() => {
            this.getChecklist();
        });
        this.personsappeared();
        this.getAppealDecisionDropdown();
        this.getTerminationTypeDropdown();
        this.getMethodServiceDropdown(); 
        this.getMethodHealthCareDecisionDropdownMakerDropdown();
        this.getAuthorizedHcdmDropdown();
        this.getTprDetails();
        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.role.name === 'apcs' || this.roleId.role.name === this.ivespecialist) {
            this.isSupervisor = true;
            this.viewCourt = true;
        }
        this.daStatus = this.storage.getItem('da_status');
        this.isClosed = this._authService.iscaseclosed('courtorder');
        const activeModuleRole = this.storage.getItem('activeModuleRole');
        if (activeModuleRole === 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
          this.isReadonly = false;
        } else {
        this.isReadonly =  this._authService.readonlyButton('read_only_access','caseworker-court-order-save');}
        this.route.queryParams.subscribe(params => {
            if(params['retrydocument']) {
            this.expandQtrReportCrds = true;
            }
          });
    }

    getCountyList() {
        this._commonHttpService.create(
            {
                where: { activeflag : 1, state: 'MD' },
                order: 'countyname asc',
                nolimit: true
            }, 'admin/county/countylist'
            ).subscribe((item) => {
                this.countyList = item;
            });
    }

    private initializeForm() {
        this.courtOrderFormGroup = this._formBuilder.group({
            courtorderdelayremoval: [''],
            courtorderdelaytimeframe: [''],
            courtorderdate: ['', Validators.required],
            hearingoutcome: [null, Validators.required],
            removalepisode: [''],
            removalepisodeDate: [''],
            childpermanencyplankey: [''],
            courtordercolang: this._formBuilder.array([]),
            courtordercopp: this._formBuilder.array([]),
            courtordercoho: this._formBuilder.array([]),
            remarks: ['', Validators.required],
            intakeservreqcourtorderid: [null],
            healthcaredecisionarrya :this._formBuilder.array([
            ]),
        });
        this.approvalStatusForm = this._formBuilder.group({
            routingstatus: [''],
            comments: ['']
        });
        this.QrtpcourtOrderFormGroup = this._formBuilder.group({
            county :[''],
            clientname :[''],
            casenumber:[''],
            dob:[''],
            courtorderdate:[''],
            personsappeared:[],
            otherpersonsappeared:[],
            courtreview:[''],
            childsneed:[''],
            childneedcantmet :[''],
            childpermanencyplan :[''],
            childmosteffplan:[''],
            qrtpapproval:[''] ,
            qrtpapprovaldecision: [''],
            judgedate:[''],
            judgename:[''],
            judgeid :[''],

            personsAppeared:this._formBuilder.array([]),
        });
        
        this.healthCareDecisionMakerForm = this._formBuilder.group({
            healthcaredecision1: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER))}],
            name1: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            authorizedhcdm1: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            email1: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            phone1: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            
            healthcaredecisionmakerinformationid1:[{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            hcdmOther1: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            healthcaredecision2: [{ value: '', disabled: true }],
            name2: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            authorizedhcdm2: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            email2: [{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            phone2: [{ value: '', disabled:!(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            hcdmOther2: [{ value: '', disabled:!(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],
            healthcaredecisionmakerinformationid2:[{ value: '', disabled: !(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) }],

        });

        this.tprDetailsForm = this._formBuilder.group({
            intakeservicerequestactorid: ['', [Validators.required]],
            serveddate: [null],
            servicetypekey: [''],
            terminationtypekey: [''],
            isappealed: [null],
            isdssappealed: [null],
            appealdate: [null],
            appealdecisiontypekey: [''],
            decisiondate: [null],
            reason: [''],
            parentname: [''],
            tprdetailsid: [null],
            tprdecisiondate: [null],
            tprpetitiondate: [null],
            relationshiptypekey: [null],
            isdenied: [null],
            isgranted: [{value: null, disabled: true}],
            iscontested: [{value: null, disabled: true}],
            singleparent: [null],
            isdisabled: [false],
            intakeservicerequestactorid1: [null],
            serveddate1: [null],
            servicetypekey1: [''],
            terminationtypekey1: [''],
            isappealed1: [null],
            isdssappealed1: [null],
            appealdate1: [null],
            appealdecisiontypekey1: [''],
            decisiondate1: [null],
            reason1: [''],
            parentname1: [''],
            tprdetailsid1: [null],
            tprdecisiondate1: [null],
            intakeservreqcourtorderid : [null],
            intakeservreqcourtorderid1 : [null],
            tprpetitiondate1: [null],
            relationshiptypekey1: [null],
            isdenied1: [null],
            isgranted1: [null],
            iscontested1: [null],
            childintakeactorid: [null],
            singleparent1: [null],
            isdisabled1: [false]
        });

    }

    uploadclosed(event: any){
        if(event){
            this.documentuploaded.closeupload();
        }
      }

    private isRequiredDescription(description: string): boolean {
        return description === this.ReasonableEffortsMade ||
               description === this.ReasonableEffortsNotMade;
    }

    setFormValues() {
        const courtOrderCoppControl = this.courtOrderFormGroup.controls['courtordercopp'] as FormArray;
        if (this.courtOrderCopp) {
            this.courtOrderCopp?.forEach((x) => {
                courtOrderCoppControl.push(this.buildCourtOrderColangForm(x));
            });
        }

        const courtOrderCohoControl = this.courtOrderFormGroup.controls['courtordercoho'] as FormArray;
        if (this.courtOrderCoho) {
            this.courtOrderCoho?.forEach((x) => {
                courtOrderCohoControl.push(this.buildCourtOrderColangForm(x));
            });
        }

        if(!this.courtOrderColang) {
            return;
        }
        this.isReasonableEffortMade = this.courtOrderList.courtdetails
                ?.filter(e => e.checklistid === '34993888-d849-4774-a5c0-6aa25a2b9a42'
                            // '34993888-d849-4774-a5c0-6aa25a2b9a42' is a checklistid that contains the value of
                            // Reasonable efforts made to finalize the child's childPermanencyPlan
                            || e.checklistid === '514f3bc2-e43d-4329-b3ea-5170dcbfac55')
                            // '514f3bc2-e43d-4329-b3ea-5170dcbfac55' is a checklistid that contains the value of
                            // Reasonable efforts made to finalize the child's childPermanencyPlan
                .some(e => e.isselected === 1)
        const courtOrderColangControl = this.courtOrderFormGroup.controls['courtordercolang'] as FormArray;
        this.courtOrderColang?.forEach((x) => {
            x.isselected = false;
            x.remarks = '';
            x.isRequired = this.isRequiredDescription(x.description);
            if (this.courtOrderList && this.courtOrderList.courtdetails) {
                const checkList = this.courtOrderList.courtdetails.find((item) => item.checklistid === x.checklistid);
                x.isselected = (checkList && checkList.isselected) ? true : false;
                x.isRequired = this.isRequiredDescription(x.description);
                x.remarks = (checkList && checkList.remarks) ? checkList.remarks : '';
            }

            courtOrderColangControl.push(this.buildCourtOrderColangForm(x));
        });
    }

    private buildCourtOrderColangForm(x: any): FormGroup {
        const description = x.description ? x.description : '';
        const courtorderdata = this._formBuilder.group({
            checklistid: x.checklistid ? x.checklistid : '',
            description: description,
            isselected: x.isselected ? x.isselected.toString() : '',
            isRequired: this.isRequiredDescription(x.description),
            remarks: x.remarks ? x.remarks : ''
        });
        const getChecklist = this.courtOrderList?.courtdetails?.filter((item) => item.checklistid === x.checklistid);
        if (getChecklist && getChecklist.length > 0) {
            return this._formBuilder.group({
                checklistid: getChecklist[0].checklistid ? getChecklist[0].checklistid : '',
                description: description,
                isselected: (getChecklist[0].isselected === 1) ? true : false,
                isRequired: this.isRequiredDescription(x.description),
                remarks: getChecklist[0].remarks ? getChecklist[0].remarks : ''
            });
        } else {
            return courtorderdata;
        }

    }

    private getPetitionDetailsList(callback?: () => void) {
    const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();

    let petitionReqObj = {};

    if (isServiceCase) {
        petitionReqObj = {
            objectid: this.id,
            objecttype: 'servicecase'
        };
    } else {
        petitionReqObj = {
            intakeservicerequestid: this.id,
            isExpungementSuperUser: isExpungementSuperUser,
            iscaseexpunged: this.iscaseexpunged
        };
    }

    this._commonHttpService
        .getArrayList(
            {
                method: 'get',
                where: petitionReqObj
            },
            `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionListUrl}?filter`
        )
        .subscribe((item: any) => {
            if (item && item.length) {
                this.petitionDetailsFortpr = item;

                this.petitionList = item.map((actor: any) => {
                    const petition: any = {
                        intakeservicerequestpetitionid: actor.intakeservicerequestpetitionid,
                        associatedattorneys: actor.associatedattorneys,
                        petitionid: actor.petitionid,
                        petitiontypekey: actor.petitiontypekey,
                        actordetails: actor.intakeservicerequestpetitionactor,
                        parentdetails: Array.from(
                            new Map(
                                (
                                    actor.intakeservicerequestcourthearing?.flatMap(
                                        (hearing: any) => hearing.hearingparents || []
                                    ) || []
                                ).map((parent: any) => [
                                    parent.personid || parent.intakeservicerequestactorid || parent.petitionactortype,
                                    parent
                                ])
                            ).values()
                        )
                    };

                    this.petitonListDetails = petition;
                    return petition;
                });
            }

            callback?.();
        });
}


    private hearingOutcome() {
        this.hearingOutpcomeDetails$ = this._commonHttpService
            .getArrayList({
                method: 'get',
                where: {
                    
                    referencetypeid: 32,
                    teamtypekey: this._authService.getAgencyName()
                }
            },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.OutComeURL}?filter`)
                .pipe(
                    map(result => {
                        return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                    }));
        this.hearingOutpcomeDetails$.subscribe(data => {
            this.hearingOutpcomeDetails = data;
        });
    }
    private personsappeared() {
        this.personsappeared$ = this._commonHttpService
            .getArrayList({
                method: 'get',
                where: {
                    referencetypeid: 800,
                    teamtypekey: this._authService.getAgencyName()
                }
            },
            'referencevalues?filter').pipe(
                map(result => {
                    return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                }));
        this.personsappeared$.subscribe(data => {
            const list = ['Child' ,'Child’s Attorney', 'Case Worker','DSS Attorney','Guardian','Mother', 'Mother’s Attorney','Father','Father’s Attorney',
                          'CASA','Pre-adoptive Parent' ,'Foster Parent','Other'];
            this.personAppeared1 = [];
            list.forEach(item => {
              const obj = data.find(ele => ele.text === item);
              if(obj && obj !== undefined){
              this.personAppeared1.push(obj);
              }
            });
            this.personAppeared1 = data;
        });

    }
    private childPermanencyPlan() {
        this.childPermanencyPlanData = this._commonHttpService
            .getArrayList({
                method: 'get',
                where: {
                    tablename: 'Childpermanencyplan',
                    teamtypekey: 'CW'
                }
            },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.ChildpermanencyplanUrl}?filter`)
                .pipe(
                    map(result => {
                        return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                    }));
    }
    private getChecklist() {
        this.hearingData = [];
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let courtReqObj:any = {};
        if (isServiceCase) {
            courtReqObj = {
                objectid: this.id,
                objecttype: 'servicecase'
            };
        } else {
            courtReqObj = { intakeserviceid: this.id };
        }
        courtReqObj.isExpungementSuperUser= this._authService.isExpungementSuperUser();
        courtReqObj.iscaseexpunged= this.iscaseexpunged;
        forkJoin([
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: courtReqObj
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl}?filter`
            ),
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: {
                        checklisttypekey: 'COLANG'
                    }
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.checklistdisplayorder}?filter`
            ),
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: {
                        checklisttypekey: 'COPP'
                    }
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.ChecklistUrl}?filter`
            ),
            this._commonHttpService.getArrayList({},
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingTypeUrl}?filter={"where": {"teamtypekey": "CW"}, "nolimit":true,"order":"description"}`),
            this._commonHttpService.getArrayList({}, 'hearingstatustype' + '?filter={"nolimit":true,"order":"description"}'),
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: {
                        checklisttypekey: 'COHO'
                    }
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.ChecklistUrl}?filter`
            ),
        ]).subscribe((data) => {
            if (data) {
                if (data[0].length) {
                    this.courtDetailsList = data[0];
                }
                this.courtOrderColang = data[1];
                this.courtOrderCopp = data[2];
                data[3].forEach(type => {
                    this.hearingtypeArray[type.hearingtypekey] = type.description;
                });
                data[4].forEach(type => {
                    this.hearingstatustypeArray[type.hearingstatustypekey] = type.description;
                });
                this.courtOrderCoho = data[5];
                this.gethearingDetails();
            }
        });
    }
    changeSelectedChecklist(event: any, checklistKey: any, index: any) {
        const value = event.checked;
        if (checklistKey === 'COLANG') {
            const colang: any = this.courtOrderFormGroup.controls['courtordercolang'] as FormArray;
            colang.controls[index]['controls']['isselected'].patchValue(value);
            if (!value) {
                colang.controls[index]['controls']['remarks'].patchValue('');
            }
        } else if (checklistKey === 'COHO') {
            const coho: any = this.courtOrderFormGroup.controls['courtordercoho'] as FormArray;
            coho.controls[index]['controls']['isselected'].patchValue(value);
            if (!value) {
                coho.controls[index]['controls']['remarks'].patchValue(false);
            }
        } else {
            const copp: any = this.courtOrderFormGroup.controls['courtordercopp'] as FormArray;
            copp.controls[index]['controls']['isselected'].patchValue(value);
            if (!value) {
                copp.controls[index]['controls']['remarks'].patchValue(false);
            }
        }
    }

    selectHearing(event: any, hearing: any) {
        this.isHearingFill=false;
        this.qrtpplacementhearing = false;
        this.isEdit = true;
        if (event.target.checked) {
            this.bulkHearing.push(hearing)
        } else {
            const id = this.bulkHearing.length > 0
                                        ? this.bulkHearing.findIndex(
                                            (x: any) => x.intakeservicerequestcourthearingid === hearing.intakeservicerequestcourthearingid
                                            && x.intakeservicerequestactorid === hearing.intakeservicerequestactorid) : [];
            if (id > -1) {
                this.bulkHearing.splice(id, 1)
            }
        }
    }

    isHearingChecked(hearing: any) {
        if(this.bulkHearing.length>0) {
            return this.bulkHearing.some((x: any)=>
                x.intakeservicerequestcourthearingid === hearing.intakeservicerequestcourthearingid
                && x.intakeservicerequestactorid === hearing.intakeservicerequestactorid)
        }
        return false;
    }

    checkDisabled(hearing: any) {
        if(this.bulkHearing.length>0) {
            return this.isEdit && !this.bulkHearing.some((x: any)=>
                x.petitionid===hearing.petitionid
                && x.intakeservicerequestpetitionid === hearing.intakeservicerequestpetitionid
                && hearing.hearingtype.join(',')===x.hearingtype.join(','))
        }
        return false;
    }

    bulkEdit() {
        $('#edit-popup').modal('show');
    }

    isSetValidator(item: any) {
        if (item) {
            this.tprDetailsForm.controls['isdssappealed'].setValidators([Validators.required]);
            this.tprDetailsForm.controls['appealdate'].setValidators([Validators.required]);
            this.tprDetailsForm.controls['appealdate'].updateValueAndValidity();
            this.tprDetailsForm.controls['isdssappealed'].updateValueAndValidity();
        } else {
            this.tprDetailsForm.controls['isdssappealed'].clearValidators();
            this.tprDetailsForm.controls['appealdate'].clearValidators();
            this.tprDetailsForm.controls['appealdate'].updateValueAndValidity();
            this.tprDetailsForm.controls['isdssappealed'].updateValueAndValidity();
        }
    }

    cancelTRPDetails() {
        this.approvalDisable = false;
        this.isSetValidator(false);
        this.isHearingFill = false;
        this.tprDetailsForm.reset();
    }

    saveTprDetail(model: any) {
        const TprDetailInput =this.tprDetailsForm.getRawValue();
        TprDetailInput.intakeserviceid = null;
        TprDetailInput.servicecaseid = this.id;
        TprDetailInput.tprdetailsid = null;
        TprDetailInput.tprrecommendationid = null;
        if(this.parent2info) {
            TprDetailInput.intakeserviceid1 = null;
            TprDetailInput.tprrecommendationid1 = null;
        }
        TprDetailInput.isdssappealed = Number(model.isdssappealed);
        TprDetailInput.isappealed = model.isappealed ? 1 : 0;

        TprDetailInput.isdssappealed1 = Number(model.isdssappealed1);
        TprDetailInput.isappealed1 = model.isappealed1 ? 1 : 0;

        this.bulkHearing.forEach((element: any,i: any) => {
            TprDetailInput.childintakeactorid = element.intakeservicerequestactorid;
            element.istprcourtordercreated = true;
            this._commonHttpService.create(TprDetailInput, 'tprdetails/addtprdetail').subscribe(
                (item) => {
                     this.getChecklist();
                    this.tprListDetails = item;
                    if(this.bulkHearing.length === i+1){
                        this._alertService.success('TPR Details saved successfully');
                        this.isHearingFill = false;
                        $('#termination-ofparental').modal('hide');
                          $('#unsaved-work-popup').modal('hide');
                        this.tprDetailsForm.reset();
                        this.bulkHearing = [];
                    }
                },
                (error) => {
                    // No data or function to call
                }
            );
        });
    }


    private getTprDetails() {
        this.tprListDetails = [];

        this._commonHttpService.getArrayList(
            {
                where: {
                    servicecaseid: this.id ? this.id : null
                 },
                method: 'get',
                nolimit: true
            }, 'tprdetails/gettprdetails' + '?filter'
            ).subscribe((res) => {
            if (res && res.length) {
                this.tprListDetails = res;
            }

        });


    }

    checkTPRPlacement(data: any) {
        //If TPR completed and missing pre-adoptive placement
            const filterparentdetails =  this.petitionDetailsFortpr?.filter((item: any)=>(item.intakeservicerequestpetitionid === data.intakeservicerequestpetitionid));
            if(this.remainingPeople[0]?.roles && this.remainingPeople[0]?.roles.length && this.remainingPeople[0]?.roles[0]?.intakeservicerequestactorid) {
                    this.remainingPeople[0].intakeservicerequestactorid  = this.remainingPeople[0].roles[0].intakeservicerequestactorid;
            }
            this.tprDetailsForm.patchValue(
                {
                    intakeservicerequestactorid: this.remainingPeople[0]?.intakeservicerequestactorid,
                    tprdetailsid: null,
                    tprpetitiondate: (filterparentdetails && filterparentdetails.length) ? filterparentdetails[0].petitiondate: null,
                });
            if(this.remainingPeople && this.remainingPeople.length && this.remainingPeople.length > 1) {
                this.parent2info = true;
                if(this.remainingPeople[1]?.roles && this.remainingPeople[1]?.roles.length && this.remainingPeople[1]?.roles[0].intakeservicerequestactorid) {
                        this.remainingPeople[1].intakeservicerequestactorid  = this.remainingPeople[1].roles[0].intakeservicerequestactorid;
                }

                this.tprDetailsForm.patchValue(
                    {
                        intakeservicerequestactorid1: this.remainingPeople[1]?.intakeservicerequestactorid,
                        tprdetailsid1: null,
                        tprpetitiondate1: (filterparentdetails && filterparentdetails.length) ? filterparentdetails[0].petitiondate: null,
                    });
            }

            this.disableTprParentNameFields();
    }

    clearTPRDetails() {
        this.tprDetailsForm.reset();
    }

    private getAppealDecisionDropdown() {
        this.appealDecisionDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '29',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
                map(result => {
                    return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                }));
    }

    private getAuthorizedHcdmDropdown() {
        this.AuthorizedHcdmDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '500700',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
                map(result => {
                    return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                }));
    }
    private getMethodHealthCareDecisionDropdownMakerDropdown() {
        this.HealthCareDecisionDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '500701',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
                map(result => {
                    return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                }));
    }

    private getMethodServiceDropdown() {
        this.methodServiceDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '35',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
                map(result => {
                    return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                }));             
    }

    private getTerminationTypeDropdown() {
        this.terminationtypDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '30',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
                map(result => {
                    return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                }));
    }

    changePerson(id: any) {
        
        const personRelation = this.involvedPerson && this.involvedPerson.length ? this.involvedPerson.filter(item => item.intakeservicerequestactorid === id) : [];
        let personnameText;
        if (personRelation && personRelation.length > 0) {
            personnameText = `${personRelation[0].firstname} ${personRelation[0].lastname}`;
        } else {
            const unknownParent = this.involvedPerson.filter(item => item.intakeservicerequestactorid === id);
            if (unknownParent.length > 0) {
                personnameText = `${unknownParent[0].firstname} ${unknownParent[0].lastname};`
            }
        }

        this.tprDetailsForm.patchValue({
            parentname: personnameText
        });
        this.updateTPRForm();
    }


    private updateTPRForm(){
        if(this.tprRecommendationList && this.tprRecommendationList.courtorder && this.tprRecommendationList.courtorder[0].hearingstatustypekey === 'CONCULD'){

                const istrpcontested = this.tprRecommendationList.courtorder[0].hearingtype[0] === 'TGC';
                const istrpgranted = this.tprRecommendationList.courtorder[0].hearingoutcometypekey === 'TPRGRA';
                const tprdecisionon = this.tprRecommendationList.courtorder[0].courtorderdate;
                const tprpetitionon = this.tprRecommendationList.courtorder[0].petitiondate;

                this.tprDetailsForm.patchValue({
                    isgranted: istrpgranted,
                    iscontested: istrpcontested,
                    tprdecisiondate: tprdecisionon,
                    tprpetitiondate: tprpetitionon,
                    isdisabled: true
                });
        }
    }
    onEditCourtOrder(hearing: any, mode: any){
        this.isRequiredParentOrLegalGuardianSection =false;
        this.address = {  disable: !this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR), address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
        this.address2 = {  disable: !this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR), address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
    
        this.bulkHearing = [];
        this.bulkHearing.push(hearing);
        if(mode=='edit'){
            this.showhcdmdeleteicon = true;
        }else{
            this.showhcdmdeleteicon=false;
        }
        if (hearing?.hearingtype && this.hearingTypesRequiredForReasonableEffort.some(type => hearing.hearingtype.includes(type))) {
            this.isPopUpActivated = true;
        }
        this.isEdit = false;
        this.updateCourtOrder(mode)
        this.healthCareDecisionMakerForm.reset();
        this.getDecisionmakerinformation(hearing, mode);
    }

    updateCourtOrder(mode: any) {
        this.selectedhearingtype = this.bulkHearing[0]?.hearingtype;
        this.selectedhearingstaustype = this.bulkHearing[0]?.hearingstatustypekey;
        this.isHearingFill = true;
        if(this.bulkHearing.length > 0) {
            $('#edit-popup').modal('hide');
        }
        this.petitonListDetails.petitionid = this.bulkHearing[0]?.intakeservicerequestpetition.petitionid;
        this.selectedPetition = this.petitionList.find(item => item.intakeservicerequestpetitionid === this.bulkHearing[0].intakeservicerequestpetitionid);
        this.isTPR = this.selectedPetition?.petitiontypekey === 'GAPTPR';
        if(this.returnHearingClientDetailsFn()) {
            this.hearingclientdetailscheck(this.bulkHearing[0]);
        }


        this.courtOrderFormGroup.reset();
        this.courtOrderFormGroup.setControl('courtordercolang', this._formBuilder.array([]));
        this.courtOrderFormGroup.setControl('courtordercopp', this._formBuilder.array([]));
        this.courtOrderFormGroup.setControl('courtordercoho', this._formBuilder.array([]));
        this.QrtpcourtOrderFormGroup.setControl('clientDetails', this._formBuilder.array([]));
        this.courtOrderList = Object.assign({}, new CourtOrderList());

        this.hearingDetails = Object.assign(new HearingDetails(), this.bulkHearing[0]);
        if (this.hearingDetails && this.hearingDetails.hearingdatetime) {
            this.minDate = new Date(this.hearingDetails.hearingdatetime);
        }

        this.childRemovalEpisodeList = [];
        
        this.bulkHearing.forEach((h: any,i: any) => {
            this.setRemovalEpisode(h,this.setRemovalEpisodeDate, null, mode);   // CIDM-9083 setting removal episode data for the first time when court order is created
            this.checkHearingInfo(h, i);
            if (this.courtDetailsList.length) {
               this.checkCourtDetails(h, i, mode);
            } else {
                this.isRouting = false;
            }
        });

        this.setFormValues();
        const isIntakeservreqcourtorderid = this.courtOrderFormGroup.get('intakeservreqcourtorderid')?.value
        let isDocumentView;

        if (this.daStatus?.toLowerCase() === 'closed') {
            isDocumentView = false;
        } else {
            isDocumentView = !!isIntakeservreqcourtorderid;
        }

        this.isDocumentView = isDocumentView;
        this.setView(mode);
        setTimeout(() => {
            if(navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
                window.scrollTo(0, document.body.scrollHeight)
            }else{
            $('html, body').animate({
                scrollTop: $('#Hearing-Fill').offset().top - 280
            }, 10);
          }

        }, 300);
    }


    // Assosiated wtih updateCourtOrder method
    private returnHearingClientDetailsFn() {
        return this.bulkHearing[0]?.hearingclientdetails && this.bulkHearing[0]?.hearingclientdetails.length;
    }

    setView(mode: any) {
        if (mode === 'view') {
            this.courtOrderFormGroup.disable();
            this.QrtpcourtOrderFormGroup.disable();
            this.viewCourt = true;
        } else {
            this.courtOrderFormGroup.enable();
            this.QrtpcourtOrderFormGroup.enable();
            this.viewCourt = false;
        }
    }

    hearingclientdetailscheck(hearing: any){
        if(this.isTPR){
            this.remainingPeople = (hearing.hearingparents || []).map((parent: any) => ({
                ...parent,
                intakeservicerequestactorid: parent.intakeservicerequestactorid || parent.petitionactortype,
                personid: parent.personid || parent.petitionactortype,
                firstname: parent.name || 'Unknown',
                lastname: '',
                fullname:
                    parent.name === 'Unknown'
                        ? `${parent.petitionactortype} Unknown`
                        : (parent.name || `${parent.petitionactortype} Unknown`)
            }));
        }else{
        this.remainingPeople = hearing.hearingclientdetails.filter((item: { otherclientflag: number; })=>(item.otherclientflag === 1));
        }
      
         this.remainingPeople.forEach((i) =>{
             this.filterTprPartents.forEach((t) =>{
                 if(i.personid === t.personid) {
                     i.roles = t.roles;
                 }

             })

         })
         this.checkTPRPlacement(hearing);
    }

    setRemovalEpisode(hearing: any, isRemovalEpisodeDateSet: any, courtOrder: any, mode: any){
        this.childRemovalEpisodeList = [];
        if(this.childremovalList && this.childremovalList?.length>0){
            this.childremovalList.forEach((el: any) => {
                if(hearing 
                    && hearing?.personid 
                    && hearing?.personid === el?.personid 
                    && !this.childRemovalEpisodeList?.some(
                        (x: any)=>x.removalid === el?.removalid
                        )){
                    if(mode === 'edit') {
                        this.childRemovalEpisodeList.push(el);
                    }
                    if(isRemovalEpisodeDateSet && courtOrder && el?.removalid.toString() === courtOrder.removalepisode){
                    this.courtOrderFormGroup.patchValue({ removalepisode: el?.removalid });
                    this.courtOrderFormGroup.patchValue({ removalepisodeDate: this.getDateFormat(el?.removaldate) });
                    }
                }
            });
        }
    }

    checkHearingInfo(hearing: any, i: any) {

        if (!hearing.hearingtype) {
            return;
        }
        hearing.hearingtype.forEach((item: any) => {
            if (item === 'QRTP' || item === 'QRTPIH' || item === 'QRTPRH') {
               this.handleQRTPHearing(hearing, i);
            }
            if (item === 'TGC') {
                this.patchtprDetailsForm(hearing, true);
            } else if (item === 'TGU') {
                this.patchtprDetailsForm(hearing, false);
            }
        })
    }

    handleQRTPHearing(hearing: any, i: any) {
        this.isHearingFill = false;
        this.qrtpplacementhearing = true;
        const clientdetails = hearing.hearingclientdetails.find((item: { personid: any; }) => (item.personid === hearing.personid));
        if (!clientdetails) {
            return;
        }
        const control = this.QrtpcourtOrderFormGroup.controls['clientDetails'] as FormArray;
        control.push(this._formBuilder.group({
            clientname: clientdetails.clientname,
            casenumber: clientdetails.casenumber,
            dob: moment(clientdetails.dob).format(this.dtformat),
            judgename: hearing.judgename ? hearing.judgename : '',
        }));
        this.bulkHearing[i].clientdetails = {
            clientname: clientdetails.clientname,
            casenumber: clientdetails.casenumber,
            dob: moment(clientdetails.dob).format(this.dtformat),
            judgename: hearing.judgename ? hearing.judgename : '',
        }
        this.QrtpcourtOrderFormGroup.patchValue({
            clientname: clientdetails.clientname,
            casenumber: clientdetails.casenumber,
            dob: moment(clientdetails.dob).format(this.dtformat),
            judgename: hearing.judgename ? hearing.judgename : '',
        })
    }
    // Assosiated with checkHearingInfo method
    private returnJudgenameFn(hearing: any): any {
        return hearing.judgename ? hearing.judgename : '';
    }

    patchtprDetailsForm(hearing: any, isContestedFlag: any){
        this.tprDetailsForm.patchValue(
            {
                iscontested: isContestedFlag,
                childintakeactorid: hearing.intakeservicerequestactorid
            });
        if (this.remainingPeople && this.remainingPeople.length && this.remainingPeople.length > 1) {
            this.tprDetailsForm.patchValue(
                {
                    iscontested1: isContestedFlag,
                });
        }
    }
    checkCourtDetails(hearing: any, i: any, mode: any) {
        let courtOrder = this.courtDetailsList.find(item => ((item.intakeservicerequesthearingid === hearing.intakeservicerequestcourthearingid)
            && (item.intakeservicerequestactorid === hearing.intakeservicerequestactorid
                || item.intakeservicerequestactorid === hearing?.intakeservicerequestpetition.intakeservicerequestpetitionactor.intakeservicerequestactorid)
                && (item.personid === hearing.personid)
        ));
        if (courtOrder){
            this.courtOrderintakeservreqcourtorderid =courtOrder?.intakeservreqcourtorderid;
        }
        if (hearing.old_id) {
            courtOrder = this.courtDetailsList.find(item => ((item.intakeservicerequesthearingid === hearing.intakeservicerequestcourthearingid)
                && (item.personid === hearing.personid)
            ));
        }
        if (courtOrder) {
            this.setRemovalEpisodeDate = true;
            this.checkCourtOrder(courtOrder, i);
            this.setRemovalEpisode(hearing,this.setRemovalEpisodeDate, courtOrder, mode);
        } else {
            this.setRemovalEpisodeDate = false;
            this.setRemovalEpisode(hearing,this.setRemovalEpisodeDate, courtOrder, mode);
            this.uploadedFile = [];
            this.childPermanencyPlanKey = null;
            this.isRouting = false;
            this.approvalDisable = false;
        }
    }
    checkCourtOrder(courtOrder: any, i: any) {
        this.approvalStatusForm.patchValue({
            routingstatus: courtOrder.status,
            comments: courtOrder.comments ? courtOrder.comments : ''
        });
        if (this.roleId.role.name === 'apcs') {
            if (courtOrder.status === 'Review' || courtOrder.status === 'Rejected') {
                this.isSupervisorSubmit = false;
            } else {
                this.isSupervisorSubmit = true;
            }
        }
        if (Array.isArray(courtOrder.hearingoutcome)) {
            courtOrder.hearingoutcome = courtOrder.hearingoutcome.map((ho: any) => {
                return ho.hasOwnProperty('hearingoutcometypekey') ? ho.hearingoutcometypekey : ho;

            });
        }
        this.uploadedFile = courtOrder.attachments ? courtOrder.attachments : [];
        this.courtOrderList = courtOrder;
        this.objectId = this.courtOrderList.intakeservreqcourtorderid;
        this.childPermanencyPlanKey = courtOrder.childpermanencyplankey;
        if (courtOrder?.dob) {
            courtOrder.dob = moment(courtOrder.dob).format(this.dtformat);
        }
        if (courtOrder.otherpersonsappeared) {
            this.showothertext = true;
        } else {
            this.showothertext = false;
        }
        this.bulkHearing[i].intakeservreqcourtorderid = courtOrder.intakeservreqcourtorderid || null;
        this.courtOrderFormGroup.patchValue(courtOrder);
        this.QrtpcourtOrderFormGroup.patchValue(courtOrder);
    }

    getQrtpCourtordertosave(): Qrtpcourtorder {
        return this.QrtpcourtOrderFormGroup.getRawValue();
    }

    getCourtOrderToSave() {
        const courtDetails: CourtOrderAdd = this.courtOrderFormGroup.getRawValue();
        this.processCourtDetails(courtDetails);
        let hearingOutcomes = null;
        if (courtDetails.hearingoutcome && Array.isArray(courtDetails.hearingoutcome)) {
            hearingOutcomes = courtDetails.hearingoutcome.map(hOutcome => ({ 'hearingoutcometypekey': hOutcome }));
        }
        const courtOrderToSave = Object.assign({
            removalepisode: courtDetails.removalepisode,
            intakeservreqcourtorderid: courtDetails.intakeservreqcourtorderid,
            courtorderdate: courtDetails.courtorderdate,
            hearingoutcometypekey: null,
            remarks: courtDetails.remarks,
            intakeserviceid: null,
            servicecaseid: this.id,
            hearingoutcomedetails: hearingOutcomes,
            courtorderdelayremoval: courtDetails.courtorderdelayremoval,
            courtorderdelaytimeframe: courtDetails.courtorderdelaytimeframe,
            childpermanencyplankey: this.childPermanencyPlanKey,
            intakeservicerequestpetitionid: this.selectedPetition ? this.selectedPetition.intakeservicerequestpetitionid : null,
            intakeservreqcourtorderdetails: courtDetails.courtordercopp.concat(courtDetails.courtordercolang).concat(courtDetails.courtordercoho)
        });
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase) {
            courtOrderToSave.servicecaseid = this.id;
             // Sending Default value for intakeservicerequestid as the API throws error for null value
            courtOrderToSave.intakeservicerequestid = 'deda9fed-a731-4151-ab8b-5f6cef7b60c4';
        } else {
            delete courtOrderToSave.servicecaseid;
            courtOrderToSave.intakeserviceid = this.id;
        }
        courtOrderToSave.intakeservreqcourtorderdetails.map((item: any) => {
            item.isselected = (item.isselected && item.isselected !== '' && item.isselected !== '0') ? 1 : 0;
        });
        courtOrderToSave.attachment = this.uploadedFile;

        return courtOrderToSave;
    }
    processCourtDetails(courtDetails: any) {
        if (courtDetails.courtordercopp) {
            courtDetails.courtordercopp.forEach((item: any) => {
                delete item.description;
                item.checklisttypekey = 'COPP';
            });
        }
        if (courtDetails.courtordercolang) {
            courtDetails.courtordercolang = this.courtOrderColang.map(item => {
                return {
                    checklisttypekey: 'COLANG',
                    isselected: item.isselected ? '1' : '0',
                    remarks: item.remarks,
                    isRequired: item.isRequired ? '1' : '0',
                    checklistid: item.checklistid,
                    description: item.description
                };
            });
            courtDetails.courtordercolang.forEach((item: any) => {
                delete item.description;
                item.checklisttypekey = 'COLANG';
            });
        }
        if (courtDetails.courtordercoho) {
            courtDetails.courtordercoho.forEach((item: any) => {
                delete item.description;
                item.checklisttypekey = 'COHO';
            });
        }
    }
    validateqrtpCourtOrder(){
        this.saveqrtpcourtorder();
    }

    reasonableEffortCheck() {
        $('#reasonableEffortWarning').modal('hide');
    }

    validateCourtOrder() {
        if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value !='PAR' && this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid2')?.value){
            this.hcdmdelete(this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid2')?.value);
            this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid2')?.setValue(null);
            this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid2')?.setValue(null);
            this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.setValue(null);
            this.healthCareDecisionMakerForm.get('name2')?.setValue(null);
        }
        if(this.validateauthorizedhcdm()){
            return;
        }
        if(!this.isReasonableEffortMade && this.isPopUpActivated){
            $('#reasonableEffortWarning').modal('show');
            return;
        }
        if (this.courtOrderFormGroup.invalid) {
            this.displayValidationMessages =true;
            this.courtOrderFormGroup.markAllAsTouched();
            return;
        }
        const courtOrderToSave = this.getCourtOrderToSave();
        if (this.validateCheckList(courtOrderToSave.intakeservreqcourtorderdetails)) {
            if (this.hasAnyUploadInProgress()) {
                this._alertService.error('Document upload in progress, please wait.');
                return;
            }
            this.saveCourtOrder();

        } else {
            this._alertService.error('Please fill all mandatory fields!');
        }
    }

    private validateauthorizedhcdm(){
        if(this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.value === 'HCDM_OTH'){
            this.healthCareDecisionMakerForm.get('hcdmOther2')?.setValidators([Validators.required]);
            if(this.healthCareDecisionMakerForm.get('hcdmOther2')?.value==null){
                return true;
            }
        }else{
            this.healthCareDecisionMakerForm.get('hcdmOther2')?.clearValidators();
        }
        if(this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.value === 'HCDM_OTH'){
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.setValidators([Validators.required]);
            if(this.healthCareDecisionMakerForm.get('hcdmOther1')?.value==null){
                return true;
            }
        }else{
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.clearValidators();
        }
        return false;
    }
    
    private setServiceCaseDetails(QRTPOrder: any) {
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase) {
            QRTPOrder.servicecaseid = this.id;
        } else {
            delete QRTPOrder.servicecaseid;
            QRTPOrder.intakeserviceid = this.id;
        }

        return QRTPOrder;
    }

    private checkIfApprovalShouldBeDisabled(): boolean {
        return this._authService.selectedRoleIs(this.ivespecialist) ||
            this._authService.selectedRoleIs(this.ivesupervisor) ||
            this._authService.selectedRoleIs('IV-E Eligibility Analyst') ||
            this._authService.selectedRoleIs('IV-E Eligibility Administrator') ||
            this._authService.selectedRoleIs('IV-E Eligibility Quality Assurance') ||
            this.isCourtOrderEditable;
    }
    saveqrtpcourtorder(){
        let qrtpcourtOrderToSave: any = this.getQrtpCourtordertosave();
        qrtpcourtOrderToSave.intakeservicerequesthearingid = this.hearingDetails.intakeservicerequestcourthearingid;
        qrtpcourtOrderToSave.intakeservicerequestactorid = this.hearingDetails['intakeservicerequestactorid'];
        qrtpcourtOrderToSave.bulkHearing = this.bulkHearing;
        qrtpcourtOrderToSave = this.setServiceCaseDetails(qrtpcourtOrderToSave);

        qrtpcourtOrderToSave.intakeservicerequestpetitionid = this.selectedPetition ? this.selectedPetition.intakeservicerequestpetitionid : null;
        this._commonHttpService.create(qrtpcourtOrderToSave, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtOrderSaveUrl).subscribe(
            (item) => {
                this._alertService.success('Court Order details saved successfully!');
                // CIDM-6991,6992, 6993 IVE role changes
                this.approvalDisable = !this.checkIfApprovalShouldBeDisabled();
                this.getChecklist();
                this.isHearingFill = false;
                this.qrtpplacementhearing = false;
                this.bulkHearing=[];
            },
            (error) => {
                // No data or function to call
            }
        );
    }
    hcdmdelete(medicalConditionid: any) {
        this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.hcdmdelete;
        return this._commonHttpService.remove(medicalConditionid).subscribe();
      }
    saveCourtOrder() {
        const courtOrderToSave = this.getCourtOrderToSave();
        courtOrderToSave.intakeservicerequesthearingid = this.hearingDetails.intakeservicerequestcourthearingid;
        courtOrderToSave.intakeservicerequestactorid = this.hearingDetails['intakeservicerequestactorid'];
        courtOrderToSave.bulkHearing = this.bulkHearing;
        this._commonHttpService.create(courtOrderToSave, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtOrderSaveUrl).subscribe(
            (data) => {
                let dataoutput =data ? data : courtOrderToSave?.bulkHearing[0]?.intakeservreqcourtorderid;
                this.saveDecisionMakerInformation(dataoutput)
                if(this.healthcaredecisionmakerinformationidhcdmflag0Fields && this.deletehdcm){
                    this.hcdmdelete(this.healthcaredecisionmakerinformationidhcdmflag0Fields);
                  }
                this._alertService.success('Court Order details saved successfully!');
                if(this._authService.selectedRoleIs(this.ivespecialist) || this._authService.selectedRoleIs(this.ivesupervisor) || this.isCourtOrderEditable) {
                    this.approvalDisable = false;
                } else {
                    this.approvalDisable = true;
                }
                const istpr = this.afterSaveCourtOrder(courtOrderToSave);
                this.getChecklist();
                if(!istpr){
                    this.bulkHearing = [];
                }
                this.isHearingFill = false;
            },
            (error) => {
                // No data or function to call
            }
        );
    }

    saveDecisionMakerInformation(data: any) {
         this.courtOrderintakeservreqcourtorderid = data;
        let healthCareDecisionMakerForm = this.healthCareDecisionMakerForm.getRawValue();
        let req: any[] = [{
            objecttype: 'courtorder',
            objectid: this.courtOrderintakeservreqcourtorderid,
            personid: this.selectedHearing?.personid,
            healthcaredecisionmaker: healthCareDecisionMakerForm.healthcaredecision1,
            name: healthCareDecisionMakerForm.name1,
            authorizedhcdm: healthCareDecisionMakerForm.authorizedhcdm1,
            email: healthCareDecisionMakerForm.email1,
            phonenumber: healthCareDecisionMakerForm.phone1,
            addressline1: this.address.address1,
            addressline2: this.address.address2,
            city: this.address.city,
            state: this.address.state,
            zip: this.address.zipcode,
            otherhcdm: healthCareDecisionMakerForm.hcdmOther1,
            hcdmflag: 1,
            healthcaredecisionmakerinformationid :healthCareDecisionMakerForm.healthcaredecisionmakerinformationid1
        }, {
            objecttype: 'courtorder',
            objectid: this.courtOrderintakeservreqcourtorderid,
            personid: this.selectedHearing?.personid,
            healthcaredecisionmaker: healthCareDecisionMakerForm.healthcaredecision2,
            name: healthCareDecisionMakerForm.name2,
            authorizedhcdm: healthCareDecisionMakerForm.authorizedhcdm2,
            email: healthCareDecisionMakerForm.email2,
            phonenumber: healthCareDecisionMakerForm.phone2,
            addressline1: this.address2.address1,
            addressline2: this.address2.address2,
            city: this.address2.city,
            state: this.address2.state,
            zip: this.address2.zipcode,
            otherhcdm: healthCareDecisionMakerForm.hcdmOther2,
            hcdmflag: 0,
            healthcaredecisionmakerinformationid :healthCareDecisionMakerForm.healthcaredecisionmakerinformationid2
        }]

            req = req.filter((obj: any) => (obj.name !== null && obj.name !== '' && obj.name)||(obj.authorizedhcdm !== null && obj.authorizedhcdm !== '' && obj.authorizedhcdm));
            this._commonHttpService.create({data : req}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.Addhealthcaredecisionmakerinformation).subscribe();

    }
    deleteAnotherHealthCare() {
        this.isRequiredParentOrLegalGuardianButton = true ;
        this.isRequiredParentOrLegalGuardianSection=false;
        this.healthCareDecisionMakerForm.get('healthcaredecision2')?.reset();
        this.healthCareDecisionMakerForm.get('name2')?.reset();
        this.healthCareDecisionMakerForm.get('name2')?.clearValidators();
        this.healthCareDecisionMakerForm.get('name2')?.updateValueAndValidity();
        this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.reset();
        this.healthCareDecisionMakerForm.get('email2')?.reset();
        this.healthCareDecisionMakerForm.get('phone2')?.reset();
        this.healthCareDecisionMakerForm.get('hcdmOther2')?.reset();
        this.address2.disable = false;
        this.deletehdcm=true;
    }
      

    afterSaveCourtOrder(courtOrderToSave: any) {
        const tpr = courtOrderToSave.hearingoutcomedetails.filter((x: any) => x.hearingoutcometypekey === 'TPRGRA' || x.hearingoutcometypekey === 'TPRDEN')
        let istpr=false;
        if (tpr && this.isValidCourtOrder(courtOrderToSave)) {
            if (courtOrderToSave.hearingoutcomedetails && courtOrderToSave.hearingoutcomedetails.length) {
                courtOrderToSave.hearingoutcomedetails.forEach((hearing: any) => {
                    if (hearing.hearingoutcometypekey === 'TPRGRA' || hearing.hearingoutcometypekey === 'TPRDEN') { 
                        this.hearingoutcometypekeycheck(hearing,courtOrderToSave);
                        $('#termination-ofparental').modal('show');
                        this.disableTprParentNameFields();
                        istpr=true;
                    }
                });
            }
        }
        return istpr;
    }

    hearingoutcometypekeycheck(hearing: any,courtOrderToSave: any){
        if (hearing.hearingoutcometypekey === 'TPRGRA') {
            this.patchtprValues(courtOrderToSave, true);
        } else if (hearing.hearingoutcometypekey === 'TPRDEN') {
            this.patchtprValues(courtOrderToSave, false);
        }

    }

    isValidCourtOrder(courtOrderToSave: { childpermanencyplankey: string; }){
        return (this.selectedhearingtype.includes('TGC') || this.selectedhearingtype.includes('TGU'))
            && ((this.selectedPetition?.petitiontypekey === 'GAPTPR') || (this.selectedPetition?.petitiontypekey === 'Waiver'))
            && ((courtOrderToSave.childpermanencyplankey === 'ABN') || (courtOrderToSave.childpermanencyplankey === 'PRA'))
            && this.selectedhearingstaustype === 'CONCULD';
    }

    patchtprValues(courtOrderToSave: any, grantFlag: any){
        this.tprDetailsForm.patchValue(
            {
                isgranted: grantFlag,
                tprdecisiondate: new Date(courtOrderToSave.courtorderdate),
                intakeservreqcourtorderid: courtOrderToSave.intakeservicerequestpetitionid
            });
        if (this.remainingPeople && this.remainingPeople.length && this.remainingPeople.length > 1) {
            this.tprDetailsForm.patchValue(
                {
                    isgranted1: grantFlag,
                    tprdecisiondate1: new Date(courtOrderToSave.courtorderdate),
                    intakeservreqcourtorderid1: courtOrderToSave.intakeservicerequestpetitionid
                });
        }
        this.tprDetailsForm.get('tprpetitiondate')?.disable();
        this.tprDetailsForm.get('tprpetitiondate1')?.disable();
        this.tprDetailsForm.get('isgranted')?.disable();
       this.tprDetailsForm.get('isgranted1')?.disable();
       this.tprDetailsForm.get('tprdecisiondate')?.disable();
       this.tprDetailsForm.get('tprdecisiondate1')?.disable();
       this.tprDetailsForm.get('iscontested')?.disable();
       this.tprDetailsForm.get('iscontested1')?.disable();
       
       this.disableTprParentNameFields();
        
    }

    

    hasAnyUploadInProgress() {
        if (this.uploadedFile.length === 0) {
            return false;
        }
        const inProgressAttachments = this.uploadedFile.filter(attachment => {
            if (attachment && attachment.hasOwnProperty('percentage') && attachment.percentage !== 100) {
                return true;
            } else {
                return false;
            }
        });

        if (inProgressAttachments.length > 0) {
            return true;
        }

        return false;
    }
    routingUpdate() {
        const routingObject = {
            objectid: this.courtOrderList.intakeservreqcourtorderid,
            eventcode: 'CORR',
            status: this.approvalStatusForm.controls['routingstatus'].value,
            comments: this.approvalStatusForm.controls['comments'].value,
            notifymsg: '',
            routeddescription: ''
        };
        this._commonHttpService.create(routingObject, 'routing/routingupdate').subscribe((res) => {
            this._alertService.success('saved successfully!');
            this.isSupervisorSubmit = true;
            this.getChecklist();
        }, (error) => {
            // No data or function to call
        });
    }

    gethearingDetails() {
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let hearingReqObj = {};
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        if (isServiceCase) {
            hearingReqObj = {
                objectid: this.id,
                objecttype: 'servicecase',
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        } else {
            hearingReqObj = { 
                intakeservicerequestid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
            };
        }
        if (this.id) {
            this._commonHttpService
                .getArrayList(
                    {
                        method: 'get',
                        where: hearingReqObj
                    },
                    `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.getHearingUrl}?filter`
                )
                .subscribe(
                    (result) => {
                        this.hearingUrlResponseFn(result);
                    },
                    (error) => {
                        // No data or function to call
                    }
                );
        }
    }

    private hearingUrlResponseFn(result: any[]) {
        if (Array.isArray(result) && result.length) {
            this.hearingDetails = result[0];

            this.hearingData = [];
            this.processhearingDetails(result);

            this.hearingData = _.orderBy(this.hearingData, ['hearingdatetime'], ['desc']);
            this.hearingData.forEach((hearing) => {
                hearing.hearingdatetime = moment(hearing.hearingdatetime).format('YYYY-MM-DD hh:mm A');
            });
            if (this.retrydoc) {
                const courthearingid = this.storage.getItem('courthearingid');
                const hearingListCheck = this.hearingData.find(item => item?.intakeservicerequestcourthearingid === courthearingid);
                if (hearingListCheck) {
                    this.onEditCourtOrder(hearingListCheck, 'view');
                    this.disableEdit('true');
                    this.retrydoc = false;
                }
            }
            this.paginationItems();
        } else {
            this.isHearingFill = false;
        }
        this.cdr.markForCheck();
    }

    processhearingDetails(hearingDetails: any) {
        hearingDetails.forEach((res: any) => {
            if ((!res.old_id) && res.hearingstatustypekey !== 'SCHULD') {
                this.scheduledhearingStatus(res);
            }

            if ((res.old_id || res?.intakeservicerequestpetition.intakeservicerequestpetitionactor.length === 0) && res.hearingstatustypekey !== 'SCHULD') {
                this.notScheduledhearingStatus(res);
            }
        });
    }
    scheduledhearingStatus(hearingDetail: any) {
        const actorList = hearingDetail?.intakeservicerequestpetition.intakeservicerequestpetitionactor.filter((item: any) => item.petitionactortype === 'PA');
        const list = actorList.map((actor: any) => {
            const obj = Object.assign({}, hearingDetail);
            obj.intakeservicerequestpetition.intakeservicerequestpetitionactor = actor;
            if (actor.intakeservicerequestactor) {
                const person = actor.intakeservicerequestactor.person;
                obj.personid = person.personid;
                obj.personname = person.fullname;
                obj.intakeservicerequestactorid = actor.intakeservicerequestactor.intakeservicerequestactorid;                
            }
            obj.petitionid = hearingDetail?.intakeservicerequestpetition.petitionid;
            if (this.courtDetailsList.length) {
                const courtOrder = this.courtDetailsList.find(item => ((item.intakeservicerequesthearingid === hearingDetail.intakeservicerequestcourthearingid)
                    && (item.intakeservicerequestactorid === obj.intakeservicerequestactorid)));
                if (courtOrder) {
                    obj.isEditable = (this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)
                        || this._authService.selectedRoleIs(this.ivespecialist)
                        || this._authService.selectedRoleIs(this.ivesupervisor)
                        || this._authService.selectedRoleIs('DHS Legal Attorney') || this.isCourtOrderEditable);
                } else {
                    if (this._authService.readonlyButton('read_only_access', 'caseworker-court-order-add')) {
                        obj.isEditable = true;
                    } else {
                        obj.isEditable = false;
                    }
                }
                if (
                    (hearingDetail.hearingtype?.includes('TGC') ||
                        hearingDetail.hearingtype?.includes('TGU')) &&
                    !hearingDetail.istprcourtordercreated
                ) {
                    obj.isEditable = true;
                }
            } else {
                obj.isEditable = true;
            }
            return obj;
        });
        this.hearingData = this.hearingData.concat(list);
    }
    notScheduledhearingStatus(hearingDetail: any) {
        const clientList = (hearingDetail.hearingclientdetails) ? hearingDetail.hearingclientdetails : [];
        const actorList = clientList.filter((item: { otherclientflag: number; }) => item.otherclientflag === 0);
        const list = actorList.map((actor: any) => {
            const obj = { ...hearingDetail };
            obj.intakeservicerequestpetition.intakeservicerequestpetitionactor = actor;
            if (actor) {
                obj.personid = actor.personid;
                obj.personname = actor.clientname;
                obj.intakeservicerequestactorid = actor.intakeservicerequestactorid;
            }
            obj.petitionid = hearingDetail?.intakeservicerequestpetition.petitionid;
            if (this.courtDetailsList.length) {
                const courtOrder = this.courtDetailsList.find(item => (item.intakeservicerequesthearingid === hearingDetail.intakeservicerequestcourthearingid)
                );
                if (courtOrder) {
                    obj.isEditable = (this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)
                        || this._authService.selectedRoleIs(this.ivespecialist)
                        || this._authService.selectedRoleIs(this.ivesupervisor)
                        || this._authService.selectedRoleIs('DHS Legal Attorney') || this.isCourtOrderEditable);
                } else {
                    this.handleEditableAccessFn(obj);
                }
            } else {
                obj.isEditable = true;
            }
            return obj;
        });
        this.hearingData = this.hearingData.concat(list);
    }
    // Assosiated with notScheduledhearingStatus method
    private handleEditableAccessFn(obj: any) {
        if (this._authService.readonlyButton('read_only_access', 'caseworker-court-order-add')) {
            obj.isEditable = true;
        } else {
            obj.isEditable = false;
        }
    }

    private validateCheckList(checkList: any) {
        if (!checkList) {
            return false;
        }
        const checkData = checkList.filter((data: { isselected: string; }) => data.isselected === '');
        return checkData.length === 0;
    }


    // speech recognition
    activateSpeechToText(): void {
        this.recognizing = true;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            this._speechRecognitionService.record().subscribe(
                // listener
                (value) => {
                    this.speechData = value;
                    this.courtOrderFormGroup.patchValue({ remarks: this.speechData });
                },
                // error
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

    uploadFile(data: any): void {
        const  file: File = data.file;
        const  category = data.category;
        const  subCategory = data.subCategory;
        const  date = data.date;

        if (!(file instanceof Array)) {
            return;
        }
        file.map((item) => {
            const fileExt = item.name
                .toLowerCase()
                .split('.')
                .pop();
            if (
                ['mp3','ogg','wav','acc','flac','aiff','mp4','mov','avi','3gp','wmv','mpeg-4','pdf','txt','docx','doc','xls','xlsx',
                'jpeg','jpg','png','ppt','pptx','gif','cr2','rtf'].includes(fileExt)
            ) {
                const isExist = this.uploadedFile.filter((data1: any) => (data1 === item));
                if (isExist.length === 0) {
                    this.uploadedFile.push(item);
                }
                const uindex = this.uploadedFile.length - 1;
                if (!this.uploadedFile[uindex].hasOwnProperty('percentage')) {
                    this.uploadedFile[uindex].percentage = 1;
                }

                this.uploadAttachment(uindex,category,subCategory,date);
                const audioExt = ['mp3', 'ogg', 'wav', 'acc', 'flac', 'aiff'];
                const videoExt = ['mp4', 'avi', 'mov', '3gp', 'wmv', 'mpeg-4'];
                if (audioExt.indexOf(fileExt) >= 0) {
                    this.uploadedFile[uindex].attachmenttypekey = 'Audio';
                } else if (videoExt.indexOf(fileExt) >= 0) {
                    this.uploadedFile[uindex].attachmenttypekey = 'Video';
                } else {
                    this.uploadedFile[uindex].attachmenttypekey = 'Document';
                }
            } else {
                this._alertService.error(`${fileExt} format can't be uploaded`);
            }
        });
    }
    uploadAttachment(index: any,category: any,subCategory: any,date: any) {
        let uploadUrl = '';
        uploadUrl = `${AppConfig.baseUrl}/${CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl}?srno=${this.caseNumber}
                        &objecttypekey=courtorder&objectid=${this.courtOrderList.intakeservreqcourtorderid}&actualdocumentdate=${date}&servicecaseid=${this.id}`;

    if(category !== ''&& subCategory !== ''&& date !== ''){
        this._uploadService
            .upload({
                url: uploadUrl,
                headers: new HttpHeaders().set('ctype', 'file'),
                filesKey: ['file'],
                files: this.uploadedFile[index],
                process: true,
            })
            .subscribe(
                (response) => {
                    if (response.status) {
                        this.uploadedFile[index].percentage = response.percent;
                    }
                    if (response.status === 1 && response.data) {
                        const doucumentInfo = response.data;
                        doucumentInfo.documentdate = doucumentInfo.date;
                        doucumentInfo.title = subCategory;
                        doucumentInfo.name = doucumentInfo.originalfilename;
                        doucumentInfo.objecttypekey = 'courtorder';
                        doucumentInfo.rootobjecttypekey = 'courtorder';
                        doucumentInfo.servicerequestid = null;
                        this.uploadedFile[index] = { ...this.uploadedFile[index], ...doucumentInfo };
                        this._alertService.success('File Upload successful.');
                    }
                }, (err) => {
                    this._alertService.error('Upload failed due to Server error, please try again later.');
                    this.uploadedFile.splice(index, 1);

                }
            );
    }
    }
    deleteAttachment() {
        this.uploadedFile.splice(this.deleteAttachmentIndex, 1);
        $('#delete-attachment-popup').modal('hide');
    }

    downloadFile(s3bucketpathname: any) {
        s3bucketpathname = s3bucketpathname.replace(/,/g, '');
        const  downldSrcURL = `/api ${s3bucketpathname}`;
        window.open(downldSrcURL, '_blank');
    }

    confirmDeleteAttachment(index: number) {
        $('#delete-attachment-popup').modal('show');
        this.deleteAttachmentIndex = index;
    }

    getChildRemoval() {
        const requestData = { ...this.getRequestParam(), ...{ isgroup: 0 } };
        this._commonHttpService
            .getSingle(
                {
                    where: requestData,
                    method: 'get'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .GetChildRemovalList}?filter`
            ).subscribe(response => {
                const list = (Array.isArray(response)) ? response : [];
                this.childremovalList = list.filter(item => item.approvalstatus === 'Approved');
                this.setchildRemovaldata();
            });
    }

    getRequestParam() {

        const intakeserviceid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let requestData;
        if (isServiceCase) {
            requestData = {
                objectid: intakeserviceid,
                objecttypekey: 'servicecase'
            };

        } else {
            requestData = { intakeserviceid: intakeserviceid };
        }
        return requestData;
    }

    loadDropDownList() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let url = '';

        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let reqObj = {};
        if (isServiceCase) {
            reqObj = {
                objectid: this.id,
                objecttypekey: 'servicecase',
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        } else {
            reqObj = {
                intakeserviceid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        }
        forkJoin([
            this._commonHttpService.getArrayList(
                {
                    where: { referencetypeid: '52', teamtypekey: this._authService.getAgencyName() },
                    method: 'get'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes}?filter`
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { referencetypeid: '53', teamtypekey: null, order: 'description asc' },
                    method: 'get'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes}?filter`
            ),
            this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: reqObj
                }),
                `${url}?filter`
            )
        ])
            .subscribe(([familyStructure, childRemovaltype, personobj]) => {
                this.familyStructure = familyStructure;
                this.childRemovaltype = childRemovaltype;
                this.involvedPerson = personobj['data'];
                this.filterTprPartents = personobj['data'];
                this.setchildRemovaldata();
            });
    }

    setchildRemovaldata() {
        const isValidfs = Array.isArray(this.familyStructure);
        const isValidcrt = Array.isArray(this.childRemovaltype);
        const isValiddata = Array.isArray(this.childremovalList);
        if (isValidcrt && isValiddata && isValidfs) {
            this.childremovalList.forEach((element: any) => {
                const fsdesc = this.familyStructure.find((item: { ref_key: any; }) => item.ref_key === element.familystructuretypekey);
                element.fsdesc = (fsdesc) ? fsdesc.description : '';
                const cdtdesc = this.childRemovaltype.find((item: { ref_key: any; }) => item.ref_key === element.removaltypekey);
                element.cdtdesc = (cdtdesc) ? cdtdesc.description : '';
                const child = this.involvedPerson.find(item => item.personid === element.personid);
                element.childname = (child) ? child.fullname : '';
            });
        }
    }

    courtOrderLanguageChanged(item: any) {       //SonarQube grouped together the condition to reduce code complexity
        this.courtOrderColang.forEach(order => {
            if ((item.description === this.ReasonableEffortsMade
                                        && order.description === this.ReasonableEffortsNotMade)
                ||(item.description === this.ReasonableEffortsNotMade
                                        && order.description === this.ReasonableEffortsMade)
                ) {
                order.isselected = false;
                order.remarks = '';
                this.isReasonableEffortMade = item.isselected;
            }
        });
        this.courtOrderColang.forEach(order => {
            if ((item.description === 'Continuation of the child in the child\'s home is contrary to the child\'s welfare'
                                        && order.description === 'Continuation of the child in child\'s home is not contrary to the child\'s welfare')
                ||(item.description === 'Continuation of the child in child\'s home is not contrary to the child\'s welfare'
                                        && order.description === 'Continuation of the child in the child\'s home is contrary to the child\'s welfare')
               ) {
                order.isselected = false;
                order.remarks = '';
            }

        });
        this.courtOrderColang.forEach(order => {
            if ((item.description === 'Reasonable efforts were made to prevent removal' && order.description === 'Reasonable efforts were not made to prevent removal')
                ||(item.description === 'Reasonable efforts were not made to prevent removal' && order.description === 'Reasonable efforts were made to prevent removal')
                ) {
                order.isselected = false;
                order.remarks = '';
            }
        });
        this.courtOrderColang.forEach(order => {
            if ((item.description === 'Voluntary placement is in the best interest of the child'
                                        && order.description === 'Voluntary placement is not in the best interest of the child')
                ||(item.description === 'Voluntary placement is not in the best interest of the child'
                                        && order.description === 'Voluntary placement is in the best interest of the child')) {
                order.isselected = false;
                order.remarks = '';
            }
        });
    }

    hearingOutcomeText(value: any) {
        const obj = this.hearingOutpcomeDetails.find(item => item.value === value);
        return (obj) ? obj.text : '';
    }

    getDateTimeFormatted(date:any){
        if(date && moment(new Date(date)).isValid()) {
          return moment(new Date(date)).format('MM/DD/YYYY, hh:mm A');
        } else {
          return '';
        }
    }

    getDateFormat(date:any){
        if(date){
          return moment(date).format(this.dtformat);
        }else{
          return '';
        }
    }
    findingchkboxchange(event: any){
        if(event.checked){
        if(event.source.value === 'courtreview'|| event.source.value ==='childsneed') {
            this.QrtpcourtOrderFormGroup.patchValue({
                childneedcantmet: '',
                childpermanencyplan : '',
                childmosteffplan :''
            });
        } else if(event.source.value === 'childmosteffplan' || event.source.value === 'childneedcantmet' || event.source.value === 'childpermanencyplan') {
            this.QrtpcourtOrderFormGroup.patchValue({
                courtreview:'',
                childsneed: ''
            }) ;
        }
    }
}
selectpersonappeared(event: any){
   
    if(event.value.includes('OTH')){
         this.showothertext =true;
    } else {
        this.showothertext = false;
        this.QrtpcourtOrderFormGroup.patchValue({
            otherpersonsappeared : ''
        })
    }
}
printCourtOrder(hearing: any){
    this.petitonListDetails.petitionid = hearing?.intakeservicerequestpetition.petitionid;
        this.selectedPetition = this.petitionList.find(item => item.intakeservicerequestpetitionid === hearing.intakeservicerequestpetitionid);
        if (this.courtDetailsList.length) {
            let courtOrder = this.courtDetailsList.find(item => ((item.intakeservicerequesthearingid === hearing.intakeservicerequestcourthearingid)
                && (item.intakeservicerequestactorid === hearing.intakeservicerequestactorid )
                ));
            if (hearing.old_id) {
                courtOrder = this.courtDetailsList.find(item => ((item.intakeservicerequesthearingid === hearing.intakeservicerequestcourthearingid)
                && (item.personid === hearing.personid)
                ));
            }

            this.intakeservreqcourtorderid = courtOrder?.intakeservreqcourtorderid;
            const clientdetails = hearing.hearingclientdetails.find((item: { personid: any; })=>(item.personid === hearing.personid))
            this.courtcasenumber = clientdetails.casenumber;
        }
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if(isServiceCase){
            this.objecttypekey = "servicecase"
        }
    const modal = {
        count: -1,
        where: {
            documenttemplatekey: ['courtqrtp'],
            courtorderid: this.intakeservreqcourtorderid ? this.intakeservreqcourtorderid  : '',
            casenumber:this.courtcasenumber,
            objectid: this.id,
            objectkey: this.objecttypekey,
        },
        method: 'post'
      };
      this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
    .subscribe(res => {
      const blob = new Blob([new Uint8Array(res)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      const timestamp = moment(new Date()).format('MM/DD/YYYY HH:mm:ss');
      link.download = `courtorder-qrtp-.${timestamp}.pdf`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
}
checkqrtp(hearing: any){
    if(hearing.hearingtype.includes('QRTPIH') || hearing.hearingtype.includes('QRTPRH')){
        return true;
    } else {
        return false
    }
}

getErrorsMessage(ControlName: any, displayName: any){
        return this.courtOrderFormGroup.controls[ControlName].status === 'INVALID' 
            ? `Please enter valid ${displayName}`
            : null;
}

    itemPerPage = 10;
    currentPage = 1;
    permenantList: any[] = []

    totalRecords = this.permenantList.length;
    paginationItems() {
        if (this.hearingData.length !== 0) {
            this.permenantList = this.hearingData;
            this.totalRecords = this.hearingData.length;
            const startIndex = (this.currentPage - 1) * this.itemPerPage;
            const endIndex = startIndex + this.itemPerPage;
            const tempData = this.hearingData.slice(startIndex, endIndex);
            this.hearingData = [];
            this.hearingData.push(...tempData);
        }
    }

    pageChanged(pageNumber: any) {
        this.currentPage = pageNumber;
        this.hearingData = this.permenantList;
        const startIndex = (this.currentPage - 1) * this.itemPerPage;
        const endIndex = startIndex + this.itemPerPage;
        const tempData = this.hearingData.slice(startIndex, endIndex);
        this.hearingData = [];
        this.hearingData.push(...tempData);
    }
    editbtn:boolean=true;
    disableEdit(value?: any) {
        if (value) {
            this.editbtn = value;
        } else {
            this.editbtn = !this.editbtn;
        }
      
    }

    get courtClientDetails(): any {
        return this.QrtpcourtOrderFormGroup.get('clientDetails') as any;
    }

    get courtordercoppDetails(): any {
        return this.courtOrderFormGroup.get('courtordercopp') as any;
    }
    onAddAnotherHealthCare() {
        this.isRequiredParentOrLegalGuardianButton = false ;
        this.isRequiredParentOrLegalGuardianSection = true ;

        this.healthCareDecisionMakerForm.get('healthcaredecision2')?.setValue('PAR');
        this.healthCareDecisionMakerForm.get('name2')?.enable();
        this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.enable();
        this.healthCareDecisionMakerForm.get('email2')?.enable();
        this.healthCareDecisionMakerForm.get('phone2')?.enable();
        this.healthCareDecisionMakerForm.get('hcdmOther2')?.enable();
        this.address2.disable = false;
    }

    onchangeDecisionMaker() {
        if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value) {
            if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value == 'PAR') {
                this.isRequiredParentOrLegalGuardianButton = true ;
            } else {
                this.isRequiredParentOrLegalGuardianButton = false ;
                this.isRequiredParentOrLegalGuardianSection = false ;
            }
            if(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)){
                this.healthCareDecisionMakerForm.get('name1')?.enable();
                this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.enable();
                this.healthCareDecisionMakerForm.get('email1')?.enable();
                this.healthCareDecisionMakerForm.get('phone1')?.enable();
                this.healthCareDecisionMakerForm.get('hcdmOther1')?.enable();
            }
            this.address.disable = false;
        } else {
            this.isRequiredParentOrLegalGuardianButton = false ;
            this.isRequiredParentOrLegalGuardianSection = false ;
            this.healthCareDecisionMakerForm.get('name1')?.disable();
            this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.disable();
            this.healthCareDecisionMakerForm.get('email1')?.disable();
            this.healthCareDecisionMakerForm.get('phone1')?.disable();
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.disable();
            this.address.disable = true;
        }
    }

    getDecisionmakerinformation(hearing: any, mode: any) {
        if(mode === 'view') {
            this.healthCareDecisionMakerForm.get('healthcaredecision1')?.disable();
            this.address.disable = true;
            this.address2.disable = true;
        } else if(this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)){
            this.healthCareDecisionMakerForm.get('healthcaredecision1')?.enable();
            this.address.disable = false;
            this.address2.disable = false;
        }
        this.selectedHearing = hearing;
        this._commonHttpService.getArrayList({
            where:{
                personid: hearing?.personid,
                objectid:  this.courtOrderintakeservreqcourtorderid,
                objecttype: 'courtorder'
            } ,

            method: 'post'
        },
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.Gethealthcaredecisionmakerinformation}`
        ).subscribe(response => {
            let data = response[0]?.gethealthcaredecisionmakerinformation || [];
             let hcdmflag1Fields;
             let hcdmflag0Fields;
            if(data){
            hcdmflag1Fields = data?.find((item: any) => item.hcdmflag == 1);
            hcdmflag0Fields = data?.find((item: any) => item.hcdmflag !=1);
            }
            const addressDisableCheck = !((this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)|| this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER)) && mode == 'edit');
    
            this.isRequiredParentOrLegalGuardianSection = hcdmflag0Fields && hcdmflag0Fields?.healthcaredecisionmaker!= null ;

            this.healthCareDecisionMakerForm.get('healthcaredecision1')?.setValue(hcdmflag1Fields?.healthcaredecisionmaker);
            this.healthCareDecisionMakerForm.get('name1')?.setValue(hcdmflag1Fields?.name);
            this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.setValue(hcdmflag1Fields?.authorizedhcdm);
            this.healthCareDecisionMakerForm.get('email1')?.setValue(hcdmflag1Fields?.email)
            this.healthCareDecisionMakerForm.get('phone1')?.setValue(hcdmflag1Fields?.phonenumber);
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.setValue(hcdmflag1Fields?.otherhcdm);
            this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid1')?.setValue(hcdmflag1Fields?.healthcaredecisionmakerinformationid);
            this.address = {  disable: addressDisableCheck, address1: hcdmflag1Fields?.addressline1, address2: hcdmflag1Fields?.addressline2, city: hcdmflag1Fields?.city, state: hcdmflag1Fields?.state, county: null, zipcode: hcdmflag1Fields?.zip };

            this.healthCareDecisionMakerForm.get('healthcaredecision2')?.setValue(hcdmflag0Fields?.healthcaredecisionmaker);
            this.healthCareDecisionMakerForm.get('name2')?.setValue(hcdmflag0Fields?.name);
            this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.setValue(hcdmflag0Fields?.authorizedhcdm);
            this.healthCareDecisionMakerForm.get('email2')?.setValue(hcdmflag0Fields?.email);
            this.healthCareDecisionMakerForm.get('phone2')?.setValue(hcdmflag0Fields?.phonenumber);
            this.healthCareDecisionMakerForm.get('hcdmOther2')?.setValue(hcdmflag0Fields?.otherhcdm);
            this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid2')?.setValue(hcdmflag0Fields?.healthcaredecisionmakerinformationid);

            this.address2 = {   disable: addressDisableCheck, address1: hcdmflag0Fields?.addressline1, address2: hcdmflag0Fields?.addressline2, city: hcdmflag0Fields?.city, state: hcdmflag0Fields?.state, county: null, zipcode: hcdmflag0Fields?.zip };
            if(addressDisableCheck){
                this.healthCareDecisionMakerForm.get('healthcaredecision1')?.disable();
                this.healthCareDecisionMakerForm.get('name1')?.disable();
                this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.disable();
                this.healthCareDecisionMakerForm.get('email1')?.disable();
                this.healthCareDecisionMakerForm.get('phone1')?.disable();
                this.healthCareDecisionMakerForm.get('hcdmOther1')?.disable();
                this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid1')?.disable();
                this.healthCareDecisionMakerForm.get('healthcaredecision2')?.disable();
                this.healthCareDecisionMakerForm.get('name2')?.disable();
                this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.disable();
                this.healthCareDecisionMakerForm.get('email2')?.disable();
                this.healthCareDecisionMakerForm.get('phone2')?.disable();
                this.healthCareDecisionMakerForm.get('hcdmOther2')?.disable();
                this.healthCareDecisionMakerForm.get('healthcaredecisionmakerinformationid2')?.disable();
            }
            this.healthCareDecisionMakerForm.get('healthcaredecision2')?.disable();
            if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value == 'PAR' && this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR  ) && hcdmflag0Fields?.healthcaredecisionmaker== null && mode != 'view'){
                this.isRequiredParentOrLegalGuardianButton =true;
            }
            this.healthcaredecisionmakerinformationidhcdmflag0Fields= hcdmflag0Fields?.healthcaredecisionmakerinformationid || null;
               
               if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'PAR'){
                this.isRequiredParentOrLegalGuardianButton=false;
                this.isRequiredParentOrLegalGuardianSection = false;
              }
        });
    }

    
    getUserCounty() {
       
        const filter: any = {};
        this._commonHttpService
        
            .getAll(CaseWorkerUrlConfig.EndPoint.DSDSAction.MedicationPsychotopic.getusercounty + encodeURIComponent(JSON.stringify(filter)))
            .subscribe(res => {
                if (res && res.length > 0) {
                   const userCounty = res[0];
                   this.countyname = userCounty.countyname;
                    this.getpsychotropiccounty();
                }
            });
    }

    getpsychotropiccounty(){      
          
        this._commonHttpService.getArrayList(
            {
                where: { objecttype:  'psycotrophic-hcdm'},
                method: 'get',
                nolimit: true
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.MedicationPsychotopic.getcountygoliveconfig + '?filter'
        ).subscribe( response => {
            this.psychotropiccounty  = response[0];
            if(this.psychotropiccounty?.statewide){
                const statewidedate = this.psychotropiccounty?.statewide;
                if( moment(statewidedate).isSameOrBefore(moment(), 'day')){ 
                    this.showhcdmtaboncounty = true;
                }
            }else{
                if(this.psychotropiccounty){
                    let countylivedate = this.psychotropiccounty[`${this.countyname?.replace(/[.\s']/g, '').toLowerCase()}`];
                    if (countylivedate) {
                        if (moment(countylivedate).isSameOrBefore(moment(), 'day')) {
                            this.showhcdmtaboncounty = true;
                        }
                    } 
        
                }  
            }
        });
      
      }

      getParentLabel(index: number): string {
  return `Parent ${index + 1}`;
}

isHearingParent(client: any): boolean {
  return this.selectedPetition?.parentdetails?.some((parent: any) =>
    String(parent.personid || '').trim() === String(client.personid || '').trim()
  ) || false;
}

getOtherClients(hearing: any): any[] {
  return (hearing?.hearingclientdetails || []).filter((client: any) =>
    client.otherclientflag === 1 && !this.isHearingParent(client)
  ); 
}

private disableTprParentNameFields(): void {
    this.tprDetailsForm.get('intakeservicerequestactorid')?.disable({ emitEvent: false });
    this.tprDetailsForm.get('intakeservicerequestactorid1')?.disable({ emitEvent: false });
}

getSelectedParentName(): string {
    const actorId = this.tprDetailsForm?.get('intakeservicerequestactorid')?.value;

    const selectedParent = this.remainingPeople?.find(
        (person: any) => person?.intakeservicerequestactorid === actorId
    );

    if (!selectedParent) {
        return '';
    }

    return selectedParent?.clientname ||  selectedParent?.fullname || selectedParent?.name || '';
}


}
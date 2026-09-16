
import { map, pluck, share, takeUntil } from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin, Observable, Subject, Subscription } from 'rxjs';
import moment from 'moment';
import { DynamicObject, DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonDropdownsService, GenericService, SessionStorageService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../../../pages/case-worker/case-worker-url.config';
import { Form1080a } from '../../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { UserInfo } from '../../../../@core/entities/authDataModel';
import { AuthService } from '../../../../@core/services/auth.service';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { AppConfig } from '../../../../app.config';
import { IntakeStoreConstants } from '../../../../pages/newintake/my-newintake/my-newintake.constants';
import { AppConstants } from '../../../../@core/common/constants';
declare let $: any;
import { FormBuilder, FormGroup, FormArray,  Validators } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../../../pages/case-worker/_entities/caseworker.data.constants';
import { DsdsService } from '../../../../pages/case-worker/dsds-action/_services/dsds.service';
import { MatSelectChange } from '@angular/material/select';
import { NewUrlConfig } from '../../../../pages/newintake/newintake-url.config';
import { InvolvedPersonSearchResponse, PersonDsdsAction } from '../../../../pages/newintake/my-newintake/_entities/newintakeModel';
import { AttachmentService } from '../../../../pages/case-worker/dsds-action/attachment/attachment.service';
import { HelpPopoverComponent } from '../../help-popover/help-popover.component';
import { formatDate } from '@angular/common';

@Component({
    // tslint:disable-next-line:component-selector
    selector: "form-1080-a",
    templateUrl: "./form-1080-a.component.html",
    styleUrls: ["./form-1080-a.component.scss"],
    standalone: false
})
export class Form1080AComponent implements OnInit {
    @ViewChild(HelpPopoverComponent) helpPopoverComponent!: HelpPopoverComponent; 
    submitforapproval: string = 'InProcess';
    formType: string = 'form1080a';
    successpopupid: string = '#success-popup';
    jurisdictionwithchildresponsibility!: string;
    personid!: string;
    sex!: string;
    race!: string;
    enthnicity!: string;
    locationtypewhereincidentoccurred!: string;
    placementprovideratthetimeoftheincident!: string;
    countyjurisdictionwheretheincidentoccurred!: string;
    signatureofpersoncompletingthisreport!: string;
    form1080a!: FormGroup;
    formData: any;
    userRole: any;
    savedFormData: any;
    deletepopupid = '#delete-attachment';
    petitions: any;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    daNumber: string;
    id: string;
    formId!: string | undefined | null;
    action!: string;
    caseNumber: string;
    store: DynamicObject;
    userId: string;
    isSupervisor: boolean;
    status: string = 'In Progress';
    notifymsg!: string;
    tosecurityusersid!: string;
    baseUrl: string;
    userDetails: UserInfo;
    yesterdayDate: Date;
    isCW!: boolean;
    agency!: string;
    isServiceCase: any;
    involvedPerson: any[] = [];
    relationships: any[] = [];
    childListDetails: any[] = [];
    allegedMaltreatorListDetails: any[] = [];
    otherChildrenDetails: any[] = [];
    otherChildrenDetailsHouseHold: any[] = [];
    savedChildrenDetails: any[] = [];
    savedChildrenDetailsHouseHold: any[] = [];
    processedDaDetails: any;
    parentListDetails: any[] = [];
    selectedChildDetails: any;
    childList: any[] = [];
    source!: string;
    supervisorDropdownList: any[] = [];
    currentSuperVisorId!: string;
    personDSDSActions$!: Observable<PersonDsdsAction[]>;
    ethinicityDropdownItems$!: Observable<DropdownModel[]>;
    genderDropdownItems$!: Observable<DropdownModel[]>;
    ethinicityDropdownItems: DropdownModel[] = [];
    genderDropdownItems: DropdownModel[] = [];
    racetypeDropdownItems: DropdownModel[] = [];
    racetypeDropdownItems$!: Observable<DropdownModel[]>;
    private _dropDownService: CommonHttpService;
    private _involvedPersonSeachService: GenericService<InvolvedPersonSearchResponse>;
    personSearchResult: InvolvedPersonSearchResponse[] = [];
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _service: GenericService<Form1080a>;
    public _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private _commonService: CommonHttpService;
    private formBuilder: FormBuilder;
    private _router: Router;
    private _session: SessionStorageService;
    private _dsdsService: DsdsService;
    private _attachmentService : AttachmentService;
    isNew1080FormEntry = false;
    submitted = false;
    isAMrequired = true;
    incidentDate: any;
    countylist$!: Observable<DropdownModel[]>;
    locationTypes: string[] = ["Parental Home", "Relative Home", "Residential Treatment Center", "Diagnostic Treatment Center", "Family Foster Home", "Licensed Day Care", "DJS Treatment Center", "Other"];
    //Need to discuss with ba on the logic to pull this list of placement providers
    placementProviders: any[] = [];

    //History clearance custom table
    historyClearanceInfoColumns: string[] = [
        'Case',
        'Intake Date',
        'Primary Program Area',
        'Sub Program Area',
        'Role',
        'Comments',
    ];
    historyClearanceInfoKeys: any[] = [];
    historyClearanceInfoData: any[] = [];

    //Children information custom table
    childrenInfoTableColumns: string[] = [
        'Name',
        'Date of Birth',
        'Relationship to Victim',
        'CJAMS PID',
        'Action'
        
    ];
    childrenInfoTableKeys: any[] = [];
    childrenInfoTableData: any[] = [];
    childrenInfoTableDataHouseHold: any[] = [];
    selectedSupervisorId!: string;
    supervisorcomments: any;
    supvCommentsMandatory : boolean = false;
    private screenSub!: Subscription | undefined;
    isScreenEnabled: boolean = false;
    maxRapidResponseDate: Date = this.setMaxRapidResponseReviewDate();
    selectedPlacementId!: string;
    selectedPersonId!: string;
    isDataRefresh = false;
    private destroy$ = new Subject<void>();
    iscaseexpunged: any;

    constructor(private injector: Injector) {
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._router = injector.get<Router>(Router);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._service = this.injector.get<GenericService<Form1080a>>(GenericService);
        this._involvedPersonSeachService = this.injector.get<GenericService<InvolvedPersonSearchResponse>>(GenericService);
        this._attachmentService = this.injector.get<AttachmentService>(AttachmentService);
        
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.caseNumber = this._dataStoreService.getData("DANUMBER");
        this.store = this._dataStoreService.getCurrentStore();

        // source._value.DANUMBER
        this.userDetails = this._authService.getCurrentUser().user;
        this.userId = this._authService.getCurrentUser().user.securityusersid;
        this.daNumber = this._dataStoreService.getData(
            CASE_STORE_CONSTANTS.DA_NUMBER
        );
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        let d = new Date()
        d.setDate(d.getDate() - 1)
        this.yesterdayDate = d
        this.baseUrl = AppConfig.baseUrl;
        this.getRoutingUsers();
    }

    ngOnInit() {
         this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.clientLoadDropDown();
        this.getCountyList();
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        this.agency = this._authService.getAgencyName();
        this.isCW = false;
        if (this.agency === 'CW') {
            this.isCW = true;
        }
        //Alleged Maltreator not required in Service case
        if(this.isServiceCase) {
            this.isAMrequired = false;
        }
        //Default supervisor
        this.tosecurityusersid = this.userDetails?.userprofile?.supervisorid;
        this.initForm1080A();
        this.setScreenSub();
        this.route.paramMap.pipe(takeUntil(this.destroy$)).subscribe(params => {
            this.formId = params.get('id')?.split('?')[0];
            if (this.formId) {
                this.populateForm1080A();
            } else {
                this.getInvolvedPerson(); // For new forms in 'start' action mode get data
            }
        });
        this.route.queryParams.pipe(takeUntil(this.destroy$)).subscribe(params => {
            this.action = params.action;
            if (this.action === 'view') {
                this.form1080a.disable();
            } else {
                this.form1080a.enable();
            }
        });
        //in edit/view mode the formId and selectedpersonid would exist so should wait for this.populateForm1080A() to resolve first
        // this.getInvolvedPerson(); 
        
        //Setting check for changes on the SDM types
        const watchSdmFields = ['ischildfatality', 'isseriousphysicalinjury', 'ismaltreatment'];

        watchSdmFields.forEach(field => {
          this.form1080a.get(field)!.valueChanges.pipe(takeUntil(this.destroy$)).subscribe(() => this.handleSdmChangeInteraction());
        });

        
        //Fetching and populating SDM related fields
        if(this.action && this.action==='start') {
            //Prepopulating data only needed in the start mode
            //else we patch based on persisted response from db
            this.checkSDM();
            this.getIntakeDetails();
        }

        if(this.isSupervisor){
            this.form1080a.get('submitforapproval')?.setValidators([Validators.required]);
        } else {
            this.form1080a.get('submitforapproval')?.clearValidators();
        }
        this.form1080a.get('submitforapproval')?.updateValueAndValidity();

        this.enableDisableSupervisorComments();
    }

    enableDisableSupervisorComments(): void {
        const supervisorcomments = this.form1080a.get('supervisorcomments');
        if (this.isSupervisor) {
            supervisorcomments?.enable();
        } else {
            supervisorcomments?.disable();
        }
    }

    initForm1080A() {
        const currentDate = new Date();
        this.form1080a = this.formBuilder.group({
            //SDM details
            ischildfatality: [null, Validators.required],
            isseriousphysicalinjury: [null, Validators.required],
            ismaltreatment: [null, Validators.required],    
            justificationforchange: [null],
            dateofthiscfspicriticalincidentreport: [null],
            countyjurisdictionwheretheincidentoccurred: [null],
            datewhentheincidentoccurred: [null],
            dateldssbecameawareofincident: [null],
            jurisdictionwithchildresponsibility: [null],
            intakereferral: [null, Validators.required],
            screen: [{ value: null, disabled: true}],
            providereason: [{ value: null, disabled: true }],
            //Alleged Victim child details
            cjamspid: [null, Validators.required],
            personid: [null],
            dob: [null],
            dod: [null],
            sex: [null],
            race: [null],
            //Seems in the db, api they have misspelled Ethnicity so just matching to 'enthnicity' for now
            enthnicity: [null],
            wasthereanyotheropencaseinvolvingthischildatthetimeofincident: [null, Validators.required],
            wasthereacaseinvolvingthischildclosedwithin12monthsofincident: [null, Validators.required],
            wasthechildeverplacedoutsideofhomebeforetheincident: [null, Validators.required],
            didmostrecentoohplacementend12monthsofincident: [null, Validators.required],
            wasthechilddiagnosedwithamentalorphysicaldisability: [null, Validators.required],
            wasthechildbornsubstanceexposed: [null, Validators.required],
            wasthechildrecordupdatedwiththedateofdeathincjams: [null, Validators.required],
            locationtypewhereincidentoccurred: [null, Validators.required],
            specifylocation: [null],
            wasthechildinanoutofhomeplacementatthetimeoftheincident: [null, Validators.required],
            placementprovideratthetimeoftheincident: [null],
            maltreators: this.formBuilder.array([
                this.createMaltreatorForm()
            ]),
            parents: this.formBuilder.array([
                this.createParentForm()
            ]),
            narrativesummaryofhistory: [null],
            isthislocationthechildprimaryresidence: [null, Validators.required],
            listotherchildren: this.formBuilder.array([]),
            listotherchildrenHouseHold: this.formBuilder.array([]),
            releventinformation: [null, Validators.required],
            narrativesummaryofhistory1: [null],
            didthechildresideprimarilyatthislocation: [null,Validators.required],
            persons: this.formBuilder.array([]),
            dateldssheldtherapidresponsereview: [null],
            additionalrelevantinformation: [null],
            whatistheextentofanycurrentorpotentialmediainvolvementrelease: [null, Validators.required],
            signatureofpersoncompletingthisreport: [null],
            datecompleted: currentDate,
            submitforapproval: [null],
            supervisorcomments: [null],
            supervisornameVal: [null, Validators.required]
        });
    }

    populateForm1080A() {
        const inputRequest = {
            form1080aid: this.formId
        }
        this._service
            .getArrayList(
                {
                    where: inputRequest,
                    method: "get",
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.GetFormData + "?filter"
            )
            .pipe(takeUntil(this.destroy$))
            .subscribe(
                (response: any) => {
                    this.formData = response;
                    this.savedChildrenDetails = response["otherChildren"];
                    this.savedChildrenDetailsHouseHold = response["otherChildrenHouseHold"];
                    this.status = response["status"];
                    this.submitforapproval = response["status"] === 'Review' ? 'InProcess': response["submitforapproval"];
                    this.supervisorcomments = response["supervisorcomments"];
                    
                
                    //@simar: race seems to be a multiple option dropdown so the patchValue is breaking
                    //so need to parse the json string coming in response before patching it
                    // response["race"] = this.normalizeMultiSelect(response["race"]);
                    //If justification for change already has data then need to show it enabled and required
                    if (response["justificationforchange"]?.trim()) {
                        this.enableJustificationField();
                    }
                    response["screen"] = JSON.parse(response["screen"]);    //NOSONAR
                    response["dob"] = this.formatDate(response["dob"]);     //NOSONAR
                    response["dod"] = this.formatDate(response["dod"]);     //NOSONAR
                    if(response["personid"]) {
                        this.selectedPersonId = response["personid"];
                        this.selectedPlacementId = response["placementprovideratthetimeoftheincident"];
                        this.getPlacementDetails(response);
                    }
                    this.form1080a.patchValue(response);
                    //If the form not submitted yet, date of report reset to current date
                    if(this.status === 'In Progress') {
                        this.form1080a.patchValue({
                            dateofthiscfspicriticalincidentreport: new Date()
                        })
                    }
                    if(this.isSupervisor && this.status === 'Review'){
                        this.form1080a.get('submitforapproval')?.setValue(null);
                    }
                    //Pull all the involved person data once the selected person id (av child) is retrieved
                    this.getInvolvedPerson();
            });
    }

    getRoutingUsers() {
        this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'INTR' },
                method: 'post'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.SupervisorList
        ).subscribe(result => {
                this.supervisorDropdownList = result.data;                    
                const supervisorId = this.userDetails?.userprofile?.supervisorid;
                const name =  result?.data?.find(supervisor => 
                supervisor?.userid === supervisorId)?.username;
                if(name){
                    this.form1080a.controls['supervisornameVal'].setValue(supervisorId);
                }
            });
    }

    async getPage(cjamspid: string): Promise<{ data: any; count: number } | undefined>  {
        return this._involvedPersonSeachService
            .getPagedArrayList(
                {
                    limit: 1,
                    order: "asc",
                    page: 1,
                    count: -1,
                    where: {
                        "cjamspid": cjamspid,
                        "searchtype": "EXM",
                        "sortorder": "asc"
                    },
                    method: 'post'
                },
                NewUrlConfig.EndPoint.Intake.GlobalPersonSearchUrl
            ).pipe(
                map((result) => {
                    return {
                        data: result.data,
                        count: result.count
                    };
                })).toPromise();
    }

    getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
            return intakeStore.number;
        } else {
            return null;
        }
    }

    getCaseUuid() {
        let caseID = this.route.snapshot.parent?.parent?.parent?.params['id'];
        if (!caseID) {
            caseID = this.getIntakeNumber();
        }
        return caseID;
    }

    getCaseNumber() {
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        let caseNumber = null;
        if (caseInfo) {
            caseNumber = caseInfo.da_number;
        }
        return caseNumber;
    }

    isIntakeMode() {
        return this.getIntakeNumber() ? true : false;
    }

    getUniqueNumber() {
        if (this.isIntakeMode()) {
            return this.getIntakeNumber();
        } else {
            return this.getCaseUuid();
        }
    }

    getSource() {
        if (this.isServiceCase) {
            return AppConstants.CASE_TYPE.SERVICE_CASE;
        } else if (this.isIntakeMode()) {
            return AppConstants.CASE_TYPE.INTAKE;
        } else {
            return AppConstants.CASE_TYPE.CPS_CASE;
        }
        // need to add condition for adoption case
    }

    getRequestParam(personid: string) {
        let inputRequest: any;
        const caseID = this.getCaseUuid();
        this.source = this.getSource();
        if (this.isServiceCase) {
            inputRequest = {
                objectid: caseID,
                objecttypekey: 'servicecase',
            };
        } else if (this.isIntakeMode()) {
            inputRequest = {
                intakenumber: this.getIntakeNumber()
            };

        } else {
            inputRequest = {
                intakeserviceid: caseID
            };
        }
        if (personid) {
            inputRequest.personid = personid;
        }
        
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        inputRequest.isExpungementSuperUser= isExpungementSuperUser;
        inputRequest.iscaseexpunged = this.iscaseexpunged;
        return inputRequest;
    }

    getInvolvedPersonWithPersonID(personid: string) {
        const where = this.getRequestParam(personid);
        return this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GetAllRelationshipByPersonURL + '?filter'
            );
    }

    createMaltreatorForm() {
        return this.formBuilder.group({
            allegedmaltreatorname: [''],
            isthisalsothecasehead: [''],
            aliases: [''],
            dob1: [''],
            cjamspid1: [''],
            personid: [null],
            relationshiptovictim: ['', this.isAMrequired ? Validators.required : null],
            anychildwelfarehistoryinvolvingthisperson: ['', this.isAMrequired ? Validators.required : null],
            processedDaDetails: []
        });
    }

    // Method to create a FormGroup for each parent entry
    createParentForm() {
        return this.formBuilder.group({
            parentname: ['', Validators.required],
            parentrole: [false],
            parentrole1: [false],
            aliases1: [''],
            personid: [null],
            dob2: [''],
            cjamspid2: ['', Validators.required],
            relationshiptovictim1: [null, Validators.required],
            anychildwelfarehistoryinvolvingthisperson1: [null, Validators.required],
            processedDaDetails: []
        });
    }

    get maltreators(): FormArray {
        return this.form1080a.get('maltreators') as FormArray;
    }

    // Getter for FormArray
    get parents(): FormArray {
        return this.form1080a.get('parents') as FormArray;
    }

    //Custom table mapping helper
    historyClearnceTableMapping(data: any) {

        const columnMapping = {
            'Case': 'casenumber',
            'Intake Date': 'intakedate',
            'Primary Program Area': 'programarea',
            'Sub Program Area': 'subprogramarea',
            'Role': 'role'
        };
        //   <td>{{ option?.casenumber }}</td>
        //   <td>{{ option?.intakedate }}</td>
        //   <td>{{ option?.programarea }}</td>
        //   <td>{{ option?.subprogramarea }}</td>
        //   <td>{{ option?.role }}</td>

        let historyClearanceInfoData = [];
        historyClearanceInfoData = data?.map((e: any) => ({
            'Case': e.casenumber,
            'Intake Date': e.intakedate,
            'Primary Program Area': e.programarea,
            'Sub Program Area': e.subprogramarea,
            'Role': e.role
        }));

        this.historyClearanceInfoColumns = Object.keys(historyClearanceInfoData?.[0] || columnMapping)
        this.historyClearanceInfoKeys = Object.keys(historyClearanceInfoData?.[0] || columnMapping)
        return historyClearanceInfoData;
    }
    
    childrenInfoTableMapping(data: any) {
        let childrenInfoTableData = [];
        childrenInfoTableData = data
        this.childrenInfoTableColumns = ['Name', 'Date of Birth', 'Relationship to Victim', 'CJAMS PID', 'Action'];
        this.childrenInfoTableKeys = ['fullname', 'dob', 'relation', 'cjamspid', 'Action' ];
        return childrenInfoTableData;
    }

    childrenInfoTableMappingHouseHold(data: any) {
        let childrenInfoTableDataHouseHold = [];
        childrenInfoTableDataHouseHold = data
        this.childrenInfoTableColumns = ['Name', 'Date of Birth', 'Relationship to Victim', 'CJAMS PID', 'Action'];
        this.childrenInfoTableKeys = ['fullname', 'dob', 'relation', 'cjamspid', 'Action' ];
        return childrenInfoTableDataHouseHold;
    }


    private clientLoadDropDown() {
        const source = forkJoin([
            this._dropDownService.getArrayList(
                {
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.EthnicGroupTypeUrl + '?filter'
            ),
            this._dropDownService.create(
                {
                    where: { activeflag: 1 },
                    method: 'post',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.GenderTypeUrl + '/genderlist'
            ),
            this._dropDownService.getArrayList(
                {
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true,
                    order: 'typedescription'
                },
                NewUrlConfig.EndPoint.Intake.RaceTypeUrl + '?filter'
            ),
            this._dropDownService.getArrayList(
                {
                    method: 'get',
                    nolimit: true,
                    order: 'typedescription'
                },
                NewUrlConfig.EndPoint.Intake.MaritalStatusUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    ethinicities: result[0].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.ethnicgrouptypekey
                            })
                    ),
                    genders: result[1].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.gendertypekey
                            })
                    ),
                    racetype: result[2].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.racetypekey
                            })
                    ),
                    maritalstatus: result[3].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.maritalstatustypekey
                            })
                    )


                };
            }),
            share());
        // Subscribe to the source to get the data for your synchronous logic
        source.pipe().subscribe(dropdownData => {
            this.ethinicityDropdownItems = dropdownData.ethinicities;
            this.genderDropdownItems = dropdownData.genders;
            this.racetypeDropdownItems = dropdownData.racetype;
        });
        this.ethinicityDropdownItems$ = source.pipe(pluck('ethinicities'));
        this.genderDropdownItems$ = source.pipe(pluck('genders'));
        this.racetypeDropdownItems$ = source.pipe(pluck('racetype'));
    }
    async getPersonDSDSAction(model: any): Promise<any> {
        const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsCWUrl + `?personid=` + model.personid + `&cisclientid=` + model.cisclientid + `&mdm_id=` + model.mdm_id + '&filter';
    
        return new Promise((resolve, reject) => {
            this._dropDownService
                .getArrayList(
                    new PaginationRequest({
                        method: "get",
                        where: { intakerequestid: null }
                    }),
                    url
                )
                .pipe(share(), pluck("data"))
                .subscribe({
                    next: (data) => resolve(data),
                    error: (err) => reject(err)
                });
        });
    }
    getInvolvedPerson() {
        let getpersonlistreq = {};
        if (this.isCW && this.isServiceCase) {
            getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
        } else {
            getpersonlistreq = { intakeserviceid: this.id };
        }

        if (this.isIntakeMode()) {
            getpersonlistreq = { intakenumber: this.getIntakeNumber() };
        }

        this.getPersonDetails(getpersonlistreq);
    }

    getPersonDetails(getpersonlistreq: any) {
       
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let url = '';
    
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        getpersonlistreq['isExpungementSuperUser'] = isExpungementSuperUser;
        getpersonlistreq['iscaseexpunged'] = this.iscaseexpunged;
        this._commonService.getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 20,
                personpagelimit: 100,
                method: 'get',
                where: getpersonlistreq
            }),
            url + "?filter"
        ).pipe(takeUntil(this.destroy$)).subscribe(response => {
            if (response && response.data && response.data.length) {
                this.involvedPerson = response.data;
                this.checkinvolvedPersonroles();
                //Need to get relationship data before updating AM/Parent data
                if(this.selectedPersonId) {
                    this.getInvolvedPersonWithPersonID(this.selectedPersonId)
                    .pipe(takeUntil(this.destroy$))
                    .subscribe(response1 => {
                        if (Array.isArray(response1)) {
                            this.relationships = response1;
                            this.updatechildrelation(this.otherChildrenDetails);
                            this.updatechildrelation(this.otherChildrenDetailsHouseHold);
                        }
                        this.callonModifyParentsMaltreatorData();
                    });
                } else {
                  this.callonModifyParentsMaltreatorData();
                }
            }
        });
    }

    updatechildrelation(item:any) : void {
        item.forEach((child: any) => {
            const relationship = this.relationships.find(rel => rel.person2id === child.personid);
            if (relationship) {
                child.relation = relationship.relation;
            } else {
                child.relation = 'unknown';
            }
        });
    }

    callonModifyParentsMaltreatorData() : void {
        this.callDataRefresh();
        if(!this.isDataRefresh){
            this.onModifyParentsMaltreatorData();
        }
    }

    callDataRefresh() : void {
        if(this.isDataRefresh) {
            const personid = this.form1080a.get('personid')?.value;
            const mockEvent: MatSelectChange = {
                value: personid,
                source: {} as any
              };
          
            this.onChildSelect(mockEvent, true);
        }
    }
    
    checkinvolvedPersonroles() {
        this.involvedPerson.forEach(ele => {
            ele.dob =  ele.dob ? moment(ele.dob).format('MM/DD/YYYY') : null;
            ele.dateofdeath =  ele.dateofdeath ? moment(ele.dateofdeath).format('MM/DD/YYYY') : null;
            if (ele.roles) {
                const childArray = ['CHILD', 'AV', 'OTHERCHILD'];
                const roles = ele.roles.map((roleid: any) => roleid.intakeservicerequestpersontypekey);
                const smallerArray = childArray.length < roles.length ? childArray : roles;
                const largerArray = childArray.length >= roles.length ? childArray : roles;
                const isChildOrAV = smallerArray.some((val: any) => largerArray.includes(val));
                this.updateChildList(isChildOrAV, ele);
            }
        });
        this.checkinvolvedPersonrolesContinue();
    
    }

    updateChildList(isChildOrAV: any, ele: any) {
        if (isChildOrAV || parseInt(ele.age) <= 18) {
            this.childListDetails.push(ele);
            if (this.action === 'start') {
            this.otherChildrenDetails.push(ele);
            this.otherChildrenDetailsHouseHold.push(ele);
            } else {
                if(this.savedChildrenDetails.find(x => x.personid === ele.personid)){
                    this.otherChildrenDetails.push(ele);
                }
                if(this.savedChildrenDetailsHouseHold.find(x => x.personid === ele.personid)){
                    this.otherChildrenDetailsHouseHold.push(ele);
                }
            }
            this.childList.push({ personid: ele.personid, fullname: ele.fullname, userroles: ele.userroles });
        }
    }

    checkinvolvedPersonrolesContinue() : void {
        if(this.selectedPersonId && this.status==='In Progress') {
            this.selectedChildDetails = this.childListDetails.filter(person => person.personid === this.selectedPersonId);
            if (this.selectedChildDetails && this.selectedChildDetails.length) {
                const selectedDetails = this.selectedChildDetails[0];
                this.patchChildDemographicInfo(selectedDetails);
                this.populateAdditionalChildInfo(selectedDetails);
            }
        }
    }

    async onModifyParentsMaltreatorData() { // NOSONAR
        this.allegedMaltreatorListDetails = [];
        this.parentListDetails = [];

        //Ideally having fixed the race condition on calling the getInvolvedPerson() we should not have persons duplicating
        //but just adding a safeguard just in case to check if person with role already processed then skip
        const processedAMPersonIds = new Set<string>();
        const processedParentPersonIds = new Set<string>();

        for (const ele of this.involvedPerson) {
            if (ele.roles) {
                const amArray = ['AM'];
                const parentArray = ['PARENT', 'LG', 'ADOPTIVEPARENT'];
                const roles = ele.roles.map((roleid: any) => roleid.intakeservicerequestpersontypekey);
                const isAM = amArray.some(val => roles.includes(val));
                let relationshiptovictim = null;
                if (this.relationships && this.relationships.length) {
                    console.log(this.relationships);
                    let roleData = this.relationships.filter(rel => rel.person2id === ele.personid);
                    let roleDataPerson1 = this.relationships.filter(rel => rel.person1id === ele.personid);
                    relationshiptovictim = roleData[0]?.relation ? roleData[0]?.relation : 'unknown';
                    if (roleDataPerson1 && roleDataPerson1.length) {
                        relationshiptovictim = 'Self';
                    }
                }
                if (isAM) {
                    if (processedAMPersonIds.has(ele.personid)) {
                        continue; // Skip if person already processed
                    }
                    processedAMPersonIds.add(ele.personid);
                    const { fullname: allegedmaltreatorname, cjamspid: cjamspid1,
                        dob, programarea, userroles,
                         isheadofhousehold, aliasname } = ele;
                    const userrolesAry = userroles?.split(",").map((value: any) => value?.trim());
                    const subprograms= programarea?.map((program: any) => program?.subprogramkey?.trim());
                    let aliases = '';

                    if (Array.isArray(aliasname)) {
                      aliases = aliasname?.join(', ');
                    } else if (aliasname != null) {
                      aliases = aliasname;
                    }
                    const isthisalsothecasehead: any = isheadofhousehold ? true : false;
                    const dob1: any = dob ? moment(dob).format('MM/DD/YYYY') : null;
                    const personSearchRes: any = await this.getPage(cjamspid1);
                    const {personid = '',
                        cisclientid = '',
                        mdm_id = ''} = personSearchRes.data[0];
                    const personDSDSActionPayload = {
                        personid,
                        cisclientid,
                        mdm_id
                    }
                    const personDSDSActionData = await this.getPersonDSDSAction(personDSDSActionPayload);
                    let processedDaDetails = [];
                    //ICC, LG, PARENT, AM
                    //Initial Contact Caregiver, Adoptive Parent, Legal Guardian, Parent, or Alleged Maltreator
                    const validRoles = [
                        "Initial Contact Caregiver",
                        "Adoptive Parent",
                        "Legal Guardian",
                        "Parent",
                        "Alleged Maltreator"
                    ];
                    if(personDSDSActionData && personDSDSActionData.length){
                        const actionDaDetails = personDSDSActionData.map((data: any) => data.daDetails);
                         processedDaDetails = actionDaDetails.flat()
                            .filter((data: any) => data.datype !== 'Intake' &&
                                            data.danumber != this.caseNumber &&
                                            data.roles.some((role: any) => validRoles.includes(role)))
                            .map((data: any) => {
                            const {danumber:casenumber, datype: programareaDA, dasubtype:subprogramarea, datereceived: intakeDate, roles: roles1} = data;
                            return {
                                casenumber,
                                intakeDate,
                                programareaDA,
                                subprogramarea,
                                role: roles1?.join(", ")
                            };
                        })
                    }
                    const daDetailsArray: any = this.formBuilder.array([]);
                    processedDaDetails.forEach((detail: any) => {
                        daDetailsArray.push(this.formBuilder.group({
                            casenumber: [detail.casenumber || ''],  // Add default values
                            intakedate: [detail.intakeDate  ? moment(detail.intakeDate).format('MM/DD/YYYY') : ''],
                            programarea: [detail.programareaDA || ''],
                            subprogramarea: [detail.subprogramarea || ''],
                            role: [detail.role || '']
                        }));
                    });
                    let anychildwelfarehistoryinvolvingthisperson = null; //Need default value to be blank
                    if(this.formData) { 
                        anychildwelfarehistoryinvolvingthisperson = this.formData["maltreators"]?.filter((a: any) => a.personid = ele.personid)?.[0]?.anychildwelfarehistoryinvolvingthisperson;
                    } else {
                        if(processedDaDetails?.length>0) {
                            anychildwelfarehistoryinvolvingthisperson = this.isChildWelfareHistoryInvolvingThisPerson(userrolesAry, subprograms);
                        }
                    }

                    const maltreatorGroup = this.createMaltreatorForm();

                    maltreatorGroup.patchValue({
                        allegedmaltreatorname: allegedmaltreatorname || '',
                        isthisalsothecasehead: isthisalsothecasehead,
                        aliases: aliases,
                        dob1: dob1 || '',
                        cjamspid1: cjamspid1 || '',
                        personid: personid,
                        relationshiptovictim: relationshiptovictim || '',
                        anychildwelfarehistoryinvolvingthisperson: anychildwelfarehistoryinvolvingthisperson
                    });
                    
                    maltreatorGroup.setControl('processedDaDetails', daDetailsArray);

                    this.allegedMaltreatorListDetails.push(maltreatorGroup);
                }
                const isParent = parentArray.some(val => roles.includes(val));
                if (isParent) {
                    if (processedParentPersonIds.has(ele.personid)) {
                        continue; // Skip if person already processed
                    }
                    processedParentPersonIds.add(ele.personid);
                    const { fullname: parentname, cjamspid: cjamspid2,
                        dob,userroles,
                        programarea,
                        isheadofhousehold: parentrole, aliasname } = ele;
                        const userrolesAry = userroles.split(",").map((value: any) => value.trim());
                    const subprograms= programarea?.map((program: any) => program?.subprogramkey?.trim());
                    let aliases1 = '';

                    if (Array.isArray(aliasname)) {
                    aliases1 = aliasname?.join(', ');
                    } else {
                    aliases1 = aliasname;
                    }
                    const rolesPA = ele.roles.map((p: any) => p.intakeservicerequestpersontypekey);
                    const parentrole1 = rolesPA.includes('AM');
                    const relationshiptovictim1 = relationshiptovictim;
                    const dob2 = dob ? moment(dob).format('MM/DD/YYYY') : null;
                    const personSearchRes: any = await this.getPage(cjamspid2);
                    const {personid = '',
                        cisclientid = '',
                        mdm_id = ''} = personSearchRes.data[0];
                    const personDSDSActionPayload = {
                        personid,
                        cisclientid,
                        mdm_id
                    }
                    const personDSDSActionData = await this.getPersonDSDSAction(personDSDSActionPayload);
                    let processedDaDetails = [];
                    //ICC, LG, PARENT, AM
                    //Initial Contact Caregiver, Adoptive Parent, Legal Guardian, Parent, or Alleged Maltreator
                    const validRoles = [
                        "Initial Contact Caregiver",
                        "Adoptive Parent",
                        "Legal Guardian",
                        "Parent",
                        "Alleged Maltreator"
                    ];
                    if(personDSDSActionData && personDSDSActionData.length){
                        const actionDaDetails = personDSDSActionData.map((data: any) => data.daDetails);
                         processedDaDetails = actionDaDetails.flat()
                            .filter((data: any) => data.datype !== 'Intake' && // NOSONAR
                                            data.danumber != this.caseNumber &&
                                            data.roles.some((role: any) => validRoles.includes(role))) 
                            .map((data: any) => {  // NOSONAR
                            const {danumber:casenumber, datype: programareaPA, dasubtype:subprogramarea, datereceived: intakeDate, roles: roles1} = data;
                            return {
                                casenumber,
                                intakeDate,
                                programareaPA,
                                subprogramarea,
                                role: roles1?.join(", ")
                            };
                        })
                    }
                    const daDetailsArray: any = this.formBuilder.array([]);
                    processedDaDetails.forEach((detail: any) => {  // NOSONAR
                        daDetailsArray.push(this.formBuilder.group({
                            casenumber: [detail.casenumber || ''],  // Add default values
                            intakedate: [detail.intakeDate  ? moment(detail.intakeDate).format('MM/DD/YYYY') : ''],
                            programarea: [detail.programareaPA || ''],
                            subprogramarea: [detail.subprogramarea || ''],
                            role: [detail.role || '']
                        }));
                    });
                    let anychildwelfarehistoryinvolvingthisperson = null; //Need default value to be blank
                    if(this.formData) { 
                        anychildwelfarehistoryinvolvingthisperson =  this.formData["parents"]?.filter((a: any) => a.personid = ele.personid)?.[0]?.anychildwelfarehistoryinvolvingthisperson;
                    } else {
                        if(processedDaDetails?.length>0) {
                            anychildwelfarehistoryinvolvingthisperson = this.isChildWelfareHistoryInvolvingThisPerson(userrolesAry, subprograms);
                        }
                    }

                    const parentGroup = this.createParentForm(); 

                    parentGroup.patchValue({
                        parentname: parentname,
                        parentrole: parentrole,
                        parentrole1: parentrole1,
                        aliases1: aliases1,
                        personid: personid,
                        dob2: dob2,
                        cjamspid2: cjamspid2,
                        relationshiptovictim1: relationshiptovictim1,
                        anychildwelfarehistoryinvolvingthisperson1: anychildwelfarehistoryinvolvingthisperson
                        // processedDaDetails: daDetailsArray // seems it is its own form group so will patch separately
                    });

                    parentGroup.setControl('processedDaDetails', daDetailsArray);

                    this.parentListDetails.push(parentGroup);
                }

            }
        }
        if (this.allegedMaltreatorListDetails && this.allegedMaltreatorListDetails.length) {
            this.form1080a.setControl('maltreators', this.formBuilder.array(
                this.allegedMaltreatorListDetails
            ));
        }
        if (this.parentListDetails && this.parentListDetails.length) {
            this.form1080a.setControl('parents', this.formBuilder.array(
                this.parentListDetails
            ));
        
        }
        if (this.action != 'view') {
            this.form1080a.get('personid')?.enable();
        }
        if(this.isDataRefresh) {
            this.isDataRefresh = false;
            this.helpPopoverComponent.close();
        }
    }

    isChildWelfareHistoryInvolvingThisPerson(userroles: any, programarea: any) {
        // Relevant roles to check against
        const relevantRoles = new Set([
            "Initial Contact Caregiver",
            "Adoptive Parent",
            "Legal Guardian",
            "Parent",
            "Alleged Maltreator"
        ]);
    
        // Convert user roles array to a set
        const userRolesSet = new Set(userroles);
    
        // Check if any relevant role is present
        const hasRelevantRole = [...userRolesSet].some((role: any) => relevantRoles.has(role));
    
        // Extract subprogram keys
        const subprograms = programarea?.map((subprogramkey: any) => subprogramkey);
    
        // Required subprogram categories
        const requiredSubprograms = new Set(["IR", "AR", "Service Case"]);
    
        // Check if any subprogram matches required categories
        const hasMatchingSubprogram = subprograms?.some((subprogram: any) => requiredSubprograms.has(subprogram));
    
        // Auto-populate based on role and subprogram match
        return hasRelevantRole && hasMatchingSubprogram ? true : null;
    }
    removeChild(event: any) {
        const person = JSON.parse(event);
        this.otherChildrenDetails = this.otherChildrenDetails.filter(child => child.personid !== person.personid);
    }

    removeChildHouseHold(event: any) {
        const person = JSON.parse(event);
        this.otherChildrenDetailsHouseHold = this.otherChildrenDetailsHouseHold.filter(child => child.personid !== person.personid);
    }
    onChildSelect(event: MatSelectChange, dataRefresh = false) {    //NOSONAR
      
        const personid = event.value;
        // validation to check if person is having existing Review / In progress record.
        if (!dataRefresh && this._attachmentService.childHavingInprogressOrReviewRecordsFormABC('form1080a',personid)){
            this._alertService.warn('The selected child already has an active record.');
            this.form1080a.get('personid')?.reset();
        } else {

            this.selectedChildDetails = this.childListDetails.filter(person => person.personid === personid);
            this.otherChildrenDetails = this.childListDetails.filter(person => person.personid !== personid);
            this.otherChildrenDetailsHouseHold = this.childListDetails.filter(person => person.personid !== personid);
            if (this.selectedChildDetails && this.selectedChildDetails.length) {
                const selectedDetails = this.selectedChildDetails[0];
                this.getInvolvedPersonWithPersonID(selectedDetails.personid)
                    .subscribe(response => {
                        if (Array.isArray(response)) {
                            console.log(response);
                            this.relationships = response;
                            this.updatechildrelation(this.otherChildrenDetails);
                            this.updatechildrelation(this.otherChildrenDetailsHouseHold);
                            this.onModifyParentsMaltreatorData();
                        }
                    });
                
                //Populate child demographic info
                this.patchChildDemographicInfo(selectedDetails);
                //ADDITIONAL ALLEGED VICTIM CHILD INFORMATION
                this.populateAdditionalChildInfo(selectedDetails);
                //Get child prior case history and placements
                this.getPriorHistoryDetails(selectedDetails);
                this.getPlacementDetails(selectedDetails);
                if(this.isDataRefresh) {
                    this.helpPopoverComponent.close();
                    const popovers = document.querySelectorAll('div.custom-popover.show');

                    popovers.forEach(popover => {
                        popover.classList.remove('show');
                    });
                }
            }
        }
    }
    onLocationSelection() {
        this.form1080a.get('locationtypewhereincidentoccurred')?.valueChanges.subscribe(value => {
            if (value === 'Other') {
                this.form1080a.get('specifylocation')?.setValidators([Validators.required]);
            } else {
                this.form1080a.get('specifylocation')?.clearValidators();
            }
            this.form1080a.get('specifylocation')?.updateValueAndValidity();
        });
    }

    genderValue(key: string): string | null {
        if (!key || !this.genderDropdownItems) {
            return null;
        }
        const foundItem = this.genderDropdownItems.find(item => item.value === key);
        return foundItem ? foundItem.text : null;
    }
    
    ethnicityValue(key: string): string | null {
        if (!key || !this.ethinicityDropdownItems) {
            return null;
        }
        const foundItem = this.ethinicityDropdownItems.find(item => item.value === key);
        return foundItem ? foundItem.text : null;
    }

    private getRaceNames(raceData: any[]): string {
        if (!Array.isArray(raceData) || !this.racetypeDropdownItems.length) {
            return '';
        }
        
        // 1. Get the keys (e.g., 'BA', 'AS') from the incoming data
        const raceKeys = raceData.map(r => r?.racetypekey).filter(key => key);
        
        // 2. For each key, find the matching name in our dropdown list
        const raceNames = raceKeys.map(key => {
            const found = this.racetypeDropdownItems.find(item => item.value === key);
            return found ? found.text : '';
        }).filter(name => name); // Filter out any that weren't found
    
        // 3. Join the names into a single string
        return raceNames?.join(', ');
    }

    patchChildDemographicInfo(personDetails: any): void {
        if (!personDetails) return;
        /**
         * CPS case -> getpersonsbyinvestigationcw($1,$2,$3,$4,$5)
         * ethinicity:"Not Hispanic or Latino"
         * **gender:"F" 
         * 
         * Service Case -> getpersonsbyservicecase($1, $2, $3)
         * **ethinicity:"99"
         * gender:"Female"
         * 
         * Seems in service case the ethnicity is coming as ref key
         * & in other cases Gender is coming as ref key
         * Ideally we should make it consist response from the api
         * but for mapping the values from reference values on UI
         */
        const gender = this.isServiceCase ? personDetails.gender : this.genderValue(personDetails.gender);
        const ethnicity = this.isServiceCase ? this.ethnicityValue(personDetails.ethinicity) : personDetails.ethinicity;
        const racevaluestext =this.getRaceNames(personDetails?.race);

        this.form1080a.patchValue({
            cjamspid: personDetails.cjamspid,
            personid: personDetails.personid,
            dob: this.formatDate(personDetails.dob),
            dod: this.formatDate(personDetails.dateofdeath),
            sex: gender,
            race: racevaluestext,
            enthnicity: ethnicity
        });
        // could also trigger other population methods here if needed
        // this.populateAdditionalChildInfo(personDetails);
    }

    getCountyList() {
        this.countylist$ = this._commonService
            .create(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker
                    .SdmCountyListUrl
            ).pipe(
            map(result => {
                return result.map(
                    (res: any) =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyid
                        })
                );
            }));
    }



    checkSDM(){
        const res = this._dataStoreService.getData('form1080SDM_Data');
        let sdm;
        if(res) {
            if (this.isServiceCase) {
                const i = res[0].getservicecasesdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                sdm = res[0].getservicecasesdm[i];
            } else {
                const i = res[0].getintakeservicerequestsdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                sdm = res[0].getintakeservicerequestsdm[i];
            }
        }

        if (this.isIntakeMode() && !res) {
            sdm = this.store[IntakeStoreConstants.intakeSDM];
        }

        if (sdm) {
            this.populateSDM(sdm);
        }
    }

    populateSDM(sdm: any) {
        //@Simar: Might have to handle these differently when in Intake vs Investagtion/Service case
        //Patch the SDM fields
        this.form1080a.patchValue({
            ischildfatality: sdm.ischildfatality,
            isseriousphysicalinjury: sdm.isseriousphysicalinjury,
            ismaltreatment: sdm.ismaltreatment
        })
    }

    //Intake details
    getIntakeDetails() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        let intakenumber = this._dataStoreService.getData('da_intakenumber');
        if (this.isIntakeMode()) {
            intakenumber = this.getIntakeNumber();
        }
        this._commonService.create({
                    page: 1,
                    limit: 10,
                    where: {
                        intakenumber: intakenumber,
                        'isExpungementSuperUser': isExpungementSuperUser,
                        'iscaseexpunged': this.iscaseexpunged
                    }
                },
                NewUrlConfig.EndPoint.Intake.IntakenapshotReport
            ).subscribe(data => {
                let response = data;
                if (response && response.data && response.data.length > 0 && response.data[0]) {
                    let intakeDetails = response.data[0]
                    this.populateIntake(intakeDetails);
                } 
            });
    }

    populateIntake(intakeDetails: any) {
        //Patch the intake fields
        const intakeModel = intakeDetails?.jsondata;
        if (intakeModel) {
            const narrative = intakeModel?.narrative?.[0];
            const disposition = intakeModel?.disposition?.[0];
    
            let isScreenIn = null;
            const supDisposition = disposition?.supDisposition?.toLowerCase();
            if (supDisposition === 'scrnin') {
                isScreenIn = true;
            } else if (supDisposition === 'screenout') {
                isScreenIn = false;
            }
    
            this.incidentDate = narrative?.incidentdate ?  new Date(narrative?.incidentdate) : null;
            const dateReceived = intakeDetails?.datereceived ? new Date(intakeDetails.datereceived) : null;
    
            this.form1080a.patchValue({
                dateofthiscfspicriticalincidentreport: new Date(),
                countyjurisdictionwheretheincidentoccurred: intakeModel.officelocation || null,
                datewhentheincidentoccurred: this.incidentDate, //createdDate,
                dateldssbecameawareofincident: dateReceived,
                // jurisdictionwithchildresponsibility: ..., //Do we populate or user select ?
                intakereferral: intakeDetails.intakenumber || null,
                screen: isScreenIn ?? null,
                // providereason: ...,  //seems it will be user entered field when ScreenOut
            });
        }
    }
    

    onSupervisorSubmit() {
        if(this.validateIfSupervisorCommentsEntered()) {
            const processObject = {isSupervisorSubmit: true};
            this.saveAsDraft(processObject);
        } 
    }

    validateIfSupervisorCommentsEntered() : boolean {
        let isSelected = true;
        const selected = this.form1080a.get('submitforapproval')?.value;
        const supervisorcomments = this.form1080a.get('supervisorcomments')?.value;
        if(selected === 'ReturnToWorker') {
           if(supervisorcomments == null || supervisorcomments == '' || supervisorcomments == "" ) {
            this._alertService.warn('Please enter supervisor comments');
            isSelected = false;
           }
        } else if(selected === null){
            this._alertService.warn('Please select supervisor approval');
            isSelected = false;
        }

        return isSelected;
    }   

    // help popup navigation confirm save data
    helpPopupConfirm(value: any) : void {
        if(value && !this.isSupervisor){
            const processObject = {isSupervisorSubmit: this.isSupervisor};
            this.saveAsDraft(processObject);
        }
    }

    // data refresh after help popup refresh
    dataRefresh(): void {
        const personid = this.form1080a.get('personid')?.value;
        if(personid){
            this.isDataRefresh = true;
            this.childListDetails = [];
            this.otherChildrenDetails = [];
            this.otherChildrenDetailsHouseHold = [];
            this.childList = []
            this.allegedMaltreatorListDetails = [];
            this.parentListDetails = [];
            this.getInvolvedPerson();
        } else {
            this._alertService.warn('Please select Alleged victim / Child');
        }
    }

    //Saving data and Submitting 
    saveAsDraft(processObject: any) {   
        if(this.form1080a.get('personid')?.value == null)
        {
            this._alertService.warn("Please select Alleged victim / Child");
        } else {
        let formData = this.form1080a.getRawValue();
        
        //Set the objectid and objecttype based on intake or case
        formData.objecttype = 'servicerequest';
        if(this.isServiceCase) {
            formData.objecttype = 'servicecase';
        }
        formData.objectid = this.id;
        formData.casenumber = this.caseNumber;
        if (this.isIntakeMode()) {
            formData.objecttype = 'intake';
            formData.objectid = this.getIntakeNumber();
            formData.casenumber = this.getIntakeNumber();
        }

        formData.listotherchildren = [...this.otherChildrenDetails];
        formData.listotherchildrenhousehold = [...this.otherChildrenDetailsHouseHold];
        this.checkAndUpdateStatus(processObject,formData);
        if(this.formId){
            formData['form1080aid'] = this.formId;
        }
        formData = {...this.formData, ...formData, id: this.id}
        this.saveAsDraftContinue(formData);
        }
    }

    checkAndUpdateStatus(processObject :any,formData : any) : void {
        if(processObject?.isSupervisorSubmit) {
            this.submitforapproval = this.form1080a.get("submitforapproval")?.value;
            this.status = this.submitforapproval  === 'InProcess' ? this.status : this.submitforapproval;
            formData['status'] = this.status;
            formData['submitforapproval'] = this.submitforapproval;
        } else {
            if(!processObject?.isSubmitToSupervisor) {
                this.form1080a.patchValue({submitforapproval: this.submitforapproval});
                formData['submitforapproval'] = this.submitforapproval;
                formData['status'] = 'In Progress';
            } else {
                this.status = 'Review';
                formData['status'] = this.status;
            }
        }
    }

    saveAsDraftContinue(formData:any) : void {
        this._service.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.AddUpdate).subscribe(
            (response: any) => {
                if (response) {

                    const result = JSON.parse(JSON.stringify(response));
                    if (result) {
                        this.formId = result?.formid;
                        this._alertService.success(result.message);
                        if(this.status !== "In Progress") {
                            this.onRouting();
                            this.redirectToAttachment();
                        }
                        
                    } else {
                        this._alertService.warn(result.message);
                    }
                }
            });
    }


    onSubmitToSupervisor() {
        this.submitted = true;
        //certain radio button fields can default to null yet are required for submitting form
        this.checkNullableRequiredfields();

        //Date of this CF/SPI/Critical Incident Report
        //when submitting for review need to set the current date
        this.form1080a.patchValue({
            dateofthiscfspicriticalincidentreport: new Date()
        })
        this.form1080a.markAllAsTouched();
        this.form1080a.updateValueAndValidity();
        Object.keys(this.form1080a.controls).forEach(key => {
            const control = this.form1080a.get(key);
            if (control && control.invalid) {
              console.warn(`Invalid control: ${key}`, control.errors);
            }
        });

        if (['VALID'].includes(this.form1080a.status)) {
            const processObj = {isSubmitToSupervisor: true};
            this.saveAsDraft(processObj);
        } else {
            this._alertService.warn('Please fill the required fields.');
        }
    }
    onRouting() {
        if(this.isSupervisor) {
            if(this.status === 'ReturnToWorker'){
                this.notifymsg = 'Form 1080A Return To Worker';
            } else {
                this.notifymsg = 'Form 1080A Approved';
            }
            this.tosecurityusersid = this?.formData?.updatedby;
        } else {
            this.status = 'review'
            this.notifymsg = 'Form 1080A submitted successfully ';
            //Not sure where he got this logic??
            // this.tosecurityusersid = this.store?.dsdsActionsSummary?.responsibleworkers?.[0]?.supervisorid;
            this.tosecurityusersid = this.userDetails?.userprofile?.supervisorid;
            if(this.selectedSupervisorId){
                //But for now just overriding it if a supervisor is selected in dropdown list
                this.tosecurityusersid = this.selectedSupervisorId;
            }
        }

        let requestObjectid = this.id;
        let requestEventcode = 'SPLR';
        if(this.isIntakeMode()) {
            requestObjectid = this.getIntakeNumber()
            requestEventcode = 'INTKFORM';
        }
        this._commonService
            .create(
                {
                    objectid: requestObjectid,
                    eventcode: requestEventcode,
                    status: this.status === 'ReturnToWorker'? 'Rejected' : this.status,
                    comments: this.notifymsg,
                    notifymsg: this.notifymsg,
                    routeddescription: this.notifymsg,
                    assessmmentName: 'form1080a',
                    tosecurityusersid: this.tosecurityusersid
                },
                'routing/routingupdate'
            )
            .subscribe(
                () => {
                    this._alertService.success(this.notifymsg);
                },
                () => {
                    this._alertService.error("Routing Update failed, please contact support");
                }
            );
    }
    disableSupervisorSubmit() {
        return this.action === 'view';
    }
    navigateBack() {
        this.redirectToAttachment();
        $(this.successpopupid).modal('hide');
    }
    redirectToAttachment() {
        let url = `/pages/case-worker/${this.id}/${this.daNumber}/dsds-action/attachment`;
        if(this.isIntakeMode()) {
            url = `/pages/newintake/my-newintake/${this.getIntakeNumber()}/edit/attachment`;
        }
        this._router.navigate([url], {
            queryParams: { openFormsTab: true}
        });
    }

    populateAdditionalChildInfo(selectedDetails: any) {
        //Need to get Disablity info --> getpersondisability
        //wasthechilddiagnosedwithamentalorphysicaldisability
        let yesDisablities: any;
        this.getDisablity(selectedDetails.personid)
                .subscribe((response) => {
                    if (response && Array.isArray(response) && response.length) {
                        const disabilityData = response;
                        yesDisablities = disabilityData.some(item => item.disabilityconditiontypekey === 'Yes');
                    }
                    this.form1080a.patchValue({
                        wasthechilddiagnosedwithamentalorphysicaldisability: yesDisablities ? true : null
                    })
                });

        //wasthechildbornsubstanceexposed
            this.form1080a.patchValue({
                wasthechildbornsubstanceexposed: selectedDetails?.senstatusflag == 1 ? true : null
            })

        //child death record in person profile
        //wasthechildrecordupdatedwiththedateofdeathincjams
            this.form1080a.patchValue({
                wasthechildrecordupdatedwiththedateofdeathincjams: selectedDetails?.dateofdeath ? true : null
            })
    }

    async getPriorHistoryDetails(selectedDetails: any) { 
        const personDSDSActionPayload = {
            personid: selectedDetails?.personid,
            cisclientid: null,
            mdm_id: null
        };
    
        try {
            const personDSDSActionData = await this.getPersonDSDSAction(personDSDSActionPayload);
            const personProgramAreaData = await this.getProgramAssignments(selectedDetails?.personid);
            
            const actionDaDetails = personDSDSActionData.map((data: any) => data.daDetails).flat();    // NOSONAR -- NOT USED IN THE CODE
            const personProgramArea = personProgramAreaData?.[0]?.personprogramarea || [];

            //Any cps case other than the current one where form is being done
            // const isOtherCPSCase = actionDaDetails.some(data =>      // NOSONAR -- NOT USED IN THE CODE
            //                         (data.datype === 'Child Protective Services' 
            //                             && data.danumber != this.caseNumber
            //                         ));

            //Seems the selectedDetails coming from the getpersodetailscw alraedy has the programarea
            const selectedPersonProgramAreas = selectedDetails.programarea; // NOSONAR -- NOT USED IN THE CODE

            //We have to find any other active program areas other that that of current case or GAP/Adoption
            const excludedProgramAreas = ['ADP', 'GAP'];    // NOSONAR -- NOT USED IN THE CODE

            //Find the current case program area
            const currentProgramArea = this.store?.dsdsActionsSummary?.da_subtype;  // NOSONAR -- NOT USED IN THE CODE


            // const applicableProgramAreas = selectedPersonProgramAreas.filter(program => {      // NOSONAR -- NOT USED IN THE CODE
            //     // Condition 1: Check if the program area is in the excluded list.
            //     const isExcludedByProgramArea = excludedProgramAreas.includes(program.programkey);
            //     if (isExcludedByProgramArea) {
            //         return false;
            //     }
            
            
            //     // If neither of the exclusion conditions were met, keep the program.
            //     return true;
            // });

            //indicated as “In Household” on the person card of a case with an active family assignment,
            //or has an open program assignment other than program assignments for the active investigation, adoption or GAP program
            const isAnyOpenInHome = personProgramArea.filter((data: any) => 
                ((data.programkey == 'IHSFP' || data.programkey == 'AXYS' || data.programkey == 'OOH' || data.programkey == 'KIN' || data.programkey == 'IL')
                    && data.enddate == null
                    && data.ishousehold == 1
                ));
                
            const isAnyOpenCPS = personProgramArea.filter((data: any) => 
                (data.programkey == 'CPS'
                    && data.subprogramkey != 'IR'
                    && data.casenumber != this.caseNumber
                    && data.enddate == null
                ));
    


            //Completed investigation within 12 months
            // const isOtherCPSCaseIn12mths = actionDaDetails.some(data =>    // NOSONAR -- NOT USED IN THE CODE
            //                         (data.datype === 'Child Protective Services' 
            //                             && data.danumber != this.caseNumber
            //                             && data.datecompleted != null
            //                             && new Date(data.datecompleted) >= new Date(new Date().setFullYear(new Date().getFullYear() - 1))
            //                         ));

            //Any in-home assignment ended within 12 months
            // const isAnyInHome12mths = actionDaDetails.some(data => 
            //                         (data.datype == 'Service Case' 
            //                             && data.dasubtype == 'IHSFP/CS'
            //                             && data.datecompleted != null
            //                             && new Date(data.datecompleted) >= new Date(new Date().setFullYear(new Date().getFullYear() - 1))
            //                         ));

            //this won't work because the 'case' can remain open while the program assignment is ended
            //need to use --> Personprogramareas/getpersonprogramarea
            const isAnyInHomeEnded12mths = personProgramArea.filter((data: any) => 
                                            (data.programkey == 'IHSFP'
                                                && data.enddate != null
                                                && data.ishousehold == 1
                                                && new Date(data.enddate) >= new Date(new Date().setFullYear(new Date().getFullYear() - 1))
                                            ));

            const isAnyCPSEnded12mths = personProgramArea.filter((data: any) => 
                                            (data.programkey == 'CPS'
                                                && data.enddate != null
                                                && new Date(data.enddate) >= new Date(new Date().setFullYear(new Date().getFullYear() - 1))
                                            ));

            this.form1080a.patchValue({
                wasthereanyotheropencaseinvolvingthischildatthetimeofincident: 
                                            (isAnyOpenInHome?.length > 0 || isAnyOpenCPS?.length > 0) ? true : null,
                wasthereacaseinvolvingthischildclosedwithin12monthsofincident: 
                                            (isAnyInHomeEnded12mths?.length > 0 || isAnyCPSEnded12mths?.length > 0) ? true : null
            });

        } catch (error) {
            console.error("Failed to get person DSDS action data", error);
        }
    }

    //Person program area assignments
    async getProgramAssignments(personID: any): Promise<any> {
        return new Promise((resolve, reject) => {
            this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { objectid: this.id, personid: personID },
                    method: 'get',
                    nolimit: true
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GetPersonProgramArea + "?filter"
            ).subscribe({
                next: (data) => resolve(data),
                error: (err) => reject(err)
            });
        });
    }

    //Provider placement details for the selected child
    getPlacementDetails(selectedDetails: any) {
        this._commonService
                .getSingle(
                    {
                        where: { personid: selectedDetails?.personid },
                        method: 'get'
                    },

                    'placement/getplacementbyperson?filter'
                )
                .subscribe(data => {
                    if (data) {
                        let placementData = data?.map((e: any) => ({
                            'placementtypekey' : e.placementtypekey,
                            'placementid': e.placementid,
                            'name': e.placementtypekey === 'LA' ? e.livingarrangementtype : e.providerdetails?.providername,
                            'case': e.servicecasenumber,
                            'startdate': e.startdate,
                            'enddate': e.enddate
                        }));
                        this.placementProviders = placementData;

                        //child ever had placement
                        //wasthechildeverplacedoutsideofhomebeforetheincident
                        const childEverPlaced = (placementData.length > 0);

                        //Did it end in last 12 months
                        //didmostrecentoohplacementend12monthsofincident
                        const childPlaced12mth = placementData.some((data: any) =>     // NOSONAR
                                                data.enddate != null
                                                && new Date(data.enddate) >= new Date(new Date().setFullYear(new Date().getFullYear() - 1)));

                        //Placement at the time of incident
                        //wasthechildinanoutofhomeplacementatthetimeoftheincident
                        let incidentDate : any;
                        let childPlacedAtIncident: any
                        if(this.incidentDate){
                            incidentDate =formatDate(this.incidentDate, 'yyyy-MM-ddTHH:mm:ss', 'en-US');
                            childPlacedAtIncident = placementData.some((data: any) => // NOSONAR                        
                                    incidentDate >= data.startdate && 
                                    (incidentDate <= data.enddate || data.enddate == null));
                        }else{
                            childPlacedAtIncident = false;
                        }
                        this.form1080a.patchValue({
                            wasthechildeverplacedoutsideofhomebeforetheincident: childEverPlaced ? true : null,
                            didmostrecentoohplacementend12monthsofincident: (childPlaced12mth && !childPlacedAtIncident) ? true : null,
                            wasthechildinanoutofhomeplacementatthetimeoftheincident: childPlacedAtIncident ? true : this.formData?.wasthechildinanoutofhomeplacementatthetimeoftheincident
                        })

                        if(this.selectedPlacementId){
                            this.form1080a.patchValue({
                                placementprovideratthetimeoftheincident: this.selectedPlacementId
                            })
                        }
                    } else {
                        return;
                    }
            });
    }

    getDisablity(personid: any){
        return this._commonService
        .getPagedArrayList(
          new PaginationRequest({
            page: 1,
            limit: 20,
            method: 'get',
            where: { personid: personid }
          }),
          CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonDisability + "?filter"
        );
    }

    //Get relationships
    getPersonRelationships(selectedDetails: any) {
        this.getInvolvedPersonWithPersonID(selectedDetails?.personid)
        .subscribe(response => {
            if (Array.isArray(response)) {
                this.relationships = response;
            }
        });
    }

    normalizeMultiSelect(value: string | string[]): string[] {
        if (Array.isArray(value)) return value;
        try {
          return JSON.parse(value);
        } catch {
          return [];
        }
    }

    onSelectSupervisor(event: MatSelectChange) {
        this.selectedSupervisorId = event.value;
    }

    formatDate(dateString: any) {
        return dateString ? moment(dateString).format('MM/DD/YYYY') : null;
    }

    handleSdmChangeInteraction() {
        const isDirty =
          this.form1080a.get('ischildfatality')!.dirty ||
          this.form1080a.get('isseriousphysicalinjury')!.dirty ||
          this.form1080a.get('ismaltreatment')!.dirty;
      
        if (isDirty) {
          this.enableJustificationField();
        } else {
          const justification = this.form1080a.get('justificationforchange');
          if(justification){
            justification.disable();
            justification.clearValidators();
            justification.setValue('');
            justification.updateValueAndValidity();
          }
        }
    }

    enableJustificationField() {
        const justification = this.form1080a.get('justificationforchange');
        if(justification) {
            justification.enable();
            justification.setValidators([Validators.required]);
            justification.updateValueAndValidity();
        }
    }

    onSupervisorApprovalChange() : void {
        const selected = this.form1080a.get('submitforapproval')?.value;
        if (selected === 'ReturnToWorker') {
            this.supvCommentsMandatory = true;
        } else {
            this.supvCommentsMandatory = false;
        }
    }

    checkNullableRequiredfields() {
        const nullableFields = [
            'didmostrecentoohplacementend12monthsofincident',
            'wasthechilddiagnosedwithamentalorphysicaldisability',
            'wasthechildbornsubstanceexposed',
            'wasthechildrecordupdatedwiththedateofdeathincjams'
        ];

        nullableFields.forEach(field => {
            const control = this.form1080a.get(field);
            if (control && control.value === null) {
              control.clearValidators();     // Remove required validator in case of Unknown/NA
              control.updateValueAndValidity();
            }
          });
    }

    private setMaxRapidResponseReviewDate(): Date {
        const date = new Date();
        date.setDate(date.getDate() + 7);
        return date;
    }

    //Narrative history required checks
    isMaltreatorNarrativeRequired(): boolean {
        return this.maltreators?.controls?.some(
            (m) => m.get('anychildwelfarehistoryinvolvingthisperson')?.value === true
        );
    }
    
    isParentNarrativeRequired(): boolean {
        return this.parents?.controls?.some(
          (p) => p.get('anychildwelfarehistoryinvolvingthisperson1')?.value === true
        );
    }
      
      
    
    setScreenSub(){
        //Auto populated. Manual entry allowed in the intake level
        if(this.isIntakeMode()) {
            this.isScreenEnabled = true;
            this.form1080a.get('screen')?.enable();
        }
        //Setting up subscription for the valve of 'screen' field being ScreenOut 
        //i.e. screen -> false will need reason as mandatory
        this.screenSub = this.form1080a.get('screen')?.valueChanges.subscribe(value => {
            const reasonControl = this.form1080a.get('providereason');
            if (value === false) { //ScreenOut scenario
              reasonControl?.setValidators([Validators.required]);
              reasonControl?.enable();
            } else {
              reasonControl?.clearValidators();
              reasonControl?.reset();
              reasonControl?.disable();
            }
            reasonControl?.updateValueAndValidity();
        });
    }

    ngOnDestroy() {
        this.screenSub?.unsubscribe();
    }

    //Config for all the link paths
    getLinkPath(type: any): string {
        /**
            Scenarios
            1. Person profile
            2. Relationships Tab
            3. Persons (household) Tab
        */
        const base = this.isIntakeMode() ? `#/pages/newintake/my-newintake/${this.getIntakeNumber()}/edit`
                                         : `#/pages/case-worker/${this.id}/${this.daNumber}/dsds-action`;
        switch (type) {
            case 'personprofile':
                return `#/pages/person-info-cw/profile`;
            case 'personhealthtab':
                return `#/pages/person-info-cw/health/disability`;
            case 'relationship':
                return `${base}/relationship`;
            case 'persontab':
                return `${base}/person-cw/list`;
            default:
                return '';
        }
      }
       
}
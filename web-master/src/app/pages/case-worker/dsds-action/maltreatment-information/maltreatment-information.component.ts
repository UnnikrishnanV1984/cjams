
import {pluck, map, share, catchError} from 'rxjs/operators';
import { DatePipe } from '@angular/common';
import { AfterViewChecked, ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormControl, Validators, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router, NavigationEnd } from '@angular/router';
import moment from 'moment';
import { Observable ,  forkJoin, of } from 'rxjs';
import { DropdownModel, PaginationRequest, PaginationInfo, DynamicObject } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { isCaseUuid } from '../../../../@core/common/initializer';
import { AlertService, AuthService, CommonHttpService, DataStoreService, GenericService, CommonDropdownsService, SessionStorageService } from '../../../../@core/services';
import { DSDSActionSummary, InvolvedPerson } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { AddMaltreatment, Areaofinjury, Indicator, Injurycharactertic, Maltreatmentcharacterstic, MaltreatmentInformation, Maltreator, ProviderMaltreatment } from './_entites/maltreatment.data.model';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import _ from 'lodash';
import { MaltreatmentAllegationResolverService } from './maltreatment-information-resolver.service';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'maltreatment-information',
    templateUrl: './maltreatment-information.component.html',
    styleUrls: ['./maltreatment-information.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class MaltreatmentInformationComponent implements OnInit, AfterViewChecked {
    maltreatmentFormGroup!: FormGroup;
    isAnotherJurisdiction!: boolean;
    maxDate = new Date();
    minDate = new Date();
    isSubmitting!: boolean;
    maltreatmentInformation: MaltreatmentInformation[] = [];
    jurisdictionDropdownItems$!: Observable<DropdownModel[]>;
    maltreatmentTypeDropdownItems$!: Observable<DropdownModel[]>;
    injuryTypeDropdownItems$!: Observable<DropdownModel[]>;
    maltreatmentCharactersticsTypeDropdownItems$!: Observable<DropdownModel[]>;
    injuryCharactersticsTypeDropdownItems$!: Observable<DropdownModel[]>;
    providerMaltreatmentTypeItems: DropdownModel[] = [];
    id!: string;
    intakeSDM: any;
    showcheckbox: boolean = false;
    enablecheckbox: boolean = false;
    dsdsActionsSummary = new DSDSActionSummary();
    indicator: Indicator[] = [];
    areaOfInjury: Areaofinjury[] = [];
    maltreatmentCharactersticType: Maltreatmentcharacterstic[] = [];
    injuryCharacterticType: Injurycharactertic[] = [];
    addMaltreatment = new AddMaltreatment();
    isShowJurisdiction = false;
    childDetails: DropdownModel[] = [];
    incidentLocation: DropdownModel[] = [];
    isInitialLoad = false;
    personInfo!: string;
    personInf: InvolvedPerson[] = [];
    involvedPersons: InvolvedPerson[] = [];
    providermaltreatment: ProviderMaltreatment[] = [];
    sdmAllegation: any = {};
    maltreatmentTypeDropdownItems: DropdownModel[] = [];
    allegationForm!: FormGroup;
    abusedChildList: any[] = [];
    selectedChild: any;
    placementRecords: any[] = [];
    searchprovider: any = {};
    selectedProvider: any;
    placementHistory: any[] = [];
    isLivingArrangment: boolean = false;
    isSchool: boolean = false;
    livingArrangmentDetails: any = [];
    showhistoryRecords: boolean = false;
    auditHistoryList: any[] = [];
    allegationHistList: any[] = [];
    providerRequired: boolean = false;
    isMaltreatorChanged: boolean = false;
    providersList: any[] = [];
    selectedallegationForm!: FormGroup;
    cpahomedetails: any;
    isProbabilityPresent!: string | null;
    foundAllegation!: any;
    allegedChild: any;
    reportSummary: any;
    disableForm!: boolean;
    isClosed = false;
    daNumber!: string;
    minincidentDate= new Date();
    minincidentendDate = new Date();
    incidentdate= new Date();
    currentdate = new Date();
    showAppeal!: boolean;
    alertMessage!: string;
    investigationFinding : any[] = [];
    paginationInfo: PaginationInfo = new PaginationInfo();
    moduleview: any;
    involvedMaltreatorDetails: any = null;
    involvedProviderDetails: any = null;
    reasonChangeText: string | null = null;
    oldproviderid: any;
    changeProviderDetails: boolean = false;
    displayvalidationMessages: any[]=[];
    disableproviderchange: boolean =false;
    displayorder = 'displayorder ASC';
    nomaltreatorfound = 'No Maltreator found.';
    maltreatmentpopupid = '#maltreatment-popup';
    nomaltreatmentpresent = 'No Maltreatment Present.';
    dtwithtimeformat = 'MM/DD/YYYY, h:mm A';
    dtformat = 'MM/DD/YYYY';
    providerCount!: number;
    providerpaginationInfo: PaginationInfo = new PaginationInfo();
    intakesdmid: any;
    isViewCase = false;
    isAdoptionCase = false;
    isServiceCase = false;
    iscaseexpunged: any = 0;

    private _formBuilder: FormBuilder;
    private _route: ActivatedRoute;
    private _dataStoreService: DataStoreService;
    private _commonDDService: CommonDropdownsService;
    private _alertService: AlertService;
    _authService: AuthService;
    private cdRef: ChangeDetectorRef;
    private _router: Router;
    private datePipe: DatePipe;
    private storage: SessionStorageService;

    constructor(
        private readonly injector : Injector,
        private _commonHttpService: CommonHttpService,
        private _service: GenericService<AddMaltreatment>,
        private maltreatmentAllegationResolverService: MaltreatmentAllegationResolverService
    ) {
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.cdRef = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._router = this.injector.get<Router>(Router);
        this.datePipe = this.injector.get<DatePipe>(DatePipe);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);

        // this._route.data.subscribe((data: any) => {
        //     if (data && data.hasOwnProperty('result')) {
        //         this._authService.setAuthDetail('maltreatmentallegation', data.result);
        //     }
        // });
        this._router.routeReuseStrategy.shouldReuseRoute = function() {
            return false;
         };

         this._router.events.subscribe((evt: any) => {
            if (evt instanceof NavigationEnd && !evt.url.startsWith('/pages/newintake') && !evt.url.startsWith('/pages/person-info-cw/health')) {
               // trick the Router into believing it's last link wasn't previously loaded
               this._router.navigated = false;
               // if you need to scroll back to top, here is the right place
               window.scrollTo(0, 0);
            }
        });
     }
    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.maltreatmentAllegationResolverService.getMaltreatmentallegation().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('maltreatmentallegation', data);
            }
        })
        this.moduleview = this._authService.isModuleAccessable('maltreatmentallegation', 'maltreatmentallegation');
        this.setsearchprovider();
        this.id = this._commonDDService.getStoredCaseUuid();
        this.daNumber = this._commonDDService.getStoredCaseNumber();
        this.disableForm = false;
        this.initialFormGroup();
        this.getJurisdictionDropdown();
        this.getSDM();
        this._authService.currentUser.subscribe();
        this.isInitialLoad = true;
        this._dataStoreService.currentStore.subscribe((store) => {
            this.checkDsdsActionsSummaryFn(store);
        });
        this.setSelectedChildData();
        const da_status = this.storage.getItem('da_status');
        if (da_status) {
         if (da_status === 'Closed' || da_status === 'Completed') {
             this.isClosed = true;
         } else {
             this.isClosed = false;
         }
        }
        this.setMinincidentDate();
        this._commonHttpService.getPagedArrayList(
                    new PaginationRequest({
                        page: 1,
                        limit: 20,
                        where: {
                            servicerequestid: this.id
                        },
                        method: 'get'
                    }), 'Intakeservicerequestdispositioncodes/GetHistory?filter'
                ).subscribe(
                    (result) => {
                        const history = (result.data) ? result.data : [];
                        this.showAppeal = false;
                        if (history && history.length > 0) {
                            const isCompleted = history.find(dispo => (dispo.dispstatus === 'Completed') && (dispo.routingstatus === 'Approved'));
                            if (isCompleted) {
                            this.showAppeal = true;
                            }
                        }
                        return result.data;
                    }
                );
    }
    // Assosiated with ngOnInit method
    private checkDsdsActionsSummaryFn(store: DynamicObject) {
        if (this.isInitialLoad && store['dsdsActionsSummary']) {
            this.dsdsActionsSummary = store['dsdsActionsSummary'];
            if (this.dsdsActionsSummary) {
                this.getDropdown();
                this.getIncidentLocation();
                this.getMaltreatmentInformation(true);
                this.getFindingList();
                this.isInitialLoad = false;

                // @TM: disable Maltreatment Allegation edit function for closed cases
                if (this.dsdsActionsSummary.da_disposition === 'Close Case' || this.dsdsActionsSummary.da_status === 'Closed') {
                    this.disableForm = true;
                }
            }
        }
    }

    ngAfterViewChecked() {
        this.cdRef.markForCheck();
        this.cdRef.detectChanges();
    }

    setSelectedChildData() {
        const X = this._dataStoreService.getData('holdChildValue');
        if (X) {
            this.selectChild(X);
            this._dataStoreService.setData('holdChildValue', null);
        }
    }
    setMinincidentDate() {
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
         // For case min incident date will be the Case received date
        if (caseInfo) {
            this.minincidentDate = caseInfo.da_receiveddate;
            }

    }

initialFormGroup() {
        this.maltreatmentFormGroup = this._formBuilder.group({
            countyid: [null],
            incidentlocationtypekey: [null],
            isjurisdiction: ['0'],
            isnotapplicable: [null],
            notapplicablecomments: [null],
            auditinfo: [null],
            caseworker: [''],
            supervisor: [''],
            person: this._formBuilder.array([]),
            allegations: this._formBuilder.array([])
        });
    }

    setFormValues() {
        if (this.maltreatmentInformation) {
            const control = <FormArray>this.maltreatmentFormGroup.controls['person'];
            this.maltreatmentInformation.forEach((x, index) => {
                control.push(this.buildPersonForm(x, index));
            });
        }
    }

    private buildPersonForm(x: any, personIndex: any): FormGroup {
        if (x.dateofdeath) {
            const childDod = this.datePipe.transform(x.dateofdeath, 'MM/dd/yyyy');
            this.personInfo = x.personname + ' ' + childDod;
        } else {
            this.personInfo = x.personname;
        }
        return this._formBuilder.group({
            personname: this.personInfo,
            personid: x.personid ? x.personid : '',
            intakeservicerequestactorid: x.intakeservicerequestactorid ? x.intakeservicerequestactorid : '',
            investigationallegation: this.buildInvestigationallegation(x, personIndex)
        });
    }

    showJurisdiction(isShow: any) {
        isShow === '1' ? this.maltreatmentFormGroup.get('countyid')?.enable() : this.maltreatmentFormGroup.get('countyid')?.disable();
        if (!this.isShowJurisdiction) {
            this.maltreatmentFormGroup.patchValue({ countyid: null });
        }
        if (isShow === '0') {
            this.isAnotherJurisdiction = false;
        } else {
            this.isAnotherJurisdiction = true;
        }
    }

    buildInvestigationallegation(inverstigation:any, personIndex:any) {
        let investigation: FormGroup[] = [];
        if (inverstigation.investigationallegation) {
            investigation = inverstigation.investigationallegation.map((item: any) => {
                return this.buildMaltreatmentTypeFormGroup(item, personIndex);
            });
            return this._formBuilder.array([...investigation]);
        } else {
            return this._formBuilder.array([this.maltreatmentTypeFormGroup()]);
        }
    }

    // D-06597 - Fix for Maltreatment type and Alleged Maltreators and Relationship to Victim fields should be mandatory fields
    maltreatmentTypeFormGroup() {
        const controls = this.providerMaltreatmentTypeItems.map((c: any) => {
            return new FormControl(false);
        });
        return this._formBuilder.group({
            investigationallegationid: [''],
            incidentdate: [null],
            allegationid: ['', Validators.required],
            isShowAllegation: [false],
            maltreatoractorid: [null, Validators.required],
            injurytypekey: [''],
            maltreatmentcharactersticstypekey: [''],
            injurycharactersticstypekey: [''],
            comments: ['', Validators.required],
            injurycomments: [''],
            enddate: [null],
            isapproximatedate: [false],
            timeofincidence: [null],
            sextrafficking: [''],
            injurytypedescription: [''],
            maltreatmentcharactersticstypedescription: [''],
            injurycharactersticstypedescription: [''],
            maltreatorname: '',
            allegationname: '',
            isShowSextrafficking: false,
            isproviderinvolved: [{value: null, disabled: true}],
            ischildfatality: [0],
            isDisplayProviderInvolved: [''],
            providerMaltreatmentItems: new FormArray(controls)
        });
    }

    addMaltreatmentType(index: any) {
        const control = <FormArray>this.maltreatmentFormGroup.get('person');
        const investigationallegationControl = <FormArray>control.at(index).get('investigationallegation');
        investigationallegationControl.push(this.maltreatmentTypeFormGroup());
    }

    private buildMaltreatmentTypeFormGroup(x: any, personIndex: any) {
        const controls = this.providerMaltreatmentTypeItems.map(c => {
            if (x.providermaltreatment && x.providermaltreatment.filter((p: { providermaltreatmenttypekey: any; }) => p.providermaltreatmenttypekey === c.value).length) {
                return new FormControl(true);
            } else {
                return new FormControl(false);
            }

        });
        if(x.auditinfo && x.auditinfo.length) {
          this.allegationHistList.push(x);
        }
        const invFG = this._formBuilder.group(this.returnInvFGDataFn(x, controls));


        const injurytype = x.injurytype ? x.injurytype.map((item: { injurytypekey: any; }) => item.injurytypekey) : null;
        const injurycharactersticstype = x.injurycharactersticstype ? x.injurycharactersticstype.map((item: { injurycharactersticstypekey: any; }) => item.injurycharactersticstypekey) : null;
        const maltreatmentcharactersticstypekey = x.maltreatmentcharactersticstypekey ? x.maltreatmentcharactersticstypekey.map((item: { maltreatmentcharactersticstypekey: any; }) => item.maltreatmentcharactersticstypekey) : null;
        const maltreators = x.maltreators ? x.maltreators.map((item: { intakeservicerequestactorid: any; }) => item.intakeservicerequestactorid) : null;
        invFG.controls['injurytypekey'].patchValue(injurytype);
        invFG.controls['injurycharactersticstypekey'].patchValue(injurycharactersticstype);
        invFG.controls['maltreatmentcharactersticstypekey'].patchValue(maltreatmentcharactersticstypekey);
        invFG.controls['maltreatoractorid'].patchValue(maltreators);

        this.patchDescriptionInvFGfn(x, invFG);
        if (x.allegationid) {
            invFG.disable();
        }
        return invFG;
    }
    // Assosiated to buildMaltreatmentTypeFormGroup method
    private patchDescriptionInvFGfn(x: any, invFG: FormGroup) {
        const injurytypedescription = x.injurytype ? x.injurytype.map((item: { typedescription: any; }) => item.typedescription) : null;
        const injurycharactersticstypedescription = x.injurycharactersticstype ? x.injurycharactersticstype.map((item: { typedescription: any; }) => item.typedescription) : null;
        const maltreatmentcharactersticstypedescription = x.maltreatmentcharactersticstypekey ? x.maltreatmentcharactersticstypekey.map((item: { typedescription: any; }) => item.typedescription) : null;
        const maltreatorstypedescription = x.maltreators
            ? x.maltreators.map((item: { relationship: string; personname: string; }) => {
                if (item && item.relationship) {
                    return item.personname + ' - ' + item.relationship;
                } else {
                    return item.personname;
                }
            })
            : null;

        invFG.controls['injurytypedescription'].patchValue(injurytypedescription);
        invFG.controls['injurycharactersticstypedescription'].patchValue(injurycharactersticstypedescription);
        invFG.controls['maltreatmentcharactersticstypedescription'].patchValue(maltreatmentcharactersticstypedescription);
        invFG.controls['maltreatorname'].patchValue(maltreatorstypedescription);
    }

    // Assosiated to buildMaltreatmentTypeFormGroup method
    private returnInvFGDataFn(x: any, controls: FormControl[]) {
        return {
            ...this.returnInvFGDataCond1Fn(x),
            ...this.returnInvFGDataCond2Fn(x, controls)
        };
    }
    // Assosiated to buildMaltreatmentTypeFormGroup method
    private returnInvFGDataCond2Fn(x: any, controls: FormControl[]) {
        return {
            isapproximatedate: x.isapproximatedate === 1 ? true : false,
            timeofincidence: x.timeofincidence ? moment(x.timeofincidence).format('HH:mm:ss') : null,
            sextrafficking: x.sextrafficking ? x.sextrafficking.toString() : '0',
            injurytypedescription: '',
            maltreatmentcharactersticstypedescription: '',
            injurycharactersticstypedescription: '',
            maltreatorname: '',
            allegationname: x.allegationname ? x.allegationname : '',
            ischildfatality: x.ischildfatality ? x.ischildfatality : 0,
            isShowSextrafficking: x.allegationname ? this.returnAllegationnameFn(x) : false,
            isproviderinvolved: x.isproviderinvolved ? x.isproviderinvolved : this.returnProviderinvolvedFn(x),
            isDisplayProviderInvolved: x.isproviderinvolved ? this.returnDisplayProviderInvolvedFn(x) : false,
            providerMaltreatmentItems: new FormArray(controls)
        };
    }
    // Assosiated to buildMaltreatmentTypeFormGroup method
    private returnDisplayProviderInvolvedFn(x: any) {
        return (x.isproviderinvolved === 1 ? true : false);
    }
    // Assosiated to buildMaltreatmentTypeFormGroup method
    private returnProviderinvolvedFn(x: any) {
        return (x.isproviderinvolved === 0 ? 0 : null);
    }
    // Assosiated to buildMaltreatmentTypeFormGroup method
    private returnAllegationnameFn(x: any) {
        return (x.allegationname === 'Sexual Abuse' ? true : false);
    }
    // Assosiated to buildMaltreatmentTypeFormGroup method
    private returnInvFGDataCond1Fn(x: any) {
        return {
            investigationallegationid: x.investigationallegationid ? x.investigationallegationid : '',
            incidentdate: x.incidentdate ? x.incidentdate : null,
            allegationid: x.allegationid ? x.allegationid : '',
            auditinfo: x.auditinfo ? x.auditinfo : null,
            isShowAllegation: x.allegationid ? true : false,
            maltreatoractorid: '',
            injurytypekey: '',
            maltreatmentcharactersticstypekey: '',
            injurycharactersticstypekey: '',
            comments: x.comments ? x.comments : '',
            injurycomments: x.injurycomments ? x.injurycomments : '',
            enddate: x.enddate ? x.enddate : null
        };
    }

    onChangeIndicator(event: any) {
        if (event) {
            const indicators = [];
            indicators.push({ maltreatoractorid: event });
            return indicators;
        }
    }
    onChangeInjuryTypeKey(event: any) {
        if (event) {
            return event.map((res: any) => {
                return { injurytypekey: res };
            });
        }
    }
    onChangeMaltreatmentCharacteristicsType(event: any) {
        if (event) {
            return event.map((res: any) => {
                return { maltreatmentcharactersticstypekey: res };
            });
        }
    }

    onProviderMaltreatmentChange(personIndex: number, investigationIndex: number, selectedValue: string, $event: any) {
        const control = <FormArray>this.maltreatmentFormGroup.controls['person'];
        const providerMaltreatmentFormArray = (<FormArray>control.get([personIndex, 'investigationallegation', investigationIndex, 'providerMaltreatmentItems']))?.value;
        if ($event.checked) {
            providerMaltreatmentFormArray.push(new FormControl(selectedValue));
        } else {
            const index = providerMaltreatmentFormArray.controls.findIndex((x: { value: string; }) => x.value === selectedValue);
            providerMaltreatmentFormArray.removeAt(index);
        }
    }

    onChangeInjuryCharactersticsType(event: any) {
        if (event) {
            return event.map((res: any) => {
                return { injurycharactersticstypekey: res };
            });
        }
    }

    getFindingList() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
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
                .subscribe((res) => {
                    if (res) {
                        this.investigationFinding = res;
                    }
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
            ]).subscribe(([res1, res2]) => {
                const res = [...(res1 || []), ...(res2 || [])];
                this.investigationFinding = res;
            });
        }
    }

    
    isFindingSaved(allegation: any) {
        let isFindingSaved = false;
        if(this.investigationFinding && this.investigationFinding.length) {
        const maltreatment =  this.investigationFinding.filter((finding: { maltreatmentid: any; }) => finding.maltreatmentid === allegation.getRawValue().maltreatmentid);
        if(maltreatment.length) {
        isFindingSaved =  maltreatment[0].findings && maltreatment[0].findings.length ? true : false;
         }    
        }
        return isFindingSaved;              
    }

    private getMaltreatmentInformation(status: boolean) {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    
        let maltreatment$;
    
        if (!isExpungementSuperUser) {
            maltreatment$ = this._commonHttpService
                .getArrayList(
                    {
                        where: { investigationid: this.dsdsActionsSummary.da_investigationid },
                        method: 'get'
                    },
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
                );
        } else {
            maltreatment$ = forkJoin([
                this._commonHttpService
                    .getArrayList(
                        {
                            where: { investigationid: this.dsdsActionsSummary.da_investigationid },
                            method: 'get'
                        },
                        CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
                    )
                    .pipe(catchError(() => of([]))),
                this._commonHttpService
                    .getArrayList(
                        {
                            where: { investigationid: this.dsdsActionsSummary.da_investigationid },
                            method: 'get'
                        },
                        'Investigationallegations/getexpungedinvestigationallegation?filter'
                    )
                    .pipe(catchError(() => of([])))
            ]).pipe(
                map(([res1, res2]) => [...(res1 || []), ...(res2 || [])])
            );
        }
    
        forkJoin([
            maltreatment$,
            this._commonHttpService.getArrayList(
                {
                    order: this.displayorder
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.providermaltreatmenttypeUrl
            ),
            this._commonHttpService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + this.id)
        ])
            .subscribe((result:any) => {
                this.reportSummary = result[2];
                this.maltreatmentInformation = (Array.isArray(result[0])) ? result[0] : [];
                const sortingOrder = _.orderBy(result[1], ['displayorder'], ['asc'])
                const filteredDetails = sortingOrder.filter(item => item.providermaltreatmenttypekey !== 'CMTY');
                this.providerMaltreatmentTypeItems = filteredDetails.map(
                    (res) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.providermaltreatmenttypekey
                        })
                );
                if (this.maltreatmentInformation && this.maltreatmentInformation[0]) {
                    if (this.maltreatmentInformation[0].isjurisdiction) {
                        this.maltreatmentInformation[0].isjurisdiction = this.maltreatmentInformation[0].isjurisdiction.toString();
                        this.isAnotherJurisdiction = true;
                    } else {
                        this.maltreatmentInformation[0].isjurisdiction = '0';
                    }
                    this.setFormValues();
                    this.maltreatmentFormGroup.patchValue({
                        incidentlocationtypekey: this.maltreatmentInformation[0].incidentlocationtypekey ? this.maltreatmentInformation[0].incidentlocationtypekey : null,
                        countyid: this.maltreatmentInformation[0].countyid,
                        isjurisdiction: this.maltreatmentInformation[0].isjurisdiction
                    });
                    this.handleIfMaltreatmentInformationDataFn();
                    this.maltreatmentInformation[0].isjurisdiction === '1' ? this.maltreatmentFormGroup.get('countyid')?.enable() : this.maltreatmentFormGroup.get('countyid')?.disable();
                }
    
                if(status) {
                    this.getInvolvedPerson();
                }
    
            });
    }
    // Assosiated to getMaltreatmentInformation method
    private handleIfMaltreatmentInformationDataFn() {
        if (this.maltreatmentInformation[0].roles && this.maltreatmentInformation[0].roles.length) {
            this.maltreatmentInformation[0].roles.forEach((item) => {
                if (item.role === 'CW') {
                    this.maltreatmentFormGroup.patchValue({ caseworker: item.username });
                }
                if (item.role === 'SP') {
                    this.maltreatmentFormGroup.patchValue({ supervisor: item.username });
                }
            });
        }
    }

    reloadCurrPage() {
        const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/maltreatment-information';
        this._router.navigate([url]);
    }
    // D-06597 - Fix for Maltreatment type and Alleged Maltreators and Relationship to Victim fields should be mandatory fields
    saveMaltreatment(person: any, data: any, personIndex: any, InvestigationIndex: any) {
        if ((this.isProbabilityPresent === this.nomaltreatorfound) || (this.isProbabilityPresent === this.nomaltreatmentpresent)) {
            $(this.maltreatmentpopupid).modal('show');
            return;
        }
        this.addMaltreatment = Object.assign(new AddMaltreatment(), data.value);

        if (!this.addMaltreatment.incidentdate && !this.addMaltreatment.isnotapplicable) {
            this._alertService.error('Please Enter Start Date of incident');
            return;
        }

        if (!this.addMaltreatment.timeofincidence && !this.addMaltreatment.isnotapplicable) {
            this._alertService.error('Please Enter time of incident');
            return;
        }

        // D-07005 Start
        if (!this.addMaltreatment.comments && !this.addMaltreatment.isnotapplicable) {
            this._alertService.error('Please Enter Maltreatment Characteristics Comments');
            return;
        }
        // D-07005 End
        // if (!this.addMaltreatment.injurycomments && !this.addMaltreatment.isnotapplicable) {
        //     this._alertService.error('Please Enter Injury Characteristics Comments');
        //     return;
        // }
        if (!this.addMaltreatment.allegationid) {
            this._alertService.error('Please Select Maltreatment Type and Alleged Maltreators.');
            return;
        }
        if (!data.value.maltreatoractorid) {
            this._alertService.error('Please Alleged Maltreators.');
            return;
        }

        if(!this.handleAllegationidFn(person, data)) {
            return false;
        }
    }
    // Assosiated to saveMaltreatment method
    private handleAllegationidFn(person: any, data: any) {
        if (this.addMaltreatment.allegationid) {
            this.handleAddMaltreatmentAssignDataFn(person, data);
            // Validate Date of Incident Start and End dates
            const { eDate, iDate, receivedDate } = this.returnDateFn(data);
            if (eDate && iDate && iDate.isAfter(eDate)) {
                this._alertService.error('Date of Incident End Date should be after Start Date');
                return false;
            }

            if (receivedDate && iDate && !receivedDate.isSame(iDate, 'day') && iDate.isAfter(receivedDate)) {
                this._alertService.error('Date of Incident should be on or before received date [' + receivedDate.format(this.dtformat) + ']');
                return false;
            }

            // End of Validation
            this.addMaltreatment.enddate = data.value.enddate ? data.value.enddate : null;
            this.addMaltreatment.incidentdate = data.value.incidentdate ? data.value.incidentdate : null;

            this.handleIfMaltreatorsFn();
            this.handleIfSupervisorFn();
            this.addMaltreatment.objectid = this.id;
            this.addMaltreatment.objecttype = 'servicerequest';
            if (this.addMaltreatment.investigationallegationid) {
                this.handleUpdateMaltreatmentFn();
            } else {
                this.handleAddMaltreatmentFn();
            }
        }
        return true;
    }
    // Assosiated to saveMaltreatment method
    private handleIfSupervisorFn() {
        if (this.maltreatmentFormGroup.value.supervisor) {
            this.handleJurisdictionuserFn(this.maltreatmentFormGroup.value.supervisor, 'SP');
        }
    }
    // Assosiated to saveMaltreatment method
    private returnDateFn(data: any) {
        const eDateStr = data.value.enddate ? data.value.enddate + '' : null;
        let eDate;
        const incidentdateStr = data.value.incidentdate ? data.value.incidentdate + '' : null;
        let iDate;
        const receivedDateStr = this._dataStoreService.getData('da_receiveddate');
        let receivedDate;
        if (receivedDateStr) {
            receivedDate = moment(new Date(receivedDateStr.substr(0, 16)));
        }
        if (eDateStr) {
            const eDateSt = moment(eDateStr).format(this.dtwithtimeformat);
            eDate = moment(new Date(eDateSt.substr(0, 16)));
            data.value.enddate = eDate.format(this.dtformat);
        }
        if (incidentdateStr) {
            const incidentdate = moment(incidentdateStr).format(this.dtwithtimeformat);
            iDate = moment(new Date(incidentdate.substr(0, 16)));
            data.value.incidentdate = iDate.format(this.dtformat);
        }
        return { eDate, iDate, receivedDate };
    }
    // Assosiated to saveMaltreatment method
    private handleAddMaltreatmentAssignDataFn(person: any, data: any) {
        this.addMaltreatment.allegationid = this.addMaltreatment.allegationid.split('~')[0];
        this.addMaltreatment.maltreatmentid = null;
        this.addMaltreatment.personid = person.value.personid;
        this.addMaltreatment.intakeservicerequestactorid = person.value.intakeservicerequestactorid;
        const maltreators = this.onChangeIndicator(data.value.maltreatoractorid);
        this.addMaltreatment.maltreators = maltreators ? maltreators : [];
        this.addMaltreatment.areaofinjury = this.onChangeInjuryTypeKey(data.value.injurytypekey);
        this.addMaltreatment.maltreatmentcharacterstics = this.onChangeMaltreatmentCharacteristicsType(data.value.maltreatmentcharactersticstypekey);
        this.addMaltreatment.injurycharactertics = this.onChangeInjuryCharactersticsType(data.value.injurycharactersticstypekey);
        this.addMaltreatment.isjurisdiction = this.maltreatmentFormGroup.value.isjurisdiction;
        this.addMaltreatment.isnotapplicable = this.maltreatmentFormGroup.value.isnotapplicable ? '1' : '0';
        this.addMaltreatment.notapplicablecomments = this.maltreatmentFormGroup.value.notapplicablecomments;
        this.addMaltreatment.countyid = this.maltreatmentFormGroup.value.countyid ? this.maltreatmentFormGroup.value.countyid : null;
        this.addMaltreatment.incidentlocationtypekey = this.maltreatmentFormGroup.value.incidentlocationtypekey;
        this.addMaltreatment.investigationid = this.dsdsActionsSummary.da_investigationid;
        this.addMaltreatment.investigationallegationid = this.addMaltreatment.investigationallegationid ? this.addMaltreatment.investigationallegationid : null;
        this.addMaltreatment.timeofincidence = this.addMaltreatment.timeofincidence ? this.convertMatinputTimeToTimestamp(this.addMaltreatment.timeofincidence) : null;
        this.addMaltreatment.isapproximatedate = this.addMaltreatment.isapproximatedate ? '1' : '0';
        this.addMaltreatment.isproviderinvolved = this.addMaltreatment.isproviderinvolved ? this.addMaltreatment.isproviderinvolved : this.returnMaltreatmentProInvolvedFn();
        this.addMaltreatment.providerMaltreatmentItems.forEach((item, index) => {
            if (item) {
                this.providermaltreatment.push({ providermaltreatmenttypekey: this.providerMaltreatmentTypeItems[index].value });
            }
        });
        this.addMaltreatment.providermaltreatment = this.providermaltreatment;
        this.addMaltreatment.isnotapplicable = this.addMaltreatment.isnotapplicable ? '1' : '0';
    }
    private returnMaltreatmentProInvolvedFn(): any {
        return (this.addMaltreatment.isproviderinvolved === 0 ? 0 : null);
    }

    // Assosiated to saveMaltreatment method
    private handleIfMaltreatorsFn() {
        if (this.addMaltreatment.maltreators) {
            this.addMaltreatment.maltreators.forEach((item) => {
                this.checkIfMaltreatoractoridFn(item);
            });
            if (this.maltreatmentFormGroup.value.caseworker) {
                this.handleJurisdictionuserFn(this.maltreatmentFormGroup.value.caseworker, 'CW');
            }
        }
    }
    private checkIfMaltreatoractoridFn(item: Maltreator) {
        if (item.maltreatoractorid === 'unknown' || item.maltreatoractorid === 'nomaltreator') {
            if (item.maltreatoractorid === 'unknown') {
                item.othermaltreator = 'unknown';
            }
            if (item.maltreatoractorid === 'nomaltreator') {
                item.othermaltreator = 'nomaltreator';
            }
            item.maltreatoractorid = null;
        }
    }

    // Assosiated to saveMaltreatment method
    private handleAddMaltreatmentFn() {
        this._service.create(this.addMaltreatment, CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.AddMaltreatmentINformationUrl).subscribe((response: any) => {
                if (response) {
                    this.isSubmitting = true;
                    this._alertService.success('Maltreatment added successfully');
                    this.providermaltreatment = [];
                    this.initialFormGroup();
                    this.getMaltreatmentInformation(false);
                    window.location.reload();
                }
            }, (_error: any) => {
                this.isSubmitting = true;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    // Assosiated to saveMaltreatment method
    private handleUpdateMaltreatmentFn() {
        this._service.create(this.addMaltreatment, CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.AddMaltreatmentINformationUrl).subscribe((response: any) => {
                if (response) {

                    this._alertService.success('Maltreatment Updated successfully');
                    window.location.reload();
                }
            }, (_error: any) => {
                this.isSubmitting = true;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    historyRecords(allegation: any) {
        this.showhistoryRecords = false;
        const filterlist  = allegation.value.maltreatmentid;
        const allegationlist = this.investigationFinding.filter((item: { maltreatmentid: any; }) => item.maltreatmentid == filterlist);
        if (allegationlist && allegationlist.length && allegationlist[0].auditinfo) {
            this.auditHistoryList = allegationlist[0].auditinfo;
            this.showhistoryRecords = true;
        }
    }

    saveMaltreatmentAllegation(person: any,i: any) {
        this.isSubmitting = true;  
        this.displayvalidationMessages[i] =true;     
        if ((this.isProbabilityPresent === this.nomaltreatorfound) || (this.isProbabilityPresent === this.nomaltreatmentpresent)) {
            $(this.maltreatmentpopupid).modal('show');
            return;
        }
        const maltreatment = person.value;
        if (typeof(person.value.providerid) !== 'number') {
            person.value.providerid = null;
        }
        this.addMaltreatment = Object.assign(new AddMaltreatment(), person.value);
        
        if(!this.handleIfProviderinvolvedFn()) {
            return;
        }
        
        if(!this.handleIfNotapplicable(maltreatment)) {
            return;
        }
        
        if (this.addMaltreatment.allegationid) {
            this.saveMaltreatmentAllegationIfAllegationidFn(maltreatment);
            
            // Validate Date of Incident Start and End dates
            if(!this.handleValidatedateFn(maltreatment)) {
                return;
            }

            // End of Validation

            this.handleMaltreatorsMapFn(maltreatment);
            if (this.addMaltreatment.investigationallegationid) {
                this.addMaltreatment.maltreatmentid = maltreatment.maltreatmentid;
                this.handleUpdateIfInvestigationallegationidFn();
            } else {
                this.handleAddIfNoInvestigationallegationidFn();
            }
        }
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleValidatedateFn(maltreatment: any) {
        const { eDate, iDate, receivedDate } = this.returnDateInSaveMaltreatmentAllegationFn(maltreatment);
        if (eDate && iDate && iDate.isAfter(eDate)) {
            this._alertService.error('Date of Incident End Date should be after Start Date');
            return false;
        }

        if (receivedDate && iDate && !receivedDate.isSame(iDate, 'day') && iDate.isAfter(receivedDate)) {
            this._alertService.error('Date of Incident should be on or before received date [' + receivedDate.format(this.dtformat) + ']');
            return false;
        }
        return true;
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleIfProviderinvolvedFn() {
        if (!this.addMaltreatment.notapplicablecomments && this.addMaltreatment.isnotapplicable) {
            this._alertService.error('Please Enter Comments');
            this.isSubmitting = false;
            return false;
        }
        if (this.addMaltreatment.isproviderinvolved) {
            this.changeProviderDetails = true;
        }
        if (this.addMaltreatment.isproviderinvolved == '1') {
            if (!this.addMaltreatment.providerMaltreatmentItems[0] && !this.addMaltreatment.providerMaltreatmentItems[1] && !this.addMaltreatment.providerMaltreatmentItems[2] && !this.addMaltreatment.providerMaltreatmentItems[3] && !this.addMaltreatment.providerMaltreatmentItems[4]) {
                this._alertService.error('Please Enter Provider Maltreatment Type Items');
                this.isSubmitting = false;
                return false;
            } 
            if((this.addMaltreatment.providername == '' || this.addMaltreatment.providerid  == 0) && !this.addMaltreatment.providerMaltreatmentItems[2] && !this.addMaltreatment.providerMaltreatmentItems[3]) {
              this._alertService.error('Please Enter Provider Details');
              this.isSubmitting = false;
              return false;
            } 
        }
        return true;
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleIfNotapplicable(maltreatment: any) {
        if(this.providerRequired && !this.showcheckbox) {
            this._alertService.error('Please Enter Required Fields');
            this.isSubmitting = false;
            return false;
        }
        if (!this.addMaltreatment.incidentdate && !this.addMaltreatment.isnotapplicable) {
            this._alertService.error('Please Enter Start Date of incident');
            return false;
        }
        if (!this.addMaltreatment.timeofincidence && !this.addMaltreatment.isnotapplicable) {
            this._alertService.error('Please Enter Time of incident');
            this.isSubmitting = false;
            return false;
        }
        // D-07005 Start
        if (!this.addMaltreatment.comments && !this.addMaltreatment.isnotapplicable) {
            this._alertService.error('Please Enter Maltreatment Characteristics Comments');
            this.isSubmitting = false;
            return false;
        }
        // D-07005 End
        // if (!this.addMaltreatment.injurycomments && !this.addMaltreatment.isnotapplicable) {
        //     this._alertService.error('Please Enter Injury Characteristics Comments');
        //     return;
        // }
        if (!this.addMaltreatment.allegationid) {
            this._alertService.error('Please Select Maltreatment Type and Alleged Maltreators.');
            this.isSubmitting = false;
            return false;
        }
        if (!maltreatment.maltreatoractorid) {
            this._alertService.error('Please Alleged Maltreators.');
            this.isSubmitting = false;
            return false;
        } 
        return true;
    }
    // Assosiated to saveMaltreatmentAllegation method
    private saveMaltreatmentAllegationIfAllegationidFn(maltreatment: any) {
        this.addMaltreatment.allegationid = this.addMaltreatment.allegationid.split('~')[0];
        this.addMaltreatment.maltreatmentid = null;
        this.addMaltreatment.personid = this.selectedChild.personid;
        this.addMaltreatment.intakeservicerequestactorid = this.selectedChild.intakeservicerequestactorid;
        this.addMaltreatment.maltreators = this.onChangeIndicator(maltreatment.maltreatorid) ?? [];
        this.addMaltreatment.areaofinjury = this.onChangeInjuryTypeKey(maltreatment.injurytypekey);
        this.addMaltreatment.maltreatmentcharacterstics = this.onChangeMaltreatmentCharacteristicsType(maltreatment.maltreatmentcharactersticstypekey);
        this.addMaltreatment.injurycharactertics = this.onChangeInjuryCharactersticsType(maltreatment.injurycharactersticstypekey);
        this.addMaltreatment.isjurisdiction = maltreatment.isjurisdiction;
        this.addMaltreatment.isnotapplicable = maltreatment.isnotapplicable ? 1 : 0;
        this.addMaltreatment.notapplicablecomments = maltreatment.notapplicablecomments;
        this.addMaltreatment.countyid = maltreatment.countyid ? maltreatment.countyid : null;
        this.addMaltreatment.incidentlocationtypekey = maltreatment.incidentlocationtypekey;
        this.addMaltreatment.investigationid = this.dsdsActionsSummary.da_investigationid;
        this.addMaltreatment.investigationallegationid = this.addMaltreatment.investigationallegationid ? this.addMaltreatment.investigationallegationid : null;
        this.addMaltreatment.timeofincidence = this.addMaltreatment.timeofincidence ? this.convertMatinputTimeToTimestamp(this.addMaltreatment.timeofincidence) : null;
        this.addMaltreatment.isproviderinvolved = this.addMaltreatment.isproviderinvolved ? this.addMaltreatment.isproviderinvolved : this.returnMaltreatmentProInvolvedFn();

        if (this.addMaltreatment.isproviderinvolved == 1) {
            this.addMaltreatment.providerMaltreatmentItems.forEach((item1, index) => {
                if (item1) {
                    this.providermaltreatment.push({ providermaltreatmenttypekey: this.providerMaltreatmentTypeItems[index].value });
                }
            });
        }
        this.addMaltreatment.providermaltreatment = this.providermaltreatment;
        this.addMaltreatment.isnotapplicable = this.addMaltreatment.isnotapplicable ? 1 : 0;
        this.addMaltreatment.oldprovider = this.oldproviderid ? this.oldproviderid : null;
        this.addMaltreatment.explainReason = this.showcheckbox ? this.showcheckbox : null;
        this.addMaltreatment.linkschidresid = this.showcheckbox ? this.showcheckbox : false;
        this.addMaltreatment.intakesdmid = this.intakesdmid;
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleAddIfNoInvestigationallegationidFn() {
        this._service.create(this.addMaltreatment, CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.AddMaltreatmentINformationUrl).subscribe((response: any) => {

                if (response) {

                    this._alertService.success('Maltreatment added successfully', true);
                    this.providermaltreatment = [];
                    this.initialFormGroup();
                    this.getMaltreatmentInformation(false);
                    setTimeout(() => {
                        this._dataStoreService.setData('holdChildValue', this.selectedChild);
                        this.reloadCurrPage();
                        this.isSubmitting = false;
                    }, 1000);
                }
            }, (_error: any) => {
                this.isSubmitting = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleUpdateIfInvestigationallegationidFn() {
        this._service.create(this.addMaltreatment, CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.AddMaltreatmentINformationUrl).subscribe((response: any) => {
                this._dataStoreService.setData('holdChildValue', this.selectedChild);

                this.isSubmitting = false;
                if (response) {
                    this._alertService.success('Maltreatment Updated successfully', true);
                    setTimeout(() => {
                        this.reloadCurrPage();
                    }, 1000);
                }
            }, (_error: any) => {
                this.isSubmitting = false;
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleMaltreatorsMapFn(maltreatment: any) {
        this.addMaltreatment.enddate = maltreatment.enddate ? maltreatment.enddate : null;
        this.addMaltreatment.incidentdate = maltreatment.incidentdate ? maltreatment.incidentdate : null;

        this.handleMaltreatorsMapFnIfMaltreators();
        if (maltreatment.caseworker) {
            this.handleJurisdictionuserFn(maltreatment.caseworker, 'CW');
        }

        if (maltreatment.supervisor) {
            this.handleJurisdictionuserFn(maltreatment.supervisor, 'SP');
        }
        this.isSubmitting = true;
        this.addMaltreatment.objectid = this.id;
        this.addMaltreatment.objecttype = 'servicerequest';
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleMaltreatorsMapFnIfMaltreators() {
        if (this.addMaltreatment.maltreators) {
            this.addMaltreatment.maltreators.forEach((item) => {
                this.checkIfMaltreatoractoridFn(item);
            });
        }
    }
    // Assosiated to saveMaltreatmentAllegation method
    private handleJurisdictionuserFn(name: any, role: any) {
        const jurisdictionuser = Object.assign({
            name: name,
            role: role
        });
        this.addMaltreatment.jurisdictionuser.push(jurisdictionuser);
    }

    private returnDateInSaveMaltreatmentAllegationFn(maltreatment: any) {
        const eDateStr = maltreatment.enddate ? maltreatment.enddate + '' : null;
        let eDate;
        const incidentdateStr = maltreatment.incidentdate ? maltreatment.incidentdate + '' : null;
        let iDate;
        const receivedDateStr = this._dataStoreService.getData('da_receiveddate');
        let receivedDate;
        if (receivedDateStr) {
            receivedDate = moment(new Date(receivedDateStr.substr(0, 16)));
        }
        if (eDateStr) {
            const eDateSt = moment(eDateStr).format(this.dtwithtimeformat);
            eDate = moment(new Date(eDateSt.substr(0, 16)));
            maltreatment.enddate = eDate.format(this.dtformat);
        }
        if (incidentdateStr) {
            const incidentdate = moment(incidentdateStr).format(this.dtwithtimeformat);
            iDate = moment(new Date(incidentdate.substr(0, 16)));
            maltreatment.incidentdate = iDate.format(this.dtformat);
        }
        return { eDate, iDate, receivedDate };
    }

    convertMatinputTimeToTimestamp(time: any) {
        return moment(moment(this.currentdate).format(this.dtformat) + ' ' + time).format();
    }

    private getJurisdictionDropdown() {
        this.jurisdictionDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    method: 'post',
                    order: 'countyname asc',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.JurisdictionListUrl + '?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyid
                        })
                );
            }));
    }

    private getDropdown() {
        const source = forkJoin([
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
            ),
            this._commonHttpService.getArrayList(
                {
                    nolimit: true,
                    method: 'get',
                    order: this.displayorder
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.InjuryTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    nolimit: true,
                    method: 'get',
                    order: this.displayorder
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentCharactersticsTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    nolimit: true,
                    method: 'get',
                    order: this.displayorder
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.injuryCharactersticsTypeUrl + '?filter'
            )
        ]).pipe(
            map((result: any) => {
                return {
                    maltreatmentType: result[0].map(
                        (res: { name: any; allegationid: any; isenablesextraffic: any; }) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.allegationid,
                                additionalProperty: res.isenablesextraffic
                            })
                    ),
                    injuryType: result[1].map(
                        (res: { typedescription: any; injurytypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.injurytypekey
                            })
                    ),
                    maltreatmentCharactersticsType: result[2].map(
                        (res: { typedescription: any; maltreatmentcharactersticstypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.maltreatmentcharactersticstypekey
                            })
                    ),
                    injuryCharactersticsType: result[3].map(
                        (res: { typedescription: any; injurycharactersticstypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.injurycharactersticstypekey
                            })
                    )
                };
            }),
            share(),);
        this.maltreatmentTypeDropdownItems$ = source.pipe(pluck('maltreatmentType'));
        this.maltreatmentTypeDropdownItems$.subscribe(data => {
            this.maltreatmentTypeDropdownItems = data;
            let i = 0;
            data.forEach(maltreatment => {
                this.filterAllegations(maltreatment.text);
                if (this.foundAllegation) {
                    i++;
                }
            });
            this.isProbabilityPresent = (i > 0) ? null : this.nomaltreatmentpresent;
        });
        this.injuryTypeDropdownItems$ = source.pipe(pluck('injuryType'));
        this.maltreatmentCharactersticsTypeDropdownItems$ = source.pipe(pluck('maltreatmentCharactersticsType'));
        this.injuryCharactersticsTypeDropdownItems$ = source.pipe(pluck('injuryCharactersticsType'));

    }

    private getInvolvedPerson() {
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
                    limit: 20,
                    method: 'get',
                    where: this.getRequestParam()
                }),
                url + '?filter'
            )
            .subscribe((items) => {
                if (items.data) {
                    this.childDetails = [];
                    this.involvedPersons = items['data'];
                    items.data.forEach((list) => {
                        this.abusedChildList = items['data'].filter(person => {
                            const roles = (Array.isArray(person.roles)) ? person.roles : [];
                           // const victim = roles.some(role => ['CHILD', 'AV'].includes(role.intakeservicerequestpersontypekey));
                           // Non-Victim should not under Maltreatment tab
                            return roles.some((role: { intakeservicerequestpersontypekey: string; }) => ['AV'].includes(role.intakeservicerequestpersontypekey));
                        });
                        
                        if (list.roles) {
                            const getAllRoles = list.roles.filter((role: { intakeservicerequestpersontypekey: string; }) => role.intakeservicerequestpersontypekey === 'AM');
                            if (getAllRoles.length) {
                                return this.childDetails.push(
                                    new DropdownModel({
                                        value: getAllRoles[0].intakeservicerequestactorid,
                                        text: list.fullname,
                                        isencryptedpersonrole: list.isencryptedpersonrole
                                    })
                                );
                            }
                        }
                    });

                    this.handleAbusedChildListFn();
                }
            });
    }
    // Assosiated to getInvolvedPerson method
    private handleAbusedChildListFn() {
        this.abusedChildList.forEach((element, i) => {
            if (i === 0) {
                this.selectChild(element);
            }
        });

        this.isProbabilityPresent = (this.childDetails.length > 0) ? null : this.nomaltreatorfound;

        if (this.childDetails.length === 0) {
            $('#no-maltreator-popup').modal('show');
        }
    }

    getRequestParam() {
        let inputRequest: Object;
        const caseID = this.id;
        const isservicecase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        if (isservicecase) {
          inputRequest = {
            objectid: caseID,
            objecttypekey: 'servicecase'
          };
        } else {
          inputRequest = {
            intakeserviceid: caseID,
            'isExpungementSuperUser': isExpungementSuperUser,
            'iscaseexpunged': this.iscaseexpunged
          };
        }

        return inputRequest;
      }

    private getIncidentLocation() {
        this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.IncidentLocationDropDown).subscribe((data) => {
            this.incidentLocation = [];
            data.forEach((values) => {
                this.incidentLocation.push(new DropdownModel({ value: values.incidentlocationtypekey, text: values.typename }));
            });
        });
    }
    sexualAbuse(data: any, index: any, InvestigationIndex: any) {
        const items: any = data.value.split('~');
        const control: any = <FormArray>this.maltreatmentFormGroup.controls['person'];
        if (items[1] === '1') {
            control.controls[index]['controls']['investigationallegation']['controls'][InvestigationIndex].controls['isShowSextrafficking'].patchValue(true);
        } else {
            control.controls[index]['controls']['investigationallegation']['controls'][InvestigationIndex].controls['isShowSextrafficking'].patchValue(false);
        }
    }

    onChangeMaltreatment(item: any, index: any, InvestigationIndex: any) {
        const control: any = <FormArray>this.maltreatmentFormGroup.controls['person'];
        if (item === '1') {
            control.controls[index]['controls']['investigationallegation']['controls'][InvestigationIndex].controls['isDisplayProviderInvolved'].patchValue(true);
        } else {
            control.controls[index]['controls']['investigationallegation']['controls'][InvestigationIndex].controls['isDisplayProviderInvolved'].patchValue(false);
        }
    }

    providerInvolvedChange(value: any, index: any) {
        const type = this.allegationForm.getRawValue();
        this.isMaltreatorChanged = true;
        this.showcheckbox=false;
        if (value.checked) {
            const allegationArrayFn = this.allegationForm.get('allegations') as FormArray;
          if (type.allegations[index].isproviderinvolved == 0 ) {
            this.reasonChangeText = 'Provider Involved';
            allegationArrayFn.controls[index].patchValue({isproviderinvolved: 1});
            allegationArrayFn.controls[index].patchValue({reasonchange: this.reasonChangeText });
          } else {
            this.reasonChangeText = 'Provider Not Involved';
            allegationArrayFn.controls[index].patchValue({isproviderinvolved: 0});
            allegationArrayFn.controls[index].patchValue({reasonchange: this.reasonChangeText});
            allegationArrayFn.controls[index].patchValue({providername: null});
            allegationArrayFn.controls[index].patchValue({providerid: null});
            allegationArrayFn.controls[index].patchValue({providerphone: null});
          }
            
        } else {
            this.reasonChangeText = null;
        }
    }

    setproviderInvolvedChange(isprovider: any, index: any) {
        if(this.intakeSDM) {
            const allegationArrayData = this.allegationForm.get('allegations') as FormArray;

            if(allegationArrayData.controls[index]){
                allegationArrayData.controls[index].patchValue({providerMaltreatmentItems: [this.intakeSDM?.isfcplacementsetting,
                this.intakeSDM.isprivateplacement,
                this.intakeSDM.islicenseddaycare,
                this.intakeSDM.isschool,
                this.intakeSDM.isfclivingarrangement]});
            }
            if (this.intakeSDM.islicenseddaycare || this.intakeSDM.isschool)  {
               this.enablecheckbox = true;
            }
            
            if(this.intakeSDM.isfcplacementsetting || this.intakeSDM.isprivateplacement){
                this.getPlacementDetails(this.intakeSDM.isfcplacementsetting ? 0 : 1);
                this.providerRequired = true;
            }

            this.handleIntakeSDMCondFn(index);
        }
        this.handleProviderInSetproviderInvolvedChangeFn(isprovider, index);
    }
    // Assosiated with setproviderInvolvedChange method
    private handleProviderInSetproviderInvolvedChangeFn(isprovider: any, index: any) {
        const allegationArrayData = this.allegationForm.get('allegations') as FormArray;
        if (isprovider) {
            if (allegationArrayData.controls[index]) {
                allegationArrayData.controls[index].patchValue({ isproviderinvolved: 1 });
            }
        } else {
            if (allegationArrayData.controls[index]) {
                allegationArrayData.controls[index].patchValue({ isproviderinvolved: 0 });
            }
        }
    }

    // Assosiated to setproviderInvolvedChange method
    private handleIntakeSDMCondFn(index: any) {
        if(this.intakeSDM.isfcplacementsetting || this.intakeSDM.isprivateplacement){
            this.getPlacementDetails(this.intakeSDM.isfcplacementsetting ? 0 : 1);
            this.providerRequired = true;
        }

        if (this.intakeSDM.isfclivingarrangement) {
            this.isLivingArrangment = true;
            this.providerRequired = true;
            this.checkLadetailsCondFn(index);

        } else if ((this.checkProviderCondFn()) || (this.checkIfNotProviderCondFn())) {
            const filterProv = this.intakeSDM.provider[0];
            this.isSchool = true;
            this.patchProviderDetailsFn(index, filterProv);

        } else if (this.placementRecords && this.placementRecords.length) {
            const selectedProv = this.placementRecords.findIndex(f => f.placementid === this.intakeSDM.providerdetails);
            if (selectedProv > -1) {
                if (this.placementRecords[selectedProv].cpahomedetails) {
                    this.cpahomedetails = this.placementRecords[selectedProv].cpahomedetails;
                }
                const filterProv = this.placementRecords[selectedProv].providerdetails;
                this.providerRequired = true;
                const allegationArrayData = this.allegationForm.get('allegations') as FormArray;
                allegationArrayData.controls[index].patchValue({ providername: filterProv?.providername });
                allegationArrayData.controls[index].patchValue({ providerid: filterProv?.provider_id });
                allegationArrayData.controls[index].patchValue({ providerphone: filterProv?.address });
            }
        }
    }
    private checkIfNotProviderCondFn() {
        return (!(this.intakeSDM.isschool || this.intakeSDM.islicenseddaycare) && this.intakeSDM.provider?.length > 0);
    }

    private checkProviderCondFn() {
        return ((this.intakeSDM.isschool || this.intakeSDM.islicenseddaycare) && this.intakeSDM.provider?.length > 0);
    }

// Assosiated to setproviderInvolvedChange method
    private checkLadetailsCondFn(index: any) {
        const ladetails = this.placementRecords?.findIndex(f => f.placementid === this.intakeSDM.providerdetails);
        const filterProv = this.intakeSDM.provider[0];
        const allegationArrayData = this.allegationForm.get('allegations') as FormArray;
        if (ladetails !== -1) {
            const lvtyp = this.placementRecords[ladetails].livingarrangementtype;
            const lvid = this.placementRecords[ladetails].primarycaregiver;
            const lvaddress = this.placementRecords[ladetails]?.address1 + " ," + (this.placementRecords[ladetails]?.address2 || '') + " ," + this.placementRecords[ladetails]?.cityname + " " + this.placementRecords[ladetails]?.statetypekey + "," + this.placementRecords[ladetails]?.zipcode;
            allegationArrayData.controls[index].patchValue({ providername: lvtyp });
            allegationArrayData.controls[index].patchValue({ providerid: lvid });
            allegationArrayData.controls[index].patchValue({ providerphone: lvaddress });
        } else if (filterProv) {
            allegationArrayData.controls[index].patchValue({ providername: filterProv.providername });
            allegationArrayData.controls[index].patchValue({ providerid: filterProv.providerid });
            allegationArrayData.controls[index].patchValue({ providerphone: filterProv.providerphone });
        }
    }
// Assosiated to setproviderInvolvedChange method
    private patchProviderDetailsFn(index: any, filterProv: any) {
        const allegationArrayData = this.allegationForm.get('allegations') as FormArray;
        allegationArrayData.controls[index].patchValue({ providername: filterProv?.providername });
        allegationArrayData.controls[index].patchValue({ providerid: filterProv?.providerid });
        allegationArrayData.controls[index].patchValue({ providerphone: filterProv?.providerphone });
    }

    onChangeProviderinvolvedType(value: any) {
        const type = this.providermaltreatment.filter(item => item.providermaltreatmenttypekey === value);
        if (type.length) {
            const index = this.providermaltreatment.indexOf(type[0]);
            this.providermaltreatment.splice(index, 1);
            this.reasonChangeText = 'Not Provider Involved';
        } else {
            this.reasonChangeText = 'Provider Involved';
            this.providermaltreatment.push({ providermaltreatmenttypekey: value });
        }
    }

    onFatalityChange(event: any, index: any) {
        if (event.value === 1) {
            if (!this.allegedChild.dateofdeath) {
                const cntrl = (<FormArray>this.allegationForm.get('allegations')).at(index);
                // const control = <FormArray>this.maltreatmentFormGroup.controls['person'];
                // control.controls[index].patchValue({ ischildfatality: 0 });
                cntrl.patchValue({ ischildfatality: 0 });
                this._alertService.error('Selected child has no date of death');
            }
        }
    }
    private getInvolvedPersons() {
        this._commonHttpService
            .getArrayList(
                {
                    page: 1,
                    method: 'get',
                    where: { intakeservreqid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            )
            .subscribe((res: any) => {
                if (res['data'] && res['data'].length) {
                    const persons = res['data'];
                    this.involvedPersons = res['data'].filter((item: { rolename: string; }) => item.rolename === 'RC');
                    this.abusedChildList = persons.filter((person: { roles: any; }) => {
                        const roles = (Array.isArray(person.roles)) ? person.roles : [];
                        return roles.some(role => ['CHILD', 'AV'].includes(role.intakeservicerequestpersontypekey));
                    });
                }
            });
    }

    startDateChanged(investigationForm: any) {
        const empForm = investigationForm.getRawValue();
        this.minDate = new Date(empForm.incidentdate);
    }

    endDateChanged(investigationForm: any) {
        const empForm = investigationForm.getRawValue();
        this.maxDate = new Date(empForm.enddate);
    }

    getSDM() {
        // servicerequestid is bound to a uuid parameter, so an unresolved this.id
        // reaches Postgres as 22P02 and the api flattens that into a bare 400.
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
            .subscribe((res) => {
                if (res && res.length > 0 && res[0].getintakeservicerequestsdm && res[0].getintakeservicerequestsdm.length > 0) {
                    const sdm = res[0].getintakeservicerequestsdm.find((item: { pathwaystatus: string; }) => item.pathwaystatus === 'Accepted');
                    this.intakesdmid = sdm.intakeservicerequestsdmid;
                    if (sdm) {
                        this.handleIfSdmfn(sdm);
                    }
                }
            });
    }
    // Assosiated with getSDM method
    private handleIfSdmfn(sdm: any) {
        if (sdm.ismalpa_suspeciousdeath || sdm.ismalpa_nonaccident || sdm.ismalpa_injuryinconsistent ||
            sdm.ismalpa_insjury || sdm.ismalpa_childtoxic || sdm.ismalpa_caregiver || sdm.ismalpa_labortrafficking) { this.sdmAllegation['phyabuse'] = true; }
        if (sdm.ismalsa_sexualmolestation || sdm.ismalsa_sexualact || sdm.ismalsa_sexualexploitation || sdm.ismalsa_physicalindicators || sdm.ismalsa_sex_trafficking) { this.sdmAllegation['sexabuse'] = true; }
        if (sdm.ismenab_psycologicalability) {
            this.sdmAllegation['miabuse'] = true;
        }

        this.handleIfAllegedvictimFn(sdm);
        if (sdm.ismenng_psycologicalability) {
            this.sdmAllegation['mineglect'] = true;
        }
        if (this.returnSdmCondFn(sdm)) { this.sdmAllegation['neglect'] = true; }
    }
    // Assosiated with getSDM method
    private returnSdmCondFn(sdm: any) {
        return (sdm.isnegmn_unreasonabledelay || sdm.isneguc_leftunsupervised || sdm.isneguc_leftaloneinappropriatecare || sdm.isneguc_leftalonewithoutsupport || sdm.isnegab_abandoned ||
            sdm.isnegfp_cargiverintervene || sdm.isnegrh_treatmenthealthrisk || sdm.isneggn_inadequatesupervision || sdm.isneggn_inadequateclothing || sdm.isneggn_exposuretounsafe ||
            sdm.isneggn_childdischarged || sdm.isneggn_inadequatefood || sdm.isneggn_signsordiagnosis || sdm.isneggn_suspiciousdeath);
    }
    // Assosiated with getSDM method
    private handleIfAllegedvictimFn(sdm: any) {
        if (this.allegedChild && sdm.allegedvictim && sdm.allegedvictim.length) {
            sdm.allegedvictim.forEach((element: { victimname: any; }) => {
                if (element.victimname == this.allegedChild.fullname) {
                    this.checkIfFullnameFn(sdm);
                } else {
                    const control = <FormArray>this.allegationForm.controls['allegations'];
                    this.handleIfValueIsNotZeroFn(control);
                }
            });
        }
    }
    // Assosiated with getSDM method
    private checkIfFullnameFn(sdm: any) {
        if (sdm.linkschidresid) {
            this.showcheckbox = true;
        }
        if (sdm.intakesnapshotdata && sdm.intakesnapshotdata.sdm) {
            this.intakeSDM = sdm.intakesnapshotdata.sdm;
            this.abusedChildList.forEach(elem => {
                this.getFilterPlacementDetails(elem.personid);
            });
            if (this.intakeSDM.linkschidresid) {
                this.showcheckbox = true;
            }
            if (this.intakeSDM.ismaltreatment) {
                this.disableproviderchange = true;

            } else {
                this.disableproviderchange = false;
            }
        }
        if (sdm.ismaltreatment) {
            this.involvedMaltreatorDetails = '1';
            this.disableproviderchange = true;
        }
        if (!sdm.ismaltreatment) {
            this.involvedMaltreatorDetails = '0';
            this.disableproviderchange = false;
        }
        if (sdm.provider) {
            this.involvedProviderDetails = sdm.provider;
        }
    }
    // Assosiated with getSDM method
    private handleIfValueIsNotZeroFn(control: FormArray) {
        if (control.value.length !== 0) {
            if (!control.value[0].maltreatmentid || control.value[0].maltreatmentid == undefined) {
                this.showcheckbox = false;
                const allegationArrayData = this.allegationForm.get('allegations') as FormArray;
                allegationArrayData.controls[0].patchValue({
                    maltreatorname: control.value[0].maltreatorname,
                    childname: control.value[0].childname,
                    investigationallegationid: null,
                    maltreatmentid: null,
                    maltreatment: control.value[0].maltreatment,
                    providerMaltreatmentItems: [false, false, false, false, false],
                    isproviderinvolved: 0,
                    providername: null,
                    providerid: null,
                    providerphone: null
                });
            }
        }
    }
    

    filterAllegations(text: any) {
        this.foundAllegation = false;
        if (this.sdmAllegation) {
            this.handleIfSdmAllegationFn(text);
        } else {
            this.findAllegationsInMaltreatmentInfo(text);
        }
    }
    // assosiated with filterAllegations method
    private handleIfSdmAllegationFn(text: any) {
        if (text === 'Mental Injury- Abuse') {
            this.foundAllegation = (this.sdmAllegation['miabuse']) ? true : this.findAllegationsInMaltreatmentInfo(text);
        }

        if (text === 'Mental Injury- Neglect') {
            this.foundAllegation = (this.sdmAllegation['mineglect']) ? true : this.findAllegationsInMaltreatmentInfo(text);
        }

        if (text === 'Neglect') {
            this.foundAllegation = (this.sdmAllegation['neglect']) ? true : this.findAllegationsInMaltreatmentInfo(text);
        }

        if (text === 'Physical Abuse') {
            this.foundAllegation = (this.sdmAllegation['phyabuse']) ? true : this.findAllegationsInMaltreatmentInfo(text);
        }

        if (text === 'Sexual Abuse') {
            this.foundAllegation = (this.sdmAllegation['sexabuse']) ? true : this.findAllegationsInMaltreatmentInfo(text);
        }
    }


    findAllegationsInMaltreatmentInfo(text: any) {
        let allegations: any[] = [];
        let chosenchild = (this.selectedChild && this.selectedChild.actorid) ? this.selectedChild.actorid : null;
        if (this.maltreatmentInformation && this.maltreatmentInformation.length) {
            allegations = this.maltreatmentInformation.filter(item => {
                return item.actorid === chosenchild;
            });
        }

        if (allegations.length > 0) {
            allegations.forEach(alle => {
                this.handleAllegationsLoopFn(alle, text);
            });
        } else {
            return false;
        }
    }
    // assosiated with filterAllegations method
    private handleAllegationsLoopFn(alle: any, text: any) {
        if (alle && alle.investigationallegation) {
            alle.investigationallegation.forEach((element: { allegationname: any; }) => {
                if (element.allegationname === text) {
                    this.foundAllegation = true;
                } else {
                    this.foundAllegation = false;
                }
            });
        }
    }

    createFormarray() {
        const tempArray: any[] = [];
        this.maltreatmentTypeDropdownItems.forEach(maltreatment => {
            this.filterAllegations(maltreatment.text);
            setTimeout(() => {
            if (this.foundAllegation) {
                tempArray.push(maltreatment);
            }
            }, 2000);
        });
        tempArray.forEach(maltreatment => {
                setTimeout(() => {
                const control = <FormArray>this.maltreatmentFormGroup.controls['allegations'];
                this.childDetails.forEach(maltreator => {                    
                    const newForm = this.createFormElement(maltreatment, maltreator);
                    control.push(newForm);
                    const maltreatmentcase = this.maltreatmentInformation.find(info => {
                        const ischildpresent = ((info.intakeservicerequestactorid === this.selectedChild.intakeservicerequestactorid) ||
                                            (info.actorid && info.actorid === this.selectedChild.actorid));
                        const investigationallegation: any = info.investigationallegation[0];
                        const ismaltreatorpresent = investigationallegation.maltreators.some((item: { intakeservicerequestactorid: any; }) => item.intakeservicerequestactorid === maltreator.value);
                        const isallegation = investigationallegation.allegationid === maltreatment.value;
                        return (ischildpresent && ismaltreatorpresent && isallegation) ? true : false;
                    }
                    );
                    setTimeout(() => {
                    if (maltreatmentcase) {
                        newForm.disable();
                        newForm.patchValue(maltreatmentcase);
                    }
                }, 2000);
                });
            }, 2000);
        });

    }

    private createFormElement(maltreat: any, person: any): FormGroup {
        const controls = this.providerMaltreatmentTypeItems.map(c => {
            return new FormControl(false);
        });
        let incidentdate = null;
        let incidentlocationtypekey = null;
        if (this.reportSummary && this.reportSummary.reporterincidentdate) {
            incidentdate = this.reportSummary.reporterincidentdate;
            this.incidentdate = incidentdate;
        }
        if (this.reportSummary && this.reportSummary.reporterincidentlocation) {
            incidentlocationtypekey = this.reportSummary.reporterincidentlocation;
        }
        return this._formBuilder.group({
            personname: person.text,
            maltreatorid: person.value,
            maltreatment: maltreat.text,
            maltreatmentid: maltreat.value,
            childname: this.allegedChild ? this.allegedChild.fullname : '',
            incidentlocationtypekey: [incidentlocationtypekey],
            isjurisdiction: [''],
            countyid: [''],
            caseworker: [''],
            supervisor: [''],
            isnotapplicable: [null],
            notapplicablecomments: [null],
            investigationallegationid: [''],
            incidentdate: [ incidentdate ? incidentdate : null],
            allegationid: maltreat.value + '~' + maltreat.additionalProperty,
            isShowAllegation: [false],
            maltreatoractorid: person.value,
            injurytypekey: [''],
            maltreatmentcharactersticstypekey: [''],
            injurycharactersticstypekey: [''],
            comments: ['', Validators.required],
            injurycomments: [''],
            enddate: [null],
            isapproximatedate: [false],
            timeofincidence: [null],
            sextrafficking: [''],
            injurytypedescription: [''],
            maltreatmentcharactersticstypedescription: [''],
            injurycharactersticstypedescription: [''],
            maltreatorname: person.text,
            allegationname: '',
            isShowSextrafficking: false,
            isproviderinvolved: [{value: 0, disabled: true}],
            ischildfatality: [0],
            isDisplayProviderInvolved: [''],
            providerMaltreatmentItems: new FormArray(controls),
            expungementStatus: [null],
            providername : [''],
            providerid : [''],
            providerphone : [''],
            providerCheckBoxChange: [null],
            reasonchange: [''],
            linkschidresid: [null]
        });
    }

    selectChild(child: any) {
        
        this.selectedChild = null;
        this.allegedChild = child;
        this.showcheckbox= false;
        if (this.allegationForm) {
            const control = <FormArray>this.allegationForm.controls['allegations'];

            while (control.length !== 0) {
                control.removeAt(0);
            }

        }
        this.getSDM();
        this.selectedChild = child;
        this.createMaltreatmentForm();
    }

    createMaltreatmentForm() {
        const tempArray: any[] = [];
        this.allegationForm = this._formBuilder.group({
            allegations: this._formBuilder.array([])
        });
        this.getFilterPlacementDetails(this.selectedChild.personid);

        this.maltreatmentTypeDropdownItems.forEach(maltreatment => {
            this.filterAllegations(maltreatment.text);
            if (this.foundAllegation) {
                tempArray.push(maltreatment);
            }
        });
        tempArray.forEach(maltreatment => { //Allegation
            const control = <FormArray>this.allegationForm.controls['allegations'];
            this.childDetails.forEach(maltreator => { //Maltreators
                if(!maltreator.isencryptedpersonrole || (maltreator.isencryptedpersonrole && maltreatment.text === 'Sexual Abuse')) {
                    const newForm = this.createFormElement(maltreatment, maltreator);
                    control.push(newForm);
                    let keegoing = true;
                    this.maltreatmentInformation.forEach(info => {
                        if(keegoing){
                        keegoing = this.handleInvestigationallegationLoopFn(info, maltreator, maltreatment, newForm, keegoing);  
                    }
                    }
                    );
                }
            });
        });
        setTimeout(() => {
            console.log("this.allegationForm.getRawValue()", this.allegationForm.getRawValue());
            const allig = this.allegationForm.getRawValue();
                allig.allegations.forEach((ele: any, i: any)  => {
                    if(ele.childname == this.allegedChild.fullname && ele.investigationallegationid.length==0){
                        if(this.involvedMaltreatorDetails == '1') {
                            this.changeProviderDetails = true;
                            this.setproviderInvolvedChange(true,i);
                          } else {
                              this.changeProviderDetails = true;
                              this.setproviderInvolvedChange(false,i); 
                          }
                    }
                });
        }, 2500);
    }
    // Assosiated with createMaltreatmentForm method
    private handleInvestigationallegationLoopFn(info: MaltreatmentInformation, maltreator: DropdownModel, maltreatment: any, newForm: FormGroup, keegoing: boolean) {
        const ischildpresent = ((info.intakeservicerequestactorid === this.selectedChild.intakeservicerequestactorid) ||
            (info.actorid && info.actorid === this.selectedChild.actorid));
        if (info.investigationallegation && Array.isArray(info.investigationallegation) && info.investigationallegation.length > 0) {
            const investigationallegation = info.investigationallegation[0];
            const maltreatorObj = Array.isArray(investigationallegation.maltreators) ? investigationallegation.maltreators : [];
            const ismaltreatorpresent = maltreatorObj.some(item => item.intakeservicerequestactorid === maltreator.value);
            const isallegation = investigationallegation.allegationid === maltreatment.value;
            if (ischildpresent && ismaltreatorpresent && isallegation) {
                newForm.patchValue(info);
                this.patchMaltreatmentForm(info, newForm);
                keegoing = false;
            }
            else {
                keegoing = true;
            }
        }
        return keegoing;
    }

    onExpand(allegation: any) {

        this.providerRequired = false;
        allegation.getRawValue().providerMaltreatmentItems.forEach((ele: any,x: any) => {
            if(ele && (this.providerMaltreatmentTypeItems[x].value == 'FCPS' || this.providerMaltreatmentTypeItems[x].value == 'PP' || this.providerMaltreatmentTypeItems[x].value == 'LAFC') ) {
                this.providerRequired = true;
                this.showcheckbox = true;
            }
        });
    }

    patchMaltreatmentForm(investigation: any, form: any) {
        const investigationallegation = investigation.investigationallegation[0];
        const providermaltreatment = this.providerMaltreatmentTypeItems.map(c => {
            if (investigationallegation.providermaltreatment && investigationallegation.providermaltreatment.filter((p: { providermaltreatmenttypekey: any; }) => p.providermaltreatmenttypekey === c.value).length) {
                return true;
            } else {
                return false;
            }
        });
        form.patchValue({
            isproviderinvolved: investigationallegation.isproviderinvolved ? Number(investigationallegation.isproviderinvolved) : this.returnInveAllegProviderinvolvedFn(investigationallegation),
            providerMaltreatmentItems: providermaltreatment,
            providername : investigation.providername,
            providerid : investigation.providerid,
            providerphone : investigation.providerphonenumber
        })
        //D-26926
        const isExpunged = this.handleProvidermaltreatmentAndExpungementFn(investigationallegation); 
        form.patchValue(this.patchInvestigationFormDataFn(investigation, investigationallegation, isExpunged));
        

        if (investigation.roles && investigation.roles.length) {
            investigation.roles.map((item: { role: string; username: any; }) => {
                if (item.role === 'CW') {
                    form.patchValue({ caseworker: item.username });
                }
                if (item.role === 'SP') {
                    form.patchValue({ supervisor: item.username });
                }
            });
        }
    }
    private returnInveAllegProviderinvolvedFn(investigationallegation: any) {
        return investigationallegation.isproviderinvolved === 0 ? 0 : this.involvedMaltreatorDetails;
    }

    // Assosiated with patchMaltreatmentForm method
    private handleProvidermaltreatmentAndExpungementFn(investigationallegation: any) {
        let isExpunged = false;
        const keycheck = investigationallegation.providermaltreatment && investigationallegation.providermaltreatment[0].providermaltreatmenttypekey;
        if ((keycheck == 'FCPS' || keycheck == 'PP' || keycheck == 'LAFC')) {
            this.showcheckbox = true;
        }
        if (investigationallegation && investigationallegation.expungement && investigationallegation.expungement.length) {
            const expunge = investigationallegation.expungement;
            if (expunge.isunsubstansiated || expunge.isindicated || expunge.isremovemaltreator || expunge.isremoverofindings) {
                isExpunged = true;
            }
        }
        this.changeProviderDetails = true;
        this.reasonChangeText = investigationallegation.auditinfo && investigationallegation.auditinfo.length > 0 ? investigationallegation.auditinfo[0].reasonchange : '';
        return isExpunged;
    }

    // Assosiated with patchMaltreatmentForm method
    private patchInvestigationFormDataFn(investigation: any, investigationallegation: any, isExpunged: boolean): any {
        return {
            childname: investigation.personname,
            countyid: investigation.countyid,
            incidentlocationtypekey: investigation.incidentlocationtypekey,
            isjurisdiction: investigation.isjurisdiction ? investigation.isjurisdiction.toString() : '0',
            isnotapplicable: investigation.isnotapplicable ? this.returnNotapplicableFn(investigation) : null,
            notapplicablecomments: investigation.notapplicablecomments ? investigation.notapplicablecomments.toString() : null,
            caseworker: investigation.caseworker,
            supervisor: investigation.supervisor,
            injurycharactersticstypekey: (investigationallegation.injurycharactersticstype) ? investigationallegation.injurycharactersticstype.map((item: { injurycharactersticstypekey: any; }) => item.injurycharactersticstypekey) : [],
            injurycomments: investigationallegation.injurycomments,
            maltreatmentcharactersticstypekey: (investigationallegation.maltreatmentcharactersticstypekey) ?
                investigationallegation.maltreatmentcharactersticstypekey.map((item: { maltreatmentcharactersticstypekey: any; }) => item.maltreatmentcharactersticstypekey) : [],
            injurytypekey: (investigationallegation.injurytype) ? investigationallegation.injurytype.map((item: { injurytypekey: any; }) => item.injurytypekey) : [],
            timeofincidence: investigationallegation.timeofincidence ? moment(investigationallegation.timeofincidence).format('HH:mm:ss') : null,
            isapproximatedate: investigationallegation.isapproximatedate,
            enddate: investigationallegation.enddate,
            incidentdate: investigationallegation.incidentdate,
            ischildfatality: investigationallegation.ischildfatality,
            comments: investigationallegation.comments,
            investigationallegationid: investigationallegation.investigationallegationid,
            maltreatmentid: investigationallegation.maltreatmentid,
            sextrafficking: investigationallegation.sextrafficking ? investigationallegation.sextrafficking.toString() : '0',
            expungementStatus: isExpunged,
            reasonchange: investigationallegation.auditinfo && investigationallegation.auditinfo.length > 0 ? investigationallegation.auditinfo[0].reasonchange : ''
        };
    }

    private returnNotapplicableFn(investigation: any) {
        return investigation.isnotapplicable !== 0 ? true : null;
    }

    setsearchprovider() {
        this.searchprovider.providerid = '';
        this.searchprovider.providernm = '';
        this.searchprovider.providerfname = '';
        this.searchprovider.providerlname = '';
        this.providersList = [];
    }
    pageChanged(pageNumber: any) {
        this.providerpaginationInfo.pageNumber = pageNumber.page;
        this.searchProvider();
        return pageNumber;
    }
    searchProvider() {
        this._commonHttpService.getArrayList(
            {
              method: 'post',
              nolimit: true,
              providercategorycd: [
                '3049',
                '1782',
                '3274',
                '3794',
                '3302'
            ],
            providerstatuscd: 1791,
              providerid: this.searchprovider.providerid,
              providername: this.searchprovider.providernm,
              filter: {},
              page: this.providerpaginationInfo.pageNumber,
              limit: this.providerpaginationInfo.pageSize
            },
            'providerreferral/providersearch'
        // )
          ).subscribe(providers => {
                this.providersList = providers;
                this.providerCount = providers[0].countdata;
                if (!this.providersList) {
                    this.alertMessage = 'No Results match your search criteria.';
                }
          });
      }
      selectProvider(provider: any) {
        this.selectedProvider = {providername : provider.provider_nm ? provider.provider_nm : (provider.provider_first_nm + ' ' + provider.provider_last_nm), providerid : provider.provider_id, providerphone : provider.adr_work_phone_tx};
      }

      changeProvider(provider: any, allegation: any) {
          this.selectedallegationForm = allegation;
          const address = provider.providerdetails.address;
          if (provider.cpahomedetails && provider.cpahomedetails.cpahomeaddress)  {
          //  address = provider.cpahomedetails.cpahomeaddress
            this.cpahomedetails = provider.cpahomedetails;
          } 
          this.selectedProvider = {
            providername : provider.providerdetails.providername ,
            providerid : provider.providerdetails.provider_id,
            providerphone : address
        };
        if (this.selectedallegationForm) {
            this.selectedallegationForm.patchValue(this.selectedProvider);
        }
     
      }

      changeLivingArrangement(provider: any, allegation: any) {
        this.selectedallegationForm = allegation;
        this.selectedProvider = {
          providername : provider.livingarrangementtype ,
          providerid : provider.primarycaregiver,
          providerphone : provider.address1 + ' ' + (provider.address2 || '') + ' ' + provider.cityname + ' ' + provider.statetypekey + ' ' + provider.zipcode
      };
      if (this.selectedallegationForm) {
          this.selectedallegationForm.patchValue(this.selectedProvider);
      }
   
    }

      onConfirmProvider() {
        if (this.selectedProvider) {
            $('#providersearch').modal('hide');
            this.setsearchprovider();
            if (this.selectedallegationForm) {
                this.selectedallegationForm.patchValue(this.selectedProvider);
            }
        } else {
          this._alertService.warn('Please select any provider');
        }
    }

    selectAllegationForm(allegation: any) {
        this.selectedallegationForm = allegation;
    }

    onMaltreatorChange(form: any, index: any, event: any) {
        this.providerRequired = false;
        this.isMaltreatorChanged = true;
        this.cpahomedetails = null;
        const allegationArrayData = this.allegationForm.get('allegations') as FormArray;
        if (event.checked) {
            allegationArrayData.controls[0].patchValue({providername: ''});
            allegationArrayData.controls[0].patchValue({providerid: ''});
            allegationArrayData.controls[0].patchValue({providerphone: ''});
            allegationArrayData.controls[0].patchValue({providerMaltreatmentItems: [false,false,false,false,false]});
            if(index == 0 || index == 1 || index == 4) {
                this.getPlacementDetails(index);
                this.providerRequired = true;
            }
            if (index == 3 || index == 2) {
                this.enablecheckbox = true;
                this.isSchool = true;
                
            }
            const control: FormArray = form.get('providerMaltreatmentItems');
            if (Array.isArray(control.controls)) {
                const list: any = [];
                control.controls.forEach((_item: any, i: any) => {
                    list.push((index === i) ? true : false);
                });
                control.setValue(list);
            }
        }
    }

    removeUncheck(event: any) {
        if(!event.checked) {
            this.showcheckbox = false;
        } else {
            this.showcheckbox = true;
        }
    }

getPlacementDetails(i: any) {
    this._commonHttpService
     .getSingle(
       {
        where: { personid: this.selectedChild.personid},
        method: 'get'
      },

      'placement/getplacementbyperson?filter'
    ).subscribe(data => {
        if (data && data.length) {
            const placementRecords = data.filter((item: { routingstatus: string; placementtypekey: string; }) => item.routingstatus == 'Approved' && item.placementtypekey == 'PRPL');
            const laRecords = data.filter((item: { routingstatus: string; isvoided: number; placementtypekey: string; }) => item.routingstatus == 'Approved'  && item.isvoided !== 1 && item.placementtypekey == 'LA');
            if(i == 2 || i == 3) {
                this.isSchool = true;
            }
            if (i == 0 || i == 1) {
                this.placementHistory = [];
                this.isSchool = false;
                this.checkIfZeroOrOneFn(i, placementRecords);
                
            } else if (i == 4) {
                this.livingArrangmentDetails = [];
                this.livingArrangmentDetails.push(...laRecords);
                this.isSchool = false;
                
                this.isLivingArrangment = true;
            }
        }
    });
}
// Assosiated with getPlacementDetails method
    private checkIfZeroOrOneFn(i: any, placementRecords: any) {
        if (i == 1) {
            const filterNonFamilyBased = placementRecords.filter((item: { isvoided: number; service_id: number; }) => item.isvoided === 0 && (item.service_id === 1 || item.service_id === 74 || item.service_id === 15 || item.service_id === 1 || item.service_id === 14 || item.service_id === 76 || item.service_id === 75));
            this.placementHistory.push(...filterNonFamilyBased);
            this.isLivingArrangment = false;
        } else {
            const filterFamilyBased = placementRecords.filter((item: { isvoided: number; service_id: number; }) => item.isvoided === 0 && (item.service_id === 9 || item.service_id === 11 || item.service_id === 501 || item.service_id === 525 || item.service_id === 13 || item.service_id === 8 || item.service_id === 500 || item.service_id === 10 || item.service_id === 9 || item.service_id === 167 || item.service_id === 11405 || item.service_id === 11406 || item.service_id === 11407
                || item.service_id === 11408 || item.service_id === 78 || item.service_id === 12));
            this.placementHistory.push(...filterFamilyBased);
            this.isLivingArrangment = false;
        }
    }

getFilterPlacementDetails(personid: any) {
    this._commonHttpService
     .getSingle(
       {
        where: { personid: personid},
        method: 'get'
      },

      'placement/getplacementbyperson?filter'
    ).subscribe(data => {
        if (data && data.length) {
            this.placementRecords = data;
        }
        if(this.maltreatmentInformation && this.maltreatmentInformation.length == 0) {

            this.handleIfNoMaltreatmentInformationFn();
        } else {
            this.maltreatmentInformation.forEach((x) => {
                if(x.investigationallegation && x.investigationallegation.length) {
                    this.handleIfNoInvestigationallegationFn(x);
                }    
            });
        }
    });
}
// Assosiated with getFilterPlacementDetails method
    private handleIfNoInvestigationallegationFn(x: MaltreatmentInformation) {
        x.investigationallegation.forEach((i, index) => {
            this.setproviderInvolvedChange(true, i);
            if (i.auditinfo && i.auditinfo.length) {
                if (i.providermaltreatment && i.providermaltreatment.length) {
                    const keycheck = i.providermaltreatment[0].providermaltreatmenttypekey;
                    if (keycheck == 'FCPS' || keycheck == 'PP' || keycheck == 'LAFC') {
                        this.providerRequired = true;
                    }
                }
                const details = i.auditinfo[i.auditinfo.length - 1];
                this.reasonChangeText = details.reasonchange;
                this.isMaltreatorChanged = true;
                this.oldproviderid = details.oldproviderid;
            }
        });
    }
// Assosiated with getFilterPlacementDetails method
    private handleIfNoMaltreatmentInformationFn() {
        const allig = this.allegationForm.getRawValue();
        allig.allegations.forEach((ele: any, i: any) => {
            if (ele.childname == this.allegedChild.fullname) {
                if (this.involvedMaltreatorDetails == '1') {
                    this.changeProviderDetails = true;
                    this.setproviderInvolvedChange(true, i);
                } else {
                    this.changeProviderDetails = true;
                    this.setproviderInvolvedChange(false, i);
                }
            } else {
                this.setproviderInvolvedChange(true, 0);
            }
        });
    }

getValidationMessage(controlName: any, displayname: any, i: any){
    const allegationArrayData = this.allegationForm.get('allegations') as FormArray;
    if(this.allegationForm?.controls?.allegations && allegationArrayData.controls && allegationArrayData.controls[i].get(controlName)?.status == 'INVALID'){
        return 'Please enter valid '+displayname;
    }
}

    get personControlsFn(): FormArray {
    return this.maltreatmentFormGroup.get('person') as FormArray;
  }

  get allegationControlsFn(): FormArray {
    return this.allegationForm.get('allegations') as FormArray;
  }

  getAllegationFormData(name: string): any[] {
    return Object.values((this.allegationForm.get(name) as FormGroup).controls);
  }
}
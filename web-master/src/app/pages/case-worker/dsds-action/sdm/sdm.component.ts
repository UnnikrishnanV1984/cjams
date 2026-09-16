
import {timer as observableTimer,  Observable } from 'rxjs';

import {mergeMap} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { FormArray, FormBuilder,FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { isCaseUuid, ObjectUtils } from '../../../../@core/common/initializer';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, SessionStorageService, CommonDropdownsService, GenericService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { MaltreatorsName, ProviderName, Sdm, VictimName, ReportSummary } from '../../../case-worker/_entities/caseworker.data.model';
import { MyNewintakeConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { SdmData } from '../../../newintake/my-newintake/_entities/newintakeModel';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import moment from 'moment';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { SDMResolverService } from './sdm-resolver.service';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'sdm',
    templateUrl: './sdm.component.html',
    styleUrls: ['./sdm.component.scss'],
    standalone: false
})
export class SdmComponent implements OnInit {
    id: string;
    sdmFormGroup!: FormGroup;
    isDisplayProvider = false;
    isChildInderOneYear!: string;
    isScreenOutIN = 'No';
    scnRecommendOveride = '';
    isImmediate!: string;
    sdm = new Sdm();
    getPageSdm: any;
    populateSdm!: any;
    intakeSDM: any = [];
    isLivingArrangement: boolean = false;
    isProviderDetails: boolean = false;
    showcheckbox: boolean = false;
    placementHistory: any = [];
    allegedVictim: VictimName[] = [];
    allegedMaltreator: MaltreatorsName[] = [];
    provider: ProviderName[] = [];
    maxDate = new Date();
    searchprovider: any = {};
    roleId!: AppUser;
    dayToOverride!: number;
    disableCaseWorker = false;
    isUpdatePathway: boolean = false;
    selectedcpaname :any;
    selectedcpaaddress:any;
    selectedcpaid:any;
    cpahome :boolean = false;
    sdmCountyValuesDropdownItems$!: Observable<DropdownModel[]>;
    savedSDMs: any;
    apporvalDatetime: any;
    birthMatchNotificationDt!: string;
    //userOverrideOnImmediate:boolean;
    sdmSettings: {
        issexualabuse: boolean;
        islabortrafficking: boolean;
        isoutofhome: boolean;
        isdeathorserious: boolean;
        issignordiagonises: boolean;
        isPopulate: boolean;
        isDisableOverride: boolean;
        isSupervisor: boolean;
        isDisablescrnin: boolean;
        isDisablescrnout: boolean;
    };
    pathwayChange = false;
    pathwaySdm: any = new SdmData();
    initialScreenInMessage!: string;
    selectedProvider: any = [];
    providersList: any[] = [];
    childFatality = 'no';
    involvedPersonList: any= [];
    quickCardPersonList: any = [];
    isIRFlag!: boolean;
    childunderoneyear!: boolean;
    isSENFlag= false;
    truePropertyPAFlag = false;
    truePropertyGNFlag = false;
    CPSFlag!: string;
    isAcptNonCPS!: boolean;
    isClosed = false;
    updatingImmediates!: boolean;
    userOverrodeImmediateList!: boolean;
    noImmediateList: any = {};
    isServiceCase = false;
    reasonForChangePathway: any = [];
    subReasonForChangePathway: any = [];
    moduleview: any;
    birthMatchFound: boolean = false;  
    sencheckbox: boolean = false; 
    activeModule:any;
    noimmediate = 'No Immediate';
    dtformat = 'MM/DD/YYYY';
    traffickinglist :any[]=[];
    sdmtraffickingauditlist:  any[]=[];
    maltreatmentauditlist: any[]=[];
    savebuttonenable!: boolean;
    disabletrafficking: boolean =false;
    hidesavebutton: boolean =false;
    isReadonly!: boolean;
    servicerequestnumber: any;
    disableprovidermaltreatmentedit!: boolean;
    paginationInfo: PaginationInfo = new PaginationInfo();
    total!: number;
    caseType: string = '';
    childfatalityauditlist: any[] = [];
    isSaveEnable: boolean = false;
    pageInfo: PaginationInfo[] = new Array(10).fill(new PaginationInfo());
    isProcessing: boolean = false;


   
        private route: ActivatedRoute;
        private formBuilder: FormBuilder;
        public _authService: AuthService;
        private _commonHttpService: CommonHttpService;
        private router: Router;
        private _alertService: AlertService;
        private dataStoreService: DataStoreService;
        private _session: SessionStorageService;
        private _commonDropDownsService: CommonDropdownsService;
        private _reportSummaryService: GenericService<ReportSummary>;
    iscaseexpunged: any;

        constructor(private injector : Injector,private sdmResolverService: SDMResolverService) 
    {
        this.route= this.injector.get<ActivatedRoute>(ActivatedRoute);
            this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
            this._authService = this.injector.get<AuthService>(AuthService);
            this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
            this.router = this.injector.get<Router>(Router);
            this._alertService = this.injector.get<AlertService>(AlertService);
            this.dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
            this._session = this.injector.get<SessionStorageService>(SessionStorageService);
            this._commonDropDownsService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
            this._reportSummaryService = this.injector.get<GenericService<ReportSummary>>(GenericService);

        // this.route.data.subscribe(data => {
        //     if (data && data.hasOwnProperty('result')) {
        //         this._authService.setAuthDetail('sdm', data.result);
        //     }
        // });
        this.id = this.dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.sdmSettings = {
            issexualabuse: false,
            islabortrafficking: false,
            isoutofhome: false,
            isdeathorserious: false,
            issignordiagonises: false,
            isPopulate: false,
            isDisableOverride: false,
            isSupervisor: false,
            isDisablescrnin: false,
            isDisablescrnout: false,
        };
    }

    ngOnInit() {
        this.iscaseexpunged = this.dataStoreService.getData('iscaseexpunged');
        this.sdmResolverService.getsdm().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('sdm', data);
            }
        })
        this.paginationInfo.pageNumber = 1;
        this.userOverrodeImmediateList = false;
        this.activeModule = this._session.getItem('activeModuleNav');
        this.updatingImmediates = false;
        this.isReadonly =this._authService.readonlyButton('read_only_access','caseworker-sdm-change-pathway');
        this.traffickinglist =[
            {
            "value" : "ST",
            "description": "Sex Trafficking"   
            },
            {
                "value" : "LT",
                "description": "Labor Trafficking"   
                }
        ]
        this.moduleview = this._authService.isModuleAccessable('sdm', 'sdm');
        this.CPSFlag = this.dataStoreService.getData('CPSFlag');
        this.roleId = this._authService.getCurrentUser();
        this.apporvalDatetime = this.dataStoreService.getData('dsdsActionsSummary').da_insertedon; // get case approval datetime
        this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this.buildFormGroup();
        this.setsearchprovider();
        this.getPage();


        this.getInvolvedPerson();
        this.getquickperson();
        this.decideScreenInMessage();

        const da_status = this._session.getItem('da_status');
        if (da_status) {
        if (da_status === 'Closed' || da_status === 'Completed') {
            this.isClosed = true;
        } else {
            this.isClosed = false;
        }
        }
        this._authService.readonlyPage('read_only_access', 'sdm-edit-mode',
        [this.sdmFormGroup ]);
    }
    // Assosiated with ngOnInit methos
private handleSavedSDMsDataFn(data: any) {
            if (data && data.length > 0) {
                if (this.isServiceCase) {
                    if (data[0].getservicecasesdm) {
                        this.savedSDMs = this.setVersion(data[0].getservicecasesdm);
                        if (data[0].getservicecasesdm.length > 0 && data[0].getservicecasesdm[0].servicerequestnumber) {
                            this.servicerequestnumber = data[0].getservicecasesdm[0].servicerequestnumber;
                        }
                    }
                } else if (data[0].getintakeservicerequestsdm) {
                    this.savedSDMs = this.setVersion(data[0].getintakeservicerequestsdm);
                }
            }
    }

    setSubscribers() {
        this.sdmFormGroup.valueChanges.subscribe(() => {
            this.isAcptNonCPS = false;
            this.sdm = Object.assign({}, this.sdmFormGroup.value);
            this.disableSettings();
            this.sdmFormGroup.patchValue({ isfinalscreenin: 'true' }, { emitEvent: false });
            if (this.sdmFormGroup.controls['scnRecommendOveride'].value === 'OvrScrnout') {
                this.sdmFormGroup.patchValue({ isfinalscreenin: 'false' }, { emitEvent: false });
                this.sdmFormGroup.controls['scnRecommendOveride'].patchValue('OvrScrnout');
            }
            
            if (!this.sdmSettings.isPopulate) {
                this.cpsResponseValidation(this.sdmFormGroup.value);
            }

            if (this.sdmFormGroup.get('isfinalscreenin')?.value === 'true') {
                this.sdmFormGroup.patchValue({ screeningRecommend: 'Scrnin' }, { emitEvent: false });
            } else {
                this.sdmFormGroup.patchValue({ screeningRecommend: 'ScreenOUT' }, { emitEvent: false });
            }
            if (this.sdm.immediate && this.sdm.immediate === this.noimmediate && !this.updatingImmediates
            && !this.userOverrodeImmediateList && this.sdmFormGroup.get('noImmediateList')?.dirty){
                if (this.sdm.noImmediateList && ObjectUtils.checkTrueProperty(this.sdm.noImmediateList)){
                        this.userOverrodeImmediateList = ObjectUtils.checkTrueProperty(this.sdm.noImmediateList) !== ObjectUtils.checkTrueProperty(this.noImmediateList)
                    }
                if(this.userOverrodeImmediateList){
                    this.sdmFormGroup.controls['noImmediateList'].patchValue(this.sdm.noImmediateList);
                }
                else{
                    this.setCPSImmediates();}
            }

            this.validateIRAR(this.sdmFormGroup.value);

            setTimeout(() => {
                if (this.sdmFormGroup.controls['isfinalscreenin'].value === 'true') {
                    this.sdmFormGroup.controls['immediate'].setValidators([Validators.required]);
                    this.sdmFormGroup.controls['immediate'].updateValueAndValidity();
                } else {
                    this.sdmFormGroup.controls['immediate'].clearValidators();
                    this.sdmFormGroup.controls['immediate'].updateValueAndValidity();
                }
            }, 2000);
        });
    }

    disableSettings() {
        const screeningRecommendVal = this.sdmFormGroup.get('screeningRecommend')?.value;

        if (screeningRecommendVal === 'ScreenOUT') {
            this.sdmSettings.isDisablescrnin = false;
            this.sdmSettings.isDisablescrnout = true;
        } else if (screeningRecommendVal === 'Scrnin') {
            this.sdmSettings.isDisablescrnin = true;
            this.sdmSettings.isDisablescrnout = false;
        } else if (screeningRecommendVal === 'accept_as_noncps') {
            this.sdmSettings.isDisablescrnin = false;
            this.sdmSettings.isDisablescrnout = false;
        }
    }

    setVersion(savedSDMs: any) {
        let isActiveStatusExist = true;
        const newSDMs = [];
        for (let index = 0; index < savedSDMs.length; index++) {
            const element = savedSDMs[index];
            const suffix = this.getSuffix(element);

            element.version = this.getVersion(element, suffix, index);
            element.isUpdatePathway = this.getPathway(element);

            if (isActiveStatusExist && element.pathwaystatus === 'Accepted') {
                element.version = 'Current Version';
                isActiveStatusExist = false;
                if (this.isUpdatePathway === false) {
                    element.isUpdatePathway = true;
                }
            }
            // CDM-26334 : Remove the condition to restrict to display Change pathway if SEN child is added
            // element.isUpdatePathway = (isSenb) ? false : element.isUpdatePathway;

            newSDMs.push(element);
        }
        return newSDMs;
    }

    getSuffix(element: any){
        return element.isar ? 'AR' : this.checkisIR(element);
    }

    checkisIR(element: { isir: any; }){
        return element.isir ? 'IR' : '';
    }
    getVersion(element: any, suffix: string, index: number) {
        let version = 'Previous Version - ' + suffix;
        element.isUpdatePathway = false;
        if (index === 0 && (element.pathwaystatus === 'Review' || element.pathwaystatus === 'Rejected')) {
            version = 'New Version - ' + suffix;
        }
        return version;
    }
    getPathway(element: { pathwaystatus: string; }) {
        let pathway = false;
        if (element.pathwaystatus === 'Review') {
            pathway = true;
            this.isUpdatePathway = true;
        }
        return pathway;
    }
    // End - D-06631 - Defect Fix

    buildFormGroup() {
        this.sdmFormGroup = this.formBuilder.group({
            referralname: [''],
            referraldob: [new Date()],
            referralid: [''],
            countyid: [null],
            county: [''],
            // allegedvictim: this.formBuilder.array([this.createFormGroup('allegedvictim')]),
            // allegedmaltreator: this.formBuilder.array([this.createFormGroup('allegedmaltreator')]),
            // provider: this.formBuilder.array([]),
            ismaltreatment: [false],
            maltreatment: [null],
            providerKnown: [null],
            childfatality: ['no'],
            ischildfatality: [false],
            confirmtrafficking: [null,Validators.required],
            selecttrafficking:[null],
            traffickingupdated:[null],
            maltreatmentupdated:[null],
            objectid:this.dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER),
            objecttype: this.isServiceCase ? 'servicecase' : 'CPS Case',
            intakeservicerequestsdmid :null,
            isfcplacementsetting: [false],
            isprivateplacement: [false],
            islicenseddaycare: [false],
            isfclivingarrangement: [false],
            isschool: [false],
            physicalAbuse: this.formBuilder.group({
                ismalpa_suspeciousdeath: [false],
                ismalpa_nonaccident: [false],
                ismalpa_injuryinconsistent: [false],
                ismalpa_insjury: [false],
                ismalpa_childtoxic: [false],
                ismalpa_caregiver: [false],
                ismalpa_labortrafficking: [false]
            }),
            sexualAbuse: this.formBuilder.group({
                ismalsa_sexualmolestation: [false],
                ismalsa_sexualact: [false],
                ismalsa_sexualexploitation: [false],
                ismalsa_physicalindicators: [false],
                ismalsa_sex_trafficking: [false]
            }),
            generalNeglect: this.formBuilder.group({
                isneggn_suspiciousdeath: [false],
                isneggn_signsordiagnosis: [false],
                isneggn_inadequatefood: [false],
                isneggn_childdischarged: [false]
            }),
            arGeneralNeglect: this.formBuilder.group({
                isneggn_exposuretounsafe: [false],
                isneggn_inadequateclothing: [false],
                isneggn_inadequatesupervision: [false],
                isnegrh_treatmenthealthrisk: [false]
            }),
            isnegfp_cargiverintervene: [false],
            isnegab_abandoned: [false],
            unattendedChild: this.formBuilder.group({
                isneguc_leftunsupervised: [false],
                isneguc_leftaloneinappropriatecare: [false],
                isneguc_leftalonewithoutsupport: [false]
            }),
            riskofHarm: this.formBuilder.group({
                isnegrh_priordeath: [false],
                isnegrh_exposednewborn: [{value: false, disabled: true}],
                // isnegrh_domesticviolence: [false],
                // isnegrh_sexualperpetrator: [false],
                isnegrh_basicneedsunmet: [false],
                // isnegrh_substantial_risk: [false],
                isnegrh_sex_offender: [false],
                isnegrh_risk_dv: [false],
                isnegrh_fatality_can: [false],
                isnegrh_indicated_unsub: [false],
                isnegrh_survivor: [false],
                isnegrh_birth_match: [false],
                isnegrh_sex_trafficking: [false]

            }),
            isnegmn_unreasonabledelay: [false],
            ismenab_psycologicalability: [false],
            ismenng_psycologicalability: [false],
            screeningRecommend: [''],
            scnRecommendOveride: [''],
            screenOut: this.formBuilder.group({
                isscrnoutrecovr_insufficient: [false],
                isscrnoutrecovr_information: [false],
                isscrnoutrecovr_historicalinformation: [false],
                isscrnoutrecovr_otherspecify: [false],
                duplicatereportflag: [false],
                scrnout_description: ['']
            }),
            screenIn: this.formBuilder.group({
                isscrninrecovr_courtorder: [false],
                isscrninrecovr_otherspecify: [false],
                scrnin_description: ['']
            }),
            immediate: [''],
            immediateList: this.formBuilder.group({
                isimmed_childfaatility: [false],
                isimmed_seriousinjury: [false],
                isimmed_childleftalone: [false],
                isimmed_allegation: [false],
                isimmed_otherspecify: [false],
                immediateList6: ['']
            }),
            noImmediateList: this.formBuilder.group({
                isnoimmed_physicalabuse: [false],
                isnoimmed_sexualabuse: [false],
                isnoimmed_neglectresponse: [false],
                isnoimmed_mentalinjury: [false],
                isnoimmed_substantial_risk: [false],
                isnoimmed_screeninoverride: [false],
                isnoimmed_risk_harm: [false]

            }),
            childunderoneyear: [''],
            childUnderOneYear: [''],
            officerfirstname: [''],
            officermiddlename: [''],
            officerlastname: [''],
            badgenumber: [''],
            recordnumber: [''],
            reportdate: [null],
            worker: [''],
            comments: [''],
            reasonforchange:[''],
            subreasonforchange:[''],
            workerdate: [null],
            supervisor: [''],
            supervisordate: [null],
            disqualifyingCriteria: this.formBuilder.group({
                issexualabuse: [false],
                islabortrafficking: [false],
                isoutofhome: [false],
                isdeathorserious: [false],
                isrisk: [false],
                isreportmeets: [false],
                issignordiagonises: [false],
                ismaltreatment3yrs: [false],
                ismaltreatment12yrs: [false],
                ismaltreatment24yrs: [false],
                isactiveinvestigation: [false]
            }),
            disqualifyingFactors: this.formBuilder.group({
                isreportedhistory: [false],
                ismultiple: [false],
                isdomesticvoilence: [false],
                iscriminalhistory: [false],
                isthread: [false],
                islawenforcement: [false],
                iscourtiinvestigation: [false]
            }),
            cpsResponseType: [null],
            isar: [true],
            isir: [false],
            isfinalscreenin: [null],
            //1080 refinement
            isseriousphysicalinjury: [null]
        });
        this.sdmFormGroup.addControl('allegedvictim', this.formBuilder.array([this.createFormGroup('allegedvictim')]));
        this.sdmFormGroup.addControl('allegedmaltreator', this.formBuilder.array([this.createFormGroup('allegedmaltreator')]));
        this.sdmFormGroup.addControl('provider', this.formBuilder.array([]));
    }

    updateSubstantialRisk() {
        if ((this.involvedPersonList && this.involvedPersonList.length) || (this.quickCardPersonList && this.quickCardPersonList.length)) {
            if (this.sdmFormGroup.get('riskofHarm')) {
                if (this.sdmFormGroup.get('riskofHarm')?.get('isnegrh_exposednewborn')){
                  this.sdmFormGroup.get('riskofHarm')?.get('isnegrh_exposednewborn')?.disable();
                }
            }
            this.isSENFlag = false;
             const hasSubstantialRiskPerson = this.involvedPersonList?.find((person: { drugexposednewbornflag: number; fetalalcoholspctrmdisordflag: number; }) => (person.drugexposednewbornflag === 1 || person.fetalalcoholspctrmdisordflag === 1 ));
             const quickCardRiskPerson = this.quickCardPersonList?.find((person: { quickpersonsubstconfig: any; }) => !!person?.quickpersonsubstconfig  );
             
             if (hasSubstantialRiskPerson || quickCardRiskPerson) {
                this.isSENFlag = true;
                this.setImmediates();
            }
        }
    }

    setFormValues() {
        const control = <FormArray>this.sdmFormGroup.controls.allegedvictim;
        if (this.allegedVictim) {
            this.allegedVictim.forEach((x) => {
                control.push(this.buildAllegedVictimForm(x));
            });
        }

        const allegedMaltreatorControl = <FormArray>this.sdmFormGroup.controls.allegedmaltreator;
        if (this.allegedMaltreator) {
            this.allegedMaltreator.forEach((x) => {
                allegedMaltreatorControl.push(this.buildAllegedMaltreatorForm(x));
            });
        }

        const providerControl = <FormArray>this.sdmFormGroup.controls.provider;
        if (this.provider) {
            this.provider.forEach((x) => {
                const isProviderExist = providerControl.controls.find(item => item.get('providername')?.value === x.providername);
                if(!isProviderExist){
                    providerControl.push(this.buildProviderForm(x));
                }
            });
        }
    }

    getPage() {
        // Both endpoints filter on a uuid column, so an unresolved this.id reaches
        // Postgres as 22P02 invalid input syntax for type uuid and the api flattens
        // that into a bare 400. ngOnInit calls this before anything has confirmed
        // CASE_UID holds a real case id, and there are no saved SDMs to list for a
        // case that does not exist yet.
        if (!isCaseUuid(this.id)) {
            return;
        }
        let sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmvaluesUrl;
        let requestParam ;
        if (this.isServiceCase) {
            sdmUrl = 'servicecase/getservicecasesdm';
            requestParam = {
                servicecaseid : this.id
            };
        } else {
            const isExpungementSuperUser = this._authService.isExpungementSuperUser();
            requestParam = {
                servicerequestid: this.id,
                isExpungementSuperUser:isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        }
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: requestParam,
                },
                sdmUrl + '?filter'
            )
            .subscribe((res) => {
                if (res && Array.isArray(res) && res.length) {
                this.handleSavedSDMsDataFn(res);
                    this.checkSDM(res);
                } else {
                    if (this.isServiceCase) {
                    this.sdmFormGroup.disable();
                    }
                }

                const caseid = this.getCaseId();
                 if (caseid) {
                     this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + caseid)
                         .subscribe((result: any) => {
                             if (result) {
                                 const purpose = result?.intakeservicerequesttype?.description;
                                 if(purpose === 'Child Protective Services' && this.isServiceCase) {
                                    this.sdmFormGroup.get('confirmtrafficking')?.enable();
                                    this.sdmFormGroup.get('selecttrafficking')?.enable();
                                 }
                                 if(['ROA-CPS', MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL, MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES].includes(purpose)) {
                                     this.sdmFormGroup.disable();
                                     this.sdmFormGroup.get('childfatality')?.enable();
                                     const childs = this.involvedPersonList.filter((person: any) => {
                                        if (person?.roles?.length>0) {
                                            return person?.roles?.some((role: any) => ['CHILD', 'RC', 'OTHERCHILD'].includes(role?.intakeservicerequestpersontypekey));
                                        } else {
                                            return false;
                                        }
                                    });
                                     if(childs?.length>0) {
                                        childs?.forEach((e: any) => {
                                            if(e?.dateofdeath) {
                                                this.sdmFormGroup.patchValue({ childfatality: 'yes' });
                                                this.sdmFormGroup.get('childfatality')?.disable();
                                            }
                                        });
                                     }
                                     this.sdmFormGroup.get('confirmtrafficking')?.enable();
                                     this.sdmFormGroup.get('selecttrafficking')?.enable();
                                     if((res?.length>0) && (res[0]?.getservicecasesdm?.length>0) && (res[0]?.getservicecasesdm[0]?.selecttrafficking)) { 
                                         let v_selecttrafficking = [];
                                         try {
                                              if(JSON.parse(res[0]?.getservicecasesdm[0]?.selecttrafficking)) {
                                                v_selecttrafficking = JSON.parse(res[0]?.getservicecasesdm[0]?.selecttrafficking);
                                              } else if(res[0]?.getservicecasesdm[0]?.selecttrafficking?.split(',')) {
                                                v_selecttrafficking = res[0]?.getservicecasesdm[0]?.selecttrafficking?.split(',');
                                              }
                                            } catch (error) {
                                                v_selecttrafficking = res[0]?.getservicecasesdm[0]?.selecttrafficking?.split(',');
                                            }
                                            if(v_selecttrafficking?.length>0) {
                                                this.sdmFormGroup.patchValue({ selecttrafficking: v_selecttrafficking});
                                            }

                                     }
                                     this.sdmFormGroup.patchValue({ maltreatment: 'no' });
                                     this.isSaveEnable = true;
                                 }
                             }
                         });
                 }
            });
    }
    checkSDM(res: any){
        let sdm;
        if (this.isServiceCase) {
            const i = res[0].getservicecasesdm.findIndex((x: { pathwaystatus: string; }) => x.pathwaystatus === 'Accepted')
            sdm = res[0].getservicecasesdm[i];
        } else {
            const i = res[0].getintakeservicerequestsdm.findIndex((x: { pathwaystatus: string; }) => x.pathwaystatus === 'Accepted')
            sdm = res[0].getintakeservicerequestsdm[i];
        }
        if (sdm) {
            this.patchSDM(sdm, false);
            this.sencheckbox = true;
        }
    }

    patchSDM(sdm: any, changePathway: boolean) {
        this.sdmSettings.isPopulate = true;
        this.populateSdm = Object.assign({}, sdm);

        /* Patch start */
        this.getPlacements(sdm);
        
        this.populateSdm.physicalAbuse = Object.assign({
            ismalpa_suspeciousdeath: sdm.ismalpa_suspeciousdeath,
            ismalpa_nonaccident: sdm.ismalpa_nonaccident,
            ismalpa_injuryinconsistent: sdm.ismalpa_injuryinconsistent,
            ismalpa_insjury: sdm.ismalpa_insjury,
            ismalpa_childtoxic: sdm.ismalpa_childtoxic,
            ismalpa_caregiver: sdm.ismalpa_caregiver,
            ismalpa_labortrafficking: sdm.ismalpa_labortrafficking
        });
        this.populateSdm.sexualAbuse = Object.assign({
            ismalsa_sexualmolestation: sdm.ismalsa_sexualmolestation,
            ismalsa_sexualact: sdm.ismalsa_sexualact,
            ismalsa_sexualexploitation: sdm.ismalsa_sexualexploitation,
            ismalsa_physicalindicators: sdm.ismalsa_physicalindicators,
            ismalsa_sex_trafficking: sdm.ismalsa_sex_trafficking
        });
        this.populateSdm.generalNeglect = Object.assign({
            isneggn_suspiciousdeath: sdm.isneggn_suspiciousdeath,
            isneggn_signsordiagnosis: sdm.isneggn_signsordiagnosis,
            isneggn_inadequatefood: sdm.isneggn_inadequatefood,
            isneggn_childdischarged: sdm.isneggn_childdischarged
        });
        this.populateSdm.arGeneralNeglect = Object.assign({
            isneggn_exposuretounsafe: sdm.isneggn_exposuretounsafe,
            isneggn_inadequateclothing: sdm.isneggn_inadequateclothing,
            isneggn_inadequatesupervision: sdm.isneggn_inadequatesupervision,
            isnegrh_treatmenthealthrisk: sdm.isnegrh_treatmenthealthrisk
        });
        this.populateSdm.unattendedChild = Object.assign({
            isneguc_leftunsupervised: sdm.isneguc_leftunsupervised,
            isneguc_leftaloneinappropriatecare: sdm.isneguc_leftaloneinappropriatecare,
            isneguc_leftalonewithoutsupport: sdm.isneguc_leftalonewithoutsupport
        });
        this.populateSdm.riskofHarm = Object.assign({
            isnegrh_priordeath: sdm.isnegrh_priordeath,
            isnegrh_exposednewborn: sdm.drugexposednewbornflag == 1 ? true : false,
            isnegrh_basicneedsunmet: sdm.isnegrh_basicneedsunmet,
            isnegrh_sex_offender: sdm.isnegrh_sex_offender,
            isnegrh_risk_dv: sdm.isnegrh_risk_dv,
            isnegrh_sex_trafficking: sdm.isnegrh_sex_trafficking,
            isnegrh_fatality_can: sdm.isnegrh_fatality_can,
            isnegrh_indicated_unsub: sdm.isnegrh_indicated_unsub,
            isnegrh_survivor: sdm.isnegrh_survivor,
            isnegrh_birth_match: sdm.isnegrh_birth_match
        });
        this.populateSdm.screenOut = Object.assign({
            isscrnoutrecovr_insufficient: sdm.isscrnoutrecovr_insufficient,
            isscrnoutrecovr_information: sdm.isscrnoutrecovr_information,
            isscrnoutrecovr_historicalinformation: sdm.isscrnoutrecovr_historicalinformation,
            isscrnoutrecovr_otherspecify: sdm.isscrnoutrecovr_otherspecify,
            duplicatereportflag: sdm.duplicatereportflag,
            scrnout_description: sdm.scrnout_description
        });
        this.populateSdm.screenIn = Object.assign({
            isscrninrecovr_courtorder: sdm.isscrninrecovr_courtorder,
            isscrninrecovr_otherspecify: sdm.isscrninrecovr_otherspecify,
            scrnin_description: sdm.scrnin_description
        });
        this.populateSDMData1(sdm);
        this.changeImmediate(this.populateSdm.immediate);

        this.populateSdm.immediateList = Object.assign({
            isimmed_childfaatility: sdm.isimmed_childfaatility,
            isimmed_seriousinjury: sdm.isimmed_seriousinjury,
            isimmed_childleftalone: sdm.isimmed_childleftalone,
            isimmed_allegation: sdm.isimmed_allegation,
            isimmed_otherspecify: sdm.isimmed_otherspecify,
            immediateList6: sdm.immediateList6
        });
        this.populateSdm.noImmediateList = Object.assign({
            isnoimmed_physicalabuse: sdm.isnoimmed_physicalabuse,
            isnoimmed_sexualabuse: sdm.isnoimmed_sexualabuse,
            isnoimmed_neglectresponse: sdm.isnoimmed_neglectresponse,
            isnoimmed_mentalinjury: sdm.isnoimmed_mentalinjury,
            isnoimmed_substantial_risk: (sdm.drugexposednewbornflag === 1) ? true : false,
            isnoimmed_screeninoverride: sdm.isnoimmed_screeninoverride,
            isnoimmed_risk_harm: sdm.isnoimmed_risk_harm,
        });
        this.populateSdm.disqualifyingCriteria = Object.assign({
            issexualabuse: sdm.issexualabuse,
            islabortrafficking: sdm.islabortrafficking,
            isoutofhome: sdm.isoutofhome,
            isdeathorserious: sdm.isdeathorserious,
            isrisk: sdm.isrisk,
            isreportmeets: sdm.isreportmeets,
            issignordiagonises: sdm.issignordiagonises,
            ismaltreatment3yrs: sdm.ismaltreatment3yrs,
            ismaltreatment12yrs: sdm.ismaltreatment12yrs,
            ismaltreatment24yrs: sdm.ismaltreatment24yrs,
            isactiveinvestigation: sdm.isactiveinvestigation
        });
        this.populateSdm.disqualifyingFactors = Object.assign({
            isreportedhistory: sdm.isreportedhistory,
            ismultiple: sdm.ismultiple,
            isdomesticvoilence: sdm.isdomesticvoilence,
            iscriminalhistory: sdm.iscriminalhistory,
            isthread: sdm.isthread,
            islawenforcement: sdm.islawenforcement,
            iscourtiinvestigation: sdm.iscourtiinvestigation
        });

        this.populateSDMData2(sdm);

        this.populateSdm.county = sdm.countyid;

        //1080 refinement
        this.populateSdm.isseriousphysicalinjury = sdm.isseriousphysicalinjury;

        /* Patch end */

        this.populateSdm.referraldob = new Date(this.populateSdm.referraldob);
        this.populateSdm.reportdate = this.populateSdm.reportdate ? new Date(this.populateSdm.reportdate) : null;

        this.provider = this.populateSdm.provider;
        const sdmtrafficking = this.populateSdm.selecttrafficking ? this.populateSdm.selecttrafficking.split(",") :'';
        this.populateSdm.selecttrafficking =null;
        this.sdmFormGroup.patchValue(this.populateSdm);
        this.sdmFormGroup.patchValue({
            selecttrafficking :sdmtrafficking
        })
        this.sdmFormGroup.get('comments')?.reset();
        this.patchChildFatalityFn(sdm);
        this.checkIfProviderFn();
        this.populateNoImmediateListAuto();
        const control = this.sdmFormGroup.controls['screenOut'] as FormGroup;
        control.controls['duplicatereportflag'].patchValue(this.populateSdm.duplicatereportflag === 1);
        if (sdm.isfinalscreenin === true) {
            this.populateSdm.isfinalscreenin = true;
            this.sdmFormGroup.patchValue({ isfinalscreenin: 'true' }, { emitEvent: false });
        } else if (sdm.isfinalscreenin === false) {
            this.populateSdm.isfinalscreenin = false;
            this.sdmFormGroup.patchValue({ isfinalscreenin: 'false' }, { emitEvent: false });
        }
        if (this.sdmFormGroup.get('screeningRecommend')?.value === 'accept_as_noncps') {
            this.sdmFormGroup.patchValue({ isfinalscreenin: 'Ovr_as_noncps' }, { emitEvent: false });
        }

        this.isScreenOutIN = this.sdmFormGroup.value.scnRecommendOveride;

        if (this.populateSdm.maltreatment === 'yes') {
            this.isDisplayProvider = true;
        }

        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.role.name === 'apcs') {
            this.sdmSettings.isSupervisor = true;
        }

        if (changePathway) {
            this.sdm = sdm;
            this.sdmFormGroup.enable();
            this.sdmSettings.isPopulate = false;
        } else {
            if(this.disabletrafficking){
                this.sdmFormGroup.disable();
                this.hidesavebutton = true;
            }
            else {
                this.sdmFormGroup.enable();
            Object.entries(this.sdmFormGroup.controls)
            .filter(([key, value]) => ['confirmtrafficking', 'selecttrafficking'].indexOf(key) < 0 )
      .forEach(([key,value]) => value.disable());
        }
    }

        this.handleSdmFormGroupDisableFn();
    }
    private patchChildFatalityFn(sdm: any) {
        if (sdm.intakesnapshotdata?.sdm?.childfatality) {
            this.sdmFormGroup.patchValue({
                childfatality: sdm.intakesnapshotdata?.sdm?.childfatality
            });
        } 
        if (sdm.ischildfatality || !sdm.ischildfatality) {
            this.sdmFormGroup.patchValue({
                childfatality: sdm.ischildfatality === true ? 'yes' : 'no'
            });
            this.childFatality = sdm.ischildfatality === true ? 'yes' : 'no';
        } else {
            this.sdmFormGroup.patchValue({
                childfatality: ''
            });
        }
    }
    private handleSdmFormGroupDisableFn() {
        this.disableCaseWorker = true;
        if (this.isServiceCase) {
            this.sdmFormGroup.disable();
        }
    }

    // Assisociated with patchSDM function
    private checkIfProviderFn() {
        if (this.provider && this.provider.length) {
            const providerControl = <FormArray>this.sdmFormGroup.controls.provider;
            providerControl.clear();
            if (this.provider) {
                this.provider.forEach((x1) => {
                    const isProviderExist = providerControl.controls.find((item: any) => item.get('providername').value === x1.providername);
                    if (!isProviderExist) {
                        providerControl.push(this.buildProviderForm(x1));
                    }
                });
            }
        }
    }

    getPlacements(sdm: any) {
        if (sdm.intakesnapshotdata && sdm.intakesnapshotdata.persondetails && sdm.intakesnapshotdata.persondetails.Person && sdm.intakesnapshotdata.persondetails.Person.length) {
            this.intakeSDM = sdm.intakesnapshotdata.sdm;
            // CIDM-8496
            this.getChildPlacements(sdm);
            this.patchLivingArrangement();
        }
    }
    getChildPlacements(sdm: any){
        if (sdm.intakesnapshotdata.persondetails.Person && sdm.intakesnapshotdata.persondetails.Person.length) {
            sdm.intakesnapshotdata.persondetails.Person.forEach((element: any) => {
                if (element.personRole && element.personRole.length) {
                    element.personRole.forEach((key: { rolekey: string; }) => {
                        if (key.rolekey == 'CHILD') {
                            this.getPlacementDetails(element.Pid);
                        }
                    });
                }
            });
        }
    }
    patchLivingArrangement(){
        if (this.intakeSDM.isfclivingarrangement) {
            this.isLivingArrangement = true;
            this.sdmFormGroup.patchValue({
                isfclivingarrangement: true,
            });
        }
        if (this.intakeSDM.linkschidresid) {
            this.showcheckbox = true;
        }
    }
    populateSDMData1(sdm: any){
        this.allegedVictim = [];
        if (sdm.isfclivingarrangement) {
            this.isLivingArrangement = true;
         }
         if (sdm.isprivateplacement || sdm.isfcplacementsetting) {
             this.isProviderDetails = true;
         }
         if (sdm.provider && this.intakeSDM.provider) {
             this.populateSdm.provider = this.intakeSDM.provider;
         }
         if (sdm.allegedvictim && sdm.allegedvictim.length) {
            sdm?.allegedvictim?.forEach((e: { victimname: any; }) => {
                const _victimname = { victimname: e?.victimname };
                if(!this?.allegedVictim?.includes(_victimname)){
                    this.allegedVictim.push(_victimname);
                }
            });
         } 
         if(sdm.linkschidresid) {
             this.showcheckbox = true;
         }
         this.checkSdmConditionFn(sdm);
    }
    // Assosiated with populateSDMData1 method
    private checkSdmConditionFn(sdm: any) {
        if (sdm.isnoimmed_substantial_risk) {
            this.populateSdm.immediate = this.noimmediate;
        } else if (sdm.isnoimmed_physicalabuse || sdm.isnoimmed_sexualabuse || sdm.isnoimmed_neglectresponse || sdm.isnoimmed_mentalinjury || sdm.isnoimmed_risk_harm) {
            this.populateSdm.immediate = this.noimmediate;
        } else if (sdm.isimmed_childfaatility || sdm.isimmed_seriousinjury || sdm.isimmed_childleftalone || sdm.isimmed_allegation || sdm.isimmed_otherspecify) {
            this.populateSdm.immediate = 'Immediate';
        } else {
            this.populateSdm.immediate = '';
        }
    }

    populateSDMData2(sdm: any){
        if (sdm.ismaltreatment) {
            this.populateSdm.maltreatment = 'yes';
        } else if (sdm.ismaltreatment === null || sdm.ismaltreatment === '') {
            this.populateSdm.maltreatment = '';
        } else {
            this.populateSdm.maltreatment = 'no';
        }

        if (sdm.isrecsc_screenout) {
            this.populateSdm.screeningRecommend = 'ScreenOUT';
        } else if (sdm.isrecsc_scrrenin) {
            this.populateSdm.screeningRecommend = 'Scrnin';
        }

        if (sdm.isir) {
            this.populateSdm.cpsResponseType = 'CPS-IR';
        } else if (sdm.isar) {
            this.populateSdm.cpsResponseType = 'CPS-AR';
        } else {
            this.populateSdm.screeningRecommend = 'accept_as_noncps';
        }

        this.populateSdm.isnegfp_cargiverintervene = sdm.isnegfp_cargiverintervene;
        this.populateSdm.isnegab_abandoned = sdm.isnegab_abandoned;

        if (sdm.isscrnoutrecovr_insufficient || sdm.isscrnoutrecovr_information || sdm.isscrnoutrecovr_historicalinformation || sdm.isscrnoutrecovr_otherspecify || sdm.duplicatereportflag) {
            this.scnRecommendOveride = 'OvrScrnout';
            this.populateSdm.scnRecommendOveride = 'OvrScrnout';
        } else if (sdm.isscrninrecovr_courtorder || sdm.isscrninrecovr_otherspecify) {
            this.scnRecommendOveride = 'Ovrscrnin';
        } else {
            this.scnRecommendOveride = '';
        }
    }
    private populateNoImmediateListAuto(){
        this.noImmediateList = {};
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.sexualAbuse) ?? 0) >= 1) { // Sexual Abuse - any selection
            this.noImmediateList.isnoimmed_sexualabuse = true;
        } else {
            this.noImmediateList.isnoimmed_sexualabuse = false;
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.physicalAbuse) ?? 0) >= 1) { // Physical Abuse
            this.noImmediateList.isnoimmed_physicalabuse = true;
        } else {
            this.noImmediateList.isnoimmed_physicalabuse = false;
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.generalNeglect) ?? 0) >= 1 || (ObjectUtils.checkTrueProperty(this.populateSdm.arGeneralNeglect) ?? 0) >= 1) { // General Neglect
            this.noImmediateList.isnoimmed_neglectresponse = true;
        } else {
            this.noImmediateList.isnoimmed_neglectresponse = false;          
        }
        if (this.populateSdm.ismenab_psycologicalability === true || this.populateSdm.ismenng_psycologicalability === true) { // Mental Abuse or Neglect
            this.noImmediateList.isnoimmed_mentalinjury = true;          
        } else {
            this.noImmediateList.isnoimmed_mentalinjury = false;                     
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.riskofHarm) ?? 0) >= 1) { // Risk of Harm            
            this.noImmediateList.isnoimmed_risk_harm = true;
        } else {
            this.noImmediateList.isnoimmed_risk_harm = false;
        }
        if (this.isSENFlag === true) {
            this.isImmediate = this.noimmediate;
        }
    }

    switchPathway(sdmData: any, changePathway: any) {
        this.pathwayChange = changePathway;
        if (this.pathwayChange === true) {
            this.setSubscribers();
            this.disableprovidermaltreatmentedit  = true;
        }
        if(sdmData?.version ==='Previous Version - AR' || sdmData?.version ==='Previous Version - IR' || (sdmData?.version === 'Current Version' && !sdmData?.isUpdatePathway )){
            this.disabletrafficking = true;
            this.hidesavebutton = true;
        }
        else {
            this.disabletrafficking = false; 
            this.hidesavebutton = false;
        }
        this.sdmFormGroup.get('comments')?.reset()
        this.patchSDM(sdmData, changePathway);
        this.getInvolvedPerson();
        this.getquickperson();
        // (<any>$('#dec-mak-step1')).click();
        this.goToNextPage('dec-mak-step1');
        if(sdmData){
            this._commonDropDownsService.getPickList(10037).subscribe(resp => {
                if(sdmData.isir || this.sdmFormGroup?.get('cpsResponseType')?.value == 'CPS-IR'){
                    this.reasonForChangePathway = resp.filter(item => item.picklist_value_cd === '104');
                }else if(sdmData.isar || this.sdmFormGroup?.get('cpsResponseType')?.value == 'CPS-AR'){
                    this.reasonForChangePathway = resp.filter(item => (item.picklist_value_cd !== '104' && item.picklist_value_cd !== '105'));}
            });}
        this._commonDropDownsService.getPickList(10040).subscribe(resp => {
            this.subReasonForChangePathway = resp;
        })

        if(sdmData?.version === 'Current Version'){
            const caseid = this.getCaseId();
            if (caseid) {
                this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + caseid)
                .subscribe((result: any) => {
                    if (result) {
                        const purpose = result?.intakeservicerequesttype?.description;
                        if((purpose === 'Child Protective Services' && this.isServiceCase) || ['ROA-CPS', MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL, MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES].includes(purpose)) {
                        this.sdmFormGroup.get('confirmtrafficking')?.enable();
                        this.sdmFormGroup.get('selecttrafficking')?.enable();
                        }
                    }
                });
            }
            } 
    }

    testing(){
        //No operation needed here
    }
    savePathway() {
        if (this.isProcessing) {
            return;
        }
        this.isProcessing = true;
        if(this.pathwayChange && !this.sdmFormGroup.value.reasonforchange){
            this._alertService.error('Please add a Reason for Change');
            this.isProcessing = false;
        }
        else if(this.pathwayChange && this.sdmFormGroup.value.reasonforchange && 
            this.sdmFormGroup.value.reasonforchange === '102' && !this.sdmFormGroup.value.subreasonforchange){
            this._alertService.error('Please add a Sub Reason for Change');
            this.isProcessing = false;
        }
        else if(this.returnSavePathwayTraffickingFn()){
                this._alertService.error("Please fill all the required fields");
                this.isProcessing = false;
                return;
    
            }
        else if (this.pathwayChange) {
            let sdm = Object.assign({}, this.sdmFormGroup.getRawValue());
            sdm = Object.assign(sdm, sdm.physicalAbuse);
            sdm = Object.assign(sdm, sdm.sexualAbuse);
            sdm = Object.assign(sdm, sdm.generalNeglect);
            sdm = Object.assign(sdm, sdm.arGeneralNeglect);
            sdm = Object.assign(sdm, sdm.unattendedChild);
            sdm = Object.assign(sdm, sdm.riskofHarm);
            sdm = Object.assign(sdm, sdm.screenOut);
            sdm = Object.assign(sdm, sdm.screenIn);
            sdm = Object.assign(sdm, sdm.immediateList);
            sdm = Object.assign(sdm, sdm.noImmediateList);
            sdm = Object.assign(sdm, sdm.disqualifyingCriteria);
            sdm = Object.assign(sdm, sdm.disqualifyingFactors);
            
            // CIDM-6086: At least one of the maltreatment type to be selected to submit
            const isMaltreatmentSelected = this.returnMaltreatmentSelectedDataFn(sdm);

            if(!isMaltreatmentSelected)
            {
                this._alertService.error('No Maltreatment Type selected. Please select atleast one Maltreatment Type.');
                this.isProcessing = false;
            }
            else
            {
                this.setSDMPathwayAndSave(sdm);
            }
        }
    }
    // Assosiated with savePathway function
    private returnMaltreatmentSelectedDataFn(sdm: any) {
        let isMaltreatmentSelected = false;

        if (sdm?.ismalpa_suspeciousdeath || sdm?.ismalpa_nonaccident || sdm?.ismalpa_injuryinconsistent ||
            sdm?.ismalpa_insjury || sdm?.ismalpa_childtoxic || sdm?.ismalpa_caregiver || sdm?.ismalpa_labortrafficking ||
            sdm?.ismalsa_sexualmolestation || sdm?.ismalsa_sexualact || sdm?.ismalsa_sexualexploitation ||
            sdm?.ismalsa_physicalindicators || sdm?.ismalsa_sex_trafficking ||
            sdm?.isneggn_suspiciousdeath || sdm?.isneggn_signsordiagnosis ||
            sdm?.isneggn_inadequatefood || sdm?.isneggn_childdischarged ||
            sdm?.isneggn_exposuretounsafe ||
            sdm?.isneggn_inadequateclothing || sdm?.isneggn_inadequatesupervision || sdm?.isnegrh_treatmenthealthrisk ||
            sdm?.isneguc_leftunsupervised || sdm?.isneguc_leftaloneinappropriatecare || sdm?.isneguc_leftalonewithoutsupport ||
            sdm?.isnegfp_cargiverintervene || sdm?.isnegab_abandoned || sdm?.isnegmn_unreasonabledelay ||
            sdm?.ismenab_psycologicalability || sdm?.ismenng_psycologicalability ) {
            isMaltreatmentSelected = true;
        }
        return isMaltreatmentSelected;
    }
    // Assosiated with savePathway function
    private returnSavePathwayTraffickingFn() {
        return this.sdmFormGroup.controls['confirmtrafficking'].invalid || this.sdmFormGroup.controls['selecttrafficking'].invalid || this.sdmFormGroup.controls['confirmtrafficking'].value == 'Yes' && this.sdmFormGroup.controls['selecttrafficking']?.value?.length == 0 || this.sdmFormGroup.controls['confirmtrafficking'].value == 'Yes' && this.sdmFormGroup.controls['selecttrafficking'].value[0] == '{}';
    }

    setSDMPathwayAndSave(sdm: any){
        if (sdm.cpsResponseType === 'CPS-IR') {
            sdm.isir = true;
            sdm.isar = false;
        } else if (sdm.cpsResponseType === 'CPS-AR') {
            sdm.isir = false;
            sdm.isar = true;
        } else {
            sdm.isir = false;
            sdm.isar = false;
        }

        if (sdm.maltreatment === 'yes') {
            sdm.ismaltreatment = true;
        } else {
            sdm.ismaltreatment = false;
        }
        if (sdm.childfatality === 'yes') {
            sdm.ischildfatality = true;
        } else {
            sdm.ischildfatality = false;
        }
        
        if(sdm.duplicatereportflag){
            sdm.duplicatereportflag = 1
        }else{
            sdm.duplicatereportflag = 0
        }
        if (sdm.screeningRecommend === 'ScreenOUT') {
            sdm.isrecsc_screenout = true;
            sdm.isrecsc_scrrenin = false;
        } else if (sdm.screeningRecommend === 'Scrnin') {
            sdm.isrecsc_screenout = false;
            sdm.isrecsc_scrrenin = true;
        } else {
            sdm.isrecsc_screenout = false;
            sdm.isrecsc_scrrenin = false;
        }
        this.saveSdmPathway(sdm).pipe(
            mergeMap((value) => {
                this._alertService.success('Sdm pathway changes sent for approval.');
                this.isProcessing = false;
                return this.listSDMHistory();
            }))
            .subscribe((data) => {
                this.savedSDMs = this.setVersion(data[0].getintakeservicerequestsdm);
                this.navigatetopathway('tab-step0')
                this.pathwayChange = false;
            });
    }
    navigatetopathway(tabtogo: string) {
        setTimeout(() => {
            const pageId: any = document.querySelector('#' + tabtogo);
            if (pageId) {
                pageId.click();
                setTimeout(() => {
                    $('html,body').animate({ scrollTop: 0 }, 'slow');
                }, 300);
            }
        }, 100);
    }
    saveSdmPathway(sdm: any) {
        sdm.reportdate = null;
        this.pathwaySdm.sdmdata = Object.assign({}, sdm);
        this.pathwaySdm.intakenumber = null;
        this.pathwaySdm.servicerequestid = this.id;
        return this._commonHttpService.create(this.pathwaySdm, CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.PathwaySdmCreateUrl);
    }

    authorizedPathway(status: any, sdm: any) {
        if (sdm) {
            this._commonHttpService
            .create(
                {
                    method: 'post',
                    servicerequestid: this.id,
                    status: status,
                    intakeservicerequestsdmid: sdm.intakeservicerequestsdmid,
                    casenumber : this.dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER)
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.PathwayAutorizationUrl
            )
            .subscribe((response) => {
                if (response.data[0].pathwayapprove === 'SUCCESS') {
                    this._alertService.success('Sdm pathway changes approved successfully.');
                } else if (response.data === 'SUCCESS') {
                    this._alertService.warn('Sdm pathway changes declined.');
                }
                observableTimer(2000).subscribe((res) => {
                    if (this.roleId.role.name === 'field') {
                        this.router.navigate(['/pages/home-dashboard']);
                    } else if (this.roleId.role.name === 'apcs') {
                        this.router.navigate(['/pages/cjams-dashboard']);
                    }
                });
            });
        }
    }

    private listSDMHistory() {
        let sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmvaluesUrl;
        let requestParam ;
        if (this.isServiceCase) {
            sdmUrl = 'servicecase/getservicecasesdm';
            requestParam = {
                servicecaseid : this.id
            };
        } else {
            const isExpungementSuperUser= this._authService.isExpungementSuperUser();
            requestParam = {
                servicerequestid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        }
        return this._commonHttpService.getArrayList(
            new PaginationRequest({
                where: requestParam,
                method: 'get'
            }),
            sdmUrl + '?filter'
        );
    }

    private buildAllegedVictimForm(x: any): FormGroup {
        return this.formBuilder.group({
            victimname: x.victimname ? x.victimname : ''
        });
    }
    private buildAllegedMaltreatorForm(x: any): FormGroup {
        return this.formBuilder.group({
            maltreatorsname: x.maltreatorsname ? x.maltreatorsname : ''
        });
    }
    private buildProviderForm(x: any): FormGroup {
        return this.formBuilder.group({
            providername: x.providername ? x.providername : '',       // @TM: the variable name is maltreatorsname for some reason, correct this later
            // providername: x.providername ? x.providername : '',
            providerid: x.providerid ? x.providerid : '',
            providerphone: x.providerphone ? x.providerphone : ''
        });
    }

    createFormGroup(formGroupName: any) {
        if (formGroupName === 'allegedvictim') {
            return this.formBuilder.group({
                victimname: ['']
            });
        } else if (formGroupName === 'allegedmaltreator') {
            return this.formBuilder.group({
                maltreatorsname: ['']
            });
        } else if (formGroupName === 'provider') {
            return this.formBuilder.group({
                providername: ['']
            });
        }
    }

    addNewFormGroup(formGroupName: any) {
        const control = <FormArray>this.sdmFormGroup.controls[formGroupName];
        const newGroup = this.createFormGroup(formGroupName);
        if (newGroup) {
            control.push(newGroup);
        }
    }

    deleteFormGroup(index: number, formGroupName: any) {
        const control = <FormArray>this.sdmFormGroup.controls[formGroupName];
        control.removeAt(index);
    }

    onChangeMaltreatment(item: any) {
        this.sdmFormGroup.patchValue({ providerKnown : null});
        if (item === 'yes') {
            this.isDisplayProvider = true;
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isoutofhome: true }, { emitEvent: false });
            this.sdmSettings.isoutofhome = true;
        } else {
            this.isDisplayProvider = false;
            const control = <FormArray>this.sdmFormGroup.controls['provider'];
            control.controls = [];
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isoutofhome: false }, { emitEvent: false });
            this.sdmSettings.isoutofhome = false;
        }
    }

    changeScreenOutIN(item: any) {
        this.isScreenOutIN = item;
        if (item === 'Scrnin') {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
        } else if (item === 'ScreenOUT') {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-AR' }, { emitEvent: false });
        } 
    }
    changeOverScreenOutIN(item: any) {
        this.isScreenOutIN = item;
        if (item === 'Ovrscrnin') {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
        } else if (item === 'OvrScrnout') {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-AR' }, { emitEvent: false });
        } 
    }
    changeImmediate(item: any) {
        this.sdmFormGroup.get('immediate')?.patchValue(item,{emitEvent:false});
        this.isImmediate = item;
    }
    changeChildInderOneYear(item: any) {
        this.isChildInderOneYear = item;
        this.validateIRAR(this.sdmFormGroup.value);
    }

    private cpsResponseValidation(sdm: any) {
        if(!this.userOverrodeImmediateList){
        this.populateSdm = Object.assign({}, sdm);

        if ((ObjectUtils.checkTrueProperty(this.populateSdm.sexualAbuse) ?? 0) >= 1) { // Sexual Abuse - any selection
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: true, disabled: true }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issexualabuse: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: false, disabled: false }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issexualabuse: false }, { emitEvent: false });
        }
        if (this.populateSdm.physicalAbuse.ismalpa_labortrafficking) { // Labor Trafficking - any selection
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ islabortrafficking: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ islabortrafficking: false }, { emitEvent: false });
        }
        this.handlePhysicalAbuseCpsRespValidationFn();
        this.handleGeneralNeglectCpsRespValidationFn();

        /*
        Fix for "Unable to swap CPS AR to IR pathway change - need to update ability to only change 
        discretionary factors and update pathway (need to update SDM options which is incorrect - 
        shouldn't be able to update SDM) 
        */

        if ((ObjectUtils.checkTrueProperty(this.populateSdm.arGeneralNeglect) ?? 0) >= 1 || (ObjectUtils.checkTrueProperty(
            this.populateSdm.unattendedChild) ?? 0) >=1||this.populateSdm.isnegfp_cargiverintervene ||this.populateSdm.isnegab_abandoned ||
            this.populateSdm.isnegmn_unreasonabledelay) {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: true, disabled: true }, { emitEvent: false });
        }
        
        if (this.populateSdm.ismenab_psycologicalability === true || this.populateSdm.ismenng_psycologicalability === true) { // Mental Abuse or Neglect
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: true, disabled: true }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isreportmeets: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: false, disabled: false }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isreportmeets: false }, { emitEvent: false });
        }
        this.handleRiskofHarmCpsRespValidationFn();

        this.populateNoImmediateListAuto();
    }
        this.validateCPSIRAR(this.sdmFormGroup.value);
    }
    // Assosiated with cpsResponseValidation function
    private handleRiskofHarmCpsRespValidationFn() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.riskofHarm) ?? 0) >= 1) { // Risk of Harm

            if (this.populateSdm.riskofHarm.isnegrh_exposednewborn === true) {
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: true }, { emitEvent: false });
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false, disabled: true }, { emitEvent: false });
            } else {
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: false }, { emitEvent: false });
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: true, disabled: true }, { emitEvent: false });
            }
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false, disabled: false }, { emitEvent: false });
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: false, disabled: true }, { emitEvent: false });
        }
    }
    // Assosiated with cpsResponseValidation function
    private handleGeneralNeglectCpsRespValidationFn() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.generalNeglect) ?? 0) >= 1 || (ObjectUtils.checkTrueProperty(
            this.populateSdm.unattendedChild) ?? 0) >= 1 || this.populateSdm.isnegfp_cargiverintervene || this.populateSdm.isnegab_abandoned ||
            this.populateSdm.isnegmn_unreasonabledelay) { // General Neglect
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: true, disabled: true }, { emitEvent: false });

            this.sexualAbuseCheck();
            this.physicalAbuseCheck();
            this.generalNeglectCheck();
            this.arGeneralNeglectCheck();

            if (this.populateSdm.generalNeglect.isneggn_signsordiagnosis === true) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issignordiagonises: true }, { emitEvent: false });
            } else {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issignordiagonises: false }, { emitEvent: false });
            }

        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: false, disabled: false }, { emitEvent: false });

            if (!this.truePropertyPAFlag) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: false }, { emitEvent: false });
            }
            this.truePropertyGNFlag = false;

            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issignordiagonises: false }, { emitEvent: false });
        }
    }
    // Assosiated with cpsResponseValidation function
    private handlePhysicalAbuseCpsRespValidationFn() {
       this.physicalAbuseCheck();
    }

    sexualAbuseCheck() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.sexualAbuse) ?? 0) >= 1) { // Sexual Abuse - any selection
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: true, disabled: true }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issexualabuse: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: false, disabled: false }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issexualabuse: false }, { emitEvent: false });
        }
    }

    physicalAbuseCheck() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.physicalAbuse) ?? 0) >= 1) { // Physical Abuse
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_physicalabuse: true, disabled: true }, { emitEvent: false });

            if (this.populateSdm.physicalAbuse.ismalpa_suspeciousdeath === true) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: true }, { emitEvent: false });
                this.truePropertyPAFlag = true;
            } else {
                if (!this.truePropertyGNFlag) {
                    this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: false }, { emitEvent: false });
                }
                this.truePropertyPAFlag = false;
            }
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_physicalabuse: false, disabled: false }, { emitEvent: false });

            if (!this.truePropertyGNFlag) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: false }, { emitEvent: false });
            }
            this.truePropertyPAFlag = false;
        }
    }

    generalNeglectCheck() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.generalNeglect) ?? 0) >= 1 || (ObjectUtils.checkTrueProperty(
            this.populateSdm.unattendedChild) ?? 0) >= 1 || this.populateSdm.isnegfp_cargiverintervene || this.populateSdm.isnegab_abandoned ||
            this.populateSdm.isnegmn_unreasonabledelay) { // General Neglect
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: true, disabled: true }, { emitEvent: false });

            if (this.populateSdm.generalNeglect.isneggn_suspiciousdeath === true) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: true }, { emitEvent: false });
                this.truePropertyGNFlag = true;
            } else {
                if (!this.truePropertyPAFlag) {
                    this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: false }, { emitEvent: false });
                }
                this.truePropertyGNFlag = false;
            }

            if (this.populateSdm.generalNeglect.isneggn_signsordiagnosis === true) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issignordiagonises: true }, { emitEvent: false });
            } else {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issignordiagonises: false }, { emitEvent: false });
            }

        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: false, disabled: false }, { emitEvent: false });

            if (!this.truePropertyPAFlag) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: false }, { emitEvent: false });
            }
            this.truePropertyGNFlag = false;

            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issignordiagonises: false }, { emitEvent: false });
        }
    }


    arGeneralNeglectCheck() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.arGeneralNeglect) ?? 0) >= 1 || (ObjectUtils.checkTrueProperty(
            this.populateSdm.unattendedChild) ?? 0) >= 1 || this.populateSdm.isnegfp_cargiverintervene || this.populateSdm.isnegab_abandoned ||
            this.populateSdm.isnegmn_unreasonabledelay) {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: true, disabled: true }, { emitEvent: false });
        }
    }
    

    private setCPSImmediates() {
        this.updatingImmediates = true;
        this.populateSdm = this.sdmFormGroup.getRawValue();

        this.sexualAbuseCheck();
        this.physicalAbuseCheck();
        this.generalNeglectCheck()
        this.arGeneralNeglectCheck();

        if (this.populateSdm.ismenab_psycologicalability === true || this.populateSdm.ismenng_psycologicalability === true) { // Mental Abuse or Neglect
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: true, disabled: true }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isreportmeets: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: false, disabled: false }, { emitEvent: false });
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isreportmeets: false }, { emitEvent: false });
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.riskofHarm) ?? 0) >= 1) { // Risk of Harm
            if (this.populateSdm.riskofHarm.isnegrh_exposednewborn === true) {
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: true }, { emitEvent: false });
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false, disabled: true }, { emitEvent: false });
            } else {
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: false }, { emitEvent: false });
                this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: true, disabled: true }, { emitEvent: false });
            } 
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false, disabled: false }, { emitEvent: false });
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: false, disabled: true }, { emitEvent: false });    // @TM: should be always disabled
        }
        this.populateNoImmediateListAuto();
        this.updatingImmediates = false;
    }
    
    validateIRAR(sdm: Sdm) {
        if (sdm.scnRecommendOveride !== '') {
            if (sdm.scnRecommendOveride === 'Ovrscrnin') {
                this.validateIRARScreenIn();
            } else if (sdm.scnRecommendOveride === 'OvrScrnout') {
                this.validateIRARScreenOut();
            } else {
                this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
            }
        } else if (sdm.screeningRecommend === 'Scrnin') {
            this.validateIRARScreenIn();
        } else if (ObjectUtils.checkTrueProperty(sdm.disqualifyingCriteria)) {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
        } else if (ObjectUtils.checkTrueProperty(sdm.disqualifyingFactors)) {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
        } else {
            this.validateIRARScreenOut();
        }
        if (this.isChildInderOneYear === 'Yes' || (this.childFatality === 'yes' &&  this.sdmFormGroup.getRawValue().childfatality === 'yes')) {
            const caseid = this.getCaseId();
            if (caseid) {
                this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + caseid)
                .subscribe((result: any) => {
                    if (result) {
                        const purpose = result?.intakeservicerequesttype?.description;
                        if(!['ROA-CPS', MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL, MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES].includes(purpose)) {
                            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
                        }
                    }
                });
            }
        }
    }
    
    validateIRARScreenIn() { // if Screen In or Over-ride Screen In

        // Code pulled from intake-sdm.component.ts ----------------------------------
        if (this.CPSFlag && this.CPSFlag === 'disable') {
            if (                                                                              // ----------IR Conditions
                !this.sdm?.physicalAbuse?.ismalpa_suspeciousdeath &&
                !this.sdm?.generalNeglect?.isneggn_suspiciousdeath &&
                !this.sdm?.generalNeglect?.isneggn_signsordiagnosis &&
                !this.sdm?.ismenab_psycologicalability &&
                !this.sdm?.ismenng_psycologicalability &&
                !this.sdm?.sexualAbuse?.ismalsa_physicalindicators &&
                !this.sdm?.sexualAbuse?.ismalsa_sex_trafficking &&
                !this.sdm?.sexualAbuse?.ismalsa_sexualact &&
                !this.sdm?.sexualAbuse?.ismalsa_sexualexploitation &&
                !this.sdm?.sexualAbuse?.ismalsa_sexualmolestation
            ) {
                this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
                this.isIRFlag = false;
            } else if
            (
                this.sdm?.physicalAbuse?.ismalpa_suspeciousdeath ||
                this.sdm?.generalNeglect?.isneggn_suspiciousdeath ||
                this.sdm?.generalNeglect?.isneggn_signsordiagnosis ||
                this.sdm?.ismenab_psycologicalability ||
                this.sdm?.ismenng_psycologicalability ||
                this.sdm?.sexualAbuse?.ismalsa_physicalindicators ||
                this.sdm?.sexualAbuse?.ismalsa_sex_trafficking ||
                this.sdm?.sexualAbuse?.ismalsa_sexualact ||
                this.sdm?.sexualAbuse?.ismalsa_sexualexploitation ||
                this.sdm?.sexualAbuse?.ismalsa_sexualmolestation
            ) {
                this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
                this.isIRFlag = true;
            }

        } else {
            if (                                                                              // ----------IR Conditions
                !this.sdm?.physicalAbuse?.ismalpa_suspeciousdeath &&
                !this.sdm?.generalNeglect?.isneggn_suspiciousdeath &&
                !this.sdm?.generalNeglect?.isneggn_signsordiagnosis &&
                !this.sdm?.ismenab_psycologicalability &&
                !this.sdm?.ismenng_psycologicalability &&
                !this.sdm?.sexualAbuse?.ismalsa_physicalindicators &&
                !this.sdm?.sexualAbuse?.ismalsa_sex_trafficking &&
                !this.sdm?.sexualAbuse?.ismalsa_sexualact &&
                !this.sdm?.sexualAbuse?.ismalsa_sexualexploitation &&
                !this.sdm?.sexualAbuse?.ismalsa_sexualmolestation &&
                // Mandatory Disqualifying Criteria - this is still required to ensure correct precedence
                !this.sdm.disqualifyingCriteria?.isrisk &&
                !this.sdm?.disqualifyingCriteria?.ismaltreatment3yrs &&
                !this.sdm?.disqualifyingCriteria?.ismaltreatment12yrs &&
                !this.sdm?.disqualifyingCriteria?.ismaltreatment24yrs &&
                !this.sdm?.disqualifyingCriteria?.isactiveinvestigation &&
                // Discretionary Disqualifying Factors - this is still required to ensure correct precedence
                !this.sdm?.disqualifyingFactors?.isreportedhistory &&
                !this.sdm?.disqualifyingFactors?.ismultiple &&
                !this.sdm?.disqualifyingFactors?.isdomesticvoilence &&
                !this.sdm?.disqualifyingFactors?.iscriminalhistory &&
                !this.sdm?.disqualifyingFactors?.isthread &&
                !this.sdm?.disqualifyingFactors?.islawenforcement &&
                !this.sdm?.disqualifyingFactors?.iscourtiinvestigation
            ) {
                this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
                this.isIRFlag = false;
            } else if
            (
                this.sdm?.physicalAbuse?.ismalpa_suspeciousdeath ||
                this.sdm?.generalNeglect?.isneggn_suspiciousdeath ||
                this.sdm?.generalNeglect?.isneggn_signsordiagnosis ||
                this.sdm?.ismenab_psycologicalability ||
                this.sdm?.ismenng_psycologicalability ||
                this.sdm?.sexualAbuse?.ismalsa_physicalindicators ||
                this.sdm?.sexualAbuse?.ismalsa_sex_trafficking ||
                this.sdm?.sexualAbuse?.ismalsa_sexualact ||
                this.sdm?.sexualAbuse?.ismalsa_sexualexploitation ||
                this.sdm?.sexualAbuse?.ismalsa_sexualmolestation ||
                // Disqualifying Criteria - this is still required to ensure correct precedence
                this.sdm?.disqualifyingCriteria?.isrisk ||
                this.sdm?.disqualifyingCriteria?.ismaltreatment3yrs ||
                this.sdm?.disqualifyingCriteria?.ismaltreatment12yrs ||
                this.sdm?.disqualifyingCriteria?.ismaltreatment24yrs ||
                this.sdm?.disqualifyingCriteria?.isactiveinvestigation ||
                // Discretionary Disqualifying Factors - this is still required to ensure correct precedence
                this.sdm?.disqualifyingFactors?.isreportedhistory ||
                this.sdm?.disqualifyingFactors?.ismultiple ||
                this.sdm?.disqualifyingFactors?.isdomesticvoilence ||
                this.sdm?.disqualifyingFactors?.iscriminalhistory ||
                this.sdm?.disqualifyingFactors?.isthread ||
                this.sdm?.disqualifyingFactors?.islawenforcement ||
                this.sdm?.disqualifyingFactors?.iscourtiinvestigation
            ) {
                this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
                this.isIRFlag = true;
            }
        }

        this.validateIRFlag();
    }

    validateIRFlag() {
        if (
            !this.isIRFlag &&
            (
                this.sdm?.physicalAbuse?.ismalpa_caregiver ||
                this.sdm?.physicalAbuse?.ismalpa_childtoxic ||
                this.sdm?.physicalAbuse?.ismalpa_injuryinconsistent ||
                this.sdm?.physicalAbuse?.ismalpa_insjury ||
                this.sdm?.physicalAbuse?.ismalpa_nonaccident ||
                this.sdm?.physicalAbuse?.ismalpa_labortrafficking ||
                this.sdm?.generalNeglect?.isneggn_inadequatefood ||
                this.sdm?.arGeneralNeglect?.isneggn_exposuretounsafe ||
                this.sdm?.arGeneralNeglect?.isneggn_inadequateclothing ||
                this.sdm?.arGeneralNeglect?.isneggn_inadequatesupervision ||
                this.sdm?.arGeneralNeglect?.isnegrh_treatmenthealthrisk ||
                this.sdm?.generalNeglect?.isneggn_childdischarged ||
                this.sdm?.isnegfp_cargiverintervene ||
                this.sdm?.isnegab_abandoned ||
                this.sdm?.unattendedChild?.isneguc_leftaloneinappropriatecare ||
                this.sdm?.unattendedChild?.isneguc_leftalonewithoutsupport ||
                this.sdm?.unattendedChild?.isneguc_leftunsupervised ||
                this.sdm?.isnegmn_unreasonabledelay
            )
        ) {
            if (this.sdm?.ischildfatality) { this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false }); }
            else {this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-AR' }, { emitEvent: false });}
        } else if (this.isIRFlag) {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
        } else {
            this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
        }
    }

    validateIRARScreenOut() {
        this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
    }

    goToNextPage(pageToGo: string) {
        const pageId:any =document.querySelector('#'+ pageToGo);
        pageId.click();
        
        $('html,body').animate({ scrollTop: 0 }, 'slow');
    }

    decideScreenInMessage() {
        const purpose = this.dataStoreService.getData('da_type');
        if (purpose === MyNewintakeConstants.PURPOSE.RISK_OF_HARM_INTAKE) {
            this.initialScreenInMessage = 'NON-CPS RISK OF HARM';
        } else {
            this.initialScreenInMessage = 'one or more maltreatment types are marked';
        }
    }

    setsearchprovider() {
        this.searchprovider.providerid = '';
        this.searchprovider.providernm = '';
        this.searchprovider.providerfname = '';
        this.searchprovider.providerlname = '';
    }

    searchProvider() {
        this._commonHttpService.getArrayList(
            {
              method: 'post',
              page: this.paginationInfo.pageNumber,
              limit: 10,
              providercategorycd: [
                '3049',
                '1782',
                '3274',
                '3794',
                '3302'
            ],
              providerid: this.searchprovider.providerid,
              providername: this.searchprovider.providernm,
              providerstatuscd: 1791,
              filter: {}
            },
            'providerreferral/providersearch'
        // )
        ).subscribe(providers => {
            if (providers && providers.length) {
            this.providersList = providers;
            this.total = providers[0].countdata;
            }
            this.setsearchprovider();
        });
    }

    selectProvider(provider: any) {
        const provider1 = {providername : provider.provider_nm , providerid : provider.provider_id, providerphone : provider.adr_work_phone_tx};

        const providerControl = <FormArray>this.sdmFormGroup.controls.provider;
        if (providerControl) {
            const isProviderExist = providerControl.controls.find((item: any) => item.get('providername').value === provider1.providername);
            if (!isProviderExist) {
                providerControl.push(this.buildProviderForm(provider1));
            }

        }
        // const providerControl = <FormArray>this.sdmFormGroup.controls.provider;
        // if (this.provider) {
        //     this.provider.forEach((x) => {
        //         providerControl.push(this.buildProviderForm(x));
        //     });
        // }
    }

    onConfirmProvider() {
        if (this.selectedProvider) {
            (<any>$('#providersearch')).modal('hide');
            this.providersList = [];
        } else {
          this._alertService.warn('Please select any provider');
        }

    }

    resetOverrides(): any {
        this.sdmFormGroup.patchValue({
            scnRecommendOveride: '',
            isfinalscreenin: null,
            immediate: '',
        }, { emitEvent: false });

        this.sdmFormGroup.get('screenOut')?.reset();
        this.sdmFormGroup.get('screenIn')?.reset();
        this.sdmFormGroup.get('immediateList')?.reset();
        this.sdmFormGroup.get('noImmediateList')?.reset();
    }

    validateChildFatality(event: any) {
    
        let childfatality = event?.value;
        if (this.childFatality == 'no' && childfatality === 'yes') {
            
            setTimeout(() => {
                 this.sdmFormGroup.patchValue({
                childfatality:'no'},{emitEvent :false});
            }, 500);
            this._alertService.error('Please update child profile with valid D.O.D to proceed.');
            // this.sdmFormGroup.patchValue({ childfatality: 'no' });
             } else if (this.childFatality == 'yes' && childfatality === 'no') {
           
            
            this._alertService.error('Child profile have a valid D.O.D please update child profile to proceed.');
            this.sdmFormGroup.patchValue({ childfatality: 'yes' });
        }
    }

    getquickperson() {
        const caseInfo = this.dataStoreService.getData('dsdsActionsSummary');
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
            this.quickCardPersonList = data[0].getquickpersondetails;

            const quickPersonList = data[0].getquickpersondetails;  
             quickPersonList.filter((person: any) => {
                const substanceExposed = person.quickpersonsubstconfig;
                if (substanceExposed && Array.isArray(substanceExposed)) {
                    this.isSENFlag = true;
                    this.sdmFormGroup.get('riskofHarm')?.patchValue({'isnegrh_exposednewborn': true }, { emitEvent: false });
                    this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: true }, { emitEvent: false });
                    this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false }, { emitEvent: false });                        
                    this.updateSubstantialRisk();
                }
            });
          }
          if(this.isSaveEnable) {
            this.sdmFormGroup.patchValue({ cpsResponseType: null },{ emitEvent: false });
            this.sdmFormGroup.patchValue({ isar: false });
            this.sdmFormGroup.patchValue({ isir: false });
            if(this.sdm) {
                this.sdm.cpsResponseType = null;
                this.sdm.isar = false;
                this.sdm.isir = false;
            }
            if(this.populateSdm) {
                this.populateSdm.cpsResponseType = null;
                this.populateSdm.isar = false;
                this.populateSdm.isir = false;
            }
          }
        });
    }



    getInvolvedPerson() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let url = '';
    
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        let inputRequest: Object;
        if (this.isServiceCase) {
            inputRequest = {
                objectid: this.id,
                objecttypekey: 'servicecase',
                servicecaseid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        }
        else {
            inputRequest = {
                intakeserviceid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        }
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: inputRequest
                }),
                url + '?filter'
            )
            .subscribe((data) => {
                this.involvedPersonList = data.data;
                const addedPersons = data.data;
                this.getAllegedVictims(addedPersons);
                this.getAllegedMaltreators(addedPersons);
                this.birthMatchCheck(addedPersons);
                this.childFatalityCheck();
                this.childAgeCheck();
                this.setFormValues();
                this.sdmFormGroup.controls['allegedvictim'].disable();
                this.sdmFormGroup.controls['allegedmaltreator'].disable();
                this.caseType =  this.sdmFormGroup?.get('cpsResponseType')?.value;
                if (!this.sencheckbox) {
                    this.updateSubstantialRisk();
                }

            });
    }
    getAllegedVictims(addedPersons: any){
        addedPersons.forEach((item: any) => {
            item.fullName = item.fullname ? item.fullname : item.firstname + ' ' + item.lastname;
            item.roles.map((roleval: any) => {
                if (roleval.intakeservicerequestpersontypekey === 'AV') {
                    this.sdmFormGroup.setControl('allegedvictim', this.formBuilder.array([]));
                    this.allegedVictim = this.allegedVictim && this.allegedVictim.length !== 0 ?
                        this.allegedVictim : [{ victimname: item.fullName }];
                    const avData = this.allegedVictim.filter((name) => name.victimname === item.fullName);
                    if (avData.length === 0) {
                        const allegedV = {
                            victimname: item.fullName
                        };
                        this.allegedVictim.push(allegedV);
                    }
                }
            });
        });
    }

    getAllegedMaltreators(addedPersons: any){
        addedPersons.forEach((item: any) => {
            item.fullName = item.fullname ? item.fullname : item.firstname + ' ' + item.lastname;
            item.roles.map((roleval: any) => {
                if (roleval.intakeservicerequestpersontypekey === 'AM') {
                    this.sdmFormGroup.setControl('allegedmaltreator', this.formBuilder.array([]));
                    this.allegedMaltreator = this.allegedMaltreator && this.allegedMaltreator.length !== 0 ?
                        this.allegedMaltreator : [{ maltreatorsname: item.fullName }];
                    const amData = this.allegedMaltreator.filter((name) => name.maltreatorsname === item.fullName);
                    if (amData.length === 0) {
                        const allegedM = {
                            maltreatorsname: item.fullName
                        };
                        this.allegedMaltreator.push(allegedM);
                    }
                }
            });
        });
    }

    birthMatchCheck(addedPersons: any){
        addedPersons.forEach((element: any) => {
            if (element.birthmatchdetails) {
                element.birthmatchdetails.map((item: any) => {
                    if (item.birthmatchflag === 1) {
                        this.birthMatchFound = true;
                        this.birthMatchNotificationDt = (this.birthMatchNotificationDt) ? this.birthMatchNotificationDt + ', ' + moment(item.notificationdate).format(this.dtformat) : moment(item.notificationdate).format(this.dtformat);
                    }
                });
            }
        });
        if (this.birthMatchFound) {
            this.sdmFormGroup.get('riskofHarm')?.patchValue({ 'isnegrh_birth_match': true });
            this.birthMatchNotificationDt = '(' + this.birthMatchNotificationDt + ')';
        }
    }
    childFatalityCheck(){
        this.involvedPersonList.filter((person: any) => {
            const roles = person.roles;
            if (roles && Array.isArray(roles)) {
                return roles.some(role => ['CHILD', 'RC', 'OTHERCHILD'].includes(role.intakeservicerequestpersontypekey));
            } else {
                return false;
            }
        });
    }

    childAgeCheck() {
        this.childunderoneyear = false;
        this.involvedPersonList.filter((person: any) => {
            const roles = person.roles;
            if (roles && Array.isArray(roles)) {
                const valid = roles.some(role => {
                    if (['CHILD', 'AV'].includes(role.intakeservicerequestpersontypekey)) { return role.intakeservicerequestpersontypekey; }
                });
                if (valid) {
                    const age = this.calculateAge(person.dob);
                    if (age >= 0 && age <= 1) {
                        this.childunderoneyear = true;
                        this.sdmFormGroup.patchValue({ childunderoneyear: 'Yes' }, { emitEvent: false });
                    }
                }
                return valid;
            } else {
                return false;
            }
        });
    }

    calculateAge(dob: any) {
        let age = 0;
        if (dob && moment(new Date(dob), this.dtformat, true).isValid()) {
            const rCDob = moment(new Date(dob), this.dtformat).toDate();
            age = moment().diff(rCDob, 'years');
        }
        return age;
    }

    validateRiskForm(_event: any) {
        const sdmForm = this.sdmFormGroup.getRawValue();
        const disqualifyingCriteria = sdmForm.disqualifyingCriteria;
        const riskofHarm = sdmForm.riskofHarm;
        if (riskofHarm.isnegrh_exposednewborn || riskofHarm.isnegrh_priordeath) {
            if (disqualifyingCriteria.issexualabuse) {
                this.sdmFormGroup.get('disqualifyingCriteria')?.enable();
            } else {
                this.sdmFormGroup.get('disqualifyingCriteria')?.disable();
            }
        }
        if (riskofHarm.isnegrh_exposednewborn) {
            this.isSENFlag = true;
        } else {
            this.isSENFlag = false;
        }
    }

    validateCPSIRAR(sdm: any) {
        if (sdm.scnRecommendOveride !== '') {
            if (sdm.scnRecommendOveride === 'Ovrscrnin') {
                sdm.isir = true;
                sdm.isar = false;
            }
            if (sdm.scnRecommendOveride === 'OvrScrnout') {
                sdm.isir = false;
                sdm.isar = true;
            }
        } else {
            if (sdm.cpsResponseType === 'CPS-IR') {
                sdm.isir = true;
                sdm.isar = false;
            } else if (sdm.cpsResponseType === 'CPS-AR') {
                sdm.isir = false;
                sdm.isar = true;
            } else {
                sdm.isir = false;
                sdm.isar = false;
            }
        }
        if (this.isAcptNonCPS) {
            sdm.isir = false;
            sdm.isar = false;
        }

        if (this.isSENFlag) {
            sdm.isir = false;
            sdm.isar = false;
        }
    }

    clearAllImmediateSelections() {
        this.sdmFormGroup.get('noImmediateList')?.reset();
    }

    setImmediates() {
        const sdmForm = this.sdmFormGroup.getRawValue();
        this.clearAllImmediateSelections();
        
        //if(!this.sdmSettings.isPopulate)
        this.cpsResponseValidation(sdmForm);
        const noImmediateList = sdmForm.noImmediateList;

        if (noImmediateList.isnoimmed_screeninoverride) {
            this.sdmFormGroup.get('noImmediateList')?.get('isnoimmed_screeninoverride')?.disable();
        }
    }

    onMaltreatorChange(key: any, event: any) {
        if (event.checked) {
            this.sdmFormGroup.patchValue({
                isfcplacementsetting: false,
                isprivateplacement: false,
                islicenseddaycare: false,
                isfclivingarrangement: false,
                isschool: false,
            }, { emitEvent: false });
            this.sdmFormGroup.get(key)?.setValue(event.checked);
        }
    }

    getPlacementDetails(i: any) {
        this._commonHttpService
         .getSingle(
           {
            where: { personid: i},
            method: 'get'
          },
          'placement/getplacementbyperson?filter'
        ).subscribe(data => {
            if (data && data.length) {
                const placementRecords = data.filter((item: { routingstatus: string; placementtypekey: string; }) => item.routingstatus == 'Approved' && item.placementtypekey == 'PRPL');
                const laRecords = data.filter((item: { routingstatus: string; isvoided: number; placementtypekey: string; }) => item.routingstatus == 'Approved'  && item.isvoided !== 1 && item.placementtypekey == 'LA');
            
            if(this.isLivingArrangement) {

                const ladetails = laRecords?.findIndex((f: { placementid: any; }) => f.placementid === this.intakeSDM.providerdetails);
                const lvtyp = laRecords[ladetails].livingarrangementtype;
                const lvid = laRecords[ladetails].primarycaregiver;
                const {address1,address2,cityname,statetypekey,zipcode} = laRecords[ladetails]
                const lvaddress = [address1,
                    address2,
                    cityname,
                    statetypekey,
                    zipcode].filter(Boolean).join(', ') // to remove all falsy values(null, undefined, empty string) and join values with comma
                this.placementHistory.push({
                  arrangementtype: lvtyp,
                  caregiverid:   lvid,
                  address: lvaddress
                })
            } else if (this.isProviderDetails) {
                const ladetails = placementRecords.findIndex((f: { placementid: any; }) => f.placementid === this.intakeSDM.providerdetails);
                if(placementRecords[ladetails]?.cpahomedetails){
                    this.cpahome =true;
                    this.selectedcpaname =placementRecords[ladetails]?.cpahomedetails?.cpahomename;
                    this.selectedcpaaddress =placementRecords[ladetails]?.cpahomedetails?.cpahomeaddress;
                    this.selectedcpaid =placementRecords[ladetails]?.cpahomedetails?.caphome_id;
                }
                this.placementHistory.push({
                    arrangementtype: placementRecords[ladetails]?.providerdetails?.provider_id,
                    caregiverid:   placementRecords[ladetails]?.providerdetails?.providername,
                    address:  placementRecords[ladetails]?.providerdetails?.address
                  })
            }
        }
        });
    }
    confirmtraffickingchange(value: any){
        this.sdmFormGroup.patchValue({
            traffickingupdated:true
        })
        if(value ==='NO'){
            this.sdmFormGroup.patchValue({
                selecttrafficking:null
            })
        }
        this.sdmFormGroup.get("physicalAbuse")?.patchValue({ ismalpa_labortrafficking: false })

    }
    selecttraffickingchange(_val: any){
        this.sdmFormGroup.patchValue({
            traffickingupdated:true
        });
        this.sdmFormGroup.get("physicalAbuse")?.patchValue({ ismalpa_labortrafficking: _val.includes("LT") });
    }
        resetResTimeDecision() {
        let selecttrafficking = ['LT']
        if (this.sdmFormGroup.get("selecttrafficking")?.value) {
            selecttrafficking = [...this.sdmFormGroup.get("selecttrafficking")?.value, ...selecttrafficking]
        }
        if (this.sdmFormGroup.get("physicalAbuse")?.get("ismalpa_labortrafficking")?.value) {
            this.sdmFormGroup.patchValue({
                selecttrafficking: selecttrafficking,
                confirmtrafficking: 'Yes'
            });
        } else {
            if (this.sdmFormGroup.get("selecttrafficking")?.value?.includes("ST")) {
                this.sdmFormGroup.patchValue({
                    selecttrafficking: ['ST'],
                    confirmtrafficking: "Yes"
                });
            } else {
                this.sdmFormGroup.patchValue({
                    selecttrafficking: null,
                    confirmtrafficking: null
                });
            }
        }
    }
   
    Savetraffickingdetails(){
        if(this.sdmFormGroup.controls['confirmtrafficking'].invalid ||this.sdmFormGroup.controls['selecttrafficking'].invalid ||this.sdmFormGroup.controls['confirmtrafficking'].value =='Yes'&& this.sdmFormGroup.controls['selecttrafficking']?.value?.length ==0 || this.sdmFormGroup.controls['confirmtrafficking'].value =='Yes'&& this.sdmFormGroup.controls['selecttrafficking'].value[0] == '{}'){
            this._alertService.error("Please fill all the required fields");
            return;
        }
        if(!this.sdmFormGroup.controls['traffickingupdated']?.value) {
            return;
        }
        this._commonHttpService
            .create(
                {
                    method: 'post',
                    casenumber: this.dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER),                    
                    intakeservicerequestsdmid: this.populateSdm?.intakeservicerequestsdmid,
                    concerntrafficking: this.sdmFormGroup.getRawValue().confirmtrafficking,
                    selecttrafficking:this.sdmFormGroup.getRawValue().selecttrafficking,
                    intakeserviceid: this.dataStoreService.getData('dsdsActionsSummary')?.intakeserviceid, 
                    intakenumber: this.dataStoreService.getData('dsdsActionsSummary')?.intakenumber,
                    isservicecase:this.isServiceCase
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.UpdateTraffickingUrl
            )
            .subscribe((response) => {
                if ([response?.data[0]?.updatesdmtrafficking, response?.data[0]?.updatesdmtrafficking_txt].includes('SUCCESS')) {
                    this._alertService.success('SDM Trafficking values saved successfully');
                    this.sdmFormGroup.patchValue({
                        traffickingupdated:false
                    })
                    this.listSDMHistory().subscribe((data) => {
                        if (data?.length > 0) {
                            this.handleListSDMHistoryApiResponseFn(data);
                        }
                    });
                } else  {
                    this._alertService.warn('An error occured while saving');
                }
            })
    }

    // assosiated with Savetraffickingdetails mthos
    private handleListSDMHistoryApiResponseFn(data: any[]) {
        if (this.isServiceCase) {
            if (data[0].getservicecasesdm) {
                this.savedSDMs = this.setVersion(data[0].getservicecasesdm);
                if (data[0].getservicecasesdm.length > 0) {
                    this.servicerequestnumber = data[0].getservicecasesdm[0].servicerequestnumber;
                }
            }
        } else if (data[0].getintakeservicerequestsdm) {
            this.savedSDMs = this.setVersion(data[0].getintakeservicerequestsdm);
        }
    }

    getsdmtraffickingaudittrail(){
        let request;
        this.sdmtraffickingauditlist=[];
        this.maltreatmentauditlist=[];
        this.childfatalityauditlist=[];
        const caseInfo = this.dataStoreService.getData('dsdsActionsSummary');
        const sdmtraffickingurl =CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmtraffickingaudittrailUrl
        
        request = {
            intakenumber : caseInfo.intakenumber,
            servicerequestnumber: (this.servicerequestnumber) ? (this.servicerequestnumber) : caseInfo?.servicecasenumber,
            servicecasenumber: caseInfo.da_number
        };
        
        this._commonHttpService.getArrayList(
            {
              where: request,
              method: 'get',
              nolimit: true
            },
            sdmtraffickingurl + '?filter'
           
          ).subscribe(data => {
              if(data && data.length){
                    this.handleSdmtraffickingurlResponseLoopFn(data);
                   this.sdmtraffickingauditlist.forEach((value)=>{
                   value.selecttrafficking = value?.selecttrafficking?.replace(/["'\[\]]/g, "").replace("ST", 'Sex Trafficking').replace("LT","Labor Trafficking");
                  }
                  );
              }
          });
        
        (<any>$('#sdmtrafficking')).modal('show');
    }// Assosiated with getsdmtraffickingaudittrail function
    private handleSdmtraffickingurlResponseLoopFn(data: any[]) {
        for (let i = 0; i < data[0].getsdmtraffickingaudittrail.length; i++) {
            if (data[0].getsdmtraffickingaudittrail[i].objectkey == 'maltreatment') {
                this.pushDataIfMaltreatmentFn(data, i);
            }
            if (data[0].getsdmtraffickingaudittrail[i].objectkey == 'trafficking') {
                this.sdmtraffickingauditlist.push(data[0].getsdmtraffickingaudittrail[i]);
            }
            if (data[0].getsdmtraffickingaudittrail[i].objectkey == 'childfatality') {
                this.childfatalityauditlist.push(data[0].getsdmtraffickingaudittrail[i]);
            }
        }
    }
    // Assosiated with getsdmtraffickingaudittrail function
    private pushDataIfMaltreatmentFn(data: any[], i: number) {
        if (data[0].getsdmtraffickingaudittrail[i].isfclivingarrangement == 'true') {
            data[0].getsdmtraffickingaudittrail[i].maltreatmenttype = 'Living Arrangement in foster care';
        }
        if (data[0].getsdmtraffickingaudittrail[i].isschool == 'true') {
            data[0].getsdmtraffickingaudittrail[i].maltreatmenttype = 'School';
        }
        if (data[0].getsdmtraffickingaudittrail[i].islicenseddaycare == 'true') {
            data[0].getsdmtraffickingaudittrail[i].maltreatmenttype = 'Licensed or unlicensed daycare';
        }
        if (data[0].getsdmtraffickingaudittrail[i].isfcplacementsetting == 'true') {
            data[0].getsdmtraffickingaudittrail[i].maltreatmenttype = 'Family-based foster home';
        }
        if (data[0].getsdmtraffickingaudittrail[i].isprivateplacement == 'true') {
            data[0].getsdmtraffickingaudittrail[i].maltreatmenttype = 'Non-Family Based setting';
        }
        this.maltreatmentauditlist.push(data[0].getsdmtraffickingaudittrail[i]);
    }

    pageChanged(pageEvent: any) {
        this.paginationInfo.pageNumber = pageEvent.page;
        this.searchProvider();
    }

    get providerDetails(): any {
        return this.sdmFormGroup.get('provider') as any;
    }

    get allegedmaltreatorDetails(): any {
        return this.sdmFormGroup.get('allegedmaltreator') as any;
    }

    get allegedvictimDetails(): any {
        return this.sdmFormGroup.get('allegedvictim') as any;
      }

        //1080 refinement
    changeSeriousPhysicalInjury(event: any) {
          // This is intentional
    }

    getCaseId() {
        const isServicecase = this.dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        const cpscaseid = this.dataStoreService.getData(CASE_STORE_CONSTANTS.CPS_CASE_ID);
        return (isServicecase) ? cpscaseid : this.id;
    }
}
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';
import {map} from 'rxjs/operators';
import { forkJoin, Observable } from 'rxjs';
import { FormArray, FormBuilder, FormGroup, Validators } from '../../../../../../node_modules/@angular/forms';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { IntakeUtils } from '../../../_utils/intake-utils.service';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { AlertService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { NewUrlConfig } from '../../newintake-url.config';
import { IntakeConfigService } from '../intake-config.service';
import { IntakeStoreConstants, MyNewintakeConstants } from '../my-newintake.constants';
import { InvolvedPerson, MaltreatorsName, ProviderName, Sdm, VictimName, Disqualifyingcriteria } from '../_entities/newintakeModel';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'intake-sdm',
    templateUrl: './intake-sdm.component.html',
    styleUrls: ['./intake-sdm.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class IntakeSdmComponent implements OnInit {
    sdmFormGroup!: FormGroup;
    isDisplayProvider = false;
    exposednewborn =false;
    disableAbuseNeg = false;
    truePropertyPAFlag = false;
    truePropertyGNFlag = false;
    isSENFlag= false;
    isIRFlag!: boolean;
    isChildInderOneYear!: string;
    isScreenOutIN = 'No';
    isImmediate!: boolean;
    isNoImmediate!: boolean;
    scrninFlag!: boolean;
    disableDQ: boolean = false;
    sdm = new Sdm();
    savedSDMs: Sdm[] = [];
    populateSdm!: Sdm;
    reporMinDateValdiation: any;
    allegedVictim: VictimName[] = [];
    allegedMaltreator: MaltreatorsName[] = [];
    provider: ProviderName[] = [];
    providerCount!: number;
    providerpaginationInfo: PaginationInfo = new PaginationInfo();
    maxDate = new Date();
    searchprovider: any = {};
    providersList: any[] = [];
    selectedProvider: any = [];
    holdData!: string;
    CPSFlag!: string;
    updatingImmediates!: boolean;
    userOverrodeImmediateList!: boolean;
    noImmediateList: any = {};
    patchIntakeModelSdm!: Sdm;
    sdmCountyValuesDropdownItems$!: Observable<DropdownModel[]>;
    roleId!: AppUser;
    dayToOverride!: number;
    isSaveEnable: boolean = false;
    supervisorStatus: any;
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
    addSdm!: Sdm;
    executed: boolean = false;
    private submittedDate?: Date;
    private intakeNumber: string;
    pathwayChange = false;
    childFatality: any = '';
    private store: any;
    involvedPersons: InvolvedPerson[] = [];
    quickPersonList: any = [];
    showCpsResponseType!: boolean;
    isAcptNonCPS!: boolean;
    cpsIRArray: any[] = [];
    childunderoneyearflag!: boolean;
    childfatalityflag = false;
    isSupervisor!: boolean;
    birthMatchFound = false;
    birthMatchNotificationDt!: string;
    isMandatory = false;
    Providerplacementdetails:any[]=[]
    selectedproviderId :any;
    showprovider = false;
    selectedprovidername :any;
    selectedProvideraddress:any;
    selectedcpaname :any;
    selectedcpaaddress:any;
    selectedcpaid:any;
    cpahome = false;
    Providerdetails:any[] =[];
    familybased :any[] =[];
    nonfamilybased:any[]=[];
    allegedVictimId:any[] =[];
    Providerplacement :any[]=[];
    livingarrangement!: boolean;
    showdropdown = false;
    selectedlivingarrangement :any;
    livingarraddress:any;
    primarycaregiver :any;
    ischeckboxMandatory = false;
    selectedplacement:any;
    islivingmandatory = false;
    traffickinglist :any[]=[];
    sdmtraffickingauditlist: any[]=[];
    maltreatmentauditlist:any[]=[];
    childfatalityauditlist:any[]=[];
    maltreatmenttype:any[]=[];
    noimmediate = 'No Immediate';
    dtformat = 'MM/DD/YYYY';
    paginationInfo: PaginationInfo = new PaginationInfo();
    total!: number;
    pageInfo: PaginationInfo[] = new Array(10).fill(new PaginationInfo());
    private readonly formBuilder: FormBuilder;
    private readonly _authService: AuthService;
    private readonly _commonHttpService: CommonHttpService;
    private readonly route: ActivatedRoute;
    private readonly _store: DataStoreService;
    private cdr: ChangeDetectorRef;
    intakeErrorMessage!: string | null;
    intakeerrorpopupid = '#intake-error-msg';

    constructor(
        private readonly injector: Injector,
        private readonly _alertService: AlertService,
        private readonly _dataStore: DataStoreService,
        private readonly _intakeConfig: IntakeConfigService,
        private readonly _intakeService: IntakeUtils,
    ) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

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
        this.store = this._store.getCurrentStore();
        this.intakeNumber = this.store[IntakeStoreConstants.intakenumber];
    }

    ngOnInit() {
        this.paginationInfo.pageNumber = 1;
        this.CPSFlag = this._dataStore.getData('CPSFlag');
        this.showCpsResponseType = true;
        this.userOverrodeImmediateList = false;
        this.setsearchprovider();
        this.buildFormGroup();
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
        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
        } else {
            this.isSupervisor = false;
        }

        if (this.store[IntakeStoreConstants.IntakeAction] === 'add') {
            this.getInvolvedPerson('add');
        } else {
            this.getInvolvedPerson('');
        }
        this.getCaseDisposition();
        this.getquickperson();
        this.setsearchprovider();
        this.getInvolvedPersons();

        this.updatingImmediates = false;
        
        this.sdmFormGroup.valueChanges.subscribe(() => {
            this.isAcptNonCPS = false;
            this.sdm = Object.assign({}, this.sdmFormGroup.getRawValue());

            this.switchoverride();
            if (!this.supervisorStatus || this.supervisorStatus !== 'Approved'){
                this.cpsResponseValidation(this.sdmFormGroup.getRawValue());
            }
            
            this.validateIRAR(this.sdmFormGroup.getRawValue());
            this.validateSDM(this.sdmFormGroup.getRawValue());
            this._store.setData(IntakeStoreConstants.intakeSDM, this.addSdm);

            this.sdmFormGroupResponseFn();
            this.updateFormControlsCPSType(this.disableDQ);
        });

        if (this.store[IntakeStoreConstants.intakeSDM]) {
            const sdmData = this.store[IntakeStoreConstants.intakeSDM];
            if (this.supervisorStatus && this.supervisorStatus === 'Approved') {
                switch (sdmData.isfinalscreenin) {
                    case true: 
                        sdmData.isfinalscreenin = 'true';
                        break;
                    case false: 
                        sdmData.isfinalscreenin = 'false';
                        break;
                    default:
                        // Do Nothing
                        break;
                }
            }
            this.patchSDM(sdmData, false, true);
        }

        this.getCountyDropdown();

        const childfatality = this.store[IntakeStoreConstants.childfatality];
        const childFatalityDetails = this._store.getData(IntakeStoreConstants.childfatalityUpdate);
        if (childfatality) {
            this.sdmFormGroup.patchValue({ childfatality: childfatality });
            this.childFatality = childfatality;
        } else {
            if(childFatalityDetails?.value) {
                this.sdmFormGroup.patchValue({ childfatality: childFatalityDetails?.value });
                this.childFatality = childFatalityDetails?.value;
            } else {
                this.sdmFormGroup.patchValue({ childfatality: '' });
                this.childFatality = '';
            }
        }
        this.reporMinDateValdiation = moment().subtract(6, 'months');

        this.checkAddPersonsFn();
        this.CpsFlagCheckFn();
      
        this.sdmFormGroup.get("selecttrafficking")?.valueChanges.subscribe((value) => {
            const purpose =  this._store.getData(IntakeStoreConstants.purposeSelected);
            if(value?.length && purpose?.text !== 'Child Protective Services'){
                 this.intakeErrorMessage =
                'Labor/Sex Trafficking referrals are ineligible for Service Case response. Please change Purpose to CPS and complete the intake as an IR';
            (<any>$(this.intakeerrorpopupid)).modal('show'); 
            return false;
            }
        });

        if(this._dataStore.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)){
            this.sdmFormGroup.disable();
        }
        this.setChildfatality(Object.assign({}, this.sdmFormGroup.getRawValue()));
        if (this.supervisorStatus && this.supervisorStatus === 'Approved') {
            this.sdmFormGroup.disable();
        } 
    }
    
    closeIntakeError(from?: string) {
        (<any>$(this.intakeerrorpopupid)).modal('hide'); 
    }
    get providerControls() {
        return (this.sdmFormGroup.get('provider') as any)?.controls || [];
    }

    get allegedvictimControls() {
        return (this.sdmFormGroup.get('allegedvictim') as any)?.controls || [];
    }

    get allegedmaltreatorControls() {
        return (this.sdmFormGroup.get('allegedmaltreator') as any)?.controls || [];
    }
    // Associated to ngOnInit function
    private checkAddPersonsFn() {
        this.involvedPersons = this.store[IntakeStoreConstants.addedPersons];
        if (this.involvedPersons) {
            this.updateReferralName();
            this.updateSubstantialRisk();
            const childInfoArr = this.filterPersonDataFn();
            if (this._dataStore.getData(IntakeStoreConstants.INTAKE_IS_CLOSED) && this.sdm) {
                this.ifIntakeClosedCondFn();
            } else {
                this.childInfoArrFn(childInfoArr);
            }
        }
    }
    // Associated to ngOnInit function
    private sdmFormGroupResponseFn() {
        if (this.sdmFormGroup.get('isfinalscreenin')?.value === 'true') {
            this.sdmFormGroup.get('immediate')?.setValidators([Validators.required]);
        } else {
            this.sdmFormGroup.get('immediate')?.clearValidators();
        }
        if (this.sdmFormGroup.get('immediate')?.value === this.noimmediate && !this.updatingImmediates
            && !this.userOverrodeImmediateList) {
            if (this.sdmFormGroup.get('noImmediateList') &&
                this.sdmFormGroup.get('noImmediateList')?.value) {
                this.userOverrodeImmediateList = ObjectUtils.checkTrueProperty(this.sdmFormGroup.get('noImmediateList')?.value) !== ObjectUtils.checkTrueProperty(this.noImmediateList);
            }
            if (!this.userOverrodeImmediateList) {
                this.setCPSImmediates();
            }
        }
    }
    // Associated to ngOnInit function
    private CpsFlagCheckFn() {
        if (this.CPSFlag === 'disable') {
            this.sdmFormGroup.get('disqualifyingCriteria')?.reset();
            this.sdmFormGroup.get('disqualifyingCriteria')?.disable();
            this.sdmFormGroup.get('disqualifyingFactors')?.reset();
            this.sdmFormGroup.get('disqualifyingFactors')?.disable();

        } else if (this.CPSFlag === 'enable') {
            this.sdmFormGroup.get('disqualifyingCriteria')?.enable();
            this.sdmFormGroup.get('disqualifyingFactors')?.enable();
        }
    }
    // Associated to ngOnInit function
    private filterPersonDataFn() {
        return this.involvedPersons?.filter((p) => {
            const rl = p.personRole;
            if (rl && Array.isArray(rl)) {
                return rl.some(role => ['CHILD', 'AV', 'OTHERCHILD'].includes(role.rolekey));
            } else {
                return false;
            }
        });
    }
    // Associated to ngOnInit function
    private ifIntakeClosedCondFn() {
        const _childfatality = String(this.sdm.childfatality);
        if (_childfatality) {
            this.sdmFormGroup.patchValue({ childfatality: (_childfatality === 'true' || _childfatality === 'yes') ? 'yes' : 'no' });
            this.childFatality = (_childfatality === 'true' || _childfatality === 'yes') ? 'yes' : 'no';
            this.childfatalityflag = (_childfatality === 'true' || _childfatality === 'yes') ? true : false;
        }
    }
    // Associated to ngOnInit function
    private childInfoArrFn(childInfoArr: InvolvedPerson[]) {
        if (childInfoArr && childInfoArr.length >= 1) {
            const childFatalityDetails = this._store.getData(IntakeStoreConstants.childfatalityUpdate);
            const childFatilityPersonlevelDetails = this._store.getData(IntakeStoreConstants.childfatalityPersonLevelUpdate);
            const fatalities = childInfoArr.filter(chld => {
                if (chld.dateofdeath) {
                    this.sdmFormGroup.patchValue({ childfatality: 'yes' });
                    this.sdmFormGroup.get('childfatality')?.disable();
                    this.childFatality = 'yes';
                    this.childfatalityflag = true;
                    return true;
                }
                this.sdmFormGroup.get('childfatality')?.enable();
                return false;
            });
            this.setChildFacility(fatalities, childFatalityDetails, childFatilityPersonlevelDetails);
        }
        this._store.setData(
            IntakeStoreConstants.childfatalityPersonLevelUpdate,
            {isUpdated: false}
        );
    }

    setChildFacility(fatalities: any, childFatalityDetails: any, childFatilityPersonlevelDetails: any){
        if (fatalities?.length === 0 && childFatalityDetails?.value ) {
            if(childFatalityDetails?.value === 'yes') {
                if(!childFatilityPersonlevelDetails?.isUpdated) {
                    this._store.setData(
                        IntakeStoreConstants.childfatalityUpdate,
                        {value: 'no', isUpdated: true}
                    );
                }
            }
            this.sdmFormGroup.patchValue({ childfatality: 'no' });
            this.childFatality = 'no';
        }
    }

    validateMaltreatmentOverScreenin(){
        if (this.isSaveEnable) {return}
        const sdmForm = this.sdmFormGroup.getRawValue();
        if(this.objReusableFn(sdmForm.physicalAbuse) >= 1 ||
        this.objReusableFn(sdmForm.sexualAbuse) >= 1 ||
        this.objReusableFn(sdmForm.generalNeglect) >= 1 ||
        this.objReusableFn(sdmForm.arGeneralNeglect) >= 1 ||
        sdmForm.isnegfp_cargiverintervene || sdmForm.isnegab_abandoned ||
        this.objReusableFn(sdmForm.unattendedChild) >= 1 ||
        sdmForm.isnegmn_unreasonabledelay ||
        sdmForm.ismenab_psycologicalability ||
        sdmForm.ismenng_psycologicalability ||
        this.objReusableFn(sdmForm.riskofHarm) >= 1
        ){
          return true;
        }else {
            return false;
        }
    }

    private objReusableFn(sdmForm: any) {
        return ObjectUtils.checkTrueProperty(sdmForm) ?? 0;
    }

    showNoMaltreatmentPopup(){
        if (this.isSaveEnable) {return}
        (<any>$('#No-Maltreatment-popup')).modal('show');
    }

    changeToNoOverrides(){
        this.sdmFormGroup.patchValue({scnRecommendOveride : ""});
        this.isScreenOutIN = "";
        this.sdmFormGroup.controls['screenOut'].reset();
        this.sdmFormGroup.controls['screenIn'].reset();
    }

    switchoverride() {
        if (this.sdmFormGroup.get('screeningRecommend')?.value === 'ScreenOUT') {
            this.sdmFormGroup.patchValue({ screeningRecommend: 'ScreenOUT' }, { emitEvent: false });
            this.sdmSettings.isDisablescrnin = false;
            this.sdmSettings.isDisablescrnout = true;
        } else if (this.sdmFormGroup.get('screeningRecommend')?.value === 'Scrnin') {
            this.sdmFormGroup.patchValue({ screeningRecommend: 'Scrnin' }, { emitEvent: false });
            this.sdmSettings.isDisablescrnin = true;
            this.sdmSettings.isDisablescrnout = false;
        } else if (this.sdmFormGroup.get('screeningRecommend')?.value === 'accept_as_noncps') {
            this.sdmFormGroup.patchValue({ screeningRecommend: 'accept_as_noncps' }, { emitEvent: false });
            this.sdmSettings.isDisablescrnin = false;
            this.sdmSettings.isDisablescrnout = false;
        }

        if (!this.supervisorStatus || this.supervisorStatus !== 'Approved') {
            if (this.sdmFormGroup.get('screeningRecommend')?.value === 'ScreenOUT') {
                this.sdmFormGroup.patchValue({
                    isfinalscreenin: 'false',
                    cpsResponseType: null
                }, { emitEvent: false });
            }

            if (this.sdmFormGroup.get('scnRecommendOveride')?.value === 'OvrScrnout') {
                this.sdmFormGroup.patchValue({
                    isfinalscreenin: 'false',
                }, { emitEvent: false });
            }
        }

        
    }

    setsearchprovider() {
        this.searchprovider.providerid = '';
        this.searchprovider.providernm = '';
        this.searchprovider.providerfname = '';
        this.searchprovider.providerlname = '';
        this.providersList = [];
    }

    resetOverrides(): any {
        this.sdmFormGroup.patchValue({
            scnRecommendOveride: '',
            isfinalscreenin: null,
            immediate: '',
        }, { emitEvent: false });

        this.sdmFormGroup.get('screenOut')?.patchValue({
            isscrnoutrecovr_insufficient: false,
            isscrnoutrecovr_information: false,
            isscrnoutrecovr_historicalinformation: false,
            isscrnoutrecovr_otherspecify: false,
            duplicatereportflag: false,
            scrnout_description: ''
        }, { emitEvent: false });

        this.sdmFormGroup.get('screenIn')?.patchValue({
            isscrninrecovr_courtorder: false,
            isscrninrecovr_otherspecify: false,
            scrnin_description: ''
        }, { emitEvent: false });

        this.sdmFormGroup.get('immediateList')?.patchValue({
            isimmed_childfaatility: false,
            isimmed_seriousinjury: false,
            isimmed_childleftalone: false,
            isimmed_allegation: false,
            isimmed_otherspecify: false,
            immediateList6: '',
        }, { emitEvent: false });

        this.sdmFormGroup.get('noImmediateList')?.patchValue({
            isnoimmed_physicalabuse: false,
            isnoimmed_sexualabuse: false,
            isnoimmed_neglectresponse: false,
            isnoimmed_mentalinjury: false,
            isnoimmed_screeninoverride: false,
            isnoimmed_substantial_risk: false,
            isnoimmed_risk_harm: false,
        }, { emitEvent: false });
    }

    // changeFinalScreenDecision(event) {
    //     if (event === 'false') {
    //         // this.sdmFormGroup.get('immediate').disable();
    //         this.sdmFormGroup.get('immediate').reset();
    //         this.sdmFormGroup.get('immediateList').reset();
    //         this.sdmFormGroup.get('noImmediateList').reset();
    //         this.isNoImmediate = false;
    //         this.isImmediate = false;
    //     } else {
    //         // this.sdmFormGroup.get('immediate').enable();
    //         // this.isImmediate = true;
    //     }
    // }

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
              providerid: this.searchprovider.providerid,
              providername: this.searchprovider.providernm,
              providerstatuscd: 1791,
              filter: {},
              page: this.paginationInfo.pageNumber,
              limit: this.paginationInfo.pageSize
            },
            'providerreferral/providersearch'
        ).subscribe(providers => {
            this.providersList = providers;
            this.providerCount = providers[0].countdata;
        });
    }

    selectProvider(provider: any) {
        const provider1 = {providername : provider.provider_nm ? provider.provider_nm : (provider.provider_first_nm + ' ' + provider.provider_last_nm) , providerid : provider.provider_id, providerphone : provider.adr_work_phone_tx};

        const providerControl = <FormArray>this.sdmFormGroup.controls.provider;
        providerControl.removeAt(0)
        if (providerControl) {
            const isProviderExist = providerControl.controls.find(item => item.get('providername')?.value === provider1.providername);
            if (!isProviderExist) {
                providerControl.push(this.buildProviderForm(provider1));
            }
        }
    }

    onConfirmProvider() {
        if (this.selectedProvider) {
            this.sdmFormGroup.get('providerdetails')?.reset();
            this.sdmFormGroup.controls['selectedproviderdetails'].reset();
            (<any>$('#providersearch')).modal('hide');
            this.setsearchprovider();
            const intakeStore = this._intakeService.getIntakeStore();
        intakeStore.maltreatmentupdated = true;
        this.sdmFormGroup.patchValue({
            maltreatmentupdated:true
        })
        this.providerChange(this.selectedProvider);
        } else {
          this._alertService.warn('Please select any provider');
        }
    }

    getInvolvedPerson(mode: any) {
        this.sdmFormGroup.get('allegedvictim')?.disable();
        this.sdmFormGroup.get('allegedmaltreator')?.disable();
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        if (addedPersons && addedPersons.length) {
            this.childunderoneyearflag = false;
            addedPersons.map((item: any) => {
                item.personRole.map((roleval: any) => {
                    this.ifRolekeyIsAVFn(roleval, item);
                    this.ifRolekeyIsAMFn(roleval, item);

                    const roles = item.personRole;
                    if (roles && Array.isArray(roles)) {
                        return this.getValidRoleFn(roles, item);
                    } else {
                        return false;
                    }
                });
            });
            if (mode === 'add') {
                this.setFormValues();
            }
        }
    }
    // Associated to getInvolvedPerson function
    private getValidRoleFn(roles: any[], item: any) {
        const valid = roles.some(role => {
            if (['CHILD', 'AV'].includes(role.rolekey)) { return role.rolekey; }
        });

        if (valid) {
            const age = this.calculateAge(item.Dob);
            const childunderoneyear = this.sdmFormGroup.get('childunderoneyear')?.value;
            this.sdmFormGroup.patchValue({ childunderoneyear: childunderoneyear ?? 'No' }, { emitEvent: false });
            if (age >= 0 && age <= 1) {
                this.childunderoneyearflag = true;
                this.sdmFormGroup.patchValue({ childunderoneyear: childunderoneyear ?? 'Yes' }, { emitEvent: false });
            }
        }
        return valid;
    }
    // Associated to getInvolvedPerson function
    private ifRolekeyIsAVFn(roleval: any, item: any) {
        if (roleval.rolekey === 'AV') {
            this.sdmFormGroup.setControl('allegedvictim', this.formBuilder.array([]));
            this.allegedVictim = this.allegedVictim && this.allegedVictim.length !== 0 ? this.allegedVictim : [{ victimname: item.fullName }];
            this.allegedVictimId = this.allegedVictimId && this.allegedVictimId.length !== 0 ? this.allegedVictimId : [{ personid: item.Pid }];
            const avData = this.allegedVictim.filter((name) => name.victimname === item.fullName);
            if (avData.length === 0) {
                const allegedV = {
                    victimname: item.fullName,
                };
                const allegedId = {
                    personid: item.Pid,
                };
                this.allegedVictim.push(allegedV);
                this.allegedVictimId.push(allegedId);

            }
            this.sdmFormGroup.get('allegedvictim')?.disable();
        }
    }
    // Associated to getInvolvedPerson function
    private ifRolekeyIsAMFn(roleval: any, item: any) {
        if (roleval.rolekey === 'AM') {

            this.sdmFormGroup.setControl('allegedmaltreator', this.formBuilder.array([]));
            this.allegedMaltreator = this.allegedMaltreator && this.allegedMaltreator.length !== 0 ? this.allegedMaltreator : [{ maltreatorsname: item.fullName }];
            const amData = this.allegedMaltreator.filter((name) => name.maltreatorsname === item.fullName);
            if (amData.length === 0) {
                const allegedM = {
                    maltreatorsname: item.fullName
                };
                this.allegedMaltreator.push(allegedM);
            }
            this.sdmFormGroup.get('allegedmaltreator')?.disable();
        }
    }

    getquickperson() {
        const caseInfo = this._dataStore.getData('dsdsActionsSummary');
        let intakeserviceid = null;
        let intakenumber = this._dataStore.getData('intakenumber') ?  this._dataStore.getData('intakenumber') : this._dataStore.getData('da_intakenumber') ;
        if (caseInfo) {
          intakeserviceid = caseInfo.intakeserviceid;
          intakenumber = caseInfo.intakenumber;
        }
        const request = {
            objectid: intakenumber ? intakenumber : intakeserviceid ,
            objecttype: intakenumber ? 'intake' : 'case'
        };
        const request1 = {
            intakenumber: intakenumber
        };
      forkJoin( [this._commonHttpService.getArrayList(
          {
            where: request,
            method: 'get',
            nolimit: true
          },
          'quickperson/list?filter'
        ), this._commonHttpService.getArrayList(
            {
              where: request1,
              method: 'get',
              nolimit: true
            },
            'quickperson/exposednewborn?filter'
          )]).subscribe(([data,senexposeddata]) => {
              if(senexposeddata){
            if (senexposeddata[0].case=='FALSE') {
                this.exposednewborn=true;
            } else{
                this.exposednewborn=false;
            }
            this.checkIfHasSubstantialRiskPersonFn();
        }
            if (data && data.length && data[0].getquickpersondetails && data[0].getquickpersondetails.length) {
             this.quickPersonList = data[0].getquickpersondetails;
             this.quickPersonList.filter((person: any) => {
                const roles = person?.quickpersonroleconfig;
                const substanceExposed = person.quickpersonsubstconfig;
                const personName = person.firstname + ' ' + person.lastname;
                this.checkIfHasRoleFn(roles, personName);
                this.checkIfHasSubstanceExposedFn(substanceExposed);
            });
            }
        });
      }
    // Associated to getquickperson function
    private checkIfHasSubstanceExposedFn(substanceExposed: any) {
        if (substanceExposed && Array.isArray(substanceExposed)) {
            this.isSENFlag = true;
            if(this.exposednewborn){
            this.sdmFormGroup.get('riskofHarm')?.patchValue({ 'isnegrh_exposednewborn': true });}
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: true }, { emitEvent: false });
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false }, { emitEvent: false });

        }
    }
    // Associated to getquickperson function
    private checkIfHasRoleFn(roles: any, personName: string) {
        if (roles && Array.isArray(roles)) {
            const allegedVictimCheck = roles.some(role => ['AV'].includes(role.actortypekey));
            const allegedMaltreatorCheck = roles.some(role => ['AM'].includes(role.actortypekey));
            if (allegedVictimCheck) {
                this.sdmFormGroup.setControl('allegedvictim', this.formBuilder.array([]));
                const allegedV = {
                    victimname: personName
                };
                this.allegedVictim.push(allegedV);
                this.setAVFormValues();
                this.sdmFormGroup.get('allegedvictim')?.disable();
            }
            if (allegedMaltreatorCheck) {
                this.sdmFormGroup.setControl('allegedmaltreator', this.formBuilder.array([]));
                const allegedV = {
                    maltreatorsname: personName
                };
                this.allegedMaltreator.push(allegedV);
                this.setAMFormValues();
                this.sdmFormGroup.get('allegedmaltreator')?.disable();
            }
        }
    }

    calculateAge(dob: any) {
        let age = 0;
        if (dob && moment(new Date(dob), this.dtformat, true).isValid()) {
            const rCDob = moment(new Date(dob), this.dtformat).toDate();
            age = moment().diff(rCDob, 'years');
        }
        return age;
    }

    private patchSDM(sdm: any, changePathway: any, loadSDMs: any) {
        if(this.populateSdm){
           this.sdmFormGroup.patchValue(this.populateSdm);
        }
        else{
            this.sdmFormGroup.patchValue(sdm);
        }
        if (sdm) {
            this.sdmSettings.isPopulate = true;
            this.populateSdm = Object.assign({}, sdm);
            this.sdmFormGroup.setControl('allegedvictim', this.formBuilder.array([]));
            this.sdmFormGroup.setControl('allegedmaltreator', this.formBuilder.array([]));
            this.sdmFormGroup.setControl('provider', this.formBuilder.array([]));
            this.populateSdm.referraldob = new Date(this.populateSdm.referraldob);
            this.populateSdm.reportdate = this.populateSdm.reportdate ? new Date(this.populateSdm.reportdate) : null;
            this.populateSdm.workerdate = this.populateSdm.workerdate ? new Date(this.populateSdm.workerdate) : null;
            this.populateSdm.supervisordate = this.populateSdm.supervisordate ? new Date(this.populateSdm.supervisordate) : null;

            /* Patch start */
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
                isnegrh_exposednewborn: sdm.isnegrh_exposednewborn,
                // isnegrh_domesticviolence: sdm.isnegrh_domesticviolence,
                // isnegrh_sexualperpetrator: sdm.isnegrh_sexualperpetrator,
                isnegrh_basicneedsunmet: sdm.isnegrh_basicneedsunmet,
                // isnegrh_substantial_risk: sdm.isnegrh_substantial_risk
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
            this.populateSdm.immediateList = Object.assign({
                isimmed_childfaatility: sdm.isimmed_childfaatility,
                isimmed_seriousinjury: sdm.isimmed_seriousinjury,
                isimmed_childleftalone: sdm.isimmed_childleftalone,
                isimmed_allegation: sdm.isimmed_allegation,
                isimmed_otherspecify: sdm.isimmed_otherspecify,
                // duplicatereportflag: sdm.duplicatereportflag,
                immediateList6: sdm.immediateList6
            });
            this.populateSdm.noImmediateList = Object.assign({
                isnoimmed_physicalabuse: sdm.isnoimmed_physicalabuse,
                isnoimmed_sexualabuse: sdm.isnoimmed_sexualabuse,
                isnoimmed_neglectresponse: sdm.isnoimmed_neglectresponse,
                isnoimmed_mentalinjury: sdm.isnoimmed_mentalinjury,
                isnoimmed_screeninoverride: sdm.isnoimmed_screeninoverride,
                isnoimmed_substantial_risk: sdm.isnoimmed_substantial_risk,
                isnoimmed_risk_harm: sdm.isnoimmed_risk_harm
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

            this.callIfIsmaltreatmentFn(sdm);
            this.ifDuplicatereportflagFn(sdm);
            this.ifIschildfatalityFn(sdm);
            this.checkCpsRespOrIsrecscFn(sdm);
            this.populateSdm.isnegfp_cargiverintervene = sdm.isnegfp_cargiverintervene;
            this.populateSdm.isnegab_abandoned = sdm.isnegab_abandoned;

            this.checkIfImmediateOrNotImmediateFn(sdm);
            if (!this.supervisorStatus || this.supervisorStatus !== 'Approved'){
                this.checkOvrScrnFn(sdm);
            }
            

            this.isScreenOutIN = this.populateSdm.scnRecommendOveride;
            this.populateSdm.county = sdm.countyid;
            /* Patch end */
            this.sdmFormGroup.patchValue(this.populateSdm);
            this.checkIfIsSelecttraffickingFn();
            this.populateNoImmediateListAuto();
            this.checkIfIsFinalscreeninFn();
            this.provider = sdm.provider;
            if (this.populateSdm.maltreatment === 'yes') {
                this.isDisplayProvider = true;
            }
            if (!this.supervisorStatus || this.supervisorStatus !== 'Approved'){
                this.cpsResponseValidation(this.populateSdm);
            }
            this.getInvolvedPerson('edit');
            this.setFormValues();
            this.roleId = this._authService.getCurrentUser();
            this.populateSdm.datesubmitted = this.populateSdm.datesubmitted ? this.populateSdm.datesubmitted : this.submittedDate;
            this.checkRoleNameConditionFn(loadSDMs, changePathway);           
        }
    }
    // Associated to patchSDM function
    private checkCpsRespOrIsrecscFn(sdm: any) {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
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
        }
    }
    // Associated to patchSDM function
    private checkOvrScrnFn(sdm: any) {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if (sdm.isscrnoutrecovr_insufficient || sdm.isscrnoutrecovr_information || sdm.isscrnoutrecovr_historicalinformation || sdm.isscrnoutrecovr_otherspecify || sdm.duplicatereportflag) {
            this.populateSdm.scnRecommendOveride = 'OvrScrnout';
            this.populateSdm.isfinalscreenin = false;
            this.populateSdm.cpsResponseType = null;
            this.populateSdm.isar = false;
            this.populateSdm.isir = false;
        } else if (sdm.isscrninrecovr_courtorder || sdm.isscrninrecovr_otherspecify) {
            this.populateSdm.scnRecommendOveride = 'Ovrscrnin';
            this.populateSdm.isfinalscreenin = true;
        } else {
            this.populateSdm.scnRecommendOveride = '';
        }
    }
    // Associated to patchSDM function
    private checkIfIsSelecttraffickingFn() {
        if (this.populateSdm.selecttrafficking && !Array.isArray(this.populateSdm.selecttrafficking)) {
            const sdmtrafficking = this.populateSdm?.selecttrafficking?.split(",");
            this.sdmFormGroup.patchValue({
                selecttrafficking: sdmtrafficking
            });
        }
    }
    // Associated to patchSDM function
    private checkIfIsFinalscreeninFn() {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if (this.populateSdm.isfinalscreenin) {
            this.sdmFormGroup.patchValue({ isfinalscreenin: 'true' }, { emitEvent: false });
        } else {
            this.sdmFormGroup.patchValue({
                isfinalscreenin: 'false'
            }, { emitEvent: false });
        }
    }
    // Associated to patchSDM function
    private checkRoleNameConditionFn(loadSDMs: any, changePathway: any) {
        if (this.roleId.role.name === 'apcs' && this.populateSdm.datesubmitted) {
            this.submittedDate = this.populateSdm.datesubmitted;
            this.sdmSettings.isSupervisor = true;
            this.validateOverrideDays(this.populateSdm.datesubmitted);
            if (loadSDMs) {
                this.listSDMs(this.intakeNumber).subscribe((data) => {
                    this.savedSDMs = data[0].getintakeservicerequestsdm;
                });
                this.cdr.markForCheck();
            }
            if (changePathway) {
                this.sdmFormGroup.enable();
                this.pathwayChange = true;
                this.populateSdm.changePathway = true;
                this._store.setData(IntakeStoreConstants.intakeSDM, this.populateSdm);
                this.sdmSettings.isPopulate = false;
            }
        } else {
            this.sdmSettings.isPopulate = false;
        }
    }
    // Associated to patchSDM function
    private checkIfImmediateOrNotImmediateFn(sdm: any) {
        if (sdm.isnoimmed_substantial_risk) {
            this.populateSdm.immediate = this.noimmediate;
        } else if (sdm.isnoimmed_physicalabuse || sdm.isnoimmed_sexualabuse || sdm.isnoimmed_neglectresponse || sdm.isnoimmed_mentalinjury ||
            sdm.isnoimmed_risk_harm || sdm.isnoimmed_screeninoverride) {
            this.populateSdm.immediate = this.noimmediate;
        } else if (sdm.isimmed_childfaatility || sdm.isimmed_seriousinjury || sdm.isimmed_childleftalone || sdm.isimmed_allegation || sdm.isimmed_otherspecify) {
            this.populateSdm.immediate = 'Immediate';
        } else {
            this.populateSdm.immediate = '';
        }
        if (this.populateSdm.immediate === 'Immediate') {
            this.isImmediate = true;
            this.isNoImmediate = false;
        } else if (this.populateSdm.immediate === this.noimmediate) {
            this.isImmediate = false;
            this.isNoImmediate = true;
        }
    }
    // Associated to patchSDM function
    private ifIschildfatalityFn(sdm: any) {
        if (sdm.ischildfatality) {
            if (sdm.ischildfatality === '') {
                this.populateSdm.childfatality = '';
            } else if (sdm.ischildfatality === 'yes') {
                this.populateSdm.childfatality = 'yes';
            } else {
                this.populateSdm.childfatality = 'no';
            }
        }
    }
    // Associated to patchSDM function
    private ifDuplicatereportflagFn(sdm: any) {
        if (sdm.duplicatereportflag) {
            sdm.duplicatereportflag = 1;
        } else if (!sdm.ismaltreatment) {
            sdm.duplicatereportflag = 0;
        } else {
            sdm.duplicatereportflag = null;
        }
    }
    // Associated to patchSDM function
    private callIfIsmaltreatmentFn(sdm: any) {
        if (sdm.ismaltreatment) {
            if (sdm.ismaltreatment === true) {
                this.populateSdm.maltreatment = 'yes';
                if (this.populateSdm.isfclivingarrangement) {
                    const eventselected = {
                        checked: true
                    };
                    this.onMaltreatorChange('isfclivingarrangement', eventselected);
                    this.selectedplacement = sdm?.providerdetails;
                }
                else if (this.populateSdm.isprivateplacement) {
                    const eventselected = {
                        checked: true
                    };
                    this.onMaltreatorChange('isprivateplacement', eventselected);
                    this.selectedplacement = sdm?.providerdetails;
                }
                else if (this.populateSdm.isfcplacementsetting) {
                    const eventselected = {
                        checked: true
                    };
                    this.onMaltreatorChange('isfcplacementsetting', eventselected);
                    this.selectedplacement = sdm?.providerdetails;
                }

            } else if (sdm.ismaltreatment === false) {
                this.populateSdm.maltreatment = 'no';
            } else {
                this.populateSdm.maltreatment = null;
            }
        }
    }

    switchPathway(sdmData: any, changePathway: any, loadSDMs: any) {
        this.patchSDM(sdmData, changePathway, loadSDMs);
        this.sdmFormGroup.get('disqualifyingCriteria')?.disable();
        // (<any>$('#tab-step3')).click();
        this.goToNextPage('tab-step3');
    }

    private listSDMs(intakeNumber: any) {
        return this._commonHttpService.getArrayList(
            new PaginationRequest({
                where: { servicerequestid: null, intakenumber: intakeNumber },
                method: 'get'
            }),
            NewUrlConfig.EndPoint.Intake.IntakeSdmListUrl
        );
    }

    buildFormGroup() {
        this.sdmFormGroup = this.formBuilder.group({
            referralname: [''],
            referraldob: [new Date()],
            referralid: [''],
            countyid: [null],
            ismaltreatment: [false],
            maltreatment: [null, [Validators.required]],
            providerKnown: [null],
            providerunknowndetail: [null],
            childfatality: [null],
            confirmtrafficking: [null],
            selecttrafficking:[null],
            traffickingupdated:[null],
            maltreatmentupdated:[null],
            objectid:this.intakeNumber,
            objecttype:'Intake',
            providerdetails:[''],
            selectedproviderdetails:[null],
            ischildfatality: [false],
            isfcplacementsetting: [false],
            isfclivingarrangement:[false],
            isprivateplacement: [false],
            childsresidence:[false],
            islicenseddaycare: [false],
            isschool: [false],
            linkschidresid:[null],
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
                isnegrh_basicneedsunmet: [false],
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
            screeningRecommend: [{ value: '', disabled: true }],
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
             // duplicatereportflag: [false],
                isimmed_otherspecify: [false],
                immediateList6: ['']
            }),
            noImmediateList: this.formBuilder.group({
                isnoimmed_physicalabuse: [{ value: false, disabled: true }],
                isnoimmed_sexualabuse: [{ value: false, disabled: true }],
                isnoimmed_neglectresponse: [{ value: false, disabled: true }],
                isnoimmed_mentalinjury: [{ value: false, disabled: true }],
                isnoimmed_screeninoverride: [{ value: false, disabled: true }],
                isnoimmed_substantial_risk: [{ value: false, disabled: true }],
                isnoimmed_risk_harm: [{ value: false, disabled: true }]
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
            workerdate: [null],
            supervisor: [''],
            supervisordate: [null],
            disqualifyingCriteria: this.formBuilder.group({
                issexualabuse: [{ value: false, disabled: true }],
                 islabortrafficking: [{ value: false, disabled: true }],
                isoutofhome: [{ value: false, disabled: true }],
                isdeathorserious: [{ value: false, disabled: true }],
                isrisk: [{ value: false, disabled: this.disableDQ }],
                isreportmeets: [{ value: false, disabled: true }],
                issignordiagonises: [{ value: false, disabled: true }],
                ismaltreatment3yrs: [{ value: false, disabled: this.disableDQ }],
                ismaltreatment12yrs: [{ value: false, disabled: this.disableDQ }],
                ismaltreatment24yrs: [{ value: false, disabled: this.disableDQ }],
                isactiveinvestigation: [{ value: false, disabled: this.disableDQ }]
            }),
            disqualifyingFactors: this.formBuilder.group({
                isreportedhistory: [{ value: false, disabled: this.disableDQ }],
                ismultiple: [{ value: false, disabled: this.disableDQ }],
                isdomesticvoilence: [{ value: false, disabled: this.disableDQ }],
                iscriminalhistory: [{ value: false, disabled: this.disableDQ }],
                isthread: [{ value: false, disabled: this.disableDQ }],
                islawenforcement: [{ value: false, disabled: this.disableDQ }],
                iscourtiinvestigation: [{ value: false, disabled: this.disableDQ }]
            }),
            cpsResponseType: [{ value: null, disabled: true }],
            isar: [true],
            isir: [false],
            isfinalscreenin: [{ value: null, disabled: true }],
            //1080 refinement
            isseriousphysicalinjury: [null]
        });
        this.sdmFormGroup.addControl('allegedvictim', this.formBuilder.array([this.createFormGroup('allegedvictim')]));
        this.sdmFormGroup.addControl('allegedmaltreator', this.formBuilder.array([this.createFormGroup('allegedmaltreator')]));
        this.sdmFormGroup.addControl('provider', this.formBuilder.array([]));
    }

    updateReferralName() {
        if (this.involvedPersons && this.involvedPersons?.length > 0) {
            for (const element of this.involvedPersons) {
                if (element.Role === 'RC') {
                    this.sdmFormGroup.patchValue({
                        referralname: element.fullName
                    });
                }
            }
        }
    }

    updateSubstantialRisk() {
        if (this.involvedPersons && this.involvedPersons?.length) {
            if (this.sdmFormGroup.get('riskofHarm')) {
                if (this.sdmFormGroup.get('riskofHarm')?.get('isnegrh_exposednewborn')) {
                    this.sdmFormGroup.get('riskofHarm')?.get('isnegrh_exposednewborn')?.disable();
                }
            }
            this.isSENFlag = false;
            this.validateIRARScreenIn();
            if (this.sdmFormGroup.get('scnRecommendOveride')?.value === 'OvrScrnout') {
                this.sdmFormGroup.patchValue({
                    isfinalscreenin: 'false'
                 }, { emitEvent: false });
            }
            this.checkIfHasSubstantialRiskPersonFn();
        }
    }
    // Associated to updateSubstantialRisk function
    private checkIfHasSubstantialRiskPersonFn() {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        const hasSubstantialRiskPerson = this.involvedPersons?.find(person => (person.senstatusflag === 1 || person.senstatusflag === 0) && (person.drugexposednewbornflag === 1 || person.fetalalcoholspctrmdisordflag === 1)
        );
        if (hasSubstantialRiskPerson && this.exposednewborn) {
            this.sdmFormGroup.get('riskofHarm')?.patchValue({ 'isnegrh_exposednewborn': true });
            this.sdmFormGroup.patchValue({ screeningRecommend: 'accept_as_noncps' }, { emitEvent: false });
            this.sdmFormGroup.patchValue({ isfinalscreenin: 'Ovr_as_noncps' }, { emitEvent: false });

            this.isSENFlag = true;
            this.validateIRARScreenIn();
            if (this.sdmFormGroup.get('scnRecommendOveride')?.value === 'OvrScrnout') {
                this.sdmFormGroup.patchValue({
                    isfinalscreenin: 'false',
                }, { emitEvent: false });
            }
        } else if(!this.sdm.riskofHarm.isnegrh_exposednewborn) {
            this.sdmFormGroup.get('riskofHarm')?.patchValue({ 'isnegrh_exposednewborn': false });
        }
    }

    getCountyDropdown() {
        this.sdmCountyValuesDropdownItems$ = this._commonHttpService
            .create(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.SdmCountyListUrl
            ).pipe(map((result) => {
                return result.map(
                    (res: any) =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyid
                        })
                );
            }));
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
                providerControl.push(this.buildProviderForm(x));
            });
        }
    }

    setAVFormValues() {
        const control = <FormArray>this.sdmFormGroup.controls.allegedvictim;
        if (this.allegedVictim) {
            this.allegedVictim.forEach((x) => {
                control.push(this.buildAllegedVictimForm(x));
            });
        }
    }


    setAMFormValues() {
        const allegedMaltreatorControl = <FormArray>this.sdmFormGroup.controls.allegedmaltreator;
        if (this.allegedMaltreator) {
            this.allegedMaltreator.forEach((x) => {
                allegedMaltreatorControl.push(this.buildAllegedMaltreatorForm(x));
            });
        }
    }

    private buildAllegedVictimForm(x: VictimName): FormGroup {
        return this.formBuilder.group({
            victimname: x.victimname ? x.victimname : ''
        });
    }
    private buildAllegedMaltreatorForm(x: MaltreatorsName): FormGroup {
        return this.formBuilder.group({
            maltreatorsname: x.maltreatorsname ? x.maltreatorsname : ''
        });
    }
    private buildProviderForm(x: ProviderName): FormGroup {
        return this.formBuilder.group({
            providername: x.providername ? x.providername : '',
            providerid: x.providerid ,
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
                providername: [''],
                childsresidence: [''],

            });
        }
    }

    addNewFormGroup(formGroupName: any) {
        const control = <FormArray>this.sdmFormGroup.controls[formGroupName];
        const newFormGroup = this.createFormGroup(formGroupName);
        if(newFormGroup) {
            control.push(newFormGroup);
        }
    }

    deleteFormGroup(index: number, formGroupName: any) {
        const control = <FormArray>this.sdmFormGroup.controls[formGroupName];
        control.removeAt(index);
        }

    resetResTimeDecision() {
        this.sdmFormGroup.get('immediate')?.reset();
        this.sdmFormGroup.get('noImmediateList')?.reset();
        this.sdmFormGroup.get('immediateList')?.reset();
        this.isImmediate = false;
        this.isNoImmediate = false;
    const currentTrafficking = this.sdmFormGroup.get("selecttrafficking")?.value || [];
    const hasLaborTrafficking = this.sdmFormGroup.get("physicalAbuse")?.get("ismalpa_labortrafficking")?.value;

    if (hasLaborTrafficking) {
        this.sdmFormGroup.patchValue({
            selecttrafficking: currentTrafficking.includes('LT') ? currentTrafficking : [...currentTrafficking, 'LT'],
            confirmtrafficking: 'Yes'
        });
    } else if (currentTrafficking.includes('LT')) {
        const updatedTrafficking = currentTrafficking.filter((item: string) => item !== 'LT');

        this.sdmFormGroup.patchValue({
            selecttrafficking: updatedTrafficking.length ? updatedTrafficking : null,
            confirmtrafficking: updatedTrafficking.length ? 'Yes' : null
        });
        }
    } 


    // @TM: D-07481
    onChangeMaltreatment(item: any) {
        this.resetResTimeDecision();
        this.sdmFormGroup.patchValue({ providerKnown : null},{ emitEvent: false });
        const intakeStore = this._intakeService.getIntakeStore();
        intakeStore.maltreatmentupdated = true;
        this.sdmFormGroup.patchValue({
            maltreatmentupdated:true
        })
        if (item === 'yes') {
            this.isDisplayProvider = true;
            this.sdmSettings.isoutofhome = true;
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isoutofhome: true });
        } else {
            this.isDisplayProvider = false;
            this.disableAbuseNeg = false;
            this.selectedplacement='';
            this.sdmFormGroup.patchValue({
                isfcplacementsetting: false,
                isprivateplacement: false,
                islicenseddaycare: false,
                isschool: false,
                isfclivingarrangement:false,
            },)
            const control = <FormArray>this.sdmFormGroup.controls['provider'];
            control.controls = [];
            this.sdmSettings.isoutofhome = false;
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isoutofhome: false });
            this.sdmFormGroup.controls['selectedproviderdetails'].reset();
        }
    }

    changeScreenOutIN(item: any) {
        this.isScreenOutIN = item;
    }

    changeOverScreenOutIN(item: any) { 
        if (this.isSaveEnable) {
            this.isScreenOutIN = '';
            this.sdmFormGroup.patchValue({scnRecommendOveride : ""})
            this.sdmFormGroup.controls['screenOut'].reset();
            this.sdmFormGroup.controls['screenIn'].reset();
            return
        }
        if (item === 'Ovrscrnin' && !this.sdmSettings.isDisablescrnin) {
            this.isScreenOutIN = item;
            this.sdmFormGroup.controls['screenOut'].reset();
            this.sdmFormGroup.patchValue({scnRecommendOveride : 'Ovrscrnin'});
        } else if (item=== 'OvrScrnout' && !this.sdmSettings.isDisablescrnout) {
            this.isScreenOutIN = item;
            this.sdmFormGroup.controls['screenIn'].reset();
           this.sdmFormGroup.patchValue({scnRecommendOveride : 'OvrScrnout'})
        } else if (item === ""){
            this.isScreenOutIN = item;
            this.sdmFormGroup.patchValue({scnRecommendOveride : ""})
            this.sdmFormGroup.controls['screenOut'].reset();
            this.sdmFormGroup.controls['screenIn'].reset();
        }
    }

    changeImmediate(item: any) {
        if (this.isSaveEnable) {
            this.sdmFormGroup.get('noImmediateList')?.reset();
            this.sdmFormGroup.get('immediateList')?.reset();
            this.isImmediate = false;
            this.isNoImmediate = false;
            return
        }
        if (item === 'Immediate') {
            this.sdmFormGroup.get('noImmediateList')?.reset();
            this.isImmediate = true;
            this.isNoImmediate = false;
        } else if (item === this.noimmediate) {
            this.sdmFormGroup.get('immediateList')?.reset();
            this.isImmediate = false;
            this.isNoImmediate = true;
        }
    }

    goToNextPage(pageToGo: string) {
        // const pageId = <any>($('#' + pageToGo));
        // pageId.click();
        const pageId:any =document.querySelector('#'+ pageToGo);
        pageId.click();
        
        $('html,body').animate({ scrollTop: 0 }, 'slow');
    }

    clearAllImmediateSelections() {
        this.sdmFormGroup.get('noImmediateList')?.patchValue({
            isnoimmed_physicalabuse: false,
            isnoimmed_sexualabuse: false,
            isnoimmed_neglectresponse: false,
            isnoimmed_mentalinjury: false,
            isnoimmed_substantial_risk: false,
            isnoimmed_risk_harm: false
        });
    }

    setImmediates() {
        if (this.isSaveEnable) {return}
        const sdmForm = this.sdmFormGroup.getRawValue();

        this.cpsImmediatesResponseValidation(sdmForm);
        const noImmediateList = sdmForm.noImmediateList;

        if (noImmediateList.isnoimmed_screeninoverride) {
            this.sdmFormGroup?.get('noImmediateList')?.get('isnoimmed_screeninoverride')?.disable();
        }
        this.sdmFormGroup.get('noImmediateList')?.disable();
    }

    changeChildInderOneYear(item: any) {
        this.isChildInderOneYear = item;
        this.validateIRAR(this.sdmFormGroup.getRawValue());
    }

    validateRiskForm(event: any) {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        this.resetResTimeDecision();
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

        if (riskofHarm.isnegrh_priordeath || riskofHarm.isnegrh_exposednewborn ||
            riskofHarm.isnegrh_basicneedsunmet || riskofHarm.isnegrh_sex_offender || riskofHarm.isdomesticvoilence||
            riskofHarm.isnegrh_risk_dv || riskofHarm.isnegrh_fatality_can ||
            riskofHarm.isnegrh_indicated_unsub || riskofHarm.isnegrh_survivor ||
            riskofHarm.isnegrh_birth_match || riskofHarm.isnegrh_sex_trafficking) {
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'accept_as_noncps'
                    //,isfinalscreenin: 'Ovr_as_noncps'
                }, { emitEvent: true });
        }
    }

          // get the latest value for Failure to Protect
          validateFailureToProtect(event: any) {
            this.resetResTimeDecision();
            if (this.sdm.isnegfp_cargiverintervene=== true) {
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'Scrnin',
                }, { emitEvent: true });
            }
        }

    // D-07475: re-writing validations as indicated
    private cpsResponseValidation(sdm: any) {
        this.populateSdm = Object.assign({}, sdm);
        this.sdmFormGroup.patchValue({
            screeningRecommend: 'ScreenOUT',
            isfinalscreenin: 'false',
        }, { emitEvent: false });
        this.scrninFlag = false;

        this.checkSexualAbuseFn();
        this.checkPhysicalAbuseFn();
        this.checkGeneralNeglectFn();

        if (this.populateSdm.isnegfp_cargiverintervene === true) {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
            }, { emitEvent: false });
            this.scrninFlag = true;
        } else {
            this.sdmFormGroup.patchValue({ isnegfp_cargiverintervene: false },
                { emitEvent: false });
        }

        if ((ObjectUtils.checkTrueProperty(this.populateSdm.arGeneralNeglect) ?? 0) >= 1) { // AR General Neglect
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
            }, { emitEvent: false });
            this.scrninFlag = true;
        }
        if (this.populateSdm.ismenab_psycologicalability === true || this.populateSdm.ismenng_psycologicalability === true) { // Mental Abuse or Neglect
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
            }, { emitEvent: false });
            this.scrninFlag = true;

            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isreportmeets: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isreportmeets: false }, { emitEvent: false });
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.riskofHarm) ?? 0) >= 1) { // Risk of Harm
            if (!this.scrninFlag) {
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'accept_as_noncps',
                    isfinalscreenin: 'Ovr_as_noncps',
                }, { emitEvent: false });
                this.disableDQ = true;
            } else if (this.scrninFlag) {
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'Scrnin',
                    isfinalscreenin: 'true',
                }, { emitEvent: false });
                this.disableDQ = false;
            } else {
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'ScreenOUT',
                    isfinalscreenin: 'false',
                }, { emitEvent: false });
                this.disableDQ = true;
            }
        }
        this.validateCPSIRAR(this.sdmFormGroup.getRawValue());
        this.validateIRARScreenIn();
         this.checkLabourTrafickng();
    }
    // Associated to cpsResponseValidation function
    private checkSexualAbuseFn() {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.sexualAbuse) ?? 0) >= 1) { // Sexual Abuse - any selection
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
            }, { emitEvent: false });
            this.scrninFlag = true;

            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issexualabuse: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issexualabuse: false }, { emitEvent: false });
        }
            }
     private checkLabourTrafickng() {
        if (this.populateSdm.physicalAbuse.ismalpa_labortrafficking) { // Labor Trafficking - any selection
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ islabortrafficking: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ islabortrafficking: false }, { emitEvent: false });
        }
    }
    // Associated to cpsResponseValidation function
    private checkPhysicalAbuseFn() {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.physicalAbuse) ?? 0) >= 1) { // Physical Abuse
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
            }, { emitEvent: false });
            this.scrninFlag = true;

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

            if (!this.truePropertyGNFlag) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: false }, { emitEvent: false });
            }
            this.truePropertyPAFlag = false;
        }
    }
    // Associated to cpsResponseValidation function
    private checkGeneralNeglectFn() {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.generalNeglect) ?? 0) >= 1) { // General Neglect
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
            }, { emitEvent: false });
            this.scrninFlag = true;

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

            if (!this.truePropertyPAFlag) {
                this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ isdeathorserious: false }, { emitEvent: false });
            }
            this.truePropertyGNFlag = false;

            this.sdmFormGroup.controls['disqualifyingCriteria'].patchValue({ issignordiagonises: false }, { emitEvent: false });
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
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.generalNeglect) ?? 0) >= 1 || 
        (ObjectUtils.checkTrueProperty(this.populateSdm.arGeneralNeglect) ?? 0) >= 1 || 
        (ObjectUtils.checkTrueProperty(this.populateSdm.unattendedChild) ?? 0) >=1 || 
        this.populateSdm.isnegfp_cargiverintervene ||this.populateSdm.isnegab_abandoned ||
            this.populateSdm.isnegmn_unreasonabledelay)  { // General Neglect
            this.noImmediateList.isnoimmed_neglectresponse = true;
        } else {
            this.noImmediateList.isnoimmed_neglectresponse = false;
        }
        if (this.populateSdm.ismenab_psycologicalability === true || this.populateSdm.ismenng_psycologicalability === true) { // Mental Abuse or Neglect
            this.noImmediateList.isnoimmed_mentalinjury = true;
        } else {
            this.noImmediateList.isnoimmed_mentalinjury = false;
        }
        this.checkRiskOfHarmCondFn();
    }

    private checkRiskOfHarmCondFn() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.riskofHarm) ?? 0) >= 1) { // Risk of Harm            
            this.noImmediateList.isnoimmed_risk_harm = true;
        } else {
            this.noImmediateList.isnoimmed_risk_harm = false;
        }
        if (this.populateSdm.riskofHarm.isnegrh_exposednewborn === true) { // Sen Exposed Child
            this.noImmediateList.isnoimmed_substantial_risk = true;
        } else {
            this.noImmediateList.isnoimmed_substantial_risk = false;
        }
    }

     // Immediates auto-selection - unless it is a manual override
     private cpsImmediatesResponseValidation(sdm: any) {
        this.populateSdm = Object.assign({}, sdm);
        this.sdmFormGroup.controls['noImmediateList'].enable();
        this.scrninFlag = false;

        if ((ObjectUtils.checkTrueProperty(this.populateSdm.sexualAbuse) ?? 0) >= 1) { // Sexual Abuse - any selection
            this.sdmFormGroup.patchValue({ immediate: this.noimmediate }, { emitEvent: false });
            this.scrninFlag = true;

            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: false }, { emitEvent: false });
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.physicalAbuse) ?? 0) >= 1) { // Physical Abuse
            this.sdmFormGroup.patchValue({ immediate: this.noimmediate }, { emitEvent: false });
            this.scrninFlag = true;

            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_physicalabuse: true }, { emitEvent: false });

        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_physicalabuse: false }, { emitEvent: false });
        }
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.generalNeglect) ?? 0) >= 1 || 
        (ObjectUtils.checkTrueProperty(this.populateSdm.arGeneralNeglect) ?? 0) >= 1 || 
        (ObjectUtils.checkTrueProperty(this.populateSdm.unattendedChild) ?? 0) >=1 || 
        this.populateSdm.isnegfp_cargiverintervene || this.populateSdm.isnegab_abandoned || this.populateSdm.isnegmn_unreasonabledelay) { // General Neglect
            this.sdmFormGroup.patchValue({ immediate: this.noimmediate }, { emitEvent: false });
            this.scrninFlag = true;

            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: true }, { emitEvent: false });

        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: false }, { emitEvent: false });
        }
        if (this.populateSdm.ismenab_psycologicalability === true || this.populateSdm.ismenng_psycologicalability === true) { // Mental Abuse or Neglect
            this.sdmFormGroup.patchValue({ immediate: this.noimmediate }, { emitEvent: false });
            this.scrninFlag = true;

            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: false }, { emitEvent: false });
        }
        this.checkRiskofHarmFn();

        if (this.populateSdm.riskofHarm.isnegrh_exposednewborn === true) { // Sen Exposed Child
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: true }, { emitEvent: false });
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: false }, { emitEvent: false });
        }

        this.populateNoImmediateListAuto();
        this.validateSDM(this.sdmFormGroup.getRawValue());
        this._store.setData(IntakeStoreConstants.intakeSDM, this.addSdm);
    }
    // Associated to cpsImmediatesResponseValidation function
    private checkRiskofHarmFn() {
        if ((ObjectUtils.checkTrueProperty(this.populateSdm.riskofHarm) ?? 0) >= 1) { // Risk of Harm
            this.sdmFormGroup.patchValue({ immediate: this.noimmediate }, { emitEvent: false });
            this.reusableCheckRiskofHarmFn();
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false }, { emitEvent: false });
        }
    }

    private setCPSImmediates() {
        this.scrninFlag = false;
        this.updatingImmediates = true;
        const sdm = Object.assign({}, this.sdmFormGroup.getRawValue());
        if ((ObjectUtils.checkTrueProperty(sdm.sexualAbuse) ?? 0) >= 1) {
            this.scrninFlag = true;
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_sexualabuse: false }, { emitEvent: false });
        }
        if ((ObjectUtils.checkTrueProperty(sdm.physicalAbuse) ?? 0) >= 1) {
            this.scrninFlag = true;
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_physicalabuse: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_physicalabuse: false }, { emitEvent: false });
        }
        if ((ObjectUtils.checkTrueProperty(sdm.generalNeglect) ?? 0) >= 1 || (ObjectUtils.checkTrueProperty(sdm.arGeneralNeglect) ?? 0) >= 1 || (ObjectUtils.checkTrueProperty(
            this.populateSdm.unattendedChild) ?? 0) >=1||this.populateSdm.isnegfp_cargiverintervene ||this.populateSdm.isnegab_abandoned ||
            this.populateSdm.isnegmn_unreasonabledelay) {
            this.scrninFlag = true;
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_neglectresponse: false }, { emitEvent: false });
        }
        if (sdm.ismenab_psycologicalability === true || sdm.ismenng_psycologicalability === true) {
            this.scrninFlag = true;
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: true }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_mentalinjury: false }, { emitEvent: false });
        }
        if ((ObjectUtils.checkTrueProperty(sdm.riskofHarm) ?? 0) >= 1) {
            this.reusableCheckRiskofHarmFn();
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false }, { emitEvent: false });
        }

        if (sdm.riskofHarm.isnegrh_exposednewborn === true) { // Sen Exposed Child
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: true }, { emitEvent: false });
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: false }, { emitEvent: false });
        } else {
            this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_substantial_risk: false }, { emitEvent: false });
        }
        this.populateNoImmediateListAuto();
        this.updatingImmediates = false;
    }
    // Associated to cpsImmediatesResponseValidation and setCPSImmediates function
    private reusableCheckRiskofHarmFn() {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if (!this.scrninFlag) {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'accept_as_noncps',
                isfinalscreenin: 'Ovr_as_noncps',
            }, { emitEvent: false });
            this.disableDQ = true;
        } else if (this.scrninFlag) {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
            }, { emitEvent: false });
            this.disableDQ = false;
        } else {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'ScreenOUT',
                isfinalscreenin: 'false',
            }, { emitEvent: false });
            this.disableDQ = true;
        }
        this.sdmFormGroup.controls['noImmediateList'].patchValue({ isnoimmed_risk_harm: true }, { emitEvent: false });
    }

    private validateOverrideDays(date: any) {
        const start_date = moment(date, 'YYYY-MM-DD');
        const end_date = moment(new Date(), 'YYYY-MM-DD');
        const duration = moment.duration(end_date.diff(start_date)).asDays();
        if (duration) {
            this.dayToOverride = 60 - Math.ceil(duration);
            if (this.dayToOverride > 0) {
                this.sdmSettings.isDisableOverride = false;
            } else {
                this.sdmSettings.isDisableOverride = true;
            }
        }
        this.updateFormControlsOverides(this.sdmSettings.isDisableOverride);
    }

    // @TM : Changes to SDM validations to identify CPS Response as AR or IR
    validateIRAR(sdm: Sdm) {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if (sdm.scnRecommendOveride !== '') { // validation for Screen-In/Out override
            if (sdm.scnRecommendOveride === 'Ovrscrnin') {
                this.disableDQ = false;
                this.validateIRARScreenIn();
                this.sdmFormGroup.patchValue({ isfinalscreenin: 'true' }, { emitEvent: false });
            } else if (sdm.scnRecommendOveride === 'OvrScrnout') {
                this.disableDQ = true;
                // this.validateIRARScreenOut();
                this.sdmFormGroup.patchValue({ isfinalscreenin: 'false'}, { emitEvent: false });
            } else {
                this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
            }
        } else if (sdm.screeningRecommend === 'Scrnin') {
            this.disableDQ = false;
            this.validateIRARScreenIn();
        } else if (ObjectUtils.checkTrueProperty(sdm.disqualifyingCriteria)) { // This is redundant but avoids validating all other checkboxes if none selected under SDM
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
        } else if (ObjectUtils.checkTrueProperty(sdm.disqualifyingFactors)) {
            this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
        } else {
            this.disableDQ = true;
            this.validateIRARScreenOut();
        }
        if (this.isChildInderOneYear === 'Yes' || (this.childFatality === 'yes' &&  this.sdmFormGroup.getRawValue().childfatality === 'yes')) {
            const purpose = this._store?.getData(IntakeStoreConstants.purposeSelected);
            if(![MyNewintakeConstants.PURPOSE.ROA_CPS, MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL, MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES].includes(purpose?.code)) {
                this.sdmFormGroup.patchValue({ cpsResponseType: 'CPS-IR' }, { emitEvent: false });
            }
        }
    }

    validateIRARScreenIn() { // if Screen In or Over-ride Screen In
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        const disqualifyingCriteria = (this.sdm.disqualifyingCriteria) ? this.sdm.disqualifyingCriteria : new Disqualifyingcriteria();
        if (this.CPSFlag === 'disable') {       //@TM: not sure why this condition was applied, verify
            this.ifCpsFlagDisabledFn();
        } else {
            this.elseCpsFlagDisabledFn(disqualifyingCriteria);
        }

        if (                                                              // ------------------------AR Conditions
            !this.isIRFlag &&
            (
            this.sdm.physicalAbuse.ismalpa_caregiver ||
            this.sdm.physicalAbuse.ismalpa_childtoxic ||
            this.sdm.physicalAbuse.ismalpa_injuryinconsistent ||
            this.sdm.physicalAbuse.ismalpa_insjury ||
            this.sdm.physicalAbuse.ismalpa_nonaccident ||
             this.sdm.physicalAbuse.ismalpa_labortrafficking ||
            this.sdm.generalNeglect.isneggn_inadequatefood ||
            this.sdm.arGeneralNeglect.isneggn_exposuretounsafe ||
            this.sdm.arGeneralNeglect.isneggn_inadequateclothing ||
            this.sdm.arGeneralNeglect.isneggn_inadequatesupervision ||
            this.sdm.arGeneralNeglect.isnegrh_treatmenthealthrisk ||
            this.sdm.generalNeglect.isneggn_childdischarged ||
            this.sdm.isnegfp_cargiverintervene ||
            this.sdm.isnegab_abandoned ||
            this.sdm.unattendedChild.isneguc_leftaloneinappropriatecare ||
            this.sdm.unattendedChild.isneguc_leftalonewithoutsupport ||
            this.sdm.unattendedChild.isneguc_leftunsupervised ||
            this.sdm.isnegmn_unreasonabledelay
            )
        ) {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
                cpsResponseType: 'CPS-AR', }, { emitEvent: false });

        } else if (this.isIRFlag) {
            if(this.isOnlyProviderInvolved()){
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'ScreenOUT',
                    isfinalscreenin: 'false',
                    cpsResponseType: 'CPS-IR', }, { emitEvent: false });
             } else{
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'Scrnin',
                    isfinalscreenin: 'true',
                    cpsResponseType: 'CPS-IR', }, { emitEvent: false });}
        } else {
            this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
        }
    }
    // Associated to validateIRARScreenIn function
    private elseCpsFlagDisabledFn(disqualifyingCriteria: Disqualifyingcriteria) {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if ( // ----------IR Conditions
            !this.sdm.physicalAbuse.ismalpa_suspeciousdeath &&
            !this.sdm.generalNeglect.isneggn_suspiciousdeath &&
            !this.sdm.generalNeglect.isneggn_signsordiagnosis &&
            !this.sdm.ismenab_psycologicalability &&
            !this.sdm.ismenng_psycologicalability &&
            !this.sdm.sexualAbuse.ismalsa_physicalindicators &&
            !this.sdm.sexualAbuse.ismalsa_sex_trafficking &&
            !this.sdm.sexualAbuse.ismalsa_sexualact &&
            !this.sdm.sexualAbuse.ismalsa_sexualexploitation &&
            !this.sdm.sexualAbuse.ismalsa_sexualmolestation &&
            // Mandatory Disqualifying Criteria - this is still required to ensure correct precedence
            !disqualifyingCriteria.isrisk &&
            !disqualifyingCriteria.ismaltreatment3yrs &&
            !disqualifyingCriteria.ismaltreatment12yrs &&
            !disqualifyingCriteria.ismaltreatment24yrs &&
            !disqualifyingCriteria.isactiveinvestigation &&
            !disqualifyingCriteria.isdeathorserious &&
             !disqualifyingCriteria.islabortrafficking &&
            !disqualifyingCriteria.isoutofhome &&
            !disqualifyingCriteria.isreportmeets &&
            !disqualifyingCriteria.issexualabuse &&
            !disqualifyingCriteria.issignordiagonises &&
            // Discretionary Disqualifying Factors - this is still required to ensure correct precedence
            !this.sdm.disqualifyingFactors.isreportedhistory &&
            !this.sdm.disqualifyingFactors.ismultiple &&
            !this.sdm.disqualifyingFactors.isdomesticvoilence &&
            !this.sdm.disqualifyingFactors.iscriminalhistory &&
            !this.sdm.disqualifyingFactors.isthread &&
            !this.sdm.disqualifyingFactors.islawenforcement &&
            !this.sdm.disqualifyingFactors.iscourtiinvestigation) {
            this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
            this.isIRFlag = false;
        } else if (this.sdm.physicalAbuse.ismalpa_suspeciousdeath ||
            this.sdm.generalNeglect.isneggn_suspiciousdeath ||
            this.sdm.generalNeglect.isneggn_signsordiagnosis ||
            this.sdm.ismenab_psycologicalability ||
            this.sdm.ismenng_psycologicalability ||
            this.sdm.sexualAbuse.ismalsa_physicalindicators ||
            this.sdm.sexualAbuse.ismalsa_sex_trafficking ||
            this.sdm.sexualAbuse.ismalsa_sexualact ||
            this.sdm.sexualAbuse.ismalsa_sexualexploitation ||
            this.sdm.sexualAbuse.ismalsa_sexualmolestation ||
            // Disqualifying Criteria - this is still required to ensure correct precedence
            disqualifyingCriteria.isrisk ||
            disqualifyingCriteria.ismaltreatment3yrs ||
            disqualifyingCriteria.ismaltreatment12yrs ||
            disqualifyingCriteria.ismaltreatment24yrs ||
            disqualifyingCriteria.isactiveinvestigation ||
            disqualifyingCriteria.isdeathorserious ||
            disqualifyingCriteria.islabortrafficking ||
            disqualifyingCriteria.isoutofhome ||
            disqualifyingCriteria.isreportmeets ||
            disqualifyingCriteria.issexualabuse ||
            disqualifyingCriteria.issignordiagonises ||
            // Discretionary Disqualifying Factors - this is still required to ensure correct precedence
            this.sdm.disqualifyingFactors.isreportedhistory ||
            this.sdm.disqualifyingFactors.ismultiple ||
            this.sdm.disqualifyingFactors.isdomesticvoilence ||
            this.sdm.disqualifyingFactors.iscriminalhistory ||
            this.sdm.disqualifyingFactors.isthread ||
            this.sdm.disqualifyingFactors.islawenforcement ||
            this.sdm.disqualifyingFactors.iscourtiinvestigation) {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
                cpsResponseType: 'CPS-IR',
            }, { emitEvent: false });
            this.isIRFlag = true;
        }
    }
    // Associated to validateIRARScreenIn function
    private ifCpsFlagDisabledFn() {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if ( // ----------IR Conditions
            !this.sdm.physicalAbuse.ismalpa_suspeciousdeath &&
            !this.sdm.generalNeglect.isneggn_suspiciousdeath &&
            !this.sdm.generalNeglect.isneggn_signsordiagnosis &&
            !this.sdm.ismenab_psycologicalability &&
            !this.sdm.ismenng_psycologicalability &&
            !this.sdm.sexualAbuse.ismalsa_physicalindicators &&
            !this.sdm.sexualAbuse.ismalsa_sex_trafficking &&
            !this.sdm.sexualAbuse.ismalsa_sexualact &&
            !this.sdm.sexualAbuse.ismalsa_sexualexploitation &&
            !this.sdm.sexualAbuse.ismalsa_sexualmolestation) {
            this.sdmFormGroup.patchValue({ cpsResponseType: null }, { emitEvent: false });
            this.isIRFlag = false;
        } else if (this.sdm.physicalAbuse.ismalpa_suspeciousdeath ||
            this.sdm.generalNeglect.isneggn_suspiciousdeath ||
            this.sdm.generalNeglect.isneggn_signsordiagnosis ||
            this.sdm.ismenab_psycologicalability ||
            this.sdm.ismenng_psycologicalability ||
            this.sdm.sexualAbuse.ismalsa_physicalindicators ||
            this.sdm.sexualAbuse.ismalsa_sex_trafficking ||
            this.sdm.sexualAbuse.ismalsa_sexualact ||
            this.sdm.sexualAbuse.ismalsa_sexualexploitation ||
            this.sdm.sexualAbuse.ismalsa_sexualmolestation) {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'Scrnin',
                isfinalscreenin: 'true',
                cpsResponseType: 'CPS-IR',
            }, { emitEvent: false });
            this.isIRFlag = true;
        }
    }

    validateIRARScreenOut() {
        this.sdmFormGroup.patchValue({
            cpsResponseType: null,
        }, { emitEvent: false });
    }

    validateChildFatality(childfatality: any) {
        this._store.setData(IntakeStoreConstants.childfatalityUpdate, {value: childfatality, isUpdated: false});
        let childFatality = this._store.getData(IntakeStoreConstants.childfatalityUpdate);
        const sdmdata = this.store[IntakeStoreConstants.intakeSDM];
        if(!this.v_childfatality) {
            this.v_childfatality = (sdmdata) ? (sdmdata?.childfatality) : '';
        }
        if (!this.childfatalityflag && childfatality === 'yes') {
            setTimeout(() => {
                 this.sdmFormGroup.patchValue({
                childfatality:''},{emitEvent :false});
            }, 1000);
            this._alertService.error('Please update child profile with valid D.O.D to proceed.');
            childfatality=childFatality?.value;
          
        } else if (this.childfatalityflag && childfatality === 'no') {
            this._alertService.error('Child profile have a valid D.O.D please update child profile to proceed.');
            this.sdmFormGroup.patchValue({ childfatality: 'yes' },{emitEvent :false});
            childfatality= childFatality?.value;
            if(this.v_childfatality !=  this.sdmFormGroup.get('childfatality')?.value) {
                this._store.setData(IntakeStoreConstants.childfatalityUpdate, {value: 'yes', isUpdated: true});
                sdmdata.childfatalityupdated = true;
                sdmdata.childfatality = 'yes';
                this.store.setData(IntakeStoreConstants.intakeSDM, sdmdata);
            }
            
        }
            this._store.setData(
            IntakeStoreConstants.childfatalityUpdate,
            {value: childfatality, isUpdated: true}
        );
    }

    unattendedChildChange(){
        if(this.sdm.unattendedChild.isneguc_leftaloneinappropriatecare){
            this.sdmFormGroup.patchValue({
                immediate: this.noimmediate,
            }, { emitEvent: false });
            this.sdmFormGroup.get('immediateList')?.reset();
            this.isImmediate = false;
            this.isNoImmediate = true;
            this.sdmFormGroup.get('noImmediateList')?.patchValue({
                isnoimmed_neglectresponse : true
            });
        }else{
            this.sdmFormGroup.patchValue({
                immediate: '',
            }, { emitEvent: false });
            this.sdmFormGroup.get('immediateList')?.reset();
            this.isNoImmediate = false;
        }
    }


    medicalneglect(){
        if(this.sdm.isnegmn_unreasonabledelay){
            this.sdmFormGroup.patchValue({
                immediate: this.noimmediate,
            }, { emitEvent: false });
            this.sdmFormGroup.get('immediateList')?.reset();
            this.isImmediate = false;
            this.isNoImmediate = true;
            this.sdmFormGroup.get('noImmediateList')?.patchValue({
                isnoimmed_neglectresponse : true
            });
        }else{
            this.sdmFormGroup.patchValue({
                immediate: '',
            }, { emitEvent: false });
            this.sdmFormGroup.get('immediateList')?.reset();
            this.isNoImmediate = false;
        }
    }


    validateSDM(sdm: any) {
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

        if (sdm?.cpsResponseType === 'CPS-IR') {
            sdm.isir = true;
            sdm.isar = false;
        } else if (sdm?.cpsResponseType === 'CPS-AR') {
            sdm.isir = false;
            sdm.isar = true;
        } else {
            this.validateCPSIRAR(sdm);
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

        this.checkScreeningRecommendFn(sdm);
        this.checkDuplicatereportflagFn(sdm);
        this.setChildfatality(sdm);
        this.addSdm = sdm;
    }
    // Associated to validateIRARScreenIn function
    private checkDuplicatereportflagFn(sdm: any) {
        if (sdm.duplicatereportflag) {
            sdm.duplicatereportflag = 1;
        } else if (!sdm.duplicatereportflag) {
            sdm.duplicatereportflag = 0;
        } else {
            sdm.duplicatereportflag = null;
        }

        if (sdm.screenOut.duplicatereportflag) {
            sdm.screenOut.duplicatereportflag = 1;
        } else if (!sdm.screenOut.duplicatereportflag) {
            sdm.screenOut.duplicatereportflag = 0;
        } else {
            sdm.screenOut.duplicatereportflag = null;
        }
    }
    // Associated to validateIRARScreenIn function
    private checkScreeningRecommendFn(sdm: any) {
        if (sdm.screeningRecommend === 'ScreenOUT') {
            sdm.isrecsc_screenout = true;
            sdm.isrecsc_scrrenin = false;
        } else if (sdm.screeningRecommend === 'Scrnin') {
            sdm.isrecsc_screenout = false;
            sdm.isrecsc_scrrenin = true;
        } else if (sdm.screeningRecommend === 'accept_as_noncps') {
            sdm.isrecsc_screenout = false;
            sdm.isrecsc_scrrenin = false;
        }
    }

    validateCPSIRAR(sdm: any) {
        if (this.supervisorStatus && this.supervisorStatus === 'Approved'){
            return;
        }
        if (this.isSaveEnable) {
            this.sdmFormGroup.patchValue({
                    isfinalscreenin: false,
                    screeningRecommend: false
                }, { emitEvent: false });
            return;
        }
        if (sdm.scnRecommendOveride !== '') {
            if (sdm.scnRecommendOveride === 'Ovrscrnin') {
                this.sdmFormGroup.patchValue({
                    isfinalscreenin: 'true'
                }, { emitEvent: false });
                sdm.isir = true;
                sdm.isar = false;
                this.disableDQ = false;
            } else if (sdm.scnRecommendOveride === 'OvrScrnout') {
                this.sdmFormGroup.patchValue({
                    isfinalscreenin: 'false'
                }, { emitEvent: false });
                // sdm.isir = false;
                // sdm.isar = false;
                this.disableDQ = true;
            }
        } else {
            if (sdm.cpsResponseType === 'CPS-IR') {
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'Scrnin',
                }, { emitEvent: false });
                sdm.isir = true;
                sdm.isar = false;
                this.disableDQ = false;
            } else if (sdm.cpsResponseType === 'CPS-AR') {
                this.sdmFormGroup.patchValue({
                    screeningRecommend: 'Scrnin',
                }, { emitEvent: false });
                sdm.isir = false;
                sdm.isar = true;
                this.disableDQ = false;
            } else {  // Risk of harm is non cps case , hence "Non  CPS" should be selceted
                if((ObjectUtils.checkTrueProperty(this.populateSdm.riskofHarm) ?? 0) < 1){
              this.sdmFormGroup.patchValue({
                    screeningRecommend: 'ScreenOUT',
                }, { emitEvent: false });
            }
                sdm.isir = false;
                sdm.isar = false;
                this.disableDQ = true;
            }
        }

        if (this.isSENFlag) {
            this.sdmFormGroup.patchValue({
                screeningRecommend: 'accept_as_noncps',
                isfinalscreenin: 'Ovr_as_noncps'
            }, { emitEvent: false });
            sdm.isir = false;
            sdm.isar = false;
            this.disableDQ = true;
        }
    }

    // setRecomNOverds() {
    //     const immediateValue = this.sdmFormGroup.get('immediate').value;
    //     if (immediateValue !== 'Immediate') {
    //         this.setImmediates();
    //     }
    // }

    onMaltreatorChange(key: any, event: any, onlychecked?: any) {
        this.sdmFormGroup.get('provider')?.reset();
        this.sdmFormGroup.controls['selectedproviderdetails'].reset();

        this.sdmFormGroup.setControl('provider', this.formBuilder.array([]));
        this.checkIfOnlyCheckedFn(onlychecked);
        this.Providerplacement = [];
        this.Providerplacementdetails = [];
        this.Providerdetails = [];
        this.showprovider = false;
        this.sdmFormGroup.patchValue({ providerdetails: null }, { emitEvent: false });
        this.selectedplacement = '';
        if (event.checked) {
            this.sdmFormGroup.patchValue({
                isfcplacementsetting: false,
                isprivateplacement: false,
                islicenseddaycare: false,
                isschool: false,
                isfclivingarrangement: false,
            }, { emitEvent: false });
            this.sdmFormGroup.get(key)?.setValue(event.checked);
        }
        this.checkPlacementCondFn();
        if (this.sdmFormGroup.get('isfcplacementsetting')?.value || this.sdmFormGroup.get('isprivateplacement')?.value) {
            this.livingarrangement = false;
            this.showdropdown = true;
            const familybased = this.sdmFormGroup.get('isfcplacementsetting')?.value;
            const nonfamilybased = this.sdmFormGroup.get('isprivateplacement')?.value
            forkJoin(this.allegedVictimId.map((av:any) => {
                this._commonHttpService
                    .getSingle(
                        {
                            where: { personid: av.personid },
                            method: 'get'
                        },

                        'placement/getplacementbyperson?filter'
                    )
                    .subscribe((data:any) => {
                        if (data) {
                            this.getplacementApiIfKeyIsPRPLFn(familybased, data, nonfamilybased);

                        } else {
                            return;
                        }
                    });
            }))
        } else if (this.sdmFormGroup.get('isfclivingarrangement')?.value) {
            this.livingarrangement = true;
            this.ischeckboxMandatory = true;
            this.islivingmandatory = true;
            this.showdropdown = true;
            this.Providerdetails = [];
            forkJoin(this.allegedVictimId.map((av:any) => {
                this._commonHttpService
                    .getSingle(
                        {
                            where: { personid: av.personid },
                            method: 'get'
                        },

                        'placement/getplacementbyperson?filter'
                    )
                    .subscribe(data => {
                        if (data) {
                            this.getplacementApiIfKeyIsLAFn(data);
                        } else {
                            return;
                        }
                    });
            }))

        } else {
            this.showdropdown = false;
        }
    }
    // Associated to onMaltreatorChange function
    private checkIfOnlyCheckedFn(onlychecked: any) {
        if (onlychecked) {
            const intakeStore = this._intakeService.getIntakeStore();
            intakeStore.maltreatmentupdated = true;
            this.sdmFormGroup.patchValue({
                maltreatmentupdated: true
            });
        } else {
            const intakeStore = this._intakeService.getIntakeStore();
            intakeStore.maltreatmentupdated = false;
            this.sdmFormGroup.patchValue({
                maltreatmentupdated: false
            });
        }
    }
    // Associated to onMaltreatorChange function
    private getplacementApiIfKeyIsLAFn(data: any) {
        this.Providerdetails = data.filter((item: any) => item.placementtypekey === "LA" && item.isvoided !== 1 && item.routingstatus === "Approved");
        this.Providerplacementdetails.push(...this.Providerdetails);
        this.providerChange(this.selectedplacement);
    }
    // Associated to onMaltreatorChange function
    private getplacementApiIfKeyIsPRPLFn(familybased: any, data: any, nonfamilybased: any) {
        if (familybased) {
            this.Providerdetails = data.filter((item: any) => (item?.providerdetails) && item.placementtypekey === "PRPL" && item.isvoided === 0 && item.routingstatus === "Approved" && (item.service_id === 9 || item.service_id === 11 || item.service_id === 501 || item.service_id === 525 || item.service_id === 13 || item.service_id === 8 || item.service_id === 500 || item.service_id === 10 || item.service_id === 9 || item.service_id === 167 || item.service_id === 11405 || item.service_id === 11406 || item.service_id === 11407
                || item.service_id === 11408 || item.service_id === 78 || item.service_id === 12));
            this.Providerplacementdetails.push(...this.Providerdetails);
        } else if (nonfamilybased) {
            this.Providerdetails = data.filter((item: any) => (item?.providerdetails) && item.placementtypekey === "PRPL" && item.isvoided === 0 && item.routingstatus === "Approved" && (item.service_id === 1 || item.service_id === 74 || item.service_id === 15 || item.service_id === 1 || item.service_id === 14 || item.service_id === 76 || item.service_id === 75));
            this.Providerplacementdetails.push(...this.Providerdetails);
        }
        this.providerChange(this.selectedplacement);
    }
    // Associated to onMaltreatorChange function
    private checkPlacementCondFn() {
        if (this.sdmFormGroup.get('isfcplacementsetting')?.value || this.sdmFormGroup.get('isprivateplacement')?.value) {

            this.isMandatory = true;
            this.ischeckboxMandatory = true;
        }

        else {
            this.isMandatory = false;
            this.ischeckboxMandatory = false;
        }
    }

    allegedVictimReset() {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        if (addedPersons && addedPersons.length) {
            this.childunderoneyearflag = false;
            addedPersons.forEach((item: any) => {
                this.addedPersonsAVForEachFn(item);
            });
        }
        const control = <FormArray>this.sdmFormGroup.controls.allegedvictim;
        if (this.allegedVictim) {
            this.allegedVictim.forEach((x) => {
                control.push(this.buildAllegedVictimForm(x));
            });
        }


    }
    // Associated to allegedVictimReset function
    private addedPersonsAVForEachFn(item: any) {
        item.personRole.forEach((roleval: any) => {
            if (roleval.rolekey === 'AV') {
                this.sdmFormGroup.setControl('allegedvictim', this.formBuilder.array([]));
                this.allegedVictim = this.allegedVictim && this.allegedVictim.length !== 0 ? this.allegedVictim : [{ victimname: item.fullName }];
                const avData = this.allegedVictim.filter((name) => name.victimname === item.fullName);
                if (avData.length === 0) {
                    const allegedV = {
                        victimname: item.fullName
                    };
                    this.allegedVictim.push(allegedV);
                }
                this.sdmFormGroup.get('allegedvictim')?.disable();
            }
        });
    }

    allegedMaltreatorReset() {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        if (addedPersons && addedPersons.length) {
            this.childunderoneyearflag = false;
            addedPersons.map((item: any) => {
                this.addedPersonsAMForEachFn(item);
            });
        }
        const allegedMaltreatorControl = <FormArray>this.sdmFormGroup.controls.allegedmaltreator;
        if (this.allegedMaltreator) {
            this.allegedMaltreator.forEach((x) => {
                allegedMaltreatorControl.push(this.buildAllegedMaltreatorForm(x));
            });
        }
    }
    // Associated to allegedMaltreatorReset function
    private addedPersonsAMForEachFn(item: any) {
        item.personRole.map((rolevalItem: any) => {
            if (rolevalItem.rolekey === 'AM') {
                this.sdmFormGroup.setControl('allegedmaltreator', this.formBuilder.array([]));
                this.allegedMaltreator = this.allegedMaltreator && this.allegedMaltreator.length !== 0 ? this.allegedMaltreator : [{ maltreatorsname: item.fullName }];
                const amData = this.allegedMaltreator.filter((name) => name.maltreatorsname === item.fullName);
                if (amData.length === 0) {
                    const allegedM = {
                        maltreatorsname: item.fullName
                    };
                    this.allegedMaltreator.push(allegedM);
                }
                this.sdmFormGroup.get('allegedmaltreator')?.disable();
            }
        });
    }

    isOnlyProviderInvolved() {
        let result = true;
        this.sdm.disqualifyingFactors.islawenforcement = true;

        if(this.sdm.disqualifyingFactors.islawenforcement){
            result = false;
        }
        if (this.returnTruePropertyRespFn()){
            result = false;
        }
        return result;

    }
    // Assosiated with isOnlyProviderInvolved method
    private returnTruePropertyRespFn() {
        return (((ObjectUtils.checkTrueProperty(this.sdm.sexualAbuse) ?? 0) >= 1) || ((ObjectUtils.checkTrueProperty(this.sdm.physicalAbuse) ?? 0) >= 1) || ((ObjectUtils.checkTrueProperty(this.sdm.generalNeglect) ?? 0) >= 1) || ((ObjectUtils.checkTrueProperty(this.sdm.arGeneralNeglect) ?? 0) >= 1) || (this.sdm.ismenab_psycologicalability === true || this.sdm.ismenng_psycologicalability === true) || ((ObjectUtils.checkTrueProperty(this.sdm.riskofHarm) ?? 0) >= 1) || ((ObjectUtils.checkTrueProperty(this.sdm.disqualifyingCriteria) ?? 0) >= 1));
    }

    private getInvolvedPersons() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._store.getData('iscaseexpunged');
    
        let url = '';

        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        forkJoin([
          this._commonHttpService
            .getPagedArrayList(
              {
                where: {
                    intakenumber: this.intakeNumber,
                    isExpungementSuperUser:isExpungementSuperUser,
                     'iscaseexpunged': iscaseexpunged
                },
                page: 1,
                limit: 50,
                nolimit: true,
                method: 'get'
              },
              url + '?filter'
            )]).subscribe((result) => {
            if (result.length && result[0] && result[0].data) {
                this.involvedPersonListCWApiResFn(result);
            }
        });
    }
    // Associated to getInvolvedPersons function
    private involvedPersonListCWApiResFn(result: any) {
        result[0].data.forEach((element: any) => {
            if (element.birthmatchdetails) {
                element.birthmatchdetails.forEach((item: any) => {
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

    resetProviderChange(event: any) {
        this.sdmFormGroup.get('provider')?.reset();
        const intakeStore = this._intakeService.getIntakeStore();
        intakeStore.maltreatmentupdated = true;
        this.sdmFormGroup.patchValue({
            maltreatmentupdated:true
        })
        this.sdmFormGroup.setControl('provider', this.formBuilder.array([]));
        this.providerChange(event);
    }

    providerChange(event: any) {
        this.selectedproviderId = '';
        this.selectedprovidername = '';
        this.selectedProvideraddress = '';
        this.selectedlivingarrangement = '';
        this.primarycaregiver = '';
        this.livingarraddress = '';
        this.selectedcpaname = ''
        this.selectedcpaaddress = '';
        this.selectedcpaid = '';
        this.cpahome = false;
        if (!this.livingarrangement) {
            this.showprovider = true;
            const index = this.Providerplacementdetails?.findIndex(f => f.placementid === event || f.providerdetails.providername === event);
            if (index > -1) {
                this.selectedplacement = this.Providerplacementdetails[index].providerdetails.providername;
                this.selectedproviderId = this.Providerplacementdetails[index].providerdetails.provider_id;
                this.selectedprovidername = this.Providerplacementdetails[index].providerdetails.providername;
                this.selectedProvideraddress = this.Providerplacementdetails[index].providerdetails.address;
                if (this.Providerplacementdetails[index].cpahomedetails) {
                    this.cpahome = true;
                    this.selectedcpaname = this.Providerplacementdetails[index].cpahomedetails.cpahomename;
                    this.selectedcpaaddress = this.Providerplacementdetails[index].cpahomedetails?.cpahomeaddress;
                    this.selectedcpaid = this.Providerplacementdetails[index].cpahomedetails.caphome_id;

                }

                if (this.Providerplacementdetails && this.Providerplacementdetails.length > 0) {
                    this.sdmFormGroup.patchValue({ 'providerdetails': this.Providerplacementdetails[index].placementid });
                    this.sdmFormGroup.patchValue({ 'selectedproviderdetails': { 'providerdet': this.Providerplacementdetails[index].providerdetails, 'cpahomedet': this.Providerplacementdetails[index].cpahomedetails } });
                }
            }

        }
        this.ifLivingarrangementFn(event);
    }
    // Associated to providerChange function
    private ifLivingarrangementFn(event: any) {
        if (this.livingarrangement) {
            this.showprovider = true;
            const index = this.Providerplacementdetails?.findIndex(f => f.placementid === event);
            if (index > -1) {
                this.selectedplacement = this.Providerplacementdetails[index].livingarrangementtype;
                this.selectedlivingarrangement = this.Providerplacementdetails[index].livingarrangementtype;
                this.primarycaregiver = this.Providerplacementdetails[index].primarycaregiver;
                const {address1,address2,cityname,statetypekey,zipcode} = this.Providerplacementdetails[index]
                const addressParts = [address1,
                    address2,
                    cityname,
                    statetypekey,
                    zipcode].filter(Boolean)
                this.livingarraddress = addressParts.join(', ')
                if (this.Providerplacementdetails && this.Providerplacementdetails.length > 0) {
                    this.sdmFormGroup.patchValue({ 'providerdetails': this.Providerplacementdetails[index].placementid });
                    this.sdmFormGroup.patchValue({
                        'selectedproviderdetails': {
                            'providerdet': this.Providerplacementdetails[index].providerdetails, 'cpahomedet': this.Providerplacementdetails[index].cpahomedetails,
                            'livingarrangement': { 'livingarrangementtype': this.selectedlivingarrangement, 'primarycaregiver': this.primarycaregiver, 'livingarraddress': this.livingarraddress }
                        }
                    });
                    // this.sdmFormGroup.patchValue({'selectedproviderdetails': this.Providerplacementdetails[index].cpahomedetails})
                }
            }
        }
    }

    confirmtraffickingchange(value: any){
        const intakeStore = this._intakeService.getIntakeStore();
        intakeStore.traffickingupdate = true;
        this._intakeService.setIntakeStore(intakeStore);
        this.sdmFormGroup.patchValue({
            traffickingupdated:true,

        })
        if(value ==='NO'){
            this.sdmFormGroup.patchValue({
                selecttrafficking:null,
                 ismalpa_labortrafficking: false,
         })
        }
          this.sdmFormGroup.get("physicalAbuse")?.patchValue({ ismalpa_labortrafficking: false })
        const sdmdata = this.store[IntakeStoreConstants.intakeSDM];
        sdmdata.traffickingupdated = true;
        sdmdata.confirmtrafficking = value;
        this._store.setData(IntakeStoreConstants.intakeSDM, sdmdata);
    }
    selecttraffickingchange(value: any){
        const intakeStore = this._intakeService.getIntakeStore();
        intakeStore.traffickingupdate = true;
        this._intakeService.setIntakeStore(intakeStore);
        this.sdmFormGroup.patchValue({
            traffickingupdated:true

        })
        this.sdmFormGroup.get("physicalAbuse")?.patchValue({ ismalpa_labortrafficking: value.includes("LT") });
        const sdmdata = this.store[IntakeStoreConstants.intakeSDM];
        sdmdata.traffickingupdated = true;
        sdmdata.selecttrafficking = value;
        this._store.setData(IntakeStoreConstants.intakeSDM, sdmdata);
    }
    getsdmtraffickingaudittrail() {
        this.sdmtraffickingauditlist = [];
        this.maltreatmentauditlist = [];
        this.childfatalityauditlist = [];
        const caseDetails = this._dataStore.getData(IntakeStoreConstants.SELECTED_INTAKE_CASE_DETAILS);
        const sdmtraffickingurl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmtraffickingaudittrailUrl
        const request = {

            intakenumber: this.intakeNumber,
            servicerequestnumber: caseDetails ? caseDetails.caseNumber : null,
        };

        this._commonHttpService.getArrayList(
            {
                where: request,
                method: 'get',
                nolimit: true
            },
            sdmtraffickingurl + '?filter'

        ).subscribe(data => {

            if (data && data.length) {
                for (let i = 0; i < data[0].getsdmtraffickingaudittrail.length; i++) {
                    this.objectkeyCheckFn(data, i);
                }
                this.sdmtraffickingauditlist.forEach((value) => {
                    value.selecttrafficking = value?.selecttrafficking?.replace(/["'\[\]]/g, "").replace("ST", 'Sex Trafficking').replace("LT", "Labor Trafficking");
                }
                );
            }
        });

        (<any>$('#sdmtrafficking')).modal('show');
    }

    pageChanged(pageEvent: any) {
        this.paginationInfo.pageNumber = pageEvent.page;
        this.searchProvider();
      }


    private objectkeyCheckFn(data: any[], i: number) {
        if (data[0].getsdmtraffickingaudittrail[i].objectkey == 'maltreatment') {
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
        if (data[0].getsdmtraffickingaudittrail[i].objectkey == 'trafficking') {
            this.sdmtraffickingauditlist.push(data[0].getsdmtraffickingaudittrail[i]);
        }
        if (data[0].getsdmtraffickingaudittrail[i].objectkey == 'childfatality') {
            this.childfatalityauditlist.push(data[0].getsdmtraffickingaudittrail[i]);
        }
        this.cdr.markForCheck();
    }

    updateFormControlsCPSType(disableValue: any) {

        const disqualifyingFactorsControlsList = [
            'isreportedhistory',
            'ismultiple',
            'isdomesticvoilence',
            'iscriminalhistory',
            'isthread',
            'islawenforcement',
            'iscourtiinvestigation'
        ];

        const disqualifyingCriteriaControlsList = [
                'isrisk',
                'ismaltreatment3yrs',
                'ismaltreatment12yrs',
                'ismaltreatment24yrs',
                'isactiveinvestigation'
        ];

        const dqCriteria = this.sdmFormGroup.get('disqualifyingCriteria') as FormGroup;
        const dqFactors = this.sdmFormGroup.get('disqualifyingFactors') as FormGroup;

        disqualifyingFactorsControlsList.forEach((controlName: any) => {
            const control = dqFactors.get(controlName);
            if (control) {
                disableValue ? control.disable({ emitEvent: false }) : control.enable({ emitEvent: false });
            }
        });
        
        disqualifyingCriteriaControlsList.forEach((controlName: any) => {
            const control = dqCriteria.get(controlName);
            if (control) {
                disableValue ? control.disable({ emitEvent: false }) : control.enable({ emitEvent: false });
            }
        });
    }

    // Assosiated with updateFormControlsOverides function
    private ovrscrninFn(screenInList: string[], disableValue: any) {
        const screenInForm = this.sdmFormGroup.get('screenIn') as FormGroup;
        screenInList.forEach((controlName: any) => {
            const control = screenInForm.get(controlName);
            if (control) {
                disableValue ? control.disable({ emitEvent: false }) : control.enable({ emitEvent: false });
            }
        });
    }
    // Assosiated with updateFormControlsOverides function
    private ovrScrnoutFn(screenOutList: string[], disableValue: any) {
        const screenOutForm = this.sdmFormGroup.get('screenOut') as FormGroup;
        screenOutList.forEach((controlName: any) => {
            const control = screenOutForm.get(controlName);
            if (control) {
                disableValue ? control.disable({ emitEvent: false }) : control.enable({ emitEvent: false });
            }
        });
    }

    updateFormControlsOverides(disableValue: any) {
        const list = [
            'scnRecommendOveride',
        ];

        if (this.isScreenOutIN === 'OvrScrnout') {
            const screenOutList = [
                'isscrnoutrecovr_insufficient',
                'isscrnoutrecovr_information',
                'isscrnoutrecovr_historicalinformation',
                'isscrnoutrecovr_otherspecify',
                'scrnout_description'
            ];
            this.ovrScrnoutFn(screenOutList, disableValue);
        } else if (this.isScreenOutIN === 'Ovrscrnin') {
            const screenInList = [
                'isscrninrecovr_courtorder',
                'isscrninrecovr_otherspecify',
                'scrnin_description'
            ];
            this.ovrscrninFn(screenInList, disableValue);
        }

        list.forEach((controlName: any) => {
            const control = this.sdmFormGroup.get(controlName);
            if (control) {
                disableValue ? control.disable({ emitEvent: false }) : control.enable({ emitEvent: false });
            }
        });
    }
    
    getInvolvedPersonsList(intakeNumber: any) {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._store.getData('iscaseexpunged');
        let url = '';
    
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        if (intakeNumber) {
            return this._commonHttpService 
                .getArrayList({
                    method: 'get',
                    where: {
                        intakenumber: intakeNumber,
                        isExpungementSuperUser: isExpungementSuperUser,
                        iscaseexpunged: iscaseexpunged
                    }
                },
                url + '?filter'
                );
        } 
    }

    setChildfatality(sdm: any) {
        if (!this.executed) {
            this.executed = true;
            const purpose = this._store?.getData(IntakeStoreConstants.purposeSelected);
            if([MyNewintakeConstants.PURPOSE.ROA_CPS, MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL, MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES].includes(purpose?.code)) {
                this.sdmFormGroup.disable();
                this.sdmFormGroup.get('childfatality')?.enable();
                this.sdmFormGroup.get('confirmtrafficking')?.enable();
                this.sdmFormGroup.get('selecttrafficking')?.enable();
                this.sdmFormGroup.patchValue({ maltreatment: 'no' });
                this.isSaveEnable = true;
                this.sdmFormGroup.patchValue({ cpsResponseType: null },{ emitEvent: false });
                this.sdmFormGroup.patchValue({ isar: false });
                this.sdmFormGroup.patchValue({ isir: false });
                if(sdm) {
                    sdm.cpsResponseType = null;
                    sdm.isar = false;
                    sdm.isir = false;
                }
                this.childFatilityAudit(this.intakeNumber);
            }
        }
    }

    v_childfatality = '';
    childFatilityAudit(intakeNumber: any) {
        let involvedPersonList = [];
        this.getInvolvedPersonsList(intakeNumber)?.subscribe((data: any) => {
            for (let person of data?.data) {
                if ((person?.dateofdeath) && (person?.roles?.filter((r: any) => ['OTHERCHILD', 'CHILD'].includes(r?.intakeservicerequestpersontypekey))?.length > 0)) {
                    involvedPersonList.push({
                        dateofdeath: person.dateofdeath,
                        cjamspid: person.cjamspid
                    });
                }
            }
            const sdmdata = this.store[IntakeStoreConstants.intakeSDM];
            this.v_childfatality = (involvedPersonList.length) ? 'yes': this.returnChildfatalityFn(sdmdata);
            this.sdmFormGroup.patchValue({ childfatality: this.v_childfatality });
            this.childFatality = this.v_childfatality;
        });

    }
    
    private returnChildfatalityFn(sdmdata: any): string {
        return (sdmdata) ? (sdmdata?.childfatality) : '';
    }

    //1080 refinement
    changeSeriousPhysicalInjury(event: any) {
        // This is intentional
    }

    getCaseDisposition() {
        let isClosed = false;
        if (this._store.getData(IntakeStoreConstants.INTAKE_STATUS) === 'Closed' || this._store.getData(IntakeStoreConstants.INTAKE_STATUS) === 'Completed') {
            isClosed = true;
           } else {
            isClosed = false;
        }
        if (this._store.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)) {
            isClosed = true;
        }

        this.supervisorStatus = null;

        if (!isClosed){
            return;
        }
        let dispositions: any = this.store[IntakeStoreConstants.disposition];
        if (dispositions && Array.isArray(dispositions) && dispositions.length) {
            if (dispositions[0].supDisposition && dispositions[0].supDisposition !== ''){
                this.supervisorStatus = dispositions[0].supStatus ?? null;
            }
        }
    }
}

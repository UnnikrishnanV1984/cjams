
import { pluck, share, tap } from 'rxjs/operators';
import { Component, OnInit, AfterViewInit, OnDestroy, Injector } from '@angular/core';
import { forkJoin, Observable, Subscription } from 'rxjs';
import { CommonHttpService } from '../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from './case-worker-url.config';
import { DSDSActionSummary, ServiceCaseResponsbility } from './_entities/caseworker.data.model';
import {
    InvolvedPerson,
} from './dsds-action/involved-persons/_entities/involvedperson.data.model';
import _, { } from 'lodash';
import moment from 'moment';
import { ActivatedRoute, Router } from '@angular/router';
import { AlertService, AuthService, CommonDropdownsService, GlobalPopupService } from '../../@core/services';
import { GLOBAL_MESSAGES } from '../../@core/entities/constants';
import { DataStoreService } from '../../@core/services/data-store.service';
import { IntakeStoreConstants } from '../newintake/my-newintake/my-newintake.constants';
import { IntakeUtils } from '../_utils/intake-utils.service';
import { GenericService } from '../../@core/services/generic.service';
import { SessionStorageService } from '../../@core/services/storage.service';
import { DsdsService } from './dsds-action/_services/dsds.service';
import { PaginationRequest } from '../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from './_entities/caseworker.data.constants';
import { AppConstants } from '../../@core/common/constants';
import { RoutingUser } from '../cjams-dashboard/_entities/dashBoard-datamodel';
import { AppUser } from '../../@core/entities/authDataModel';
import { AbstractControl, FormArray, FormBuilder, FormGroup, ValidationErrors, ValidatorFn, Validators } from '@angular/forms';
import { ChildRemovalService } from './dsds-action/child-removal/child-removal.service';
import { MedicationIncludingPsychotropicCwComponent } from '../shared-pages/person-info/person-health/medication-including-psychotropic-cw/medication-including-psychotropic-cw.component';
import { NewUrlConfig } from '../newintake/newintake-url.config';
import { isCaseUuid, ObjectUtils } from '../../@core/common/initializer';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'case-worker',
    templateUrl: './case-worker.component.html',
    styleUrls: ['./case-worker.component.scss'],
    standalone: false
})
export class CaseWorkerComponent implements OnInit, AfterViewInit, OnDestroy {
    dsdsActionsSummary: any = new DSDSActionSummary();
    id!: string;
    daNumber!: string;
    activeRunway!: boolean;
    reporterName!: string;
    youthStatus!: string;
    isDjs!: boolean;
    isNewCase!: boolean;
    legalGuardian!: string;
    involvedPerson$!: Observable<InvolvedPerson[]>;
    involvedPerson: any[] = [];
    store: any;
    isCW!: boolean;
    datastoreSubscription!: Subscription;
    isServiceCase!: string;
    serviceprogramkey: any[] = [];
    familyworker!: ServiceCaseResponsbility | null;
    childworker!: ServiceCaseResponsbility;
    isrestricteditem = false;
    isAdoptionCase = false;
    servicedays!: number;
    selectedServiceCaseId: string | null = null;
    serviceCaseNumber: any;
    exitingServiceCaseList: Array<any> = [];
    adoptionStartDate: any;
    isCaseWorker = false;
    isSupervisor = false;
    canUserRestrictItems = false;
    supervisorsList: any[] = [];
    placementRunwayList: any[] = [];
    selectedSupervisor!: string | null;
    cpsActionSelectedSupervisor!: string;
    caseworkerlist: any[] = [];
    roleId!: AppUser;
    hasFamilyAccessToCase: boolean = false;
    cpsResponseOffset = 0;
    sdmInfo: any;
    selectedteamid!: string;
    selectedcaseworkerlist: any[] = [];
    administrativeWorker!: ServiceCaseResponsbility;
    headofHousehold = '';
    workerPhoneNumber!: string;
    valueCaseStatusDate = '';
    openedonstr = 'Opened On :';
    labelCaseStatusDate = this.openedonstr;
    valueCaseCloseDate = '';
    isReadonly = true;
    username: any;
    responseTimerOn = true;
    caseTypeDef: any;

    countyList: any[] = [];
    countyCaseWorkersList: any[] = [];
    countySupervisorsList: any[] = [];

    selectJuridication: any = null;
    selectCaseWorker: any = null;
    selectSupervisor: any = null;

    reasonForm!: FormGroup;
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
    updatedOn: any;
    showhistoryTable!: boolean;
    responseTimerDueDate: any;
    reason: any = '';
    allegedVictimreasonDropDown1: any[] = [];
    allegedVictimreasonDropDown2: any[] = [];
    allegedVictimreasonDropDown3: any[] = [];
    otherChildrenreasonDropDown1: any[] = [];
    otherChildrenreasonDropDown2: any[] = [];
    otherChildrenreasonDropDown3: any[] = [];
    caseWorkerComment: any;
    supervisorComment: any;
    caregiverreasonDropDown1: any[] = [];
    caregiverreasonDropDown2: any[] = [];
    caregiverreasonDropDown3: any[] = [];

    restrictedItems: any = null;
    prevSkipList: any[] = [];
    skipname: any;
    disableskipbtn!: boolean;
    recording: any[] = [];
    hidedropdowns!: boolean;
    serviceCaseId: any;
    assignmentlist: any[] = [];
    showlegislativecontent!: boolean;
    responseTimerDueDateList: any;
    hideskipbtn!: boolean;
    showapprovebtn!: boolean;
    hideallegeddropdown!: boolean;
    hideotherchilddropdown!: boolean;
    hidecaregiverdropdown!: boolean;
    showreportSSAbtn!: boolean;

    enableAllegedDataEntryErrorReason!: boolean;
    enableChildrenDataEntryErrorReason!: boolean;
    enableCaregiverDataEntryErrorReason!: boolean;
    cpsResponseTimerList: any;
    hasSavedResponseTimerRecord: boolean = false;
    isResponseTimerGreaterthanoverdue!: boolean;
    responseTimerDate: any;
    responseTimerDueDateFormatted: any;
    isselectAllegedmultiple!: boolean;
    isselectChildrenmultiple!: boolean;
    isselectCaregivermultiple!: boolean;
    hasSaveForApproval: boolean = false;
    canSaveResponseTimer: boolean = true;
    ipaduser: boolean = false;
    openLivingArrangement: boolean = false;
    openFCNHSKidsList: any = [];
    isOpenFCNHSlivingarrangement: boolean = false;
    openLADetails: any = [];
    openLAHistory: any[] = [];
    fromoverduelink: boolean = false;
    individualsName: any = {name:'',id:''};
    tempData: any = [];
    indexData: number = 0;
    dtformat = "YYYY-MM-DD H:m:s a";
    routingurl = 'routing/routingupdate';
    aasignpopupid = '#confirm-navigation-assign-service-case';
    cwpersonurl = '/dsds-action/person-cw';
    servicecasehistorypopupid = '#serviceCaseHistory';
    caseworkerpageurl = '/pages/case-worker/';
    restrictitempopupid = '#confirm-restrict-item';
    errormsg = 'Error in updating restriction.';
    requestcasepopupid = '#confirm-request-case';
    livingarrangementpopupid = '#living-arrangement-confirm-popup';
    disorderConditionpopupid = '#alert-conditions-disorders-popup';
    overduepopupid = '#overdue-Popup';
    gettypesurl = 'referencetype/gettypes';
    reportsummary = 'dsds-action/report-summary';
    intakeNumber : any;
    senuntimelyreasonslist: any;
    senUntimelyForm: FormGroup = new FormGroup({});
    facetofacelist: any;
    safeclist: any;
    mfiralist: any;
    showSenUntimelyPopup: boolean = false;

    private _service: GenericService<InvolvedPerson>;
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _authService: AuthService;
    private _dsdsActionService: CommonHttpService;
    private _dataStoreService: DataStoreService;
    private _intakeService: IntakeUtils;
    private storage: SessionStorageService;
    private _dsdsService: DsdsService;
    private _router: Router;
    private _commonHttpService: CommonHttpService;
    private _intakeUtils: IntakeUtils;
    private _commonDDService: CommonDropdownsService;
    private _formBuilder: FormBuilder;
    private _childRemovalService: ChildRemovalService;
    private _globalPopupService :GlobalPopupService;
    caseType: any;
    caseId!: string;
    iscaseexpunged: any;

    constructor(private injector: Injector) {
        this._service = injector.get<GenericService<InvolvedPerson>>(GenericService);
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this._alertService = injector.get<AlertService>(AlertService);
        this._authService = injector.get<AuthService>(AuthService);
        this._dsdsActionService = injector.get<CommonHttpService>(CommonHttpService);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._intakeService = injector.get<IntakeUtils>(IntakeUtils);
        this.storage = injector.get<SessionStorageService>(SessionStorageService);
        this._dsdsService = injector.get<DsdsService>(DsdsService);
        this._router = injector.get<Router>(Router);
        this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
        this._intakeUtils = injector.get<IntakeUtils>(IntakeUtils);
        this._commonDDService = injector.get<CommonDropdownsService>(CommonDropdownsService);
        this._formBuilder = injector.get<FormBuilder>(FormBuilder);
        this._childRemovalService = injector.get<ChildRemovalService>(ChildRemovalService);
        this._globalPopupService = injector.get<GlobalPopupService>(GlobalPopupService);

        this.route.data.subscribe(data => {
            this.isServiceCase = this.storage.getItem('ISSERVICECASE');
            this.setActionSummary(data.intakesummary);
            this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
            this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
            const intakesummary = (Array.isArray(data.intakesummary) && data.intakesummary.length) ? data.intakesummary[0] : null;
            if (intakesummary) {
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.CPS_CASE_ID, intakesummary.intakeserviceid);
            }
        });

    }

    ngOnInit() {
        this._dataStoreService.setObj('responsetimerduedatelist', null);
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.selectedSupervisor = null;
        const activeModuleRole = this.storage.getItem('activeModuleRole');
        this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-servcase');            //Sonarqube moved this to top to reduce complexity
        if (['CJAMS_SSA_FTDM_FACILITATOR', 'CJAMS_SSA_QUALIFIED_INDIVIDUAL', 'CJAMS_SSA_FTDM_QI_SUPERVISOR'].includes(activeModuleRole)) { //Sonarqube moved this to top to reduce complexity
            this.isReadonly = false;
        } /*else {
        this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-servcase');}*/
        this.selectedcaseworkerlist = [];
        this.isDjs = this._authService.isDJS();
        this.isCW = this._authService.isCW();
        this.roleId = this._authService.getCurrentUser();
        const tma = this.roleId.user.userprofile.teammemberassignment;
        const assignments = Array.isArray(tma) ? tma : [tma];
        this.caseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.intakeNumber = this._dataStoreService.getData("da_intakenumber");
        this.isNewCase = true;
        this.getCountyList();
        if (navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
            this.ipaduser = true;
        }
        if (this.roleId) {
            this.username = this.roleId.user.userprofile.fullname;
        }
        this.selectedteamid = assignments[0]?.teammember?.teamid;
        this.datastoreSubscription = this._dataStoreService.currentStore.subscribe(storeObj => {
            if (storeObj[IntakeStoreConstants.statusChanged] && this.isDjs) {
                this._dataStoreService.setData(IntakeStoreConstants.statusChanged, false);
                this.getYouthStaus();
            }
            if (storeObj[CASE_STORE_CONSTANTS.FOLDER_CHANGED] && this.isDjs) {
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.FOLDER_CHANGED, false);
                this.getActionSummary();
            }
            if (storeObj['DSDS_ACTION_UPDATE']) {
                this._dataStoreService.setData('DSDS_ACTION_UPDATE', false);
                this.getActionSummary();
            }
            if(storeObj['refereshgetrohcall']) {
               this._dataStoreService.setData('refereshgetrohcall', false);
               this.getrohsenuntimelycriteria();
            }
        });
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.getAssignmentsList();
        const caseType = this.storage.getItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.caseTypeDef = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DSDS_ACTIONS_SUMMARY).da_subtype;
        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
            this.adoptionStartDate = this.storage.getItem(CASE_STORE_CONSTANTS.Adoption_START_DATE);
            this.calculatedays(this.adoptionStartDate);
        }
        if (this.daNumber) {
            this.getActionSummary();
            this.caseViewAudit();
        }

        // Decide who can restrict items
        if (this.isSupervisor) {
            this.canUserRestrictItems = true;
        }

        if (this.id) {
            this.getIsRestrictItem();
            this.restrictedItemAuditLog();
        }
        this._intakeUtils.notesUpdated$.subscribe(() => {
            this.processRecordingsList();
        });
        this.getPlacementRecordList();
        this.getcpsresponsetimerActions();

        this._dataStoreService.setData(
            IntakeStoreConstants.INTAKE_STATUS,
            null
        );
        this._dataStoreService.setObj('intake', null);

        setTimeout(() => {
            this.getresponsetimerduedate();
        }, 1000);
        
        // Load SDM from Intake
        this.getIntakeSDM();
        this.getrohsenuntimelycriteria();
    }

    getrohsenuntimelycriteria() {      
        this._commonHttpService
        .getArrayList(
            {
                where: {
                    servicecaseid  : this.id,
                    objecttype : 'overduereasonpopup'
                },
                method: 'get'
            },
            NewUrlConfig.EndPoint.Intake.Rohsenuntimelycriteria + '?filter' /* Separate API invoked for SEN Untimely Report */
        ).subscribe(data => {
            if(data && data.length > 0) {
                this.senuntimelyreasonslist = data; 
            }
        });
    }
    showSenOverduePopup() {
        if(this.valueCaseCloseDate != '') {
            this.showSenUntimelyPopupAlert(this.senuntimelyreasonslist);
        } else {
            const req = {
                servicecaseid  : this.id,
                inputsource : 'overduereasonpopup'
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
                                objecttype : 'overduereasonpopup'
                            },
                            method: 'get'
                        },
                        NewUrlConfig.EndPoint.Intake.Rohsenuntimelycriteria + '?filter' /* Separate API invoked for SEN Untimely Report */
                    ).subscribe(data => {
                        if(data && data.length > 0) {
                            this.senuntimelyreasonslist = data; 
                            this.showSenUntimelyPopupAlert(this.senuntimelyreasonslist);
                        }
                    });
                }
            });
        }
    }

     showSenUntimelyPopupAlert(senuntimelylist: any): void {
        this.showSenUntimelyPopup = true;
        this.loadDropDownsAsObservable().subscribe();

        this.senUntimelyForm = this._formBuilder.group({
            childlist: this._formBuilder.array([])
        });

        this.buildSENForm(senuntimelylist);

        this.senuntimelyreasonslist = senuntimelylist;
        (<any>$('#caseworkersenuntimelyPopup')).modal('show');
    }

    buildSENForm(senuntimelylist: any[]) {
        const arr = this.childlist;
    
        senuntimelylist.forEach(item => {
          arr.push(
            this._formBuilder.group({
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
        if(this.dsdsActionsSummary?.da_status === 'Closed') {
            this.senUntimelyForm.disable();
        }
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

    closeSenUntimelyAlertPopup() : void {
        (<any>$('#caseworkersenuntimelyPopup')).modal('hide');
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
               this.closeSenUntimelyAlertPopup();
            },
            (error) => {
                console.log(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    getIntakeSDM() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        let  isRiskofHarmValue;
        isRiskofHarmValue =  this._dataStoreService.getData('IsRiskofHarm');
        if(isRiskofHarmValue === null || isRiskofHarmValue === undefined){
            this._commonHttpService
                .create(
                    {
                        page: 1,
                        limit: 10,
                        where: {
                            intakenumber: this.intakeNumber,
                            'isExpungementSuperUser': isExpungementSuperUser,
                            'iscaseexpunged': this.iscaseexpunged,
                        }
                    },
                    NewUrlConfig.EndPoint.Intake.IntakenapshotReport /* Separate API invoked for Intakereport Report */
                ).subscribe(data => {
                    const response = data;
                    if (response && response.data && response.data.length > 0 && response.data[0]) {
                        const intakeModel = response.data[0].jsondata;
                        const sdm = intakeModel.sdm;
                        let isROHFlag;
                        const isROHFlagCheck = sdm && sdm.riskofHarm ? ObjectUtils.checkTrueProperty(sdm.riskofHarm) : 0;
                        if (isROHFlagCheck >= 1) {
                            isROHFlag = true;
                        }
                        this.setRiskOfHarmData(sdm,isROHFlag);
                    }
                });
        }
    }

    setRiskOfHarmData(sdm: any, isROHFlag: any) : void {
        if(!(sdm?.isir || sdm?.isar) && (sdm?.isnegrh_exposednewborn || isROHFlag)){
            this._dataStoreService.setData('IsRiskofHarm', true);
        } else {
            this._dataStoreService.setData('IsRiskofHarm', false);
        }
    }

    getAssignmentsList() {
        this._commonHttpService.getArrayList(
            {
                where: { servicecaseid: this.id },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        ).subscribe(data => {
            if (data) {
                this.checkCaseAccess(data);
                this.checkLoginWorkerIsLastAssignedCW(data);
            }
        });
    }

    checkLoginWorkerIsLastAssignedCW(data: any) {
       const record: any = this.getFilteredLatestRecord(data);
        const userId: any = this.roleId?.user?.securityusersid;
        const workerDetails: any = record?.[0]?.toworkerdetails;
        const workerId: any = Array.isArray(workerDetails) ? workerDetails[0]?.securityusersid : null;

        if (userId && workerId && userId === workerId) {
            this._dataStoreService.setData('IsLastAssignedCW', true);
        } else {
            this._dataStoreService.setData('IsLastAssignedCW', false);
        }
    }

    getFilteredLatestRecord(data: any) {
        if (data.length === 0) return [];

        const sorted = [...data].sort(
            (a, b) => new Date(b.enddate).getTime() - new Date(a.enddate).getTime()
        );

        const latestDate = new Date(sorted[0].enddate).getTime();
        const latestDateRecords = sorted.filter(
            record => new Date(record.enddate).getTime() === latestDate
        );
        if (latestDateRecords.length > 1) {
            return latestDateRecords.filter(
            record => record.responsibilitytypekey.toLowerCase() === "family"
            );
        }
        return [sorted[0]];
      }
    
    checkCaseAccess(data: any) {
        const checkAccessList = data.filter((item: any) => (item.responsibilitytypekey === "child" || item.responsibilitytypekey === "family" || item.responsibilitytypekey === "administrative") && (item.enddate === null || moment(item.enddate) >= moment(new Date())))
        for (const element of checkAccessList) {
            const familyAssignmentWorker = element.toworkerdetails?.filter((a: any) => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
            if (familyAssignmentWorker.length > 0) {
                this.hasFamilyAccessToCase = true;
                this.handleDisorderConditionPopUpFn();
                break;
            }
          }
    }


    private handleDisorderConditionPopUpFn() {
        if (this.isCaseWorker) {
            this.getChildRemoval();
        }
    }

    ngAfterViewInit() {
        if (this._authService.isDevice()) {
            $('#cw-profile-section').hide();
            $('#cw-groupid-display').hide();
            $('.scrtabs-tab-container').hide();
            $('#header').hide();
        }
    }

    getChildRemoval() {
        this._commonHttpService
            .getSingle(
                {
                    where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalListForDisorderPopUpCheck + '?filter'
            ).subscribe(data => {
                if (data && data.length) {
                    const crData = data.filter((item: any) => {
                        if (item.childremoval && item.childremoval.length && item.childremoval[0]) {
                            const removal = item.childremoval[0];
                            return (removal.approvalstatus === 'Approved') ? true : false;
                        } else {
                            return false;
                        }
                    });
                    this.handleCRDataFn(crData);
                } else {
                    return [];
                }
            });
    }

    private handleCRDataFn(crData: any) {
        this.tempData=[];
        if (crData.length > 0) {
            for (const ele of crData) {
                if(Array.isArray(ele.childremoval)) {
                this.tempData.push({ name: this._globalPopupService.capitalizeWords(ele.personname), id: ele.personid, alerttype: ele.alerttype });
                }
            }
            if(this.tempData.length > 0) {
                if(this._router.url.includes('report-summary')){
                 this._globalPopupService.setMedicalPrescribedData(this.tempData);
                }
            }
        }
    }

      getBusinessDaysDifference(startDate: any, endDate: any) {
        let count = 0;
        let currentDate = new Date(startDate);
      
        while (currentDate <= endDate) {
          // Check if it's a weekday (Mon-Fri)
          if (currentDate.getDay() !== 0 && currentDate.getDay() !== 6) {
            count++;
          }
          currentDate.setDate(currentDate.getDate() + 1);
        }
      
        return count;
      }
      
      

    private handlePopupOneByOneFn(tempData: any[], i: number) {
        $(this.disorderConditionpopupid).modal('hide');
        this.individualsName = tempData[i];
        this.indexData += 1;
        setTimeout(() => {
            $(this.disorderConditionpopupid).modal('show');
        }, 1000);
    }

    capitalizeWords(string: any) {
        return string.split(' ').map((word: string) =>
          word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
        ).join(' ')
    }

    getYouthStaus() {
        this._intakeService.getFocusPersonStatus(this.dsdsActionsSummary.personid, this.id, this.dsdsActionsSummary.intakenumber)
            .subscribe(statuses => {
                const status = statuses.map(s => s.description);
                this.youthStatus = status.toString();
                this._dataStoreService.setData(IntakeStoreConstants.youthStatus, status);
            });
    }

    changeFolder() {
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.FOLDER_CHANGE_INITIATED, true);
        (<any>$('#folder-change')).modal('show'); // NOSONAR
    }

    getcaseworkerlist() {
        let appEvent = 'RSTR';
        if (this.roleId.role.name === AppConstants.ROLES.KINSHIP_INTAKE_WORKER || this.roleId.role.name === AppConstants.ROLES.KINSHIP_SUPERVISOR) {
            appEvent = 'KINR';
        }
        this._service
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: appEvent, teamid: this.selectedteamid || null },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.caseworkerlist = result.data;
            });
    }

    addConditionsAudit(key: any, refkeyid: any){
        let username;
        const objectType = 'Person-profile';
        this._authService.currentUser.subscribe((userInfo) => {
            username = userInfo.user.securityusersid;
        });
        const comment = {
            securityusersid: username,
            logtype: key, 
            referenceid: refkeyid, 
            objectype: objectType,
            objectid: this.caseId ? this.caseId : null, 
            description: key 
        };
        this._commonHttpService.create(comment, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddDetailedAudit).subscribe(
            (result) => {
               console.log(result);
            },
            (error) => {
                console.log(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    
    }


    // On User response to No, Intialising Medication Psychotropic form and saving record.
    createMedicationPsychotropicFormAndSaveNo(id : any) {
        let medicationPsychotropicForm = MedicationIncludingPsychotropicCwComponent.createForm(this._formBuilder)
        medicationPsychotropicForm.patchValue({
            isprescribedmedication : false,     
            renewal : false
        });
        const uploadInfo: any = {};
        uploadInfo['uploadedFiles'] = [];
        const data = {...medicationPsychotropicForm.getRawValue(), ...uploadInfo};
        let finaldata = this.replaceEmptyValuesWithNull(data);
        this._globalPopupService.saveHealth({ 'personmedicalPsychotropic': [finaldata] }, id).subscribe();
    }

    replaceEmptyValuesWithNull(obj: any): any {
        if (Array.isArray(obj)) {
          return obj.map(item => this.replaceEmptyValuesWithNull(item));
        } else if (obj !== null && typeof obj === 'object') {
          const updatedObj: any = {};
          for (const key in obj) {
            if (obj.hasOwnProperty(key)) {
              updatedObj[key] = this.replaceEmptyValuesWithNull(obj[key]);
            }
          }
          return updatedObj;
        } else if (obj === '') {
          return null;
        } else {
          return obj;
        }
      }


    private getSource() {
        return AppConstants.CASE_TYPE.SERVICE_CASE;
      }

      private getCaseUuid() {
        const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        if (caseID) {
          return caseID;
        }
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        return caseInfo?.intakeserviceid ?? null;
      }


    private getInvolvedPerson() {
        const isExpungementSuperUser =  this._authService.isExpungementSuperUser();
        if (!this.id) {
            this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        }
        let inputRequest: Object;
        if (this._dsdsService.isServiceCase()) {
            inputRequest = {
                objectid: this.id,
                objecttypekey: 'servicecase'
            };
        } else {
            inputRequest = {
                intakeserviceid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': this.iscaseexpunged
            };
        }
        this.involvedPerson$ = this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: inputRequest
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .PersonList + '?filter'
            ).pipe(
                share(),
                pluck('data'));
        this.involvedPerson$.subscribe((data) => {
            this.involvedPerson = data;
            this.processLegalGuardian();
            this.loadSDMData();

        });
    }

    setReporterNameIntakeReportedDateAndProgramKey() {
        this.caseType = this._dataStoreService.getData('Case Type');
        if (this.dsdsActionsSummary?.intake_jsondata && this.dsdsActionsSummary?.intake_jsondata?.narrative &&
            this.dsdsActionsSummary?.intake_jsondata?.narrative.length) {
            this.reporterName = this.dsdsActionsSummary.intake_jsondata.narrative[0].Firstname + ' ' + this.dsdsActionsSummary.intake_jsondata.narrative[0].Lastname;
            if (!this.reporterName || !this.reporterName.replace(/\s/g, '').length) {
                this.reporterName = '';
            }
        }
        if (this.dsdsActionsSummary?.intake_jsondata && Array.isArray(this.dsdsActionsSummary?.intake_jsondata)
            && this.dsdsActionsSummary?.intake_jsondata?.length > 0 && this.dsdsActionsSummary?.intake_jsondata[0]?.reporteddate) {
            this.dsdsActionsSummary.intake_jsondata = _.sortBy(this.dsdsActionsSummary.intake_jsondata, 'reporteddate');
            this._dataStoreService.setData('intakereporteddate', this.dsdsActionsSummary.intake_jsondata[0].reporteddate);
        } else if (this.dsdsActionsSummary?.da_receiveddate) {
            this._dataStoreService.setData('intakereporteddate', this.dsdsActionsSummary.da_receiveddate);
        }
        if (this.dsdsActionsSummary?.programarea && this.dsdsActionsSummary?.programarea?.length) {
            this.dsdsActionsSummary.programarea.forEach((element: any) => {
                this.serviceprogramkey.push(element);
            });
        }

    }
    updateCaseStatus() {
        if (_.has(this.dsdsActionsSummary, 'case_closedate') && _.has(this.dsdsActionsSummary, 'case_opendate')) {
            if (this.dsdsActionsSummary['case_closedate'] != null) {
                let open = (new Date(this.dsdsActionsSummary['case_opendate'])).getTime();
                let close = (new Date(this.dsdsActionsSummary['case_closedate'])).getTime();
                if (open > close) {
                    this.labelCaseStatusDate = 'Reopened On :';
                    this.valueCaseStatusDate = this.dsdsActionsSummary['case_opendate'];
                    this.valueCaseCloseDate = '';
                } else {
                    this.labelCaseStatusDate = this.openedonstr;
                    this.valueCaseStatusDate = this.dsdsActionsSummary['case_opendate'];
                    this.valueCaseCloseDate = this.dsdsActionsSummary['case_closedate'];
                }
            } else {
                this.labelCaseStatusDate = this.openedonstr;
                this.valueCaseStatusDate = this.dsdsActionsSummary['case_opendate'];
                this.valueCaseCloseDate = '';
            }
        }

    }
    updateWorkerYouthAndCase() {
        if (this.dsdsActionsSummary?.responsibleworkers && Array.isArray(this.dsdsActionsSummary?.responsibleworkers) && this.dsdsActionsSummary?.responsibleworkers?.length) {
            this.familyworker = this.dsdsActionsSummary.responsibleworkers.find((worker: { responsibilitytypekey: string; }) => worker.responsibilitytypekey === 'family');
            this.childworker = this.dsdsActionsSummary.responsibleworkers.find((worker: { responsibilitytypekey: string; }) => worker.responsibilitytypekey === 'child');
            this.administrativeWorker = this.dsdsActionsSummary.responsibleworkers.find((worker: { responsibilitytypekey: string; }) => worker.responsibilitytypekey === 'administrative');
            this.workerPhoneNumber = this.dsdsActionsSummary.responsibleworkers[0].phonenumber;

        } else {
            this.familyworker = null;
        }
        if (String(this.dsdsActionsSummary.da_number).toLowerCase().startsWith('cw')) {
            this.isNewCase = false;
        }

    }

    private caseViewAudit() {
        const securityuserid = this._authService.getCurrentUser().user.securityusersid;
        const logtypekey = 'CV';
        const description = 'Case was viewed by a worker';
        const objectid = ((this.isServiceCase && this.isServiceCase !== 'false') || this.isAdoptionCase) ? this.id : this.daNumber;
        let serviceType = this.isServiceCase && this.isServiceCase !== 'false';
        const serviceTypeValue = serviceType ? 'servicecase' : 'servicerequest';
        const objecttype = this.isAdoptionCase ? 'adoptioncase' : serviceTypeValue;

        var newadd = {
            "description": description,
            "logtypekey": logtypekey,
            "referenceid": securityuserid,
            "objectid": objectid,
            "objecttype": objecttype,
            "insertedby": securityuserid,
            "updatedby": securityuserid,
        }
        this._commonHttpService.create(newadd, CaseWorkerUrlConfig.EndPoint.Dashboard.AddAuditLog).subscribe(
            () => {
                // No content to add or call
            },
            (error) => {
              console.error(error);
            }
        );
    }
    private getActionSummary() {

        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    
        this.serviceprogramkey = [];
        let url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${this.iscaseexpunged}`;
    
        if (this.isServiceCase && this.isServiceCase !== 'false') {
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + this.id + '/casetype' + `?isExpungementSuperUser=${isExpungementSuperUser}`;
        } else if (this.isAdoptionCase) {
            url = CaseWorkerUrlConfig.EndPoint.Dashboard.AdoptionActionSummary + '/' + this.id;
        }

        this._dsdsActionService.getAll(url).subscribe(
            (response) => {
                this.dsdsActionsSummary = response[0];
                const stdate = moment(this.dsdsActionsSummary.da_receiveddate, this.dtformat);
                var currenDate = moment(new Date()).format(this.dtformat);
                var endDate = moment(currenDate, this.dtformat);
                var result = endDate.diff(stdate, 'days');
                if ((this.dsdsActionsSummary.da_subtype === "CPS-AR" && result === 9)
                    || (this.dsdsActionsSummary.da_subtype === "CPS-IR" && result === 13)) {

                    this.getcpsresponsetimerActions();
                }
                this.responseTimerDate = moment(this.dsdsActionsSummary.da_responsetime, "YYYY-MM-DD H:m:s a");

                if (this.dsdsActionsSummary.da_responsetime) {
                    this.responseTimerOn = false;
                } else {
                    this.responseTimerOn = true;
                }
                if (!this.dsdsActionsSummary) {
                    this._alertService.error('DSDS Action Summary is Empty, Please Check Your Data.');
                    return;
                }
                //SonarQube - moved the entire logic to small functions to reduce code complexity                
                this.setReporterNameIntakeReportedDateAndProgramKey();
                this.updateCaseStatus();
                this.updateWorkerYouthAndCase();

                this.getLegalGuardian();
                this._dataStoreService.setData('object', this.dsdsActionsSummary);
                this._dataStoreService.setData('da_status', this.dsdsActionsSummary.da_status);
                this.storage.setItem('case_closed', this.dsdsActionsSummary.case_closedate);
                this.storage.setItem('da_status', this.dsdsActionsSummary.da_status);
                this.storage.setItem('da_assignedby', this.dsdsActionsSummary.da_assignedby);
                localStorage.setItem('dsdsActionsSummary', JSON.stringify(this.dsdsActionsSummary));
                this._dataStoreService.setData('teamtypekey', this.dsdsActionsSummary.teamtypekey);
                this._dataStoreService.setData('teamid', this.dsdsActionsSummary.teamid);
                this._dataStoreService.setData('dsdsActionsSummary', this.dsdsActionsSummary);
                this._dataStoreService.setData('da_assignedby', this.dsdsActionsSummary.da_assignedby);
                this._dataStoreService.setData('youthFullName', this.dsdsActionsSummary.da_lastname + ' ' + this.dsdsActionsSummary.da_suffix + ', ' + this.dsdsActionsSummary.da_firstname);
                this._dataStoreService.setData('da_legalGuardian', this.dsdsActionsSummary.da_legalGuardian);
                this._dataStoreService.setData('da_focus', this.dsdsActionsSummary.da_focus);
                this._dataStoreService.setData('da_personid', this.dsdsActionsSummary.personid);
                this._dataStoreService.setData('da_persondob', this.dsdsActionsSummary.persondob);
                this._dataStoreService.setData('da_foldertypedecription', this.dsdsActionsSummary.foldertypedescription);
                this._dataStoreService.setData('da_foldertypekey', this.dsdsActionsSummary.foldertypekey);
                this._dataStoreService.setData('da_intakenumber', this.dsdsActionsSummary.intakenumber);
                this._dataStoreService.setData('countyid', this.dsdsActionsSummary.countyid);
                this._dataStoreService.setData('programarea', this.dsdsActionsSummary.programarea);
                this._dataStoreService.setData('adoptionproviderid', this.dsdsActionsSummary.adoptionproviderid);
                this._dataStoreService.setData('onlyadoptivehomeprovider', this.dsdsActionsSummary.onlyadoptivehomeprovider);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.CPS_CASE_ID, this.dsdsActionsSummary.intakeserviceid);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.INTAKE_NUMBER, this.dsdsActionsSummary.intakenumber);
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER, this.dsdsActionsSummary.intake_jsondata);
                if (this.isDjs) {
                    this.getYouthStaus();
                }
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    loadSupervisor() {
        if (!this.supervisorsList || (this.supervisorsList && this.supervisorsList.length == 0)) {
            this._dsdsActionService
                .getPagedArrayList(
                    new PaginationRequest({
                        where: { appevent: 'INTR' },
                        method: 'post'
                    }),
                    'Intakedastagings/getroutingusers'
                )
                .subscribe(result => {
                    this.supervisorsList = result.data;
                });
        }
    }
    getAppEventCode() {
        let appeventcode = 'INVT';
        if (this.isAdoptionCase) {
            appeventcode = 'ADPC';
        }
        if (this.isServiceCase) {
            appeventcode = 'SRVC';
        }
        return appeventcode;
    }
    updateReviewer() {
        if (this.selectedSupervisor) {
            this._dsdsActionService.create({
                appeventcode: this.getAppEventCode(),
                objectid: this.id,
                fromuserid: this.selectedSupervisor
            },
                'routing/changereviewer'
            )
                .subscribe(result => {
                    this.selectedSupervisor = null;
                    this._alertService.success('Case Assign Successfully Completed');
                    (<any>$('#list-supervisor')).modal('hide'); // NOSONAR
                    this.getActionSummary();
                });
        } else {
            this._alertService.warn('Please Select Supervisor');
        }
    }
    onChangeSupervisor(supervisor: RoutingUser) {
        this.selectedSupervisor = supervisor.userid;
    }
    private setActionSummary(intakesummary: any) {
        if (intakesummary && intakesummary.length) {
            const data = intakesummary[0];
            this.getLegalGuardian();
            this._dataStoreService.setData('da_status', data.da_status);
            this._dataStoreService.setData('teamtypekey', data.teamtypekey);
            this._dataStoreService.setData('dsdsActionsSummary', data);
            this._dataStoreService.setData('da_assignedby', data ? data.da_assignedby : null);
            this._dataStoreService.setData('da_focus', data.da_focus);
            this._dataStoreService.setData('da_legalGuardian', data.da_legalGuardian);
            this._dataStoreService.setData('da_personid', data.personid);
            this._dataStoreService.setData('da_persondob', data.persondob);
            this._dataStoreService.setData('da_foldertypedecription', data.foldertypedescription);
            this._dataStoreService.setData('da_foldertypekey', data.foldertypekey);
            this._dataStoreService.setData('da_intakenumber', data.intakenumber);
            this._dataStoreService.setData('da_typeid', data.da_typeid);
            this._dataStoreService.setData('da_type', data.da_type);
            this._dataStoreService.setData('da_subtypeid', data.da_typeid);
            this._dataStoreService.setData('da_receiveddate', data.da_receiveddate);
            this._dataStoreService.setData('programarea', data.programarea);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.INTAKE_NUMBER, data.intakenumber);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.SC_INTAKE_NUMBER, data.intake_jsondata);
            if (this.isServiceCase) {
                this.calculatedays(data.case_opendate);
            }
            if (this.isDjs) {
                this.getYouthStaus();
            }
        }
    }
    calculatedays(recieveddate: string | number | Date) {
        const date2 = new Date(recieveddate);
        const date1 = new Date();
        const diff = Math.abs(date1.getTime() - date2.getTime());
        this.servicedays = Math.ceil(diff / (1000 * 3600 * 24));
    }

    private getLegalGuardian() {
        if (this.involvedPerson && this.involvedPerson.length > 0) {
            this.processLegalGuardian();
        } else {
            this.getInvolvedPerson();
        }
    }

    processLegalGuardian() {
        const addedPersons = this.involvedPerson;
        let personFullName = '';
        const da_assignedby = this.dsdsActionsSummary ? this.dsdsActionsSummary.da_assignedby : null;   //Sonarqube code complextity -moved this check to top
        if (!addedPersons || !Array.isArray(addedPersons)) {
            return;
        }
        //else{
        addedPersons.forEach(item => {
            if (item.rolename === 'LG' && personFullName === '') {
                personFullName = item.firstname + ' ' + item.lastname;
                this.dsdsActionsSummary.da_legalGuardian = personFullName;
                this._dataStoreService.setData('dsdsActionsSummary', this.dsdsActionsSummary);
                this._dataStoreService.setData('da_assignedby', da_assignedby);
                this._dataStoreService.setData('da_legalGuardian', personFullName);
            }
            if (item.isheadofhousehold === true) {
                this.headofHousehold = item.fullname;
                this._dataStoreService.setData('hoh',this.headofHousehold)
            }
        });

        if (this.isAdoptionCase && this.headofHousehold === '') {
            addedPersons.forEach(item => {
                if (item.rolename === 'CHILD' || item.rolename === 'PVTADPCHILD') {
                    this.headofHousehold = item.fullname;
                    this._dataStoreService.setData('hoh', this.headofHousehold)
                }
            });
        }
    }

    ngOnDestroy(): void {
        if (this.datastoreSubscription) {
            this.datastoreSubscription.unsubscribe();
        }
    }
    linkToServiceCase() {
        this._dsdsActionService
            .getArrayList(
                {
                    where: { intakeserviceid: this.id, source: 'cps' },
                    method: 'get'
                },
                'intakeservreqchildremoval/servicecasevalidation?filter'
            ).subscribe((result: any) => {
                if (!this.serviceCaseNumber && result && result?.data && result?.data?.length && result?.data?.length > 0) {
                    this.serviceCaseNumber = result?.data[0]?.servicecaseno;
                }
                if (result.isavailable === 1) {
                    this.openHistoryOfFamilyCase(result.data);
                } else {
                    this.getActionSummary();
                    this._alertService.success('Successfully Linked to Service Case');
                    const routingObject = {
                        objectid: this.id,
                        eventcode: 'SCCR',
                        status: 'Accepted',
                        intakeserviceid: this.id,
                        notifymsg: 'Case Connect Approved '
                    };

                    this._dsdsActionService.create(routingObject, this.routingurl).subscribe((res) => {
                        this._alertService.success('Service case created: ' + this.serviceCaseNumber);
                        (<any>$(this.aasignpopupid)).modal('show'); // NOSONAR
                    });
                }
            });
    }

    // Saran

    selectCase(selectedcase: any, isRedirect: boolean = false) {
        //if (selectedcase === 'NEW_CASE') {                //SonarQube code complexity change
        this.selectedServiceCaseId = 'NEW_CASE';
        //}
        if (selectedcase !== 'NEW_CASE') {
            if (isRedirect) {
                this.routToServiceCase(selectedcase);
            } else {
                this.selectedServiceCaseId = selectedcase.servicecaseid;

                this.storage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
                //if (selectedcase) {                                                   //SonarQube code complexity change 
                this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, selectedcase.objecttypekey);
                //}
                const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + selectedcase.servicecaseid + '/casetype';
                this._dsdsActionService.getAll(url).subscribe((response) => {
                    const dsdsActionsSummary = response[0];
                    if (dsdsActionsSummary) {
                        this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                        this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                        this.storage.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
                        this._dataStoreService.clearStore();
                        this._dataStoreService.clearStore();
                        this._dataStoreService.clearStore();
                    }
                });
            }
        }
    }

    routToServiceCase(selectedcase: { servicecasenumber: string; servicecaseid: string; }) {
        if (selectedcase) {
            this.storage.setItemKey(selectedcase.servicecasenumber + '.' + CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        }
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + selectedcase.servicecaseid + '/casetype';
        this._dsdsActionService.getAll(url).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                const currentUrl = '#/pages/case-worker/' + selectedcase.servicecaseid + '/' + selectedcase.servicecasenumber + '/' + this.reportsummary;
                window.open(currentUrl);
            }
        });
    }

    createOrMergeServiceCase() {
        const serviceCaseData = {
            servicecaseid: this.selectedServiceCaseId === 'NEW_CASE' ? null : this.selectedServiceCaseId,
            intakeserviceid: this.id,
            isnewcase: this.selectedServiceCaseId === 'NEW_CASE' ? 1 : 0,
            subtypekey: 'IHM', // INHOME SERVICES,
            source: 'intake'
        };
        this._dsdsActionService
            .create(serviceCaseData, 'servicecase/createservicecase')
            .subscribe(response => {
                this.serviceCaseNumber = response[0].servicecaseno;

                // not sure what these are doing
                this.hideHistoryOfFmailyCase();
                this.getActionSummary();
                // end : not sure what these are doing

                const routingObject = {
                    objectid: this.id,
                    eventcode: 'SCCR',
                    status: 'Accepted',
                    intakeserviceid: this.id
                };

                this._dsdsActionService.create(routingObject, this.routingurl).subscribe((res) => {
                    if (this.selectedServiceCaseId === 'NEW_CASE') {
                        this._alertService.success('Service case created: ' + this.serviceCaseNumber);
                        (<any>$(this.aasignpopupid)).modal('show'); // NOSONAR
                    } else {
                        this._alertService.success('Service case connected: ' + this.serviceCaseNumber);
                    }
                });
            });

    }

    openServiceCaseAcknowledge(serviceCaseNumber: any) {
        this.serviceCaseNumber = serviceCaseNumber;
        (<any>$('#approve-intake-ackmt-service-case')).modal('show'); // NOSONAR
    }
    openHistoryOfFamilyCase(caseList: any) {
        this.exitingServiceCaseList = caseList;
        (<any>$(this.servicecasehistorypopupid)).modal('show'); // NOSONAR
    }

    hideHistoryOfFmailyCase() {
        (<any>$(this.servicecasehistorypopupid)).modal('hide'); // NOSONAR
    }
    routToCaseWorker1(item: { objecttypekey: any; servicecaseid: string; servicecasenumber: string; }) {
        this.storage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttypekey);
        }
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecaseid + '/casetype';
        this._dsdsActionService.getAll(url).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('dsdsActionsSummary', dsdsActionsSummary);
                this._dataStoreService.setData('da_assignedby', dsdsActionsSummary ? dsdsActionsSummary.da_assignedby : null);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                const currentUrl = this.caseworkerpageurl + item.servicecaseid + '/' + item.servicecasenumber + this.cwpersonurl;
                this._router.navigateByUrl('/', { skipLocationChange: true }).then(() => this._router.navigate([currentUrl]));
            }
        });
    }

    getIsRestrictItem() {
        this._intakeService.isRestrictedItem(this.id)
            .subscribe(
                (response) => {
                    const result: any = response
                    this.restrictedItems = response;
                    if (result.success) {
                        this.isrestricteditem = true;
                        this.mapRestrictedData(result);
                        this.selectJuridication = result.data.countylist;
                        this.countyChange([], this.selectJuridication)
                        this.selectCaseWorker = result.data.caseworkerlist.map((item: { userid: any; }) => item.userid);
                        this.selectSupervisor = result.data.supervisorlist.map((item: { userid: any; }) => item.userid);
                    }
                }
            );
    }

    mapRestrictedData(modal: any) {
        this.selectJuridication = modal.data.countylist.filter((v: any, i: any) => modal.data.countylist.findIndex((item: any) => item == v) === i);
        this.countyChange([], this.selectJuridication)
        this.selectCaseWorker = modal.data.caseworkerlist.map((item: { userid: any; }) => item.userid);
        this.selectSupervisor = modal.data.supervisorlist.map((item: { userid: any; }) => item.userid);
        this.selectCaseWorker = this.selectCaseWorker.filter((v: any, i: any) => this.selectCaseWorker.findIndex((item: any) => item == v) === i);
        this.selectSupervisor = this.selectSupervisor.filter((v: any, i: any) => this.selectSupervisor.findIndex((item: any) => item == v) === i);
    }

    restrictedItemAuditLog() {
        this._intakeService.restrictedItemAuditLog(this.id)
            .subscribe();
    }

    confirmRestrictItem(flag: boolean) {
        const userinfo = this._authService.getCurrentUser();
        let activeflag = 0;
        const userlist = [];
        if (flag) {
            if (!this.selectCaseWorker || this.selectCaseWorker.length === 0) {
                this._alertService.warn('Please select atleast one case worker');
                return;
            }
            this.selectSupervisor = (!this.selectSupervisor) ? [] : this.selectSupervisor;
            activeflag = 1;
            this.selectCaseWorker.map((element: any) => {
                userlist.push({
                    userid: element,
                    roletypekey: 'CWCW'
                })
            })
            this.selectSupervisor.map((element: any) => {
                userlist.push({
                    userid: element,
                    roletypekey: 'CWSP'
                })
            })
        }

        userlist.push({
            userid: userinfo.user.securityusersid,
            roletypekey: 'CWSP'
        });

        this._intakeService.createRestrictedItem(this.id, 'SERVICE', userlist, activeflag)
            .subscribe(
                (response) => {
                    // If originally false then we just successfully applied restriction
                    if (activeflag === 1) {
                        this._alertService.success('Restriction applied successfully.');
                    } else {
                        this.selectJuridication = [];
                        this.selectCaseWorker = [];
                        this.selectSupervisor = [];
                        this._alertService.success('Restriction removed successfully.');
                    }
                    // Revert the restriction flag
                    this.isrestricteditem = flag;
                    (<any>$(this.restrictitempopupid)).modal('hide'); // NOSONAR
                    this.selectedcaseworkerlist = [];
                },
                (error) => {
                    this._alertService.warn(this.errormsg);
                }
            );
    }


    cancelRestrictItem() {
        (<any>$(this.restrictitempopupid)).modal('hide'); // NOSONAR
        this.selectedcaseworkerlist = [];
        if (this.isrestricteditem) {
            this.mapRestrictedData(this.restrictedItems);
        }
    }

    cancelRequestCase() {
        (<any>$(this.requestcasepopupid)).modal('hide'); // NOSONAR
    }
    confirmRequestCase() {
        const routingObject = {
            objectid: this.id,
            eventcode: 'SCCR',
            status: 'Review',
            intakeserviceid: this.id,
            notifymsg: 'Case Connect Submitted for Review '
        };

        /*
        comments: "Case worker has requested to open a in-home service case.",
        notifymsg: 'Notify message',
        routeddescription: 'routing description'
        */
        this._dsdsActionService.create(routingObject, this.routingurl).subscribe((res) => {
            this._alertService.success('Successfully Requested to Open a Service Case.');
            this.routeIntakeServiceRequestToCaseWorker1(this.daNumber);
        });


        (<any>$(this.requestcasepopupid)).modal('hide'); // NOSONAR
        this.hideHistoryOfFmailyCase();
    }

    closeRequestCaseAndRoute(event: any) {
        if (event.selecteditemtype === 'SERVICE_CASE') {
            this.routeServiceCaseToCaseWorker(event);
        } else if (event.selecteditemtype === 'INTAKE_SERVICE_REQUEST') {
            this.routeToIntakeServiceRequestFromRelatedCases(event);
        } else if (event.selecteditemtype === 'INTAKE') {
            this.routeToIntakeFromRelatedCases(event);
        }
    }

    routeToIntakeFromRelatedCases(item: any) {
        (<any>$(this.requestcasepopupid)).modal('hide'); // NOSONAR
        this._intakeService.redirectIntake(item.intakenumber);
    }

    routeToIntakeServiceRequestFromRelatedCases(item: any) {
        (<any>$(this.requestcasepopupid)).modal('hide'); // NOSONAR
        this._dsdsActionService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                const currentUrl = this.caseworkerpageurl + item.intakeserviceid + '/' + item.servicerequestnumber + '/' + this.reportsummary;
                this._router.navigateByUrl('/', { skipLocationChange: true }).then(() => this._router.navigate([currentUrl]));
            }
        });
    }

    routeIntakeServiceRequestToCaseWorker1(item: any) {
        (<any>$(this.requestcasepopupid)).modal('hide'); // NOSONAR
        this._dsdsActionService.getById(item, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this.dsdsActionsSummary.caseconnectsent = dsdsActionsSummary.caseconnectsent;
            }
        });
    }

    routeServiceCaseToCaseWorker(item: any) {
        (<any>$(this.servicecasehistorypopupid)).modal('hide'); // NOSONAR
        (<any>$(this.requestcasepopupid)).modal('hide'); // NOSONAR
        this.storage.setTabKeyKey(item.servicecasenumber);
        this.storage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttypekey);
        }
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecaseid + '/casetype';
        this._dsdsActionService.getAll(url).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                const currentUrl = this.caseworkerpageurl + item.servicecaseid + '/' + item.servicecasenumber + '/' + this.reportsummary;
                this._router.navigateByUrl('/', { skipLocationChange: true }).then(() => this._router.navigate([currentUrl]));
            }
        });
    }

    confirmNavigationAssignServiceCase() {
        (<any>$(this.aasignpopupid)).modal('hide'); // NOSONAR
        (<any>$(this.requestcasepopupid)).modal('hide'); // NOSONAR
        const currentUrl = 'pages/cjams-dashboard/cw-assign-service-case';
        this._router.navigate([currentUrl]);
    }

    cancelNavigationAssignServiceCase() {
        (<any>$(this.aasignpopupid)).modal('hide'); // NOSONAR
        window.location.reload();
    }

    confirmIntakeNavigation() {
        (<any>$('#confirm-intake-navigation')).modal('hide'); // NOSONAR
        this._intakeService.redirectIntake(this.dsdsActionsSummary.intakenumber);
    }

    cancelIntakeNavigation() {
        (<any>$('#confirm-intake-navigation')).modal('hide'); // NOSONAR
    }

    calculateResponseOffset(sdmInfo: any) {
        if (sdmInfo) {
            /* SDM Counter info
             isnoimmed_physicalabuse-- Physical abuse-response within 24 hours
             isnoimmed_sexualabuse -- Sexual abuse-response within 24 hours
             isnoimmed_neglectresponse --- Neglect-response within 5 days
             isnoimmed_mentalinjury --- Mental injury-response within 5 days
             isnoimmed_screeninoverride --- Screen-in Override
             isnoimmed_risk_harm --There is Risk ofHarm. Response within 5 days.
             isnoimmed_substantial_risk -- There is Risk of Harm for a Substance Exposed Newborn. Response within 48 hours.
             isnoimmed_risk_harm -- There is Risk of Harm. Response within 5 days.
             */

            if (sdmInfo.isnoimmed_physicalabuse || sdmInfo.isnoimmed_sexualabuse || sdmInfo.ismalpa_suspeciousdeath || sdmInfo.ismalpa_nonaccident
                || sdmInfo.ismalpa_injuryinconsistent || sdmInfo.ismalpa_insjury || sdmInfo.ismalpa_childtoxic || sdmInfo.ismalpa_caregiver || sdmInfo.ismalpa_labortrafficking
                || sdmInfo.ismalsa_sexualmolestation || sdmInfo.ismalsa_sexualact || sdmInfo.ismalsa_sexualexploitation || sdmInfo.ismalsa_physicalindicators || sdmInfo.ismalsa_sex_trafficking) {
                return 24;
            }

            if (sdmInfo.isnoimmed_substantial_risk || sdmInfo.isnegrh_exposednewborn) {
                return 48;
            }

            if (sdmInfo.isnegab_abandoned || sdmInfo.isnoimmed_neglectresponse || sdmInfo.isnoimmed_mentalinjury || sdmInfo.isnoimmed_risk_harm
                || sdmInfo.isneggn_suspiciousdeath || sdmInfo.isneggn_signsordiagnosis || sdmInfo.isneggn_inadequatefood || sdmInfo.isneggn_childdischarged
                || sdmInfo.isneggn_exposuretounsafe || sdmInfo.isneggn_inadequateclothing || sdmInfo.isneggn_inadequatesupervision || sdmInfo.isnegrh_treatmenthealthrisk
                || sdmInfo.isnegrh_priordeath || sdmInfo.isnegrh_basicneedsunmet || sdmInfo.isnegrh_basicneedsunmet || sdmInfo.isnegrh_sex_offender || sdmInfo.isnegrh_risk_dv
                || sdmInfo.isnegrh_sex_trafficking || sdmInfo.isnegrh_fatality_can || sdmInfo.isnegrh_indicated_unsub || sdmInfo.isnegrh_survivor || sdmInfo.isnegrh_birth_match
                || sdmInfo.ismenab_psycologicalability || sdmInfo.ismenng_psycologicalability || sdmInfo.isnegmn_unreasonabledelay) {
                return 24 * 5;  // 5 days
            }
        }
        return 0;
    }

    processRecordingsList() {
        const isExpungementSuperUser =  this._authService.isExpungementSuperUser();
        const neededRoles = ['AV', 'CHILD', 'LG'];
        if (!this.involvedPerson || !Array.isArray(this.involvedPerson)) {
            return;
        }

        const needToContactPersons = this.involvedPerson.filter(person => {
            if (person.roles) {
                if (person.roles.find((role: { intakeservicerequestpersontypekey: string; }) => neededRoles.indexOf(role.intakeservicerequestpersontypekey) !== -1)) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }

        }).map(filteredPerson => filteredPerson.roles[0].intakeservicerequestactorid);
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    where: { intakeservicerequestactorids: needToContactPersons,
                        isExpungementSuperUser: isExpungementSuperUser,
                        'iscaseexpunged': this.iscaseexpunged },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.id + '?data'
            )
            .subscribe((result) => {
                if (Array.isArray(result?.data)) {
                    this.processAcceptedRecordings(result.data, needToContactPersons);


                }
            });
    }
    processAcceptedRecordings(data: any, needToContactPersons: any) {
        const acceptedRecordings = data.filter((recording: any) => {
            return (['Face To Face', 'Initialfacetoface', 'Phone'].includes(recording.recordingtype))
                && (recording.attemptind !== null);
        });
        needToContactPersons.forEach((requestactorid: any) => {
            let isCompleted = false;
            for (const recodringInfo of acceptedRecordings) {
                const found = recodringInfo.contactparticipant.filter((participant: { intakeservicerequestactorid: any; }) => participant.intakeservicerequestactorid === requestactorid);
                if (found && found.length > 0) {
                    isCompleted = true;
                    break;
                }
            }
            return { requestactorid: requestactorid, completed: isCompleted };
        });

        this.cpsResponseOffset = this.calculateResponseOffset(this.sdmInfo);
    }
    loadSDMData() {
        // servicerequestid is bound to a uuid parameter, so an unresolved this.id
        // reaches Postgres as 22P02 and the api flattens that into a bare 400. This
        // runs off the involvedPerson subscription, which does not check the id.
        if (!isCaseUuid(this.id)) {
            return;
        }
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._commonHttpService.getArrayList(
            new PaginationRequest({
                where: { servicerequestid: this.id, intakenumber: null, isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged },
                method: 'get'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.PathwaySdmListUrl
        ).subscribe(response => {
            if (response && Array.isArray(response) && response.length) {
                const sdmInfoHistory = response[0].getintakeservicerequestsdm;
                if (sdmInfoHistory && Array.isArray(sdmInfoHistory) && sdmInfoHistory.length) {
                    this.sdmInfo = sdmInfoHistory.find(x=>x.pathwaystatus == 'Accepted');
                    this.cpsResponseOffset = this.calculateResponseOffset(this.sdmInfo);
                    this.processRecordingsList();
                }
            }
        });
    }

    formatPhoneNumber(phoneNumber: string) {
        if (phoneNumber) {
            return this._commonDDService.formatPhoneNumber(phoneNumber);
        }
    }

    getDateTimeFormatted(date: any) {
        if (date && moment(date).isValid()) {
            return moment(date).format('MM/DD/YYYY, h:mm A');
        } else {
            return '';
        }
    }


    getPlacementRecordList() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get',
                    where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
                }),
                'placement/getplacementbyservicecase?filter'
            ).subscribe(data => {
                this.placementRunwayList = data.data;
                this.checkActiveRunwayPlacement();
            });
    }


    checkActiveRunwayPlacement() {
        this.activeRunway = false;
        this.openLADetails = [];
        if (this.placementRunwayList && this.placementRunwayList.length) {
            this.placementRunwayList.forEach(placement => {
                const placements = placement.placements;
                placements.forEach((plmnt: any) => {
                    if (plmnt && plmnt.livingarrangementtypekey == 'RNW' && plmnt.routingstatus == 'Approved' && plmnt.livingenddate == null) {
                        this.activeRunway = true;
                        return this.activeRunway;
                    }
                    if (plmnt && plmnt.placementtypekey == 'LA' && (plmnt.livingarrangementtypekey == 'FCH' || plmnt.livingarrangementtypekey == 'FCNFHS') && plmnt.routingstatus == 'Approved' && plmnt.livingenddate == null) {
                        this.openLADetails = plmnt;
                        this.openLivingArrangement = true;
                        this.checklivingArragementKey(plmnt, placement);
                        this.getcpsresponsetimerForLA(plmnt.placementid);
                        return this.activeRunway;
                    }
                });
            });
        }
        return this.activeRunway;
    }

    checklivingArragementKey(plmnt: any, placement: any){
        if(plmnt.livingarrangementtypekey == 'FCNFHS') {
            const stdate = moment(plmnt.livingstartdate, this.dtformat);
            const currenDate = moment(new Date()).format(this.dtformat);
            const endDate = moment(currenDate, this.dtformat);
            const resultdt = endDate.diff(stdate, 'days');
        if (resultdt >= 7) {
            this.isOpenFCNHSlivingarrangement = true;
            this.openFCNHSKidsList.push({
                clientName : placement.cjamspid + ' - ' + placement.clientname,
            })
        }
        } else {
            this.isOpenFCNHSlivingarrangement = false;
        }
    }

    getcpsresponsetimerForLA(id: any) {
        const obj = {
            "placementid": id
        }
        this._commonHttpService.create(obj, 'overridepopup/listla').subscribe(response => {
            this.showLivingArrangmentPopup1();
            if (response && response.data && response.data.length) {
                this.openLAHistory = response.data;
            }
        },
            (error) => {
                this._alertService.warn(this.errormsg);
            }
        );
    }



    showLivingArrangmentPopup1() {
        this.getcpsresponsetimerActions();
        if(this.isOpenFCNHSlivingarrangement) {
            this._globalPopupService.setlapopupFcnFHS(true);
            this._globalPopupService.setClientNamesFcnFHS(this.openFCNHSKidsList);
           
        } else {
            this._globalPopupService.setlapopup(true);
        }
    }



    laArrangementCheck(_flag: any) {
        let obj;
        if (this.openLAHistory && this.openLAHistory.length) {
            obj = {
                overduepopupid: this.openLAHistory[0].overduepopupid,
                intakeserviceid: this.id,
                securityuserid: this._authService.getCurrentUser().user.securityusersid,
                objectid: this.openLADetails.placementid,
                objecttype: this.openLAHistory[0].objecttype,
                revisioncount: this.openLAHistory[0].revisioncount + 1
            };
        }
        else {
            obj = {
                overduepopupid: null,
                intakeserviceid: this.id,
                securityuserid: this._authService.getCurrentUser().user.securityusersid,
                objectid: this.openLADetails.placementid,
                objecttype: 'LA',
                revisioncount: 1,
            };
        }
       
        this._commonHttpService.create(obj, 'overridepopup/addupdate').subscribe(
            () => {
                // No content to add or call
        },
            (error) => {
                this._alertService.warn(this.errormsg);
            });
    }

    //Restricted-Unrestricted User Story Changes
    getCountyList() {
        this._dsdsActionService.create({
            where: {},
            order: 'countyname',
            nolimit: true,
        }, 'admin/county/countylist').subscribe((item) => {
            this.countyList = item;
        });
    }

    countyChange(model: any, countyids?: any) {
        this._dsdsActionService.getArrayList({
            where: { countyids: countyids ? countyids : model.map((item: { countyid: any; }) => item.countyid) },
            nolimit: true,
            method: 'get'
        }, 'admin/userprofile/getusersbycountyids?filter').subscribe((data: any[]) => {
            this.countyCaseWorkersList = data.filter(item => item.roletypekey === 'CWCW');
            this.countySupervisorsList = data.filter(item => item.roletypekey === 'CWSP');
        });
    }

    declineUnrestrict() {
        (<any>$('#unrestrict-case-confirm-popup')).modal('hide'); // NOSONAR
    }

    initreasonForm() {
        this.reasonForm = this._formBuilder.group({
            reasontxt: ['']
        });
    }

    showReasonPopup() {
        this.reasonForm.reset();
        (<any>$('#reason-Popup')).modal('show'); // NOSONAR
    }

    showOverduePopup() {
        this.loadSupervisor();
        this.fromoverduelink = true;
        this.getcpsresponsetimerActions();
        setTimeout(() => {
            this.getresponsetimerduedate();
        }, 1000);
        (<any>$(this.overduepopupid)).modal('show'); // NOSONAR
    }
    closeReasonPopup() {
        this.reasonForm.reset();
        (<any>$('#reason-Popup')).modal('hide'); // NOSONAR

    }
    checkCaregiverInfo() {
        let caregiverInfoValid = true;
        if ((!this.hidecaregiverdropdown && this.caregiverreasonDropDown1?.length > 0 && this.selectCaregiverReason1 === undefined) ||
            (this.caregiverreasonDropDown2?.length > 0 && this.selectCaregiverReason2 === undefined && !this.enableCaregiverDataEntryErrorReason) ||
            (this.caregiverreasonDropDown3?.length > 0 && this.selectCaregiverReason3 === undefined)) {
            caregiverInfoValid = false;
        }
        return caregiverInfoValid;

    }
    submitOverdue() {
        if ((!this.hideallegeddropdown && this.allegedVictimreasonDropDown1?.length > 0 && this.selectAllegedVictimReason1 === undefined) ||
            (this.allegedVictimreasonDropDown2?.length > 0 && this.selectAllegedVictimReason2 === undefined && !this.enableAllegedDataEntryErrorReason) ||
            (this.allegedVictimreasonDropDown3?.length > 0 && this.selectAllegedVictimReason3 === undefined) ||
            (!this.hideotherchilddropdown && this.otherChildrenreasonDropDown1?.length > 0 && this.selectOtherChildReason1 === undefined) ||
            (this.otherChildrenreasonDropDown2?.length > 0 && this.selectOtherChildReason2 === undefined && !this.enableChildrenDataEntryErrorReason)  
        ) {
            this._alertService.error('select all mandatory fields.');
            return;
        }
        const caregiverInfoValid = this.checkCaregiverInfo();
        if (!caregiverInfoValid) {
            this._alertService.error('select all mandatory fields.');
            return;
        }
        if (!this.cpsActionSelectedSupervisor) {
            this._alertService.error('Select all mandatory fields.');
            return;
        }

        const obj = {
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
        this._commonHttpService.create(obj, 'cpsresponsetimeractions/addupdate').subscribe(() => {
            // No content to add or call
        },
        (error) => {
            this._alertService.warn(this.errormsg);
        });

        (<any>$(this.overduepopupid)).modal('hide'); // NOSONAR



    }
    closeOverduePopup() {
        let obj;
        if (this.cpsresponsetimeractionsid !== "") {
            const skipsplit = this.skipname?.split(" ");
            const skipsplitval: any = skipsplit ? parseInt(skipsplit[1]) + 1 : '';
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
       
        this._commonHttpService.create(obj, 'cpsresponsetimeractions/addupdate').subscribe(() => {
            // No content to add or call
        },
            (error) => {
                this._alertService.warn(this.errormsg);
            });

        (<any>$(this.overduepopupid)).modal('hide'); // NOSONAR
    }
    getcpsresponsetimerActions() {
        const obj = {
            "intakeserviceid": this.id
        }
        this._commonHttpService.create(obj, 'cpsresponsetimeractions/list').subscribe(response => {
            if (response?.data?.length > 0) {
                this.cpsResponseTimerList = response.data;
                this.hasSavedResponseTimerRecord = true;
                this.updateflags();         //SonarQube fix - moved the entire logic into small multiple function to reduce code complexity
                this.updateResponseTimer();

                this.updatebuttons(response);

                const saveddetails = response.data[0];

                this.selectedAllegedVictimReason1FromService(581, saveddetails.cpsresponsetimerreason1);
                this.selectedAllegedVictimReason2FromService(582, saveddetails.cpsresponsetimerreason2);

                this.selectedOtherChildReason1FromService(584, saveddetails.cpsresponsetimerreason4);
                this.selectedOtherChildReason2FromService(585, saveddetails.cpsresponsetimerreason5);

                this.selectedCaregiverReason1FromService(587, saveddetails.cpsresponsetimerreason7);
                this.selectedCaregiverReason2FromService(588, saveddetails.cpsresponsetimerreason8);
              
                this.getThirdDropdowns(saveddetails);
                this.setReasons(saveddetails);
            }
            else {
                this.hasSavedResponseTimerRecord = false;
                if (response.data === undefined) {
                    this.hideskipbtn = true;
                }
                const stdate = moment(this.dsdsActionsSummary.da_receiveddate, this.dtformat);
                const currenDate = moment(new Date()).format(this.dtformat);
                const endDate = moment(currenDate, this.dtformat);
                const resultdt = endDate.diff(stdate, 'days');
                if (this.responseTimerDueDateList?.malt_type === 'NEGLECT' && resultdt === 12) {
                    this.hideskipbtn = false;
                }
                if (this.responseTimerDueDateList?.malt_type === 'ABUSE' && resultdt === 8) {
                    this.hideskipbtn = false;
                }
            }
        },
            (error) => {
                this._alertService.warn(this.errormsg);
            }
        );
    }

    getThirdDropdowns(saveddetails: any) {
        if (saveddetails.cpsresponsetimerreason3) {
            this.selectAllegedVictimReason3 = saveddetails.cpsresponsetimerreason3;
            this.getAllegedVictimReasonDropdown3(saveddetails.cpsresponsetimerreason2);
        }

        if (saveddetails.cpsresponsetimerreason6) {
            this.selectOtherChildReason3 = saveddetails.cpsresponsetimerreason6;
            this.getOtherChildrenreasonDropDown3(saveddetails.cpsresponsetimerreason5);
        }

        if (saveddetails.cpsresponsetimerreason9) {
            this.selectCaregiverReason3 = saveddetails.cpsresponsetimerreason9;
            this.getCaregiverreasonDropDown3(saveddetails.cpsresponsetimerreason8);
        }
    }

    getAllegedVictimReasonDropdown3(selectedvalue: any) {
        this.allegedVictimreasonDropDown3 = [];
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 582, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {
                this.allegedVictimreasonDropDown3 = data;
            });
    }

    getOtherChildrenreasonDropDown3(selectedvalue: any) {
        this.otherChildrenreasonDropDown3 = [];
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 585, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {
                this.otherChildrenreasonDropDown3 = data;
            });
    }

    getCaregiverreasonDropDown3(selectedvalue: any) {
        this.caregiverreasonDropDown3 = [];
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 588, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {
                this.caregiverreasonDropDown3 = data;
            });
    }

    updateflags() {
        this.chkAllegedVictim =
            (this.cpsResponseTimerList[0]?.allegedvictimcontact === 'true' || this.cpsResponseTimerList[0]?.allegedvictimcontact === 'Y') ? true : false;
        this.hideallegeddropdown = false;
        if (this.chkAllegedVictim === true) {
            this.hideallegeddropdown = true;
        }
        this.chkOtherChild =
            (this.cpsResponseTimerList[0]?.otherchildrencontact === 'true' || this.cpsResponseTimerList[0]?.otherchildrencontact === 'Y') ? true : false;
        this.hideotherchilddropdown = false;
        if (this.chkOtherChild === true) {
            this.hideotherchilddropdown = true;
        }
        this.chkCaregiver =
            (this.cpsResponseTimerList[0]?.initialcaregivercontact === 'true' || this.cpsResponseTimerList[0]?.initialcaregivercontact === 'Y') ? true : false;
        this.hidecaregiverdropdown = false;
        if (this.chkCaregiver === true) {
            this.hidecaregiverdropdown = true;
        }
    }

    updateResponseTimer() {
        if (this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Save' && this.cpsResponseTimerList[0].approvedby === null) {
            this.hasSaveForApproval = true;
            this.canSaveResponseTimer = false;
            if (this.cpsResponseTimerList[0].routingstatustypeid === 17) {
                this.canSaveResponseTimer = true;
            }
            if (this.isSupervisor && this.hasSaveForApproval && !this.fromoverduelink) {
                this.fromoverduelink = false;
            } else {
                this.fromoverduelink = true;
            }
            this.cpsresponsetimeractionsid = this.cpsResponseTimerList[0].cpsresponsetimeractionsid;
        } else if (this.cpsResponseTimerList[0].cpsresponsetimeractiontype === 'Save' && this.cpsResponseTimerList[0].approvedby !== null
            && this.cpsResponseTimerList[0].routingstatustypeid === 16) {
            this.canSaveResponseTimer = false;
        }
    }

    updatebuttons(response: { data: any[]; }) {
        const time = moment.duration("04:00:00");
        const date = moment(response.data[0].updatedon, this.dtformat);
        const correcthrs = date.subtract(time);
        const duration = moment.duration(moment().diff(correcthrs));
        const hours = duration.asHours();
        if (response.data.length === 1 && response.data[0].cpsresponsetimeractiontype === 'Skip 1') {
            this.fromoverduelink = true;
            this.hideskipbtn = false;
            this.showapprovebtn = true;
            if (hours < 24) {
                this.hideskipbtn = true;
                this.showapprovebtn = false;
            }
        }
        if (response.data.length === 2 && response.data[1].cpsresponsetimeractiontype === 'Skip 2') {
            this.hideskipbtn = false;
            if (hours < 120) {
                this.hideskipbtn = true;
                this.showapprovebtn = false;
            }

        }
        this.fromoverduelink = true;
        if (response.data.length === 3 && response.data[2].cpsresponsetimeractiontype === 'Skip 3') {

            this.showreportSSAbtn = true;
            this.fromoverduelink = true;
        }

        this.prevSkipList = response.data.filter(s => s.isskipped === true);
        if (this.prevSkipList && this.prevSkipList.length) {
            this.cpsresponsetimeractionsid = this.prevSkipList[0].cpsresponsetimeractionsid;
            this.updatedOn = this.prevSkipList[0].updatedon;
            this.skipname = this.prevSkipList[0].cpsresponsetimeractiontype;
        }

    }

    setReasons(saveddetails: any) {
        this.selectAllegedVictimReason1 = saveddetails.cpsresponsetimerreason1;
        this.selectOtherChildReason1 = saveddetails.cpsresponsetimerreason4;
        this.selectCaregiverReason1 = saveddetails.cpsresponsetimerreason7;

        setTimeout(() => {
            this.selectAllegedVictimReason2 =
                this.isJson(saveddetails.cpsresponsetimerreason2) ? JSON.parse(saveddetails.cpsresponsetimerreason2) : saveddetails.cpsresponsetimerreason2;
            this.selectOtherChildReason2 =
                this.isJson(saveddetails.cpsresponsetimerreason5) ? JSON.parse(saveddetails.cpsresponsetimerreason5) : saveddetails.cpsresponsetimerreason5;
            this.selectCaregiverReason2 =
                this.isJson(saveddetails.cpsresponsetimerreason8) ? JSON.parse(saveddetails.cpsresponsetimerreason8) : saveddetails.cpsresponsetimerreason8;
        }, 1000);

        setTimeout(() => {
            this.selectAllegedVictimReason3 = saveddetails.cpsresponsetimerreason3;
            this.selectOtherChildReason3 = saveddetails.cpsresponsetimerreason6;
            this.selectCaregiverReason3 = saveddetails.cpsresponsetimerreason9;
        }, 3000);


        this.caseWorkerComment = saveddetails.caseworkercomments;
        this.reason = saveddetails.reason;

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

    isJson(str: any) {
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
            ).subscribe((data) => {
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
            ).subscribe((data) => {
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
            ).subscribe((data) => {
                this.caregiverreasonDropDown1 = data;

            });
    }
    selectedAllegedVictimReason1FromService(id: number | string, selectedvalue: string) {
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
            ).subscribe((data) => {
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
            ).subscribe((data) => {
                this.allegedVictimreasonDropDown2 = data;
                this.selectAllegedVictimReason2 = undefined;
                this.allegedVictimreasonDropDown3 = [];
                this.selectAllegedVictimReason3 = undefined;
            });
    }
    selectedAllegedVictimReason2FromService(id: string | number, selectedvalue: any) {
        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                    method: 'get'
                },
                this.gettypesurl + '?filter'
            ).subscribe((data) => {
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
            ).subscribe((data) => {
                this.allegedVictimreasonDropDown3 = data;
                this.selectAllegedVictimReason3 = undefined;

            });
    }
    selectedOtherChildReason1FromService(id: string | number, selectedvalue: string) {
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
        ).subscribe((data) => {
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
        ).subscribe((data) => {
            this.otherChildrenreasonDropDown2 = data;
            this.selectOtherChildReason2 = undefined;
            this.otherChildrenreasonDropDown3 = [];
            this.selectOtherChildReason3 = undefined;

        });
    }
    selectedOtherChildReason2FromService(id: string | number, selectedvalue: any) {
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data) => {
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
        ).subscribe((data) => {
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
        ).subscribe((data) => {

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
        ).subscribe((data) => {
            this.caregiverreasonDropDown2 = data;
            this.selectCaregiverReason2 = undefined;
            this.caregiverreasonDropDown3 = [];
            this.selectCaregiverReason3 = undefined;
        });
    }
    selectedCaregiverReason2FromService(id: string | number, selectedvalue: any) {
        this._commonHttpService.getArrayList(
            {
                where: { referencetypeid: id, teamtypekey: 'CW', parentkey: selectedvalue },
                method: 'get'
            },
            this.gettypesurl + '?filter'
        ).subscribe((data) => {
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
        ).subscribe((data) => {
            this.caregiverreasonDropDown3 = data;
            this.selectCaregiverReason3 = undefined;

        });
    }

    getresponsetimerduedate() {
        const isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const obj = {
            "intakeserviceid": this.id,
            "isExpungementSuperUser": isExpungementSuperUser,
            'iscaseexpunged': this.iscaseexpunged
        }
        this._commonHttpService.create(obj, 'cpsresponsetimeractions/duedate').subscribe(response => {
            this.responseTimerDueDateList = response.data;
             this._dataStoreService.setObj('responsetimerduedatelist', response);
            let time = moment.duration("04:00:00");
            let date;
            if (this.responseTimerDueDateList?.responsetimer_duedate) {
                if (moment(this.responseTimerDueDateList?.responsetimer_duedate) > moment(new Date())) {
                    this.responseTimerDueDateList.responsetimer_status = 'Stopped';
                }
                date = moment(this.responseTimerDueDateList?.responsetimer_duedate, this.dtformat);

                this.responseTimerDueDateFormatted = this.responseTimerDueDateList?.responsetimer_duedate_formatted;
                this.responseTimerDueDate = date.subtract(time);
            } else {
                this.responseTimerDueDate = null;
            }

            const canDeriveFromTimer = !this.hasSavedResponseTimerRecord;

            if (canDeriveFromTimer) {
                if (this.fromoverduelink === true) {
                    this.chkAllegedVictim = null;
                    this.chkOtherChild = null;
                    this.chkCaregiver = null;
                }
                this.updateVictimChildCaregriverflags(response);   //SonarQube - moved the logic to seperate function to reduce code complexity

                if (['N', 'L'].includes(response?.data?.icc_contact_sw)) {
                    this.hidecaregiverdropdown = false;
                    this.hidedropdowns = false;

                }
            }

            date = moment(this.responseTimerDate, this.dtformat);
            const correcthrs = date.subtract(time);
            this.isResponseTimerGreaterthanoverdue = false;
            if (this.responseTimerDate && this.responseTimerDueDate && moment(correcthrs) > moment(this.responseTimerDueDate)) {
                this.isResponseTimerGreaterthanoverdue = true;
            }

            if (canDeriveFromTimer) {
                this.allegedVictimChange('580');
                this.otherChildChange('583');
                this.caregiverChange('586');
            }
        },
            (error) => {
                this._alertService.warn('Error in fetching data.');
            });
    }
    updateVictimChildCaregriverflags(response: any) {
        this.chkAllegedVictim = ((this.chkAllegedVictim === undefined || this.chkAllegedVictim === null) && response?.data?.alleged_victim_contact_sw === 'Y') ? true : false;
        this.chkOtherChild = ((this.chkOtherChild === undefined || this.chkOtherChild === null) && response?.data?.other_children_contact_sw === 'Y') ? true : false;
        this.chkCaregiver = ((this.chkCaregiver === undefined || this.chkCaregiver === null) && response?.data?.icc_contact_sw === 'Y') ? true : false;

        if (this.chkAllegedVictim === false) {
            this.hideallegeddropdown = false;
            this.hidedropdowns = false;
        } else {
            this.hideallegeddropdown = true;
            this.hidedropdowns = true;
        }
        if (this.chkOtherChild === false) {
            this.hideotherchilddropdown = false;

        } else {
            this.hideotherchilddropdown = true;
            this.hidedropdowns = true;
        }
        if (this.chkCaregiver === false) {
            this.hidecaregiverdropdown = false;

        } else {
            this.hidecaregiverdropdown = true;
            this.hidedropdowns = true;
        }
    }

    cancelPopup() {
        (<any>$(this.overduepopupid)).modal('hide'); // NOSONAR
        this.clearcontrol();
    }
    sendForApproval() {
        const caseWorker = this._authService.getCurrentUser();
        const supervisorId = caseWorker.user.userprofile.supervisorid;
        const obj = {
            intakeserviceid: this.id,
            approvalstatus: 15,
            approvedby: supervisorId
        };


        this._commonHttpService.create(obj, 'cpsresponsetimeractions/skip2routing').subscribe(response => {
            this.getcpsresponsetimerActions();
            this.clearcontrol();
        },
            (error) => {
                this._alertService.warn(this.errormsg);
            });

        (<any>$(this.overduepopupid)).modal('hide'); // NOSONAR
    }
    clearcontrol() {
        this.selectAllegedVictimReason1 = undefined;
        this.allegedVictimreasonDropDown2 = [];
        this.selectAllegedVictimReason2 = undefined;
        this.allegedVictimreasonDropDown3 = [];
        this.selectAllegedVictimReason3 = undefined;

        this.selectOtherChildReason1 = undefined;
        this.otherChildrenreasonDropDown2 = [];
        this.selectOtherChildReason2 = undefined;
        this.otherChildrenreasonDropDown3 = [];
        this.selectOtherChildReason3 = undefined;

        this.selectCaregiverReason1 = undefined;
        this.caregiverreasonDropDown2 = [];
        this.selectCaregiverReason2 = undefined;
        this.caregiverreasonDropDown3 = [];
        this.selectCaregiverReason3 = undefined;
        this.reason = "";


    }

    changeSupervisor(_event: any) {
        // No data or function to call
    }

    onSorted(_event: any) {
        // No data or function to call
    }

}
import { Component, Injector, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatRadioChange } from '@angular/material/radio';
import { Router } from '@angular/router';
import jsPDF from 'jspdf';
import _, { cloneDeep } from 'lodash';
import moment from 'moment';
import { config } from '../../../../../../environments/config';
// import html2canvas from 'html2canvas';
import { ProgressSpinnerMode } from '@angular/material/progress-spinner';
import { AppConstants } from '../../../../../@core/common/constants';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, AuthService, CommonDropdownsService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { SignatureFieldComponent } from '../../../../../shared/modules/common-controls/signature-field/signature-field.component';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { IntakeStoreConstants } from '../../../../newintake/my-newintake/my-newintake.constants';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { DSDSActionSummary, ServicePlanAction, ServicePlanFocus, ServicePlanService } from '../../../_entities/caseworker.data.model';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';

@Component({
    selector: 'service-plan-core',
    host: {
        class: 'service-plan-core'
    },
    templateUrl: './service-plan-core.component.html',
    styleUrls: ['./service-plan-core.component.scss'],
    standalone: false
})
export class ServicePlanCoreComponent implements OnInit, OnDestroy {
  @ViewChild(SignatureFieldComponent)
  public signaturePad!: SignatureFieldComponent;
  dsdsActionsSummary = new DSDSActionSummary();
  percentageInprogress = 0;
  percentageAchieved = 0;
  percentageNotAchieved = 0;

  actionPersonList!: any[];
  approvalProcess!: string;
  selectedItem!: string;
  selectedPlan!: string;

  // selectedList: ServicePlanService[] = [];
  // idx: number;


  serviceplanstartdate: any;
  serviceplanenddate: any;
  selectedServiceList = [];
  listSnapShot: any[] = [];
  selectedActionList = [];
  selectedFocusList = [];
  serviceplanobjective: any;
  servicePlanFormGroup!: FormGroup;
  servicePlanForm!: FormGroup;
  focusPlanFormGroup!: FormGroup;
  actionPlanFormGroup!: FormGroup;
  candidacyFormGroup!: FormGroup;
  candidacyFormGroupIsChildComp: boolean = false;
  candidacyFormGroupIsChildCompSaved: boolean = false;
  candidacyFormGroupIsChildComp1: boolean = false;
  candidacyFormGroup1!: FormGroup;
  candidacyFormGroup2!: FormGroup;
  selectedService: any;
  backupService!: ServicePlanService;
  currSelectedService!: ServicePlanService;
  selectedAction!: ServicePlanAction | null;
  selectedFocus!: ServicePlanFocus | null;
  signatureFormGroup?: FormGroup;
  showAssignButton: boolean = true;
  showGoalReason: boolean = false;
  mindate!: Date;
  getUsersList: any[] = [];
  selectedPerson: any;
  cansfData: any;
  intakeserviceid = '';
  daNumber = '';
  cansFNeedsList!: any[];
  cansFStrengthList!: any[];
  sectionList: string[] = [];
  personList!: any[];
  personListName: any;
  personDataList!: any[];
  childList: any[] = [];
  childCandidates: any = [];
  childCandidatesTraditional: any = [];
  childrenHeader: any[] = [];
  legalGuardian = '';
  caseWorker = '';
  caseWorkerPh: any = null;
  user!: AppUser;
  paginationInfo: PaginationInfo = new PaginationInfo();

  cansFNeedsData!: any[];
  cansFStrengthsData!: any[];
  cansNeedsData!: any[];
  cansStrengthsData!: any[];

  focusNeeds!: any[];
  focusStrengths!: any[];
  isAssementCompleted!: boolean;
  totalActions!: number;
  completedAction!: number;
  deletetype: any;
  deleteObject: any;

  baseUrl: string;
  before: any = "before";
  // Visitation Plan
  selectedServiceVisitationPlans: any [] = [];
  visitationPlansFormGroup!: FormGroup;

  //--new visitation plan
  //--new visitation plan
  visitationPlanFormGroup!: FormGroup;
  visitationplans: any[] = [];
  visitationplansresponse: any[] = [];

  // YTP Variables
  ytpList: any[] = [];
  selectedYTP: any;
  serviceplanslist: ServicePlanService[] = [];
  isAddPlan: boolean = true;
  serviceplanversions: any[] = [];
  selectedServicePlan: any;
  serviceplangoals: any[] = [];
  serviceplanobjectives: any[] = [];
  color = 'primary';
  mode: ProgressSpinnerMode  = 'determinate';

  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
  servicePlanGoal?: FormGroup;

  //Reference Dropdown values

  childandvisitortransportation: any[] = [];
  frequencyofplannedvisits: any[] = [];
  lengthofplannedvisit: any[] = [];
  riskList: any[] = [];

  // Goals
  // Goals
  splanGoalsFormGroup!: FormGroup;
  selectedObjective: any;
  selectedGoal: any;
  goalReferenceValues: any = [];
  goalReasonRefValues: any = [];
  servicePlanNameReferenceValues: any = [];
  isOtherGoal = false;
  servicePlanNeed!: FormGroup;
  servicePlanStrength!: FormGroup;
  isSupervisor = false;
  isServiceCase = false;
  isAdoptionCase = false;
  

  //Status values
  goalStatusReferenceValues: any = [];
  objectiveStatusReferenceValues: any = [];
  actionStatusReferenceValues: any = [];

  //New Signature
  //New Signature
  personSignatureFormGroup!: FormGroup;
  signaturePersonTypes: any = [];
  personlistforsnapshot!: any[];

  //Snapshot Version
  selectedSnapshotVersion: any;
  selectedSignaturesList: any = [];
  achievedActions!: number;
  inProgressActions!: number;
  notAchievedActions!: number;
  completedPercentage!: number;
  minContactDate = new Date();
  count: any;
  countobj!: number;
  isReadonly = true;
  indexval:any;
  visitation = false;
  selectServiceFn: any;
  snapshotFilterFormGroup!: FormGroup;
  isClosed = false;
  openObj!: boolean;
  goalerrormsg = false;
  goalerrormsg1 = false;
  isObjective = false;
  isAction = false;
  serviceGoal = true;
  serviceObjective = true;
  isGoalAdded!: boolean;
  serviceAction!: boolean;
  goalResponse: any;
  serviceobject: any;
  serviceEditObjective!: boolean;
  addObjective!: boolean;
  editUpdateGoal!: boolean;
  showInfo = true;
  showActionForm: boolean = false;
  showvisitplan: boolean = false;

  autoSaveInitiated: boolean = false;
  autoSaveIntervalTimer!: any;
  saveType: any;
  currentGoalData: any
  goalAutoSaved: boolean = false;
  actionAutoSaved: boolean = false;
  currentObjectiveData: any
  currentActionData: any
  lastUpdatedTime: any = null;
  lastActionUpdatedTime: any = null;
  candidacyMaxDate: any;
  candidacyMinDate: any;

  goalAutoSaveIntervalTimer!: any; 
  objctiveAutoSaveIntervalTimer!: any; 
  actionAutoSaveIntervalTimer!: any; 

  goalAutoSaveInitiated: boolean = false;
  objectiveAutoSaveInitiated: boolean = false;
  actionAutoSaveInitiated: boolean = false;
  objectiveAutoSaved:boolean = false;
  isVersionEbpNotCompleted:boolean = false;
  versionSaveEnabled:boolean = false;
  lastObjectiveUpdatedTime: any = null;
  involvedPersonForm: any[] = [];
  involvedPersonFormChange: any[] = [];
  isEbpReferralMade: boolean = false;
  clientNamesForEbp: any[] = [];
  servicePlanWithEbpYes: any[] = [];
  selectPersonNameList: string[] = [];
  selectedClientName: string = '';
  selectedSnapShotData: any;
  candidacyRoles: string[] = ['CHILD', 'OTHERCHILD', 'AV'];

  disableSubmit: boolean = false;
  editserviceplan: boolean =false;
  editServicePlanData: any = '';
  checkmandatory: boolean =false;
  visitationplanrequired: boolean =false;
  eligibilitydetcheck: boolean =false;
  goalrequired: boolean =false;
  requiredfield :boolean = true;
  actioplanrequired: boolean =false;
  checkcandidacyform: boolean=false;
  focusplanmandatory: boolean=false;

  addservicepopupid = '#add-service';
  deletepopupid = '#delete-popup';
  mandatorymsg = 'Please fill all required fields';
  addfocuspopupid = '#add-focus';
  autosavemsg = 'Auto Save cannot be triggered at this time as the mandatory fields are not filled to proceed.';
  dtformat = 'MM/DD/YYYY h:mm:ss A';
  notachieved = 'Not Achieved';
  inprogress = 'In Progress';
  caseassignpopupid = '#intake-caseassignnewX';
  ebpwarningpopup ='#ebp-warning-message';
  displayorder = 'insertedon desc';
  ebpUtilizationTypes: any;
  isEbpAddServicePlan: boolean = false;
  sourcecaseheadname = '';
  caseheadname = '';
  isNewPlan: boolean = false;
  isReopenedCase: boolean = false;
  actionTexts: any = {
    "Functional Family Therapy": " will participate in Functional Family Therapy (FFT) over the next 3-5 months",
    "Multisystemic Therapy": " will participate in Multisystemic Therapy (MST) over the next 4-6 months",
    "Parent Child Interaction Therapy": " will participate in Parent Child Interaction Therapy (PCIT) over the next year",
    "Healthy Families America" : " will participate in Healthy Families America (HFA) over the next year"
  };
  headofhouseholdName: any;
  headofhouseholPersonId: any;
  CandidacyFormGroupList: any[] = [];
  CandidacyTradFormGroupList: any[] = [];
  CandidacyFormGroup1List: any[] = [];
  CandidacyTradFormGroup1List: any[] = [];
  CandidacyFormGroup2List: any[] = [];
  CandidacyTradFormGroup2List: any[] = [];


     private readonly _formBuilder: FormBuilder;
     private readonly  _commonhttp: CommonHttpService;
      private readonly _alertservice: AlertService;
       private readonly  _datastore: DataStoreService;
      public _authService: AuthService;
      private readonly _router: Router;
      private readonly storage: SessionStorageService;
      private readonly _dataStoreService: DataStoreService;
      private readonly _commonDropdownService: CommonDropdownsService;

      constructor(private injector:Injector,private html2canvas:Html2CanvasService) {
            this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
            this._commonhttp = this.injector.get<CommonHttpService>(CommonHttpService);
            this._alertservice = this.injector.get<AlertService>(AlertService);
            this._datastore = this.injector.get<DataStoreService>(DataStoreService);
            this._authService = this.injector.get<AuthService>(AuthService);
            this._router = this.injector.get<Router>(Router);
            this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
            this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
            this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
            
            this.baseUrl = AppConfig.baseUrl;
  }

  ngOnInit() {
    this.candidacyMaxDate = new Date();
    this.dsdsActionsSummary= this._dataStoreService.getData('dsdsActionsSummary');
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole === 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =this._authService.readonlyButton('read_only_access','caseworker-service-plan-add-new');}
    this.cansFNeedsList = [];
    this.cansFStrengthList = [];

    this.paginationInfo.sortBy = 'asc';
    this.paginationInfo.sortColumn = 'clientname';

    this.intakeserviceid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.personDataList = [];
    this.setMinContactDate();
    this.visitation = true;
    this.selectServiceFn = this.selectService;

    // to be developed: Decide when or where to call this DB persistence of Assessments
    this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.user = this._authService.getCurrentUser();
    if (this.user.role.id === '71') {
      this.caseWorker = this.user.user.userprofile.displayname;
      this.caseWorkerPh = this.user.user.userprofile.userprofilephonenumber.length > 0 ? this.user.user.userprofile.userprofilephonenumber[0].phonenumber : '';
    }
    this._commonDropdownService.getReferenveValuesByTypeId('10001')
      .subscribe( (response) => { 
        response.sort(function (a, b) {
          return a.displayorder - b.displayorder;
        });
        this.ebpUtilizationTypes = response;
      })
    this.getServicePlanNameReferenceValues();
    this.getInvolvedPerson();
    this.getCollateralPerson();
    this.getPersonListWithProgramAssignment();
    this.getNeeds();
    this.getStrengths();
    this.selectedItem = 'Empty';

    this.initForms();
    this.getReferenceDropdowns();

    this.getGoalReferenceValues();
    this.getGoalReasonRefValues();
    this.getStatusReferenceValues();
    this.getYTPList();
    
    this.getVisitationPlans();
    //Signatures
    this.getSignaturePersonTypeReferenceValues();
    this.initPersonSignatureFormGroup();
    this.initSnapshotFilterFormGroup();

    this.isAssementCompleted = false;
    this.isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    const caseType = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        
    if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
        this.isAdoptionCase = true;
    }
    const da_status = this.storage.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
    
    this.existingForm();
    
    this.servicePlanGoalFn();

    this.focusPlanFormGroupFn();

    this.actionPlanFormGroupFn();


  }
  // Assosiated with ngOnInit function
  private actionPlanFormGroupFn() {
    this.actionPlanFormGroup.valueChanges.subscribe((_val: any) => {

      clearInterval(this.goalAutoSaveIntervalTimer);
      clearInterval(this.objctiveAutoSaveIntervalTimer);

      const latestActionData = this.actionPlanFormGroup.getRawValue();
      latestActionData.planfor = (latestActionData.planfor === null) ? 'In Home' : latestActionData.planfor;
      this.currentActionData.planfor = (this.currentActionData.planfor === null) ? 'In Home' : this.currentActionData.planfor;
      this.currentActionData.comments = (latestActionData.comments === null && this.currentActionData.comments === '') ? null : this.currentActionData.comments;
      this.currentActionData.serviceplanactionid = (latestActionData.serviceplanactionid === null && this.currentActionData.serviceplanactionid === '')
        ? null : this.currentActionData.serviceplanactionid;
      this.currentActionData.serviceplanoutcome = (latestActionData.serviceplanoutcome === null && this.currentActionData.serviceplanoutcome === '')
        ? null : this.currentActionData.serviceplanoutcome;
      const isActionChanged = _.isEqual(this.currentActionData, latestActionData);

      if (!isActionChanged && !this.actionAutoSaveInitiated) {
        this.initiateActionAutoSave();
      }
    });
  }
  // Assosiated with ngOnInit function
  private focusPlanFormGroupFn() {
    this.focusPlanFormGroup.valueChanges.subscribe((_val: any) => {

      clearInterval(this.goalAutoSaveIntervalTimer);
      clearInterval(this.actionAutoSaveIntervalTimer);

      const latestObjectiveData = this.focusPlanFormGroup.getRawValue();

      latestObjectiveData.comments = (latestObjectiveData.comments === null) ? '' : latestObjectiveData.comments;
      this.currentObjectiveData.comments = (this.currentObjectiveData.comments === null) ? '' : this.currentObjectiveData.comments;
      const isObjectiveChanged = _.isEqual(this.currentObjectiveData, latestObjectiveData);

      if (!this.objectiveAutoSaveInitiated && !isObjectiveChanged) {
        this.initiateObjectiveAutoSave();
      }

    });
  }
  // Assosiated with ngOnInit function
  private servicePlanGoalFn() {
    this.servicePlanGoal?.valueChanges.subscribe((val) => {
      const latestGoalData = this.servicePlanGoal?.getRawValue();
      if (latestGoalData.goalname !== null) {
        clearInterval(this.objctiveAutoSaveIntervalTimer);
        clearInterval(this.actionAutoSaveIntervalTimer);
        const isGoalChanged = _.isEqual(this.currentGoalData, latestGoalData);
        if (!isGoalChanged && !this.goalAutoSaveInitiated) {
          this.initiateGoalAutoSave();
        }
      }
    });
  }

  ngOnDestroy() {
    clearInterval(this._datastore.getData('autoAddServicePlaceTimer'));
    clearInterval(this._datastore.getData('goalAutoSavePlaceTimer'));
    clearInterval(this._datastore.getData('objctiveAutoSavePlaceTimer'));
    clearInterval(this._datastore.getData('actionAutoSavePlaceTimer'));
  }

  getReferenceDropdowns() {
    this._commonDropdownService.getReferenveValuesByTypeId('50042')
      .subscribe( (response) => { this.childandvisitortransportation = response });
    this._commonDropdownService.getReferenveValuesByTypeId('50084')
      .subscribe( (response) => { this.frequencyofplannedvisits = response });    
    this._commonDropdownService.getReferenveValuesByTypeId('500108')
      .subscribe( (response) => { this.lengthofplannedvisit = response });
    this._commonDropdownService.getReferenveValuesByTypeId('516')
      .subscribe( (response) => { this.riskList = response });  
  }

  initForms() {
    this.servicePlanFormGroup = this._formBuilder.group({
      serviceplanname: [''],
      effectivedate: [null, Validators.required],
      serviceplanid: [null],
      enddate: [null],
      numberofdays: [null],
      activeflag: [1],
      targetenddate: [null, Validators.required]
    });

    this.servicePlanForm = this._formBuilder.group({
     enddate: [null]
    });

    this.servicePlanGoal = this._formBuilder.group({
      goalname: [{value: null, disabled: this.isOtherGoal}],
      splangoalid: [null],
      status: [''],
      autoflag: 0
     });

     this.servicePlanNeed = this._formBuilder.group({
      serviceplanneedname: [null]
     });

     this.servicePlanStrength = this._formBuilder.group({
      serviceplanstrengthname: [null]
     });

    this.focusPlanFormGroup = this._formBuilder.group({
      objectivename: [null, Validators.required],
      needs: [null],
      strengths: [null],
      splanobjectiveid: [null],
      otherneeds: [null],
      otherstrength: [null],
      comments: [''],
      status: [null, Validators.required],
      autoflag: [0]
    });

    this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();

    this.actionPlanFormGroup = this._formBuilder.group({
      serviceplanactionname: [null, Validators.required],
      serviceplanactionid: [''],
      enddate: [null, Validators.required],
      startdate: [null, Validators.required],
      status: [null, Validators.required],
      // plantype: [null],
      planfor: ['In Home'],
      personresponsible: [null, Validators.required],
      // serviceplanpersoninvolved: [null, Validators.required]
      personinvolved: [null, Validators.required],
      serviceplanoutcome: [''],
      comments: [''],
      goalreason: [''],
      autoflag: [0]
    });

    this.currentActionData = this.actionPlanFormGroup.getRawValue();

    this.initVisitationPlansFormGroup();
    this.initVisitationPlanFormGroup();
    this.initCandidacyForm();
    this.initCandidacyForm1();
    this.initCandidacyForm2();
    this.initSignatureFormGroup();

    // @Simar - new stuff
    // this.initSPlanGoalsFormGroup();
  }

  /**
   * Service Plan
   */
  getServicePlans(id?: any, isCreateServicePlan? : any) {
    const payload = {
      method: 'get',
      where: {
        caseid: this.intakeserviceid
      }
    };
    this._commonhttp.getArrayList(payload, 'serviceplan/listbyallrelation?filter').subscribe(
      response => {
        try {
          // @Simar: ANSHUL => New requirement that Supervisor can add and work on draft service plans

          this.listbyallrelationApiResponseLoopFn(response);
          this.serviceplanslist = response;
          if (response && response.length) {
            this.handleGetServicePlansRespFn(id, response);
            this.serviceplanslist.forEach((plan: any) => {                
              plan['isReady'] = this.isSpReadyForReview();
              // Trigger the history lookup by default so dates load instantly CIDM-11575
              this.getHistForCompletionDate(plan.serviceplanid); 
          });
          } else {
            this.isAddPlan = false;
          }
          if (this.serviceplanslist && this.serviceplanslist.length) {
            this.serviceplanstartdate = this.serviceplanslist[0].effectivedate;
            this.serviceplanenddate = this.serviceplanslist[0].enddate;
            this.serviceplanslist.forEach((plan: any) => {                
                plan['isReady'] = this.isSpReadyForReview();
            });
          }
          this.ifSelectedServiceFn(response);

          response.forEach(service => {
            if (Array.isArray(service.serviceplanfocus)) {
              service.serviceplanfocus.map((objective: any) => {
                this.timecheck(objective);
              });
            }
          });
        } catch (error) {
          console.error(error);
        } finally {
          this.disableSubmit = false;
          this.getservicecasedisposition();
        }
      },
      error => this.disableSubmit = false, () => this.disableSubmit = false);
  }
  // Assosiated with getServicePlans function
  private handleGetServicePlansRespFn(id: any, response: any[]) {
    const selectedServicePlanid = id ? id : this.storage.getItem(CASE_STORE_CONSTANTS.SERVICEPLAN_ID);
    this.selectedServicePlan = id ? response.find((e: any) => selectedServicePlanid === e.serviceplanid) : response[0];
    let i = 0, index = 0;
    if (selectedServicePlanid != null && selectedServicePlanid !== undefined) {
      response.forEach(element => {
        index = this.checkServiceplanidFn(element, selectedServicePlanid, index, i);
        i = i + 1;
      });
    }
    this.resetCandidacy();
    this.selectPlan(this.selectedServicePlan, index);
    this.focusPlanFormGroup.disable();
    this.actionPlanFormGroup.disable();
    this.isGoalAdded = this.selectedServicePlan.splangoal.length > 0 ? true : false;
    if (this.isGoalAdded) {
      this.focusPlanFormGroup.enable();
      this.actionPlanFormGroup.enable();
    }
    const planNew = this.serviceplanslist.filter((e: any) => e?.serviceplanname?.includes(" Family Service plan"));
    this.isNewPlan = (planNew.length > 0);
    if (this.sourcecaseheadname) {
      this.caseheadname = this.isNewPlan ? (this.sourcecaseheadname + ' ' + (planNew.length + 1)) : this.sourcecaseheadname;
    }
  }

  // Assosiated with getServicePlans function
  private checkServiceplanidFn(element: any, selectedServicePlanid: any, index: number, i: number) {
    if (element.serviceplanid === selectedServicePlanid) {
      this.selectedServicePlan = element;
      index = i;
    }
    return index;
  }
  // Assosiated with getServicePlans function
  private ifSelectedServiceFn(response: any[]) {
    if (this.selectedService) {
      this.selectedService = response.find(item => item.serviceplanid === this.selectedService.serviceplanid);
      const minimumDate = new Date(this.selectedService.effectivedate);
      minimumDate.setHours(0);
      minimumDate.setMinutes(0);
      minimumDate.setSeconds(0);
      this.candidacyMinDate = minimumDate;
      this.calculation(this.selectedService);
      if (this.selectedGoal) {
        this.selectedGoal = this.selectedService.splangoal.find((item: { splangoalid: any; }) => item.splangoalid === this.selectedGoal.splangoalid);
        if (this.selectedObjective) {
          this.selectedObjective = this.selectedGoal.splanobjective.find((item: { splanobjectiveid: any; }) => item.splanobjectiveid === this.selectedObjective.splanobjectiveid);
        }
      }
      this.getHistForCompletionDate(this.selectedService.serviceplanid);
    }
  }
  // Assosiated with getServicePlans function
  private listbyallrelationApiResponseLoopFn(response: any[]) {
    if (response.length > 0) {
      response.forEach(element => {
        if (element.involvedpersons && element.involvedpersons.persons) {
          element.involvedpersons = element.involvedpersons.persons;
        }
      });
    }
  }

  addServicePlan(activeflag: any) {
    this.checkmandatory = true;
    if (this.servicePlanFormGroup.valid || activeflag === 0) {
      try {
        this.disableSubmit = true;
        const service = (activeflag === 1) ? this.servicePlanFormGroup.getRawValue() : this.selectedService;
        service.objectid = this.intakeserviceid;
        service.activeflag = activeflag;
        service.involvedpersons = this.involvedPersonForm;
        const validForm = this.returnServiceRoomFn(service);

        if(!validForm && !(this.editserviceplan )) {
          this._alertservice.warn('Please fill the mandatory fields');
          this.disableSubmit = false;
          return;
        }
        if (activeflag === 1 && !this.headofhouseholdName) {
          this._alertservice.warn('This case does not have a Head of Household. Please add the Head of Household in persons screen.');
          return;
        }

        const involvedpersons = {
          'persons': service.involvedpersons
        }

        service.involvedpersons = involvedpersons;

        this.servicePlanFormGroup.reset();
        this.addupdateServicePlanFn(service, activeflag);
      } catch (e) {
        this.disableSubmit = false;
        throw e;
      }
    }
    else {
      this._alertservice.error(this.mandatorymsg);
    }
  }
  // Assosiation with addServicePlan function
  private addupdateServicePlanFn(service: any, activeflag: any) {
    service.effectivedate = moment(service.effectivedate).format('MM/DD/YYYY');
    service.targetenddate = moment(service.targetenddate).format('MM/DD/YYYY');
    this._commonhttp.create(service, 'serviceplan/addupdate').subscribe(response => {
      try {
        this.selectedItem = (activeflag === 1) ? 'service' : 'Empty';
        delete response.where;
        this.getServicePlans(response.serviceplanid, (activeflag === 1 && service.serviceplanid === null));
        if (activeflag === 1 && service.serviceplanid === null) {
          this._alertservice.success('Service plan created successfully.');
          this.createChildTask(response.serviceplanid, this.involvedPersonForm, service.effectivedate, service.targetenddate);
        } else if (activeflag === 1 && service.serviceplanid != null) {
          this._alertservice.success('Service plan updated successfully.');
        } else {
          this._alertservice.success('Service plan deleted successfully.');
        }
        this.involvedPersonForm = [];
        this.involvedPersonFormChange = [];
        this.cancelServicePlanSave();
        ( < any > $(this.addservicepopupid)).modal('hide');
        ( < any > $(this.deletepopupid)).modal('hide');
      } catch (e) {
        this.disableSubmit = false;
        throw e;
      }
    }, error => {
      this.disableSubmit = false;
      this._alertservice.error('Error in creating Service plan.');
      ( < any > $(this.deletepopupid)).modal('hide');
    }, () => this.disableSubmit = false);
  }
  
  async createChildTask(serviceplanid: any, data: any, startdate: any, enddate: any, cb?: any) {
    let goalDetails: any[] = [];
    data = data.filter((child: any) => child?.ebp.utilized === 'Yes');
    if (data.length === 0) {
      if (cb) {
        cb(goalDetails);
      }
      return;
    }
  
    for (const element of data) {
      const person = this.personList.find((e: any) =>
        e.fullname.replace(/\s+/g, '') === element.name.replace(/\s+/g, '')
      );
  
      if (!person) continue;
  
      const personid = person.personid;
      const name = element.ebp.utilizedtypes !== 'Other' ? this.actionTexts[element.ebp.utilizedtypes] : element.ebp.notes;
  
      const goal = {
        goalname: "Youth are safely maintained in their homes whenever possible and appropriate",
        splangoalid: null,
        status: "In Progress",
        activeflag: 1,
        autoflag: 1,
        serviceplanid: serviceplanid,
        securityuserid: this._authService.getCurrentUser().user.securityusersid
      };
  
      try {
        const response1: any = await this._commonhttp.create(goal, '/splangoal/addupdate').toPromise();
  
        const objective = {
          objectivename: `Enhance parenting skills to address challenging behaviors of ${element.name} by completing the identified prevention service.`,
          needs: "null",
          strengths: "null",
          splanobjectiveid: null,
          otherneeds: null,
          otherstrength: null,
          comments: null,
          status: "In Progress",
          activeflag: 1,
          autoflag: 1,
          splangoalid: response1.splangoalid,
          serviceplanid: serviceplanid,
          securityuserid: this._authService.getCurrentUser().user.securityusersid
        };
  
        const response2: any = await this._commonhttp.create(objective, 'splanobjective/addupdate').toPromise();
  
        const action = {
          serviceplanactionname: `${element.name} ${name}`,
          serviceplanactionid: null,
          enddate: enddate,
          startdate: startdate,
          status: "In Progress",
          planfor: "GAP",
          personresponsible: [this.headofhouseholdName],
          personinvolved: [personid, this.headofhouseholPersonId],
          serviceplanoutcome: null,
          comments: null,
          goalreason: null,
          splanobjectiveid: response2.splanobjectiveid,
          objectid: this.intakeserviceid,
          activeflag: 1,
          autoflag: (element.ebp.utilizedtypes !== 'Other') ? 1 : 0,
          serviceplanpersoninvolved: [personid, this.headofhouseholPersonId],
          securityuserid: this._authService.getCurrentUser().user.securityusersid
        };
  
        const response3: any = await this._commonhttp.create(action, 'serviceplanaction/addupdate').toPromise();
        response1.splanobjective = [response2];
        response1.serviceplanaction = [response3];
        goalDetails.push(response1);
      } catch (error) {
        console.error("Error occurred:", error);
      }
    }
  
    this.getServicePlans();
    if (cb) {
      cb(goalDetails);
    }
  }
  
  // Assosiation with addServicePlan function
  private returnServiceRoomFn(service: any) {
    let validForm = true;
    service.involvedpersons.map((element: any) => {
      if (element.imminentrisks.indexOf('OTH') > -1 && element.comment === null) {
        validForm = false;
      }
      if (element.imminentrisks.indexOf('INK') > -1
        && (element.livingininformalkinship === null || (element.livingininformalkinship === 'others' && element.comment === null))) {
        validForm = false;
      }
      if (element.imminentrisks.length === 0) {
        validForm = false;
      }
    });
    return validForm;
  }

    selectPlan(item: any, index: any,isClick? : boolean) {
        this.selectedServicePlan = item;
        this.getImminentRiskReason();
        this.storage.setItem(CASE_STORE_CONSTANTS.SERVICEPLAN_ID, item.serviceplanid);
        this.isGoalAdded = this.selectedServicePlan.splangoal.length > 0 ? true : false;
        //Scrolll the screen to the service plan workspace when selected a plan
        // var contentElement = document.getElementById("splan_content");
        // contentElement.scrollIntoView({behavior: "smooth", block: "nearest", inline: "start"});
        // if (contentElement) {
        //   contentElement.scrollIntoView(true);
        // }

        this.selectService(item, index);
        this.handleServiceplancandidacyFn(item);
        if (isClick) {
          this.getHistForCompletionDate(item.serviceplanid);
        }
      }
      // Assosiated to selectPlan method
  private handleServiceplancandidacyFn(item: any) {
    if (!item.serviceplancandidacy && item.involvedpersons && item.involvedpersons.length > 0) {
      const control = <FormArray>this.candidacyFormGroup.get('candidates');
      const controlTraditional = <FormArray>this.candidacyFormGroup.get('candidatestraditional');
      control.controls = [];
      controlTraditional.clear();
      item.involvedpersons.forEach((element: any) => {
        if (element.imminentrisks && element.imminentrisks.length > 0 && !element.imminentrisks.includes('NONE') && element.ebp) {
          this.handleIfImminentrisksFn(element, control, controlTraditional);
        }

      });
    }
  }
  // Assosiated to selectPlan method
  private handleIfImminentrisksFn(element: any, control: FormArray, controlTraditional: FormArray) {
    let imminentrisksD: any[] = [];
    if (element.imminentrisks && element.imminentrisks.length > 0) {
      element.imminentrisks.forEach((ele: any) => {
        imminentrisksD.push(new FormControl(ele));
      });
    }
    this.popImminentrisks(element, control, controlTraditional, imminentrisksD);
  }
  popImminentrisks(element: any, control: FormArray, controlTraditional: FormArray, imminentrisksD: any) {
    if (element.ebp.familyFirstPrevention) {
      control.push(this._formBuilder.group({
        id: element.id,
        name: element.name,
        candidacy: "1",
        candidacydate: new Date(),
        disabledate: false,
        details: element.details,
        imminentrisks: (!element.imminentrisks.includes('NONE')) ? new FormArray(imminentrisksD) : null,
        ebp: element.ebp,
        disablefield: false
      }));
    } else {
      this.populateTrade(element, control, controlTraditional, imminentrisksD);
    }
  }
  populateTrade(element: any, control: FormArray, controlTraditional: FormArray, imminentrisksD: any) {
    const disabledate =true;
    controlTraditional.push(this._formBuilder.group({
      id: element.id,
      name: element.name,
      candidacy : (!element.imminentrisks.includes('NONE') || disabledate) ? "1" : "",
      candidacydate: disabledate ? new Date() : '',
      disabledate: disabledate,
      details: element.details,
      imminentrisks: new FormArray(imminentrisksD),
      ebp: element.ebp,
      disablefield: disabledate
    }));
  }
      getImminentRiskReason() {
          if (this.selectedServicePlan.involvedpersons && this.selectedServicePlan.involvedpersons.length > 0) {
            this.selectedServicePlan.involvedpersons.forEach((ele: any) => {
              const details: any[] = [];
              ele.imminentrisks.forEach((element: any) => {
                  const riskDetails = this.riskList.find((e: any) => (e.ref_key === element));
                  if (riskDetails) {
                    details.push(riskDetails.value_text);
                  }
              });
              ele.details = details.join(' | ');
            });
          }
      }

      selectService(service: any, index: any)  {
        this.selectedItem = 'service';
        this.indexval = index;
        this.selectedService = service;
        const minimumDate = new Date(this.selectedService.effectivedate);
          minimumDate.setHours(0);
          minimumDate.setMinutes(0);
          minimumDate.setSeconds(0);
          this.candidacyMinDate = minimumDate;
        this._dataStoreService.setData('SelectedService', this.selectedService);
        this.selectedService.approvalstatustypekey = service.approvalstatustypekey;
        this.selectedFocus = null;
        this.selectedAction = null;
        this.calculation(this.selectedService);
        this.selectedFocusList = service.focus;
        this.resetCandidacy();
        this.handleServciePlanCondInSelectServiceFn();

        this.selectedService['isReady'] = this.isSpReadyForReview();

        this.setGoalsData();
        this.getVisitationPlans();
        if(this.selectedService.splangoal.length){
          this.handleIfSplangoalFn();
        }
      this.validatecandidacyForm(this.candidacyFormGroup);
    //    this.samplevalue = objectval.serviceplanaction
      }
  private handleServciePlanCondInSelectServiceFn() {
    if (this.selectedService.serviceplancandidacy) {
      this.updateCandidacy();
      this.childCandidates = (this.candidacyFormGroup.get('candidates') as FormGroup).controls;
      this.childCandidatesTraditional = (this.candidacyFormGroup.get('candidatestraditional') as FormGroup).controls;
    } else {
      this.updateCandidacy();
    }
  }

      // Assosiated to selectService method
  private handleIfSplangoalFn() {
    this.selectedService.splangoal.map((plan: any) => {
      this.goalerrormsg1 = false;
      if (plan.splanobjective.length > 0) {
        this.goalerrormsg1 = true;
      }
      else {
        this.goalerrormsg1 = false;
      }
      if (plan.splanobjective && plan.splanobjective.length) {
        plan.splanobjective.map((obj: any) => {
          this.goalerrormsg = false;
          if (obj.serviceplanaction.length > 0) {
            this.goalerrormsg = true;
          }
          else {
            this.goalerrormsg = false;
          }
        });
      }
    });
  }

    setGoalsData() {
        this.serviceplangoals = this.selectedService.splangoal;
    }

    /**
     * Goals
     */
    // initSPlanGoalsFormGroup() {
    //     this.splanGoalsFormGroup = this._formBuilder.group({
    //         splangoal : this._formBuilder.array([])
    //     });
    // }

    setGoals() {
        this.splanGoalsFormGroup.patchValue(this.selectedService.splangoal);
    }

    // createGoalFormGroup() {
    //     return this._formBuilder.group({
    //         serviceplanid : [null],
    //         splangoalid: [null],
    //         goalname: [null],
    //         approvalstatustypekey: [null]
    //         // activeflag: 1
    //     });
    // }

    // openAddGoalModal() {
    //     if (this.selectedService && this.selectedService.serviceplanvisitation) {
    //     this.visitationPlansFormGroup.patchValue(this.selectedService.serviceplanvisitation);
    //     }
    //     (<any>$('#add-visitation')).modal('show');
    // }

    // addSPGoal() {
    //     const control = <FormArray>this.splanGoalsFormGroup.controls.splangoal;
    //     control.push(this.initVisitationFormGroup());
    // }

  addGoal(activeflag: any, item: any) {
    const goal = (activeflag === 1) ? this.servicePlanGoal?.getRawValue() : item;
    goal.activeflag = activeflag;
    goal['serviceplanid'] = this.selectedService.serviceplanid;
    this._commonhttp.create(goal, 'splangoal/addupdate').subscribe(
      response => {
        (<any>$('#add-goal')).modal('hide');
        this.servicePlanGoal?.reset();
        this.goalAutoSaveInitiated = false;
        clearInterval(this.goalAutoSaveIntervalTimer);
        if (activeflag === 0){
          this._alertservice.success('Goal deleted successfully!');
        } else {
          this._alertservice.success('Goal added successfully!');
        }
        
        this.getServicePlans();
        this.resetGoalsModal();
        setTimeout(() => {
          if (activeflag === 0){
            this.serviceGoal = true;
          }
        }, 1000);
      }
    );
  }

  addservicePlanneed() {
    const needs = this.servicePlanNeed.getRawValue();
    needs.intakeserviceid = this.intakeserviceid;
    this._commonhttp.create(needs, 'serviceplanneed').subscribe(
      response => {
        this.getNeeds();
        (<any>$('#add-need')).modal('hide');
        (<any>$(this.addfocuspopupid)).modal('show');
        this.servicePlanNeed.reset();
        this._alertservice.success('Need added successfully!');

      }
    );

  }

  addservicePlanstrength() {
    const strength = this.servicePlanStrength.getRawValue();
    strength.intakeserviceid = this.intakeserviceid;
    this._commonhttp.create(strength, 'serviceplanstrength').subscribe(
      response => {
        this.getStrengths();
        (<any>$('#add-strength')).modal('hide');
        (<any>$(this.addfocuspopupid)).modal('show');
        this.servicePlanStrength.reset();
        this._alertservice.success('Strength added successfully!');

      }
    );

  }


  /**
   * Visitation Plans
   */
  initVisitationPlansFormGroup() {
    this.visitationPlansFormGroup = this._formBuilder.group({
      visitationplans: this._formBuilder.array([])
    });
  }

  initVisitationFormGroup() {
    return this._formBuilder.group({
      personinvolved: [null, Validators.required],
      frequency: [null],
      length: [null],
      location: [''],
      conditions: [''],
      childtransportation: [''],
      visitortransportation: ['']
    });
  }

  onSorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getVisitationPlans();
}
  //New Visitaion plans
  getVisitationPlans() {
    const payload = {
      method: 'get',
      where: {
        caseid :this.intakeserviceid,
        sortby : this.paginationInfo.sortColumn,
        sortdir : this.paginationInfo.sortBy
      }
    };
    this._commonhttp.getArrayList(payload, 'visitationplan/listallvisitation?filter').subscribe(
      response => {
        this.visitationplansresponse = _.cloneDeep(response);
        this.visitationplans = this.visitationplansresponse;
      }
    );
  }

  initVisitationPlanFormGroup() {
    this.visitationPlanFormGroup = this._formBuilder.group({
      personid: [null],
      caseid: [null],
      visitfrequencytypekey: [null],
      visitdurationtypekey: [null],
      visittypekey: [null],
      planexplain: [''],
      planlocation: [''],
      childtransportationtypekey: [null],
      transportexplain: [''],
      visitortransportationtypekey: [null],
      visitortransportexplain: [''],
      frequencyexplain: [''],
      // activeflag: [null],
      courtorderedflag: [null],
      supervisedflag: 0,
      supervisecomments: [''],
      visitnotallowedflag: [null],
      datavalidflag: [null],
      establisheddate: [null],
      enddate: [null],
      visitationplanclients: [null],
      visitationplanid: [null]
    });
  }
  
  openVisitationPlanModal() {
    this.getVisitationPlans();
  }

  addVisitationPlan() {
    // Save the visitation plan
    this.visitationplanrequired =true;
    if(this.visitationPlanFormGroup.valid){
    const visitationplan = this.visitationPlanFormGroup.getRawValue();
    visitationplan.caseid = this.intakeserviceid;
    this._commonhttp.create(visitationplan, 'visitationplan/addupdate').subscribe(
      response => {
        this.getVisitationPlans();
        this.visitationReset();
        this._alertservice.success('Visitation plan added successfully!');
        this.showvisitplan=false;
      }
    );
    }
    else{
      this._alertservice.error("Please fill the required fields");
    }
  }

  deleteVisitationPlan(deleteVisitationPlan: any) {
    // Save the visitation plan
    deleteVisitationPlan.caseid = this.intakeserviceid;
    deleteVisitationPlan.activeflag = 0;
    this._commonhttp.create(deleteVisitationPlan, 'visitationplan/addupdate').subscribe(
      response => {
        this.getVisitationPlans();
        this.visitationReset();
        this._alertservice.success('Visitation plan deleted successfully!');
        
      }
    );

  }

  visitationReset() {
      this.visitationPlanFormGroup.reset();
      this.visitationPlanFormGroup.enable();
      this.selectedClientName = '';
      this.selectPersonNameList = [];
      this.visitationplanrequired = false ;
  }

  setMinContactDate() {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    const intakeReceivedDate = this._dataStoreService.getData(IntakeStoreConstants.receivedDate);

    if (this.isIntakeMode() && intakeReceivedDate) {
        // For intake min contact date will be the Intake/Referral received date
        this.minContactDate = intakeReceivedDate;
    } else {
        // For case min contact date will be the Case received date
        if (caseInfo) {
            this.minContactDate = caseInfo.da_receiveddate;
        }
    }
}

  isIntakeMode() {
    return this.getIntakeNumber() ? true : false;
  }

  getIntakeNumber() {
    const intakeStore = this._dataStoreService.getObj('intake');
    if (intakeStore && intakeStore.number) {
        return intakeStore.number;
    } else {
        return null;
    }
  }


  editVisitationPlan(item: any, mode: any) {
    this.visitationPlanFormGroup.reset();
    const formdata = item;
    this.getClientNameList(formdata.personid, this.personList);
    this.getPersonNameList(formdata.visitationplanclients, this.personList);
    if (formdata.visitationplanclients) {
      formdata.visitationplanclients = formdata.visitationplanclients.map((x: { personid: any; }) =>
        {
          if (x && x.personid) {
            return x.personid;}
          else {return x;}
        });
    }
    setTimeout(() => {
      this.visitationPlanFormGroup.patchValue(formdata);
      if (mode === 'view') {
        this.visitationPlanFormGroup.disable();
      } else {
        this.visitationPlanFormGroup.enable();
      }
    }, 300);
  }

  // openAddVisitationModal() {
  //   if (this.selectedService && this.selectedService.serviceplanvisitation) {
  //     this.visitationPlansFormGroup.patchValue(this.selectedService.serviceplanvisitation)
  //   }
  //   (<any>$('#add-visitation')).modal('show');
  // }

  // addVisitationPlan() {
  //   const control = <FormArray>this.visitationPlansFormGroup.controls.visitationplans;
  //   control.push(this.initVisitationFormGroup());
  // }

  // saveVisitationPlans() {
  //   const payload = {};
  //   payload['serviceplanid'] = this.selectedService.serviceplanid;
  //   payload['serviceplanvisitation'] = this.visitationPlansFormGroup.value; // this.visitationFormGroup.value;
  //   this._commonhttp.patch(
  //     this.selectedService.serviceplanid,
  //     payload,
  //     'serviceplan'
  //   ).subscribe(
  //     response => {
  //       // this.getServicePlans();
  //       this.selectedService.serviceplanvisitation = this.visitationPlansFormGroup.value;
  //       this._alertservice.success('Visitation details entered successfully!');

  //       // this.visitationPlansFormGroup.reset();
  //       // (<any>$('#add-visitation')).modal('hide');
  //     },
  //     error => {
  //       this._alertservice.error('Error in entering visitation details!');
  //     }
  //   );
  // }


  /**
   * Candidacy
   */
  initCandidacyForm() {
    this.candidacyFormGroup = this._formBuilder.group({
      candidates: this._formBuilder.array([]),
      candidatestraditional: this._formBuilder.array([])
    });
  }

  initCandidacyForm1() {
    this.candidacyFormGroup1 = this._formBuilder.group({
      candidates: this._formBuilder.array([]),
      candidatestraditional: this._formBuilder.array([])
    });
  }

  initCandidacyForm2() {
    this.candidacyFormGroup2 = this._formBuilder.group({
      candidates: this._formBuilder.array([]),
      candidatestraditional: this._formBuilder.array([])
    });
  }

  resetCandidacy(){
    const control = <FormArray>this.candidacyFormGroup.controls.candidates;
    const controlTraditional = <FormArray>this.candidacyFormGroup.controls.candidatestraditional;

    for(let i = control.length-1; i>=0; i--){
      control.removeAt(i)
    }
    for(let i = controlTraditional.length-1; i>=0; i--){
      controlTraditional.removeAt(i)
    }
  }

  initCandidacy() {
    const control = <FormArray>this.candidacyFormGroup.controls.candidates;
    const controlTraditional = <FormArray>this.candidacyFormGroup.controls.candidatestraditional;

    this.selectedService.serviceplancandidacy.candidates.forEach((x: any) => {
      
      control.push(this._formBuilder.group({
          id: x.id,
          name: x.name,
          candidacy: x.candidacy,
          candidacydate: x.candidacydate ? new Date(x.candidacydate) : new Date(),
          disabledate :x.candidacydate ? true :false  
        })
      );

    });

    this.selectedService.serviceplancandidacy.candidatestraditional.forEach((x: any) => {
    const candidacyValue =  x.candidacydate ? new Date(x.candidacydate):null ;
      controlTraditional.push(this._formBuilder.group({
          id: x.id,
          name: x.name,
          candidacy: x.candidacy,
          candidacydate: x.candidacy ? candidacyValue : null,
          disablefield:x.candidacy ? true :false
        })
      );

    });
  }

  updateCandidacy() {
    const control = <FormArray>this.candidacyFormGroup.get('candidates');
    const controlTraditional = <FormArray>this.candidacyFormGroup.get('candidatestraditional');
    const personList = this.handlePersonListFn();
    if (control.controls) {
      control.controls = [];
    }

    if (this.selectedService.involvedpersons && this.selectedService.involvedpersons.length > 0) {
      const emptyFill = this.selectedService.involvedpersons?.filter((item: { imminentrisks: string | any[]; ebp: any; }) => item.imminentrisks?.length === 0 && !item.ebp);
      if (emptyFill.length === this.selectedService.involvedpersons.length) {
        return;
      }
    }

    this.ifInvoledPersonFn(personList, control);

    this.ifChildRiskReasonInfoFn(personList, controlTraditional);
  }
  // Assosiated with updateCandidacy function
  private ifInvoledPersonFn(personList: any[], control: FormArray) {
    personList.forEach(child => {

      const childRiskReasonInfo = (this.selectedService.involvedpersons) ? this.returninvolvedpersonsDataFn(child) : [];
      const ebpDetail = (this.selectedService.involvedpersons) ? this.selectedService.involvedpersons.find((item: { id: any; }) => item.id === child.id) : null;
      const isInvoledPerson = this.selectedService.involvedpersons?.filter((item: { id: any; }) => item.id === child.id);

      if (isInvoledPerson?.length > 0 && childRiskReasonInfo[0]?.imminentrisks?.length > 0) {
        if (control.controls.length === 0 || control.controls.filter((x: any) => <FormGroup>x?.get('id')?.value === child.id).length === 0) {
          this.handleIfInvoledPersonFn(child, isInvoledPerson, control, childRiskReasonInfo, ebpDetail);
        }
      }
    });
  }
  // Assosiated with updateCandidacy function
  private handleIfInvoledPersonFn(child: any, isInvoledPerson: any, control: FormArray, childRiskReasonInfo: any, ebpDetail: any) {
    let candidacyData = [];
    if (this.selectedService.serviceplancandidacy) {
      candidacyData = this.selectedService.serviceplancandidacy.candidates.filter((x: { id: any; }) => x.id === child.id);
    }
    if (!isInvoledPerson[0]?.imminentrisks.includes("NONE") && isInvoledPerson[0]?.ebp?.isebpreferralmade !== 'No') {
      control.push(this.handleToPushControlFormDataInInvolvedPersonFn(child, candidacyData, childRiskReasonInfo, isInvoledPerson, ebpDetail));
    }
  }
  // Assosiated with updateCandidacy function
  private handleToPushControlFormDataInInvolvedPersonFn(child: any, candidacyData: any[], childRiskReasonInfo: any, isInvoledPerson: any, ebpDetail: any) {
    return this._formBuilder.group({
      id: child.id ? child.id : '',
      name: child.name ? child.name : '',
      candidacy: this.returnCandidacy(candidacyData, childRiskReasonInfo),
      candidacydate: candidacyData && candidacyData[0]?.candidacydate ? new Date(candidacyData[0].candidacydate) : new Date(),
      disabledate: candidacyData && candidacyData[0]?.candidacydate ? true : false,
      details: this.returnDetails(candidacyData, isInvoledPerson, child),
      imminentrisks: [],
      ebp: this.returnEbp(candidacyData, ebpDetail)
    });
  }
  // Assosiated with updateCandidacy function
  private returnDetails(candidacyData: any[], isInvoledPerson: any, child: any) {
    return candidacyData && candidacyData[0]?.details ? candidacyData[0]?.details : isInvoledPerson.find((item: { id: any; }) => item.id === child.id).details;
  }
  // Assosiated with updateCandidacy function
  private returnEbp(candidacyData: any[], ebpDetail: any) {
    let ebpValue;
    if(candidacyData && candidacyData[0]?.ebp){
      ebpValue = candidacyData[0].ebp;
    }else if(ebpDetail && ebpDetail.ebp){
      ebpValue = ebpDetail.ebp;
    }else{
      ebpValue = '';
    }
    return ebpValue;
  }
  // Assosiated with updateCandidacy function
  private returnCandidacy(candidacyData: any[], childRiskReasonInfo: any) {
    let rtrnCandidacy;
    if(candidacyData.length !== 0){
      rtrnCandidacy = candidacyData[0].candidacy;
    }else if(childRiskReasonInfo && childRiskReasonInfo.length){
      rtrnCandidacy = '0';
    }else{ 
      rtrnCandidacy = '1'; 
    }
    return rtrnCandidacy;
  }

  // Assosiated with updateCandidacy function
  private returninvolvedpersonsDataFn(child: any) {
    return this.selectedService.involvedpersons.filter((item: any) => item.id === child.id && ((item.ebp?.isebpreferralmade === 'Yes' && item.imminentrisks.indexOf('NONE') > -1) || (item.ebp?.isebpreferralmade === 'No' || item.imminentrisks.indexOf('NONE') > -1 || (item.imminentrisks && item.imminentrisks.length === 0) || (this.selectedService.involvedpersons[0].ebp?.isebpreferralmade === 'Yes' && this.selectedService.involvedpersons[0].imminentrisks.indexOf('NONE') === -1))));
  }

  // Assosiated with updateCandidacy function
  private ifChildRiskReasonInfoFn(personList: any[], controlTraditional: FormArray) {
    let isOpenEdit = true;
    personList.forEach(child => {
      const childRiskReasonInfo = (this.selectedService.involvedpersons) ?
        this.selectedService.involvedpersons.filter((item: any) => item.id === child.id && ((item.ebp?.isebpreferralmade === 'Yes' && item.imminentrisks.indexOf('NONE') > -1) || (item.ebp?.isebpreferralmade === 'No' || item.imminentrisks.indexOf('NONE') > -1 || (item.imminentrisks && item.imminentrisks.length === 0)))) : [];
      const ebpDetail = (this.selectedService.involvedpersons) ? this.selectedService.involvedpersons.find((item: { id: any; }) =>
        item.id === child.id) : null;
      let candidacyData: any[] = [];
      if (this.returnChildRiskReasonInfoCondFn(childRiskReasonInfo, controlTraditional, child)) {
        if (this.selectedService.serviceplancandidacy) {
          ({ candidacyData, isOpenEdit } = this.handleIfServiceplancandidacyFn(candidacyData, child, isOpenEdit));
        }
        const isInvoledPerson = this.selectedService.involvedpersons?.filter((item: { id: any; }) => item.id === child.id);
        if (isInvoledPerson.length > 0) {
          this.handleiIfInvoledPersonDataLengthIGreaterThanZeroFn(candidacyData, isInvoledPerson, controlTraditional, child, ebpDetail);
        }
      }
    });
    this.candidacyFormGroupIsChildCompSaved = (this.selectedService.serviceplancandidacy !== null && isOpenEdit);
    this.validatecandidacyForm(this.candidacyFormGroup);
  }
  private handleIfServiceplancandidacyFn(candidacyData: any[], child: any, isOpenEdit: boolean) {
    candidacyData = this.selectedService.serviceplancandidacy.candidatestraditional.filter((x: { id: any; }) => x.id === child.id);   // NOSONAR
    if (candidacyData && candidacyData.length > 0) {
      const details: any[] = [];
      if(typeof (candidacyData[0].imminentrisks) === 'object'){
        candidacyData[0].imminentrisks = candidacyData[0].imminentrisks;  // NOSONAR
      }else if( candidacyData[0].imminentrisks ){
        candidacyData[0].imminentrisks = [candidacyData[0].imminentrisks];
      }else{
        candidacyData[0].imminentrisks = [];
      }
      candidacyData?.[0]?.imminentrisks?.forEach?.((ele: any) => {
        details.push(this.riskList.find((e: any) => (e.ref_key === ele))?.value_text);
      });
      candidacyData[0].details = details.join(' | ');
      if (candidacyData[0].imminentrisks?.length === 0) {
        candidacyData = [];
        if (isOpenEdit === true) {
          isOpenEdit = false;
          this.selectedService.serviceplancandidacy = null;
        }
      }
    }
    return { candidacyData, isOpenEdit };
  }

  private returnChildRiskReasonInfoCondFn(childRiskReasonInfo: any, controlTraditional: FormArray, child: any) {
    return (childRiskReasonInfo && childRiskReasonInfo.length && childRiskReasonInfo[0]?.imminentrisks?.length > 0
      && (controlTraditional.controls.length === 0 || controlTraditional.controls.filter((x: any) => <FormGroup>x.get('id')?.value === child.id).length === 0));
  }

  private handleiIfInvoledPersonDataLengthIGreaterThanZeroFn(candidacyData: any[], isInvoledPerson: any, controlTraditional: FormArray, child: any, ebpDetail: any) {
    let disablefield: boolean = false;
    if (candidacyData.length !== 0) {
      disablefield = this.handleCandidacyDataFn(candidacyData, disablefield, isInvoledPerson);
    }
    let candidacyInfo;

    if (candidacyData.length !== 0) {
      candidacyInfo = candidacyData[0].candidacy;
    } else if (isInvoledPerson?.length) {
        if (!disablefield) {
          candidacyInfo = null;
        } else {
          candidacyInfo = isInvoledPerson[0]?.ebp?.isebpreferralmade === 'Yes' || disablefield ? '1' : '0';
        }
    } else {
      candidacyInfo = null;
    }
    controlTraditional.push(this.pushFormDataInHandleIfInvoledPersonDataLengthIGreaterThanZeroFn(child, candidacyInfo, candidacyData, isInvoledPerson, disablefield, ebpDetail));
  }

  private handleCandidacyDataFn(candidacyData: any[], disablefield: boolean, isInvoledPerson: any) {
    if (candidacyData[0].candidacy == '0' && candidacyData[0].ebp?.isebpreferralmade == 'No') {
      disablefield = true;
      candidacyData[0].disablefield = true;
    } else {
        const isReferralMade = isInvoledPerson[0]?.ebp?.isebpreferralmade === 'Yes';
        const hasImminentRisks = isInvoledPerson[0]?.imminentrisks.includes("NONE");
        disablefield = candidacyData[0].candidacy && (isReferralMade || !hasImminentRisks);
    }
    return disablefield;
  }

  private pushFormDataInHandleIfInvoledPersonDataLengthIGreaterThanZeroFn(child: any, candidacyInfo: any, candidacyData: any[], isInvoledPerson: any, disablefield: boolean, ebpDetail: any) {
    let cndcyDate = isInvoledPerson?.length && !disablefield ? null : new Date();
    let ebpVal1 = ((ebpDetail && ebpDetail.ebp) ? ebpDetail.ebp : '');
    return this._formBuilder.group({
      id: child.id ? child.id : '',
      name: child.name ? child.name : '',
      candidacy: candidacyInfo,
     
      candidacydate: candidacyData.length !== 0 ? candidacyData[0]?.candidacydate : cndcyDate,
      disablefield: candidacyData.length !== 0 ? candidacyData[0].disablefield : disablefield,
      details: candidacyData && candidacyData[0]?.details ? candidacyData[0]?.details : isInvoledPerson?.find?.((item: { id: any; }) => item.id === child.id)?.details || '',
      imminentrisks: [],
      ebp: candidacyData && candidacyData[0]?.ebp ? candidacyData[0]?.ebp : ebpVal1
    });
  }

  mainTraditionalSelect(event: any, index: any) {
    this.updateImminentrisks(event, index);
    this.setVersionSaveEnabled();
  }

  updateImminentrisksMain(event: any, index: any) {
    const controlTraditional = <FormArray>this.candidacyFormGroup.controls.candidatestraditional;
    if (event && event.value && event.value.length > 0) {
      const details: any[] = [];
      event.value.forEach((element: any) => {
        details.push(this.riskList.find((e: any) => (e.ref_key === element)).value_text);
      });
      controlTraditional.at(index).patchValue({ details: details.join(' | ') });
    } else {
      controlTraditional.at(index).patchValue({ details: '' });
    }
    this.validatecandidacyForm(this.candidacyFormGroup);
  }
  updateImminentrisks(event: any, index: any) {
    const controlTraditional = <FormArray>this.candidacyFormGroup1.controls.candidatestraditional;
    if (event && event.value && event.value.length > 0) {
      const details: any[] = [];
      event.value.forEach((element: any) => {
        details.push(this.riskList.find((e: any) => (e.ref_key === element)).value_text);
      });
      controlTraditional.at(index).patchValue({ details: details.join(' | ') });
    } else {
      controlTraditional.at(index).patchValue({ details: '' });
    }
    this.validatecandidacyForm(this.candidacyFormGroup1, '1');
  }

  openCandidacyModal() {
    if (this.selectedService && this.selectedService.serviceplancandidacy) {
      this.candidacyFormGroup.patchValue(this.selectedService.serviceplancandidacy);
    }
    (<any>$('#candidacy')).modal('show');
  }

  addCandidacy() {
    this.checkcandidacyform =true;
    this.eligibilitydetcheck =true;
    if(this.candidacyFormGroup.valid){
    const candidacyFormData = this.candidacyFormGroup.value;
    const validateArray = candidacyFormData.candidates.filter((item: { candidacy: string; candidacydate: null; }) => item.candidacy === '1' && item.candidacydate === null)
    const validateTraditioanlArray = candidacyFormData.candidatestraditional.filter((item: { candidacy: string; candidacydate: null; }) => item.candidacy === '1' && item.candidacydate === null)

    if(validateArray.length || validateTraditioanlArray.length) {
      this._alertservice.warn('Please Select Candidacy Determination Date');
      return false;
    }
    const payload: any = {};
    payload['serviceplanid'] = this.selectedService.serviceplanid;
    payload['serviceplancandidacy'] = this.candidacyFormGroup.value;
    this._commonhttp.patch(
      this.selectedService.serviceplanid,
      payload,
      'serviceplan'
    ).subscribe(
      response => {
        this.selectedService.serviceplancandidacy = this.candidacyFormGroup.value;
        this.candidacyFormGroupIsChildComp = false;
        this.candidacyFormGroupIsChildCompSaved = true;
        this._alertservice.success('Candidacy information entered successfully!');
      },
      error => {
        this._alertservice.error('Error in entering Candidacy information!');
      }
    );
    }
    else{
      this._alertservice.error(this.mandatorymsg);
    }
  }

  /**
   * Signatures
   */
  initSignatureFormGroup() {
    this.signatureFormGroup = this._formBuilder.group({
      ihmcaseworkersign: [null],
      ihmcaseworkersigndate: [null],
      ihmcaseworkername: [null],
      oohcaseworkersign: [null],
      oohcaseworkersigndate: [null],
      oohcaseworkername: [null],
      familymembersign: [null],
      familymembersigndate: [null],
      familymembername: [null],
      familymemuploadsign: [null],
      familymemrefusesign: [null],

      secondfamilymembersign: [null],
      secondfamilymembersigndate: [null],
      secondfamilymembername: [null],
      secondfamilymemuploadsign: [null],
      secondfamilymemrefusesign: [null],

      supervisorsign: [null],
      supervisorsigndate: [null],
      supervisorname: [null]
    });
  }

  initPersonSignatureFormGroup() {
    this.personSignatureFormGroup = this._formBuilder.group({
      personsign: [null],
      personsigndate: [null],
      personname: [null],
      persontype: [null],
      persontypekey: [null],
      personsignuploaded: [null],
      personsignrefused: [null]
    });
  }

  //Snapshot version
  initSnapshotFilterFormGroup() {
    this.snapshotFilterFormGroup = this._formBuilder.group({
      personlist: [null],
      startdate: [null],
      enddate: [null]
    });
  }

  async downloadCasePdf(val: any) {
    const pages: any = document.getElementsByClassName('pdf-page');
    let pageImages: any[] = [];
    for (let i = 0; i < pages.length; i++) {
      const pageName = pages.item(i).getAttribute('data-page-name');
      if (val === 'ihm') {
        if (pageName === 'In Home Service Plan') {
          await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas) => {
            const img = canvas.toDataURL('image/png');
            pageImages.push(img);
          });
        }
      } else {
        if (pageName === 'Out of Home Service Plan') {
          await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas) => {
            const img = canvas.toDataURL('image/png');
            pageImages.push(img);
          });
        }
      }
    }

    this.pdfFiles.push({ fileName: val === 'ihm' ? 'In Home Service Plan' : 'Out of Home Service Plan', images: pageImages });
    pageImages = [];
    this.convertImageToPdf();
  }

  convertImageToPdf() {
    this.pdfFiles.forEach((pdfFile) => {
        let doc: any = null;
        doc = new jsPDF();
        const width = doc.internal.pageSize.getWidth() - 10;
        const heigth = doc.internal.pageSize.getHeight() - 10;

        pdfFile.images.forEach((image, index) => {

          doc.addImage(image, 'PNG', 3, 5, width, heigth);
          if (pdfFile.images.length > index + 1) {
              doc.addPage();
          }
        });
        doc.save(pdfFile.fileName);
    });
    (<any>$('#servicePlanIhmPrint')).modal('hide');
    (<any>$('#servicePlanOohPrint')).modal('hide');
    (<any>$('#youthTransPlan')).modal('hide');
    this.pdfFiles = [];
  }

  async downloadYTPPdf() {
    const pages: any = document.getElementsByClassName('pdf-page');
    let pageImages: any[] = [];
    for (let i = 0; i < pages.length; i++) {
      const pageName = pages.item(i).getAttribute('data-page-name');
      if (pageName === 'Youth Transitional Plan') {
          await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
            const img = canvas.toDataURL('image/png');
            pageImages.push(img);
          });
        }
    }

    this.pdfFiles.push({ fileName: 'Youth Transitional Plan', images: pageImages });
    pageImages = [];
    this.convertImageToPdf();
  }

  youthTransPlanPrint() {
    (<any>$('#youthTransPlan')).modal('show');
  }

  servicePlanIhmPrint(item: any,index: any) {
   const inputRequest = {
        'intakeserviceid': this.intakeserviceid,
        'id': this.selectedService.serviceplanid,
        'type': 'IHSFP',
        'snapshotid': item,
        'documenttemplatekey': [
            'inhome'
        ],
        'isheaderrequired': false,
        personinvolved: this.personlistforsnapshot[index]
    };
    const payload = {
      method: 'post',
      count: -1,
      page: 1,
      limit: 20,
      riskList: this.riskList,
      where: inputRequest,
      documntkey: [
        'inhome'
    ],
    };
    this._commonhttp.create(payload, 'serviceplan/getreportserviceplan').subscribe(
      response => {
        setTimeout(() => window.open(response.data.documentpath), 3000);
     });
    
  }

  viewDownload(item: any) {
    this.backupService = this.selectedService ? this.selectedService : null;
    this.selectedService = item;
    this.getHistoryForServicePlan();
    (<any>$('#splan-snapshot-version')).modal('show');
  

    if(this.selectedService.splangoal.length){
      this.selectedService.splangoal.map((plan: any) => {
        if(plan.splanobjective.length)
          {
           this.goalerrormsg1 = true
          }
          else{
           this.goalerrormsg1 = false;
          }
      this.ifSplanobjectiveFn(plan);
   })
    }
  }
  // Assosiated with viewDownload method
  private ifSplanobjectiveFn(plan: any) {
    if (plan.splanobjective && plan.splanobjective.length) {
      plan.splanobjective.map((obj: any) => {
        if (obj.serviceplanaction.length) {
          this.goalerrormsg = true;
        }
        else {
          this.goalerrormsg = false;
        }
      });
    }
  }

  documentGenerate(item: any, typeData: any) {
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['inhome'],
        id: item.id,
        type: typeData,
        // date_sw: childReport.date_sw,
        // date_from: childReport.date_from,
        // date_to: childReport.date_to,
        format: 'pdf'
      },
      method: 'post'
    };
      this._commonhttp.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          link.download = 'inHome.pdf';
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
    });
  }



  servicePlanOohPrint(item: any, index: any) {
    const inputRequest = {
      'intakeserviceid': this.intakeserviceid,
      'id': this.selectedService.serviceplanid,
      'type': 'OOH',
      'snapshotid': item,
      'documenttemplatekey': [
          'inhome'
      ],
      'isheaderrequired': false,
      personinvolved: this.personlistforsnapshot[index]
  };
  const payload = {
    method: 'post',
    count: -1,
    page: 1,
    limit: 20,
    riskList: this.riskList,
    where: inputRequest,
    documntkey: [
      'oohome'
  ],
  };
  this._commonhttp.create(payload, 'serviceplan/getreportserviceplan').subscribe(
    response => {
      setTimeout(() => window.open(response.data.documentpath), 3000);
   });
    // this.backupService = this.selectedService ? this.selectedService : null;
    // this.selectedService = item;
    // (<any>$('#servicePlanOohPrint')).modal('show');
  }

  closeView() {
    this.selectedService = this.backupService ? this.backupService : null;
  }

  onSelectedChange(event: any) {
  }


  closeServicePlan() {
    this.calculation(this.selectedService);
    if (this.completedPercentage !== 100) {
      this._alertservice.error('Please close all goals for this service plan.');
      return;
    }
    const service =  this.servicePlanForm.getRawValue();
    service.serviceplanid = this.selectedService.serviceplanid;
    this._commonhttp.patch(
      this.selectedService.serviceplanid,
      service,
      'serviceplan'
    ).subscribe(
      response => {
        this.getServicePlans();
        this.servicePlanForm.reset();
        (<any>$('#close-service')).modal('hide');
       },
      error => {
        this._alertservice.error('Error in closing service plan.');
      }
    );
  }



  addFocusPlan(activeflag: any, focusPlan?: ServicePlanFocus) {
    var objectivealertmsg: any;
    const objective = (activeflag === 1) ? this.focusPlanFormGroup.getRawValue() : focusPlan;
    if(objective.splanobjectiveid === undefined || objective.splanobjectiveid == null || objective.splanobjectiveid === '') {
      objectivealertmsg = 'Objective is added successfully.';
    }
    else {
      objectivealertmsg = 'Objective is updated successfully.';
    }
    objective.needs = JSON.stringify(objective.needs);
    objective.strengths = JSON.stringify(objective.strengths);
    objective.activeflag = activeflag;
    objective.splangoalid = this.selectedGoal.splangoalid;
    objective.serviceplanid = this.selectedService.serviceplanid;
    this.selectedService.serviceplanfocus = this.returnServiceplanfocusFn();
    this._commonhttp.create(objective, 'splanobjective/addupdate').subscribe(
      response => {
        objective.splanobjectiveid = response.splanobjectiveid;

        const objectFocusIndex = this.selectedService.serviceplanfocus.findIndex((fdata: any) => fdata.splanobjectiveid === response.splanobjectiveid
        );

        if (objectFocusIndex === -1) {
            this.selectedService.serviceplanfocus.unshift(objective);
        } else {
            if (objective.activeflag === 1) {
                this.selectedService.serviceplanfocus[objectFocusIndex] = objective;
            } else {
                this.selectedService.serviceplanfocus.splice(objectFocusIndex, 1);
            }
        }
        this.focusPlanFormGroup.reset();
        this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();
        const message = (activeflag === 1) ? objectivealertmsg : 'Objective is deleted successfully.';
        this._alertservice.success(message);
        this.getServicePlans();
        (<any>$(this.addfocuspopupid)).modal('hide');
      },
      error => {
        this.focusPlanFormGroup.reset();
        this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();
        const message = (activeflag === 1) ? 'Error in updating Objective.' : 'Error in deleting Objective.';
        this._alertservice.error(message);
        (<any>$(this.deletepopupid)).modal('hide');
      }
    );
  }

  private returnServiceplanfocusFn(): any {
    return (this.selectedService.serviceplanfocus && this.selectedService.serviceplanfocus.length) ? this.selectedService.serviceplanfocus : [];
  }

  compareNeedsObjects(o1: any, o2: any): boolean {
    return o1.serviceplanneedname === o2.serviceplanneedname;
  }

  getPlanByPersonID(personId: any, action: any) {
    if (this.actionPersonList && Array.isArray(this.actionPersonList) && personId && personId[0]) {
      const id = (action === 1) ? personId[0] : personId[0].personinvolved;
      const person = this.actionPersonList.find(item => item.personid === id);
      return (person) ? (person.programkey) : '';
    }
    return '';
  }

  addNewActionPlan(activeflag: any,serviceplanobjective: any, isAutoSave: any) {
    this.actioplanrequired = true;
    if(this.actionPlanFormGroup.valid){
    
    const serviceplan = serviceplanobjective ? serviceplanobjective : this.serviceobject;
    this.selectObjective(serviceplan);
    this.addActionPlan(activeflag, isAutoSave);
    this.hideActionFormGroup();
    }
    else{
      this._alertservice.error(this.mandatorymsg);
    }
  }

  addActionPlan(activeflag: any, isAutoSave: any, actionPlan?: ServicePlanAction) {

    if(isAutoSave && !this.actionPlanFormGroup.valid) {
      this._alertservice.error(this.autosavemsg);
      return false;
    }

    let actionalertmsg: any;
    const action = (activeflag === 1) ? this.actionPlanFormGroup.getRawValue() : actionPlan;
    if (isAutoSave == null) {
      action.autoflag = null;
    }
    if(action.serviceplanactionid === undefined || action.serviceplanactionid == null|| action.serviceplanactionid === '') {
      actionalertmsg = this.returnActionAlertMsgFn(isAutoSave, 'created');
    } else {
      actionalertmsg = this.returnActionAlertMsgFn(isAutoSave, 'updated');
    }
    action.serviceplanactionid = (action.serviceplanactionid !== '') ? action.serviceplanactionid : null;
    action.splanobjectiveid = this.selectedObjective ? this.selectedObjective.splanobjectiveid : null;
    action.objectid = this.intakeserviceid;
    action.activeflag = activeflag;
    action.serviceplanpersoninvolved = (activeflag === 1) ? action.personinvolved : action.serviceplanpersoninvolved;
    if (activeflag === 1) {
    action.planfor = this.getPlanByPersonID((activeflag === 1) ?
    action.personinvolved : action.serviceplanpersoninvolved, activeflag);
    }
    this._commonhttp.create(action, 'serviceplanaction/addupdate').subscribe(
      response => {
        this.addActionPlanResponseFn(isAutoSave, response, actionalertmsg, activeflag);
      },
      error => {
        const message = (activeflag === 1) ? 'Error in updating Action.' : 'Error in deleting Action.';
        this._alertservice.error(message);
        this.actionPlanFormGroup.reset();
        this.actionAutoSaveInitiated = false;
        clearInterval(this.actionAutoSaveIntervalTimer);
        (<any>$(this.deletepopupid)).modal('hide');
      }
    );
  }

  // Assosiated with addActionPlan function
  private returnActionAlertMsgFn(isAutoSave: any, status: string) {
    return isAutoSave ? 'Action Auto-Saved Successfully!' : 'Action is ' + status + ' successfully.';
  }
  // Assosiated with addActionPlan function
  private addActionPlanResponseFn(isAutoSave: any, response: any, actionalertmsg: any, activeflag: any) {
    if (isAutoSave) {
      this.actionAutoSaved = true;
      this.lastActionUpdatedTime = moment().format(this.dtformat);
      this.actionPlanFormGroup.patchValue({ serviceplanactionid: response.serviceplanactionid }, { emitEvent: false, onlySelf: true });
      this.currentActionData = this.actionPlanFormGroup.getRawValue();
      this._alertservice.success(actionalertmsg);
    } else {
      this.actionAutoSaved = false;
      this.actionPlanFormGroup.reset();
      this.actionAutoSaveInitiated = false;
      clearInterval(this.actionAutoSaveIntervalTimer);
      this.currentActionData = this.actionPlanFormGroup.getRawValue();
      const message = (activeflag === 1) ? actionalertmsg : 'Action is deleted successfully.';
      this._alertservice.success(message);
      this.getServicePlans();
      (<any>$(this.deletepopupid)).modal('hide');
    }
  }

  createInvolvedPersonForms(previousData?: any,isPopNotOpen?: any, isVersion? : any) {
    this.involvedPersonForm = [];
    const personList = this.handlePersonListFn();
    if (previousData && previousData.involvedpersons && previousData.involvedpersons.length) {
      personList.forEach(element => {
        const data: any = this.handleListSnapShotFn(element, previousData);
        const imminentrisks = this.handleImminentrisksFn(data);
        this.involvedPersonForm.push({
          name: element.name, 
          id : element.id, 
          imminentrisks: imminentrisks, 
          comment: data?.comment,
          disabledit: false,
          livingininformalkinship: data?.livingininformalkinship, 
          enablelivinginink:data?.enablelivinginink,
          previousriskreasonids: [],
          ebp: this.ebpNullCheck(data)
        });
      });
    } else {
      if (this.selectedService && this.selectedService.involvedpersons && this.selectedService.involvedpersons.length > 0 && this.selectedService.involvedpersons[0].ebp) {
        const pList = this.handleSelectPersonListFn(isVersion);
        pList.forEach(element => {
          const imminentrisks = this.handleImminentrisksFn(element);
          this.involvedPersonForm.push({
            name: element.name, 
            id : element.id, 
            imminentrisks: imminentrisks, 
            comment: element?.comment,
            disabledit: false,
            livingininformalkinship: element?.livingininformalkinship, 
            enablelivinginink:false,
            previousriskreasonids: [],
            ebp: this.ebpNullCheck(element)
          });
        });
      } else {
        personList.forEach(element => {
          this.involvedPersonForm.push({
            name: element.name, 
            id : element.id, 
            imminentrisks: [], 
            comment: null,
            disabledit: false,
            livingininformalkinship: null, 
            enablelivinginink:false,
            previousriskreasonids: [],
            ebp: null
          });
        });
      }
     
    }
    if (isPopNotOpen) {
      this.personList = personList;
    }
    this.servicePlanFormGroup.patchValue({
      serviceplanname: (this.serviceplanslist.length === 0 || !this.caseheadname) ? this.sourcecaseheadname : this.caseheadname
    });
  }

  private ebpNullCheck(value: any){
      return (value && value?.ebp) ? value?.ebp : null;
  }
  
  private handleImminentrisksFn(data: any): string[] {
    if (!data) return [];
    const risks = (data.details ? data.details.split('|') : data.imminentrisks) || [];
    return risks
      .filter(Boolean)
      .map((risk: any) => {
        const match = this.riskList.find(
          (e: any) => e.value_text?.toUpperCase().replace(/\s+/g, '') === risk.toUpperCase().replace(/\s+/g, '')
        );
        return match?.ref_key;
      })
      .filter(Boolean);
  }
  

  private handleListSnapShotFn(element: any, previousData: any) {
    let data: any;
    if ((this.listSnapShot && this.listSnapShot.length > 0)) {
      if (this.listSnapShot[0].snapshotdata.candidatesObj) {
        if (this.listSnapShot[0].snapshotdata.candidatesObj.candidates) {
          data = this.listSnapShot[0].snapshotdata.candidatesObj.candidates.find((e: any) => (e.id === element.id));
        }
        if (!data && this.listSnapShot[0].snapshotdata.candidatesObj.candidatestraditional) {
          data = this.listSnapShot[0].snapshotdata.candidatesObj.candidatestraditional.find((e: any) => (e.id === element.id));
        }
      }
    }
    if (!data) {
      data = previousData.involvedpersons.find((e: any) => (e.id === element.id));
    }
    return data;
  }

  private handlePersonListFn() {
    return this.childList.filter(item => item.programarea && (item.programarea.filter((element: { programkey: string; }) => element.programkey === 'OOH').length <= 0) && (item.ishousehold === 1));
  }
  private handleSelectPersonListFn(isVersion?: any) {
    if (!isVersion) {
      return  this.handlePersonListFn();
    } else {
      let childs: any[] = [];
      this.selectedService.involvedpersons.forEach((element: any) => {
        let child = this.childList.find((e: any) => e.id === element.id);
        if (child && (child.programarea && (child.programarea.filter((ele: any) => ele.programkey === 'OOH').length <= 0) && (child.ishousehold === 1))) {
          childs.push(element);
        }
      });
      return childs;
    }
  }


  getservicecasedisposition() {
    this._commonhttp
            .getArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize,
                    where: {
                        servicecaseid: this.intakeserviceid
                    },
                    method: 'get'
                }),
                'servicecasedisposition/getservicecasedisposition?filter'
            ).subscribe((result) => {
              const serviceplansList = cloneDeep(this.serviceplanslist);
              serviceplansList.sort(function(a: any,b: any){
                return (new Date(b.insertedon).getTime() - new Date(a.insertedon).getTime());
              });
                this.isReopenedCase = ((result && result.length > 0 && (result[0].dispstatus === 'Open' || result[0].dispstatus === 'Return to Worker') && result[0].disposition === 'Inprogress' && (result[0].routingstatus === 'Approved' || result[0].userrole === 'Supervisor'))
                 && (serviceplansList &&  serviceplansList.length > 0
                   && (this.getTimeFromDate(result[0].displaydate) > new Date(serviceplansList[0].insertedon).getTime())));
           });
  }
  getTimeFromDate(date: any) {
    date = date.split('T');
    const time = date[1].split('.');
    return new Date(date[0] + ' ' + time[0]).getTime();
  }


  openAddServiceModal() {
    if(!this.isReopenedCase && this.isNewPlan && this.serviceplanslist?.length > 0) {
      this._alertservice.warn('Every family should have only one service plan per open service case, To add new service plan the case must be reopened.');
      return;
    }
    this.cancelServicePlanSave();
    // this.selectService = null;
    this.selectServiceFn = null
    this.candidacyFormGroupIsChildCompSaved = false;

     this.createInvolvedPersonForms();
    this._commonhttp.getArrayList({},
      'Nextnumbers/getNextNumber?apptype=Serviceplannumber') .subscribe(
        (result) => {
          (<any>$(this.addservicepopupid)).modal('show');
          setTimeout(() => {
            const el: any = document.getElementById('add-service');
            el.style.paddingRight = '0px';
          },1000);
        });
  }

  checkOpenUpEditService() {
    return this.involvedPersonForm.filter((e: any) => (e.imminentrisks.length > 0 && !e.ebp)).length > 0;
  }

  openEditServiceModal(item: any){

    this.editserviceplan =true;
    this.editServicePlanData = cloneDeep(item);
    this.servicePlanFormGroup.patchValue({
         serviceplanname: item['serviceplanname'],
         effectivedate:item['effectivedate'], 
         targetenddate:item['targetenddate'],
         serviceplanid:item['serviceplanid'], 
         enddate:item['enddate']
    });

    this.involvedPersonForm = [];

    const personList = this.childList.filter(item1 => 
      item1.programarea  && (item1.programarea.filter((element: any) =>
        element.programkey === 'OOH' 
      ).length <= 0) && (item1.ishousehold === 1)
    );

    personList.forEach(element => {
      let riskList = this.getRiskList(item, element); 
      let imntRisk = (riskList[0]?.imminentrisks) ? true :false;
      let disabledate = false;
       let ebp = null;
      if (riskList && riskList.length > 0 && riskList[0].imminentrisks.length > 0) {
        disabledate = (riskList[0].imminentrisks[0] == "NONE");
        if (disabledate) {
          ebp = {
            isebpreferralmade: "No",
            noadditionalinfo: 'YNE'
           }
        }
      }
      const ebpelse = ((riskList[0]?.ebp) ? riskList[0].ebp : null);
      const disableditelse = ((riskList[0]?.disableedit !== undefined) ? riskList[0].disableedit : imntRisk);
      this.involvedPersonForm.push({
        name: element.name, 
        id: element.id,
        imminentrisks: (riskList[0]?.imminentrisks) ? riskList[0].imminentrisks : [],
        disableedit : disabledate ? disabledate : disableditelse,
        comment: (riskList[0]?.comment) ? riskList[0].comment : null, 
        livingininformalkinship: (riskList[0]?.livingininformalkinship) ? riskList[0].livingininformalkinship : null, 
        enablelivinginink : (riskList[0]?.enablelivinginink) ? riskList[0].enablelivinginink : null,
        previousriskreasonids: (riskList[0]?.imminentrisks) ? riskList[0].imminentrisks : [], 
        ebp: (ebp !== null) ? ebp : ebpelse
      });
    });

    this.involvedPersonFormChange = this.involvedPersonForm;
    (<any>$(this.addservicepopupid)).modal('show');
    setTimeout(() => {
      const el: any = document.getElementById('add-service');
      el.style.paddingRight = '0px';
    },1000);

    this.servicePlanFormGroup.get('effectivedate')?.disable();
    
  }

  getRiskList(item: any, element: any){
    let riskList = (item.involvedpersons && item.involvedpersons.length) ? item.involvedpersons.filter((ele: any) => ele.id === element.id) : [];
      if(!riskList || riskList == null ){
        riskList = [];
      }
      return riskList;
  }

  candidacyChange(event: MatRadioChange, index: any) {
    const controlTraditional = <FormArray>this.candidacyFormGroup.controls.candidatestraditional;
    if (event.value === '1') {
      controlTraditional.at(index).patchValue({
        imminentrisks: ['NONE'],
        details: 'NONE',
        candidacydate: new Date()
      });
    } else {
      controlTraditional.at(index).patchValue({
        imminentrisks: [],
        details: '',
        candidacydate: new Date()
      });
    }
    this.validatecandidacyForm(this.candidacyFormGroup);
  }

  candidacyChange1(event: MatRadioChange, index: any) {
    const controlTraditional = <FormArray>this.candidacyFormGroup1.controls.candidatestraditional;
    controlTraditional.at(index).patchValue({candidacydate: new Date()});
    if (event.value === '1') {
      controlTraditional.at(index).patchValue({
        imminentrisks: ['NONE'],
        details: 'NONE'
      });
    } else {
      controlTraditional.at(index).patchValue({
        imminentrisks: [],
        details: ''
      });
    }
    this.validatecandidacyForm(this.candidacyFormGroup1, '1');
  }

  childLivingInInformalKinship(value: any, index: any) {
    if (!(value === 'others' || this.involvedPersonForm[index].imminentrisks.indexOf('OTH') > -1)) {
      this.involvedPersonForm[index].comment = '';
    }
    this.setIsEbpAddServicePlan();
  }

  onEventDropDownChanged(_i: any) {
    //No operation needed here
  }


  childRiskReason(child: any, value: any, type?: any) {
      if(child.previousriskreasonids.length === 0) {
        child.previousriskreasonids = value;
      } else if(child.previousriskreasonids.indexOf('NONE') < 0 && value.indexOf('NONE') > -1) {
        child.imminentrisks = ['NONE'];
        child.previousriskreasonids = ['NONE'];
        child.livingininformalkinship = null;
        child.enablelivinginink = false;
        this.populateChildEBPComp(type, child);
        return;
      } 
  
      if(child.previousriskreasonids.indexOf('NONE') > -1 && value.length > 1) {
        child.previousriskreasonids = [];
        value.forEach((element: any)=>{
          if(element !== 'NONE') {
            child.previousriskreasonids.push(element);}
        })
        child.imminentrisks = child.previousriskreasonids;
        value = child.previousriskreasonids;
      }
  
      if(value.indexOf('NONE') > -1) {
        child.imminentrisks = ['NONE'];
        child.livingininformalkinship = null;
        child.enablelivinginink = false;
      }
  
      if(value.indexOf('INK') > -1) {
        child.enablelivinginink = true;
      } else {
        child.livingininformalkinship = null;
        child.enablelivinginink = false;
      }
      this.populateChildEBPComp(type, child);
  }

  populateChildEBPComp(type: any, child: any) {
    if (type === 'add') {
      this.setIsEbpAddServicePlan();
    } else {
      this.setIsVersionEbpNotCompleted();
    }
    this._commonhttp.candidacyDropDownChange.next({
      id: child.id,
      imminentrisks: child.imminentrisks
    });
  }

  cancelServicePlanSave() {
    this.checkmandatory =false;
    this.involvedPersonFormChange = [];
    this.involvedPersonForm = [];
    this.servicePlanFormGroup.reset()
    this.editserviceplan =false;
    this.isEbpAddServicePlan = false;
    this.servicePlanFormGroup.get('effectivedate')?.enable();
  }


  captureSign(item: any) {
    this.currSelectedService = item;
    if (this.currSelectedService && this.currSelectedService.serviceplansignatures) {
      this.signatureFormGroup?.patchValue(this.currSelectedService.serviceplansignatures);
    }
    (<any>$('#signature')).modal('show');
  }

  signServicePlan() {
    const payload: any = {};
    payload['serviceplanid'] = this.currSelectedService.serviceplanid;
    payload['serviceplansignatures'] = this.signatureFormGroup?.value;
    this._commonhttp.patch(
      this.currSelectedService.serviceplanid,
      payload,
      'serviceplan'
    ).subscribe(
      response => {
        this.getServicePlans();
        this.signatureFormGroup?.reset();
        this._alertservice.success('Signatures captured successfully!');
        (<any>$('#signature')).modal('hide');
      },
      error => {
        this._alertservice.error('Error in capturing signatures!');
      }
    );
  }

  calculation(selectedService: any) {
    let goalToalList = [];
    let goalAchievedList = [];
    let goalInprogressList = [];
    let goalNotAchievdedList = [];
    this.percentageInprogress = 0;
    this.percentageAchieved = 0;
    this.percentageNotAchieved = 0;
    const goals = Array.isArray(selectedService.splangoal) ? selectedService.splangoal : [];
    goalToalList = goals;
    if (goalToalList.length) {
      goalAchievedList = goalToalList.filter((item: { status: string; }) => item.status === 'Achieved');
      goalNotAchievdedList = goalToalList.filter((item: { status: string; }) => item.status === this.notachieved);
      goalInprogressList = goalToalList.filter((item: { status: string; }) => item.status === this.inprogress);
    }
    if (goalToalList.length && goalAchievedList.length) {
      this.percentageAchieved = goalAchievedList.length / goalToalList.length * 100;
      this.percentageAchieved = Math.floor(this.percentageAchieved);
    }
    if (goalToalList.length && goalNotAchievdedList.length) {
      this.percentageNotAchieved = goalNotAchievdedList.length / goalToalList.length * 100;
      this.percentageNotAchieved = Math.floor(this.percentageNotAchieved);
    }
    if (goalToalList.length && goalInprogressList.length) {
      this.percentageInprogress = goalInprogressList.length / goalToalList.length * 100;
      this.percentageInprogress = Math.floor(this.percentageInprogress);
    }
    this.totalActions = goalToalList.length;
    this.achievedActions = goalAchievedList.length;
    this.notAchievedActions = goalNotAchievdedList.length;
    this.inProgressActions = goalInprogressList.length;

    this.completedPercentage = this.percentageAchieved + this.percentageNotAchieved;
  }

  getPersonListWithProgramAssignment() {
    let inputRequest = {};
    inputRequest = {
      objectid: this.intakeserviceid,
    };
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: inputRequest
    };
    this._commonhttp.getArrayList(payload, 'People/getPersonWithProgramAssignment?filter').subscribe(
      response => {
        this.actionPersonList = response;
     });

  }

  getInvolvedPerson() {
    let inputRequest = {};
    const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (isServiceCase || this.isAdoptionCase) {
      inputRequest = {
        objectid: this.intakeserviceid,
        objecttypekey: 'servicecase'
      };
    } else {
      inputRequest = {
        intakeserviceid: this.intakeserviceid
      };
    }
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit : 100,
      nolimit: true,
      where: inputRequest
    };
    this._commonhttp.getPagedArrayList(payload, 'People/getpersondetail?filter').subscribe(
      response => {
        this.personList = response.data;

        if (response.data && response.data.length) {
          this.getpersondetailApiResponseFn(response);
        }
        this.getServicePlans();
      });     
  }
  // Assosiated with getInvolvedPerson function
  private getServicePlanTitle(response: any){
    return response.data.find((e: any) => e.caseheadname !== undefined && e.isheadofhousehold);
  }
  // Assosiated with getInvolvedPerson function
  private getpersondetailApiResponseFn(response: any) {
    const addServicePlanTitle = this.getServicePlanTitle(response);
    this.sourcecaseheadname = addServicePlanTitle ? addServicePlanTitle.lastname + ' Family Service plan' : '';
    
    response.data.forEach((person: any) => {
      if (person.caseheadname !== undefined && person.isheadofhousehold) {
        this.headofhouseholdName = this.getFullName(person);
        this.headofhouseholPersonId = person.personid;
      }
      this.personDataList.push({ 'name': this.getFullName(person) });
      let obj;
      if (person.roles) {
        person.roles.some((role: any) => {
          if (this.candidacyRoles.includes(role.intakeservicerequestpersontypekey) && this.isChild(person.dob)) {
            obj = {
              'id': person.cjamspid,
              'personid': person.personid,
              'name': this.getFullName(person),
              'candidacy': null,
              'programarea': person.programarea,
              'ishousehold': person.ishousehold
            };
            this.childList.push(obj);
            return true;
          }
        });
      }
      if (person?.isheadofhousehold) {
        this.legalGuardian = this.getFullName(person);
      }
    });
    this.personDataList.push({ 'name': this.user.user.userprofile.displayname });
    if (this.personDataList && this.personDataList.length) {
      this.personListName = this.personDataList[0].name;
    }
  }

  isChild(birthDate: any) {
    birthDate = birthDate.split('T');
    birthDate = new Date(birthDate[0]);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return (age <= 21);
  }
  getCollateralPerson(){
    const request = {
        objectid: this.intakeserviceid,
        objecttype: 'case'
    };
    this._commonhttp.getArrayList(
        {
            where: request,
            method: 'get',
            nolimit: true
        },
        'collateral/list?filter'
    ).subscribe(res => {
        if (res && res.length && res[0].getcollateraldetails && res[0].getcollateraldetails.length) {
            const collateralDetails = res[0].getcollateraldetails;
            if(collateralDetails && collateralDetails.length>0){
              collateralDetails.forEach((collateralDetail: any) => {
                this.personDataList.push({'name': this.getCollateralFullName(collateralDetail)})
              });
            }
        }
    });

  }

  getFullName(person: any) {
    const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
    let name = '';
    nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
      if ( (person[key] != null) && (person[key] !== 'null') && (person[key] !== '') ) {
        name = name + person[key] + ' ';
      }}
    });
    return name;
  }

  getCollateralFullName(collateral: any) {
    const nameKeys = [ 'prefixtypekey' , 'firstname' , 'middlename' , 'lastname' , 'suffixtypekey'];
    let name = '';
    nameKeys.forEach(key => {
      if ( (collateral[key] != null) && (collateral[key] !== 'null') && (collateral[key] !== '') && collateral.hasOwnProperty(key) ) {
        name = name + collateral[key] + ' ';
      }
    });
    return name;
  }

  editServicePlan() {
    this.servicePlanForm.patchValue(this.selectedService);
    (<any>$('#close-service')).modal('show');
  }

  editGoal(goal: any) {
    this.selectedGoal = goal;
    this._datastore.setData('SelectedGoal', this.selectedGoal);
    this.serviceGoal = true;
    this.editUpdateGoal = true;
    this.servicePlanGoal?.patchValue(goal, {emitEvent: false, onlySelf: true});
    this.currentGoalData = this.servicePlanGoal?.getRawValue();
  }

  editFocus(objective: any, goal: any) {
    this.selectedGoal = goal;
    this._datastore.setData('SelectedGoal', this.selectedGoal);
    this.selectedObjective = objective;
    this.serviceObjective = true;
    this.serviceEditObjective = true;
    this.focusPlanFormGroup.patchValue(objective);
    this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();
    if (objective.serviceplanneed && Array.isArray(objective.serviceplanneed)) {
      const serviceplanneedOne = objective.serviceplanneed.map((item: { serviceplanneedname: any; }) => item.serviceplanneedname ? item.serviceplanneedname : item);
      this.focusPlanFormGroup.patchValue({ serviceplanneed: serviceplanneedOne });
    }
    if (objective.serviceplanstrength && Array.isArray(objective.serviceplanstrength)) {
      const serviceplanstrengthOne = objective.serviceplanstrength.map((item: { serviceplanstrengthname: any; }) => item.serviceplanstrengthname ? item.serviceplanstrengthname : item);
      this.focusPlanFormGroup.patchValue({ serviceplanstrength: serviceplanstrengthOne });
    }
  }

  cancelActionFormGroup() {
    this.actionPlanFormGroup.reset();
    this.actionAutoSaveInitiated = false;
    clearInterval(this.actionAutoSaveIntervalTimer);
    this.hideActionFormGroup()
  }

  hideActionFormGroup() {
    this.showActionForm = false;
    this.currentActionData = this.actionPlanFormGroup.getRawValue();
  }
  showActionFormGroup() {
    this.showActionForm = true;
  }
  
  addNewAction(objective: any) {
    this.showActionFormGroup();
    this.selectedObjective = (objective) ? objective : this.selectedObjective;
  }

  editAction(action: any, objective: any) {
    if (action.status === this.notachieved) {
        this.showGoalReason = true;
    }
    this.showActionFormGroup();
    this.selectedObjective = (objective) ? objective : this.selectedObjective;
    if (typeof action.personresponsible === 'string') {
      action.personresponsible = action.personresponsible.split(',');
    }
    this.actionPlanFormGroup.patchValue(action, {emitEvent: false, onlySelf: true});
    if (action.serviceplanpersoninvolved && Array.isArray(action.serviceplanpersoninvolved) && action.serviceplanpersoninvolved.length >0) {
      const persons = action.serviceplanpersoninvolved.map((item: { personinvolved: any; }) => item.personinvolved ? item.personinvolved : item);
      this.actionPlanFormGroup.patchValue({ personinvolved: persons }, {emitEvent: false, onlySelf: true});
    }
    this.currentActionData = this.actionPlanFormGroup.getRawValue();
  }

  getPersonName(id: any) {
    if (this.personList && Array.isArray(this.personList)) {
      const person = this.personList.find(item => item.personid === id);
      let name='';
      if(person){
        name = (person) ? (this.getFullName(person)) : '';}
      return name;
    }
    return '';
  }

  /**
   * Needs and strengths
   */
  saveAssessmentStrengthNeeds() {
    // How do we handle cans-outofhome?
    const payload = {
      'objectid': this.intakeserviceid,
      'templatename': 'cansF',
      'status': 'accepted'
    };
    this._commonhttp.create(payload, 'serviceplan/saveAssessmentStrengthNeeds').subscribe(
      response => {
        this.getNeeds();
        this.getStrengths();
      });
  }


  getNeeds() {
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: {
        intakeserviceid : this.intakeserviceid
      }
    };
    this._commonhttp.getPagedArrayList(payload, 'serviceplanneed/list?filter').subscribe(
      response => {
        if (response && Array.isArray(response.data)) {
          this.cansFNeedsData = response.data.filter(x => x.assessmenttype === 'cansF');
          this.cansNeedsData = response.data.filter(x => x.assessmenttype === 'cansOutOfHomePlacementService');
          this.focusNeeds = response.data.map(x => x.serviceplanneedname);
          this.cansFNeedsList = response.data;
          if (this.cansFNeedsList.length) {
             this.isAssementCompleted = true;
          }
         }
      });
  }

  getStrengths() {
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: {
        intakeserviceid : this.intakeserviceid
      }
    };
    this._commonhttp.getPagedArrayList(payload, 'serviceplanstrength/list?filter').subscribe(
      response => {
        if (response && response.data && response.data.length) {
        this.cansFStrengthsData = response.data.filter(x => x.assessmenttype === 'cansF');
        this.cansStrengthsData = response.data.filter(x => x.assessmenttype === 'cansOutOfHomePlacementService');
        this.focusStrengths = response.data.map(x => x.serviceplanstrengthname);
        this.cansFStrengthList = response.data;

        if (this.cansFStrengthList.length) {
          this.isAssementCompleted = true;
        }

        }
      });
  }

  /**
   * Assignment & Routing
   */
  getRoutingUser(appoval: any, selectService: any) {
       this.approvalProcess = appoval;
       this.selectedPlan = selectService.serviceplanid;
       
       this.getUsersList = [];
       if (appoval === 'Pending') {
        this._commonhttp
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent:  'SPLAN' },
                method: 'post'
            }),
            'Intakedastagings/getroutingusers'
        )
        .subscribe(result => {
            this.getUsersList = result.data;
            this.getUsersList = this.getUsersList.filter(
                users => users.userid !== this._authService.getCurrentUser().user.securityusersid
            );
        });
      }  else {
        this.assignNewUser(selectService);
      }
  }

  selectPerson(row: any) {
    this.selectedPerson = row;
  }

  assignNewUser(selectedService: any) {
      
      // Instead of the service plan, the snapshot version is sent for approval 
      // selectedService.approvalstatustypekey = this.approvalProcess;
      this.showAssignButton = false;
      this.selectedSnapshotVersion.approvalstatus = this.approvalProcess;

      const payload = {
        eventcode: 'SPLAN',
        tosecurityusersid: this.selectedPerson ? this.selectedPerson.userid : '',
        fromsecurityusersid: this.user.user.securityusersid,
        objectid: this.intakeserviceid,
        serviceNumber: this.daNumber,
        approvalstatustypekey: this.approvalProcess,
        serviceplanid: this.selectedPlan
      };
      this._commonhttp.create(
         payload,
        'serviceplan/serviceplanrouting'
      ).subscribe(
        (response) => {
          this.getHistForCompletionDate(selectedService.serviceplanid);
          this.updateSnapshotVersionStatus();
          (<any>$(this.caseassignpopupid)).modal('hide');
          if(this.isEbpReferralMade && this.approvalProcess == 'Pending') {
             (<any>$(this.ebpwarningpopup)).modal('show');
          }
          this.showAssignButton = true;
        },
        (error) => {
          this._alertservice.error('Unable to submit decision!');
          this.showAssignButton = true;
        });
    }


    redirectToServicelog() {
      let currentUrl = this._router.url;
      currentUrl = currentUrl.replace("sc-gc", "service-log-activity/referred-services");
      this._router.navigate([currentUrl]);
      (<any>$(this.ebpwarningpopup)).modal('hide');
    }

    saveSnapshothist() {

      const control:any = this.candidacyFormGroup1.get('candidates')?.getRawValue();
      const controlTraditional: any = this.candidacyFormGroup1.get('candidatestraditional')?.getRawValue();
      this.versionsnapshot.candidatesObj = {
        candidates: control,
        candidatestraditional: controlTraditional,
      };
      let versnCandidates =  (this.versionsnapshot.serviceplancandidacy?.candidates ? this.versionsnapshot.serviceplancandidacy.candidates : control);
      let vrsncandidatetraditional = (this.versionsnapshot.serviceplancandidacy?.candidatestraditional ? this.versionsnapshot.serviceplancandidacy?.candidatestraditional : controlTraditional);
      this.versionsnapshot.serviceplancandidacy = {
        candidates: (control && control?.length > 0) ? versnCandidates : [],
        candidatestraditional: (controlTraditional && controlTraditional?.length > 0) ? 
        vrsncandidatetraditional : [],
};
        this.versionsnapshot.involvedpersons = this.involvedPersonForm;
      if (this.selectedService.splangoal?.length > 0) {
        const GOAL_NAME = 'Youth are safely maintained in their homes whenever possible and appropriate';
        const OBJECTIVE_KEYWORD = 'Enhance parenting skills to address challenging behaviors';
      
        const goalIndex = this.selectedService.splangoal.findIndex(
          (goal: any) => goal.goalname === GOAL_NAME &&
                    goal.splanobjective?.some((obj: any) => obj.objectivename.includes(OBJECTIVE_KEYWORD))
        );
      
        if (goalIndex !== -1) {
          this.getHistForCompletionDate(this.selectedService.serviceplanid, () => {
            this.createNewActionForVersion(this.involvedPersonForm, this.selectedService.splangoal, (goalDetails: any) => {
              this.setVersionGoalsToHistory(goalDetails);
              this.createVersionHistory();
            });
          });
        } else {
          this.createChildTask(
            this.selectedService.serviceplanid,
            this.involvedPersonForm,
            this.snapshotFilterFormGroup.get('startdate')?.value,
            this.snapshotFilterFormGroup.get('enddate')?.value, (goalDetails: any) => {
              this.setVersionGoalsToHistory(goalDetails);
              this.createVersionHistory();
            });
        }
      } else {
        this.createChildTask(
          this.selectedService.serviceplanid,
          this.involvedPersonForm,
          this.snapshotFilterFormGroup.get('startdate')?.value,
          this.snapshotFilterFormGroup.get('enddate')?.value, (goalDetails: any) => {
            this.setVersionGoalsToHistory(goalDetails);
            this.createVersionHistory();
          });
      }
      
    }
    setVersionGoalsToHistory(goalDetails: any) {
      const involvedPersonIds = this.versionsnapshot.personsinvolved.map((pi: any) => pi.personid);
      const createdGoals = this.transformResponse1ToResponse2(goalDetails);
      const combinedGoals = [...this.versionsnapshot.splangoal, ...createdGoals];

     const uniqueGoals = combinedGoals.filter((goal, index, self) =>
      index === self.findIndex(g => g.splangoalid === goal.splangoalid)
    );
    
    const filteredGoals = uniqueGoals.filter(goal =>
      goal.splanobjective?.some((obj: any) =>
        obj.serviceplanaction?.some((action: any) =>
          action.serviceplanpersoninvolved?.some((spi: any) =>
            involvedPersonIds.includes(spi.person.personid)
          )
        )
      )
    );
      this.versionsnapshot.splangoal = filteredGoals;
    }
    transformResponse1ToResponse2(response1: any[]): any[] {
      return response1.map(goal => {
        return {
          splangoalid: goal.splangoalid,
          serviceplanid: goal.serviceplanid,
          goalname: goal.goalname,
          approvalstatustypekey: null,
          activeflag: goal.activeflag,
          autoflag: goal.autoflag,
          status: goal.status,
          splanobjective: goal.splanobjective.map((objective: any) => {
            const actionsForObjective = goal.serviceplanaction.filter(
              (action: any) => action.splanobjectiveid === objective.splanobjectiveid
            ).map((action: any) => {
              return {
                serviceplanactionid: action.serviceplanactionid,
                splanobjectiveid: action.splanobjectiveid,
                serviceplanactionname: action.serviceplanactionname,
                personresponsible: action.personresponsible[0], // assuming one responsible person
                startdate: action.startdate,
                enddate: action.enddate,
                status: action.status,
                approvalstatustypekey: null,
                serviceplanoutcome: action.serviceplanoutcome,
                goalreason: action.goalreason,
                comments: action.comments,
                activeflag: action.activeflag,
                autoflag: action.autoflag,
                plantype: null,
                planfor: action.planfor,
                serviceplanpersoninvolved: action.serviceplanpersoninvolved.map((personId: any) => {
                  const person = this.personList.find((ep: any) =>
                    ep.personid === personId
                  );
                  const personObj = {
                    activeflag: 1,
                    firstname: person.firstname,
                    lastname: person.lastname,
                    middlename: person.middlename,
                    personid: personId,
                    suffix: null
                  };
                  return {
                    serviceplanpersoninvolvedid: null,
                    serviceplanactionid: action.serviceplanactionid,
                    personinvolved: personId,
                    activeflag: 1,
                    person: personObj
                  };
                })
              };
            });
            return {
              splanobjectiveid: objective.splanobjectiveid,
              splangoalid: objective.splangoalid,
              objectivename: objective.objectivename,
              needs: null,
              strengths: null,
              approvalstatustypekey: null,
              comments: objective.comments,
              activeflag: objective.activeflag,
              autoflag: objective.autoflag,
              status: objective.status,
              serviceplanaction: actionsForObjective
            };
          })
        };
      });
    }
    createVersionHistory() {
      const payload = {
        'objectid': this.selectedService.serviceplanid,
        'objecttype': 'SPLAN',
        'updatedby': this._authService?.getCurrentUser()?.user?.securityusersid,
        'insertedby': this._authService?.getCurrentUser()?.user?.securityusersid,
        'versionupdatedby': this._authService?.getCurrentUser()?.user?.securityusersid,
        'snapshotdata': this.versionsnapshot
      };
      this._commonhttp.create(payload, 'snapshothist').subscribe(
        response => {
          this.versionsnapshot.candidatesObj = [];
            this.getHist();
            this.cancelChildComp();
            (<any>$('#service-plan-version-eligibility')).modal('hide');
           
        });
    }
    async createNewActionForVersion(involvedPersonForm: any, goals: any, cb?: any) {
      let personsinvolved: string[] = [];
      let goalDetails: any = [];
      personsinvolved = this.personInvoledFn(goals);
      const involvedpersons: any = (this.serviceplanversions?.length >= 1) && this.serviceplanversions[0].snapshotdata.involvedpersons 
        ? this.serviceplanversions[0].snapshotdata.involvedpersons
        : this.selectedService.involvedpersons;
      
      for (const element of involvedPersonForm) {
        const child = involvedpersons.find((e: any) =>
          e.name.replace(/\s+/g, '') === element.name.replace(/\s+/g, '')
        );
    
        const isEBPChanged = (this.sortedStringify(JSON.parse(JSON.stringify(element?.ebp))) !== this.sortedStringify((JSON.parse(JSON.stringify(child?.ebp || {})))));
        const isChildExist = personsinvolved.find((e: any) => (e === element.name.replace(/\s+/g, '')));
        if ((isEBPChanged || (undefined === isChildExist)) && element?.ebp?.utilized === 'Yes') {
          const person = this.personList.find((e: any) =>
            e.fullname.replace(/\s+/g, '') === element.name.replace(/\s+/g, '')
          );
    
          if (!person) continue;
    
          const personid = person.personid;
          const name = this.getNotes(element);
    
          const goalObj = {
            goalname: "Youth are safely maintained in their homes whenever possible and appropriate",
            splangoalid: null,
            status: "In Progress",
            activeflag: 1,
            autoflag: 1,
            serviceplanid: this.selectedService.serviceplanid,
            securityuserid: this._authService.getCurrentUser().user.securityusersid
          };
    
          try {
            const response1: any = await this._commonhttp.create(goalObj, '/splangoal/addupdate').toPromise();
    
            const objective = {
              objectivename: `Enhance parenting skills to address challenging behaviors of ${element.name} by completing the identified prevention service.`,
              needs: "null",
              strengths: "null",
              splanobjectiveid: null,
              otherneeds: null,
              otherstrength: null,
              comments: null,
              status: "In Progress",
              activeflag: 1,
              autoflag: 1,
              splangoalid: response1.splangoalid,
              serviceplanid: this.selectedService.serviceplanid,
              securityuserid: this._authService.getCurrentUser().user.securityusersid
            };
    
            const response2: any = await this._commonhttp.create(objective, 'splanobjective/addupdate').toPromise();
    
            const action = {
              serviceplanactionname: `${element.name} ${name}`,
              serviceplanactionid: null,
              enddate: this.snapshotFilterFormGroup.get('enddate')?.value,
              startdate: this.snapshotFilterFormGroup.get('startdate')?.value,
              status: "In Progress",
              planfor: "GAP",
              personresponsible: [this.headofhouseholdName],
              personinvolved: [personid, this.headofhouseholPersonId],
              serviceplanoutcome: null,
              comments: null,
              goalreason: null,
              splanobjectiveid: response2.splanobjectiveid,
              objectid: this.intakeserviceid,
              activeflag: 1,
              autoflag: this.getAutoFlag(element),
              serviceplanpersoninvolved: [personid, this.headofhouseholPersonId],
              securityuserid: this._authService.getCurrentUser().user.securityusersid
            };
    
            const response3: any = await this._commonhttp.create(action, 'serviceplanaction/addupdate').toPromise();
            response1.splanobjective = [response2];
            response1.serviceplanaction = [response3];
            goalDetails.push(response1);
          } catch (error) {
            console.error("Error occurred while creating plan:", error);
          }
        }
      }
      this.getServicePlans();
      if (cb) {
        cb(goalDetails);
      }
    }

    // Associated with createNewActionForVersion
    getNotes(element: any){
      return element.ebp.utilizedtypes !== 'Other'
            ? this.actionTexts[element.ebp.utilizedtypes]
            : element.ebp.notes;
    }

    // Associated with createNewActionForVersion
    getAutoFlag(element: any){
      return (element.ebp.utilizedtypes !== 'Other') ? 1 : 0;
    }

    // Associated with createNewActionForVersion
    personInvoledFn(goals: any){
      let personsinvolved: any[] = [];
      goals.forEach((element: any) => {
        if (element.autoflag === 1) {
          element.splanobjective.forEach((element1: any) => {
            element1.serviceplanaction.personsinvolved = [];
            if (element1.serviceplanaction?.length > 0) {
              element1.serviceplanaction.forEach((action: any) => {
                if (action.autoflag !== null) {
                  action.serviceplanpersoninvolved.forEach((p: any) => {
                    personsinvolved.push(this.getFullName(p.person).replace(/\s+/g, ''));
                  });
                }
              });
            }
          });
        }
      });
      return personsinvolved;
    }
    sortedStringify(obj: any): string {
      if (obj){
        obj.familyFirstPrevention = undefined;
      }
      return JSON.stringify(obj, Object.keys(obj || {}).sort());
    }
    
    cancelChildComp() {
      this.candidacyFormGroupIsChildComp = false;
      this.isVersionEbpNotCompleted = false;
    }
    getHistForCompletionDate(serviceplanid: any, cb?: any) {
      this.isAddPlan = true;
      this._commonhttp
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          order: this.displayorder,
          where: {
           objectid: serviceplanid,
           objecttype: 'SPLAN'
           }
        }),
        'snapshothist' + '?filter'
      ).subscribe(
        response => {
          this.serviceplanversions = [];
          if(response && response.length > 0){
            this.serviceplanversions = response;
            this.serviceplanslist.forEach(plan => {
              if(plan.serviceplanid === this.serviceplanversions[0].objectid){
                this.handleIfObjectidMatchesFn(this.serviceplanversions, plan, serviceplanid);
              }
            });
          }
          this.isAddPlan = false;
          if (cb) {
            cb();
          }
       });
    }
  // Assosiated to getHistForCompletionDate method
  private handleIfObjectidMatchesFn(serviceplanversions: any[], plan: ServicePlanService, serviceplanid: any) {
    if (serviceplanversions && serviceplanversions.length > 0) {
      serviceplanversions.forEach(version => {
        if (version.approvalstatus === 'Approved') {
          plan.enddate = version.approvaldate;
        }
      });
    }
    if (serviceplanid === this.selectedService.serviceplanid) {
      this.handleIfServiceplanidMatchesFn(serviceplanversions);
    }
  }
  // Assosiated to getHistForCompletionDate method
  private handleIfServiceplanidMatchesFn(serviceplanversions: any[]) {
    const serviceplanvers = _.cloneDeep(serviceplanversions);
    serviceplanvers.sort(function (a: any, b: any) {
      return (new Date(b.approvaldate).getTime() - new Date(a.approvaldate).getTime());
    });
    const approvedVersion = serviceplanvers.find((e: any) => e.approvalstatus && e.approvaldate && e.approvedby && new Date(e.approvaldate).getTime() > new Date("2024-07-16").getTime());
    if (approvedVersion) {
      const control = <FormArray>this.candidacyFormGroup.get('candidates');
      control.controls = [];
      const controlTraditional = <FormArray>this.candidacyFormGroup.get('candidatestraditional');
      approvedVersion.snapshotdata.candidatesObj?.candidates.forEach((child: any) => {
        this.handleSnapshotdataInCandidatesObjFn(child, control);
      });
      controlTraditional.clear();
      approvedVersion.snapshotdata.candidatesObj?.candidatestraditional.forEach((child: any) => {
        controlTraditional.push(this._formBuilder.group(this.payloadInGetHistForCompletionDateFn(child)));
      });
      this.candidacyFormGroupIsChildCompSaved = true;
    }
  }
  // Assosiated to getHistForCompletionDate method
  private payloadInGetHistForCompletionDateFn(child: any): any {
    return {
      id: child.id ? child.id : '',
      name: child.name ? child.name : '',
      candidacy: child.candidacy,
      candidacydate: child.candidacydate,
      disabledate: child.candidacydate ? true : false,
      disablefield: child.candidacydate ? true : false,
      details: child.details ? child.details : '',
      ebp: child.ebp ? child.ebp : ''
    };
  }
  // Assosiated to getHistForCompletionDate method
  private handleSnapshotdataInCandidatesObjFn(child: any, control: FormArray) {
    if (!child.details.includes("NONE")) {
      control.push(this._formBuilder.group({
        id: child.id ? child.id : '',
        name: child.name ? child.name : '',
        candidacy: child.candidacy,
        candidacydate: child.candidacydate,
        disabledate: child.candidacydate ? true : false,
        details: child.details ? child.details : '',
        imminentrisks: [],
        ebp: child.ebp ? child.ebp : ''
      }));
    }
  }

    getHist() {
      this._commonhttp
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          order: this.displayorder,
          where: {
           objectid: this.selectedService.serviceplanid,
           objecttype: 'SPLAN'
           }
        }),
        'snapshothist' + '?filter'
      ).subscribe(
        response => {
          this.listSnapShot = [];
          this.personlistforsnapshot = [];
          if(response) {
            this.listSnapShot = response;
            this.listSnapShot.forEach(element => {
              if(element?.requestedby === this._authService?.getCurrentUser()?.user?.securityusersid
              ||(element?.insertedby === this._authService?.getCurrentUser()?.user?.securityusersid)){
                element['isrequestedbyuser']=true;
              }
              this.personlistforsnapshot.push([]);
            });
            if(this.selectedSnapshotVersion != null && this.selectedSnapshotVersion !== undefined){
              const selectedversion = response.find(version => version.id === this.selectedSnapshotVersion.id);
              this.selectedSnapshotVersion = selectedversion;
              this.setSignaturesList(selectedversion); // set new list with added signature.
            }
          }
       });
    }


    getHistoryForServicePlan() {
      this.listSnapShot = [];
      this.personlistforsnapshot = [];
      this._commonhttp
      .getArrayList(
        new PaginationRequest({
          method: 'post',
          where: {
           objectid: this.selectedService?.serviceplanid,
           objecttype: 'SPLAN'
           }
        }),
        'Serviceplan/getserviceloghistory'
      ).subscribe(
        (response: any) => {
          if(response) {
            response.sort(function(a: any,b: any){
              return (new Date(b.insertedon).getTime() - new Date(a.insertedon).getTime());
            });
            this.listSnapShot = response;            
              this.listSnapShot.forEach(element => {
                this.personlistforsnapshot.push([]);
                if(element?.requestedby === this._authService.getCurrentUser().user.securityusersid){
                  element['isrequestedbyuser']=true;
                }
                
              });
            if(this.selectedSnapshotVersion != null && this.selectedSnapshotVersion !== undefined){
              const selectedversion = response.find((version: { id: any; }) => version.id === this.selectedSnapshotVersion.id);
              this.selectedSnapshotVersion = selectedversion;
              this.setSignaturesList(selectedversion); // set new list with added signature.
            }
          }          
       });
    }

   // Getter to return comma-separated full names
   getCommaSeparatedFullNames(persons: any[]): string {
    return persons.map(person => person.fullname).join(', ');
  }
  
  timecheck(objective: any) {
    if (objective && Array.isArray(objective.serviceplanaction)) {
      objective.serviceplanaction.map((item: any) => {
        const startdate = new Date(item.startdate);
        const enddate = new Date(item.enddate);
        const currdate = new Date();
        const diff = Math.abs(enddate.getTime() - currdate.getTime());
        const diffDays = Math.ceil(diff / (1000 * 3600 * 24));
        const actionDiff = Math.abs(enddate.getTime() - startdate.getTime());
        const nod = Math.ceil(actionDiff / (1000 * 3600 * 24));
        item.nod = nod;
        if (diffDays > 0 && diffDays < 30 && item.status === 'open') {
          item.alert = 1;
        } else if (diffDays >= 30 && diffDays < 60 && item.status === 'open') {
          item.alert = 2;
        } else if (diffDays >= 60 && item.status === 'open') {
          item.alert = 3;
        }
      });
    }
  }

  showEbpInfoDialog(){
    (<any>$('#ebp-warning-hoover-popup')).modal('show');
  }

  confirmDelete(type: any, item: any) {
    this.deletetype = type;
    this.deleteObject = item;
    const res =this.listSnapShot;
    this.getHistoryForServicePlan();
    setTimeout(()=>{
    const confirmnopending = res.find(c=>(c.approvalstatus ==='Pending'));
    if(confirmnopending) {
      (<any>$('#delete-pending-popup')).modal('show');

    }
     else {
    (<any>$(this.deletepopupid)).modal('show');
     }
    },3000);
  }

  deleteItem() {
    if (this.deletetype === 'service') {
      this.addServicePlan(0);
    } else if (this.deletetype === 'goal') {
      this.addGoal(0, this.deleteObject);
    } else if (this.deletetype === 'objective') {
      this.addFocusPlan(0, this.deleteObject);
    } else if (this.deletetype === 'action') {
      this.addActionPlan(0, false, this.deleteObject);
    } else if (this.deletetype === 'visitationplan') {
      this.deleteVisitationPlan(this.deleteObject);
    }
  }

  isSpReadyForReview() {

    //Signature checks
    // && this.selectedService.serviceplansignatures['familymembersign']
    // && this.selectedService.serviceplansignatures['ihmcaseworkersign'] && this.selectedService.serviceplansignatures['oohcaseworkersign']

    if (this.selectedService && Array.isArray(this.selectedService.splangoal)) {
        const goals = this.selectedService.splangoal;
        if (goals.length > 0) {
            return goals.some((goal: any) =>
              (!goal.approvalstatustypekey && (Array.isArray(goal.splanobjective) && goal.splanobjective.length > 0))
            );
        } else {
          return false;
        }
      } else {
        return false;
      }

  }

  // YTP Stuff
  getYTPList() {
    return this._commonhttp.getArrayList(
        {
          page: 1,
          limit: 20,
          method: 'get',
          where: {
            intakeserviceid: this.intakeserviceid,
            approvalstatuskey: 'Approved'
          },
          order: this.displayorder
        }, 'youthtransitionplan' + '?filter'
      ).subscribe(
        (response) => {
          this.ytpList = response;
          this.selectedYTP = null;
    });
  }

  selectYTP(item: any) {
    this.selectedYTP = item;
   // console.log("2")
    this.setSelectedSnapshotVersion(item, false)
  }

  selectImportYTP() {
    (<any>$('#import-ytp')).modal('show');
  }

  importYTP() {
    const payload: any = {};
    payload['servicePlanID'] = this.selectedService?.serviceplanid;
    payload['ytpID'] = this.selectedYTP?.youthtransitionplanid;
    this._commonhttp.create(
      payload,
      'youthtransitionplan/importYTPtoSP'
    ).subscribe(
      response => {
        this.getServicePlans();
        this._alertservice.success('Youth Transition Plan data imported successfully.');
        (<any>$('#import-ytp')).modal('hide');
      },
      error => {
        this._alertservice.error('Error in importing Youth Transition Plan.');
      }
    );
  }

  routeServiceCaseToCaseWorker(item: any) {
    (<any>$('#serviceCaseHistory')).modal('hide');
    (<any>$('#confirm-request-case')).modal('hide');
    this.storage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
    if (item) {
        this._datastore.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttypekey);
    }
    const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecaseid + '/casetype';
    this._commonhttp.getAll(url).subscribe((response) => {
        const dsdsActionsSummary = response[0];
        if (dsdsActionsSummary) {
            this._datastore.setData('da_status', dsdsActionsSummary.da_status);
            this._datastore.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = '/pages/case-worker/' + item.servicecaseid + '/' + item.servicecasenumber + '/dsds-action/person-cw';
            this._router.navigateByUrl('/', { skipLocationChange: true }).then(() => this._router.navigate([currentUrl]));
        }
    });
  }

  selectGoal(goal: any) {
      this.addObjective = true;
      this.selectedGoal = goal;
      this._datastore.setData('SelectedGoal', this.selectedGoal);
  }

  selectObjective(objective: any) {
    this.selectedObjective = objective;
  }

  // We are still waiting for the business requirement for these dropdown value
  // So for now just adding some values on the UI to show the ability
  getGoalReferenceValues() {
    this._commonDropdownService.getReferenveValuesByTypeIdandTeam('106', this._authService.getAgencyName() ).subscribe(
      (resultresp) => {
        this.goalReferenceValues = resultresp;
      });
  }

  getGoalReasonRefValues() {
    this._commonDropdownService.getReferenveValuesByTypeIdandTeam('500119', this._authService.getAgencyName() ).subscribe(
      (resultresp) => {
        this.goalReasonRefValues = resultresp;
      });
  }
  

  getServicePlanNameReferenceValues() {
    this.servicePlanNameReferenceValues = [
        'Family service plan',
        'Individual Service Plan'
    ];
  }

  addOtherGoal() {
    this.isOtherGoal = true;
    const goalName: any = this.servicePlanGoal?.get('goalname');
    goalName.disable({ emitEvent: false });
    this.servicePlanGoal?.patchValue({goalname : 'Other'});
  }

  resetGoalsModal() {
      this.isOtherGoal = false;
      const goalName: any = this.servicePlanGoal?.get('goalname');
      this.servicePlanGoal?.reset();
      goalName.enable({ emitEvent: false });
      this.goalAutoSaveInitiated = false;
      clearInterval(this.goalAutoSaveIntervalTimer);
  }

  //Status values
  //Goal to have 3 valid statuses: in progress, achieved, not achieved
  //Objective and Action to have 2 valid statuses: achieved or not achieved
  getStatusReferenceValues() {
    this.goalStatusReferenceValues = [this.inprogress, 'Achieved', this.notachieved];
    this.objectiveStatusReferenceValues = [this.inprogress, 'Achieved', this.notachieved];
    this.actionStatusReferenceValues = [this.inprogress, 'Achieved', this.notachieved];
  }

  setDefaultGoalFormValues() {
    this.isGoalAdded = false;
    this.serviceGoal = true;
    this.serviceObjective = true;
    this.servicePlanForm.enable();
    this.servicePlanForm.reset();
    this.focusPlanFormGroup.disable();
    this.actionPlanFormGroup.disable();
    this.focusPlanFormGroup.reset();
    this.actionPlanFormGroup.reset();
    this.actionAutoSaveInitiated = false;
    clearInterval(this.actionAutoSaveIntervalTimer);
    this.serviceobject = null;
    this.selectedGoal = null;
    this.servicePlanGoal?.patchValue({
      status: this.inprogress
    })
  }

  setDefaultObjectiveFormValues() {
    this.focusPlanFormGroup.patchValue({
      status: this.notachieved
    })
  }

  setDefaultActionFormValues() {
    this.actionPlanFormGroup.patchValue({
      status: this.notachieved
    }, {emitEvent: false, onlySelf: true})
  }

  setDefaultSnapshotFilterValues(isPopNotOpen?: any, isVersion?: any) {
    let previousData: any;
    if (this.listSnapShot && this.listSnapShot.length > 0) {
      previousData = this.listSnapShot[0].snapshotdata;
      const personIds: any[] = [];
      previousData.personsinvolved.forEach((element: any) => {
        personIds.push(element.personid);
      });
      this.snapshotFilterFormGroup.patchValue({
        startdate: previousData.versionfilterstartdate,
        enddate: previousData.versionfilterenddate,
        personlist: personIds
      });
    } else {
      const personIds: any[] = [];
      if(this.serviceplanslist && this.serviceplanslist.length == 1) {
        previousData = this.serviceplanslist[0]; 
        previousData.involvedpersons.forEach((element: any) => {
          personIds.push(element.id);
        });
      }
      this.snapshotFilterFormGroup.patchValue({
        startdate: this.selectedService.effectivedate,
        enddate: this.selectedService.targetenddate,
        personlist: personIds
      });
    }
    this.mindate=this.selectedService.effectivedate;
    this.initCandidacyForm1();
    this.createInvolvedPersonForms(previousData, isPopNotOpen, isVersion);
    if (!isPopNotOpen) {
     
        (<any>$('#splan-snapshot-filter')).modal('show');
      
    }
  }

  /**
   * Snapshot work 
   * */
   versionsnapshot :any = []
  createSnapshot(isAutoSave?: any) {
    if (this.isVersionEbpNotCompleted) {
      return;
    }
    this.checkmandatory = true
    if (this.snapshotFilterFormGroup.valid || isAutoSave) {
      const versionfilterstartdate = this.snapshotFilterFormGroup.get('startdate')?.value;
      const versionfilterenddate = this.snapshotFilterFormGroup.get('enddate')?.value;
      const splanversionpersoninvolved = this.checksPlanversionpersoninvolvedFn();
      this.selectedService.childrenHeader = this?.childrenHeader?.join(', ');
      this.selectedService.legalGuardian = this.legalGuardian;
      this.versionsnapshot = _.cloneDeep(this.selectedService);
      const versiongoal: any[] = [];
      const versionvisitation: any[] = [];
      const goals = this.reusableCreateSnapshotFn(this.versionsnapshot?.splangoal);
      const visitations = this.reusableCreateSnapshotFn(this.visitationplansresponse);
      this.goalLoopFn(goals, splanversionpersoninvolved, versionfilterstartdate, versionfilterenddate, versiongoal);
      this.versionsnapshot.versionfilterstartdate = versionfilterstartdate;
      this.versionsnapshot.versionfilterenddate = versionfilterenddate;
      this.versionsnapshot.splangoal = versiongoal;
      if (!isAutoSave) {
        this.visitationsLoopFn(visitations, splanversionpersoninvolved, versionfilterstartdate, versionfilterenddate, versionvisitation);
      }
      this.versionsnapshot.visitationplans = versionvisitation;
      this.versionsnapshot.personsinvolved = this.personList.filter(x => splanversionpersoninvolved.includes(x.personid));
      let personsinvolvedNames: any[] = [];
      this.versionsnapshot.personsinvolved.forEach((pinvolved: any) => {
        personsinvolvedNames.push(pinvolved.fullname.replace(/\s+/g, ''));
      });
      if (this.createSnapshotHHCheck()) {
        this._alertservice.warn('This case does not have a Head of Household. Please add the Head of Household in persons screen.');
        return;
      }
      this.getServicePlanVersionInvolvedPersons();
      this.setVersionSaveEnabled();
      if (!isAutoSave) {
        let previousUtilizedTypesChanged = false;
        previousUtilizedTypesChanged = this.getPerviousUtilizedTypes(previousUtilizedTypesChanged, personsinvolvedNames);
        if (versiongoal.length > 0 || previousUtilizedTypesChanged) {
          (<any>$('#service-plan-version-eligibility')).modal('show');
        } else {
          this._alertservice.error(`Service Plan Must have at least one Objective for each Goal and One Action for each Objective ` +
            `and Person benefiting in the action must match the Person benefiting in the version to continue with send for Approval`);
        }
      }
    }
    else {
      this._alertservice.error('Please fill required fields');
    }
  }

  createSnapshotHHCheck(){
    return !this.headofhouseholdName && this.involvedPersonForm.length > 0 && this.involvedPersonForm.find((e: any) => e.ebp.utilizedtypes != '' && e.ebp.utilizedtypes != null);
  }

  getPerviousUtilizedTypes(previousUtilizedTypesChanged: any, personsinvolvedNames: any){
    if (this.listSnapShot.length > 0) {
      this.listSnapShot[0].snapshotdata.involvedpersons.forEach((helement: any) => {
        if (!previousUtilizedTypesChanged && personsinvolvedNames.includes(helement.name.replace(/\s+/g, ''))) {
          let historyOfEle = this.involvedPersonForm.find((e: any) => (helement.id === e.id));
          if (historyOfEle &&  historyOfEle.ebp.utilizedtypes != null && historyOfEle.ebp.utilizedtypes != helement.ebp.utilizedtypes) {
            previousUtilizedTypesChanged = true;
          }
        }
      });
    } else if (this.selectedService && this.selectedService.involvedpersons && this.selectedService.involvedpersons.length > 0) {
      previousUtilizedTypesChanged = this.perviousUtilizedTypesElse(previousUtilizedTypesChanged, personsinvolvedNames);
    }
    return previousUtilizedTypesChanged;
  }

  perviousUtilizedTypesElse(previousUtilizedTypesChanged: any, personsinvolvedNames: any){
    this.involvedPersonForm.forEach(sielement => {
      if (!previousUtilizedTypesChanged && personsinvolvedNames.includes(sielement.name.replace(/\s+/g, '')) && sielement.ebp && sielement.ebp.utilizedtypes != '' && sielement.ebp.utilizedtypes != null) {
       let currentp = this.selectedService.involvedpersons.find((e: any) => sielement.name.replace(/\s+/g, '') == e.name.replace(/\s+/g, ''));
       if (currentp && currentp.ebp.utilizedtypes != sielement.ebp.utilizedtypes) {
         previousUtilizedTypesChanged = true;
       }
      }
   });
   return previousUtilizedTypesChanged;
  }
  // Assosiated with createSnapshot function
  private goalLoopFn(goals: any[], splanversionpersoninvolved: any, versionfilterstartdate: any, versionfilterenddate: any, versiongoal: any[]) {
    let isValidSnapshot = true;
    goals.forEach(goal => {
      const objectives = this.reusableCreateSnapshotFn(goal?.splanobjective);
      const versionobjective: any[] = [];
      this.countobj = 0;
      objectives.forEach(objective => {
        const actions = this.reusableCreateSnapshotFn(objective?.serviceplanaction);
        const versionactions: any[] = [];
        actions.forEach(action => {
          this.count = 0;
          action.serviceplanpersoninvolved.forEach((serviceplanperinvolved: any) => {
            if (splanversionpersoninvolved.indexOf(serviceplanperinvolved.personinvolved) > -1) {
              this.count++;
            }
          });
          if (this.count > 0 &&
            (action.enddate == null || action.enddate === undefined || new Date(versionfilterstartdate).setHours(0, 0, 0, 0) <= new Date(action.enddate).setHours(0, 0, 0, 0))
            && new Date(versionfilterenddate).setHours(0, 0, 0, 0) >= new Date(action.startdate).setHours(0, 0, 0, 0)) {
            versionactions.push(action);
          }
        });
        if (versionactions.length > 0) {
          objective.serviceplanaction = versionactions;
          versionobjective.push(objective);
        } else {
          objective = {};   // NOSONAR // Making object empty on else condition
          this.countobj++;
        }
      });
      if (this.countobj === objectives.length) {
        goal = {};   // NOSONAR // Making object empty on else condition
        isValidSnapshot = false;  // NOSONAR // updating flag.
      } else {
        goal.splanobjective = versionobjective;
        versiongoal.push(goal);
      }
    });
  }
  // Assosiated with createSnapshot function
  private visitationsLoopFn(visitations: any[], splanversionpersoninvolved: any, versionfilterstartdate: any, versionfilterenddate: any, versionvisitation: any[]) {
    visitations.forEach(visitation => {
      if (splanversionpersoninvolved.indexOf(visitation.personid) >= -1) {
        let temp = this.frequencyofplannedvisits.find(x => x.ref_key === visitation.visitfrequencytypekey);
        visitation.visitfrequencytypekey = (temp) ? (temp.value_text) : '';
        temp = this.lengthofplannedvisit.find(x => x.ref_key === visitation.visitdurationtypekey);
        visitation.visitdurationtypekey = (temp) ? (temp.value_text) : '';
        temp = this.childandvisitortransportation.find(x => x.ref_key === visitation.childtransportationtypekey);
        visitation.childtransportationtypekey = (temp) ? (temp.value_text) : '';
        temp = this.childandvisitortransportation.find(x => x.ref_key === visitation.visitortransportationtypekey);
        visitation.visitortransportationtypekey = (temp) ? (temp.value_text) : '';
        if ((!visitation.enddate || new Date(versionfilterstartdate).setHours(0, 0, 0, 0) <= new Date(visitation.enddate).setHours(0, 0, 0, 0)) &&
          new Date(versionfilterenddate).setHours(0, 0, 0, 0) >= new Date(visitation.establisheddate).setHours(0, 0, 0, 0)) {
          versionvisitation.push(visitation);
        }
      }
    });
  }
  // Assosiated with createSnapshot function
  private reusableCreateSnapshotFn(data: any) {
    return Array.isArray(data) ? data : [];
  }
  // Assosiated with createSnapshot function
  private checksPlanversionpersoninvolvedFn() {
    const splanversionpersoninvolved = this.snapshotFilterFormGroup.get('personlist')?.value;
    if (splanversionpersoninvolved) {
      this?.childList?.forEach(child => {
        if (splanversionpersoninvolved?.includes(child?.personid)) {
          if (!(this?.childrenHeader?.includes(child?.name))) {
            this?.childrenHeader?.push(child?.name);
          }
        }
      });
    }
    return splanversionpersoninvolved;
  }

setVersionSaveEnabled() {
  this.versionSaveEnabled = !((this.candidacyFormGroup1.value.candidatestraditional.filter((e: any) => (e.candidacy === null || e.candidacy === undefined)).length > 0) || (this.candidacyFormGroup1.value.candidatestraditional.filter((e: any) => (e.imminentrisks === null || e.imminentrisks === undefined || e.imminentrisks.length === 0)).length > 0));
}

getServicePlanVersionInvolvedPersons() { 


  const control = <FormArray>this.candidacyFormGroup1.controls.candidates;
  const controlTraditional = <FormArray>this.candidacyFormGroup1.controls.candidatestraditional;
    let servicePlanVersionInvolvedPersonsArr = [];
    servicePlanVersionInvolvedPersonsArr = this.involvedPersonForm;
    const candidates: any[] = [];
    const candidatesTraditional: any[] = [];
     servicePlanVersionInvolvedPersonsArr.forEach((person: any)=> {
      const details: any[] = [];
      person.imminentrisks.forEach((element: any) => {
          details.push(this.riskList.find((e: any) => (e.ref_key === element)).value_text);
      });
      const selectedDetail = this.involvedPersonForm.find((e: any) => e.id === person.id);
      const ob = this.returnObFn(person, selectedDetail, details);
      const obj = this.returnObjFn(person, selectedDetail);
      if(person?.ebp?.familyFirstPrevention) {
        control.push(this._formBuilder.group(ob));
        candidates.push(obj);
      } else if (person?.imminentrisks && person.imminentrisks.length > 0 && !person.imminentrisks.includes('NONE')) {
        candidatesTraditional.push(obj)
        const disabledate = person?.imminentrisks?.[0] == "NONE" && person?.ebp?.isebpreferralmade === "No" ? false : true;
        const prsncndcy =  person?.ebp?.isebpreferralmade === 'Yes' || disabledate ? '1' : '0';
        controlTraditional.push(this._formBuilder.group({
          id: person.id,
          name:  person.name,
          candidacy: !disabledate ? null : prsncndcy, 
          candidacydate: person && !disabledate ? null :new Date(),
          disabledate: disabledate,
          comment: selectedDetail.comment,
          livingininformalkinship: selectedDetail.livingininformalkinship, 
          enablelivinginink:selectedDetail.enablelivinginink,
          imminentrisks: details.join(' | '),
          details: details.join(' | '),
          ebp: selectedDetail.ebp
        }));
      }

    })
   return {
      candidates : candidates,
      candidatesTraditional: candidatesTraditional
    }
  }
  // Assosiated to getServicePlanVersionInvolvedPersons method
  private returnObjFn(person: any, selectedDetail: any) {
    return {
      id: person.id,
      name: person.name,
      candidacy: person.imminentrisks[0] == "NONE" ? '0' : '1',
      candidacydate: new Date(),
      disabledate: true,
      comment: selectedDetail.comment,
      livingininformalkinship: selectedDetail.livingininformalkinship,
      enablelivinginink: selectedDetail.enablelivinginink
    };
  }
  // Assosiated to getServicePlanVersionInvolvedPersons method
  private returnObFn(person: any, selectedDetail: any, details: any[]) {
    return {
      id: person.id,
      name: person.name,
      candidacy: person.imminentrisks[0] == "NONE" ? '0' : '1',
      candidacydate: new Date(),
      disabledate: true,
      imminentrisks: this._formBuilder.array(person.imminentrisks),
      comment: selectedDetail.comment,
      livingininformalkinship: selectedDetail.livingininformalkinship,
      enablelivinginink: selectedDetail.enablelivinginink,
      details: details.join(' | '),
      ebp: selectedDetail.ebp
    };
  }

  setSelectedSnapshotVersion(item: any, assign: any) {
    this.isEbpReferralMade = false;
    if (item && item.snapshotdata && item.snapshotdata.involvedpersons && item.snapshotdata.involvedpersons.length) {

      item.snapshotdata.involvedpersons.forEach((element: any) => {
        if(element && element.ebp && element.ebp?.isebpreferralmade == 'Yes' && element.ebp?.utilized == 'Yes') {
          this.isEbpReferralMade = true;
          this.clientNamesForEbp.push(element);
        }
      });
    }
    
    if (item && item.snapshotdata && item.snapshotdata.splangoal && item.snapshotdata.splangoal.length) {
      this.splangoalMapFn(item);
    }
    if (this.isAction === true && this.isObjective === true) {
      this.selectedSnapshotVersion = item;
      this.ifAssignFn(assign);
    }
    else {
      (<any>$(this.caseassignpopupid)).modal('hide');
      this._alertservice.error('Service Plan Must have at least one Objective for each Goal and One Action for each Objective '
        + 'and Person benefiting in the action must match the Person benefiting in the version to continue with send for Approval');
    }
  }
  // Assosiated with setSelectedSnapshotVersion function
  private splangoalMapFn(item: any) {
    item.snapshotdata.splangoal.map((plan: any) => {
      if (plan.splanobjective.length > 0) {
        this.isObjective = true;
      }
      else {
        this.isObjective = false;
      }
      if (plan.splanobjective && plan.splanobjective.length) {
        plan.splanobjective.map((obj: any) => {
          if (obj.serviceplanaction.length > 0) {
            this.isAction = true;
          }
          else {
            this.isAction = false;
          }
        });
      }
    });
  }
  // Assosiated with setSelectedSnapshotVersion function
  private ifAssignFn(assign: any) {
    if (assign) {
      (<any>$('#splan-snapshot-version')).modal('hide');
      (<any>$(this.caseassignpopupid)).modal('show');
    } else {
      (<any>$(this.caseassignpopupid)).modal('hide');
    }
  }

  updateSnapshotVersionStatus() {
    const payload: any = {};
    payload['id'] = this.selectedSnapshotVersion.id;
    payload['approvalstatus'] = this.approvalProcess;
    if(this.approvalProcess === 'Approved'){
      payload['approvedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
      payload['approvaldate'] = new Date();
    }
    if(this.approvalProcess === 'Pending'){
    payload['requestedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['requesteddate'] = new Date();
    }
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['insertedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    this._commonhttp.patch(
      this.selectedSnapshotVersion.id,
      payload,
      'snapshothist'
    ).subscribe(
      response => {
        this._alertservice.success('Service plan version decision submitted successfully!');
        this.getHistoryForServicePlan();
      },
      error => {
        this._alertservice.error('Error in submitting service plan version decision!');
      }
    );
  }


  /**
   * Signature
   */
  getSignaturePersonTypeReferenceValues() {
    this.signaturePersonTypes = [
      {key: 'CWIHM', value: 'Case Worker (In-home Services)'},
      {key: 'CWOOH', value: 'Case Worker (Out-of-home Services)'},
      {key: 'FAM', value: 'Family Member'},
      {key: 'SUP', value: 'Supervisor'}
    ];
  }

  getSignaturePersonTypeByKey(key: any) {
    return this.signaturePersonTypes.find((item: { key: any; }) => item.key === key);
  }

  saveSignatureDetails() {
    this.personSignatureFormGroup.get('persontype')?.setValue(
      this.getSignaturePersonTypeByKey(
        this.personSignatureFormGroup.get('persontypekey')?.value
      )?.value
    ); 
    this.setSignaturesList(this.selectedSnapshotVersion);

    this.selectedSignaturesList.push(this.personSignatureFormGroup.value)
    
    const payload: any = {};
    payload['id'] = this.selectedSnapshotVersion.id;
    payload['signatures'] = this.selectedSignaturesList;
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['insertedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    this._commonhttp.patch(
      this.selectedSnapshotVersion.id,
      payload,
      'snapshothist'
    ).subscribe(
      response => {
        this.resetSignatureCapture();
        this._alertservice.success('Signatures captured successfully!');
        this.getHist();
        (<any>$('#capture-signature')).modal('hide');
        (<any>$('#signatures-list')).modal('show');
      },
      error => {
        this._alertservice.error('Error in capturing signatures!');
      }
    );
  }

  setSignaturesList(item: any) {
    this.selectedSignaturesList = [];
    this.clientNamesForEbp =  [];
    if (item && item.signatures) {
      this.selectedSignaturesList = item.signatures;
    }
    this.setSelectedSnapshotVersion(item, false);
  }

  public clearSignature(): void {
    this.signaturePad.clear();
  }

  resetSignatureCapture() {
    this.clearSignature();
    this.personSignatureFormGroup.reset();
  }


  deleteServicePlan(data: any) {
    this.selectedSnapshotVersion = data;
    const payload: any = {};
    payload['id'] = data.id;
    payload['activeflag'] = 0;
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['insertedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    this._commonhttp.patch(
      data.id,
      payload,
      'snapshothist'
      ).subscribe(
      (response) => {
      this.getHist();
      this._alertservice.success('Snapshot deleted successfully');
    },
    (error) => {
      this._alertservice.error('Could not delete Snapshot');
  })
    
  }

addGoalOnLoad(activeflag: any, item: any, isAutoSave: any) {
  this.goalrequired =true;
  if(this.servicePlanGoal?.valid){
  const goal = (activeflag === 1) ? this.servicePlanGoal?.getRawValue() : item;
  goal.activeflag = activeflag;
  goal['serviceplanid'] = this.selectedServicePlan.serviceplanid;
  this._commonhttp.create(goal, 'splangoal/addupdate').subscribe(
    response => {
      if (response) {
        this.servicePlanGoal?.patchValue({splangoalid : response.splangoalid}, {emitEvent: false, onlySelf: true});
        this.selectedGoal = response;
        if(isAutoSave) {
          this.currentGoalData = {
            goalname: goal.goalname,
            splangoalid : response.splangoalid,
            status: goal.status,
          }
          this._alertservice.success('Goal Auto-Saved Successfully!');
          this.goalAutoSaved = true;
          this.lastUpdatedTime = moment().format(this.dtformat);
        } else {
            this.currentGoalData = {
            goalname: null,
            splangoalid : null,
            status: null,
          }
          this.goalAutoSaved = false;
          this.serviceGoal = false;
          this.serviceObjective = true;
          this.servicePlanGoal?.reset();
          this.goalAutoSaveInitiated = false;
          clearInterval(this.goalAutoSaveIntervalTimer);
          this.focusPlanFormGroup.enable();
          this._alertservice.success('Goal added successfully!');
        }
         
      }
    }
  );
  }
  else{
    this._alertservice.error("Please enter all required fields")
  }
}

cancelObjective() {
  this.focusPlanFormGroup.reset();
  this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();
}

  addFocusPlanOnLoad(activeflag: any, isAutoSave: any, focusPlan?: ServicePlanFocus) {
    this.focusplanmandatory = true;

    if (isAutoSave && !this.focusPlanFormGroup.valid) {
      this._alertservice.error(this.autosavemsg);
      return false;
    }
    if (this.focusPlanFormGroup.valid) {
      const objective = (activeflag === 1) ? this.focusPlanFormGroup.getRawValue() : focusPlan;
      const objectivealertmsg = this.getObjectiveAlertMsgFn(objective, isAutoSave);

      objective.needs = JSON.stringify(objective.needs);
      objective.strengths = JSON.stringify(objective.strengths);
      objective.activeflag = activeflag;
      objective.splangoalid = this.selectedGoal.splangoalid;
      objective.serviceplanid = this.selectedService.serviceplanid;

      this.selectedService.serviceplanfocus = this.returnServiceplanfocusFn();

      this._commonhttp.create(objective, 'splanobjective/addupdate').subscribe(
        response => {
          this.serviceobject = response;
          this.handleServiceobjectFn(objective, response);

          if (isAutoSave) {
            this.handleAutoSaveFn(response, objectivealertmsg);
          } else {
            this.handleNonAutoSaveFn(activeflag, objectivealertmsg);
          }

        },
        error => {
          this.focusPlanFormGroup.reset();
          const message = (activeflag === 1) ? 'Error in updating Objective.' : 'Error in deleting Objective.';
          this._alertservice.error(message);
        }
      );
    }
    else {
      this._alertservice.error(this.mandatorymsg);
    }
  }
  // Assosiated with addFocusPlanOnLoad function
  private handleServiceobjectFn(objective: any, response: any) {
    objective.splanobjectiveid = response.splanobjectiveid;

    const objectFocus = this.selectedService.serviceplanfocus.find((fdata: { splanobjectiveid: any; }) => fdata.splanobjectiveid === response.splanobjectiveid);

    if (!objectFocus) {
      this.selectedService.serviceplanfocus.unshift(objective);
    } else {
      const index = this.selectedService.serviceplanfocus.findIndex((fdata: { splanobjectiveid: any; }) => fdata.splanobjectiveid === response.splanobjectiveid);
      if (objective.activeflag === 1) {
        this.selectedService.serviceplanfocus[index] = objective;
      } else {
        this.selectedService.serviceplanfocus.splice(index, 1);
      }
    }
  }
// Assosiated with addFocusPlanOnLoad function
  private handleNonAutoSaveFn(activeflag: any, objectivealertmsg: string) {
    this.objectiveAutoSaved = false;
    this.focusPlanFormGroup.reset();
    this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();
    const message = (activeflag === 1) ? objectivealertmsg : 'Objective is deleted successfully.';
    this._alertservice.success(message);
    if (activeflag === 1) {
      this.serviceObjective = false;
      this.actionPlanFormGroup.enable();
      this.serviceAction = true;
    }
  }
// Assosiated with addFocusPlanOnLoad function
  private handleAutoSaveFn(response: any, objectivealertmsg: string) {
    this.objectiveAutoSaved = true;
    this.lastObjectiveUpdatedTime = moment().format(this.dtformat);
    this.focusPlanFormGroup.patchValue({ splanobjectiveid: response.splanobjectiveid });
    this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();
    this._alertservice.success(objectivealertmsg);
  }
// Assosiated with addFocusPlanOnLoad function
  getObjectiveAlertMsgFn(objective: any, isAutoSave: any) {
    let objAdd = isAutoSave ? 'Objective Auto-Saved Successfully!' : 'Objective is added successfully.';
    let objUpdate = isAutoSave ? 'Objective Auto-Saved Successfully!' : 'Objective is updated successfully.';
    return (objective.splanobjectiveid === undefined || objective.splanobjectiveid == null || objective.splanobjectiveid === '') ? objAdd : objUpdate;
  }

saveObjective(value: any) {
  this.selectedService = this._datastore.getData('SelectedService');
  this.selectedGoal = this._datastore.getData('SelectedGoal');
  this.addObjective = false;
  this.serviceEditObjective = false;
  this.getServicePlans();
}

saveGoal(value: any) {
  this.editUpdateGoal = false;
  this.selectedService = this._datastore.getData('SelectedService');
  this.selectedGoal = this._datastore.getData('SelectedGoal');
  this.getServicePlans();
}


switchInfo() {
  this.showInfo = !this.showInfo;
}

getPersonResponsible(responsible: any) {
  let result = responsible;
  if (responsible && responsible.indexOf(',') !== -1) {
    result = responsible.replace(/,/g, ', ');
  }
  return result;
}

closeRiskReasonInfo() {
  (<any>$('#imminent-risk-reason-list')).modal('hide');
}

openRiskReasonInfo() {
  (<any>$('#imminent-risk-reason-list')).modal('show');
}

existingForm(){
  setTimeout(()=>{
      this.currentGoalData = this.servicePlanGoal?.getRawValue();
      this.currentObjectiveData = this.focusPlanFormGroup.getRawValue();
      this.currentActionData = this.actionPlanFormGroup.getRawValue();
  }, 3000);
}

initiateGoalAutoSave() {

  this.goalAutoSaveInitiated = true;
  let isGoalChanged = true;

  this.goalAutoSaveIntervalTimer = setInterval(() => {

    // Auto Save Goal
    const latestGoalData = this.servicePlanGoal?.getRawValue();
    isGoalChanged = _.isEqual(this.currentGoalData, latestGoalData); 
    if(!isGoalChanged) {
      if(latestGoalData.goalname !== null && latestGoalData.status !== null  && latestGoalData.status !== '') {
        this.addGoalOnLoad(1,null,true)
      } else {
        this._alertservice.error(this.autosavemsg);
      }
    } 
  }, config.AutoSaveTimer);
  this._datastore.setData('goalAutoSavePlaceTimer', this.goalAutoSaveIntervalTimer);

}

statusChange(value: any) {
  if (value === this.notachieved) {
     this.showGoalReason = true;
  } else {
     this.showGoalReason = false;
  }
}

initiateObjectiveAutoSave() {

  this.objectiveAutoSaveInitiated = true;
  let isObjectiveChanged =  true;

  this.objctiveAutoSaveIntervalTimer = setInterval(() => {
    
    const latestObjectiveData = this.focusPlanFormGroup.getRawValue();
    
    // Auto Save Objective
    latestObjectiveData.comments = (latestObjectiveData.comments === null) ? '' : latestObjectiveData.comments;
    this.currentObjectiveData.comments = (this.currentObjectiveData.comments === null) ? '' : this.currentObjectiveData.comments;
    isObjectiveChanged = _.isEqual(this.currentObjectiveData, latestObjectiveData); 
    if(!isObjectiveChanged){
      this.addFocusPlanOnLoad(1,true)
    }
   
  }, config.AutoSaveTimer);
  this._datastore.setData('objctiveAutoSavePlaceTimer', this.objctiveAutoSaveIntervalTimer);
  
}

initiateActionAutoSave() {
  
  this.actionAutoSaveInitiated = true;
  let isActionChanged = true;

  this.actionAutoSaveIntervalTimer = setInterval(() => {
    
    const latestActionData = this.actionPlanFormGroup.getRawValue();

    // Auto Save Action
    latestActionData.planfor = (latestActionData.planfor === null) ? 'In Home' : latestActionData.planfor;
    this.currentActionData.planfor = (this.currentActionData.planfor === null) ? 'In Home' : this.currentActionData.planfor;
    this.currentActionData.comments = (latestActionData.comments === null && this.currentActionData.comments === '') ? null : this.currentActionData.comments;
    this.currentActionData.serviceplanactionid = (latestActionData.serviceplanactionid === null && this.currentActionData.serviceplanactionid === '') 
                                                        ? null : this.currentActionData.serviceplanactionid;
    this.currentActionData.serviceplanoutcome = (latestActionData.serviceplanoutcome === null && this.currentActionData.serviceplanoutcome === '') 
                                                        ? null : this.currentActionData.serviceplanoutcome;
    isActionChanged = _.isEqual(this.currentActionData, latestActionData); 
    if(!isActionChanged){
      this.addNewActionPlan(1,this.selectedObjective,true)
    }
    
  },config.AutoSaveTimer);
  this._datastore.setData('actionAutoSavePlaceTimer', this.actionAutoSaveIntervalTimer);
 
}
getPersonNameList(id: any, list: any) {
  const selectPersonList = list.filter((f: { personid: any; }) => id?.includes(f.personid));
  this.selectPersonNameList = selectPersonList.map((item: { fullname: any; }) => item?.fullname);
}
getClientNameList(id: any, list: any) {
  const selectPersonList = list.find((f: { personid: any; }) => f.personid === id);
  this.selectedClientName = selectPersonList?.fullname;
}
showHistory() {
  this.getHistoryForServicePlan();
  (<any>$('#history-snapshot-version')).modal('show');
}
clearSelectedSnapShotData() {
  this.selectedSnapShotData = '';
}

showHistoryDetails(data: any) {
  
  this.selectedSnapShotData = data;
  (<any>$('#history-eligibility-dialog')).modal('show');
  let candidatesObj;
  let isOld = false;
  if (data.snapshotdata.candidatesObj) {
    candidatesObj = data.snapshotdata.candidatesObj;
  } else {
    isOld = true;
    candidatesObj = data.snapshotdata.serviceplancandidacy;
  }
  const control = <FormArray>this.candidacyFormGroup2.get('candidates');
  const controlTraditional = <FormArray>this.candidacyFormGroup2.get('candidatestraditional');
  control.clear();
  controlTraditional.clear();
  if (candidatesObj) {
    this.handleCandidateLoopFn(candidatesObj, isOld, data, control);
  
    this.handleCandidatestraditionalFn(candidatesObj, isOld, data, controlTraditional);
  }
}

  private handleCandidatestraditionalFn(candidatesObj: any, isOld: boolean, data: any, controlTraditional: FormArray) {
    candidatesObj.candidatestraditional.forEach((c: any) => {
      if (isOld) {
        if (!c.details) {
          const temp = data.snapshotdata.involvedpersons.find((ip: any) => ip.id === c.id);
          if (temp) {
            c.imminentrisks = temp.imminentrisks;
            const details: any[] = [];
            c.imminentrisks.forEach((element: any) => {
              details.push(this.riskList.find((e: any) => (e.ref_key === element)).value_text);
            });
            c.details = details.join(',');
          }

        }
      }
      controlTraditional.push(this._formBuilder.group({
        id: c.id,
        name: c.name,
        candidacy: c.candidacy,
        candidacydate: c.candidacydate,
        disabledate: c.disabledate,
        details: (c.candidacy === "0" && !c.ebp) ? "NONE" : c.details,
        ebp: c.ebp
      }));
    });
  }

  private handleCandidateLoopFn(candidatesObj: any, isOld: boolean, data: any, control: FormArray) {
    candidatesObj.candidates.forEach((c: any) => {
      if (isOld) {
        if (!c.details) {
          const temp = data.snapshotdata.involvedpersons.find((ip: any) => ip.id === c.id);
          if (temp) {
            c.imminentrisks = temp.imminentrisks;
            const details: any[] = [];
            c.imminentrisks.forEach((element: any) => {
              details.push(this.riskList.find((e: any) => (e.ref_key === element)).value_text);
            });
            c.details = details.join(', ');
          }

        }
      }
      control.push(this._formBuilder.group({
        id: c.id,
        name: c.name,
        candidacy: c.candidacy,
        candidacydate: c.candidacydate,
        disabledate: c.disabledate,
        details: (c.candidacy === "0") ? "NONE" : c.details,
        ebp: c.ebp
      }));
    });
  }

ebppopaddserviceplan(data: any, index: any) {
    this.involvedPersonForm[index].ebp = ((data.status === true) ? data.data : null);
    this.setIsEbpAddServicePlan();
}
setIsEbpAddServicePlan() {
  this.isEbpAddServicePlan = this.involvedPersonFormChildCompleted();
}
ebpversionpop(data: any, index: any) {
  this.involvedPersonForm[index].ebp = ((data.status === true) ? data.data : null);
  this.setIsVersionEbpNotCompleted();
}
setIsVersionEbpNotCompleted() {
  this.isVersionEbpNotCompleted = this.involvedPersonFormChildCompleted();
}
involvedPersonFormChildCompleted() {
  return (this.involvedPersonForm.filter((e: any) => (e.ebp === null || e.ebp === undefined)).length > 0) || (this.involvedPersonForm.filter((e: any) => (e.imminentrisks === null || e.imminentrisks === undefined || e.imminentrisks.length === 0 || (e.imminentrisks.indexOf('INK') > -1 && (!e.livingininformalkinship || (e.livingininformalkinship === 'others' && !e.comment))))).length > 0);
}
ebppop(data: any, index: any, type: any) {
    if (type === 'pr') {
      const controlCandidate = <FormArray>this.candidacyFormGroup1.controls.candidates;
      controlCandidate.at(index).patchValue({ebp: ((data.status === true) ? data.data : undefined)});
    } else {
      const controlTraditional = <FormArray>this.candidacyFormGroup1.controls.candidatestraditional;
      controlTraditional.at(index).patchValue({ebp: ((data.status === true) ? data.data : undefined)}); 
    }
    this.validatecandidacyForm(this.candidacyFormGroup1, '1');
}
ebpmain(data: any, index: any, type: any) {
  if (type === 'pr') {
    const controlCandidate = <FormArray>this.candidacyFormGroup.controls.candidates;
    controlCandidate.at(index).patchValue({ebp: ((data.status === true) ? data.data : undefined)});

  } else {
    const controlTraditional = <FormArray>this.candidacyFormGroup.controls.candidatestraditional;
    controlTraditional.at(index).patchValue({ebp: ((data.status === true) ? data.data : undefined)}); 
  }
  this.validatecandidacyForm(this.candidacyFormGroup);
}
validatecandidacyForm(candidacyFormGroup: any, index?: any) {
  setTimeout(() => {
    const isValid = (candidacyFormGroup.value.candidates.filter((e: any) => (e.ebp === undefined || e.ebp === "")).length === 0 && (candidacyFormGroup.value.candidatestraditional.length === 0 || (candidacyFormGroup.value.candidatestraditional.filter((e: any) => (e.ebp === undefined || e.ebp === "")).length === 0) && (candidacyFormGroup.value.candidatestraditional.filter((e: any) => (e.candidacy === undefined || e.candidacy === null)).length === 0) && (candidacyFormGroup.value.candidatestraditional.filter((e: any) => (e.details === undefined || (e.details === ''))).length === 0)));
    if (index) {
      this.candidacyFormGroupIsChildComp1 = isValid;
    } else {
      this.candidacyFormGroupIsChildComp = isValid;
    }
    this.setVersionSaveEnabled();
    return isValid;
  }, 0);
}
childLivingInInformalKinship1(value: any, index: any) {
  if (!(value === 'others' || this.involvedPersonForm[index].imminentrisks.indexOf('OTH') > -1)) {
    this.involvedPersonForm[index].comment = '';
  }
  this.setIsVersionEbpNotCompleted();
}

getVisitationPlansFormGroupData(name: string): any[] {
  return Object.values((this.visitationPlansFormGroup.get(name) as FormGroup).controls);
}

getCandidacyFormGroup2Data(name: string): any[] {
  const groups: any = Object.values((this.candidacyFormGroup2.get(name) as FormGroup).controls);
  return this.getCandidacyFormGroupDataLoopFn(groups, name, 'ctrl2');
}

getCandidacyFormGroup1Data(name: string): any[] {
  const groups: any = Object.values((this.candidacyFormGroup1.get(name) as FormGroup).controls);

  return this.getCandidacyFormGroupDataLoopFn(groups, name, 'ctrl1');
}

getCandidacyFormGroupData(name: string): any[] {
  // return Object.values((this.candidacyFormGroup.get(name) as FormGroup).controls);
  const groups: any = Object.values((this.candidacyFormGroup.get(name) as FormGroup).controls);

  return this.getCandidacyFormGroupDataLoopFn(groups, name, 'ctrl');

// getCandidacyFormGroupData(name: string, controlName: any, ctrlName: any): any[] {
//   const groups: any[] = Object.values((controlName.get(name) as FormGroup).controls);

//   return this.getCandidacyFormGroupDataLoopFn(groups, name, ctrlName);
}
// Assosiated to getCandidacyFormGroupData method
  private getCandidacyFormGroupDataLoopFn(groups: any[], name: string, ctrlName: any) {
    groups.forEach(group => {
      this.applyCandidacyRules(group, name, ctrlName);
    });
    return groups;
  }

  // Assosiated to getCandidacyFormGroupDataLoopFn method
  applyCandidacyRules(group: any, name: any, mode?: 'ctrl' | 'ctrl1' | 'ctrl2'): void {
    const candidacy = group.get('candidacy');
    const candidacyDate = group.get('candidacydate');

    if (!candidacy || !candidacyDate) return;

    candidacyDate.disable({ emitEvent: false });

    if (name === 'candidates') {
      candidacy.disable({ emitEvent: false });
      return;
    }
    switch (mode) {
      case 'ctrl':
        if (
          this.candidacyFormGroupIsChildCompSaved ||
          group.get('disablefield')?.value
        ) {
          candidacy.disable({ emitEvent: false });
        }
        break;

      case 'ctrl1':
        if (group.get('disabledate')?.value) {
          candidacy.disable({ emitEvent: false });
        }
        break;

      case 'ctrl2':
        candidacy.disable({ emitEvent: false });
        break;
    }
  }

  getCandidacyDate(item: any): string | null {
    const candidates = item?.snapshotdata?.candidatesObj?.candidates;
    const candidatesTraditional = item?.snapshotdata?.candidatesObj?.candidatestraditional;
  
    if (candidates && candidates.length > 0) {
      return candidates[0]?.candidacydate;
    }
  
    if (candidatesTraditional && candidatesTraditional.length > 0) {
      return candidatesTraditional[0]?.candidacydate;
    }
  
    return null;
  }
  
}
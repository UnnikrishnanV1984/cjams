import { Component, OnInit, OnDestroy, Injector, ViewChild, Input } from '@angular/core';
import { ChildRemovalService } from '../child-removal.service';
import { Subscription, firstValueFrom } from 'rxjs';
import { SpeechRecognitionService } from '../../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, AuthService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { IntakeUtils } from '../../../../_utils/intake-utils.service';
import { ChildRemovalMapperService } from '../child-removal-mapper.service';
import { AppConstants } from '../../../../../@core/common/constants';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { HttpService } from '../../../../../@core/services/http.service';
import moment from 'moment';
import _ from 'lodash';
import { Router, ActivatedRoute } from '@angular/router';
import { PersonDisabilityService } from '../../../../shared-pages/person-disability/person-disability.service';
import { GetintakAssessment, RoutingInfo } from '../../../_entities/caseworker.data.model';
import { PaginationRequest, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { AppConfig } from '../../../../../app.config';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { ChildRoles, SharedChildData } from '../../child-removal/_entities/childremoval.model';
import { PersonInfoService } from '../../../../shared-pages/person-info/person-info.service';
import { PAGES_STORE_CONSTANTS } from '../../../../pages.constants';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { GlobalPopupComponent } from '../../../../../shared/shared-components/global-popup/global-popup.component';
import { PlacementConstants } from '../../service-case-placements/constants';


const DEFAULT_FOSTER_CARE = 'FC';
const DEFAULT_REMOVAL_TYPE = 'JD'; // Judicial Determination
const CHILD_DISABILITY_VOLUNTARY_PLACEMENT = 'CDVP';
const TIME_LIMITED_VOLUNTARY = 'TLV';
const INDEPENDENT_LIVING_ENH_AFTERCARE = 'EHA';

const NO_EFFORTS_MADE = 'NREM';

const NEW_SERVICE_CASE = 1;
const OLD_SERVICE_CASE = 0;

type ChildRelationshipSyncState = 'PENDING' | 'SYNCING' | 'SYNCED' | 'FAILED' | 'SKIPPED';

interface ChildRelationshipSyncRow {
  actorRelationshipId: number;
  relationshipTypeKey: string;
  cjamsRole: string;
  bintiRole: string;
  relativePersonId: number;
  relativeCjamspid: string;
  firstname: string;
  middlename?: string;
  lastname: string;
  dob: string;
  gender?: string;
  selected: boolean;
  canBeSynced: boolean;
  selectionDisabledReason?: string;
  syncState: ChildRelationshipSyncState;
  syncMessage?: string;
}

interface ChildConfirmationAccordionItem {
  firstname: string;
  lastname: string;
  dob: string;
  gender: string;
  clientId: string;
  county: string;
  hasBintiSearch: boolean;
  expanded: boolean;
  relationshipsLoading: boolean;
  relationshipsError: string | null;
  relationshipRows: ChildRelationshipSyncRow[];
}

declare const $ : any;
@Component({
    selector: 'child-removal-form',
    host: {
        class: 'child-removal-form'
    },
    templateUrl: './child-removal-form.component.html',
    styleUrls: ['./child-removal-form.component.scss'],
    standalone: false
})
export class ChildRemovalFormComponent implements OnInit, OnDestroy {
  // Popup for child info confirmation before approval
  showChildInfoConfirmModal: boolean = false;
  isFamilyFindingsRelationshipsComplete = false;
  childInfoForConfirmation: any[] = [];
  childInfoForConfirmationList: any[] = [];
  childConfirmationAccordion: ChildConfirmationAccordionItem[] = [];
  @ViewChild('doesNotApplyPopup') private confirmPopup!: GlobalPopupComponent;
  @ViewChild('childAgeOverModal') private childAgeOverModal!: GlobalPopupComponent;
  private _token:AppUser;
  removedChildren:any[] = [];
  removalSubscription!: Subscription;
  disablitySubscription!: Subscription;
  speechRecogninitionOn: boolean;
  speechData: string;
  personAddress = {};
  minDate = new Date();
  selectedPersonid: any;
  currentLanguage!: string;
  notification!: string | null;
  recognizing = '';
  childbehaviorproblem: any;
  removalReason:any[] = []; sendTo:any[] = []; familyStructure:any[] = []; childRemovalType:any[] = [];
  exitCaseReasons:any[] = []; reasonableEfforts:any[] = []; reasonableEffortsNotMade:any[] = [];
  disabilityTypes:any[] = []; disabilityConditions:any[] = []; removalEndReasons:any[] = []; allRemovalEndAReasons:any[] = []; 
  transferagencies:any[] = []; alltransferagencies:any[] = []; locationofadoptions:any[] = []; environmentAtRemovalList: any[] =[]; 

  careGiverPersons:any[] = [];
  maxDate = new Date();
  yesterday = new Date();
  isVoluntaryAgreementType = false;
  childRemovalFormGroup!: FormGroup;

  isCaseWorker = false;
  isSupervisor = false;

  serviceCaseNumber!: string | null;
  approvalQueueIndex = 0;
  approvalQueueLength = 0;
  familystructuretypekeyref: any =  null;
  environmentAtRemovalkeyref: any =  null;
  agencytypekeyref: any = null;
  removaltypekeyref: any = null;
  primarycaregiveractoridref: any = null;
  seccaregiveractoridref: any = null;
  parent1idref: any = null;
  parent2idref: any = null;
  disablesheltercheckbox: boolean= false;
  removalreasonref: any = null;
  removalexitreasonref: any = null;
  reasonableeffortsref: any = null;
  notmakingeffortsref: any = null;
  rmvdfrmisractoridref: any;
  intakeservicerequestactoridref: any;
  personidref: any;

  approveRejectQueueIndex = 0;
  approveRejectQueueLength = 0;

  message!: string;

  sendApprovalDisabled = false;
  saveAsDraftDisabled = false;
  showparent1signature = true;
  showparent2signature = true;
  showparent2signmisreason = false;
  showYouthSignedDate!: boolean;
  showbeginDate!: boolean;
  showParentsSignature!: boolean;
  showEndDate!: boolean;
  showNotes!: boolean;
  validList:any[] = [];
  isValidChildRemoval!: boolean;
  isApproved!: boolean;

  disabilityChild: any;
  personDisability: any;

  showNotMakingReasonableEfforts = false;
  notAddedDisabilityPersons:any[] = [];

  serviceCaseFormGroup!: FormGroup;
  exitingServiceCaseList: any;
  exitingServiceCaseId: any;
  newservicecasenumber: any;
  auditlogTrail: any;
  auditlogTrailExpand: any;
  auditUpdatedOn: any;
  auditUpdatedEmail: any;
  auditUpdatedBy: any;
  isValue: number = 1;

  CHILD_REMOVAL_SUBMIT = 0;

  id: string;
  displayValidationMessages!: boolean;
  circumstancestext!: boolean;
  disabilitytext!: boolean;
  daNumber: string;
  startAssessment$: any;
  getAsseesmentHistory: GetintakAssessment[] = [];
  showAssesment = -1;
  involvedPersons: any;
  routingInfo!: RoutingInfo[];
  isServiceCase!: string;
  inputRequest!: Object;
  assessmentTemplateId: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  childDetail: ChildRoles[] = [];
  shelterChkBox = 0;  //this.shelterChkBox values: 0-No,1-Yes,2-N/A
  ischildhomeaddress!: boolean;
  isuploadedmanually!: number | null;
  personDisabilities:any[] = [];
  hasDisability!: boolean;
  disabilityConditionsType = [{
    'value_text': 'Yes',
    'description': 'Yes'
  },
  {
    'value_text': 'No',
    'description': 'No'
  },
  {
    'value_text': 'Unknown',
    'description': 'Unknown'
  }];
  disabilityTypesCheck:any[] = [];
  enableEndRemoval = false;
  viewOnly = false;

  removalMinDate: any = null;
  isClosed = false;
  formDisabled!: boolean;
  vendorlist:any[] = [];
  agencylist:any[] = [];
  endatecheck: any = {};
  activeremovalservicecase: any;
  showapprove!: boolean;
  isJustificationEnabled: boolean = false;
  maxTimeValidation:any;
  isExitChildRemoval: boolean = false;

  personRemovalHistory:any[] = [];
  sampleFormShow: boolean = false;
  isCW: any;
  assesType: any;
  isChildAgeOverModal: boolean = false;

  dtformat = 'YYYY-MM-DD';
  readonly MANDATORY_CIRCUMSTANCES_MSG = 'Please complete all mandatory fields under Circumstances at Removal.';
  readonly doesNotApplyMsg =
    'At least one of the Circumstances at Removal must be marked as “Applies.” ' +
    'Please review this list and update one or more entries to “Applies,” then send ' +
    'the removal for supervisor approval.';
  mandatorymsg = 'Please fill required fields';
  dtformat1 = 'MM/DD/YYYY';
  removalpopupid = '#removal-verification';
  servicecasevalidationpopupid = '#ServiceCaseValidation';
  removalackmtid = '#removal-ackmt';
  approvalsuccesspopupid = '#show-approval-success';
  newservicecasepopupid = '#show-new-service-case-number';
  loggermsg = 'Child serviceCaseNumber';
  loggermsg1 = 'service case create';

  childremovalluggage!: boolean;
  luggageprovided!:boolean | null;
  placementdisposableortrashbag!: boolean | null;
  luggagecomments: any ='';

  twelvehour: boolean = true;
  timeInterval: number = 5;

  countyList: any[] = [];
  bintiCountyName: string = '';
  currentChildHasBintiSearch = false;

  currentWorker: any = null;

  private _childRemovalService: ChildRemovalService;
  private _mapperService: ChildRemovalMapperService;
  private _formBuilder: FormBuilder;
  private speechRecognizer: SpeechRecognizerService;
  private _speechRecognitionService: SpeechRecognitionService;
  private _alertService: AlertService;
  private _intakeUtils: IntakeUtils;
  public _authService: AuthService;
  private _router: Router;
  private route: ActivatedRoute;
  private _disabilityService: PersonDisabilityService;
  private _dataStoreService: DataStoreService;
  private _commonService: CommonHttpService;
  private _http: HttpService;
  private _servicePerson: PersonDisabilityService;
  private storage: SessionStorageService;
  private _personInfoService: PersonInfoService;
  luggageupdated!: boolean;
  luggageupdatedby: any;
  luggageupdatedon: any;
  @Input() sharedChildData: SharedChildData = { isNulEndDatPhonNumb: false, isNulEndDatEmail: false, age: 0, dod: "", emailIds: [], phoneNumbers: [] };
  showcontactpage: boolean = false;
  childAgeOverModalMsg: string = "";
  isEditChildRemoval: boolean = false;
  constructor(private injector : Injector){
  this._childRemovalService = this.injector.get<ChildRemovalService>(ChildRemovalService);
  this._mapperService = this.injector.get<ChildRemovalMapperService>(ChildRemovalMapperService);
  this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
  this.speechRecognizer = this.injector.get<SpeechRecognizerService>(SpeechRecognizerService);
  this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
  this._alertService = this.injector.get<AlertService>(AlertService);
  this._intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
  this._authService = this.injector.get<AuthService>(AuthService);
  this._router = this.injector.get<Router>(Router);
  this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
  this._disabilityService = this.injector.get<PersonDisabilityService>(PersonDisabilityService);
  this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
  this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
  this._http = this.injector.get<HttpService>(HttpService);
  this._servicePerson = this.injector.get<PersonDisabilityService>(PersonDisabilityService);
  this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
  this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    // Fetch county list and set binti county name for current user
    const user = this._authService.getCurrentUser();
    const actualuser = user.user;
    this.currentWorker = actualuser;
    const primaryCountyCode = actualuser?.userprofile?.primarycountycd || '';
    this.getCountyListAndSetBintiName(primaryCountyCode);


  this._token = this._authService.getCurrentUser();
  this.speechRecogninitionOn = false;
  this.speechData = '';
  this.yesterday = new Date(this.minDate);
  this.yesterday.setDate(this.minDate.getDate() - 1);

  this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
  this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);

  this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
  this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
}


  ngOnInit() {
    this.initFormGroup();
    this.childRemovalFormGroup.get("removalreason")?.disable()
    this.setDefaultValues();
    this.currentLanguage = 'en-US';
    this.notification = null;
    this.speechRecognizer.initialize(this.currentLanguage);
    this.processRemovalType();
    this.listenForChildRemoval();
    this.listenForChildRemovalInfo();
    this.listenForPersonDisability();
   if (this.isSupervisor) {
      this._childRemovalService.getChildList();
      this.loadRemovalChildrenInfo(this._childRemovalService.getReviewChildrenForSupervisor());
    }
    this._childRemovalService.removalConfig$.subscribe((data: any) => {
      this.loadDropDownList();
      if (!this.isSupervisor) {
        this.isuploadedmanually = null;
      }
    });

    this.inputRequest = {
      servicerequestid: this.id,
    };
    this.getPage(1);
    this.getAssessmentPrefillData();
    this.loadPersonDisabilityList();
    this.childDetails();
    this.childRemovalFormGroup.get('primarycaregiveradd')?.valueChanges.subscribe((result: any) => {
      if (!result) {
        this.childRemovalFormGroup.patchValue({
          isverifiedcaregiver1add: null
        });
      }
    });
    this.childRemovalFormGroup.get('seccaregiveradd')?.valueChanges.subscribe((result: any) => {
      if (!result) {
        this.childRemovalFormGroup.patchValue({
          isverifiedcaregiver2add: null
        });
      }
    });
    this.childRemovalFormGroup.get('childphysicalremovaladdress')?.valueChanges.subscribe((result: any) => {
      if (!result) {
        this.childRemovalFormGroup.patchValue({
          ischildphysicalremovaladdressverified: null
        });
      }
    });
    const da_status = this.storage.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
  }


  getCountyListAndSetBintiName(primaryCountyCode?: string) {
    if (!this.countyList || this.countyList.length === 0) {
      this._commonService.create({
        where: {
          activeflag: '1',
          state: 'MD'
        },
        order: 'countyname asc',
        nolimit: true
      }, CaseWorkerUrlConfig.countyListurl).subscribe((item: any[]) => {
        if (item && item.length) {
          this.countyList = item;
          if (primaryCountyCode) {
            const match = this.countyList.find(
              (county: any) => county.statecountycode === primaryCountyCode
            );
            if (match) {
              this.bintiCountyName = match.binticountyname;
            }
          }
        }
      });
    }
  }

  childDetails() {
    this._servicePerson.getDisabilityTypes().subscribe((response: any) => {
      if (response && Array.isArray(response)) {
        this.disabilityTypesCheck = response;
        this.setDisabiltyFields();
      }
    });
  }

  loadPersonDisabilityList() {
    this._servicePerson.getDisabilityList(this._personInfoService.getPersonId()).subscribe((response: any) => {
      if (response && Array.isArray(response) && response.length) {
        this.personDisabilities = response;
        this.setDisabiltyFields();
        if (this.personDisabilities.length > 0) {
          this.hasDisability = true;
        }
      } else {
        this.personDisabilities = [];
        this.hasDisability = false;
        this.setDisabiltyFields();
      }
    });
  }

  closelocationofadoption() {
    $('#open-location-of-adoption').modal('hide');
  }

  openlocationofadoption() {
    $('#open-location-of-adoption').modal('show');
  }

  setDisabiltyFields() {
    if (this.disabilityTypesCheck && this.disabilityTypesCheck.length) {
      this.setpersonDisabilities();
    }
  }

  setpersonDisabilities() {
    const personDisabilities = this.personDisabilities;
    this.disabilityTypesCheck.forEach(element => {
      element.conditionType = null;
      if (personDisabilities && personDisabilities.length) {
        const isDisabilityAvailable = personDisabilities.find(child => child.disabilitytypekey === element.ref_key);
        if (isDisabilityAvailable) {
          if (isDisabilityAvailable.comments === 'No_Disability' || isDisabilityAvailable.comments === 'Unknown_Disability') {
            element.conditionType = this.getDisabilityConditionType(isDisabilityAvailable.comments);
          } else {
            element.conditionType = isDisabilityAvailable.disabilityconditiontypekey;
          }
          element.disabled = true;
        } else {
          element.disabled = false;
        }
      } else {
        element.conditionType = null;
        element.disabled = false;
      }
    });
  }

  getDisabilityConditionType(comments: string){
    return (comments === 'No_Disability') ? 'No' : 'Unknown';
  }

  getPage(page: number) {

    this._http.overrideUrl = false;
    this._http.baseUrl = AppConfig.baseUrl;
    this._childRemovalService.getAssessments().subscribe((result: any) => {
      this.startAssessment$ = result.data;
    });
  }

  private getAssessmentPrefillData() {
    this._childRemovalService.getAssessmentsInvolvedPersons().subscribe((result: any) => {
      if (result && result['data']) {
        this.involvedPersons = result['data'];
      }
    });
    this._childRemovalService.getAssessmentsRoutingInfo().subscribe((result: any) => {
      if (result && result['data']) {
        this.routingInfo = result['data'];
      }
    });
  
  }

  startAssessment(assessment: GetintakAssessment, mode: any) {
    assessment.mode = mode;
    const storeData = this._dataStoreService.getCurrentStore();

    storeData['CASEWORKER_INVOLVED_PERSON'] = this.involvedPersons;
    storeData['CASEWORKER_ROUTING_INFO'] = this.routingInfo;
    storeData['CASEWORKER_SELECTED_ASSESSMENT'] = assessment;
    storeData['CASEWORKER_CHILD_DETAIL'] = this.childDetail;
    this._dataStoreService.setObject(storeData, true, 'CASEWORKER_ASSESSMENT_LOAD');
    if (this.removedChildren && this.removedChildren.length && this.removedChildren[0] && this.removedChildren[0].intakeservicerequestactorid){
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.SHELTER_ASSESSMENT_ISRACTORID, this.removedChildren[0].intakeservicerequestactorid)
    }
    this._router.navigate(['../view'], { relativeTo: this.route });
  }
  initFormGroup() {
    this.childRemovalFormGroup = this._formBuilder.group({
      intakeservreqchildremovalid: [null],
      familystructuretypekey: [null],
      environmentatremovalkey: [null],
      agencytypekey: [null, Validators.required],
      isdisability: [null],
      removaltypekey: [null, Validators.required],
      removaldate: [null, Validators.required],
      exitdate: [null],
      exittime: [null],
      removaltime: [null, Validators.required],
      rmvdfrmpersonname: [null],
      primarycaregiveractorid: [null],
      seccaregiveractorid: [null],
      removaladd1: [null],
      vpabegindate: [null],
      vpaenddate: [null],
      vpaparentssigneddate: [null],
      parent2signeddate: [null],
      vpaguardiansigneddate: [null],
      parent1id: [null],
      parent2id: [null],
      guardianid: [null],
      vpa2parentssigneddate: [null],
      parent2sigmissreason: [null],
      primarycaregiveradd: [null],
      ischildaddressasprimaryaddress: [null, Validators.required],
      childhomeaddress: [null],
      childphysicalremovaladdress: [null],
      ischildphysicalremovaladdressverified: [{value: null, disabled: true}],
      seccaregiveradd: [null],
      isverifiedcaregiver1add: [{value: false, disabled: true}],
      isverifiedcaregiver2add: [{value: false, disabled: true}],
      vpayouthsigneddate: [null],
      isbothparentssigned: [null],
      volrelinquishment: [null],
      agencysigneddate: [null],
      removalreason: [null],
      removalexitreason: [null],
      transferagency: [null],
      otherpublicagency: [null],
      locationofadoption:[null],
      caregiverreason: [null],
      reasonableefforts: [null],
      notmakingefforts: [null],
      specifiedrelativename: [null],
      returndate: [null],
      returntime: [null],
      specifiedrelativedatechildlastlivedwith: [null],
      exitreason: [null],
      parent2comments: [''],
      comments: ['', Validators.required],
      reasonableeffortsmade: [null],
      isverifiedreporteradd: [{value: null, disabled: true}],
      placement: [''],
      familyhistory: [''],
      childdesc: [null],
      justification: [null],
      removalcircumstances: this._formBuilder.group({
        abandonment: [null],
        caretakeralcoholuse: [null],
        caretakerdruguse: [null],
        caretakersignificantimpairment: [null],
        caretakerignificantimpphysical: [null],
        childalcoholuse: [null],
        childbehaviorproblem: [null],
        childdruguse: [null],
        childrequestedplacement: [null],
        deathofcaretaker: [null],
        diagnosedcondition: [null],
        domesticviolence: [null],
        failuretoreturn: [null],
        familyconflict: [null],
        homelessness: [null],
        inadequateaccesstomhs: [null],
        inadequateaccesstomedicalservices: [null],
        inadequatehousing: [null],
        incarcerationofcaretaker: [null],
        medicalneglect: [null],
        neglect: [null],
        parentalimmigration: [null],
        physicalabuse: [null],
        prenatalalcoholexposure: [null],
        prenataldrugexposure: [null],
        psychologicalemotionalabuse: [null],
        publicagencytitleive: [null],
        runaway: [null],
        sexualabuse: [null],
        sextrafficking: [null],
        tribaltitleive: [null],
        voluntaryrelinquishment: [null],
        whereaboutsunknown: [null],
      })
    });



    this.serviceCaseFormGroup = this._formBuilder.group({
      intakeserviceid: [''],
      servicecaseid: [null],
      isnewcase: ['']
    });
  }

  setDefaultValues() {
    if(!this.childRemovalFormGroup.controls.removaltypekey){
    this.childRemovalFormGroup.patchValue({ 'removaltypekey': DEFAULT_REMOVAL_TYPE });
    }
    const agencyTypeControl = this.childRemovalFormGroup.get('agencytypekey');

    if (!agencyTypeControl?.value) {
      agencyTypeControl?.patchValue(DEFAULT_FOSTER_CARE);
    }    
    
    const removalCircumstancesControl = this.childRemovalFormGroup.get('removalcircumstances');
    const currentValues = removalCircumstancesControl?.value || {};
  
    removalCircumstancesControl?.patchValue(
      Object.keys(currentValues).reduce((acc: any, key: any) => {
        if (currentValues[key] === null) {
          acc[key] = false;
        }
        return acc;
      }, {})
    );
  }

  listenForChildRemoval() {
    this.removalSubscription = this._childRemovalService.childRemoval$.subscribe((child: any) => {
      this.removedChildren = this._childRemovalService.getRemovedChildren();
      this.personRemovalHistory = child.removalHistory;
      if (this.removedChildren.length) {
        this.sendApprovalDisabled = false;
      }
      if (this.removedChildren.length === 1) {
        this.childRemovalFormGroup.reset();
        this.setDefaultValues();
        this.processRemovalType();
      }
      this.loadDropDownList();
    });

  }

  listenForChildRemovalInfo() {
    this.removalSubscription = this._childRemovalService.childRemovalInfo$.subscribe((children: any) => {
      this.loadRemovalChildrenInfo(children);
      if (children && children.length) {
        this.removalMinDate = new Date(children[0].dob);
      }
    });

  }

  listenForPersonDisability() {
    this.removalSubscription = this._dataStoreService.currentStore.subscribe((store: any) => {
      if (store.SUBSCRIPTION_TARGET === 'DISABILITY') {
        this._childRemovalService.loadPersonDisabilities();
      }
    });
    this.disablitySubscription = this._childRemovalService.removalDisabilityConfig$.subscribe((disablityInfo: any) => {
      if (disablityInfo) {
        this.removedChildren.forEach(person => {
          if (person.personid === disablityInfo.personid) {
            person.hasDisability = disablityInfo.hasDisability;
          }
        });
      }
    });
  }
  loadRemovalChildrenInfo(children: any) {
    this.childRemovalFormGroup.reset();
    this.removedChildren = children;
    this.currentChildHasBintiSearch = false;
    this.childAuditInfo(children);
    this.loadDropDownList();
    if (Array.isArray(children) && children.length > 0) {
      const unMappedData = this._mapperService.unMapChildRemovalInfo(children[0].removalInfo);
      unMappedData.removaltime = moment(unMappedData.removaltime);
       unMappedData.exittime = moment(unMappedData.exitdate);
      this.isExitChildRemoval = (children[0].editType && children[0].editType === 'Exit') ? true : false;
      this.isEditChildRemoval = (children[0]?.editType && children[0]?.editType === 'Edit') ? true : false;
      this.isApproved = (unMappedData && unMappedData.approvalstatus === 'Approved') ? true : false;
      this.showapprove = (unMappedData &&unMappedData.approvalstatus === 'Review') ? true : false;
      this.currentChildHasBintiSearch = this.getHasBintiSearchFlag(children[0]);
      this.handleJustificationFn(children, unMappedData);
      this.personRemovalHistory = children[0].removalHistory;
      this.setDefaultValues(); // CDM-44564 moved setdefaultvalues() before setchildremovalform() to avoid defaulting. 
      this.setChildRemovalForm(unMappedData);
      this.setremovalEndReasons();
      this.processRemovalType();
      this.processActionButtons(children);
    }
    this.childRemovalFormGroup.get("removalreason")?.disable()

  }

  private getHasBintiSearchFlag(child: any): boolean {
    const flag = child?.removalInfo?.hasbintisearch ?? child?.hasbintisearch;
    return flag === true || flag === 1 || flag === '1';
  }

  private normalizeRelationshipKeyForSync(value: any): string {
    return (value || '')
      .toString()
      .trim()
      .replace(/[-_\s/()]+/g, '')
      .toUpperCase();
  }

  private hasValidRelationshipMapping(row: any): boolean {
    if (typeof row?.ismapped === 'boolean') {
      return row.ismapped;
    }

    if (row?.ismapped === 1 || row?.ismapped === '1') {
      return true;
    }

    const bintiRole = (row?.bintirolelabel || row?.binti_role_label || '').toString().trim().toUpperCase();
    return !!bintiRole && bintiRole !== '--' && bintiRole !== 'UNKNOWN';
  }

  private mapRelationshipSyncRow(row: any, seedFromPersistedSelection = false): ChildRelationshipSyncRow {
    const status = (row?.syncstatus || 'NOT_SYNCED').toString().trim().toUpperCase();
    const isMapped = this.hasValidRelationshipMapping(row);
    const canBeSynced = status !== 'SYNCED' && isMapped;
    const selected = seedFromPersistedSelection
      ? canBeSynced && (status === 'AWAIT_SYNC' || status === 'FAILED')
      : canBeSynced;
    let selectionDisabledReason = '';

    if (!canBeSynced) {
      if (status === 'SYNCED') {
        selectionDisabledReason = 'Already synced.';
      } else if (!isMapped) {
        selectionDisabledReason = 'No mapping found in reference values.';
      } else {
        selectionDisabledReason = 'Not eligible for sync.';
      }
    }

    return {
      actorRelationshipId: row?.actorrelationshipid,
      relationshipTypeKey: row?.relationshiptypekey,
      cjamsRole: row?.relationshiptype,
      bintiRole: row?.bintirolelabel || row?.binti_role_label || '--',
      relativePersonId: row?.relativepersonid || row?.relative_personid,
      relativeCjamspid: row?.relativecjamspid || row?.relative_cjamspid,
      firstname: row?.firstname,
      middlename: row?.middlename,
      lastname: row?.lastname,
      dob: row?.dob,
      gender: row?.gender || row?.gendertypekey,
      selected,
      canBeSynced,
      selectionDisabledReason,
      syncState: status === 'SYNCED' ? 'SYNCED' : 'PENDING',
      syncMessage: '',
    };
  }

  private async loadRelationshipRowsForChild(cjamspid: string, seedFromPersistedSelection = false): Promise<ChildRelationshipSyncRow[]> {
    const servicecaseid = this.id || this.findServiceCaseId();
    const response: any = await firstValueFrom(
      this._commonService.create(
        {
          where: {
            cjamspid,
            servicecaseid,
            page: 1,
            limit: 500,
          },
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetFamilyFindingRelationships
      )
    );

    if (!response?.success) {
      throw new Error(response?.data?.message || 'Failed to load relationships.');
    }

    return (response?.data || []).map((row: any) => this.mapRelationshipSyncRow(row, seedFromPersistedSelection));
  }

  private buildBintiPayloadFromAccordion() {
    this.childInfoForConfirmation = this.childConfirmationAccordion.map((child) => ({
      firstname: child.firstname,
      lastname: child.lastname,
      dob: child.dob,
      gender: child.gender,
      clientId: child.clientId,
      county: child.county,
      selected_relationships: child.relationshipRows
        .filter((row) => row.selected && row.canBeSynced)
        .map((row) => ({
          actorrelationshipid: row.actorRelationshipId,
          relationshiptypekey: row.relationshipTypeKey,
          relationshiptype: row.cjamsRole,
          relativepersonid: row.relativePersonId,
          relative_personid: row.relativePersonId,
          relativecjamspid: row.relativeCjamspid,
          relative_cjamspid: row.relativeCjamspid,
          firstname: row.firstname,
          lastname: row.lastname,
          bintirolelabel: row.bintiRole,
          binti_role_label: row.bintiRole,
          selectionstatus: row.syncState,
        })),
    }));

    this.childInfoForConfirmationList = [...this.childInfoForConfirmation];
  }

  areAllChildRelationshipsSelected(child: ChildConfirmationAccordionItem): boolean {
    const selectableRows = child.relationshipRows.filter((row) => row.canBeSynced);
    if (selectableRows.length === 0) {
      return false;
    }
    return selectableRows.every((row) => row.selected);
  }

  toggleSelectAllChildRelationships(child: ChildConfirmationAccordionItem, event: Event): void {
    const selected = (event.target as HTMLInputElement)?.checked || false;
    child.relationshipRows.forEach((row) => {
      if (row.canBeSynced) {
        row.selected = selected;
      }
    });
  }

  toggleChildRelationshipSelection(row: ChildRelationshipSyncRow, event: Event): void {
    if (!row.canBeSynced) {
      return;
    }
    const selected = (event.target as HTMLInputElement)?.checked || false;
    row.selected = selected;
  }

  getChildRelationshipSyncStateLabel(state: ChildRelationshipSyncState): string {
    if (state === 'SYNCED') {
      return 'Synced';
    }
    if (state === 'FAILED' || state === 'SKIPPED') {
      return 'Not Synced';
    }
    return 'Pending';
  }

  getChildRelationshipSyncStateIcon(state: ChildRelationshipSyncState): string {
    if (state === 'SYNCED') {
      return 'check_circle';
    }
    if (state === 'FAILED') {
      return 'cancel';
    }
    if (state === 'SYNCING') {
      return 'autorenew';
    }
    if (state === 'SKIPPED') {
      return 'remove_circle';
    }
    return 'schedule';
  }

  getChildRelationshipSyncStateClass(state: ChildRelationshipSyncState): string {
    if (state === 'SYNCED') {
      return 'sync-state-synced';
    }
    if (state === 'FAILED' || state === 'SKIPPED') {
      return 'sync-state-not-synced';
    }
    if (state === 'SYNCING') {
      return 'sync-state-syncing';
    }
    return 'sync-state-pending';
  }

  toggleChildAccordion(child: ChildConfirmationAccordionItem): void {
    child.expanded = !child.expanded;
  }
  // Assosiated with loadRemovalChildrenInfo method
  private handleJustificationFn(children: any[], unMappedData: any) {
    const removalForm = this.childRemovalFormGroup.getRawValue();
    if (removalForm.justification !== null) {
      this.isJustificationEnabled = true;
    } else if (children[0].isViewOrNot !== undefined) {
      this.isJustificationEnabled = false;
    } else {
      this.isJustificationEnabled = (unMappedData && unMappedData.isJustificationEnabled) ? unMappedData.isJustificationEnabled : true;
    }

    this.shelterChkBox = unMappedData.isshelterauthcompleted;
    this.isuploadedmanually = unMappedData.isuploadedmanually ? unMappedData.isuploadedmanually : 0;
    if (unMappedData.removaladd1 && unMappedData.ischildaddressasprimaryaddress === 1) {
      unMappedData.isverifiedreporteradd = 1;
    }
    this.childremovalluggage =unMappedData.childremovalluggage;
    this.luggageprovided =unMappedData.luggageprovided;
    this.luggagecomments = unMappedData.luggagecomments;
    this.placementdisposableortrashbag = unMappedData.placementdisposableortrashbag;
    this.luggageupdatedby = unMappedData.luggageupdatedby;
    this.luggageupdatedon = unMappedData.luggageupdatedon;
    
  }

  childAuditInfo(children: any){
    if(children && children.length> 0){
      if (children[0].isViewOrNot == false) { //  NOSONAR
        this.isValue = 3; 
      } else {
        this.isValue = 1;
      }
      if (children[0].intakeservreqchildremovalid) {
          this.getAuditInformation(children[0].intakeservreqchildremovalid);
       } else { 
          this.getAuditInformation(children[0].intakeChildRemovalid);
       }
    }

    if (this.removedChildren && this.removedChildren.length > 0) {
      setTimeout( () => {
       const el: any = document.getElementById('new-child-removel');
       el.scrollIntoView();
       window.scrollBy(0, 94);
      }, 100);
    }
  }

  setChildRemovalForm(unMappedData: any){
    let justificationValue: string | null = null;
    if(unMappedData.revisionrecord !== undefined && unMappedData.revisionrecord !== null && unMappedData.revisionrecord.length > 0 && unMappedData.approvalstatus !== 'Approved') {
      unMappedData.revisionrecord[0].exittime = moment(unMappedData.revisionrecord[0].exitdate);
      if (unMappedData.revisionrecord[0].modifieddata?.justification) {
        justificationValue = unMappedData.revisionrecord[0].modifieddata.justification;
      } else if (unMappedData?.showcontactpage) {
        justificationValue = unMappedData?.justification ?? null;
      }
      unMappedData.revisionrecord[0].justification = justificationValue;
      unMappedData.revisionrecord[0].removaltime =  moment(unMappedData.revisionrecord[0].removaltime);
      if (unMappedData.revisionrecord[0].removaladd1 && unMappedData.revisionrecord[0].ischildaddressasprimaryaddress === 1) {
        unMappedData.revisionrecord[0].isverifiedreporteradd = 1;
      }
      this.childRemovalFormGroup.patchValue(unMappedData.revisionrecord[0]);   
      this.shelterChkBox = unMappedData.revisionrecord[0].isshelterauthcompleted;
      this.isuploadedmanually =unMappedData.revisionrecord[0].isuploadedmanually;
      this.luggageupdatedby =unMappedData.revisionrecord[0].luggageupdatedby;
    this.luggageupdatedon = unMappedData.revisionrecord[0].luggageupdatedon;
      this.handlePatchChildRemovalFormFn(unMappedData);
    } else {
      if (unMappedData.removaladd1 && unMappedData.ischildaddressasprimaryaddress === 1) {
        unMappedData.isverifiedreporteradd = 1;
      }
      this.childRemovalFormGroup.patchValue(unMappedData);
      this.patchExitDetails(unMappedData);
    }
  }
  private patchExitDetails(unMappedData: any) {
    if (unMappedData.revisionrecord) {
      const record = unMappedData.revisionrecord[0];
      record.exittime = record.exitdate;
      this.childRemovalFormGroup.patchValue({
        removalexitreason: record.removalexitreason,
        exitdate: record.exitdate,
        exittime: record.exittime
      });
    }
  }
  // Assosiated with setChildRemovalForm method
  private handlePatchChildRemovalFormFn(unMappedData: any) {
    this.childRemovalFormGroup.patchValue({
      comments: (unMappedData.revisionrecord && unMappedData.revisionrecord[0] && unMappedData.revisionrecord[0].comments) ? unMappedData.revisionrecord[0].comments : unMappedData.comments
    });
    this.childRemovalFormGroup.patchValue({
      removalreason: unMappedData.removalreason
    });
    this.childRemovalFormGroup.patchValue({
      removalcircumstances: (unMappedData.revisionrecord && unMappedData.revisionrecord[0] && unMappedData.revisionrecord[0].removalcircumstances) ? unMappedData.revisionrecord[0].removalcircumstances : unMappedData.removalcircumstances
    });
    this.childRemovalFormGroup.patchValue({
      reasonableefforts: unMappedData.reasonableefforts
    });
    this.childRemovalFormGroup.patchValue({
      notmakingefforts: unMappedData.notmakingefforts
    });
    this.childremovalluggage =unMappedData?.revisionrecord[0]?.childremovalluggage;
    this.luggagecomments =unMappedData.revisionrecord[0].luggagecomments;
    this.luggageprovided = unMappedData.revisionrecord[0].luggageprovided;
    this.placementdisposableortrashbag = unMappedData.revisionrecord[0].placementdisposableortrashbag;

  }

  setremovalEndReasons() {
    const rmInfo = this.childRemovalFormGroup.getRawValue();
    if (rmInfo.removalexitreason !== null && rmInfo.removalexitreason.trim() !== '') {
      const checkExist = this.removalEndReasons?.filter(item => item.ref_key === rmInfo.removalexitreason);
      if (checkExist.length <= 0) {
        this.removalEndReasons.push(this.allRemovalEndAReasons.find(item => item.ref_key === rmInfo.removalexitreason))
      }
    }
    if (this.removalEndReasons) {
      this.removalEndReasons.sort((a, b) =>
        a.description.localeCompare(b.description)
      );
    }
  }
 
  
  loadDropDownList() {
    this.removalReason = this._childRemovalService.removalReason;
    this.sendTo = this._childRemovalService.sendTo;
    this.familyStructure = this._childRemovalService.familyStructure;
    this.environmentAtRemovalList = this._childRemovalService.environmentAtRemovalList;
    this.childRemovalType = this._childRemovalService.childRemoval.filter(crt => crt.activeflag == 1);
    this.exitCaseReasons = this._childRemovalService.exitCaseReasons;
    this.reasonableEfforts = this._childRemovalService.reasonableEfforts;
    this.reasonableEffortsNotMade = this._childRemovalService.reasonableEffortsNotMade;
    this.disabilityTypes = this._childRemovalService.disabilityTypes;
    this.disabilityConditions = this._childRemovalService.disabilityConditions;
    
    this.setRemovalEndReasons();
    this.allRemovalEndAReasons = this._childRemovalService.removalEndReasons;

    this.transferagencies = this._childRemovalService.transferagencies.filter(item => item.activeflag === 1);
    this.transferagencies.sort((a, b) => a.description.localeCompare(b.description));
    this.alltransferagencies = this._childRemovalService.transferagencies;

    this.locationofadoptions = this._childRemovalService.locationofadoptions.filter(item => item.activeflag === 1);

    this.careGiverPersons = this._childRemovalService.getCareGiverList();
    if (this.careGiverPersons !== null && this.careGiverPersons !== undefined ) {
      this.careGiverPersonNameWithId();
    }
  }

  careGiverPersonNameWithId() {
    this.careGiverPersons.forEach(person => {
      let personNameWithId: string = '';
      if (person.prefx) {
        personNameWithId = person.prefx + ' ';
      }
      if (person.firstname) {
        personNameWithId = personNameWithId + person.firstname + ' ';
      }
      if (person.middlename) {
        personNameWithId = personNameWithId + person.middlename + ' ';
      }
      if (person.lastname) {
        personNameWithId = personNameWithId + person.lastname + ' ';
      }
      if (person.suffix) {
        personNameWithId = personNameWithId + person.suffix + ' ';
      }
      if (person.cjamspid) {
        personNameWithId = personNameWithId + '- ' + person.cjamspid;
      }
      person.personNameWithId = personNameWithId;
    });
  }
  

  setRemovalEndReasons() {
    this.removalEndReasons = this._childRemovalService.removalEndReasons.filter(item => item.activeflag === 1);
    if (this.removedChildren && this.removedChildren.length) {
      const ageofthechild = moment().diff(this.removedChildren[0].dob, 'years');
      if (ageofthechild < 18) {
        this.removalEndReasons = this.removalEndReasons.filter(item => item.ref_key !== 'RNAWAY');
      }
    }
  }
  

  filterCareGiver( { roles }: any) {
      return (_.find(roles, {intakeservicerequestpersontypekey: 'LG'}) || _.find(roles, {intakeservicerequestpersontypekey: 'PARENT'}) || _.find(roles, {intakeservicerequestpersontypekey: 'ADOPTIVEPARENT'}));
  }

  castToInt(str: any) {
    return _.parseInt(str, 10) || '';
  }

  activateSpeechToText(type: any): void {
    this.recognizing = type;
    this.speechRecogninitionOn = !this.speechRecogninitionOn;
    if (this.speechRecogninitionOn) {
      this._speechRecognitionService.record().subscribe(
        // listener
        (value: any) => {
          this.speechData = value;
          this.setChildRemovalFormSpeechData(type);
        },
        // errror
        (err: any) => {
          this.recognizing = '';
          if (err.error === 'no-speech') {
            this.notification = `No speech has been detected. Please try again.`;
            this._alertService.warn(this.notification);
            this.activateSpeechToText(type);
          } else if (err.error === 'not-allowed') {
            this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
            this._alertService.warn(this.notification);
          } else if (err.error === 'not-microphone') {
            this.notification = `Microphone is not available. Please verify the connection of your microphone and try again.`;
            this._alertService.warn(this.notification);
          }
        },
        // completion
        () => {
          this.speechRecogninitionOn = true;
          this.activateSpeechToText(type);
        }
      );
    } else {
      this.recognizing = '';
      this.deActivateSpeechRecognition();
    }
  }

  setChildRemovalFormSpeechData(type: any){
    switch (type) {
      case 'comments':
        let comments = this.childRemovalFormGroup.getRawValue().comments;
        if (comments) {
          comments = comments + ' ' + this.speechData;
        } else {
          comments = this.speechData;
        }
        this.childRemovalFormGroup.patchValue({ comments: comments });
        break;
      case 'parent_comments':
        let parent_comments = this.childRemovalFormGroup.getRawValue().parent2comments;
        if (parent_comments) {
          parent_comments = parent_comments + ' ' + this.speechData;
        } else {
          parent_comments = this.speechData;
        }
        this.childRemovalFormGroup.patchValue({ parent2comments: parent_comments + ' ' + this.speechData });
        break;
      case 'placement':
        const placement = this.childRemovalFormGroup.getRawValue().placement;
        this.childRemovalFormGroup.patchValue({ placement: placement + ' ' + this.speechData });
        break;
      case 'familyhistory':
        const familyhistory = this.childRemovalFormGroup.getRawValue().familyhistory;
        this.childRemovalFormGroup.patchValue({ familyhistory: familyhistory + ' ' + this.speechData });
        break;
      case 'childdesc':
        const childdesc = this.childRemovalFormGroup.getRawValue().childdesc;
        this.childRemovalFormGroup.patchValue({ childdesc: childdesc + ' ' + this.speechData });
        break;
      default: break;
    }
  }

  deActivateSpeechRecognition() {
    this.speechRecogninitionOn = false;
    this._speechRecognitionService.destroySpeechObject();
  }

  ngOnDestroy(): void {
    this._speechRecognitionService.destroySpeechObject();
    this.removalSubscription.unsubscribe();
    this.disablitySubscription.unsubscribe();
  }
  selectPerson(cjamsPid: any) {
    if (this.selectedPersonid !== cjamsPid) {
      this.selectedPersonid = cjamsPid;
    } else {
      this.selectedPersonid = null;
    }
   }
  processRemovalType(value?: any) {
    this.isJustificationEnabled = false;
    const removalForm = this.childRemovalFormGroup.getRawValue();
    this.shelterCheckbox(value);
    this.checkRemovalData();
    if ([CHILD_DISABILITY_VOLUNTARY_PLACEMENT, TIME_LIMITED_VOLUNTARY].includes(removalForm.removaltypekey)) {
      this.isVoluntaryAgreementType = true;
      this.showYouthSignedDate = false;
      this.showNotes = true;
      this.showEndDate = true;
      this.showParentsSignature = true;
      this.showbeginDate = true;
      this.setVoluntaryPlacementValidators();
    } else if (removalForm.removaltypekey === INDEPENDENT_LIVING_ENH_AFTERCARE) {
      this.isVoluntaryAgreementType = true;
      this.showYouthSignedDate = true;
      this.showNotes = false;
      this.showEndDate = false;
      this.showParentsSignature = false;
      this.showbeginDate = false;
      this.clearVoluntaryPlacementValidators();
    } else {
      this.isVoluntaryAgreementType = false;
      this.showYouthSignedDate = false;
      this.clearVoluntaryPlacementValidators();
    }
    this.parentsignedAggmntChange();
    this.reasonableEffortsChanged();
  }
  shelterCheckbox(value: any) {
    const removalForm = this.childRemovalFormGroup.getRawValue();
    if (removalForm.removaltypekey === 'CDVP' || removalForm.removaltypekey === 'EHA' || removalForm.removaltypekey === 'TLV') {
      if (this.removedChildren && this.removedChildren.length) {
        if (value) {
          this.shelterChkBox = 2;
          this.disablesheltercheckbox = true;
        }
        else if (this.shelterChkBox === 2) {
          this.disablesheltercheckbox = true;
        }
        else {
          this.disablesheltercheckbox = false;
        }
      }
    }
    else {
      this.disablesheltercheckbox = false;
      if (value) {
        this.shelterChkBox = 0;
      }
    }
  }
  checkRemovalData() {
    const removalForm = this.childRemovalFormGroup.getRawValue();
    if (this.removedChildren && this.removedChildren.length) {
      if (removalForm.justification !== null) {
        this.isJustificationEnabled = true;
      } else if (this.removedChildren[0].isViewOrNot !== undefined) {
        this.isJustificationEnabled = false;
      } else if (this.removedChildren[0].intakeservreqchildremovalid && !(this.isSupervisor && this.removedChildren[0].removalStatus === 'Review' && removalForm.justification == null)) {
        this.isJustificationEnabled = true;
      }

      if (this.removedChildren[0].removalHistory && this.removedChildren[0].removalHistory.length) {
        const removalData = this.removedChildren[0].removalHistory.filter((item: { intakeservreqchildremovalid: any; }) => item.intakeservreqchildremovalid === this.removedChildren[0].intakeservreqchildremovalid);
        if (removalData.length > 0 && removalData[0].revisionrecord === null && this.isSupervisor && removalForm.justification == null) {
          this.isJustificationEnabled = false;
        }
      }
      const dob = new Date(this.removedChildren[0].dob);
      dob.setUTCHours(0);
      dob.setHours(0, 0, 0, 0);
      this.removalMinDate = dob;
    }
  }

  getPersonAddress(personid: any, controlName: any) {
    if (personid) {
      this._childRemovalService.getAddressPerson(personid).subscribe(
        (response: any) => {
          if (response && response.length) {
            let fullAddress = '';
            const currentAddress = response.filter((address: { currentlocationflag: any; }) => address.currentlocationflag );
            if (currentAddress && currentAddress.length) {
              fullAddress = this.getFullAddress(currentAddress);
            }
        
            const obj: any = {};
            obj[controlName] = fullAddress;
            this.childRemovalFormGroup.patchValue(obj);
          }

        }
      );
    }
  }

  getFullAddress(currentAddress: any){
    return (currentAddress[0].address ? currentAddress[0].address : '') +
              (currentAddress[0].address2 ? ',' + currentAddress[0].address2 : '') +
              (currentAddress[0].city ? ', ' + currentAddress[0].city : '') +
              (currentAddress[0].state ? ', ' + currentAddress[0].state : '');
  }

  saveAsDraft() {
    this.activeremovalservicecase = this.removedChildren && this.removedChildren.length ? this.removedChildren[0].activeremovalservicecase : null;
    const removalTimeCheck = moment(this.childRemovalFormGroup.getRawValue().removaltime).format("HH:mm");
    const removalDateCheck = moment(this.childRemovalFormGroup.getRawValue().removaldate).format(this.dtformat);
    const validateRemovalDateTime = removalDateCheck + 'T' +removalTimeCheck + ':00';
    let overlapRemoval = false;
    if(this.personRemovalHistory) {
      const existingData = this.personRemovalHistory.filter(item => item.intakeservreqchildremovalid !== this.childRemovalFormGroup.getRawValue().intakeservreqchildremovalid);
      if(existingData.length > 0) {

        existingData.forEach(element => {
          element.exitdate = element.exitdate ? element.exitdate : new Date();
        });

        const validateFromDate = existingData.filter(item => new Date(item.removaltime) < new Date(validateRemovalDateTime) && new Date(item.exitdate) > new Date(validateRemovalDateTime))
        if(validateFromDate.length > 0) {
          overlapRemoval = true;
        } 
      }
    }
    if (overlapRemoval) {
      this._alertService.warn('The removal date should not overlap with the existing child removal dates. Please choose some other date');
      return;
    }
    
    this.submitRequest();
  }
  submitRequest(){
    if(this.activeremovalservicecase) {
      this._alertService.error('Child has an approved active removal in service case ' + this.activeremovalservicecase);
    } else {
      this._router.navigate(['..'], { relativeTo: this.route });
      this.approvalQueueIndex = 0;
      this.approvalQueueLength = this.removedChildren.length;
      this.CHILD_REMOVAL_SUBMIT = 0; // save as draft
      this.submitForApprovalQueue();
    }
  }

  approvalPathValidation(){
    if(this.maxTimeValidation !== null && moment(this.childRemovalFormGroup.getRawValue().removaltime).format("HH:MM") > this.maxTimeValidation) {
      this._alertService.error('Removal time should be less than or equal to Placement start time');
      return true;
    }

    if (this.isJustificationEnabled && !this.childRemovalFormGroup.getRawValue().justification) {
      this._alertService.error('Please fill justification');
      return true;
    }

    if ((this.enableEndRemoval || this.childRemovalFormGroup.getRawValue().exitdate !== null) && !this.childRemovalFormGroup.getRawValue().removalexitreason) {
      this._alertService.error('Please fill Removal End Reason');
      return true;
    }

    if (this.enableEndRemoval && !this.childRemovalFormGroup.getRawValue().exitdate) {
      this._alertService.error('Please fill Removal End Date');
      return true;
    }

    return false;
  }

  checkapprovalpath() {
    this.displayValidationMessages =true;
    this.childRemovalFormGroup.markAllAsTouched();
    if(this.approvalPathValidation()){
      return;
    }
    if (this.removedChildren[0].hasDisability === false) {
      this.disabilitytext = true;
    }
    if (this.enableEndRemoval && !this.childRemovalFormGroup.getRawValue().exittime) {
      this._alertService.error('Please fill Removal End Time');
      return;
    }
    
    if(this.isExitChildRemoval && this.checkluggage()){
      this._alertService.error('Please enter the mandatory fields for Luggage indicator questions');
      return;

    }
    
    const circumstanceStatus = this.isValidRemovalCircumstances();

    if (circumstanceStatus === 'NULL_VALUES') {
      this._alertService.error(this.MANDATORY_CIRCUMSTANCES_MSG);
      return;
    }

    if (circumstanceStatus === 'ALL_DOES_NOT_APPLY') {
      this.confirmPopup.openConfirmationModal();
      return;
    }

    // For supervisor, proceed as before
    if (this.getApprovalConfirm()) {
      if (this.checkFurther()) {
        return;
      }
      this.submitRemoval();
    }
  }

  // Prepare child info for confirmation popup
  async prepareChildInfoForConfirmation(seedFromPersistedSelection = false) {
    if (this.removedChildren && this.removedChildren.length > 0) {
      const mappedChildren = this.removedChildren.map((child: any, index: number) => ({
        firstname: child.firstname || '',
        lastname: child.lastname || '',
        dob: child.dob ? this.formatDate(child.dob) : '',
        gender: child.gender || '',
        clientId: child.cjamspid || '',
        county: this.bintiCountyName || '',
        hasBintiSearch: this.getHasBintiSearchFlag(child),
        expanded: index === 0,
        relationshipsLoading: true,
        relationshipsError: null,
        relationshipRows: [],
      }));

      this.childConfirmationAccordion = mappedChildren;

      await Promise.all(this.childConfirmationAccordion.map(async (child) => {
        try {
          child.relationshipRows = await this.loadRelationshipRowsForChild(child.clientId, seedFromPersistedSelection);
        } catch (err: any) {
          child.relationshipRows = [];
          child.relationshipsError = err?.message || 'Failed to load relationships.';
        } finally {
          child.relationshipsLoading = false;
        }
      }));

      this.buildBintiPayloadFromAccordion();
    } else {
      this.childInfoForConfirmation = [];
      this.childInfoForConfirmationList = [];
      this.childConfirmationAccordion = [];
    }
  }

  // Format date as MM/DD/YYYY
  formatDate(date: any): string {
    if (!date) return '';
    const d = new Date(date);
    const mm = (d.getMonth() + 1).toString().padStart(2, '0');
    const dd = d.getDate().toString().padStart(2, '0');
    const yyyy = d.getFullYear();
    return `${mm}/${dd}/${yyyy}`;
  }

  onConfirmChildInfoProceed() {
    this.buildBintiPayloadFromAccordion();
    this.isFamilyFindingsRelationshipsComplete = true;
    this.validList.forEach((child) => {
      child.familyFindingsRelationshipsComplete = true;
    });
    const removalInfo = this.childRemovalFormGroup.getRawValue();
    this.isValidChildRemoval = this.validList.every((item) =>
      item['validMDM'] && item['hasLG'] && (item['isadult'] || removalInfo.removaltypekey === 'EHA')
      && item['isvalidremovalDate'] && item['primCitizenReq'] && item['familyFindingsRelationshipsComplete']
    );
    $(this.removalpopupid).modal('show');
    this.showChildInfoConfirmModal = false;
  }

  // Handler for cancel button in popup
  onCancelChildInfoProceed() {
    this.showChildInfoConfirmModal = false;
    this.childConfirmationAccordion = [];
    this.isFamilyFindingsRelationshipsComplete = false;
  }

  getApprovalConfirm() {
    if (this.sharedChildData.dod !== "" || this.isRemovlExitDeathOfChild()) {
      /* If it is not EXIT type or date of death is there, popup wont show */
      this.isChildAgeOverModal = false;
      return true;
    }
    /* If child age more than 17 and email & phone number objects having EndDate */
    if (this.editMode() || this.exitMode()) {
      this.childAgeOverModalMsg = "Please review the Contact Info tab on this youth’s Person card and enter a current phone number and/or current email address for them. If the youth does not have a phone number or email address, enter the information in the youth’s Person Card in the Contact Info tab for a family member or friend who is in close contact with them. This information is needed for future NYTD surveys";
      this.isChildAgeOverModal = true;
      setTimeout(() => {
        this.childAgeOverModal.openConfirmationModal();
      });
      return false;
    }
    return true;
  }
  editMode() {
    let response = false;
    if (!this.isExitChildRemoval) {  /* Edit page */
      const reason = this.childRemovalFormGroup.controls.removalexitreason.value;
      const date = this.childRemovalFormGroup.controls.exitdate.value;
      const time = this.childRemovalFormGroup.controls.exittime.value;

      const hasValidExitDetails = (reason !== "" && reason !== null) && (date !== "" && date !== null) && (time !== "" && time !== null);
      const noFonOrEmail = this.noFonOrEmails();
      const ageCondition = this.ageGreatOrEqual17();
      const isNullDatFonOrEmail = this.isNulEnDatFonOrEmail();

      response = hasValidExitDetails && (noFonOrEmail || (ageCondition && isNullDatFonOrEmail));
    }

    return response;
  }
  exitMode() {
    let response = false;
    if (this.isExitChildRemoval) {  /* Exit page*/
      response = this.noFonOrEmails() || this.ageGreatOrEqual17() && this.isNulEnDatFonOrEmail();
    }
    return response;
  }
  ageGreatOrEqual17() {
    return this.sharedChildData.age >= 17;
  }
  isNulEnDatFonOrEmail(){
    return !this.sharedChildData.isNulEndDatPhonNumb && !this.sharedChildData.isNulEndDatEmail; /* Phone and Email list having end date = show popup */
  }
  noFonOrEmails() {
    return (!this.sharedChildData.emailIds || this.sharedChildData.emailIds.length === 0) && (!this.sharedChildData.phoneNumbers || this.sharedChildData.phoneNumbers.length === 0);
  }
  goToContctInfo(response: boolean) {
    if (response) {
      this.showcontactpage = true;
      this.saveAsDraft();
    } else {
      if(this.isChildAgeOverModal) {
        this.childAgeOverModal.closeConfirmationModal();
      }
    }
  }
  isRemovlExitDeathOfChild() {
    return this.childRemovalFormGroup.controls.removalexitreason.value ===  PlacementConstants.EXIT_TYPES.DEATH;
  }


  isValidRemovalCircumstances(): 'VALID' | 'NULL_VALUES' | 'ALL_DOES_NOT_APPLY' {
    const circumstances = this.childRemovalFormGroup.getRawValue().removalcircumstances;
    let hasAtLeastOneTrue = false;
  
    for (const key in circumstances) {
      const value = circumstances[key];
      if (value === null) return 'NULL_VALUES';
      if (value === true) hasAtLeastOneTrue = true;
    }
  
    if (!hasAtLeastOneTrue) {
      this.circumstancestext = true;
      return 'ALL_DOES_NOT_APPLY';
    }
  
    return 'VALID';
  }
  
  

  checkFurther(){
    if(this.isExitChildRemoval && this.checkluggage()){
      this._alertService.error('Please enter the mandatory fields for Luggage indicator questions');
      return true;
    }

    const removalCircumstancesFormGroup = this.childRemovalFormGroup.get("removalcircumstances")?.value;
    const removalCircumstancesFormGroupValues = Object.values(removalCircumstancesFormGroup)
    if(removalCircumstancesFormGroupValues.filter((item)=>item).length == 0 ){
      this._alertService.error('At least one applicable circumstance at removal must be selected to proceed further with the Child Removal Submission.');
      return true;
    }
    
    const removalTimeCheck = moment(this.childRemovalFormGroup.getRawValue().removaltime).format("HH:mm");
    const removalDateCheck = moment(this.childRemovalFormGroup.getRawValue().removaldate).format(this.dtformat);
    const validateRemovalDateTime = removalDateCheck + 'T' + removalTimeCheck + ':00';
    let overlapRemoval = false;
    overlapRemoval = this.handlePersonRemovalHistory(validateRemovalDateTime,overlapRemoval);
    if (overlapRemoval) {
      this._alertService.warn('The removal date should not overlap with the existing child removal dates. Please choose some other date');
      return true;
    }
    return false;
  }

  handlePersonRemovalHistory(validateRemovalDateTime: any,overlapRemoval: any){
    if (this.personRemovalHistory) {
      const existingData = this.personRemovalHistory.filter(item => item.intakeservreqchildremovalid !== this.childRemovalFormGroup.getRawValue().intakeservreqchildremovalid);
      if(existingData.length > 0) {

        existingData.forEach(element => {
          element.exitdate = element.exitdate ? element.exitdate : new Date();
        });

        const validateFromDate = existingData.filter(item => new Date(item.removaltime) < new Date(validateRemovalDateTime) && new Date(item.exitdate) > new Date(validateRemovalDateTime))
        if(validateFromDate.length > 0) {
          overlapRemoval = true;    // NOSONAR
        } 
      }
    }
    return overlapRemoval;

  }

  submitRemoval(){
    this.activeremovalservicecase = this.removedChildren && this.removedChildren.length ? this.removedChildren[0].activeremovalservicecase : null;
    if (this._authService.hasSupervisor()) {
      if(this.activeremovalservicecase){
        this._alertService.error('Child has an approved active removal in service case ' + this.activeremovalservicecase);
      } else {
        const enddate = this.childRemovalFormGroup.getRawValue().exitdate;
        if (enddate) {
          if(!this.childRemovalFormGroup.getRawValue().removalexitreason) {
            this._alertService.error(this.mandatorymsg);
            return;
          }
          this.checkEndDateValidation(0);
        } else {
          this.submitChildRemoval();
        }
      }
    }
  }

  submitChildRemoval() {
    const disabilityChangesMade = this._dataStoreService.getData(PAGES_STORE_CONSTANTS.PERSON_DISABILITY_PRINSTINE);  //  NOSONAR
  
    const removalInfo = this.childRemovalFormGroup.getRawValue();

    this.isVerifiedCareGiver();

    if (this.checkForErrors1(removalInfo)){
      return;
    }


    if (this.checkForErrors2()){
      return;
    }


    if (this.checkForErrors3(removalInfo)){
      return;
    }

    if (this.shelterChkBox === 0 && removalInfo.removaltypekey !== 'EHA') {
      $('#confirm-shelter-popup').modal('show');
      return;
    }
    this.validatechildRemoval();
  }
  isVerifiedCareGiver(){
    const disabilityChangesMade = this._dataStoreService.getData(PAGES_STORE_CONSTANTS.PERSON_DISABILITY_PRINSTINE);
    if (disabilityChangesMade) {
      $('#disability-check-popup').modal('show');
      return;
    }
    const removalInfo = this.childRemovalFormGroup.getRawValue();

    if(removalInfo.isverifiedcaregiver1add === 1) {
      this.childRemovalFormGroup.patchValue({
        isverifiedcaregiver1add : true
      })
    }

    if(removalInfo.isverifiedcaregiver2add === 1) {
      this.childRemovalFormGroup.patchValue({
        isverifiedcaregiver2add : true
      })
    }
  }
  checkForErrors1(removalInfo: any) {
    if (this.childRemovalFormGroup.invalid || (this.shelterChkBox === 1 && this.isuploadedmanually == null) || this.shelterChkBox === null) {
      this._alertService.error(this.mandatorymsg);
      return true;
    }

    if ((removalInfo.removaladd1 && !removalInfo.isverifiedreporteradd) ||
      (removalInfo.childphysicalremovaladdress && !removalInfo.ischildphysicalremovaladdressverified) ||
      (removalInfo.seccaregiveradd && !removalInfo.isverifiedcaregiver2add)) {
      this._alertService.error(this.mandatorymsg);
      return true;
    }

    return false;
  }
  checkForErrors2(){
    const removaldate = this.childRemovalFormGroup.getRawValue().removaldate;
    if ((removaldate && moment(new Date(removaldate)))) {
      const removalDate = new Date(removaldate);
      const toDate = new Date();
      if (moment(removalDate).isAfter(toDate)) {
        this._alertService.error('Child Removal date can not be a future date');
        return true;
      }
    }

    const disabilityNotChosen = this.removedChildren.filter(child => child.hasDisability === false);
    if (!disabilityNotChosen || disabilityNotChosen.length > 0) {
      $('#disablity-fillup').modal('show');
      return true;
    }
    return false;
  }

  checkForErrors3(removalInfo: any){
    if ([CHILD_DISABILITY_VOLUNTARY_PLACEMENT, TIME_LIMITED_VOLUNTARY].includes(removalInfo.removaltypekey)) {
      if (!removalInfo.vpaparentssigneddate && !removalInfo.vpaguardiansigneddate) {
        $('#error-info').modal('show');
        return true;
      }
    }

    const disabilityEnabledChildren = this.removedChildren.filter(child => child.hasDisability === 1);
    if (disabilityEnabledChildren && disabilityEnabledChildren.length > 0) {
      let notAddedDisabilityCount = 0;
      this.notAddedDisabilityPersons = [];
      disabilityEnabledChildren.forEach(child => {
        if (child.personDisabilities.length === 0) {
          notAddedDisabilityCount++;
          this.notAddedDisabilityPersons.push(child);
        }
      });
      if (notAddedDisabilityCount > 0) {
        this._alertService.error('Please add a disability');
        return true;
      }
    }

    return false;
  }

  getLegalCustody(childActorId: any) {
    const removalInfo = this.childRemovalFormGroup.getRawValue();
    this._commonService.getArrayList({
      method: 'get',
      where: {
        personid: childActorId
      }
    }, 'legalcustody/getlegalcustody?filter').subscribe( (res: any) => {
      let hascustody = false;
      if (res && res.length && res[0].getlegalcustody) {
        let legalCustodyDetails = res[0].getlegalcustody;
        legalCustodyDetails = legalCustodyDetails.filter((legalCustody: { todate: any; fromdate: any; }) => {
          if(legalCustody.todate == null && moment(legalCustody.fromdate).isSameOrBefore(moment(removalInfo.removaldate))){
            return true;
          }
        });
        hascustody = (Array.isArray(legalCustodyDetails) && legalCustodyDetails.length) ? true : false;
      }

      this.setValidChildRemovalFlag(hascustody, childActorId);
    
    });
  }
  setValidChildRemovalFlag(hascustody: any, childActorId: any){
    const removalInfo = this.childRemovalFormGroup.getRawValue();
    this.validList.forEach(item => {
      if(item.intakeservicerequestactorid == childActorId){
        item.hasLG = hascustody;
      }
    });
    this.isValidChildRemoval = this.validList.every(item =>
      item['validMDM'] && item['hasLG'] && (item['isadult'] || removalInfo.removaltypekey === 'EHA')
      && item['isvalidremovalDate'] && item['primCitizenReq'] && item['familyFindingsRelationshipsComplete']
    );
  }

  async triggerChildRemoval() {
    $(this.removalpopupid).modal('hide');
    const removalInfo = this.childRemovalFormGroup.getRawValue();
    this.isValidChildRemoval = this.validList.every((item) =>
      item['validMDM'] && item['hasLG'] && (item['isadult'] || removalInfo.removaltypekey === 'EHA')
      && item['isvalidremovalDate'] && item['primCitizenReq'] // && item['familyFindingsRelationshipsComplete']
    );
    if (this.isValidChildRemoval) {
      this.serviceCaseNumber = null;
      const childRemovalData = this.childRemovalFormGroup.getRawValue();
      childRemovalData.isshelterauthcompleted = (this.shelterChkBox != null) ? this.shelterChkBox : 0;
      childRemovalData.isuploadedmanually = (this.isuploadedmanually != null) ? this.isuploadedmanually : 0;
      this.approvalQueueIndex = 0;
      this.approvalQueueLength = this.removedChildren.length;
      this.CHILD_REMOVAL_SUBMIT = 1;
      if (this.isCaseWorker && !this.isExitChildRemoval && !this.isFamilyFindingsRelationshipsComplete) {
        await this.prepareChildInfoForConfirmation();
        childRemovalData.bintiInfo = this.childInfoForConfirmation;
        this.showChildInfoConfirmModal = true;
        return;
      }
      this.submitForApprovalQueue();
    } else {
      this._alertService.error('Please complete all checklist');
    }
  }

  serviceCaseCreation() {
    if (this.isValidChildRemoval) {
      this._childRemovalService.serviceCaseCreateOrCheckIsExist().subscribe((scResponse: any) => {
        if (scResponse && scResponse.data && scResponse.data.length) {
          if (scResponse.isavailable === 1) {
            this.exitingServiceCaseList = scResponse.data;
            $(this.servicecasevalidationpopupid).modal('show');
          } else {
            this.serviceCaseNumber = scResponse.data[0].servicecasenumber;
           $(this.removalackmtid).modal('show');
            this._alertService.success('Service case created successfully. Servicecase #' + scResponse.data[0].servicecaseno);
          }

        }


      });
    } else {
      $(this.removalpopupid).modal('hide');
    }
  }

  findServiceCaseId() {
    const removalIfo = this._childRemovalService.childRemovalInfo;
    let serviceCaseId = null;
    if (removalIfo && Array.isArray(removalIfo) && removalIfo.length) {
      const ri = removalIfo.find(item => item.servicecaseid !== null);
      serviceCaseId = (ri) ? ri.servicecaseid : null;
    }

    return serviceCaseId;
  }

  validatechildRemoval() {
    const lgList = this._childRemovalService.getLegalGuardianList();  // NOSONAR
    const remvalChildList = this._childRemovalService.getRemovedChildren();
    const removalInfo = this.childRemovalFormGroup.getRawValue();
    const requiresFamilyFindingsChecklist = this.isCaseWorker && !this.isExitChildRemoval;
    this.isFamilyFindingsRelationshipsComplete = requiresFamilyFindingsChecklist ? false : true;
    this.isValidChildRemoval = true;
    this.validList = [];
    this.validList.length = 0;
    this.validList = remvalChildList.map(child => {
      const obj: any = {};
      obj['validMDM'] = true; // (child.mdm === 'Y') ? true : false; un comment this line once mdm related proc solved
      // obj['hasLG'] = (lgList && lgList.length) ? true : false;
      obj['isadult'] = (this.calculateAge(child.dob) > 18) ? false : true;
      obj['isvalidremovalDate'] = this.isremovaldateafterchilddob(child);
      obj['primCitizenReq'] = (child.citizenalenageflag === 1 || child.citizenalenageflag === 0) ? true : false;
      obj['familyFindingsRelationshipsComplete'] = this.isFamilyFindingsRelationshipsComplete;
      if (!(obj['validMDM'] && (obj['isadult'] || removalInfo.removaltypekey === 'EHA') && obj['isvalidremovalDate']
        && obj['primCitizenReq'] && obj['familyFindingsRelationshipsComplete'])) {
        this.isValidChildRemoval = false;
      }
      if (!(obj['validMDM'] && (obj['isadult'] || removalInfo.removaltypekey === 'EHA') && obj['isvalidremovalDate']
        && obj['primCitizenReq'])) {
        this.isValidChildRemoval = false;
      }
      obj['cjamspid'] = child.cjamspid;
      obj['firstname'] = child.firstname;
      obj['lastname'] = child.lastname;
      obj['intakeservicerequestactorid'] = child.intakeservicerequestactorid;
      this.getLegalCustody(child.intakeservicerequestactorid);
      return obj;
    });

    if (requiresFamilyFindingsChecklist) {
      this.prepareChildInfoForConfirmation().then(() => {
        this.showChildInfoConfirmModal = true;
      });
      return;
    }

    $(this.removalpopupid).modal('show');
  }

  submitForApprovalQueue() {
    this.setFamilystructuretypekeyref();
 
    this.setEnvironmentAtRemovalkeyref();
   
    this.setAgencytypekeyref();
   
    this.setRemovaltypekeyref();
    
    this.setPrimarycaregiveractoridref();
  
    this.setSeccaregiveractoridref();
   
    this.setParent1idref();
   
    this.setParent2idref();
   
    this.setRemovalreasonref();
    
    this.setReasonableeffortsref();
    
    this.setRemovalexitreasonref();
    
    this.setNotakingeffortsref();
    
    this.approvalRequestSubmission();
    
    if(this.isChildAgeOverModal || this.childAgeOverModal) {
      this.childAgeOverModal.closeConfirmationModal();
    }
  }
  setFamilystructuretypekeyref(){
    if (this.childRemovalFormGroup.controls.familystructuretypekey.value) {
      this.familyStructure.forEach(a => {
        if (a.picklist_value_cd === this.childRemovalFormGroup.controls.familystructuretypekey.value) {
          this.familystructuretypekeyref = a.description_tx;
        }
      });
    }
  }
  setEnvironmentAtRemovalkeyref(){
    if (this.childRemovalFormGroup.controls.environmentatremovalkey.value) {
      this.environmentAtRemovalList.forEach(a => {
        if (a.ref_key === this.childRemovalFormGroup.controls.environmentatremovalkey.value) {
          this.environmentAtRemovalkeyref = a.description;
        }
      });
    }
  }
  setAgencytypekeyref(){
    if (this.childRemovalFormGroup.controls.agencytypekey.value) {
      this.sendTo.forEach(a => {
        if (a.agencytypekey === this.childRemovalFormGroup.controls.agencytypekey.value) {
          this.agencytypekeyref = a.typedescription;
        }
      });
    }
  }
  setRemovaltypekeyref(){
    if (this.childRemovalFormGroup.controls.removaltypekey.value) {
      this.childRemovalType.forEach(a => {
        if (a.ref_key === this.childRemovalFormGroup.controls.removaltypekey.value) {
          this.removaltypekeyref = a.description;
        }
      });
    }
  }
  setPrimarycaregiveractoridref(){
    if (this.childRemovalFormGroup.controls.primarycaregiveractorid.value) {
      this.careGiverPersons.forEach(a => {
        if (a.personid === this.childRemovalFormGroup.controls.primarycaregiveractorid.value) {
          this.primarycaregiveractoridref = a.personNameWithId;
        }
      });
    }
  }
  setSeccaregiveractoridref(){
    if (this.childRemovalFormGroup.controls.seccaregiveractorid.value) {
      this.careGiverPersons.forEach(a => {
        if (a.personid === this.childRemovalFormGroup.controls.seccaregiveractorid.value) {
          this.seccaregiveractoridref = a.personNameWithId;
        }
      });
    }
  }
  setParent1idref(){
    if (this.childRemovalFormGroup.controls.parent1id.value) {
      this.careGiverPersons.forEach(a => {
        if (a.cjamspid === this.childRemovalFormGroup.controls.parent1id.value) {
          this.parent1idref = a.firstname + a.lastname;
        }
      });
    }
  }
  setParent2idref(){
    if (this.childRemovalFormGroup.controls.parent2id.value) {
      this.careGiverPersons.forEach(a => {
        if (a.cjamspid === this.childRemovalFormGroup.controls.parent2id.value) {
          this.parent2idref = a.firstname + a.lastname;
        }
      });
    }
  }
  setRemovalreasonref(){
    if (this.childRemovalFormGroup.controls.removalreason.value) {
      const removalReasonDesc = this.childRemovalFormGroup.controls.removalreason.value; 
      this.removalreasonref = '';
      this.removalReason.forEach(a => {
        if (removalReasonDesc.length > 0){
           this.handleRemovalReasonDescLoopFn(removalReasonDesc, a);
        }
      });
    }
  }
  // Assosiated with setRemovalreasonref method
  private handleRemovalReasonDescLoopFn(removalReasonDesc: any, a: any) {
    removalReasonDesc.forEach((element: any, index: number) => {
      if (a.removalreasontypekey === element) {
        index++;
        if (index > 1) {
          this.removalreasonref += ', ' + a.description;
        } else {
          this.removalreasonref += a.description;
        }
      }
    });
  }

  setReasonableeffortsref(){
    if (this.childRemovalFormGroup.controls.reasonableefforts.value) {
      const reasonableeffortsDesc = this.childRemovalFormGroup.controls.reasonableefforts.value; 
      this.reasonableeffortsref = '';
      this.handleReasonableeffortsDescLoopFn(reasonableeffortsDesc);
    }
  }
  // Assosiated with setReasonableeffortsref method
  private handleReasonableeffortsDescLoopFn(reasonableeffortsDesc: any) {
    this.reasonableEfforts.forEach((a, index) => {
      if (reasonableeffortsDesc.length > 0) {
        reasonableeffortsDesc.forEach((element: any) => {
          if (a.ref_key === element) {
            index++;
            if (index > 1) {
              this.reasonableeffortsref += ', ' + a.value_text;
            }
            else {
              this.reasonableeffortsref += a.value_text;
            }
          }
        });
      }
    });
  }

  setRemovalexitreasonref(){
    if (this.childRemovalFormGroup.controls.removalexitreason.value) {
      this.removalEndReasons.forEach(a => {
        if (a.ref_key === this.childRemovalFormGroup.controls.removalexitreason.value) {
          this.removalexitreasonref = a.description;
        }
      });
    }
  }
  setNotakingeffortsref(){
    if (this.childRemovalFormGroup.controls.notmakingefforts.value) {
      const notmakingeffortsdesc = this.childRemovalFormGroup.controls.notmakingefforts.value; 
      this.notmakingeffortsref = '';
      this.handleReasonableEffortsNotMadeLoopFn(notmakingeffortsdesc);
    }
  }
  // Assosiated with setNotakingeffortsref method
  private handleReasonableEffortsNotMadeLoopFn(notmakingeffortsdesc: any) {
    this.reasonableEffortsNotMade.forEach((a, index) => {
      if (notmakingeffortsdesc.length > 0) {
        notmakingeffortsdesc.forEach((element: any) => {
          if (a.ref_key === element) {
            index++;
            if (index > 1) {
              this.notmakingeffortsref += ', ' + a.value_text;
            }
            else {
              this.notmakingeffortsref += a.value_text;
            }
          }
        });
      }
    });
  }

  approvalRequestSubmission() {
    const actionSummary = this._dataStoreService.getData('dsdsActionsSummary');
    if (actionSummary.da_subtype === 'IHS') {
      this.approvalSend();
    } else {
      if (this.approvalQueueIndex < this.removedChildren.length) {
        this.approvalSend();
      } else {
        if (this.CHILD_REMOVAL_SUBMIT === 1) {
          this.showAcknowledgement();
        
        } else {
          this._alertService.success('saved successfully');
          this._childRemovalService.getPersonsAndChildRemovalInfo().subscribe((_response: any) => {
            // No content to add or call
          });
          setTimeout(() => {
            if (this.showcontactpage) {
              this._router.navigate(['/pages/person-info-cw/contacts']);
            } else {
              this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/child-removal/details']);
            }
          }, 2000);
        }
      }
    }
  }
  showAcknowledgement(){
    if (this._childRemovalService.isServiceCase()) {
     $('#service-case-removal-ackmt').modal('show');
    } else {
      const serviceCaseId = this.findServiceCaseId();
      if (serviceCaseId) {
        this._childRemovalService.serviceCaseCreatOrMerge(serviceCaseId, OLD_SERVICE_CASE).subscribe((response: any) => {
          $(this.servicecasevalidationpopupid).modal('hide');
          this._alertService.success('Service case merged successfully with Service case #' + response[0].servicecaseno);
          this.serviceCaseNumber = response[0].servicecaseno;
           $(this.removalackmtid).modal('show');
        });
      } else {
        this.serviceCaseCreation();
      }
    }
    this.sendApprovalDisabled = true;
  }

  approvalSend() {
    const removalDetails = this.childRemovalFormGroup.getRawValue();
    const referenceData = {
      'familystructuretypekeyref': this.familystructuretypekeyref,
      'environmentAtRemovalkeyref':this.environmentAtRemovalkeyref,
      'agencytypekeyref': this.agencytypekeyref,
      'removaltypekeyref': this.removaltypekeyref,
      'primarycaregiveractoridref': this.primarycaregiveractoridref,
      'seccaregiveractoridref': this.seccaregiveractoridref,
      'parent1idref': this.parent1idref,
      'parent2idref': this.parent2idref,
      'removalreasonref': this.removalreasonref,
      'removalexitreasonref': this.removalexitreasonref,
      'reasonableeffortsref': this.reasonableeffortsref,
      'notmakingeffortsref': this.notmakingeffortsref,
      'isuploadedmanually': this.isuploadedmanually,
      'isshelterauthcompleted': this.shelterChkBox,
       'childremovalluggage' : this.childremovalluggage,
       'luggageprovided':this.luggageprovided,
      'luggagecomments': this.luggagecomments,
      'placementdisposableortrashbag':this.placementdisposableortrashbag

    };
    const updatedRefernceValues  = Object.assign(this.childRemovalFormGroup.getRawValue(), referenceData);
    removalDetails.modifiedjson = updatedRefernceValues;
    const childRemovalData = removalDetails;
    childRemovalData.isshelterauthcompleted = (this.shelterChkBox != null) ? this.shelterChkBox : 0;
    childRemovalData.isuploadedmanually = (this.isuploadedmanually != null) ? this.isuploadedmanually : 0;
    childRemovalData.luggageprovided = this.luggageprovided;
    childRemovalData.childremovalluggage = this.childremovalluggage;
    childRemovalData.luggagecomments = this.luggagecomments;
    childRemovalData.placementdisposableortrashbag =this.placementdisposableortrashbag;
    if(this.luggageupdated){
      childRemovalData.luggageupdatedby = this._token.user.userprofile.displayname;
      childRemovalData.luggageupdatedon = moment(new Date()).format('MM/DD/YYYY hh:mm:ss A');
    }else{
      childRemovalData.luggageupdatedby = this.luggageupdatedby;
      childRemovalData.luggageupdatedon = this.luggageupdatedon;
    }
    let formatedData = this.returnFormatedDataFn(childRemovalData);
    formatedData = this.formatedDataFn(formatedData);
    if(this._token.user.securityusersid){
      formatedData.v_securityusersid = this._token.user.securityusersid;
    }
    formatedData.showcontactpage = this.showcontactpage;
    if (!this.childInfoForConfirmation || this.childInfoForConfirmation.length === 0) {
      this.childInfoForConfirmation = this.removedChildren.map((child: any) => ({
        firstname: child.firstname || '',
        lastname: child.lastname || '',
        dob: child.dob ? this.formatDate(child.dob) : '',
        gender: child.gender || '',
        clientId: child.cjamspid || '',
        county: this.bintiCountyName || '',
        selected_relationships: [],
      }));
      this.childInfoForConfirmationList = [...this.childInfoForConfirmation];
    } else if (this.childConfirmationAccordion && this.childConfirmationAccordion.length > 0) {
      this.buildBintiPayloadFromAccordion();
    }
    // Send only the current queued child info with each API call.
    formatedData.bintiinfo = this.childInfoForConfirmation[this.approvalQueueIndex] || null;
    // need to send as disability array as service dependency sending as object
    this._childRemovalService.sendForApproval(formatedData).subscribe((_item: any) => {
      if (this.approvalQueueIndex < this.approvalQueueLength) {
        this.approvalQueueIndex++;
        if (this.isCaseWorker) {
        }
        this.submitForApprovalQueue();
      }

    });
  }
  
  // Assosiated with approvalSend method
  private formatedDataFn(formatedData: any){
    if(formatedData.modifiedjson) {
      const lugageProvFalse = (formatedData?.modifiedjson?.luggageprovided === false)? 0: formatedData?.modifiedjson?.luggageprovided;
      const childremoavlLagugeFalse = (formatedData?.modifiedjson?.childremovalluggage === false) ? 0 :formatedData?.modifiedjson?.childremovalluggage;
      formatedData.modifiedjson.isverifiedcaregiver1add = this.formatedDataFnConditionCheck(formatedData.modifiedjson.isverifiedcaregiver1add);
      formatedData.modifiedjson.isverifiedcaregiver2add = this.formatedDataFnConditionCheck(formatedData.modifiedjson.isverifiedcaregiver2add);
      formatedData.modifiedjson.ischildphysicalremovaladdressverified = this.formatedDataFnConditionCheck(formatedData.modifiedjson.ischildphysicalremovaladdressverified);
      formatedData.modifiedjson.isverifiedreporteradd = this.formatedDataFnConditionCheck(formatedData.modifiedjson.isverifiedreporteradd);
      formatedData.modifiedjson.luggageprovided = (formatedData?.modifiedjson?.luggageprovided === true) ? 1 : lugageProvFalse;
      formatedData.modifiedjson.childremovalluggage = (formatedData?.modifiedjson?.childremovalluggage === true) ? 1 : childremoavlLagugeFalse;
      formatedData.modifiedjson.placementdisposableortrashbag = this.formatedDataFnConditionCheck(formatedData?.modifiedjson?.placementdisposableortrashbag);
      formatedData.modifiedjson.placementdisposableortrashbag = (formatedData?.modifiedjson?.placementdisposableortrashbag ===false)? 0 : formatedData?.modifiedjson?.placementdisposableortrashbag; 
    }
    return formatedData;
  }

  // Assosiated with approvalSend method
  private formatedDataFnConditionCheck(value: any){
    return value === true ? 1 : value;
  }
  // Assosiated with approvalSend method
  private returnFormatedDataFn(childRemovalData: any) {
    const formatedData = this._mapperService.mapChildRemovalFormData(childRemovalData);
    const removedChild = this.removedChildren[this.approvalQueueIndex];
    formatedData.intakeservicerequestactorid = removedChild.intakeservicerequestactorid;
    formatedData.personid = removedChild.personid;
    formatedData.isreviewsubmit = this.CHILD_REMOVAL_SUBMIT;
    if (removedChild.hasOwnProperty('intakeservreqchildremovalid')) {
      formatedData.intakeservreqchildremovalid = removedChild.intakeservreqchildremovalid;
    }
    if (formatedData.removaldate && formatedData.removaltime) {
      const date = moment(formatedData.removaldate).format(this.dtformat1);
      const time = moment(formatedData.removaltime).format('hh:mm A');
      const removaldatetime = `${date} ${time}`;
      formatedData.removaltime = removaldatetime;
    }

    formatedData.isverifiedcaregiver1add = (formatedData.isverifiedcaregiver1add === true) ? 1 : formatedData.isverifiedcaregiver1add;
    formatedData.isverifiedcaregiver2add = (formatedData.isverifiedcaregiver2add === true) ? 1 : formatedData.isverifiedcaregiver2add;
    formatedData.ischildphysicalremovaladdressverified = (formatedData.ischildphysicalremovaladdressverified === true) ? 1 : formatedData.ischildphysicalremovaladdressverified;
    formatedData.isverifiedreporteradd = (formatedData.isverifiedreporteradd === true) ? 1 : formatedData.isverifiedreporteradd;
    return formatedData;
  }

  removalAcknowledged() {
    $(this.removalackmtid).modal('hide');
  }

  reject() {
    this.approveRejectQueueIndex = 0;
    const childRemovalId = this.removedChildren[this.approveRejectQueueIndex].intakeservreqchildremovalid;
    this.rejectionQueue(childRemovalId);
  }

  approve() {
    this.approveRejectQueueIndex = 0;
    const childRemovalId = this.removedChildren[this.approveRejectQueueIndex].intakeservreqchildremovalid;
    this.approveQueue(childRemovalId);
  }

  rejectionQueue(remvoalID: any) {
    this._childRemovalService.rejectChildRemoval(remvoalID).subscribe((removal: any) => {
      this.approveRejectQueueIndex++;
      if (this.approveRejectQueueIndex < this.removedChildren.length) {
        const childRemovalId = this.removedChildren[this.approveRejectQueueIndex].intakeservreqchildremovalid;
        this.rejectionQueue(childRemovalId);
      } else {
        this.rejectionCompleted(removal);
      }
    });
  }

  rejectionCompleted(data: any) {
    this.message = 'Child removal rejected successfully';
    this.isApproved = true;
    this._alertService.success(this.message, true);
    this._router.navigate(['/pages/cjams-dashboard/cw-approval']);
  }

  approveCompleted(data: any) {
    this.message = 'Child removal approved successfully.';
    this.isApproved = true;
    this._alertService.success(this.message, true);
    if (this._childRemovalService.childRemovalInfo && this._childRemovalService.childRemovalInfo.length) {
      const ri = this._childRemovalService.childRemovalInfo.find(removal => removal.servicecasenumber !== null);
      this.newservicecasenumber = (ri) ? ri.servicecasenumber : null;
      if (this._childRemovalService.isServiceCase()) {
        $(this.approvalsuccesspopupid).modal('show');
      } else {
       $(this.newservicecasepopupid).modal('show');
      }

    }

  }
  getErrorsMessage(ControlName: any, displayName: any){
    if(this.childRemovalFormGroup.controls[ControlName].status =='INVALID' ){
    return 'Please enter valid ' + displayName
    }
    }
   
  getnewservicecaselist() {
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        limit: 1,
        page: 1,
        method: 'get',
        where: { 'status': 'OPEN' }

      }),
      'Intakedastagings/servicecaseassignlist?filter').subscribe((result: any) => {
        if (result && result[0]) {
          this.newservicecasenumber = result[0].servicecasenumber;
          $(this.newservicecasepopupid).modal('show');
        }
      });
  }

  getAuditInformation(intakeChildRemovalid: any) {
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        limit: 30,
        page: 1,
        method: 'get',
        where: { 
          columnid: 'intakeservreqchildremovalid',
          tableid:  'intakeservreqchildremoval_history',
        
          objectid: intakeChildRemovalid
      }

      }),
      'servicecase/getauditlog?filter').subscribe((result: any) => {
        if (result && result.data) {
          const sortresult = result.data;
          let rvrseReslt = sortresult.reverse();    // NOSONAR
          const reversedResult = rvrseReslt;
          this.checkAuditlog(reversedResult);
        
        }
      });
  }
  checkAuditlog(sortresult: any) {
    sortresult.forEach((el: any) => {
      const a = el.modifieddata ? el.modifieddata.data : null;
      if (a && a.length) {
        a.forEach((element: any) => {
          if (element.key === 'removaldate') {
            element.display_name = 'Removal Start date';
          }
          element.new_value = this.getElementNewValue(element);
          element.old_value = this.getElementOldValue(element);
        
        });
      }
    })
    this.auditlogTrail = sortresult;
  }

  getElementNewValue(element: any){
    this.checkIfIsuploadedmanuallyFn(element);
   
    if (element.key.includes('date')) {
      if (element.new_value && moment(element.new_value).isValid()) {
        element.new_value = this.getDateFormatted(element.new_value);
      }
    }
    if (element.key.includes('time')) {
      if (element.new_value && moment(element.new_value).isValid()) {
        element.new_value = this.getTimeFormatted(element.new_value);
      }
    }
    if (element.key.includes('approvedon') || element.key.includes('submittedon') || element.key.includes('rejectedon')) {
      if (element.new_value && moment(element.new_value).isValid()) {
        element.new_value = this.getDateTimeFormatted(element.new_value);
      }
    }
    return element.new_value;
  }
  // Assosiated with getElementNewValue method
  private checkIfIsuploadedmanuallyFn(element: any) {
    if (element.key === 'isuploadedmanually') {
      if (element.new_value == 1) {
        element.new_value = 'Uploaded Manually';
      }
      if (element.new_value == 0) {
        element.new_value = 'Uploaded via System';
      }
    }
    if (element.new_value === true || element.new_value == 1) {
      element.new_value = 'Yes';
    }
    if (element.new_value === false || element.new_value == 2 || element.new_value == 0) {
      element.new_value = 'No';
    }
  }

  getElementOldValue(element: any){
    if (element.key === 'isuploadedmanually') {
      if (element.old_value == 1) {
        element.old_value = 'Uploaded Manually';
      }
      if (element.old_value == 0) {
        element.old_value = 'Uploaded via System';
      }
    }
    if (element.old_value === true || element.old_value == 1) {
      element.old_value = 'Yes';
    }
    if (element.old_value === false || element.old_value == 2 || element.old_value == 0) {
      element.old_value = 'No';
    }
    if (element.key.includes('date')) {
      if (element.old_value && moment(element.old_value).isValid()) {
        element.old_value = this.getDateFormatted(element.old_value);
      }
    } else if (element.key.includes('time')) {
      if (element.old_value && moment(element.old_value).isValid()) {
        element.old_value = this.getTimeFormatted(element.old_value);
      }
    }
    return element.old_value;
  }

  getDateFormatted(date:any){
    if(date){
      return moment(date).format(this.dtformat1);
    } else {
      return '';
    }  
  }

  getDateTimeFormatted(date:any){
    if(date){
      return moment(date).format('MM/DD/YYYY, h:mm A');
    }else {
      return '';
    }
  }

  getTimeFormatted(date:any){
  if (!date) {
    return '';
  }
  const time = moment(date, 'HH:mm:ss', true);
  return (time.isValid() ? time : moment(date)).format('h:mm A');
}
  auditlogTrailOpen(i: any){
    const filteredValues = i.modifieddata.data;
    this.auditlogTrailExpand =  filteredValues.filter((child: { new_value: string | null; }) => child.new_value !== null || child.new_value !== '');
    this.auditUpdatedBy = i.fullname;
    this.auditUpdatedOn = i.updatedon;
    this.auditUpdatedEmail = i.email;
  }

  navigatetohome() {
    if (this._childRemovalService.isServiceCase()) {
      $(this.approvalsuccesspopupid).modal('hide');
      $(this.newservicecasepopupid).modal('hide');
      this._router.navigate(['/pages/cjams-dashboard/cw-approval']);
    } else {
       $(this.newservicecasepopupid).modal('hide');
       $(this.approvalsuccesspopupid).modal('hide');
       this._router.navigate(['/pages/cjams-dashboard/cw-assign-service-case']);
    }

  }

  closeApproveReject() {
    $('#approve-reject-ackmt').modal('hide');
  }

  async approveQueue(removalID: any) {
    await this.prepareChildInfoForConfirmation(true);
    const selectedChildInfo = this.childInfoForConfirmation[this.approveRejectQueueIndex] || {};
    const selectedRemovedChild = this.removedChildren[this.approveRejectQueueIndex] || {};
    const selectedClientInfo = {
      firstname: selectedChildInfo.firstname || selectedRemovedChild.firstname || '',
      lastname: selectedChildInfo.lastname || selectedRemovedChild.lastname || '',
      dob: selectedChildInfo.dob || (selectedRemovedChild.dob ? this.formatDate(selectedRemovedChild.dob) : ''),
      gender: selectedChildInfo.gender || selectedRemovedChild.gender || '',
      county: selectedChildInfo.county || this.bintiCountyName || '',
      caseid: this.id || this.findServiceCaseId(),
      clientId: selectedChildInfo.clientId || selectedRemovedChild.cjamspid || '',
      cjamspid: selectedChildInfo.clientId || selectedRemovedChild.cjamspid || '',
      selected_relationships: Array.isArray(selectedChildInfo.selected_relationships)
        ? selectedChildInfo.selected_relationships
        : []
    };
    this._childRemovalService.approveChildRemoval({
      removalID: removalID,
      ...(!this.checkluggage() ? {} : {
        bintiinfo: {
          client: selectedClientInfo,
          search_date: new Date().toISOString().slice(0, 10),
          case_worker: {
            email: this.currentWorker?.email,
            userid: this.currentWorker?.securityusersid,
          }
        }
      })
    }).subscribe((removal: any) => {
      // CSMS Trigger only for Removal Exit
      if(this.childRemovalFormGroup.getRawValue().removalexitreason && this.childRemovalFormGroup.getRawValue().exitdate !== null) {
         this.sendApprovalInfomation(this.removedChildren[this.approveRejectQueueIndex]);
      }
      this.approveRejectQueueIndex++;
      if (this.approveRejectQueueIndex < this.removedChildren.length) {
        const childRemovalId = this.removedChildren[this.approveRejectQueueIndex].intakeservreqchildremovalid;
        this.approveQueue(childRemovalId);
      } else {
        this.approveCompleted(removal);
      }
    });

  }


  // Trigger to pass the CJAMS information to CSMS
  sendApprovalInfomation(data: any) {
    this._commonService.create(
        {
            'where': {
                'clientId': Number(data.cjamspid),
                'removalId': Number(data.removalid),
                'reviewperiod': 'Removal Exit'
            },
        },
        'titleive/ive/ivecsms-data'
    ).subscribe((_response: any) => {
            return true;
        },
        (_error: any) => {
            return false;
        });
}


  parentsignedAggmntChange() {
    const value = this.childRemovalFormGroup.getRawValue().isbothparentssigned;
    if (value === 1) {
      this.showparent1signature = true;
      this.showparent2signature = true;
      this.showparent2signmisreason = false;
    } else if (value === 2) {
      this.showparent1signature = true;
      this.showparent2signature = false;
      this.showparent2signmisreason = true;
    }
  }

  calculateAge(dob: any) {
    let age = 0;
    if (dob && moment(new Date(dob), this.dtformat1, true).isValid()) {
      const rCDob = moment(new Date(dob), this.dtformat1).toDate();
      age = moment().diff(rCDob, 'years');
    }
    return age;
  }

  isremovaldateafterchilddob(child: any) {
    const removaldate = this.childRemovalFormGroup.getRawValue().removaldate;
    const dob = child.dob;
    if ((removaldate && moment(new Date(removaldate))) && (dob && moment(new Date(dob), this.dtformat1, true).isValid())) {
      const removalDate = moment(new Date(removaldate));
      const dobDate = moment(new Date(dob));
      if (removalDate.isSameOrAfter(dobDate, 'day')) {
        return true;
      }
    }
    return false;
  }

  openDisabilityForm(child: any) {
    this.disabilityChild = child;
    this._router.navigate(['disability/' + child.personid + '/create'], { relativeTo: this.route });
  }

  openDisabilityList(child: any) {
    this.disabilityChild = child;
    this._router.navigate(['disability/' + child.personid + '/list'], { relativeTo: this.route });
  }


  reasonableEffortsChanged() {
    const efforts = this.childRemovalFormGroup.getRawValue().reasonableefforts;
    if (efforts && Array.isArray(efforts) && efforts.length > 0) {
      if (efforts.indexOf(NO_EFFORTS_MADE) !== -1) {
        this.showNotMakingReasonableEfforts = true;
      } else {
        this.showNotMakingReasonableEfforts = false;
      }
    }
  }

  deleteDisability() {
    this._disabilityService.deleteDisability(this.personDisability.persondisabilityid).subscribe(() => {
      this._alertService.success('Disability deleted successfully');
      this._childRemovalService.loadPersonDisabilities();
    });
  }

  confirmDeleteDisability(personDisability: any) {
    this.personDisability = personDisability;
  }
 

  checkForNoDisabilityAdded(child: any) {
    if (child.personDisabilities.length > 0) {
      child.hasDisability = 1;
      this.removedChildren.forEach(removedChild => {
        if (removedChild.personid === child.personid) {
          removedChild.hasDisability = 1;
        }
      });
      this._childRemovalService.loadPersonDisabilities();
      $('#alert-message').modal('show');
    }
  }

  selectCase(selectedCase: any) {
    this.exitingServiceCaseId = selectedCase.servicecaseid;
  }

  createServiceCase(isnewcase: any) {
    if (isnewcase === 1) {
      this._childRemovalService.serviceCaseCreatOrMerge(null, isnewcase).subscribe((response: any) => {
        $(this.servicecasevalidationpopupid).modal('hide');
        if (response && Array.isArray(response)) {
          this._alertService.success('Service case created successfully. Servicecase #' + response[0].servicecaseno);
          this.serviceCaseNumber = response[0].servicecaseno;
          $(this.removalackmtid).modal('show');
        }

      });
    } else {
      if (!this.exitingServiceCaseId) {
        this._alertService.error('Please Select Case');
        return false;
      }
      this._childRemovalService.serviceCaseCreatOrMerge(this.exitingServiceCaseId, isnewcase).subscribe((response: any) => {
        $(this.servicecasevalidationpopupid).modal('hide');
        this._alertService.success('Service case merged successfully. Servicecase #' + response[0].servicecaseno);
        this.serviceCaseNumber = response[0].servicecaseno;
        $(this.removalackmtid).modal('show');

      });
    }
  }
  childAddressAsPrimary() {
    const value = this.childRemovalFormGroup.getRawValue().ischildaddressasprimaryaddress;
    if (value === 2) {
      this.childRemovalFormGroup.get('removaladd1')?.setValidators([Validators.required]);
      this.childRemovalFormGroup.get('removaladd1')?.updateValueAndValidity();
      this.ischildhomeaddress = true;
    } else {
      this.childRemovalFormGroup.get('removaladd1')?.clearValidators();
      this.childRemovalFormGroup.get('removaladd1')?.updateValueAndValidity();
      this.ischildhomeaddress = false;
    }
  }

  onChangechildAddress(value: any) {
    const primaryAddress = this.childRemovalFormGroup.getRawValue().primarycaregiveradd;
    if (value === 1) {
      this.childRemovalFormGroup.patchValue({ removaladd1: primaryAddress });
      this.childRemovalFormGroup.patchValue({ isverifiedreporteradd: 1 });
    } else {
      this.childRemovalFormGroup.patchValue({ removaladd1: null });
      this.childRemovalFormGroup.patchValue({ isverifiedreporteradd: null });
    }
  }

  showAssessment(id: number, row: any) {
  
    this.getAsseesmentHistory = row;
    if (this.showAssesment !== id) {
      this.showAssesment = id;
    } else {
      this.showAssesment = -1;
    }
  }
  isIconDisabled(modal: any) {
    if (this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)) {
      if (modal.assessmentstatustypekey === 'InProcess' || modal.assessmentstatustypekey === 'Rejected' || modal.assessmentstatustypekey === 'Accepted') {
        return 'icon-disabled';
      }
    } else {
      return;
    }
  }

  actionIconDisplay(modal: any, status: string): boolean {
    if (status === 'View') {
      return modal.assessmentstatustypekey !== 'Open' && modal !== null;
    } else if (status === 'Edit') {
      const cwstatusList = ['Accepted']; // Rejected is removed based on UAT team request on 03072019
      const supStatusList = ['Open', 'Accepted'];
      return (!cwstatusList.includes(modal.assessmentstatustypekey) && modal !== null)
        || (this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)
          && !supStatusList.includes(modal.assessmentstatustypekey));
    } else if (status === 'Print') {
      return modal.assessmentstatustypekey !== 'Open' && modal !== null;
    } else if (status === 'InProcess') {
      return modal.assessmentstatustypekey === 'InProcess' && modal !== null;
    }
    return false;
  }
  confirmDelete(assessmentid: any) {
    this.assessmentTemplateId = assessmentid;
    $('#delete-assessment-popup').modal('show');
  }
  deleteAssessment() {
    this._commonService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.DeleteAssessment;
    this._commonService.create({
      assessmentid: this.assessmentTemplateId,
    })
      .subscribe((response: any) => {
          if (response) {
            this._alertService.success(
              'Assessment deleted successfully'
            );
            $('#delete-assessment-popup').modal('hide');
            this.getAsseesmentHistory = [];
            this.getPage(1);
            this.showAssesment = -1;
          }
        }
      );
  }

  close() {
    this.removedChildren = [];
    this.shelterChkBox = 0;
    this.isuploadedmanually = null;
    this.enableEndRemoval = false;
    this.sendApprovalDisabled = false;
    this.isJustificationEnabled = false;
    this.viewOnly = false;
    this.disablesheltercheckbox = false;
    this._childRemovalService.getPersonsAndChildRemovalInfo().subscribe((_response: any) => {
      // No content to add or call
    });

  }

  processActionButtons(children: any) {
    this.sendApprovalDisabled = false;
    const draftChildRemoval = children.filter((child: { removalStatus: string; }) => child.removalStatus === 'Draft');
    if (draftChildRemoval.length === children.length) {
      this.sendApprovalDisabled = false;
    }
    const reviewChildRemoval = children.filter((child: { removalStatus: string; }) => child.removalStatus === 'Review');
    if (reviewChildRemoval.length === children.length && this.isCaseWorker) {
      this.sendApprovalDisabled = false;
      this.saveAsDraftDisabled = true;
    }
    const approvedChildRemoval = children.filter((child: { removalStatus: string; }) => child.removalStatus === 'Approved');
    if (approvedChildRemoval.length === children.length && this.isCaseWorker) {
      this.saveAsDraftDisabled = true;
    }
    // Enable the Send for approval if Child removal active again after reunification or placement end date in any permanency plan closure
    const enableEndRemoval = children.filter((child: { enableEndRemoval: boolean; }) => child.enableEndRemoval === true);
    const rejectedExitInfo = children.filter((child: { removalStatus: string; }) => child.removalStatus === 'Rejected' && children[0].removalInfo.revisionrecord !== null &&  children[0].removalInfo.revisionrecord.length > 0);

    if (children[0].editType === 'Exit' && ((enableEndRemoval && enableEndRemoval.length) || (rejectedExitInfo && rejectedExitInfo.length))) {
      this.enableEndRemoval = true;
      this.formDisabled = true;
      this.childRemovalFormGroup.disable();
      this.childRemovalFormGroup.controls['exitdate'].enable();
      this.childRemovalFormGroup.controls['exittime'].enable();
      this.childRemovalFormGroup.controls['removalexitreason'].enable();
      this.childRemovalFormGroup.controls['transferagency'].enable();
      this.childRemovalFormGroup.controls['otherpublicagency'].enable();
      this.childRemovalFormGroup.controls['locationofadoption'].enable();
      this.childRemovalFormGroup.controls['justification'].enable();
    } else {
      this.enableEndRemoval = false;
      this.formDisabled = false;
      this.childRemovalFormGroup.enable();
    }

    if(this.isSupervisor) {
      this.formDisabled = true;
      this.childRemovalFormGroup.disable();
    }

    const viewOnlyRemoval = children.filter((child: { viewOnly: boolean; }) => child.viewOnly === true);
    if (viewOnlyRemoval && viewOnlyRemoval.length) {
      this.viewOnly = true;
    } else {
      this.viewOnly = false;
    }


  }

  setVoluntaryPlacementValidators() {
    this.setRequriedValidtor('vpabegindate');
    this.setRequriedValidtor('vpaenddate');
    this.setRequriedValidtor('agencysigneddate');
  }

  clearVoluntaryPlacementValidators() {
    this.clearValidators('vpabegindate');
    this.clearValidators('vpaenddate');
    this.clearValidators('agencysigneddate');
  }

  setRequriedValidtor(formControlName: string) {
    this.childRemovalFormGroup.get(formControlName)?.setValidators([Validators.required]);
    this.childRemovalFormGroup.get(formControlName)?.updateValueAndValidity();
  }
  clearValidators(formControlName: string) {
    this.childRemovalFormGroup.get(formControlName)?.clearValidators();
    this.childRemovalFormGroup.get(formControlName)?.updateValueAndValidity();
  }


  checkEndDateValidation(action: any) {
    const enddate = this.childRemovalFormGroup.getRawValue().exitdate;
    if (action === 0) {
      this.vendorlist = [];
      this.agencylist = [];
      this.endatecheck = {};
      const child = this._personInfoService.getPerson();
      if (child) {
        const slsource = this.getServiceLogList(child.cjamspid);
        const vssource = this.getVendorList(child.cjamspid);
        this.getPlacementInfoList(child, enddate);
        vssource.subscribe((data: any) => {
          this.vendorlist = data['servicelogData'];
          this.checkallservicelog(enddate);
        });
        slsource.subscribe((data: any) => {
          const list = Array.isArray(data['servicelogData']) ? data['servicelogData'] : [];
          this.agencylist = list;
          this.checkallservicelog(enddate);
        });
        this.checkEndDateValidation(1);
      }
    } else if (action === 1) {
      const l = true;
      $('#end-removal-check-popup').modal('show');
    }
  }

  getServiceLogList(id: any) {
    return this._commonService.getArrayList(
      {
        where: { daNumber: this.daNumber, client_id: id },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.agencyServiceLog + '?filter'
    );
  }
  getVendorList(id: any) {
    return this._commonService.getArrayList(
      {
        where: { daNumber: this.daNumber, clientid: id },
        method: 'get'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.vendorServiceLog + '?filter'
    );
  }

  checkallservicelog(enddate: any) {
    if (this.vendorlist && this.agencylist) {     
      const agencylistcompleted = this.getAgencylistcompleted(enddate);     
      const vendorlistcompleted = this.getVendorlistcompleted(enddate);
      this.endatecheck['validservicelog'] = (vendorlistcompleted && agencylistcompleted);
    }
  }
  getAgencylistcompleted(enddate: any) {
    const date = new Date(enddate);
    let agencylistcompleted = false;
    if (this.agencylist.length) {
      const valid = this.agencylist.some(item => {
        let actenddate;
        if (item.actual_end_date) {
          actenddate = new Date(item.actual_end_date);
          actenddate.setHours(0, 0, 0, 0);
        } else { actenddate = null; }
        if ((actenddate === null) || (item.agency_program_area_id == 'OOH' && actenddate > date)) { return true; } else { return false; }
      });
      agencylistcompleted = !valid;
    } else {
      agencylistcompleted = true;
    }
    return agencylistcompleted;
  }
  getVendorlistcompleted(enddate: any) {
    const date = new Date(enddate);
    let vendorlistcompleted = false;
    if (this.vendorlist.length) {
      const valid = this.vendorlist.some(item => {  // NOSONAR
        let actenddate;
        if (item.actual_end_date) {
          actenddate = new Date(item.actual_end_date);
          actenddate.setHours(0, 0, 0, 0);
        } else { actenddate = null; }
        if ((actenddate === null) || (item.agency_program_area_id == 'OOH' && actenddate > date)) { return true; } else { return false; }
      });
      vendorlistcompleted = !valid;
    } else {
      vendorlistcompleted = true;
    }
    return vendorlistcompleted;
  }

  getPlacementInfoList(child: any, enddate: any) {
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 10,
          method: 'get',
          where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'placement/getplacementbyservicecase?filter'
      ).subscribe((result: any) => {
        const date = new Date(enddate);
        const list = Array.isArray(result.data) ? result.data : [];
        this.endDateCheck(list, child, date);
       
      });
  }
  endDateCheck(list: any, child: any, date: any){
    if (list.length) {
      const childplacement = list.find((ele: { cjamspid: any; }) => ele.cjamspid === child.cjamspid);
      if (childplacement) {
        this.handleEndDateCheckFn(childplacement, date);
      } else {
        this.endatecheck['validplacement'] = true;
      }
    } else {
      this.endatecheck['validplacement'] = true;
    }
  }
  // Assosiated with endDateCheck method
  private handleEndDateCheckFn(childplacement: any, date: any) {
    let isPRPLpresent = true;
    const placements = Array.isArray(childplacement.placements) ? childplacement.placements?.filter((el: { placementtypekey: string; isvoided: number; }) => el?.placementtypekey === 'PRPL' && el.isvoided === 0) : [];
    if(placements && placements?.length > 0 ){
      isPRPLpresent  = placements.every((ele: { enddate: string | number | Date; routingstatus: string; }) => {
        const actenddate = (ele.enddate) ? new Date(ele.enddate) : null;
        if (actenddate) { actenddate.setHours(0, 0, 0, 0); }
        return ((actenddate !== null && actenddate <= date) && ele.routingstatus === 'Approved' )
    });
  }
    this.endatecheck['validplacement'] = isPRPLpresent;
  }
  async triggerChildRemovalUpdate() {
     $('#end-removal-check-popup').modal('hide');
     if (this.endatecheck['validservicelog'] && this.endatecheck['validplacement']) {
            this.serviceCaseNumber = null;
      const childRemovalData = this.childRemovalFormGroup.getRawValue();
      childRemovalData.isshelterauthcompleted = (this.shelterChkBox != null) ? this.shelterChkBox : 0;
      childRemovalData.isuploadedmanually = (this.isuploadedmanually != null) ? this.isuploadedmanually : 0;
      this.approvalQueueIndex = 0;
      this.approvalQueueLength = this.removedChildren.length;
      this.CHILD_REMOVAL_SUBMIT = 1;
       if (this.isCaseWorker && !this.isExitChildRemoval) {
         await this.prepareChildInfoForConfirmation();
         childRemovalData.bintiInfo = this.childInfoForConfirmation;
         this.showChildInfoConfirmModal = true;
         return;
       }
      this.submitForApprovalQueue();
    } else {
      this._alertService.error('Please complete all checklist');
    }
  }

  validateRemovalDate(removalDate: string) {
    this.maxTimeValidation = null;
    
    if(this.personRemovalHistory) {

      const currentRemoval = this.personRemovalHistory.filter(item => item.intakeservreqchildremovalid === this.childRemovalFormGroup.getRawValue().intakeservreqchildremovalid);

      if(currentRemoval.length > 0 && moment(currentRemoval[0].removaldate) < moment(removalDate) && this.removedChildren.length > 0 && this.removedChildren[0].placementList.length > 0) {
        const providerPlacementValidation = this.removedChildren[0].placementList[0].placements.filter((item: any) => item.placementtypekey === 'PRPL' && item.intakeservreqchildremovalid === this.childRemovalFormGroup.getRawValue().intakeservreqchildremovalid && moment(item.startdate).format(this.dtformat) <= moment(removalDate).format(this.dtformat))
        const providerPlacementValidationOnSameDay = this.removedChildren[0].placementList[0].placements.filter((item: any) => item.placementtypekey === 'PRPL' && item.intakeservreqchildremovalid === this.childRemovalFormGroup.getRawValue().intakeservreqchildremovalid && moment(item.startdate).format(this.dtformat) === moment(removalDate).format(this.dtformat))
        if(providerPlacementValidationOnSameDay.length > 0) {
          this.maxTimeValidation = providerPlacementValidationOnSameDay[0].starttime;
          this.childRemovalFormGroup.patchValue({
            removaltime: null
          });
          return;
        }
        if(providerPlacementValidation.length > 0) {
            this._alertService.warn('Please update the Placement start date and get it approved from supervisor before proceeding with Child Removal Start Date update');
            this.childRemovalFormGroup.patchValue({
              removaldate: moment(currentRemoval[0].removaldate)
            });
            return;
        }
      } 
      
     
    }
        
  }

  validateRemovalEndDate(removalEndDate: string) {
    const existingData = this.personRemovalHistory.filter(item => item.intakeservreqchildremovalid !== this.childRemovalFormGroup.getRawValue().intakeservreqchildremovalid);

    if(existingData.length > 0) {

      existingData.map(element => { // NOSONAR
        element.exitdate = element.exitdate ? element.exitdate : new Date();
      });

      let validateFromDate = existingData.filter(item => new Date(item.removaldate) < new Date(removalEndDate) && new Date(item.exitdate) > new Date(removalEndDate));
      const validateFromToDate = existingData.filter(item => new Date(item.removaldate) === new Date(removalEndDate) && new Date(item.exitdate) === new Date(removalEndDate));
      if(validateFromDate.length === 0) {
        const existingDataIndex = this.personRemovalHistory.findIndex(item => item.intakeservreqchildremovalid === this.childRemovalFormGroup.getRawValue().intakeservreqchildremovalid);
        validateFromDate =  (existingDataIndex !== 0 && (new Date(removalEndDate) >  new Date(existingData[0].exitdate))) ? [existingData[0]] : [];
      }
        
      if(validateFromDate.length > 0 || validateFromToDate.length > 0) {
        this._alertService.warn('The removal end date should not overlap with the existing child removal dates. Please choose some other date');
        this.childRemovalFormGroup.patchValue({
          exitdate: null
        });
      }
    }
        
  }

  openSampleForm(){
    this.sampleFormShow = !this.sampleFormShow;
  }
  closePopover(element: any) {
    element.hide();
  }
  openexitreasoninfo(){
    $('#open-location-of-infobox').modal('show');
  }
  closeinfobox(){
     $('#open-location-of-infobox').modal('hide');
  }

  getValidCirumstances(){
    let validData = false;
    const circumstances = this.childRemovalFormGroup.getRawValue().removalcircumstances;
    Object.keys(circumstances).map(function(key) {    // NOSONAR
        if(circumstances[key] !== null) {
          validData = true;
        }
    });
    if(!validData && !this.isExitChildRemoval) {
     return true;
    }
    return false;
  }
  getValidDisabilities(){
  const disabilityNotChosen = this.removedChildren.filter(child => child.hasDisability === false);

    if (!disabilityNotChosen || disabilityNotChosen.length > 0) {
     
      return true;
    }
    return false;
  }
  luggagebuttonreset(value: any){
    this.luggageupdated  = true;
    
    if (value === 1) {
      this.luggageprovided = null;
      this.luggagecomments = null;
      this.placementdisposableortrashbag =null;
    }
    if (value === 2) {
      this.luggagecomments = null;
      this.placementdisposableortrashbag =null;
    }

  }
  checkluggage() {
    if (this.childremovalluggage === null || this.childremovalluggage === undefined) {
      return true;
    } else if (this.childremovalluggage && this.childremovalluggage === true) {
      return false;
    } else if (this.childremovalluggage === false && (this.luggageprovided === null || this.luggageprovided === undefined)) {
      return true;
    } else if (this.luggageprovided && this.luggageprovided === true) {
      return false;
    }else if(this.luggageprovided === false &&(this.placementdisposableortrashbag === null || this.placementdisposableortrashbag === undefined)){
        return true;
      
    } else if (this.luggagecomments === null || this.luggagecomments === undefined) {
      return true;
    }
}

}
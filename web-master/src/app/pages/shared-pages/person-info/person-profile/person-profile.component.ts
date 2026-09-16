import {of as observableOf, Observable, Subscription, forkJoin } from 'rxjs';
import {map, mergeMap} from 'rxjs/operators';
import { Component, OnInit, OnDestroy, Renderer2, Injector, ViewChild, ChangeDetectionStrategy, ElementRef, ChangeDetectorRef } from '@angular/core';
import { Validators, FormBuilder, FormGroup, FormControl, AbstractControl, ValidationErrors, ValidatorFn} from '@angular/forms';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { DataStoreService, SessionStorageService, CommonDropdownsService, AlertService, AuthService } from '../../../../@core/services';
import moment, { Duration } from 'moment';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { PersonInfoService } from '../person-info.service';
import { PersonProfileService } from './person-profile.service';
import { AppConstants } from '../../../../@core/common/constants';
import { NavigationUtils } from '../../../_utils/navigation-utils.service';
import _ from 'lodash';
import { IntakeUtils } from '../../../_utils/intake-utils.service';
import { AppConfig } from '../../../../app.config';
import { CASE_STORE_CONSTANTS } from '../../../case-worker/_entities/caseworker.data.constants';
import { IntakeStoreConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { MatCheckboxChange } from '@angular/material/checkbox';
import { SafeResourceUrl } from '@angular/platform-browser';
import {EMPTY } from 'rxjs';
import { GlobalPopupComponent } from '../../../../shared/shared-components/global-popup/global-popup.component';
import { CaseWorkerUrlConfig } from '../../../../pages/case-worker/case-worker-url.config';
import { ActivatedRoute, Router } from '@angular/router';
import {NestedTreeControl} from '@angular/cdk/tree';
import {MatTreeNestedDataSource} from '@angular/material/tree';
import { MatInput } from '@angular/material/input';


interface dropdownNode {
  class: string;
  value: any;
  children?: dropdownNode[];
  isSelected: boolean;
}
declare var $: any;
@Component({
    selector: 'person-profile',
    templateUrl: './person-profile.component.html',
    styleUrls: ['./person-profile.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class PersonProfileComponent implements OnInit, OnDestroy {
  treeControl = new NestedTreeControl<dropdownNode> (node => node.children);
   dataSource = new MatTreeNestedDataSource<dropdownNode>(); 
   childIsSelectedList = [];
   //selections: any[] = [];
   selectionStatus: any = {}; // TODO: replace with mapping
   nodeLookup:any = {};
  @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent; 
  @ViewChild('myMatInput') myMatInput!: MatInput;
  id: string = '';
  testurl: SafeResourceUrl = 'assets/templates/tribal_id_en_version.pdf' ;
  involvedPersonFormGroup!: FormGroup;
  suggestedAddress$!: Observable<any[]>;
  maritalDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<any[]>;
  genderDropdownItems!: DropdownModel[];
  prefixDropdownItems$!: Observable<any[]>;
  suffixDropdownItems$!: Observable<any[]>;
  livingSituationDropDownItems$!: Observable<any[]>;
  livingArrangementDropDownItems$!: Observable<any[]>;
  languageTypesDropDownItems$!: Observable<any[]>;
  primaryCitizenshipDropDownItems$!: Observable<any[]>;
  nationalityDropDownItems$!: Observable<any[]>;
  ethinicityDropdownItems$!: Observable<any[]>;
  racetypeDropdownItems!: any[];
  religionDropdownItems$!: Observable<any[]>;
  akaDropdownItems$!: Observable<any[]>;
  substanceclassDropDownItems$!: Observable<any[]>;
  babysubstanceclassDropDownItems$!: Observable<any[]>;
  alienStatusDropDownItems$!: Observable<any[]>;
  sencriteriaDropDownItems$!: Observable<any[]>;
  birthinghospitalDropDownItems$!: Observable<any[]>;
  babysubstanceclassDropDown_level1$!: Observable<any[]>;
  babysubstanceclassDropDown_level2$!: Observable<any[]>;
  smartyAddress = {  disable: false, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
  householdroleDropdownItems$!: Observable<DropdownModel[]>;
  collateralroleDropdownItems$!: Observable<DropdownModel[]>;
  ROLE_ITREATION_COUNT = 0;

  imageChangedEvent!: File;
  croppedImage!: File;
  isImageHide!: boolean;
  errorValidateAddress = false;
  isBlockPersonSaveNotification = false;
  beofreImageCropeHide = false;
  afterImageCropeHide = false;
  isDefaultPhoto = true;
  isView = false;
  isImageLoadFailed = false;
  editImage = true;
  suffixTypes:any=[];
  prefixTypes:any=[];
  personAge = '';
  adoptionAge = '';
  personAgeCheck!: number;
  selectedPersonDetails: any;
  selected!: string;
  rolecount: any;
  existingRoleId: any;
  personAgeStatus: boolean = false;
  maritalStatus: boolean = false;
  senNewBorn: boolean = true;
  isRequired:boolean = false;
  isChild21:boolean = false;
  isChild18:boolean =false;
  isChildabove18:boolean =false;
  isDodChaged: boolean = false;
  isIntakeDodChanged: boolean = false;
  today = new Date();

  dd = this.today.getDate();
  mm = this.today.getMonth();
  yyyy = this.today.getFullYear();
  senHistoryFlag: string = '';
  dropdownDataNode : dropdownNode[] =[];
  minDate = new Date(1900, 0, 1);
  maxDate = new Date(this.yyyy, this.mm, this.dd);
  suggestedAddress: any = [];
  suggestedAddressOg: any = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  disableHospitalDropdown = true;
  disableSubstanceClass = true;
  enableOtherFlag = false;
  aliasList = [];
  personmaritalstatusList = [];
  personspouseaddressList = [];
  personroleList = [];
  personRole: any;
  rolesList :any= [];
  duplicateRolesListForAM = [];
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask:boolean = true;
  profileUpdateSubscription: Subscription = new Subscription;
  intakeData: any;
  iscitizen:number | null = null; //CIDM-9811 - Alien Status/Number be visible only when US Citizen is selected No
  store: any;
  SSNDuplicateFound = false;
  babySubstanceOther = false;
  errorMessage: string='';
  errorList: any[] = [];
  isClosed = false;
  dsdsactionsummary: any;
  isCPS :boolean= false;
  isServiceCase = false;
  isAdoptionCase = false;
  navigationInfo:any;
  currentStatus!: string;
  requiredPalceHolders: any = {
    'Lastname': 'Lastname',
    'Firstname': 'Firstname',
    'gendertypekey': 'Gender',
    'Dob': 'Date of Birth',
    'preadptdate': 'Previously Adoption Date',
    'preplacementguardianshipdate': 'Prior Legal Guardianship Date',
    'dangerousself': 'Danger to self ?',
    'Dangerousworker': 'Danger to worker ?',
    'ismentalimpair' : 'Appearance of mentally impaired ?',
    'ismentalillness': 'Signs of mental illness?',
    'roletype': 'In Household/Other/Collateral',
    'roles': 'Roles',
    'ismentalillnessReason' : 'Signs of mental illness reason',
    'dangerousselfreason' : 'Danger to self reason',
    'DangerousWorkerReason': 'Danger to worker reason',
    'ismentalimpairReason' : 'Appearance of mentally impaired reason',
    'arnumber' : 'Alien Registration Number',
    'astatus': 'Alien Status',
    'nationality': 'Nationality',
    'primarycitizenship' : 'Primary Citizenship',
    'drugexposedtypekey' : 'Substance Class',
    'biologicalmothermarriedsw' : 'Mother (Biological) Married at time of child\'s birth ?',
    'heightft': 'Height in Feet should be entered between 0 to 8',
    'heightin': 'Height in Inches should be entered between 0 to 11'

  };
  isGlasses = [{
    id: true,
    value: 'Yes'
  },
  {
    id: false,
    value: 'No'
  }];
  racelist: any;
  setraceunkown!: string;
  astatusChange: any;
  hairColor$!: Observable<any[]>;
  hairTexture$!: Observable<any[]>;
  eyeColor$!: Observable<any[]>;
  physicalBuild$!: Observable<any[]>;
  skinTone$!: Observable<any[]>;
  isGlass$!: Observable<any[]>;
  showOtherColor!: boolean;
  showOtherTexture!: boolean;
  isNotSexOffender = false;
  houseHold: any = [];
  isheadofhouseholdflag: boolean = false;
  userphoto: any;
  userphotoforEdit: any;
  isRaceUnknownFlag: boolean = false;
  isChildRole: boolean = false;
  isReadonly= true;
  casePersonList : any;
  isProgramAreaOoh: boolean = false;
  isCfeHomeResource: string = '';
  roleDropDownList: DropdownModel[] = [];
  showReasonInput: boolean = false;
  isSupervisor: boolean = false;
  roleId!: AppUser;
  birthMatchUpdatedOn : any;
  birthMatchStatus: any;
  resptimerrole!: string[];
  initialrespreadonly: boolean = false;
  programAsssignList: any;
  programPersonDetails: any;
  noActiveProgram!: boolean;
  caseType!: string;
  issavedisabled: boolean = false;
  dispositionreview!: any[];
  displayValidationMessages!: boolean;
  dtformat = 'YYYY-MM-DD';
  patternToValidate = '^(?!(00))[A-Za-z0-9]*$';
  notificationMsg1 = ' is added as a Active Birth Match Client in this Case.';
  getSingleApiPath = 'Usernotifications/getSingle';
  addApiPath = 'Usernotifications/Add';
  placeholderUpdated: boolean = false;
  senHistoryList: any[] = [];
  selectedReasons: string[] = [];
  selectedActions: string[] = [];
  otherReasonText: string = '';
  selectedHistoryItem: any;
  isSenRequestLoading: boolean = false;
  status: string = '';
  denyReason: string = '';
  approveAcknowledged: boolean = false;
  agencyActions: any[] = [];
  disabledFlag: boolean = true;
  showIcwaRaceModal = false;
  showIcwa60DaysModal: boolean = false;
  showIcwaNotifyUnknownModal: boolean = false;
  // Common ICWA modal state
  icwaModalType: 'race' | '60days' | 'notify_unknown' | null = null;
  icwaModalTitle: string = '';
  icwaModalMessage: string = '';
  private icwaRaceProceed = false;
  private lastClickTime = 0;
  private clickDelay = 2000;
  private previousSenState: boolean = false;
  isIntake: boolean = false;

  senchecksupervisordeny: any[] = [];
  actionChoice: any;
  private _formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _service: PersonProfileService;
  public _personInfoService: PersonInfoService;
  private _commonDropdownService: CommonDropdownsService;
  private _navigationUtils: NavigationUtils;
  private _alertService: AlertService;
  private renderer: Renderer2;
  private elementRef: ElementRef;
  private _changeDetectorRef: ChangeDetectorRef;
  private _dataStoreService: DataStoreService;
  private _intakeUtils: IntakeUtils;
  private readonly _router: Router;
  private readonly route: ActivatedRoute;
  currentUserProfile: any;
  senCriteriaOptions: any[] = [];
  substanceParentMap = new Map<string, string>();
  babysubstanceclassDropDownItemsSnapshot: { ref_key: string, description: string }[] = [];
  babysubstanceclassDropDownlevel1Snapshot: { ref_key: string, description: string }[] = [];
  substanceClassDropdownData: { ref_key: string, description: string, parentkey: string  }[] = [];
  babysubstanceclassDropDownlevel2Snapshot : { ref_key: string, description: string , parentkey: string}[] = [];
  intakeservicerequestsdm: any[] = [];
  pathwaySdm :any =  {};
  isSaveConfirmPopup: boolean = false;
  confrimMessage: string = '';
  isValuesUpdated: boolean = false;
  isConfrimPopup: boolean = true;
  readonly allowedMaritalStatusKeys = ['MR', '1570', 'SG', 'UK', 'UNMC'];
  maritalStatusInitialKey: string | null = null;
  substancelistUpdated = false;
  isOpenedIncidentDateModal: boolean = false;
  isCheckboxDisabled: boolean = false;
  firstLevelSubstanceClasses: any[] = [];
  substanceClassPlaceholderArray: any[] = [];
  substanceClassPlaceholder: string = '';
  refKeystoSave:any[] = [];
  listShown: string ='';
  hasChild = (_: number, node: dropdownNode) => !!node.children && node.children.length > 0;
  partlySelected = (node: dropdownNode) => (this.selectionStatus[node.value] == 1);
  allSelected = (node: dropdownNode) => (this.selectionStatus[node.value] == 2);
  constructor(
    private readonly injector : Injector,
    private _session: SessionStorageService,
    private _authService: AuthService) {
      this.dataSource.data = this.dropdownDataNode;
      this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._service = this.injector.get<PersonProfileService>(PersonProfileService);
      this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
      this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
      this._navigationUtils = this.injector.get<NavigationUtils>(NavigationUtils);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this.renderer = this.injector.get<Renderer2>(Renderer2);
      this.elementRef = this.injector.get<ElementRef>(ElementRef);
      this._changeDetectorRef =this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
      this._router = this.injector.get<Router>(Router);
      this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);

      this.store = this._dataStoreService.getCurrentStore();
      if (this.isEmpty(this.store)) {
        const storeInfoData: any = localStorage.getItem('storeInfo');
        this.store = this.parseData(storeInfoData);
      }
  }

  parseData(input: any): any {
    if (typeof input === 'string') {
      try {
        return JSON.parse(input);
      } catch (e: any) {
        return input;
      }
    }
    return input;
  }

  ngOnInit() {
    const activeModuleRole = this._session.getItem('activeModuleRole');
    this.treeControl.dataNodes = this.dataSource.data;
    this.buildLookup();
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly = this._authService.readonlyButton('read_only_access','add-edit-person');}
    this.roleId = this._authService.getCurrentUser();
    this.isSupervisor = (this.roleId && this.roleId.role && this.roleId.role.name === 'apcs') ? true : false;
    this.currentStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
    this.viewPerson();
    this.isClosed = this._authService.iscaseclosed('personprofile');
    this._personInfoService.aliasList = [];
    this._personInfoService.getIntakeNumberByServiceCaseID().subscribe(data => {
      if (data && data.length) {
        this.intakeData = data[0];
      }
    });
    this.initiateFormGroup();
    this.updateIdAndIntake();

    this.imageChangedEvent = Object.assign({});
    this.loadDropDown();
    this.loadDropdownItems();
    this.suffixTypes = ['Jr', 'Sr'];
    this.prefixTypes = ['Mr', 'Mrs', 'Ms', 'Dr', 'Prof', 'Sister', 'Atty'];
    this.dobChangeListener();
    this.preadptdateChangeListener();
    this.profileUpdateListener();
    this.setupChangeSubscribers();
    this.getdispositionhist();
    this.involvedPersonFormGroup?.get('citizenalenageflag')?.valueChanges.subscribe((changeFlag: any) => {
        this.iscitizen = changeFlag;
        if (this.iscitizen === 1) {
          this.ifIsCitizen1Fn();
        } else if (this.iscitizen === 0) {
          this.ifIsCitizen0Fn();
        }
      }
    );
    this.involvedPersonFormGroup?.get('astatus')?.valueChanges.subscribe((astatusChange: any) => {
        this.astatusChangeConditionFn(astatusChange);
      }
    );
    if (this.selectedPersonDetails?.personbasicdetails?.personid &&
      this.selectedPersonDetails?.personbasicdetails?.sencriteria) {
      this.loadSenHistory(this.selectedPersonDetails?.personbasicdetails?.personid);
    }
    this._authService.setIntakeReadOnly([this.involvedPersonFormGroup]);
    const tempDsdsActionsSummary = this._dataStoreService.getData('dsdsActionsSummary')
    this.caseType = tempDsdsActionsSummary?tempDsdsActionsSummary.da_subtype:null;
    this.updateCheckboxState();
    this.getHospitalList(); 
  }
  
  updateCheckboxState(): void {
    this.isCheckboxDisabled =
      this.senHistoryFlag?.trim() === 'Historic' ||
      this.personAgeCheck > 65;
      const historyList: any = this.isCheckboxDisabled || (this.senHistoryList?.length > 0 && this.senHistoryList[0]?.approval_status === 'Pending');
      const flagControl: any = this.involvedPersonFormGroup.get('substanceexposednewbornflag');
      const classControl: any = this.involvedPersonFormGroup.get('substanceclasses');
      if (this.isCheckboxDisabled) {
        flagControl?.disable({ emitEvent: false });
        classControl?.disable({ emitEvent: false });
      } else {
        if(historyList) {
          flagControl?.disable({ emitEvent: false });
        } else {
          flagControl?.enable({ emitEvent: false });
        }
        classControl?.enable({ emitEvent: false });
      }
      if(this.senHistoryFlag?.trim() === 'Active'){
        this.involvedPersonFormGroup.controls['sencriteria'].setValidators(Validators.required);
        this.involvedPersonFormGroup.controls['birthinghospital'].setValidators(Validators.required);
      }
  }

  buildLookup() {
    for (let child of this.dropdownDataNode) {
      this.buildNodeLookup(child);
    }
  }

  buildNodeLookup(node: dropdownNode) {
    this.nodeLookup[node.value] = node;
    if (node.children && node.children.length) {
      for (let child of node.children) {
        this.buildNodeLookup(child);
      }
    }
  }

  getSelectedCriteriaDescription() {
    const selectedKey = this.involvedPersonFormGroup.get('sencriteria')?.value; 
    var criteriaDesc = '';   
    this.sencriteriaDropDownItems$.subscribe(data => {
      const criteriaData = data;
      criteriaDesc = criteriaData.find(item=>item.ref_key===selectedKey)?.description || '';      
    });
    return criteriaDesc; 
  }

  selectionToggle(isChecked: any, node: dropdownNode) {
    let newValue = isChecked? 2: 0;
    this.selectionStatus[node.value] = newValue;
    if (node.children && node.children.length) {
      for (let child of node.children) {
        this.selectionToggle(isChecked, child);
      }
    }
    this.substancelistUpdated = true;
    // update the status of all nodes' selection
    this.updateSelectionStatus(node);
    
    const subControl: any = this.involvedPersonFormGroup.get('substanceclasses');
    subControl?.setValue(this.refKeystoSave.length > 0 ? this.refKeystoSave : null);
    subControl?.markAsTouched(); 
    subControl?.updateValueAndValidity();
    this.involvedPersonFormGroup.markAsDirty();
  }

  filterTree(word:any) {
    let newData = []
    for (let child of this.dropdownDataNode) {
      let result = this.filterNode(child, word, false);
      if (result) newData.push(result);
    }
    return newData;
  }

  filterNode(node:dropdownNode, word:any, selectAll:any){   
    let newNode:dropdownNode = {
      class: node.class,
      value: node.value,
      isSelected: node.isSelected,
      children: []
    }
    let nodeHit = newNode.value.toLowerCase().includes(word) || selectAll;
    if (node.children && node.children.length) {
      for (let child of node.children) {
        let subtree = this.filterNode(child, word, nodeHit);
        if (subtree!== null) {
          newNode.children?.push(subtree);
        }
      }
    }
    if (nodeHit || (newNode.children && newNode.children.length >0)) {
      return newNode;
    }
    return null;
  }

  syncTreeWithSavedData(savedSubstanceClasses: string[]) {
    const traverse = (nodes: any[]) => {
      nodes.forEach(node => {
       if (savedSubstanceClasses.includes(node.class)) {
          this.selectionStatus[node.value] = 2;  
           this.expandPath(node);
        }
        if (node.children && node.children.length > 0) {
          traverse(node.children);
        }
      });
    };
    traverse(this.dataSource.data);
  }

  expandPath(targetNode: any) {
    const findAndExpand = (nodes: any[]): boolean => {
      for (const node of nodes) {
        if (node === targetNode) return true;
        if (node.children && findAndExpand(node.children)) {
          this.treeControl.expand(node);
          return true;
        }
      }
      return false;
    };
    findAndExpand(this.dataSource.data);
  }

  updateSelectionStatus(node:dropdownNode) {
    for (let child of this.dropdownDataNode) { 
      this.setSelectionStatus(child);
    }
    let currentSelection = [];   
    this.enableOtherFlag = false; 
    for (let key in this.selectionStatus) {
      if (this.selectionStatus[key] > 0) {
        currentSelection.push(key);
        if(key == 'Other Drug/Substance'){
          this.enableOtherFlag = true;
          this.involvedPersonFormGroup.get('othersubstances')?.enable();
        }        
      }
    }
    if(this.selectionStatus[node.value]!=0){
      this.refKeystoSave.push(node.class);
    }else{
      this.refKeystoSave = this.refKeystoSave.filter(item=> item != node.class);
    }
    this.getSubstanceClassPlaceholder(node.class,node.value);     
    this.placeholderUpdated = true;
  }  

  getSubstanceClassPlaceholder(classkey: any,classvalue: string){
    //placeholder to print the selected substances
    var level2desc:any,level3desc:any, totalPlaceholder: any = '';
    if(this.getValueBykey(classkey)){
      level2desc = this.substanceClassDropdownData.filter(item => item.ref_key === this.getValueBykey(classkey));
      if(this.getValueBykey(level2desc[0].ref_key)){
        level3desc = this.substanceClassDropdownData.filter(item => item.ref_key === this.getValueBykey(level2desc[0].ref_key));
        totalPlaceholder = level3desc[0].description;
      }
      totalPlaceholder = totalPlaceholder + '('+ level2desc[0].description + '(' + classvalue + '))';
      if(this.selectionStatus[classvalue]!=0){
        this.substanceClassPlaceholderArray.push(totalPlaceholder);
      }else{
        this.substanceClassPlaceholderArray = this.substanceClassPlaceholderArray.filter(item => item!=totalPlaceholder);
      }
    }else if(classkey=='OTDS'){
      if(this.selectionStatus[classvalue]!=0){
      this.substanceClassPlaceholderArray.push('Other Drug/Substance');
      }else{
        this.substanceClassPlaceholderArray = this.substanceClassPlaceholderArray.filter(item => item!='Other Drug/Substance');
      }
    }
    this.substanceClassPlaceholder = '';
    this.substanceClassPlaceholderArray.forEach(val=>{
      if(this.substanceClassPlaceholder){
        this.substanceClassPlaceholder = this.substanceClassPlaceholder + ', ' + val;
      }else{
        this.substanceClassPlaceholder = val;
      }      
    });
    this.updatePlaceholder(this.substanceClassPlaceholder);
  }

  updatePlaceholder(newValue: string) {
    this.substanceClassPlaceholder = newValue;
    if (this.elementRef) {
      this.renderer.setProperty(this.elementRef.nativeElement, 'placeholder', newValue);
    }    
  }

  buildSubstanceClassPlaceholder(classnames : string[]){
    classnames.forEach(val =>{
      var subclass = this.babysubstanceclassDropDownlevel2Snapshot.filter(item => item.ref_key === val)[0];
      this.getSubstanceClassPlaceholder(val,subclass?.description);
    });
  }

  getValueBykey(searchValue: any){ //refkey of the node
    var parent = ''; 
    const myArr = Array.from(this.substanceParentMap.entries());
    for (let [key, value] of myArr) {
      if (key === searchValue) 
      parent = value;
    }
    return parent;
  }

  setSelectionStatus(node:any) {
    let allSelected = true;
    let partlySelected = false;
    if (node.children && node.children.length) {
      for (let child of node.children) {
        let status:any = this.setSelectionStatus(child);
        allSelected = allSelected && status[0]; 
        partlySelected = partlySelected || status[1]
      }
    } else { // for leaf nodes
      allSelected = partlySelected = this.selectionStatus[node.value] > 0; 
    }
    this.selectionStatus[node.value] = Number(allSelected) + Number(partlySelected);
    return [allSelected, partlySelected];
  }

  filterChanged(event:any) {
    let newData = this.filterTree(event.target.value);
    console.log('newData: ', newData)
    console.log('dataNodes: ', this.treeControl.dataNodes);
    this.dataSource.data = newData;
    this.treeControl.dataNodes = this.dataSource.data;
    console.log('treeControl: ', this.treeControl);
    this.treeControl.expandAll();
  }

  updateIdAndIntake() : void {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if(this.id === undefined){
      const idData: any = localStorage.getItem('CASE_UID');
      this.id = this.parseData(idData);
    }
    
    this.casePersonList = this._dataStoreService.getData('PERSONINVOLVEDLIST');
    let dataStore = this.updateDataStore();
    const intakeserviceid = dataStore ? dataStore.intakeserviceid : '';
    if (this.id === undefined) {
        this.id = intakeserviceid;
        this.isIntake = true;
    }
  }

  updateDataStore()  {
    let dataStore: any = this._dataStoreService.getData('dsdsActionsSummary');
    if (this.isEmpty(dataStore)) {
      const dsdsActionsSummaryData: any = localStorage.getItem('dsdsActionsSummary');
      dataStore = this.parseData(dsdsActionsSummaryData);
    }
    this.dsdsactionsummary = dataStore;
    return dataStore;
  }

  isEmpty(dataStore: any) {
    // Null or undefined
    if (dataStore == null) return true;
  
    // String or Array (length === 0)
    if (typeof dataStore === 'string' || Array.isArray(dataStore)) {
      return dataStore.length === 0;
    }
  
    // Object (no own properties)
    if (typeof dataStore === 'object') {
      return Object.keys(dataStore).length === 0;
    }
  
    // All other types (number, boolean, function, etc.) are not considered empty
    return false;
  }

  getintakeservicerequestsdm() {
    if (this.updateDataStore()?.intakeserviceid) {
    this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
            where: {  servicerequestid: this.updateDataStore()?.intakeserviceid },
              method: 'get',
              nolimit: true
          }),
          NewUrlConfig.EndPoint.Intake.IntakeSdmListUrl      )
      .subscribe((programResult: any) => {
        this.intakeservicerequestsdm = programResult;
        const isReviewExist = this.intakeservicerequestsdm[0]?.getintakeservicerequestsdm?.filter((item: any) => (item.pathwaystatus === "Review"));
        const isRoleTypeExist = this.selectedPersonDetails?.personbasicdetails?.personrole?.Personroletype?.filter(
          (item: any) => ["AV", "CHILD", "OTHERCHILD"].includes(item.roletype));
        if (isReviewExist.length) {
          this.isSaveConfirmPopup = false; // checking if review is exist then should not show save confirm popup
        }
          const personId = this.selectedPersonDetails?.personbasicdetails?.personid;
          this.getProgramAssignmentList(personId, isRoleTypeExist, isReviewExist); // checking if AR is exist then show psave confirm popup
      });
    }
  }
  saveIntakeservicerequestsdm() {
    const sdm = this.intakeservicerequestsdm[0]?.getintakeservicerequestsdm.filter((item: any) => (item.pathwaystatus === "Accepted"))
    const i = sdm.reduce((latestIdx: any, current: any, idx: any, arr: any) => {
      return new Date(current.insertedon) > new Date(arr[latestIdx].insertedon) ? idx : latestIdx;
    }, 0);
    if (sdm.length) {
      sdm[i].childfatality = 'yes';
      sdm[i].ischildfatality = true;
      sdm[i].cpsResponseType = "CPS-IR";
      sdm[i].isir = true;
      sdm[i].isar = false;
      sdm[i].reasonforchange = "101";
      sdm[i].comments = "A mandatory pathway change was initiated after a date of death was entered for a child. Child fatalities are ineligible for Alternative Response";
      this.saveSdmPathway(sdm[i]).pipe(
        mergeMap(() => {
          this.confrimMessage = "Sdm pathway changes sent for approval.";
          this.isConfrimPopup = false;
          this.globalPopupRef.openConfirmationModal();
          return EMPTY;
        }))
        .subscribe((data) => {
          //No operation needed here
        });
    }
  }
  saveSdmPathway(sdm: any) {
    sdm.reportdate = null;
    this.pathwaySdm.sdmdata = Object.assign({}, sdm);
    this.pathwaySdm.intakenumber = null;
    this.pathwaySdm.servicerequestid = this.id;
    return this._commonHttpService.create(this.pathwaySdm, 'Intakeservicerequestsdm/createsdm');
  }
  loadDropdownItems() {
    forkJoin([
      this._commonDropdownService.getPickListByName('sencheck'),
      this._commonDropdownService.getPickListByName('sencheckagencyactions'),
      this._commonDropdownService.getPickListByName('senchecksupervisordeny')
    ]).subscribe(([sencheck, sencheckagencyactions, senchecksupervisordenyopts]) => {
      this.senCriteriaOptions = sencheck;
      this.agencyActions = sencheckagencyactions;
      this.senchecksupervisordeny = senchecksupervisordenyopts;
      this.populateSenDetails();
    });
  }
  openApprovePopup() {
    if (this.actionChoice === 'accept') {
      $('#approve-confirmation').modal('show');
    } else {
     this.confirmApprove();
     this.submitSENRequest(false, 'Deny');
    }
  }

  confirmApprove() {
    $('#approve-confirmation').modal('hide');
    // Proceed with approval logic here
  }

  // Associated to ngOnInit function
  private astatusChangeConditionFn(astatusChange: any) {
    if (astatusChange === 'ILLAEN') {
      this.involvedPersonFormGroup?.get('arnumber')?.reset();
      this.involvedPersonFormGroup?.get('arnumber')?.disable();
      this.involvedPersonFormGroup.controls['arnumber']?.clearValidators();
      this.involvedPersonFormGroup.controls['arnumber']?.updateValueAndValidity();
      this.isRequired = false;
    } else if (astatusChange !== 'ILLAEN') {
      this.involvedPersonFormGroup?.get('arnumber')?.enable();
      this.involvedPersonFormGroup.controls['arnumber'].setValidators(Validators.required);
      this.involvedPersonFormGroup.controls['arnumber'].setValidators(Validators.pattern(this.patternToValidate));
      this.involvedPersonFormGroup.controls['arnumber'].updateValueAndValidity();
      this.isRequired = true;
    } else {
      this.involvedPersonFormGroup.controls['arnumber'].clearValidators();
      this.involvedPersonFormGroup.controls['arnumber'].setValidators(Validators.pattern(this.patternToValidate));
      this.involvedPersonFormGroup.controls['arnumber'].updateValueAndValidity();
      this.isRequired = false;
    }
  }
  // Associated to ngOnInit function
  private ifIsCitizen0Fn() {
    this.involvedPersonFormGroup?.get('primarycitizenship')?.enable();
    this.involvedPersonFormGroup.controls['primarycitizenship'].setValidators(Validators.required);
    this.involvedPersonFormGroup.controls['primarycitizenship'].updateValueAndValidity();
    this.involvedPersonFormGroup.controls['nationality'].setValidators(Validators.required);
    this.involvedPersonFormGroup.controls['nationality'].updateValueAndValidity();
    //commented for CDM-762 Defect
    //this.involvedPersonFormGroup.controls['astatus'].setValidators(Validators.required);
    //this.involvedPersonFormGroup.controls['astatus'].updateValueAndValidity();
    if (this.selectedPersonDetails?.personbasicdetails) {
      this.checkIfPersonbasicdetailsFn();
    }
  }
  // Associated to ngOnInit function
  private checkIfPersonbasicdetailsFn() {
    if (this.selectedPersonDetails.personbasicdetails.citizenalenageflag === 0) {
      this.involvedPersonFormGroup.patchValue({
        primarycitizenship: this.selectedPersonDetails.personbasicdetails.primarycitizenship ? this.selectedPersonDetails.personbasicdetails.primarycitizenship : null,
        nationality: this.selectedPersonDetails.personbasicdetails.nationalitytypekey ? this.selectedPersonDetails.personbasicdetails.nationalitytypekey : null,
        secondarycitizenship: this.selectedPersonDetails.personbasicdetails.secondarycitizenship ? this.selectedPersonDetails.personbasicdetails.secondarycitizenship : null,
        astatus: this.selectedPersonDetails.personbasicdetails.alienstatustypekey ? this.selectedPersonDetails.personbasicdetails.alienstatustypekey : null,
        arnumber: this.selectedPersonDetails.personbasicdetails.alienregistrationtext ? this.selectedPersonDetails.personbasicdetails.alienregistrationtext : null,
      });
    } else {
      this.involvedPersonFormGroup.controls['primarycitizenship'].clearValidators();
      this.involvedPersonFormGroup.controls['primarycitizenship'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['nationality'].clearValidators();
      this.involvedPersonFormGroup.controls['nationality'].updateValueAndValidity();
      //commented for CDM-762 Defect
      //this.involvedPersonFormGroup.controls['astatus'].clearValidators();
      //this.involvedPersonFormGroup.controls['astatus'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['arnumber'].clearValidators();
      this.involvedPersonFormGroup.controls['arnumber'].setValidators(Validators.pattern(this.patternToValidate));
      this.involvedPersonFormGroup.controls['arnumber'].updateValueAndValidity();
      this.involvedPersonFormGroup.patchValue({
        primarycitizenship: null,
        nationality: null,
        secondarycitizenship: null,
        astatus: null,
        arnumber: null,
      });
    }
  }

  // Associated to ngOnInit function
  private ifIsCitizen1Fn() {
    this.involvedPersonFormGroup.patchValue({
      primarycitizenship: 'USA'
    });
    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails.nationalitytypekey) {
      this.involvedPersonFormGroup.patchValue({
        nationality: this.selectedPersonDetails.personbasicdetails.nationalitytypekey
      });
    } else {
      this.involvedPersonFormGroup.patchValue({
        nationality: 'American'
      });
    }
    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails.secondarycitizenship) {
      if (this.selectedPersonDetails.personbasicdetails.citizenalenageflag === 1) {
        this.involvedPersonFormGroup.patchValue({
          secondarycitizenship: this.selectedPersonDetails.personbasicdetails.secondarycitizenship ? this.selectedPersonDetails.personbasicdetails.secondarycitizenship : null
        });
      } else {
        this.involvedPersonFormGroup.patchValue({
          secondarycitizenship: null
        });
      }
    } else {
      this.involvedPersonFormGroup.patchValue({
        secondarycitizenship: null
      });
    }
    this.involvedPersonFormGroup.controls['primarycitizenship'].clearValidators();
    this.involvedPersonFormGroup.controls['primarycitizenship'].updateValueAndValidity();
    this.involvedPersonFormGroup.controls['nationality'].clearValidators();
    this.involvedPersonFormGroup.controls['nationality'].updateValueAndValidity();
    //commented for CDM-762 Defect
    //this.involvedPersonFormGroup.controls['astatus'].clearValidators();
    //this.involvedPersonFormGroup.controls['astatus'].updateValueAndValidity();
    this.involvedPersonFormGroup.controls['arnumber'].clearValidators();
    this.involvedPersonFormGroup.controls['arnumber'].setValidators(Validators.pattern(this.patternToValidate));
    this.involvedPersonFormGroup.controls['arnumber'].updateValueAndValidity();
    this.involvedPersonFormGroup?.get('primarycitizenship')?.disable();
  }

  openPdfInNewTab(): void {
    window.open('assets/templates/tribal_id_en_version.pdf', '_blank');
  }


  viewPerson() {
    const navigationinf:any =localStorage?.getItem('navigationInfo')
    const personinfo = this._dataStoreService.getObj('PERSON_NAVIGATION_INFO') ? this._dataStoreService.getObj('PERSON_NAVIGATION_INFO') :JSON.parse(navigationinf);
    const isCfeHomeDetails  =  this._dataStoreService.getData('person_cfetooltip');
    const activeModuleRole = this._session.getItem('activeModuleRole');
    if (personinfo?.action === 'VIEW' || activeModuleRole == 'Medical Specialist') {
      this.isView = true;
      if(isCfeHomeDetails) {
        this.isCfeHomeResource = isCfeHomeDetails;
      }
    } else {
      this.isView = false;
    }
    this.isProgramAreaOoh = !!personinfo?.data?.isProgramAreaOoh
    this._session.setItem('isView', this.isView);
  }

  dobchange() {
    if (this.senNewBorn) {
      this.involvedPersonFormGroup.patchValue({
        drugexposednewbornflag: null,
        drugexposedtypekey: '',
      });
    }
    this.involvedPersonFormGroup.patchValue({
      safehavenbabyflag: null,
      maritalstatustypekey: null
      });
  this.involvedPersonFormGroup.get('maritalstatustypekey')?.updateValueAndValidity();
  }

  toggleSsn = () => {
    this.isSsnHidden = !this.isSsnHidden;
    if (this.isSsnHidden) {
      this.ssnEye = 'fa-eye';
      this.showSsnMask = true;
    } else {
      this.ssnEye = 'fa-eye-slash';
      this.showSsnMask = false;
    }
  }

  get f() {
    return this.involvedPersonFormGroup.controls;
  }

  getPlacHolderName(key:any) {
    if (this.requiredPalceHolders.hasOwnProperty(key)) {
      return this.requiredPalceHolders[key];
    } else {
      return key;
    }
  }

  // Firstname get input control value
  get inputControlFirstname() {
    return this.involvedPersonFormGroup?.get('Firstname');
  }

    // Middlename get input control value
    get inputControlMiddlename() {
    return this.involvedPersonFormGroup?.get('Middlename');
  }

    // Lastname get input control value
    get inputControlLastname() {
    return this.involvedPersonFormGroup?.get('Lastname');
  }

  private initiateFormGroup() {
    this.involvedPersonFormGroup = this._formBuilder.group({
      Lastname: ['', [Validators.required, Validators.pattern('^([A-Za-z]*[\-\'\ \-]{0,1}[A-Za-z])+$')] ],
      Firstname: ['', [Validators.required, Validators.pattern('^([A-Za-z]*[\-\'\ \-]{0,1}[A-Za-z])+$')] ],
      Middlename: ['',  Validators.pattern('^([A-Za-z]*[\-\'\ \-]{0,1}[A-Za-z])+$')],
      prefix: [''],
      nameSuffix: [''],
       primarylanguage: ['', Validators.required],
      secondarylanguage: [null],
      Dob: [Validators.required],
      dateofdeath: [null],
      isapproxdod: [null],
      isapproxdob: [null],
      isdobunknown: [null],
      safehavenbabyflag: [{value: null, disabled: this.personAgeCheck > 65}],
      everbeenadoptedflag: [{ value: '', disabled: !this.isChild18 }],
      intercountryadoption: [{ value: null, disabled: !this.isChild18 }],
      priorlegalguardianship: [{ value: null, disabled: !this.isChild18 }],
      cferesourcehomechild:[null],
      age: [null],
      gendertypekey: ['', Validators.required],
      othergendertypekey:[null],
      religiontypekey: null,
      // maritalstatustypekeyold: [null],
      maritalstatustypekey: [null, this.maritalStatus ? Validators.required : null],
      // race: [null],
      SSN: [''],
      ssnverified: [{ value: null, disabled: true }],
      mdm_id: [null],
      actorid: [null],
      intakeservicerequestid: [null],
      ethnicgrouptypekey: [null],
      occupation: [null],
      stateid: [null,[Validators.pattern('^([A-Za-z0-9]*[-]*[A-Za-z0-9])*$')]],
      // aliasname: [null],
      source: [null],
      potentialSOR: [''],
      eDLHistory: [''],
      dMH: [''],
      Race: [[]],
      Address: [''],
      address1: [''],
      Zip: [''],
      City: [''],
      State: [null],
      County: [null],

      DangerousAddressReason: [''],
      tribalassociation: [null],
      icwastatusinquiry: [null],
      icwanotify: [null],
      icwaeligibleformembership: [{ value: null, disabled: true }],
      icwatribename: [{value: null, disabled: true}],
      icwaunderdefinition: [null],
      icwanotification: [null],
      icwatribelegalnotice: [null],
      height: [null],
      heightft: new FormControl(null, [Validators.pattern('^([0-8]|0[8])$')]) ,
      heightin: new FormControl(null, [Validators.pattern('^([0-9]|1[011])$')]) ,
      weight: [null],
      weightpnd:  new FormControl(null, [Validators.pattern('^[0-9]*$')]) ,
      weightound:  new FormControl(null, [Validators.pattern('^[0-9]*$')]) ,
      tattoo: [''],
      haircolortypekey: [''],
      hairtexturetypekey: [''],
      eyecolortypekey: [''],
      physicalbuildtypekey: [''],
      skintonetypekey: [''],
      hairtextureotherdesc: [''],
      haircolorotherdesc: [''],
      isglasses: [null],
      PhyMark: [''],
      dangerousselfreason: [''],
      ismentalimpairReason: [''],
      DangerousWorkerReason: [''],
      ismentalillnessReason: [''],
      dangerousself: [null],
      Dangerousworker: [null],
      ismentalimpair: [null],
      ismentalillness: [null],
      // mentalimpairdetail: [''],
      // mentalillnessdetail: [''],
      personid: [null],
      //  iscollateralcontact: [null],
      //  ishousehold: [null],
      roletype: [null, [Validators.required]],
      drugexposednewbornflag: [null],
      // fetalalcoholspctrmdisordflag: [false],
      sexoffenderregisteredflag: [{ value: null, disabled: this.isNotSexOffender }],
      probationsearchconductedflag: [null],
      otherdrugs: [''],
      drugexposedtypekey: [''],
      needs: [null],
      strengths: [null],
      livingsituationkey: [null],
      licensedfacilitykey: [null],
      otherlicensedfacility: [null],
      livingsituationdesc: [null],
      livingarrangementkey: new FormControl({ value: null, disabled: true }),
      livingarrangementdesc: new FormControl({ value: null, disabled: true }) ,
      otherreligion: [null],
      alienregistrationtext: [null],
      alienstatustypekey: [null],
      citizenalenageflag: [null],
      isqualifiedalien: [null],
      verificationremarks: [null],
      // issafehaven: [false]
      primarycitizenship: [null],
      secondarycitizenship: [null],
      nationality: [null],
      astatus: [null],
      arnumber: [null, [Validators.pattern(this.patternToValidate)]],
      householdflag: [null],
      // role: '',
      roles: [null],
      spouseaddress1: [null],
      spouseAddress2: [null],
      spousecity: [null],
      spousestate: [null],
      spousezipcode: [null],
      spousecounty: [null],
      spousehomenumber: [null],
      spouseofficenumber: [null],
      spouseofficeextension: [null],
      spouseprefix: [null],
      spousefirstname: [null],
      spouselastname: [null],
      spousemiddlename: [null],
      spousesuffix: [null],
      numberofchildren: [null],
      maritalcomments: [null],
      maritalstartdate: [null],
      maritalenddate: [null],
      marriageplace: [null],
      divorceplace: [null],
      aname: false,
      preadptdate: [],
      preplacementguardianshipdate: [],
      userphoto: [''],
      // primaryrole: [null]
      // nname: false,
      // cname: false,
      // mname: false
      employername: [''],
      clienttitle: [''],
      isheadofhousehold: false,
      biologicalmothermarriedsw: [null],
      clientflag: [null],
      birthmatchflag: [null],
      notificationdate: [null],
      birthmatchupdateflag: [null],
      deselectreason: [null],
      substanceexposednewbornflag: [null],
       needtranslatorinterpreter: [null],
      substanceexposednewbornsourceid: [null],
      substanceexposednewbornsourcetypekey: [null],
      substanceexposednewborntimetamp: [null],
      sencriteria: [null],
      birthinghospital: [null],
      substanceclasses: [[], [Validators.required]],
      othersubstances: [null],
      initialresponse :[null],
      initialresponseupdatedby :[null],
      initialresponseupdatedon: [null],
      limitedenglishproficiency: [false],
      readingproficiency: [false],
      writingproficiency: [false],
      speakingproficiency: [false]
    },
      { validators: this.lepProficiencyValidator() }
    );

    this.involvedPersonFormGroup?.get('gendertypekey')?.valueChanges.subscribe((value: any)=> {
      if(value === 'O') {

        this.involvedPersonFormGroup?.get('othergendertypekey')?.setValidators([Validators.required]);
        this.involvedPersonFormGroup?.get('othergendertypekey')?.updateValueAndValidity()

      } else {
        this.involvedPersonFormGroup.get('othergendertypekey')?.patchValue(null);
        this.involvedPersonFormGroup.get('othergendertypekey')?.clearValidators()
        this.involvedPersonFormGroup.get('othergendertypekey')?.updateValueAndValidity()
      }
    })
            this.involvedPersonFormGroup.get('limitedenglishproficiency')?.valueChanges.subscribe((lep: boolean) => {
      if (!lep) {
        this.involvedPersonFormGroup.patchValue({
          readingproficiency: false,
          writingproficiency: false,
          speakingproficiency: false,
        }, { emitEvent: false });

        this.involvedPersonFormGroup.updateValueAndValidity();
      }
    });
    let search_details = this._personInfoService.getSearchData();
    if (search_details && search_details.exist === 1) {
      const quickPersonCheck = this._dataStoreService.getData('QUICK_PERSON_ID');
      if(quickPersonCheck) {
        search_details = this.handleIfQuickPersonCheckFn(quickPersonCheck, search_details);
      }
      this.updateProfileViewfromSearch(search_details);
    }
  }

  get isPriorGuardianshipRequired() {
    return this.involvedPersonFormGroup.controls['priorlegalguardianship'].value === 1 && this.isChild18;
  }
  
  // Assosiated with initiateFormGroup method
  private handleIfQuickPersonCheckFn(quickPersonCheck: any, search_details: any) {
    const roleType = quickPersonCheck.quickpersonroleconfig;
    const roles :any= [];
    if (roleType) {
      roleType.forEach((element:any )=> {
        roles.push(element.actortypekey);
      });
      this.involvedPersonFormGroup.patchValue({
        roletype: 'household',
        roles: roles
      });
    }
    const subsExposed = quickPersonCheck.quickpersonsubstconfig;
    const substancecategoryRoles :any= [];
    if (subsExposed) {
      subsExposed.forEach((element :any)=> {
        substancecategoryRoles.push(element.substanceclasskey);
      });
      this.involvedPersonFormGroup.patchValue({
        drugexposednewbornflag: true,
        drugexposedtypekey: substancecategoryRoles
      });
      search_details.drugexposednewbornflag = this.involvedPersonFormGroup.value.drugexposednewbornflag === true ? 1 : 0;
      search_details.drugexposedtypekey = this.involvedPersonFormGroup.value.drugexposedtypekey;
    }

    return search_details;
  }

  // Associated to initiateFormGroup function
  private returnisChild18Fn(): any {
    return this.isChild18 ? Validators.required : null;
  }

  showLegacyStatusAlert() {
    $('#legacy-marital-status-alert').modal('show');
  }
  
  closeLegacyStatusAlert() {
    $('#legacy-marital-status-alert').modal('hide');
  }

  loadSenHistory(personId: string) {
    if (!personId) {
      this.senHistoryList = [];
      return;
    }
    this.currentUserProfile = this._authService.getCurrentUser();
    this._personInfoService.getSENHistoryByPersonId(personId).subscribe(
      (response) => {
        if (response.success) {
          this.senHistoryList = response.data || [];
          this.patchSenHistory();
          if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails?.senstatusflag == 1) {
            this.senHistoryFlag = 'Active ';
          } else if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails?.senstatusflag == 0) {
            this.senHistoryFlag = 'Historic ';
          }
          this.updateCheckboxState();
          const criteriaControl = this.involvedPersonFormGroup.get('sencriteria');
          const birthinghospitalControl = this.involvedPersonFormGroup.get('birthinghospital');
          if (this.senHistoryFlag?.trim() === 'Historic') {
            criteriaControl?.disable();
            birthinghospitalControl?.disable();
          } else {
            criteriaControl?.enable();
            birthinghospitalControl?.enable();
          }
        } else {
          this._alertService.warn('Failed to load SEN history');
          this.senHistoryList = [];
        }
      },
      (error) => {
        console.error('Error loading SEN history:', error);
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        this.senHistoryList = [];
      }
    );
  }

  patchSenHistory(){
    if (this.senHistoryList.length > 0) {
      this.selectedHistoryItem = this.senHistoryList[0];
      this.isIntake = false;
      if (this.selectedHistoryItem.approval_status === 'Pending') {
        this.involvedPersonFormGroup.patchValue({
          substanceexposednewbornflag: 0
        });
       this.populateSenDetails();
      }
    }
  }
  populateSenDetails() {
    if (this.selectedHistoryItem && this.currentUserProfile && this.currentUserProfile.user && this.isSupervisor && (this.selectedHistoryItem.parentteamid === this.currentUserProfile.user.userprofile?.teammemberassignment?.teammember?.team?.parentteamid)){
      this.selectedHistoryItem.reasonDesc = [];
      this.selectedHistoryItem.actionDesc = [];
      if (this.selectedHistoryItem.reasons && this.selectedHistoryItem.reasons.length > 0 && this.senCriteriaOptions && this.senCriteriaOptions.length > 0) {
        this.selectedHistoryItem.reasons.forEach((element: any) => {
          this.selectedHistoryItem.reasonDesc.push(this.senCriteriaOptions.find((e: any) => e.ref_key == element).description);
        });
      }
      if (this.selectedHistoryItem.actions && this.selectedHistoryItem.actions.length > 0 && this.agencyActions && this.agencyActions.length > 0) {
        this.selectedHistoryItem.actions.forEach((element: any) => {
          this.selectedHistoryItem.actionDesc.push(this.agencyActions.find((e: any) => e.ref_key == element).description);
        });
      }
      this.selectedHistoryItem.fullname = [
        this.selectedPersonDetails.personbasicdetails.firstname,
        this.selectedPersonDetails.personbasicdetails.middlename,
        this.selectedPersonDetails.personbasicdetails.lastname
      ].filter(Boolean).join(' ');
      this.openDescionScreen();
    }
  }
  openDescionScreen() {
    $('#descion-screen').modal('show');
  }

  substanceexposednewbornflagChanged(event: MatCheckboxChange) {
    if (!event.checked) {
      this.previousSenState = true;

      if (!this.isIntake && this.selectedPersonDetails?.personbasicdetails?.substanceexposednewbornflag === 1) {
       this.openSenRemovalModal();
      }
      this.involvedPersonFormGroup.controls['birthinghospital']?.reset(null);
      this.involvedPersonFormGroup.controls['sencriteria']?.reset(null);
      this.involvedPersonFormGroup.controls['sencriteria']?.clearValidators();
      this.involvedPersonFormGroup.controls['birthinghospital']?.clearValidators();
      if(this.selectedPersonDetails?.personbasicdetails && this.selectedPersonDetails.personbasicdetails.birthinghospital) { 
        this.selectedPersonDetails.personbasicdetails.birthinghospital = null
        this.selectedPersonDetails.personbasicdetails.sencriteria = null
      }


    }
    if(this.selectedPersonDetails?.personbasicdetails?.personid){
    this.loadSenHistory(this.selectedPersonDetails?.personbasicdetails?.personid);
    }
    this.involvedPersonFormGroup.controls['sencriteria'].setValidators(Validators.required);
    this.involvedPersonFormGroup.controls['birthinghospital'].setValidators(Validators.required);
  }

  onSenRemovalCancel() {
    this.involvedPersonFormGroup.get('substanceexposednewbornflag')?.setValue(this.previousSenState);

    $('#sen-removal-modal').modal('hide');

  }


  openSenRemovalModal() {
    this.selectedReasons = [];
    this.selectedActions = [];
    this.otherReasonText = '';

    $('#sen-removal-modal').modal('show');
  }

  onReasonsChange() {
    if (!this.selectedReasons.includes('OTH')) {
      this.otherReasonText = '';
    }
  }


  isFormValid(): boolean {
    const hasReason = this.selectedReasons.length > 0;
    const hasOtherReasonFilled = !this.selectedReasons.includes('OTH') || (this.otherReasonText?.trim()?.length > 0);
    const hasActions = this.selectedActions.length > 0;
    return hasReason && hasOtherReasonFilled && hasActions;
  }


  submitForApproval() {
    const now = Date.now();
    if (now - this.lastClickTime < this.clickDelay) {
      this._alertService.warn('Please wait before submitting again');
      return;
    }

    this.lastClickTime = now;
    this.submitSENRequest(false, 'Pending');
  }


  submitSENRequest(isAddition: boolean, approvalStatus? : any, personId? : any) {
    const reqTxt = isAddition ? 'addition' : 'removal';
    if (this.isSenRequestLoading) {
      return;
    }
    if (!isAddition && !this.isFormValid() && !approvalStatus && approvalStatus !== 'Changed') {
      this._alertService.warn('Please complete all required fields');
      return;
    }
    const request = this.getSenHistoryRequest(isAddition, approvalStatus);
    if(!request.personId){
      request.personId = personId;
    }
    this.isSenRequestLoading = true;
    this._personInfoService.manageSENHistory(request).subscribe(
      (response) => {
        if (response && response.length > 0 && response[0].success) {
          this.onsubmitSENSuccess(isAddition, approvalStatus, reqTxt);
          this.actionChoice = null;
          this.selectedHistoryItem = null;
          this.isSenRequestLoading = false;
          this.loadSenHistory(request.personId);
          if (approvalStatus !== 'Changed' && approvalStatus !== 'Pending') {
            setTimeout(() => {
              this.isBlockPersonSaveNotification = true;
              this.addOrUpdatePerson(approvalStatus);
            }, 0);
          }
        } else {
          this._alertService.error(response.message || `Failed to submit SEN ${reqTxt} request`);
        }
      },
      (error) => {
        this._alertService.error(`Failed to submit SEN ${reqTxt} request`);
      }
    );
  }

  onsubmitSENSuccess(isAddition: any, approvalStatus: any, reqTxt: any){
    if (!isAddition) {
      $('#sen-removal-modal').modal('hide');
    }
    switch(approvalStatus){
      case 'Approved':
        $('#descion-screen').modal('hide');
        this._alertService.success(`SEN removal approved successfully`);
        $('#approve-confirmation').modal('hide');
        break;
      case 'Deny':
        $('#descion-screen').modal('hide');
        this._alertService.success(`SEN removal request denied`);
        break;
      case 'Pending':
        $('#descion-screen').modal('hide');
        this._alertService.success(`SEN ${reqTxt} request submitted for approval`);
        break;
    }
  }

  getSenHistoryRequest(isAddition: boolean, approvalStatus? : any) {
    let data: any = this.getSenHistoryData(isAddition, approvalStatus);

    if (!isAddition) {
      data.reasons = this.selectedReasons;
      data.otherReason = this.selectedReasons.includes('OTH') ? this.otherReasonText : null;
      data.actions = this.selectedActions;
    }
    data = this.processSenHistory(data, approvalStatus);
    if (approvalStatus === 'Deny') {
      let substanceClasses = this.senHistoryList.find((e: any) => (e.substance_classes && e.substance_classes.length > 0));
      this.involvedPersonFormGroup.patchValue({
        substanceexposednewbornflag: 1,
        substanceclasses: (substanceClasses && substanceClasses.substance_classes.length > 0) ? substanceClasses.substance_classes : null
      });
    } else if (approvalStatus === 'Approved') {
      this.involvedPersonFormGroup.patchValue({
        substanceexposednewbornflag: 0,
        substanceclasses: null
      });
    }
    return data;
  }

  processSenHistory(data: any, approvalStatus? : any){
    if (approvalStatus === 'Approved' || approvalStatus === 'Deny') {
      data.reasons = (this.senHistoryList[0].reasons && this.senHistoryList[0].reasons.length > 0) ? this.senHistoryList[0].reasons : [];
      data.otherReason = this.senHistoryList[0].otherReason ? this.senHistoryList[0].otherReason : null;
      data.actions = (this.senHistoryList[0].actions && this.senHistoryList[0].actions.length > 0) ? this.senHistoryList[0].actions : [];
    }
    return data;
  }

  getSenHistoryData(isAddition: boolean, approvalStatus? : any){
    const currentUser = this._authService.getCurrentUser();
    const personId = this.selectedPersonDetails?.personbasicdetails?.personid;
    const objectid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const isAprroveOrDeny = (this.senHistoryList && this.senHistoryList.length > 0 && (approvalStatus === 'Approved' || approvalStatus === 'Deny'));
    const hospitalAddress = this.involvedPersonFormGroup.get('birthinghospital')?.value == 'Other' ? this.smartyAddress.address1 + ', ' + this.smartyAddress.city
              + ', ' + this.smartyAddress.county + ', ' + this.smartyAddress.state + ' ' + this.smartyAddress.zipcode : this.involvedPersonFormGroup.get('birthinghospital')?.value;
    return {
      personId: personId,
      requestedOn: isAprroveOrDeny ? this.senHistoryList[0].requested_on : undefined,
      requestedBy: (approvalStatus === 'Changed' || approvalStatus === 'Created' || approvalStatus === 'Pending') ? currentUser.user.securityusersid : this.senHistoryList[0].requested_by,
      approvedBy: isAprroveOrDeny ? currentUser.user.securityusersid : undefined,
      senStatus: (approvalStatus === 'Changed' || approvalStatus === 'Created' || approvalStatus === 'Deny' ),
      birthinghospital: isAprroveOrDeny ? this.senHistoryList[0].birthinghospital : hospitalAddress,
      sencriteria: isAprroveOrDeny ? this.senHistoryList[0].sencriteria : this.involvedPersonFormGroup.get('sencriteria')?.value,
      othersubstances: isAprroveOrDeny ? this.senHistoryList[0].othersubstances : this.involvedPersonFormGroup.get('othersubstances')?.value,
      approvalStatus: approvalStatus,
      substanceClasses: isAprroveOrDeny ? this.senHistoryList[0].substance_classes : this.refKeystoSave,
      servicecaseid:  this.isServiceCase ? this.getSenHistoryDataCond(approvalStatus, objectid) : undefined,
      intakeserviceid: !this.isServiceCase ? this.getSenHistoryDataCond(approvalStatus, objectid) : undefined,
      activeFlag: isAddition ? 1 : 0,
      denialreasonkey: (approvalStatus === 'Deny') ? this.senHistoryList[0].denialreasonkey : undefined,
      denialreasondesc: (approvalStatus === 'Deny') ? this.senHistoryList[0].denialreasondesc : undefined
    };
  }

  getSenHistoryDataCond(approvalStatus: any, objectid: any){
    return (((approvalStatus === 'Approved' || approvalStatus === 'Deny') || (this.senHistoryList && this.senHistoryList.length > 0 && this.senHistoryList[0].objectid)) ? this.senHistoryList[0].objectid : objectid);
  }

  viewSENHistoryDetails(history: any) {
    this.selectedHistoryItem = history;
    this.selectedHistoryItem.reasonDesc = [];
    this.selectedHistoryItem.actionDesc = [];
    this.selectedHistoryItem.denyDesc = [];
    if (history.reasons && history.reasons.length > 0) {
      history.reasons.forEach((element: any) => {
        this.selectedHistoryItem.reasonDesc.push(this.senCriteriaOptions.find((e) => e.ref_key == element).description);
      });
    }
    if (history.actions && history.actions.length > 0) {
      history.actions.forEach((element: any) => {
        this.selectedHistoryItem.actionDesc.push(this.agencyActions.find((e) => e.ref_key == element).description);
      });
    }
    if (history.denialreasonkey) {
        this.selectedHistoryItem.denyDesc.push(this.senchecksupervisordeny.find((e) => e.ref_key == history.denialreasonkey).description);
    }
    $('#sen-history-details-modal').modal('show');
  }


  closeModal() {
    $('#sen-history-details-modal').modal('hide');
    $('#sen-removal-modal').modal('hide');
  }

  fileChangeEvent(file: any) {
    this.beofreImageCropeHide = true;
    this.afterImageCropeHide = true;
    this.imageChangedEvent = file;
    this.isDefaultPhoto = false;
    this.isImageLoadFailed = false;
    this.isImageHide = true;
  }
  private loadDropDown() {
    const babysubstanceList = ['BOTH', 'BPD', 'BPCP', 'BMTD', 'BMJA', 'BHOI', 'BESY', 'BCOC', 'BBS', 'BAS', 'FASD', 'BTN', 'BTNR', 'BENZO', 'OPIA']; // @TM: Baby substances

    this.maritalDropdownItems$ = this._commonDropdownService.getPickListByName('maritalstatus');
    this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
    this.countyDropDownItems$ = this._commonDropdownService.getPickListByName('county');
    this.prefixDropdownItems$ = this._commonDropdownService.getPickListByName('prefix');
    this.suffixDropdownItems$ = this._commonDropdownService.getPickListByName('suffix');
    this.livingArrangementDropDownItems$ = this._commonDropdownService.getPickListByName('livingarrangementtype');
    this.livingArrangementDropDownItems$ = this.livingArrangementDropDownItems$.pipe(map(arr =>
      arr.filter(item => item.activeflag === 1)
    ));

    this.languageTypesDropDownItems$ = this._commonDropdownService.getPickListByName('languagetype');
    this.primaryCitizenshipDropDownItems$ = this._commonDropdownService.getPickListByName('country');
    this.nationalityDropDownItems$ = this._commonDropdownService.getPickListByName('nationality');
    this.ethinicityDropdownItems$ = this._commonDropdownService.getPickListByName('ethnicity');
    this.religionDropdownItems$ = this._commonDropdownService.getPickListByName('religion');
    this.akaDropdownItems$ = this._commonDropdownService.getPickListByName('akatype');
    this.sencriteriaDropDownItems$ = this._commonDropdownService.getPickListByName('sencriteria',null,'displayorder');
    this.substanceclassDropDownItems$ = this._commonDropdownService.getListAllByTableID('55');
    this.babysubstanceclassDropDownItems$ = this.substanceclassDropDownItems$.pipe(map(arr => // @TM: force filter Baby substances
      arr.filter(item => babysubstanceList.includes(item.ref_key) && item.activeflag=='2') // old substance list
    ));

    this.babysubstanceclassDropDownItems$.subscribe(data => {
      this.babysubstanceclassDropDownItemsSnapshot = data;
    });
    this.substanceclassDropDownItems$.subscribe(data => {
      this.substanceClassDropdownData = data;      //new susbtance list
    });

    this.babysubstanceclassDropDown_level1$ = this.substanceclassDropDownItems$.pipe(map(arr => 
      arr.filter(item => (item.parentkey==null) && item.activeflag=='1')
    ));    

    this.babysubstanceclassDropDown_level2$ = this.substanceclassDropDownItems$.pipe(map(arr => 
      arr.filter(item => (item.parentkey!=null) && item.activeflag=='1')
    ));

    this.babysubstanceclassDropDown_level2$.subscribe(data => {
      this.babysubstanceclassDropDownlevel2Snapshot = data;
      this.babysubstanceclassDropDownlevel2Snapshot.forEach(item => {
        const mapKey = item.ref_key;
        this.substanceParentMap.set(mapKey, item.parentkey);
      }); 
    }); 

    this.babysubstanceclassDropDown_level1$.subscribe(data => {
      this.babysubstanceclassDropDownlevel1Snapshot = data;
       
      this.babysubstanceclassDropDownlevel1Snapshot.forEach(element => {
        this.firstLevelSubstanceClasses.push(element.description);
      });
      if(this.substanceClassDropdownData && this.babysubstanceclassDropDownlevel1Snapshot && this.substanceParentMap){
        this.babysubstanceclassDropDownlevel1Snapshot.forEach(group=>{        
          var level1:any = {class:group.ref_key, value:group.description, isSelected : false, children: null}
          var childlist:any = this.getKeyByValue(group.ref_key);
          if(childlist){
            childlist.forEach((key: string)=>{
              var insertVal:any = this.substanceClassDropdownData.filter(item=> item.ref_key == key)[0];
              if(level1['children']){
                level1['children'].push({class:insertVal.ref_key, value:insertVal.description, isSelected : false, children: null}); 
              }else{
                level1['children'] = [{class:insertVal.ref_key, value:insertVal.description, isSelected : false, children: null}]; 
              } 
              var grandchildlist:any = this.getKeyByValue(insertVal.ref_key);
              if(grandchildlist){
                grandchildlist.forEach((substance: string)=>{
                  var insertVal2:any = this.substanceClassDropdownData.filter(item=> item.ref_key == substance)[0];
                  level1['children'].forEach((element: { [x: string]: { class: any; value: any; isSelected: boolean; children: null; }[]; class: any; }) => {
                    if(element.class === insertVal2.parentkey){
                      if(element['children']){
                        element['children'].push({class:insertVal2.ref_key, value:insertVal2.description, isSelected : false, children: null});
                      }else{
                        element['children'] =  [{class:insertVal2.ref_key, value:insertVal2.description, isSelected : false, children: null}]; 
                      }
                    }
                  })                  
                })
              }                         
            })
          }
          this.dropdownDataNode.push(level1);       
        });
      }
    });   


    

    let houseHoldType = 'cpsroles';
    this.navigationInfo = this._navigationUtils.getNavigationInfo();
    if (this.navigationInfo && (this.navigationInfo.source === AppConstants.MODULE_TYPE.PUBLIC_PROVIDER
      || this.navigationInfo.source === AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_REFERRAL
      || this.navigationInfo.source === AppConstants.MODULE_TYPE.PUBLIC_PROVIDER_APPLICATION)) {
        houseHoldType = 'provdroles';
      }

    this.getCaseType();
    this.validateRoleForAdoption();

    this.alienStatusDropDownItems$ = this._commonDropdownService.getPickListByName('alienstatus');
    this.householdroleDropdownItems$ = this._commonDropdownService.getPickListByName(houseHoldType);
    this.collateralroleDropdownItems$ = this._commonDropdownService.getPickListByName('collateralroles');
    this.hairColor$ = this._commonDropdownService.getPickListByName('haircolor');
    this.hairTexture$ = this._commonDropdownService.getPickList('93');
    this.eyeColor$ = this._commonDropdownService.getPickList('79');
    this.physicalBuild$ = this._commonDropdownService.getPickList('140');
    this.skinTone$ = this._commonDropdownService.getPickList('199');
    this.isGlass$ = this._commonDropdownService.getPickList('78');

    this.householdroleDropdownItems$.subscribe((data) => {
        const resultData: any = data;
        const dropDownList = [];
            dropDownList.push(resultData.find((f:any) => f.ref_key === 'ICC'));

        const index = resultData.indexOf(resultData.find((f: { ref_key: string; }) => f.ref_key === 'ICC'));
        resultData.splice(index, 1);
        const response = resultData.sort(function(a: { value_text: number; },b: { value_text: number; }){
          const ifLess = a.value_text < b.value_text ? -1 : 0;
          return a.value_text > b.value_text ? 1 : ifLess;
        })
        this.roleDropDownList =  [ ...dropDownList, ...response];
    })
  }

  getKeyByValue(searchValue: any) {
    var keyList = []; 
    for (let [key, value] of this.substanceParentMap.entries()) {
      if (value === searchValue) 
        keyList.push(key);
    }
    return keyList;
  }

  getHospitalList() {    
    this._commonHttpService.getPagedArrayList({
      page: this.paginationInfo.pageNumber,
      limit: 100000,
      objecttype: 'SEN',
      method: 'get'
    }, 'hospitaldetail/list?filter').subscribe((res: any) => {
      if (res) {
        res.sort((a: { name: number; },b: { name: number; }) => (a.name > b.name) ? 1 : this.returnRespSortFn(b, a))
        this.suggestedAddressOg = res ? JSON.parse(JSON.stringify(res)) : [];
        this.suggestedAddress = res ? res : [];
      }
    });
  }
  private returnRespSortFn(b: any, a: any) {
    return (b.name > a.name) ? -1 : 0;
  }

  getSuggestednames() {
    if (this.involvedPersonFormGroup.value.birthinghospital) {
      this.suggestedAddress = this.suggestedAddressOg.filter((c: { name: string; })=>c.name.toLowerCase().startsWith(this.involvedPersonFormGroup.value.birthinghospital.toLowerCase()))
    }
  }

  selectedCriteria(item: any){
    if(item){      
      this.disableHospitalDropdown = false      
    }
  }

  selectAddress(item: any){
    this.selectedAddress(item);
    this.disableSubstanceClass = false;
  }

  getSubstanceClassDescriptions(codes: string[]): string[] {
    if (!Array.isArray(codes)) return [];
    return codes.map(code => {
      if(code==='OTDS'){
        return 'Other Drug/Substance' + ' (' + this.selectedHistoryItem.othersubstances + ')';
      }
      var match = this.babysubstanceclassDropDownItemsSnapshot.find(item => item.ref_key === code);      
      var final: any, data: any = '';
      if(!match){
       let match2 = this.substanceClassDropdownData.find(item => item.ref_key === code);
        var level1:any,level2:any;
        if(match2){
          data = 'new';
          final ='';
          if(this.getValueBykey(code)){
            level1 = this.substanceClassDropdownData.filter(item => item.ref_key === this.getValueBykey(code));
            if(this.getValueBykey(level1[0].ref_key)){
              level2 = this.substanceClassDropdownData.filter(item => item.ref_key === this.getValueBykey(level1[0].ref_key));
              final = level2[0].description;
            }
            final = final + '('+ level1[0].description + '(' + match2.description + '))';
          }
          if(!final) final = code;
        }
      }else{
        data = 'old';
      }
      return data=='old' ? match?.description : final;
    });
  }

  validateRoleForAdoption(){
    if(this.isAdoptionCase){
      this.involvedPersonFormGroup.controls['roletype'].clearValidators();
      this.involvedPersonFormGroup.controls['roletype'].updateValueAndValidity();
    }
  }
    getCaseType(){
        this.isCPS=false;
        this.isServiceCase=false;
        this.isAdoptionCase=false;

        //IS SERVICE
        if (this.navigationInfo && (this.navigationInfo.source === AppConstants.CASE_TYPE.SERVICE_CASE)) {
          this.isCPS = false;
          this.isServiceCase = true;
        }
        if (this.store && (this.store.CASE_TYPE == AppConstants.CASE_TYPE.SERVICE_CASE)) {
          this.isCPS = false;
          this.isServiceCase = true;
        }

        //IS CPS?
        if (this.navigationInfo && (this.navigationInfo.source === AppConstants.CASE_TYPE.CPS_CASE)) {
          this.isCPS = true;
          this.isServiceCase = false;
        }

        if(this.dsdsactionsummary && this.dsdsactionsummary.da_type == AppConstants.DA_TYPE_TEXT.ADOPTION_CASE){
          this.isServiceCase = false;
          this.isCPS = false;
          this.isAdoptionCase = true;
        }
        if(this._session && this._session.getItem('CASE_TYPE') == 'ADOPTION'){
          this.isServiceCase = false;
          this.isCPS = false;
          this.isAdoptionCase = true;
        }
      }
  calculatePersonAge() {
    const person = this.involvedPersonFormGroup?.getRawValue();
    if (person && person.Dob) {
      const age = { years: 0, months: 0, days: 0, totalMonths: 0, duration: null };
      age.years = this.returnYearFn(person);
      age.totalMonths = this.returnTotalMonthFn(person);
      age.months = this.returnMonthFn(age);
      age.days = this.returnDaysFn(person);
      age.duration = this.returnDurationFn(person);
      const ddays = this.returnDDaysFn(age);
      const dmonths = this.returnDMonthsFn(age);
      const dyears = this.returnDYearsFn(age);
      this.personAge = `${dyears} Years ${dmonths} month(s) ${ddays} Day(s)`;
      this._dataStoreService.setData('personAge', age.totalMonths);
      this.handleAgeDetailsFn(age);
      // Marital status check of age changed
      var selectedRoles = this.involvedPersonFormGroup.getRawValue().roles;
      if((selectedRoles && selectedRoles.includes("ICC")) || dyears >= 21 ||
        (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails.caregiverData
          && this.selectedPersonDetails.personbasicdetails.caregiverData.length>0)){
          this.maritalStatus = true;
          this.involvedPersonFormGroup.controls["maritalstatustypekey"].setValidators([Validators.required])
      } else {
        this.maritalStatus = false;
        this.involvedPersonFormGroup.controls["maritalstatustypekey"].setValidators([])
      }
    }
  }
  // Associated to calculatePersonAge function
  private handleAgeDetailsFn(age: { years: any; months: any; days: any; totalMonths?: number; duration?: null | Duration; }) {
    this.involvedPersonFormGroup.get('safehavenbabyflag')?.enable();
    this.personAgeCheck = age.days;
    this.isChild21 = age.years <= 21;
    this.isChild18 = age.years <= 18;
    this.isChildabove18 = age.years >= 18;
    const years = age.duration?.years() ?? 0;
    if (years < 14 && this.involvedPersonFormGroup?.get('maritalstatustypekey')?.value === null) {
      this.involvedPersonFormGroup.patchValue({
        maritalstatustypekey: 'SG'
      });
      this.involvedPersonFormGroup.controls["maritalstatustypekey"].updateValueAndValidity();
    }
    this.checkOnDobSelectFn(age);
    if(this.isChild18){
      this.involvedPersonFormGroup.get("intercountryadoption")?.enable();
    }else{
      this.involvedPersonFormGroup.get("intercountryadoption")?.disable();
    }

    if(this.personAgeCheck > 10) {
      this.involvedPersonFormGroup.get('safehavenbabyflag')?.disable();
    }
    this.updateCheckboxState();
  }
  // Associated to handleAgeDetailsFn function
  private checkOnDobSelectFn(age: { years: any; months: any; days: any; totalMonths?: number; duration?: null | Duration; }) {
    const daysSinceLastMonth = age.duration?.days();
    const monthsSinceLastYear = age.duration?.months();
    if (age.years < 21) {
      this.personAgeStatus = true;
    } else if ((age.years === 21 && monthsSinceLastYear === 0 && daysSinceLastMonth === 0)) { 
      this.personAgeStatus = false;
    } else {
      this.personAgeStatus = false;
    }

    this.commonValidatorFn(this.isChild18,'everbeenadoptedflag');
    this.commonValidatorFn(this.isChild18,'priorlegalguardianship');
  }

  commonValidatorFn(isChild18: boolean, field: any) { 
    const control: any = this.involvedPersonFormGroup.get(field); 
    if (isChild18) { 
      control?.setValidators([Validators.required]); 
      control?.enable(); 
    } else { 
      control?.clearValidators(); 
      control?.disable(); 
    } 
    control?.updateValueAndValidity(); 
  } 

  // Associated to calculatePersonAge function
  private returnDYearsFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }) {
    return (age.duration.years()) ? age.duration.years() : 0;
  }
  // Associated to calculatePersonAge function
  private returnDMonthsFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }) {
    return (age.duration.months()) ? age.duration.months() : 0;
  }
  // Associated to calculatePersonAge function
  private returnDDaysFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }) {
    return (age.duration.days()) ? age.duration.days() : 0;
  }
  // Associated to calculatePersonAge function
  private returnDurationFn(person: any): any {
    return moment.duration(moment(Date.now()).diff(moment(person.Dob)));
  }
  // Associated to calculatePersonAge function
  private returnDaysFn(person: any): number {
    return (moment().diff(person.Dob, 'days', false)) ? moment().diff(person.Dob, 'days', false) : 0;
  }
  // Associated to calculatePersonAge function
  private returnMonthFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }): number {
    return (age.totalMonths - (age.years * 12)) ? age.totalMonths - (age.years * 12) : 0;
  }
  // Associated to calculatePersonAge function
  private returnTotalMonthFn(person: any): number {
    return (moment().diff(person.Dob, 'months', false)) ? moment().diff(person.Dob, 'months', false) : 0;
  }
  // Associated to calculatePersonAge function
  private returnYearFn(person: any): number {
    return (moment().diff(person.Dob, 'years', false)) ? moment().diff(person.Dob, 'years', false) : 0;
  }

  calculateAdoptionAge(){
    const person = this.involvedPersonFormGroup?.getRawValue();
    if (person && person.Dob) {
      const age:any = { years: 0, months :0, days: 0, totalMonths: 0, duration:0 };
      age.years = (moment(person.preadptdate).diff(person.Dob, 'years', false)) ? moment(person.preadptdate).diff(person.Dob, 'years', false) : 0;
      age.totalMonths = (moment(person.preadptdate).diff(person.Dob, 'months', false)) ? moment(person.preadptdate).diff(person.Dob, 'months', false) : 0;
      age.duration = moment.duration(moment(person.preadptdate).diff(moment(person.Dob)));
      const dyears = (age.duration.years()) ? age.duration.years() : 0;
      this.adoptionAge = `${dyears} Years`;
      this._dataStoreService.setData('adoptionAge', age.totalMonths);
    }
  }

  dobChangeListener() {
    this.involvedPersonFormGroup.controls['Dob'].valueChanges.subscribe((res: any) => {
      if (res) {
        this.calculatePersonAge();
      }
    });
  }
  preadptdateChangeListener() {
    this.involvedPersonFormGroup.controls['preadptdate'].valueChanges.subscribe((res: any) => {
      if (res) {
        this.calculateAdoptionAge();
      }
    });
  }
  updateProfileViewfromSearch(searchdata: { lastname: any; firstname: any; gender: any; dob: moment.MomentInput; dateofdeath: moment.MomentInput; occupation: any; ssn: any; stateid: any; address2: any; address1: any; zip: any; city: any; county: any; alias: any; length: any; drugexposednewbornflag: any; drugexposedtypekey: any; }) {
    this.involvedPersonFormGroup.patchValue({
      Lastname: searchdata.lastname,
      Firstname: searchdata.firstname,
      gendertypekey: searchdata.gender,
      Dob: searchdata.dob ? moment(searchdata.dob).format(this.dtformat) : null,
      dateofdeath: searchdata.dateofdeath ? moment(searchdata.dateofdeath) : null,
      occupation: searchdata.occupation,
      SSN: searchdata.ssn ? searchdata.ssn : '',
      stateid: searchdata.stateid,
      Address: searchdata.address2,
      address1: searchdata.address1,
      Zip: searchdata.zip,
      City: searchdata.city,
      State: searchdata.stateid,
      County: searchdata.county,
      aliasname: searchdata.alias,
      hasAlias: searchdata.length ? true : null,
      substanceexposednewbornflag: searchdata.drugexposednewbornflag ? searchdata.drugexposednewbornflag : 0,
      substanceclasses: searchdata.drugexposedtypekey ? searchdata.drugexposedtypekey : null,
    });

    if(searchdata.dob) {
      this.calculatePersonAge();
    }else{
      this.isChild18 = false;
      this.involvedPersonFormGroup.get("everbeenadoptedflag")?.disable();
      this.involvedPersonFormGroup.get("intercountryadoption")?.disable();
      this.involvedPersonFormGroup.get("priorlegalguardianship")?.disable();
    }
  }
  updateProfileView(personInfo: any) {
    this.selectedPersonDetails = personInfo;

    if(this.selectedPersonDetails &&
      this.selectedPersonDetails.personbasicdetails &&
      this.selectedPersonDetails.personbasicdetails.userphoto != null &&
      this.selectedPersonDetails.personbasicdetails.userphoto != undefined &&
      this.selectedPersonDetails.personbasicdetails.userphoto != ''){
      this.userphotoforEdit = this.selectedPersonDetails.personbasicdetails.userphoto;
      // An inline data/blob source is already complete - only relative paths need the api prefix
      if (!/^(data:|blob:)/i.test(this.selectedPersonDetails.personbasicdetails.userphoto)) {
        this.selectedPersonDetails.personbasicdetails.userphoto = '/api'+this.selectedPersonDetails.personbasicdetails.userphoto;
      }
      
    }


    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails) {
      if (this.selectedPersonDetails.personbasicdetails.userphoto) {
        this.userphoto = /^(data:|blob:)/i.test(this.selectedPersonDetails.personbasicdetails.userphoto)
          ? this.selectedPersonDetails.personbasicdetails.userphoto
          : AppConfig.baseUrl + this.selectedPersonDetails.personbasicdetails.userphoto;
      }

      if (this.selectedPersonDetails?.personbasicdetails?.personid) {
        this.loadSenHistory(this.selectedPersonDetails.personbasicdetails.personid);
      }
      if(this.selectedPersonDetails.personbasicdetails.senstatusflag == 0 || 
        (this.selectedPersonDetails.personbasicdetails.senstatusflag == 1 && !this.selectedPersonDetails.personbasicdetails.sencriteria)){
        this.listShown = 'old';
      }else{
        this.listShown = 'new';
      }
    }
    const personbasicdetails = (this.selectedPersonDetails) ? this.selectedPersonDetails.personbasicdetails : null;
    if(personbasicdetails?.othersubstances){
      this.enableOtherFlag = true;
      let othercontrol = this.involvedPersonFormGroup.get('othersubstances');
        if(this.involvedPersonFormGroup.value.sencriteria == null && !this.selectedPersonDetails.personbasicdetails?.sencriteria){
          othercontrol?.disable();
        }else{
          othercontrol?.enable();
        }
    }
    if(personbasicdetails?.substanceclasses){
      this.substanceClassPlaceholderArray = [];
      this.refKeystoSave = [];
      this.buildSubstanceClassPlaceholder(personbasicdetails.substanceclasses);
      this.syncTreeWithSavedData(personbasicdetails.substanceclasses);
      personbasicdetails.substanceclasses.forEach((element: any) => {
        this.refKeystoSave.push(element);
      });
    }
    this.checkUpdateProfilPersonbasicdetailsFn(personbasicdetails);

    this.involvedPersonFormGroup.markAsPristine();

    if(this._dataStoreService.getData('personsdrsource')) {
      this.involvedPersonFormGroup.controls['Dob'].disable();
      this.involvedPersonFormGroup.controls['Firstname'].disable();
      this.involvedPersonFormGroup.controls['Lastname'].disable();
      this.involvedPersonFormGroup.controls['gendertypekey'].disable();
      this.involvedPersonFormGroup.controls['SSN'].disable();
    }

    this.loadDropdowns();
    this.getintakeservicerequestsdm();
  }
  // Associated with updateProfileView function
  private checkUpdateProfilPersonbasicdetailsFn(personbasicdetails: any) {
    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails) {
      this.checkIfPersonbasicdetailsCondition1Fn();

      const roleType = this.conditionForRoleTypeFn();
      const personrole = this.conditionForPersonRoleFn();
      const isheadofhousehold = this.conditionForHeadofhouseholdFn();

      this.involvedPersonFormGroup.patchValue(this.patchInvolvedPersonFormGroupDataFn(personrole, roleType, isheadofhousehold, personbasicdetails));

      this.icwaEligibleFormembershipChange();
      this.checkIfPersonbasicdetailsCondition2Fn();
      this.checkIfPersonbasicdetailsCondition3Fn();

      this.processRoleValidation();
      this.conditionToPatchCitizenalenageflagDataFn();

      if (!this.isClosed) {
        this.triggerIcwa60DaysModalIfNeeded();
      }

      // if (this.selectedPersonDetails.personroledetails && this.selectedPersonDetails.personroledetails.actor.ishousehold) {
      //   this.involvedPersonFormGroup.patchValue({ householdflag: 1 });
      // }
      // if (this.selectedPersonDetails.personroledetails && this.selectedPersonDetails.personroledetails.actor.iscollateralcontact) {
      //   this.involvedPersonFormGroup.patchValue({ householdflag: 0 });
      // }
      // if (this.selectedPersonDetails.personroledetails && this.selectedPersonDetails.personroledetails.actor) {
      //   const roles = [this.selectedPersonDetails.personroledetails.actor.actortype];
      //   this.involvedPersonFormGroup.patchValue({ roles: roles });
      // }
      // if (
      //   this.selectedPersonDetails.personroledetails &&
      //   this.selectedPersonDetails.personroledetails.actor
      // ) {
      //   this.involvedPersonFormGroup.patchValue({
      // Dangerousworker:
      //   this.selectedPersonDetails.personroledetails.actor
      //     .dangerlevel === null
      //     ? 'no'
      //     : this.selectedPersonDetails.personroledetails
      //       .actor.dangerlevel,
      // DangerousWorkerReason: this.selectedPersonDetails
      //   .personroledetails.actor.dangerreason,
      // mentalimpairdetail: this.selectedPersonDetails
      //   .personroledetails.actor.mentalimpairdetail,
      // ismentalillness:
      //   this.selectedPersonDetails.personroledetails.actor
      //     .ismentalillness === null
      //     ? 'no'
      //     : this.selectedPersonDetails.personroledetails
      //       .actor.ismentalillness,
      // mentalillnessdetail: this.selectedPersonDetails
      //   .personroledetails.actor.mentalillnessdetail
      //   });
      // }
      // this.resetRoleTabRadioBtn(this.selectedPersonDetails.personroledetails.actor.iscollateralcontact);
      // tslint:disable-next-line:max-line-length
      this.checkIfPersonbasicdetailsCondition4Fn();
      this.checkIfPersonbasicdetailsCondition5Fn();
      this.checkIfPersonbasicdetailsCondition6Fn();
      this.isValuesUpdated = true ;
      if(this.involvedPersonFormGroup.get('sencriteria')?.value != null){
        this.disableHospitalDropdown = false;
      }
      if(this.involvedPersonFormGroup.get('birthinghospital')?.value != null){
        this.disableSubstanceClass = false;
      }
    }
  }
  // Associated with updateProfileView function
  private checkIfPersonbasicdetailsCondition6Fn() {
    if (this.returnPersonphysicalattributeCondition()) {
      const higth = this.returnHtDataFn('Ht');
      const weight = this.returnHtDataFn('Wt');
      const tattoos = this.returnHtDataFn('Tattoo');
      const phyMarks = this.returnHtDataFn('PhyMark');
      let heightin = this.returnAttributeValueFn(higth);
      heightin = heightin.split('.');
      let weightpnd = this.returnAttributeValueFn(weight);
      weightpnd = weightpnd.split('.');
      this.involvedPersonFormGroup.patchValue(this.patchInvolvedPersonFormGroupBodyAndMarksDataFn(heightin, weightpnd, tattoos, phyMarks));
    }
    this.checkIfPersonmaritalstatusConditionFn();
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupBodyAndMarksDataFn(heightin: any, weightpnd: any, tattoos: any, phyMarks: any) {
    return {
      heightft: heightin && heightin.length && !isNaN(heightin[0]) ? heightin[0] : null,
      heightin: heightin && heightin.length > 1 && !isNaN(heightin[1]) ? heightin[1] : null,
      weightpnd: weightpnd && weightpnd.length && !isNaN(weightpnd[0]) ? weightpnd[0] : null,
      weightound: weightpnd && weightpnd.length > 1 && !isNaN(weightpnd[1]) ? weightpnd[1] : null,
      tattoo: tattoos && tattoos.length ? tattoos[0].attributevalue : '',
      PhyMark: phyMarks && phyMarks.length ? phyMarks[0].attributevalue : ''
    };
  }
  // Associated with updateProfileView function
  private returnPersonphysicalattributeCondition() {
    return this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personphysicalattribute && this.selectedPersonDetails.personbasicdetails.personphysicalattribute.length;
  }
  // Associated with updateProfileView function
  private returnAttributeValueFn(index: any) {
    return (index && index.length && index[0].attributevalue ? index[0].attributevalue : '');
  }
  // Associated with updateProfileView function
  private returnHtDataFn(filterString: string) {
    return (this.selectedPersonDetails.personbasicdetails.personphysicalattribute.filter((item: { physicalattributetypekey: string; }) => item.physicalattributetypekey === filterString));
  }
  // Associated with updateProfileView function
  private checkIfPersonmaritalstatusConditionFn() {
    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personmaritalstatus) {
      const maritalInfo = this.selectedPersonDetails.personbasicdetails.personmaritalstatus;
      const maritalAddressInfo = this.selectedPersonDetails.personbasicdetails.personspouseaddress[0];
      this.involvedPersonFormGroup.patchValue(this.patchinvolvedPersonFormGroupMaritalStatusDataFn(maritalInfo));
      this.checkIfMaritalAddressInfoConditionFn(maritalAddressInfo, maritalInfo);
    }
  }
  // Associated with updateProfileView function
  private checkIfMaritalAddressInfoConditionFn(maritalAddressInfo: any, maritalInfo: any) {
    if (maritalAddressInfo) {
      this.involvedPersonFormGroup.patchValue({
        marriageplace: maritalInfo.marriageplace ? maritalInfo.marriageplace : '',
        spouseaddress1: maritalAddressInfo.spouseaddress1 ? maritalAddressInfo.spouseaddress1 : '',
        spouseAddress2: maritalAddressInfo.spouseAddress2 ? maritalAddressInfo.spouseAddress2 : '',
        spousecity: maritalAddressInfo.spousecity ? maritalAddressInfo.spousecity : null,
        spousestate: maritalAddressInfo.spousestate ? maritalAddressInfo.spousestate : null,
        spousezipcode: maritalInfo.marriageplace ? maritalAddressInfo.spousezipcode : null,
        spousecounty: maritalAddressInfo.spousecounty ? maritalAddressInfo.spousecounty : null
      });

    }
  }
  // Associated with updateProfileView function
  private patchinvolvedPersonFormGroupMaritalStatusDataFn(maritalInfo: any) {
    return {
      marriageplace: maritalInfo.marriageplace ? maritalInfo.marriageplace : '',
      divorceplace: maritalInfo.divorceplace ? maritalInfo.divorceplace : '',
      spousehomenumber: maritalInfo.spousehomenumber ? maritalInfo.spousehomenumber : null,
      spouseofficenumber: maritalInfo.spouseofficenumber ? maritalInfo.spouseofficenumber : null,
      spouseofficeextension: maritalInfo.spouseofficeextension ? maritalInfo.spouseofficeextension : null,
      spouseprefix: maritalInfo.spouseprefix ? maritalInfo.spouseprefix : null,
      spousefirstname: maritalInfo.spousefirstname ? maritalInfo.spousefirstname : null,
      spouselastname: maritalInfo.spouselastname ? maritalInfo.spouselastname : null,
      spousemiddlename: maritalInfo.spousemiddlename ? maritalInfo.spousemiddlename : null,
      spousesuffix: maritalInfo.spousesuffix ? maritalInfo.spousesuffix : null,
      numberofchildren: maritalInfo.childrenno ? maritalInfo.childrenno : null,
      maritalcomments: maritalInfo.maritalcomments ? maritalInfo.maritalcomments : '',
      maritalstartdate: this._commonDropdownService.getValidDate(maritalInfo.maritalstartdate),
      maritalenddate: this._commonDropdownService.getValidDate(maritalInfo.maritalenddate),
      personmaritalstatusid: maritalInfo.personmaritalstatusid ? maritalInfo.personmaritalstatusid : null,
    };
  }
  // Associated with updateProfileView function
  private checkIfPersonbasicdetailsCondition5Fn() {
    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole) {
      this.personroleList = this.selectedPersonDetails.personbasicdetails.personrole;
      this.personRole = this.selectedPersonDetails.personbasicdetails.personrole;
      let roleType = null;
      if (this.personRole.ishouseholdmember === 1) {
        roleType = 'household';
      }
      if (this.personRole.ishouseholdmember === 2) {
        roleType = 'other';
        this.personRole.isheadofhousehold = false;
      }
      if (this.personRole.ishouseholdmember === 0) {
        roleType = 'collateral';
        this.personRole.isheadofhousehold = false;
      }
      this.involvedPersonFormGroup.patchValue({ roletype: roleType });
    }
    if (this._dataStoreService.getData('QUICK_PERSON_ID')) {
      this.involvedPersonFormGroup.patchValue({ clientflag: 1 });
    }

    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personspouseaddress && this.selectedPersonDetails.personbasicdetails.personspouseaddress.length) {
      this.personspouseaddressList = this.selectedPersonDetails.personbasicdetails.personspouseaddress[0];
    }
  }
  // Associated with updateProfileView function
  private checkIfPersonbasicdetailsCondition4Fn() {
    if (this.selectedPersonDetails.personbasicdetails && Array.isArray(this.selectedPersonDetails.personbasicdetails.personracetypemap)) {
      const parsedRace = this.selectedPersonDetails.personbasicdetails.personracetypemap.map((race: { racetypekey: any; }) => race.racetypekey);
      this.involvedPersonFormGroup.patchValue({ Race: parsedRace });
      this.changerace();
    }
    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.alias && this.selectedPersonDetails.personbasicdetails.alias.length) {
      this._personInfoService.aliasList = this.selectedPersonDetails.personbasicdetails.alias;
    } else {
      this._personInfoService.aliasList = [];
    }

    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personmaritalstatus && this.selectedPersonDetails.personbasicdetails.personmaritalstatus.length) {
      this.personmaritalstatusList = this.selectedPersonDetails.personbasicdetails.personmaritalstatus[0];
    }
  }
  // Associated with updateProfileView function
  private conditionToPatchCitizenalenageflagDataFn() {
    if (this.selectedPersonDetails.personbasicdetails) {
      if (this.selectedPersonDetails.personbasicdetails.citizenalenageflag === 1) {
        this.involvedPersonFormGroup.patchValue({
          citizenalenageflag: 1
        });
      } else if (this.selectedPersonDetails.personbasicdetails.citizenalenageflag === 0) {
        this.involvedPersonFormGroup.patchValue({
          citizenalenageflag: 0
        });
      }
    }
  }
  // Associated with updateProfileView function
  private checkIfPersonbasicdetailsCondition3Fn() {
    if (this.returnPersonbasicdetailsCondition()) {
      if (this.selectedPersonDetails.personbasicdetails.everbeenadoptedflag === 1) {
        this.involvedPersonFormGroup.patchValue({
          everbeenadoptedflag: 1
        });
      } else if (this.selectedPersonDetails.personbasicdetails.everbeenadoptedflag === 0) {
        this.involvedPersonFormGroup.patchValue({
          everbeenadoptedflag: 0
        });
      } else if (this.selectedPersonDetails.personbasicdetails.everbeenadoptedflag === 2) {
        this.involvedPersonFormGroup.patchValue({
          everbeenadoptedflag: 2
        });
      }
    }

    if (this.returnPersonbasicdetailsCondition()) {
      if (this.selectedPersonDetails.personbasicdetails.intercountryadoption === 1) {
        this.involvedPersonFormGroup.patchValue({
          intercountryadoption: 1
        });
      } else if (this.selectedPersonDetails.personbasicdetails.intercountryadoption === 0) {
        this.involvedPersonFormGroup.patchValue({
          intercountryadoption: 0
        });
      }
    }

    if (this.returnPersonbasicdetailsCondition()) {
      if (this.selectedPersonDetails.personbasicdetails.priorlegalguardianship === 1) {
        this.involvedPersonFormGroup.patchValue({
          priorlegalguardianship: 1
        });
      } else if (this.selectedPersonDetails.personbasicdetails.priorlegalguardianship === 0) {
        this.involvedPersonFormGroup.patchValue({
          priorlegalguardianship: 0
        });
      }
      else if (this.selectedPersonDetails.personbasicdetails.priorlegalguardianship === 2) {
        this.involvedPersonFormGroup.patchValue({
          priorlegalguardianship: 2
        });
      }
    }
  }
  // Associated with updateProfileView function
  private returnPersonbasicdetailsCondition() {
    return (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails);
  }
  // Associated with updateProfileView function
  private checkIfPersonbasicdetailsCondition2Fn() {
    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.deselectreason && this.selectedPersonDetails.personbasicdetails.deselectreason !== '') {
      this.showReasonInput = true;
    }

    if (this.selectedPersonDetails.personbasicdetails.senstatusflag == 1) {
      this.senHistoryFlag = 'Active ';
    } else if (this.selectedPersonDetails.personbasicdetails.senstatusflag == 0) {
      this.senHistoryFlag = 'Historic ';
    }
    this.updateCheckboxState();
    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.birthmatchflag === 1 && this.selectedPersonDetails.personbasicdetails.birthmatchupdatedon && this.selectedPersonDetails.personbasicdetails.birthmatchupdatedon !== '') {
      this.birthMatchUpdatedOn = this.selectedPersonDetails.personbasicdetails.birthmatchupdatedon;
      if ((moment().diff(moment(this.birthMatchUpdatedOn), 'days')) >= 60 || this.isClosed) {
        this.birthMatchStatus = ' (History)';
      } else {
        this.birthMatchStatus = ' (Active)';
      }
    }
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataFn(personrole: any, roleType: string, isheadofhousehold: boolean, personbasicdetails: any) {
    return {
      ...this.patchInvolvedPersonFormGroupDataMerge1Fn(),
      ...this.patchInvolvedPersonFormGroupDataMerge2Fn(personrole),

      // DangerousselfReason: this.selectedPersonDetails
      //   .personbasicdetails
      //   ? this.selectedPersonDetails.personbasicdetails
      //     .dangertoselfreason
      //   : '',
      ...this.patchInvolvedPersonFormGroupDataMerge3Fn(roleType),
      ...this.patchInvolvedPersonFormGroupDataMerge4Fn(),
      ...this.patchInvolvedPersonFormGroupDataMerge5Fn(),
      ...this.patchInvolvedPersonFormGroupDataMerge6Fn(isheadofhousehold),
      ...this.patchInvolvedPersonFormGroupDataMerge7Fn(personbasicdetails)
    };
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataMerge7Fn(personbasicdetails: any) {
    return {
      biologicalmothermarriedsw: personbasicdetails ? personbasicdetails.biologicalmothermarriedsw : null,
      clientflag: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.clientflag : null,
      birthmatchflag: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.birthmatchflag : null,
      notificationdate: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.notificationdate : null,
      deselectreason: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.deselectreason : null,
      icwastatusinquiry: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.icwastatusinquiry : null,
      icwanotify: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.notify_icwa : null,
      icwaeligibleformembership: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.icwaeligibleformembership : null,
      icwatribename: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.icwatribename : null,
      icwaunderdefinition: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.icwaunderdefinition : null,
      icwanotification: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.icwanotification : null,
      icwatribelegalnotice: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.icwatribelegalnotice : null
    };
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataMerge6Fn(isheadofhousehold: boolean) {
    return {
      hairtexturetypekey: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.hairtexturetypekey : null,
      eyecolortypekey: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.eyecolortypekey : null,
      physicalbuildtypekey: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.physicalbuildtypekey : null,
      skintonetypekey: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.skintonetypekey : null,
      hairtextureotherdesc: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.hairtextureotherdesc : null,
      haircolorotherdesc: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.haircolorotherdesc : null,
      isglasses: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.isglasses : null,
      employername: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.employername : null,
      clienttitle: this.selectedPersonDetails.personbasicdetails ? this.selectedPersonDetails.personbasicdetails.clienttitle : null,
      //@Simar: On editing the user photo gets lost - Patch existing user photo to the form control so that when saving again it retains old value
      userphoto: this.userphotoforEdit ? this.userphotoforEdit : this.returnUserphotoFn(),
      isheadofhousehold: isheadofhousehold
    };
  }
  // Associated with updateProfileView function
  private returnUserphotoFn() {
    return (this.userphoto ? this.userphoto : '');
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataMerge5Fn() {
    return {
      primarycitizenship: (this.involvedPersonFormGroup?.get('citizenalenageflag')?.value && this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.primarycitizenship) ?
        this.selectedPersonDetails.personbasicdetails.primarycitizenship : '',
      secondarycitizenship: (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.secondarycitizenship) ?
        this.selectedPersonDetails.personbasicdetails.secondarycitizenship : '',
      nationality: (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.nationalitytypekey) ?
        this.selectedPersonDetails.personbasicdetails.nationalitytypekey : '',
      isqualifiedalien: (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.isqualifiedalien)
        ? ('' + this.selectedPersonDetails.personbasicdetails.isqualifiedalien) : null,
      astatus: this.selectedPersonDetails.personbasicdetails
        ? this.selectedPersonDetails.personbasicdetails.alienstatustypekey : '',
      arnumber: (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.alienregistrationtext) ?
        this.selectedPersonDetails.personbasicdetails.alienregistrationtext : '',
      verificationremarks: this.selectedPersonDetails.personbasicdetails
        ? this.selectedPersonDetails.personbasicdetails.verificationremarks : '',
      roles: this.rolesList,
      haircolortypekey: this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.haircolortypekey ? this.selectedPersonDetails.personbasicdetails.haircolortypekey : null
    };
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataMerge4Fn() {
    return {
      probationsearchconductedflag: this.returnProbationsearchconductedflagConditionFn() ? true : false,
      safehavenbabyflag: this.returnSafehavenbabyflagConditionFn() ? true : false,
      // everbeenadoptedflag: (modal.everbeenadoptedflag === 1) ? true : false,
      everbeenadoptedflag: this.selectedPersonDetails.personbasicdetails ? this.returnEverbeenadoptedflagFn() : null,
      intercountryadoption: this.selectedPersonDetails.personbasicdetails ? this.returnIntercountryadoptionFn() : null,
      priorlegalguardianship: this.selectedPersonDetails.personbasicdetails ? this.returnPriorlegalguardianshipFn() : null,
      cferesourcehomechild: this.selectedPersonDetails.personbasicdetails ? this.returnCferesourcehomechildFn() : false,
      citizenalenageflag: this.returnCitizenalenageflagConditionFn(),
      limitedenglishproficiency: this.selectedPersonDetails.personbasicdetails?.limitedenglishproficiency,
      readingproficiency: this.selectedPersonDetails.personbasicdetails?.readingproficiency,
      writingproficiency: this.selectedPersonDetails.personbasicdetails?.writingproficiency,
      speakingproficiency: this.selectedPersonDetails.personbasicdetails?.speakingproficiency,
      needtranslatorinterpreter: this.selectedPersonDetails.personbasicdetails?.needtranslatorinterpreter
    };
  }
  // Associated with updateProfileView function
  private returnCferesourcehomechildFn() {
    return (!!this.selectedPersonDetails.personbasicdetails.cferesourcehomechild ? true : false);
  }
  // Associated with updateProfileView function
  private returnPriorlegalguardianshipFn() {
    return (this.selectedPersonDetails.personbasicdetails.priorlegalguardianship ? this.selectedPersonDetails.personbasicdetails.priorlegalguardianship : null);
  }
  // Associated with updateProfileView function
  private returnIntercountryadoptionFn() {
    return (this.selectedPersonDetails.personbasicdetails.intercountryadoption ? this.selectedPersonDetails.personbasicdetails.intercountryadoption : null);
  }
  // Associated with updateProfileView function
  private returnEverbeenadoptedflagFn() {
    return (this.selectedPersonDetails.personbasicdetails.everbeenadoptedflag ? this.selectedPersonDetails.personbasicdetails.everbeenadoptedflag : null);
  }
  // Associated with updateProfileView function
  private returnCitizenalenageflagConditionFn() {
    return (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.citizenalenageflag)
      ? ('' + this.selectedPersonDetails.personbasicdetails.citizenalenageflag) : null;
  }
  // Associated with updateProfileView function
  private returnProbationsearchconductedflagConditionFn() {
    return (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole && this.selectedPersonDetails.personbasicdetails.personrole.probationsearchconductedflag === 1);
  }
  // Associated with updateProfileView function
  private returnSafehavenbabyflagConditionFn() {
    return (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.safehavenbabyflag === 1);
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataMerge3Fn(roleType: string) {
    return {
      personid: this.selectedPersonDetails.personbasicdetails ? this.returnPersonidFn() : null,
      iscollateralcontact: (this.selectedPersonDetails.personroledetails) ? this.selectedPersonDetails.personroledetails.actor.iscollateralcontact : null,
      roletype: roleType,
      substanceexposednewbornflag: (this.selectedPersonDetails.personbasicdetails.substanceexposednewbornflag === 1) ? true : false,
      substanceexposednewbornsourceid: this.selectedPersonDetails.personbasicdetails.substanceexposednewbornsourceid,
      substanceexposednewbornsourcetypekey: this.selectedPersonDetails.personbasicdetails.substanceexposednewbornsourcetypekey,
      substanceexposednewborntimetamp: this.selectedPersonDetails.personbasicdetails.substanceexposednewborntimetamp,
      substanceclasses: this.listShown =='old' ? this.selectedPersonDetails.personbasicdetails.substanceclasses : this.substanceClassPlaceholder,
      sencriteria: this.selectedPersonDetails.personbasicdetails.sencriteria,
      birthinghospital: this.selectedPersonDetails.personbasicdetails.birthinghospital,
      othersubstances: this.selectedPersonDetails.personbasicdetails.othersubstances,
      // fetalalcoholspctrmdisordflag: (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.fetalalcoholspctrmdisordflag === 1) ? true : false,
      drugexposednewbornflag: ((this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole
        && this.selectedPersonDetails.personbasicdetails.personrole.drugexposednewbornflag === 1) || this.selectedPersonDetails.personbasicdetails.drugexposednewbornflag === 1) ? true : false,
      // probationsearchconductedflag: (this.selectedPersonDetails
      //   .personroledetails) ? this.selectedPersonDetails
      //     .personroledetails.actor.probationsearchconductedflag : null,
      // probationsearchconductedflag: (modal.probationsearchconductedflag === 1) ? true : false,
      sexoffenderregisteredflag: (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole
        && this.selectedPersonDetails.personbasicdetails.personrole.sexoffenderregisteredflag === 1) ? true : false
    };
  }
  // Associated with updateProfileView function
  private returnPersonidFn() {
    return (this.selectedPersonDetails.personbasicdetails.personid ? this.selectedPersonDetails.personbasicdetails.personid : '');
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataMerge2Fn(personrole: any) {
    return {
      primarylanguage: (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.primarylanguageid) ?
        this.selectedPersonDetails.personbasicdetails.primarylanguageid : 'ENG',
      hasAlias: (this.selectedPersonDetails.personbasicdetails) ? this.returnHasAliasFn() : null,
      aliasname: this.returnAliasnameConditionFn() ? this.selectedPersonDetails.personbasicdetails.alias[0].firstname : '',
      dangerousself: this.returnPatchPersonRoleDataFn(personrole, personrole?.dangertoself),
      ismentalimpair: this.returnPatchPersonRoleDataFn(personrole, personrole?.ismentalimpair),
      Dangerousworker: this.returnPatchPersonRoleDataFn(personrole, personrole?.isdangertoworker),
      ismentalillness: this.returnPatchPersonRoleDataFn(personrole, personrole?.ismentalillness),

      otherdrugs: this.returnPatchPersonRoleDataFn(personrole, personrole?.otherdrugs),
      drugexposedtypekey: personrole ? (personrole?.drugexposedtypekey) : this.returnDrugexposedtypekeyFn(),

      dangerousselfreason: this.returnPatchPersonRoleDataFn(personrole, personrole?.dangertoselfreason),
      DangerousWorkerReason: this.returnPatchPersonRoleDataFn(personrole, personrole?.dangertoworkerreason),
      ismentalillnessReason: this.returnPatchPersonRoleDataFn(personrole, personrole?.mentalillnessdetail),
      ismentalimpairReason: this.returnPatchPersonRoleDataFn(personrole, personrole?.mentalimpairdetail),

      initialresponse: personrole ? this.returnInitialresponseFn(personrole) : null,
      initialresponseupdatedby: this.returnPatchPersonRoleDataFn(personrole, personrole?.initialresponseupdatedby),
      initialresponseupdatedon: this.returnPatchPersonRoleDataFn(personrole, personrole?.initialresponseupdatedon)
    };
  }
  // Associated with updateProfileView function
  private returnInitialresponseFn(personrole: any) {
    return ((personrole?.initialresponse == 1) ? "yes" : this.returnInitialresponseIfZeroFn(personrole));
  }
  // Associated with updateProfileView function
  private returnInitialresponseIfZeroFn(personrole: any) {
    return ((personrole?.initialresponse == 0) ? "no" : null);
  }
  // Associated with updateProfileView function
  private returnDrugexposedtypekeyFn() {
    return (this.selectedPersonDetails.personbasicdetails.drugexposedtypekey ? this.selectedPersonDetails.personbasicdetails.drugexposedtypekey : null);
  }
  // Associated with updateProfileView function
  private returnHasAliasFn() {
    return (this.selectedPersonDetails.personbasicdetails.alias.length ? true : null);
  }
  // Associated with updateProfileView function
  private returnAliasnameConditionFn() {
    return this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.alias && Array.isArray(this.selectedPersonDetails.personbasicdetails.alias) && this.selectedPersonDetails.personbasicdetails.alias.length;
  }
  // Associated with updateProfileView function
  private returnPatchPersonRoleDataFn(personrole: any, data: any) {
    return (personrole ? data : null);
  }
  // Associated with updateProfileView function
  private patchInvolvedPersonFormGroupDataMerge1Fn() {
    return {
      mdm_id: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.mdm_id),
      tribalassociation: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails.tribalassociation),
      prefix: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.prefix),
      Lastname: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.lastname),
      Firstname: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.firstname),
      Middlename: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.middlename),
      nameSuffix: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.suffix),
      maritalstatustypekey: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.maritalstatustypekey !== '99' ? this.selectedPersonDetails.personbasicdetails?.maritalstatustypekey : null),
      Dob: this.returnPatchInvolvedPersonFormGroupDataFn(moment(this.selectedPersonDetails.personbasicdetails?.dob).format(this.dtformat)),
      preadptdate: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.preadoptiondate),
      preplacementguardianshipdate: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.preplacementguardianshipdate),
      dateofdeath: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.dateofdeath),
      isapproxdod: this.returnPatchInvolvedPersonFormGroupDataFn((this.selectedPersonDetails.personbasicdetails?.isapproxdod === 1 ? true : null)),
      isapproxdob: this.returnPatchInvolvedPersonFormGroupDataFn((this.selectedPersonDetails.personbasicdetails?.isapproxdob === 1 ? true : false)),
      gendertypekey: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.gendertypekey),
      othergendertypekey: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.othergendertypekey),
      religiontypekey: this.selectedPersonDetails.personbasicdetails ? (this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.religiontypekey)) : null,
      otherreligion: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.otherreligion),
      Dangerous: '',
      dangerAddress: '',
      SSN: this.selectedPersonDetails.personbasicdetails ? this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.ssnno) : null,
      ssnverified: this.selectedPersonDetails.personbasicdetails ? this.returnSsnverifiedFn() : null,
      ethnicgrouptypekey: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.ethnicgrouptypekey),
      occupation: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.occupation),
      strengths: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.strengths),
      needs: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.needs),
      stateid: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.stateid),
      secondarylanguage: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.secondarylanguageid),
      otherprimarylanguage: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.otherprimarylanguagetypekey),
      licensedfacilitykey: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.licensedfacilitykey),
      livingsituationdesc: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.livingsituationdesc),
      livingsituationkey: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.livingsituationkey),
      livingarrangementdesc: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.livingarrangementdesc),
      livingarrangementkey: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.livingarrangementkey),
      otherlicensedfacility: this.returnPatchInvolvedPersonFormGroupDataFn(this.selectedPersonDetails.personbasicdetails?.otherlicensedfacility),
    };
  }
  // Associated with updateProfileView function
  private returnSsnverifiedFn() {
    return (this.selectedPersonDetails.personbasicdetails?.ssnverified === true ? true : null);
  }
  // Associated with updateProfileView function
  private returnPatchInvolvedPersonFormGroupDataFn(data: any) {
    return this.selectedPersonDetails.personbasicdetails ? data : null;
  }
  // Associated with updateProfileView function
  private conditionForHeadofhouseholdFn() {
    let isheadofhousehold = false;
    if (this.selectedPersonDetails.personroledetails && this.selectedPersonDetails.personroledetails.actor.intakeservicerequestactor.length) {
      const actorRoles = this.selectedPersonDetails.personroledetails.actor.intakeservicerequestactor.filter((item: { isheadofhousehold: boolean; }) => item.isheadofhousehold === true);
      isheadofhousehold = actorRoles.length > 0;
    }

    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.dob) {
      this._dataStoreService.setData(IntakeStoreConstants.DATE_OF_BIRTH, moment(this.selectedPersonDetails.personbasicdetails.dob));
    }
    return isheadofhousehold;
  }
  // Associated with updateProfileView function
  private conditionForPersonRoleFn() {
    let personrole;
    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole) {
      personrole = this.selectedPersonDetails.personbasicdetails.personrole;
      if (personrole?.initialresponseupdatedon) {
        personrole.initialresponseupdatedon = moment(personrole.initialresponseupdatedon).format('YYYY-MM-DD hh:mm A');
      }
    }
    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole != null) {
      this.initialrespreadonly = true;
    }

    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.haircolortypekey && this.selectedPersonDetails.personbasicdetails.haircolortypekey === '1298') {
      this.showOtherColor = true;
    } else {
      this.showOtherColor = false;
    }

    if (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.hairtexturetypekey && this.selectedPersonDetails.personbasicdetails.hairtexturetypekey === '1305') {
      this.showOtherTexture = true;
    } else {
      this.showOtherTexture = false;
    }
    return personrole;
  }
  // Associated with updateProfileView function
  private conditionForRoleTypeFn() {
    let roleType = '';
    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole) {
      if (this.selectedPersonDetails.personbasicdetails.personrole.ishouseholdmember === 1) {
        roleType = 'household';
        this.invokeValidators(1);
      } else if (this.selectedPersonDetails.personbasicdetails.personrole.ishouseholdmember === 2) {
        roleType = 'other';
        this.invokeValidators(1);
      } else if (this.selectedPersonDetails.personbasicdetails.personrole.iscollateralcontact === 1) {
        roleType = 'collateral';
      }
    }
    return roleType;
  }
  // Associated with updateProfileView function
  private checkIfPersonbasicdetailsCondition1Fn() {
    if (this.selectedPersonDetails.personbasicdetails.drugexposednewbornflag == 1) {
      this.senNewBorn = false;
    }
    if (this.selectedPersonDetails.personbasicdetails.caregiverData && this.selectedPersonDetails.personbasicdetails.caregiverData.length > 0) {
      this.maritalStatus = true;
      this.involvedPersonFormGroup.controls["maritalstatustypekey"].setValidators([Validators.required])
    } else {
      this.maritalStatus = false;
      this.involvedPersonFormGroup.controls["maritalstatustypekey"].setValidators([])
    }
    if (this.selectedPersonDetails.personbasicdetails && this.selectedPersonDetails.personbasicdetails.personrole && this.selectedPersonDetails.personbasicdetails.personrole.Personroletype && this.selectedPersonDetails.personbasicdetails.personrole.Personroletype.length) {
      this.existingRoleId = this.selectedPersonDetails.personbasicdetails.personrole.Personroletype[0].personroleid;
    }
    if (this.selectedPersonDetails.personroledetails && this.selectedPersonDetails.personroledetails.actor) {
      const roleArray = this.selectedPersonDetails.personroledetails.actor.intakeservicerequestactor;
      const roleArrayFilter = (roleArray && roleArray.length) ? roleArray.filter((role: { spexpungementflag: any; }) => !role.spexpungementflag) : [];
      this.rolesList = (roleArrayFilter && roleArrayFilter.length) ? roleArrayFilter.map((data: { intakeservicerequestpersontypekey: any; }) => data.intakeservicerequestpersontypekey) : [];
      this.duplicateRolesListForAM = this.rolesList;
    }
  }

  /**
   * load gender
   */

  loadDropdowns():void{
    this._commonDropdownService.getPickListByName('gender').subscribe(
      (payload: any) => {
        if (payload.length > 0) {
          if (this.involvedPersonFormGroup.controls['gendertypekey'].value === 'TG') {
            this.genderDropdownItems = payload.filter((data: { ref_key: string; }) => data.ref_key !== 'U');
          } else if (this.involvedPersonFormGroup.controls['gendertypekey'].value === 'U') {
            this.genderDropdownItems = payload.filter((data: { ref_key: string; }) => data.ref_key !== 'TG');
          }
          else {
            this.genderDropdownItems = payload.filter((data: { ref_key: string; }) => data.ref_key !== 'TG' && data.ref_key !== 'U');
          }
        }
      }
    )

    this._commonDropdownService.getPickListByName('race').subscribe(
      (resp: any) => {
        if(resp.length > 0){
          if(this.involvedPersonFormGroup.controls['Race'].value.includes('LA')){
            this.racetypeDropdownItems = resp;
          }else{
            this.racetypeDropdownItems = resp.filter((data: { ref_key: string; }) => data.ref_key !== 'LA');
          }
          if(!this.involvedPersonFormGroup.controls['Race'].value.includes('OT')) {
            this.racetypeDropdownItems = this.racetypeDropdownItems.filter((data) => data.ref_key !== 'OT');
          }
        }
      }
    );

    this._commonDropdownService.getPickListByName('maritalstatus').subscribe((allItems) => {
      const allowedItems = allItems.filter(item =>
        this.allowedMaritalStatusKeys.includes(item.ref_key)
      );
  
      this.maritalDropdownItems$ = observableOf(
        allowedItems.concat(
          allItems.find(item =>
            item.ref_key === this.maritalStatusInitialKey &&
            !this.allowedMaritalStatusKeys.includes(item.ref_key)
          ) || []
        )
      );
    });

  }


  dangerQuestionChange(ques: string) {
    const ans = this.involvedPersonFormGroup?.getRawValue()[ques];
    if (ques === 'dangerousself' && ans !== 1) {
      this.involvedPersonFormGroup.patchValue({
        dangerousselfreason: '',
      });
    } else if (ques === 'Dangerousworker' && ans !== 1) {
      this.involvedPersonFormGroup.patchValue({
        DangerousWorkerReason: '',
      });
    } else if (ques === 'ismentalillness' && ans !== 1) {
      this.involvedPersonFormGroup.patchValue({
        ismentalillnessReason: '',
      });
    } else if (ques === 'ismentalimpair' && ans !== 1) {
      this.involvedPersonFormGroup.patchValue({
        ismentalimpairReason: '',
      });
    }
  }

  hairColorChange(value: string) {
    if (value === '1298') {
      this.showOtherColor = true;
    } else {
      this.showOtherColor = false;
    }
  }

  hairTextureChange(value: string) {
    if (value === '1305') {
      this.showOtherTexture = true;
    } else {
      this.showOtherTexture = false;
    }
  }

  profileUpdateListener() {
    // update here....
    if (this._personInfoService.personInfo) {
      this.updateProfileView(this._personInfoService.personInfo);
    }else{
      this.loadDropdowns();
    }
    this.profileUpdateSubscription = this._personInfoService.personInfoListener$.subscribe(personInfo => {
      setTimeout(() => {
        if (this._personInfoService.personInfo) {
          this.updateProfileView(personInfo);
        }
        if (this._personInfoService.personInfo?.personbasicdetails?.maritalstatustypekey) {
          this.maritalStatusInitialKey = this._personInfoService.personInfo.personbasicdetails.maritalstatustypekey;
        }
  
        this.loadDropdowns();
      }, 2000);

    });
  }

  getSuggestedAddress() {
    if (this.involvedPersonFormGroup.value.spouseaddress1 &&
      this.involvedPersonFormGroup.value.spouseaddress1.length >= 3) {
      this.suggestAddress();
    }
  }
  suggestAddress() {
    this._commonHttpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.involvedPersonFormGroup.value.spouseaddress1,
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
        (suggestAddResult: any) => {
          if (suggestAddResult.length > 0) {
          this.suggestedAddress$ = observableOf(suggestAddResult);
        } else {
          this.suggestedAddress$ = observableOf([]);
        }
        }
      );
  }
  selectedAddress(model: any) {
    this.involvedPersonFormGroup?.patchValue({
      spouseaddress1: model.streetLine ? model.streetLine : '',
      spousecity: model.city ? model.city : '',
      spousestate: model.state ? model.state : ''
    });
    const addressInput = {
      street: model.streetLine ? model.streetLine : '',
      street2: '',
      city: model.city ? model.city : '',
      state: model.state ? model.state : '',
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
          (selectedAddResult) => {
              if (selectedAddResult?.[0]?.analysis) {
                this.involvedPersonFormGroup.patchValue({
                    spousezipcode: selectedAddResult?.[0]?.components.zipcode ? selectedAddResult[0].components.zipcode : ''
                });
                if (selectedAddResult?.[0]?.metadata?.countyName) {
                  this._commonHttpService.getArrayList(
                  {
                      nolimit: true,
                      where: { referencetypeid: 306,  mdmcode: {"like": this.involvedPersonFormGroup.value.spousestate + "~%25","options":"i" }, description: selectedAddResult[0].metadata.countyName}, method: 'get'
                    },
                    'referencevalues?filter'
                ) .subscribe(
                  (resultresp) => {
                    this.involvedPersonFormGroup.patchValue({
                      spousecounty: resultresp?.[0]?.ref_key
                  });

                  }
                );
              }
               }
              } ,
              (error) => {
                  // No data or function to add or call
              }
      );
  }


  toggle(event: any) {
   // No data or function to add or call
  }

  patchimagedata(imagedata: { s3bucketpathname: any; }) {
    // Keep userphotoforEdit in step with the control - updateProfileView patches the control back
    // from userphotoforEdit, so leaving it stale here silently discards the photo just picked
    this.userphotoforEdit = imagedata.s3bucketpathname;
    this.userphoto = imagedata.s3bucketpathname;
    this.involvedPersonFormGroup.patchValue({
      userphoto: imagedata.s3bucketpathname
    });
  }

  showIcwaModal(type: 'race' | '60days' | 'notify_unknown') {
    this.icwaModalType = type;
    if (type === 'race') {
      this.icwaModalTitle = 'ICWA Confirmation';
      this.icwaModalMessage = `You have indicated that this child is ICWA but not an American Indian and/or Alaskan Native in the Race dropdown. Are you sure you want to proceed?`;
    } else if (type === '60days') {
      this.icwaModalTitle = 'ICWA 60 Days Notification';
      this.icwaModalMessage = `Please update this child’s ICWA status based on the ICWA Inquiry Response`;
    } else if (type === 'notify_unknown') {
      this.icwaModalTitle = 'ICWA Notification';
      this.icwaModalMessage = `Please update this child’s ICWA status once the response has been received from the tribal authority and within 60 days.`;
    }
    setTimeout(() => {
      ($('#icwa-common-modal') as any).modal('show');
    });
  }

  closeIcwaModal() {
    this.icwaModalType = null;
    this.icwaModalTitle = '';
    this.icwaModalMessage = '';
    ($('#icwa-common-modal') as any).modal('hide');
  }

  handleIcwaModalAction(result: boolean) {
    if (this.icwaModalType === 'race') {
      this.showIcwaRaceModalHandler(result);
    } else if (this.icwaModalType === '60days') {
      this.showIcwa60DaysModalHandler(false);
    } else if (this.icwaModalType === 'notify_unknown') {
      this.showIcwaNotifyUnknownModalHandler(false);
    }
    this.closeIcwaModal();
  }

  showIcwa60DaysModalHandler(show: boolean) {
    this.showIcwa60DaysModal = show;
    if (show) {
      this.showIcwaModal('60days');
    } else {
      this.closeIcwaModal();
    }
  }

  showIcwaNotifyUnknownModalHandler(show: boolean) {
    this.showIcwaNotifyUnknownModal = show;
    if (show) {
      this.showIcwaModal('notify_unknown');
    } else {
      this.closeIcwaModal();
    }
  }

  triggerIcwa60DaysModalIfNeeded() {
    if (this.involvedPersonFormGroup.controls['icwanotify'].value === 'YES') {
      this.showIcwa60DaysModalHandler(true);
    }
  }

  showIcwaRaceModalHandler(proceed: boolean) {
    if (proceed) {
      this.icwaRaceProceed = true;
      this.saveAddOrUpdatePerson();
    }
  }

  changerace() {
   this.racelist = this.involvedPersonFormGroup?.getRawValue().Race.filter((data: string) => data !== 'UN');
   if (this.racelist.length > 0) {
    this.setraceunkown = 'UN';
   } else {
    this.setraceunkown = '';
   }
   const unknownracelist = this.involvedPersonFormGroup?.getRawValue().Race.filter((data: string) => data === 'UN');
   if (unknownracelist.length > 0){
      this.isRaceUnknownFlag = true;
    } else {
      this.isRaceUnknownFlag = false;
    }
  }

  saveAddOrUpdatePerson() {
    ['Firstname', 'Middlename', 'Lastname'].forEach(f => {
      const control = this.involvedPersonFormGroup.get(f);
      const val = control?.value;

      if (typeof val === 'string') {
        control?.setValue(val.trim());
        control?.updateValueAndValidity();
      }
    });
    const effectiveDate = this.selectedPersonDetails?.personbasicdetails?.effectivedate;
    const primarylanguage = this.involvedPersonFormGroup.getRawValue().primarylanguage;
    if (!this.validateEffectiveDate(effectiveDate) && primarylanguage === 'UNKN') {
    this.showProfileErrorMessage(
        'The Primary Language field for this client is still set to "Unknown" and has exceeded the 5-business-day compliance window. Please update this field so the system has accurate client communication information.'
      );      return;
    } // if effective date exceeded more than 5 days and primaryLanguage is unknw then stop save function.
    this.isValuesUpdated = false;
    if (this.involvedPersonFormGroup.value.icwastatusinquiry === 'NO') {
      this.involvedPersonFormGroup.patchValue({
        icwaunderdefinition: null,
        icwaeligibleformembership: null,
        icwatribename: null,
        icwanotification: null,
        icwatribelegalnotice: null
      });
    }
    const formValue = this.involvedPersonFormGroup.getRawValue();
    if (formValue.icwaunderdefinition === 'NO' || formValue.icwaunderdefinition === 'UNKNOWN') {
      this.involvedPersonFormGroup.patchValue({
        icwatribelegalnotice: null,
        icwanotification: null,
        icwatribename: null,
      });
    }
    if (formValue.icwaunderdefinition === 'YES') {
      const raceArr = Array.isArray(formValue.Race) ? formValue.Race : [];
      const raceKeys = raceArr.map((r: any) => typeof r === 'string' ? r : r.racetypekey);
      if (!raceKeys.includes('AI') && !raceKeys.includes('AN') && !this.icwaRaceProceed) {
        this.showIcwaModal('race');
        return;
      }
    }
    this.icwaRaceProceed = false;
    if (this.involvedPersonFormGroup.getRawValue().dateofdeath && this.isSaveConfirmPopup === true) {
      this.confrimMessage = `As the Child’s DOD is added this will update the SDM Child Fatality as YES and the case will be submitted for Change Pathway from CPS AR to CPS IR. Do you still want to proceed?<br/><br/>If you are entering a DOD for a child where maltreatment is not suspected, select “No”, enter a new referral with the information about the child’s death and screen it out. The date of death will update on the person card, and the pathway will not change.`;
      this.isConfrimPopup = true;
      this.globalPopupRef.openConfirmationModal();
    }
    else { this.addOrUpdatePerson(); }
     }
    validateEffectiveDate(effectiveDate: any): boolean {
    if (!effectiveDate || effectiveDate === null || effectiveDate === undefined) return true;
  
    const now = new Date();
  
    const eff = /^\d{4}-\d{2}-\d{2}$/.test(effectiveDate)
      ? new Date(effectiveDate + "T00:00:00")   // date-only -> midnight
      : new Date(effectiveDate);               // datetime
  
    if (isNaN(eff.getTime())) return false;
  
    const diffDays = (now.getTime() - eff.getTime()) / (1000 * 60 * 60 * 24);
  
    return diffDays >= 0 && diffDays <= 5;
  }
  confrimedSave(res: any) {
    if (this.isConfrimPopup) {
    if (res) {
      this.saveIntakeservicerequestsdm();
      this.addOrUpdatePerson();
    }
    }

    if(this.isOpenedIncidentDateModal) {
        this.closeOverdueRolePopup();
        this.isOpenedIncidentDateModal = false;
        let intakenumber = this.store[IntakeStoreConstants.intakenumber];
        const url = '/pages/newintake/my-newintake/' + intakenumber + '/edit/narrative';
        this._router.navigate([url], { relativeTo: this.route });
        this._dataStoreService.setData('NarrativeDateChange', {isUpdated: true});
    }
    this.globalPopupRef.closeConfirmationModal();
  }
  private addOrUpdatePerson(senStatus?: any) {
    if (this.handleBlockedSubmitGuard(senStatus)) {
      return;
    }
      ['readingproficiency', 'writingproficiency', 'speakingproficiency'].forEach((key) => {
      if (!this.involvedPersonFormGroup.get(key)?.value) {
        this.involvedPersonFormGroup.patchValue({ [key]: false });
      }
    });

    if(!this.involvedPersonFormGroup?.getRawValue().Dob) {
      this.displayValidationMessages = true;
      this.getErrorsMessage('Dob','Date of Birth');
      return;
    }
    const dob = new Date(moment(this.involvedPersonFormGroup?.getRawValue().Dob).format('MM/DD/YYYY'));
    if (this.minDate > dob) {
      this._alertService.warn('Selected DOB should be greater than 01/01/1900');
      return;
    }

    const data1 = this.involvedPersonFormGroup.getRawValue();

    if (data1.maritalstatustypekey && !this.allowedMaritalStatusKeys.includes(data1.maritalstatustypekey)) {
      this.showLegacyStatusAlert();
      return;
    }

    if (!this.isBlockPersonSaveNotification) {
      this.addOrUpdatePersonCondition1Fn();
    }
    if (senStatus != 'Approved' && (this.senHistoryList && this.senHistoryList.length > 0 && this.senHistoryList[0].approval_status === 'Pending')) {
      this.involvedPersonFormGroup.patchValue({
        substanceexposednewbornflag: 1
      });
    }
    const data = this.involvedPersonFormGroup.getRawValue();
    if(this.involvedPersonFormGroup.controls['birthinghospital'].value=='Other' && this.smartyAddress.address1){
      if(this.smartyAddress.address2){
        data.birthinghospital = this.smartyAddress.address1 + ', ' + this.smartyAddress.address2 + ', ' + this.smartyAddress.city
              + ', ' + this.smartyAddress.county + ', ' + this.smartyAddress.state + ' ' + this.smartyAddress.zipcode;
      }else{
        data.birthinghospital = this.smartyAddress.address1 + ', ' + this.smartyAddress.city
              + ', ' + this.smartyAddress.county + ', ' + this.smartyAddress.state + ' ' + this.smartyAddress.zipcode;
      }      
    }
    if(this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails?.substanceclasses){
      data.substanceclasses = this.selectedPersonDetails.personbasicdetails?.substanceclasses;
    }
    if(this.refKeystoSave.length>0){
      data.substanceclasses = this.refKeystoSave;
    }
    if(this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails ) {
      if(this.selectedPersonDetails.personbasicdetails?.substanceexposednewbornflag == 1) {
         this.selectedPersonDetails.personbasicdetails.substanceexposednewbornflag = true;
      } else {
         this.selectedPersonDetails.personbasicdetails.substanceexposednewbornflag = false;
      }
    } 
    if(!this.refKeystoSave.includes('OTDS')){
      data.othersubstances = null;
    }
    let senChanged = false;
    if (
      !this.isIntake && !senStatus && this.senHistoryFlag?.trim() !== 'Historic' && this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails &&
      (
        (this.selectedPersonDetails.personbasicdetails.substanceexposednewbornflag != data.substanceexposednewbornflag) ||
        (this.selectedPersonDetails.personbasicdetails.sencriteria !== data.sencriteria) || 
        (this.selectedPersonDetails.personbasicdetails.othersubstances !== data.othersubstances) ||
        (this.selectedPersonDetails.personbasicdetails.birthinghospital !== data.birthinghospital) || 
        (JSON.stringify(this.selectedPersonDetails.personbasicdetails.substanceclasses) != JSON.stringify(data.substanceclasses) && data.substanceclasses !== '')
      )
    ) {
      senChanged = true;
    }

    const otherPersonList = this.casePersonList ? this.returnCasePersonListTrueCondFn() : null;
    if(otherPersonList && otherPersonList.length > 0 && data.isheadofhousehold === true){
      this._alertService.warn('There is an Head of Household exist already')
      return;
    }

    this.addOrUpdatePersonCondition2Fn(data);

    if (data.SSN && this.SSNDuplicateFound) {
      this.showProfileErrorMessage(this.getSSNErrorMessage());
      return false;
    }

    this.addorUpdatePersonCond(data, senChanged);
  }
  
  private handleBlockedSubmitGuard(senStatus?: any): boolean {
    if (this.involvedPersonFormGroup.get('substanceexposednewbornflag')?.value ==  false || this.involvedPersonFormGroup.get('substanceexposednewbornflag')?.value ==  0) {
        this.involvedPersonFormGroup.get('substanceclasses')?.clearValidators();
        this.involvedPersonFormGroup.get('substanceclasses')?.updateValueAndValidity();
    }
    if (
      !senStatus &&
      ((this.involvedPersonFormGroup.pristine && !this.substancelistUpdated) ||
        (this.involvedPersonFormGroup.get('substanceexposednewbornflag')?.value == true && this.senHistoryFlag?.trim() !== 'Historic' && !this.involvedPersonFormGroup.get('sencriteria')?.value) ||
       this.involvedPersonFormGroup.invalid ||
       this.isClosed ||
       this.issavedisabled
    ) ){
      this.displayValidationMessages = true;
      this.involvedPersonFormGroup.markAllAsTouched();
      return true;
    }
    return false;
  }
  

  private addorUpdatePersonCond(data: any, senChanged: any){
    const roles = data.roles;
    let personRoleDetails: any[] = [];
    if (this.returnSelectedPersonDetailsFn()) {
      personRoleDetails = this.selectedPersonDetails.personbasicdetails.personrole.Personroletype;
    }

    let rolesData = [];

    if (roles && roles.length) {
     rolesData = roles.map((roleKey: any, index: any) => {
       return this.rolesListMapFn(roleKey, personRoleDetails);
     });
    }

    this.addOrUpdatePersonCondition3Fn(roles, personRoleDetails, rolesData, data);

    if (data.Race && Array.isArray(data.Race)) {
      data.Race = data.Race.map((race: any) => {
        return { 'racetypekey': race };
      });
    } else {
      data.Race = null;
    }

    this.addOrUpdatePersonCondition4Fn(data);
    if (!this.isBlockPersonSaveNotification) {
      this.onClickSaveForNonCPS();
    }
    if (senChanged && data.personid) {
      if(this.senHistoryList && this.senHistoryList.length) {
        this.submitSENRequest(false, 'Changed');
      }else {
        this.submitSENRequest(true, 'Created');
      }
    }
  }

  onClickSaveForNonCPS() {    
    this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
              where: { objectid: this.id, personid: this.selectedPersonDetails?.personbasicdetails?.personid },
              method: 'get',
              nolimit: true
          }),
          'Personprogramareas/getpersonprogramarea?filter'
      )
      .subscribe((programResult: any) => {
        const activeProg = programResult[0]?.personprogramarea?.filter((x: { objectid: string; enddate: any; }) => x?.objectid == this.id && !x?.enddate);
        if(!this.isCPS &&  (!activeProg || activeProg?.length == 0)){
          $('#identify-active-persons').modal('show');
        }
      });

  }

  clickOnIdentifyActiveOk() {
    $('#identify-active-persons').modal('hide');
  }

  closeOverdueRolePopup() {
    $('#identify-active-persons').modal('hide');
}
  // Associated to addOrUpdatePerson function
  private rolesListMapFn(roleKey: any, personRoleDetails: any) {
    if (this.rolesList?.indexOf(roleKey) !== -1) {
      const savedRole =
        personRoleDetails.find((role: { roletype: any; }) => role.roletype === roleKey);
      if (savedRole) {
        return {
          'personroletypeid': savedRole.personroletypeid,
          'personroleid': savedRole.personroleid,
          'roletype': savedRole.roletype,
          'isprimary': (savedRole.isprimary == "true" || savedRole.isprimary == "1") ? 1 : 0
        };
      }
      else {
        return {
          'personroletypeid': null,
          'personroleid': null,
          'roletype': roleKey,
          'isprimary': 0
        };
      }
    } else {
      return {
        'personroletypeid': null,
        'personroleid': null,
        'roletype': roleKey,
        'isprimary': 0
      };
    }
  }
  // Associated to addOrUpdatePerson function
  private returnCasePersonListTrueCondFn() {
    return this.casePersonList.filter((item: { personid: any; isheadofhousehold: boolean; }) => item.personid !== this._personInfoService.getPersonId() && item.isheadofhousehold === true);
  }
  // Associated to addOrUpdatePerson function
  private addOrUpdatePersonCondition4Fn(data: any) {
    if (data.citizenalenageflag === 1) {
      data.arnumber = null;
      data.astatus = null;
    }
    if (this._dataStoreService.getData('QUICK_PERSON_ID')) {
      data.clientflag = 1;
    }
    // ## CIS CLIENT ID need to be set if source is SDR person
    if (this._personInfoService.personInfo && this._personInfoService.personInfo.personbasicdetails) {
      data.cisclientid = this._personInfoService.personInfo.personbasicdetails.cisclientid;
    }
  
   this.setSdmPersonApprovalFlag(data);

    this.substanceexposednewbornflagFn(data);
    this.involvedPersonFormGroup.markAsPristine();
    this.issavedisabled = true;
    this._personInfoService.savePersonDetails(data, this.intakeData).subscribe(response => {
      const docid = this.returnDocidFn();
      if (response && response.Personid) {
        if(this.isDodChaged || this.isIntakeDodChanged) {
          this.childFatilityAudit();
        }
        if(!data.personid && data.substanceexposednewbornflag){
          this.submitSENRequest(true, 'Created',response.Personid);
        } 
        
        this.savePersonDetailsResponseFn(response, docid, data);
      } else {
        this.savePersonDetailsFailedResFn(response);
      }
      this.issavedisabled = false;
      this._personInfoService.setPersonDob(data.Dob);
      
      this.validateDateOfIncident();
    },
      error => {
        this.issavedisabled = false;
      }
    );
  }
  
  private setSdmPersonApprovalFlag(data: any): void {
    const isRoleTypeExist = this.selectedPersonDetails
      ?.personbasicdetails?.personrole?.Personroletype
      ?.filter((item: any) => ["AV", "CHILD", "OTHERCHILD"].includes(item.roletype));
  
    data.sdmpersonapprovalflag =
      (isRoleTypeExist?.length && this.ifCpsArFn() === 'AR' && this.involvedPersonFormGroup?.getRawValue().dateofdeath !== null)
        ? 1
        : null;
  }
  

    validateDateOfIncident() {
      const roles = this.involvedPersonFormGroup.controls['roles']?.value;
      if(roles.indexOf('AV') > -1) {
        const narrative = this.store[IntakeStoreConstants.addNarrative];
        const incidentdate = moment(narrative?.incidentdate);
        const dob = this.involvedPersonFormGroup.controls['Dob']?.value;
        const dateOfbirth = moment(dob);
        const diff = dateOfbirth.diff(incidentdate, 'months');
        if (diff >= 10) {
            this.confrimMessage = "Please confirm that the incident date recorded in this intake record is correct. The date of alleged maltreatment cannot be more than 10 months prior to the date of birth of the alleged victim. Please enter a valid date and, if the exact date is unknown, check the ‘Approximate Date’ box";
            this.isConfrimPopup = false;
            this.globalPopupRef.openConfirmationModal();
            this.isOpenedIncidentDateModal=true;
        }
      }
    }

    onDodChange() {
      if(!this.isValuesUpdated) {
          return;
      }
      if((!this._personInfoService.personInfo) && this.involvedPersonFormGroup.controls['dateofdeath']?.value) {
        this.isDodChaged = true;
      }

      let intakeserviceid = this._personInfoService.getCaseId();
      let roles = this.involvedPersonFormGroup.get('roles')?.value;
      for (let role of roles) {
          if (['OTHERCHILD', 'CHILD', 'AV'].indexOf(role) > -1) {
              if (!intakeserviceid) {
                  this.isIntakeDodChanged = true;
              } else {
                  this.isDodChaged = true;
              }
              break;
          }
      }
    }

    getInvolvedPersons(intakeserviceid: string) {
      let isExpungementSuperUser= this._authService.isExpungementSuperUser();
      const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
      let url = '';

      if(isExpungementSuperUser=== 1) {
          url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
      } else {
          url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
      }
      if ('intake' === this.navigationInfo?.source?.toLowerCase()) {
          return this._commonHttpService
              .getArrayList({
                  method: 'get',
                  where: {
                    intakenumber: this.navigationInfo?.sourceID,
                    isExpungementSuperUser: isExpungementSuperUser,
                    'iscaseexpunged': iscaseexpunged
                  }
              },
              url + '?filter'
              );
      } else {
        return this._commonHttpService
            .getArrayList(
                {
                    where: { objectid: this.navigationInfo?.sourceID, objecttypekey: 'servicecase', isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': iscaseexpunged},
                    method: 'get'
                },
                url + '?filter'
            );
      }
    }

    childFatilityAudit() {
        let involvedPersons: any[] = [];
        this.getInvolvedPersons(this.navigationInfo?.sourceID).subscribe((data: any) => {
          for (let person of data?.data) {
              if (person.dateofdeath && (person?.roles?.filter((r: any) => ['OTHERCHILD', 'CHILD', 'AV'].includes(r?.intakeservicerequestpersontypekey))?.length > 0)) {
                    involvedPersons.push({
                        dateofdeath: person.dateofdeath,
                        cjamspid: person.cjamspid
                    });
                }
            }
            this.SaveChildfatilitydetails(this.updateDataStore()?.intakeserviceid, involvedPersons);
        });

    }

    SaveChildfatilitydetails(intakeserviceid: any, involvedPersonList: any){
        let sdm, i;
        if(this.intakeservicerequestsdm[0]?.getintakeservicerequestsdm) {
            sdm = this.intakeservicerequestsdm[0]?.getintakeservicerequestsdm?.filter((item: any) => (item.pathwaystatus === "Accepted"))
            i = sdm.reduce((latestIdx: any, current: any, idx: any, arr: any) => {
              return new Date(current.insertedon) > new Date(arr[latestIdx].insertedon) ? idx : latestIdx;
            }, 0);
        }

          this._commonHttpService
              .create(
                  {
                      method: 'post',
                      intakeserviceid: intakeserviceid,
                      intakeservicerequestsdmid: ((sdm?.length>0) ? (sdm[i]?.intakeservicerequestsdmid) : null),
                      casenumber: ('intake' === this.navigationInfo?.source?.toLowerCase()) ? (this.navigationInfo?.sourceID) : this.navigationInfo?.data?.caseNumber,
                      childfatalityvalue : involvedPersonList.length ? 'yes': 'no',
                      involvedPersions: involvedPersonList,
                      isservicecase: this.isServiceCase
                  },
                  CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.UpdatechildfatalityUrl
              )
              .subscribe((response) => {
                  this.isIntakeDodChanged = false;
                  this.isDodChaged = false;
                  this._dataStoreService.setData(
                      IntakeStoreConstants.childfatalityPersonLevelUpdate,
                      {isUpdated: true}
                  );
                  if (response.data[0].updatechildfatality != 'SUCCESS') {
                      this._alertService.warn('An error occured while saving');
                  }
              })
      }


  // Associated to addOrUpdatePerson function
  private addOrUpdatePersonCondition3Fn(roles: any, personRoleDetails: any[], rolesData: any[], data: any) {
    if (this.checkRoleListHasAMFn(roles)) {
      this.isServiceCaseRoleTypeCheckFn(personRoleDetails, rolesData);
    }

    if (rolesData && rolesData.length > 0) {
      rolesData = _.orderBy(rolesData, ['isprimary'], ['desc']);
      for (let i = 0; i < rolesData.length; i++) {
        rolesData[i].isprimary = i === 0 ? 1 : 0;
      }
    }


    // For Audit Log
    const objectID = this._navigationUtils.getNavigationInfo().sourceID;
    const objectType = this._navigationUtils.getModuleType();
    data.objectid = objectID;
    data.objecttype = objectType;

    // FIX needed for Multiple roles issue
    data.personroleid = this.existingRoleId;

    if (data.roletype === 'household') {
      data.ishousehold = 1;
    } else if (data.roletype === 'other') {
      data.ishousehold = 2;
      data.isheadofhousehold = false;
    } else {
      data.ishousehold = 0;
      data.isheadofhousehold = false;
    }
    if (data.initialresponse === 'yes') {
      data.initialresponse = 1;
    } else if (data.initialresponse === 'no') {
      data.initialresponse = 0;
    }

    data.iscollateralcontact = (data.roletype && data.roletype === 'collateral') ? 1 : 0;
    data.personRole = this.decidePrimaryRole(rolesData);

    data.alias = this._personInfoService.aliasList;
  }
  // Associated to addOrUpdatePerson function
  private checkRoleListHasAMFn(roles: any) {
    return this.isServiceCase && this.rolesList.indexOf('AM') !== -1 && roles.indexOf('AM') == -1;
  }
  // Associated to addOrUpdatePerson function
  private addOrUpdatePersonCondition2Fn(data: any) {
    data.unknownperson = this.returnUnknownPersonFn();
    // Check height in feet
    if (this.involvedPersonFormGroup?.get('heightft')?.value == undefined || this.involvedPersonFormGroup?.get('heightft')?.value == '') {
        data.heightft = null;
    } else {
        data.heightft = this.involvedPersonFormGroup?.get('heightft')?.value; // Store the feet value
    }

    // Check height in inches
    this.handleHeightinFn(data);

    // Combine height if feet is present
    if (data.heightft != null) {
        data.height = data.heightft + '.' + data.heightin; // Combine feet and inches
    } else {
        data.height = null; // Set to null if feet is missing
    }

    if (this.involvedPersonFormGroup?.get('weightpnd')?.value == undefined || this.involvedPersonFormGroup?.get('weightpnd')?.value == '') {
      data.weightpnd = null;
    }
    if (this.involvedPersonFormGroup?.get('weightound')?.value == undefined || this.involvedPersonFormGroup?.get('weightound')?.value == '') {
      data.weightound = null;
    }

    if ((this.involvedPersonFormGroup?.get('weightpnd')?.value != null) && (this.involvedPersonFormGroup?.get('weightound')?.value != null)) {
      data.weight = this.involvedPersonFormGroup?.get('weightpnd')?.value + '.' + this.involvedPersonFormGroup?.get('weightound')?.value;
    } else {
      data.weight = null;
    }

    if (this.isChild18) {
      data.preadptdate = this.returnPreadptdateFn(data);
      data.preplacementguardianshipdate = this.returnPreplacementguardianshipdateFn(data);
    }
  }
  // Associated to addOrUpdatePerson function
  private handleHeightinFn(data: any) {
    if (this.involvedPersonFormGroup?.get('heightin')?.value == undefined || this.involvedPersonFormGroup?.get('heightin')?.value == '' 
      || isNaN(this.involvedPersonFormGroup?.get('heightin')?.value)) {
      if (data.heightft !== null) {
        data.heightin = 0; // Assign 0 if height in feet is present and inches is empty
      } else {
        data.heightin = null; // Set to null if feet is not provided
      }
    } else {
      data.heightin = this.involvedPersonFormGroup?.get('heightin')?.value;
    }
  }
  // Associated to addOrUpdatePerson function
  private returnUnknownPersonFn(): any {
    return this._dataStoreService.getData('UNKNOWN_PERSON_ID') ? this._dataStoreService.getData('UNKNOWN_PERSON_ID') : null;
  }
  // Associated to addOrUpdatePerson function
  private addOrUpdatePersonCondition1Fn() {
    const selectedRoles = this.involvedPersonFormGroup?.getRawValue().roles;
    const isAM = selectedRoles.filter((roleKey: string) => roleKey === 'AM');
    const isAV = selectedRoles.filter((roleKey: string) => roleKey === 'AV');
    if ((isAM && isAM.length) || (isAV && isAV.length)) {
      this._alertService.warn('Please establish relationships between the alleged victim(s) and/or alleged maltreater(s)');
    }

    // For now setting flag on Save button click, should be done on success response of save service call
    if(this.store){
      this.store['SAVEDONEFLAG'] = true;
    }
    this.involvedPersonFormGroup.controls['personid'].setValue(this._personInfoService.getPersonId());

    if (this.involvedPersonFormGroup.controls['birthmatchflag'].dirty) {
      this.involvedPersonFormGroup.patchValue({ birthmatchupdateflag: 'Y' });
    }

    if (!this.isChild18) {
      const currentValues = this.involvedPersonFormGroup.value;
      if (!currentValues.everbeenadoptedflag) {
        this.involvedPersonFormGroup.patchValue({ everbeenadoptedflag: null });
      }
      if (!currentValues.preadptdate) {
        this.involvedPersonFormGroup.patchValue({ preadptdate: null });
      }
      this.involvedPersonFormGroup.patchValue({ intercountryadoption: null });
      this.involvedPersonFormGroup.patchValue({ priorlegalguardianship: null });
      this.involvedPersonFormGroup.patchValue({ preplacementguardianshipdate: null });
    } 
  }
  // Associated to addOrUpdatePerson function
  private savePersonDetailsFailedResFn(response: any) {
    if (response.status) {
      this._alertService.error(response.status);
    } else {
      this._alertService.error('Failed saving the person details, Please try again');
    }
  }

  private programAssignmentCond(savedPersonID: any){
    return this._dataStoreService.getData(IntakeStoreConstants.PERSON_SEARCH_CASE) === this.id &&
      (savedPersonID != this._dataStoreService.getData('NEW_PERSON_ASSIGNED') || (this.caseType === 'CPS-IR' || this.caseType ==='CPS-AR')) && this.isCPS;
  }
  // Associated to addOrUpdatePerson function
  private savePersonDetailsResponseFn(response: any, docid: any, data:any) {
    const savedPersonID = response.Personid;
    const model = {
      personid: savedPersonID,
      documentpropertiesid: docid
    };
    if (docid) {
      this._commonHttpService
        .create(model,
          'Documentproperties/updateObjectId'
        )
        .subscribe();
    }
    this._personInfoService.updatePersonId(savedPersonID);
    this._personInfoService.getPersonDetails().subscribe(payloadRes => {
       this._personInfoService.setPersonInfo(payloadRes);
    });
    if (this.programAssignmentCond(savedPersonID)) { //CIDM-9634: new requirement
      this.getProgramAssignmentList(savedPersonID);
    }
    if (response.status !== 'Head of Household Person already added') {
      if (!this.isBlockPersonSaveNotification) {
        this._alertService.success(response.status);
      }
      this.isBlockPersonSaveNotification = false;
      this._personInfoService.personActionListener$.next('UPDATED');
      const savedPerId = response.Personid;
      this._personInfoService.updatePersonId(savedPerId);
      const caseNumber = data.caseInfo.objectNumber;
      if (this.senHistoryFlag.trim() === 'Active' && caseNumber) {
        const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const fullName = `${data.Firstname} ${data.Middlename} ${data.Lastname}`;
        const notificationData: any = {}
        notificationData.objectid = this.id;
        notificationData.isexternalentity = 'false'
        notificationData.subject = `Active Substance Exposed New Born (${fullName.replace("'", " ").trim()} / ${this.selectedPersonDetails.personbasicdetails.cjamspid}) is added to case ${caseNumber}`;
        notificationData.priorityleveltypekey = 'High'
        notificationData.usernotificationtypekey = 'System'
        notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
        notificationData.securityusersid = this._authService.getCurrentUser().user.securityusersid;
        notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
        notificationData.objectcasenumber = caseNumber;
        notificationData.servicerequestnumber = caseNumber;
        notificationData.body = fullName.trim() + this.notificationMsg1;
        this._commonHttpService.create(notificationData, this.getSingleApiPath).subscribe((res) => {
          if (res && res.length === 0) {
            this._commonHttpService.create(notificationData, this.addApiPath).subscribe(() => {
              this._commonHttpService.getArrayList(
                {
                  where: { servicecaseid: id },
                  method: 'get'
                },
                'Caseassignments/getworkload?filter'
              ).subscribe(workloadData => {
                const notificationArray = workloadData.filter(item => item.enddate === null || moment(item.enddate) >= moment(new Date()));
                // console.info("notificationArray", notificationArray)
                this.createNotification(notificationArray, fullName);
              })
            })
          }
        })
      }
    } else {
      this._alertService.error(response.status);
    }
    this.deleteIdentified(response.Personid);
  }
  // Associated to addOrUpdatePerson function
  private returnDocidFn() {
    return this._dataStoreService.getData('_documentpropertiesid') ? this._dataStoreService.getData('_documentpropertiesid') : null;
  }
  // Associated to addOrUpdatePerson function
  private substanceexposednewbornflagFn(data: any) {
    if (data.substanceexposednewbornflag) {
      data.substanceexposednewbornflag = 1;
      if (this.isCPS) {
        data.substanceexposednewbornsourcetypekey = 2957;
      } else if (this.isServiceCase) {
        data.substanceexposednewbornsourcetypekey = 2952;
      } else {
        data.substanceexposednewbornsourcetypekey = 2954;
      }
    } else {
      data.substanceexposednewbornflag = 0;
      data.substanceexposednewbornsourceid = null;
      data.substanceexposednewbornsourcetypekey = null;
      data.substanceexposednewborntimetamp = null;
      data.substanceclasses = null;
      data.othersubstances = null;
    }
  }
  // Associated to addOrUpdatePerson function
  private isServiceCaseRoleTypeCheckFn(personRoleDetails: any[], rolesData: any[]) {
    const savedRole = personRoleDetails.find(role => role.roletype === 'AM');
    if (savedRole) {
      rolesData.push({
        'personroletypeid': savedRole.personroletypeid,
        'personroleid': savedRole.personroleid,
        'roletype': savedRole.roletype,
        'isprimary': (savedRole.isprimary == "true" || savedRole.isprimary == "1") ? 1 : 0
      });
    } else {
      rolesData.push({
        'personroletypeid': null,
        'personroleid': null,
        'roletype': 'AM',
        'isprimary': 0
      });
    }
  }
  // Associated to addOrUpdatePerson function
  private returnSelectedPersonDetailsFn() {
    return this.selectedPersonDetails
      && this.selectedPersonDetails.personbasicdetails
      && this.selectedPersonDetails.personbasicdetails.personrole
      && this.selectedPersonDetails.personbasicdetails.personrole.Personroletype
      && this.selectedPersonDetails.personbasicdetails.personrole.Personroletype.length;
  }
  // Associated to addOrUpdatePerson function
  private returnFirstAndLastNameFn(data: any) {
    return ((data.Firstname.includes('-') && data.Firstname.indexOf(' ') >= 0) || (data.Lastname.includes('-')  && data.Lastname.indexOf(' ') >= 0) || (data.Middlename && data.Middlename.includes('-') && data.Middlename.indexOf(' ') >= 0) || (data.Firstname.includes('\'') && data.Firstname.indexOf(' ') >= 0) || (data.Lastname.includes('\'')  && data.Lastname.indexOf(' ') >= 0) || (data.Middlename && data.Middlename.includes('\'') && data.Middlename.indexOf(' ') >= 0));
  }
  // Associated to addOrUpdatePerson function
  private returnPreplacementguardianshipdateFn(data: any): any {
    return data.priorlegalguardianship ? this.priorlegalguardianshipTrueFn(data) : null;
  }
  // Associated to addOrUpdatePerson function
  private priorlegalguardianshipTrueFn(data: any): any {
    return data.priorlegalguardianship == "1" ? data.preplacementguardianshipdate : null;
  }
  // Associated to addOrUpdatePerson function
  private returnPreadptdateFn(data: any): any {
    return data.everbeenadoptedflag ? this.everbeenadoptedflagTrueFn(data) : null;
  }
  // Associated to addOrUpdatePerson function
  private everbeenadoptedflagTrueFn(data: any): any {
    return data.everbeenadoptedflag == "1" ? data.preadptdate : null;
  }

  createNotification(notificationArray: any[], fullName: string) {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    notificationArray.forEach((notification: any) => {
      const notificationDataTemp: any = {}
      notificationDataTemp.objectid = this.id;
      notificationDataTemp.isexternalentity = 'false'
      notificationDataTemp.subject = `Active Substance Exposed New Born (${fullName.replace("'", " ").trim()} / ${this.selectedPersonDetails.personbasicdetails.cjamspid}) is added to case ${caseInfo.da_number}`;
      notificationDataTemp.priorityleveltypekey = 'High';
      notificationDataTemp.usernotificationtypekey = 'System';
      notificationDataTemp.objectcasenumber = caseInfo.da_number;
      notificationDataTemp.servicerequestnumber = caseInfo.da_number;
      notificationDataTemp.body = fullName.trim() + this.notificationMsg1;
      const userId:any = notification.toworkerdetails[0]?.securityusersid;
      const supervisorId = notification.toworkerdetails[0].supervisorid;
      notificationDataTemp.insertedby = this._authService.getCurrentUser().user.securityusersid;
      notificationDataTemp.securityusersid = userId;
      notificationDataTemp.updatedby = this._authService.getCurrentUser().user.securityusersid;
      this._commonHttpService.create(notificationDataTemp, this.getSingleApiPath).subscribe((res) => {
        if (res && res.length === 0) {
          this._commonHttpService.create(notificationDataTemp, this.addApiPath).subscribe((data) => {
            const notificationData: any = {}
            notificationData.objectid = this.id;
            notificationData.isexternalentity = 'false'
            notificationData.subject = `Active Substance Exposed New Born (${fullName.replace("'", " ").trim()} / ${this.selectedPersonDetails.personbasicdetails.cjamspid}) is added to case ${caseInfo.da_number}`;
            notificationData.priorityleveltypekey = 'High';
            notificationData.usernotificationtypekey = 'System';
            notificationData.objectcasenumber = caseInfo.da_number;
            notificationData.servicerequestnumber = caseInfo.da_number;
            notificationData.body = fullName.trim() + this.notificationMsg1;
            notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
            notificationData.securityusersid = supervisorId;
            notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
            this.handleCreateNotificationDataFn(notificationData);
          })
        } else {
          const notificationData: any = {}
          notificationData.objectid = this.id;
          notificationData.isexternalentity = 'false'
          notificationData.subject = `Active Substance Exposed New Born (${fullName.replace("'", " ").trim()} / ${this.selectedPersonDetails.personbasicdetails.cjamspid}) is added to case ${caseInfo.da_number}`;
          notificationData.priorityleveltypekey = 'High';
          notificationData.usernotificationtypekey = 'System';
          notificationData.objectcasenumber = caseInfo.da_number;
          notificationData.servicerequestnumber = caseInfo.da_number;
          notificationData.body = fullName.trim() + this.notificationMsg1;
          notificationData.insertedby = this._authService.getCurrentUser().user.securityusersid;
          notificationData.securityusersid = supervisorId;
          notificationData.updatedby = this._authService.getCurrentUser().user.securityusersid;
          this.handleCreateNotificationDataFn(notificationData);
        }
      })
    });
  }
  // Assosiated with createNotification method
  private handleCreateNotificationDataFn(notificationData: any) {
    this._commonHttpService.create(notificationData, this.getSingleApiPath).subscribe((notifyResult) => {
      if (notifyResult && notifyResult.length === 0) {
        this._commonHttpService.create(notificationData, this.addApiPath)
      }
    });
  }

  getdispositionhist(){
    if(this.isCPS) {
      this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
              page: 1,
              limit: 10,
              where: {
                  servicerequestid: this.id
              },
              method: 'get'
          }),
          'Intakeservicerequestdispositioncodes/GetHistory?filter'
      ).subscribe((historyResult) => {
            if(historyResult && historyResult.data) {
              this.dispositionreview = historyResult.data.filter(dahistory => dahistory?.routingstatus == 'Review');
            }
          },
          (error) => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
      );
    }
  }

  onAdoptefFlagChange(value: any) {
    if(value === 1 && this.isChild18) {
      this.commonValidatorFn(true,'intercountryadoption');
    } else {
      this.commonValidatorFn(false,'intercountryadoption');
    }
  }
getErrorsMessage(ControlName: string | number, displayName: string, otherControlName?:any){
  if(otherControlName){
     if(this.involvedPersonFormGroup.controls[ControlName].value =='O' &&
     this.involvedPersonFormGroup.controls[otherControlName].status =='INVALID'){
       // No content or data to call or add
     }
    return 'Please enter valid ' + displayName
    }
else if(this.involvedPersonFormGroup.controls[ControlName].status =='INVALID' ){
return 'Please enter valid ' + displayName
}  
  
  if(ControlName === "Dob" && (this.involvedPersonFormGroup.controls[ControlName].value === 'Invalid date' || this.involvedPersonFormGroup.controls[ControlName].value === null)){
return 'Please enter valid ' + displayName
}
}


getProgramAssignmentList(savedPersonID: any, isRoleTypeExist = [], isReviewExist = []) {
  const isExpungementSuperUser = this._authService.isExpungementSuperUser();
  const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
  this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
              where: { objectid: this.id, personid: savedPersonID,isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': iscaseexpunged },
              method: 'get',
              nolimit: true
          }),
          'Personprogramareas/getpersonprogramarea?filter'
      )
      .subscribe((programResult) => {
          if (programResult && Array.isArray(programResult) && programResult.length) {
              this.programAsssignList = programResult[0];
              this.programPersonDetails = programResult[0].persondetails;
              const activeProgramKey = this.returnActiveProgramKeyFn();
              if (activeProgramKey && !this.isView) {
                this.noActiveProgram = true;
                this.ifPersonprogramareaFn(activeProgramKey);
                this.newPersonCPSAssignment(savedPersonID);
            }
            this.isSaveConfirmPopup = this.ifCpsArFn() === 'AR' && isRoleTypeExist.length > 0 && isReviewExist.length === 0
            ? true : false;
        }
      });
}
// Associated to getProgramAssignmentList function
  private ifPersonprogramareaFn(activeProgramKey: string) {
    if (this.programAsssignList && this.programAsssignList.personprogramarea) {
      const activePrograms = this.programAsssignList.personprogramarea.filter((programArea: { subprogramkey: string; objectid: string; }) => programArea.subprogramkey === activeProgramKey && programArea.objectid === this.id);
      if (activePrograms.length > 0) {
        this.noActiveProgram = false;
      }
    }
  }
// Associated to getProgramAssignmentList function
  private returnActiveProgramKeyFn() {
    return this.caseType === 'CPS-IR' ? 'IR' : this.ifCpsArFn();
  }
// Associated to getProgramAssignmentList function
  private ifCpsArFn() {
    return this.caseType === 'CPS-AR' ? 'AR' : null;
  }

  newPersonCPSAssignment(savedPersonID: any) {
    if (this.noActiveProgram === true) {
      const model = {
        personid: savedPersonID,
        startdate: this.today,
        programkey: 'CPS',
        subprogramkey: this.caseType === 'CPS-IR' ? 'IR' : this.returnSubprogramkeyFn(),
        objecttypekey: 'servicerequest',
        objectid: this.id
      };

      this._commonHttpService
      .create(model,
          'Personprogramareas/addupdate'
      )
      .subscribe(() => {
          this._alertService.success('Program assignment added successfully!');
      });

    }
  }
  // Assosiated with newPersonCPSAssignment method
  private returnSubprogramkeyFn() {
    return this.caseType === 'CPS-AR' ? 'AR' : null;
  }

  deleteIdentified(person: any) {
    let persons = this._dataStoreService.getData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);
    if(persons) {
      persons = persons.filter((item: { id: any; }) => person !== item.id);
    }
    this._dataStoreService.setData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS, persons);
  }


  // getRoleList() {
  //   console.log('case/intake worker Role itration count', this.ROLE_ITREATION_COUNT);
  //   this._personInfoService.getRoleList().subscribe(data => {
  //     if (data && data.length) {
  //       this.setRoleList(data);
  //     } else {
  //       if (this.ROLE_ITREATION_COUNT < AppConstants.ITRETOR.POLING_COUNT) {
  //         this.ROLE_ITREATION_COUNT++;
  //         this.getRoleList();
  //       }
  //     }

  //   });
  // }

  // setRoleList(data) {
  //   this.roleDropdownItems$ = data.map(res => {
  //     return {
  //       text: res.typedescription,
  //       value: res.actortype,
  //       rolegrp: res.rolegroup
  //     };
  //   });
  // }

  languageType() {
    // No data or function to add or call
  }



  enableAddAlias(event: any) {
    // No data or function to add or call
  }

  loadCounty(state: any) {
    this._commonDropdownService.getPickListByMdmcode(state.ref_key).subscribe(countyList => {
      this.countyDropDownItems$ = observableOf(countyList);
    });
  }



  getSelected(item:any) {
    this.rolecount = this.selected ? this.selected.length : '';
    return item.ref_key;
  }

  invokeValidators(isHouseHold: number) {
    if(!this.initialrespreadonly){
    this.involvedPersonFormGroup.patchValue({
      initialresponse:null,
      initialresponseupdatedby : null,
      initialresponseupdatedon : null
    });
  }
    if (isHouseHold) {
      this.involvedPersonFormGroup.controls['Dob'].setValidators(Validators.required);
      this.involvedPersonFormGroup.controls['dangerousself'].setValidators(Validators.required);
      this.involvedPersonFormGroup.controls['ismentalimpair'].setValidators(Validators.required);
      this.involvedPersonFormGroup.controls['Dangerousworker'].setValidators(Validators.required);
      this.involvedPersonFormGroup.controls['ismentalillness'].setValidators(Validators.required);
      this.involvedPersonFormGroup.controls['Dob'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['dangerousself'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['ismentalimpair'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['Dangerousworker'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['ismentalillness'].updateValueAndValidity();
    } else {
      this.involvedPersonFormGroup.controls['Dob'].clearValidators();
      this.involvedPersonFormGroup.controls['dangerousself'].clearValidators();
      this.involvedPersonFormGroup.controls['ismentalimpair'].clearValidators();
      this.involvedPersonFormGroup.controls['Dangerousworker'].clearValidators();
      this.involvedPersonFormGroup.controls['ismentalillness'].clearValidators();
      this.involvedPersonFormGroup.controls['Dob'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['dangerousself'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['ismentalimpair'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['Dangerousworker'].updateValueAndValidity();
      this.involvedPersonFormGroup.controls['ismentalillness'].updateValueAndValidity();
      this.isChildRole = false;
    }
  }

  Falg(event: any) {
    // No data or function to call or add
  }

  ngOnDestroy(): void {
    if (this.profileUpdateSubscription) {
      this.profileUpdateSubscription.unsubscribe();
  }
  this._dataStoreService.removeItem('personsdrsource');
  }

  // Roles stuff
  selectPrimaryRole(event: any) {
    // No data or function to call or add
  }
   
  setupChangeSubscribers() {
    this.involvedPersonFormGroup.controls['substanceclasses'].valueChanges
      .subscribe(() => {
        this.babySubstanceOther = false;
        const substances: any[] = this.involvedPersonFormGroup.controls['substanceclasses'].value;
        if (substances && Array.isArray(substances)) {
          substances.forEach(item => {
            if (item === 'BOTH') {
              this.babySubstanceOther = true;
            }
          });
        }
      });
  }


  decidePrimaryRole(roles: any[]) {
    if (roles && roles.length) {
      const isChildFound = roles.find((role: { roletype: string; }) => role.roletype === 'CHILD');
      const isLGFound = roles.find((role: { roletype: string; }) => role.roletype === 'LG');
      const isChildAndLG = (isChildFound && isLGFound) ? true : false;

      if (isChildFound || isLGFound) {
        roles.forEach((role: { roletype: string; isprimary: number; }) => {
          if (role.roletype === 'CHILD') {
            role.isprimary = 1;
          } else if (role.roletype === 'LG' && !isChildAndLG) {
            role.isprimary = 1; // @Simar: If LG role is present along with CHILD, then only CHILD will be made Primary
          } else {
            role.isprimary = 0;
          }
        });
      }
    }
    return _.orderBy(roles, ['isprimary'], ['desc']);
  }

  SSNchanged() {
    const personInfo = this.involvedPersonFormGroup?.getRawValue();
    this.involvedPersonFormGroup.patchValue({
      ssnverified: null
    });
    if (personInfo.SSN) {
      const ssnValidator = personInfo.SSN && /^(?!(000|666|9))(\d{3}-?(?!(00))\d{2}-?(?!(0000))\d{4})$/.test(personInfo.SSN)  ? true  : false;
      if(!ssnValidator){
        this.showProfileErrorMessage(this.getSSNValidationMessage());
        this.involvedPersonFormGroup.patchValue({
          SSN: this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails ? this.returnSsnFn() : null
        });
        return;
      }
      this.checkForSSNExist(personInfo, true);
    }
  }
  // Assosiated with SSNchanged method
  private returnSsnFn(): any {
    return this.selectedPersonDetails.personbasicdetails.ssnno ? this.selectedPersonDetails.personbasicdetails.ssnno : null;
  }

  checkForSSNExist(personInfo: { SSN: any; }, throwError = false) {
    const ssnValue = personInfo.SSN;
    if (ssnValue && ssnValue.length === 9) {
      this._personInfoService.searchPersonWithSsnCritera({
         'ssn': ssnValue,
        }).subscribe(presonSearchResult => {
        if (presonSearchResult?.count > 0) {
          this.ssnExistResponseFn(presonSearchResult, personInfo);
        } else {
          this.SSNDuplicateFound = false;
        }
      });
    } else {
      this.SSNDuplicateFound = false;
    }
  }
  // Associated to checkForSSNExist function
  private ssnExistResponseFn(psResult: any, personInfo: any) {
    const checkList = psResult.data.filter((data: { source: string; }) => data.source === 'Local');
    if (checkList?.length > 0) {
      //CIDM-5412 To allow person save with same ssn for when fname,lname,dob and gender matches
      checkList.forEach((role: { firstname: any; lastname: any; gendertypekey: any; dob: moment.MomentInput; }) => {
        if (personInfo.Firstname !== role.firstname || personInfo.Lastname !== role.lastname || personInfo.gendertypekey !== role.gendertypekey || moment(personInfo.Dob).format(this.dtformat) !== moment(role.dob).format(this.dtformat)) {
          this.SSNDuplicateFound = true;
          this.showProfileErrorMessage(this.getSSNErrorMessage());
        }
      });
    }
  }

  getSSNErrorMessage() {
    return `The SSN entered already exists in CJAMS`;
  }

  getSSNValidationMessage() {
    return `Please Enter Valid SSN`;
  }

  showProfileErrorMessage(message: string) {
    this.errorMessage = message;

  this._changeDetectorRef.detectChanges();

    $('#profile-error-message').modal('show');
  }

  getNameValidationMessage() {
    return `Please Enter Valid Name`;
  }

  closeErrorMessage() {
    this.errorMessage = '';
    $('#profile-error-message').modal('hide');
  }

  goBack() {
    this._dataStoreService.setData(IntakeStoreConstants.NAVIGATE_TO_PERSON, true);
    this._dataStoreService.setData(IntakeStoreConstants.SELECT_PERSON_TAB_INTAKE, true);
    this._personInfoService.goBack();
  }

  processRoleValidation() {
    this.initialrespreadonlyFn();
    const selectedRoles = this.involvedPersonFormGroup?.getRawValue().roles;
    let intialAMrole = false;
    let intialAVrole = false;
    let changedAMrole = false;
    let changedAVrole = false;

    if(this.duplicateRolesListForAM?.length > 0){
      intialAMrole = this.roleValidationCheckRoles(this.duplicateRolesListForAM).amRole;
      intialAVrole = this.roleValidationCheckRoles(this.duplicateRolesListForAM).avRole;
    }

    if(selectedRoles?.length > 0){
      changedAMrole = this.roleValidationCheckRoles(selectedRoles).amRole;
      changedAVrole = this.roleValidationCheckRoles(selectedRoles).avRole;
    }
    this.checkICC(selectedRoles);
    if(this.duplicateRolesListForAMIfConditionFn(intialAMrole, changedAMrole, intialAVrole, changedAVrole)){
      this.involvedPersonFormGroup.patchValue({roles:this.duplicateRolesListForAM });
      this._alertService.error("User can not Edit Alleged Victim or Alleged Maltreator Role when the CPS Case is under Review status. Please connect with supervisor to reject the case review so worker can edit the roles");
      return true;
    }
    this.checkSelectedRolesFn(selectedRoles, intialAMrole, changedAMrole);
    this.duplicateRolesListForAM = selectedRoles;
    if(this.involvedPersonFormGroup.controls['dateofdeath'].value) {
        this.onDodChange();
    }
  }

  roleValidationCheckRoles(arr: any){
    let amRole = false;
    let avRole = false;
    arr.forEach((role: any) => {
      if(role === "AM"){
        amRole = true;
      }
      if(role === "AV"){
        avRole = true;
      }
    });
    return {amRole, avRole};
  }
  // Associated to processRoleValidation function
  private initialrespreadonlyFn() {
    if (!this.initialrespreadonly) {
      this.involvedPersonFormGroup.patchValue({
        initialresponse: null,
        initialresponseupdatedby: null,
        initialresponseupdatedon: null
      });
    }
  }

  // Associated to Intial Care giver function
  private checkICC(_selectedRoles: string | string[]){
    if (_selectedRoles.includes("ICC") || !this.personAgeStatus ||
      (this.selectedPersonDetails && this.selectedPersonDetails.personbasicdetails.caregiverData
        && this.selectedPersonDetails.personbasicdetails.caregiverData.length > 0)) {
      this.maritalStatus = true;
      this.involvedPersonFormGroup.controls["maritalstatustypekey"].setValidators([Validators.required])
    } else {
      this.maritalStatus = false;
      this.involvedPersonFormGroup.controls["maritalstatustypekey"].setValidators([])
    }
  }

  // Associated to processRoleValidation function
  private duplicateRolesListForAMIfConditionFn(intialAMrole: boolean, changedAMrole: boolean, intialAVrole: boolean, changedAVrole: boolean) {
    return (intialAMrole !== changedAMrole || intialAVrole !== changedAVrole) && this.isCPS && this.dispositionreview && this.dispositionreview.length > 0;
  }
  // Associated to processRoleValidation function
  private checkSelectedRolesFn(selectedRoles: any, intialAMrole: boolean, changedAMrole: boolean) {
    if (selectedRoles.indexOf('CHILD') !== -1) {
      this.isChildRole = true;
      this._dataStoreService.setData('isChildRole', true);
      // D-18392 Remove required
      // this.involvedPersonFormGroup.controls['biologicalmothermarriedsw'].setValidators(Validators.required);
      this.involvedPersonFormGroup.controls['biologicalmothermarriedsw'].updateValueAndValidity();
    } else {
      this.isChildRole = false;
      this._dataStoreService.setData('isChildRole', false);
      this.involvedPersonFormGroup.controls['biologicalmothermarriedsw'].clearValidators();
      this.involvedPersonFormGroup.controls['biologicalmothermarriedsw'].updateValueAndValidity();
    }
    if (selectedRoles.indexOf('CHILD') === -1 && selectedRoles.length > 0) {
      this.isheadofhouseholdflag = true;
    } else {
      this.isheadofhouseholdflag = false;
    }
    this.checkForSexOffender(selectedRoles);

    if ((intialAMrole && !changedAMrole) && !this.isServiceCase) {
      this._alertService.warn("Information: Change in Alleged Maltreator Role will reflect / impact the data in Maltreatment Allegation and Investigation Finding screen");
    }
  }

  /**
   * Checks whether or not to show the role in the 'roles' dropdown
   * returns false for role we don't want to show based on specific conditions
   * @param role the role type key
   */
  checkRoles(role: string) {

    //Rule 1. If selected roles has Alleged victim then cannot be Alleged maltreator, and vice versa
    let selectedRoles = this.involvedPersonFormGroup?.getRawValue().roles;
    selectedRoles = selectedRoles && selectedRoles.length ? selectedRoles : [];
    const isAM = selectedRoles.filter( (roleKey: string) => roleKey === 'AM');
    const isAV = selectedRoles.filter( (roleKey: string) => roleKey === 'AV');
    if ((role === 'AV' && isAM.length && !isAV.length) || ( role === 'AM' && isAV.length && !isAM.length)) {
      return false;
    }

    //Rule 2. Maltreator role should ONLY be visible for CPS cases
    if (role === 'MALTREATOR' && !this.isCPS) {
      return false;
    }

    //Rule 3. Alleged Maltreater should NOT be visible for Service cases
    if(role == 'AM' && this.isServiceCase){
      return false;
    }

    //Default rule just show on dropdown, so returning true if none of the above conditions satisfied
    return true;
  }

  checkForSexOffender(roles: any[]) {
    this.isNotSexOffender = false;
    this.involvedPersonFormGroup.get('sexoffenderregisteredflag')?.enable();
    const notSexOffenderRoles = ['AV', 'CHILD', 'OTHERCHILD'];
    if (roles && roles.length) {
     const resultRoles = roles.filter(value => -1 !== notSexOffenderRoles.indexOf(value))
     if (resultRoles && resultRoles.length > 0) {
       this.isNotSexOffender = true;
       this.involvedPersonFormGroup.get('sexoffenderregisteredflag')?.disable();
     }
    }
  }
  _keyUp(event: any) {
    const pattern = /^([A-Za-z0-9]*[-]*[A-Za-z0-9])*$/;
      if (!pattern.test(event.target.value)) {
        event.target.value = event.target.value.replace(/[^a-zA-Z0-9-]/g, "");
        // invalid character, prevent input
      }
  }
  _onKeyUp(event: any){
    const pattern = /^[a-zA-Z]*$/;
    if(!pattern.test(event.target.value)){
      event.target.value = event.target.value.replace(/[^a-zA-Z]/g, "");
    }
  }
  confirmBirthMatchPopup(item: { checked: any; }) {
    if(item.checked) {
      this.showReasonInput = false;
      this.birthMatchStatus = ' (Active)';
      $('#confirm-birthmatch-popup').modal('show');
    } else {
      if(this.isSupervisor) {
        this.birthMatchStatus = '';
        this.showReasonInput = true;
        this.involvedPersonFormGroup.patchValue({birthmatchflag : 0});
      } else{
        this.involvedPersonFormGroup.patchValue({birthmatchflag : 1});
      }


    }
  }

  changeBirthMatchValue(flag: any) {
    if(!flag) {
      this.involvedPersonFormGroup.patchValue({birthmatchflag : 0});
    } else {
      this.involvedPersonFormGroup.patchValue({birthmatchflag : 1});
    }
    $('#confirm-birthmatch-popup').modal('hide');
  }

  checkcomma(event:any){
    const value:any =event.target.value;
    this.involvedPersonFormGroup.controls["icwatribename"].setValidators([this.checkcommaCustomValidator()]);
    const newValue = value.replace(/[^\dA-Z]/g, '').replace(/(.{3})/g, '$1,').trim();
    this.involvedPersonFormGroup.patchValue({icwatribename: newValue});
  }
  checkcommaCustomValidator() {
    return (control: AbstractControl) : ValidationErrors | null => {
      const value = control.value?.replaceAll(",","");
      if(!value || value.length % 3 !== 0) {
        return { notMultipleOfThree: true};
      }
      return null;
    }
  }
  icwaStatusChange() {
    if (this.involvedPersonFormGroup.controls['icwastatusinquiry'].value !== 'YES') {
      // Only disable, do not clear values
      this.involvedPersonFormGroup.controls['icwatribename'].disable();
      this.involvedPersonFormGroup.controls['icwatribename'].clearValidators();
    } else {
      this.involvedPersonFormGroup.controls['icwatribename'].enable();
    }
    this.involvedPersonFormGroup.controls['icwaeligibleformembership'].updateValueAndValidity();
    this.involvedPersonFormGroup.controls['icwatribename'].updateValueAndValidity();
  }

  icwaEligibleFormembershipChange() {
    const underDef = this.involvedPersonFormGroup.controls['icwaunderdefinition'].value;
    this.involvedPersonFormGroup.controls['icwaeligibleformembership'].setValue(underDef);
    if (this.involvedPersonFormGroup.controls['icwaeligibleformembership'].value === 'YES') {
      this.involvedPersonFormGroup.controls['icwatribename'].enable();
      this.involvedPersonFormGroup.controls['icwatribename'].setValidators([Validators.required]);
    } else {
      // Only clear icwatribename if not YES
      this.involvedPersonFormGroup.controls['icwatribename'].setValue(null);
      this.involvedPersonFormGroup.controls['icwatribename'].disable();
      this.involvedPersonFormGroup.controls['icwatribename'].clearValidators();
    }
    this.involvedPersonFormGroup.controls['icwatribename'].updateValueAndValidity();
  }

  icwaUnderDefinitionChange() {
    const underDefValue = this.involvedPersonFormGroup.controls['icwaunderdefinition'].value;
    if (underDefValue !== 'YES') {
      // Only disable, do not clear values
      this.involvedPersonFormGroup.controls['icwatribelegalnotice'].setValue(null);
      this.involvedPersonFormGroup.controls['icwanotification'].setValue(null);
      this.involvedPersonFormGroup.controls['icwatribename'].setValue(null);
      this.involvedPersonFormGroup.controls['icwatribename'].clearValidators();
      this.involvedPersonFormGroup.controls['icwatribelegalnotice'].clearValidators();
      this.involvedPersonFormGroup.controls['icwanotification'].clearValidators();
      // Set Status in Federally Recognized Tribe to NO if under definition is NO
      if (underDefValue === 'NO') {
        this.involvedPersonFormGroup.controls['icwaeligibleformembership'].setValue('NO');
        this.involvedPersonFormGroup.controls['icwatribename'].setValue(null);
      } else if (underDefValue === 'UNKNOWN') {
        this.involvedPersonFormGroup.controls['icwaeligibleformembership'].setValue('UNKNOWN');
        this.showIcwaNotifyUnknownModalHandler(true);
      }
    } else {
      this.involvedPersonFormGroup.controls['icwatribename'].enable();
      this.involvedPersonFormGroup.controls['icwatribename'].setValidators([Validators.required]);
      this.involvedPersonFormGroup.controls['icwatribelegalnotice'].enable();
      this.involvedPersonFormGroup.controls['icwanotification'].enable();
      this.involvedPersonFormGroup.controls['icwatribelegalnotice'].setValidators([Validators.required]);
      this.involvedPersonFormGroup.controls['icwaeligibleformembership'].setValue('YES');
    }
    this.involvedPersonFormGroup.controls['icwatribelegalnotice'].updateValueAndValidity();
    this.involvedPersonFormGroup.controls['icwanotification'].updateValueAndValidity();
  }

  icwaTribelegalNoticeChange() {
    if (this.involvedPersonFormGroup.controls['icwatribelegalnotice'].value === 'YES') {
      this.involvedPersonFormGroup.controls['icwanotification'].setValidators([Validators.required]);
    } else {
      this.involvedPersonFormGroup.controls['icwanotification'].clearValidators();
    }
    this.involvedPersonFormGroup.controls['icwanotification'].updateValueAndValidity();
  }
checkresponsetimer(person: any){

const roles = this.involvedPersonFormGroup?.getRawValue().roles;
const roletype  = this.involvedPersonFormGroup?.getRawValue().roletype

  if (person) {
    return this.returnCheckInitialFn(person, roletype, roles);
  } else if (roletype && roles) {
    return this.returnCheckIfRoletypeFn(roletype, roles)
  }
}

private returnCheckInitialFn(person: any, roletype: any, roles: any) {
  if (person.initialresponse == 1 || person.initialresponse == 0 || person.personroleid === null) {
    if (roletype && roles) {
      if (roletype === 'household' && (roles.includes('CHILD') || roles.includes('OTHERCHILD') || roles.includes('AV'))) {
        return true
      } else if (roletype == 'other' && (roles.includes('AV'))) {
        return true;
      } else{
        return false;
      }
    }
  }
  else {
    return false;
  }
}

private returnCheckIfRoletypeFn(roletype: any, roles: any) {
  if (roletype === 'household' && (roles.includes('CHILD') || roles.includes('OTHERCHILD') || roles.includes('AV'))) {
    return true
  } else if (roletype == 'other' && (roles.includes('AV'))) {
    return true;
  } else{
    return false;
  }
}

initialresponseupdate(value: any){
  const initialresptime  = moment(new Date()).format('YYYY-MM-DD hh:mm A');
  this.involvedPersonFormGroup.patchValue({
    initialresponseupdatedby : this.roleId.user.userprofile.fullname,
    initialresponseupdatedon : initialresptime
  })
  if(value ==='no'){

   $('#confirm-responsetimer-popup').modal('show');
  }
}

confirmactivechild(value: any){

  if(value ==='no'){
    this.involvedPersonFormGroup.patchValue({
      initialresponseupdatedby : null,
      initialresponseupdatedon : null,
      initialresponse:null
    })
  }
  $('#confirm-responsetimer-popup').modal('hide');
}
aliasAdded() {
  this.involvedPersonFormGroup.markAsDirty();
}
closelocationofadoption() {
  $('#open-location-of-adoption').modal('hide');
}

openlocationofadoption() {
  $('#open-location-of-adoption').modal('show');
}

  private lepProficiencyValidator(): ValidatorFn {
    return (group: AbstractControl): ValidationErrors | null => {
      const lep = group.get('limitedenglishproficiency')?.value;

      if (!lep) return null;

      const reading = group.get('readingproficiency')?.value === true;
      const writing = group.get('writingproficiency')?.value === true;
      const speaking = group.get('speakingproficiency')?.value === true;

      return (reading || writing || speaking) ? null : { lepProficiencyRequired: true };
    };
  }
}

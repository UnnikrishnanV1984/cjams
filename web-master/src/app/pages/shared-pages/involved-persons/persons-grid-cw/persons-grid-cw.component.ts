import {of as observableOf,  Observable,Subject, of, forkJoin  } from 'rxjs';
import {pluck, share, takeUntil, tap} from 'rxjs/operators';
import { Component, OnInit, OnDestroy, ViewChild, Injector, ElementRef} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AlertService, AuthService, CommonDropdownsService, DataStoreService, CommonHttpService, SessionStorageService, LocalStorageService } from '../../../../@core/services';
import { IntakeConfigService } from '../../../newintake/my-newintake/intake-config.service';
import { IntakeStoreConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { FindIndividualService } from '../find-individual/find-individual.service';
import { InvolvedPersonsService } from '../involved-persons.service';
import { InvolvedPerson } from '../_entities/involvedperson.data.model';
import { AppConfig } from '../../../../app.config';
import { PaginationRequest, DropdownModel } from '../../../../@core/entities/common.entities';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { CASE_STORE_CONSTANTS } from '../../../case-worker/_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';
import moment from 'moment';
import { AppConstants } from '../../../../@core/common/constants';
import { PersonInfoService } from '../../person-info/person-info.service';
import { ReportSummary } from '../../../case-worker/_entities/caseworker.data.model';
import { TransferHistoryApprovedService } from '../../../../shared/services/transfer-history-approved.service';
import { AddressDetailsService } from '../../person-info/address-details/address-details.service';
import { PhoneType } from '../../../../pages/admin/general/_entities/general.data.models';
import { PopoverDirective } from 'ngx-bootstrap/popover';
import { HospitalizationService } from  './../../../../shared/services/hospitalization.service';
import { GlobalPopupComponent } from '../../../../shared/shared-components/global-popup/global-popup.component';
import { YouthTransitionPlanService } from '../../../../pages/case-worker/dsds-action/service-plan/youth-transition-plan-new/youth-transition-plan.service';


declare let $: any;

@Component({
    selector: 'persons-grid-cw',
    templateUrl: './persons-grid-cw.component.html',
    styleUrls: ['./persons-grid-cw.component.scss'],
    standalone: false
})
export class PersonsGridCwComponent implements OnInit, OnDestroy  {

  @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  isHouseholdActive = true;
  involevedPerson$!: Observable<InvolvedPerson[]>;
  reportSumary$: Observable<ReportSummary> | null | undefined;
  involevedPerson: any[] = [];
  involvedPersonList: InvolvedPerson[]= [];
  cpsAssignment: boolean = true;
  involvedUnkPerson: any[] = [];
  agency!: string;
  token!: AppUser;
  reviewstatus: any;
  currentStatus!: string;
  selectedIndex: any;
  selectedPerson: any;
  unkPersonFormGroup: any;
  householdroleDropdownItems$!: Observable<any[]>;
  addedIdentifiedPersons: any = [];
  reporterPerson: any;
  persontodelete: any;
  /* Service case - Program Assignment */
  activepersondetails!: any;
  addAssignmentForm!: FormGroup;
  endDateForm!: FormGroup;
  programArea: any;
  programSubArea: any;
  notPlacedChildList: any;
  reasonForEndList$!: Observable<any>;
  personid: any;
  isChildOrNotCheck = false;
  programAsssignList: any;
  minDate!: Date | null;
  minimumDate = new Date(1900, 0, 1);
  personprogramid: any;
  isAddAssignment!: boolean;
  programPersonDetails: any;
  isNotPersonYouth = false;
  outhomestatus = false;
  outhomemessage: any = null;
  maxDate = new Date();
  caseStartDate!: Date | null;
  currentaddressDropdownItems$!: Observable<DropdownModel[]>;
  changeView = 'card';
  id!: string;
  isEVPA!: boolean;
  checkVPA!: any;
  isrole: any = [];
  showpersoncardsinblue: boolean = false;
  isServiceCase!: string;
  isAdoptionCase: boolean = false;
  isCW = false;
  isValidateProgramArea!: boolean;
  nonCpsCase!: boolean;
  isClosed = false;
  isViewCase = false;
  canDelete = false;
  intakePersonDelete = false;
  canSearchAdd = true;
  isIntakeCaseOrNot = false;
  personLoadFlag = false;
  noSearchAddList = ['ADOPTION_CASE'];
  isSupervisor = false;
  caseType = '';
  noActiveProgram = false;
  daNumber!: number;
  kinshipChecklistComplete = false;
  source!: string;
  caregiversInCase!: string;
  legalGaurdianPersonId!: string;
  isServicePlanPresent: boolean = false;
  servicelogcompleted: boolean = false;
  checklistItems: any[] = [];
  personlistforservicelog: any[] = [];
  houseHoldPersonList: any[] = [];
  parentOrLegalGaurdian: any[] = [];
  collateralCount = 0;
  placementList: any[] = [];
  placementRunwayList: any[] = [];
  permanencyPlanList: any[] = [];
  selectedPersonHistory:any;
  placementHistory:any;
  placementRevison: any;
  today = new Date();
  cpsCaseTypes = ['CPS-IR', 'CPS-AR'];
  isReadonly = true;
  reportdata!: ReportSummary | null;
  minStartDate!: Date;
  programAreaHistoryData: any[] = [];
  isintake!: boolean;
  isEditDisabled!: boolean;
  roleId!: AppUser;
  editprogramassignment: boolean = true;
  isAdoptiveParent: boolean = false;
  checkmandatory: boolean = false;
  generateintakedocumenturl = 'evaluationdocument/generateintakedocument';
  servicecasetxt = 'Service Case';
  defaultdt = '01/01/1900';
  addprogramassignmentpopupid = '#add-program-assignment';
  personprogramareasaddupdateurl = 'Personprogramareas/addupdate';
  agencyprogramarealisturl = 'agencyprogramarea/list?filter';
  isAttemptedOrCompletedContactNote = false;
  isAllServiceLogsEndDated = false;
  isKinshipChecklistCompleted!: boolean;
  selectedPersonId!: string | null;
  selectedCjamspid!: string;
  isProgramAreaKinshipSelected!: boolean;
  isProgramAreaInHomeSelected!: boolean;
  isProgramAreaAuxiliarySelected!: boolean;
  isEndDateSelected!: boolean;
  reasonForEndAllList: any[] = [];
  contactTypes: any[] = [];
  @ViewChild('tablePopover', { static: false })
  tablePopover!: PopoverDirective;
  personPhoneList: any = {};
  currentDate = new Date(new Date().toLocaleDateString());
  removalCircumstancesObj:any= [];
  // @ViewChild('dialog') myDialog!: ElementRef<HTMLDialogElement>;
  @ViewChild('dialog') myDialog!: ElementRef<any>;

  activeTab: string = '';
  supervisorsList: any = [];
  isMoveable: boolean = false;
  isRequestSent: boolean = false;
  activePrograms: any = [];
  programForm!: FormGroup;
  selectedSupervisor: string = '';
  personHistory: any = [];
  movecomments: string = '';
  showHistoryDetail: number | null = null;
  showProgramAssignDetail: number | null = null;
  confrimMessage: string = '';
  isConfrimPopup: boolean = false;
    ytpFcgsCompletedByPersonId: Record<string, boolean> = {};
  ytpAge17FlagByPersonId: Record<string, boolean> = {};
  ytpAge17Plus6MonthsFlagByPersonId: Record<string, boolean> = {};
  private ytpLoadStartedForPersonIds = new Set<string>();
    intakeserviceid: string = '';
  caseNo: string = '';
  ytpProgramAreaStatus: any = {};
  isExpungementSuperUser: number = 0;
  placementdataForCfeCheck: any[] = [];
  familyWorkerCounty : string = '';
  motivationActiveCounty : any ;
  showMotivationalInterviewOptions: boolean = false;
 
    private _service: InvolvedPersonsService;
    private _router: Router;
    private route: ActivatedRoute;
    private _findIndividualService: FindIndividualService;
    private _intakeConfig: IntakeConfigService;
    private _dataStoreService: DataStoreService;
    public _authService: AuthService;
    private _alertService: AlertService;
    private _formBuilder: FormBuilder;
    private _commonDropdownService: CommonDropdownsService;
    private _commonHttpService: CommonHttpService;
    private storage: SessionStorageService;
    private localStorage: LocalStorageService;
    private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;
    public _personInfoService: PersonInfoService;
    private _addressService: AddressDetailsService;
    private _hospitalizationService: HospitalizationService;   
     private _ytpService: YouthTransitionPlanService; 
  iscaseexpunged: any;

  constructor(private injector:Injector){
    this._service = this.injector.get<InvolvedPersonsService>(InvolvedPersonsService);
     this._ytpService= this.injector.get<YouthTransitionPlanService>(YouthTransitionPlanService);
    this._router = this.injector.get<Router>(Router);
    this.route =this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._findIndividualService = this.injector.get<FindIndividualService>(FindIndividualService);
    this._intakeConfig = this.injector.get<IntakeConfigService>(IntakeConfigService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this.localStorage = this.injector.get<LocalStorageService>(LocalStorageService);
    this._transferHistoryApprovedService = this.injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._addressService = this.injector.get<AddressDetailsService>(AddressDetailsService);
    this._hospitalizationService = this.injector.get<HospitalizationService>(HospitalizationService);
   }

  ngOnInit() {
       this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.caseNo = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.storage.setItem('isView', false);
    this.maxDate = new Date();
    this.handleActiveModuleRoleFn();
    this.isEditDisabled = this._authService.isDisabled('person','person.involved.editassignment');
    this.getPlacementRecordList();
    this.loadPersons();
    this.initendDateForm();
    const unkpersons = this._dataStoreService.getData(IntakeStoreConstants.addedUnkPersons);
    this.involvedUnkPerson = (unkpersons) ? unkpersons : [];
    const caseNumber = this._dataStoreService.getData('dsdsActionsSummary');
      if (caseNumber?.da_number) {
        this.isIntakeCaseOrNot = true;
    }
    this.agency = this._authService.getAgencyName();
    this.token = this._authService.getCurrentUser();
    this.reviewstatus = this._dataStoreService.getData(IntakeStoreConstants.reviewstatus);
    this.currentStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
    this.isClosed = this._authService.iscaseclosed('persongrid');
    this.initiateUnkFormGroup();
    this.householdroleDropdownItems$ = this._commonDropdownService.getPickListByName('cpsroles');
    this.getquickperson();
    this.loadSupervisorList();
    const voluntaryPlacementId = this._dataStoreService.getData('voluntryPlacementType');
    if (voluntaryPlacementId !== 'VPA') {
        this.isEVPA = false;
    } else {
        this.isEVPA = true;
    }
    this.intializeData();
    this.caseStartDate =  null;
    if (this.isServiceCase) {
      this.getChildRemoval();
      this.loadReportSummary();
    }
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    const tempDsdsActionsSummary = this._dataStoreService.getData('dsdsActionsSummary')
    this.caseType = tempDsdsActionsSummary ? tempDsdsActionsSummary.da_subtype:null;
    if (this._authService.isCW()) {
      this.ifIsCWFn();
    } else {
      this.canDelete = true;
    }

    this._intakeConfig.colletarlCount$.subscribe(count => {
      this.collateralCount = count;
    });

    this.addAssignmentForm?.get('enddate')?.valueChanges
      ?.subscribe(endDate => {
        this.isEndDateSelected = false;
        if(endDate) {
          this.isEndDateSelected = true;
        }
    });
    // This api service call is for fetching all available phone types (like cell, home, office, primary, etc.)
    this._commonDropdownService.getPickListByName('phonetype').subscribe(contactTypes => {
      if (contactTypes && Array.isArray(contactTypes)) {
        this.contactTypes = contactTypes;
      }
    });
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, null);
    
    if(this.isIntakeMode() && this._transferHistoryApprovedService.getTrasferHistory()) {
      this.isClosed = true;
    }

    this.loadRemovalCircumstances();

     //Global popup response yes, new screen will load in new tab
     setTimeout(() => {
      this.checkGlobalPopupResponseMultiTab();
    }, 500);
    
    this.isExpungementSuperUser = this._authService.isExpungementSuperUser();
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
  }

  checkGlobalPopupResponseMultiTab() : void {
    const uniqueKey = window.name;
    if(uniqueKey){
      const personId = localStorage.getItem(uniqueKey);
      if (personId) {
          const person = this.involevedPerson.find(item => item.personid === personId);
          window.name = '';
          this.editPerson(person);
        
      }
    }
  }

  intializeData(){
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.initAddAssignmentForm(); /* Service case - Program Assignment */
    this.initProgramForm();
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.getAssignmentsList();
    this.nonCpsCase = this.isServiceCase == 'true' || this.isAdoptionCase;
    this.isintake = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.SOURCE_PAGE) === AppConstants.MODULE_TYPE.INTAKE;
  }
    private isOnOrAfterSeventeenthBirthday(dobInput: any): boolean {
    const dateOfBirth = this.toDateOrNull(dobInput);
    if (!dateOfBirth) return false;
    const seventeenthBirthday = moment(dateOfBirth).add(17, 'years');
    return moment().isSameOrAfter(seventeenthBirthday, 'day');
  }

  private isOnOrAfterSeventeenthPlusSixMonths(dobInput: any): boolean {
    const dateOfBirth = this.toDateOrNull(dobInput);
    if (!dateOfBirth) return false;
    const seventeenthPlusSixMonths = moment(dateOfBirth).add(17, 'years').add(6, 'months');
    return moment().isSameOrAfter(seventeenthPlusSixMonths, 'day');
  }

  private toDateOrNull(dateInput: any): Date | null {
    if (!dateInput) return null;
    const parsed = new Date(dateInput);
    return isNaN(parsed.getTime()) ? null : parsed;
  }

  private isFcgsChecklistCompletedAndYtpApproved(plans: any[]): boolean {
    if (!Array.isArray(plans)) return false;
  
    return plans.some((plan) => {
      const isApproved =
        String(plan?.approvalstatuskey || '').trim().toLowerCase() === 'approved';
  
  
      const hasNonEmptyChecklistJson =
        !!plan?.newfcgschecklistjson &&
        (
          (typeof plan.newfcgschecklistjson === 'object' && Object.keys(plan.newfcgschecklistjson).length > 0) ||
          (typeof plan.newfcgschecklistjson === 'string' && plan.newfcgschecklistjson.trim().length > 0)
        );
  
      return isApproved && hasNonEmptyChecklistJson;
    });
  }
  
  
  initializeYtpNotifications(personId: string, personDob: any): void {
    if (!personId || this.ytpLoadStartedForPersonIds.has(personId)) return;
    this.ytpLoadStartedForPersonIds.add(personId);
  
    this.ytpAge17FlagByPersonId[personId] = this.isOnOrAfterSeventeenthBirthday(personDob);
    this.ytpAge17Plus6MonthsFlagByPersonId[personId] = this.isOnOrAfterSeventeenthPlusSixMonths(personDob);
  
    this._ytpService.getYTPPlanList(personId).subscribe({
      next: (plans) => {
        this.ytpFcgsCompletedByPersonId[personId] = this.isFcgsChecklistCompletedAndYtpApproved(plans);
      },
      error: () => {
        this.ytpFcgsCompletedByPersonId[personId] = false;
      }
    });
  }

  preloadYtpNotificationsForPeople(people: Array<{ personid: string; dob: any }>): void {
    (people || []).forEach(person => {
      this.initializeYtpNotifications(person?.personid, person?.dob);
    });
  }
  
  isEndDateGiven(): boolean {
    return this.nonCpsCase ? this.activePrograms.every((program: any) => program.enddate != null) : true;
  }

  isReasonForEndSelected(): boolean {
    return this.nonCpsCase ? this.activePrograms.every((program: any) => program.endreasonkey != null && program.endreasonkey !== '') : true;
  }
  // Assosiated to ngOnInit method
  private handleActiveModuleRoleFn() {
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else if (activeModuleRole == 'Medical Specialist') {
      this.isReadonly = true;
    } else {
      this.isReadonly = this._authService.readonlyButton('read_only_access', 'add-edit-person');
    }
  }

  openDialog(personId: any) {
    this.selectedPersonId = personId;
    this.myDialog.nativeElement.showModal();
  }

  closeDialog() {
    this.myDialog.nativeElement.close();
    this.selectedPersonId = null;
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();       
  }

  private ifIsCWFn() {
    if (this.isSupervisor) {
      this.canDelete = true;
      if (this.isintake && !this.isClosed) {
        this.intakePersonDelete = true;
      }
    }
    const source = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.SOURCE_PAGE);
    const intakeStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
    if (source === AppConstants.MODULE_TYPE.INTAKE) {
      if (!intakeStatus || intakeStatus === 'Draft' || intakeStatus === 'Review') {
        this.canDelete = true;
      }
    }
  }
   // This function is for fetching phone info based on person id.
   getPhonesList(personId: any) {
    this._addressService.getPhoneList(personId);
    this._addressService.phonePersonType$.subscribe((data: PhoneType[]) => {
      if(data.length) {
        this.convertToDate(data);
        this.personPhoneList[personId] = data;
        this.personPhoneList[personId].sort(this.sortPersonPhoneType);
      }
    });
  }
    // This function is for converting string format enddate to date format, as we are comparing enddate with today.
    convertToDate(data: any) {
      return data.map((item: any) => {
        if(item.enddate) {
          item.enddate = new Date(item.enddate);
        }
        return item;
      });
    }
      // This function is for sorting objects based on personphonetypekey.
  sortPersonPhoneType(a: any, b: any) {
    if ( a.personphonetypekey < b.personphonetypekey ){
      return -1;
    }
    if ( a.personphonetypekey > b.personphonetypekey ){
      return 1;
    }
    return 0;
  }
  // This function is for displaying description on UI instead of key value.  
  getPhoneType(type: any) {
    if (this.contactTypes?.length && type) {
      const typeObj = this.contactTypes.find(data => data.ref_key === type);
      return typeObj.description;
    }
  }

  // This function is for checking if all phone items have valid end date.
  getPersonContactWithEndDate(personId: any) {
    return this.personPhoneList[personId].every((item: any) => item.enddate && item.enddate <= this.currentDate);
  } 
  private getAge(dateValue: any) {
    if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()) {
        const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
        return moment().diff(rCDob, 'years');
    } else {
        return '';
    }
  }

  isChild(person: any) {
    let isCurrentPersonisChild = false;
    if (person && person.roles) {
    const roles = person.roles;
    isCurrentPersonisChild = roles.some((item: any) => ['CHILD', 'AV', 'OTHERCHILD'].includes(item.intakeservicerequestpersontypekey));
    }
    return isCurrentPersonisChild;
  }
  getVoluntaryList(involvedperson: any) {
    const Pid = involvedperson.personid;
    if (Pid.indexOf('tempid') >= 0) {
        const dob = involvedperson.dob;
        const age = this.getAge(dob);
        this.checkVPA =

        [
        {'conditionname': 'placement', 'status': 'false', 'description': 'Youth is former CINA or VPA foster child who exited care after 18'},
        {'conditionname': 'county', 'status': 'false', 'description': 'Youth must be applying in the county from which they exited'},
        {'conditionname': 'permanency', 'status': 'false', 'description': 'Youth did not exit care for: Reunification, Adoption, Guardianship, Marriage or Military'},
        {'conditionname': 'age', 'status': (age && age >= 18 && age <= 20) ? 'true' : 'false', 'description': 'Youth between 18-20 years 6 months'}
       ];
    } else {
    const countId = this._dataStoreService.getData('countyId');
    const voluntaryPlacementId = this._dataStoreService.getData('voluntryPlacementType');
    if (voluntaryPlacementId !== 'VPA') {
        return false;
    }
    this._commonHttpService
    .getArrayList(
        new PaginationRequest({
            method: 'get',
            where:  {
             county : countId,
            personid : involvedperson.personid
             },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        }),
        'Intakeservs/getvpadetails?filter'
    )
        .subscribe(
            (result) => {
               if (result && result.length && result[0].checkvpa) {
               this.checkVPA = result[0].checkvpa;
             
               }
            }
        );
   
    }
}

closeVoluntaryModal() {
  $('#vpa-detail-popup').modal('hide');
}
openVoluntaryModal() {
  $('#vpa-detail-popup').modal('show');
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
        if(this.isAdoptionCase){
          this.checkCaseAccess(data);
      }else{
        this.getFamilyWorkerCounty(data);
      }
    }
  });
}


checkCaseAccess(data: any) {
  const checkAccessList = data.filter((item: any) => (item.responsibilitytypekey === "family" || item.responsibilitytypekey === "administrative") && (item.enddate === null || moment(item.enddate) >= moment(new Date())))
  checkAccessList.forEach((element: any) => {
      const familyAssignmentWorker = element.toworkerdetails?.filter((a: any) => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
      if (familyAssignmentWorker.length > 0) {
          let hasFamilyAccessToCase = true;
          this.storage.setItem('hasFamilyAccessToCase', hasFamilyAccessToCase);
          }
  })
}

getFamilyWorkerCounty(data: any) {
  const checkAccessList = data.filter((item: any) => (item.responsibilitytypekey === "family") && (item.enddate === null || moment(item.enddate) >= moment(new Date())))
  if (checkAccessList.length > 0) {
    checkAccessList.forEach((element: any) => {
            this.familyWorkerCounty = element?.countyname;
    })
  }
}


  prepareReportedCard() {
    if(!this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)){
      const reporterPerson = this._dataStoreService.getData(IntakeStoreConstants.addNarrative);
    if (reporterPerson) {
      this.reporterPerson = Object.assign({}, reporterPerson);
      this.reporterPerson.firstname = reporterPerson.Firstname;
      this.reporterPerson.lastname = reporterPerson.Lastname;
      this.reporterPerson.isDel = false;
      const personList = this.involevedPerson ? this.involevedPerson.filter((item) => item.firstname === reporterPerson.Firstname && item.lastname === reporterPerson.Lastname) : [];
      if ((personList && personList.length > 0) || reporterPerson.isDel) {
        this.reporterPerson.isDel = true;
      }
      this.reporterPerson.role = 'Reporter';
      this.reporterPerson.id = new Date().getTime();
    }
    }
  }
  loadPage() {
    this.personLoadFlag =  true;
    this.loadPersons();
    this._dataStoreService.setData('DSDS_ACTION_UPDATE', true);
    $('#program-assignment-service-case').modal('hide');
  }

  closeAssignmentPopup() {
    $('#program-assignment-service-case').modal('hide');
  }

getChildRemoval() {
    this._commonHttpService
      .getSingle(
        {
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID), 'objecttypekey': 'servicecase' , isgroup: 1},
          method: 'get'
        },
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
      ).subscribe(data => {
        if (data && data.length) {
          const list = data.filter((item: any) => {
            if (item.childremoval && item.childremoval.length) {
              const removal = item.childremoval[0];
              return (removal.approvalstatus === 'Approved') ? true : false;
            } else {
              return false;
            }
          });
        this.placementCheck1(list);
        }
      });
}

displayWorksheet(ivedeterminationdetails: any){

  let worksheet: any;

  worksheet = ivedeterminationdetails[0].sqnm_sw === 'I'? 'INITIAL' : 'REDETERMINATION';

  const modal = {
    method: 'post',
    where: {
        documenttemplatekey: ['ivefostercarePDF'],
        status: 'fostercare',
        transactionid: ivedeterminationdetails[0].ivetransactionid,
        type: worksheet,
        isheaderrequired: false
    },
    limit: 10,
    order: 'desc',
    page: 1,
    count: -1
};
this._commonHttpService.download(this.generateintakedocumenturl, modal)
    .subscribe(res => {
        const blob = new Blob([new Uint8Array(res)]);
        const link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        if (worksheet==='INITIAL') {
          link.download = `ivefostercareinitialeligibility.pdf`;
        } else if (worksheet==='REDETERMINATION') {
          link.download = `ivefostercareredeterminationeligibility.pdf`;
        }
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    });

  }

downloadAdoptionWorksheet(iveadoptiondetails: any) {

        const worksheet = iveadoptiondetails[0].sqnm_sw === 'I' ? 'INITIAL' : 'REDETERMINATION';

        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['adoptioneligibilityform'],
                status: 'fostercare',
                clientId: iveadoptiondetails[0].adoptionclientid,
                type: worksheet,
                eligibilityId: iveadoptiondetails[0].adoptiontransactionid,
                isheaderrequired: false
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonHttpService.download(this.generateintakedocumenturl, modal)
            .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = `adoptioneligibilityform.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
}


downloadGapWorksheet(gapdeterminationdetails: any, cjamspid: any) {

  const worksheet = gapdeterminationdetails[0].sqnm_sw === 'I' ? 'INITIAL' : 'REDETERMINATION';

  const modal = {
      method: 'post',
      where: {
          documenttemplatekey: ['gapeligibilityform'],
          status: 'fostercare',
          clientId: cjamspid,
          type: worksheet,
          eligibilityId: gapdeterminationdetails[0].ivetransactionid,
          isheaderrequired: false
      },
      limit: 10,
      order: 'desc',
      page: 1,
      count: -1
  };
  this._commonHttpService.download(this.generateintakedocumenturl, modal)
      .subscribe(res => {
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          link.download = `gapeligibilityform.pdf`;
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
      });
}


getPlacementValidation(childId: any) {
  return this._commonHttpService
  .getSingle(
    {
      where: {
        objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
        childId: childId},
      method: 'get'
    },
    `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
  );
}

  placementCheck1(removedChild: any) {
    this.permanencyPlanList = [];
    this.placementList = [];
    const activeChildRemovals = removedChild.filter((child: any) => {
      if (child.childremoval && child.childremoval.length &&
        child.childremoval.find((item: any) => (item.approvalstatus === 'Approved' && !item.exitdate))){
          return true;
        }else{
          return false;}
    });
    
    this.getPlacementInfoList(1, 10).subscribe(data => {
      if (data && data.data && data.data.length) {
        this.placementList = data.data;
        this.checkAbandonedChildren(activeChildRemovals);
      }
    });
    this.getPermanencyPlanList(1, 10).subscribe(data => {
      this.permanencyPlanList = data;
      this.checkAbandonedChildren(activeChildRemovals);
    });
  }

  checkAbandonedChildren(removedChild: any) {
    if (this.permanencyPlanList && this.placementList) {
      const placmentArray: any[] = [];
      removedChild.forEach((child: any) => {
        const cjamsPid = child.cjamspid;
        const personName = child.personname;
        const isActivePlacement = this.getIsActivePlacementDataFn(child, false); 
        const hasActivePlan = this.permanencyPlanList.some(item => {
          if (item.cjamspid === cjamsPid.toString()) {
            const list = item.permanencyplans;
            return this.retuenValidDataFn(list);
          } else {
            return false;
          }
        });
        const childPlacement = {
          'cjamsPid': cjamsPid, 'personName': personName,
          'isActivePlacement': (!isActivePlacement && !hasActivePlan)
        };
        placmentArray.push(childPlacement);
      });
      this._dataStoreService.setData('placment_check', placmentArray);
      this.notPlacedChildList = placmentArray.filter(placment => placment.isActivePlacement);
    }
  }

  private retuenValidDataFn(list: any) {
    return list.some((ele: {enddate: any;}) => ele.enddate === null);
  }

  private getIsActivePlacementDataFn(child: any, isActivePlacement: any) {
    this.placementList.forEach(placement => {
      const placements = placement.placements;
      placements.forEach((plmnt: { routingstatus: string; enddate: any; }) => {
        if (((child.cjamspid).toString() === placement.cjamspid) && (plmnt.routingstatus === 'Approved' || plmnt.routingstatus === 'Review') && !plmnt.enddate) {
          isActivePlacement = true;
        }
      });
    });
    return isActivePlacement;
  }

placementCheck(removedChild: any) {
  this.getPlacementInfoList(1, 10).subscribe(data => {
      const placmentArray: any[] = [];
      removedChild.forEach((child: any) => {
        this.getPlacementValidation(child.cjamspid).subscribe(
          dat => {
            // No content to add or call
        });
        const cjamsPid = child.cjamspid;
        const personName = child.personname;
        let isActivePlacement: boolean | null = null;
        if (data && data.data && data.data.length) {
            const placementList = data.data;
            placementList.forEach(placement => {
              const placements = placement.placements;
                placements.forEach((plamnt: any) => {
                  if ( ( (child.cjamspid).toString() ===  placement.cjamspid ) && (plamnt.routingstatus === 'Approved' || plamnt.routingstatus === 'Review')  && !plamnt.enddate) {
                      isActivePlacement = true;
                  }
                });
           });
        }
        const childPlacement = { 'cjamsPid': cjamsPid, 'personName': personName, 'isActivePlacement': isActivePlacement};
         placmentArray.push(childPlacement);
      });
      this._dataStoreService.setData('placment_check', placmentArray);
      this.notPlacedChildList = placmentArray.filter(placment => !placment.isActivePlacement);
  });
}

checkIfPersonExpunged(person: any) {
  let ifExpunged = false;
  if (person && person.roles && person.roles.length) {
    person.roles.forEach((role: any) => {
      if (role.spexpungementflag && person.roles.length === 1) {
        ifExpunged = true;
      } else {
        ifExpunged = false;
      }
    });
  }
  return ifExpunged;
}
  checkIfNoPlacement(child: any) {
    if(this.isrole[child.personid] != 'AV' && this.isrole[child.personid] !='CHILD' && this.isrole[child.personid] !='OTHERCHILD') {
      return false;
    }
    let isNoPlacement;
    if (this.notPlacedChildList && this.notPlacedChildList.length) {
      this.notPlacedChildList.forEach((ch: { cjamsPid: any; isActivePlacement: any; }) => {
        if ((ch.cjamsPid).toString() === child.cjamspid) {
          if (ch.isActivePlacement) {
            isNoPlacement = 'true';
          }
        }
      });

    }
    return isNoPlacement;
  }

  checkIfPersonActiveRunaway(person: any) {
    let filteredByPersonId;
    if (this.placementRunwayList && this.placementRunwayList.length) {
        filteredByPersonId = this.placementRunwayList.filter(item => person.personid === item.personid);
        if(filteredByPersonId && filteredByPersonId.length > 0) {
           return  this.checkPersonRunwayOrNot(filteredByPersonId);
        }
    }
  }

  checkPersonRunwayOrNot(person: any) {
    let activeRunawayOrNot = false;
    if (person && person.length) {
      person[0].placements.forEach((plc: any) => {
        if (plc && plc.livingarrangementtypekey == 'RNW' && plc.routingstatus == 'Approved' && plc.livingenddate == null) {
         activeRunawayOrNot = true;
         this._dataStoreService.setData('activeRunawayOrNot', activeRunawayOrNot);
         return true;
        } 
      });
    }
    return activeRunawayOrNot;
  }

getPlacementInfoList(pageNumber: any, limit: any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: pageNumber,
          limit: limit,
          method: 'get',
          where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'placement/getplacementbyservicecase?filter'
        
      );
}

getPlacementRecordList(){
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
    this.placementdataForCfeCheck = data?.data ?? [];
      this.placementRunwayList = data.data;
  });
}

getPermanencyPlanList(pageNumber: any, limit: any) {
  return this._commonHttpService
    .getArrayList(
      new PaginationRequest({
        page: pageNumber,
        limit: 100,
        nolimit: true,
        method: 'get',
        where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
      }),
      'permanencyplan/list?filter'
    );


}

  loadReportSummary() {
    this.reportSumary$ = this._service.getReportSummary() ? this._service.getReportSummary()?.pipe(
      share()) : null;
    if(this.reportSumary$) {
    this.reportSumary$.subscribe(response => {
      if(response && response.insertedon){
        this.handleLoadReportSummaryRespFn(response);

      }
    });
    }
  }

  private handleLoadReportSummaryRespFn(response: ReportSummary) {
    this.reportdata = response;
    if (this.reportdata.reporterincidentdate) {
      this.caseStartDate = new Date(this.reportdata.reporterincidentdate);
    }
    else if (this.reportdata.reporteddate) {
      this.caseStartDate = new Date(this.reportdata.reporteddate);
    }
    else {
      this.caseStartDate = this.reportdata.insertedon ? new Date(this.reportdata.insertedon) : null;
    }
  }

  cfePlacementCheck(person: any) {
    person.cfeToolTip = 'CfE Resource Home Child';
    const placementList = JSON.parse(JSON.stringify(this.placementdataForCfeCheck));
    placementList.forEach((placement: any) => {
      const placements = placement.placements;
      this.cjamspidCheckFn(person, placement, placements);
    });
  }

  private cjamspidCheckFn(person: any, placement: any, placements: any) {
    if ((person.cjamspid).toString() === placement.cjamspid) {
      placements.forEach((plmnt: { isvoided: number; service_id: number; enddate: null; placementrevision: string | any[]; routingstatus: string; }) => {
        if (plmnt.isvoided !== 1 && plmnt.service_id == 525 && plmnt.enddate === null) {
          const placementRevison = (plmnt.placementrevision.length > 0) ? plmnt.placementrevision[0] : null;
          if (plmnt.routingstatus === 'Approved' || (placementRevison !== null && placementRevison.exitdate !== null)) {
            person.cferesourcehomechild = true;
            person.cfeToolTip = 'The child is currently in a provider placement with placement structure "CfE Resource Home".';
          }
        }
      });
    }
  }

  loadPersons() {
    let isPrivateAdoption = false;
    this.involevedPerson$ = this._service.getInvolvedPerson(1, 100).pipe(
      share(),
      pluck('data')
    );
  
    this.involevedPerson$.subscribe(response => {
      if (this.isResponseValid(response)) {
        const narrative = this._dataStoreService.getData(IntakeStoreConstants.addNarrative);
        const incidentDate = narrative ? narrative.incidentdate : null;
        this.involevedPerson = response;
                // Fostercare check list consdition check
        this.ytpActiveChildRemovalCheck();
  
        this.handleInvolevedPersonFn();
        isPrivateAdoption = this.isPrivateAdoptionDataFn(isPrivateAdoption, incidentDate);
        this.involvedPersonList = response;
        this._dataStoreService.setData('PERSONINVOLVEDLIST', this.involvedPersonList);
  
        if (this.involvedPersonList && this.involvedPersonList.length) {
          this.handleInvolvedPersonListFn();
        }
        if (this.shouldFilterPersons()) {
          this.filterAndGetPersonInfo();
        }
        this.checkPersonSearchCaseIdFn();
      }
  
      this.prepareReportedCard();
      this.handlePersonHealthSummary();
    });
  
    this._dataStoreService.setData('ISPRIVATEADOPTION', isPrivateAdoption);
  }
  
  isResponseValid(response: any): boolean {
    return response && Array.isArray(response);
  }
  
  shouldFilterPersons(): boolean {
    return this.localStorage.getItem(CASE_STORE_CONSTANTS.PERSON_MOVE_ID) && this.isSupervisor && !this.personLoadFlag;
  }
  
  filterAndGetPersonInfo() {
    this.involvedPersonList.forEach(item => {
      if (item.actorid === this.localStorage.getItem(CASE_STORE_CONSTANTS.PERSON_MOVE_ID)) {
        const checkForCPS = this.isServiceCase || this.isAdoptionCase ? 'nonCPS' : 'CPS';
        this.activeTab = item.personmovestatus == 1 ? 'active' : 'inactive';
        this.getPersonInfo(item, checkForCPS);
      }
    });
  }
  
  handlePersonHealthSummary() {
    this.involevedPerson.forEach(person => {
      const querySearchByPersonId = this.route.snapshot.queryParams;
      if (querySearchByPersonId['pid']) {
        if (person.personid === querySearchByPersonId['pid']) {
          this.viewPersonHealthSummary(person, { path: querySearchByPersonId['path'], updatedon: querySearchByPersonId['updatedon'] });
          return;
        }
      }
    });
  }
  
  // Assosiated with loadPersons method
  private handleInvolevedPersonFn() {
    if (this.involevedPerson?.length > 0) {
      let pids: any = [];
      this.involevedPerson?.forEach(p => {
        if (!pids?.includes(p?.personid)) {
          pids.push(p?.personid);
        }
      });
      if (pids?.length > 0) {
        this?.getpregnants(pids);
      }
    }
  }

  // Assosiated to loadPersons method
  private checkPersonSearchCaseIdFn() {
    if (this._dataStoreService.getData(IntakeStoreConstants.PERSON_SEARCH_CASE) === this.id) {
      this.checkNewPersonCPS();
    }
  }

  // Assosiated to loadPersons method
  private handleInvolvedPersonListFn() {
    this._service.updateInProviderInfo();
    const addedPersons = this.involvedPersonList.map(person => {
      return this._intakeConfig.mapOldJsonData(person);
    });
    this._dataStoreService.setData(
      IntakeStoreConstants.addedPersons,
      addedPersons
    );
    this.involvedPersonList.forEach((item) => {
      if (item.roles && item.roles.length) {
        return this.itemRolesLoopFn(item);
      }
    });
    if (this.involvedPersonList) {
      const arrayHashmap = this.involvedPersonList.reduce((obj: any, item: any) => {
        const existingEntry = obj[item.personid];
        if (existingEntry) {
          obj[item.personid].roles?.push(...item.roles) 
        } else {
          obj[item.personid] = { ...item };
        }
        return obj;
      }, {});

      this.involvedPersonList = Object.values(arrayHashmap);
      // Iterating thru person's list and mapping phone info to person id. 
      for (const person of this.involvedPersonList) {
        this.getPhonesList(person.personid);
      }
    }
    this.filterHouseHold('household');
  }

  private itemRolesLoopFn(item: InvolvedPerson): void {
    return item.roles.forEach((res) => {
      if (res.intakeservicerequestpersontypekey === 'RC' || res.intakeservicerequestpersontypekey === 'LG' || res.intakeservicerequestpersontypekey === 'CHILD' || res.intakeservicerequestpersontypekey === 'AV' || res.intakeservicerequestpersontypekey === 'BIOCHILD' || res.intakeservicerequestpersontypekey === 'OTHERCHILD') {
        this.isrole[item.personid] = res.intakeservicerequestpersontypekey; // NOSONAR
        if (item.roles.length > 1) {
          item.roles.forEach((obj) => {
            if (obj.intakeservicerequestpersontypekey === 'CHILD' || obj.intakeservicerequestpersontypekey === 'BIOCHILD' || obj.intakeservicerequestpersontypekey === 'RC' || obj.intakeservicerequestpersontypekey === 'OTHERCHILD') {
              this.showpersoncardsinblue = true;
            }
          });
        }
      } else {
        this.isrole[item.personid] = ''; // NOSONAR
      }
    });
  }

  private isPrivateAdoptionDataFn(isPrivateAdoption: boolean, incidentDate: any) {
    this.involevedPerson.forEach((person: any) => {
      this.cfePlacementCheck(person);
      // An inline data/blob source is already complete - only relative paths need the api host
      if (person.userphoto && !/^(data:|blob:)/i.test(person.userphoto)) {
        person.userphoto = AppConfig.baseUrl + person.userphoto;
      }
      const roles = (Array.isArray(person.roles)) ? person.roles : [];
      this.personlistforservicelog.push(person.cjamspid);
      const isVictim = roles.some((item: { intakeservicerequestpersontypekey: string; }) => ['CHILD', 'AV'].includes(item.intakeservicerequestpersontypekey));
      const isLegalGaurdian = roles.some((item: { intakeservicerequestpersontypekey: string; }) => ['LG'].includes(item.intakeservicerequestpersontypekey));
      const isAdoptiveParent = roles.some((item: { intakeservicerequestpersontypekey: string; }) => ['ADOPTIVEPARENT'].includes(item.intakeservicerequestpersontypekey));
      if (isLegalGaurdian) {
        this.parentOrLegalGaurdian.push(person);
        this.legalGaurdianPersonId = person.personid;
      }
      if (!isPrivateAdoption) {
        isPrivateAdoption = roles.find((item: { intakeservicerequestpersontypekey: string; }) => item.intakeservicerequestpersontypekey === 'PVTADPCHILD') ? true : false;
      }
      if (isPrivateAdoption) {
        this._dataStoreService.setData('ISPRIVATEADOPTION', isPrivateAdoption);
      }
      person['ageatincident'] = (isVictim) ? this.getAgeAtIncident(incidentDate, person.dob) : null;
      person['isVictim'] = isVictim;
      person['isLegalGaurdian'] = isLegalGaurdian;
      person['isAdoptiveParent'] = isAdoptiveParent;
      if (person['programarea'] && person['programarea'].length) {
        const data = person['programarea'].map((item: any) => {
          return item.programname;
        });
        person['programnames'] = data.join(' / ');
      }
      if (person['programareabyservicecase'] && person['programareabyservicecase'].length) {
        const data = person['programareabyservicecase'].map((item: any) => {
           return item.programname;
         });
         person['programnamesbyservice'] = data.join(' / ');
       }      
    });
    return isPrivateAdoption;
  }

  getAgeAtIncident(incidentDate: any, persondob: any) {
    if (!incidentDate || !persondob) {
      return 'N/A';
    }
    const date2 = new Date(incidentDate);
    const date1 = new Date(persondob);
    let diff = (date2.getTime() - date1.getTime()) / 1000;
    diff /= (60 * 60 * 24);
    return Math.abs(Math.round(diff / 365.25)) + ' Yrs';
  }

  searchIdentified(person: any, isUnknown?: any, type?: any) {
    if(isUnknown){
      this._dataStoreService.setData('UNKNOWN_PERSON_ID',person);
      person = {personid:person};
    }
    if(type === 'QP') {
      person.persontype = type;
      person.clientflag = 1;
      this._dataStoreService.setData('QUICK_PERSON_ID',person);
    } else {
      this._dataStoreService.setData('QUICK_PERSON_ID',null);
    }
    this._dataStoreService.setData(IntakeStoreConstants.PERSON_TO_SEARCH, person);
    this._router.navigate(['../find-individual/search'], { relativeTo: this.route });
  }

  deleteIdentified(person: any, action: any) {
    if (action === -1) {
      this.persontodelete = person;
      $('#delete-unkperson-popup').modal('show');
    } else if (action === 0) {
      this.persontodelete = null;
      $('#delete-unkperson-popup').modal('hide');
    } else if (action === 1) {
      if (this.persontodelete?.role === 'Reporter') {
        const reporterPerson = this._dataStoreService.getData(IntakeStoreConstants.addNarrative);
        reporterPerson.isAdded = true;
        reporterPerson.isDel = true;
        this.reporterPerson.isAdded = true;
        this.reporterPerson.isDel = true;
        this._dataStoreService.setData(IntakeStoreConstants.addNarrative, reporterPerson);
      } else {
    
       this._commonHttpService.remove( person.quickpersonid , {}, 'quickperson/deletequickperson').subscribe(() => {
        this._alertService.success('Quick Person deleted successfully'); 
            this.getquickperson();
        });
      }
      $('#delete-unkperson-popup').modal('hide');
    }
  }
  deletequickpersonrequest(person: any, action: any) {
    var deletedata: any = {};
    const intakenumber = this._dataStoreService.getData('intakenumber');
    const intakeserviceid = this._dataStoreService.getData('CPS_CASE_ID');
    const servicecasenumber = this._dataStoreService.getData('DANUMBER');
     
    if(servicecasenumber && this.isServiceCase){
      deletedata['objecttype']= this.servicecasetxt;
      deletedata['objectid']= [servicecasenumber]; 
    }
    else if(intakeserviceid){
      deletedata['objecttype']= 'Case';
      deletedata['objectid']= [intakeserviceid]; 
    }
    else if(intakenumber){
      deletedata['objecttype']= 'Intake';
      deletedata['objectid']= [intakenumber]; 
    }
    if (action === -1) {
      this.persontodelete = person;
      $('#delete-quickperson-popup').modal('show');
    } else if (action === 0) {
      this.persontodelete = null;
      $('#delete-quickperson-popup').modal('hide');
    } else if (action === 1) {
      this.ifActionIs1Fn()
    }
  }
  private ifActionIs1Fn() {
    const caseInfo = this._dataStoreService.getData('CPS_CASE_ID');
    const caseNumber = this._dataStoreService.getData('dsdsActionsSummary');
    this.CheckIfSupervisorFn(this.persontodelete, caseInfo, caseNumber);
    $('#delete-quickperson-popup').modal('hide');
  }

  private CheckIfSupervisorFn(deletedata: any, caseInfo: any, caseNumber: any) {
    if (!this.isSupervisor) {
      deletedata['deletetype'] = 'Request';
      deletedata['caseid'] = this.id ? this.id : this.returnCaseInfoFn(caseInfo);
      deletedata['caseNumber'] = caseNumber && caseNumber.da_number ? caseNumber.da_number : null;
      this._commonHttpService.create(deletedata, 'quickperson/deleterequest').subscribe(() => {
        this._alertService.success('Request to Delete Quick Add Person Card Sent successfully.');
        this.getquickperson();
      });

    } else {
      deletedata['deletetype'] = 'Approve';
      this._commonHttpService.create(deletedata, 'quickperson/deleterequest').subscribe(() => {
        this._alertService.success('Quick Add Person Card deleted successfully.');
        this.getquickperson();
      });
    }
  }

  private returnCaseInfoFn(caseInfo: any): any {
    return caseInfo ? caseInfo : null;
  }

  getquickperson() {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let intakeserviceid = null;
    let intakenumber = this.getIntakeNumber();
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
        this.addedIdentifiedPersons = data[0].getquickpersondetails; 
        this._dataStoreService.setData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS, this.addedIdentifiedPersons);
        this.addedIdentifiedPersons = this._dataStoreService.getData(IntakeStoreConstants.ADDED_IDENTIFIED_PERSONS);       
      } else {
        this.addedIdentifiedPersons = [];
      }
      this._intakeConfig.quickAddPersonCount$.next(this.addedIdentifiedPersons.length);
    });
  }

  filterHouseHold(tabSelected: any) {
    this.activeTab = tabSelected;
    this.isHouseholdActive = true;
    this.involevedPerson$ = observableOf(this.involvedPersonList.filter(person => person.ishousehold === 1 && person?.programarea && person?.programarea.length>0 && person?.programarea.some((item: { objectid: string; }) => item.objectid === this.id) && (this.nonCpsCase || (!this.nonCpsCase && person?.personmovestatus == 1))));
    this.involevedPerson = this.involvedPersonList.filter(person => person.ishousehold === 1 && person?.programarea && person?.programarea.length>0 && person?.programarea.some((item: { objectid: string; }) => item.objectid === this.id) && (this.nonCpsCase || (!this.nonCpsCase && person?.personmovestatus == 1)));
    this.houseHoldPersonList =  this.involevedPerson;
  }

  filterOtherPerson(tabSelected: any) {
    this.activeTab = tabSelected;
    this.isHouseholdActive = false;
    this.involevedPerson$ = observableOf(this.involvedPersonList.filter(person => person.ishousehold !== 1 && person?.programarea && person?.programarea.length>0 && person?.programarea.some((item: { objectid: string; }) => item.objectid === this.id) && (this.nonCpsCase || (!this.nonCpsCase && person?.personmovestatus == 1))));
    this.involevedPerson = this.involvedPersonList.filter(person => person.ishousehold !== 1 && person?.programarea && person?.programarea.length>0 && person?.programarea.some((item: { objectid: string; }) => item.objectid === this.id) && (this.nonCpsCase || (!this.nonCpsCase && person?.personmovestatus == 1)));
  }

  filterInactivePerson(tabSelected: any) {
    this.activeTab = tabSelected;
    this.isHouseholdActive = false;
    this.involevedPerson$ = observableOf(this.involvedPersonList.filter(person => !person?.programarea || (person?.programarea && person?.programarea.length>0 && person?.programarea.every((item: { objectid: string; }) => item.objectid !== this.id)) && (!this.nonCpsCase && person?.personmovestatus == 0)));
    this.involevedPerson = this.involvedPersonList.filter(person => !person?.programarea || (person?.programarea && person?.programarea.length>0 && person?.programarea.every((item: { objectid: string; }) => item.objectid !== this.id)) || (!this.nonCpsCase && person?.personmovestatus == 0));
  }
  filtercolateral(tabSelected: any) {
    this.activeTab = tabSelected;
  }

  filterHouseHoldCount() {
    if (this.involvedPersonList === undefined) { return 0; }
    const household =  this.involvedPersonList.filter(person => person.ishousehold === 1 && person?.programarea && person?.programarea.length>0 && person?.programarea.some((item: { objectid: string; }) => item.objectid === this.id) && (this.nonCpsCase || (!this.nonCpsCase && person?.personmovestatus == 1)));
    if (household && household.length) {
      let noOfHouseHold = 0;
      household.forEach(person => {
        noOfHouseHold = !this.checkIfPersonExpunged(person) ? noOfHouseHold + 1 : noOfHouseHold;
      });
      return noOfHouseHold;
    } else {
      return 0;
    }
  }

  filterOtherPersonCount() {
    if (this.involvedPersonList === undefined) { return 0; }
    const others =  this.involvedPersonList.filter(person => person.ishousehold !== 1 && person?.programarea && person?.programarea.length>0 && person?.programarea.some((item: { objectid: string; }) => item.objectid === this.id) && (this.nonCpsCase || (!this.nonCpsCase && person?.personmovestatus == 1)));
    if (others && others.length) {
      let noOfOthers = 0;
      others.forEach(person => {
        noOfOthers = !this.checkIfPersonExpunged(person) ? noOfOthers + 1 : noOfOthers;
      });
      return noOfOthers;
    } else {
      return 0;
    }
  }

  filterInactivePersonCount() {
    if (this.involvedPersonList === undefined) { return 0; }
    const inactive =  this.involvedPersonList.filter(person => !person?.programarea || (person?.programarea && person?.programarea.length>0 && person?.programarea.every((item: { objectid: string; }) => item.objectid !== this.id)) || (!this.nonCpsCase && person?.personmovestatus == 0));
    if (inactive && inactive.length) {
      let noOfInactive = 0;
      inactive.forEach(person => {
        noOfInactive = !this.checkIfPersonExpunged(person) ? noOfInactive + 1 : noOfInactive;
      });
      return noOfInactive;
    } else {
      return 0;
    }
  }

  loadSupervisorList() {
    this._commonHttpService.getPagedArrayList(
        new PaginationRequest({
            where: { appevent: 'CWIF' },
            method: 'post'
        }),
        'Intakedastagings/getroutingusers'
        )
    .subscribe((result: any) => {
        this.supervisorsList = result.data;
        this.supervisorsList = this.supervisorsList.filter((users: { rolecode: string; }) => users.rolecode === 'SP');
        const supervisor = this.supervisorsList.filter((x: { userid: string; })=>x.userid == this._authService.getCurrentUser().user.userprofile.supervisorid);
        this.selectedSupervisor = supervisor.length>0 ? supervisor[0].userid : '';
    });
}

sendForApproval(status: string){
  if(this.movecomments == '' && status == 'Rejected'){
    this._alertService.error('Please Add reason/comments for rejection');
    return;
  }
    const data = {
      caseType: this.nonCpsCase ? 'NonCPS' : 'CPS',
      supervisor: status == 'Review' ? this.selectedSupervisor : this._authService.getCurrentUser().user.securityusersid,
      programs: this.activePrograms,
      status: status,
      eventtype: this.activeTab == 'inactive' ? 'MPIA' : 'MPAI',
      personid: this.programPersonDetails.personid,
      caseid: this.id,
      comments: this.movecomments
    }
    this._commonHttpService.create(data, 'Personprogramareas/movepersonApproval').subscribe(response => {
      if(status == 'Review') {
        this.isRequestSent = true;
        this._alertService.success('Request sent to Supervisor');
        this.getPersonHistory(false);
        $('#move-person-card').modal('hide');
        $('#program-assignment-service-case').modal('show');
      } else {
        this._alertService.success('Move person request has been '+ status);
        $('#move-person-card').modal('hide');
        $('#program-assignment-service-case').modal('hide');
        this.filterHouseHold('household');
        this.personLoadFlag = true;
        this.localStorage.setItem(CASE_STORE_CONSTANTS.PERSON_MOVE_ID, null);
        window.location.reload();
      }
    });
}

  openFindIndividual() {
    this._findIndividualService.resetSearchCriteria();
    this._dataStoreService.setData(IntakeStoreConstants.PERSON_TO_SEARCH, null);
    this._dataStoreService.setData(IntakeStoreConstants.PERSON_SEARCH_CASE, this.id);
    this._router.navigate(['../find-individual/search'], { relativeTo: this.route });
  }

  updateIntakeServiceRequestActorid(roles: any) {
    if(roles?.length > 0) {
      let childIndex = roles.findIndex((person: any)=> person['intakeservicerequestpersontypekey'].toUpperCase() === 'CHILD');
      if (childIndex > -1) {
        this._hospitalizationService.intakeservicerequestactorid = roles[childIndex]['intakeservicerequestactorid'];
      } else {
        this._hospitalizationService.intakeservicerequestactorid = roles[0]['intakeservicerequestactorid'];
      }
    }
  }
  editPerson(person: any) {
    this.updateIntakeServiceRequestActorid(person['roles']);
    let isChildRole = (person && person.roles && person.roles.length > 0 && (person.roles.findIndex((e: any) => e.intakeservicerequestpersontypekey === 'CHILD') > -1));
    this._dataStoreService.setData('isChildRole', isChildRole);
    const isExpungementSuperUser = this._authService.isExpungementSuperUser();
    const intake = this.getIntakeNumber();
    this._commonHttpService
    .getPagedArrayList(
        new PaginationRequest({
            where: { objectid: this.id ? this.id : intake, personid: person.personid,isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged},
            method: 'get',
            nolimit: true
        }),
        'Personprogramareas/getpersonprogramarea?filter'
    )
    .subscribe((result) => {
        if (Array.isArray(result) && result?.length) {
            this.programAsssignList = result[0];
            this.programPersonDetails = result[0].persondetails;
            if(this.programAsssignList?.personprogramarea !== null) {
              this.personprogramareaFn(person);
            } else {
              this._service.editPerson(person.personid, false);
            }
        }
    });
  }

  private personprogramareaFn(person: any) {
    const programAreaOohList = this.programAsssignList.personprogramarea.filter((item: {programkey: any;}) => item.programkey === "OOH");
    this._service.editPerson(person.personid, (programAreaOohList.length > 0) ? true : false);
    let isActiveOoh = false;
    if (programAreaOohList && programAreaOohList.length > 0) {
      programAreaOohList.forEach((element: { enddate: null; }) => {
        if (element.enddate === null) {
          isActiveOoh = true;
        }
      });
    }
    this._service.editPerson(person.personid, (programAreaOohList.length > 0) ? true : false, isActiveOoh);
  }

  viewPerson(person: any) {
    if(person.cferesourcehomechild && person.cfeToolTip) {
      this._dataStoreService.setData('person_cfetooltip', person.cfeToolTip);
    }
    this._dataStoreService.setData('isAdoptiveParent', person.isAdoptiveParent);
    this._service.viewPerson(person.personid);
  }

  viewPersonHealthSummary(person: any, extras?: { path: string, updatedon: string }) {
    if(person.cferesourcehomechild && person.cfeToolTip) {
      this._dataStoreService.setData('person_cfetooltip', person.cfeToolTip);
    }
    this._dataStoreService.setData('isAdoptiveParent', person.isAdoptiveParent);
    this._service.viewPersonHealthSummary(person.personid, extras);
  }

  openAddUnkModal() {
    this.unkPersonFormGroup.controls['Firstname'].disable();
    this.unkPersonFormGroup.controls['Lastname'].disable();
    $('#intake-unkperson').modal('show');
  }

  initiateUnkFormGroup() {
    this.unkPersonFormGroup = this._formBuilder.group({
      role: ['', Validators.required],
      Firstname: [{value: 'Unknown', disabled: true}],
      Middlename:'',
      Lastname:[{value: 'Unknown', disabled: true}],
      DobDisp: [{value: new Date(this.defaultdt), disabled: true}],
      Dob: this.defaultdt,
      isapproxdob: 1,
      gendertypekey: 'U',
      roletype: 'household',
      citizenalenageflag: 1,
      primarycitizenship: 'USA',
      nationality: 'USA',
      ishousehold:1,
      dangerousself: 2,
      Dangerousworker: 2,
      ismentalimpair: 2,
      ismentalillness: 2
    });
  }

  initendDateForm() {

    this.endDateForm = this._formBuilder.group({
      endDate: ['']
    });
  }

  confirmDelete(index: any, person: any) {
    this.selectedIndex = index;
    this.selectedPerson = person;
    $('#confirm-delete-person').modal('show');   
  }

  resetSelectedPerson() {
    this.selectedIndex = -1;
    this.selectedPerson = null;
  }
  confirmPersonDelete() {
    const index = this.selectedIndex;
    const person = this.selectedPerson;
    this.involvedPersonList.splice(index, 1);
    this.involevedPerson.splice(index, 1);
    this.involevedPerson$ = observableOf(this.involevedPerson);
   
                this._service.removeInvolvedPersons(person)?.subscribe(() => {
                  this.loadPersons();
                });
      
    let addedPersons: any = [];
    if (this.involvedPersonList
      && this.involvedPersonList.length) {
       addedPersons = this.involvedPersonList.map(item => {
          return this._intakeConfig.mapOldJsonData(item);
      });
      }
      this._dataStoreService.setData(
        IntakeStoreConstants.addedPersons,
        addedPersons
    );
    this.resetSelectedPerson();
  }

  addUnkPerson() {
    const person = this.unkPersonFormGroup.getRawValue();
    this.addPerson(person);

  }

  deleteUnkPerson(person: any) {
    this.involvedUnkPerson = this.involvedUnkPerson.filter((item: {id: any;}) => item.id !== person.id);
    this._dataStoreService.setData(IntakeStoreConstants.addedUnkPersons, this.involvedUnkPerson);
    this._alertService.success('Person deleted successfully.');
  }

  /* Service case - Program Assignment */

  checkPreviousProgramAssignmentEnded() {
    if (this.programAsssignList?.personprogramarea && this.programAsssignList?.personprogramarea?.length) {
      const endDate = this.programAsssignList?.personprogramarea.filter((item: { enddate: null; }) => item?.enddate === null);
      if (endDate.length) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  loadProgramAssignForm() {
    this.returnMinStartDateFn();
    this.minStartDate = moment(this.minStartDate).startOf('day').toDate();
    this.outhomestatus = false;
    this.outhomemessage = null;
    this.isAddAssignment = true;
    this.addAssignmentForm.reset();
    this.loadProgramAreaDropdowns(null);
    this.loadEndReasonDropDown();
    if (this.checkPreviousProgramAssignmentEnded()) {
      $(this.addprogramassignmentpopupid).modal('show');
      this.addAssignmentForm.enable();
      this.addAssignmentForm.get('enddate')?.enable();
    } else {
      $('#end-previous-prog-assignment-alert').modal('show');
    }
}

loadProgramAssignmentDropDownValues$(servicerequesttypekey: any): Observable<any>{
  const programareaDropDownList$ = this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
              where: { servicerequestsubtypekey: servicerequesttypekey },
              method: 'get',
              nolimit: true
          }),
          this.agencyprogramarealisturl
      );
  const reasonForEndDropDownList$ = this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
              where: { referencetypeid: 357, teamtypekey: 'CW' },
              method: 'get',
              nolimit: true
          }),
          'referencetype/gettypes?filter'
      );

  return forkJoin([programareaDropDownList$, reasonForEndDropDownList$]);
}

initAddAssignmentForm() {
    this.addAssignmentForm = this._formBuilder.group(
        {
            programkey: ['', Validators.required],
            subprogramkey: [''],
            ifpsatriskflag: [''],
            startdate: ['', Validators.required],
            enddate: [''],
            endreasonkey: [''],
            isdefault: false
        }
    );
}

initProgramForm(){
  this.programForm = this._formBuilder.group({
    programs: this._formBuilder.array([]) // Initialize FormArray
  });
}

loadEndReasonDropDown() {
    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                where: { referencetypeid: 357, teamtypekey: 'CW' },
                method: 'get',
                nolimit: true
            }),
            'referencetype/gettypes?filter'
        )
        .subscribe((result) => {
            if (result && Array.isArray(result) && result.length) {
              this.reasonForEndAllList =  result;           
              this.reasonForEndList$ = of(result);
            }
        });
}

loadRemovalCircumstances() {
  this._commonHttpService
      .getPagedArrayList(
          new PaginationRequest({
              where: { referencetypeid: 1200, teamtypekey: 'CW' },
              method: 'get',
              nolimit: true
          }),
          'referencetype/gettypes?filter'
      )
      .subscribe((result) => {
         this.removalCircumstancesObj = result;
      });
}

viewChanged() {
    this._commonHttpService.create({
        viewpreference: this.changeView
    }, NewUrlConfig.EndPoint.Intake.ViewPreference).subscribe();
}


getPersonInfo(person: any, caseType: string){
  this.selectedPersonId = person?.personid;
  this.selectedCjamspid = person?.cjamspid;
  this.cpsAssignment = false;
  this.isAdoptiveParent = person.isAdoptiveParent;
  this.getPersonData(person, caseType);
}

getPersonData(person: any, caseType: string) {
    this.nonCpsCase = caseType === 'nonCPS';
    this.activepersondetails = person;
    this.personid = person.personid;
    this.getProgramAssignmentList();
    if (person.roles && person.roles.length) {
      this.isChildOrNotCheck = person.roles.some((item: { intakeservicerequestpersontypekey: string; }) => ['CHILD', 'AV', 'OTHERCHILD'].includes(item.intakeservicerequestpersontypekey));
      const data = person.roles.filter((item: { intakeservicerequestpersontypekey: string; }) => item.intakeservicerequestpersontypekey === 'AV' || item.intakeservicerequestpersontypekey === 'CHILD');
      this.isValidateProgramArea = data.length > 0;
    }
    this.resetAllChecklists();
    this.getInvolvedPersonWithPersonID();
}

  resetAllChecklists(){
    this.isServicePlanPresent = false;
    this.servicelogcompleted = false;
    this.isAttemptedOrCompletedContactNote = false;
    this.isAllServiceLogsEndDated = false;
  }

  checkCPSActiveProgram() {
    const caseTypeValue = this.caseType === 'CPS-AR' ? 'AR' : null;
    const activeProgramKey = this.caseType === 'CPS-IR' ? 'IR' : caseTypeValue;
    if (!this.nonCpsCase && activeProgramKey) {
      this.noActiveProgram = true;
      if (this.programAsssignList && this.programAsssignList.personprogramarea) {
        const activePrograms = this.programAsssignList.personprogramarea.filter((programArea: { subprogramkey: string; objectid: string; }) => programArea.subprogramkey === activeProgramKey && programArea.objectid === this.id);
        if (activePrograms.length > 0){
          this.noActiveProgram = false;}
      }
      this.cpsAssignment = true;
    }
  }

getProgramAssignmentList() {
  const isExpungementSuperUser = this._authService.isExpungementSuperUser();
  const intake = this.getIntakeNumber();
    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                where: { objectid: this.id? this.id: intake, personid: this.personid,isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged },
                method: 'get',
                nolimit: true
            }),
            'Personprogramareas/getpersonprogramarea?filter'
        )
        .subscribe((result: any) => {
            if (result && Array.isArray(result) && result.length) {
              this.programAsssignList = result[0];
              this.programPersonDetails = result[0].persondetails;
              const caseNumber = this._dataStoreService.getData('dsdsActionsSummary')?.da_number || null;
              this.isMoveable = this.programAsssignList?.personprogramarea?.some((item: any) => (item?.objectid == this.id || (item?.objecttypekey == 'servicerequest' && item?.casenumber == caseNumber)) && (item?.programkey === "OOH" || item?.programkey === "ADP" || item?.programkey === "GAP" || item?.programkey === "KIN"));
              this.activePrograms = this.programAsssignList?.personprogramarea?.filter((x: any)=>!x?.enddate && x?.objectid==this.id);
              this.getPersonHistory(false);
              this.checkCPSActiveProgram();
            }
        });
}

sendcaseprogramarea(programAsssignList: any,persondetails: any) {
  if (programAsssignList && Array.isArray(programAsssignList)) {
    const programAsssigns = programAsssignList.filter(program => program.datatransferflag !== 'C');
    if (programAsssigns && Array.isArray(programAsssigns)) {
       programAsssigns.forEach((program) => this.sendPro(program, persondetails) );
    }
  }

}
sendPro(program: any, persondetails: any) {
    const modal = {
      sendcaseprogramarea : 'Y',
      personprogramid : program.personprogramid,
      personid: program.personid
    };
    if (persondetails && persondetails.cisclientid && persondetails.personid === program.personid ) {
      this._commonHttpService
      .create(modal, this.personprogramareasaddupdateurl)
      .subscribe(() => {
        // No content to add or call
      });
    }
}

updateStartAndEndDate(selecteddate: string, isstartdate: boolean) {
  this._dataStoreService.getData('dsdsActionsSummary');
  const caseOpenDate = this.nonCpsCase ? this._dataStoreService.getData('intakereporteddate') : this.programPersonDetails.addedon;
  const startdate = this.addAssignmentForm.controls['startdate'].value;
  const errormsg = this.nonCpsCase ? 'Program start date should be greater than case open date' : 'Program start date should be greater person added on date';

  if ((this.addAssignmentForm.controls['programkey'].pristine ||
  ((this.addAssignmentForm.controls['programkey'].value === 'KIN' || this.addAssignmentForm.controls['programkey'].value === 'IHSFP' || this.addAssignmentForm.controls['programkey'].value === 'AXYS') && this.addAssignmentForm.controls['subprogramkey'].pristine))
  && this.isAddAssignment) {
  this._alertService.error('Please select a program area (and program sub area if required) before adding a date');
  this.addAssignmentForm.controls['startdate'].reset();
  this.addAssignmentForm.controls['enddate'].reset();
}
  //CHECK START DATE NOT LESSER THAN CASE OPEN/REOPEN DATE
  if (isstartdate && startdate && moment(startdate).diff(moment(caseOpenDate), 'days') < 0) {
    this._alertService.error(errormsg);
    this.addAssignmentForm.controls['startdate'].reset();
    this.minDate = null;
  }

  //CHECK END DATE NOT LESSER THAN START DATE
  if (!isstartdate && startdate &&  moment(selecteddate).diff(moment(startdate), 'days') < 0) {
    this._alertService.error('Program end date should be greater than start date');
    this.addAssignmentForm.controls['enddate'].reset();
  }

}

updateEndDate(date: string, startdate: boolean) {
  if (startdate) {
    this.minDate = new Date(date);
    this.addAssignmentForm.controls['enddate'].reset();
  }
  const data =  this._dataStoreService.getData('dsdsActionsSummary');
  const caseStartDateValue = (this.caseStartDate ? this.caseStartDate : data.case_opendate);
  const caseOpenDate = this.nonCpsCase? caseStartDateValue : data.da_receiveddate;
  const dateDiff =  moment(date).diff(moment(caseOpenDate), 'days');
  let enddateDiff = 0;
  if (data.case_closedate) {
    enddateDiff  =  moment(date).diff(moment(data.case_closedate), 'days');
  }
  if (startdate) {
    if (dateDiff < 0) {
      this._alertService.error('Program date should be greater than case open date');
      this.addAssignmentForm.controls['startdate'].reset();
      this.minDate = null;
    }
  } else {
    if (dateDiff < 0 || enddateDiff > 0) {
      this._alertService.error('Program date should be greater than case open date');
      this.addAssignmentForm.controls['enddate'].reset();
    }
  }
}

getIveDetermintationDetails (ivedeterminationdetails: any, iverejecteddeterminationdetails: any) {
  if(iverejecteddeterminationdetails && iverejecteddeterminationdetails.length) {
    if(iverejecteddeterminationdetails[0].sqnm_sw === ivedeterminationdetails[0].sqnm_sw && ivedeterminationdetails[0].approvalstatus === 'REJECTED') {
       return ivedeterminationdetails[1].ivestatustype;
    } else {
      return ivedeterminationdetails[0].ivestatustype;
    }
  } else {
    return ivedeterminationdetails[0].ivestatustype;
  }
}


getAdoptionDetermintationDetails (ivedeterminationdetails: any, iverejecteddeterminationdetails: any) {
  if(iverejecteddeterminationdetails && iverejecteddeterminationdetails.length) {
    if(iverejecteddeterminationdetails[0].sqnm_sw === ivedeterminationdetails[0].sqnm_sw && ivedeterminationdetails[0].approvalstatus === 'REJECTED') {
       return ivedeterminationdetails[1].adoptionstatustype;
    } else {
      return ivedeterminationdetails[0].adoptionstatustype;
    }
  } else {
    return ivedeterminationdetails[0].adoptionstatustype;
  }
}

movePerson(){
  this.loadEndReasonDropDown();
  $('#move-person-card').modal('show');
}

closeMovePerson(){
  if(this.selectedSupervisor !== this._authService.getCurrentUser().user.securityusersid){
    this.localStorage.setItem(CASE_STORE_CONSTANTS.PERSON_MOVE_ID, null);
  }
  $('#move-person-card').modal('hide');
  $('#program-assignment-service-case').modal('show');
}

movePersonHistory(){
    $('#move-person-card').modal('hide');
    $('#move-person-history').modal('show');
}

reviewMovePerson(){
  $('#move-person-history').modal('hide');
  this.personLoadFlag = false;
  this.getPersonHistory(true);
}

getPersonHistory(shouldfilter: any){
  const data = {
    caseid: this.id,
    personid: this.programPersonDetails.personid
  }
  this._commonHttpService.create(data, 'Personprogramareas/movepersonHistory').subscribe((response: any) => {
    this.personHistory = response;
      this.isRequestSent = this.personHistory && this.personHistory?.some((item: { status: string; }) => item.status == 'Review');
      if(this.isRequestSent && this.shouldFilterPersons() || shouldfilter){
        this.loadEndReasonDropDown();
        this.personHistory[0]?.endvalue?.forEach((ele: any) => {
          ele.enddate = new Date(ele.enddate);
        });
        this.activePrograms = this.personHistory[0].endvalue;
        this.selectedSupervisor = this.supervisorsList.filter((x: { username: string; })=>x?.username?.replace(/\s/g, '')?.trim() == this.personHistory[0]?.requestedto?.replace(/\s/g, '')?.trim())?.[0]?.userid;
        $('#move-person-card').modal('show');
      }
  });
}

editProgramAssigment(person: any, action?: string ) {
 
  if(action === 'view'){
    this.handleProgramAreaListViewCondFn(person);
   
  } else {
    const caseNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    if (caseNumber !== person.casenumber && !action && this.programAsssignList?.personprogramarea?.[0].programkey !== "KIN") {
     
      this.editprogramassignment = false;
      $('#program-assignment-service-case').modal('show');
      this.isProgramAreaKinshipSelected = false;
       this._alertService.error(`You cannot edit the Program Assignment for this client as this Program Assignment is added in case # ${person.casenumber} Program Assignment can be edited from the origin case ${person.casenumber} only`);
    }
    else{
      this.editprogramassignment = true;
      this.outhomestatus = false;
      this.outhomemessage = null;
      this.checkaccesstoproceed(null, 'checkDue', person);
      this.isAddAssignment = false;
      this.minDate = new Date(person.startdate);
      this.returnMinStartDateFn();
      this.minStartDate = moment(this.minStartDate).startOf('day').toDate();
      this.personprogramid = person.personprogramid;
  
      this.handleProgramAreaListNotViewCondFn(person);
      
    }
  }
}
  private returnMinStartDateFn() {
    const dateReceived = this._dataStoreService.getData('da_receiveddate') ? new Date(this._dataStoreService.getData('da_receiveddate')) : new Date();
    const caseStartDateValue = (this.caseStartDate ? this.caseStartDate : dateReceived);
    this.minStartDate = this.nonCpsCase ? caseStartDateValue : dateReceived;
  }

// Assosiated to editProgramAssigment method
  private handleProgramAreaListNotViewCondFn(person: any) {
    this.loadProgramAssignmentDropDownValues$(null).subscribe(([programAreaList, reasonForEndList]) => {
      if (programAreaList && Array.isArray(programAreaList) && programAreaList.length) {
        this.programArea = programAreaList[0].programarea;
        this.programArea = this.programArea.filter(function (n: any) { // NOSONAR    // Duplicate function has less than 3 lines hence marking it as no sonar.
          const progAreaArray = ['ADP', 'GAP', 'IS', 'OOH'];
          const manual = progAreaArray.includes(n.programkey);
          return !manual;
        });
        if (this.nonCpsCase){
          this.programArea = this.programArea.filter((item: { programkey: string; }) => item.programkey !== 'CPS');

        } else{
          this.programArea = this.programArea.filter((item: { programkey: string; }) => item.programkey === 'CPS');
        }
      }


      if (reasonForEndList && Array.isArray(reasonForEndList) && reasonForEndList.length) {
        this.reasonForEndAllList = reasonForEndList;
        this.reasonForEndList$ = of(reasonForEndList);
      }
      this.updateReasonForEndList(person.programkey);

      this.addAssignmentForm.patchValue(
        {
          startdate: person.startdate,
          enddate: person.enddate,
          programkey: person.programkey,
          subprogramkey: person.subprogramkey,
          endreasonkey: person.endreasonkey,
          ifpsatriskflag: (person.ifpsatriskflag) ? 'Yes' : 'No',
          isdefault: person.isdefault,
        }
      );

      this.addAssignmentForm.enable();
      this.addAssignmentForm.get('programkey')?.disable();
      this.addAssignmentForm.get('subprogramkey')?.disable();
      if (this.programAsssignList?.personprogramarea?.[0].programkey === "KIN") {
        this.updateSubprogramArea(programAreaList);
      }
      this.addAssignmentForm.get('startdate')?.disable();

    });
  }
  // Assosiated to editProgramAssigment method
  private handleProgramAreaListViewCondFn(person: any) {
    this.loadProgramAssignmentDropDownValues$(null).subscribe(([programAreaList, reasonForEndList]) => {
      if (programAreaList && Array.isArray(programAreaList) && programAreaList.length) {
        this.programArea = programAreaList[0].programarea;
        this.programArea = this.programArea.filter(function (x: { programkey: string; }) {
          const progAreaArray = ['ADP', 'GAP', 'IS', 'OOH'];
          const manual = progAreaArray.includes(x.programkey);
          return !manual;
        });
        if (this.nonCpsCase){
          this.programArea = this.programArea.filter((item: { programkey: string; }) => item.programkey !== 'CPS');

        } else{
          this.programArea = this.programArea.filter((item: { programkey: string; }) => item.programkey === 'CPS');
        }

        this.updateSubprogramArea(programAreaList, 'view');
      }


      if (reasonForEndList && Array.isArray(reasonForEndList) && reasonForEndList.length) {
        this.reasonForEndAllList = reasonForEndList;
        this.reasonForEndList$ = of(reasonForEndList);
      }

      this.reasonForEndList$ = of(this.reasonForEndAllList);

      this.addAssignmentForm.patchValue(
        {
          startdate: person.startdate,
          enddate: person.enddate,
          programkey: person.programkey,
          subprogramkey: person.subprogramkey,
          endreasonkey: person.endreasonkey,
          ifpsatriskflag: (person.ifpsatriskflag) ? 'Yes' : 'No',
        });
      this.addAssignmentForm.disable();
    });
  }

checkprogramAssignmentEditble(programKey: any) {
  const programAreaArray = ['IS', 'OOH'];
  const exists = programAreaArray.includes(programKey);
  return !exists;
}

checkAge() {
  const dob = moment(this.programPersonDetails?.dob);
  const age = moment().diff(dob, 'years', true);
  if (age < 18) {
      return true;
  }
  if (age > 21) {
    return true;
  }
  return false;
}
loadChecklist() {
  this._commonHttpService
    .getArrayList(
      new PaginationRequest({
        nolimit: true,
        method: 'get',
        where: {
          iskinship: 1
        }
      }),
      `${CaseWorkerUrlConfig.EndPoint.DSDSAction.kinship.checklistUrl}?filter`
    )
    .subscribe((result: any) => {
      this.checklistItems = result.map((res: any) =>
          new DropdownModel({
            text: res.name,
            value: res.amtaskid
          })
      );
    });
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
  const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
  if (caseID) {
    return caseID;
  }
  const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
  let caseUUID = null;
  if (caseInfo) {
    caseUUID = caseInfo.intakeserviceid;
  }
  return caseUUID;
}

isIntakeMode() {
  return this.getIntakeNumber() ? true : false;
}

getSource() {

  if (this.isServiceCase) {
   return AppConstants.CASE_TYPE.SERVICE_CASE;
  } else if (this.isIntakeMode()) {
    return AppConstants.CASE_TYPE.INTAKE;
  } else {
    return AppConstants.CASE_TYPE.CPS_CASE;
  }
}

getRequestParam(personid: string) {
  var inputRequest: any;
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
  if(personid) {
    inputRequest.personid=personid;
  }

  const isExpungementSuperUser= this._authService.isExpungementSuperUser()
  inputRequest.isExpungementSuperUser= isExpungementSuperUser;
  inputRequest.iscaseexpunged =  this.iscaseexpunged;
  return inputRequest;
}

getInvolvedPersonWithPersonID() {
  this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 200,
        nolimit: true,
        method: 'get',
        where: this.getRequestParam(this.personid)
      }),
      'People/getallpersonrelationbyprovidedpersonid?filter'
    ).subscribe(response => {
      if (response && Array.isArray(response)) {
        const bilogicalParents = response.filter(element => ((element.relationshiptypekey === 'BGMTHR' || element.relationshiptypekey === 'BGFTHR') && element.person2id !== this.legalGaurdianPersonId));
        const mergeParentorBilogicalArray = this.parentOrLegalGaurdian.concat(bilogicalParents);
        this.parentOrLegalGaurdian = mergeParentorBilogicalArray;
         const caregiver = response.find(element => element.caregiverflag === 1);
         this.caregiversInCase = caregiver ? caregiver.person2id : null;
      }});
}

findCaregiverContact(){
  const isExpungementSuperUser = this._authService.isExpungementSuperUser();
  this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: null,
                    limit: null,
                    nolimit: true,
                    where: {isExpungementSuperUser: isExpungementSuperUser,'iscaseexpunged': this.iscaseexpunged},
                    method: 'get'
                }),
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl}/${this.id}?data`
            )
            .subscribe((result) => {
                const recording = result.data;
                let contactparticpants = [];

                recording.forEach(() => {
                  return;
                });
            });
}

getServiceLogList() {
  return this._commonHttpService.getArrayList(
    {
      where: { daNumber: this.daNumber, client_id: [this.selectedCjamspid] },
      method: 'get',
      nolimit: true
    },
    `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.servicelogmultipelist}?filter`
  );
}

getVendorList() {

  return this._commonHttpService.getArrayList(
      {
          where: { daNumber: this.daNumber, clientid: [this.selectedCjamspid], nolimit: true },
          method: 'get'
      },
      `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.multivendorServiceLog}?filter`
  );
}
getServicePlans() {
  const payload = {
    method: 'get',
    where: {
      caseid : this.getCaseUuid()
    }
  };
  this._commonHttpService.getArrayList(payload, 'serviceplan/listbyallrelation?filter').subscribe(
    response => {
        if (response && response.length && response.length !== 0) {
          this.isServicePlanPresent = true;
        }
    });
  }
  
  listAffidavit() {
    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 100,
                where: { objectid: this.id },
                method: 'post'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Affidavit.List
        );

}

  getAssessments() {
    let inputRequest: Object;
    if (this.isServiceCase) {
      inputRequest = {
        objecttypekey: 'servicecase',
        objectid: this.id
      };
    } else {
      const isExpungementSuperUser = this._authService.isExpungementSuperUser();
      inputRequest = {
        servicerequestid: this.id,
        categoryid: null,
        subcategoryid: null,
        targetid: null,
        assessmentstatus: null,
        isExpungementSuperUser: isExpungementSuperUser,
        'iscaseexpunged': this.iscaseexpunged
      };
    }
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          where: inputRequest,
          method: 'get'
        }),
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.ListAssessment}?filter`
      )
      .subscribe(result => {
        this.assessmentListResponseFn(result);
      });
  }

  private assessmentListResponseFn(result: any) {
    const list = result.data;
    const safec = list.filter((item: { description: string; }) => item.description.toUpperCase() === 'SAFE-C');
    let safecList = safec && safec.length && safec[0].intakassessment ? safec[0].intakassessment : [];
    safecList = safecList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
    const safecohp = list.filter((item: { description: string; }) => item.description.toUpperCase() === 'SAFE-C OHP');
    let safecohpList = safecohp && safecohp.length && safecohp[0].intakassessment ? safecohp[0].intakassessment : [];
    safecohpList = safecohpList.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
    let isSafeAssDone = false;
    if (safecohpList.length > 0 || safecList.length > 0) {
      isSafeAssDone = true;   //  NOSONAR   // this whole function is redundant. need to re-evalute
    }
    const ismifradone = this.assessmentCompletion(list, 'MFIRA');
    const ismfradone = this.assessmentCompletion(list, 'MARYLAND FAMILY RISK REASSESSMENT');
    const isrisklegacydone = this.assessmentCompletion(list, 'RISK ASSESSMENT LEGACY');

    let ismfraandmfiradone = false;
    if (ismifradone === true || ismfradone === true || isrisklegacydone === true) {
      ismfraandmfiradone = true;   //  NOSONAR   // this whole function is redundant. need to re-evalute
    }
  }

assessmentCompletion(list: any, assessmentname: any) {
  const assessment = list.find((item: { description: string; }) => item.description.toUpperCase() === assessmentname);
  let submissionlist = assessment && Array.isArray(assessment.intakassessment) ? assessment.intakassessment : [];
  submissionlist = submissionlist.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey === 'Accepted');
  return (submissionlist.length > 0);
}

checkAttemptedOrCompletedKinshipContactNote() {
  this._commonHttpService.getArrayList(
    {
      where: { 
        intakeserviceid: this.id, 
        personid: this.selectedPersonId 
      },
      method: 'get',
      nolimit: true
    },
    `${CaseWorkerUrlConfig.EndPoint.DSDSAction.kinship.KinshipContactNote}?filter`
  ).subscribe(data => {
    if(data && data?.[0].findkinshipnavigationservicescontactnote){
      this.isAttemptedOrCompletedContactNote = true;      
    }else {
      this.isAttemptedOrCompletedContactNote = false;
    }
    this.kinshipChecklistCompleted();
  });
}
checkallservicelog() {
  let vendorlist: any[] = [];
  let agencylist: any[] = [];
  this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    const slsource = this.getServiceLogList();
  const vssource = this.getVendorList();

  forkJoin([slsource, vssource])
    .pipe(
      takeUntil(this.ngUnsubscribe)
    ).subscribe((values: any) => {
      vendorlist = values?.[1]?.['servicelogData']?.filter((data: { agency_program_area_id: string; }) => data?.agency_program_area_id === 'KIN');
      const servicelogData = values?.[0].filter((data: { agency_program_area_id: string; }) => data?.agency_program_area_id === 'KIN');
      const list = Array.isArray(servicelogData) ? servicelogData : [];
      agencylist = list;

      if (vendorlist && agencylist) {
        let agencylistcompleted = false;
        let vendorlistcompleted = false;
        if (agencylist.length) {
            const valid = agencylist.some((item: {actual_end_date: null;}) => item.actual_end_date === null);
            agencylistcompleted = !valid;
        } else {
            agencylistcompleted = true;
        }
  
        if (vendorlist.length) {
            const valid = vendorlist.some((item: { actual_end_date: null; }) => item.actual_end_date === null);
            vendorlistcompleted = !valid;
        } else {
            vendorlistcompleted = true;
        }
        if (vendorlistcompleted && agencylistcompleted){
        this.servicelogcompleted = true;
        }else{
          this.servicelogcompleted = false;
        }
        this.kinshipChecklistCompleted();
      }
    });
}

kinshipChecklist() {
  this.kinshipChecklistComplete = true;
  $('#kinship-navigator-checklist-popup').modal('hide');
  this.saveProgramAssignment();
}

saveEndDate() {
  const model = {
    personid: this.personid,
    enddate: this.endDateForm.value.endDate
  };
  this._commonHttpService
    .create(model,
        'Personprogramareas/updateEndDate'
    )
    .subscribe(() => {
        $(this.addprogramassignmentpopupid).modal('show');
        this._alertService.success('Program assignment Ended successfully!');
    });
}
showProgramassignment(){
  $(this.addprogramassignmentpopupid).modal('show');
}
  saveProgramAssignment() {
    this.checkmandatory = true;
    // tslint:disable-next-line:max-line-length
    if(this.addAssignmentForm.value.enddate && !this.addAssignmentForm.value.endreasonkey){
      this.addAssignmentForm.get('endreasonkey')?.setErrors({ 'invalid': true });
      return;
    }  
  
    if(!this.addAssignmentForm.controls['startdate'].value){
      this.addAssignmentForm.get('startdate')?.setErrors({ 'invalid': true });
      return;
    }
    this.checkSaveProgramAssignmentFn();
    
}

checkSaveProgramAssignmentFn(){
if (this.saveProgramAssignmentCondCheckFn()) {
  if(!this.saveProgramAssignmentCondCheckCond1Fn()) {
    return;
  }
  
  if(this.returnKinCondFn()) {
    $(this.addprogramassignmentpopupid).modal('hide');
    }
   if (!this.addAssignmentForm.controls['startdate'].value) {
    this._alertService.warn('Please provide Start Date');
    return false;
  }
  if (!this.checkOnlyProgramkeyFn()) {
    this._alertService.warn('Please provide Program Area');
    return false;
  }
  if (this.checkSubprogramkeyAndEndDateFn()) {
    this.conditionToShowChecklistPopupFn();
    return;
  }
  this.kinshipChecklistComplete = false;
  this.roleId = this._authService.getCurrentUser();

  if (this.addAssignmentForm['controls'].isdefault.value && this.addAssignmentForm['controls'].enddate.value) {
      this.confrimMessage = "The Active SEN will change to a Historic SEN and the approved POSC will become a Historic Plan of Safe Care by ending the program assignment. Please ensure before proceeding further.";
      this.isConfrimPopup = true;
      this.globalPopupRef.openConfirmationModal();
  } else {
      this.personprogramareasaddupdateApiFn();
  }
}
}

confrimedSave(event: any) {
  if (event) {
      this.personprogramareasaddupdateApiFn();
  } else {
      this.globalPopupRef.closeConfirmationModal();
  }
}
  // Assosiated to saveProgramAssignment method
  private returnKinCondFn() {
    return ((this.addAssignmentForm.controls['programkey'].value === 'KIN'
      || this.addAssignmentForm.controls['subprogramkey'].value === 'KN')
      && this.addAssignmentForm.controls['enddate'].value && !this.kinshipChecklistComplete);
  }
  // Assosiated to saveProgramAssignment method
  private saveProgramAssignmentCondCheckCond1Fn() {
    const startdate = this.addAssignmentForm.controls['startdate'].value;
    const startdt = moment(startdate)
    if (!startdt.isValid()) {
      this.addAssignmentForm.get('startdate')?.setErrors({ 'invalid': true });
      return false;
    }
    if (this.checkMinDateFn(startdt)) {
      this._alertService.error(' should be greater than ' + this.defaultdt);
      return false;
    }
    if (this.CheckPkAndEndDateFn()) {
      this._alertService.warn('Please select reason for end');
      return false;
    }

    if (this.checkAgeFn()) {
      this._alertService.success('Independent Living(Program  Assignment cannot be selected when Client is Under 18 and Over 21 yrs of age)');
      return false;
    }
    return true;
  }
// Assosiated to saveProgramAssignment method
  private saveProgramAssignmentCondCheckFn() {
    return !this.addAssignmentForm.invalid || !this.outhomestatus;
  }
// Assosiated to saveProgramAssignment method
  private checkOnlyProgramkeyFn() {
    return this.addAssignmentForm.controls['programkey'].value;
  }
// Assosiated to saveProgramAssignment method
  private checkStartdateFn() {
    return this.addAssignmentForm['controls'].startdate.value;
  }

  private checkAgeFn() {
    return this.checkAge() && this.addAssignmentForm.value.programkey === 'IL';
  }

  private checkMinDateFn(startdt: moment.Moment) {
    return this.minimumDate && startdt.isBefore(this.minimumDate);
  }

  private checkSubprogramkeyAndEndDateFn() {
    return (this.addAssignmentForm.controls['programkey'].value === 'KIN' || this.addAssignmentForm.controls['subprogramkey'].value === 'KN') && this.addAssignmentForm.controls['enddate'].value && !this.kinshipChecklistComplete;
  }

  private CheckPkAndEndDateFn() {
    return (this.addAssignmentForm.value.programkey === 'IL' || this.addAssignmentForm.controls['programkey'].value === 'IHSFP') && moment(this.addAssignmentForm.controls['enddate'].value).isValid() && (!this.addAssignmentForm.controls['endreasonkey'].value);
  }

  private conditionToShowChecklistPopupFn() {
    $(this.addprogramassignmentpopupid).modal('hide');
    this.findCaregiverContact();
    this.getAssessments();
    this.getServicePlans();
    this.checkallservicelog();
    this.checkAttemptedOrCompletedKinshipContactNote();
    this.loadChecklist();
    $('#kinship-navigator-checklist-popup').modal('show');
  }

  private personprogramareasaddupdateApiFn() {
    const model = {
      personid: this.personid,
      personprogramid: (this.personprogramid && !this.isAddAssignment) ? this.personprogramid : null,
      startdate: this.checkStartdateFn(),
      enddate: this.addAssignmentForm['controls'].enddate.value,
      programkey:  this.addAssignmentForm['controls'].programkey.value,
      subprogramkey: this.addAssignmentForm['controls'].subprogramkey.value,
      endreasonkey: this.addAssignmentForm['controls'].endreasonkey.value,
      clientmergeid: null,
      ifpsatriskflag: (this.addAssignmentForm['controls'].ifpsatriskflag.value === 'Yes') ? 1 : 0,
      securityusersid: this.roleId.user.securityusersid,
      // @Simar: changing this to lower case as the application dependencies / data migration expect 'servicecase' and not 'Servicecase'
      objecttypekey: (this.storage?.getItem('CASE_TYPE') == "ADOPTION") ? 'adoptioncase' : 'servicecase',
      objectid: this.id,
      isdefault: this.addAssignmentForm['controls'].isdefault.value
    };
   if(this.addAssignmentForm.get('programkey')?.value=='CPS'){model.objecttypekey='servicerequest'}
    this._commonHttpService
      .create(model,
        this.personprogramareasaddupdateurl
      )
      .subscribe(() => {
        const status = (this.isAddAssignment) ? 'added' : 'updated';
       $(this.addprogramassignmentpopupid).modal('hide');
        this._alertService.success('Program assignment ' + status + ' successfully!');
        this.getProgramAssignmentList();
        $('#program-assignment-service-case').modal('show');
        this.isProgramAreaKinshipSelected = false;
      });
  }

private loadProgramAreaDropdowns(servicerequesttypekey: string | null) {
    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                where: { servicerequestsubtypekey: servicerequesttypekey },
                method: 'get',
                nolimit: true
            }),
            this.agencyprogramarealisturl
        )
        .subscribe((result) => {
            if (result && Array.isArray(result) && result.length) {
                this.programArea = result[0].programarea;
                this.programArea = this.programArea.filter(function(n: { programkey: string; }){   //NOSONAR     // This function has less than 3 lines of duplicate code. Hence, marking it as No Sonar.
                  const progAreaArray = ['ADP','GAP', 'IS', 'OOH'];
                  const manual = progAreaArray.includes(n.programkey);
                  return !manual;
                });
              if (this.nonCpsCase){
                this.programArea = this.programArea.filter((item: { programkey: string; }) => item.programkey !== 'CPS');
              }else{
                this.programArea = this.programArea.filter((item: { programkey: string; }) => item.programkey === 'CPS');}
            }
        });
}

updateReasonForEndList(programarea: string) : void {
  if(programarea === 'KIN'){
    this.isProgramAreaKinshipSelected = true;
  } else{
    this.isProgramAreaKinshipSelected = false;
  }

  if(programarea === 'IHSFP'){
    this.isProgramAreaInHomeSelected = true;
  } else{
    this.isProgramAreaInHomeSelected = false;
  }

  if(programarea === 'AXYS'){
    this.isProgramAreaAuxiliarySelected = true;
  } else{
    this.isProgramAreaAuxiliarySelected = false;
  }
}

updateSubprogramArea(item: any, programarea?: string): void {
  if (item && item.length) {
    if(this.caseType === 'CPS-IR'){
        this.programSubArea = item[0].subprogram.filter((itemIR: { subprogramkey: string; }) => itemIR.subprogramkey ==='IR');
    }else if(this.caseType === 'CPS-AR'){
        this.programSubArea = item[0].subprogram.filter((itemAR: { subprogramkey: string; }) => itemAR.subprogramkey ==='AR');
    }else if(programarea === 'IHSFP' && this.isAddAssignment) {
        this.programSubArea = item[0].subprogram.filter((itemKN: { subprogramkey: string; }) => itemKN.subprogramkey !=='KN');
    }else if(item[0].programarea.find((itemKIN: { programkey: string; }) => itemKIN.programkey === "KIN") && !this.isAddAssignment){
      this.programSubArea = item[0].subprogram.filter((itemOther: { subprogramkey: string; }) =>["NON","INF", "FOR"].includes(itemOther.subprogramkey));
    }else{
        this.programSubArea = item[0].subprogram
      }
  }
}
   checkaccesstoproceed(value: any, type?: any, progreamInfo?: any) {
    this.updateReasonForEndList(value);
    this._commonHttpService.getArrayList({
      where: { programkey: value }, method: 'get', nolimit: true
    }, this.agencyprogramarealisturl).subscribe((item) => {
      this.updateSubprogramArea(item, value);
      if (item?.length) {
        if (this.caseType === 'CPS-IR') {
          this.programSubArea = item[0].subprogram.filter((i: { subprogramkey: string; }) => i.subprogramkey === 'IR');
        } else if (this.caseType === 'CPS-AR') {
          this.programSubArea = item[0].subprogram.filter((i: { subprogramkey: string; }) => i.subprogramkey === 'AR');
        } else {
            this.getMotivationInterviewActivecounty().subscribe(() => {
            const excludedKeys = new Set(['CSMI', 'FPSMI']);
            this.programSubArea = this.showMotivationalInterviewOptions 
              ? item[0].subprogram
              : item[0].subprogram.filter((subItem: { subprogramkey: string; }) => !excludedKeys.has(subItem.subprogramkey));
            });
        }
       } 
       if (value === 'OOH' && this.activepersondetails.relationship !== 'Child') {
        this._alertService.error('OOH Program Area  Not Allowed For Other Than Child Role.');
        this.addAssignmentForm.controls['programkey'].reset();
        return false;
      }
      // tslint:disable-next-line:radix
      if (value === 'OOH' && (parseInt(this.activepersondetails.age) > 17) && this.activepersondetails.relationship === 'Child') {
        this._alertService.error('OOH Program Area should Not Allowed Over 17 Years');
        this.addAssignmentForm.controls['programkey'].reset();
        return false;
      }
      if (((value === 'IHSFP' || value === 'OOH') && this.activepersondetails.relationship === 'Child') || (this.isValidateProgramArea && type === 'checkDue' && progreamInfo.programkey === 'OOH')) {
        this.checkProgramkeyFn(type, progreamInfo, value);
      } else {
        this.outhomestatus = false;
        this.outhomemessage = null;
      }
    });
  }

  private checkProgramkeyFn(type: string | undefined, progreamInfo: any, value: any) {
    let object = {};
    if (type === 'checkDue') {
      object = {
        personid: this.activepersondetails.personid,
        servicecaseid: progreamInfo.objectid
      };
    } else {
      object = {
        personid: this.activepersondetails.personid,
        servicecaseid: this.activepersondetails.servicecaseid
      };
    }
    this._commonHttpService.getPagedArrayList(new PaginationRequest({
      where: object,
      method: 'get'
    }), 'Caseassignments/validateprogramarea?filter').subscribe((result: any) => {
      if (result.count !== '0') {
        if (value !== 'OOH') {
          this.outhomestatus = true;
          this.outhomemessage = 'Out of home placement is not ended.';
        }
      } else {
        if (value !== 'OOH') {
          this.outhomestatus = false;
          this.outhomemessage = null;
        } else {
          this.outhomemessage = 'Out of home placement is not available';
          this.outhomestatus = true;
        }
      }
    });
  }

  searchOrAddFunctionality() {
    const source = this._dataStoreService.getData(AppConstants.GLOBAL_KEY.SOURCE_PAGE);
    if ( this.noSearchAddList.includes(source)) {
      this.canSearchAdd = false;
    }
  }

  getRemovalHistoryByPerson(person: any){
    this._commonHttpService
    .getSingle(
      {
        where: { objectid: person.personid, 'objecttypekey': 'personid'},
        method: 'get'
      },
      `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
    ).subscribe(data => {
        this.selectedPersonHistory = {
          removalHistory : data,
          fullname : person.fullname,
          age : person.age,
          gender : person.gender,
          cjamspid : person.cjamspid
        }
    });
  }

  getRemovalReasons(removalItem: any){
    if(removalItem?.removalreason) {
      return removalItem.removalreason;
    } else if (removalItem?.removalcircumstances) {
      let arr =  Object.entries(removalItem.removalcircumstances).map(([key, value]) => ({ key, value }));
      arr = arr.filter(item=>item.value);
      arr = arr.map((item:any)=> {
        const index = this.removalCircumstancesObj.findIndex((rObj: any)=> rObj.ref_key == item.key);
        if(index > -1) {
          item.key =  this.removalCircumstancesObj[index]['ref_key']
          item.description = this.removalCircumstancesObj[index]['description'];
        } else {
         item.description = "";
        }
        
         return item;
       })
      return arr;
    }

  }

  getRoleHistoryByPerson(person: any){
    this.selectedPersonHistory = {
      roleHistory : person.rolehistory ? person.rolehistory : [],
      fullname : person.fullname,
      age : person.age,
      gender : person.gender,
      cjamspid : person.cjamspid
    }
  }

  getPlacementHistoryByPerson(person: any){
    this._commonHttpService
    .getSingle(
      {
        where: { personid: person.personid},
        method: 'get'
      },

      'placement/getplacementbyperson?filter'
    ).subscribe(data => {
        this.placementHistory = data;
    });
  }

  toggleTable(id: any, index: any, placementrevison: any) {
    this.placementRevison = placementrevison;
    if(this.checkAccordionRow(id,'accordion-tables-placement')) {
      if (this.showHistoryDetail === index) {
        this.showHistoryDetail = null;
      } else {
        this.showHistoryDetail = index;
      }
    }
  }

  checkAccordionRow(id: string, value: any): boolean {
    return id.includes(value);
  }

  settimein12hr(strtime: any) {
    if (strtime && moment(new Date(strtime), 'HH:mm', true).isValid()) {
      return moment(new Date(strtime), 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm', true).isValid()) {
      return moment(strtime, 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm:ss', true).isValid()) {
      return moment(strtime, 'HH:mm:ss', true).toDate();
    }
  }

  newPersonCPSAssignment() {
    if (this.noActiveProgram === true) {
      const caseTypeValue =  this.caseType === 'CPS-AR' ? 'AR' : null;
      //D-21732: @Simar - Objecttypekey needs to be servicerequest to match conversion and application
      const model = {
        personid: this.personid,
        startdate: this.today,
        programkey: 'CPS',
        subprogramkey: this.caseType === 'CPS-IR' ? 'IR' : caseTypeValue,
        objecttypekey: 'servicerequest',
        objectid: this.id
      };

      

      this._commonHttpService
      .create(model,
          this.personprogramareasaddupdateurl
      )
      .subscribe(() => {
          this._alertService.success('Program assignment added successfully!');
          this.loadPage();
      });

    }
  }

  checkNewPersonCPS() {
    const newpersonid = this._personInfoService.getPersonId();

    if(newpersonid != null && newpersonid != this._dataStoreService.getData('NEW_PERSON_ASSIGNED') && this.cpsCaseTypes.includes(this.caseType)){
      const newperson: any = {}
      newperson['personid'] = newpersonid;
      this.getPersonData(newperson, 'CPS');
      this._personInfoService.resetPersonId();
    }

    this._dataStoreService.setData('NEW_PERSON_ASSIGNED', newpersonid);

  }

  getProgramAreaHistory(personprogramid: any, tableName: any, index: any) {
    this.programAreaHistoryData = [];
    this._commonHttpService.getArrayList(
      {
        where: {
          activeflag: '1',
          referenceid: personprogramid,
          logType: 'PRGMAREA'
        },
        method: 'get',
        nolimit: true
      },
      'auditlog/list?filter')
      .subscribe(
        (response) => {
          if(this.checkAccordionRow(tableName,'accordion-tables-program-area')) {
            if (this.showProgramAssignDetail === index) {
              this.showProgramAssignDetail = null;
            } else {
              this.showProgramAssignDetail = index;
            }
          }
          if (response.length > 0) {
            response.forEach((item: any) => {
              if(item.metadata){
                item.metadata.insertedon = item.insertedon;
                item.metadata.displayname = (item.description==='information')?item.displayname:'System';
                this.programAreaHistoryData.push(item.metadata);
              }
            });
          }
        }
      );

    $('.collapse.in').collapse('hide');
    $('#' + tableName).collapse('toggle');
  }

  addPerson(person: any) {
    person['roles']= [person.role];
    person['personRole']= [{
      roletype: person.role,
      isprimary: 1
    }];

    const intakenumber = this._dataStoreService.getData('intakenumber');
    const intakeserviceid = this._dataStoreService.getData('CPS_CASE_ID');
    const servicecasenumber = this._dataStoreService.getData('DANUMBER');
    let caseInfo = {};
    if(servicecasenumber && this.isServiceCase){
      person['objecttype']= this.servicecasetxt;
      person['objectid']= [servicecasenumber];
      caseInfo = {objectType : this.servicecasetxt, objectNumber: servicecasenumber};
    }
    else if(intakeserviceid){
      person['objecttype']= 'Case';
      person['objectid']= [intakeserviceid];
      caseInfo = {objectType : 'Case', objectNumber: intakenumber};
    }
    else if(intakenumber){
      person['objecttype']= 'Intake';
      person['objectid']= [intakenumber];
      caseInfo = {objectType : 'Intake', objectNumber: intakenumber};
    }

    const intakeData = { intakenumber, intakeserviceid }
    this._personInfoService.savePersonDetails(person, intakeData, caseInfo).subscribe(response => {
      if (response) {
        if (response.status !== 'Head of Household Person already added') {
          this.loadPersons();
          this._alertService.success(response.status);
          this.unkPersonFormGroup.controls['role'].reset();
          const savedPersonID = response.Personid;
          this._personInfoService.updatePersonId(savedPersonID);
          this._dataStoreService.setData(IntakeStoreConstants.PERSON_SEARCH_CASE, this.id);
          $('#intake-unkperson').modal('hide');
        } else {
          this._alertService.error(response.status);
        }
        this._alertService.success(response.status);
      }
    },
      (_error: any) => {
      }
    );
  }

  disableAddUnkw(role: any,reviewstatus: any){
    if(role==='Intake Worker' && reviewstatus === 'Approved'){
      return true;
    }else if (role==='apcs'){
      if(reviewstatus === 'Review' || reviewstatus === 'Reopen' || reviewstatus === 'Accepted' || reviewstatus === 'Closed' || reviewstatus === 'Approved'){
        return true;
      }else{
        return false;}
    }
    return false;
  }

  isCareGiver(roleList: any) {
    if (roleList) {
      const roleDtl = roleList.filter((f: { intakeservicerequestpersontypekey: string; }) => f.intakeservicerequestpersontypekey === 'ICC');
      return  roleDtl.length > 0 ? true : false;
    }
    return false;
  }
  kinshipChecklistCompleted() : void {
    if(this.isAttemptedOrCompletedContactNote && this.servicelogcompleted){
      this.isKinshipChecklistCompleted = true;
    } else {
      this.isKinshipChecklistCompleted = false;
    }
  }
  formatPhoneNumber(phoneNumber: string) {
    return this._commonDropdownService.formatPhoneNumber(phoneNumber);
  }

  pregnants: any[] = [];
  pregnantsids: any[] = [];
  pregnantspopupid = '#pregnants-popup';
  getpregnants(pids: any) {
      this.pregnants = [];
      this.pregnantsids = [];
      this._commonHttpService
          .getPagedArrayList(
              new PaginationRequest({
                  page: 1,
                  limit: 50,
                  nolimit: true,
                  method: 'get',
            where: { v_pids: pids }
          }),
          'personsexualinfo/getpregnants?filter'
        ).subscribe((res: any) => {
            if(res && res[0]?.getpregnants?.length > 0) {
              res[0]?.getpregnants?.forEach((e: { pregnant: any; }) => {
                const p = e?.pregnant;
                const pid = p?.substring(p?.indexOf(':')+1, p?.indexOf(')'));
                  if(!this?.pregnants?.includes(pid)) {
                      this?.pregnantsids?.push(pid);
                      this?.pregnants?.push(p);
                  } 
              });              
            }
        });
    } 

    pregnant: any;
    showPregnantsPopup(pid: any){
      if(this.pregnants && this.pregnants?.length > 0) {
        this.pregnant = this?.pregnants?.filter(p => p.includes(pid));
        ($(this.pregnantspopupid)).modal('show');
      }
    }

    closePregnantsPopup(){
      ($(this.pregnantspopupid)).modal('hide');
    }
      ytpActiveChildRemovalCheck() {
    this.ytpProgramAreaStatus = {};
    this.involevedPerson.filter((item: any) => {
      if(this.calculateAge(item.dob) > 13) {
        const programAssignments = this.getProgramAssignments(item.personid);
        programAssignments.subscribe({
          next: (res: any) => {
            if (res && Array.isArray(res) && res.length > 0) {

              const checkActiveProgramAreas: any = res
                                  .flatMap(item => Array.isArray(item?.personprogramarea) ? item.personprogramarea : [])
                                  .filter(area => area?.programkey === 'OOH' && area?.enddate === null && this.caseNo === area?.casenumber);

              if(checkActiveProgramAreas && checkActiveProgramAreas.length > 0){
                this.ytpProgramAreaStatus[item.personid] = true;
              }
            }
          },
          error: (_err: any) => {
            console.error('Error occurred:', _err);
          },
          complete: () => {
            console.log('Observable completed');
          }
        })
      }
    });
  }

  calculateAge(dob: string): number {
    return moment().diff(moment(dob, 'YYYY-MM-DD'), 'years');
  }  
 
  //Function to check for active program assignments for each person
  getProgramAssignments(personID: string) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { objectid: this.id, personid: personID },
          method: 'get',
          nolimit: true
        }),
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GetPersonProgramArea}?filter`
      )
  }
  
  // Dynamically fetching Motivation Interview options based on County go live data
  getMotivationInterviewActivecounty(): Observable<any> {
    return this._commonHttpService.getArrayList(
      {
        where: { objecttype: 'motivational-interview' },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.getcountygoliveconfig + '?filter'
    ).pipe(
      tap(response => {
        this.motivationActiveCounty = response[0];
        
        if (this.motivationActiveCounty?.statewide) {
          const statewidedate = this.motivationActiveCounty?.statewide;
          if (moment(statewidedate).isSameOrBefore(moment(new Date()).format('MM/DD/YYYY'))) {
            this.showMotivationalInterviewOptions = true;
          }
        } else if (this.motivationActiveCounty) {
          let countylivedate = this.motivationActiveCounty[`${this.familyWorkerCounty?.replace(/[.\s']/g, '').toLowerCase()}`];
          if (countylivedate) {
            if (moment(countylivedate).isSameOrBefore(moment(new Date()).format('MM/DD/YYYY'))) {
              this.showMotivationalInterviewOptions = true;
            }
          }
        }
      })
    );
  }
}
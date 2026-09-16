import { Component, EventEmitter, Injector, Input, OnInit, Output, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialog} from '@angular/material/dialog';
import {MatStepper} from '@angular/material/stepper';
import moment from 'moment';
import _, { AnyKindOfDictionary } from 'lodash';
import { FileUtils } from '../../../../@core/common/file-utils';
import { AlertService, CommonHttpService, DataStoreService, AuthService} from '../../../../@core/services';
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';
import { PaginationRequest, DropdownModel } from '../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';
import { NavigationUtils } from '../../../_utils/navigation-utils.service';
import { AppConstants } from '../../../../@core/common/constants';
import { MatDatepicker } from '@angular/material/datepicker';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'eligible-worksheet-form',
    templateUrl: './eligible-worksheet-form.component.html',
    styleUrls: ['./eligible-worksheet-form.component.scss'],
    standalone: false
})
export class EligibleWorksheetFormComponent implements OnInit {

  @ViewChild('stepper') stepper!: MatStepper;
  isStart = false;
  dataSource!:any;
  displayedColumns: string[] =
    ['placementlivingtype', 'type', 'samelivingarrplacement', 'placementreimbursible', 'lapses',
    'lapsetype', 'startdt', 'provider', 'provideraddress', 'enddt'];

  placementList:any[] = [];
  pageSize=1;
  tempList:any[]=[];
  client_id = '1008560';
  selectedPeriodItems: any;
  periodTable: any[]=[];
  hearingTypeListdropdown: any[]=[];
  clientId!: number;
  removalId!: number;
  periodSqnm!: string;
  placementId!: number;
  periodType!: string;
  startdatefordetermination: any;
  enddatefordetermination: any;
  showonly18Bday = false;
  initialstartdate: any;
  personsList: any = {};
  selectedDetCount = 0;
  subsequent = true;
  fromIVtab = true;
  selectedComponent!: string;
  componentsList: string[] = ['legal', 'afdcRelatedness', 'placement', 'otherCriteria'];
  selectPeriodItem: any;
  msg :string[]= [];
  errorMessage :string[] =  [];
  deprivationAbsenceInAUPersons = [];
  incompleteincomepersons:any =  [];
  incompleteInAuPersons: any;
  incompleteassetpersons: any;
  showMissingIncomeInfo!: boolean;
  showMissingAssetsInfo!: boolean;
  showMissingInAU!: boolean;
  checkCTWDecision!:any;
  childCost!: string;
  specifiedRelativeRelationShips :any= {
    1001: 'Brother/Sister',
    1002: 'Nephew/Nieces',
    1003: 'Grand Nephew/Nieces',
    1004: 'Great-Grand Nephew/Nieces',
    1005: 'Grand Parents',
    1006: 'Uncles Aunts',
    1007: 'First Cousins',
    1008: 'First Cousins once removed',
    1009: 'Great-Grand Parents',
    1010: 'Great-Uncles Aunts',
    1011: 'Great-Great Grand Parents',
    1012: 'Great-Grand Uncles Aunts',
    1013: 'God Child',
    1014: 'Other',
    1015: 'Non-Relative',
  };

  @Input() summaryInfo: any;
  @Input() worksheetData: any;
  @Input() worksheetForm!: FormGroup;
  @Input() legalStatusForm!: FormGroup;
  @Input() afdcForm!: FormGroup;
  @Output() submitForReview: EventEmitter<any> = new EventEmitter();
  @Output() incomeSummaryData: EventEmitter<any> = new EventEmitter();
  @Input() generalForm!: FormGroup;
  @Input() legalForm!: FormGroup;
  @Input() incomeForm!: FormGroup;
  @Input() criteriaForm!: FormGroup;
  @Input() tempRows1: any;

  personrelationlist: any;
  educationlist: any;
  employementlist: any;
  employementbarrierlist: any;
  narrativeuniqueInfo: any;
  disabilityList: any;
  disabilityfilterlist:any = [];
  educationfilterlist :any= [];
  educationEligiblityList:any[] = [];
  isEduEligible = false;
  isEmpEligible = false;
  isEmpBarEligible = false;
  isdisabilityEligible = false;
  personsDropdown:any[] = [];
  personSubjectCtw :any[]= [];
  personSubjectOthersCtw:any[] = [];
  personSubjectDeprivation :any[]= [];
  disabilityEligiblityList :any[]= [];
  employementEligibiltyList:any = [];
  employementBarrierEligibiltyList:any = [];
  firstGenList :any[]= [];
  deprivationData :any= [];
  householdData :any= [];
  ageforoutputform: any;
  controlarry :any= [];
  controlDevarry :any[]= [];
  controlRel:any = [];
  selectedHouseHold: any;
  scheduleHLookUp: any;
  scheduleHLookUpForNotInAU: any;
  ageofthechildvalue: any;
  show18to21section!: boolean;
  annual21Bday = false;
  educationstartdtcheck = false;
  employementstartdtcheck = false;
  employmentbarrierstdtcheck = false;
  disabilitystartdtcheck = false;
  childPersonId: any;
  casnumber: any;
  legalGroup!: FormGroup;
  afdc!: FormGroup;
  placement!: FormGroup;
  atleastOnesilaplacement = false;
  other!: FormGroup;
  isMessageShow = false;
  disablesave = false;
  ctwdropdown!: DropdownModel[];
  reasonableeffortsdropdown!: DropdownModel[];
  jdrefppdropdown!: DropdownModel[];
  vpabestinterestdropdown!: DropdownModel[];
  reasonableeffortsmade : any;
  reasonableeffortsnotnecessaryduetoemergentcircumstances : any;
  shownotinau= false;
  typeofcourthearing: any;
  initialeligiblestatus: string = '';
  isreadonly = false;
  displayValidationMessages = false;
  voluntaryplacementagreement = 'Voluntary Placement Agreement';
  validationmsg = 'Please fill required fields';
  dtformat = 'MM/DD/YYYY';
  pleaseselecterrmsg = 'Please select ';
  silaHomesText = 'SILA home/Apartment';
  invalidDate = 'Invalid date';

  private readonly route: ActivatedRoute;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _alertService: AlertService;
  private readonly _dataStoreService: DataStoreService;
  private readonly _formBuilder: FormBuilder;
  public _authService: AuthService;
  
  constructor(private injector: Injector,
    private readonly _navigationUtils: NavigationUtils,
    public dialog: MatDialog) {
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._authService = this.injector.get<AuthService>(AuthService);
  }

  ngOnInit() {          
    this.dataSource = [];
    this.clientId = this.route.snapshot.params['clientId'];
    this.removalId = this.route.snapshot.params['removalId'];
    this.placementId = this.route.snapshot.params['placementId'];
    if (this.summaryInfo) {
          this.childPersonId = this.summaryInfo.personid;
    }
    this.getInvolvedPersonWithPersonID();
    this.getPersonsList();
    this.getEligibilityData();
    this.gethearingdetails();
    this.buildFormGroup();
    this._dataStoreService.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
    this.legalGroup.get('dateoffindingctwdecision')?.valueChanges.subscribe(result => {
      if(result) {
      this.getLegalInfo(result,'CTW');
      }
    });
    this.legalGroup.get('dateofreasonableeffortscourthearing')?.valueChanges.subscribe(result => {
      if(result) {
      this.getLegalInfo(result,'RPR');
      }
    });
    this.legalGroup.get('dateofjudicialfindingofrefpp')?.valueChanges.subscribe(result => {
      if(result) {
      this.getLegalInfo(result,'JD');
      }
    });
    this.legalGroup.get('dateofcurrentjudicialfindingofbestinterest')?.valueChanges.subscribe(result => {
      if(result) {
      this.getLegalInfo(result,'VPA');
      }
    });
    this.isTabSwitched();
    this._authService.readonlyPage('read_only_access','',
    [this.placement,this.afdc,this.legalGroup,this.other]);
  }

  isTabSwitched(){
    $('.intake-tabs a').on('shown.bs.tab', (event :any) => {
      const x = $(event.target).text();
      if(x.includes("DETAILS")){
        this.getEligibilityData();
      }
    });
  }

  selectionChange(event:any){
    this._dataStoreService.setData("FosterCare_Selected_Component",(event.selectedIndex + 1 ));
  }

  /* D-22152 Default deprivation factor to None*/
  deprivationfactorchange(event:any, i:any) {
      if (event.value === 'NO') {
         const controlArry = this.afdc.controls.delist as FormArray;
         const controlArry1 = controlArry.controls[i] as FormGroup;
         controlArry1?.controls['deprivationfactor']?.setValue('NONE');
         controlArry1?.controls['reasonforabsence']?.setValue(null);
      }
  }

  inAUdropdownchange(event:any, i:any) {
    var controlArryDelist = <FormArray>this.afdc.controls.delist;
    var controlArryHousehold = <FormArray>this.afdc.controls.household;
    
    var currentInAUParentId = controlArryHousehold.controls[i].get('involvedclientid')?.value;
    this.deprivationAbsenceInAUPersons = [];

    //If the 'In AU' dropdown is being set to 'YES'
    if (event.value == 'YES' && controlArryDelist && currentInAUParentId) {
      //The parent is being identified as 'In AU'
      //check if the deprivation factor of that parent is 'Absence'
      controlArryDelist.value.forEach((item:any) => {
          if(item && item.deprivationParentId == currentInAUParentId
            && item.deprivationfactor == "AB") {
            //Use this one for pop-up alert
            $('#iframe-deprivation-absence-inau').modal('show');
          }
      });
    }

  }

  deprivationdropdownchange(event:any, i:any) {
      var controlArryDelist = <FormArray>this.afdc.controls.delist;
      var controlArryHousehold = <FormArray>this.afdc.controls.household;

      var currentDeprivationParentId = controlArryDelist.controls[i].get('deprivationParentId')?.value;
      this.deprivationAbsenceInAUPersons = [];

      if (event.value !== 'AB') {
          const controlArry = this.afdc.controls.delist as FormArray;
          const controlArry1 = controlArry.controls[i] as FormGroup;
          controlArry1?.controls['reasonforabsence']?.setValue(null);
      }
      
      if (event.value == 'AB' && controlArryHousehold && currentDeprivationParentId) {
        //The deprivation factor is being marked as Absence
        //check if that person is identified as 'In AU'
        controlArryHousehold.value.forEach((item:any) => {
            if(item && item.involvedclientid == currentDeprivationParentId
              && item.assistanceunit == "YES") {
              //Use it if we need red banner alert
              // this._alertService.error('Deprivation factor Abcense parent cannot be in AU');

              //Use this one for pop-up alert
              $('#iframe-deprivation-absence-inau').modal('show');
            }
        });
      }
  }

  clickMatStepper(index: number, stepper: MatStepper) {
    stepper.selectedIndex = index ? (index - 1) : index;
  }


  buildFormGroup() {
    this.legalGroup = this._formBuilder.group({
      issafehavenbaby : [{ value: '', disabled: true }],
      typeofremoval : [{ value: '', disabled: true }],
      typeofremovaldescription : [{ value: '', disabled: true }],
      typeofvpa : [{ value: '', disabled: true }],
      childphysicalremovaldate : [{ value: '', disabled: true }],
      clientnameofpersonfromwhomchildwasphysicallyremoved : [{ value: '', disabled: true }],
      clientidofpersonfromwhomchildwasphysicallyremoved : [{ value: '', disabled: true }],
      childphysicaladdressafterremoval : [{ value: '', disabled: true }],
      relationshipofpersonfromwhomchildwasphysicallyremoved : [{ value: '', disabled: true }],
      relationshipidofpersonfromwhomchildwasphysicallyremoved : [{ value: '', disabled: true }],
      intakeservreqcourtorderid : [{ value: '', disabled: true }],
      courtinfotable: [{ value: '', disabled: true }],
      dateofcourthearing : [{ value: null, disabled: true }],
      magistrateorjudgename : [{ value: '', disabled: true }],
      issignedbyjudge : [{ value: '', disabled: true }],
      ctwdecision : [{ value: '', disabled: false }],
      dateoffindingctwdecision : [{ value: '', disabled: false }],
      dateofnexthearing : [{ value: null, disabled: true }],
      isiveagencyresponsibleforplacementandcare : [{ value: '', disabled: false }, Validators.required],
      nameofsubjectctwfinding : [{ value: '', disabled: true }],
      clientidofsubjectctwfinding : [{ value: '', disabled: true }],
      relationshipofsubjectctwfinding : [{ value: '', disabled: true }],
      NameOfSubjectOfCTWFindingGroup : [''],
      courtorderdelayremoval : [{ value: '', disabled: true }],
      courtorderdelaytimedays : [{ value: '', disabled: true }],
      dateagencylostlegalresponsibility : [{ value: '', disabled: false }],
      typeofcourthearing : [{ value: '', disabled: false }],
      reasonableeffortsmade : [{ value: '', disabled: true }],
      dateofreasonableeffortscourthearing : [{ value: '', disabled: false }],
      reasonableeffortsnotnecessaryduetoemergentcircumstances : [{ value: '', disabled: true }],
      fostercarepermanencyplan : [{ value: '', disabled: true }],
      fostercarepermanencyplandesc : [{ value: '', disabled: true }],
      dateofjudicialfindingofrefpp : [{ value: '', disabled: false }],
      dateofcurrentjudicialfindingofrefpp : [{ value: '', disabled: true }],
      dateofsubsequentjudicialfindingofrefpp : [{ value: '', disabled: true }],
      dateofpreviousjudicialfindingofrefpp : [{ value: '', disabled: true }],
      dateofsubsequentfindingofbestinterest : [{ value: '', disabled: true }],
      dateofcurrentjudicialfindingofbestinterest : [{ value: '', disabled: false }],
      dateofpreviousbestinterestfinding : [{ value: '', disabled: true }],
      clientnamewhosignedvpa : [{ value: '', disabled: true }],
      dateof1stparentsignatureonvpa : [{ value: '', disabled: true }],
      dateof2ndparentsignatureonvpa : [{ value: '', disabled: true }],
      dateofguardiansignatureonvpa : [{ value: '', disabled: true }],
      dateofldsssignatureonvpa : [{ value: '', disabled: true }],
      mandatorynoteonmissing2ndparentsignatureonvpa : [{ value: '', disabled: true }],
      dateofyouthsignatureonvpa : [{ value: '', disabled: true }],
      previousfostercareepisodeexist : [{ value: '', disabled: true }],
      exitcaredatefrompreviousfostercareepisode : [{ value: '', disabled: true }],
      reasonforexit : [{ value: '', disabled: true }]

    });
    this.afdc = this._formBuilder.group({
       dateofbirth : [{ value: '', disabled: true }],
       ageofthechild : [{ value: '', disabled: true }],
       uscitizen : [{ value: '', disabled: true }],
       qualifiedalien : [{ value: '', disabled: true }],
       qualifiedalienstaus : [{ value: '', disabled: true }],
       alienregistrationnumber : [{ value: '', disabled: true }],
       household: this._formBuilder.array([]),
       delist: this._formBuilder.array([]),
       specifiedRelativesList: this._formBuilder.array([]),
       costChild : [''],
       afdceligibilitymonth: [{ value: null}, Validators.required],
    });
    this.placement = this._formBuilder.group({
      childbeeninfostercare12monthormore: [{ value: '', disabled: true }],
      isreasonableeffortsfindingtimely: [{ value: '', disabled: true }],
      IsThereAnyReasonableEffortsFindingDuringReviewPeriod: [{ value: '', disabled: true }],
      islapsesinplacement : [null, Validators.required],
      typeoflapses : [null, Validators.required],
      kindoflapses : [null, Validators.required]
    });
    this.other = this._formBuilder.group({
      nameofsecondaryeducationorequivalentprogram: [{ value: '', disabled: true }],
      startdateofsecondaryeducationorequivalentprogram: [{ value: '', disabled: true }],
      nameofpostsecondaryorvocationaleducation: [{ value: '', disabled: true }],
      startdateofpostsecondaryorvocationaleducation: [{ value: '', disabled: true }],
      nameofpromotetoemploymentprogram: [{ value: '', disabled: true }],
      startdateofpromotetoemploymentprogram: [{ value: '', disabled: true }],
      nameofemployer: [{ value: '', disabled: true }],
      startdateofemployment: [{ value: '', disabled: true }],
      hourspermonthemployed: [{ value: '', disabled: true }],
      childdisabilitytype: [{ value: '', disabled: true }],
      childdisabilitystartdate: [{ value: '', disabled: true }],
      childdisabilityevaluationdocumentiondate: [{ value: '', disabled: true }],
      childreceivingssiorssa: [null],
      typeofbenefit: [''],
      amountofbenefit: [null],
      ischildageabove18: [null],
      agencyrepresentativeflag: [null],
      whoisrepresentativepayee: [''],
      reasonforagencynotrepresentativepayee: [''],
      dateofmedicaldetermination: [''],
      hasagencyapplytobecomerepresentativepayee: [null],
      dateofapplicationtobecomerepresentativepayee: [''],
      suspendssipaymentflag: [null],
      reasonfornotsuspendingssipayment: [''],
      doesagencyhasmedicaldocstostateincapabilityofchild : [null],
      dateofrequesttosuspendthessipaymentandclaimive: [''],
      infoaboutincomenresources: ['', Validators.required],
      incomeresourcesverification: ['', Validators.required],
      isSilaAgreementValid: [null],
      silaAgreementDate: [null , Validators.required],
      citizenshipverification: [null , Validators.required],
      ageverification: [null , Validators.required],
      assetinfoverification: [null , Validators.required],
      vpasprverification: [null , Validators.required],
      ssissainfoverification: [null , Validators.required],
      homeassessmentverification: [null, Validators.required],
      isSilaYouth:[null]
    });
  }

  // tslint:disable-next-line: use-life-cycle-interface
  ngAfterViewInit() {
    if (this.stepper) {
     this.stepper._getIndicatorType = () => 'number';
    }
  }

  ngOnDestroy() {
    this._dataStoreService.setData("fostercarecasedetails", null);
  }

  getPersonVal(clientId:number) {
    if (_.has(this, `personsList.${clientId}`)) {
      return {
        value: this.personsList[clientId].value,
        label: this.personsList[clientId].label,
      }
    } else {
      return { value: '', label: '' };
    }
  }

  getPersonLabel(clientId: number){
    return _.get(this.personsList, `${clientId}.label`);
  }

  getPersonNameD(clientId: number){
    return _.get(this.personsList, `${clientId}.name`);
  }
  get4eRelationId(clientId: number): number {
    return _.get(this.personsList, `${clientId}.fourerelid`);
  }

  getRelationVal(id:any) {
    if (_.has(this, `specifiedRelativeRelationShips.${id}`)) {
      return {
        value: id,
        label: this.specifiedRelativeRelationShips[id],
      }
    } else {
      return { value: '', label: '' };
    }
  }

  startForm(periodData: any) {
    this.isStart = true;
    if (this.stepper) {
      this.stepper._getIndicatorType = () => 'number';
    }
    const worksheetData = this.worksheetData;
    if (worksheetData && worksheetData.data) {
      this.checkWorksheetDataFn(worksheetData);
    }
    this.personlistFilteringFn();

    const deprivationInfo = _.get(worksheetData, 'deprivationInfo');
    const controlArry = <FormArray>this.afdc.controls.delist;
    while (this.controlDevarry.length > 0) {
      this.controlDevarry.pop();
      controlArry.removeAt(this.controlDevarry.length - 1);
    }
    // controlDevarry
    if (deprivationInfo && _.isArray(deprivationInfo)) {
      deprivationInfo.forEach((element:any) => {
        controlArry.push(this._formBuilder.group({
          deprivationParentId: [this.getPersonVal(element.parentid).value],
          childdeprivedofparentalsupport: [element.childdeprivedofparentalsupport],
          reasonforabsence: [element.reasonforabsence],
          deprivationfactor: [element.deprivationtype],
          dateofparentdeath: [element.dateofparentdeath],
          incarcerationdate: [element.dateofincarceration],
          unemploymentorunderemployment: [element.isunemployment],
          ivepersondeprivationid: [element.ivepersondeprivationid],
          activeFlag: [1]
        })
        );
        this.controlDevarry.push('1');
      });
    }
    const householdInfo = _.get(worksheetData, 'householdInfo');
    // House hold info
    const control = <FormArray>this.afdc.controls.household;
    while (this.controlarry.length > 0) {
      this.controlarry.pop();
      control.removeAt(this.controlarry.length - 1);
    }
    if (householdInfo && _.isArray(householdInfo) && _.isArray(householdInfo[0].getfinanceincomebycase)) {
      this.checkHouseholdInfoFn(householdInfo, control);
    }
    const specifiedRelativeInfo = _.get(worksheetData, 'specifiedRelativeInfo');
    // Specified Relatives
    const controlArryRel = <FormArray>this.afdc.controls.specifiedRelativesList;
    while (this.controlRel.length > 0) {
      this.controlRel.pop();
      controlArryRel.removeAt(this.controlRel.length - 1);
    }
    this.specifiedRelativeInfoFn(specifiedRelativeInfo, controlArryRel);
  }
  // Associated with startForm function
  private specifiedRelativeInfoFn(specifiedRelativeInfo: any, controlArryRel: FormArray) {
    if (specifiedRelativeInfo && _.isArray(specifiedRelativeInfo)) {
      specifiedRelativeInfo.forEach((element:any) => {
        controlArryRel.push(this._formBuilder.group({
          sepecifiedrelativeuniqid: element.specifiedrelativeid,
          specifiedrelativename: this.getPersonVal(element.specifiedrelativeclientid).value,
          specifiedrelativerelationshipid: this.get4eRelationId(element.specifiedrelativeclientid),
          specifiedrelativephysicaladdress: element.specifiedrelativephysicaladdress,
          specifiedrelativedatechildlastlivedwith: element.specifiedrelativedatechildlastlivedwith,
          activeFlag: [1]
        })
        );
        this.controlRel.push('1');
      });
    }
  }
  // Associated with startForm function
  private checkHouseholdInfoFn(householdInfo: any[], control: FormArray) {
    householdInfo[0].getfinanceincomebycase.forEach((hh:any) => {
      control.push(this._formBuilder.group({
        name: [this.getPersonName(hh) + ' - ' + hh.cjamspid],
        id: [hh.personid],
        ivepersonincomeid: [hh.iveincomesumary ? hh.iveincomesumary.ivepersonincomeid : ''],
        involvedclientid: [hh.cjamspid],
        assistanceunit: [hh.iveincomesumary ? hh.iveincomesumary.assistanceunit : ''],
        deemedincome: [hh.iveincomesumary ? hh.iveincomesumary.deemedincome === 'YES' : false],
        disregardearnedincome: [hh.iveincomesumary ? hh.iveincomesumary.disregardearnedincome === 'YES' : false],
        income: [hh.getfinanceincome ? hh.getfinanceincome : []],
        caseid: hh.servicecaseid,
        casenumber: hh.servicecasenumber,
        assets: [hh.getfinanceassets ? hh.getfinanceassets : []],
      })
      );
      this.controlarry.push('1');
    });
    this.showScheduleH();
  }
  // Associated with startForm function
  private personlistFilteringFn() {
    this.personsDropdown = [];
    this.personSubjectCtw = [];
    this.personSubjectOthersCtw = [];
    _.forIn(this.personsList, (person) => {
      this.personsDropdown.push({
        value: person.value,
        label: person.label
      });
    });
    _.forIn(this.personsList, (person) => {
      if (((!person.relationship.some((relation:any) => relation === 'Child')) || (this.worksheetData.data.typeofvpa === 'EA-VPA')) || (person.relationship.some((relation:any) => relation === 'Child') && person.relationship.some((relation:any) => relation === 'Parent'))) {
        this.personSubjectCtw.push({
          value: person.value,
          label: person.label
        });
      }
    });
    _.forIn(this.personsList, (person) => {
      if ((!person.relationship.some((relation:any) => relation === 'Child')) || (person.relationship.some((relation:any) => relation === 'Child') && person.relationship.some((relation:any) => relation === 'Parent'))) {
        this.personSubjectOthersCtw.push({
          value: person.value,
          label: person.label
        });
      }
    });
    //D-23536 Parent drop down should list only biological and adoptive parents
    _.forIn(this.personsList, (person) => {
      if (person.relationcheck === 'Adoptive Father' || person.relationcheck === 'Adoptive Mother' || person.relationcheck === 'Biological Father'
        || person.relationcheck === 'Biological Mother' || person.relationcheck === 'Adoptive Parent') {
        this.personSubjectDeprivation.push({
          value: person.value,
          label: person.label
        });
        this.personSubjectDeprivation = this.personSubjectDeprivation.filter(((set:any) => (checkvalue:any) => !set.has(checkvalue.value) && set.add(checkvalue.value))(new Set));
      }
    });
  }
  // Associated with startForm function
  private checkWorksheetDataFn(worksheetData: any) {
    if (worksheetData.data.ctwjson) {
      this.ctwdropdown = worksheetData.data.ctwjson.map(
        (res :any) => new DropdownModel({
          text: res.dateoffindingctwdecision,
          value: res.intakeservreqcourtorderid
        })
      );
    }
    if (worksheetData.data.reasonableeffortsjson) {
      this.reasonableeffortsdropdown = worksheetData.data.reasonableeffortsjson.map(
        (res :any) => new DropdownModel({
          text: res.dateofreasonableeffortscourthearing,
          value: res.intakeservreqcourtorderid
        })
      );
    }
    if (worksheetData.data.jdrefppjson) {
      this.jdrefppdropdown = worksheetData.data.jdrefppjson.map(
        (res :any)=> new DropdownModel({
          text: res.dateofjudicialfindingofrefpp,
          value: res.intakeservreqcourtorderid
        })
      );
    }
    if (worksheetData.data.vpabestinterestjson) {
      this.vpabestinterestdropdown = worksheetData.data.vpabestinterestjson.map(
        (res :any) => new DropdownModel({
          text: res.dateofcurrentjudicialfindingofbestinterest,
          value: res.intakeservreqcourtorderid
        })
      );
    }
    if (worksheetData.removalInfo && worksheetData.removalInfo.length > 0) {
      this.legalGroup.patchValue(worksheetData.removalInfo[0]);
    }
    const typeofcourthearingvalue = worksheetData.data.typeofcourthearing;
    this.legalGroup.patchValue({ isiveagencyresponsibleforplacementandcare: worksheetData.data.isiveagencyresponsibleforplacementandcare });
    this.legalGroup.patchValue({ dateagencylostlegalresponsibility: worksheetData.data.dateagencylostlegalresponsibility });
    this.typeofcourthearing = (typeofcourthearingvalue && typeofcourthearingvalue.length) ? typeofcourthearingvalue.split(',') : [];
    this.legalGroup.patchValue({ typeofcourthearing: this.typeofcourthearing });
    this.placement.patchValue({ childbeeninfostercare12monthormore: worksheetData.data.periodsInfo.hasthechildbeeninfostercarefor12monthsormore });
    this.afdc.patchValue(worksheetData.data);
    this.afdc.patchValue({ costChild: worksheetData.data.childcarecost });
    this.afdc.patchValue({ ageofthechild: moment().diff(worksheetData.data.dateofbirth, 'years') });
    this.ageofthechildvalue = moment().diff(worksheetData.data.dateofbirth, 'years');

    if (worksheetData.placementInfo && worksheetData.placementInfo.islapsesinplacement === 'YES' && worksheetData.placementInfo.typeoflapses === 'Permanent') {
      this.legalGroup.patchValue({ isiveagencyresponsibleforplacementandcare: 'NO' });
    }

    if (worksheetData.ssissaCriteriaInfo && worksheetData.ssissaCriteriaInfo.length > 0) {
      this.other.patchValue({ reasonfornotsuspendingssipayment: worksheetData.ssissaCriteriaInfo[0].notefornotsuspendingssi });
      this.other.patchValue({ reasonforagencynotrepresentativepayee: worksheetData.ssissaCriteriaInfo[0].noteforagencynotaspayee });
      this.other.patchValue({ whoisrepresentativepayee: worksheetData.ssissaCriteriaInfo[0].representativepayee });
      this.other.patchValue({ incomeresourcesverification: worksheetData.ssissaCriteriaInfo[0].incomeresourcesverification });
      this.other.patchValue({ isSilaAgreementValid: worksheetData.ssissaCriteriaInfo[0].issillaagreementvalid });
      this.other.patchValue({ silaAgreementDate: worksheetData.ssissaCriteriaInfo[0].silaagreementdate });
      this.other.patchValue({ isSilaYouth: worksheetData.ssissaCriteriaInfo[0].issilayouth });

    }

    /* D-21365 Checking the Age of the child at comparing start date and end date of determination */
    this.checkPeriodTypeFn();

    this.populatePlacementInfo(worksheetData);
    this.populateOtherCriteria(worksheetData);
    this.legalGroup.patchValue({ NameOfSubjectOfCTWFindingGroup: worksheetData.data.clientidofsubjectctwfinding });
    this.legalGroup.patchValue({ dateoffindingctwdecision: worksheetData.data.ctwcourtorderid });
    this.legalGroup.patchValue({ dateofreasonableeffortscourthearing: worksheetData.data.reasonablecourtorderid });
    this.legalGroup.patchValue({ ctwdecision: worksheetData.data.ctwdecision });
    this.checkCTWDecision = worksheetData.data.ctwdecision ? worksheetData.data.ctwdecision : null;

    this.checkTypeofremovalFn(worksheetData);
  }
  // Associated with checkWorksheetDataFn function
  private checkTypeofremovalFn(worksheetData: any) {
    if (this.worksheetData.data.typeofremoval === 'Court_Order'
      || (this.worksheetData.data.typeofremoval === 'Voluntary_Placement_Agreement' && this.worksheetData.data.typeofvpa === 'Time-Limited')) {
      if (this.selectPeriodItem.sqnm_sw !== 'I' && worksheetData.data.redetcourtorderid === null) {
        this.getLegalInfo(null, 'JD');
      }
      if (this.selectPeriodItem.sqnm_sw !== 'I' && worksheetData.data.ctwcourtorderid !== null) {
        this.getLegalInfo(this.worksheetData.data.ctwcourtorderid, 'CTW');
      }
      this.legalGroup.patchValue({ dateofjudicialfindingofrefpp: worksheetData.data.redetcourtorderid });
    }
    if (this.worksheetData.data.typeofremoval === 'Voluntary_Placement_Agreement'
      && (this.worksheetData.data.typeofvpa === 'EA-VPA' || this.worksheetData.data.typeofvpa === 'Child with Disabilities')) {
      if (this.selectPeriodItem.sqnm_sw !== 'I' && worksheetData.data.redetcourtorderid === null) {
        this.getLegalInfo(null, 'VPA');
      }
      this.legalGroup.patchValue({ dateofcurrentjudicialfindingofbestinterest: worksheetData.data.redetcourtorderid });
    }
  }
  // Associated with checkWorksheetDataFn function
  private checkPeriodTypeFn() {
    if (this.periodType === 'RD') {

      const startdatefordeterminationformat = moment(this.startdatefordetermination);
      const enddatefordeterminationformat = moment(this.enddatefordetermination);
      const childdob = moment(this.worksheetData.data.dateofbirth);

      const ageofthechildafterattimeofstartdate = startdatefordeterminationformat.diff(childdob, 'years');
      const ageofthechildafterbeforetimeofenddate = enddatefordeterminationformat.diff(childdob, 'years');

      this.checkAfterBeforeTimeFn(ageofthechildafterattimeofstartdate, ageofthechildafterbeforetimeofenddate);
    } else if (this.periodType === 'ID') {
      this.ifPeriodTypeIDFn();
    } else {
      if (this.ageofthechildvalue >= '18' && this.ageofthechildvalue <= '21') {
        this.show18to21section = true;
      } else {
        this.show18to21section = false;
      }
    }
  }
  // Associated with checkPeriodTypeFn function
  private checkAfterBeforeTimeFn(ageofthechildafterattimeofstartdate: number, ageofthechildafterbeforetimeofenddate: number) {
    if ((ageofthechildafterattimeofstartdate >= 18 && ageofthechildafterattimeofstartdate <= 21)
      || (ageofthechildafterbeforetimeofenddate >= 18 && ageofthechildafterbeforetimeofenddate <= 21)) {
      this.show18to21section = true;
      // To get education details
      this.getEducation(this.childPersonId);
      this.getworkDetails(this.childPersonId);
      this.getEmploymentBarrierDetails(this.childPersonId);
      this.getDisabilityList(this.childPersonId);
      if (ageofthechildafterattimeofstartdate === 21 || ageofthechildafterbeforetimeofenddate === 21) {
        this.annual21Bday = true;
      } else {
        this.annual21Bday = false;
      }
    } else {
      this.show18to21section = false;
      this.annual21Bday = false;
    }
  }
  // Associated with checkPeriodTypeFn function
  private ifPeriodTypeIDFn() {
    if (this.worksheetData && this.worksheetData.data.typeofvpa === 'EA-VPA') {
      this.show18to21section = true;
      // To get education details
      this.getEducation(this.childPersonId);
      this.getworkDetails(this.childPersonId);
      this.getEmploymentBarrierDetails(this.childPersonId);
      this.getDisabilityList(this.childPersonId);
    } else {
      this.show18to21section = false;
    }
  }

  handleWorkSheetData(worksheetData:any) {
    if(worksheetData.data.ctwjson) {
      this.ctwdropdown = worksheetData.data.ctwjson.map(
        (resp :any) =>
            new DropdownModel({
                text: resp.dateoffindingctwdecision,
                value: resp.intakeservreqcourtorderid
            })
    );
    }
    if(worksheetData.data.reasonableeffortsjson) {
      this.reasonableeffortsdropdown = worksheetData.data.reasonableeffortsjson.map(
        (resp:any) =>
            new DropdownModel({
                text: resp.dateofreasonableeffortscourthearing,
                value: resp.intakeservreqcourtorderid
            })
    );
    }
    if(worksheetData.data.jdrefppjson) {
      this.jdrefppdropdown = worksheetData.data.jdrefppjson.map(
        (resp:any) =>
            new DropdownModel({
                text: resp.dateofjudicialfindingofrefpp,
                value: resp.intakeservreqcourtorderid
            })
    );
    }
    if(worksheetData.data.vpabestinterestjson) {
      this.vpabestinterestdropdown = worksheetData.data.vpabestinterestjson.map(
        (resp :any) =>
            new DropdownModel({
              value: resp.intakeservreqcourtorderid,
              text: resp.dateofcurrentjudicialfindingofbestinterest
            })
    );
    }
    if(worksheetData.removalInfo && worksheetData.removalInfo.length > 0){
      this.legalGroup.patchValue(worksheetData.removalInfo[0]);
    }
  }
  handlePeriodType(){
    if (this.periodType === 'RD') {
      this.handleStartAndEndDateCheckFn();
    } else if (this.periodType === 'ID') {
      if (this.worksheetData && this.worksheetData.data.typeofvpa === 'EA-VPA') {
            this.show18to21section = true;
            // To get education details
            this.getEducation(this.childPersonId);
            this.getworkDetails(this.childPersonId);
            this.getEmploymentBarrierDetails(this.childPersonId);
            this.getDisabilityList(this.childPersonId);
        } else {
            this.show18to21section = false;
        }

    } else {
      if (this.ageofthechildvalue >= '18' && this.ageofthechildvalue <= '21') {
          this.show18to21section = true;
      } else {
          this.show18to21section = false;
      }
    }
  }
  // Assosiated with handlePeriodType method
  private handleStartAndEndDateCheckFn() {
    const startdatefordeterminationformat = moment(this.startdatefordetermination);
    const enddatefordeterminationformat = moment(this.enddatefordetermination);
    const childdob = moment(this.worksheetData.data.dateofbirth);

    const ageofthechildafterattimeofstartdate = startdatefordeterminationformat.diff(childdob, 'years');
    const ageofthechildafterbeforetimeofenddate = enddatefordeterminationformat.diff(childdob, 'years');

    if ((ageofthechildafterattimeofstartdate >= 18 && ageofthechildafterattimeofstartdate <= 21)
      || (ageofthechildafterbeforetimeofenddate >= 18 && ageofthechildafterbeforetimeofenddate <= 21)) {
      this.show18to21section = true;
      // To get education details
      this.getEducation(this.childPersonId);
      this.getworkDetails(this.childPersonId);
      this.getEmploymentBarrierDetails(this.childPersonId);
      this.getDisabilityList(this.childPersonId);
      if (ageofthechildafterattimeofstartdate === 21 || ageofthechildafterbeforetimeofenddate === 21) {
        this.annual21Bday = true;
      } else {
        this.annual21Bday = false;
      }
    } else {
      this.show18to21section = false;
      this.annual21Bday = false;
    }
  }

  handlePersonList(){
    _.forIn(this.personsList, (person) => {
      this.personsDropdown.push({
        label: person.label,
        value: person.value
      });
    });
   _.forIn(this.personsList, (person) => {
          if (((!person.relationship.some((relation:any) => relation === 'Child')) || (this.worksheetData.data.typeofvpa === 'EA-VPA')) ||
          (person.relationship.some((relation:any) => relation === 'Child') && person.relationship.some((relation:any) => relation === 'Parent'))) {
              this.personSubjectCtw.push({
                label: person.label,
                value: person.value
              });
          }
      });
  _.forIn(this.personsList, (person) => {
      if ((!person.relationship.some((relation:any) => relation === 'Child')) || 
      (person.relationship.some((relation:any) => relation === 'Child') && person.relationship.some((relation:any) => relation === 'Parent'))) {
          this.personSubjectOthersCtw.push({
              label: person.label,
              value: person.value
          });
      }
  });
  //D-23536 Parent drop down should list only biological and adoptive parents
  _.forIn(this.personsList, (person) => {
          if (person.relationcheck === 'Adoptive Father' || person.relationcheck === 'Adoptive Mother' || person.relationcheck === 'Biological Father' 
              || person.relationcheck === 'Biological Mother' || person.relationcheck === 'Adoptive Parent') {
              this.personSubjectDeprivation.push({
                label: person.label,
                value: person.value
              });
                this.personSubjectDeprivation = this.personSubjectDeprivation.filter(((set:any) => (checkvalue:any) => !set.has(checkvalue.value) && set.add(checkvalue.value))(new Set));
          }
  });
  }
  addDeprivation() {
    const controlArry = this.afdc.controls.delist as FormArray;
    controlArry.push(this._formBuilder.group({
      deprivationParentId: [''],
      childdeprivedofparentalsupport: [''],
      reasonforabsence: [''],
      deprivationfactor: [''],
      dateofparentdeath: [''],
      incarcerationdate: [''],
      unemploymentorunderemployment: [''],
      ivepersondeprivationid: [''],
      activeFlag: [1]
    })
    );
    this.controlDevarry.push('1');
  }

  deletedeprivation(index:any, item:any) {
    const data = {
      ivepersondeprivationid: item,
    }
    this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.deprivationDelete)
    .subscribe(
      response => {
          if (response) {
            this.msg.push( 'Deprivation deleted successfully');
          }
      },
      error => {
        this.errorMessage.push('Deprivation not delted successfully');
      }
    );
    const controlArry = this.afdc.controls.delist as FormArray;
    controlArry.removeAt(index);
  }



  changedeprivationparent(index:number) {
    const controlArry = this.afdc.controls.delist  as FormArray;
    this.firstGenList.forEach((item:any) => {
      if(item.cjamspid === controlArry?.controls[index].get('deprivationParentId')?.value){
        controlArry.controls[index].get('dateofparentdeath')?.value(item.dateofdeath);
      }
    });
  }

  addRelatives() {
    const controlArryRel = this.afdc.controls.specifiedRelativesList  as FormArray;
    controlArryRel.push(this._formBuilder.group({
      sepecifiedrelativeuniqid: '',
      specifiedrelativename:  '',
      specifiedrelativerelationshipid:  '',
      specifiedrelativephysicaladdress: '',
      specifiedrelativedatechildlastlivedwith:  '',
      activeFlag: [1]
    })
    );
    this.controlRel.push('1');
  }
  deleteRelatives(index:any) {
    const controlArryRel = this.afdc.controls.specifiedRelativesList  as FormArray;
    controlArryRel.removeAt(index);
  }


  specifiedRelativeChange(id:any){
    const controlArryRel = this.afdc.controls.specifiedRelativesList  as FormArray;
    const afdc = this.afdc.getRawValue();
    afdc.specifiedRelativesList.forEach((item:any, index:any) => {
      if(item.specifiedrelativename === id.specifiedrelativename){
        const selectedPerson =  this.personsList[item.specifiedrelativename];
        const address = selectedPerson.address ? selectedPerson.address : '';
        const city = selectedPerson.city ? selectedPerson.city : '';
        const state = selectedPerson.state ? selectedPerson.state : '';
        const zipcode = selectedPerson.zipcode ? selectedPerson.zipcode : '';
        if(address === ''){
          controlArryRel.controls[index].get('specifiedrelativephysicaladdress')?.setValue('');
        }else{
          controlArryRel.controls[index].get('specifiedrelativephysicaladdress')?.setValue(`${address} ${city} ${state} ${zipcode}`);
        }

      }
    });
  }

  showScheduleH() {
    this.shownotinau = false;
    const control = this.afdc.controls.household  as FormArray;
    const arr = [];
    _.forIn(control['value'], (val) => {
       if (val.assistanceunit === 'YES'){
         arr.push(1);
       }
    });
    const notInAU = [];
    _.forIn(control['value'], (val) => {
       if (val.assistanceunit === 'NO'){
        notInAU.push(1);
       }
    });
    this.getScheduleH(arr.length, true);
    this.getScheduleH(notInAU.length, false);
    _.forIn(control['value'], (val) => {
      if (val.deemedincome === true){
        this.shownotinau = true;
      }
   });
   }

   getScheduleH(length:number,isAU:boolean){
    this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        nolimit: true,
        method: 'get',
        where: { householdsize: length }
      }),
      `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.getScheduleH}?filter`
    )
    .subscribe((result) => {
       if (result && _.isArray(result)) {
        if (isAU) {
          this.scheduleHLookUp = result[0] ;
        } else {
          this.scheduleHLookUpForNotInAU = result[0] ;
        }
       }
    });
   }

   getLegalInfo(courtorderid:any, courtlanguagetype:any) {

    const data = {
      courtorderid: courtorderid,
      courtlanguagetype: courtlanguagetype,
      clientid : this.clientId,
      removalid : this.removalId,
      sqnm_sw : this.selectPeriodItem.sqnm_sw, 
      reviewperiodstartdt: this.selectPeriodItem.start_dt
    }

    this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.getLegalInfo).subscribe(
      (response: any) => {
        const legalinfo = response.data ? response.data[0] : null;
        if (legalinfo) {
          if(courtlanguagetype === 'RPR')
          {
            this.reasonableeffortsmade = legalinfo.reasonableeffortsmade;
            this.reasonableeffortsnotnecessaryduetoemergentcircumstances = legalinfo.reasonableeffortsnotnecessaryduetoemergentcircumstances;
            this.legalGroup.patchValue({reasonableeffortsmade : this.reasonableeffortsmade});
            this.legalGroup.patchValue({reasonableeffortsnotnecessaryduetoemergentcircumstances : this.reasonableeffortsnotnecessaryduetoemergentcircumstances});
          } else {
              this.legalGroup.patchValue(legalinfo);
              if (courtorderid ===  ' ' && this.checkCTWDecision === 'N') {
                  this.legalGroup.patchValue({ctwdecision: this.checkCTWDecision});
              }
            if (this.reasonableeffortsmade) {
            this.legalGroup.patchValue({reasonableeffortsmade : this.reasonableeffortsmade});
            this.legalGroup.patchValue({reasonableeffortsnotnecessaryduetoemergentcircumstances : this.reasonableeffortsnotnecessaryduetoemergentcircumstances});
            }
          }
        }
      },
      (error) => {
        return false;
      }
    );

   }

  getPersonName(person:any) {
    let relation = 'Unknown';
    if (this.firstGenList && this.firstGenList.length > 0) {
      const relationshiparraycheck = this.personrelationlist ? this.personrelationlist : this.firstGenList[0].relationshiparray;
      _.forIn(relationshiparraycheck, (relatnship) => {
        if ((relatnship.person1id === this.childPersonId && relatnship.person2id === person.personid) ||
          (relatnship.primaryuserid === this.childPersonId && relatnship.secondaryuserid === person.personid)) {
          relation = relatnship.relation || relatnship.description || 'Unknown';
        }
      });
    }
    if (this.childPersonId === person.personid) {
      relation = 'Self';
    }

    return `${person.firstname} ${person.lastname}(${relation})`;
  }

  showAssetOrIncome(household:any,isIncome:any) {
    this.selectedHouseHold = null;
    const house = household;
    this.selectedHouseHold = house['value'];
    if(isIncome){
      $('#iframe-income').modal('show');
    } else {
      $('#iframe-asset').modal('show');
    }
  }

  showPersonFin(household:any) {
    const house = household;
    this.selectedHouseHold = house['value'];
    if (this.selectedHouseHold && this.selectedHouseHold.id && this.selectedHouseHold.caseid && this.selectedHouseHold.casenumber) {
      this._dataStoreService.setData('fostercarecasedetails', this.selectedHouseHold);
      this._navigationUtils.openEditFinance(this.selectedHouseHold.id,this.clientId,this.placementId,this.removalId,this.fromIVtab,
             AppConstants.CASE_TYPE.SERVICE_CASE, this.selectedHouseHold.caseid, this.getData(this.selectedHouseHold.casenumber));
    }
  }


  getData(casenumber:any) {
    return {
      purposeId: null,
      caseNumber: casenumber
    };
  }

  /* D-21360 Earned and Unearned Income Validation  */
    verifyearnedincome() {
      let householdincomecheck:any[] = [];
        if (this.periodType === 'ID') {
            householdincomecheck = this.afdc.value.household;
            const houseHoldArray :any[] = [];
            let householdobjrelation = '';
            householdincomecheck.forEach(houseHoldObj => {
               householdobjrelation =  houseHoldObj.name.substring(
                    houseHoldObj.name.lastIndexOf('(') + 1,
                    houseHoldObj.name.lastIndexOf(')')
                );
                let earnedandunearnedincomecheck!: boolean 
               if ((houseHoldObj.assistanceunit === 'NO' || houseHoldObj.disregardearnedincome === true) 
                  && (householdobjrelation !== 'Step Father' && householdobjrelation !== 'Step Mother')) {
                   earnedandunearnedincomecheck = true;
               }
               this.ifNotearnedandunearnedincomecheckFn(earnedandunearnedincomecheck, houseHoldObj, houseHoldArray);
            });
            return houseHoldArray;
        } else {
            return householdincomecheck;
        }
    }
  // Associated to verifyearnedincome function
  private ifNotearnedandunearnedincomecheckFn(earnedandunearnedincomecheck: boolean, houseHoldObj: any, houseHoldArray: any[]) {
    if (!earnedandunearnedincomecheck) {

      const flag:any[] = [];
      if (houseHoldObj.income.length === 0) {
        const houseHoldIncomeObj = {
          name: houseHoldObj.name,
          message: 'Earned and Unearned Income is missing for '
        };
        houseHoldArray.push(houseHoldIncomeObj);
      } else {
        houseHoldObj.income.forEach((income:any) => {
          this.checkEarnedSwFn(income, flag);
        });
        if (!(flag.length === 2 && houseHoldObj.income.length >= 2)) {
          const houseHoldIncomeObj = {
            name: houseHoldObj.name,
            message: flag[0],
          };
          houseHoldArray.push(houseHoldIncomeObj);
        }
      }
    }
  }
  // Associated to verifyearnedincome function
  private checkEarnedSwFn(income: any, flag: any[]) {
    if (income['earned_sw'] !== 'U') {
      const alertMessage = 'Unearned Income is missing for ';
      if (flag.indexOf(alertMessage) === -1) {
        flag.push(alertMessage);
      }

    }
    if (income['earned_sw'] !== 'E') {
      const alertMessage = 'Earned Income is missing for ';
      if (flag.indexOf(alertMessage) === -1) {
        flag.push(alertMessage);
      }
    }
  }

    saveAsDraft(){
      this.saveData(false);
    }

    saveAndConfirm(){
      this.displayValidationMessages =false;
    if (this?.legalGroup?.invalid) {
        this.displayValidationMessages =true;
        this?.legalGroup?.markAllAsTouched();
    }
    if (this?.other?.invalid) {
      this.displayValidationMessages =true;
      this?.other?.markAllAsTouched();
    }
    if (this?.placement?.invalid) {
      this.displayValidationMessages =true;
      this?.placement?.markAllAsTouched();
    }
    if (this?.afdc?.invalid) {
      this.displayValidationMessages =true;
      this?.afdc?.markAllAsTouched();
    }
      this.saveData(true);
    }
    // D-23978 Assets and In AU validation check
    verifyinauperson() {
        let householdInAuCheck = [];
        if (this.periodType === 'ID') {
            householdInAuCheck = this.afdc.value.household;
            const houseHoldArray :any[]= [];
            householdInAuCheck.forEach((houseHoldObj:any) => {
                    if (houseHoldObj.assistanceunit.length === 0) {
                        const houseHoldIncomeObj = {
                            name: houseHoldObj.name,
                            message: 'In AU is missing for '
                        };
                        houseHoldArray.push(houseHoldIncomeObj);
                    }
            });
            return houseHoldArray;
        }//SonarQube fix - Refactor this function to use "return" consistently.
        return undefined;
    }

    verifyassets() {
        let householdassetscheck = [];
        if (this.periodType === 'ID') {
            householdassetscheck = this.afdc.value.household;
            const houseHoldArray :any= [];
            householdassetscheck.forEach((houseHoldObj:any) => {
                let assetcheck: boolean;
                if (houseHoldObj.assistanceunit === 'NO' || houseHoldObj.disregardearnedincome === true) {
                    assetcheck = false;
                } else {
                    assetcheck = true;
                }
                if (assetcheck) {
                    if (houseHoldObj.assets.length === 0) {
                        const houseHoldassetsObj = {
                            name: houseHoldObj.name,
                            message: 'Asset Information is missing for '
                        };
                        houseHoldArray.push(houseHoldassetsObj);
                    }
                }
            });
            return houseHoldArray;
        }//SonarQube fix - Refactor this function to use "return" consistently.
        return undefined;
    }

    verifyDeprivationFactorWithAU() {
      /*
        For all the parents in deprivation list -> check their inAU record in household list
        Ideally, instead of having to loop over two arrays the 'household' info
        should have been built as a 'hash map' with client id as the 'key'
        that way we could just query directly the values corresponding to that parent
      */

      let deprivationAbsenceInAUPersons:any = [];

      let deprivationMembers = this.afdc.value.delist;
      let householdMembers = this.afdc.value.household;
      
      if(deprivationMembers && householdMembers) {
      deprivationMembers.forEach( (deprivationMember:any) => {
        let currentDeprivationParentId = deprivationMember.deprivationParentId;
        householdMembers.forEach( (householdMember :any) => {
          if(householdMember.involvedclientid == currentDeprivationParentId
            && householdMember.assistanceunit == "YES" && deprivationMember.deprivationfactor == "AB") {
            deprivationAbsenceInAUPersons.push(householdMember.name);
          }
        })
      })
      }
      return deprivationAbsenceInAUPersons;
    }

  saveData(draft:any) {
    this.isMessageShow = true;
    this.disablesave = true;
    this.msg = [];
    this.errorMessage = [];

    //check for deprivation factor as Absence and parent in AU
    this.deprivationAbsenceInAUPersons = this.verifyDeprivationFactorWithAU();
    if (this.checkDeprivationAbsenceInAUPersonsCondFn()) {
      $('#iframe-deprivation-absence-inau').modal('show');
      this.disablesave = false;
      return false;
    }
    //Check if Date on which the agency lost legal responsibility is valid - CIDM-9426
    if (this.legalGroup.value.isiveagencyresponsibleforplacementandcare === 'NO') {
      if (this.checkCondForDeterminationDatesFn()) {
          this._alertService.error('Please enter the "Date on which the agency lost legal responsibility" between the selected review period start date and review period end date.');
          return;
        }
    }

    if (draft) {
      this.incompleteincomepersons = this.verifyearnedincome();
      this.incompleteInAuPersons = this.verifyinauperson();
      this.incompleteassetpersons = this.verifyassets();
      if (this.checkCondition1LinkedToDraftFn()) {
        this.disablesave = false;
        return false;
      }

      if (this.educationstartdtcheck) {
        this._alertService.error('Please Enter Start Date for Educational Details');
        this.disablesave = false;
        return;
      }
      if (this.employementstartdtcheck) {
        this._alertService.error('Please Enter Start Date for Employement Details');
        this.disablesave = false;
        return;
      }
      if (this.employmentbarrierstdtcheck) {
        this._alertService.error('Please Enter Start Date for Employement Barrier Details');
        this.disablesave = false;
        return;
      }
      if (this.disabilitystartdtcheck) {
        this._alertService.error('Please Enter Start Date for Disability Details');
        this.disablesave = false;
        return;
      }
    }

    this.pushMsgFn();
    window.scrollTo(0, 100);
    setTimeout(() => {
      this.getEligibilityData();
      this.getEligibilityWorksheetData(this.selectPeriodItem);
      this.isMessageShow = false;
      this.disablesave = false;
    }, 5000);
  }
  // Associated with saveData function
  private checkDeprivationAbsenceInAUPersonsCondFn() {
    return (this.deprivationAbsenceInAUPersons && this.deprivationAbsenceInAUPersons.length !== 0);
  }
  // Associated with saveData function
  private checkCondForDeterminationDatesFn() {
    return (this.legalGroup.value.dateagencylostlegalresponsibility &&
      (moment().diff(this.enddatefordetermination, 'days') > moment().diff(moment(moment(this.legalGroup.value.dateagencylostlegalresponsibility).format(this.dtformat)), 'days')
        || moment().diff(this.startdatefordetermination, 'days') < moment().diff(moment(moment(this.legalGroup.value.dateagencylostlegalresponsibility).format(this.dtformat)), 'days')));
  }
  // Associated with saveData function
  private checkCondition1LinkedToDraftFn() {
    if (this.periodType === 'ID') {
      if(this.checkCondition1LinkedToDraftFn2()){
        return true;
      }
      if (this.incompleteassetpersons && this.incompleteassetpersons.length !== 0) {
        this.showMissingAssetsInfo = true;
        $('#iframe-assets-missing-info').modal('show');
        return true;
      }
      if (this.afdc.value.afdceligibilitymonth === null || this.afdc.value.afdceligibilitymonth === '') {
        $('#iframe-afdc-eligibilitymonth').modal('show');
        return true;
      }
      return false;
    }

    if (this.checkCondition1LinkedToDraftCond4Fn() || this.checkCondition1LinkedToDraftCond1Fn() || this.checkCondition1LinkedToDraftCond2Fn() || this.checkCondition1LinkedToDraftCond3Fn()) {
      this._alertService.error(this.validationmsg);
      return true;
    }

    if (this.checkCondition2LinkedToDraftFn()) {
      return true
    }
    return false;
  }

  private checkCondition1LinkedToDraftFn2(){
    if (this.incompleteincomepersons && this.incompleteincomepersons.length !== 0) {
      this.showMissingIncomeInfo = true;
      $('#iframe-income-missing-info').modal('show');
      return true;
    }
    if (this.incompleteInAuPersons && this.incompleteInAuPersons.length !== 0) {
      this.showMissingInAU = true;
      $('#iframe-inAU-missing-info').modal('show');

      return true;
    }
    return false;
  }
  // Associated with saveData function
  private checkCondition1LinkedToDraftCond4Fn() {
    return this.legalGroup['controls'].typeofremovaldescription.value !== this.voluntaryplacementagreement && (this.legalGroup.value.isiveagencyresponsibleforplacementandcare === null || this.legalGroup.value.isiveagencyresponsibleforplacementandcare === '');
  }
  // Associated with saveData function
  private checkCondition1LinkedToDraftCond3Fn() {
    return (this.show18to21section && this.atleastOnesilaplacement && (this.other.value.homeassessmentverification === null || this.other.value.homeassessmentverification === ''));
  }
  // Associated with saveData function
  private checkCondition1LinkedToDraftCond2Fn() {
    return (this.periodType === 'RD' && ((this.placement.value.islapsesinplacement === null || this.placement.value.islapsesinplacement === '') || (this.other.value.ssissainfoverification === null || this.other.value.ssissainfoverification === '')));
  }
  // Associated with saveData function
  private checkCondition1LinkedToDraftCond1Fn() {
    return (this.legalGroup['controls'].typeofremovaldescription.value === this.voluntaryplacementagreement && this.periodType === 'RD' && (this.legalGroup.value.isiveagencyresponsibleforplacementandcare === null || this.legalGroup.value.isiveagencyresponsibleforplacementandcare === ''));
  }
  // Associated with saveData function
  private checkCondition2LinkedToDraftFn() {
    if (this.checkCondition2LinkedToDraftCond1Fn() || this.checkCondition2LinkedToDraftCond2Fn()) {
      this._alertService.error(this.validationmsg);
      return true;
    }
    
    let silaPlacements;
    if (this.show18to21section) {
      silaPlacements = this.placementList.filter((item:any) => item.placement_type == this.silaHomesText);
      let element :any;
      for (element of silaPlacements) {
        if (element.isplacementreimbursible && element.isplacementreimbursible === 'YES' && !element.effectivedate) {
          this._alertService.error(this.validationmsg);
          return true;
        } else if (element.isplacementreimbursible && element.isplacementreimbursible === 'YES' && element.silaMaxDate && (element.effectivedate > new Date(element.silaMaxDate))) {
          this._alertService.error('Home Report Date should be less than ' + element.silaMaxDate);
          return true;
        } else if (element.isplacementreimbursible && element.isplacementreimbursible === 'YES' && element.effectivedate < new Date(element.silaMinDate)) {
          this._alertService.error('Home Report Date should be greater than ' + element.silaMinDate);
          return true;
        }
      }
    }

    if (this.checkCondition2LinkedToDraftCond3Fn()) {
      this._alertService.error(this.validationmsg);
      return true;
    }

    if (this.checkCondition3LinkedToDraftFn()) {
      return true;
    }

    return false;
  }
  // Associated with saveData function
  private checkCondition2LinkedToDraftCond3Fn() {
    return (this.periodType === 'ID' && this.other.value.infoaboutincomenresources !== 'NO' && (this.other.value.incomeresourcesverification === null || this.other.value.incomeresourcesverification === ''));
  }
  // Associated with saveData function
  private checkCondition2LinkedToDraftCond2Fn() {
    return (this.legalGroup['controls'].typeofremovaldescription.value === this.voluntaryplacementagreement && this.periodType === 'ID' && (this.other.value.vpasprverification === null || this.other.value.vpasprverification === ''));
  }
  // Associated with saveData function
  private checkCondition2LinkedToDraftCond1Fn() {
    return (this.periodType === 'ID' && ((this.other.value.citizenshipverification === null || this.other.value.citizenshipverification === '') || (this.other.value.infoaboutincomenresources === null || this.other.value.infoaboutincomenresources === '') || (this.other.value.ageverification === null || this.other.value.ageverification === '') || (this.other.value.assetinfoverification === null || this.other.value.assetinfoverification === '') || (this.other.value.ssissainfoverification === null || this.other.value.ssissainfoverification === '')));
  }
  // Associated with saveData function
  private checkCondition3LinkedToDraftFn() {
    if (this.checkCondition3LinkedToDraftCond1Fn() || this.checkCondition3LinkedToDraftCond2Fn()) {
      this._alertService.error(this.validationmsg);
      return true;
    }
  }
  // Associated with saveData function
  private checkCondition3LinkedToDraftCond1Fn() {
    return (this.placement.value.islapsesinplacement === 'YES' && (this.placement.value.typeoflapses === null || this.placement.value.kindoflapses === null));
  }
  // Associated with saveData function
  private checkCondition3LinkedToDraftCond2Fn() {
    return ((this.other.value.isSilaYouth === 'YES' && !this.other.value.isSilaAgreementValid) || (this.other.value.isSilaAgreementValid === 'YES' && (this.other.value.silaAgreementDate === null || this.other.value.silaAgreementDate === '')));
  }
  // Associated to saveData function
  private pushMsgFn() {
    this.updateVPA(this.legalGroup.value).subscribe(
      response => {
        if (response) {
          // VPA saved successfully
        }
      },
      error => {
        this.errorMessage.push('VPA not saved successfully');
      }
    );
    this.updatePlacement().subscribe(
      response => {
        this.reusableResponseFn(response, 'Placement saved successfully');
      },
      error => {
        this.errorMessage.push('Placement not saved successfully');
      }
    );

    this.updateJudicial().subscribe(
      response => {
        this.reusableResponseFn(response, 'Judicial saved successfully');
      },
      error => {
        this.errorMessage.push('Judicial not saved successfully');
      }
    );

    if (this.afdc.value.delist && this.afdc.value.delist.length && this.afdc.value.delist[0]) {
      this.updateDeprivation(this.afdc.value.delist)?.subscribe(
        response => {
          this.reusableResponseFn(response, 'Deprivation saved successfully');
        },
        error => {
          this.errorMessage.push('Deprivation not saved successfully');
        }
      );
    }
    if (this.afdc.value.specifiedRelativesList && this.afdc.value.specifiedRelativesList.length && this.afdc.value.specifiedRelativesList[0]) {
      this.updateSpecifiedRelatives(this.afdc.value.specifiedRelativesList)?.subscribe(
        response => {
          this.reusableResponseFn(response, 'Specified Relatives saved successfully');
        },
        error => {
          this.errorMessage.push('Specified Relatives not saved successfully');
        }
      );
    }
    if (this.scheduleHLookUp || this.scheduleHLookUpForNotInAU) {
      this.updateIncomeAndAssetsSummary()?.subscribe(
        response => {
          this.reusableResponseFn(response, 'Income And Assets Summar saved successfully');
        },
        error => {
          this.errorMessage.push('Income And Assets Summar not saved successfully');
        }
      );
    }
    this.updateHouseHoldIncome(this.afdc.value.household).subscribe(
      response => {
        this.reusableResponseFn(response, 'House Hold Income saved successfully');
      },
      error => {
        this.errorMessage.push('House Hold Income not saved successfully');
      }
    );
    this.updateSSISSAData(this.other.value).subscribe(
      response => {
        this.reusableResponseFn(response, 'SSI saved successfully');
      },
      error => {
        this.errorMessage.push('SSI not saved successfully');
      }
    );
  }
  // Associated to saveData function
  private reusableResponseFn(response: any, message: string) {
    if (response) {
      this.msg.push(message);
    }
  }

    getInvolvedPersonWithPersonID() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged'); 

        const casenumber = this.summaryInfo.servicecaseid;

        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    method: 'get',
                    where: { 'objectid': casenumber,
                        'objecttypekey': 'servicecase',
                        'personid': this.childPersonId,
                        'isExpungementSuperUser': isExpungementSuperUser,
                        'iscaseexpunged': iscaseexpunged}
                }),
                'People/getallpersonrelationbyprovidedpersonid?filter'
            ).subscribe((result) => {
                if (result) {
                    const orderofpersonrelation:any = result;
                    orderofpersonrelation.sort((a:any, b:any) => a.updatedon.localeCompare(b.updatedon));
                    this.personrelationlist = orderofpersonrelation;
                    this.getPersonsList();
                } else {
                    this.getPersonsList();
                }
            }, error => {
                this.getPersonsList();
                });
    }


    getEligibilityWorksheetData(item: any) {
    const data = {
      clientId: this.clientId,
      removalId: this.removalId,
      detPeriodType: item.sqnm_sw,
    }
    this.periodSqnm = item.sqnm_sw;
    if(!this.periodSqnm){
      this.periodSqnm = 'I';
    }
    this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.getEligibilityWorksheet).subscribe(
      (response: any) => {
        if (response) {
          this.getInvolvedPersonWithPersonID();
          this.worksheetData = response;
          this.startForm(item);
          if(this.worksheetData.data.typeofremoval === 'Court_Order'){
            this.legalGroup.patchValue({typeofremovaldescription : 'Court Order'});
          }
          if(this.worksheetData.data.typeofremoval === 'Voluntary_Placement_Agreement'){
            this.legalGroup.patchValue({typeofremovaldescription : this.voluntaryplacementagreement});
          }
        }
      },
      (error) => {
        return false;
      }
    );
  }

  toggleChildren(keyId: number): void {
    const filterChildrenData: any = {
      keyId,
      isParent: false
    }

    const filterParentData: any = {
      keyId,
      isParent: true
    }

    _.filter(this.periodTable, filterChildrenData).forEach((period : any)=>{
      period.isVisible = !period.isVisible;
    });

    _.filter(this.periodTable, filterParentData).forEach((period : any)=>{
      period.isCollapsed = !period.isCollapsed;
    });
  }

  getEligibilityData(): void {
    this._commonHttpService.getAll(`${Titile4eUrlConfig.EndPoint.getPeriods}/${this.clientId}/${this.removalId}`).subscribe((response: any) => {
      response.data.forEach((v:any) => {
        v.isSelected = false;
      });
      let data = response.data;
      data.forEach((obj :any) => {
          obj.eligibilitystatus = (obj.eligibilitystatus === 'FOSTER_CARE_INELIGIBLE') ? 'INELIGIBLE' : obj.eligibilitystatus;
      });
      const eligibilityCheck = data.findIndex((element:any) => (element.eligibilitystatus === 'INELIGIBLE'));
      const eligibilityInitialCheck  = data.findIndex((element:any) => (element.eligibilitystatus === 'INELIGIBLE' && element.sqnm_sw === 'I'));
      const r1EligibilityDetails =  data.find((element:any) => element.sqnm_sw ==='R1');
      const r1EligibilityDetailsIndex =  data.findIndex((element:any) => element.sqnm_sw ==='R1');
      let initialineligiblitycheck = false;
      data.forEach((obj :any) => {
          if (obj.sqnm_sw === 'I' && obj.eligibilitystatus === 'INELIGIBLE') {
              initialineligiblitycheck = true;
              this.initialeligiblestatus = 'Ineligible';
          }
      });

        if (eligibilityCheck !== -1 && initialineligiblitycheck) {
          
          
          // CIDM-8544 and CDM-37210
          if(r1EligibilityDetails && eligibilityInitialCheck) {
            data = data.slice(r1EligibilityDetailsIndex - 1);
          }
        } else if (eligibilityCheck !== -1 ) {
            data = data.slice(eligibilityCheck);
        }

      let previousKey = 0;
      for (let index = data.length-1; index >= 0; index--) {
          data[index].isParent = true;
          data[index].isVisible = true;
          data[index].isCollapsed = true;
          if(previousKey === data[index].key_id){
             data[index].isVisible = false;
              data[index].isParent = false;
              data[index].isCollapsed = false;
          }
          previousKey = data[index].key_id;
      }
      this.periodTable = data;
      this.checkFosterCareSelectedPeriodFn();
    },
      (error) => {
        return false;
      }
    );
  }
// Associate to getEligibilityData function
  private checkFosterCareSelectedPeriodFn() {
    const item = this._dataStoreService.getData("FosterCare_Selected_Period");
    const fostercarecasedetails = this._dataStoreService.getData("fostercarecasedetails");
    if (item) {
      this.onPeriodSelectItem(item);
      if (fostercarecasedetails) {
        this.clickMatStepper(2, this.stepper);
      } else {
        this.clickMatStepper(this._dataStoreService.getData("FosterCare_Selected_Component"), this.stepper);
      }
    }
  }

  getPersonsList() {
    const casenumber = this.summaryInfo.servicecaseid;
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          nolimit: true,
          method: 'get',
          where: { servicecaseid: casenumber }
        }),
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList}?filter`
      )
      .subscribe((result) => {
        this.firstGenList = result.data;
        this.firstGenList.forEach((element:any) => {
          const relation = this.involvedPersonListApiResponseFn(element);


          const roles = _.flatMap(element.roles, 'typedescription');
          this.personsList[element.cjamspid] = {
            name: `${element.firstname.trim()} ${element.lastname.trim()}`,
            relationship: roles,
            fourerelid: element.fourerelid,
            value: element.cjamspid,
            label: `${element.firstname.trim()} ${element.lastname.trim()}(${element.cjamspid}) - ${relation}`,
            relationcheck: `${relation}`,
            personid: element.personid,
            address: element.address,
            city: element.city,
            state: element.state,
            zipcode: element.zipcode,
            dateofbirthforincome: element.dob,
          };
        });
      });
  }

  private involvedPersonListApiResponseFn(element: any) {
    let relation = 'Unknown';

    if (this.personrelationlist && this.personrelationlist.length > 0) {
      relation = this.ifPersonrelationlistFn(element, relation);
    } else {
      relation = this.ifNotPersonrelationlistFn(element, relation);
    }

    if (this.childPersonId === element.personid) {
      relation = 'Self';
    }
    return relation;
  }

  private ifNotPersonrelationlistFn(element: any, relation: string) {
    const relationshipsort = element.relationshiparray;
    relationshipsort.sort((a:any, b:any) => a.updatedon.localeCompare(b.updatedon));
    const relationshiparraycheck = relationshipsort;
    _.forIn(relationshiparraycheck, (relatnship) => {
      if (relatnship.primaryuserid === this.childPersonId && relatnship.secondaryuserid === element.personid) {
        relation = relatnship.description ? relatnship.description : 'Unknown';
      }
    });
    return relation;
  }

  private ifPersonrelationlistFn(element: any, relation: string) {
    const relationshiparraycheck = this.personrelationlist;
    _.forIn(relationshiparraycheck, (relatnship) => {
      if (relatnship.person1id === this.childPersonId && relatnship.person2id === element.personid) {
        relation = relatnship.relation ? relatnship.relation : 'Unknown';
      }
    });
    return relation;
  }

  gethearingdetails() {
     return this._commonHttpService.getArrayList(
      {}, `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingTypeUrl}?filter={"where": {"teamtypekey": "CW"},"nolimit":true,"order":"description"}`)
      .subscribe((result) => {
         this.hearingTypeListdropdown = result;
     });
  }

  getEducation(personid:any) {
    return this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                method: 'get',
                where: { personid: personid },
                page: 1,
                limit: 10
            }),
            'personeducation/educationlist?filter'
        ).subscribe((result) => {
            this.educationlist = result;
            this.educationlist = this.educationlist?.personEducation ?? [];
            this.educationfilterlist = [];
            this.educationEligiblityList = [];
            this.educationlist.forEach((element:any) => {
                element.startdate = this.retrunStartDateFn(element);
                element.enddate =  this.returnEnddateFn(element);
                this.startdatefordetermination = moment(this.startdatefordetermination).format(this.dtformat);
                this.enddatefordetermination = moment(this.enddatefordetermination).format(this.dtformat);
                if (this.checkClasstypekeyCondFn(element)) {
                      if(element.classtypetypekey === null && element.schoolenrolltypekey) {
                        if (element.schoolenrolltypekey === 'SESC') {
                         element.classtypetypekey = 'JH';
                        } else if (element.schoolenrolltypekey === 'COLLG') {
                         element.classtypetypekey = 'CLG';
                       } else if (element.schoolenrolltypekey === 'PSEOT') {
                         element.classtypetypekey = 'VTP';
                       }
                      }
                      this.educationfilterlist.push(element);
                    // Check for education details before determination and send to corticon
                    this.checkDateConditionFn(element);

                }
            });
        });
}
  // Associated to getEducation function
  private checkDateConditionFn(element: any) {
    const eleRef = { ...element };
    if (this.reusableAfterBeforeDateCondFn(element)) {
      this.isEduEligible = true;
      if ((moment(this.startdatefordetermination).isSameOrBefore(moment(element.startdate)) && 
      (moment(this.enddatefordetermination).isSameOrAfter(moment(element.startdate))) && element.enddate === null)) {
        eleRef.enddate = moment(this.enddatefordetermination).format(this.dtformat);
      }
    } else if (this.startEndDateCheckFn(element)) {
      eleRef.startdate = moment(this.startdatefordetermination).format(this.dtformat);
      this.isEduEligible = true;
    }
    if (this.showonly18Bday) {
      if (moment(element.startdate).isSameOrBefore(moment(this.startdatefordetermination)) &&
        (element.enddate == null || moment(element.enddate).isSameOrAfter(moment(this.startdatefordetermination)))) {
        this.educationEligiblityList.push(eleRef);
      }
    } else {
      this.educationEligiblityList.push(eleRef);
    }

    this.checkShowonly18BdayFn(element, eleRef);
  }
  // Associated to getEducation function
  private checkClasstypekeyCondFn(element: any) {
    return element.classtypetypekey === 'CLG' || element.classtypetypekey === 'GEDP' || element.classtypetypekey === 'VTP' || element.classtypetypekey === 'HS'
      || element.classtypetypekey === 'JH' || element.classtypetypekey === 'IA' || element.currentgradetypekey === 'GDTWL' || element.currentgradetypekey === 'COL'
      || element.schoolenrolltypekey === 'SESC' || element.schoolenrolltypekey === 'COLLG' || element.schoolenrolltypekey === 'PSEOT';
  }

getworkDetails(personid: string) {
    return this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                method: 'get',
                where: { personid: personid }
            }),
            'People/getpersonwork?filter'
        ).subscribe((result) => {
            this.employementlist = result;
            this.employementEligibiltyList = [];
            this.employementlist.forEach((element:any) => {
                element.startdate = this.retrunStartDateFn(element);
                element.enddate =  this.returnEnddateFn(element);
                element.noofhours =  element.noofhours ? Number(element.noofhours) : null;
                if (element.workphone && element.workphone.length > 0) {
                    delete element.workphone;
                }
                if (element.email && element.email.length > 0) {
                    delete element.email;
                }
                // Check for valid employment details before determination and send to corticon
                const eleRef = {...element}
                if(this.reusableAfterBeforeDateCondFn(element)) {
                  this.isEmpEligible = true;
                } else if(this.startEndDateCheckFn(element)){
                  eleRef.startdate = moment(this.startdatefordetermination).format(this.dtformat);
                  this.isEmpEligible = true;
                }
                this.checkShowonly18BdayFn(element, eleRef);
            });
        });
}

  // Associated to getEducation and getworkDetails function
  private checkShowonly18BdayFn(element: any, eleRef: any) {
    if (this.showonly18Bday) {
      if (moment(element.startdate).isSameOrBefore(moment(this.startdatefordetermination)) &&
        (element.enddate == null || moment(element.enddate).isSameOrAfter(moment(this.startdatefordetermination)))) {
        this.employementEligibiltyList.push(eleRef);
      }
    } else {
      this.employementEligibiltyList.push(eleRef);
    }

    if (element.startdate === null || element.startdate === undefined) {
      this.educationstartdtcheck = true;
    }
  }

getEmploymentBarrierDetails(personid:any) {
    return this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                method: 'get',
                where: {personid: personid}
            }),
            'People/getpersonworknarrative?filter'
        ).subscribe((result) => {
            this.employementbarrierlist = result;
            const narrativeuniqueInfo = [];
            this.narrativeuniqueInfo = [];
            this.employementBarrierEligibiltyList = [];
            for (const element of this.employementbarrierlist) {
                const promotedemploymentprogramname = element.promotedemploymentprogramname;
                element.promotedemploymentprogramstartdate = element.promotedemploymentprogramstartdate ? 
                moment(element.promotedemploymentprogramstartdate).format(this.dtformat) : null;
                element.promotedemploymentprogramenddate =  element.promotedemploymentprogramenddate ? 
                moment(element.promotedemploymentprogramenddate).format(this.dtformat) : null;

                if (promotedemploymentprogramname) {
                    narrativeuniqueInfo[promotedemploymentprogramname] = element;
                }
                // Check for valid employment barier details before determination and send to corticon
                const eleRef = {...element}
                if(this.reusableAfterBeforeDateBarrierCondFn(element)) {
                  this.isEmpBarEligible = true;
                }else if(this.startEndDateCheckBarrierFn(element)){
                  eleRef.promotedemploymentprogramstartdate = moment(this.startdatefordetermination).format(this.dtformat);
                  this.isEmpBarEligible = true;
                }

                this.checkShowonly18BdayBarrierFn(eleRef, element);
            }
            for (const k in narrativeuniqueInfo) {
              this.narrativeuniqueInfo.push(narrativeuniqueInfo[k]);
            }
        });
}
  // Associated to getEmploymentBarrierDetails function
  private checkShowonly18BdayBarrierFn(eleRef: any, element: any) {
    if (this.showonly18Bday) {
      if (moment(eleRef.promotedemploymentprogramstartdate).isSameOrBefore(moment(this.startdatefordetermination)) &&
        (eleRef.promotedemploymentprogramenddate == null || moment(eleRef.promotedemploymentprogramenddate).isSameOrAfter(moment(this.startdatefordetermination)))) {
        this.employementBarrierEligibiltyList.push(eleRef);
      }
    } else {
      this.employementBarrierEligibiltyList.push(eleRef);
    }


    if (element.promotedemploymentprogramstartdate === null || element.promotedemploymentprogramstartdate === undefined) {
      this.employmentbarrierstdtcheck = true;
    }
  }
  // Associated to getEmploymentBarrierDetails function
  private startEndDateCheckBarrierFn(element: any) {
    return moment(this.startdatefordetermination).isSameOrAfter(moment(element.promotedemploymentprogramstartdate)) && 
    (element.promotedemploymentprogramenddate == null || 
      moment(this.enddatefordetermination).isSameOrBefore(moment(element.promotedemploymentprogramenddate)));
  }
  // Associated to getEmploymentBarrierDetails function
  private reusableAfterBeforeDateBarrierCondFn(element: any) {
    return (moment(this.startdatefordetermination).isSameOrBefore(moment(element.promotedemploymentprogramstartdate)) && 
    (moment(this.enddatefordetermination).isSameOrAfter(moment(element.promotedemploymentprogramstartdate)))) || 
    ((element.promotedemploymentprogramenddate == null || moment(this.startdatefordetermination).isSameOrBefore(moment(element.promotedemploymentprogramenddate))) && 
    (element.promotedemploymentprogramenddate == null || moment(this.enddatefordetermination).isSameOrAfter(moment(element.promotedemploymentprogramenddate))));
  }

getDisabilityList(personid:string) {
    return this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 20,
                method: 'get',
                where: { personid: personid }
            }),
            'People/getpersondisability?filter'
        ).subscribe((result) => {
            this.disabilityfilterlist = [];
            this.disabilityEligiblityList = [];
            this.disabilityList = result;
            this.disabilityList.forEach((element:any) => {
                element.startdate = this.retrunStartDateFn(element);
                element.enddate =  this.returnEnddateFn(element);
                element.evaluationdate =  element.evaluationdate ? moment(element.evaluationdate).format(this.dtformat) : null;
                if (element.disabilityconditiontypekey === 'Yes') {
                  if (element.disabilityflag === 1) {
                    element.disabilityflag = 'Permanent';
                  }  else {
                    element.disabilityflag = 'Temporary';
                  }
                  if (element.startdate === null || element.startdate === undefined ) {
                    this.disabilitystartdtcheck = true;
                  }
                  this.disabilityfilterlist.push(element);

                  // Check for Disability before determination and send to corticon
                  this.checkDateCondDisabilityFn(element);
                }
            });
        });
}
  // Associated to getDisabilityList function
  private checkDateCondDisabilityFn(element: any) {
    const eleRef = { ...element };
    if (this.reusableAfterBeforeDateCondFn(element)) {
      this.isdisabilityEligible = true;
    } else if (this.startEndDateCheckFn(element)) {
      eleRef.startdate = moment(this.startdatefordetermination).format(this.dtformat);
      this.isdisabilityEligible = true;
    }

    if (this.showonly18Bday) {
      if (moment(element.startdate).isSameOrBefore(moment(this.startdatefordetermination)) &&
        (element.enddate == null || moment(element.enddate).isSameOrAfter(moment(this.startdatefordetermination)))) {
        this.disabilityEligiblityList.push(eleRef);
      }
    } else {
      this.disabilityEligiblityList.push(eleRef);
    }
  }

  // Associated to getEducation, getDisabilityList and getworkDetails function
  private reusableAfterBeforeDateCondFn(element: any) {
    return (moment(this.startdatefordetermination).isSameOrBefore(moment(element.startdate)) && 
    (moment(this.enddatefordetermination).isSameOrAfter(moment(element.startdate)))) || 
    ((element.enddate == null || moment(this.startdatefordetermination).isSameOrBefore(moment(element.enddate))) && 
    (element.enddate == null || moment(this.enddatefordetermination).isSameOrAfter(moment(element.enddate))));
  }

  // Associated to getEducation, getDisabilityList and getworkDetails function
  private startEndDateCheckFn(element: any) {
    return moment(this.startdatefordetermination).isSameOrAfter(moment(element.startdate)) &&
     (element.enddate == null || moment(this.enddatefordetermination).isSameOrBefore(moment(element.enddate)));
  }

  // Associated to getEducation, getDisabilityList and getworkDetails function
  private returnEnddateFn(element: any): any {
    return element.enddate ? moment(element.enddate).format(this.dtformat) : null;
  }
  // Associated to getEducation, getDisabilityList and getworkDetails function
  private retrunStartDateFn(element: any): any {
    return element.startdate ? moment(element.startdate).format(this.dtformat) : null;
  }

  onSelectItem(event: any, item: any): void {
    item.isSelected = event.target.checked;
    this.selectedDetCount = _.filter(this.periodTable, {isSelected: true as any}).length;
  }

  submitEligibility() {
    this.selectedPeriodItems = {
      clientId: this.clientId,
      removalId: this.removalId,
      initialEligibleStatus: this.initialeligiblestatus ? this.initialeligiblestatus : null,
      selectedPeriods: _.filter(this.periodTable, { 'isSelected': true as any }),
      educationinformation: this.show18to21section && this.isEduEligible ? this.educationEligiblityList : null,
      employmentinformation: this.show18to21section && this.isEmpEligible ? this.employementEligibiltyList : null,
      employmentbarrierinfomation: this.show18to21section && this.isEmpBarEligible ? this.employementBarrierEligibiltyList : null,
      disablityinformation: this.show18to21section && this.isdisabilityEligible? this.disabilityEligiblityList : null,
      annual21Bday: this.annual21Bday ? this.annual21Bday : false,
    }
    this.submitForReview.emit(this.selectedPeriodItems);
  }

  private getAge(dateValue:any) {
    if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
        const rCDob = moment(new Date(dateValue), this.dtformat).toDate();
        return moment().diff(rCDob, 'years');
    } else {
        return '';
    }
}

  onPeriodSelectItem(item: any): void {
    this.legalGroup.reset();
    this.afdc.reset();
    this.placement.reset();
    this.other.reset();
    this.jdrefppdropdown = [];
    this.vpabestinterestdropdown = [];
    this._dataStoreService.setData("FosterCare_Selected_Period",item);
    const regex = /^[R]\d+$/gm;
    this.selectPeriodItem = item;
    this.showonly18Bday = false;
    if (item.sqnm_sw === 'I') {
      // initial determination
      this.periodType = 'ID';
      this.initialstartdate = item.start_dt;
    } else if (regex.exec(item.sqnm_sw) !== null) {
      this.periodType = 'RD';
      this.startdatefordetermination = item.start_dt;
      this.enddatefordetermination = item.end_dt;
    } else if (item.sqnm_sw === '18BDAY') {
      this.periodType = 'RD';
      this.showonly18Bday = true;
      // CDM-37158 - For 18 BDAY we need consider 30 days period to generate events
      this.startdatefordetermination = item.start_dt;
      this.enddatefordetermination =  moment(item.start_dt).add(30, 'days').format('YYYY-MM-DDTHH:mm:ss');            
    } else {
      this.periodType = '';
    }

    if(item.sqnm_sw === 'I' || item.sqnm_sw === 'R1' ){
      this.subsequent = false;
    } else {
      this.subsequent = true;
    }
    this.getEligibilityWorksheetData(item);
    const fostercarecasedetails =  this._dataStoreService.getData("fostercarecasedetails"); 
    const selectedComponent = this._dataStoreService.getData("FosterCare_Selected_Component");
    if(fostercarecasedetails) {
      this.clickMatStepper(2, this.stepper);
    } else if (selectedComponent){
      this.clickMatStepper(this._dataStoreService.getData("FosterCare_Selected_Component"), this.stepper);
    } else {
      this.clickMatStepper(1, this.stepper);
    }
  }

  updateVPA(submission: any) {
    const payload = {
      clientId: this.clientId,
      removalReasonTypeKey: _.get(submission, 'reasonforexit') ? _.get(submission, 'reasonforexit') : null,
      returnDate: _.get(submission, 
        'exitcaredatefrompreviousfostercareepisode') ? moment(_.get(submission, 'exitcaredatefrompreviousfostercareepisode')).format('MM-DD-YYYY') : null,
    };
    return this._commonHttpService.update('', payload, Titile4eUrlConfig.EndPoint.updateRemoval);
  }

  updatePlacement() {
    let silaPlacements;
    if (this.show18to21section) {
       silaPlacements = this.placementList.filter((item:any) => item.placement_type === this.silaHomesText && item.isplacementreimbursible === "YES");
       silaPlacements.forEach((element:any) => {
         if (element.effectivedate && element.effectivedate !== this.invalidDate) {
          element.effectivedate = moment(element.effectivedate).format(this.dtformat);  
         } else {
           element.effectivedate = null;
         }
         if (element.healthReportdate && element.healthReportdate !== this.invalidDate) {
          element.healthReportdate = moment(element.healthReportdate).format(this.dtformat);  
         } else {
           element.healthReportdate = null;
         }
       });
    }
    const payload = {
      clientid: this.clientId,
      removalid: this.removalId,
      periodtype: this.periodSqnm,
      islapsesinplacement : this.placement.value.islapsesinplacement,
      typeoflapses : this.placement.value.typeoflapses,
      kindoflapses : this.placement.value.kindoflapses,
      silaplacementchange: silaPlacements

    }
    return this._commonHttpService.update('', payload, Titile4eUrlConfig.EndPoint.placementUpdate);
  }

  updateJudicial(){
    const  dateofreasonableeffortscourthearing:any = this.reasonableeffortsdropdown ? 
                    this.reasonableeffortsdropdown.filter(reasonableeffort => this.legalGroup.value.dateofreasonableeffortscourthearing === reasonableeffort.value) : null;
    const  dateoffindingctwdecision:any =  this.ctwdropdown ? this.ctwdropdown.filter(ctwdecision => this.legalGroup.value.dateoffindingctwdecision === ctwdecision.value) : null;
    const  dateofjudicialfindingofrefpp:any = this.jdrefppdropdown ? this.jdrefppdropdown.filter(jdrefpp => this.legalGroup.value.dateofjudicialfindingofrefpp === jdrefpp.value) : null;
    const  dateofcurrentjudicialfindingofbestinterest :any= this.vpabestinterestdropdown ? 
                    this.vpabestinterestdropdown.filter(vpabestinterest => this.legalGroup.value.dateofcurrentjudicialfindingofbestinterest === vpabestinterest.value): null;
    const dateoffindingctwdecisionvalue:any =  (dateoffindingctwdecision?.length > 0) ? dateoffindingctwdecision[0].text : null ;
    const dateofreasonableeffortscourthearingvalue :any= (dateofreasonableeffortscourthearing?.length > 0) ? dateofreasonableeffortscourthearing[0].text : null;
    const dateofjudicialfindingofrefppvalue = (dateofjudicialfindingofrefpp?.length > 0 ) ? dateofjudicialfindingofrefpp[0].text : null;
    const dateofcurrentjudicialfindingofbestinterestvalue = (dateofcurrentjudicialfindingofbestinterest?.length > 0) ? dateofcurrentjudicialfindingofbestinterest[0].text : null;
    const payload = {
      clientid: this.clientId,
      removalid: this.removalId,
      periodtype: this.periodSqnm,
      dateagencylostlegalresponsibility: this.legalGroup.value.isiveagencyresponsibleforplacementandcare === 'NO' ? this.legalGroup.value.dateagencylostlegalresponsibility : null,
      clientidofsubjectctwfinding: this.legalGroup.value.NameOfSubjectOfCTWFindingGroup,
      nameofsubjectctwfinding: this.legalGroup.value.NameOfSubjectOfCTWFindingGroup ? this.getPersonNameD(this.legalGroup.value.NameOfSubjectOfCTWFindingGroup) : null,
      relationshipofsubjectctwfinding: 1001,
      isiveagencyresponsibleforplacementandcare : this.legalGroup.value.isiveagencyresponsibleforplacementandcare,
      ctwcourtorderid : this.legalGroup.value.dateoffindingctwdecision,
      reasonablecourtorderid : this.legalGroup.value.dateofreasonableeffortscourthearing,
      redetcourtorderid : this.legalGroup.value.dateofcurrentjudicialfindingofbestinterest ? 
                            this.legalGroup.value.dateofcurrentjudicialfindingofbestinterest : this.legalGroup.value.dateofjudicialfindingofrefpp,
      dateofcourthearing : this.legalGroup.controls.dateofcourthearing.value,
      magistrateorjudgename : this.legalGroup.controls.magistrateorjudgename.value,
      issignedbyjudge : this.legalGroup.controls.issignedbyjudge.value,
      ctwdecision : this.legalGroup.value.ctwdecision,
      dateoffindingctwdecision : dateoffindingctwdecisionvalue,
      dateofnexthearing : this.legalGroup.controls.dateofnexthearing.value,
      courtorderdelayremoval : this.legalGroup.controls.courtorderdelayremoval.value,
      courtorderdelaytimedays : this.legalGroup.controls.courtorderdelaytimedays.value,
      typeofcourthearing : this.legalGroup.controls.typeofcourthearing.value ? this.legalGroup.controls.typeofcourthearing.value.toString() : null,
      reasonableeffortsmade : this.legalGroup.controls.reasonableeffortsmade.value,
      dateofreasonableeffortscourthearing : dateofreasonableeffortscourthearingvalue,
      reasonableeffortsnotnecessaryduetoemergentcircumstances : this.legalGroup.controls.reasonableeffortsnotnecessaryduetoemergentcircumstances.value,
      dateofjudicialfindingofrefpp : dateofjudicialfindingofrefppvalue,
      dateofsubsequentjudicialfindingofrefpp : this.legalGroup.controls.dateofsubsequentjudicialfindingofrefpp.value,
      dateofpreviousjudicialfindingofrefpp : this.legalGroup.controls.dateofpreviousjudicialfindingofrefpp.value,
      fostercarepermanencyplandesc : this.legalGroup.controls.fostercarepermanencyplandesc.value,
      fostercarepermanencyplan : this.legalGroup.controls.fostercarepermanencyplan.value,
      dateofcurrentjudicialfindingofbestinterest : dateofcurrentjudicialfindingofbestinterestvalue,
      dateofsubsequentfindingofbestinterest : this.legalGroup.controls.dateofsubsequentfindingofbestinterest.value,
      dateofpreviousbestinterestfinding : this.legalGroup.controls.dateofpreviousbestinterestfinding.value
    };
    return this._commonHttpService.update('', payload, Titile4eUrlConfig.EndPoint.judicial);
  }

  updateDeprivation(submission: any) {
    const payload = submission.map((data: any) => {
      const childdeprivedofparentalsupportvalue = this.returnChilddeprivedofparentalsupportvalueFN(data);
      const unemploymentorunderemploymentvalue = this.returnUnemploymentorunderemploymentvalueFn(data);
      const deprivationfactorvalue = this.returnDeprivationfactorvalueFn(data);
      const reasonforabsencevalue = this.returnReasonforabsencevalueFn(data);
      const dateofparentdeathvalue = this.returnDateofparentdeathvalueFn(data);
      const incarcerationdatevalue = this.returnIncarcerationdatevalueFn(data);
      if (data.deprivationParentId) {
      const deprivationdata = {
        clientId: this.clientId,
        removalid: this.removalId,
        parentid: data.deprivationParentId,
        relationship: _.get(this.personsList, `${data.deprivationParentId}.relationship`),
        relationshiptochild: _.get(this.personsList, `${data.deprivationParentId}.relationcheck`),
        childdeprivedofparentalsupport: childdeprivedofparentalsupportvalue,
        isunemployment: unemploymentorunderemploymentvalue,
        deprivationtype: deprivationfactorvalue,
        reasonforabsence: reasonforabsencevalue,
        dateofparentdeath: dateofparentdeathvalue,
        dateofincarceration: incarcerationdatevalue,
        nameofhouseholdmember: _.get(this.personsList, `${data.deprivationParentId}.name`),
      };
      if (_.has(data, 'ivepersondeprivationid') && !_.isEmpty(data.ivepersondeprivationid)) {
        (deprivationdata as any)['ivepersondeprivationid'] = data.ivepersondeprivationid;
      }
      return deprivationdata;
      }
    });
    if (payload && payload.length && payload[0] !== undefined && payload[0] !== null) {
        return this._commonHttpService.create(payload, Titile4eUrlConfig.EndPoint.deprivationUpdate);
    }
    return null;
  }

  private returnIncarcerationdatevalueFn(data: any) {
    return data.incarcerationdate ? data.incarcerationdate : null;
  }

  private returnDateofparentdeathvalueFn(data: any) {
    return data.dateofparentdeath ? data.dateofparentdeath : null;
  }

  private returnReasonforabsencevalueFn(data: any) {
    return data.reasonforabsence ? data.reasonforabsence : null;
  }

  private returnDeprivationfactorvalueFn(data: any) {
    return data.deprivationfactor ? data.deprivationfactor : null;
  }

  private returnUnemploymentorunderemploymentvalueFn(data: any) {
    return data.unemploymentorunderemployment ? data.unemploymentorunderemployment : null;
  }

  private returnChilddeprivedofparentalsupportvalueFN(data: any) {
    return data.childdeprivedofparentalsupport ? data.childdeprivedofparentalsupport : null;
  }

  updateHouseHoldIncome(submission: any) {
    const incomeType = submission.map((household: any) => {
      if (household.involvedclientid) {
          if (household.name.includes('\'')) {
            if (this.personsList[household.involvedclientid]) {
              this.personsList[household.involvedclientid].name = household.name.split('\'')[0] + household.name.split('\'')[1];
            } 
          }
          if (this.initialstartdate && this.personsList[household.involvedclientid] ) {
              const initialstartdateconversion = moment(this.initialstartdate);
              const datebirthofmember = moment(this.personsList[household.involvedclientid].dateofbirthforincome);
              this.ageforoutputform =  initialstartdateconversion.diff(datebirthofmember, 'years');
          }
          const householddata:any = this.returnHouseholddataFn(household);
              if (_.has(household, 'ivepersonincomeid') && !_.isEmpty(household.ivepersonincomeid)) {
                  householddata['ivepersonincomeid'] = household.ivepersonincomeid;
              }
              return householddata;
          }
          return household;
    });

    const payload = {
      clientId: this.clientId,
      removalid: this.removalId,
      incomeType: incomeType
    };

    return this._commonHttpService.create(payload, Titile4eUrlConfig.EndPoint.saveIncomeSummary);
  }
  // Associated with updateHouseHoldIncome function
  private returnHouseholddataFn(household: any) {
    return {
      clientId: this.clientId,
      removalid: this.removalId,
      involvedClientId: household.involvedclientid,
      involvedClientName: this.personsList[household.involvedclientid] ? this.personsList[household.involvedclientid].name : '',
      assistanceUnit: household.assistanceunit ? household.assistanceunit : 'NO',
      deemedIncome: household.deemedincome ? 'YES' : 'NO',
      earnedIncomeNo: household.earnedincomeno,
      disregardEarnedIncome: household.disregardearnedincome ? 'YES' : 'NO',
      unearnedIncome: household.income,
      relationshipstatus: this.personsList[household.involvedclientid] ? this.personsList[household.involvedclientid].relationcheck : '',
      dateofbirthforincome: this.ageforoutputform ? this.ageforoutputform : null,
    };
  }

  updateIncomeAndAssetsSummary() {
    if (this.scheduleHLookUp || this.scheduleHLookUpForNotInAU) {
     const payload = {
       ...this.updateIncomeAndAssetsSummaryDataFn(),
      clientId: this.clientId,
      removalid: this.removalId,
      // ivepersondeprivationid: FileUtils.newGuid(),
      assetsallowance: 0, // Needs to be calcualted
      assetsmarketvalue: 0,
      childcarecost:  this.afdc.value.costChild ? this.afdc.value.costChild : 0,
      afdceligibilitymonth:  this.afdc.value.afdceligibilitymonth ? this.afdc.value.afdceligibilitymonth : null,
  };
        return this._commonHttpService.create(payload, Titile4eUrlConfig.EndPoint.incomeUpdate);
   }
   return null;
  }
  // Associated with updateIncomeAndAssetsSummary function
  private updateIncomeAndAssetsSummaryDataFn() {
    return {
      assistanceunitno: this.scheduleHLookUp ? (this.scheduleHLookUp.familysize || 0) : 0,
      notinassistanceunitno: this.scheduleHLookUpForNotInAU ? (this.scheduleHLookUpForNotInAU.familysize || 0) : 0,
      standardunitno: this.scheduleHLookUp ? (this.scheduleHLookUp.standardofneed || 0) : 0,
      notinstandardunitno: this.scheduleHLookUpForNotInAU ? (this.scheduleHLookUpForNotInAU.standardofneed || 0) : 0,
      grossincome185pcunitno: this.scheduleHLookUp ? (this.scheduleHLookUp.grossincomeoneeightyfive || 0) : 0
    };
  }

  updateSpecifiedRelatives(submission: any) {

    const payload = submission.map((data: any) => {
      return {
        clientId: this.clientId,
        removalid: this.removalId,
        specifiedrelativeid: data.sepecifiedrelativeuniqid || FileUtils.newGuid(),
        specifiedrelativeclientid: data.specifiedrelativename,
        specifiedrelativedatechildlastlivedwith: data.specifiedrelativedatechildlastlivedwith ? data.specifiedrelativedatechildlastlivedwith : null ,
        specifiedrelativename: _.get(this.personsList, `${data.specifiedrelativename}.name`),
        relationshiptochild: _.get(this.personsList, `${data.specifiedrelativename}.relationcheck`),
        specifiedrelativephysicaladdress: data.specifiedrelativephysicaladdress.trim(),
        specifiedrelativerelationshipid: this.get4eRelationId(data.specifiedrelativename),
      }
    });

    if (payload && payload.length && payload[0] !== undefined && payload[0] !== null) {
        return this._commonHttpService.create(payload, Titile4eUrlConfig.EndPoint.saveSpecificRelative);
    }
    return null;
  }

  updateSSISSAData(data: any) {
    const payload = {
      clientId: this.clientId,
      removalid: this.removalId,
      ischildageabove18: data.ischildageabove18,
      childReceivingSsiOrSsa:  Number(data.childreceivingssiorssa),
      agencyRepresentativeFlag: Number(data.agencyrepresentativeflag),
      noteForAgencyNotAsPayee: data.reasonforagencynotrepresentativepayee,
      representativePayee: data.whoisrepresentativepayee,
      suspendSsiPaymentFlag: Number(data.suspendssipaymentflag),
      noteForNotSuspendingSsi: data.reasonfornotsuspendingssipayment,
      dateofmedicaldetermination: data.dateofmedicaldetermination ? data.dateofmedicaldetermination : null ,
      doesagencyhasmedicaldocstostateincapabilityofchild: data.doesagencyhasmedicaldocstostateincapabilityofchild,
      hasagencyapplytobecomerepresentativepayee:  Number(data.hasagencyapplytobecomerepresentativepayee),
      dateofapplicationtobecomerepresentativepayee: data.dateofapplicationtobecomerepresentativepayee ? data.dateofapplicationtobecomerepresentativepayee : null,
      dateofrequesttosuspendthessipaymentandclaimive: data.dateofrequesttosuspendthessipaymentandclaimive ? data.dateofrequesttosuspendthessipaymentandclaimive : null,
      typeofbenefit: data.typeofbenefit,
      amountofbenefit: data.amountofbenefit,
      detperiodtype: this.periodSqnm,
      infoaboutincomenresources: data.infoaboutincomenresources,
      incomeresourcesverification: data.incomeresourcesverification,
      issillaagreementvalid: data.isSilaAgreementValid,
      issilayouth:data.isSilaYouth,
      silaagreementdate: data.silaAgreementDate ? data.silaAgreementDate : null,
      citizenshipverification: data.citizenshipverification,
      ageverification: data.ageverification,
      assetinfoverification: data.assetinfoverification,
      ssissainfoverification: data.ssissainfoverification,
      homeassessmentverification: data.homeassessmentverification,
      vpasprverification: data.vpasprverification,
    }

    return this._commonHttpService.create(payload, Titile4eUrlConfig.EndPoint.ssiSsaUpdate);
  }

  populatePlacementInfo(worksheetData:any) {
    this.placementList = [];
    if (worksheetData.data && worksheetData.placementInfo && _.isArray(worksheetData.placementInfo)) {
      const placementTypes = {
        PLTR: 'Placement',
        LA: 'Living'
      };
      if (worksheetData.placementInfo && worksheetData.placementInfo.length) {
        if (worksheetData.placementInfo[0]) {
          this.placement.patchValue(worksheetData.placementInfo[0]);
          if (worksheetData.placementInfo[0].placement && worksheetData.placementInfo[0].placement.length) {
            this.checkPlacementidFn(worksheetData, placementTypes);
          }
        }
      }
    }
  }
  // Associated with populatePlacementInfo function
  private checkPlacementidFn(worksheetData: any, placementTypes: any) {
    worksheetData.placementInfo[0].placement.forEach((element:any) => {
      const silaPlacementInfo = worksheetData.placementInfo[0].silaplacementchange;
      if (element.placementid) {
        if (element && element.placement_type && element.placement_type == this.silaHomesText) {
          element = this.ifPlacementTypeConditionFn(silaPlacementInfo, element);
        }

        this.placementList.push(this.returnPlacementListDataFn(element, placementTypes));

        this.atleastOnesilaplacement = this.placementList.some((item) => item.placement_type == this.silaHomesText && item.isplacementreimbursible == 'YES');
      }
    });
  }
  private ifPlacementTypeConditionFn(silaPlacementInfo: any, element: any) {
    if (silaPlacementInfo && silaPlacementInfo.length) {
      const currSilaplacement = silaPlacementInfo.find((sila:any) => sila.placementid == element.placementid);
      if (currSilaplacement) {
        element = currSilaplacement;
      }
    }
    if (new Date(element.start_dt) <= new Date(this.startdatefordetermination)) {
      element.silaMinDate = this.startdatefordetermination;
    }
    if ((new Date(element.end_dt) >= new Date(this.enddatefordetermination)) || !element.end_dt) {
      element.silaMaxDate = this.enddatefordetermination;
    } else {
      element.silaMaxDate = element.end_dt;
    }
    return element;
  }

  // Associated with populatePlacementInfo function
  private returnPlacementListDataFn(element: any, placementTypes: any): any {
    return {
      placementid: element.placementid ? element.placementid : null,
      livingarrangementtype: _.get(placementTypes, element.livingarrangementtype),
      placement_type: element.placement_type ? element.placement_type : null,
      isplacementreimbursible: element.isplacementreimbursible === 'Y' || element.isplacementreimbursible === 'YES' ? 'YES' : 'NO',
      islivingarrangementsameasplacement: this.returnIslivingarrangementsameasplacementCondFn(element),
      start_dt: element.start_dt ? element.start_dt : null,
      end_dt: element.end_dt ? element.end_dt : null,
      silaMinDate: element.silaMinDate ? element.silaMinDate : element.start_dt,
      silaMaxDate: element.silaMaxDate ? element.silaMaxDate : null,
      effectivedate: element.effectivedate && element.effectivedate !== this.invalidDate ? new Date(element.effectivedate) : null,
      isValidHomeHealth: element.isValidHomeHealth === 'Y' || element.isValidHomeHealth === 'YES' ? 'YES' : 'NO',
      healthReportdate: this.returnHealthReportdateFn(element),
      provider_nm: this.returnproviderNmFn(element),
      provider_address: element.provider_address ? element.provider_address : null
    };
  }
  // Associated with populatePlacementInfo function
  private returnIslivingarrangementsameasplacementCondFn(element: any) {
    return element.livingarrangementtype === 'PLTR' ? 'YES' : this.returnIslivingarrangementsameasplacementFalseCondFn(element);
  }
  // Associated with populatePlacementInfo function
  private returnHealthReportdateFn(element: any) {
    return element.healthReportdate && element.healthReportdate !== this.invalidDate ? new Date(element.healthReportdate) : null;
  }
  // Associated with populatePlacementInfo function
  private returnproviderNmFn(element: any) {
    return (element.provider_nm ? `${element.provider_nm.split('-')[1]} - ${element.provider_nm.split('-')[0]}` : null);
  }
  // Associated with populatePlacementInfo function
  private returnIslivingarrangementsameasplacementFalseCondFn(element: any) {
    return (element.livingarrangementtype === 'LA' ? 'NO' : null);
  }

  onItemReimbursible($event:any, i:any, selection:any) {
    this.placementList[i].isplacementreimbursible = $event.value;
    if ($event.value === 'NO') {
      this.placementList[i].effectivedate = null;
      this.placementList[i].healthReportdate = null;
      this.atleastOnesilaplacement = false;
    } else if($event.value === 'YES' && this.placementList[i].placement_type === this.silaHomesText) {
       this.atleastOnesilaplacement = true;
    }
    selection.close();
  }

  didChangeDate($event:any, index:any, selection:any, field:any) {
    if ($event.value) {
      this.placementList[index][field] = $event.value;
    } else {
      this.placementList[index][field] = null;

    }
    selection.close();
  }

  onValidHealthChange($event:any, i:any, selection:any) {
    this.placementList[i].isValidHomeHealth = $event.value;
    if ($event.value === 'NO') {
      this.placementList[i].healthReportdate = null;
    }
    selection.close();
  }

  populateOtherCriteria(worksheetData:any) {
    if (worksheetData.data) {
      this.other.patchValue(worksheetData.data);
    }
  }

  onPageChange(e:any) {
    this.tempList = this.placementList.slice(e.pageIndex * e.pageSize,(e.pageIndex + 1) *e.pageSize);
  }

  getErrorsMessage(ControlName:any, displayName:any){
    if(this.legalGroup.controls[ControlName].status ==='INVALID' ){
      return this.pleaseselecterrmsg + displayName;
    }//SonarQube fix - Refactor this function to use "return" consistently.
    return undefined;
  }

  getErrorsMessageEnter(ControlName:any, displayName:any){
    if(this.other.controls[ControlName].status ==='INVALID' ){
      return (ControlName==='infoaboutincomenresources'?this.pleaseselecterrmsg:'Please enter valid ') + displayName;
    }//SonarQube fix - Refactor this function to use "return" consistently.
    return undefined;
  }
  getErrorsMessageafdc(ControlName: any, displayName: any){
    if(this.afdc.controls[ControlName].status ==='INVALID' ){
      return this.pleaseselecterrmsg + displayName;
    }//SonarQube fix - Refactor this function to use "return" consistently.
    return undefined;
  }
  getErrorsMessagePlacement(ControlName: any, displayName: any){
    if(this.placement.controls[ControlName].status ==='INVALID' ){
      return this.pleaseselecterrmsg + displayName;
    }//SonarQube fix - Refactor this function to use "return" consistently.
    return undefined;
  }
  silaYouthchange(event:any){
    if(event === 'NO') {
      this.other.patchValue({
        isSilaAgreementValid :'NO',
      });
    } else {
      this.other.patchValue({
        isSilaAgreementValid :null,
      });
    }

  }

  getAfdcData(name: string): any[] {
    return Object.values((this.afdc.get(name) as FormGroup).controls);
  }

  setMonthAndYear(normalizedMonthAndYear: any, datepicker: MatDatepicker<any>) {
    this.afdc.patchValue({
      afdceligibilitymonth: normalizedMonthAndYear
    });
    datepicker.close();
  }
}

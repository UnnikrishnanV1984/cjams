
import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { DataStoreService } from '../../../../../@core/services/data-store.service';
import { FormBuilder, FormGroup, ValidationErrors, Validators } from '@angular/forms';
import { AlertService, CommonHttpService, AuthService, GlobalPopupService, SessionStorageService } from '../../../../../@core/services';
import { forkJoin ,  Observable } from 'rxjs';
import { DropdownModel, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { MyNewintakeConstants } from '../../../../newintake/my-newintake/my-newintake.constants';
import { Medication, Health } from '../../../involved-persons/_entities/involvedperson.data.model';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { PersonHealthService } from '../person-health.service';
import { PersonInfoService } from '../../person-info.service';
import _ from 'lodash';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import moment from 'moment';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CommonUrlConfig } from '../../../../../../app/@core/common/URLs/common-url.config';
import { QueryType } from '../../../../../../app/@core/common/models/person-health-summary.model';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'medication-including-psychotropic-cw',
    templateUrl: './medication-including-psychotropic-cw.component.html',
    styleUrls: ['./medication-including-psychotropic-cw.component.scss'],
    standalone: false
})
export class MedicationIncludingPsychotropicCwComponent implements OnInit {
  medicationpsychotropicForm!: FormGroup;
  healthCareDecisionMakerForm!: FormGroup;
  healthcaredecisionmakerinformationid1: any;
  healthcaredecisionmakerinformationid2: any;
  isRequiredParentOrLegalGuardianSection: boolean = false;
  showauditloghcdm: boolean = false;
  deletedAnotherHealthCare: boolean = false;
  getlatesthealthcareupdate: boolean = false;
  showsecondaryreviewcompleted: any = 0;
  showallotherfiled: boolean = false;
  secondaryreviewdosage: any;
  showcompletesecondary: boolean = false;
  showAdditionalfields: boolean = true;
  disablebutton: boolean = false;
  showaddotherfild: boolean = false;
  disablecheckboxtraget: boolean = false;
  isRequiredParentOrLegalGuardianButton: boolean = false;
  defaultMedication: any;
  psychotropiccounty: any;
  countylivedate: any;
  auditTrailhcdmdata: any;
  editshowauditTrailhcdm: boolean = false;
  countyname: any;
  showhcdmtaboncounty: boolean = false;
  deleteParentOrLegalGuardianButton: boolean = false;
  modalInt!: number;
  editMode!: boolean;
  isLoading!: boolean;
 showgetLatestbutton: boolean = false;
  renewaledit!: boolean;
  reportMode!: string;
  informedconsentList:any=[];
  selectedMedication: any;
  medicationpsychotropic: Medication[] = [];
  medicationpsychotropicHistory: any =[];
  health: Health = {};
  medicationType$!: Observable<DropdownModel[]>;
  medicationType: any = [];
  isMedicationIncludes!: boolean;
  constants = MyNewintakeConstants.Intake.PersonsInvolved.Health;
  prescriptionReasonType$!: Observable<DropdownModel[]>;
  informationSourceType$!: Observable<DropdownModel[]>;
  HealthCareDecisionDropdownItems$!: Observable<DropdownModel[]>;
  AuthorizedHcdmDropdownItems$!: Observable<DropdownModel[]>;
  frequency$!: Observable<DropdownModel[]>;
  targetedsymptoms$!: Observable<DropdownModel[]>;
  informedconsent$!: Observable<DropdownModel[]>;
  frequencydropdown: any[] = [];
  medicationClassification: any[] = [];
  prescribedDuration$!: Observable<DropdownModel[]>;
  diagnosislist$!: Observable<DropdownModel[]>;
  medicationsettinglist$!: Observable<DropdownModel[]>;
  psychosocialintervention$!: Observable<DropdownModel[]>;
  psychosocialinterventionlist: DropdownModel[] = [];
  diagnosislist: DropdownModel[] = [];
  prescriberspeciality$!: Observable<DropdownModel[]>;
  prescriberdegree$!: Observable<DropdownModel[]>;
  medicationClassification$!: Observable<DropdownModel[]>;
  maxDate = new Date();
  teamTypeKey!: string;
  isAddEdit = false;
  Psychotropicid :any;
  selectinformedconsentList:any;
  targetedsymptomsList:any;
  selecttargetedsymptomsList:any;
  isview=false;
  psyedit =false;
  uploadedfilesEdit:any;
  personId!: string;
  editModehdmc: boolean=false;
  showselectedMedicationbutton: boolean=false;
  uploadedFiles: any[] = [];
 pandldelete: boolean=false;
  uploadNumber = '123434';
  personmedicpshychotropicid: any;
  psychotropicpersonmedidocumentlist:any;
  dtDisable = false;
  isrenewal=false;
  mandatoryField:boolean=false;
  reasonPrescribed:boolean=false;
  newpsychotropic:boolean=false;
  expirationDate:boolean=false;
  targetedOthervalidation:boolean=false;
  isClosed = false;
  isHistoricalMedication: boolean = false;
  isPsychotropic=false;
  latesthealthcareflg:boolean=false;
  isChangeOfMedication = false;
  targetedSymptomscheck=false;
  docselect: any[] =[];
  totalRecords = 0;
  deleteItem: any;
  RenewalItem:any;
  renewalpshychotropicid:any;
  isRefill:any = false;
  selectRowIndex: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  suggestedMedicine$!: Observable<any[]>;
  suggestions: any;
  suggestedMedicine: any;
  psychotropicmedicationshealthcaredecision :any;
  hcdmfromcourt :any;
  ismedicationpsychotropic:boolean=true;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  load:boolean = false;
  completesecondary:boolean = false;
  medication :any;
  showsecondarylist:boolean =false;
  disablesecondary:boolean = false;
  showotherdiagnosis:boolean = false;
  showotherprescriberdegree:boolean = false;
  isldss:boolean = false;
  healthcaredecisionmakerinformationidhcdmflag0Fields:any=null;
  deletehdcm:boolean = false;
  getlatesthealthcareupdatedelete:boolean = false;
  secondaryreview :boolean = false;
  showotherprescriberspeciality :boolean = false;
  showotheraddpsychosocial:boolean = false;
  backbutton:boolean = false;
  hasremoval: boolean = false;
  gettypesurl = 'referencetype/gettypes';
  deletepopupid = '#delete-popup';
  secondaryreviewpopupid ='#secondaryreviewpopupid';
  renewalpopupid = '#renewal-popup';
  hourList: any[] = [];
  hourSpecifydurationList: any[] = [];
  filterFrequencyHourSugg: any[] = [];
  filterSpecifyHourSugg: any[] = [];
  id!: string;
  hasFamilyAccessToCase: boolean = false;
  caseId!: string;
  isNavgToMdPsyPage: boolean = false;
  address: any = {  disable: false, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
  address2: any = {  disable: false, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
  retrydoc: any = false;
  medicationListCheck: any;
  medicationid: any;
  MedicationPsychotropicColumns!: string[];
 
    MedicationPsychotropicKeys!: string[];
    refillmedication:  Medication[] = [];
    
   minwidthstyle = 'min-width-120';
   mednamewidthstyle ='min-width-220';
   tdminwidthstyle ='td-width-style';
     styles: any = {
      
    "Medication Name": {'thStyleClassName': this.minwidthstyle  ,'tdStyleClassName':this.tdminwidthstyle,'filterIconClassName':'top-10'},
     "Frequency":{'thStyleClassName': 'min-width-80','tdStyleClassName':'min-width-80','filterIconClassName':'top-10'},
      "Dosage":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.tdminwidthstyle,'filterIconClassName':'top-10'},
     "Updated By":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.tdminwidthstyle,'filterIconClassName':'top-10'},
     "Updated On":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.tdminwidthstyle,'filterIconClassName':'top-10'},
     "Date Prescribed":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.tdminwidthstyle,'filterIconClassName':'top-10'},
    "Date Medication Started":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.tdminwidthstyle,'filterIconClassName':'top-10'},
    "Date Discontinued":{'thStyleClassName': this.minwidthstyle,'tdStyleClassName':this.tdminwidthstyle,'filterIconClassName':'top-10'},
     "Action":{'thStyleClassName': '','tdStyleClassName':'','filterIconClassName':''},
  };
                   
     
  isAllchecked: boolean = false;
  medicationpsychotropicData: Medication[] = [];
  htmlColumns: string[] = ['View'];
  unsortablecolumnlist: string[] = [];
  personmedicpshychotropicparentid:any;


  private formbulider: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _authService: AuthService;
  private sessionStorage: SessionStorageService;
  private _personInfoService: PersonInfoService;
  private _globalPopupService: GlobalPopupService;
  private route: ActivatedRoute;
  searchandsortquery: any;
  datediscontinued: any;
  refilldata: any;
  


  constructor(private injector: Injector ,private router: Router
    ){
    this.sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
    this.formbulider = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._globalPopupService = this.injector.get<GlobalPopupService>(GlobalPopupService);
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.medicationid = params['retryid'];
    });
     }

  ngOnInit() {

    this.isNavgToMdPsyPage = JSON.parse(localStorage.getItem('IsNavigateToMedPsy') || 'false');
    if (this.isNavgToMdPsyPage) {
      const navigationInfoData: any = localStorage.getItem('navigationInfo');
      const personinfo = JSON.parse(navigationInfoData);
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.DA_NUMBER, personinfo?.data?.caseNumber);
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, personinfo?.sourceID);
      this.id = personinfo?.sourceID;
    }


    this.hourList = [];
    for(let i=1; i<=24;i++) {
      this.hourList.push(i+ ((i==1) ? ' Hr' : ' Hrs'));
    }
    this.hourSpecifydurationList = [];
    for(let i=1; i<=1000;i++) {
      this.hourSpecifydurationList.push(i);
    }
    this.personId =  this._personInfoService.getPersonId();
    this.hasremoval = this._personInfoService.personInfo?.personbasicdetails?.hasremoval;
    this.teamTypeKey = this._authService.getAgencyName();
    this.caseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.loadDropDowns();
    this.getUserCounty()
    this.suggestMedicine();
    this.editMode = false;
    this.modalInt = -1;
    this.reportMode = 'add';
    this.isMedicationIncludes = false;
    this.healthCareDecisionMakerForm = this.formbulider.group({
      healthcaredecision1: [{ value: '', disabled: false}],
      name1: [{ value: '', disabled: false }],
      authorizedhcdm1: [{ value: '', disabled: false }],
      email1: [{ value: '', disabled: false }],
      phone1: [{ value: '', disabled: false }],
      hcdmOther1: [{ value: '', disabled: false }],
      healthcaredecision2: [{ value: '', disabled: false }],
      name2: [{ value: '', disabled: false }],
      authorizedhcdm2: [{ value: '', disabled: false }],
      email2: [{ value: '', disabled: false }],
      phone2: [{ value: '', disabled: false }],
      hcdmOther2: [{ value: '', disabled: false }],
      courtorderid2: [{ value: '', disabled: false }],
      courtorderid1: [{ value: '', disabled: false }],
  });
    this. InitialiseFormGroup();
    this.isClosed = this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person','person.Health.psychotropicadd');
    
    this.paginationInfo.pageNumber = 1;
    this.paginationInfo.pageSize = 10;
     this.searchandsortquery = {};
    this.getAssignmentsList();
    this.getMedicationPsychotropicList('init');
    this.route.queryParams.subscribe(params => {
      const status = params['medication'];
      if (status) {
        const medication = JSON.parse(this._dataStoreService.getData('medication-health-summary'));
        this.view(medication,1);
      }
    
    });

    if (this.isNavgToMdPsyPage) {
      this.addMedicationPsychotropic();
      setTimeout(() => {
        this.medicationpsychotropicForm.get('isprescribedmedication')?.setValue('true');
        this.ismedication(true); 
      }, 1000);
    }

  }

  InitialiseFormGroup() {
    this.medicationpsychotropicForm = MedicationIncludingPsychotropicCwComponent.createForm(this.formbulider);
  }

  static createForm(fb: FormBuilder): FormGroup {
    return fb.group({
       isprescribedmedication: [null, [Validators.required]],
       ismedicationpsychotropic :[null],
       secondaryreviewcompleted:[null],
       pshychotropicid:[null],
       classification:[null],
       medicationname: ['', Validators.required],
       prescribedreason: '',
       medicationtype: '',
       dosage: '',
       diagnosis:'',
       frequency: '',
       targetedsymptoms:'',
       targetedother:'',
       informedconsent:'',
       renewal:'',
       compliant: '',
       compliantcomments: '',
       dateofrefill: '',
       informationsourcetypekey: '',
       lastdosetakendate: [null],
       datemedicationstarted: [null],
       isprescribercheck:'',
      medicationeffectivedate: [null],
      medicationexpirationdate: null, 
      prescribingdoctor: '',
      prescriptionreasontypekey: '',
      medicationcomments: '',
      reportedby: [''],
      otherreason: '',
      prescribedduration: '',
      username :'',
      changeofdate: '',
      specifyfrequencyhour: '',
      specifyduration: '',
      otherspecifyduration: '',
       diagnosisfromsecond :'',
         diagnosisotherfromsecond:'',
          psychosocialinterventions:'',
          additionalpsychosocialinterventions:'',
        otheradditionalpsychosocialinterventions:'',
          prescribercontactinfo:'',
          prescriberemail:'',
         prescriberdegree:'',
         prescriberspecialty:'',
          otherprescriberspecialty:'',
         settingmedicationprescribed:'',
         otherprescriberdegree:''
    });
   }
   disablemedicationname(){
     if (this.disablesecondary || this.isChangeOfMedication || this.isRefill) {
      this.medicationpsychotropicForm.controls.medicationname.disable();
return true;
     }else{
       return false;
     }
   }
   updateTooltip() {
    
    let selectedValues= this.medicationpsychotropicForm?.controls['targetedsymptoms']?.value
    if(selectedValues){
    const selectedSymptoms = selectedValues?.map((val: any) => 
      this.targetedsymptomsList?.find((item: any) => item?.value === val)?.text
    ).filter((text: any) => text != null);
    
    return selectedSymptoms.join(', ') ;}
    else{
      return null
    }
  }
  psychosocialTooltip() {
    
    let selectedValues= this.medicationpsychotropicForm?.controls['additionalpsychosocialinterventions']?.value
    if(selectedValues){
    const selectedSymptoms = selectedValues?.map((val: any) => 
      this.psychosocialinterventionlist?.find((item: any) => item?.value === val)?.text
    ).filter((text: any) => text != null);
    
    return selectedSymptoms.join(', ') ;}
    else{
      return null
    }
  }

  auditTrailhcdm(){
      (<any>$('#audittrailloghcdm')).modal('show');
  }

  auditTrailhcdmcheck(courtorderid: any){
    this._commonHttpService.getArrayList(
      {
          where: { objectid: courtorderid },
          method: 'post',
          nolimit: true  
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.MedicationPsychotopic.auditTrailhcdm + '?filter'
      
  ).subscribe((response: any) => {
     
      this.auditTrailhcdmdata  = response[0].getaudittrailhcdm;
      if(this.auditTrailhcdmdata && this.auditTrailhcdmdata[1])
            {
              this.editshowauditTrailhcdm=true;
            }else{
              this.editshowauditTrailhcdm=false;
            }
  });
  }

  mentalUpdateTooltip(){
    
    let selectedValues= this.medicationpsychotropicForm?.controls['diagnosisfromsecond']?.value
    if(selectedValues){
    const selectedSymptoms = selectedValues?.map((val: any) => 
    this.diagnosislist?.find((item: any) => item?.value === val)?.text
    ).filter((text: any) => text != null);
    
    return selectedSymptoms.join(', ') ;}
    else{
      return null
    }
  }

  ngOnDestroy() {
    this._healthService.renewalflag= false;
    this.addConditionsAudit('leave-from-medication-psychotropic');
    localStorage.setItem('IsNavigateToMedPsy', JSON.stringify(false));
  }

  doccheckedList(event: any){
    const event1=event.filter((ele: any) => !this.uploadedFiles.find(val=>val.ecmsdocumentid==ele.ecmsdocumentid))
      this.uploadedFiles =[...this.uploadedFiles,...event1];
      if(event1.length!==0){
        this.medicationpsychotropicForm.markAsDirty();
      }
  }
  uploadclosed(event: any){
    if(event){
    this.documentuploaded.closeupload();
    this.load = true;
    }
    setTimeout(()=>{
      if(this.uploadedFiles?.length != this.uploadedfilesEdit?.length){
        this.medicationpsychotropicForm.markAsDirty();
      }else{
      const difference = this.uploadedfilesEdit.reduce((result: any, element: { documentpropertiesid: any; }) => {
        if (this.uploadedFiles.findIndex(value=>value.documentpropertiesid==element.documentpropertiesid) === -1) {
            result.push(element);
        }
        return result;
    }, []);
    if(difference.length>0){
      this.medicationpsychotropicForm.markAsDirty();
     }}
  
    })
    if(this.uploadedFiles){
      this.editMode = true;
      this.medicationpsychotropicForm.markAllAsTouched();
    }
  }

  updateLoad() {
    this.load = false;
  }
  getUserCounty() {
       
    const filter: any = {};
    this._commonHttpService
    
        .getAll(CaseWorkerUrlConfig.EndPoint.DSDSAction.MedicationPsychotopic.getusercounty + encodeURIComponent(JSON.stringify(filter)))
        .subscribe(res => {
            if (res && res.length > 0) {
               const userCounty = res[0];
               this.countyname = userCounty.countyname;
                this.getpsychotropiccounty();
            }
        });
}
  getpsychotropiccounty(){
        
          

    this._commonHttpService.getArrayList(
      {
        where: { objecttype: 'psycotrophic-hcdm' },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.MedicationPsychotopic.getcountygoliveconfig + '?filter'
    ).subscribe(response => {
      this.psychotropiccounty = response[0];
      const normalizedCounty = this.countyname?.replace(/[.\s']/g, '').toLowerCase();
      let countyDate = this.psychotropiccounty[normalizedCounty];
      if (countyDate && moment(countyDate).isSameOrBefore(moment(), 'day')) {
        this.countylivedate = countyDate;
        this.showhcdmtaboncounty = true;
      } else {
        const statewideDate = this.psychotropiccounty?.statewide;
        if (statewideDate && moment(statewideDate).isSameOrBefore(moment(), 'day')) {
          this.countylivedate = statewideDate;
          this.showhcdmtaboncounty = true;
        }
      }
    });
  
  }
  ismedication(opt: any) {
    this.enableorDisableField('medicationname', opt);
    this.enableorDisableField('lastdosetakendate', opt);
    if(opt){
      this.healthCareDecisionMakerForm.controls['name1'].setValidators(Validators.required);
    }else{
      this.healthCareDecisionMakerForm.controls['name1'].clearValidators();
      this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].clearValidators();
      this.medicationpsychotropicForm.controls['prescribingdoctor'].clearValidators();
      this.medicationpsychotropicForm.controls['ismedicationpsychotropic'].clearValidators();
      this.medicationpsychotropicForm.controls['medicationeffectivedate'].clearValidators();
      this.medicationpsychotropicForm.controls['frequency'].clearValidators();
      this.medicationpsychotropicForm.controls['dosage'].clearValidators();
      this.medicationpsychotropicForm.controls['diagnosis'].clearValidators();
      this.medicationpsychotropicForm.controls['informedconsent'].clearValidators();
      this.medicationpsychotropicForm.controls['classification'].clearValidators();
      this.medicationpsychotropicForm.controls['targetedsymptoms'].clearValidators();
      
    }
    if(opt && this.newpsychotropic && !this.isview && !this.psyedit ){
      this.gethcdmfromcourt();
      this.healthCareDecisionMakerForm.controls['name1'].setValidators(Validators.required);
      if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='PAR'){
        this.isRequiredParentOrLegalGuardianSection=true;
      }else{this.isRequiredParentOrLegalGuardianSection=false;}
     
    }else{
      this.healthCareDecisionMakerForm.controls['name1'].clearValidators();
    }

    this.isMedicationIncludes = opt;
    this.medicationpsychotropicForm.reset();
    this.medicationpsychotropicForm.patchValue({ 'isprescribedmedication': opt });
  }

  private enableorDisableField(field: any, opt: any) {
    if (opt) {
      this.medicationpsychotropicForm.get(field)?.enable();
      this.medicationpsychotropicForm.get(field)?.updateValueAndValidity();
    } else {
      this.medicationpsychotropicForm.get(field)?.disable();
      this.medicationpsychotropicForm.get(field)?.clearValidators();
      this.medicationpsychotropicForm.get(field)?.updateValueAndValidity();
    }
  }
  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          where: { activeflag: 1 },
          method: 'get',
          nolimit: true
        },
        NewUrlConfig.EndPoint.Intake.prescriptionreasontype + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        NewUrlConfig.EndPoint.Intake.informationsourcetype + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          order: 'description'
        },
        NewUrlConfig.EndPoint.Intake.medicationtype + '?filter'
      ),
      this._commonHttpService
      .getArrayList(
          {
              where: { "tablename":"frequencytype", "teamtypekey": this.teamTypeKey },
              method: 'get'
          },
          this.gettypesurl + '?filter'
      ),
      this._commonHttpService
      .getArrayList(
        {
            where: { referencetypeid: 334, teamtypekey: this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
      ),
      this._commonHttpService
      .getArrayList(
        {
            where: { referencetypeid: 339, teamtypekey: this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
      ),
      this._commonHttpService
      .getArrayList(
          {
              where: { "tablename":"targetedsymptoms", "teamtypekey": this.teamTypeKey ,order: 'displayorder ASC'},
              method: 'get'
          },
          this.gettypesurl + '?filter'
      ),this._commonHttpService
      .getArrayList(
          {
              where: { "tablename":"informedconsent", "teamtypekey": this.teamTypeKey },
              method: 'get'
          },
          this.gettypesurl + '?filter'
      ),this._commonHttpService
      .getArrayList(
        {
            where: {
                referencetypeid: '500701',
                teamtypekey: null
            },
            method: 'get',
            nolimit: true
        },
        `${this.gettypesurl}?filter`
    ), this._commonHttpService
    .getArrayList(
        {
            where: {
                referencetypeid: '500700',
                teamtypekey: null
            },
            method: 'get',
            nolimit: true
        },
        `${this.gettypesurl}?filter`
    )
    ,this._commonHttpService
    .getArrayList(
        {
            where: { "tablename":"diagnosis", "teamtypekey": this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
    ),this._commonHttpService
    .getArrayList(
        {
            where: { "tablename":"additionalpsychosocialinterventions", "teamtypekey": this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
    ),this._commonHttpService
    .getArrayList(
        {
            where: { "tablename":"prescriberdegree", "teamtypekey": this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
    ),this._commonHttpService
    .getArrayList(
        {
            where: { "tablename":"prescriberspecialty", "teamtypekey": this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
    ),this._commonHttpService
    .getArrayList(
        {
            where: { "tablename":"settingmedicationprescribed", "teamtypekey": this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
    )
     
    ]).pipe(
      map((result) => {
        result[2].forEach(type => {
          this.medicationType[type.medicationtypekey] = type.description;
        });
        return {
          prescriptionreasontype: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.prescriptionreasontypekey
              })
          ),
          informationsourcetype: result[1].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.informationsourcetypekey
              })
          ),
          medicationtype: result[2].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.medicationtypekey
              })
          ),
          frequency: this.createDropdownModel(result[3]),
          prescribedduration:this.createDropdownModel(result[4]),
          medicalclassification : this.createDropdownModel(result[5]),
          targetedsymptoms: this.createDropdownModelWithSort(result[6]),
          informedconsent: this.createDropdownModel(result[7]),
          HealthCareDecisionDropdownItems: this.createDropdownModel(result[8]),
          AuthorizedHcdmDropdownItems: this.createDropdownModel(result[9]),
          diagnosislist :this.createDropdownModel(result[10]),
          psychosocialintervention :this.createDropdownModel(result[11]),
          prescriberdegree :this.createDropdownModel(result[12]),
          prescriberspeciality :this.createDropdownModel(result[13]),
          medicationsettinglist :this.createDropdownModel(result[14])
        };
      }),
      share(),);
    this.prescriptionReasonType$ = source.pipe(pluck('prescriptionreasontype'));
    this.informationSourceType$ = source.pipe(pluck('informationsourcetype'));
    this.medicationType$ = source.pipe(pluck('medicationtype'));
    this.HealthCareDecisionDropdownItems$ = source.pipe(pluck('HealthCareDecisionDropdownItems'));
    this.AuthorizedHcdmDropdownItems$ = source.pipe(pluck('AuthorizedHcdmDropdownItems'));
    this.frequency$ = source.pipe(pluck('frequency'));
    this.diagnosislist$ = source.pipe(pluck('diagnosislist'));
    this.diagnosislist$.subscribe(data=>{
      this.diagnosislist =data;
    })
    this.medicationsettinglist$ = source.pipe(pluck('medicationsettinglist'));
    this.prescriberdegree$ = source.pipe(pluck('prescriberdegree'));
    this.prescriberspeciality$ = source.pipe(pluck('prescriberspeciality'));
    this.psychosocialintervention$ = source.pipe(pluck('psychosocialintervention'));
    this.psychosocialintervention$.subscribe(data=>{
      this.psychosocialinterventionlist =data;
    })
    this.prescribedDuration$ = source.pipe(pluck('prescribedduration'));
    this.medicationClassification$ = source.pipe(pluck('medicalclassification'));
    this.targetedsymptoms$ = source.pipe(pluck('targetedsymptoms'));
    this.informedconsent$ = source.pipe(pluck('informedconsent'));
    this.medicationClassification$.subscribe(data => {
      const sorting = _.sortBy(data,'text');
      this.medicationClassification = sorting;
    });
    this.informedconsent$.subscribe(data => {
      this.informedconsentList = data;
    });
    this.targetedsymptoms$.subscribe(data => {
      this.targetedsymptomsList = data;
    });
    this._commonHttpService.getArrayList({
      where: { "tablename":"frequencytype", "teamtypekey": this.teamTypeKey },
      method: 'get'},this.gettypesurl + '?filter').subscribe(data => {
      this.frequencydropdown = data;
    });
  }

  createDropdownModel(result: any){
    return this.returnMappedResultFn(result);
  }

  private returnMappedResultFn(result: any) {
    return result.map(
      (res: { description: any; ref_key: any; }) => new DropdownModel({
        text: res.description,
        value: res.ref_key
      })
    );
  }

  createDropdownModelWithSort(result: any){
   const resultAfterSort =  result.sort((a: { displayorder: number; },b: { displayorder: number; }) => (a.displayorder - b.displayorder));
    return this.returnMappedResultFn(resultAfterSort);
  }

  medicationeffective(event: any){
   const listdate= moment(event).subtract(365,'days').format('YYYY-MM-DD');
   const eventdate = moment(event);
   const countydate = moment(this.countylivedate);
   if (this.isHistoricalMedication && !eventdate.isBefore(countydate)) {
    this._alertSevice.error('Date prescribed cannot be later than Psychotropic feature release date.');
    this.medicationpsychotropicForm.patchValue({medicationeffectivedate: null});
    return;
   }

    this.getMedicationPsychotropicDocumentList(listdate);
    this.medicationpsychotropicForm.patchValue({lastdosetakendate: null});
    this.attachmentdoc();
  }

targetedsymptoms(event: any){
    const targetedevent=event.find((temp: string)=>temp== "OTH")
   
      if(targetedevent ){
        this.targetedOthervalidation =true;
      }else{
        this.targetedOthervalidation=false;
        this.medicationpsychotropicForm.controls['targetedother'].reset();
      }
  }
  informedconsentTooltip(){
    const value = this.medicationpsychotropicForm.getRawValue().informedconsent
    if(value){
     return   this.informedconsentList.filter((ele: { value: any; })=>value.includes(ele.value))
  .map((val: { text: any; })=>val.text).join(",");}

  }

  renewalbutton(input: any){
    if(input=='yes'){
  (<any>$(this.renewalpopupid)).modal('show');
}
  }
 otherValidation(){
   return this.medicationpsychotropicForm.controls.targetedsymptoms.value?.includes('OTH');
 }
  add(action: 'add' | 'refill') {
    this.isview=false;
    this.mandatoryField=true;
    this.addValidation();
    if(!this.medicationpsychotropicForm.get('isprescribedmedication')?.value){
      Object.keys(this.medicationpsychotropicForm.controls).forEach(field => {
        this.medicationpsychotropicForm.get(field)?.clearValidators();
        this.medicationpsychotropicForm.get(field)?.updateValueAndValidity();
    });
    }
    if(!this.medicationpsychotropicForm.get('ismedicationpsychotropic')?.value){
      Object.keys(this.healthCareDecisionMakerForm.controls).forEach(field => {
        this.healthCareDecisionMakerForm.get(field)?.clearValidators();
        this.healthCareDecisionMakerForm.get(field)?.updateValueAndValidity();
    });
    }
    if(this.medicationpsychotropicForm.invalid && this.othersCheck()){
      this.medicationpsychotropicForm.markAllAsTouched();
      this._alertSevice.error('Please fill required fields');
      return;
    }
  

    const name1Control = this.healthCareDecisionMakerForm.controls['name1'];
    const decision1Control = this.healthCareDecisionMakerForm.controls['healthcaredecision1'];
    const isPsychotropic = this.medicationpsychotropicForm.getRawValue().ismedicationpsychotropic;
    const shouldShowHcdmTab = this.showhcdmtaboncounty;
  
    const isName1Missing = !name1Control.value;
    const isDecision1Missing = !decision1Control.value;
  
    const isHcdmRequired = action === 'add' && isPsychotropic && shouldShowHcdmTab && (isName1Missing || isDecision1Missing);
  
    if (isHcdmRequired) {
      name1Control.setValidators(Validators.required);
      name1Control.updateValueAndValidity();
  
      decision1Control.setValidators(Validators.required);
      decision1Control.updateValueAndValidity();
  
      this.healthCareDecisionMakerForm.markAllAsTouched();
      this._alertSevice.error('Please fill required fields');
      return;
    }

    if(!this.healthCareDecisionMakerForm.controls['name2'].value && this.medicationpsychotropicForm.getRawValue().ismedicationpsychotropic && this.isRequiredParentOrLegalGuardianSection){
      this.healthCareDecisionMakerForm.controls['name2'].setValidators(Validators.required);
      this.healthCareDecisionMakerForm.controls['name2'].updateValueAndValidity();
      this.healthCareDecisionMakerForm.markAllAsTouched();
      this._alertSevice.error('Please fill required fields');
      return;
    }
    const uploadInfo: any = {};
    uploadInfo['uploadedFiles'] = this.uploadedFiles;
    const data = {...this.medicationpsychotropicForm.getRawValue(), ...uploadInfo};

    if (this.medicationpsychotropicForm.getRawValue().secondaryreviewcompleted === 1) { 
      data.secondaryreviewcompleted = true;
    } else {
      data.secondaryreviewcompleted = false;
    }
    if(data.renewal == true){
      data.personmedicpshychotropicparentid = this.personmedicpshychotropicparentid;
    }
    const renewcheck =data?.uploadedFiles.find((da: any)=> (da.documentattachment?.attachmentclassificationsubtypekey=='Informed Consent' || da.documentattachment?.attachmentclassificationsubtypekey== 'Psychotropic Medication Informed Consent'));
    if (
      !renewcheck && !this.isrenewal && 
      this.medicationpsychotropicForm.controls.ismedicationpsychotropic.value &&
        this.hasremoval &&
        this.medicationpsychotropicForm.getRawValue().secondaryreviewcompleted === 1
      ) {
        this._alertSevice.error('Please Upload Informed Consent Document');
        return;
      }
    if(!data.renewal){
      data.renewal=false;
     data.personmedicpshychotropicparentid = ''
    }
    if(data.renewal){
      data.personmedicpshychotropicparentid = this.RenewalItem.personmedicpshychotropicid;
    }
    data.isprescribedmedication = this.isMedicationIncludes;
    
    this._healthService.saveHealth({ 'personmedicalPsychotropic': [data] }).subscribe((Psychotropic) => {
      this.addConditionsAudit('add-medication-psychotropic');
      this.Psychotropicid=Psychotropic[0].personhealthaddupdate;
      this._alertSevice.success('Medication Information Added Successfully');
      this.saveDecisionMakerInformation();
      this.resetForm();
      this.getMedicationPsychotropicList('init');
      this.isAddEdit =false;
      this._healthService.renewalflag= false;
      // updating first due task after adding record.
      if (this.hasFamilyAccessToCase) {       
        this._globalPopupService.updateMyTaskbyUser('Medication-Psychotropic',this.personId,false);
      }
    });
  }

	addValidation(){
    if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'LDSS' ){
			this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].clearValidators();
			this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].updateValueAndValidity();
		}
		if(this.medicationpsychotropicForm.controls?.isprescribercheck?.value){
			this.targetedSymptomscheck = true;
			this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
			this.medicationpsychotropicForm.controls['targetedsymptoms'].clearValidators();
			this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
			this.medicationpsychotropicForm.controls['targetedother'].reset();
			this.medicationpsychotropicForm.controls['targetedother'].clearValidators();
			this.medicationpsychotropicForm.controls['targetedother'].updateValueAndValidity();
		} else {
			this.targetedSymptomscheck = false;
			this.medicationpsychotropicForm.controls['targetedsymptoms'].setValidators((!this.reasonPrescribed) ? Validators.required : null);
			this.medicationpsychotropicForm.controls['targetedsymptoms'].setValidators(Validators.required);
			this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
		}
		if(!this.medicationpsychotropicForm.get('ismedicationpsychotropic')?.value){
			this.medicationpsychotropicForm.controls['medicationeffectivedate'].clearValidators();
			this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
			this.medicationpsychotropicForm.controls['classification'].clearValidators();
			this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
			this.medicationpsychotropicForm.controls['informedconsent'].clearValidators();
			this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
			this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].clearValidators();
			this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].updateValueAndValidity();
			this.healthCareDecisionMakerForm.controls['name1'].clearValidators();
			this.healthCareDecisionMakerForm.controls['name1'].updateValueAndValidity();
    }
  }
  pageChanged(pageInfo: any) {
      this.paginationInfo.pageNumber = pageInfo.page;
      this.getMedicationPsychotropicList();
  }
  resetForm() {
    this.medicationpsychotropicForm.reset();
    this.selectedMedication = null;
    this.modalInt = -1;
    this.selectRowIndex ='';
    this.isMedicationIncludes = false;
    this.isChangeOfMedication = false;
    this.editMode = false;
    this.reportMode = 'add';
    this.dtDisable = false;
    this.isRefill = false;
    this.medicationpsychotropicForm.enable();
    this.medicationpsychotropicForm.get('isprescribedmedication')?.setValidators([Validators.required]);
    this.medicationpsychotropicForm.get('isprescribedmedication')?.updateValueAndValidity();
    this.medicationpsychotropicForm.controls['compliant'].setValidators(null);
    this.medicationpsychotropicForm.controls['compliantcomments'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['compliant'].setValidators(null);
    this.medicationpsychotropicForm.controls['compliant'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['dateofrefill'].setValidators(null);
    this.medicationpsychotropicForm.controls['dateofrefill'].updateValueAndValidity();
    this.healthCareDecisionMakerForm.reset();
    this.healthcaredecisionmakerinformationid1 = null;
    this.healthcaredecisionmakerinformationid2 = null;
    this.healthcaredecisionmakerinformationidhcdmflag0Fields = null;
    this.Psychotropicid = null;
  }

  update() {
    this.mandatoryField=true;
    this.updateValidation();
    if(!this.medicationpsychotropicForm.get('ismedicationpsychotropic')?.value){
      Object.keys(this.healthCareDecisionMakerForm.controls).forEach(field => {
        this.healthCareDecisionMakerForm.get(field)?.clearValidators();
        this.healthCareDecisionMakerForm.get(field)?.updateValueAndValidity();
    });
    }
    if(!this.medicationpsychotropicForm.get('isprescribedmedication')?.value){
      Object.keys(this.medicationpsychotropicForm.controls).forEach(field => {
        this.medicationpsychotropicForm.get(field)?.clearValidators();
        this.medicationpsychotropicForm.get(field)?.updateValueAndValidity();
    });
    }
    this.medicationpsychotropicForm.controls['compliant'].clearValidators();
this.medicationpsychotropicForm.controls['compliant'].updateValueAndValidity();
    if(((this.medicationpsychotropicForm.invalid && this.othersCheck())|| (this.showhcdmtaboncounty &&  this.healthCareDecisionMakerForm.invalid) ) && this.medicationpsychotropicForm.get('isprescribedmedication')?.value){
      this.medicationpsychotropicForm.markAllAsTouched();
      this.healthCareDecisionMakerForm.markAllAsTouched();
      this._alertSevice.error('Please fill required fields');
      return;
    }
    const uploadInfo: any = {};
    uploadInfo['uploadedFiles'] = this.uploadedFiles;
    const data = {...this.medicationpsychotropicForm.getRawValue(), ...uploadInfo};
    const renewcheck =data?.uploadedFiles.find((da: any)=> (da.documentattachment?.attachmentclassificationsubtypekey=='Informed Consent' || da.documentattachment?.attachmentclassificationsubtypekey== 'Psychotropic Medication Informed Consent'));
    if(!renewcheck && !this.renewal && this.medicationpsychotropicForm.controls.ismedicationpsychotropic.value){
      this._alertSevice.error('Please Upload Informed Consent Document');
      return;
    }
    data.personmedicpshychotropicid = this.personmedicpshychotropicid;
    data.personmedicpshychotropicparentid = this.personmedicpshychotropicparentid
    data.isprescribedmedication = this.isMedicationIncludes;
    this.saveDecisionMakerInformation();
    if(this.healthcaredecisionmakerinformationidhcdmflag0Fields && (this.deletehdcm || this.getlatesthealthcareupdatedelete)){
      this.hcdmdelete(this.healthcaredecisionmakerinformationidhcdmflag0Fields);
    }
    if(this.datediscontinued !== data.medicationexpirationdate)
     {
     var refilldataids = this.getrefilldata(data);
     data.refilldata = refilldataids;
     }
    if (this.isChangeOfMedication) {
      const changeofdate = data.changeofdate;
      data.changeofdate = null;
      data.datemedicationstarted = moment(changeofdate).format('MM/DD/YYYY');
      this._healthService.saveHealth({ 'personmedicalPsychotropic': [data] }).subscribe(responseCreate => {
        this.selectedMedication.medicationexpirationdate = changeofdate;
        this.selectedMedication.changeofdate = null;
        const updateData = {
          "isprescribedmedication": this.selectedMedication.isprescribedmedication,
          "ismedicationpsychotropic": this.selectedMedication.ismedicationpsychotropic,
          "secondaryreviewcompleted" :this.selectedMedication.secondaryreviewcompleted,
          "classification": this.selectedMedication.classification,
          "medicationname": this.selectedMedication.medicationname,
          "prescribedreason": this.selectedMedication.prescribedreason,
          "medicationtype": this.selectedMedication.medicationtype,
          "dosage": this.selectedMedication.dosage,
          "diagnosis": this.selectedMedication.diagnosis,
          "frequency": this.selectedMedication.frequency,
          "targetedsymptoms": this.selectedMedication.targetedsymptoms,
          "targetedother": this.selectedMedication.targetedother,
          "informedconsent": this.selectedMedication.informedconsent,
          "renewal": this.selectedMedication.renewal,
          "compliant": this.selectedMedication.compliant,
          "compliantcomments": this.selectedMedication.compliantcomments,
          "dateofrefill": this.selectedMedication.dateofrefill,
          "informationsourcetypekey": this.selectedMedication.informationsourcetypekey,
          "lastdosetakendate": this.selectedMedication.lastdosetakendate,
          "datemedicationstarted": this.selectedMedication.datemedicationstarted,
          "isprescribercheck": this.selectedMedication.isprescribercheck,
          "medicationeffectivedate": this.selectedMedication.medicationeffectivedate,
          "medicationexpirationdate": this.selectedMedication.medicationexpirationdate,
          "prescribingdoctor": this.selectedMedication.prescribingdoctor,
          "prescriptionreasontypekey": this.selectedMedication.prescriptionreasontypekey,
          "medicationcomments": this.selectedMedication.medicationcomments,
          "reportedby": this.selectedMedication.reportedby,
          "otherreason": this.selectedMedication.otherreason,
          "prescribedduration": this.selectedMedication.prescribedduration,
          "username": this.selectedMedication.username,
          "changeofdate": null,
          "uploadedFiles": [],
          "personmedicpshychotropicid": this.selectedMedication.personmedicpshychotropicid,
          specifyfrequencyhour: this.selectedMedication.specifyfrequencyhour,
          specifyduration: this.selectedMedication.specifyduration,
          otherspecifyduration: this.selectedMedication.otherspecifyduration
        };
        
        this._healthService.saveHealth({ 'personmedicalPsychotropic': [updateData] }, 0).subscribe(response => {

          this.saveHealthResponse();
          this.getMedicationPsychotropicList('init');
          
        });
      });
      this.deletehdcm=false;
    } else {
      this._healthService.saveHealth({ 'personmedicalPsychotropic': [data] }, 0).subscribe(response => {
        this.saveHealthResponse();
        this.getMedicationPsychotropicList('init');
      });
    }
    
  }

  updateValidation(){
    if(this.medicationpsychotropicForm.controls?.isprescribercheck?.value){
      this.targetedSymptomscheck=true;
      this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
this.medicationpsychotropicForm.controls['targetedsymptoms'].clearValidators();
this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
this.medicationpsychotropicForm.controls['targetedother'].reset();
this.medicationpsychotropicForm.controls['targetedother'].clearValidators();
this.medicationpsychotropicForm.controls['targetedother'].updateValueAndValidity();

    }else{
      this.targetedSymptomscheck=false;
      this.medicationpsychotropicForm.controls['targetedsymptoms'].setValidators(Validators.required);
      this.healthCareDecisionMakerForm.controls['name1'].setValidators(Validators.required);
      this.healthCareDecisionMakerForm.controls['name1'].updateValueAndValidity();
      if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value == 'PAR' && !this.deletedAnotherHealthCare && this.healthCareDecisionMakerForm.get('healthcaredecision2')?.value == 'PAR'){
        this.healthCareDecisionMakerForm.controls['name2'].setValidators(Validators.required);
        this.healthCareDecisionMakerForm.controls['name2'].updateValueAndValidity();
      }else{
        this.healthCareDecisionMakerForm.controls['name2'].clearValidators();
        this.healthCareDecisionMakerForm.controls['name2'].updateValueAndValidity();
      }
      if(this.medicationpsychotropicForm.get('isprescribedmedication')?.value){
  this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();}
  else{
    this.medicationpsychotropicForm.controls['targetedsymptoms'].clearValidators();
    this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
  }
  
    }
    if(!this.medicationpsychotropicForm.get('ismedicationpsychotropic')?.value){
      this.medicationpsychotropicForm.controls['medicationeffectivedate'].clearValidators();
      this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
      this.medicationpsychotropicForm.controls['classification'].clearValidators();
      this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
      this.medicationpsychotropicForm.controls['informedconsent'].clearValidators();
      this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
      this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].clearValidators();
      this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].updateValueAndValidity();
      this.healthCareDecisionMakerForm.controls['name1'].clearValidators();
      this.healthCareDecisionMakerForm.controls['name1'].updateValueAndValidity();
    }
    if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'LDSS' )
    {
      this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].clearValidators();
      this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].updateValueAndValidity();
    }
  }

  saveHealthResponse()
  {
    this.addConditionsAudit('edit-medication-psychotropic');
    this._alertSevice.success('Medication Information Updated Successfully');
    this.resetForm();
    this.getMedicationPsychotropicList();
    this.isAddEdit =false;
    this._healthService.renewalflag= false;
  }

  view(modal: any, i: any) {
    this.healthCareDecisionMakerForm.reset();
    this.isview=true;
    this.isAddEdit = true;
    this.showgetLatestbutton =false;    
    if(modal.medicationname){
   
      this.showallotherfiled=true;
      this.showaddotherfild =true;
    }else{
      this.showallotherfiled=false;
      this.showaddotherfild =false;
    }
      this.showsecondaryreviewcompleted =true ;
      if (modal.diagnosisfromsecond) {
        try {
            modal.diagnosisfromsecond = JSON.parse(modal.diagnosisfromsecond);
        } catch  {
           
        }
    }
    if(modal.additionalpsychosocialinterventions){
    modal.additionalpsychosocialinterventions=JSON.parse(modal.additionalpsychosocialinterventions);}
    this.reportMode = 'edit';
    this.handleViewModalCondn(modal);
    this.ismedication(modal.isprescribedmedication);
    this.editMode = false;
    this.getDecisionmakerinformation(modal.personmedicpshychotropicid,'view')
    try {
      modal.targetedsymptoms=JSON.parse(modal.targetedsymptoms);
      modal.informedconsent=JSON.parse(modal.informedconsent);
    } catch (ex) {
    }
   if(modal?.targetedother ){
      this.targetedOthervalidation =true;
    }else{
      this.targetedOthervalidation=false;
    } 
    if (modal.lastdosetakendate) {
      this.expirationDate = false;
    } else {
      this.expirationDate = true;
    }
    this.patchForm(modal);
    this.validtionfromsecode();
    this.dtDisable = true;
    this.medicationpsychotropicForm.disable();
    this.getMedicationPsychotropicHistory(modal.personmedicpshychotropicid);
    if(modal.renewal){
      this._healthService.renewalflag= true;}
      else{
        this._healthService.renewalflag= false;
      }
      this.addConditionsAudit('view-medication-psychotropic');
  }
  private handleViewModalCondn(modal: any) {
    if (modal?.informedconsent) {
      this.selectinformedconsentList = this.informedconsentList?.filter((val: { value: any; }) => Object.prototype.toString.call(modal?.informedconsent) == '[object Array]' ?
        (modal?.informedconsent?.indexOf(val.value) != -1) :
        JSON?.parse(modal?.informedconsent)?.indexOf(val.value) != -1)?.map((ele: { text: any; }) => ele.text)?.join(",");
    } else {
      this.selectinformedconsentList = null;
    }
    if (modal?.targetedsymptoms) {
      this.selecttargetedsymptomsList = this.targetedsymptomsList?.filter((val: { value: any; }) => Object.prototype.toString.call(modal.targetedsymptoms) == '[object Array]' ?
        (modal?.targetedsymptoms?.indexOf(val.value) != -1) :
        JSON?.parse(modal?.targetedsymptoms)?.indexOf(val.value) != -1)?.map((ele: { text: any; }) => ele.text)?.join(",");
    } else {
      this.selecttargetedsymptomsList = null;
    }
    this.uploadedFiles = modal.uploadedfiles ? modal.uploadedfiles : [];
  }

  renewal(){
    const modal=JSON.parse(JSON.stringify( this.RenewalItem));
    this.defaultMedication =modal?.pshychotropicid ;
    modal.personmedicpshychotropicid=null;
    modal.personmedicpshychotropicparentid =this.RenewalItem.personmedicpshychotropicid;
    modal.uploadedfiles=null;
    modal.renewal=true;
    this.isRefill = true;
    this.patchForm(modal);
    this.edit(modal, this.selectRowIndex, 'renew');
    (<any>$(this.renewalpopupid)).modal('hide'); 

    this.medicationpsychotropicForm.controls['compliant'].setValidators(null);
    this.medicationpsychotropicForm.controls['compliant'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['dateofrefill'].setValidators(null);
    this.medicationpsychotropicForm.controls['dateofrefill'].updateValueAndValidity();
  }
  changeOfMedication(){
    const modal=JSON.parse(JSON.stringify( this.RenewalItem));
    this.selectedMedication = _.cloneDeep(modal);
    modal.personmedicpshychotropicid=null;
    modal.changeOfMedication=true;
    this.patchForm(modal);
    this.edit(modal, this.selectRowIndex,'changeOfMedication');
    this.declineChangeOfDate();
    this.RenewalItem= null;
    this.medicationpsychotropicForm.controls['compliant'].setValidators(null);
    this.medicationpsychotropicForm.controls['compliant'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['dateofrefill'].setValidators(null);
    this.medicationpsychotropicForm.controls['dateofrefill'].updateValueAndValidity();
  }
  attachmentdoc(){
    if(this.medicationpsychotropicForm.controls['ismedicationpsychotropic'].value && this.medicationpsychotropicForm.controls['medicationeffectivedate'].value){
      this.isPsychotropic=true;
    }else{
      this.isPsychotropic=false;
    }
  }

  hcdmdelete(medicalConditionid: any) {
    this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.hcdmdelete;
    return this._commonHttpService.remove(medicalConditionid).subscribe();
  }

  getlatesthealthcare(){
    this.latesthealthcareflg=true;
    let mood='refill';
    this._commonHttpService.getPagedArrayList({
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
      method: 'post',
      where: { personid: this.personId,courtorderid:this.healthCareDecisionMakerForm.get('courtorderid1')?.value}
    }, 'personmedicalcondition/getlatesthealthcare').subscribe((res: any) => {
      this.hcdmfromcourt = res[0].getlatesthealthcare
      let data: any[] = res[0].getlatesthealthcare || [];
      if(data && data.length > 0){
        this.getlatesthealthcareupdate =true;
        let hcdmflag1Fields = data?.find((item: any) => item.hcdmflag == 1);
        let hcdmflag0Fields = data?.find((item: any) => item.hcdmflag !=1);
          this.getlatesthealthcareupdatedelete=(this.healthcaredecisionmakerinformationidhcdmflag0Fields && !hcdmflag0Fields);
        if(hcdmflag0Fields && hcdmflag0Fields.healthcaredecisionmaker != null)
        {
        this.isRequiredParentOrLegalGuardianSection = true ;
        this.isRequiredParentOrLegalGuardianButton=false;
        this.healthCareDecisionMakerForm.controls['name2'].clearValidators();
this.healthCareDecisionMakerForm.controls['name2'].updateValueAndValidity();

    }else {
        this.isRequiredParentOrLegalGuardianSection = false ;
        this.isRequiredParentOrLegalGuardianButton=hcdmflag1Fields?.healthcaredecisionmaker=='PAR';
        
        }
        this.healthCareDecisionMakerForm.get('healthcaredecision1')?.setValue(hcdmflag1Fields?.healthcaredecisionmaker);
        this.healthCareDecisionMakerForm.get('name1')?.setValue(hcdmflag1Fields?.name);
        this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.setValue(hcdmflag1Fields?.authorizedhcdm);
        this.healthCareDecisionMakerForm.get('email1')?.setValue(hcdmflag1Fields?.email)
        this.healthCareDecisionMakerForm.get('phone1')?.setValue(hcdmflag1Fields?.phonenumber);
        this.healthCareDecisionMakerForm.get('hcdmOther1')?.setValue(hcdmflag1Fields?.otherhcdm);
        this.healthCareDecisionMakerForm.get('courtorderid1')?.setValue(hcdmflag1Fields?.objectid);
        if(mood=='refill'){
          this.address = {  disable: true, address1: hcdmflag1Fields?.addressline1, address2: hcdmflag1Fields?.addressline2, city: hcdmflag1Fields?.city, state: hcdmflag1Fields?.state, county: null, zipcode: hcdmflag1Fields?.zip };

        }else{
          this.address = {  disable: false, address1: hcdmflag1Fields?.addressline1, address2: hcdmflag1Fields?.addressline2, city: hcdmflag1Fields?.city, state: hcdmflag1Fields?.state, county: null, zipcode: hcdmflag1Fields?.zip };

        }

        this.healthCareDecisionMakerForm.get('healthcaredecision2')?.setValue(hcdmflag0Fields?.healthcaredecisionmaker);
        this.healthCareDecisionMakerForm.get('name2')?.setValue(hcdmflag0Fields?.name);
        this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.setValue(hcdmflag0Fields?.authorizedhcdm);
        this.healthCareDecisionMakerForm.get('email2')?.setValue(hcdmflag0Fields?.email);
        this.healthCareDecisionMakerForm.get('phone2')?.setValue(hcdmflag0Fields?.phonenumber);
        this.healthCareDecisionMakerForm.get('hcdmOther2')?.setValue(hcdmflag0Fields?.otherhcdm);
        this.healthCareDecisionMakerForm.get('courtorderid2')?.setValue(hcdmflag0Fields?.objectid);
        if(mood=='refill'){
        this.address2 = {  disable: true, address1: hcdmflag0Fields?.addressline1, address2: hcdmflag0Fields?.addressline2, city: hcdmflag0Fields?.city, state: hcdmflag0Fields?.state, county: null, zipcode: hcdmflag0Fields?.zip };
      }else{
        this.address2 = {  disable: false, address1: hcdmflag0Fields?.addressline1, address2: hcdmflag0Fields?.addressline2, city: hcdmflag0Fields?.city, state: hcdmflag0Fields?.state, county: null, zipcode: hcdmflag0Fields?.zip };

      }
if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'LDSS'){
  this.medicationpsychotropicForm.controls['classification'].reset();
  this.medicationpsychotropicForm.controls['medicationeffectivedate'].reset();
  this.medicationpsychotropicForm.controls['informedconsent'].reset();
  this.medicationpsychotropicForm.controls['diagnosis'].reset();
  this.medicationpsychotropicForm.controls['dosage'].reset();
  this.medicationpsychotropicForm.controls['frequency'].reset();
  this.medicationpsychotropicForm.controls['medicationname'].reset();
  this.medicationpsychotropicForm.controls['prescribingdoctor'].reset();
  this.medicationpsychotropicForm.controls['classification'].enable();
  this.medicationpsychotropicForm.controls['medicationeffectivedate'].enable();
  this.medicationpsychotropicForm.controls['informedconsent'].enable();
  this.medicationpsychotropicForm.controls['diagnosis'].enable();
  this.medicationpsychotropicForm.controls['isprescribercheck'].enable();
  this.medicationpsychotropicForm.controls['dosage'].enable();
  this.medicationpsychotropicForm.controls['frequency'].enable();
  this.medicationpsychotropicForm.controls['medicationname'].enable();
  this.medicationpsychotropicForm.controls['prescribingdoctor'].enable();
  this.medicationpsychotropicForm.controls['classification'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['medicationeffectivedate'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['informedconsent'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['diagnosis'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['diagnosis'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['dosage'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['dosage'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['frequency'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['frequency'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['medicationname'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['medicationname'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['prescribingdoctor'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['prescribingdoctor'].updateValueAndValidity();
  this.medicationpsychotropicForm.controls['targetedsymptoms'].enable();
  this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
this.medicationpsychotropicForm.controls['targetedsymptoms'].clearValidators();
this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
}
  this.latestHealthValidation();
       
    }});
    
  }

  latestHealthValidation(){
    if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'LDSS' && this.showhcdmtaboncounty){
      this.showallotherfiled =true;
      this.showcompletesecondary =true;
      this.showsecondaryreviewcompleted =false;
      this.showAdditionalfields =false;
     }else{
      this.showallotherfiled =false;
      this.showcompletesecondary =false;
      this.showsecondaryreviewcompleted =true;
     }
     if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'PAR'){
       this.isRequiredParentOrLegalGuardianButton=false;
       this.isRequiredParentOrLegalGuardianSection = false;
     }
  }

  didChangeStatus(event: any){
if(event?.checked){
this.targetedSymptomscheck=true;
this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
this.medicationpsychotropicForm.controls['targetedsymptoms'].clearValidators();
this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
this.medicationpsychotropicForm.controls['targetedother'].reset();
this.medicationpsychotropicForm.controls['targetedother'].clearValidators();
this.medicationpsychotropicForm.controls['targetedother'].updateValueAndValidity();


}else{
  this.targetedSymptomscheck=false;
  this.medicationpsychotropicForm.controls['targetedsymptoms'].setValidators(Validators.required);
  this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
 
}
  }
  edit(modal: any, i?:any, renew?:any) {
    this.healthCareDecisionMakerForm.reset();
    this.isview=false;
    this.psyedit=true;
    this.isLoading = true;
    this.showgetLatestbutton  =true;
    this.secondaryreview=false;
    this.isRequiredParentOrLegalGuardianSection=false;
    this.showallotherfiled=!!modal.medicationname;
    this.showaddotherfild =!!modal.medicationname;
    this.datediscontinued =modal.medicationexpirationdate
    if (modal.diagnosisfromsecond) {
        modal.diagnosisfromsecond = JSON.parse(modal.diagnosisfromsecond);
  }
    if(modal.additionalpsychosocialinterventions){
    modal.additionalpsychosocialinterventions=JSON.parse(modal.additionalpsychosocialinterventions);}
    if((renew=='renew' )){
      this.isRequiredParentOrLegalGuardianButton=false;
      this.showgetLatestbutton =false;
    }
   
    modal.compliant = (modal.compliant !== null) ? modal.compliant.toString() : null;
    this.isChangeOfMedication = (modal.changeOfMedication === true);
    this.Psychotropicid =modal?.personmedicpshychotropicid;
    this.personmedicpshychotropicparentid =modal?.personmedicpshychotropicparentid
    const listdate = modal?.medicationeffectivedate ? moment(modal.medicationeffectivedate).subtract(365,'days').format('YYYY-MM-DD') : null;
    if(renew!='renew'){
      this.getDecisionmakerinformation(modal.personmedicpshychotropicid,'edit')
    }
    this.showsecondaryreviewcompleted = (!(!this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value==null || this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value !='LDSS'));
    
    this.getMedicationPsychotropicDocumentList(listdate);
    this.medicationpsychotropicForm.controls['classification'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['medicationeffectivedate'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['informedconsent'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['diagnosis'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['diagnosis'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['dosage'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['dosage'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['frequency'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['frequency'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['medicationname'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['medicationname'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['prescribingdoctor'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['prescribingdoctor'].updateValueAndValidity();
    this.handleEditModalFn(modal);
    this.personmedicpshychotropicid = modal?.personmedicpshychotropicid;
    if(!modal.renewal){
    this.uploadedfilesEdit =JSON.parse(JSON.stringify(modal.uploadedfiles));
    }
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.addConditionsAudit('edit-medication-psychotropic');
    if(!modal?.personmedicpshychotropicid){
      this.reportMode='renew'
    }
    
    this.getMedicationPsychotropicHistory(modal?.personmedicpshychotropicid);
    this.showsecondaryreviewcompleted = (!(!this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value ==null || this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value !='LDSS'));
    
    this.ismedication(modal.isprescribedmedication);
    this.editMode = true;
    try {
    modal.targetedsymptoms=JSON.parse(modal.targetedsymptoms);
    modal.informedconsent=JSON.parse(modal.informedconsent);
  } catch (ex) {
  }
  this.targetedOthervalidation =!!modal?.targetedother;

    this.patchForm(modal);
    this.validtionfromsecode();
    this.dtDisable = false;
    if(!modal.renewal){
    this.uploadedFiles = Array.isArray(modal.uploadedfiles) ? modal.uploadedfiles : [];
    }
    this.medicationpsychotropicForm.enable();
    this.medicationpsychotropicForm.controls.prescribedreason.disable();
    this.medicationpsychotropicForm.controls.diagnosisfromsecond.disable();
    this.medicationpsychotropicForm.controls.diagnosisotherfromsecond.disable();
    this.medicationpsychotropicForm.controls.psychosocialinterventions.disable();
    this.medicationpsychotropicForm.controls.additionalpsychosocialinterventions.disable();
    this.medicationpsychotropicForm.controls.otheradditionalpsychosocialinterventions.disable();
    this.medicationpsychotropicForm.controls.prescribercontactinfo.disable();
    this.medicationpsychotropicForm.controls.prescriberemail.disable();
    this.medicationpsychotropicForm.controls.prescriberdegree.disable();
    this.medicationpsychotropicForm.controls.otherprescriberdegree.disable();
    this.medicationpsychotropicForm.controls.prescriberspecialty.disable();
    this.medicationpsychotropicForm.controls.otherprescriberspecialty.disable();
    this.medicationpsychotropicForm.controls.settingmedicationprescribed.disable();
    if(modal.renewal){
      this.isrenewal =true;
      this._healthService.renewalflag= true;
      this.medicationpsychotropicForm.controls.medicationname.disable();
      this.medicationpsychotropicForm.controls.medicationexpirationdate.disable();

      this.healthCareDecisionMakerForm.disable();
    }else{
      this.isrenewal =false;
      this._healthService.renewalflag= false;
    }
if(this.isrenewal && this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='PAR' &&(this.healthCareDecisionMakerForm.get('name2')?.value || this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.value) ){
this.isRequiredParentOrLegalGuardianSection=true;
}
  this.resetChangeofMedication(modal);
    
    setTimeout(() => {
      this.isLoading = false;
    }, 0);
  }

  resetChangeofMedication(modal: any){
    if (modal.changeOfMedication) {
      this.editMode = true;
      this.reportMode = 'edit';
      this.uploadedFiles = [];
      this.uploadedfilesEdit = [];
    }
  }

  private handleEditModalFn(modal: any) {
    if (modal?.ismedicationpsychotropic && modal?.medicationeffectivedate) {
      this.isPsychotropic = true;
    } else {
      this.isPsychotropic = false;
    }
    if (modal?.isprescribercheck) {
      this.targetedSymptomscheck = true;
      this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
      this.medicationpsychotropicForm.controls['targetedsymptoms'].clearValidators();
      this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
      this.medicationpsychotropicForm.controls['targetedother'].reset();
      this.medicationpsychotropicForm.controls['targetedother'].clearValidators();
      this.medicationpsychotropicForm.controls['targetedother'].updateValueAndValidity();

    } else {
      this.targetedSymptomscheck = false;
      this.medicationpsychotropicForm.controls['targetedsymptoms'].setValidators(Validators.required);
      this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();

    }
    if (modal.lastdosetakendate) {
      this.expirationDate = false;
    } else {
      this.expirationDate = true;
    }
  }

  delete() {
    const modal = this.deleteItem;

    const data = {
      'personmedicpshychotropicid': modal.personmedicpshychotropicid,
    };
    this._healthService.saveHealth({ 'personmedicalPsychotropic': [data] }, 2).subscribe(() => {
        this._alertSevice.success('Medication Information Deleted Successfully');
        this.resetForm();
        this.getMedicationPsychotropicList('init');
        this.isAddEdit =false;
        (<any>$(this.deletepopupid)).modal('hide');
        this.deleteItem = null;
        this.addConditionsAudit('delete-medication-psychotropic');
      });
  }

  cancel() {
    this.isrenewal =false;
    this._healthService.renewalflag= false;
    this.resetForm();
    this.isAddEdit = false;
    this.medicationpsychotropicForm.controls['compliant'].setValidators(null);
    this.medicationpsychotropicForm.controls['compliant'].updateValueAndValidity();
    if(this.isClosed) {
      window.scrollTo(0,0);
    }
  }
  getMedicationPsychotropicHistory(pmid: any) {
    this._commonHttpService.getPagedArrayList({
      method: 'get',
      where: { id: pmid}
    }, 'personmedicalcondition/personmedicalhistory?filter').subscribe(res => {
      this.medicationpsychotropicHistory = res ? res : [];
    });
  }
  auditTrail(modal: any){
    const pmid=modal?.personmedicpshychotropicid;
    this.getMedicationPsychotropicHistory(pmid);
    (<any>$('#audittraillog')).modal('show');
  }
  private patchForm(modal: Medication) {
    modal.compliant = modal.compliant?String(modal.compliant):null;
    this.uploadedFiles = modal.uploadedfiles ? modal.uploadedfiles :[];
    if(modal.secondaryreviewcompleted === false) {
      const medicationeffectivedate = moment(modal.medicationeffectivedate);
      const countylivedate = moment(this.countylivedate);
      if(medicationeffectivedate.isBefore(countylivedate)){
        modal.secondaryreviewcompleted = 0;
      } else {
        modal.secondaryreviewcompleted = 0;
      }
    } else {
      modal.secondaryreviewcompleted = 1;
    }
    this.medicationpsychotropicForm.patchValue(modal);
  }

  addMedicationPsychotropic() {
    this.resetForm();
    this.healthCareDecisionMakerForm.reset();
    this.reasonPrescribed =true;
    this.newpsychotropic =true;
    this.expirationDate=true;
    this.isAddEdit = true;
    this.uploadedFiles = [];
    this.pandldelete =true;
  }


  getfrequencyvalue(val: any) {
    
      
   
    var text = this.frequencydropdown.filter(c=>c.ref_key == val.frequency);
    
    if(text && text.length) {
      return text[0].value_text.replace(' (Specify number)', ' (' + val.specifyfrequencyhour + ')');
    } else {
      return '';
    }
  
  }
  getMedicationPsychotropicDocumentList(date?: any) {
    this._commonHttpService.getPagedArrayList({
      method: 'get',
      where: { personid: this.personId,date:date}
    }, 'personmedicalcondition/personmedidocumentlist?filter').subscribe((res: any) => {
      this.psychotropicpersonmedidocumentlist = res ? res[0]?.data : [];
    });
  }
  getMedicationPsychotropicList(val?:string) {
    const sortdirection = 'desc';
    const sortcolumn = 'Updated on';
    const srtDirection = this.searchandsortquery?.sortDirection ? this.searchandsortquery?.sortDirection : sortdirection;
    const srtColumn = this.searchandsortquery?.sortColumn ? this.searchandsortquery?.sortColumn : sortcolumn;
    this._commonHttpService.getPagedArrayList({
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
      method: 'get',
      where: { personid: this.personId,
        sortorder: this.searchandsortquery ? srtDirection : sortdirection,
        sortcolumn: this.searchandsortquery ? srtColumn : sortcolumn,
      }
    }, 'personmedicalcondition/personmedicallist?filter').subscribe(res => {
      this.medicationpsychotropic = res ? res.data : [];
      const medicationpsychotropic2 =this.medicationpsychotropic.filter(re=>re.medicationexpirationdate!==null);
      const medicationpsychotropic1 =this.medicationpsychotropic.filter(re=>re.medicationexpirationdate==null);
      this.medicationpsychotropic =medicationpsychotropic1.concat(medicationpsychotropic2);
     
    if(val ==='init'){
    this.getrefillmedicationist();}
else{
    this.medicationpsychotropic =this.medicationpsychotropic.concat(this.refillmedication);

  

    this.loadlistDetails()
      this.medicationListCheck = this.medicationpsychotropic.find(item => item.personmedicpshychotropicid === this.medicationid);
      if (this.medicationListCheck && this.medicationid) {
          this.edit(this.medicationListCheck);
          this.medicationid = null;
      }
    }
      this.totalRecords = res.count;
      
     
    // psychotropicDetailsData
    });
  }
  loadlistDetails(query: QueryType = {}) {
      const columnMapping = {
      // "id":'id',
       "Medication Name":'medicationname',
      "Dosage":'dosage',
      "Frequency":'frequency',
      "Updated By":'username',
      "Updated On":'updatedon',
      "Date Prescribed":'medicationeffectivedate',
      "Date Medication Started":'datemedicationstarted',
      "Date Discontinued":'medicationexpirationdate',
      'Action':'Action'
         
      };
      let sortedList = this.medicationpsychotropic;
      ////this.psychotropicDetailsData = this.psychotropiclist;
  
       
       this.medicationpsychotropicData = this.returnSortedListDataFn(sortedList);
      //  this.medicationpsychotropic
  
      this.MedicationPsychotropicColumns = Object.keys(this.medicationpsychotropicData?.[0] || columnMapping)
    this.MedicationPsychotropicKeys = Object.keys(this.medicationpsychotropicData?.[0] || columnMapping)
    this.unsortablecolumnlist = [ 'Dosage', 'Frequency', 'Updated By', 'Updated On'
      ,'Date Medication Started','Date Discontinued','Actions']; 
                       
       }
  returnSortedListDataFn(sortedList: any[]): any[] {
     return sortedList?.map((e: any) => ({
          // 'id':e.personmedicpshychotropicid,
          // 'medicationexpirationdate':e.medicationexpirationdate,
          // 'healthcaredecisionmaker':e.healthcaredecisionmaker,
          'Medication Name': e.medicationname,
          'Dosage':e.dosage,
          'Frequency': this.getfrequencyvalue(e),
          'Updated By': e.username,
          'Updated On':  e.updatedon ? moment(e.updatedon).format('MM/DD/YYYY') : "",
          'Date Prescribed': e.medicationeffectivedate ? moment(e.medicationeffectivedate).format('MM/DD/YYYY') : "",
          'Date Medication Started':  e.datemedicationstarted ? moment(e.datemedicationstarted).format('MM/DD/YYYY') : "",
          'Date Discontinued': e.medicationexpirationdate ? moment(e.medicationexpirationdate).format('MM/DD/YYYY') : "",
          'Action': e
        }));
  }
  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }
  confirmDelete(modal: any){
    this.deleteItem = modal;
    (<any>$(this.deletepopupid)).modal('show');
  }
  changecompliant(value: any) {
    this.medicationpsychotropicForm.controls['compliant'].setValidators((value === '0') ? Validators.required : null);
    this.medicationpsychotropicForm.controls['compliantcomments'].updateValueAndValidity();
    this.medicationpsychotropicForm.patchValue({
      compliantcomments: ''
    });
  }

  confirmRenewal(modal: any, i: any) {
    this.selectRowIndex = i;
    this.secondaryreview=false;
    this.getDecisionmakerinformation(modal?.personmedicpshychotropicid, 'refill');
    this.RenewalItem = modal;
    this.medicationpsychotropicForm.controls['compliant'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['compliant'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['dateofrefill'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['dateofrefill'].updateValueAndValidity();
    (<any>$(this.renewalpopupid)).modal('show');
  }

  declineRenewal() {
    this.isRefill = false;
    (<any>$(this.renewalpopupid)).modal('hide');
  }
  confirmChangeOfDate(modal: any, i: any) {
    this.selectRowIndex = i;
    this.secondaryreview=false;
    this.getDecisionmakerinformation(modal?.personmedicpshychotropicid, 'datechange');
    this.RenewalItem = modal;
    this.medicationpsychotropicForm.controls['compliant'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['compliant'].updateValueAndValidity();
    this.medicationpsychotropicForm.controls['dateofrefill'].setValidators(Validators.required);
    this.medicationpsychotropicForm.controls['dateofrefill'].updateValueAndValidity();
    (<any>$('#change-of-date-popup')).modal('show');
  }
  declineChangeOfDate() {
    (<any>$('#change-of-date-popup')).modal('hide');
  }
  getSuggestedmedicine(){
      if (this.medicationpsychotropicForm.value.medicationname) {
      this.suggestions = this.suggestedMedicine.filter((c: { description: string; })=>c.description.toLowerCase().startsWith(this.medicationpsychotropicForm.value.medicationname.toLowerCase()))
    }
  }
  selectedmedicine(item: any){
 this.medicationpsychotropicForm.patchValue({
  medicationname:item.description
 })
  }
  suggestMedicine() {
  
  this._commonHttpService
      .getArrayList(
        {
            where: { referencetypeid: 903, teamtypekey: this.teamTypeKey },
            method: 'get'
        },
        this.gettypesurl + '?filter'
      ).subscribe ((result : any)=>{
          if(result.length > 0){
            this.suggestedMedicine = result;
            this.suggestedMedicine.sort((a: { description: string; }, b: { description: any; }) => a.description.localeCompare(b.description));
          }
      })

      }
      nosecondary(){
        this.completesecondary =true;
        this.showsecondarylist =false;
        this.medication=null;
        
      }
      selectpsychotropic(medication: any){
 this.medication =medication;
 this.medicationpsychotropicForm.get('pshychotropicid')?.setValue(this.medication?.psychotropicid);
 this.submit();
         
      }
      submit(){
        if (this.medication){
          this.isldss=true;
          this.showaddotherfild =true;
          this.disablecheckboxtraget= true;
          this.showallotherfiled=true
          this.secondaryreview = true;
          let medication =this.medication;
          if(medication && medication.dosage){
            this.secondaryreviewdosage =medication.dosage;
          }
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].setValue(medication.dateprescribed);
          this.medicationpsychotropicForm.controls['dosage'].setValue(medication.dosage);
          this.medicationpsychotropicForm.controls['medicationname'].setValue(medication.medicationname);
          switch(medication.classification){
            case 'STI': 
              medication.classification='ST';
              break;
            case 'ANT':
              medication.classification='AP';
              break;
            case 'MOS':
              medication.classification='MS';
              break;
          }
          
          this.medicationpsychotropicForm.controls['classification'].setValue(medication.classification);
          switch(medication.methodofdelivery){
            case 'OBY':
              medication.methodofdelivery='Oral';
              break;
            case 'IMI':
              medication.methodofdelivery='IM';
              break;
            case 'ITS':
              medication.methodofdelivery='IT';
              break;
            case 'IIV':
              medication.methodofdelivery='IV';
              break;
            case 'REC':
              medication.methodofdelivery='Rectal';
              break;
            case 'SIN':
              medication.methodofdelivery='SC'
              break;

          }
          
          this.medicationpsychotropicForm.controls['medicationtype'].setValue(medication.methodofdelivery);
          let symptoms = JSON.parse(medication.targetedsymptoms); // Parse the JSON string into an array
          symptoms = this.normalizeSymptoms(symptoms); // Replace 'ANX' with 'DEM'

          this.medicationpsychotropicForm.controls['targetedsymptoms'].setValue(symptoms);
          this.medicationpsychotropicForm.controls['frequency'].setValue(medication.frequency);
          switch(medication.prescribedduration){
            case 'OTH':
              medication.prescribedduration='OTHER';
              break;
            case 'NON':
              medication.prescribedduration='NONE';
              break;
            case 'UNK':
              medication.prescribedduration='UNKN';
              break;
            case 'XDY':
              medication.prescribedduration='XDAYS'
              break;
            case 'XWE':
              medication.prescribedduration='XWEEKS';
              break;
          }
          
          this.medicationpsychotropicForm.controls['specifyfrequencyhour'].setValue(medication.specifyhour);
          this.medicationpsychotropicForm.controls['prescribedduration'].setValue(medication.prescribedduration);
          this.medicationpsychotropicForm.controls['otherspecifyduration'].setValue(medication.otherspecifyduration);
          this.medicationpsychotropicForm.controls['specifyduration'].setValue(medication.specifyduration);
          this.medicationpsychotropicForm.controls['prescribingdoctor'].setValue(medication.prescribername);
          this.medicationpsychotropicForm.controls['targetedother'].setValue(medication.othersymptoms);
          this.medicationpsychotropicForm.controls['otherreason'].setValue(medication.otherfrequency);
          this.medicationpsychotropicForm.controls['diagnosisfromsecond'].setValue(JSON.parse(medication.diagnosis));
          this.medicationpsychotropicForm.controls['diagnosisotherfromsecond'].setValue(medication.otherdiagnosis);
          this.medicationpsychotropicForm.controls['psychosocialinterventions'].setValue(medication.psychosocialinterventions);
          this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].setValue(JSON.parse(medication.additionalpsychosocialinterventions));
          this.medicationpsychotropicForm.controls['otheradditionalpsychosocialinterventions'].setValue(medication.otheradditionalpsychosocialinterventions);
          this.medicationpsychotropicForm.controls['prescribercontactinfo'].setValue(medication.prescribercontactinfo);
          this.medicationpsychotropicForm.controls['prescriberemail'].setValue(medication.prescriberemail);
          this.medicationpsychotropicForm.controls['prescriberdegree'].setValue(medication.prescriberdegree);
          this.medicationpsychotropicForm.controls['otherprescriberdegree'].setValue(medication.otherprescriberdegree);
          this.medicationpsychotropicForm.controls['prescriberspecialty'].setValue(medication.prescriberspecialty);
          this.medicationpsychotropicForm.controls['otherprescriberspecialty'].setValue(medication.otherprescriberspecialty);
          this.medicationpsychotropicForm.controls['settingmedicationprescribed'].setValue(medication.settingmedicationprescribed);
          this.medicationpsychotropicForm.controls.diagnosisfromsecond.disable();
          this.medicationpsychotropicForm.controls.diagnosisotherfromsecond.disable();
          this.medicationpsychotropicForm.controls.psychosocialinterventions.disable();
          this.medicationpsychotropicForm.controls.additionalpsychosocialinterventions.disable();
          this.medicationpsychotropicForm.controls.otheradditionalpsychosocialinterventions.disable();
          this.medicationpsychotropicForm.controls.prescribercontactinfo.disable();
          this.medicationpsychotropicForm.controls.prescriberemail.disable();
          this.medicationpsychotropicForm.controls.prescriberdegree.disable();
          this.medicationpsychotropicForm.controls.otherprescriberdegree.disable();
          this.medicationpsychotropicForm.controls.prescriberspecialty.disable();
          this.medicationpsychotropicForm.controls.otherprescriberspecialty.disable();
          this.medicationpsychotropicForm.controls.settingmedicationprescribed.disable();
          
          this.validtionfromsecode();
      }else{
        this.disablecheckboxtraget =false;
      }
        this.disablesecondary =true;
      }

      normalizeSymptoms(symptoms: any) {
        const mapping: any = {
          DEM: 'DEP',
          MAE: 'MAN',
          MID: 'MOI'
        };
        return symptoms.map((symptom: any) => mapping[symptom] || symptom);
      }

      validtionfromsecode(){
        const diagnosis = this.medicationpsychotropicForm.controls['diagnosisfromsecond'].value
           if(diagnosis?.includes('OTH')){
             this.showotherdiagnosis =true;
            }else{
             this.showotherdiagnosis = false;
              }
             const prescriberdegree = this.medicationpsychotropicForm.controls['prescriberdegree'].value
                 if(prescriberdegree?.includes('OTH')){
                      this.showotherprescriberdegree =true;
                  }else{
                   this.showotherprescriberdegree= false;
              
                  }
                  const prescriberspeciality = this.medicationpsychotropicForm.controls['prescriberspecialty'].value
                  if(prescriberspeciality?.includes('OTH')){
                   this.showotherprescriberspeciality =true;
                 
                  }else{
                   this.showotherprescriberspeciality= false; }
                   const psychosocial = this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].value
                   if(psychosocial?.includes('OTH')){
                    this.showotheraddpsychosocial =true;
                   }else{
                         this.showotheraddpsychosocial  = false;}
      }
      yessecondary(){
        this.showsecondarylist =true;
        this.completesecondary =false;
        this._commonHttpService.getPagedArrayList({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          method: 'post',
          where: { personid: this.personId}
        }, 'personmedicalcondition/personsecondarymedicallist').subscribe((res: any) => {
          this.psychotropicmedicationshealthcaredecision = res[0].getpsychotropicmedicationshealthcaredecision;
         if(this.psychotropicmedicationshealthcaredecision){
            this.backbutton=true;
         }else{
          this.backbutton=false;
         }
        });
        
      }
      gethcdmfromcourt(mood?: any){
       
        this._commonHttpService.getPagedArrayList({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          method: 'post',
          where: { personid: this.personId}
        }, 'personmedicalcondition/gethcdmfromcourt').subscribe((res: any) => {
          this.hcdmfromcourt = res[0].gethcdminfo;
          let data: any[] = res[0].gethcdminfo || [];
          if(data && data.length > 0){
            let hcdmflag1Fields = data?.find((item: any) => item.hcdmflag == 1);
            let hcdmflag0Fields = data?.find((item: any) => item.hcdmflag !=1);
            if(hcdmflag0Fields && hcdmflag0Fields.healthcaredecisionmaker != null)
            {
            this.isRequiredParentOrLegalGuardianSection = true ;
        }else {
            this.isRequiredParentOrLegalGuardianSection = false ;
            }
            this.healthCareDecisionMakerForm.get('healthcaredecision1')?.setValue(hcdmflag1Fields?.healthcaredecisionmaker);
            this.healthCareDecisionMakerForm.get('name1')?.setValue(hcdmflag1Fields?.name);
            this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.setValue(hcdmflag1Fields?.authorizedhcdm);
            this.healthCareDecisionMakerForm.get('email1')?.setValue(hcdmflag1Fields?.email)
            this.healthCareDecisionMakerForm.get('phone1')?.setValue(hcdmflag1Fields?.phonenumber);
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.setValue(hcdmflag1Fields?.otherhcdm);
            this.healthCareDecisionMakerForm.get('courtorderid1')?.setValue(hcdmflag1Fields?.objectid);
              this.address = {  disable: true, address1: hcdmflag1Fields?.addressline1, address2: hcdmflag1Fields?.addressline2, city: hcdmflag1Fields?.city, state: hcdmflag1Fields?.state, county: null, zipcode: hcdmflag1Fields?.zip };
              this.healthCareDecisionMakerForm.controls['healthcaredecision1'].disable();
              this.healthCareDecisionMakerForm.controls['name1'].disable();
              this.healthCareDecisionMakerForm.controls['authorizedhcdm1'].disable();
              this.healthCareDecisionMakerForm.controls['email1'].disable();
              this.healthCareDecisionMakerForm.controls['phone1'].disable();
              this.healthCareDecisionMakerForm.controls['hcdmOther1'].disable();
              this.healthCareDecisionMakerForm.controls['courtorderid1'].disable();

            this.healthCareDecisionMakerForm.get('healthcaredecision2')?.setValue(hcdmflag0Fields?.healthcaredecisionmaker);
            this.healthCareDecisionMakerForm.get('name2')?.setValue(hcdmflag0Fields?.name);
            this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.setValue(hcdmflag0Fields?.authorizedhcdm);
            this.healthCareDecisionMakerForm.get('email2')?.setValue(hcdmflag0Fields?.email);
            this.healthCareDecisionMakerForm.get('phone2')?.setValue(hcdmflag0Fields?.phonenumber);
            this.healthCareDecisionMakerForm.get('hcdmOther2')?.setValue(hcdmflag0Fields?.otherhcdm);
            this.healthCareDecisionMakerForm.get('courtorderid2')?.setValue(hcdmflag0Fields?.objectid);
            this.healthCareDecisionMakerForm.controls['healthcaredecision2'].disable();
            this.healthCareDecisionMakerForm.controls['name2'].disable();
            this.healthCareDecisionMakerForm.controls['authorizedhcdm2'].disable();
            this.healthCareDecisionMakerForm.controls['email2'].disable();
            this.healthCareDecisionMakerForm.controls['phone2'].disable();
            this.healthCareDecisionMakerForm.controls['hcdmOther2'].disable();
            this.healthCareDecisionMakerForm.controls['courtorderid2'].disable();
            this.address2 = {  disable: true, address1: hcdmflag0Fields?.addressline1, address2: hcdmflag0Fields?.addressline2, city: hcdmflag0Fields?.city, state: hcdmflag0Fields?.state, county: null, zipcode: hcdmflag0Fields?.zip };

            if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'LDSS' ){
           this.showallotherfiled =true;
           this.showcompletesecondary =true;
           this.showsecondaryreviewcompleted =false;
          }else{
            if(!(mood=='edit'||mood=='view')){
              this.showallotherfiled =false;
            }
           
           this.showcompletesecondary =false;
           this.showsecondaryreviewcompleted =true;
          }

        }});
        
      }

      changesecondaryreviewcompleted(event: any){
        if (event === 1) {
        this.yessecondary();
        this.disablebutton =false;
        this.showcompletesecondary =false;
        } else if (event === 0) {
          this.disablebutton =true;
          this.showcompletesecondary =true;
          this.disablecheckboxtraget =false;
          this.showallotherfiled=false;
          this.showaddotherfild =false;
          this.nosecondary();
          this.medicationpsychotropicForm.controls['medicationname'].reset();
          this.medicationpsychotropicForm.controls['specifyfrequencyhour'].reset();
          this.medicationpsychotropicForm.controls['prescribedduration'].reset();
          this.medicationpsychotropicForm.controls['otherspecifyduration'].reset();
          this.medicationpsychotropicForm.controls['specifyduration'].reset();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].reset();
          this.medicationpsychotropicForm.controls['targetedother'].reset();
          this.medicationpsychotropicForm.controls['otherreason'].reset();
          this.medicationpsychotropicForm.controls['diagnosisfromsecond'].reset();
          this.medicationpsychotropicForm.controls['diagnosisotherfromsecond'].reset();
          this.medicationpsychotropicForm.controls['psychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['otheradditionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['prescribercontactinfo'].reset();
          this.medicationpsychotropicForm.controls['prescriberemail'].reset();
          this.medicationpsychotropicForm.controls['prescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['prescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['settingmedicationprescribed'].reset();
          this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
          this.medicationpsychotropicForm.controls['frequency'].reset();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].reset();
          this.medicationpsychotropicForm.controls['dosage'].reset();
          this.medicationpsychotropicForm.controls['medicationtype'].reset();
          this.medicationpsychotropicForm.controls['classification'].reset();
          this.medicationpsychotropicForm.controls['classification'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['informedconsent'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['diagnosis'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['diagnosis'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['dosage'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['dosage'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['frequency'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['frequency'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationname'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['medicationname'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['prescribingdoctor'].updateValueAndValidity();
          
        } else {
          this.isHistoricalMedication = true;
          this.showallotherfiled = true;
          this.showaddotherfild = true;
          this.medicationpsychotropicForm.controls['medicationname'].reset();
          this.medicationpsychotropicForm.controls['specifyfrequencyhour'].reset();
          this.medicationpsychotropicForm.controls['prescribedduration'].reset();
          this.medicationpsychotropicForm.controls['otherspecifyduration'].reset();
          this.medicationpsychotropicForm.controls['specifyduration'].reset();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].reset();
          this.medicationpsychotropicForm.controls['targetedother'].reset();
          this.medicationpsychotropicForm.controls['otherreason'].reset();
          this.medicationpsychotropicForm.controls['diagnosisfromsecond'].reset();
          this.medicationpsychotropicForm.controls['diagnosisotherfromsecond'].reset();
          this.medicationpsychotropicForm.controls['psychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['otheradditionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['prescribercontactinfo'].reset();
          this.medicationpsychotropicForm.controls['prescriberemail'].reset();
          this.medicationpsychotropicForm.controls['prescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['prescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['settingmedicationprescribed'].reset();
          this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
          this.medicationpsychotropicForm.controls['frequency'].reset();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].reset();
          this.medicationpsychotropicForm.controls['dosage'].reset();
          this.medicationpsychotropicForm.controls['medicationtype'].reset();
          this.medicationpsychotropicForm.controls['classification'].reset();
          this.medicationpsychotropicForm.controls['classification'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['informedconsent'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['diagnosis'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['diagnosis'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['dosage'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['dosage'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['frequency'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['frequency'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationname'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['medicationname'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['prescribingdoctor'].updateValueAndValidity();
        }
      }
      changemedpsychotropic(event: any){
        if(!event || !this.showhcdmtaboncounty){
          this.showallotherfiled=true;
        }else{
          this.showallotherfiled=false;
        }

        if( !event){
          this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].reset();
          this.showsecondaryreviewcompleted =false ;
        }
        this.attachmentdoc();
        if(!event){
          this.healthCareDecisionMakerForm.reset();
          this.isRequiredParentOrLegalGuardianSection=false;
          this.address = {  disable: false, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
          this.address2 = {  disable: false, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
        }else{
          if(this.newpsychotropic){
            this.gethcdmfromcourt()
          }
          
        }
    
        this.medicationpsychotropicForm.controls['classification'].reset();
        this.medicationpsychotropicForm.controls['medicationeffectivedate'].reset();
          this.medicationpsychotropicForm.controls['informedconsent'].reset();
        if(!event){
          this.isPsychotropic=false;
          this.medicationpsychotropicForm.controls['classification'].clearValidators();
          this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].clearValidators();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['lastdosetakendate'].clearValidators();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['informedconsent'].clearValidators();
          this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
          
        }
        if(this.secondaryreview && !event){
          this.medicationpsychotropicForm.controls['medicationname'].reset();
          this.medicationpsychotropicForm.controls['specifyfrequencyhour'].reset();
          this.medicationpsychotropicForm.controls['prescribedduration'].reset();
          this.medicationpsychotropicForm.controls['otherspecifyduration'].reset();
          this.medicationpsychotropicForm.controls['specifyduration'].reset();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].reset();
          this.medicationpsychotropicForm.controls['targetedother'].reset();
          this.medicationpsychotropicForm.controls['otherreason'].reset();
          this.medicationpsychotropicForm.controls['diagnosisfromsecond'].reset();
          this.medicationpsychotropicForm.controls['diagnosisotherfromsecond'].reset();
          this.medicationpsychotropicForm.controls['psychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['otheradditionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['prescribercontactinfo'].reset();
          this.medicationpsychotropicForm.controls['prescriberemail'].reset();
          this.medicationpsychotropicForm.controls['prescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['prescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['settingmedicationprescribed'].reset();
          this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
          this.medicationpsychotropicForm.controls['frequency'].reset();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].reset();
          this.medicationpsychotropicForm.controls['dosage'].reset();
          this.medicationpsychotropicForm.controls['medicationtype'].reset();
          this.medicationpsychotropicForm.controls['classification'].reset();
          
        }
        if(!event){
          this.medicationpsychotropicForm.controls['medicationname'].reset();
          this.medicationpsychotropicForm.controls['specifyfrequencyhour'].reset();
          this.medicationpsychotropicForm.controls['prescribedduration'].reset();
          this.medicationpsychotropicForm.controls['otherspecifyduration'].reset();
          this.medicationpsychotropicForm.controls['specifyduration'].reset();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].reset();
          this.medicationpsychotropicForm.controls['targetedother'].reset();
          this.medicationpsychotropicForm.controls['otherreason'].reset();
          this.medicationpsychotropicForm.controls['diagnosisfromsecond'].reset();
          this.medicationpsychotropicForm.controls['diagnosisotherfromsecond'].reset();
          this.medicationpsychotropicForm.controls['psychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['otheradditionalpsychosocialinterventions'].reset();
          this.medicationpsychotropicForm.controls['prescribercontactinfo'].reset();
          this.medicationpsychotropicForm.controls['prescriberemail'].reset();
          this.medicationpsychotropicForm.controls['prescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberdegree'].reset();
          this.medicationpsychotropicForm.controls['prescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['otherprescriberspecialty'].reset();
          this.medicationpsychotropicForm.controls['settingmedicationprescribed'].reset();
          this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
          this.medicationpsychotropicForm.controls['frequency'].reset();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].reset();
          this.medicationpsychotropicForm.controls['dosage'].reset();
          this.medicationpsychotropicForm.controls['medicationtype'].reset();
          this.medicationpsychotropicForm.controls['classification'].reset();
          this.medicationpsychotropicForm.controls['diagnosis'].reset();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].enable();
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['diagnosis'].enable();
          this.medicationpsychotropicForm.controls['diagnosis'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['diagnosis'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['dosage'].enable();
          this.medicationpsychotropicForm.controls['dosage'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['dosage'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['frequency'].enable();
          this.medicationpsychotropicForm.controls['frequency'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['frequency'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['medicationname'].enable();
          this.medicationpsychotropicForm.controls['medicationname'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['medicationname'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].enable();
          this.medicationpsychotropicForm.controls['prescribingdoctor'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['prescribingdoctor'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['targetedsymptoms'].enable();
          this.medicationpsychotropicForm.controls['targetedsymptoms'].setValidators(Validators.required);
          this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
          this.medicationpsychotropicForm.controls['isprescribercheck'].enable();
          this.medicationpsychotropicForm.controls['medicationtype'].enable();
          this.medicationpsychotropicForm.controls['prescribedduration'].enable();
       
        }
      }
      
      selectedHour(item: any) {
        if (item) {
          this.medicationpsychotropicForm.patchValue({ specifyfrequencyhour: item });
        }
      }
      clearspecifyfrequencyhour() {
        this.medicationpsychotropicForm.patchValue({ specifyfrequencyhour: '' });
        this.medicationpsychotropicForm.controls['specifyfrequencyhour'].setValidators((this.medicationpsychotropicForm.controls['specifyfrequencyhour'].value === 'EHD') ? [Validators.required] : null);
        this.medicationpsychotropicForm.controls['specifyfrequencyhour'].updateValueAndValidity();
      }
      filterFrequencyHours() {
        if (this.medicationpsychotropicForm.value.specifyfrequencyhour) {
          this.filterFrequencyHourSugg = this.hourList.filter(option =>  option.toLowerCase().indexOf(this.medicationpsychotropicForm.value.specifyfrequencyhour.toLowerCase()) === 0);

        }
      }
      filterSpecifyHour() {
        if (this.medicationpsychotropicForm.value.specifyduration) {
          this.filterSpecifyHourSugg = this.hourList.filter(option =>  option.toLowerCase().indexOf(this.medicationpsychotropicForm.value.specifyduration.toLowerCase()) === 0);
        }
      }
      selectedSpecifyDuration(item: any) {
        if (item) {
          this.medicationpsychotropicForm.patchValue({ specifyduration: item });
        }
      }
      clearOtherSpecifyfrequency() {
        this.medicationpsychotropicForm.patchValue({ specifyduration: '', otherspecifyduration: '' });
        this.medicationpsychotropicForm.controls['specifyduration'].reset();
        this.medicationpsychotropicForm.controls['specifyduration'].setValidators((this.medicationpsychotropicForm.getRawValue().prescribedduration === 'XDAYS' ||  this.medicationpsychotropicForm.getRawValue().prescribedduration === 'XWEEKS') ? [Validators.required] : null);
        this.medicationpsychotropicForm.controls['otherspecifyduration'].reset();
        this.medicationpsychotropicForm.controls['otherspecifyduration'].setValidators(null);
      }
      othersCheck() {
        const errors: any = [];
        Object.keys(this.medicationpsychotropicForm.controls).forEach(key => {
          const controlErrors: any = this.medicationpsychotropicForm.get(key)?.errors;
          if (controlErrors != null) {
            errors.push(key);
          }
        });
        return (errors.length > 0) ? true : (((this.medicationpsychotropicForm.value.prescribedduration === 'XDAYS' ||  this.medicationpsychotropicForm.value.prescribedduration === 'XWEEKS') && !this.medicationpsychotropicForm.value.specifyduration) || (this.medicationpsychotropicForm.value.prescribedduration === 'OTHER' && !this.medicationpsychotropicForm.value.otherspecifyduration));
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
                // On opening of the medication page will trigger this function.
                this.addConditionsAudit('open-medication-psychotropic');
                if (this.hasFamilyAccessToCase) {                 
                  this._globalPopupService.updateMyTaskbyUser('Medication-Psychotropic',this.personId,true);
               }
            }
        });
      }

    checkCaseAccess(data: any) {
      const checkAccessList = data.filter((item: any) => (item.responsibilitytypekey === "child" || item.responsibilitytypekey === "family" || item.responsibilitytypekey === "administrative") && (item.enddate === null || moment(item.enddate) >= moment(new Date())))
      checkAccessList.forEach((element: any) => {
          const familyAssignmentWorker = element.toworkerdetails?.filter((a: any) => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
          if (familyAssignmentWorker.length > 0) {
              this.hasFamilyAccessToCase = true;
          }
      })
    }

    addConditionsAudit(key: any){
      let username;
      const objectType = 'Medication-Psychotropic';
      this._authService.currentUser.subscribe((userInfo) => {
          username = userInfo.user.securityusersid;
      });
      const comment = {
          securityusersid: username,
          logtype: key, 
          referenceid: this.personId, 
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
      )
    }

      saveDecisionMakerInformation() {
        if (!this.Psychotropicid) {
          return;
        }
        let healthCareDecisionMakerForm = this.healthCareDecisionMakerForm.getRawValue();
        let req = [{
          healthcaredecisionmakerinformationid : this.healthcaredecisionmakerinformationid1? this.healthcaredecisionmakerinformationid1 :null,
            objecttype: 'psychotropic',
            objectid: this.Psychotropicid,
            personid: this.personId,
            healthcaredecisionmaker: healthCareDecisionMakerForm.healthcaredecision1,
            name: healthCareDecisionMakerForm.name1,
            authorizedhcdm: healthCareDecisionMakerForm.authorizedhcdm1,
            email: healthCareDecisionMakerForm.email1,
            phonenumber: healthCareDecisionMakerForm.phone1,
            addressline1: this.address.address1,
            addressline2: this.address.address2,
            city: this.address.city,
            state: this.address.state, 
            zip: this.address.zipcode,
            otherhcdm: healthCareDecisionMakerForm.hcdmOther1,
            hcdmflag: 1,
            courtorderid:  healthCareDecisionMakerForm.courtorderid1
        }, {
          healthcaredecisionmakerinformationid : this.healthcaredecisionmakerinformationid2? this.healthcaredecisionmakerinformationid2 :null,
            objecttype: 'psychotropic',
            objectid: this.Psychotropicid,
            personid:  this.personId,
            healthcaredecisionmaker: healthCareDecisionMakerForm.healthcaredecision2,
            name: healthCareDecisionMakerForm.name2,
            authorizedhcdm: healthCareDecisionMakerForm.authorizedhcdm2,
            email: healthCareDecisionMakerForm.email2,
            phonenumber: healthCareDecisionMakerForm.phone2,
            addressline1: this.address2.address1,
            addressline2: this.address2.address2,
            city: this.address2.city,
            state: this.address2.state,
            zip: this.address2.zipcode,
            otherhcdm: healthCareDecisionMakerForm.hcdmOther2,
            hcdmflag: 0,
            courtorderid:  healthCareDecisionMakerForm.courtorderid2
        }]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
         const hasValue = (val: any) => val !== null && val !== undefined && val !== '';
        req = req.filter(obj => hasValue(obj.name) && hasValue(obj.authorizedhcdm) && hasValue(obj.healthcaredecisionmaker));
        if (!req.length) {
          return;
        }
            this._commonHttpService.create({data : req}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.Addhealthcaredecisionmakerinformation).subscribe();
    }
    
    getDecisionmakerinformation(psychotropicid: any, mode: any) {
      this.showselectedMedicationbutton = (mode === 'refill');
      
        if(mode === 'view') {
            
            this.healthCareDecisionMakerForm.disable();
            this.address.disable = true;
            this.address2.disable = true;
            this.editModehdmc =true;

        } else {
            this.healthCareDecisionMakerForm.get('healthcaredecision2')?.disable();
            this.address.disable = true;
            this.address2.disable = true;
            this.editModehdmc= false;
        }
     
        this._commonHttpService.getArrayList({
           where:{
                personid: this.personId,
                objectid:  psychotropicid,
                objecttype: 'psychotropic'
            } ,

            method: 'post'
        },
        'intakeservreqcourtorder/gethealthcaredecisionmakerinformation').subscribe(response => {
            let data: any[] = response[0]?.gethealthcaredecisionmakerinformation || [];
            if(data && data.length > 0){
            let hcdmflag1Fields = data?.find((item: any) => item.hcdmflag == 1);
            let hcdmflag0Fields = data?.find((item: any) => item.hcdmflag != 1);
            this.isRequiredParentOrLegalGuardianSection = false ;
            this.editModeSetdecisionMakerIds(mode, hcdmflag1Fields, hcdmflag0Fields);
            this.auditTrailhcdmcheck(hcdmflag1Fields?.courtorderid );
            this.showauditloghcdm=(hcdmflag1Fields?.courtorderid &&(mode === 'edit'||mode === 'view'));
            
            this.healthCareDecisionMakerForm.get('healthcaredecision1')?.setValue(hcdmflag1Fields?.healthcaredecisionmaker);
            this.healthCareDecisionMakerForm.get('name1')?.setValue(hcdmflag1Fields?.name);
            this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.setValue(hcdmflag1Fields?.authorizedhcdm);
            this.healthCareDecisionMakerForm.get('email1')?.setValue(hcdmflag1Fields?.email)
            this.healthCareDecisionMakerForm.get('phone1')?.setValue(hcdmflag1Fields?.phonenumber);
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.setValue(hcdmflag1Fields?.otherhcdm);
            this.healthCareDecisionMakerForm.get('courtorderid1')?.setValue(hcdmflag1Fields?.courtorderid);
            this.isRequiredParentOrLegalGuardianSection = (this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='PAR' && hcdmflag0Fields);
            
            this.isRequiredParentOrLegalGuardianButton=( this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='PAR' && !hcdmflag0Fields && mode != 'view');
            
            this.isldss= (this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='LDSS');
    this.address = {  disable: (mode === 'view' || mode === 'refill' || this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='LDSS'), address1: hcdmflag1Fields?.addressline1, address2: hcdmflag1Fields?.addressline2, city: hcdmflag1Fields?.city, state: hcdmflag1Fields?.state, county: null, zipcode: hcdmflag1Fields?.zip };
            this.decisionMakerValidation(mode, hcdmflag0Fields, hcdmflag1Fields);
            
        }});
    }

    editModeSetdecisionMakerIds(mode: any, hcdmflag1Fields: any, hcdmflag0Fields: any){
      if(mode === 'edit'){
        if(hcdmflag1Fields){
          this.healthcaredecisionmakerinformationid1 =hcdmflag1Fields?.healthcaredecisionmakerinformationid ;
        }
        if(hcdmflag0Fields){
          this.healthcaredecisionmakerinformationid2=hcdmflag0Fields?.healthcaredecisionmakerinformationid ;
        }
      }
    }

    decisionMakerValidation(mode: any, hcdmflag0Fields: any, hcdmflag1Fields: any){
      this.showsecondaryreviewcompleted = (!(!this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value ==null|| this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value !='LDSS'));
          
            if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='LDSS' && mode === 'edit'){
              this.medicationpsychotropicForm.controls['medicationname'].disable();
              this.medicationpsychotropicForm.controls['specifyfrequencyhour'].disable();
              this.medicationpsychotropicForm.controls['prescribedduration'].disable();
              this.medicationpsychotropicForm.controls['otherspecifyduration'].disable();
              this.medicationpsychotropicForm.controls['specifyduration'].disable();
              this.medicationpsychotropicForm.controls['prescribingdoctor'].disable();
              this.medicationpsychotropicForm.controls['targetedother'].disable();
              this.medicationpsychotropicForm.controls['otherreason'].disable();
              this.medicationpsychotropicForm.controls['diagnosisfromsecond'].disable();
              this.medicationpsychotropicForm.controls['diagnosisotherfromsecond'].disable();
              this.medicationpsychotropicForm.controls['psychosocialinterventions'].disable();
              this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].disable();
              this.medicationpsychotropicForm.controls['otheradditionalpsychosocialinterventions'].disable();
              this.medicationpsychotropicForm.controls['prescribercontactinfo'].disable();
              this.medicationpsychotropicForm.controls['prescriberemail'].disable();
              this.medicationpsychotropicForm.controls['prescriberdegree'].disable();
              this.medicationpsychotropicForm.controls['otherprescriberdegree'].disable();
              this.medicationpsychotropicForm.controls['prescriberspecialty'].disable();
              this.medicationpsychotropicForm.controls['otherprescriberspecialty'].disable();
              this.medicationpsychotropicForm.controls['settingmedicationprescribed'].disable();
              this.medicationpsychotropicForm.controls['targetedsymptoms'].disable();
              this.medicationpsychotropicForm.controls['frequency'].disable();
              this.medicationpsychotropicForm.controls['medicationeffectivedate'].disable();
              this.medicationpsychotropicForm.controls['medicationtype'].disable();
              this.medicationpsychotropicForm.controls['classification'].disable();
              this.medicationpsychotropicForm.controls['isprescribercheck'].disable();
              this.medicationpsychotropicForm.controls['classification'].setValidators(Validators.required);
              this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
            }
            this.healthCareDecisionMakerForm.get('healthcaredecision2')?.setValue(hcdmflag0Fields?.healthcaredecisionmaker);
            this.healthCareDecisionMakerForm.get('name2')?.setValue(hcdmflag0Fields?.name);
            this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.setValue(hcdmflag0Fields?.authorizedhcdm);
            this.healthCareDecisionMakerForm.get('email2')?.setValue(hcdmflag0Fields?.email);
            this.healthCareDecisionMakerForm.get('phone2')?.setValue(hcdmflag0Fields?.phonenumber);
            this.healthCareDecisionMakerForm.get('hcdmOther2')?.setValue(hcdmflag0Fields?.otherhcdm);
            this.healthCareDecisionMakerForm.get('courtorderid2')?.setValue(hcdmflag0Fields?.courtorderid);
            this.healthcaredecisionmakerinformationidhcdmflag0Fields= hcdmflag0Fields?.healthcaredecisionmakerinformationid || null;
            
            this.address2 = {  disable: (mode === 'view' || mode === 'refill' ), address1: hcdmflag0Fields?.addressline1, address2: hcdmflag0Fields?.addressline2, city: hcdmflag0Fields?.city, state: hcdmflag0Fields?.state, county: null, zipcode: hcdmflag0Fields?.zip };
            
            if( this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value =='LDSS' && (mode === 'view' || mode === 'refill' ||mode === 'edit')){
              this.yessecondary();
              this.defaultMedication = this.medicationpsychotropicForm.get('pshychotropicid')?.value ? this.medicationpsychotropicForm.get('pshychotropicid')?.value : this.renewalpshychotropicid;
            }
            if(mode==='edit' && hcdmflag1Fields?.courtorderid){
            this.healthCareDecisionMakerForm.controls['healthcaredecision2'].disable();
            this.healthCareDecisionMakerForm.controls['name2'].disable();
            this.healthCareDecisionMakerForm.controls['authorizedhcdm2'].disable();
            this.healthCareDecisionMakerForm.controls['email2'].disable();
            this.healthCareDecisionMakerForm.controls['phone2'].disable();
            this.healthCareDecisionMakerForm.controls['hcdmOther2'].disable();
            this.healthCareDecisionMakerForm.controls['courtorderid2'].disable();
            this.address2.disable =true;
            this.address.disable =true;
            this.healthCareDecisionMakerForm.controls['healthcaredecision1'].disable();
            this.healthCareDecisionMakerForm.controls['name1'].disable();
            this.healthCareDecisionMakerForm.controls['authorizedhcdm1'].disable();
            this.healthCareDecisionMakerForm.controls['email1'].disable();
            this.healthCareDecisionMakerForm.controls['phone1'].disable();
            this.healthCareDecisionMakerForm.controls['hcdmOther1'].disable();
            this.healthCareDecisionMakerForm.controls['courtorderid'].disable();
            }
    }

    goToPsychotropicReview() {
      const fullName = this._personInfoService.personInfo.personbasicdetails.firstname + ' ' + this._personInfoService.personInfo.personbasicdetails.lastname;
      const cjamspid =this._personInfoService.personInfo.personbasicdetails.cjamspid;
      const gender = this._personInfoService.personInfo.personbasicdetails.gendertypekey;
      const dob = this._personInfoService.personInfo.personbasicdetails.dob;
      const countytypekey = this._personInfoService.personInfo.personbasicdetails.personaddress.find((address: any) => address.county)?.county;
      const race = this._personInfoService.personInfo.personbasicdetails?.personracetypemap[0]?.value_text;
      const personinfo1: any = localStorage.getItem('navigationInfo');
      this.caseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER)? this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER) :JSON.parse(personinfo1)?.data?.caseNumber;
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_CASEID, this.caseId);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_FULLNAME, fullName);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_CJAMSPID, cjamspid);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_GENDER, gender);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_DOB, dob);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_COUNTY, countytypekey);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_RACE, race);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_PERSONID, this.personId);
      this.sessionStorage.setItemWithOutTab(CASE_STORE_CONSTANTS.PSYCHOTRPIC_FROMMEDICATION, true);
      const currenturl = '#/pages/psychotropicprescription-review';
      window.open(currenturl);
  }
    onAddAnotherHealthCare() {
        this.isRequiredParentOrLegalGuardianButton = false ;
        this.isRequiredParentOrLegalGuardianSection = true ;
        this.deleteParentOrLegalGuardianButton = true;
        this.deletedAnotherHealthCare = false ;
        this.healthCareDecisionMakerForm.get('healthcaredecision2')?.setValue('PAR');
        this.healthCareDecisionMakerForm.get('healthcaredecision2')?.disable();
        this.healthCareDecisionMakerForm.get('name2')?.enable();
        this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.enable();
        this.healthCareDecisionMakerForm.get('email2')?.enable();
        this.healthCareDecisionMakerForm.get('phone2')?.enable();
        this.healthCareDecisionMakerForm.get('hcdmOther2')?.enable();
        this.address2.disable = false;
        this.pandldelete =false;
    }
    deleteAnotherHealthCare() {
      this.isRequiredParentOrLegalGuardianButton = true ;
      this.deleteParentOrLegalGuardianButton = false;
      this.isRequiredParentOrLegalGuardianSection=false;
      this.deletedAnotherHealthCare =true;
      this.healthCareDecisionMakerForm.markAsDirty();
      this.healthCareDecisionMakerForm.get('healthcaredecision2')?.reset();
      this.healthCareDecisionMakerForm.get('name2')?.reset();
      this.healthCareDecisionMakerForm.get('name2')?.clearValidators();
      this.healthCareDecisionMakerForm.get('name2')?.updateValueAndValidity();
      this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.reset();
      this.healthCareDecisionMakerForm.get('email2')?.reset();
      this.healthCareDecisionMakerForm.get('phone2')?.reset();
      this.healthCareDecisionMakerForm.get('hcdmOther2')?.reset();
      this.address2.disable = false;
      this.deletehdcm=true;
  }
    onchangeDecisionMaker() {
      this.medicationpsychotropicForm.controls['secondaryreviewcompleted'].reset();
      if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value != 'LDSS'  ){
        this.showallotherfiled =true;
        this.showcompletesecondary =false;
        this.medicationpsychotropicForm.controls['medicationname'].reset();
        this.medicationpsychotropicForm.controls['medicationname'].enable();
        this.medicationpsychotropicForm.controls['specifyfrequencyhour'].reset();
        this.medicationpsychotropicForm.controls['prescribedduration'].reset();
        this.medicationpsychotropicForm.controls['otherspecifyduration'].reset();
        this.medicationpsychotropicForm.controls['specifyduration'].reset();
        this.medicationpsychotropicForm.controls['prescribingdoctor'].reset();
        this.medicationpsychotropicForm.controls['targetedother'].reset();
        this.medicationpsychotropicForm.controls['otherreason'].reset();
        this.medicationpsychotropicForm.controls['diagnosisfromsecond'].reset();
        this.medicationpsychotropicForm.controls['diagnosisotherfromsecond'].reset();
        this.medicationpsychotropicForm.controls['psychosocialinterventions'].reset();
        this.medicationpsychotropicForm.controls['additionalpsychosocialinterventions'].reset();
        this.medicationpsychotropicForm.controls['otheradditionalpsychosocialinterventions'].reset();
        this.medicationpsychotropicForm.controls['prescribercontactinfo'].reset();
        this.medicationpsychotropicForm.controls['prescriberemail'].reset();
        this.medicationpsychotropicForm.controls['prescriberdegree'].reset();
        this.medicationpsychotropicForm.controls['otherprescriberdegree'].reset();
        this.medicationpsychotropicForm.controls['prescriberspecialty'].reset();
        this.medicationpsychotropicForm.controls['otherprescriberspecialty'].reset();
        this.medicationpsychotropicForm.controls['settingmedicationprescribed'].reset();
        this.medicationpsychotropicForm.controls['targetedsymptoms'].reset();
        this.medicationpsychotropicForm.controls['frequency'].reset();
        this.medicationpsychotropicForm.controls['medicationeffectivedate'].reset();
        this.medicationpsychotropicForm.controls['dosage'].reset();
        this.medicationpsychotropicForm.controls['medicationtype'].reset();
        this.medicationpsychotropicForm.controls['classification'].reset();
        this.medicationpsychotropicForm.controls['diagnosis'].reset();
        this.medicationpsychotropicForm.controls['informedconsent'].reset();
        this.medicationpsychotropicForm.controls['classification'].enable();
        this.medicationpsychotropicForm.controls['classification'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['classification'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['medicationeffectivedate'].enable();
        this.medicationpsychotropicForm.controls['medicationeffectivedate'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['medicationeffectivedate'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['informedconsent'].enable();
        this.medicationpsychotropicForm.controls['informedconsent'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['informedconsent'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['diagnosis'].enable();
        this.medicationpsychotropicForm.controls['diagnosis'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['diagnosis'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['dosage'].enable();
        this.medicationpsychotropicForm.controls['dosage'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['dosage'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['frequency'].enable();
        this.medicationpsychotropicForm.controls['frequency'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['frequency'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['medicationname'].enable();
        this.medicationpsychotropicForm.controls['medicationname'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['medicationname'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['prescribingdoctor'].enable();
        this.medicationpsychotropicForm.controls['prescribingdoctor'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['prescribingdoctor'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['targetedsymptoms'].enable();
        this.medicationpsychotropicForm.controls['targetedsymptoms'].setValidators(Validators.required);
        this.medicationpsychotropicForm.controls['targetedsymptoms'].updateValueAndValidity();
        this.medicationpsychotropicForm.controls['isprescribercheck'].enable();
        this.medicationpsychotropicForm.controls['medicationtype'].enable();
        this.medicationpsychotropicForm.controls['prescribedduration'].enable();
      }else{
        this.showallotherfiled =false;
        this.showcompletesecondary =true;
      }
      if((!this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value  ==null || this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value == 'LDSS' ) && this.medicationpsychotropicForm.get('ismedicationpsychotropic')?.value === true){
        this.showsecondaryreviewcompleted =true;
        this.isldss=true;
      }else{
        this.showsecondaryreviewcompleted =false;
        this.isldss=false;
      }
        if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value) {
            if(this.healthCareDecisionMakerForm.get('healthcaredecision1')?.value == 'PAR') {
                this.isRequiredParentOrLegalGuardianButton = true ;
            } else {
                this.isRequiredParentOrLegalGuardianButton = false ;
                this.isRequiredParentOrLegalGuardianSection = false ;
                this.healthCareDecisionMakerForm.get('name2')?.reset();
                this.healthCareDecisionMakerForm.get('healthcaredecision2')?.reset();
                this.healthCareDecisionMakerForm.get('authorizedhcdm2')?.reset();
                this.healthCareDecisionMakerForm.get('email2')?.reset();
                this.healthCareDecisionMakerForm.get('phone2')?.reset();
                this.healthCareDecisionMakerForm.get('hcdmOther2')?.reset();
                this.address2 = {  disable: false, address1: null, address2: null, city: null, state: null, county: null, zipcode: null };

            }

            this.healthCareDecisionMakerForm.get('name1')?.enable();
            this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.enable();
            this.healthCareDecisionMakerForm.get('email1')?.enable();
            this.healthCareDecisionMakerForm.get('phone1')?.enable();
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.enable();
            this.address.disable = false;
        } else {
            this.isRequiredParentOrLegalGuardianButton = false ;
            this.isRequiredParentOrLegalGuardianSection = false ;
            this.healthCareDecisionMakerForm.get('name1')?.disable();
            this.healthCareDecisionMakerForm.get('authorizedhcdm1')?.disable();
            this.healthCareDecisionMakerForm.get('email1')?.disable();
            this.healthCareDecisionMakerForm.get('phone1')?.disable();
            this.healthCareDecisionMakerForm.get('hcdmOther1')?.disable();
            this.address.disable = true;
        }
    }
 
    onSort(event: any, from = ''){}

    callReDirect(event:any){
      const data = JSON.parse(event)
     
      const modal  = this.medicationpsychotropic.filter((x:any) =>x.personmedicpshychotropicid  ==data.personmedicpshychotropicid)
      switch(data.action){

      case 'View':
      this.view(modal[0],data.row)
      break;
      case 'Edit':this.edit(modal[0],data.row)
      break;    
      case 'Delete':this.confirmDelete(modal[0])
      break; 
      case 'AuditLog':this.auditTrail(modal[0])
      break; 
      case 'Refill':this.confirmRenewal(modal[0], data.row)
      break; 
      case 'MedicationChange':this.confirmChangeOfDate(modal[0],data.row)
      break; 
   
      
      }

    }
    onSortedlist(event: any) {
    event = JSON.parse(event);
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.searchandsortquery.sortDirection = event.sortDirection;
    this.searchandsortquery.sortColumn = event.sortColumn;
    this. getMedicationPsychotropicList();
  }
  getrefillmedicationist(){
  this._commonHttpService.getPagedArrayList({
      
      method: 'get',
      where: { personid: this.personId,
      
      }// CommonUrlConfig.EndPoint.PERSON.MEDICAL.psychotropicrenewallist
      //  --'personmedicalcondition/personmedicalrenewallist?filter'
    }, CommonUrlConfig.EndPoint.PERSON.MEDICAL.psychotropicrenewallist).subscribe(res => {
      this.refillmedication = res ? res.data : [];
      this.medicationpsychotropic =this.medicationpsychotropic.concat(this.refillmedication);

    

    this.loadlistDetails()
      this.medicationListCheck = this.medicationpsychotropic.find(item => item.personmedicpshychotropicid === this.medicationid);
      if (this.medicationListCheck && this.medicationid) {
          this.edit(this.medicationListCheck);
          this.medicationid = null;
      }
     
   
    });
      
  }
   getrefilldata(data:any){
      this.refilldata=[];
     this.refilldata = this.medicationpsychotropicData.filter((x:any)=>(x.Action.renewal ==true 
          
          && x.Action.personmedicpshychotropicparentid === data.personmedicpshychotropicid
                 
      ))
       const refillids = this.refilldata.map((item :any)=>item.Action.personmedicpshychotropicid)
       return refillids ;
      
    }
}
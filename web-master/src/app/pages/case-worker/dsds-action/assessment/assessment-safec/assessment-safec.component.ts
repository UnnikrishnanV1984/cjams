import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { ActivatedRoute, Router } from '@angular/router';
import { isCaseUuid } from '../../../../../@core/common/initializer';
import { GenericService, CommonHttpService, DataStoreService, SessionStorageService, CommonDropdownsService, AlertService, AuthService } from '../../../../../@core/services';
import { HttpService } from '../../../../../@core/services/http.service';
import { DomSanitizer } from '@angular/platform-browser';
import { Assessments, RoutingInfo } from '../../../_entities/caseworker.data.model';
import { FormBuilder, FormGroup, FormArray, FormControl, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AssessmentService } from '../assessment.service';
import moment from 'moment';
import _ from 'lodash';
import { OWL_DATE_TIME_FORMATS, OwlDateTimeComponent, OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { GlobalPopupComponent } from '../../../../../shared/shared-components/global-popup/global-popup.component';
import { GlobalPopupModule } from '../../../../../shared/shared-components/global-popup/global-popup.module';
import { CommonModule } from '@angular/common';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { ApprovalHistoryModule } from '../../../../../shared/shared-components/approval-history/approval-history.module';
import { AssessmentContactPurposeComponent } from '../assessment-contact-purpose/assessment-contact-purpose.component';
import { MatExpansionModule } from '@angular/material/expansion';
import { MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';
import { provideNgxMask } from 'ngx-mask';
import { NewUrlConfig } from '../../../../../../../src/app/pages/newintake/newintake-url.config';

export const MY_MOMENT_FORMATS = {
  parseInput: 'MM/DD/YYYY h:mm A',
  fullPickerInput: 'MM/DD/YYYY h:mm A',
  datePickerInput: 'MM/DD/YYYY h:mm A',
  timePickerInput: 'h:mm A',
  monthYearLabel: 'MMM YYYY',
  dateA11yLabel: 'LL',
  monthYearA11yLabel: 'MMMM YYYY',
};

export const CUSTOM_DATE_FORMATS: MatDateFormats = {
  parse: {
    dateInput: 'MM/DD/YYYY',
  },
  display: {
    dateInput: 'MM/DD/YYYY',
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY',
  },
}

@Component({
    selector: 'assessment-safec',
    templateUrl: './assessment-safec.component.html',
    styleUrls: ['./assessment-safec.component.scss'],
    imports:[GlobalPopupModule,ApprovalHistoryModule,MatRadioModule,MatCheckboxModule,MatFormFieldModule,MatInputModule,SignatureFieldModule,CommonModule,OwlDateTimeModule, OwlNativeDateTimeModule,OwlMomentDateTimeModule,MatSelectModule,ReactiveFormsModule,MatDatepickerModule,AssessmentContactPurposeComponent,FormsModule,MatExpansionModule ],
    providers:[provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
    standalone: true
})
export class AssessmentSafecComponent implements OnInit {
  @ViewChild('picker2') picker2!: OwlDateTimeComponent<any>;
  @ViewChild('picker1') picker1!: OwlDateTimeComponent<any>;
  @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent;
  ASSESSMENT_NAME = 'SAFE-C';
  submissiondata: any;
  involvedPerson: any[] = [];
  headofHouseholdDetails: any;
  caregiversList: any[] = [];
  // notCaregiverslist: any = [];
  allchilddetails: any[] = [];
  isServiceCase: any;
  roleId!: AppUser;
  agency!: string;
  isCW!: boolean;
  id: any;
  daNumber: any;
  currentAssessmentId: any;
  currentSubmissionId!: string;
  mifraData: any;  
  notChildListOriginal: any[] = [];
  childListOriginal: any[] = [];
  notChildList: any[] = [];   
  updateMifra!: boolean; 
  viewMifra!: boolean;
  enableSendForApproval: boolean = false;
  migratedCaseorNot: boolean = false;
  familyHOUSEHOLD: any[] = [];
  headofhouseholdid!: string;
  assessmentInitDate: any;
  relationships: any;
  //Approval and routing
  routingSupervisors: any[] = [];
  routingInfo!: RoutingInfo[];
  safeCForm!: FormGroup;
  currentDate: any;
 
  legalGuardian: any[] = [];
  isSupervisor!: boolean;
  assessmentStatus: any;
  caseworkersign: any;
  supervisorsign: any;
  incompleteList: any[] = [];
  caseworkersignature: any;
  supervisorsignature: any;
  enableChildDeceased: boolean = false;
  childDeceased: boolean = false;
  isChildLocatedByDept: boolean = false;
  requiredForApproval: boolean = false;
  deceasedChildName: any;
  dodOfDeceasedChild: any;
  childList: any[] = [];
  otherchildList: any[] = [];
  isValue: number = 1;
  currentdatetime = moment();
  form1080aalertdisplayed = false;

  contactNotes: any;
  //Caregivers
  caregiversInCase: any[] = [];

  dtformat1 = 'YYYY-MM-DDTHH:mm';
  dtformat2 = 'MM/DD/YYYY h:mm a';
  dtformat3 = 'YYYY-MM-DDTHH:mm:ss';
  validationmsg = 'Please Enter Child Information';
  ischildfatality = false;
  isseriousphysicalinjury = false;
  ismaltreatment = false;
  form1080aData: any = [];
  form1080aAlertMessage!: string;
  intakesdmproviderlength : any;
  sdmData : any;
  iscaseexpunged: any = 0;


  private readonly route: ActivatedRoute;
  private readonly _commonService: CommonHttpService
  public readonly sanitizer: DomSanitizer;
  private readonly _http: HttpService;
  private readonly _dataStoreService: DataStoreService;
  private readonly _router: Router;
  private readonly storage: SessionStorageService;
  private readonly _authService: AuthService;
  private readonly _alertService: AlertService;
  private readonly _commonDDService: CommonDropdownsService;
  private readonly _assessmentService: AssessmentService;
  private readonly _formBuilder: FormBuilder;

  constructor(
    private readonly injector : Injector,
    private readonly _service: GenericService<Assessments>
  ) {
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.sanitizer = this.injector.get<DomSanitizer>(DomSanitizer);
    this._http = this.injector.get<HttpService>(HttpService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._router = this.injector.get<Router>(Router);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._assessmentService = this.injector.get<AssessmentService>(AssessmentService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);

    this.id = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._commonDDService.getStoredCaseNumber();
    this.assessmentInitDate = moment(new Date()).format(this.dtformat1);
  }

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this._assessmentService.getservicecase();
    this.roleId = this._authService.getCurrentUser();
    this.agency = this._authService.getAgencyName();
    this.initSafeCForm();
    this.initFlags();
    this.mifraData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');

    this.checkMifraData();
    this.childDeceased = this.getChildDeceased();
    this.isChildLocatedByDept = this.getIsChildLocatedByDept();
    
    if(this.childDeceased) {
      this.isValue = 6
    } else if(this.isChildLocatedByDept) {
      this.isValue = 7
    }

    this.contactNotes = this._dataStoreService.getData('contact_action_info') ? this._dataStoreService.getData('contact_action_info').replace(/<\/?[^>]+(>|$)/g, "") : null;

    if (this.mifraData && (this.mifraData.mode === 'update' || this.mifraData.mode === 'submit')) {
      this.updateMifra = true;
    } else {
      this.updateMifra = false;
    }
    this.currentDate = moment(new Date()).format(this.dtformat1);
    this.currentAssessmentId = this.mifraData.assessmentid;
    this.currentSubmissionId = this.mifraData.submissionid;
    this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') ? this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') : [];
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.getInvolvedPerson();
    this.safeCForm.patchValue({ 
      dateassessmentinitiated: this.mifraData.submissiondata && this.mifraData.submissiondata.dateassessmentinitiated ? new Date(this.mifraData.submissiondata.dateassessmentinitiated) : new Date(this.assessmentInitDate),
      cpscaseid: this.daNumber,
      actionsTaken: this.contactNotes ? this.contactNotes : '',
      supervisorname: this._dataStoreService.getData('da_assignedby'),
      workersname: this.roleId.user.userprofile.fullname
    });
    this.safeCForm.get('workersname')?.disable();
    this.safeCForm.get('supervisorname')?.disable();
    

   // loading sdm data
    this.getSDM();
    // get form1080A data
    this.getForm1080A();
  }

  getSDM() {
    // Both sdm endpoints filter on a uuid column, so an unresolved this.id -- the
    // getStoredCaseUuid() fallback returns null when neither store key is set --
    // reaches Postgres as 22P02 and the api flattens that into a bare 400.
    if (!isCaseUuid(this.id)) {
        return;
    }
    let sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmvaluesUrl;
    let requestParam;
    if (this.isServiceCase) {
        sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmServiceCaseUrl; //'servicecase/getservicecasesdm';
        requestParam = {
            servicecaseid: this.id
        };
    } else {
        requestParam = {
            servicerequestid: this.id
        };
    }
    this._commonService
        .getArrayList(
            {
                method: 'get',
                where: requestParam
            },
            sdmUrl + '?filter'
        )
        .subscribe((res) => {
            if (res && res.length > 0) {
              let sdm;
              if (this.isServiceCase) {
                const i = res[0].getservicecasesdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                sdm = res[0].getservicecasesdm[i];
              } else {
                const i = res[0].getintakeservicerequestsdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                sdm = res[0].getintakeservicerequestsdm[i];
              }
              if (sdm) {
                this.ischildfatality = sdm?.ischildfatality;
                this.isseriousphysicalinjury = sdm?.isseriousphysicalinjury;
                this.ismaltreatment = sdm?.ismaltreatment;
                this.intakesdmproviderlength = sdm?.provider?.length;
              }
            }
        });
  }

  initFlags(){
    this.isSupervisor = (this.roleId.role.name === 'apcs') ? true : false;
    if(!this.isSupervisor) {
      this.safeCForm.get('supervisorcomments')?.disable();
    }
    if (this.isSupervisor) {
      this.enableSendForApproval = true;
    }
    if (this.agency === 'CW') {
      this.isCW = true;
    } else {
      this.isCW = false;
    }
  }

  checkMifraData(){
    const previousInfo = this.mifraData.intakassessment;
    if (previousInfo && previousInfo.length) {
      const filterApproveRecords = previousInfo.filter((item: { assessmentstatustypekey: string; }) => item.assessmentstatustypekey == 'Accepted');
      if (filterApproveRecords && filterApproveRecords.length) {
        // CDM-32241 Date of last safety plan
        const details = filterApproveRecords.filter((item: any) => item.submissiondata !==  null && (item.submissiondata.dangerInfluencesIdentified == 'safetydecision3' || item.submissiondata.dangerInfluencesIdentified == 'safetydecision2' ));
         const previosAssessmentDt = details[0]?.submissiondata ? details[0]?.submissiondata.safetyassessmentcompletiondate : null;
        if (previosAssessmentDt) {
         this.safeCForm.patchValue({ 
           dateoflastsafetyplan:  moment(previosAssessmentDt).format(this.dtformat1)
         });
        }
      }
    } else if (this.mifraData.username == 'Migrated') {
      this.migratedCaseorNot = true;
      this.getSubmisionData();
    }
  }

  getChildDeceased(){
    return this.mifraData.submissiondata && this.mifraData.submissiondata.childDeceased ? this.mifraData.submissiondata.childDeceased : false;
  }

  getIsChildLocatedByDept(){
    return this.mifraData.submissiondata && this.mifraData.submissiondata.childLocatedByDept ? this.mifraData.submissiondata.childLocatedByDept : false;
  }

  initSafeCForm() {
  this.safeCForm = this._formBuilder.group({
    unabletolocatechild: [null],
    childdeceased: [null],
    actionsTaken: [{value: null, disabled: true}],
    deceasedChildName: [{value: null, disabled: true}],
    columnsChildDod: [{value: null, disabled: true}],
    childdatagrid:  this._formBuilder.array([]),
    dateassessmentinitiated: [null],
    dateoflastsafetyplan: [{value: null, disabled: true}],
    caseheadsname: [null],
    cpscaseid: [null],
    headofhouseholdname: [null],
    relationship: [null],
    safeccaregivers: [null],
    cisid: [null],
    addchildren: this._formBuilder.array([]),
    cpscad: [null],
    cpscoi: [null],
    cpscsj: [null],
    cpsftf: [null],
    oohrch: [null],
    oohthv: [null],
    oohtta: [null],
    ihfbcar: [null],
    oohbccr: [null],
    oohbunsv: [null],
    cpslastsafetyplandt: [null],
    cpssafetyplan: [null],
    ihfsevendays: [null],
    oohcsafety: [null],
    oohscinc: [null],
    age05: [null],
    dpc: [null],
    significantdiagnosed: [null],
    childsextreme: [null],
    dmc: [null],
    schoolage: [null],
    caregiverfailstoprotect: [null],
    caregiverfailstoprotectnote: [null],
    caregivermadeaplausible: [null],
    caregivermadeaplausiblenote: [null],
    currentactofmaltreatment: [null],
    currentactofmaltreatmentnote: [null],
    childsexualabuse: [null],
    childsexualabusenote: [null],
    caregiverdescribes: [null],
    caregiverdescribesnote: [null],
    caregiverssuspected: [null],
    caregiverssuspectednote: [null],
    caregiversemotionalinstability: [null],
    caregiversemotionalinstabilitynote: [null],
    caregiversexplanation: [null],
    caregiversexplanationnote: [null],
    caregiversjustification: [null],
    caregiversjustificationnote: [null],
    caregiverrefuses: [null],
    caregiverrefusesnote: [null],
    domesticviolence: [null],
    domesticviolencenote: [null],
    childscurrentimminent: [null],
    childscurrentimminentnote: [null],
    childswhereabouts: [null],
    childswhereaboutsnote: [null],
    specialneeds: [null],
    specialneedsnote: [null],
    extremelyanxious: [null],
    extremelyanxiousnote: [null],
    unabletoprotect: [null],
    unabletoprotectnote: [null],
    servicestothecaregiver: [null],
    servicestothecaregivernote: [null],
    multiplereports: [null],
    multiplereportsnote: [null],
    dateofmultidisciplinary: [null],
    protectivecapacity1: [null],
    protectivecapacity2: [null],
    protectivecapacity3: [null],
    protectivecapacity4: [null],
    protectivecapacity5: [null],
    protectivecapacity6: [null],
    protectivecapacity7: [null],
    protectivecapacity8: [null],
    TF1: [null],
    TF2: [null],
    TF3: [null],
    TF4: [null],
    TF5: [null],
    TF6: [null],
    TF7: [null],
    TF8: [null],
    dangerInfluencesIdentified: [null],
    childisunsafe1: [null],
    childisunsafe2: [null],
    childisunsafe3: [null],
    childisunsafe4: [null],
    dangerinfluence1: [null],
    actionrequired1: [null],
    datetobecompleted1: [null],
    responsibleparties1: [null],
    reevaluationdate1: [null],
    dangerinfluence2: [null],
    actionrequired2: [null],
    datetobecompleted2: [null],
    responsibleparties2: [null],
    reevaluationdate2: [null],
    dangerinfluence3: [null],
    actionrequired3: [null],
    datetobecompleted3: [null],
    responsibleparties3: [null],
    reevaluationdate3: [null],
    dangerinfluence4: [null],
    actionrequired4: [null],
    datetobecompleted4: [null],
    responsibleparties4: [null],
    reevaluationdate4: [null],
    dangerinfluence5: [null],
    actionrequired5: [null],
    datetobecompleted5: [null],
    responsibleparties5: [null],
    reevaluationdate5: [null],
    dangerinfluence6: [null],
    actionrequired6: [null],
    datetobecompleted6: [null],
    responsibleparties6: [null],
    reevaluationdate6: [null],
    dangerinfluence7: [null],
    actionrequired7: [null],
    datetobecompleted7: [null],
    responsibleparties7: [null],
    reevaluationdate7: [null],
    dangerinfluence8: [null],
    actionrequired8: [null],
    datetobecompleted8: [null],
    responsibleparties8: [null],
    reevaluationdate8: [null],
    dangerinfluence9: [null],
    actionrequired9: [null],
    datetobecompleted9: [null],
    responsibleparties9: [null],
    reevaluationdate9: [null],
    dangerinfluence10: [null],
    actionrequired10: [null],
    datetobecompleted10: [null],
    responsibleparties10: [null],
    reevaluationdate10: [null],
    dangerinfluence11: [null],
    actionrequired11: [null],
    datetobecompleted11: [null],
    responsibleparties11: [null],
    reevaluationdate11: [null],
    dangerinfluence12: [null],
    actionrequired12: [null],
    datetobecompleted12: [null],
    responsibleparties12: [null],
    reevaluationdate12: [null],
    dangerinfluence13: [null],
    actionrequired13: [null],
    datetobecompleted13: [null],
    responsibleparties13: [null],
    reevaluationdate13: [null],
    dangerinfluence14: [null],
    actionrequired14: [null],
    datetobecompleted14: [null],
    responsibleparties14: [null],
    reevaluationdate14: [null],
    dangerinfluence15: [null],
    actionrequired15: [null],
    datetobecompleted15: [null],
    responsibleparties15: [null],
    reevaluationdate15: [null],
    dangerinfluence16: [null],
    actionrequired16: [null],
    datetobecompleted16: [null],
    responsibleparties16: [null],
    reevaluationdate16: [null],
    dangerinfluence17: [null],
    actionrequired17: [null],
    datetobecompleted17: [null],
    responsibleparties17: [null],
    reevaluationdate17: [null],
    dangerinfluence18: [null],
    actionrequired18: [null],
    datetobecompleted18: [null],
    responsibleparties18: [null],
    reevaluationdate18: [null],
    associatedetails: this._formBuilder.array([]),
    supervisorname: [null],
    workersname: [null],
    ldss: [null],
    assessmentreviewed: ['InProcess'],
    assessmentStaus: ['InProcess'],
    caseworkersignature: [null],
    reroutesupervisor: [null],
    safetyassessmentapprovaldate: [{value: null, disabled: true}],
    safetyassessmentcompletiondate: [null],
    assessmentstatus: [null],
    supervisorrsignature: [null],
    caseworkercomments: [null],
    supervisorcomments: [null],

    submissionapprovaldate: [{value: null, disabled: true}]

  });
  
}


getSubmisionData() {
  const url = `admin/assessment/getassessmentform/${this.mifraData.external_templateid}/submission/${this.mifraData.submissionid}`;
  this._commonService.getSingle({}, url).subscribe(result => {
    
    //Replace submissiondata from assessment table with the parsed json from transaction table
    // this.cansFData.submissiondata = result;
    this.submissiondata = result;
    this.mifraData.submissiondata  = result;
  });
}

changeChildLocation(event: any, value: any){
  if (value == 'U') {
    this.safeCForm.get('childdeceased')?.reset();
    if(event.checked) {
      this.isChildLocatedByDept = true;
    } else {
      this.isChildLocatedByDept = false;
    }
  } else if (value == 'D') {
    this.safeCForm.get('unabletolocatechild')?.reset();
    if(event.checked) {
      this.childDeceased = true;
    } else {
      this.childDeceased = false;
    }
    if( this.deceasedChildName && this.childDeceased) {
      this.safeCForm.patchValue({
        deceasedChildName: this.deceasedChildName,
        columnsChildDod: this.dodOfDeceasedChild
      });
    }

  }
}

removeSignature(event: any, index: any, field: any) {
  if (event.checked) {
    (<FormArray>this.safeCForm.get('associatedetails')).controls[index].patchValue({
      sign: false
    });
    if (field == 'R') {
      (<FormArray>this.safeCForm.get('associatedetails')).controls[index].patchValue({
        UnavailabletoSign: false,
        SignatureUploaded: false
      });
    } else if (field == 'U') {
      (<FormArray>this.safeCForm.get('associatedetails')).controls[index].patchValue({
        refusetosign: false,
        SignatureUploaded: false
      });
    } else if (field == 'S') {
      (<FormArray>this.safeCForm.get('associatedetails')).controls[index].patchValue({
        refusetosign: false,
        UnavailabletoSign: false
      });
    }
  } else {
    (<FormArray>this.safeCForm.get('associatedetails')).controls[index].patchValue({
      signature: null,
      sign: true
    });
  }
}

calculateSafeOrUnsafe() {
  const safeCdetails = this.safeCForm.getRawValue();
  if(safeCdetails.servicestothecaregiver == 'yes' || safeCdetails.multiplereports == 'yes') {
    this.safeCForm.patchValue({
      dangerInfluencesIdentified: 'safetydecision3'
    });

  }
  else if (safeCdetails.caregiverfailstoprotect == 'no' &&  safeCdetails.caregivermadeaplausible == 'no' && safeCdetails.currentactofmaltreatment == 'no' && 
  safeCdetails.childsexualabuse == 'no' &&  safeCdetails.caregiverdescribes == 'no' && safeCdetails.caregiverssuspected == 'no' && 
  safeCdetails.caregiversemotionalinstability == 'no' &&  safeCdetails.caregiversexplanation == 'no' && safeCdetails.caregiversjustification == 'no' &&
  safeCdetails.caregiverrefuses == 'no' &&  safeCdetails.domesticviolence == 'no' && safeCdetails.childscurrentimminent == 'no'&& 
  safeCdetails.childswhereabouts == 'no' &&  safeCdetails.specialneeds == 'no' && safeCdetails.extremelyanxious == 'no' && 
  safeCdetails.unabletoprotect == 'no' &&  safeCdetails.servicestothecaregiver == 'no' && safeCdetails.multiplereports == 'no'
  ) {
    this.safeCForm.patchValue({
      dangerInfluencesIdentified: 'safetydecision1'
    });
  } else if (safeCdetails.caregiverfailstoprotect == 'yes' ||  safeCdetails.caregivermadeaplausible == 'yes' || safeCdetails.currentactofmaltreatment == 'yes' || 
  safeCdetails.childsexualabuse == 'yes' ||  safeCdetails.caregiverdescribes == 'yes' || safeCdetails.caregiverssuspected == 'yes' || 
  safeCdetails.caregiversemotionalinstability == 'yes' || safeCdetails.caregiversexplanation == 'yes' || safeCdetails.caregiversjustification == 'yes' ||
  safeCdetails.caregiverrefuses == 'yes' ||  safeCdetails.domesticviolence == 'yes' || safeCdetails.childscurrentimminent == 'yes' || 
  safeCdetails.childswhereabouts == 'yes' ||  safeCdetails.specialneeds == 'yes' || safeCdetails.extremelyanxious == 'yes' || 
  safeCdetails.unabletoprotect == 'yes') {
    this.safeCForm.patchValue({
      dangerInfluencesIdentified: 'safetydecision2'
    });
  }

  if (safeCdetails.caregiverfailstoprotect == 'no' ||  safeCdetails.caregivermadeaplausible == 'no' || safeCdetails.currentactofmaltreatment == 'no' || 
  safeCdetails.childsexualabuse == 'no' ||  safeCdetails.caregiverdescribes == 'no' || safeCdetails.caregiverssuspected == 'no' ||
  safeCdetails.caregiversemotionalinstability == 'no' ||  safeCdetails.caregiversexplanation == 'no' || safeCdetails.caregiversjustification == 'no' ||
  safeCdetails.caregiverrefuses == 'no' ||  safeCdetails.domesticviolence == 'no' || safeCdetails.childscurrentimminent == 'no' ||
  safeCdetails.childswhereabouts == 'no' ||  safeCdetails.specialneeds == 'no' || safeCdetails.extremelyanxious == 'no' || 
  safeCdetails.unabletoprotect == 'no' ||  safeCdetails.servicestothecaregiver == 'no' || safeCdetails.multiplereports == 'no'
  ) {
    this.resetMandateFields();
  }
  
}

radioBtnChange(event: any) {
  if(event.value == 'safetydecision4') {
    this.resetMandateFields();
  }
}

statusChange(event: any) {
  this.safeCForm.patchValue({ 
    safetyassessmentapprovaldate:  moment(new Date()).format(this.dtformat3)
  });
}


resetMandateFields() {
  this.resetMandateFieldsQuestion1to6();
  this.resetMandateFieldsQuestion7to12();
  this.resetMandateFieldsQuestion13to18();
  
}

  resetMandateFieldsQuestion1to6() {
    const safeCdetails = this.safeCForm.getRawValue();
    // Reseting Question 1 Required values
    if (safeCdetails.caregiverfailstoprotect == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregiverfailstoprotectnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence1'].clearValidators();
      this.safeCForm.controls['actionrequired1'].clearValidators();
      this.safeCForm.controls['datetobecompleted1'].clearValidators();
      this.safeCForm.controls['responsibleparties1'].clearValidators();
      this.safeCForm.controls['reevaluationdate1'].clearValidators();
      this.safeCForm.controls['caregiverfailstoprotectnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence1'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired1'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted1'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties1'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate1'].updateValueAndValidity();
    }

    // Reseting Question 2 Required values
    if (safeCdetails.caregivermadeaplausible == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregivermadeaplausiblenote'].clearValidators();
      this.safeCForm.controls['dangerinfluence2'].clearValidators();
      this.safeCForm.controls['actionrequired2'].clearValidators();
      this.safeCForm.controls['datetobecompleted2'].clearValidators();
      this.safeCForm.controls['responsibleparties2'].clearValidators();
      this.safeCForm.controls['reevaluationdate2'].clearValidators();
      this.safeCForm.controls['caregivermadeaplausiblenote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence2'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired2'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted2'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties2'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate2'].updateValueAndValidity();
    }

    // Reseting Question 3 Required values
    if (safeCdetails.currentactofmaltreatment == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['currentactofmaltreatmentnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence3'].clearValidators();
      this.safeCForm.controls['actionrequired3'].clearValidators();
      this.safeCForm.controls['datetobecompleted3'].clearValidators();
      this.safeCForm.controls['responsibleparties3'].clearValidators();
      this.safeCForm.controls['reevaluationdate3'].clearValidators();
      this.safeCForm.controls['currentactofmaltreatmentnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence3'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired3'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted3'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties3'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate3'].updateValueAndValidity();
    }


    // Reseting Question 4 Required values
    if (safeCdetails.childsexualabuse == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['childsexualabusenote'].clearValidators();
      this.safeCForm.controls['dangerinfluence4'].clearValidators();
      this.safeCForm.controls['actionrequired4'].clearValidators();
      this.safeCForm.controls['datetobecompleted4'].clearValidators();
      this.safeCForm.controls['responsibleparties4'].clearValidators();
      this.safeCForm.controls['reevaluationdate4'].clearValidators();
      this.safeCForm.controls['childsexualabusenote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence4'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired4'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted4'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties4'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate4'].updateValueAndValidity();
    }

    // Reseting Question 5 Required values
    if (safeCdetails.caregiverdescribes == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregiverdescribesnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence5'].clearValidators();
      this.safeCForm.controls['actionrequired5'].clearValidators();
      this.safeCForm.controls['datetobecompleted5'].clearValidators();
      this.safeCForm.controls['responsibleparties5'].clearValidators();
      this.safeCForm.controls['reevaluationdate5'].clearValidators();
      this.safeCForm.controls['caregiverdescribesnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence5'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired5'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted5'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties5'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate5'].updateValueAndValidity();
    }


    // Reseting Question 6 Required values
    if (safeCdetails.caregiverssuspected == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregiverssuspectednote'].clearValidators();
      this.safeCForm.controls['dangerinfluence6'].clearValidators();
      this.safeCForm.controls['actionrequired6'].clearValidators();
      this.safeCForm.controls['datetobecompleted6'].clearValidators();
      this.safeCForm.controls['responsibleparties6'].clearValidators();
      this.safeCForm.controls['reevaluationdate6'].clearValidators();
      this.safeCForm.controls['caregiverssuspectednote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence6'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired6'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted6'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties6'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate6'].updateValueAndValidity();
    }
  }

  resetMandateFieldsQuestion7to12() {
    const safeCdetails = this.safeCForm.getRawValue();
    // Reseting Question 7 Required values
    if (safeCdetails.caregiversemotionalinstability == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregiversemotionalinstabilitynote'].clearValidators();
      this.safeCForm.controls['dangerinfluence7'].clearValidators();
      this.safeCForm.controls['actionrequired7'].clearValidators();
      this.safeCForm.controls['datetobecompleted7'].clearValidators();
      this.safeCForm.controls['responsibleparties7'].clearValidators();
      this.safeCForm.controls['reevaluationdate7'].clearValidators();
      this.safeCForm.controls['caregiversemotionalinstabilitynote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence7'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired7'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted7'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties7'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate7'].updateValueAndValidity();
    }

    // Reseting Question 8 Required values
    if (safeCdetails.caregiversexplanation == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregiversexplanationnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence8'].clearValidators();
      this.safeCForm.controls['actionrequired8'].clearValidators();
      this.safeCForm.controls['datetobecompleted8'].clearValidators();
      this.safeCForm.controls['responsibleparties8'].clearValidators();
      this.safeCForm.controls['reevaluationdate8'].clearValidators();
      this.safeCForm.controls['caregiversexplanationnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence8'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired8'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted8'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties8'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate8'].updateValueAndValidity();
    }

    // Reseting Question 9 Required values
    if (safeCdetails.caregiversjustification == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregiversjustificationnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence9'].clearValidators();
      this.safeCForm.controls['actionrequired9'].clearValidators();
      this.safeCForm.controls['datetobecompleted9'].clearValidators();
      this.safeCForm.controls['responsibleparties9'].clearValidators();
      this.safeCForm.controls['reevaluationdate9'].clearValidators();
      this.safeCForm.controls['caregiversjustificationnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence9'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired9'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted9'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties9'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate9'].updateValueAndValidity();
    }

    // Reseting Question 10 Required values
    if (safeCdetails.caregiverrefuses == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['caregiverrefusesnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence10'].clearValidators();
      this.safeCForm.controls['actionrequired10'].clearValidators();
      this.safeCForm.controls['datetobecompleted10'].clearValidators();
      this.safeCForm.controls['responsibleparties10'].clearValidators();
      this.safeCForm.controls['reevaluationdate10'].clearValidators();
      this.safeCForm.controls['caregiverrefusesnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence10'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired10'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted10'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties10'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate10'].updateValueAndValidity();
    }

    // Reseting Question 11 Required values
    if (safeCdetails.domesticviolence == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['domesticviolencenote'].clearValidators();
      this.safeCForm.controls['dangerinfluence11'].clearValidators();
      this.safeCForm.controls['actionrequired11'].clearValidators();
      this.safeCForm.controls['datetobecompleted11'].clearValidators();
      this.safeCForm.controls['responsibleparties11'].clearValidators();
      this.safeCForm.controls['reevaluationdate11'].clearValidators();
      this.safeCForm.controls['domesticviolencenote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence11'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired11'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted11'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties11'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate11'].updateValueAndValidity();
    }


    // Reseting Question 12 Required values
    if (safeCdetails.childscurrentimminent == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['childscurrentimminentnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence12'].clearValidators();
      this.safeCForm.controls['actionrequired12'].clearValidators();
      this.safeCForm.controls['datetobecompleted12'].clearValidators();
      this.safeCForm.controls['responsibleparties12'].clearValidators();
      this.safeCForm.controls['reevaluationdate12'].clearValidators();
      this.safeCForm.controls['childscurrentimminentnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence12'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired12'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted12'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties12'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate12'].updateValueAndValidity();
    }
  }

  resetMandateFieldsQuestion13to18() {
    const safeCdetails = this.safeCForm.getRawValue();
    // Reseting Question 13 Required values
    if (safeCdetails.childswhereabouts == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['childswhereaboutsnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence13'].clearValidators();
      this.safeCForm.controls['actionrequired13'].clearValidators();
      this.safeCForm.controls['datetobecompleted13'].clearValidators();
      this.safeCForm.controls['responsibleparties13'].clearValidators();
      this.safeCForm.controls['reevaluationdate13'].clearValidators();
      this.safeCForm.controls['childswhereaboutsnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence13'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired13'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted13'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties13'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate13'].updateValueAndValidity();
    }

    // Reseting Question 14 Required values
    if (safeCdetails.specialneeds == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['specialneedsnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence14'].clearValidators();
      this.safeCForm.controls['actionrequired14'].clearValidators();
      this.safeCForm.controls['datetobecompleted14'].clearValidators();
      this.safeCForm.controls['responsibleparties14'].clearValidators();
      this.safeCForm.controls['reevaluationdate14'].clearValidators();
      this.safeCForm.controls['specialneedsnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence14'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired14'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted14'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties14'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate14'].updateValueAndValidity();
    }

    // Reseting Question 15 Required values
    if (safeCdetails.extremelyanxious == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['extremelyanxiousnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence15'].clearValidators();
      this.safeCForm.controls['actionrequired15'].clearValidators();
      this.safeCForm.controls['datetobecompleted15'].clearValidators();
      this.safeCForm.controls['responsibleparties15'].clearValidators();
      this.safeCForm.controls['reevaluationdate15'].clearValidators();
      this.safeCForm.controls['extremelyanxiousnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence15'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired15'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted15'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties15'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate15'].updateValueAndValidity();
    }

    // Reseting Question 16 Required values
    if (safeCdetails.unabletoprotect == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['unabletoprotectnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence16'].clearValidators();
      this.safeCForm.controls['actionrequired16'].clearValidators();
      this.safeCForm.controls['datetobecompleted16'].clearValidators();
      this.safeCForm.controls['responsibleparties16'].clearValidators();
      this.safeCForm.controls['reevaluationdate16'].clearValidators();
      this.safeCForm.controls['unabletoprotectnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence16'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired16'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted16'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties16'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate16'].updateValueAndValidity();
    }

    // Reseting Question 17 Required values
    if (safeCdetails.servicestothecaregiver == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['servicestothecaregivernote'].clearValidators();
      this.safeCForm.controls['dangerinfluence17'].clearValidators();
      this.safeCForm.controls['actionrequired17'].clearValidators();
      this.safeCForm.controls['datetobecompleted17'].clearValidators();
      this.safeCForm.controls['responsibleparties17'].clearValidators();
      this.safeCForm.controls['reevaluationdate17'].clearValidators();
      this.safeCForm.controls['servicestothecaregivernote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence17'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired17'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted17'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties17'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate17'].updateValueAndValidity();
    }

    // Reseting Question 18 Required values
    if (safeCdetails.multiplereports == 'no' || safeCdetails.dangerInfluencesIdentified == 'safetydecision4') {
      this.safeCForm.controls['multiplereportsnote'].clearValidators();
      this.safeCForm.controls['dangerinfluence18'].clearValidators();
      this.safeCForm.controls['actionrequired18'].clearValidators();
      this.safeCForm.controls['datetobecompleted18'].clearValidators();
      this.safeCForm.controls['responsibleparties18'].clearValidators();
      this.safeCForm.controls['reevaluationdate18'].clearValidators();
      this.safeCForm.controls['multiplereportsnote'].updateValueAndValidity();
      this.safeCForm.controls['dangerinfluence18'].updateValueAndValidity();
      this.safeCForm.controls['actionrequired18'].updateValueAndValidity();
      this.safeCForm.controls['datetobecompleted18'].updateValueAndValidity();
      this.safeCForm.controls['responsibleparties18'].updateValueAndValidity();
      this.safeCForm.controls['reevaluationdate18'].updateValueAndValidity();
    }
  }

  mfiraPatch() {
    if (this.mifraData && this.mifraData.submissiondata) {
      this.submissiondata = this.mifraData.submissiondata;
    } else {
      this.getRolesAndRelation();
    }
    this._dataStoreService.setData('PRINTDATA', this.submissiondata);

    if (this.mifraData && (this.mifraData.mode === 'update' || this.mifraData.mode === 'submit')) {
      this.viewMifra = false;
      if (this.mifraData && this.mifraData.submissiondata) {
        this.setMIFRAInfo();
        this.safCFormPatchFromMIFRA();
      }
    }
    if (this.mifraData && this.mifraData.mode === 'submit') {
      this.viewMifra = true;
      this.safeCForm.disable();  
    }
    if (this.migratedCaseorNot) {
      this.viewMifra = true;
      this.safeCForm.disable();  
    }
  }

  setMIFRAInfo() {
    if (this.mifraData.submissiondata.dateassessmentinitiated) {
      this.mifraData.submissiondata.dateassessmentinitiated = moment(this.mifraData.submissiondata.dateassessmentinitiated).format(this.dtformat1);
    }
    if (this.mifraData.submissiondata.dateoflastsafetyplan) {
      this.mifraData.submissiondata.dateoflastsafetyplan = moment(this.mifraData.submissiondata.dateoflastsafetyplan).format(this.dtformat1);
    }
    if (this.mifraData.submissiondata.safetyassessmentapprovaldate) {
      this.mifraData.submissiondata.safetyassessmentapprovaldate = moment(this.mifraData.submissiondata.safetyassessmentapprovaldate).format(this.dtformat3);
    }
    if (this.mifraData.submissiondata.safetyassessmentcompletiondate) {
      this.mifraData.submissiondata.safetyassessmentcompletiondate = this.mifraData.submissiondata.safetyassessmentcompletiondate;
    }
  }

  safCFormPatchFromMIFRA(){
    if(this.mifraData.submissiondata.dangerInfluencesIdentified === 'childIsUnsafe') {
      this.mifraData.submissiondata.dangerInfluencesIdentified = 'safetydecision4';
    }
    this.safeCForm.patchValue(this.mifraData.submissiondata);
    if (this.submissiondata.childdeceased) {
      this.safeCForm.patchValue({
        columnsChildDod: this.dodOfDeceasedChild
      });
    }
    if (this.submissiondata.unabletolocatechild) {
      this.safeCForm.patchValue({
        actionsTaken: this.contactNotes ? this.contactNotes : '',
      });
    }
    if (!this.submissiondata.headofhouseholdname) {
      this.safeCForm.patchValue({
        headofhouseholdname: this.getFullName(this.headofHouseholdDetails),
      });
    }
    if (this.submissiondata.assessmentstatus == 'Accepted') {
      this.safeCForm.patchValue({
        relationship: this.submissiondata.relationship ? this.submissiondata.relationship : '',
      });
    } else {
      this.getRolesAndRelation();
    }

    if (!this.submissiondata.caseheadsname && this.legalGuardian && this.legalGuardian.length && this.submissiondata.assessmentstatus !== 'Accepted') {
      this.getRolesAndRelation();
    }

    this.getMIFRAChildList();

    if (this.mifraData.submissiondata.childdatagrid) {
      this.safeCForm.patchValue(this.mifraData.submissiondata.childdatagrid);
      this.mifraData.submissiondata.childdatagrid.forEach((data: any) => {
        this.addFamily(data);
      });
    }
    if (this.mifraData.submissiondata.addchildren) {
      this.safeCForm.patchValue(this.mifraData.submissiondata.addchildren);
      this.mifraData.submissiondata.addchildren.forEach((data: any) => {
        this.addOtherFamily(data);
      });
    }
    if (this.mifraData.submissiondata.associatedetails) {
      this.safeCForm.patchValue(this.mifraData.submissiondata.associatedetails);
      this.mifraData.submissiondata.associatedetails.forEach((data: any) => {
        this.addAssociatedDetails(data);
      });
    }
  }

  getMIFRAChildList(){
    if (this.safeCForm.get('assessmentstatus')?.value == 'Accepted' && this.mifraData.submissiondata.all_childs_json && this.mifraData.submissiondata.all_childs_json.length) {
      this.childList = [];
      this.otherchildList = [];
      let childpayloadjson = [];
      if (typeof this.mifraData.submissiondata.all_childs_json == 'string') {
        childpayloadjson = JSON.parse(this.mifraData.submissiondata.all_childs_json);
      } else {
        childpayloadjson = this.mifraData.submissiondata.all_childs_json;
      }
      childpayloadjson.forEach((element: { fullname: any; name: string; seconeage: any; age: any; namecheck: any; }) => {
        element.fullname = element.name.trim();
        element.seconeage = element.age;
        element.namecheck = element.name.trim();
      });
      this.childList = childpayloadjson;
      this.otherchildList = childpayloadjson;
    }
  }

  removeAddedCaregiver() {
    const control = this.safeCForm.controls['safeccaregivers'].value;
    const noDuplicates = _.uniqBy(this.notChildListOriginal, 'fullname');
    this.notChildList[control.length] = noDuplicates;
    if (control && control.length > 0) {
      control.forEach((data: any) => {
        this.notChildList[control.length] = this.notChildList[control.length].filter((ele: { intakeservicerequestactorid: any; }) => ele.intakeservicerequestactorid !== data.caregivername);
      });
    } else {
      this.notChildList[0] = noDuplicates;
    }
  }

  deleteLegalGuardian(i: number) {
    const control = this.safeCForm.controls['safeccaregivers'].value;
    const oridata = this.notChildListOriginal.find(data => data.intakeservicerequestactorid === control[i].caregivername);
    if (control && control.length > 0) {
      control.forEach((element: any, index: any) => {
        if (oridata) {
          if (i < control.length && index !== (control.length - 1)) {
            this.setNotChildListWithCareGiver(control, index);
          } else {
            this.setNotChildListWithoutCareGiver(oridata, index);
          }
        }
      });
    }
    const controldata = <FormArray>this.safeCForm.controls['safeccaregivers'];
    controldata.removeAt(i);
  }

  setNotChildListWithCareGiver(control: any, index: any){
    const oridatas = this.notChildListOriginal.find(data => data.intakeservicerequestactorid === control[index + 1].caregivername);            
    const notchildlist = oridatas ? this.notChildList[index].find((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid === oridatas.intakeservicerequestactorid) : null;
    if (!notchildlist) {
      this.notChildList[index].push(oridatas);
    }
  }

  setNotChildListWithoutCareGiver(oridata: any, index: any){
    const notchildlist = this.notChildList[index].find((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid === oridata.intakeservicerequestactorid);
    if (!notchildlist) {
      this.notChildList[index].push(oridata);
    }
  }

  private createFormGroupNew() {
    return this._formBuilder.group({
      caregivername: null,
      caregiverdob: null,
      caregiverage: null,
      caregiverrelationship: null
    });
}

  addFamily(model: any) {
    const modelData: any = this.createFormGroup(model);
    if(modelData) {
      const control = this.safeCForm.get('childdatagrid') as FormArray;
      if (control) {
        control.push(modelData);
      }
    }
  }

  deleteFamily(index: number) {
    const control = <FormArray>this.safeCForm.controls['childdatagrid'];
    control.removeAt(index);
  }

  addOtherFamily(model: any) {
    const control = this.safeCForm.get('addchildren') as FormArray;
    control.push(this.createOtherFormGroup(model));
  }

  deleteOtherFamily(index: number) {
    const control = <FormArray>this.safeCForm.controls['addchildren'];
    control.removeAt(index);
  }

  addAssociatedDetails(model: any) {
    const control = this.safeCForm.get('associatedetails') as FormArray;
    control.push(this.createADFormGroup(model));
  }

  deleteAssociatedDetails(index: number) {
    const control = <FormArray>this.safeCForm.controls['associatedetails'];
    control.removeAt(index);
  }

  private createFormGroup(modal: any) {
    if (this.updateMifra) {
      const filterToget = this.filterToget(modal);
      if(filterToget && filterToget.length || _.isEmpty(modal)) {
        return this._formBuilder.group({
          clientid: this.nullCheck(modal.clientid),
          age: this.nullCheck(modal.age),
          childname: filterToget && filterToget.length ? filterToget[0].fullname : this.nullCheck(modal.childname),
        });
      } else {
        return null;
      }
    } else {
      return this._formBuilder.group({
        clientid: this.nullCheck(modal.cjamspid),
        age: this.nullCheck(modal.age),
        childname: this.nullCheck(modal.fullname),
      });
    }
  }
  nullCheck(inputData: any){
    return inputData ? inputData : '';
  }

  filterToget(modal: any) {
    let filterToget = [];
    if (this.migratedCaseorNot) {
      filterToget = this.involvedPerson.filter(item => item.fullname.toUpperCase() == modal.childname.trim().toUpperCase());
      if (filterToget && filterToget.length) {
        this.childList.push(filterToget[0]);
      }
    } else {
      filterToget = this.childList.filter(item => item.cjamspid == modal.clientid);
    }

    return filterToget;
  }

  private createOtherFormGroup(modal: any) {
    if (this.updateMifra) {

      if(modal.seconename) {
        return this.createOtherFormGroupSeconename(modal);
      } else {
        const filterToget = this.otherchildList;

        return this._formBuilder.group({
          seconename: filterToget && filterToget.length ? filterToget[0].fullname :'',
          seconeage: filterToget && filterToget.length ? filterToget[0].age : '',
        });
      }
    } else {
      return this._formBuilder.group({
        seconename: this.getSeconenameFromModal(modal),
        seconeage: this.getSeconeageFromModal(modal),
      });
    }
  }

  getSeconenameFromModal(modal: { seconename: any; }){
    return modal.seconename ? modal.seconename : '';
  }

  getSeconeageFromModal(modal: { seconeage: any; }){
    return modal.seconeage ? modal.seconeage : '';
  }

  createOtherFormGroupSeconename(modal: any) {
    let filterToget = [];
    if (this.migratedCaseorNot) {
      filterToget = this.involvedPerson.filter(item => item.namecheck.toUpperCase() == modal.seconename.trim().toUpperCase());
      if (filterToget && filterToget.length) {
        filterToget[0].seconeage = this.getSeconeageFromModal(modal);
        this.otherchildList.push(filterToget[0]);
      }
    } else {
      filterToget = this.otherchildList.filter(item => item.namecheck == modal.seconename.trim());
    }
    return this._formBuilder.group({
      seconename: this.getSeconenameFromPerson(filterToget, modal),
      seconeage: this.getSeconeageFromPerson(filterToget, modal),
    });
  }

  getSeconenameFromPerson(filterToget: any, modal: any){
    return filterToget && filterToget.length ? filterToget[0].fullname : this.nullCheck(modal.seconename);
  }

  getSeconeageFromPerson(filterToget: any, modal: any){
    return filterToget && filterToget.length ? filterToget[0].seconeage : this.nullCheck(modal.seconeage);
  }

  private createADFormGroup(modal: any) {
    if(this.updateMifra) {
      return this._formBuilder.group({
      date: this.getADFormGroupDate(modal),
      sign: this.getADFormGroupSign(modal),
      title: this.getADFormGroupTitle(modal),
      signature: this.getADFormGroupSignature(modal),
      printedname: this.getADFormGroupPrintedname(modal),
      refusetosign: this.getADFormGroupRefusetosign(modal),
      SignatureUploaded: this.getADFormGroupSignatureUploaded(modal),
      UnavailabletoSign: this.getADFormGroupUnavailabletoSign(modal),
      intakeservicerequestactorid: this.getADFormGroupActorid(modal)
      });
    } else  {
      
      return this._formBuilder.group({
        date: this.getADFormGroupDate(modal),
        sign: true,
        title: this.getADFormGroupRoles(modal),
        signature: this.getADFormGroupSignature(modal),
        printedname: this.getADFormGroupFullname(modal),
        refusetosign: this.getADFormGroupRefusetosign(modal),
        SignatureUploaded: this.getADFormGroupSignatureUploaded(modal),
        UnavailabletoSign: this.getADFormGroupUnavailabletoSign(modal),
        intakeservicerequestactorid: this.getADFormGroupActorid(modal),
        });
    }
  }

  getADFormGroupDate(modal: any){
    return modal.date ? modal.date : '';
  }

  getADFormGroupRoles(modal: any){
    return modal.roles && modal.roles.length ? modal.roles[0].typedescription : '';
  }

  getADFormGroupSign(modal: any){
    return (modal.refusetosign  || modal.SignatureUploaded || modal.UnavailabletoSign) ? false : true;
  }

  getADFormGroupTitle(modal: any){
    return modal.title ? modal.title : '';
  }

  getADFormGroupSignature(modal: any){
    return modal.signature ? modal.signature : '';
  }

  getADFormGroupPrintedname(modal: any){
    return modal.printedname ? modal.printedname : '';
  }

  getADFormGroupFullname(modal: any){
    return modal.fullname ? modal.fullname : '';
   }

  getADFormGroupRefusetosign(modal: any){
    return modal.refusetosign ? modal.refusetosign : '';
  }

  getADFormGroupSignatureUploaded(modal: any){
    return modal.SignatureUploaded ? modal.SignatureUploaded : '';
  }

  getADFormGroupUnavailabletoSign(modal: any){
    return modal.UnavailabletoSign ? modal.UnavailabletoSign : '';
  }

  getADFormGroupActorid(modal: any){
    return modal.intakeservicerequestactorid ? modal.intakeservicerequestactorid : '';
  }
 
  getCansfData() {
    if (this.mifraData && (this.mifraData.mode === 'update' || this.mifraData.mode === 'submit')) {
      this.updateMifra = true;
      this.viewMifra = false;
 
    } else {
      this.updateMifra = false;
      this.viewMifra = false;
    }
    if (this.mifraData && this.mifraData.mode === 'submit') {
      this.updateMifra = true;
      this.viewMifra = true;

    }
  }

  getAssessmentActors(familyArray: any) {
    const assessmentactorArray: any[] = [];
    familyArray.forEach((member: { intakeservicerequestactorid: any; }) => {
          assessmentactorArray.push({
            'intakeservicerequestactorid': member.intakeservicerequestactorid? member.intakeservicerequestactorid:null
          });
        }
    );
    return assessmentactorArray;
  }

  checkDateTime(start: any, end: any): boolean {
    const startDate = moment(start);
    const endDate = moment(end);
    return endDate.isBefore(startDate)
  }

  saveForm() {
    const mfiraData = this.safeCForm.getRawValue();
    if(this.checkDateTime(mfiraData.dateassessmentinitiated, mfiraData.safetyassessmentcompletiondate)){
      this._alertService.error("Safety Assessment Completion Date & Time is lesser than Date Time Assessment Initiated");
      return;
    }
    if ((this.safeCForm.get('childdatagrid') as FormArray)?.controls.length == 0) {
      this._alertService.error(this.validationmsg);
      return;
    }
    mfiraData.currentSubmissionId = this.currentSubmissionId;
    mfiraData.assessmentStatus = this.assessmentStatus;
    mfiraData.routingsupervisors =  this.routingSupervisors;
    const selectedchild: any[] = [];
    mfiraData.childdatagrid.forEach((element: { clientid: any; }) => {
      if (element.clientid) {
        const child = this.childList.filter(item => item.cjamspid == element.clientid);
        selectedchild.push(child[0]);
      }
    });
      if (selectedchild && selectedchild.length) {
        mfiraData.assessmentactor = this.getAssessmentActors(selectedchild);
      } else {
        this._alertService.error(this.validationmsg);
        return;
      }

    mfiraData.all_childs_json = this.allchilddetails;
    this._dataStoreService.setData('PRINTDATA', mfiraData);
    this._assessmentService.saveSafecAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, mfiraData)
      .subscribe(
        (response) => {
          if (response.data) {
            this.currentAssessmentId = response.data.assessmentid;
            this.currentSubmissionId = response.data.submissionid;
          } else {
            this.currentAssessmentId = response.assessmentid;
            this.currentSubmissionId = response.submissionid;
          }
          this.enableSendForApproval = true;
          this._alertService.success(`Form Saved Successfully`);
        },
        (error) => {
          this._alertService.error('Unable to save.');
        }

      );
  }

  submitForApproval() {
      const submissionData = this.safeCForm.getRawValue();
      if(!this.isSupervisor){
        submissionData.submissionapprovaldate =moment(new Date()).format(this.dtformat1)
      }
      if (this.isSupervisor) {
       this.assessmentStatus = this.safeCForm.get('assessmentstatus')?.value;
       submissionData.assessmentStaus = this.safeCForm.get('assessmentstatus')?.value;
      } else {
       this.assessmentStatus = 'Review';
       submissionData.assessmentStaus = 'Review';
      }
      submissionData.currentSubmissionId = this.currentSubmissionId;
      submissionData.routingsupervisors =  this.routingSupervisors;
      submissionData.comments = submissionData.caseworkercomments;
      const selectedchild: any[] = [];
      submissionData.childdatagrid.forEach((element: {clientid: any}) => {
        const child = this.childList.filter(item => item.cjamspid == element.clientid);
        selectedchild.push(child[0]);
      });
      if (selectedchild && selectedchild.length) {
        submissionData.assessmentactor = this.getAssessmentActors(selectedchild);
      }
      submissionData.all_childs_json = this.allchilddetails;
       
      this._dataStoreService.setData('PRINTDATA', submissionData);
      this._assessmentService.saveSafecAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe(
        (response) => {
        this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
        if(this.isServiceCase) {
          this.getrohsenuntimelycriteria(submissionData);
        } else {
          if(!this.form1080aalertdisplayed){
            this.goBack();
          }
        }
        },
        (error) => {
          this._alertService.error('Unable to submit for approval.');
        }
      );
      
   }
  
  getrohsenuntimelycriteria(submissionData: any) {      
    this._commonService
    .getArrayList(
        {
            where: {
                servicecaseid  : this.id,
                safecassessmentid: this.currentAssessmentId,
                objecttype : 'safec'
            },
            method: 'get'
        },
        NewUrlConfig.EndPoint.Intake.Rohsenuntimelycriteria + '?filter' /* Separate API invoked for SEN Untimely Report */
    ).subscribe(data => {
        if(data && data.length > 0) {
            this._dataStoreService.setData('refereshgetrohcall', true);
            this.globalPopupRef.showSenUntimelyPopupAlert('SAFEC',data);
        } else {
          if(!this.form1080aalertdisplayed){
            this.goBack();
          }
        }           
    });
 }

   goBack() {
    setTimeout(() => {
      this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
    }, 1000);
  }

  getRoutingSupervisors() {
    return this.routingSupervisors; 
  }

  getRoutingInfo() {
    return this.routingInfo;
  }

  /**
   * Get caregivers in the case
   */
  getCaregiversInCase() {
    this.caregiversInCase = [];
    this._commonService.getArrayList(
            new PaginationRequest({
                nolimit: true,
                method: 'get',
                where: {
                    personid: this.id
                }
            }),
            'Actorrelationships/getallcaregiversincase'+ '?filter'
        )
        .subscribe(response => {
        if (response && Array.isArray(response) && response.length && response[0].getallcaregiversincase) {
          this.caregiversInCase = response[0].getallcaregiversincase;
          }
      });
  }

  getInvolvedPerson() {
    let getpersonlistreq = {};
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    } else {
      getpersonlistreq = { intakeserviceid: this.id };
    }
    this.getInvolvedPersonDetail(getpersonlistreq);

  }

  getInvolvedPersonDetail(getpersonlistreq: any){
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    getpersonlistreq['isExpungementSuperUser'] = isExpungementSuperUser;
    getpersonlistreq['iscaseexpunged'] = this.iscaseexpunged;
  
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 20,
        method: 'get',
        where: getpersonlistreq
      }),
      url + '?filter'
    ).subscribe(response => {
      if (response && response.data && response.data.length) {
        this.involvedPerson = response.data;
        this.involvedPersonInfo();
      }
    });
  }

  involvedPersonInfo() {
    this.involvedPerson.forEach(ele => {

      if (this.migratedCaseorNot) {
        ele.namecheck = ele.firstname + ' ' + ele.lastname;
      }
      this.houseHoldPerson(ele);
      this.headOfHouseHoldPerson(ele);

      if (ele?.roles && ele?.roles?.length) {
        this.setAllChildAndLegalGuardian(ele);
        this.setCareGiversList(ele);
        const childData = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD' || roleid.intakeservicerequestpersontypekey === 'AV');
        if (childData && childData.length) {
          ele.namecheck = ele.firstname + ' ' + ele.lastname;
          this.childList.push(ele);
          if (!this.updateMifra) {
            this.addFamily(ele);
          }
        }
        const notChildData = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey !== 'CHILD' && roleid.intakeservicerequestpersontypekey !== 'AV');
        if (notChildData && notChildData.length && !this.updateMifra) {
          this.addAssociatedDetails(ele);
        }
      }
    });

    this.setCaregiversInCase();
    this.setDeceasedInfo();
    this.mfiraPatch();
  }

  houseHoldPerson(ele: any) {
    if (ele.ishousehold == 1) {
      this.familyHOUSEHOLD.push(ele);
      if (ele.roles && ele.roles.length) {
        const otherchildData = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'OTHERCHILD' || roleid.intakeservicerequestpersontypekey === 'OTHCHNH');
        if (otherchildData && otherchildData.length && !this.migratedCaseorNot) {
          ele.namecheck = ele.firstname + ' ' + ele.lastname;
          this.otherchildList.push(ele);
        }
      }
    }
  }

  headOfHouseHoldPerson(ele: any) {
    if (ele.isheadofhousehold) {
      this.headofhouseholdid = ele.personid;
      this.headofHouseholdDetails = ele;
      this.safeCForm.patchValue({
        headofhouseholdname: this.getFullName(ele),
      });
    }
  }

  setAllChildAndLegalGuardian(ele: any){
    const legalGurdian = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'LG');
    const filterChildRoles = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD' || roleid.intakeservicerequestpersontypekey === 'AV' || roleid.intakeservicerequestpersontypekey === 'OTHERCHILD' || roleid.intakeservicerequestpersontypekey === 'OTHCHNH');
    if (filterChildRoles && filterChildRoles.length) {
      this.allchilddetails.push({
        name: ele.fullname,
        age: ele.age,
        cjamspid: ele.cjamspid
      })
    }

    if (legalGurdian && legalGurdian.length) {
      this.legalGuardian.push(ele);
    }
  }

  setCareGiversList(ele: any){
    let _filter = true;
    const _ar = Array.from(new Set(ele?.roles?.map((e: { intakeservicerequestpersontypekey: any; }) => e.intakeservicerequestpersontypekey)));
    if (_ar?.length > 0) {
      _filter = this.checkRoleFilter(_ar);
    }
    
    if (_filter) {
      this.caregiversList.push(ele);
    }
  }

  checkRoleFilter(_ar: any){
    let _filter = true;
    switch (_ar.length) {
      case 1:
        if (_ar.includes('OTHERCHILD') || _ar.includes('OTHCHNH') || _ar.includes('CHILD') || _ar.includes('AV')) {
          _filter = false;
        }
        break;
      case 2:
        _filter = this.twoRoleCheck(_ar);
        break;
      case 3:
        if ((_ar.includes('CHILD') && _ar.includes('AV') && _ar.includes('OTHERCHILD')) ||
          (_ar.includes('CHILD') && _ar.includes('AV') && _ar.includes('OTHCHNH'))) {
          _filter = false;
        }
        break;
      case 4:
        if ((_ar.includes('CHILD') && _ar.includes('AV') && _ar.includes('OTHERCHILD') && _ar.includes('OTHCHNH'))) {
          _filter = false;
        }
        break;
    }

    return _filter;
  }
  twoRoleCheck(_ar: any) {
    let _filter = true;
    if ((_ar?.includes('CHILD') && _ar.includes('AV')) ||
      (_ar.includes('OTHERCHILD') && _ar.includes('AV')) ||
      (_ar.includes('OTHCHNH') && _ar.includes('AV'))) {
      _filter = false;
    }
    return _filter;
  }

  setCaregiversInCase(){
    if (this.caregiversList && this.caregiversList.length) {
      this.caregiversInCase = this.involvedPerson.filter(e => this.caregiversList.indexOf(e) >= 0);
    }
  }

  setDeceasedInfo(){
    if (this.childList.length === 1) {
      this.enableChildDeceased = true;
      this.deceasedChildName = this.childList[0].fullname ? this.childList[0].fullname : null;
      this.dodOfDeceasedChild = this.childList[0].dateofdeath ? this.childList[0].dateofdeath : null;
    }
  }

  selectionChild(event: any, index: any){
    const personDetails = this.otherchildList.filter(item => item.fullname === event);
    (<FormArray>this.safeCForm.get('addchildren')).controls[index].patchValue({
      seconeage: personDetails[0].age ? personDetails[0].age : '',
    });
  }

  selectionCareGiver(event: any) {
    this.safeCForm.patchValue({ 
      safeccaregivers:  event
    });
  }

  getRolesAndRelation() {
    if (this.childList && this.childList.length && this.legalGuardian && this.legalGuardian.length) {
        
      const guardiandetails = this.legalGuardian[0];
      const childpersonid = this.legalGuardian[0].personid;
      const legalGuardian = this.childList[0];
      let rolecheck = '';
      if (legalGuardian.relationshiparray && legalGuardian.relationshiparray.length){
      legalGuardian.relationshiparray.forEach((element: { secondaryuserid: any; primaryuserid: any; description: string; }) => {
        if (element.secondaryuserid == childpersonid  && element.primaryuserid == legalGuardian.personid) {
          rolecheck = element.description;
          return true;
        }
        return false;
      });
    }
      this.safeCForm.patchValue({
        caseheadsname: this.getFullName(guardiandetails),
        cisid: guardiandetails.assistpid,
        relationship: rolecheck
      });
    }
  }


  addNewChild(event: any, index: any) {
    const personDetails = this.childList.filter(item => item.fullname === event);
    (<FormArray>this.safeCForm.get('childdatagrid')).controls[index].patchValue({
      age: personDetails[0].age ? personDetails[0].age : '',
      clientid: personDetails[0].cjamspid ? personDetails[0].cjamspid : ''
    });

  }

  getFullName(person: any) {
    const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
    let name = '';
    nameKeys.forEach(key => {
    if(person && person.hasOwnProperty(key)){
        if ((person[key] !== null) && (person[key] !== 'null') && (person[key] !== '') ) {
        name = name + person[key] + ' ';
        }}
    });
    return name;
}
  changeSupervisor(userid: any) {
    const user = this.routingSupervisors.find(item => item.userid === userid);
    if (user.username) {
      this.safeCForm.patchValue({
        supervisorname: user.username
      });
    }
  }
  getValidationMessage(controlName: any, displayname: any) {
    if (controlName == 'childdatagrid') {
      if ((this.safeCForm.get('childdatagrid') as FormArray)?.controls.length == 0) {
        return 'Please enter valid ' + displayname;
      }
      const validationMsg = this.validationFlag(controlName);
      if (validationMsg) {
        return 'Please enter valid ' + displayname;
      }
    } else {
      if (this.safeCForm.controls[controlName].status == 'INVALID') {
        return 'Please Select value ' + displayname;
      }
    }
  }

  validationFlag(controlName: any) {
    let validationMsg = false;
    if ((this.safeCForm.get(controlName) as FormArray)?.controls.length) {
      const childdatalist = (this.safeCForm.get(controlName) as FormArray)?.controls;
      childdatalist.forEach((element: any) => {
        if (this.checkChild(element)) {
          validationMsg = true;
          return validationMsg;
        }
        if (this.checkChildRoleCheck(element)) {
          validationMsg = true;
          return validationMsg;
        }
        return false;
      });
    }
    return validationMsg;
  }

  checkChild(element: any){
    if (element.value.childname == '' || element.value.clientid == '' || element.value.age == '') {
      return true;
    } else {
      return false;
    }
  }

  checkChildRoleCheck(element: any){
    const childRoleCheck = this.childList.filter(item => item.cjamspid == element.value.clientid);
    if (!childRoleCheck || childRoleCheck == undefined || childRoleCheck.length == 0) {
      return true;
    } else {
      return false;
    }
  }

getValidationMessageWithIndex(controlName: any,displayname: any,i: any){
  const group = this.safeCForm.get('associatedetails') as FormGroup; 
  const control = group?.controls[i]?.get(controlName) as FormControl;

  if (control?.status === 'INVALID') 
  {
      return 'Please Do '+displayname;
  }
}
  isReadyForApproval() {
    this.requiredForApproval = true;
    this.incompleteList = [];
    if (!this.checkForDeceased()) {
      const controls = this.safeCForm.controls;
      let invalid = [];
      for (const name in controls) {
        if (controls[name].invalid) {
          invalid.push(name);
        }
      }
      let signature = this.safeCForm.getRawValue().associatedetails;
      this.checkSign(signature);
      invalid = invalid.filter(e => e !== "associatedetails");
      if (!this.safeCForm.valid) {
        if (invalid?.length > 0) {
          this.incompleteList.push('Please Enter All Required Fields');
        }
      }
    }

    this.checkForIncompletes();
    if (this.incompleteList.length == 0 && ((this.safeCForm.get('childdatagrid') as FormArray)?.controls.length != 0 || this.safeCForm.controls.unabletolocatechild.value === true)) {
      this.form1080Alerts();
      this.submitForApproval();
    } else {
      (<any>$('#incomplete-items')).modal('show');
    }
  }

  form1080Alerts() : void {
    if(!this.checkForm1080AFilled()){
      const riskOfHarm=  this._dataStoreService.getData('IsRiskofHarm');
      const safeCDataCount = this._dataStoreService.getData('safecDataCount');
      if(safeCDataCount === 0) {
        if((this.isServiceCase && riskOfHarm) || (!this.isServiceCase)) {
          this.form1080aalertdisplayed = true;
          this.globalPopupRef.showGlobalPopupAlert('Form 1080 A Alert',this.form1080aAlertMessage);
        } 
      }
    } else {
      this.form1080aalertdisplayed = false;
    }
  }

  onCloseForm1080Alert() : void {
    (<any>$('#form1080a-alert')).modal('hide');
    this.goBack();
  }

  private reusableValidPersonConditionFn(data: any[]) {
    if (data) {
        return true
    } else {
        return false;
    }
  }

  // Checking if Form1080 A is available for Safe-C
  checkForm1080AFilled() : boolean {
    
    const form1080aMessageWorker = 'Please complete and submit the 1080 A form. The 1080 Series is located in the Forms sub-tab of the Documents tab.';
    const form1080aMessageSupervisor = 'Please complete and submit the 1080 A form. The 1080 Series is located in the Forms sub-tab of the Documents tab.';

    this.form1080aAlertMessage = this.isSupervisor ? form1080aMessageSupervisor : form1080aMessageWorker;

    const validPersonsForAV = this.involvedPerson.filter(person => {
      const rolesAV = person?.roles?.find((item: any) => item.intakeservicerequestpersontypekey === 'AV');
      return this.reusableValidPersonConditionFn(rolesAV);
      });

      const oohPersons = validPersonsForAV.filter(person =>
          person.programarea?.some((program: any) => program.programkey === "OOH")
      );


    let response = true;
    if(this.ischildfatality || this.isseriousphysicalinjury || 
      (this.ismaltreatment && oohPersons && oohPersons.length > 0)) {
      let data = this.form1080aData;
      let isForm1080Done = false;
      if(data.length>0) {
          isForm1080Done = data.some((form: any) => form.status === 'Approved');
          if(!isForm1080Done){
            response = false;
          }
      } else {
        response = false;
      }

    } 
    return response;
  }

  // Get Form 1080 A Data
  getForm1080A() {
    const intakeNumber = this._dataStoreService.getData("da_intakenumber");
    const inputRequest = {
        objectid: [this.id,intakeNumber],
    };
    this._commonService.getArrayList(
        new PaginationRequest({
            where: inputRequest,
            method: "get",
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.List + "?filter"
    ).subscribe(
        (response) => {
            if (response) {
                this.form1080aData = response;
            }
        },
        (error) => {
            this._alertService.warn('Error retrieving Form 1080A data');
        }
    );
  } 

  checkSign(signature: any){
    if (this.checkSignature()) {
      signature.forEach((element: any) => {
        if ((element?.signature === null || element?.signature === "") && (element?.refusetosign === false || element?.refusetosign === "") &&
          (element?.UnavailabletoSign === false || element?.UnavailabletoSign === "") && (element?.SignatureUploaded === false || element?.SignatureUploaded === "")) {
          this.incompleteList.push('Please Enter All Required Fields in SECTION VII: Safety plan');
        }
      });
    }
  }

  checkForDeceased(){
    if(this.childDeceased || this.isChildLocatedByDept || this.safeCForm['controls']?.unabletolocatechild?.value || this.safeCForm['controls']?.childdeceased?.value) {
      return true;
    } else {
      return false;
    }
  }

  checkSignature(){
    const signature = this.safeCForm.getRawValue().associatedetails;
    if(signature && signature.length && (this.safeCForm.getRawValue().dangerInfluencesIdentified == 'safetydecision2' || this.safeCForm.getRawValue().dangerInfluencesIdentified == 'safetydecision3')) {
      return true;
    } else {
      return false;
    }
    
  }


  checkForIncompletes() {
    if (this.isSupervisor && !this.safeCForm.getRawValue().assessmentstatus) {
      this.incompleteList.push('Please Enter All Required Fields');
    }
    if ((this.safeCForm.get('childdatagrid') as FormArray)?.controls.length == 0 && !this.safeCForm.controls.unabletolocatechild.value === true) {
      this.incompleteList.push(this.validationmsg);
    }
    if (this.safeCForm['controls'].assessmentreviewed.value == 'InProcess') {
      this.incompleteList.push('Please Update the Review Status');
    }
    if ((this.safeCForm.get('childdatagrid') as FormArray)?.controls.length) {
      const childdatalist = (this.safeCForm.get('childdatagrid') as FormArray)?.controls;
      childdatalist.forEach((element: any) => {
        if (element.value.childname == '' || element.value.clientid == '' || element.value.age == '') {
          this.incompleteList.push(this.validationmsg);
          return true;
        }
        const childRoleCheck = this.childList.filter(item => item.cjamspid == element.value.clientid);
        if (!childRoleCheck || childRoleCheck == undefined || childRoleCheck.length == 0) {
          this.incompleteList.push(this.validationmsg);
          return true;
        }
        return false;
      });
    }
  }


  converttoNumber(value: any) {
    return (value) ? parseFloat(value) : 0;
  }


  houseHoldChildDeceased(value: any) {
    if(value.target.checked) {
      this.childDeceased = true;
      this.isChildLocatedByDept = false;
    } else {
      this.isValue = 1;
      this.childDeceased = false;
    }
    return 'success'
  }
 
  deptLocateChild(value: any) {
    if(value.target.checked) {
      this.isValue = 7;
      this.isChildLocatedByDept = true;
      this.childDeceased = false;
    } else {
      this.isValue = 1;
      this.isChildLocatedByDept = false;
    }
    return 'success'
  }
  getSignatureCondFn(i: any) {
    return (this.safeCForm.get(['associatedetails', i, 'SignatureUploaded'])?.value || this.safeCForm.get(['associatedetails', i, 'UnavailabletoSign'])?.value || this.safeCForm.get(['associatedetails', i, 'refusetosign'])?.value)
  }
  getControlSDataFn(name: string): any[] {
    return Object.values((this.safeCForm.get(name) as FormGroup).controls)
  }

  openPicker(pickerclicked: any) {
    if(pickerclicked === 'picker2') {
      this.picker2.open();
    } else if(pickerclicked === 'picker1') {
      this.picker1.open();
    }
  }

  onPickerClosed(event: any, controlName: string) {
    const control: any = this.safeCForm.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }

}
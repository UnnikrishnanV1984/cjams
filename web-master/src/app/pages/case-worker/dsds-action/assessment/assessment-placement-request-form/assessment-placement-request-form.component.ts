import { Component, Injector, OnInit, ViewChild } from "@angular/core";
import { map, pluck, share } from 'rxjs/operators'
import { FormArray, FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from "@angular/forms";
import moment from "moment";
import { of as observableOf,Observable, forkJoin } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PaginationRequest, DropdownModel } from '../../../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { AssessmentService } from '../assessment.service';
import { CommonHttpService, DataStoreService, SessionStorageService, AuthService, AlertService, CommonDropdownsService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import _ from 'lodash';
import { Router } from "@angular/router";
import { PersonInfoService } from "../../../../shared-pages/person-info/person-info.service";
import { UserRelationship } from "../../../../../@core/common/models/involvedperson.data.model";
import {DocumentUploadListSharedComponent } from '../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { MatDatepicker, MatDatepickerModule } from "@angular/material/datepicker";

import { RandomIdGeneratorService } from "../../../../../@core/services/random-id-generator.service";
import { AttachmentUploadsharedModule } from "../../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module";
import { DocumentUploadListSharedModule } from "../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module";
import { CommonModule } from "@angular/common";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatRadioModule } from "@angular/material/radio";
import { MatSelectModule } from "@angular/material/select";
import { OWL_DATE_TIME_FORMATS, OwlDateTimeModule, OwlNativeDateTimeModule } from "@danielmoncada/angular-datetime-picker";
import { OwlMomentDateTimeModule } from "@danielmoncada/angular-datetime-picker-moment-adapter";
import { SignatureFieldModule } from "../../../../../shared/modules/common-controls/signature-field/signature-field.module";
import { MatExpansionModule } from "@angular/material/expansion";
import { MatDividerModule } from "@angular/material/divider";
import { MAT_DATE_FORMATS, MatDateFormats } from "@angular/material/core";
import { NgxMaskDirective, provideNgxMask } from 'ngx-mask';

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
    selector: 'assessment-placementrequest-form',
    templateUrl: './assessment-placement-request-form.component.html',
    styleUrls: ['./assessment-placement-request-form.component.scss'],
    imports:[AttachmentUploadsharedModule,DocumentUploadListSharedModule,MatRadioModule,MatCheckboxModule,MatFormFieldModule,MatInputModule,SignatureFieldModule,CommonModule,OwlDateTimeModule, OwlNativeDateTimeModule,OwlMomentDateTimeModule,MatSelectModule,ReactiveFormsModule,MatDatepickerModule,FormsModule,MatExpansionModule,MatDividerModule,NgxMaskDirective],
    providers:[provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
    standalone: true
})

export class AssessmentPlacementRequestFormComponent implements OnInit {
  ASSESSMENT_NAME = 'PLACEMENT REQUEST FORM - ATTACHMENT A';
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  currentAssessmentId: any;
  currentSubmissionId!: string;
  isValue: number = 1;
  isServiceCase: any;
  YouthInformationForm!: FormGroup;
  objectId:string = '';
  additionalobjectid!: string;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  @ViewChild('picker71') picker71!: MatDatepicker<Date>;
  store: any;
  id = '';
  user!: AppUser;
  agency!: string;
  isCW!: boolean;
  isSupervisor!: boolean;
  examinationList: any[] = [];
  personList!: any[];
  otherpersonList:any[]=[];
  spouseorpartnerList: any[] = [];
  spouseorpartnerList1: any[] = [];
  youthList!: any[];
  childList: any[] = [];
  updateprfadata!: boolean;
  viewprfadata!: boolean;

  countyList: any[] = [];
  siblingList: any[] = [];
  siblingArraylist: any[] = [];
  spouseorpartnerarray: any[] = [];
  legalGuardian: any[] = [];
  legalGuardianother: any[] = [];
  youthListdetails: any[] = [];
  childremovalhistory: any[] = [];
  collateralList: any[] = [];
  selectedYouthName = '';
  selectedotherparty = '';
  selectedSiblingName = '';
  selectedrelativename = '';
  prfadata: any;
  placementHistory: any[] = [];
  currplacement: any;
  currlivingarrangement: any;
  primaryCitizenshipDropDownItems$!: Observable<any[]>;
  gradeDropdownItems$!: Observable<any[]>;
  raceDropdownItems$!: Observable<any[]>;
  ethnicityDropdownItems$!: Observable<any[]>;
  nationalityDropdownItems$!: Observable<any[]>;
  statenameDropdownItems$!: Observable<any[]>;


  showother: boolean = false;
  livingother: boolean = false;
  frequencydropdown: any[] = [];
  showfosterplacement: boolean = false;
  currentliving!: null;
  langother: boolean = false;
  showchheckother: boolean = false;
  showothersc: boolean = false;
  physicianinfolist: any[] = [];

  pronouns: any = ['He/Him/His', 'she/her/hers', 'they/them/theirs', 'Other-Please Specify'];
  //Specialconsiderations  = ['Deaf & HOH', 'LGBTQ' ,'DD/IQ' ,'Substance Abuse','DV' , 'Trafficking Victim', 'Sexual Abuse Victim','Sexual Abuse Offender','Pregnant & Parenting','Other issues']
  Specialconsiderations: any = [
    {
      value: 'Hearing Impaired',
      label: 'dhoh'
    },
    {
      value: 'LGBTQ',
      label: 'lgbtq'
    },
    {
      value: 'DD/IQ',
      label: 'ddiq'
    },
    {
      value: 'Substance Abuse',
      label: 'subabuse'
    },
    {
      value: 'DV',
      label: 'dv'
    },
    {
      value: 'Trafficking Victim',
      label: 'traffvic'
    },
    {
      value: 'Sexual Abuse Victim',
      label: 'seabvic'
    },
    {
      value: 'Sexual Abuse Offender',
      label: 'seaboff'
    },
    {
      value: 'Pregnant & Parenting',
      label: 'pregandparent'
    },
    {
      value: 'Other issues',
      label: 'otherissues'
    },
  ];

  YouthCurrentlyliving: any = ['Home of Parent or Legal Guardian', 'Placement', 'Living Arrangement'];
  legalstatus: any[] = [];
  preflanguages: any = ['English', 'Spanish', 'Others'];
  youthselected!: boolean;
  currYouthPersonId!: string;
  currServiceCaseId!: string;
  infoDialog!: string;
  relationshipArrayOfYouth: UserRelationship[] = [];

  // section 2  specific start

  // section 2  specific start
  teamTypeKey!: string;
  placementreqform!: FormGroup;
  placementtypeList!: any[];
  placementtype: any[] = [];
  maxToDate: any;
  uploadedFiles:any[] = [];
  hasAttachment: boolean = false;

  //section 2 end
  //section 3 start
  youthmother: any;
  youthfather: any;
  lgfather: any;
  lgmother: any;
  youthrelationships: any[] = [];
  YouthFamilyForm!: FormGroup;
  headofhousehold: any;
  addedsiblingList: any[] = [];
  addedspouseList: any[] = [];
  checkboxStates: any = {};
  clarificationReq: string[] = [];
  requireddocs = [
    {
      value: 'Child and Adolescent Needs and Strengths (CANS) Assessment (most recent)',
      label: 'cansassessment'
    },
    {
      value: 'Psychosocial History',
      label: 'psychosocial'
    },
    {
      value: 'Youth’s Placement History, if applicable',
      label: 'yplacementhist'
    },
    {
      value: 'Psychological Evaluations (most recent) – if one has been done',
      label: 'physevaluation'
    },

    {
      value: 'School records (e.g., IEP, etc.)',
      label: 'schoolrecords'
    },
    {
      value: 'Treatment reports (any treatment plans/reports not indicated above)',
      label: 'treports'
    },
    {
      value: 'Counseling or therapy report, most recent – if applicable',
      label: 'creport'
    },
    {
      value: 'Psychiatric Assessment with treatment plan (most recent)',
      label: 'psyassessment'
    },
    {
      value: 'Hospital Discharge Reports (within last 12 months)',
      label: 'hdreport'
    },
    {
      value: 'Certificate of Need – include medical (for RTC referrals) ',
      label: 'certneed'
    },
    {
      value: 'Others (Please Specify)',
      label: 'otherscheck'
    }
  ];
  // checkboxStatus: boolean;
  //section 3 end
  //section 4 start
  // checkboxStatus: boolean;
  //section 3 end
  //section 4 start
  OtherRelativeForm!: FormGroup;

  //section 4 end

  //section 5
  //section 4 end
  //section 5
  YouthEducationForm!: FormGroup;
  allEducationList: any;
  employementlist: any
  djsinvolvedchkbox = false;
  ganginvolvedchkbox = false;
  elecmonitoringchkbox = false;
  djscommitedchkbox = false;
  //section 5 end
  //section 6 start
  //section 5 end
  //section 6 start
  YouthMedicalForm!: FormGroup;
  privateInsurance!: any[];
  hospitalList: any[] = [];
  mentalpsychohospitalList: any[] = [];
  medicationpsychotropic: any[] = [];

  sexualinfoList: any[] = [];
  ishospitalised = false;
  medicalConditionType$!: Observable<DropdownModel[]>;
  medicalCondtionType: any;
  medicalConditionDescription: string[] = [];
  firstEnteredDate!: string;
  //section 6 end
  //section 7
  //section 6 end
  //section 7
  YouthplacementserviceForm!: FormGroup;
  YouthProviderForm!: FormGroup;
  providerData: any[] = [];
  CPAProviderData: any[] = [];
  assessmentStatus: any;
  incompleteList: any[] = [];
  caseworkersignature: any;
  providersignature: any;
  supervisorsignature: any;
  routingSupervisors: any[] = [];
  currentDate: any;
  todaysdate:any;
  daNumber: any;
  ftdmrequired = true;
  isuploadenabled = false;
  languagepref: any;
  permanencyGoalsResponse: any = null;
  legalStatusValueChange = false;
  legalCustodyDropdownItems$!: Observable<DropdownModel[]>;
  initServiceCaseId!: string;
  intakeservreqchildremovalid!: string;
  isChildRemovalApproved = true;
  //section 7 end
  //Section 8 start
  dtformat = 'MM/DD/YYYY';
  dtformat1 = 'YYYY-MM-DDTHH:mm:ss'
  notspecified = 'Not Specified';
  placeholderIDforUploadedFiles!: string;
  canComplete = false;
  canUploadProviderData = false;
  isCompleted = false;
  comments:string = '';
  selectedProviderObj: any;
  selectedCPAProviderObj: any;
  currentUploadedFilesLength!: number;
  isProviderUploadEnabled!: boolean;
  providerCheckbox = false;
  cpaDropdownStatus = false;
  targetProviderData: any;
  reroutesupervisor: any;
  supervisorname: any;
  oldsupervisorname: any;
  caseworkercomments: any;
  providercjamspid!: { name: string; cjamspid: string; }[];
  iscaseexpunged: any = 0;

  private readonly _dataStoreService: DataStoreService;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _authService: AuthService;
  private readonly _formBuilder: FormBuilder;
  private readonly _router: Router;
  private readonly _assessmentService: AssessmentService;
  private readonly storage: SessionStorageService;
  private readonly _alertService: AlertService;
  private readonly _commonDDService: CommonDropdownsService;
  private readonly personInfoService: PersonInfoService;
  private readonly randomIdGeneratorService: RandomIdGeneratorService;
  isExpungementSuperUser: any;

  constructor(private readonly injector : Injector) {
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._router = this.injector.get<Router>(Router);
    this._assessmentService = this.injector.get<AssessmentService>(AssessmentService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this.randomIdGeneratorService = this.injector.get<RandomIdGeneratorService>(RandomIdGeneratorService);
    this.store = this._dataStoreService.getCurrentStore();
    this.daNumber = this._commonDDService.getStoredCaseNumber();

  }

  openPicker(val: any) {
    if (val===71) {
      this.picker71.open();
    }
  }
  ngOnInit(): void {
    this.loadDropDowns();
    this. getLegalCustodyDropdown();
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.user = this._authService.getCurrentUser();
    this.currentDate = moment(new Date()).format('YYYY-MM-DDTHH:mm');
    this.todaysdate = moment(new Date()).format('YYYY-MM-DD');
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.routingSupervisors = this.routingSupervisors.filter(e => e.issupervisor);
    this.agency = this._authService.getAgencyName();
    this.isSupervisor = (this.user.role.name === 'apcs') ? true : false;
    this._assessmentService.getservicecase();
    if (this.agency === 'CW') {
      this.isCW = true;
    } else {
      this.isCW = false;
    }

    this.getCounties();

    this._commonHttpService.getArrayList({
            where: { "tablename":"frequencytype", "teamtypekey": this.teamTypeKey },
            method: 'get'},'referencetype/gettypes' + '?filter'
    ).subscribe(data => {
      this.frequencydropdown = data;
    });
    this.getPermanencyPlanList().subscribe((res)=>{
      this.permanencyGoalsResponse = res; 
      this.getInvolvedPerson(); 
     });
    
    this.getcollateral();
    this.initYouthInformation();
    this.initplacementinformation();
    this.inityouthfamilyform();
    this.inityouthsiblingform();
    this.inityoutheducationform();
    this.inityouthmedicalform();
    this.initplacementserviceform();
    this.initproviderserviceform();

    if(!this.selectedYouthName){

      this.youthselected = false;

    }

    this.handlePrfadataFn();

    //section 2 start
    this.handleSection2Fn();
    

    //section 2 end
    const printdata = this.prfadata;
    printdata.submissionData = this.getPRFAdata();
    this._dataStoreService.setData('PRINTDATA', printdata);
    //section 3 start
    this.handleSection3Fn();

    //section 3 end
    //section 4 start


    this.handleSection4Fn();
    //section 4 end
    //section 5 start
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youtheducation) {
      this.YouthEducationForm.patchValue(this.prfadata.submissiondata.youtheducation);
    }
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youtheducation) {
      this.djsinvolvedcheck();
   
    }
    //section 5 end
    //section 6 start
      this.handleSection6Fn();
    //section 6 end
    // section 7
    this.handleSection7Fn();
    //section 7 end

    //section 8 start
    this.handleSection8Fn();
    //section 8 end
    this.isExpungementSuperUser = this._authService.isExpungementSuperUser();
  }
  // Assosiated with ngOnInit method
  private handlePrfadataFn() {
    this.prfadata = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    if (this.prfadata && (this.prfadata.mode === 'update' || this.prfadata.mode === 'submit')) {
      this.updateprfadata = true;
      this.viewprfadata = false;
    }
    else {
      this.updateprfadata = false;
      this.viewprfadata = false;
    }
    if (this.prfadata && this.prfadata.mode === 'submit') {
      this.prfadatadisablecheck();
    }
    if (this.prfadata && this.prfadata.mode === 'partialEditMode') {
      this.updateprfadata = true;
      this.viewprfadata = true;
      this.canComplete = true;
      this.YouthEducationForm.disable();
      this.YouthFamilyForm.disable();
      this.YouthInformationForm.disable();
      this.OtherRelativeForm.disable();
      this.placementreqform.disable();
      this.YouthMedicalForm.disable();
      this.YouthplacementserviceForm.disable();
    }

    this.currentAssessmentId = this.prfadata ? this.checkAssessmentidFn() : this.currentAssessmentId;
    this.additionalobjectid = this.prfadata ? this.prfadata?.assessmentid : this.prfadata?.submissiondata?.placeholderIDforUploadedFiles;
    this.canUploadProviderData = this.prfadata ? (this.prfadata?.assessmentstatustypekey === 'Accepted') : false;
    this.currentSubmissionId = this.prfadata.submissionid;
    this.initServiceCaseId = this.prfadata.servicecaseid;

    this.handlePrfadataSubmissiondataFn();
    if (this.prfadata && this.prfadata.mode === 'start') {
      this.acknowledgeViaPopup();
    }
  }
  private checkAssessmentidFn(): any {
    return (this.prfadata?.assessmentid ? this.prfadata?.assessmentid : this.currentAssessmentId);
  }

  // Assosiated with ngOnInit method
  private handlePrfadataSubmissiondataFn() {
    if (this.prfadata && this.prfadata.submissiondata) {
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.uploadedFiles) {
        this.uploadedFiles = this.prfadata.submissiondata.uploadedFiles.filter((attachment: { additionalobjectid: any; }) => attachment.additionalobjectid === this.currentAssessmentId || attachment.additionalobjectid === this.prfadata?.submissiondata?.placeholderIDforUploadedFiles);
        this.hasAttachment = this.uploadedFiles.length > 0;
        this.currentUploadedFilesLength = this.uploadedFiles.length;
      }
      // }
      // if (this.prfadata && this.prfadata.submissiondata) {
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.placeholderIDforUploadedFiles) {
        this.placeholderIDforUploadedFiles = this.prfadata.submissiondata.placeholderIDforUploadedFiles;
      }
    }
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthinformation) {
      this.selectedyouthnamecheck();
    }
  }
  // Assosiated with ngOnInit method
  private handleSection8Fn() {
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthproviderservice) {
      this.YouthProviderForm.patchValue(this.prfadata.submissiondata.youthproviderservice);
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthproviderservice.providersignature) {
        this.providersignature = this.prfadata.submissiondata.youthproviderservice.providersignature;
      }
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthproviderservice.selectedProvider) {
        this.selectedProviderObj = this.prfadata.submissiondata.youthproviderservice?.selectedProvider;
        this.isCompleted = this.prfadata.submissiondata.isCompleted;
        this.cpaDropdownStatus = this.prfadata.submissiondata.cpaDropdownStatus;
      }
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthproviderservice.selectedCPAProvider) {
        this.selectedCPAProviderObj = this.prfadata.submissiondata.youthproviderservice?.selectedCPAProvider;
      }
    }

    this.getPermanencyPlanList().subscribe((res) => {
      this.permanencyGoalsResponse = res;
    });
  }
  // Assosiated with ngOnInit method
  private handleSection7Fn() {
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthplacementservice) {
      this.YouthplacementserviceForm.patchValue(this.prfadata.submissiondata.youthplacementservice);
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthplacementservice.caseworkersignature) {
        this.caseworkersignature = this.prfadata.submissiondata.youthplacementservice.caseworkersignature;

      }
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthplacementservice.caseworkercomments) {
        this.YouthplacementserviceForm.patchValue(this.prfadata.submissiondata.youthplacementservice.caseworkercomments);
      }
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthplacementservice.supervisorsignature) {
        this.supervisorsignature = this.prfadata.submissiondata.youthplacementservice.supervisorsignature;
      }
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthplacementservice.assessmentapprovaldate) {
        this.YouthplacementserviceForm.patchValue({
          assessmentapprovaldate: moment(this.prfadata.submissiondata.youthplacementservice.assessmentapprovaldate).format(this.dtformat1)
        });
      }
    }
  }
  // Assosiated with ngOnInit method
  private handleSection6Fn() {
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthmedical) {
      this.YouthMedicalForm.patchValue(this.prfadata.submissiondata.youthmedical);
      if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthmedical?.medconditionarray) {
        this.prfadata.submissiondata.youthmedical.medconditionarray.forEach((element: any, index: any) => {

          this.addmedicalcondition(element);

        });

      }
    }
  }
  // Assosiated with ngOnInit method
  private handleSection4Fn() {
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthrelative?.otherrelativearray) {
      this.prfadata.submissiondata.youthrelative.otherrelativearray.forEach((element: any, index: any) => {
        this.addotherrelative(element);
      });

    }
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthrelative?.otherinterestedparties) {
      this.prfadata.submissiondata.youthrelative.otherinterestedparties.forEach((element: any, index: any) => {
        this.addinterestedparty(element);
      });

    }
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthfamily.otherreqdocs) {
      this.showchheckother = this.prfadata.submissiondata.youthfamily.otherscheck;
    }
  }
  // Assosiated with ngOnInit method
  private handleSection3Fn() {
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthfamily) {
      this.YouthFamilyForm.patchValue(this.prfadata.submissiondata.youthfamily);
      this.requireddocs.forEach((doc: any, index: any) => {
        this.checkboxStates[index] = this.prfadata.submissiondata.youthfamily['checkbox_' + index];
        this.clarificationReq[index] = this.prfadata.submissiondata.youthfamily['status_' + index];
      });

    }
  }
  // Assosiated with ngOnInit method
  private handleSection2Fn() {
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.placementinfo) {
      this.placementreqform.patchValue(this.prfadata.submissiondata.placementinfo);
    } else {

      this.workerandsupervisordetails();
    }
  }

  djsinvolvedcheck(){
    if(this.prfadata.submissiondata.youtheducation.djsinvolved) {
      this.djsinvolvedchkbox = true;
      }
      if(this.prfadata.submissiondata.youtheducation.ganginvolved) {
        this.ganginvolvedchkbox = true;
        }
        if(this.prfadata.submissiondata.youtheducation.elecmonitoring) {
          this.elecmonitoringchkbox = true;
          }
          if(this.prfadata.submissiondata.youtheducation.djscommited) {
            this.djscommitedchkbox = true;
            }
  }

  selectedyouthnamecheck(){
    this.selectedYouthName = this.prfadata.submissiondata.youthinformation.YouthName;
    if(this.youthList && this.youthList.length > 0) {
      const event = this.youthList.find(item => item.fullname === this.selectedYouthName);
      this.getIfInCareGoals(event.personid)
    }

    if (this.prfadata.submissiondata.youthinformation.YouthcurrentLiving) {
      this.currentliving = this.prfadata.submissiondata.youthinformation.YouthcurrentLiving;
      this.onselectliving(this.currentliving, this.initServiceCaseId);
    }

    this.YouthInformationForm.patchValue(this.prfadata.submissiondata.youthinformation);
    this.legalStatusValueChange  = this.YouthInformationForm.get('legalstatus')?.value ? true : false;
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthinformation) {
      this.ifSubmissiondataFn();
    }
    if (this.prfadata.submissiondata.youthinformation.otherissues) {

      this.showothersc = true;
    }
    if (this.prfadata.submissiondata.youthinformation.state) {
      this.loadCounty(this.prfadata.submissiondata.youthinformation.state);
    }
  }

  private ifSubmissiondataFn() {
    if (this.prfadata.submissiondata.youthinformation.Youthpronoun === "3") {
      this.showother = true;
    }
    else {
      this.showother = false;

    }
    if (this.prfadata.submissiondata?.youthinformation?.Preflang) {
      this.languagepref = this.prfadata.submissiondata.youthinformation.Preflang;
      this.onlanguagechange(this.languagepref);
    }
    if (this.prfadata.submissiondata.youthinformation.Preflang === 'Others') {
      this.langother = true;

    }
    else {
      this.langother = false;
    }
  }
  
  prfadatadisablecheck(){
    this.updateprfadata  = true;
    this.viewprfadata  = true;
    this.YouthEducationForm.disable();
    this.YouthFamilyForm.disable();
    this.YouthInformationForm.disable();
    this.YouthplacementserviceForm.disable();
    this.OtherRelativeForm.disable();
    this.placementreqform.disable();
    this.YouthMedicalForm.disable();
    this.YouthProviderForm.disable();
  }

  ngAfterViewInit(): void {
    this.prfadata = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    if(this.prfadata?.assessmentid) {
      this.additionalobjectid = this.prfadata?.assessmentid;
    } else {
      this.additionalobjectid = this.randomIdGeneratorService.generateRandomId();
      this.placeholderIDforUploadedFiles = this.additionalobjectid;
    }
  }
  confirmAssessment() {
    (<any>$('#acknowledge-assessment-popup')).modal('hide'); // NOSONAR
  }

  acknowledgeViaPopup() {
    (<any>$('#acknowledge-assessment-popup')).modal('show'); // NOSONAR
        }

        updateCompleted = false;
  handleUpdateOperation = async (tempID: string, updatedby: any, newId: string) => {
      if (tempID && newId && !this.updateCompleted) {
        const res = await this._assessmentService.updateTemporaryId(tempID, updatedby, newId).toPromise();
        if (res === false) {
            console.error('Error: Update operation failed.');
          return false;
        }
        this.updateCompleted = true;
        return true;
      }
    }
  legalCustodyDetails: any[] = [];
  getLegalCustody(personid: any, youthNamehanged: any) {
    this._commonHttpService.getArrayList({
      method: 'get',
      where: {
        personid: personid
      }
    }, 'legalcustody/getlegalcustody?filter').subscribe( res => {
      if (res && res.length && res[0].getlegalcustody) {
        this.legalCustodyDetails = res[0].getlegalcustody;
        if (  this.legalStatusValueChange  && youthNamehanged) {     
           this.legalStatusValueChange = false;
         }

        this.handleIfNoYouthNamehangedFn(youthNamehanged);
        this.YouthInformationForm.updateValueAndValidity()
        } else {
          this.legalCustodyDetails = [];
        }
    });
  }
  // Assosiated with getLegalCustody method
  private handleIfNoYouthNamehangedFn(youthNamehanged: any) {
    if (!youthNamehanged) {
      if (this.legalCustodyDetails && this.legalCustodyDetails.length > 0) {
        const currentUserLegalCustodyDetails = this.legalCustodyDetails.filter(e => e.todate === null || e.todate === undefined);
        this.YouthInformationForm.patchValue({
          legalstatus: currentUserLegalCustodyDetails && currentUserLegalCustodyDetails.length > 0
            ? currentUserLegalCustodyDetails[0]['legalcustodytypedesc']
            : ''
        });
      }
    }
  }

  resetSignatureCapture(value: any) {
    if (value == 1) {
        this.caseworkersignature = null;
        this.YouthplacementserviceForm.get('caseworkersignature')?.reset();
    } 
    if (value == 2) {
      this.providersignature = null;
      this.YouthplacementserviceForm.get('providersignature')?.reset();
    } 
    if (value == 3) {
      this.supervisorsignature = null;
      this.YouthplacementserviceForm.get('supervisorsignature')?.reset();
    }
}

  getPermanencyPlanList() {
    return this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 10,
          nolimit: true,
          method: 'get',
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'permanencyplan/list?filter'
      )
  }

  getCounties() {
    this._commonHttpService.create({
      where: {
          activeflag: '1',
          state: 'MD'
      },
      order: 'countyname asc',
      nolimit: true
  }, 'admin/county/countylist').subscribe((item) =>
          this.countyList = item)
      }

      showInfoDialog(value: any)
      {
        this.infoDialog = value;
        (<any>$('#info-dialog')).modal('show'); // NOSONAR
      }

      confirmUpdate() {
        (<any>$('#confirm-dialog')).modal('show'); // NOSONAR
      }

      confirmUpdateCompleted() {
        (<any>$('#confirm-dialog')).modal('hide'); // NOSONAR
      }

      providerUpdateConfirm() {
        (<any>$('#provider-confirm-dialog')).modal('show'); // NOSONAR
      }

      providerUpdateConfirmationCompleted() {
        (<any>$('#provider-confirm-dialog')).modal('hide'); // NOSONAR
      }
     
  isWorkerReferred = false;
  isThisFormInitialiation!: boolean;
  isCurrentUserDifferentFromReferredWorker = false;
  supValues!: { supervisorname: string; supervisorsemail: string; supervisorsphone: any; };

  onChangeWorkerReferred = () => {
    this.isCurrentUserDifferentFromReferredWorker=false;
    const userDetails = this._authService.getCurrentUser();
    this.placementreqform.patchValue({
      currworkername: userDetails.user.userprofile.fullname,
      currworkerphone: userDetails.user.userprofile?.userprofilephonenumber[0]?.phonenumber,
      currworkeremail:userDetails.user.userprofile.email
    })
    this.placementreqform.patchValue(
      { 
        currsupervisorname:this.supValues?.supervisorname,
        currsupervisoremail:this.supValues?.supervisorsemail,
        currsupervisorphone:this.supValues?.supervisorsphone[0]?.phonenumber
    })
    this.confirmUpdateCompleted();

  }    
  workerandsupervisordetails() {

    const userDetails = this._authService.getCurrentUser();
    if (this.selectedYouthName) {
      this.handleViewprfadataFn();
      if (!this.isSupervisor && !this.viewprfadata) {
        const county = this.getCountyList(userDetails.user.userprofile.primarycountycd);

        this.YouthplacementserviceForm.patchValue({
          ldss: county,
          workersname: userDetails.user.userprofile.fullname,
          workersphone: (
            userDetails.user.userprofile.userprofilephonenumber &&
            userDetails.user.userprofile.userprofilephonenumber.length > 0
          )
            ? String(userDetails.user.userprofile.userprofilephonenumber[0]?.phonenumber)?.replace(/[\s\-().]/g, '').trim()
            : "",
          workersemail: userDetails.user.userprofile.email,
        });
      }

      this.isThisFormInitialiation = this.prfadata?.submissionData?.placementinfo?.currworkername === undefined || this.prfadata?.submissionData?.placementinfo?.currworkername === null || this.prfadata?.submissionData?.placementinfo?.currworkername.length === 0;
      if (!this.isThisFormInitialiation) {
        this.isCurrentUserDifferentFromReferredWorker = userDetails?.user?.userprofile?.fullname !== this.prfadata?.submissionData?.placementinfo?.currworkername;
      }

      this.handleIfNotIsWorkerReferredFn(userDetails);
    }

    this.handleGetuserprofilebyidApiFn();


  }
  // Assosiated with workerandsupervisordetails method
  private handleViewprfadataFn() {
    if (this.viewprfadata) {
      this.placementreqform.patchValue({
        dateofrequest: new Date(),
        // workername: this.prfadata?.submissiondata?.placementinfo?.workername,
        // workerphone: this.prfadata?.submissiondata?.placementinfo?.workerphone,
        // workeremail: this.prfadata?.submissiondata?.placementinfo?.workeremail
      });
    }
    else {
      if (!this.isSupervisor) {
        this.placementreqform.patchValue({
          dateofrequest: new Date(),
        });
      }
    }
  }
  // Assosiated with workerandsupervisordetails method
  private handleGetuserprofilebyidApiFn() {
    this._commonHttpService.getSingle(
      {
        where: { securityuserid: this.user.user.securityusersid },
        method: 'get'
      }, 'users/getuserprofilebyid?filter'
    ).subscribe(data => {
      if (data && data[0]) {
        const supervisorprofile = data?.[0]?.supprofile?.[0] ?? null;
        const supervisorPhone = data?.[0]?.supervisorphonenumber?.[0]?.phonenumber ?? null;

        const supervisorValues = {
          supervisorname: supervisorprofile?.fullname,
          supervisorsemail: supervisorprofile?.email,
          supervisorsphone: supervisorPhone
        };
        this.supValues = supervisorValues;

        const currSupervisorValues = {
          currsupervisorname: this.prfadata?.submissiondata?.placementinfo?.currsupervisorname ? this.prfadata?.submissiondata?.placementinfo?.currsupervisorname : supervisorprofile?.fullname,
          currsupervisoremail: this.prfadata?.submissiondata?.placementinfo?.currsupervisoremail ? this.prfadata?.submissiondata?.placementinfo?.currsupervisoremail : supervisorprofile?.email,
          currsupervisorphone: this.prfadata?.submissiondata?.placementinfo?.currsupervisorphone ? this.prfadata?.submissiondata?.placementinfo?.currsupervisorphone : supervisorPhone
        };

        this.placementreqform.patchValue(currSupervisorValues);

        if (this.prfadata?.assessmentstatustypekey !== 'Review' && !this.isSupervisor && (this.supervisorname === null || this.supervisorname === undefined)) {
          this.YouthplacementserviceForm.patchValue({
            ...supervisorValues,
            supervisorsphone: supervisorPhone
          });
        }
      }
    });
  }
  // Assosiated with workerandsupervisordetails method
  private handleIfNotIsWorkerReferredFn(userDetails: AppUser) {
    if (!this.isWorkerReferred) {
      this.placementreqform.patchValue({
        currworkername: this.prfadata?.submissionData?.placementinfo?.currworkername ? this.prfadata?.submissionData?.placementinfo?.currworkername : userDetails.user.userprofile.fullname,
        currworkerphone: this.prfadata?.submissionData?.placementinfo?.currworkerphone ? this.prfadata?.submissionData?.placementinfo?.currworkerphone : this.checkNadReturnUserProfilePhoneNumberFn(userDetails),
        currworkeremail: this.prfadata?.submissionData?.placementinfo?.currworkeremail ? this.prfadata?.submissionData?.placementinfo?.currworkeremail : userDetails.user.userprofile.email
      });

    }
  }

  private checkNadReturnUserProfilePhoneNumberFn(userDetails: AppUser): any {
    return ((userDetails.user.userprofile.userprofilephonenumber && userDetails.user.userprofile.userprofilephonenumber.length > 0) ? userDetails.user.userprofile.userprofilephonenumber[0]?.phonenumber : "");
  }

  formatPhoneno(number:any){
    if (!number) {
      return '';
    }
  //  number= number.toString().trim().replace(/^\+/,'')
   number=  number.toString().trim().replaceAll(' ','')
    if(number.match(/[^0-9]/)){ 
      return number;
    }

    var country, city, no;

    switch (number.length) {
      case 10:
        country = 1;
        city = number.slice(0, 3);
        no = number.slice(3);
        break;
      case 11:
        country = number[0];
        city = number.slice(1, 4);
        no = number.slice(4);
        break;
      case 12:
        country = number.slice(0, 3);
        city = number.slice(3, 5);
        no = number.slice(5);
        break;
      default: return number;
    }
    if(country==1){
      country=''
    }
    no=no.slice(0,3) +'-'+no.slice(3);
    return (country+"("+city+")"+no).trim();

  }
  getCountyList (code:any) {
    let county_name:any='';
        if(this.countyList){
          this.countyList.forEach(key=>{
            if(key.statecountycode == code){
              county_name=key.countyname;
            }
          });
          return county_name;
        }
   
}
  initplacementinformation() {
    this.placementreqform = this._formBuilder.group({
      dateofrequest: [''],
      dateofplacement: [''],
      emergencyplacement: [''],
      currworkername: [''],
      currworkerphone: [''],
      currworkeremail: [''],
      currsupervisorname: [''],
      currsupervisorphone: [''],
      currsupervisoremail: [''],
      ftmStatus:[null],
      narrative:{value: null, disabled: true},
      isftdm: [''],
      ftdmnotes: [''],
      ftdmdate: [],
      lastftdmdate: [],
      placementtype: [],
      placementreason: ['', Validators.required],
      iscaregiverinvolved: ['', Validators.required],
      caregiverinvolvednotes: [''],
      youthreviewnotes: ['', Validators.required],
      youthfeelingnotes: ['', Validators.required],
      youthattitudenotes: ['', Validators.required],
      paretattitudenotes: ['', Validators.required],
      familyinvolvement: ['', Validators.required],
      currentvisitplan: ['', Validators.required],
    });

    this.placementreqform.get('ftmStatus')?.valueChanges.subscribe(value => {
      if (value === 'waived') {
        this.placementreqform.get('narrative')?.enable();
      } else {
        this.placementreqform.get('narrative')?.disable();
      }
    });

    this.placementreqform.get('iscaregiverinvolved')?.valueChanges.subscribe(value => {
      if (value === '1') {
        this.placementreqform.get('caregiverinvolvednotes')?.setValidators([Validators.required]);
      } else {
        this.placementreqform.get('caregiverinvolvednotes')?.clearValidators();
      }
      this.placementreqform.get('caregiverinvolvednotes')?.updateValueAndValidity();
    });

    this._commonDDService.getListAllByTableID(10008).subscribe(response => {
      this.placementtypeList = response;
    });

    // this._commonHttpService.getArrayList({
    //   where: { servicecaseid: this.id }, method: 'get'
    // }, 'Caseassignments/getworkload?filter').subscribe(data => {
    //   if (data && !this.viewprfadata && this.selectedYouthName) {
    //     var admindetails = data.filter(item => item.responsibilitytypekey === 'family');
    //     if (admindetails && admindetails.length > 0) {
    //       if (admindetails[0].toworkerdetails && admindetails[0].toworkerdetails.length) {
    //         this.placementreqform.patchValue({
    //           supervisorname: admindetails[0].fromworkerdetails[0].fromworkername,
    //           supervisorphone: admindetails[0].fromworkerdetails[0].phonenumber,
    //           supervisoremail: admindetails[0].fromworkerdetails[0].email
    //         });
    //       }
    //       if (admindetails[0].fromworkerdetails && admindetails[0].fromworkerdetails.length) {
    //         this.placementreqform.patchValue({
    //           workername: admindetails[0].toworkerdetails[0].toworkername,
    //           workerphone: admindetails[0].toworkerdetails[0].phonenumber,
    //           workeremail: admindetails[0].toworkerdetails[0].email
    //         });
    //       }
    //     }
    //   }

      
    //   //at the end of init
    //   const printdata = this.getPRFAdata();
    //   this._dataStoreService.setData('PRINTDATA', printdata);
    // }
    // );
    

    this.maxToDate = new Date();

  }

  

  initYouthInformation() {
    this.primaryCitizenshipDropDownItems$ = this._commonDDService.getPickListByName('country');
    this.raceDropdownItems$ = this._commonDDService.getPickListByName('race');
    this.ethnicityDropdownItems$ = this._commonDDService.getPickListByName('ethnicity');
    this.nationalityDropdownItems$ = this._commonDDService.getPickListByName('nationality');
    this.statenameDropdownItems$ = this._commonDDService.getPickListByName('state');


    this.YouthInformationForm = this._formBuilder.group({
      YouthName: [null,Validators.required],
      YouthCjamspid: null,
      Youthdob: null,
      Youthage: null,
      Youthgender: null,
      Youthpronoun: null,
      Youthsweight: null,
      Youthsheight: null,
      Youthsrace: null,
      Youthsethnicity:null,
      Preflang: null,
      legalstatus: null,
      ifincaregoal: null,
      isacitizen: null,
      primarycitizenof: null,
      secondarycitizen: null,
      nationality: null,
      alienstatus: null,
      alienregistrationno: null,
      icwastatus: null,
      icwaeligibile: null,
      tribalaffiliation: null,
      dhoh: null,
      lgbtq: null,
      ddiq: null,
      subabuse: null,
      dv: null,
      traffvic: null,
      seabvic: null,
      seaboff: null,
      pregandparent: null,
      otherissues: null,
      otherpronoun: null,
      YouthcurrentLiving: null,
      facilityname: null,
      dsshistory: null,
      addresslineone: null,
      addresslinetwo: null,
      state: null,
      zipcode: null,
      city: null,
      county: null,
      livingother: null,
      currplacedate: null,
      datefirstentered: null,
      parentlgname: null,
      relntoyouth: null,
      livaddress: null,
      livingphno: null,
      parentlgname1: null,
      relntoyouth1: null,
      livaddress1: null,
      livingphno1: null,
      currentplacementdate: null,
      firstentereddate: null,
      Preflangother: null,
      chkboxother: null,

    });
    this.YouthInformationForm.get('Youthpronoun')?.valueChanges.subscribe(value => {
      if (value !== '3') {
          this.YouthInformationForm.get('otherpronoun')?.clearValidators();
      } else {
          this.YouthInformationForm.get('otherpronoun')?.setValidators([Validators.required]);
      }
      this.YouthInformationForm.get('otherpronoun')?.updateValueAndValidity();
  });

  }

  getformpayload() {
    const formdata = this.placementreqform.getRawValue();
    return {
      intakeservicerequestactorid: this.user.user.securityusersid,
      assessmentStaus: 'draft',
      assessmentactor: this.user.user.securityusersid,
      sectiontwo: formdata,
    };
  }


  saveForm() {

    const prfaData = this.getPRFAdata();
    if (!prfaData.placeholderIDforUploadedFiles) {
      prfaData.placeholderIDforUploadedFiles = this.placeholderIDforUploadedFiles;
    }
    this.handleUpdateOperation(this.placeholderIDforUploadedFiles, this.user?.user?.securityusersid, this.currentAssessmentId);
  
    const finalMentalpsychohospitalList = this.mentalpsychohospitalList.map(data => {
      if (data['Hospital_DischargedDate'] && data['Hospital_DischargedDate'] !== null) {
        const dischargedDate = new Date(data['Hospital_DischargedDate']);
        data['Hospital_DischargedDate'] = `${dischargedDate.getMonth() + 1}/${dischargedDate.getDate()}/${dischargedDate.getFullYear()}`;  
      } else {
        data['Hospital_DischargedDate'] = '';
      }
      const InpatientAdmissionDate = new Date(data['Hospital_InpatientAdmissionDate']);
      data['Hospital_InpatientAdmissionDate'] = `${InpatientAdmissionDate.getMonth() + 1}/${InpatientAdmissionDate.getDate()}/${InpatientAdmissionDate.getFullYear()}`;
      return {
        Hospital_name:data['Hospital_name'],
        Hospital_InpatientAdmissionDate:data['Hospital_InpatientAdmissionDate'],
        Hospital_DischargedDate:data['Hospital_DischargedDate'],
        Hospital_DischargeDiagnoses:data['Hospital_DischargeDiagnoses']
      }
    });
    prfaData.youthmedical.hospitalList = finalMentalpsychohospitalList;

    this._dataStoreService.setData('PRINTDATA', prfaData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, prfaData)
      .subscribe(
        (response) => {
          this._alertService.success('Assessment data saved');
          if (response.data) {
            this.currentAssessmentId = response.data.assessmentid;
            this.currentSubmissionId = response.data.submissionid;
          } else {
            this.currentAssessmentId = response.assessmentid;
            this.currentSubmissionId = response.submissionid;
          }
          this.additionalobjectid = this.currentAssessmentId !== undefined && this.currentAssessmentId !== null ? this.currentAssessmentId : this.additionalobjectid;
        },
        (error) => {
          this._alertService.error('Unable to save.');
        }
      );
  }

  saveFormWithProviderData(){
      this.isCompleted=true;
      this.saveForm();
      this.providerUpdateConfirmationCompleted();
      this.goBack();
  }
  getcollateral() {
    const request = {
      objectid: this.id,
      objecttype: 'case'
    };
    this._commonHttpService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'collateral/list?filter'
    ).subscribe(data => {
      if (data && data.length && data[0].getcollateraldetails && data[0].getcollateraldetails.length) {
        this.collateralList = data[0].getcollateraldetails;


      } else {
        this.collateralList = [];
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
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: getpersonlistreq
    };
    this._commonHttpService.getPagedArrayList(payload, 'People/getpersondetail?filter').subscribe(
      response => {
        this.youthList = [];
        this.legalGuardian = [];
        if (response && response.data && response.data.length) {
          this.providercjamspid = response.data.reduce((acc, item) => {
            acc[item.fullname.trim()] = item.cjamspid;  
            return acc;
        }, {});
          this.personList = response.data;
          this.personcheck();

        }
        if (this.selectedYouthName) {
          this.selectYouth(this.selectedYouthName,false);
          this.youthselected = true;
           } 
          const printdata = this.getPRFAdata();
          this._dataStoreService.setData('PRINTDATA', printdata);
        
      });
  }

  personcheck() {
    const other = this.personList.filter((e) => (e.ishousehold !== 1))
    this.otherpersonList = other;
    this.handleIfKeyIsChildFilterFn();
    this.handleIfKeyIsLgFilterFn();

    const event = this.youthList[0];
    if (!this.currentAssessmentId && !this.currentSubmissionId) {

      this.getLegalCustody(event.intakeservicerequestactorid, false)
    }
  }
  // Assosiated with personcheck method
  private handleIfKeyIsLgFilterFn() {
    this.personList.forEach(list1 => {

      if (list1.roles) {
        const lg = list1.roles.filter((role: { intakeservicerequestpersontypekey: string; }) => role.intakeservicerequestpersontypekey === 'LG');
        if (lg && lg.length > 0) {
          this.legalGuardian.push(list1);
        }
      }
    });
  }
  // Assosiated with personcheck method
  private handleIfKeyIsChildFilterFn() {
    this.personList.forEach(list => {
      if (list.isheadofhousehold === true) {
        this.headofhousehold = list;
      }

      if (list.roles) {
        const child = list.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD');
        if (child && child.length > 0) {
          this.childList.push(list);
          this.youthList.push(list);
        }
      }

    });
  }

  checkyouthage(item: any) {
    const dob = moment(item.dob);
    const age = moment().diff(dob, 'years', true);
    if (age >= 14 && age <= 21) {
      this.youthList.push(item);
    }
  }
  async getRemovalHistoryOfPerson(servicecaseid: any, pid: string) {
    this._commonHttpService
      .getSingle(
        {
          where: { objectid: servicecaseid, 'objecttypekey': 'servicecase', 'isgroup':0 }, //objecttypekey":"servicecase","isgroup":0
          method: 'get'
        },
        'intakeservreqchildremoval/getchildremoval?filter'
      ).subscribe(async (data) => {
        if (!data) {
          return
        }
        this.intakeservreqchildremovalid = data.find((e: { personid: string; }) => e.personid === pid)?.intakeservreqchildremovalid
        await this.getAuditInformation(this.intakeservreqchildremovalid)
        this.childremovalhistory = this.isChildRemovalApproved ?  data.filter((record: { personid: string; }) => record.personid === pid).sort((a: any,b: any) => new Date(b.removaltime).getTime() - new Date(a.removaltime).getTime()) : [];
      },
      (error) => {
        console.error('Error fetching removal history:', error);
      }
      );
  }

  getDateTimeFormatted(date:any){
    if(date){
      return moment(date).format('MM/DD/YYYY, h:mm A');
     }else{
      return '';
    }
  }

  async getAuditInformation(intakeservreqchildremovalid:string) {
    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: 30,
        page: 1,
        method: 'get',
        where: { 
          columnid: 'intakeservreqchildremovalid',
          tableid:  'intakeservreqchildremoval_history',
          objectid: intakeservreqchildremovalid
      }

      }),
      'servicecase/getauditlog?filter').subscribe((payload: any) => {

        const result: any = payload?.data ?? [];

        const modifiedResult: any = result.map((e: any) => e?.modifieddata).map((e: any) => e?.data).filter((item: any) =>
            item?.some((e: any) => e.key === 'approvedby') && item?.some((e: any) => e.key === 'status' && e.new_value === 'Approved')
          );

        this.isChildRemovalApproved = modifiedResult.length > 0;

      });
  }

  setFirstEnteredCare(event: any) {
      if (event.removaldate) {
        this.firstEnteredDate = moment(event.removaldate).format(this.dtformat);
    } else {
        this.firstEnteredDate = '';
    }
  }
  getPlacementHistoryByPerson(person: any) {
    if (person && person.personid) {
      this._commonHttpService
        .getSingle(
          {
            where: { personid: person.personid },
            method: 'get'
          },

          'placement/getplacementbyperson?filter'
        ).subscribe(data => {
          this.placementHistory = data;
          this.currplacement = this.placementHistory.find(item => (item.enddate !== '' || item.enddate !== null) && item.routingstatus === 'Approved')
          if (this.currplacement) {
            this.handleGetplacementbypersonApiFn();
          }
        });
    }
  }
  // Assosiated with getPlacementHistoryByPerson method
  private handleGetplacementbypersonApiFn() {
    const placementstdate = moment(this.currplacement.startdate).format(this.dtformat);
    const providername = this.prfadata?.submissiondata?.youthinformation?.parentlgname
      ? this.prfadata?.submissiondata?.youthinformation?.parentlgname
      : this.checkAndReturnPrimarycareGiverFn();
    this.YouthInformationForm.patchValue({
      currentplacementdate: moment(placementstdate).format('MM-DD-YYYY'),
      parentlgname: providername,
      livaddress: (this.currplacement?.address2 ?? '') + ', ' +
        (this.currplacement?.address1 ?? '') + ', ' +
        (this.currplacement?.cityname ?? '') + ', ' +
        (this.currplacement?.statename ?? ''),
      relntoyouth: this.currplacement?.primaryrelationship ?
        this?.currplacement?.primaryrelationship
        : this.notspecified
    });
    this.currlivingarrangement = this.placementHistory.find(item => (item.enddate !== '' || item.enddate !== null) && item.routingstatus === 'Approved');
  }

  private checkAndReturnPrimarycareGiverFn() {
    return (this.currplacement?.primarycaregiver
      ? this.currplacement?.primarycaregiver
      : this.currplacement?.livingarrangementtype);
  }

  resetLivingArrangementValues() {
    return this.YouthInformationForm.patchValue({
      parentlgname: null,
      caregiverclientid:null,
      livaddress:null,
      relntoyouth: null,
      currentplacementdate:null,
      firstentereddate:null,
      livingphno:null,
    })
  }
  placmentDetails: any;
  getParentFromLivingArrangement(id: any) {
    return this._commonHttpService
    .getArrayList(
      new PaginationRequest(
        {
          method: 'get',
          where: { personid: id },
          page: 1, 
          limit: 10
        }),
      CommonUrlConfig.EndPoint.PERSON.LIVINGARRANGEMENT.ListUrl + '?filter'
    )
  }
  getPlacementData(id: any) {
    return this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 10,
        method: 'get',
        // where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        where: { servicecaseid:id },
      }),
      'placement/getplacementbyservicecase?filter'
    )
  }
  getAllCaregiversInServicecase = (id:string) => {
    return this._commonHttpService.getArrayList(
      new PaginationRequest({
          nolimit: true,
          method: 'get',
          where: { personid: id }
      }),
      'Actorrelationships/getallcaregiversincase' + '?filter'
    )
  }
  getPlacementByPerson(id: any) {
    return this._commonHttpService
          .getSingle(
            {
              where: { personid: id },
              method: 'get'
            },
            'placement/getplacementbyperson?filter'
          )   
  }
  getDateFormatted(date:any){
    if(date && moment(date).isValid()){
      return moment(date).format(this.dtformat);
    }else{
      return '';
    }
  }
  async getProviderData(servicecaseId: string){
    const result = await this.getPlacementData(servicecaseId)?.toPromise();
    if (result && result.data) {
      const targetPerson = result.data.find(person => person.personid === this.currYouthPersonId);

      if (targetPerson && targetPerson.placements) {
          const data = targetPerson.placements;
          
          const targetPlacements = data.filter((placement: any) =>
            (placement.placementtypekey === 'PRPL' || placement.livingarrangementtypekey === 'RFKH') 
            && placement.isvoided === 0 &&
            (!placement.placementrevision ||
              placement.placementrevision.some((e: { status: string; approvedby: null; }) => e.status === 'Approved' && e.approvedby !== null)
            )
          );

          this.providerData = this.returnproviderDataMapFn(targetPlacements);

          this.targetProviderData = this.returnTargetProviderDataMapFn(data);                                
          }
      }

  }
  // Assosiated with getProviderData method
  private returnTargetProviderDataMapFn(data: any): any {
    return data.filter((e: any) => e.cpahomerevision.length > 0)
      .map((e: any) => ({
        cpahomerevision: e.cpahomerevision,
        providerid: e.providerdetails?.provider_id,
        startdate: e.startdate
      }));
  }
  // Assosiated with getProviderData method
  private returnproviderDataMapFn(targetPlacements: any): any[] {
    return targetPlacements.map((e: any) => {
      if (e.livingarrangementtypekey === 'RFKH') {
        const cjamspid = this.providercjamspid[e.primarycaregiver.trim()];
        return this.handleIfLivingarrangementtypekeyIsRFKH(e, cjamspid);
      } else {
        return this.handleIfLivingarrangementtypekeyIsNotRFKH(e);
      }
    });
  }
  // Assosiated with getProviderData method
  private handleIfLivingarrangementtypekeyIsNotRFKH(e: any) {
    return {
      name: e.providerdetails?.providername + '- Start Date: ' + moment(e.startdate).format(this.dtformat) + '- End Date: ' + (e.enddate ? moment(e.enddate).format(this.dtformat) : ''),
      address: e.providerdetails ? e.providerdetails.address : ' ',
      providerId: e.providerdetails ? e.providerdetails.provider_id : ' ',
      cpaStatus: e.cpahomerevision.length > 0 ? 1 : 0,
      startdate: e.startdate
    };
  }
  // Assosiated with getProviderData method
  private handleIfLivingarrangementtypekeyIsRFKH(e: any, cjamspid: { name: string; cjamspid: string; }) {
    return {
      name: e.primarycaregiver + '- Start Date: ' + moment(e.startdate).format(this.dtformat) + '- End Date: ' + (e.enddate ? moment(e.enddate).format(this.dtformat) : ''),
      address: `${e.address1 ?? ''}, ${e.address2 ?? ''}, ${e.cityname ?? ''}, ${e.statename ?? ''}, ${e.zipcode ?? ''}`,
      providerId: cjamspid,
      cpaStatus: e.cpahomerevision.length > 0 ? 1 : 0,
      startdate: e.startdate
    };
  }

  loadExaminationList(personID: any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personID }
        }),
        'personexamination/list?filter'
      ).subscribe(list => {
      if (list && Array.isArray(list) && list.length) {
        this.examinationList = list;
        this.YouthMedicalForm.get('examinationList')?.patchValue(this.examinationList);
      }
    });
  }
  
  addfamily(modal: any) {
    if (modal) {
      const control = <FormArray>this.OtherRelativeForm.controls['othersarray'];
      this.getrecentlist();
      this.spouseorpartnerarray[control.length] = this.spouseorpartnerList;
      control.push(this.createFormGroup(modal));
    }
    else {
      this.getrecentlist();
      const control = <FormArray>this.OtherRelativeForm.controls['othersarray'];
      this.spouseorpartnerarray[control.length] = this.spouseorpartnerList;
      control.push(this.createFormGroupNew());
    }


  }
  getrecentlist(){
    if (this.spouseorpartnerList.length > 0) {
      if (this.addedspouseList.length === 0) {
        this.addedspouseList = [];
        this.addedspouseList = this.spouseorpartnerList
      }
      const res1 = this.addedspouseList.length !== 0 ? this.addedspouseList : this.spouseorpartnerList;

      if (res1.length > 0) {
        const res = this.spouseorpartnerList.filter(entry1 => !res1.some(entry2 => entry1.fullname === entry2.siblingname));
        this.spouseorpartnerList = res;
      }

    }

  }


  private createFormGroupNew() {
    return this._formBuilder.group({
      othername: null,
      othercjamspid: null,
      otherphno: null,
      otheraddress: null,
    });
  }
  private createFormGroup(modal: any) {

    return this._formBuilder.group({

      othername: modal.othername ? modal.othername : '',
      othercjamspid: modal.othercjamspid ? modal.othercjamspid : '',
      otherphno: modal.otherphno ? modal.otherphno : '',
      otheraddress: modal.otheraddress ? modal.otheraddress : ''
    });

  }
  addsibling(modal: any) {
    const control = <FormArray>this.OtherRelativeForm.controls['siblingsarray'];
    const siblingListToAdd:any[] = this.spouseorpartnerList;
    if (modal) {
      this.getrecentsibling(modal);
      control.push(this.createsiblingGroup(modal));
    }
    else {
      this.getrecentsibling(null);
      control.push(this.createsiblingGroupNew());
    }
    this.siblingArraylist.push(siblingListToAdd)
  }
  private createsiblingGroupNew() {
    return this._formBuilder.group({
      siblingname: null,
      siblingdob: null,
      siblingplacement: null,
      siblingcurrentliving: null,
      siblingteammeeting: null,
      siblingaddress: null,
      siblingphno: null
    });
  }
  private createsiblingGroup(modal: any) {


    return this._formBuilder.group({

      siblingname: modal.siblingname ? modal.siblingname : '',
      siblingdob: modal.siblingdob ? modal.siblingdob : '',
      siblingcurrentliving: modal.siblingcurrentliving ? modal.siblingcurrentliving : '',
      siblingplacement: modal.siblingplacement ? modal.siblingplacement : '',
      siblingteammeeting: modal.siblingteammeeting ? modal.siblingteammeeting : '',
      siblingaddress: modal.siblingaddress ? modal.siblingaddress : '',
      siblingphno: modal.siblingphno ? modal.siblingphno : ''

    });


  }
  getRelationshipOfPerson(event: any) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    this.youthrelationships = [];
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 30,
          method: 'get',
          where: { objectid: caseID, objecttypekey: 'servicecase', personid: event.personid, 'isExpungementSuperUser': isExpungementSuperUser, 'iscaseexpunged': this.iscaseexpunged}
        }),
        'People/getallpersonrelationbyprovidedpersonid?filter'
      ).subscribe(response => {
        if (response && Array.isArray(response)) {
          this.youthrelationships.push(...response);
          this.handleYouthmotherFn(response);

          this.handleYouthfatherFn(response);
          this.handleIfLgfatherORmotherFn();
          this.handleHeadofhouseholdIfMotherOrFatherFn();



          this.getyouthsibling(event);
          this.getyouthspouseorpartner(event);
          if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthrelative.siblingsarray) {
             this.prfadata.submissiondata.youthrelative.siblingsarray.forEach((element: any, _index: any) => {
              this.selectedSiblingName = element.siblingname;
              this.addsibling(element);

            });
          }
          if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthrelative.othersarray) {
            this.prfadata.submissiondata.youthrelative.othersarray.forEach((element: any, _index: any) => {
              this.addfamily(element);
            });
          }
    
        
        }
      });
  }
  // Assosaited with getRelationshipOfPerson method
  private handleHeadofhouseholdIfMotherOrFatherFn() {
    if (this.headofhousehold.personid === this.youthmother?.personid || this.headofhousehold.personid === this.youthfather?.personid) {
      this.OtherRelativeForm.patchValue({
        headofhouse: null
      });
    }
    else {
      const address = (this.headofhousehold.address ? this.headofhousehold.address : '') + " " + (this.headofhousehold.address2 ? this.headofhousehold.address2 : '') + " " + (this.headofhousehold.city ? this.headofhousehold.city : '') + " " + (this.headofhousehold.county ? this.headofhousehold.county : '') + " " + (this.headofhousehold.state ? this.headofhousehold.state : '') + " " + (this.headofhousehold.zipcode ? this.headofhousehold.zipcode : '');
      this.OtherRelativeForm.patchValue({
        headofhouse: this.headofhousehold.fullname,
        hohcjamspid: this.headofhousehold.cjamspid,
        hohphno: this.formatPhoneno(this.headofhousehold.phonenumber),
        hohaddress: address
      });

    }
  }
  // Assosaited with getRelationshipOfPerson method
  private handleIfLgfatherORmotherFn() {
    if (this.lgfather || this.lgmother) {
      this.OtherRelativeForm.patchValue({
        legalguardian: null,
        legalcjamspid: null,
        legalgphno: null,
        legalgaddress: null
      });
    }
    else if (this.legalGuardian?.length) {
      const address = (this.legalGuardian[0].address ? this.legalGuardian[0].address : '') + " " + (this.legalGuardian[0].address2 ? this.legalGuardian[0].address2 : '') + " " + (this.legalGuardian[0].city ? this.legalGuardian[0].city : '') + " " + (this.legalGuardian[0].county ? this.legalGuardian[0].county : '') + " " + (this.legalGuardian[0].state ? this.legalGuardian[0].state : '') + " " + (this.legalGuardian[0].zipcode ? this.legalGuardian[0].zipcode : '');
      this.OtherRelativeForm.patchValue({
        legalguardian: this.legalGuardian[0].fullname,
        legalcjamspid: this.legalGuardian[0].cjamspid,
        legalgphno: this.formatPhoneno(this.legalGuardian[0].phonenumber),
        legalgaddress: address,
      });
    }
  }
  // Assosaited with getRelationshipOfPerson method
  private handleYouthfatherFn(response: any) {
    const youthfather = response.find((element: { relationshiptypekey: string; }) => element.relationshiptypekey === 'BGFTHR');
    if (youthfather) {

      this.youthfather = this.personList.find(item => item.personid === youthfather.person2id);
      const address = (this.youthfather.address ? this.youthfather.address : '') + " " + (this.youthfather.address2 ? this.youthfather.address2 : '') + " " + (this.youthfather.city ? this.youthfather.city : '') + " " + (this.youthfather.county ? this.youthfather.county : '') + " " + (this.youthfather.state ? this.youthfather.state : '') + " " + (this.youthfather.zipcode ? this.youthfather.zipcode : '');
      this.lgfather = this.legalGuardian.find(item => item.personid === this.youthfather.personid);



      this.OtherRelativeForm.patchValue(this.returnFatherPayloadFn(youthfather, address));


    }
  }
  // Assosaited with getRelationshipOfPerson method
  private returnFatherPayloadFn(youthfather: any, address: string) {
    return {
      fathername: this.youthfather.fullname,
      fathercjamspid: this.youthfather.cjamspid,
      fatherphno: this.youthfather.phonenumber ? this.formatPhoneno(this.youthfather.phonenumber) : this.notspecified,
      fathercc: youthfather.caregiverflag ? true : false,
      fatherLg: this.lgfather ? true : false,
      fatheraddress: address ? address : ''
    };
  }
  // Assosaited with getRelationshipOfPerson method
  private handleYouthmotherFn(response: any) {
    const youthmother = response.find((element: { relationshiptypekey: string; }) => element.relationshiptypekey === 'BGMTHR');
    if (youthmother) {

      this.youthmother = this.personList.find(item => item.personid === youthmother.person2id);
      const address = (this.youthmother.address ? this.youthmother.address : '') + " " + (this.youthmother.address2 ? this.youthmother.address2 : '') + " " + (this.youthmother.city ? this.youthmother.city : '') + " " + (this.youthmother.county ? this.youthmother.county : '') + " " + (this.youthmother.state ? this.youthmother.state : '') + " " + (this.youthmother.zipcode ? this.youthmother.zipcode : '');
      this.lgmother = this.legalGuardian.find(item => item.personid === this.youthmother.personid);
      this.OtherRelativeForm.patchValue(this.returnMethwePayloadFn(youthmother, address));
    }
  }
  // Assosaited with getRelationshipOfPerson method
  private returnMethwePayloadFn(youthmother: any, address: string) {
    return {
      mothername: this.youthmother.fullname,
      mothercjamspid: this.youthmother.cjamspid,
      motherphno: this.youthmother.phonenumber ? this.formatPhoneno(this.youthmother.phonenumber) : this.notspecified,
      mothercc: youthmother.caregiverflag ? true : false,
      motherLg: this.lgmother ? true : false,
      motheraddress: address ? address : ''
    };
  }

  getyouthsibling(youth: any) {
    this.siblingList = this.returnPersonListFn(youth);
  }

  getyouthspouseorpartner(youth: any){
    this.spouseorpartnerList = this.returnPersonListFn(youth);
  }

  private returnPersonListFn(youth: any): any[] {
    return this.personList.filter(element => element.personid !== this.youthmother?.personid
      && element.personid !== this.youthfather?.personid
      && element.personid !== youth.personid
      && element.ishousehold === 1);
  }

  getrecentsibling(modal:any) {

    if (this.siblingList.length > 0) {
      if (this.addedsiblingList.length === 0) {
        this.addedsiblingList = [];
        this.addedsiblingList = this.siblingList
      }
    }
  }
resetallforms(){
 this.YouthInformationForm.reset();

 this.placementreqform.reset();
 this.OtherRelativeForm.reset();
 this.YouthEducationForm.reset();
 this.YouthFamilyForm.reset();
 this.YouthMedicalForm.reset();
 this.YouthplacementserviceForm.reset();
 
}
  async selectYouth(eventname: any,changeyouth?: any) {
    this.selectedYouthName = eventname;
    this.youthselected = true;
    if(changeyouth === true){
    this.resetallforms();
    this.caseworkersignature = ''
    this.providersignature = ''
    this.supervisorsignature=''
    this.checkboxStates = {};
    }
    this.YouthInformationForm.patchValue({YouthName:eventname});
    this.workerandsupervisordetails(); 
    this.currplacement = '';
    if (this.YouthInformationForm.get('Youthpronoun')?.value === "3") {
      this.showother = true;
    }
    else {
      this.showother = false;

    }
    const event = this.youthList.find(item => item.fullname === this.selectedYouthName);
    this.currYouthPersonId = event?.personid;
    this.objectId = event?.personid;
    this.currServiceCaseId = event?.servicecaseid;
    this._dataStoreService.setData('YOUTHID', event.personid);
    this._dataStoreService.setData('YOUTHID', event.personid);
    this.getRelationshipOfPerson(event);
    this.loadmedicalinfo(event);   
    this.getLegalCustody(event.intakeservicerequestactorid,this.legalStatusValueChange)

    this.getIfInCareGoals(event.personid)

    this.relationshipArrayOfYouth = event?.relationshiparray?.filter((ele: { firstname: any; })=>ele.firstname===event.firstname);

    this.handleCitizenshiptypekeyFn(event);
    if (event.race) {
      let racetype = [];
      this.raceDropdownItems$.subscribe(data => {
        racetype = data.filter(item => item.ref_key === event.race[0].racetypekey)
         this.YouthInformationForm.patchValue({
          Youthsrace: racetype[0]?.description
        })
      });
    }
    if (event.ethinicity) {
      let ethnicitytype: any[] = [];
      this.ethnicityDropdownItems$.subscribe(data => {
        ethnicitytype = data.filter(item => item.ref_key === event.ethinicity)
         this.YouthInformationForm.patchValue({
          Youthsethnicity: ethnicitytype[0]?.description
        })
      });
    }
    if (event.nationalitytypekey) {
      let nationalitytype: any[] = [];
      this.nationalityDropdownItems$.subscribe(data => {
        nationalitytype = data.filter(item => item.ref_key === event.nationalitytypekey)
        // There is no mapping available for some nationalitytypekey like 99 in the reference type table
         this.YouthInformationForm.patchValue({
          nationality: nationalitytype[0] ? nationalitytype[0].description : 'Not Available'
        })
      });
    }
    await this.getRemovalHistoryOfPerson(this.currServiceCaseId, this.currYouthPersonId);
    this.getEducationListInfo(event);
    this.getemploymentDetails(event);
    this.setFirstEnteredCare(event);
    this.loadExaminationList(this.currYouthPersonId);
    this.YouthInformationForm.patchValue(this.returnYouthInformationFormPayloadFn(event))
    this.getIfInCareGoals(event.personid)
    this.YouthplacementserviceForm.patchValue({
      assessmentcompletiondate: this.currentDate

    })
    this.getProviderData(this.currServiceCaseId);
  }
  // Assosiated with selectYouth method
  private returnYouthInformationFormPayloadFn(event: any) {
    return {
      YouthCjamspid: event.cjamspid,
      Youthdob: this.formatdob(event.dob),
      Youthage: event.age,
      Youthgender: event.gender,
      isacitizen: event.citizenalenageflag === 1 ? 'Yes' : 'No',
      alienstatus: event.alienstatustypekey ? event.alienstatustypekey : this.notspecified,
      alienregistrationno: event.alienregistrationtext ? event.alienregistrationtext : this.notspecified,
      icwastatus: event.icwastatusinquiry ? event.icwastatusinquiry : this.notspecified,
      Youthsweight: event.weight ? event.weight : this.notspecified,
      Youthsheight: event.height ? event.height : this.notspecified,
      icwaeligibile: event.icwaeligibleformembership ? event.icwaeligibleformembership : this.notspecified,
      tribalaffiliation: event.icwatribename ? event.icwatribename : this.notspecified,
      // nationality: event.nationalitytypekey ? event.nationalitytypekey : this.notspecified,
      firstentereddate: event.removaldate ? moment(event.removaldate).format(this.dtformat) : '',
    };
  }
  // Assosiated with selectYouth method
  private handleCitizenshiptypekeyFn(event: any) {
    if (event.primarycitizenshiptypekey) {

      let primarycitizen = [];
      this.primaryCitizenshipDropDownItems$.subscribe(data => {
        primarycitizen = data.filter(item => item.ref_key === event.primarycitizenshiptypekey);
        this.YouthInformationForm.patchValue({
          primarycitizenof: primarycitizen[0]?.description
        });
      });

    }
    if (event.seccitizenshiptypekey) {
      let seccitizen = [];
      this.primaryCitizenshipDropDownItems$.subscribe(data => {
        seccitizen = data.filter(item => item.ref_key === event.seccitizenshiptypekey);
        this.YouthInformationForm.patchValue({
          secondarycitizen: seccitizen[0]?.description
        });
      });

    }
  }

  private getLegalCustodyDropdown() {
      this._commonHttpService
        .getArrayList(
            {
                where: {
                    referencetypeid: '28',
                    teamtypekey: null
                },
                method: 'get',
                nolimit: true
            },
            'referencetype/gettypes' + '?filter'
        )
        .subscribe((res)=> {
          res.forEach((dropdowns)=>{
            this.legalstatus.push(dropdowns.description)
          })
        });
}

  getIfInCareGoals(personId: any) {
    if( this.permanencyGoalsResponse && this.permanencyGoalsResponse.length > 0) {
   
    let permanencyGoals = '';
    const res  = this.permanencyGoalsResponse.filter((permanceyGoal: { personid: any; }) => {
      return permanceyGoal.personid === personId
    } )
    if(res.length > 0) {
      const permanencyplans = res[0]['permanencyplans'];
      if (permanencyplans && permanencyplans.length > 0) {
        const permanencyGoalsArr: any[] = [];
        permanencyplans.forEach((plan: any) => {
          if(!plan.enddate) {
           permanencyGoalsArr
           .push( plan['primarypermanency'][0]['plantypedescription']  + ',' +
           plan['concurrentpermanency'][0]['concurrentplandescription']
           )
          }       
         });
         permanencyGoals = permanencyGoalsArr.join(',')
      } 
    }
    this.YouthInformationForm.get('ifincaregoal')?.patchValue(permanencyGoals);
    this.YouthInformationForm.updateValueAndValidity()
  } 
  } 

  onChangepronoun(event: any) {
    if (event === "3") {
      this.showother = true;
    } else {
      this.showother = false;
      this.YouthInformationForm.patchValue({ otherpronoun: null })
    }

  }

  isOtherPronounRequired() {
    const pronounValue = this.YouthInformationForm.get('Youthpronoun')?.value;
    return pronounValue === '3' && this.YouthInformationForm.get('otherpronoun')?.hasError('required');
}
  getPRFAdata() {

    return {      
      youthinformation: this.YouthInformationForm.getRawValue(),
      placementinfo: this.placementreqform.getRawValue(),
      youthfamily: this.YouthFamilyForm.getRawValue(),
      youthrelative: this.OtherRelativeForm.getRawValue(),
      youtheducation: this.YouthEducationForm.getRawValue(),
      youthmedical: this.YouthMedicalForm.getRawValue(),
      youthplacementservice :this.YouthplacementserviceForm.getRawValue(),
      youthproviderservice: this.YouthProviderForm.getRawValue(),
      currentSubmissionId: this.currentSubmissionId,
      routingsupervisors: this.routingSupervisors,
      uploadedFiles: this.uploadedFiles,
      placeholderIDforUploadedFiles:this.placeholderIDforUploadedFiles,
      isCompleted: this.isCompleted,
      comments:this.comments,
      reroutesupervisor: this.reroutesupervisor,
      supervisorname: this.supervisorname,
      cpaDropdownStatus:this.cpaDropdownStatus,
      assessmentStaus: this.assessmentStatus ? this.assessmentStatus : this.returnAssessmentStatusFn(),
      // YouthFamilyForm:this.YouthFamilyForm.getRawValue()
    };
  }

  private returnAssessmentStatusFn() {
    return this.prfadata.submissiondata ? this.prfadata.submissiondata.assessmentStaus : null;
  }

  updateAssessmentStatus(event: any) {
    const assessmentStatus = event.value;
    this.YouthplacementserviceForm.controls['assessmentstatus'].setValue(assessmentStatus);
    if (event.value) {
      this.YouthplacementserviceForm.patchValue({
        assessmentapprovaldate: moment(new Date()).format(this.dtformat1)
      });
    }

}

  isRejected(): boolean {
    const assessmentStatus = this.YouthplacementserviceForm.controls['assessmentstatus'].value || false;
    return assessmentStatus !== 'Rejected';
  }

  // 
  

  load:boolean = false;
  uploadclosed(event: any){
    if(event){
      this.documentuploaded.closeupload();
      this.load = true;
    }
  }

  updateLoad() {
    this.load = false;
  }

  onselectliving(event: any, servicecaseid: any) {
    this.currentliving = event;
    switch (event) {
        case 'Home of Parent or Legal Guardian':
            this.handleHomeOfParent(servicecaseid || this.currServiceCaseId);
            break;
        case 'Living Arrangement':
            this.getLivingArrangementInfo(this.currYouthPersonId, servicecaseid || this.currServiceCaseId);
            break;
        case 'Placement':
            this.getPlacementByServCase(this.currServiceCaseId);
            break;
        default:
            break;
    }
  }

  handleHomeOfParent(servicecaseid: string) {
    this.getLivingArrangementFromPersons(this.currYouthPersonId);
    this.getCaregiversInServiceCase(servicecaseid);
}

  caregiverclientid!: string;
  getLivingArrangementFromPersons(personid: string) {
    this._commonHttpService.getArrayList(
        new PaginationRequest({
            method: 'get',
            where: { personid: personid },
            page: 1,
            limit: 10
        }),
        CommonUrlConfig.EndPoint.PERSON.LIVINGARRANGEMENT.ListUrl + '?filter'
    ).subscribe(res => {
        if (res && res.length > 0) {
            const livingArrangement = res[0];
            this.YouthInformationForm.patchValue({ facilityname: livingArrangement?.primarycaregivername });
            this.caregiverclientid = livingArrangement?.caregiverclientid;
        }
    });
  }
  
  getCaregiversInServiceCase(id: string) {
    this._commonHttpService.getArrayList(
        new PaginationRequest({
            nolimit: true,
            method: 'get',
            where: { personid: id }
        }),
        'Actorrelationships/getallcaregiversincase' + '?filter'
    ).subscribe(response => {
        if (response && response.length > 0) {
            const caregivers = response[0]?.getallcaregiversincase;
            const addressObj = caregivers.find((item: { personid: string; }) => item.personid === this.caregiverclientid);
            if (addressObj && addressObj.address && addressObj.address.length > 0) {
                const address = addressObj.address[0];
                this.patchAddressInfo(address);
            }
        }
    });
  }

  patchAddressInfo(address: any) {
    const statename = address?.statename;
    if (statename) {
        this.statenameDropdownItems$.subscribe(data => {
            const statenametype = data.find(item => item.description === statename);
            if (statenametype) {
                this.loadCounty(statenametype.ref_key);
                this.YouthInformationForm.patchValue({ state: statenametype.description || 'Not Available' });
            }
        });
    }

    this.YouthInformationForm.patchValue({
        addresslineone: address?.address || '',
        addresslinetwo: address?.address2 || '',
        city: address?.city || '',
        state: statename || '',
        county: address?.countydescription || '',
        zipcode: address?.zipcode || ''
    });
  }

  async getLivingArrangementInfo(pid:string, sid:string) {
    this.resetLivingArrangementValues();
    await this.getRemovalHistoryOfPerson(sid, pid);

    /*
    Checks if childremoval exists - if no, then get data from persons tab living arrangement
                                    if yes, then first patches the firstentered data value and 
                                            then checks if there is any open living arrangement
           if there is an open living arrangement(defined as mostrecentplacement) then gets provider data from there. 
    */

    if (this.childremovalhistory.length === 0 || this.childremovalhistory[0]?.exitdate) {
        this.handleParentFromLivingArrangementFn(pid);
        this.YouthInformationForm.patchValue({ currentplacementdate: '' });

        this.handleAllCaregiversInServicecaseFn(sid);
        return;
    }

    this.YouthInformationForm.patchValue({
        firstentereddate: moment(this.childremovalhistory[0]?.removaldate).format(this.dtformat)
    });

    const result = await this.getPlacementData(sid)?.toPromise();

    if (result && result.data) {
        this.handleGetPlacementDataRespFn(result, pid);
    }
}
// Assosiated with getLivingArrangementInfo method
  private handleGetPlacementDataRespFn(result: any, pid: string) {
    const targetPerson = result.data.find((person: { personid: string; }) => person.personid === pid);
    const data = targetPerson?.placements;

    if (data && data.length > 0) {
      const targetPlacement = data
        .filter((placement: { placementtypekey: string; routingstatus: string; livingarrangementtypekey: string; }) => placement && placement.placementtypekey === 'LA' && placement.routingstatus === 'Approved' && placement.livingarrangementtypekey !== 'RNW')
        .sort((a: any, b: any) => new Date(b.starttime).getTime() - new Date(a.starttime).getTime());

      if (targetPlacement.length > 0) {
        const mostRecentPlacement = targetPlacement[0];

        this.handleIfRoutingstatusIsApprovedFn(mostRecentPlacement);
      }
    }
  }
  // Assosiated with getLivingArrangementInfo method
  private handleIfRoutingstatusIsApprovedFn(mostRecentPlacement: any) {
    if (!mostRecentPlacement.enddate && mostRecentPlacement.routingstatus === 'Approved') {
      // Update form values based on the most recent placement
      this.YouthInformationForm.patchValue({
        currentplacementdate: moment(mostRecentPlacement.startdate).format(this.dtformat),
        parentlgname: mostRecentPlacement.primarycaregiver || '',
        livaddress: `${mostRecentPlacement.address1 ?? ''}, ${mostRecentPlacement.address2 ?? ''}, ${mostRecentPlacement.cityname ?? ''}, ${mostRecentPlacement.statename ?? ''}, ${mostRecentPlacement.zipcode ?? ''}`,
        relntoyouth: mostRecentPlacement.primaryrelationship || '',
        livingphno: mostRecentPlacement.contactphone ? this.formatPhoneno(mostRecentPlacement.contactphone) : ''
      });
    }
  }

// Assosiated with getLivingArrangementInfo method
  private handleParentFromLivingArrangementFn(pid: string) {
    this.getParentFromLivingArrangement(pid).subscribe(res => {
      if (res && res.length > 0) {
        this.caregiverclientid = res[0].caregiverclientid;
        this.YouthInformationForm.patchValue({
          currentplacementdate: moment(res[0]?.livingstartdate.startdate).format(this.dtformat)
        });
      }
    });
  }
// Assosiated with getLivingArrangementInfo method
  private handleAllCaregiversInServicecaseFn(sid: string) {
    this.getAllCaregiversInServicecase(sid).subscribe(response => {
      if (response && response.length > 0) {
        const getallcaregiversincase = response[0].getallcaregiversincase;
        const personObj = getallcaregiversincase.find((item: { personid: string; }) => item.personid === this.caregiverclientid);

        if (personObj && personObj.address && personObj.address.length > 0) {
          const { address, address2, city, statename, countydescription, zipcode } = personObj.address[0];
          const relationship = this.relationshipArrayOfYouth?.filter(ele => ele.secondaryuserid === this.caregiverclientid);
          this.YouthInformationForm.patchValue({
            livaddress: `${address} ${address2} ${city} ${countydescription} ${statename} ${zipcode}`,
            relntoyouth: relationship[0]?.description,
            livingphno: this.formatPhoneno(personObj.phonenumber),
            parentlgname: personObj.personname
          });
        }
      }
    });
  }

async getPlacementByServCase(sid: string) {
  this.resetLivingArrangementValues();
  await this.getRemovalHistoryOfPerson(this.currServiceCaseId, this.currYouthPersonId);

  if (this.childremovalhistory?.length === 0 || this.childremovalhistory?.[0]?.exitdate) {
      return;
  }

  this.YouthInformationForm.patchValue({
      firstentereddate: moment(this.childremovalhistory?.[0]?.removaldate).format(this.dtformat),
  });

  const result = await this.getPlacementData(sid)?.toPromise();

  if (result && result.data) {
      this.handlePlacementDataInGetPlacementByServCaseFn(result);
  }
}
// Assosiated with getPlacementByServCase method
  private handlePlacementDataInGetPlacementByServCaseFn(result: any) {
    const targetPerson = result?.data?.find((person: any) => person?.personid === this.currYouthPersonId);

    if (targetPerson && targetPerson.placements) {
      const data = targetPerson.placements;

      const targetPlacement = data.filter((placement: any) => placement?.placementtypekey === 'PRPL' &&
        !placement?.enddate &&
        placement?.placementrevision &&
        placement?.placementrevision.some((e: any) => e?.status == 'Approved' && e?.approvedby !== null)
      );

      if (targetPlacement && targetPlacement.length > 0) {
        const mostRecentPlacement = targetPlacement.reduce((prev: { starttime: number; }, current: { starttime: number; }) => (prev.starttime > current.starttime) ? prev : current);

        if (mostRecentPlacement.enddate) {
          this.resetPlacementFormValues();
        } else {
          this.patchPlacementFormValues(mostRecentPlacement);
        }
      }
    }
  }

resetPlacementFormValues() {
  this.YouthInformationForm.patchValue({
      currentplacementdate: '',
      livingphno: '',
      relntoyouth: '',
      livaddress: '',
      parentlgname: ''
  });
}

patchPlacementFormValues(mostRecentPlacement: any) {
  const formattedContactPhone = this.formatPhoneno(mostRecentPlacement.contactphone);

  this.YouthInformationForm.patchValue({
      currentplacementdate: moment(mostRecentPlacement.startdate).format(this.dtformat),
      livingphno: formattedContactPhone || '',
      relntoyouth: mostRecentPlacement.primaryrelationship || ''
  });

  if (mostRecentPlacement.providerdetails) {
      this.YouthInformationForm.patchValue({
          livaddress: mostRecentPlacement.providerdetails.address,
          parentlgname: mostRecentPlacement.providerdetails.providername ? mostRecentPlacement.providerdetails.providername : mostRecentPlacement.primarycaregiver
      });
  }
}

  onchangespecial(event: any) {

    if (event.target.value === 'otherissues') {
      if (event.target.checked) {
        this.showothersc = true;
      } else {
        this.showothersc = false;
        this.YouthInformationForm.patchValue({
          chkboxother: null
        })
      }
    }

  }
  onlanguagechange(event: any) {
    this.languagepref = event;
    if (event === 'Others') {
      this.langother = true;


    } else {
      this.langother = false;
      this.YouthInformationForm.patchValue({ Preflangother: null })
    }
  }
  // section 3 start
  inityouthfamilyform() {
    const formControls: any = {
      cansassessment: null,
      psychosocial: null,
      yplacementhist: null,
      physevaluation: null,
      schoolrecords: null,
      treports: null,
      creport: null,
      psyassessment: null,
      hdreport: null,
      certneed: null,
      otherscheck: null,
      otherreqdocs: null
    };
      this.requireddocs.forEach((_doc: any, index: any) => {
          formControls['checkbox_' + index] = new FormControl(false);
          formControls['status_' + index] = new FormControl('');
          formControls['clarification_' + index] = new FormControl(null);
          this.checkboxStates[index] = false;
          this.clarificationReq[index] = '';
      });
        
    this.YouthFamilyForm = this._formBuilder.group(formControls);    
  }

  onCheckboxChange(index: number, event: Event) {
    const eventTarget = event.target as HTMLInputElement;
    this.checkboxStates[index] = eventTarget.checked;
    
    if (index == this.requireddocs.length-1) {
      this.showchheckother=eventTarget.checked;
      this.YouthFamilyForm.patchValue({
        otherscheck: true
    });
    }
}

  onRadioChange(index: number, event: any) {
    this.clarificationReq[index] = event.value;
    this.requireddocs.forEach((_doc: any, i: any) => {
      if(this.clarificationReq[i]  === 'pending') {
        this.YouthFamilyForm.get('clarification_'+i)?.setValidators([Validators.required])
      } else {
        this.YouthFamilyForm.get('clarification_'+i)?.clearValidators()
      }
      this.YouthFamilyForm.get('clarification_' + i)?.updateValueAndValidity();
  })
 
   
  }


  inityouthsiblingform() {

    this.OtherRelativeForm = this._formBuilder.group({
      motherLg: null,
      mothercc: null,
      mothername: null,
      mothercjamspid: null,
      motherphno: null,
      motheraddress: null,

      fatherLg: null,
      fathercc: null,
      fathername: null,
      fathercjamspid: null,
      fatherphno: null,
      fatheraddress: null,

      legalguardian: null,
      legalgphno: null,
      legalgaddress:null,
      legalcjamspid: null,

      headofhouse: null,
      hohcjamspid: null,
      hohphno: null,
      hohaddress: null,
      
    });
    this.OtherRelativeForm.setControl('othersarray', this._formBuilder.array([]));
    this.OtherRelativeForm.setControl('siblingsarray', this._formBuilder.array([]));
    this.OtherRelativeForm.setControl('otherrelativearray', this._formBuilder.array([]));
    this.OtherRelativeForm.setControl('otherinterestedparties', this._formBuilder.array([]));

  }

  selectother(eventname: any, i: any) {
    const event = this.spouseorpartnerList.find(item => item.fullname === eventname);
    const address = (event.address ? event.address :'') + " " + (event.address2 ? event.address2 :'') + " " + (event.city ? event.city: '') + " "  + (event.county ? event.county: '') + " " + (event.state ? event.state :'') + " " + (event.zipcode ? event.zipcode :'');
    (<FormArray>this.OtherRelativeForm.get('othersarray')).controls[i].patchValue({

      othername: event.fullname,
      othercjamspid: event.cjamspid,
      otherphno: event.phonenumber,
      otheraddress: address
    })
    const elem = {
      othername: event.fullname,
      othercjamspid: event.cjamspid,
      otherphno: event.phonenumber,
      otheraddress: address
    }
   this.addedspouseList.push(elem);
  }
  selectsibling(eventname: any, i: any) {
    this.selectedSiblingName = eventname;
    const event = this.siblingList.find(item => item.fullname === eventname);
    const address = (event.address ? event.address :'') + " " + (event.address2 ? event.address2 :'') + " " + (event.city ? event.city : '') + " " + (event.county ? event.county :'') + " " + (event.state ? event.state :'') + " " + (event.zipcode ? event.zipcode :'');
    (<FormArray>this.OtherRelativeForm.get('siblingsarray')).controls[i].patchValue({

      siblingname: eventname,
      siblingdob: this.formatdob(event.dob),
      siblingaddress: address ? address : '',
      siblingphno: this.formatPhoneno(event.phonenumber)
    })
    const element = {
      siblingname: eventname,
      siblingdob: this.formatdob(event.dob),
      siblingaddress: address ? address : '',
      siblingphno: this.formatPhoneno(event.phonenumber)
    }
    this.addedsiblingList.push(element);
  }

  addotherrelative(modal: any) {
    if (modal) {
      const control = <FormArray>this.OtherRelativeForm.controls['otherrelativearray'];
      control.push(this.createrelativeGroup(modal));
    }
    else {
      const control = <FormArray>this.OtherRelativeForm.controls['otherrelativearray'];
      control.push(this.createrelativeGroupNew());
    }


  }
  private createrelativeGroupNew() {
    return this._formBuilder.group({
      relativename: null,
      relationship: null,
      teammeeting: null,
      transportneed: null,
      relativeaddress: null,
      relativephno: null
    });
  }
  private createrelativeGroup(modal: any) {
    this.selectedrelativename = modal.relativename;
    return this._formBuilder.group({

      relativename: modal.relativename ? modal.relativename : '',
      relationship: modal.relationship ? modal.relationship : '',
      teammeeting: modal.teammeeting ? modal.teammeeting : '',
      transportneed: modal.transportneed ? modal.transportneed : '',
      relativeaddress: modal.relativeaddress ? modal.relativeaddress : '',
      relativephno: modal.relativephno ? modal.relativephno : ''

    });

  }
  selectrelative(eventname: any, i: any) {
    this.selectedrelativename = eventname;
    const event = this.otherpersonList.find(item => item.fullname === this.selectedrelativename);
    const relative = this.youthrelationships.find(f => f.person2id === event.personid);
    const address = (event.address ? event.address:'') + " " + (event.address2 ? event.address2 :'') + " " + (event.city ? event.city :'') + " " + (event.county ? event.county :'') + " " + (event.state ?event.state :'') + " " +( event.zipcode ?  event.zipcode : '');
    (<FormArray>this.OtherRelativeForm.get('otherrelativearray')).controls[i].patchValue({

      relativeaddress: address,
      relationship: relative ? relative.relation : ''
    })

  }

  //section 4.1
  addinterestedparty(modal: any) {
    if (modal) {
      const control = <FormArray>this.OtherRelativeForm.controls['otherinterestedparties'];
      control.push(this.createotherpartiesGroup(modal));
    }
    else {

      const control = <FormArray>this.OtherRelativeForm.controls['otherinterestedparties'];
      control.push(this.createotherpartiesGroupNew());
    }


  }
  private createotherpartiesGroupNew() {

    return this._formBuilder.group({
      otherpartyname: null,
      relationship: null,
      teammeeting: null,
      relativeaddress: null,
      relativephno: null
    });
  }
  private createotherpartiesGroup(modal: any) {

    this.selectedotherparty = modal.otherpartyname;
    return this._formBuilder.group({

      otherpartyname: modal.otherpartyname ? modal.otherpartyname : '',
      relationship: modal.relationship ? modal.relationship : '',
      teammeeting: modal.teammeeting ? modal.teammeeting : '',
      transportneed: modal.transportneed ? modal.transportneed : '',
      relativeaddress: modal.relativeaddress ? modal.relativeaddress : '',
      relativephno: modal.relativephno ? modal.relativephno : ''
    
    });

  }
  deleteMedRow( index:any){
    const control = <FormArray>this.YouthMedicalForm.controls['medconditionarray'];
    control.removeAt(index);
  }
  deleteSiblingsRow(index:number){
    const control = <FormArray>this.OtherRelativeForm.controls['siblingsarray'];
    control.removeAt(index);
    this.siblingArraylist.splice(index,1);
  }

  deleteOthersRow(index:number){
    const control = <FormArray>this.OtherRelativeForm.controls['othersarray'];
    control.removeAt(index);
    this.siblingArraylist.splice(index,1);
  }
  
  deleteRelativeRow(event:any){
    const control = <FormArray>this.OtherRelativeForm.controls['otherrelativearray'];
      control.removeAt(event)
      
  }
  deleteInterestRow(event:any){
    const control = <FormArray>this.OtherRelativeForm.controls['otherinterestedparties'];
      control.removeAt(event)
      
  }
  selectotherparty(eventname: any, i: any) {
    
    const event = this.collateralList.find(item => item.fullname === eventname);
    (<FormArray>this.OtherRelativeForm.get('otherinterestedparties')).controls[i].patchValue({
      relationship: event.collateralroleconfig[0].description,
      relativeaddress: event.collateraladdress[0]?.address1 + " " + (event.collateraladdress[0]?.address2 ? event.collateraladdress[0]?.address2 :'') + " " + (event.collateraladdress[0]?.cityname ? event.collateraladdress[0]?.cityname : '') + " " + (event.collateraladdress[0]?.countytypekey ? event.collateraladdress[0]?.countytypekey :'') + " " + (event.collateraladdress[0]?.statetypekey ? event.collateraladdress[0]?.statetypekey :'') + " " + (event.collateraladdress[0]?.zip5no ? event.collateraladdress[0]?.zip5no :''),
      relativephno: event.mobile
    })
  }
  //section 5
  inityoutheducationform() {
    this.gradeDropdownItems$ = this._commonDDService.getPickListByName('gradelevel');
    this.YouthEducationForm = this._formBuilder.group({
      youtheducation: null,
      edulastattend: null,
      youthlastgrade: null,
      youthcurrschool: null,
      youthcurrgrade: null,
      youthiep: null,
      nextmeetingdate: null,
      parentsurrogate: null,
      schoolrecommendations: null,
      schoolreview: null,
      youthcurremployed: null,
      youthemployer: null,
      lastemployeddate: null,
      workreview: null,
      djsinvolved: null,
      ganginvolved: null,
      elecmonitoring: null,
      djscommited: null,
      upcomingdjs: null,
      upcominggang: null,
      upcomingelecmonitoring: null,
      upcomingdjscom: null,
      djscharges: null,
      gangcharges: null,
      elecmonitoringcharges: null,
      djscomcharges: null,
      djsstatusgcharges: null,
      gangstatuscharges: null,
      elecmonitstacharges: null,
      djscomstatuscharges: null,




    })

  }
  getEducationListInfo(event: any) {
    this._commonHttpService
      .getArrayList(
        {
          method: 'get',
          where: { personid: event.personid }
        },
        'personeducation/educationlist' + '?filter').subscribe(response => {
          this.allEducationList = response;
          if (this.allEducationList) {
            this.allEducationList = this.allEducationList.personEducation;
            this.allEducationList = _.orderBy(this.allEducationList, ['startdate'], ['desc']);
            
            if (this.allEducationList[0]?.highestgradetypekey) {
              this.gradeDropdownItems$.subscribe(data => {
                const highergrade = data.find(item => item.ref_key === this.allEducationList[0]?.highestgradetypekey)
                this.YouthEducationForm.patchValue({
                  youthlastgrade: highergrade.description
                });

              })
            }

            this.YouthEducationForm.patchValue(this.returnEducationDetailsFn())
          }
        });
  }
  // Assosiated with getEducationListInfo method
  private returnEducationDetailsFn() {
    return {
      youtheducation: this.allEducationList[0]?.enddate ? "2" : "1",
      edulastattend: this.allEducationList[0]?.enddate ? (moment(this.allEducationList[0]?.enddate).format(this.dtformat)) : '',
      youthcurrschool: this.allEducationList[0]?.enddate ? '' : this.allEducationList[0]?.educationname,
      youthcurrgrade: this.allEducationList[0]?.enddate ? '' : this.allEducationList[0]?.currentgrade,
      youthiep: this.allEducationList[0]?.isspecialeducation ? "1" : "2",
    };
  }

  getemploymentDetails(event:any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: event.personid }
        }),
        'People/getpersonwork?filter'
      ).subscribe((result) => {
        this.employementlist = result;
        if (this.employementlist.length) {
          this.employementlist = _.orderBy(this.employementlist, ['startdate'], ['desc']);
          this.YouthEducationForm.patchValue({
            youthcurremployed: this.employementlist[0]?.enddate ? "2" : "1",
            youthemployer: this.employementlist[0]?.enddate ? " " : this.employementlist[0]?.employername,
            lastemployeddate: this.employementlist[0]?.enddate ? moment(this.employementlist[0]?.enddate).format(this.dtformat) : "Current"
          })
        }
        else {
          this.YouthEducationForm.patchValue({ youthcurremployed: "2", youthemployer: "", lastemployeddate: ""});
        }
      });
  }
  getMostRecentDate(): string {
    const physicianDate = this.YouthMedicalForm.get('physicianlastseendt')?.value;
    const dentistDate = this.YouthMedicalForm.get('dentistlastseendt')?.value;
    const therapistDate = this.YouthMedicalForm.get('therapistlastseendt')?.value;

    const physicianDateObj = new Date(physicianDate);
    const dentistDateObj = new Date(dentistDate);
    const therapistDateObj = new Date(therapistDate);

    // Calculating the maximum date among the three
    const maxDate = new Date(Math.max(physicianDateObj.getTime(), dentistDateObj.getTime(), therapistDateObj.getTime()));

    return `${maxDate.getMonth() + 1}/${maxDate.getDate()}/${maxDate.getFullYear()}`;
}

  djschecked(event: any,chkboxname: any){
    // alert("clicked")
    if(chkboxname === "djsinvolved"){
      this.djsinvolvedeventcheck(event);
    
  }
  if(chkboxname === "ganginvolved"){
    this.ganginvolvedeventcheck(event);
    
  }
 
  if(chkboxname === "elecmonitoring"){
    this.elecmonitoringeventcheck(event);
    
  }
  if(chkboxname === "djscommited"){
    this.djscommitedeventcheck(event);
  }
  }

  djsinvolvedeventcheck(event: any){
    if(event.checked){
      this.djsinvolvedchkbox = true
    }
    else {
      this.djsinvolvedchkbox = false
      this.YouthEducationForm.patchValue({
        upcomingdjs:null,
        djscharges:null,
        djsstatusgcharges:null
      })
    }
  }

  ganginvolvedeventcheck(event: any){
    if(event.checked){
      this.ganginvolvedchkbox = true;
    }
    else {
      this.ganginvolvedchkbox = false;
      this.YouthEducationForm.patchValue({
        upcominggang:null,
        gangcharges:null,
        gangstatuscharges:null
      })
    }

  }

  elecmonitoringeventcheck(event: any){
    if(event.checked){
      this.elecmonitoringchkbox = true;
    }
    else {
      this.elecmonitoringchkbox = false;
      this.YouthEducationForm.patchValue({
        upcomingelecmonitoring:null,
        elecmonitoringcharges:null,
        elecmonitstacharges:null
      })
    }
  }

  djscommitedeventcheck(event: any){
    if(event.checked){
      this.djscommitedchkbox = true;
    }
    else {
      this.djscommitedchkbox = false;
      this.YouthEducationForm.patchValue({
        upcomingdjscom:null,
        djscomcharges:null,
        djscomstatuscharges:null
      })
      
    }
  }
  //section 5 end
  //section 6
  // Added physicianspeciality just for ref - delete if not needed
  inityouthmedicalform() {
    this.YouthMedicalForm = this._formBuilder.group({
      youthphysician: null,
      youthphysicianname: null,
      physicianlastseendt: null,
      physicianspeciality: null,
      youthdentist: null,
      youthdentistname: null,
      dentistlastseendt: null,
      physicianphno: null,
      youthprivateinsurance: null,
      youthpregnant: null,
      examinationList:null,
      specialequipment: null,
      describe: null,
      youthhospitalization: null,
      youththerapist: null,
      isyouththerapist: null,
      therapistlastseendt: null,
      youththerapistphno: null,
      therapistinsurance: null,
      youthtreatmntreason: null,
      youthprovdiagnosis: null,
      isyouthcooperative: null,
      youthnotcoperative: null,
      isyouthpsychological: null,
      isyouthintherapy: null,
      youththerapyoutcome: null,
      youththerapyoutcomedesc: null,
      isyouthhosphistory: null,
      medcurravailable: null,
      youthtakingmedicine: null,
     
    })
    this.YouthMedicalForm.setControl('medconditionarray', this._formBuilder.array([]));
  }
  loadmedicalinfo(event: any) {
    this.getproviderInfo(event);
    this.getInsuranceInfo(event);
    this.getHospitalizationInfo(event);
    this.getsexualInfo(event);
    this.getMedicationList(event);
  }
  getsexualInfo(event: any) {

    this._commonHttpService
      .getSingle(
        new PaginationRequest({
          method: 'get',
          where: { personid: event.personid }
        }),
        'personsexualinfo/list?filter'
      ).subscribe(res => {
        this.sexualinfoList = res ? res.personsexualinfo : [];
        this.YouthMedicalForm.patchValue({
          youthpregnant: this.sexualinfoList?.[0]?.ispregnant ? "1" : "2"
        })

      });

  }
  getHospitalizationInfo(event: any) {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: event.personid }
    }, 'personhospitalization/list?filter').subscribe(res => {
     const hospitalLists = res ? res.data : [];
      this.mentalpsychohospitalList = hospitalLists.filter(data => (data.hospitalization_typedesc === "Psychiatric"));
      this.hospitalList = hospitalLists.filter(data => (data.hospitalization_typedesc === "Medical"));

      if (this.hospitalList && this.hospitalList.length) {
        this.ishospitalised = true;

      }
      else {
        this.ishospitalised = false
      }
      this.YouthMedicalForm.patchValue({
        youthhospitalization: this.ishospitalised ? "1" : "2",
        isyouthhosphistory: this.mentalpsychohospitalList?.length ? "1" : "2"
      });

    });
  }
  getMedicationList(event: any) {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: event.personid }
    }, 'personmedicalcondition/personmedicallist?filter').subscribe(res => {
      this.medicationpsychotropic = res ? res.data : [];
      this.YouthMedicalForm.patchValue({
        isyouthpsychological : this.medicationpsychotropic.filter((e) => e.isprescribedmedication === true)?.length ? '1' : '2'
      })


    });
  }
  getInsuranceInfo(event: any) {
    this.privateInsurance = [];
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: event.personid }
    }, 'personhealthinsurance/list?filter').subscribe(res => {
      this.privateInsurance = res ? res.data : [];
      this.privateInsurance.push(...res.data);
      this.YouthMedicalForm.patchValue({
        youthprivateinsurance: this.privateInsurance[0]?.isinsuranceavailable ? "1" : "2",

      })
    });
  }

  getfrequencyvalue(value: any) {
    var text = this.frequencydropdown.filter(c=>c.ref_key == value);
    if(text && text.length) {
      return text[0].value_text;
    } else {
      return '';
    }
  }

  getproviderInfo(event: any) {
    this.physicianinfolist = [];

    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: event.personid }
    }, 'personphycisianinfo/getproviderinfo?filter').subscribe(res => {

      this.physicianinfolist.push(...res.data);

     if(this.physicianinfolist.length > 0) {
       this.physicianinfolistcheck();
     
    } else {
      this.YouthMedicalForm.patchValue({
        youthphysician : "2"
      })
      
    }
    });
    this.YouthMedicalForm.patchValue({
      // change metrostop-6 values here
      physicianlastseendt:new Date(),
      physicianspeciality:'physician speciality'

    })

  }

  physicianinfolistcheck(){
    if((this.prfadata.assessmentstatustypekey === undefined || this.prfadata.assessmentstatustypekey === 'InProcess' || this.prfadata.assessmentstatustypekey === 'Rejected')){
      let PCP: any;
     let DP:any;
     this.physicianinfolist.forEach((key)=>{
       if(key.is_primary_care_physician && key.physician_speciality!= "DP") {
         PCP= key;
       } 
         
     });
     this.physicianinfolist.forEach((key)=>{
      if(key.physician_speciality== "DP") {
        DP= key;
      }
    });
    this.handleYouthMedicalFormPatchDataFn(PCP, DP);
   }
  }
  // Assosiated with physicianinfolistcheck method
  private handleYouthMedicalFormPatchDataFn(PCP: any, DP: any) {
    this.YouthMedicalForm.patchValue({
      youthphysician: this.returnPrimaryCarePhysicianFn(PCP) ? "1" : "2",
      youthphysicianname: (PCP ? PCP.physician_name : this.physicianinfolist[0]?.physician_name),
      physicianphno: (PCP ? PCP.physician_phone : this.formatPhoneno(this.physicianinfolist[0]?.physician_phone))
    });
    this.YouthMedicalForm.patchValue({
      youthdentist: DP ? "1" : "2",
      youthdentistname: DP ? DP.physician_name : ""
    });
  }

  private returnPrimaryCarePhysicianFn(PCP: any) {
    return PCP ? PCP.is_primary_care_physician : this.physicianinfolist[0]?.is_primary_care_physician;
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.medicalconditiontype + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          medicalconditiontype: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.medicalconditiontypekey
              })
          )
        };
      }),
      share(),);
    this.medicalConditionType$ = source.pipe(pluck('medicalconditiontype'));
    this.stateDropdownItems$ = this._commonDDService.getPickListByName('state');
  }
  loadCounty(state: any) {
    this._commonDDService.getPickListByMdmcode(state).subscribe(countyList => {
      this.countyDropDownItems$ = observableOf(countyList);
    });
  }
  selectMedicalConditionType(event: any) {
    if (event) {
      const medicalConditionType = event.map((res: any) => {
        return { medicalconditiontypekey: res };
      });
      this.medicalCondtionType = medicalConditionType;
      this.medicalConditionType$.subscribe(items => {
        if (items) {
          const getConditiontems = items.filter(item => {
            if (event.includes(item.value)) {
              return item;
            }
          });
          this.medicalConditionDescription = getConditiontems.map(res => res.text);
        }
      });
    }
  }
  addmedicalcondition(modal: any) {
    if (modal) {
      const control = <FormArray>this.YouthMedicalForm.controls['medconditionarray'];
      control.push(this.createmedFormGroup(modal));
    }
    else {
      const control = <FormArray>this.YouthMedicalForm.controls['medconditionarray'];
      control.push(this.createmedFormGroupNew());
    }


  }


  private createmedFormGroupNew() {
    return this._formBuilder.group({
      medicalconditiontypekey: null,
      specialistname: null,
      specialistphno: null,
      currentmedications: null,
      doseorfreq: null,
      medcurrentavailability: null,
      youthtaking: null
    });
  }
  private createmedFormGroup(modal: any) {
    
    return this._formBuilder.group({

      medicalconditiontypekey: modal.medicalconditiontypekey ? modal.medicalconditiontypekey : '',
      specialistname: modal.specialistname ? modal.specialistname : '',
      specialistphno: modal.specialistphno ? this.formatPhoneno(modal.specialistphno) : '',
      currentmedications: modal.currentmedications ? modal.currentmedications : '',
      doseorfreq: modal.doseorfreq ? modal.doseorfreq : '',
      medcurrentavailability: modal.medcurrentavailability ? modal.medcurrentavailability : '',
      youthtaking: modal.youthtaking ? modal.youthtaking : '',
    });

  }
  //section 6 end
  //section 7
  initplacementserviceform(){
    this.YouthplacementserviceForm = this._formBuilder.group({
      youthhealthgoal1:null,
      youthhealthgoal2:null,
      youthhealthgoal3:null,
      youthhealthgoal4:null,
      youthhealthgoal5:null,
      plcmntrecommendation:null,
      plcmntdecision:null,
      youthservicegoal1:null,
      youthservicegoal2:null,
      decisionsupport:null,
      youthinterimplan:null,
      interimdecisionsupport:null,
      nosupportreason:null,
      resourceexploration:null,
      needforsupervision:null,
      reasonfornoservice:null,
      recommendorsupport:null,
      assessmentstatus:null,
      supervisorcomments:null,
      ldss:null,
      workersname:null,
      workersphone:null,
      workersemail:null,
      providersname:null,
      caseworkersigncheckboxvalue: [false],
      caseworkersigneddate:null,
      supervisorname:null,
      supervisorsphone:null,
      supervisorsemail:null,
      caseworkersignature:[null, Validators.required],
      supervisorsignature:null,
      reroutesupervisor:[null],
      caseworkercomments:null,
      assessmentapprovaldate:null,
      assessmentcompletiondate:null,
      ftdmcheckbox:null,
      ftdmdate:null,
      assessmentreviewed:null ,
      
    })
    const updateUploadEnabled = () => {
      const caseworkerCheckbox = this.YouthplacementserviceForm.get('caseworkersigncheckboxvalue')?.value;
      this.isuploadenabled = this.hasAttachment ? true : caseworkerCheckbox;
      
    };
    
    this.YouthplacementserviceForm.get('caseworkersigncheckboxvalue')?.valueChanges.subscribe(updateUploadEnabled);


    this.YouthplacementserviceForm.get('caseworkersigncheckboxvalue')?.valueChanges.subscribe(value => {
      if (value ) {  
        this.YouthplacementserviceForm.get('caseworkersignature')?.setValidators(null);
      } else {
        this.YouthplacementserviceForm.get('caseworkersignature')?.setValidators([Validators.required]);
      }
      this.YouthplacementserviceForm.get('caseworkersignature')?.updateValueAndValidity();
    });

}

initproviderserviceform(){
  this.YouthProviderForm = this._formBuilder.group({
    providersigncheckboxvalue: [false],
    providersignature:[null, Validators.required],
    selectedProvider: [this.selectedProviderObj, Validators.required],
    placementAddress: '',
    providerId:'',
    selectedCPAProvider: [this.selectedCPAProviderObj],
    cpaPlacementAddress: '',
    cpaProviderId:'',
    providerdate:['', Validators.required],
  })
  const updateUploadEnabledForProvider = () => {
    this.providerCheckbox = this.YouthProviderForm.get('providersigncheckboxvalue')?.value;
  };
  
  this.YouthProviderForm.get('providersigncheckboxvalue')?.valueChanges.subscribe(updateUploadEnabledForProvider);
  
  this.YouthProviderForm.get('providersigncheckboxvalue')?.valueChanges.subscribe(value => {
    if (value ) {  
      this.YouthProviderForm.get('providersignature')?.setValidators(null);
    } else {
      this.YouthProviderForm.get('providersignature')?.setValidators([Validators.required]);
    }
    this.YouthProviderForm.get('providersignature')?.updateValueAndValidity();
  });
  }
  onDropdownChange(selectedValue: any) {
    this.YouthProviderForm.patchValue({
      providerId: selectedValue.providerId,
      placementAddress: selectedValue.address,
      cpaProviderId: null,
      cpaPlacementAddress: null,
      selectedCPAProvider:null,
    })
    this.CPAProviderData = [];
    if(selectedValue.cpaStatus) {
      this.cpaDropdownStatus = true
      this.YouthProviderForm.get('selectedCPAProvider')?.setValidators([Validators.required]);
      this.CPAProviderData = this.targetProviderData.filter((e: { providerid: any; startdate: any; }) => e.providerid === selectedValue.providerId &&  e.startdate === selectedValue.startdate)[0].cpahomerevision.map((e: any) => ({
        name: `${e.providername} - Start Date: ${moment(e.entry_tm).format(this.dtformat)} - End Date: ${e.exit_tm ? moment(e.exit_tm).format(this.dtformat) : ''}`,
        address: e.provideraddress || ' ',
        providerId: e.provider_id || ' '
      }));
    
      this.CPAProviderData.sort((b, a) => moment(a.name.split('Start Date: ')[1], this.dtformat).diff(moment(b.name.split('Start Date: ')[1], this.dtformat)));
    } else {
      this.cpaDropdownStatus = false
     this.YouthProviderForm.get('selectedCPAProvider')?.clearValidators();
    }
    this.YouthProviderForm.get('selectedCPAProvider')?.updateValueAndValidity();
  }
  onCPADropdownSelection(selectedValue: any) {
    this.YouthProviderForm.patchValue({
      cpaProviderId: selectedValue.providerId,
      cpaPlacementAddress: selectedValue.address
    }) 
  }

  changeSupervisor(userid: any) {
    this.oldsupervisorname=this.prfadata?.submissiondata?.youthplacementservice?.supervisorname;
    const user = this.routingSupervisors.find(item => item.userid === userid);
    if (user.username) {
      this.YouthplacementserviceForm.patchValue({
        supervisorname: user.username,
        supervisorsemail :user.email
      });
      this.supervisorname = user.username;
    }
  }
  isReadyForApproval(){
    this.incompleteList =[];
    const isProviderCheckboxChecked = !!this.providerCheckbox;
    const areUploadedFilesEmpty = this.uploadedFiles.length === 0;
    this.isProviderUploadEnabled = isProviderCheckboxChecked && areUploadedFilesEmpty;
    this.handleAllPartsForApprovalFn();
    if (!this.canUploadProviderData && !this.YouthplacementserviceForm.valid) {
      this.markFormControlsAsTouched(this.YouthplacementserviceForm);
      this.incompleteList.push('Part 7');
    }
    if (this.canUploadProviderData && !this.YouthProviderForm.valid) {
      this.markFormControlsAsTouched(this.YouthProviderForm);
      this.incompleteList.push('Part 8');
    }
    if(this.isuploadenabled && (!this.uploadedFiles || this.uploadedFiles.length === 0)) {
      this.incompleteList.push('Please upload Placement Request form caseworker Signed document.');
    }
    if(this.isProviderUploadEnabled) {
      this.incompleteList.push('Please upload Placement Request form Provider Signed document.');
    }
    if (this.incompleteList.length === 0) {
      if (!this.canUploadProviderData) {
        this.submitForApproval();
      } else if (this.canUploadProviderData) {
        this.providerUpdateConfirm();
      }
    } else {
      (<any>$('#incomplete-items')).modal('show');
      return false;
    }
  }
  // Assosiated with isReadyForApproval method
  private handleAllPartsForApprovalFn() {
    if (!this.canUploadProviderData && !this.YouthInformationForm.valid) {
      this.markFormControlsAsTouched(this.YouthInformationForm);
      this.incompleteList.push('Part 1');
    }
    if (!this.canUploadProviderData && !this.placementreqform.valid) {
      this.markFormControlsAsTouched(this.placementreqform);
      this.incompleteList.push('Part 2');
    }
    if (!this.canUploadProviderData && !this.YouthFamilyForm.valid) {
      this.incompleteList.push('Part 3');
    }
    if (!this.canUploadProviderData && !this.OtherRelativeForm.valid) {
      this.incompleteList.push('Part 4');
    }
    if (!this.canUploadProviderData && !this.YouthEducationForm.valid) {
      this.incompleteList.push('Part 5');
    }
    if (!this.canUploadProviderData && !this.YouthMedicalForm.valid) {
      this.incompleteList.push('Part 6');
    }
  }

  getErrorsMessage(ControlName: any, displayName: any){
    if(this.placementreqform.controls[ControlName].status =='INVALID' ){
    return this.reusableErrMsgFn(displayName);
    }}

  getErrorsMessageforPartSeven(ControlName: any, displayName: any){
    if(this.YouthplacementserviceForm.controls[ControlName].status =='INVALID' ){
    return this.reusableErrMsgFn(displayName)
    }}
  getErrorsMessageforPartEight(ControlName: any, displayName: any){
      if(this.YouthProviderForm.controls[ControlName].status =='INVALID' ){
      return this.reusableErrMsgFn(displayName)
      }}
  getErrorsMessageforFileUpload(formGroup: any, ControlName: any, displayName: any) {
      const control = formGroup.controls[ControlName];
      if ((!this.uploadedFiles || this.uploadedFiles.length === 0) && control && control.value) {
        return 'Please upload ' + displayName;
      }
    }

    private reusableErrMsgFn(displayName: any) {
      return 'Please enter valid ' + displayName;
    }
  
  markFormControlsAsTouched(formGroup: FormGroup) {
    Object.values(formGroup.controls).forEach(control => {
        control.markAsTouched();
    });
  }
  submitForApproval(){
    const submissionData =this.getPRFAdata();
    if (this.isSupervisor) {
       this.assessmentStatus = this.YouthplacementserviceForm.get('assessmentstatus')?.value;
       submissionData.assessmentStaus = this.YouthplacementserviceForm.get('assessmentstatus')?.value;
     } else {
      this.assessmentStatus = 'Review';
      submissionData.assessmentStaus = 'Review';
     }
    if (!submissionData.placeholderIDforUploadedFiles) {
      submissionData.placeholderIDforUploadedFiles = this.placeholderIDforUploadedFiles;
    }
    if (!submissionData.isCompleted) {
      submissionData.isCompleted = this.isCompleted;
    }
    if (!submissionData.cpaDropdownStatus) {
      submissionData.cpaDropdownStatus = this.cpaDropdownStatus;
    }   
    submissionData.currentSubmissionId = this.currentSubmissionId;
    submissionData.routingsupervisors =  this.routingSupervisors;
    submissionData.comments = submissionData?.youthplacementservice?.caseworkercomments;
    submissionData.reroutesupervisor = submissionData?.youthplacementservice?.reroutesupervisor;
    submissionData.supervisorname = submissionData?.youthplacementservice?.supervisorname;

     this._dataStoreService.setData('PRINTDATA', submissionData);
     this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
       .subscribe((response) => {
          this.handleUpdateOperation(this.placeholderIDforUploadedFiles, this.user?.user?.securityusersid, response.data?.assessmentid);
          this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
          this.goBack();
         }, (_error: any) => {
           this._alertService.error('Unable to submit for approval.');
         }
       ); 
  }
  goBack() {
    setTimeout(() => {
      this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
    }, 1000);
  }

  //section 7 end
  formatdob(dob: any){
    if(dob) {
    return moment(dob,).format('MM-DD-YYYY');
    }
    else {
      return '';
    }

  }
  
  getDataUsingControlsNameFn(name: string): any[] {
    return Object.values((this.OtherRelativeForm.get(name) as FormGroup).controls);
  }
}
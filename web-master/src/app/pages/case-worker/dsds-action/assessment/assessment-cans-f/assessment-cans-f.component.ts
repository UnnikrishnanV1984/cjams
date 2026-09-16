import { FormGroup, FormBuilder, FormArray, Validators, ReactiveFormsModule, FormsModule } from '@angular/forms';
import { Component, OnInit, Injector, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { RoutingInfo } from '../../../_entities/caseworker.data.model';
import { CommonHttpService, DataStoreService, SessionStorageService, AuthService, AlertService, CommonDropdownsService } from '../../../../../@core/services';
import { DomSanitizer } from '@angular/platform-browser';
import { AssessmentService } from '../assessment.service';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';

import _ from 'lodash';
import moment from 'moment';
import { OWL_DATE_TIME_FORMATS, OwlDateTimeComponent, OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { ApprovalHistoryModule } from '../../../../../shared/shared-components/approval-history/approval-history.module';
import { MatRadioModule } from '@angular/material/radio';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { CommonModule } from '@angular/common';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { provideNgxMask } from 'ngx-mask';
import { MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';
import { AssessmentContactPurposeComponent } from '../assessment-contact-purpose/assessment-contact-purpose.component';
import { MatSortModule } from '@angular/material/sort';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { ViewAssessmentCansFSummaryComponent } from '../view-assessment-cans-f-summary/view-assessment-cans-f-summary.component';

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
    selector: 'assessment-cans-f',
    templateUrl: './assessment-cans-f.component.html',
    styleUrls: ['./assessment-cans-f.component.scss'],
    imports:[MatSortModule,ApprovalHistoryModule,MatRadioModule,MatCheckboxModule,MatFormFieldModule,MatInputModule,MatSelectModule,MatDatepickerModule,CommonModule,ReactiveFormsModule,OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule,FormsModule,AssessmentContactPurposeComponent,SignatureFieldModule
      ,ViewAssessmentCansFSummaryComponent
    ],
    providers:[provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
    standalone: true
})
export class AssessmentCansFComponent implements OnInit {
  @ViewChild('picker11') picker11!: OwlDateTimeComponent<any>;
  ASSESSMENT_NAME = 'cans-v2';
  submissiondata: any;
  familyYouth!: FormGroup;
  familyAssessmentYouth!: FormGroup;
  familyCultureYouth!: FormGroup;
  childFormFamilyQuestion!: FormGroup;
  involvedPerson: any[] = [];
  legalGuardian: any[] = [];
  allEducationList: any;
  isServiceCase: any;
  currentUser!: AppUser;
  agency!: string;
  currentdate!: Date;
  isCW!: boolean;
  headofhouseholdid!: string;
  id: any;
  daNumber: any;
  isValue: number = 1;
  currentAssessmentId: any;
  currentSubmissionId!: string;
  isMigrated = false;
  timeForCompletion: any[] = [
    {
      text: 'Initial',
      value: 'Initial'
    },
    {
      text: '45 days',
      value: '45 days'
    },
    {
      text: '3 months',
      value: '3 months'
    },
    {
      text: '6 months',
      value: '6 months'
    },
    {
      text: 'Change in Family Circumstances',
      value: 'Change in Family Circumstances'
    },
    {
      text: 'End of Service Case',
      value: 'End of Service Case'
    },
  ];
  serviceNameList: any[] = [];
  caregiverForm!: FormGroup;
  ShowCareGiverForm = false;
  cansFData: any;
  updateCansF!: boolean;
  viewCansF!: boolean;
  otherbox!: boolean;
  ritual_strength_id!: boolean;
  sexual_comments_id!: boolean;
  cultural_comments_id!: boolean;
  language_comments_id!: boolean;
  relation_strength_id!: boolean;
  extended_strength_id!: boolean;
  family_strength_id!: boolean;
  financial_resources_strength_id!: boolean;
  residential_stability_strength_id!: boolean;
  fcommunication_strength_id!: boolean;
  fappropriateness_strength_id!: boolean;
  safety_strength_id!: boolean;
  social_strength_id!: boolean;
  Provider!: boolean;
  cProvider!: boolean;
  familyOther!: boolean;
  totalamt!: number;
  enableChildDeceased: boolean = false;
  childDeceased: boolean = false;
  isChildLocatedByDept: boolean = false;
  navigateToApproval: boolean = false;
  deceasedChildName: any;
  dodOfDeceasedChild: any;
  contactNotes: any;
  childListFilter: any[] = [];
  dateofcasehead: any;
  caregiverFormList: any[] = [];
  caregiverMode: any;
  caregiverindex!: number | undefined;
  showCareGiver!: boolean;
  caregiverlegalGuardian: any[] = [];
  caregiverDdList: any[] = [];
  caregiverlegalGuardianName: any[] = [];
  parental_description_id!: boolean;
  childForm!: FormGroup;
  childFormList: any[] = [];
  childMode: any;
  childindex!: number;
  showChild!: boolean;
  childList: any[] = [];
  childListName: any[] = [];
  childListOriginal: any[] = [];
  notChildList: any[] = [];
  childListArrayList: any[] = [];
  caregiversInCase: any[] = [];
  routingSupervisors: any[] = [];
  routingInfo!: RoutingInfo[];
  authorizationApproval!: FormGroup;
  isSupervisor!: boolean;
  assessmentStatus: any;

  incompleteList: any[] = [];
  caseworkersignature: any;
  supervisorsignature: any;
  headofHouseHold: any;
  notChildListOriginal: any[] = [];
  caregiverNotRequiredForm!: FormGroup;
  listCollateralPerson: any[] = [];
  listCollateralPersonFormList: any[] = [];
  caregiverNotRequiredDtl: any;
  disableSubmit: boolean = false;
  requiredForApproval: boolean = false;
  validationmsg = 'Please Enter value ';
  dtformat = 'MM/DD/YYYY';
  summaryData: any = {};
  dtformat1 = 'YYYY-MM-DDTHH:mm';
  currentdatetime = moment();
  iscaseexpunged: any = 0;
  private route: ActivatedRoute;
  private _commonService: CommonHttpService;
  public sanitizer: DomSanitizer;
  private _dataStoreService: DataStoreService;
  private _router: Router;
  private storage: SessionStorageService;
  private _authService: AuthService;
  private _alertService: AlertService;
  private _commonDDService: CommonDropdownsService;
  private _assessmentService: AssessmentService;
  private _formBuilder: FormBuilder;

  constructor(private injector : Injector){
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.sanitizer = this.injector.get<DomSanitizer>(DomSanitizer);
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
  }

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.currentUser = this._authService.getCurrentUser();
    this.agency = this._authService.getAgencyName();
    this.isSupervisor = (this.currentUser.role.name === 'apcs') ? true : false;
    this.isCW = false;
    if (this.agency === 'CW') {
      this.isCW = true;
    }
    this.totalamt = 0;
    this.Provider = false;
    this.cProvider = false;
    this.otherbox = false;
    this.family_strength_id = false;
    this.getcollateral();
    this.familyYouthForm();
    this.comprehensiveFamilyAssessmentForm();
    this.initializeCaregiverForm();
    this.initializeChildForm();
    this.CultureAssessmentForm();
    this.authorizationApprovalForm();
    this.getCaregiversInCase();
    this.childFormFamilyQuestionInit();
    this.relation_strength_id = false;
    this.parental_description_id = false;
    this.extended_strength_id = false;
    this.fcommunication_strength_id = false;
    this.safety_strength_id = false;
    this.social_strength_id = false;
    this.ritual_strength_id = false;
    this.sexual_comments_id = false;
    this.cultural_comments_id = false;
    this.language_comments_id = false;
    this.financial_resources_strength_id = false;
    this.residential_stability_strength_id = false;
    const list = this._dataStoreService.getData('CASEWORKER_SERVICE_PLAN_LIST');
    this.cansFData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.setCanFData();
    
    this.contactNotes = this._dataStoreService.getData('contact_action_info') ? this._dataStoreService.getData('contact_action_info').replace(/<\/?[^>]+(>|$)/g, "") : null;
    this.currentAssessmentId = this.cansFData.assessmentid;
    this.currentSubmissionId = this.cansFData.submissionid;
    if(this.cansFData.ismigration === 1) {
       this.isMigrated = true;
    }

    if(this.childDeceased) {
      this.isValue = 6
    } else if(this.isChildLocatedByDept) {
      this.isValue = 7
    }

    this.serviceNameList = (Array.isArray(list)) ? list.map(item => item.serviceplanname) : [];

    this._assessmentService.getservicecase();
    this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') ? this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') : [];
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.prefillAuthorizationApprovalInfo();

   this.getInvolvedPerson();
   

    if (this.authorizationApproval.get('caseworkersign')?.value) {
      this.caseworkersignature = this.authorizationApproval.get('caseworkersign')?.value;
    }
    if (this.authorizationApproval.get('supervisorsign')?.value) {
      this.supervisorsignature = this.authorizationApproval.get('supervisorsign')?.value;
    }
  }  
  

  setCanFData(){
    this.childDeceased = this.cansFData.submissiondata && this.cansFData.submissiondata.childDeceased ? this.cansFData.submissiondata.childDeceased : false;
    this.isChildLocatedByDept = this.cansFData.submissiondata && this.cansFData.submissiondata.childLocatedByDept ? this.cansFData.submissiondata.childLocatedByDept : false;

    if(this.cansFData.submissiondata && this.cansFData.submissiondata.caregivernotapplicable && this.cansFData.submissiondata.caregivernotapplicable === true) {
      this.caregiverNotRequiredForm.patchValue({
        caregivernotapplicable: this.cansFData.submissiondata.caregivernotapplicable,
        caregiverreason: this.cansFData.submissiondata.caregiverreason,
      })
    }
  }

  getValidationMessage(controlName: any, displayname: any){
 
    if(this.familyYouth.controls[controlName].status == 'INVALID')
    {
        return this.validationmsg+displayname;
    }
  }

  isFamilyYouthControlInvalid(controlName: any){
 
    return (this.familyYouth.touched && this.familyYouth.controls[controlName].status == 'INVALID');
  }

  getValidationMessage1(controlName: any, displayname: any){
 
    if(this.caregiverForm.controls[controlName].status == 'INVALID')
    {
        return this.validationmsg+displayname;
    }
  }
  getValidationMessage2(controlName: any, displayname: any){
 
    if(this.childForm.controls[controlName].status == 'INVALID')
    {
        return this.validationmsg+displayname;
    }
  }
  getValidationMessage3(controlName: any, displayname: any){
 
    if(this.authorizationApproval.controls[controlName].status == 'INVALID')
    {
        return this.validationmsg+displayname;
    }
  }
  
  addNamesToSubmissionData() { 
    const sub = this._dataStoreService.getData('PRINTDATA');

    this.addCareGiverList(sub);
    this.addChildList(sub);

  }

  addCareGiverList(sub: any){
    const carelist: any[] = [];
    if(sub && sub.careGiver && sub.careGiver.length> 0 ){
      const cg = sub.careGiver;
      cg.forEach((care: any) => {
        if(care.caregiverlist){
          this.caregiverDdList.forEach(data => {
            if(data.intakeservicerequestactorid == care.caregiverlist){
              care['careGiverName'] = data.fullname;
            }
          });
        }
        carelist.push(care);
      });
      if(this.submissiondata){
        this.submissiondata.careGiver = carelist;
      }
    }
  }

  addChildList(sub: any){
    const childlistwithnames: any[] = [];
    if(sub && sub.child && sub.child.length> 0 ){
      const cl = sub.child;
      cl.forEach((kid: any) => {
        if(kid.childlist){
          this.childListOriginal.forEach(data => {
            if(data.intakeservicerequestactorid == kid.childlist){
              kid['kidName'] = data.fullname;
            }
          });
        }
        childlistwithnames.push(kid);
      });
      if(this.submissiondata){
        this.submissiondata.child = childlistwithnames;
      }
      
    }
  }

  loadCaregiverList() {
    this.isValue = 3;
    this.initializeCaregiverForm();
    
    if(this.caregiverNotRequiredDtl) {
      this.caregiverNotRequiredForm.patchValue(this.caregiverNotRequiredDtl);
    } else if(this.cansFData.submissiondata && this.cansFData.submissiondata.caregivernotapplicable && this.cansFData.submissiondata.caregivernotapplicable === true) {
      this.caregiverNotRequiredForm.patchValue({
        caregivernotapplicable: this.cansFData.submissiondata.caregivernotapplicable,
        caregiverreason: this.cansFData.submissiondata.caregiverreason,
      })
    }
    this.caregiverlegalGuardian = this.caregiverDdList;
    if (this.caregiverlegalGuardian && this.caregiverlegalGuardian.length > 0) {
      this.caregiverlegalGuardian.forEach(data => {
        this.caregiverlegalGuardianName[data.intakeservicerequestactorid] = data.fullname;
      });
    }
    this.removeAddedlegals();
    this.showCareGiver = false;

  }

  caregiverRequired(value: any, formcontrolname: any) {
    if (value !== 0) {
      this.caregiverForm.get(formcontrolname)?.setValidators(Validators.required);
      this.caregiverForm.get(formcontrolname)?.updateValueAndValidity();
    } else {
      this.caregiverForm.get(formcontrolname)?.clearValidators();
      this.caregiverForm.get(formcontrolname)?.updateValueAndValidity();
    }
  }

  prefillAuthorizationApprovalInfo() {
    this.authorizationApproval.patchValue({
      supervisorname: this._dataStoreService.getData('da_assignedby'),
      workername: this.currentUser.user.userprofile.fullname 
    })
  }

  getSubmisionData() {
    const url = `admin/assessment/getassessmentform/${this.cansFData.external_templateid}/submission/${this.cansFData.submissionid}`;
    this._commonService.getSingle({}, url).subscribe(result => {
      this.submissiondata = result;
      this.getCansfData();
    });
  }

  getCansfData() {
    if (this.cansFData && this.cansFData.submissiondata ) {
      this.submissiondata = this.cansFData.submissiondata;
    }
    this._dataStoreService.setData('PRINTDATA', this.submissiondata);

    if (this.cansFData && (this.cansFData.mode === 'update' || this.cansFData.mode === 'submit')) {
      this.updateCansF = true;
      this.viewCansF = false;
      this.setFamilyYouth();
      this.setCaregiverFormList();
      this.setChildFormList();
      this.setFamilyAssessmentYouth();
      this.setFamilyCultureYouth();
      this.setChildFormFamilyQuestion();
      this.setApprovalData();
    } else {
      this.updateCansF = false;
      this.viewCansF = false;
    }
    this.disableCheck();
  }

  setFamilyYouth(){
    if (this.submissiondata.familyYouth) {
      const fydata = this.submissiondata.familyYouth;
      this.dateofcasehead = fydata.caseheaddatetime ? fydata.caseheaddatetime : null;
      this.familyYouth.patchValue({
        caseheaddatetime: fydata?.caseheaddatetime ? new Date(fydata?.caseheaddatetime):fydata?.caseheaddatetime,
        timeCompletion: fydata.timeCompletion,
        houseHoldId: fydata.houseHoldId,
        houseHoldHead: fydata.houseHoldHead,
        houseHoldName: fydata.houseHoldName,
        servicename: fydata.servicename,
        caregivername: fydata.caregivername,
        caregiverdob: fydata.caregiverdob,
        caregiverage: fydata.caregiverage,
        caregiverrelationship: fydata.caregiverrelationship,
        childName: fydata.childName,
        childDob: fydata.childDob,
        childAge: fydata.childAge,
        childRelationship: fydata.childRelationship,
        childSchool: fydata.childSchool,
        childdescription: fydata.childdescription,
        caregiverdescription: fydata.caregiverdescription,
        referralsource: fydata.referralsource
      });
      this.setFamilyYouthServiceArray();
      this.setFamilyYouthChildArray();
      this.setFamilyYouthCareGiverArray();
    }
  }

  setFamilyYouthServiceArray(){
    if (this.submissiondata && this.submissiondata.familyYouth_serviceArray) {
      this.submissiondata.familyYouth_serviceArray.forEach((element: any) => {
        this.addService(element);
      });
    }
  }

  setFamilyYouthChildArray(){
    if (this.submissiondata && this.submissiondata.familyYouth_childArray) {
      this.submissiondata.familyYouth_childArray.forEach((element: { childName: any; }, index: any) => {
        this.childListArrayList[index] = this.childListOriginal;
        let validChild = false;
        this.childListOriginal.forEach((childLisOrg) => {
            if(childLisOrg.intakeservicerequestactorid === element.childName){
              validChild = true;
            }
         });

         if(validChild){
          this.addChild(element);
         }
      });
    }
  }

  setFamilyYouthCareGiverArray(){
    if (this.submissiondata && this.submissiondata.familyYouth_caregiverArray) {
      this.submissiondata.familyYouth_caregiverArray.forEach((element: any, index: any) => {
        this.notChildList[index] = this.notChildListOriginal;
        this.addLegalGuardian(element);
      });
    }
  }

  setApprovalData(){
    if (this.submissiondata && this.submissiondata.authorizationApproval) {
      const approvaldata = this.submissiondata.authorizationApproval;
      this.authorizationApproval.patchValue({
        routingsupervisors: approvaldata.routingsupervisors,
        supervisorname: approvaldata.supervisorname,
        workername: approvaldata.workername,
        caseworkersign: approvaldata.caseworkersign,
        caseworkersigndate: approvaldata.caseworkersigndate,
        caseworkercomments: approvaldata.caseworkercomments,
        supervisorsign: approvaldata.supervisorsign,
        supervisorsigndate: approvaldata.supervisorsigndate,
        supervisorcomments: approvaldata.supervisorcomments,
        assessmentstatus: approvaldata.assessmentstatus,
        assessmentsubmission : approvaldata.assessmentsubmission
      });
    }
  }

  setCaregiverFormList(){
    if (this.submissiondata && this.submissiondata.careGiver) {
      this.caregiverFormList = this.submissiondata.careGiver;
    }
  }
  setChildFormList(){
    if (this.submissiondata && this.submissiondata.child) {
      this.childFormList = this.submissiondata.child;
    }
  }
  setFamilyAssessmentYouth(){
    if (this.submissiondata && this.submissiondata.familyAssessmentYouth) {
      this.familyAssessmentYouth.patchValue(this.submissiondata.familyAssessmentYouth);
    }
  }
  setFamilyCultureYouth(){
    if (this.submissiondata && this.submissiondata.familyCultureYouth) {
      this.familyCultureYouth.patchValue(this.submissiondata.familyCultureYouth);
    }
  }
  setChildFormFamilyQuestion(){
    if(this.submissiondata && this.submissiondata.childFormFamilyQuestion){
      this.childFormFamilyQuestion.patchValue(this.submissiondata.childFormFamilyQuestion);
    }
  }

  disableCheck(){
    if (this.cansFData && this.cansFData.mode === 'submit') {
      this.updateCansF = true;
      this.viewCansF = true;
      this.familyYouth.disable();
      this.familyAssessmentYouth.disable();
      this.childFormFamilyQuestion.disable();
      this.familyCultureYouth.disable();
      this.authorizationApproval.disable();
    }
  }

  familyYouthForm() {
    this.familyYouth = this._formBuilder.group({
      caseheaddatetime: [null],
      timeCompletion: [null, [Validators.required]],
      houseHoldId: [{value: null, disabled: true}],
      houseHoldHead: [null],
      houseHoldName: [{value: null, disabled: true}],
      servicename: [null],
      caregivername: [null],
      caregiverdob: [null],
      caregiverage: [null],
      caregiverrelationship: [null],
      childName: [null],
      childDob: [null],
      childAge: [null],
      childRelationship: [null],
      childSchool: [null],
      childdescription: [null],
      caregiverdescription: [null],
      referralsource: [null]
    });
    this.familyYouth.setControl('caregiverArray', this._formBuilder.array([]));
    this.familyYouth.setControl('childArray', this._formBuilder.array([]));
    this.familyYouth.setControl('serviceArray', this._formBuilder.array([]));
    this.familyYouth.patchValue({
      caseheaddatetime: new Date(moment(new Date()).format(this.dtformat1)),
      houseHoldId: this.daNumber
    });
  }

  authorizationApprovalForm() {
    this.authorizationApproval = this._formBuilder.group({
      routingsupervisors: [null],
      supervisorname: [{value: '', disabled: true}],
      workername: [{value: '', disabled: true}],
      caseworkersign: [''],
      caseworkersigndate: [null],
      caseworkercomments: [''],
      supervisorsign: [''],
      supervisorsigndate: [null],
      supervisorcomments: [''],
      assessmentstatus: [''],
      assessmentsubmission: [{value: null, disabled: true}]
    });
  }

  changeSupervisor(userid: any) {
    const user = this.routingSupervisors.find(item => item.userid === userid);
    if (user.username) {
      this.authorizationApproval.patchValue({
        supervisorname: user.username
      });
    }
  }

  childFormFamilyQuestionInit(){
    this.childFormFamilyQuestion = this._formBuilder.group({
      recommendations: [null],
      recommendationstext:['']
    });
  }
  comprehensiveFamilyAssessmentForm() {
    this.familyAssessmentYouth = this._formBuilder.group({
      parental_strength: [''],
      parental_scale: ['0'],
      parental_description: [''],
      relation_strength: [''],
      relation_scale: ['0'],
      relation_description: [''],
      extended_strength: [''],
      extended_scale: ['0'],
      extended_description: [''],
      family_strength: [''],
      family_scale: ['0'],
      family_description: [''],
      fcommunication_strength: [''],
      fcommunication_scale: ['0'],
      fcommunication_description: [''],
      fappropriateness_strength: [''],
      fappropriateness_scale: ['0'],
      fappropriateness_description: [''],
      safety_strength: [''],
      safety_scale: ['0'],
      safety_description: [''],
      social_strength: [''],
      social_scale: ['0'],
      social_description: [''],
      emp_income_amt: [''],
      child_support_amt: [''],
      t_cash_assistance_amt: [''],
      food_stamp_amt: [''],
      social_security_benefits: [''],
      unemployment_amt: [''],
      other_amt: [''],
      unknown_amt: [''],
      monthly_total: [''],
      caregiver_insurance: [''],
      caregiver_insurance_provider: [''],
      children_insurance: [''],
      children_insurance_provider: [''],
      family_needs_assistance: [''],
      family_needs_assistance_txt: [''],
      financial_resources_strength: [''],
      financial_resources_scale: ['0'],
      financial_resources_description: [''],
      residential_stability_strength: [''],
      residential_stability_scale: ['0'],
      residential_stability_description: [''],
      family_own_rent: [''],
      family_other: [''],
      family_transport: [''],
      neighborhood: [''],
      familyFunctioning: ['']
    });
  }
  CultureAssessmentForm() {
    this.familyCultureYouth = this._formBuilder.group({
      language_strength: [''],
      language_scale: ['0'],
      language_comments: [''],
      cultural_strength: [''],
      cultural_scale: ['0'],
      cultural_comments: [''],
      sexual_identity_strength: [''],
      sexual_scale: ['0'],
      sexual_comments: [''],
      ritual_strength: [''],
      ritual_scale: ['0'],
      ritual_comments: [''],
      additional_acculturation_info: ['']
    });
  }

  caregivername(value: any, i: any) {
    this.checkifcaregiver(value);
    const modal = this.notChildListOriginal.find(data => data.intakeservicerequestactorid === value);
    const relationshipDesc = this._assessmentService.getRelationShip(this.headofhouseholdid,modal.personid, modal.relationshiparray);
   
    (<FormArray>this.familyYouth.get('caregiverArray')).controls[i].patchValue({
      caregiverdob: modal.dob ? new Date(modal.dob) : '',
      caregiverage: modal.age ? modal.age : '',
      caregiverrelationship: relationshipDesc ? relationshipDesc : ''
    });
    const control = this.familyYouth.controls['caregiverArray'].value;
    if (control && control.length > 0) {
      control.forEach((index: any) => {
        if (index !== i) {
          this.notChildList[index] = this.notChildList[index].filter((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid !== value);
        }
      });
    }
  }

  getEducationListInfo(personid: any, i: any) {
    this._commonService
      .getArrayList(
          {
            method: 'get',
            where: { personid: personid }
          },
        'personeducation/educationlist' + '?filter').subscribe( response => {
            this.allEducationList = response;
            let currentGrade = '';
            if(this.allEducationList){
              this.allEducationList =  this.allEducationList.personEducation;
              this.allEducationList = _.orderBy(this.allEducationList, ['startdate'], ['desc']);
              if(this.allEducationList.length && this.allEducationList[0] && this.allEducationList[0].currentgrade){
              currentGrade = this.allEducationList[0].currentgrade;
            }
              (<FormArray>this.familyYouth.get('childArray')).controls[i].patchValue({
                childSchool: currentGrade ? currentGrade : ''
              })
            }
        });
  } 
  childname(value: any, i: any) {
    const modal = this.childListOriginal.find(data => data.intakeservicerequestactorid === value);
    const relationshipDesc = this._assessmentService.getRelationShip(this.headofhouseholdid,modal.personid, modal.relationshiparray);
    this.getEducationListInfo(modal.personid, i);
    (<FormArray>this.familyYouth.get('childArray')).controls[i].patchValue({
      childDob: modal.dob ? new Date(modal.dob) : '',
      childAge: modal.age ? modal.age : '',
      childRelationship: relationshipDesc ? relationshipDesc : ''
    });
    const control = this.familyYouth.controls['childArray'].value;
    if (control && control.length > 0) {
      control.forEach((index: any) => {
        if (index !== i) {
          this.childListArrayList[index] = this.childListArrayList[index].filter((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid !== value);
        }
      });
    }
  }

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

  checkifcaregiver(value: any) {
    this.assignCargiverName(value, 'person')
    let cgflag = false;

    const modal = this.involvedPerson.find(data => data.intakeservicerequestactorid === value);

    if(this.caregiversInCase && this.caregiversInCase.length) {
      this.caregiversInCase.forEach(element => {
          if(element.personid == modal.personid) {
            cgflag = true;
          }
      });

      if (cgflag === false) {
        (<any>$('#not-caregiver-alert')).modal('show');
      }
    }
  }

  assignCargiverName(modal: any, type: any) {
    let caregiveinfo;
    if(type === 'person' && this.caregiverlegalGuardian) { 
      caregiveinfo = this.caregiverlegalGuardian.find(item=> item.intakeservicerequestactorid === modal);
    } else if(type === 'collateral') {
      caregiveinfo = this.listCollateralPerson.find(item=> item.collateralid === modal);
    }

    if(caregiveinfo) {
      this.caregiverForm.patchValue({
        ccacaregivername : caregiveinfo.fullname
      });
    }
  }
  assignChildName(modal: any) {
    const childinfo = this.childList.find(item=> item.intakeservicerequestactorid === modal);
    if(childinfo) {
      this.childForm.patchValue({
        childname : childinfo.fullname
      });
    }
  }

  getInvolvedPerson() {
    this.legalGuardian = [];
    this.caregiverDdList = [];
    let getpersonlistreq = {};
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    } else {
      getpersonlistreq = { intakeserviceid: this.id };
    }
    this.getPersonDetails(getpersonlistreq);
   
    if(this.caregiverDdList){
    this.caregiverlegalGuardian = this.caregiverDdList;}
  }

  getPersonDetails(getpersonlistreq: any) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();

    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    getpersonlistreq['isExpungementSuperUser'] = isExpungementSuperUser;
    getpersonlistreq['iscaseexpunged'] = this.iscaseexpunged;
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 20,
        personpagelimit: 100,
        method: 'get',
        where: getpersonlistreq
      }),
      url + '?filter'
    ).subscribe(response => {
      if (response && response.data && response.data.length) {
        this.involvedPerson = response.data;
        this.checkinvolvedPersonroles();
        this.checkChildListFilter();
        this.checkInvolvedPerson();
        this.setChildListArrayList();
        this.setNotChildList();
        this.checkCansFDataMode();
      }
      if (!(this.headofHouseHold && this.headofHouseHold.intakeservicerequestactorid)) {
        setTimeout(() => {
          this.checksettimeoutpatchvalue();
        }, 2000);
      }
    });
  }
  checkinvolvedPersonroles(){
    this.involvedPerson.forEach(ele => {
      if (ele.roles) {
        const childData = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD' || roleid.intakeservicerequestpersontypekey === 'AV');
        if (childData && childData.length) {
          this.childListFilter.push(ele);
        }
      }
    });
  }

  checkChildListFilter(){
    if(this.childListFilter.length == 1) {
      this.enableChildDeceased = true;
      this.deceasedChildName = this.childListFilter[0].fullname ? this.childListFilter[0].fullname : null ;
      this.dodOfDeceasedChild = this.childListFilter[0].dateofdeath ?  moment(this.childListFilter[0].dateofdeath).format(this.dtformat) : null;
    }
  }

  checkInvolvedPerson(){
    let headofHouseHold: any = null;
    this.involvedPerson.forEach(item => {
      if (item.isheadofhousehold) {
        this.headofhouseholdid = item.personid;
        headofHouseHold = item;
      }
      if (item.roles !== null) {
        const legalGurdian = item.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'LG');
        const child = item.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => (roleid.intakeservicerequestpersontypekey === 'CHILD' ||
          roleid.intakeservicerequestpersontypekey === 'OTHERCHILD'));
        this.setchildListOriginal(child, item);
        this.setNotChildListOriginal(child, item);
        this.checkLegalGuardian(legalGurdian, item);
        if (item.roles) {
          const cg = item.roles.filter((el: { intakeservicerequestpersontypekey: string; }) =>
          (el.intakeservicerequestpersontypekey != 'CHILD'
            && el.intakeservicerequestpersontypekey != 'OTHERCHILD'
            && el.intakeservicerequestpersontypekey != 'AV'));

          if (cg && cg.length) {
            this.caregiverDdList.push(item);
          }

        }
        this.setHouseHoldHead(headofHouseHold);
      }
      this.addNamesToSubmissionData();
    });
  }
        

  setHouseHoldHead(headofHouseHold: any){
    if (headofHouseHold && headofHouseHold.intakeservicerequestactorid) {
      this.headofHouseHold = headofHouseHold;
      this.familyYouth.patchValue({
        houseHoldHead: headofHouseHold.intakeservicerequestactorid,
        houseHoldName: headofHouseHold.firstname + ' ' + headofHouseHold.lastname
      });
    }
  }
            

  checkLegalGuardian(legalGurdian: any, item: any) {
    if (legalGurdian && legalGurdian.length) {
      if (item.roles.length && item.roles[0].allroles) {
        const allRoles = item.roles[0].allroles;
        const items: any[] = [];
        allRoles.forEach((ele: { intakeservicerequestactorid: any; }) => {
          if (!items.find(item1 => item1.intakeservicerequestactorid === ele.intakeservicerequestactorid)) {
            items.push({
              intakeservicerequestactorid: ele.intakeservicerequestactorid,
              fullname: item.fullname
            });
          }
        })
        this.notChildListOriginal.push(...items);
      }
      this.legalGuardian.push(item);
    }
  }

  setchildListOriginal(child: any, item: any){
    if (child && child.length) {
      if(item.roles.length && item.roles[0].allroles){
        const allRoles = item.roles[0].allroles;
        const items: any[] = [];
        allRoles.forEach((ele: { intakeservicerequestactorid: any; }) =>{
          if(!items.find(item1 =>item1.intakeservicerequestactorid === ele.intakeservicerequestactorid)){
          items.push({
            intakeservicerequestactorid: ele.intakeservicerequestactorid, 
            personid: item.personid,
            fullname: item.fullname,
            dob: item.dob,
            age: item.age,
            relationshiparray: item.relationshiparray,
            cjamspid: item.cjamspid
          });
        }
        })
        if(items) {
          this.childListOriginal.push(...items);
        }
      }
      this.childListOriginal.push(item);
    }
  }

  setNotChildListOriginal(child: any, item: any) {
    if (!child || child.length === 0) {
      if (item.roles.length && item.roles[0].allroles) {
        const allRoles = item.roles[0].allroles;
        const items: any[] = [];
        allRoles.forEach((ele: { intakeservicerequestactorid: any; }) => {
          if (items.find(item1 => item1.intakeservicerequestactorid === ele.intakeservicerequestactorid)) {
            items.push({
              intakeservicerequestactorid: ele.intakeservicerequestactorid,
              fullname: item.fullname
            });
          }
        })
        this.notChildListOriginal.push(...items);
      }
      this.notChildListOriginal.push(item);
    }
  } 
  
  setChildListArrayList(){
    const controlChild = this.familyYouth.get('childArray') as FormArray;
    for (let i = 0; i < controlChild.length; i++) {
      let newList: any[] = [];
      let copyOfChildListOriginal = this.childListOriginal;
      newList.push(this.childListOriginal.find(item => (
        item.intakeservicerequestactorid === (controlChild.at(i).get('childName') ? controlChild.at(i).get('childName')?.value : null))))
      copyOfChildListOriginal = copyOfChildListOriginal.filter(item => item.intakeservicerequestactorid !== (controlChild.at(i).get('childName') ? controlChild.at(i).get('childName')?.value : null))

      if (newList.length && !newList[0]) {
        newList = [];
      }
      newList.push(...copyOfChildListOriginal);
      newList = _.uniqBy(newList, 'intakeservicerequestactorid');
      this.childListArrayList[i] = newList;
    }
  }
   
  setNotChildList(){
    const controlCaregiver = this.familyYouth.get('caregiverArray') as FormArray;
    for (let i = 0; i < controlCaregiver.length; i++) {
      let newList: any[] = [];
      let copyOfNotChildListOriginal = this.notChildListOriginal;
      newList.push(this.notChildListOriginal.find(item => (
        item.intakeservicerequestactorid === (controlCaregiver.at(i).get('caregivername') ? controlCaregiver.at(i).get('caregivername')?.value : null))))
      copyOfNotChildListOriginal = copyOfNotChildListOriginal.filter(item => item.intakeservicerequestactorid !== (controlCaregiver.at(i).get('caregivername') ? controlCaregiver.at(i).get('caregivername')?.value : null))

      if (newList.length && !newList[0]) {
        newList = [];
      }
      newList.push(...copyOfNotChildListOriginal);
      newList = _.uniqBy(newList, 'intakeservicerequestactorid');
      this.notChildList[i] = newList;
    }
  }

  checkCansFDataMode(){
    if (this.cansFData.mode === 'update' || this.cansFData.mode === 'submit') {
      this.getSubmisionData();
    } else {
      this.getCansfData();
    }
  }
  checksettimeoutpatchvalue(){
    this.familyYouth.patchValue({
      houseHoldHead: this.legalGuardian && this.legalGuardian.length ? this.legalGuardian[0].intakeservicerequestactorid : '',
      houseHoldName: this.legalGuardian && this.legalGuardian.length ? this.legalGuardian[0].fullname : ''
    });
  }
  addLegalGuardian(modal: any) {
    if (modal) {
      const control = <FormArray>this.familyYouth.controls['caregiverArray'];
      const noDuplicates = _.uniqBy(this.notChildListOriginal, 'fullname');
      this.notChildList[control.length] = noDuplicates;
      control.push(this.createFormGroup(modal));
    } else {
      this.removeAddedCaregiver();
      const control = <FormArray>this.familyYouth.controls['caregiverArray'];
      control.push(this.createFormGroupNew());
    }
  }

  removeAddedCaregiver() {
    const control = this.familyYouth.controls['caregiverArray'].value;
    const noDuplicates = _.uniqBy(this.notChildListOriginal, 'fullname');
    this.notChildList[control.length] = noDuplicates;
    if (control && control.length > 0) {
      control.forEach((data: { caregivername: any; }) => {
        this.notChildList[control.length] = this.notChildList[control.length].filter((ele: { intakeservicerequestactorid: any; }) => ele.intakeservicerequestactorid !== data.caregivername);
      });
    } else {
      this.notChildList[0] = noDuplicates;
    }
  }

  deleteLegalGuardian(i: number) {
    const control = this.familyYouth.controls['caregiverArray'].value;
    const oridata = this.notChildListOriginal.find(data => data.intakeservicerequestactorid === control[i].caregivername);
    if (control && control.length > 0) {
      control.forEach((index: any) => {
        if (oridata) {
          if (i < control.length && i !== (control.length - 1)) {
            const oridatas = this.notChildListOriginal.find(data => data.intakeservicerequestactorid === control[i].caregivername);            
            this.checkNotChildList1(i, oridatas);
          } else {
            this.checkNotChildList1(i, oridata);
          }
        }
      });
    }
    const controldata = <FormArray>this.familyYouth.controls['caregiverArray'];
    controldata.removeAt(i);
  }

  checkNotChildList1(index: any, oridatas: any){
    const notchildlist = oridatas ? this.notChildList[index].find((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid === oridatas.intakeservicerequestactorid) : null;
    if (!notchildlist) {
      this.notChildList[index].push(oridatas);
    }
  }

  checkNotChildList2(index: any, oridata: any) {
    const notchildlist = this.notChildList[index].find((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid === oridata.intakeservicerequestactorid);
    if (!notchildlist) {
      this.notChildList[index].push(oridata);
    }
  }

  addChild(modal: any) {
    if (modal) {
      const control = <FormArray>this.familyYouth.controls['childArray'];
      const noDuplicates = _.uniqBy(this.childListOriginal, 'intakeservicerequestactorid');
      this.childListArrayList[control.length] = noDuplicates;
      control.push(this.createChildGroup(modal));
    } else {
      this.removeAddedChildList();
      const control = <FormArray>this.familyYouth.controls['childArray'];
      control.push(this.createChildGroupNew());
    }
  }
  removeAddedChildList() {
    const control = this.familyYouth.controls['childArray'].value;
    const noDuplicates = _.uniqBy(this.childListOriginal, 'personid');
    this.childListArrayList[control.length] = noDuplicates;
    if (control && control.length > 0) {
      control.forEach((data: { childName: any; }) => {
        this.childListArrayList[control.length] = this.childListArrayList[control.length].filter((ele: { intakeservicerequestactorid: any; }) => ele.intakeservicerequestactorid !== data.childName);
      });
    } else {
      this.childListArrayList[0] = noDuplicates;
    }
  }
  deleteChild(i: number) {
    const control = this.familyYouth.controls['childArray'].value;
    const oridata = this.childListOriginal.find(data => data.intakeservicerequestactorid === control[i].childName);
    if (control && control.length > 0) {
      control.forEach((index: any) => {
        if (oridata) {
          if (i < control.length && i !== (control.length - 1)) {
            const oridatas = this.childListOriginal.find(data => data.intakeservicerequestactorid === control[i].childName);
            this.pushTochildListArrayList1(oridatas, i);
          } else {
            this.pushTochildListArrayList2(oridata, i);
          }
        }
      });
    }
    const controldata = <FormArray>this.familyYouth.controls['childArray'];
    controldata.removeAt(i);
  }

  pushTochildListArrayList1(oridatas: any, index: any) {
    const notchildlist = oridatas ? this.childListArrayList[index].find((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid === oridatas.intakeservicerequestactorid) : null;
    if (!notchildlist) {
      this.childListArrayList[index].push(oridatas);
    }
  }

  pushTochildListArrayList2(oridata: any, index: any) {
    const notchildlist = this.childListArrayList[index].find((data: { intakeservicerequestactorid: any; }) => data.intakeservicerequestactorid === oridata.intakeservicerequestactorid);
    if (!notchildlist) {
      this.childListArrayList[index].push(oridata);
    }
  }

  
  addService(modal?: any) {
    const control = <FormArray>this.familyYouth.controls['serviceArray'];
    if (modal) {
      control.push(this.createServiceGroup(modal));
    } else {
      control.push(this.createServiceGroup(null));
    }
  }
  deleteService(index: number) {
    const control = <FormArray>this.familyYouth.controls['serviceArray'];
    control.removeAt(index);
  }
  private createFormGroup(modal: any) {
    if (!this.updateCansF) {
      return this._formBuilder.group({
        caregivername: modal.fullname ? modal.fullname : '',
        caregiverdob:  modal.dob ? new Date(modal.dob.split('T')[0]) : '',
        caregiverage: modal.age ? modal.age : '',
        caregiverrelationship: modal.relationship ? modal.relationship : ''
      });
    } else {
      modal.caregiverdob = modal.caregiverdob ? new Date(modal.caregiverdob.split('T')[0] + ' 00:00:00') : '';
      return this._formBuilder.group(modal);
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
  private createChildGroup(modal: any) {
    if (!this.updateCansF) {
      return this._formBuilder.group({
        childName: modal.fullname ? modal.fullname : '',
        childDob: modal.dob ? new Date(modal.dob) : '',
        childAge: modal.age ? modal.age : '',
        childRelationship: modal.relationship ? modal.relationship : '',
        childSchool: null
      });
    } else {
      return this._formBuilder.group(modal);
    }
  }

  private createChildGroupNew() {
    return this._formBuilder.group({
      childName: null,
      childDob: null,
      childAge: null,
      childRelationship: null,
      childSchool: null
    });
  }

  private createServiceGroup(modal: any) {
    if (modal) {
      return this._formBuilder.group({
        servicename: modal.servicename ? modal.servicename : null,
        currentorpast: modal.currentorpast ? modal.currentorpast : null,
        servicehelpful: modal.servicehelpful ? modal.servicehelpful : null,
      });
    } else {
      return this._formBuilder.group({
        servicename: null,
        currentorpast: null,
        servicehelpful: null,
      });
    }
  }

  getCGName(value: any) {
    const modal = this.notChildListOriginal.find(data => data.intakeservicerequestactorid === value);
    return modal ? modal.fullname : '' ;
  }

  getChildName(value: any) {
    const modal = this.childListOriginal.find(data => data.intakeservicerequestactorid === value);
    return modal ? modal.fullname : '' ;
  }

  getFYPrintData() {
    const fy = this.familyYouth.getRawValue();

    const cgarr = this.familyYouth.get('caregiverArray')?.value;
    if (cgarr) {
      cgarr.forEach((element: any) => {
        element['caregivernametext'] = this.getCGName(element['caregivername']);
      });
    }
    fy['caregiverArray'] = cgarr;

    const childarr = this.familyYouth.get('childArray')?.value;
    if (childarr) {
      childarr.forEach((element: { [x: string]: any; }) => {
        element['childNameText'] = this.getChildName(element['childName']);
      });
    }
    fy['childArray'] = childarr;

    return fy;
  }


  getcansfPayload() {
    const submissiondataValue = (this.submissiondata ? this.submissiondata.assessmentStaus : null);
    return {
      assessmentactor :  this.processActorDetails(),
      familyYouth: this.getFYPrintData(),
      caregivernotapplicable: this.caregiverNotRequiredForm.get('caregivernotapplicable')?.value,
      caregiverreason: this.caregiverNotRequiredForm.get('caregiverreason')?.value,
      familyYouth_caregiverArray: this.familyYouth.get('caregiverArray')?.value,
      familyYouth_childArray: this.familyYouth.get('childArray')?.value,
      familyYouth_serviceArray: this.familyYouth.get('serviceArray')?.value,
      careGiver: this.caregiverFormList,
      familyAssessmentYouth: this.familyAssessmentYouth.getRawValue(),
      child: this.childFormList,
      childFormFamilyQuestion: this.childFormFamilyQuestion.getRawValue(),
      familyCultureYouth: this.familyCultureYouth.getRawValue(),
      authorizationApproval: this.authorizationApproval.getRawValue(),
      supervisorname: this.authorizationApproval.get('supervisorname')?.value,
      routingsupervisors: this.routingSupervisors,
      currentSubmissionId: this.currentSubmissionId,
      assessmentStaus: this.assessmentStatus ? this.assessmentStatus : submissiondataValue,
      comments: this.authorizationApproval.controls['caseworkercomments'].value,
      childDeceased: this.childDeceased,
      childLocatedByDept: this.isChildLocatedByDept 
    };
  }

  processActorDetails() {
    const assessmentactorArray: any[] = [];
    this.childFormList.forEach(child => {
        const assessmentactor = {
          'intakeservicerequestactorid': child.childlist ? child.childlist : null,
      };
      assessmentactorArray.push(assessmentactor);
    });
    const houseHoldHead = this.familyYouth.get('houseHoldHead')?.value;
    assessmentactorArray.push({ 'intakeservicerequestactorid': houseHoldHead ? houseHoldHead : null});
    return assessmentactorArray;
}
  saveForm() {
    if(this.isValue === 1 && this.familyYouth.status == 'INVALID'){
      this.familyYouth.markAsTouched();
      return;
    }
    const cansFData = this.getcansfPayload();
    this._dataStoreService.setData('PRINTDATA', cansFData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, cansFData)
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
        },
        (error) => {
          this._alertService.error('Unable to save.');
        }
      );
  }

  submitForApproval() {
     if (this.isSupervisor) {
      this.assessmentStatus = this.authorizationApproval.get('assessmentstatus')?.value;
     } else {
      this.assessmentStatus = 'Review';
     }
     if(!this.isSupervisor){
      this.authorizationApproval.patchValue({
        assessmentsubmission :moment(new Date()).format(this.dtformat1)
      });
     }
      const submissionData = this.getcansfPayload();
      this._dataStoreService.setData('PRINTDATA', submissionData);

      this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
        .subscribe(
          (response) => {
            this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
            if (this.assessmentStatus === 'Accepted') {
              this.saveAssessmentStrengthNeeds('cansF');
            }
            setTimeout(() => {
              this._router.navigate(['../'], {relativeTo : this.route});
            }, 1000);
          },
          (error) => {
            this._alertService.error('Unable to submit for approval.');
          }
        );
  }

    saveAssessmentStrengthNeeds(templatename: any) {
      const payload = {
        'objectid': this.id,
        'templatename': templatename,
        'status': 'accepted'
      };
      this._commonService.create(payload, 'serviceplan/saveAssessmentStrengthNeeds').subscribe();
    }

  ondetectStrength(event: any, strength_id: any, comment: any, form: any) {
    if (event.value == 1) {
      this.checkStrengthId1(strength_id);
      if (form == 2) {
        this.familyAssessmentYouth.get(comment)?.clearValidators();
        this.familyAssessmentYouth.get(comment)?.updateValueAndValidity();
      } else if (form == 4) {
        this.familyCultureYouth.get(comment)?.clearValidators();
        this.familyCultureYouth.get(comment)?.updateValueAndValidity();
      }
    } else if (event.value > 1) {
      $('#' + strength_id).addClass('hide');
      this.checkStrengthId2(strength_id);
      if (form == 2) {
        this.familyAssessmentYouth.get(comment)?.setValidators([Validators.required]);
        this.familyAssessmentYouth.get(comment)?.updateValueAndValidity();
      } else if (form == 4) {
        this.familyCultureYouth.get(comment)?.setValidators([Validators.required]);
        this.familyCultureYouth.get(comment)?.updateValueAndValidity();
      }
    } else {
      this.parental_description_id = false;
    }
  }

  checkStrengthId1(strength_id: any){
    switch (strength_id) {
      case 'parental_strength':
        this.parental_description_id = true;
        break;
      case 'cultural_strength':
        this.cultural_comments_id = true;
        break;
      case 'language_strength':
        this.language_comments_id = true;
        break;
      case 'sexual_identity_strength':
        this.sexual_comments_id = true;
        break;
      case 'ritual_strength':
        this.ritual_strength_id = true;
        break;
      case 'relation_strength':
        this.relation_strength_id = true;
        break;
      case 'extended_strength':
        this.extended_strength_id = true;
        break;
      case 'social_strength':
        this.social_strength_id = true;
        break;
      case 'safety_strength':
        this.safety_strength_id = true;
        break;
      case 'fappropriateness_strength':
        this.fappropriateness_strength_id = true;
        break;
      case 'fcommunication_strength':
        this.fcommunication_strength_id = true;
        break;
      case 'financial_resources_strength':
        this.financial_resources_strength_id = true;
        break;
      case 'residential_stability_strength':
        this.residential_stability_strength_id = true;
        break;
      case 'family_strength':
        this.family_strength_id = true;
        break;
    }
  }

  checkStrengthId2(strength_id: any){
    switch (strength_id){
      case'language_strength':
        this.language_comments_id = false;
      break;
      case'sexual_identity_strength':
        this.sexual_comments_id = false;
      break;
      case'ritual_strength':
        this.ritual_strength_id = false;
      break;
      case'relation_strength':
        this.relation_strength_id = true;
      break;
      case'parental_strength':
        this.parental_description_id = false;
      break;
      case'extended_strength':
        this.extended_strength_id = false;
      break;
      case'social_strength':
        this.social_strength_id = false;
      break;
      case'safety_strength':
        this.safety_strength_id = false;
      break;
      case'family_strength':
        this.family_strength_id = false;
      break;
      case'fappropriateness_strength':
        this.fappropriateness_strength_id = false;
      break;
      case'fcommunication_strength':
        this.fcommunication_strength_id = false;
      break;
      case'financial_resources_strength':
        this.financial_resources_strength_id = false;
      break;
      case'residential_stability_strength':
        this.residential_stability_strength_id = false;
      break;
    }
  }

  calculate() {
    const emp_income_amt = (this.familyAssessmentYouth.get('emp_income_amt')?.value) ? parseFloat(this.familyAssessmentYouth.get('emp_income_amt')?.value) : 0;
    const child_support_amt = (this.familyAssessmentYouth.get('child_support_amt')?.value) ? parseFloat(this.familyAssessmentYouth.get('child_support_amt')?.value) : 0;
    const t_cash_assistance_amt = (this.familyAssessmentYouth.get('t_cash_assistance_amt')?.value) ? parseFloat(this.familyAssessmentYouth.get('t_cash_assistance_amt')?.value) : 0;
    const food_stamp_amt = (this.familyAssessmentYouth.get('food_stamp_amt')?.value) ? parseFloat(this.familyAssessmentYouth.get('food_stamp_amt')?.value) : 0;
    const social_security_benefits = (this.familyAssessmentYouth.get('social_security_benefits')?.value) ? parseFloat(this.familyAssessmentYouth.get('social_security_benefits')?.value) : 0;
    const unemployment_amt = (this.familyAssessmentYouth.get('unemployment_amt')?.value) ? parseFloat(this.familyAssessmentYouth.get('unemployment_amt')?.value) : 0;
    const other_amt = (this.familyAssessmentYouth.get('other_amt')?.value) ? parseFloat(this.familyAssessmentYouth.get('other_amt')?.value) : 0;
    const unknown_amt = (this.familyAssessmentYouth.get('unknown_amt')?.value) ? parseFloat(this.familyAssessmentYouth.get('unknown_amt')?.value) : 0;

    this.totalamt = emp_income_amt + child_support_amt + t_cash_assistance_amt + food_stamp_amt + social_security_benefits + unemployment_amt + other_amt + unknown_amt;
    this.familyAssessmentYouth.patchValue({
        monthly_total: this.totalamt,
      });
  }

  initializeCaregiverForm() {
    this.caregiverForm = this._formBuilder.group({
      caregiverlist: [null],
      collaterallist: [null],
      ccacaregivername:[null],
      supervision: [null],
      supervisionrating: ['0'],
      supervisionnotes: [null],
      involvement: [null],
      involvementrating: ['0'],
      involvementnotes: [null],
      emotionalresp: [null],
      emotionalresprating: ['0'],
      emotionalrespnotes: [null],
      knowledge: [null],
      knowledgerating: ['0'],
      knowledgenotes: [null],
      org: [null],
      orgrating: ['0'],
      orgnotes: [null],
      boundaries: [null],
      boundariesrating: ['0'],
      boundariesnotes: [null],
      discipline: [null],
      disciplinerating: ['0'],
      disciplinenotes: [null],
      posttraumaticrating: ['0'],
      posttraumaticnotes: [null],
      phyhealthrating: ['0'],
      phyhealthnotes: [null],
      mentalhealthrating: ['0'],
      mentalhealthnotes: [null],
      developmentalrating: ['0'],
      developmentalnotes: [null],
      substanceuserating: ['0'],
      substanceusenotes: [null],
      criminalbehavrating: ['0'],
      criminalbehavnotes: [null],
      sexabuserating: ['0'],
      sexabusenotes: [null],
      phyabuserating: ['0'],
      phyabusenotes: [null],
      emotionalabuserating: ['0'],
      emotionalabusenotes: [null],
      neglectrating: ['0'],
      neglectnotes: [null],
      medtraumarating: ['0'],
      medtraumanotes: [null],
      familyvoilancerating: ['0'],
      familyvoilancenotes: [null],
      communityvoilancerating: ['0'],
      communityvoilancenotes: [null],
      schoolvoilancerating: ['0'],
      schoolvoilancenotes: [null],
      disasterrating: ['0'],
      disasternotes: [null],
      waraffectedrating: ['0'],
      waraffectednotes: [null],
      terroraffectedrating: ['0'],
      terroraffectednotes: [null],
      criminalactivityrating: ['0'],
      criminalactivitynotes: [null],
      disruptionrating: ['0'],
      disruptionnotes: [null],
      famchildneeds: [null],
      famchildneedsrating: ['0'],
      famchildneedsnotes: [null],
      serviceopt: [null],
      serviceoptrating: ['0'],
      serviceoptnotes: [null],
      responsibilities: [null],
      responsibilitiesrating: ['0'],
      responsibilitiesnotes: [null],
      listening: [null],
      listeningrating: ['0'],
      listeningnotes: [null],
      communication: [null],
      communicationrating: ['0'],
      communicationnotes: [null],
      naturesupport: [null],
      naturesupportrating: ['0'],
      naturesupportnotes: [null],
      youthliving: [null],
      youthlivingrating: ['0'],
      youthlivingnotes: [null],
      youtheducation: [null],
      youtheducationrating: ['0'],
      youtheducationnotes: [null],
      servicearrange: [null],
      servicearrangerating: ['0'],
      servicearrangenotes: [null],
      Psychosisrating: ['0'],
      Psychosisnotes: [null],
      AttnDeficitImpulseControlrating: ['0'],
      AttnDeficitImpulseControlnotes: [null],
      DepressionMoodDisorderrating: ['0'],
      DepressionMoodDisordernotes: [null],
      Anxietyrating: ['0'],
      Anxietynotes: [null],
      OppositionalBehaviorrating: ['0'],
      OppositionalBehaviornotes: [null],
      ConductAntisocialBehaviorrating :['0'],
      ConductAntisocialBehaviornotes: [null],
      SubstanceAbuserating: ['0'],
      SubstanceAbusenotes: [null],
      EatingDisturbancerating: ['0'],
      EatingDisturbancenotes: [null],
      AngerControlrating: ['0'],
      AngerControlnotes: [null],
      AttachmentDifficultiesrating: ['0'],
      AttachmentDifficultiesnotes: [null],
      SuicideRiskrating: ['0'],
      SuicideRisknotes: [null],
      SelfInjuriousBehaviorsrating: ['0'],
      SelfInjuriousBehaviorsnotes: [null],
      RecklessBehaviorsrating: ['0'],
      RecklessBehaviorsnotes: [null],
      DangertoOthersrating: ['0'],
      DangertoOthersnotes: [null],
      SexualAggressionrating: ['0'],
      SexualAggressionnotes: [null],
      SexuallyReactiveBehaviorsrating: ['0'],
      SexuallyReactiveBehaviornotes: [null],
      runawayrating: ['0'],
      runawaynotes: [null],
      DelinquentBehaviorrating: ['0'],
      DelinquentBehaviornotes: [null],
      firesettingrating: ['0'],
      firesettingnotes: [null],
      IntentionalMisbehaviorrating: ['0'],
      IntentionalMisbehaviornotes: [null],
      bullyingrating: ['0'],
      bullyingnotes: [null],
      Exploitedrating: ['0'],
      Exploitednotes: [null],
      addl_crgvr_advcy_info: [''],
      addl_crgvr_info_pmsl: [''],
      formStatus: [null]
    });
    this.caregiverForm.setControl('contactcaregivers', this._formBuilder.array([]));
    this.caregiverForm.setControl('contactprofesssionalsupcaregivers', this._formBuilder.array([]));

    this.caregiverNotRequiredForm = this._formBuilder.group({
      caregivernotapplicable: [null],
      caregiverreason: [null]
    });
  }

  showEditCareGiver(mode: number, model: any, index: any) {
    this.initializeCaregiverForm();
    this.listCollateralPersonFormList = this.listCollateralPerson;
    if (mode === 2) {
      this.caregiverFormList.splice(index, 1);
      return true;
    }
    if (mode === 3) {
      this.removeAddedlegals();
    }
    this.caregiverForm.enable();
    this.showCareGiver = true;
    this.caregiverMode = mode;
    if (model) {
      this.caregiverlegalGuardian = this.caregiverDdList;
      this.caregiverForm.patchValue(model);
      this.caregiverForm.setControl('contactcaregivers', this._formBuilder.array([]));
      this.caregiverForm.setControl('contactprofesssionalsupcaregivers', this._formBuilder.array([]));
      if (model.contactcaregivers && model.contactcaregivers.length > 0) {
        model.contactcaregivers.forEach((data: any) => {
          this.addcaregiverContact(data);
        });
      }
      if (model.contactprofesssionalsupcaregivers && model.contactprofesssionalsupcaregivers.length > 0) {
        model.contactprofesssionalsupcaregivers.forEach((data: any) => {
          this.addprofesssionalsupcaregiverContact(data);
        });
      }
      //}
      this.caregiverindex = index;
      if (mode === 0) {
        this.caregiverForm.disable();
      }
    } else {
      this.caregiverForm.reset();
      this.initializeCaregiverForm();       
    }
  }

  addcaregiverContact(modal: any) {
    const control = <FormArray>this.caregiverForm.controls['contactcaregivers'];
    control.push(this.createcareGiver(modal));
  }
  deletecaregiverContact(index: number) {
    const control = <FormArray>this.caregiverForm.controls['contactcaregivers'];
    control.removeAt(index);
  }

  addprofesssionalsupcaregiverContact(modal: any) {
    const control = <FormArray>this.caregiverForm.controls['contactprofesssionalsupcaregivers'];
    control.push(this.createcareGiver(modal));
  }
  deleteprofesssionalsupcaregiverContact(index: number) {
    const control = <FormArray>this.caregiverForm.controls['contactprofesssionalsupcaregivers'];
    control.removeAt(index);
  }

  private createcareGiver(modal: any) {
    return this._formBuilder.group({
      name: modal.name ? modal.name : null,
      address: modal.address ? modal.address : null,
      phoneno: modal.phoneno ? modal.phoneno : null,
      relationship: modal.relationship ? modal.relationship : null
    });
  }

  saveCaregiver() {
    const caregiverform = this.caregiverForm.getRawValue();
    caregiverform.formStatus = this.caregiverForm.valid;
    if (this.caregiverMode && this.caregiverMode === 1 && this.caregiverindex != null) {
      this.caregiverFormList[this.caregiverindex] = caregiverform;
    } else {
      this.caregiverFormList.push(caregiverform);
    }
    this.showCareGiver = false;
    this.removeAddedlegals();
    this.saveForm();
  }

  saveCaregiverAsNotApplicable() {
    this.caregiverNotRequiredDtl = { caregivernotapplicable: this.caregiverNotRequiredForm.getRawValue().caregivernotapplicable, caregiverreason: this.caregiverNotRequiredForm.getRawValue().caregiverreason }
    this.caregiverFormList = [];
    this.showCareGiver = false;
    this.removeAddedlegals();
    this.saveForm();
  }

  removeAddedlegals() {
    this.listCollateralPersonFormList = this.listCollateralPerson;
    if (this.caregiverFormList && this.caregiverFormList.length > 0) {
      this.caregiverFormList.forEach((data: any) => {
        this.caregiverlegalGuardian = this.caregiverlegalGuardian.filter(ele => ele.intakeservicerequestactorid !== data.caregiverlist);
        this.listCollateralPersonFormList = this.listCollateralPersonFormList.filter(ele => ele.collateralid !== data.collaterallist);
      });
    } else {
      this.caregiverlegalGuardian = this.caregiverDdList;
    }
  }

  cancelCareGiver() {
    this.showCareGiver = false;
  }

  onChangeDisplay(event: any, type: any) {
    if (type == 'family_own_rent') {
      if (event.value == 3) {
        this.familyOther = true;
      } else {
        this.familyOther = false;
      }
    } else {
      if (event.value == 1) {
        this.checkEventValueOne(type);
      } else {
        this.checkEventValueOther(type);
      }
    }
  }

  checkEventValueOne(type: any) {
    switch (type) {
      case 'caregiver_insurance':
        this.Provider = true;
        break;
      case 'children_insurance':
        this.cProvider = true;
        break;
      case 'family_needs_assistance':
        this.otherbox = true;
        break;
    }
  }

  checkEventValueOther(type: any) {
    switch (type) {
      case 'family_needs_assistance':
        this.otherbox = true;
        break;
      case 'children_insurance':
        this.cProvider = true;
        break;
      case 'caregiver_insurance':
        this.Provider = true;
        break;
    }
  }

  getRoutingSupervisors() {
    return this.routingSupervisors; 
  }

  getRoutingInfo() {
    return this.routingInfo;
  }

  initializeChildForm() {
    this.childForm = this._formBuilder.group({
      childlist: [null],
      childname: [null],
      mother: [null],
      motherrating: ['0'],
      mothernotes: [null],
      father: [null],
      fatherrating: ['0'],
      fathernotes: [null],
      pricaregiver: [null],
      pricaregiverrating: ['0'],
      pricaregivernotes: [null],
      adults: [null],
      adultsrating: ['0'],
      adultsnotes: [null],
      siblings: [null],
      siblingsrating: ['0'],
      siblingsnotes: [null],
      medical: [null],
      medicalrating: ['0'],
      medicalnotes: [null],
      iq: [null],
      iqrating: ['0'],
      iqnotes: [null],
      autism: [null],
      autismrating: ['0'],
      autismnotes: [null],
      speech: [null],
      speechrating: ['0'],
      speechnotes: [null],
      social: [null],
      socialrating: ['0'],
      socialnotes: [null],
      schoolatd: [null],
      schoolatdrating: ['0'],
      schoolatdnotes: [null],
      schoolachiv: [null],
      schoolachivrating: ['0'],
      schoolachivnotes: [null],
      schoolbehv: [null],
      schoolbehvrating: ['0'],
      schoolbehvnotes: [null],
      mentalhealthrating: ['0'],
      mentalhealthnotes: [null],
      riskbehaviour: ['0'],
      adjtotraumarating: ['0'],
      adjtotraumanotes: [null],
      sexabuserating: ['0'],
      sexabusenotes: [null],
      phyabuserating: ['0'],
      phyabusenotes: [null],
      emotionalabuserating: ['0'],
      emotionalabusenotes: [null],
      neglectrating: ['0'],
      neglectnotes: [null],
      medicaltraumarating: ['0'],
      medicaltraumanotes: [null],
      familyvoilancerating: ['0'],
      familyvoilancenotes: [null],
      communityvoilancerating: ['0'],
      communityvoilancenotes: [null],
      schoolvoilancerating: ['0'],
      schoolvoilancenotes: [null],
      disasterrating: ['0'],
      disasternotes: [null],
      waraffectedrating: ['0'],
      waraffectednotes: [null],
      terroraffectedrating: ['0'],
      terroraffectednotes: [null],
      criminalactivityrating: ['0'],
      criminalactivitynotes: [null],
      disruptionrating: ['0'],
      disruptionnotes: [null],
      Psychosisrating: ['0'],
      Psychosisnotes: [null],
      AttnDeficitImpulseControlrating: ['0'],
      AttnDeficitImpulseControlnotes: [null],
      DepressionMoodDisorderrating: ['0'],
      DepressionMoodDisordernotes: [null],
      Anxietyrating: ['0'],
      Anxietynotes: [null],
      OppositionalBehaviorrating: ['0'],
      OppositionalBehaviornotes: [null],
      ConductAntisocialBehaviorrating :['0'],
      ConductAntisocialBehaviornotes: [null],
      SubstanceAbuserating: ['0'],
      SubstanceAbusenotes: [null],
      EatingDisturbancerating: ['0'],
      EatingDisturbancenotes: [null],
      AngerControlrating: ['0'],
      AngerControlnotes: [null],
      AttachmentDifficultiesrating: ['0'],
      AttachmentDifficultiesnotes: [null],
      SuicideRiskrating: ['0'],
      SuicideRisknotes: [null],
      SelfInjuriousBehaviorsrating: ['0'],
      SelfInjuriousBehaviorsnotes: [null],
      RecklessBehaviorsrating: ['0'],
      RecklessBehaviorsnotes: [null],
      DangertoOthersrating: ['0'],
      DangertoOthersnotes: [null],
      SexualAggressionrating: ['0'],
      SexualAggressionnotes: [null],
      SexuallyReactiveBehaviorsrating: ['0'],
      SexuallyReactiveBehaviornotes: [null],
      runawayrating: ['0'],
      runawaynotes: [null],
      DelinquentBehaviorrating: ['0'],
      DelinquentBehaviornotes: [null],
      firesettingrating: ['0'],
      firesettingnotes: [null],
      IntentionalMisbehaviorrating: ['0'],
      IntentionalMisbehaviornotes: [null],
      bullyingrating: ['0'],
      bullyingnotes: [null],
      Exploitedrating: ['0'],
      Exploitednotes: [null],
      addl_child_info:[''],
      formStatus: [null]
    });
  }

  loadChildList() {
    this.isValue =5;
    this.initializeChildForm();
    this.childList = _.uniqBy(this.childListOriginal, 'personid');
    if (this.childList && this.childList.length > 0) {
      this.childList.forEach(data => {
        this.childListName[data.intakeservicerequestactorid] = data.fullname +"("+data.cjamspid +","+moment(data.dob).format(this.dtformat) +")";
      });
    }
    this.removeAddedchild();
    this.showChild = false;
  }

  removeAddedchild() {
    if (this.childFormList && this.childFormList.length > 0) {
      this.childFormList.forEach(data => {
        this.childList = this.childList.filter(ele => ele.intakeservicerequestactorid !== data.childlist);
      });
    } else {
      this.childList = _.uniqBy(this.childListOriginal, 'personid');
    }
  }

  showEditChild(mode: number, model: any, index?: any) {
    this.initializeChildForm();
    if (mode === 2) {
      this.childList = _.uniqBy(this.childListOriginal, 'fullname');
      this.childFormList.splice(index, 1);
      return true;
    }
    if (mode === 3) {
      this.removeAddedchild();
    }
    this.childForm.enable();
    this.showChild = true;
    this.childMode = mode;
    if (model) {
      this.childList = _.uniqBy(this.childListOriginal,'fullname');
      this.childForm.patchValue(model);
      this.childindex = index;
      if (mode === 0) {
        this.childForm.disable();
      }
    } else {
      this.childForm.reset();
      this.initializeChildForm();
    }
  }

  cancelChildFormFamilyQuestion(){
    this.childFormFamilyQuestion.reset();
  }

  cancelchild() {
    this.showChild = false;
  }

  saveChild() {
    const childform = this.childForm.getRawValue();
    childform.formStatus = this.childForm.valid;
    if (this.childMode && this.childMode === 1) {
      this.childFormList[this.childindex] = childform;
    } else {
      this.childFormList.push(childform);
    }
    this.showChild = false;
    this.removeAddedchild();
    this.saveForm();
  }

  isReadyForApproval(){
    this.requiredForApproval=true;
    this.familyAssessmentYouth.markAllAsTouched();
    this.caregiverForm.markAllAsTouched();
    this.familyCultureYouth.markAllAsTouched();
    this.childForm.markAllAsTouched();
    this.disableSubmit = true;
    this.incompleteList = [];
    if(!this.childDeceased && !this.isChildLocatedByDept) {
      this.approvalReadynessCheck();
  } 
   if(this.isChildLocatedByDept) {
      if(this.contactNotes == null || this.contactNotes == undefined) {
         this.incompleteList.push('Actions Taken');
    }
  } 
  if (this.childDeceased) {
    if (this.deceasedChildName == null) {
      this.incompleteList.push('Child Name');
    }
    if (this.dodOfDeceasedChild == null ) {
      this.incompleteList.push('Child DOD');
    }
  }
  if (!this.authorizationApproval.valid) {
    this.incompleteList.push('APPROVAL');
  }
  if (this.incompleteList.length == 0) {
    this.submitForApproval();
  } else {
    this.disableSubmit = false;
    (<any>$('#incomplete-items')).modal('show');
  }
}

approvalReadynessCheck() {
  if (!this.familyYouth.valid) {
    this.incompleteList.push('FAMILY AND YOUTH INFORMATION');
  }
  if (!this.familyAssessmentYouth.valid) {
    this.incompleteList.push('COMPREHENSIVE FAMILY ASSESSMENT');
  }
  this.tabThreeValidation();
  if (!this.familyCultureYouth.valid) {
    this.incompleteList.push('FAMILY CULTURE ASSESSMENT');
  }
  this.tabFiveValidation();
}
tabThreeValidation(){
  const caregiverNotRequired = (this.caregiverNotRequiredForm.value.caregivernotapplicable !== null) ? this.caregiverNotRequiredForm.value.caregivernotapplicable : false;
  const caregiverNotRequiredReason = (this.caregiverNotRequiredForm.value.caregiverreason) ? this.caregiverNotRequiredForm.value.caregiverreason : null;
  if (this.caregiverFormList && this.caregiverFormList.length > 0) {
    const formStatus = this.caregiverFormList.filter(data => {
      return !(data.formStatus);
    });
    if (formStatus && formStatus.length > 0) {
      this.incompleteList.push('COMPREHENSIVE CAREGIVER ASSESSMENT');
    }
  } else if (!caregiverNotRequired || (caregiverNotRequired && !caregiverNotRequiredReason)) {
    this.incompleteList.push('COMPREHENSIVE CAREGIVER ASSESSMENT');
  }
}

tabFiveValidation(){
  if (this.childFormList && this.childFormList.length > 0) {
    const formStatus = this.childFormList.filter(data => {
      return !(data.formStatus);
    });
    if (formStatus && formStatus.length > 0) {
      this.incompleteList.push('COMPREHENSIVE CHILD ASSESSMENT');
    }
  } else {
    this.incompleteList.push('COMPREHENSIVE CHILD ASSESSMENT');
  }
}



  houseHoldChildDeceased(value: any) {
    if(value.checked) {
      this.childDeceased = true;
      this.isValue = 6;
      if(!this.dateofcasehead) {
        this.dateofcasehead = moment(new Date()).format(this.dtformat);
      }
      this.isChildLocatedByDept = false;
    } else {
      this.childDeceased = false;
      this.isValue = 1;
    }
    return 'success'
  }

  deptLocateChild(value: any) {
    if(value.checked) {
      this.isChildLocatedByDept = true;
      this.childDeceased = false;
      this.isValue = 7;
      if(!this.dateofcasehead) {
        this.dateofcasehead = moment(new Date()).format(this.dtformat);
      }
    } else {
      this.isChildLocatedByDept = false;
      this.isValue = 1;
    }
    return 'success'
  }

  getcollateral() {
    const request = {
      objectid: this.id,
      objecttype: 'case'
    };
    this._commonService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'collateral/list?filter'
    ).subscribe(data => {
      if (data && data.length && data[0].getcollateraldetails && data[0].getcollateraldetails.length) {
        data[0].getcollateraldetails.map((element: any) => {
          if(element.collateralroleconfig) {
            element.collateralroleconfig.map((item: any) => {
              if(item.description === 'Caretaker-Caregiver') {
               this.listCollateralPerson.push({
                 collateralid : element.collateralid,
                 fullname: element.fullname,
                 persontype: 'collateral'
               })
              }
            })
          }
        })
        
             
      } else {
        this.listCollateralPerson = [];
      }
    });
  }
  getCollateralPersonName(collateralid: any) {
    const colinfo = this.listCollateralPerson.find(data => data.collateralid === collateralid);
    return colinfo ? colinfo.fullname : null;
  }

  cancelCansfCareGiver(item: any) {
    if(item.checked) {
      this.cancelCareGiver();
    }
  }

  closePopup() {
    (<any>$('#info-popup')).modal('hide');
  }
  summaryTabOpen() {
    this.isValue = 9;
    this.summaryData = this.getcansfPayload();
    
  }
  
  getCaregiverFormData(name: string): any[] {
    return Object.values((this.caregiverForm.get(name) as FormGroup).controls);
  }

  getFamilyYouthFormData(name: string): any[] {
    return Object.values((this.familyYouth.get(name) as FormGroup).controls);
  }

  openPicker(picker: any) {
    if(picker === 'picker11') {
      this.picker11.open();
    }
  }

  onPickerClosed(event: any, controlName: string) {
    const control: any = this.familyYouth.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }

}
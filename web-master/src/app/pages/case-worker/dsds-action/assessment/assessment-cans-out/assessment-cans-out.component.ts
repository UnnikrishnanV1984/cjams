import { Component, OnInit, Injector, ViewChild, ElementRef } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup, FormArray, Validators, ReactiveFormsModule } from '@angular/forms';
import { AssessmentService } from '../assessment.service';
import { CommonDropdownsService, AlertService, AuthService, SessionStorageService, DataStoreService, CommonHttpService } from '../../../../../@core/services';
import { DomSanitizer } from '@angular/platform-browser';
import { RoutingInfo } from '../../../_entities/caseworker.data.model';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';

import moment from 'moment';
import _ from 'lodash';
import { OWL_DATE_TIME_FORMATS, OwlDateTimeComponent, OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { ApprovalHistoryModule } from '../../../../../shared/shared-components/approval-history/approval-history.module';
import { MatSelectModule } from '@angular/material/select';
import { CommonModule } from '@angular/common';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { provideNgxMask } from 'ngx-mask';
import { MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';
import { ViewAssessmentCansSummaryComponent } from '../view-assessment-cans-summary/view-assessment-cans-summary.component';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatSortModule } from '@angular/material/sort';

declare let bootstrap: any;

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
  selector: 'assessment-cans-out',
  templateUrl: './assessment-cans-out.component.html',
  styleUrls: ['./assessment-cans-out.component.scss'],
  imports:[MatFormFieldModule,MatInputModule,MatRadioModule,ReactiveFormsModule,ApprovalHistoryModule,MatSelectModule,CommonModule,MatDatepickerModule,OwlDateTimeModule, OwlNativeDateTimeModule,OwlMomentDateTimeModule,ViewAssessmentCansSummaryComponent,SignatureFieldModule,MatCheckboxModule],
  providers:[MatSortModule,provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
  standalone: true
})
export class AssessmentCansOutComponent implements OnInit {
  @ViewChild('picker1') picker1!: OwlDateTimeComponent<any>;
  @ViewChild('infoPopup', { static: true }) infoPopup!: ElementRef;
  id: any;
  source!: string;
  isValue: number =1;
  daNumber: any;
  ASSESSMENT_NAME = 'CANS-OUT OF HOME PLACEMENT SERVICE';
  submissiondata: any;
  currentAssessmentId: any;
  isSupervisor: any;
  requiredForApproval!: boolean;
  assessmentStatus: any;
  routingSupervisors: any;
  isServiceCase: any;
  roleId!: AppUser;
  agency!: string;
  isCW!: boolean;
  cansOOHData: any;
  currentSubmissionId: any;
  faceLifeForm!: FormGroup;
  childform!: FormGroup;
  cultureFactorForm!: FormGroup;
  traumaform!: FormGroup;
  caregiverstrengthform!: FormGroup;
  permanencyPlanform!: FormGroup;
  transitionForm!: FormGroup;
  authorizationForm!: FormGroup;
  selectedChildPersonId: any;
  // common
  involvedPerson: any[] = [];
  legalGuardian: any[] = [];
  reportedChild: any[] = [];
  viewCansOut = false;
  routingInfo!: RoutingInfo[];
  incompleteList: any[] = [];
  isapprovaltab = false;
  adultage = 0;
  disableSubmitforAPproval = false;
  // CareGiver
  ShowCareGiverForm = false;
  caregiverFormList: any[] = [];
  caregiverMode: any;
  caregiverindex!: number|undefined;
  showCareGiver!: boolean;
  caregiverDdList: any[] = [];
  caregiverlegalGuardian: any[] = [];
  caregiverlegalGuardianName: any[] = [];
  caregiverNotRequiredForm!: FormGroup;
  listCollateralPerson: any[] = [];

  //Caregivers
  caregiversInCase: any[] = [];

  currentAssessmentDate: any;
  summaryData: any = {};

  assessmentType: any[] = [
    {
      text: 'Initial (60 days from placement)',
      value: 'Initial (60 days from placement)'
    },
    {
      text: 'Re-assessment (every 6 months)',
      value: 'Re-assessment (every 6 months)'
    },
    {
      text: 'Transition/Discharge (part of transition/case close)',
      value: 'Transition/Discharge (part of transition/case close)'
    }
  ];
  medicalModuleList!: ['Life Threat', 'Chronicity', 'Diagnostic Complexity', 'Emotional Response', 'Impairment in Functioning', 'Treatment Involvement', 'Family Stress', 'Intensity of Treatment', 'Organizational Complexity'];
  runawayModuleList!: ['Frequencey of Running', 'Consistancy of Destination', 'Safety of Destination', 'Involvement in Illegal Activities', 'Likelhood of Return on Own', 'Involvement of Others', 'Realistic Expectations', 'Planning']
  substanceAbuseModuleList!: ['Severity of Use', 'Duration of Use', 'Stage of Recovery', 'Peer Influences', 'Parental Influences', 'Environmental Influences']
  fireSettingModuleList!: ['Seriousness', 'History', 'Planning', 'Use of accelerants', 'Intention to harm', 'Community Safety', 'Response to Accusation', 'Remorse', 'Likelhood of future fires']
  sexualAggressionModuleList!: ['Relationship', 'Physical Force/Threat', 'Planning', 'Age Differential', 'Type of Sex Act', 'Respone to Accusation', 'Temporal Consistency', 'History of Sexual Behavior', 'Severity of Sexual Abuse', 'Prior Treatment']
  maxDate: any = moment(new Date()).format('YYYY-MM-DDTHH:mm');
  minDate = new Date();
  isCareGiver!: boolean;
  collateralPersons: any[] = [];
  listCollateralPersonFormList: any[] = [];
  showtransition_oldsection: boolean = false;
  currentdatetime = moment().toDate();
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

  constructor(private injector: Injector) {
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
    this.inintailizeForm();
    this.initializeCaregiverForm();
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this._assessmentService.getservicecase();
    this.roleId = this._authService.getCurrentUser();
    this.agency = this._authService.getAgencyName();
    this.isSupervisor = (this.roleId.role.name === 'apcs') ? true : false;
    if (this.agency === 'CW') {
      this.isCW = true;
    } else {
      this.isCW = false;
    }
    this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') ? this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') : [];
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.cansOOHData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    // In case of working with an existing assesment submission
    this.currentAssessmentId = this.cansOOHData.assessmentid;
    this.currentSubmissionId = this.cansOOHData.submissionid;
    this.getCaregiverCollateral();
    //Get persons in case
    this.getInvolvedPerson();
    //Get caregivers in case
    this.getCaregiversInCase();
    //Get collaterals with role Foster Parent in case
    this.getcollateral();

    this.authorizationForm.get('supervisorname')?.disable();

    if (this.cansOOHData.mode === 'update' || this.cansOOHData.mode === 'submit') {
      this.getSubmisionData();
    } else {
      this.patchCansOutForm();
    }
    if (this.isSupervisor) {
      this.authorizationForm.get('routingsupervisors')?.disable();
      this.authorizationForm.get('caseworkername')?.disable();
      this.authorizationForm.get('caseworkercomments')?.disable();
    }
    this.currentAssessmentDate = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');

    this.handleApprovalButtonCondWithRespToFormChangesFn();
  }

  private handleApprovalButtonCondWithRespToFormChangesFn() {
    this.faceLifeForm.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.childform.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.cultureFactorForm.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.traumaform.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.caregiverNotRequiredForm.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.caregiverstrengthform.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.permanencyPlanform.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.transitionForm.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
    this.authorizationForm.valueChanges.subscribe(() => {
      this.reusableButtonApprovalStatusFn();
    });
  }

  private reusableButtonApprovalStatusFn() {
    if (this.assessmentStatus == 'Review') {
      this.disableSubmitforAPproval = false;
    }
  }

  tabChange(tabname: any) {
    if (tabname === 'caregiver') {
      this.isCareGiver = true;
    } else if (tabname === 'summary') {
      this.isCareGiver = true;
      this.summaryData = this.getCansoutReq();
    } else {
      this.isCareGiver = false;
    }
    this.isapprovaltab = tabname === 'Approval';
  }

  getSubmisionData() {
    const url = `admin/assessment/getassessmentform/${this.cansOOHData.external_templateid}/submission/${this.cansOOHData.submissionid}`;
    this._commonService.getSingle({}, url).subscribe(result => {
      //Replace submissiondata from assessment table with the parsed json from transaction table
      // this.cansFData.submissiondata = result;
      this.submissiondata = result;
      this.patchCansOutForm();
    });
  }


  patchCansOutForm() {

    //Flip for non-migrated data
    if (this.cansOOHData && this.cansOOHData.submissiondata) {
      this.handleIfSubmissiondataCheckFn();
    }

    if (this.cansOOHData.submissiondata && this.cansOOHData.submissiondata.caregivernotapplicable && this.cansOOHData.submissiondata.caregivernotapplicable === true) {
      this.caregiverNotRequiredForm.patchValue({
        caregivernotapplicable: this.cansOOHData.submissiondata.caregivernotapplicable,
        caregiverreason: this.cansOOHData.submissiondata.caregiverreason,
      })
    }

    this._dataStoreService.setData('PRINTDATA', this.getChildFullNames(this.submissiondata));

    if (this.cansOOHData && (this.cansOOHData.mode === 'update' || this.cansOOHData.mode === 'submit')) {
      this.viewCansOut = false;
      setTimeout(() => {

        this.handleIfModeIsEitherUpdateOrSubmitFn();
      }, 2000)


      if (this.submissiondata.faceLifeForm) {
        this.selectedChildPersonId = this.submissiondata.faceLifeForm.childname;
        this.faceLifeForm.patchValue(this.submissiondata.faceLifeForm);
        const user = this.reportedChild.find((item: any) => item.intakeservicerequestactorid === this.selectedChildPersonId);
        this.adultage = moment().diff(user?.dob, 'years');
        this.faceLifeForm.patchValue({
          dateassessmentinitiated: new Date(this.submissiondata.faceLifeForm.dateassessmentinitiated)
        });
      }

      if (this.submissiondata.childform) {
        this.childform.patchValue(this.submissiondata.childform);
      }

    } else {
      this.viewCansOut = false;
      this.prefillauthorizationFormInfo();
    }
    if (this.cansOOHData && this.cansOOHData.mode === 'submit') {
      this.viewCansOut = true;
      this.faceLifeForm.disable();
      this.childform.disable();
      this.cultureFactorForm.disable();
      this.traumaform.disable();
      this.caregiverstrengthform.disable();
      this.permanencyPlanform.disable();
      this.transitionForm.disable();
      this.authorizationForm.disable();
    }
  }
  private handleIfSubmissiondataCheckFn() {
    this.submissiondata = this.cansOOHData.submissiondata;
    if (!this.cansOOHData.submissiondata.transitionForm?.showoldsection || this.cansOOHData.submissiondata.transitionForm?.showoldsection === undefined) {
      this.showtransition_oldsection = false;
    }
    else if (this.cansOOHData.submissiondata.authorizationForm?.assessmentstatus == 'Accepted' && (this.cansOOHData.submissiondata.transitionForm?.showoldsection && !this.cansOOHData.submissiondata.transitionForm?.showoldsection)) {
      this.showtransition_oldsection = false;
    } else {
      this.showtransition_oldsection = true;
    }

    this.faceLifeForm.patchValue({
      dateassessmentinitiated: this.cansOOHData.submissiondata.faceLifeForm.dateassessmentinitiated
    });
  }

  private handleIfModeIsEitherUpdateOrSubmitFn() {
    if (this.submissiondata.faceLifeForm) {
      this.selectedChildPersonId = this.submissiondata.faceLifeForm.childname;
      this.faceLifeForm.patchValue(this.submissiondata.faceLifeForm);
      const user = this.reportedChild.find((item: any) => item.intakeservicerequestactorid === this.selectedChildPersonId);
      this.adultage = moment().diff(user?.dob, 'years');
      this.faceLifeForm.patchValue({
        dateassessmentinitiated: new Date(this.submissiondata.faceLifeForm.dateassessmentinitiated)
      });
    }

    if (this.submissiondata.childform) {
      this.childform.patchValue(this.submissiondata.childform);
    }

    if (this.submissiondata.authorizationForm) {
      this.submissiondata.authorizationForm.safetyassessmentapprovaldate = moment(this.submissiondata.authorizationForm.safetyassessmentapprovaldate).format('MM/DD/YYYY h:mm a');
      this.authorizationForm.patchValue(this.submissiondata.authorizationForm);
    }

    if (this.submissiondata.cultureFactorForm) {
      this.cultureFactorForm.patchValue(this.submissiondata.cultureFactorForm);
    }

    if (this.submissiondata.caregiverstrengthform) {
      this.caregiverstrengthform.patchValue(this.submissiondata.caregiverstrengthform);
    }
    if (this.submissiondata.traumaform) {
      this.traumaform.patchValue(this.submissiondata.traumaform);
    }
    if (this.submissiondata.permanencyPlanform) {
      this.permanencyPlanform.patchValue(this.submissiondata.permanencyPlanform);
    }
    if (this.submissiondata.transitionForm) {
      this.transitionForm.patchValue(this.submissiondata.transitionForm);
    }
    if (this.submissiondata.careGiver) {
      this.caregiverFormList = this.submissiondata.careGiver;
    }

    if (this.submissiondata.faceLifeForm && this.submissiondata.faceLifeForm.datearray) {
      this.submissiondata.faceLifeForm.datearray.forEach((element: any) => {
        this.addmeetingdate(element);
      });
    }
  }

  getValidationMessage(controlName: any, displayname: any) {

    if (this.faceLifeForm.controls[controlName].status == 'INVALID') {
      return 'Please Enter value ' + displayname;
    }
  }
  getValidationMessage1(controlName: any, displayname: any) {

    if (this.caregiverstrengthform.controls[controlName].status == 'INVALID') {
      return 'Please Enter value ' + displayname;
    }
  }

  openApprovalModal() {
    const modal = new bootstrap.Modal(document.getElementById('info-popup')!);
    modal.show();
  }

  isReadyForApproval() {
    this.requiredForApproval = true;
    this.faceLifeForm.markAllAsTouched();
    this.childform.markAllAsTouched();
    this.cultureFactorForm.markAllAsTouched();
    this.traumaform.markAllAsTouched();
    this.permanencyPlanform.markAllAsTouched();
    this.caregiverstrengthform.markAllAsTouched();
    this.transitionForm.markAllAsTouched();
    this.incompleteList = [];
    if (!this.faceLifeForm.valid) {
      this.incompleteList.push('FACE SHEET');
    }
    if (!this.childform.valid) {
      this.incompleteList.push('CHILD AND ENVIRONMENT STRENGTHS');
    }
    if (!this.cultureFactorForm.valid) {
      this.incompleteList.push('CULTURAL FACTORS');
    }
    if (!this.traumaform.valid) {
      this.incompleteList.push('TRAUMA');
    }
    this.handleCaregiverNotRequiredFn();
    if (!this.permanencyPlanform.valid) {
      this.incompleteList.push('PERMANENCY PLAN');
    }
    if (!this.transitionForm.valid && this.adultage >= 14) {
      this.incompleteList.push('EMERGING ADULT');
    }
    if (!this.authorizationForm.valid) {
      this.incompleteList.push('APPROVAL');
    }
    if (this.incompleteList.length == 0) {
      this.submitForApproval();
    } else {
      (<any>$('#incomplete-items')).modal('show');// NOSONAR
    }
  }

  private handleCaregiverNotRequiredFn() {
    let caregiverNotRequired = (this.caregiverNotRequiredForm.value.caregivernotapplicable !== null) ? this.caregiverNotRequiredForm.value.caregivernotapplicable : false;
    let caregiverNotRequiredReason = (this.caregiverNotRequiredForm.value.caregiverreason) ? this.caregiverNotRequiredForm.value.caregiverreason : null;
    if (this.caregiverFormList.length > 0) {
      const formStatus = this.caregiverFormList.filter(data => !data.formStatus);
      if (formStatus && formStatus.length > 0) {
        this.incompleteList.push('CURRENT CAREGIVER NEEDS AND STRENGTHS');
      }
    } else if (!caregiverNotRequired || (caregiverNotRequired && !caregiverNotRequiredReason)) {
      this.incompleteList.push('CURRENT CAREGIVER NEEDS AND STRENGTHS');
    }
  }

  prefillauthorizationFormInfo() {
    this.authorizationForm.patchValue({
      supervisorname: this._dataStoreService.getData('da_assignedby'),
      caseworkername: this.roleId.user.userprofile.fullname
    })
    this.faceLifeForm.patchValue({
      caseworkername: this.roleId.user.userprofile.fullname
    });
  }

  patchlegalGaurdian(model: any) {
    if (!(this.cansOOHData && (this.cansOOHData.mode === 'update' || this.cansOOHData.mode === 'submit'))) {
      this.caregiverstrengthform.patchValue({
        firstName: model.firstname,
        lastName: model.lastname,
        relationship: model.relationship
      });

      this.permanencyPlanform.patchValue({
        caregiver: model.personid,
        firstName: model.firstname,
        lastName: model.lastname,
        relationship: model.relationship,
        caregiverII: model.personid,
        firstNameII: model.firstname,
        lastNameII: model.lastname,
        relationshipII: model.relationship
      });
    }
  }

  /**
   * Get caregivers in the case
   */
  getCaregiversInCase() {
    this.caregiversInCase = [];
    this._commonService.getArrayList(
      new PaginationRequest({
        nolimit: true,
        method: 'get',
        where: {
          personid: this.id
        }
      }),
      'Actorrelationships/getallcaregiversincase' + '?filter'
    )
      .subscribe(response => {
        if (response && Array.isArray(response) && response.length && response[0].getallcaregiversincase) {
          this.caregiversInCase = response[0].getallcaregiversincase;
        }
      });
  }

  checkifcaregiver(value: any) {
    this.assignCargiverName(value, 'person');
    //ignoring check for collateral
    if (this.collateralPersons.find(collateral => collateral.intakeservicerequestactorid === value)) {
      return true;
    }
    let cgflag = false;

    const modal = this.involvedPerson.find(data => data.intakeservicerequestactorid === value);

    if (this.caregiversInCase) {
      this.caregiversInCase.forEach(element => {
        if (element.personid == modal.personid) {
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
    if (type === 'person') {
      caregiveinfo = this.caregiverlegalGuardian.find(item => item.intakeservicerequestactorid === modal);
    } else if (type === 'collateral') {
      caregiveinfo = this.listCollateralPerson.find(item => item.collateralid === modal);
    }

    if (caregiveinfo) {
      this.caregiverstrengthform.patchValue({
        ccacaregivername: caregiveinfo.fullname
      });
    }
  }

  getInvolvedPerson() {
    this.legalGuardian = [];
    this.caregiverDdList = [];
    let getpersonlistreq : any;
    let childNameFilterOoh;
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    } else {
      getpersonlistreq = { intakeserviceid: this.id };
    }
    let isExpungementSuperUser= this._authService.isExpungementSuperUser()
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
        this.handleInvolvmentForeachFn();

        this._dataStoreService.setData('PRINTDATA', this.getChildFullNames(this._dataStoreService.getData('PRINTDATA')));
      }
    });
  }

  private handleInvolvmentForeachFn() {
    this.involvedPerson.forEach(item => {
      if (item.roles) {
        this.handleLegalguardianAndCaregiverListFn(item);
      }
    });
  }

  private handleLegalguardianAndCaregiverListFn(item: any) {
    let childNameFilterOoh;
    const legalGurdian = item.roles.filter((roleid: any) => roleid.intakeservicerequestpersontypekey === 'LG');
    const child = item.roles.filter((roleid: any) => roleid.intakeservicerequestpersontypekey === 'CHILD' ||
      roleid.intakeservicerequestpersontypekey === 'AV' ||
      roleid.intakeservicerequestpersontypekey === 'OTHERCHILD');
    childNameFilterOoh = _.isEmpty(item.programarea) ? '' : item.programarea.filter((key: any) => key.programkey === 'OOH');
    if (child && child.length > 0) {
      if ((this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT').mode === "submit") || childNameFilterOoh.length > 0) {
        this.reportedChild.push(item)
      }
    }
    if (legalGurdian && legalGurdian.length) {
      this.legalGuardian.push(item);
    }
    let cg = true;

    item.roles.forEach((role: any) => {
      if (role.intakeservicerequestpersontypekey === 'CHILD'
        || role.intakeservicerequestpersontypekey === 'OTHERCHILD'
        || role.intakeservicerequestpersontypekey === 'AV') {
        cg = false;
      }
    });

    if (cg) {
      this.caregiverDdList.push(item);
    }
  }

  calculateAge(dob: any) {
    if (dob) {
      const age = { years: 0 };
      age.years = (moment().diff(dob, 'years', false)) ? moment().diff(dob, 'years', false) : 0;
      this.adultage = age.years;
    }
  }

  getCareGiverFormPrintData() {
    this.caregiverFormList.forEach(data => {
      data['caregivername'] = this.getCGName(data['caregiverlist']);
    })
    return this.caregiverFormList;
  }

  getCGName(value: any) {
    if (this.involvedPerson) {
      const modal = this.involvedPerson.find(data => data.intakeservicerequestactorid === value);
      return modal ? modal.fullname : '';
    }
    return '';

  }

  getCansoutReq() {
    const authorizationForm = this.authorizationForm.getRawValue();
    if (!this.isSupervisor) {
      authorizationForm.safetyassessmentapprovaldate = moment(new Date()).format('MM/DD/YYYY h:mm a');
    }
    this.transitionForm.patchValue({
      showoldsection: this.showtransition_oldsection
    })
    if (this.showtransition_oldsection === false) {
      this.transitionForm.patchValue({
        literacy_rating: null,
        servlearning_rating: null,
        empoptimism_rating: null,
        volunterexperince_rating: null,
        knwldgeillness_rating: null,
        treatment_rating: null,
        medcompliance_rating: null,
        selfcare_rating: null,
        placementstab_rating: null,
        relationshippermenance_rating: null
      });



    }
    return {
      assessmentactor: this.processActorDetails(),
      faceLifeForm: this.faceLifeForm.getRawValue(),
      childform: this.childform.getRawValue(),
      cultureFactorForm: this.cultureFactorForm.getRawValue(),
      traumaform: this.traumaform.getRawValue(),
      caregiverstrengthform: this.caregiverstrengthform.getRawValue(),
      careGiver: this.getCareGiverFormPrintData(),
      permanencyPlanform: this.permanencyPlanform.getRawValue(),
      transitionForm: this.transitionForm.getRawValue(),
      authorizationForm: authorizationForm,
      supervisorname: this.authorizationForm.get('supervisorname')?.value,
      routingsupervisors: this.routingSupervisors,
      currentSubmissionId: this.currentSubmissionId,
      assessmentStaus: this.assessmentStatus,
      caregivernotapplicable: this.caregiverNotRequiredForm.get('caregivernotapplicable')?.value,
      caregiverreason: this.caregiverNotRequiredForm.get('caregiverreason')?.value,
    }
  }

  processActorDetails() {
    const assessmentactorArray = [];
    const assessmentactor = {
      'intakeservicerequestactorid': this.faceLifeForm && this.faceLifeForm.getRawValue().childname ? this.faceLifeForm.getRawValue().childname : null
    };
    assessmentactorArray.push(assessmentactor);
    return assessmentactorArray;
  }
  saveForm() {
    const cansaoutData = this.getCansoutReq();
    this._dataStoreService.setData('PRINTDATA', this.getChildFullNames(cansaoutData));
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, cansaoutData)
      .subscribe(
        (response) => {
          this._alertService.success('Form saved');
          if (response.data) {
            this.currentAssessmentId = response.data.assessmentid;
            this.currentSubmissionId = response.data.submissionid;
          } else {
            this.currentAssessmentId = response.assessmentid;
            this.currentSubmissionId = response.data.submissionid;
          }
        },
        (error) => {
          this._alertService.error('Unable to save.');
        }

      );
  }

  submitForApproval() {
    if (this.isSupervisor) {
      this.assessmentStatus = this.authorizationForm.get('assessmentstatus')?.value;
    } else {
      this.assessmentStatus = 'Review';
    }
    const submissionData = this.getCansoutReq();
    this._dataStoreService.setData('PRINTDATA', this.getChildFullNames(submissionData));
    this.disableSubmitforAPproval = true;
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe(
        (response) => {
          if (response?.errormessage) {
            this._alertService.warn(response.errormessage);
            return;
          }
          this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
          if (this.assessmentStatus === 'Accepted') {
            this.saveAssessmentStrengthNeeds('cansOutOfHomePlacementService');
          }
          setTimeout(() => {
            this.closePopup();
            this._router.navigate(['../'], { relativeTo: this.route });
          }, 1000);
        },
        (error) => {
          this._alertService.error('Unable to submit for approval.');
        }
      );
  }

  saveAssessmentStrengthNeeds(templatename: any) {
    // How do we handle cans-outofhome?
    const payload = {
      'objectid': this.id,
      'templatename': templatename,
      'status': 'accepted'
    };
    this._commonService.create(payload, 'serviceplan/saveAssessmentStrengthNeeds').subscribe();
  }

  changeSupervisor(userid: any) {
    const user = this.routingSupervisors.find((item: any) => item.userid === userid);
    if (user.username) {
      this.authorizationForm.patchValue({
        supervisorname: user.username
      });
    }
  }
  getInvolvedPersonWithPersonID(page: number, limit: number, personid: string) {

    return this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: limit,
          method: 'get',
          where: {
            personid: personid
          }
        }),
        'Actorrelationships/getcaregiverdetail?filter'
      );
  }

  selectAge(value: any) {
    const user = this.reportedChild.find(item => item.intakeservicerequestactorid === value);
    this.selectedChildPersonId = user.personid;
    if (user.age) {
      this.faceLifeForm.patchValue({
        age: user.age
      });
      this.adultage = moment().diff(user?.dob, 'years');
    }

    this.getInvolvedPersonWithPersonID(1, 20, this.selectedChildPersonId)
      .subscribe(response => {
        if (response && Array.isArray(response)) {
          this.permanencyPlanform.patchValue({
            firstName: '',
            lastName: '',
            relationship: ''
          });
        }
      });
  }

  addmeetingdate(modal: any) {
    const control = <FormArray>this.faceLifeForm.controls['datearray'];
    control.push(this.createFormGroup(modal));
  }
  deletemeetingdate(index: number) {
    const control = <FormArray>this.faceLifeForm.controls['datearray'];
    control.removeAt(index);
  }
  private createFormGroup(modal: any) {
    return this._formBuilder.group({
      meetingdate: modal.meetingdate ? modal.meetingdate : null
    });
  }
  addMedicalmodule() {
    const medicalList = ['Life Threat', 'Chronicity', 'Diagnostic Complexity', 'Emotional Response', 'Impairment in Functioning', 'Treatment Involvement', 'Family Stress', 'Intensity of Treatment', 'Organizational Complexity'];
    medicalList.forEach((data, index) => {
      (this.faceLifeForm.get('medicalmodule') as FormArray).push(this._formBuilder.group({
        id: index,
        label: data,
        value: ['0'],
        comment: null
      }))
    })
  }
  addChilSubModule() {
    const sexualaggressionlist = ['Relationship', 'Physical Force/Threat', 'Planning', 'Age Differential', 'Type of Sex Act', 'Respone to Accusation', 'Temporal Consistency', 'History of Sexual Behavior', 'Severity of Sexual Abuse', 'Prior Treatment']
    const runawaylist = ['Frequencey of Running', 'Consistancy of Destination', 'Safety of Destination', 'Involvement in Illegal Activities', 'Likelhood of Return on Own', 'Involvement of Others', 'Realistic Expectations', 'Planning']
    const firesettinglist = ['Seriousness', 'History', 'Planning', 'Use of accelerants', 'Intention to harm', 'Community Safety', 'Response to Accusation', 'Remorse', 'Likelhood of future fires']
    const substanceAbuseList = ['Severity of Use', 'Duration of Use', 'Stage of Recovery', 'Peer Influences', 'Parental Influences', 'Environmental Influences']

    substanceAbuseList.forEach((data, index) => {
      (this.childform.get('substanceabusemodule') as FormArray).push(this._formBuilder.group({
        id: index,
        label: data,
        value: ['0'],
        comment: null
      }))
    })
    sexualaggressionlist.forEach((data, index) => {
      (this.childform.get('sexualabusemodule') as FormArray).push(this._formBuilder.group({
        id: index,
        label: data,
        value: ['0'],
        comment: null
      }))
    })
    runawaylist.forEach((data, index) => {
      (this.childform.get('runawaymodule') as FormArray).push(this._formBuilder.group({
        id: index,
        label: data,
        value: ['0'],
        comment: null
      }))
    })
    firesettinglist.forEach((data, index) => {
      (this.childform.get('firesettingmodule') as FormArray).push(this._formBuilder.group({
        id: index,
        label: data,
        value: ['0'],
        comment: null
      }))
    })
  }
  inintailizeForm() {
    this.faceLifeForm = this._formBuilder.group({
      assessmenttype: null,
      childname: null,
      age: null,
      caseworkername: null,
      family_rating: ['0'],
      family_comments: null,
      livingsitu_rating: ['0'],
      livingsitu_strength: null,
      livingsitu_comments: null,
      socialpeer_rating: ['0'],
      socialpeer_strength: null,
      socialpeer_comments: null,
      socialadult_rating: ['0'],
      socialadult_strength: null,
      socialadult_comments: null,
      juvenilejustice_rating: ['0'],
      juvenilejustice_comments: null,
      medphy_rating: ['0'],
      medphy_strength: null,
      medphy_comments: null,
      enuresis_rating: ['0'],
      enuresis_strength: null,
      enuresis_comments: null,
      sleeping_rating: ['0'],
      sleeping_strength: null,
      sleeping_comments: null,
      iq_rating: ['0'],
      iq_strength: null,
      iq_comments: null,
      autism_rating: ['0'],
      autism_strength: null,
      autism_comments: null,
      recreation_rating: ['0'],
      recreation_strength: null,
      recreation_comments: null,
      legal_rating: ['0'],
      legal_strength: null,
      legal_comments: null,
      judgement_rating: ['0'],
      judgement_strength: null,
      judgement_comments: null,
      sexual_rating: ['0'],
      sexual_strength: null,
      sexual_comments: null,
      jobfun_rating: ['0'],
      jobfun_strength: null,
      jobfun_comments: null,
      schoolatd_rating: ['0'],
      schoolatd_strength: null,
      schoolatd_comments: null,
      schoolacheive_rating: ['0'],
      schoolacheive_strength: null,
      schoolacheive_comments: null,
      schoolbehave_rating: ['0'],
      schoolbehave_strength: null,
      schoolbehave_comments: null,
      dateassessmentinitiated: [new Date(), Validators.required]
    });

    setTimeout(() => {
      const ctrl = this.faceLifeForm.get('dateassessmentinitiated');
      ctrl?.updateValueAndValidity({ emitEvent: true });
      this.onPickerClosed('','dateassessmentinitiated');
    });

    this.faceLifeForm.setControl('datearray', this._formBuilder.array([]));
    this.faceLifeForm.setControl('medicalmodule', this._formBuilder.array([]));
    this.addMedicalmodule()
    this.childform = this._formBuilder.group({
      familyenv_rating: ['3'],
      familyenv_strength: null,
      familyenv_comments: null,
      eduenv_rating: ['3'],
      eduenv_strength: null,
      eduenv_comments: null,
      religious_rating: ['3'],
      religious_strength: null,
      religious_comments: null,
      community_rating: ['3'],
      community_strength: null,
      community_comments: null,
      relperformance_rating: ['3'],
      relperformance_strength: null,
      relperformance_comments: null,
      natural_rating: ['3'],
      natural_strength: null,
      natural_comments: null,
      interperson_rating: ['3'],
      interperson_strength: null,
      interperson_comments: null,
      interpersonnoncare_rating: ['3'],
      interpersonnoncare_strength: null,
      interpersonnoncare_comments: null,
      optimism_rating: ['3'],
      optimism_strength: null,
      optimism_comments: null,
      talent_rating: ['3'],
      talent_strength: null,
      talent_comments: null,
      culture_rating: ['3'],
      culture_strength: null,
      culture_comments: null,
      careplanning_rating: ['3'],
      careplanning_strength: null,
      careplanning_comments: null,
      resiliency_rating: ['3'],
      resiliency_strength: null,
      resiliency_comments: null,
      vocational_rating: ['3'],
      vocational_strength: null,
      vocational_comments: null,
      resourcefulness_rating: ['3'],
      resourcefulness_strength: null,
      resourcefulness_comments: null,
      psychosis_rating: ['0'],
      psychosis_strength: null,
      psychosis_comments: null,
      impulse_rating: ['0'],
      impulse_strength: null,
      impulse_comments: null,
      mood_rating: ['0'],
      mood_strength: null,
      mood_comments: null,
      anxiety_rating: ['0'],
      anxiety_strength: null,
      anxiety_comments: null,
      opposition_rating: ['0'],
      opposition_strength: null,
      opposition_comments: null,
      conduct_rating: ['0'],
      conduct_strength: null,
      conduct_comments: null,
      substanceabuse_rating: ['0'],
      substanceabuse_strength: null,
      substanceabuse_comments: null,
      eating_rating: ['0'],
      eating_strength: null,
      eating_comments: null,
      angermang_rating: ['0'],
      angermang_strength: null,
      angermang_comments: null,
      attchment_rating: ['0'],
      attchment_strength: null,
      attchment_comments: null,
      adjtrauma_rating: ['0'],
      adjtrauma_strength: null,
      adjtrauma_comments: null,
      suicide_rating: ['0'],
      suicide_strength: null,
      suicide_comments: null,
      selfinjury_rating: ['0'],
      selfinjury_strength: null,
      selfinjury_comments: null,
      reckless_rating: ['0'],
      reckless_strength: null,
      reckless_comments: null,
      dangertoother_rating: ['0'],
      dangertoother_strength: null,
      dangertoother_comments: null,
      sexaggress_rating: ['0'],
      sexaggress_strength: null,
      sexaggress_comments: null,
      sexreact_rating: ['0'],
      sexreact_strength: null,
      sexreact_comments: null,
      runaway_rating: ['0'],
      runaway_strength: null,
      runaway_comments: null,
      deliquent_rating: ['0'],
      deliquent_strength: null,
      deliquent_comments: null,
      fire_rating: ['0'],
      fire_strength: null,
      fire_comments: null,
      intentional_rating: ['0'],
      intentional_strength: null,
      intentional_comments: null,
      bullying_rating: ['0'],
      bullying_strength: null,
      bullying_comments: null,
      exploited_rating: ['0'],
      exploited_strength: null,
      exploited_comments: null
    });
    this.childform.setControl('sexualabusemodule', this._formBuilder.array([]));
    this.childform.setControl('runawaymodule', this._formBuilder.array([]));
    this.childform.setControl('firesettingmodule', this._formBuilder.array([]));
    this.childform.setControl('substanceabusemodule', this._formBuilder.array([]));
    this.addChilSubModule();

    this.cultureFactorForm = this._formBuilder.group({
      language_rating: ['0'],
      language_strength: null,
      language_comments: null,
      ritual_rating: ['0'],
      ritual_strength: null,
      ritual_comments: null,
      genderidentity_rating: ['0'],
      genderidentity_strength: null,
      genderidentity_comments: null,
      culturestress_rating: ['0'],
      culturestress_strength: null,
      culturestress_comments: null,
      _rating: null,
      _strength: null,
      _comments: null

    });

    this.traumaform = this._formBuilder.group({
      sexsbuse_rating: ['0'],
      sexsbuse_strength: null,
      sexsbuse_comments: null,
      phyabuse_rating: ['0'],
      phyabuse_strength: null,
      phyabuse_comments: null,
      emotionalabuse_rating: ['0'],
      emotionalabuse_strength: null,
      emotionalabuse_comments: null,
      neglect_rating: ['0'],
      neglect_strength: null,
      neglect_comments: null,
      medicaltrauma_rating: ['0'],
      medicaltrauma_strength: null,
      medicaltrauma_comments: null,
      familywitness_rating: ['0'],
      familywitness_strength: null,
      familywitness_comments: null,
      communityvoilance_rating: ['0'],
      communityvoilance_strength: null,
      communityvoilance_comments: null,
      schoolvoilance_rating: ['0'],
      schoolvoilance_strength: null,
      schoolvoilance_comments: null,
      naturaldisaster_rating: ['0'],
      naturaldisaster_strength: null,
      naturaldisaster_comments: null,
      waraffected_rating: ['0'],
      waraffected_strength: null,
      waraffected_comments: null,
      terroraffected_rating: ['0'],
      terroraffected_strength: null,
      terroraffected_comments: null,
      criminalactivity_rating: ['0'],
      criminalactivity_strength: null,
      criminalactivity_comments: null,
      disruptions_rating: ['0'],
      disruptions_strength: null,
      disruptions_comments: null,
      traumagrief_rating: ['0'],
      traumagrief_strength: null,
      traumagrief_comments: null,
      reexperiancing_rating: ['0'],
      reexperiancing_strength: null,
      reexperiancing_comments: null,
      avoidance_rating: ['0'],
      avoidance_strength: null,
      avoidance_comments: null,
      numbering_rating: ['0'],
      numbering_strength: null,
      numbering_comments: null,
      dysregulation_rating: ['0'],
      dysregulation_strength: null,
      dysregulation_comments: null,
      dissociation_rating: ['0'],
      dissociation_strength: null,
      dissociation_comments: null
    });
    this.permanencyPlanform = this._formBuilder.group({
      firstName: null,
      lastName: null,
      relationship: null,
      supervision_rating: ['0'],
      supervision_strength: [''],
      supervision_comments: null,
      involvement_rating: ['0'],
      involvement_strength: [''],
      involvement_comments: null,
      knowledge_rating: ['0'],
      knowledge_strength: [''],
      knowledge_comments: null,
      organization_rating: ['0'],
      organization_strength: [''],
      organization_comments: null,
      resource_rating: ['0'],
      resource_strength: [''],
      resource_comments: null,
      difficulties_rating: ['0'],
      difficulties_strength: null,
      difficulties_comments: null,
      assebilitycare_rating: ['0'],
      assebilitycare_strength: null,
      assebilitycare_comments: null,
      stablity_rating: ['0'],
      stablity_strength: null,
      stablity_comments: null,
      familystress_rating: ['0'],
      familystress_strength: null,
      familystress_comments: null,
      safety_rating: ['0'],
      safety_strength: null,
      safety_comments: null,
      phyhealth_rating: ['0'],
      phyhealth_strength: null,
      phyhealth_comments: null,
      mentalhealth_rating: ['0'],
      mentalhealth_strength: null,
      mentalhealth_comments: null,
      substanceuse_rating: ['0'],
      substanceuse_strength: null,
      substanceuse_comments: null,
      developmental_rating: ['0'],
      developmental_strength: null,
      developmental_comments: null,
      marital_rating: ['0'],
      marital_strength: null,
      marital_comments: null,
      traumatic_rating: ['0'],
      traumatic_strength: null,
      traumatic_comments: null,
      criminal_rating: ['0'],
      criminal_strength: null,
      criminal_comments: null,
      firstNameII: null,
      lastNameII: null,
      relationshipII: null,
      supervision_ratingII: ['0'],
      supervision_strengthII: null,
      supervision_commentsII: null,
      involvement_ratingII: ['0'],
      involvement_strengthII: null,
      involvement_commentsII: null,
      knowledge_ratingII: ['0'],
      knowledge_strengthII: null,
      knowledge_commentsII: null,
      organization_ratingII: ['0'],
      organization_strengthII: null,
      organization_commentsII: null,
      resource_ratingII: ['0'],
      resource_strengthII: null,
      resource_commentsII: null,
      difficulties_ratingII: ['0'],
      difficulties_strengthII: null,
      difficulties_commentsII: null,
      assebilitycare_ratingII: ['0'],
      assebilitycare_strengthII: null,
      assebilitycare_commentsII: null,
      stablity_ratingII: ['0'],
      stablity_strengthII: null,
      stablity_commentsII: null,
      familystress_ratingII: ['0'],
      familystress_strengthII: null,
      familystress_commentsII: null,
      safety_ratingII: ['0'],
      safety_strengthII: null,
      safety_commentsII: null,
      phyhealth_ratingII: ['0'],
      phyhealth_strengthII: null,
      phyhealth_commentsII: null,
      mentalhealth_ratingII: ['0'],
      mentalhealth_strengthII: null,
      mentalhealth_commentsII: null,
      substanceuse_ratingII: ['0'],
      substanceuse_strengthII: null,
      substanceuse_commentsII: null,
      developmental_ratingII: ['0'],
      developmental_strengthII: null,
      developmental_commentsII: null,
      marital_ratingII: ['0'],
      marital_strengthII: null,
      marital_commentsII: null,
      traumatic_ratingII: ['0'],
      traumatic_strengthII: null,
      traumatic_commentsII: null,
      criminal_ratingII: ['0'],
      criminal_strengthII: null,
      criminal_commentsII: null,
      caregiver: null,
      caregiverII: null

    });

    this.transitionForm = this._formBuilder.group({
      showoldsection: null,
      literacy_rating: ['0'],
      literacy_strength: null,
      literacy_comments: null,
      servlearning_rating: ['0'],
      servlearning_strength: null,
      servlearning_comments: null,
      empoptimism_rating: ['0'],
      empoptimism_strength: null,
      empoptimism_comments: null,
      volunterexperince_rating: ['0'],
      volunterexperince_strength: null,
      volunterexperince_comments: null,
      knwldgeillness_rating: ['0'],
      knwldgeillness_strength: null,
      knwldgeillness_comments: null,
      treatment_rating: ['0'],
      treatment_strength: null,
      treatment_comments: null,
      medcompliance_rating: ['0'],
      medcompliance_strength: null,
      medcompliance_comments: null,
      selfcare_rating: ['0'],
      selfcare_strength: null,
      selfcare_comments: null,
      placementstab_rating: ['0'],
      placementstab_strength: null,
      placementstab_comments: null,
      relationshippermenance_rating: ['0'],
      relationshippermenance_strength: null,
      relationshippermenance_comments: null,

      servlearningii_rating: ['0'],
      servlearningii_strength: null,
      servlearningii_comments: null,
      eduattainmentii_rating: ['0'],
      eduattainmentii_strength: null,
      eduattainmentii_comments: null,
      etvii_rating: ['0'],
      etvii_strength: null,
      etvii_comments: null,
      optimismii_rating: ['0'],
      optimismii_strength: null,
      optimismii_comments: null,
      workexpii_rating: ['0'],
      workexpii_strength: null,
      workexpii_comments: null,
      illnessii_rating: ['0'],
      illnessii_strength: null,
      illnessii_comments: null,
      treatmentii_rating: ['0'],
      treatmentii_strength: null,
      treatmentii_comments: null,
      medcomplianceii_rating: ['0'],
      medcomplianceii_strength: null,
      medcomplianceii_comments: null,
      selfcareii_rating: ['0'],
      selfcareii_strength: null,
      selfcareii_comments: null,
      stabilityii_rating: ['0'],
      stabilityii_strength: null,
      stabilityii_comments: null,
      indpendentii_rating: ['0'],
      indpendentii_strength: null,
      indpendentii_comments: null,
      consumerii_rating: ['0'],
      consumerii_strength: null,
      consumerii_comments: null,
      budgetingii_rating: ['0'],
      budgetingii_strength: null,
      budgetingii_comments: null,
      vitualii_rating: ['0'],
      vitualii_strength: null,
      vitualii_comments: null,
      resourceii_rating: ['0'],
      resourceii_strength: null,
      resourceii_comments: null,
      intimateii_rating: ['0'],
      intimateii_strength: null,
      intimateii_comments: null,


      attainmentiii_rating: ['0'],
      attainmentiii_strength: null,
      attainmentiii_comments: null,
      posteduiii_rating: ['0'],
      posteduiii_strength: null,
      posteduiii_comments: null,
      optimismiii_rating: ['0'],
      optimismiii_strength: null,
      optimismiii_comments: null,
      workexpiii_rating: ['0'],
      workexpiii_strength: null,
      workexpiii_comments: null,
      trainingiii_rating: ['0'],
      trainingiii_strength: null,
      trainingiii_comments: null,
      illnessiii_rating: ['0'],
      illnessiii_strength: null,
      illnessiii_comments: null,
      treatmentiii_rating: ['0'],
      treatmentiii_strength: null,
      treatmentiii_comments: null,
      medcomplianceiii_rating: ['0'],
      medcomplianceiii_strength: null,
      medcomplianceiii_comments: null,
      adultserviceiii_rating: ['0'],
      adultserviceiii_strength: null,
      adultserviceiii_comments: null,
      selfcareiii_rating: ['0'],
      selfcareiii_strength: null,
      selfcareiii_comments: null,
      placementstabilityiii_rating: ['0'],
      placementstabilityiii_strength: null,
      placementstabilityiii_comments: null,
      livingskillsiii_rating: ['0'],
      livingskillsiii_strength: null,
      livingskillsiii_comments: null,
      consumeriii_rating: ['0'],
      consumeriii_strength: null,
      consumeriii_comments: null,
      budgetingiii_rating: ['0'],
      budgetingiii_strength: null,
      budgetingiii_comments: null,
      vitaliii_rating: ['0'],
      vitaliii_strength: null,
      vitaliii_comments: null,
      resourceiii_rating: ['0'],
      resourceiii_strength: null,
      resourceiii_comments: null,
      relationshipiii_rating: ['0'],
      relationshipiii_strength: null,
      relationshipiii_comments: null,
      intimatereliii_rating: ['0'],
      intimatereliii_strength: null,
      intimatereliii_comments: null,

      literacyiv_rating: ['0'],
      literacyiv_strength: null,
      literacyiv_comments: null,
      servlearningiv_rating: ['0'],
      servlearningiv_strength: null,
      servlearningiv_comments: null,
      attainmentiv_rating: ['0'],
      attainmentiv_strength: null,
      attainmentiv_comments: null,
      etviv_rating: ['0'],
      etviv_strength: null,
      etviv_comments: null,
      posteduiv_rating: ['0'],
      posteduiv_strength: null,
      posteduiv_comments: null,
      optimismiv_rating: ['0'],
      optimismiv_strength: null,
      optimismiv_comments: null,
      internshipiv_rating: ['0'],
      internshipiv_strength: null,
      internshipiv_comments: null,
      workexpiv_rating: ['0'],
      workexpiv_strength: null,
      workexpiv_comments: null,
      trainingiv_rating: ['0'],
      trainingiv_strength: null,
      trainingiv_comments: null,

      healthneedsv_rating: ['0'],
      healthneedsv_strength: null,
      healthneedsv_comments: null,
      treatcomplexv_rating: ['0'],
      treatcomplexv_strength: null,
      treatcomplexv_comments: null,
      medicationv_rating: ['0'],
      medicationv_strength: null,
      medicationv_comments: null,
      adultservicev_rating: ['0'],
      adultservicev_strength: null,
      adultservicev_comments: null,
      civicengv_rating: ['0'],
      civicengv_strength: null,
      civicengv_comments: null,

      selfcarevi_rating: ['0'],
      selfcarevi_strength: null,
      selfcarevi_comments: null,
      stabilityvi_rating: ['0'],
      stabilityvi_strength: null,
      stabilityvi_comments: null,
      livingskillsvi_rating: ['0'],
      livingskillsvi_strength: null,
      livingskillsvi_comments: null,

      consumervii_rating: ['0'],
      consumervii_strength: null,
      consumervii_comments: null,
      budgetingvii_rating: ['0'],
      budgetingvii_strength: null,
      budgetingvii_comments: null,
      vitalvii_rating: ['0'],
      vitalvii_strength: null,
      vitalvii_comments: null,
      resourceidentivii_rating: ['0'],
      resourceidentivii_strength: null,
      resourceidentivii_comments: null,


      socialpeerviii_rating: ['0'],
      socialpeerviii_strength: null,
      socialpeerviii_comments: null,
      intimateviii_rating: ['0'],
      intimateviii_strength: null,
      intimateviii_comments: null,
      permenanceviii_rating: ['0'],
      permenanceviii_strength: null,
      permenanceviii_comments: null

    });

    this.authorizationForm = this._formBuilder.group({
      assessmentstatus: [null],
      routingsupervisors: [null],
      supervisorname: [null],
      caseworkername: [null],
      caseworkercomments: [null],
      caseworkersignature: [null],
      supervisorrsignature: [null],
      safetyassessmentapprovaldate: [{ value: null, disabled: true }]
    });

    this.faceLifeForm.get('caseworkername')?.disable();
    this.permanencyPlanform.get('firstName')?.disable();
    this.permanencyPlanform.get('lastName')?.disable();
    this.permanencyPlanform.get('relationship')?.disable();
    this.permanencyPlanform.get('firstNameII')?.disable();
    this.permanencyPlanform.get('lastNameII')?.disable();
    this.permanencyPlanform.get('relationshipII')?.disable();
  }
  getcgFirstLastName(value: any) {
    this.permanencyPlanform.patchValue({
      firstName: null,
      lastName: null,
      relationship: null
    });
    if (!this.validateCaregiver("caregiver")) {
      return;
    }
    const name = this.caregiversInCase.find(item => item.personid === value);
    const involvedPerson = this.involvedPerson.filter(item => item.personid == value)[0];
    var relation = 'No Relation';
    if (involvedPerson && this.selectedChildPersonId && involvedPerson.relationshiparray && involvedPerson.relationshiparray.length > 0) {
      involvedPerson.relationshiparray.forEach((relationship: any) => {
        if (relationship.secondaryuserid === involvedPerson.personid
          && relationship.primaryuserid === this.selectedChildPersonId) {
          relation = relationship.description;
        }
      });
    }

    if (name) {
      this.permanencyPlanform.patchValue({
        firstName: name.firstname,
        lastName: name.lastname,
        relationship: relation
      });
    }
  }
  getcgFirstLastNameII(value: any) {
    this.permanencyPlanform.patchValue({
      firstNameII: null,
      lastNameII: null,
      relationshipII: null
    });
    if (!this.validateCaregiver("caregiverII")) {
      return;
    }

    const name = this.caregiversInCase.find(item => item.personid === value);
    var relation = 'No Relation';
    if (name) {
      this.permanencyPlanform.patchValue({
        firstNameII: name.firstname,
        lastNameII: name.lastname,
        relationshipII: relation
      });
    }
  }

  validateCaregiver(controlName: any) {
    const caregiver = this.permanencyPlanform.get("caregiver")?.value;
    const caregiverII = this.permanencyPlanform.get("caregiverII")?.value;

    if (caregiver === caregiverII) {

      //reset value if duplicate
      this.permanencyPlanform.get(controlName)?.setValue(null);

      this._alertService.error('Duplicate Caregiver not allowed.');

      return false;
    }

    return true;
  }

  getcollateral() {
    if (this.collateralPersons && this.collateralPersons.length == 0) {
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
      ).subscribe(res => {
        if (res && res.length && res[0].getcollateraldetails && res[0].getcollateraldetails.length) {
          const fosterParents = this.handleFosterParentsFn(res);
          if (fosterParents && fosterParents.length) {
            this.collateralPersons = fosterParents;
          }
        }
      });
    }
  }

  private handleFosterParentsFn(res: any[]) {
    return res[0].getcollateraldetails.filter((collateral: any) => {
      if (collateral.collateralroleconfig && collateral.collateralroleconfig.length) {
        if (collateral.collateralroleconfig.filter((role: any) => role.actortypekey === 'FOPA').length) {
          collateral.intakeservicerequestactorid = collateral.collateralid;
          collateral.personid = collateral.collateralid;
          collateral.iscollateral = true;
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    });
  }

  showEditCareGiver(mode: number, model: any, index: any) {
    this.listCollateralPersonFormList = this.listCollateralPerson;
    if (mode === 2) {
      this.caregiverFormList.splice(index, 1);
      this.removeAddedlegals();
      return true;
    }
    if (mode === 3) {
      this.removeAddedlegals();
    }
    this.caregiverstrengthform.enable();
    this.showCareGiver = true;
    this.caregiverMode = mode;
    if (model) {
      this.caregiverlegalGuardian = this.caregiverDdList;
      this.caregiverstrengthform.patchValue(model);
      this.caregiverstrengthform.setControl('contactcaregivers', this._formBuilder.array([]));
      if (this.submissiondata) { //Non-migrated data caregiver contact
        if (model.contactcaregivers && model.contactcaregivers.length > 0) {
          model.contactcaregivers.forEach((data: any) => {
            this.addcaregiverContact(data);
          });
        }
      }
      this.caregiverindex = index;
      if (mode === 0) {
        this.caregiverstrengthform.disable();
      }
    } else {
      this.caregiverstrengthform.reset();
      this.initializeCaregiverForm();
    }
  }

  addcaregiverContact(modal: any) {
    const control = <FormArray>this.caregiverstrengthform.controls['contactcaregivers'];
    control.push(this.createcareGiver(modal));
  }
  deletecaregiverContact(index: number) {
    const control = <FormArray>this.caregiverstrengthform.controls['contactcaregivers'];
    control.removeAt(index);
  }

  saveCaregiverAsNotApplicable() {
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

  private createcareGiver(modal: any) {
    return this._formBuilder.group({
      name: modal.name ? modal.name : null,
      address: modal.address ? modal.address : null,
      phoneno: modal.phoneno ? modal.phoneno : null,
      relationship: modal.relationship ? modal.relationship : null
    });
  }

  loadCaregiverList() {
    this.initializeCaregiverForm();
    this.caregiverlegalGuardian = this.caregiverDdList;
    if (this.collateralPersons && this.collateralPersons.length) {
      this.caregiverlegalGuardian.push(...this.collateralPersons);
    }
    let assessmentData = this._dataStoreService.getData('PRINTDATA')
    if (assessmentData && assessmentData.caregivernotapplicable && assessmentData.caregivernotapplicable === true) {
      this.caregiverNotRequiredForm.patchValue({
        caregivernotapplicable: assessmentData.caregivernotapplicable,
        caregiverreason: assessmentData.caregiverreason,
      })
    }
    if (this.caregiverlegalGuardian && this.caregiverlegalGuardian.length > 0) {
      this.caregiverlegalGuardian.forEach(data => {
        this.caregiverlegalGuardianName[data.intakeservicerequestactorid] = data.fullname;
      });
    }
    this.removeAddedlegals();
    this.showCareGiver = false;
  }

  initializeCaregiverForm() {
    this.caregiverstrengthform = this._formBuilder.group({
      caregiverlist: [null],
      collaterallist: [null],
      firstName: null,
      lastName: null,
      relationship: null,
      supervision_rating: ['0'],
      supervision_strength: [''],
      supervision_comments: null,
      involvement_rating: ['0'],
      involvement_strength: [''],
      involvement_comments: null,
      knowledge_rating: ['0'],
      knowledge_strength: [''],
      knowledge_comments: null,
      organization_rating: ['0'],
      organization_strength: [''],
      organization_comments: null,
      resource_rating: ['0'],
      resource_strength: [''],
      resource_comments: null,
      difficulties_rating: ['0'],
      difficulties_strength: null,
      difficulties_comments: null,
      assessablity_rating: ['0'],
      assessablity_strength: null,
      assessablity_comments: null,
      stability_rating: ['0'],
      stability_strength: null,
      stability_comments: null,
      familystress_rating: ['0'],
      familystress_strength: null,
      familystress_comments: null,
      safety_rating: ['0'],
      safety_strength: null,
      safety_comments: null,
      phyhealth_rating: ['0'],
      phyhealth_strength: null,
      phyhealth_comments: null,
      mentalhealth_rating: ['0'],
      mentalhealth_strength: null,
      mentalhealth_comments: null,
      substanceuse_rating: ['0'],
      substanceuse_strength: null,
      substanceuse_comments: null,
      developmental_rating: ['0'],
      developmental_strength: null,
      developmental_comments: null,
      marital_rating: ['0'],
      marital_strength: null,
      marital_comments: null,
      posttraumatic_rating: ['0'],
      posttraumatic_strength: null,
      posttraumatic_comments: null,
      criminalbehav_rating: ['0'],
      criminalbehav_strength: null,
      criminalbehav_comments: null,
      ccacaregivername: [null],
    });
    this.caregiverstrengthform.setControl('contactcaregivers', this._formBuilder.array([]));

    this.caregiverNotRequiredForm = this._formBuilder.group({
      caregivernotapplicable: [null],
      caregiverreason: [null]
    });

  }
  saveCaregiver() {
    const caregiverstrengthform = this.caregiverstrengthform.getRawValue();
    caregiverstrengthform.formStatus = this.caregiverstrengthform.valid;
    if (this.caregiverMode && this.caregiverMode === 1 && this.caregiverindex != null) {
      this.caregiverFormList[this.caregiverindex] = caregiverstrengthform;
    } else {
      this.caregiverFormList.push(caregiverstrengthform);
    }
    this.showCareGiver = false;
    this.removeAddedlegals();
    this.saveForm();
  }

  cancelCareGiver() {
    this.showCareGiver = false;
  }

  getChildFullNames(data: any) {
    if (data && data.faceLifeForm) {
      const child = this.reportedChild.find(child1 => child1.intakeservicerequestactorid === data.faceLifeForm.childname);
      if (child)
        data.faceLifeForm.childfullname = child.fullname;
    }
    return data;
  }

  getCaregiverCollateral() {
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
          element.collateralroleconfig.map((item: any) => {
            if (item.description === 'Caretaker-Caregiver') {
              this.listCollateralPerson.push({
                collateralid: element.collateralid,
                fullname: element.fullname,
                persontype: 'collateral'
              })
            }
          })
        })


      } else {
        this.listCollateralPerson = [];
      }
    });
  }

  getCollateralPersonName(collateralid: any) {
    let colinfo = this.listCollateralPerson.find(data => data.collateralid === collateralid);
    return colinfo ? colinfo.fullname : null;
  }

  cancelCansfCareGiver(item: any) {
    if (item.checked) {
      this.cancelCareGiver();
    }
  }

  closePopup() {
    // (<any>$('#info-popup')).modal('hide');
    const modalInstance: any = bootstrap.Modal.getInstance(document.getElementById('info-popup'));
    modalInstance?.hide();
  }

  getChildformData(name: string): any[] {
    return Object.values((this.childform.get(name) as FormGroup).controls);
  }

  getFaceLifeFormData(name: string): any[] {
      return Object.values(
          (this.faceLifeForm.get(name) as FormGroup).controls
      );
  }

  openPicker(picker: any) {
    if(picker === 'picker1') {
      this.picker1.open();
    }
  }

  onPickerClosed(event: any, controlName: string) {
    const control: any = this.faceLifeForm.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }

}
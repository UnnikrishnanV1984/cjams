import { Component, OnInit, Injector, ChangeDetectorRef, ChangeDetectionStrategy, ViewChild } from '@angular/core';
import { ListDataItem, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { ActivatedRoute, Router } from '@angular/router';
import { isCaseUuid } from '../../../../../@core/common/initializer';
import { GenericService, CommonHttpService, DataStoreService, SessionStorageService, CommonDropdownsService, AlertService, AuthService } from '../../../../../@core/services';
import { HttpService } from '../../../../../@core/services/http.service';
import { DomSanitizer } from '@angular/platform-browser';
import { Assessments, RoutingInfo } from '../../../_entities/caseworker.data.model';
import { FormBuilder, FormGroup, FormArray, Validators, ReactiveFormsModule, FormsModule } from '@angular/forms';
import { AssessmentService } from '../assessment.service';
import moment from 'moment';
import { OWL_DATE_TIME_FORMATS, OwlDateTimeComponent, OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { GlobalPopupComponent } from '../../../../../shared/shared-components/global-popup/global-popup.component';
import { GlobalPopupModule } from '../../../../../shared/shared-components/global-popup/global-popup.module';
import { ApprovalHistoryModule } from '../../../../../shared/shared-components/approval-history/approval-history.module';
import { MatRadioModule } from '@angular/material/radio';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { CommonModule } from '@angular/common';
import { MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { AssessmentContactPurposeComponent } from '../assessment-contact-purpose/assessment-contact-purpose.component';
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
    selector: 'assessment-mfira',
    templateUrl: './assessment-mfira.component.html',
    styleUrls: ['./assessment-mfira.component.scss'],
    imports:[GlobalPopupModule,ApprovalHistoryModule,MatRadioModule,MatCheckboxModule,MatFormFieldModule,MatInputModule,SignatureFieldModule,CommonModule,OwlDateTimeModule, OwlNativeDateTimeModule,OwlMomentDateTimeModule,MatSelectModule,ReactiveFormsModule,MatDatepickerModule,AssessmentContactPurposeComponent,FormsModule],
    providers:[provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: true
})
export class AssessmentMfiraComponent implements OnInit {
  @ViewChild('picker21') picker21!: OwlDateTimeComponent<any>;
  @ViewChild('picker11') picker11!: OwlDateTimeComponent<any>;
  @ViewChild(GlobalPopupComponent) globalPopupRef!: GlobalPopupComponent;
  ASSESSMENT_NAME = 'MFIRA';
  submissiondata: any;
  involvedPerson: any[] = [];
  isServiceCase: any;
  roleId!: AppUser;
  agency!: string;
  isCW!: boolean;
  id: any;
  daNumber: any;
  currentAssessmentId: any;
  currentSubmissionId!: string;
  mifraData: any;
  updateMifra!: boolean;
  viewMifra!: boolean;
  headofhouseholdid!: string;
  assessmentInitDate: any;
  relationships: any;
  //Approval and routing
  routingSupervisors: any[] = [];
  routingInfo!: RoutingInfo[];
  authorizationApproval!: FormGroup;
  familyHOUSEHOLD!: FormGroup;
  supplementaryApproval!: FormGroup;
  scoringandoverride!: FormGroup;
  NeglectAbuse!: FormGroup;
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
  deceasedChildName: any;
  dodOfDeceasedChild: any;
  currentDate!: Date;
  childList: any[] = [];
  isValue: number = 1;
  currentdatetime = moment();
  contactNotes: any;
  //Caregivers
  caregiversInCase: any[] = [];
  checkmandatory!: boolean;
  dtformat = 'MM/DD/YYYY h:mm a';
  ischildfatality = false;
  isseriousphysicalinjury = false;
  ismaltreatment = false;
  form1080bData: any[] = [];
  form1080bAlertMessage!: string;
  intakesdmproviderlength : any;
  sdmData : any;
  iscaseexpunged: any = 0;

  private route: ActivatedRoute;
  private _service: GenericService<Assessments>;
  private _commonService: CommonHttpService;
  public sanitizer: DomSanitizer;
  private _http: HttpService;
  private _dataStoreService: DataStoreService;
  private _router: Router;
  private storage: SessionStorageService;
  private _authService: AuthService;
  private _alertService: AlertService;
  private _commonDDService: CommonDropdownsService;
  private _assessmentService: AssessmentService;
  private _formBuilder: FormBuilder;
  private readonly cdr: ChangeDetectorRef;

  constructor(private injector: Injector) {
    this.route = injector.get<ActivatedRoute>(ActivatedRoute);
    this._service = injector.get<GenericService<Assessments>>(GenericService);
    this._commonService = injector.get<CommonHttpService>(CommonHttpService);
    this.sanitizer = injector.get<DomSanitizer>(DomSanitizer);
    this._http = injector.get<HttpService>(HttpService);
    this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
    this._router = injector.get<Router>(Router);
    this.storage = injector.get<SessionStorageService>(SessionStorageService);
    this._authService = injector.get<AuthService>(AuthService);
    this._alertService = injector.get<AlertService>(AlertService);
    this._commonDDService = injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._assessmentService = injector.get<AssessmentService>(AssessmentService);
    this._formBuilder = injector.get<FormBuilder>(FormBuilder);
    this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
    this.id = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._commonDDService.getStoredCaseNumber();
    this.assessmentInitDate = new Date();
  }

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this._assessmentService.getservicecase();
    this.roleId = this._authService.getCurrentUser();
    this.agency = this._authService.getAgencyName();
    this.isSupervisor = (this.roleId.role.name === 'apcs') ? true : false;
    this.isCW = false;                 //SonarQube complexity fix - commented else
    if (this.agency === 'CW') {
      this.isCW = true;
    }
    this.mifraData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');

    this.childDeceased = this.mifraData.submissiondata && this.mifraData.submissiondata.childDeceased ? this.mifraData.submissiondata.childDeceased : false;
    this.isChildLocatedByDept = this.mifraData.submissiondata && this.mifraData.submissiondata.childLocatedByDept ? this.mifraData.submissiondata.childLocatedByDept : false;

    if (this.childDeceased) {
      this.isValue = 6
    } else if (this.isChildLocatedByDept) {
      this.isValue = 7
    }

    this.contactNotes = this._dataStoreService.getData('contact_action_info') ? this._dataStoreService.getData('contact_action_info').replace(/<\/?[^>]+(>|$)/g, "") : null;
    this.updateMifra = false;                                         //SonarQube complexity fix - commented else
    if (['update', 'submit'].includes(this.mifraData.mode)) {           //SonarQube complexity fix - modified condition check
      this.updateMifra = true;
    }
    //In case of working with an existing assesment submission
    this.currentAssessmentId = this.mifraData.assessmentid;
    this.currentSubmissionId = this.mifraData.submissionid;
    this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') ? this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') : [];
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.familyHOUSEHOLDForm();
    this.authorizationApprovalForm();
    this.supplementaryForm();
    this.scoringandoverrideForm();
    this.NeglectAbuseForm();
    this.prefillAuthorizationApprovalInfo();
    //Get persons in case
    this.getInvolvedPerson();
    //Get caregivers in case
    this.getCaregiversInCase();
    this.familyHOUSEHOLD.patchValue({
      assessmentInitDate: this.assessmentInitDate,
      serviceCaseId: this.daNumber
    });

    this.loadFinalScore();
    if (this.authorizationApproval.get('caseworkersign')?.value) {
      this.caseworkersignature = this.authorizationApproval.get('caseworkersign')?.value;
    }
    if (this.authorizationApproval.get('supervisorsign')?.value) {
      this.supervisorsignature = this.authorizationApproval.get('supervisorsign')?.value;
    }

    
   // loading sdm data
   this.getSDM();
   // get form1080A data
   this.getForm1080B();
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
                  if (this.isServiceCase) {
                    const i = res[0].getservicecasesdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                    this.sdmData = res[0].getservicecasesdm[i];
                  } else {
                    const i = res[0].getintakeservicerequestsdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                    this.sdmData = res[0].getintakeservicerequestsdm[i];
                  }
                  if (this.sdmData) {
                    this.ischildfatality = this.sdmData?.ischildfatality;
                    this.isseriousphysicalinjury = this.sdmData?.isseriousphysicalinjury;
                    this.ismaltreatment = this.sdmData?.ismaltreatment;
                    this.intakesdmproviderlength = this.sdmData?.provider?.length;
                  }
                }
            });
  }

  mfiraPatch() {
    //Flip for non-migrated data
    if (this.mifraData && this.mifraData.submissiondata) {
      this.submissiondata = this.mifraData.submissiondata;
      this.familyHOUSEHOLD.patchValue({
        assessmentInitDate: new Date(this.mifraData.submissiondata.familyHOUSEHOLD.assessmentInitDate)
      })
    }

    this._dataStoreService.setData('PRINTDATA', this.submissiondata);

    if (this.mifraData && (this.mifraData.mode === 'update' || this.mifraData.mode === 'submit')) {
      this.viewMifra = false;
      if (this.mifraData && this.mifraData.submissiondata) {
        this.handleIfSubmissiondataFn();
      }
    }
    if (this.mifraData && this.mifraData.mode === 'submit') {
      this.mifradatacheck();
    }
  }

  // Assosiated with mfiraPatch method
  private handleIfSubmissiondataFn() {
    if (this.mifraData.submissiondata.familyHOUSEHOLD) {
      this.familyHOUSEHOLD.patchValue(this.mifraData.submissiondata.familyHOUSEHOLD);
      this.familyHOUSEHOLD.setControl('familyArray', this._formBuilder.array([]));
      if (this.mifraData.submissiondata.familyHOUSEHOLD.familyArray) {
        this.mifraData.submissiondata.familyHOUSEHOLD.familyArray.forEach((data: any) => {
          this.addFamily(data);
        });
      }
      this.familyHOUSEHOLD.patchValue({
        assessmentInitDate: new Date(this.mifraData.submissiondata.familyHOUSEHOLD.assessmentInitDate)
      })
    }
    if (this.mifraData.submissiondata.NeglectAbuse) {
      this.NeglectAbuse.patchValue(this.mifraData.submissiondata.NeglectAbuse);
    }
    if (this.mifraData.submissiondata.supplementaryApproval) {
      this.supplementaryApproval.patchValue(this.mifraData.submissiondata.supplementaryApproval);
    }
    if (this.mifraData.submissiondata.scoringandoverride) {
      this.scoringandoverride.patchValue(this.mifraData.submissiondata.scoringandoverride);
    }
    if (this.mifraData.submissiondata.authorizationApproval) {
      this.authorizationApprovalcheck();
    }
  }

  authorizationApprovalcheck() {
    const approvaldata = this.mifraData.submissiondata.authorizationApproval;
    this.authorizationApproval.patchValue({
      routingsupervisors: approvaldata.routingsupervisors,
      supervisorname: approvaldata.supervisorname,
      workername: approvaldata.workername,
      caseworkersign: approvaldata.caseworkersign,
      caseworkersigndate: approvaldata.caseworkersigndate,
      caseworkercomment: approvaldata.caseworkercomment,
      supervisorsign: approvaldata.supervisorsign,
      reviewdate: approvaldata.reviewdate,
      supervisorcomment: approvaldata.supervisorcomment,
      assessmentstatus: approvaldata.assessmentstatus,
      safetyassessmentapprovaldate: approvaldata.safetyassessmentapprovaldate
    });
  }

  mifradatacheck() {
    this.viewMifra = true;
    this.familyHOUSEHOLD.disable();
    this.authorizationApproval.disable();
    this.authorizationApproval.controls['caseworkercomment'].enable();
    this.supplementaryApproval.disable();
    this.scoringandoverride.disable();
    this.NeglectAbuse.disable();
  }

  familyHOUSEHOLDForm() {
    this.familyHOUSEHOLD = this._formBuilder.group({
      assessmentInitDate: [null],
      houseHoldHeadName: [null],
      serviceCaseId: [null]
    });
    this.familyHOUSEHOLD.setControl('familyArray', this._formBuilder.array([]));
  }

  addFamily(model: any) {
    const control = <FormArray>this.familyHOUSEHOLD.controls['familyArray'];
    control.push(this.createFormGroup(model));
  }

  deleteFamily(index: number) {
    const control = <FormArray>this.familyHOUSEHOLD.controls['familyArray'];
    control.removeAt(index);
  }

  private createFormGroup(modal: any) {
    const relationships = this.handleRelationshipsFn(modal);
    const relationshipDesc = this._assessmentService.getRelationShip(this.headofhouseholdid, modal.personid, relationships);
    if (this.updateMifra) {
      return this.updatemifracheck(modal, relationshipDesc);

    } else {
      return this._formBuilder.group({
        name: modal.fullname ? modal.fullname : '',
        dob: modal.dob ? new Date(modal.dob) : '',
        caregiver: modal.caregiver ? modal.caregiver : '',
        relationship: relationshipDesc ? relationshipDesc : '',
        personid: modal.personid ? modal.personid : '',
        intakeservicerequestactorid: modal.intakeservicerequestactorid ? modal.intakeservicerequestactorid : null
      });
    }
  }

  // Assosiated with createFormGroup method
  private handleRelationshipsFn(modal: any) {
    if (modal.relationshiparray && modal.relationshiparray.length && modal.relationshiparray.length > 0) {
      this.relationships = modal.relationshiparray;
    }

    var relationships;
    if (this.relationships && this.relationships.length > 0) {
      relationships = this.relationships;
    } else {
      relationships = modal.relationshiparray;
    }
    return relationships;
  }

  updatemifracheck(modal: any, relationshipDesc: any) {
    return this._formBuilder.group({
      name: modal.name ? modal.name : '',
      dob: modal.dob ? new Date(modal.dob) : '',
      caregiver: modal.caregiver ? modal.caregiver : '',
      relationship: relationshipDesc ? relationshipDesc : '',
      personid: modal.personid ? modal.personid : '',
      intakeservicerequestactorid: modal.intakeservicerequestactorid ? modal.intakeservicerequestactorid : null
    });
  }

  NeglectAbuseForm() {
    this.NeglectAbuse = this._formBuilder.group({
      assessmentInitDate: [null],
      houseHoldHeadName: [null],
      serviceCaseId: [null],
      caregivername: [null],
      caregiverdob: [null],
      caregiverage: [null],
      caregiverrelationship: [null],
      currentReport: [null],
      currentNeglectScore: [0],
      currentAbuseScore: [0],
      priorCPSResponse: [null],
      priorCPSResponseNeglectScore: [0],
      priorCPSResponseAbuseScore: [0],
      priorNeglect: [null],
      priorNeglectNeglectScore: [0],
      priorNeglectAbuseScore: [0],
      priorAbuse: [null],
      priorAbuseNeglectScore: [0],
      priorAbuseAbuseScore: [0],
      ihfsohpcase: [null],
      ihfsohpcaseNeglectScore: [0],
      ihfsohpcaseAbuseScore: [0],
      cpsresponse: [null],
      cpsresponseNeglectScore: [0],
      cpsresponseAbuseScore: [0],
      priorNonAccidental: [null],
      priorNonAccidentalNeglectScore: [0],
      priorNonAccidentalAbuseScore: [0],
      youngestAge: [null],
      youngestAgeNeglectScore: [0],
      youngestAgeAbuseScore: [0],
      PrimaryCaregiver: [null],
      PrimaryCaregiverNeglectScore: [0],
      PrimaryCaregiverAbuseScore: [0],
      PrimaryCaregiverMentalHealth: [null],
      PrimaryCaregiverTreatment: [null],
      PrimaryCaregiverMentalHealthNeglectScore: [0],
      PrimaryCaregiverMentalHealthAbuseScore: [0],
      PrimaryCaregiverHistory: [null],
      PrimaryCaregiverHistoryNeglectScore: [0],
      PrimaryCaregiverHistoryAbuseScore: [0],
      housing: [null],
      housingNeglectScore: [0],
      housingAbuseScore: [0],
      totalNeglectScore: [0],
      totalAbuseScore: [0],
      medicallyfragile: [null],
      positivetoxicology: [null],
      physicaldisability: [null],
      developmentaldisability: [null],
      delinquencyhistory: [null],
      mentalhealth: [null],
      nonecharacteristics: [null],
      characteristicsabusescore: [0],
      characteristicsneglectscore: [0],
      blameschild: [null],
      justifiesmaltreatment: [null],
      noneprimary: [null],
      primaryabusescore: [0],
      primaryneglectscore: [0],
      primarycaregivercharacteristicsabusescore: [0],
      primarycaregivercharacteristicsneglectscore: [0],
      providesinsufficient: [null],
      employsexcessive: [null],
      domineeringcaregiver: [null],
      nonecaregiver: [null],
      pastorcurrentabusescore: [0],
      pastorcurrentneglectscore: [0],
      pastorcurrentdrugsselect: [null],
      pastorcurrentdrugs: [null],
      pastorcurrentalcohol: [null],
      pastorcurrentalcoholselect: [null],
      pastorcurrent: [null],
      secondarycaregiverpastorcurrentabuse: [0],
      secondarycaregiverpastorcurrentneglect: [0],
      secondarycaregiverpastorcurrentdrugs: [null],
      secondarycaregiverpastorcurrentdrugsselect: [null],
      secondarycaregiverpastorcurrentselect: [null],
      secondarycaregiverpastorcurrentalcohol: [null],
      secondarycaregiverpastorcurrent: [null],
      domesticviolenceabuse: [0],
      domesticviolenceneglect: [0],
      domesticviolencefamily: [null],
      domesticviolencehomeless: [null],
      domesticviolencecurrent: [null]
    });
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
        'intakeservicerequestactorid': member.intakeservicerequestactorid ? member.intakeservicerequestactorid : null
      });
    }
    );
    return assessmentactorArray;
  }

  getMfiraPayload(_value: any) {
    var familyHOUSEHOLDData = this.familyHOUSEHOLD.getRawValue();
    if (familyHOUSEHOLDData && familyHOUSEHOLDData.familyArray && familyHOUSEHOLDData.familyArray.length > 0) {
      familyHOUSEHOLDData.familyArray.forEach((family: { relationshiparray: any; }) => {
        family.relationshiparray = this.relationships;
      });
    }
    const authorizationApproval = this.authorizationApproval.getRawValue();
    if (!this.isSupervisor) {
      authorizationApproval.safetyassessmentapprovaldate = moment(new Date()).format('YYYY-MM-DDTHH:mm');
    }

    return {
      familyHOUSEHOLD: familyHOUSEHOLDData,
      NeglectAbuse: this.NeglectAbuse.getRawValue(),
      supplementaryApproval: this.supplementaryApproval.getRawValue(),
      scoringandoverride: this.scoringandoverride.getRawValue(),
      authorizationApproval: authorizationApproval,
      assessmentactor: this.getAssessmentActors(this.familyHOUSEHOLD.controls['familyArray'].value),
      // The API expects these in addition to form data
      supervisorname: this.authorizationApproval.controls['supervisorname'].value,
      routingsupervisors: this.routingSupervisors,
      currentSubmissionId: this.currentSubmissionId,
      assessmentStaus: this.assessmentStatus,
      comments: this.authorizationApproval.controls['caseworkercomment'].value,
      childDeceased: this.childDeceased,
      childLocatedByDept: this.isChildLocatedByDept
    };
  }

  saveForm() {
    this.checkmandatory = true;
    if ((this.isValue == 1 && this.familyHOUSEHOLD.valid) || (this.isValue == 2 && this.NeglectAbuse.valid) || (this.isValue == 3 && this.scoringandoverride.valid) || (this.isValue == 4 && this.supplementaryApproval.valid)) {
      const mfiraData = this.getMfiraPayload(false);
      this._dataStoreService.setData('PRINTDATA', mfiraData);
      this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, mfiraData)
        .subscribe(
          (response) => {
            this._alertService.success('Form saved');
            if (response.data) {
              this.currentAssessmentId = response.data.assessmentid ? response.data.assessmentid : this.currentAssessmentId;
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
    else {
      this._alertService.error('Please fill all required fields');
    }
  }

  submitForApproval() {
    if (this.isSupervisor) {
      this.assessmentStatus = this.authorizationApproval.get('assessmentstatus')?.value;
    } else {
      this.assessmentStatus = 'Review';
    }
    const submissionData = this.getMfiraPayload(true);
    this._dataStoreService.setData('PRINTDATA', submissionData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
    .subscribe(
      (response) => {
        if (response.data) {
          this.currentAssessmentId = response.data.assessmentid ? response.data.assessmentid : this.currentAssessmentId;   
        }
        this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
        if(this.isServiceCase) {
          this.getrohsenuntimelycriteria();
        } else {
          if(this.checkForm1080BFilled()){
            setTimeout(() => {
              this._router.navigate(['../'], { relativeTo: this.route });
            }, 1000);
          }
        }
      },
      (error) => {
        this._alertService.error('Unable to submit for approval.');
      }
    );
  }

  getrohsenuntimelycriteria() {      
    this._commonService
    .getArrayList(
        {
            where: {
                servicecaseid  : this.id,
                mfiraassessmentid: this.currentAssessmentId,
                objecttype : 'mfira'
            },
            method: 'get'
        },
        NewUrlConfig.EndPoint.Intake.Rohsenuntimelycriteria + '?filter' /* Separate API invoked for SEN Untimely Report */
    ).subscribe(data => {
        if(data && data.length > 0) {
            this._dataStoreService.setData('refereshgetrohcall', true);
            this.globalPopupRef.showSenUntimelyPopupAlert('MFIRA',data);
        } else {        
          if(this.checkForm1080BFilled()){
            setTimeout(() => {
              this._router.navigate(['../'], { relativeTo: this.route });
            }, 1000);
          }          
        }           
    });
 }

  getRoutingSupervisors() {
    return this.routingSupervisors;
  }

  getRoutingInfo() {
    return this.routingInfo;
  }

  scoringandoverrideForm() {
    this.scoringandoverride = this._formBuilder.group({
      discretionaryreason: [null],
      //overiderisklevel: [null],
      discretionaryoverride: [null, Validators.required],
      caregiveraction: [null, Validators.required],
      severenonaccidental: [null, Validators.required],
      nonaccidental: [null, Validators.required],
      sexualabusecase: [null, Validators.required],
      finalrisklevel: [null]
    });
    this.scoringandoverride.get('finalrisklevel')?.disable();
  }

  supplementaryForm() {
    this.supplementaryApproval = this._formBuilder.group({
      criminalhistorywithinpastyears: [null],
      primary_isarrest: [null],
      primary_isconviction: [null],
      primary_felonyconviction: [null],
      secondary_nosecondarycaregiver: [null],
      secondary_isarrest: [null],
      secondary_isconviction: [null],
      secondary_felonyconviction: [null],

    });
  }

  authorizationApprovalForm() {
    this.authorizationApproval = this._formBuilder.group({
      routingsupervisors: [null],
      supervisorname: [''],
      workername: [''],
      assessmentstatus: [''],
      caseworkersign: [''],
      supervisorsign: [''],
      reviewdate: [null],
      caseworkercomment: [''],
      supervisorcomment: [{ value: '', disabled: !this.isSupervisor }],
      safetyassessmentapprovaldate: [{ value: null, disabled: true }]
    });
  }

  prefillAuthorizationApprovalInfo() {
    if (Array.isArray(this.routingInfo) && this.routingInfo.length) {
      this.authorizationApproval.patchValue({
        supervisorname: this._dataStoreService.getData('da_assignedby'),
        workername: this.roleId.user.userprofile.fullname
      });
    }
  }

  onOverrideRisk(value: any) {
    if (value === '1') {
      this.scoringandoverride.get('discretionaryreason')?.setValidators(Validators.required);
      this.scoringandoverride.get('discretionaryreason')?.updateValueAndValidity();
    } else {
      this.scoringandoverride.get('discretionaryreason')?.reset();
      this.scoringandoverride.get('discretionaryreason')?.clearValidators();
      this.scoringandoverride.get('discretionaryreason')?.updateValueAndValidity();
      this.loadFinalScore();
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

  getInvolvedPerson() {
    let getpersonlistreq = {};
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    } else {
      getpersonlistreq = { intakeserviceid: this.id, isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged };
    }
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
        this.handleGetpersondetailcwRespFn(response);
      }

    });
  }

  // Assosiated with getInvolvedPerson method
  private handleGetpersondetailcwRespFn(response: ListDataItem<any>) {
    this.involvedPerson = response.data;
    this.involvedpersoncheck();
    if (this.childList.length === 1) {
      this.enableChildDeceased = true;
      this.deceasedChildName = this.childList[0].fullname ? this.childList[0].fullname : null;
      this.dodOfDeceasedChild = this.childList[0].dateofdeath ? moment(this.childList[0].dateofdeath).format('MM/DD/YYYY') : null;
    }

    this.involvedPerson.forEach(ele => {
      if (!this.updateMifra && ele.ishousehold == 1) {
        this.addFamily(ele);
      }
    });
    this.mfiraPatch();
  }

  involvedpersoncheck() {
    this.involvedPerson.forEach(ele => {

      if (ele.isheadofhousehold) {
        this.headofhouseholdid = ele.personid;
        this.familyHOUSEHOLD.patchValue({
          houseHoldHeadName: this.getFullName(ele)
        });
      }
      if (ele.roles) {
        const legalGurdian = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'LG');
        if (legalGurdian && legalGurdian.length) {
          this.legalGuardian.push(ele);

        }
        const childData = ele.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD');
        if (childData && childData.length) {
          this.childList.push(ele);
        }

      }
    });
  }

  getFullName(person: any) {
    const nameKeys = ['prefx', 'firstname', 'middlename', 'lastname', 'suffix'];
    let name = '';
    nameKeys.forEach(key => {
      if (person && person.hasOwnProperty(key)) {
        if (person[key] != null && person[key] != 'null' && person[key] != '') {
          name = name + person[key] + ' ';
        }
      }
    });
    return name;
  }
  changeSupervisor(userid: any) {
    const user = this.routingSupervisors.find(item => item.userid === userid);
    if (user.username) {
      this.authorizationApproval.patchValue({
        supervisorname: user.username
      });
    }
  }

  calculateScore(value: any, negelct: any, abuse: any) {
    if (negelct == 'priorCPSResponseNeglectScore' && value === '4') { //Fully reset I2a if 2 is set to no
      this.NeglectAbuse.controls['priorNeglectNeglectScore'].setValue(0);
      this.NeglectAbuse.controls['priorNeglect'].setValue('4');
      this.NeglectAbuse.controls['priorAbuseAbuseScore'].setValue(0);
      this.NeglectAbuse.controls['priorAbuse'].setValue('4');
    }
    if (negelct == 'pastorcurrent' && value === '7') { //Fully reset Alcohol and Drugs if 12 is set to no
      this.NeglectAbuse.controls['pastorcurrentalcohol'].setValue(false);
      this.NeglectAbuse.controls['pastorcurrentdrugs'].setValue(false);
      this.NeglectAbuse.patchValue({ pastorcurrentalcoholselect: [null] });
      this.NeglectAbuse.patchValue({ pastorcurrentdrugsselect: [null] });
    }
    if (value === '11') {
      value = '4';
    }
    if (value === '10') {
      value = '1';
    }
    if (value === '12') {
      value = '2';
    }
    if (negelct == 'secondarycaregiverpastorcurrentneglect' && value === '4') {//Fully reset Alcohol and Drugs if 13 is set to no
      this.NeglectAbuse.controls['secondarycaregiverpastorcurrentalcohol'].setValue(false);
      this.NeglectAbuse.controls['secondarycaregiverpastorcurrentdrugs'].setValue(false);
      this.NeglectAbuse.patchValue({ secondarycaregiverpastorcurrentselect: [null] });
      this.NeglectAbuse.patchValue({ secondarycaregiverpastorcurrentdrugsselect: [null] });
    }
    this.handleNeglectAbuseFn(value, negelct, abuse);
  }
  // Assosisted with calculateScore method
  private handleNeglectAbuseFn(value: any, negelct: any, abuse: any) {
    if (value === '1') {
      this.NeglectAbuse.controls[negelct].setValue(1);
      this.NeglectAbuse.controls[abuse].setValue(0);
    }
    if (value === '2') {
      if (negelct == 'PrimaryCaregiverHistoryNeglectScore') {
        this.NeglectAbuse.controls[negelct].setValue(1);
        this.NeglectAbuse.controls[abuse].setValue(1);
      }
      else {
        this.NeglectAbuse.controls[negelct].setValue(0);
        this.NeglectAbuse.controls[abuse].setValue(1);
      }
    }
    if (value === '3') {
      this.NeglectAbuse.controls[negelct].setValue(1);
      this.NeglectAbuse.controls[abuse].setValue(1);
    }
    if (value === '4') {
      this.NeglectAbuse.controls[negelct].setValue(0);
      this.NeglectAbuse.controls[abuse].setValue(0);
    }
    if (value === '5') {
      this.NeglectAbuse.controls[negelct].setValue(2);
      this.NeglectAbuse.controls[abuse].setValue(0);
    }
    if (value === '6') {
      this.NeglectAbuse.controls[negelct].setValue(0);
      this.NeglectAbuse.controls[abuse].setValue(2);
    }
  }

  calculateScoreOncheck(value: any, negelct: any, abuse: any, section: any) {
    if (negelct) {
      this.NeglectAbuse.controls[negelct].setValue(1);
    }
    if (abuse) {
      this.NeglectAbuse.controls[abuse].setValue(1);
    }
  }

  getCharacteristicvalue(value: any) {
    if (value === 1) {
      this.neglectcountercheck();
    }
    if (value === 2) {
      this.abusecountercheck();
    }
  }

  neglectcountercheck() {
    const formControls: any = this.NeglectAbuse;

    const medicallyfragileControl = formControls.get('medicallyfragile');
    const positivetoxicologyControl = formControls.get('positivetoxicology');
    const physicaldisabilityControl = formControls.get('physicaldisability');
    const developmentaldisabilityControl = formControls.get('developmentaldisability');
    const delinquencyhistoryControl = formControls.get('delinquencyhistory');
    const mentalhealthControl = formControls.get('mentalhealth');
    
    let neglectcounter = 0;
    if (this.NeglectAbuse.get('medicallyfragile')?.value) {
      neglectcounter++;
    } else {
      neglectcounter = neglectcounter > 0 ? neglectcounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('positivetoxicology')?.value) {
      neglectcounter++;
    } else {
      neglectcounter = neglectcounter > 0 ? neglectcounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('physicaldisability')?.value) {
      neglectcounter++;
    } else {
      neglectcounter = neglectcounter > 0 ? neglectcounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('nonecharacteristics')?.value) {
      neglectcounter = 0;
      medicallyfragileControl?.reset();
      positivetoxicologyControl?.reset();
      physicaldisabilityControl?.reset();
      developmentaldisabilityControl?.reset();
      delinquencyhistoryControl?.reset();
      mentalhealthControl?.reset();
      medicallyfragileControl?.disable({ emitEvent: false });
      positivetoxicologyControl?.disable({ emitEvent: false });
      physicaldisabilityControl?.disable({ emitEvent: false });
      developmentaldisabilityControl?.disable({ emitEvent: false });
      delinquencyhistoryControl?.disable({ emitEvent: false });
      mentalhealthControl?.disable({ emitEvent: false });
    } else {
      medicallyfragileControl?.enable({ emitEvent: false });
      positivetoxicologyControl?.enable({ emitEvent: false });
      physicaldisabilityControl?.enable({ emitEvent: false });
      developmentaldisabilityControl?.enable({ emitEvent: false });
      delinquencyhistoryControl?.enable({ emitEvent: false });
      mentalhealthControl?.enable({ emitEvent: false });
    }
    this.NeglectAbuse.patchValue({
      characteristicsneglectscore: neglectcounter
    });
    return neglectcounter;
  }

  abusecountercheck() {
    let abusecounter = 0;
    if (this.NeglectAbuse.get('developmentaldisability')?.value) {
      abusecounter++;
    } else {
      abusecounter = abusecounter > 0 ? abusecounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('delinquencyhistory')?.value) {
      abusecounter++;
    } else {
      abusecounter = abusecounter > 0 ? abusecounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('mentalhealth')?.value) {
      abusecounter++;
    } else {
      abusecounter = abusecounter > 0 ? abusecounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('nonecharacteristics')?.value) {
      abusecounter = 0;
      this.NeglectAbuse.get('mentalhealth')?.reset();
      this.NeglectAbuse.get('delinquencyhistory')?.reset();
      this.NeglectAbuse.get('developmentaldisability')?.reset();
    }
    this.NeglectAbuse.patchValue({
      characteristicsabusescore: abusecounter
    });
    return abusecounter;

  }

  isReadyForApproval() {
    this.checkmandatory = true;
    this.incompleteList = [];

    if (!this.childDeceased && !this.isChildLocatedByDept) {
      this.childDeceasedcheck();
    } else {
      this.childDeceasedelsecheck();
    }

    if (!this.authorizationApproval.valid || (this.authorizationApproval.controls.reviewdate.value === 'Invalid date' && this.isSupervisor === true)) {
      this.incompleteList.push('APPROVAL');
    }
    if (this.incompleteList.length == 0) {
      if(!this.checkForm1080BFilled()){
        const riskOfHarm=  this._dataStoreService.getData('IsRiskofHarm');
        if((this.isServiceCase && riskOfHarm) || (!this.isServiceCase)) {
          this.globalPopupRef.showGlobalPopupAlert('Form 1080 B Alert',this.form1080bAlertMessage);
        } 
      }
      this.submitForApproval();
    } else {
      (<any>$('#incomplete-items')).modal('show'); // NOSONAR
    }
  }

  
  onCloseForm1080bAlert() : void {
    (<any>$('#form1080b-alert')).modal('hide');
    setTimeout(() => {
      this._router.navigate(['../'], { relativeTo: this.route });
    }, 1000);
  }

  private reusableValidPersonConditionFn(data: any[]) {
    if (data) {
        return true
    } else {
        return false;
    }
  }

  // Checking if Form1080 B is available for MFIRA
  checkForm1080BFilled() : boolean {
    
    // we can remove supervisor variable once we get final requirement on message.
    const form1080aMessageWorker = 'Please complete and submit the Form 1080 B. The 1080 Form Series is located in the Forms sub-tab of the Documents tab.';
    const form1080aMessageSupervisor = 'Please complete and submit the Form 1080 B form. The 1080 Form Series is located in the Forms sub-tab of the Documents tab';

    this.form1080bAlertMessage = this.isSupervisor ? form1080aMessageSupervisor : form1080aMessageWorker;

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
      let data = this.form1080bData;
      let isForm1080Done = false;
      if(data.length>0) {
          isForm1080Done = data.some(form => form.status === 'Approved');
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
  getForm1080B() {
    const intakeNumber = this._dataStoreService.getData("da_intakenumber");
    const inputRequest = {
        objectid: [this.id,intakeNumber],
    };
    this._commonService.getArrayList(
        new PaginationRequest({
            where: inputRequest,
            method: "get",
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080b.List + "?filter"
    ).subscribe(
        (response) => {
            if (response) {
                this.form1080bData = response;
            }
        },
        (error) => {
            this._alertService.warn('Error retrieving Form 1080B data');
        }
    );
  } 

  childDeceasedelsecheck() {
    if (this.childDeceased && (this.deceasedChildName == null || this.dodOfDeceasedChild == null)) {
      this.incompleteList.push('Child Name & Child DOD')
    }
    if (this.isChildLocatedByDept && (this.contactNotes == null || this.contactNotes == undefined)) {
      this.incompleteList.push('Action Taken');
    }
  }

  childDeceasedcheck() {
    if (!this.familyHOUSEHOLD.valid) {
      this.incompleteList.push('FAMILY AND HOUSEHOLD COMPOSITION');
    }
    if (!this.NeglectAbuse.valid) {
      this.incompleteList.push('NEGLECT/ABUSE INDEX');
    }
    if (!this.scoringandoverride.valid) {
      this.incompleteList.push('SCORING AND OVERRIDES');
    }
    if (!this.supplementaryApproval.valid) {
      this.incompleteList.push('SUPPLEMENTAL QUESTION');
    }
  }

  getcaregivervalue(value: any) {
    if (value === 2) {
      const neglectcounter = this.handleGetcaregivervalueFn();
      this.NeglectAbuse.patchValue({
        primaryneglectscore: neglectcounter,
        primaryabusescore: 0
      });
      return neglectcounter;
    }
  }
  // Assosiated with getcaregivervalue method
  private handleGetcaregivervalueFn() {
    const formControls: any = this.NeglectAbuse;

    const blamesChildControl = formControls.get('blameschild');
    const justifiesControl = formControls.get('justifiesmaltreatment');
  
    let neglectcounter = 0;
    if (this.NeglectAbuse.get('blameschild')?.value) {
      neglectcounter++;
    } else {
      neglectcounter = neglectcounter > 0 ? neglectcounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('justifiesmaltreatment')?.value) {
      neglectcounter = neglectcounter + 2;
    } else {
      const neglectcounterValue = (neglectcounter === 3 ? neglectcounter - 2 : neglectcounter - 1);
      neglectcounter = (neglectcounter === 0) ? 0 : neglectcounterValue;
    }
    if (this.NeglectAbuse.get('noneprimary')?.value) {
      blamesChildControl?.reset();
      justifiesControl?.reset();
      blamesChildControl?.disable({ emitEvent: false });
      justifiesControl?.disable({ emitEvent: false });
      neglectcounter = 0;
    } else {
      blamesChildControl?.enable({ emitEvent: false });
      justifiesControl?.enable({ emitEvent: false });
    }
    return neglectcounter;
  }

  getcaregivercharvalue(value: any) {
    if (value === 2) {
      const abusecounter = this.handleGetcaregivercharvalueFn();
      this.NeglectAbuse.patchValue({
        primarycaregivercharacteristicsneglectscore: 0,
        primarycaregivercharacteristicsabusescore: abusecounter
      });
      return abusecounter;
    }
  }
  // Assosiated with getcaregivercharvalue method
  private handleGetcaregivercharvalueFn() {
    let abusecounter = 0;
    if (this.NeglectAbuse.get('providesinsufficient')?.value) {
      abusecounter++;
    } else {
      abusecounter = (abusecounter > 0) ? abusecounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('employsexcessive')?.value) {
      abusecounter++;
    } else {
      abusecounter = (abusecounter > 0) ? abusecounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('domineeringcaregiver')?.value) {
      abusecounter++;
    } else {
      abusecounter = (abusecounter > 0) ? abusecounter - 1 : 0;
    }
    if (this.NeglectAbuse.get('nonecaregiver')?.value) {
      this.getcaregivercharvaluecheck();
      abusecounter = 0;
    } else {
      this.NeglectAbuse.get('domineeringcaregiver')?.enable({ emitEvent: false });
      this.NeglectAbuse.get('employsexcessive')?.enable({ emitEvent: false });
      this.NeglectAbuse.get('providesinsufficient')?.enable({ emitEvent: false });
    }
    return abusecounter;
  }

  getcaregivercharvaluecheck() {
    this.NeglectAbuse.get('domineeringcaregiver')?.reset();
    this.NeglectAbuse.get('employsexcessive')?.reset();
    this.NeglectAbuse.get('providesinsufficient')?.reset();
    this.NeglectAbuse.get('domineeringcaregiver')?.disable({ emitEvent: false });
    this.NeglectAbuse.get('employsexcessive')?.disable({ emitEvent: false });
    this.NeglectAbuse.get('providesinsufficient')?.disable({ emitEvent: false });
}

  getsubstanceabusevalue(value: any) {
    if (value === 1) {
      let abusecounter = 0;
      if (this.NeglectAbuse.get('pastorcurrentalcohol')?.value) {
        if (this.NeglectAbuse.get('pastorcurrentalcoholselect')?.value &&
          (this.NeglectAbuse.get('pastorcurrentalcoholselect')?.value == 2 || this.NeglectAbuse.get('pastorcurrentalcoholselect')?.value == 3)) {
          abusecounter++;
        }
      }
      if (this.NeglectAbuse.get('pastorcurrentdrugs')?.value) {
        if (this.NeglectAbuse.get('pastorcurrentdrugsselect')?.value &&
          (this.NeglectAbuse.get('pastorcurrentdrugsselect')?.value == 2 || this.NeglectAbuse.get('pastorcurrentdrugsselect')?.value == 3)) {
          abusecounter++;
        }
      }
      this.NeglectAbuse.patchValue({
        pastorcurrentabusescore: abusecounter,
      });
      return abusecounter;
    }
  }
  getsubstancesecondaryabusevalue(value: any) {
    if (value === 1) {
      let abusecounter = 0;
      if (this.NeglectAbuse.get('secondarycaregiverpastorcurrentalcohol')?.value) {
        if (this.NeglectAbuse.get('secondarycaregiverpastorcurrentselect')?.value &&
          (this.NeglectAbuse.get('secondarycaregiverpastorcurrentselect')?.value == 2 || this.NeglectAbuse.get('secondarycaregiverpastorcurrentselect')?.value == 3)) {
          abusecounter++;
        }
      }
      if (this.NeglectAbuse.get('secondarycaregiverpastorcurrentdrugs')?.value) {
        if (this.NeglectAbuse.get('secondarycaregiverpastorcurrentdrugsselect')?.value &&
          (this.NeglectAbuse.get('secondarycaregiverpastorcurrentdrugsselect')?.value == 2 || this.NeglectAbuse.get('secondarycaregiverpastorcurrentdrugsselect')?.value == 3)) {
          abusecounter++;
        }
      }
      this.NeglectAbuse.patchValue({
        secondarycaregiverpastorcurrentabuse: abusecounter,
      });
      return abusecounter;
    }
  }
  getHousing(value: any) {
    if (value === 2) {
      const neglectcounter = this.handleGetHousingFn();
      this.NeglectAbuse.patchValue({
        housingNeglectScore: neglectcounter,
        housingAbuseScore: 0
      });
      return neglectcounter;
    }
  }

  private handleGetHousingFn() { 
    let neglectcounter = 0;
    const domesticViolenceCurrent = this.NeglectAbuse.get('domesticviolencecurrent')?.value;
    const domesticViolenceHomeless = this.NeglectAbuse.get('domesticviolencehomeless')?.value;
    if (domesticViolenceCurrent) {
      neglectcounter++;
    }
    if (domesticViolenceHomeless) {
      neglectcounter += 2;
    }
    if (!domesticViolenceCurrent && !domesticViolenceHomeless) {
      if (neglectcounter > 2) {
        neglectcounter -= 2;
      } else if (neglectcounter > 0) {
        neglectcounter = 0;
      }
    }

  return neglectcounter;
}


  calculateTotalNeglect() {
    let totalNeglectScore = 0;
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('currentNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorCPSResponseNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorNeglectNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorAbuseNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('ihfsohpcaseNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('cpsresponseNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorNonAccidentalNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('youngestAgeNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('characteristicsneglectscore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('primaryneglectscore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('PrimaryCaregiverNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('primarycaregivercharacteristicsneglectscore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('PrimaryCaregiverMentalHealthNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('pastorcurrentneglectscore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('secondarycaregiverpastorcurrentneglect')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('PrimaryCaregiverHistoryNeglectScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('domesticviolenceneglect')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('housingNeglectScore')?.value);
    this.NeglectAbuse.patchValue({
      totalNeglectScore: totalNeglectScore
    });
    return totalNeglectScore;
  }

  calculateTotalAbuse() {
    let totalNeglectScore = 0;
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('currentAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorCPSResponseAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorNeglectAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorAbuseAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('ihfsohpcaseAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('cpsresponseAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('priorNonAccidentalAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('youngestAgeAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('characteristicsabusescore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('primaryabusescore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('PrimaryCaregiverAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('primarycaregivercharacteristicsabusescore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('PrimaryCaregiverMentalHealthAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('pastorcurrentabusescore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('secondarycaregiverpastorcurrentabuse')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('PrimaryCaregiverHistoryAbuseScore')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('domesticviolenceabuse')?.value);
    totalNeglectScore += this.converttoNumber(this.NeglectAbuse.get('housingAbuseScore')?.value);
    this.NeglectAbuse.patchValue({
      totalAbuseScore: totalNeglectScore
    });
    return totalNeglectScore;
  }

  converttoNumber(value: any) {
    return (value) ? parseFloat(value) : 0;
  }

  loadFinalScore() {
    if (this.overrideExists()) {
      this.scoringandoverride.patchValue({
        finalrisklevel: '4'
      });
    } else {
      const neglect = this.converttoNumber(this.NeglectAbuse.get('totalNeglectScore')?.value);
      const abuse = this.converttoNumber(this.NeglectAbuse.get('totalAbuseScore')?.value);
      const total = neglect >= abuse ? neglect : abuse;
      if (total <= 1) {
        this.scoringandoverride.patchValue({
          finalrisklevel: '1'
        });
      } else if (total <= 4) {
        this.scoringandoverride.patchValue({
          finalrisklevel: '2'
        });
      } else if (total <= 8) {
        this.scoringandoverride.patchValue({
          finalrisklevel: '3'
        });
      } else if (total >= 8) {
        this.scoringandoverride.patchValue({
          finalrisklevel: '4'
        });
      }
      if (this.scoringandoverride.get('discretionaryoverride')?.value === '1') {
        const score = this.converttoNumber(this.scoringandoverride.get('finalrisklevel')?.value);
        if (score < 4) {
          const finalrisklevel = (score + 1).toString();
          this.scoringandoverride.patchValue({
            finalrisklevel: finalrisklevel
          });
        }
      }
    }
    return true;
  }

  houseHoldChildDeceased(value: any) {
    if (value.target.checked) {
      this.isValue = 6;
      this.childDeceased = true;
      this.isChildLocatedByDept = false;
    } else {
      this.isValue = 1;
      this.childDeceased = false;
    }
    return 'success'
  }

  deptLocateChild(value: any) {
    if (value.target.checked) {
      this.isValue = 7;
      this.isChildLocatedByDept = true;
      this.childDeceased = false;
    } else {
      this.isValue = 1;
      this.isChildLocatedByDept = false;
    }
    return 'success'
  }

  overrideExists(): boolean {
    if (this.scoringandoverride && this.scoringandoverride.enabled) {
      if (this.scoringandoverride.get('sexualabusecase')?.value == '1') {
        return true;
      }
      if (this.scoringandoverride.get('nonaccidental')?.value == '1') {
        return true;
      }
      if (this.scoringandoverride.get('severenonaccidental')?.value == '1') {
        return true;
      }
      if (this.scoringandoverride.get('caregiveraction')?.value == '1') {
        return true;
      }
    }
    return false;
  }

  checkboxvalidation() {
    if (this.NeglectAbuse.get('nonecharacteristics')?.value === true) {
      return false;
    }
    else if (this.NeglectAbuse.get('medicallyfragile')?.value ||
      this.NeglectAbuse.get('positivetoxicology')?.value ||
      this.NeglectAbuse.get('physicaldisability')?.value ||
      this.NeglectAbuse.get('developmentaldisability')?.value ||
      this.NeglectAbuse.get('delinquencyhistory')?.value ||
      this.NeglectAbuse.get('mentalhealth')?.value) { return false; }
    else { return true; }
  }

  housingcheckboxvalidation() {
    if (this.NeglectAbuse.get('domesticviolencecurrent')?.value ||
      this.NeglectAbuse.get('domesticviolencehomeless')?.value ||
      this.NeglectAbuse.get('domesticviolencefamily')?.value) {
      return false;
    } else {
      return true;
    }
  }

  checkprimarycare() {
    if (this.NeglectAbuse.get('nonecaregiver')?.value) {
      return false;
    }
    else if (this.NeglectAbuse.get('providesinsufficient')?.value ||
      this.NeglectAbuse.get('employsexcessive')?.value ||
      this.NeglectAbuse.get('domineeringcaregiver')?.value
    ) {
      return false;
    } else {
      return true;
    }
  }
  assesmentincidentvalidation() {
    if (this.NeglectAbuse.get('blameschild')?.value ||
      this.NeglectAbuse.get('justifiesmaltreatment')?.value ||
      this.NeglectAbuse.get('noneprimary')?.value) {
      return false;
    } else {
      return true;
    }
  }
  onChckBoxChng(event: any, chckBox_label: string) {
    if (!event.checked && chckBox_label === 'Alcohol_Pri') { this.NeglectAbuse.patchValue({ pastorcurrentalcoholselect: [null] }); }
    if (!event.checked && chckBox_label === 'Drugs_Pri') { this.NeglectAbuse.patchValue({ pastorcurrentdrugsselect: [null] }); }
    if (!event.checked && chckBox_label === 'Alcohol_Sec') { this.NeglectAbuse.patchValue({ secondarycaregiverpastorcurrentselect: [null] }); }
    if (!event.checked && chckBox_label === 'Drugs_Sec') { this.NeglectAbuse.patchValue({ secondarycaregiverpastorcurrentdrugsselect: [null] }); }
  }
  getControlSDataFn(name: string): any[] {
    return Object.values((this.familyHOUSEHOLD.get(name) as FormGroup).controls)
  }

  openPicker(picker: any) {
    if(picker === 'picker21') {
      this.picker21.open();
    } else if(picker === 'picker11') {
      this.picker11.open();
    }
  }

  onPickerClosed(event: any, controlName: string) {
    const control: any = this.authorizationApproval.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }


}

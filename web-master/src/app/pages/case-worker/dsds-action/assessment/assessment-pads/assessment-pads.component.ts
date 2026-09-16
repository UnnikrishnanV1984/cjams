import { Component, OnInit, Injector, ViewChild } from '@angular/core';
import { FormGroup, FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonHttpService, AlertService, DataStoreService, AuthService, CommonDropdownsService, SessionStorageService } from '../../../../../@core/services';
import { AssessmentService } from '../assessment.service';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatRadioModule } from '@angular/material/radio';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { CommonModule } from '@angular/common';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import moment from 'moment';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { OWL_DATE_TIME_FORMATS, OwlDateTimeComponent, OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { provideNgxMask } from 'ngx-mask';
import { MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';

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
    selector: 'assessment-pads',
    templateUrl: './assessment-pads.component.html',
    styleUrls: ['./assessment-pads.component.scss'],
    imports:[MatFormFieldModule,MatInputModule,MatSelectModule,MatRadioModule,ReactiveFormsModule,MatDatepickerModule,OwlDateTimeModule, OwlNativeDateTimeModule,OwlMomentDateTimeModule,CommonModule,MatCheckboxModule,SignatureFieldModule],
    providers:[provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
    standalone: true
})
export class AssessmentPadsComponent implements OnInit {
  @ViewChild('picker2') picker2!: OwlDateTimeComponent<any>;
  @ViewChild('picker1') picker1!: OwlDateTimeComponent<any>;

  ASSESSMENT_NAME = 'PADS Form';
  submissiondata: any;
  aodidentifyForm!: FormGroup;
  currentAssessmentId!: string;
  preliminaryForm!: FormGroup;
  authorizationForm!: FormGroup;
  preliminaryFormList: any[] = [];
  disableSubmitforAPproval = false;
  routingInfo: any;

  // Common
  isServiceCase: any;
  roleId!: AppUser;
  agency!: string;
  isCW!: boolean;
  id: any;
  daNumber: any;
  isSupervisor!: boolean;
  requiredForApproval!: boolean;
  involvedPerson: any[] = [];
  reportedChild: any[] = [];
  reportedChildOriginal: any[] = [];
  reportedChildName: any[] = [];
  viewAod = false;

  // Preliminarey Form
  showpreliminary = false;
  preliminaryMode!: number;
  preliminaryindex!: number | undefined;
  routingSupervisors: any[] = [];
  currentSubmissionId: any;
  AodData: any;
  assessmentStatus: any;
  incompleteList: any[] = [];
  drugList: any;
  signature: any;
  iscaseexpunged: any = 0;
  assessmentInitDate: any;
  dtformat1 = 'YYYY-MM-DDTHH:mm';
  currentdatetime = moment();


  private _formBuilder: FormBuilder;
  private route: ActivatedRoute;
  private _router: Router;
  private _commonHttpService: CommonHttpService;
  private _alertService: AlertService;
  private _assessmentService: AssessmentService;
  private _dataStoreService: DataStoreService;
  private _commonDDService: CommonDropdownsService;
  private storage: SessionStorageService;
  private _authService: AuthService

  constructor(private injector: Injector) {
    this._formBuilder = injector.get<FormBuilder>(FormBuilder);
    this.route = injector.get<ActivatedRoute>(ActivatedRoute);
    this._router = injector.get<Router>(Router);
    this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = injector.get<AlertService>(AlertService);
    this._assessmentService = injector.get<AssessmentService>(AssessmentService);
    this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
    this._commonDDService = injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.storage = injector.get<SessionStorageService>(SessionStorageService);
    this._authService = injector.get<AuthService>(AuthService);

    this.id = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._commonDDService.getStoredCaseNumber();
    this.assessmentInitDate = moment(new Date()).format(this.dtformat1);
  }

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.roleId = this._authService.getCurrentUser();
    this.agency = this._authService.getAgencyName();
    this.initAODForm();
    this._assessmentService.getservicecase();
    this.isSupervisor = (this.roleId.role.name === 'apcs') ? true : false;
    if (this.agency === 'CW') {
      this.isCW = true;
    } else {
      this.isCW = false;
    }



    this.authorizationForm.patchValue({
      supervisorname: this._dataStoreService.getData('da_assignedby')
    });
    this.authorizationForm.get('supervisorname')?.disable();

    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.getInvolvedPerson();
    this.aodidentifyForm.patchValue({
      supervisorname: this._dataStoreService.getData('da_assignedby'),
      caseworkername: this.roleId.user.userprofile.fullname,
      dateassessmentinitiated: new Date(this.assessmentInitDate)
    });
    this.aodidentifyForm.get('caseworkername')?.disable();
    this.aodidentifyForm.get('supervisorname')?.disable();
    this.AodData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.currentAssessmentId = this.AodData.assessmentid;
    this.currentSubmissionId = this.AodData.submissionid;

    if (this.AodData.mode === 'update' || this.AodData.mode === 'submit') {
      this.getSubmisionData();
    } else {
      this.patchAodForm();
    }
    this.authorizationForm.valueChanges.subscribe(val => {
      this.setDisableSubmitforApproval();
    })
    this.aodidentifyForm.valueChanges.subscribe(val => {
      this.setDisableSubmitforApproval();
    })
    this.preliminaryForm.valueChanges.subscribe(val => {
     this.setDisableSubmitforApproval();
    })
  }

  setDisableSubmitforApproval(){
    if (this.assessmentStatus == 'Review') {
      this.disableSubmitforAPproval = false;
    }
  }

  initAODForm() {
    this.aodidentifyForm = this._formBuilder.group({
      caseworkername: null,
      supervisorname: null,
      caseworkerphone: [''],
      supervisorphone: [''],
      dateassessmentinitiated: null
    });
    this.preliminaryForm = this._formBuilder.group({
      client: [null],
      dob: [null],
      address: [null],
      contact: [null],
      isinfluencedrugs: [''],
      isphysicalsymptoms: [''],
      isdrugparaphrenalia: [''],
      isevidencealcohol: [''],
      ispositivedrugscreen: [''],
      issubstanceabuseincps: [''],
      ischildrenreportabuse: [''],
      isabusetreatment: [''],
      isuseddrugstwelvemonths: [''],
      isconsequencemisusedrugs: [''],
      istroublelawmisusedrugs: [''],
      isdruguserscontactchild: [''],
      isackcomplications: [''],
      othercomments: [''],
      isclientconsentreferral: [''],
      referralcaseworkername: [null],
      referraldate: [null],
      adoscreening: [null],
      signdha: [null],
      aodassess: [null],
      negativeaod: [null],
      positiveaod: [null],
      substanceaubuse: [null],
      treatment: [null],
      appearaod: [null],
      currentaod: [null],
      addictionname: [null],
      addictiondate: [null],
      addictionphno: [null],
      addictionemail: [null],
      addictioncomments: [null],
      isinfluencedrugscomments: null,
      isphysicalsymptomscomments: null,
      isdrugparaphrenaliacomments: null,
      isevidencealcoholcomments: null,
      ispositivedrugscreencomments: null,
      issubstanceabuseincpscomments: null,
      ischildrenreportabusecomments: null,
      ischildrenreportabusedate: null,
      isabusetreatmentcomments: null,
      isabusetreatmentdate: null,
      isuseddrugstwelvemonthsdrug: null,
      isuseddrugstwelvemonthscomments: null,
      isconsequencemisusedrugscomments: null,
      isconsequencemisusedrugsconseq: null,
      istroublelawmisusedrugscomments: null,
      istroublelawmisusedrugslaw: null,
      isdruguserscontactchildcomments: null,
      isackcomplicationscomments: null,
      signature: null,
      isclientconsentreferraldate: null,
      isclientconsentreferralcomments: null,
      treatmentdate: null,
      treatmentprovidername: null,
      appearaoddate: null,
      currentaodfacility: null,
      currentaodverified: null,
      ispositivedrugscreenchild: [''],
      ispositivedrugscreendrug: [''],
      userrole: [''],
    });

    this.authorizationForm = this._formBuilder.group({
      assessmentstatus: [null],
      routingsupervisors: [null],
      supervisorname: [null]
    });
  }

  getSubmisionData() {
    const url = `admin/assessment/getassessmentform/${this.AodData.external_templateid}/submission/${this.AodData.submissionid}`;
    this._commonHttpService.getSingle({}, url).subscribe(result => {
      //Replace submissiondata from assessment table with the parsed json from transaction table
      // this.cansFData.submissiondata = result;
      this.submissiondata = result;
      this.patchAodForm();
    });
  }

  patchAodForm() {

    //Flip for non-migrated data
    if (this.AodData && this.AodData.submissiondata) {
      this.submissiondata = this.AodData.submissiondata;
    }
    this._dataStoreService.setData('PRINTDATA', this.submissiondata);

    if (this.AodData && (this.AodData.mode === 'update' || this.AodData.mode === 'submit')) {
      this.viewAod = false;

      if (this.submissiondata.aodidentifyForm) {
        if(!this.submissiondata.aodidentifyForm.dateassessmentinitiated && this.AodData.createddate) {
          this.submissiondata.aodidentifyForm.dateassessmentinitiated = new Date(this.AodData.createddate);
        }
        this.aodidentifyForm.patchValue(this.submissiondata.aodidentifyForm);
      }
      if (this.submissiondata.preliminaryForm) {
        this.preliminaryFormList = this.submissiondata.preliminaryForm;
      }
      if (this.submissiondata.authorizationForm) {
        this.authorizationForm.patchValue(this.submissiondata.authorizationForm);
      }
    } else {
      this.viewAod = false;
    }
    if (this.AodData && this.AodData.mode === 'submit') {
      this.viewAod = true;
      this.aodidentifyForm.disable();
      this.preliminaryForm.disable();
      this.authorizationForm.disable();
    }
  }

  changeSupervisor(userid: any) {
    const user: any = this.routingSupervisors.find((item: {userid: any;}) => item.userid === userid);
    if (user.username) {
      this.authorizationForm.patchValue({
        supervisorname: user.username
      });
    }
  }

  getInvolvedPerson() {
    let getpersonlistreq = {};
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    } else {
      getpersonlistreq = { intakeserviceid: this.id, isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged};
    }
   
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    this._commonHttpService.getPagedArrayList(
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
        this.involvedpersoncheck();
      }
    });
    this.drugList = this._dataStoreService.getData('CASEWORKER_DRUG_LIST_PADS');
  }

  involvedpersoncheck() {
    this.involvedPerson.forEach((item: any) => {
      if (item && item.roles) {
        const child = item.roles.filter((_roleid: any) => true);
        if (child && child.length) {
          this.reportedChild.push(item);
          this.reportedChildOriginal.push(item);
          this.reportedChildName[item.intakeservicerequestactorid] = item.fullname;
        }
      }
    });
  }

  patchClientData(value: any) {
    const data = this.reportedChild.find(ele => ele.intakeservicerequestactorid === value);
    if (data) {
      this.preliminaryForm.patchValue({
        dob: new Date(data.dob),
        address: this.getFormattedAddress(data),
        contact: data.phonenumber
      });
    }
  }

  private getFormattedAddress(data: any) {
    return (data.address ? data.address + ',' : '')
      + (data.address2 ? data.address2 + ',' : '')
      + (data.state ? data.state + ',' : '')
      + (data.city ? data.city + ',' : '')
      + (data.zipcode ? data.zipcode : '');
  }

  removeAddedChild() {
    if (this.preliminaryFormList && this.preliminaryFormList.length > 0) {
      this.preliminaryFormList.forEach(data => {
        this.reportedChild = this.reportedChild.filter(ele => ele.intakeservicerequestactorid !== data.client);
      });
    } else {
      this.reportedChild = this.reportedChildOriginal;
    }
  }

  showEditPreliminary(mode: number, model: any, index?: number) {
    if (mode === 2 && index !== null && index !== undefined) {
      this.preliminaryFormList.splice(index, 1);
      return true;
    }
    if (mode === 3) {
      this.removeAddedChild();
    }
    this.preliminaryForm.enable();
    this.showpreliminary = true;
    this.preliminaryMode = mode;
    if (model) {
      this.reportedChild = this.reportedChildOriginal;
      this.preliminaryForm.patchValue(model);
      if (model.signature) {
        this.signature = model.signature;
      }
      this.preliminaryindex = index;
      if (mode === 0) {
        this.preliminaryForm.disable();
      }
    } else {
      this.preliminaryForm.reset();
      this.preliminaryForm.patchValue({
        referralcaseworkername: this.roleId.user.userprofile.fullname,
        referraldate: new Date(this.assessmentInitDate)
      });
    }
  }

  cancelPreliminary() {
    this.showpreliminary = false;
  }

  savePreliminary() {
    const preliminaryForm = this.preliminaryForm.getRawValue();
    preliminaryForm.formStatus = this.preliminaryForm.valid;
    if (this.preliminaryMode && this.preliminaryMode === 1 && this.preliminaryindex != null) {
      this.preliminaryFormList[this.preliminaryindex] = preliminaryForm;
    } else {
      this.preliminaryFormList.push(preliminaryForm);
    }
    this.showpreliminary = false;
    this.removeAddedChild();
  }

  getClientPrint(item: any) {
    const data = item;

    data['clientname'] = this.reportedChildName[item['client']];

    if (item['ispositivedrugscreenchild']) {
      data['ispositivedrugscreenchildnames'] = item['ispositivedrugscreenchild'].map((child: any) => this.reportedChildName[child]);
    }

    if (item['ispositivedrugscreendrug']) {
      data['ispositivedrugscreendrugnames'] = item['ispositivedrugscreendrug']?.map((drug: any) => this.drugList.find((pitem: { ref_key: any; }) => pitem.ref_key === drug)?.value_text);
    }

    if (item['isuseddrugstwelvemonthsdrug']) {
      data['isuseddrugstwelvemonthsdrugnames'] = item['isuseddrugstwelvemonthsdrug'].map((drug: any) => this.drugList.find((uitem: { ref_key: any; }) => uitem.ref_key === drug)?.value_text);
    }

    return data;
  }

  getPreliminaryFormListPrint() {
    const preliminaryFormListPrint: any[] = [];
    this.preliminaryFormList.forEach((item) => {
      preliminaryFormListPrint.push(this.getClientPrint(item));
    })
    return preliminaryFormListPrint;
  }

  getAodRequest() {
    return {
      assessmentactor: this.processActorDetails(),
      aodidentifyForm: this.aodidentifyForm.getRawValue(),
      authorizationForm: this.authorizationForm.getRawValue(),
      preliminaryForm: this.getPreliminaryFormListPrint(),
      supervisorname: this.authorizationForm.get('supervisorname')?.value,
      routingsupervisors: this.routingSupervisors,
      currentSubmissionId: this.currentSubmissionId,
      assessmentStaus: this.assessmentStatus
    };
  }

  processActorDetails() {
    const assessmentactorArray: any[] = [];
    this.preliminaryFormList.forEach(child => {
      const assessmentactor = {
        'intakeservicerequestactorid': child.client ? child.client : null,
      };
      assessmentactorArray.push(assessmentactor);
    });
    return assessmentactorArray;
  }
  saveAssessment() {
    this.viewAod = true;
    const aodAssessmentData = this.getAodRequest();
    this._dataStoreService.setData('PRINTDATA', aodAssessmentData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, aodAssessmentData)
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
          this.viewAod = false;
        },
        (error) => {
          this.viewAod = false;
          this._alertService.error('Unable to save.');
        }
      );
  }

  submitForApproval() {
    this.viewAod = true;
    if (this.isSupervisor) {
      this.assessmentStatus = this.authorizationForm.get('assessmentstatus')?.value;
    } else {
      this.assessmentStatus = 'Review';
    }
    const submissionData = this.getAodRequest();
    this._dataStoreService.setData('PRINTDATA', submissionData);
    this.disableSubmitforAPproval = true;
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe(
        (response) => {
          if (response?.errormessage) {
            this._alertService.warn(response.errormessage);
            return;
          }
          this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
          if (response.data) {
            this.currentAssessmentId = response.data.assessmentid;
            this.currentSubmissionId = response.data.submissionid;
          } else {
            this.currentAssessmentId = response.assessmentid;
            this.currentSubmissionId = response.submissionid;
          }
          this.viewAod = false;
          setTimeout(() => {
            this._router.navigate(['../'], { relativeTo: this.route });
          }, 1000);
        },
        (error) => {
          this.viewAod = false;
          this._alertService.error('Unable to submit for approval.');
        }
      );
  }

  getValidationMessage(controlName: any, displayname: any) {
    if (this.preliminaryForm.controls[controlName].status == 'INVALID') {
      return 'Please select value ' + displayname;
    }
  }
  
  isReadyForApproval() {
    this.requiredForApproval = true;
    this.incompleteList = [];
    if (!this.aodidentifyForm.valid) {
      this.incompleteList.push('Identifying Information');
    }
    if (this.preliminaryFormList.length > 0) {
      const formStatus = this.preliminaryFormList.filter(data => !data.formStatus);
      if (formStatus && formStatus.length > 0) {
        this.incompleteList.push('Preliminary Alcohol and Other Drugs Sorting');
      }
    } else {
      this.incompleteList.push('Preliminary Alcohol and Other Drugs Sorting');
    }
    if (!this.authorizationForm.valid) {
      this.incompleteList.push('AUTHORIZATION');
    }
    if (this.incompleteList.length === 0) {
      this.submitForApproval();
    } else {
      (<any>$('#incomplete-items')).modal('show');
    }
  }

  openPicker(pickerclicked: any) {
    if(pickerclicked === 'picker2') {
      this.picker2.open();
    } else if(pickerclicked === 'picker1') {
      this.picker1.open();
    }
  }

  radioBtnChange() {
    if(this.preliminaryForm.value.isclientconsentreferral === '2') {
      this.preliminaryForm.patchValue({ isclientconsentreferraldate: null });
      this.preliminaryForm?.get('isclientconsentreferraldate')?.clearValidators();
      this.preliminaryForm?.get('isclientconsentreferraldate')?.updateValueAndValidity();
    }
  }

  onPickerClosed(event: any, controlName: string) {
    const control: any = this.preliminaryForm.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }

}

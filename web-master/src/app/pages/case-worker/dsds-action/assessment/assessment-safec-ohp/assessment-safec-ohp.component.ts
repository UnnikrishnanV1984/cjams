import { Component, OnInit, Injector, ChangeDetectorRef, ViewChild } from '@angular/core';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { Observable, of } from 'rxjs';
import { Router } from '@angular/router';
import { CommonHttpService, DataStoreService, CommonDropdownsService, AlertService, AuthService } from '../../../../../@core/services';
import { RoutingInfo } from '../../../_entities/caseworker.data.model';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AssessmentService } from '../assessment.service';
import moment from 'moment';
import { OWL_DATE_TIME_FORMATS, OwlDateTimeComponent, OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { CommonModule } from '@angular/common';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { ApprovalHistoryModule } from '../../../../../shared/shared-components/approval-history/approval-history.module';
import { GlobalPopupModule } from '../../../../../shared/shared-components/global-popup/global-popup.module';
import { MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';
import { NgxMaskDirective, provideNgxMask } from 'ngx-mask';
import { MatAutocompleteModule } from '@angular/material/autocomplete';

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
    selector: 'assessment-safec-ohp',
    templateUrl: './assessment-safec-ohp.component.html',
    styleUrls: ['./assessment-safec-ohp.component.scss'],
    imports:[GlobalPopupModule,ApprovalHistoryModule,MatRadioModule,MatCheckboxModule,MatFormFieldModule,MatInputModule,SignatureFieldModule,CommonModule,OwlDateTimeModule, OwlNativeDateTimeModule,OwlMomentDateTimeModule,MatSelectModule,ReactiveFormsModule,MatDatepickerModule,FormsModule,MatExpansionModule,NgxMaskDirective,MatAutocompleteModule ],
    providers:[provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
    standalone: true
})
export class AssessmentSafecOhpComponent implements OnInit {
  @ViewChild('picker1') picker1!: OwlDateTimeComponent<any>;
  @ViewChild('picker11') picker11!: OwlDateTimeComponent<any>;
  @ViewChild('picker4') picker4!: OwlDateTimeComponent<any>;
  @ViewChild('picker3') picker3!: OwlDateTimeComponent<any>;
  @ViewChild('picker2') picker2!: OwlDateTimeComponent<any>;
  ASSESSMENT_NAME = 'SAFE-C OHP';
  safecOhpData: any;
  id: any;
  daNumber: any;
  safecOhpForm!: FormGroup;
  dtformat2 = 'MM/DD/YYYY h:mm a';
  dtformat3 = 'MM/DD/YYYY h:mm:ss a';
  dtformat4 = 'YYYY-MM-DDTHH:mm:ss.SSSSZ'

  customFormat = {
    parseInput: 'MM/DD/YYYY h:mm:ss a',
    fullPickerInput: 'MM/DD/YYYY h:mm:ss a',
    datePickerInput: 'MM/DD/YYYY h:mm:ss a',
    timePickerInput: 'h:mm:ss a',
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY',
  };

  requiredForApproval: boolean = false;
  involvedPersons: any;
  safeCOHPchildList: any[] = [];
  selectedChild: any;
  routingInfo!: RoutingInfo[];
  routingSupervisors: any[]  = [];
  roleId!: AppUser;
  childsNames: any[]  = [];
  caseworkersignature: any = null;
  reroutesupervisorList: any[]  = [];
  currentAssessmentId: any;
  currentSubmissionId: any;
  currentDate: any;
  isSupervisor: boolean = false;
  suggestedAddress$!: Observable<any[]>;
  safetys: any[]  = [];
  isDisabled: boolean = false;
  currentdatetime = moment();
  
  private _commonHttpService: CommonHttpService;
  private _dataStoreService: DataStoreService;
  private _router: Router;
  private _authService: AuthService;
  private _alertService: AlertService;
  private _commonDDService: CommonDropdownsService;
  private _assessmentService: AssessmentService;
  private _formBuilder: FormBuilder;

  constructor(private injector : Injector, private cdr: ChangeDetectorRef){
      this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
      this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
      this._router = injector.get<Router>(Router);
      this._authService = injector.get<AuthService>(AuthService);
      this._alertService = injector.get<AlertService>(AlertService);
      this._commonDDService = injector.get<CommonDropdownsService>(CommonDropdownsService);
      this._assessmentService = injector.get<AssessmentService>(AssessmentService);
      this._formBuilder = injector.get<FormBuilder>(FormBuilder);
      this.id = this._commonDDService.getStoredCaseUuid();
      this.daNumber = this._commonDDService.getStoredCaseNumber();
  }

  ngOnInit() {
    this.involvedPersons = this._dataStoreService.getData('CASEWORKER_INVOLVED_PERSON');
    this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO');
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS');
    this.safecOhpData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.currentAssessmentId = this.safecOhpData?.assessmentid;
    this.currentSubmissionId = this.safecOhpData?.submissionid;
    this.roleId = this._authService.getCurrentUser();
    this._assessmentService.getservicecase();
    this.isSupervisor = (this?.roleId?.role?.name === 'apcs') ? true : false;
    const mode = this?.safecOhpData?.mode;
    let data = this?.safecOhpData?.submissiondata;
    this.currentDate = moment(new Date()).format(this.dtformat4);
    if(mode === 'submit') {
      data = this.handleIfModeIsSubmitFn(data);
    } else {
      if (this.involvedPersons?.length > 0) {
        this?.getSafeCOHPChildList(
          this?.getChildDetailsIncludingOther(this?.involvedPersons),
          this._dataStoreService.getData('CASEWORKER_PLACEMENT_INFO'));
      }
      if (!(this?.currentSubmissionId) && (this.safeCOHPchildList?.length > 0)) {
        this.selectedChild = this?.safeCOHPchildList[0];
        data = this.getChildData(this.selectedChild, this?.getCaseHead());
      }
      this.initSafecOhpForm(data);
    }
    this?.safecOhpForm?.get('ClientName')?.setValue(data?.clientid);
    this.setSafetys();
    this.setDisable(mode);

    setTimeout(() => {
      const ctrl = this.safecOhpForm.get('dateassessmentinitiated');
      ctrl?.updateValueAndValidity({ emitEvent: true });
      this.onPickerClosed('','dateassessmentinitiated');
    });
  }
  // Assosiated to ngOnInit method
  private handleIfModeIsSubmitFn(data: any) {
    if (!data && this?.safecOhpData?.migratedsubmissiondata) {
      data = JSON.parse(this?.safecOhpData?.migratedsubmissiondata);
    }
    this.initSafecOhpForm(data);
    this.safeCOHPchildList.push({
      childname: data?.ClientName,
      clientid: data?.clientid,
    });
    let tf1 = null;
    let tf2 = null;
    let tf3 = null;
    if (data?.timeframe) {
      tf1 = (typeof data?.timeframe[1] == "boolean") ? (data?.timeframe[1]) : JSON.parse(data?.timeframe)[1];
      tf2 = (typeof data?.timeframe[2] == "boolean") ? (data?.timeframe[2]) : JSON.parse(data?.timeframe)[2];
      tf3 = (typeof data?.timeframe[3] == "boolean") ? (data?.timeframe[3]) : JSON.parse(data?.timeframe)[3];
    }
    this.safecOhpForm.patchValue(this.returnSafecOhpFormDataFn(data, tf1, tf2, tf3));
    if (data?.currentplacement) {
      this.safecOhpForm.patchValue({
        currentplacement: true,
        potentialresource: false,
        address: true
      });
    }
    return data;
  }
  // Assosiated to ngOnInit method
  private returnSafecOhpFormDataFn(data: any, tf1: any, tf2: any, tf3: any): any {
    return {
      timeframe1: (data?.timeframe) ? this.returnTimeFrameBoolFn(tf1) : this.returnTimeFrameDataFn(data?.timeframe1),
      timeframe2: (data?.timeframe) ? this.returnTimeFrameBoolFn(tf2) : this.returnTimeFrameDataFn(data?.timeframe2),
      timeframe3: (data?.timeframe) ? this.returnTimeFrameBoolFn(tf3) : this.returnTimeFrameDataFn(data?.timeframe3),
      dateassessmentinitiated: data?.dateassessmentinitiated,
      safetydecision: data?.safetydecision,
      safetyinfluenceq1: data?.safetyinfluenceq1 + '',
      safetyinfluenceq2: data?.safetyinfluenceq2 + '',
      safetyinfluenceq3: data?.safetyinfluenceq3 + '',
      safetyinfluenceq4: data?.safetyinfluenceq4 + '',
      safetyinfluenceq5: data?.safetyinfluenceq5 + '',
      safetyinfluenceq6: data?.safetyinfluenceq6 + '',
      safetyinfluenceq7: data?.safetyinfluenceq7 + '',
      safetyinfluenceq8: data?.safetyinfluenceq8 + '',
      safetyinfluenceq9: data?.safetyinfluenceq9 + '',
      safetyinfluenceq10: data?.safetyinfluenceq10 + '',
      safetyinfluenceq11: data?.safetyinfluenceq11 + '',
      safetyinfluenceq12: data?.safetyinfluenceq12 + '',
      Wunsafe1: (typeof data?.Wunsafe1 == "boolean") ? data?.Wunsafe1 : (data?.Wunsafe1?.toLowerCase?.() === 'true'),
      Wunsafe2: (typeof data?.Wunsafe2 == "boolean") ? data?.Wunsafe2 : (data?.Wunsafe2?.toLowerCase?.() === 'true'),
      Wunsafe3: (typeof data?.Wunsafe2 == "boolean") ? data?.Wunsafe3 : (data?.Wunsafe3?.toLowerCase?.() === 'true'),
      supervisorname: (data?.supervisorname) ? (data?.supervisorname) : null,
    };
  }
  // Assosiated to ngOnInit method
  private returnTimeFrameDataFn(data: any) {
    return (data ? data : null);
  }
  // Assosiated to ngOnInit method
  private returnTimeFrameBoolFn(tf: any) {
    return (['t', true].includes(tf) ? true : false);
  }

  isReadyForApproval() {
    this.requiredForApproval = true;
    this.excludeValidation(this?.isSupervisor);
    if ((this?.safecOhpForm?.getRawValue()?.SignatureObtained === 'Yes') &&
      (!this?.safecOhpForm?.controls?.panel8068827005903365ColumnsDateTimeField.value)) {
      this.markControlsAsTouched(this.safecOhpForm);
      return;
    }
    if (this?.safecOhpForm?.valid) {
      if (this?.isSupervisor) {
        this.submitForApproval();
      } else {
        if (this?.safecOhpForm?.controls?.assessmentreviewed?.value === 'Review') {
          this.submitForApproval();
        } else {
          this.markControlsAsTouched(this.safecOhpForm);
        }
      }
    } else {
      this.markControlsAsTouched(this.safecOhpForm);
    }
  }

  submitForApproval() {
    const submissionData = this.safecOhpForm.getRawValue();
    this.updateISODateFormat(submissionData);
    if (!this.isSupervisor) {
      submissionData.submissionapprovaldate = moment(new Date()).format(this.dtformat2)
    }
    if (this.isSupervisor) {
      submissionData.assessmentStaus = this.safecOhpForm.get('assessmentstatus')?.value;
    } else {
      submissionData.assessmentStaus = 'Review';
    }
    submissionData.currentSubmissionId = this.currentSubmissionId;
    submissionData.routingsupervisors = this.routingSupervisors;
    this.setSubmissionData(submissionData);
    this._dataStoreService.setData('PRINTDATA', submissionData);
    this._assessmentService.saveSafecAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe(
        (_response) => {
          this._alertService.success(`${submissionData?.assessmentStaus} Submitted Successfully`);
          this.goBack();
        },
        (_error) => {
          this._alertService.error('Unable to submit for approval.');
        }
      );
  }

  goBack() {
    setTimeout(() => {
      this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
    }, 1000);
  }

  getValidationMessage(controlName: any, displayname: any) {
    if (['Comments'].includes(controlName) &&
      !(this?.safecOhpForm?.controls[controlName]?.value?.trim())) {
      return displayname + ' is required.';
    }
    if (this.safecOhpForm?.controls[controlName]?.status == 'INVALID') {
      return 'Please Select value ' + displayname;
    }
  }

  private markControlsAsTouched(formGroup: FormGroup) {
    Object.keys(formGroup.controls).forEach(key => {
      const control = formGroup.controls[key];
      if (control instanceof FormGroup) {
        this.markControlsAsTouched(control);
      } else {
        control.markAsTouched();
      }
    });
    this._alertService.error('Unable to save SAFE-C OHP. Please try again.');
  }

  initSafecOhpForm(data: any) {
    this.safecOhpForm = this._formBuilder.group({
      dateassessmentinitiated: (data?.dateassessmentinitiated) ? data?.dateassessmentinitiated : new Date(),
      caseid: data?.caseid,
      casehead: data?.casehead,
      ClientName: [data?.ClientName, Validators.required],
      clientid: data?.clientid,
      dob: (data?.dob) ? (data?.dob) : null,
      currentplacement: data?.currentplacement,
      potentialresource: data?.potentialresource,
      placementlivingarrangement: data?.placementlivingarrangement,
      staffmember: data?.staffmember,
      timeframe1: data?.timeframe1,
      timeframe2: data?.timeframe2,
      timeframe3: data?.timeframe3,
      safetyinfluenceq1: [data?.safetyinfluenceq1, Validators.required],
      safetyinfluenceq2: [data?.safetyinfluenceq2, Validators.required],
      safetyinfluenceq3: [data?.safetyinfluenceq3, Validators.required],
      safetyinfluenceq4: [data?.safetyinfluenceq4, Validators.required],
      safetyinfluenceq5: [data?.safetyinfluenceq5, Validators.required],
      safetyinfluenceq6: [data?.safetyinfluenceq6, Validators.required],
      safetyinfluenceq7: [data?.safetyinfluenceq7, Validators.required],
      safetyinfluenceq8: [data?.safetyinfluenceq8, Validators.required],
      safetyinfluenceq9: [data?.safetyinfluenceq9, Validators.required],
      safetyinfluenceq10: [data?.safetyinfluenceq10, Validators.required],
      safetyinfluenceq11: [data?.safetyinfluenceq11, Validators.required],
      safetyinfluenceq12: [data?.safetyinfluenceq12, Validators.required],
      unsafeinfluencesidentified: data?.unsafeinfluencesidentified,
      safetydecision: (data?.safetydecision) ? data?.safetydecision : null,
      panel45537735365179954RadioField: [{value: data?.panel45537735365179954RadioField, disabled :true}],
      safetydecision1: data?.safetydecision1,
      childIsUnsafeAnyInfluence112WasCheckedNo: data?.childIsUnsafeAnyInfluence112WasCheckedNo,
      Wunsafe1: data?.Wunsafe1,
      Wunsafe2: data?.Wunsafe2,
      Wunsafe3: data?.Wunsafe3,
      Comments: [data?.Comments, Validators.required],
      caseworkersign: data?.caseworkersign,
      SignatureObtained: data?.SignatureObtained,
      representativetitle: data?.representativetitle,
      localdepartment: data?.localdepartment,
      assessor: (data?.assessor) ? (data?.assessor) : (this?.roleId?.user?.userprofile?.fullname),
      supervisorname: (data?.supervisorname) ? (data?.supervisorname) : this._dataStoreService.getData('da_assignedby'),
      assessmentreviewed: [((data?.assessmentreviewed) ? (data?.assessmentreviewed) : 'InProcess'), Validators.required],
      safetyassessmentcompletiondate: [(data?.safetyassessmentcompletiondate) ? data?.safetyassessmentcompletiondate : null, Validators.required],
      reroutesupervisor: data?.reroutesupervisor,
      caseworkercomments: data?.caseworkercomments,
      assessmentstatus: [data?.assessmentstatus, Validators.required],
      approveddate: (data?.approveddate) ? data?.approveddate : null,
      supervisorcomments: data?.supervisorcomments,
      address: data?.address,
      addressline1: data?.addressline1,
      addressline2: data?.addressline2,
      zipcode: data?.zipcode,
      provideraddress: data?.provideraddress,
      fax: data?.fax,
      work: data?.work,
      ext: data?.ext,
      panel8068827005903365ColumnsDateTimeField: (data?.panel8068827005903365ColumnsDateTimeField) ? data?.panel8068827005903365ColumnsDateTimeField : null,
      assessmentStaus: (data?.assessmentStaus) ? (data?.assessmentStaus) : ['InProcess'],
    });
    this.safecOhpForm.get('panel45537735365179954RadioField')?.disable();
    if (data?.caseworkersign) {
      this.caseworkersignature = data?.caseworkersign;
    }
    if(data?.approveddate){
      this.safecOhpForm.patchValue({
        approveddate:  data?.approveddate
      });
    }
  }
  // Assosiated with initSafecOhpForm method
  private returnApproveddateFn() {
    return ((this?.isSupervisor) ? moment(new Date()).format(this.dtformat2) : null);
  }

  updateChildSafe(event: any, id: any) {
    this.safetys.forEach(sa => {
      if (sa?.key == id) {
        sa.value = event?.value;
      }
    });
    const unsafe = this.safetys.filter(s => s?.value === '0');
    this.safecOhpForm.patchValue({
      panel45537735365179954RadioField: 'childIsUnsafeAnyInfluence112WasCheckedNo'
    });
    if (unsafe?.length === 0) {
      this.safecOhpForm.patchValue({
        panel45537735365179954RadioField: 'safetydecision1'
      });
    }
     this.safecOhpForm.get('panel45537735365179954RadioField')?.disable();
  }

  signatureObtainedChange(event: any) {
    this.safecOhpForm.patchValue({
      panel8068827005903365ColumnsDateTimeField: null
    });
    if (event?.value === 'Yes') {
      ['panel8068827005903365ColumnsDateTimeField']?.forEach(e => {
        this?.safecOhpForm?.get(e)?.setValidators(Validators.required);
        this?.safecOhpForm?.get(e)?.updateValueAndValidity();
      });
    } else {

      ['panel8068827005903365ColumnsDateTimeField']?.forEach(e => {
        this.safecOhpForm.get(e)?.clearValidators();
        this.safecOhpForm.get(e)?.updateValueAndValidity();
      });
    }
  }

  changeSupervisor(userid: any) {
    const user = this.routingSupervisors.find(item => item?.userid === userid);
    if (user?.username) {
      this.safecOhpForm.patchValue({
        supervisorname: user?.username
      });
    }
  }

  changeClient(clientid: any) {
    this.safecOhpForm.patchValue({
      currentplacement: false,
      potentialresource: false,
      address: false
    });
    const childList: any = this?.safeCOHPchildList?.filter(c => c?.clientid === clientid);
    if (childList?.length > 0) {
      this.selectedChild = childList[0];
      this.safecOhpForm.patchValue({
        dateassessmentinitiated: (this.selectedChild?.dateassessmentinitiated) ? this.selectedChild?.dateassessmentinitiated : new Date(),
        caseid: this?.daNumber,
        ClientName: this.selectedChild?.childname,
        clientid: this.selectedChild?.clientid,
        dob: (this.selectedChild?.dob) ? this.selectedChild?.dob : null,
        placementlivingarrangement: this.selectedChild?.placementlivingarrangement,
        addressline1: this.selectedChild?.addressline1,
        addressline2: this.selectedChild?.addressline2,
        zipcode: this.selectedChild?.zipcode,
        provideraddress: this?.selectedChild?.provideraddress,
        ext: this?.selectedChild?.ext,
        fax: this?.selectedChild?.fax,
        work: this.selectedChild?.work,
        casehead: this?.getCaseHead()
      });
      this?.safecOhpForm?.get('ClientName')?.setValue(this.selectedChild?.clientid);
    }
  }

  showAddress(event: any, value: any) {
    this.resetValue(['currentplacement', 'potentialresource', 'address']);
    if (event.checked) {
      if (value === 'cp') {
        this.changeClient(this?.safecOhpForm?.getRawValue()?.ClientName);
        this.safecOhpForm.patchValue({
          currentplacement: true,
          address: true,
        });
      } else if (value === 'pr') {
        this.safecOhpForm.patchValue({
          potentialresource: true,
          address: true,
          placementlivingarrangement: null,
          addressline1: null,
          addressline2: null,
          zipcode: null,
          provideraddress: null,
          ext: '',
          fax: '',
          work: null,
        });
      }
    }
  }

  resetValue(l: any) {
    if (l?.length > 0) {
      l.forEach((e: any) => {
        this.safecOhpForm.get(e)?.reset();
      });
    }
  }

  saveForm() {
    const safecOhpFormData = this.safecOhpForm.getRawValue();
    this.updateISODateFormat(safecOhpFormData);
    safecOhpFormData.currentSubmissionId = this.currentSubmissionId;
    safecOhpFormData.routingsupervisors = this.routingSupervisors;
    this.setSubmissionData(safecOhpFormData);
    this._dataStoreService.setData('PRINTDATA', safecOhpFormData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, safecOhpFormData)
      .subscribe(
        (response) => {
          if (response?.data) {
            this.currentAssessmentId = response?.data?.assessmentid;
            this.currentSubmissionId = response?.data?.submissionid;
          } else {
            this.currentAssessmentId = response?.assessmentid;
            this.currentSubmissionId = response?.submissionid;
          }
          this._alertService.success(`Form Saved Successfully`);
        },
        (_error) => {
          this._alertService.error('Unable to save.');
        }
      );
  }

  resetSignatureCapture() {
    this.caseworkersignature = null
  }

  excludeValidation(isSupervisor: any) {
    if (isSupervisor) {
      ['assessmentstatus']?.forEach(e => {
        this?.safecOhpForm?.get(e)?.setValidators(Validators.required);
        this?.safecOhpForm?.get(e)?.updateValueAndValidity();
      });
      ['assessmentreviewed']?.forEach(e => {
        this.safecOhpForm.get(e)?.clearValidators();
        this.safecOhpForm.get(e)?.updateValueAndValidity();
      });
    } else {
      ['assessmentreviewed']?.forEach(e => {
        this?.safecOhpForm?.get(e)?.setValidators(Validators.required);
        this?.safecOhpForm?.get(e)?.updateValueAndValidity();
      });
      ['assessmentstatus']?.forEach(e => {
        this.safecOhpForm.get(e)?.clearValidators();
        this.safecOhpForm.get(e)?.updateValueAndValidity();
      });
    }
  }

  setSafetys() {
    this.safetys = [
      { key: 1, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq1 }, { key: 2, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq2 }, { key: 3, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq3 },
      { key: 4, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq4 }, { key: 5, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq5 }, { key: 6, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq6 },
      { key: 7, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq7 }, { key: 8, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq8 }, { key: 9, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq9 },
      { key: 10, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq10 }, { key: 11, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq11 }, { key: 12, value: this?.safecOhpForm?.getRawValue()?.safetyinfluenceq12 }
    ];
  }

  getChildDetailsIncludingOther(persons: any) {
    const REPORTED_CHILD = ['RC', 'CHILD', 'AV', 'OTHERCHILD'];
    const res = persons?.filter((child: any) => {
      let childFound = false;
      if (child?.dateofdeath) {
        return false;
      }
      if (child?.removaldate === null) {
        return false;
      }
      const roles = (Array.isArray(child?.roles)) ? (child?.roles) : [];
      roles.forEach((role: { intakeservicerequestpersontypekey: string; }) => {
        const childCategory = REPORTED_CHILD.find(category => category === role?.intakeservicerequestpersontypekey);
        if (childCategory) {
          childFound = true;
        }
      });
      return childFound;
    });
    return Array.isArray(res) ? res : [];
  }

  getSafeCOHPChildList(childs: any, placements: any) {
    childs?.forEach((child: { firstname: string; lastname: string; cjamspid: any; roles: any; dob: any; }) => {
      const pi = this.getProviderInfo(placements, child);
      this.safeCOHPchildList.push({
        childname: child?.firstname + ' ' + child?.lastname,
        clientid: child?.cjamspid,
        roles: child?.roles,
        age: this.getAge(child?.dob),
        dob: child?.dob,
        providerInfo: (pi?.providerInfo) ? (pi?.providerInfo) : null,
        hasActivePlacement: (pi?.hasActivePlacement) ? (pi?.hasActivePlacement) : null,
        provideraddress: (pi?.provideraddress) ? (pi?.provideraddress) : null,
        placementlivingarrangement: pi?.providerInfo?.providername,
        addressline1: this.getProviderAddressLine1(pi?.providerInfo),
        addressline2: this.getProviderAddressLine2(pi?.providerInfo),
        zipcode: pi?.providerInfo?.adr_zip5_no,
        ext: pi?.providerInfo?.ext,
        fax: pi?.providerInfo?.fax,
        work: pi?.providerInfo?.phonenumber
      });
    });
  }

  getProviderInfo(palcements:any, child: any) {
    let providerInfo = null;
    let hasActivePlacement = false;
    let provideraddress = null;
    if (child && palcements && Array.isArray(palcements)) {
      const childPlacments = palcements?.find(item => item?.personid === child?.personid);
      if (childPlacments && Array.isArray(childPlacments?.placements)) {
        const activeChildPlacment = childPlacments?.placements.find((item: any) => item?.placementtypekey === 'PRPL' && !item?.enddate && item?.routingstatus === 'Approved' && item?.isvoided === 0);
        hasActivePlacement = this.returnTrueOrFalseFn(activeChildPlacment);
        if(activeChildPlacment && activeChildPlacment?.cpahomerevision && activeChildPlacment?.cpahomerevision?.length>0) {
            provideraddress = activeChildPlacment?.cpahomerevision?.find((ele: any) => ele.exit_dt == null)?.provideraddress; //CDM-44429
        }
        if (activeChildPlacment && activeChildPlacment?.providerdetails) {
          providerInfo = activeChildPlacment?.providerdetails;
        }
      }
    }
    return { providerInfo, hasActivePlacement, provideraddress };
  }
  // Assosiated with getProviderInfo method
  private returnTrueOrFalseFn(activeChildPlacment: any) {
    return (activeChildPlacment ? true : false);
  }

  private getFormattedDate(dateValue: any) {
    if (dateValue && moment(dateValue, 'MM/DD/YYYY', true).isValid()) {
      return moment(dateValue).format('YYYY-MM-DD');
    } else {
      return '';
    }
  }

  private getAge(dateValue: any) {
    if (dateValue && moment(dateValue, 'MM/DD/YYYY', true).isValid()) {
      const rCDob = moment(dateValue, 'MM/DD/YYYY').toDate();
      return moment().diff(rCDob, 'years');
    } else {
      return '';
    }
  }

  getProviderAddressLine1(addressInfo: any) {
    return ('' + this.getValueOrEmptyString(addressInfo?.adr_street_no)
      + this.getValueOrEmptyString(addressInfo?.adr_box_no)
      + this.getValueOrEmptyString(addressInfo?.adr_street_tx)
      + this.getValueOrEmptyString(addressInfo?.adr_street_nm)
      + this.getValueOrEmptyString(addressInfo?.adr_street_suffix_cd)).trim();
  }

  getProviderAddressLine2(addressInfo: any) {
    return ('' + this.getValueOrEmptyString(addressInfo?.adr_unit_no_tx)
      + this.getValueOrEmptyString(addressInfo?.adr_city_nm)
      + this.getValueOrEmptyString(addressInfo?.adr_state_cd)).trim();
  }

  getValueOrEmptyString(value: any) {
    return value ? value + ' ' : '';
  }

  getChildData(child: any, casehead: any) {
    return {
      dateassessmentinitiated: child?.dateassessmentinitiated,
      caseid: this?.daNumber,
      ClientName: child?.childname,
      clientid: child?.clientid,
      dob: child?.dob,
      placementlivingarrangement: child?.placementlivingarrangement,
      addressline1: child?.addressline1,
      addressline2: child?.addressline2,
      zipcode: child?.zipcode,
      ext: '',
      fax: '',
      work: child?.work,
      casehead: casehead
    };
  }

  getCaseHead() {
    const headofhousehold = this?.involvedPersons?.filter((i: { isheadofhousehold: any; }) => i?.isheadofhousehold);
    let casehead = '';
    if (headofhousehold?.length > 0) {
      casehead = headofhousehold[0]?.fullname;
    }
    return casehead;
  }

  getSuggestedAddress() {
    if (this.safecOhpForm?.value?.addressline1 &&
      this.safecOhpForm?.value?.addressline1?.length >= 3) {
      this.suggestAddress();
    }
  }
  suggestAddress() {
    this._commonHttpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.safecOhpForm?.value?.addressline1,
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
        (result: any) => {
          if (result?.length > 0) {
            this.suggestedAddress$ = of(result);
          } else {
            this.suggestedAddress$ = of([]);
          }
        }
      );
  }

  selectedAddress(model: any) {
    this.safecOhpForm.patchValue({
      addressline1: (model?.streetLine) ? (model?.streetLine) : '',
      addressline2: ((model?.city) ? (model?.city) : '') +' '+ ((model?.state) ? (model?.state) : ''),
    });
    const addressInput = {
      street: (model?.streetLine) ? (model?.streetLine) : '',
      street2: '',
      city: (model?.city) ? (model?.city) : '',
      state: (model?.state) ? (model?.state) : '',
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
        (result) => {
          if (result[0]?.analysis) {
            this.handlrValidateAddressUrlResponseFn(result);
          }
        },
        (_error) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }

  private handlrValidateAddressUrlResponseFn(result: any) {
    if (result) {
      this.safecOhpForm.patchValue({
        zipcode: (result[0]?.components?.zipcode) ? (result[0]?.components?.zipcode) : ''
      });
    }
  }

  setDisable(mode: any) {
    if (mode === 'start' || mode === 'update') {
      this.isDisabled = false;
      this.safecOhpForm.enable();
       this.safecOhpForm.get('panel45537735365179954RadioField')?.disable();
    }
    if ((mode === 'submit') || ((this?.safecOhpData?.username) === 'Migrated')) {
      this.isDisabled = true;
      this.safecOhpForm.disable();
    }
  }
  updateISODateFormat(form: any) {
    form.dateassessmentinitiated = (form?.dateassessmentinitiated) ? (new Date(form?.dateassessmentinitiated)?.toISOString()) : null;
    form.approveddate = (form?.approveddate) ? (new Date(form?.approveddate)?.toISOString()) : null;
    form.safetydecision = (form?.safetydecision) ? (new Date(form?.safetydecision)?.toISOString()) : null;
  }

  setSubmissionData(submissionData: any) {
    if(this.safeCOHPchildList && this.safeCOHPchildList?.length>0) {
      const childList: any = this?.safeCOHPchildList?.filter(c => c?.clientid === submissionData?.clientid);
      if (childList?.length > 0) {
        this.selectedChild = childList[0];
        submissionData.ClientName = this.selectedChild?.childname;
        const assessmentactorlist: any[]  = [];
        if(this.selectedChild?.roles?.length > 0) {
          this.selectedChild?.roles?.forEach((e: any) => {
            assessmentactorlist.push({"intakeservicerequestactorid": e?.intakeservicerequestactorid});
          });
        }
        submissionData.assessmentactor = assessmentactorlist;
      }
    }
  }

  statusChange(event: any) {
    this.safecOhpForm.patchValue({
      approveddate:  null
    });
    if (event.value) {
      this.safecOhpForm.patchValue({
        approveddate:  moment(this.currentDate).format('MM/DD/YYYY h:mm:ss a')
      });
    }
    this.cdr.detectChanges();
  }

  openPicker(picker: any) {
    if(picker === 'picker1') {
      this.picker1.open();
    } else if(picker === 'picker2') {
      this.picker2.open();
    } else if(picker === 'picker3') {
      this.picker3.open();
    } else if(picker === 'picker4') {
      this.picker4.open();
    } else if(picker === 'picker11') {
      this.picker11.open();
    }
  }

  onPickerClosed(event: any, controlName: string) {
    const control: any = this.safecOhpForm.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }

}

import { Component, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Observable ,  Subscription } from 'rxjs';
import {share, map} from 'rxjs/operators';
import { InvolvedPersonsConstants } from '../../../../involved-persons/_entities/involvedPersons.constants';
import { AlertService, DataStoreService, ValidationService, AuthService } from '../../../../../../@core/services';
import { PersonHealthService } from '../../person-health.service';
import { PersonExaminationService } from '../person-examination.service';
import moment from 'moment';
import { IntakeStoreConstants } from '../../../../../newintake/my-newintake/my-newintake.constants';
import { DocumentUploadListSharedComponent } from '../../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../../../../pages/case-worker/_entities/caseworker.data.constants';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'examination-cw',
    templateUrl: './examination-cw.component.html',
    styleUrls: ['./examination-cw.component.scss'],
    standalone: false
})
export class ExaminationCwComponent implements OnInit {


  examinationInfoForm!: FormGroup;
  editMode!: boolean;
  reportMode!: string;
   requiredForApproval!: boolean;
  modalInt!: number;
  examinationList: any[] = [];
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  examTypeDropdownItems$!: Observable<any[]>;
  specialityExamTypeDropdownItems$!: Observable<any[]>;
  labTestDropdownItems$!: Observable<any[]>;
  stateDropdownItems$!: Observable<any[]>;
  countyDropDownItems$!: Observable<any[]>;
  appointments: any[] = [];
  isAddEdit = false;
  isProviderAvailable: any = null;
  healthSubscription!: Subscription;
  uploadedFiles: any[] = [];
  uploadNumber = '123434';
  selectedExamination: any = null;
  deleteIndex: any = null;
  examinationDisable = false;
  isClosed = false;
  errorMsg = 'Please fill required fields';
  address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false};
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  showlabtestother : boolean = false;
  showspecialexamother : boolean = false;
  retrydoc: any = false;
  examinationListCheck: any;
  examinationid: any;
  constructor(
    private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _healthService: PersonHealthService,
    private _service: PersonExaminationService,
    private _dataStoreService: DataStoreService,
    public _authService: AuthService,
    private route: ActivatedRoute
  ) {
    this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.examinationid = params['retryid'];
    });
  }

  ngOnInit() {
    this.reportMode = 'add';
    this.isClosed = this._authService.iscaseclosed('personhealth');
    this.examinationInfoForm = this.formbulider.group({
      affilication: '',
      speciality: '',
      physicianname: '',
      recommendations: '',
      comments: '',
      medicalreferrals: '',
      followupneeded: '',
      phone: '',
      physicianfaxnumber: '',
      email: ['', [ValidationService.mailFormat]]

    });

    this.loadExaminationList();

    this.route.queryParams.subscribe(params => {
      const status = params['examination'];
      if (status) {
        const examination = JSON.parse(this._dataStoreService.getData('person-health-summary'));
        this.view(examination);
      }
    });

    this.loadExaminationList();
  }

  resetAddress() {
    this.address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false};
  }



  loadExaminationList() {
    this._healthService.getExaminationList().subscribe(list => {
      if (list && Array.isArray(list) && list.length) {
        this.examinationList = list;
        this.examinationListCheck = this.examinationList.find(item => item.personexaminationid === this.examinationid);
          if (this.examinationListCheck && this.examinationid) {
              this.edit(this.examinationListCheck);
              this.examinationid = null;
          }
      }
    });
  }

  private resetForm() {

    this.examinationInfoForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.address.disable = false;
    this.examinationDisable = false;
    this.examinationInfoForm.enable();

  }


  view(examination: any) {
    const header: any = document.getElementById('examination-form-container');
    header.scrollIntoView();
    this.selectedExamination = examination;
    this.examinationDisable = false;
    this.isProviderAvailable = examination.providerinfoflag ? true : false;
    if (examination && Array.isArray(examination.appointment)) {
      this.appointments = examination.appointment;
      this.address.address1 =  examination.physician.address1;
      this.address.address2 =  examination.physician.address2;
      this.address.city =  examination.physician.city;
      this.address.state =  examination.physician.state;
      this.address.county =  examination.physician.county;
      this.address.zipcode =  examination.physician.zip;
      this.examinationInfoForm.patchValue(examination.physician);
      this.uploadedFiles = Array.isArray(examination.uploadpath) ? examination.uploadpath : [];
      if(this.appointments.length && this.appointments[0]) {
        this.appointments[0].covidimpacted = examination.covidimpacted; 
        this.appointments[0].covidtestconducted = examination.covidtestconducted;
        this.appointments[0].covidtestdate = examination.covidtestdate;
        this.appointments[0].typeoftest = examination.typeoftest;
        this.appointments[0].covidtestresults = examination.covidtestresults;
        this.appointments[0].exposedtocovid = examination.exposedtocovid;
      }
    }
    if(this.appointments.length && this.appointments[0] && this.appointments[0].labtestkey && this.appointments[0].showlabtestother) {
      this.appointments[0].labtestkey.pipe(map(res => {
        if( res === '7829') {
          this.appointments[0].showlabtestother = true; 
        } else {
          this.appointments[0].showlabtestother = false; 
  
        }
        }),share(),);
    }     
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.address.disable = true;
    this.editMode = false;
    this.examinationDisable = true;
    this.examinationInfoForm.disable();
  }

  edit(examination: any) {
    const header: any = document.getElementById('examination-form-container');
    header.scrollIntoView();
    this.reportMode = 'edit';
    this.editMode = true;
    this.selectedExamination = examination;
    this.isAddEdit = true;
    this.examinationDisable = false;
    this.isProviderAvailable = examination.providerinfoflag ? true : false;
    if (examination && Array.isArray(examination.appointment)) {
      this.appointments = examination.appointment;
      this.address.address1 =  examination.physician.address1;
      this.address.address2 =  examination.physician.address2;
      this.address.city =  examination.physician.city;
      this.address.state =  examination.physician.state;
      this.address.county =  examination.physician.county;
      this.address.zipcode =  examination.physician.zip;
      
      this.address.disable = false;
      this.examinationInfoForm.patchValue(examination.physician);
      this.uploadedFiles = this.getUploadPath(examination);
      if(this.appointments.length && this.appointments[0]) {
        this.appointments[0].covidimpacted = examination.covidimpacted; 
        this.appointments[0].covidtestconducted = examination.covidtestconducted;
        this.appointments[0].covidtestdate = examination.covidtestdate;
        this.appointments[0].typeoftest = examination.typeoftest;
        this.appointments[0].covidtestresults = examination.covidtestresults;
        this.appointments[0].exposedtocovid = examination.exposedtocovid;
      }
      if(this.appointments.length && this.appointments[0] && this.appointments[0].labtestkey && this.appointments[0].showlabtestother) {
        this.appointments[0].labtestkey.pipe(map(res => {   // NOSONAR  // This is function has less than 3 lines of identical code. Hence, marking it as no sonar.
          if( res === '7829') {
            this.appointments[0].showlabtestother = true; 
          } else {
            this.appointments[0].showlabtestother = false; 
    
          }
        }),share(),);
      }   
      this.checkAppointments()  
    }
    this.examinationInfoForm.enable();
  }

  getUploadPath(examination: any){
    return Array.isArray(examination.uploadpath) ? examination.uploadpath : [];
  }

  checkAppointments() {
    if (this.appointments.length && this.appointments[0]) {
      if (this.appointments[0].specialityexamkey === '7851') {
        this.showspecialexamother = true;
      }
      else {
        this.showspecialexamother = false;
      }
    }
  }



  cancel() {
    this.resetForm();
  }

  add() {
    this.requiredForApproval = true;

    if (this.appointments && this.appointments.length && this.appointments[0]) {
      const appointmentDate = this.appointments[0].apptDate;
      const natureOfExam = this.appointments[0].natureofexamkey;
      const isannualhealthvisit = this.appointments[0].isannualhealthvisit;
      const issemiannualdentalvisit = this.appointments[0].issemiannualdentalvisit;
      const covidImpacted = this.appointments[0].covidimpacted;
      const exposedToCovid = this.appointments[0].exposedtocovid;
      const covidTestConducted = this.appointments[0].covidtestconducted;
      const typeOfTest = this.appointments[0].typeoftest;
      const covidTestResults = this.appointments[0].covidtestresults;
      const covidTestDate = this.appointments[0].covidtestdate;
      const specialityexamkey = this.appointments[0].specialityexamkey;
      const starttime = this.appointments[0].starttime;
      const casenumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
      const intakenumber =this._dataStoreService.getData(IntakeStoreConstants.intakenumber);
      this.appointments[0].casenumber = casenumber ?? intakenumber ?? null;
      let covidCheckFailed = false;

      if (this.visitErrors(natureOfExam, isannualhealthvisit, issemiannualdentalvisit, specialityexamkey)){
        return;
      }

      if (covidImpacted) {
        covidCheckFailed = exposedToCovid === 'true' ? this.covidTestCheck(covidTestConducted, typeOfTest, covidTestResults, covidTestDate) : this.exposedtoCovidCheck(exposedToCovid);
      }

      if (this.requiredFieldsError(appointmentDate, natureOfExam, covidCheckFailed, starttime)) {
        return;
      }

      this.setSpecialityExamInfo();
      const data = {
        'appointment': this.appointments,
        'physician': null,
        'providerinfoflag': this.isProviderAvailable,
        'personexaminationid': null,
        'uploadpath': this.uploadedFiles,
        'covidimpacted': covidImpacted,
        'exposedtocovid': exposedToCovid,
        'covidtestconducted': covidTestConducted,
        'typeoftest': typeOfTest,
        'covidtestresults': covidTestResults,
        'covidtestdate': covidTestDate
      };
      this.saveExaminationDetails(data);
    } else {
      this._alertSevice.error(this.errorMsg);
    }
  }

  visitErrors(natureOfExam: any, isannualhealthvisit: any, issemiannualdentalvisit: any, specialityexamkey: any){
    if (this.annualHealthVisitError(natureOfExam, isannualhealthvisit)){
      return true;
    }

    if (this.semiAnnualHealthVisitError(natureOfExam,issemiannualdentalvisit)) {
      return true;
    }

    if (this.specialityExamError(natureOfExam, isannualhealthvisit, specialityexamkey, issemiannualdentalvisit)) {
      return true;
    }

    return false;
  }
  annualHealthVisitError(natureOfExam: any, isannualhealthvisit: any){
    if (natureOfExam === '3257' && (isannualhealthvisit === null || isannualhealthvisit === undefined)) {
      this._alertSevice.error('Please select Is this Annual Health Visit field');
      return true;
    } else {
      return false;
    }
  }
  semiAnnualHealthVisitError(natureOfExam: any, issemiannualdentalvisit: any){
    if (natureOfExam === '32926' && (issemiannualdentalvisit === null || issemiannualdentalvisit === undefined)) {
      this._alertSevice.error('Please select Is this Semi-Annual Dental Visit field');
      return true;
    } else {
      return false;
    }
  }
  specialityExamError(natureOfExam: any, isannualhealthvisit: any, specialityexamkey: any, issemiannualdentalvisit: any){
    if ((natureOfExam === '3257' && isannualhealthvisit === false && (specialityexamkey === null || specialityexamkey === undefined)) || (natureOfExam === '32926' && issemiannualdentalvisit === false && (specialityexamkey === null || specialityexamkey === undefined))) {
      this._alertSevice.error('Please select Speciality Exam field');
      return true;
    } else {
      return false;
    }
  }

  requiredFieldsError(appointmentDate: any, natureOfExam: any, covidCheckFailed: any, starttime: any) {
    if (this.appointments[0] && this.appointments[0].apptkept === null) {
      this._alertSevice.error(this.errorMsg);
      return true;
    }
    const dob = moment(new Date(this._dataStoreService.getData(IntakeStoreConstants.DATE_OF_BIRTH)));
    if (this.appointments[0] && this.appointments[0].notkeptreason === 'NKR1') {
      const age = moment().diff(dob, 'years', true);
      if (!this.appointments[0].authformcompletion && age >= 18) {
        this._alertSevice.error(this.errorMsg);
        return true;
      }
    }
    if (this.appointments[0] && this.appointments[0].authformcompletion === '2') {
      if (!this.appointments[0].notcompletedauthform) {
        this._alertSevice.error(this.errorMsg);
        return true;
      }
    }
    if (this.requiredFieldsError2(appointmentDate, natureOfExam, covidCheckFailed, starttime)){
      return true;
    }

    return false;
  }

  requiredFieldsError2(appointmentDate: any, natureOfExam: any, covidCheckFailed: any, starttime: any) {
    if (this.appointments[0] && this.appointments[0].notkeptreason === 'NKR6') {
      if (!this.appointments[0].otherreason) {
        this._alertSevice.error(this.errorMsg);
        return true;
      }
    }
    if (this.appointments[0] && this.appointments[0].notkeptreason === 'NKR7') {
      if (!this.appointments[0].provcaremissed) {
        this._alertSevice.error(this.errorMsg);
        return true;
      }
    }
    if (appointmentDate == null || natureOfExam == null || this.isProviderAvailable == null || covidCheckFailed || starttime == null || !starttime) {
      this._alertSevice.error(this.errorMsg);
      return true;
    }

    const currentDate = moment(new Date());
    const dob = moment(new Date(this._dataStoreService.getData(IntakeStoreConstants.DATE_OF_BIRTH)));
    if (this.appointments[0].specialityexamkey === null && currentDate.diff(dob, 'days') <= 1554 && (natureOfExam === '3257' || natureOfExam === '3256' || natureOfExam === '7833') && this.appointments[0].timeframe === null) {
      this._alertSevice.error(this.errorMsg);
      return true;
    }

    return false;
  }


  setSpecialityExamInfo() {
    if ((this.appointments[0].natureofexamkey === '32926' && this.appointments[0].issemiannualdentalvisit === true) || (this.appointments[0].natureofexamkey === '3257' && this.appointments[0].isannualhealthvisit === true)) {
      this.appointments[0].specialityexamkey = null;
    }
    if (this.appointments[0].specialityexamkey !== '7851') {
      this.appointments[0].specialityexamother = null;
    }
  }
  saveExaminationDetails(data: any) {
    const uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;
    if (!this.isProviderAvailable) {
      this.examinationInfoForm.reset();
      this.resetAddress();
    }
    const phyData = this.examinationInfoForm.getRawValue();
    const physicianInfo = { ...phyData, ...this.address, ...uploadInfo };
    physicianInfo.medicalreferrals = phyData.medicalreferrals;
    physicianInfo.followupneeded = phyData.followupneeded;
    physicianInfo.zip = this.address.zipcode;
    let personexaminationid = null;
    let isNew = 1;
    if (this.selectedExamination && this.selectedExamination.personexaminationid) {
      personexaminationid = this.selectedExamination.personexaminationid;
      isNew = 0;
    }
    data.physician = physicianInfo;
    data.personexaminationid = personexaminationid;
    if (data.uploadpath) {
      data.uploadpath.forEach((document: { percentage: any; }) => {
        if (document.percentage) {
          delete document.percentage;
        }
      });
    }
    this._healthService.saveHealth({ 'personExamination': [data] }, isNew).subscribe(_ => {
      if (this.reportMode === 'edit') {
        this._alertSevice.success('Examination Updated Successfully');
      } else {
        this._alertSevice.success('Examination Saved Successfully');
      }
      this.resetAll();
      this.loadExaminationList();
    });
  }
covidTestCheck(covidTestConducted: any, typeOfTest: any, covidTestResults: any, covidTestDate: any){
  return (covidTestConducted === 'true' ? this.covidtestTypeCheck(typeOfTest, covidTestResults, covidTestDate) : this.covidTestConductedCheck(covidTestConducted))
}
exposedtoCovidCheck(exposedToCovid: any){
  return (exposedToCovid === 'false'? false : true);
}
covidtestTypeCheck(typeOfTest: any, covidTestResults: any, covidTestDate: any){
  return (typeOfTest ? this.covidtestResultCheck(covidTestResults, covidTestDate) : true);
}
covidTestConductedCheck(covidTestConducted: any){
  return (covidTestConducted === 'false'? false : true);
}
covidtestResultCheck(covidTestResults: any, covidTestDate: any){
  return ((covidTestResults && covidTestDate) ? false : true);
}


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
  resetAll() {
    if(this.reportMode === 'add'){
    this.appointments[0].apptkept = null;
    this.appointments[0].apptDate = null;
    this.appointments[0].nextApptDate = null;
    this.appointments[0].natureofexamkey = null;
    this.appointments[0].isannualhealthvisit = null;
    this.appointments[0].issemiannualdentalvisit = null;
    this.appointments[0].labtestkey = null;
    this.appointments[0].specialityexamkey = null;
    this.appointments[0].hivtestreceived = null;
    this.appointments[0].nextappointmentreason = null;
    this.appointments[0].notkeptreason = null;
    this.appointments[0].covidimpacted = null; 
    this.appointments[0].covidtestconducted = null;
    this.appointments[0].covidtestdate = null;
    this.appointments[0].typeoftest = null;
    this.appointments[0].covidtestresults = null;
    this.appointments[0].exposedtocovid = null;
    this.appointments[0].timeframe = null;
    this.appointments[0].authformcompletion =null;    
    this.appointments[0].notcompletedauthform =null;
    this.appointments[0].provcaremissed = null;
    this.appointments[0].durationhours = null;
    this.appointments[0].durationmins = null;
    this.appointments[0].starttime = null;
    this.appointments[0].endtime = null;
    this.selectedExamination = null;
    this.resetAddress();
    this.isProviderAvailable = null;
    this.isAddEdit = true;
    this.resetForm();
    this.uploadedFiles = [];
    this.appointments[0].labtestother = null;
    this.appointments[0].specialityexamother = null;
    }else{
    this.appointments = [];
    this.selectedExamination = null;
    this.resetAddress();
    this.isProviderAvailable = null;
    this.isAddEdit = false;
    this.resetForm();
    this.uploadedFiles = [];
    }
    
  }



  addNewExamination() {
    this.isAddEdit = true;
    const appointment = this._service.getNewAppointment();
    this.appointments = [appointment];
  }

  deleteConfirm(item: any, index: any) {
    (<any>$('#delete-popup')).modal('show');
    this.selectedExamination = item;
    this.deleteIndex = index;
  }

  delete() {
    this.reportMode = 'delete';
    this.examinationList.splice(this.deleteIndex, 1);
    const data = {
      'personexaminationid': this.selectedExamination.personexaminationid,
    };
    this._healthService.saveHealth({ 'personExamination': [data] }, 2).subscribe(_ => {
      this._alertSevice.success('Deleted Examination Successfully');
      this.resetAll();
      this.loadExaminationList();
    });
  }

  getDateFormatted(date:any){
    if(date && moment(date).isValid()){
      return moment(date).format('MM/DD/YYYY');
    }else{
      return '';}
  }

}

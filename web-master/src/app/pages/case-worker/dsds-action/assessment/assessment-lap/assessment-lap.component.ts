import { Component, OnInit, Injector, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonHttpService, DataStoreService, CommonDropdownsService, AlertService, AuthService, SessionStorageService } from '../../../../../@core/services';
import { RoutingInfo } from '../../../_entities/caseworker.data.model';
import { AssessmentService } from '../assessment.service';
import moment from 'moment';
import { Router } from '@angular/router';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PaginationRequest, DropdownModel } from '../../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Observable } from 'rxjs';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config' ;//'../../case-worker/case-worker-url.config';
import { OwlDateTimeComponent } from '@danielmoncada/angular-datetime-picker';

@Component({
    selector: 'assessment-lap',
    templateUrl: './assessment-lap.component.html',
    styleUrls: ['./assessment-lap.component.scss'],
    standalone: false
})
export class AssessmentLapComponent implements OnInit {
  @ViewChild('picker11') picker11!: OwlDateTimeComponent<any>;
  @ViewChild('picker1') picker1!: OwlDateTimeComponent<any>;
  assessmentLapForm!: FormGroup;
  currentAssessmentId: any;
  currentSubmissionId!: string;
  ASSESSMENT_NAME = 'LAP (Lethality Assessment Program)';
  involvedPersons: any;
  safeCOHPchildList: any;
  selectedChild: any;
  routingInfo!: RoutingInfo[];
  routingSupervisors: any[] = [];
  assessmentLapData: any;
  currentDate: any;
  id: any;
  daNumber: any;
  // assessmentInitDate: any;
  dtformat1 = 'YYYY-MM-DDTHH:mm';
  dtformat2 = 'MM/DD/YYYY h:mm a';
  roleId!: AppUser;
  isSupervisor: boolean = false;
  isDisabled: boolean = false;
  store: any;
  agency!: string;
  permanencyGoalsResponse = null;
  isCW!: boolean;
  isServiceCase: any;
  legalGuardian: any[] = [];
  legalGuardianother: any[] = [];
  providercjamspid!: { name: string; cjamspid: string; }[];
  personList: any[] = [];
  otherpersonList: any[] = [];
  headofhousehold: any;
  selectedYouthName = '';
  legalStatusValueChange = false;
  childList: any[] = [];
  legalCustodyDropdownItems$!: Observable<DropdownModel[]>;
  dtformat = 'MM/DD/YYYY';
  caseworkersignature: any = null;
  supervisorsignature:any = null;
  raceDropdownItems$!: Observable<any[]>;
  ethnicityDropdownItems$!: Observable<any[]>;
  submitForApprovalClicked: boolean = false;
  showHotlineNumberField:boolean = false;
  saveAsDraftClicked: boolean = false;
  relationShipToRADropdownItems!: DropdownModel[];
  viewAssementLap!: boolean;
  clientSignature!: boolean | null;
  isClientSignAlertClicked = false;
  isClientSignDocument: boolean = false;
  clientSignatureRequired: boolean = false;
  currentdatetime = moment();
  stateleadership: any = '';

  private fb: FormBuilder;
  private _dataStoreService: DataStoreService;
  private _commonDDService: CommonDropdownsService;
  private _assessmentService: AssessmentService;
  private _alertService: AlertService;
  private _authService: AuthService;
  private _router: Router;
  private _commonHttpService: CommonHttpService;
  private storage: SessionStorageService

  constructor(private readonly injector : Injector) {

    this.fb = this.injector.get<FormBuilder>(FormBuilder);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._assessmentService = this.injector.get<AssessmentService>(AssessmentService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._router = this.injector.get<Router>(Router);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);

    this.id = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._commonDDService.getStoredCaseNumber();
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit(): void {
    this._assessmentService.getservicecase();
    this.involvedPersons = this._dataStoreService.getData('CASEWORKER_INVOLVED_PERSON');
    this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO');
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS');
    this.assessmentLapData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.currentAssessmentId = this.assessmentLapData?.assessmentid;
    this.currentSubmissionId = this.assessmentLapData?.submissionid;

    this.currentDate = moment(new Date()).format(this.dtformat1);
    this.roleId = this._authService.getCurrentUser();
    this.isSupervisor = (this?.roleId?.role?.name === 'apcs') ? true : false;
    this.raceDropdownItems$ = this._commonDDService.getPickListByName('race');
    this.ethnicityDropdownItems$ = this._commonDDService.getPickListByName('ethnicity');
    let data = this?.assessmentLapData?.submissiondata;

    if (this.assessmentLapData && this.assessmentLapData.mode === 'submit') {
      this.viewAssementLap = true;
    } else {
      this.viewAssementLap = false;
    }
    this.initializeForm(data);
   let arr: any =this.getFormControlNamesToValidate();
   this.updateValidationForSendForApprovalAction(arr)
    this.getRelationList();
    this.getStateConfigInfo();
    if(this.isSupervisor) {
      this.assessmentLapForm.get("assessmentstatus")?.setValidators([Validators.required]);
      this.assessmentLapForm.get("assessmentstatus")?.updateValueAndValidity();
      
      this.assessmentLapForm.get("caseWorkerComments")?.disable();
      this.assessmentLapForm.get("caseWorkerComments")?.updateValueAndValidity();
      this.assessmentLapForm.get("assementSubmissionDateTime")?.disable();
      this.assessmentLapForm.get("assementSubmissionDateTime")?.updateValueAndValidity();

    } else {
      this.assessmentLapForm.get("supervisorSignatureDateTime")?.disable();
      this.assessmentLapForm.get("supervisorSignatureDateTime")?.updateValueAndValidity();
      this.assessmentLapForm.get("supervisorComments")?.disable();
      this.assessmentLapForm.get("supervisorComments")?.updateValueAndValidity();
    }
    if (this?.assessmentLapData?.mode === 'update') {
      this.isDisabled = false;
    }
    if (((this?.assessmentLapData?.mode) === 'submit') || ((this?.assessmentLapData?.username) === 'Migrated')) {
      this.isDisabled = true;
      this.assessmentLapForm.disable();
    }

    this.agency = this._authService.getAgencyName();
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    if (this.agency === 'CW') {
      this.isCW = true;
    } else {
      this.isCW = false;
    }
    this.getInvolvedPerson();
  }

  assessmentStatusChange(event: { value: string; }){
    if(this.isSupervisor && event.value === "Rejected") {
      this.assessmentLapForm.get("supervisorComments")?.setValidators([Validators.required]);
      this.assessmentLapForm.get("supervisorSignature")?.clearValidators();
      this.assessmentLapForm.get("supervisorSignatureDateTime")?.clearValidators();
    } else {
      this.assessmentLapForm.get("supervisorComments")?.clearValidators();
      if(this.isSupervisor  && event.value === "Accepted") {
        this.assessmentLapForm.get("supervisorSignature")?.setValidators([Validators.required]);
        this.assessmentLapForm.get("supervisorSignatureDateTime")?.setValidators([Validators.required]);
      }

    }

    this.assessmentLapForm.get("supervisorComments")?.updateValueAndValidity();
    this.assessmentLapForm.get("supervisorSignature")?.updateValueAndValidity();
    this.assessmentLapForm.get("supervisorSignatureDateTime")?.updateValueAndValidity();

  }

  resetSignatureCapture() {
    this.caseworkersignature = null
  }

  resetSupervisorSignatureCapture(){
    this.supervisorsignature =null;
  }

  resetClientSIgnature() {
    this.clientSignature = null;
  }

  validateMandatoryFields(controlName: any, groupName: any = null){
    if (groupName) {
      return this.assessmentLapForm.get(`${groupName}.${controlName}`)?.errors?.required;
    } else {
      return this.assessmentLapForm.get(controlName)?.errors?.required;
    }
  }

  updateValidationForSaveAsDraftAction(arr: any[]=[]){

    arr.forEach((ele: any)=>{
      if(ele.dependencyControlName){
        this.saveDraftValidate(ele);
      } else if(ele.formGroupName)  {
        this.assessmentLapForm.get(ele.formGroupName)?.get(ele.controlName)?.clearValidators();
        this.assessmentLapForm.get(ele.formGroupName)?.get(ele.controlName)?.updateValueAndValidity();
      } else {
        this.saveDraftValidate(ele);
      }
    })
  
  }

  saveDraftValidate(ele: any){
    this.assessmentLapForm.get(ele.controlName)?.clearValidators();
    this.assessmentLapForm.get(ele.controlName)?.updateValueAndValidity();
  }

  updateValidationForSendForApprovalAction(arr = []){

    arr.forEach((ele: any)=>{
      if((ele.controlName =="signatureReport" && !this.isSupervisor) || (ele.dependencyControlName && ele.anyValue && this.assessmentLapForm.get(ele.dependencyControlName)?.value) ||
      (ele.dependencyControlName && this.assessmentLapForm.get(ele.dependencyControlName)?.value && (this.assessmentLapForm.get(ele.dependencyControlName)?.value == ele.value)) ||
      (!ele.dependencyControlName && !ele.formGroupName)) {
        this.assessmentLapForm.get(ele.controlName)?.setValidators([Validators.required]);
        this.assessmentLapForm.get(ele.controlName)?.updateValueAndValidity();
      }
      else if(ele.formGroupName)  {
        this.assessmentLapForm.get(ele.formGroupName)?.get(ele.controlName)?.setValidators([Validators.required]);
        this.assessmentLapForm.get(ele.formGroupName)?.get(ele.controlName)?.updateValueAndValidity();
      }
    })
 
    this.assessmentLapForm.updateValueAndValidity();
  }

  initializeForm(data: any) {
    this.assessmentLapForm = this.fb.group({
      assessmentstatus: [data?.assessmentstatus],
      victiminfo: [data?.victiminfo, Validators.required],
      cjamspid : [data?.cjamspid],
      clientName: [data?.clientName],
      dob: [data?.dob],
      gender: [data?.gender],
      raceEthnicity: [data?.raceEthnicity],
      date: [data?.date ? data?.date : this.returnDateFn(data) ],
      time: [data?.time],
      Practitioner: [data?.Practitioner],
      email: [data?.email],
      ldss: [data?.ldss],
      caseNumber: [data?.caseNumber],
      clientPhone: [data?.clientPhone],
      isSafeNumber: [data?.isSafeNumber],
      relationshipToOffender: [data?.relationshipToOffender],
      consentFollowUp: [data?.consentFollowUp],
      Checkhereifvictimdeclinedtobescreened: [data?.Checkhereifvictimdeclinedtobescreened],
      Checkadvisedvictimdutytoreportscrenned: [data?.Checkadvisedvictimdutytoreportscrenned],
      Checkhereifthepractitioner: [data?.Checkhereifthepractitioner],
      HighDangerassessment: this.fb.group({
        0: [data?.HighDangerassessment["0"]],
        1: [data?.HighDangerassessment["1"]],
        2: [data?.HighDangerassessment["2"]]
      }),
      HighDangerassessment2: this.fb.group({
        4: [data?.HighDangerassessment2["4"]],
        5: [data?.HighDangerassessment2["5"]],
        6: [data?.HighDangerassessment2["6"]],
        7: [data?.HighDangerassessment2["7"]],
        8: [data?.HighDangerassessment2["8"]],
        9: [data?.HighDangerassessment2["9"]],
        10: [data?.HighDangerassessment2["10"]],
        '11DoesHeSheTheyFollowOrSpyOnYouOrLeaveThreateningMessages': [data?.HighDangerassessment2["11DoesHeSheTheyFollowOrSpyOnYouOrLeaveThreateningMessages"]]

      }),
      panel2740773786278622Columns2TextField: [data?.panel2740773786278622Columns2TextField],
      panel2740773786278622ColumnsRadioField: [data?.panel2740773786278622ColumnsRadioField],
      panel2740773786278623Columns: [data?.panel2740773786278623Columns],
      Didthevictimspeakwiththehotlineadvocate: [data?.Didthevictimspeakwiththehotlineadvocate],
      panel2740773786278623Checkhereifthevictimrequestthatthehotlinenotbecalled:[data?.panel2740773786278623Checkhereifthevictimrequestthatthehotlinenotbecalled],
      Checkhereifclientconsent:[data?.Checkhereifclientconsent],
      assessmentreviewed: [data?.assessmentreviewed ? data?.assessmentreviewed: "InProcess", Validators.required],
      supervisorname: [data?.supervisorname],
      caseworkername: [data?.caseworkername],
      reroutesupervisor: [data?.reroutesupervisor],
      assementSubmissionDateTime:    [(data?.assementSubmissionDateTime) ? (data?.assementSubmissionDateTime) : null,],
   
      supervisorSignatureDateTime: [(data?.supervisorSignatureDateTime) ? (data?.supervisorSignatureDateTime) : null,],
      
      signatureReport: [data?.signatureReport],
      supervisorSignature: [data?.supervisorSignature ? data?.supervisorSignature : data?.Signature ],
      caseWorkerComments: [data?.caseWorkerComments],
      supervisorComments: [data?.supervisorComments],
      assessmentStaus: (data?.assessmentStaus) ? (data?.assessmentStaus) : ['InProcess'],
      HotlineNumber:[data?.HotlineNumber],
      clientSignature:[data?.clientSignature],
      clientSignedDocument:[data?.clientSignedDocument],
    });
    if(data?.panel2740773786278623Columns === "Yes") {
      this.showHotlineNumberField = true;
    }
    if (data?.signatureReport) {
      this.caseworkersignature = data?.signatureReport;
    }
    if (data?.supervisorSignature || data?.Signature) {
      this.supervisorsignature = data?.supervisorSignature  ? data?.supervisorSignature : data?.Signature ;
    }
    if (data?.clientSignature) {
      this.clientSignature = data?.clientSignature;
    }

    if (data?.clientSignedDocument) {
      this.handleClientSigedDocumentn();
    }
  }


  private returnDateFn(data: any) {
    return (data?.Date ? moment(new Date(data?.Date)).format(this.dtformat) : null);
  }

  changeSupervisor(userid: any) {
    const user: any = this.routingSupervisors.find((item: any) => item?.userid === userid);
    if (user?.username) {
      this.assessmentLapForm.patchValue({
        supervisorname: user?.username
      });
    }
  }
  saveAsDraft() {
    
    this.submitForApprovalClicked = false;
    this.saveAsDraftClicked = true;
    let arr =this.getFormControlNamesToValidate();
    this.updateValidationForSaveAsDraftAction(arr);
    if (this.assessmentLapForm.invalid) {
      this._alertService.error('Please fill mandatory fields');
      return
    }
    const assessmentLapFormData = this.assessmentLapForm.getRawValue();
    assessmentLapFormData.currentSubmissionId = this.currentSubmissionId;
    assessmentLapFormData.routingsupervisors = this.routingSupervisors;
    this._dataStoreService.setData('PRINTDATA', assessmentLapFormData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, assessmentLapFormData)
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
        (error) => {
          this._alertService.error('Unable to save.');
        }
      );
  }


  handleClientSigedDocumentn(){
    this.isClientSignDocument = this.assessmentLapForm.get("clientSignedDocument")?.value;
    if(this.isClientSignDocument || this.isSupervisor) {
      this.clientSignatureRequired = false;
    } else {
      this.clientSignatureRequired = true;
    }
  }

  continueSendForApproval(){
    (<any>$('#clientSignnature-alert')).modal('hide');
      this.submitForApproval(true)    
  }

  getFormControlNamesToValidate(){
    return [
      {dependencyControlName:"clientPhone",controlName:"isSafeNumber", anyValue:true},
      {formGroupName:"HighDangerassessment",controlName:"0"},
      {formGroupName:"HighDangerassessment",controlName:"1"},
      {formGroupName:"HighDangerassessment",controlName:"2"},
      {formGroupName:"HighDangerassessment2",controlName:"4"},
      {formGroupName:"HighDangerassessment2",controlName:"5"},
      {formGroupName:"HighDangerassessment2",controlName:"6"},
      {formGroupName:"HighDangerassessment2",controlName:"7"},
      {formGroupName:"HighDangerassessment2",controlName:"8"},
      {formGroupName:"HighDangerassessment2",controlName:"9"},
      {formGroupName:"HighDangerassessment2",controlName:"10"},
      {formGroupName:"HighDangerassessment2",controlName:"11DoesHeSheTheyFollowOrSpyOnYouOrLeaveThreateningMessages"},


      {controlName:"relationshipToOffender"},
      {controlName:"consentFollowUp"},
      {controlName:"panel2740773786278622Columns2TextField"},
      {controlName:"panel2740773786278622ColumnsRadioField"},

      {controlName:"panel2740773786278623Columns"},
      {dependencyControlName:"panel2740773786278623Columns",controlName:"HotlineNumber", value:"Yes"},
      {controlName:"Didthevictimspeakwiththehotlineadvocate"},
      {controlName:"assementSubmissionDateTime"},
      {controlName:"signatureReport"},
      {controlName:"caseWorkerComments"},
    ];
  }

  submitForApproval(clientSignatureChecked=false) {
    const clientSignatureCheck = !this.assessmentLapForm.get("clientSignature")?.value && !this.assessmentLapForm.get("clientSignedDocument")?.value && !this.isSupervisor;
    if(!this.isSupervisor) {
      let arr: any =this.getFormControlNamesToValidate();
      this.updateValidationForSendForApprovalAction(arr)
    }
    this.submitForApprovalClicked = true;
    this.saveAsDraftClicked = false;
    if (this.assessmentLapForm.invalid) {
      this._alertService.error('Please fill mandatory fields');
      if(clientSignatureCheck) {
        this.clientSignatureRequired = true;
       
      }
      return
    }

    if(this.assessmentLapForm.get("assessmentreviewed")?.value  === "InProcess") {
      this._alertService.error('Please select review for submit for approval');
      if(clientSignatureCheck ) {
        this.clientSignatureRequired = true;
       
      }
      return
    }
    if(clientSignatureCheck) {
      this._alertService.error('Please select Client Signature');      
      this.clientSignatureRequired = true;
      return
    }
    
    this.clientSignatureRequired = false;
  
        if(this.isClientSignDocument && !clientSignatureChecked  && !this.isSupervisor) {
        (<any>$('#clientSignnature-alert')).modal('show');
        return;
      }
    const submissionData = this.assessmentLapForm.getRawValue();
    if (!this.isSupervisor) {
      submissionData.submissionapprovaldate = moment(new Date()).format(this.dtformat1)
    }
    if (this.isSupervisor) {
      submissionData.assessmentStaus = this.assessmentLapForm.get('assessmentstatus')?.value;
    } else {
    submissionData.assessmentStaus = 'Review';
     }
    submissionData.currentSubmissionId = this.currentSubmissionId;
    submissionData.routingsupervisors = this.routingSupervisors;
    submissionData.comments = submissionData.caseWorkerComments;
    this._dataStoreService.setData('PRINTDATA', submissionData);
    this._assessmentService.saveSafecAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe(
        (response) => {
          this._alertService.success(`${submissionData?.assessmentStaus} Submitted Successfully`);
          this.goBack();
        },
        (error) => {
          this._alertService.error('Unable to submit for approval.');
        }
      );
  }

  goBack() {
    setTimeout(() => {
      this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
    }, 1000);
  }


  getCaseHead() {
    const headofhousehold = this?.involvedPersons?.filter((i: { isheadofhousehold: any; }) => i?.isheadofhousehold);
    let casehead = '';
    if (headofhousehold?.length > 0) {
      casehead = headofhousehold[0]?.fullname;
    }
    return casehead;
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
        if (response && response.data && response.data.length) {
          this.providercjamspid = response.data.reduce((acc, item) => {
            acc[item.fullname.trim()] = item.cjamspid;
            return acc;
          }, {});
          this.personList = response.data;
          this.personcheck();

        }

      });
  }

  personcheck() {
    const other = this.personList.filter((e) => (e.ishousehold !== 1))
    this.otherpersonList = other;
    this.handleIfKeyIsChildFilterFn();
  }

  //     // Assosiated with personcheck method
  private handleIfKeyIsChildFilterFn() {
    this.personList.forEach(list => {
      if (list.isheadofhousehold === true) {
        this.headofhousehold = list;
      }

      if (list.roles) {
        const child = list.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD' || roleid.intakeservicerequestpersontypekey === "PARENT");
        if (child && child.length > 0) {
          list.fullname = list.fullname.split(" ").filter((fullname: string)=>fullname !="").map((fullname: string)=>fullname.trim()).join(" ")
          this.childList.push(list);
        }
      }

    });
  }



  formatdob(dob: any) {
    if (dob) {
      return moment(dob,).format('MM-DD-YYYY');
    }
    else {
      return '';
    }
  }

  setRaceEthinicity(race: any, ethinicity: any) {

    let raceDesc = "NA";
    let ethinicityDesc = "NA";
    if (race && ethinicity) {
      let racetype: any[] = [];
      this.raceDropdownItems$.subscribe(data => {
        racetype = data.filter(item => item.ref_key === race)
        raceDesc = racetype[0]?.description;
        let ethnicitytype: any[] = [];
        ethinicityDesc = '';
        this.ethnicityDropdownItems$.subscribe(dataa => {
          ethnicitytype = dataa.filter(item => item.ref_key === ethinicity);
          ethinicityDesc = ethnicitytype.length > 0 ? ethnicitytype[0].description : '';
      
          this.assessmentLapForm.patchValue({
            raceEthnicity: raceDesc + "/ " + ethinicityDesc
          });
      
          this.assessmentLapForm.get('raceEthnicity')?.updateValueAndValidity();
        });
      });

    } else if (race && !ethinicity) {
      let racetype = [];
      this.raceDropdownItems$.subscribe(data => {
        racetype = data.filter(item => item.ref_key === race[0].racetypekey)
        raceDesc = racetype[0]?.description
        this.assessmentLapForm.patchValue({
          raceEthnicity: raceDesc + "/ " + ethinicityDesc
        })
        this.assessmentLapForm.get('raceEthnicity')?.updateValueAndValidity();
      })
    } else if (!race && ethinicity) {
      let ethnicitytype = [];
      this.ethnicityDropdownItems$.subscribe(data => {
        ethnicitytype = data.filter(item => item.ref_key === ethinicity)
        ethinicityDesc = ethnicitytype[0]?.description;

        this.assessmentLapForm.patchValue({
          raceEthnicity: raceDesc + "/ " + ethinicityDesc
        })
        this.assessmentLapForm.get('raceEthnicity')?.updateValueAndValidity();
      });
    } else {
      this.assessmentLapForm.patchValue({
        raceEthnicity: raceDesc + "/ " + ethinicityDesc
      })
      this.assessmentLapForm.get('raceEthnicity')?.updateValueAndValidity();
    }



  }



  selectChild(childFullName: string): void {
    const event = this.childList.find(item => item.fullname === childFullName);
  
    if (!event) {
      console.warn(`No child found with fullname: ${childFullName}`);
      return;
    }
  
    const userDetails = this._authService.getCurrentUser();
  
    if (!userDetails || !userDetails.user || !userDetails.user.userprofile) {
      return;
    }
  
    const userProfileAddressCounty =  userDetails.user.userprofile?.userprofileaddress[0]?.county
    const team = userDetails.user.userprofile?.teammemberassignment?.teammember?.team;
    const ldss = team ?  team?.county?.countyname : userProfileAddressCounty;
    this.setRaceEthinicity(event?.race?.[0]?.racetypekey, event?.ethinicity);
  
    this.assessmentLapForm.patchValue({
      dob: this.formatdob(event.dob),
      gender: event.gender,
      date: moment().format(this.dtformat),
      time: moment(new Date()).format("hh:mm a"),
      Practitioner: userDetails.user.userprofile.fullname,
      email: userDetails.user.email,
      ldss: ldss,
      caseNumber: this?.daNumber,
      clientPhone: event.phonenumber,
      caseworkername: userDetails.user.userprofile.fullname,
      supervisorname: this._dataStoreService.getData('da_assignedby'),
      assessmentreviewed: "InProcess",
      cjamspid: event.cjamspid
    });
  
    this.assessmentLapForm.updateValueAndValidity();
  }

  formatPhoneNumber(phoneNumber: string) {
    return this._commonDDService.formatPhoneNumber(phoneNumber);
  }

  handleHotlineResponse(event: any) {
    if(event.value ==="Yes") {
      this.showHotlineNumberField = true;
    } else {
      this.showHotlineNumberField = false;
    }
  }

  getRelationList() {
    this._commonHttpService.getArrayList(
      {
        where: { activeflag: 1, teamtypekey: this._authService.getAgencyName() },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .RelationshipTypesUrl + '?filter'
    ).subscribe(data => {
      if (data && data.length) {
        this.setRelationList(data);
      }
    });
  }

  setRelationList(data: any) {
    if (data && data.length) {
      this.relationShipToRADropdownItems = data.map((res: { description: any; relationshiptypekey: any; }) => {
        return new DropdownModel({
          text: res.description,
          value: res.relationshiptypekey
        });
      });
    }
  }

  openPicker(picker: any) {
    if(picker === 'picker1') {
      this.picker1.open();
    } else if(picker === 'picker11') {
      this.picker11.open();
    }
  }

  onPickerClosed(event: any, controlName: string) {
    const control: any = this.assessmentLapForm.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }

  getStateConfigInfo() {
    this._commonHttpService.getArrayList({
      method: 'post', where: {}
    }, 'admin/assessment/getstateconfiginfo').subscribe((res:any) => {
      if (res?.stateinfo?.length){
        const governor = res.stateinfo[0].governor ?? '';
        const ltgovernor = res.stateinfo[0].ltgovernor ?? '';
        const dhssecretary = res.stateinfo[0].dhssecretary ?? '';
        this.stateleadership = governor + ', Governor | ' + ltgovernor + ', Lt. Governor | ' + dhssecretary + ', Secretary';
      }
    })
  }

}
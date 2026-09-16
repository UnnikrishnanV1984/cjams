import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, Validators } from '@angular/forms';
import { CommonHttpService, AlertService, DataStoreService } from '../../../../@core/services';
import { ActivatedRoute} from '@angular/router';
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';
import { DatePipe } from '@angular/common';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AuthService } from '../../../../@core/services/auth.service';
import { AppConstants } from '../../../../@core/common/constants';
import moment from 'moment';

interface LooseObject {
  [key: string]: any;
}
@Component({
    selector: 'adoption-child-assessment',
    templateUrl: './adoption-child-assessment.component.html',
    styleUrls: ['./adoption-child-assessment.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class AdoptionChildAssessmentComponent implements OnInit {
  @Output() applicabilityDecision: EventEmitter<any> = new EventEmitter();
  adoptionChildAssessmentForm!: FormGroup;
  @Input() clientIDInput: any;
  @Input() removalIDInput: any;
  @Input() adoptionData: any;
  adoptionLogData: any;
  adoptionmessages: any;
  adoptionwarnings: any;
  isiveSupervisor = false;
  isiveSpecialist = false;
  saveAlertmessage = false;
  disablesendtosupervisor = false;
  warningdate: any;
  client_id: any;
  removalid: any;
  adoptionMigratedData: any;
  adoptionMigratedDataSearch: any;
  personid: any;
  ivestatus: any;
  rejectcomments: any;
  agency = '';
  userInfo!: AppUser;
  childassessmentData: any;
  tprdetails: any;
  casenumber: any;
  childagency: any;
  childjurisdiction: any;
  childname: any;
  tprcourtorderdate: any;
  ssieligibilityfromfostercare: any;
  persondetails: any;
  relationship: any;
  approvalid: any;
  isCaseWorker = false;
  isSupervisor = false;
  caseworkersignature: any;
  resubmissioncaseworkersignature: any;
  approvedbysupervisor: any;
  applicabilitychilddecision: any;
  sendtoive:boolean = false;
  isreadonly: any;
  displayValidationMessages: boolean = false;
  validationmsg = 'Please fill mandatory fields.';
  scwcommentpopupid = '#scwComment';
  failedStatus = "Submission Failed";

  constructor(
    private formBuilder: FormBuilder,
    private commonHttpService: CommonHttpService,
    public alertService: AlertService,
    public _authService: AuthService,
    private _dataStore: DataStoreService,
    private activatedRoute: ActivatedRoute
  ) { }

  ngOnInit() {
    this.createFormGroup();
    this.agency = this._authService.getAgencyName();
    this.userInfo = this._authService.getCurrentUser();
    this._dataStore.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
    if (this._dataStore.getData('adoption_clientid')) {
        this.client_id = this._dataStore.getData('adoption_clientid');
    } else {
        this.client_id = this.activatedRoute.snapshot.paramMap.get('clientid');
    }
    this.removalid = this._dataStore.getData('adoption_removalid');
    this.isiveSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SUPERVISOR);
    this.isiveSpecialist = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SPECIALIST);
    if(this.userInfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey === AppConstants.ROLES.TITLE_IVE_SUPERVISOR){
      this.isiveSupervisor = true;
    }
    if(this.userInfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey === AppConstants.ROLES.TITLE_IVE_SPECIALIST){
      this.isiveSpecialist = true;
    }
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    if (this.removalid) {
        this.getEligibInfo();
        this.getAdoptionApplicabilityDecision();
    } else if (this.removalid == null || this.removalid == undefined) {
        this.getAdoptionHistoryByPerson();
    }
    this._authService.readonlyPage('read_only_access','',
    [this.adoptionChildAssessmentForm]);
  }

    getAdoptionHistoryByPerson() {
        // client_id comes from the route, so it is the literal string 'null' whenever
        // the navigation that opened this page built the URL from a list row with no
        // client id. adoption-history declares clientId as a required number, so
        // strong-remoting rejects '/adoption-history/null' with a 400 before the
        // query runs and the subscribe below never fires.
        if (!this.client_id || isNaN(Number(this.client_id))) {
            return;
        }
        this.commonHttpService.getAll('iveadoption/adoption/adoption-history/' + this.client_id
        ).subscribe(data => {
            this.adoptionChildAssessmentForm.patchValue({ childbirthdate: data[0].dateofbirth});
            this.adoptionMigratedData = data[0];
        });
    }

  getEligibInfo() {
    this.commonHttpService.getAll(
        'iveadoption/adoption/adoption-aca-worksheet/' + this.client_id+'/'+this.removalid
        ).subscribe((response: any) => {
            if (response.adoptionAcaInfo && response.adoptionAcaInfo.length> 0){
              this.adoptionAcaWorksheetResponseFn(response);
            }
        });
    }

  private adoptionAcaWorksheetResponseFn(response: any) {
    this.adoptionChildAssessmentForm.patchValue(response.adoptionAcaInfo[0]);
    this.ivestatus = response.adoptionAcaInfo[0].ivestatus;
    this.rejectcomments = response.adoptionAcaInfo[0].rejectcomments;
    this.approvedbysupervisor = response.adoptionAcaInfo[0].decisionresubmissionspecalistname;
    this.casenumber = response.adoptionAcaInfo[0].casenumber;
    this.childagency = response.adoptionAcaInfo[0].childagency;
    this.childjurisdiction = response.adoptionAcaInfo[0].childjurisdiction;
    this.childname = response.adoptionAcaInfo[0].childname;
    if (response.adoptionAcaInfo[0].caseworkername === null) {
      this.caseworkernameIsNullFn(response);
    }
    if (response.adoptionAcaInfo[0].siblingsinfo && response.adoptionAcaInfo[0].siblingsinfo.length > 0) {
      this.addingSiblingInfo(response.adoptionAcaInfo[0].siblingsinfo);
    }
    if (response.adoptionAcaInfo[0].minorparentinfo && response.adoptionAcaInfo[0].minorparentinfo.length > 0) {
      this.addingMinorparentInfo(response.adoptionAcaInfo[0].minorparentinfo);
    }
    if (response.adoptionAcaInfo[0].eligiblesiblingsinfo && response.adoptionAcaInfo[0].eligiblesiblingsinfo.length > 0) {
      this.addingeligibleSiblingInfo(response.adoptionAcaInfo[0].eligiblesiblingsinfo);
    }
  }

  private caseworkernameIsNullFn(response: any) {
    if (this.isCaseWorker) {
      this.adoptionChildAssessmentForm.patchValue({ caseworkername: this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname });
      this.adoptionChildAssessmentForm.patchValue({ resubmissioncaseworkername: this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname });
    }
    if (!response.adoptionAcaInfo[0].submissiondate) {
      this.adoptionChildAssessmentForm.patchValue({ submissiondate: new Date() });
    }
  }

    getAdoptionApplicabilityDecision() {
        this.commonHttpService.getAll(
            'iveadoption/adoption/adoption-applicability-decision/' + this.client_id + '/' + this.removalid
        ).subscribe((response: any) => {
            if (response) {
                if (response.adoptionApplicabilityauditInfo && response.adoptionApplicabilityauditInfo.length > 0) {
                    this.approvalid = response.adoptionApplicabilityauditInfo[0].approvalid;
                    if (response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable === 'YES'){
                        this.applicabilitychilddecision = 'An applicable and non-applicable child';
                    } else if (response.adoptionApplicabilityauditInfo[0].adoptionapplicable === 'YES' && response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable !== 'YES' ) {
                        this.applicabilitychilddecision = 'An applicable child';
                    } else if (response.adoptionApplicabilityauditInfo[0].adoptionnonapplicable === 'YES' && response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable !== 'YES' ) {
                        this.applicabilitychilddecision = 'A Non-applicable child';
                    } else if (response.adoptionApplicabilityauditInfo[0].neitheranappnornonappchildfortitleivepurposes === 'YES') {
                        this.applicabilitychilddecision = 'Neither an applicable or a non-applicable child';
                    }
                }
            }
        });
    }

  createFormGroup(){
    this.adoptionChildAssessmentForm = this.formBuilder.group({
      childbirthdate: [null, Validators.required],
      ivestatus: [null],
      ivecomment: [''],
      expectedadoptiondate: [null, Validators.required],
      hasthechildbeenincare60monthsormore: [null, Validators.required],
      issiblingtochildwhoqualifiesasapplchildbyage: [null],
      acourtorder: [null],
      removalcourtorderdate: [null],
      dateoffirstcourtorderwithctw: [null],
      bavoluntaryplacementagreement: [null],
      childremovaldate: [null],
      dtof1stcowithbiorctwfindingifconvtocina: [null],
      voluntaryrelinquishment: [null],
      dateofrelinquishment: [null],
      childmeetsssimedicaldisabledeligliblerequirements: [null, Validators.required],
      childreceivingssiatremoval: [null],
      startdateofreceivingssi: [null],
      isthechildresidinginafosterfamilyhome: [null, Validators.required],
      canchildreturntohome: [null, Validators.required],
      descriptionofreturnhome: [null],
      childmeetallmedicaldisabilityrequirementsforssi: [null, Validators.required],
      child617yearsofage: [false],
      physicalmentalemotionaldisability: [false],
      emotionaldisturbance: [false],
      siblinginformationcheck: [false],
      recognizedhighriskofphysicaldisability: [false],
      raceethnicityofchild: [false],
      raceorethnicitywithoneofthesabove: [null],
      unsuccessfulreasonableeffortsstatusrecords: [null, Validators.required],
      unsuccessfulreasonableeffortsstatusrecordsdescription: [null],
      fosterparentemotionalbonding: [null, Validators.required],
      fosterparentemotionalbondingdescription: [null],
      childspreviouslyadopted: [null, Validators.required],
      childsivestatusofpreviousadoption: [null],
      previousadoptiveparentstpr: [null],
      adoptiveparentstprdate: [null],
      childscurrentivefostercareeligibilitystatus: [null],
      childsssieligibilitystatus: [null, Validators.required],
      caseworkername: [{value: '', disabled: true}],
      submissiondate: [{value: '', disabled: false}],
      resubmissioncaseworkername: [{value: '', disabled: true}],
      resubmissiondate: [{value: '', disabled: false}],
      childagetable:[''],
      resubmissioncount: [null],
      adoptionapplicabilitysiblinginfo: this.formBuilder.array([]),
      membersiblinginfo: this.formBuilder.array([]),
      adoptionapplicabilityminorparentinfo: this.formBuilder.array([]),
      adoptionapplicabilitystartdt: [null],
      caseworkersignature: [null, Validators.required],
      resubmissioncaseworkersignature: [null]
    });
  }

  saveData() {
    if (this.adoptionChildAssessmentForm.invalid) {
      this.displayValidationMessages =true;
      this.adoptionChildAssessmentForm.markAllAsTouched();
      return;
    }
      if (this.adoptionChildAssessmentForm.invalid) {
          this.alertService.warn(this.validationmsg);
      } else if (this.adoptionChildAssessmentForm.value.canchildreturntohome === 'NO' && (this.adoptionChildAssessmentForm.value.descriptionofreturnhome === null || this.adoptionChildAssessmentForm.value.descriptionofreturnhome === '')) {
        this.alertService.warn('Please explain why child cannot or should not be returned to the home of the parent');
      } else {
          this.saveToDB(this.adoptionChildAssessmentForm.value);
      }
  }

  saveToDB(submission:any){
      this.sendtoive = this._dataStore.getData('adoption_sendtoive');
      if(this.sendtoive){
        this.ivestatus = 'REVIEW';
        this._dataStore.setData('adoption_sendtoive', false);
      }
      if (submission.resubmissioncount === 0 && !submission.submissiondate) {
        submission.submissiondate = new Date();
      } else if (submission.resubmissioncount > 0 && this.isCaseWorker) {
        submission.resubmissioncaseworkername = this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname;
      }
      submission.resubmissioncount = Number(submission.resubmissioncount) + 1;
      if (this.ivestatus === null || this.ivestatus === undefined || this.ivestatus === ''){
        this.ivestatus = 'PENDING';
      }
      if (this.isCaseWorker) {
          submission.caseworkername = submission.caseworkername ? submission.caseworkername : this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname;
      }

      this.postAdoptionApplicabilityToDBFn(submission);

  }

  private getFinalsubmissionData(submission: any) {
    return {
      childBirthDate: submission.childbirthdate,
      ivestatus: this.ivestatus,
      fosterparentemotionalbonding: submission.fosterparentemotionalbonding,
      unsuccessfulreasonableeffortsstatusrecords: submission.unsuccessfulreasonableeffortsstatusrecords,
      raceEthnicityofchild: submission.raceethnicityofchild,
      raceorethnicitywithoneofthesabove: submission.raceorethnicitywithoneofthesabove,
      descriptionofreturnhome: submission.descriptionofreturnhome,
      recognizedhighriskofphysicaldisability: submission.recognizedhighriskofphysicaldisability,
      childRemovalDate: submission.childremovaldate,
      canchildreturntohome: submission.canchildreturntohome,
      emotionalDisturbance: submission.emotionaldisturbance,
      childscurrentIvEfostercareeligibilitystatus: submission.childscurrentivefostercareeligibilitystatus,
      removalCourtorderdate: submission.removalcourtorderdate,
      previousAdoptiveParentsTpr: submission.previousadoptiveparentstpr,
      childMeetAllMedicalDisabilityRequirementsforSsi: submission.childmeetallmedicaldisabilityrequirementsforssi,
      hasthechildbeenincare60Monthsormore: submission.hasthechildbeenincare60monthsormore,
      childmeetsSsImedicaldisabledeligliblerequirements: submission.childmeetsssimedicaldisabledeligliblerequirements,
      voluntaryRelinquishment: submission.voluntaryrelinquishment,
      adoptiveParentsTprDate: submission.adoptiveparentstprdate,
      physicalMentalEmotionalDisability: submission.physicalmentalemotionaldisability,
      childsSsIeligibilitystatus: submission.childsssieligibilitystatus,
      childsIvEstatusofpreviousadoption: submission.childsivestatusofpreviousadoption,
      startdateofreceivingSsi: submission.startdateofreceivingssi,
      expectedAdoptionDate: submission.expectedadoptiondate,
      childreceivingSsIatremoval: submission.childreceivingssiatremoval,
      childspreviouslyadopted: submission.childspreviouslyadopted,
      ivecomment: submission.ivecomment,
      caseworkerName: submission.caseworkername,
      submissionDate: submission.submissiondate,
      caseworkerSignature: submission.caseworkersignature,
      resubmissionCaseworkerName: submission.resubmissioncaseworkername,
      resubmissionDate: submission.resubmissiondate,
      resubmissionCaseworkerSignature: submission.resubmissioncaseworkersignature,
      resubmissionCount: submission.resubmissioncount,
      childagetable: submission.childagetable,
      issiblingtochildwhoqualifiesasapplchildbyage: submission.issiblingtochildwhoqualifiesasapplchildbyage,
      aCourtOrder: submission.acourtorder,
      dateoffirstcourtorderwithCtw: submission.dateoffirstcourtorderwithctw,
      BAvoluntaryplacementagreement: submission.bavoluntaryplacementagreement,
      dateofRelinquishment: submission.dateofrelinquishment,
      isthechildresidinginafosterfamilyhome: submission.isthechildresidinginafosterfamilyhome,
      child617Yearsofage: submission.child617yearsofage,
      siblingInformationCheck: submission.siblinginformationcheck,
      unsuccessfulreasonableeffortsstatusrecordsdescription: submission.unsuccessfulreasonableeffortsstatusrecordsdescription,
      fosterparentemotionalbondingdescription: submission.fosterparentemotionalbondingdescription,
      siblingStatus: submission.adoptionapplicabilitysiblinginfo,
      minorParentInformation: submission.adoptionapplicabilityminorparentinfo,
      adoptionapplicabilitystartdt: submission.adoptionapplicabilitystartdt ? submission.adoptionapplicabilitystartdt : new Date(),
      eligiblesiblingsinfo: submission.membersiblinginfo
    };
  }

  private postAdoptionApplicabilityToDBFn(submission: any) {
    const finalsubmission = this.getFinalsubmissionData(submission);

    const idInfo = {
      'clientId': Number(this.client_id),
      'removalid': this.removalid
    };

    const request = {
      ...idInfo,
      ...finalsubmission
    };

    request.childBirthDate = request.childBirthDate === '' ? null : request.childBirthDate;
    request.expectedAdoptionDate = request.expectedAdoptionDate === '' ? null : request.expectedAdoptionDate;
    request.startdateofreceivingSsi = request.startdateofreceivingSsi === '' ? null : request.startdateofreceivingSsi;
    request.adoptiveParentsTprDate = request.adoptiveParentsTprDate === '' ? null : request.adoptiveParentsTprDate;

    this.commonHttpService.create(request, Titile4eUrlConfig.EndPoint.postAdoptionApplicabilityToDB).subscribe(
      (res) => {
        this.postAdoptionApplicabilityToDbResponse();
      },
      (error) => {
        this.alertService.error(this.failedStatus);
        this._dataStore.setData('hasAdoptionApplicabilityInfo', false);
      });
  }

  private postAdoptionApplicabilityToDbResponse() {
    (<any>$(this.scwcommentpopupid)).modal('hide');
    if (this.saveAlertmessage) {
      this.alertService.success('Saved successfully!');
    } else {
      this.disablesendtosupervisor = false;
      this.alertService.success('Submitted successfully!');
    }
    this._dataStore.setData('hasAdoptionApplicabilityInfo', true);
  }

 savederror(){
  this.alertService.error(this.failedStatus);
  this._dataStore.setData('hasAdoptionApplicabilityInfo', false);
 }

  addingSiblingInfo(siblingsinfo:any) {
    const adoptionapplicabilitysiblinginfocontrol = <FormArray>this.adoptionChildAssessmentForm.controls.adoptionapplicabilitysiblinginfo;
    siblingsinfo.forEach((element:any) => {
      adoptionapplicabilitysiblinginfocontrol.push(this.formBuilder.group({
        siblingid: [element.siblingid],
        nameofsiblingchild: [element.nameofsiblingchild],
        nameofsiblingchildsadoptiveplacement: [element.nameofsiblingchildsadoptiveplacement],
        dateofsiblingsadoptiondecree: [element.dateofsiblingsadoptiondecree ? moment(element.dateofsiblingsadoptiondecree).format('YYYY-MM-DD') : null],
        dateofsiblingsapplicablechildassessment: [element.dateofsiblingsapplicablechildassessment],
        childssiblingsapplicabilitystatus: [element.childssiblingsapplicabilitystatus],
        expectedchildadoptiveplacement: [element.expectedchildadoptiveplacement],
        siblingsrelationshipwithchild: [element.siblingsrelationshipwithchild],
      })
      );
    });
  }

  addingeligibleSiblingInfo(eligiblesiblingsinfo:any) {
    const membersiblinginfocontrol = <FormArray>this.adoptionChildAssessmentForm.controls.membersiblinginfo;
    eligiblesiblingsinfo.forEach((element:any) => {
      const dtofsiblingsadoptiondecree = element.dtofsiblingsadoptiondecree ? new Date(moment(element.dtofsiblingsadoptiondecree).toDate()) : null;
      membersiblinginfocontrol.push(this.formBuilder.group({
            nameofsiblingchild: [element.nameofsiblingchild],
            siblingadoptionstatus: [element.siblingadoptionstatus],
            siblingproviderid: [element.adpsiblingname ? element.adpsiblingname : element.siblingproviderid],
            dateofsiblingsadoptiondecree: element.dateofsiblingsadoptiondecree ? new Date(moment(element.dateofsiblingsadoptiondecree).toDate()) : dtofsiblingsadoptiondecree,
            dateofsiblingsapplicablechildassessment: element.dateofsiblingsapplicablechildassessment ? new Date(moment(element.dateofsiblingsapplicablechildassessment).toDate()) : dtofsiblingsadoptiondecree,
          })
      );
    });
  }

  addingMinorparentInfo(minorparentinfo:any) {
    const adoptionapplicabilityminorparentinfocontrol = <FormArray>this.adoptionChildAssessmentForm.controls.adoptionapplicabilityminorparentinfo;
    minorparentinfo.forEach((element:any) => {
      adoptionapplicabilityminorparentinfocontrol.push(this.formBuilder.group({
        minorparentid: [element.minorparentid],
        minorparentname: [element.minorparentname],
        birthdateofparent: [element.birthdateofparent],
        removaltypeofminorparent: [element.removaltypeofminorparent],
        removalcourtorderdateofminorparent: [element.removalcourtorderdateofminorparent],
        removaldateofminorparent: [element.removaldateofminorparent],
        minorparentscurrentplacementtype: [element.minorparentscurrentplacementtype],
        childscurrentplacementtype: [element.childscurrentplacementtype],
        physicaladdressofminorparent: [element.physicaladdressofminorparent],
        physicaladdressofchild: [element.physicaladdressofchild],
        minorparentclientid: [element.minorparentclientid],
		    istheminorparentreceivingivefc: [element.istheminorparentreceivingivefc],
		    minorparentivefostercarestatus: [element.minorparentivefostercarestatus],
		    minorparentivefostercarestartdate: [element.minorparentivefostercarestartdate],
		    dateoflatestpaymentofminorparentivefostercare: [element.dateoflatestpaymentofminorparentivefostercare],
      })
      );
    });
  }


  submitData() {
    if (this.adoptionChildAssessmentForm.invalid) {
      this.alertService.warn(this.validationmsg);
    } else if (this.adoptionChildAssessmentForm.value.childspreviouslyadopted === 'YES' && this.adoptionChildAssessmentForm.value.adoptiveparentstprdate === null && this.adoptionChildAssessmentForm.value.previousadoptiveparentstpr === null) {
      this.alertService.warn('Please fill either adoptive parents tpr date or death date');
    } else if (this.adoptionChildAssessmentForm.value.canchildreturntohome === 'NO' && (this.adoptionChildAssessmentForm.value.descriptionofreturnhome === null )) {
        this.alertService.warn('Please explain why child cannot or should not be returned to the home of the parent');
    } else {
    this.ivestatus = 'DETERMINE';
    this.saveData();
    const submissiondata =  this.submissionData();
    this.commonHttpService.create(submissiondata, Titile4eUrlConfig.EndPoint.postAdoptionApplicability).subscribe((response: any) => {
      this.applicabilityDecision.emit();
      this.alertService.success("Submitted successfully!");
      this.commonHttpService.getAll(
        'iveadoption/adoption/adoption-applicability-decision/' +  this.client_id+'/'+ this.removalid
        ).subscribe(resp => {
            this.getLogMessages(resp);
        });
      },
      (error) => {
        this.alertService.error(this.failedStatus);
      }
      );
    }
  }

  checklogs(){
    (<any>$('#checklogs')).modal('show');
  }

  checkwarnings(){
    (<any>$('#checkwarnings')).modal('show');
  }

  displayRejectedReason(){
    (<any>$('#rejectedreason')).modal('show');
  }

  displayWorksheet(){
    const modal = {
      method: 'post',
      where: {
        documenttemplatekey: ['adoptionacaform'],
        status: 'fostercare',
        removalId: this.removalid,
        clientId: Number(this.client_id),
        childName: this.childname,
        childJurisdiction: this.childjurisdiction,
        childAgency: this.childagency,
        caseNumber: this.casenumber,
        isheaderrequired: false
      },
      limit: 10,
      order: 'desc',
      page: 1,
      count: -1
    };
    this.commonHttpService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          link.download = `adoptionacaformPDF.pdf`;
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
        });
  }



  getLogMessages(response:any){
    this.adoptionLogData = response;
    if(this.adoptionLogData && this.adoptionLogData.adoptionApplicabilityauditInfo && this.adoptionLogData.adoptionApplicabilityauditInfo.length > 0){
      var auditInfo = this.adoptionLogData.adoptionApplicabilityauditInfo[0];
      this.adoptionmessages = [];
      this.adoptionwarnings = [];
      this.warningdate = auditInfo.insertedon;
      if(auditInfo.outputjson && auditInfo.outputjson.Messages && auditInfo.outputjson.Messages.Message && auditInfo.outputjson.Messages.Message.length>0){
        this.adoptionmessages = auditInfo.outputjson.Messages.Message;
        for (const adoptionwarning of auditInfo.outputjson.Messages.Message) {
            if (adoptionwarning.severity === 'Warning') {
                this.adoptionwarnings.push(adoptionwarning);
            }
        }
      }
    }
  }

  completeForm(){
    if (this.adoptionChildAssessmentForm.invalid) {
      this.alertService.warn(this.validationmsg);
    }
    else if(this.adoptionChildAssessmentForm.value.childspreviouslyadopted === 'YES' && this.adoptionChildAssessmentForm.value.adoptiveparentstprdate === null && this.adoptionChildAssessmentForm.value.previousadoptiveparentstpr === null) {
      this.alertService.warn('Please fill either adoptive parents tpr date or death date');
    }
    else if(this.adoptionChildAssessmentForm.value.childspreviouslyadopted === 'YES' && (this.adoptionChildAssessmentForm.value.childsivestatusofpreviousadoption === null || this.adoptionChildAssessmentForm.value.childsivestatusofpreviousadoption === '')) {
      this.alertService.warn('Please fill document explanation in case record.');
    }
    else {
      this.ivestatus = 'COMPLETED';
      this.saveData();
    }
  }


  returnToWorker(){
    if(this.adoptionChildAssessmentForm.getRawValue().ivecomment && this.adoptionChildAssessmentForm.getRawValue().ivecomment != ''){
      this.ivestatus = 'RETURNED';
      this.saveData();
    }
    else{
      this.alertService.error("Please add a comment to proceed");}
  }

  submissionData() {
   const data = this.adoptionChildAssessmentForm.getRawValue();

    let FederalFiscalDateforCorticon = null;
    FederalFiscalDateforCorticon = this.getFederalFiscalDateforCorticonData(data, FederalFiscalDateforCorticon);
    const minorParentDetails :any[] = [];
    this.getMinorParentDetails(data, minorParentDetails);

    const siblingDetails:any[] = [];
    let indexofsiblings = 1;
    if (data.membersiblinginfo && data.membersiblinginfo.length > 0 && data.siblinginformationcheck) {
        indexofsiblings = this.getMembersiblingData(data, siblingDetails, indexofsiblings);
    }

    if(data.adoptionapplicabilitysiblinginfo){
      this.getAdoptionapplicabilitysiblingData(data, siblingDetails, indexofsiblings);
    }

    return this.returnSubmissionDataFn(data, minorParentDetails, siblingDetails, FederalFiscalDateforCorticon);
  }

  private returnSubmissionDataFn(data: any, minorParentDetails: any[], siblingDetails: any[], FederalFiscalDateforCorticon: any): LooseObject {
    return {
      'cjamsPid': Number(this.client_id),
      'removalid': this.removalid,
      'approvalid': this.approvalid ? this.approvalid : null,
      'pagesnapshot': data,
      'applicability': {
        'payload': {
          "name": "AdoptionApplicability",
          "__metadataRoot": {},
          "Objects": this.getaApplicabilityObjectsData(data, minorParentDetails, siblingDetails, FederalFiscalDateforCorticon)
        }
      }
    };
  }

  private getAdoptionapplicabilitysiblingData(data: any, siblingDetails: any[], indexofsiblings: number) {
    data.adoptionapplicabilitysiblinginfo.forEach((element:any) => {
      siblingDetails.push({
        "SiblingAdoptionDecreeDate": this.dateConversion(element.dateofsiblingsadoptiondecree),
        "SiblingApplicableChildAssessmentDate": this.dateConversion(element.dateofsiblingsapplicablechildassessment),
        "SiblingAdoptionApplicable": data.issiblingtochildwhoqualifiesasapplchildbyage === "" ? null : data.issiblingtochildwhoqualifiesasapplchildbyage,
        "SiblingAdoptiveProviderID": element.expectedchildadoptiveplacement === "" ? null : element.expectedchildadoptiveplacement,
        "SiblingName": element.nameofsiblingchild,
        "__metadata": {
          "#type": "SiblingDetails",
          "#id": "SiblingDetails_id_" + indexofsiblings++
        }
      });
    });
    return indexofsiblings;
  }

  private getMembersiblingData(data: any, siblingDetails: any[], indexofsiblings: number) {
    data.membersiblinginfo.forEach((element:any, index:any) => {
      if (element.siblingproviderid) {
        siblingDetails.push({
          "SiblingAdoptionDecreeDate": this.dateConversion(element.dateofsiblingsadoptiondecree),
          "SiblingApplicableChildAssessmentDate": this.dateConversion(element.dateofsiblingsapplicablechildassessment),
          "SiblingAdoptiveProviderID": element.siblingproviderid === "" ? null : element.siblingproviderid,
          "SiblingAdoptionStatus": element.siblingadoptionstatus === 'Eligible' ? 'Eligible Reimbursable' : null,
          "SiblingName": element.nameofsiblingchild,
          "__metadata": {
            "#type": "SiblingDetails",
            "#id": "SiblingDetails_id_" + indexofsiblings++
          }
        });
      }
    });
    return indexofsiblings;
  }

  private getMinorParentDetails(data: any, minorParentDetails: any[]) {
    if (data.adoptionapplicabilityminorparentinfo) {
      data.adoptionapplicabilityminorparentinfo.forEach((element:any, index:any) => {
        minorParentDetails.push({
          "MinorParentRemovalDate": this.dateConversion(element.removaldateofminorparent),
          "MinorParentName": element.minorparentname === "" ? null : element.minorparentname,
          "MinorParentCurrentPlacementType": element.minorparentscurrentplacementtype === "" ? null : element.minorparentscurrentplacementtype,
          "MinorParentDateOfBirth": this.dateConversion(element.birthdateofparent),
          "MinorParentRemovalCourtOrderDate": this.dateConversion(element.removalcourtorderdateofminorparent),
          "__metadata": {
            "#type": "ParentDetails",
            "#id": "ParentDetails_id_" + index
          },
          "MinorParentPhysicalAddress": element.physicaladdressofminorparent,
          "ChildPhysicalAddress": element.physicaladdressofchild
        });
      });
    }
  }

  private getFederalFiscalDateforCorticonData(data: any, FederalFiscalDateforCorticon: any) {
    if (data && data.expectedadoptiondate) {
      // Corticon needs user selected Year along with federal fiscal end date which is 09-30
      const federalfiscalMonthforCorticon = Number(moment(data.expectedadoptiondate).format('MM'));
      if (federalfiscalMonthforCorticon >= 0 && federalfiscalMonthforCorticon <= 9) {
        FederalFiscalDateforCorticon = moment(data.expectedadoptiondate).format('YYYY-09-30');
      } else {
        // To pass next fiscal year to corticon If the expected adoption month is Oct,Nov or Dec
        const federalfiscalYearforCorticon = Number(moment(data.expectedadoptiondate).format('YYYY')) + 1;
        FederalFiscalDateforCorticon = federalfiscalYearforCorticon + '-09-30';
      }
    }
    return FederalFiscalDateforCorticon;
  }

  private getaApplicabilityObjectsData(data: any, minorParentDetails: any[], siblingDetails: any[], FederalFiscalDateforCorticon: any) {
    return [{
      "person": this.adoptionApplicabilityPersonDataFn(data, minorParentDetails, siblingDetails, FederalFiscalDateforCorticon),
      "AdoptionApplicabilityStartDate": data.adoptionapplicabilitystartdt ? this.dateConversion(data.adoptionapplicabilitystartdt) : this.dateConversion(new Date()),
      "__metadata": {
        "#type": "Application",
        "#id": "Application_id_1"
      },
      "status": {
        "AdoptionApplicable": null,
        "Applicable_DoesTheChildMeetAnyOfTheChildStatusCriteriaOfSection_I_A1_2or3": null,
        "HasChildBeenAssessedToNOTBeAnApplicableChild": null,
        "Applicable_DoesTheChildMeetTheSpecialNeedsCriteriaInSection_I_C1_2_AorB_AND_3_AorB": null,
        "NonApplicable_DoesTheChildMeetPlacementOrMedicalCriteriaOfSection_I_B1_2or3": null,
        "AdoptionNonApplicable": null,
        "Applicable_DoesTheChildMeetPlacementOrMedicalCriteriaOfSection_I_B1_2or3": null,
        "__metadata": {
          "#type": "Status",
          "#id": "Status_id_1"
        },
        "AdoptionDataIncomplete": null,
        "ApplicableAndNonApplicable": null
      }
    }];
  }

  private adoptionApplicabilityPersonDataFn(data: any, minorParentDetails: any[], siblingDetails: any[], FederalFiscalDateforCorticon: any) {
    return {
      ...this.adoptionApplicabilityPersonData1(data, minorParentDetails, siblingDetails),
      "__metadata": {
        "#type": "Person",
        "#id": "Person_id_1"
      },
      "DateOfBirth": this.dateConversion(data.childbirthdate),
      "Removal_Court_Order_Date": this.dateConversion(data.removalcourtorderdate),
      "ChildPreviousAdoptiveParentTPRDate": this.dateConversion(data.previousadoptiveparentstpr),
      ...this.adoptionApplicabilityPersonData2(data, FederalFiscalDateforCorticon, siblingDetails),
    };
  }

  private adoptionApplicabilityPersonData1(data: any, minorParentDetails: any, siblingDetails: any) {
    return {
      "ChildHasFosterParentEmotionalTies": data.fosterparentemotionalbonding === "" ? null : data.fosterparentemotionalbonding,
      "ChildAdoptionUnsuccessfulEffortsToPlace": data.unsuccessfulreasonableeffortsstatusrecords === "" ? null : data.unsuccessfulreasonableeffortsstatusrecords,
      "ChildRaceEthnicity": data.raceethnicityofchild ? 'YES' : 'NO',
      "ChildNotReturnHomeExplanation": data.descriptionofreturnhome === "" ? null : data.descriptionofreturnhome,
      "parentDetails": minorParentDetails,
      "ChildHasHighRiskOfDisability": data.recognizedhighriskofphysicaldisability ? 'YES' : 'NO',
      "Child_Removal_Date": this.dateConversion(data.childremovaldate),
      "ChildCanReturnToHome": data.canchildreturntohome === "" ? null : data.canchildreturntohome,
      "ChildExpectedAdoptiveProviderID": siblingDetails?.length > 0 ? siblingDetails[0].SiblingAdoptiveProviderID : null,
      "ChildHasEmotionalDisturbance": data.emotionaldisturbance ? 'YES' : 'NO',
      "ChildCurrentIVEFosterCareEligibilityStatus": data.childscurrentivefostercareeligibilitystatus === "" ? null : this.ChildCurrentIVEFosterCareEligibilityStatusFalseCondition(data),
    }
  }

  private adoptionApplicabilityPersonData2(data: any, FederalFiscalDateforCorticon: any, siblingDetails: any) {
    return {
      "ChildMeetsSSIMedicalDisabilityReqts": this.returnChildMeetsSSIMedicalDisabilityReqtsFn(data),
      "ChildHasBeenInCare60Months": data.hasthechildbeenincare60monthsormore === "" ? null : data.hasthechildbeenincare60monthsormore,
      "ChildMeetsSSIMedicalDisabledEligReqts": data.childmeetsssimedicaldisabledeligliblerequirements === "" ? null : data.childmeetsssimedicaldisabledeligliblerequirements,
      "VoluntaryRelinquishment": data.voluntaryrelinquishment === "" ? null : data.voluntaryrelinquishment,
      "ChildPreviousAdoptiveParentDeathDate": this.dateConversion(data.adoptiveparentstprdate),
      "ChildHasPhysicalMentalEmotionalDisability": data.physicalmentalemotionaldisability ? 'YES' : 'NO',
      "ChildIsSSIEligible": data.childsssieligibilitystatus === "" ? null : data.childsssieligibilitystatus,
      "siblingDetails": siblingDetails,
      "ChildPreviousAdoptionIVEStatus": data.childsivestatusofpreviousadoption ? this.ChildPreviousAdoptionIVEStatusTrueCondition(data) : null,
      "StartDateOfReceivingSSI": this.dateConversion(data.startdateofreceivingssi),
      "FederalFiscalYearAdoptionAssistanceAgreementSignDate": FederalFiscalDateforCorticon ? this.dateConversion(FederalFiscalDateforCorticon) : null,
      "ChildReceivingSSIAtRemoval": this.returnChildReceivingSSIAtRemovalFn(data),
      "ChildPreviouslyAdopted": data.childspreviouslyadopted === "" ? null : data.childspreviouslyadopted
    }
  }

  private returnChildReceivingSSIAtRemovalFn(data: any) {
    return (data.childreceivingssiatremoval === "" || data.childreceivingssiatremoval === null) ? 'NO' : data.childreceivingssiatremoval;
  }

  private returnChildMeetsSSIMedicalDisabilityReqtsFn(data: any) {
    return data.childmeetallmedicaldisabilityrequirementsforssi === "" ? null : data.childmeetallmedicaldisabilityrequirementsforssi;
  }

  private ChildPreviousAdoptionIVEStatusTrueCondition(data: any) {
    return data.childsivestatusofpreviousadoption === '' ? 'Ineligible' : data.childsivestatusofpreviousadoption;
  }

  private ChildCurrentIVEFosterCareEligibilityStatusFalseCondition(data: any) {
    return data.childscurrentivefostercareeligibilitystatus === 'YES' ? 'Eligible Reimbursable' : 'Ineligible';
  }

  dateConversion(date:any) {
    if (date === undefined || date === null || date === '') {
      return null;
    } else {
      return moment(date).format('MM/DD/YYYY');
    }
  }

  openSCWPopup(){
    (<any>$(this.scwcommentpopupid)).modal('show');
  }

  closeSCWPopup(){
    (<any>$(this.scwcommentpopupid)).modal('hide');
  }

  getErrorsMessage(ControlName:any, displayName:any){
    if(this.adoptionChildAssessmentForm.controls[ControlName].status =='INVALID' ){
    return 'Please enter valid ' + displayName
    }
  }

  getAdoptionChildAssessmentForm(name: string): any[] {
    return Object.values((this.adoptionChildAssessmentForm.get(name) as FormGroup).controls);
  }

}

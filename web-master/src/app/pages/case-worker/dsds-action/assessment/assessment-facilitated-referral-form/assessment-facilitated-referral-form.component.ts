import { Component, OnInit, Injector } from "@angular/core";
import { FormArray, FormBuilder, FormGroup, Validators } from "@angular/forms";
import moment from "moment";
import { forkJoin } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AssessmentService } from '../assessment.service';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CommonHttpService, DataStoreService, SessionStorageService, AuthService, AlertService, CommonDropdownsService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { Router } from "@angular/router";

@Component({
    selector: 'assessment-facilitated-referral-form',
    templateUrl: './assessment-facilitated-referral-form.component.html',
    styleUrls: ['./assessment-facilitated-referral-form.component.scss'],
    standalone: false
})

export class AssessmentFacilitatedReferralFormComponent implements OnInit {
  ASSESSMENT_NAME = 'FACILITATED MEETING REFERRAL FORM';
  currentAssessmentId!: string;
  currentSubmissionId!: string;
  requiredForApproval!: boolean;
  isValue: number = 1;
  isServiceCase: any;
  referralForm!: FormGroup;
  familyAccessForm!: FormGroup;
  childForm!: FormGroup;
  store: any;
  id = '';
  user!: AppUser;
  agency!: string;
  isCW!: boolean;
  isSupervisor!: boolean;
  personList: any[] = [];
  spouseorpartnerList: any[] = [];
  spouseorpartnerList1: any[] = [];
  youthList: any[] = [];
  childList: any[] = [];
  updatefmrfdata!: boolean;
  viewfmrfdata!: boolean;
  daNumber: any;
  currentDate!: string;
  routingSupervisors: any;
  roleTypeKey!: string | undefined;
  fmrfdata: any;
  legalGuardian: any[] = [];
  headofhousehold: any;
  selectedYouthName: any;
  curentPlacementTyps: any[] = [];
  placementTyps: any[] = [];
  parentsNames: any[] = [];
  displayCurrentPlacemnt: boolean = false;
  livingDropDownItems: any[] = [];
  livingarrangement: any[] = [];
  programassingement: any[] = [];
  providerplacement: any[] = [];
  completeFMFDetails: any;
  maxDate: Date = new Date();
  realationshipdetails: any[] = [];
  parentlistdetails: any[] = [];
  orderControllingConductApplicables: any[] = [];
  protectingConductApplicables: any[] = [];
  showDateAdd: boolean = true;
  meetings: any[] = [];
  supprtiveRelatnshipNames: any[] = [];
  parentsInfoArray: any[] = [];
  parentsOnlyArray: any[] = [];
  infoDialog!: string;
  selectedChildName: any[] = [];
  enableSendForApproval: boolean = false;
  incompleteList: any[] = [];
  assessmentStaus!: string;
  caseworkersignature: any;
  supervisorsignature: any;
  teamList: any;
  unitCaseWorkerList: any;
  disableForm: boolean = false;
  facilitatormeetingassessmentsubmitdate!: string;
  facilitatorname!: string;
  facilitatorassigneddatetime!: string;
  subChildForm!: FormGroup;
  displayValidationMessages: boolean = false;
  dtformat = 'YYYY-MM-DDTHH:mm';
  dtformat1 = 'YYYY-MM-DDTHH:mm:ss'
  facilityrowstr = " Facility : ROW ";
  errMsg: any;
  fmlyerrMsg: any;
  commntsmsg: any;

  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _authService: AuthService;
  private _formBuilder: FormBuilder;
  private _router: Router;
  private _assessmentService: AssessmentService;
  private storage: SessionStorageService;
  private _alertService: AlertService;
  private _commonDDService: CommonDropdownsService;
  private _session: SessionStorageService;

  constructor(private injector: Injector) {
    this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
    this._authService = injector.get<AuthService>(AuthService);
    this._formBuilder = injector.get<FormBuilder>(FormBuilder);
    this._router = injector.get<Router>(Router);
    this._assessmentService = injector.get<AssessmentService>(AssessmentService);
    this.storage = injector.get<SessionStorageService>(SessionStorageService);
    this._alertService = injector.get<AlertService>(AlertService);
    this._commonDDService = injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._session = injector.get<SessionStorageService>(SessionStorageService);
    this.store = this._dataStoreService.getCurrentStore();
    this.daNumber = this._commonDDService.getStoredCaseNumber();
  }

  ngOnInit(): void {
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.user = this._authService.getCurrentUser();
    this.currentDate = moment(new Date()).format(this.dtformat1);
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.agency = this._authService.getAgencyName();
    this.isSupervisor = (this.user.role.name === 'apcs') ? true : false;
    this.roleTypeKey = this.user?.user?.userprofile?.teammemberassignment?.teammember?.roletypekey;
    this._assessmentService.getservicecase();
    this.isCW = false;                          //SonarQube complexity fix - commented else
    if (this.agency === 'CW') {
      this.isCW = true;
    }
    this.initReferralInformation();
    this.iniFamilyAccessForm();
    this.loadDropdownItems();

    this.fmrfdata = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.updatefmrfdata = false;                              //SonarQube complexity fix - commented else
    this.viewfmrfdata = false;
    if (this.fmrfdata && this.fmrfdata.mode === 'update') {       //SonarQube complexity fix - removed submit as same condition is checked below
      this.updatefmrfdata = true;
      this.viewfmrfdata = false;
    }

    if (this.fmrfdata && this.fmrfdata.mode === 'submit') {
      this.updatefmrfdata = true;
      this.viewfmrfdata = true;
      this.referralForm.disable();
      this.disableForm = true;
    }

    this.currentAssessmentId = this.fmrfdata.assessmentid;
    this.currentSubmissionId = this.fmrfdata.submissionid;

    this.setEditData();
    this.getFMFDetails(this.currentAssessmentId);
    this.getInvolvedPerson();
    this.familyAccessForm.get('ldss')?.disable();
    this.familyAccessForm.get('workersname')?.disable();
    this.familyAccessForm.get('supervisorname')?.disable();
    if (this.fmrfdata.submissiondata && this.fmrfdata.submissiondata.familyAccess) {
      this.facilitatormeetingassessmentsubmitdate = this.fmrfdata.submissiondata.familyAccess?.facilitatormeetingassessmentsubmitdate;
      if (this.fmrfdata.submissiondata.familyAccess?.caseworkersignature) {                         //SonarQube complexity fix - commented the check as same condition is checked in outer if condition
        this.caseworkersignature = this.fmrfdata.submissiondata.familyAccess?.caseworkersignature;

      }
      if (this.fmrfdata.submissiondata.familyAccess?.supervisorsignature) {
        this.supervisorsignature = this.fmrfdata.submissiondata.familyAccess?.supervisorsignature;
      }
      if (this.fmrfdata.submissiondata.familyAccess?.facilitatormeetingassessmentapprovaldate) {
        this.familyAccessForm.patchValue({
          facilitatormeetingassessmentapprovaldate: moment(this.fmrfdata.submissiondata.familyAccess.facilitatormeetingassessmentapprovaldate).format(this.dtformat1)
        });
      }
    }
  }

  setEditData() {
    if (this.fmrfdata.submissiondata && this.fmrfdata.submissiondata.referralinformation) {
      this.referralFormChildArray();
      this.referralFormSubChildArray();

      this.referralForm.patchValue(this.fmrfdata.submissiondata.referralinformation);
      if (this.disableForm) { this.referralForm.disable(); }
    }
    this.familyAccessFormControlsValidation();
    this.familyAccessForm.controls['facilitatormeetingassessmentsubmitdate'].disable();
    this.disableFamilyAccessForm();
  }

  referralFormChildArray() {
    const control_ChildArray: any = <FormArray>this.referralForm.controls['childarray'];
    for (let i = 0; i < this.fmrfdata.submissiondata.referralinformation.childarray.length; i++) {
      const data = this.fmrfdata.submissiondata.referralinformation.childarray[i];
      this.getPersonCompleteDetails(data.personId, data.servicecaseid, i);
      control_ChildArray.push(this.createReferralGroupNew());
      if (this.disableForm) {
        control_ChildArray.disable();
      }
    }
  }

  referralFormSubChildArray() {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];

    for (let i = 0; i < this.fmrfdata.submissiondata.referralinformation?.SubChildarray?.length; i++) {
      control_SubChildarray.push(this.createSubChildFormGroupNew());
      if (this.disableForm) {
        control_SubChildarray.disable();
      }
      this.handleParentsNameFormFn(i, control_SubChildarray);
      this.handleOrderControllingConductApplicableToFormFn(i, control_SubChildarray);
      this.handleProtectingConductApplicableToFormFn(i, control_SubChildarray);
      this.handleSupportiveRelationshipArrayFn(i, control_SubChildarray);
    }
  }

  // Assosiated with referralFormSubChildArray method
  private handleSupportiveRelationshipArrayFn(i: number, control_SubChildarray: any) {
    for (let j = 0; j < this.fmrfdata.submissiondata.referralinformation.SubChildarray[i]?.supportiveRelationshipArray?.length; j++) {
      control_SubChildarray.controls[i].controls.supportiveRelationshipArray.controls.push(this.createSupportiveRelationshipGroup());
      if (this.disableForm) {
        control_SubChildarray.controls[i].controls.supportiveRelationshipArray.disable();
      }
    }
  }
  // Assosiated with referralFormSubChildArray method
  private handleProtectingConductApplicableToFormFn(i: number, control_SubChildarray: any) {
    for (let j = 0; j < this.fmrfdata.submissiondata.referralinformation.SubChildarray[i]?.protectingConductApplicableToForm?.length; j++) {
      control_SubChildarray.controls[i].controls.protectingConductApplicableToForm.controls.push(this.createProtectingConductApplicableToGroup());
      if (this.disableForm) { control_SubChildarray.controls[i].controls.protectingConductApplicableToForm.disable(); }
    }
  }
  // Assosiated with referralFormSubChildArray method
  private handleOrderControllingConductApplicableToFormFn(i: number, control_SubChildarray: any) {
    for (let j = 0; j < this.fmrfdata.submissiondata.referralinformation.SubChildarray[i]?.orderControllingConductApplicableToForm?.length; j++) {
      control_SubChildarray.controls[i].controls.orderControllingConductApplicableToForm.controls.push(this.createOrderControllingConductApplicableToGroup());
      if (this.disableForm) { control_SubChildarray.controls[i].controls.orderControllingConductApplicableToForm.disable(); }
    }
  }
  // Assosiated with referralFormSubChildArray method
  private handleParentsNameFormFn(i: number, control_SubChildarray: any) {
    for (let j = 0; j < this.fmrfdata.submissiondata.referralinformation.SubChildarray[i]?.parentsNameForm?.length; j++) {
      control_SubChildarray.controls[i].controls.parentsNameForm.controls.push(this.createParentsNameGroup());
      if (this.disableForm) {
        control_SubChildarray.controls[i].controls.parentsNameForm.disable();
      }
    }
  }

  familyAccessFormControlsValidation() {
    if (!this.fmrfdata.submissiondata) {
      const userDetails = this._authService.getCurrentUser();
      const ldss = userDetails.user?.userprofile?.teammemberassignment?.teammember?.team?.county?.countyname;
      this.familyAccessForm.controls['ldss'].patchValue(ldss);
      this.familyAccessForm.controls['supervisorname'].patchValue(this._dataStoreService.getData('da_assignedby'));
      this.familyAccessForm.controls['workersname'].patchValue(this.user.user.userprofile.fullname);
    }
    if (!this.isSupervisor) {
      this.familyAccessForm.controls['supervisorsignature'].disable();
      this.familyAccessForm.controls['supervisorcomments'].disable();
      this.familyAccessForm.controls['facilitatormeetingassessmentapprovaldate'].disable();
      this.familyAccessForm.controls['assessmentStaus'].disable();
    }
    this.familyAccessForm.controls['facilitatormeetingassessmentsubmitdate'].disable();
  }

  disableFamilyAccessForm() {
    if (this.fmrfdata.submissiondata && this.fmrfdata.submissiondata.familyAccess) {
      if (this.fmrfdata.submissiondata?.familyAccess?.parentFacilityForm?.length > 0) {
        const control_FamilyAccessArray: any = <FormArray>this.familyAccessForm.controls['parentFacilityForm'];
        for (let i = 0; i < this.fmrfdata.submissiondata.familyAccess.parentFacilityForm.length; i++) { // NOSONAR
          control_FamilyAccessArray.push(this.createparentFacilityForm());
          if (this.disableForm) { control_FamilyAccessArray.disable(); }
        }
      }
      this.familyAccessForm.patchValue(this.fmrfdata.submissiondata.familyAccess);
      if (this.disableForm) {
        this.familyAccessForm.disable();
      }
    }
  }

  setPrintData() {
    const printdata = this.fmrfdata;
    printdata.submissiondata = this.getfmrfdata();
    this._dataStoreService.setData('PRINTDATA', printdata);
  }

  getFMFDetails(assessmentid: any) {
    const payload = {
      method: 'post',
      where: { assessmentid: assessmentid }
    };
    this._commonHttpService.getPagedArrayList(payload, 'admin/assessment/getFMFDetails?filter').subscribe(
      response => {
        this.completeFMFDetails = response.data;
        this.patchFamilyAccessMeetingNeeds();
        this.setPrintData();
        this.enableSendForApproval = true;
      }, error => {
        console.error(error);
      });
  }
  patchFamilyAccessMeetingNeeds() {
    const familyAccessData = this.completeFMFDetails?.submissiondata?.familyAccess;
    this.familyAccessForm.patchValue({
      familyUnderstanding: familyAccessData?.familyUnderstanding,
      isWriteNeeded: familyAccessData?.isWriteNeeded,
      parentResidingFacility: familyAccessData?.parentResidingFacility,
      isWriteNeededComments: familyAccessData?.isWriteNeededComments,
      familyPreferred: familyAccessData?.familyPreferred,
      familyPreferredComments: familyAccessData?.familyPreferredComments,
      parentFacilityForm: familyAccessData?.parentFacilityForm
    });
  }

  placementTypeChange(event: any, index: any) {
    if (event.checked) {
      const subChildArray: any = this.referralForm.controls['SubChildarray'];
      subChildArray.controls[index].patchValue({
        plTypeNA: false
      });
    }
  }

  placementTypeNAChange(event: any, index: any) {
    if (event.checked) {
      const subChildArray: any = this.referralForm.controls['SubChildarray'];
      subChildArray.controls[index].patchValue({
        plTypeFosterHome: false,
        plTypeGroupHome: false,
        plTypeIndLiving: false,
        plTypeKinship: false,
        plTypeHomeNotRemoved: false
      });
    }
  }

  supprtiveRelatnshipNameChng(event: any, index: any, subIndex: any) {
    const subChildArray: any = this.referralForm.controls['SubChildarray'];
    if (event !== '') {
      const isExist = this.supprtiveRelatnshipNames.find(item => item.id === event);

      isExist.relationshipTo = isExist.relationshipTo === 'NA' ? null : isExist.relationshipTo;
      if (isExist.length != 0) {
        const phoneArray = this.getPhoneArray(isExist);
        const addressString = this.getAddressString(isExist);
        subChildArray.controls[index].controls.supportiveRelationshipArray.controls[subIndex].patchValue({
          supportiveName: isExist.name,
          familyHasIndicate: null,
          relationshipTo: isExist.relationshipTo,
          address: addressString,
          phone: phoneArray,
          email: isExist.email,
          collateralRelationshipTo: isExist.collateralRelationshipTo,
          hasWorker: isExist.hasWorker
        });
      }
    }
  }

  parentsNameChange(event: any, index: any, subIndex: any) {
    const subChildArray: any = this.referralForm.controls['SubChildarray']
    if (event.value !== '') {
      const isExist: any = this.parentsOnlyArray.find(item => item.id === event.value);
      isExist.email = isExist.email !== null ? isExist.email : 'NA';

      if (isExist.length != 0) {
        const phoneArray = this.getPhoneArray(isExist);
        const addressString = this.getAddressString(isExist);
        subChildArray.controls[index].controls.parentsNameForm.controls[subIndex].patchValue({
          parentsName: event.value,
          name: isExist.name,
          address: addressString,
          phone: phoneArray,
          email: isExist.email,
          contactHome: isExist.contactHome,
          contactWork: isExist.contactWork,
          contactCell: isExist.contactCell,
          contactText: isExist.contactText,
          contactEmail: isExist.contactEmail
        });
      }
    }
  }

  parentFacilityDrpDwnChange(event: any, j: any) {
    if (event.value !== '') {
      const isExist: any = this.parentsOnlyArray.find(item => item.id === event.value);
      if (isExist.length != 0) {
        const control: any = this.familyAccessForm.controls['parentFacilityForm'];
        control.controls[j].patchValue({
          name: isExist.name,
          firstname: isExist.firstname,
          lastname: isExist.lastname
        });
      }
    }
  }

  orderControllingConductApplicableToChange(event: any, index: any, subIndex: any) {
    const subChildArray: any = this.referralForm.controls['SubChildarray']
    if (event.value !== '') {
      const isExist = this.orderControllingConductApplicables.find(item => item.id === event.value);
      if (isExist.length != 0) {
        subChildArray.controls[index].controls.orderControllingConductApplicableToForm.controls[subIndex].patchValue({
          orderControllingConductApplicableToName: isExist.name,
          cjamspid: isExist.cjamspid,
          dob: isExist.dob
        });
      }
    }
  }

  protectingConductApplicableToChange(event: any, index: any, subIndex: any) {
    const subChildArray: any = this.referralForm.controls['SubChildarray']
    if (event.value !== '') {
      const isExist = this.protectingConductApplicables.find(item => item.id === event.value);
      if (isExist.length != 0) {
        subChildArray.controls[index].controls.protectingConductApplicableToForm.controls[subIndex].patchValue({
          applicableToName: isExist.name,
          cjamspid: isExist.cjamspid,
          dob: isExist.dob
        });
      }
    }
  }



  initReferralInformation() {
    const userDetails = this._authService.getCurrentUser();
    this.referralForm = this._formBuilder.group({
      dateofreferral: new Date(),
      requestor: userDetails.user.userprofile.firstname + ' ' + userDetails.user.userprofile.lastname,
      phone: userDetails.user.userprofile.userprofilephonenumber[0]?.phonenumber,
      email: userDetails.user.userprofile.email
    })
    this.referralForm.setControl('childarray', this._formBuilder.array([]));
    this.referralForm.setControl('SubChildarray', this._formBuilder.array([]));
  }

  iniFamilyAccessForm() {
    this.familyAccessForm = this._formBuilder.group({
      familyUnderstanding: '',
      isWriteNeeded: '',
      parentResidingFacility: '',
      isWriteNeededComments: '',
      familyPreferred: '',
      familyPreferredComments: '',
      meetings: [],
      parentFacilityForm: this._formBuilder.array([]),
      option1Date: '',
      option2Date: '',
      option3Date: '',
      specialNeedsRiskFactorSelect: '',
      snrfChildcare: '',
      snrfCourtOrder: '',
      snrfLiteracy: '',
      snrfTransportation: '',
      snrfSafetyConcerns: '',
      snrfADAConcerns: '',
      snrfInterpreter: '',
      snrfTraumaResponsiveNeeds: '',
      snrfVirtualMeetingNeeds: '',
      snrfOtherMeetingNeeds: '',
      otherMeetingNeedsComments: '',
      specialNeedsRiskFactorsComments: '',
      familyTeamDecisionMeeting: '',
      emergentChildSeperation: '',
      consideredChildSeperation: '',
      placementChangeStability: '',
      recommendationsPermanencyChange: '',
      qrtp: '',
      voluntaryPlacement: '',
      placementPlanning: '',
      ytp: '',
      facilitatedFamilyMeeting: '',
      facilitatedFamilyMeetingComments: '',
      ldss: null,
      workersname: null,
      supervisorname: null,
      assessmentreviewed: 'InProcess',
      assessmentStaus: 'InProcess',
      reroutesupervisor: [null],
      caseworkersignature: null,
      caseworkercomments: null,
      facilitatormeetingassessmentcompletiondate: null,
      facilitatormeetingassessmentapprovaldate: null,
      facilitatormeetingassessmentsubmitdate: null,
      supervisorsignature: null,
      supervisorcomments: null,
      toteamid: null,
      assigneduser: null
    });
  }

  addReferral() {
    const control_ChildArray = <FormArray>this.referralForm.controls['childarray'];
    const control_SubChildarray = <FormArray>this.referralForm.controls['SubChildarray'];
    if (control_ChildArray.length != 0) {
      const i = control_ChildArray.controls.length - 1;
      const data: any = control_ChildArray.controls[i];
      if (data.controls.name.value != null) {
        this.selectedChildName.push(data.controls.name.value);
      }
    }
    control_ChildArray.push(this.createReferralGroupNew());
    control_SubChildarray.push(this.createSubChildFormGroupNew());
  }

  AddSupportiveRelationshipForm(index: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    control_SubChildarray.controls[index].controls.supportiveRelationshipArray.controls.push(this.createSupportiveRelationshipGroup());
  }

  deleteSupportiveRelationshipForm(index1: any, index2: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    const supportiveRelationshipArrayarray: any = control_SubChildarray.controls[index1].controls.supportiveRelationshipArray;
    supportiveRelationshipArrayarray.removeAt(index2);
  }

  addParentsNameForm(index: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    control_SubChildarray.controls[index].controls.parentsNameForm.controls.push(this.createParentsNameGroup());
  }

  deleteParentsNameForm(index1: any, index2: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    const parentsFormarray: any = control_SubChildarray.controls[index1].controls.parentsNameForm;
    parentsFormarray.removeAt(index2);
  }

  addorderControllingConductApplicableToForm(index: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    control_SubChildarray.controls[index].controls.orderControllingConductApplicableToForm.controls.push(this.createOrderControllingConductApplicableToGroup());
  }

  deleteorderControllingConductApplicableToForm(index1: any, index2: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    const applicableToFormarray: any = control_SubChildarray.controls[index1].controls.orderControllingConductApplicableToForm;
    applicableToFormarray.removeAt(index2);
  }

  addProCondApplicableToForm(index: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    control_SubChildarray.controls[index].controls.protectingConductApplicableToForm.controls.push(this.createProtectingConductApplicableToGroup());
  }

  deleteProCondApplicableToForm(index1: any, index2: any) {
    const control_SubChildarray: any = <FormArray>this.referralForm.controls['SubChildarray'];
    const protectingConductApplicableToFormarray: any = control_SubChildarray.controls[index1].controls.protectingConductApplicableToForm;
    protectingConductApplicableToFormarray.removeAt(index2);
  }
  addparentFacilityForm() {
    const control: any = <FormArray>this.familyAccessForm.controls['parentFacilityForm'];
    control.push(this.createparentFacilityForm());
  }

  deleteparentFacilityForm(index: any) {
    const parentFacilityFormArray: any = <FormArray>this.familyAccessForm.controls['parentFacilityForm'];
    parentFacilityFormArray.removeAt(index);
  }

  showFormDialog(event: any) {
    if (event.checked) {
      (<any>$('#facilitated-meeting-form-dialog')).modal('show');
    }
  }

  showqrtpDialog(event: any) {
    if (event.checked) {
      (<any>$('#qrtp-dialog')).modal('show');
    }
  }

  showInfoDialog(value: any) {
    this.infoDialog = value;
    (<any>$('#info-dialog')).modal('show');
  }

  private createparentFacilityForm() {
    return this._formBuilder.group({
      name: null,
      firstname: null,
      lastname: null,
      parent: null,
      facilityName: null,
      address: null,
      phone: null,
      fax: null,
      email: null,
      comments: null
    });
  }

  private createReferralGroupNew() {
    return this._formBuilder.group({
      name: null,
      cjamsid: null,
      dob: null,
      address: null,
      personId: null,
      servicecaseid: null
    });
  }

  private createSubChildFormGroupNew() {
    this.subChildForm = this._formBuilder.group({
      curentPlacementTyp: null,
      plTypeFosterHome: null,
      plTypeGroupHome: null,
      plTypeIndLiving: null,
      plTypeKinship: null,
      plTypeHomeNotRemoved: null,
      plTypeNA: null,

      livingarrangementtypeConsidered: null,
      providername: null,
      provider_id: null,
      placementAddress: null,
      placementstartdatetime: null,
      livingarrangementtypedescription: null,

      orderControllingConduct: ['', Validators.required],
      orderOfProtectingConduct: ['', Validators.required],
      orderControllingConductComments: null,
      protectingConductComments: null,

      currentCareGiver: [],
      programassingement: [],
      permanencyplans: [],
      legalcustody: [],
      resourceparentsinfo: [],
      livingarrangement: [],
      currentPlacementType: null,
      livingArrangmentType: null,
      childinfo: [],
      providerplacement: [],
      parentsNameForm: this._formBuilder.array([]),
      orderControllingConductApplicableToForm: this._formBuilder.array([]),
      protectingConductApplicableToForm: this._formBuilder.array([]),
      supportiveRelationshipArray: this._formBuilder.array([]),
      personId: null
    });

    return this.subChildForm;
  }

  private createSupportiveRelationshipGroup() {
    return this._formBuilder.group({
      supportiveName: null,
      name: null,
      familyHasIndicate: null,
      collateralRelationshipTo: null,
      relationshipTo: null,
      address: null,
      phone: null,
      email: null,
      hasWorker: null
    });
  }

  private createParentsNameGroup() {
    return this._formBuilder.group({
      parentsName: null,
      name: null,
      address: null,
      phone: null,
      email: null,
      contactHome: null,
      contactWork: null,
      contactCell: null,
      contactText: null,
      contactEmail: null,
    });
  }

  private createOrderControllingConductApplicableToGroup() {
    return this._formBuilder.group({
      orderControllingConductApplicableTo: null,
      orderControllingConductApplicableToName: null,
      cjamspid: null,
      dob: null
    });
  }
  private createProtectingConductApplicableToGroup() {
    return this._formBuilder.group({
      protectingConductApplicableTo: null,
      applicableToName: null,
      cjamspid: null,
      dob: null
    });
  }

  saveForm() {

    const fmrfdata = this.getfmrfdata();
    if (!this.isSupervisor) {
      fmrfdata.familyAccess.assessmentStaus = null;
      fmrfdata.familyAccess.supervisorcomments = null;
      fmrfdata.familyAccess.facilitatormeetingassessmentapprovaldate = null;
      fmrfdata.familyAccess.supervisorsignature = null;
    }
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, fmrfdata)
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

  getassessmentStatus() {
    let status = '';
    if (this.isSupervisor) {
      status = this.familyAccessForm.get('assessmentStaus')?.value;
    } else {
      status = 'Review';
    }
    return status;
  }

  submitForApproval() {
    const submissiondata = this.getfmrfdata();
    this.assessmentStaus = this.getassessmentStatus();
    submissiondata.assessmentStaus = this.getassessmentStatus();
    submissiondata.currentSubmissionId = this.currentSubmissionId;
    submissiondata.routingsupervisors = this.routingSupervisors;

    if (this.assessmentStaus === 'Accepted') {
      this.openaddfacilitator();
    }
    else {
      this.saveApprovalData(submissiondata);
    }
  }

  saveApprovalData(data: any) {
    this._dataStoreService.setData('PRINTDATA', data);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, data)
      .subscribe(
        (response) => {
          this._alertService.success(`${this.assessmentStaus === 'Review' ? 'Approval' : this.assessmentStaus} Submitted Successfully`);
          this.goBack();
        },
        (error) => {
          this._alertService.error('Unable to submit for approval.');
        }
      );
  }

  getInvolvedPerson() {
    let getpersonlistreq = {};
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    } else {
      getpersonlistreq = { intakeserviceid: this.id };
    }
    this.getPersonDetails(getpersonlistreq);
  }

  getPersonDetails(getpersonlistreq: any) {
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
          this.personList = response.data;
          this.setchildList();
          this.setLegalGuardian();
          if (this.getassessmentStatus() !== 'Accepted') {
            this.patchlatestpersoninfo();
          }
        }
        if (this.selectedYouthName) {
          this.selectYouth(this.selectedYouthName);
          const printdata = this.getfmrfdata();
          this._dataStoreService.setData('PRINTDATA', printdata);
        }
      });
  }

  setchildList() {
    this.personList.forEach(list => {
      if (list.isheadofhousehold === true) {
        this.headofhousehold = list;
      }
      if (list.roles) {
        const child = list.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD')
        if (child && child.length > 0) {
          this.childList.push(list);
          this.checkyouthage(list);
        }
      }
    });
  }

  setLegalGuardian() {
    this.personList.forEach(list1 => {
      if (list1.roles) {
        const lg = list1.roles.filter((role: { intakeservicerequestpersontypekey: string; }) => role.intakeservicerequestpersontypekey === 'LG')
        if (lg && lg.length > 0) {
          this.legalGuardian.push(list1)
        }
      }
    });
  }

  checkyouthage(item: any) {
    const dob = moment(item.dob);
    const age = moment().diff(dob, 'years', true);
    if (age <= 21) {
      this.youthList.push(item);
    }
  }
  addNewChild(event: any, index: any) {
    const isExist = this.selectedChildName.filter((i: any) => (i == event));
    if (isExist.length == 0) {
      const personDetails = this.childList.filter(item => item.fullname === event);
      const personId = personDetails[0].personid;
      const servicecaseid = personDetails[0].servicecaseid;
      (<FormArray>this.referralForm.get('childarray')).controls[index].patchValue({
        dob: personDetails[0].dob ? personDetails[0].dob : '',
        cjamsid: personDetails[0].cjamspid ? personDetails[0].cjamspid : '',
        address: (personDetails[0].address) ? personDetails[0].address + ' ' +( personDetails[0].address2 || '') + ' ' + personDetails[0].city + ' ' + personDetails[0].state + ' ' + personDetails[0].zipcode : null,
        personId: personDetails[0].personid,
        servicecaseid: personDetails[0].servicecaseid
      });
      this.getPersonCompleteDetails(personId, servicecaseid, index);
    } else {
      this._alertService.success('Child name - ' + event + ' already selected.');
    }
  }

  getcollateralphoneitem(data: any) {
    let item: any;
    if (data.mobile !== null && data.mobile !== undefined) {
      item = {};
      item.ismobile = true;
      item.personphonetypekey = "CL";
      item.phonenumber = data.mobile;
    }
    if (data.workphone !== null && data.workphone !== undefined) {
      item = {};
      item.ismobile = false;
      item.personphonetypekey = "WK";
      item.phonenumber = data.workphone;
    }

    if (data.homephone !== null && data.homephone !== undefined) {
      item = {};
      item.ismobile = false;
      item.personphonetypekey = "HM";
      item.phonenumber = data.homephone;
    }
    item = item === undefined ? null : item;
    return item;
  }

  getPersonCompleteDetails(personId: any, servicecaseid: any, index: any) {
    const payload = {
      method: 'post',
      where: { personid: personId, servicecaseid: servicecaseid }
    };
    this._commonHttpService.getPagedArrayList(payload, 'admin/assessment/getpersoncompletedetail?filter').subscribe(
      response => {
        this.realationshipdetails = [];
        this.parentlistdetails = [];
        this.parentsInfoArray = [];
        let responseData: any = [];
        if (response && response.data[0] && response.data[0]?.getpersoncompletedetail[0]) {
          responseData = response.data[0]?.getpersoncompletedetail[0];
          this.setReferralFormSubChildarray(responseData, personId, index);
          for (let i = 0; i < responseData?.realationshipdetails?.length; i++) {
            this.realationshipdetails.push(responseData?.realationshipdetails[i]);
          }
          this.checkCollateralInfo(responseData);
          this.checkRelationshipInfo(responseData);
          this.setApplicables(responseData);
          this.setSupportiveRelationship(responseData);
          this.setparentsOnlyArray(responseData);
          this.setMeetings(responseData);
        }
      }, error => {
        console.error(error);
      });
  }

  setReferralFormSubChildarray(responseData: any, personId: any, index: any) {
    (<FormArray>this.referralForm.get('SubChildarray')).controls[index].patchValue({
      personId: personId,
      providername: responseData.providerplacement === null ? '' : responseData?.providerplacement[0].providerdetails.providername,
      provider_id: responseData?.providerplacement === null ? '' : responseData?.providerplacement[0].providerdetails.provider_id,
      placementAddress: responseData?.providerplacement === null ? '' : responseData?.providerplacement[0]?.providerdetails.address,
      placementstartdatetime: responseData?.providerplacement === null ? '' : responseData?.providerplacement[0]?.placementstartdatetime,
      livingarrangementtypedescription: responseData?.livingarrangement === null ? '' : responseData?.livingarrangement[0]?.livingarrangementtypedescription,
      currentCareGiver: responseData?.currentcaregiverinfo === null ? [] : responseData?.currentcaregiverinfo,
      programassingement: responseData?.programassingement === null ? [] : responseData?.programassingement,
      permanencyplans: responseData?.permanencyplans === null ? [] : responseData?.permanencyplans,
      legalcustody: responseData?.legalcustody === null ? [] : responseData?.legalcustody,
      resourceparentsinfo: responseData?.resourceparentsinfo === null ? [] : responseData?.resourceparentsinfo,
      livingarrangement: responseData?.livingarrangement === null ? [] : responseData?.livingarrangement,
      currentPlacementType: this.setCurrentPlacementType(responseData),
      livingArrangmentType: this.setLivingArrangmentType(responseData),
      childinfo: responseData?.childinfo === null ? '' : responseData?.childinfo[0],
      providerplacement: responseData?.providerplacement === null ? '' : responseData?.providerplacement[0]
    });
  }

  checkCollateralInfo(responseData: any) {
    for (let i = 0; i < responseData?.collateral?.length; i++) {
      let collateraladdress = null;
      if (responseData?.collateral[i].collateraladdress !== null) {
        if (responseData?.collateral[i].collateraladdress?.length > 0) {
          collateraladdress = responseData?.collateral[i].collateraladdress[0];
        }
      }
      this.parentsInfoArray.push(this.returnParentsInfoArrayDataFn(responseData, i, collateraladdress));
    }
  }

  // Assosiated with checkCollateralInfo method
  private returnParentsInfoArrayDataFn(responseData: any, i: number, collateraladdress: any): any {
    return {
      id: responseData?.collateral[i].collateralid,
      name: responseData?.collateral[i].fullname,
      cjamspid: 'NA',
      dob: responseData?.collateral[i].dob,
      phoneinfo: [],
      relationshipTo: 'NA',
      address: collateraladdress === null ? '' : collateraladdress.address1,
      address2: collateraladdress === null ? '' : collateraladdress.address2,
      city: collateraladdress === null ? '' : collateraladdress.cityname,
      state: collateraladdress === null ? '' : collateraladdress.statetypekey,
      zipcode: collateraladdress === null ? '' : collateraladdress.zip5no,
      phone: this.getcollateralphoneitem(responseData?.collateral[i]),
      email: responseData?.collateral[i]?.email === null ? '' : responseData?.collateral[i]?.email
    };
  }

  checkRelationshipInfo(responseData: any) {
    const tempChildAvoidedArray = [];

    for (let i = 0; i < responseData?.realationshipdetails?.length; i++) {
      const isExist = this.returnIsExistDataFn(responseData?.realationshipdetails[i]?.roles);
      if (isExist.length == 0) {
        tempChildAvoidedArray.push(responseData?.realationshipdetails[i]);
      }
      for (let j = 0; j < tempChildAvoidedArray?.length; j++) {
        this.parentsInfoArray.push(this.returnTempChildAvoidedArrayDataFn(tempChildAvoidedArray, j));
      }
    }
  }

  // handling if the role is empty
  private returnIsExistDataFn(roles: any) {
    return (roles ? roles.filter((item: any) => (item.intakeservicerequestpersontypekey == 'CHILD' || item.intakeservicerequestpersontypekey == 'AV')) : [])
  }

  // Assosiated with checkRelationshipInfo method
  private returnTempChildAvoidedArrayDataFn(tempChildAvoidedArray: any[], i: number): any {
    return {
      id: tempChildAvoidedArray[i].personid,
      name: tempChildAvoidedArray[i].fullname,
      cjamspid: tempChildAvoidedArray[i].cjamspid,
      dob: tempChildAvoidedArray[i].dob,
      phoneinfo: tempChildAvoidedArray[i].phoneinfo,
      relationshipTo: tempChildAvoidedArray[i].relationship === null ? '' : tempChildAvoidedArray[i].relationship,
      address: tempChildAvoidedArray[i].address === null ? '' : tempChildAvoidedArray[i].address,
      address2: tempChildAvoidedArray[i].address2 === null ? '' : tempChildAvoidedArray[i].address2,
      city: tempChildAvoidedArray[i].city === null ? '' : tempChildAvoidedArray[i].city,
      state: tempChildAvoidedArray[i].state === null ? '' : tempChildAvoidedArray[i].state,
      zipcode: tempChildAvoidedArray[i].zipcode === null ? '' : tempChildAvoidedArray[i].zipcode,
      phone: 'NA',
      email: tempChildAvoidedArray[i].email === null ? '' : tempChildAvoidedArray[i].email,
    };
  }

  setApplicables(responseData: any) {
    const applicableToTempArray = [];
    for (let i = 0; i < responseData?.collateral?.length; i++) {
      const collateralphone: any[] = [];
      const item: any = {};

      applicableToTempArray.push(
        {
          id: responseData?.collateral[i].collateralid,
          name: responseData?.collateral[i].fullname,
          cjamspid: 'NA',
          dob: responseData?.collateral[i].dob,
          relationshipTo: 'NA',
          address: 'NA',
          phone: this.getcollateralphoneitem(responseData?.collateral[i]),
          email: responseData?.collateral[i].email === null ? '' : responseData?.collateral[i].email
        }
      );
    }
    for (let i = 0; i < responseData?.realationshipdetails?.length; i++) {
      applicableToTempArray.push(
        {
          id: responseData?.realationshipdetails[i].personid,
          name: responseData?.realationshipdetails[i].fullname,
          cjamspid: responseData?.realationshipdetails[i].cjamspid,
          dob: responseData?.realationshipdetails[i].dob,
          relationshipTo: responseData?.realationshipdetails[i].relationship === null ? '' : responseData?.realationshipdetails[i].relationship,
          address: responseData?.realationshipdetails[i].address === null ? '' : responseData?.realationshipdetails[i].address,
          phone: 'NA',
          email: responseData?.realationshipdetails[i].email === null ? '' : responseData?.realationshipdetails[i].email,
        }
      );
    }
    this.orderControllingConductApplicables = applicableToTempArray;
    this.protectingConductApplicables = applicableToTempArray;
  }

  setSupportiveRelationship(responseData: any) {
    const supprtiveRelatnshipTempArray: any[] = [];
    this.handleCollateralLoopFn(responseData, supprtiveRelatnshipTempArray);
    this.handleRelationshipsbypersonLoopFn(responseData, supprtiveRelatnshipTempArray);
    this.handleRelationshipDetails(responseData,supprtiveRelatnshipTempArray);
    this.supprtiveRelatnshipNames = supprtiveRelatnshipTempArray;
  }

  // Assosiated with setSupportiveRelationship method
  private handleRelationshipsbypersonLoopFn(responseData: any, supprtiveRelatnshipTempArray: any[]) {
    for (let i = 0; i < responseData?.relationshipsbyperson?.length; i++) {
      if (responseData?.relationshipsbyperson[i] !== null && responseData?.relationshipsbyperson[i] !== undefined) {
        supprtiveRelatnshipTempArray.push(
          this.returnRelationshipsbypersonDataFn(responseData, i)
        );
      }
    }
  }

  // Assosiated with setSupportiveRelationship method
  private returnRelationshipsbypersonDataFn(responseData: any, i: number): any {
    return {
      id: responseData?.relationshipsbyperson[i].person2id,
      name: responseData?.relationshipsbyperson[i].person2name,
      dob: responseData?.relationshipsbyperson[i].dob,
      relationshipTo: responseData?.relationshipsbyperson[i].relation === null ? '' : responseData?.relationshipsbyperson[i].relation,
      address: responseData?.relationshipsbyperson[i].address === null ? '' : responseData?.relationshipsbyperson[i].address,
      address2: responseData?.relationshipsbyperson[i].address2 === null ? '' : responseData?.relationshipsbyperson[i].address2,
      city: responseData?.relationshipsbyperson[i].city === null ? '' : responseData?.relationshipsbyperson[i].city,
      state: responseData?.relationshipsbyperson[i].state === null ? '' : responseData?.relationshipsbyperson[i].state,
      zipcode: responseData?.relationshipsbyperson[i].zipcode === null ? '' : responseData?.relationshipsbyperson[i].zipcode,
      phone: responseData?.relationshipsbyperson[i].phoneinfo === null ? '' : responseData?.relationshipsbyperson[i].phoneinfo,
      email: responseData?.relationshipsbyperson[i].email === null ? '' : responseData?.relationshipsbyperson[i].email,
    };
  }

  // Assosiated with setSupportiveRelationship method
  private handleCollateralLoopFn(responseData: any, supprtiveRelatnshipTempArray: any[]) {
    for (let i = 0; i < responseData?.collateral?.length; i++) {
      let collateraladdress: any = {};
      if (responseData?.collateral[i].collateraladdress !== null && responseData?.collateral[i].collateraladdress !== undefined) {
        collateraladdress = responseData?.collateral[i].collateraladdress.length > 0 ? responseData?.collateral[i].collateraladdress[0] : responseData?.collateral[i].collateraladdress;
      }

      supprtiveRelatnshipTempArray.push(
        this.returnHandleCollateralLoopDataFn(responseData, i, collateraladdress)
      );
    }
  }

  // Assosiated with setSupportiveRelationship method
  private returnHandleCollateralLoopDataFn(responseData: any, i: number, collateraladdress: any): any {
    return {
      id: responseData?.collateral[i].collateralid,
      name: responseData?.collateral[i].fullname,
      dob: responseData?.collateral[i].dob,
      relationshipTo: 'NA',
      address: collateraladdress !== null ? collateraladdress.address1 : '',
      address2: collateraladdress !== null ? collateraladdress.address2 : '',
      city: collateraladdress !== null ? collateraladdress.cityname : '',
      state: collateraladdress !== null ? collateraladdress.statetypekey : '',
      zipcode: collateraladdress !== null ? collateraladdress.zip5no : '',
      phone: this.getcollateralphoneitem(responseData?.collateral[i]),
      email: responseData?.collateral[i].email === null ? '' : responseData?.collateral[i].email
    };
  }

    // Assosiated with setSupportiveRelationship method
    private handleRelationshipDetails(responseData: any, supprtiveRelatnshipTempArray: any[]) {
      for (let i = 0; i < responseData?.realationshipdetails?.length; i++) {
        if (responseData?.realationshipdetails[i] !== null && responseData?.realationshipdetails[i] !== undefined) {
          const isRecordExists = supprtiveRelatnshipTempArray.filter(user => user.id ==  responseData?.realationshipdetails[i].personid);
          if (isRecordExists?.length == 0) {
            supprtiveRelatnshipTempArray.push( this.returnhandleRelationshipDetails(responseData, i));
          }
        }
      }
    }

    // Assosiated with setSupportiveRelationship method
  private returnhandleRelationshipDetails(responseData: any, i: number): any {
    return {
      id: responseData?.realationshipdetails[i].personid,
      name: responseData?.realationshipdetails[i].fullname,
      dob: responseData?.realationshipdetails[i].dob,
      address: responseData?.realationshipdetails[i].address === null ? '' : responseData?.realationshipdetails[i].address,
      address2: responseData?.realationshipdetails[i].address2 === null ? '' : responseData?.realationshipdetails[i].address2,
      city: responseData?.realationshipdetails[i].city === null ? '' : responseData?.realationshipdetails[i].city,
      state: responseData?.realationshipdetails[i].state === null ? '' : responseData?.realationshipdetails[i].state,
      zipcode: responseData?.realationshipdetails[i].zipcode === null ? '' : responseData?.realationshipdetails[i].zipcode,
      phone: responseData?.realationshipdetails[i].phoneinfo === null ? '' : responseData?.realationshipdetails[i].phoneinfo,
      email: responseData?.realationshipdetails[i].email === null ? '' : responseData?.realationshipdetails[i].email,
    };
  }

  setparentsOnlyArray(responseData: any) {
    this.parentsOnlyArray = [];
    //Only Parents
    if (responseData?.relationshipsbyperson?.length > 0) {
      const parents = responseData?.relationshipsbyperson?.filter((item: any) => (
        item.relationshiptypekey == 'BGFTHR' || item.relationshiptypekey == 'STMTHR' || item.relationshiptypekey == 'STPFTHR' || item.relationshiptypekey == 'UKMTHR' ||
        item.relationshiptypekey == 'UKNFTHR' || item.relationshiptypekey == 'BGMTHR' || item.relationshiptypekey == 'CUSLG' || item.relationshiptypekey == 'FSTRFTHR' ||
        item.relationshiptypekey == 'FSTRMTHR' || item.relationshiptypekey == 'GDNLGL' || item.relationshiptypekey == 'LGLFTHR' || item.relationshiptypekey == 'LGLMTHR' ||
        item.relationshiptypekey == 'PRNT' || item.relationshiptypekey == 'PUTFATHR' || item.relationshiptypekey == 'PTMTHR' || item.relationshiptypekey == 'ADPFTHR' || item.relationshiptypekey == 'ADPMTHR'
      )
      );
      if (parents?.length > 0) {
        this.parentsonlyarray(parents);
      }
    }
  }

  parentsonlyarray(parents: any) {
    for (const parent of parents) {
      this.parentsOnlyArray.push(
        this.returnParentsonlyarrayDataFn(parent)
      );
    }
  }

  // Assosiated with parentsonlyarray method
  private returnParentsonlyarrayDataFn(parent: any): any {
    return {
      id: parent.person2id,
      name: parent.person2name,
      dob: parent.dob,
      relationshipTo: parent.relation === null ? '' : parent.relation,
      address: parent.address === null ? '' : parent.address,
      address2: parent.address2 === null ? '' : parent.address2,
      city: parent.city === null ? '' : parent.city,
      state: parent.state === null ? '' : parent.state,
      zipcode: parent.zipcode === null ? '' : parent.zipcode,
      phone: parent.phoneinfo === null ? '' : parent.phoneinfo,
      email: parent.email === null ? '' : parent.email,
    };
  }

  setMeetings(responseData: any) {
    this.meetings = [];
    for (let i = 0; i < responseData?.meetings?.length; i++) {
      let tempData = '';
      for (let j = 0; j < responseData?.meetings[i]?.participants.length; j++) {
        if (tempData == '') {
          tempData = responseData?.meetings[i]?.participants[j]?.firstname + ' ' + responseData?.meetings[i]?.participants[j]?.lastname;
        } else {
          tempData = tempData + ', ' + responseData?.meetings[i]?.participants[j]?.firstname + ' ' + responseData?.meetings[i]?.participants[j]?.lastname;
        }
      }
      this.meetings.push({
        meetingtype: responseData?.meetings[i].meetingtype,
        meetingdate: responseData.meetings[i].meetingdate,
        location: '',
        virtual: false,
        inPerson: false,
        participants: tempData
      });
    }
    this.familyAccessForm.patchValue({
      meetings: this.meetings
    });
  }

  setCurrentPlacementType(res: any) {
    let value = '';
    if (res.programassingement == null) {
      value = 'Home - Not Removed';
    } else if (res.programassingement.length > 0 && res.providerplacement == null && res.livingarrangement == null) {
      value = 'Please update the Current Placement or Living Arrangement for the client';
    } else {
      value = 'N/A'
    }
    return value;
  }

  setLivingArrangmentType(res: any) {
    let value = '';
    if (res.programassingement == null) {
      value = 'Home - Not Removed';
    } else if (res.programassingement.length > 0 && res.livingarrangement == null && res.providerplacement == null) {
      value = 'Please update the Current Placement or Living Arrangement for the client';
    }
    return value;
  }

  selectYouth(eventname: any) {
    this.selectedYouthName = eventname;
    this.spouseorpartnerList = this.personList.filter(entry1 => !this.childList.some(entry2 => entry1.fullname === entry2.fullname))
    const event = this.youthList.find(item => item.fullname === this.selectedYouthName);

    this.referralForm.patchValue(event);
  }

  getfmrfdata() {
    const fmrfdataValue = {
      referralinformation: this.referralForm.getRawValue(),
      familyAccess: this.familyAccessForm.getRawValue(),
      currentSubmissionId: this.currentSubmissionId,
      routingsupervisors: this.routingSupervisors,
      assessmentStaus: this.assessmentStaus || this.fmrfdata.submissiondata?.assessmentStaus || null,
      supervisorname: this.familyAccessForm.getRawValue().supervisorname,
      facilitatorname: this.facilitatorname,
      facilitatorassigneddatetime: this.facilitatorassigneddatetime,
      ftdmUser: '',
      objectid: this.id,
      objectkey: "servicecase",
      sendFmrfNotification: false
    };
    this.fmrfdata = fmrfdataValue;
    return this.fmrfdata;
  }

  goBack() {
    setTimeout(() => {
      this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
    }, 1000);
  }

  private loadDropdownItems() {
    forkJoin([
      this._commonDDService.getListByTableID(76)
    ]).subscribe(([livingArrangements]) => {
      livingArrangements = livingArrangements.sort((e1, e2) =>
        e1.description.toLowerCase().localeCompare(e2.description.toLowerCase()));
      this.livingDropDownItems = livingArrangements.filter(item => item.activeflag === 1);
    });

  }

  deleteFamily(index: any) {
    const control_childarray = <FormArray>this.referralForm.controls['childarray'];
    const control_SubChildarray = <FormArray>this.referralForm.controls['SubChildarray'];
    control_childarray.removeAt(index);
    control_SubChildarray.removeAt(index);
  }

  changeSupervisor(userid: any) {
    const user = this.routingSupervisors.find((item: { userid: any; }) => item.userid === userid);
    if (user.username) {
      this.familyAccessForm.patchValue({
        supervisorname: user.username
      });
    }
  }

  statusChange(event: any) {
    this.familyAccessForm.patchValue({
      facilitatormeetingassessmentapprovaldate: moment(new Date()).format(this.dtformat1)
    });
  }
  getValidationMessage(controlName: any, displayname: any) {

    if (this.familyAccessForm.controls[controlName]?.status == 'INVALID') {
      return 'Please Enter value ' + displayname;
    }
    const familyaccess = this.familyAccessForm.getRawValue();

    switch (controlName) {
      case 'familyTeamDecisionMeeting1':
        if (this.checkFamilyTeamDecisionMeeting1(familyaccess)) {
          return displayname;
        }
        break;
      case 'snrfOtherMeetingNeeds':
        if (this.checkSnrfOtherMeetingNeeds(familyaccess)) {
          return "Please select  Atleast one Special Needs / Risk Factors";
        }
        break;
      case 'familyTeamDecisionMeeting':
        if (this.checkFamilyTeamDecisionMeeting(familyaccess)) {
          return "Please select  Atleast one Type of Facilitated Meeting";
        }
        break;
      case 'assessmentreviewed':
        if (this.checkAssessmentReviewed(familyaccess)) {
          return "please change status to review";
        }
        break;
    }
  }

  checkFamilyTeamDecisionMeeting1(familyaccess: any) {
    if (familyaccess.familyTeamDecisionMeeting &&
      !familyaccess.emergentChildSeperation && !familyaccess.consideredChildSeperation &&
      !familyaccess?.placementChangeStability && !familyaccess?.recommendationsPermanencyChange) {
      return true;
    } else {
      return false;
    }
  }

  checkSnrfOtherMeetingNeeds(familyaccess: any) {
    if (familyaccess.specialNeedsRiskFactorSelect.toLowerCase() == "yes" &&
      this.snrfChildcareCheck(familyaccess) &&
      this.snrfCourtOrderCheck(familyaccess) &&
      this.snrfLiteracyCheck(familyaccess) &&
      this.snrfTransportationCheck(familyaccess) &&
      this.snrfSafetyConcernsCheck(familyaccess) &&
      this.snrfADAConcernsCheck(familyaccess) &&
      this.snrfInterpreterCheck(familyaccess) &&
      this.snrfTraumaResponsiveNeedsCheck(familyaccess) &&
      this.snrfVirtualMeetingNeedsCheck(familyaccess) &&
      this.snrfOtherMeetingNeedsCheck(familyaccess)) {
      return true;
    } else {
      return false;
    }
  }

  snrfChildcareCheck(familyaccess: any) {
    if (familyaccess.snrfChildcare == null || familyaccess.snrfChildcare == undefined || familyaccess.snrfChildcare.toString().trim() == "false" || familyaccess.snrfChildcare.toString().trim() == "") {
      return true;
    } else {
      return false;
    }
  }

  snrfCourtOrderCheck(familyaccess: any) {
    if (familyaccess.snrfCourtOrder == null || familyaccess.snrfCourtOrder == undefined || familyaccess.snrfCourtOrder.toString().trim() == "" || familyaccess.snrfCourtOrder.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfLiteracyCheck(familyaccess: any) {
    if (familyaccess.snrfLiteracy == null || familyaccess.snrfLiteracy == undefined || familyaccess.snrfLiteracy.toString().trim() == "" || familyaccess.snrfLiteracy.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfTransportationCheck(familyaccess: any) {
    if (familyaccess.snrfTransportation == null || familyaccess.snrfTransportation == undefined || familyaccess.snrfTransportation.toString().trim() == "" || familyaccess.snrfTransportation.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfSafetyConcernsCheck(familyaccess: any) {
    if (familyaccess.snrfSafetyConcerns == null || familyaccess.snrfSafetyConcerns == undefined || familyaccess.snrfSafetyConcerns.toString().trim() == "" || familyaccess.snrfSafetyConcerns.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfADAConcernsCheck(familyaccess: any) {
    if (familyaccess.snrfADAConcerns == null || familyaccess.snrfADAConcerns == undefined || familyaccess.snrfADAConcerns.toString().trim() == "" || familyaccess.snrfADAConcerns.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfInterpreterCheck(familyaccess: any) {
    if (familyaccess.snrfInterpreter == null || familyaccess.snrfInterpreter == undefined || familyaccess.snrfInterpreter.toString().trim() == "" || familyaccess.snrfInterpreter.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfTraumaResponsiveNeedsCheck(familyaccess: any) {
    if (familyaccess.snrfTraumaResponsiveNeeds == null || familyaccess.snrfTraumaResponsiveNeeds == undefined || familyaccess.snrfTraumaResponsiveNeeds.toString().trim() == "" || familyaccess.snrfTraumaResponsiveNeeds.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfVirtualMeetingNeedsCheck(familyaccess: any) {
    if (familyaccess.snrfVirtualMeetingNeeds == null || familyaccess.snrfVirtualMeetingNeeds == undefined || familyaccess.snrfVirtualMeetingNeeds.toString().trim() == "" || familyaccess.snrfVirtualMeetingNeeds.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  snrfOtherMeetingNeedsCheck(familyaccess: any) {
    if (familyaccess.snrfOtherMeetingNeeds == null || familyaccess.snrfOtherMeetingNeeds == undefined || familyaccess.snrfOtherMeetingNeeds.toString().trim() == "" || familyaccess.snrfOtherMeetingNeeds.toString().trim() == "false") {
      return true;
    } else {
      return false;
    }
  }

  checkFamilyTeamDecisionMeeting(familyaccess: any) {
    if (this.familyTeamDecisionMeeting(familyaccess) &&
      this.qrtpCheck(familyaccess) &&
      this.voluntaryPlacementCheck(familyaccess) &&
      this.placementPlanningCheck(familyaccess) &&
      this.ytpCheck(familyaccess) &&
      this.facilitatedFamilyMeetingCheck(familyaccess)) {
      return true;
    } else {
      return false;
    }
  }

  familyTeamDecisionMeeting(familyaccess: any) {
    if (familyaccess.familyTeamDecisionMeeting == null || familyaccess.familyTeamDecisionMeeting == undefined || (!familyaccess.familyTeamDecisionMeeting)) {
      return true;
    } else {
      return false;
    }
  }

  qrtpCheck(familyaccess: any) {
    if (familyaccess.qrtp == null || familyaccess.qrtp == undefined || (!familyaccess.qrtp)) {
      return true;
    } else {
      return false;
    }
  }

  voluntaryPlacementCheck(familyaccess: any) {
    if (familyaccess.voluntaryPlacement == null || familyaccess.voluntaryPlacement == undefined || (!familyaccess.voluntaryPlacement)) {
      return true;
    } else {
      return false;
    }
  }

  placementPlanningCheck(familyaccess: any) {
    if (familyaccess.placementPlanning == null || familyaccess.placementPlanning == undefined || (!familyaccess.placementPlanning)) {
      return true;
    } else {
      return false;
    }
  }

  ytpCheck(familyaccess: any) {
    if (familyaccess.ytp == null || familyaccess.ytp == undefined || (!familyaccess.ytp)) {
      return true;
    } else {
      return false;
    }
  }

  facilitatedFamilyMeetingCheck(familyaccess: any) {
    if (familyaccess.facilitatedFamilyMeeting == null || familyaccess.facilitatedFamilyMeeting == undefined || (!familyaccess.facilitatedFamilyMeeting)) {
      return true;
    } else {
      return false;
    }
  }


  checkAssessmentReviewed(familyaccess: any) {
    if (familyaccess.assessmentreviewed == "InProcess" || familyaccess.assessmentreviewed == " " || familyaccess.assessmentreviewed == undefined) {
      return true;
    } else {
      return false;
    }
  }
  getValidationMessage1(controlName: any, displayname: any, index: any) {
    if (this.familyAccessForm.get('parentFacilityForm')?.get(`${index}`)?.get(controlName)?.invalid) {
      return 'Please Enter value ' + displayname;
    }
  }
  isReadyForApproval() {
    this.displayValidationMessages = false;
    ['orderControllingConduct', 'orderOfProtectingConduct'].forEach((item) => {
      this?.subChildForm?.get(item)?.setValidators([Validators.required]);
      this?.subChildForm?.get(item)?.updateValueAndValidity();
    });
    if (this?.subChildForm?.invalid) {
      this.displayValidationMessages = true;
      this?.subChildForm?.markAllAsTouched();
    }
    this.requiredForApproval = true;
    this.incompleteList = [];
    //Validate all required form elements fields 
    this.validateFormData();

    if (this.incompleteList.length == 0) {
      if (!this.isSupervisor) {
        this.familyAccessForm.patchValue({
          facilitatormeetingassessmentsubmitdate: moment(new Date()).format(this.dtformat)
        });
      }
      this.submitForApproval();
    } else {
      (<any>$('#incomplete-items')).modal('show');
    }
  }

  openaddfacilitator() {
    this.getteamlist();
    (<any>$('#facilitator-assignment-popup')).modal('show');
  }

  getteamlist() {
    this.familyAccessForm.get('toteamid')?.disable();
    const obj = {
      activeflag: 1,
      teamtypekey: this.user.role.teamtypekey
    }

    this._commonHttpService.getPagedArrayList(new PaginationRequest({
      where: obj,
      method: 'get',
      nolimit: true
    }), 'manage/team/getteamlist?filter').subscribe((result: any) => {
      this.teamList = result.filter((x: { name: string; }) => x.name == 'Facilitator/Qualified Supervisor' || x.name == 'FTDM/QI Supervisor');
      const activeteam = this.teamList.find((v: { isdefault: number; }) => v.isdefault === 1)
      if (activeteam) {
        if (this.familyAccessForm.get('toteamid')?.value == '') {
          this.familyAccessForm.get('toteamid')?.patchValue(activeteam.teamid);
          this.getteamusers(activeteam.teamid);
        }
      }
    });
    this.familyAccessForm.get('toteamid')?.enable();
  }

  getteamusers(data: any) {
    this.familyAccessForm.get('assigneduser')?.disable();
    const obj = {
      teamid: '',
      filtertypekey: 'ftdm'
    };
    obj.teamid = data === '' ? null : data;
    this._commonHttpService.getPagedArrayList(new PaginationRequest({
      where: obj,
      method: 'get',
      nolimit: true
    }), 'manage/team/getteamusers?filter').subscribe((result: any) => {
      this.unitCaseWorkerList = result;
      this.familyAccessForm.get('assigneduser')?.enable();
    });
  }

  caseTransfersubmit() {
    const teamid = this.familyAccessForm.get('toteamid')?.value;
    const assignedUser = this.familyAccessForm.get('assigneduser')?.value;
    if (teamid === null || teamid === '') {
      return this._alertService.error('Please select a Team/Unit');
    }

    if (assignedUser === null || assignedUser === '') {
      return this._alertService.error('Please select a Social Worker');
    }
    this.facilitatorname = this.unitCaseWorkerList.find((x: { userid: any; }) => x.userid == assignedUser)?.username;
    this.facilitatorassigneddatetime = moment(new Date()).format('MM/DD/YYYY hh:mm a');
    const submissiondata = this.getfmrfdata();
    submissiondata.sendFmrfNotification = true;
    submissiondata.ftdmUser = assignedUser;
    this.assessmentStaus = this.getassessmentStatus();
    submissiondata.assessmentStaus = this.getassessmentStatus();
    const data: any = {
      appeventcode: 'SRVC',
      assigneduser: assignedUser,
      responsibilitytypekey: 'administrative',
      selectDeptGroup: 'unit',
      assignmenttype: 'U',
      servicecaseid: this.id,
      toteamid: teamid,
      startdate: null,
      assessmenttype: "FTDM"
    };
    data.startdate = moment(new Date()).format('YYYY-MM-DD HH:mm:ss');
    this._commonHttpService.create(data, CaseWorkerUrlConfig.EndPoint.DSDSAction.Assignment.Reassigncase)
      .subscribe((res) => {
        if (res && res.length && res[0].statuscode === 200) {
          this._alertService.success(res[0].status_description);
          this._dataStoreService.setData('DSDS_ACTION_UPDATE', true);
          this.saveApprovalData(submissiondata);
          this.closefacilitatorModel();
        } else {
          this._alertService.error('Service Case Assignment Error');
        }
      });
  }

  closefacilitatorModel() {
    (<any>$('#facilitator-assignment-popup')).modal('hide');
  }

  patchlatestpersoninfo() {
    if (this.fmrfdata.submissiondata?.referralinformation) {
      const submittedReferralInfo = this.fmrfdata.submissiondata.referralinformation;
      for (const element of submittedReferralInfo.childarray) {
        const submittedchildinfo = element;
        const latestInfo = this.childList.find(x => x.cjamspid == submittedchildinfo.cjamsid);
        submittedchildinfo.fullname = latestInfo.fullname;
        submittedchildinfo.address = this.returnChildAddressFn(latestInfo);
        submittedchildinfo.dob = this.returnChildDobFn(latestInfo);
        submittedchildinfo.cjamsid = this.returnChildCjamsIdFn(latestInfo);
      }
      for (const subchild of submittedReferralInfo.SubChildarray) {
      //parent info
        for (const parent of subchild.parentsNameForm) {
          const isExist: any = this.parentsOnlyArray.find(x => x.id == parent.parentsName);
          const phoneArray = this.getPhoneArray(isExist);
          const addressString = this.getAddressString(isExist);
          isExist.email = isExist.email !== null ? isExist.email : 'NA';
          parent.name = isExist.name;
          parent.address = addressString;
          parent.phone = phoneArray;
          parent.email = isExist.email;
        }
      }
      this.referralForm.patchValue(this.fmrfdata.submissiondata.referralinformation);
    }
  }
  // Assosiated with patchlatestpersoninfo method
  private returnChildCjamsIdFn(latestInfo: any) {
    return (latestInfo.cjamspid ? latestInfo.cjamspid : '');
  }
  // Assosiated with patchlatestpersoninfo method
  private returnChildDobFn(latestInfo: any) {
    return (latestInfo.dob ? latestInfo.dob : '');
  }
  // Assosiated with patchlatestpersoninfo method
  private returnChildAddressFn(latestInfo: any) {
    return ((latestInfo.address) ? latestInfo.address + ' ' + (latestInfo.address2 || '') + ' ' + latestInfo.city + ' ' + latestInfo.state + ' ' + latestInfo.zipcode : null);
  }

  getPhoneArray(value: any) {
    const phoneArray: any[] = [];
    if (value.phone !== null && value.phone !== undefined && value.phone !== '{}' && value.phone !== "") {
      if (value.phone?.length > 0) {
        for (const element of value.phone) {
          phoneArray.push({ key: this.getPhoneKey(element.personphonetypekey), phone: this.getFormattedPhoneNumber(element.phonenumber) });
        }
      }
      else {
        phoneArray.push({ key: this.getPhoneKey(value.phone.personphonetypekey), phone: this.getFormattedPhoneNumber(value.phone.phonenumber) });
      }

    } else {
      phoneArray.push({ key: 'N/A', phone: '' })
    }
    return phoneArray;
  }

  getPhoneKey(value: any) {
    let phoneKey;
    if (value == 'HM') { phoneKey = 'Home' }
    else if (value == 'WK') { phoneKey = 'Work' }
    else if (value == 'CL') { phoneKey = 'Cell' }
    else { phoneKey = 'OTHERS' }
    return phoneKey;
  }

  getFormattedPhoneNumber(value: any) {
    return '(' + value.substring(0, 3) + ') ' + value.substring(3, 6) + '-' + value.substring(6, 10);
  }

  getAddressString(value: any) {
    let addressString = '';
    addressString = (value.address !== null && value.address !== "" && value.address !== undefined) ? value.address : 'N/A';
    if (addressString !== 'N/A') {
      addressString += (value.address2 !== null && value.address2 !== '' && value.address2 !== undefined) ? ', ' + value.address2 : ' ';
      addressString += (value.city !== null && value.city !== '' && value.city !== undefined) ? ', ' + value.city : ' ';
      addressString += (value.state !== null && value.state !== '' && value.state !== undefined) ? ', ' + value.state : ' ';
      addressString += (value.zipcode !== null && value.zipcode !== '' && value.zipcode !== undefined) ? ' - ' + value.zipcode : ' ';
    }
    return addressString;
  }

  validateFormData() {
    const submissiondata = this.getfmrfdata();
    let subChild = submissiondata.referralinformation.SubChildarray ? submissiondata.referralinformation.SubChildarray : [];
    const familyaccess = submissiondata.familyAccess;
    this.errMsg = [];
    this.fmlyerrMsg = [];
    this.commntsmsg = [];

    subChild.forEach((x: any) => {
      this.checkChildNameErrMsgs(x);
      this.checkRelationshipErrMsgs(x);
    })

    this.familyUnderstandingCheck(familyaccess);
    this.isWriteNeededCheck(familyaccess);
    this.facilityErrorCheck(familyaccess);
    this.familyPreferredCheck(familyaccess)
    this.familyErrorMessages(familyaccess);
    this.otherMeetingNeedsCheck(familyaccess);
    this.facilitatedMeetingCheck(familyaccess);
    this.keyDecisionPointCheck(familyaccess);
    this.facilitatedFamilyMeetingCheck2(familyaccess);
    this.commentsCheck(familyaccess);
    if (this.errMsg.length > 0) {
      var meetErr = { "name": " FAMILY AND YOUTH INFORMATION", "errMsg": this.errMsg };
      this.incompleteList.push(meetErr);
    }
    if (this.fmlyerrMsg.length > 0) {
      var flyAccErr = { "name": "  FAMILY ACCESS / MEETING NEEDS", "errMsg": this.fmlyerrMsg };
      this.incompleteList.push(flyAccErr);
    }
    if (this.commntsmsg.length > 0) {
      var commErr = { "name": "  APPROVALS / SIGNATURES", "errMsg": this.commntsmsg };
      this.incompleteList.push(commErr);
    }
  }

  checkChildNameErrMsgs(subChild: any) {
    const childName = subChild.childinfo.childname.toString();
    if ((subChild.orderControllingConduct == null || subChild.orderControllingConduct == undefined || subChild.orderControllingConduct == "")) {
      this.errMsg.push(childName + "  -  Order Controlling Conduct");
    }

    if (this.orderControllingConductCheck(subChild)) {
      this.errMsg.push(childName + "  -  Order Controlling Conduct Comments");
    }
    if ((subChild.orderOfProtectingConduct == null || subChild.orderOfProtectingConduct == undefined || subChild.orderOfProtectingConduct == "")) {
      this.errMsg.push(childName + "  -  Order Of Protective Supervision");
    }
    if (this.orderOfProtectingConductCheck(subChild)) {
      this.errMsg.push(childName + "  -  Order Of Protective Supervision Comments");
    }
  }

  orderControllingConductCheck(subChild: any) {
    if ((subChild.orderControllingConduct != null && subChild.orderControllingConduct.trim().toLowerCase() == "yes" && (
      subChild.orderControllingConductComments == null || subChild.orderControllingConductComments == undefined || subChild.orderControllingConductComments.trim() == ""))) {
      return true;
    } else {
      return false;
    }
  }

  orderOfProtectingConductCheck(subChild: any) {
    if ((subChild.orderOfProtectingConduct != null && subChild.orderOfProtectingConduct.trim().toLowerCase() == "yes" && (
      subChild.protectingConductComments == null || subChild.protectingConductComments == undefined || subChild.protectingConductComments.trim() == ""))) {
      return true;
    } else {
      return false;
    }
  }

  checkRelationshipErrMsgs(subChild: any) {
    const childName = subChild.childinfo.childname.toString();
    var supRel = subChild.supportiveRelationshipArray ? subChild.supportiveRelationshipArray : [];
    let supportiveIndex = 0;
    supRel.forEach((rel: any) => {
      supportiveIndex++;
      if ((rel.familyHasIndicate == null || rel.familyHasIndicate == undefined || rel.familyHasIndicate == "")) {
        this.errMsg.push(childName + "  -  Supportive Relationship/Resources - " + (rel.supportiveName ? rel.supportiveName : ' ROW-' + supportiveIndex) + " -- 	Family has indicated that attendance is Critical");
      }
      if ((rel.familyHasIndicate != null && rel.familyHasIndicate == "1" && (rel.hasWorker == null || rel.hasWorker == undefined || rel.hasWorker.trim() == ""))) {
        this.errMsg.push(childName + "  -  Supportive Relationship/Resources - " + (rel.supportiveName ? rel.supportiveName : ' ROW-' + supportiveIndex) + " -- Has Worker Made Contact");
      }
    })
  }

  familyUnderstandingCheck(familyaccess: any) {
    if (familyaccess.familyUnderstanding == null || familyaccess.familyUnderstanding == undefined || familyaccess.familyUnderstanding.trim() == "") {
      this.fmlyerrMsg.push("Family’s understanding of the purpose");
    }
  }

  isWriteNeededCheck(familyaccess: any) {
    if (familyaccess.isWriteNeeded == null || familyaccess.isWriteNeeded == undefined || familyaccess.isWriteNeeded.trim() == "") {
      this.fmlyerrMsg.push(" Writ needed or any other specific steps taken in order to have parent(s) participate");
    } else if (familyaccess.isWriteNeeded.toLowerCase() == "yes" && (familyaccess.isWriteNeededComments == null || familyaccess.isWriteNeededComments == undefined || familyaccess.isWriteNeededComments.trim() == "")) {
      this.fmlyerrMsg.push(" Writ needed or any other specific steps taken in order to have parent(s) participate - Comments");
    }
  }

  facilityErrorCheck(familyaccess: any) {
    var fmlyUnd = familyaccess.parentFacilityForm ? familyaccess.parentFacilityForm : [];

    if (this.parentResidingFacilityCheck(familyaccess)) {
      this.fmlyerrMsg.push("   Indicate if parent(s) are residing/committed to a facility of any kind");
    } else {
      if (familyaccess.parentResidingFacility.trim().toLowerCase() == "yes" && fmlyUnd.length <= 0) {
        this.fmlyerrMsg.push("Parent(s) residing/committed Facility Details ");
      } else if (familyaccess.parentResidingFacility.trim().toLowerCase() == "yes" && fmlyUnd.length > 0) {
        this.fmlyUndforeachcheck(fmlyUnd);
      }
    }
  }

  fmlyUndforeachcheck(fmlyUnd: any) {
    let flyparentcnt = 0;
    fmlyUnd.forEach((y: any) => {
      flyparentcnt++;
      if (this.facilityNameCheck(y)) {
        this.fmlyerrMsg.push(this.facilityrowstr + flyparentcnt.toString() + " - Facility Name");
      }
      if (this.facilityAddressCheck(y)) {
        this.fmlyerrMsg.push(this.facilityrowstr + flyparentcnt.toString() + " - Facility Address ");
      }

      if (this.facilityContactCheck(y)) {
        this.fmlyerrMsg.push(this.facilityrowstr + flyparentcnt.toString() + " - Facility Contact Details ");
      }
    })

  }
  parentResidingFacilityCheck(familyaccess: any) {
    if (familyaccess.parentResidingFacility == null || familyaccess.parentResidingFacility == undefined || familyaccess.parentResidingFacility.trim() == "") {
      return true;
    } else {
      return false;
    }
  }

  facilityNameCheck(facility: any) {
    if (facility.facilityName == null || facility.facilityName == undefined || facility.facilityName.trim() == "") {
      return true;
    } else {
      return false;
    }
  }

  facilityAddressCheck(facility: any) {
    if (facility.address == null || facility.address == undefined || facility.address.trim() == "") {
      return true;
    } else {
      return false;
    }
  }

  facilityContactCheck(facility: any) {
    if ((facility.phone == null || facility.phone == undefined || facility.phone.trim() == "") &&
      (facility.fax == null || facility.fax == undefined || facility.fax.trim() == "") &&
      (facility.email == null || facility.email == undefined || facility.email.trim() == "")) {
      return true;
    } else {
      return false;
    }
  }

  familyPreferredCheck(familyaccess: any) {
    if (familyaccess.familyPreferred == null || familyaccess.familyPreferred == undefined || familyaccess.familyPreferred.trim() == "") {
      this.fmlyerrMsg.push("Family’s preferred location of meeting");
    }
  }

  familyErrorMessages(familyaccess: any) {
    if (this.specialNeedsRiskFactorSelectCheck(familyaccess)) {
      this.fmlyerrMsg.push("Special Needs / Risk Factors (For Facilitated Meeting)");
    } else if (this.specialNeedsErrorCheck(familyaccess)) {
      this.fmlyerrMsg.push("Atleast one Special Needs / Risk Factors");
    } else if (this.specialNeedsRiskFactorSelectCheck2(familyaccess)) {
      this.fmlyerrMsg.push("Specific Explanation of selected Special Needs:");
    }
  }

  specialNeedsRiskFactorSelectCheck(familyaccess: any) {
    if (familyaccess.specialNeedsRiskFactorSelect == null || familyaccess.specialNeedsRiskFactorSelect == undefined || familyaccess.specialNeedsRiskFactorSelect.trim() == "") {
      return true;
    } else {
      return false;
    }
  }

  specialNeedsErrorCheck(familyaccess: any) {
    if (familyaccess.specialNeedsRiskFactorSelect.toLowerCase() == "yes" &&
      this.snrfChildcareValidation(familyaccess) &&
      this.snrfCourtOrderValidation(familyaccess) &&
      this.snrfLiteracyValidation(familyaccess) &&
      this.snrfTransportationValidation(familyaccess) &&
      this.snrfSafetyConcernsValidation(familyaccess) &&
      this.snrfADAConcernsValidation(familyaccess) &&
      this.snrfInterpreterValidation(familyaccess) &&
      this.snrfTraumaResponsiveNeedsValidation(familyaccess) &&
      this.snrfVirtualMeetingNeedsValidation(familyaccess) &&
      this.snrfOtherMeetingNeedsValidation(familyaccess)) {
      return true;
    } else {
      return false;
    }
  }

  validateField(fieldValue: any) {
    return fieldValue == null ||
      fieldValue == undefined ||
      fieldValue.toString().trim() === "false" ||
      fieldValue.toString().trim() === "";
  }

  snrfChildcareValidation(familyaccess: { snrfChildcare: any; }) {
    return this.validateField(familyaccess.snrfChildcare);
  }

  snrfCourtOrderValidation(familyaccess: { snrfCourtOrder: any; }) {
    return this.validateField(familyaccess.snrfCourtOrder);
  }

  snrfLiteracyValidation(familyaccess: { snrfLiteracy: any; }) {
    return this.validateField(familyaccess.snrfLiteracy);
  }

  snrfTransportationValidation(familyaccess: { snrfTransportation: any; }) {
    return this.validateField(familyaccess.snrfTransportation);
  }

  snrfSafetyConcernsValidation(familyaccess: { snrfSafetyConcerns: any; }) {
    return this.validateField(familyaccess.snrfSafetyConcerns);
  }

  snrfADAConcernsValidation(familyaccess: { snrfADAConcerns: any; }) {
    return this.validateField(familyaccess.snrfADAConcerns);
  }

  snrfInterpreterValidation(familyaccess: { snrfInterpreter: any; }) {
    return this.validateField(familyaccess.snrfInterpreter);
  }

  snrfTraumaResponsiveNeedsValidation(familyaccess: { snrfTraumaResponsiveNeeds: any; }) {
    return this.validateField(familyaccess.snrfTraumaResponsiveNeeds);
  }

  snrfVirtualMeetingNeedsValidation(familyaccess: { snrfTraumaResponsiveNeeds: any; }) {
    return this.validateField(familyaccess.snrfTraumaResponsiveNeeds);
  }

  snrfOtherMeetingNeedsValidation(familyaccess: { snrfOtherMeetingNeeds: any; }) {
    return this.validateField(familyaccess.snrfOtherMeetingNeeds);
  }

  specialNeedsRiskFactorSelectCheck2(familyaccess: any) {
    if (familyaccess.specialNeedsRiskFactorSelect.toLowerCase() == "yes" && (familyaccess.specialNeedsRiskFactorsComments == null || familyaccess.specialNeedsRiskFactorsComments == undefined || familyaccess.specialNeedsRiskFactorsComments.trim() == "")) {
      return true;
    } else {
      return false;
    }
  }


  otherMeetingNeedsCheck(familyaccess: any) {
    if (familyaccess.snrfOtherMeetingNeeds != null && familyaccess.snrfOtherMeetingNeeds != undefined && familyaccess.snrfOtherMeetingNeeds && (familyaccess.otherMeetingNeedsComments == null || familyaccess.otherMeetingNeedsComments == undefined || familyaccess.otherMeetingNeedsComments.trim() == "")) {
      this.fmlyerrMsg.push("Other Meeting Needs");
    }
  }

  facilitatedMeetingCheck(familyaccess: any) {
    if (this.familyTeamDecisionMeeting(familyaccess) &&
      this.qrtpCheck(familyaccess) &&
      this.voluntaryPlacementCheck(familyaccess) &&
      this.placementPlanningCheck(familyaccess) &&
      this.ytpCheck(familyaccess) &&
      this.facilitatedFamilyMeetingCheck(familyaccess)) {
      this.fmlyerrMsg.push("Type of Facilitated Meeting");
    }
  }


  keyDecisionPointCheck(familyaccess: any) {
    if (familyaccess.familyTeamDecisionMeeting && (
      (familyaccess.recommendationsPermanencyChange == null || familyaccess.recommendationsPermanencyChange == undefined || !familyaccess.recommendationsPermanencyChange) &&
      (familyaccess.emergentChildSeperation == null || familyaccess.emergentChildSeperation == undefined || !familyaccess.emergentChildSeperation) &&
      (familyaccess.consideredChildSeperation == null || familyaccess.consideredChildSeperation == undefined || !familyaccess.consideredChildSeperation) &&
      (familyaccess.placementChangeStability == null || familyaccess.placementChangeStability == undefined || !familyaccess.placementChangeStability)
    )
    ) {
      this.fmlyerrMsg.push("Key Decision Point for Family Team Decision Meeting");
    }
  }


  facilitatedFamilyMeetingCheck2(familyaccess: any) {
    if (familyaccess.facilitatedFamilyMeeting && (familyaccess.facilitatedFamilyMeetingComments == null || familyaccess.facilitatedFamilyMeetingComments == undefined || familyaccess.facilitatedFamilyMeetingComments.trim() == "")) {
      this.fmlyerrMsg.push("Reason for Meeting (include why it requires a facilitator)");
    }
  }


  commentsCheck(familyaccess: any) {
    if (familyaccess.assessmentreviewed == "InProcess") {
      this.commntsmsg.push("Review Status")
    }
    if (!familyaccess.facilitatormeetingassessmentcompletiondate) {
      this.commntsmsg.push("Facilitator Meeting Assessment Completion Date")
    }

    if (this.isSupervisor) {
      if (!familyaccess.assessmentStaus || familyaccess.assessmentStaus == "InProcess") {
        this.commntsmsg.push("Assessment Status")
      }
      if (familyaccess.assessmentStaus == "Accepted" && !familyaccess.facilitatormeetingassessmentapprovaldate) {
        this.commntsmsg.push("Facilitator Meeting Assessment Approval Date")
      }
      if (familyaccess.assessmentStaus == "Rejected" && !familyaccess.supervisorcomments) {
        this.commntsmsg.push("Please Enter Supervisor Comments for Rejection")
      }
    }
  }



  getErrorsMessage(ControlName: any, displayName: any) {
    if (this.subChildForm.controls[ControlName].status == 'INVALID') {
      return 'Please select ' + displayName
    }
  }

  onChange($event: any) {
    let _id = $event?.source?.id;
    if (_id && $event?.value) {
      _id = parseInt($event?.value) === 1 ? _id.replace('-(1)', '') : _id.replace('-(2)', '');
      let idValue: any = document.getElementById(_id);
      idValue.innerHTML = '';
    }
  }

  getParentFacilityData(): any[] {
    return Object.values((this.familyAccessForm.get('parentFacilityForm') as FormGroup).controls);
  }

  getReferalFormData(name: string): any[] {
    return Object.values((this.referralForm.get(name) as FormGroup).controls);
  }

  returnCjamsIdFn(i: any) {
    return this.referralForm.get(['childarray', i, 'cjamsid'])?.value
  }

  returnNameFn(i: any) {
    return this.referralForm.get(['childarray', i, 'name'])?.value
  }

  returnDobFn(i: any) {
    return this.referralForm.get(['childarray', i, 'dob'])?.value
  }
}
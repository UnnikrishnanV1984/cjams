
import {pluck, share} from 'rxjs/operators';
import { Component, OnInit, OnDestroy, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { DynamicObject, PaginationRequest, PaginationInfo } from '../../../../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, AuthService, SessionStorageService } from '../../../../../../../@core/services';
import { Router } from '@angular/router';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { AppUser } from '../../../../../../../@core/entities/authDataModel';
import { Observable } from 'rxjs';
import { SpeechRecognitionService } from '../../../../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { InvolvedPerson } from '../../../../../../../@core/common/models/involvedperson.data.model';
import { FinanceService } from '../../../../../../finance/finance.service';
import { AppConstants } from '../../../../../../../@core/common/constants';
import moment from 'moment';


@Component({
    selector: 'subsidy-rate',
    templateUrl: './subsidy-rate.component.html',
    styleUrls: ['./subsidy-rate.component.scss'],
    standalone: false
})
export class SubsidyRateComponent implements OnInit, OnDestroy {
  subsidyAgreementRateForm!: FormGroup;
  providerSearchForm!: FormGroup;
  routingForm!: FormGroup;
  currProcess!: string;
  id: string;
  speechData!: string;
  selectedViewProvider: any;
  selectedparent: any;
  adoptiveparent1!: string;
  parent1providerid!: string;
  parent2providerid!: string;
  adoptiveparent1id!: string;
  adoptiveparent2id!: string;
  rateExceeded!: boolean;
  placementStrType: any;
  adoptiveparent2!: string;
  notification!: string;
  daNumber: string;
  fcpaginationInfo: PaginationInfo = new PaginationInfo();
  store: DynamicObject;
  selectedProvider: any;
  permanencyplanid!: string;
  agreementRate!: any[];
  fcProviderSearch: any;
  parent1providername!: string;
  parent2providername!: string;
  markersLocation : Array<any> = [];
  zoom!: number;
  defaultLat = 39.29044;
  defaultLng = -76.61233;
  paginationInfo: PaginationInfo = new PaginationInfo();
  fcTotal: any;
  childPlacement: any;
  breakLink: any;
  isView!: boolean;
  specialNeedsDropDown!: any[];
  relationshipDropDown!: any[];
  childCharacteristics!: any[];
  otherLocalDeptmntType!: any[];
  childPlacedfromDropDown!: any[];
  childPlacedbyDropDown!: any[];
  bundledPlcmntServicesType!: any[];
  involvedPersons$!: Observable<any[]>;
  involvedPersons: any[] = [];
  selectedIndex!: number;
  adoptionagreementrateid: any;
  unapprovedtrateid: any;
  genderDropdownItems!: any[];
  isEdit!: boolean;
  isSentForReview: boolean = true;
  minAge!: number;
  maxAge!: number;
  gender!: string;
  lat = 51.678418;
  lng = 7.809007;
  showMap!: boolean;
  agreement: any;
  child: any;
  isSupervisor: boolean;
  user!: AppUser;
  approvalStatus!: string;
  recognizing = false;
  currentLanguage!: string;
  speechRecogninitionOn!: boolean;
  token!: AppUser;
  uploadedFile: any = [];
  deleteAttachmentIndex!: number;
  reportedChild!: InvolvedPerson;
  isAdoptionCase: boolean;
  childremoval: any;
  ratemaxDate: any;
  agreementMinDate: any;
  rateMinDate: any;
  disableaddrate = false;
  isAdoptionCreated!: boolean;
  agreementsignedDate: any;
  isRequired!: boolean;
  medicalAssistanceOnlyGetChecked = false;
  paymentAmountPattern = '^[0-9][0-9]*([.][0-9]{1,2}|)$';
  annualReviewList: any;
  isServiceCase: any;
  serviceCase!: boolean;
  overpayments!: any[];
  placmentDetails: any;
  providerDetails: any;
  provider_id: any;
  isPrivateAdoption!: boolean;
  providerid: any;
  baseRate!: number;

  quillToolbar = AppConstants.NARRATIVE.TOOLBAR_CONFIG;
  adoptionAlternateId: any;
  sendForApproval = false;
  isEnddateedited!: string;
  isedited!: boolean;
  maxEndDate!: Date;
  ssaApproved!: boolean;
  initialAgreementRate: any[] = [];
  isEditDisabled = false;
  sentRateForReview!: boolean;
  gettypesurl = 'referencetype/gettypes';

  private readonly _commonHttp: CommonHttpService;
  private readonly _formBuilder: FormBuilder;
  private readonly _alert: AlertService;
  private readonly _store: DataStoreService;
  private readonly _router: Router;
  private readonly _PlacementAdoptionService: PlacementAdoptionService;
  public _authService: AuthService;
  private readonly _session: SessionStorageService;
  private readonly _speechRecognitionService: SpeechRecognitionService;

  constructor(
    private readonly injector : Injector,
    private readonly speechRecognizer: SpeechRecognizerService,
    private readonly _financeService: FinanceService
  ) {
    this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alert = this.injector.get<AlertService>(AlertService);
    this._store = this.injector.get<DataStoreService>(DataStoreService);
    this._router = this.injector.get<Router>(Router);
    this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);

    this.daNumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.store = this._store.getCurrentStore();
    this.id = this.store['CASEUID'];
    this.daNumber = this.store['DANUMBER'];
    this.breakLink = this.store['adoptionBreakLink'];
    if (this.store['placement_child']) {
      this.childPlacement = this.store['placement_child'];
      this.permanencyplanid = this.store['placement_child'].permanencyplanid;

      this.child = this.store[CASE_STORE_CONSTANTS.PLACED_CHILD];
      const childdob = new Date(this.child.dob);
      const dob = moment(childdob);
      this.maxEndDate = dob.add(21,'years').toDate();
    }
    const caseType = this._store.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);

    if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
        this.isAdoptionCase = true;
    } else {
      this.isAdoptionCase = false;
    }
  }

  ngOnInit() {
    this.isEditDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.subsidy.rateedit');
    this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this.isPrivateAdoption = this._store.getData('ISPRIVATEADOPTION');
    if (this.isServiceCase === 'true') {
      this.serviceCase = true;
    } else {
        this.serviceCase = false;
    }
    this.currProcess = 'search';
    this.token = this._authService.getCurrentUser();
    this.sentRateForReview = false;
    this.formInitialize();
    this.getBreaklink();
    this.getAgreementListing();
    this.getDropDownList();
    this.getReviews();
    this.currentLanguage = 'en-US';
    this.speechRecognizer.initialize(this.currentLanguage);

    this.ratemaxDate = new Date();
    if(this.annualReviewList && this.annualReviewList.length){
      let reviewenddate = new Date(this.annualReviewList[this.annualReviewList.length - 1].assessmentdate);
      reviewenddate.setFullYear(reviewenddate.getFullYear() + 1);
      reviewenddate.setDate(reviewenddate.getDate() - 1);
      this.ratemaxDate = reviewenddate.getDate();
    }

    this.user = this._authService.getCurrentUser();
    this.getInvolvedPerson();
    if (this.user.role.name === 'apcs') {
      this.isSupervisor = true;
      this.subsidyAgreementRateForm.disable();
    }
    const pid = (this.child && this.child.personid) ? this.child.personid : null;
    this.getReportedChild(pid);
    if (this.childPlacement && this.childPlacement.providerdetails) {
      this.parent1providerid = this.childPlacement.providerdetails.provider_id ? this.childPlacement.providerdetails.provider_id : null;
      this.parent1providername = this.childPlacement.providerdetails.providername ? this.childPlacement.providerdetails.providername : null;
    }
    
    this.isRequired = true;
    this.decideSSAApproval();
    if (this.serviceCase) {
      this.childPlacementList();
    }
  }

  ngAfterViewInit(): void {
    this.getAgreementListing();
  }

  getReviews() {
    this._commonHttp.getArrayList(
      new PaginationRequest({
          page: 1,
          limit: 10,
          where: {
              adoptioncaseid: this.id },
          method: 'get'
      }),
      'adoptioniverenewal/list' + '?filter'
    ).subscribe(
      (resp) => {
          this.annualReviewList = resp;
      });
  }

  formInitialize() {
    this.subsidyAgreementRateForm = this._formBuilder.group({
      transactiondate: [new Date()],
      startdate: [new Date(), Validators.required],
      enddate: [null, Validators.required],
      provider_id: [null],
      paymentamout: [null],
      isapproval: [null],
      approvaldate: [null],
      isssaapproved: [null],
      ssaapproveddate: [null],
      isspeacialneeds: [null],
      parent1actorid: [null],
      parent2actorid: [null],
      childrelationship: [null],
      notes: [null],
      specialneedremarks: [null],
      specialneedtypekey: [null],
      adoptionagreementrateid: [null],
      adoptionagreementid: [null],
      adoptionplanningid: [null]
    });

    this.subsidyAgreementRateForm.controls.isssaapproved.valueChanges.subscribe(value => {
      if (value === 1) {
        this.ssaApproved = true;
        this.subsidyAgreementRateForm.controls.ssaapproveddate.setValidators([Validators.required]);
      } else {
        this.ssaApproved = false;
        this.subsidyAgreementRateForm.controls.ssaapproveddate.setValidators(null);
      }
      this.subsidyAgreementRateForm.controls.ssaapproveddate.updateValueAndValidity();
    });
  }

  getInvolvedPerson() {
    let reqObj = {};
      reqObj = {
        objectid: this.id,
        objecttypekey: 'servicecase'
      };
    this.involvedPersons$ = this._commonHttp
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: reqObj
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
      ).pipe(
      share(),
      pluck('data'),);
    this.involvedPersons$.subscribe((items) => {
      if (items) {

        const person = items.filter((item) => {
          if (!item.rolename || item.rolename === '') {
            if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
              item.rolename = item.roles[0].intakeservicerequestpersontypekey;
            }
          }
          if (item.rolename === 'ADOPTPARNT') {
            this.handleIfRolenameIsADOPTPARNT(item);
            return item;
          }
        });

        this.involvedPersons = person.map((res) => res);
      }
    });
  }
  // Assosiated with getInvolvedPerson method
  private handleIfRolenameIsADOPTPARNT(item: any) {
    if (!item.intakeservicerequestactorid) {
      if (item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
        item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
      }
    }
  }

  getAgreementListing() {
    let planningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
    if (this.isSupervisor && this.isAdoptionCase) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }
    if (!planningid) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }
    if (!planningid) {
      planningid = this.store['adoptionAgreement'] ? this.store['adoptionAgreement'].adoptionplanningid : null;
    }
    if (!this.isSupervisor && this.isAdoptionCase) {
      planningid = this._session.getItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    }
    let url = '';
    let obj;

    if (this.isAdoptionCase) {
      url = 'adoptioncaseagreement/list?filter';
      obj = { adoptioncaseid: this.id };
    } else {
      url = 'adoptionagreement/list?filter';
      obj = { adoptionplanningid: planningid };
    }

    this._commonHttp
      .getSingle(
        new PaginationRequest({
          where: obj,
          method: 'get',
          page: 1,
          limit: 10
        }),
        url
      )
      .subscribe(res => {
        if (res && res.length && Array.isArray(res)) {
          this.handleAgreementListingResponseFn(res);
        }
      });
  }
  // Assosiated with getAgreementListing function
  private handleAgreementListingResponseFn(res: any[]) {
    const obcj = res[0];
    const agreementList = this.isAdoptionCase ? obcj.getadoptioncaseagreementlist : obcj.getadoptionagreementlist;
    if (!agreementList || agreementList.length === 0) {
      return;
    }
    const length = agreementList.length - 1;
    this.agreement = agreementList[length];
    this.adoptionAlternateId = agreementList[length].alternateid;
    this._store.setData('adoptionAlternateID', this.adoptionAlternateId);
    this.permanencyplanid = agreementList[length].permanencyplanid;
    this.uploadedFile = agreementList[length].attachments ? agreementList[length].attachments : [];
    if(this.agreement.enddate == undefined || this.agreement.enddate == null){
      this.agreement.enddate = this.getEndDate();
    }
    this.parent1providerid = this.agreement.parent1providerid;
    this.parent2providerid = this.agreement.parent2providerid;
    this.parent1providername = this.agreement.parent1providername;
    this.parent2providername = this.agreement.parent2providername;
    this.baseRate = this.agreement.lastfcpaymentamount
    this._store.setData('adoptionAgreement', this.agreement);
    /* Service Case / Adoption Subsidy Agreement:
      Don't allow user to add 2nd rate. */
    if (this.isServiceCase && Array.isArray(this.agreementRate) && this.agreementRate.length) {
      this.disableaddrate = true;
    }
    // }
    this.handleIfAgreementrateFn();
  }
  // Assosiated with getAgreementListing function
  private handleIfAgreementrateFn() {
    if (!this.agreement.agreementrate) {
      return;
    }
      this.agreementRate = this.agreement.agreementrate;
      const currentUnapproved = this.agreementRate.find(item => ['Incomplete', 'Review'].includes(item.typedescription))
      this.unapprovedtrateid = currentUnapproved ? currentUnapproved.adoptionagreementrateid : '';
      this.approvalStatus = currentUnapproved ? currentUnapproved.typedescription : 'Approved';
      if (this.agreementRate[this.agreementRate.length-1].typedescription === 'Rejected') {
        const duplicateRejected = this.agreementRate.filter((item, index) => {
          return( 
            index !== this.agreementRate.length-1
            && item.startdate === this.agreementRate[this.agreementRate.length-1].startdate
            && item.typedescription !== 'Rejected'
            );
        });
        if(duplicateRejected.length === 0) {this.approvalStatus = 'Rejected'}
      }
    this.disableaddrate = this.agreementRate.some(item => ['Review', 'Incomplete', null].includes(item.typedescription));
    this.isSentForReview = this.agreementRate.some(item => [this.approvalStatus.toString()].includes(item.typedescription));

    if (this.isAdoptionCase && Array.isArray(this.agreementRate) && this.agreementRate.length) {
      this.agreementRate.forEach(rate => {
        this.checkAgreementRateCondFn(rate);
      });
    }
    this.provider_id = this.agreement.agreementrate.provider_id;
    this.isedited = (this.agreement.newenddate && (this.agreement.newenddate !== this.agreement.enddate)) ? true : false;
    // }
  }
  // Assosiated with getAgreementListing function
  private checkAgreementRateCondFn(rate: any) {
    if (rate.isssaapproved != null) {
      rate.isssaapproved = (rate.isssaapproved === 'true' || rate.isssaapproved === true || rate.isssaapproved == 1) ? 1 : 2;
    }
    if (rate.isspeacialneeds != null) {
      rate.isspeacialneeds = (rate.isspeacialneeds === 'true' || rate.isspeacialneeds === true || rate.isspeacialneeds == 1) ? 1 : 2;
    }
  }

  getEndDate(){
    let enddate = this.agreement.enddate;
    if(this.store && this.store['CHILD']){
      const childdob = new Date(this.store['CHILD'].dob);
      const dob = moment(childdob);
      enddate = dob.add(18, 'years').toDate(); // Default value =18th bday if nothing set.
      if (Array.isArray(this.agreement.agreementrate) && this.agreement.agreementrate.length) {
        const rate = this.agreement.agreementrate[this.agreement.agreementrate.length - 1];
        const rateenddate = new Date(rate.enddate);
        rateenddate.setHours(0, 0, 0, 0);
        if(enddate < rateenddate){
          const cDob = moment(childdob);
          enddate = cDob.add(21, 'years').toDate(); //If enddate of latest rate agreement is after 18th bday, then 21st
        }
      }
    }
    return enddate;
  }

  patchForm(data: any, mode: any, index: any) {
    this.isView = mode;
    this.isEdit = !mode;
    this.ratemaxDate = null;
    if (this.isEdit) {
      this.selectedIndex = index;
    }
    if (!data.typedescription || data.typedescription === 'Review') {
      this.adoptionagreementrateid = data.adoptionagreementrateid;
    } else {
      this.adoptionagreementrateid = null;
    }
    data.transactiondate = data.transactiondate ? data.transactiondate : new Date();
    this.subsidyAgreementRateForm.patchValue(data);
    if (this.isEdit) {
      this.subsidyAgreementRateForm.enable();
      this.subsidyAgreementRateForm.controls.startdate.setValidators([Validators.required]);
      this.subsidyAgreementRateForm.controls.enddate.setValidators([Validators.required]);
    } else {
      this.subsidyAgreementRateForm.disable();
    }
    const rateEndDate = this.subsidyAgreementRateForm.getRawValue().enddate;
    if (rateEndDate) {
      this.ratemaxDate = new Date(rateEndDate);
    }

    if (this.agreementRate && this.agreementRate.length && this.agreementRate.length > 1) { //should have atleast 2 rates else agreement start date is min
      const lastrate = this.agreementRate[this.agreementRate.length - 2]; //edit should look at 2nd index from last since the last row is being edited
      const enddate = new Date(lastrate.enddate);
      enddate.setDate(enddate.getDate() + 1);
      this.rateMinDate = enddate;
    } else {
      const agreementDate = this.agreement.startdate;
      this.rateMinDate = agreementDate;
    }
    this.ratestartdatechange();
    setTimeout(() => { (<any>$('#rate')).modal('show'); }, 400);
  }

  getDropDownList() {
    this._commonHttp.getArrayList(
      { method: 'get',
        where: {
          referencetypeid: 110,
          teamtypekey: 'CW'
        }
      },
      this.gettypesurl + '?filter'
    ).subscribe((item) => {
      this.specialNeedsDropDown = item;
    });

    this._commonHttp.getArrayList(
      { method: 'get',
        where: {
          referencetypeid: 900,
          teamtypekey: 'CW'
        }
      },
      this.gettypesurl + '?filter'
    ).subscribe((item) => {
      this.childPlacedfromDropDown = item;
    });

    this._commonHttp.getArrayList(
      { method: 'get',
        where: {
          referencetypeid: 901,
          teamtypekey: 'CW'
        }
      },
      this.gettypesurl + '?filter'
    ).subscribe((item) => {
      this.childPlacedbyDropDown = item;
    });

    this._commonHttp.getArrayList(
      { method: 'get',
        where: {
          referencetypeid: 109,
          teamtypekey: 'cw'
        }
      },
      this.gettypesurl + '?filter'
    ).subscribe((item) => {
      this.relationshipDropDown = item;
    });
  }

  resetRateForm() {
    this.ratemaxDate = null;
    this.subsidyAgreementRateForm.enable();
    this.subsidyAgreementRateForm.reset();
    this.decideSSAApproval();
    this.isView = false;
    this.isEdit = false;
    this.selectedIndex = -1;
  }

  existingRateRangeValidation(startdate: any, enddate: any, rateid: any) {
    let isValid = true;

    if (this.agreementRate && this.agreementRate.length) {
      this.agreementRate.forEach(rate => {
        if (
          ( ( new Date(startdate).getTime() > new Date(rate.startdate).getTime() && new Date(startdate).getTime() < new Date(rate.enddate).getTime() ) ||
            ( new Date(enddate).getTime() > new Date(rate.startdate).getTime() && new Date(enddate).getTime() < new Date(rate.enddate).getTime())
          ) && (rateid !== (rate.adoptionagreementrateid?rate.adoptionagreementrateid:rate.agreementrateid) ) && rate.typedescription !== 'Rejected'
        ) {
          isValid = false; 
        }
      });
    }

    return isValid;
  }

  addRate() {
    if (this.agreement && this.agreement.adoptionagreementid && this.agreement.routingstatus === 'Approved') {
      if (this.agreementRate && this.agreementRate.length) {
        this.subsidyAgreementRateForm.reset();
        this.isView = false;
        this.isEdit = false;
        this.selectedIndex = -1;

        this.subsidyAgreementRateForm.controls.startdate.setValidators([Validators.required]);
        this.subsidyAgreementRateForm.controls.enddate.setValidators([Validators.required]);

        const lastrate = this.agreementRate[this.agreementRate.length - 1];
        const enddate = new Date(lastrate.enddate);
        enddate.setDate(enddate.getDate() + 1);

        if (new Date(enddate).setHours(0,0,0,0) >= new Date(this.agreement.enddate).setHours(0,0,0,0)) {
          (<any>$('#agreement-enddate-validation')).modal('show');
          return;
        } else {
          this.rateMinDate = enddate;
          this.subsidyAgreementRateForm.patchValue({ transactiondate: new Date(), startdate: enddate });
          this.ratestartdatechange();
        }
      } else {
        const agreementDate = this.agreement.startdate;

        if (agreementDate) {
          this.rateMinDate = agreementDate;
          this.subsidyAgreementRateForm.patchValue({ transactiondate: new Date(), startdate: agreementDate });
          this.ratestartdatechange();
        }
      }

      setTimeout(() => { (<any>$('#rate')).modal('show'); } , 300 );
    } else {
      setTimeout(() => {
        (<any>$('#rate')).modal('hide');
      (<any>$('#agreement-validation')).modal('show'); }, 300 );
    }
  }

  addAgreementRate() {
    const agreementRateInput = Object.assign(this.subsidyAgreementRateForm.getRawValue());
    if(this.subsidyAgreementRateForm.invalid){
      this.subsidyAgreementRateForm.markAllAsTouched();
      this._alert.warn('Please fill mandatory fields')
    return;
    }
    if (!agreementRateInput.provider_id && !this.parent1providerid) {
      this._alert.error('Please Select Provider to proceed further !!');
      return;
    }

    const isRateRangeValid = this.existingRateRangeValidation(agreementRateInput.startdate, agreementRateInput.enddate, 0);
    if (!isRateRangeValid) {
      this._alert.warn('Subsidy Rate already exist between this date range');
      return;
    }
    if (this.agreement && this.agreement.adoptionagreementid) {
      this.saveAgreementRate(false);
    } else {
      const agreementRate = Object.assign(this.subsidyAgreementRateForm.getRawValue());
      agreementRate.provider_id =  this.agreement.providerid ? this.agreement.providerid : this.agreement.parent1providerid;
      this.resetRateForm();
      if (!this.agreementRate) {
        this.agreementRate = [];
      }
      this.agreementRate.push(agreementRate);
      this.disableaddrate = true;
      if (!this.isAdoptionCase) {
        this.initialAgreementRate.push(agreementRate);
      }
    }
    (<any>$('#rate')).modal('hide');
  }

  saveAgreementRateReq() {
    this.handlePlanningidFn();
    const agreementRateInput = Object.assign(this.subsidyAgreementRateForm.getRawValue());

    this.handleIfAdoptionCaseFn(agreementRateInput);

    agreementRateInput.adoptionagreementrateid = agreementRateInput.adoptionagreementrateid ? agreementRateInput.adoptionagreementrateid : null;
    agreementRateInput.servicecaseid = this.id ? this.id : null;
    agreementRateInput.servicerequestnumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    agreementRateInput.approvalflag = this.isAdoptionCase ? true : false;
    agreementRateInput.adoptioncaseid = this.id ? this.id : null;
    agreementRateInput.approvalflag = (this.agreement && this.agreement.adoptionagreementid) ? true : false ;
    agreementRateInput.adoptionagreementid = this.agreement.adoptionagreementid ? this.agreement.adoptionagreementid : null;
    agreementRateInput.provider_id = this.agreement.providerid ? this.agreement.providerid : this.agreement.parent1providerid;

    // CDM-33049 Format fix for agreement end date
    if(agreementRateInput.enddate) {
      agreementRateInput.enddate = moment(agreementRateInput.enddate).format('YYYY-MM-DDTHH:mm:ss');
    }

    return agreementRateInput;
  }
  // Assosiated with saveAgreementRateReqfunction
  private handlePlanningidFn() {
    let planningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
    if (!planningid) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }
    if (!planningid) {
      planningid = this.store['adoptionAgreement'] ? this.store['adoptionAgreement'].adoptionplanningid : null;
    }
    if (!planningid || (!this.isSupervisor && this.isAdoptionCase)) {
      planningid = this._session.getItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    }
    return planningid;
  }

  // Assosiated with saveAgreementRateReqfunction
  private handleIfAdoptionCaseFn(agreementRateInput: any) {
    if (this.isAdoptionCase) {
      agreementRateInput.isssaapproved = agreementRateInput.isssaapproved == 1 ? true : this.returnIsssaapprovedFn(agreementRateInput);
      agreementRateInput.isspeacialneeds = agreementRateInput.isspeacialneeds == 1 ? true : this.returnIsspeacialneedsFn(agreementRateInput);
    }
  }

  private returnIsspeacialneedsFn(agreementRateInput: any): any {
    return (agreementRateInput.isspeacialneeds == 2 ? false : null);
  }

  private returnIsssaapprovedFn(agreementRateInput: any): any {
    return (agreementRateInput.isssaapproved == 2 ? false : null);
  }

  getErrorsMessage(ControlName: any, displayName: any){
    if(this.subsidyAgreementRateForm.controls[ControlName].status =='INVALID' ){
    return 'Please enter valid ' + displayName
    }
    }
  saveAgreementRate(isUpdate: any) {
    if(this.subsidyAgreementRateForm.invalid){
      this.subsidyAgreementRateForm.markAllAsTouched();
      this._alert.warn('Please fill mandatory fields')
    return;
    }
    const agreementRateInput = this.saveAgreementRateReq();
    if (!agreementRateInput.provider_id && !this.parent1providerid) {
      this._alert.error('Please Select Provider to proceed further !!');
      return;
    }
    if(isUpdate){
    const isRateRangeValid = this.existingRateRangeValidation(agreementRateInput.startdate, agreementRateInput.enddate, agreementRateInput?.adoptionagreementrateid);
    if (!isRateRangeValid) {
      this._alert.warn('Subsidy Rate already exist between this date range');
      return;
    }
  }
    let url = '';
    let msg = '';
    url = this.isAdoptionCase ? 'adoptioncaserevision/createraterevision' : 'adoptionagreementraterevision/createraterevision';
    msg = isUpdate ? 'updated' : 'saved';

    this._commonHttp.create(agreementRateInput, url).subscribe(res => {
      if (res) {
          this._alert.success('Subsidy rate '+ msg +' successfully');
          this.resetRateForm();
        } else {
          this._alert.error('Unable to process request')
        }
        this.getAgreementListing();
        (<any>$('#rate')).modal('hide');
      },
      err => {
        this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$('#rate')).modal('hide');
      });
  }

  sendRateForReview () {
    let url = '';
    this.sentRateForReview = true;
    url = this.isAdoptionCase ? 'adoptioncaseagreementrate/routerate' : 'adoptionagreementrate/routerate';

    const submitStatus = Object.assign({
      servicerequestnumber: this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER),
      adoptionagreementrateid: this.unapprovedtrateid ? this.unapprovedtrateid : null,
      statustypeid: 15,
      servicecaseid: this.id
    });
    this._commonHttp.create(submitStatus, url).subscribe(
      res => {
        this.approvalStatus = status;
        this._alert.success('Subsidy Rate submitted successfully');
        this.resetRateForm();
        (<any>$('#rate')).modal('hide');
        this.getAgreementListing();
      },
      err => {
        console.error(err)
      }
    );    
    this.isSentForReview = true;
  }

  supervisorDecision(status: any) {
    let url = '';
    if (this.isAdoptionCase) {
      url = (status == 'Approved') ? 'adoptioncaseagreementrate/add' : 'adoptioncaseagreementrate/routerate';
    } else {
      url = (status == 'Approved') ? 'adoptionagreementrate/add' : 'adoptionagreementrate/routerate';
    }
    const statustypeid = (status == 'Approved') ? 16 : 17;

    const submitStatus = Object.assign({
      servicerequestnumber: this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER),
      adoptionagreementrateid: this.unapprovedtrateid,
      statustypeid: statustypeid,
      servicecaseid: this.id
    });
    this._commonHttp.create(submitStatus, url).subscribe(res => {
        this.approvalStatus = status;
        this._alert.success('Subsidy Rate '+ status +' successfully');
        this.getAgreementListing();
      }, err => { 
        this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });
  }

  checkLastFcRate(event: any) {
    if (Number(event.target.value) > 2000) {
      this.rateExceeded = true;
      setTimeout(() => { (<any>$('#rate-exceeded')).modal('show'); }, 300 );
    } else if (Number(event.target.value) > Number(this.baseRate)) {
      this.rateExceeded = false;
      this.subsidyAgreementRateForm.patchValue({ isssaapproved: 1 }); 
    } else {
      this.rateExceeded = false;
      this.subsidyAgreementRateForm.patchValue({ isssaapproved: null });
    }
  }

  ratestartdatechange() {
    const startdate = this.subsidyAgreementRateForm.getRawValue().startdate;

    if(!startdate) {
      this._alert.error('Rate Start date is required');
      return;
    } else if (new Date(startdate).setHours(0,0,0,0) < new Date(this.agreement.startdate).setHours(0,0,0,0)) {
      this._alert.error('Rate Start date cannot be prior to Agreement Start Date');
      return;
    } else if (new Date(startdate).setHours(0,0,0,0) > new Date(this.agreement.enddate).setHours(0,0,0,0)) {
      this._alert.error('Rate Start date cannot be beyond Agreement End Date');
      return;
    } else if (this.agreementRate && this.agreementRate.length && this.agreementRate.length > 1) { //should have atleast 2 else agreement start date is min
      const lastrate = this.agreementRate[this.agreementRate.length - 2]; //edit should look at 2nd index from last since the last row is being edited
      const enddate = new Date(lastrate.enddate);
      enddate.setDate(enddate.getDate() + 1);

      const lastYearenddate = new Date(lastrate.enddate);
      lastYearenddate.setFullYear(lastYearenddate.getFullYear() + 1);
      lastYearenddate.setDate(lastYearenddate.getDate() + 1);

      if (new Date(startdate).setHours(0,0,0,0) < new Date(enddate).setHours(0,0,0,0)) {
        this._alert.error('New Rate should not overlap previous Rate slab');
        return;
      } else if ((new Date(startdate).setHours(0, 0, 0, 0) > new Date(enddate).setHours(0, 0, 0, 0)) && (new Date(startdate).setHours(0, 0, 0, 0) !== new Date(lastYearenddate).setHours(0, 0, 0, 0))) {
        this._alert.error('The new gap rate start date is not in continuation to the last rate end date, the provider is not going to get paid for that interval, are you sure you want to proceed?');
        return;
      }
    }
    this.handleRatestartdatechangeCondFn(startdate);
  }
  // Assosiated with ratestartdatechange method
  private handleRatestartdatechangeCondFn(startdate: any) {
    const agenddate = this.agreement.enddate;

    let enddate = this.subsidyAgreementRateForm.getRawValue().enddate;
    this.returnUpcomingReviewDateFn();

    const agreementRateArray = this.agreement.agreementrate;
    if(agreementRateArray && agreementRateArray[agreementRateArray.length-1].typedescription === 'Rejected') {
      const duplicateRejected = agreementRateArray.filter((item: any, index: any) => {
        return( 
          index !== agreementRateArray.length-1
          && item.startdate === agreementRateArray[agreementRateArray.length-1].startdate
          && item.typedescription === 'Approved'
          );
      });
      if(duplicateRejected.length === 0) {
        startdate = this.agreement.agreementrate[this.agreement.agreementrate.length-1].startdate;
        this.subsidyAgreementRateForm.get('startdate')?.setValue(startdate);
        enddate = this.agreement.agreementrate[this.agreement.agreementrate.length-1].enddate;
        this.subsidyAgreementRateForm.get('enddate')?.setValue(enddate);
      }
    }

    const calcOneYr = new Date(startdate);
    calcOneYr.setFullYear(calcOneYr.getFullYear() + 1);
    calcOneYr.setMonth(calcOneYr.getMonth());
    calcOneYr.setDate(calcOneYr.getDate() - 1);
    this.subsidyAgreementRateForm.patchValue({
      enddate: enddate ? enddate : this.returnEnddateFn(calcOneYr, agenddate),
    });
    this.rateenddateChange();
    this.ratemaxDate = this.returnEnddateFn(calcOneYr, agenddate);
  }
  // Assosiated with ratestartdatechange method
  private returnEnddateFn(calcOneYr: Date, agenddate: any): any {
    return calcOneYr && new Date(calcOneYr) < new Date(agenddate) ? calcOneYr : agenddate;
  }

  private returnUpcomingReviewDateFn() {
    let upcomingReviewDate, upcomingReview, completedReview, completedReviewDate;
    if (this.annualReviewList && this.annualReviewList.length) {
      upcomingReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Review');
      completedReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Approved');
      upcomingReviewDate = upcomingReview && upcomingReview.length ? upcomingReview[0].assessmentdate : null;
      completedReviewDate = completedReview && completedReview.length ? completedReview[completedReview.length - 1].assessmentdate : null;
    }
    this.handleUpcomingReviewDateFn(upcomingReviewDate, completedReviewDate);
  }

  // Assosiated with ratestartdatechange method
  private handleUpcomingReviewDateFn(upcomingReviewDate: any, completedReviewDate: any) {
    if (!upcomingReviewDate && !completedReviewDate) {
      let agstartdate;
      if (this.agreement && this.agreement.startdate) {
        agstartdate = new Date(this.agreement.startdate);
      } else {
        agstartdate = new Date();
      }
      agstartdate.setFullYear(agstartdate.getFullYear() + 1);
      agstartdate.setMonth(agstartdate.getMonth());
      agstartdate.setDate(agstartdate.getDate() - 1);
      upcomingReviewDate = agstartdate;
    }
    return upcomingReviewDate;
  }

  rateenddateChange() {
    const startdate = this.subsidyAgreementRateForm.getRawValue().startdate;
    const enddate = this.subsidyAgreementRateForm.getRawValue().enddate;
    const agenddate = this.agreement.enddate;

    const calcOneYr = new Date(startdate);
    calcOneYr.setFullYear(calcOneYr.getFullYear() + 1);
    calcOneYr.setMonth(calcOneYr.getMonth());
    calcOneYr.setDate(calcOneYr.getDate() - 1);

    if(!enddate) {
      this._alert.error('Rate End date is required');
      return;
    } else if (new Date(enddate).setHours(0,0,0,0) < new Date(startdate).setHours(0,0,0,0)) {
      this._alert.error('Rate End date should be greater than Rate Start Date');
      this.subsidyAgreementRateForm.patchValue({
        enddate: calcOneYr && new Date(calcOneYr) < new Date(agenddate) ? calcOneYr : agenddate,
      });
      return;
    } else if (new Date(enddate).setHours(0,0,0,0) > new Date(this.agreement.enddate).setHours(0,0,0,0)) {
      this._alert.error('Rate End date cannot be beyond Agreement End Date');
      this.subsidyAgreementRateForm.patchValue({
        enddate: calcOneYr && new Date(calcOneYr) < new Date(agenddate) ? calcOneYr : agenddate,
      });
      return;
    } else if (new Date(enddate).setHours(0,0,0,0) > new Date(calcOneYr).setHours(0,0,0,0)) {
      this._alert.error('Rate Renewal period cannot be more than 1 year');
      this.subsidyAgreementRateForm.patchValue({
        enddate: calcOneYr && new Date(calcOneYr) < new Date(agenddate) ? calcOneYr : agenddate,
      });
      return;
    }

    this.handleIfIsAdoptionCaseFn(startdate, enddate);
  }
  // Assosiated with rateenddateChange method
  private handleIfIsAdoptionCaseFn(startdate: any, enddate: any) {
    const upcomingReviewDate = this.handleRateenddateChangeFn();
    if (this.isAdoptionCase) {
      if (new Date(startdate) < new Date(upcomingReviewDate)) {
        this.subsidyAgreementRateForm.patchValue({
          enddate: new Date(enddate)
        });
      }
      else {
        setTimeout(() => {
          (<any>$('#rate')).modal('hide');
          (<any>$('#annual-review-validation')).modal('show');
        }, 500);
      }
    }
    if (!this.approvalStatus || (this.approvalStatus && this.approvalStatus.toLowerCase() === 'incomplete')) {
      this.subsidyAgreementRateForm.controls.paymentamout.enable();
    }
  }
  // Assosiated with rateenddateChange method
  private handleRateenddateChangeFn() {
    let { upcomingReviewDate, completedReviewDate } = this.handleIfAnnualReviewListFn();
    if (!upcomingReviewDate && !completedReviewDate) {
      let agstartdate;
      if (this.agreement && this.agreement.startdate) {
        agstartdate = new Date(this.agreement.startdate);
      } else {
        agstartdate = new Date();
      }
      agstartdate.setFullYear(agstartdate.getFullYear() + 1);
      agstartdate.setMonth(agstartdate.getMonth());
      agstartdate.setDate(agstartdate.getDate() - 1);
      upcomingReviewDate = agstartdate;
    } else if (!upcomingReviewDate && completedReviewDate) {
      let cmstartdate;
      cmstartdate = completedReviewDate;
      cmstartdate = new Date(cmstartdate);
      cmstartdate.setFullYear(cmstartdate.getFullYear() + 1);
      cmstartdate.setMonth(cmstartdate.getMonth());
      cmstartdate.setDate(cmstartdate.getDate() - 1);
      upcomingReviewDate = cmstartdate;
    }
    return upcomingReviewDate;
  }
  // Assosiated with rateenddateChange method
  private handleIfAnnualReviewListFn() {
    let upcomingReviewDate, upcomingReview, completedReview, completedReviewDate;
    if (this.annualReviewList && this.annualReviewList.length) {
      upcomingReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Review');
      completedReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Approved');
      upcomingReviewDate = upcomingReview && upcomingReview.length ? upcomingReview[0].assessmentdate : null;
      completedReviewDate = completedReview && completedReview.length ? completedReview[completedReview.length - 1].assessmentdate : null;
    }
    return { upcomingReviewDate, completedReviewDate };
  }

  private getReportedChild(childActorId?: any) {
    let reqObj = {};
    if (this.serviceCase) {
      reqObj = {
        objectid: this.id,
        objecttypekey: 'servicecase'
      };
    } else {
      reqObj = {
        intakeserviceid: this.id
      };
    }

    this._commonHttp
      .getSingle({
          method: 'get',
          where: reqObj
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
      ).subscribe(res => {
        if (res && res.data) {
          this.handleInvolvedPersonListFn(childActorId, res);
        }
      });
  }
  // Assosiated with getReportedChild method
  private handleInvolvedPersonListFn(childActorId: any, res: any) {
    if (childActorId) {
      const repChild = res.data.filter((child: { personid: any; }) => child.personid === childActorId);
      if (repChild && repChild.length) {
        this.reportedChild = repChild[0];
        this.child = repChild[0];
      }
    } else {
      this.child = res.data.find((item: { rolename: string; }) => item.rolename === 'CHILD');
    }
    if (this.child) {
      const childdob = new Date(this.child.dob);
      const dob = moment(childdob);
      this.maxEndDate = dob.add(21, 'years').toDate();
    }
  }

  private getBreaklink() {
    this._commonHttp
      .getArrayList({
        method: 'get', where: {
          adoptionplanningid: this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid
        }
      }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
      .subscribe(res => {
        if (res && res.length) {
          res.forEach((item) => {
            if(item && item.getadoptionbreakthelink){
              this.returnBreakLineFn(item);
            } 
          });
        }
      });
  }

  private returnBreakLineFn(item: any) {
    return item.getadoptionbreakthelink.map((breaklink: { adoptioncasenumber: any; }) => {
      this.isAdoptionCreated = (breaklink.adoptioncasenumber) ? true : false;
      return breaklink;
    });
  }

  decideSSAApproval() {
    if (this.isSupervisor) {
      this.subsidyAgreementRateForm.controls.isssaapproved.enable();
    } else {
      this.subsidyAgreementRateForm.controls.isssaapproved.disable();
    }
  }

  childPlacementList() {
    this._commonHttp
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 10,
          method: 'get',
          where: { servicecaseid: this._store.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'placement/getplacementbyservicecase?filter'
      ).subscribe(result => {
        if (result && result.data) {
          this.handlePlacementbyservicecaseApiResponseFn(result);
        }
    });
  }

  // Assosiated with childPlacementList method
  private handlePlacementbyservicecaseApiResponseFn(result: any) {
    if (this.serviceCase && this.store['placed_child']) {
      this.placmentDetails = result.data.find((item: { cjamspid: any; }) => item.cjamspid === this.store['placed_child'].cjamspid);
      this.providerDetails = (this.placmentDetails && this.placmentDetails.placements && this.placmentDetails.placements.length && this.placmentDetails.placements[0].providerdetails) ?
        this.placmentDetails.placements[0].providerdetails : null;
    } else {
      if (this.child && this.child.cjamspid) {
        this.placmentDetails = result.data.find((item: { cjamspid: any; }) => item.cjamspid === this.child.cjamspid);
        this.providerDetails = (this.placmentDetails && this.placmentDetails.placements && this.placmentDetails.placements.length && this.placmentDetails.placements[0].providerdetails) ?
          this.placmentDetails.placements[0].providerdetails : null;
      }
    }
  }

  fiscalAudit() {
    this._financeService.getChangeHistory(1, this.adoptionAlternateId, 'adoptionrate');
  }

  gotoAnnualReviewPage(){
    const currentUrl = '/pages/case-worker/' +  this.id + '/'
      + this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER)
      + '/dsds-action/placement/adoption/adoption-subsidy/adoption-annual-reviews';
    this._router.navigate([currentUrl]);
  }

  goToAgreementPage(){
    const currentUrl = '/pages/case-worker/' +  this.id + '/'
    + this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER)
    + '/dsds-action/placement/adoption/adoption-subsidy/agreement';
    this._router.navigate([currentUrl]);
  }

  activateSpeechToText(): void {
    this.recognizing = true;
    this.speechRecogninitionOn = !this.speechRecogninitionOn;
    if (this.speechRecogninitionOn) {
      this._speechRecognitionService.record().subscribe(
        // listener
        value => {
          this.speechData = value;
        },
        // error
        err => {
          this.recognizing = false;
          if (err.error === 'no-speech') {
              this.notification = `No speech has been detected. Please try again.`;
              this._alert.warn(this.notification);
              this.activateSpeechToText();
          } else if (err.error === 'not-allowed') {
              this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
              this._alert.warn(this.notification);
          } else if (err.error === 'not-microphone') {
              this.notification = `Microphone is not available. Plese verify the connection of your microphone and try again.`;
              this._alert.warn(this.notification);
          }
        },
        // completion
        () => {
          this.speechRecogninitionOn = true;
          this.activateSpeechToText();
        }
      );
    } else {
      this.recognizing = false;
      this.deActivateSpeechRecognition();
    }
  }

  deActivateSpeechRecognition() {
      this.speechRecogninitionOn = false;
      this._speechRecognitionService.destroySpeechObject();
  }

  ngOnDestroy() {
    this._speechRecognitionService.destroySpeechObject();
  }
}
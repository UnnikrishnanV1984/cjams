import {map, share, pluck } from 'rxjs/operators';
import { Component, OnInit, ViewChild, Input, OnChanges, Output, EventEmitter, SimpleChanges, Injector } from '@angular/core';
import { CASE_STORE_CONSTANTS } from '../../../pages/case-worker/_entities/caseworker.data.constants';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Hospitalization } from '../../../pages/shared-pages/involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../pages/shared-pages/involved-persons/_entities/involvedPersons.constants';
import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../app/@core/entities/common.entities';
import { Observable ,  forkJoin, Subscription } from 'rxjs';
import { AlertService, DataStoreService, CommonHttpService, AuthService, CommonDropdownsService, SessionStorageService  } from '../../../../app/@core//services';
import { CaseWorkerUrlConfig } from '../../../pages/case-worker/case-worker-url.config';
import { PersonHealthService } from '../../../pages/shared-pages/person-info/person-health/person-health.service';
import { PersonInfoService } from '../../../pages/shared-pages/person-info/person-info.service';
import moment from 'moment';
import { DocumentUploadListSharedComponent } from '../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute, Router } from '@angular/router';
import { ServiceCasePlacementsService } from '../../../pages/case-worker/dsds-action/service-case-placements/service-case-placements.service';
import { HospitalizationService } from '../../services/hospitalization.service';
import { AppUser } from '../../../../app/@core/entities/authDataModel';
import { PlacementConstants } from '../../../pages/case-worker/dsds-action/service-case-placements/constants' //'../constants';
import { ExitPlacementService } from '../../../pages/case-worker/dsds-action/service-case-placements/exit-placements/exit-placement.service';
declare var $: any;

@Component({
    selector: 'hospitalization-cw-shared',
    templateUrl: './hospitalization-cw-shared.component.html',
    styleUrls: ['./hospitalization-cw-shared.component.scss'],
    standalone: false
})
export class HospitalizationCwSharedComponent implements OnInit, OnChanges {
  hosptializationForm!: FormGroup;
  luggageForm!: FormGroup;
  exitPlacementForm!: FormGroup;
  mandatorymessage?: boolean =false;
  commentsRequired = false;
  showExitTypes = false;
  exitTypes : any;
  editMode?: boolean;
  reportMode?: string;
  minDate = new Date();
  maxDate = new Date();
  startMaxDate = new Date();
  startMinDate = new Date();
  exitMinDate:any;
  modalInt?: number;
  hospitalcw: Hospitalization[] = [];
  private userInfo: AppUser;
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  stateDropdownItems$?: Observable<DropdownModel[]>;
  countyDropDownItems$?: Observable<DropdownModel[]>;
  hosptializationType$?: Observable<DropdownModel[]>;
  hosptializationReason$?: Observable<DropdownModel[]>;
  hosptializationTypes?: any = [];
  personId?: string;
  personPlacements: any = [];
  @Input()
  isAddEdit = false;
  @Input()
  hideHospitalizationRecords =false;
  @Input()
  hospitalizationData:any;
  @Input()
  addHospitalizationBtn = true;
  @Input() isShared = false;
  @Output()
  hospitalizationFormEvent = new EventEmitter();
  @Output()
  hospitalizationFormStatusEvent = new EventEmitter();
  uploadedFiles = [];
  uploadNumber = '123434';
  address = { address1: null, address2: null, city: null, state: null, county: null, zipcode: null, disable: false };
  hospital_address = { address1: null, address2: null, city: null, state: null, county: null, zipcode: null, disable: false };
  ERevaluationDisplay: boolean =  false;
  hospitalizationId?: string;
  selectedItem?:any;
  dtDisable = false;
  countyDropDownItems = [{id:'',name:''}]
  reasonForStays$?: Observable<DropdownModel[]>;
  denialsByProviders$?: Observable<DropdownModel[]>;
  dischargeRecommendations$?: Observable<DropdownModel[]>;
  groupHomes$?: Observable<DropdownModel[]>;
  psychiatric$?: Observable<DropdownModel[]>;
  displayReasoForFenialByProvider: boolean = false;
  remainingCount?: number = 280;
  ERexaminationDisplay: boolean = false;
  hosptializationReasons:any =[];
  isServiceCase: any;
  isChildRole = false;
  load:boolean = false;
  paginationInfo: PaginationInfo = new PaginationInfo();
  @ViewChild(DocumentUploadListSharedComponent) documentuploaded?: DocumentUploadListSharedComponent;
  totalRecords?: number;
  checkmandatory: boolean= false;
  requiredForApproval: boolean =false;
  isClosed = false;
  dtformat1 = 'YYYY-MM-DD';
  dtformat2 = 'MM-DD-YYYY';
  @Input()
  loadHospitalForms =false;
  hospitalizationFormSubscriber?: Subscription;
  personDetails: any;
  suggestedAddress: any = [];
  suggestedAddressOg: any = [];
  filteredOptions?: Observable<any[]>;
  statenameDropdownItems$?: Observable<any[]>;
  states: any = [];
  @Input()
  viewMode = false;
  @Input()
  livingArrangementKey = null;
  @Input() startdate: any = null;
  @Input()
  starttime= null;
  exitPlacementEndDateSubscription?: Subscription;
  @Output()
  dischargeDateEvent = new EventEmitter();
  @Output()
  dischargeTimeEvent = new EventEmitter();
  @Output()
  dischargeChangeHandlerEvent = new EventEmitter();
  @Input()
  hospitalizationNewRecord = false;
  hospitalEntry:any;
  reasonForExitRequired :any = false;
  reasonsForExit:any =[];
  reasonforexit : any;
  exitReasonKey: any;
  hospitalizationFormEventSubscriber: any;
  @Output()
  startDateAndTimeEvent = new EventEmitter();
  showERInfo: boolean = false;
  showImInfo: boolean = false;
  exitPage = false;
  livingArrangementKeyChanged = false;
  
    private _formBuilder: FormBuilder;
    private _alertService: AlertService;
    private _dataStoreService: DataStoreService;
    private _commonHttpService: CommonHttpService;
    private _healthService: PersonHealthService;
    private _personInfoService: PersonInfoService;
    public _authService: AuthService;
    private route: ActivatedRoute;
    private _ServiceCasePlacementsService: ServiceCasePlacementsService;
    private _hospitalizationService: HospitalizationService;
    private _router: Router;
    private _session: SessionStorageService;
    private _commonDDService: CommonDropdownsService;
    private exitService: ExitPlacementService;
    retrydoc: any = false;
    hospitalizationListCheck: any;
    hospitalizationid: any;
    constructor( private injector : Injector ) { 
      this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
      this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
      this._ServiceCasePlacementsService =  this.injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
      this._hospitalizationService = this.injector.get<HospitalizationService>(HospitalizationService);
      this._router = this.injector.get<Router>(Router);
      this._session = this.injector.get<SessionStorageService>(SessionStorageService);
      this._commonDDService =  this.injector.get<CommonDropdownsService>(CommonDropdownsService);
      this.exitService =  this.injector.get<ExitPlacementService>(ExitPlacementService);
      
      this.userInfo = this._authService.getCurrentUser();
      this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
      this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.hospitalizationid = params['retryid'];
    });
    }

  ngOnChanges(changes: SimpleChanges) {
    let action = "add";
    //this._ServiceCasePlacementsService.placementDetails
    if(this._ServiceCasePlacementsService?.placementDetails[0]?.['viewMode']){
      if(this.isAddEdit && this.hideHospitalizationRecords && this.hospitalizationData && Object.keys(this.hospitalizationData).length && this.loadHospitalForms && this.hosptializationForm){
        const exitMode = this._ServiceCasePlacementsService?.placementDetails[0]?.['exitMode']
        this.view(this.hospitalizationData , exitMode)
        action = "view";
      }
    }else{
      if(this.isAddEdit && this.hideHospitalizationRecords && this.hospitalizationData && Object.keys(this.hospitalizationData).length && this.loadHospitalForms && this.hosptializationForm){
        this.edit(this.hospitalizationData , 0)
        action ="edit";
      }
    }

    if(changes["livingArrangementKey"] &&  (changes["livingArrangementKey"].currentValue !== changes["livingArrangementKey"].previousValue)) {
      this.livingArrangementKeyChanged = this.livingArrangementKey ? true : false ; 
    } else {
      this.livingArrangementKeyChanged = false;
    }

    if(this.hosptializationForm) {
      this.initializeHospitalizationTypes(action);

    }



  }


  initializeHospitalizationTypes(action = "add"){
    this.showERInfo = false;
    this.showImInfo = false;
    if(this.livingArrangementKey && this.livingArrangementKey === "ERP"){
      this.handleIfERPFn(action);
    }

    if(this.livingArrangementKey && this.livingArrangementKey === "ERM"){
      this.handleIfERMFn(action);
    }

    if(this.livingArrangementKey && this.livingArrangementKey === "IMC") {
      this.handleIfIMCFn(action);
    }

    if(this.livingArrangementKey && this.livingArrangementKey === "PSYH") {
      this.handleIfPSYHFn(action);
    }

    this.inpatientAdmissionChng()
    this.erExaminationChng()
  }
  // Assosiated with initializeHospitalizationTypes method
  private handleIfPSYHFn(action: string) {
    this.hosptializationForm?.get("hospitalization_type")?.patchValue("32789");
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.patchValue(true);
    let hsptlRexmntn =  ((this.hosptializationForm?.get("Hospital_ERexamination")?.value && !this.livingArrangementKeyChanged) ? this.hosptializationForm?.get("Hospital_ERexamination")?.value : false);
    const hospitalERexamination = (action != "add" && (this.hospitalizationData["Hospital_ERexamination"] === this.hosptializationForm?.get("Hospital_ERexamination")?.value)) ? this.hospitalizationData["Hospital_ERexamination"] : hsptlRexmntn;
    this.hosptializationForm?.get("Hospital_ERexamination")?.patchValue(hospitalERexamination);
    if (this.startdate) {
      let hsptlRxmntnStrt = ((this.hosptializationForm?.get("Hospital_examStartDate")?.value && !this.livingArrangementKeyChanged) ? new Date(this.hosptializationForm?.get("Hospital_examStartDate")?.value) : null);
      const hospitalERexaminationStartDate = (action != "add" && this.hospitalizationData["Hospital_examStartDate"]) ? new Date(this.hospitalizationData["Hospital_examStartDate"]) : hsptlRxmntnStrt;
      this.hosptializationForm?.get("Hospital_examStartDate")?.patchValue(hospitalERexaminationStartDate);
      this.hosptializationForm?.patchValue({
        Hospital_InpatientAdmissionDate:new Date(this.startdate)});
    }

    this.handleStartTimeIfIMCorPSYHFn(action);
    this.hosptializationForm?.get("hospitalization_type")?.disable();
    this.hosptializationForm?.get("Hospital_ERexamination")?.enable();
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.disable();
    this.hosptializationForm?.updateValueAndValidity();
    this.typeOfHospitalization();
    this.showImInfo = true;
  }
  // Assosiated with initializeHospitalizationTypes method
  private handleIfIMCFn(action: string) {
    this.hosptializationForm?.get("hospitalization_type")?.patchValue("32790");
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.patchValue(true);
    let hsptlERxmntn =  ((this.hosptializationForm?.get("Hospital_ERexamination")?.value && !this.livingArrangementKeyChanged) ? this.hosptializationForm?.get("Hospital_ERexamination")?.value : false) ;
    const hospitalERexamination = (action != "add" && (this.hospitalizationData["Hospital_ERexamination"] === this.hosptializationForm?.get("Hospital_ERexamination")?.value)) ? this.hospitalizationData["Hospital_ERexamination"] : hsptlERxmntn;
    this.hosptializationForm?.get("Hospital_ERexamination")?.patchValue(hospitalERexamination);
    if (this.startdate) {
      let inithsptExmntnStrt = ((this.hosptializationForm?.get("Hospital_examStartDate")?.value && !this.livingArrangementKeyChanged) ? new Date(this.hosptializationForm?.get("Hospital_examStartDate")?.value) : null);
      const hospitalERexaminationStartDate = (action != "add" && this.hospitalizationData["Hospital_examStartDate"]) ? new Date(this.hospitalizationData["Hospital_examStartDate"]) : inithsptExmntnStrt;
      this.hosptializationForm?.get("Hospital_examStartDate")?.patchValue(hospitalERexaminationStartDate);
      this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.patchValue(new Date(this.startdate ?? ''));
    }

    this.handleStartTimeIfIMCorPSYHFn(action);
    this.hosptializationForm?.get("hospitalization_type")?.disable();
    this.hosptializationForm?.get("Hospital_ERexamination")?.enable();
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.disable();
    this.hosptializationForm?.updateValueAndValidity();
    this.typeOfHospitalization();
    this.showImInfo = true;
  }
  // Assosiated with initializeHospitalizationTypes method
  private handleStartTimeIfIMCorPSYHFn(action: string) {
    if (this.starttime) {
      let hsptlInptntStrtTme =  ((this.hosptializationForm?.get("Hospital_examStartDate_starttime")?.value && !this.livingArrangementKeyChanged) ? this.hosptializationForm?.get("Hospital_examStartDate_starttime")?.value : null);
      const hospitalInpatientAdmissionStartTime = (action != "add" && this.hospitalizationData["Hospital_examStartDate_starttime"]) ? this.formatTime(this.hospitalizationData["Hospital_examStartDate"]) : hsptlInptntStrtTme;
      this.hosptializationForm?.get("Hospital_examStartDate_starttime")?.patchValue(hospitalInpatientAdmissionStartTime);
      this.hosptializationForm?.get("Hospital_InpatientAdmissionDate_starttime")?.patchValue(this.starttime);
    }
  }

  // Assosiated with initializeHospitalizationTypes method
  private handleIfERMFn(action: string) {
    this.hosptializationForm?.get("hospitalization_type")?.patchValue("32790");
    this.hosptializationForm?.get("Hospital_ERexamination")?.patchValue(true);
    let inithsptlInptnAdmn = ((this.hosptializationForm?.get("Hospital_InpatientAdmission")?.value && !this.livingArrangementKeyChanged) ? this.hosptializationForm?.get("Hospital_InpatientAdmission")?.value : false);
    const hospitalInpatientAdmission = (action != "add" && (this.hospitalizationData["Hospital_InpatientAdmission"] === this.hosptializationForm?.get("Hospital_InpatientAdmission")?.value)) ? this.hospitalizationData["Hospital_InpatientAdmission"] : inithsptlInptnAdmn;
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.patchValue(hospitalInpatientAdmission);
    if (this.startdate) {

      this.hosptializationForm?.get("Hospital_examStartDate")?.patchValue(new Date(this.startdate));
      let initHsptlInpntAdmnDate = ((this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.value && !this.livingArrangementKeyChanged) ? new Date(this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.value) : null);
      const hospitalInpatientAdmissionDate = (action != "add" && this.hospitalizationData["Hospital_InpatientAdmissionDate"]) ? new Date(this.hospitalizationData["Hospital_InpatientAdmissionDate"]) : initHsptlInpntAdmnDate;
      this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.patchValue(hospitalInpatientAdmissionDate);
    }
    
    this.handleStartTimeIfERPorERMFn(action);
    this.hosptializationForm?.get("hospitalization_type")?.disable();
    this.hosptializationForm?.get("Hospital_ERexamination")?.disable();
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.enable();
    this.hosptializationForm?.updateValueAndValidity();
    this.typeOfHospitalization();
    this.showERInfo = true;
  }
  // Assosiated with initializeHospitalizationTypes method
  private handleIfERPFn(action: string) {
    this.hosptializationForm?.get("hospitalization_type")?.patchValue("32789");
    this.hosptializationForm?.get("Hospital_ERexamination")?.patchValue(true);
    let hsptlInptAdmn1 = ((this.hosptializationForm?.get("Hospital_InpatientAdmission")?.value && !this.livingArrangementKeyChanged) ? this.hosptializationForm?.get("Hospital_InpatientAdmission")?.value : false);
    const hospitalInpatientAdmission = (action != "add" && (this.hospitalizationData["Hospital_InpatientAdmission"] === this.hosptializationForm?.get("Hospital_InpatientAdmission")?.value)) ? this.hospitalizationData["Hospital_InpatientAdmission"] : hsptlInptAdmn1;
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.patchValue(hospitalInpatientAdmission);
    if (this.startdate) {

      this.hosptializationForm?.get("Hospital_examStartDate")?.patchValue(new Date(this.startdate));
      let hsplInpntAdmnDte1 = ((this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.value && !this.livingArrangementKeyChanged) ? new Date(this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.value) : null);
      const hospitalInpatientAdmissionDate = (action != "add" && this.hospitalizationData["Hospital_InpatientAdmissionDate"]) ? new Date(this.hospitalizationData["Hospital_InpatientAdmissionDate"]) : hsplInpntAdmnDte1;
      this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.patchValue(hospitalInpatientAdmissionDate);
    }

    this.handleStartTimeIfERPorERMFn(action);
    this.hosptializationForm?.get("hospitalization_type")?.disable();
    this.hosptializationForm?.get("Hospital_ERexamination")?.disable();
    this.hosptializationForm?.get("Hospital_InpatientAdmission")?.enable();
    this.hosptializationForm?.updateValueAndValidity();
    this.typeOfHospitalization();
    this.showERInfo = true;
  }
  // Assosiated with initializeHospitalizationTypes method
  private handleStartTimeIfERPorERMFn(action: string) {
    if (this.starttime) {

      this.hosptializationForm?.get("Hospital_examStartDate_starttime")?.patchValue(this.starttime);
      let hsptlInpntAdmnstrtTme = ((this.hosptializationForm?.get("Hospital_InpatientAdmissionDate_starttime")?.value && !this.livingArrangementKeyChanged) ? this.hosptializationForm?.get("Hospital_InpatientAdmissionDate_starttime")?.value : null);
      const hospitalInpatientAdmissionStartTime = (action != "add" && this.hospitalizationData["Hospital_InpatientAdmissionDate_starttime"]) ? this.formatTime(this.hospitalizationData["Hospital_InpatientAdmissionDate"]) : hsptlInpntAdmnstrtTme ;
      this.hosptializationForm?.get("Hospital_InpatientAdmissionDate_starttime")?.patchValue(hospitalInpatientAdmissionStartTime);
    }
  }

  ngOnInit() {
    this.exitPage =  this.route.snapshot.paramMap.get('action') === "exit";

    let action = "add";
    this.statenameDropdownItems$ = this._commonDDService.getPickListByName('state');
    this.statenameDropdownItems$.subscribe(data => {
           this.states = data;
        });
    this.isChildRole = this._dataStoreService.getData('isChildRole');
    this.getHospitalList();
    this.personDetails = this._personInfoService.getPersonInfo();
    this.isClosed = this._authService.iscaseclosed('personhealth');
    this.personId = this._personInfoService.getPersonId();
    this.reportMode = 'add';
    this.loadDropDowns();
    this.initForm();
    this.paginationInfo.pageNumber = 1;
    this.paginationInfo.pageSize = 20;
    this.getHospitalizationList();
    this.gethosptializationTypeDropdown();
    this.getPlacementInfoList();
    if(this.personDetails && this.personDetails.personbasicdetails && this.personDetails.personbasicdetails.dob) {
      this.startMinDate = this.personDetails.personbasicdetails.dob;
    }
    this.route.queryParams.subscribe(params => {
      let status = params['hospitalization'];
      if (status) {
        let hospitalization = JSON.parse(this._dataStoreService.getData('hospitalization-health-summary'));
        this.view(hospitalization);
        action = "view";
      }
    });
    if (this.isAddEdit && this.hideHospitalizationRecords && this.hospitalizationData && Object.keys(this.hospitalizationData).length && this.loadHospitalForms) {

      if (this._ServiceCasePlacementsService?.placementDetails[0]?.['viewMode']) {
        const exitMode = this._ServiceCasePlacementsService?.placementDetails[0]?.['exitMode'];
        this.view(this.hospitalizationData, exitMode);
        action = "view";
      } else {
        this.edit(this.hospitalizationData, 0)
        action = "edit";
      }

    }
    this.handleHospitalizationFn(action);
  }
  // Assosiated with ngOnInit method
  private handleHospitalizationFn(action: string) {
    this.hospitalizationFormSubscriber = this.hosptializationForm?.valueChanges.subscribe((values) => {
      let hospitalData = {};
      if (this.hospital_address.address1) {
        hospitalData = { ...this.hosptializationForm?.getRawValue(), ...this.address, ...this.hospital_address };
      } else {
        hospitalData = { ...this.hosptializationForm?.getRawValue(), ...this.address };
      }

      this.updateHospitalEntry(hospitalData);

    });

    this.exitPlacementEndDateSubscription = this._hospitalizationService.getExitPlacementEndDate().subscribe((value: string | number | Date) => {

      if (value) {
        const dateObj = new Date(value);
        this.hosptializationForm?.get('Hospital_DischargedDate')?.patchValue(dateObj);
        this.hosptializationForm?.get('Hospital_Discharged')?.patchValue(true);
        this.hosptializationForm?.updateValueAndValidity();
        this.dischargeDateEvent.emit(value);

      }

    });


    this.exitPlacementEndDateSubscription = this._hospitalizationService.getExitPlacementEndTime().subscribe((value: any) => {

      if (value) {
        this.hosptializationForm?.get('Hospital_DischargedDate_starttime')?.patchValue(value);
        this.hosptializationForm?.get('Hospital_Discharged')?.patchValue(true);
        this.hosptializationForm?.updateValueAndValidity();
        this.dischargeTimeEvent.emit(value);

      }

    });
    if (this.hosptializationForm) {
      this.initializeHospitalizationTypes(action);

    }
    if (this.isAddEdit && this.loadHospitalForms) {
      this.hospitalizationFormEventSubscriber = this.hosptializationForm?.valueChanges.subscribe(() => {
        this.hospitalizationFormStatusEvent.emit(this.hosptializationForm?.valid);
      });
    }

    if (this.exitPage) {
      this.hosptializationForm?.get('Hospital_Discharged')?.patchValue(true);
      this.hosptializationForm?.updateValueAndValidity();
    }
  }

  ngOnDestroy(): void {
    this.exitPlacementEndDateSubscription?.unsubscribe();
    this._hospitalizationService.setDischargDate(null);
    if(this.hospitalizationFormEventSubscriber) {
      this.hospitalizationFormEventSubscriber.unsubscribe()
    }
   
}

  getSuggestednames() {
      if (this.hosptializationForm?.value.Hospital_name) {
        this.suggestedAddress = this.suggestedAddressOg.filter((c: { name: string; })=>c.name.toLowerCase().startsWith(this.hosptializationForm?.value.Hospital_name.toLowerCase()))
      }
  }
  selectedAddress(item: any) {
    if (item) {
      let state = this.states.find((e: { value_text: any; }) => e.value_text === item.state);
      this.hospital_address = this.returnHospitalAddressDataFn(item, state);
      setTimeout(() => {
        this.address = { address1: item.addresss1 ?item.addresss1: item.address1, address2: item.addresss2 ? item.addresss2: item.address2, city: item.city, state: state ? state.ref_key: item.state, county: item.county, zipcode: item.zipcode, disable: false };
      }, 0);
      this.handleToPatchHospitalDetailsFn(item);

    }
    const data = { ...this.hosptializationForm?.getRawValue(), ...this.hospital_address };
    this.updateHospitalEntry(data)
  }
  // Assosiated with selectedAddress method
  private handleToPatchHospitalDetailsFn(item: any) {
    if (item.phoneno && item.name) {
      this.hosptializationForm?.patchValue({
        Hospital_phone: item.phoneno,
        Hospital_name: item.name
      });
    } else if (item.phoneno) {
      this.hosptializationForm?.patchValue({
        Hospital_phone: item.phoneno,
        Hospital_name: null
      });
    } else if (item.name) {
      this.hosptializationForm?.patchValue({
        Hospital_phone: null,
        Hospital_name: item.name
      });
    }
  }

  // Assosiated with selectedAddress method
  private returnHospitalAddressDataFn(item: any, state: any) {
    return {
      address1: item.addresss1 ? item.addresss1 : item.address1,
      address2: item.addresss2 ? item.addresss2 : item.address2,
      city: item.city,
      state: state ? state.ref_key : item.state,
      county: item.county,
      zipcode: item.zipcode,
      disable: true
    };
  }

  updateAddress(values: any){
    this.selectedAddress(values);
  }

  uploadclosed(event: any){
    if(event){
    this.documentuploaded?.closeupload();
    this.load = true;
    }
  }

  updateLoad() {
    this.load = false;
  }

  initForm() {
    this.hosptializationForm = this._formBuilder.group({
      'hospitalizationid': null,
      'hospitalization_type': ['', Validators.required],
      'hospitalization_reason': ['', Validators.required],
      'hospitalization_reasonForHospitalization_others': [null],
      'hospitalization_discharge_recommendation_others' : [null],
      'actual_placement_after_discharge_others' : [null],
      'Reason_or_diagnosis': [null],
      'Hospital_name': [null],
      'Hospital_phone': [null],
      'hospital_room': [null],
      'hospital_roomphoneno': [null],
      // 'Hospital_address1': '',
      // 'Hospital_address2': '',
      // 'Hospital_city': '',
      // 'Hospital_state': '',
      // 'Hospital_county': '',
      // 'Hospital_zipcode': '',
      'start_Date':[null],
      'end_Date': [null],
      'starttime': [null],
      'endtime': [null],
      'durationdays': [null],
      'medicalnecessitydays': [null],
      'durationhours': [null],
      'durationmins': [null],
      'has_discharge_plan': [null],
      'discharge_plan': [null],
      'Hospital_ERexamination': [null],
      'Hospital_examStartDate': [null],
      'Hospital_examStartDate_starttime': [null],
      'Hospital_ERevaluation': [null],
      'Hospital_evaluatSartDate': [null],
      'Hospital_Overstay': ['', Validators.required],
      'Hospital_OverstayDate': [null],
      'Hospital_ReasonForOvrStay': [null],
      'Hospital_DenialsByProviders': null,
      'Hospital_LengthOfOverstay': [null],
      'Hospital_InpatientAdmission': [null],
      'Hospital_InpatientAdmissionDate': [null],
      'Hospital_InpatientAdmissionDate_starttime': [null],
      'Hospital_city': [null],
      'Hospital_state': [null],
      'Hospital_country': [null],
      'Hospital_zipcode': [null],
      'Hospital_Discharged': [null],
      'Hospital_DischargedDate': [null],
      'Hospital_DischargedDate_starttime': [null],
      'ReasoForFenialByProvider': [null],
      'Hospital_DischargeRecommendation': [null],
      'Actual_Placement_After_Discharge': [null],
      'Hospital_GroupHome': [null],
      'Hospital_DischargeDiagnoses': [null],
      'Hospital_DischargePlan': [null]
    });

    this.luggageForm =  this._formBuilder.group({
      livingarrangementluggage: null,
      laluggagepurchased: null,
      laluggagecomments: null,
      ladisposableortrashbag :null
     });

     this.exitPlacementForm =  this._formBuilder.group({
      exittypekey: null,
      exitreasontypekey: null,
      remarks: null,
      leastrestrictiveplacement: null
     });
     this.exitService.getExitTypes() .subscribe(result => {
      if (result && result.length) {
        this.exitTypes = result;
      }
  
    });

    this.exitService.getreasontype().subscribe(result => {
      this.reasonforexit = result.filter(item=>item.activeflag === 1)
        this.reasonforexit  = this.reasonforexit .filter((item: { ref_key: string; }) => item.ref_key !== 'RNAWAY');
      this.reasonforexit.sort((a: { description: string; }, b: { description: any; }) => a.description.localeCompare(b.description));
     }) ;
  }

 
  

  onExitTypeChange(status: any) {
    const exitTypeKey = this.exitPlacementForm?.getRawValue().exittypekey;
    if (status) {
      this.exitPlacementForm?.patchValue({
        exitreasontypekey: null
      });
    }
    if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
      this.reasonForExitRequired = true;
      this.exitPlacementForm?.patchValue({
        exitreasontypekey: this.getexitreasontypekey(status)
      })
      this.exitPlacementForm?.get('exitreasontypekey')?.enable();
      if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT) {
        this.exitService.getReasonForExit(exitTypeKey).subscribe(result => {
          if (result && result.length) {
            this.reasonsForExit = result;
          }
        });
      }
      else if (exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
        this.reasonsForExit = this.reasonforexit;
      }
    } else {
      this.reasonForExitRequired = false;
      this.exitPlacementForm?.get('exitreasontypekey')?.disable();
      this.reasonsForExit = [];
    }
    if (PlacementConstants.EXIT_TYPES.OTHER === exitTypeKey) {
     this.commentsRequired = true;
    } else {
      this.commentsRequired = false;
    }
  }



  getexitreasontypekey(status: any){
    return (this.exitReasonKey && !status) ? this.exitReasonKey : null;
  }
  startDateChange(hosptializationForm: FormGroup) {
    this.calculateContactDuration(hosptializationForm);
    this.calculateMedicalNecessity(hosptializationForm);
    if(hosptializationForm['controls'].Hospital_examStartDate.value) {
      this.startMinDate = hosptializationForm['controls'].Hospital_examStartDate.value;
      const minEndDate = moment(this.startMinDate).format(this.dtformat1); 
      this.exitMinDate = moment(minEndDate).toDate(); 
    }
  }



 

  handleErExamintaionChange(controlName: string | (string | number)[], isStartDate: any) {
    if (this.hosptializationForm?.get(controlName)?.value && (this.livingArrangementKey === "ERP" || this.livingArrangementKey === "ERM") && this.isAddEdit) {
      if (isStartDate) {
        this.startDateAndTimeEvent.emit({
          date: this.hosptializationForm?.get(controlName)?.value
        })
      } else {
        this.startDateAndTimeEvent.emit({
          time: this.hosptializationForm?.get(controlName)?.value
        })
      }
    }
      this.startMinDate = new Date(this.hosptializationForm['controls'].Hospital_examStartDate.value);
      const minEndDate = moment(this.startMinDate).format(this.dtformat1); 
      this.exitMinDate = moment(minEndDate).toDate();
  }

  handleInPatientExamintaionChange(controlName: string | (string | number)[], isStartDate: any) {
    if (this.hosptializationForm?.get(controlName)?.value && (this.livingArrangementKey === "IMC" || this.livingArrangementKey === "PSYH") && this.isAddEdit) {

      if (isStartDate) {
        this.startDateAndTimeEvent.emit({
          date: this.hosptializationForm?.get(controlName)?.value
        })
      } else {
        this.startDateAndTimeEvent.emit({
          time: this.hosptializationForm?.get(controlName)?.value
        })
      }
    }
  }

  handleDischargeStartTimeChange(hosptializationForm: any){
    const startTime = hosptializationForm.get('Hospital_examStartDate_starttime')?.value;
    const dischargeTime = hosptializationForm.get('Hospital_DischargedDate_starttime')?.value;

    const startDate =  moment(hosptializationForm.get('Hospital_examStartDate')?.value).format(this.dtformat1);
    const dischargeDate = moment(hosptializationForm.get('Hospital_DischargedDate')?.value).format(this.dtformat1)

    this._hospitalizationService.setDischargTime(hosptializationForm.get('Hospital_DischargedDate_starttime')?.value);
    this.dischargeTimeEvent.emit(hosptializationForm.get('Hospital_DischargedDate_starttime')?.value);
    if(startTime && dischargeTime && startDate && dischargeDate && startDate == dischargeDate   && startTime >= dischargeTime ) {
      this._alertService.error('Exit date & time should be greater than the start date & time');
      this.hosptializationForm?.patchValue({Hospital_DischargedDate_starttime: null});
    }
  }

  denialsByProviderChng(value:any){
    if (value['value'].includes('4521')) {
      this.displayReasoForFenialByProvider = true;
    } else {
      this.displayReasoForFenialByProvider = false;
    }
  }

  typeOfHospitalization() {
    const value = this.hosptializationForm?.controls.hospitalization_type.value
    if (value === '32789') {
      this.ERevaluationDisplay = true;
      this.getPsychiatricDropdown();
    } else {
      this.ERevaluationDisplay = false;
    }
    if (value === '32790') {
      this.getMedicalDropdown();
    }
  }

  

  endDateChange(hosptializationForm:any,event:any) {

    this._hospitalizationService.setDischargDate(hosptializationForm.get('Hospital_DischargedDate')?.value);
    this.dischargeDateEvent.emit(hosptializationForm.get('Hospital_DischargedDate')?.value);
    this.calculateContactDuration(hosptializationForm);
    this.calculateMedicalNecessity(hosptializationForm);
    if(!hosptializationForm.getRawValue().Hospital_DischargedDate && this.hosptializationForm?.controls.Hospital_Discharged.value === true) {
      this._alertService.error('Please fill start date');
      hosptializationForm.patchValue({ end_Date : null});
    } 
  }

  // private resetForm() {
    resetForm() {
    this.dtDisable = false;
    this.address = {
      address1: null, address2: null,
      city: null, state: null,
      zipcode: null, county: null,
      disable: false
    };
    this.startMaxDate = new Date();
    this.hosptializationForm?.reset();
    this.editMode = false;
    this.isAddEdit = false;
    this.reportMode = 'add';
    this.modalInt = -1;
    this.hosptializationForm?.enable();
    this.uploadedFiles = [];
    this.selectedItem = null;
  }

 view(modal:any, exitMode?:any) {
    this.address = {
      address1: modal.Hospital_address1,
      address2: modal.Hospital_address2,
      city: modal.Hospital_city,
      state: modal.Hospital_state,
      zipcode: modal.Hospital_zipcode,
      county: modal.county,
      disable: true
    };
    this.hospital_address = {
      address1: modal.hospital_addressline1,
      address2: modal.hospital_addressline2,
      city: modal.hospital_cityname,
      state: modal.hospital_statename,
      county: modal.hospital_country,
      zipcode: modal.hospital_zipcode1,
      disable: true
    };
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.patchForm(modal);
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.editMode = false;
    this.hosptializationForm?.controls['start_Date'].disable();
    this.hosptializationForm?.controls['end_Date'].disable();
    this.dtDisable = true;
    this.hosptializationForm?.disable();
    this.hosptializationForm?.controls['start_Date'].disable();
    if(exitMode){
      this.hosptializationForm?.controls['Hospital_Discharged'].enable();
      this.hosptializationForm?.controls['Hospital_DischargedDate'].enable();
      this.hosptializationForm?.controls['Hospital_DischargedDate_starttime'].enable();
      this.hosptializationForm?.controls['Hospital_DischargeRecommendation'].enable();
      this.hosptializationForm?.controls['hospitalization_discharge_recommendation_others'].enable();
      this.hosptializationForm?.controls['Actual_Placement_After_Discharge'].enable();
      this.hosptializationForm?.controls['actual_placement_after_discharge_others'].enable();
      this.hosptializationForm?.controls['Hospital_DischargeDiagnoses'].enable();
      this.hosptializationForm?.controls['Hospital_DischargePlan'].enable();
    }
    if(this.hosptializationForm?.controls.Hospital_Discharged.value === false || this.hosptializationForm?.controls.Hospital_Discharged.value === null){
      this.calculateWithCurrentDate();
      this.disChargedChng();
    }

    if(modal['Hospital_ERevaluation'] == null) {
      this.ERevaluationDisplay  = false;
    } else {
      this.ERevaluationDisplay = true;
    }

  }

   edit(modal:any, i?:any) {
    this.address = {
      address1: modal.Hospital_address1,
      address2: modal.Hospital_address2,
      city: modal.Hospital_city,
      state: modal.Hospital_state,
      zipcode: modal.Hospital_zipcode,
      county: modal.county,
      disable: false
    };
    this.hospital_address = {
      address1: modal.hospital_addressline1,
      address2: modal.hospital_addressline2,
      city: modal.hospital_cityname,
      state: modal.hospital_statename,
      county: modal.hospital_country,
      zipcode: modal.hospital_zipcode1,
      disable: false
    };
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.hospitalizationId = modal.hospitalizationid;
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.startMaxDate = modal.end_Date;
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal)
    const hospitalData = { ...this.hosptializationForm?.getRawValue(), ...this.address, ...this.hospital_address };
    this.updateHospitalEntry(hospitalData);
    this.hosptializationForm?.enable();
    this.hosptializationForm?.controls.Hospital_DenialsByProviders.setValue(JSON.parse(modal.Hospital_DenialsByProviders));
    if(this.hosptializationForm?.controls.Hospital_Discharged.value === false || this.hosptializationForm?.controls.Hospital_Discharged.value === null){
      this.calculateWithCurrentDate();
      this.disChargedChng();
    }

    if (this.hosptializationForm?.get("Hospital_Discharged")?.value && this.livingArrangementKey) {
      this.hosptializationForm?.get("Hospital_Discharged")?.disable();
      this.hosptializationForm?.get("Hospital_DischargedDate_starttime")?.disable();
      this.hosptializationForm?.get("Hospital_DischargedDate")?.disable();
    }
  }

  calculateWithCurrentDate(){
    if(this.hosptializationForm){
    this.calculateContactDuration(this.hosptializationForm);
    this.calculateMedicalNecessity(this.hosptializationForm);
    }
  }

  cancel() {
    this.resetForm();
  }

  private patchForm(modal: any) {
    this.dtDisable = false;
    modal.Hospital_examStartDate_starttime = modal.Hospital_examStartDate ? this.formatTime(modal.Hospital_examStartDate) : null;
    modal.Hospital_InpatientAdmissionDate_starttime = modal.Hospital_InpatientAdmissionDate ? this.formatTime(modal.Hospital_InpatientAdmissionDate) : null;
    modal.Hospital_DischargedDate_starttime = modal.Hospital_DischargedDate ? this.formatTime(modal.Hospital_DischargedDate) : null;
    this.hosptializationForm?.patchValue(modal);
    this.hosptializationForm?.updateValueAndValidity();
    this.typeOfHospitalization();
  }
  formatTime(time: any) {
    time =  moment(new Date(time)).format('HH:mm');
    return time;
  }


  formatDate(date: any) {
    date =  moment(new Date(date)).format('YYYY-MM-DD hh:mm A');
    return date;
  }

  concateDateTime(date: string,time: string){
    date =  date.split(" ")[0] + " " + time + ":00";
    return date;
   }

  overnightPopShow(action: string) {
  
    if (this.endDatechangevalidation()) {
      return;
    }

    let { startDate , startDateI, dischargeDate } = this.returnDatesDataFn();

   if (!startDate && this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.value) {
      startDate = startDateI
    }


    let startDate1 =  moment(startDate)?.valueOf();
    let dischargeDate1 = this.hosptializationForm?.get("Hospital_DischargedDate")?.value
      ? moment(dischargeDate)?.valueOf()
      : null;
    
    if (dischargeDate1 && startDate1 && dischargeDate1 <= startDate1) {
      this._alertService.error("Discharge / Exit date & time should be greater than the start date & time");
      return; 
    }


    if (!this.hosptializationForm['controls'].Hospital_ERexamination.value &&
    !this.hosptializationForm['controls'].Hospital_InpatientAdmission.value
    ) {
      action === 'add' ? this.add() : this.update();
      return;
    }

    if(this.isChildRole && this.isServiceCase) {
    $('#overnight-pop').modal('show');
    } else {
      action === 'add' ? this.add() : this.update();
    }
  }
  // Assosiated with overnightPopShow method
  private returnDatesDataFn() {
    let startDate = this.hosptializationForm?.get("Hospital_examStartDate")?.value ? this.concateDateTime(moment(new Date(this.hosptializationForm?.get("Hospital_examStartDate")?.value)).format('YYYY-MM-DD hh:mm A'), this.hosptializationForm?.get("Hospital_examStartDate_starttime")?.value) : '';
    let startDateI = this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.value ? this.concateDateTime(moment(new Date(this.hosptializationForm?.get("Hospital_InpatientAdmissionDate")?.value)).format('YYYY-MM-DD hh:mm A'), this.hosptializationForm?.get("Hospital_InpatientAdmissionDate_starttime")?.value) : '';
    let dischargeDate = this.hosptializationForm?.get("Hospital_DischargedDate")?.value ? this.concateDateTime(moment(new Date(this.hosptializationForm?.get("Hospital_DischargedDate")?.value)).format('YYYY-MM-DD hh:mm A'), this.hosptializationForm?.get("Hospital_DischargedDate_starttime")?.value) : '';
    return { startDate, startDateI, dischargeDate };
  }

  overnightPopCancel() {
    $('#overnight-pop').hide('show');
  }

  add(isApproval?:any) {
    this.checkmandatory =true;
    this.requiredForApproval = true;
    if(this.checkAndReturnIfMandatoryFieldsFn()){
      this.hosptializationForm?.markAllAsTouched();
      this._alertService.error('Please fill required fields');
      return;
    }
    let uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;
    let data: any = { ...this.hosptializationForm?.getRawValue(), ...this.address, ...uploadInfo, ...this.hospital_address };
    data.Hospital_address1 = this.address.address1;
    data.Hospital_address2 = this.address.address2;
    data.Hospital_city = this.address.city;
    data.Hospital_state = this.address.state;
    data.Hospital_zipcode = this.address.zipcode;
    data.county = this.address.county;
    if (data.hospitalization_type !== '32789' && data.hospitalization_type !== '32790') {
      this._alertService.warn('Please Select Valid Type of Hospitalization ');
      return ;
    }

    
    data.hospital_addressline1 = this.hospital_address.address1;
    data.hospital_addressline2 = this.hospital_address.address2;
    data.hospital_cityname = this.hospital_address.city;
    data.hospital_statename = this.hospital_address.state;
    data.hospital_country = this.hospital_address.county;
    data.hospital_zipcode1 = this.hospital_address.zipcode;

    if (data.start_Date) {
      data.start_Date = moment(new Date(data.start_Date)).format(this.dtformat1);
    }
    if (data.end_Date) {
      data.end_Date = moment(new Date(data.end_Date)).format(this.dtformat1);
    }

    if (data.uploadpath) {
      data.uploadpath.forEach((document: { percentage: any; }) => {
        if (document.percentage) {
          delete document.percentage;
        }
      });
    }
    let isNew = 1;
    if (data.hospitalizationid) {
      isNew = 0;
    }
    data = this.returnHospitalexamDateDataFn(data);
    this._healthService.saveHealth({ 'personHospitalizationHistory': [data] }, isNew).subscribe(response => {
      this._alertService.success('Hospitalization Info Saved Successfully');
      setTimeout(() => {
        this._alertService.success('Please enter the current hospitalization in the Youth’s Living Arrangement if in Out of Home Care.');
      }, 1000);
      this.paginationInfo.pageNumber = 1;
      this.getHospitalizationList(((isApproval && response.length > 0) ? response[0].personhealthaddupdate : null));
    });
    this.resetForm();
  }
  // Assosiated with add method
  private returnHospitalexamDateDataFn(data: any) {
    if (data.Hospital_examStartDate) {
      data.Hospital_examStartDate = data.Hospital_examStartDate.includes('T') ? data.Hospital_examStartDate.split('T')[0] : data.Hospital_examStartDate;
      data.Hospital_examStartDate = (data.Hospital_examStartDate + 'T' + data.Hospital_examStartDate_starttime);
    }
    if (data.Hospital_InpatientAdmissionDate) {
      data.Hospital_InpatientAdmissionDate = data.Hospital_InpatientAdmissionDate.includes('T') ? data.Hospital_InpatientAdmissionDate.split('T')[0] : data.Hospital_InpatientAdmissionDate;
      data.Hospital_InpatientAdmissionDate = (data.Hospital_InpatientAdmissionDate + 'T' + data.Hospital_InpatientAdmissionDate_starttime);
    }
    if (data.Hospital_DischargedDate) {
      data.Hospital_DischargedDate = data.Hospital_DischargedDate.includes('T') ? data.Hospital_DischargedDate.split('T')[0] : data.Hospital_DischargedDate;
      data.Hospital_DischargedDate = (data.Hospital_DischargedDate + 'T' + data.Hospital_DischargedDate_starttime);
    }
    return data;
  }
  // Assosiated with add method
  private checkAndReturnIfMandatoryFieldsFn() {
    return (this.hosptializationForm?.invalid || ((this.hosptializationForm['controls'].Hospital_ERexamination.value === true && !this.hosptializationForm['controls'].Hospital_examStartDate_starttime.value) || (this.hosptializationForm['controls'].Hospital_InpatientAdmission.value && !this.hosptializationForm['controls'].Hospital_InpatientAdmissionDate_starttime.value) || (this.hosptializationForm['controls'].Hospital_Discharged.value === true && !this.hosptializationForm['controls'].Hospital_DischargedDate_starttime.value)));
  }

  private update() {
    if(this.hosptializationForm?.invalid){
      this.hosptializationForm?.markAllAsTouched();
      this._alertService.error('Please fill required fields');
      return;
    }
    const uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;
    const data = { ...this.hosptializationForm?.getRawValue(), ...this.address, ...uploadInfo, ...this.hospital_address };
    data.Hospital_address1 = this.address.address1;
    data.Hospital_address2 = this.address.address2;
    data.Hospital_city = this.address.city;
    data.Hospital_state = this.address.state;
    data.Hospital_zipcode = this.address.zipcode;
    data.hospitalizationid = this.hospitalizationId;
    if (data.hospitalization_type !== '32789' && data.hospitalization_type !== '32790') {
      this._alertService.warn('Please Select Valid Type of Hospitalization ');
      return ;
    }


    data.hospital_addressline1 = this.hospital_address.address1;
    data.hospital_addressline2 = this.hospital_address.address2;
    data.hospital_cityname = this.hospital_address.city;
    data.hospital_statename = this.hospital_address.state;
    data.hospital_country = this.hospital_address.county;
    data.hospital_zipcode1 = this.hospital_address.zipcode;




    if (data.start_Date) {
      data.start_Date = moment(new Date(data.start_Date)).format(this.dtformat1);
    }
    if (data.end_Date) {
      data.end_Date = moment(new Date(data.end_Date)).format(this.dtformat1);
    }
    data.Hospital_examStartDate = data.Hospital_examStartDate ? (data.Hospital_examStartDate.split("T")[0] + 'T' + data.Hospital_examStartDate_starttime) : data.Hospital_examStartDate;
    data.Hospital_InpatientAdmissionDate = data.Hospital_InpatientAdmissionDate ? (data.Hospital_InpatientAdmissionDate.split("T")[0] + 'T' + data.Hospital_InpatientAdmissionDate_starttime) : data.Hospital_InpatientAdmissionDate;
    data.Hospital_DischargedDate = data.Hospital_DischargedDate ? (data.Hospital_DischargedDate.split("T")[0] + 'T' + data.Hospital_DischargedDate_starttime) : data.Hospital_DischargedDate;
    this._healthService.saveHealth({ 'personHospitalizationHistory': [data] }, 0).subscribe(response => {
      this._alertService.success('Hospitalization Info Updated Successfully');
      this.paginationInfo.pageNumber = 1;
      this.getHospitalizationList();
    });
    this.resetForm();
  }

  initializeHospitalization() {
    this.resetForm();
  }

  private loadDropDowns() {
    var removeList = ['10689','10690','10691','10692','10693','10694','10695','10696','10688'];
    if(this.hospitalcw && this.hospitalcw.length) {
      this.hospitalcw.forEach((item) =>{
        if(item.hospitalization_reason) {
          removeList.push(item.hospitalization_reason);
        }
      })
    }
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '230', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '310', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '450', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '452', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '453', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '454', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '280', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      )
    ]).pipe(map((result: any) => {
      const reasonFrHosResp = result[1].filter((item: { picklist_value_cd: string; }) => removeList.includes(item.picklist_value_cd));
      return {
        hosptializationTypeValues: result[0].map(
          (res1: any) =>
            new DropdownModel({
              text: res1.description_tx,
              value: res1.picklist_value_cd
            })
        ),
        hosptializationReasonValues: reasonFrHosResp.map(
          (res2: any) =>
            new DropdownModel({
              text: res2.description_tx,
              value: res2.picklist_value_cd
            })
        ),
        reasonForStayValue: result[2].map(
          (res3: any) =>
            new DropdownModel({
              text: res3.description_tx,
              value: res3.picklist_value_cd
            })
        ),
        denialsByProvidersValue: result[3].map(
          (ress3: any) =>
            new DropdownModel({
              value: ress3.picklist_value_cd,
              text: ress3.description_tx
            })
        ),
        states: result[4].map(
          (res4: any) =>
            new DropdownModel({
              text: res4.statename,
              value: res4.stateabbr
            })
        ),
        dischargeRecommendationsValue: result[5].map(
          (res5: any) =>
            new DropdownModel({
              text: res5.description_tx,
              value: res5.picklist_value_cd
            })
        ),
        groupHomesValue: result[6].map(
          (res6: any) =>
            new DropdownModel({
              text: res6.description_tx,
              value: res6.picklist_value_cd
            })
        ),
        psychiatricValue: result[7].map(
          (res7: any) =>
            new DropdownModel({
              text: res7.description_tx,
              value: res7.picklist_value_cd
            })
        )
        
      };
    }),
      share(),);
    this.hosptializationReason$ = source.pipe(pluck('hosptializationReasonValues'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.hosptializationType$ = source.pipe(pluck('hosptializationTypeValues'));
    this.reasonForStays$ = source.pipe(pluck('reasonForStayValue'));
    this.denialsByProviders$ = source.pipe(pluck('denialsByProvidersValue'));
    this.dischargeRecommendations$ = source.pipe(pluck('dischargeRecommendationsValue'));
    this.groupHomes$ = source.pipe(pluck('groupHomesValue'));
    this.psychiatric$ = source.pipe(pluck('psychiatricValue'));
  }


  gethosptializationTypeDropdown(){
    this.hosptializationTypes = [];
    this._commonHttpService
    .getArrayList(
      {
        method: 'get',
        where: { 'active_sw': 'Y', 'picklist_type_id': '230', 'delete_sw': 'N' }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    )
    .subscribe((res) => {
      // Only to allow Psychiatric and Medical dropdown values
      let removeList = ['32789','32790'];
      if(this.hospitalcw && this.hospitalcw.length) {
        this.hospitalcw.forEach((item) =>{
          if(item.hospitalization_type) {
            removeList.push(item.hospitalization_type);
          }
        })
      }
      res.sort((a,b) => (a.description_tx > b.description_tx) ? 1 : this.returnSortedDataFn(b, a))
      this.hosptializationTypes = res.filter(item => removeList.includes(item.picklist_value_cd));
    });
  }
  private returnSortedDataFn(b: any, a: any): number {
    return (b.description_tx > a.description_tx) ? -1 : 0;
  }

  getMedicalDropdown(){
    this.hosptializationReasons = [];
    this._commonHttpService
    .getArrayList(
      {
        method: 'get',
        where: { 'active_sw': 'Y', 'picklist_type_id': '310', 'delete_sw': 'N' }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    )
    .subscribe((res) => {
      // Only to allow Psychiatric and Medical dropdown values
      var removeList = ['1261', '1260', '1258', '1257', '1256', '1255', '1254', '1253', '1252', '10688', '1203', '1204', '1205', '1206', '1207', '1208', '1209'
        , '1210', '1211', '1212', '1213', '1214', '1215', '1216', '1217', '1218', '1219', '1220', '1221', '1222', '1223', '1224', '1225', '1226', '1227', '1228', '1229', '1230', '1231', '1232', '1233', '1234', '1217', '1218', '1219', '1220'
        , '1221', '1222', '1223', '1224', '1225', '1226', '1227', '1228', '1229', '1230', '1231', '1232', '1233', '1234', '1235', '1236', '1237', '1238'
        , '1239', '1240', '1241', '1242', '1243', '1244', '1245', '1246', '1247', '1248', '1249', '1250', '1251'];
      if(this.hospitalcw && this.hospitalcw.length) {
        this.hospitalcw.forEach((item1) =>{
          if(item1.hospitalization_reason) {
            removeList.push(item1.hospitalization_reason);
          }
        })
      }

      this.hosptializationReasons =  this.hosptializationForm?.controls.hospitalization_type.value === "32790" ? res.filter(item => removeList.includes(item.picklist_value_cd)) : this.hosptializationReasons;
    });
  }

  getPsychiatricDropdown(){
    this.hosptializationReasons = [];
    this._commonHttpService
    .getArrayList(
      {
        method: 'get',
        where: { 'active_sw': 'Y', 'picklist_type_id': '280', 'delete_sw': 'N' }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    )
    .subscribe((res) => {
      this.hosptializationReasons = res//.filter(item => removeList.includes(item.picklist_value_cd));
    });
  }

  
  addHospitalization() {
    this.isAddEdit = true;
    this.hospitalizationNewRecord = true;
    this.hosptializationForm?.reset();
  }

  calculateContactDuration(hosptializationForm: FormGroup){
    this.calculateOverstayDuration(hosptializationForm)
    const today_ = new Date();
    const today = today_.toISOString();
    const startdate = hosptializationForm.getRawValue().Hospital_InpatientAdmissionDate;
    const enddate = hosptializationForm.getRawValue().Hospital_DischargedDate ? hosptializationForm.getRawValue().Hospital_DischargedDate : today;

    if(startdate && enddate) {

      const start_date = moment(startdate);
      const end_date =  moment(enddate);
      const duration = moment.duration(end_date.diff(start_date)).asDays() + 1;
  
      if(duration) {
        hosptializationForm.patchValue({
          durationdays :  Math.floor(duration)
        }); 
      }
    } 
 }

 calculateMedicalNecessity(hosptializationForm: FormGroup){
  var today = new Date();
  const inpatientAdmissionDate = hosptializationForm.getRawValue().Hospital_InpatientAdmissionDate;
  let clcteMdclMnDt = (hosptializationForm.getRawValue().Hospital_DischargedDate ? hosptializationForm.getRawValue().Hospital_DischargedDate : today);
  const mainDate = hosptializationForm.getRawValue().Hospital_OverstayDate ? hosptializationForm.getRawValue().Hospital_OverstayDate : clcteMdclMnDt ;
  
   if (inpatientAdmissionDate && mainDate) {
     const start_date = moment(inpatientAdmissionDate);
     const end_date = moment(mainDate);
     const duration = moment.duration(end_date.diff(start_date)).asDays() + 1;

     if (duration) {
       hosptializationForm.patchValue({
         medicalnecessitydays: Math.floor(duration)
       });
     }
   }  
}

 calculateOverstayDuration(hosptializationForm: { getRawValue: () => { (): any; new(): any; Hospital_OverstayDate: any; Hospital_DischargedDate: any; }; patchValue: (arg0: { Hospital_LengthOfOverstay: number; }) => void; }){
  var today = new Date();
  const overstay_date = hosptializationForm.getRawValue().Hospital_OverstayDate;
  const discharged_date = hosptializationForm.getRawValue().Hospital_DischargedDate ? hosptializationForm.getRawValue().Hospital_DischargedDate : today;

  if(overstay_date && discharged_date) {

    const start_date = moment(moment(overstay_date), this.dtformat2);
    const end_date = moment(moment(discharged_date), this.dtformat2);
    const duration = moment.duration(end_date.diff(start_date)).asDays() + 1;

    if(duration) {
      hosptializationForm.patchValue({
        Hospital_LengthOfOverstay : Math.floor(duration) 
      }); 
    }
  } 
}

  calculateContactDurationView(hospital: Hospitalization){
    const startdate = hospital.start_Date;
    const enddate = hospital.end_Date;
    const starttime = hospital?.starttime;
    const endtime = hospital?.endtime;

    const _startTime = moment(moment(startdate).format(this.dtformat2) + ' ' + starttime + ':00');
    const _endTime = moment(moment((enddate ? enddate : startdate)).format(this.dtformat2) + ' ' + endtime + ':00');

    const computedDuration = moment.duration(_endTime.diff(_startTime));

    const startDatetime =  _startTime.toDate();
    const endDatetime = _endTime.toDate();

    const Difference_In_Time = endDatetime.getTime() - startDatetime.getTime();

    let Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);

    Difference_In_Days = Math.floor(Difference_In_Days); // NOSONAR
    
    if ((computedDuration as any)._data) { 
      const data =(computedDuration as any)._data
      hospital['durationhours']= data.hours;
      hospital['durationmins'] = data.minutes;
    }
    return hospital;
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.getHospitalizationList();
}
  
  getHospitalizationList(id?: any) {
    this._commonHttpService.getPagedArrayList({
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
      method: 'get',
      where: { personid: this.personId }
    }, 'personhospitalization/list?filter').subscribe(res => {
      this.hospitalcw = res ? res.data : [];
       this.hospitalizationListCheck = (this.hospitalcw as any[]).find(item => item.hospitalizationid === this.hospitalizationid);
          if (this.hospitalizationListCheck && this.hospitalizationid) {
              this.edit(this.hospitalizationListCheck);
              this.hospitalizationid = null;
          }
      this.totalRecords = res.count;
      this.hospitalcw = this.hospitalcw.map((hospital:Hospitalization) => {
        hospital = this.calculateContactDurationView(hospital);
        if(hospital['uploadpath'] === null ){
          hospital['uploadpath'] = []
        }
        return hospital;
      });
      if (id) {
        this.openLuggageForm(this.hospitalcw.find((e: any) => e.hospitalizationid === id));
      }
      this.gethosptializationTypeDropdown();
    });
  }

  getHospitalList() {
    this._commonHttpService.getPagedArrayList({
      page: this.paginationInfo.pageNumber,
      limit: 100000,
      method: 'get'
    }, 'hospitaldetail/list?filter').subscribe((res: any) => {
      if (res) {
        res.sort((a:any,b:any) => (a.name > b?.name) ? 1 : this.returnRespSortFn(b, a))
        this.suggestedAddressOg = res ? JSON.parse(JSON.stringify(res)) : [];
        this.suggestedAddress = res ? res : [];
      }
    });
  }

  private returnRespSortFn(b: any, a: any) {
    return (b.name > a.name) ? -1 : 0;
  }

  deleteConfirm(item: any) {
    $('#delete-popup').modal('show');
    this.selectedItem = item;
  }

  getLivingarrangementtypekey(hospital:any){
    const typeOfHospitalization = hospital?.['hospitalization_type'];
    const hospitalERexamination = hospital?.['Hospital_ERexamination'];
    const hospitalInpatientAdmission = hospital?.['Hospital_InpatientAdmission'];
    
    if (typeOfHospitalization === '32790' && hospitalERexamination) {
      return 'ERM';
    } else if (typeOfHospitalization === '32790' && !hospitalERexamination && hospitalInpatientAdmission) {
      return 'IMC';
    } else if (typeOfHospitalization === '32789' && hospitalERexamination) {
      return 'ERP';
    } else if (typeOfHospitalization === '32789' && !hospitalERexamination && hospitalInpatientAdmission) {
      return 'PSYH';
    }
  
    return 'ERM';
  }




  sendForApproval(hospital: any){
    let sndfrAprvlStrtDt = hospital['Hospital_InpatientAdmissionDate'] ? this.formatDate(hospital['Hospital_InpatientAdmissionDate'])  : null;
    let sndfrAprvlStrTm =  (hospital['Hospital_InpatientAdmissionDate'] ? this.formatTime(hospital['Hospital_InpatientAdmissionDate'] ) : null);
    const hospitalObj = {
      placementtypekey:"LA",
      contactname:null,
      caregiverclientid: null,
      primarycaregiver:null,
      partnerid:null,
      secondarycaregiver:null,
      primaryrelationship:null,
      remarks:null,
      contactphone:null,
      workphone:null,
      enddate: hospital['Hospital_DischargedDate'] ? this.formatDate(hospital['Hospital_DischargedDate']) : null,
      add1:hospital['Hospital_address1'],
      add2:hospital['Hospital_address2'],
      cityname:hospital['Hospital_city'],
      statetypekey:hospital['Hospital_state'],
      zipcode:hospital['Hospital_zipcode'],
      countytypekey:null,
      runawayreported:null,
      runawayreportnumber:null, 
      runawaynotreportedreason:null,
      endtime: hospital['Hospital_DischargedDate'] ? this.formatTime(hospital['Hospital_DischargedDate']):null,
      whereabouts:null,
      country:null,
      tribalservicearea:null,
      fostercarehome:null,
      fostercarenonfoster:null,
      fostercomments:null,
      livingarrangementluggage:null,
      laluggagepurchased:null,
      laluggagecomments:null, 
      ladisposableortrashbag :null,
      servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
      v_securityusersid: this.userInfo.user.userprofile.securityusersid,
      livingarrangementtypekey: this.getLivingarrangementtypekey(hospital),
      startdate: hospital['Hospital_examStartDate'] ?  this.formatDate(hospital['Hospital_examStartDate']) : sndfrAprvlStrtDt,
      starttime:  hospital['Hospital_examStartDate'] ? this.formatTime(hospital['Hospital_examStartDate']) : sndfrAprvlStrTm ,
      personid:this.personId,
      health: hospital,
      intakeservicerequestactorid:this._hospitalizationService.intakeservicerequestactorid
    }

    const payload = {...hospitalObj, ...this.luggageForm?.value , ...this.exitPlacementForm?.value}
    this.addUpdatePlacement(payload);

  }


  openLuggageForm(hospital: Hospitalization | undefined){
    if (!this.personPlacements || this.personPlacements.length === 0) {
      this.reusableOpenLuggageFormFn(hospital);
      return;
    }
      let placements = false;
      let islaoverlap = false;
      const placement = this.returnPersonPlacementFilteredDataFn();
      const  placementStartDt = this.returnPlacementStartDtFn(hospital);
      const placementEndDt = this.returnPlacementEndDtFn(hospital);
      let  firstStartDate: null = null;
      let  lastEndDate: null = null;
      const livingarrangementtypekey = this.getLivingarrangementtypekey(hospital);
      this.personPlacements.forEach((place: any) => {
        const { placStatDt, placEndDt } = this.returnPlacDtaeFn(place);
        if (this.returnIfFirstStartDateIsNullFn(firstStartDate, placStatDt)) {
          firstStartDate = placStatDt;
        }
        if (this.returnIfPlacEndDtFn(placEndDt, lastEndDate)) {
          lastEndDate = placEndDt;
        }
        if (this.returnIfPlaceFn(place, livingarrangementtypekey)) {
          placements = true;
        }
        if (!islaoverlap) {
          islaoverlap = this.isLAOverlap(livingarrangementtypekey, place, new Date(placementStartDt).getTime(), new Date(placementEndDt).getTime(), new Date(placStatDt).getTime(), new Date(placEndDt).getTime(), islaoverlap);
        }
      });
      const { isBackDate, isOpenRecord, isLastEndDate } = this.returnDateDataFn(livingarrangementtypekey, lastEndDate, placementEndDt, firstStartDate, hospital, placementStartDt);
      if (isBackDate) {
        this._alertService.error('Please enter the discharge/exit date as this open exit date overlaps with other existing Hospitalization Living Arrangement record');
        return;
      } else if (this.returnPlacementCheckFn(placements, firstStartDate, placementStartDt)) {
        placements = false;
      }
      if (this.returnIfErrorFn(livingarrangementtypekey, placement, islaoverlap, placements, isBackDate, placementStartDt, firstStartDate, isOpenRecord, isLastEndDate)) {
        return;
      }
    // }
    this.reusableOpenLuggageFormFn(hospital);
  }
  // Assosiated with openLuggageForm method
  private returnPlacDtaeFn(place: any) {
    let placStatDt = place.starttime;
    let placEndDt = place.endtime;
    return { placStatDt, placEndDt };
  }

  // Assosiated with openLuggageForm method
  private returnPlacementCheckFn(placements: boolean, firstStartDate: any, placementStartDt: any) {
    return (placements && (firstStartDate && (new Date(placementStartDt).getTime() < new Date(firstStartDate).getTime())));
  }

  // Assosiated with openLuggageForm method
  private returnIfErrorFn(livingarrangementtypekey: any, placement: any, islaoverlap: boolean, placements: boolean, isBackDate: boolean, placementStartDt: any, firstStartDate: any, isOpenRecord: boolean, isLastEndDate: boolean) { // NOSONAR
    return (this.isError(livingarrangementtypekey, placement, islaoverlap, placements, isBackDate, (new Date(placementStartDt).getTime() < new Date(firstStartDate).getTime()), isOpenRecord, isLastEndDate, true));
  }
  // Assosiated with openLuggageForm method
  private returnIfPlaceFn(place: any, livingarrangementtypekey: any) {
    return (place && (place.livingenddate === null && (place.livingarrangementtypekey === livingarrangementtypekey.trim()) && place.routingstatus !== 'Rejected'));
  }
  // Assosiated with openLuggageForm method
  private returnIfPlacEndDtFn(placEndDt: any, lastEndDate: any) {
    return (placEndDt && (lastEndDate == null || (new Date(placEndDt).getTime() > new Date(lastEndDate).getTime())));
  }
  // Assosiated with openLuggageForm method
  private returnIfFirstStartDateIsNullFn(firstStartDate: any, placStatDt: any) {
    return (firstStartDate == null || (new Date(placStatDt).getTime() < new Date(firstStartDate).getTime()));
  }
  // Assosiated with openLuggageForm method
  private returnPlacementEndDtFn(hospital: any) {
    return (hospital.Hospital_DischargedDate ? hospital.Hospital_DischargedDate : null);
  }
  // Assosiated with openLuggageForm method
  private returnPlacementStartDtFn(hospital: any) {
    return (hospital.Hospital_InpatientAdmissionDate ? hospital.Hospital_InpatientAdmissionDate : hospital.Hospital_examStartDate);
  }
  // Assosiated with openLuggageForm method
  private returnDateDataFn(livingarrangementtypekey: any, lastEndDate: any, placementEndDt: any, firstStartDate: any, hospital: any, placementStartDt: any) {
    const isLastEndDate = (lastEndDate === null);
    const isOpenRecord = (placementEndDt === null) && this.personPlacements.filter((place: any) => place.livingenddate === null && ((livingarrangementtypekey === 'RFKH' && place.livingarrangementtypekey === 'RFKH') || (livingarrangementtypekey !== 'RFKH' && (place.livingarrangementtypekey === 'ERM' || place.livingarrangementtypekey === 'ERP' || place.livingarrangementtypekey === 'IMC' || place.livingarrangementtypekey === 'PSYH')))).length > 0;
    const placementEndDtF = placementEndDt ? placementEndDt : lastEndDate;
    const isBackDate = (firstStartDate && !hospital.Hospital_DischargedDate && ((new Date(placementStartDt).getTime() < new Date(firstStartDate).getTime()) || (new Date(placementEndDtF).getTime() < new Date(lastEndDate).getTime())));
    return { isBackDate, isOpenRecord, isLastEndDate };
  }
  // Assosiated with openLuggageForm method
  private returnPersonPlacementFilteredDataFn() {
    return (this.personPlacements.filter((placement: { enddate: null; livingarrangementtypekey: string; }) => placement.enddate === null && (placement.livingarrangementtypekey === 'ERM' || placement.livingarrangementtypekey === 'ERP' || placement.livingarrangementtypekey === 'IMC' || placement.livingarrangementtypekey === 'PSYH')));
  }
  // Assosiated with openLuggageForm method
  private reusableOpenLuggageFormFn(hospital: any) {
    if (!hospital.Hospital_Discharged) {
      this.showExitTypes = false;
      this.exitPlacementForm?.reset();
    } else {
      this.showExitTypes = true;
    }
    if (hospital.Hospital_examStartDate) {
      hospital.Hospital_examStartDate = this.formatDate(hospital.Hospital_examStartDate);
    }
    if (hospital.Hospital_InpatientAdmissionDate) {
      hospital.Hospital_InpatientAdmissionDate = this.formatDate(hospital.Hospital_InpatientAdmissionDate);
    }
    if (hospital.Hospital_DischargedDate) {
      hospital.Hospital_DischargedDate = this.formatDate(hospital.Hospital_DischargedDate);
    }
    this.hospitalEntry = hospital;
    this.mandatorymessage = true;
    $('#luggage-pop-up').modal('show');
  }

  isLAOverlap(livingArrangementKey: string, place: { livingarrangementtypekey: string; }, placementStartDt: number, placementEndDt: number | null, placStatDt: number, placEndDt: number | null, islaoverlap: any) {
    const isLivingArrangementKey = (livingArrangementKey === 'ERM' || livingArrangementKey === 'ERP' || livingArrangementKey === 'IMC' || livingArrangementKey === 'PSYH');
    const isPlaceLivingArrangementKey = (place && (place.livingarrangementtypekey === 'ERM' || place.livingarrangementtypekey === 'ERP' || place.livingarrangementtypekey === 'IMC' || place.livingarrangementtypekey === 'PSYH'));
    if (isLivingArrangementKey) {
      if (((isPlaceLivingArrangementKey  && placEndDt && placementEndDt
      && ((placementStartDt >= placStatDt && placementStartDt <= placEndDt) 
      || (placementEndDt >= placStatDt && placementEndDt <= placEndDt)))
        || (isPlaceLivingArrangementKey && placementEndDt && placEndDt
        && ((placStatDt >= placementStartDt && placStatDt <= placementEndDt) 
        || (placEndDt >= placementStartDt && placStatDt <= placementEndDt)))) || (isPlaceLivingArrangementKey && placementEndDt == null && placEndDt == null && placementStartDt >= placStatDt)) {
        islaoverlap = true;
      }
    }
    return islaoverlap;
  }
  isError(livingArrangementKey: string, placement: string | any[], islaoverlap: boolean, placements: boolean, isBackDate: boolean, isOlderRecord: boolean, isOpenRecord: boolean, isLastEndDate: boolean, isApprove?: any) { // NOSONAR
    const isLivingArrangementKey = (livingArrangementKey === 'ERM' || livingArrangementKey === 'ERP' || livingArrangementKey === 'IMC' || livingArrangementKey === 'PSYH');
    if (isLivingArrangementKey) {
      if (placement.length || placements) {
        if(this.handleIfPlacementFn(isBackDate, isLivingArrangementKey, islaoverlap, isOlderRecord, isOpenRecord, isLastEndDate, isApprove)) {
          return true
        }
      } else if (islaoverlap) {
          if (isLastEndDate) {
            this.openRecordPop(isLivingArrangementKey);
            return true;
          }
          this.overLapRecordPop();
          return true;
        }
    }
    return false;
  }
  // Assosiated with isError method
  private handleIfPlacementFn(isBackDate: any, isLivingArrangementKey: any, islaoverlap: any, isOlderRecord: any, isOpenRecord: any, isLastEndDate: any, isApprove: any) {
    if (isBackDate) {
      this.openRecordPop(isLivingArrangementKey);
      return true;
    } else if (islaoverlap) {
      if (!isOlderRecord) {
        this.openRecordPop(isLivingArrangementKey, isOpenRecord, isApprove);
        return true;
      } else {
        this.overLapRecordPop();
        return true;
      }
    } else if (!isOlderRecord) {
      if (isOpenRecord) {
        this._alertService.error('Overlapping Hospitalization Living Arrangement is not allowed, Please Discharge/End the Active record to create a new one.');
        return true;
      } else if (isLastEndDate) {
        this.openRecordPop(isLivingArrangementKey);
        return true;
      }
    }
    return false
  }
  luggagePopCancel(){
    $('#luggage-pop').hide('show');
  }

  submitLuggageForm(){
    this.sendForApproval(this.hospitalEntry)   
  }


   addUpdatePlacement(formData: any) {
    const serviceCaseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const casenumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
      this._commonHttpService
        .create(formData, 'placement/addupdate')
        .subscribe(response => {
          if (response.msgStatus == 'ERROR') {
            this._alertService.error(response.message, true);
          } else if (response.msgStatus == 'Success') {
            this._alertService.success(response.message, true);
            this._router.navigate([`/pages/case-worker/${serviceCaseId}/${casenumber}/dsds-action/sc-placements/list`])
          }
          this.luggageForm?.reset();
          this.exitPlacementForm?.reset();
        });
    }


    

  delete() {
    const data = {
      'hospitalizationid': this.selectedItem.hospitalizationid,
    };
    this._healthService.saveHealth({ 'personHospitalizationHistory': [data] }, 2).subscribe(_ => {
      this._alertService.success('Deleted Hospitalization Info Successfully');
      this.resetForm();
      this.paginationInfo.pageNumber = 1;
      this.getHospitalizationList();
    });
  }

  reasonForHospitalizationDetailsKeyUp(){
    this.remainingCount = 0;
    const currentLength = this.hosptializationForm?.controls['hospitalization_reasonForHospitalization_others'].value.length;
    this.remainingCount = 280 - currentLength;
  }
  erExaminationChng() {
    if (!this.hosptializationForm?.controls.Hospital_ERexamination.value) {
      this.hosptializationForm?.controls.Hospital_examStartDate.reset();
      this.hosptializationForm?.controls.Hospital_examStartDate.clearValidators();
      this.hosptializationForm?.controls.Hospital_examStartDate_starttime.reset();
      this.hosptializationForm?.controls.Hospital_examStartDate_starttime.clearValidators();
      this.hosptializationForm?.controls.Hospital_examStartDate_starttime.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_examStartDate.updateValueAndValidity();
    } else{
      if(this.livingArrangementKey && (this.livingArrangementKey === "IMC" || this.livingArrangementKey === "PSYH")) {
        this._alertService.error('Please select the appropriate Living Arrangement Type');

      }
      this.hosptializationForm?.controls.Hospital_examStartDate.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_examStartDate_starttime.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_examStartDate_starttime.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_examStartDate.updateValueAndValidity();
    }
  }

  erEvalutionChng() {
    if (!this.hosptializationForm?.controls.Hospital_ERevaluation.value) {
      this.hosptializationForm?.controls.Hospital_evaluatSartDate.reset();
    }
  }

  inpatientAdmissionChng() {
    if (!this.hosptializationForm?.controls.Hospital_InpatientAdmission.value) {
      this.hosptializationForm?.controls.durationdays.reset();
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate.reset();
      this.hosptializationForm?.controls.medicalnecessitydays.reset();
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate.clearValidators();
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate_starttime.reset();
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate_starttime.clearValidators();
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate_starttime.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate.updateValueAndValidity();
    } else {
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate_starttime.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate_starttime.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_InpatientAdmissionDate.updateValueAndValidity();
    }
    if(this.hosptializationForm?.get('Hospital_examStartDate')?.value) {
      this.startMinDate = new Date(this.hosptializationForm['controls'].Hospital_examStartDate.value);
      const minEndDate = moment(this.startMinDate).format(this.dtformat1); 
      this.exitMinDate = moment(minEndDate).toDate(); 
    }
  }
  overStayChng() {
    if (!this.hosptializationForm?.controls.Hospital_Overstay.value) {
      this.hosptializationForm?.controls.Hospital_LengthOfOverstay.reset();
      this.hosptializationForm?.controls.Hospital_OverstayDate.reset();
      this.hosptializationForm?.controls.medicalnecessitydays.reset();
      this.hosptializationForm?.controls.Hospital_OverstayDate.clearValidators();
      this.hosptializationForm?.controls.Hospital_OverstayDate.updateValueAndValidity();
    } else{
      this.hosptializationForm?.controls.Hospital_OverstayDate.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_OverstayDate.updateValueAndValidity();
    }
  }
  disChargedChng() {
    if (!this.hosptializationForm?.controls.Hospital_Discharged.value) {
      this.hosptializationForm?.controls.Hospital_DischargedDate.reset();
      this.startDateChange(this.hosptializationForm);
      this.hosptializationForm?.controls.Hospital_DischargedDate.clearValidators();
      this.hosptializationForm?.controls.Hospital_DischargedDate_starttime.clearValidators();
      this.hosptializationForm?.controls.Hospital_DischargeRecommendation.clearValidators();
      this.hosptializationForm?.controls.Actual_Placement_After_Discharge.clearValidators();
      this.hosptializationForm?.controls.Hospital_DischargeDiagnoses.clearValidators();
      this.hosptializationForm?.controls.Hospital_DischargedDate_starttime.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_DischargedDate.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_DischargeRecommendation.updateValueAndValidity();

      this.hosptializationForm?.controls.Actual_Placement_After_Discharge.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_DischargeDiagnoses.updateValueAndValidity();
    } else  {
      this.hosptializationForm?.controls.Hospital_DischargedDate.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_DischargedDate_starttime.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_DischargeRecommendation.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Actual_Placement_After_Discharge.setValidators([Validators.required]);
      this.hosptializationForm?.controls.Hospital_DischargeDiagnoses.setValidators([Validators.required]);
  
      this.hosptializationForm?.controls.Hospital_DischargedDate_starttime.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_DischargedDate.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_DischargeRecommendation.updateValueAndValidity();
      this.hosptializationForm?.controls.Actual_Placement_After_Discharge.updateValueAndValidity();
      this.hosptializationForm?.controls.Hospital_DischargeDiagnoses.updateValueAndValidity();
    }
    if(this.hosptializationForm?.controls.Hospital_Discharged.value && this.hosptializationForm['controls'].Hospital_examStartDate.value) {
      this.startMinDate = new Date(this.hosptializationForm['controls'].Hospital_examStartDate.value);
      const minEndDate = moment(this.startMinDate).format(this.dtformat1); 
      this.exitMinDate = moment(minEndDate).toDate(); 
    }

    this.dischargeChangeHandlerEvent.emit(this.hosptializationForm?.controls.Hospital_Discharged.value)
  }

  updateHospitalEntry(data: { Hospital_address1?: any; Hospital_address2?: any; Hospital_city?: any; Hospital_state?: any; Hospital_zipcode?: any; county?: any; }) {
    data.Hospital_address1 = this.address.address1;
    data.Hospital_address2 = this.address.address2;
    data.Hospital_city = this.address.city;
    data.Hospital_state = this.address.state;
    data.Hospital_zipcode = this.address.zipcode;
    data.county = this.address.county;
    this.hospitalizationFormEvent.emit( { ...this.hosptializationForm?.getRawValue(), ...data,...{uploadpath: this.uploadedFiles} });
  }

  handleDischargeValues(controlName: string | (string | number)[]){
    if(this.isAddEdit && this.loadHospitalForms && this.viewMode && !this.addHospitalizationBtn && this.hideHospitalizationRecords ){
      const value = this.hosptializationForm?.get(controlName)?.value;
      this.updateHospitalEntry({ ...this.hosptializationForm?.getRawValue(), ...{controlName:value} })
    }
    
  }
  
  getPlacementInfoList() {
    this.personPlacements = [];
    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 10,
                method: 'get',
                where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
            }),
            'placement/getplacementbyservicecase?filter'
        ).subscribe(result => {
            const list = Array.isArray(result.data) ? result.data : [];
            if (list.length) {
              let pPlacements: any = list.find((e: any) => e.personid = this.personId && e.cjamspid === this.personDetails?.personbasicdetails?.cjamspid);
              if (pPlacements && pPlacements.placements.length > 0) {
                this.personPlacements = pPlacements.placements;
              }
            }
        });
  }

  endDatechangevalidation() {
    const { minDate, toDate } = this.returnMinAndToDateFn();
    let placements: any[] = [];
    placements = this.returnPlacementFilterDataFn();
    if (placements.length === 0) {
      return false;
    }
    const { placementEndDt, placementStartDt, firstStartDate, lastEndDate, outOfRange, isLastEndDate } = this.returnDatesDataInEndDateFn(minDate, toDate, placements);
    const isOpenRecord = (placementEndDt === null);
    const isOlderRecord = firstStartDate ? (new Date(placementStartDt).getTime() < new Date(firstStartDate ?? '').getTime()): '';
    const placementEndDtF = this.returnPlacementEndDtFFn(placementEndDt, lastEndDate);
    const isBackDate = this.returnIsBackDateInEndDateFn(firstStartDate, placementStartDt, placementEndDtF, lastEndDate);
    if (isBackDate) {
      this.handlePlacementStartAndEndDateFn(placementStartDt, firstStartDate, placementEndDtF, lastEndDate);
      return true;
    } else if (outOfRange) {
      if (!isOlderRecord) {
        if(firstStartDate){
        if (new Date(placementStartDt).getTime() >= new Date(firstStartDate ?? '').getTime()) {
          this.overLapRecordPop();
        } else {
          this.openRecordPop();
        }
      }
        return true;
      } else {
        this.overLapRecordPop();
        return true;
      }
    } else if (!isOlderRecord) {
      if (isOpenRecord) {
        this.openDischargeDatePop();
        return true;
      } else if (isLastEndDate && lastEndDate && (new Date(placementEndDtF).getTime() > new Date(lastEndDate ?? '').getTime())) {
        this.openRecordPop();
        return true;
      }
    }
    return outOfRange;
  }
  // Assosiated with endDatechangevalidation method
  private returnPlacementEndDtFFn(placementEndDt: any, lastEndDate: any) {
    return (placementEndDt ? placementEndDt : lastEndDate);
  }
  // Assosiated with endDatechangevalidation method
  private returnPlacementFilterDataFn(): any[] {
    return (this.personPlacements.filter((e: any) => (e.routingstatus !== 'Rejected' && (e.livingarrangementtypekey === 'ERM' || e.livingarrangementtypekey === 'ERP' || e.livingarrangementtypekey === 'IMC' || e.livingarrangementtypekey === 'PSYH'))));
  }
  // Assosiated with endDatechangevalidation method
  private handlePlacementStartAndEndDateFn(placementStartDt: any, firstStartDate: any, placementEndDtF: any, lastEndDate: any) {
    if ((new Date(placementStartDt).getTime() > new Date(firstStartDate).getTime()) && (new Date(placementEndDtF).getTime() < new Date(lastEndDate).getTime())) {
      this.overLapRecordPop();
    } else {
      this.openDischargeDatePop();
    }
  }

  // Assosiated with endDatechangevalidation method
  private returnIsBackDateInEndDateFn(firstStartDate: any, placementStartDt: any, placementEndDtF: any, lastEndDate: any) {
    return (firstStartDate && !this.hosptializationForm?.value.Hospital_DischargedDate && ((new Date(placementStartDt).getTime() < new Date(firstStartDate).getTime()) || (new Date(placementEndDtF).getTime() < new Date(lastEndDate).getTime())));
  }
  // Assosiated with endDatechangevalidation method
  private returnDatesDataInEndDateFn(minDate: any, toDate: any, placements: any[]) {
    let outOfRange = false;
    let firstStartDate: string | number | Date | null = null;
    let lastEndDate: string | number | Date | null = null;
    const placementStartDt = minDate;
    const placementEndDt = toDate ? toDate : null;
    const placementStartDtT = new Date(minDate).getTime();
    const placementEndDtT = new Date(toDate ? toDate : null).getTime();
    placements.forEach(placement => {
      let placStatDt = new Date(placement.starttime).getTime();
      let placEndDt = new Date(this.returnLivingenddateFn(placement)).getTime();
      if (this.returnOutOfRangeCondFn(outOfRange, placementStartDtT, placStatDt, placEndDt, placementEndDtT)) {
        outOfRange = true;
      }
      if (firstStartDate == null || (new Date(placement.starttime).getTime() < new Date(firstStartDate).getTime())) {
        firstStartDate = placement.starttime;
      }
      let endd = placement.endtime ? placement.endtime : placement.starttime;
      if ((lastEndDate == null || (new Date(endd).getTime() > new Date(lastEndDate).getTime()))) {
        lastEndDate = endd;
      }
    });
    let isLastEndDate = (lastEndDate === null);
    if (!isLastEndDate) {
      let lastDate = placements.find((e: any) => e.starttime === lastEndDate);
      isLastEndDate = (lastDate && lastDate.endtime === null);
    }
    return { placementEndDt, placementStartDt, firstStartDate, lastEndDate, outOfRange, isLastEndDate };
  }
  // Assosiated with endDatechangevalidation method
  private returnLivingenddateFn(placement: any): string | number | Date {
    return placement.endtime ? placement.endtime : placement.starttime;
  }
  // Assosiated with endDatechangevalidation method
  private returnOutOfRangeCondFn(outOfRange: boolean, placementStartDtT: number, placStatDt: number, placEndDt: number, placementEndDtT: number) {
    return (!outOfRange && (((placementStartDtT >= placStatDt && placementStartDtT <= placEndDt) || (placementEndDtT >= placStatDt && placementEndDtT <= placEndDt)) || ((placStatDt >= placementStartDtT && placStatDt <= placementEndDtT) || (placEndDt >= placementStartDtT && placStatDt <= placementEndDtT)) || (placementEndDtT == null && placEndDt == null && placementStartDtT >= placStatDt)));
  }
  // Assosiated with endDatechangevalidation method
  private returnMinAndToDateFn() {
    let minDate: any = '';
    let toDate: any = '';
    if (this.hosptializationForm?.get('Hospital_examStartDate')?.value && this.hosptializationForm['controls'].Hospital_examStartDate_starttime.value) {
      let examStartDate = this.hosptializationForm['controls'].Hospital_examStartDate.value.includes("T") ? this.hosptializationForm['controls'].Hospital_examStartDate.value.split("T")[0] : (this.hosptializationForm['controls'].Hospital_examStartDate.value + " " + this.hosptializationForm['controls'].Hospital_examStartDate_starttime.value + ":00");
      minDate = moment(new Date(examStartDate)).format("YYYY-MM-DD hh:mm a");
    } else if (this.hosptializationForm?.get('Hospital_InpatientAdmissionDate') && this.hosptializationForm['controls']?.Hospital_InpatientAdmissionDate_starttime.value) {
      minDate = (this.hosptializationForm.get('Hospital_InpatientAdmissionDate')?.value.includes("T") ? this.hosptializationForm['controls']?.Hospital_InpatientAdmissionDate.value.split("T")[0] : this.hosptializationForm['controls'].Hospital_InpatientAdmissionDate.value)  + " "+  this.hosptializationForm['controls'].Hospital_InpatientAdmissionDate_starttime.value + ":00";
      minDate = new Date(minDate);
    } else {
      minDate = new Date();
    }
    if (this.hosptializationForm?.get('Hospital_DischargedDate')?.value && this.hosptializationForm['controls']?.Hospital_DischargedDate_starttime.value) {
      toDate = this.hosptializationForm['controls'].Hospital_DischargedDate.value  + " "+ this.hosptializationForm['controls'].Hospital_DischargedDate_starttime.value + ":00";
    } else {
      toDate = minDate;
    }
    return { minDate, toDate };
  }

  overLapRecordPop() {
    this._alertService.error('Please enter the dates correctly as selected dates are overlapping with other existing Living Arrangement');
  }
  openRecordPop(isLivingArrangementKey?: any, isOpenRecord?: any, isApprove?: any) {
    if(isLivingArrangementKey) {
      if (!isOpenRecord && isApprove) {
        this._alertService.error('Overlapping Hospitalization Living Arrangement is not allowed.');
      } else {
        this._alertService.error('Overlapping Hospitalization Living Arrangement is not allowed, Please Discharge/End the Active record to create a new one.');
      }
    } else {
      this._alertService.error('The user must end the older Living Arrangement before the user can leave the screen');
    }
  }
  openDischargeDatePop() {
    this._alertService.error("Please enter the discharge date as this open discharge date overlaps with other existing Hospitalization record");
  }
  luggagebuttonreset(value:any){

    if(value ===1){
      this.luggageForm?.patchValue({
       laluggagepurchased :null,
       laluggagecomments:null,
       ladisposableortrashbag :null
      })
    }
      if(value ===2){
        this.luggageForm?.patchValue({
          laluggagecomments:null,
          ladisposableortrashbag :null
         })

      }
      const luggagecomments = this.luggageForm?.get('laluggagecomments');
      luggagecomments?.clearValidators();
      luggagecomments?.updateValueAndValidity();

  }

  openexitreasoninfo(){

  }
}

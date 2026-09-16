import { Component,  OnInit, Injector } from '@angular/core';
import { Validators, FormBuilder, FormGroup, FormControl } from '@angular/forms';
import { ServiceCasePlacementsService } from '../../service-case-placements.service';
import { forkJoin, Observable, of } from 'rxjs';
import { NewUrlConfig } from '../../../../../newintake/newintake-url.config';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { CommonHttpService, CommonDropdownsService, AlertService, DataStoreService, SessionStorageService } from '../../../../../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { PlacementConstants } from '../../constants';
import moment from 'moment';
import { CASE_STORE_CONSTANTS } from '../../../../../case-worker/_entities/caseworker.data.constants';
import { InvolvedPersonsService } from '../../../../../shared-pages/involved-persons/involved-persons.service';
import { AppConstants } from '../../../../../../@core/common/constants';
import { HospitalizationService } from '../../../../../../shared/services/hospitalization.service';
import { ExitPlacementService } from '../../exit-placements/exit-placement.service';
import _ from 'lodash';

declare var $: any;
@Component({
    selector: 'living-arrangement-form',
    templateUrl: './living-arrangement-form.component.html',
    styleUrls: ['./living-arrangement-form.component.scss'],
    standalone: false
})
export class LivingArrangementFormComponent implements OnInit {
  placementForm!: FormGroup;
  referalForm!: FormGroup;
  minDate: any;
  maxDate: any;
  maxTime: any;
  endMinDate: any;
  countyDropDownItems: any[] = [];
  stateDropDownItems: any[] = [];
  countryDropDownItems: any[] = [];
  tsaDropdownItems: any[] = [];
  livingDropDownItems: any[] = [];
  selectedChildren: any[] = [];
  icwaStatus = false;
  icwaStatusRequired = false;
  isRunaway = false;
  isRunawayReported = false;
  disabletsafields = true;
  isClosed = false;
  suggestedAddress$!: Observable<any[]>;
  caregiverPersonsList: any = [];
  caregiverPersonsList2: any;
  primaryselected: boolean = false;
  secondaryselected: boolean = false;
  personsList: any = [];
  relationShipDropdownItems: any[] = [];
  copyRelationShipDropdownItems: any[] = [];
  sendforapprovaldisabled = false;
  test!: boolean;
  personId: any;
  readOnly: boolean = false;
  fostercarehomelist :any[] = [];
  fosternonfosterlist :any[] = [];
  ratetypepicklist: any[] = [];
  dtformat = 'YYYY-MM-DD';
  mandatorymessage: boolean =false;
  selectedPersonId: any;
  hospitalizationData: any = {}
  hospitalizationFormValues: any = {};
  exitTypes: any[] = [];
  dtformat2 = 'MM-DD-YYYY';
  hospitalizationFormStatus = true;
  daNumber!: string;

  private readonly _service: InvolvedPersonsService;
  private  readonly _ServiceCasePlacementsService: ServiceCasePlacementsService;
  private readonly _dropDownService: CommonDropdownsService;
  private readonly formBuilder: FormBuilder;
  private readonly _alertService: AlertService;
  private readonly router: Router;
  private readonly route: ActivatedRoute;
  private readonly  _dataStoreService: DataStoreService;
  private readonly _httpService: CommonHttpService;
  private readonly storage: SessionStorageService;
  private hospitalizationService: HospitalizationService;
  private exitService: ExitPlacementService;
  doesPlacementExist!: boolean;

  constructor(private injector: Injector){
    this._service = this.injector.get<InvolvedPersonsService>(InvolvedPersonsService);
    this._ServiceCasePlacementsService = this.injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
    this._dropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this. _dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._httpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this.hospitalizationService = this.injector.get<HospitalizationService>(HospitalizationService);
    this.exitService = this.injector.get<ExitPlacementService>(ExitPlacementService);

    this._dataStoreService.setData(AppConstants.GLOBAL_KEY.SOURCE_PAGE, AppConstants.MODULE_TYPE.CASE);
  }

  ngOnInit() {
    this.hospitalizationService.getSelectedPersonId().subscribe((personId:string) => this.personId= personId);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.forminitialize();
    this.minDate = new Date();
    this.maxDate = new Date();
    this.maxTime = moment(new Date()).format("HH:mm");
    this.endMinDate = new Date();
    this.setFormControlValidators();
    this.loadDropdownItems();
    this.sendforapprovaldisabled = false;
    this._ServiceCasePlacementsService.placementApprovalQueue$.subscribe(response => {
      $('#placement-ackmt').modal('show');
      this.sendforapprovaldisabled = false;
    });
    this.placementForm.get('startdate')?.valueChanges.subscribe(result => {
        this.placementForm.patchValue({ enddate: null });
        if (result) {
          this.endMinDate = new Date(result);
        }
      });
    this.initCaregiverLists();
    this.selectedChildren = this._ServiceCasePlacementsService.selectedChildren;
  
    this.validatePlacementDates(this.selectedChildren);
    this.personsList = this._ServiceCasePlacementsService.personsList;
    this.selectedChildren.forEach((field) => {
      this.personsList.forEach((item: { personid: any; icwastatusinquiry: string; }) => {
        if (item.personid == field.personid) {
          if (item.icwastatusinquiry == 'NO') {
            this.icwaStatusRequired = true;
            return;
          }
        }
      }) 
    });
    this._ServiceCasePlacementsService.childSelection$.subscribe(children => {
      this.selectedChildren = this._ServiceCasePlacementsService.selectedChildren;
      this.initCaregiverLists();
      this.placementForm.patchValue({
        startdate: null,
        enddate: null
      });
      this.validatePlacementDates(this.selectedChildren);
    });

    const da_status = this.storage.getItem('da_status');
    if (da_status) {
      if (da_status === 'Closed' || da_status === 'Completed') {
        this.isClosed = true;
      } else {
        this.isClosed = false;
      }
    }
    this.handleHospitalizationServiceFn();
    
  }
  // Assosiated with ngOnInit method
  private handleHospitalizationServiceFn() {
    this.hospitalizationService.getSelectedPersonId().subscribe((selectedPersonId: any) => {
      this.selectedPersonId = selectedPersonId;
    });

    this.exitService.getExitTypes().subscribe(result => {
      if (result && result.length) {
        this.exitTypes = result;
      }

    });
  }

  initCaregiverLists() {
    this.caregiverPersonsList = this._ServiceCasePlacementsService.caregiversList;
    this.caregiverPersonsList2 = this.caregiverPersonsList;

  }
  primaryCaregiver($event: any) {
    this.personId = null;
    if ($event.value && $event.value != null && this.caregiverPersonsList) {
      const modal = this.caregiverPersonsList.find((data: { personid: any; }) => data.personid === $event.value);
      this.personId = $event.value;
      if (modal) {
        this.patchModal(modal);
      }
    }
    else {
      this.placementForm.reset({
        primarycaregiver: [null],
        partnerid: [null],
        secondarycaregiver: [null],
        primaryrelationship: [null],
        contactphone: [null],
        workphone: [null],
        hotelorother: [null],
        agency1to1: [null],
        agency1to1desc: [null],
        agency1to1explaination: [null],
        dailyrate: [null],
        agency1to1rate: [null],
        add1: [null],
        add2: [null],
        cityname: [null],
        statetypekey: [null],
        zipcode: [null],
        countytypekey: [null],
        country: [null],
        tribalservicearea: [null]
      });
      this.caregiverPersonsList2 = this.caregiverPersonsList;
      this.primaryselected = false;
    }
  }
  patchModal(modal: any) {
    this.loadStateDropdownItems(modal.state, modal.county);
    this.placementForm.patchValue({
      add1: this.emptyCheck(modal.address),
      add2: this.emptyCheck(modal.address2),
      cityname: this.emptyCheck(modal.city),
      hotelorother: this.emptyCheck(modal.hotelorother),
      agency1to1: this.emptyCheck(modal.agency1to1),
      agency1to1desc: this.emptyCheck(modal.agency1to1desc),
      agency1to1explaination: this.emptyCheck(modal.agency1to1explaination),
      dailyrate: this.emptyCheck(modal.dailyrate),
      agency1to1rate: this.emptyCheck(modal.agency1to1rate),
      statetypekey: this.emptyCheck(modal.state),
      zipcode: this.emptyCheck(modal.zipcode),
      countytypekey: this.emptyCheck(modal.county),
      contactphone: this.nullCheck(modal.phonenumber),
      workphone: this.nullCheck(modal.workphone),
      primarycaregiver: this.emptyCheck(modal.fullname)
    });
    const child = this.personsList ? this.personsList.find((person: { personid: any; }) => (this.selectedChildren && this.selectedChildren[0].personid == person.personid)) : {};
    if (child) {
      const relationship = this._ServiceCasePlacementsService.getRelationShip(child.personid, modal.personid, child.relationshiparray);
      const matchedRelationship = relationship
        ? this.relationShipDropdownItems.find(item => item.description === relationship)
        : null;
      this.placementForm.patchValue({
      primaryrelationship: matchedRelationship?.description || null
      });
    }    
    this.caregiverPersonsList2 = this.caregiverPersonsList.filter((care: { personid: any; }) => care.personid != modal.personid);
    this.placementForm.patchValue({
      partnerid: null,
      secondarycaregiver: null
    });
    this.primaryselected = true;
  }

  secondaryCaregiver($event: any) {
    let modal: any;
    if (this.caregiverPersonsList2) {
      modal = this.caregiverPersonsList2.find((data: { personid: any; }) => data.personid === $event.value);
    }
    if (modal) {
      this.placementForm.patchValue({
        secondarycaregiver: modal.fullname
      });
    } else {
      this.placementForm.patchValue({
        secondarycaregiver: [null]
      });
    }

    if ($event.value && $event.value != null) {
      this.secondaryselected = true;
    } else {
      this.secondaryselected = false;
    }
  }

  validatePlacementDates(selectedChildren: any) {
    if (selectedChildren && selectedChildren.length && Array.isArray(selectedChildren)) {
      let minDob = new Date();
      const today = new Date();
      const todayStr = moment(today).format(this.dtformat);
      selectedChildren.forEach((child, index) => {
        minDob = this.getMinDOB(child, minDob, todayStr)
      });
      this.minDate = minDob;
      this.endMinDate = minDob;
    }
  }

  getMinDOB(child: any, minDob: any, todayStr: any) {
    const minDobStr = moment(minDob).format(this.dtformat);
    if (child.dob) {
      const dob = new Date(child.dob);
      if (minDobStr === todayStr) {
        if (dob < minDob) {
          minDob = dob;
        }
      } else {
        if (dob > minDob) {
          minDob = dob;
        }
      }
    }
    return minDob;
  }

  close() {
    $('#placement-ackmt').modal('hide');
    this.goBack();
  }

  goBack() {
    this._ServiceCasePlacementsService.getChildRemovalInfoAndPlacements().subscribe(response => {
      this._ServiceCasePlacementsService.broadCastPageRefresh();
      this.router.navigate(['../../list'], { relativeTo: this.route });
    });
  }

  addControls = ()=>{
    this.placementForm.addControl('placementtypekey', new FormControl('LA'))
    this.placementForm.addControl('contactname', new FormControl(null));
    this.placementForm.addControl('caregiverclientid', new FormControl(null, Validators.required));
    this.placementForm.addControl('primarycaregiver', new FormControl(null));
    this.placementForm.addControl('partnerid', new FormControl(null));
    this.placementForm.addControl('secondarycaregiver', new FormControl(null));
    this.placementForm.addControl('primaryrelationship', new FormControl(null));
    this.placementForm.addControl('remarks', new FormControl(null));
    this.placementForm.addControl('contactphone', new FormControl(null));
    this.placementForm.addControl('workphone', new FormControl(null));
    this.placementForm.addControl('enddate', new FormControl(null));
    this.placementForm.addControl('add1', new FormControl(null, Validators.required));
    this.placementForm.addControl('add2', new FormControl(null));
    this.placementForm.addControl('cityname', new FormControl(null));
    this.placementForm.addControl('hotelorother', new FormControl(null));
    this.placementForm.addControl('agency1to1', new FormControl(null));
    this.placementForm.addControl('agency1to1desc', new FormControl(null));
    this.placementForm.addControl('agency1to1explaination', new FormControl(null));
    this.placementForm.addControl('dailyrate', new FormControl(null));
    this.placementForm.addControl('agency1to1rate', new FormControl(null));
    this.placementForm.addControl('ratetype', new FormControl(null)); 
    this.placementForm.addControl('statetypekey', new FormControl(null));
    this.placementForm.addControl('zipcode', new FormControl(null));
    this.placementForm.addControl('countytypekey', new FormControl(null));
    this.placementForm.addControl('runawayreported', new FormControl(null));
    this.placementForm.addControl('runawayreportnumber', new FormControl(null));
    this.placementForm.addControl('runawaynotreportedreason', new FormControl(null));
    this.placementForm.addControl('endtime', new FormControl(null));
    this.placementForm.addControl('whereabouts', new FormControl(null)); 
    this.placementForm.addControl('country', new FormControl(null)); 
    this.placementForm.addControl('tribalservicearea', new FormControl(null)); 
    this.placementForm.addControl('fostercarehome', new FormControl(null)); 
    this.placementForm.addControl('fostercarenonfoster', new FormControl(null)); 
    this.placementForm.addControl('fostercomments', new FormControl(null)); 
    this.placementForm.updateValueAndValidity();
  }

  removeControls = ()=>{
    this.placementForm.removeControl('placementtypekey');
    this.placementForm.removeControl('contactname');
    this.placementForm.removeControl('caregiverclientid');
    this.placementForm.removeControl('primarycaregiver');
    this.placementForm.removeControl('partnerid');
    this.placementForm.removeControl('secondarycaregiver');
    this.placementForm.removeControl('primaryrelationship');
    this.placementForm.removeControl('remarks');
    this.placementForm.removeControl('contactphone');
    this.placementForm.removeControl('workphone');
    this.placementForm.removeControl('enddate');
    this.placementForm.removeControl('add1');
    this.placementForm.removeControl('add2');
    this.placementForm.removeControl('cityname');
    this.placementForm.removeControl('hotelorother');
    this.placementForm.removeControl('agency1to1');
    this.placementForm.removeControl('agency1to1desc');
    this.placementForm.removeControl('agency1to1explaination');
    this.placementForm.removeControl('dailyrate');
    this.placementForm.removeControl('agency1to1rate');
    this.placementForm.removeControl('ratetype'); 
    this.placementForm.removeControl('statetypekey');
    this.placementForm.removeControl('zipcode');
    this.placementForm.removeControl('countytypekey');
    this.placementForm.removeControl('runawayreported');
    this.placementForm.removeControl('runawayreportnumber');
    this.placementForm.removeControl('runawaynotreportedreason');
    this.placementForm.removeControl('endtime');
    this.placementForm.removeControl('whereabouts'); 
    this.placementForm.removeControl('country'); 
    this.placementForm.removeControl('tribalservicearea'); 
    this.placementForm.removeControl('fostercarehome'); 
    this.placementForm.removeControl('fostercarenonfoster'); 
    this.placementForm.removeControl('fostercomments'); 
    this.placementForm.updateValueAndValidity();
  }

  forminitialize() {
    this.placementForm = this.formBuilder.group({
      placementtypekey: ['LA'],
      livingarrangementtypekey: [null, Validators.required],
      contactname: [null],
      caregiverclientid: [null],
      primarycaregiver: [null],
      partnerid: [null],
      secondarycaregiver: [null],
      primaryrelationship: [null],
      startdate: [null, Validators.required],
      remarks: [null],
      contactphone: [null],
      workphone: [null],
      enddate: [null],
      add1: [null, Validators.required],
      add2: [null],
      cityname: [null],
      hotelorother: [null],
      agency1to1: [null],
      agency1to1desc: [null],
      agency1to1explaination: [null],
      dailyrate: [null],
      agency1to1rate: [null],
      ratetype : [null],
      statetypekey: [null],
      zipcode: [null],
      countytypekey: [null],
      runawayreported: [null],
      runawayreportnumber: [null],
      runawaynotreportedreason: [null],
      endtime: [null],
      starttime: [null],
      whereabouts: [{ value: '', disabled: true }],
      country: [null],
      tribalservicearea: [null],
      fostercarehome : [null],
      fostercarenonfoster : [null],
      fostercomments : [null],
      livingarrangementluggage :[null],
      laluggagepurchased :[null],
      laluggagecomments: [null],
      ladisposableortrashbag: [null],
      hospitalizationType: [null],
      exittypekey:null,
      exitreasontypekey:null,
     remarks1:[null],
      leastrestrictiveplacement:null,
      casenumber:this.daNumber
    });
  }

  setFormControlValidators() {
    // If living arrangement is Runaway runawayreported is required otherwise not
    const runawayReportedControl: any = this.placementForm.get('runawayreported');
    const address1Control: any = this.placementForm.get('add1');
    const statetypekey: any = this.placementForm.get('statetypekey');
    const countytypekey: any = this.placementForm.get('countytypekey');
    const zipcode: any = this.placementForm.get('zipcode');
    const primaryrelationshipControl: any = this.placementForm.get('primaryrelationship');
   
    this.placementForm.get('livingarrangementtypekey')?.valueChanges
      .subscribe(livingArrangement => {
        if (livingArrangement === PlacementConstants.RUN_AWAY) {
          address1Control.setValidators(null);
          address1Control.setErrors(null);
          address1Control.clearValidators();
          statetypekey.setValidators(null);
          statetypekey.setErrors(null);
          statetypekey.clearValidators();
          countytypekey.setValidators(null);
          countytypekey.setErrors(null);
          countytypekey.clearValidators();
          zipcode.setValidators(null);
          zipcode.setErrors(null);
          zipcode.clearValidators();
        } else {
          address1Control.setValidators([Validators.required]);
          runawayReportedControl.setValidators(null);
          runawayReportedControl.setErrors(null);
          runawayReportedControl.clearValidators();
        }
        runawayReportedControl.updateValueAndValidity();
        address1Control.updateValueAndValidity();
        statetypekey.updateValueAndValidity();
        countytypekey.updateValueAndValidity();
        zipcode.updateValueAndValidity();
        if (livingArrangement.trim() === 'FCH' || livingArrangement.trim() === "RFKH" 
        || livingArrangement.trim() === "REC" || livingArrangement.trim() === "SHA" 
        || livingArrangement.trim() === "TVH" || livingArrangement.trim() === "OHA"
        ) {
          primaryrelationshipControl.setValidators(Validators.required);
          primaryrelationshipControl.updateValueAndValidity();
        } else {
          primaryrelationshipControl.setErrors(null);
          primaryrelationshipControl.setValidators(null);
        }
        this.test = primaryrelationshipControl.hasError('required');
      });
  }


  getSuggestedAddress() {
    if (this.placementForm.value.add1 &&
      this.placementForm.value.add1.length >= 3) {
      this.suggestAddress();
    }
  }

  suggestAddress() {
    this._httpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.placementForm.value.add1,
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
          if (result.length > 0) {
            this.suggestedAddress$ = of(result);
          } else {
            this.suggestedAddress$ = of([]);
          }
        }
      );
  }

  selectedAddress(model: any) {
    this.placementForm.patchValue({
      add1: this.emptyCheck(model.streetLine),
      cityname: this.emptyCheck(model.city),
      statetypekey: this.emptyCheck(model.state)
    });
    this.loadStateDropdownItems(model.state, null);
    const addressInput = {
      street: this.emptyCheck(model.streetLine),
      street2: '',
      city: this.emptyCheck(model.city),
      state: this.emptyCheck(model.state),
      zipcode: '',
      match: 'invalid'
    };
    this._httpService
      .getSingle(
        {
          method: 'post',
          where: addressInput
        },
        NewUrlConfig.EndPoint.Intake.ValidateAddressUrl
      )
      .subscribe(
        (result) => this.handlegetsingleaddressinput(result)
      );
  }

  handlegetsingleaddressinput (result: any) {
    if (result[0].analysis) {
      setTimeout(() => {
        this.placementForm.patchValue({
          zipcode: result[0].components.zipcode ? result[0].components.zipcode : '',
          countytypekey: result[0].metadata.countyName ? result[0].metadata.countyName : ''
        });
      }, 500);
    }
    
    
  }

  emptyCheck(input: any){
    return input ? input : '';
  }

  nullCheck(input: any){
    return input ? input : null;
  }

  private loadDropdownItems() {
    forkJoin([
      this._dropDownService.getPickListByName('livingarrangementstates'),
      this._dropDownService.getPickListByName('country'),
      this._dropDownService.getPickListByName('tribalservicearea'),
      this._dropDownService.getListByTableID(76),
      this._dropDownService.getRelations(),
      this._dropDownService.getListByTableID(762),
      this._dropDownService.getListByTableID(760),
      this._dropDownService.getListByTableID(942)
    ]).subscribe(([stateList,countryList, tsaList, livingArrangements, relations,fostercarehomelist,fosternonfosterlist, ratetypepicklist]) => {
     
      const withMD = stateList.filter(item => item.ref_key === 'MD')[0];
      this.stateDropDownItems = stateList.filter(item => item.ref_key !== 'MD');
      this.stateDropDownItems.unshift(withMD);
      
      const withUSA = countryList.filter(item => item.ref_key == 'USA')[0];
      this.countryDropDownItems = countryList.filter(item => item.ref_key != 'USA');
      this.countryDropDownItems.unshift(withUSA);
      this.tsaDropdownItems = tsaList;
      this.livingDropDownItems = livingArrangements.filter(item => item.activeflag === 1 && item.ref_key !== 'HMLS');
      this.relationShipDropdownItems = relations;
      this.copyRelationShipDropdownItems = JSON.parse(JSON.stringify(relations));
      this.fostercarehomelist = fostercarehomelist.filter(item => item.activeflag ===1);
      this.fosternonfosterlist =fosternonfosterlist.filter(item => item.activeflag ==1);
      this.ratetypepicklist =ratetypepicklist.filter(item => item.activeflag ==1);
    });
  }

  loadStateDropdownItems(stateId: any, countyId: any) {
    if(stateId !== 'NS') {
      this._httpService
      .getArrayList({
          where: {
            referencetypeid: 306,
            activeflag: 1,
            mdmcode: {"like": stateId + "~%25","options":"i"}
          },
          method: 'get',
          nolimit: true
        },
        'referencevalues?filter'
        )
       .subscribe(result => {
        this.countyDropDownItems = result;
        if (countyId) {
          const filteredCounty = this.countyDropDownItems.filter(county => county.ref_key  == countyId);
          if (filteredCounty && filteredCounty.length && filteredCounty.length > 0) {
            this.placementForm.patchValue({
              countytypekey: filteredCounty[0].value_text
            });
          }
        }
       });
    }
    if (stateId) {
      let whereabouts;
      let country = '';
      if (stateId == 'MD') {
        whereabouts = 'instate';
        country = 'USA';
        this.placementForm.get('country')?.disable();
      } else if (stateId == 'NS') {
        this.placementForm.get('country')?.enable();
        whereabouts = 'outcountry';
        this.countryDropDownItems = this.countryDropDownItems.filter(item => item.ref_key !== 'USA');
        this.placementForm.controls['countytypekey'].clearValidators();
        this.placementForm.controls['countytypekey'].updateValueAndValidity();
      } else {
        whereabouts = 'outstate';
        country = 'USA';
        this.placementForm.get('country')?.disable();
      }
      this.placementForm.patchValue({
        whereabouts: whereabouts,
        country: country
      });
    }
  }
  

  submitPlacementForm() {
    this.mandatorymessage = true;
    if (this.placementForm.valid && this.hospitalizationFormStatus) {
      if(this.returnLivingarrangementtypekeyFn()) {
        this._alertService.error('Please select the appropriate Living Arrangement Type');
        return;

      }
      const { isBackDate, placementsTemp, firstStartDate, placementStartDt, placement, islaoverlap, isOpenRecord, isLastEndDate } = this.returnSubmitPlacementDataFn();
      let placements = placementsTemp;
      if (isBackDate) {
        this._alertService.error('Please enter the discharge/exit date as this open exit date overlaps with other existing Hospitalization Living Arrangement record');
        return;
      } else if (placements && (firstStartDate && (new Date(placementStartDt).getTime() < new Date(firstStartDate).getTime()))) {
        placements = false;
      }
      if (this.isError(placement, islaoverlap, placements, isBackDate, (new Date(placementStartDt).getTime() < new Date(firstStartDate).getTime()), isOpenRecord, isLastEndDate)) {
        return;
      }
      this.placementFormValidation();
    }
    else {
      this.placementForm.markAllAsTouched();
      this._alertService.error('Please fill mandatory fields');
    }
  }

  // Assosiated with submitPlacementForm method
  private placementFormValidation(){
    if (this.placementForm.invalid) {
      this._alertService.error('Please fill required fields');
      this.sendforapprovaldisabled = false;
    } else if (this.placementForm.controls['livingarrangementtypekey'].value === 'FCNFHS' && this.placementForm.controls['fostercarenonfoster'].value === 'HOTEL' && this.placementForm.controls['dailyrate'].value == '0.00') {
      this._alertService.error('Daily rate should be greater than 0');
      this.sendforapprovaldisabled = false;
    } else if (this.placementForm.controls['livingarrangementtypekey'].value === 'FCNFHS' && this.placementForm.controls['fostercarenonfoster'].value === 'HOTEL' && this.placementForm.controls['agency1to1'].value && this.placementForm.controls['agency1to1rate'].value == '0.00') {
      this._alertService.error('1 to 1 Agency rate should be greater than 0');
      this.sendforapprovaldisabled = false;
    } else {
      if (this.placementForm.value?.dailyrate == '' ) {
        this.placementForm.patchValue({
          dailyrate :null
        });
      }
      if (this.placementForm.value?.agency1to1rate == '' ) {
        this.placementForm.patchValue({
          agency1to1rate :null
        });
      }
      this.sendApprovalInQueue();
    }
  }

  // Assosiated with submitPlacementForm method
  private returnLivingarrangementtypekeyFn() {
    return (this.placementForm.get('livingarrangementtypekey')?.value &&
      (this.placementForm.get('livingarrangementtypekey')?.value === "IMC" ||
        this.placementForm.get('livingarrangementtypekey')?.value === "PSYH")
      && this.hospitalizationFormValues["Hospital_ERexamination"]);
  }
  // Assosiated with submitPlacementForm method
  private returnSubmitPlacementDataFn() {
    const startDate: any = this.placementForm.getRawValue().startdate;
    const startTime: any = this.placementForm.getRawValue().starttime;

    const { enddate, endtime } = this.returnDataForEndDtaeAndTimeFn();

    const placement: any = this.returnSelectedChildFilterDataFn();
    const { lastEndDate, 
      placementEndDt, 
      firstStartDate, 
      placementStartDt, 
      placementsTemp, 
      islaoverlap } = this.handleSelectedChildrenLoopFn(startDate, startTime, enddate, endtime);
    const isLastEndDate = (lastEndDate === null);
    const isOpenRecord = (placementEndDt === null);
    const placementEndDtF = placementEndDt ? placementEndDt : lastEndDate;
    const isBackDate = this.returnIsBackDateDataFn(firstStartDate, placementStartDt, placementEndDtF, lastEndDate);
    return { isBackDate, placementsTemp, firstStartDate, placementStartDt, placement, islaoverlap, isOpenRecord, isLastEndDate };
  }
  // Assosiated with submitPlacementForm method
  private handleSelectedChildrenLoopFn(startDate: any, startTime: any, enddate: any, endtime: any) {
    let placementsTemp = false;
    let islaoverlap = false;
    const placementStartDt = this.getPlacementStartDt(startDate, startTime);
    const placementEndDt = this.returnPlacementEndDtDataFn(enddate, endtime);
    let firstStartDate: any = null;
    let lastEndDate: any = null;
    let livKey = this.placementForm.get('livingarrangementtypekey')?.value;
    this.selectedChildren?.forEach((child) => {   // NOSONAR    // This function has less than 15 complex conditions. Hence marking it as no sonar.
      if (child.placements && child.placements.length > 0) {
        let currrentPlacements = child.placements.filter((childc: any) => childc && (livKey !== 'RFKH' && (childc.livingarrangementtypekey === 'ERM' || childc.livingarrangementtypekey === 'ERP' || childc.livingarrangementtypekey === 'IMC' || childc.livingarrangementtypekey === 'PSYH')) || (livKey === 'RFKH' && childc.livingarrangementtypekey === 'RFKH'));
        if (currrentPlacements && currrentPlacements.length > 0) {
          currrentPlacements.forEach((place: any) => {
            let placStatDt = place.startdate;
            let placEndDt = place.enddate;
            const placStatTime = place.starttime;
            const placEndTime = place.endtime;
            placStatDt = this.getPlacStatDt(placStatDt, placStatTime);
            placEndDt = this.getPlacEndDt(placEndDt, placEndTime);
            if (!placEndDt && place.livingenddate) {
              placEndDt = place.livingenddate;
            }
            if (this.checkAndReturnFirstStartDateCondFn(firstStartDate, placStatDt)) {
              firstStartDate = placStatDt;
            }
            if (this.checkAndReturnIfPlacEndDtFn(placEndDt, lastEndDate)) {
              lastEndDate = placEndDt;
            }
            if (this.returnPlacementsTempIfTrueFn(place)) {
              placementsTemp = true;
            }
            islaoverlap = this.isLAOverlap(place, placementStartDt, placementEndDt, placStatDt, placEndDt, islaoverlap);
          });
        }
      }
    });
    return { lastEndDate, placementEndDt, firstStartDate, placementStartDt, placementsTemp, islaoverlap };
  }
  // Assosiated with submitPlacementForm method
  private returnPlacementEndDtDataFn(enddate: any, endtime: any) {
    return enddate && endtime ? this.getPlacementEndDt(enddate, endtime) : null;
  }
  // Assosiated with submitPlacementForm method
  private checkAndReturnIfPlacEndDtFn(placEndDt: any, lastEndDate: any) {
    return placEndDt && (lastEndDate == null || (new Date(placEndDt).getTime() > new Date(lastEndDate).getTime()));
  }
  // Assosiated with submitPlacementForm method
  private checkAndReturnFirstStartDateCondFn(firstStartDate: any, placStatDt: any) {
    return firstStartDate == null || (new Date(placStatDt).getTime() < new Date(firstStartDate).getTime());
  }
  // Assosiated with submitPlacementForm method
  private returnIsBackDateDataFn(firstStartDate: any, placementStartDt: any, placementEndDtF: any, lastEndDate: any) {
    return firstStartDate && !this.hospitalizationFormValues['Hospital_DischargedDate'] && 
    this.placementForm.get('livingarrangementtypekey')?.value !== 'RFKH' && ((new Date(placementStartDt).getTime() < new Date(firstStartDate).getTime()) || (new Date(placementEndDtF).getTime() < new Date(lastEndDate).getTime()));
  }
  // Assosiated with submitPlacementForm method
  private returnPlacementsTempIfTrueFn(place: any) {
    return (place && (place.enddate === null && (place.livingarrangementtypekey === this.placementForm.getRawValue().livingarrangementtypekey.trim()) && place.routingstatus !== 'Rejected'));
  }
  // Assosiated with submitPlacementForm method
  private returnOpenhospitalizationlaIsTrueFn(place: any) {
    return (place && place.enddate === null && (place.livingarrangementtypekey === 'ERM' || place.livingarrangementtypekey === 'ERP' || place.livingarrangementtypekey === 'IMC' || place.livingarrangementtypekey === 'PSYH'));
  }
  // Assosiated with submitPlacementForm method
  private returnSelectedChildFilterDataFn() {
    if (this.selectedChildren?.[0]?.placement) {
      const livingArrangementKey = this.placementForm.get('livingarrangementtypekey')?.value?.trim();
      const validKeys = ['ERM', 'ERP', 'IMC', 'PSYH'];
  
      return this.selectedChildren.filter((child) => {
        const placement = child?.placement;
        const isEndDateNull = placement?.enddate === null;
        const isValidArrangement =
          (livingArrangementKey !== 'RFKH' && validKeys.includes(placement?.livingarrangementtypekey)) ||
          (livingArrangementKey === 'RFKH' && placement?.livingarrangementtypekey === 'RFKH');
        return isEndDateNull && isValidArrangement;
      });
    }
  
    this.doesPlacementExist = this.selectedChildren?.[0]?.placements?.[0]; //

    if (this.doesPlacementExist) {
      const livingArrangementKey = this.placementForm.get('livingarrangementtypekey')?.value?.trim();
      const validKeys = livingArrangementKey === 'RFKH' ? ['RFKH'] : ['ERM', 'ERP', 'IMC', 'PSYH'];
  
      return this.selectedChildren.filter((child) => {
        const approvedPlacements = child?.placements?.filter(
        (placement: any) => 
          placement?.routingstatus === 'Approved' && 
          validKeys.includes(placement?.livingarrangementtypekey)
      );
      return approvedPlacements?.some((placement: any) => {
        const isEndDateNull = placement?.enddate === null;
        const isValidArrangement =
          (livingArrangementKey !== 'RFKH' && validKeys.includes(placement?.livingarrangementtypekey)) ||
          (livingArrangementKey === 'RFKH' && placement?.livingarrangementtypekey === 'RFKH');
        return isEndDateNull && isValidArrangement;
      });
    });
    }
  }
  // Assosiated with submitPlacementForm method
  private returnDataForEndDtaeAndTimeFn() {
    const endDateValue = this.hospitalizationFormValues['Hospital_DischargedDate'] ? this.hospitalizationFormValues['Hospital_DischargedDate'] : null;
    const endTimeValue = this.hospitalizationFormValues['Hospital_DischargedDate'] ? this.hospitalizationFormValues['Hospital_DischargedDate_starttime'] : null;
    const enddate = this.placementForm.getRawValue().enddate ? this.placementForm.getRawValue().enddate : endDateValue;
    const endtime = this.placementForm.getRawValue().endtime ? this.placementForm.getRawValue().endtime : endTimeValue;
    return { enddate, endtime };
  }

  getPlacementStartDt(startDate: any, startTime: any) {
    let placementStartDt = startDate;
    if (startDate && startTime) {
      const formatStDt = moment(startDate).format(this.dtformat);
      placementStartDt = formatStDt + 'T' + startTime + ':00';
    }
    return placementStartDt;
  }

  getPlacementEndDt(enddate: any, endtime: any) {
    let placementEndDt = enddate;
    if (enddate && endtime) {
      const formatEndDt = moment(enddate).format(this.dtformat);
      placementEndDt = formatEndDt + 'T' + endtime + ':00';
    }
    return placementEndDt;
  }

  getPlacStatDt(placStatDt: any, placStatTime: any) {
    if (placStatDt && placStatTime) {
      const formatPlacStartDt = moment(placStatDt).format(this.dtformat);
      let formatStartTime = placStatTime;
      if (placStatTime.length > 5) {
        const plcStartTime = new Date(placStatTime);
        formatStartTime = moment(plcStartTime).format('HH:mm');
      }
      placStatDt = formatPlacStartDt + 'T' + formatStartTime + ':00';
    }
    return placStatDt;
  }

  getPlacEndDt(placEndDt: any, placEndTime: any) {
    if (placEndDt && placEndTime) {
      const formatPlacEndDt = moment(placEndDt).format(this.dtformat);
      let formatEndTime = placEndTime;
      if (placEndTime.length > 5) {
        const plcEndTime = new Date(placEndTime);
        formatEndTime = moment(plcEndTime).format('HH:mm');
      }
      placEndDt = formatPlacEndDt + 'T' + formatEndTime + ':00';
    }
    return placEndDt;
  }
  isLAOverlap(place: any, placementStartDt: any, placementEndDt: any, placStatDt: any, placEndDt: any, islaoverlap: any) {
    const livingArrangementKey = this.placementForm.getRawValue().livingarrangementtypekey.trim();
    const isLivingArrangementKey = (livingArrangementKey === 'ERM' || livingArrangementKey === 'ERP' || livingArrangementKey === 'IMC' || livingArrangementKey === 'PSYH' || livingArrangementKey === 'RFKH');
    const isPlaceLivingArrangementKey = (place && (place.livingarrangementtypekey === 'ERM' || place.livingarrangementtypekey === 'ERP' || place.livingarrangementtypekey === 'IMC' || place.livingarrangementtypekey === 'PSYH' || place.livingarrangementtypekey === 'RFKH'));
    if (isLivingArrangementKey) {
      if (((isPlaceLivingArrangementKey 
      && ((placementStartDt >= placStatDt && placementStartDt <= placEndDt) 
      || (placementEndDt >= placStatDt && placementEndDt <= placEndDt)))
        || (isPlaceLivingArrangementKey 
        && ((placStatDt >= placementStartDt && placStatDt <= placementEndDt) 
        || (placEndDt >= placementStartDt && placStatDt <= placementEndDt)))) || (isPlaceLivingArrangementKey && placementEndDt == null && placEndDt == null && placementStartDt <= placStatDt)) {
        islaoverlap = true;
      }
    }
    return islaoverlap;
  }

  isError(placement: any, islaoverlap: any, placements: any, isBackDate: any, isOlderRecord: any, isOpenRecord: any, isLastEndDate: any) {
    const livingArrangementKey = this.placementForm.getRawValue().livingarrangementtypekey;
    const isLivingArrangementKey = this.returnIsLivingArrangementKeyFn(livingArrangementKey);
    if (isLivingArrangementKey) {
      if (this.checkPrimaryCaregiverContactInfoFn()) {
        this._alertService.error('Please Enter Primary Caregiver Contact Information in the Person Card before proceeding');
        this.sendforapprovaldisabled = false;
        return true;

      } else
      if (placement?.length || placements) {
        if(this.handleIfPlacementsFn(isBackDate, isLivingArrangementKey, islaoverlap, isOlderRecord, isOpenRecord, isLastEndDate)) {
          return true;
        }
      } else if (islaoverlap) {
          if (isLastEndDate) {
            this.openRecordPop(isLivingArrangementKey);
            return true;
          }
          this.overLapRecordPop(isLivingArrangementKey);
          return true;
        }
    }
    return false;
  }
  // Assosiated with isError method
  private handleIfPlacementsFn(isBackDate: any, isLivingArrangementKey: any, islaoverlap: any, isOlderRecord: any, isOpenRecord: any, isLastEndDate: any) {
    if (isBackDate) {
      this.openRecordPop(isLivingArrangementKey);
      return true;
    } else if (islaoverlap) {
      if (!isOlderRecord) {
        this.openRecordPop(isLivingArrangementKey);
        return true;
      } else {
        this.overLapRecordPop(isLivingArrangementKey);
        this.sendforapprovaldisabled = false;
        return true;
      }
    } else if (!isOlderRecord) {
      if (isOpenRecord && 
        this.placementForm.get('livingarrangementtypekey')?.value !== 'RFKH') {
        this._alertService.error('Please enter the discharge/exit date as this open exit date overlaps with other existing Hospitalization Living Arrangement record');
        return true;
      } else if (isLastEndDate || (isOpenRecord && 
        this.placementForm.get('livingarrangementtypekey')?.value === 'RFKH')) {
        this.openRecordPop(isLivingArrangementKey);
        return true;
      }
    }
    return false;
  }
  // Assosiated with isError method
  private returnIsLivingArrangementKeyFn(livingArrangementKey: any) {
    return livingArrangementKey === 'ERM' || livingArrangementKey === 'ERP' || livingArrangementKey === 'IMC' || livingArrangementKey === 'PSYH' || livingArrangementKey === 'RFKH';
  }
  // Assosiated with isError method
  private checkPrimaryCaregiverContactInfoFn() {
    return this.placementForm.controls['add1']?.invalid || this.placementForm.controls['statetypekey']?.invalid
      || this.placementForm.controls['countytypekey']?.invalid || this.placementForm.controls['zipcode']?.invalid;
  }

  overLapRecordPop(isLivingArrangementKey: any) {
    if(isLivingArrangementKey && this.placementForm.getRawValue().livingarrangementtypekey !== 'RFKH') {
      this._alertService.error('Please enter the dates correctly as selected dates are overlapping with other existing Living Arrangement');
    } else {
      this._alertService.error('The user must end the older Living Arrangement before the user can leave the screen');
    }
  }
  openRecordPop(isLivingArrangementKey: any) {
    if(isLivingArrangementKey && this.placementForm.getRawValue().livingarrangementtypekey !== 'RFKH') {
      this._alertService.error('Overlapping Hospitalization Living Arrangement is not allowed, Please Discharge/End the Active record to create a new one.');
    } else {
      this._alertService.error('The user must end the older Living Arrangement before the user can leave the screen');
    }
  }
  formatTime(time: any) {
    time =  moment(new Date(time)).format('HH:mm');
    return time;
  }

  concateDateTime(date: any,time: any){
    date =  date.split(" ")[0] + " " + time + ":00";
    return date;
   }

  sendApprovalInQueue() {
    const currentTime = moment(new Date()).format("HH:mm");
    const currentDate = moment(new Date()).format(this.dtformat);
    const givenDate = moment(this.placementForm.getRawValue().startdate).format(this.dtformat);
    const givenTime = this.placementForm.getRawValue().starttime;

    if (this._ServiceCasePlacementsService.selectedChildren.length === 0) {
      this._alertService.error('Please select the children');
      this.sendforapprovaldisabled = false;
    }

    if (this.placementForm.value.placementtypekey === 'LA' && givenTime !== null && currentTime < givenTime && currentDate === givenDate) {
      this._alertService.error('Start date & time should be less than the current time');
      this.placementForm.patchValue({ starttime: null });
      this.sendforapprovaldisabled = false;
    }

    let formData = this.placementForm.getRawValue();
    formData.placementtypekey = 'LA';
    formData.startdate = this.convertMatinputTimeToTimestamp(formData.startdate, formData.starttime);
    if (formData.endtime) {
      formData.enddate = this.convertMatinputTimeToTimestamp(formData.enddate, formData.endtime);
    }
    if(this.loadHospitalForms) {
      formData = this.handleToLoadHospitalFormsFn(formData);
    }

  const startDate = new Date(formData["startdate"]).getTime();
  const dischargeDate = this.hospitalizationFormValues["Hospital_DischargedDate"]
    ? new Date(this.hospitalizationFormValues["Hospital_DischargedDate"]).getTime()
    : null;
  
  if (dischargeDate && dischargeDate <= startDate) {
    this._alertService.error("Discharge / Exit date & time should be greater than the start date & time");
    this.sendforapprovaldisabled = false;
    return; 
  }
    this._ServiceCasePlacementsService.sendApprovalInQueue(formData);
  
  }
  // Assosiated with sendApprovalInQueue method
  private handleToLoadHospitalFormsFn(formData: any) {
    if (this.hospitalizationFormValues["Hospital_ERexamination"]) {
      this.hospitalizationFormValues["Hospital_examStartDate"] = this.hospitalizationFormValues["Hospital_examStartDate"] ? this.concateDateTime(moment(new Date(this.hospitalizationFormValues["Hospital_examStartDate"])).format('YYYY-MM-DD hh:mm A'), this.hospitalizationFormValues["Hospital_examStartDate_starttime"]) : null;
    } else {
      this.hospitalizationFormValues["Hospital_examStartDate"] = null;
    }

    if (this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"]) {
      this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"] = this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"] ? this.concateDateTime(moment(new Date(this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"])).format('YYYY-MM-DD hh:mm A'), this.hospitalizationFormValues["Hospital_InpatientAdmissionDate_starttime"]) : null;
    } else {
      this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"] = null;
    }

    if (this.hospitalizationFormValues["Hospital_Discharged"]) {
      this.hospitalizationFormValues["Hospital_DischargedDate"] = this.hospitalizationFormValues["Hospital_DischargedDate"] ? this.concateDateTime(moment(new Date(this.hospitalizationFormValues["Hospital_DischargedDate"])).format('YYYY-MM-DD hh:mm A'), this.hospitalizationFormValues["Hospital_DischargedDate_starttime"]) : null;
    } else {
      this.hospitalizationFormValues["Hospital_DischargedDate"] = null;
    }



    formData.placementtypekey = "LA";
    formData.contactname = null;
    formData.caregiverclientid = this.personId;
    formData.primarycaregiver = this.hospitalizationFormValues["Hospital_name"];
    formData.partnerid = null;
    formData.secondarycaregiver = null;
    formData.primaryrelationship = null;
    formData.remarks = null;
    formData.contactphone = null;
    formData.workphone = null;
    formData.enddate = this.hospitalizationFormValues['Hospital_DischargedDate'] ? moment(new Date(this.hospitalizationFormValues['Hospital_DischargedDate'])).format(this.dtformat2) : null;
    formData.add1 = this.hospitalizationFormValues["Hospital_address1"];
    formData.add2 = this.hospitalizationFormValues["Hospital_address2"];
    formData.cityname = this.hospitalizationFormValues["Hospital_city"];
    formData.statetypekey = this.hospitalizationFormValues["Hospital_state"];
    formData.zipcode = this.hospitalizationFormValues["Hospital_zipcode"];
    formData.countytypekey = this.hospitalizationFormValues["Hospital_country"];
    formData.runawayreported = null;
    formData.runawayreportnumber = null;
    formData.runawaynotreportedreason = null;
    formData.endtime = this.hospitalizationFormValues['Hospital_DischargedDate_starttime'];
    formData.whereabouts = null;
    formData.country = null;
    formData.tribalservicearea = null;
    formData.fostercarehome = null;
    formData.fostercarenonfoster = null;
    formData.ratetype = null;
    formData.fostercomments = null;
    formData.health = this.hospitalizationFormValues;

    return formData;
  }

  convertMatinputTimeToTimestamp(date: any, time: any) {
    return moment(moment(date).format('MM/DD/YYYY') + ' ' + time).format();
  }

  onDailyAmountChange(event:  any, key: any) {
    const amount: any = event.target.value;
    if (!_.isNaN(_.toNumber(amount)) && key == 1) {
      this.placementForm.patchValue ({
        dailyrate : _.toNumber(amount).toFixed(2)
      });
    } else if (!_.isNaN(_.toNumber(amount)) && key == 2) {
      this.placementForm.patchValue ({
        agency1to1rate : _.toNumber(amount).toFixed(2)
      });
    }
  }

  resetUnwantedControls(formValues: any) {
    if (formValues.livingarrangementtypekey === PlacementConstants.RUN_AWAY) {
      formValues.contactname = null;
      formValues.startdate = null;
      formValues.remarks = null;
      formValues.contactphone = null;
      formValues.workphone = null;
      formValues.enddate = null;
      formValues.add1 = null;
      formValues.add2 = null;
      formValues.cityname = null;
      formValues.hotelorother = null;
      formValues.agency1to1 = null;
      formValues.agency1to1desc = null;
      formValues.agency1to1explaination = null;
      formValues.dailyrate = null;
      formValues.statetypekey = null;
      formValues.zipcode = null;
      formValues.countytypekey = null;
    } else {
      formValues.runawayreported = null;
      formValues.runawayreportnumber = null;
      formValues.runawaynotreportedreason = null;
    }
    return formValues;
  }

  loadHospitalForms = false;
  onLivingArrangementChange() {
    const openHospitalRecords = false;
    const livingArrangementKey = this.placementForm?.getRawValue()?.livingarrangementtypekey;
    if (livingArrangementKey &&
      (livingArrangementKey === 'ERM' ||
        livingArrangementKey === 'ERP' ||
        livingArrangementKey === "IMC" ||
        livingArrangementKey === "PSYH")) {
      this.removeControls();
      ($('#hospitalization-info') as any).modal('show');  //NOSONAR
      this.loadHospitalForms = true;
      this.getHospitalizationList(this.selectedPersonId)
    } else {
      if(livingArrangementKey !== 'FCNFHS') {
         this.placementForm.get("fostercarenonfoster")?.clearValidators();
         this.placementForm.get("fostercarenonfoster")?.updateValueAndValidity();
         this.placementForm.get("ratetype")?.clearValidators();
         this.placementForm.get("ratetype")?.updateValueAndValidity();
      }
      this.handleOnLivingArrangementChanceElseCondFn(openHospitalRecords, livingArrangementKey);
    }
  }
  // Assosiated with onLivingArrangementChange method
  private handleOnLivingArrangementChanceElseCondFn(openHospitalRecords: boolean, livingArrangementKey: any) {
    this.selectedChildren.forEach((field) => {
      if (field && field.placements && field.placements.length) {
        field.placements.forEach((item: { enddate: null; livingarrangementtypekey: string; }) => {
          if (item?.enddate == null && (item?.livingarrangementtypekey === 'ERM' || item?.livingarrangementtypekey === 'ERP' || item?.livingarrangementtypekey === 'IMC' || item?.livingarrangementtypekey === 'PSYH')) {
            openHospitalRecords = true;
            return true;
          }
          return false
        });
      }

    });

    this.loadHospitalForms = false;
    this.addControls();
    if (livingArrangementKey.trim() === 'RFKH') {
      this.readOnly = true;
    } else {
      this.readOnly = false;
    }

    if (livingArrangementKey === PlacementConstants.RUN_AWAY) {
      this.isRunaway = true;
      this.placementForm.patchValue({
        whereabouts: 'unknown',
        fostercarehome: null,
        fostercomments: null,
        fostercarenonfoster: null,
        laluggagecomments: null,
        livingarrangementluggage: null,
        laluggagepurchased:null

      });
      this.placementForm.get('laluggagepurchased')?.clearValidators();
      this.placementForm.get('laluggagepurchased')?.updateValueAndValidity();
      this.placementForm.get('laluggagecomments')?.clearValidators();
      this.placementForm.get('laluggagecomments')?.updateValueAndValidity();
      this.placementForm.get('fostercarenonfoster')?.clearValidators();
      this.placementForm.get('fostercarenonfoster')?.updateValueAndValidity();
      this.placementForm.get('fostercomments')?.clearValidators();
      this.placementForm.get('fostercomments')?.updateValueAndValidity();
      this.placementForm.get('fostercarehome')?.clearValidators();
      this.placementForm.get('fostercarehome')?.updateValueAndValidity();
      this.placementForm.get('livingarrangementluggage')?.clearValidators();
      this.placementForm.get('livingarrangementluggage')?.updateValueAndValidity();
    } else {
      this.isRunaway = false;
    }

    this.relationShipDropdownItems = JSON.parse(JSON.stringify(this.copyRelationShipDropdownItems));
    this.handleLivingArrangementFn(livingArrangementKey, openHospitalRecords);
  }
  // Assosiated with onLivingArrangementChange method
  private handleLivingArrangementFn(livingArrangementKey: any, openHospitalRecords: boolean) {
    const primaryrelationshipControl = this.placementForm.get('primaryrelationship');
    const caregiverGlientId = this.placementForm.get('caregiverclientid');
    if (livingArrangementKey.trim() == "FCH" || livingArrangementKey.trim() == "RFKH" || livingArrangementKey.trim() == "REC" || livingArrangementKey.trim() == "SHA" || livingArrangementKey.trim() == "TVH" || livingArrangementKey.trim() == "OHA") {
      this.placementForm.patchValue({
        primaryrelationship:null

      });
      primaryrelationshipControl?.clearValidators();
      primaryrelationshipControl?.setValidators(Validators.required);
      primaryrelationshipControl?.updateValueAndValidity();
      this.test = true;
      primaryrelationshipControl?.markAsTouched({ onlySelf: true });
      this.relationShipDropdownItems = this.relationShipDropdownItems.filter(item => item.relationshiptypekey == 'Kin' || item.relationshiptypekey == 'Relative' || item.relationshiptypekey == 'NORELTVE');
    } else {
      primaryrelationshipControl?.setErrors(null);
      primaryrelationshipControl?.setValidators(null);
      primaryrelationshipControl?.markAsUntouched();
      caregiverGlientId?.setErrors(null);
      caregiverGlientId?.setValidators(null);
      caregiverGlientId?.markAsUntouched();
    }

    this.placementForm.patchValue({
      fostercarehome: null,
      fostercarenonfoster: null,
      fostercomments: null
    });

    if (openHospitalRecords) {
      ($('#hospitalization-open') as any).modal('show');  //  NOSONAR
    }
  }

    showHospitalizationFormFields(){
      return this.placementForm.get('livingarrangementtypekey')?.value == 'ERM' ||  this.placementForm.get('livingarrangementtypekey')?.value == 'ERP'
      || this.placementForm.get('livingarrangementtypekey')?.value == 'IMC' || this.placementForm.get('livingarrangementtypekey')?.value == 'PSYH'
    }

    removeObjRelationShipDropdownItems(key: any) {
      const index = this.relationShipDropdownItems.findIndex(x => x.relationshiptypekey === key);
      this.relationShipDropdownItems.splice(index, 1);
  }

  onRunawayReportedChange() {
    const isRunawayReported = this.placementForm.getRawValue().runawayreported;
    if (isRunawayReported === 'YES') {
      this.isRunawayReported = true;
    } else {
      this.isRunawayReported = false;
    }
  }

  tsaSelectionChange() {
    const tribalservicearea: any = this.placementForm.getRawValue().tribalservicearea;
    const statetypekey: any = this.placementForm.get('statetypekey');
    const countytypekey: any = this.placementForm.get('countytypekey');
    const zipcode: any = this.placementForm.get('zipcode');

    if(tribalservicearea) {
      this.disabletsafields = false;
      statetypekey.clearValidators();
      countytypekey.clearValidators();
      zipcode.clearValidators();
      statetypekey.updateValueAndValidity();
      countytypekey.updateValueAndValidity();
      zipcode.updateValueAndValidity();
    } else {
      this.disabletsafields = true;
    }
  }

  timechange() {

    const currentTime = moment(new Date()).format("HH:mm");
    const currentDate = moment(new Date()).format(this.dtformat);
    const givenDate = moment(this.placementForm.getRawValue().startdate).format(this.dtformat);
    const givenTime = this.placementForm.getRawValue().starttime;

    if (givenTime !== null && currentTime < givenTime && currentDate === givenDate) {
      this._alertService.error('Start date & time should be less than the current time');
      this.placementForm.patchValue({ starttime: null });
    }
  }

  editPerson() {
    const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._httpService
    .getPagedArrayList(
        new PaginationRequest({
            where: { objectid: id, personid: this.personId },
            method: 'get',
            nolimit: true
        }),
        'Personprogramareas/getpersonprogramarea?filter'
    )
    .subscribe((result) => {
        if (result && Array.isArray(result) && result.length) {
            const programAsssignList = result[0];
            if(programAsssignList !== null && programAsssignList.personprogramarea !== null) {
              const programAreaOohList = programAsssignList.personprogramarea.filter((item: { programkey: string; }) => item.programkey === "OOH");
              const isActiveOoh = this.isActiveOOH(programAsssignList);
              this._service.editPerson(this.personId, (programAreaOohList.length > 0) ? true : false, isActiveOoh);
            } else {
              this._service.editPerson(this.personId, false);
            }
        }
    });
  }

  isActiveOOH(programAsssignList: any) {
    const programAreaOohList = programAsssignList.personprogramarea.filter((item: { programkey: string; }) => item.programkey === "OOH");
    let isActiveOoh = false;
    if (programAreaOohList && programAreaOohList.length > 0) {
      programAreaOohList.map((element: { enddate: null; }) => {
        if (element.enddate === null) {
          isActiveOoh = true;
        }
      })
    }
    return isActiveOoh;
  }

  onFostercareHomeChange(){
    this.placementForm.patchValue({
      fostercomments :null
    });
    const fosterComments: any = this.placementForm.get('fostercomments');
    if (this.placementForm.controls['fostercarehome'].value === 'UOther') {
      fosterComments.setValidators(Validators.required);
    } else if (this.placementForm.controls['livingarrangementtypekey'].value === 'FCNFHS') {
      this.placementForm.get('fostercarehome')?.clearValidators();
      this.placementForm.get('fostercarehome')?.updateValueAndValidity();
     if (this.placementForm.controls['fostercarenonfoster'].value !==  'HOTEL') {
      this.placementForm.get("agency1to1")?.clearValidators();
      this.placementForm.get("agency1to1desc")?.clearValidators();
      this.placementForm.get("agency1to1explaination")?.clearValidators();
      this.placementForm.get("dailyrate")?.clearValidators();
      this.placementForm.get("ratetype")?.clearValidators();
      this.placementForm.get("ratetype")?.updateValueAndValidity();
      this.placementForm.get("agency1to1rate")?.clearValidators();
      this.placementForm.get("agency1to1rate")?.updateValueAndValidity();
      this.placementForm.get("dailyrate")?.updateValueAndValidity();
      this.placementForm.get("agency1to1")?.updateValueAndValidity();
      this.placementForm.get("agency1to1desc")?.updateValueAndValidity();
      this.placementForm.get("agency1to1explaination")?.updateValueAndValidity();


      this.placementForm.patchValue({
        agency1to1: null,
        agency1to1desc: null,
        agency1to1explaination: null,
        dailyrate: null,
        ratetype: null,
        agency1to1rate: null
      });
     } 
     if (this.placementForm.controls['fostercarenonfoster'].value !==  'OTHER') {
      this.placementForm.get("fostercomments")?.clearValidators();
      this.placementForm.get("fostercomments")?.updateValueAndValidity();

     }

    }  else {
      this.placementForm.get("fostercarenonfoster")?.clearValidators();
      this.placementForm.get("fostercarenonfoster")?.updateValueAndValidity();
      fosterComments.setErrors(null);
      fosterComments.setValidators(null);
      fosterComments.markAsUntouched();
    }
  }

  agency1to1change() {
    if (this.placementForm.controls['fostercarenonfoster'].value ===  'HOTEL') {
      if(this.placementForm.controls['agency1to1'].value) {
        this.placementForm.get("agency1to1explaination")?.clearValidators();
        this.placementForm.get("agency1to1explaination")?.updateValueAndValidity();
        this.placementForm.patchValue({
          agency1to1explaination: null
        });
      } else if (!this.placementForm.controls['agency1to1'].value) {
        this.placementForm.get("agency1to1desc")?.clearValidators();
        this.placementForm.get("agency1to1desc")?.updateValueAndValidity();
        this.placementForm.get("ratetype")?.clearValidators();
        this.placementForm.get("ratetype")?.updateValueAndValidity();
        this.placementForm.get("agency1to1rate")?.clearValidators();
        this.placementForm.get("agency1to1rate")?.updateValueAndValidity();

        this.placementForm.patchValue({
          agency1to1desc: null,
          ratetype: null,
          agency1to1rate: null
        });
      }
    }
  }

  luggagebuttonreset(value: any){

    if(value ===1){
      this.placementForm.patchValue({
       laluggagepurchased :null,
       laluggagecomments:null,
       ladisposableortrashbag:null
      })
      const luggagepurchased: any = this.placementForm.get('laluggagepurchased');
      luggagepurchased.clearValidators();
      luggagepurchased.updateValueAndValidity();
      
    }
      if(value ===2){
        this.placementForm.patchValue({
          laluggagecomments:null,
          ladisposableortrashbag:null
         })

      }
      const luggagecomments: any = this.placementForm.get('laluggagecomments');
      luggagecomments.clearValidators();
      luggagecomments.updateValueAndValidity();
      const ladisposableortrashbag: any =this.placementForm.get('ladisposableortrashbag');
      ladisposableortrashbag.clearValidators();
      ladisposableortrashbag.updateValueAndValidity();

  }

  hospitalizationTypes: any[] = [];  

getHospitalizationList(selectedPersonId: any) {
  this._httpService.getPagedArrayList({
    method: 'get',
    where: { personid: selectedPersonId }
  }, 'personhospitalization/list?filter').subscribe(res => {
    if (res && res.data && Array.isArray(res.data)) {
      res.data.forEach((data) => {
        this.hospitalizationTypes.push(data);
      });
    }
    this.hospitalizationTypes.unshift({
      Hospital_name : "Add Hospitalization"
    });
  });
}
 
  onHospitalizationTypeChange(event: any) {

    this.hospitalizationData = event['value'];
    this.hospitalizationData = this.hospitalizationTypes.filter((data)=>{
      return data['Hospital_name'] === event['value']
    });
    this.hospitalizationData = this.hospitalizationData[0];
    this.hospitalizationFormValues = JSON.parse(JSON.stringify(this.hospitalizationData))
    this.loadHospitalForms = true;
    if(this._ServiceCasePlacementsService['placementDetails'] && this._ServiceCasePlacementsService['placementDetails'][0] ){
      this._ServiceCasePlacementsService['placementDetails'][0]['viewMode'] = false;
    }

    
  }

  updateHospitalizationFormValues(event: any){
    this.hospitalizationFormValues = event;
    if(this.hospitalizationFormValues["Hospital_Discharged"]) {
      this.placementForm.get("exittypekey")?.setValidators([Validators.required]);
      this.placementForm.get("leastrestrictiveplacement")?.setValidators([Validators.required])
     
    } else {
      this.placementForm.get("exittypekey")?.clearValidators();
      this.placementForm.get("leastrestrictiveplacement")?.clearValidators();
     
    }
    this.placementForm.get("exittypekey")?.updateValueAndValidity();
    this.placementForm.get("leastrestrictiveplacement")?.updateValueAndValidity();
  }

  
  setExitEntryValidation(){
    // No data or function to add or call
  }

  reasonForExitRequired = false;
  reasonsForExit: any[] = [];
  reasonforexit : any;
  commentsRequired = false;
  exitReasonKey: any;
  onExitTypeChange(status: any) {
    const exitTypeKey = this.placementForm.getRawValue().exittypekey;
    if (status) {
      this.placementForm.patchValue({
        exitreasontypekey: null
      });
    }
    if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
      this.handleIfHasExitTypeKeyFn(status, exitTypeKey);
    } else {
      this.reasonForExitRequired = false;
      this.placementForm.get('exitreasontypekey')?.disable();
      this.reasonsForExit = [];
    }
    if (PlacementConstants.EXIT_TYPES.OTHER === exitTypeKey) {
     this.commentsRequired = true;
    } else {
      this.commentsRequired = false;
    }
  }
  // Assosiated with onExitTypeChange method
  private handleIfHasExitTypeKeyFn(status: any, exitTypeKey: any) {
    this.reasonForExitRequired = true;
    this.placementForm.patchValue({
      exitreasontypekey: this.getexitreasontypekey(status)
    });
    this.placementForm.get('exitreasontypekey')?.enable();
    if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
      this.exitService.getReasonForExit(exitTypeKey).subscribe(result => {
        if (result && result.length) {
          this.reasonsForExit = result;
        }
      });
    }
  }

  getexitreasontypekey(status: any){
    return (this.exitReasonKey && !status) ? this.exitReasonKey : null;
  }


  getHospitalizationForm(event: any){
    this.hospitalizationFormStatus = event
  }

  handleSartDateTimeEvent(event: any){
    if(event.time) {
      this.placementForm.get('starttime')?.patchValue(event.time)
    } 
    else if(event.date) {
      this.placementForm.get('startdate')?.patchValue(new Date(event.date))
    }

    this.placementForm.updateValueAndValidity();
  }

}
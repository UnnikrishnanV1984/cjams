import { Component, OnInit, Output, EventEmitter, Injector } from '@angular/core';
import { Observable ,  forkJoin } from 'rxjs';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DataStoreService, CommonDropdownsService, AlertService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { ControlUtils } from '../../../../../@core/common/control-utils';
import { LivingArrangementDetailsService } from '../living-arrangement-details.service';
import { PersonInfoService } from '../../person-info.service';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import moment from 'moment';

@Component({
    selector: 'add-living-arrangement',
    templateUrl: './add-living-arrangement.component.html',
    styleUrls: ['./add-living-arrangement.component.scss'],
    standalone: false
})

export class AddLivingArrangementComponent implements OnInit {
  livingArrangementForm!: FormGroup ;
  referalForm!: FormGroup ;
  minDate: any=[];
  mandatoryField: boolean = false;
  maxDate: any=[];
  maxTime: any=[];
  addressList = [{}];
  endMinDate: any=[];
  countyDropDownItems:any = [];
  stateDropDownItems :any= [];
  livingDropDownItems :any= [];
  selectedChildren: any[] = [];
  isRunaway:boolean = false;
  isRunawayReported:boolean = false;
  isClosed:boolean = false;
  suggestedAddress$!: Observable<any[]>;
  caregiverPersonsList: any[] = [];
  caregiverPersonsList2: any[] = [];
  primaryselected: boolean = false;
  secondaryselected: boolean = false;
  personsList: any[] = [];
  relationShipDropdownItems: any[] = [];
  sendforapprovaldisabled:boolean= false;
  personId: any;
  isView = false;

  showPrimaryCareGiverAddress: boolean = false;
  showSecondaryCareGiverAddress: boolean = false;
  primaryCareGiverCjamsPid : any;
  secondaryCareGiverCjamsPid : any;
  primaryCareGiverAddress : any;
  secondaryCareGiverAddress : any;
  primaryCareGiverPhone : any;
  secondaryCareGiverPhone : any;
  dtformat = 'YYYY-MM-DD';
  @Output() addflag: EventEmitter<boolean> = new EventEmitter();

  private _commonHttpService: CommonHttpService;
  private _dropDownService: CommonDropdownsService;
  private formBuilder: FormBuilder;
  private _alertService: AlertService;
  private _livingArrangementDetailsService: LivingArrangementDetailsService;
  private _personService: PersonInfoService; 
  private _dataStoreService: DataStoreService;
  private _httpService: CommonHttpService;

  constructor(private injector:Injector){
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._dropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._livingArrangementDetailsService = this.injector.get<LivingArrangementDetailsService>(LivingArrangementDetailsService);
    this._personService = this.injector.get<PersonInfoService>(PersonInfoService); 
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._httpService = this.injector.get<CommonHttpService>(CommonHttpService);
  }


  ngOnInit() {
    
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : null;
    this.forminitialize();
    this.minDate = new Date();
    this.maxDate = new Date();
    this.maxTime = moment(new Date()).format("HH:mm");
    this.endMinDate = new Date();
    this.setFormControlValidators();
    this.loadDropdownItems();
    this.sendforapprovaldisabled = false;
    this.livingArrangementForm?.get('startdate')?.valueChanges.subscribe(result => {
      if(result){
       this.endMinDate =  new Date(result);
      }
    });
    if(this.personId) {
      this.initCaregiverLists();
    }
    
    this._livingArrangementDetailsService.selectedLivingArrangement$.subscribe(data => {
      if (data) {
        this.isView = data.action === 'view' ? true : false;
        this.editLivingArrangement(data);
      }
    });
  }

  initCaregiverLists(){
    const personid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)
    if(personid !== null && personid !== undefined){
      this._commonHttpService.getArrayList(
              new PaginationRequest({
                  nolimit: true,
                  method: 'get',
                  where: {
                    personid: personid
                  }
              }),
              'Actorrelationships/getallcaregiversincase'+ '?filter'
          ).subscribe((data : any) => {
            if (data && data[0]?.getallcaregiversincase && data[0]?.getallcaregiversincase.length > 0) {
                data[0].getallcaregiversincase.map((element:any)=> {
                    element.fullname = element.firstname + ' ' + element.lastname 
                })
                this.caregiverPersonsList = data[0].getallcaregiversincase;
                this.caregiverPersonsList2 = data[0].getallcaregiversincase;
            }
          });
    
  }
  }
  
  primaryCaregiver($event:any) {
    if($event?.value !== null && this.caregiverPersonsList) {
      this.primaryCaregiverIfConditionFn($event);
    } else {
      this.livingArrangementFormRestData();
    }
  }

  private livingArrangementFormRestData() {
    this.livingArrangementForm.reset({
      primarycaregiver: [null],
      partnerid: [null],
      secondarycaregiver: [null],
      primaryrelationship: [null],
      contactphone: [null],
      workphone: [null],
      add1: [null],
      add2: [null],
      cityname: [null],
      statetypekey: [null],
      zipcode: [null],
      countytypekey: [null]
    });
    this.caregiverPersonsList2 = this.caregiverPersonsList;
    this.primaryselected = false;
    this.showPrimaryCareGiverAddress = false;
  }

  private primaryCaregiverIfConditionFn($event: any) {
    const modal = this.caregiverPersonsList.find(data => data.personid === $event.value);
      if (modal) {
        this.loadStateDropdownItems(modal.state, modal.county);
        this.livingArrangementFormPatchDefaultData(modal);
        this.checkChildFn();
        
        this.caregiverPersonsList2 = this.caregiverPersonsList.filter(care => care.personid != modal.personid);
      
        this.livingArrangementForm.patchValue({
          partnerid: null,
          secondarycaregiver: null
        });
        this.showSecondaryCareGiverAddress = false;
        this.primaryselected = true;
        this.showPrimaryCareGiverAddress = true;
        this.primaryCareGiverCjamsPid = modal.cjamspid;
        this.primaryCareGiverPhone = modal.phonenumber;
        if(modal.address !== null && modal.address.length > 0) {
            const { address, address2, city, countydescription, statename, zipcode } = modal.address[0];
            const addressParts = [
              address,
              address2,
              city,
              countydescription,
              statename,
              zipcode
            ].filter(Boolean); // to remove all falsy values(null, undefined, empty string) 
            this.primaryCareGiverAddress = addressParts.join(', '); 
         } else {
          this.primaryCareGiverAddress = '-'
        }
      }
  }

  private checkChildFn() {
    const child = this.personsList ? this.personsList.find(person => (this.selectedChildren && this.selectedChildren[0].personid == person.personid)) : {};
    if (child) {
      const relationship: any = null;
      this.livingArrangementForm.patchValue({
        primaryrelationship: relationship ? relationship : null
      });
    }
  }

  private livingArrangementFormPatchDefaultData(modal: any) {
    this.livingArrangementForm.patchValue({
      add1: modal.address?.[0]?.address ?? '',
      add2: modal.address?.[0]?.address2 ?? '',
      cityname: modal.address?.[0]?.city ?? '',
      statetypekey: modal.address?.[0]?.state ?? '',
      zipcode: modal.address?.[0]?.zipcode ?? null,
      countytypekey: modal?.county ?? '',
      contactphone: modal?.phonenumber ?? null,
      workphone: modal?.workphone ?? null,
      primarycaregiver: modal?.fullname ?? ''
    });
  }

  secondaryCaregiver($event:any) {
    let modal: any;
    if (this.caregiverPersonsList2) {
     modal = this.caregiverPersonsList2.find((data:any) => data.personid === $event.value);
    }
    if(modal){
      this.livingArrangementForm.patchValue({
        secondarycaregiver: modal.fullname
      });
    }else{
      this.livingArrangementForm.patchValue({
        secondarycaregiver: [null]
      });
    }

    if($event.value && $event.value!=null){
      this.secondaryselected = true;
      this.showSecondaryCareGiverAddress = true;
      this.secondaryCareGiverCjamsPid = modal.cjamspid;
      this.secondaryCareGiverPhone = modal.phonenumber;
      if(modal.address !== null && modal.address.length > 0) {
        const { address, address2, city, countydescription, statename, zipcode } = modal.address[0];
        const addressParts = [
          address,
          address2,
          city,
          countydescription,
          statename,
          zipcode
        ].filter(Boolean); // to remove all falsy values(null, undefined, empty string) 
        this.secondaryCareGiverAddress = addressParts.join(', '); 
      } else {
        this.secondaryCareGiverAddress = '-'
      }
    }else{
      this.secondaryselected = false;
      this.showSecondaryCareGiverAddress = false;
    }
  }

  validatePlacementDates(selectedChildren:any) {
    if (selectedChildren?.length && Array.isArray(selectedChildren)) {
      let minDob = new Date();
      const today = new Date();

      const todayStr = moment(today).format(this.dtformat);
      selectedChildren.forEach((child) => {
        const minDobStr = moment(minDob).format(this.dtformat);
        minDob = this.checkDobFn(child, minDobStr, todayStr, minDob);
      });
      this.minDate = minDob;
      this.endMinDate = minDob;
    }
  }

  private checkDobFn(child: any, minDobStr: string, todayStr: string, minDob: Date) {
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
    (<any>$('#placement-ackmt')).modal('hide');
    this.goBack();
  }

  goBack() {
    // No data or function to add or call
  }

  forminitialize() {
    this.livingArrangementForm = this.formBuilder.group({
      livingarrangementid: null,
      personid : this.personId,
      livingarrangementtypekey: [null, Validators.required],
      livingpriortoplacement: [null],
      contactname: [null],
      caregiverclientid:[null],
      primarycaregiver:[null],
      partnerid:[null],
      secondarycaregiver:[null],
      primaryrelationship:[null],
      startdate: [null, Validators.required],
      remarks: [null],
      contactphone: [null],
      workphone: [null],
      enddate: [null],
      add1: [null],
      add2: [null],
      cityname: [null],
      statetypekey: [null],
      zipcode: [null],
      countytypekey: [null],
      runawayreported: [null],
      runawayreportnumber: [null],
      runawaynotreportedreason: [null],
      endtime: [null],
      starttime: [null]
    });
  }

  setFormControlValidators() {
    // If living arrangement is Runaway runawayreported is required otherwise not
    const runawayReportedControl = this.livingArrangementForm.get('runawayreported');
    const address1Control = this.livingArrangementForm.get('add1');
    this.livingArrangementForm?.get('livingarrangementtypekey')?.valueChanges
      .subscribe((livingArrangement:any) => {
        if (livingArrangement === null //PlacementConstants.RUN_AWAY
          ) {
          address1Control?.setValidators(null);
          address1Control?.setErrors(null);
          address1Control?.clearValidators();
        } else {
          runawayReportedControl?.setValidators(null);
          runawayReportedControl?.setErrors(null);
          runawayReportedControl?.clearValidators();
        }
        runawayReportedControl?.updateValueAndValidity();
        address1Control?.updateValueAndValidity();
      });
  }

  
  getSuggestedAddress() {
    if (this.livingArrangementForm.value.add1 &&
      this.livingArrangementForm.value.add1.length >= 3) {
      this.suggestAddress();
    }
  }

  suggestAddress() {
    this._httpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.livingArrangementForm.value.add1,
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
            this.suggestedAddress$ = result;
          }
        }
      );
  }


  selectedAddress(model:any) {
    this.livingArrangementForm.patchValue({
      add1: model.streetLine ? model.streetLine : '',
      cityname: model.city ? model.city : '',
      statetypekey: model.state ? model.state : ''
    });
    this.loadStateDropdownItems(model.state, null);
    const addressInput = {
      street: model.streetLine ? model.streetLine : '',
      street2: '',
      city: model.city ? model.city : '',
      state: model.state ? model.state : '',
      zipcode: '',
      match: 'invalid'
    };
    this.ValidateAddressUrlApiFn(addressInput);
  }

  private ValidateAddressUrlApiFn(addressInput: { street: any; street2: string; city: any; state: any; zipcode: string; match: string; }) {
    this._httpService
      .getSingle(
        {
          method: 'post',
          where: addressInput
        },
        NewUrlConfig.EndPoint.Intake.ValidateAddressUrl
      )
      .subscribe(
        (result) => {
          this.livingArrangementFormResult(result);
        }
      );
  }

  private livingArrangementFormResult(result: any) {
    if (result[0].analysis) {
      setTimeout(() => {
        this.livingArrangementForm.patchValue({
          zipcode: result[0].components.zipcode ? result[0].components.zipcode : '',
          countytypekey: result[0].metadata.countyName ? result[0].metadata.countyName : ''
        });
      }, 500);
    }
  }

  private loadDropdownItems() {
    forkJoin([
      this._dropDownService.getStateList(),
      this._dropDownService.getListByTableID(76),
      this._dropDownService.getRelations()
    ]).subscribe(([stateList, livingArrangements, relations]) => {
      this.stateDropDownItems = stateList;
      this.livingDropDownItems = livingArrangements.filter(item => item.activeflag === 1);
      this.relationShipDropdownItems = relations;
    });

  }

  loadStateDropdownItems(stateId:any, countyId:any) {
    const filter = {
          where: {
            activeflag: '1',
            state: stateId
          },
          order: 'countyname asc',
          nolimit: true
        };
    this._httpService.create(filter, 'admin/county/countylist')
          .subscribe(result => {
            this.countyDropDownItems = result;
            if(countyId){
              var filteredCounty = this.countyDropDownItems.filter((county:any) => county.countyid == countyId);
              if(filteredCounty && filteredCounty.length && filteredCounty.length > 0){
                this.livingArrangementForm.patchValue({
                  countytypekey: filteredCounty[0].countyname
                });
              }
            }
          });
  }

  

  convertMatinputTimeToTimestamp(date:any, time:any) {
    return moment(moment(date).format('MM/DD/YYYY') + ' ' + time).format();
}

  resetUnwantedControls(formValues:any) {
    if (formValues.livingarrangementtypekey === null //PlacementConstants.RUN_AWAY
      ) {
      formValues.contactname = null;
      formValues.startdate = null;
      formValues.remarks = null;
      formValues.contactphone = null;
      formValues.workphone = null;
      formValues.enddate = null;
      formValues.add1 = null;
      formValues.add2 = null;
      formValues.cityname = null;
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

  onLivingArrangementChange() {
    const livingArrangementKey = this.livingArrangementForm.getRawValue().livingarrangementtypekey;
    if (livingArrangementKey === null //PlacementConstants.RUN_AWAY
      ) {
      this.isRunaway = true;
    } else {
      this.isRunaway = false;
    }
  }

  onRunawayReportedChange() {
    const isRunawayReported = this.livingArrangementForm.getRawValue().runawayreported;
    if (isRunawayReported === 'YES') {
      this.isRunawayReported = true;
    } else {
      this.isRunawayReported = false;
    }
  }

  timechange() {

    const currentTime = moment(new Date()).format("HH:mm");
    const currentDate = moment(new Date()).format(this.dtformat);
    const givenDate = moment(this.livingArrangementForm.getRawValue().startdate).format(this.dtformat);
    const givenTime = this.livingArrangementForm.getRawValue().starttime;

    if(givenTime !== null && currentTime < givenTime && currentDate === givenDate) {
      this._alertService.error('Start date & time should be less than the current time');
      this.livingArrangementForm.patchValue({starttime: null});
    }
  }

  cancelForm() {
    this._livingArrangementDetailsService.isShowAddLivingArrangementEnabled(false);
  }
  getValidationMessage(controlName:any,displayname:any){
    if(this.livingArrangementForm.controls[controlName].status == 'INVALID' )
    {
        return 'Please  '+displayname;
    }}

  addUpdatePersonLivingArrangement() {
    this.mandatoryField=true;
    if(this.livingArrangementForm.invalid){
      return;
    }

    const personLivingArrangementForm = this.livingArrangementForm.getRawValue();
    if (personLivingArrangementForm) {
      
      this._commonHttpService.create(personLivingArrangementForm, CommonUrlConfig.EndPoint.PERSON.LIVINGARRANGEMENT.AddUpdateUrl).subscribe(
        result => {
          if(personLivingArrangementForm.livingarrangementid) {
            this._alertService.success('Living arrangement details updated successfully!');
          } else {
            this._alertService.success('Living arrangement details added successfully!');
          }
          this.livingArrangementForm.reset();
          this.addflag.emit(true);
        },
        error => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
      this.livingArrangementForm.reset();
      this.livingArrangementForm.enable();
    } else {
      this._alertService.warn('Please fill mandatory fields');
      ControlUtils.validateAllFormFields(this.livingArrangementForm);
    }

  }

  editLivingArrangement(model:any) {
    setTimeout(() => {
      this.livingArrangementForm.patchValue(model);
      this.livingArrangementForm.patchValue({
        livingarrangementid: model.livingid,
        startdate: model.livingstartdate,
        enddate: model.livingenddate
      });

      if(this.isView) {
        this.livingArrangementForm.disable();
      }else{
        this.livingArrangementForm.enable();
      }
      
      const primaryCaregiver: any = this.caregiverPersonsList.find(data => data.personid === model.caregiverclientid);
      
      this.primaryCaregiverDetails(primaryCaregiver);
      
      const secondaryCaregiver = this.caregiverPersonsList2.find((data:any) => data.personid === model.partnerid);

      if(secondaryCaregiver !== undefined && secondaryCaregiver !== null) {
        this.showSecondaryCareGiverAddress = true;
        this.secondaryCareGiverCjamsPid = secondaryCaregiver.cjamspid;
        this.secondaryCareGiverPhone = secondaryCaregiver.phonenumber ? secondaryCaregiver.phonenumber : '-';
        if(secondaryCaregiver.address !== null && secondaryCaregiver.address.length > 0) {
          const { address, address2, city, countydescription, statename, zipcode } = secondaryCaregiver.address[0];
            const addressParts = [
              address,
              address2,
              city,
              countydescription,
              statename,
              zipcode
            ].filter(Boolean); // to remove all falsy values(null, undefined, empty string) 
            this.secondaryCareGiverAddress = addressParts.join(', '); 
        } else {
          this.secondaryCareGiverAddress = '-'
        }

      }
      
    }, 100);
  }


  private primaryCaregiverDetails(primaryCaregiver: any) {
    if (primaryCaregiver !== undefined && primaryCaregiver !== null) {
      this.showPrimaryCareGiverAddress = true;
      this.primaryCareGiverCjamsPid = primaryCaregiver?.cjamspid;
      this.primaryCareGiverPhone = primaryCaregiver?.phonenumber ? primaryCaregiver?.phonenumber : '-';
      if (primaryCaregiver?.address !== null && primaryCaregiver?.address.length > 0) {
        const { address, address2, city, countydescription, statename, zipcode } = primaryCaregiver.address[0];
        const addressParts = [
          address,
          address2,
          city,
          countydescription,
          statename,
          zipcode
        ].filter(Boolean); // to remove all falsy values(null, undefined, empty string) 
        this.primaryCareGiverAddress = addressParts.join(', ');
      } else {
        this.primaryCareGiverAddress = '-';
      }
    }
  }
}


import {of as observableOf,  Observable  } from 'rxjs';
import { Component, OnInit, Output, EventEmitter, Injector } from '@angular/core';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { Validators, FormBuilder, FormGroup, AbstractControl, ValidationErrors, ValidatorFn } from '@angular/forms';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DataStoreService,  CommonDropdownsService, AlertService, AuthService } from '../../../../../@core/services';
import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { ControlUtils } from '../../../../../@core/common/control-utils';
import { AddressDetailsService } from '../address-details.service';
import { PersonInfoService } from '../../person-info.service';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import { NavigationUtils } from '../../../../_utils/navigation-utils.service';

export function citySpecialCharacterValidator(): ValidatorFn {
    return (control:AbstractControl) : ValidationErrors | null => {
        const validPattern = /^[-' a-zA-Z]+$/
        const value: string = control.value;

        if (!value) {
            return null;
        }

        const cityValid = validPattern.test(value)

        return !cityValid ? {citySpecialCharacterValidator:true}: null;
    }
}

@Component({
    selector: 'add-address',
    templateUrl: './add-address.component.html',
    styleUrls: ['./add-address.component.scss'],
    standalone: false
})

export class AddAddressComponent implements OnInit {
  suggestedAddress$!: Observable<any[]>;
  personAddressFormGroup!: FormGroup;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  addresstypeDropdownItems$?: Observable<any[]>;
  addressTypes!: Observable<any[]>;
  personId: any=[];
  reportMode: string='';
  mandatoryField:boolean=false;
  personAddressId: any=[];
  phoneNumberList :any= [];
  emailList :any= [];
  id!: string;
  actionText:string = 'Add';
  minDate :Date= new Date();
  maxDate :Date= new Date();

  @Output() addflag: EventEmitter<boolean> = new EventEmitter();
  enableReason = false;
  isClosed = false;
  addressdetails: any = [];

  private _formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _commonDropdownService: CommonDropdownsService;
  private _alertservices: AlertService;
  private _addressService: AddressDetailsService;
  public _personService: PersonInfoService;
  private _dataStoreService: DataStoreService;
  private _navigationUtils: NavigationUtils;
  private _authService : AuthService;

  constructor(private injector : Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._alertservices = this.injector.get<AlertService>(AlertService);
    this._addressService = this.injector.get<AddressDetailsService>(AddressDetailsService);
    this._personService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._navigationUtils = this.injector.get<NavigationUtils>(NavigationUtils);
    this._authService = this.injector.get<AuthService>(AuthService);
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personaddress');
    this.initiateFormGroup();
    this.loadDropDown();
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
    this.getAddressList();
    this.phoneNumberList = this.initializePhoneNumberList();
    this.emailList = this.initializeEmailList();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._addressService.selectedAddress$.subscribe((data:any) => {
      if (data) {
        this.editAddress(data);
      }
    });
  }

  getAddressList() {
    this.addressdetails = [];
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: this.personId },
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        CommonUrlConfig.EndPoint.PERSON.ADDRESS.ListAddressUrl + '?filter'
      ).subscribe((data : any) => {
        this.addressdetails = data;
      });
}

  initializePhoneNumberList() {
    // check for phone number api a list once both associated with address.
    // assign phoneNumberList
    // set the phone list here on edit

    return [{
      personphonetypekey: null,
      phonenumber: null
    }];
  }
  initializeEmailList() {
    // check for  email api list once both associated with address.
    // assign phoneNumberList, emailList
    // set the email List  on edit
    return [{
      type: 'Primary',
      email: null
    },
    {
      type: 'Secondary',
      email: null
    }];
  }

  private initiateFormGroup() {
    this.personAddressFormGroup = this._formBuilder.group({
      personaddressid: [null],
      address: ['', [Validators.required]],
      address2: [''],
      city: ['', [Validators.required, citySpecialCharacterValidator()]],
      state: ['', [Validators.required]],
      county: [''],
      zipcode: ['', [Validators.required]],
      addresstype: ['', [Validators.required]],
      knownDangerAddress: [null],
      knownDangerAddressReason: [null],
      addressstartdate: [''],
      personadrenddate: [''],
      isHouseholdMember: [null],
      isCurrentAddress: [false],
      durationDay: [null],
      currentlocationflag: [0],
    });
  }

  editAddress(model:any) {
    this.actionText = 'Save';
    this.loadCounty(model.state);
    let knownDangerAddress:any = null;
    if (model.danger === true) {
      knownDangerAddress = 1;
    } else if (model.danger === false) {
      knownDangerAddress = 0;
    } else {
      knownDangerAddress = 2;
    }
    setTimeout(() => {
      this.personAddressFormGroup.patchValue(model);
      this.personAddressFormGroup.patchValue({
        addresstype: model.personaddresstypekey,
        address2: model.address2,
        knownDangerAddress: knownDangerAddress,
        knownDangerAddressReason: model.dangerreason
      });
    }, 100);
  

    this.personAddressId = model.personaddressid;
    this.reportMode = 'edit';
  }


  loadCounty(state:any) {
    this._commonDropdownService.getPickListByMdmcode(state).subscribe(countyList => {
      this.countyDropDownItems$ = observableOf(countyList);
    });
  }

  getSuggestedAddress() {
    if (this.personAddressFormGroup.value.address &&
      this.personAddressFormGroup.value.address.length >= 3) {
      this.suggestAddress();
    }
  }
  suggestAddress() {
    this._commonHttpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.personAddressFormGroup.value.address,
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
            this.suggestedAddress$ = observableOf(result);
          } else {
            this.suggestedAddress$ = observableOf([]);
          }
        }
      );
  }
  selectedAddress(model:any) {
    this.personAddressFormGroup.patchValue({
      address: model.streetLine ? model.streetLine : '',
      city: model.city ? model.city : '',
      state: model.state ? model.state : ''
    });
    const addressInput = {
      street: model.streetLine ? model.streetLine : '',
      street2: '',
      city: model.city ? model.city : '',
      state: model.state ? model.state : '',
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
          if (result[0].analysis) {
            this.handlrValidateAddressUrlResponseFn(result);
          }
        },
        (error) => {
          this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }

// Assosiated with selectedAddress method
  private handlrValidateAddressUrlResponseFn(result: any) {
    this.personAddressFormGroup.patchValue({
      zipcode: result[0].components.zipcode ? result[0].components.zipcode : ''
    });
    this.loadCounty(this.personAddressFormGroup.value.state);
    if (result[0].metadata.countyName) {
      this._commonHttpService.getArrayList(
        {
          nolimit: true,
          where: { referencetypeid: 306, mdmcode: (this.personAddressFormGroup.value.state + '~' + result[0].metadata.countyName).toUpperCase(), description: result[0].metadata.countyName }, method: 'get'
        },
        'referencevalues?filter'
      ).subscribe(
        (resultresp) => {
          this.updateResultResp(resultresp);
        }
      );
    }
  }

  updateResultResp(resultresp:any){
    if (resultresp[0]) {
      this.personAddressFormGroup.patchValue({
        county: resultresp[0].ref_key
      });
    }
  }

  private selectedAddressApiResponseFn(result: any) {
    this.personAddressFormGroup.patchValue({
      zipcode: result[0].components.zipcode ? result[0].components.zipcode : ''
    });
    this.loadCounty(this.personAddressFormGroup.value.state);
    if (result[0].metadata.countyName) {
      this.getReferencevaluesApi(result);
    }
  }

  private getReferencevaluesApi(result: any) {
    this._commonHttpService.getArrayList(
      {
        nolimit: true,
        where: { referencetypeid: 306, mdmcode: (this.personAddressFormGroup.value.state + '~' + result[0].metadata.countyName).toUpperCase(), description: result[0].metadata.countyName },
        method: 'get'
      },
      'referencevalues?filter'
    ).subscribe(
      (resultresp) => {
        this.updateResultResp(resultresp);
      }
    );
  }

  private loadDropDown() {

    this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
    this.addresstypeDropdownItems$ = this._commonDropdownService.getAddressType();
  }
  getValidationMessage(controlName:any,displayname:any){
    if(this.personAddressFormGroup.controls[controlName].status == 'INVALID' )
    {
        return 'Please  '+displayname;
    }}
  addPersonAddress(addAddress:any) {
    this.mandatoryField=true;
    if(this.personAddressFormGroup.invalid ){
      return;
    }
    const personAddressForm = this.personAddressFormGroup?.getRawValue();
    if (personAddressForm) {
      if (personAddressForm.knownDangerAddress === 1) {
        addAddress.danger = true;
        addAddress.dangerreason = personAddressForm.knownDangerAddressReason;
      } else if (personAddressForm.knownDangerAddress === 0) {
        addAddress.danger = false;
        addAddress.dangerreason = null;
      } else {
        addAddress.danger = null;
        addAddress.dangerreason = null;
      }
      addAddress.personaddresstypekey = personAddressForm.addresstype;
      addAddress.personid = this._personService.getPersonId();
      addAddress.address = personAddressForm.address;
      addAddress.address2 = personAddressForm.address2;
      addAddress.zipcode = personAddressForm.zipcode;
      addAddress.state = personAddressForm.state;
      addAddress.city = personAddressForm.city;
      addAddress.county = personAddressForm.county;
      addAddress.personaddressid = personAddressForm.personaddressid;

      const objectID = this._navigationUtils.getNavigationInfo().sourceID;
      const objectType = this._navigationUtils.getModuleType();
      addAddress.objectid = objectID;
      addAddress.objecttype = objectType;
      if (this.personAddressFormGroup.value.addressstartdate) {
        addAddress.addressstartdate = personAddressForm.addressstartdate;
      } else {
        addAddress.addressstartdate = null;
      }
      if (this.personAddressFormGroup.value.personadrenddate) {
        addAddress.personadrenddate = personAddressForm.personadrenddate;
      } else {
        addAddress.personadrenddate = null;
      }
      delete addAddress.currentlocationflag;
      this._commonHttpService.create(addAddress, CommonUrlConfig.EndPoint.PERSON.ADDRESS.AddUpdateUrl).subscribe(
        result => {
          this._alertservices.success('Address details Added/Updated successfully!');
          this.reportMode = 'add';
          this.personAddressFormGroup.reset();
          this.addflag.emit(true);
        },
        error => {
          this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
      this.personAddressFormGroup.reset();
      this.actionText = 'Add';
      this.personAddressFormGroup.enable();
    } else {
      this._alertservices.warn('Please fill mandatory fields for Phone');
      ControlUtils.validateAllFormFields(this.personAddressFormGroup);
    }
  }

  cancelForm() {
    this._addressService.isShowAddAddressEnabled(false);
  }

  getPhoneNumberList() {
    // check for phone number api a list once both associated with address.
    // assign phoneNumberList
    // set the phone list here on edit

    this._addressService.phonePersonType$.subscribe((data) => {
      if (data.length > 0) {
        this.phoneNumberList = data;
      }
    });

  }


  setPhoneNumberList() {
    return this.phoneNumberList;
  }

  getEmailList() {
    // check for  email api list once both associated with address.
    // assign phoneNumberList, emailList
    // set the email List  on edit
    this._addressService.emailPersonType$.subscribe((data) => {
      if (data) {
        data.forEach((email) => {
          if (email.personemailtypekey === 'P') {
            email.type = 'Primary';
          } else if (email.personemailtypekey === 'S') {
            email.type = 'Secondary';
          }
        });
        this.emailList = data;
      }
    });
  }

  setEmailList() {
    // check for  email api list once both associated with address.
    // assign phoneNumberList, emailList
    // set the email List  on edit
    return this.emailList;
  }

  updateEmailList(event:any) {
    this.emailList = event;
  }


  updatePhoneList(event:any) {
    this.phoneNumberList = event;
  }

  knowDangerChange(value:any) {
    this.enableReason = ( value === 1) ? true : false;
    if ( this.enableReason ) {
      this.personAddressFormGroup?.get('knownDangerAddressReason')?.setValidators(Validators.required);
      this.personAddressFormGroup?.get('knownDangerAddressReason')?.updateValueAndValidity();
    } else {
      this.personAddressFormGroup?.get('knownDangerAddressReason')?.clearValidators();
      this.personAddressFormGroup?.get('knownDangerAddressReason')?.updateValueAndValidity();
    }
  }

  getHouseholdAddress(event:any){
    if(event.checked){
        const objectID = this._navigationUtils.getNavigationInfo().sourceID;
        const objectType = this._navigationUtils.getModuleType();
        const request = { objectid : objectID,
        objecttype : objectType}
        this._commonHttpService.create(request, CommonUrlConfig.EndPoint.PERSON.ADDRESS.GetHouseholdAddressUrl).subscribe(
          result => {
            if(result.length && result[0]){
              const householdAddress = {
                personaddressid:null,
                personid:this._personService.getPersonId(),
                address:result[0].address,
                address2:result[0].address2,
                city:result[0].city,
                state:result[0].state,
                county:result[0].county,
                zipcode:result[0].zipcode,
                addresstype:result[0].personaddresstypekey,
                addressstartdate:result[0].addressstartdate,
                personadrenddate:result[0].personadrenddate,
                isHouseholdMember:true,
                durationDay:result[0].durationday,
                knownDangerAddress:result[0].danger,
                knownDangerAddressReason:result[0].dangerreason,
                }
                if(householdAddress && householdAddress.state){
                  this.loadCounty(householdAddress.state);
                }
              this.personAddressFormGroup.reset();
              this.personAddressFormGroup.patchValue(householdAddress);
            }
          },
          error => {
            this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
        );
    }
    else{
      this.personAddressFormGroup.reset();}
  }
  addresstypeChange(value:any) {
    if (value && this.addressdetails) {
      const existingAddress = this.addressdetails.find((e:any) => e.personaddresstypekey === value && !e.personadrenddate);
      if (existingAddress) {
        this._alertservices.error('Please fill the end date for existing address type');
        this.personAddressFormGroup.patchValue({
          addresstype: ''
        });
      }
    }
  }
}
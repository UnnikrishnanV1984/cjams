
import {of as observableOf,  Observable } from 'rxjs';
import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { CommonDropdownsService, AlertService } from '../../../../../@core/services';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { PersonInfoService } from '../../person-info.service';
import { MilitaryService } from '../military.service';

@Component({
    selector: 'add-military',
    templateUrl: './add-military.component.html',
    styleUrls: ['./add-military.component.scss'],
    standalone: false
})
export class AddMilitaryComponent implements OnInit {

  suggestedAddress$!: Observable<any[]>;
  personId: any;
  requiredForApproval: boolean = false;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  prefixDropdownItems$!: Observable<DropdownModel[]>;
  suffixDropdownItems$!: Observable<DropdownModel[]>;
  branchDropdownItems$!: Observable<DropdownModel[]>;
  serviceDropdownItems$!: Observable<DropdownModel[]>;

  militaryFormGroup!: FormGroup ;
  phoneNumberList:any = [];
  superiorPhoneNumberList:any = [];
  address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null };

  @Output() addflag: EventEmitter<boolean> = new EventEmitter();
  actionText: string='';
  isLoading = false;
  minDate!: Date;

  constructor(
    private _formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService,
    private _commonDropdownService: CommonDropdownsService,
    private _alertSevice: AlertService,
    private _militaryInfoService: MilitaryService,
    public _personInfoService: PersonInfoService) { }

  ngOnInit() {
    this.minDate = new Date();
    this.actionText = 'Save';
    this.initiateFormGroup();
    this.phoneNumberList = this.getPhoneNumberList();
    this.superiorPhoneNumberList = this.getPhoneNumberList();
    this.loadDropDown();
    this.personId = this._personInfoService.getPersonId();

    this._militaryInfoService.selectedMilitary$.subscribe(data => {
      if (data) {
        this.editAddress(data);
      }
    });
  }

  getPhoneNumberList() {
    return [{
      contactType: null,
      phoneNumber: null
    }];
  }

  private loadDropDown() {
    this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
    this.countyDropDownItems$ = this._commonDropdownService.getPickListByName('county');
    this.prefixDropdownItems$ = this._commonDropdownService.getPickListByName('prefix');
    this.suffixDropdownItems$ = this._commonDropdownService.getPickListByName('suffix');
    this.branchDropdownItems$ = this._commonDropdownService.getPickListByName('militarybranch');
    this.serviceDropdownItems$ = this._commonDropdownService.getPickListByName('servicestatus');
  }

  loadCounty(state:any) {
    this._commonDropdownService.getPickListByMdmcode(state.ref_key).subscribe(countyList => {
      this.countyDropDownItems$ = observableOf(countyList);
    });
  }

  private initiateFormGroup() {
    this.militaryFormGroup = this._formBuilder.group({
      personid: [null],
      military: this._formBuilder.group({
        personmilitaryserviceid: [null],
        branchkey: [null, [Validators.required]],
        serviceid: [null, [Validators.required]],
        dutystation: [null],
        servicestatuskey: [null],
        startdate: [null],
        enddate: [null],
        contactprefixkey: [null],
        contactfirstname: [null, [Validators.required]],
        contactmiddlename: [null],
        contactlastname: [null],
        contactsuffixkey: [null],
        contactphonetypekey: [null],
        contactphonenumber: [null],
        contactphoneextension: [null],
        superiorprefixkey: [null],
        superiorfirstname: [null, [Validators.required]],
        superiormiddlename: [null],
        superiorlastname: [null],
        superiorsuffixkey: [null],
        superiorphonetypekey: [null],
        superiorphonenumber: [null],
        superiorphoneextension: [null],
        comments: [null]
      })
    });
    if (this._personInfoService.getClosed()) {
      this.militaryFormGroup.disable();
    }
  }

  addOrUpdatePersonMiltary() {
    this.militaryFormGroup.patchValue({ personid: this.personId });
    this.requiredForApproval= true;
    this.militaryFormGroup.markAllAsTouched();
    if (this.militaryFormGroup.invalid || !this.address.address1) {
      this._alertSevice.error('Please fill required fields');
      return;
    }
    const data = this.militaryFormGroup.getRawValue();
    data.military.adr1 = this.address.address1;
    data.military.adr2 = this.address.address2;
    data.military.city = this.address.city;
    data.military.state = this.address.state;
    data.military.county = this.address.county;
    data.military.zip5no = this.address.zipcode;
    data.military.phonelist = this.phoneNumberList;
    data.military.superiorphonelist = this.superiorPhoneNumberList;
    this._militaryInfoService.saveMilitaryInfo(data).subscribe(response => {
      this._alertSevice.success('Military Information Saved successfully..');
      this.militaryFormGroup.reset();
      this.resetAddress();
      this.addflag.emit(true);
    }
    );

  }

  resetAddress() {
    this.address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null };
  }
  getValidationMessage(controlName:any,displayname:any){
 
    if(this.militaryFormGroup.get(`military.${controlName}`)?.status === 'INVALID')
    {
        return 'Please Enter value '+displayname;
    }
  }
  getSuggestedAddress() {
    if (this.militaryFormGroup.controls['military'].value.adr1 &&
      this.militaryFormGroup.controls['military'].value.adr1 >= 3) {
      this.suggestAddress();
    }
  }
  suggestAddress() {
    this._commonHttpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.militaryFormGroup.controls['military'].value.adr1,
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
    this.militaryFormGroup.controls['military'].patchValue({
      adr1: model.streetLine ? model.streetLine : '',
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
            this.militaryFormGroup.controls['military'].patchValue({
              zip5no: result[0].components.zipcode ? result[0].components.zipcode : ''
            });
            if (result[0].metadata.countyName) {
              this._commonHttpService.getArrayList(
                {
                  nolimit: true,
                  where: { referencetypeid: 306, mdmcode: {"like": this.militaryFormGroup.value.state + "~%25","options":"i" }, description: result[0].metadata.countyName }, method: 'get'
                },
                'referencevalues?filter'
              ).subscribe(
                (resultresp) => {
                  this.militaryFormGroup.controls['military'].patchValue({
                    county: resultresp[0].ref_key
                  });

                }
              );
            }
          }
        }
      );
  }

  editAddress(model:any) {
    this.isLoading = true;
    this.actionText = 'Update';
    this.address.address1 = model.adr1;
    this.address.address2 = model.adr2;
    this.address.city = model.city;
    this.address.state = model.state;
    this.address.zipcode = model.zip5no;
    this.address.county = model.county;
    this.phoneNumberList = model.phonelist;
    this.superiorPhoneNumberList = model.superiorlist;
    this.minDate = new Date(this.militaryFormGroup.value.startdate);
    this.militaryFormGroup.controls['military'].patchValue(model);
    setTimeout(() => {
      this.isLoading = false;
    }, 100);
  }

  cancel() {
    this.militaryFormGroup.reset();
    this.resetAddress();
    this.addflag.emit(true);
  }

  onChangeDate() {
      this.minDate = new Date(this.militaryFormGroup.controls['military'].value.startdate);
      this.militaryFormGroup.controls['military'].patchValue({
        enddate: null
      });
  }
}

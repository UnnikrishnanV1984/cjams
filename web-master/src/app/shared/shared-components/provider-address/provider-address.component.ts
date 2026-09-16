import { Component, OnInit, Input, Output, EventEmitter, Injector } from '@angular/core';
import { Observable } from 'rxjs';
import { AlertService } from '../../../@core/services/alert.service';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { DataStoreService } from '../../../@core/services/data-store.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ProviderAddressService } from './provider-address.service';
import { AuthService } from '../../../@core/services/auth.service';
import { CommonDropdownsService } from '../../../@core/services/common-dropdowns.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'provider-address',
    templateUrl: './provider-address.component.html',
    styleUrls: ['./provider-address.component.scss'],
    standalone: false
})
export class ProviderAddressComponent implements OnInit {
  yo!: string;
  isViewOnly: boolean = false;
  @Input() object_id!: string;
  @Input() isReadOnly!: boolean;
  @Input() isPayment!: boolean;
  @Input() isLocation: boolean = false;
  @Input() provider_type!: string;
  @Input() object_type: string = 'APPLICANT';
  @Output() addressupdated = new EventEmitter();
  addressForm!: FormGroup;
  suggestedAddress$!: Observable<any[]>;
  contactLocation!: any[];
  addressTypes!: string[];

  addressList:any[] = [];

  adr_type_cd_LOCATION: string = '3357';
  adr_type_cd_PAYMENT: string = '3356';
  url!: string;
  mode!: string;
  stateList?: any[];
  pre_post_dir_list?: any[];
  suffix_cd_list?: any[];
  unit_type_cd?: any[];
  adress_types?: any[];
  countyList?: any[];
  currentAddress: any;
  adr_type_cd!: string;
  readonly?: boolean;
  current_suffix_cd_list?: any[];
  saving: boolean=false;
  maxDate = new Date();
  addressformpopupid = '#address-form';

  private formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService; 
  private _alertService: AlertService;
  private _dataStoreService: DataStoreService;
  public _authService: AuthService;
  public _addressService: ProviderAddressService;
  private _commonDropdownService: CommonDropdownsService;
  
    
    constructor(private injector : Injector) {
      this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._addressService = this.injector.get<ProviderAddressService>(ProviderAddressService);
      this._commonDropdownService =  this.injector.get<CommonDropdownsService>(CommonDropdownsService);


  }

  ngOnInit() {
    this.initializeAddressForm();
    this.loadDropDown();
    if (this.isReadOnly===undefined)
    {
      this.isReadOnly=true;
    }
    switch(this.object_type) {
      case 'APPLICANT':
        this.url='tb_provider_applicant_addresses';
        break; 
      case 'REFERRAL':
        this.url='tb_provider_referral_addresses';
        break;
      case 'PROVIDER':
        this.url='tb_provider_address';
        break;
      case 'VENDOR':
          this.url='tb_provider_applicant_addresses';
          break;
    }
    if(this.isPayment){
      this.adr_type_cd = this.adr_type_cd_PAYMENT;
    }else{
      this.adr_type_cd = this.adr_type_cd_LOCATION;
    }
    this.getAddress();
    if (this._dataStoreService.getData('readonlyProvider') || this._dataStoreService.getData('DISABLE_ADDRESS')){
      this.readonly = true;
      this.addressForm.disable();
    }
    if(this._dataStoreService.getData('editContact')) {
      this.readonly = false;
    }
    
    
  }
  getAddressOfType(){
    if(this.object_id) {
      var arg:any = {
        method: 'get',
        where: {
          delete_sw: 'N',
          parent_key_id: this.object_id,
          adr_type_cd: this.adr_type_cd
        }
      };
      return this._commonHttpService.getArrayList(
        arg,
        this.url+'?filter'
      );
    }
  }
  resetAndUpdateValidity(adr_format_cd:any){
    this.addressForm?.get('adr_box_no')?.clearValidators();
    this.addressForm?.get('adr_box_no')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_pre_dir_cd')?.clearValidators();
    this.addressForm?.get('adr_pre_dir_cd')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_street_nm')?.clearValidators();
    this.addressForm?.get('adr_street_nm')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_street_suffix_cd')?.clearValidators();
    this.addressForm?.get('adr_street_suffix_cd')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_post_dir_cd')?.clearValidators();
    this.addressForm?.get('adr_post_dir_cd')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_unit_type_cd')?.clearValidators();
    this.addressForm?.get('adr_unit_type_cd')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_unit_no_tx')?.clearValidators();
    this.addressForm?.get('adr_unit_no_tx')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_city_nm')?.clearValidators();
    this.addressForm?.get('adr_city_nm')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_county_cd')?.clearValidators();
    this.addressForm?.get('adr_county_cd')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_state_cd')?.clearValidators();
    this.addressForm?.get('adr_state_cd')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_zip5_no')?.clearValidators();
    this.addressForm?.get('adr_zip5_no')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_zip4_no')?.clearValidators();
    this.addressForm?.get('adr_zip4_no')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_direction_tx')?.clearValidators();
    this.addressForm?.get('adr_direction_tx')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_foreign_tx')?.clearValidators();
    this.addressForm?.get('adr_foreign_tx')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_foreign_state_tx')?.clearValidators();
    this.addressForm?.get('adr_foreign_state_tx')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_country_tx')?.clearValidators();
    this.addressForm?.get('adr_country_tx')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_postal_code_tx')?.clearValidators();
    this.addressForm?.get('adr_postal_code_tx')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_street_tx')?.clearValidators();
    this.addressForm?.get('adr_street_tx')?.updateValueAndValidity();
    
    this.addressForm?.get('adr_county_cd_tx')?.clearValidators();
    this.addressForm?.get('adr_county_cd_tx')?.updateValueAndValidity();
    if(adr_format_cd == 'S'){
      this.addressForm?.get('adr_county_cd')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_city_nm')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_state_cd')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_zip5_no')?.setValidators([Validators.required]);      
      this.addressForm?.get('adr_street_tx')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_street_nm')?.setValidators([Validators.required]);
    }
    else if(adr_format_cd == 'R'){
      this.addressForm?.get('adr_county_cd')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_city_nm')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_state_cd')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_zip5_no')?.setValidators([Validators.required]);      
      this.addressForm?.get('adr_street_tx')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_box_no')?.setValidators([Validators.required]);
    }
    else if(adr_format_cd == 'P'){
      this.addressForm?.get('adr_county_cd')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_city_nm')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_state_cd')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_zip5_no')?.setValidators([Validators.required]);  
      this.addressForm?.get('adr_box_no')?.setValidators([Validators.required]);
    }
    else if(adr_format_cd == 'F'){
      this.addressForm?.get('adr_foreign_tx')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_city_nm')?.setValidators([Validators.required]);
      this.addressForm?.get('adr_country_tx')?.setValidators([Validators.required]);

    }
    if(adr_format_cd == 'F'){
      this.addressForm.patchValue({
        adr_box_no : null,
        adr_pre_dir_cd : null,
        adr_street_nm : null,
        adr_street_suffix_cd : null,
        adr_post_dir_cd : null,
        adr_unit_type_cd : null,
        adr_unit_no_tx : null,
        adr_county_cd : null,
        adr_state_cd : 'XX',
        adr_foreign_state_tx : 'XX',
        adr_zip5_no : null,
        adr_zip4_no : null,
        adr_street_tx : null,
        adr_county_cd_tx : null,
      });
    }
    else{
      this.addressForm.patchValue({
        //adr_box_no: null,
        adr_foreign_tx : null,
        adr_foreign_state_tx : null,
        adr_country_tx : null,
        adr_postal_code_tx : null,
        //adr_street_tx : null,
        adr_county_cd_tx : null,
      });
    }
    if(this.addressForm?.get('adr_unit_type_cd')?.value !== null && this.addressForm?.get('adr_unit_type_cd')?.value !== undefined){
      this.addressForm?.get('adr_unit_no_tx')?.setValidators([Validators.required]);
    }
  }
  patch(obj:any){
    this.addressForm.patchValue(obj);
    this.addressForm.patchValue({ adr_default_sw_checkbox : ( obj.adr_default_sw == 'Y' ? true : false) });
  }
  close(){
    (<any>$('#confirm')).modal('hide');
  }

  getAddress() {
    if(this.object_id) {
      var arg:any = {
        method: 'get',
        order: 'adr_start_dt desc',
        where: {
          delete_sw: 'N',
          parent_key_id: this.object_id
        }
      };
      if(this.isPayment){
        arg.where.adr_type_cd = this.adr_type_cd_PAYMENT;
      }
      else if(this.isLocation){
        arg.where.adr_type_cd = this.adr_type_cd_LOCATION;
      }
      this._commonHttpService.getArrayList(
        arg,
        this.url+'?filter'
      ).subscribe(res => {    
        this.addressForm.reset();
        if (res && res.length && res[0]) {
          this.addressList = res;
          this.addressList =this.addressList.filter(add => add.delete_sw=='N');
          this.formatAddressList();
        }
        else{
          this.addressList=[];
        }
      });
    }
  }

  dateChanged() {
    const form  = this.addressForm?.getRawValue()
    var arg:any = {
      method: 'get',
      where: {
        delete_sw: 'N',
        parent_key_id: this.object_id,
        adr_type_cd: form.adr_type_cd,
        adr_start_dt: form.adr_start_dt,
        adr_end_dt: form.adr_end_dt
      }
    };
    this._commonHttpService.getArrayList(
      arg,
      this.url+'?filter'
    ).subscribe(res => {    
      if (res && res.length && res[0]) {
        this._alertService.warn('There is already an address for this type and date interval.');
      }
    });
  }

  viewAddress(address:any){
    (<any>$(this.addressformpopupid)).modal('show');
    this.mode='View';
    this.patch(address);
    this.addressForm.disable();
  }
  editAddress(address:any){
    (<any>$(this.addressformpopupid)).modal('show');
    this.mode='Edit';
    this.resetAndUpdateValidity(address.adr_format_cd);
    this.patch(address);
    this.addressForm.enable();
    this.addressForm?.get('adr_type_cd')?.disable();
  }
  addAddress(){
    (<any>$(this.addressformpopupid)).modal('show');
    this.mode='Add';
    this.addressForm.reset();
    this.addressForm.enable();
    this.addressForm.patchValue({ 
      adr_type_cd : this.adr_type_cd ,
      adr_format_cd: 'S',
      adr_default_sw : 'Y',  
      adr_default_sw_checkbox : true });
    this.addressForm?.get('adr_type_cd')?.disable();
    this.getAddressOfType()?.subscribe(res => {    
      if (res && res.length) {
        this.currentAddress = res.find(add => add.adr_type_cd == this.addressForm.value.adr_type_cd && (!add.adr_end_dt || add.adr_end_dt == '') );
        if(this.currentAddress){
          this._alertService.warn("Please end date all other addresses of this type.");
        }
      }
    });
    this.checkDefault();
  }
  showReminder(){
    (<any>$('#addressConfirmPopup')).modal('show');
  }
  closeReminder(){
    (<any>$('#addressConfirmPopup')).modal('hide');
  }

  addressSave(){
    if(this.provider_type == 'PUBLIC_PROVIDER' && this.mode == 'Add' ){
      this.showReminder();      
    }
    this.saving = true;
    var form = this.addressForm?.getRawValue();
    if(!(form.adr_zip4_no && form.adr_zip4_no.length > 0 )) {
      form.adr_zip4_no = null;
    }
    form.parent_key_id = this.object_id;
  this._commonHttpService.create(
    form,
    this.url+'/addupdate'
  ).subscribe(res => {
    if (res) {
      this.addressForm.reset();
      this.saving = false;
      this.closeForm();
      this._alertService.success("Address saved.");
      this.addressupdated.emit(true);
    }
  });
  if(this.saving){
    setTimeout(() => {
      this.saving = false;
    }, 1000);
  }
}

  closeForm(){
    (<any>$(this.addressformpopupid)).modal('hide');
    this.getAddress();
    this.addressForm.reset();
    this.saving = false;
  }
  checkDefault(){
    const form  = this.addressForm?.getRawValue();
    if(form.adr_default_sw_checkbox){
      var arg:any = {
        method: 'get',
        where: {
          delete_sw: 'N',
          parent_key_id: this.object_id,
          adr_type_cd: form.adr_type_cd,
          adr_default_sw: 'Y'
        }
      };
      if(form.address_id){
        arg.where.address_id= { neq: form.address_id };
      }
      this._commonHttpService.getArrayList(
        arg,
        this.url+'?filter'
      ).subscribe(res => {    
        if (res && res.length && Array.isArray(res)) {
          this._alertService.error("There can be only one default address of one type.");
          this.addressForm.patchValue({ adr_default_sw : 'N' , adr_default_sw_checkbox : false });
        }
        else{
          this.addressForm.patchValue({ adr_default_sw : 'Y' , adr_default_sw_checkbox : true });
        }
      });
    }
    else{
      this.addressForm.patchValue({ adr_default_sw : 'N' , adr_default_sw_checkbox : false });
    }
  }

  private loadDropDown() {
     this._commonDropdownService.getPickList(104).subscribe(list => this.countyList = list ? list : [] );
     this._commonDropdownService.getPickList(211).subscribe(list => this.stateList = list ? list : [] );
     this._commonDropdownService.getPickList(69).subscribe(res => this.pre_post_dir_list = res ? res : []);
     this._commonDropdownService.getPickList(212).subscribe(res => {
       this.suffix_cd_list = res ? res : [];
       this.current_suffix_cd_list = this.suffix_cd_list;
     });
     this._commonDropdownService.getPickList(250).subscribe(res => this.unit_type_cd = res ? res : []);
     this.getPickList(10).subscribe(res => this.adress_types = res ? res : []);
  }

  formatAddressList(){
    this.addressList.forEach(add => {
      add.adr_default_sw_checkbox = add.adr_default_sw == 'Y' ? true : false;
      add.formatted_address = this._addressService.formatAddress(add);
      let frmAdrsLst = add.adr_type_cd == this.adr_type_cd_LOCATION ? 'Location' : 'Invalid'
      add.address_type = add.adr_type_cd == this.adr_type_cd_PAYMENT ? 'Payment' : frmAdrsLst ;
    });
  }
  getPickList(picklistid:any) {
    return this._commonHttpService.getArrayList({
      where: {
        'picklist_type_id': picklistid,
        'category_tx': 'P',
        'active_sw': 'Y'
      },
      nolimit: true,
      method: 'get'
    }, 'tb_picklist_values?filter');
  }


  private initializeAddressForm() {
    this.addressForm = this.formBuilder.group({
      address_id: [null],
      adr_type_cd: [null],
      adr_format_cd: [null],
      adr_box_no: [null],
      adr_pre_dir_cd: [null],
      adr_street_nm: [null],
      adr_street_suffix_cd: [null],
      adr_post_dir_cd: [null],
      adr_unit_type_cd: [null],
      adr_unit_no_tx: [null],
      adr_city_nm: [null],
      adr_county_cd: [null],
      adr_state_cd: [null],
      adr_zip5_no: [null],
      adr_zip4_no: [null],
      adr_direction_tx: [null],
      adr_foreign_tx: [null],
      adr_foreign_state_tx: [null],
      adr_country_tx: [null],
      adr_postal_code_tx: [null],
      adr_default_sw: [null],
      adr_default_sw_checkbox: [null],
      adr_start_dt: [null],
      adr_end_dt: [null],
      adr_street_tx: [null],
      adr_county_cd_tx: [null],
    });
  }
  suffix(event:any ){
    const a=event;
  }
  getAddressByType(event:any){
    // No operation needed here
  }



  typeSuffix(event:any){
    const srch = (event.srcElement.value).toLowerCase().trim();
    var re = new RegExp(srch, 'g');
    this.current_suffix_cd_list = this.suffix_cd_list?.filter((unit) => String(unit.value_tx).toLowerCase().trim().match(re) );
  }
  clickSuffix(){
    (<any>$('#select-input')).focus();
    (<any>$('#select-input')).select();
  }
  selectionChanged(value:any) {
    if (value !== 'MD') {
      this.addressForm.patchValue({
        adr_county_cd: '3825'
      });
    } else if (value === 'MD') {
      this.addressForm.patchValue({
        adr_county_cd: null
      });
    }
  }
}

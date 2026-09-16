
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { AlertService, CommonHttpService, DataStoreService, AuthService, CommonDropdownsService } from '../../../../@core/services';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ProviderAddressService } from '../../../../shared/shared-components/provider-address/provider-address.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'provider-profile',
    templateUrl: './provider-profile.component.html',
    styleUrls: ['./provider-profile.component.scss'],
    standalone: false
})
export class ProviderProfileComponent implements OnInit {
  object_type!: string;
  isReadOnly!: boolean;
  providerId: string;
  send_to_list: any[] = [];
  type: string = 'PROVIDER';
  pay_to_affiliate_cd!: string;
  paymentAddress: any;  
  provider_type!: string;
  adr_object_type: any = 'PROVIDER'
  paymentForm!: FormGroup;
  suggestedPayment$!: Observable<any[]>;
  contactLocation: any[] = [];
  paymentTypes: string[] = [];
  public static AFFILIATED_PROVIDER_ADDRESS = '3368';
  public static SAME_PROVIDER_ADDRESS = '3366';
  public static DIFFERENT_PROVIDER_ADDRESS = '3367';
  public static NA_TAX_TYPE = '4970';
  public static FEIN_TYPE = '2517';	
  public static SSN_TYPE = '2518';	
  public static LOCATION_ADR_CD = '3357';
  public static PAYMENT_ADR_CD = '3356';
  stateList!: any[];
  prefix_cd_list!: any[];
  suffix_cd_list!: any[];
  suffix_cd_list_name!: any[];
  adress_types!: any[];
  tax_id_type_list!: any[];
  
  pre_post_dir_list!: any[];
  unit_type_cd!: any[];
  countyList!: any[];
  currentPayment: any;
  providerInfo: any;
  showAddress!: boolean;
  isPayment: boolean = true;
  cpaInfo: any;
  currentProvider: any;
  af_providerInfo: any;
  reasonwithhold: any;
  headerTxt!: string;
  checkAlertTxt!: string;
  alertTxt!: string;
  currentvalue: any;
  markCheckStatus!: boolean;
  isPaymentWithhold: any;
  electronicfundtransfer!: boolean;
  onlyadoptivehomeprovider: boolean = true;
  showsavebutton!: boolean;

  constructor(
    private formBuilder: FormBuilder,
    private _dataStoreService: DataStoreService,
    private _commonDropdownService: CommonDropdownsService,
    public _authService: AuthService,
    private _alertService: AlertService,
    private _commonHttpService: CommonHttpService,
    private _addressService: ProviderAddressService,
  ) {
    this.providerId = this._dataStoreService.getData("adoptionproviderid");
    this.onlyadoptivehomeprovider = this._dataStoreService.getData("onlyadoptivehomeprovider");
  }
  ngOnInit() {
    this.loadDropDowns();
    this.initializePaymentForm();
    this.isReadOnly = this._authService.readonlyButton('read_only_access', 'add-edit-person');
    if (this.isReadOnly===undefined)
    {
      this.isReadOnly=false;
    }
    if (!this.isReadOnly){
      this.paymentForm.disable();      
    }
    this.provider_type = 'PUBLIC_PROVIDER';    
    this.object_type='PROVIDER';   
    this.getPayment(); 
  }

  savePayment(){
    this.doValidations().subscribe(isvalid => {
      if(isvalid){
        const form = this.paymentForm.getRawValue();
        form.withhold_payment_sw = form.withhold_payment_sw_cb ? 'Y' : 'N' ;
        form.eft_sw = form.eft_sw_cb ? 'Y' : 'N' ;
        form.medicaid_sw = form.medicaid_sw_cb ? 'Y' : 'N' ;
        form.indicator_1099_sw = form.indicator_1099_sw_cb ? 'Y' : 'N' ;
        form.provider_id = this.providerId;
        this._commonHttpService.create(
          form,
          'tb_provider/addupdate'
        ).subscribe(res => {
          if (res) {
            this.paymentForm.reset();
            this.getPayment();
            this._alertService.success("Payment information saved.");
          }
        });
      }
      else{
        this._alertService.error("Invalid Address");
      }
    });
  }

  addressupdated(event: any){
    if(event){
      this.getPayment(); 
    }
  }

  doValidations(){
    return this.validateAddress();
  }

  private initializePaymentForm() {
    this.paymentForm = this.formBuilder.group({
      payment_id: [null],
      prov_tax_type_cd : [null],
      tax_id_no : [null],
      indicator_1099_sw : [null],
      indicator_1099_sw_cb: [null],
      medicaid_sw : [null],
      medicaid_sw_cb: [null],
      withhold_payment_sw : [null],
      withhold_payment_sw_cb: [null],
      medical_license_no_tx : [null],
      medical_speciality_tx : [null],
      eft_sw : [null],
      eft_sw_cb: [null],
      pay_to_affiliate_cd : [null],
      ref_contact_prefix_cd : [null],
      ref_contact_first_nm : [null],
      ref_contact_middle_nm : [null],
      ref_contact_last_nm : [null],
      ref_contact_suffix_cd : [null],
      ref_work_phone_tx: [null],
      ref_work_xtn_tx : [null],
      ref_home_phone_tx : [null],
      ref_pager_tx : [null],
      ref_email_tx : [null],
      ref_fax_tx : [null],
      ref_cell_phone_tx : [null],
      ref_url_tx : [null],
      ref_other_contact_tx : [null],
      adm_contact_prefix_cd : [null],
      adm_contact_first_nm : [null],
      adm_contact_middle_nm : [null],
      adm_contact_last_nm : [null],
      adm_contact_suffix_cd : [null],
      adm_work_phone_tx : [null],
      adm_work_xtn_tx : [null],
      adm_home_phone_tx : [null],
      adm_pager_tx : [null],
      adm_email_tx : [null],
      adm_fax_tx : [null],
      adm_cell_phone_tx : [null],
      adm_url_tx : [null],
      adm_other_contact_tx : [null]
    });
  }

  getPayment(provider_id = this.providerId) {
    const arg:any = {
      method: 'get',
      where: {
        provider_id: provider_id
      }
    };
    this._commonHttpService.getArrayList(
      arg,
      'tb_provider'+'?filter'
    ).subscribe(res => {    
      this.paymentForm.reset();
      if (res && res.length && res[0]) {
        this.providerInfo = res[0];
        this.formatPaymentInfo();

        this.paymentForm.patchValue(this.providerInfo);
        this.pay_to_affiliate_cd = this.providerInfo.pay_to_affiliate_cd;
        if(this.providerInfo && this.providerInfo.tax_id_no && this.providerInfo.tax_id_no.length < 9) {
          this.paymentForm.patchValue({ tax_id_no: 0+this.providerInfo.tax_id_no});
        }
        if(this.type == 'CPA'){
          this.paymentForm.patchValue({
            pay_to_affiliate_cd : ProviderProfileComponent.AFFILIATED_PROVIDER_ADDRESS
          });
          this.pay_to_affiliate_cd = ProviderProfileComponent.AFFILIATED_PROVIDER_ADDRESS;
          this.paymentForm.disable();
        }
        this.showsavebutton = false;
        this.validateAddress();
      }
      else{
        this.providerInfo={};
      }
    });
  }

  formatPaymentInfo() {

    let tax_type_cd='';
    if(this.type == 'SITE' || this.type == 'CPA' || this.provider_type =='PRIVATE_PROVIDER'){
      tax_type_cd = ProviderProfileComponent.FEIN_TYPE;
    }
    else if(this.provider_type =='PUBLIC_PROVIDER'){
      tax_type_cd= ProviderProfileComponent.SSN_TYPE;
    }
    if(!this.providerInfo.prov_tax_type_cd){
      this.providerInfo.prov_tax_type_cd = tax_type_cd;
    }
    this.providerInfo.indicator_1099_sw = this.providerInfo.prov_tax_type_cd == ProviderProfileComponent.SSN_TYPE ?  'Y' : 'N';

    this.providerInfo.indicator_1099_sw_cb = this.providerInfo.indicator_1099_sw == 'Y' ? true : false;
    this.providerInfo.medicaid_sw_cb = this.providerInfo.medicaid_sw == 'Y' ? true : false;
    this.providerInfo.withhold_payment_sw_cb = this.providerInfo.withhold_payment_sw == 'Y' ? true : false;
    this.providerInfo.eft_sw_cb = this.providerInfo.eft_sw == 'Y' ? true : false;

  }


  private loadDropDowns() {    
    this._commonDropdownService.getPickList(338).subscribe(res => {
      this.send_to_list = res ? res : [];
      if(this.send_to_list && this.type == 'PROVIDER'){
        const i = this.send_to_list.indexOf( this.send_to_list.find(option => option.picklist_value_cd == ProviderProfileComponent.AFFILIATED_PROVIDER_ADDRESS));
        this.send_to_list.splice(i,1); 
      }
    });
  }

  addressTypeChanged(){
    this.checkForEFT();
    this.validateAddress();
  }

  validateAddress(pay_to_affiliate_cd = null){
    this.showAddress = false;
    if(!pay_to_affiliate_cd){
      pay_to_affiliate_cd = this.paymentForm.getRawValue().pay_to_affiliate_cd;
    }
    if(pay_to_affiliate_cd == ProviderProfileComponent.AFFILIATED_PROVIDER_ADDRESS){ // Payment of afffiliated provider - we can get that address and show here
      return this.getAffiliatedProviderAddress();
    }
    return this.getOwnAddress(pay_to_affiliate_cd);
  }
  getOwnAddress(pay_to_affiliate_cd = null){
    let type_cd = '';
    if(!pay_to_affiliate_cd){
      pay_to_affiliate_cd = this.paymentForm.getRawValue().pay_to_affiliate_cd;
    }
    this.showAddress = false;
    if (pay_to_affiliate_cd === ProviderProfileComponent.SAME_PROVIDER_ADDRESS){ // Same as location
      type_cd = ProviderProfileComponent.LOCATION_ADR_CD;
      this.isPayment = false;
    }else{
      type_cd = ProviderProfileComponent.PAYMENT_ADR_CD; // Different Payment 
      this.isPayment = true;
    }
    const a = this.getAddress(type_cd);
    a.subscribe(add=>{
      if(add && add.length && add[0]){
        this.paymentAddress = this._addressService.formatAddress(add[0]);
        this.showAddress = false;
      }
      else{
        if(pay_to_affiliate_cd === ProviderProfileComponent.DIFFERENT_PROVIDER_ADDRESS){
          this.paymentAddress = '';
          this._alertService.error("Please add payment address.");
        }
        else{
          this.paymentAddress = '';
          this._alertService.error("Please add location address.");
        }
        this.showAddress = true;
      }
    });
    return a.pipe(map(add=>{
      if(add && add.length && add[0]){
        return true;
      }
      else{
        return false;
      }
    }));
  }
  getAffiliatedProviderAddress() {
    const p = this.getProvider();
    p.subscribe(providerList => {
      this.currentProvider= providerList && providerList.length ? providerList[0] : {};
      const af_provider_id = this.currentProvider.affiliate_provider_id;
      this.getProvider(af_provider_id).subscribe(afproviderList => {
        this.af_providerInfo = afproviderList && afproviderList.length ? afproviderList[0] : {};
        if(this.af_providerInfo){
          this.setpaymentAddress(af_provider_id);
        }
      });
    });
    return p.pipe(map(add=>{
      return true;
    }));
  }
  setpaymentAddress(af_provider_id: string | undefined) {
    let type_cd = '';
    if (this.af_providerInfo.pay_to_affiliate_cd === ProviderProfileComponent.SAME_PROVIDER_ADDRESS) { // Same as location
      type_cd = ProviderProfileComponent.LOCATION_ADR_CD;
      this.isPayment = false;
    } else {
      type_cd = ProviderProfileComponent.PAYMENT_ADR_CD; // Different Payment 
      this.isPayment = true;
    }
    this.getAddress(type_cd, af_provider_id).subscribe(add => {
      if (add && add.length && add[0]) {
        this.paymentAddress = this._addressService.formatAddress(add[0]);
      }
      else {
        this.paymentAddress = "Parent Organization's payment information not found.";
      }
    });
  }
  checkForEFT(){
    const form = this.paymentForm.getRawValue();
    if(form && form.eft_sw_cb && this.provider_type != 'PRIVATE_PROVIDER'){
      this._alertService.error("Cannot change payment address type when EFT is enabled.");
      this.paymentForm.patchValue({ pay_to_affiliate_cd: '3366'});
      this.pay_to_affiliate_cd = '3366';
      this.showsavebutton = false;
    } else {
      if(this.pay_to_affiliate_cd != this.paymentForm.getRawValue().pay_to_affiliate_cd) {
        this.showsavebutton = true;
      }else {
        this.showsavebutton = false;
      }
    }
  }

  getAddress(adr_type_cd: any, provider_id = this.providerId) {
    const arg:any = {
      method: 'get',
      where: {
        delete_sw: 'N',
        adr_default_sw: 'Y',
        adr_type_cd: adr_type_cd ? adr_type_cd : '',
        parent_key_id: provider_id
      }
    };
    return this._commonHttpService.getArrayList(
      arg,
      'tb_provider_address'+'?filter'
    );
  }

  getProvider(provider_id = this.providerId){
    const arg:any = {
      method: 'get',
      where: {
        provider_id: provider_id
      }
    };
    return this._commonHttpService.getArrayList(
      arg,
      'tb_provider'+'?filter'
    )
  }

  }
import { Injectable } from '@angular/core';
import { CommonDropdownsService, CommonHttpService } from '../../../@core/services';
import { Router } from '@angular/router';
import { ProviderAddressConfig } from './_entities/provider-address.data.models';

@Injectable()
export class ProviderAddressService {
  contactnotesConfig!: ProviderAddressConfig;

  
  stateList?: any[];
  pre_post_dir_list?: any[];
  suffix_cd_list?: any[];
  unit_type_cd?: any[];
  adress_types?: any[];
  countyList?: any[];

  constructor(private _router: Router, 
    private _commonDropdownService: CommonDropdownsService,
    private _commonHttpService: CommonHttpService) {
    this.loadDropDown();

  }

  private loadDropDown() {
    this._commonDropdownService.getPickList(104).subscribe(list => this.countyList = list ? list : []);
    this._commonDropdownService.getPickList(211).subscribe(list => this.stateList = list ? list : []);
    this._commonDropdownService.getPickList(69).subscribe(res => this.pre_post_dir_list = res ? res : []);
    this._commonDropdownService.getPickList(212).subscribe(res => this.suffix_cd_list = res ? res : []);
    this._commonDropdownService.getPickList(250).subscribe(res => this.unit_type_cd = res ? res : []);
    this.getPickList(10).subscribe(res => this.adress_types = res ? res : []);
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

formatAddressLineTwo(a:any){
  if(a){
    return this.returnFormatAddressLineTwoData(a); 
  }
  return '';
}
  private returnFormatAddressLineTwoData(a: any) {
    let add = '';
    add = this.formatAddressLineTwoCountyData(a, add);
    add = this.formatAddressLineTwoCountryStateData(a, add);
    return add;
  }

  private formatAddressLineTwoCountryStateData(a: any, add: string) {
    if (a.adr_state_cd && this.stateList) {
      const isadr_state_cd = this.stateList.find(item => item.picklist_value_cd === a.adr_state_cd);
      add = add + ' ' + (isadr_state_cd ? isadr_state_cd['value_tx'] : '');
    }
    if (a.adr_zip5_no) {
      add = add + ' - ' + ('00000' + a.adr_zip5_no).slice(-5);
    }
    if (a.adr_country_tx) {
      add = add + ' ' + a.adr_country_tx;
    }
    if (a.adr_postal_code_tx) {
      add = add + ' ' + a.adr_postal_code_tx;
    }
    return add;
  }

  private formatAddressLineTwoCountyData(a: any, add: string) {
    if (a.adr_city_nm) {
      add = add + ' ' + a.adr_city_nm;
    }
    if (a.adr_county_cd && this.countyList) {
      const isadr_county_cd = this.countyList.find(item => item.picklist_value_cd === a.adr_county_cd);
      add = add + ', ' + (isadr_county_cd ? isadr_county_cd['value_tx'] + ', ' : '');
    }
    if (a.adr_county_cd_tx) {
      add = add + ' ' + a.adr_county_cd_tx;
    }
    return add;
  }

formatAddressLineOne(a:any){
  if(a){
    return this.returnFormatAddressLineOneData(a);
  }
  return '';
}
  private returnFormatAddressLineOneData(a: any) {
    let add = '';
    add = this.formatAddressLineOneStreetData(a, add);
    add = add + ', ';
    add = this.formatAddressLineOneUnitData(a, add);
    return add;
  }

  private formatAddressLineOneUnitData(a: any, add: string) {
    if (a.adr_unit_type_cd && this.unit_type_cd) {
      const isadr_unit_type_cd = this.unit_type_cd.find(item => item.picklist_value_cd == a.adr_unit_type_cd);
      add = add + ' ' + (isadr_unit_type_cd ? isadr_unit_type_cd['value_tx'] : '');
    }
    if (a.adr_unit_no_tx) {
      add = add + ' ' + a.adr_unit_no_tx;
    }
    if (a.adr_unit_no_tx || a.adr_unit_type_cd) {
      add = add + ', ';
    }
    if (a.adr_direction_tx) {
      add = add + ' ' + a.adr_direction_tx;
    }
    if (a.adr_format_cd === 'P') {
      add = 'P.O.BOX ' + add;
    }
    return add;
  }

  private formatAddressLineOneStreetData(a: any, add: string) {
    if (a.adr_street_tx) { add = add + ' ' + a.adr_street_tx; }
    if (a.adr_pre_dir_cd && this.pre_post_dir_list) {
      const isadr_pre_dir_cd = this.pre_post_dir_list.find(item => item.picklist_value_cd == a.adr_pre_dir_cd);
      add = add + ' ' + (isadr_pre_dir_cd ? isadr_pre_dir_cd['value_tx'] : '');
    }
    if (a.adr_box_no) { add = add + ' ' + a.adr_box_no; }
    add = this.getAppendedOneStreetDataFn(a, add);
    return add;
  }

  private getAppendedOneStreetDataFn(a: any, add: string) {
    if (a.adr_street_nm) { add = add + ' ' + a.adr_street_nm; }
    if (a.adr_street_suffix_cd && this.suffix_cd_list) {
      const isadr_street_suffix_cd = this.suffix_cd_list.find(item => item.picklist_value_cd == a.adr_street_suffix_cd);
      add = add + ' ' + (isadr_street_suffix_cd ? isadr_street_suffix_cd['value_tx'] : '');
    }
    if (a.adr_post_dir_cd && this.pre_post_dir_list) {
      const isadr_post_dir_cd = this.pre_post_dir_list.find(item => item.picklist_value_cd == a.adr_post_dir_cd);
      add = add + ' ' + (isadr_post_dir_cd ? isadr_post_dir_cd['value_tx'] : '');
    }
    if (a.adr_foreign_tx) {
      add = add + ' ' + a.adr_foreign_tx;
    }
    return add;
  }

formatAddress(a:any){
  if(a){
    let add = '';
    add = this.formatAddressStreetData(a, add);
    add=add+ ', ';
    add = this.formatAddressUnitData(a, add);
    add = this.formatAddressCountyInfo(a, add);
    return add; 
  }
  return '';
}
  private formatAddressCountyInfo(a: any, add: string) {
    if (a.adr_city_nm) { add = add + ' ' + a.adr_city_nm; }
    if (a.adr_county_cd && this.countyList) {
      var isadr_county_cd = this.countyList.find(item => item.picklist_value_cd == a.adr_county_cd);
      add = add + ', ' + (isadr_county_cd ? isadr_county_cd['value_tx'] + ', ' : '');
    }
    if (a.adr_state_cd && this.stateList) {
      var isadr_state_cd = this.stateList.find(item => item.picklist_value_cd == a.adr_state_cd);
      add = add + ' ' + (isadr_state_cd ? isadr_state_cd['value_tx'] : '');
    }
    if (a.adr_zip5_no) {
      add = add + ' - ' + ('00000' + a.adr_zip5_no).slice(-5);
    }
    if (a.adr_country_tx) { add = add + ' ' + a.adr_country_tx; }
    if (a.adr_postal_code_tx) { add = add + ' ' + a.adr_postal_code_tx; }
    if (a.adr_county_cd_tx) { add = add + ' ' + a.adr_county_cd_tx; }
    if (a.adr_direction_tx) { add = add + ' ' + a.adr_direction_tx; }
    if (a.adr_format_cd === 'P') {
      add = 'P.O.BOX ' + add;
    }
    return add;
  }

  private formatAddressUnitData(a: any, add: string) {
    if (a.adr_unit_type_cd && this.unit_type_cd) {
      var isadr_unit_type_cd = this.unit_type_cd.find(item => item.picklist_value_cd == a.adr_unit_type_cd);
      add = add + ' ' + (isadr_unit_type_cd ? isadr_unit_type_cd['value_tx'] : '');
    }
    if (a.adr_unit_no_tx) { add = add + ' ' + a.adr_unit_no_tx; }
    if (a.adr_unit_no_tx || a.adr_unit_type_cd) { add = add + ', '; }
    return add;
  }

  private formatAddressStreetData(a: any, add: string) {
    if (a.adr_street_tx) { add = add + ' ' + a.adr_street_tx; }
    if (a.adr_pre_dir_cd && this.pre_post_dir_list) {
      const isadr_pre_dir_cd = this.pre_post_dir_list.find(item => item.picklist_value_cd == a.adr_pre_dir_cd);
      add = add + ' ' + (isadr_pre_dir_cd ? isadr_pre_dir_cd['value_tx'] : '');
    }
    if (a.adr_box_no) { add = add + ' ' + a.adr_box_no; }
    if (a.adr_street_nm) { add = add + ' ' + a.adr_street_nm; }
    if (a.adr_street_suffix_cd && this.suffix_cd_list) {
      const isadr_street_suffix_cd = this.suffix_cd_list.find(item => item.picklist_value_cd == a.adr_street_suffix_cd);
      add = add + ' ' + (isadr_street_suffix_cd ? isadr_street_suffix_cd['value_tx'] : '');
    }
    add = this.getAppendedStreetDataFn(a, add);
    return add;
  }

  private getAppendedStreetDataFn(a: any, add: string) {
    if (a.adr_post_dir_cd && this.pre_post_dir_list) {
      const isadr_post_dir_cd = this.pre_post_dir_list.find(item => item.picklist_value_cd == a.adr_post_dir_cd);
      add = add + ' ' + (isadr_post_dir_cd ? isadr_post_dir_cd['value_tx'] : '');
    }
    if (a.adr_foreign_tx) { add = add + ' ' + a.adr_foreign_tx; }
    return add;
  }

  setProviderAddressConfig(contactnotesConfig:ProviderAddressConfig) {
      this.contactnotesConfig = contactnotesConfig;
  }

  getProviderAddressConfig():ProviderAddressConfig {
      return this.contactnotesConfig;
  }
//   getProviderAddressId(id) {
//     return this.provider-addressId = id;
//   }   
}

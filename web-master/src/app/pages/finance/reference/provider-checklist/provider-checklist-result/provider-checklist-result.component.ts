import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { ProviderChecklist } from '../../../finance.constants';
import { FinanceUrlConfig } from '../../../finance.url.config';
import { FormGroup, FormBuilder } from '@angular/forms';

@Component({
    selector: 'provider-checklist-result',
    templateUrl: './provider-checklist-result.component.html',
    styleUrls: ['./provider-checklist-result.component.scss'],
    standalone: false
})
export class ProviderChecklistResultComponent implements OnInit {
  searchParams: any;
  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  providerSearch: any[]=[];
  providerCheckDetailsForm!: FormGroup;
  accprovider: any;
  providername: any;
  providerid: any;
  constructor(private _route: ActivatedRoute,
    private _router: Router,
    private _datastoreService: DataStoreService,
    private _commonHttpService: CommonHttpService, private formBuilder: FormBuilder) {
    this._datastoreService.currentStore.subscribe((store:any) => {
      const searchParams = store[ProviderChecklist.ProviderChecklistSearchParams];
      if (!searchParams && (JSON.stringify(this.searchParams) !== JSON.stringify(searchParams))) {
        this.searchParams = null;
        this.providerSearch = [];
      } else if (searchParams && (JSON.stringify(this.searchParams) !== JSON.stringify(searchParams))) {
        this.searchParams = searchParams;
        this.getproviderSearchData();
      }
    });
  }

  ngOnInit() {
    this.initializeForm();
  }

  getproviderSearchData() {
    this.searchParams.provider_id = this.searchParams.provider_id ? this.searchParams.provider_id : null;
    this.searchParams.provider_name = this.searchParams.provider_name ? this.searchParams.provider_name : null;
    this.searchParams.tax_id = this.searchParams.tax_id ? this.searchParams.tax_id : null;
    this.searchParams.mail_code = this.searchParams.mail_code ? this.searchParams.mail_code : null;
    this._commonHttpService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: this.searchParams,
      method: 'post'
    }, FinanceUrlConfig.EndPoint.providerChecklist.listProviderChecklistdetails).subscribe((res: any) => {
      if (res) {
        this.providerSearch = res;
      }
    });
  }
  initializeForm() {

    this.providerCheckDetailsForm = this.formBuilder.group({
      provider_id: [null],
      provider_name: [null],
      tax_id_type: [null],
      provider_category: [null],
      tax_id: [null],
      mail_code: [null],
      indicator_1099: [null],
      location_address: [null],
      locn_street_route: [null],
      locn_rural: [null],
      locn_pbox: [null],
      locn_foreign: [null],
      locn_street_route_no: [null],
      locn_city_nm: [null],
      locn_box_po_no: [null],
      locn_state_cd: [null],
      locn_street_nm: [null],
      locn_zip5_no: [null],
      locn_unit_type: [null],
      foreign_address: [null],
      foreign_state: [null],
      foreign_country: [null],
      foreign_postalcode: [null],
      payment_address: [null],
      pay_foreign_streetroute: [null],
      pay_foreign_city: [null],
      pay_foreign_pbox: [null],
      pay_foreign_state: [null],
      pay_foreign_streetname: [null],
      pay_foreign_zip: [null],
      pay_foreign_unit: [null],
      payto_foreign_address: [null],
      payto_foreign_state: [null],
      payto_foreign_country: [null],
      payto_foreign_postal: [null],
      payto_localdept: [null],
      send_payment_to:[null]
    });
  }
  providerDetails(provider: any) {

      this.providername = provider.providername;
      this.providerid = provider.provider_id;
      const providerupdate = provider.checklist_details[0];
      this.providerCheckDetailsForm.patchValue({
      provider_category: (providerupdate.provider_category_sw === 'Y') ? false : true,
      tax_id_type: (providerupdate.tax_id_type_sw === 'Y') ? false : true,
      tax_id: (providerupdate.tax_id_sw === 'Y') ? false : true,
      mail_code: (providerupdate.mail_code_sw === 'Y') ? false : true,
      indicator_1099: (providerupdate.indicator_1099_sw === 'Y') ? false : true,
      ...this.locnFn(providerupdate),
      losscn_unit_type: (providerupdate.locn_unit_type === 'Y') ? false : true,
      ...this.foreignFn(providerupdate),
      payto_localdept: (providerupdate.local_department_sw === 'Y') ? false : true,
      ...this.payForeignFn(providerupdate),
      payment_address: providerupdate.pay_adr_format_cd,
      location_address: providerupdate.locn_adr_format_cd,
      send_payment_to: (providerupdate.send_payment_to_sw === 'Y') ? false : true

    });
    this.providerCheckDetailsForm.disable();
  }

  private foreignFn(providerupdate: any){
    return {
      foreign_address: (providerupdate.locn_foreign_tx_sw === 'Y') ? false : true,
      foreign_state: (providerupdate.locn_foreign_state_tx_sw === 'Y') ? false : true,
      // foreign_country:(providerupdate.locn_street_route_no_sw === 'N') ? false : true,
    }
  }

  private locnFn(providerupdate: any){
    return {
      locn_street_route: (providerupdate.locn_street_route_no_sw === 'Y') ? false : true,
      locn_city_nm: (providerupdate.locn_city_nm_sw === 'Y') ? false : true,
      locn_box_po_no: (providerupdate.locn_box_po_no === 'Y') ? false : true,
      locn_state_cd: (providerupdate.locn_state_cd === 'Y') ? false : true,
      locn_street_nm: (providerupdate.locn_street_nm === 'Y') ? false : true,
      locn_zip5_no: (providerupdate.locn_zip5_no === 'Y') ? false : true
    }
  }
  
  private payForeignFn(providerupdate: any){
    return {
      pay_foreign_unit: (providerupdate.pay_unit_type_sw === 'Y') ? false : true,
      pay_foreign_pbox: (providerupdate.pay_foreign_pbox === 'Y') ? false : true,
      pay_foreign_state: (providerupdate.pay_state_cd_sw === 'Y') ? false : true,
      pay_foreign_streetname: (providerupdate.pay_street_tx_sw === 'Y') ? false : true,
      pay_foreign_zip: (providerupdate.pay_zip5_no_sw === 'Y') ? false : true
    }
  }
}


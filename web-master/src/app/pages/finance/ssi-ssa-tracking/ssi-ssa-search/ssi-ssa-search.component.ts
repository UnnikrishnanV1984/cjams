import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { DataStoreService } from '../../../../@core/services';
import { FinanceStoreConstants } from '../../finance.constants';

@Component({
    selector: 'ssi-ssa-search',
    templateUrl: './ssi-ssa-search.component.html',
    styleUrls: ['./ssi-ssa-search.component.scss'],
    standalone: false
})
export class SsiSsaSearchComponent implements OnInit {

  ssiSsaFormGroup!: FormGroup;
  client_id: any;
  client_name: any;
  dobdaterangefrom: any;
  dobdaterangeto: any;
  ssn: any;
  caseworker_name: any;

  constructor(
    private formBuilder: FormBuilder,
    private _datatoreService: DataStoreService
  ) { }

  ngOnInit() {
    this.ssiSsaFormGroup = this.formBuilder.group({
      client_id: [null],
      client_firstname: [null],
      client_lastname: [null],
      client_middlename: [null],
      dobdaterangefrom: [null],
      dobdaterangeto: [null],
      ssn: [null],
      caseworker_name: [null],
      ayear: ['Y']
    });
    setTimeout(() => {
      const searchParams = this._datatoreService.getData(FinanceStoreConstants.AccountsReceivableSearchParams);
      if (searchParams) {
          this.ssiSsaFormGroup.patchValue(searchParams);
      }
  }, 100);
  }

  // getSsiSsaClientDetails() {
  //   this._commonService.getPagedArrayList({
  //     limit: this.paginationInfo.pageSize,
  //     page: this.paginationInfo.pageNumber,
  //     where: {
  //           client_id: (this.client_id) ? this.client_id : null,
  //           client_name:  (this.client_name) ? this.client_name : null,
  //           ssn :  (this.ssn) ? this.ssn : null,
  //           dobdaterangefrom : (this.dobdaterangefrom) ? this.dobdaterangefrom : null,
  //           dobdaterangeto : (this.dobdaterangeto) ? this.dobdaterangefrom : null,
  //           caseworker_name : (this.caseworker_name) ? this.caseworker_name : null
  //         },
  //     method: 'post'
  //   }, FinanceUrlConfig.EndPoint.ssiSsaTracking.listSsiSsaClientDetails).subscribe((res: any) => {
  //       if (res) {
         
  //       }
  //   });

    searchProviders() {
      const searchParams = this.ssiSsaFormGroup.getRawValue();
      this._datatoreService.setData(FinanceStoreConstants.AccountsReceivableSearchParams, searchParams);
    }

    clearSearch() {
      this.ssiSsaFormGroup.reset();
      this._datatoreService.setData(FinanceStoreConstants.AccountsReceivableSearchParams, null);
    }

}

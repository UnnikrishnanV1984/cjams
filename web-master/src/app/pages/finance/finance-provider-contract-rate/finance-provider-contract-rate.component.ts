import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonHttpService, AlertService } from '../../../@core/services';
import { PaginationRequest, PaginationInfo } from '../../../@core/entities/common.entities';

@Component({
    selector: 'finance-provider-contract-rate',
    templateUrl: './finance-provider-contract-rate.component.html',
    styleUrls: ['./finance-provider-contract-rate.component.scss'],
    standalone: false
})
export class FinanceProviderContractRateComponent implements OnInit {

  paginationInfo: PaginationInfo = new PaginationInfo();
  providerContractForm!: FormGroup;
  providerName!: boolean;
  providerID!: boolean;
  taxID!: boolean;
  providerList!: any[];
  totalcount: any;
  providerProgramList!: any[];
  totalResult: any;
  pageInfo: PaginationInfo = new PaginationInfo();
  id: any;
  provider: any;
  collapseinclass = '.collapse.in';
  constructor(
    private _formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService,
    private _alertService: AlertService
  ) { }

  ngOnInit() {
    this.initiateForm();
  }

  initiateForm() {
      this.providerContractForm = this._formBuilder.group({
        prid: ['pid'],
        providerid: [null],
        pname: [null],
        providername: [null],
        providerfirstnm: [null],
        providerlastnm: [null],
        txid: [null],
        taxid: [null]
      });
      this.providerCheck('pid');
  }

  providerCheck(value: string) {
    if (value === 'pnm') {
      this.providerContractForm.patchValue({
        prid: null,
        txid: null,
        taxid: null,
        providerid: null,
      });
      this.providerName = true;
      this.providerID = false;
      this.taxID = false;
      this.providerContractForm.controls['taxid'].clearValidators();
      this.providerContractForm.controls['providerid'].clearValidators();
      this.providerContractForm.controls['taxid'].disable();
      this.providerContractForm.controls['providerid'].disable();
    } else if (value === 'pid') {
      this.providerContractForm.patchValue({
        pname: null,
        txid: null,
        providername: null,
        providerfirstnm: null,
        providerlastnm: null,
        taxid: null
      });
      this.providerName = false;
      this.providerID = true;
      this.taxID = false;
      this.providerContractForm.controls['providerid'].enable();
      this.providerContractForm.controls['providerid'].setValidators(Validators.required);
      this.providerContractForm.controls['providerlastnm'].clearValidators();
      this.providerContractForm.controls['providerid'].updateValueAndValidity();
      this.providerContractForm.controls['providername'].clearValidators();
      this.providerContractForm.controls['taxid'].clearValidators();
      this.providerContractForm.controls['taxid'].disable();
    } else {
      this.providerContractForm.patchValue({
        prid: null,
        pname: null,
        providername: null,
        providerfirstnm: null,
        providerlastnm: null,
        providerid: null
      });
      this.providerContractForm.controls['taxid'].enable();
      this.providerContractForm.controls['taxid'].setValidators(Validators.required);
      this.providerContractForm.controls['providername'].clearValidators();
      this.providerContractForm.controls['taxid'].updateValueAndValidity();
      this.providerContractForm.controls['providerid'].clearValidators();
      this.providerContractForm.controls['providerlastnm'].clearValidators();
      this.providerContractForm.controls['providerid'].disable();
      this.providerName = false;
      this.providerID = false;
      this.taxID = true;
    }
  }

  searchProviderContract(providerContractForm: any) {
    this.pageInfo.pageNumber = 1;
    (<any>$(this.collapseinclass)).collapse('hide');
    (<any>$('#' + this.id)).collapse('hide');
    this.providerList = [];
    const modal = providerContractForm;
    if (this.providerName) {
      if (!(modal.providername || modal.providerfirstnm || modal.providerlastnm)) {
        this._alertService.error('Provider name should not be empty');
        return false;
      }
    }
    modal.providerid = providerContractForm.providerid ? providerContractForm.providerid : null;
    modal.taxid = providerContractForm.taxid ? providerContractForm.taxid : null;
    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'post',
        where: modal
        }), 'tb_payment_header/getprovidercontract'
    ).subscribe((result: any) => {
      if (result) {
        this.providerList = result.data ? result.data : null;
        this.totalcount = (this.providerList && this.providerList.length > 0) ? this.providerList[0].totalcount : 0;
      }
    });
  }

  programList(id: string, provider: any, show?: boolean) {
    this.id = id;
    this.provider = provider;
    this.providerProgramList = [];
   if(show){
    (<any>$(this.collapseinclass)).collapse('show');
    (<any>$('#' + this.id)).collapse('show');
   } else {
    (<any>$(this.collapseinclass)).collapse('hide');
    (<any>$('#' + id)).collapse('toggle');
   }
    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: this.pageInfo.pageSize,
        page: this.pageInfo.pageNumber,
        method: 'get',
        where: {
          providerid: provider.provider_id
        }
        }), 'tb_payment_header/getprovidercontractrate?filter'
    ).subscribe((result: any) => {
      if (result) {
        this.providerProgramList = result ? result : null;
        this.totalResult = (this.providerProgramList && this.providerProgramList.length > 0) ? this.providerProgramList[0].totalcount : 0;
      }
    });
  }

  pageNumberChanged(page: any) {
    this.pageInfo.pageNumber = page;
    this.programList(this.id, this.provider, true);
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page;
    this.searchProviderContract(this.providerContractForm.getRawValue());
  }

  clearSearch() {
    this.providerContractForm.reset();
    this.providerList = [];
    this.paginationInfo.pageNumber = 1;
    this.totalcount = 0;
    this.providerContractForm.patchValue({
      prid: 'pid',
      txid: null,
      providername: null,
      providerfirstnm: null,
      providerlastnm: null,
      taxid: null
    });
    this.providerCheck('pid');
    this.pageInfo.pageNumber = 1;
    (<any>$(this.collapseinclass)).collapse('hide');
    (<any>$('#' + this.id)).collapse('hide');
  }

}

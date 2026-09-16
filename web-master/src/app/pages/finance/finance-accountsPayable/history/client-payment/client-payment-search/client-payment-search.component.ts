import { Component, OnInit, EventEmitter, Output } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CommonHttpService,DataStoreService } from '../../../../../../@core/services';
import { ClientPayment } from '../../../../finance.constants';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../../finance.url.config';

@Component({
    selector: 'client-payment-search',
    templateUrl: './client-payment-search.component.html',
    styleUrls: ['./client-payment-search.component.scss'],
    standalone: false
})
export class ClientPaymentSearchComponent implements OnInit {
  clientSearchForm!: FormGroup;
  localDepartmentList:any[]=[];
  @Output() searchEmitter = new EventEmitter<any>();
  clientName = false;
  sName = true;

  constructor(
    private _dataStoreService: DataStoreService,
    private formBuilder: FormBuilder,
    private _commonService: CommonHttpService
  ) { }

  ngOnInit() {
    this.clientSearchForm = this.formBuilder.group({
      // client_id: [null],
      // client_name: [null],
      daterangefrom: [null],
      daterangeto: [null],
      ssn: [null],
      caseworker_name: [null],
      local_dept: [null],
      clientid: [null],
      cnm: [null],
      clId: ['cid'],
      v_firstname: [null],
      v_lastname: [null],
      ssnName: [null]
      // ayear: ['Y']
    });
  this.populateLocalDropDownType();
  this.clientSearchForm.controls['ssn'].disable();
  this._dataStoreService.setData(ClientPayment.ClientPaymentSearchParams, null);
  }

  searchClient() {
    const searchParams = this.clientSearchForm.getRawValue();
    this._dataStoreService.setData(ClientPayment.ClientPaymentSearchParams, searchParams);
    this.searchEmitter.emit();
  }

  clearSearch() {
    this.clientSearchForm.reset();
    this._dataStoreService.setData(ClientPayment.ClientPaymentSearchParams, null);
    this.searchEmitter.emit();
  }



  populateLocalDropDownType(){
    this.localDepartmentList = [];
    this._commonService.getArrayList(new PaginationRequest({
        where: {
          'picklist_type_id': '104'
        },
        nolimit: true,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result) => {
        return result.filter((res) => {
          this.localDepartmentList.push(res);
    });
    });
  }

  clientCheck(value:any) {
    this.clientSearchForm.patchValue({
      ssn: null,
      clientid: null,
      clientfirstnm: null,
      clientlastnm: null
    });
    if (value === 'cid') {
      this.clientSearchForm.patchValue({
        cnm: null,
        ssnName: null,
        v_firstname: null,
        v_lastname: null
      });
      this.clientSearchForm.controls['clientid'].enable();
      this.clientSearchForm.controls['ssn'].disable();
      this.clientName = false;
      this.sName = true;
    } else if (value === 'sname') {
      this.clientSearchForm.patchValue({
        cnm: null,
        clId: null,
        v_firstname: null,
        v_lastname: null
      });
      this.clientName = false;
      this.sName = false;
      this.clientSearchForm.controls['clientid'].disable();
      this.clientSearchForm.controls['ssn'].enable();
    } else {
      this.clientSearchForm.patchValue({
       clId: null,
       ssnName: null
      });
      this.clientName = true;
      this.sName = true;
      this.clientSearchForm.controls['clientid'].disable();
      this.clientSearchForm.controls['ssn'].disable();
    }
  }
}

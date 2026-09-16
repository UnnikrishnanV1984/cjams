import { Component, OnInit, Output, EventEmitter, ChangeDetectorRef } from '@angular/core';

import { FormBuilder, FormGroup, Validators, ValidatorFn, ValidationErrors } from '@angular/forms';
import { CommonHttpService,DataStoreService } from '../../../../../../@core/services';
import { FinanceFundingSource } from '../../../../finance.constants';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../../finance.url.config';
import { map } from 'rxjs/operators';
import { Observable } from 'rxjs/internal/Observable';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'funding-allocation-search',
    templateUrl: './funding-allocation-search.component.html',
    styleUrls: ['./funding-allocation-search.component.scss'],
    standalone: false
})
export class FundingAllocationSearchComponent implements OnInit {
  fundingSearchForm!: FormGroup;
   paymentType$!: Observable<any[]>;
  @Output() searchFundingEmitter = new EventEmitter<any>();
  localDepartmentList:any[]=[];
  constructor(
    private _dataStoreService: DataStoreService,
    private formBuilder: FormBuilder,
    private _commonService: CommonHttpService,
    private cd: ChangeDetectorRef
  ) { }

  ngOnInit() {
    this.getAccountType();
    this.fundingSearchForm = this.formBuilder.group({
      client_id: [null],
      client_last_name: [null],
      client_first_name: [null],
      dobdaterangefrom: [null],
      dobdaterangeto: [null],
      ssn: [null],
      caseworker_name: [null],
      local_dept: [null],
      payment_type_cd: [[]]
     // ayear: ['Y']
    }, { validators: this.atleastOne(Validators.required) });
    setTimeout(() => {
      const searchParams = this._dataStoreService.getData(FinanceFundingSource.FundingSourceSearchParams);
      if (searchParams) {
          this.fundingSearchForm.patchValue(searchParams);
          this.fundingSearchForm.markAsDirty();
          this.cd.detectChanges();
      }
  }, 100);
  this.populateLocalDropDownType();
  }

   getAccountType() {
  
          this.paymentType$ = this._commonService.getArrayList(new PaginationRequest({
              where: {
                'picklist_type_id': '2'
              },
              nolimit: true,
              method: 'get'
            }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).pipe(map((result) => {
              return result.filter((res) => {
               return ['5689', '7', '6', '3294'].includes(res.picklist_value_cd)
          });
        }));
        }

  atleastOne = (validator: ValidatorFn) => (group: FormGroup): ValidationErrors | null => {
    const controls = group.controls;
    const validFields = Object.keys(controls).filter(
      (k) => !validator(controls[k])
    );

    return validFields.length >= 1 ? null : { atleastOne: true }
  };

  searchClient() {
    const searchParams = this.fundingSearchForm.getRawValue();
    this._dataStoreService.setData(FinanceFundingSource.FundingSourceSearchParams, searchParams);
    this.searchFundingEmitter.emit();
  }


  clearSearch() {
    this.fundingSearchForm.reset();
    this._dataStoreService.setData(FinanceFundingSource.FundingSourceSearchParams, null);
    this.searchFundingEmitter.emit();
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

}

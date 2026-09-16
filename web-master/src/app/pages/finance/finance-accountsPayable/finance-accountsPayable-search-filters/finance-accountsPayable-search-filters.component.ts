
import {map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, Subject } from 'rxjs';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services/generic.service';
import { FinanceUrlConfig } from '../../finance.url.config';
import { FinanceAccountsPayableSearchEntry } from '../../_entities/finance-entity.module';
import { DataStoreService, CommonHttpService, AlertService } from '../../../../@core/services';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-finance-accountsPayable-search-filters',
    templateUrl: './finance-accountsPayable-search-filters.component.html',
    styleUrls: ['./finance-accountsPayable-search-filters.component.scss'],
    standalone: false
})

export class FinanceAccountsPayableSearchFiltersComponent implements OnInit {

    @Input() searchData$!: Subject<Observable<FinanceAccountsPayableSearchEntry[]>>;
    @Input() totalSearchRecord$!: Subject<Observable<number>>;
    @Input() pageNumberSearch$!: Subject<number>;

    accountsPayableSearch: FinanceAccountsPayableSearchEntry;
    accountsPayableFormGroup: FormGroup;
    localDept: any[]=[];
    paymentType$!: Observable<any[]>;
    paymentStatus: any[]=[];
    paymentType: any[]=[];
  providerName:boolean=false;
  providerID = true;
  taxID:boolean=false;
  clientName = false;
  displayValidationMessages =false;

    constructor(private formBuilder: FormBuilder, private _service: GenericService<FinanceAccountsPayableSearchEntry>,
        private _dataStoreService: DataStoreService,
        private _commonService: CommonHttpService,
        private _alertService: AlertService) {
        this._service.endpointUrl = FinanceUrlConfig.EndPoint.accountsPayable.getAccountsPayableInfo;

        this.accountsPayableSearch = new FinanceAccountsPayableSearchEntry();
        this.accountsPayableSearch.sortdir = 'asc';
        this.accountsPayableSearch.sortcol = 'paymentid';
        this.accountsPayableSearch.activeflag = '1';

        this.accountsPayableFormGroup = this.formBuilder.group({
            paymentid: [''],
            taxid: ['', Validators.required],
            providerid: ['', Validators.required],
            providername: [''],
            clientid: [''],
            address: [''],
            zip: [''],
            state: [''],
            daterangeto: [''],
            daterangefrom: [''],
            city: [''],
            county: [''],
            region: [''],
            phone: [''],
            ssn: [''],
            dcn: [''],
            firstname: [''],
            clientname: [''],
            dobdaterangefrom: [null],
            dobdaterangeto: [null],
            ayear: ['Y'],
            payment_type_cd: [null],
            county_cd: [null],
            payment_status_cd: [null],
            providerfirstnm: [''],
            providerlastnm: [''],
            prid: ['pid'],
            pname: [null],
            pmnid: [null],
            cnm: [null],
            clId: ['cid'],
            clientfirstnm: [null],
            clientlastnm: [null]

        });
        this.accountsPayableFormGroup.controls['taxid'].disable();
    }

    ngOnInit() {
        this._dataStoreService.setData('AccountPayableSerchFilter', null);
        this.pageNumberSearch$.subscribe(data => {
            this.searchAccountsPayable(data, this.accountsPayableSearch);
        });
        this.getAccountType();
        const getSearchdata = this._dataStoreService.getData('FinanceProviderSearch');
        if (getSearchdata && (getSearchdata.page === 'Both' || getSearchdata.page === 'Ancillary')) {
          this.accountsPayableFormGroup.reset();
          this.accountsPayableFormGroup.patchValue({
            providerid: getSearchdata.providerId
          });
          this.searchAccountsPayable(1, this.accountsPayableFormGroup.getRawValue());
          this._dataStoreService.setData('FinanceProviderSearch', null);
        }
    }

    searchAccountsPayable(pageNo: number, modal: FinanceAccountsPayableSearchEntry) {
      this.displayValidationMessages =false;
      ['providerid', 'taxid'].forEach((item:any)=> {
        this.accountsPayableFormGroup?.get(item)?.setValidators([Validators.required]);
        this.accountsPayableFormGroup?.get(item)?.updateValueAndValidity();
      });
      if (this.accountsPayableFormGroup.invalid) {
          this.displayValidationMessages =true;
          this.accountsPayableFormGroup.markAllAsTouched();
      }
      if (this.accountsPayableFormGroup.valid) {
        if (this.providerName) {
          if (!(modal.providername || modal.providerfirstnm || modal.providerlastnm)) {
            this._alertService.error('Provider name should not be empty');
          } else {
            this._dataStoreService.setData('paymentid', null);
            this._dataStoreService.setData('AccountPayableSerchFilter', modal);
          }
        } else {
          this._dataStoreService.setData('paymentid', null);
          this._dataStoreService.setData('AccountPayableSerchFilter', modal);
        }
      } else {
         this._alertService.error('Please fill mandatory fields');
      }
    }

    clearSearch() {
      this._dataStoreService.setData('paymentid', null);
      this._dataStoreService.setData('AccountPayableSerchFilter', 'clear');
        this.accountsPayableFormGroup.reset();
        this.accountsPayableFormGroup.patchValue({
          county: '', region: '', gender: '', race: '', prid: ['pid'],
          providerfirstnm: [''],
          providerlastnm: [''],
          pname: [null],
          pmnid: [null],
          clId: ['cid'],
        });
        this.providerCheck('pid');
        this.clientCheck('cid');
    }

    getAccountType() {
        this._commonService.getArrayList(new PaginationRequest({
          where: {
            'picklist_type_id': '133'
          },
          nolimit: true,
          method: 'get'
        }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result:any) => {
          this.paymentStatus = result;
        });

        this.paymentType$ = this._commonService.getArrayList(new PaginationRequest({
            where: {
              'picklist_type_id': '2'
            },
            nolimit: true,
            method: 'get'
          }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).pipe(map((result) => {
            return result.filter((res) => {
              if (res.picklist_value_cd === '4' || res.picklist_value_cd === '5989') {
               // return res;
            } else {
              return res;
            }
        });
      }));
          this._commonService.getArrayList(new PaginationRequest({
            where: {
              'picklist_type_id': '104'
            },
            nolimit: true,
            method: 'get'
          }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl).subscribe((result:any) => {
            this.localDept = result;
          });
      }

      providerCheck(value:any) {
        if (value === 'pnm') {
          this.accountsPayableFormGroup.patchValue({
            prid: null,
            pmnid: null,
            taxid: null,
            providerid: null,
          });
          this.providerName = true;
          this.providerID = false;
          this.taxID = false;
          this.accountsPayableFormGroup.controls['taxid'].clearValidators();
          this.accountsPayableFormGroup.controls['providerid'].clearValidators();
          this.accountsPayableFormGroup.controls['taxid'].disable();
          this.accountsPayableFormGroup.controls['providerid'].disable();
        } else if (value === 'pid') {
          this.accountsPayableFormGroup.patchValue({
            pname: null,
            pmnid: null,
            providername: null,
            providerfirstnm: null,
            providerlastnm: null,
            taxid: null
          });
          this.providerName = false;
          this.providerID = true;
          this.taxID = false;
          this.accountsPayableFormGroup.controls['providerid'].enable();
          this.accountsPayableFormGroup.controls['providerid'].setValidators(Validators.required);
          this.accountsPayableFormGroup.controls['providerlastnm'].clearValidators();
          this.accountsPayableFormGroup.controls['providerid'].updateValueAndValidity();
          this.accountsPayableFormGroup.controls['providername'].clearValidators();
          this.accountsPayableFormGroup.controls['taxid'].clearValidators();
          this.accountsPayableFormGroup.controls['taxid'].disable();
        } else {
          this.accountsPayableFormGroup.patchValue({
            prid: null,
            pname: null,
            providername: null,
            providerfirstnm: null,
            providerlastnm: null,
            providerid: null
          });
          this.accountsPayableFormGroup.controls['taxid'].enable();
          this.accountsPayableFormGroup.controls['taxid'].setValidators(Validators.required);
          this.accountsPayableFormGroup.controls['providername'].clearValidators();
          this.accountsPayableFormGroup.controls['taxid'].updateValueAndValidity();
          this.accountsPayableFormGroup.controls['providerid'].clearValidators();
          this.accountsPayableFormGroup.controls['providerlastnm'].clearValidators();
          this.accountsPayableFormGroup.controls['providerid'].disable();
          this.providerName = false;
          this.providerID = false;
          this.taxID = true;
        }
      }
      clientCheck(value:any) {
        if (value === 'cid') {
          this.accountsPayableFormGroup.patchValue({
            cnm: null,
            clientfirstnm: null,
            clientlastnm: null
          });
          this.clientName = false;
          this.accountsPayableFormGroup.controls['clientid'].enable();
        } else {
          this.accountsPayableFormGroup.patchValue({
           clId: null
          });
          this.clientName = true;
          this.accountsPayableFormGroup.controls['clientid'].disable();
        }
      }

      getErrorsMessage(ControlName:any, displayName:any){
        if(this.accountsPayableFormGroup.controls[ControlName].status =='INVALID' ){
        return 'Please enter ' + displayName
        }
      }
}

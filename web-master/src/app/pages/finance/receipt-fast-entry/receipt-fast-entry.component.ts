
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService, AlertService, AuthService } from '../../../@core/services';
import { DropdownModel, PaginationInfo } from '../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { FinanceUrlConfig } from '../finance.url.config';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ReceiptEntry } from '../_entities/finance-entity.module';
import { AppUser } from '../../../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { of } from 'rxjs';

@Component({
    selector: 'receipt-fast-entry',
    templateUrl: './receipt-fast-entry.component.html',
    styleUrls: ['./receipt-fast-entry.component.scss'],
    standalone: false
})
export class ReceiptFastEntryComponent implements OnInit {
  paymentTypes$!: Observable<DropdownModel []>;
  receiptType$!: Observable<DropdownModel[]>;
  accountType$: Observable<DropdownModel[]> = of([]);
    receiptForm!: FormGroup;
  viewReceiptEntry!: FormGroup;
  receiptEntryList: any[] = [];
  receiptFastEntry!: ReceiptEntry;
  userProfile!: AppUser;
  disableSave!: boolean;
  bulkReceipt: any[] = [];
  enableBulk!: boolean;
  unPostReceiptList: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount!: number;
  pageInfo: PaginationInfo = new PaginationInfo();
  totalpagecount!: number;
  disTransBulk = false;
  disPostBulk = false;
  editReceipt!: boolean;
  selectedAction!: string;
  alertServiceMsg!: string;
  // postReceiptEntry: PostReceipt;
  bulkSaveReceipt!: any[];
  saveBulkTxt!: string;
  dupResponse: any[]= [];
  tabName!: string;
  selectPostBulk!: boolean;
  selectTransBulk!: boolean;
  savBtn!: string;
  clientName = null;
  clientId = null;
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  isVissbleButton!: boolean;
  displayValidationMessages =false;
  fastentrydetailspopupid = '#fast-entry-details';

  constructor(
    private _commonService: CommonHttpService,
    private _formBuilder: FormBuilder,
    private _alertService: AlertService,
    private _authService: AuthService

  ) { }

  ngOnInit() {
    this.userProfile = this._authService.getCurrentUser();
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this.loadaccountType();
    this.paginationInfo.pageNumber = 1;
    this.buildForm();
    this.selectedAction = 'transactionTab';
    this.saveBulkTxt = 'Save BulK Transaction';

  }

  buildForm() {
    this.receiptForm = this._formBuilder.group({
      account_type_cd: ['', Validators.required],
      transaction_source_cd: ['', Validators.required]
    });

    this.viewReceiptEntry = this._formBuilder.group({
      client_id: [null],
      account_no_tx: [null],
      client_name: [null],
      transaction_amount_no: [null],
      ssno: [null],
      account_type: [null],
      entered_by: [null],
      benefit_start_dt: [null],
      benefit_end_dt: [null],
      notes_tx: [''],
      transaction_source: [null],
      entered_dt: [null],
      post_sw: [null]
    });
  }

  loadaccountType(): void {
    this.accountType$ = this._commonService?.getArrayList({
      where: { picklist_type_id: '40' },
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.receiptFastEntry.receiptPicklist + '?filter'
    ).pipe(
      map((result: any[]) => {
        const resultAcc: any[] = [];
        if (result) {
          const item = result.find((item: any) => item.picklist_value_cd === '590');
          if (item) {
            resultAcc.push(item);
          }
        }
        return resultAcc.map(
          (res) =>
            new DropdownModel({
              text: res.value_tx,
              value: res.picklist_value_cd
            })
        );
      }),
      map((items: DropdownModel[]) => items ?? [])
    );
  }
  

  onAccountChange(accountType: any) {
    this.receiptType$ = this._commonService.getArrayList({
      where: {picklist_type_id : '38'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.receiptFastEntry.receiptPicklist + '?filter'
    ).pipe( map((result:any) => {
      return result.filter((res:any) => {
        if (accountType !== '592') {
            if (res.picklist_value_cd === '585' || res.picklist_value_cd === '586' ||
              res.picklist_value_cd === '587') {
                   return res;
            }
        } else {
            if (res.picklist_value_cd === '585') {
                  return res;
            }
        }
  });
}));
  }

  getTransaction(tabName: string) {
    this.selectedAction = tabName;
    this.saveBulkTxt = 'Save BulK Transaction';
    this.bulkReceipt = [];
    this.disPostBulk = false;
    this.selectTransBulk = false;
    this.getReceiptEntryList();
  }

  searchReceiptEntry(searchTerm: string) {
    if (searchTerm === 'clientId') {
      this.clientName = null;
    } else {
      this.clientId = null;
    }
    this.getReceiptEntryList();
  }

  getReceiptEntryList() {
    this.displayValidationMessages =false;
		['account_type_cd', 'transaction_source_cd'].forEach((item) => {
			this.receiptForm?.get(item)?.setValidators([Validators.required]);
			this.receiptForm?.get(item)?.updateValueAndValidity();
		});
    if (this.receiptForm.invalid) {
        this.displayValidationMessages =true;
        this.receiptForm.markAllAsTouched();
        return;
    }  
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.receiptFastEntry.receiptEntryList;
    const modal = {
      account_type_cd: this.receiptForm.get('account_type_cd')?.value ?  this.receiptForm.get('account_type_cd')?.value : '',
      transaction_source_cd:  this.receiptForm.get('transaction_source_cd')?.value ?  this.receiptForm.get('transaction_source_cd')?.value : '',
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      client_id: this.clientId,
      client_name: this.clientName
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        if (response) {
          this.receiptEntryList = response;
          const check = this.receiptEntryList.find((res: any) => !res.post_sw);
          if (check) {
            this.disTransBulk = true;
          } else {
            this.disTransBulk = false;
          }
  
          this.dupResponse = [...this.receiptEntryList];
          this.totalcount = (this.receiptEntryList && this.receiptEntryList.length > 0) ? this.receiptEntryList[0].totalcount : 0;
        }
      }
    );
  }

  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.getReceiptEntryList();
  }

  viewTransaction(transaction: any) {
    this.savBtn = 'Save';
    this.receiptFastEntry = transaction;
    this.receiptFastEntry.benefit_start_dt = transaction.current_mon_start_day;
    this.receiptFastEntry.benefit_end_dt = transaction.current_mon_end_day;
    this.viewReceiptEntry.patchValue(transaction);
    this.viewReceiptEntry.patchValue({
      entered_by: this.userProfile.user.username,
      entered_dt: new Date(),
      benefit_start_dt: transaction.current_mon_start_day,
      benefit_end_dt: transaction.current_mon_end_day
    });
    this.viewReceiptEntry.disable();
    if (!transaction.post_sw) {
      this.viewReceiptEntry.get('benefit_start_dt')?.enable();
      this.viewReceiptEntry.get('benefit_end_dt')?.enable();
      this.viewReceiptEntry.get('transaction_amount_no')?.enable();
      this.viewReceiptEntry.get('notes_tx')?.enable();
      this.viewReceiptEntry.get('post_sw')?.enable();
      this.editReceipt = true;
    } else {
      this.editReceipt = false;
    }

  }

  receivedReceipt(event: any) {
    if (event) {
      this.disableSave = true;
      this.receiptFastEntry.post_sw = 'N';
    } else {
      this.disableSave = false;
      this.receiptFastEntry.post_sw = null;
    }
  }

  getBulk(event: any) {
    this.bulkReceipt = [];
   if (event) {
      this.enableBulk = true;
      for (let i = 0; i < this.dupResponse.length; i++) {
        this.dupResponse[i].create_user_id = this.userProfile.user.securityusersid;
        this.dupResponse[i].update_user_id = this.userProfile.user.securityusersid;
        this.dupResponse[i].delete_sw = 'N';
        this.dupResponse[i].benefit_start_dt = this.dupResponse[i].current_mon_start_day;
        this.dupResponse[i].benefit_end_dt = this.dupResponse[i].current_mon_end_day;
        this.dupResponse[i].post_dt = new Date();
        if (this.selectedAction === 'transactionTab') {
          this.ifTransactionTabFn(i);
        } else if (this.selectedAction === 'unPostTab') {
          this.ifUnPostTabFn(i);
        }
     }
    } else {
      this.enableBulk = false;
      this.selectPostBulk = false;
      this.selectTransBulk = false;
      if (this.selectedAction === 'transactionTab') {
        (<any>$('.trans')).prop('checked', false);
      } else {
        (<any>$('.unpost')).prop('checked', false);
      }

    }
  }


  private ifUnPostTabFn(i: number) {
    if (this.dupResponse[i].post_sw === 'N') {
      // (<any>$('#unpost-id-' + i)).prop('checked', true);
      this.selectTransBulk = false;
      this.selectPostBulk = true;
      this.dupResponse[i].post_sw = 'Y';

      this.dupResponse[i].frequency_cd = 'Yes';
      this.bulkReceipt.push({ ...this.dupResponse[i] });
      this.dupResponse[i].post_sw = 'N';
      (<any>$('.unpost')).prop('checked', true);
    }
  }

  private ifTransactionTabFn(i: number) {
    if (!this.dupResponse[i].post_sw) {
      (<any>$('#trans-id-' + i)).prop('checked', true);
      this.selectTransBulk = true;
      this.dupResponse[i].post_sw = 'N';
      this.bulkReceipt.push({ ...this.dupResponse[i] });
      this.dupResponse[i].post_sw = null;
    }
  }

  saveReceipt() {
    this.receiptFastEntry.create_user_id = this.userProfile.user.securityusersid;
    this.receiptFastEntry.update_user_id = this.userProfile.user.securityusersid;
    this.receiptFastEntry.delete_sw = 'N';
    this.receiptFastEntry.transaction_amount_no = this.viewReceiptEntry.get('transaction_amount_no')?.value;
    if (this.selectedAction === 'transactionTab') {
      this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.receiptFastEntry.receiptSave;
        this.alertServiceMsg = 'Receipt Entry Saved Successfully';
        this.receiptFastEntry.create_user_id = this.userProfile.user.securityusersid;
        this.receiptFastEntry.update_user_id = this.userProfile.user.securityusersid;
        this.receiptFastEntry.delete_sw = 'N';
        this.receiptFastEntry.post_dt = new Date();
        this._commonService.create({fast_entry: [this.receiptFastEntry]}).subscribe(
          (response:any) => {
            this._alertService.success(this.alertServiceMsg);
            (<any>$(this.fastentrydetailspopupid)).modal('hide');
            this.getReceiptEntryList();
          },
          (error:any) => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
        );
    } else if (this.selectedAction === 'unPostTab') {
        this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.receiptFastEntry.receiptPostUpdate;
        this.alertServiceMsg = 'Receipt Entry Posted Successfully';
        this.receiptFastEntry.frequency_cd = 'Yes';
        this.receiptFastEntry.post_sw = 'Y';
        this.receiptFastEntry.post_dt = new Date();
        this._commonService.create({fast_entry: [this.receiptFastEntry]}).subscribe(
          (response:any) => {
            this._alertService.success(this.alertServiceMsg);
            (<any>$(this.fastentrydetailspopupid)).modal('hide');
            this.getUnpostReceipt('unPostTab');
          },
          (error:any) => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
        );
    }
  }

  transChanged(event:any, receiptdata: any) {
    const checked :boolean =event.target.checked
    const receipt = JSON.parse(JSON.stringify(receiptdata));
    const selectedReceipt = (this.bulkReceipt && this.bulkReceipt.length > 0) ? this.bulkReceipt.find(rec => rec.transaction_id === receipt.transaction_id) : null;
    receipt.create_user_id = this.userProfile.user.securityusersid;
    receipt.update_user_id = this.userProfile.user.securityusersid;
    receipt.delete_sw = 'N';
    receipt.benefit_start_dt = receipt.current_mon_start_day;
    receipt.benefit_end_dt = receipt.current_mon_end_day;
    receipt.post_dt = new Date();
    if (checked) {
      if (!selectedReceipt) {
        receipt.post_sw = 'N';
        this.bulkReceipt.push(receipt);
      }
    } else {
      if (selectedReceipt) {
        this.selectTransBulk = false;
        this.bulkReceipt = this.bulkReceipt.filter(rec => rec.transaction_id !== receipt.transaction_id);
      }
    }
    this.enableBulk = !!this.bulkReceipt.length;
    const receptlist = this.receiptEntryList.filter((data: any) => !data.post_sw);
    if (this.bulkReceipt.length !== 0) {
      const bulkcheckboxselect = (receptlist.length === this.bulkReceipt.length);
      if (bulkcheckboxselect) {
        this.selectTransBulk = true;
      } else {
        this.selectTransBulk = false;
      }
    } else {
      this.selectTransBulk = false;
    }
  }

  postChanged(event: any, receiptdata: any) {
    const checked:any = event.target.value
    const receipt = JSON.parse(JSON.stringify(receiptdata));
    const selectedReceipt = (this.bulkReceipt && this.bulkReceipt.length > 0) ? this.bulkReceipt.find(rec => rec.transaction_id === receipt.transaction_id) : null;
    receipt.create_user_id = this.userProfile.user.securityusersid;
    receipt.update_user_id = this.userProfile.user.securityusersid;
    receipt.delete_sw = 'N';
    receipt.benefit_start_dt = receipt.current_mon_start_day;
    receipt.benefit_end_dt = receipt.current_mon_end_day;
    if (checked) {
      if (!selectedReceipt) {
        receipt.post_sw = 'Y';
        this.bulkReceipt.push(receipt);
      }
    } else {
      if (selectedReceipt) {
        this.selectPostBulk = false;
        this.bulkReceipt = this.bulkReceipt.filter(rec => rec.transaction_id !== receipt.transaction_id);
      }
    }
    this.enableBulk = !!this.bulkReceipt.length;
    const receptlist = this.unPostReceiptList;
    if (this.bulkReceipt.length !== 0) {
      const bulkcheckboxselect = (receptlist.length === this.bulkReceipt.length);
      if (bulkcheckboxselect) {
        this.selectPostBulk = true;
      } else {
        this.selectPostBulk = false;
      }
    } else {
      this.selectPostBulk = false;
    }
  }

  saveBulkReceipt() {

    if (this.selectedAction === 'transactionTab') {
      this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.receiptFastEntry.receiptSave;
    } else if (this.selectedAction === 'unPostTab') {
      this.tabName = 'unPostTab';
      
      this.bulkReceipt.forEach(data => {
        data.transaction_id = null;
      });
      this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.receiptFastEntry.receiptPostUpdate;
    }
    this._commonService.create({fast_entry: this.bulkReceipt}).subscribe(
      (response:any) => {
        this._alertService.success('Selected Receipt Entry Saved Successfully');
        (<any>$(this.fastentrydetailspopupid)).modal('hide');
        if (this.tabName === 'unPostTab') {
          this.getUnpostReceipt('unPostTab');
          this.selectPostBulk = false;

        } else {
          this.getReceiptEntryList();
          this.selectTransBulk = false;
         // (<any>$('.trans')).prop('checked', false);
        }
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  getUnpostReceipt(tabName: string) {
    this.selectPostBulk = false;
    this.bulkReceipt = [];
    this.selectedAction = tabName;
    this.disPostBulk = false;
    this.selectTransBulk = false;
    this.saveBulkTxt = 'Post BulK Transaction';

    this.unPostReceiptList = [];
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.receiptFastEntry.receiptEntryList;
    const modal = {
      account_type_cd: this.receiptForm.get('account_type_cd')?.value ?  this.receiptForm.get('account_type_cd')?.value : '',
      transaction_source_cd:  this.receiptForm.get('transaction_source_cd')?.value ?  this.receiptForm.get('transaction_source_cd')?.value : '',
      limit: this.pageInfo.pageSize,
      page: this.pageInfo.pageNumber,
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        response.forEach((element: any) => {
          if (element && element.post_sw === 'N') {
            this.unPostReceiptList.push(element);
            if (this.unPostReceiptList) {
              this.disPostBulk = true;
            } else {
              this.disPostBulk = false;
            }
          }
        });

        this.totalpagecount = (this.unPostReceiptList && this.unPostReceiptList.length > 0) ? this.unPostReceiptList[0].totalcount : 0;
      }
    );
  }

  pageNumberChanged(page: any) {
    this.pageInfo.pageNumber = page;
    this.getUnpostReceipt('unPostTab');
  }

  editUnpostReceipt(receipt: any) {
    this.savBtn = 'Post';
    this.editReceipt = true;
    this.disableSave = true;
    this.receiptFastEntry = receipt;
    this.receiptFastEntry.benefit_start_dt = receipt.current_mon_start_day;
    this.receiptFastEntry.benefit_end_dt = receipt.current_mon_end_day;
    this.receiptFastEntry.transaction_id = null;
    this.viewReceiptEntry.patchValue(receipt);
    this.viewReceiptEntry.patchValue({
      entered_by: this.userProfile.user.username,
      entered_dt: new Date(),
      benefit_start_dt: receipt.current_mon_start_day,
      benefit_end_dt: receipt.current_mon_end_day
    });
    this.viewReceiptEntry.disable();
      this.viewReceiptEntry.get('benefit_start_dt')?.enable();
      this.viewReceiptEntry.get('benefit_end_dt')?.enable();
      this.viewReceiptEntry.get('transaction_amount_no')?.enable();
      this.viewReceiptEntry.get('notes_tx')?.enable();

  }

  checkDec(el: any) {
    let value = el?.target?.value || '';
    if (value) {
      el.target.value = isNaN(value) ? '' : value.replace(/[^0-9.]{0,2}/g, '');
      return el.target.value ;
    }
    return '';
  }

  toggleSsn = () => {
    this.isSsnHidden = !this.isSsnHidden;
    if (this.isSsnHidden) {
      this.ssnEye = 'fa-eye';
      this.showSsnMask = true;
    } else {
      this.ssnEye = 'fa-eye-slash';
      this.showSsnMask = false;
    }
  }

  getErrorsMessage(ControlName: string, displayName: string){
    if(this.receiptForm.controls[ControlName].status =='INVALID' ){
    return 'Please ' + displayName
    }
  }
  closeReceipt(){

  }
}

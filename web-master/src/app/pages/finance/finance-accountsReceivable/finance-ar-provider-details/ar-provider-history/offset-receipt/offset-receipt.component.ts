import { Component, OnInit, Injector } from '@angular/core';
import { CommonHttpService, AuthService, AlertService, DataStoreService } from '../../../../../../@core/services';
import { PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../../finance.url.config';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { ArProviderHistoryService } from '../ar-provider-history.service';
import { FinanceArProviderDetailsService } from '../../finance-ar-provider-details.service';
import moment from 'moment';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'offset-receipt',
    templateUrl: './offset-receipt.component.html',
    styleUrls: ['./offset-receipt.component.scss'],
    standalone: false
})
export class OffsetReceiptComponent implements OnInit {
  paginationInfo: PaginationInfo = new PaginationInfo();
  receipts: any[] = [];
  offsetReceiptFormFroup!: FormGroup;
  paymenttypeList: any[] = [];
  payeeList: any[] = [];
  receipttypeList: any[] = [];
  reasonforreversalList: any[] = [];
  buttontext = 'Add';
  receipt_id = null;
  totalCount!: number;
  receivableDetailID: string='';
  loggedInUser: string='';
  balanceamount: any;
  receiptdetailspopupid = '#receipt-details';
  deletereceiptpopupid = '#delete-receipt-popup';
  
  private formBuilder: FormBuilder; 
  private _commonHttpService: CommonHttpService; 
  private _authService: AuthService;
  private _alertService: AlertService; 
  private route: ActivatedRoute; 
  private _storeService: DataStoreService;
  private _history: ArProviderHistoryService; 
  private _providerService: FinanceArProviderDetailsService;
  private _router: Router;

  constructor(private injector : Injector){
    this.formBuilder = injector.get<FormBuilder>(FormBuilder); 
    this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService); 
    this._authService = injector.get<AuthService>(AuthService);
    this._alertService = injector.get<AlertService>(AlertService); 
    this.route = injector.get<ActivatedRoute>(ActivatedRoute); 
    this._storeService = injector.get<DataStoreService>(DataStoreService);
    this._history = injector.get<ArProviderHistoryService>(ArProviderHistoryService); 
    this._providerService = injector.get<FinanceArProviderDetailsService>(FinanceArProviderDetailsService);
    this._router = injector.get<Router>(Router);

    this.receivableDetailID = this.route.snapshot.params['receivabledetailid'];
  }

  ngOnInit() {
    if (!this._history.receipt) {
      this._router.navigate(['../../overpayments'], {relativeTo: this.route});
    }
    this.loggedInUser = this._authService.getCurrentUser().user.username;
    this.initiateForm();
    this.loadDropdowns();
    this.paginationInfo.pageNumber = 1;
    this.loadReceipts();
    this.addReceipt();
    this.prefillReciept();
  }

  prefillReciept() {
    this.offsetReceiptFormFroup.patchValue({
      payment_method_cd: this._history.receipt.payment_method_cd,
      payment_no_tx: this._history.receipt.referencenumber,
      payment_amount_no: this._history.receipt.collected_amount_no,
    });
    this.changeReceiptType(this._history.receipt.payment_method_cd);
    this.buttontext = 'Update';
  }

  loadDropdowns() {
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '10042'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe((res:any) => {
      this.paymenttypeList = res;
    });
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '5'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe((res:any) => {
      this.receipttypeList = res;
    });
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '104'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe((res:any) => {
      this.payeeList = res;
    });
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '6'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe((res:any) => {
      this.reasonforreversalList = res;
    });
  }

  initiateForm() {
    this.offsetReceiptFormFroup = this.formBuilder.group({
      receipt_dt: '',
      payment_type_cd: '',
      payment_method_cd: '',
      payment_no_tx: '',
      payment_amount_no: '',
      payee_cd: '',
      reason_tx: '',
      notes_tx: '',
      enteredby: '',
      enteredat: '',
      approveat: '',
      approvedby: ''
    });
  }

  addReceipt() {
    this.resetForm();
    this.offsetReceiptFormFroup.enable();
    this.offsetReceiptFormFroup.get('enteredat')?.setValue(new Date());
    this.offsetReceiptFormFroup.get('enteredby')?.setValue(this.loggedInUser);
    this.offsetReceiptFormFroup.get('enteredat')?.disable();
    this.offsetReceiptFormFroup.get('enteredby')?.disable();
    this.offsetReceiptFormFroup.get('payee_cd')?.setValue(this._providerService.provider.county_cd);
    this.offsetReceiptFormFroup.get('payee_cd')?.disable();
    this.offsetReceiptFormFroup.get('payment_amount_no')?.setValue(this.balanceamount);
    (<any>$(this.receiptdetailspopupid)).modal('show');
  }

  resetForm() {
    this.offsetReceiptFormFroup.reset();
    this.buttontext = 'Add';
    this.receipt_id = null;
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadReceipts();
  }

  loadReceipts(receiptid = null) {
    this._commonHttpService.getPagedArrayList({
      where: {
        receivabledetailid: this.receivableDetailID
      },
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.list).subscribe((res: any) => {
      this.receipts = (res && res.data) ? res.data : [];
      this.totalCount = res.data.length ? res.data[0].totalcount : 0;
      this.balanceamount = res['balanceamount'];
    });
  }

  getReceipt(model: any, editindex: number) {
    this.resetForm();
    this.receipt_id = model.receipt_id;
    setTimeout(() => {
      this.patchform(model);
      if (editindex === 1) {
        this.buttontext = 'View';
        this.offsetReceiptFormFroup.disable();
      } else {
        this.buttontext = 'Update';
        this.offsetReceiptFormFroup.enable();
      }
      (<any>$(this.receiptdetailspopupid)).modal('show');
    }, 100);
  }

  SaveUpdateReceipts() {
    const model = this.offsetReceiptFormFroup.getRawValue();
    model.receivable_detail_id = this.receivableDetailID;
    model.receivable_id = this._history.receipt.receivable_id;
    model.provider_id = this._providerService.providerid;
    model.offset_dt = new Date();
    model.update_ts = moment(new Date());
    if (this.buttontext === 'Update') {
      model.receipt_id = this._history.receipt.offset_id;
    }
    this._commonHttpService.create(model, FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.addUpdate).subscribe(
      (result:any) => {
        (<any>$(this.receiptdetailspopupid)).modal('hide');
        this.resetForm();
        this._alertService.success('Receipt details Saved successfully!');
        this.loadReceipts();
      },
      (erro:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  deleteReceipt() {
    this._commonHttpService.create({ receipt_id: this.receipt_id }, FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.deleteReceipt).subscribe(
     (response:any) => {
        this._alertService.success('Receipt id ' + this.receipt_id + ' deleted successfully');
        this.receipt_id = null;
        (<any>$(this.deletereceiptpopupid)).modal('hide');
        this.loadReceipts();
      },
     (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletereceiptpopupid)).modal('hide');
      }
    );
  }

  changeReceiptType(type: string) {
    if (type !== '16') {
      this.offsetReceiptFormFroup.get('reason_tx')?.setValue(null);
      this.offsetReceiptFormFroup.get('reason_tx')?.disable();
    } else {
      this.offsetReceiptFormFroup.get('reason_tx')?.enable();
    }
  }

  showDeletePop(model: any) {
    this.receipt_id = model.receipt_id;
    (<any>$(this.deletereceiptpopupid)).modal('show');
  }

  patchform(model: any) {
    this.offsetReceiptFormFroup.patchValue(model);
    this.changeReceiptType(model.payment_method_cd);
  }

  getValues(value: any, type: string) {
    if(type == 'receipttype') {
      const receiptdesc = this.receipttypeList.find((item:any) => item.picklist_value_cd === value);
      if (receiptdesc) {
        return receiptdesc.description_tx;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

}

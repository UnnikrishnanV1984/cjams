import { Component, OnInit, Injector, ChangeDetectorRef } from '@angular/core';
import { FinanceArProviderDetailsService } from '../../finance-ar-provider-details.service';
import { CommonHttpService, DataStoreService, AlertService, AuthService, SessionStorageService } from '../../../../../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../../finance.url.config';
import { ActivatedRoute, Router } from '@angular/router';
import { ArProviderHistoryService } from '../ar-provider-history.service';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import moment from 'moment';
import _ from 'lodash';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { RoleGuard } from '../../../../../../@core/guard';

declare let $: any;

@Component({
    selector: 'history-overpayments',
    templateUrl: './history-overpayments.component.html',
    styleUrls: ['./history-overpayments.component.scss'],
    standalone: false
})
export class HistoryOverpaymentsComponent implements OnInit {

  paginationInfo: PaginationInfo = new PaginationInfo();
  receiptPage: PaginationInfo = new PaginationInfo();
  offsetReceiptFormFroup!: FormGroup;
  receivableDetailID: string='';
  loggedInUser: string='';
  mandatoryField:boolean=false;
  buttontext = 'Add';
  receipt_id = null;
  balanceamount: any;
  receipts: any[] = [];
  totalCount!: number;
  paymenttypeList: any[] = [];
  payeeList: any[] = [];
  receipttypeList: any[] = [];
  reasonforreversalList: any[] = [];
  isEnableReceipt = false;
  payment_amount_error: string='';
  id: any;
  bulkReceipt: any[]=[];
  enableBulk:boolean=false;
  dupResponse: any[]=[];
  selectReceiptBulk:boolean=false;
  enableSave:boolean=false;
  payment_type_cd : any;
  bulkSave:boolean=false;
  isBulkView:boolean=false;
  overpaymentCheck:boolean=false;
  isreversalReceipt:boolean=false;
  receipttypeListOriginal: any[]=[];
  getUsersList: any[]=[];
  selectedPerson: any;
  assignedTo: any;
  isreversal:boolean=false;
  expandedIndex: number | null = null;
  isAddAllowed: boolean = true;

  currentDate = new Date();
  isButtonClicked = false;
  paymenttypeListOriginal: any[]=[];
  isaddreceipt:boolean=false;
  collectionStatus775:boolean=false;
  accepted:boolean=false;
  activeModule: any;
  isSupervisor:boolean=false;
  isFW:boolean=false;
  assignedUser:boolean=false;
  userProfile!: AppUser;
  paymentdetail: any;
  bulkReceiptSave = false;
  isVissbleButton:boolean=false;
  reversal_amount_no: any = '0.00';

  private formBuilder: FormBuilder;
  private _providerService: FinanceArProviderDetailsService;
  private _commonHttpService: CommonHttpService;
  private _route: ActivatedRoute;
  private _router: Router;
  public _history: ArProviderHistoryService;
  private _dataStore: DataStoreService;
  private _alertService: AlertService;
  private _authService: AuthService;
  private _sessionStorage: SessionStorageService;
  private cdr: ChangeDetectorRef;

  constructor(private injector : Injector, private _roleGuard: RoleGuard){
    this.formBuilder = injector.get<FormBuilder>(FormBuilder);
    this._providerService = injector.get<FinanceArProviderDetailsService>(FinanceArProviderDetailsService);
    this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
    this._route = injector.get<ActivatedRoute>(ActivatedRoute);
    this._router = injector.get<Router>(Router);
    this._history = this.injector.get<ArProviderHistoryService>(ArProviderHistoryService);
    this._dataStore = injector.get<DataStoreService>(DataStoreService);
    this._alertService = injector.get<AlertService>(AlertService);
    this._authService = injector.get<AuthService>(AuthService);
    this._sessionStorage = injector.get<SessionStorageService>(SessionStorageService);
    this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

    this.receivableDetailID = this._route.snapshot.params['receivabledetailid'];
  }
  overpaymenthistoryclass = '.overpayment-history tr';
  selectedbgclass = 'selected-bg';
  historydetailsclass = '.history-details tr';
  collapseclass = '.collapse.in';
  receiptdetailspopupid = '#receipt-details';

  ngOnInit() {
    this.initiateForm();
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this._history = Object.assign({}, new ArProviderHistoryService());
   const data = this._roleGuard.getPermissionsList();
   this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance Approval') {
      this.isSupervisor = true;
      this.isFW = false;
      this.isVissbleButton = true;
    } else if (this.activeModule === 'Finance') {
      this.isSupervisor = false;
      this.isFW = true;
      this.isAddAllowed = true;
    }
   if (data && data.length) {
     const res = data.filter((item:any) => item.resourceid === 'manage_receipt_add');
     this.isAddAllowed = res && res.length ? res[0].isallowed : true;
   }
 
    this.loggedInUser = this._authService.getCurrentUser().user.username;
    this.userProfile = this._authService.getCurrentUser();
    this.loadDropdowns();
    if (!this._history.index && this._history.index !== 0) {
      this.loadOverPaymentHistory();
    } else {
      setTimeout(() => {
        $(this.overpaymenthistoryclass).removeClass(this.selectedbgclass);
        $(`#overpayment-${this._history.index}`).addClass(this.selectedbgclass);
        $(this.historydetailsclass).removeClass(this.selectedbgclass);
        $(`#overpayment-details-${this._history.historyIndex}`).addClass(this.selectedbgclass);
        $('.receipt-details tr').removeClass(this.selectedbgclass);
        $(`#receipt-details-${this._history.receiptIndex}`).addClass(this.selectedbgclass);
      }, 100);
    }
  }


  loadOverPaymentHistory() {
    this._history.overPaymentHistory = [];
    this.loadOverpaymentList(false).subscribe((res: any) => {
        this._history.overPaymentHistory = res.data;
        if (this.bulkReceiptSave) {
          this.viewBulk(true);
        }
        this.bulkReceiptSave = false;
        const balance = this._history.overPaymentHistory.filter((rec:any) => rec.receivable_balance_no !== '0.00');
        if (balance.length > 0) {
          this.overpaymentCheck = true;
        } else {
          this.overpaymentCheck = false;
        }
        this._history.totalcount = res.count;
        this._history.historyDetails = [];
        this._history.receiptDetails = [];
        this.dupResponse = [...res.data];
        if (this._history.index && this._history.index >= 0) {
          this.getHistoryDetails(this._history.selectedPaymentid, this._history.index, this._history, this.id);
        }
        this.checkReversalFn();
      });
  }
  // Assosiated to loadOverPaymentHistory function
  private checkReversalFn() {
    const reversal = this._dataStore.getData('ReversalReceiptFromDashboard');
    if (reversal && reversal.client_id && this._history.overPaymentHistory && this._history.overPaymentHistory.length > 0) {
      let historydetails:any = null;
      this._history.overPaymentHistory.forEach((data, index) => {
        historydetails = this.overPaymentHistoryLoopFn(index, data, reversal, historydetails);
      });
      if (!this._history.selectedPaymentid || !historydetails) {
        this.loadOverpaymentList(true).subscribe((ele:any) => {
          if (ele && ele.data) {
            historydetails = ele.data.find((e:any) => e.receivable_detail_id == reversal.receivable_detail_id);
            this._history.index = ele.data.findIndex((e:any) => e.receivable_detail_id == reversal.receivable_detail_id);
            this.ifHistorydetailsFn(historydetails, reversal);
          }
        });
      } else {
        this.getHistoryDetails(reversal.payment_detail_id, this._history.index, historydetails, 'accordion-tables' + this._history.index);
      }
    }
  }
  // Assosiated to loadOverPaymentHistory function
  private ifHistorydetailsFn(historydetails: any, reversal: any) {
    if (historydetails) {
      this.getHistoryDetails(reversal.payment_detail_id, this._history.index, historydetails, 'accordion-tables' + this._history.index);
    }
  }
  // Assosiated to loadOverPaymentHistory function
  private overPaymentHistoryLoopFn(index: number, data: any, reversal: any, historydetails: any) {
    this._history.index = index;
    if (data.receivable_detail_id == reversal.receivable_detail_id) {
      historydetails = data;
      this._history.selectedPaymentid = data ? data.payment_detail_id : null;
    }
    return historydetails;
  }

  loadOverpaymentList(isnolimit:any) {
   return this._commonHttpService.getPagedArrayList({
      method: 'get',
      page: this._history.paginationInfo.pageNumber,
      limit: isnolimit ? 1000 : this._history.paginationInfo.pageSize,
      nolimit: isnolimit,
      where: {
        providerid: this._providerService.providerid
      }
    },
      FinanceUrlConfig.EndPoint.accountsReceivable.history.overpayments.list);
  }

  pageChanged(page:any) {
    this._history.paginationInfo.pageNumber = page;
    if (!this.isBulkView) {
      this.receiptPage.pageNumber = 1;
      this.totalCount = 1;
    }
    this._history.receiptDetails = null;
    this.loadOverPaymentHistory();

  }

  getHistoryDetails(paymentdetailid: number, index: number, history:any, id:any, view?:any) {
    this.id = id;
    this.isEnableReceipt = false;
    this._history.selectedPaymentid = paymentdetailid;
    this._history.index = index;
    this._history.receivable_detail_id = history.receivable_detail_id;
    this._history.receivable_balance_no = history.receivable_balance_no;
    this._history.collection_status_cd = history.collection_status_cd;
    this._history.receivable_id = history.receivable_id;
    this._history.county_cd = history.county_id;
    this._history.manual_sw = history.manual_sw;
    this._history.approval_status_cd = history.approval_status_cd;
    this.accepted = false;
    this.collectionStatusFn(history);
    if (!view) {
      // $(this.collapseclass).collapse('hide');
      // $('#' + id).collapse('toggle');
      // $(this.overpaymenthistoryclass).removeClass(this.selectedbgclass);
      // $(`#overpayment-${this._history.index}`).addClass(this.selectedbgclass);
      this.expandedIndex = this.expandedIndex === index ? null : index;
    }
    
    this._commonHttpService.getPagedArrayList({
      method: 'get',
      page: this._history.historyPaginationInfo.pageNumber,
      limit: this._history.historyPaginationInfo.pageSize,
      where: {
        paymentdetailid: paymentdetailid,
        providerid: this._providerService.providerid
      }
    },
      FinanceUrlConfig.EndPoint.accountsReceivable.history.overpayments.subList)
      .subscribe((res: any) => {
        this._history.historyDetails = res.data;
        this._history.historyTotalcount = res.count;
        if (res.data && res.data.length > 0) {
          this._history.receiptDetails = res.data[0].offsetreceiptdetails;
          if (view) {
            this.getOffsetDetails(res.data[0].offsetreceiptdetails, index, history.receivable_status_cd, history.collection_status_cd, history);
          }
        }
        if (this._history.historyIndex && this._history.historyIndex >= 0) {
          this.getOffsetDetails(this._history.receiptDetails, this._history.historyIndex, '');
        }
        this.getHistoryDetailsReversalFn();
      });
  }
  // Associated with getHistoryDetails function
  private getHistoryDetailsReversalFn() {
    const reversal = this._dataStore.getData('ReversalReceiptFromDashboard');
    if (reversal && reversal.client_id && this._history.overPaymentHistory && this._history.overPaymentHistory.length > 0) {
      this._history.historyDetails.forEach((data:any, index:number) => {
        this._history.index = index;
        if (data.receivable_detail_id == reversal.receivable_detail_id) {
          this._history.receiptDetails = data;
        }
      });
      this.getOffsetDetails(this._history.receiptDetails, this._history.historyIndex, '');
    }
  }
  // Associated with getHistoryDetails function
  private collectionStatusFn(history: any) {
    if (history.collection_status_cd === '775') {
      this.collectionStatus775 = true;
    } else {
      this.collectionStatus775 = false;
    }
  }

  historyPageChanged(page:any) {
    this._history.historyPaginationInfo.pageNumber = page;
    this.getHistoryDetails(this._history.selectedPaymentid, this._history.index, this._history, this.id);
  }

  getOffsetDetails(receiptdetails: any, index: number, receivable_status_cd: any, collection_status_cd?: any, history?: any) {
    if (history) {
      this._history.receivable_balance_no = history.receivable_balance_no;
      this._history.collection_status_cd = history.collection_status_cd;
      this._history.approval_status_cd = history.approval_status_cd;
    }
    if (collection_status_cd && collection_status_cd === '775') {
      this.collectionStatus775 = true;
    } else {
      this.collectionStatus775 = false;
    }
    this.enableBulk = false;
    this.selectReceiptBulk = false;
    $('.trans').prop('checked', false);
    this._history.receiptDetails = receiptdetails;
    this._history.historyIndex = index;
    this._history.payment_type_cd = receivable_status_cd;
    $(this.historydetailsclass).removeClass(this.selectedbgclass);
    $(`#overpayment-details-${this._history.historyIndex}`).addClass(this.selectedbgclass);
    this._history.receiptDetails = receiptdetails ? receiptdetails : [];
    this.isEnableReceipt = true;
    this.isBulkView = false;
    const reversal = this._dataStore.getData('ReversalReceiptFromDashboard');
    if (reversal && reversal.receipt_id && this._history.receiptDetails && this._history.receiptDetails.length > 0) {
      const receipt = this._history.receiptDetails.find((data:any) => data.receipt_id === reversal.receipt_id);
      this.getReceipt(receipt, 3);
    }
  }

  getReceipt(model:any, editindex:any) {
    this.resetForm();
    this.receipt_id = model.receipt_id;
    this._history.receivable_detail_id = model.receivable_detail_id;
    setTimeout(() => {
      this.patchform(model);
      this.offsetReceiptFormFroup.patchValue({
        enteredat: model.enteredat,
        receipt_dt: model.receipt_dt,
        payment_balance_amount_no: this.returnPaymentBalanceAmountNoFn(model),
        payment_amount_no: this.returnPaymentAmountNoFn(model),
        reason_tx: this.returnReasonTxFn(model)
      });
      this.isreversalReceipt = false;
      this.receipttypeList = this.receipttypeListOriginal;
      if (editindex === 1) {
        this.buttontext = 'View';
        this.offsetReceiptFormFroup.disable();
      } else if (editindex === 2) {
        // Reversal of receipt code
        this.isreversalReceipt = true;
        this.changeReceiptType('16');
        this.receipttypeList = this.receipttypeList.filter(data => data.picklist_value_cd == '16');
        this.buttontext = 'Send For Approval';
        this.isreversal = model.isreversal;
        this.reversal_amount_no =  this.returnReversalAmountNoFn(model);
        this.offsetReceiptFormFroup.disable();
        this.offsetReceiptFormFroup.get('payment_method_cd')?.enable();
        this.offsetReceiptFormFroup.get('payment_amount_no')?.enable();
        this.offsetReceiptFormFroup.get('payment_amount_no')?.reset();
        this.offsetReceiptFormFroup.get('reason_tx')?.enable();
        this.offsetReceiptFormFroup.get('notes_tx')?.enable();
      } else if (editindex === 3) {
        // Reversal of receipt code For approval
        this.isreversalReceipt = true;
        this.changeReceiptType('16');
        this.buttontext = 'Send For Approval';
        this.isreversal = model.isreversal;
        this.offsetReceiptFormFroup.patchValue({
          payment_method_cd: model.payment_method_cd,
          reason_tx: model.reversal_reason_tx,
          payment_amount_no: this.returnReversalAmountNoFn(model)
        });
        this.offsetReceiptFormFroup.disable();
        this.offsetReceiptFormFroup.get('notes_tx')?.enable();
      }  else {
        this.buttontext = 'Update';
        this.offsetReceiptFormFroup.enable();
      }
      $(this.receiptdetailspopupid).modal('show');
    }, 100);
    if (this.userProfile.user.securityusersid === model.tosecurityusersid) {
      this.assignedUser = true;
    } else {
      if (model.receipt_status === 'Pending') {
        this.offsetReceiptFormFroup.disable();
      }
      this.assignedUser = false;
    }
  }
  // Associated with getReceipt function
  private returnReversalAmountNoFn(model: any): any {
    return model.reversal_amount_no ? _.toNumber(model.reversal_amount_no).toFixed(2) : '0.00';
  }
  // Associated with getReceipt function
  private returnReasonTxFn(model: any): any {
    return model.reversal_reason_tx ? model.reversal_reason_tx : null;
  }
  // Associated with getReceipt function
  private returnPaymentAmountNoFn(model: any): any {
    return model.payment_amount_no ? _.toNumber(model.payment_amount_no).toFixed(2) : '0.00';
  }
  // Associated with getReceipt function
  private returnPaymentBalanceAmountNoFn(model: any): any {
    return model.collected_amount_no ? _.toNumber(model.collected_amount_no).toFixed(2) : '0.00';
  }

  patchform(model:any) {
    const receiptFormData = {
    receipt_dt: model.offset_dt,
    payment_type_cd: model.payment_type_cd,
    notes_tx: model.notes_tx,
    enteredat: moment(model.enteredat).format('YYYY-MM-DD'),
    enteredby: model.enteredby,
    payment_no_tx: model.referencenumber,
    payment_method_cd: model.payment_method_cd,
    payment_amount_no: _.toNumber(model.collected_amount_no).toFixed(2),
    payee_cd: model.payee_cd };

    this.offsetReceiptFormFroup.patchValue(receiptFormData);
    this.offsetReceiptFormFroup.get('payment_balance_amount_no')?.setValue(this._history.receivable_balance_no);
    this.changeReceiptType(model.payment_method_cd);
  }

  // Receipt Details

  initiateForm() {
    this.offsetReceiptFormFroup = this.formBuilder.group({
      receipt_dt: '',
      payment_type_cd: '',
      payment_method_cd: '',
      payment_no_tx: '',
      payment_amount_no: new FormControl(null, Validators.compose([
        Validators.pattern('^[+-]?([0-9]*[.])?[0-9]+$')
      ])),
      payment_balance_amount_no: '',
      payee_cd: '',
      reason_tx: '',
      notes_tx: '',
      enteredby: '',
      enteredat: '',
      approveat: '',
      approvedby: ''
    });
  }

  SaveUpdateReceipts() {
    this.mandatoryField=true;
    this.offsetReceiptFormFroup.markAllAsTouched();
    if(this.offsetReceiptFormFroup.invalid){
      return;
    }
    this.isButtonClicked = true;
    this.bulkReceipt = [];
    const balance = this.offsetReceiptFormFroup.getRawValue().payment_balance_amount_no;
    const amount_no = this.offsetReceiptFormFroup.getRawValue().payment_amount_no;
    const reversal_balance = balance - this.reversal_amount_no;
    if (!this.collectionStatus775) {
      if (+amount_no > +balance) {
        this._alertService.error('Payment amount should not exceed the balance');
        this.isButtonClicked = false;
        return false;
      }
      if (+amount_no > +reversal_balance) {
        this._alertService.error('Payment amount should not exceed the balance');
        this.isButtonClicked = false;
        return false;
      }
    }
    
    if (this.isreversalReceipt) {
      $(this.receiptdetailspopupid).modal('hide');
      this.getRoutinguser();
      $('#adjustment-approval').modal('show');
      return false;
    }
    const model = this.offsetReceiptFormFroup.getRawValue();
    model.receivable_detail_id = this._history.receivable_detail_id;
    model.receivable_id =  this._history.receivable_id;
    model.provider_id = this._providerService.providerid;
    model.offset_dt = new Date();
    this.bulkReceipt.push({
      payment_amount_no: amount_no,
      receivable_detail_id: this._history.receivable_detail_id,
      receivable_id: this._history.receivable_id,
      update_ts: moment(new Date())
    });
    model.receivable_details = this.bulkReceipt;
  
    this._history.overPaymentHistory = [];
    this._commonHttpService.create(model, FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.addUpdate).subscribe(
      (result:any) => {
        $(this.receiptdetailspopupid).modal('hide');
        this.resetForm();
        this._alertService.success('Receipt details Saved successfully!');
        this.bulkReceipt = [];

        this._commonHttpService.getPagedArrayList({
          method: 'get',
          page: this._history.paginationInfo.pageNumber,
          limit: this._history.paginationInfo.pageSize,
          where: {
            providerid: this._providerService.providerid
          }
        },
          FinanceUrlConfig.EndPoint.accountsReceivable.history.overpayments.list)
          .subscribe((res: any) => {
            this._history.overPaymentHistory = res.data;
            this._history.totalcount = res.count;
            const paymentHistory:any = this._history.overPaymentHistory.find((payment:any) => payment.receivable_detail_id === this._history.receivable_detail_id );
            this._history.receivable_balance_no = paymentHistory.receivable_balance_no;
            const balanceCheck = this._history.overPaymentHistory.filter((rec:any) => rec.receivable_balance_no !== '0.00');
            if (balanceCheck.length > 0) {
              this.overpaymentCheck = true;
            } else {
              this.overpaymentCheck = false;
            }
            setTimeout(() => {
              $(this.overpaymenthistoryclass).removeClass(this.selectedbgclass);
              $(`#overpayment-${this._history.index}`).addClass(this.selectedbgclass);
            }, 100);


            this._commonHttpService.getPagedArrayList({
              method: 'get',
              page: this._history.historyPaginationInfo.pageNumber,
              limit: this._history.historyPaginationInfo.pageSize,
              where: {
                paymentdetailid: this._history.selectedPaymentid,
                providerid: this._providerService.providerid
              }
            },
              FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.list)
              .subscribe((resp: any) => {
                this._history.historyDetails = resp.data;
                this._history.historyTotalcount = resp.count;
                this._history.receiptDetails = [];
               setTimeout( () => {
                $(this.historydetailsclass).removeClass(this.selectedbgclass);
                $(`#overpayment-details-${this._history.historyIndex}`).addClass(this.selectedbgclass);
               }, 200);
               this._history.receiptDetails = this._history.historyDetails;
               this.isEnableReceipt = true;
               this.isBulkView = false;
              });
          });
      },
      (error:any) => {
        this.isButtonClicked = false;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  addReceipt() {
    this.bulkSave = false;
    this.isaddreceipt = true;
    this.resetForm();
  
    this.receipttypeList = this.receipttypeList.filter(data => data.picklist_value_cd !== '16');
    this.offsetReceiptFormFroup.enable();
    this.offsetReceiptFormFroup.get('enteredat')?.setValue(new Date());
    this.offsetReceiptFormFroup.get('enteredby')?.setValue(this.loggedInUser);
    this.offsetReceiptFormFroup.get('enteredat')?.disable();
    this.offsetReceiptFormFroup.get('enteredby')?.disable();
    this.offsetReceiptFormFroup.get('payee_cd')?.setValue(this._history.county_cd);
    this.offsetReceiptFormFroup.get('payee_cd')?.enable();
   
    this.offsetReceiptFormFroup.get('payment_balance_amount_no')?.setValue(this._history.receivable_balance_no);
    this.offsetReceiptFormFroup.get('payment_balance_amount_no')?.disable();
    this.offsetReceiptFormFroup.get('payment_amount_no')?.setValue('0.00');
    $(this.receiptdetailspopupid).modal('show');
  }

  resetForm() {
    this.offsetReceiptFormFroup.reset();
    this.buttontext = 'Add';
    this.isaddreceipt = false;
    this.receipt_id = null;
    this.isreversal = false;
    this.isreversalReceipt = false;
    this.bulkSave = false;
    this.receipttypeList = this.receipttypeListOriginal;
    this.isButtonClicked = false;
    this._dataStore.setData('ReversalReceiptFromDashboard', null);
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
      this.paymenttypeListOriginal = res;
    });
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '5'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe((res:any)=> {
      this.receipttypeList = res;
      this.receipttypeListOriginal = res;
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

  changeReceiptType(type: string) {
    if (type !== '16') {
      this.offsetReceiptFormFroup.get('reason_tx')?.setValue(null);
      this.offsetReceiptFormFroup.get('reason_tx')?.disable();
      this.offsetReceiptFormFroup.get('reason_tx')?.clearValidators();
    } else {
      this.offsetReceiptFormFroup.get('reason_tx')?.enable();
      this.offsetReceiptFormFroup.get('reason_tx')?.setValidators([Validators.required]);
    }
    this.offsetReceiptFormFroup.get('reason_tx')?.updateValueAndValidity();
    this.cdr.detectChanges();
  }

  calculatePerDiem(paymentAmount:any) {
    const amount = +paymentAmount.target.value;
    const tempPaymentAmount = +amount.toFixed(2);
    this.offsetReceiptFormFroup.patchValue({
      payment_amount_no: tempPaymentAmount ? _.toNumber(tempPaymentAmount).toFixed(2) : 0.00
    });
  }

  bulkCheck() {
    this.resetForm();
    this.bulkSave = true;
    this.offsetReceiptFormFroup.enable();
    this.offsetReceiptFormFroup.get('enteredat')?.setValue(new Date());
    this.offsetReceiptFormFroup.get('enteredby')?.setValue(this.loggedInUser);
    this.offsetReceiptFormFroup.get('enteredat')?.disable();
    this.offsetReceiptFormFroup.get('enteredby')?.disable();
    this.offsetReceiptFormFroup.get('payee_cd')?.setValue(this._history.county_cd);
    this.offsetReceiptFormFroup.get('payee_cd')?.enable();
    this.offsetReceiptFormFroup.patchValue({
      payment_type_cd: this._history.payment_type_cd
    });
    this.offsetReceiptFormFroup.get('payment_balance_amount_no')?.setValue(this.balanceamount.toFixed(2));
    this.offsetReceiptFormFroup.get('payment_balance_amount_no')?.disable();
   this.offsetReceiptFormFroup.get('payment_amount_no')?.setValue('0.00');
   this.receipttypeList = this.receipttypeList.filter(data => data.picklist_value_cd !== '16');
  }

  selectedReceiptView(receipt:any) {
    this.paymentdetail = receipt ? receipt.payment_detail_id : null;
    this.receiptPage.pageNumber = 1;
    this.viewBulk(false);
  }

  receiptChanged(page:any) {
    this.receiptPage.pageNumber = page;
    this.viewBulk(this.isBulkView);
  }
  viewBulk(bulk:any) {
    if (bulk) {
      this.paymentdetail = null;
      this.isBulkView = true;
    } else {
      this.isBulkView = false;
    }
    $(this.historydetailsclass).removeClass(this.selectedbgclass);
    $('.overpayment tr').removeClass(this.selectedbgclass);
    $(this.collapseclass).collapse('hide');
    this._commonHttpService.getPagedArrayList({
      method: 'get',
      page: this.receiptPage.pageNumber,
      limit: this.receiptPage.pageSize,
      where: {
        paymentdetailid: this.paymentdetail,
        providerid: this._providerService.providerid
      }
    },
      FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.list)
      .subscribe((res: any) => {
        this._history.receiptDetails = (res && res.data) ? res.data : [];
       this.totalCount = res.data.length ? res.data[0].totalcount : 0;
       this.isEnableReceipt = true;
       window.scrollTo(0, document.body.scrollHeight);
       this.cdr.detectChanges();
    });
  }

  getBulk(event:any) {
    this.isEnableReceipt = false;
    $(this.historydetailsclass).removeClass(this.selectedbgclass);
    $(this.collapseclass).collapse('hide');
    this.bulkReceipt = [];
   if (event) {
      this.balanceamount = 0;
      if (this.dupResponse && this.dupResponse.length) {
        for (let i = 0; i < this.dupResponse.length; i++) {
          if (this.dupResponse[i].collection_status_cd !== '779' && this.dupResponse[i].receivable_balance_no !== '0.00'  && this.dupResponse[i].approval_status_cd === '3047') {
            this.dupResponse[i].update_ts = new Date();
            $('#trans-id-' + i).prop('checked', true);
            this.selectReceiptBulk = true;
            this.bulkReceipt.push({
              payment_amount_no: this.dupResponse[i].receivable_balance_no,
              receivable_detail_id: this.dupResponse[i].receivable_detail_id,
              receivable_id: this.dupResponse[i].receivable_id,
              manual_sw: this.dupResponse[i].manual_sw
            });
            this.balanceamount = +this.dupResponse[i].receivable_balance_no + this.balanceamount;
          }
        }
      }
      this.enableBulk = !!this.bulkReceipt.length;
     } else {
      this.enableBulk = false;
      this.selectReceiptBulk = false;
        $('.trans').prop('checked', false);
        this.balanceamount = 0;

    }
  }

  transChanged(event:any, receiptDetails:any) {
    const checked:any =event.target.checked;
    this.isEnableReceipt = false;
    this.collectionStatus775 = false;
    $(this.historydetailsclass).removeClass(this.selectedbgclass);
    $(this.collapseclass).collapse('hide');
    const receipt = JSON.parse(JSON.stringify(receiptDetails));
    const selectedReceipt = this.returnSelectedReceiptCondition(receipt);
    // receipt.validation_status_cd = placement.validation_status_cd ?  1750 : 1749,
      receipt.update_ts = new Date();
    if (checked) {
      this.ifNotSelectedReceiptFn(selectedReceipt, receiptDetails);
    } else {
      this.ifSelectedReceiptFn(selectedReceipt, receipt);
      this.collectionStatus775 = false;
    }
    this.enableBulk = !!this.bulkReceipt.length;
    const receptlist = this._history.overPaymentHistory;
    if (this.bulkReceipt.length !== 0) {
      const bulkcheckboxselect = (receptlist.length === this.bulkReceipt.length);
      if (bulkcheckboxselect) {
        this.selectReceiptBulk = true;
      } else {
        this.selectReceiptBulk = false;
      }
    } else {
      this.selectReceiptBulk = false;
    }
}
// Associated with transChanged function
  private ifSelectedReceiptFn(selectedReceipt: any, receipt: any) {
    if (selectedReceipt) {
      this.selectReceiptBulk = false;
      if (this.balanceamount && this.balanceamount > +selectedReceipt.payment_amount_no) {
        this.balanceamount = this.balanceamount - selectedReceipt.payment_amount_no;
      } else {
        this.balanceamount = selectedReceipt.payment_amount_no - this.balanceamount;
      }
      this.bulkReceipt = this.bulkReceipt.filter(rec => rec.receivable_detail_id !== receipt.receivable_detail_id);
    }
  }
  // Associated with transChanged function
  private ifNotSelectedReceiptFn(selectedReceipt: any, receiptDetails: any) {
    if (!selectedReceipt) {
      if (!this.balanceamount) {
        this.balanceamount = 0;
      }
      if (!this.bulkReceipt) {
        this.bulkReceipt = [];
      }
      this.balanceamount = +receiptDetails.receivable_balance_no + this.balanceamount;
      this.bulkReceipt.push({
        payment_amount_no: receiptDetails.receivable_balance_no,
        receivable_detail_id: receiptDetails.receivable_detail_id,
        receivable_id: receiptDetails.receivable_id,
        manual_sw: receiptDetails.manual_sw ? receiptDetails.manual_sw : null
      });
      if (receiptDetails.collection_status_cd === '775') {
        this.collectionStatus775 = true;
      }
    }
  }
  // Associated with transChanged function
  private returnSelectedReceiptCondition(receipt: any) {
    return (this.bulkReceipt && this.bulkReceipt.length > 0) ? this.bulkReceipt.find(rec => rec.receivable_detail_id === receipt.receivable_detail_id) : null;
  }

  saveBulkValidation() {
    this.mandatoryField=true;
    this.offsetReceiptFormFroup.markAllAsTouched();
   if(this.offsetReceiptFormFroup.invalid){
     return;
   }
    this.isButtonClicked = true;
    if (!this.collectionStatus775) {
      if (+this.offsetReceiptFormFroup.get('payment_balance_amount_no')?.value < +this.offsetReceiptFormFroup.get('payment_amount_no')?.value) {
        this._alertService.error('Receipt Balance should not be exceeded to Balance Amount');
        this.isButtonClicked = false;
        return false;
      }
    }
   
      this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.addUpdate;
      const model = this.offsetReceiptFormFroup.getRawValue();
      model.receivable_detail_id = this._history.receivable_detail_id;
      model.receivable_id =  this._history.receivable_id;
      model.provider_id = this._providerService.providerid;
      model.offset_dt = new Date();
      model.receivable_details = this.bulkReceipt;
      model.update_ts = moment(new Date());
    this._commonHttpService.create(model).subscribe(
      (response:any) => {
        $(this.receiptdetailspopupid).modal('hide');
        this._alertService.success('Selected Receipts Added Successfully');
        this.loadOverPaymentHistory();
        this.selectReceiptBulk = false;
        this.enableBulk = false;
        this.isEnableReceipt = true;
        this.bulkReceipt = [];
        this.bulkReceiptSave = true;
        this.resetForm();
      },
      (error:any) => {
        this.isButtonClicked = false;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        this.resetForm();
      }
    );
  }

  validateCheck(checked:any) {
    if (checked === true) {
      this.enableSave = true;
    } else {
      this.enableSave = false;
    }
  }

  getRoutinguser() {
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'RVRSL' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result:any) => {
        if (result && result.data) {
          this.getUsersList = result.data;
          this.getUsersList = this.getUsersList.filter((res) => {
            if (res.userid !== this.userProfile.user.securityusersid) {
              return res;
            }
          });
        }
        });
  }

  selectPerson(row:any) {
    if (row) {
      this.selectedPerson = row;
      this.assignedTo = row.userid;
    }
  }

  saveReversalReceipt() {
    if (this.isreversalReceipt && this.assignedTo) {
      this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.ReversalAdd;
      const model = this.offsetReceiptFormFroup.getRawValue();
      model.receivable_detail_id = this._history.receivable_detail_id;
      model.toassingedsecurityuserid = this.assignedTo;
      this._commonHttpService.create({
        receivable_detail_id: model.receivable_detail_id,
        toassingedsecurityuserid: this.assignedTo,
        payment_amount_no: model.payment_amount_no,
        reason_tx: model.reason_tx,
        receipt_id: this.receipt_id
      }).subscribe(
        (response:any) => {
          $('#adjustment-approval').modal('hide');
          this._alertService.success('Reversal Receipts Assigned Successfully');
        
          this.isreversalReceipt = false;
          this.resetForm();
        },
        (error:any) => {
          this.isButtonClicked = false;
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    } else {
      this.isButtonClicked = false;
      this._alertService.warn('Please Select User!');
    }
  }

  ApproveReversalReceipt(index:any) {
    this.isButtonClicked = true;
    this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.ReversalApproval;
    this._commonHttpService.create({
      receipt_id: this.receipt_id,
      status: index == 1 ? 'A' : 'R'
    }).subscribe(
      (response:any) => {
        $(this.receiptdetailspopupid).modal('hide');
        this._alertService.success('Reversal Receipts Approved Successfully');
        this.loadOverPaymentHistory();
        this.isreversalReceipt = false;
        this.offsetReceiptFormFroup.reset();
        this._dataStore.setData('ReversalReceiptFromDashboard', null);
        this.resetForm();
      },
      (error:any) => {
        this.isButtonClicked = false;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

 checkDec(el:any) {
    if (el.target.value !== '') {
      el.target.value = isNaN(el.target.value) ? '' : el.target.value.replace(/[^0-9.]{0,2}/g, '');
      return el.target.value;
    }
    return '';
  }
}

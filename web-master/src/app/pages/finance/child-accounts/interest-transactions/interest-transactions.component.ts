
import {map, pluck, share} from 'rxjs/operators';
import { Component, OnInit, AfterContentInit, Injector } from '@angular/core';
import { FinanceUrlConfig } from '../../finance.url.config';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, AuthService, DataStoreService, CommonDropdownsService } from '../../../../@core/services';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { DatePipe } from '@angular/common';
import { forkJoin ,  Observable } from 'rxjs';
import _ from 'lodash';

import { SessionStorageService } from '../../../../@core/services/storage.service';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import moment from 'moment';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { ChildAccount } from '../../finance.constants';

declare let $: any;
@Component({
    selector: 'interest-transactions',
    templateUrl: './interest-transactions.component.html',
    styleUrls: ['./interest-transactions.component.scss'],
    providers: [DatePipe],
    standalone: false
})

export class InterestTransactionsComponent implements OnInit, AfterContentInit {
  childaccountslist: any[]=[];
  getPagedArrayList$!: Observable<any[]>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  childtransactionslist: any[] = [];
  childdetails: any;
  selectedTransaction: any;
  addForm!: FormGroup;
  editTransactionForm!: FormGroup;
  clientAccount: any;
  transactionExistOptions = [
    { text: 'Yes', value: 'Y' },
    { text: 'No', value: 'N' },
  ];
  transactionType$!: Observable<any[]>;
  transactionTypeChangeList: any[]=[];
  transactionSourceChangeList: any[]=[];
  transactionSource: any[]=[];
  localDept: any[]=[];
  totalRecords: any;
  disableTrans:boolean=false;
  typeTransaction: string='';
  client_account_type: any;
  minDate:Date=new Date();
  transSource:boolean=false;
  monthStart:Date=new Date();
  approvalRequest:boolean=false;
  selectedPerson: any;
  getUsersList: any[]=[];
  originalUserList: any[]=[];
  assignedTo: any;
  userProfile!: AppUser;
  addTransctionForm: any;
  isFW:boolean=false;
  isFS:boolean=false;
  status!: number;
  comments: string='';
  alertTxt: string='';
  url: string='';
  reason_tx: any;
  buttonTxt: string='';
  datastoreSubscription: any;
  errorCorrection: any;
  accountDetails: any;
  sortedData: any;
  benefitEndDt:boolean=false;
  benefitStartDt:boolean=false;
  actualCost: any;
  editTransctionForm: any;
  editTrans:boolean=false;
  isAdjust:boolean=false;
  obligated_amount: any;
  late_entry_sw: string | null='';
  dateMin:Date | null=null;
  endMaxDate?:Date=new Date();
  transOtherSource:boolean=false;
  receiptsType:boolean=false;
  dateMinCheck:boolean=false;
  activeModule: any;
  allowedErrorCorrection: any;
  minTransDate:Date=new Date();
  dateMinBk:Date | null =null
  isCountyMismatch:boolean=false;
  isVissbleButton:boolean=false;
  userCounty: any;
  isnotesmandatory:boolean=false;
  assign:boolean=false;
  checkforrequired: boolean  =false;
  isSupervisor?:boolean;

  private _commonService: CommonHttpService;
  private _alertService: AlertService;
  private formBuilder: FormBuilder;
  private datePipe: DatePipe;
  private sessionStora: SessionStorageService;
  public _authService: AuthService;
  private _datastoreService: DataStoreService;
  constructor(private readonly injector : Injector, private _commonDropDownService: CommonDropdownsService, private _sessionStorage: SessionStorageService) {
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.datePipe = this.injector.get<DatePipe>(DatePipe);
    this.sessionStora = this.injector.get<SessionStorageService>(SessionStorageService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._datastoreService = this.injector.get<DataStoreService>(DataStoreService);

    this.sortedData = this.childtransactionslist.slice();
  }
  dtformat = 'YYYY-MM-DD';
  dtformat1 = 'yyyy-MM-dd';
  benefitdatevalidationmsg = 'Benefit End Date should be greater than or equal to Benefit Start Date';
  amountvalidationmsg = 'Amount should be greater than $0.00';
  adjustmentamountvalidationmsg = 'Adjustment Amount should be within the total balance';
  addtransactionpopupid = '#addNewTransaction';
  mandatorymsg = 'Please fill the mandatory details.';
  edittransactionpopupid = '#editTransaction';
  ngOnInit() {
    this.userCounty = this._datastoreService.getData('selectedFinanceDept');
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this.userProfile = this._authService.getCurrentUser();
    this.paginationInfo.sortColumn = 'transaction_id';
    this.paginationInfo.sortBy = 'desc';
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      this.isFW = true;
      this.status = 81;
    } else if (this.activeModule === 'Finance Approval') {
      this.isFS = true;
      this.status = 82;
      this.isVissbleButton = true;
    }
    this.datastoreSubscription = this._datastoreService.currentStore.subscribe((store:any) => {
      this.errorCorrection = store[ChildAccount.ErrorCorrection];
    });
    this.initTransactionForm();
    this.initEditTransactionForm();
    this.getchilddetailslist();
  }

  ngAfterContentInit() {
    if (this.errorCorrection) {
      this.accountDetails = this.errorCorrection;
      this.getchilddetailslist();
      this._datastoreService.setData(ChildAccount.ErrorCorrection, null);
    }

  }

  getchilddetailslist() {
    let selectedClientId;
    if (this.accountDetails) {
      selectedClientId = this.accountDetails.client_id;
    } else {
      selectedClientId = this.sessionStora.getObj('selectedClientId');
    }

    if (selectedClientId) {
      this._commonService.getPagedArrayList(new PaginationRequest({
        where: { client_id: selectedClientId, sortcolumn:this.paginationInfo.sortColumn,sortorder:this.paginationInfo.sortBy  },
        page: 1,
        limit: 20,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.childAccounts.getchilddetailslistUrl + '?filter').subscribe((result:any) => {
        if (result && result.data && result.data.length > 0) {
          this.childdetails = result.data[0];
          this.getchildaccountslist();
        } else {
          this.childdetails = null;
        }
      });
    }
  }

  pageChanged(page:any) {
    this.getTransactionslist(page);
  }

  getTransactionslist(page = 1) {
    if (this.clientAccount) {
      this.dateMin = this.clientAccount.open_dt ? new Date(new Date(this.clientAccount.open_dt).setHours(0, 0, 0, 0)) : null;
      this.dateMinBk = this.dateMin;
      this.obligated_amount = this.clientAccount.obligated_for_anc ? this.clientAccount.obligated_for_anc : '0.00';
      this.client_account_type = this.clientAccount.account_type_cd;
      this.checkStatusCdFn();
    }
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { client_account_id: this.clientAccount.client_account_id,sortcolumn:this.paginationInfo.sortColumn,sortorder:this.paginationInfo.sortBy },
      page: page,
      limit: 10,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.interestTransactions.getTransactionsUrl + '?filter').subscribe((result:any) => {
      this.childtransactionslist = result.data;
      this.childtransactionslistLoopFn();
      this.sortedData = this.childtransactionslist.slice();
      this.totalRecords = result.count;
      this.getDropdowns(this.clientAccount.client_account_id);
      this.ifAccountDetailsFn();
    });
    if (this.clientAccount && this.clientAccount.county_cd && this.userCounty && (this.clientAccount.county_cd.toString() !== this.userCounty)) {
        this.isCountyMismatch = true;
      } else {
      this.isCountyMismatch = false;
    }

  }

  private ifAccountDetailsFn() {
    if (this.accountDetails) {
      const transaction = this.childtransactionslist.filter(res => res.transaction_id === this.accountDetails.transaction_id);
      if (this.isFS && transaction[0].status_type === 81) {
        this.editTransaction(transaction[0], 'fs');
      } else if (this.isFW && transaction[0].status_type === 83) {
        this.editTransaction(transaction[0], 'fw');
      } else {
        this.viewTransaction(transaction[0]);
      }
      this.accountDetails = null;
    }
  }

  private childtransactionslistLoopFn() {
    for (const element of this.childtransactionslist) {
      element.benefit_start_dt = this._commonDropDownService.getValidDate(element.benefit_start_dt);
      element.benefit_end_dt = this._commonDropDownService.getValidDate(element.benefit_end_dt);
    }
  }

  private checkStatusCdFn() {
    if (this.clientAccount.status_cd === '592' && this.clientAccount.service_id !== 101) {
      this.disableTrans = false;
    } else {
      if (this.clientAccount && ((this.clientAccount.fundingstatus && this.clientAccount.fundingstatus.toLowerCase() === 'denied') ||
        (this.clientAccount.paymentstatus && this.clientAccount.paymentstatus.toLowerCase() === 'denied'))) {
        this.disableTrans = false;
      } else {
        this.disableTrans = true;
      }
    }
  }

  initTransactionForm() {
    this.addForm = this.formBuilder.group({
      transaction_dt: [{ value: '', disabled: true }],
      entered_by: [''],
      transaction_type_cd: ['', Validators.required],
      recurring_transaction: ['', Validators.required],
      transaction_source_cd: ['', Validators.required],
      reference_transaction_id: ['', Validators.required],
      benefit_start_dt: ['', Validators.required],
      benefit_end_dt: ['', Validators.required],
      transaction_amount_no: ['', Validators.required],
      credit_debit_sw: [{ value: '', disabled: true }],
      notes_tx: [''],
      delete_sw: [''],
      transaction_type: [''],
      transaction_source: [''],
      transaction_id: [''],


      client_account_id: [''],
      create_ts: [''],
      update_ts: [''],
      adjustment_approval_status_cd: [''],
      manual_db_approval_status_cd: [''],
      post_sw: [''],
      payment_detail_id: [''],
      authorization_id: [''],
      late_entry_sw: [''],
      frequency_cd: ['']
    });
    this.addForm?.get('reference_transaction_id')?.disable();
    this.addForm?.get('benefit_start_dt')?.disable();
    this.addForm?.get('benefit_end_dt')?.disable();
    this.benefitEndDt = true;
    this.benefitStartDt = true;
  }

  initEditTransactionForm() {
    this.editTransactionForm = this.formBuilder.group({
      transaction_dt: [{ value: '', disabled: true }],
      transaction_type_cd: ['', Validators.required],
      transaction_source_cd: ['', Validators.required],
      frequency_cd: ['', Validators.required],
      // reference_transaction_id: ['', Validators.required],
      benefit_start_dt: [{ value: '', disabled: true }, Validators.required],
      benefit_end_dt: ['', Validators.required],
      transaction_amount_no: ['', Validators.required],
      credit_debit_sw: [{ value: '', disabled: true }],
      notes_tx: [''],

      client_account_id: [''],
      create_ts: [''],
      update_ts: [''],
      adjustment_approval_status_cd: [''],
      manual_db_approval_status_cd: [''],
      post_sw: [''],
      payment_detail_id: [''],
      authorization_id: [''],
      late_entry_sw: [''],
      delete_sw: ['']
    });
  }

  onChangeDate(form:any, mode:any) {
    if (form.value.benefit_start_dt) {
        const beginDate = new Date(form.value.benefit_start_dt);
        const day = new Date(form.value.benefit_start_dt).getDate();
        const startdate = new Date(beginDate.getFullYear(), beginDate.getMonth(), 1);
        const start = new Date(startdate).getDate();
      if (mode === 'check') {
        if (day === start) {
          this.minDate = new Date(form.value.benefit_start_dt);
          form?.get('benefit_end_dt')?.reset();
        } else {
          if (!this.dateMinCheck) {
            this._alertService.error('Please Select the Beginning date of the month');
            form?.get('benefit_start_dt')?.reset();
            form?.get('benefit_end_dt')?.reset();
          }
        }
      } else {
        this.minDate = new Date(form.value.benefit_start_dt);
        this.endMaxDate = new Date(this.minDate.getFullYear(), this.minDate.getMonth() + 1, 0);
        form?.get('benefit_end_dt')?.reset();
      }
    }
  }

  onChangeEndDate(form:any) {
    if (form.value.benefit_end_dt) {
      const endDt = new Date(form.value.benefit_end_dt);
      const day = new Date(form.value.benefit_end_dt).getDate();
      const endDate = new Date(endDt.getFullYear(), endDt.getMonth() + 1, 0);
      const end = new Date(endDate).getDate();
      if (day !== end) {
        this._alertService.error('Please Select the End date of the month');
        form?.get('benefit_end_dt')?.reset();
      }
    }
  }

  addNewTransaction() {
    this.checkforrequired =true;
    if (this.addForm.valid) {
      const data = this.addForm.getRawValue();

      if (this.addForm.getRawValue().benefit_start_dt && this.addForm.getRawValue().benefit_end_dt) {
        const startDate = moment(new Date(this.addForm.getRawValue().benefit_start_dt)).format(this.dtformat);
        const endDate = moment(new Date(this.addForm.getRawValue().benefit_end_dt)).format(this.dtformat);

        this.checkIfTransSourceFn(endDate);
        if (new Date(startDate).getTime() > new Date(endDate).getTime()) {
          this._alertService.error(this.benefitdatevalidationmsg);
          return false;
        }
      }
      if(!this.transactionAmountDataCheckFn(data)){
        return false;
      }

      this._commonService.create({

        // 'transaction_dt': this.datePipe.transform(this.addForm.value.transaction_dt, this.dtformat1),
        'transaction_dt': new Date(),
        'transaction_type_cd': data.transaction_type_cd,
        'frequency_cd': data.recurring_transaction,
        'transaction_source_cd': data.transaction_source_cd,
        'reference_transaction_id': data.reference_transaction_id,
        'benefit_start_dt': this.datePipe.transform(this.addForm.value.benefit_start_dt, this.dtformat1),
        'benefit_end_dt': this.datePipe.transform(this.addForm.value.benefit_end_dt, this.dtformat1),
        'transaction_amount_no': data.transaction_amount_no,
        'credit_debit_sw': data.credit_debit_sw,
        'notes_tx': data.notes_tx,
        'delete_sw': 'N',

        'client_account_id': this.clientAccount.client_account_id,
        'create_ts': new Date(),
        'update_ts': new Date(),
        // 'adjustment_approval_status_cd': '500',
        // 'manual_db_approval_status_cd': '500',
        'post_sw': null,
        // 'payment_detail_id': 1232131,
        // 'authorization_id': 4543,
        'late_entry_sw': this.late_entry_sw,
        // tslint:disable-next-line:max-line-length
        'adjustment_approval_status_cd' : (data.transaction_type_cd === '588' && data.transaction_source_cd === '5472') ? '3047' : null // Adjustment type and Bank Service Charges should be in approved status

      }
        , FinanceUrlConfig.EndPoint.interestTransactions.addNewTransactionUrl).subscribe((result:any) => {
          this.addNewTransactionUrlResponseFn(result);
        });
    } else {
      this._alertService.warn(this.mandatorymsg);
    }
  }
  // Associated with addNewTransaction function
  private addNewTransactionUrlResponseFn(result: any) {
    if (result) {
      if (!result.isexists) {
        $(this.addtransactionpopupid).modal('hide');
        this._alertService.success('Transaction added successfully');
        this.getTransactionslist();
        this.benefitEndDt = true;
        this.benefitStartDt = true;
      } else {
        this._alertService.error('Transaction is already added for the selected month');
      }
    } else {
      $(this.addtransactionpopupid).modal('hide');
      this._alertService.success('Transaction added successfully');
      this.getTransactionslist();
      this.benefitEndDt = true;
      this.benefitStartDt = true;
    }
  }
  // Associated with addNewTransaction function
  private checkIfTransSourceFn(endDate: string) {
    if (this.transSource) {
      if (moment(endDate).isBefore(moment().subtract(1, 'months').startOf('month'))) {
        this.late_entry_sw = 'Y';
      } else {
        this.late_entry_sw = null;
      }
    } else {
      this.late_entry_sw = null;
    }
  }
  // Associated with addNewTransaction function
  private transactionAmountDataCheckFn(data: any) {
    if (data.transaction_amount_no <= 0) {
      this._alertService.error(this.amountvalidationmsg);
      return false;
    }

    if (data.transaction_type_cd === '588') {
      if (+data.transaction_amount_no > +this.clientAccount.total_balance_no) {
        this._alertService.error(this.adjustmentamountvalidationmsg);
        return false;
      }
    }
    if (data && data.transaction_source_cd === '5486') {
      if (data.notes_tx === null || data.notes_tx === '') {
        this._alertService.error('Please fill the notes for other transaction source.');
        return false;
      }
    }
    return true;
  }

  UpdateCase() {
    if (this.editTransactionForm.valid) {
      const data = this.editTransactionForm.getRawValue();

      if (this.editTransactionForm.getRawValue().benefit_start_dt && this.editTransactionForm.getRawValue().benefit_end_dt) {
        const startDate = moment(new Date(this.editTransactionForm.getRawValue().benefit_start_dt)).format(this.dtformat);
        const endDate = moment(new Date(this.editTransactionForm.getRawValue().benefit_end_dt)).format(this.dtformat);
        if (new Date(startDate).getTime() > new Date(endDate).getTime()) {
          this._alertService.error(this.benefitdatevalidationmsg);
          return false;
        }
      }

      this._commonService.update('',
        {
          'transaction_dt': data.transaction_dt,
          'transaction_type_cd': data.transaction_type_cd,
          'frequency_cd': data.frequency_cd,
          'transaction_source_cd': data.transaction_source_cd,
          // 'reference_transaction_id': data.reference_transaction_id,
          'benefit_start_dt': data.benefit_start_dt,
          'benefit_end_dt': data.benefit_end_dt,
          'transaction_amount_no': data.transaction_amount_no,
          'credit_debit_sw': data.credit_debit_sw,
          'notes_tx': data.notes_tx,
          'client_account_id': this.clientAccount.client_account_id,
          // 'create_ts': null,
          'update_ts': new Date(),
          'adjustment_approval_status_cd': 500,
          'manual_db_approval_status_cd': 500,
          'post_sw': null,
          'payment_detail_id': 1232131,
          'authorization_id': 4543,
          'late_entry_sw': '',
          'delete_sw': 'N'
        }
        , FinanceUrlConfig.EndPoint.interestTransactions.EditTransactionUrl + this.selectedTransaction.transaction_id).subscribe((result:any) => {
          this._alertService.success('Child Transaction updated successfully');
          this.getTransactionslist();
          this.getchildaccountslist();
          $(this.edittransactionpopupid).modal('hide');
        });
    } else {
      this._alertService.warn(this.mandatorymsg);
    }
  }


  viewTransaction(transaction:any) {
    this.selectedTransaction = transaction;
    $('#viewTransaction').modal('show');
    if (transaction.credit_debit_sw === 'C') {
      this.typeTransaction = 'Credit';
    } else {
      this.typeTransaction = 'Debit';
    }
  }

  /* editTransaction(transaction) {
   // console.log(transaction);
    this.minDate = new Date(transaction.benefit_start_dt);

    this.transactionType$.subscribe((response:any) => {
      if (response) {
        this.transactionTypeChangeList = response;
       // if (this.client_account_type === '590' || this.client_account_type === '592' ) {
          this.transactionTypeChangeList =  response.filter(transactionSource => {
            return (transactionSource.picklist_value_cd === '588' || transactionSource.picklist_value_cd === '589');
          });
      //  }
      }
    });

    const transactionType = transaction.transaction_type_cd;
   // this.transactionSource$.subscribe((response:any) => {
      if (this.transactionSource) {
        this.transactionSourceChangeList = this.transactionSource;
        const conservedReceipt = ['583', '587', '586', '5479', '584', '585', '5471', '5481', '5482'];
        const adjustment = ['5472', '5473'];
        const fosterReceipt = ['5479', '584', '5481', '5479', '5482', '5471', '585', '588', '589' ];
        const dedicatedReceipt = ['587', '586', '585', '5471'];

        if (this.client_account_type === '590' && transactionType === '589' ) {
            this.transactionSourceChangeList =  this.transactionSource.filter(transactionData => {
              return ( conservedReceipt.indexOf(transactionData.picklist_value_cd) > -1);
            });
        } else if (this.client_account_type === '592' && transactionType === '589' ) {
          this.transactionSourceChangeList =  this.transactionSource.filter(transactionData => {
            return ( fosterReceipt.indexOf(transactionData.picklist_value_cd) > -1);
          });
        } else if (this.client_account_type === '591' && transactionType === '589' ) {
          this.transactionSourceChangeList =  this.transactionSource.filter(transactionData => {
            return ( dedicatedReceipt.indexOf(transactionData.picklist_value_cd) > -1);
          });
        } else if ((this.client_account_type === '590' || this.client_account_type === '591' || this.client_account_type === '592')
                    && transactionType === '588' ) {
          this.transactionSourceChangeList =  this.transactionSource.filter(transactionData => {
            return ( adjustment.indexOf(transactionData.picklist_value_cd) > -1);
          });
        }
      }
    // });

  //  setTimeout( () => {
      this.selectedTransaction = transaction;
      this.editTransactionForm.patchValue(transaction);
      // this.editTransactionForm?.get('reference_transaction_id')?.setValue(transaction.transaction_id);
      // this.editTransactionForm?.get('reference_transaction_id')?.disable();
      this.editTransactionForm?.get('transaction_type_cd')?.enable();
      this.editTransactionForm?.get('transaction_source_cd')?.enable();
      this.editTransactionForm?.get('frequency_cd')?.enable();
      // this.editTransactionForm?.get('benefit_start_dt')?.enable();
      this.editTransactionForm?.get('benefit_end_dt')?.enable();
      this.editTransactionForm?.get('transaction_amount_no')?.enable();
      this.editTransactionForm?.get('notes_tx')?.enable();

      if (this.clientAccount.status_cd === '593') {
        this.editTransactionForm.disable();
      }
   // }, 200);
  } */

  deleteTransaction(transaction:any) {
    this.selectedTransaction = transaction;
  }

  deleteItem() {
    this._commonService.create(
      {
        'commTransactionId': this.selectedTransaction.comm_transaction_id
      },
      FinanceUrlConfig.EndPoint.interestTransactions.deleteTransaction).subscribe(
        (res:any) => {
          this._alertService.success('Transaction deleted successfully');
          $('#deleteTransaction').modal('hide');
          this.getTransactionslist();
        },
        (err:any) => {
          console.error(err)
        }
      );
  }

  openAddModal() {
    this.transactionType$.subscribe((response:any) => {
      if (response) {
        this.transactionTypeChangeList = response;
        this.transactionTypeChangeList = response.filter((transactionSource:any) => {
          return (transactionSource.picklist_value_cd === '588' || transactionSource.picklist_value_cd === '589');
        });
      }
    });

    if (this.clientAccount) {
      this.addForm.reset();
      this.addForm.patchValue({
        transaction_dt: new Date(),
        credit_debit_sw: 'C',
        recurring_transaction: 'N'
      });
      $(this.addtransactionpopupid).modal('show');
    } else {
      this._alertService.warn('Please Select the child account number');
    }
  }

  private getDropdowns(client_id: any) {
    const source = forkJoin([
      this._commonService.getArrayList(new PaginationRequest({
        where: {
          'picklist_type_id': '39'
        },
        nolimit: true,
        method: 'get'
      }), FinanceUrlConfig.EndPoint.childAccounts.pickListUrl)
    ]).pipe(
      map((result:any) => {

        return {
          transactionType: result[0]
        };
      }),
      share(),);
    this.transactionType$ = source.pipe(pluck('transactionType'));
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'client_account_id': client_id ? client_id : null
      },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.transactionSource + '?filter')
      .subscribe((response:any) => {
        if (response) {
          this.transactionSource = response['data'];
        }
      });
  }

  getchildaccountslist(page = 1) {
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { client_id: this.childdetails.client_id,
        istransaction: true },
      page: page,
      limit: 50,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getchildaccountslistUrl + '?filter').subscribe((result:any) => {
      if (result) {
        this.childaccountslist = result['data'];
        if (this.clientAccount) {
          this.clientAccount = this.childaccountslist.find(data => data.account_no_tx === this.clientAccount.account_no_tx);
        }
        if (this.accountDetails) {
          this.clientAccount = this.childaccountslist.find(data => data.client_account_id === this.accountDetails.client_account_id);
          this.getTransactionslist();
        }
      }
    });
  }

  transactionModeChange(id: any) {
    this.addForm?.get('credit_debit_sw')?.reset();
    const transactionType = id;
    if (transactionType === '588') {
      this.receiptsType = false;
      this.addForm?.get('credit_debit_sw')?.setValue('D');
      this.addForm?.get('recurring_transaction')?.reset();
      this.addForm?.get('recurring_transaction')?.setValue('N');
      this.addForm?.get('recurring_transaction')?.disable();
    } else if (transactionType === '589') {
      this.receiptsType = true;
      this.addForm?.get('recurring_transaction')?.enable();
      this.addForm?.get('credit_debit_sw')?.setValue('C');
    }
    this.addForm?.get('credit_debit_sw')?.disable();
    if (this.transactionSource) {
      this.transactionSourceChangeList = this.transactionSource;
      const conservedReceipt = ['583', '587', '586', '5479', '584', '585', '5471', '5482', '5487'];
      const adjustment = ['5472'];
      const fosterReceipt = ['5479', '584', '5479', '5486', '588', '589', '5491'];
      const dedicatedReceipt = ['5488', '5489', '5490', '5486', '584'];



      if (this.client_account_type === '590' && transactionType === '589') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (conservedReceipt.indexOf(transaction.picklist_value_cd) > -1);
        });
      } else if (this.client_account_type === '592' && transactionType === '589') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (fosterReceipt.indexOf(transaction.picklist_value_cd) > -1);
        });
      } else if (this.client_account_type === '591' && transactionType === '589') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (dedicatedReceipt.indexOf(transaction.picklist_value_cd) > -1);
        });
      } else if ((this.client_account_type === '590' || this.client_account_type === '591' || this.client_account_type === '592')
        && transactionType === '588') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (adjustment.indexOf(transaction.picklist_value_cd) > -1);
        });
      }
    }

  }

  transactionSourceChange(source: string, mode: string) {
    if (source === '5486') {
      this.isnotesmandatory = true;
    } else {
      this.isnotesmandatory = false;
    }
    if (mode === 'add') {
      if (source === '5473') {
        this.approvalRequest = true;
      } else {
        this.approvalRequest = false;
      }
      this.checkSourceConditionFn(source);
    } else if (mode === 'edit') {
      if (source === '585' || source === '586' || source === '587') {
        this.transSource = true;
        this.editTransactionForm?.get('benefit_start_dt')?.reset();
        this.editTransactionForm?.get('benefit_end_dt')?.reset();
      } else {
        this.editTransactionForm?.get('benefit_start_dt')?.reset();
        this.editTransactionForm?.get('benefit_end_dt')?.reset();
        this.transSource = false;
      }
    }
  }
  // Associated with transactionSourceChange funvction
  private checkSourceConditionFn(source: any) {
    if (source === '585' || source === '586' || source === '587') {
      this.transSource = true;
      const currDate = new Date();
      const year = currDate.getFullYear();
      const month = currDate.getMonth();
      const day = currDate.getDate();
      this.minTransDate = new Date(year - 2, month, day);
      if(this.dateMin){
      if (this.dateMin < this.minTransDate) {
        this.dateMin = this.minTransDate;
      }
    }
      this.transOtherSource = false;
      this.reusableBenefitFn();
    } else if (this.receiptsType) {
      this.dateMin = this.dateMinBk;
      this.transSource = false;
      this.transOtherSource = true;
      this.reusableBenefitFn();
    } else {
      this.dateMin = this.dateMinBk;
      this.transOtherSource = false;
      this.reusableBenefitFn();
      this.transSource = false;
    }
  }
  // Associated with transactionSourceChange function
  private reusableBenefitFn() {
    this.addForm?.get('benefit_start_dt')?.reset();
    this.addForm?.get('benefit_end_dt')?.reset();
    this.benefitEndDt = false;
    this.benefitStartDt = false;
    this.addForm?.get('benefit_start_dt')?.enable();
    this.addForm?.get('benefit_end_dt')?.enable();
  }

  confirmApproval(mode: string) {
    if (mode === 'edit') {
      if(!this.checkEditModeFn()){
        return false
      }
    } else if (mode === 'send') {
      if(!this.checkendModeFn()){
        return false
      }
    } else {
      if(!this.checkFormValidationFn()){
        return false
      }
    }
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'PCAUTH' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result:any) => {
        this.getUsersList = result.data;
        this.originalUserList = this.getUsersList;
        this.listUser('TOBEASSIGNED');
      });
    $(this.addtransactionpopupid).modal('hide');
    $(this.edittransactionpopupid).modal('hide');
  }
  // Associated with confirmApproval function
  private checkEditModeFn() {
    if (this.editTransactionForm.valid) {
      this.addTransctionForm = this.editTransactionForm.getRawValue();
      this.addTransctionForm.reference_transaction_id = this.editTransctionForm.transaction_id;
      this.addTransctionForm.recurring_transaction = this.editTransactionForm?.get('frequency_cd')?.value;
      if (!this.checkEditTransactionFormValidationFn()) {
        return false
      }
    } else {
      this._alertService.warn(this.mandatorymsg);
      return false;
    }
    return true;
  }
  // Associated with confirmApproval function
  private checkEditTransactionFormValidationFn() {
    if ( this.editTransactionForm.getRawValue().benefit_start_dt && this.editTransactionForm.getRawValue().benefit_end_dt) {
      const startDate = moment(new Date(this.editTransactionForm.getRawValue().benefit_start_dt)).format(this.dtformat);
      const endDate = moment(new Date(this.editTransactionForm.getRawValue().benefit_end_dt)).format(this.dtformat);
      if ( new Date(startDate).getTime() > new Date(endDate).getTime()) {
        this._alertService.error(this.benefitdatevalidationmsg);
        return false;
      }
    }
    if (this.addTransctionForm.transaction_amount_no <= 0) {
      this._alertService.error(this.amountvalidationmsg);
      return false;
    } else if (this.addTransctionForm.credit_debit_sw === 'D' && +this.addTransctionForm.transaction_amount_no > this.allowedErrorCorrection) {
      this._alertService.error('Amount should be less then $' + this.allowedErrorCorrection);
      return false;
    }
    if (this.addTransctionForm.transaction_type_cd === '588') {
      if (+this.addTransctionForm.transaction_amount_no > +this.clientAccount.total_balance_no) {
        this._alertService.error(this.adjustmentamountvalidationmsg);
        return false;
      }
    }

    return true;
  }
  // Associated with confirmApproval function
  private checkendModeFn() {
    if (this.addForm.valid) {
      this.addTransctionForm = this.addForm.getRawValue();
      if (!this.checkAddFormValidationFn()) {
        return false
      }
    } else {
      this._alertService.warn(this.mandatorymsg);
      return false;
    }
    return true;
  }
  // Associated with confirmApproval function
  private checkAddFormValidationFn() {
    if (this.addForm.getRawValue().benefit_start_dt && this.addForm.getRawValue().benefit_end_dt) {
      const startDate = moment(new Date(this.addForm.getRawValue().benefit_start_dt)).format(this.dtformat);
      const endDate = moment(new Date(this.addForm.getRawValue().benefit_end_dt)).format(this.dtformat);
      if (new Date(startDate).getTime() > new Date(endDate).getTime()) {
        this._alertService.error(this.benefitdatevalidationmsg);
        return false;
      }
    }
    if (this.addTransctionForm.transaction_amount_no <= 0) {
      this._alertService.error(this.amountvalidationmsg);
      return false;
    }
    if (this.addTransctionForm.transaction_type_cd === '588') {
      if (+this.addTransctionForm.transaction_amount_no > +this.clientAccount.total_balance_no) {
        this._alertService.error(this.adjustmentamountvalidationmsg);
        return false;
      }
    }
    return true;
  }
  // Associated with confirmApproval function
  private checkFormValidationFn() {
    if (this.editTransactionForm.valid) {
      if (this.addTransctionForm.transaction_amount_no <= 0) {
        this._alertService.error(this.amountvalidationmsg);
        return false;
      }
      this.addTransctionForm.transaction_amount_no = this.editTransactionForm?.get('transaction_amount_no')?.value;
    } else {
      this._alertService.warn(this.mandatorymsg);
      return false;
    }
    return true;
  }

  selectPerson(row: { userid: any; }) {
    if (row) {
      this.assign = false;
      this.selectedPerson = row;
      this.assignedTo = row.userid;
    }
  }

  listUser(assigned: string) {
    this.selectedPerson = '';
    this.getUsersList = [];
    this.getUsersList = this.originalUserList;
    if (assigned === 'TOBEASSIGNED') {
      this.getUsersList = this.getUsersList.filter((res) => {
        if (res.userrole === 'LDSS Fiscal Supervisor' && res.userid !== this.userProfile.user.securityusersid) {
          this.assign = true;
          $('#adjustment-approval').modal('show');
          return res;
        }
      });
    }
  }

  editTransaction(transaction: { [x: string]: any; status_type?: any; }, mode: string) {
    this.isAdjust = false;
    this.addTransctionForm = transaction;
    this.editTransactionForm.patchValue(transaction);
    if (mode === 'fs') {
      $(this.edittransactionpopupid).modal('show');
      this.editTransactionForm.disable();
      this.buttonTxt = 'Approve';
    } else {
      if (transaction.status_type === 83) {
        this.editTransactionForm.disable();
        this.editTransactionForm?.get('transaction_amount_no')?.enable();
        this.buttonTxt = 'Resend For Approval';
      } else {
        this.editTransactionForm.enable();
        this.buttonTxt = 'Send For Approval';
      }
    }
  }
  editTransactionAdjustment(transaction: { [x: string]: any; error_correction_amt?: any; transaction_amount_no?: any; }) {
    this.allowedErrorCorrection = (transaction && transaction.error_correction_amt) ? transaction.error_correction_amt : '0.00';
    this.buttonTxt = 'Send For Approval';
    this.isAdjust = true;
    this.transSource = false;
    this.transOtherSource = false;
    this.editTransctionForm = transaction;
    this.actualCost = transaction.transaction_amount_no;
    this.editTransactionForm.patchValue(transaction);
    this.editTransactionForm.patchValue({
      frequency_cd: 'N',
      transaction_type_cd: '588',
      transaction_source_cd: '5473',
      transaction_amount_no: this.allowedErrorCorrection
    });
    this.editTransactionForm?.get('frequency_cd')?.disable();
    this.editTransactionForm?.get('transaction_type_cd')?.disable();
    this.editTransactionForm?.get('transaction_source_cd')?.disable();
    this.editTransactionForm?.get('transaction_dt')?.disable();
    this.editTransactionForm?.get('credit_debit_sw')?.enable();
    this.editTransactionForm?.get('benefit_start_dt')?.enable();
    this.benefitEndDt = false;
    this.benefitStartDt = false;
  }

  transModeSwitch(value: string) {
    if (value === 'D') {
      const actual_cost = this.actualCost;
        if (this.editTransactionForm?.get('transaction_amount_no')?.value) {
          if (parseFloat(this.editTransactionForm?.get('transaction_amount_no')?.value) > actual_cost) {
            this._alertService.warn('Not allowed to add more than the actual cost');
            this.editTransactionForm.patchValue({
              transaction_amount_no : this.actualCost
            });
          }
        }
      }
  }
  confirmReject() {
    this.reason_tx = '';
    $(this.edittransactionpopupid).modal('hide');
    $('#reject-approval').modal('show');
  }

  rejectAdjustment() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.interestTransactions.adjustmentReject;
    const modal = {
      reason_tx: this.reason_tx,
      transaction_id: this.addTransctionForm.transaction_id,
      account_no_tx: this.clientAccount.account_no_tx
    };

    this._commonService.create(modal).subscribe(
      (response:any) => {
        $('#rejectApproval').modal('hide');
        this._alertService.success('Adjustment Error Correction Rejected Successfully');
        this.getTransactionslist();
        this.getchildaccountslist();
      },
      (error:any) => {
        this._alertService.success(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });
  }

  supervisorApproval() {
    this.assign = true;
    if (this.isFW) {
      this.comments = 'Approval request for Error Correction for the Client Account ID(' + this.clientAccount.client_account_id + ')';
      this.alertTxt = 'Approval Request sent successfully';
      this.url = FinanceUrlConfig.EndPoint.interestTransactions.adjustmentRequest;
    } else if (this.isFS) {
      this.comments = 'Approved Error Correction for the Client Account ID(' + this.clientAccount.client_account_id + ')';
      this.alertTxt = 'Approved Adjustment - Error Correction successfully';
      this.url = FinanceUrlConfig.EndPoint.interestTransactions.adjustmentApproval;
    }
      this._commonService.create({
        'transaction_dt': new Date(),
        'transaction_type_cd': this.addTransctionForm.transaction_type_cd,
        'frequency_cd': this.addTransctionForm.recurring_transaction,
        'transaction_source_cd': this.addTransctionForm.transaction_source_cd,
        'reference_transaction_id': this.isFW ? this.addTransctionForm.reference_transaction_id : null,
        'benefit_start_dt': this.datePipe.transform(this.addTransctionForm.benefit_start_dt, this.dtformat1),
        'benefit_end_dt': this.datePipe.transform(this.addTransctionForm.benefit_end_dt, this.dtformat1),
        'transaction_amount_no': this.addTransctionForm.transaction_amount_no,
        'credit_debit_sw': this.addTransctionForm.credit_debit_sw,
        'notes_tx': this.addTransctionForm.notes_tx,
        'delete_sw': 'N',
        'client_account_id': this.clientAccount.client_account_id,
        'late_entry_sw': '',
        'assignedtoid': this.assignedTo,
        'intakeserviceid': this.clientAccount.intakeserviceid,
        'eventcode': 'CACCTRANS',
        'status': this.status,
        'comments': this.comments,
        notifymsg : this.comments,
        routeddescription: this.comments,
        transaction_id: this.addTransctionForm.transaction_id ? this.addTransctionForm.transaction_id : null
      }, this.url).subscribe((result:any) => {
          if (result) {
            this._alertService.success(this.alertTxt);
            this.getTransactionslist();
            $('#adjustment-approval').modal('hide');
            $(this.edittransactionpopupid).modal('hide');
          } else {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
        });
  }

  beneficiaryStartDate = (d: Date): boolean => {
    if(d === null) {
      return false;
    }
    const day = new Date(d).getDate();
    const startdate = new Date(d.getFullYear(), d.getMonth(), 1);
    this.monthStart = new Date(d.getFullYear(), d.getMonth() + 1, 0);
    const start = new Date(startdate).getDate();
      this.dateMinCheck = false;
      return (day === start);
  }

  beneficiaryEndDate = (d: Date): boolean => {
    const day = new Date(d).getDate();
    const endDate = this.monthStart;
    const end = new Date(endDate).getDate();
    return (day === end);
  }

  editTransactionModeChange(id: any) {
    const transactionType = id;
    if (transactionType === '588') {
      this.editTransactionForm?.get('credit_debit_sw')?.setValue('D');
    } else if (transactionType === '589') {
      this.editTransactionForm?.get('credit_debit_sw')?.setValue('C');
    }
    this.editTransactionForm?.get('credit_debit_sw')?.disable();
    if (this.transactionSource) {
      this.transactionSourceChangeList = this.transactionSource;
      const conservedReceipt = ['583', '587', '586', '5479', '584', '585', '5471', '5482', '5487'];
      const adjustment = ['5472', '5473'];
      const fosterReceipt = ['5479', '584', '5481', '5479', '5482', '5486', '588', '589'];
      const dedicatedReceipt = ['5488', '5489', '5490', '5486'];



      if (this.client_account_type === '590' && transactionType === '589') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (conservedReceipt.indexOf(transaction.picklist_value_cd) > -1);
        });
      } else if (this.client_account_type === '592' && transactionType === '589') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (fosterReceipt.indexOf(transaction.picklist_value_cd) > -1);
        });
      } else if (this.client_account_type === '591' && transactionType === '589') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (dedicatedReceipt.indexOf(transaction.picklist_value_cd) > -1);
        });
      } else if ((this.client_account_type === '590' || this.client_account_type === '591' || this.client_account_type === '592')
        && transactionType === '588') {
        this.transactionSourceChangeList = this.transactionSource.filter(transaction => {
          return (adjustment.indexOf(transaction.picklist_value_cd) > -1);
        });
      }
    }

  }

  onHistorySorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getTransactionslist();
}

checkDec(el:any) {
  if (!_.isNaN(_.toNumber(el.target.value))) {
    el.target.value = isNaN(el.target.value) ? '' :  _.toNumber(el.target.value).toFixed(2);
    return el.target.value;
  }
  return '';
}
}

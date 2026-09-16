import { Component, OnInit, OnDestroy, AfterContentInit, Injector } from '@angular/core';
import { FinanceUrlConfig } from '../../finance.url.config';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, GenericService, DataStoreService, AuthService, CommonDropdownsService, SessionStorageService } from '../../../../@core/services';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { DatePipe } from '@angular/common';
import { Observable } from 'rxjs';
import { AddForm } from '../../_entities/finance-entity.module';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { CommingledAccount } from '../../finance.constants';
import _ from 'lodash';

declare let $: any;
@Component({
    selector: 'interest-transactions',
    templateUrl: './interest-transactions.component.html',
    styleUrls: ['./interest-transactions.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class InterestTransactionsComponent implements OnInit, OnDestroy, AfterContentInit {

  id: string='';
  commingledAccountLists: any[]=[];
  selectedCommingledAccount: any;
  getPagedArrayList$!: Observable<any[]>;
  childtransactionslist: any[] = [];
  // transactionIdArray: any[] = [];
  childdetails: any;
  selectedTransaction: any;
  formAdd!: AddForm;
  addForm!: FormGroup;
  editTransactionForm!: FormGroup;
  childId = '';
  transactionExistOptions = [
    { text: 'Yes', value: 'Y' },
    { text: 'No', value: 'N' },
  ];
  transactionType: any[]=[];
  transactionStatus: any[]=[];
  localDept: any[]=[];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  selectedDept: any;
  loggedInUser: string='';
  currentDate: Date = new Date();
  isView:boolean=false;
  mandatoryField:boolean=false;
  isEdit:boolean=false;
  datastoreSubscription: any;
  selectedPerson: any;
  assignedTo: any;
  getUsersList: any[]=[];
  originalUserList: any[]=[];
  user!: AppUser;
  isFinanceSupervisor:boolean=false;
  userId: string='';
  requestUser: any;
  disableTrans:boolean=false;
  account_status_nm: string='';
  minDate:Date=new Date();
  reason_tx: string='';
  commAccId: any;
  selectedAccount: any;
  errorCorrection: any;
  accountNo: any;
  errorData: any[]=[];
  accountDetails: any;
  maxDate:Date=new Date();
  transactionID: any;
  commingledTrans: any[]=[];
  isApprove:boolean=false;
  transaction: any;
  activeModule: any;
  isVissbleButton:boolean=false;
  disableAssignButton = false;
  isSupervisor:boolean=false;
  private _commonService: CommonHttpService;
  private _alertService: AlertService;
  private _sessionStorage: SessionStorageService;
  private formBuilder: FormBuilder;
  private _datastoreService: DataStoreService;
  private datePipe: DatePipe;
  public _authService: AuthService;

  constructor(
    private readonly injector : Injector,
    private _commonDropDownService: CommonDropdownsService,
    private _ativityService: GenericService<AddForm>) {
      this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
      this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._datastoreService = this.injector.get<DataStoreService>(DataStoreService);
      this.datePipe = this.injector.get<DatePipe>(DatePipe);
      this._authService = this.injector.get<AuthService>(AuthService);
    }
  edittransactionpopupid = '#edit-transaction';
  addtransactionpopupid = '#addNewTransaction';
  rejectapprovalpopupid = '#reject-approval';
  ngOnInit() {
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this.user = this._authService.getCurrentUser();
    this.userId = this._authService.getCurrentUser().user.securityusersid;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      this.isFinanceSupervisor = false;
    } else if (this.activeModule === 'Finance Approval') {
      this.isFinanceSupervisor = true;
      this.isVissbleButton = true;
    }
    this.selectedCommingledAccount = null;
    this.initTransactionForm();
    this.datastoreSubscription = this._datastoreService.currentStore.subscribe((store:any) => {
      const selectedDept = store['selectedFinanceDept'];
      this.selectedAccount = store['CommingledErrorCorrection'];
      if (selectedDept && selectedDept !== this.selectedDept) {
        if (this.selectedAccount) {
          this.selectedCommingledAccount = this.selectedAccount;
        } else {
          this.selectedCommingledAccount = null;
        }
        this.selectedDept = selectedDept;
        this.errorCorrection = store[CommingledAccount.ErrorCorrection];
        this.getCommingledDropdown();
      }
    });
  }

  ngAfterContentInit() {
    if (this.selectedAccount) {
      this.getTransactions(this.selectedAccount);
      if (this.isFinanceSupervisor) {
        this.editTransaction(this.selectedAccount);
      } else {
        this.viewTransaction(this.selectedAccount);
      }
      this._datastoreService.setData('CommingledErrorCorrection', null);
    } else if (this.errorCorrection) {
      this.accountDetails = this.errorCorrection;
      this.getCommingledDropdown();
      this._datastoreService.setData(CommingledAccount.ErrorCorrection, null);
    } else {
      this.getTransactions();
    }
  }

  ngOnDestroy() {
    this.datastoreSubscription.unsubscribe();
  }

  addChildTransaction(ativity: AddForm) {
    this.mandatoryField=true;
    this.addForm.markAllAsTouched();
    if(this.addForm.invalid){
      return;
    }
    this.formAdd = Object.assign(ativity);
    this.formAdd.comm_account_id = this.selectedCommingledAccount.comm_account_id;
    this.formAdd.interest_start_dt = this.datePipe?.transform(this.formAdd?.interest_start_dt, 'yyyy-MM-dd') ?? '';
    this.formAdd.interest_end_dt = this.datePipe.transform(this.formAdd.interest_end_dt, 'yyyy-MM-dd')?? '';

    if (this.isEdit) {
      if (!this.isFinanceSupervisor) {
        this.selectedTransaction.interest_amount_no = ativity.interest_amount_no;
        this.selectedTransaction.mod_interest_amount_no = ativity.mod_interest_amount_no;
        this.getRoutingUser();
      }
    } else {
      this._ativityService.endpointUrl = FinanceUrlConfig.EndPoint.commingledAccounts.interestTransactions.add;
      this._ativityService.create(this.formAdd).subscribe(
        (res: any) => {
          if (res) {
            if (!res.isexists) {
              this.closePopupAndLoadTransactions();
            } else {
              this._alertService.error('Already added for the selected month');
            }
          }
        },
        (error:any) => {}
      );
    }
  }

  deleteInterestTransaction() {
    this._ativityService.getSingle({
      method: 'post'
    }, FinanceUrlConfig.EndPoint.commingledAccounts.interestTransactions.delete + this.selectedTransaction.comm_acct_trans_id)
      .subscribe((res:any) => {
        this._alertService.success('Interest Transaction deleted successfuly.');
        this.getTransactions();
        this.getCommingledDropdown();
        $(this.edittransactionpopupid).modal('hide');
      });
  }

  private closePopupAndLoadTransactions() {
    $(this.addtransactionpopupid).modal('hide');
    this.getTransactions();
    this.getCommingledDropdown();
    this._alertService.success(`Transaction ${this.isEdit ? 'updated' : 'added'} successfully`);
  }

  getTransactions(account: any = null) {
    this.selectedCommingledAccount = account ? account : this.selectedCommingledAccount;
    if (this.selectedCommingledAccount) {
        this.ifSelectedComingledAccountFn();
    } else {
      this.disableTrans = true;
    }
    if (this.selectedCommingledAccount) {
      this._ativityService.getPagedArrayList({
        where: {
          comm_account_id: this.selectedCommingledAccount.comm_account_id
        },
        method: 'get'
      }, FinanceUrlConfig.EndPoint.commingledAccounts.interestTransactions.list
      ).subscribe((res: any) => {
        if (res && res.data) {
          this.childtransactionslist = res.data;
          this.childtransactionslistLoopFn();
          if (this.transactionID) {
            this.commingledTrans = this.childtransactionslist.filter( response => {
              return (response.comm_acct_trans_id === this.transactionID);
            });
            this.accountDetails = [];
            this.checkIfTransactionIdFn();
            this.transactionID = null;
          }
          this.totalRecords = this.returnTotalRecordsCountFn();
        }
      });
    }
  }

  private returnTotalRecordsCountFn(): number {
    return (this.childtransactionslist.length > 0) ? this.childtransactionslist[0].totalcount : 0;
  }

  private checkIfTransactionIdFn() {
    if (this.isFinanceSupervisor) {
      this.approveModal(this.commingledTrans[0]);
    } else {
      this.viewTransaction(this.commingledTrans[0]);
    }
  }

  private childtransactionslistLoopFn() {
    for (const element of this.childtransactionslist) {
      element.interest_start_dt = this._commonDropDownService.getValidDate(element.interest_start_dt);
      element.interest_end_dt = this._commonDropDownService.getValidDate(element.interest_end_dt);
    }
  }

  private ifSelectedComingledAccountFn() {
    if (this.selectedCommingledAccount.close_dt || !(this.selectedCommingledAccount.total_balance_no) || +this.selectedCommingledAccount.total_balance_no <= 0) {
      this.disableTrans = true;
    } else {
      this.disableTrans = false;
    }
    if (this.selectedCommingledAccount.close_dt) {
      this.account_status_nm = 'Closed';
    } else {
      this.account_status_nm = 'Active';
    }
  }

  initTransactionForm() {
    this.addForm = this.formBuilder.group({
      interest_start_dt: [{ value: '' }, Validators.required],
      interest_end_dt: [{ value: '' }, Validators.required],
      enteredby: [{ value: '', disabled: true }],
      interest_amount_no: [{ value: '' }, Validators.required],
      notes_tx: [{ value: '' }, Validators.required],
      mod_interest_amount_no: ['']
    });
  }

  onChangeDate(form:any) {
    this.minDate = new Date(form.value.interest_start_dt);
    form?.get('interest_end_dt')?.reset();
  }

  viewTransaction(transaction:any) {
    this.selectedTransaction = transaction;
    this.addForm.patchValue(this.selectedTransaction);
    this.addForm.disable();
    this.isView = true;
    this.isEdit = false;
    this.isApprove = false;
    $(this.addtransactionpopupid).modal('show');
  }


  editTransaction(transaction:any) {
    this.minDate = new Date(transaction.interest_start_dt);
    this.selectedTransaction = transaction;
    this.addForm.patchValue(this.selectedTransaction);
    if (!this.isFinanceSupervisor) {
      this.addForm.patchValue({
        mod_interest_amount_no: ''
      });
    }
    this.addForm.disable();
    this.addForm?.get('mod_interest_amount_no')?.enable();
    this.isView = false;
    this.isEdit = true;
    this.isApprove = false;
    $(this.addtransactionpopupid).modal('show');
  }

  approveModal(transaction: any) {
    this.transaction = transaction;
    this.addForm.patchValue(this.transaction);
    this.addForm.disable();
    this.isView = false;
    this.isEdit = false;
    if (this.transaction.statuskey === 45) {
      this.isApprove = true;
    } else {
      this.isApprove = false;
      this.isView = true;
    }
    $(this.addtransactionpopupid).modal('show');
  }

  approveEditTransaction() {
    const transaction = this.transaction;
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.commingledAccounts.interestTransactions.approveUpdate + transaction.comm_acct_trans_id;
    const modal = {
      'fromsecurityusersid': transaction.fromsecurityusersid,
      'intakeserviceid': transaction.intakeserviceid
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        $(this.addtransactionpopupid).modal('hide');
        this._alertService.success('Requested Transaction Approved successfully!');
        this.getTransactions();
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  rejectEditTransaction(transaction:any) {
    this.commAccId = transaction.comm_acct_trans_id;
    this.reason_tx = '';
    $(this.rejectapprovalpopupid).modal('show');
  }

  rejectTransaction() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.commingledAccounts.interestTransactions.rejectUpdate + this.commAccId;
    const modal = {
      reason_tx: this.reason_tx
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
          this._alertService.success('Commingled Updated Transaction request has been Denied!');
          $(this.rejectapprovalpopupid).modal('hide');
          this.getTransactions();
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  deleteTransaction(transaction:any) {
    this.selectedTransaction = transaction;
    $(this.edittransactionpopupid).modal('show');
  }

  openAddModal() {
    this.addForm.reset();
    this.addForm.patchValue({
      interest_start_dt: this.currentDate,
      enteredby: this.loggedInUser
    });
    this.addForm.enable();
    this.addForm?.get('enteredby')?.disable();
    this.isView = false;
    this.isEdit = false;
    this.isApprove = false;
    this.minDate = new Date(this.addForm.value.interest_start_dt);
    this.maxDate = new Date();
    $(this.addtransactionpopupid).modal('show');
  }

  clearForm() {
    this.addForm?.get('mod_interest_amount_no')?.reset();
  }

  getCommingledDropdown(page = 1) {
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { localdepartment: this.selectedDept },
      page: page,
      limit: null,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.commingledAccounts.getCommingledAccountUrl + '?filter').subscribe((result:any) => {
      if (!this.selectedCommingledAccount) {
        this.commingledAccountLists = result['data'];
        if (this.accountDetails) {
          this.transactionID = this.accountDetails.comm_acct_trans_id;
          this.commingledAccountListsLoopFn();
        }
      } else if (this.selectedCommingledAccount) {
        if (this.accountDetails) {
          this.transactionID = this.accountDetails.comm_acct_trans_id;
            if (this.selectedCommingledAccount.comm_account_id === this.accountDetails.comm_account_id) {
              this.accountNo = this.selectedCommingledAccount;
              this.getTransactions(this.selectedCommingledAccount);
            }
        } else {
          this.selectedCommingledAccount = (result['data'] && result['data'].length) ? result['data'][0] : null;
        }
      }
    });
  }
  // Associated with getCommingledDropdown function
  private commingledAccountListsLoopFn() {
    for (const element of this.commingledAccountLists) {
      if (element.comm_account_id === this.accountDetails.comm_account_id) {
        this.accountNo = element;
        this.getTransactions(element);
      }
    }
  }

  /* getCommingledDropdown() {
    const where = this.selectedCommingledAccount ? {
      account_no: this.selectedCommingledAccount.account_no
    } : {
        county_cd: this.selectedDept
      };
    this._commonService.getArrayList(new PaginationRequest({
      where: where,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.commingledAccounts.interestTransactions.commingledDropdownList).subscribe((result:any) => {
      if (!this.selectedCommingledAccount) {
        this.commingledAccountLists = result;
        if (this.accountDetails) {
          this.transactionID = this.accountDetails.comm_acct_trans_id;
          for (let i = 0; i < this.commingledAccountLists.length; i++) {
            if (this.commingledAccountLists[i].comm_account_id === this.accountDetails.comm_account_id) {
              this.accountNo = this.commingledAccountLists[i];
              this.getTransactions(this.commingledAccountLists[i]);
            //  this.approveEditTransaction(this.commingledAccountLists[i]);
              // this.accountDetails = [];
            }
          }
        }
      } else if (this.selectedCommingledAccount) {
        if (this.accountDetails) {
          this.transactionID = this.accountDetails.comm_acct_trans_id;
            if (this.selectedCommingledAccount.comm_account_id === this.accountDetails.comm_account_id) {
              this.accountNo = this.selectedCommingledAccount;
              this.getTransactions(this.selectedCommingledAccount);
              // this.accountDetails = [];
            }
        } else {
          this.selectedCommingledAccount = (result && result.length) ? result[0] : null;
        }
      }
    });
  } */

  selectPerson(row:any) {
    if (row) {
      this.selectedPerson = row;
      this.assignedTo = row.userid;
      this.disableAssignButton = false;
    }
  }

  getRoutingUser() {
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'PCAUTH' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result:any) => {
        this.disableAssignButton = true;
        $(this.edittransactionpopupid).modal('show');
        $(this.addtransactionpopupid).modal('hide');
        this.getUsersList = result.data;
        this.originalUserList = this.getUsersList;
        this.listUser('TOBEASSIGNED');
      });
  }

  listUser(assigned: string) {
    this.selectedPerson = '';
    this.getUsersList = [];
    this.getUsersList = this.originalUserList;
    if (assigned === 'TOBEASSIGNED') {
      this.getUsersList = this.getUsersList.filter((res) => {
        if (res.userrole === 'LDSS Fiscal Supervisor') {
          return res;
        }
      });
    }
  }

  assignUser() {
    this.disableAssignButton = true;
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.commingledAccounts.interestTransactions.update + this.selectedTransaction.comm_acct_trans_id;
    const modal = {
      'interest_amount_no': this.selectedTransaction.interest_amount_no,
      'mod_interest_amount_no': this.selectedTransaction.mod_interest_amount_no,
      'assignedtoid': this.assignedTo,
      'intakeserviceid': this.selectedTransaction.intakeserviceid
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        this._alertService.success('Edit Approval sent successfully!');
        $(this.edittransactionpopupid).modal('hide');
        this.disableAssignButton = false;
        this.getTransactions();
      },
      (error:any) => {
        this.disableAssignButton = false;
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );

  }

  private deleteSupervisorApproval(transaction:any) {

    this.requestUser = transaction.fromsecurityusersid;
    this._commonService.endpointUrl = 'Tb_comm_acct_transactions/deleteCommAccountTransaction' + '/' + transaction.comm_acct_trans_id;
    const modal = {
      // 'comm_acct_trans_id' : this.selectedTransaction.comm_acct_trans_id,
      'fromsecurityusersid': this.requestUser,
      method: 'post'
    };
    this._commonService.create(modal).subscribe(
      (response:any) => {
        this._alertService.success('Approved successfully!');
        this.getTransactions();
        this.getCommingledDropdown();
      },
      (error:any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  calculatePerDiem(paymentAmount:any) {
    if (Number.isInteger(+paymentAmount.target.value)) {
      this.addForm.patchValue ({
        mod_interest_amount_no : paymentAmount.target.value + '.00'
      });
    }
  }

  checkDec(el:any) {
    if (el.target.value !== '') {
      el.target.value = isNaN(el.target.value) ? '' : el.target.value.replace(/[^0-9.]{0,2}/g, '')
      return el.target.value;
    }
    return '';
  }

  interestAmountChange(event:any) {
    const amount:any=event.target.value
    if (amount) {
      this.addForm.patchValue({
        interest_amount_no: _.toNumber(amount).toFixed(2)
    });
    }
  }
  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
   }
}

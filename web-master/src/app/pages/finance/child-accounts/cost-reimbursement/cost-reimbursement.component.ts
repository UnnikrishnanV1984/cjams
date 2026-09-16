import { Component, OnInit } from '@angular/core';
import { FinanceUrlConfig } from '../../finance.url.config';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, SessionStorageService, AuthService } from '../../../../@core/services';
import { FormGroup, FormBuilder } from '@angular/forms';
import { DatePipe } from '@angular/common';
import { Observable } from 'rxjs';

@Component({
    selector: 'cost-reimbursement',
    templateUrl: './cost-reimbursement.component.html',
    styleUrls: ['./cost-reimbursement.component.scss'],
    providers: [DatePipe],
    standalone: false
})

export class CostReimbursementComponent implements OnInit {
  childaccountslist: any[]=[];
  ancillaryExcessDetails: any[] =[];
  ancillaryExcessDetailsCOC: any[] =[];
  getPagedArrayList$!: Observable<any[]>;
  childTransactionList: any[] = [];
  childdetails: any;
  selectedTransaction: any;
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
  pageInfo: PaginationInfo = new PaginationInfo();
  
  totalRecords: any;
  clientAccount: any;
  totalcount!: number;
  coc_date_sw: string='';
  date_sw: any;
  isVissbleButton: boolean=false;
  constructor(
    private _commonService: CommonHttpService,
    private _alertService: AlertService,
    private formBuilder: FormBuilder,
    private datePipe: DatePipe,
    private sessionStora: SessionStorageService,
    private _authServie: AuthService) { }

  ngOnInit() {
    this.isVissbleButton = this._authServie.isVissbleButton('read_only_access', '');
    this.coc_date_sw = 'Y';
    this.date_sw = 'Y';
    this.paginationInfo.pageNumber = 1;
    this.pageInfo.pageNumber = 1;
    this.pageInfo.pageSize = 5;
   this.getchilddetailslist();
  }
  getchilddetailslist() {
    const selectedClientId = this.sessionStora.getObj('selectedClientId');

    if (selectedClientId) {
      this._commonService.getPagedArrayList(new PaginationRequest({
        where: { client_id: selectedClientId },
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

  getList() {
    this.getCostofcarelist();
    this.getCostofcareAncillarylist();
  }

  getchildaccountslist(page = 1) {
    this.childaccountslist = [];
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { client_id: this.childdetails.client_id,
        istransaction: true },
      page: page,
      limit: 50,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getchildaccountslistUrl + '?filter').subscribe((result:any) => {
      if (result && result.data.length) {
        result.data.forEach((response:any) => {
          if (response.account_type_cd === '590') {
            this.childaccountslist.push(response);
          }
        });
    }
    });
  }

  rangCOC(value: any) {
    if (value !== 'D') {
      this.coc_date_sw = value;
      this.date_sw = value;
    } else {
      this.coc_date_sw = 'D';
      this.date_sw = null;
    }
    this.pageInfo.pageNumber = 1;
    this.paginationInfo.pageNumber = 1;
    this.getCostofcarelist();
    this.getCostofcareAncillarylist();
  }
  getCostofcarelist() {
    this.ancillaryExcessDetailsCOC = [];
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { clientaccountid: (this.clientAccount && this.clientAccount.client_account_id) ? this.clientAccount.client_account_id : null, 
      date_sw: this.date_sw , type: 'COCRM'},
      page: this.pageInfo.pageNumber,
      limit: 10,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getCostofCarelistUrl + '?filter').subscribe((result:any) => {
      if (result.data && result.data.length && result.data[0].getdhs116report) {
        if (!this.coc_date_sw) {
          this.coc_date_sw = 'All';
        }
          this.ancillaryExcessDetailsCOC = result.data[0].getdhs116report;
      }
      this.totalRecords = (this.ancillaryExcessDetailsCOC && this.ancillaryExcessDetailsCOC.length > 0) ? this.ancillaryExcessDetailsCOC[0].totalcount : 0;
    });
  }
  getCostofcareAncillarylist() {
    this.ancillaryExcessDetails = [];
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { clientaccountid: (this.clientAccount && this.clientAccount.client_account_id) ? this.clientAccount.client_account_id : null,
      date_sw: this.date_sw  , type: 'ANCLR'},
      page: this.paginationInfo.pageNumber,
      limit: 10,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getCostofCarelistUrl + '?filter').subscribe((result:any) => {
      if (result.data && result.data.length && result.data[0].getdhs116report) {
          this.ancillaryExcessDetails =  result.data[0].getdhs116report;
      }
      this.totalcount = (this.ancillaryExcessDetails && this.ancillaryExcessDetails.length > 0) ? this.ancillaryExcessDetails[0].totalcount : 0;
    });
  }

pageChanged(page:any) {
  this.pageInfo.pageNumber = page;
  this.getCostofcarelist();
}

pageNumberChanged(page:any) {
  this.paginationInfo.pageNumber = page;
  this.getCostofcareAncillarylist();
}

  // pageChanged(page) {
  //   this.getTransactionslist(page)
  // }
    
  // getTransactionslist(page = 1) {
  //   this._commonService.getPagedArrayList(new PaginationRequest({
  //     where: { client_id: (this.childdetails && this.childdetails.client_id) ? this.childdetails.client_id : null },
  //     page: page,
  //     limit: 10,
  //     method: 'get'
  //   }), FinanceUrlConfig.EndPoint.interestTransactions.getTransactionsUrl + '?filter').subscribe((result:any) => {
  //     this.childtransactionslist = result.data;
  //     this.totalRecords = result.count; 
  //   });
  // }
  // initTransactionForm() {
  //   this.addForm = this.formBuilder.group({
  //     open_dt: [{ value: '', disabled: true }],
  //     close_dt: [{ value: '', disabled: true }],    
  //     entered_by:[''],
  //     amount:[''],
  //     notes:['']
      
  //   });
  // }

  // initEditTransactionForm() {
  //   this.editTransactionForm = this.formBuilder.group({
  //     open_dt: [{ value: '', disabled: true }],
  //     close_dt: [{ value: '', disabled: true }],    
  //     entered_by:[''],
  //     amount:[''],
  //     notes:['']
      
  //   });
  // }

  // addTransaction() {
  //   if (this.addForm.valid) {
  //     const data = this.addForm.getRawValue();
  //     this._commonService.create({

  //       'openDt': new Date(),
  //       'closeDt': this.datePipe.transform(this.addForm.value.close_dt, 'yyyy-MM-dd'),
  //       'bankNm': data.bank_nm,
  //       'transactionNo': data.bank_acc_num,
  //       'approvalStatusCd': data.status_cd,
  //       'countyCd': data.local_dept,
  //       'totalBalanceNo': data.total_balance,
  //       "deleteSw": "N",
  //     }
  //       , FinanceUrlConfig.EndPoint.interestTransactions.addTransactionUrl).subscribe((result:any) => {
  //         if (result) {
  //           this._alertService.success(' Transaction added successfully');
  //           this.getTransactionslist();
  //           (<any>$('#addNewTransaction')).modal('hide');
  //         } else {
  //           this._alertService.error(' Transaction not added successfully');

  //         }
  //       });
  //   }
  //   else {
  //     this._alertService.warn("Please fill the mandatory details.");
  //   }
  // }

  // UpdateCase() {
  //   if (this.editTransactionForm.valid) {
  //     const data = this.editTransactionForm.getRawValue();
  //     this._commonService.update('',
  //       {
  //         'commTransactionId': this.selectedTransaction.comm_transaction_id,
  //         'transaction_type_cd': data.transaction_type_cd,
  //         'bankNm': data.bank_nm,
  //         'transactionNo': data.transaction_no,
  //         'totalBalanceNo': data.total_balance_no,
  //         "deleteSw": "N",
  //         'openDt': data.open_dt,
  //         'closeDt': data.close_dt,
  //         'approvalStatusCd': data.approval_status_cd,
  //         'countyCd': data.county_cd,

  //       }
  //       , FinanceUrlConfig.EndPoint.interestTransactions.updateTransactionUrl).subscribe((result:any) => {
  //         this._alertService.success('Child Transaction updated successfully');
  //         this.getTransactionslist();
  //         (<any>$('#editTransaction')).modal('hide');
  //       });
  //   }
  //   else {
  //     this._alertService.warn("Please fill the mandatory details.");
  //   }

  // }
 

  // viewTransaction(transaction) {
  //   this.selectedTransaction = transaction;
  // }

  // editTransaction(transaction) {
  //   this.selectedTransaction = transaction; 
  //   this.editTransactionForm.patchValue(transaction);
  // }

  // deleteTransaction(transaction) {
  //   this.selectedTransaction = transaction;
  // }


  // deleteItem() {  

  //   this._commonService.create(
  //     {
  //       "commTransactionId": this.selectedTransaction.comm_transaction_id
  //     },
  //     FinanceUrlConfig.EndPoint.interestTransactions.deleteTransaction).subscribe(
  //       res => {
  //         this._alertService.success('Transaction deleted successfully');
  //         (<any>$('#deleteTransaction')).modal('hide')
  //         this.getTransactionslist();
  //       },
  //       err => { }
  //     );
  // }


  // openAddModal() { 
  //   this.addForm.reset();
  //   this.addForm.patchValue({
  //     open_dt: new Date()
  //   });
  //   (<any>$('#addNewTransaction')).modal('show');

  // } 

  
  /* getCommingledDropdown() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {comm_ac_id: 0},
      page: 1,
      limit: 100,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.childAccounts.getCommingledAccountsUrl + '?filter').subscribe((result:any) => {
      this.commingledAccountLists = result['data'];
    });
  } */
}

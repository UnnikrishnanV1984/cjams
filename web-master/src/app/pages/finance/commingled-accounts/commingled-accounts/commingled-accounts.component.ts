import { Component, OnInit, OnDestroy } from '@angular/core';
import { FinanceUrlConfig } from '../../finance.url.config';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, CommonDropdownsService, AuthService } from '../../../../@core/services';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { DatePipe } from '@angular/common';
import { Observable } from 'rxjs';
import moment from 'moment';

@Component({
    selector: 'commingled-accounts-tab',
    templateUrl: './commingled-accounts.component.html',
    styleUrls: ['./commingled-accounts.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class CommingledAccountsTabComponent implements OnInit, OnDestroy {
  getPagedArrayList$!: Observable<any[]>;
  commingledAccountslist: any[] = [];
  childdetails: any;
  selectedAccount: any;
  addCommingledForm!: FormGroup;
  editAccountForm!: FormGroup;
  selectedDept: any;
  accountExistOptions = [
    { text: 'Yes', value: 'Y' },
    { text: 'No', value: 'N' },
  ];
  accountType: any[]=[];
  accountStatus: any[]=[];
  pageNo: any;
  localDept: any[]=[];
  county_nm: any[]=[];// NOSONAR
  approval_status_cd : any;// NOSONAR
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords: any;
  datastoreSubscription: any;
  childReportForm!: FormGroup;
  clientAccountId: any;
  minDate: Date=new Date();
  maxOpenDate:Date=new Date();
  showBusy:boolean=false;
  mandatoryField = false;
  isVissbleButton:boolean=false;
  constructor(
    private readonly _commonService: CommonHttpService,
    private readonly _alertService: AlertService,
    private readonly formBuilder: FormBuilder,
    private readonly datePipe: DatePipe,
    private readonly _datastoreService: DataStoreService,
    private readonly _authServie: AuthService,
    private readonly _commonDDservice: CommonDropdownsService) { }
  dtformat = 'YYYY-MM-DD';
  ngOnInit() {
    this.maxOpenDate = new Date();
    this.initAccountForm();
    this.initEditAccountForm();
    this.getAccountStatus();
    this.getDropdown();
    this.childReport();
    this.isVissbleButton = this._authServie.isVissbleButton('read_only_access', '');
    this.datastoreSubscription = this._datastoreService.currentStore.subscribe(store => {
      const selectedDept = store['selectedFinanceDept'];
      if (selectedDept && selectedDept !== this.selectedDept) {
        this.selectedDept = selectedDept;
        this.getcommingledAccountslist(1);
      }
    });
  }

  ngOnDestroy() {
    this.datastoreSubscription.unsubscribe();
  }

  initAccountForm() {
    this.addCommingledForm = this.formBuilder.group({
      open_dt: [{ value: ''}],
      close_dt: [{ value: '', disabled: true}],
      bank_nm: ['', Validators.required],
      // status_cd: ['', Validators.required],
      status_cd: [{disabled: true}, Validators.required],
      local_dept: [{ value: '', disabled: true }, Validators.required],
      bank_acc_num: ['', Validators.required],
      // total_balance: ['', Validators.required],
      entered_by: [''],
      interest_amount_no: [''],
      total_balance_no: ['']
    });
  }

  initEditAccountForm() {
    this.editAccountForm = this.formBuilder.group({
      open_dt: [{ value: '', disabled: true}],
      close_dt: [''],
      bank_nm: ['', Validators.required],
      approval_status_cd: ['', Validators.required],
      county_cd: [{ value: '', disabled: true }, Validators.required],
      account_no: ['', Validators.required],
      // total_balance_no:['', Validators.required]
    });
  }

  childReport() {
    this.childReportForm = this.formBuilder.group({
      date_sw: ['Y'],
      date_from: [null],
      date_to: [null]
    });
  }

  onChangeDate(form:any) {
    this.minDate = new Date(form.value.open_dt);
    form?.get('close_dt')?.reset();
  }

  addCommingledAccount() {
    this.addCommingledForm.markAllAsTouched();
    this.mandatoryField=true;
    if(this.addCommingledForm.invalid){
      return false;
    }
    if (this.addCommingledForm.valid) {
      const data = this.addCommingledForm.getRawValue();
     
      if ( this.addCommingledForm.getRawValue().open_dt && this.addCommingledForm.getRawValue().close_dt ) {
        const openDate = moment(new Date(this.addCommingledForm.getRawValue().open_dt)).format(this.dtformat);
        const closeDate = moment(new Date(this.addCommingledForm.getRawValue().close_dt)).format(this.dtformat);
        if ( new Date(openDate).getTime() > new Date(closeDate).getTime()) {
          this._alertService.error('Close Date should be greater than or equal to Open Date');
          return false;
        }
      }

      this._commonService.create({

        'openDt': (data.open_dt) ? data.open_dt : null,
        'closeDt': (this.addCommingledForm.value.close_dt) ? this.datePipe.transform(this.addCommingledForm.value.close_dt, 'yyyy-MM-dd') : null,
        'bankNm': data.bank_nm,
        'accountNo': data.bank_acc_num,
        'approvalStatusCd': data.status_cd,
        'countyCd': data.local_dept,
        'totalBalanceNo': data.total_balance,
        'deleteSw': 'N'
      }
        , FinanceUrlConfig.EndPoint.commingledAccounts.addCommingledAccountUrl).subscribe((result:any) => {
          this.addCommingledAccountUrlResponseFn(result);
        });
    } else {
      this._alertService.warn('Please fill the mandatory details.');
    }
    return true;
  }
  // Associated with addCommingledAccount function
  private addCommingledAccountUrlResponseFn(result: any) {
    if (result) {
      if (result['UserToken'].isaccountexists) {
        this._alertService.error('Commingled Account Bank details already exist');
      } else {
        this._alertService.success('Commingled Account added successfully');
        this.getcommingledAccountslist(this.pageChanged);
      }
      (<any>$('#addNewAccount')).modal('hide');// NOSONAR
    } else {
      this._alertService.error('Commingled Account not added successfully');
    }
  }

  UpdateCase() {
    if (this.editAccountForm.valid) {
      const data = this.editAccountForm.getRawValue();

      if ( this.editAccountForm.getRawValue().open_dt && this.editAccountForm.getRawValue().close_dt) {
        const openDate = moment(new Date(this.editAccountForm.getRawValue().open_dt)).format(this.dtformat);
        const closeDate = moment(new Date(this.editAccountForm.getRawValue().close_dt)).format(this.dtformat);
        if ( new Date(openDate).getTime() > new Date(closeDate).getTime()) {
          this._alertService.error('Close Date should be greater than or equal to Open Date');
          return false;
        }
      }

      this._commonService.update('',
        {
          'commAccountId': this.selectedAccount.comm_account_id,
          'account_type_cd': data.account_type_cd,
          'bankNm': data.bank_nm,
          'accountNo': data.account_no,
          'totalBalanceNo': data.total_balance_no,
          'deleteSw': 'N',
          'openDt': (data.open_dt) ? moment(new Date(data.open_dt)).format('MM/DD/YYYY') : null,
          'closeDt': (data.close_dt) ?  moment(new Date(data.close_dt)).format('MM/DD/YYYY') : null,
          'approvalStatusCd': data.approval_status_cd,
          'countyCd': data.county_cd
        }
        , FinanceUrlConfig.EndPoint.commingledAccounts.updateAccountUrl).subscribe((result:any) => {
          this.updateAccountUrlResponseFn(result);
        });
    } else {
      this._alertService.warn('Please fill the mandatory details.');
    }
    return true
  }
  // Associated with UpdateCase function
  private updateAccountUrlResponseFn(result: any) {
    if (result) {
      if (result['UserToken'].isaccountexists) {
        this._alertService.error('Commingled Account Bank details already exist');
      } else {
        if (result['UserToken'].ischildexist === false) {
          this._alertService.success('Commingled Account updated successfully');
          this.getcommingledAccountslist(this.pageNo);
          (<any>$('#editAccount')).modal('hide');// NOSONAR
        } else {
          this._alertService.error('A commingled account cannot be closed if any associated child account is active or if the total balance is greater than zero.');
        }
      }
    }
  }

  getcommingledAccountslist(page:any) {
    const CommingledAccountUrl = `${FinanceUrlConfig.EndPoint.commingledAccounts.getCommingledAccountUrl}?filter`;
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: { localdepartment: this.selectedDept },
      page: page,
      limit: 10,
      method: 'get'
    }), CommingledAccountUrl).subscribe((result:any) => {
      this.commingledAccountslist = result['data'];
      this.totalRecords = result['count'];
    });

  }

  pageChanged(page:any) {
      this.pageNo = page;
    this.getcommingledAccountslist(page);
  }

  // getchilddetailslist() {
  //   if (this.selectedDept)
  //     this.getcommingledAccountslist();
  // }

  getAccountType() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '40'
      },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.commingledAccounts.pickListUrl).subscribe((result:any) => {
      this.accountType = result;
    });
  }

  getAccountStatus() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '365'
      },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.commingledAccounts.pickListUrl).subscribe((result:any) => {
      this.accountStatus = result;
    });
  }


  getDropdown() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '104'
      },
      nolimit: true,
      method: 'get'
    }), FinanceUrlConfig.EndPoint.commingledAccounts.pickListUrl).subscribe((result:any) => {
      this.localDept = result;
    });
  }

  viewAccount(account:any) {
    this.selectedAccount = account;
  }

  editAccount(account:any) {
    this.minDate = new Date(account.open_dt);
    this.selectedAccount = account;
    this.editAccountForm.patchValue(account);
    if (account.close_dt) {
        this.editAccountForm.patchValue({
          approval_status_cd: '3565'
        });
        this.approval_status_cd = 'Closed';
        account.approval_status_cd = '3565';
    } else {
        this.editAccountForm.patchValue({
          approval_status_cd: '3564'
        });
        this.approval_status_cd =  'Active';
        account.approval_status_cd = '3564';
    }
    this.editAccountForm.disable();
    this.editAccountForm?.get('approval_status_cd')?.enable();
    this.editAccountForm?.get('county_cd')?.disable();
    if (account.close_dt) {
      this.editAccountForm?.get('close_dt')?.disable();
    }
    (<any>$('#editAccount')).modal('show');// NOSONAR
  }

  statusChange(id:any, mode:any) {
    const formNm = (mode === 'add') ? this.addCommingledForm : this.editAccountForm;
    if (mode === 'edit') {
      if (this.selectedAccount && +this.selectedAccount.total_balance_no <= 0) {
        formNm?.get('close_dt')?.enable();
        if (id === '592') {
          formNm?.get('close_dt')?.setValue(null);
          formNm?.get('close_dt')?.disable();
        }
      } else {
        this.editAccountForm?.get('approval_status_cd')?.reset();
        this.editAccountForm.patchValue({
          approval_status_cd: this.selectedAccount.approval_status_cd
        });
        this._alertService.error('Account cannot be closed if balance is more than $0.00');
      }
    } else {
      formNm?.get('close_dt')?.enable();
      if (id === '592') {
        formNm?.get('close_dt')?.setValue(null);
        formNm?.get('close_dt')?.disable();
      }
    }

  }

  deleteAccount(account:any) {
    this.selectedAccount = account;
  }


  deleteItem() {
    this._commonService.create(
      {
        'commAccountId': this.selectedAccount.comm_account_id
      },
      FinanceUrlConfig.EndPoint.commingledAccounts.deleteCommingledAccount).subscribe(
        () => {
          this._alertService.success('Account deleted successfully');
          (<any>$('#deleteAccount')).modal('hide');// NOSONAR
          this.getcommingledAccountslist(1);
        }
      );
  }


  openAddModal() {
    if (this.selectedDept) {
      this.getAccountStatus();
      this.addCommingledForm.reset();
      this.addCommingledForm.patchValue({
        open_dt: new Date(),
        local_dept: this.selectedDept.trim(),
        status_cd: '3564'
      });
      this.addCommingledForm?.get('status_cd')?.disable();
      (<any>$('#addNewAccount')).modal('show');// NOSONAR
    } else {
      this._alertService.warn('Please select the Department.');
    }
  }

  accountTypeSelected(event:any) {
    if (event.value === '591') {
      this.addCommingledForm?.get('bank_nm')?.setValidators([Validators.required]);
      this.addCommingledForm?.get('bank_acc_num')?.setValidators([Validators.required]);
      this.addCommingledForm?.get('bank_nm')?.updateValueAndValidity();
      this.addCommingledForm?.get('bank_acc_num')?.updateValueAndValidity();
    } else if (event.value === '590') {
      this.addCommingledForm?.get('bank_nm')?.clearValidators();
      this.addCommingledForm?.get('bank_acc_num')?.clearValidators();
      this.addCommingledForm?.get('bank_nm')?.updateValueAndValidity();
      this.addCommingledForm?.get('bank_acc_num')?.updateValueAndValidity();
    }
  }

  documentPopup(commAccountId:any) {
    this.showBusy = false;
    this.clientAccountId = commAccountId;
  }

  clearchildForm() {
    this.childReportForm.reset();
    this.childReportForm.patchValue({
      date_sw: 'M'
  });
  }

  documentGenerate(childReport:any, type:any) {
    this.showBusy = true;
    const modal = {
      count: -1,
      where: {
        documenttemplatekey: ['child117report'],
        commaccountid: this.clientAccountId,
        date_sw: childReport.date_sw,
        date_from: childReport.date_from,
        date_to: childReport.date_to,
        format: type
      },
      method: 'post'
    };
      this._commonService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
          this.showBusy = false;
          const blob = new Blob([new Uint8Array(res)]);
          const link = document.createElement('a');
          link.href = window.URL.createObjectURL(blob);
          if (type === 'pdf') {
            link.download = 'DHS_117_Commingled_Account_History_Report.pdf';
          } else if (type === 'excel') {
            link.download = 'DHS_117_Commingled_Account_History_Report.xlsx';
          }

          document.body.appendChild(link);

          link.click();

          document.body.removeChild(link);
          this.clearchildForm();
          (<any>$('#downloadReport')).modal('hide');// NOSONAR
        });
  }
}

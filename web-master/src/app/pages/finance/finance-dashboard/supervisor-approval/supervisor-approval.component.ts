import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, AuthService, SessionStorageService } from '../../../../@core/services';
import { Router } from '@angular/router';
import { AccountDisbursement } from '../../finance.constants';
import { AppUser } from '../../../../@core/entities/authDataModel';

@Component({
    selector: 'supervisor-approval',
    templateUrl: './supervisor-approval.component.html',
    styleUrls: ['./supervisor-approval.component.scss'],
    standalone: false
})
export class SupervisorApprovalComponent implements OnInit {

  totalcount!: number;
  totalpagecount!: number;
  pageInfo: PaginationInfo = new PaginationInfo();
  fundingData: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  paymentData: any[] = [];
  userProfile!: AppUser;
  isFW!: boolean;
  isFS!: boolean;
  status!: number;
  statusDropDownList = [
    {
      'text': 'All',
      'value': 'All'
    },
    {
      'text': 'Approved',
      'value': 'A'
    },
    {
    'text': 'Pending',
    'value': 'P'
    },
    {
      'text': 'Denied',
      'value': 'R'
    },
  ];
  fundDisStatus: any;
  paymentDisStatus: any;
  activeModule: any;
  isValue: any = 1;
  constructor(
    private _commonService: CommonHttpService,
    private _alertService: AlertService,
    private _router: Router,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService,
    private _sessionStorage: SessionStorageService
  ) { }

  ngOnInit() {
    this.fundDisStatus = 'P';
    this.paymentDisStatus = 'P';
    this.userProfile = this._authService.getCurrentUser();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
  }
  loadInfo() {
    this.fundDisStatus = 'P';
    this.paymentDisStatus = 'P';
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance Approval') {
      this.status = 56;
      this.isFS = true;
      this.isFW = false;
    } else if (this.activeModule === 'Finance') {
      this.status = 58;
      this.isFS = false;
      this.isFW = true;
    }
    this.getPaymentDisbursementApprove();
    this.getFundingDisbursementApprove();
  }
  statusFundingDropDown(status: any) {
    this.fundDisStatus = status;
    this.getFundingDisbursementApprove();
  }
  statusPaymentDropDown(status: any) {
    this.paymentDisStatus = status;
    this.getPaymentDisbursementApprove();
  }

  getPaymentDisbursementApprove() {
    this.isValue = 2;
    this._commonService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: {status: 57, dispstatus: this.paymentDisStatus},
      method: 'get'
    }, 'tb_child_account_disbursement/listFinalDisbursement?filter')
      .subscribe((res: any) => {
        if (res) {
          this.paymentData = res.data;
          this.totalcount = (this.paymentData && this.paymentData.length > 0) ? this.paymentData[0].totalcount : 0;
        }
      });
  }
  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page;
    this.getPaymentDisbursementApprove();
  }

  reDirectToDisbursement(paymentData: any) {
    this._router.navigate(['/pages/finance/child-accounts/child-accounts/' + paymentData.client_id]);
    this._dataStoreService.setData(AccountDisbursement.FundingParms, paymentData);
  }

  getFundingDisbursementApprove() {
    this.isValue = 1;
    this._commonService.getPagedArrayList({
      limit: this.pageInfo.pageSize,
      page: this.pageInfo.pageNumber,
      where: {status: this.status, dispstatus: this.fundDisStatus},
      method: 'get'
    }, 'tb_child_account_disbursement/listFinalDisbursement?filter')
      .subscribe((res: any) => {
        if (res) {
          this.fundingData = res.data;
          this.totalpagecount = (this.fundingData && this.fundingData.length > 0) ? this.fundingData[0].totalcount : 0;
        }
      });
  }
   pageNumberChanged(page: any) {
    this.pageInfo.pageNumber = page;
    this.getFundingDisbursementApprove();
  }

  reDirectToFundingDisbursement(fundingData: any) {
    this._router.navigate(['/pages/finance/child-accounts/child-accounts/' + fundingData.client_id]);
    this._dataStoreService.setData(AccountDisbursement.FundingParms, fundingData);
  }

}

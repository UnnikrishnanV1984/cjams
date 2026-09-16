import { Component, OnInit } from '@angular/core';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { Router } from '@angular/router';
import { FinanceUrlConfig } from '../../finance.url.config';
import { ChildAccount } from '../../finance.constants';

@Component({
    selector: 'child-transaction-approval',
    templateUrl: './child-transaction-approval.component.html',
    styleUrls: ['./child-transaction-approval.component.scss'],
    standalone: false
})
export class ChildTransactionApprovalComponent implements OnInit {

  userProfile!: AppUser;
  pageInfo: PaginationInfo = new PaginationInfo();
  routID!: number;
  childErrorCorrectionData!: any[];
  totalcount: any;
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
  childStatus: any;
  activeModule: any;

  constructor(
    private _authService: AuthService,
    private _commonService: CommonHttpService,
    private _router: Router,
    private _dataStoreService: DataStoreService,
    private _sessionStorage: SessionStorageService
  ) { }

  ngOnInit() {
    this.userProfile = this._authService.getCurrentUser();
    this.childStatus = 'P';
    this.pageInfo.pageNumber = 1;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
  }
  loadInfo() {
    this.childStatus = 'P';
    this.pageInfo.pageNumber = 1;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      this.routID = 81;
   } else if (this.activeModule === 'Finance Approval') {
     this.routID = 82;
   }
   this.getErrorCorrection();
  }
  statusDropDown(status: any) {
    this.childStatus = status;
    this.getErrorCorrection();
  }

  getErrorCorrection() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.childAccounts.transactionApproval;
    const modal = {
      routingstatustypeid: this.routID,
      page : this.pageInfo.pageNumber,
      limit : this.pageInfo.pageSize,
      statusval: this.childStatus
    };
    this._commonService.create(modal).subscribe(
      (response) => {
        if (response) {
          this.childErrorCorrectionData = response.data;
          this.totalcount = (this.childErrorCorrectionData && this.childErrorCorrectionData.length > 0) ? this.childErrorCorrectionData[0].totalcount : 0;
        }
      });
  }

  pageChanged(page: any) {
    this.pageInfo.pageNumber = page;
    this.getErrorCorrection();
  }

 reDirectToAccount(account: any) {
    this._router.navigate(['/pages/finance/child-accounts/interest-transactions']);
    this._dataStoreService.setData(ChildAccount.ErrorCorrection, account);
  }

}

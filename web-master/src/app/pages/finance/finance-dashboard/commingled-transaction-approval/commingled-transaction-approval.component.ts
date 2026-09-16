import { Component, OnInit } from '@angular/core';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { FinanceUrlConfig } from '../../finance.url.config';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { Router } from '@angular/router';
import { CommingledAccount } from '../../finance.constants';

@Component({
    selector: 'commingled-transaction-approval',
    templateUrl: './commingled-transaction-approval.component.html',
    styleUrls: ['./commingled-transaction-approval.component.scss'],
    standalone: false
})
export class CommingledTransactionApprovalComponent implements OnInit {
  userProfile!: AppUser;
  pageInfo: PaginationInfo = new PaginationInfo();
  routID!: number;
  errorCorrectionData: any[] = [];
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
  commingledStatus: any;
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
    this.commingledStatus = 'P';
    this.pageInfo.pageNumber = 1;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
  }
  loadInfo() {
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.commingledStatus = 'P';
    this.pageInfo.pageNumber = 1;
    if (this.activeModule === 'Finance') {
      this.routID = 45;
   } else {
     this.routID = 53;
   }
   this.getErrorCorrection();
  }
  statusDropDown(status: any) {
    this.commingledStatus = status;
    this.getErrorCorrection();
  }

  getErrorCorrection() {
    this._commonService.endpointUrl = FinanceUrlConfig.EndPoint.commingledAccounts.errorCorection;
    const modal = {
      routingstatustypeid: this.routID,
      page : this.pageInfo.pageNumber,
      limit : this.pageInfo.pageSize,
      statusval: this.commingledStatus
    };
    this._commonService.create(modal).subscribe(
      (response) => {
        if (response) {
          this.errorCorrectionData = response.data;
          this.totalcount = (this.errorCorrectionData && this.errorCorrectionData.length > 0) ? this.errorCorrectionData[0].totalcount : 0;
        }
      });
  }

  pageChanged(page: any) {
    this.pageInfo.pageNumber = page;
    this.getErrorCorrection();
  }

  reDirectToAccount(account: any) {
    this._router.navigate(['/pages/finance/commingled-accounts/interest-transactions']);
    this._dataStoreService.setData(CommingledAccount.ErrorCorrection, account);
  }

}

import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { CommonHttpService, AuthService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { Router } from '@angular/router';
import { FinanceUrlConfig } from '../../finance.url.config';

@Component({
    selector: 'ar-reversal-receipt',
    templateUrl: './ar-reversal-receipt.component.html',
    styleUrls: ['./ar-reversal-receipt.component.scss'],
    standalone: false
})
export class ArReversalReceiptComponent implements OnInit {

  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  manualList: any[] = [];
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
    }
  ];
  manualStatus: any;
  statusId!: string;
  userProfile!: AppUser;
  routID!: number;
  activeModule: any;
  constructor(
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
    private _dataStoreService: DataStoreService,
    private _router: Router,
    private _sessionStorage: SessionStorageService) { }

  ngOnInit() { 
    this.userProfile = this._authService.getCurrentUser();
    this.paginationInfo.pageNumber = 1;
    this.manualStatus = 'P';
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
  }
  loadInfo() {
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.paginationInfo.pageNumber = 1;
    this.manualStatus = 'P';
    if (this.activeModule === 'Finance') {
      this.routID = 73;
    } else if (this.activeModule === 'Finance Approval') {
      this.routID = 74;
    }
    this.loadList();
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo;
    this.loadList();
  }

  loadList() {
    this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.history.receipt.dashboardList;
    const modal = {
      method: 'get',
      page : this.paginationInfo.pageNumber,
      limit : this.paginationInfo.pageSize,
      where: {
        statusval: this.manualStatus
        // routingstatustypeid: this.routID,
      }
    };
    this._commonHttpService.getPagedArrayList(modal).subscribe(
      (response) => {
        if (response && response.data && response.data.length > 0) {
          this.manualList = response.data[0].getreversalreceiptlist;
          this.totalcount = (this.manualList && this.manualList.length > 0) ? this.manualList[0].totalcount : 0;
        }
      });
  }

  openProvider(provider: any) {
    this._dataStoreService.setData('ReversalReceiptFromDashboard', provider);
    this._router.navigate([`/pages/finance/finance-accountsReceivable/provider/${provider.provider_id}/history/overpayments`]);
  }

  statusManualDropDown(status: any) {
    this.manualStatus = status;
    this.loadList();
  }

}

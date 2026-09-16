import { Component, OnInit } from '@angular/core';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { FinanceAdjustment } from '../../finance.constants';
import { Router } from '@angular/router';

@Component({
    selector: 'ancillary-payment-adjustment',
    templateUrl: './ancillary-payment-adjustment.component.html',
    styleUrls: ['./ancillary-payment-adjustment.component.scss'],
    standalone: false
})
export class AncillaryPaymentAdjustmentComponent implements OnInit {
  user!: AppUser;
  selectedProvider: any[] = [];
  selectedPayment: any[] = [];
  userID!: string;
  isFinanceSupervisor!: boolean;
  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  url!: string;
  selectedProviderId!: number;
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
  ancillaryStatus: any;
  status: any;
  activeModule: any;

  constructor(
    private _commonService: CommonHttpService,
    private _authService: AuthService,
    private _router: Router,
    private _datastoreService: DataStoreService,
    private _sessionStorage: SessionStorageService
  ) { }

  ngOnInit() {
    this.ancillaryStatus = 'P';
    this.user = this._authService.getCurrentUser();
    this.userID = this.user.user.securityusersid;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.paginationInfo.pageNumber = 1;
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
  }
  loadInfo() {
    this.userID = this.user.user.securityusersid;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.ancillaryStatus = 'P';
    this.paginationInfo.pageNumber = 1;
    if (this.activeModule === 'Finance') {
      this.isFinanceSupervisor = false;
    } else if (this.activeModule === 'Finance Approval') {
      this.isFinanceSupervisor = true;
    }
    
    this.getSelectedProvider();
  }
  statusAncillaryDropDown(status: any) {
    this.ancillaryStatus = status;
    this.getSelectedProvider();
  }


  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page;
    this.getSelectedProvider();
  }

  getSelectedProvider() {
    if (this.isFinanceSupervisor) {
      this.url = 'tb_payment_header/getancillarysupervisorlist';
    } else {
      this.url = 'tb_payment_header/getancillaryadjustmentlist';
    }

    this._commonService.getPagedArrayList(
      new PaginationRequest({
        where: {providerid: null, status: this.ancillaryStatus},
        limit: this.paginationInfo.pageSize, // this.paginationInfo.pageSize
        page: this.paginationInfo.pageNumber, // this.paginationInfo.pageNumber
        method: 'get'
    }), this.url + '?filter'
    ).subscribe(response => {
      this.selectedProvider = response.data;
      this.totalcount = (this.selectedProvider && this.selectedProvider.length > 0) ? this.selectedProvider[0].totalcount : 0;
    });
  }

  ancillaryAdjustment(provider: any) {
    this._datastoreService.setData(FinanceAdjustment.SelectedpaymentFromDashboard, provider);
    this._router.navigate(['pages/finance/finance-adjustment/payment-adjustment']);
  }
}

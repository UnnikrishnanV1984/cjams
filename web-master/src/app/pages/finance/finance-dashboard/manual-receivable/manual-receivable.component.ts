import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AuthService, SessionStorageService, DataStoreService } from '../../../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { FinanceUrlConfig } from '../../finance.url.config';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AccountReceivable } from '../../finance.constants';

@Component({
    selector: 'manual-receivable',
    templateUrl: './manual-receivable.component.html',
    styleUrls: ['./manual-receivable.component.scss'],
    standalone: false
})
export class ManualReceivableComponent implements OnInit {

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
    private _router: Router,
    private _route: ActivatedRoute,
    private _sessionStorage: SessionStorageService,
    private _dataStore: DataStoreService
  ) { }

  ngOnInit() {
    this.userProfile = this._authService.getCurrentUser();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.paginationInfo.pageNumber = 1;
    this.manualStatus = 'P';
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
    } else {
      this.routID = 74;
    }
    this.loadList();
  }
  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo;
    this.loadList();
  }

  loadList() {
    this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.manualOverPayment.dashboardList;
    const modal = {
      routingstatustypeid: this.routID,
      page : this.paginationInfo.pageNumber,
      limit : this.paginationInfo.pageSize,
      statusval: this.manualStatus
    };
    this._commonHttpService.create(modal).subscribe(
      (response) => {
        if (response) {
          this.manualList = response.data;
          this.totalcount = (this.manualList && this.manualList.length > 0) ? this.manualList[0].totalcount : 0;
        }
      });
  }

  openProvider(provider: any) {
    this._dataStore.setData(AccountReceivable.WriteOff, provider);
    this._router.navigate([`/pages/finance/finance-accountsReceivable/provider/${provider.provider_id}/overpayments`]);
  }

  statusManualDropDown(status: any) {
    this.manualStatus = status;
    this.loadList();
  }

}

import { Component, OnInit } from '@angular/core';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AuthService, SessionStorageService, DataStoreService } from '../../../../@core/services';
import { FinanceUrlConfig } from '../../finance.url.config';
import { ActivatedRoute, Router } from '@angular/router';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AccountReceivable } from '../../finance.constants';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'writeoff-approval',
    templateUrl: './writeoff-approval.component.html',
    styleUrls: ['./writeoff-approval.component.scss'],
    standalone: false
})
export class WriteoffApprovalComponent implements OnInit {

  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  writeOffList: any[] = [];
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
  writeOffStatus: any;
  statusId!: string;
  activeModule: any;
  roletype!: string;
  financeSupervisor!: boolean;
  user!: AppUser;

  constructor(
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
    private _router: Router,
    private _route: ActivatedRoute,
    private _sessionStorage: SessionStorageService,
    private _dataStore: DataStoreService
  ) { }

  ngOnInit() {
    this.paginationInfo.sortColumn = 'write_off_request_date';
    this.paginationInfo.sortBy = 'desc';
    this.loadDashboard();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadDashboard();
    });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo;
    this.loadList();
  }

  onSorted($event: ColumnSortedEvent) {
  this.paginationInfo.sortBy = $event.sortDirection;
  this.paginationInfo.sortColumn = $event.sortColumn;
  this.loadList();
  }

  loadDashboard() {
    this.user = this._authService.getCurrentUser();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance Approval') {
      if (this.user.role.name === 'Central Office Fiscal Supervisor') {
        this.roletype = 'FNSCOFS';
      } else {
        this.roletype = 'FNSFS';
      }
      this.financeSupervisor = true;
    } else if (this.activeModule === 'Finance') {
      if (this.user.role.name === 'Central Office Fiscal Staff') {
        this.roletype = 'FNSCOFW';
      } else {
        this.roletype = 'FNSFW';
      }
      this.financeSupervisor = false;
    }
    this.paginationInfo.pageNumber = 1;
    this.writeOffStatus = 'P';
    this.statusId = `{3045}`;
    this.loadList();
  }

  loadList() {
    this._commonHttpService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: {
        writeoffstatus: this.statusId,
        status: this.writeOffStatus,
        roletypekey: this.roletype ? this.roletype : null,
        sortcolumn: this.paginationInfo.sortColumn,
        sortorder: this.paginationInfo.sortBy
      },
      method: 'post'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.search.dashboardList)
      .subscribe((res: any) => {
        if (res) {
          this.writeOffList = res;
          this.totalcount = (this.writeOffList && this.writeOffList.length > 0) ? this.writeOffList[0].totalcount : 0;
        }
      });
  }

  openProvider(provider: any) {
    this._dataStore.setData(AccountReceivable.WriteOff, provider);
    this._router.navigate([`/pages/finance/finance-accountsReceivable/provider/${provider.provider_id}/overpayments`]);
  }

  statusWriteOffDropDown(status: string) {
    if (status === 'All') {
      this.statusId = `{3045, 3047}`;
    } else if (status === 'P') {
      this.statusId = `{3045}`;
    } else if (status === 'A') {
      this.statusId = `{3047}`;
    } else if (status === 'R') {
      this.statusId = `{3281}`;
    }
    this.writeOffStatus = status;
    this.loadList();
  }

}

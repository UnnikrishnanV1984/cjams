import { Component, OnInit } from '@angular/core';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { FinanceAdjustment } from '../../finance.constants';
import { Router } from '@angular/router';
import { CaseWorkerUrlConfig } from '../../../../pages/case-worker/case-worker-url.config';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';

@Component({
    selector: 'cfe-retainer-payment',
    templateUrl: './cfe-retainer-payment.component.html',
    styleUrls: ['./cfe-retainer-payment.component.scss'],
    standalone: false
})
export class CfeRetainerPaymentComponent implements OnInit {
  user!: AppUser;
  selectedProvider = [];
  selectedPayment!: any[];
  userID!: string;
  isFinanceSupervisor!: boolean;
  isFinanceWorker!: boolean;
  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  url!: string;
  selectedProviderId!: number;
  statusDropDownList = [
    {
    'text': 'Pending',
    'value': 'P'
    }
  ];
  ancillaryStatus: any;
  status: any;
  activeModule: any;
  ancillaryServicesList: any = [];
  private token!: AppUser;
  roletype!: string;

  constructor(
    private _commonService: CommonHttpService,
    private _authService: AuthService,
    private _router: Router,
    private _datastoreService: DataStoreService,
    private _sessionStorage: SessionStorageService
  ) { }

  ngOnInit() {
    this.token = this._authService.getCurrentUser();
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
    if (this.activeModule === 'Finance Approval') {
      this.roletype = 'FNSFS';
      this.isFinanceSupervisor = true;
      this.isFinanceWorker = false;
    } else if (this.activeModule === 'Finance') {
      this.roletype = 'FNSFW';
      this.isFinanceSupervisor = false;
      this.isFinanceWorker = true;
    } else {
      this.roletype = 'FNSDF';
      this.isFinanceSupervisor = false;
      this.isFinanceWorker = false;
    }
    this.listAncillaryServices(this.isFinanceSupervisor ? 'FS' : 'FW');
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page;
    this.listAncillaryServices(this.isFinanceSupervisor ? 'FS' : 'FW');
  }

  listAncillaryServices(userRole: any) {
    this._commonService.getPagedArrayList(
        new PaginationRequest({
            where: { 
              securityuserid: this.token.user.securityusersid,
              userrole: userRole,
              status: 'pending',
              pagenumber : this.paginationInfo.pageNumber,
              pagesize : this.paginationInfo.pageSize,
            },
            method: 'post'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.AncillaryServices.list
    )
    .subscribe(result => {
        this.ancillaryServicesList = (result.data) ? result.data : [];
        this.totalcount = (this.ancillaryServicesList && this.ancillaryServicesList.length > 0) ? this.ancillaryServicesList?.[0]?.totalcount : 0;
    });
  }

  ancillaryAdjustment(id: any) {
    this._datastoreService.setData(FinanceAdjustment.AncillaryServicesId, id);
    this._router.navigate(['pages/provider-payment-management/cfe-payment']);
  }

  onSortedFunding($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.listAncillaryServices('FW');
  }

  onSortedPayment($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.listAncillaryServices('FS');
  }
  
}
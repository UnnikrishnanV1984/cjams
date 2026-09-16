import { Component, OnDestroy } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, CommonHttpService } from '../../../../@core/services';
import { FinanceStoreConstants } from '../../finance.constants';
import { FinanceUrlConfig } from '../../finance.url.config';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';

@Component({
    selector: 'app-finance-accountsReceivable-search-result',
    templateUrl: './finance-accountsReceivable-search-result.component.html',
    styleUrls: ['./finance-accountsReceivable-search-result.component.scss'],
    standalone: false
})
export class FinanceAccountsReceivableSearchResultComponent implements OnDestroy {
  searchParams: any;
  providerList :any[]= [];
  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  isTaxidHidden: boolean = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  
  constructor(
    private _route: ActivatedRoute,
    private _router: Router,
    private _datastoreService: DataStoreService,
    private _commonHttpService: CommonHttpService
  ) {
  }

  getARSearchData(page:any) {
    this.paginationInfo.sortColumn = null;
    this.paginationInfo.sortBy = null;
    this.paginationInfo.pageNumber = page;
    const searchParams = this._datastoreService.getData(FinanceStoreConstants.AccountsReceivableSearchParams);
    if (!searchParams) {
        this.searchParams = null;
        this.providerList = [];
        this.totalcount = 0;
    } else if (searchParams) {
      this.searchParams = searchParams;
      ObjectUtils.removeEmptyProperties(this.searchParams);
      this.paginationInfo.pageNumber = 1;
     this.getFilteredProviders();
    }
  }

  onARSearch($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getFilteredProviders();
  }

  toggleSsn = (row:any) => {
    row.isSsnHidden = (row.isSsnHidden !== null && row.isSsnHidden !== undefined ? !row.isSsnHidden : !this.isTaxidHidden);
    if (row.isSsnHidden) {
      row.ssnEye = 'fa-eye';
      row.showSsnMask = true;
    } else {
      row.ssnEye = 'fa-eye-slash';
      row.showSsnMask = false;
    }
  }

  private getFilteredProviders() {
    this.searchParams.sortorder = this.paginationInfo.sortBy ? this.paginationInfo.sortBy : null;
    this.searchParams.sortcolumn = this.paginationInfo.sortColumn ? this.paginationInfo.sortColumn : null;
    this._commonHttpService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: this.searchParams,
      method: 'post'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.search.list)
      .subscribe((res: any) => {
        if (res) {
          this.providerList = res;
          this.totalcount = (this.providerList && this.providerList.length > 0) ? this.providerList[0].totalcount : 0;
        }
      });
  }

  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.getFilteredProviders();
  }

  openProvider(provider:any) {
    this._datastoreService.setData(FinanceStoreConstants.SelectedProvider, provider);
    this._router.navigate(['../provider/' + provider.provider_id], { relativeTo: this._route });
  }

  ngOnDestroy(): void {
    this._datastoreService.setData(FinanceStoreConstants.AccountsReceivableSearchParams, null);
  }
}

import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, CommonHttpService } from '../../../../../../@core/services';
import { PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { FinanceFundingSource } from '../../../../finance.constants';
import { FinanceUrlConfig } from '../../../../finance.url.config';

@Component({
    selector: 'funding-allocation-result',
    templateUrl: './funding-allocation-result.component.html',
    styleUrls: ['./funding-allocation-result.component.scss'],
    standalone: false
})
export class FundingAllocationResultComponent implements OnInit {
  searchParams: any;

  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  fundingSearch: any;
  totalRecords!: number;
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;

  constructor(
    private _route: ActivatedRoute,
    private _router: Router,
    private _datastoreService: DataStoreService,
    private _commonHttpService: CommonHttpService
  ) {
    }

  ngOnInit() {
    this.paginationInfo.pageNumber = 1;
    this.fundingSearch = this._datastoreService.getData(FinanceFundingSource.FundingSourceResults);
  }



  getFundingSearchData(page:any) {
    this.paginationInfo.pageNumber = page;
        const searchParams = this._datastoreService.getData(FinanceFundingSource.FundingSourceSearchParams);
        if (!searchParams){
          this.searchParams = null;
          this.fundingSearch = [];
          this._datastoreService.setData(FinanceFundingSource.FundingSourceResults,this.fundingSearch);
          this.totalRecords = 0;
        } else if (searchParams) {
          this.searchParams = searchParams;
        this.assignDataToSearchParamsFn();
        this._commonHttpService.getPagedArrayList({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        where: this.searchParams,
        method: 'post'
        }, FinanceUrlConfig.EndPoint.accountsPayable.history.searchFundingAllocation).subscribe((res: any) => {
            if (res) {
                this.fundingSearch = res.data;
                this._datastoreService.setData(FinanceFundingSource.FundingSourceResults,res.data);
                this.totalRecords = (this.fundingSearch && this.fundingSearch.length > 0) ? this.fundingSearch[0].totalcount : 0;
            }
        });
        }
  }
  // Associated with getFundingSearchData function
  private assignDataToSearchParamsFn() {
    this.searchParams.client_id = this.searchParams.client_id ? this.searchParams.client_id : null;
    this.searchParams.client_first_name = this.searchParams.client_first_name ? this.searchParams.client_first_name : null;
    this.searchParams.client_last_name = this.searchParams.client_last_name ? this.searchParams.client_last_name : null;
    this.searchParams.ssn = this.searchParams.ssn ? this.searchParams.ssn : null;
    this.searchParams.dobdaterangefrom = this.searchParams.dobdaterangefrom ? this.searchParams.dobdaterangefrom : null;
    this.searchParams.dobdaterangeto = this.searchParams.dobdaterangeto ? this.searchParams.dobdaterangeto : null;
    this.searchParams.local_dept = this.searchParams.local_dept ? this.searchParams.local_dept : null;
    this.searchParams.caseworker_name = this.searchParams.caseworker_name ? this.searchParams.caseworker_name : null;
  }

  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.getFundingSearchData(page);
  }

  fundingDetails(fund:any) {
    this._datastoreService.setData(FinanceFundingSource.SelectedFundingSource, fund);
    this._router.navigate(['../details'], { relativeTo: this._route });
  }

  toggleSsn = () => {
    this.isSsnHidden = !this.isSsnHidden;
    if (this.isSsnHidden) {
      this.ssnEye = 'fa-eye';
      this.showSsnMask = true;
    } else {
      this.ssnEye = 'fa-eye-slash';
      this.showSsnMask = false;
    }
  }
}

import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, CommonHttpService } from '../../../../../../@core/services';
import { ClientPayment } from '../../../../finance.constants';

@Component({
    selector: 'client-payment-result',
    templateUrl: './client-payment-result.component.html',
    styleUrls: ['./client-payment-result.component.scss'],
    standalone: false
})
export class ClientPaymentResultComponent implements OnInit {
  searchParams: any;
  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  clientSearch: any[]=[];
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
  }

  getclientSearchData(page:any) {
    this.paginationInfo.pageNumber = page;
    const searchParams = this._datastoreService.getData(ClientPayment.ClientPaymentSearchParams);
    if (!searchParams) {
      this.searchParams = null;
      this.clientSearch = [];
      this.totalRecords = 0;
    } else if (searchParams) {
      this.searchParams = searchParams;
      this.assignDataToSearchParamsFn();
    this._commonHttpService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: this.searchParams,
      method: 'post'
    }, 'tb_client_account/listClientPaymentSearch') .subscribe((res: any) => {
        if (res) {
            this.clientSearch = res.data;
            this.totalRecords = (this.clientSearch && this.clientSearch.length > 0) ? this.clientSearch[0].totalcount : 0;
        }
    });
    }

  }
  // Associated with getclientSearchData function
  private assignDataToSearchParamsFn() {
    this.searchParams.client_id = this.searchParams.client_id ? this.searchParams.client_id : null;
    this.searchParams.client_name = this.searchParams.client_name ? this.searchParams.client_name : null;
    this.searchParams.ssn = this.searchParams.ssn ? this.searchParams.ssn.replaceAll('-', '') : null;
    this.searchParams.daterangefrom = this.searchParams.daterangefrom ? this.searchParams.daterangefrom : null;
    this.searchParams.daterangeto = this.searchParams.daterangeto ? this.searchParams.daterangeto : null;
    this.searchParams.local_dept = this.searchParams.local_dept ? this.searchParams.local_dept : null;
    this.searchParams.caseworker_name = this.searchParams.caseworker_name ? this.searchParams.caseworker_name : null;
  }

  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.getclientSearchData(page);
  }

  fundingDetails(fund:any) {
    this._datastoreService.setData(ClientPayment.SelectedClientSource, fund);
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

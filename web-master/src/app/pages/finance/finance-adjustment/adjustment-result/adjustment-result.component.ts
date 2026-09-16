import { Component } from '@angular/core';
import { FinanceAdjustment } from '../../finance.constants';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, CommonHttpService } from '../../../../@core/services';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adjustment-result',
    templateUrl: './adjustment-result.component.html',
    styleUrls: ['./adjustment-result.component.scss'],
    standalone: false
})
export class AdjustmentResultComponent {

  searchParams: any;
  providerList: any[] = [];
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

  toggleSsn = (row: any) => {
    row.isSsnHidden = (row.isSsnHidden !== null && row.isSsnHidden !== undefined ? !row.isSsnHidden : !this.isTaxidHidden);
    if (row.isSsnHidden) {
      row.ssnEye = 'fa-eye';
      row.showSsnMask = true;
    } else {
      row.ssnEye = 'fa-eye-slash';
      row.showSsnMask = false;
    }
  }

  public getFilteredProviders(pageNo: number) {
    this.paginationInfo.pageNumber = pageNo;
    const searchParams = this._datastoreService.getData(FinanceAdjustment.AncillaryAdjustmentSearchParams);
        if (!searchParams) {
          this.searchParams = null;
          this.providerList = [];
          this.totalcount = 0
        } else if (searchParams) {
          this.searchParams = searchParams;
            this.setSearchParameterFn();
            this._commonHttpService.getPagedArrayList({
            limit: this.paginationInfo.pageSize,
            page: this.paginationInfo.pageNumber,
            where: this.searchParams,
            method: 'post'
            }, 'tb_payment_header/getancillaryadjustmentsearch')
            .subscribe((res: any) => {
                if (res) {
                this.providerList = res.data;
                this.totalcount = (this.providerList && this.providerList.length > 0) ? this.providerList[0].totalcount : 0;
                }
            });
            }
  }

  private setSearchParameterFn() {
    this.searchParams.providerid = this.searchParams.providerid ? this.searchParams.providerid : null;
    this.searchParams.paymentid = this.searchParams.paymentid ? this.searchParams.paymentid : null;
    this.searchParams.clientid = this.searchParams.clientid ? this.searchParams.clientid : null;
    this.searchParams.taxid = this.searchParams.taxid ? this.searchParams.taxid : null;
  }

  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.getFilteredProviders(page);
  }

  openadjustment(payment: any) {
    this._datastoreService.setData(FinanceAdjustment.Selectedpayment, payment);
    this._router.navigate(['../payment-adjustment'], { relativeTo: this._route });
  }

}

import { Component, OnInit } from '@angular/core';
import { DataStoreService, CommonHttpService, AlertService } from '../../../../../../@core/services';
import { FinanceFundingSource } from '../../../../finance.constants';
import { PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../../../finance.url.config';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
    selector: 'funding-allocation-details',
    templateUrl: './funding-allocation-details.component.html',
    styleUrls: ['./funding-allocation-details.component.scss'],
    standalone: false
})
export class FundingAllocationDetailsComponent implements OnInit {
  searchParams: any;
  clientID: any;
  clientName: any;
  ssn: any;
  clientDob: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  pageInfo: PaginationInfo = new PaginationInfo();
  clientFundingData:any = [];
  totalcount!: number;
  dispFundingSource: any;
  fundingSrcHistory: any[]=[];
  totalPageCount!: number;
  fundingHistoryDetails: any;
  selectedFundingHistoryDetails: any;
  paymentDetails :any[]= [];
  totalpage!: number;

  constructor(
    private _datastoreService: DataStoreService,
    private _commService: CommonHttpService,
    private _alertService: AlertService,
    private _route: ActivatedRoute,
    private _router: Router
  ) { }

  ngOnInit() {
    this.paginationInfo.pageNumber = 1;
    //this._datastoreService.currentStore.subscribe(store => {
      const selectedClient = this._datastoreService.getData(FinanceFundingSource.SelectedFundingSource);
      const searchParams = this._datastoreService.getData(FinanceFundingSource.FundingSourceSearchParams);
      if (selectedClient) {
        this.searchParams = searchParams;
        this.clientID = selectedClient.client_id;
        this.clientName = selectedClient.client_name ? selectedClient.client_name : '';
        this.ssn = selectedClient.ssn ? selectedClient.ssn : '';
        this.clientDob = selectedClient.client_dob ? selectedClient.client_dob : '';
        if (this.clientID) {
          this.getClientFundingSource();
        }
      }
    //});
  }

  getClientFundingSource() {
    const where: any = {
       client_id: this.clientID
    };

    const paymentType = this.searchParams?.payment_type_cd;

    if (Array.isArray(paymentType) && paymentType.length > 0) {
     where.payment_type_cd = paymentType;
    }
    this._commService.getPagedArrayList(
      new PaginationRequest({
        where,
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'get'
      }),
      FinanceUrlConfig.EndPoint.accountsPayable.history.listFundingAllocation + '?filter'
      ).subscribe(response => {
        if (response && response.data) {
          this.clientFundingData = response.data[0];
          this.paymentDetails = response.data ? response.data : [];
          this.totalcount = (this.paymentDetails && this.paymentDetails.length > 0) ? this.paymentDetails[0].totalcount : 0;
        }
      });
  }

  pageChanged(page:any) {
    this.paginationInfo.pageNumber = page;
    this.getClientFundingSource();
  }

  viewFundingSource(fund:any) {
    (<any>$('#view-funding')).modal('hide');
    this.dispFundingSource = fund;
  }

  fundingSourceHistory(fundAllocID:any) {
    this._commService.getPagedArrayList(
      new PaginationRequest({
        where: {fund_alloc_id: fundAllocID},
        limit: this.pageInfo.pageSize,
        page: this.pageInfo.pageNumber,
        method: 'get'
      }),
      FinanceUrlConfig.EndPoint.accountsPayable.history.fundingSourceHistory + '?filter'
    ).subscribe( response => {
      this.fundingSrcHistory = response.data;
      this.totalPageCount = (this.fundingSrcHistory && this.fundingSrcHistory.length > 0) ? this.fundingSrcHistory[0].totalPageCount : 0;
      if (this.fundingSrcHistory) {
        setTimeout(() => {
          this.getFundingHistoryDetails(this.fundingSrcHistory[0], 0);
        }, 50);
      }
    });
  }

  pageNumberChanged(page:any) {
    this.pageInfo.pageNumber = page;
    this.getClientFundingSource();
  }

  getFundingHistoryDetails(fundingHistory:any, index: number) {
    this.fundingHistoryDetails = fundingHistory;
    (<any>$('.funding-details-view tr')).removeClass('selected-bg'); // NOSONAR
    (<any>$(`#funding-details-view-${index}`)).addClass('selected-bg'); // NOSONAR
  }

  closeFundingHistory() {
    (<any>$('#view-history')).modal('hide'); // NOSONAR
    (<any>$('#view-funding')).modal('show'); // NOSONAR
  }

  backToSearch() {
    this._router.navigate(['../funding-allocation-result-result'], { relativeTo: this._route });
  }


}

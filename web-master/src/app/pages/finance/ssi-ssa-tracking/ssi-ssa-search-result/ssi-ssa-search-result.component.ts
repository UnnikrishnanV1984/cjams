import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, CommonHttpService } from '../../../../@core/services';
import { FinanceStoreConstants } from '../../finance.constants';
import { FinanceUrlConfig } from '../../finance.url.config';

@Component({
    selector: 'ssi-ssa-search-result',
    templateUrl: './ssi-ssa-search-result.component.html',
    standalone: false
})
export class SsiSsaSearchResultComponent implements OnInit {

  searchParams: any;
  showSsnMask:boolean=true;
  ssiSsaTrackingList: any[] = [];
  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  isAuthorized :any; //for fortify issues 
  constructor(
    private _route: ActivatedRoute,
    private _router: Router,
    private _datastoreService: DataStoreService,
    private _commonHttpService: CommonHttpService
  ) {
    this._datastoreService.currentStore.subscribe(store => {
      const searchParams = store[FinanceStoreConstants.AccountsReceivableSearchParams];
      if (!searchParams && (JSON.stringify(this.searchParams) !== JSON.stringify(searchParams))) {
        this.searchParams = null;
        this.ssiSsaTrackingList = [];
      } else if (searchParams && (JSON.stringify(this.searchParams) !== JSON.stringify(searchParams))) {
        this.searchParams = searchParams;
        this.getSsiSsaClientDetails();
      }
    });
  }

  ngOnInit() {
    this.isAuthorized= this._datastoreService.isAuthorized();
  } 

  getSsiSsaClientDetails() {
    const model = {
      ayear: (this.searchParams.ayear) ? this.searchParams.ayear : 'Y' ,
      caseworker_name: (this.searchParams.caseworker_name) ? this.searchParams.caseworker_name : null ,
      client_id: (this.searchParams.client_id) ? this.searchParams.client_id : null ,
      client_firstname: (this.searchParams.client_firstname) ? this.searchParams.client_firstname : null ,
      client_lastname: (this.searchParams.client_lastname) ? this.searchParams.client_lastname : null ,
      client_middlename: (this.searchParams.client_middlename) ? this.searchParams.client_middlename : null ,
      dobdaterangefrom: (this.searchParams.dobdaterangefrom) ?  this.searchParams.dobdaterangefrom  : null ,
      dobdaterangeto: (this.searchParams.dobdaterangeto) ? this.searchParams.dobdaterangeto : null ,
      ssn: (this.searchParams.ssn) ? this.searchParams.ssn : null ,
    };

    this._commonHttpService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: model,
      // where: {
      //       client_id: (this.client_id) ? this.client_id : null,
      //       client_name:  (this.client_name) ? this.client_name : null,
      //       ssn :  (this.ssn) ? this.ssn : null,
      //       dobdaterangefrom : (this.dobdaterangefrom) ? this.dobdaterangefrom : null,
      //       dobdaterangeto : (this.dobdaterangeto) ? this.dobdaterangefrom : null,
      //       caseworker_name : (this.caseworker_name) ? this.caseworker_name : null
      //     },
      method: 'post'
    }, FinanceUrlConfig.EndPoint.ssiSsaTracking.listSsiSsaClientDetails).subscribe((res: any) => {
        if (res) {
            this.ssiSsaTrackingList = res.data;
        }
    });
  }

  ssiOverview(clientid: any) {
    this._router.navigate(['../' + clientid + '/ssi-ssa-overview'], { relativeTo: this._route });
  }
}

import { Component, OnInit } from '@angular/core';
import { CommonHttpService, AuthService } from '../../../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { FinanceUrlConfig } from '../../finance.url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'conserved-ac-balance-alert',
    templateUrl: './conserved-ac-balance-alert.component.html',
    standalone: false
})
export class ConservedAcBalanceAlertComponent implements OnInit {

  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount: any;
  userCounty!: any[];
  conservedAlert!: any[];

  constructor(
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService
  ) { }

  ngOnInit() {
    this.paginationInfo.pageNumber = 1;
    this.getCounty();
  }
  getCounty() {
    this._commonHttpService.getArrayList({ method: 'get', where : {}}, FinanceUrlConfig.EndPoint.general.userCounty + '?filter').subscribe((result) => {
      if (result && result.length > 0) {
          this.userCounty = result;
          this.loadList(result[0].statecountycode);
      }
    });
  }
  loadList(county: string) {
    this._commonHttpService
    .getPagedArrayList(
        new PaginationRequest({
            page: this.paginationInfo.pageNumber,
            limit: this.paginationInfo.pageSize,
            where: {
                'county_cd': county
            },
            method: 'get'
        }),
        'tb_provider/getConservedBalance?filter'
    )
    .subscribe((res: any) => {
        if (res) {
            this.conservedAlert = res;
            this.totalcount = (this.conservedAlert && this.conservedAlert.length > 0) ? this.conservedAlert[0].totalcount : 0;
        }
    });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo;
    this.loadList(this.userCounty[0].statecountycode);
  }
}

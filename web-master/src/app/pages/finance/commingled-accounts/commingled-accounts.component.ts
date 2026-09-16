import { Component, OnInit } from '@angular/core';
import { CommonHttpService, DataStoreService } from '../../../@core/services';
import { FinanceUrlConfig } from '../finance.url.config';

@Component({
    selector: 'commingled-accounts',
    templateUrl: './commingled-accounts.component.html',
    styleUrls: ['./commingled-accounts.component.scss'],
    standalone: false
})
export class CommingledAccountsComponent implements OnInit {
  selectedDept: any;
  localDept: any[]=[];
  selectedAccount: any;
  deptSelected: any;
  disableCounty:boolean=false;
  constructor(
    private _commonService: CommonHttpService,
    private _datastoreService: DataStoreService
  ) { }

  ngOnInit() {
    this.getDropdown();
  }

  getDropdown() {
    this._commonService.getArrayList({ method: 'get', where : {}}, FinanceUrlConfig.EndPoint.general.userCounty + '?filter').subscribe((result) => {
      if (result !== null) {
          this.localDept = result;
          this.selectedDept = result[0].statecountycode;
          this.disableCounty = true;
          this.getchilddetailslist();
      }
    });
  }

  getchilddetailslist() {
    if (this.selectedDept) {
      this._datastoreService.setData('selectedFinanceDept', this.selectedDept);
    }
  }

}

import { Component, OnInit } from '@angular/core';
import { DataStoreService, AuthService } from '../../../../../@core/services';
import { FinanceFundingSource } from '../../../finance.constants';

@Component({
    selector: 'funding-source-allocation',
    templateUrl: './funding-source-allocation.component.html',
    standalone: false
})
export class FundingSourceAllocationComponent implements OnInit {
  moduleview: any;

    constructor( private _dataStoreService: DataStoreService, private _authService: AuthService) {
    }

   ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('finance', 'finance.finance.historyfundingsourceallocation');
     this._dataStoreService.setData(FinanceFundingSource.FundingSourceSearchParams, null);
   }

}

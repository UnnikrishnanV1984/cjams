import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FinanceArProviderDetailsService } from '../finance-ar-provider-details.service';
import { ArProviderHistoryService } from './ar-provider-history.service';
import { DataStoreService } from '../../../../../@core/services';
import { FinanceStoreConstants } from '../../../finance.constants';

@Component({
    selector: 'ar-provider-history',
    templateUrl: './ar-provider-history.component.html',
    styleUrls: ['./ar-provider-history.component.scss'],
    standalone: false
})
export class ArProviderHistoryComponent implements OnInit {
  tabDetails :any[]= [];

  constructor(
    private _router: Router,
    private _route: ActivatedRoute,
    private _financeDetailsService: FinanceArProviderDetailsService,
    private _history: ArProviderHistoryService,
    private _datastoreService: DataStoreService
  ) {
    _financeDetailsService.providerid = _route?.parent?.parent?.snapshot?.params['providerid'];
    _history.index = 0;
    _history.historyIndex = 0;
    _history.receiptIndex = 0;
  }

  ngOnInit() {
    const selectedProvider = this._datastoreService.getData(FinanceStoreConstants.SelectedProvider);
    if (!selectedProvider) {
      this._financeDetailsService.loadProviderDetails();
    } else {
      this._financeDetailsService.provider = selectedProvider;
    }
    this.initTabs();
  }

  initTabs() {
    this.tabDetails = [
      {
        id: 'overpayments',
        title: 'Overpayments History',
        name: 'Overpayments History',
        route: 'overpayments'
      },
      // {
      //   id: 'receipt',
      //   title: 'Receipts Entry',
      //   name: 'Receipts Entry',
      //   route: 'receipt'
      // }
    ];
  }

}

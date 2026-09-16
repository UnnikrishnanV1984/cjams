import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FinanceArProviderDetailsService } from './finance-ar-provider-details.service';
import { DataStoreService } from '../../../../@core/services';
import { FinanceStoreConstants } from '../../finance.constants';

@Component({
    selector: 'finance-ar-provider-details',
    templateUrl: './finance-ar-provider-details.component.html',
    styleUrls: ['./finance-ar-provider-details.component.scss'],
    standalone: false
})
export class FinanceArProviderDetailsComponent implements OnInit {
    tabDetails: any[] = [];

    constructor(
        private _router: Router,
        private _route: ActivatedRoute,
        private _datastoreService: DataStoreService,
        public _financeDetailsService?: FinanceArProviderDetailsService
       
    ) {if(_financeDetailsService)
        _financeDetailsService.providerid = _route.snapshot.params['providerid'];
    }

    ngOnInit() {
        const selectedProvider = this._datastoreService.getData(FinanceStoreConstants.SelectedProvider);
        if (!selectedProvider && this._financeDetailsService) {
            this._financeDetailsService.loadProviderDetails();
        } else {
            if(this._financeDetailsService){
            this._financeDetailsService.provider = selectedProvider;
            }
        }
        this.initTabs();
    }

    backToSearch() {
        this._datastoreService.setData(FinanceStoreConstants.AccountsReceivableSearchParams, null);
        this._router.navigate(['/pages/finance/finance-accountsReceivable/search-result']);
    }

    initTabs() {
        this.tabDetails = [
            {
                id: 'details',
                title: 'Summary',
                name: 'Summary',
                route: 'details'
            },
            {
                id: 'overpayments',
                title: 'Provider Overpayments',
                name: 'Provider Overpayments',
                route: 'overpayments'
            },
            {
                id: 'history',
                title: 'Overpayments Collection History',
                name: 'Overpayments Collection History',
                route: 'history'
            },
            {
                id: 'payment-plan',
                title: 'Payment Plan',
                name: 'Payment Plan',
                route: 'payment-plan'
            },
            {
                id: 'documents',
                title: 'Documents',
                name: 'Documents',
                route: 'documents'
            }
        ];
    }

}

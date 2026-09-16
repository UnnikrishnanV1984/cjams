import { Component, Input } from '@angular/core';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'accountsReceivable-search-view',
    templateUrl: './finance-accountsReceivable-search-view.component.html',
    styleUrls: ['./finance-accountsReceivable-search-view.component.scss'],
    standalone: false
})
export class FinanceAccountsReceivableSearchViewComponent {
    @Input() selectedAccountsReceivable: any;
}

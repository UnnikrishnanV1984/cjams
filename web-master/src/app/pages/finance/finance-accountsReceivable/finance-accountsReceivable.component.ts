import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { FinanceAccountsReceivableSearchEntry } from '../_entities/finance-entity.module';

@Component({
    selector: 'app-finance-accountsReceivable',
    templateUrl: './finance-accountsReceivable.component.html',
    styleUrls: ['./finance-accountsReceivable.component.scss'],
    standalone: false
})
export class FinanceAccountsReceivableComponent implements OnInit {
    searchData$: Subject<Observable<FinanceAccountsReceivableSearchEntry[]>>;
    totalSearchRecord$: Subject<Observable<number>>;
    pageNumberResult$: Subject<number>;
    searchResultData$!: Observable<FinanceAccountsReceivableSearchEntry[]>;
    totalResulRecords$!: Observable<number>;
    showTable = false;

    constructor() {
        this.searchData$ = new Subject();
        this.totalSearchRecord$ = new Subject();
        this.pageNumberResult$ = new Subject();
    }

    ngOnInit() {
        this.searchData$.subscribe(data => {
            this.searchResultData$ = data;
            this.showTable = true;
        });
        this.totalSearchRecord$.subscribe(data => {
            this.totalResulRecords$ = data;
        });

    }
}

import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { FinanceAccountsPayableSearchEntry } from '../_entities/finance-entity.module';
import { AuthService } from '../../../@core/services/auth.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-finance-accountsPayable',
    templateUrl: './finance-accountsPayable.component.html',
    styleUrls: ['./finance-accountsPayable.component.scss'],
    standalone: false
})
export class FinanceAccountsPayableComponent implements OnInit {
    searchData$: Subject<Observable<FinanceAccountsPayableSearchEntry[]>>;
    totalSearchRecord$: Subject<Observable<number>>;
    pageNumberResult$!: Subject<number>;
    searchResultData$!: Observable<FinanceAccountsPayableSearchEntry[]>;
    totalResulRecords$!: Observable<number>;
    showTable = false;
    moduleview: any;

    constructor(private _authService: AuthService) {
        this.searchData$ = new Subject();
        this.totalSearchRecord$ = new Subject();
        this.pageNumberResult$ = new Subject();
    }

    ngOnInit() {
        this.moduleview = this._authService.isModuleAccessable('finance', 'finance.finance.accountspayable');
        this.searchData$.subscribe(data => {
            this.searchResultData$ = data;
            this.showTable = true;
        });
        this.totalSearchRecord$.subscribe(data => {
            this.totalResulRecords$ = data;
        });

    }
}

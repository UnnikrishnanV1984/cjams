import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { FinanceAdoptionSearchEntry} from '../_entities/finance-entity.module';

@Component({
    selector: 'app-finance-adoption',
    templateUrl: './finance-adoption.component.html',
    styleUrls: ['./finance-adoption.component.scss'],
    standalone: false
})
export class FinanceAdoptionComponent implements OnInit {
    searchData$: Subject<Observable<FinanceAdoptionSearchEntry[]>>;
    totalSearchRecord$: Subject<Observable<number>>;
    pageNumberResult$: Subject<number>;
    searchResultData$!: Observable<FinanceAdoptionSearchEntry[]>;
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

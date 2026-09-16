import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { FinancePlacementSearchEntry} from '../_entities/finance-entity.module';

@Component({
    selector: 'app-finance-placement',
    templateUrl: './finance-placement.component.html',
    styleUrls: ['./finance-placement.component.scss'],
    standalone: false
})
export class FinancePlacementComponent implements OnInit {
    searchData$: Subject<Observable<FinancePlacementSearchEntry[]>>;
    totalSearchRecord$: Subject<Observable<number>>;
    pageNumberResult$: Subject<number>;
    searchResultData$!: Observable<FinancePlacementSearchEntry[]>;
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

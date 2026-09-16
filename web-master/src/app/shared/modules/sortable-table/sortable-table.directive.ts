import { Directive, OnInit, EventEmitter, Output, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';

import { SortService } from './sort.service';

@Directive({
    // tslint:disable-next-line:directive-selector
    selector: '[sortable-table]',
    standalone: false
})
export class SortableTableDirective implements OnInit, OnDestroy {
    constructor(private sortService: SortService) {}

    @Output() sorted = new EventEmitter();

    private columnSortedSubscription: Subscription = new Subscription();

    ngOnInit() {
        // subscribe to sort changes so we emit and event for this data table
        this.columnSortedSubscription = this.sortService.columnSorted$.subscribe((event) => {
            this.sorted.emit(event);
        });
    }

    ngOnDestroy() {
        if (this.columnSortedSubscription) {
            this.columnSortedSubscription.unsubscribe();
        }
    }
}

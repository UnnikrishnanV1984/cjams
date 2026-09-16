import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MatTooltipModule } from '@angular/material/tooltip';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { AlertService } from '../../../../@core/services';
import { ReleaseNoteService } from '../../release-note.service';
import { TicketDetailComponent, KW_TICKET_MODAL_IDS } from '../ticket-list/ticket-detail/ticket-detail.component';

@Component({
    selector: 'keyword-search-list',
    templateUrl: './keyword-search-list.component.html',
    standalone: true,
    imports: [
        CommonModule,
        FormsModule,
        MatTooltipModule,
        PaginationModule,
        SortTableModule,
        TicketDetailComponent
    ]
})
export class KeywordSearchListComponent implements OnChanges, OnDestroy {
    @Input() searchTerm: string = '';
    @Input() itemtype: string = 'both';
    @Input() results: any[] = [];
    @Input() totalRecords: number = 0;
    @Input() totalStoryCount: number = 0;
    @Input() totalDefectCount: number = 0;
    @Input() totalDistinctReleaseCount: number = 0;
    @Input() paginationInfo: PaginationInfo = new PaginationInfo();
    @Input() hasSearched: boolean = false;

    @Output() cleared = new EventEmitter<void>();
    @Output() sorted = new EventEmitter<ColumnSortedEvent>();
    @Output() pageChanged = new EventEmitter<number>();

    scopeLabel: string = 'Stories and Defects';

    // State passed to ticket-detail
    selectedRelease: any = null;
    ticketDetails: any = null;
    ticketMode: 'view' | 'edit' = 'view';

    readonly modalIds = KW_TICKET_MODAL_IDS;
    private _destroy$ = new Subject<void>();

    constructor(
        private _service: ReleaseNoteService,
        private _alert: AlertService
    ) {}

    ngOnChanges(changes: SimpleChanges) {
        if (changes['itemtype']) {
            if (this.itemtype === 'Story') this.scopeLabel = 'Stories';
            else if (this.itemtype === 'Defect') this.scopeLabel = 'Defects';
            else this.scopeLabel = 'Stories and Defects';
        }
    }

    onSorted(event: ColumnSortedEvent) {
        this.sorted.emit(event);
    }

    onPageChanged(pageInfo: any) {
        this.pageChanged.emit(pageInfo.page);
    }

    getBadgeClass(itemtype: string): string {
        if (itemtype === 'Story')  return 'type-badge type-badge--story';
        if (itemtype === 'Defect') return 'type-badge type-badge--defect';
        return 'type-badge type-badge--unknown';
    }

    getBadgeLabel(itemtype: string): string {
        if (itemtype === 'Story')  return 'S';
        if (itemtype === 'Defect') return 'D';
        return '?';
    }

    openDetails(row: any) {
        this.selectedRelease = row;
        this.ticketDetails = null;
        this.ticketMode = 'view';
        (<any>$('#' + this.modalIds.editView)).modal('show');
    }

    ngOnDestroy() {
        this._destroy$.next();
        this._destroy$.complete();
    }

    openSupportLog(row: any) {
        this._service.getSupportLogWithJira(row).pipe(takeUntil(this._destroy$)).subscribe({
            next: (result: any) => {
                if (result) {
                    this.ticketDetails = result.ticketDetails;
                    this.selectedRelease = row;
                    (<any>$('#' + this.modalIds.supportLog)).modal('show');
                } else {
                    this._alert.error('Could not load support ticket details. Please try again.');
                }
            },
            error: () => {
                this._alert.error('An error occurred while loading support ticket details.');
            }
        });
    }
}

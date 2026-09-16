import { Component, Input, Output, EventEmitter, OnChanges, OnDestroy, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { DomSanitizer, SafeUrl } from '@angular/platform-browser';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { AlertService } from '../../../../@core/services';
import { ReleaseNoteService, ReleaseVersion, TicketFilter } from '../../release-note.service';
import { TicketDetailComponent, TICKET_MODAL_IDS } from './ticket-detail/ticket-detail.component';

@Component({
    selector: 'ticket-list',
    templateUrl: './ticket-list.component.html',
    standalone: true,
    imports: [
        CommonModule,
        FormsModule,
        RouterModule,
        MatFormFieldModule,
        MatInputModule,
        PaginationModule,
        SortTableModule,
        TicketDetailComponent
    ]
})
export class TicketListComponent implements OnChanges, OnDestroy {
    @Input() version: ReleaseVersion | null = null;
    @Input() releaseApprover: boolean = false;
    @Input() releaseAdmin: boolean = false;

    @Output() back = new EventEmitter<void>();

    tickets: any[] = [];
    totalCount: number = 0;
    paginationInfo: PaginationInfo = new PaginationInfo();

    isValue: number = 0;
    get tabType(): string { return this.isValue === 0 ? 'Defect' : 'Story'; }

    // Field filters — typed to match their actual usage
    jiraid: string | null = null;
    supportticketno: string | null = null;
    raisedbyuser: string | null = null;
    title: string | null = null;
    description: string | null = null;

    // In-version keyword search
    popupKeywordSearchTerm: string = '';

    // State passed down to ticket-detail child
    selectedRelease: any = null;
    ticketDetails: any = null;
    ticketMode: 'view' | 'edit' = 'view';

    readonly modalIds = TICKET_MODAL_IDS;

    private _destroy$ = new Subject<void>();

    constructor(
        private _service: ReleaseNoteService,
        private _alert: AlertService,
        private _sanitizer: DomSanitizer
    ) {}

    ngOnDestroy() {
        this._destroy$.next();
        this._destroy$.complete();
    }

    getSafeDocumentLink(url: string): SafeUrl | null {
        if (!url) return null;
        const lower = url.toLowerCase().trim();
        if (!lower.startsWith('http://') && !lower.startsWith('https://')) return null;
        return this._sanitizer.bypassSecurityTrustUrl(url);
    }

    ngOnChanges(changes: SimpleChanges) {
        if (changes['version'] && this.version) {
            this.isValue = 0;
            this._clearFilters();
            this.loadTickets();
        }
    }

    private _clearFilters() {
        this.jiraid = null;
        this.supportticketno = null;
        this.raisedbyuser = null;
        this.title = null;
        this.description = null;
        this.popupKeywordSearchTerm = '';
        this.paginationInfo.pageNumber = 1;
    }

    loadTickets() {
        if (!this.version) return;
        const filter: TicketFilter = {
            releaseversionno: this.version.releaseversionno,
            releasedate: this.version.releasedate
                ? this.version.releasedate.substring(0, 10)
                : null,
            jiraid: this.jiraid,
            supportticketno: this.supportticketno,
            title: this.title,
            description: this.description,
            raisedbyuser: this.raisedbyuser,
            tab: this.tabType,
            pagenumber: this.paginationInfo.pageNumber,
            pagesize: this.paginationInfo.pageSize,
            sortdirection: this.paginationInfo.sortBy,
            sortcolumn: this.paginationInfo.sortColumn
        };
        this._service.getTickets(filter).pipe(takeUntil(this._destroy$)).subscribe((res: any) => {
            this.tickets = res.data ?? [];
            this.totalCount = this.tickets.length > 0 && this.tickets[0].totalcount
                ? this.tickets[0].totalcount : 0;
        });
    }

    switchTab(value: number) {
        this.isValue = value;
        this.paginationInfo.pageNumber = 1;
        this.loadTickets();
    }

    search() {
        this.paginationInfo.pageNumber = 1;
        this.loadTickets();
    }

    reset() {
        this._clearFilters();
        this.loadTickets();
    }

    onKeywordSearch() {
        if (!this.popupKeywordSearchTerm?.trim()) return;
        this._service.fuzzySearch(this.popupKeywordSearchTerm.trim(), true, {
            pReleaseVersion: this.version?.releaseversionno ?? '',
            page:  String(this.paginationInfo.pageNumber),
            limit: String(this.paginationInfo.pageSize),
            ...(this.paginationInfo.sortColumn ? { sortcolumn: this.paginationInfo.sortColumn } : {}),
            ...(this.paginationInfo.sortBy     ? { sortorder:  this.paginationInfo.sortBy }     : {})
        }).pipe(takeUntil(this._destroy$)).subscribe((results: any) => {
            this.tickets = results ?? [];
            this.totalCount = this.tickets.length > 0 && this.tickets[0].totalcount
                ? this.tickets[0].totalcount : 0;
        });
    }

    onSort(event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = event.sortDirection;
        this.paginationInfo.sortColumn = event.sortColumn;
        this.paginationInfo.pageNumber = 1;
        this.loadTickets();
    }

    pageChanged(page: number) {
        this.paginationInfo.pageNumber = page;
        this.loadTickets();
    }

    // ── Actions that open modals in the ticket-detail child ───────────────────

    viewRelease(release: any) {
        this.selectedRelease = release;
        this.ticketDetails = null;
        this.ticketMode = 'view';
        (<any>$('#' + this.modalIds.editView)).modal('show');
    }

    editRelease(release: any) {
        this.selectedRelease = release;
        this.ticketDetails = null;
        this.ticketMode = 'edit';
        (<any>$('#' + this.modalIds.editView)).modal('show');
    }

    getSupportLog(release: any) {
        this._service.getSupportLogWithJira(release).subscribe({
            next: (result: any) => {
                if (result) {
                    this.ticketDetails = result.ticketDetails;
                    this.selectedRelease = release;
                    (<any>$('#' + this.modalIds.supportLog)).modal('show');
                } else {
                    (<any>$('#' + this.modalIds.jiraError)).modal('show');
                }
            },
            error: () => {
                this._alert.error('An error occurred while loading support ticket details.');
            }
        });
    }
}

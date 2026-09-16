import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';
import { take } from 'rxjs/operators';
import { PaginationInfo } from '../../@core/entities/common.entities';
import { ReleaseNoteService, KeywordSearchState } from './release-note.service';
import { ReleaseNoteAccess } from './release-note-resolver.service';
import { ColumnSortedEvent } from '../../shared/modules/sortable-table/sort.service';
import { AlertService } from '../../@core/services';
import { ReleaseNoteSearchComponent, VersionFilter } from './components/release-note-search/release-note-search.component';
import { ReleaseVersionListComponent } from './components/release-version-list/release-version-list.component';
import { TicketListComponent } from './components/ticket-list/ticket-list.component';
import { KeywordSearchListComponent } from './components/keyword-search-list/keyword-search-list.component';

const ALLOWED_ITEMTYPES = ['Story', 'Defect'] as const;

@Component({
    selector: 'release-note',
    templateUrl: './release-note.component.html',
    standalone: true,
    imports: [
        CommonModule,
        ReleaseNoteSearchComponent,
        ReleaseVersionListComponent,
        TicketListComponent,
        KeywordSearchListComponent
    ]
})
export class ReleaseNoteComponent implements OnInit, OnDestroy {
    releaseApprover: boolean = false;
    releaseAdmin: boolean = false;

    selectedVersion: any = null;

    kwState!: KeywordSearchState;
    private _kwSub!: Subscription;
    private _fromScreen: string | null = null;

    versionFilter: VersionFilter = { releaseversionno: null, startdate: null, enddate: null };

    constructor(
        private _route: ActivatedRoute,
        private _service: ReleaseNoteService,
        private _alert: AlertService
    ) {}

    ngOnInit() {
        this._route.queryParams.pipe(take(1)).subscribe(params => {
            this._fromScreen = params['fromScreen'] ?? null;
        });

        // Access flags pre-fetched by the route resolver — no extra HTTP call needed
        const access: ReleaseNoteAccess = this._route.snapshot.data['access'];
        if (access) {
            this.releaseApprover = access.approver;
            this.releaseAdmin    = access.admin;
        }

        this._kwSub = this._service.keywordState$.subscribe(s => this.kwState = s);
    }

    ngOnDestroy() {
        this._kwSub.unsubscribe();
    }

    onOpenVersion(version: any) {
        this.selectedVersion = version;
    }

    onBack() {
        this.selectedVersion = null;
    }

    onFirstVersionLoaded(firstVersion: any) {
        if (this._fromScreen === 'login' && firstVersion) {
            this._fromScreen = null;
            this.onOpenVersion(firstVersion);
        }
    }

    // ── Version filter handlers ───────────────────────────────────────────────

    onVersionSearch(filter: VersionFilter) {
        this.versionFilter = filter;
    }

    onVersionCleared() {
        this.versionFilter = { releaseversionno: null, startdate: null, enddate: null };
    }

    // ── Keyword search handlers ───────────────────────────────────────────────

    onKeywordSearch(event: { term: string; itemtype: string }) {
        this._runKeywordSearch({
            ...this.kwState,
            mode: true,
            searchTerm: event.term,
            itemtype: event.itemtype,
            paginationInfo: { ...new PaginationInfo(), pageNumber: 1 }
        });
    }

    onKeywordCleared() {
        this._service.clearKeywordState();
    }

    onKeywordSorted(event: ColumnSortedEvent) {
        const pg = { ...this.kwState.paginationInfo };
        pg.sortBy = event.sortDirection;
        pg.sortColumn = event.sortColumn;
        pg.pageNumber = 1;
        this._runKeywordSearch({ ...this.kwState, paginationInfo: pg });
    }

    onKeywordPageChanged(page: number) {
        const pg = { ...this.kwState.paginationInfo, pageNumber: page };
        this._runKeywordSearch({ ...this.kwState, paginationInfo: pg });
    }

    private _runKeywordSearch(state: KeywordSearchState) {
        const itemtypeIsValid = ALLOWED_ITEMTYPES.includes(state.itemtype as any);
        const extra: Record<string, string> = {
            page: String(state.paginationInfo.pageNumber),
            limit: String(state.paginationInfo.pageSize),
            ...(state.paginationInfo.sortColumn ? { sortcolumn: state.paginationInfo.sortColumn } : {}),
            ...(state.paginationInfo.sortBy ? { sortorder: state.paginationInfo.sortBy } : {}),
            ...(itemtypeIsValid ? { itemtype: state.itemtype } : {})
        };
        this._service.fuzzySearch(state.searchTerm, true, extra).subscribe({
            next: (res: any) => {
                this._service.setKeywordState({
                    ...state,
                    results: res?.rows ?? [],
                    totalRecords: res?.totalcount ?? 0,
                    totalStoryCount: res?.totalstorycount ?? 0,
                    totalDefectCount: res?.totaldefectcount ?? 0,
                    totalDistinctReleaseCount: res?.totaldistinctreleasecount ?? 0,
                    hasSearched: true
                });
            },
            error: () => {
                this._service.setKeywordState({ ...state, hasSearched: true });
                this._alert.error('An error occurred while searching. Please try again.');
            }
        });
    }
}

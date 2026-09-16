import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, forkJoin, of } from 'rxjs';
import { map } from 'rxjs/operators';
import { CommonHttpService } from '../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../@core/common/URLs/common-url.config';

export interface ReleaseVersion {
    releaseversionno: string;
    releasedate: string;
    publish?: boolean;
    totalcount?: number;
}

export interface TicketFilter {
    releaseversionno?: string | null;
    releasedate?: string | null;
    jiraid?: string | null;
    supportticketno?: string | null;
    title?: string | null;
    description?: string | null;
    raisedbyuser?: string | null;
    tab?: string;
    pagenumber?: number;
    pagesize?: number;
    sortdirection?: string | null;
    sortcolumn?: string | null;
}

export interface KeywordSearchState {
    mode: boolean;
    searchTerm: string;
    itemtype: string;
    results: any[];
    totalRecords: number;
    totalStoryCount: number;
    totalDefectCount: number;
    totalDistinctReleaseCount: number;
    paginationInfo: PaginationInfo;
    hasSearched: boolean;
}

const ISSUE_TYPES: { key: string; value: string }[] = [
    { key: '531', value: 'Enhancement' },
    { key: '528', value: 'Bug/Issue/Defect' },
    { key: '532', value: 'Question/Policy' },
    { key: '533', value: 'Gap/Missing from Legacy System' },
    { key: '524', value: 'Application Support/Training' }
];

@Injectable({ providedIn: 'root' })
export class ReleaseNoteService {
    private _keywordState = new BehaviorSubject<KeywordSearchState>({
        mode: false,
        searchTerm: '',
        itemtype: 'both',
        results: [],
        totalRecords: 0,
        totalStoryCount: 0,
        totalDefectCount: 0,
        totalDistinctReleaseCount: 0,
        paginationInfo: new PaginationInfo(),
        hasSearched: false
    });

    readonly keywordState$ = this._keywordState.asObservable();

    constructor(private _http: CommonHttpService) {}

    // ── Access ────────────────────────────────────────────────────────────────

    checkAccess(): Observable<any> {
        return this._http.getAll('releasenotes/releasenotesaccesscheck');
    }

    // ── Versions ──────────────────────────────────────────────────────────────

    getReleaseVersions(filter: any, page: number, limit: number): Observable<any> {
        return this._http.getPagedArrayList(
            new PaginationRequest({ where: filter, page, limit, method: 'post' }),
            'releasenotes/getreleaseversions'
        );
    }

    publishReleaseNotes(info: { releaseversionno: string; releasedate: string }): Observable<any> {
        return this._http.getPagedArrayList(
            new PaginationRequest({ where: info, method: 'post' }),
            'releasenotes/publishupdate'
        );
    }

    deleteReleaseNotes(info: { releaseversionno: string; releasedate: string }): Observable<any> {
        return this._http.getPagedArrayList(
            new PaginationRequest({ where: info, method: 'post' }),
            'releasenotes/deletereleasenotes'
        );
    }

    saveReleaseNotes(itemlist: any[]): Observable<any> {
        return this._http.create({ itemlist }, 'releasenotes/savereleasenotes');
    }

    downloadReport(releaseversionno: string, releasedate: string, doctype: string): Observable<any> {
        const filter = { releaseversionno, releasedate, tab: null, doctype };
        return this._http.download(
            CommonUrlConfig.EndPoint.REPORTS.SUPERVISOR.GENERATE + 'releasenotes',
            JSON.stringify(filter)
        );
    }

    // ── Tickets ───────────────────────────────────────────────────────────────

    getTickets(filter: TicketFilter): Observable<any> {
        return this._http.getPagedArrayList(
            new PaginationRequest({ where: filter, method: 'post' }),
            'releasenotes/getreleasedata'
        );
    }

    editTicket(where: any): Observable<any> {
        return this._http.getPagedArrayList(
            new PaginationRequest({ where, method: 'post' }),
            'releasenotes/ticketdetailsedit'
        );
    }

    getSupportLog(filter: any): Observable<any> {
        return this._http.getPagedArrayList(
            new PaginationRequest({ where: filter, method: 'post' }),
            'supportlog/getsupportlog'
        );
    }

    getJiraStatus(itemid: string): Observable<any> {
        return this._http.getAll('supportlog/getJiraStatus?jirarequestno=' + encodeURIComponent(itemid));
    }

    getSupportLogWithJira(release: any): Observable<{ ticketDetails: any } | null> {
        if (!release.itemid) {
            return of(null);
        }
        const filter = { input: { supportno: release.supportno, searchstring: null } };
        return forkJoin([
            this.getSupportLog(filter),
            this.getJiraStatus(release.itemid)
        ]).pipe(map(([response, res2]: any[]) => {
            const res = response.data ?? null;
            if (!res || res.length === 0) return null;
            const ticket = { ...res[0] };
            ticket.jiraStatus = res2?.status ?? null;
            if (res2?.comments?.length > 0) {
                ticket.jiraComments = res2.comments
                    .filter((c: any) => !c.body.includes('image-'))
                    .map((c: any) =>
                        `Author: ${c.author?.displayName ?? ''}\n` +
                        `Date & Time: ${c.updated ? c.updated.substring(0, 16) : ''}\n` +
                        `Comment: ${c.body ?? ''}\n`
                    ).join('');
            }
            if (ticket.issuetype) {
                ticket.issuetype = ISSUE_TYPES.find(t => t.key === ticket.issuetype)?.value ?? '';
            }
            return { ticketDetails: ticket };
        }));
    }

    // ── Keyword search state (persisted in service across route visits) ───────

    fuzzySearch(searchTerm: string, fulldata: boolean, extra: Record<string, string>): Observable<any> {
        const params = new URLSearchParams({ searchTerm, fulldata: String(fulldata), ...extra });
        return this._http.getAll('releasenotes/search/fuzzy?' + params.toString());
    }

    getKeywordState(): KeywordSearchState {
        return this._keywordState.getValue();
    }

    setKeywordState(state: KeywordSearchState) {
        this._keywordState.next(state);
    }

    clearKeywordState() {
        this._keywordState.next({
            mode: false,
            searchTerm: '',
            itemtype: 'both',
            results: [],
            totalRecords: 0,
            totalStoryCount: 0,
            totalDefectCount: 0,
            totalDistinctReleaseCount: 0,
            paginationInfo: new PaginationInfo(),
            hasSearched: false
        });
    }
}

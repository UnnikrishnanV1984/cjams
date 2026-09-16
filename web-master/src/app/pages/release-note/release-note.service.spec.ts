import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { of } from 'rxjs';
import { ReleaseNoteService, KeywordSearchState } from '././release-note.service
import { CommonHttpService } from '../../@core/services';
import { PaginationInfo } from '../../@core/entities/common.entities';

describe('ReleaseNoteService', () => {
    let service: ReleaseNoteService;
    let mockHttp: jasmine.SpyObj<CommonHttpService>;

    beforeEach(() => {
        mockHttp = jasmine.createSpyObj('CommonHttpService', [
            'getAll', 'getPagedArrayList', 'create', 'download'
        ]);

        TestBed.configureTestingModule({
            providers: [
                ReleaseNoteService,
                { provide: CommonHttpService, useValue: mockHttp },
                provideHttpClient(),
                provideHttpClientTesting()
            ]
        });

        service = TestBed.inject(ReleaseNoteService);
    });

    // ── checkAccess ──────────────────────────────────────────────────────────

    it('checkAccess calls the correct endpoint', () => {
        mockHttp.getAll.and.returnValue(of([{ approver: true, admin: false }]));
        service.checkAccess().subscribe(res => {
            expect(res[0].approver).toBeTrue();
        });
        expect(mockHttp.getAll).toHaveBeenCalledWith('releasenotes/releasenotesaccesscheck');
    });

    // ── getReleaseVersions ───────────────────────────────────────────────────

    it('getReleaseVersions calls getPagedArrayList with correct URL', () => {
        const mockData = [{ releaseversionno: '1.0', releasedate: '2024-01-01' }];
        mockHttp.getPagedArrayList.and.returnValue(of(mockData));
        service.getReleaseVersions({ releaseversion: '1.0' }, 1, 10).subscribe(res => {
            expect(res).toEqual(mockData);
        });
        expect(mockHttp.getPagedArrayList).toHaveBeenCalledWith(
            jasmine.any(Object),
            'releasenotes/getreleaseversions'
        );
    });

    // ── publishReleaseNotes ──────────────────────────────────────────────────

    it('publishReleaseNotes calls publishupdate endpoint', () => {
        mockHttp.getPagedArrayList.and.returnValue(of(true));
        service.publishReleaseNotes({ releaseversionno: '1.0', releasedate: '2024-01-01' }).subscribe(res => {
            expect(res).toBeTrue();
        });
        expect(mockHttp.getPagedArrayList).toHaveBeenCalledWith(
            jasmine.any(Object),
            'releasenotes/publishupdate'
        );
    });

    // ── deleteReleaseNotes ───────────────────────────────────────────────────

    it('deleteReleaseNotes calls deletereleasenotes endpoint', () => {
        mockHttp.getPagedArrayList.and.returnValue(of(true));
        service.deleteReleaseNotes({ releaseversionno: '1.0', releasedate: '2024-01-01' }).subscribe();
        expect(mockHttp.getPagedArrayList).toHaveBeenCalledWith(
            jasmine.any(Object),
            'releasenotes/deletereleasenotes'
        );
    });

    // ── saveReleaseNotes ─────────────────────────────────────────────────────

    it('saveReleaseNotes calls create with itemlist', () => {
        const items = [{ Item_Type: 'Story', Title: 'A' }];
        mockHttp.create.and.returnValue(of('Success'));
        service.saveReleaseNotes(items).subscribe(res => {
            expect(res).toBe('Success');
        });
        expect(mockHttp.create).toHaveBeenCalledWith({ itemlist: items }, 'releasenotes/savereleasenotes');
    });

    // ── downloadReport ───────────────────────────────────────────────────────

    it('downloadReport calls download with serialised filter', () => {
        const blob = new Blob(['data']);
        mockHttp.download.and.returnValue(of(blob));
        service.downloadReport('1.0', '2024-01-01', 'pdf').subscribe(res => {
            expect(res).toBe(blob);
        });
        expect(mockHttp.download).toHaveBeenCalledWith(
            jasmine.stringContaining('releasenotes'),
            jasmine.stringContaining('"doctype":"pdf"')
        );
    });

    // ── getTickets ───────────────────────────────────────────────────────────

    it('getTickets calls getreleasedata endpoint', () => {
        mockHttp.getPagedArrayList.and.returnValue(of({ data: [] }));
        service.getTickets({ tab: 'Story' }).subscribe();
        expect(mockHttp.getPagedArrayList).toHaveBeenCalledWith(
            jasmine.any(Object),
            'releasenotes/getreleasedata'
        );
    });

    // ── editTicket ───────────────────────────────────────────────────────────

    it('editTicket calls ticketdetailsedit endpoint', () => {
        mockHttp.getPagedArrayList.and.returnValue(of(true));
        service.editTicket({ releasenotesid: 1, title: 'T' }).subscribe();
        expect(mockHttp.getPagedArrayList).toHaveBeenCalledWith(
            jasmine.any(Object),
            'releasenotes/ticketdetailsedit'
        );
    });

    // ── getSupportLog ────────────────────────────────────────────────────────

    it('getSupportLog calls getsupportlog endpoint', () => {
        mockHttp.getPagedArrayList.and.returnValue(of({ data: [] }));
        service.getSupportLog({ input: { supportno: '123' } }).subscribe();
        expect(mockHttp.getPagedArrayList).toHaveBeenCalledWith(
            jasmine.any(Object),
            'supportlog/getsupportlog'
        );
    });

    // ── getJiraStatus ────────────────────────────────────────────────────────

    it('getJiraStatus calls getJiraStatus endpoint with itemid', () => {
        mockHttp.getAll.and.returnValue(of({ status: 'Open' }));
        service.getJiraStatus('JIRA-1').subscribe();
        expect(mockHttp.getAll).toHaveBeenCalledWith(
            'supportlog/getJiraStatus?jirarequestno=JIRA-1'
        );
    });

    // ── getSupportLogWithJira ────────────────────────────────────────────────

    it('getSupportLogWithJira returns null immediately when jirasupportno is falsy', done => {
        service.getSupportLogWithJira({ jirasupportno: null }).subscribe(res => {
            expect(res).toBeNull();
            done();
        });
        expect(mockHttp.getPagedArrayList).not.toHaveBeenCalled();
    });

    it('getSupportLogWithJira returns null when support log data is empty', done => {
        mockHttp.getPagedArrayList.and.returnValue(of({ data: [] }));
        mockHttp.getAll.and.returnValue(of({ status: 'Open' }));
        service.getSupportLogWithJira({ jirasupportno: 'SUP-1', supportno: '123', itemid: 'JIRA-1' }).subscribe(res => {
            expect(res).toBeNull();
            done();
        });
    });

    it('getSupportLogWithJira merges jiraStatus and maps issuetype', done => {
        const ticket = { issuetype: '531', supportno: '123' };
        mockHttp.getPagedArrayList.and.returnValue(of({ data: [ticket] }));
        mockHttp.getAll.and.returnValue(of({ status: 'In Progress', comments: [] }));
        service.getSupportLogWithJira({ jirasupportno: 'SUP-1', supportno: '123', itemid: 'JIRA-1' }).subscribe((res: any) => {
            expect(res.ticketDetails.jiraStatus).toBe('In Progress');
            expect(res.ticketDetails.issuetype).toBe('Enhancement');
            done();
        });
    });

    it('getSupportLogWithJira filters image comments and formats others', done => {
        const ticket = { issuetype: null, supportno: '123' };
        const comments = [
            { body: 'Has image-attachment here', author: { displayName: 'User' }, updated: '2024-01-01T10:00:00' },
            { body: 'Normal comment', author: { displayName: 'Admin' }, updated: '2024-01-01T11:00:00' }
        ];
        mockHttp.getPagedArrayList.and.returnValue(of({ data: [ticket] }));
        mockHttp.getAll.and.returnValue(of({ status: null, comments }));
        service.getSupportLogWithJira({ jirasupportno: 'SUP-1', supportno: '123', itemid: 'JIRA-1' }).subscribe((res: any) => {
            expect(res.ticketDetails.jiraComments).toContain('Normal comment');
            expect(res.ticketDetails.jiraComments).not.toContain('image-attachment');
            done();
        });
    });

    // ── fuzzySearch ──────────────────────────────────────────────────────────

    it('fuzzySearch constructs URL with all params', () => {
        mockHttp.getAll.and.returnValue(of([]));
        service.fuzzySearch('fix', true, { page: '1', limit: '10' }).subscribe();
        const calledUrl: string = mockHttp.getAll.calls.mostRecent().args[0];
        expect(calledUrl).toContain('searchTerm=fix');
        expect(calledUrl).toContain('fulldata=true');
        expect(calledUrl).toContain('page=1');
    });

    // ── Keyword state management ─────────────────────────────────────────────

    it('initial keywordState has mode=false and empty results', done => {
        service.keywordState$.subscribe(state => {
            expect(state.mode).toBeFalse();
            expect(state.results).toEqual([]);
            expect(state.hasSearched).toBeFalse();
            done();
        });
    });

    it('setKeywordState updates the observable', done => {
        const newState: KeywordSearchState = {
            mode: true,
            searchTerm: 'test',
            itemtype: 'Story',
            results: [{ id: 1 }],
            totalRecords: 1,
            paginationInfo: new PaginationInfo(),
            hasSearched: true
        };
        service.setKeywordState(newState);
        service.keywordState$.subscribe(state => {
            expect(state.mode).toBeTrue();
            expect(state.searchTerm).toBe('test');
            expect(state.results.length).toBe(1);
            done();
        });
    });

    it('getKeywordState returns current value synchronously', () => {
        const state = service.getKeywordState();
        expect(state).toBeDefined();
        expect(state.mode).toBeFalse();
    });

    it('clearKeywordState resets to defaults', done => {
        service.setKeywordState({
            mode: true, searchTerm: 'abc', itemtype: 'Story',
            results: [{ id: 1 }], totalRecords: 1,
            paginationInfo: new PaginationInfo(), hasSearched: true
        });
        service.clearKeywordState();
        service.keywordState$.subscribe(state => {
            expect(state.mode).toBeFalse();
            expect(state.searchTerm).toBe('');
            expect(state.results).toEqual([]);
            done();
        });
    });
});

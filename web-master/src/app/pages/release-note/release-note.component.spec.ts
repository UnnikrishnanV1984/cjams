import { waitForAsync, ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { BehaviorSubject, of } from 'rxjs';
import { By } from '@angular/platform-browser';
import { ReleaseNoteComponent } from '././release-note.component
import { ReleaseNoteService, KeywordSearchState } from '././release-note.service
import { PaginationInfo } from '../../@core/entities/common.entities';

function buildKwState(overrides: Partial<KeywordSearchState> = {}): KeywordSearchState {
    return {
        mode: false, searchTerm: '', itemtype: 'both',
        results: [], totalRecords: 0,
        paginationInfo: new PaginationInfo(), hasSearched: false,
        ...overrides
    };
}

function buildServiceMock() {
    const kwSubject = new BehaviorSubject<KeywordSearchState>(buildKwState());
    return {
        keywordState$: kwSubject.asObservable(),
        fuzzySearch: jasmine.createSpy('fuzzySearch').and.returnValue(of([])),
        setKeywordState: jasmine.createSpy('setKeywordState').and.callFake((s: KeywordSearchState) => kwSubject.next(s)),
        clearKeywordState: jasmine.createSpy('clearKeywordState').and.callFake(() => kwSubject.next(buildKwState())),
        _kwSubject: kwSubject
    };
}

describe('ReleaseNoteComponent', () => {
    let component: ReleaseNoteComponent;
    let fixture: ComponentFixture<ReleaseNoteComponent>;
    let mockService: ReturnType<typeof buildServiceMock>;
    let mockRoute: any;

    beforeEach(waitForAsync(() => {
        mockService = buildServiceMock();
        mockRoute = {
            snapshot: { data: { access: { approver: false, admin: false } } },
            queryParams: of({})
        };

        TestBed.configureTestingModule({
            imports: [ReleaseNoteComponent],
            providers: [
                { provide: ReleaseNoteService, useValue: mockService },
                { provide: ActivatedRoute, useValue: mockRoute }
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ReleaseNoteComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    // ── Initialisation ───────────────────────────────────────────────────────

    it('creates the component', () => {
        expect(component).toBeTruthy();
    });

    it('reads approver/admin flags from route snapshot data', () => {
        mockRoute.snapshot.data.access = { approver: true, admin: true };
        fixture = TestBed.createComponent(ReleaseNoteComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
        expect(component.releaseApprover).toBeTrue();
        expect(component.releaseAdmin).toBeTrue();
    });

    it('defaults access flags to false when resolver data is missing', () => {
        mockRoute.snapshot.data = {};
        fixture = TestBed.createComponent(ReleaseNoteComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
        expect(component.releaseApprover).toBeFalse();
        expect(component.releaseAdmin).toBeFalse();
    });

    it('starts with no selectedVersion', () => {
        expect(component.selectedVersion).toBeNull();
    });

    // ── Version selection ────────────────────────────────────────────────────

    it('onOpenVersion sets selectedVersion', () => {
        const v = { releaseversionno: '1.0', releasedate: '2024-01-01' };
        component.onOpenVersion(v);
        expect(component.selectedVersion).toEqual(v);
    });

    it('onBack clears selectedVersion', () => {
        component.selectedVersion = { releaseversionno: '1.0', releasedate: '2024-01-01' };
        component.onBack();
        expect(component.selectedVersion).toBeNull();
    });

    // ── Auto-open on login ───────────────────────────────────────────────────

    it('onFirstVersionLoaded opens version when fromScreen is login', () => {
        (component as any)._fromScreen = 'login';
        const v = { releaseversionno: '1.0', releasedate: '2024-01-01' };
        component.onFirstVersionLoaded(v);
        expect(component.selectedVersion).toEqual(v);
    });

    it('onFirstVersionLoaded does not open version when fromScreen is not login', () => {
        (component as any)._fromScreen = null;
        const v = { releaseversionno: '1.0', releasedate: '2024-01-01' };
        component.onFirstVersionLoaded(v);
        expect(component.selectedVersion).toBeNull();
    });

    it('onFirstVersionLoaded does nothing when firstVersion is null', () => {
        (component as any)._fromScreen = 'login';
        component.onFirstVersionLoaded(null);
        expect(component.selectedVersion).toBeNull();
    });

    // ── Version filter ───────────────────────────────────────────────────────

    it('onVersionSearch updates versionFilter', () => {
        const f = { releaseversionno: '2.0', startdate: '2024-01-01', enddate: '2024-12-31' };
        component.onVersionSearch(f);
        expect(component.versionFilter).toEqual(f);
    });

    it('onVersionSearch creates a new object reference (shallow copy)', () => {
        const f = { releaseversionno: '2.0', startdate: null, enddate: null };
        component.onVersionSearch(f);
        expect(component.versionFilter).not.toBe(f);
    });

    it('onVersionCleared resets versionFilter to nulls', () => {
        component.versionFilter = { releaseversionno: '1.0', startdate: '2024-01-01', enddate: '2024-12-31' };
        component.onVersionCleared();
        expect(component.versionFilter).toEqual({ releaseversionno: null, startdate: null, enddate: null });
    });

    // ── Keyword search ───────────────────────────────────────────────────────

    it('onKeywordSearch calls fuzzySearch and sets keyword state', () => {
        const results = [{ id: 1 }];
        mockService.fuzzySearch.and.returnValue(of(results));
        component.onKeywordSearch({ term: 'fix', itemtype: 'Story' });
        expect(mockService.fuzzySearch).toHaveBeenCalledWith('fix', true, jasmine.objectContaining({ itemtype: 'Story' }));
        expect(mockService.setKeywordState).toHaveBeenCalledWith(jasmine.objectContaining({ mode: true, searchTerm: 'fix' }));
    });

    it('onKeywordSearch resets page to 1', () => {
        mockService.fuzzySearch.and.returnValue(of([]));
        component.onKeywordSearch({ term: 'bug', itemtype: 'both' });
        const stateArg: KeywordSearchState = mockService.setKeywordState.calls.mostRecent().args[0];
        expect(stateArg.paginationInfo.pageNumber).toBe(1);
    });

    it('onKeywordSearch excludes itemtype from params when itemtype is not Story or Defect', () => {
        mockService.fuzzySearch.and.returnValue(of([]));
        component.onKeywordSearch({ term: 'bug', itemtype: 'both' });
        const extraArg = mockService.fuzzySearch.calls.mostRecent().args[2];
        expect(extraArg['itemtype']).toBeUndefined();
    });

    it('onKeywordCleared calls clearKeywordState', () => {
        component.onKeywordCleared();
        expect(mockService.clearKeywordState).toHaveBeenCalled();
    });

    it('onKeywordSorted calls fuzzySearch with updated sort params', () => {
        mockService.fuzzySearch.and.returnValue(of([]));
        component.onKeywordSorted({ sortColumn: 'title', sortDirection: 'asc' });
        const extraArg = mockService.fuzzySearch.calls.mostRecent().args[2];
        expect(extraArg['sortcolumn']).toBe('title');
        expect(extraArg['sortorder']).toBe('asc');
    });

    it('onKeywordPageChanged calls fuzzySearch with correct page number', () => {
        mockService.fuzzySearch.and.returnValue(of([]));
        component.onKeywordPageChanged(3);
        const extraArg = mockService.fuzzySearch.calls.mostRecent().args[2];
        expect(extraArg['page']).toBe('3');
    });

    // ── ngOnDestroy ──────────────────────────────────────────────────────────

    it('unsubscribes from keywordState on destroy', () => {
        spyOn((component as any)._kwSub, 'unsubscribe');
        component.ngOnDestroy();
        expect((component as any)._kwSub.unsubscribe).toHaveBeenCalled();
    });

    // ── Template integration ─────────────────────────────────────────────────

    it('shows version list when no version is selected and kwState mode is false', () => {
        component.selectedVersion = null;
        component.kwState = buildKwState({ mode: false });
        fixture.detectChanges();
        const versionList = fixture.debugElement.query(By.css('release-version-list'));
        expect(versionList).toBeTruthy();
    });

    it('shows ticket list when a version is selected', () => {
        component.selectedVersion = { releaseversionno: '1.0', releasedate: '2024-01-01' };
        component.kwState = buildKwState({ mode: false });
        fixture.detectChanges();
        const ticketList = fixture.debugElement.query(By.css('ticket-list'));
        expect(ticketList).toBeTruthy();
    });

    it('shows keyword search list when kwState mode is true', () => {
        component.selectedVersion = null;
        component.kwState = buildKwState({ mode: true });
        fixture.detectChanges();
        const kwList = fixture.debugElement.query(By.css('keyword-search-list'));
        expect(kwList).toBeTruthy();
    });
});

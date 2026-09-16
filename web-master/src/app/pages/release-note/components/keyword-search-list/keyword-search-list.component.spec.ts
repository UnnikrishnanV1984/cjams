import { waitForAsync, ComponentFixture, TestBed } from '@angular/core/testing';
import { SimpleChange } from '@angular/core';
import { of, throwError } from 'rxjs';
import { By } from '@angular/platform-browser';
import { KeywordSearchListComponent } from './keyword-search-list.component';
import { ReleaseNoteService } from '..../../release-note.service
import { AlertService } from '../../../../@core/services';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

const SAMPLE_RESULTS = [
    { itemtype: 'Story', releaseversionno: '1.0', title: 'Story A', description: 'Desc A', supportid: null },
    { itemtype: 'Defect', releaseversionno: '1.0', title: 'Defect B', description: 'Desc B', supportid: 'SUP-1' },
    { itemtype: 'Story', releaseversionno: '2.0', title: 'Story C', description: 'Desc C', supportid: null }
];

describe('KeywordSearchListComponent', () => {
    let component: KeywordSearchListComponent;
    let fixture: ComponentFixture<KeywordSearchListComponent>;
    let mockService: jasmine.SpyObj<ReleaseNoteService>;
    let mockAlert: jasmine.SpyObj<AlertService>;

    beforeEach(waitForAsync(() => {
        mockService = jasmine.createSpyObj('ReleaseNoteService', ['getSupportLogWithJira']);
        mockAlert = jasmine.createSpyObj('AlertService', ['success', 'error']);

        (window as any).$ = () => ({ modal: jasmine.createSpy('modal') });

        TestBed.configureTestingModule({
            imports: [KeywordSearchListComponent],
            providers: [
                { provide: ReleaseNoteService, useValue: mockService },
                { provide: AlertService, useValue: mockAlert }
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(KeywordSearchListComponent);
        component = fixture.componentInstance;
        component.paginationInfo = new PaginationInfo();
        fixture.detectChanges();
    });

    it('creates the component', () => {
        expect(component).toBeTruthy();
    });

    // ── ngOnChanges — results ────────────────────────────────────────────────

    it('recalculates counts when results change', () => {
        component.results = SAMPLE_RESULTS;
        component.ngOnChanges({ results: new SimpleChange([], SAMPLE_RESULTS, false) });
        expect(component.storyCount).toBe(2);
        expect(component.defectCount).toBe(1);
        expect(component.distinctReleaseCount).toBe(2);
    });

    it('sets counts to 0 for empty results', () => {
        component.results = [];
        component.ngOnChanges({ results: new SimpleChange(SAMPLE_RESULTS, [], false) });
        expect(component.storyCount).toBe(0);
        expect(component.defectCount).toBe(0);
        expect(component.distinctReleaseCount).toBe(0);
    });

    // ── ngOnChanges — itemtype ───────────────────────────────────────────────

    it('sets scopeLabel to "Stories" when itemtype is Story', () => {
        component.itemtype = 'Story';
        component.ngOnChanges({ itemtype: new SimpleChange('both', 'Story', false) });
        expect(component.scopeLabel).toBe('Stories');
    });

    it('sets scopeLabel to "Defects" when itemtype is Defect', () => {
        component.itemtype = 'Defect';
        component.ngOnChanges({ itemtype: new SimpleChange('both', 'Defect', false) });
        expect(component.scopeLabel).toBe('Defects');
    });

    it('sets scopeLabel to "Stories and Defects" when itemtype is both', () => {
        component.itemtype = 'both';
        component.ngOnChanges({ itemtype: new SimpleChange('Story', 'both', false) });
        expect(component.scopeLabel).toBe('Stories and Defects');
    });

    // ── Outputs ──────────────────────────────────────────────────────────────

    it('onSorted emits sorted event', () => {
        let emitted: any;
        component.sorted.subscribe(e => emitted = e);
        component.onSorted({ sortColumn: 'title', sortDirection: 'asc' });
        expect(emitted).toEqual({ sortColumn: 'title', sortDirection: 'asc' });
    });

    it('onPageChanged emits page number', () => {
        let emitted: number | undefined;
        component.pageChanged.subscribe(p => emitted = p);
        component.onPageChanged({ page: 3 });
        expect(emitted).toBe(3);
    });

    it('cleared emits when cleared output fires', () => {
        let emitted = false;
        component.cleared.subscribe(() => emitted = true);
        component.cleared.emit();
        expect(emitted).toBeTrue();
    });

    // ── openDetails ──────────────────────────────────────────────────────────

    it('openDetails sets selectedRelease and ticketMode to view', () => {
        const row = SAMPLE_RESULTS[0];
        component.openDetails(row);
        expect(component.selectedRelease).toEqual(row);
        expect(component.ticketMode).toBe('view');
        expect(component.ticketDetails).toBeNull();
    });

    // ── openSupportLog ───────────────────────────────────────────────────────

    it('openSupportLog sets ticketDetails when result is returned', () => {
        const ticketDetails = { issuetype: 'Bug', jiraStatus: 'Open' };
        mockService.getSupportLogWithJira.and.returnValue(of({ ticketDetails }));
        component.openSupportLog(SAMPLE_RESULTS[1]);
        expect(component.ticketDetails).toEqual(ticketDetails);
        expect(component.selectedRelease).toEqual(SAMPLE_RESULTS[1]);
    });

    it('openSupportLog shows error alert when result is null', () => {
        mockService.getSupportLogWithJira.and.returnValue(of(null));
        component.openSupportLog(SAMPLE_RESULTS[1]);
        expect(mockAlert.error).toHaveBeenCalledWith(
            'Could not load support ticket details. Please try again.'
        );
    });

    it('openSupportLog shows error alert on service error', () => {
        mockService.getSupportLogWithJira.and.returnValue(throwError(() => new Error('fail')));
        component.openSupportLog(SAMPLE_RESULTS[1]);
        expect(mockAlert.error).toHaveBeenCalledWith(
            'An error occurred while loading support ticket details.'
        );
    });

    // ── Template rendering ───────────────────────────────────────────────────

    it('shows results table when hasSearched is true and results exist', () => {
        component.hasSearched = true;
        component.results = SAMPLE_RESULTS;
        component.ngOnChanges({ results: new SimpleChange([], SAMPLE_RESULTS, false) });
        fixture.detectChanges();
        const rows = fixture.debugElement.queryAll(By.css('tbody tr'));
        expect(rows.length).toBeGreaterThan(0);
    });

    it('shows no-results row when hasSearched is true and results are empty', () => {
        component.hasSearched = true;
        component.results = [];
        component.ngOnChanges({ results: new SimpleChange(SAMPLE_RESULTS, [], false) });
        fixture.detectChanges();
        const noResultsRow = fixture.debugElement.query(By.css('tbody tr td'));
        expect(noResultsRow).toBeTruthy();
    });
});

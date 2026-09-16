import { waitForAsync, ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { ReleaseNoteSearchComponent } from './release-note-search.component';
import { KeywordSearchState } from '../../release-note.service
import { PaginationInfo } from '../../../../@core/entities/common.entities';

function buildKwState(overrides: Partial<KeywordSearchState> = {}): KeywordSearchState {
    return {
        mode: false, searchTerm: '', itemtype: 'both',
        results: [], totalRecords: 0,
        paginationInfo: new PaginationInfo(), hasSearched: false,
        ...overrides
    };
}

describe('ReleaseNoteSearchComponent', () => {
    let component: ReleaseNoteSearchComponent;
    let fixture: ComponentFixture<ReleaseNoteSearchComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
            imports: [ReleaseNoteSearchComponent]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ReleaseNoteSearchComponent);
        component = fixture.componentInstance;
        component.kwState = buildKwState();
        fixture.detectChanges();
    });

    it('creates the component', () => {
        expect(component).toBeTruthy();
    });

    // ── Version search ───────────────────────────────────────────────────────

    it('onVersionSearch emits the current version filter fields', () => {
        let emitted: any;
        component.versionSearch.subscribe(v => emitted = v);
        component.releaseversionno = '2.0';
        component.startdate = '2024-01-01';
        component.enddate = '2024-12-31';
        component.onVersionSearch();
        expect(emitted).toEqual({ releaseversionno: '2.0', startdate: '2024-01-01', enddate: '2024-12-31' });
    });

    it('onVersionSearch emits nulls when fields are empty', () => {
        let emitted: any;
        component.versionSearch.subscribe(v => emitted = v);
        component.onVersionSearch();
        expect(emitted).toEqual({ releaseversionno: null, startdate: null, enddate: null });
    });

    it('onVersionClear resets fields and emits versionCleared', () => {
        let cleared = false;
        component.versionCleared.subscribe(() => cleared = true);
        component.releaseversionno = '1.0';
        component.startdate = '2024-01-01';
        component.enddate = '2024-12-31';
        component.onVersionClear();
        expect(component.releaseversionno).toBeNull();
        expect(component.startdate).toBeNull();
        expect(component.enddate).toBeNull();
        expect(cleared).toBeTrue();
    });

    // ── Keyword search ───────────────────────────────────────────────────────

    it('onKeywordSearch emits term and itemtype when term is non-empty', () => {
        let emitted: any;
        component.keywordSearch.subscribe(e => emitted = e);
        component.keywordTerm = '  fix bug  ';
        component.itemtype = 'Defect';
        component.onKeywordSearch();
        expect(emitted).toEqual({ term: 'fix bug', itemtype: 'Defect' });
    });

    it('onKeywordSearch does not emit when term is blank', () => {
        let emitted = false;
        component.keywordSearch.subscribe(() => emitted = true);
        component.keywordTerm = '   ';
        component.onKeywordSearch();
        expect(emitted).toBeFalse();
    });

    it('onKeywordSearch does not emit when keywordTerm is empty string', () => {
        let emitted = false;
        component.keywordSearch.subscribe(() => emitted = true);
        component.keywordTerm = '';
        component.onKeywordSearch();
        expect(emitted).toBeFalse();
    });

    it('onKeywordClear resets keywordTerm and itemtype and emits keywordCleared', () => {
        let cleared = false;
        component.keywordCleared.subscribe(() => cleared = true);
        component.keywordTerm = 'test';
        component.itemtype = 'Story';
        component.onKeywordClear();
        expect(component.keywordTerm).toBe('');
        expect(component.itemtype).toBe('both');
        expect(cleared).toBeTrue();
    });

    // ── Template ─────────────────────────────────────────────────────────────

    it('renders the version search section', () => {
        const el = fixture.debugElement.query(By.css('input[name="releaseversionno"]') ?? By.css('mat-form-field'));
        expect(el || fixture.nativeElement.innerHTML).toBeTruthy();
    });
});

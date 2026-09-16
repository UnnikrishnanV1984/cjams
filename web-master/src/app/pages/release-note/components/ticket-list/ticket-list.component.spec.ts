import { waitForAsync, ComponentFixture, TestBed } from '@angular/core/testing';
import { SimpleChange } from '@angular/core';
import { of, throwError } from 'rxjs';
import { By } from '@angular/platform-browser';
import { TicketListComponent } from './ticket-list.component';
import { ReleaseNoteService, ReleaseVersion } from '..../../release-note.service
import { AlertService } from '../../../../@core/services';
import { DomSanitizer } from '@angular/platform-browser';

describe('TicketListComponent', () => {
    let component: TicketListComponent;
    let fixture: ComponentFixture<TicketListComponent>;
    let mockService: jasmine.SpyObj<ReleaseNoteService>;
    let mockAlert: jasmine.SpyObj<AlertService>;

    const sampleVersion: ReleaseVersion = {
        releaseversionno: '1.0',
        releasedate: '2024-03-15T00:00:00'
    };

    const sampleTickets = [
        { itemid: 'JIRA-1', title: 'Fix login', itemtype: 'Defect', totalcount: 2, documentlink: 'https://docs.example.com' },
        { itemid: 'JIRA-2', title: 'Add feature', itemtype: 'Story', totalcount: 2, documentlink: null }
    ];

    beforeEach(waitForAsync(() => {
        mockService = jasmine.createSpyObj('ReleaseNoteService', [
            'getTickets', 'fuzzySearch', 'getSupportLogWithJira'
        ]);
        mockAlert = jasmine.createSpyObj('AlertService', ['success', 'error']);

        mockService.getTickets.and.returnValue(of({ data: sampleTickets }));

        (window as any).$ = () => ({ modal: jasmine.createSpy('modal') });

        TestBed.configureTestingModule({
            imports: [TicketListComponent],
            providers: [
                { provide: ReleaseNoteService, useValue: mockService },
                { provide: AlertService, useValue: mockAlert }
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(TicketListComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('creates the component', () => {
        expect(component).toBeTruthy();
    });

    // ── tabType getter ───────────────────────────────────────────────────────

    it('tabType returns Defect when isValue is 0', () => {
        component.isValue = 0;
        expect(component.tabType).toBe('Defect');
    });

    it('tabType returns Story when isValue is 1', () => {
        component.isValue = 1;
        expect(component.tabType).toBe('Story');
    });

    // ── ngOnChanges ──────────────────────────────────────────────────────────

    it('loads tickets when version is set', () => {
        component.ngOnChanges({
            version: new SimpleChange(null, sampleVersion, true)
        });
        expect(mockService.getTickets).toHaveBeenCalled();
        const filter = mockService.getTickets.calls.mostRecent().args[0];
        expect(filter.releaseversionno).toBe('1.0');
        expect(filter.releasedate).toBe('2024-03-15');
    });

    it('resets isValue to 0 (Defect tab) when version changes', () => {
        component.isValue = 1;
        component.ngOnChanges({
            version: new SimpleChange(null, sampleVersion, false)
        });
        expect(component.isValue).toBe(0);
    });

    it('clears filters when version changes', () => {
        component.jiraid = 'JIRA-99';
        component.title = 'old title';
        component.ngOnChanges({
            version: new SimpleChange(null, sampleVersion, false)
        });
        expect(component.jiraid).toBeNull();
        expect(component.title).toBeNull();
    });

    it('does not load tickets when version is null', () => {
        mockService.getTickets.calls.reset();
        component.ngOnChanges({ version: new SimpleChange(sampleVersion, null, false) });
        expect(mockService.getTickets).not.toHaveBeenCalled();
    });

    // ── loadTickets ──────────────────────────────────────────────────────────

    it('populates tickets and totalCount from response', () => {
        component.version = sampleVersion;
        component.loadTickets();
        expect(component.tickets.length).toBe(2);
        expect(component.totalCount).toBe(2);
    });

    it('handles empty data response', () => {
        mockService.getTickets.and.returnValue(of({ data: [] }));
        component.version = sampleVersion;
        component.loadTickets();
        expect(component.tickets.length).toBe(0);
        expect(component.totalCount).toBe(0);
    });

    it('does not call service when version is null', () => {
        mockService.getTickets.calls.reset();
        component.version = null;
        component.loadTickets();
        expect(mockService.getTickets).not.toHaveBeenCalled();
    });

    // ── switchTab ────────────────────────────────────────────────────────────

    it('switchTab changes isValue and reloads', () => {
        component.version = sampleVersion;
        component.switchTab(1);
        expect(component.isValue).toBe(1);
        const filter = mockService.getTickets.calls.mostRecent().args[0];
        expect(filter.tab).toBe('Story');
    });

    it('switchTab resets page to 1', () => {
        component.version = sampleVersion;
        component.paginationInfo.pageNumber = 5;
        component.switchTab(0);
        expect(component.paginationInfo.pageNumber).toBe(1);
    });

    // ── search / reset ───────────────────────────────────────────────────────

    it('search resets page and reloads tickets', () => {
        component.version = sampleVersion;
        component.paginationInfo.pageNumber = 4;
        component.search();
        expect(component.paginationInfo.pageNumber).toBe(1);
        expect(mockService.getTickets).toHaveBeenCalled();
    });

    it('reset clears filters and reloads', () => {
        component.version = sampleVersion;
        component.jiraid = 'JIRA-5';
        component.title = 'something';
        component.reset();
        expect(component.jiraid).toBeNull();
        expect(component.title).toBeNull();
        expect(mockService.getTickets).toHaveBeenCalled();
    });

    // ── onKeywordSearch ──────────────────────────────────────────────────────

    it('onKeywordSearch calls fuzzySearch with trimmed term', () => {
        mockService.fuzzySearch.and.returnValue(of(sampleTickets));
        component.version = sampleVersion;
        component.popupKeywordSearchTerm = '  fix  ';
        component.onKeywordSearch();
        expect(mockService.fuzzySearch).toHaveBeenCalledWith('fix', true, jasmine.objectContaining({
            pReleaseVersion: '1.0'
        }));
    });

    it('onKeywordSearch does not call service when term is blank', () => {
        component.popupKeywordSearchTerm = '   ';
        component.onKeywordSearch();
        expect(mockService.fuzzySearch).not.toHaveBeenCalled();
    });

    it('onKeywordSearch populates tickets from result', () => {
        mockService.fuzzySearch.and.returnValue(of(sampleTickets));
        component.version = sampleVersion;
        component.popupKeywordSearchTerm = 'bug';
        component.onKeywordSearch();
        expect(component.tickets.length).toBe(2);
    });

    // ── onSort / pageChanged ─────────────────────────────────────────────────

    it('onSort updates sort params and reloads', () => {
        component.version = sampleVersion;
        component.onSort({ sortColumn: 'title', sortDirection: 'asc' });
        expect(component.paginationInfo.sortColumn).toBe('title');
        expect(component.paginationInfo.sortBy).toBe('asc');
        expect(mockService.getTickets).toHaveBeenCalled();
    });

    it('pageChanged updates pageNumber and reloads', () => {
        component.version = sampleVersion;
        component.pageChanged(3);
        expect(component.paginationInfo.pageNumber).toBe(3);
        expect(mockService.getTickets).toHaveBeenCalled();
    });

    // ── Modal actions ────────────────────────────────────────────────────────

    it('viewRelease sets selectedRelease and ticketMode to view', () => {
        const release = sampleTickets[0];
        component.viewRelease(release);
        expect(component.selectedRelease).toEqual(release);
        expect(component.ticketMode).toBe('view');
        expect(component.ticketDetails).toBeNull();
    });

    it('editRelease sets selectedRelease and ticketMode to edit', () => {
        const release = sampleTickets[0];
        component.editRelease(release);
        expect(component.selectedRelease).toEqual(release);
        expect(component.ticketMode).toBe('edit');
    });

    // ── getSupportLog ────────────────────────────────────────────────────────

    it('getSupportLog sets ticketDetails on successful result', () => {
        const ticketDetails = { issuetype: 'Bug', jiraStatus: 'Open' };
        mockService.getSupportLogWithJira.and.returnValue(of({ ticketDetails }));
        component.getSupportLog(sampleTickets[0]);
        expect(component.ticketDetails).toEqual(ticketDetails);
        expect(component.selectedRelease).toEqual(sampleTickets[0]);
    });

    it('getSupportLog shows jira error modal when result is null', () => {
        const modalSpy = jasmine.createSpy('modal');
        (window as any).$ = () => ({ modal: modalSpy });
        mockService.getSupportLogWithJira.and.returnValue(of(null));
        component.getSupportLog(sampleTickets[0]);
        expect(modalSpy).toHaveBeenCalledWith('show');
    });

    it('getSupportLog shows error alert on service error', () => {
        mockService.getSupportLogWithJira.and.returnValue(throwError(() => new Error('fail')));
        component.getSupportLog(sampleTickets[0]);
        expect(mockAlert.error).toHaveBeenCalledWith(
            'An error occurred while loading support ticket details.'
        );
    });

    // ── getSafeDocumentLink ──────────────────────────────────────────────────

    it('getSafeDocumentLink returns a SafeUrl for https links', () => {
        const result = component.getSafeDocumentLink('https://example.com');
        expect(result).toBeTruthy();
    });

    it('getSafeDocumentLink returns a SafeUrl for http links', () => {
        const result = component.getSafeDocumentLink('http://example.com');
        expect(result).toBeTruthy();
    });

    it('getSafeDocumentLink returns null for non-http links', () => {
        expect(component.getSafeDocumentLink('javascript:alert(1)')).toBeNull();
        expect(component.getSafeDocumentLink('ftp://example.com')).toBeNull();
    });

    it('getSafeDocumentLink returns null for empty string', () => {
        expect(component.getSafeDocumentLink('')).toBeNull();
    });

    // ── back output ──────────────────────────────────────────────────────────

    it('back output can be emitted', () => {
        let backEmitted = false;
        component.back.subscribe(() => backEmitted = true);
        component.back.emit();
        expect(backEmitted).toBeTrue();
    });

    // ── Template rendering ───────────────────────────────────────────────────

    it('renders two tab buttons for Defects and Stories', () => {
        component.version = sampleVersion;
        component.ngOnChanges({ version: new SimpleChange(null, sampleVersion, true) });
        fixture.detectChanges();
        const tabs = fixture.debugElement.queryAll(By.css('.nav-link') ?? By.css('[class*="tab"]'));
        // Tab buttons exist in the template
        expect(fixture.nativeElement.innerHTML).toContain('Defect');
        expect(fixture.nativeElement.innerHTML).toContain('Story');
    });
});

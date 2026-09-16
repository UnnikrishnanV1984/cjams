import { waitForAsync, ComponentFixture, TestBed } from '@angular/core/testing';
import { SimpleChange } from '@angular/core';
import { of } from 'rxjs';
import { By } from '@angular/platform-browser';
import { TicketDetailComponent, TICKET_MODAL_IDS, KW_TICKET_MODAL_IDS } from './ticket-detail.component';
import { ReleaseNoteService } from '..../../../release-note.service
import { AlertService } from '../../../../../@core/services';

describe('TicketDetailComponent', () => {
    let component: TicketDetailComponent;
    let fixture: ComponentFixture<TicketDetailComponent>;
    let mockService: jasmine.SpyObj<ReleaseNoteService>;
    let mockAlert: jasmine.SpyObj<AlertService>;

    const sampleRelease = {
        releasenotesid: 42,
        itemid: 'JIRA-1',
        title: 'Fix login bug',
        description: 'Desc here',
        supportno: 'SUP-1',
        frommailid: 'user@example.com',
        documentlink: 'https://example.com/doc'
    };

    beforeEach(waitForAsync(() => {
        mockService = jasmine.createSpyObj('ReleaseNoteService', ['editTicket']);
        mockAlert = jasmine.createSpyObj('AlertService', ['success', 'error']);

        (window as any).$ = () => ({ modal: jasmine.createSpy('modal') });

        TestBed.configureTestingModule({
            imports: [TicketDetailComponent],
            providers: [
                { provide: ReleaseNoteService, useValue: mockService },
                { provide: AlertService, useValue: mockAlert }
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(TicketDetailComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('creates the component', () => {
        expect(component).toBeTruthy();
    });

    // ── TICKET_MODAL_IDS constants ───────────────────────────────────────────

    it('exports TICKET_MODAL_IDS with expected keys', () => {
        expect(TICKET_MODAL_IDS.supportLog).toBe('ticket-detail-support');
        expect(TICKET_MODAL_IDS.editView).toBe('ticket-detail-view');
        expect(TICKET_MODAL_IDS.jiraError).toBe('ticket-detail-jira-error');
    });

    it('exports KW_TICKET_MODAL_IDS with kw-prefixed keys', () => {
        expect(KW_TICKET_MODAL_IDS.supportLog).toBe('kw-ticket-detail-support');
        expect(KW_TICKET_MODAL_IDS.editView).toBe('kw-ticket-detail-view');
        expect(KW_TICKET_MODAL_IDS.jiraError).toBe('kw-ticket-detail-jira-error');
    });

    it('defaults modalIdSupportLog to TICKET_MODAL_IDS.supportLog', () => {
        expect(component.modalIdSupportLog).toBe(TICKET_MODAL_IDS.supportLog);
    });

    it('accepts custom modal IDs via @Input', () => {
        component.modalIdSupportLog = KW_TICKET_MODAL_IDS.supportLog;
        expect(component.modalIdSupportLog).toBe('kw-ticket-detail-support');
    });

    // ── ngOnChanges — selectedRelease ────────────────────────────────────────

    it('patches form when selectedRelease changes', () => {
        component.ngOnChanges({
            selectedRelease: new SimpleChange(null, sampleRelease, true)
        });
        expect(component.editForm.value.Defect).toBe('JIRA-1');
        expect(component.editForm.value.Title).toBe('Fix login bug');
        expect(component.editForm.value.Description).toBe('Desc here');
        expect(component.editForm.value.supportno).toBe('SUP-1');
        expect(component.editForm.value.documentlink).toBe('https://example.com/doc');
    });

    it('does not patch form when selectedRelease is null', () => {
        component.editForm.patchValue({ Title: 'Existing' });
        component.ngOnChanges({ selectedRelease: new SimpleChange(null, null, false) });
        expect(component.editForm.value.Title).toBe('Existing');
    });

    // ── ngOnChanges — mode ───────────────────────────────────────────────────

    it('enables form when mode changes to edit', () => {
        component.editForm.disable();
        component.mode = 'edit';
        component.ngOnChanges({ mode: new SimpleChange('view', 'edit', false) });
        expect(component.editForm.enabled).toBeTrue();
    });

    it('disables form when mode changes to view', () => {
        component.editForm.enable();
        component.mode = 'view';
        component.ngOnChanges({ mode: new SimpleChange('edit', 'view', false) });
        expect(component.editForm.disabled).toBeTrue();
    });

    // ── getFormattedDate ─────────────────────────────────────────────────────

    it('getFormattedDate returns MM/DD/YYYY for a valid date', () => {
        const result = component.getFormattedDate('2024-03-15');
        expect(result).toMatch(/^\d{2}\/\d{2}\/\d{4}$/);
    });

    it('getFormattedDate returns empty string for null', () => {
        expect(component.getFormattedDate(null)).toBe('');
    });

    it('getFormattedDate returns empty string for invalid date', () => {
        expect(component.getFormattedDate('not-a-date')).toBe('');
    });

    // ── save ─────────────────────────────────────────────────────────────────

    it('save calls editTicket with correct payload', () => {
        mockService.editTicket.and.returnValue(of(true));
        component.selectedRelease = sampleRelease;
        component.ngOnChanges({ selectedRelease: new SimpleChange(null, sampleRelease, true) });
        component.save();
        expect(mockService.editTicket).toHaveBeenCalledWith(jasmine.objectContaining({
            releasenotesid: 42,
            itemid: 'JIRA-1',
            title: 'Fix login bug'
        }));
    });

    it('save shows success alert on truthy response', () => {
        mockService.editTicket.and.returnValue(of(true));
        component.selectedRelease = sampleRelease;
        component.save();
        expect(mockAlert.success).toHaveBeenCalledWith('Release details updated Successfully.');
    });

    it('save shows error alert on falsy response', () => {
        mockService.editTicket.and.returnValue(of(false));
        component.selectedRelease = sampleRelease;
        component.save();
        expect(mockAlert.error).toHaveBeenCalledWith('Error in updating Release details.');
    });

    it('save emits saved event after service call', () => {
        mockService.editTicket.and.returnValue(of(true));
        component.selectedRelease = sampleRelease;
        let savedEmitted = false;
        component.saved.subscribe(() => savedEmitted = true);
        component.save();
        expect(savedEmitted).toBeTrue();
    });
});

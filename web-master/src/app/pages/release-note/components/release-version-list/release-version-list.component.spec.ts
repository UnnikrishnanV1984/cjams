import { waitForAsync, ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { SimpleChange } from '@angular/core';
import { of } from 'rxjs';
import { ReleaseVersionListComponent } from './release-version-list.component';
import { ReleaseNoteService, ReleaseVersion } from '..../../release-note.service
import { AlertService } from '../../../../@core/services';

describe('ReleaseVersionListComponent', () => {
    let component: ReleaseVersionListComponent;
    let fixture: ComponentFixture<ReleaseVersionListComponent>;
    let mockService: jasmine.SpyObj<ReleaseNoteService>;
    let mockAlert: jasmine.SpyObj<AlertService>;

    const sampleVersions: ReleaseVersion[] = [
        { releaseversionno: '1.0', releasedate: '2024-01-01T00:00:00', publish: true, totalcount: 2 },
        { releaseversionno: '2.0', releasedate: '2024-06-01T00:00:00', publish: false, totalcount: 2 }
    ];

    beforeEach(waitForAsync(() => {
        mockService = jasmine.createSpyObj('ReleaseNoteService', [
            'getReleaseVersions', 'publishReleaseNotes', 'deleteReleaseNotes', 'downloadReport'
        ]);
        mockAlert = jasmine.createSpyObj('AlertService', ['success', 'error']);

        mockService.getReleaseVersions.and.returnValue(of({ data: sampleVersions }));

        (window as any).$ = () => ({ modal: jasmine.createSpy('modal') });

        TestBed.configureTestingModule({
            imports: [ReleaseVersionListComponent],
            providers: [
                { provide: ReleaseNoteService, useValue: mockService },
                { provide: AlertService, useValue: mockAlert }
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ReleaseVersionListComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('creates the component', () => {
        expect(component).toBeTruthy();
    });

    // ── Initial load ─────────────────────────────────────────────────────────

    it('calls getReleaseVersions on init', () => {
        expect(mockService.getReleaseVersions).toHaveBeenCalled();
    });

    it('populates versions from response', () => {
        expect(component.versions.length).toBe(2);
        expect(component.versions[0].releaseversionno).toBe('1.0');
    });

    it('sets totalRecords from first row totalcount', () => {
        expect(component.totalRecords).toBe(2);
    });

    it('emits firstVersionLoaded with the first version on initial load', () => {
        let emitted: any = undefined;
        component.firstVersionLoaded.subscribe(v => emitted = v);
        fixture = TestBed.createComponent(ReleaseVersionListComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
        expect(emitted.releaseversionno).toBe('1.0');
    });

    it('emits firstVersionLoaded with null when versions array is empty', () => {
        mockService.getReleaseVersions.and.returnValue(of({ data: [] }));
        let emitted: any = 'NOT_SET';
        fixture = TestBed.createComponent(ReleaseVersionListComponent);
        component = fixture.componentInstance;
        component.firstVersionLoaded.subscribe(v => emitted = v);
        fixture.detectChanges();
        expect(emitted).toBeNull();
    });

    // ── ngOnChanges ──────────────────────────────────────────────────────────

    it('reloads on filter change (not first change)', () => {
        mockService.getReleaseVersions.calls.reset();
        component.ngOnChanges({
            filter: new SimpleChange(
                { releaseversionno: null, startdate: null, enddate: null },
                { releaseversionno: '1.0', startdate: null, enddate: null },
                false
            )
        });
        expect(mockService.getReleaseVersions).toHaveBeenCalled();
    });

    it('does not reload when filter change is the first change', () => {
        mockService.getReleaseVersions.calls.reset();
        component.ngOnChanges({
            filter: new SimpleChange(null, { releaseversionno: null, startdate: null, enddate: null }, true)
        });
        expect(mockService.getReleaseVersions).not.toHaveBeenCalled();
    });

    // ── Sorting and pagination ────────────────────────────────────────────────

    it('onSorted resets page to 1 and reloads', () => {
        component.paginationInfo.pageNumber = 3;
        component.onSorted({ sortColumn: 'Version', sortDirection: 'asc' });
        expect(component.paginationInfo.pageNumber).toBe(1);
        expect(mockService.getReleaseVersions).toHaveBeenCalledTimes(2); // init + sort
    });

    it('pageChanged updates pageNumber and reloads', () => {
        component.pageChanged({ page: 2 });
        expect(component.paginationInfo.pageNumber).toBe(2);
        expect(mockService.getReleaseVersions).toHaveBeenCalledTimes(2);
    });

    // ── Publish flow ─────────────────────────────────────────────────────────

    it('publish sets pendingPublishItem', () => {
        component.publish(sampleVersions[1]);
        expect(component.pendingPublishItem).toEqual(sampleVersions[1]);
    });

    it('confirmPublish calls publishReleaseNotes and shows success alert', () => {
        mockService.publishReleaseNotes.and.returnValue(of(true));
        component.pendingPublishItem = sampleVersions[1];
        component.confirmPublish();
        expect(mockService.publishReleaseNotes).toHaveBeenCalledWith({
            releaseversionno: '2.0',
            releasedate: jasmine.any(String)
        });
        expect(mockAlert.success).toHaveBeenCalledWith('Release Notes Published Successfully.');
        expect(component.pendingPublishItem).toBeNull();
    });

    it('confirmPublish shows error alert when service returns falsy', () => {
        mockService.publishReleaseNotes.and.returnValue(of(false));
        component.pendingPublishItem = sampleVersions[1];
        component.confirmPublish();
        expect(mockAlert.error).toHaveBeenCalledWith('Error in Publishing Release Notes.');
    });

    it('confirmPublish does nothing when pendingPublishItem is null', () => {
        component.pendingPublishItem = null;
        component.confirmPublish();
        expect(mockService.publishReleaseNotes).not.toHaveBeenCalled();
    });

    // ── Delete flow ──────────────────────────────────────────────────────────

    it('deleteVersion sets pendingDeleteItem', () => {
        component.deleteVersion(sampleVersions[0]);
        expect(component.pendingDeleteItem).toEqual(sampleVersions[0]);
    });

    it('confirmDelete calls deleteReleaseNotes and shows success alert', () => {
        mockService.deleteReleaseNotes.and.returnValue(of(true));
        component.pendingDeleteItem = sampleVersions[0];
        component.confirmDelete();
        expect(mockService.deleteReleaseNotes).toHaveBeenCalledWith({
            releaseversionno: '1.0',
            releasedate: jasmine.any(String)
        });
        expect(mockAlert.success).toHaveBeenCalledWith('Release Notes Deleted Successfully.');
        expect(component.pendingDeleteItem).toBeNull();
    });

    it('confirmDelete shows error alert when service returns falsy', () => {
        mockService.deleteReleaseNotes.and.returnValue(of(false));
        component.pendingDeleteItem = sampleVersions[0];
        component.confirmDelete();
        expect(mockAlert.error).toHaveBeenCalledWith('Error in Deleting Release Notes.');
    });

    it('confirmDelete does nothing when pendingDeleteItem is null', () => {
        component.pendingDeleteItem = null;
        component.confirmDelete();
        expect(mockService.deleteReleaseNotes).not.toHaveBeenCalled();
    });

    // ── Download ─────────────────────────────────────────────────────────────

    it('downloadReport sets downloadingItem then clears it on success', () => {
        const blob = new Blob(['data'], { type: 'application/pdf' });
        mockService.downloadReport.and.returnValue(of(blob));

        const link = jasmine.createSpyObj('link', ['click']);
        spyOn(document, 'createElement').and.returnValue(link as any);
        spyOn(document.body, 'appendChild');
        spyOn(document.body, 'removeChild');
        spyOn(window.URL, 'createObjectURL').and.returnValue('blob:url');

        component.downloadReport(sampleVersions[0], 'pdf');
        expect(component.downloadingItem).toBeNull();
        expect(link.click).toHaveBeenCalled();
        expect(link.download).toBe('Release_Notes_1.0.pdf');
    });

    it('downloadReport clears downloadingItem on error', () => {
        const { throwError } = require('rxjs');
        mockService.downloadReport.and.returnValue(throwError(() => new Error('fail')));
        component.downloadReport(sampleVersions[0], 'xlsx');
        expect(component.downloadingItem).toBeNull();
    });

    it('isDownloading returns true only for the matching item and doctype', () => {
        component.downloadingItem = { releaseversionno: '1.0', doctype: 'pdf' };
        expect(component.isDownloading(sampleVersions[0], 'pdf')).toBeTrue();
        expect(component.isDownloading(sampleVersions[0], 'xlsx')).toBeFalse();
        expect(component.isDownloading(sampleVersions[1], 'pdf')).toBeFalse();
    });

    // ── Role-based rendering ─────────────────────────────────────────────────

    it('shows upload button when releaseAdmin is true', () => {
        component.releaseAdmin = true;
        fixture.detectChanges();
        const btn = fixture.debugElement.query(By.css('button'));
        expect(btn).toBeTruthy();
        expect(btn.nativeElement.textContent).toContain('Upload Release Notes');
    });

    it('hides upload button when releaseAdmin is false', () => {
        component.releaseAdmin = false;
        fixture.detectChanges();
        const btns = fixture.debugElement.queryAll(By.css('button'));
        const uploadBtn = btns.find(b => b.nativeElement.textContent.includes('Upload Release Notes'));
        expect(uploadBtn).toBeFalsy();
    });
});

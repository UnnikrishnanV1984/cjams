import { waitForAsync, ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { of, throwError } from 'rxjs';
import { Workbook } from 'exceljs';
import { ReleaseNoteUploadComponent } from './upload.component';
import { ReleaseNoteService } from '..../../release-note.service
import { AlertService } from '../../../../@core/services';
import { NgxfUploaderService } from 'ngxf-uploader';

async function buildMinimalXlsxBuffer(): Promise<ArrayBuffer> {
    const wb = new Workbook();
    const stories = wb.addWorksheet('Stories');
    stories.addRow(['Story_Id', 'Title', 'Description', 'Support_Id', 'Document_Link', 'Raised_By']);
    stories.addRow(['S-1', 'Story Title', 'Story Desc', null, null, 'Dev Team']);
    const defects = wb.addWorksheet('Defects');
    defects.addRow(['Defect_Id', 'Title', 'Description', 'Support_Id', 'Document_Link']);
    defects.addRow(['D-1', 'Defect Title', 'Defect Desc', 'SUP-1', null]);
    const buffer = await wb.xlsx.writeBuffer();
    return buffer as ArrayBuffer;
}

describe('ReleaseNoteUploadComponent', () => {
    let component: ReleaseNoteUploadComponent;
    let fixture: ComponentFixture<ReleaseNoteUploadComponent>;
    let mockService: jasmine.SpyObj<ReleaseNoteService>;
    let mockAlert: jasmine.SpyObj<AlertService>;

    beforeEach(waitForAsync(() => {
        mockService = jasmine.createSpyObj('ReleaseNoteService', ['saveReleaseNotes']);
        mockAlert = jasmine.createSpyObj('AlertService', ['success', 'error']);

        (window as any).$ = () => ({ modal: jasmine.createSpy('modal') });

        TestBed.configureTestingModule({
            imports: [ReleaseNoteUploadComponent],
            providers: [
                { provide: ReleaseNoteService, useValue: mockService },
                { provide: AlertService, useValue: mockAlert },
                NgxfUploaderService
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ReleaseNoteUploadComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('creates the component', () => {
        expect(component).toBeTruthy();
    });

    it('has the expected modalId', () => {
        expect(component.modalId).toBe('release-upload');
    });

    // ── open / cancel ────────────────────────────────────────────────────────

    it('open shows the modal', () => {
        const modalSpy = jasmine.createSpy('modal');
        (window as any).$ = () => ({ modal: modalSpy });
        component.open();
        expect(modalSpy).toHaveBeenCalledWith('show');
    });

    it('open resets the form', () => {
        component.uploadForm.patchValue({ releasedate: '2024-01-01', releaseversion: '1.0' });
        component.open();
        expect(component.uploadForm.value.releasedate).toBeNull();
        expect(component.uploadForm.value.releaseversion).toBeNull();
    });

    it('cancel hides the modal', () => {
        const modalSpy = jasmine.createSpy('modal');
        (window as any).$ = () => ({ modal: modalSpy });
        component.cancel();
        expect(modalSpy).toHaveBeenCalledWith('hide');
    });

    it('cancel resets the form', () => {
        component.uploadForm.patchValue({ releasedate: '2024-01-01', releaseversion: '1.0' });
        component.cancel();
        expect(component.uploadForm.value.releasedate).toBeNull();
        expect(component.uploadForm.value.releaseversion).toBeNull();
    });

    // ── onFileSelected — guard ───────────────────────────────────────────────

    it('onFileSelected does nothing when event is not a File', async () => {
        await component.onFileSelected('not-a-file');
        expect(mockService.saveReleaseNotes).not.toHaveBeenCalled();
    });

    // ── onFileSelected — success ─────────────────────────────────────────────

    it('onFileSelected parses Stories and Defects worksheets and calls saveReleaseNotes', async () => {
        mockService.saveReleaseNotes.and.returnValue(of('Success'));
        component.uploadForm.patchValue({ releasedate: '2024-01-01', releaseversion: '1.0' });

        const buffer = await buildMinimalXlsxBuffer();
        const file = new File([buffer], 'release.xlsx');
        spyOn(file, 'arrayBuffer').and.returnValue(Promise.resolve(buffer));

        await component.onFileSelected(file);

        const itemlist: any[] = mockService.saveReleaseNotes.calls.mostRecent().args[0];
        expect(itemlist.length).toBe(2);

        const story = itemlist.find(i => i.Item_Type === 'Story');
        expect(story).toBeDefined();
        expect(story.Item_Id).toBe('S-1');
        expect(story.Title).toBe('Story Title');
        expect(story.Application).toBe('CW');
        expect(story.Raised_By).toBe('Dev Team');

        const defect = itemlist.find(i => i.Item_Type === 'Defect');
        expect(defect).toBeDefined();
        expect(defect.Item_Id).toBe('D-1');
        expect(defect.Support_Id).toBe('SUP-1');
        expect(defect.Raised_By).toBeNull();
    });

    it('onFileSelected shows success alert on Success response', async () => {
        mockService.saveReleaseNotes.and.returnValue(of('Success'));
        component.uploadForm.patchValue({ releasedate: '2024-01-01', releaseversion: '1.0' });

        const buffer = await buildMinimalXlsxBuffer();
        const file = new File([buffer], 'release.xlsx');
        spyOn(file, 'arrayBuffer').and.returnValue(Promise.resolve(buffer));

        await component.onFileSelected(file);
        expect(mockAlert.success).toHaveBeenCalledWith('Release Notes Uploaded Successfully.');
    });

    it('onFileSelected shows error alert on non-Success response', async () => {
        mockService.saveReleaseNotes.and.returnValue(of('Error'));
        component.uploadForm.patchValue({ releasedate: '2024-01-01', releaseversion: '1.0' });

        const buffer = await buildMinimalXlsxBuffer();
        const file = new File([buffer], 'release.xlsx');
        spyOn(file, 'arrayBuffer').and.returnValue(Promise.resolve(buffer));

        await component.onFileSelected(file);
        expect(mockAlert.error).toHaveBeenCalledWith('Error in Uploading Release Notes.');
    });

    it('onFileSelected emits uploadComplete after 4s delay', fakeAsync(async () => {
        mockService.saveReleaseNotes.and.returnValue(of('Success'));
        component.uploadForm.patchValue({ releasedate: '2024-01-01', releaseversion: '1.0' });

        const buffer = await buildMinimalXlsxBuffer();
        const file = new File([buffer], 'release.xlsx');
        spyOn(file, 'arrayBuffer').and.returnValue(Promise.resolve(buffer));

        let emitted = false;
        component.uploadComplete.subscribe(() => emitted = true);

        await component.onFileSelected(file);
        expect(emitted).toBeFalse();
        tick(4000);
        expect(emitted).toBeTrue();
    }));

    it('onFileSelected shows error alert on service error', async () => {
        mockService.saveReleaseNotes.and.returnValue(throwError(() => new Error('fail')));
        component.uploadForm.patchValue({ releasedate: '2024-01-01', releaseversion: '1.0' });

        const buffer = await buildMinimalXlsxBuffer();
        const file = new File([buffer], 'release.xlsx');
        spyOn(file, 'arrayBuffer').and.returnValue(Promise.resolve(buffer));

        await component.onFileSelected(file);
        expect(mockAlert.error).toHaveBeenCalled();
    });
});

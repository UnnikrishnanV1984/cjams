import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { By } from '@angular/platform-browser';

import { ReleaseNoteConfirmDialogComponent } from './confirm-dialog.component';

describe('ReleaseNoteConfirmDialogComponent', () => {
    let component: ReleaseNoteConfirmDialogComponent;
    let fixture: ComponentFixture<ReleaseNoteConfirmDialogComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
            imports: [ReleaseNoteConfirmDialogComponent]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ReleaseNoteConfirmDialogComponent);
        component = fixture.componentInstance;
        component.modalId = 'test-modal';
        component.title = 'Confirm?';
        component.message = 'Are you sure?';
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('renders the title and message from inputs', () => {
        const titleEl = fixture.debugElement.query(By.css('.modal-title'));
        const bodyEl = fixture.debugElement.query(By.css('.modal-body p'));
        expect(titleEl.nativeElement.textContent).toContain('Confirm?');
        expect(bodyEl.nativeElement.textContent).toContain('Are you sure?');
    });

    it('sets the modal id attribute from the modalId input', () => {
        const modal = fixture.debugElement.query(By.css('.modal'));
        expect(modal.nativeElement.id).toBe('test-modal');
    });

    it('emits confirmed when onConfirm() is called', () => {
        const spy = jasmine.createSpy('confirmed');
        component.confirmed.subscribe(spy);
        component.onConfirm();
        expect(spy).toHaveBeenCalledTimes(1);
    });

    it('emits cancelled when onCancel() is called', () => {
        const spy = jasmine.createSpy('cancelled');
        component.cancelled.subscribe(spy);
        component.onCancel();
        expect(spy).toHaveBeenCalledTimes(1);
    });

    it('emits confirmed when the Yes button is clicked', () => {
        const spy = jasmine.createSpy('confirmed');
        component.confirmed.subscribe(spy);
        const yesBtn = fixture.debugElement.queryAll(By.css('.modal-body button'))
            .find(b => b.nativeElement.textContent.trim() === 'Yes')!;
        yesBtn.nativeElement.click();
        expect(spy).toHaveBeenCalledTimes(1);
    });

    it('emits cancelled when the No button is clicked', () => {
        const spy = jasmine.createSpy('cancelled');
        component.cancelled.subscribe(spy);
        const noBtn = fixture.debugElement.queryAll(By.css('.modal-body button'))
            .find(b => b.nativeElement.textContent.trim() === 'No')!;
        noBtn.nativeElement.click();
        expect(spy).toHaveBeenCalledTimes(1);
    });
});

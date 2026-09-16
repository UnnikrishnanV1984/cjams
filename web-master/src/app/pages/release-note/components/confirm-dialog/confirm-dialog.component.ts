import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
    selector: 'release-note-confirm-dialog',
    templateUrl: './confirm-dialog.component.html',
    standalone: true,
    imports: [CommonModule]
})
export class ReleaseNoteConfirmDialogComponent {
    @Input() modalId!: string;
    @Input() title!: string;
    @Input() message!: string;
    @Output() confirmed = new EventEmitter<void>();
    @Output() cancelled = new EventEmitter<void>();

    onConfirm() {
        this.confirmed.emit();
    }

    onCancel() {
        this.cancelled.emit();
    }
}

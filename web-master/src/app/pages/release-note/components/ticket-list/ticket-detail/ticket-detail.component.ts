import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import moment from 'moment';
import { AlertService } from '../../../../../@core/services';
import { ReleaseNoteService } from '../../../release-note.service';

export const TICKET_MODAL_IDS = {
    supportLog: 'ticket-detail-support',
    editView:   'ticket-detail-view',
    jiraError:  'ticket-detail-jira-error'
} as const;

export const KW_TICKET_MODAL_IDS = {
    supportLog: 'kw-ticket-detail-support',
    editView:   'kw-ticket-detail-view',
    jiraError:  'kw-ticket-detail-jira-error'
} as const;

@Component({
    selector: 'ticket-detail',
    templateUrl: './ticket-detail.component.html',
    standalone: true,
    imports: [CommonModule, FormsModule, ReactiveFormsModule]
})
export class TicketDetailComponent implements OnChanges {
    @Input() ticketDetails: any = null;
    @Input() selectedRelease: any = null;
    @Input() releaseDate: any = null;
    @Input() releaseVersion: any = null;
    @Input() mode: 'view' | 'edit' = 'view';
    @Input() isValue: number = 0;
    @Input() releaseApprover: boolean = false;
    @Input() releaseAdmin: boolean = false;

    @Input() modalIdSupportLog: string = TICKET_MODAL_IDS.supportLog;
    @Input() modalIdEditView: string   = TICKET_MODAL_IDS.editView;
    @Input() modalIdJiraError: string  = TICKET_MODAL_IDS.jiraError;

    @Output() saved = new EventEmitter<void>();

    editForm!: FormGroup;

    constructor(
        private _fb: FormBuilder,
        private _service: ReleaseNoteService,
        private _alert: AlertService
    ) {
        this.editForm = this._fb.group({
            Defect: null,
            Title: null,
            Description: null,
            supportno: null,
            frommailid: null,
            documentlink: null
        });
    }

    ngOnChanges(changes: SimpleChanges) {
        if (changes['selectedRelease'] && this.selectedRelease) {
            this.editForm.patchValue({
                Defect:       this.selectedRelease.itemid,
                Title:        this.selectedRelease.title,
                Description:  this.selectedRelease.description,
                supportno:    this.selectedRelease.supportno,
                frommailid:   this.selectedRelease.frommailid,
                documentlink: this.selectedRelease.documentlink
            });
        }
        if (changes['mode']) {
            if (this.mode === 'edit') {
                this.editForm.enable();
            } else {
                this.editForm.disable();
            }
        }
    }

    getFormattedDate(dateValue: any): string {
        if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY HH:mm:ss', true).isValid()) {
            return moment(new Date(dateValue)).format('MM/DD/YYYY');
        }
        return '';
    }

    save() {
        this._service.editTicket({
            releasenotesid: this.selectedRelease?.releasenotesid,
            itemid:         this.editForm.value.Defect,
            title:          this.editForm.value.Title,
            description:    this.editForm.value.Description,
            supportno:      this.editForm.value.supportno,
            documentlink:   this.editForm.value.documentlink
        }).subscribe({
            next: (response: any) => {
                if (response) {
                    this._alert.success('Release details updated Successfully.');
                } else {
                    this._alert.error('Error in updating Release details.');
                }
                (<any>$('#' + this.modalIdEditView)).modal('hide');
                this.saved.emit();
            },
            error: () => {
                this._alert.error('An error occurred while saving. Please try again.');
                (<any>$('#' + this.modalIdEditView)).modal('hide');
            }
        });
    }
}

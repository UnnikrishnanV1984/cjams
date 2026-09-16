import { Component, Input, Output, EventEmitter, OnInit, OnChanges, SimpleChanges, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { AlertService } from '../../../../@core/services';
import { ReleaseNoteService, ReleaseVersion } from '../../release-note.service';
import { VersionFilter } from '../release-note-search/release-note-search.component';
import { ReleaseNoteConfirmDialogComponent } from '../confirm-dialog/confirm-dialog.component';
import { ReleaseNoteUploadComponent } from '../upload/upload.component';

@Component({
    selector: 'release-version-list',
    templateUrl: './release-version-list.component.html',
    standalone: true,
    imports: [
        CommonModule,
        FormsModule,
        PaginationModule,
        SortTableModule,
        ReleaseNoteConfirmDialogComponent,
        ReleaseNoteUploadComponent
    ]
})
export class ReleaseVersionListComponent implements OnInit, OnChanges {
    @Input() releaseApprover: boolean = false;
    @Input() releaseAdmin: boolean = false;
    @Input() filter: VersionFilter = { releaseversionno: null, startdate: null, enddate: null };

    @Output() openVersion = new EventEmitter<ReleaseVersion>();
    @Output() firstVersionLoaded = new EventEmitter<ReleaseVersion | null>();
    @Output() filterCleared = new EventEmitter<void>();

    @ViewChild('uploadComponent') uploadComponent!: ReleaseNoteUploadComponent;

    versions: ReleaseVersion[] = [];
    totalRecords: number = 0;
    paginationInfo: PaginationInfo = new PaginationInfo();

    downloadingItem: { releaseversionno: string; doctype: string } | null = null;
    pendingPublishItem: ReleaseVersion | null = null;
    pendingDeleteItem: ReleaseVersion | null = null;

    private _initialLoad = true;

    constructor(
        private _service: ReleaseNoteService,
        private _alert: AlertService
    ) {
        this.paginationInfo.pageSize = 10;
    }

    ngOnInit() {
        this.loadVersions();
    }

    ngOnChanges(changes: SimpleChanges) {
        if (changes['filter'] && !changes['filter'].firstChange) {
            this.paginationInfo.pageNumber = 1;
            this.loadVersions();
        }
    }

    loadVersions() {
        this._service.getReleaseVersions(
            {
                startdate: this.filter?.startdate ?? null,
                enddate: this.filter?.enddate ?? null,
                releaseversion: this.filter?.releaseversionno ?? null,
                sortcolumn: this.paginationInfo.sortColumn,
                sortorder: this.paginationInfo.sortBy
            },
            this.paginationInfo.pageNumber,
            this.paginationInfo.pageSize
        ).subscribe({
            next: (response: any) => {
                const result: ReleaseVersion[] = Array.isArray(response)
                    ? response
                    : (response?.data ?? []);
                this.totalRecords = result.length > 0 && result[0].totalcount ? result[0].totalcount : 0;
                this.versions = result;
                if (this._initialLoad) {
                    this._initialLoad = false;
                    this.firstVersionLoaded.emit(this.versions[0] ?? null);
                }
            },
            error: (err: any) => {
                this._alert.error('Failed to load release versions. Please try again.');
            }
        });
    }

    onUploadComplete() {
        this.paginationInfo.pageNumber = 1;
        this.filterCleared.emit();
        // this.loadVersions();     // <--duplicate call, the filterCleared.emit should lead to ngonchange running this function
    }

    onSorted(event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = event.sortDirection;
        this.paginationInfo.sortColumn = event.sortColumn;
        this.paginationInfo.pageNumber = 1;
        this.loadVersions();
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.loadVersions();
    }

    // ── Publish ───────────────────────────────────────────────────────────────

    publish(item: ReleaseVersion) {
        this.pendingPublishItem = item;
        (<any>$('#publish-confirmation')).modal('show');
    }

    confirmPublish() {
        if (!this.pendingPublishItem) return;
        this._service.publishReleaseNotes({
            releaseversionno: this.pendingPublishItem.releaseversionno,
            releasedate: this.pendingPublishItem.releasedate
        }).subscribe((response: any) => {
            if (response) {
                this._alert.success('Release Notes Published Successfully.');
            } else {
                this._alert.error('Error in Publishing Release Notes.');
            }
            this.pendingPublishItem = null;
            (<any>$('#publish-confirmation')).modal('hide');
            this.loadVersions();
        });
    }

    // ── Delete ────────────────────────────────────────────────────────────────

    deleteVersion(item: ReleaseVersion) {
        this.pendingDeleteItem = item;
        (<any>$('#delete-confirmation')).modal('show');
    }

    confirmDelete() {
        if (!this.pendingDeleteItem) return;
        this._service.deleteReleaseNotes({
            releaseversionno: this.pendingDeleteItem.releaseversionno,
            releasedate: this.pendingDeleteItem.releasedate
        }).subscribe((response: any) => {
            if (response) {
                this._alert.success('Release Notes Deleted Successfully.');
            } else {
                this._alert.error('Error in Deleting Release Notes.');
            }
            this.pendingDeleteItem = null;
            (<any>$('#delete-confirmation')).modal('hide');
            this.loadVersions();
        });
    }

    // ── Download ──────────────────────────────────────────────────────────────

    downloadReport(item: ReleaseVersion, doctype: string) {
        this.downloadingItem = { releaseversionno: item.releaseversionno, doctype };
        this._service.downloadReport(item.releaseversionno, item.releasedate, doctype).subscribe({
            next: (res: any) => {
                const mimeType = doctype === 'pdf'
                    ? 'application/pdf'
                    : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
                const blob = new Blob([res], { type: mimeType });
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = `Release_Notes_${item.releaseversionno}.${doctype}`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                URL.revokeObjectURL(link.href);
                this.downloadingItem = null;
            },
            error: () => { this.downloadingItem = null; }
        });
    }

    isDownloading(item: ReleaseVersion, doctype: string): boolean {
        return this.downloadingItem?.releaseversionno === item.releaseversionno
            && this.downloadingItem?.doctype === doctype;
    }
}

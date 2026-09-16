import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTooltipModule } from '@angular/material/tooltip';
import { KeywordSearchState } from '../../release-note.service';

export interface VersionFilter {
    releaseversionno: string | null;
    startdate: string | null;
    enddate: string | null;
}

@Component({
    selector: 'release-note-search',
    templateUrl: './release-note-search.component.html',
    standalone: true,
    imports: [
        CommonModule,
        FormsModule,
        MatFormFieldModule,
        MatInputModule,
        MatTooltipModule
    ]
})
export class ReleaseNoteSearchComponent {
    @Input() kwState!: KeywordSearchState;

    @Output() versionSearch = new EventEmitter<VersionFilter>();
    @Output() versionCleared = new EventEmitter<void>();
    @Output() keywordSearch = new EventEmitter<{ term: string; itemtype: string }>();
    @Output() keywordCleared = new EventEmitter<void>();

    // Version filter state
    releaseversionno: string | null = null;
    startdate: string | null = null;
    enddate: string | null = null;

    // Keyword filter state
    keywordTerm: string = '';
    itemtype: string = 'both';

    onVersionSearch() {
        this.versionSearch.emit({
            releaseversionno: this.releaseversionno,
            startdate: this.startdate,
            enddate: this.enddate
        });
    }

    onVersionClear() {
        this.releaseversionno = null;
        this.startdate = null;
        this.enddate = null;
        this.versionCleared.emit();
    }

    onKeywordSearch() {
        const term = this.keywordTerm?.trim();
        if (!term) return;
        this.keywordSearch.emit({ term, itemtype: this.itemtype });
    }

    onKeywordClear() {
        this.keywordTerm = '';
        this.itemtype = 'both';
        this.keywordCleared.emit();
    }
}

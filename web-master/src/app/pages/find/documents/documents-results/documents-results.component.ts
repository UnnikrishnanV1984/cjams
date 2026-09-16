import { Component, Input } from '@angular/core';
import { Observable, Subject } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { DocumentsResultsEntity, DocumentsSearchEntity } from '../../_entities/find-entity.module';

@Component({
    selector: 'documents-results',
    templateUrl: './documents-results.component.html',
    styleUrls: ['./documents-results.component.scss'],
    standalone: false
})
export class DocumentsResultsComponent {

    @Input()
    resultsPageNumber$!: Subject<number>;
    @Input()
    resultsDocumentsList$!: Observable<DocumentsSearchEntity[]>;
    @Input()
    resultsTotalRecords$!: Observable<number>;
    @Input() showResult: boolean;
    @Input() showView: boolean;

    subDocumentSubject$: Subject<{ id: DocumentsResultsEntity, show: boolean }>;
    paginationInfo: PaginationInfo = new PaginationInfo();

    constructor() {
        this.subDocumentSubject$ = new Subject<{ id: DocumentsResultsEntity, show: boolean }>();
        this.showResult = false;
        this.showView = false;
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.resultsPageNumber$.next(event.page);
        const docViewParam = {
            id: new DocumentsResultsEntity,
            show: false
        };
        this.subDocumentSubject$.next(docViewParam);
    }

    selectDocument(id: any) {
        const docViewParam = {
            id: id,
            show: true
        };
        this.subDocumentSubject$.next(docViewParam);
    }
}

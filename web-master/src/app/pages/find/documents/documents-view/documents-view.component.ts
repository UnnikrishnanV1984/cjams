
import {share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { DocumentsResultsEntity, DocumentsViewEntity } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

declare let $: any;

@Component({
    selector: 'documents-view',
    templateUrl: './documents-view.component.html',
    styleUrls: ['./documents-view.component.scss'],
    standalone: false
})
export class DocumentsViewComponent implements OnInit {

    @Input() documentSubject$!: Subject<{ id: DocumentsResultsEntity, show: boolean }>;
    // @Input() showView: boolean;
    subDocument$: Observable<DocumentsViewEntity>;
    document: DocumentsResultsEntity;
    id!: string;
    showView = false;

    constructor(private _service: CommonHttpService) {
        this.document = new DocumentsResultsEntity();
        this.subDocument$ = new Observable<DocumentsViewEntity>();
        this.showView = false;
    }

    ngOnInit() {
        this.documentSubject$.subscribe(data => {
            this.showView = data.show;
            this.document = data.id;
            this.id = this.document.documentpropertyid;
            this.getSubDocument();
        });
    }

    showDocumentViewModel() {
        $('#modal-view-documents').modal('show');
    }

    getSubDocument() {
        const url = FindUrlConfig.EndPoint.Documents.documentDetailUrl;
        this.subDocument$ = this._service.getArrayList(
            {
                include: 'Userprofile',
                where: {
                    documentpropertiesid: this.id
                },
                method: 'get'
            }
            , url).pipe(map(data => {
                if (data.length > 0) {
                    return new DocumentsViewEntity(data[0]);
                } else {
                    return new DocumentsViewEntity();
                }
            }),share(),);
    }
}

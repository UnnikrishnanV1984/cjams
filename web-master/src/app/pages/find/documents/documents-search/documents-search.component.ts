
import {share, map, pluck} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { BsDatepickerConfig } from 'ngx-bootstrap/datepicker';
import { Observable, Subject } from 'rxjs';

import { ObjectUtils } from '../../../../@core/common/initializer';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services';
import { DocumentsSearchEntity, DocumentType } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';


@Component({
    selector: 'documents-search',
    templateUrl: './documents-search.component.html',
    styleUrls: ['./documents-search.component.scss'],
    standalone: false
})
export class DocumentsSearchComponent implements OnInit {
    @Input()
    searchDocumentsList$!: Subject<Observable<DocumentsSearchEntity[]>>;
    @Input()
    searchTotalRecords$!: Subject<Observable<number>>;
    @Input()
    searchPageNumber$!: Subject<number>;

    documentsFormGroup: FormGroup;
    documentsSearchEntity: DocumentsSearchEntity;

    documentTypeCheckBoxItems$: Observable<DocumentType[]>;
    documentTypeArray!: string[];
    createdByArray!: string[];

    // datepicker
    minDate = new Date();
    colorTheme = 'theme-blue';
    bsConfig!: Partial<BsDatepickerConfig>;

    constructor(private _service: GenericService<DocumentsSearchEntity>,
        private formBuilder: FormBuilder) {
        this.documentTypeCheckBoxItems$ = new Observable<DocumentType[]>();
        this.documentsSearchEntity = new DocumentsSearchEntity();
        this._service.endpointUrl = FindUrlConfig.EndPoint.Documents.documentsSearchUrl;
        this.documentsFormGroup = this.formBuilder.group({
            documenttype: [''],
            receivedfrom: [''],
            receivedto: [''],
            assigned: [''],
            documentidentifer: [''],
            notificationattachments: [''],
            librarydocument: [''],
            mergetemplatedocument: [''],
            attachment: [''],
            formdocument: [''],
            createdbymine: [''],
            createdbymyteam: [''],
            createdby: ['']
        }, { validators: [ this.checkDateRange ] });
    }

    ngOnInit() {
        this.searchPageNumber$.subscribe(pageNumber => {
            this.searchDocuments(pageNumber, this.documentsSearchEntity);
        });
        this.getDocumentTypeList();
        this.documentTypeArray = [];
        this.createdByArray = [];
        this.bsConfig = Object.assign({}, { containerClass: this.colorTheme, maxDate: new Date() });
    }

    getDocumentTypeList() {
        this.documentTypeCheckBoxItems$ = this._service.getArrayList({}, FindUrlConfig.EndPoint.Documents.documentTypeUrl).pipe(map(data => {
            return data.map(res => new DocumentType({ value: res.documenttypekey }));
        }));

    }

    onDocumentTypeCheckBoxChange(value: string, event: Event) {
        const isChecked = (event.target as HTMLInputElement).checked;
        if (isChecked) {
            this.documentTypeArray.push(value);
        } else {
            this.documentTypeArray.splice(this.documentTypeArray.indexOf(value), 1);
        }
    }

    onCreatedByCheckBoxChange(event: Event) {
        const isChecked = (event.target as HTMLInputElement).checked;
        const value = (event.target as HTMLInputElement).value;
        if (isChecked) {
            this.createdByArray.push(value);
        } else {
            this.createdByArray.splice(this.createdByArray.indexOf(value), 1);
        }
    }

    searchDocuments(pageNumber: number, model: DocumentsSearchEntity) {
        this.documentsSearchEntity = model;
        ObjectUtils.removeEmptyProperties(this.documentsSearchEntity);
        if (this.createdByArray.length) {
            this.documentsSearchEntity.assigned = this.createdByArray;
        }
        if (this.documentTypeArray.length) {
            this.documentsSearchEntity.doctype = this.documentTypeArray;
        }
        const source = this._service.getPagedArrayList(new PaginationRequest({
            limit: 10,
            page: pageNumber,
            where: this.documentsSearchEntity,
            method: 'post'
        })).pipe(share());
        this.searchDocumentsList$.next(source.pipe(pluck('data')));
        if (pageNumber === 1) {
            this.searchTotalRecords$.next(source.pipe(pluck('count')));
        }
    }

    checkDateRange(group: FormGroup) {
        if (group.controls.receivedto.value) {
            if (group.controls.receivedto.value < group.controls.receivedfrom.value) {
                return { notValid: true };
            }
            return null;
        }
    }
}

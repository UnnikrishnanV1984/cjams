
import {EMPTY, merge, Observable ,  Subject } from 'rxjs';

import {startWith, mergeMap, map, share, pluck, debounceTime} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

import { DynamicObject, PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DocDetail } from '../../_entities/daconfig.data.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'doc-details',
    templateUrl: './doc-details.component.html',
    standalone: false
})
export class DocDetailsComponent implements OnInit {
    docDetailsType!: DocDetail;
    docDetailForm!: FormGroup;
    findFilterStateForm!: FormGroup;
    docDetailsType$!: Observable<any>;
    docDetailsTypes$!: Observable<DocDetail[]>;
    docDetailsTypesList$!: Observable<DocDetail[]>;
    findFilterStateDetails$!: Observable<DocDetail[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    selectedDocDetail = new DocDetail();
    formGroup!: FormGroup;
    componentConfig = {
        listShow: false,
        isEditMode: false,
        selectedDeficiency: ''
    };
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    private docmodal!: DocDetail;
    deletepopupid = '#delete-popup';
    constructor(private formBuilder: FormBuilder, private _service: GenericService<DocDetail>) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.GetDocDetailsUrl;
    }
    ngOnInit() {
        this.docDetailForm = this.formBuilder.group({
            questionname: [''],
            questiontext: ['']
        });
        this.findFilterStateForm = this.formBuilder.group({
            filterStateSearch: ['']
        });
        this.paginationInfo.sortBy = 'entityroletypekey asc';
        this.getPage();
    }
    getPage() {
        const pageSource = this.pageStream$.pipe(map((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObject, page: pageNumber };
        }));

        const searchSource = this.searchTermStream$.pipe(debounceTime(1000),map((searchTerm) => {
            this.dynamicObject = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);

        const source = merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObject,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                return this._service
                    .getPagedArrayList(
                        new PaginationRequest({
                            limit: this.paginationInfo.pageSize,
                            page: this.paginationInfo.pageNumber,
                            count: this.paginationInfo.total,
                            method: 'post'
                        })
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.docDetailsType$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    editListItem(modal: DocDetail) {
        this.docDetailsTypesList$ = EMPTY;
        this.findFilterStateForm.reset();
        this.selectedDocDetail = Object.assign({});
        this.docmodal = modal;
        const source = this._service
            .getPagedArrayList(
                {
                    limit: this.paginationInfo.pageSize,
                    order: 'questionname asc',
                    page: this.paginationInfo.pageNumber,
                    include: 'statestatutes',
                    where: {
                        servicerequesttypeconfigroleid: modal.servicerequesttypeconfigroleid,
                        activeflag: 1
                    },
                    method: 'get'
                },
                AdminUrlConfig.EndPoint.DAConfig.ProviderAgreementDocumentRuleConfigUrl + '/list?filter'
            ).pipe(
            map((result) => {
                return { data: result.data, count: result.count };
            }),
            share(),);
        this.docDetailsTypes$ = source.pipe(pluck('data'));
    }
    findFilterStateDetails() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.GetStateStatuteSearchUrl;
        const source = this._service
            .getPagedArrayList(
                {
                    limit: this.paginationInfo.pageSize,
                    page: this.paginationInfo.pageNumber,
                    where: { name: this.findFilterStateForm.value.filterStateSearch },
                    method: 'get'
                },
                AdminUrlConfig.EndPoint.DAConfig.GetStateStatuteSearchUrl + '/list?filter'
            ).pipe(
            map((result) => {
                return { data: result.data, count: result.count };
            }),
            share(),);
        this.docDetailsTypesList$ = source.pipe(pluck('data'));
    }
    selectDeficiency() {
        this.componentConfig.listShow = !this.componentConfig.listShow;
    }
    saveItem(modal: DocDetail) {
        modal = Object.assign(new DocDetail(), modal);
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ProviderAgreementDocumentRuleConfigUrl;
        modal.servicerequesttypeconfigroleid = this.docmodal.servicerequesttypeconfigroleid;
        modal.questionname = this.docDetailForm.value.questionname;
        modal.questiontext = this.docDetailForm.value.questiontext;
        if (this.selectedDocDetail.provideragreementdocumentruleconfigid) {
            this._service.patch(this.selectedDocDetail.provideragreementdocumentruleconfigid, modal).subscribe((response: any) => {
                    this.editListItem(this.docmodal);
                    this.selectedDocDetail = Object.assign(new DocDetail(), {});
                },
                (_error: any) => {
                    // No content to add or call
                }
            );
        } else {
            modal.activeflag = 1;
            modal.sequencenumber = 0;
            modal.statestatutesid = this.selectedDocDetail.statestatutesid;
            modal.statestatuteskey = this.selectedDocDetail.statestatuteskey;
            modal.servicerequesttypeconfigroleid = this.docmodal.servicerequesttypeconfigroleid;
            this._service.create(modal).subscribe(
                (response: any) => {
                    this.editListItem(this.docmodal);
                    this.selectedDocDetail = Object.assign(new DocDetail(), {});
                    this.paginationInfo.sortBy = 'insertedon desc';
                    this.pageStream$.next(1);
                    this.docDetailForm.patchValue({
                        nameSearch: this.docDetailsType.name
                    });
                },
                (_error: any) => {
                    // No content to add or call
                }
            );
        }
        this.findFilterStateDetails();
        this.docDetailForm.reset();
    }

    editItem(data: DocDetail) {
        this.selectedDocDetail = Object.assign({}, data);
        this.docDetailForm.setValue({
            questionname: data.questionname,
            questiontext: data.questiontext
        });
    }
    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    deleteItem() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ProviderAgreementDocumentRuleConfigUrl;
        if(this.docDetailsType.provideragreementdocumentruleconfigid) {
            this._service
                .patch(this.docDetailsType.provideragreementdocumentruleconfigid, {
                    activeflag: 0,
                    questionname: this.docDetailsType.questionname,
                    questiontext: this.docDetailsType.questiontext
                })
                .subscribe(
                    (_response: any) => {
                        this.editListItem(this.docmodal);
                        (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
                    },
                    (_error: any) => {
                        // No content to add or call
                    }
                );
        }
    }
    declineDelete() {
        (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
    }
    confirmDelete(modal: DocDetail) {
        this.docDetailsType = modal;
        (<any>$(this.deletepopupid)).modal('show'); // NOSONAR
        this.docDetailForm.reset();
    }
    selectDocDetail(modal: any) {
        this.selectedDocDetail.statestatutes = Object.assign({}, modal);
        this.selectedDocDetail = Object.assign(this.selectedDocDetail, modal);
        this.componentConfig.listShow = false;
    }
    clearForm() {
        this.docDetailForm.reset();
        (<any>$('#doc-details-edit')).modal('hide'); // NOSONAR
    }
    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObject[field] = { like: value };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }
}

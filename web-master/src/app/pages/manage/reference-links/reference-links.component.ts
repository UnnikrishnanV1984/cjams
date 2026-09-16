
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable ,  Subject, merge } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { AlertService } from '../../../@core/services';
import { GenericService } from '../../../@core/services/generic.service';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { ReferenceLinkConfig } from '../_entities/manage.data.models';
import { ManageUrlConfig } from '../manage-url.config';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'reference-links',
    templateUrl: './reference-links.component.html',
    styleUrls: ['./reference-links.component.scss'],
    standalone: false
})
export class ReferenceLinksComponent implements OnInit {
    addEditLabel!: string;
    referenceLinkForm: FormGroup;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    referenceLink$!: Observable<ReferenceLinkConfig[]>;
    referenceLink!: ReferenceLinkConfig;
    paginationInfo: PaginationInfo = new PaginationInfo();
    referenceLinkModelData = new ReferenceLinkConfig();
    createButton = true;
    private pageSubject$ = new Subject<number>();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    deletepopupid = '#delete-popup';
    constructor(private formBuilder: FormBuilder, private _service: GenericService<ReferenceLinkConfig>, private _alertService: AlertService) {
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.ReferenceLink;
        this.referenceLinkForm = this.formBuilder.group(
            {
                name: ['', Validators.required],
                links: ['', Validators.required]
            },
            { validators: this.urlValidator }
        );
    }
    ngOnInit() {
        this.paginationInfo.sortBy = 'name asc';
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

        const source = merge(searchSource, pageSource).pipe(
            startWith({
                search: this.dynamicObject,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                return this._service
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            page: params.page,
                            order: this.paginationInfo.sortBy,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        ManageUrlConfig.EndPoint.Manage.ReferenceLink + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.referenceLink$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    saveLink() {
        this.referenceLinkModelData.name = this.referenceLinkForm.value.name;
        this.referenceLinkModelData.links = this.referenceLinkForm.value.links;
        if (this.referenceLinkModelData.configurablelinksid) {
            this.referenceLinkModelData.updatedby = 'Default';
            this._service.update(this.referenceLinkModelData.configurablelinksid, this.referenceLinkModelData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Reference link saved successfully!');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $('#myModal-add-edit-links').modal('hide');
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this.referenceLinkModelData.activeflag = 1;
            this.referenceLinkModelData.effectivedate = new Date();
            this._service.create(this.referenceLinkModelData).subscribe(
                (response: any) => {
                    if (response.configurablelinksid) {
                        this._alertService.success('Reference Link saved Successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        $('#myModal-add-edit-links').modal('hide');
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    editLink(data: ReferenceLinkConfig) {
        this.changeModelLabel('Edit Link');
        this.referenceLinkModelData = Object.assign({}, data);
        this.referenceLinkForm.setValue({
            name: this.referenceLinkModelData.name,
            links: this.referenceLinkModelData.links
        });
    }
    deleteLink() {
        this._service.remove(this.referenceLink.configurablelinksid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Reference link deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide'); 
                }
            },
            (error) => {
                $(this.deletepopupid).modal('hide'); 
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    declineDelete() { /* //NOSONAR */
    }
    confirmDelete(requestData: ReferenceLinkConfig) {
        this.referenceLink = requestData;
        $(this.deletepopupid).modal('show'); 
    }
    urlValidator(group: FormGroup) {
        if (group.controls.links.value !== '' && group.controls.links.value !== null) {
            if (group.controls.links.value.match(/^((ftp|http[s]?):\/\/)?(www\.)([a-z0-9]+)\.[a-z]{2,5}(\.[a-z]{2})?$/)) {
                return null;
            } else {
                return { invalidURL: true };
            }
        }
    }
    inValidUrl(url: any) {
        const check = url.substring(0, 4);
        if (check === 'http') {
            window.open(url);
        } else {
            window.open('//' + url);
        }
    }
    changeModelLabel(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add Links') {
            this.referenceLinkForm.reset();
            this.referenceLinkModelData = Object.assign({}, new ReferenceLinkConfig());
        }
    }
    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }

    getControlByIndexFn(index: string): FormControl {
        return this.referenceLinkForm.controls[index] as FormControl;
    }
}

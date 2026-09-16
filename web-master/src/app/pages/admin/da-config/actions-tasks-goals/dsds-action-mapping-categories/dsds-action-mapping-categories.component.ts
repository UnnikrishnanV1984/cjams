
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DsdsActionMappingCateg } from '../../_entities/daconfig.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-action-mapping-categories',
    templateUrl: './dsds-action-mapping-categories.component.html',
    standalone: false
})
export class DsdsActionMappingCategoriesComponent implements OnInit {
    addEditLabel!: string;
    actionMappingCategFormGroup: FormGroup;
    dsdsActionMappingCateg$!: Observable<DsdsActionMappingCateg[]>;
    canDisplayPager$!: Observable<boolean>;
    actionMappingCategData!: DsdsActionMappingCateg;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private dynamicObject: DynamicObject = {
        activitytypekey: 'Investigation',
        activeflag: 1
    };
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    deletepopupid = '#delete-popup';
    constructor(private _actionMappingCategService: GenericService<DsdsActionMappingCateg>, private _alertService: AlertService, private formBuilder: FormBuilder) {
        this._actionMappingCategService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmactivityUrl;
        this.actionMappingCategFormGroup = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
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

        const source = merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObject,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                return this._actionMappingCategService
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            where: this.dynamicObject,
                            method: 'get'
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AmactivityUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.dsdsActionMappingCateg$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    changeModelLabel(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add') {
            this.actionMappingCategFormGroup.reset();
            this.actionMappingCategData = Object.assign({});
        }
    }
    editActionMappingCateg(modelData: any) {
        this.changeModelLabel('Edit');
        this.actionMappingCategData = Object.assign({}, modelData);
        this.actionMappingCategFormGroup.setValue({
            name: this.actionMappingCategData.name,
            description: this.actionMappingCategData.description
        });
    }
    saveItem() {
        this.actionMappingCategData.name = this.actionMappingCategFormGroup.value.name;
        this.actionMappingCategData.description = this.actionMappingCategFormGroup.value.description;
        this.actionMappingCategData.activitytypekey = 'Investigation';
        this.actionMappingCategData.activeflag = 1;
        this.actionMappingCategData.effectivedate = new Date();
        if (this.actionMappingCategData.amactivityid) {
            this._actionMappingCategService.update(this.actionMappingCategData.amactivityid, this.actionMappingCategData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Activity category saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $('#myModal-action-mapping-categories-add-edit').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._actionMappingCategService.create(this.actionMappingCategData).subscribe(
                (response: any) => {
                    if (response.amactivityid) {
                        this._alertService.success('Activity category saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        $('#myModal-action-mapping-categories-add-edit').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    confirmDelete(modelData: DsdsActionMappingCateg) {
        this.actionMappingCategData = Object.assign({}, modelData);
        $(this.deletepopupid).modal('show');
    }

    deleteItem() {
        this._actionMappingCategService.remove(this.actionMappingCategData.amactivityid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Activity category deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                }
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                $(this.deletepopupid).modal('hide');
            }
        );
    }

    clearItem() {
        this.actionMappingCategFormGroup.reset();
        this.actionMappingCategData = Object.assign({}, new DsdsActionMappingCateg());
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

    get nameControl(): FormControl { 
        return this.actionMappingCategFormGroup.get('name') as FormControl; 
    }
    
    get descriptionControl(): FormControl { 
        return this.actionMappingCategFormGroup.get('description') as FormControl; 
    }
}

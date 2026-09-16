
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DsdsActionTypeConfig } from './../../_entities/daconfig.data.models';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-action-tasks',
    templateUrl: './dsds-action-tasks.component.html',
    standalone: false
})
export class DsdsActionTasksComponent implements OnInit {
    addEditLabel!: string;
    actionTasksFormGroup: FormGroup;
    totalRecords$!: Observable<number>;
    dsdsActionTasksTypes$!: Observable<DsdsActionTypeConfig[]>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    actionTasksData: DsdsActionTypeConfig = new DsdsActionTypeConfig();
    actionTasksDataCreate: DsdsActionTypeConfig = new DsdsActionTypeConfig();
    private dynamicObject: DynamicObject = {
        activitytypekey: 'Investigation',
        activeflag: 1
    };
    deletepopupid = '#delete-popup';
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(private _actionTasksService: GenericService<DsdsActionTypeConfig>, private _alertService: AlertService, private formBuilder: FormBuilder) {
        this._actionTasksService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmtaskUrl;
        this.actionTasksFormGroup = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'name asc';
        this.getPage();
    }

    private getPage() {
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
                return this._actionTasksService
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            where: this.dynamicObject,
                            method: 'get'
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AmtaskUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return {
                            data: result.data.map((model) => new DsdsActionTypeConfig(model)),
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),
            share(),);

        this.dsdsActionTasksTypes$ = source.pipe(pluck('data'));
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
            this.actionTasksFormGroup.reset();
            this.actionTasksData = Object.assign({});
        }
    }

    editActionTasks(modelData: any) {
        this.actionTasksData = Object.assign({}, modelData);
        this.changeModelLabel('Edit');
        this.actionTasksFormGroup.setValue({
            name: this.actionTasksData.name,
            description: this.actionTasksData.description
        });
    }

    saveItem() {
        this.actionTasksData.name = this.actionTasksFormGroup.value.name;
        this.actionTasksData.description = this.actionTasksFormGroup.value.description;

        this.actionTasksData.activitytypekey = 'Investigation';
        this.actionTasksData.activeflag = 1;
        this.actionTasksData.effectivedate = new Date();
        if (this.actionTasksData.amtaskid) {
            this._actionTasksService.update(this.actionTasksData.amtaskid, this.actionTasksData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Activity task saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $('#myModal-action-tasks-add-edit').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._actionTasksService.create(this.actionTasksData).subscribe(
                (response: any) => {
                    if (response.amtaskid) {
                        this._alertService.success('Activity task saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        $('#myModal-action-tasks-add-edit').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    confirmDelete(modelData: DsdsActionTypeConfig) {
        this.actionTasksData = Object.assign({}, modelData);
        $(this.deletepopupid).modal('show');
    }

    deleteItem() {
        this._actionTasksService.remove(this.actionTasksData.amtaskid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Activity task deleted successfully');
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
        this.actionTasksFormGroup.reset();
        this.actionTasksData = Object.assign({}, new DsdsActionTypeConfig());
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
        return this.actionTasksFormGroup.get('name') as FormControl; 
    }
    
    get descriptionControl(): FormControl { 
        return this.actionTasksFormGroup.get('description') as FormControl; 
    }
}


import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { AllegationTasks } from '../../_entities/daconfig.data.models';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'allegation-tasks',
    templateUrl: './allegation-tasks.component.html',
    standalone: false
})
export class AllegationTasksComponent implements OnInit {
    labelAddEdit!: string;
    tasksForm: FormGroup;
    allegationTasks$!: Observable<AllegationTasks[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    allegationTasksData = new AllegationTasks();
    paginationInfo: PaginationInfo = new PaginationInfo();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(private formBuilder: FormBuilder, private _serviceTasks: GenericService<AllegationTasks>, private _alertService: AlertService) {
        this._serviceTasks.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmtaskUrl;
        this.tasksForm = this.formBuilder.group({
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
                return this._serviceTasks
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AmtaskUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.allegationTasks$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem() {
        this.allegationTasksData.name = this.tasksForm.value.name;
        this.allegationTasksData.description = this.tasksForm.value.description;
        this.allegationTasksData.effectivedate = new Date();
        this.allegationTasksData.activeflag = 1;
        this.allegationTasksData.activitytypekey = 'Allegation';
        if (this.allegationTasksData.amtaskid) {
            this._serviceTasks.update(this.allegationTasksData.amtaskid, this.allegationTasksData).subscribe(
                (_response: any) => {
                    this._alertService.success('Allegation task saved successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $('#myModal-allegation-task-add').modal('hide');
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._serviceTasks.create(this.allegationTasksData).subscribe(
                (_response: any) => {
                    this._alertService.success('Allegation task saved successfully');
                    this.paginationInfo.sortBy = 'insertedon desc';
                    this.pageStream$.next(1);
                    $('#myModal-allegation-task-add').modal('hide');
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    editItem(task: any) {
        this.changeModelLabel('Edit');
        this.allegationTasksData = Object.assign({}, task);
        this.tasksForm.setValue({
            name: this.allegationTasksData.name,
            description: this.allegationTasksData.description
        });
    }
    changeModelLabel(addEdit: any) {
        this.labelAddEdit = addEdit;
        if (addEdit === 'Add') {
            this.clearItems();
            this.allegationTasksData = Object.assign({}, new AllegationTasks());
        }
    }

    deleteItem() {
        this._serviceTasks.remove(this.allegationTasksData.amtaskid).subscribe(
            (response) => {
                this._alertService.success('Allegation task deleted successfully');
                this.pageStream$.next(this.paginationInfo.pageNumber);
                this.declineDelete();
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    clearItems() {
        this.tasksForm.reset();
    }
    declineDelete() {
        $('#delete-popup').modal('hide');
    }

    confirmDelete(task: AllegationTasks) {
        this.allegationTasksData = task;
        $('#delete-popup').modal('show');
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
}

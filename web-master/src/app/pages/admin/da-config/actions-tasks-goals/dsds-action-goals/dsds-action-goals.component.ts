
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DsdsActionGols } from '../../_entities/daconfig.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-action-goals',
    templateUrl: './dsds-action-goals.component.html',
    standalone: false
})
export class DsdsActionGoalsComponent implements OnInit {
    addEditLabel!: string;
    actionGoalsFormGroup: FormGroup;
    actionGoalData!: DsdsActionGols;
    canDisplayPager$!: Observable<boolean>;
    dsdsActionGols$!: Observable<DsdsActionGols[]>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private dynamicObject: DynamicObject = {
        activitytypekey: 'Investigation',
        activeflag: 1
    };
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    deletepopupid = '#delete-popup';
    constructor(private _actionGoalsService: GenericService<DsdsActionGols>, private _alertService: AlertService, private formBuilder: FormBuilder) {
        this._actionGoalsService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmgoalUrl;
        this.actionGoalsFormGroup = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'name asc ';
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
                return this._actionGoalsService
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            where: this.dynamicObject,
                            method: 'get'
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AmgoalUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.dsdsActionGols$ = source.pipe(pluck('data'));
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

    changeModelLabel(addEdit: string) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add') {
            this.actionGoalsFormGroup.reset();
            this.actionGoalData = Object.assign({});
        }
    }

    editActionGoal(modelData: any) {
        this.changeModelLabel('Edit');
        this.actionGoalData = Object.assign({}, modelData);
        this.actionGoalsFormGroup.setValue({
            name: this.actionGoalData.name,
            description: this.actionGoalData.description
        });
    }

    saveItem() {
        this.actionGoalData.name = this.actionGoalsFormGroup.value.name;
        this.actionGoalData.description = this.actionGoalsFormGroup.value.description;

        this.actionGoalData.activitytypekey = 'Investigation';
        this.actionGoalData.activeflag = 1;
        this.actionGoalData.effectivedate = new Date();
        if (this.actionGoalData.amgoalid) {
            this._actionGoalsService.update(this.actionGoalData.amgoalid, this.actionGoalData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Activity goal saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        this.actionGoalData = Object.assign({}, new DsdsActionGols());
                        $('#myModal-dsds-action-goals-add-edit').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._actionGoalsService.create(this.actionGoalData).subscribe(
                (response: any) => {
                    if (response.amgoalid) {
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        $('#myModal-dsds-action-goals-add-edit').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    confirmDelete(modelData: DsdsActionGols) {
        this.actionGoalData = Object.assign({}, modelData);
        $(this.deletepopupid).modal('show');
    }

    deleteItem() {
        this._actionGoalsService.remove(this.actionGoalData.amgoalid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Activity goal deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                }
            },
            () => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                $(this.deletepopupid).modal('hide');
            }
        );
    }

    clearItem() {
        this.actionGoalsFormGroup.reset();
        this.actionGoalData = Object.assign({}, new DsdsActionGols());
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
        return this.actionGoalsFormGroup.get('name') as FormControl; 
    }
    
    get descriptionControl(): FormControl { 
        return this.actionGoalsFormGroup.get('description') as FormControl; 
    }
}

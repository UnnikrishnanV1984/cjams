
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { AllegationGoals } from '../../_entities/daconfig.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'allegation-goals',
    templateUrl: './allegation-goals.component.html',
    standalone: false
})
export class AllegationGoalsComponent implements OnInit {
    labelAddEdit!: string;
    goalForm: FormGroup;
    allegationGoals$!: Observable<AllegationGoals[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    allegationGoalData = new AllegationGoals();
    private dynamicObject: DynamicObject = {};
    private pageStream$ = new Subject<number>();
    private searchTermStream$ = new Subject<DynamicObject>();
    deletepopupid = '#delete-popup';
    constructor(private formBuilder: FormBuilder, private _serviceGoals: GenericService<AllegationGoals>, private _alertService: AlertService) {
        this._serviceGoals.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmgoalUrl;
        this.goalForm = this.formBuilder.group({
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
                return this._serviceGoals
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AmgoalUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.allegationGoals$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem() {
        this.allegationGoalData.name = this.goalForm.value.name;
        this.allegationGoalData.description = this.goalForm.value.description;
        this.allegationGoalData.effectivedate = new Date();
        this.allegationGoalData.activeflag = 1;
        this.allegationGoalData.activitytypekey = 'Allegation';
        if (this.allegationGoalData.amgoalid) {
            this._serviceGoals.update(this.allegationGoalData.amgoalid, this.allegationGoalData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Allegation goal saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $('#myModal-allegations-goal-add').modal('hide');
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._serviceGoals.create(this.allegationGoalData).subscribe(
                (response: any) => {
                    if (response.amgoalid) {
                        this._alertService.success('Allegation goal saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        $('#myModal-allegations-goal-add').modal('hide');
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    editItem(goal: any) {
        this.changeModelLabel('Edit');
        this.allegationGoalData = Object.assign({}, goal);
        this.goalForm.setValue({
            name: this.allegationGoalData.name,
            description: this.allegationGoalData.description
        });
    }
    changeModelLabel(addEdit: string) {
        this.labelAddEdit = addEdit;
        if (addEdit === 'Add') {
            this.clearItems();
            this.allegationGoalData = Object.assign({}, new AllegationGoals());
        }
    }
    deleteItem() {
        this._serviceGoals.remove(this.allegationGoalData.amgoalid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Allegation goal deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                }
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
        this.goalForm.reset();
    }
    declineDelete() {
        $(this.deletepopupid).modal('hide');
    }
    confirmDelete(goal: AllegationGoals) {
        this.allegationGoalData = goal;
        $(this.deletepopupid).modal('show');
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

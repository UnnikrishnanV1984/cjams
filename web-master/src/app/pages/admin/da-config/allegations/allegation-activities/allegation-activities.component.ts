
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { AllegationActivities } from '../../_entities/daconfig.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'allegation-activities',
    templateUrl: './allegation-activities.component.html',
    standalone: false
})
export class AllegationActivitiesComponent implements OnInit {
    labelAddEdit!: string;
    activitiesForm: FormGroup;
    allegationActivities$!: Observable<AllegationActivities[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    allegationActivitiesData = new AllegationActivities();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(private formBuilder: FormBuilder, private _activitiesService: GenericService<AllegationActivities>, private _alertService: AlertService) {
        this._activitiesService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmactivityUrl;
        this.activitiesForm = this.formBuilder.group({
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
                return this._activitiesService
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AmactivityUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.allegationActivities$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem() {
        this.allegationActivitiesData.name = this.activitiesForm.value.name;
        this.allegationActivitiesData.description = this.activitiesForm.value.description;
        this.allegationActivitiesData.effectivedate = new Date();
        this.allegationActivitiesData.activeflag = 1;
        this.allegationActivitiesData.activitytypekey = 'Allegation';
        if (this.allegationActivitiesData.amactivityid) {
            this._activitiesService.update(this.allegationActivitiesData.amactivityid, this.allegationActivitiesData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Allegation activity saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $('#myModal-allegation-activity-add').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._activitiesService.create(this.allegationActivitiesData).subscribe(
                (response: any) => {
                    if (response.amactivityid) {
                        this._alertService.success('Allegation activity saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        $('#myModal-allegation-activity-add').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    editItem(activiti: any) {
        this.changeModelLabel('Edit');
        this.allegationActivitiesData = Object.assign({}, activiti);
        this.activitiesForm.setValue({
            name: this.allegationActivitiesData.name,
            description: this.allegationActivitiesData.description
        });
    }
    changeModelLabel(addEdit: string) {
        this.labelAddEdit = addEdit;
        if (addEdit === 'Add') {
            this.clearItems();
            this.allegationActivitiesData = Object.assign({}, new AllegationActivities());
        }
    }
    deleteItem() {
        this._activitiesService.remove(this.allegationActivitiesData.amactivityid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Allegation activity deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    this.declineDelete();
                }
            },
            () => {
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
        this.activitiesForm.reset();
    }
    declineDelete() {
        $('#delete-popup').modal('hide');
    }

    confirmDelete(activiti: AllegationActivities) {
        this.allegationActivitiesData = activiti;
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

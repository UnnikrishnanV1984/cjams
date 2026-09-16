
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { MasterProviderContracting, PaActivitiesPC } from '../../_entities/daconfig.data.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'pa-activities',
    templateUrl: './pa-activities.component.html',
    standalone: false
})
export class PaActivitiesComponent implements OnInit {
    addEditLabel!: string;
    isEditMode = false;
    paActivitiesformGroup!: FormGroup;
    paActivitiesPC$!: Observable<PaActivitiesPC[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    providerContractingConfig!: MasterProviderContracting;
    paActivitiesPC!: PaActivitiesPC;
    paginationInfo: PaginationInfo = new PaginationInfo();
    currentDaStatusData = new PaActivitiesPC();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    deletepopupid = '#delete-popup';
    constructor(private formBuilder: FormBuilder, private _service: GenericService<PaActivitiesPC>, private _alertService: AlertService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmactivityUrl;
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'name asc';
        this.paActivitiesformGroup = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
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
        this.paActivitiesPC$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    saveItem() {
        this.currentDaStatusData.description = this.paActivitiesformGroup.value.description;
        if (this.currentDaStatusData.amactivityid) {
            this._service.update(this.currentDaStatusData.amactivityid, this.currentDaStatusData).subscribe((response: any) => {
                    if (response) {
                        this._alertService.success('Pa activities type saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.paActivitiesformGroup.patchValue({
                            nameSearch: this.currentDaStatusData.name
                        });
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this.currentDaStatusData.activitytypekey = 'Investigation';
            this.currentDaStatusData.name = this.paActivitiesformGroup.value.name;
            this.currentDaStatusData.effectivedate = new Date();
            this.currentDaStatusData.activeflag = 1;
            this._service.create(this.currentDaStatusData).subscribe((response: any) => {
                    if (response.amactivityid) {
                        this._alertService.success('Pa activities type saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    editItem(currentdata: any) {
        this.isEditMode = true;
        this.currentDaStatusData = Object.assign({}, currentdata);
        this.paActivitiesformGroup.setValue({
            name: this.currentDaStatusData.name,
            description: this.currentDaStatusData.description
        });
    }
    changeModelLabel(addEdit: any) {
        this.isEditMode = false;
        this.addEditLabel = addEdit;
        if (addEdit === 'Add Task') {
            this.paActivitiesformGroup.reset();
            this.currentDaStatusData = Object.assign({}, new PaActivitiesPC());
        }
    }
    deleteItem() {
        this._service.remove(this.paActivitiesPC.amactivityid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Pa activities type deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
                }
            },
            (error) => {
                (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    declineDelete() {
        (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
    }

    confirmDelete(requestData: PaActivitiesPC) {
        this.paActivitiesPC = requestData;
        (<any>$(this.deletepopupid)).modal('show'); // NOSONAR
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
        return this.paActivitiesformGroup.get('name') as FormControl; 
    }
    
    get deficiencyControl(): FormControl { 
        return this.paActivitiesformGroup.get('deficiency') as FormControl; 
    }
}

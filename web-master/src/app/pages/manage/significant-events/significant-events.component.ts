
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable ,  Subject, merge } from 'rxjs';

import { PaginationInfo, DynamicObject } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX, LENGTH } from '../../../@core/entities/constants';
import { AlertService, GenericService, ValidationService } from '../../../@core/services';
import { SignificantEventConfig } from '../_entities/manage.data.models';
import { ManageUrlConfig } from '../manage-url.config';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'significant-events',
    templateUrl: './significant-events.component.html',
    styleUrls: ['./significant-events.component.scss'],
    standalone: false
})
export class SignificantEventsComponent implements OnInit {
    addEditLabel!: string;
    saveButton!: boolean;
    significantEventForm: FormGroup;
    significantEvents$!: Observable<SignificantEventConfig[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    significantEvent = new SignificantEventConfig();
    paginationInfo: PaginationInfo = new PaginationInfo();
    significantEventControl!: AbstractControl | null;
    eventIdControl!: AbstractControl | null;
    private pageSubject$ = new Subject<number>();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    deletepopupid = '#delete-popup';
    constructor(private formBuilder: FormBuilder, private _service: GenericService<SignificantEventConfig>, private _alertService: AlertService) {
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.SignificantEvent;
        this.significantEventForm = this.formBuilder.group(
            {
                effectivedate: ['', [Validators.required , LENGTH.MIN_LENGTH_VALIDATOR ]],
                expirationdate: ['', [Validators.required , LENGTH.MIN_LENGTH_VALIDATOR ]],
                datavalue: ['', [Validators.required, ValidationService.range(1, 100000)]],
                servicerequestincidenttypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                typedescription: ['']
            },
            { validators: this.checkDateRange }
        );
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'servicerequestincidenttypekey asc';
        this.getPage();
        this.significantEventControl = this.significantEventForm.get(['servicerequestincidenttypekey']);
        this.eventIdControl = this.significantEventForm.get(['datavalue']);
    }
    getPage() {
        const pageSource = this.pageStream$.pipe(map(pageNumber => {
            this.paginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObject, page: pageNumber };
        }));

        const searchSource = this.searchTermStream$.pipe(debounceTime(1000),map(searchTerm => {
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
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        ManageUrlConfig.EndPoint.Manage.SignificantEvent + '/list?filter'
                    ).pipe(
                    map(result => {
                        return { data: result.data, count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.significantEvents$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    saveEvent(significantEvent: SignificantEventConfig) {
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.SignificantEvent;
        if (this.significantEventForm.dirty && this.significantEventForm.valid) {
            this.significantEvent = Object.assign(new SignificantEventConfig(), significantEvent);
            this.significantEvent.servicerequestincidenttypekey = this.significantEventForm.value.servicerequestincidenttypekey;
            this._service.create(this.significantEvent).subscribe(
                (result: any) => {
                    if (result.servicerequestincidenttypekey) {
                        this._alertService.success('Significant event saved successfully!');
                        this.paginationInfo.sortBy = 'insertedon asc';
                        this.pageStream$.next(1);
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.cancelEvent();
        }
    }
    updateEvent(significantEvent: SignificantEventConfig) {
        if (this.significantEventForm.dirty && this.significantEventForm.valid) {
            if (this.significantEvent.servicerequestincidenttypekey) {
                const servicerequestincidenttypekey = this.significantEvent.servicerequestincidenttypekey;
                this.significantEvent.typedescription = significantEvent.typedescription;
                this.significantEvent.effectivedate = significantEvent.effectivedate;
                this.significantEvent.expirationdate = significantEvent.expirationdate;
                delete this.significantEvent['servicerequestcincidenttypekey'];
                delete this.significantEvent['timestamp'];
                this._service.patch(servicerequestincidenttypekey, this.significantEvent).subscribe(
                    (result: any) => {
                        if (result) {
                            this._alertService.success('Significant event updated successfully!');
                            this.pageStream$.next(this.paginationInfo.pageNumber);
                        }
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            }
        }
        this.cancelEvent();
    }
    editEvent(model: SignificantEventConfig) {
        this.saveButton = true;
        this.showAddEdit('Edit');
        this.significantEvent = Object.assign({}, model);
        this.significantEventForm.patchValue({
            effectivedate: new Date(this.significantEvent.effectivedate),
            expirationdate: new Date( this.significantEvent.expirationdate),
            datavalue: this.significantEvent.datavalue,
            servicerequestincidenttypekey: this.significantEvent.servicerequestincidenttypekey,
            typedescription: this.significantEvent.typedescription
        });
        this.significantEventControl?.disable();
        this.eventIdControl?.disable();
        this.significantEventForm.value.effectivedate = new Date();
    }
    deleteEvent() {
        if(this.significantEvent.servicerequestincidenttypekey) {
            this._service.remove(this.significantEvent.servicerequestincidenttypekey).subscribe(
                (result: any) => {
                    if (result) {
                        this._alertService.success('Deleted successfully!');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $(this.deletepopupid).modal('hide');
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.significantEventForm.reset();
            this.significantEventControl?.enable();
            this.eventIdControl?.enable();
        }
    }
    declineDelete() {
        $(this.deletepopupid).modal('hide'); 
    }
    confirmDelete(significantEvent: SignificantEventConfig) {
        this.significantEvent = significantEvent;
        $(this.deletepopupid).modal('show');
    }
    cancelEvent() {
        $('#myModal-add-edit-events').modal('hide'); 
        this.significantEventForm.reset();
        this.significantEventControl?.enable();
        this.eventIdControl?.enable();
    }
    checkDateRange(group: FormGroup) {
        if (group.controls.expirationdate.value) {
            if (group.controls.expirationdate.value < group.controls.effectivedate.value) {
                return { notValid: true };
            }
            return null;
        }
    }
    showAddEdit(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add') {
            this.saveButton = false;
            this.significantEventForm.value.effectivedate = new Date();
            this.significantEvent = Object.assign({}, new SignificantEventConfig());
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
            this.pageStream$.next(this.paginationInfo.pageNumber);
        }
        this.searchTermStream$.next(this.dynamicObject);

    }

    getControlByIndexFn(index: string): FormControl {
        return this.significantEventForm.controls[index] as FormControl;
    }
}

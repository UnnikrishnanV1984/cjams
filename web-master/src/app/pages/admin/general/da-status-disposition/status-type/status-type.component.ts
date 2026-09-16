
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService } from '../../../../../@core/services';
import { GenericService } from '../../../../../@core/services/generic.service';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DaStatusType, MasterCatelogConfig } from '../../_entities/general.data.models';
import { ManageDAAction } from '../../_entities/manage-da-action.models';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'status-type',
    templateUrl: './status-type.component.html',
    standalone: false
})
export class StatusTypeComponent implements OnInit {
    statusForm!: FormGroup;
    manageDAActions$!: Observable<ManageDAAction[]>;
    daStatusTypes$!: Observable<DaStatusType[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    daStatusTypeConfig: MasterCatelogConfig;
    paginationInfo: PaginationInfo = new PaginationInfo();
    currentDaStatusData: any;
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(
        private formBuilder: FormBuilder,
        private _service: GenericService<DaStatusType>,
        private _alertService: AlertService
    ) {
        this._service.endpointUrl =
            AdminUrlConfig.EndPoint.General.IntakeSerReqstStatusTypeUrl;

        this.daStatusTypeConfig = new MasterCatelogConfig({
            BlockTitle: '',
            LabelNameTitle: 'Status Type',
            LabelDescriptionTitle: 'Type Description',
            TableHeaderName: 'Code',
            TableHeaderDescription: 'Description',
            RouteUrl: ''
        });
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'intakeserreqstatustypekey asc';
        this.paginationInfo.total = -1;
        this.getPage();
        this.stausFrom();
    }


    stausFrom() {
        this.statusForm = this.formBuilder.group(
            {
                description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                intakeserreqstatustypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                effectivedate: [new Date(), [Validators.required, Validators.minLength(1)]],
                expirationdate: ['', [Validators.required, Validators.minLength(1)]]
            },
            { validators: this.checkDateRange }
        );
    }

    checkDateRange(statusForm: any) {
        if (statusForm.controls.expirationdate.value) {
            if (
                statusForm.controls.expirationdate.value <
                statusForm.controls.effectivedate.value
            ) {
                return { notValid: true };
            }
        }
        return null;
    }

    getPage() {
        const pageSource = this.pageStream$.pipe(map(pageNumber => {
            this.paginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObject, page: pageNumber };
        }));

        const searchSource = this.searchTermStream$.pipe(
            debounceTime(1000),
            map(searchTerm => {
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
                        AdminUrlConfig.EndPoint.General.IntakeSerReqstStatusTypeUrl +
                        '/list?filter'
                    ).pipe(
                    map(result => {
                        return {
                            data: result.data.map(model => new DaStatusType(model)),
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),share(),);
        this.daStatusTypes$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    faCalandar() {
        (<any>$('#fm-box-form')).modal('show'); // NOSONAR
    }

    saveItem() {
        this.currentDaStatusData.effectivedate = this.statusForm.value.effectivedate;
        this.currentDaStatusData.expirationdate = this.statusForm.value.expirationdate;
        this.currentDaStatusData.description = this.statusForm.value.description;
        this.currentDaStatusData.intakeserreqstatustypekey = this.statusForm.value.intakeserreqstatustypekey;

        if (this.currentDaStatusData.intakeserreqstatustypeid) {
            this.currentDaStatusData.updatedby = 'Default';
            this.currentDaStatusData.insertedby = 'Default';
            this._service
                .update(
                    this.currentDaStatusData.intakeserreqstatustypeid,
                    this.currentDaStatusData
                )
                .subscribe((response: any) => {
                        if (response) {
                            this._alertService.success(
                                'Status type saved successfully'
                            );
                            this.pageStream$.next(this.paginationInfo.pageNumber);
                        }
                    }, (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            this.statusForm.reset();
        } else {
            this.currentDaStatusData.activeflag = 1;
            this.currentDaStatusData.insertedby = 'Default';
            this._service.create(this.currentDaStatusData).subscribe((response: any) => {
                    if (response.intakeserreqstatustypeid) {
                        this._alertService.success(
                            'Status type saved successfully'
                        );
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.statusForm.patchValue({
                            nameSearch: this.currentDaStatusData.name
                        });
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.statusForm.reset();
        }
    }

    deleteItem() {
        this._service.remove(this.currentDaStatusData.intakeserreqstatustypeid).subscribe(
            response => {
                this._alertService.success('Status type deleted successfully');
                this.pageStream$.next(this.paginationInfo.pageNumber);
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    declineDelete() {
        (<any>$('#delete-popup')).modal('hide'); // NOSONAR
    }
    confirmDelete(requestData: DaStatusType) {
        this.currentDaStatusData = requestData;
        (<any>$('#delete-popup')).modal('show'); // NOSONAR
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.pageStream$.next(this.paginationInfo.pageNumber);
        this.paginationInfo.pageSize = event.itemsPerPage;
    }

    editItem(data: any) {
        this.currentDaStatusData = Object.assign({}, data);
        this.statusForm.patchValue({
            intakeserreqstatustypekey: this.currentDaStatusData
                .intakeserreqstatustypekey,
            description: this.currentDaStatusData.description,
            effectivedate: new Date(this.currentDaStatusData.effectivedate),
            expirationdate: new Date(this.currentDaStatusData.expirationdate)
        });
    }

    clearItems() {
        this.statusForm.reset();
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy =
            $event.sortColumn + ' ' + $event.sortDirection;
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

    get expirationdateControl(): FormControl { 
        return this.statusForm.get('expirationdate') as FormControl; 
    }

    get effectivedateControl(): FormControl { 
        return this.statusForm.get('effectivedate') as FormControl; 
    }

    get descriptionControl(): FormControl { 
        return this.statusForm.get('description') as FormControl; 
    }

    get intakeserreqstatustypekeyControl(): FormControl { 
        return this.statusForm.get('intakeserreqstatustypekey') as FormControl; 
    }    
}

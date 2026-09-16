
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
import { DispositionCodeType } from '../../_entities/general.data.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'disposition-code',
    templateUrl: './disposition-code.component.html',
    standalone: false
})
export class DispositionCodeComponent implements OnInit {

    dispositionCodeForm!: FormGroup;
    dispositionCodeType$!: Observable<DispositionCodeType[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    dispositionData: any;
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(private formBuilder: FormBuilder, private _service: GenericService<DispositionCodeType>, private _alertService: AlertService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.General.DispositionCodeUrl;
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'dispositioncode asc';
        this.getPage();
        this.dispositionForm();
    }

    dispositionForm() {
        this.dispositionCodeForm = this.formBuilder.group(
            {
                dispositioncode: [
                    '',
                    [Validators.required, Validators.maxLength(10), REGEX.NOT_EMPTY_VALIDATOR]
                ],
                description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                effectivedate: [new Date(), [Validators.required, Validators.minLength(1)]],
                expirationdate: ['', [Validators.required, Validators.minLength(1)]]
            },
            { validators: this.checkDateRange }
        );
    }
    checkDateRange(dispositionCodeForm: any) {
        if (dispositionCodeForm.controls.expirationdate.value) {
            if (dispositionCodeForm.controls.expirationdate.value < dispositionCodeForm.controls.effectivedate.value) {
                return { notValid: true };
            }
        }
        return null;
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
                        AdminUrlConfig.EndPoint.General.DispositionCodeUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return {
                            data: result.data,
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),
            share(),);

        this.dispositionCodeType$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    saveItem() {
        this.dispositionData.dispositioncode = this.dispositionCodeForm.value.dispositioncode;
        this.dispositionData.description = this.dispositionCodeForm.value.description;
        this.dispositionData.effectivedate = this.dispositionCodeForm.value.effectivedate;
        this.dispositionData.expirationdate = this.dispositionCodeForm.value.expirationdate;

        if (this.dispositionData.dispositioncodeid) {
            this.dispositionData.updatedby = 'Default';
            this.dispositionData.insertedby = 'Default';
            this.dispositionData.sequencenumber = 34;
            this._service.update(this.dispositionData.dispositioncodeid, this.dispositionData).subscribe((response: any) => {
                    if (response) {
                        this._alertService.success('Disposition code saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.dispositionCodeForm.reset();
        } else {
            this.dispositionData.activeflag = 1;
            this.dispositionData.insertedby = 'Default';
            this._service.create(this.dispositionData).subscribe((response: any) => {
                    if (response.dispositioncodeid) {
                        this._alertService.success('Disposition code saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.dispositionCodeForm.patchValue({
                            nameSearch: this.dispositionData.name
                        });
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.dispositionCodeForm.reset();
        }
    }

    deleteItem() {
        this._service.remove(this.dispositionData.dispositioncodeid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Disposition code deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                }
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    declineDelete() {
        (<any>$('#delete-popup')).modal('hide'); // NOSONAR
    }
    confirmDelete(requestData: DispositionCodeType) {
        this.dispositionData = requestData;
        (<any>$('#delete-popup')).modal('show'); // NOSONAR
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.pageStream$.next(this.paginationInfo.pageNumber);
        this.paginationInfo.pageSize = event.itemsPerPage;
    }

    editItem(data: any) {
        this.dispositionData = Object.assign({}, data);
        this.dispositionCodeForm.patchValue({
            dispositioncode: this.dispositionData.dispositioncode,
            description: this.dispositionData.description,
            effectivedate: new Date(this.dispositionData.effectivedate),
            expirationdate: new Date(this.dispositionData.expirationdate)
        });
    }
    clearItems() {
        this.dispositionCodeForm.reset();
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

    get expirationdateControl(): FormControl { 
        return this.dispositionCodeForm.get('expirationdate') as FormControl; 
    }
    
    get effectivedateControl(): FormControl { 
        return this.dispositionCodeForm.get('effectivedate') as FormControl; 
    }

    get descriptionControl(): FormControl { 
        return this.dispositionCodeForm.get('description') as FormControl; 
    }

    get dispositioncodeControl(): FormControl { 
        return this.dispositionCodeForm.get('dispositioncode') as FormControl; 
    } 
}

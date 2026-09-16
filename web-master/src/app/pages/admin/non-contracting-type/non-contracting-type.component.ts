
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, AbstractControl, FormControl } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../@core/services';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../admin-url.config';
import { NonContractingType } from './_entities/non-contract-type.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'non-contracting-type',
    templateUrl: './non-contracting-type.component.html',
    standalone: false
})
export class NonContractingTypeComponent implements OnInit {
    addEditLabel!: string;
    isEditMode = false;
    disableOnEdit = false;
    formGroup: FormGroup;
    nonContractionType$!: Observable<NonContractingType[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    nonContracting: NonContractingType = new NonContractingType();
    paginationInfo: PaginationInfo = new PaginationInfo();
    providernonagreementtypekeyControler!: AbstractControl | null;
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    addeditpopupid = '#myModal-non-contracting-type-edit-add';
    constructor(private formBuilder: FormBuilder, private _service: GenericService<NonContractingType>, private _alertService: AlertService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.NonContractingType.ProviderNonAgreementTypeUrl;
        this.formGroup = this.formBuilder.group({
            typedescription: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            providernonagreementtypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
    }
    ngOnInit() {
        this.paginationInfo.sortBy = 'providernonagreementtypekey asc';
        this.getPage();
        if(this.formGroup.get('providernonagreementtypekey')) {
            this.providernonagreementtypekeyControler = this.formGroup.get('providernonagreementtypekey');
        }
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
                        AdminUrlConfig.EndPoint.NonContractingType.ProviderNonAgreementTypeUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.nonContractionType$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    saveItem() {
        this.nonContracting.typedescription = this.formGroup.value.typedescription;
        if (this.nonContracting.providernonagreementtypekey && this.isEditMode) {
            this.nonContracting.updatedby = 'Default';
            this._service.update(this.nonContracting.providernonagreementtypekey, this.nonContracting).subscribe((response: any) => {
                    if (response) {
                        this._alertService.success('Non contracting type saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $(this.addeditpopupid).modal('hide');
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this.nonContracting.providernonagreementtypekey = this.formGroup.value.providernonagreementtypekey;
            this.nonContracting.activeflag = 1;

            this.nonContracting.effectivedate = new Date();
            this.nonContracting.expirationdate = new Date();
            this._service.create(this.nonContracting).subscribe((response: any) => {
                    if (response.providernonagreementtypekey) {
                        this._alertService.success('Non contracting type saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.formGroup.patchValue({
                            nameSearch: this.nonContracting.name
                        });
                        this.isEditMode = false;
                        $(this.addeditpopupid).modal('hide');
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    updateActiveState(nonContract: any, val: any) {
        this._service.update(nonContract.providernonagreementtypekey, nonContract).subscribe((response: any) => {
                if (response) {
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                }
            }, (_error: any) => {
            }
        );
    }
    updateAddEditLabel(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add') {
            this.cancelItem();
            this.nonContracting = Object.assign({}, new NonContractingType());
        }
    }
    editItem(nonContracting: NonContractingType) {
        this.providernonagreementtypekeyControler?.disable();
        this.isEditMode = true;
        this.nonContracting = Object.assign({}, nonContracting);
        this.formGroup.setValue({
            providernonagreementtypekey: this.nonContracting.providernonagreementtypekey,
            typedescription: this.nonContracting.typedescription
        });
    }
    cancelItem() {
        this.disableOnEdit = false;
        this.formGroup.reset();
        this.providernonagreementtypekeyControler?.enable();
        $(this.addeditpopupid).modal('hide');
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
        }
        this.searchTermStream$.next(this.dynamicObject);
    }

    get typedescriptionControl(): FormControl {
        return this.formGroup.get('typedescription') as FormControl;
    }

    get providernonagreementtypekeyControl(): FormControl {
        return this.formGroup.get('providernonagreementtypekey') as FormControl;
    }
}

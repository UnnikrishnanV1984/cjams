
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable ,  Subject, merge } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../@core/services';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { RegulationLibraryConfig } from '../_entities/manage.data.models';
import { ManageUrlConfig } from '../manage-url.config';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'regulation-library',
    templateUrl: './regulation-library.component.html',
    styleUrls: ['./regulation-library.component.scss'],
    standalone: false
})
export class RegulationLibraryComponent implements OnInit {
    addEditLabel!: string;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    regulationFormGroup: FormGroup;
    private pageSubject$ = new Subject<number>();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    regulationLibrary$!: Observable<RegulationLibraryConfig[]>;
    regulationLibraryData = new RegulationLibraryConfig();
    constructor(private formBuilder: FormBuilder, private _service: GenericService<RegulationLibraryConfig>, private _alertService: AlertService) {
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.RegulationLibrary;

        this.regulationFormGroup = this.formBuilder.group({
            statestatuteskey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            statestatutetext: [''],
            expirationdate: ['', [Validators.required, Validators.minLength(1)]],
            possiblesanctionflag: [''],
            possiblereferralflag: ['']
        });
    }
    deletepopupid = '#delete-popup';
    ngOnInit() {
        this.paginationInfo.sortBy = 'statestatuteskey asc';
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
                            page: params.page,
                            order: this.paginationInfo.sortBy,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        ManageUrlConfig.EndPoint.Manage.RegulationLibrary + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.regulationLibrary$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    changeModelLabel(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add') {
            this.regulationFormGroup.reset();
            this.regulationLibraryData = Object.assign({}, new RegulationLibraryConfig());
        }
    }

    saveItem() {
        if (this.regulationFormGroup.dirty && this.regulationFormGroup.valid) {
            this.regulationLibraryData.statestatuteskey = this.regulationFormGroup.value.statestatuteskey;
            this.regulationLibraryData.description = this.regulationFormGroup.value.description;
            this.regulationLibraryData.effectivedate = new Date();
            this.regulationLibraryData.expirationdate = this.regulationFormGroup.value.expirationdate;
            this.regulationLibraryData.possiblesanctionflag = this.regulationFormGroup.value.possiblesanctionflag;
            this.regulationLibraryData.possiblereferralflag = this.regulationFormGroup.value.possiblereferralflag;

            if (this.regulationLibraryData.statestatutesid) {
                this.regulationLibraryData.updatedby = 'Default';
                this.regulationLibraryData.insertedby = 'Default';
                this._service.update(this.regulationLibraryData.statestatutesid, this.regulationLibraryData).subscribe(
                    (response: any) => {
                        if (response) {
                            this._alertService.success('Regulation library saved successfully');
                            this.pageStream$.next(this.paginationInfo.pageNumber);
                            $('#myModal-add-edit-state').modal('hide'); 
                        }
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this.regulationLibraryData.activeflag = 1;
                this.regulationLibraryData.insertedby = 'Default';
                this._service.create(this.regulationLibraryData).subscribe(
                    (response: any) => {
                        if (response.statestatutesid) {
                            this._alertService.success('Regulation library  saved successfully');
                            this.paginationInfo.sortBy = 'insertedon desc';
                            this.pageStream$.next(1);
                            $('#myModal-add-edit-state').modal('hide');
                        }
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            }
        }
    }

    deleteItem() {
        this._service.remove(this.regulationLibraryData.statestatutesid).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('Regulation library deleted successfully');
                    $(this.deletepopupid).modal('hide'); 
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                }
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    declineDelete() {
        $(this.deletepopupid).modal('hide'); 
    }
    confirmDelete(regulationLibraryData: RegulationLibraryConfig) {
        this.regulationLibraryData = regulationLibraryData;
        $(this.deletepopupid).modal('show'); 
    }

    editItem(regulationLibrary: any) {
        this.changeModelLabel('Edit');
        this.regulationLibraryData = Object.assign({}, regulationLibrary);
        this.regulationFormGroup.setValue({
            statestatuteskey: this.regulationLibraryData.statestatuteskey,
            description: this.regulationLibraryData.description,
            expirationdate: new Date(this.regulationLibraryData.expirationdate),
            statestatutetext: this.regulationLibraryData.statestatutetext,
            possiblesanctionflag: this.regulationLibraryData.possiblesanctionflag,
            possiblereferralflag: this.regulationLibraryData.possiblereferralflag
        });
    }
    clearItems() {
        this.regulationFormGroup.reset();
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

    // tslint:disable-next-line:no-shadowed-variable
    onSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }

    getControlByIndexFn(index: string): FormControl {
        return this.regulationFormGroup.controls[index] as FormControl;
    }
}

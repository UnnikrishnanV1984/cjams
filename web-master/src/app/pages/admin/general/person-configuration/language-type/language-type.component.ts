
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { GeneralConfig, LanguageType, MasterCatelogConfig } from '../../_entities/general.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'language-type',
    templateUrl: './language-type.component.html',
    standalone: false
})
export class LanguageTypeComponent implements OnInit {
    languageTypes$!: Observable<LanguageType[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    languageTypeConfig: MasterCatelogConfig;
    formGroup: FormGroup;
    dynamicObject: DynamicObject = {};
    languageTypeData = new GeneralConfig();
    paginationInfo: PaginationInfo = new PaginationInfo();
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(
        private formBuilder: FormBuilder,
        private _service: GenericService<LanguageType>,
        private _alertService: AlertService
    ) {
        this._service.endpointUrl =
            AdminUrlConfig.EndPoint.General.LanguageTypeUrl;
        this.formGroup = this.formBuilder.group({
            name: ['', [Validators.required , REGEX.NOT_EMPTY_VALIDATOR]]
        });
        this.languageTypeConfig = new MasterCatelogConfig({
            BlockTitle: 'Add Language Type',
            LabelNameTitle: 'Language Type',
            LabelDescriptionTitle: 'Type Description',
            TableHeaderName: 'Language Type',
            TableHeaderDescription: 'Description',
            RouteUrl: ''
        });
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'languagetypename asc';
        this.getPage();
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
                        AdminUrlConfig.EndPoint.General.LanguageTypeUrl + '/list?filter'
                    ).pipe(
                    map(result => {
                        return {
                            data: result.data.map(model => new LanguageType(model)),
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),share(),);
        this.languageTypes$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem(modelData: LanguageType) {
        modelData.languagetypename = modelData.name;
        modelData.activeflag = 1;
        if (modelData.languagetypeid) {
            this._service.update(modelData.languagetypeid, modelData).subscribe((response: any) => {
                    if (response) {
                        this._alertService.success(
                            'Language type saved successfully.'
                        );
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                    }
                }, (error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._service.create(modelData).subscribe((response: any) => {
                    if (response.languagetypeid) {
                        this._alertService.success(
                            'Language type saved successfully.'
                        );
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.formGroup.patchValue({
                            nameSearch: this.languageTypeData.name
                        });
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    deleteItem(modelData: LanguageType) {
        if(modelData.languagetypeid) {
            this._service.remove(modelData.languagetypeid).subscribe(
                response => {
                    if (response) {
                        this._alertService.success(
                            'Language type deleted successfully.'
                        );
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                    }
                },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSort($event: ColumnSortedEvent) {
        if ($event.sortColumn === 'name') {
            this.paginationInfo.sortBy =
                'languagetypename ' + $event.sortDirection;
        } else if ($event.sortColumn === 'description') {
            this.paginationInfo.sortBy =
                'typedescription ' + $event.sortDirection;
        }
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(event: any) {
        if (event.field === 'name') {
            this.dynamicObject['languagetypename'] = { like: '%25' + event.value + '%25' };
            if (!event.value) {
                delete this.dynamicObject['languagetypename'];
            }
        } else if (event.field === 'description') {
            this.dynamicObject['typedescription'] = { like: '%25' + event.value + '%25' };
            if (!event.value) {
                delete this.dynamicObject['typedescription'];
            }
        }
        this.searchTermStream$.next(this.dynamicObject);
    }
}

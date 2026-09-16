
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { PaginationInfo, DynamicObject } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { LivingArrangementType, MasterCatelogConfig, GeneralConfig } from '../../_entities/general.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'living-arrangement-type',
    templateUrl: './living-arrangement-type.component.html',
    standalone: false
})
export class LivingArrangementTypeComponent implements OnInit {
    livingArrangementTypes$!: Observable<LivingArrangementType[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    livingarrangementTypeConfig: MasterCatelogConfig;
    paginationInfo: PaginationInfo = new PaginationInfo();
    formGroup: FormGroup;
    dynamicObject: DynamicObject = {};
    livingarrangementTypeData = new GeneralConfig();
    private readonly searchTermStream$ = new Subject<DynamicObject>();
    private readonly pageStream$ = new Subject<number>();

    constructor(
        private readonly formBuilder: FormBuilder,
        private readonly _service: GenericService<LivingArrangementType>,
        private readonly _alertService: AlertService
    ) {
        this._service.endpointUrl =
            AdminUrlConfig.EndPoint.General.LivingArrangementTypeUrl;
        this.formGroup = this.formBuilder.group({
            name: ['', [Validators.required, Validators.maxLength(50), REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, Validators.maxLength(50), REGEX.NOT_EMPTY_VALIDATOR]]
        });
        this.livingarrangementTypeConfig = new MasterCatelogConfig({
            BlockTitle: 'Add Living Arrangement Type',
            LabelNameTitle: 'Living Arrangement Type',
            LabelDescriptionTitle: 'Type Description',
            TableHeaderName: 'Living Arrangement Type',
            TableHeaderDescription: 'Description',
            RouteUrl: ''
        });
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'livingarrangementtypekey asc';
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
                AdminUrlConfig.EndPoint.General.LivingArrangementTypeUrl +
                    '/list?filter'
            ).pipe(
            map(result => {
                return {
                    data: result.data.map(
                        model => new LivingArrangementType(model)
                    ),
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize
                };
            }));
        }),share(),);

        this.livingArrangementTypes$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem(modelData: LivingArrangementType) {
        modelData.activeflag = 1;
        if (modelData.livingarrangementtypekey) {
            this._service
                .update(modelData.livingarrangementtypekey, modelData)
                .subscribe((response: any) => {
                        if (response) {
                            this._alertService.success(
                                'Living arrangement type saved successfully.'
                            );
                            this.pageStream$.next(this.paginationInfo.pageNumber);
                        }
                    }, (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
        } else {
            modelData.livingarrangementtypekey = modelData.name;
            this._service.create(modelData).subscribe((response: any) => {
                    if (response.livingarrangementtypekey) {
                        this._alertService.success(
                            'Living arrangement type saved successfully.'
                        );
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.formGroup.patchValue({
                            nameSearch: this.livingarrangementTypeData.name
                        });
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    deleteItem(modelData: LivingArrangementType) {
        if(modelData.livingarrangementtypekey) {
            this._service.remove(modelData.livingarrangementtypekey).subscribe(
                response => {
                    if (response) {
                        this._alertService.success(
                            'Living arrangement type deleted successfully.'
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
                'livingarrangementtypekey ' + $event.sortDirection;
        } else if ($event.sortColumn === 'description') {
            this.paginationInfo.sortBy = 'description ' + $event.sortDirection;
        }
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(event: any) {
        if (event.field === 'name') {
            this.dynamicObject['livingarrangementtypekey'] = { like: '%25' + event.value + '%25' };
            if (!event.value) {
                delete this.dynamicObject['livingarrangementtypekey'];
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

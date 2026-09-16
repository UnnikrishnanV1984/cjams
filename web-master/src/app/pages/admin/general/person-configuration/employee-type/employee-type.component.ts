
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { PaginationInfo, DynamicObject } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { EmployeeType, MasterCatelogConfig, GeneralConfig } from '../../_entities/general.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'employee-type',
    templateUrl: './employee-type.component.html',
    standalone: false
})
export class EmployeeTypeComponent implements OnInit {
    employeeTypes$!: Observable<EmployeeType[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    employeeTypeConfig: MasterCatelogConfig;
    paginationInfo: PaginationInfo = new PaginationInfo();
    formGroup: FormGroup;
    dynamicObject: DynamicObject = {};
    employeeTypeData = new GeneralConfig();
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();

    constructor(
        private formBuilder: FormBuilder,
        private _service: GenericService<EmployeeType>,
        private _alertService: AlertService
    ) {
        this._service.endpointUrl =
            AdminUrlConfig.EndPoint.General.EmployeeTypetUrl;
        this.formGroup = this.formBuilder.group({
            name: ['', [Validators.required, Validators.maxLength(50), REGEX.NOT_EMPTY_VALIDATOR]]
        });
        this.employeeTypeConfig = new MasterCatelogConfig({
            BlockTitle: 'Add Employee Type',
            LabelNameTitle: 'Employee Type',
            LabelDescriptionTitle: 'Type Description',
            TableHeaderName: 'Employee Type',
            TableHeaderDescription: 'Description',
            RouteUrl: ''
        });
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'employeetypename asc';
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
                        AdminUrlConfig.EndPoint.General.EmployeeTypetUrl +
                        '/list?filter'
                    ).pipe(
                    map(result => {
                        return {
                            data: result.data.map(model => new EmployeeType(model)),
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),share(),);

        this.employeeTypes$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem(modelData: EmployeeType) {
        modelData.employeetypename = modelData.name;
        modelData.activeflag = 1;
        if (modelData.employeetypeid) {
            this._service.update(modelData.employeetypeid, modelData).subscribe((response: any) => {
                    if (response) {
                        this._alertService.success(
                            'Employee type saved successfully.'
                        );
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            modelData.expirationdate = new Date();
            this._service.create(modelData).subscribe((response: any) => {
                    if (response.employeetypeid) {
                        this._alertService.success(
                            'Employee type saved successfully.'
                        );
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.formGroup.patchValue({
                            nameSearch: this.employeeTypeData.name
                        });
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    deleteItem(modelData: EmployeeType) {
        if(modelData.employeetypeid) {
            this._service.remove(modelData.employeetypeid).subscribe(
                response => {
                    if (response) {
                        this._alertService.success(
                            'Employee type deleted successfully.'
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
                'employeetypename ' + $event.sortDirection;
        }
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(event: any) {
        if (event.field === 'name') {
            this.dynamicObject['employeetypename'] = { like: '%25' + event.value + '%25' };
            if (!event.value) {
                delete this.dynamicObject['employeetypename'];
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

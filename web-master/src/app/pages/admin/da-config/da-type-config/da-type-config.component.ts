
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../admin-url.config';
import { DaTypeConfigMainData } from './_entities/da-type-config.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'da-type-config',
    templateUrl: './da-type-config.component.html',
    styleUrls: ['./da-type-config.component.scss'],
    standalone: false
})
export class DaTypeConfigComponent implements OnInit {
    daTypeConfig$!: Observable<DaTypeConfigMainData[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(private _service: GenericService<DaTypeConfigMainData>) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.DaTypeConfigComponentUrl;
    }
    ngOnInit() {
        this.paginationInfo.sortBy = 'servicerequesttypeconfigid asc';
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
                    .getPagedArrayList({
                        limit: this.paginationInfo.pageSize,
                        order: this.paginationInfo.sortBy,
                        page: params.page,
                        method: 'post',
                        where: params.search
                    }).pipe(
                    map((result) => {
                        return {
                            data: result.data.map((model) => new DaTypeConfigMainData(model)),
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),
            share(),);
        this.daTypeConfig$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObject[field] = { like: value };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }
}

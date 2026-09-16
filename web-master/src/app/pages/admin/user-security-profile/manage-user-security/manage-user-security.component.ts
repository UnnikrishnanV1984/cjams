
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Subject, merge, Observable } from 'rxjs';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../admin-url.config';
import { DynamicObject, PaginationInfo } from '../../../../@core/entities/common.entities';
import { ProfileUser } from '../_entites/user-security-profile.data.modal';
import { GenericService, DataStoreService } from '../../../../@core/services';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'manage-user-security',
    templateUrl: './manage-user-security.component.html',
    styleUrls: ['./manage-user-security.component.scss'],
    standalone: false
})
export class ManageUserSecurityComponent implements OnInit {
    totalRecords$: Observable<number> = new Observable<number>();
    canDisplayPager$: Observable<boolean> = new Observable<boolean>();
    usersList$: Observable<ProfileUser[]> = new Observable<ProfileUser[]>();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    paginationInfo: PaginationInfo = new PaginationInfo();
    constructor(private _service: GenericService<ProfileUser>, private _dataStore: DataStoreService ) {}

    ngOnInit() {
        this.paginationInfo.sortBy = 'displayname asc';
        this.getPage();
        this._dataStore.currentStore.subscribe((item) => {
            if (item['Update_List']) {
                this.getPage();
                this._dataStore.setData('Update_List', false);
            }
        });
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
                        AdminUrlConfig.EndPoint.UserProfile.UsersListUrl + '?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.usersList$ = source.pipe(pluck('data'));
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
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }
    onGenderSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObject[field] = { like: value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }
}

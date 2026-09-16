
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { BsModalRef } from 'ngx-bootstrap/modal/bs-modal-ref.service';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService } from '../../../../@core/services';
import { GenericService } from '../../../../@core/services/generic.service';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../admin-url.config';
import { ManageDAAction } from '../_entities/manage-da-action.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'manage-dsds-action-type',
    templateUrl: './manage-dsds-action-type.component.html',
    standalone: false
})
export class ManageDsdsActionTypeComponent implements OnInit {
    paginationInfo: PaginationInfo = new PaginationInfo();
    daAction!: ManageDAAction;
    modalRef!: BsModalRef;
    manageDAActions$!: Observable<ManageDAAction[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    managedsdsactionTypeData = new ManageDAAction();
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    private dynamicObject: DynamicObject = {};
    constructor(private _service: GenericService<ManageDAAction>, private _alertService: AlertService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl;
    }
    deletepopupid = '#delete-popup';

    ngOnInit() {
        this.paginationInfo.sortBy = 'intakeservreqtypekey asc';
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
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            nolimit: true,
                            method: 'get',
                            where: params.search
                        },
                        AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl + '/list?filter'
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

        this.manageDAActions$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    deleteItem() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl + '/delete';
        this._service.remove(this.daAction.intakeservreqtypeid).subscribe(
            () => {
                this._alertService.success('Department action type deleted successfully.');
                this.pageStream$.next(this.paginationInfo.pageNumber);
                $(this.deletepopupid).modal('hide');
            },
            () => {
                $(this.deletepopupid).modal('hide');
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    confirmDelete(modelData: ManageDAAction) {
        this.daAction = modelData;
        $(this.deletepopupid).modal('show');
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
}

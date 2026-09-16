
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { PaginationInfo, DynamicObject } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { MasterCatelogConfig, PersonRole, GeneralConfig } from '../../_entities/general.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-role',
    templateUrl: './person-role.component.html',
    standalone: false
})
export class PersonRoleComponent implements OnInit {
    personRoles$!: Observable<PersonRole[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    personTypeConfig: MasterCatelogConfig;
    paginationInfo: PaginationInfo = new PaginationInfo();
    formGroup: FormGroup;
    dynamicObject: DynamicObject = {};
    personroleTypeData = new GeneralConfig();
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(
        private formBuilder: FormBuilder,
        private _service: GenericService<PersonRole>,
        private _alertService: AlertService
    ) {
        this._service.endpointUrl =
            AdminUrlConfig.EndPoint.General.ActorTypeUrl;
        this.formGroup = this.formBuilder.group({
            name: ['', [Validators.required, Validators.maxLength(50), REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, Validators.maxLength(50), REGEX.NOT_EMPTY_VALIDATOR]]
        });

        this.personTypeConfig = new MasterCatelogConfig({
            BlockTitle: 'Add Person Role',
            LabelNameTitle: 'Person Role',
            LabelDescriptionTitle: 'Type Description',
            TableHeaderName: 'Person Role',
            TableHeaderDescription: 'Description',
            RouteUrl: ''
        });
    }
    ngOnInit() {
        this.paginationInfo.sortBy = 'actortype asc';
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
                        AdminUrlConfig.EndPoint.General.ActorTypeUrl + '/list?filter'
                    ).pipe(
                    map(result => {
                        return {
                            data: result.data.map(model => new PersonRole(model)),
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),share(),);

        this.personRoles$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem(modelData: any) {
        modelData.typedescription = modelData.description;
        modelData.activeflag = 1;
        if (modelData.actortype) {
            this._service.update(modelData.actortype, modelData).subscribe((response: any) => {
                    this._alertService.success(
                        'Person role saved successfully.'
                    );
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                }, (error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            modelData.actortype = modelData.name;
            modelData.tasktype = 2;
            this._service.create(modelData).subscribe((response: any) => {
                    this._alertService.success(
                        'Person role type saved successfully.'
                    );
                    this.paginationInfo.sortBy = 'insertedon desc';
                    this.pageStream$.next(1);
                    this.formGroup.patchValue({
                        nameSearch: this.personroleTypeData.name
                    });
                }, (error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    deleteItem(modelData: any) {
        if(modelData.actortype) {
            this._service.remove(modelData.actortype).subscribe(
                response => {
                    this._alertService.success('Person role deleted successfully.');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
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
            this.paginationInfo.sortBy = 'actortype ' + $event.sortDirection;
        } else if ($event.sortColumn === 'description') {
            this.paginationInfo.sortBy =
                'typedescription ' + $event.sortDirection;
        }
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(event: any) {
        if (event.field === 'name') {
            this.dynamicObject['actortype'] = { like: '%25' + event.value + '%25' };
            if (!event.value) {
                delete this.dynamicObject['actortype'];
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

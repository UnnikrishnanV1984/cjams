
import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DSDSActionMapping } from '../../_entities/dsds-action-mapping.data.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-action-mappings',
    templateUrl: './dsds-action-mappings.component.html',
    standalone: false
})
export class DsdsActionMappingsComponent implements OnInit {
    formGroup: FormGroup;
    dsdsActionMapping$!: Observable<DSDSActionMapping[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private pageSubject$ = new Subject<number>();
    constructor(private formBuilder: FormBuilder, private _dsdsActionMappingService: GenericService<DSDSActionMapping>, private _alertService: AlertService) {
        this.formGroup = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
    }
    ngOnInit() {
        this.pageSubject$.subscribe((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            this.getPage(this.paginationInfo.pageNumber);
        });
        this.getPage(1);
    }
    getPage(page: number) {
        this.paginationInfo.pageNumber = page;
        const source = this._dsdsActionMappingService
            .getPagedArrayList(
                new PaginationRequest({
                    limit: this.paginationInfo.pageSize,
                    page: this.paginationInfo.pageNumber,
                    count: this.paginationInfo.total,
                    where: { activitytypekey: 'Investigation' },
                    method: 'get',
                    order: 'insertedon desc'
                }),
                AdminUrlConfig.EndPoint.DAConfig.MappingListUrl
            ).pipe(
            map((result) => {
                return {
                    data: result.data,
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize
                };
            }),
            share(),);

        this.dsdsActionMapping$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageSubject$.next(this.paginationInfo.pageNumber);
    }
}

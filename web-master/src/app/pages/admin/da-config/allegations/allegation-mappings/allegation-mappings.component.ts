
import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, GenericService } from '../../../../../@core/services';
import { AdminUrlConfig } from '../../../admin-url.config';
import { AllegationMapping } from '../../_entities/allegation-mapping.data.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'allegation-mappings',
    templateUrl: './allegation-mappings.component.html',
    standalone: false
})
export class AllegationMappingsComponent implements OnInit {
    formGroup: FormGroup;
    allegationMapping$!: Observable<AllegationMapping[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    allegationMapping?: AllegationMapping = new AllegationMapping();
    private pageSubject$ = new Subject<number>();
    constructor(private formBuilder: FormBuilder, private _allegationMappingService: GenericService<AllegationMapping>, private _alertService: AlertService) {
        this.formGroup = this.formBuilder.group({
            name: ['', Validators.required],
            description: ['', Validators.required]
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
        const mappingData = this._allegationMappingService
            .getPagedArrayList(
                new PaginationRequest({
                    limit: this.paginationInfo.pageSize,
                    page: this.paginationInfo.pageNumber,
                    count: this.paginationInfo.total,
                    where: { activitytypekey: 'Allegation' },
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

        this.allegationMapping$ = mappingData.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = mappingData.pipe(pluck('count'));
            this.canDisplayPager$ = mappingData.pipe(pluck('canDisplayPager'));
        }
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageSubject$.next(this.paginationInfo.pageNumber);
    }
}

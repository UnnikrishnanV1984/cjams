
import {debounceTime, map, share, pluck, startWith, mergeMap} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { forkJoin, merge, Observable, Subject } from 'rxjs';

import { DropdownModel, DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { AllegationScoreUsage } from '../../_entities/daconfig.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'assessment-score-usage',
    templateUrl: './assessment-score-usage.component.html',
    standalone: false
})
export class AssessmentScoreUsageComponent implements OnInit {
    labelAddEdit!: string;
    selectedItems: string[] = [];
    scoreUsageGroup!: FormGroup;
    availableAssessmentTemplate!: AllegationScoreUsage[];
    scoreUsage$!: Observable<AllegationScoreUsage[]>;
    assessmentScoreType$!: Observable<DropdownModel[]>;
    assessmentScoringMethod$!: Observable<DropdownModel[]>;
    totalRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private dynamicObject: DynamicObject = {};
    private pageStream$ = new Subject<number>();
    private searchTermStream$ = new Subject<DynamicObject>();
    constructor(private _scoreUsageService: GenericService<AllegationScoreUsage>, private formBuilder: FormBuilder) {
        this._scoreUsageService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ScoreUsageUrl;
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'name asc';
        this.scoreUsageGroup = this.formBuilder.group({
            assessmentscoretypekey: [''],
            assessmentscoringmethodid: [''],
            leftSelectedItems: [''],
            rightSelectedItems: ['']
        });
        this.getPage();
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    changeModelLabel(addEdit: any) {
        this.labelAddEdit = addEdit;
        if (addEdit === ' Add ') {
            this.clearItems();
            this.availableAssessmentTemplate = Object.assign({});
        }
    }
    clearItems() {
        this.scoreUsageGroup.reset();
    }
    editItem(model: AllegationScoreUsage) {
        this.loadDropdownItems();
    }
    loadDropdownItems() {
        const source = forkJoin([
            this._scoreUsageService.getArrayList({}, AdminUrlConfig.EndPoint.DAConfig.GetAssessmentScoreTypeUrl),
            this._scoreUsageService.getArrayList({}, AdminUrlConfig.EndPoint.DAConfig.GetAssessmentScoringUrl)
        ]).pipe(
            map((result) => {
                return {
                    scoreTypelist: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.assessmentscoretypekey
                            })
                    ),
                    scoringMethodList: result[1].map(
                        (res) =>
                            new DropdownModel({
                                text: res.scoringmethod,
                                value: res.assessmentscoringmethodid
                            })
                    )
                };
            }),
            share(),);
        this.assessmentScoreType$ = source.pipe(pluck('scoreTypelist'));
        this.assessmentScoringMethod$ = source.pipe(pluck('scoringMethodList'));
        this.getAvailableConfiguration();
    }
    getAvailableConfiguration() {
        this._scoreUsageService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AssessmentScoreUsageUrl;
        this._scoreUsageService
            .getPagedArrayList(
                { limit: this.paginationInfo.pageSize, page: this.paginationInfo.pageNumber, where: { activeflag: 1 }, method: 'post' },

                AdminUrlConfig.EndPoint.DAConfig.AllegationConfigListUrl + '/list?filter'
            )
            .subscribe((result) => {
                this.availableAssessmentTemplate = result.data;
            });
    }

    saveItem() {
        this._scoreUsageService.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ScoreUsageUrl;
    }

    selectAll() {
        this.availableAssessmentTemplate = this.availableAssessmentTemplate.map((item) => {
            item.isSelected = true;
            return item;
        });
    }

    select() {
        if (this.scoreUsageGroup.value.leftSelectedItems) {
            this.availableAssessmentTemplate = this.availableAssessmentTemplate.map((item) => {
                this.scoreUsageGroup.value.leftSelectedItems.map((id: any) => {
                    if (item.assessmentscoretypekey === id) {
                        item.isSelected = true;
                    }
                });
                return item;
            });
        }
    }
    unSelect() {
        if (this.scoreUsageGroup.value.rightSelectedItems) {
            this.availableAssessmentTemplate = this.availableAssessmentTemplate.map((item) => {
                this.scoreUsageGroup.value.rightSelectedItems.map((id: string) => {
                    if (item.assessmentscoretypekey === id) {
                        item.isSelected = false;
                    }
                });
                return item;
            });
        }
    }
    unSelectAll() {
        this.availableAssessmentTemplate = this.availableAssessmentTemplate.map((item) => {
            item.isSelected = false;
            return item;
        });
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
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    private getPage() {
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
                return this._scoreUsageService
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            method: 'get',
                            where: params.search
                        },
                        AdminUrlConfig.EndPoint.DAConfig.ScoreUsageUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count };
                    }));
            }),
            share(),);
        this.scoreUsage$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
        }
    }
}

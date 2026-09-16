
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { EdlreviewresultConfig } from '../../_entities/reviewda.data.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'edl-review-results',
    templateUrl: './edl-review-results.component.html',
    standalone: false
})
export class EdlReviewResultsComponent implements OnInit {
    addEditLabel!: string;
    edlreviewformgroup: FormGroup;
    edlReviewResultTypes$!: Observable<EdlreviewresultConfig[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    edlReviewResultType: EdlreviewresultConfig = new EdlreviewresultConfig();
    paginationInfo: PaginationInfo = new PaginationInfo();
    private dynamicObject: DynamicObject = { reviewtypekey: 'EDL' };
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    deletepopupid = '#delete-popup';
    constructor(private _service: GenericService<EdlreviewresultConfig>, private _authService: AuthService, private formBuilder: FormBuilder, private _alertService: AlertService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ReviewResultTemplateUrl;
        this.edlreviewformgroup = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            deficiency: ['']
        });
    }
    ngOnInit() {
        this.paginationInfo.sortBy = 'name asc';
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
                            where: this.dynamicObject,
                            method: 'get'
                        },
                        AdminUrlConfig.EndPoint.DAConfig.ReviewResultTemplateUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.edlReviewResultTypes$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    saveItem() {
        if (this.edlreviewformgroup.dirty && this.edlreviewformgroup.valid) {
            this.edlReviewResultType.name = this.edlreviewformgroup.value.name;
            this.edlReviewResultType.deficiency = this.edlreviewformgroup.value.deficiency ? this.edlreviewformgroup.value.deficiency : false;
            this._authService.currentUser.subscribe((userInfo) => {
                this.edlReviewResultType.updatedby = userInfo.userId;
                this.edlReviewResultType.insertedby = userInfo.userId;
            });
            if (this.edlReviewResultType.reviewresulttemplateid) {
                this._service.update(this.edlReviewResultType.reviewresulttemplateid, this.edlReviewResultType).subscribe((response: any) => {
                        if (response) {
                            this._alertService.success('Review result saved successfully');
                            this.paginationInfo.sortBy = 'insertedon desc';
                            this.pageStream$.next(this.paginationInfo.pageNumber);
                            (<any>$('#add-edit-edl-review-results')).modal('hide'); // NOSONAR
                        }
                    }, (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this.edlReviewResultType.reviewtypekey = 'EDL';
                this.edlReviewResultType.activeflag = 1;
                this._service.create(this.edlReviewResultType).subscribe((response: any) => {
                    if (response.reviewresulttemplateid) {
                        this._alertService.success('Review result saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.edlreviewformgroup.patchValue({
                            nameSearch: this.edlReviewResultType.name
                        });
                        (<any>$('#add-edit-edl-review-results')).modal('hide'); // NOSONAR
                    }
                });
            }
        }
    }
    editItem(edlReviewResultType: EdlreviewresultConfig) {
        this.changeModelLabel('Edit Review Result');
        this.edlReviewResultType = Object.assign({}, edlReviewResultType);
        this.edlreviewformgroup.setValue({
            name: this.edlReviewResultType.name,
            deficiency: this.edlReviewResultType.deficiency
        });
    }
    changeModelLabel(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add Review Result') {
            this.edlreviewformgroup.reset();
            this.edlReviewResultType = Object.assign({}, new EdlreviewresultConfig());
        }
    }
    deleteItem() {
        this._service.remove(this.edlReviewResultType.reviewresulttemplateid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Review result deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
                }
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    declineDelete() {
        (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
    }
    confirmDelete(edlReviewResultType: EdlreviewresultConfig) {
        this.edlReviewResultType = edlReviewResultType;
        (<any>$(this.deletepopupid)).modal('show'); // NOSONAR
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

    get nameControl(): FormControl { 
        return this.edlreviewformgroup.get('name') as FormControl; 
    }
    
    get deficiencyControl(): FormControl { 
        return this.edlreviewformgroup.get('deficiency') as FormControl; 
    }
}


import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { SuperreviewResultPage } from '../../_entities/reviewda.data.models';

// tslint:disable-next-line:import-blacklist
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'supervisor-review-results',
    templateUrl: './supervisor-review-results.component.html',
    styleUrls: ['./supervisor-review-results.component.scss'],
    standalone: false
})
export class SupervisorReviewResultsComponent implements OnInit {
    addEditLabel!: string;
    formgroup: FormGroup;
    superReviewTypes$!: Observable<SuperreviewResultPage[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    superReviewType: SuperreviewResultPage = new SuperreviewResultPage();
    paginationInfo: PaginationInfo = new PaginationInfo();
    supervisorReviewTitle = 'Add Review Result';
    private dynamicObject: DynamicObject = { reviewtypekey: 'Super' };
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(private formBuilder: FormBuilder, private _service: GenericService<SuperreviewResultPage>, private _authService: AuthService, private _alertService: AlertService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ReviewResultTemplateUrl;
        this.formgroup = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            deficiency: ['']
        });
    }
    deletepopupid = '#delete-popup';
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
        this.superReviewTypes$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem() {
        if (this.formgroup.dirty && this.formgroup.valid) {
            this.superReviewType.name = this.formgroup.value.name;
            this.superReviewType.deficiency = this.formgroup.value.deficiency ? this.formgroup.value.deficiency : false;
            this._authService.currentUser.subscribe((userInfo) => {
                this.superReviewType.updatedby = userInfo.userId;
                this.superReviewType.insertedby = userInfo.userId;
            });
            if (this.superReviewType.reviewresulttemplateid) {
                this._service.update(this.superReviewType.reviewresulttemplateid, this.superReviewType).subscribe(
                    (response: any) => {
                        if (response) {
                            this._alertService.success('Review result saved successfully');
                            this.pageStream$.next(this.paginationInfo.pageNumber);
                            (<any>$('#add-super-review-results')).modal('hide'); // NOSONAR
                        }
                    },
                    (error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this.superReviewType.reviewtypekey = 'Super';
                this.superReviewType.activeflag = 1;
                this._service.create(this.superReviewType).subscribe((response: any) => {
                    if (response.reviewtypekey) {
                        this._alertService.success('Review result saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.formgroup.patchValue({
                            nameSearch: this.superReviewType.name
                        });
                        (<any>$('#add-super-review-results')).modal('hide'); // NOSONAR
                    }
                });
            }
        }
    }
    editItem(superReviewType: SuperreviewResultPage) {
        this.changeModelLabel('Edit Review Result');
        this.superReviewType = Object.assign({}, superReviewType);
        this.formgroup.setValue({
            name: this.superReviewType.name,
            deficiency: this.superReviewType.deficiency
        });
    }
    changeModelLabel(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add Review Result') {
            this.formgroup.reset();
            this.superReviewType = Object.assign({}, new SuperreviewResultPage());
        }
    }
    deleteItem() {
        this._service.remove(this.superReviewType.reviewresulttemplateid).subscribe(
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
    confirmDelete(superReviewType: SuperreviewResultPage) {
        this.superReviewType = superReviewType;
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

    get deficiencyControl(): FormControl { 
        return this.formgroup.get('deficiency') as FormControl; 
    }

    get nameControl(): FormControl { 
        return this.formgroup.get('name') as FormControl; 
    }
}

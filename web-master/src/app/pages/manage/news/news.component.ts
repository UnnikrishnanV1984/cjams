
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable ,  Subject,merge } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../@core/services';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { ManageNewsConfig } from '../_entities/manage.data.models';
import { ManageUrlConfig } from '../manage-url.config';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'news',
    templateUrl: './news.component.html',
    styleUrls: ['./news.component.scss'],
    standalone: false
})
export class NewsComponent implements OnInit {
    labelAddEdit!: string;

    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private pageSubject$ = new Subject<number>();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    manageNews$!: Observable<ManageNewsConfig[]>;
    manageNews = new ManageNewsConfig();
    newsForm: FormGroup;
    deletepopupid = '#delete-popup';
    constructor(private _service: GenericService<ManageNewsConfig>, private formBuilder: FormBuilder, private _alertService: AlertService) {
        this.newsForm = this.formBuilder.group({
            longtext: ['', [Validators.required, Validators.maxLength(150), REGEX.NOT_EMPTY_VALIDATOR]]
        });
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.News;
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'longtext asc';
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

        const source =  merge(searchSource, pageSource).pipe(
            startWith({
                search: this.dynamicObject,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                return this._service
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            page: this.paginationInfo.pageNumber,
                            order: this.paginationInfo.sortBy,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        ManageUrlConfig.EndPoint.Manage.News + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.manageNews$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    changeModelLabel(addEdit: any) {
        this.labelAddEdit = addEdit;
        if (addEdit === 'Add') {
            this.clearItems();
            this.manageNews = Object.assign({}, new ManageNewsConfig());
        }
    }

    saveItem() {
        this.manageNews.longtext = this.newsForm.value.longtext;
        this.manageNews.shorttext = this.newsForm.value.longtext;
        this.manageNews.activeflag = 1;
        this.manageNews.effectivedate = new Date();
        if (this.manageNews.newsid) {
            this._service.update(this.manageNews.newsid, this.manageNews).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('News saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $('#myModal-add-edit-news').modal('hide'); 
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._service.create(this.manageNews).subscribe(
                (response: any) => {
                    if (response.newsid) {
                        this._alertService.success('News saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        $('#myModal-add-edit-news').modal('hide'); 
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    deleteItem() {
        this._service.remove(this.manageNews.newsid).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('News deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                }
            },
            (_error: any) => {
                $(this.deletepopupid).modal('hide');
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    editItem(news: any) {
        this.changeModelLabel('Edit');
        this.manageNews = Object.assign({}, news);
        this.newsForm.setValue({
            longtext: this.manageNews.longtext
        });
        this.newsForm.value.longtext = news.longtext;
    }
    clearItems() {
        this.newsForm.reset();
    }

    declineDelete() {
        $(this.deletepopupid).modal('hide'); 
    }
    confirmDelete(manageNews: ManageNewsConfig) {
        this.manageNews = manageNews;
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

    onSearch(field: string,  val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }

    getControlByIndexFn(index: string): FormControl {
        return this.newsForm.controls[index] as FormControl;
    }
}

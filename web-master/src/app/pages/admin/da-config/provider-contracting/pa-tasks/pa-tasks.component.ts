
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { MasterProviderContracting, PaTasksPC } from '../../_entities/daconfig.data.models';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'pa-tasks',
    templateUrl: './pa-tasks.component.html',
    standalone: false
})
export class PaTasksComponent implements OnInit {
    addEditLabel!: string;
    paTaskForm!: FormGroup;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    paTasksPC$!: Observable<PaTasksPC[]>;
    paTasksPC!: PaTasksPC;
    providerContractingConfig: MasterProviderContracting;
    paginationInfo: PaginationInfo = new PaginationInfo();
    currentDaStatusData = new PaTasksPC();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    deletepopupid = '#delete-popup';
    constructor(private _service: GenericService<PaTasksPC>, private _alertService: AlertService, private formBuilder: FormBuilder) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AmtaskUrl;

        this.providerContractingConfig = new MasterProviderContracting({
            TableHeaderName: 'Name',
            TableHeaderDescription: 'Description',
            RouteUrl: ''
        });
    }

    ngOnInit() {
        this.paTaskForm = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
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
                            method: 'get',
                            where: params.search
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AmtaskUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.paTasksPC$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    saveItem() {
        this.currentDaStatusData.name = this.paTaskForm.value.name;
        this.currentDaStatusData.description = this.paTaskForm.value.description;
        if (this.currentDaStatusData.amtaskid) {
            this._service.update(this.currentDaStatusData.amtaskid, this.currentDaStatusData).subscribe((response: any) => {
                    if (response) {
                        this._alertService.success('Pa tasks type saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this.currentDaStatusData.effectivedate = new Date();
            this.currentDaStatusData.activeflag = 1;
            this.currentDaStatusData.activitytypekey = 'ProvContracting';
            this._service.create(this.currentDaStatusData).subscribe((response: any) => {
                    if (response.amtaskid) {
                        this._alertService.success('Pa tasks type update successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.paTaskForm.patchValue({
                            nameSearch: this.currentDaStatusData.name
                        });
                    }
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    editItem(data: PaTasksPC) {
        this.changeModelLabel('Edit Task');
        this.currentDaStatusData = Object.assign({}, data);
        this.paTaskForm.setValue({
            name: this.currentDaStatusData.name,
            description: this.currentDaStatusData.description
        });
    }
    changeModelLabel(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add Task') {
            this.paTaskForm.reset();
            this.currentDaStatusData = Object.assign({}, new PaTasksPC());
        }
    }

    deleteItem() {
        this._service.remove(this.paTasksPC.amtaskid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Pa activities type deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                }
            },
            (error) => {
                $(this.deletepopupid).modal('hide');
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    declineDelete() {
        $(this.deletepopupid).modal('hide');
    }
    confirmDelete(requestData: PaTasksPC) {
        this.paTasksPC = requestData;
        $(this.deletepopupid).modal('show');
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
        return this.paTaskForm.get('name') as FormControl; 
    }
    
    get deficiencyControl(): FormControl { 
        return this.paTaskForm.get('deficiency') as FormControl; 
    }
}

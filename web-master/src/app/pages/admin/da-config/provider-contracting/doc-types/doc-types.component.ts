
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, merge, Subject } from 'rxjs';

import { DynamicObject, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DocTypesPC, MasterProviderContracting } from '../../_entities/daconfig.data.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'doc-types',
    templateUrl: './doc-types.component.html',
    styleUrls: ['./doc-types.component.scss'],
    standalone: false
})
export class DocTypesComponent implements OnInit {
    addEditLabel!: string;
    isEditMode = false;
    disableOnEdit = false;
    docTypesFormgroup: FormGroup;
    docTypesControl!: AbstractControl | null;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    docTypesPC$!: Observable<DocTypesPC[]>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    providerContractingConfig: MasterProviderContracting;
    currentDaStatusData = new DocTypesPC();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(private formBuilder: FormBuilder, private _service: GenericService<DocTypesPC>, private _alertService: AlertService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.ProviderAgreementDoctypeUrl;
        this.docTypesFormgroup = this.formBuilder.group({
            provideragreementdocumenttypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            typedescription: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            activeflag: ['']
        });
        this.providerContractingConfig = new MasterProviderContracting({
            TableHeaderName: 'Name',
            TableHeaderDescription: 'Description',
            RouteUrl: ''
        });
    }
    ngOnInit() {
        this.paginationInfo.sortBy = 'typedescription asc';
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
                        AdminUrlConfig.EndPoint.DAConfig.ProviderAgreementDoctypeUrl + '/list?filter'
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);
        this.docTypesPC$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    saveItem() {
        this.docTypesControl = this.docTypesFormgroup.get('provideragreementdocumenttypekey');
        this.docTypesControl?.enable();
        this.currentDaStatusData.typedescription = this.docTypesFormgroup.value.typedescription;
        this.currentDaStatusData.activeflag = 1;
        if (this.currentDaStatusData.provideragreementdocumenttypekey) {
            if (this.docTypesFormgroup.value.activeflag === true) {
                this.currentDaStatusData.activeflag = 0;
            }
            this._service.update(this.currentDaStatusData.provideragreementdocumenttypekey, this.currentDaStatusData).subscribe((response: any) => {
                    if (response) {
                        this._alertService.success('Doc type saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        this.docTypesControl?.enable();
                    }
                }, (error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this.currentDaStatusData.provideragreementdocumenttypekey = this.docTypesFormgroup.value.provideragreementdocumenttypekey;
            this.currentDaStatusData.effectivedate = new Date();
            this.currentDaStatusData.editable = 0;
            this.currentDaStatusData.datavalue = 0;
            this.currentDaStatusData.sequencenumber = '0';
            this._service.create(this.currentDaStatusData).subscribe((response: any) => {
                    if (response.provideragreementdocumenttypekey) {
                        this._alertService.success('Doc type saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        this.docTypesControl?.enable();
                    }
                    this.paginationInfo.sortBy = 'insertedon desc';
                    this.pageStream$.next(1);
                    this.docTypesFormgroup.patchValue({
                        nameSearch: this.currentDaStatusData.name
                    });
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.docTypesFormgroup.reset();
            (<any>$('#myModal-doc-types-edit')).modal('hide'); // NOSONAR
        }
    }
    editItem(currentdata: any) {
        this.docTypesControl = this.docTypesFormgroup.get('provideragreementdocumenttypekey');
        this.docTypesControl?.disable();
        this.isEditMode = true;
        this.currentDaStatusData = Object.assign({}, currentdata);
        this.docTypesFormgroup.setValue({
            provideragreementdocumenttypekey: this.currentDaStatusData.provideragreementdocumenttypekey,
            typedescription: this.currentDaStatusData.typedescription,
            activeflag: !this.currentDaStatusData.activeflag
        });
    }
    changeModelLabel(addEdit: any) {
        this.isEditMode = false;
        this.addEditLabel = addEdit;
        if (addEdit === 'Add Task') {
            this.docTypesFormgroup.reset();
            this.currentDaStatusData = Object.assign({}, new DocTypesPC());
            this.docTypesControl = this.docTypesFormgroup.get('provideragreementdocumenttypekey');
            this.docTypesControl?.enable();
            this.docTypesFormgroup.reset();
        }
    }
    cancelItem() {
        this.disableOnEdit = false;
        this.docTypesFormgroup.reset();
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

    get typedescriptionControl(): FormControl { 
        return this.docTypesFormgroup.get('typedescription') as FormControl; 
    }
    
    get provideragreementdocumenttypekeyControl(): FormControl { 
        return this.docTypesFormgroup.get('provideragreementdocumenttypekey') as FormControl; 
    }
}

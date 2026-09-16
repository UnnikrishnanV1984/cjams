
import {mergeMap, map, debounceTime, startWith, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import moment from 'moment';
// import { CustomValidators } from 'ng4-validators';
import { Observable, merge, Subject } from 'rxjs';

import { DropdownModel, DynamicObject, PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../@core/entities/constants';
import { AlertService, GenericService, ValidationService } from '../../../@core/services';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { RecordingType } from '../../admin/recording-type/_entities/recordingtype.data.model';
import { AdminUrlConfig } from '../admin-url.config';
import * as recordingtype from './_configurations/recordingtype.json';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'recording-type',
    templateUrl: './recording-type.component.html',
    styleUrls: ['./recording-type.component.scss'],
    standalone: false
})
export class RecordingTypeComponent implements OnInit {
    isEditMode = false;
    showList = false;
    showSubType = false;
    isAsync = false;
    parentId!: string | number | null;
    showProgressNoteTypes: string[] = [];
    currentRecordingSubType: any = [];
    recordingFormGroup!: FormGroup;
    recordingSubTypeFormGroup!: FormGroup;
    paginationInfo: PaginationInfo = new PaginationInfo();
    currentRecordingTypes = new RecordingType();
    currentRecordingType = new RecordingType();
    recordingtypedropdown!: DropdownModel[];
    recTypesPC$!: Observable<RecordingType[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    currentRecordingSubType$!: Observable<any[]>;
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    private expirationDate!: string;
    private pageSubject$ = new Subject<number>();
    constructor(private route: ActivatedRoute, private router: Router, private service: GenericService<RecordingType>, private formBuilder: FormBuilder, private _alertService: AlertService) {
        this.service.endpointUrl = AdminUrlConfig.EndPoint.RecordingType.RecordingTypeUrl;
    }
    deletepopupid = '#delete-popup';
    ngOnInit() {
        this.paginationInfo.sortBy = 'progressnotetype asc';
        this.expirationDate = moment()
            .subtract(1, 'd')
            .format();
        this.showProgressNoteTypes = ['progressnoteclassificationtype', 'progressnotetype'];
        this.recordingtypedropdown = <any>recordingtype;
        this.pageSubject$.subscribe((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            this.getPage(this.paginationInfo.pageNumber);
        });
        this.getPage(1);
        this.showSubType = false;
        this.clearRecordingFormGroup();
        this.recordingFormGroup = this.formBuilder.group({
            progressnotetypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            progressnoteclassificationtypekey: ['', Validators.required],
            progressnotetypeid: '',
            description: [''],
            expirationdate: ['', [Validators.required, Validators.minLength(1)]]
        });
        this.recordingSubTypeFormGroup = this.formBuilder.group({
            progressnotesubtypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            subexpirationdate: ['']
        });

        this.recordingFormGroup = this.formBuilder.group({
            progressnotetypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            progressnoteclassificationtypekey: [''],
            progressnotetypeid: '',
            description: [''],
            expirationdate: ['', [Validators.required]],
            activeflag: [1],
            datavalue: [0],
            editable: [0],
            insertedby: [''],
            effectivedate: ['']
        }, {
            validators: [ValidationService.minDateValidator(this.expirationDate)]
        });
    }

    getPage(page: number) {
        this.paginationInfo.pageNumber = page;
        const pageSource = this.pageStream$.pipe(map((pageNumber: number) => {
            this.paginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObject, page: pageNumber };
        }));

        const searchSource = this.searchTermStream$.pipe(debounceTime(1000),map((searchTerm: DynamicObject) => {
            this.dynamicObject = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);
        const source = merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObject,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                return this.service
                    .getAllPaged(
                        new PaginationRequest({
                            limit: this.paginationInfo.pageSize,
                            page: this.paginationInfo.pageNumber,
                            order: this.paginationInfo.sortBy,
                            include: this.showProgressNoteTypes,
                            // where: { parentid: this.parentId }
                            where: params.search
                        }),
                        AdminUrlConfig.EndPoint.RecordingType.RecordingTypeUrl
                    ).pipe(
                    map((result: { data: any; count: number; }) => {
                        return {
                            data: result.data,
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),
            share(),);
        if (this.showSubType) {
            this.isAsync = true;
            this.currentRecordingSubType$ = source.pipe(pluck('data'));
        } else {
            this.isAsync = false;
            this.recTypesPC$ = source.pipe(pluck('data'));
        }
        this.currentRecordingSubType$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem() {
        if (this.recordingFormGroup.dirty && this.recordingFormGroup.valid) {
            this.currentRecordingTypes.progressnotetypekey = this.recordingFormGroup.value.progressnotetypekey;
            this.currentRecordingTypes.progressnoteclassificationtypekey = this.recordingFormGroup.value.progressnoteclassificationtypekey;
            this.currentRecordingTypes.description = this.recordingFormGroup.value.description;
            this.currentRecordingTypes.expirationdate = this.recordingFormGroup.value.expirationdate;
            this.currentRecordingTypes.activeflag = 1;
            if (this.isEditMode && this.currentRecordingTypes.progressnotetypeid) {
                this.currentRecordingTypes.parentid = undefined;
                this.service.update(this.currentRecordingTypes.progressnotetypeid, this.currentRecordingTypes).subscribe(
                    (_response: any) => {
                        this.getPage(this.paginationInfo.pageNumber);
                        this._alertService.success('Contact type added successfully');
                        this.showProgressNoteTypes = ['progressnoteclassificationtype', 'progressnotetype'];
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this.currentRecordingTypes.progressnotetypeid = null as any;
                this.service.create(this.currentRecordingTypes).subscribe(
                    (response : any) => {
                        this.getPage(this.paginationInfo.pageNumber);
                        this._alertService.success('Contact type added successfully');
                        this.showProgressNoteTypes = ['progressnoteclassificationtype', 'progressnotetype'];
                        this.parentId = response.progressnotetypeid;
                        this.showSubType = true;
                    },
                    (error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            }
        }
    }

    saveSubItem() {
        if (this.recordingSubTypeFormGroup.dirty && this.recordingSubTypeFormGroup.valid) {
            this.currentRecordingTypes.progressnotetypekey = this.recordingSubTypeFormGroup.value.progressnotesubtypekey;
            this.currentRecordingTypes.expirationdate = this.recordingSubTypeFormGroup.value.subexpirationdate ? this.recordingSubTypeFormGroup.value.subexpirationdate : null;
            this.currentRecordingTypes.parentid = this.parentId;
            this.currentRecordingTypes.progressnotetypeid = null as any;
            this.currentRecordingTypes.activeflag = 1;
            this.service.create(this.currentRecordingTypes).subscribe(
                (_response: any) => {
                    this.getPage(this.paginationInfo.pageNumber);
                    this._alertService.success('Contact sub type added successfully');
                    this.showProgressNoteTypes = [];
                    this.recordingSubTypeFormGroup.reset();
                    this.showList = true;
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    editItem(currentdata: any) {
        this.isEditMode = true;
        this.showSubType = true;
        this.currentRecordingTypes = Object.assign({}, currentdata);

        this.currentRecordingSubType = this.currentRecordingTypes.progressnotetype;
        this.parentId = this.currentRecordingTypes.progressnotetypeid;
        if (this.currentRecordingSubType) {
            this.showList = true;
        } else {
            this.showList = false;
        }
        this.recordingFormGroup.patchValue({
            progressnotetypekey: this.currentRecordingTypes.progressnotetypekey,
            description: this.currentRecordingTypes.description,
            progressnoteclassificationtypekey: this.currentRecordingTypes.progressnoteclassificationtypekey,
            expirationdate: new Date(this.currentRecordingTypes.expirationdate)
        });
    }

    deleteItem() {
        if (this.currentRecordingType.progressnotetypeid) {
            this.service.remove(this.currentRecordingType.progressnotetypeid).subscribe(
                (response) => {
                    this._alertService.success('Contact subType deleted successfully');
                    this.getPage(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    $(this.deletepopupid).modal('hide');
                }
            );
        }
    }

    declineDelete() {
        $(this.deletepopupid).modal('hide');
    }

    confirmDelete(requestModel: any) {
        this.currentRecordingType = requestModel;
        $(this.deletepopupid).modal('show');
    }

    clearRecordingFormGroup() {
        this.isEditMode = false;
        this.showSubType = false;
        this.showList = false;
    }
    cancelItems1() {
        this.recordingSubTypeFormGroup.reset();
        this.recordingFormGroup.reset();
        this.getPage(this.paginationInfo.pageNumber);
    }
    cancelItems() {
        this.recordingSubTypeFormGroup.reset();
        this.recordingFormGroup.reset();
        this.router.routeReuseStrategy.shouldReuseRoute = function() {
            return false;
        };
        const currentUrl = 'pages/admin/recording-type';
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = false;
            this.router.navigate([currentUrl]);
        });
    }
    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    onSearch(field: string, value: string) {
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    get progressNoteSubTypeControl(): FormControl {
        return this.recordingSubTypeFormGroup.get('progressnotesubtypekey') as FormControl;
    }
}

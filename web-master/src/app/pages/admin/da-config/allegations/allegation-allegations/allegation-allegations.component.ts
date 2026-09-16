
import {of as observableOf, Observable, merge, Subject } from 'rxjs';

import {mergeMap, map, debounceTime, startWith, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';

import {
    DropdownModel,
    DynamicObject,
    PaginationInfo,
    PaginationRequest,
} from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, CommonHttpService, GenericService } from '../../../../../@core/services';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { AllegationAllegations, Indicator } from '../../_entities/daconfig.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'allegation-allegations',
    templateUrl: './allegation-allegations.component.html',
    styleUrls: ['./allegation-allegations.component.scss'],
    standalone: false
})
export class AllegationAllegationsComponent implements OnInit {
    labelAddEdit!: string;
    allegationForm: FormGroup;
    indicatorForm!: FormGroup;
    totalRecords$!: Observable<number>;
    allegationAllegations$!: Observable<AllegationAllegations[]>;
    allegationAllegation$!: Observable<AllegationAllegations>;
    allegationAllegationData: AllegationAllegations = new AllegationAllegations();
    dynamicObject: DynamicObject = {};
    paginationInfo: PaginationInfo = new PaginationInfo();
    daTypeDropdownItems$!: Observable<DropdownModel[]>;
    canDisplayPager$!: Observable<boolean>;
    daSubTypeDropdownItems$!: Observable<DropdownModel[]>;
    indicators$!: Observable<Indicator[]>;
    indicatorsData: Indicator[] = [];
    indicator!: Indicator;
    deletepopupid = '#delete-popup';
    listurl = '/list?filter';
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    constructor(
        private formBuilder: FormBuilder,
        private _serviceAllegation: GenericService<AllegationAllegations>,
        private _alertService: AlertService,
        private _commonHttpService: CommonHttpService
    ) {
        this._serviceAllegation.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AllegationUrl;
        this.allegationForm = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            self: [''],
            workload: [''],
            nameSearch: [''],
            intakeservicereqtypeid: ['', Validators.required],
            intakeservicereqsubtypeid: ['', Validators.required],
            indicatorname: ['']
        });
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'name asc';

        this.getPage();
    }

    addIndicator() {
        this.indicator = Object.assign(new Indicator(), {});
        if (this.allegationForm.value.indicatorname.trim().length >= 1) {
            this.indicator.indicatorname = this.allegationForm.value.indicatorname;
            this.indicatorsData.push(this.indicator);
            this.indicatorsData = this.indicatorsData.map((item, ix) => {
                item.index = ix;
                return item;
            });
            this.indicators$ = observableOf(this.indicatorsData);
            this.allegationForm.patchValue({ indicatorname: '' });
        }
    }

    deleteIndicator(indicatorItem: any) {
        this.indicatorsData.splice(indicatorItem.index, 1);
        this.indicatorsData = this.indicatorsData.map((item, ix) => {
            item.index = ix;
            return item;
        });
        this.indicators$ = observableOf(this.indicatorsData);
        this.allegationForm.markAsDirty();
    }

    onChangeDaType(intakeservreqtypeid: string) {
        this.daSubTypeDropdownItems$ = this.loadDASubTypes(intakeservreqtypeid);
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
                return this._serviceAllegation
                    .getPagedArrayList(
                        {
                            limit: this.paginationInfo.pageSize,
                            order: this.paginationInfo.sortBy,
                            page: params.page,
                            count: this.paginationInfo.total,
                            method: 'get',
                            where: params.search
                        },
                        AdminUrlConfig.EndPoint.DAConfig.AllegationUrl + this.listurl
                    ).pipe(
                    map((result) => {
                        return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                    }));
            }),
            share(),);

        this.allegationAllegations$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }

    saveItem() {
        this.allegationAllegationData.name = this.allegationForm.value.name;
        this.allegationAllegationData.self = this.allegationForm.value.self;
        this.allegationAllegationData.workload = this.allegationForm.value.workload;
        this.allegationAllegationData.intakeservicereqtypeid = this.allegationForm.value.intakeservicereqtypeid;
        this.allegationAllegationData.intakeservicereqsubtypeid = this.allegationForm.value.intakeservicereqsubtypeid;
        this.allegationAllegationData.indicator = this.indicatorsData;
        if (this.allegationAllegationData.allegationid) {
            this._serviceAllegation.patch(this.allegationAllegationData.allegationid, this.allegationAllegationData, this._serviceAllegation.endpointUrl + '/updateAllegation').subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Allegation saved successfully');
                        this.pageStream$.next(this.paginationInfo.pageNumber);
                        $('#myModal-allegation-allegations-add').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._serviceAllegation.create(this.allegationAllegationData, this._serviceAllegation.endpointUrl + '/addAllegation').subscribe(
                (response: any) => {
                    if (response.allegationid) {
                        this._alertService.success('Allegation saved successfully');
                        this.paginationInfo.sortBy = 'insertedon desc';
                        this.pageStream$.next(1);
                        this.allegationForm.patchValue({
                            nameSearch: this.allegationAllegationData.name
                        });
                        $('#myModal-allegation-allegations-add').modal('hide');
                    }
                },
                () => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    editItem(allegation: AllegationAllegations) {
        this.changeModelLabel('Edit');
        this.daTypeDropdownItems$ = this.loadDATypes();
        this.indicators$ = observableOf([]);
        this.allegationForm.markAsPristine();
        this.loadAllegation(allegation);
    }

    changeModelLabel(addEdit: string) {
        this.labelAddEdit = addEdit;
        if (addEdit === 'Add') {
            this.clearItems();
            this.allegationAllegationData = Object.assign({}, new AllegationAllegations());
            this.daTypeDropdownItems$ = this.loadDATypes();
            this.indicatorsData = [];
            this.indicators$ = observableOf([]);
        }
    }

    loadDATypes() {
        return this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    order: 'intakeservreqtypekey ASC',
                    where: { archiveon: null },
                    method: 'get',
                    nolimit: true
                }),
                AdminUrlConfig.EndPoint.DAConfig.DaTypeUrl + this.listurl
            ).pipe(
            map((result: any) =>
                result['data'].map((res: { description: any; intakeservreqtypeid: any; }) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.intakeservreqtypeid
                        })
                )
            ));
    }

    loadDASubTypes(intakeservreqtypeid: string) {
        return this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    order: 'workloadweight ASC',
                    where: { intakeservreqtypeid: intakeservreqtypeid },
                    method: 'get',
                    nolimit: true
                }),
                AdminUrlConfig.EndPoint.DAConfig.DaConfigSubtypeUrl + this.listurl
            ).pipe(
            map((result: any) =>
                result['data'].map((res: { classkey: any; servicerequestsubtypeid: any; }) =>
                        new DropdownModel({
                            text: res.classkey,
                            value: res.servicerequestsubtypeid
                        })
                )
            ));
    }

    loadAllegation(allegationItem: AllegationAllegations) {
        const __this = this;
        this._serviceAllegation.getSingle(new PaginationRequest({ method: 'get' }), this._serviceAllegation.endpointUrl + '/getAllegation/' + allegationItem.allegationid + '?filter').subscribe(
            (response: any) => {
                const result = response[0];
                __this.allegationAllegationData = Object.assign({}, result);

                __this.allegationForm.patchValue({
                    name: result.name,
                    self: result.self,
                    workload: result.workload,
                    intakeservicereqtypeid: result.intakeservicereqtypeid
                });
                __this.daSubTypeDropdownItems$ = this.loadDASubTypes(result.intakeservicereqtypeid);

                __this.allegationForm.patchValue({
                    name: result.name,
                    self: result.self,
                    workload: result.workload,
                    intakeservicereqtypeid: result.intakeservicereqtypeid
                    // intakeservicereqsubtypeid: result.intakeservicereqsubtypeid
                });
                __this.daSubTypeDropdownItems$ = this.loadDASubTypes(result.intakeservicereqtypeid);

                __this.daSubTypeDropdownItems$.subscribe(() => {
                    __this.allegationForm.patchValue({
                        intakeservicereqsubtypeid: result.intakeservicereqsubtypeid
                    });
                });

                __this.indicatorsData = result.indicator;
                let index = -1;
                __this.indicatorsData.forEach((x) => (x.index = ++index));
                __this.indicators$ = observableOf(result.indicator);
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    deleteItem() {
        this._serviceAllegation.remove(this.allegationAllegationData.allegationid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Allegation deleted successfully');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                }
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    clearItems() {
        this.allegationForm.reset();
    }
    declineDelete() {
        $(this.deletepopupid).modal('hide');
    }

    confirmDelete(allegation: AllegationAllegations) {
        this.allegationAllegationData = allegation;
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
        return this.allegationForm.get('name') as FormControl; 
    }
}

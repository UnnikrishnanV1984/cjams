
import { forkJoin ,  Subject ,  Observable, EMPTY } from 'rxjs';

import {pluck, share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormControl } from '@angular/forms';

import { ObjectUtils } from '../../../../@core/common/initializer';
import {
    DropdownModel,
    PaginationRequest
} from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { GenericService } from '../../../../@core/services/generic.service';
import { ProviderSearchParam, ProviderAttributeSelector } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-provider-filter-criteria',
    templateUrl: './provider-filter-criteria.component.html',
    styleUrls: ['./provider-filter-criteria.component.scss'],
    standalone: false
})
export class ProviderFilterCriteriaComponent implements OnInit {
    @Input() showTable: boolean;
    @Input() providerAttributeSelector: ProviderAttributeSelector;
    @Input()
    providerSubject$!: Subject<ProviderAttributeSelector>;
    @Input()
    searchListSubject$!: Subject<Observable<any[]>>;
    @Input()
    totalRecordsSubject$!: Subject<Observable<number>>;
    @Input()
    pageNumberSubject$!: Subject<number>;

    formSearchCriteria: FormGroup;
    categoryTypeDropdownItems$!: Observable<DropdownModel[]>;
    agencyTypeDropdownItems$!: Observable<DropdownModel[]>;
    businessTypeDropdownItems$!: Observable<DropdownModel[]>;
    countyDropdownItems$!: Observable<DropdownModel[]>;
    regionDropdownItems$!: Observable<DropdownModel[]>;
    statusDropdownItems$!: Observable<DropdownModel[]>;
    paTypeDropdownItems$!: Observable<DropdownModel[]>;
    serviceTypeDropdownItems$!: Observable<DropdownModel[]>;

    constructor(
        private formBuilder: FormBuilder,
        private _commonService: CommonHttpService,
        private _service: GenericService<ProviderSearchParam>
    ) {
        this.showTable = false;
        this._service.endpointUrl =
            FindUrlConfig.EndPoint.ProviderSearch.gloabalagencysearchData;
        this.providerAttributeSelector = new ProviderAttributeSelector();
        this.formSearchCriteria = this.formBuilder.group({
            agencyname: '',
            name: '',
            status: '',
            provideragreementtype: '',
            specialterms: '',
            ssbg: '',
            agencycategory: [{ value: '', disabled: true }],
            agencytype: '',
            agencysubtype: new FormControl({ value: '', disabled: true }),
            serviceid: '',
            countyserviced: '',
            address1: '',
            address2: '',
            city: '',
            zipcode: '',
            county: '',
            region: '',
            phonenumber: '',
            facid: ''
        });
    }

    ngOnInit() {
        this.providerSubject$.subscribe(data => {
            this.providerAttributeSelector = data;
            this.clearSearch();
            this.getAllDropdownData();
        });
        this.getAllDropdownData();
        this.pageNumberSubject$.subscribe(data => {
            this.search(this.formSearchCriteria.value, data);
        });
    }

    getAllDropdownData() {
        const entityCategoryRequest = this._commonService.getArrayList({},
            FindUrlConfig.EndPoint.ProviderSearch.agencycategory
        );
        const agencyTypeRequest = this._commonService.getArrayList(
            {
                where: {
                    agencycategorykey: this.providerAttributeSelector.agencycategory
                    , activeflag: '1'
                },
                method: 'get'
            }
            , FindUrlConfig.EndPoint.ProviderSearch.agencytype

        );
        const businessTypeRequest = this._commonService.getArrayList(
            {
                where: { agencytypekey: 'Noncontracted', activeflag: '1' }
                , method: 'get'
            },
            FindUrlConfig.EndPoint.ProviderSearch.agencysubtypes
        );
        const countyTypeRequest = this._commonService.getArrayList({},
            FindUrlConfig.EndPoint.common.counties
        );
        const regionTypeRequest = this._commonService.getArrayList({},
            FindUrlConfig.EndPoint.common.regions
        );
        const statusTypeRequest = this._commonService.getArrayList({},
            FindUrlConfig.EndPoint.ProviderSearch.agencystatustypes
        );
        const paTypeRequest = this._commonService.getArrayList({},
            FindUrlConfig.EndPoint.ProviderSearch.providernonagreementtype
        );
        const serviceTypeRequest = this._commonService.getArrayList({},
            FindUrlConfig.EndPoint.ProviderSearch.services
        );

        const source = forkJoin([
            entityCategoryRequest,
            agencyTypeRequest,
            businessTypeRequest,
            countyTypeRequest,
            regionTypeRequest,
            statusTypeRequest,
            paTypeRequest,
            serviceTypeRequest
        ]).pipe(
            map(result => {
                return {
                    categoryTypes: result[0].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.agencycategorykey
                            })
                    ),
                    agencyTypes: result[1].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.agencytypekey
                            })
                    ),
                    businessTypes: result[2].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.agencysubtypekey
                            })
                    ),
                    countries: result[3].map(
                        res =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyname
                            })
                    ),
                    regions: result[4].map(
                        res =>
                            new DropdownModel({
                                text: res.regionname,
                                value: res.regionname
                            })
                    ),
                    status: result[5].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.agencystatustypekey
                            })
                    ),
                    paTypes: result[6].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.providernonagreementtypekey
                            })
                    ),
                    serviceType: result[7].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.servicename
                            })
                    )
                };
            }),
            share(),);

        this.categoryTypeDropdownItems$ = source.pipe(pluck('categoryTypes'));
        this.agencyTypeDropdownItems$ = source.pipe(pluck('agencyTypes'));
        this.countyDropdownItems$ = source.pipe(pluck('countries'));
        this.regionDropdownItems$ = source.pipe(pluck('regions'));
        this.statusDropdownItems$ = source.pipe(pluck('status'));
        this.paTypeDropdownItems$ = source.pipe(pluck('paTypes'));
        this.serviceTypeDropdownItems$ = source.pipe(pluck('serviceType'));
    }

    getBusinessTypes(agencytype: string) {
        const formctrl: any = this.formSearchCriteria.get('agencysubtype');
        this.businessTypeDropdownItems$ = EMPTY;

        if (agencytype !== '') {
            this.businessTypeDropdownItems$ = this._commonService
                .getArrayList(
                {
                    where: { agencytypekey: agencytype, activeflag: '1' }
                    , method: 'get'
                }
                , FindUrlConfig.EndPoint.ProviderSearch.agencysubtypes

                ).pipe(
                map(res =>
                    res.map(
                        data =>
                            new DropdownModel({
                                text: data.typedescription,
                                value: data.agencysubtypekey
                            })
                    )
                ));
            formctrl.enable();
        } else {
            formctrl.disable();
        }
    }

    search(params: ProviderSearchParam, pageNo: any) {
        this._service.endpointUrl =
            FindUrlConfig.EndPoint.ProviderSearch.gloabalagencysearchData;
        ObjectUtils.removeEmptyProperties(params);
        params = Object.assign(new ProviderSearchParam(), params);
        params.agencycategory = this.providerAttributeSelector.agencycategory;
        const source = this._service
            .getPagedArrayList(
            new PaginationRequest({
                where: params,
                page: pageNo,
                limit: 10,
                method: 'post'
            })
            ).pipe(
            share());

        this.searchListSubject$.next(source.pipe(pluck('data')));
        if (pageNo === 1) {
            this.totalRecordsSubject$.next(source.pipe(pluck('count')));
        }
    }

    clearSearch() {
        this.formSearchCriteria.reset();
        this.formSearchCriteria.patchValue({
            county: '',
            agencytype: '',
            agencysubtype: '',
            status: '',
            provideragreementtype: '',
            serviceid: '',
            region: ''
        });
        const formctrl: any = this.formSearchCriteria.get('agencysubtype');
        formctrl.disable();
    }
}

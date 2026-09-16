
import {pluck, share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { Observable ,  forkJoin ,  Subject } from 'rxjs';

import { ObjectUtils } from '../../../../@core/common/initializer';
import { DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { EntitiesSearchEntity } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';



@Component({
    selector: 'entities-search',
    templateUrl: './entities-search.component.html',
    styleUrls: ['./entities-search.component.scss'],
    standalone: false
})
export class EntitiesSearchComponent implements OnInit {


    @Input()
    searchEntitiesList$!: Subject<Observable<EntitiesSearchEntity[]>>;
    @Input()
    searchTotalRecords$!: Subject<Observable<number>>;
    @Input()
    searchPageNumber$!: Subject<number>;

    resultsTotalRecords$ = new Subject<number>();
    entitiesFormGroup: FormGroup;
    entitiesSearchEntity: EntitiesSearchEntity;

    countyDropDownItems$!: Observable<DropdownModel[]>;
    regionDropDownItems$!: Observable<DropdownModel[]>;
    categoryDropDownItems$!: Observable<DropdownModel[]>;
    typeDropDownItems$!: Observable<DropdownModel[]>;
    businessTypeDropDownItem!: Observable<DropdownModel[]>;
    serviceDropDownItems$!: Observable<DropdownModel[]>;
    areaServicedDropDownItems$!: Observable<DropdownModel[]>;

    constructor(private _service: GenericService<EntitiesSearchEntity>,
        private _commonService: CommonHttpService, private formBuilder: FormBuilder) {
        this.entitiesSearchEntity = new EntitiesSearchEntity();
        this._service.endpointUrl = FindUrlConfig.EndPoint.Entities.entitiesSearchUrl;
        this.entitiesFormGroup = this.formBuilder.group({
            agencyname: [''],
            commonname: [''],
            status: [''],
            phonenumber: [''],
            facid: [''],
            address: [''],
            street2: [''],
            city: [''],
            zipcode: [''],
            county: [''],
            region: [''],
            category: [''],
            type: [''],
            businesstype: new FormControl({ value: '', disabled: true }),
            service: [''],
            areaserviced: [''],
            ActiveFlag: ['1'],
            ActiveFlag1: ['1']
        });
    }

    ngOnInit() {
        this.searchPageNumber$.subscribe(pageNumber => {
            this.searchEntities(pageNumber, this.entitiesSearchEntity);
        });

        const getCountyList = this._service.getArrayList({}, FindUrlConfig.EndPoint.Entities.countyUrl);
        const getRegionList = this._service.getArrayList({}, FindUrlConfig.EndPoint.Entities.regionUrl);
        const getCategoryList = this._service.getArrayList({}, FindUrlConfig.EndPoint.Entities.categoryUrl);
        const getTypeList = this._service.getArrayList({}, FindUrlConfig.EndPoint.Entities.typeUrl);
        const getServiceList = this._service.getArrayList({}, FindUrlConfig.EndPoint.Entities.serviceUrl);

        const source = forkJoin([getCountyList, getRegionList, getCategoryList, getTypeList, getServiceList]).pipe(
            map(result => {
                return {
                    countyTypes: result[0].map(res => new DropdownModel(
                        { text: res.countyname, value: res.countyname })),
                    regionsTypes: result[1].map(res => new DropdownModel(
                        { text: res.regionname, value: res.regionid })),
                    categoryTypes: result[2].map(res => new DropdownModel(
                        { text: res.description, value: res.agencycategorykey })),
                    types: result[3].map(res => new DropdownModel(
                        { text: res.typedescription, value: res.agencytypekey })),
                    serviceTypes: result[4].map(res => new DropdownModel(
                        { text: res.servicename, value: res.servicetypekey }))
                };
            }),share(),);

        this.countyDropDownItems$ = source.pipe(pluck('countyTypes'));
        this.regionDropDownItems$ = source.pipe(pluck('regionsTypes'));
        this.categoryDropDownItems$ = source.pipe(pluck('categoryTypes'));
        this.typeDropDownItems$ = source.pipe(pluck('types'));
        this.serviceDropDownItems$ = source.pipe(pluck('serviceTypes'));

    }

    getBusinessTypeList(type: string) {
        if (type) {
            const url = FindUrlConfig.EndPoint.Entities.businessTypeUrl;
            this.businessTypeDropDownItem = this._commonService.getArrayList(
                {
                    where:
                        {
                            agencytypekey: type,
                            activeflag: 1
                        },
                    method: 'get'
                }
                , url).pipe(map(data => {
                    return data.map(res => new DropdownModel({ text: res.typedescription, value: res.agencysubtypekey }));
                }));
        }
    }

    onSelectType(type: string) {
        const formctrl: any = this.entitiesFormGroup.get('businesstype');
        if (type !== '') {
            this.getBusinessTypeList(type);
            formctrl.enable();
        } else {
            formctrl.disable();
        }
    }


    searchEntities(pageNo: number, model: EntitiesSearchEntity) {
        this.entitiesSearchEntity = model;
        ObjectUtils.removeEmptyProperties(this.entitiesSearchEntity);
        const source = this._service.getPagedArrayList(new PaginationRequest({
            limit: 10,
            page: pageNo,
            where: this.entitiesSearchEntity,
            method: 'post'
        })).pipe(share());
        this.searchEntitiesList$.next(source.pipe(pluck('data')));
        if (pageNo === 1) {
            this.searchTotalRecords$.next(source.pipe(pluck('count')));
        }
    }

    clearEntities() {
        this.entitiesFormGroup.reset();
        this.entitiesFormGroup.patchValue({ activeflag: 1, status: '', county: '', region: '', category: '', type: '', businesstype: '', service: '' });
        this.entitiesFormGroup.get('businesstype')?.disable();
    }
}

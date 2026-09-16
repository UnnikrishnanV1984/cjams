
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable, forkJoin } from 'rxjs';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { DropdownModel, PaginationInfo } from '../../../../@core/entities/common.entities';
import { AlertService, GenericService, DataStoreService } from '../../../../@core/services';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { NewUrlConfig } from '../../newintake-url.config';
import { EntitesSave, InvolvedEntitySearch, InvolvedEntitySearchResponse } from '../_entities/newintakeModel';
import { IntakeStoreConstants } from '../my-newintake.constants';
declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'intake-entities',
    templateUrl: './intake-entities.component.html',
    styleUrls: ['./intake-entities.component.scss'],
    standalone: false
})
export class IntakeEntitiesComponent implements OnInit {
    // @Input() entityDetailsSaveSubject$ = new Subject<EntitesSave[]>();
    // @Input() entitiesSubject$ = new Subject<EntitesSave[]>();
    involvedEntitiesForm!: FormGroup;
    entityDetailsForm!: FormGroup;
    entityId!: number | null;
    canShowSSBG = false;
    involvedEntityData = false;
    entitesSearchTabActive = false;
    entitesserachResultTabActive = false;
    entiteSearchTabActive = false;
    previousButtonDisabel = true;
    entityDetailsSave: EntitesSave = new EntitesSave();
    entitySubjectArray: EntitesSave[] = [];
    addedEntities: InvolvedEntitySearchResponse[] = [];
    listEntities: EntitesSave[] = [];
    editEntityData!: EntitesSave;
    editEntityIndex!: number | undefined;
    selectEntite!: InvolvedEntitySearchResponse;
    paginationInfo: PaginationInfo = new PaginationInfo();
    countyDropDownItems$!: Observable<DropdownModel[]>;
    stateDropDownItems$!: Observable<DropdownModel[]>;
    regionDropDownItems$!: Observable<DropdownModel[]>;
    categoryDropDownItems$!: Observable<DropdownModel[]>;
    roleDropdownItems$!: Observable<DropdownModel[]>;
    roleTypeDropdownItems$!: Observable<DropdownModel[]>;
    involvedEntitySearchResponses$!: Observable<InvolvedEntitySearchResponse[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    private involvedEntitySearch!: InvolvedEntitySearch;
    entitiessearchpopupid = '#entities-search';
    constructor(
        private formBuilder: FormBuilder,
        private _involvedEntitySeachService: GenericService<InvolvedEntitySearchResponse>,
        private _commonHttpService: CommonHttpService,
        private _alertService: AlertService,
        private _dataStore: DataStoreService
    ) { }

    ngOnInit() {
        this.initilizeForm();
        this.loadDropdownItems();
        // this.entitiesSubject$.subscribe((data) =>
        {
            this.listEntities = this._dataStore.getData(IntakeStoreConstants.addedEntities);
        }// );
    }
    initilizeForm() {
        this.involvedEntitiesForm = this.formBuilder.group({
            description: [''],
            agencycategorykey: [''],
            facid: [''],
            ssbg: [''],
            address1: [''],
            address2: [''],
            zipcode: [''],
            city: [''],
            region: [''],
            state: [''],
            county: [''],
            phonenumber: [''],
            isSatelliteOffice: [''],
            satelliteOffice: false
        });
        this.entityDetailsForm = this.formBuilder.group({
            agencyroletypekey: ['', [Validators.required]],
            agencytypekey: ['', [Validators.required]]
        });
    }
    searchResult() {
        (<any>$('#search-result-click')).click(); // NOSONAR
        this.paginationInfo.pageNumber = 1;
    }
    searchInvolvedEntities(model: InvolvedEntitySearch) {
        this.entitesSearchTabActive = true;
        this.involvedEntitySearch = model;
        this.involvedEntitiesForm.reset();
        this.getPage(1);
    }
    selectInvolvedEntity(model: InvolvedEntitySearchResponse, control: any) {
        this.selectEntite = model;
        const tempCount = this.listEntities.filter((item) => item.agencyid === model.agencyid);
        if (tempCount.length >= 1) {
            this._alertService.error('Entity Already Exists');
            control.target.checked = false;
        } else {
            if (this.addedEntities.length >= 1) {
                this.addedEntities.forEach((data: any) => {
                    this.addedEntities.splice(0, 1);
                    this.addedEntities.push(model);
                });
            } else {
                this.addedEntities.push(model);
            }
        }
    }
    saveEntity(event: any) {
        if (this.involvedEntitiesForm.valid) {
            if (this.entityDetailsForm.valid) {
                this.entitesSearchTabActive = false;
                this.entitesserachResultTabActive = false;
                this.entiteSearchTabActive = false;
                if (this.editEntityIndex !== undefined) {
                    this.listEntities[this.editEntityIndex].agencyroletypekey = event.agencyroletypekey;
                    this.listEntities[this.editEntityIndex].agencytypekey = event.agencytypekey;
                    this.involvedEntitiesForm.reset();
                    this.entityDetailsForm.reset();
                    (<any>$(this.entitiessearchpopupid)).modal('hide'); // NOSONAR
                    this._dataStore.setData(IntakeStoreConstants.addedEntities, this.listEntities);
                    this.editEntityIndex = undefined;
                } else {
                    const entitySaveItem = this.addedEntities[0];
                    this.entityDetailsSave = <EntitesSave>{
                        agencyid: entitySaveItem.agencyid,
                        description: entitySaveItem.agencyname,
                        agencysubtype: entitySaveItem.agencysubtype,
                        agencytypedesc: entitySaveItem.agencytypedesc,
                        phonenumber: entitySaveItem.phonenumber,
                        state: entitySaveItem.state,
                        zipcode: entitySaveItem.zipcode,
                        agencyroletypekey: event.agencyroletypekey,
                        agencytypekey: event.agencytypekey
                    };
                    this.listEntities.push(this.entityDetailsSave);
                    this.closePopup();
                    this._dataStore.setData(IntakeStoreConstants.addedEntities, this.listEntities);
                    this.editEntityIndex = undefined;
                }
            } else {
                this._alertService.warn('Please fill mandatory fields');
            }
        } else {
            this._alertService.warn('Select Entity Role');
        }
    }
    clearSearch() {
        this.involvedEntitiesForm.reset();
    }
    closePopup() {
        (<any>$(this.entitiessearchpopupid)).modal('hide'); // NOSONAR
        this.involvedEntitiesForm.reset();
        this.entityDetailsForm.reset();
        this.editEntityIndex = undefined;
        this.entitesSearchTabActive = false;
        this.entitesserachResultTabActive = false;
        this.entiteSearchTabActive = false;
    }
    editEntity(model: any, index: any) {
        (<any>$(this.entitiessearchpopupid)).modal('show'); // NOSONAR
        (<any>$('#entiterole')).click(); // NOSONAR
        this.entitesSearchTabActive = true;
        this.entitesserachResultTabActive = true;
        this.previousButtonDisabel = false;
        this.editEntityData = model;
        this.editEntityIndex = index;
        this.loadEntityDropdowns();
        this.entityDetailsForm.patchValue({
            agencyroletypekey: model.agencyroletypekey,
            agencytypekey: model.agencytypekey
        });
    }
    tabNavigation(id: any) {
        if (id === 'entiteinfo') {
            (<any>$('#' + id)).click(); // NOSONAR
            this.entitesserachResultTabActive = true;
            this.selectEntite = Object.assign({});
            this.paginationInfo.pageNumber = 1;
        }
        if (id === 'entiterole') {
            if (this.selectEntite.agencyid) {
                (<any>$('#' + id)).click(); // NOSONAR
                this.loadEntityDropdowns();
                this.entitesserachResultTabActive = true;
            } else {
                this._alertService.warn('Please select an entity.');
            }
        }
        $(this.entitiessearchpopupid).modal('show');
        if (id === 'search-result-click') {
            (<any>$('#' + id)).click(); // NOSONAR
            this.entiteSearchTabActive = true;
        }
    }
    searchPopup(id: any) {
        this.selectEntite = Object.assign({});
        (<any>$(this.entitiessearchpopupid)).modal('show'); // NOSONAR
        (<any>$('#' + id)).click(); // NOSONAR
    }
    confirmDelete(model: EntitesSave) {
        this.entityId = this.listEntities.indexOf(model);
        (<any>$('#delete-entity-popup')).modal('show'); // NOSONAR
    }

    deleteInvolvedEntity() {
        if(this.entityId) {
            this.listEntities.splice(this.entityId, 1);
            this.entitySubjectArray.splice(this.entityId, 1);
        }
        this._dataStore.setData(IntakeStoreConstants.addedEntities, this.entitySubjectArray);
        (<any>$('#delete-entity-popup')).modal('hide'); // NOSONAR
        this.entityId = null;
    }
    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.getPage(this.paginationInfo.pageNumber);
    }
    private loadDropdownItems() {
        const source = forkJoin([
            this._commonHttpService.create(
                {
                    nolimit: true,
                    order: 'countyname asc',
                },
                NewUrlConfig.EndPoint.Intake.CountryListUrl
            ),
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.StateListUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.RegionListUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.AgencyCategoryUrl + '?filter'
            )
        ]).pipe(
            map((result: any) => {
                return {
                    counties: result[0].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyname
                            })
                    ),
                    stateList: result[1].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.statename,
                                value: res.stateabbr
                            })
                    ),
                    regions: result[2]['data'].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.regionname,
                                value: res.regionid
                            })
                    ),
                    categories: result[3].map(
                        (res: any) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.agencycategorykey
                            })
                    )
                };
            }),
            share(),);
        this.countyDropDownItems$ = source.pipe(pluck('counties'));
        this.stateDropDownItems$ = source.pipe(pluck('stateList'));
        this.regionDropDownItems$ = source.pipe(pluck('regions'));
        this.categoryDropDownItems$ = source.pipe(pluck('categories'));
    }
    private getPage(pageNumber: number) {
        ObjectUtils.removeEmptyProperties(this.involvedEntitySearch);
        const source = this._involvedEntitySeachService
            .getAllFilter(
                {
                    limit: this.paginationInfo.pageSize,
                    order: '',
                    page: pageNumber,
                    count: this.paginationInfo.total,
                    where: this.involvedEntitySearch
                },
                NewUrlConfig.EndPoint.Intake.InvolvedEnititesSearchUrl
            ).pipe(
            map((result: any) => {
                this.canShowSSBG = result.data.filter((item: any) => item.ssbg).length !== 0;
                return {
                    data: result.data,
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize
                };
            }),
            share(),);
        this.involvedEntitySearchResponses$ = source.pipe(pluck('data'));
        if (pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    private loadEntityDropdowns() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.EntityRoletypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { agencycategorykey: 'Agency' },
                    order: 'displayorder ASC',
                    method: 'get',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.EntitesTypeUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    entityRoleType: result[0].map(
                        (data) =>
                            new DropdownModel({
                                text: data.typedescription,
                                value: data.agencyroletypekey
                            })
                    ),
                    entitySubRoleType: result[1].map(
                        (data) =>
                            new DropdownModel({
                                text: data.typedescription,
                                value: data.agencytypekey
                            })
                    )
                };
            }),
            share(),);
        this.roleDropdownItems$ = source.pipe(pluck('entityRoleType'));
        this.roleTypeDropdownItems$ = source.pipe(pluck('entitySubRoleType'));
    }
}

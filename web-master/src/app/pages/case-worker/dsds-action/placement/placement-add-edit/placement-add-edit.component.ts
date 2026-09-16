
import {forkJoin as observableForkJoin, EMPTY,  Observable } from 'rxjs';

import {pluck, map, share} from 'rxjs/operators';
import { DatePipe } from '@angular/common';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';

import { DropdownModel, PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService, GenericService, DataStoreService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { InvolvedPerson } from '../../involved-persons/_entities/involvedperson.data.model';
import { Placement, SearchPlan } from '../../service-plan/_entities/service-plan.model';
import { PlacementPlanConfig } from '../_entities/placement.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-add-edit',
    templateUrl: './placement-add-edit.component.html',
    styleUrls: ['./placement-add-edit.component.scss'],
    standalone: false
})
export class PlacementAddEditComponent implements OnInit {
    @Input() zoomControl: any;
    id!: string;
    caseTypes$!: Observable<DropdownModel[]>;
    categoryTypes$!: Observable<DropdownModel[]>;
    categorySubTypes$!: Observable<DropdownModel[]>;
    paymentTypes$!: Observable<DropdownModel[]>;
    exitTypes$!: Observable<DropdownModel[]>;
    searchPlacementForm!: FormGroup;
    addPlacementPlanForm!: FormGroup;
    PlacementPlanFormExit!: FormGroup;
    placementForm!: FormGroup;
    reportedChildDob!: string | null;
    involevedPerson$!: Observable<InvolvedPerson[]>;
    SearchPlacement$!: Observable<SearchPlan[]>;
    SearchPlacementRes$!: Observable<number>;
    placement$!: Observable<Placement[]>;
    placementCount$!: Observable<number>;
    countyDropdown$!: Observable<DropdownModel[]>;
    childCharacteristicDropdown$!: Observable<DropdownModel[]>;
    childDropdown = [];
    placementAdd!: PlacementPlanConfig;
    providerId!: string;
    intakeservicerequestactorid!: string;
    nextDisabled = true;
    startdatetime!: string;
    enddatetime!: string;
    Exitdatetime!: string;
    Exittime!: string;
    exitplacementid!: string;
    markersLocation : Array<any> = [];
    zoom!: number;
    defaultLat!: number;
    defaultLng!: number;
    maxDate = new Date();
    startDate!: Date;
    isAddPlacement = true;
    providerInfo!: any;
    paginationInfo: PaginationInfo = new PaginationInfo();
    isEnablePlacement!: Placement[];
    editPlacement!: Placement;
    twelvehour: boolean = true;
    timeInterval: number = 5;
    
    constructor(
        private _httpService: CommonHttpService,
        private _formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private _servicePlan: GenericService<PlacementPlanConfig>,
        private _alertService: AlertService,
        private datePipe: DatePipe,
        private _dataStoreService: DataStoreService
    ) {}
    dtformat = 'YYYY-MM-DD';
    panelconfig = {
        panels: [
            {
                id: 1,
                name: 'Profile',
                selector: 'profile-info'
            },
            {
                id: 2,
                name: 'Contract',
                selector: 'contract-info'
            },
            {
                id: 3,
                name: 'Additional Information',
                selector: 'additional-info'
            }
        ]
    };

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.searchPlacementForm = this._formBuilder.group({
            jurisdiction: [null],
            zipcode: [null],
            serviceType: [null],
            categoryType: [null],
            categorySubType: [null],
            paymentType: [null],
            vendor: [null],
            providerTaxId: [null]
        });

        this.addPlacementPlanForm = this._formBuilder.group({
            startdatetime: [null, Validators.required],
            enddatetime: [null, Validators.required],
            remarks: ['', Validators.required]
        });

        this.PlacementPlanFormExit = this._formBuilder.group({
            enddatetime: [null, Validators.required],
            exittime: [null, Validators.required],
            exitremarks: ['', Validators.required]
        });
        this.placementForm = this._formBuilder.group({
            choosechild: ['']
        });
        this.getDefaults();
        this.getPlacement(1);
        this.getInvolvedPerson();
        this.getCountyDropdown();
        this.childCharacteristic();
    }

    getProvider(providerInformation: any) {
        this.providerInfo = providerInformation;
    }

    getInvolvedPerson() {
        this.involevedPerson$ = this._httpService
            .getArrayList(
                {
                    method: 'get',
                    where: { intakeservreqid: this.id }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            ).pipe(
            map((res: any) => {
                return res['data'].filter((item: { rolename: string; }) => item.rolename === 'RC' || item.rolename === 'AV');
            }));
    }
    pesonDateOfBirth(item: any) {
        this.reportedChildDob = item.value.dob;
        this.intakeservicerequestactorid = item.value.intakeservicerequestactorid;

        this.placement$.pipe(
            map((res) => {
                const fullname = item.value.firstname + ' ' + item.value.lastname;
                const blah = res.filter((ite) => ite.childname === fullname && !ite.placeenddatetime);
                if (blah.length) {
                    this.isAddPlacement = true;
                } else {
                    this.isAddPlacement = false;
                }
            }))
            .subscribe();
    }
    searchClearPlacement() {
        this.SearchPlacement$ = EMPTY;
        this.nextDisabled = true;
        this.searchPlacementForm.reset();
        this.childDropdown = [];
        this.searchPlacementForm.patchValue({ serviceType: '' });
    }
    getPlacement(page: number) {
        const source = this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: page,
                    limit: this.paginationInfo.pageSize,
                    where: {
                        intakeserviceid: this.id
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementListUrl + '?filter'
            ).pipe(
            map((res) => {
                return {
                    data: res.data,
                    count: res.count
                };
            }),
            share(),);
        this.placement$ = source.pipe(pluck('data'));
        if (page === 1) {
            this.placementCount$ = source.pipe(pluck('count'));
        }
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.placementForm.patchValue({ choosechild: '' });
        this.isAddPlacement = true;
        this.getPlacement(this.paginationInfo.pageNumber);
    }

    child(childvalues: any) {
        this.childDropdown = childvalues.value;
    }

    searchPlacement(model: any) {
        this.zoom = 11;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        const source = this._httpService
            .getPagedArrayList(
                {
                    where: {
                        servicetype: model.serviceType ? model.serviceType : null,
                        service: model.categoryType ? model.categoryType : null,
                        servicesubtype: model.categorySubType ? model.categorySubType : null,
                        county: model.jurisdiction ? model.jurisdiction : null,
                        zipcode: model.zipcode ? model.zipcode : null,
                        provider: model.vendor ? model.vendor : null,
                        providerTaxId: model.providerTaxId ? model.providerTaxId : null,
                        pagenumber: null,
                        pagesize: null,
                        // from: 'Placement',
                        count: null,
                        childcharacteristic: this.childDropdown.length >= 1 ? this.childDropdown : null
                    },
                    method: 'post'
                },
                'provider/search'
            ).pipe(
            map((resp) => {
                return {
                    data: resp.data,
                    count: resp.count
                };
            }),
            share(),);
        this.SearchPlacement$ = source.pipe(pluck('data'));
        this.SearchPlacementRes$ = source.pipe(pluck('count'));
    }
    private getDefaults() {
        const source = observableForkJoin([this.getCaseType(), this.getCategoryType(), this.getPaymentType(), this.ExitReason()]).pipe(
            map((item) => {
                return {
                    caseTypes: item[0]
                        .filter((itm) => itm.servicetypekey === 'PS')
                        .map((res) => {
                            return new DropdownModel({
                                text: res.servicetypedescription,
                                value: res.servicetypekey
                            });
                        }),
                    categoryTypes: item[1].map((itm) => {
                        return new DropdownModel({
                            text: itm.description,
                            value: itm.serviceid
                        });
                    }),
                    paymentTypes: item[2].map((itm) => {
                        return new DropdownModel({
                            text: itm.providercontracttypename,
                            value: itm.providercontracttypekey
                        });
                    }),
                    exitTypes: item[3].map((itm) => {
                        return new DropdownModel({
                            text: itm.description,
                            value: itm.exitreasontypekey
                        });
                    })
                };
            }),
            share(),);
        this.caseTypes$ = source.pipe(pluck('caseTypes'));
        this.categoryTypes$ = source.pipe(pluck('categoryTypes'));
        this.paymentTypes$ = source.pipe(pluck('paymentTypes'));
        this.exitTypes$ = source.pipe(pluck('exitTypes'));
    }

    getCountyDropdown() {
        this.countyDropdown$ = this._httpService
            .create(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmCountyListUrl
            ).pipe(
            map((result) => {
                return result.map(
                    (res: { countyname: any; countyid: any; }) =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyid
                        })
                );
            }));
    }

    private getCaseType() {
        return this._httpService.getArrayList({ where: {}, nolimit: true, method: 'get' }, 'servicetype?filter');
    }

    private getCategoryType() {
        return this._httpService.getArrayList({ where: { servicetypekey: 'PS' }, nolimit: true, method: 'get' }, 'Services?filter');
    }

    childCharacteristic() {
        this.childCharacteristicDropdown$ = this._httpService
            .getArrayList(
                {
                    order: 'childcharacteristicdescription asc',
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.childcharacteristicUrl + '?filter'
            ).pipe(
            map((result) => {
                return result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.childcharacteristicdescription,
                            value: res.childcharacteristictypekey
                        })
                );
            }));
    }

    getCategorySubType(categoryType: string) {
        this.categorySubTypes$ = this._httpService
            .getArrayList(
                {
                    method: 'get',
                    where: { serviceid: categoryType },
                    nolimit: true
                },
                'servicesubtype?filter'
            ).pipe(
            map((itm) => {
                return itm.map(
                    (res) =>
                        new DropdownModel({
                            text: res.servicesubtypedescription,
                            value: res.servicesubtypekey
                        })
                );
            }));
    }

    private getPaymentType() {
        return this._httpService.getArrayList({ where: {}, nolimit: true, method: 'get' }, 'providercontracttype?filter');
    }

    private ExitReason() {
        return this._httpService.getAll('exitreasontype/');
    }

    selectedProv(provId: any) {
        this.nextDisabled = false;
        this.providerId = provId;
    }
    placementSearchAdd(servicePlanModel: PlacementPlanConfig) {
        this.startdatetime = moment(servicePlanModel.startdatetime).format(this.dtformat);
        this.enddatetime = moment(servicePlanModel.enddatetime).format('HH:mm');

        this.placementAdd = Object.assign(servicePlanModel);
        this.placementAdd.intakeserviceid = this.id;
        this.placementAdd.intakeservicerequestactorid = this.intakeservicerequestactorid;
        this.placementAdd.providerid = this.providerId;
        this.placementAdd.startdatetime = this.startdatetime + ' ' + this.enddatetime;
        this.placementAdd.enddatetime = null;
        this.placementAdd.remarks = servicePlanModel.remarks;
        this.placementAdd.statustypekey = 'PENDING';
        this._servicePlan.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementAddUrl;

        this._servicePlan.create(this.placementAdd).subscribe(
            (_res: any) => {
                this.addPlacementPlanForm.reset();
                this.searchPlacementForm.reset();
                $('#select-placement').modal('hide');
                this._alertService.success('Placement sent for Approval');
                this.isAddPlacement = true;
                this.getPlacement(1);
                this.getInvolvedPerson();
                this.reportedChildDob = null;
            },
            (_error: any) => {
                // No data or function to add or call
            }
        );
    }
    listMap() {
        this.zoom = 11;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        this.SearchPlacement$.subscribe((mapp) => {
            this.markersLocation = [];
            if (mapp.length > 0) {
                mapp.forEach((res) => {
                    const mapLocation = {
                        lat: +res.latitude,
                        lng: +res.longitude,
                        draggable: +true,
                        providername: res.providername,
                        addressline1: res.addressline1
                    };
                    this.markersLocation.push(mapLocation);
                    this.defaultLat = this.markersLocation[0].lat;
                    this.defaultLng = this.markersLocation[0].lng;
                });
                $('#iframe-popup').modal('show');
            }
        });
    }
    mapClose() {
        this.markersLocation = [];
    }

    Exitbutton(placement: any) {
        this.PlacementPlanFormExit.reset();
        this.exitplacementid = placement.placementid;
        this.startDate = placement.placedatetime;
        this.editPlacement = placement;
    }
    selectedGap(modal: any): boolean {
        if (modal.exitremarks === 'GS' && this.editPlacement.iscourtexists === true && this.editPlacement.iseligible === true) {
            this.Exitdatetime = moment(modal.enddatetime).format(this.dtformat);
            this.Exittime = moment(modal.exittime).format('HH:mm');
            const enddatetime = this.Exitdatetime + ' ' + this.Exittime;
            const startdate: any = this.datePipe.transform(this.startDate, 'yyyy-MM-dd HH:mm');
            const noOfDays = Math.abs(new Date(enddatetime).getTimezoneOffset() - new Date(startdate).getTimezoneOffset()) / (1000 * 60 * 60 * 24);
            if (180 > noOfDays) {
                this._alertService.warn('End date should be 180 days for Guardianship');
                return true;
            }
            return false;
        } else if (modal.exitremarks === 'GS' && this.editPlacement.iscourtexists === false) {
            this._alertService.warn('Court records doesn`t exist');
            return true;
        } else if (modal.exitremarks === 'GS' && this.editPlacement.iseligible === false) {
            this._alertService.warn('Child age should be less than 18 years!');
            return true;
        } else {
            return false;
        }
    }
    ExitSave(modal: any) {
        const isGuardianShip = this.selectedGap(modal);
        this.Exitdatetime = moment(modal.enddatetime).format(this.dtformat);
        this.Exittime = moment(modal.exittime).format('HH:mm');
        if (!isGuardianShip) {
            this._httpService
                .create(
                    {
                        placementid: this.exitplacementid,
                        exitreasontypekey: modal.exitremarks,
                        enddatetime: this.Exitdatetime + ' ' + this.Exittime
                    },
                    'placement/updateplacement'
                )
                .subscribe(
                    (res) => {
                        $('#exit-popup').modal('hide');
                        this._alertService.success('Placement Update successfully');
                        this.getPlacement(1);
                        this.getInvolvedPerson();
                        this.reportedChildDob = null;
                    },
                    (err) => {
                        // No data or function  to add or call
                    }
                );
        }
    }
}

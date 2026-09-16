
import {forkJoin as observableForkJoin, EMPTY,  Observable ,  Subject } from 'rxjs';

import {pluck, share, map} from 'rxjs/operators';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormArray, FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';

import { DropdownModel, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService, GenericService, DataStoreService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Occurence, RepeatsOn, SearchPlan, ServicePlanConfig } from '../_entities/service-plan.model';
import { MatDatepickerInputEvent } from '@angular/material/datepicker';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare const $ : any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'service-plan-add-edit-service',
    templateUrl: './service-plan-add-edit-service.component.html',
    styleUrls: ['./service-plan-add-edit-service.component.scss'],
    standalone: false
})
export class ServicePlanAddEditServiceComponent implements OnInit {

    @Input() zoomControl: any;
    
    caseTypes$!: Observable<DropdownModel[]>;
    categoryTypes$!: Observable<DropdownModel[]>;
    categorySubTypes$!: Observable<DropdownModel[]>;
    paymentTypes$!: Observable<DropdownModel[]>;
    servicePlanForm!: FormGroup;
    addServicePlanForm!: FormGroup;
    timesInDayHide = false;
    weekDays: RepeatsOn[] = [];
    id!: string;
    servicePlanAdd!: ServicePlanConfig;
    SearchPlan$!: Observable<SearchPlan[]>;
    SearchPlanRes$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    servicePlanCountyValuesDropdownItems$!: Observable<DropdownModel[]>;
    private pageStream$ = new Subject<number>();
    providerId!: string;
    nextDisabled = true;
    isrepeatschecked!: boolean;
    isRepeats = 0;
    zoom!: number;
    defaultLat!: number;
    defaultLng!: number;
    mapBtn = false;
    markersLocation : Array<any> = [];
    mindate = new Date();
    endMinDate = new Date();
    @Output()
    getServicePlan = new EventEmitter();
    @Input()
    servicePlanActivityiId!: string;
    @Output()
    dateChange!: EventEmitter<MatDatepickerInputEvent<Date>>;
    occurence!: Occurence[];
    weekstime : Array<any> = [];
    twelvehour: boolean = true;
    timeInterval: number = 5;
    constructor(
        private _httpService: CommonHttpService,
        private _alertService: AlertService,
        private _servicePlan: GenericService<ServicePlanConfig>,
        private _formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private _dataStoreService: DataStoreService
    ) { }

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.servicePlanForm = this._formBuilder.group({
            jurisdiction: [null],
            zipcode: [null],
            serviceType: [null],
            categoryType: [null],
            categorySubType: [null],
            paymentType: [null],
            vendor: [null],
            childCharacteristic: [null]
        });
        this.addServicePlanForm = this._formBuilder.group({
            startdate: [null],
            enddate: [null],
            reason: [''],
            rate: [''],
            isrepeats: [false],
            repeats: [false],
            exemptions: [''],
            noofoccurence: [''],
            occurences: this._formBuilder.array([])
        });
        this.addServicePlanForm.get('repeats')?.disable();
        this.addServicePlanForm.get('noofoccurence')?.disable();
        this.getDefaults();
        this.getCountyDropdown();
        this.isrepeatschecked = false;
        this.weekDays = [
            {
                day: 'SUN',
                dayValue: 'SUN'
            },
            {
                day: 'MON',
                dayValue: 'MON'
            },
            {
                day: 'TUE',
                dayValue: 'TUE'
            },
            {
                day: 'WED',
                dayValue: 'WED'
            },
            {
                day: 'THU',
                dayValue: 'THU'
            },
            {
                day: 'FRI',
                dayValue: 'FRI'
            },
            {
                day: 'SAT',
                dayValue: 'SAT'
            }
        ];
    }

    addFormGroup(value: any) {
        const timingFormArray = <FormArray>(
            this.addServicePlanForm.controls['occurences']
        );
        timingFormArray.controls = [];
        for (let i = 1; i <= value; i++) {
            timingFormArray.push(this.initFormGroup());
        }
    }

    initFormGroup(): FormGroup {
        return this._formBuilder.group({
            starttime: [null],
            endtime: [null]
        });
    }

    disableRepeatsOn(event: any) {
        if (event === true) {
            this.addServicePlanForm.get('repeats')?.enable();
            this.addServicePlanForm.get('noofoccurence')?.enable();
            this.isRepeats = 1;
            this.isrepeatschecked = true;
        } else {
            this.addServicePlanForm.get('repeats')?.disable();
            this.addServicePlanForm.get('noofoccurence')?.disable();
            this.isRepeats = 0;
            this.isrepeatschecked = false;
            this.addServicePlanForm.patchValue({
                repeats: false
            });
        }
    }

    clearItem() {
        this.SearchPlan$ = EMPTY;
        this.nextDisabled = true;
        this.servicePlanForm.reset();
        this.servicePlanForm.patchValue({ serviceType: '' });
        this.mapBtn = false;
        this.markersLocation = [];
        this.timesInDayHide = false;
        this.addServicePlanForm.reset();
        this.addServicePlanForm.setControl('occurences', new FormArray([]));
        this.isrepeatschecked = false;
        this.addServicePlanForm.patchValue({
            isrepeats: false
        });
    }

    startDateNotGreater(startDate: any) {
        this.endMinDate = new Date(startDate);
        this.addServicePlanForm.patchValue( {
enddate : null
        });
    }

    private getDefaults() {
        const source = observableForkJoin([
            this.getCaseType(),
            this.getPaymentType()
        ]).pipe(
            map(item => {
                return {
                    caseTypes: item[0].map(itm => {
                        return new DropdownModel({
                            text: itm.servicetypedescription,
                            value: itm.servicetypekey
                        });
                    }),
                    paymentTypes: item[1].map(itm => {
                        return new DropdownModel({
                            text: itm.providercontracttypename,
                            value: itm.providercontracttypekey
                        });
                    })
                };
            }),
            share(),);
        this.caseTypes$ = source.pipe(pluck('caseTypes'));
        this.paymentTypes$ = source.pipe(pluck('paymentTypes'));
    }

    getCountyDropdown() {
        this.servicePlanCountyValuesDropdownItems$ = this._httpService
            .create(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    order: 'countyname asc',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker
                    .SdmCountyListUrl
            ).pipe(
            map(result => {
                return result.map((res: { countyname: any; countyid: any; }) =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyid
                        })
                );
            }));
    }
    daysChange(event: any) {
        if (event.checked) {
            this.weekstime.push(event.source.value);
            this.timesInDayHide = true;
        }
    }
    expertOnReset() {
        this.addServicePlanForm.get('exemptions')?.reset();
    }

    private getCaseType() {
        return this._httpService.getArrayList(
            { where: {}, nolimit: true, method: 'get' },
            'servicetype?filter'
        );
    }
    getCategoryType(serviceType: string) {
        this.categoryTypes$ = this._httpService
            .getArrayList(
                {
                    method: 'get',
                    where: { servicetypekey: serviceType },
                    nolimit: true
                },
                'Services?filter'
            ).pipe(
            map(itms => {
                return itms.map(
                    res =>
                        new DropdownModel({
                            text: res.servicename,
                            value: res.serviceid
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
            map(itm => {
                return itm.map(
                    res =>
                        new DropdownModel({
                            text: res.servicesubtypedescription,
                            value: res.servicesubtypekey
                        })
                );
            }));
    }

    private getPaymentType() {
        return this._httpService.getArrayList(
            { where: {}, nolimit: true, method: 'get' },
            'providercontracttype?filter'
        );
    }

    searchActivityService(model: any) {
        this.zoom = 11;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        const source = this._httpService
            .getPagedArrayList(
                {
                    where: {
                        servicetype: model.serviceType
                            ? model.serviceType
                            : null,
                        service: model.categoryType ? model.categoryType : null,
                        servicesubtype: model.categorySubType
                            ? model.categorySubType
                            : null,
                        paymenttype: model.paymentType
                            ? model.paymentType
                            : null,
                        childcharacteristic: model.childCharacteristic
                            ? model.childCharacteristic
                            : null,
                        county: model.jurisdiction ? model.jurisdiction : null,
                        zipcode: model.zipcode ? model.zipcode : null,
                        provider: model.vendor ? model.vendor : null,
                        pagenumber: null,
                        pagesize: null,
                        count: null
                    },
                    method: 'post'
                },
                'provider/search?filter'
            ).pipe(
            map(res => {
                return {
                    data: res.data,
                    count: res.count
                };
            }),
            share(),);
        this.SearchPlan$ = source.pipe(pluck('data'));
        this.SearchPlanRes$ = source.pipe(pluck('count'));
    }

    addServicePlan(servicePlanModel: ServicePlanConfig) {
        this.servicePlanAdd = Object.assign(servicePlanModel);
        this.servicePlanAdd.objecttypekey = 'ServiceRequest';
        this.servicePlanAdd.objectid = this.id;
        this.servicePlanAdd.providerid = this.providerId;
        this.servicePlanAdd.exemptions = Object.assign([
            { exemptiondate: servicePlanModel.exemptions }
        ]);
        this.servicePlanAdd.repeats = Object.assign([
            { repeatdaytypekey: servicePlanModel.repeats }
        ]);
        this.servicePlanAdd.occurences = servicePlanModel.occurences;
        this.servicePlanAdd.rate = servicePlanModel.rate;
        this.servicePlanAdd.isrepeats = this.isRepeats;
        this.servicePlanAdd.serviceplanactivityid = this.servicePlanActivityiId;
        this._servicePlan.endpointUrl =
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.AddServicePlanUrl;
        this._servicePlan.create(this.servicePlanAdd).subscribe((_res: any) => {
                this.addServicePlanForm.reset();
               $('#select-services').modal('hide');
                this._alertService.success('Service added successfully');
                this.clearItem();
                this.getServicePlan.emit();
            }, (_error: any) => {}
        );
    }
    selectedProv(provId: any) {
        this.nextDisabled = false;
        this.providerId = provId;
    }
    changeTab() {
       $('#previous-click').click();
    }
    // Map tab
    clickedMarker(label: string, index: number) {
        //No operation needed here
    }
    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }
    listMap() {
        this.zoom = 11;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        this.SearchPlan$.subscribe(map1 => {
            this.markersLocation = [];
            if (map1.length > 0) {
                this.servicePlanLoopFn(map1);
                if (
                    !this.markersLocation[0].lat !== null &&
                    !this.markersLocation[0].lng !== null
                ) {
                    this.defaultLat = this.markersLocation[0].lat;
                    this.defaultLng = this.markersLocation[0].lng;
                } else {
                    this.defaultLat = 39.29044;
                    this.defaultLng = -76.61233;
                }
               $('#iframe-popup').modal('show');
            }
        });
    }
    // Associated with listMap function
    private servicePlanLoopFn(mapS: SearchPlan[]) {
        mapS.forEach(res => {
            if (res.latitude !== null && res.longitude !== null) {
                const mapLocation = {
                    lat: +res.latitude,
                    lng: +res.longitude,
                    draggable: +true,
                    providername: res.providername !== null ? res.providername : 'NA',
                    addressline1: res.addressline1 !== null ? res.addressline1 : 'NA',
                };
                this.markersLocation.push(mapLocation);
            } else {
                const mapLocation = {
                    lat: +this.defaultLat,
                    lng: +this.defaultLng,
                    draggable: +true,
                    providername: res.providername !== null ? res.providername : 'NA',
                    addressline1: res.addressline1 !== null ? res.addressline1 : 'NA',
                };
                this.markersLocation.push(mapLocation);
            }
        });
    }

    mapClose() {
        this.markersLocation = [];
    }

    changeTime(item: any, i: any) {
        const getOccurences = <FormArray>(
            this.addServicePlanForm.controls['occurences']
        );
        const format = 'hh:mm';
        this.occurence = getOccurences.value;
        this.occurence.forEach((items, index) => {
            if ((items.starttime && items.endtime) && index !== i) {
                const startTime = moment(items.starttime, format);
                const endTime = moment(items.endtime, format);
                const startTimeDiff = moment(item.value.starttime, format), beforeTime = startTime, afterTime = endTime;
                const endTimeDiff = moment(item.value.endtime, format), beforeStartTime = startTime, afterEndTime = endTime;

                if (startTimeDiff.isBetween(beforeTime, afterTime)) {
                        //No operation needed here
                } else {
                    if (endTimeDiff.isBetween(beforeStartTime, afterEndTime)) {
                        //No operation needed here
                    }
                }
            }
        });
    }

    getAddServicePlanFormData(name: string): any[] {
        return Object.values((this.addServicePlanForm.get(name) as FormGroup).controls);
    }
}

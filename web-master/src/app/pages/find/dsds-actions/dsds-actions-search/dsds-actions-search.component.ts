
import {pluck, share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { BsDatepickerConfig } from 'ngx-bootstrap/datepicker';
import { Observable ,  forkJoin ,  Subject } from 'rxjs';

import { ObjectUtils } from '../../../../@core/common/initializer';
import { DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services/generic.service';
import { DsdsActionFilter, DsdsActionResult } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-actions-search',
    templateUrl: './dsds-actions-search.component.html',
    styleUrls: ['./dsds-actions-search.component.scss'],
    standalone: false
})
export class DsdsActionsSearchComponent implements OnInit {
    @Input()
    dsdsActionSearchData$!: Subject<Observable<DsdsActionResult[]>>;
    @Input()
    totalSearchRecord$!: Subject<Observable<number>>;
    @Input()
    pageNumberSearch$!: Subject<number>;
    dsdsActionFilter: DsdsActionFilter;
    countyDropdownItems$!: Observable<DropdownModel[]>;
    regionDropdownItems$!: Observable<DropdownModel[]>;
    daTypeDropdownItems$!: Observable<DropdownModel[]>;
    daSubTypeDropdownItems$!: Observable<DropdownModel[]>;
    statusDropdownItems$!: Observable<DropdownModel[]>;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    dsdsActionForm: FormGroup;
    dASubTypeDropdownList: any;
    statusList: any;
    statusArray: string[] = [];
    typeArray: string[] = [];
    assignedArray: string[] = [];
    // datepicker
    minDate = new Date();
    colorTheme = 'theme-blue';
    bsConfig!: Partial<BsDatepickerConfig>;
    today: any;

    constructor(
        private _service: GenericService<DsdsActionResult>,
        private formBuilder: FormBuilder
    ) {
        this.dsdsActionFilter = new DsdsActionFilter();
        this._service.endpointUrl =
            FindUrlConfig.EndPoint.DsdsAction.dsdsActionSearchURL;

        this.dsdsActionForm = this.formBuilder.group({
            status: [''],
            assigned: [''],
            reporteddate: [''],
            duedate: [''],
            overdue: [''],
            srtype: [''],
            region: [''],
            county: [''],
            zipCode: [''],
            servicerequestnumber: [''],
            moNumber: [''],
            pagenumber: [''],
            pagesize: [''],
            srsubtype: [''],
            disposition: [''],
            receivedFrom: [''],
            receivedTo: [''],
            openedFrom: [''],
            openedTo: [''],
            closedFrom: [''],
            closedTo: [''],
            reportedAdult: [''],
            allegedPerpetrator: [''],
            dsdsProvider: [''],
            reporter: [''],
            dsdsWorker: [''],
            loadNumber: [''],
            activeflag: 1
        });
    }
    ngOnInit() {
        this.pageNumberSearch$.subscribe(data => {
            this.searchDSDSAction(data, this.dsdsActionFilter);
        });
        const getCountyList = this._service.getArrayList(
            {}, FindUrlConfig.EndPoint.DsdsAction.dsdsActionCountyURL
        );
        const getRegionList = this._service.getArrayList(
            {}, FindUrlConfig.EndPoint.DsdsAction.dsdsActionRegionURL
        );
        const getDATypeDropdown = this._service.getArrayList(
            {}, FindUrlConfig.EndPoint.DsdsAction.dsdsActionDATypeURL
        );
        const source = forkJoin([
            getCountyList,
            getRegionList,
            getDATypeDropdown
        ]).pipe(
            map(resultvalue => {
                return {
                    countyDropdownItems: resultvalue[0].map(
                        res =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyname
                            })
                    ),
                    regionDropdownItems: resultvalue[1].map(
                        res =>
                            new DropdownModel({
                                text: res.regionname,
                                value: res.regionid
                            })
                    ),
                    daTypeDropdownItems: resultvalue[2].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.intakeservreqtypekey
                            })
                    )
                };
            }),
            share(),);
        this.countyDropdownItems$ = source.pipe(pluck('countyDropdownItems'));
        this.regionDropdownItems$ = source.pipe(pluck('regionDropdownItems'));
        this.daTypeDropdownItems$ = source.pipe(pluck('daTypeDropdownItems'));
        this.statusArray = [];
        this.typeArray = [];
        this.assignedArray = [];
        this.bsConfig = Object.assign({}, { containerClass: this.colorTheme });
        const date = new Date();
        this.today =
            date.getDate() + '/' + date.getMonth() + '/' + date.getFullYear();
    }
    // Getting the da sub type dropdown values
    onChangeDaType(val: Event) {
        const daType: string = (val.target as HTMLInputElement).value;
        this.typeArray = [];
        this.typeArray.push(daType);
        const url =
            FindUrlConfig.EndPoint.DsdsAction.dsdsActionDASubTypeURL;
        this.daSubTypeDropdownItems$ = this._service.getArrayList(
            {
                include: 'servicerequestsubtype',
                where: { intakeservreqtypekey: daType },
                method: 'get'
            }
            , url).pipe(map((data: any) => {
                const subType = data[0]['servicerequestsubtype'];
                this.dASubTypeDropdownList = subType;
                return subType.map((res: { description: any; servicerequestsubtypeid: any; }) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.servicerequestsubtypeid
                        })
                );
            }));
    }
    // Getting the status dropdown values
    onChangeDaSubType(val: Event) {
        const daSubType = (val.target as HTMLInputElement).value;
        const selectedDATypeID = this.dASubTypeDropdownList.find((daTypeID: { servicerequestsubtypeid: string; }) => {
            return daTypeID.servicerequestsubtypeid === daSubType;
        });
        const url =
            FindUrlConfig.EndPoint.DsdsAction.dsdsActionStatusURL;
        this.statusDropdownItems$ = this._service.getArrayList(
            {
                where: {
                    datypeid: selectedDATypeID.intakeservreqtypeid,
                    dasubtypeid: daSubType
                },
                method: 'get'
            }
            , url).pipe(map(data => {
                this.statusList = data;
                return data.map(
                    res =>
                        new DropdownModel({
                            text: res.description,
                            value: res.intakeserreqstatustypeid
                        })
                );
            }));
    }
    // Getting the disposition dropdown values
    onChangeStatus(val: Event) {
        const status = (val.target as HTMLInputElement).value;
        this.statusArray = [];
        const selectedConfigID = this.statusList.find((configID: { intakeserreqstatustypeid: string; }) => {
            return configID.intakeserreqstatustypeid === status;
        });
        this.statusArray.push(selectedConfigID.description);
        const url =
            FindUrlConfig.EndPoint.DsdsAction.dsdsActionDispositionURL;
        this.dispositionDropdownItems$ = this._service.getArrayList(
            {
                where: {
                    servicereqtypeid: status,
                    servicereqconfigid: selectedConfigID.servicerequesttypeconfigid
                },
                method: 'get'
            }
            , url).pipe(map(data => {
                return data.map(
                    res =>
                        new DropdownModel({
                            text: res.description,
                            value: res.dispositioncode
                        })
                );
            }));
    }
    // For getting status checkbox values
    onStatusCheckBoxChange(value: string, event: Event) {
        const isChecked = (event.target as HTMLInputElement).checked;
        if (isChecked) {
            this.statusArray.push(value);
        } else {
            this.statusArray.splice(this.statusArray.indexOf(value), 1);
        }
    }
    // For getting type checkbox values
    onTypeCheckBoxChange(value: string, event: Event) {
        const isChecked = (event.target as HTMLInputElement).checked;
        if (isChecked) {
            this.typeArray.push(value);
        } else {
            this.typeArray.splice(this.typeArray.indexOf(value), 1);
        }
    }
    // For getting assigned checkbox values
    onAssignedCheckBoxChange(value: string, event: Event) {
        const isChecked = (event.target as HTMLInputElement).checked;
        if (isChecked) {
            this.assignedArray.push(value);
        } else {
            this.assignedArray.splice(this.typeArray.indexOf(value), 1);
        }
    }
    // Search functions
    searchDSDSAction(pageNo: number, modal: DsdsActionFilter) {
        modal = Object.assign(new DsdsActionFilter(), modal);
        if (this.statusArray.length) {
            modal.status = this.statusArray;
        }
        if (this.typeArray.length) {
            modal.srtype = this.typeArray;
        }
        if (this.assignedArray.length) {
            modal.assigned = this.assignedArray;
        }
        if (modal.reporteddate) {
            modal.reporteddate = this.today;
        }
        if (modal.duedate) {
            modal.duedate = this.today;
        }
        if (modal.overdue) {
            modal.overdue = this.today;
        }
        ObjectUtils.removeEmptyProperties(modal);
        const body: PaginationRequest = {
            limit: 10,
            page: pageNo,
            where: modal,
            method: 'post'
        };
        const source = this._service.getPagedArrayList(body).pipe(share());
        this.dsdsActionSearchData$.next(source.pipe(pluck('data')));
        if (pageNo === 1) {
            this.totalSearchRecord$.next(source.pipe(pluck('count')));
        }
    }
    // Cancel the modal pop up
    cancelDSDSActionModal() {
        this.clearFormGroup();
    }
    clearFormGroup() {
        this.dsdsActionForm.reset();
        this.dsdsActionForm.patchValue({ activeflag: 1, county: '', region: '', srtype: '', srsubtype: '', status: '', disposition: '' });
        this.statusArray = [];
        this.typeArray = [];
        this.assignedArray = [];
    }
    complexSearchDSDSAction() {
        this.clearFormGroup();
    }
}

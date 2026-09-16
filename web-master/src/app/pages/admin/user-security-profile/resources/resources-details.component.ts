
import {of as observableOf,  Observable, Subject } from 'rxjs';

import {map, pluck} from 'rxjs/operators';
import { AfterViewChecked, ChangeDetectorRef, Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, CommonHttpService, DataStoreService, GenericService } from '../../../../@core/services';
import { AdminUrlConfig } from '../../admin-url.config';
import { TeamDetails } from '../../team-position/_entities/teamposition.data.model';

declare let $: any;

@Component({
    selector: 'resources-details',
    templateUrl: './resources-details.component.html',
    styleUrls: ['./resources-details.component.scss'],
    standalone: false
})
export class ResourcesDetailsComponent implements OnInit, AfterViewChecked {


    loadNumber: string | undefined;
    teamId: string | undefined;
    @Input() reloadTreeSubject = new Subject();
    @Input() selectedTreeSubject = new Subject();
    @Input() teamDetails$: Observable<any> = new Observable<any>();
    @Input() selectedResourceId = new Subject<string>();
    @Input() totalCount$ = new Subject<any>();
    @Input() pageChangedRequest$ = new Subject<any>();
    @Input() teamMemeberDetails: TeamDetails = new TeamDetails();

    resourcesModule$: Observable<any> = new Observable<any>();
    resourcesTypes$: Observable<any> = new Observable<any>();
    paginationInfo: PaginationInfo = new PaginationInfo();
    totalRecordCount!: number;
    tempTeamId: string | undefined;
    actionLabel: string | undefined;
    teamDetailLabel: string | undefined;
    resourseFormGroup!: FormGroup;
    showModelBox = false;
    teamDetail: any[] = [];

    teamTypes: any[] = [];
    parentTeam$: Observable<any[]> = new Observable<any[]>();
    teamList$: Observable<any[]> = new Observable<any[]>();
    positionTeamlist: Array<any> = [];
    teammemberId: string | undefined;
    resourceList: any;
    teamDetailData: any;
    openingTimeHours: string | undefined;
    closingTimeHours: string | undefined;
    moduleField: boolean = false;
    constructor(
        private formBuilder: FormBuilder,
        private _service: GenericService<any>,
        private _commonService: CommonHttpService,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService,
        private cdRef: ChangeDetectorRef
    ) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamDetailsUrl;
    }
    deletepopupid = '#delete-popup';
    ngOnInit() {
        this.getResourcesTypes();
        this.getModulesList();
        this.showModelBox = false;
        this.selectedResourceId.subscribe((result) => {
            this.tempTeamId = result;
            this.loadNumber = '';
            this.showModelBox = false;
        });
        this.totalCount$.subscribe((item) => {
            this.totalRecordCount = item;
        });
        this._dataStoreService.currentStore.subscribe((item) => {
            if (item['Pagination_Reset']) {
                this.paginationInfo.pageNumber = 1;
            }
        });
        this.resourseFormGroup = this.formBuilder.group(
            {
                parentid: null,
                name: ['', [Validators.required]],
                description: [''],
                modulekey: [''],
                resourceid: ['', [Validators.required]],
                resourcetype: [null, [Validators.required]]
            }
        );
    }

    ngAfterViewChecked() {
        this.cdRef.detectChanges();
    }



    pageChanged(event: any) {
        this.pageChangedRequest$.next(event);
    }




    getResourcesTypes() {
        this.resourcesTypes$ = this._commonService
            .getArrayList(
                {
                    nolimit: true,
                    method: 'get',
                    where: {
                        referencetypeid: '344',
                        teamtypekey: 'CW'
                    }
                },
                AdminUrlConfig.EndPoint.resources.ResourcesTypeListUrl + '/gettypes?filter'
            ).pipe(
            map((result) => {
                return result;
            }));
    }






    saveResourse(_resourseData: any) {
        if (!this.resourseFormGroup.dirty && !this.resourseFormGroup.valid) {
            return false;
        }
        this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.Add;
        this._service.create(this.resourseFormGroup.value).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('Resourse setup details saved successfully');
                    $('#myModal-new-resource').modal('hide');
                    const data1: any = {
                        id : this.resourseFormGroup.get('parentid')?.value,
                        pageNo: 1
                    };
                    this.selectedTreeSubject.next(data1);
                    this.paginationInfo.pageNumber = 1;
                    this.reloadTreeSubject.next(null); // left side data refresh
                    this.clearFormGroup();
                }
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    deleteItem() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesAdd;
        this._service.patch(this.teamDetailData.id, { 'activeflag': 0 }).subscribe(
            (response: { parentid: any; }) => {
                if (response) {
                    this._alertService.success('Resource deleted successfully');
                    this.reloadTreeSubject.next(null);
                    const data1 = {
                        id : response.parentid,
                        pageNo: 1
                    };
                    this.selectedTreeSubject.next(data1);
                    this.paginationInfo.pageNumber = 1;
                    $(this.deletepopupid).modal('hide');
                }
            },
            (_error: any) => {
                $(this.deletepopupid).modal('hide');
                this._alertService.error('Cannot delete a Resource');
            }
        );
    }
    declineDelete() {
        $(this.deletepopupid).modal('hide');
    }
    confirmDelete(requestdataDelete: any) {
        if (requestdataDelete.id) {
            this.resourseFormGroup.patchValue({
                parentid: requestdataDelete.parentid,
            });
            this.teamDetailData = requestdataDelete;
            this.teamDetailData.id = requestdataDelete.id;
            $(this.deletepopupid).modal('show');
        }
    }

    editTeamItem(requestdata: any) {
        if (requestdata) {
            this.teamDetailData = requestdata;
            this.resourseFormGroup.patchValue({
                parentid: requestdata.parentid,
                name: requestdata.name,
                description: requestdata.description,
                modulekey: requestdata.modulekey,
                resourceid: requestdata.resourceid,
                resourcetype: String(requestdata.resourcetype)
            });
        }
        this.teamDetailLabel = 'Edit';
    }

    updateResourse() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesAdd;
            this._service.patch(this.teamDetailData.id, this.resourseFormGroup.value).subscribe(
                (response: { parentid: any; }) => {
                    if (response) {
                        this._alertService.success('Resource updated successfully');
                        $('#myModal-new-resource').modal('hide');
                        const data = {
                            id : response.parentid,
                            pageNo: this.paginationInfo.pageNumber,
                        };
                        this.selectedTreeSubject.next(data); // right side data refresh
                        this.reloadTreeSubject.next(null);
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );

    }



    clearFormGroup() {
        this.teamDetailLabel = 'Add';
        this.resourseFormGroup.reset();
        this.resourseFormGroup.patchValue({
            name: [''],
            description: [''],
            modulekey: [''],
            resourceid: [''],
            resourcetype: null
        });
    }




    getModulesList() {
        const moduleslist = this._commonService.getArrayList(
            {
                nolimit: true,
                method: 'get',
                where: {
                    resourcetype: '2'
                }
            },
            AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl + '?filter'
        ).pipe(map(response => {
            return response;
        }));
        this.resourcesModule$ = moduleslist.pipe(pluck('data'));
    }

    getListResource() {
        let listData:any = observableOf([]);
        let whereData: any;
        const parentidData = this.resourseFormGroup.get('parentid')?.value;
        if (parentidData) {
            whereData = {
                'activeflag': 1,
                'or': [{ parentid: parentidData },
                { id: parentidData }]
            };
        } else {
            whereData = {
                'or': [
                    {
                        'and': [
                            {
                                'parentid': null
                            },
                            {
                                'resourcetype': {
                                    'gt': 2
                                }
                            }
                        ]
                    },
                    {
                        'and': [
                            {
                                'parentid': null
                            },
                            {
                                'resourcetype': {
                                    'lt': 2
                                }
                            }
                        ]
                    }
                ]
            };
        }
        listData = this._commonService.getArrayList({
            // limit: pageSize,
            nolimit: 'true',
            method: 'get',
            where: whereData
        }, AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl + '?filter').pipe(map((item) => {
            return item;
        }));

        this.teamDetails$ = listData;
    }

    getControlByIndexFn(index: string): FormControl {
        return this.resourseFormGroup.controls[index] as FormControl;
    }
}



import {forkJoin as observableForkJoin,  Observable ,  Subject } from 'rxjs';

import {share, pluck, map} from 'rxjs/operators';
import { InvolvedPerson } from './../../../_entities/caseworker.data.model';
import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { AddServicePlanActivity, AddActivity } from '../_entities/service-plan.model';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonHttpService, AlertService, GenericService, DataStoreService } from '../../../../../@core/services';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { AuthService } from '../../../../../@core/services/auth.service';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'service-plan-add-edit-activity',
    templateUrl: './service-plan-add-edit-activity.component.html',
    styleUrls: ['./service-plan-add-edit-activity.component.scss'],
    standalone: false
})
export class ServicePlanAddEditActivityComponent implements OnInit {
    id!: string;
    activityCategoryTypes$!: Observable<DropdownModel[]>;
    activityCategorySubTypes$!: Observable<DropdownModel[]>;
    activityGoal$!: Observable<DropdownModel[]>;
    activityStatus$!: Observable<DropdownModel[]>;
    activityPersonInvloved$!: Observable<DropdownModel[]>;
    activityPersonResponsible$!: Observable<DropdownModel[]>;
    invoveldPerson$!: Observable<InvolvedPerson[]>;
    addServciePlanActivity!: AddServicePlanActivity;
    activityStrategy!: FormGroup;
    activityAdd!: AddActivity;
    serviceTypeId!: string;
    servieTypeKey!: string;
    token!: AppUser;
    mindate = new Date();
    @Output()
    acitityServie = new EventEmitter();
    @Input() editServicePlanOutputSubject$: Subject<AddActivity | null> = new Subject<AddActivity | null>();
    @Input()
    activityPlanActivityiId!: string;
    activityPlanActivityi!: string;
    updateServicePlanButton!: boolean;
    SaveServicePlanButton!: boolean;
    viewMode = false;
    constructor(
        private _httpService: CommonHttpService,
        private _formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _ativityServie: GenericService<AddActivity>,
        private _authService: AuthService,
        private _dataStoreService: DataStoreService
    ) {}

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.token = this._authService.getCurrentUser();
        this.activityStrategy = this._formBuilder.group({
            activity: ['', Validators.required],
            servicetypekey: [null],
            servicesubtypekey: [null],
            personinvolved: ['', Validators.required],
            responsibleperson: ['', Validators.required],
            reevaluationdate: [null],
            completiondate: [null],
            serviceplangoalid: [null],
            serviceplanactivitystatustypekey: ['', Validators.required]
        });
        this.getDefaults();
        this.getInvolvedPerson();
        this.editServicePlanOutputSubject$.subscribe((data: AddActivity | null) => {
            if (data && data.isAddEdit === 'Edit') {
                this.activityStrategy.patchValue(data);
                this.activityPlanActivityi = data.isAddEdit;
                this.updateServicePlanButton = true;
            } else if (data && data.isAddEdit === 'view') {
                this.activityStrategy.patchValue(data);
                this.activityPlanActivityi = data.isAddEdit;
                this.activityStrategy.patchValue({
                    responsibleperson: data.associatedworker,
                    });
                this.viewMode = true;
            } else {
                this.updateServicePlanButton = false;
            }
        });
    }

    clearItem() {
        this.editServicePlanOutputSubject$ = Object.assign({
            activity: '',
            servicetypekey: null,
            servicesubtypekey: null,
            personinvolved: '',
            responsibleperson: '',
            reevaluationdate: null,
            completiondate: null,
            serviceplangoalid: null,
            serviceplanactivitystatustypekey: null
        });
        this.activityStrategy.reset();
        this.activityStrategy.patchValue({ serviceType: '' });
    }
    saveActivity(ativity: AddActivity) {
        this.activityAdd = Object.assign(ativity);
        this.activityAdd.servicetypekey = ativity.servicetypekey;
        this.activityAdd.objecttypekey = 'ServiceRequest';
        this.activityAdd.objectid = this.id;
        this._ativityServie.endpointUrl = 'serviceplan/activity/';
        this._ativityServie.create(this.activityAdd).subscribe((_res: any) => {
                this.clearItem();
                $('#add-newactivity').modal('hide');
                this._alertService.success('Activity added successfully');
                this.acitityServie.emit();
            }, (_error: any) => {}
        );
    }

    UpdateActivity(ativity: AddActivity) {
        this.activityAdd = Object.assign(ativity);
        this.activityAdd.objecttypekey = 'ServiceRequest';
        this.activityAdd.objectid = this.id;
        this._httpService.patch(this.activityPlanActivityiId, this.activityAdd, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.DelectServicePlanUrl).subscribe(
            (res) => {
                this.clearItem();
                $('#add-newactivity').modal('hide');
                this._alertService.success('Activity Update successfully');
                this.acitityServie.emit();
            },
            (err) => {
                console.error(err)
            }
        );
    }

    private getDefaults() {
        const source = observableForkJoin([this.getCategoryType(), this.getCategorySubType(), this.getActivityGoal(), this.getStatus()]).pipe(
            map((item) => {
                return {
                    activityCategoryTypes: item[0].map((itm) => {
                        return new DropdownModel({
                            text: itm.servicetypedescription,
                            value: itm.servicetypekey
                        });
                    }),
                    activityCategorySubTypes: item[1].map((itm) => {
                        return new DropdownModel({
                            text: itm.servicesubtypedescription,
                            value: itm.servicesubtypekey
                        });
                    }),
                    activityGoal: item[2].map((itm) => {
                        return new DropdownModel({
                            text: itm.goal,
                            value: itm.serviceplangoalid
                        });
                    }),
                    activityStatus: item[3].map((itm) => {
                        return new DropdownModel({
                            text: itm.description,
                            value: itm.serviceplanactivitystatustypekey
                        });
                    })
                };
            }),
            share(),);
        this.activityCategoryTypes$ = source.pipe(pluck('activityCategoryTypes'));
        this.activityStatus$ = source.pipe(pluck('activityStatus'));
        this.activityGoal$ = source.pipe(pluck('activityGoal'));
        this.activityCategorySubTypes$ = source.pipe(pluck('activityCategorySubTypes'));
    }

    personResponsibleText(responseble: string) {
        this.activityStrategy.patchValue({
            personinvolved: responseble
        });
    }
    invlovedPersonText(person: string) {
        this.activityStrategy.patchValue({
            responsibleperson: person
        });
    }

    private getCategoryType() {
        return this._httpService.getArrayList( { where: {}, nolimit: true, method: 'get' },
        'servicetype?filter');
    }

    private  getCategorySubType() {
        return this._httpService.getArrayList({method: 'get', order: 'servicesubtypedescription', nolimit: true}, 'servicesubtype?filter');
    }

    private getActivityGoal() {
        return this._httpService.getArrayList({ method: 'get', where: { objectid: this.id } }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.GoalUrl + '?filter');
    }
    private getStatus() {
        return this._httpService.getArrayList({ nolimit: true, method: 'get' }, 'serviceplan/activitystatustype?filter');
    }
    private getInvolvedPerson() {
        this.invoveldPerson$ = this._httpService
            .getArrayList(
                {
                    where: { intakeserviceid: this.id },
                    page: 1,
                    limit: 10,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            ).pipe(
            map((itm: any) => {
                return itm['data'].filter((res: any) => res.ishousehold === 1);
            }));
    }
}

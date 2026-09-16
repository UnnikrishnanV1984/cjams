
import {pluck, map, share} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Observable ,  Subject } from 'rxjs';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { AddActivity, ServicePlanActivity } from '../_entities/service-plan.model';
import { ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'service-plan-activity',
    templateUrl: './service-plan-activity.component.html',
    styleUrls: ['./service-plan-activity.component.scss'],
    standalone: false
})
export class ServicePlanActivityComponent implements OnInit {
    servicePlanActivity$!: Observable<ServicePlanActivity[]>;
    servicePlanActivityCount$!: Observable<number>;
    totalResulRecords$!: Observable<number>;
    servicePlanId$ = new Subject<string>();
    @Input()
    servicePlanActivityiId!: string;
    @Input()
    activityPlanActivityiId!: string;
    id!: string;
   
    @Input() editServicePlanOutputSubject$: Subject<AddActivity | null> = new Subject<AddActivity | null>();

    constructor(private _httpService: CommonHttpService, private _formBuilder: FormBuilder, private _alertService: AlertService,
         private route: ActivatedRoute, private _dataStoreService: DataStoreService) {}

    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.getServicePlanActivity(1);
        this.viewServiceLog(null);
    }
    servicePlane() {
        this.getServicePlanActivity(1);
    }
    updateServicePlanActivityiId(id: any) {
        this.servicePlanActivityiId = id;
    }
    getServicePlanActivity(pageNo: number) {
        const source = this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    limit: 10,
                    page: pageNo,
                    where: { objectid: this.id },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ActivityUrl + '?filter'
            ).pipe(
            map(res => {
                return {
                    data: res.data,
                    count: res.count
                };
            }),
            share(),);
        this.servicePlanActivity$ = source.pipe(pluck('data'));
        this.servicePlanActivityCount$ = source.pipe(pluck('count'));
    }

    editServiceEmpty() {
        this.editServicePlanOutputSubject$.next(null);
    }

    editServicePlan(ativity: any) {
        this.activityPlanActivityiId = ativity.serviceplanactivityid;
        ativity.isAddEdit = 'Edit';
        this.editServicePlanOutputSubject$.next(ativity);
    }

    deleteServicePlan(activity: any) {
        this._httpService.patch(activity.serviceplanactivityid, { activeflag: 0 }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.DelectServicePlanUrl).subscribe(
            res => {
                this._alertService.success('Successfully deleted Activity');
                this.getServicePlanActivity(1);
            },
            err => {
                console.error(err);
            }
        );
    }

    viewServiceLog(serviceplanid: any) {
        this.servicePlanId$.next(serviceplanid);
    }
}

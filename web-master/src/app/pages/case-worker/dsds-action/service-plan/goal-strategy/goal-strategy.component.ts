
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { ServicePlanGoal, AddServicePlanGoal } from '../_entities/service-plan.model';
import { CommonHttpService, GenericService, AlertService, DataStoreService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'goal-strategy',
    templateUrl: './goal-strategy.component.html',
    styleUrls: ['./goal-strategy.component.scss'],
    standalone: false
})
export class GoalStrategyComponent implements OnInit {
    addServciePlanGoal!: AddServicePlanGoal;
    servicePlanGoal$!: Observable<ServicePlanGoal[]>;
    totalResulRecords$!: Observable<number>;
    goalStrategy!: FormGroup;
    id!: string;
    servicePlanGoalId!: string;
    isAdded!: boolean;
    addEditLabel!: string;
    maxdate = new Date();
    constructor(
        private _httpService: CommonHttpService,
        private _addGoalService: GenericService<AddServicePlanGoal>,
        private _formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService
    ) {}
    ngOnInit() {
        this.isAdded = true;
        this.addEditLabel = 'Add New';
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.goalStrategy = this._formBuilder.group({
            goal: [''],
            goaldate: [''],
            strategy: ['']
        });
        this.getServicePlanGoal(1);
    }
    addServicePlanGoal(goal: AddServicePlanGoal) {
        this.addServciePlanGoal = Object.assign(goal);
        this.addServciePlanGoal.objecttypekey = 'ServiceRequest';
        this.addServciePlanGoal.objectid = this.id;
        this._addGoalService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.GoalUrl + '/'; // WSO2;
        this._addGoalService.create(this.addServciePlanGoal).subscribe((_response: any) => {
                this._alertService.success('Goal added successfully');
                this.goalStrategy.reset();
                this.clearGoals();
                $('#cls-add-goal').click();
                this.getServicePlanGoal(1);
            }, (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    editGoals(model: any) {
        this.isAdded = false;
        this.addEditLabel = 'Edit';
        this.goalStrategy.patchValue(model);
        this.servicePlanGoalId = model.serviceplangoalid;
    }
    updateServicePlanGoal(item: any) {
        this.addServciePlanGoal = Object.assign(item);
        this.addServciePlanGoal.objecttypekey = 'ServiceRequest';
        this.addServciePlanGoal.objectid = this.id;
        this._addGoalService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.GoalUrl + '/';
        this._addGoalService.patch(this.servicePlanGoalId, this.addServciePlanGoal).subscribe((_response: any) => {
                this._alertService.success('Goal updated successfully');
                this.goalStrategy.reset();
                this.clearGoals();
                $('#cls-add-goal').click();
                this.getServicePlanGoal(1);
            }, (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    deleteServicePlanGoal(goal: any) {
        this._httpService.patch(goal.serviceplangoalid, { activeflag: 0 }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.GoalUrl).subscribe(
            res => {
                this._alertService.success('Goal deleted successfully');
                this.getServicePlanGoal(1);
            },
            err => {
                console.error(err);
            }
        );
    }
    clearGoals() {
        this.addEditLabel = 'Add New';
        this.goalStrategy.reset();
        this.isAdded = true;
    }
    getServicePlanGoal(pageNo: number) {
        this.servicePlanGoal$ = this._httpService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    page: pageNo,
                    where: { objectid: this.id },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.GoalUrl + '?filter'
            ).pipe(
            map(res => {
                return res;
            }));
    }
}

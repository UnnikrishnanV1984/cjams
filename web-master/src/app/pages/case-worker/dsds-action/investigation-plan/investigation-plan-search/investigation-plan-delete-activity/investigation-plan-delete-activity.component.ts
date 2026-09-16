
import {share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { PaginationInfo, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { AlertService, CommonHttpService, DataStoreService } from '../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { DeleteTask, DeleteActivity } from '../../_entities/investigationplan.data.models';
import { Observable } from 'rxjs';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-plan-delete-activity',
    templateUrl: './investigation-plan-delete-activity.component.html',
    styleUrls: ['./investigation-plan-delete-activity.component.scss'],
    standalone: false
})
export class InvestigationPlanDeleteActivityComponent implements OnInit {
    daNumber: string;
    id: string;
    tempSelectedActivity!: string;
    deleteActivityFormGroup!: FormGroup;
    deleteTaskFormGroup!: FormGroup;
    paginationInfo: PaginationInfo = new PaginationInfo();
    deleteActivity!: DeleteActivity;
    deleteTask!: DeleteTask;
    listActivity$!: Observable<DeleteActivity[]>;
    listTask$!: Observable<DeleteTask[]>;
    private investigationID: string;
    constructor(private formBuilder: FormBuilder, private _router: Router, private _service: CommonHttpService, private route: ActivatedRoute, private _alertService: AlertService,
        private _dataStoreService: DataStoreService) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.investigationID = this.route.snapshot.params['investigationID'];
    }

    ngOnInit() {
        this.deleteActivityFormGroup = this.formBuilder.group({
            leftSelectedItems: ['', Validators.required]
        });
        $('#myModal-delete-activities-tasks').modal('show');
        this.listActivity();
        this.deleteTaskFormGroup = this.formBuilder.group({
            rightSelectedItems: ['', Validators.required]
        });
    }

    listActivity() {
        this.listActivity$ = this._service
            .getArrayList(
                new PaginationRequest({
                    order: 'insertedon desc',
                    where: {
                        objectid: this.investigationID,
                        activeflag: 1
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GetActivitiesListUrl + '?filter'
            ).pipe(
            share());
    }

    changeActivity(_event: any) {
        this.deleteTaskFormGroup.patchValue({ rightSelectedItems: '' });
        this.listTask$ = this._service
            .getArrayList(
                new PaginationRequest({
                    order: 'insertedon desc',
                    where: {
                        activityid: this.deleteActivityFormGroup.value.leftSelectedItems,
                        activeflag: 1
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GetActivityTaskUrl + '?filter'
            ).pipe(
            share());
    }

    deleteSelectedActivity() {
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GetActivitiesUrl;
        this._service.patch(this.deleteActivityFormGroup.value.leftSelectedItems, { activeflag: 0, expirationdate: new Date() }).subscribe(
            (response) => {
                this.listActivity();
                this._alertService.success('Activity deleted successfully');
                this.closePopup();
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    closePopup() {
        $('.modal').modal('hide');
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/investigation-plan';
        this._router.navigateByUrl(currentUrl).then(() => {
            this._router.navigated = false;
            this._router.navigate([currentUrl]);
        });
    }

    deleteSelectedTask() {
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GetActivityTaskUrl;
        this._service.patch(this.deleteTaskFormGroup.value.rightSelectedItems, { activeflag: 0, expirationdate: new Date() }).subscribe(
            (response) => {
                this.changeActivity('');
                this._alertService.success('Task deleted successfully');
                this.closePopup();
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    declineDeleteActivity() {
        $('#delete-popup').modal('hide');
    }
    confirmDeleteActivity(requestData: DeleteActivity) {
        this.deleteActivity = requestData;
        $('#delete-popup').modal('show');
    }
    declineDeleteTask() {
        $('#delete-popup-task').modal('hide');
    }
    confirmDeleteTask(requestData: DeleteTask) {
        this.deleteTask = requestData;
        $('#delete-popup-task').modal('show');
    }
}

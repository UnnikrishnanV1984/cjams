
import {pluck, share, map} from 'rxjs/operators';
import { DatePipe } from '@angular/common';
import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';

import { DropdownModel } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { AuthService, AlertService, GenericService, DataStoreService } from '../../../../../../@core/services';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { CreateTaskModal } from '../../_entities/investigationplan.data.models';
import { ObjectUtils } from '../../../../../../@core/common/initializer';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-plan-task',
    templateUrl: './investigation-plan-task.component.html',
    styleUrls: ['./investigation-plan-task.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class InvestigationPlanTaskComponent implements OnInit {
    taskFormGroup!: FormGroup;
    daNumber: string;
    id: string;
    isPhActivity!: boolean;
    currentUserLoadNumber!: string;
    taskStatusType = false;
    activityTask = new CreateTaskModal();
    activityDropdownItems$!: Observable<DropdownModel[]>;
    statusDropdownItems$!: Observable<DropdownModel[]>;
    typeDropdownItems$!: Observable<DropdownModel[]>;
    usersProfileDropdownItems$!: Observable<DropdownModel[]>;
    dispositionDropdownItems$!: Observable<DropdownModel[]>;
    taskTypeStatusDropdownItems$!: Observable<DropdownModel[]>;
    taskCommunicationDropdownItems$!: Observable<DropdownModel[]>;
    private investigationID: string;
    private loadNumber: string;
    showSubType = false;

    private route: ActivatedRoute;
    private _authService: AuthService;
    private _taskService: GenericService<CreateTaskModal>;
    private formBuilder: FormBuilder;
    private _alertService: AlertService;
    private _commonHttpService: CommonHttpService;
    private datePipe: DatePipe;
    private _dataStoreService: DataStoreService;


    constructor(private injector: Injector){
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._taskService = this.injector.get<GenericService<CreateTaskModal>>(GenericService);
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.datePipe = this.injector.get<DatePipe>(DatePipe);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.investigationID = this.route.snapshot.params['investigationID'];
        this.loadNumber = this.route.snapshot.params['loadNumber'];
    }

    ngOnInit() {
        this.creatTaskForm();
        this.taskFormGroup.get('startdate')?.valueChanges.subscribe(() => {
            this.changeStartDate();
        });
        this.taskFormGroup.get('enddate')?.valueChanges.subscribe(() => {
            this.changeEndDate();
        });
        this.loadDropdown();
        this.taskStatusType = false;
        this.taskFormGroup.patchValue({ assignedon: new Date(), createddate: new Date()});
    }
    creatTaskForm() {
        this.taskFormGroup = this.formBuilder.group(
            {
                activityItems: ['', Validators.required],
                name: ['', Validators.required],
                description: ['', Validators.required],
                taskTypeItems: ['', Validators.required],
                duedate: ['', Validators.required],
                assignedto: ['', Validators.required],
                assignedon: [''],
                statustask: ['', Validators.required],
                taskdisposition: ['', Validators.required],
                completeddate: [''],
                requiredtask: [false],
                createddate: [''],
                outofoffice: [''],
                startdate: [''],
                starttime: [''],
                starttimeformat: [''],
                enddate: [''],
                endtime: [''],
                endtimeformat: [''],
                taskcommunication: ['']
            },
            { validators: [this.checkDateRange, this.checkCompletedDate] }
        );
    }
    checkDateRange(taskFormGroup: any) {
        if (taskFormGroup.controls.duedate.value) {
            if (taskFormGroup.controls.createddate.value > taskFormGroup.controls.duedate.value) {
                return { notValid: true };
            }
            return null;
        }
    }
    checkCompletedDate(taskFormGroup: any) {
        if (taskFormGroup.controls.completeddate.value) {
            if ( taskFormGroup.controls.assignedon.value > taskFormGroup.controls.completeddate.value ) {
                return { notValidCompletedDate: true };
            }
            return null;
        }
    }
    loadDropdown() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.InvestigationActivitiesUrl + '/' + this.id + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.UserProfilekUrl + '?filter'
            )
        ]).pipe(
            map((result: any) => {
                const userInfo = this._authService.getCurrentUser();
                if (userInfo && userInfo.user.userprofile) {
                    const currentUserLoadInfo = result[1].filter((res: { displayname: string; }) => res.displayname === userInfo.user.userprofile.displayname);
                    if (currentUserLoadInfo.length) {
                        this.currentUserLoadNumber = currentUserLoadInfo[0].loadnumber;
                        this.taskFormGroup.patchValue({ assignedto: this.currentUserLoadNumber });
                    }
                }
                return {
                    activity: result[0]['investigation'][0]['activity'].map(
                        (res: { description: any; activityid: string; activitytypekey: string; }) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.activityid + '$' + res.activitytypekey
                            })
                    ),
                    usersProfile: result[1].map((res: { displayname: any; securityusersid: any; }) => {
                        return new DropdownModel({
                            text: res.displayname,
                            value: res.securityusersid
                        });
                    })
                };
            }),
            share(),);
        this.activityDropdownItems$ = source.pipe(pluck('activity'));
        this.usersProfileDropdownItems$ = source.pipe(pluck('usersProfile'));
    }

    onChangeActivity(option: any) {
        this.getDropdown(option.value.split('$')[1]);
        if (option && (option.label === 'Project Home - Reconsideration' || option.label.trim() === 'Adult Foster Care - Reconsideration')) {
            this.isPhActivity = true;
        } else {
            this.isPhActivity = false;
        }
    }

    getDropdown(activitytypekey: any) {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: 1, activitytypekey: activitytypekey },
                    order: 'typedescription asc',
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.ActivityAllTaskUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: 1, activitytypekey: activitytypekey },
                    order: 'typedescription asc',
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.TaskStatusTypeUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    tasktype: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitytasktypekey
                            })
                    ),
                    tasktypestatus: result[1].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitytaskstatustypekey
                            })
                    )
                };
            }),
            share(),);
        this.typeDropdownItems$ = source.pipe(pluck('tasktype'));
        this.taskTypeStatusDropdownItems$ = source.pipe(pluck('tasktypestatus'));
    }
    getTaskDisposition(tasktypekey: any, taskstatustypekey: any, activitytypekey: any) {
        const source = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        activitytasktypekey: tasktypekey,
                        activitytaskstatustypekey: taskstatustypekey,
                        activitytypekey: activitytypekey
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.InvestigationDispositionUrl + '?filter'
            ).pipe(
            map((result) => {
                return {
                    disposition: result.map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitytaskdispositiontypekey
                            })
                    )
                };
            }),
            share(),);
        this.taskFormGroup.patchValue({
            disposition: ''
        });
        this.dispositionDropdownItems$ = source.pipe(pluck('disposition'));
    }
    changeTaskStatusType() {
        this.getTaskDisposition(this.taskFormGroup.value.taskTypeItems, this.taskFormGroup.value.statustask, this.taskFormGroup.value.activityItems.split('$')[1]);
    }
    changeAssignedTo() {
        this.taskFormGroup.get('assignedto')?.enable();
    }

    changeType(event: any) {
        if (event.label === 'Contact') {
            this.taskStatusType = true;
        } else {
            this.taskStatusType = false;
        }
        if (event.value === 'Invcommunication') {
            this.taskFormGroup.get('taskcommunication')?.setValidators([Validators.required]);
            this.taskFormGroup.get('taskcommunication')?.updateValueAndValidity();
            this.showSubType = true;
            this.getTaskCommunication();
        } else {
            this.taskFormGroup.get('taskcommunication')?.clearValidators();
            this.taskFormGroup.get('taskcommunication')?.updateValueAndValidity();
            this.showSubType = false;
        }
    }

    changeStartDate() {
        this.taskFormGroup.patchValue({
            starttime: this.taskFormGroup.get('startdate')?.value.getHours() + ':' + this.taskFormGroup.get('startdate')?.value.getMinutes(),
            starttimeformat: this.taskFormGroup.get('startdate')?.value.getHours() >= 12 ? 'PM' : 'AM'
        });
    }

    changeEndDate() {
        this.taskFormGroup.patchValue({
            endtime: this.taskFormGroup.get('enddate')?.value.getHours() + ':' + this.taskFormGroup.get('enddate')?.value.getMinutes(),
            endtimeformat: this.taskFormGroup.get('enddate')?.value.getHours() >= 12 ? 'PM' : 'AM'
        });
    }

    saveTask() {
        this.activityTask = Object.assign({}, this.taskFormGroup.value);
        this.activityTask.iseditable = this.isPhActivity;
        this.activityTask.activityid = this.taskFormGroup.value.activityItems.split('$')[0];
        this.activityTask.activitytaskstatustypekey = this.taskFormGroup.value.statustask;
        this.activityTask.activitytaskdispositiontypekey = this.taskFormGroup.value.taskdisposition;
        this.activityTask.activitytasktypekey = this.taskFormGroup.value.taskTypeItems;
        this.activityTask.required = this.taskFormGroup.value.requiredtask;
        this.activityTask.taskcommunicationtypekey = this.taskFormGroup.value.taskcommunication;
        if (this.taskFormGroup.value.startdate) {
            this.activityTask.startdatetime = this.datePipe.transform(this.taskFormGroup.value.startdate, 'yyyy-MM-dd') + ' ' + this.taskFormGroup.value.starttime;
            this.activityTask.enddatetime = this.datePipe.transform(this.taskFormGroup.value.enddate, 'yyyy-MM-dd') + ' ' + this.taskFormGroup.value.endtime;
        }
        ObjectUtils.removeEmptyProperties(this.activityTask);
        this.activityTask.required = this.taskFormGroup.get('requiredtask')?.value;
        this._taskService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GetActivityTaskUrl;
        this._taskService.create(this.activityTask).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('Task Created Successfully');
                    $('#myModal-add-task').modal('hide');
                }
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    getTaskCommunication() {
        this.taskCommunicationDropdownItems$ = this._commonHttpService
            .getArrayList({}, 'taskcommunicationtype').pipe(
            map((result) => {
                return result.map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.taskcommunicationtypekey
                            })
                    );
            }));
    }

    getControlByIndexFn(index: string): FormControl {
        return this.taskFormGroup.controls[index] as FormControl;
    }
}

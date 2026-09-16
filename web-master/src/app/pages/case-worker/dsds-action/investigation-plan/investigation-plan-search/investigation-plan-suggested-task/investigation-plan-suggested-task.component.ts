
import {map} from 'rxjs/operators';
import { ChangeDetectorRef, Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable } from 'rxjs';

import { DropdownModel } from '../../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService, GenericService, DataStoreService } from '../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { Goal, SaveActivity, SuggestedTask, Task, ActivityTaskModal } from '../../_entities/investigationplan.data.models';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-plan-suggested-task',
    templateUrl: './investigation-plan-suggested-task.component.html',
    styleUrls: ['./investigation-plan-suggested-task.component.scss'],
    standalone: false
})
export class InvestigationPlanSuggestedTaskComponent implements OnInit {
    daNumber: string;
    formGroup!: FormGroup;
    id: string;
    amactivityid!: string;
    ammappingid!: string;
    activityid!: string;
    saveActivty: SaveActivity = new SaveActivity();
    suggestedTasks: SuggestedTask[] = [];
    taskItems!: Task[];
    goalItems!: Goal[];
    tasks: Task[] = [];
    goals: Goal[] = [];

    leftTasks: Task[] = [];
    rightTasks: Task[] = [];
    leftGoals: Goal[] = [];
    rightGoals: Goal[] = [];
    activityDropdownItems$!: Observable<DropdownModel[]>;
    activityTasks!: ActivityTaskModal[];
    isInitialized = false;
    private investigationID: string;
    private leftSelectedTasks: Task[] = [];
    private rightSelectedTasks: Task[] = [];
    private leftSelectedGoals: Goal[] = [];
    private rightSelectedGoals: Goal[] = [];

    noitemselectedmsg = 'No items selected.';

    private formBuilder: FormBuilder;
    private _service: GenericService<SuggestedTask>;
    private _activityService: GenericService<SaveActivity>;
    private _commonHttpService: CommonHttpService;
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _router: Router;
    private _changeDetect: ChangeDetectorRef;
    private _dataStoreService: DataStoreService;

    constructor(private injector:Injector){
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._service = this.injector.get<GenericService<SuggestedTask>>(GenericService);
        this._activityService = this.injector.get<GenericService<SaveActivity>>(GenericService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._router = this.injector.get<Router>(Router);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.investigationID = this.route.snapshot.params['investigationID'];
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.InvestigationActivitiesUrl;
    }

    ngOnInit() {
        this.formGroup = this.formBuilder.group({
            leftSelectedTask: [''],
            rightSelectedTask: [''],
            leftSelectedGoals: [''],
            rightSelectedGoals: [''],
            selectActivityList: ['']
        });
        this.isInitialized = true;
        this._dataStoreService.currentStore.subscribe(storeData => {
            if (this.isInitialized && storeData['SUBSCRIPTION_TARGET'] === 'ACTIVITY_TASK_LOAD') {
                this.activityTasks = storeData['ACTIVITY_TASK'];
                this.isInitialized = false;
            }
        });
        this.getAvailableActivityList();
        $('#myModal-suggested-tasks').modal('show');
    }
    getActivityList() {
        this.activityDropdownItems$ = this._commonHttpService
            .getArrayList({ method: 'get' }, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.InvestigationActivitiesUrl + '/' + this.id + '?filter').pipe(
            map((result: any) => {
                return result['investigation'][0]['activity'].map((res: { description: any; activityid: string; ammappingid: string; }) => new DropdownModel({ text: res.description, value: res.activityid + '$' + res.ammappingid }));
            }));
    }
    getAvailableActivityList() {
        this.activityDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    order: 'name ASC',
                    where: {
                        activitytypekey: { inq: ['Allegation', 'Investigation'] },
                        activeflag: 1,
                        ondemand: 't'
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.AmmappingListUrl + '?filter'
            ).pipe(
            map((result: any) => {
                return result['data'].map((res: { description: any; amactivityid: string; ammappingid: string; }) => new DropdownModel({ text: res.description, value: res.amactivityid + '$' + res.ammappingid }));
            }));
    }
    onChangeActivity(option: any) {
        this.rightGoals = [];
        this.rightTasks = [];
        this.amactivityid = option.value.split('$')[0];
        this.ammappingid = option.value.split('$')[1];
        this._service
            .getPagedArrayList(
                {
                    where: {
                        activitytypekey: 'Investigation',
                        ammappingid: this.ammappingid
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.MappingListUrl + '?filter'
            )
            .subscribe(result => {
                this.suggestedTasks = result.data;
                this.leftTasks = this.suggestedTasks[0].ammapping[0].ammappingtask.map(item => {
                    return Object.assign({
                        activityid: this.activityid,
                        amtaskid: item.amtaskid,
                        name: item.amtask.name,
                        helptext: item.helptext,
                        activitytasktypekey: item.activitytasktypekey,
                        activityprioritytypekey: item.activityprioritytypekey,
                        description: item.amtask.name,
                        assignedto: item.assignedto,
                        activitytaskstatustypekey: 'InvOpen',
                        required: '1',
                        activeflag: '1',
                        isSelected: false,
                        iseditable: this.suggestedTasks[0].ammapping[0].iseditable
                    });
                });
                this.leftGoals = this.suggestedTasks[0].ammapping[0].ammappinggoal.map(goal => {
                    return Object.assign({
                        amgoalid: goal.amgoalid,
                        name: goal.amgoal.name,
                        description: goal.description,
                        activityid: this.activityid,
                        activitygoalstatustypekey: goal.activitygoalstatustypekey,
                        activitygoaltypekey: goal.activitygoaltypekey,
                        activityprioritytypekey: goal.activityprioritytypekey,
                        required: '1',
                        activeflag: '1',
                        isSelected: false
                    });
                });
            });
        this.buttonStateSelected();
        this.buttonStateSuggested();
    }
    selectAllTask() {
        if (this.leftTasks.length) {
            this.moveTasks(this.leftTasks, this.rightTasks, Object.assign([], this.leftTasks));
            this.clearSelectedTasks('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    selectTask() {
        if (this.leftSelectedTasks.length) {
            this.moveTasks(this.leftTasks, this.rightTasks, this.leftSelectedTasks);
            this.clearSelectedTasks('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelectTask() {
        if (this.rightSelectedTasks.length) {
            this.moveTasks(this.rightTasks, this.leftTasks, this.rightSelectedTasks);
            this.clearSelectedTasks('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelectAllTask() {
        if (this.rightTasks.length) {
            this.moveTasks(this.rightTasks, this.leftTasks, Object.assign([], this.rightTasks));
            this.clearSelectedTasks('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    selectAllGoals() {
        if (this.leftGoals.length) {
            this.moveGoals(this.leftGoals, this.rightGoals, Object.assign([], this.leftGoals));
            this.clearSelectedGoals('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    selectGoals() {
        if (this.leftSelectedGoals.length) {
            this.moveGoals(this.leftGoals, this.rightGoals, this.leftSelectedGoals);
            this.clearSelectedGoals('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelectGoals() {
        if (this.rightSelectedGoals.length) {
            this.moveGoals(this.rightGoals, this.leftGoals, this.rightSelectedGoals);
            this.clearSelectedGoals('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelectAllGoals() {
        if (this.rightGoals.length) {
            this.moveGoals(this.rightGoals, this.leftGoals, Object.assign([], this.rightGoals));
            this.clearSelectedGoals('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    activitySave() {
        if (this.activityTasks) {
            this.rightTasks.forEach(res => {
                const activity = this.activityTasks.filter(item => item.amtaskid === res.amtaskid);
                if (!activity.length) {
                    this.saveActivty.activitytask.push(res);
                }
            });
        } else {
            this.saveActivty.activitytask = this.rightTasks;
        }
        if (this.saveActivty.activitytask.length > 0) {
            this._activityService.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.AddTaskUrl;
            this.saveActivty.intakeserviceid = this.investigationID;
            this.saveActivty.amactivityid = this.amactivityid;
            this.saveActivty.ammappingid = this.ammappingid;
            this.saveActivty.activitytypekey = 'Investigation';
            delete this.saveActivty.goal;
            this._activityService.create(this.saveActivty).subscribe((response: any) => {
                if (response) {
                    this.closePopup();
                    this.getAvailableActivityList();
                    this.rightGoals = [];
                    this.rightTasks = [];
                }
            });
        } else {
            this._alertService.error('Activity task already exist');
        }
    }
    closePopup() {
        $('#myModal-suggested-tasks').modal('hide');
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/investigation-plan';
        this._router.navigateByUrl(currentUrl).then(() => {
            this._router.navigated = true;
            this._router.navigate([currentUrl]);
            this._alertService.success('Activities saved successfully!');
        });
    }
    buttonStateSelected() {
        return this.leftTasks ? false : true;
    }
    buttonStateSuggested() {
        return this.leftGoals ? false : true;
    }

    toggleTask(position: string, selectedItem: Task, control: any) {
        if (position === 'left') {
            if (control.target.checked) {
                this.leftSelectedTasks.push(selectedItem);
            } else {
                const index = this.leftSelectedTasks.indexOf(selectedItem);
                this.leftSelectedTasks.splice(index, 1);
            }
        } else {
            if (control.target.checked) {
                this.rightSelectedTasks.push(selectedItem);
            } else {
                const index = this.rightSelectedTasks.indexOf(selectedItem);
                this.rightSelectedTasks.splice(index, 1);
            }
        }
    }

    private moveTasks(source: Task[], target: Task[], selectedItems: Task[]) {
        selectedItems.forEach((item: Task, i) => {
            const selectedIndex = source.indexOf(item);
            if (selectedIndex !== -1 /*selectedItem.length*/) {
                source.splice(selectedIndex, 1);
                target.push(item);
            }
        });
        this._changeDetect.detectChanges();
    }

    private clearSelectedTasks(position: string) {
        if (position === 'left') {
            this.leftSelectedTasks = [];
        } else {
            this.rightSelectedTasks = [];
        }
    }

    toggleGoal(position: string, selectedItem: Goal, control: any) {
        if (position === 'left') {
            if (control.target.checked) {
                this.leftSelectedGoals.push(selectedItem);
            } else {
                const index = this.leftSelectedGoals.indexOf(selectedItem);
                this.leftSelectedGoals.splice(index, 1);
            }
        } else {
            if (control.target.checked) {
                this.rightSelectedGoals.push(selectedItem);
            } else {
                const index = this.rightSelectedGoals.indexOf(selectedItem);
                this.rightSelectedGoals.splice(index, 1);
            }
        }
    }

    private moveGoals(source: Goal[], target: Goal[], selectedItems: Goal[]) {
        selectedItems.forEach((item: Goal, i) => {  // NOSONAR  // Goal and Task having 3 lines of identical code. Hence marking it as no sonar.
            const selectedIndex = source.indexOf(item);
            if (selectedIndex !== -1 /*selectedItem.length*/) {
                source.splice(selectedIndex, 1);
                target.push(item);
            }
        });
        this._changeDetect.detectChanges();
    }

    private clearSelectedGoals(position: string) {
        if (position === 'left') {
            this.leftSelectedGoals = [];
        } else {
            this.rightSelectedGoals = [];
        }
    }

    getControlByIndexFn(index: string): FormControl {
        return this.formGroup.controls[index] as FormControl;
    }
}

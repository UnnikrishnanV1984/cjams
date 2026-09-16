
import {map, share, pluck} from 'rxjs/operators';
import {
    AfterViewChecked,
    AfterViewInit,
    ChangeDetectionStrategy,
    ChangeDetectorRef,
    Component,
    OnInit,
} from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable ,  forkJoin } from 'rxjs';

import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, CommonHttpService, GenericService } from '../../../../../@core/services';
import { AdminUrlConfig } from '../../../admin-url.config';
import {
    DSDSActionMapping,
    DSDSActionMappingDetail,
    DSDSActionMappingGoal,
    DSDSActionMappingGoalDetail,
    DSDSActionMappingTask,
    DSDSActionMappingTaskDetail,
} from '../../_entities/dsds-action-mapping.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-dsds-action-mapping',
    templateUrl: './add-edit-dsds-action-mapping.component.html',
    styleUrls: ['./add-edit-dsds-action-mapping.component.scss'],
    changeDetection: ChangeDetectionStrategy.Default,
    standalone: false
})
export class AddEditDSDSActionMappingComponent implements OnInit, AfterViewInit, AfterViewChecked {
    id = '0';
    isEditMode = false;
    titleHead = 'Add';
    addEditDSDSActionMappingForm!: FormGroup;
    addEditDSDSActionMappingTaskTypeForm!: FormGroup;
    addEditDSDSActionMappingGoalTypeForm!: FormGroup;
    activityCategoryDropdownItems$!: Observable<DropdownModel[]>;
    taskDropdownItems$!: Observable<DropdownModel[]>;
    goalDropdownItems$!: Observable<DropdownModel[]>;
    daTypeDropdownItems$!: Observable<DropdownModel[]>;
    daSubTypeDropdownItems$!: Observable<DropdownModel[]>;
    editDSDSData$!: Observable<DSDSActionMapping>;
    taskTypeDropdownItems!: DropdownModel[];
    goalTypeDropdownItems!: DropdownModel[];
    priorityTypeDropdownItems!: DropdownModel[];
    private selectedGoalName = '';
    private selectedTaskName = '';
    private selectedGoalId = '';
    private selectedTaskId = '';
    constructor(
        private readonly router: Router,
        private readonly route: ActivatedRoute,
        private readonly formBuilder: FormBuilder,
        private readonly _dsdsActionMappingService: GenericService<DSDSActionMapping>,
        private readonly _commonHttpService: CommonHttpService,
        private readonly _alertService: AlertService,
        private readonly _changeDetect: ChangeDetectorRef
    ) {}

    ngOnInit() {
        this.formGroupInitialize();
        this.loadMainDropdowns();
        this.route.params.subscribe((item) => {
            this.id = item['id'];
            if (this.id !== '0') {
                this.isEditMode = true;
                this.titleHead = 'Edit';
                const editdata = this._dsdsActionMappingService
                    .getSingle(
                        new PaginationRequest({
                            where: {
                                activitytypekey: 'Investigation',
                                ammappingid: this.id
                            },
                            method: 'get'
                        }),
                        AdminUrlConfig.EndPoint.DAConfig.MappingListUrl
                    ).pipe(
                    share());

                    this.editDSDSData$ = editdata.pipe(
                        pluck('data'),
                        map((data:any) => data as DSDSActionMapping)
                      );
            }
            $('#add-edit-dsds-action-mapping').modal('show');
        });
    }

    ngAfterViewInit() {
        if (this.id !== '0') {
            this.editDSDSData$.subscribe((result: any) => {
                if (result.length && result[0].ammapping.length && result[0].ammapping[0].daobj.length && result[0].ammapping[0].daobj[0].intakeservreqtypeid) {
                    this.onChangeDaSubType(result[0].ammapping[0].daobj[0].intakeservreqtypeid);
                }
                this.setFormGroup(result);
            });
        }
    }

    ngAfterViewChecked() {
        // explicit change detection to avoid "expression-has-changed-after-it-was-checked-error"
        this._changeDetect.detectChanges();
    }

    closeItem() {
        $('#add-edit-dsds-action-mapping').modal('hide');
        this.router.navigate(['/pages/admin/da-config/actions-tasks-goals/dsds-action-mappings']);
    }

    addTask(_task: any) {
        const taskInfo = new DSDSActionMappingTask();
        taskInfo.amtask = new DSDSActionMappingTaskDetail();
        taskInfo.amtask.description = this.selectedTaskName;
        taskInfo.amtask.amtaskid = this.selectedTaskId;
        this.setTask(taskInfo);
        this.addEditDSDSActionMappingTaskTypeForm.patchValue({ taskType: '' });
    }

    changeTask(option: any) {
        this.selectedTaskName = option.label;
        this.selectedTaskId = option.value;
    }

    removeTask(i: number) {
        const control = <FormArray>this.addEditDSDSActionMappingForm.controls['ammappingtask'];
        control.removeAt(i);
        this.addEditDSDSActionMappingForm.markAsDirty();
    }

    addGoal(_goal: any) {
        const goalInfo = new DSDSActionMappingGoal();
        goalInfo.amgoal = new DSDSActionMappingGoalDetail();
        goalInfo.amgoal.description = this.selectedGoalName;
        goalInfo.amgoal.amgoalid = this.selectedGoalId;
        this.setGoal(goalInfo);
        this.addEditDSDSActionMappingGoalTypeForm.patchValue({ goalType: '' });
    }

    changeGoal(option: any) {
        this.selectedGoalName = option.label;
        this.selectedGoalId = option.value;
    }

    removeGoal(i: number) {
        const control = <FormArray>this.addEditDSDSActionMappingForm.controls['ammappinggoal'];
        control.removeAt(i);
        this.addEditDSDSActionMappingForm.markAsDirty();
    }

    onChangeDaSubType(intakeservreqtypeid: string) {
        this.daSubTypeDropdownItems$ = this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    nolimit: true,
                    order: 'workloadweight ASC',
                    where: { intakeservreqtypeid: intakeservreqtypeid },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.DAConfig.DaConfigSubtypeUrl + '/list?filter'
            ).pipe(
            map((result) => {
                return result.data.map(
                    (res) =>
                        new DropdownModel({
                            text: res.classkey,
                            value: res.servicerequestsubtypeid
                        })
                );
            }));
    }
    saveMapping() {
        let url = 'admin/ammapping/mappingAdd';
        const actionMappingDetail = Object.assign(new DSDSActionMappingDetail(), this.addEditDSDSActionMappingForm.value);
        if (this.addEditDSDSActionMappingForm.value.demandReview === 'ondemand') {
            actionMappingDetail.ondemand = true;
            actionMappingDetail.isreviewactivity = false;
        } else if (this.addEditDSDSActionMappingForm.value.demandReview === 'isreviewactivity') {
            actionMappingDetail.ondemand = false;
            actionMappingDetail.isreviewactivity = true;
        }
        actionMappingDetail.activeflag = '1';
        actionMappingDetail.activitytypekey = 'Investigation';
        actionMappingDetail.servicerequestid = actionMappingDetail.intakeservreqtypeid;
        if (this.id !== '0') {
            actionMappingDetail.ammappingid = this.id;
            url = 'admin/ammapping/mappingSave';
        }

        this._commonHttpService.create(actionMappingDetail, url).subscribe(
            (response) => {
                if (response) {
                    if (response.ammappingid || response === 'Success') {
                        this.closeItem();
                        this._alertService.success('Action mapping saved successfully.');
                    } else {
                        this.closeItem();
                        this._alertService.error('Map Service type and Service sub type');
                    }
                }
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                $('#delete-popup').modal('hide');
            }
        );
    }
    // admin/activitytasktype?filter={ 'where': {'activeflag': 1,'activitytypekey':'DSDSAction' } }
    private loadMainDropdowns() {
        const source = forkJoin([
            this.getDSDSActionDropdownItem('admin/amactivity'),
            this.getDSDSActionDropdownItem('admin/amtask'),
            this.getDSDSActionDropdownItem('admin/amgoal'),
            this.getDSDSActionDropdownItem('admin/activitytasktype'),
            this.getDSDSActionDropdownItem('intake/activitygoaltype'),
            this.getDSDSActionDropdownItem('admin/activityprioritytype'),
            this.getDSDSActionDropdownItem('admin/intakeservicerequesttype')
        ]).pipe(
            map((resultvalue) => {
                return {
                    activityCategory: resultvalue[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.amactivityid
                            })
                    ),
                    tasks: resultvalue[1].map(
                        (res) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.amtaskid
                            })
                    ),
                    goals: resultvalue[2].map(
                        (res) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.amgoalid
                            })
                    ),
                    taskTypes: resultvalue[3].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitytasktypekey
                            })
                    ),
                    goalTypes: resultvalue[4].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitygoaltypekey
                            })
                    ),
                    priorityTypes: resultvalue[5].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activityprioritytypekey
                            })
                    ),
                    daTypes: resultvalue[6].map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.intakeservreqtypeid
                            })
                    )
                };
            }),
            share(),);
        this.activityCategoryDropdownItems$ = source.pipe(pluck('activityCategory'));
        this.taskDropdownItems$ = source.pipe(pluck('tasks'));
        this.goalDropdownItems$ = source.pipe(pluck('goals'));
        this.daTypeDropdownItems$ = source.pipe(pluck('daTypes'));
        source.pipe(pluck('taskTypes')).subscribe((item) => {
            this.taskTypeDropdownItems = item;
        });
        source.pipe(pluck('goalTypes')).subscribe((item) => {
            this.goalTypeDropdownItems = item;
        });
        source.pipe(pluck('priorityTypes')).subscribe((item) => {
            this.priorityTypeDropdownItems = item;
        });
    }

    private getDSDSActionDropdownItem(url: string) {
        return this._commonHttpService.getArrayList(
            new PaginationRequest({
                nolimit: true,
                where: {
                    activitytypekey: 'Investigation',
                    activeflag: 1
                },
                method: 'get'
            }),
            url + '?filter'
        );
    }

    private formGroupInitialize() {
        this.addEditDSDSActionMappingForm = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            amactivityid: ['', Validators.required],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            helptext: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            demandReview: [''],
            workload: [''],
            intakeservreqtypeid: [''],
            servicerequestsubtypeid: [''],
            ammappingtask: this.formBuilder.array([]),
            ammappinggoal: this.formBuilder.array([])
        });

        this.addEditDSDSActionMappingTaskTypeForm = this.formBuilder.group({
            taskType: ['', Validators.required]
        });

        this.addEditDSDSActionMappingGoalTypeForm = this.formBuilder.group({
            goalType: ['', Validators.required]
        });
    }

    private setFormGroup(allegMapping: DSDSActionMapping[]) {
        let ammappingtask: any = <FormArray>this.addEditDSDSActionMappingForm.controls['ammappingtask'];
        if (!ammappingtask) {
            ammappingtask = new FormArray([]);
        }
        let ammappinggoal: any = <FormArray>this.addEditDSDSActionMappingForm.controls['ammappinggoal'];
        if (!ammappinggoal) {
            ammappinggoal = new FormArray([]);
        }
        if (allegMapping[0] && allegMapping[0].ammapping.length > 0) {
            const mapping = allegMapping[0];
            mapping.ammapping.map((item) => {
                item.ammappinggoal.map((goal) => {
                    this.setGoal(goal);
                });
                item.ammappingtask.map((task) => {
                    this.setTask(task);
                });
            });
            let daobj;
            daobj = {};
            
                if(mapping.ammapping[0]?.daobj && mapping.ammapping[0]?.daobj.length>0){
                    daobj = mapping.ammapping[0].daobj[0];
                }
                this.addEditDSDSActionMappingForm.patchValue({
                    name: mapping.ammapping[0].name,
                    amactivityid: mapping.ammapping[0].amactivityid,
                    description: mapping.ammapping[0].description,
                    helptext: mapping.ammapping[0].helptext,
                    demandReview: mapping.ammapping[0].ondemand ? 'ondemand' : 'isreviewactivity',
                    workload: mapping.ammapping[0].workload,
                    intakeservreqtypeid: daobj.intakeservreqtypeid ? daobj.intakeservreqtypeid : '',
                    servicerequestsubtypeid: daobj.servicerequestsubtypeid ? daobj.servicerequestsubtypeid : ''
                });
                this.addEditDSDSActionMappingForm.setControl('ammappingtask', ammappingtask);
                this.addEditDSDSActionMappingForm.setControl('ammappinggoal', ammappinggoal);
            //}
        }
    }

    private setTask(task: DSDSActionMappingTask) {
        const control = <FormArray>this.addEditDSDSActionMappingForm.controls['ammappingtask'];
        const addrCtrl = this.initTask(task);
        control.push(addrCtrl);
    }

    private setGoal(gaol: DSDSActionMappingGoal) {
        const control = <FormArray>this.addEditDSDSActionMappingForm.controls['ammappinggoal'];
        const addrCtrl = this.initGoal(gaol);
        control.push(addrCtrl);
    }

    private initTask(task: DSDSActionMappingTask): FormGroup {
        return this.formBuilder.group({
            amtaskid: [task.amtask.amtaskid ? task.amtask.amtaskid : ''],
            description: [task.amtask.description ? task.amtask.description : ''],
            helptext: [task.helptext ? task.helptext : ''],
            activitytasktypekey: [task.activitytasktypekey ? task.activitytasktypekey : '', Validators.required],
            activityprioritytypekey: [task.activityprioritytypekey ? task.activityprioritytypekey : '', Validators.required],
            required: [task.required ? task.required : false],
            duedateoffset: [task.duedateoffset ? task.duedateoffset : '0']
        });
    }

    private initGoal(goal: DSDSActionMappingGoal): FormGroup {
        return this.formBuilder.group({
            amgoalid: [goal.amgoal.amgoalid ? goal.amgoal.amgoalid : ''],
            description: [goal.amgoal.description ? goal.amgoal.description : ''],
            helptext: [goal.helptext ? goal.helptext : ''],
            activitygoaltypekey: [goal.activitygoaltypekey ? goal.activitygoaltypekey : '', Validators.required],
            activityprioritytypekey: [goal.activityprioritytypekey ? goal.activityprioritytypekey : '', Validators.required],
            required: [goal.required ? goal.required : false],
            duedateoffset: [goal.duedateoffset ? goal.duedateoffset : '0']
        });
    }

    get nameControl(): FormControl { 
        return this.addEditDSDSActionMappingForm.get('name') as FormControl; 
    }
    
    get amactivityidControl(): FormControl { 
        return this.addEditDSDSActionMappingForm.get('amactivityid') as FormControl; 
    }

    get descriptionControl(): FormControl { 
        return this.addEditDSDSActionMappingForm.get('description') as FormControl; 
    }

    getFormData(name: string): any[] {
        return Object.values((this.addEditDSDSActionMappingForm.get(name) as FormGroup).controls);
    }
}

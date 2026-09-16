
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
    AllegationMapping,
    AllegationMappingDetail,
    AllegationMappingGoal,
    AllegationMappingGoalDetail,
    AllegationMappingTask,
    AllegationMappingTaskDetail,
} from '../../_entities/allegation-mapping.data.models';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-allegation-mapping',
    templateUrl: './add-edit-allegation-mapping.component.html',
    styleUrls: ['./add-edit-allegation-mapping.component.scss'],
    changeDetection: ChangeDetectionStrategy.Default,
    standalone: false
})
export class AddEditAllegationMappingComponent implements OnInit, AfterViewInit, AfterViewChecked {
    id = '0';
    isEditMode = false;
    titleHead = 'Add';
    addEditAllegationMappingForm!: FormGroup;
    addEditAllegationMappingTaskTypeForm!: FormGroup;
    addEditAllegationMappingGoalTypeForm!: FormGroup;
    activityCategoryDropdownItems$!: Observable<DropdownModel[]>;
    taskDropdownItems$!: Observable<DropdownModel[]>;
    goalDropdownItems$!: Observable<DropdownModel[]>;
    allegationDropdownItems$!: Observable<DropdownModel[]>;
    editAllegationData$!: Observable<AllegationMapping>;
    taskTypeDropdownItems!: DropdownModel[];
    goalTypeDropdownItems!: DropdownModel[];
    priorityTypeDropdownItems!: DropdownModel[];
    private selectedGoalName = '';
    private selectedTaskName = '';
    private selectedGoalId = '';
    private selectedTaskId = '';
    constructor(
        private router: Router,
        private route: ActivatedRoute,
        private formBuilder: FormBuilder,
        private _allegationMappingService: GenericService<AllegationMapping>,
        private _commonHttpService: CommonHttpService,
        private _alertService: AlertService,
        private _changeDetect: ChangeDetectorRef
    ) {}

    ngOnInit() {
        this.formGroupInitialize();
        this.loadMainDropdowns();
        this.route.params.subscribe((item) => {
            this.id = item['id'];
            if (this.id !== '0') {
                this.isEditMode = true;
                this.titleHead = 'Edit';
                const source = this._allegationMappingService
                    .getSingle(
                        new PaginationRequest({
                            where: {
                                activitytypekey: 'Allegation',
                                ammappingid: this.id
                            },
                            method: 'get',
                            nolimit: true
                        }),
                        AdminUrlConfig.EndPoint.DAConfig.MappingListUrl
                    ).pipe(
                    share());

                    this.editAllegationData$ = source.pipe(
                        pluck('data'),
                        map((data:any) => data as AllegationMapping)
                      );
            }
            $('#add-edit-allegation-mapping').modal('show');
        });
    }

    ngAfterViewInit() {
        if (this.id !== '0') {
            this.editAllegationData$.subscribe((result: any) => {
                this.setFormGroup(result);
            });
        }
    }

    ngAfterViewChecked() {
        // explicit change detection to avoid "expression-has-changed-after-it-was-checked-error"
        this._changeDetect.detectChanges();
    }

    closeItem() {
        $('#add-edit-allegation-mapping').modal('hide');
        this.router.navigate(['/pages/admin/da-config/allegations/allegation-mappings']);
    }

    addTask(_task: any) {
        const taskInfo = new AllegationMappingTask();
        taskInfo.amtask = new AllegationMappingTaskDetail();
        taskInfo.amtask.description = this.selectedTaskName;
        taskInfo.amtask.amtaskid = this.selectedTaskId;
        this.setTask(taskInfo);
        this.addEditAllegationMappingTaskTypeForm.patchValue({ taskType: '' });
    }

    changeTask(option: any) {
        this.selectedTaskName = option.label;
        this.selectedTaskId = option.value;
    }

    removeTask(i: number) {
        const control = <FormArray>this.addEditAllegationMappingForm.controls['ammappingtask'];
        control.removeAt(i);
        this.addEditAllegationMappingForm.markAsDirty();
    }

    addGoal(_goal: any) {
        const goalInfo = new AllegationMappingGoal();
        goalInfo.amgoal = new AllegationMappingGoalDetail();
        goalInfo.amgoal.description = this.selectedGoalName;
        goalInfo.amgoal.amgoalid = this.selectedGoalId;
        this.setGoal(goalInfo);
        this.addEditAllegationMappingGoalTypeForm.patchValue({ goalType: '' });
    }

    changeGoal(option: any) {
        this.selectedGoalName = option.label;
        this.selectedGoalId = option.value;
    }

    removeGoal(i: number) {
        const control = <FormArray>this.addEditAllegationMappingForm.controls['ammappinggoal'];
        control.removeAt(i);
        this.addEditAllegationMappingForm.markAsDirty();
    }

    saveMapping() {
        let url = 'admin/ammapping/mappingAdd';
        const actionMappingDetail = Object.assign(new AllegationMappingDetail(), this.addEditAllegationMappingForm.value);
        actionMappingDetail.activeflag = '1';
        actionMappingDetail.activitytypekey = 'Allegation';
        if (this.id !== '0') {
            actionMappingDetail.ammappingid = this.id;
            url = 'admin/ammapping/mappingSave';
        }
        this._commonHttpService.create(actionMappingDetail, url).subscribe(
            (response) => {
                if (response) {
                    this.closeItem();
                    this._alertService.success('Allegation mapping saved successfully.');
                }
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    private loadMainDropdowns() {
        const source = forkJoin([
            this.getAllegationDropdownItem('admin/amactivity'),
            this.getAllegationDropdownItem('admin/amtask'),
            this.getAllegationDropdownItem('admin/amgoal'),
            this.getAllegationDropdownItem('admin/activitytasktype'),
            this.getAllegationDropdownItem('intake/activitygoaltype'),
            this.getAllegationDropdownItem('admin/activityprioritytype'),
            this.getAllegationDropdownItem('admin/allegation/list')
        ]).pipe(
            map((resultvalue: any) => {
                return {
                    activityCategory: resultvalue[0].map(
                        (res: { name: any; amactivityid: any; }) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.amactivityid
                            })
                    ),
                    tasks: resultvalue[1].map(
                        (res: { name: any; amtaskid: any; }) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.amtaskid
                            })
                    ),
                    goals: resultvalue[2].map(
                        (res: { name: any; amgoalid: any; }) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.amgoalid
                            })
                    ),
                    taskTypes: resultvalue[3].map(
                        (res: { typedescription: any; activitytasktypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitytasktypekey
                            })
                    ),
                    goalTypes: resultvalue[4].map(
                        (res: { typedescription: any; activitygoaltypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activitygoaltypekey
                            })
                    ),
                    priorityTypes: resultvalue[5].map(
                        (res: { typedescription: any; activityprioritytypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.activityprioritytypekey
                            })
                    ),
                    allegations: resultvalue[6]['data'].map(
                        (res: { name: any; allegationid: any; }) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.allegationid
                            })
                    )
                };
            }),
            share(),);
        this.activityCategoryDropdownItems$ = source.pipe(pluck('activityCategory'));
        this.taskDropdownItems$ = source.pipe(pluck('tasks'));
        this.goalDropdownItems$ = source.pipe(pluck('goals'));
        this.allegationDropdownItems$ = source.pipe(pluck('allegations'));
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

    private getAllegationDropdownItem(url: string) {
        return this._commonHttpService.getArrayList(
            new PaginationRequest({
                where: {
                    activitytypekey: 'Allegation',
                    activeflag: 1
                },
                method: 'get',
                nolimit: true
            }),
            url + '?filter'
        );
    }

    private formGroupInitialize() {
        this.addEditAllegationMappingForm = this.formBuilder.group({
            name: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            amactivityid: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            objectid: ['', Validators.required],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            helptext: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            ondemand: [false],
            workload: [''],
            ammappingtask: this.formBuilder.array([]),
            ammappinggoal: this.formBuilder.array([])
        });

        this.addEditAllegationMappingTaskTypeForm = this.formBuilder.group({
            taskType: ['', Validators.required]
        });

        this.addEditAllegationMappingGoalTypeForm = this.formBuilder.group({
            goalType: ['', Validators.required]
        });
    }

    private setFormGroup(allegMapping: AllegationMapping[]) {
        if (allegMapping[0]) {
            const mapping: any = allegMapping[0];
            mapping.ammapping.map((item: any) => {
                item.ammappinggoal.map((goal: any) => {
                    this.setGoal(goal);
                });
                item.ammappingtask.map((task: any) => {
                    this.setTask(task);
                });
            });
            if (mapping.ammapping.length > 0) {
                this.addEditAllegationMappingForm.patchValue({
                    name: mapping.ammapping[0].name,
                    amactivityid: mapping.ammapping[0].amactivityid,
                    objectid: mapping.ammapping[0].investigationmapping.objectid,
                    description: mapping.ammapping[0].description,
                    helptext: mapping.ammapping[0].helptext,
                    ondemand: mapping.ammapping[0].ondemand === true ? mapping.ammapping[0].ondemand : false,
                    workload: mapping.ammapping[0].workload
                });
                let ammappingtask: any = <FormArray>this.addEditAllegationMappingForm.controls['ammappingtask'];
                if (!ammappingtask) {
                    ammappingtask = new FormArray([]);
                }
                let ammappinggoal: any = <FormArray>this.addEditAllegationMappingForm.controls['ammappinggoal'];
                if (!ammappinggoal) {
                    ammappinggoal = new FormArray([]);
                }
                this.addEditAllegationMappingForm.setControl('ammappingtask', ammappingtask);
                this.addEditAllegationMappingForm.setControl('ammappinggoal', ammappinggoal);
            }
        }
    }

    private setTask(task: AllegationMappingTask) {
        const control = <FormArray>this.addEditAllegationMappingForm.controls['ammappingtask'];
        const addrCtrl = this.initTask(task);
        control.push(addrCtrl);
    }

    private setGoal(gaol: AllegationMappingGoal) {
        const control = <FormArray>this.addEditAllegationMappingForm.controls['ammappinggoal'];
        const addrCtrl = this.initGoal(gaol);
        control.push(addrCtrl);
    }

    private initTask(task: AllegationMappingTask): FormGroup {
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

    private initGoal(goal: AllegationMappingGoal): FormGroup {
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
        return this.addEditAllegationMappingForm.get('name') as FormControl; 
    }
    
    get amactivityidControl(): FormControl { 
        return this.addEditAllegationMappingForm.get('amactivityid') as FormControl; 
    }

    get objectidControl(): FormControl { 
        return this.addEditAllegationMappingForm.get('objectid') as FormControl; 
    }
    
    get descriptionControl(): FormControl { 
        return this.addEditAllegationMappingForm.get('description') as FormControl; 
    }

    getFormData(name: string): any[] {
        return Object.values((this.addEditAllegationMappingForm.get(name) as FormGroup).controls);
    }
}

export class InvestigationPlanSummary {
    openedcount!: string;
    closedcount!: string;
    totalcount!: string;
}
export class ActivityGoallist {
    totalcount!: string;
    activitygoalid!: string;
    goal!: string;
    goaltype!: string;
    duedate!: Date;
    completiondate!: Date;
    required!: boolean;
    dispositionstatus!: string;
    goalstatus!: string;
    activitygoalstatustypekey!: string;
    activitygoaldispositiontypekey!: string;
    activitygoaltypekey!: string;
}

export class ActivityTasklist {
    activityid!: string;
    activitytaskid!: string;
    actvityname!: string;
    duedate!: Date;
    task!: string;
    tasktype!: string;
    required!: boolean;
    assignedon!: Date;
    taskstatustype!: string;
    completeddate!: Date;
    dispositionstatus!: string;
    expceptionrequest!: string;
    assignedto!: string;
    activitytasktypekey!: string;
    insertedon!: Date;
    assignloadnumber!: string;
    location!: string;
    outofoffice!: boolean;
    activitytaskstatustypekey!: string;
    activitytaskdispositiontypekey!: string;
    taskdescription!: string;
    ammapping!: string;
    name!: string;
    startdatetime!: Date;
    enddatetime!: Date;
    updatedby!: string;
}
export class ActivityGoalModal {
    totalcount!: string;
    activitygoalid!: string;
    goal!: string;
    goaltype!: string;
    duedate!: Date;
    completiondate!: Date;
    required!: boolean;
    dispositionstatus!: string;
    goalstatus!: string;
    activitygoalstatustypekey!: string;
    activitygoaldispositiontypekey!: string;
    activitygoaltypekey!: string;
    activityid!: string;
}

export class ActivityTaskModal {
    activityid!: string;
    activitytaskid!: string;
    actvityname!: string;
    activitytypekey!: string;
    duedate!: Date;
    task!: string;
    tasktype!: string;
    required!: boolean;
    iseditable!: boolean;
    assignedon!: Date;
    taskstatustype!: string;
    completeddate!: Date;
    dispositionstatus!: string;
    expceptionrequest!: string;
    assignedto!: string;
    activitytasktypekey!: string;
    insertedon!: Date;
    assignloadnumber!: string;
    location!: string;
    outofoffice!: boolean;
    isstatustype!: boolean;
    activitytaskstatustypekey!: string;
    activitytaskdispositiontypekey!: string;
    taskdescription!: string;
    ammapping!: string;
    name!: string;
    startdatetime!: string;
    enddatetime!: string;
    updatedby!: string;
    loadnumber!: string;
    amtaskid?: string;
    notes?: string;
    checklisttype!: string;
}
export class ActivityPlan {
    ammappingid!: string;
    amactivityid!: string;
    rulesetid!: string;
    rulesetsourceid!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
    helptext!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    ammapping!: string;
}
export class Allegationtask {
    amtaskid!: string;
    name!: string;
    description!: string;
}

export class AllegationMappingTask {
    ammappingid!: string;
    amtaskid!: string;
    required!: boolean;
    activityid!: string;
    helptext!: string;
    duedateoffset!: number;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    activeflag!: number;
    amtask!: Allegationtask;
    name!: string;
    description!: string;
    assignedto!: number;
    iseditable!: boolean;
    activitytaskstatustypekey!: string;
}

export class AllegationMapping {
    ammappingid!: string;
    iseditable!: boolean;
    amactivityid!: string;
    name!: string;
    description!: string;
    ondemand!: boolean;
    workload?: string;
    ammappinggoal!: AllegationMappingGoal[];
    ammappingtask!: AllegationMappingTask[];
}

export class SuggestedTask {
    amactivityid!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
    voidedby?: string;
    voidedon?: string;
    isSelected = false;
    voidreasonid?: string;
    workload?: string;
    activitytaskid!: string;
    activityid!: string;
    amtaskid!: string;
    activitytaskstatustypekey!: string;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    ammapping!: AllegationMapping[];
}
export class IntakeActivityTask {
    activitytaskid!: string;
    activitytaskstatustypekey!: string;
    activitytaskdispositiontypekey!: string;
    completeddate!: string;
}
export class AllegationGoal {
    amgoalid!: string;
    name!: string;
    description!: string;
}

export class AllegationMappingGoal {
    ammappingid!: string;
    amgoalid!: string;
    required!: boolean;
    helptext!: string;
    duedateoffset?: Date;
    activitygoaltypekey!: string;
    activityprioritytypekey!: string;
    activeflag!: number;
    amgoal!: AllegationGoal;
    activityid!: string;
    name!: string;
    description!: string;
    activitygoalstatustypekey!: string;
}

export class ListActivities {
    activityid!: string;
    description!: string;
    activitystatustypekey?: string;
    amactivityid!: string;
    ammappingid!: string;
    objectid!: string;
    sourcedescription!: string;
    activitytypekey!: string;
    helptext!: string;
    sequence!: number;
    activeflag!: number;
    effectivedate!: string;
    expirationdate?: Date;
    oldId?: string;
    voidedby?: string;
    voidedon?: string;
    voidreasonid?: string;
    groupsequence!: number;
}

export class ListActivityTask {
    activitytaskid!: string;
    activityid!: string;
    amactivityid!: string;
    name!: string;
    description!: string;
    helptext!: string;
    amtaskid!: string;
    assignedto!: string;
    assignedon!: string;
    activitytaskstatustypekey!: string;
    activitytaskdispositiontypekey?: string;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    duedate!: string;
    startdatetime?: Date;
    enddatetime?: Date;
    location?: string;
    outofoffice?: string;
    reasonnotmet?: string;
    required!: boolean;
    sequence!: number;
    completeddate!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate?: Date;
    old_id?: string;
    timestamp!: Timestamp;
    voidedby?: string;
    voidedon?: string;
    voidreasonid?: string;
    targetcompleteddate?: string;
}

export class DeleteActivity {
    activityid!: string;
    description!: string;
    activitystatustypekey?: string;
    amactivityid!: string;
    ammappingid!: string;
    objectid!: string;
    sourcedescription!: string;
    activitytypekey!: string;
    helptext!: string;
    sequence!: number;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
    oldId?: string;
    voidedby?: string;
    voidedon?: string;
    voidreasonid?: string;
    groupsequence!: number;
}
export class Timestamp {
    type!: string;
    data!: number[];
}

export class DeleteTask {
    activitytaskid!: string;
    activityid!: string;
    name!: string;
    description!: string;
    helptext!: string;
    amtaskid!: string;
    assignedto!: string;
    assignedon!: string;
    activitytaskstatustypekey!: string;
    activitytaskdispositiontypekey?: string;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    duedate!: string;
    startdatetime?: Date;
    enddatetime?: Date;
    location?: string;
    outofoffice?: string;
    reasonnotmet?: string;
    required!: boolean;
    sequence!: number;
    completeddate!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
    old_id?: string;
    timestamp!: Timestamp;
    voidedby?: string;
    voidedon?: string;
    voidreasonid?: string;
    targetcompleteddate?: Date;
    isSelected: any;
}

export class Task {
    name!: string;
    description!: string;
    helptext!: string;
    amtaskid!: string;
    assignedto!: string;
    activitytaskstatustypekey!: string;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    required!: number;
    activeflag!: number;
    isSelected!: boolean;
}

export class Goal {
    activityid!: string;
    name!: string;
    description!: string;
    amgoalid!: string;
    activitygoalstatustypekey!: string;
    activitygoaltypekey!: string;
    activityprioritytypekey!: string;
    required!: number;
    activeflag!: number;
    isSelected!: boolean;
}

export class SaveActivity {
    intakeserviceid!: string;
    amactivityid!: string;
    ammappingid!: string;
    activitytypekey!: string;
    activitytask: Task[] = [];
    goal?: Goal[] = [];
}
export class CreateTaskModal {
    activitytaskid!: string;
    activityid!: string;
    name!: string;
    iseditable!: boolean;
    description!: string;
    helptext!: string;
    assignedto!: string;
    assignedon!: string;
    activitytaskstatustypekey!: string;
    activitytaskdispositiontypekey!: string;
    activitytasktypekey!: string;
    duedate!: string;
    startdatetime!: string;
    enddatetime!: string;
    location!: string;
    outofoffice!: boolean;
    required!: boolean;
    completeddate!: string;
    activeflag!: number;
    effectivedate!: string;
    limit!: number;
    page!: number;
    insertedby!: string;
    updatedby!: string;
    taskcommunicationtypekey!: string;
}
export interface Activity {
    description: string;
    amactivityid: string;
    ammappingid: string;
    objectid: string;
    sourcedescription: string;
    activitytypekey: string;
    helptext: string;
    sequence: number;
    activeflag: number;
    expirationdate: string;
    groupsequence: number;
}

export interface ActivityPlan {
    activity: Activity[];
}

export class InvestigationPlanCaseCount {
    openedcount!: string;
    closedcount!: string;
    totalcount!: string;
}

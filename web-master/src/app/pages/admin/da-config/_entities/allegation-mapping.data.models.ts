
export class AllegationMapping {
    amactivityid!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    voidedby!: string;
    voidedon!: Date;
    voidreasonid!: string;
    workload!: string;
    ammapping!: AllegationMappingDetail[];
}

export class AllegationMappingDetail {
    ammappingid!: string;
    amactivityid!: string;
    name!: string;
    description!: string;
    amactivity!: AmActivityDetail;
    investigationmapping!: InvestigationMappingDetail;
    ammappinggoal!: AllegationMappingGoal[];
    ammappingtask!: AllegationMappingTask[];
}

export class AmActivityDetail {
    amactivityid!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
}

export class AllegationMappingTask {
    ammappingid!: string;
    amtaskid!: string;
    required!: boolean;
    helptext!: string;
    duedateoffset!: number;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    activeflag!: number;
    amtask!: AllegationMappingTaskDetail;
}

export class AllegationMappingTaskDetail {
    amtaskid!: string;
    name!: string;
    description!: string;
}

export class AllegationMappingGoal {
    ammappingid!: string;
    amgoalid!: string;
    required!: boolean;
    helptext!: string;
    duedateoffset!: number;
    activitygoaltypekey!: string;
    activityprioritytypekey!: string;
    activeflag!: number;
    amgoal!: AllegationMappingGoalDetail;
}

export class AllegationMappingGoalDetail {
    amgoalid!: string;
    name!: string;
    description!: string;
}

export class InvestigationMappingDetail {
    ammappingid!: string;
    objectid!: string;
}

export class AllegationMappingActivitySaveModel {
    amactivityid!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
    helptext!: string;
    activeflag!: string;
    ondemand!: string;
    workload!: string;
    insertedby!: string;
    ammappinggoal!: AllegationMappingGoalSaveModel[];
    ammappingtask!: AllegationMappingItemSaveModel[];
}
export class AllegationMappingItemSaveModel {
    prioritytypekey!: string;
    DueDateOffset!: string;
    helptext!: string;
    Required!: string;
    activeflag!: string;
    insertedby!: string;
    updatedby!: string;
}
export class AllegationMappingGoalSaveModel extends AllegationMappingItemSaveModel {
    amgoalid!: string;
    goaltypekey!: string;
}

export class AllegationMappingTaskSaveModel extends AllegationMappingItemSaveModel {
    amtaskid!: string;
    tasktypekey!: string;
}


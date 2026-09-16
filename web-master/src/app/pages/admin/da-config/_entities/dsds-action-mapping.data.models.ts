
export class DSDSActionMapping {
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
    amactivity: any;
    ammapping!: DSDSActionMappingDetail[];
}

export class DSDSActionMappingDetail {
    ammappingid!: string;
    amactivityid!: string;
    name!: string;
    description!: string;
    helptext!: string;
    activeflag!: '1';
    ondemand!: number;
    workload!: number;
    activitytypekey!: string;
    servicerequestid!: string;
    servicerequestsubtypeid!: string;
    daobj!: DaDetail[];
    ammappinggoal!: DSDSActionMappingGoal[];
    ammappingtask!: DSDSActionMappingTask[];
    amactivity: any;
}

export class DSDSActionMappingTask {
    ammappingid!: string;
    amtaskid!: string;
    required!: boolean;
    helptext!: string;
    duedateoffset!: number;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    activeflag!: number;
    amtask!: DSDSActionMappingTaskDetail;
}

export class DSDSActionMappingTaskDetail {
    amtaskid!: string;
    name!: string;
    description!: string;
}

export class DSDSActionMappingGoal {
    ammappingid!: string;
    amgoalid!: string;
    required!: boolean;
    helptext!: string;
    duedateoffset!: number;
    activitygoaltypekey!: string;
    activityprioritytypekey!: string;
    activeflag!: number;
    amgoal!: DSDSActionMappingGoalDetail;
}

export class DSDSActionMappingGoalDetail {
    amgoalid!: string;
    name!: string;
    description!: string;
}


export class DSDSActionMappingActivitySaveModel {
    amactivityid!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
    helptext!: string;
    activeflag!: string;
    ondemand!: string;
    workload!: string;
    insertedby!: string;
    ammappinggoal!: DSDSActionMappingGoalSaveModel[];
    ammappingtask!: DSDSActionMappingItemSaveModel[];
}
export class DSDSActionMappingItemSaveModel {
    prioritytypekey!: string;
    DueDateOffset!: string;
    helptext!: string;
    Required!: string;
    activeflag!: string;
    insertedby!: string;
    updatedby!: string;
}

export class DaDetail {
    intakeservreqtypeid!: string;
    servicerequestsubtypeid!: string;
}
export class DSDSActionMappingGoalSaveModel extends DSDSActionMappingItemSaveModel {
    amgoalid!: string;
    goaltypekey!: string;
}

export class DSDSActionMappingTaskSaveModel extends DSDSActionMappingItemSaveModel {
    amtaskid!: string;
    tasktypekey!: string;
}



import { Injectable } from '@angular/core';

import { initializeObject } from '../../../../@core/common/initializer';

export class DsdsActionTypeConfig {
    amtaskid!: number;
    activitytypekey!: string;
    sequencenumber!: number;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    insertedby!: string;
    name!: string;
    description!: string;
    updatedby!: string;
    constructor(initializer?: DsdsActionTypeConfig) {
        initializeObject(this, initializer);
    }
}

export class MasterDaConfig {
    TableHeaderName: string | null = null;
    TableHeaderDescription: string | null = null;
    RouteUrl: string | null = null;
    constructor(initializer?: MasterDaConfig) {
        initializeObject(this, initializer);
    }
}

export class DsdsActionConfig {
    id!: string;
    activitytypekey!: string;
    activeflag!: number;
    editable!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    name!: string;
    description!: string;
    constructor(initializer?: DsdsActionConfig) {
        initializeObject(this, initializer);
    }
}

export class DsdsActionGols {
    amgoalid!: string;
    activitytypekey!: string;
    activeflag!: number;
    editable!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    name!: string;
    description!: string;
    constructor(initializer?: DsdsActionGols) {
        initializeObject(this, initializer);
    }
}

export class AllegationActivities extends DsdsActionConfig {
    amactivityid!: string;
    constructor(initializer?: AllegationActivities) {
        super(initializer);
    }
}
export class DsdsActionMappingCateg {
    amactivityid!: string;
    activitytypekey!: string;
    activeflag!: number;
    editable!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    name!: string;
    description!: string;
    constructor(initializer?: DsdsActionMappingCateg) {
        initializeObject(this, initializer);
    }
}
export class AllegationConfiguration extends DsdsActionConfig {
    titleheadertext!: string;
    assessmenttemplateid!: string;
    category!: string;
    isSelected = false;
    constructor(initializer?: AllegationConfiguration) {
        super(initializer);
    }
}
export class AllegationGoals extends DsdsActionConfig {
    amgoalid!: string;
    constructor(initializer?: AllegationGoals) {
        super(initializer);
    }
}
export class AllegationTasks extends DsdsActionConfig {
    amtaskid!: string;
    constructor(initializer?: AllegationTasks) {
        super(initializer);
    }
}

export class Indicator extends DsdsActionConfig {
    index!: number;
    indicatorid?: string;
    allegationid!: string;
    indicatorname!: string;
}

export class AllegationAllegations extends DsdsActionConfig {
    allegationid!: string;
    self!: boolean;
    workload!: string;
    updatedby!: string;
    insertedby!: string;
    intakeservicereqtypeid!: string;
    intakeservicereqsubtypeid!: string;
    indicator!: Indicator[];
    constructor(initializer?: AllegationAllegations) {
        super(initializer);
    }
}

export class AllegationScoreUsage {
    typedescription!: string;
    scoringmethod!: string;
    assessmentscoringmethodid!: string;

    assessmentscoretypekey!: string;
    assessmenttemplate!: ScoreUsageAssessment[];
    isSelected = false;
    constructor(initializer?: AllegationScoreUsage) {
        initializeObject(this, initializer);
    }
}
export class ScoreUsageAssessment {
    id!: string;
    scoringmethod!: string;
    name!: string;
}

@Injectable()
export class MasterProviderContracting {
    TableHeaderName: string | null = null;
    TableHeaderDescription: string | null = null;
    RouteUrl: string | null = null;
    constructor(initializer?: MasterProviderContracting) {
        initializeObject(this, initializer);
    }
}

export class MasterProviderContractingconfig {
    id!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    insertedby!: string;
    insertedon!: Date;
    updatedby!: string;
    updatedon!: Date;
    constructor(initializer?: MasterProviderContractingconfig) {
        initializeObject(this, initializer);
    }
}

export class DocTypesPC extends MasterProviderContractingconfig {
    sequencenumber!: string;
    typedescription!: string;
    datavalue!: number;
    editable!: number;
    provideragreementdocumenttypekey!: string;
    constructor(initializer?: DocTypesPC) {
        super(initializer);
    }
}

export class PaTasksPC extends MasterProviderContractingconfig {
    amtaskid!: string;
    constructor(initializer?: PaTasksPC) {
        super(initializer);
    }
}

export class PaActivitiesPC extends MasterProviderContractingconfig {
    amactivityid!: string;
    constructor(initializer?: PaActivitiesPC) {
        super(initializer);
    }
}

export class DocDetail {
    activeflag = 1;
    questionname!: string;
    questiontext!: string;
    servicerequesttypeconfigroleid!: string;
    sequencenumber!: number;
    statestatutesid!: string;
    statestatuteskey!: string;
    statestatutetext!: string;
    name!: string;
    updatedby!: string;
    provideragreementdocumentruleconfigid?: string | undefined;
    statestatutes!: DocDetailStatus;
    entityroletypekey!: DocDetailList;
    constructor(initializer?: DocDetail) {
        initializeObject(this, initializer);
    }
}
export class DocDetailStatus {
    activeflag!: number;
    description!: string;
    effectivedate!: string;
    expirationdate!: Date;
    inputregulationstatestatue!: string;
    librarytype!: string;
    possiblereferral!: string;
    possiblereferralflag!: boolean;
    possiblesanction!: string;
    possiblesanctionflag!: boolean;
    reasontobelieve!: string;
    statestatutesid!: string;
    statestatuteskey!: string;
    statestatutetext!: string;
}
export class DocDetailList {
    datype!: string;
    dasubtype!: string;
    servicerequesttypeconfigroleid!: string;
    entityroletypekey!: string;
}
export class AllegationSearchRequest {
    statestatutesid!: string[];
    statestatuteskey!: string;
    description!: string;
    statestatutetext?: string;
    allegationid!: string;
    isSelected!: boolean;
}

export class Statestatute {
    description!: string;
    statestatutesid!: string;
    statestatuteskey!: string;
    isSelected!: boolean;
}

export class Allegationstatestatute {
    allegationid!: string;
    statestatuteid!: string;
    statestatutes!: {
        description: string;
        statestatutesid: string;
        statestatuteskey: string;
    };
    isSelected!: boolean;
}

export class AllegationStatus {
    allegationid!: string;
    name!: string;
    self!: boolean;
    rulesetid?: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate?: Date;
    workload?: string;
    intakeservicereqtypeid!: string;
    intakeservicereqsubtypeid!: string;
    allegationstatestatutes!: Allegationstatestatute[];
}

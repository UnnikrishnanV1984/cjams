import { Injectable } from '@angular/core';

import { initializeObject } from '../../../../@core/common/initializer';

@Injectable()
export class MasterCatelogReview {
    BlockTitle: string | null = null;
    LabelNameTitle: string | null = null;
    LabelDescriptionTitle: string | null = null;
    TableHeaderName: string | null = null;
    TableHeaderDescription: string | null = null;
    RouteUrl: string | null = null;
    constructor(initializer?: MasterCatelogReview) {
        initializeObject(this, initializer);
    }
}

@Injectable()
export class ReviewConfig {
    id!: number;
    reviewresulttemplateid!: string;
    rulesetid!: string;
    requestedactionpath!: string;
    deficiency = false;
    name!: string;
    reviewtypekey!: string;
    activeflag = 1;
    updatedby!: string;
    updatedon!: Date;
    insertedby!: string;
    insertedon!: Date;
    effectivedate: Date = new Date();
    expirationdate: Date = new Date();
    timestamp!: Date;
    constructor(initializer?: ReviewConfig) {
        initializeObject(this, initializer);
    }
}
export class ReviewConfigList {
    assessmenttemplateid!: string;
    name!: string;
    description!: string;
    insertedby!: string;
    updatedby!: string;
    version!: string;
    titleheadertext!: string;
    assessmenttextpositiontypekey!: string;
    activeflag!: boolean;
    assesssmenttemplateids!: ReviewConfigList[];
    isSelected = false;
}
// tslint:disable-next-line:class-name
export class EdlreviewresultConfig extends ReviewConfig {
}
export class ManagementreviewResultPage extends ReviewConfig {
}
export class SuperreviewResultPage extends ReviewConfig {
}


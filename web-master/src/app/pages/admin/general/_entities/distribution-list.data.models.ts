import { Injectable } from '@angular/core';
import { initializeObject } from '../../../../@core/common/initializer';

Injectable();
export class DistributionGroupNameResults {
    usernotificationgroupid?: string;
    usernotificationgroupname: string = '';
    activeflag: any = 1;
    updatedby: string | null = null;
    insertedby?: string | null = null;
    effectivedate!: Date;
    expirationdate!: Date;
    teammemberid!: Array<string>;
    constructor(initializer?: DistributionGroupNameResults) {
        initializeObject(this, initializer);
    }
}
Injectable();
export class DistributionSearchResults {
    teammemberid?: string;
    usernotificationgroupid?: string;
    firstname?: string;
    lastname?: string;
    positioncode?: string;
    roletypekey!: string;
    displayname!: string;
    activeflag!: number;
    constructor(initializer?: DistributionSearchResults) {
        initializeObject(this, initializer);
    }
}

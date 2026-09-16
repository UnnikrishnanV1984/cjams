import { Injectable } from '@angular/core';

import { initializeObject } from '../../../../../@core/common/initializer';

@Injectable()
export class DaTypeConfigMainData {
    servicerequesttypeconfigid?: string;
    intakeservreqtypeid!: string;
    servicerequestsubtypeid!: string;
    activeflag!: 1;
    intakeservicerequestplantypekey!: string;
    workload?: number;
    internalfile!: boolean;
    duedateoffset!: number;
    limitedrouting!: boolean;
    intakeserreqstatustypeid?: string;
    focusroletype!: string;
    insertedby!: string;
    updatedby?: string;
    effectivedate?: Date;
    expirationdate?: Date;
    category!: string;
    datype!: string;
    subtype!: string;
    plantype!: string;
    workload_basis!: number;
    focusentitytype!: string;
    displaydatype!: string;
    displaydasubtype!: string;
    agencycategorykey?: string;
    constructor(initializer?: DaTypeConfigMainData) {
        initializeObject(this, initializer);
    }
}
export class DefaultAccessList {
    teammemberid!: string;
    positioncode!: string;
    roletypekey!: string;
    displayname!: string;
    firstname!: string;
    lastname!: string;
    filtertype!: 'DAACCESSLIST';
    activeflag!: 1;
    isSelected!: boolean;
    servicerequesttypeconfigid!: string;
    type!: string;
    constructor(initializer?: DefaultAccessList) {
        initializeObject(this, initializer);
    }
}

export class DefaultAccessConfig {
    servicerequesttypeconfigid!: string;
    activeflag!: 1;
    loadnumber!: string[];
    constructor(initializer?: DefaultAccessConfig) {
        initializeObject(this, initializer);
    }
}

export class ServiceRequestTypeConfig {
    name!: string;
    description!: string;
    entityroletype!: string;
    entityroletypekey!: string;
    activeflag!: 1;
    servicerequesttypeconfigid!: string;
    effectivedate!: Date;
    insertedby!: 'Default';
    isdefault!: boolean;
}
export class ServiceRequestTypeConfigList {
    name!: string;
    description!: string;
    constructor(initializer?: ServiceRequestTypeConfig) {
        initializeObject(this, initializer);
    }
}
export class ServiceRequestDispositionConfig {
    servicerequesttypeconfigid!: string;
    dispositioncode!: string;
    description!: string;
    intakeserreqstatustypeid!: string;
    activeflag!: 1;
    expirationdate!: Date;
    effectivedate!: Date;
    insertedby!: string;
    intakeserreqstatustype!: ReqestStatusType;
    constructor(initializer?: ServiceRequestDispositionConfig) {
        initializeObject(this, initializer);
    }
}

export class ManageAlertsConfig {
    servicerequesttypeconfigid!: string;
    alerttimetype!: '';
    alerttimeinterval!: 0;
    teamtypekey!: string;
    alerteventkey!: string;
    activeflag!: 1;
    effectivedate = new Date();
    expirationdate = new Date();
    insertedby!: 'Default';
    isSelected!: boolean;
    roletypekey!: string;
    description: any;
    
    constructor(initializer?: ManageAlertsConfig) {
        initializeObject(this, initializer);
    }
}

export class DATypeScreenStatus {
    hasPersonRoles!: boolean;
    hasDispositions!: boolean;
    hasDefaultAccessList!: boolean;
    hasDocType!: boolean;
    hasEntityConfig!: boolean;
    hasEntityRole!: boolean;
    hasManageAlerts!: boolean;
    hasUserRoles!: boolean;
}
export class ReqestStatusType {
    intakeserreqstatustypeid!: string;
    intakeserreqstatustypekey!: string;
    description!: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
}

import { Injectable } from '@angular/core';

import { initializeObject } from '../../../../@core/common/initializer';
import { TreeViewModel } from '../../../../@core/entities/common.entities';



@Injectable()
export class MasterRecordingTypesConfig {
    id!: number;
    name!: string;
    description!: string;
    activeflag!: number;
    updatedby!: string;
    updatedon!: Date;
    insertedby!: string;
    insertedon!: Date;
    effectivedate: Date = new Date();
    expirationdate: Date = new Date();
    timestamp!: Date;
    constructor(initializer?: MasterRecordingTypesConfig) {
        initializeObject(this, initializer);
    }
}

export class TeamPosition {

    id!: string;
    name!: string;
    children!: TreeViewModel[];
    teamname!: string;
    teamnumber!: string;
    teamtypekey!: string;
    officetimingfrom!: string;
    officetimingto!: string;
    region!: string;
    teammemberid!: string;
    teamid!: string;
    teammembers!: object;
    positioncode!: string;
    securityusersid!: string;
    fullname!: string;
    unavailableflag!: boolean;
    userworkstatustypekey!: string;
    userworkstatustype!: string;
    typedescription!: string;
    description!: string;
    insertedby?: string;
    updatedby!: string;
    activeflag!: number;
    constructor(initializer?: TeamPosition) {
        initializeObject(this, initializer);
    }
}


export class TeamDetails {

    id!: string;
    teamname!: string;
    teamnumber!: string;
    name!: string;
    teamtypekey!: string;
    officetimingfrom!: null;
    officetimingto!: null;
    region!: string;
    teammemberid!: string;
    parentteamid!: null;
    teamid!: string;
    teammembers!: any[];
    positioncode!: string;
    securityusersid!: string;
    fullname!: string;
    unavailableflag!: string;
    userworkstatustypekey!: string;
    userworkstatustype!: string;
    typedescription!: string;
    description!: string;
    insertedby?: string;
    updatedby!: string;
    activeflag!: number;
    roletypekey!: string;
    apsregion!: string;
    team?: any;
    constructor(initializer?: TeamDetails) {
        initializeObject(this, initializer);
    }
}

export class TeamPositionDetails {
    id!: string;
    teamid!: string;
    roletypekey!: string;
    roletype!: string;
    loadnumber!: string;
    positioncode!: string;
    region!: number;
    activeflag!: number;
    description!: string;
    isoncall!: boolean;
    teammemberid!: string;
    insertedby!: string;
    updatedby!: string;
    effectivedate!: Date;
    expirationdate!: null;
    linenumber!: number;
    rtfdate!: Date;
    coadate!: Date;
    countyareateammember: any;
    
    constructor(initializer?: TeamPositionDetails) {
        initializeObject(this, initializer);
    }
}
    export class CountyDetails {
    isSelected = false;
    countyid!: string;
    activeflag!: 1;
    countyname!: string;
    regionid!: string;
    statecountycode!: string;
    fipscode!: number;
    oldcountyid!: string;
    insertedby!: string;
    updatedby!: string;
    expirationdate!: string;
    effectivedate!: string;
    longitude!: DoubleRange;
    latitude!: DoubleRange;
    state!: string;
    apsregion!: number;
    ltcregion!: number;
    zipcode!: number;
    city!: string;
    locationcode!: string;
    constructor(initializer?: CountyDetails) {
        initializeObject(this, initializer);
    }
}

export class ReAssignmentDetails {
    id!: string;
    teamid!: string;
    roletypekey!: string;
    loadnumber!: string;
    positioncode!: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
    dob!: string;
    email!: string;
    fullname!: string;
    orgname!: string;
    orgnumber!: string;
    activeflag!: number;
    teammemberid!: string;
    teammemberassignmentid!: string;
    securityusersid!: string;
    securityusers!: string | undefined;
    voidreasonid!: string;
    insertedby!: string;
    updatedby!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    rtfdate!: Date;
    coadate!: Date;
    userworkstatustypekey!: string;
    unavailableflag!: boolean;
    usertypekey!: string;
    teammemberassignment: any;

    constructor(initializer?: ReAssignmentDetails) {
        initializeObject(this, initializer);
    }
}

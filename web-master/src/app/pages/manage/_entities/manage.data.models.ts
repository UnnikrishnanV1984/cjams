import { Injectable } from '@angular/core';
import { initializeObject } from '../../../@core/common/initializer';
@Injectable()

export class RegulationLibraryConfig {
    statestatutesid!: string;
    statestatuteskey!: string;
    statestatutetext!: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    insertedby!: string;
    description!: string;
    updatedby!: string;
    possiblesanctionflag!: boolean;
    possiblereferralflag!: boolean;
    constructor(initializer?: RegulationLibraryConfig) {
        initializeObject(this, initializer);
    }
}

export class ManageNewsConfig {
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: string;
    longtext!: string;
    newsid!: string;
    shorttext!: string;
    updatedby!: string;
    updatedon!: string;
    constructor(initializer?: ManageNewsConfig) {
        initializeObject(this, initializer);
    }
}
@Injectable()
export class ReferenceLinkConfig {
    configurablelinksid!: number;
    name!: string;
    links!: string;
    activeflag!: number;
    updatedby!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    constructor(initializer?: ReferenceLinkConfig) {
        initializeObject(this, initializer);
    }
}

export class SignificantEventConfig {
    activeflag = 1;
    datavalue!: number;
    editable = 1;
    effectivedate = new Date();
    sequencenumber!: number;
    servicerequestincidenttypekey?: string;
    typedescription: string = '';
    expirationdate = new Date();
    servicerequestcincidenttypekey?: any;
    timestamp?: any;
}

export class HelpDocuments {
    helpdocumentsid!: string;
    title!: string;  
    filename!: string;
    category!: string;
    subcategory!: string;   
    insertedon!: Date;
    insertedby!: Date;
    uploadedon!: Date;
    uploadedby!: string; 
    type!: string;
    filecontent!: File;  
}

export class ManageDAGroupConfig {

    constructor(initializer?: ManageDAGroupConfig) {
        initializeObject(this, initializer);
    }
}


export class ManageTeamConfig {
    team!: {
        teamnumber: string;
        name: string;
        description: string;
        region: string;
    };
    teammembers!: object;
}

export class ManageTeamUserConfig {
    lastname?: string;
    firstname?: string;
    fullname?: string;
    email?: string;
    phonenumber?: string;
    userprofileaddress?: {
        address: string;
        pobox: string;
        city: string;
        state: string;
        county: string;
    };
}

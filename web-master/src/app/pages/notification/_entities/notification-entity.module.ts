import { initializeObject } from '../../../@core/common/initializer';

export class NotificationResult {
    updatedon!: string;
    priorityleveltypekey!: string;
    fromname!: string;
    toname!: string;
    frommail!: string;
    tomail!: string;
    subject!: string;
    hasattachments!: boolean;
    usernotificationtypekey!: string;
    body!: string;
    isread!: boolean;
    usernotificationid!: string;
    entityid?: string;
    servicerequestnumber!: string;
    intakeserviceid!: string;
    objecttype!: string;
    statestatuteskey: any;
    constructor(initializer?: NotificationResult) {
        initializeObject(this, initializer);
    }
}
export class NotificationSearch {
    pagenumber!: 1;
    constructor(initializer?: Notification) {
        initializeObject(this, initializer);
    }
}

export class BroadCastMessage {
    id!: number;
    securityusersid!: string;
    email!: string;
    displayname!: string;
    userphoto!: string;
    zipcode!: number;
    county!: string;
    phonenumber!: number;
    role!: string;
    isSelected!: boolean;
}
export class EntityNotification {
    totalcount!: string;
    usernotificationid!: string;
    fromname!: string;
    toname!: string;
    usernotificationtypekey!: string;
    url?: any;
    subject!: string;
    priorityleveltypekey!: string;
    body!: string;
    hasattachments?: any;
    updatedby!: string;
    updatedon!: string;
    insertedby!: string;
    insertedon!: string;
    teammemberid?: any;
    attachmentlocation?: any;
    servicerequestnumber?: any;
    tosecurityusersid!: string;
    isreplied?: any;
    isforwarded?: any;
    iscarboncopy?: any;
    isread!: boolean;
    effectivedate!: string;
    expirationdate?: any;
    intakeserviceid!: string;
    source: any;
    entityid: any;
}

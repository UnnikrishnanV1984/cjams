
export class Attachment {
    filename!: string;
    Documentproperties!: string;
    Documentattachment!: string;
    documentpropertiesid!: string;
    documenttypekey!: string;
    documentdate!: Date;
    title!: string;
    mime!: string;
    insertedby!: string;
    insertedon!: Date;
    updatedon!: Date;
    documentattachment!: AttachmentType;
    userprofile!: UserProfile;
    s3bucketpathname!: string;
    description!: string;
    originalfilename!: string;
    titleheadertext!: string;
    assessmenttemplateid: any;
    isrequired!: boolean;
    actualdocumentdate!: string;
    other!: string;
    uplodeddate!: string;
    updatedby!: string;
}
export class AttachmentType {
    documentpropertiesid?: string;
    attachmenttypekey?: string;
    attachmentclassificationtypekey?: string;
    attachmentclassificationsubtypekey?: string;
    attachmentClassificationSubTypeKey?: string;
    updatedby?: string;
    attachmentdate?: Date;
    assessmenttemplateid?: string;
}

export class UserProfile {
    securityusersid?: string;
    firstname?: string;
    lastname?: string;
    displayname?: string;
}
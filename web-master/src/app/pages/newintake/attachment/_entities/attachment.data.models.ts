
export class Attachment {
    originalfilename: string;
    filename: string;
    Documentproperties: string;
    Documentattachment: string;
    documentpropertiesid: string;
    documenttypekey: string;
    documentdate: Date;
    title: string;
    description: string;
    mime: string;
    insertedby: string;
    insertedon: Date;
    documentattachment: AttachmentType;
    userprofile: UserProfile;
    s3bucketpathname: string;
    numberofbytes: number;
}
export class AttachmentType {
    documentpropertiesid: string;
    attachmenttypekey: string;
    attachmentclassificationtypekey: string;
    updatedby: string;
    attachmentdate: Date;
}

export class UserProfile {
    securityusersid: string;
    firstname: string;
    lastname: string;
    displayname: string;
}

export class GeneratedDocuments {
    id: string;
    key: string;
    title: string;
    generatedBy: string;
    generatedDateTime: string;
    isSelected: boolean;
    isRequired: boolean;
    isInProgress: boolean;
    isGenerated: boolean;
    access: string[];
}

export class AttachmentUpload {
    index?: number;
    filename: string;
    mime: string;
    numberofbytes: number;
    s3bucketpathname: string;
}
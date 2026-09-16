
export class AttachmentUpload {
    index?: number;
    filename: string;
    mime: string;
    numberofbytes: number;
    s3bucketpathname: string;
}

export class AttachmentIntake {
    filename: string;
    mime: string;
    numberofbytes: string;
    s3bucketpathname: string;
    documentdate: string;
    intakenumber: string;
    objecttypekey: string;
    rootobjecttypekey: string;
    activeflag: number;
    insertedby: string;
    updatedby: string;
    title: string;
    description: string;
    documentattachment: {
        attachmentdate: string;
        sourceauthor: string;
        attachmentsubject: string;
        sourceposition: string;
        attachmentpurpose: string;
        sourcephonenumber: string;
        acquisitionmethod: string;
        sourceaddress: string;
        locationoforiginal: string;
        insertedby: string;
        note: string;
        updatedby: string;
        activeflag: number;
        attachmenttypekey: string;
        attachmentclassificationtypekey: string;
        assessmenttemplateid: string;
    };
}
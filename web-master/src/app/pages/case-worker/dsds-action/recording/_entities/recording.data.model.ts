export class MeetingRecordingActor {
    intakeservicerequestactorid!: string;
    personid!: string;
}

export class MeetingParticipant {
    participanttype!: string;
    participantkey!: string;
    participantroledesc!: string;
    firstname!: string;
    lastname!: string;
    emailid!: string;
    personid!: string;
    isinvited!: number;
    isattended!: number;
    isaccpted!: number;
    providerId!: string;
    participantttypekey?: any;
}

export class FimType {
    familymeetingtypekey!: string;
    familymeetingsubtypekey!: string;
}
export class Fim {
    intakeserviceid!: string | null;
    servicecaseid!: string | null;
    adoptioncaseid!: string | null;
    meetingdate!: Date;
    meetingtypekey!: string;
    persontype!: string;
    personname!: string;
    meetingdescription!: string;
    meetingcomments!: string;
    isfollowupmeeting!: number;
    followmeetingdate!: Date;
    followupdate!: Date;
    parentmeetingid?: any;
    iscompleted!: number;
    ismeetingdecision!: number;
    meetingrecordingactor!: MeetingRecordingActor[];
    followmeetingrecordingactor!: MeetingRecordingActor[];
    meetingparticipants!: MeetingParticipant[];
    fimtype!: FimType[];
    uploadedfile?: any[];
}

export interface FamilyList {
    intakeserviceid: string;
    meetingdate: string;
    meetingtypekey: string;
    persontype: string;
    meetingrecordingactor: string;
    personname: string;
    meetingdescription: string;
    meetingcomments: string;
    meetingdecisioncomments: string;
    isfollowupmeeting: number;
    parentmeetingid?: any;
    Persondropdown?: any;
    meetingstatus?: any;
    fimtype: any;
    iscompleted: number;
    ismeetingdecision: number;
    followmeetingrecordingactor: string;
    followmeetingdate?: any;
    followupdate?: any;
    meetingdecision?: any;
    recordingactor: Recordingactor[];
    participants: Participant[];
    hearingdetail?:any;
    fimdetails: Fimdetail[];
    uploadedfile?: any;
    meetingtype: any;
    meetingrecordingid?: any;
    placementid?: string;
}

export interface Fimdetail {
    familymeetingtypekey: string;
    familymeetingsubtypekey: string;
}
export interface Participant {
    collateralid: any;
    participanttype: string;
    participantkey?: (null | string)[];
    participantroledesc: string;
    firstname: string;
    lastname: string;
    emailid: string;
    personid?: string;
    isinvited: number;
    isattended: number;
    isaccpted: number;
    electronicsignature:string;
    meetingtype: any;
}
export interface Recordingactor {
    meetingrecordingid: string;
    personid: string;
    actortype: string;
    firstname: string;
    lastname: string;
    typedescription: string;
}
export class ReasonForContact {
    progressnotereasontypeid!: string;
    progressnotereasontypekey!: string;
    activeflag!: number;
    typedescription!: string;
    effectivedate!: Date;
    old_id!: string;
}

export class Participants {
    totalcount!: number;
    intakeservicerequestactorid!: string;
    firstname!: string;
    lastname!: string;
    dob!: Date;
    personid!: string;
    roles!: PersoRoles[];
    relationship!: string;
    ishousehold!: number;
    iscollateralcontact!: number;
    schoolname!: string;
    gender!: string;
    race!: string;
    address!: string;
}
export class PersoRoles {
    intakeservicerequestpersontypekey!: string;
    intakeservicerequestactorid!: string;
    typedescription!: string;
    personname?: string;
}

export class ResourceConsult {
    intakeservicerequestconsultreviewid?: string;
    resourceconsultuser!: ResourceConsultUser[];
    date!: Date;
    notes!: string;
    intakeserviceid!: string;
    time!: string;
}

export class ResourceConsultUser {
    intakeservicerequestconsultreviewconfigid!: string;
    name!: string;
    consultreviewusertypekey!: string;
    consultreviewusertype!: string;
}

export class ResourceList {
    intakeservicerequestconsultreviewid!: string;
    resourceconsultuser!: ResourceConsultUser[];
    date!: Date;
    notes!: string;
    insertedby!: string;
    insertedon!: Date;
    updatedby!: string;
    updatedon?: any;
    activeflag!: number;
    intakeserviceid!: string;
    reviewdate: any;
}

export class RecordingNotes {
    recordingtype?: string;
    progressnotetypeid!: string;
    progressnotesubtypeid!: string;
    contactdate!: string;
    contactname?: string;
    progressnotereasontypekey!: string;
    totaltime?: string;
    contactparticipant!: ContactParticipant[];
    focusperson?: any;
    contacttrialvisit!: ContactTrialVisit;
    contactphone?: string;
    contactemail?: string;
    description!: string;
    recordingsubtype!: string;
    starttime!: string;
    endtime!: string;
    entitytypeid!: string;
    servicecaseid?: string;
    progressnotereasontypedescription!: string;
    entitytype!: string;
    savemode!: number;
    stafftype!: number;
    attemptind!: boolean;
    instantresults!: number;
    contactstatus!: boolean;
    drugscreen!: boolean;
    others?: string;
    progressnotepurposetypekey?: string;
    progressnoteroletype?: string;
    documentpropertiesid?: string;
    draft?: string;
    progressnoteid?: string;
    s3bucketpathname!: string;
    filename!: string;
    traveltime!: string;
    progressnoterole?: any;
    histories?: any[];
    notesid?: any;
    isIntake?: string;
    notedetails!: any[];
    duration?: string;
    initiationindicator: any;
    recordingtypedescription: any;
    uploadedfile:any;
    detail: any;
    doctitle: any;
    team: any;
    author: any;
    recordingdate: any;
    witsid: any;
    updatedon: any;
    mioptions?:string;
}

export class ContactTrialVisit {
    issuedesc!: string;
    safetydesc!: string;
    services_childdesc!: string;
    services_parentdesc!: string;
    permanencystepdesc!: string;
    placementdesc!: string;
    educationdesc!: string;
    healthdesc!: string;
    socialareadesc!: string;
    financialliteracydesc!: string;
    familyplanningdesc!: string;
    skillissuedesc!: string;
    transitionplandesc!: string;
}

export class ContactParticipant {
    intakeservicerequestactorid?: any;
    participanttypekey!: string;
    firstname!: string;
    lastname!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    zipcode!: string;
    email!: string;
    phonenumber!: string;    
    typedescription!: string;
    contactparticipantid!: string;
    collateralid!: string;
    name: any;
    childroles: any;
}
export class ParticipantType {
    participanttypeid!: string;
    participanttypekey!: string;
    typedescription!: string;
    displayorder!: string;
    activeflag!: number;
    objecttypekey!: string;
    effectivedate!: string;
    old_id?: any;
}

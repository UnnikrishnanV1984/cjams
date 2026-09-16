import { Allegation, AttachmentIntake, CrossReference, IntakeDATypeDetail, InvolvedEntitySearchResponse, InvolvedPerson, Recording } from './newintakeModel';

export class IntakeScreen {
    General: General = new General();
    DAType: DATypeDetails = new DATypeDetails();
    Agency: Agency[] = [];
    CrossReferences: CrossReference[] = [];
    Person: Person[] = [];
    Recording: Recordings = new Recordings();
    Allegations: Allegation[] = [];
    NarrativeIntake: NarrativeIntake[] = [];
    AttachmentIntake: AttachmentIntakes[] = [];
    EvaluationField: EvaluationFields[] = [];
    Appointments: IntakeAppointment[] = [];
}

export class DATypeDetails {
    DATypeDetail: DATypeDetail[] = [];
}

export class Recordings {
    Recordings: Recording[] = [];
}
export class NarrativeIntake {
    NarrativeIntake: NarrativeIntake[] = [];
}
export class AttachmentIntakes {
    AttachmentIntakes: AttachmentIntake[] = [];
}
export class General {
    safeHavenAssessmentScore!: number;
    kinshipAssessmentScore!: number;
    ascrsScore!: number;
    CreatedDate!: Date;
    Source!: string;
    Author!: string;
    LegalGuardian!: string;
    RecivedDate!: string;
    Time = new Date();
    Narrative!: string;
    cpsHistoryClearance!: string;
    GroupReason!: string[];
    InputSource!: string;
    GroupSummary!: string[];
    IsAnonymousReporter!: boolean;
    IsUnknownReporter!: boolean;
    MisssingPersons!: boolean;
    SuspiciousDeath!: boolean;
    IllegalActivity!: boolean;
    IllegalActivityKey!: string;
    SignificantEvent!: boolean;
    SignificantEventKey!: string;
    IntakeNumber = '';
    MoNumber!: string;
    Purpose!: string;
    PurposeName!: string;
    Agency!: string;
    intakeservice: any[] = [];
    iAndRsubtype!: string;
    otheragency!: string;
    isOtherAgency!: boolean;
    dispositioncode!: string;
    intakeserreqstatustypekey!: string;
    Firstname!: string;
    Middlename!: string;
    Lastname!: string;
    AgencyCode!: string;
    receiveddelay!: string;
    submissiondelay!: string;
    PhoneNumber!: string;
    ZipCode!: string;
    RefuseToShareZip!: boolean;
    offenselocation!: string;
    Iscps?: string | null;
    communicationDescription!: string;
    agencyDescription!: string;
    purposeDescription!: string;
    isDisposition!: boolean;
    islocalreferal!: number;
    referalcomments!: string;
    countyid!: string;
    countydesc!: string;
    nonreferalreason!: string;
    requesteraddress1!: string;
    requesteraddress2!: string;
    requestercity!: string;
    requesterstate!: string;
    requestercounty!: string;
    requestercountyname!: string;
    isacknowledgementletter!: number;
    servicerequest!: string[];
    suggestedresource!: string[];
    voluntaryPlacementType?: string;
    incidentlocation!: string;
    incidentdate!: string;
    isapproximate!: string;
    email!: string;
    narrativeUpdatedDate?: any;
    approvaldetails?: any;
    intakechessieid!: string;
    supervisorflag!: string;
    addendumNarrative!: string;
    addendumNarrativeCreatedAt!: string;
    addendumNarrativeUpdatedAt!: string;
    addendumNarrativeCreatedBy!: string;
    addendumNarrativeUpdatedBy!: string;
    addendumNarrativeCreatedByInfo!: string;
    addendumNarrativeUpdatedByInfo!: string;
    casedetails!: string[];
    isoverriderequest!: boolean;
    casealreadycreated!: boolean;
    isaddendumnarrativeupdated!: boolean;
}
export class DelayResponse {
    message!: string | null;
    isreceiveddelay!: boolean | null;
    issubmitdelay!: boolean | null;
}

export class DelayForm {
    fiveDays!: string;
    twentyFiveDays!: string;
}
export class DATypeDetail {
    DaTypeKey: string;
    DasubtypeKey: string;
    Investigatable: boolean;
    Actionable: boolean;
    personid: string;
    DAStatus: string;
    DADisposition: string[];
    CancelReason: string[];
    CancelDescription: string[];
    Summary: string[];
    ServiceRequestNumber: string;
    GroupNumber: string;
    GroupReasonType: string;
    GroupComment: string;
    constructor(initializer: IntakeDATypeDetail) {
        this.Actionable = initializer.Actionable;
        this.DaTypeKey = initializer.DaTypeKey;
        this.DasubtypeKey = initializer.DasubtypeKey;
        this.Investigatable = initializer.Investigatable;
        this.personid = '';
        this.DAStatus = initializer.DAStatus;
        this.DADisposition = [initializer.DADisposition];
        this.CancelReason = [initializer.CancelReason];
        this.CancelDescription = [initializer.CancelDescription];
        this.Summary = [initializer.Summary];
        this.ServiceRequestNumber = initializer.ServiceRequestNumber;
        this.GroupNumber = initializer.GroupNumber;
        this.GroupReasonType = initializer.GroupReasonType;
        this.GroupComment = initializer.GroupComment;
    }
}

export class Agency {
    AgencyId: string;
    OfficialName: string;
    Category: string;
    EntityType: string;
    EntitySubtype: string;
    constructor(initializer: InvolvedEntitySearchResponse) {
        this.AgencyId = initializer.agencyid;
        this.OfficialName = initializer.agencyname;
        this.Category = '';
        this.EntityType = initializer.agencytypedesc;
        this.EntitySubtype = initializer.agencysubtypedesc;
    }
}

export class Person {
    id!: number;
    Pid?: string | null;
    Role: string;
    Firstname: string;
    Lastname: string;
    Middlename: string;
    Dob: string;
    Gender: string;
    Race: string[];
    PrimaryPhoneNumberext!: string;
    PrimaryPhoneNumber: string;
    TemparoryPhoneNumber: string;
    TemparoryPhoneNumberext: string;
    AddressId: string;
    Address: string;
    Address2: string;
    City: string;
    State: string;
    Zip: string;
    County: string;
    SSN: string;
    Dcn: string;
    RelationshiptoRA: string;
    Dangerous: string;
    DangerousWorkerReason: string;
    DangerousAddress: string;
    DangerousAddressReason: string;
    Mentealillness: string;
    MentealillnessDetail: string;
    Mentealimpair: string;
    MentealimpairDetail: string;
    Ethicity: string;
    PrimaryLanguage: string;
    TemparoryAddressId: string;
    TemparoryAddress: string;
    TemparoryAddress2: string;
    TemparoryCity: string;
    TemparoryState: string;
    TemparoryZip: string;
    RoutingAddress: string;
    Alias!: {
        AliasName: AliasName[];
    };
    constructor(initializer: InvolvedPerson) {
        this.Firstname = initializer.Firstname;
        this.Pid = initializer.Pid;
        this.Role = initializer.Role;
        this.Lastname = initializer.Lastname;
        this.Middlename = initializer.Middlename;
        this.Dob = initializer.Dob;
        this.Gender = initializer.Gender;
        this.Race = initializer.Race;
        this.PrimaryPhoneNumber = initializer.primaryPhoneNumber;
        this.TemparoryPhoneNumber = initializer.alternatePhoneNumber;
        this.TemparoryPhoneNumberext = initializer.TemparoryPhoneNumberext;
        this.AddressId = initializer.AddressId;
        this.Address = initializer.Address;
        this.Address2 = initializer.Address2;
        this.City = initializer.City;
        this.State = initializer.State;
        this.Zip = initializer.Zip;
        this.County = initializer.County;
        this.SSN = initializer.SSN;
        this.Dcn = initializer.Dcn;
        this.RelationshiptoRA = initializer.RelationshiptoRA;
        this.Dangerous = initializer.Dangerous;
        this.DangerousWorkerReason = initializer.DangerousWorkerReason;
        this.DangerousAddress = initializer.dangerAddress;
        this.DangerousAddressReason = initializer.DangerousAddressReason;
        this.Mentealillness = initializer.Mentealillness;
        this.MentealillnessDetail = initializer.MentealillnessDetail;
        this.Mentealimpair = initializer.Mentealimpair;
        this.MentealimpairDetail = initializer.MentealimpairDetail;
        this.Ethicity = initializer.Ethicity;
        this.PrimaryLanguage = initializer.PrimaryLanguage;
        this.TemparoryAddressId = initializer.TemparoryAddressId;
        this.TemparoryAddress = initializer.TemparoryAddress;
        this.TemparoryAddress2 = initializer.TemparoryAddress2;
        this.TemparoryCity = initializer.TemparoryCity;
        this.TemparoryState = initializer.TemparoryState;
        this.TemparoryZip = initializer.TemparoryZip;
        this.RoutingAddress = initializer.RoutingAddress;
    }
}
export class AliasName {
    index!: number;
    id!: string;
    Pid!: string;
    AliasFirstName!: string;
    AliasLastName!: string;
}
export class EvaluationFields {
    complaintid!: string;
    offenselocation!: number;
    arrestdate!: string;
    zipcode!: number;
    allegedoffense!: any[];
    allegedoffenseknown!: number;
    allegedoffensedate!: string;
    begindate!: string;
    enddate!: string;
    isdetention!: boolean;
    evaluationsourceagencyid!: string;
    evaluationsourceagencykey!: string;
    evaluationsourcetypeid!: string;
    evaluationsourcetypekey!: string;
    complaintreceiveddate!: string;
    countyid!: string;
    unknownrange!: boolean;
    dateRange!: boolean;
    yearsofage!: string;
    age!: string;
    sourcesearch!: string;
    sourceTitle!: string;
    sourceBadgeNo!: string;
    sourcelastname!: string;
    sourcefirstname!: string;
    sourceStreetno!: string;
    sourceStreet1!: string;
    sourceStreet2!: string;
    sourceKey!: string;
    sourceCount!: string;
    evaluationsourceid!: string;
    narrative?: string;
    ispeaceorder?: boolean;
    adultpetitionid?: string;
    waiverpetitionid?: string;
    iscreatepetition?: boolean;
    isMcapsReq?: boolean;
    victims?: any;
    evaluationsourceagencyname: any;
    countyname: any;
}

export class ComplaintTypeCase {
    caseID!: string;
    complaintids!: string[];
    serviceTypeID!: string;
    serviceTypeValue!: string;
    subServiceTypeID!: string;
    subSeriviceTypeValue!: string;
    GroupNumber!: string;
    GroupReasonType!: string;
    GroupComment!: string;
    choosenAllegation: ChoosenAllegation[] = [];
    dispositioncode?: string;
    intakeserreqstatustypekey?: string;
    supStatus?: string;
    supDisposition?: string;
    apsInvestigation!: string;
    isyouthincustody?: boolean;
    isYouthinCustodyShow?: boolean;
    showLawFileds?: boolean;
    showICJFields?: boolean;
}

export class ChoosenAllegation {
    allegationID!: string;
    allegationValue!: string;
    indicators: any[] = [];
}
export class BroadCostMessage {
    userannouncementid!: string;
    details!: string;
    isaccepted!: boolean;
}
export class IntakeService {
    intakeservid!: string;
    description!: string;
    external_templateid?: string;
    assessmenttemplateid?: string;
    isViewable?: boolean;
    intakesubservice?: IntakeServiceSubtype[];
    intakeservtypekey!: string;
    intakeservsubtype?: any;
}
export class IntakeServiceSubtype {
    intakeservsubtypeid!: string;
    intakeservid!: string;
    intakeservsubtypekey!: string;
    typedescription!: string;
    isSelected!: boolean;
}
export class SearchCase {
    status!: string;
    intakenumber!: string;
    ispreintake!: boolean;
    sortcolumn!: string | null;
    sortorder!: string | null;
    securityusersid!: string | null;
}

export class IntakeAppointment {
    id!: number;
    title!: string;
    titleid!: string;
    appointmentdate!: string;
    servreqaptmtid?: string;
    status!: string;
    appointmentworkername!: string;
    notes!: string;
    isChanged!: boolean;
    intakeserviceid?: string;
    intakeWorkerId!: string;
    appointmentDate!: string;
    appointmentTime!: string;
    appointmentworkerid!: string;
    actors!: { 'actorid': string; 'isoptional': boolean; }[];
    history: IntakeAppointment[] = [];
    scheduledBy!: string;
    worker!: string;
    youthid!: string;
    youthssn!: string;
    titleDetails: TitleDetails[] = [];
    youthname!: string;
    titledescription: any;
}

export class TitleDetails {
    titleid!: string;
    titlekey!: string;
}

export class MembersInMeeting {
    isSelected!: boolean;
    fullname!: string;
    role!: string;
    pid!: string;
    userPhoto!: string;
}

export class CourtDetails {
    intakenumber!: string;
    legalcounselname!: string;
    magistratename!: string;
    workername!: string;
    hearingdatetime!: string;
    courtactiontypekey!: string;
    courtordertypekey!: string;
    courtorderdatetime!: string;
    conditiontypekey!: string;
    conditiontypedescription!: string;
    conditiontypecompletiondatetime!: string;
    terminationdatetime!: string;
    adjudicationdatetime!: string;
    adjudicationdecision!: string;
    allegationid!: string;
    completionTime!: string;
    terminationTime!: string;
    orderTime!: string;
    hearingTime!: string;
    adjudicationTime!: string;
}

export class SAOResponse {
    saoresponsedate!: string;
    saoresponsestatustypekey!: string;
    saoresponseconditiontypekey!: string;
}

export class PetitionDetails {
    intakeservicerequestpetitionid!: string;
    intakenumber!: string;
    petitionid!: string;
    associatedattorneys!: string;
    complaintid!: string;
    transferpetitionid!: string;
    petitionfiled!: boolean;
    hearingdatetime!: string;
    hearingtypekey!: string;
    hearingnotes!: string;
    hearingTime!: string;
}


export class Petition {
    intakenumber!: string;
    petitionid!: string;
    petitiontypekey!: string;
    evaluationfields!: { intakeservicerequestevaluationid: string; }[];
    youth: any;
}

export class GeneratedDocuments {
    id!: string;
    key!: string;
    title!: string;
    generatedBy!: string;
    generatedDateTime!: string;
    isSelected!: boolean;
    isRequired!: boolean;
    isInProgress!: boolean;
    isGenerated!: boolean;
    access!: string[];
    team!: string;
    documentpath!: string;
    fromAPI!: boolean;
}

export class ApproveIntakeResponse {
    responseservicereqnum!: string;
    responseintakeserviceid!: string;
    message!: string;
    intakeservicerequestactorid!: string;
    progrmkey!: string;
    subprogrmkey!: string;
}


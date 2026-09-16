import { DropdownModel } from './../../../../@core/entities/common.entities';
import { initializeObject } from '../../../../@core/common/initializer';
import { General, AttachmentIntakes, EvaluationFields, ComplaintTypeCase, IntakeAppointment, GeneratedDocuments } from './newintakeSaveModel';

export class UserProfileImage {
    filename!: string;
    originalfilename!: string;
    mime!: string;
    numberofbytes!: number;
    s3bucketpathname!: string;
}

export class Provider {
    index!: number;
    providerName!: string;
    Lastname!: string;
    Firstname!: string;
    communicationType!: string;
    emailId!: string;
    phoneNumber!: string;
    TaxID!: string;
    program!: string;
    programType!: string;
    parentTaxId!: string;
    taxId!: string;
    programName!: string;
    isSON!: string;
    isRFP!: string;
    isFEIN!: string;
    entityName!: string;
    parentEntityName!: string;
    country!: string;
    zipCode!: string;
    streetNo!: string;
    streetName!: string;
    cityName!: string;
    stateName!: string;
    countryCode!: string;
}
export class InvolvedPerson {
    index!: number;
    id!: string;
    Pid!: string;
    Role!: string;
    rolekeyDesc!: string;
    RoleExpanded!: string;
    userPhoto!: string;
    Firstname!: string;
    Lastname!: string;
    Middlename!: string;
    Dob!: Date;
    Gender!: string;
    GenderExpanded!: string;
    Race?: string[];
    PrimaryPhoneNumberext!: string;
    TemparoryPhoneNumber!: string;
    TemparoryPhoneNumberext!: string;
    AddressId?: string;
    addresstypeLabel!: string;
    address1!: string;
    Address2!: string;
    city!: string;
    state!: string;
    county!: string;
    zipcode!: number;
    Address!: string;
    City!: string;
    State!: string;
    Zip!: string;
    County!: string;
    SSN!: string;
    Dcn!: string;
    livingArrangements!: string;
    RelationshiptoRA!: string;
    personRole?: PersonRole[];
    Dangerous!: string;
    DangerousWorkerReason!: string;
    DangerousAddressReason!: string;
    Mentealillness!: string;
    MentealillnessDetail!: string;
    Mentealimpair!: string;
    MentealimpairDetail!: string;
    Ethicity!: string;
    PrimaryLanguage!: string;
    TemparoryAddressId?: string;
    TemparoryAddress!: string;
    TemparoryAddress2!: string;
    TemparoryCity!: string;
    TemparoryState!: string;
    TemparoryZip!: string;
    RoutingAddress!: string;
    Alias!: InvolvedPersonAlias[];
    Coutny!: string;
    primaryPhoneNumber!: string;
    alternatePhoneNumber!: string;
    dangerAddress!: string;
    IsAnonymousReporter!: boolean;
    tribalAssociation!: string;
    physicalAtt!: string;
    DobFormatted!: string;
    personAddressInput!: PersonAddress[];
    phoneNumber!: any[];
    emailID!: any[];
    fullName!: string;
    fullAddress!: string;
    contactsmail?: any[];
    contacts?: any[];
    address?: PersonAddress[];
    mentalillsign?: string;
    mentalillsignReason!: string;
    AliasLastName!: string;
    userProfilePicture!: UserProfileImage;
    school?: School[];
    vocation?: Vocation[];
    testing?: Testing[];
    accomplishment?: Accomplishment[];
    raceDescription!: string;
    maritalDescription!: string;
    aliasname?: string;
    displayMultipleRole!: string[];
    physicianinfo?: Physician[];
    healthinsurance?: HealthInsuranceInformation[];
    personmedicationphyscotropic?: Medication[];
    personhealthexam?: HealthExamination[];
    personmedicalcondition?: MedicalConditions[];
    personbehavioralhealth?: BehaviouralHealthInfo[];
    personabusehistory?: HistoryofAbuse;
    personabusesubstance?: SubstanceAbuse;
    employer?: Employer[];
    careerGoals?: string;
    persondentalinfo?: PersonDentalInfo[];
    height?: string;
    weight?: string;
    physicalMark?: string;
    stateid?: string;
    religionkey?: string;
}
export class PersonRole {
    rolekey!: string;
    description!: string;
    relationshiptorakey!: string;
    isprimary!: string;
    hidden!: boolean;
}
export class PersonAddress {
    addressType!: string;
    phoneNo?: string;
    address1!: string;
    Address2?: string;
    zipcode!: string;
    state!: string;
    city!: string;
    county!: string;
    startDate?: Date;
    endDate?: Date;
    addressid!: string;
}

export class EvaluationSourceObject {
    totalcount?: string;
    evaluationsourcekey!: string;
    evaluationsourceid?: string;
    title!: string;
    badgeno!: string;
    lastname!: string;
    firstname!: string;
    streetno!: string;
    street1!: string;
    street2!: string;
}

export class EvaluationSourceType {
    evaluationsourcetypeid!: string;
    evaluationsourcetypekey!: string;
    description!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
}

export class EvaluationSourceAgency {
    evaluationsourceagencyid!: string;
    evaluationsourcetypekey!: string;
    evaluationsourceagencykey!: string;
    description!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
}

export class InvolvedPersonAlias {
    index!: number;
    AliasFirstName!: string;
    AliasLastName!: string;
}
export class InvolvedPersonSearch {
    activeflag = '1';
    personflag = 'T';
    firstname!: string;
    lastname!: string;
    maidenname!: string;
    age!: string;
    race!: string;
    dob!: string;
    gender!: string;
    city!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    dateofdeath!: string;
    roletype!: string;
    rolesubtype!: string;
    interfacetype!: string;
    commapos!: string;
    dangerous!: string;
    region!: string;
    dobfrom!: string;
    dobto!: string;
    ssn!: string;
    dcn!: string;
    mediasrc!: string;
    stateid!: string;
    occupation!: string;
    dl!: string;
    intakeNumber!: string;
}
export class InvolvedPersonSearchResponse {
    alias!: string;
    totalcount!: number;
    personid!: string;
    personroleid!: string;
    personroletype!: string;
    personrolesubtype!: string;
    firstname!: string;
    middlename!: string;
    lastname!: string;
    dob!: Date;
    dangerlevel!: string;
    ssn!: string | undefined;
    dcn!: string;
    primaryaddress!: string | undefined;
    homephone!: string;
    gendertypekey!: string;
    loadnumber!: string;
    teamname!: string;
    addressJson!: InvolvedPersonSearchAddressResponse;
    source?: string;
    middleName?: string;
    gender?: string;
    city?: string;
    zipcode?: string;
    county?: string;
    iscwsurvivingid? : boolean;
    priors!: number;
    relationscount!: number;
    relations: any;
    socialmediasource!: string;
    suffix!: string;
    prefix!: string;
    userphoto!: string;
    mdm_id?: string;
    prefx!: string;
    dateofdeath!: Date;
    exactmatch!: string;
    cjamspid!: string;
    cisclientid!: string;
    dl!: string;
    showSsnMask: any;
    ssnEye!: string;
    isprovider: any;
    score: any;
    rank: any;
    matchtype: any;
    dod: any;
    phone_number: any;
    email: any;
    __splitRow?: any;
}
export class InvolvedPersonSearchAddressResponse {
    Id!: string;
    address1!: string;
    address2!: string;
    city!: string;
    zipcode!: string;
    county!: string;
    state!: string;
}
export class InvolvedEntitySearch {
    name!: string;
    status!: string;
    ssbg!: string;
    agencytype!: string;
    agencysubtype!: string;
    region!: number;
    assignedqas!: string;
    specialterms!: string;
    sanctions!: string;
    activeflag!: string;
    activeflag1!: string;
    count!: string;
    sortcol!: string;
    sortdir!: string;
    county!: string;
    zipcode!: string;
    agencyname!: string;
    fiscalyear!: string;
    provideragreementtype!: string;
    locationfilter!: string;
    phonenumber!: string;
    category!: string;
    agencyid!: string;
    city!: string;
    address1!: string;
    address2!: string;
    facid!: string;
    serviceid!: string;
    servicerequestid!: string;
    ActiveFlag1 = '1';
    ActiveFlag = '1';
}
export class InvolvedEntitySearchResponse {
    agencyid!: string;
    agencyname!: string;
    status!: string;
    ssbg!: string;
    agencytypedesc!: string;
    agencysubtype!: string;
    assignedqas!: string;
    count!: number;
    address!: string;
    city!: string;
    state!: string;
    zipcode!: string;
    phonenumber!: string;
    provideragreementtypekey!: string;
    provideragreementtypename!: string;
    aliasname!: string;
    provideragreementid!: string;
    startdate!: string;
    enddate!: string;
    provideragreementstatuskey!: string;
    fiscalyear!: string;
    activeflag!: string;
    serviceprovider!: string;
    areaserved!: string;
    provideragreementlocationtypekey!: string;
    providernonagreementdetailid!: string;
    providernonagreementtypedescription!: string;
    agencysubtypedesc!: string;
    facid!: string;
    country!: string;
}

export class AgencyCategory {
    agencycategorykey!: string;
    description!: string;
}

export class AgencyType {
    agencytypekey!: string;
    typedescription!: string;
}

export class AgencySubType {
    agencysubtypekey!: string;
    typedescription!: string;
}

export class Agency {
    agencyid!: string;
    activeflag!: number;
    agencytypekey!: string;
    agencyname!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    agencycategorykey!: string;
    agencysubtypekey!: string;
    agencycategory!: AgencyCategory;
    agencytype!: AgencyType;
    agencysubtype!: AgencySubType;
    aliasname!: string;
    agencyaddress!: AgencyAddress[];
    agencyservice!: AgencyService[];
}

export class AgencyService {
    areaserviced!: string;
    service!: InvolvedEntityService;
}

export class InvolvedEntityService {
    serviceid!: string;
    description!: string;
    servicetypekey!: string;
    servicename!: string;
}
export class AgencyAddress {
    agencyaddressid!: string;
    agencyid!: string;
    activeflag!: number;
    agencyaddresstypekey!: string;
    address!: string;
    zipcode!: string;
    city!: string;
    state!: string;
    country!: string;
    county!: string;
    address2!: string;
    region!: string;
}

export class InvolvedEntity {
    intakeservicerequestagencyid!: string;
    agencyid!: string;
    agency!: Agency;
    intakeserviceagencyroletype!: IntakeServiceAgencyRole[];
    expirationdate!: Date;
}
export class AgencyRole {
    agencyroletypekey!: string;
    activeflag!: number;
    typedescription!: string;
    isSelected!: boolean;
    intakeserviceagencyroletypeid!: string;
    intakeservicerequestagencyid!: string;
    effectivedate!: Date;
    insertedby!: string;
    updatedby!: string;
}

export class IntakeServiceAgencyRole {
    intakeserviceagencyroletypeid!: string;
    intakeservicerequestagencyid!: string;
    agencyroletypekey!: string;
    agencyroletype!: AgencyRole;
}

export class SelectedRoles {
    intakeservicerequestagencyid!: string;
    agencyid!: string;
    description!: string;
    agencyroletypekey!: string;
    intakeserviceid!: string;
    intakeserviceagencyroletype!: IntakeServiceAgencyRole[];
}

export class IntakeAgencyRole {
    roleTypes!: AgencyRole[];
    selectedRoleTypes!: SelectedRoles;
}
export class IntakeDATypeDetail {
    index!: number;
    DaTypeKey!: string;
    DaTypeText!: string;
    DasubtypeKey!: string;
    DasubtypeText!: string;
    Investigatable!: boolean;
    Actionable!: boolean;
    personid!: string;
    DAStatus!: string;
    ServiceRequestTypeConfigId!: string;
    DAStatusText!: string;
    DADisposition!: string;
    DADispositionText!: string;
    CancelReason!: string;
    CancelDescription!: string;
    Summary!: string;
    ServiceRequestNumber!: string;
    GroupNumber!: string;
    GroupReasonType!: string;
    GroupComment!: string;
    RouteTo!: string;
    RouteOn!: Date;
    Load!: string;
    Team!: string;
    Allegations: Allegation[] = [];
    agencycode!: string;
}
export class AllegationItem {
    name!: string;
    allegationid!: string;
    indicators!: string[];
    constructor(initializer?: AllegationItem) {
        initializeObject(this, initializer);
    }
}
export class Allegation {
    DaType!: string;
    DaSubType!: string;
    DaNumber!: string;
    AllegationId!: string;
    AllegationName!: string;
    Indicators: string[] = [];
    ParentGridRowIndex!: number;
    GridRowIndex!: number;
}

export class NarrativeIntake {
    Firstname!: string;
    Lastname!: string;
    Narrative!: string;
    Role!: string;
    draftId!: string;
    IsAnonymousReporter!: boolean;
    finalTranscript!: string;
    IsUnknownReporter!: boolean;
}
export class AttachmentIntake {
    filename!: string;
    mime!: string;
    numberofbytes!: string;
    s3bucketpathname!: string;
    documentdate!: string;
    intakenumber!: string;
    objecttypekey!: string;
    rootobjecttypekey!: string;
    activeflag!: number;
    insertedby!: string;
    updatedby!: string;
    title!: string;
    description!: string;
    documentattachment!: {
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
    };
}
export class CrossReference {
    id!: number;
    CrossRefDA: string;
    crossrefdaid: string;
    DAType: string;
    DASubType: string;
    reasonsofcrossref: string;
    Assighnedto: string;
    crossrefwith?: string;
    OGCReferred?: string;
    constructor(initializer: CrossReferenceSearchResponse) {
        this.CrossRefDA = initializer.servicerequestnumber;
        this.reasonsofcrossref = initializer.ReasonsofCrossref;
        this.Assighnedto = initializer.assignedto;
        this.DAType = initializer.srtype;
        this.DASubType = initializer.srsubtype;
        this.crossrefwith = initializer.crossRefwith;
        this.crossrefdaid = initializer.intakeserviceid;
    }
}
export class CrossReferenceSearch {
    servicerequestnumber!: string;
    status: string[] = ['Open'];
    county!: string;
    sid!: string;
    region!: 0;
    zipcode!: string;
    activeflag = '1';
    activeflag1 = '1';
    sortcol!: string;
    sortdir!: string;
    reporteddate!: string;
    reportedenddate!: string;
    narrative!: string;
    disposition!: string;
    reportedadult!: string;
    allegedperpetrator!: string;
    reporter!: string;
    dsdsworker!: string;
    overdue!: string;
    duedate!: string;
    dsdsprovider!: string;
    loadnumber!: string;
    agencyid!: string;
    groupnumber!: string;
    groupcreatedate!: string;
    monumber!: string;
    receivedfrom!: string;
    receivedto!: string;
    openfrom!: string;
    opento!: string;
    closefrom!: string;
    closeto!: string;
    intakeserviceid!: string;
    myteam!: string;
    ReasonsofCrossref!: string;
    firstname?: string;
    lastname?: string;
    role?: string;
}
export class CrossReferenceSearchResponse {
    intakenumber!: string;
    complaintid!: string;
    intakeserviceid!: string;
    servicerequestnumber!: string;
    srtype!: string;
    srsubtype!: string;
    raname!: string;
    zipcode!: string;
    county!: string;
    region!: string;
    datereceived!: string;
    timereceived!: string;
    datedue!: string;
    timedue!: string;
    overdue!: string;
    count!: string;
    providername!: string;
    ssbg!: string;
    contractstatus!: string;
    provideragrementid!: string;
    routingstatustypekey!: string;
    areateammemberservicerequestid!: string;
    groupnumber!: string;
    agencyid!: string;
    assignedto!: string;
    teamname!: string;
    disposition!: string;
    srstatus!: string;
    insertedby!: string;
    teamtypekey!: string;
    assignedtosid!: string;
    revisited!: string;
    investigationid!: string;
    ReasonsofCrossref!: string;
    crossRefwith?: string;
    insertedon!: string;
    pastdue!: string;
    dueddate!: string;
}

export class IntakeCrossReferenceSearchResponse {
    intakenumber!: string;
    insertedon!: string;
    status!: string;
    complaintid!: string;
}

export class CrossReferenceResponse {
    crossrefs!: CrossReferenceSearchResponse[];
    intakecrossrefs!: IntakeCrossReferenceSearchResponse[];
}
export class Recording {
    recordingid?: string;
    RecordingDA?: string;
    RecordingType?: string;
    RecordingTypeText?: string;
    RecordingsubType?: string;
    RecordingSubTypeText?: string;
    ContactDate?: string;
    ContactName?: string;
    Contactrole?: string;
    ContactroleText?: string;
    ContactPhoneno?: string;
    contactEmail?: string;
    Detail?: string;
}
export class DaDetails {
    dasubtype!: string;
    danumber!: string;
    description!: string;
    firstname!: string;
    lastname!: string;
    role!: string;
    datereceived!: string;
    datecompleted!: string;
    status!: string;
    intakeserviceid?: string;
    county!: string;
    roles?:any;
    restrictedstatus: any;
    priordanumber: any;
    headofhousehlod: any;
    isExpungedVal?: any;
    workerdetails?: any;
    workername?: string;
}
export class PriorAuditLog {
    danumber!: string;
    description!: string;
    firstname!: string;
    lastname!: string;
    role!: string;
    datereceived!: string;
    datecompleted!: string;
    status!: string;
    priordanumber!: string;
    intakeserviceid!: string;
    restrictedstatus?: string;
}
export class PersonDsdsAction {
    personid?: string;
    mdm_id?: string;
    cisclientid?: string;
    daDetails!: DaDetails[];
    daTypeName!: string;
    highLight = false;
    InvolvedPersonSearchResponse?: any;
    cjamspid!: string;
    constructor(initializer?: PersonDsdsAction) {
        initializeObject(this, initializer);
    }
}

export class PersonDsdsActionByType {
    personid?: string;
    mdm_id?: string;
    cisclientid?: string;
    type!: string;
    cjamspid?: string; 
}

export class Personrelative {
    firstname!: string;
    lastname!: string;
    middlename!: string;
    personid!: string;
}

export class Personrelationtype {
    personrelationtypeid!: string;
    personrelationtypekey!: string;
    description!: string;
}

export class PersonRelativeDetails {
    personrelativeid!: string;
    personrelationtypeid!: string;
    personrelative!: Personrelative;
    personrelationtype!: Personrelationtype;
}

export class RouteDA {
    caseworker_name!: string;
    loadnumber!: string;
    teamname!: string;
}

export class IntakeAssessmentRequestIds {
    intakeservicerequesttypeid!: string;
    intakeservicerequestsubtypeid!: string;
    agencycode!: string;
    intakenumber!: string;
    target!: string;
}

export class EntitesSave {
    index!: number;
    agencyid!: string;
    description!: string;
    agencyroletypekey!: string;
    agencytypekey!: string;
    agencysubtype!: string;
    agencytypedesc!: string;
    phonenumber!: string;
    state!: string;
    zipcode!: string;
}

export class IntakeTemporarySaveModel {
    persons: InvolvedPerson[];
    entities: InvolvedEntitySearchResponse[];
    intakeDATypeDetails: IntakeDATypeDetail[];
    crossReference: CrossReferenceSearchResponse[];
    recordings: ContactTypeAdd[];
    General: General;
    narrative: NarrativeIntake;
    clwStatus: number;
    attachement: AttachmentIntakes[];
    generatedDocuments: GeneratedDocuments[];
    evaluationFields: EvaluationFields;
    appointments: IntakeAppointment[];
    disposition?: DispostionOutput[];
    reviewstatus: ReviewStatus;
    createdCases: ComplaintTypeCase[];
    sdm: Sdm;
    agency: EntitesSave[];
    communicationFields: Notes[];
    DAType?: any;
    securityuserid?: string;
    preIntakeDispo?: PreIntakeDisposition;
    constructor(initializer: IntakeTemporarySaveModel) {
        this.crossReference = initializer.crossReference;
        this.persons = initializer.persons;
        this.entities = initializer.entities;
        this.agency = initializer.agency;
        this.intakeDATypeDetails = initializer.intakeDATypeDetails;
        this.recordings = initializer.recordings;
        this.General = initializer.General;
        this.narrative = initializer.narrative;
        this.attachement = initializer.attachement;
        this.evaluationFields = initializer.evaluationFields;
        this.appointments = initializer.appointments;
        this.reviewstatus = initializer.reviewstatus;
        this.disposition = initializer.disposition;
        this.createdCases = initializer.createdCases;
        this.sdm = initializer.sdm;
        this.preIntakeDispo = initializer.preIntakeDispo;
        this.generatedDocuments = initializer.generatedDocuments;
        this.communicationFields = initializer.communicationFields;
        this.clwStatus = initializer.clwStatus;
    }
}

export class GetAssessments {
    totalcount!: number;
    assessmentid!: string;
    assessmenttemplateid!: string;
    external_templateid!: string;
    submissionid!: string;
    description!: string;
    updatedon!: Date;
    assessmenttype!: string;
    assessmentstatustypekey!: string;
    assessmentstatustypeid!: number;
    name!: string;
    assessment!: Assessment;
    target!: string;
    titleheadertext!: string;
}

export class Assessment {
    assessmentid!: string;
    assessmenttemplateid!: string;
    submissionid!: string;
    assessmentstatustypekey!: string;
    updatedon!: Date;
}
export class ValidateAddress {
    dpv_footnotes!: string;
    footnotes!: string;
    dpv_match_code!: string;
}

export class Narrative {
    Firstname!: string;
    Lastname!: string;
    PhoneNumber!: string;
    ZipCode!: string;
    Narrative!: string;
    Role!: string;
    draftId!: string;
    IsAnonymousReporter!: boolean;
    finalTranscript!: string;
    IsUnknownReporter!: boolean;
    RefuseToShareZip!: boolean;
    offenselocation!: string;
}

export class SuggestAddress {
    text!: string;
    streetLine!: string;
    city!: string;
    state!: string;
}
export class ValidatedAddress {
    dpvMatchCode!: string;
    dpvFootnotes!: string;
    dpvCmra!: string;
    dpvVacant!: string;
    active!: string;
    ewsMatch!: string;
    lacslinkCode!: string;
    lacslinkIndicator!: string;
    suitelinkMatch!: string;
    footnotes!: string;
}
export class AddressDetails {
    personaddressid!: string;
    personid!: string;
    activeflag!: number;
    Personaddresstype!: AddressTypeDetails;
    address!: string;
    zipcode!: string;
    city!: string;
    state!: string;
    country!: string;
    county!: string;
    effectivedate!: Date;
    expirationdate?: string;
    oldId?: string;
    address2?: string;
    directions?: string;
    danger?: string;
    dangerreason?: string;
}
export class AddressTypeDetails {
    personaddresstypekey!: string;
    typedescription!: string;
}

export class AttachmentUpload {
    index?: number;
    filename!: string;
    mime!: string;
    numberofbytes!: number;
    s3bucketpathname!: string;
}
export class ResourcePermission {
    id?: string;
    parentid?: string;
    name!: string;
    resourceid?: string;
    resourcetype?: number;
    isSelected?: boolean;
    tooltip?: string;
}
export class MyIntakeDetails {
    id!: string;
    intakenumber!: string;
    datereceived!: Date;
    timereceived!: Date;
    narrative!: string;
    raname!: string;
    entityname!: string;
    cruworkername!: string;
}
export class PersonInvolved {
    personid?: string;
    firstname!: string;
    lastname!: string;
    role!: string;
    isnew!: boolean;
    isedit!: boolean;
    isdelete!: boolean;
    obj!: InvolvedPerson;
}

export class Person {
    Lastname?: string;
    Firstname?: string;
    Middlename?: string;
    Dob?: Date;
    Gender?: string;
    religiontype?: string;
    maritalstatus?: string;
    Dangerous?: string;
    Role?: string;
    dangerAddress?: string;
    RelationshiptoRA?: string;
    race?: string;
    Dcn?: string;
    ssn?: string;
    Ethnicity?: string;
    occupation?: string;
    stateid?: string;
    PrimaryLanguage?: string;
    AliasLastName?: string;
    potentialSOR?: string;
    eDLHistory?: string;
    dMH?: string;
    Race?: string;
    Address?: string;
    Address2?: string;
    Zip?: string;
    City?: string;
    State?: string;
    County?: string;
    DangerousWorkerReason?: string;
    DangerousAddressReason?: string;
}

export class ReviewStatus {
    appevent!: string;
    status!: string;
    commenttext!: string;
    assignsecurityuserid?: string;
    assignIntakeuserid?: string;
    ismanualrouting?: boolean;
}

export class DispositionCode {
    description!: string;
    servicerequesttypeconfigid!: string;
    dispositioncode!: string;
    intakeserreqstatustypeid!: string;
    intakeserreqstatustypekey!: string;
    servicerequesttypeconfigdispositioncode!: DispoistionList[];
}

export class DispoistionList {
    description!: string;
    dispositioncode!: string;
    intakeserreqstatustypeid!: string;
    servicerequesttypeconfigid!: string;
}
export class DispostionOutput {
    dispositioncode?: string;
    intakeserreqstatustypekey?: string;
    comments?: string;
    reason?: string;
    DAStatus!: string;
    DADisposition!: string;
    Summary!: string;
    ReasonforDelay?: string;
    supStatus?: string;
    supDisposition?: string;
    supComments?: string;
    isDelayed?: string;
    intakeMultipleDispositionDropdown?: DropdownModel[];
    supMultipleDispositionDropdown?: DropdownModel[];
    DaTypeKey?: string;
    DasubtypeKey?: string;
    ServiceRequestNumber?: string;
    subSeriviceTypeValue?: string;
    intakeAction?: string;
    GroupNumber?: string;
    GroupReasonType?: string;
    GroupComment?: string;
    issubtypekey?: boolean;
    subtypekey?: string;
}
export class GeneralNarative {
    formkey!: string;
    controlindex!: number;
    helptext!: string;
}
export class IntakePurpose {
    description!: string;
    intakeservreqtypeid!: string;
    teamtype!: { sequencenumber: number; teamtypekey: string };
}
export class SubType {
    activeflag!: number;
    classkey!: string;
    description!: string;
    intakeservreqtypeid!: string;
    investigatable!: boolean;
    servicerequestsubtypeid!: string;
    workloadweight!: number;
}

export interface Timestamp {
    type: string;
    data: number[];
}

export interface GetAssessmentScore {
    score: number;
    assessmenttemplateid: string;
    name: string;
    description: string;
    version: string;
    titleheadertext: string;
    assessmenttextpositiontypekey: string;
    instructions: string;
    activeflag: number;
    effectivedate: Date;
    expirationdate?: Date;
    oldId?: string;
    timestamp: Timestamp;
    helptext: string;
    datamappingenabled: boolean;
    enableassessmentscore: boolean;
    scoringname?: string;
    calculationmethod?: string;
    assessmentscoresetupid?: string;
    external_templateid: string;
    assessmentTextPositionTypeKey: string;
    target: string;
}

export class Sdm {
    referralname!: string;
    referraldob!: Date;
    referralid!: string;
    county!: string;
    countyid!: string;
    ismaltreatment!: boolean;
    maltreatment!: string;
    physicalAbuse!: PhysicalAbuse;
    malpa_suspeciousdeath!: boolean;
    malpa_nonaccident!: boolean;
    malpa_injuryinconsistent!: boolean;
    malpa_insjury!: boolean;
    malpa_childtoxic!: boolean;
    malpa_caregiver!: boolean;
    sexualAbuse!: SexualAbuse;
    malsa_sexualmolestation!: boolean;
    malsa_sexualact!: boolean;
    malsa_sexualexploitation!: boolean;
    malsa_physicalindicators!: boolean;
    generalNeglect!: GeneralNeglect;
    negfp_cargiverintervene!: boolean;
    negab_abandoned!: string;
    unattendedChild!: UnattendedChild;
    neguc_leftunsupervised!: boolean;
    neguc_leftaloneinappropriatecare!: boolean;
    neguc_leftalonewithoutsupport!: boolean;
    riskofHarm!: RiskofHarm;
    negrh_priordeath!: boolean;
    negrh_sexualperpetrator!: boolean;
    negrh_basicneedsunmet!: boolean;
    negmn_unreasonabledelay!: string;
    menab_psycologicalability!: boolean;
    menng_psycologicalability!: boolean;
    screeningRecommend!: string;
    scnRecommendOveride!: string;
    screenOut!: ScreenOut;
    isscrnoutrecovr_insufficient!: boolean;
    isscrnoutrecovr_information!: boolean;
    isscrnoutrecovr_historicalinformation!: boolean;
    isscrnoutrecovr_otherspecify!: boolean;
    scrnout_description!: boolean;
    screenIn!: ScreenIn;
    isscrninrecovr_courtorder!: boolean;
    isscrninrecovr_otherspecify!: boolean;
    scrnin_description!: boolean;
    isfinalscreenin!: boolean;
    immediate!: string;
    immediateList!: ImmediateList;
    isnoimmed_physicalabuse!: boolean;
    isnoimmed_sexualabuse!: boolean;
    isnoimmed_neglectresponse!: boolean;
    isnoimmed_mentalinjury!: boolean;
    isimmed_childfaatility!: boolean;
    isimmed_seriousinjury!: boolean;
    isimmed_childleftalone!: boolean;
    isimmed_allegation!: boolean;
    isimmed_otherspecify!: boolean;
    immediateList6!: boolean;
    noImmediateList!: NoImmediateList;
    childunderoneyear!: string;
    officerfirstname!: string;
    officermiddlename!: string;
    officerlastname!: string;
    badgenumber!: string;
    recordnumber!: string;
    reportdate!: Date;
    worker!: string;
    workerdate!: Date;
    supervisor!: string;
    supervisordate!: Date;
    allegedvictim!: VictimName[];
    allegedmaltreator!: MaltreatorsName[];
    provider!: ProviderName[];
    disqualifyingCriteria!: Disqualifyingcriteria;
    issexualabuse!: boolean;
    isoutofhome!: boolean;
    isdeathorserious!: boolean;
    isrisk!: boolean;
    isreportmeets!: boolean;
    issignordiagonises!: boolean;
    ismaltreatment3yrs!: boolean;
    ismaltreatment12yrs!: boolean;
    ismaltreatment24yrs!: boolean;
    isactiveinvestigation!: boolean;
    disqualifyingFactors!: Disqualifyingfactors;
    isreportedhistory!: boolean;
    ismultiple!: boolean;
    isdomesticvoilence!: boolean;
    iscriminalhistory!: boolean;
    isthread!: boolean;
    islawenforcement!: boolean;
    iscourtiinvestigation!: boolean;
    cpsResponseType!: string;
    isir!: boolean;
    isar!: boolean;
    iscps!: string;
    datesubmitted?: Date;
    sdmDescription!: SDMDescription;
    recsc_screenout!: boolean;
    recsc_scrrenin!: boolean;
    recovr_scrrenin!: boolean;
    reccps_screenout!: boolean;
}
export class VictimName {
    victimname!: string;
}
export class MaltreatorsName {
    maltreatorsname!: string;
}
export class ProviderName {
    providername!: string;
}
export class PhysicalAbuse {
    malpa_suspeciousdeath!: boolean;
    malpa_nonaccident!: boolean;
    malpa_injuryinconsistent!: boolean;
    malpa_insjury!: boolean;
    malpa_childtoxic!: boolean;
    malpa_caregiver!: boolean;
}
export class SexualAbuse {
    malsa_sexualmolestation!: boolean;
    malsa_sexualact!: boolean;
    malsa_sexualexploitation!: boolean;
    malsa_physicalindicators!: boolean;
}
export class GeneralNeglect {
    neggn_suspiciousdeath!: boolean;
    neggn_signsordiagnosis!: boolean;
    neggn_inadequatefood!: boolean;
    neggn_exposuretounsafe!: boolean;
    neggn_inadequateclothing!: boolean;
    neggn_inadequatesupervision!: boolean;
    neggn_childdischarged!: boolean;
}
export class UnattendedChild {
    neguc_leftunsupervised!: boolean;
    neguc_leftaloneinappropriatecare!: boolean;
    neguc_leftalonewithoutsupport!: boolean;
}
export class RiskofHarm {
    negrh_priordeath!: boolean;
    negrh_sexualperpetrator!: boolean;
    negrh_basicneedsunmet!: boolean;
}
export class ScreenOut {
    isscrnoutrecovr_insufficient!: boolean;
    isscrnoutrecovr_information!: boolean;
    isscrnoutrecovr_historicalinformation!: boolean;
    isscrnoutrecovr_otherspecify!: boolean;
    scrnout_description!: boolean;
}
export class ScreenIn {
    isscrninrecovr_courtorder!: boolean;
    isscrninrecovr_otherspecify!: boolean;
    scrnin_description!: boolean;
}
export class ImmediateList {
    isimmed_childfaatility!: boolean;
    isimmed_seriousinjury!: boolean;
    isimmed_childleftalone!: boolean;
    isimmed_allegation!: boolean;
    isimmed_otherspecify!: boolean;
    immediateList6!: boolean;
}
export class NoImmediateList {
    isnoimmed_physicalabuse!: boolean;
    isnoimmed_sexualabuse!: boolean;
    isnoimmed_neglectresponse!: boolean;
    isnoimmed_mentalinjury!: boolean;
}

export class Disqualifyingcriteria {
    issexualabuse!: boolean;
    isoutofhome!: boolean;
    isdeathorserious!: boolean;
    isrisk!: boolean;
    isreportmeets!: boolean;
    issignordiagonises!: boolean;
    ismaltreatment3yrs!: boolean;
    ismaltreatment12yrs!: boolean;
    ismaltreatment24yrs!: boolean;
    isactiveinvestigation!: boolean;
}

export class Disqualifyingfactors {
    isreportedhistory!: boolean;
    ismultiple!: boolean;
    isdomesticvoilence!: boolean;
    iscriminalhistory!: boolean;
    isthread!: boolean;
    islawenforcement!: boolean;
    iscourtiinvestigation!: boolean;
}
export class CpsDocInput {
    InputSource!: string;
    intakePurpose!: boolean;
}
export interface EntitesSave {
    AgencyId: string;
    OfficialName: string;
    Category: string;
    EntityType: string;
    EntitySubtype: string;
}
export class School {
    personeducationid!: string;
    personid!: string;
    educationname!: string;
    educationtypekey!: string;
    countyid!: string;
    statecode!: string;
    startdate!: string;
    enddate!: string;
    lastgradetypekey!: string;
    currentgradetypekey!: string;
    isspecialeducation!: boolean;
    specialeducation!: string;
    specialeducationtypekey!: string;
    absentdate!: string;
    isreceived!: boolean;
    isverified!: boolean;
    isexcuesed!: boolean;
    schoolTypeDescription!: string;
}

export class Vocation {
    personeducationvocationid!: string;
    personid!: string;
    isvocationaltest!: boolean;
    vocationinterest!: string;
    vocationaptitude!: string;
    certificatename!: string;
    certificatepath!: string;
}

export class Testing {
    personeducationtestingid!: string;
    personid!: string;
    testingtypekey!: string;
    testdescription!: string;
    readinglevel!: number;
    readingtestdate!: string;
    mathlevel!: number;
    mathtestdate!: string;
    testingprovider!: string;
}

export class Accomplishment {
    personaccomplishmentid!: string;
    personid!: string;
    highestgradetypekey!: string;
    accomplishmentdate!: string;
    isrecordreceived!: boolean;
    receiveddate!: string;
    gradedescription!: string;
}

export class Education {
    school?: School[];
    vocation?: Vocation[];
    testing?: Testing[];
    accomplishment?: Accomplishment[];
    personId?: string;
}

export class Assessments {
    totalcount!: number;
    assessmenttextpositiontypekey!: string;
    assessmentscoresetupid!: string;
    assessmenttemplateid!: string;
    calculationmethod!: string;
    datamappingenabled!: string;
    description!: string;
    effectivedate!: Date;
    enableassessmentscore!: boolean;
    expirationdate!: Date;
    external_templateid!: string;
    helptext!: string;
    instructions!: string;
    isvisible!: boolean;
    name!: string;
    old_id!: string;
    scoringname!: string;
    target!: string;
    timestamp!: string;
    titleheadertext!: string;
    version!: number;
    intakassessment!: GetintakAssessment;
}

export class GetintakAssessment {
    assessmenttextpositiontypekey!: string;
    assessmentscoresetupid!: string;
    assessmenttemplateid!: string;
    calculationmethod!: string;
    datamappingenabled!: boolean;
    description!: string;
    effectivedate!: Date;
    enableassessmentscore!: boolean;
    expirationdate!: Date;
    external_templateid!: string;
    helptext!: string;
    instructions!: string;
    isvisible!: boolean;
    name!: string;
    scoringname!: string;
    titleheadertext!: string;
    version!: number;
    submissionid!: string;
    score!: number;
    assessmentstatustypekey!: string;
    assessmentid!: string;
    username!: string;
    updateddate!: Date;
}
export class FinalIntake {
    intake!: IntakeTemporarySaveModel;
    review!: ReviewStatus;
}
export class IntakeContactRoleType {
    progressnotetypeid!: string;
    progressnotetypekey!: string;
    description!: string;
}

export class IntakeContactRole {
    sequencenumber!: string;
    contactroletypekey!: string;
    activeflag = 1;
    datavalue!: string;
    editable!: number;
    typedescription!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    timestamp!: Date;
}
export class ContactTypeAdd {
    recordingdate!: Date;
    duriation!: string;
    progressnotetypeid!: string;
    RecordingDA!: string;
    recordingtype!: string;
    title!: string;
    description!: string;
    entitytype!: string;
    entitytypeid!: string;
    pagetitle!: string;
    pageurl!: string;
    savemode!: number;
    contactdate!: string;
    contactname!: string;
    progressnotetypekey!: string;
    contactphone!: string;
    contactemail!: string;
    attemptindicator!: number;
    starttime!: string;
    endtime!: string;
    recordingsubtype!: string;
    author!: string;
    multipleRoles!: string;
    team!: string;
    detail!: Detail;
    progressnoteroletype!: ProgressNoteRoleType[];
    contactroletypekey!: ProgressNoteRoleType[];
    s3bucketpathname!: string;
}

export class IntakeFileAttachement {
    s3bucketpathname!: string;
    title!: string;
    description!: string;
}
export class ProgressNoteRoleType {
    contactroletypekey!: string;
}
export class Detail {
    description!: string;
    contactdate!: Date;
    author!: string;
}

export class SDMDescription {
    malpa_suspeciousdeath!: string;
    malpa_nonaccident!: string;
    malpa_injuryinconsistent!: string;
    malpa_insjury!: string;
    malpa_childtoxic!: string;
    malpa_caregiver!: string;
    malsa_sexualmolestation!: string;
    malsa_sexualact!: string;
    malsa_sexualexploitation!: string;
    malsa_physicalindicators!: string;
    neggn_suspiciousdeath!: string;
    neggn_signsordiagnosis!: string;
    neggn_inadequatefood!: string;
    neggn_exposuretounsafe!: string;
    neggn_inadequateclothing!: string;
    neggn_inadequatesupervision!: string;
    neggn_childdischarged!: string;
    negfp_cargiverintervene!: string;
    negab_abandoned!: string;
    neguc_leftunsupervised!: string;
    neguc_leftaloneinappropriatecare!: string;
    neguc_leftalonewithoutsupport!: string;
    negrh_priordeath!: string;
    negrh_sexualperpetrator!: string;
    negrh_basicneedsunmet!: string;
    negmn_unreasonabledelay!: string;
    menab_psycologicalability!: string;
    menng_psycologicalability!: string;
    ScreenOUT!: string;
    Scrnin!: string;
    OvrScrnout!: string;
    isscrnoutrecovr_insufficient!: string;
    isscrnoutrecovr_information!: string;
    isscrnoutrecovr_historicalinformation!: string;
    isscrnoutrecovr_otherspecify!: string;
    Ovrscrnin!: string;
    isscrninrecovr_courtorder!: string;
    isscrninrecovr_otherspecify!: string;
    isfinalscreenin!: string;
    isfinalscreeninIn!: string;
    isfinalscreeninOut!: string;
    isimmed_childfaatility!: string;
    isimmed_seriousinjury!: string;
    isimmed_childleftalone!: string;
    isimmed_allegation!: string;
    isimmed_otherspecify!: string;
    isnoimmed_physicalabuse!: string;
    isnoimmed_sexualabuse!: string;
    isnoimmed_neglectresponse!: string;
    isnoimmed_mentalinjury!: string;
    isImmediateYes!: string;
    isImmediateNo!: string;
}

export class PreIntakeDisposition {
    reason!: string;
    comment!: string;
    status!: string;
    systemRecmdatn!: string;
    systemRecmdatnStatus!: string;
}

export class AssessmentSummary {
    totalcount!: number;
    opencount!: number;
    inprogresscount!: number;
    completedcount!: number;
}
export class ContactType {
    progressnotetypeid!: string;
    progressnotetypekey!: string;
    description!: string;
}
export class PurposeType {
    progressnotepurposetypeid!: string;
    progressnotepurposetypekey!: string;
    description!: string;
    activeflag!: boolean;
    effectivedate!: string;
}
export class TypeofLocation {
    progressnotetypeid!: string;
    progressnotetypekey!: string;
    description!: string;
}
export class PersonsInvolvedType {
    sequencenumber!: number;
    contactroletypekey!: string;
    activeflag!: boolean;
    datavalue!: number;
    editable!: boolean;
    typedescription!: string;
    effectivedate!: string;
    expirationdate!: string;
    timestamp!: string;
}

export class Notes {
    progressnoteid!: string;
    author!: string;
    date!: string;
    notes!: string;
    location!: string;
    staff!: string;
    recordingtype!: string;
    recordingsubtype!: string;
    title!: string;
    team!: string;
    draft!: string;
    attemptind!: boolean;
    contactdate!: string;
    contactname!: string;
    contactrole!: string[];
    contactphone!: string;
    contactemail!: string;
    archivedon!: string;
    archivedby!: string;
    detail!: string;
    recordingdate!: string;
    insertedby!: string;
    documentpropertiesid!: string;
    doctitle!: string;
    docdescription!: string;
    filename!: string;
    mime!: string;
    s3bucketpathname!: string;
    starttime!: string;
    endtime!: string;
    stafftype!: string;
    instantresults!: string;
    contactstatus!: string;
    drugscreen!: string;
    progressnotetypeid!: string;
    progressnotepurposetype!: string;
}

export class Health {
    persondentalinfo?: PersonDentalInfo[];
    physician?: Physician[];
    behaviouralhealthinfo?: BehaviouralHealthInfo[];
    healthInsurance?: HealthInsuranceInformation[];
    medication?: Medication[];
    healthExamination?: HealthExamination[];
    medicalcondition?: MedicalConditions[];
    history?: HistoryofAbuse;
    substanceAbuse?: SubstanceAbuse;
}

export class Physician {
    isprimaryphycisian!: boolean;
    name!: string;
    facility!: string;
    phone!: string;
    email!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    county!: string;
    zip!: string;
    startdate!: string;
    enddate!: string;
    physicianspecialtytypekey!: string;
}

export class PersonDentalInfo {
    isdentalinfo!: boolean;
    dentistname!: string;
    dentalspecialtytypekey!: string;
    facility!: string;
    phone!: string;
    email!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    county!: string;
    zip!: string;
    startdate!: string;
    enddate!: string;
}

export class BehaviouralHealthInfo {
    behaviouralhealthdiagnosis!: string;
    typeofservice!: string;
    clinicianname!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    county!: string;
    zip!: string;
    phone!: string;
    reportname!: string;
    reportpath!: string;
}

export class HealthExamination {
    healthexamname!: string;
    healthassessmenttypekey!: string;
    healthdomaintypekey!: string;
    assessmentdate!: string;
    healthprofessiontypekey!: string;
    practitionername!: string;
    outcomeresults!: string;
    notes!: string;
}

export class HealthInsuranceInformation {
    ismedicaidmedicare!: string;
    medicalinsuranceprovider!: string;
    providertype!: string;
    policyholdername!: string;
    customprovidertype!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    county!: string;
    zip!: string;
    providerphone!: string;
    patientpolicyholderrelation!: string;
    policyname!: string;
    groupnumber!: string;
    startdate!: string;
    enddate!: string;
}

export class HistoryofAbuse {
    isneglect!: boolean;
    neglectnotes!: string;
    isphysicalabuse!: boolean;
    physicalnotes!: string;
    isemotionalabuse!: boolean;
    emotionalnotes!: string;
    issexualabuse!: boolean;
    sexualnotes!: string;
}

export class MedicalConditions {
    medicalconditiontypekey!: string;
    medicalconditionsnotes!: string;
    custommedicalcondition!: string;
    begindate!: string;
    enddate!: string;
    recordedby!: string;
}

export class Medication {
    medicationname!: string;
    personid!: string;
    medicationeffectivedate!: string;
    medicationexpirationdate!: string;
    dosage!: string;
    complaint!: string;
    frequency!: string;
    prescribingdoctor!: string;
    lastdosetakendate!: string;
    medicationcomments!: string;
    prescriptionreasontypekey!: string;
    informationsourcetypekey!: string;
    startdate!: string;
    enddate!: string;
    compliant!: number;
    reportedby!: string;
    medicationtypekey!: string;
    isMedicationIncludes!: boolean;
    monitoring!: string;
}

export class SubstanceAbuse {
    isusetobacco!: string;
    isusedrugoralcohol!: string;
    isusedrug!: string;
    drugfrequencydetails!: string;
    drugageatfirstuse!: string;
    isusealcohol!: string;
    alcoholfrequencydetails!: string;
    alcoholageatfirstuse!: string;
    drugoralcoholproblems!: string;
}

export class Work {
    employer?: Employer[];
    careergoals?: string;
}

export class Employer {
    employername!: string;
    noofhours!: string;
    duties!: string;
    startdate!: string;
    enddate!: string;
    reasonforleaving!: string;
    careergoals!: string;
}

export class AssessmentScores {
    DRAI: any;
    MCASP: any;
}

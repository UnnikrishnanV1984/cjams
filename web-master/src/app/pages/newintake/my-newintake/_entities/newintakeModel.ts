import { initializeObject } from '../../../../@core/common/initializer';
import { DropdownModel } from './../../../../@core/entities/common.entities';
import { AttachmentIntakes, ComplaintTypeCase, CourtDetails, EvaluationFields, General, GeneratedDocuments, IntakeAppointment, SAOResponse } from './newintakeSaveModel';

export class UserProfileImage {
    filename!: string;
    originalfilename!: string;
    mime!: string;
    numberofbytes!: number;
    s3bucketpathname!: string;
}
export class InvolvedPerson {
    index!: number;
    id!: string;
    Pid!: string | null;
    assistpid!: string;
    cjamspid!: string;
    Role!: string;
    rolekeyDesc!: string;
    RoleExpanded!: string;
    userPhoto!: string;
    Firstname!: string;
    Lastname!: string;
    livingsituationkey!: string;
    licensedfacilitykey!: string;
    otherlicensedfacility!: string;
    livingsituationdesc!: string;
    Middlename!: string;
    Dob!: string;
    dateofdeath!: string;
    isapproxdod!: number;
    isapproxdob!: number;
    safehavenbabyflag!: number;
    everbeenadoptedflag!: number;
    Gender!: string;
    GenderExpanded!: string;
    Race!: string[];
    raceList?: string[];
    PrimaryPhoneNumberext!: string;
    TemparoryPhoneNumber!: string;
    TemparoryPhoneNumberext!: string;
    AddressId!: string;
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
    ssnAvailable!: string;
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
    maritalstatus!: string;
    Ethicity!: string;
    PrimaryLanguage!: string;
    TemparoryAddressId!: string;
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
    DodFormatted!: string;
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
    emergency?: EmergencyContactPerson[];
    height?: string;
    weight?: string;
    physicalMark?: string;
    stateid?: string;
    religionkey?: string;
    fetalalcoholspctrmdisordflag?: number;
    drugexposednewbornflag?: number;
    probationsearchconductedflag?: number;
    sexoffenderregisteredflag?: number;
    senstatusflag?:number;
    substances!: Substances[];
    guardian!: Guardian;
    personsupport?: PersonSupport[];
    race?: any;
    personpayee?: PersonPayee[];
    fullname?: string;
    dob?: string;
    gender?: string;
    phonenumber?: string;
    isDataAvailable?: any;
}
export class Guardian {
    WRK!: WRK[];
    ATTY!: WRK[];
    GOPT!: WRK[];
    GOP!: WRK[];
    hhsdclient!: Hhsdclient;
    codestatus!: Codestatus;
    funeral!: Funeral[];
}
export class PersonSupport {
    personid!: string;
    intakenumber!: string;
    personsupporttypekey!: string;
    supportername!: string;
    description!: string;
}

export class Funeral {
    contact!: string;
    contactnumber!: string;
    personid!: string;
    arrangementsdescription!: string;
}

export class Codestatus {
    codestatustypekey!: string;
    personid!: string;
    othercodestatus!: string;
}

export class Hhsdclient {
    hhsclientid!: string;
    personid!: string;
    notes!: string;
}

export class WRK {
    guardianpersontypekey!: string;
    personid!: string;
    guadianpersonid!: string;
    startdate!: string;
    enddate?: any;
}
export class Substances {
    subtancekey!: string;
    othersubtance!: string;
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
export class EmergencyContactPerson {
    contactpersonid!: string;
    firstname!: string;
    lastname!: string;
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

export class EvaluationOffenseLocationTypeList {
    offencelocationtypeid!: string;
    offencelocationtypekey!: string;
    description!: string;
    activeflag!: number;
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
    personid!: string;
    dateofdeath!: string;
    isapproxdod!: number;
    assistpid!: string;
    cjamspid!: string;
    personroleid!: string;
    personroletype!: string;
    personrolesubtype!: string;
    firstname!: string;
    middlename!: string;
    lastname!: string;
    dob!: Date;
    age: any;
    dangerlevel!: string;
    ssn!: string;
    dcn!: string;
    primaryaddress!: string;
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
    priors!: number;
    relationscount!: number;
    relations!: string;
    socialmediasource!: string;
    suffix!: string;
    userphoto!: string;
    safehavenbabyflag!: string;
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
    allegationname!: string;
    allegationid!: string;
    indicators!: any[];
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
    draftId?: string;
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
        assessmenttemplateid: string;
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
    crossrefwith!: string;
    OGCReferred!: string;
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
    crossRefwith!: string;
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
    roles: any;
    restrictedstatus: any;
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
}
export class PersonDsdsAction {
    personid?: string;
    cisclientid?: string;
    mdm_id?: string;
    daDetails!: DaDetails[];
    daTypeName!: string;
    highLight = false;
    cjamspid?: string;
    constructor(initializer?: PersonDsdsAction) {
        initializeObject(this, initializer);
    }
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
    clwStatus: string;
    signedOffDate: string;
    attachement: AttachmentIntakes[];
    generatedDocuments: GeneratedDocuments[];
    evaluationFields: EvaluationFields[];
    appointments: IntakeAppointment[];
    disposition?: DispostionOutput[];
    reviewstatus: ReviewStatus;
    createdCases: ComplaintTypeCase[];
    sdm: Sdm;
    agency: EntitesSave[];
    saoResponseDetail: SAOResponse;
    petitionDetails: any[];
    scheduledHearings: any[];
    courtDetails: CourtDetails;
    communicationFields: Notes[];
    DAType?: any;
    securityuserid?: string;
    preIntakeDispo?: PreIntakeDisposition;
    adultScreenTool?: any;
    focuspersoncasedetails?: any;
    paymentSchedule: any;
    unknownPersons?: any;
    identifiedPersons?: any;
    placement?: any;
    reasonforDraft?: any[];
    reasonintakeinterview?: any;
    complaintInfoReview?: any;
    detentionOpened?: any;
    roacps: any;
    clearhistory: any;
    userrole: any;
    privateadoption: any;
    officelocation?: any;
    constructor(initializer: IntakeTemporarySaveModel) {
        this.crossReference = initializer.crossReference;
        this.persons = initializer.persons;
        this.reasonforDraft = initializer.reasonforDraft;
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
        this.saoResponseDetail = initializer.saoResponseDetail;
        this.petitionDetails = initializer.petitionDetails;
        this.scheduledHearings = initializer.scheduledHearings;
        this.courtDetails = initializer.courtDetails;
        this.preIntakeDispo = initializer.preIntakeDispo;
        this.generatedDocuments = initializer.generatedDocuments;
        this.communicationFields = initializer.communicationFields;
        this.clwStatus = initializer.clwStatus;
        this.signedOffDate = initializer.signedOffDate;
        this.adultScreenTool = initializer.adultScreenTool;
        this.focuspersoncasedetails = initializer.focuspersoncasedetails;
        this.paymentSchedule = initializer.paymentSchedule;
        this.unknownPersons = initializer.unknownPersons;
        this.identifiedPersons = initializer.identifiedPersons;
        this.placement = initializer.placement;
        this.reasonintakeinterview = initializer.reasonintakeinterview;
        this.complaintInfoReview = initializer.complaintInfoReview;
        this.detentionOpened = initializer.detentionOpened;
        this.roacps = initializer.roacps;
        this.clearhistory = initializer.clearhistory;
        this.privateadoption = initializer.privateadoption;
        this.userrole = initializer.userrole;
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
    Middlename!: string;
    Lastname!: string;
    PhoneNumber!: string;
    PhoneNumberExt!: string;
    ZipCode!: string;
    Narrative!: string;
    Role!: string;
    RoleName!: string;
    draftId?: string;
    IsAnonymousReporter!: boolean;
    finalTranscript!: string;
    IsUnknownReporter!: boolean;
    RefuseToShareZip!: boolean;
    offenselocation!: string;
    requesteraddress1!: string;
    requesteraddress2!: string;
    requestercity!: string;
    requesterstate!: string;
    requestercounty!: string;
    requestercountyname!: string;
    isacknowledgementletter!: boolean;
    incidentlocation!: string;
    incidentdate!: string;
    isapproximate!: string;
    email!: string;
    organization?: string;
    title?: string;
    narrativeUpdatedDate?: any;
    cpsHistoryClearance!: string;
    addendumNarrative!: string;
    addendumNarrativeUpdatedAt?: any;
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
    // D-07003 Start
    // D-07003 Start
    updateddate!: Date;
    datereceivedeststr!: string;
    updateddateeststr!: string;
    // D-07003 End
    // D-07003 End
    narrative!: string;
    raname!: string;
    entityname!: string;
    cruworkername!: string;
    sdm!: SDM[];
    jsondata: any;
    purpose: any;
    headofhousehlod: any;
    receivingcountyname: any;
    transferreason: any;
    reviewstatus: any;
    hoh_name: any;
    transferdate: any;
    requestorname: any;
    youthcjamspid: any;
    youthname: any;
}

export class SDM {
    ischildfatality!: boolean;
    ismaltreatment!: boolean;
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
    DAsubnotes?: string;
    dispositioncode?: string;
    dispositioncodedesc?: string;
    dispositioncodestatus?: string;
    dispositioncodestatusdesc?: string;
    intakeserreqstatustypekey?: string;
    comments?: string;
    reason?: string;
    DAStatus!: string;
    DADisposition!: string;
    Summary!: string;
    ReasonforDelay?: string;
    supStatus?: string;
    supDisposition?: string;
    DAsubdisposition?: string;
    supDispositiondesc?: string;
    DAsubdispositiondesc?: string;
    supComments?: string;
    isDelayed?: string;
    intakeMultipleDispositionDropdown!: DropdownModel[];
    intakeMultipleDispositionStatusDropdown?: DropdownModel[];
    supMultipleDispositionDropdown!: DropdownModel[];
    supMultipleDispositionStatusDropdown?: DropdownModel[];
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
    caseID?: string;
    serviceTypeID?: string;
    restitution?: boolean;
    supRestitution?: boolean;
    subServiceTypeID?: string;
    isYouthIndependentLive!: string;
    captureReason!: string;
    agencyType?: string;
    agencyName?: string;
    agencyContact?: string;
}
export class GeneralNarative {
    formkey!: string;
    controlindex!: number;
    helptext!: string;
}
export class IntakePurpose {
    description!: string;
    intakeservreqtypeid!: string;
    intakeservreqtypekey!: string;
    teamtype!: { sequencenumber: number; teamtypekey: string; };
}

export class IntakeCommunication {
    description!: string;
    intakeservreqinputtypeid!: string;
    intakeservreqinputtypekey!: string;
    teamtype!: { sequencenumber: number; teamtypekey: string; };
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
    comments!: string;
    intakeservicerequestsdmid!: string;
    intakeserviceid!: string;
    referralname!: string;
    referraldob!: Date;
    referralid!: string;
    county!: string;
    countyid!: string;
    ismaltreatment!: boolean;
    maltreatment!: string | null;
    childfatality!: string;
    childfatalityupdated?: string;
    ischildfatality!: boolean;
    linkschidresid!: boolean;
    isfcplacementsetting!: boolean;
    isfclivingarrangement!: boolean;
    isprivateplacement!: boolean;
    islicenseddaycare!: boolean;
    isschool!: boolean;
    physicalAbuse!: PhysicalAbuse;
    ismalpa_suspeciousdeath!: boolean;
    ismalpa_nonaccident!: boolean;
    ismalpa_injuryinconsistent!: boolean;
    ismalpa_insjury!: boolean;
    ismalpa_childtoxic!: boolean;
    ismalpa_caregiver!: boolean;
    ismalpa_labortrafficking!: boolean;
    sexualAbuse!: SexualAbuse;
    ismalsa_sexualmolestation!: boolean;
    ismalsa_sexualact!: boolean;
    ismalsa_sexualexploitation!: boolean;
    ismalsa_physicalindicators!: boolean;
    generalNeglect!: GeneralNeglect;
    arGeneralNeglect!: ARGeneralNeglect;
    isnegfp_cargiverintervene!: boolean;
    isnegab_abandoned!: string;
    unattendedChild!: UnattendedChild;
    isneguc_leftunsupervised!: boolean;
    isneguc_leftaloneinappropriatecare!: boolean;
    isneguc_leftalonewithoutsupport!: boolean;
    riskofHarm!: RiskofHarm;
    isnegrh_priordeath!: boolean;
    isnegrh_exposednewborn!: boolean;
    isnegrh_domesticviolence!: boolean;
    isnegrh_sexualperpetrator!: boolean;
    isnegrh_basicneedsunmet!: boolean;
    isnegrh_treatmenthealthrisk!: boolean;
    isnegrh_substantial_risk!: boolean;
    isnegrh_sex_offender!: boolean;
    isnegrh_risk_dv!: boolean;
    isnegrh_fatality_can!: boolean;
    isnegrh_indicated_unsub!: boolean;
    isnegrh_survivor!: boolean;
    isnegrh_birth_match!: boolean;
    isnegrh_sex_trafficking!: boolean;
    isnegmn_unreasonabledelay!: string;
    ismenab_psycologicalability!: boolean;
    ismenng_psycologicalability!: boolean;
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
    isnoimmed_screeninoverride!: boolean;
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
    reportdate!: Date | null;
    worker!: string;
    workerdate!: Date | null;
    supervisor!: string;
    supervisordate!: Date | null;
    allegedvictim!: VictimName[];
    allegedmaltreator!: MaltreatorsName[];
    provider!: ProviderName[];
    disqualifyingCriteria!: Disqualifyingcriteria;
    issexualabuse!: boolean;
    providerdetails :any;
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
    cpsResponseType!: string | null;
    isir!: boolean;
    isar!: boolean;
    iscps!: string;
    datesubmitted?: Date;
    sdmDescription!: SDMDescription;
    isrecsc_screenout!: boolean;
    isrecsc_scrrenin!: boolean;
    isrecovr_scrrenin!: boolean;
    isreccps_screenout!: boolean;
    changePathway = false;
    isneggn_suspiciousdeath!: boolean;
    isneggn_signsordiagnosis!: boolean;
    isneggn_inadequatefood!: boolean;
    isneggn_childdischarged!: boolean;
    negfp_cargiverintervene: any;
    negab_abandoned: any;
    negmn_unreasonabledelay: any;
    menab_psycologicalability: any;
    menng_psycologicalability: any;
    confirmtrafficking!: string;
    selecttrafficking!: string;
    traffickingupdated!: boolean;
    maltreatmentupdated!: boolean;
    insertedby: any;
    insertedon: any;
    isseriousphysicalinjury: any;

}
export class VictimName {
    victimname!: string;
}
export class MaltreatorsName {
    maltreatorsname!: string;
}
export class ProviderName {
    providername!: string;
    providerid!: string;
    providerphone!: string;
}
export class PhysicalAbuse {
    ismalpa_suspeciousdeath!: boolean;
    ismalpa_nonaccident!: boolean;
    ismalpa_injuryinconsistent!: boolean;
    ismalpa_insjury!: boolean;
    ismalpa_childtoxic!: boolean;
    ismalpa_caregiver!: boolean;
    ismalpa_labortrafficking!: boolean;
}
export class SexualAbuse {
    ismalsa_sexualmolestation!: boolean;
    ismalsa_sexualact!: boolean;
    ismalsa_sexualexploitation!: boolean;
    ismalsa_physicalindicators!: boolean;
    ismalsa_sex_trafficking!: boolean;
}
export class GeneralNeglect {
    isneggn_suspiciousdeath!: boolean;
    isneggn_signsordiagnosis!: boolean;
    isneggn_inadequatefood!: boolean;
    isneggn_childdischarged!: boolean;
}
export class ARGeneralNeglect {
    isneggn_exposuretounsafe!: boolean;
    isneggn_inadequateclothing!: boolean;
    isneggn_inadequatesupervision!: boolean;
    isnegrh_treatmenthealthrisk!: boolean;
}
export class UnattendedChild {
    isneguc_leftunsupervised!: boolean;
    isneguc_leftaloneinappropriatecare!: boolean;
    isneguc_leftalonewithoutsupport!: boolean;
}
export class RiskofHarm {
    isnegrh_priordeath!: boolean;
    isnegrh_exposednewborn!: boolean;
    isnegrh_domesticviolence!: boolean;
    isnegrh_sexualperpetrator!: boolean;
    isnegrh_basicneedsunmet!: boolean;
}
export class ScreenOut {
    duplicatereportflag : any
    isscrnoutrecovr_insufficient: any;
    isscrnoutrecovr_information: any;
    isscrnoutrecovr_historicalinformation: any;
    isscrnoutrecovr_otherspecify: any;
    scrnout_description: any;
}
export class ScreenIn {
    isscrninrecovr_courtorder: any;
    isscrninrecovr_otherspecify: any;
    scrnin_description: any;
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
    isnoimmed_screeninoverride!: boolean;
}

export class Disqualifyingcriteria {
    issexualabuse!: boolean;
    isoutofhome!: boolean;
    isdeathorserious!: boolean;
    islabortrafficking!: boolean;
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
    iepstartdate!: string;
    absentdate!: string;
    isreceived!: boolean;
    isverified!: boolean;
    isexcuesed!: boolean;
    schoolTypeDescription!: string;
    city!: string;
    contactInfo!: ContactInfoSchool;
    schoolSchedule!: string;
    schoolAdjustment!: string;
    schoolid?: string;

}

export class ContactInfoSchool {
    contactName!: string;
    workPhone!: string;
    workPhoneExt!: string;
    fax!: string;
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

export class EdcnPerformance {

    quater1!: string;
    quater2!: string;
    quater3!: string;
    quater4!: string;
}

export class EducationDetails {

    typeOfClass!: string;
    lastgradetypekey!: string;
    currentgradetypekey!: string;
    splEdcLeastRestEnv!: string;
    funGradeLevel!: string;
    dateLastAttended!: string;
    edcnPerformance!: EdcnPerformance;
    splEdcnNeeds!: string;
    schlExitReason!: string;
    schlExitDate!: string;
    strengths!: string;
    weakness!: string;
    edcnProgram!: string;
    homeHospEdcnServices!: string;
    edcnPrgmGoal!: string;
    extCurricularAct!: string;
    comments!: string;
    disabledQuestion!: boolean;
    diabilityNotes!: string;
    schlChngdPlcmnt!: boolean;
    reasonToChangeSchl!: string;




}

export class Education {
    school?: School[];
    vocation?: Vocation[];
    testing?: Testing[];
    accomplishment?: Accomplishment[];
    educationDetails?: EducationDetails[];
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
    intakassessment?: GetintakAssessment[];
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
    submissiondata: any;
    servicerequestnumber: any;
    intakenumber: any;
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
    ismalpa_suspeciousdeath!: string;
    ismalpa_nonaccident!: string;
    ismalpa_injuryinconsistent!: string;
    ismalpa_insjury!: string;
    ismalpa_childtoxic!: string;
    ismalpa_caregiver!: string;
    ismalsa_sexualmolestation!: string;
    ismalsa_sexualact!: string;
    ismalsa_sexualexploitation!: string;
    ismalsa_physicalindicators!: string;
    isneggn_suspiciousdeath!: string;
    isneggn_signsordiagnosis!: string;
    isneggn_inadequatefood!: string;
    isneggn_exposuretounsafe!: string;
    isneggn_inadequateclothing!: string;
    isneggn_inadequatesupervision!: string;
    isneggn_childdischarged!: string;
    isnegfp_cargiverintervene!: string;
    isnegab_abandoned!: string;
    isneguc_leftunsupervised!: string;
    isneguc_leftaloneinappropriatecare!: string;
    isneguc_leftalonewithoutsupport!: string;
    isnegrh_priordeath!: string;
    isnegrh_exposednewborn!: string;
    isnegrh_domesticviolence!: string;
    isnegrh_sexualperpetrator!: string;
    isnegrh_basicneedsunmet!: string;
    isnegrh_treatmenthealthrisk!: string;
    isnegmn_unreasonabledelay!: string;
    ismenab_psycologicalability!: string;
    ismenng_psycologicalability!: string;
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
    isnoimmed_screeninoverride!: string;
    isImmediateYes!: string;
    isImmediateNo!: string;
    [key: string]: any;
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
    histories?: any[];
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
    currentdiagnoses!: string;
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
    isselfneglect!: boolean;
    selfneglectnotes!: string;
    isfinancialexploitation!: boolean;
    financialexploitationnotes!: string;
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
    tobaccofrequencydetails!: string;
    tobaccoageatfirstuse!: string;
}

export class Work {
    employer?: Employer[];
    careergoals?: string;
    employactivity?: EmployActivity[];
}

export class EmployActivity {
    program_name!: string;
    start_date!: string;
    narrative!: string;
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

export class LegalActionHistory {
    petitionID!: string;
    complaintID!: string;
    hearingType!: string;
    worker!: string;
    hearingDate!: string;
    courtActions!: string[];
    courtOrder!: string[];
    courtDate!: string;
    terminationDate!: string;
    adjudicationDate!: string;
    adjudicationDecision!: string;
    adjudicatedOffense!: string;
}
export class MedicalConditionType {
    medicalconditiontypekey!: string;
}

export class SdmData {
    servicerequestid!: string;
    intakenumber!: string | null;
    sdmdata!: Sdm;
}
export class ContactPerson {
    activeflag!: number;
    dangerlevel!: number;
    dangerreason?: string;
    deceaseddate?: string;
    dob!: string;
    effectivedate!: string;
    ethnicgrouptypekey?: string;
    expirationdate?: string;
    firstname!: string;
    firstnamesoundex?: string;
    gendertypekey!: string;
    incometypekey?: string;
    interpreterrequired?: string;
    lastname!: string;
    lastnamesoundex?: string;
    maritalstatustypekey?: string;
    middlename?: string;
    nameSuffix?: string;
    assistpid?: string;
    personid!: string;
    primarylanguageid!: string;
    principalident?: string;
    racetypekey?: string;
    religiontypekey?: string;
    salutation?: string;
    secondarylanguageid?: string;
    ssnverified?: string;
    timestamp?: string;
    userphoto?: string;
    refusessn!: boolean;
    refusedob!: boolean;
    dangertoself!: number;
    dangertoselfreason?: string;
    personphysicalattributetypeid?: string;
    maidenname?: string;
    tribalassociation?: string;
    socialmediasource?: string;
    dateofdeath?: string;
    isapproxdod?: string;
    suffix?: string;
    prefix?: string;
    occupation?: string;
    stateid?: string;
    fein?: string;
    complaintnumber?: string;
    cjisnumber?: string;
    petitionid?: string;
    strengths?: string;
    needs?: string;
    cjamspid!: string;
    nationalitytypekey?: string;
    livingsituationkey?: string;
    licensedfacilitykey?: string;
    otherlicensedfacility?: string;
    livingsituationdesc?: string;
    otherprimarylanguagetypekey?: string;
    personidentifier: Personidentifier[] = [];
    personaddress: Personaddress[] = [];
    personphonenumber: Personphonenumber[] = [];
    personemail: Personemail[] = [];
    personphysicalattribute!: any[];
    gendertype!: Gendertype;
    alias!: any[];
    personnickname!: any[];
    personrelation!: any[];
}
export class Personemail {
    personemailid!: string;
    personid!: string;
    activeflag!: number;
    personemailtypekey!: string;
    email!: string;
    effectivedate!: string;
    expirationdate?: string;
    oldId?: string;
    timestamp?: string;
    Personemailtype!: Personemailtype;
}
export class Personemailtype {
    personemailtypekey!: string;
    typedescription!: string;
}
export class Gendertype {
    gendertypekey!: string;
    typedescription!: string;
}

export class Personphonenumber {
    personphonenumberid!: string;
    personid!: string;
    activeflag!: number;
    personphonetypekey!: string;
    phonenumber!: string;
    phoneextension?: string;
    reversephonenumber?: string;
    ismobile!: boolean;
    effectivedate!: string;
    expirationdate?: string;
    oldId?: string;
    timestamp?: string;
    personphonetype!: Personphonetype;
}

export class Personphonetype {
    personphonetypekey!: string;
    typedescription!: string;
}

export class Personaddress {
    personaddressid!: string;
    personid!: string;
    activeflag!: number;
    personaddresstypekey!: string;
    address!: string;
    zipcode!: string;
    city!: string;
    state!: string;
    country!: string;
    county!: string;
    effectivedate!: string;
    expirationdate?: string;
    oldId?: string;
    address2?: string;
    directions?: string;
    danger?: string;
    dangerreason?: string;
    Personaddresstype!: Personaddresstype;
}

export class Personaddresstype {
    personaddresstypekey!: string;
    typedescription!: string;
}

export class Personidentifier {
    personidentifierid!: string;
    personid!: string;
    personidentifiertypekey!: string;
    personidentifiervalue!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate?: string;
    oldId?: string;
    timestamp?: string;
    personidentifiertype!: Personidentifiertype;
}

export class Personidentifiertype {
    personidentifiertypekey!: string;
    typedescription!: string;
}

export class AttachmentSubCategory {
    assessmenttemplateid!: string;
    isrequired!: boolean;
    titleheadertext!: string;
}
export class GuardianshipSearch {
    personsearch!: boolean;
    storeid!: string;
}
export class PersonPayee {
    personid!: string;
    personrepresentativeworkerid!: string;
    personrepresentativepersonid!: string;
    entityid!: string;
    persontypekey!: string;
    representativetypekey!: string;
    startdate!: string;
    enddate!: string;
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

export class ReasonForContact {
    progressnotereasontypeid!: string;
    progressnotereasontypekey!: string;
    activeflag!: number;
    typedescription!: string;
    effectivedate!: Date;
    old_id!: string;
}

export class RecordingNotes {
    recordingtype?: string;
    progressnotetypeid!: string;
    progressnotesubtypeid!: string;
    contactdate!: string;
    contactname?: string;
    contactpurposeList?: any;
    progressnotereasontypekey!: string;
    totaltime?: string;
    contactparticipant!: ContactParticipant[];
    contacttrialvisit!: ContactTrialVisit;
    contactphone?: string;
    contactemail?: string;
    description!: string;
    recordingsubtype!: string;
    starttime!: string;
    endtime!: string;
    entitytypeid!: string;
    progressnotereasontypedescription!: string;
    entitytype!: string;
    savemode!: number;
    stafftype!: number;
    attemptind!: boolean;
    instantresults!: number;
    contactstatus!: boolean;
    drugscreen!: boolean;
    progressnotepurposetypekey?: string;
    progressnoteroletype?: string;
    documentpropertiesid!: string;
    draft?: string;
    progressnoteid?: string;
    s3bucketpathname!: string;
    filename!: string;
    traveltime!: string;
    progressnoterole?: any;
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
export class CaseWorkerContactRoles {
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
export class CaseWorkerRecording {
    progressnoteid!: string;
    progressnotereasontypekey!: string;
    author!: string;
    recordingtype!: string;
    recordingsubtype!: string;
    title!: string;
    team!: string;
    draft!: boolean;
    attemptindicator!: boolean;
    contactdate!: Date;
    contactname!: string;
    contactrole!: string;
    contactphone!: number;
    contactemail!: string;
    archivedon!: string;
    archivedby!: string;
    detail!: string;
    recordingdate!: Date;
    insertedby!: string;
    progressnotedetail!: ProgressNoteDetail;
    progressnoteroletype!: ProgressNoteRoleType[];
    progressnoteactor: any;
    starttime!: Date;
    endtime!: Date;
    progressnoteroletypeview!: string[];
    subtype?: CaseWorkerRecordingType;
    progressnotesubtypeid!: string;
}
export class CaseWorkerRecordingEdit {
    title!: string;
    insertedby!: string;
}
export class CaseWorkerRecordingType {
    progressnotetypeid!: string;
    progressnotetypekey!: string;
    description!: string;
}
export class SearchRecording {
    draft!: string;
    type!: string;
    datefrom!: string;
    dateto!: string;
    contactdatefrom!: string;
    contactdateto!: string;
}

export class ProgressNoteDetail {
    progressnotedetailid!: string;
    progressnoteid!: string;
    description!: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    insertedby!: string;
    insertedon!: Date;
    userprofile!: UserProfile;
}
export class UserProfile {
    securityusersid!: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
    fullname!: string;
}

export class ResourceConsult {
    intakeservicerequestconsultreviewid?: string;
    resourceconsultuser!: ResourceConsultUser[];
    date!: Date;
    notes!: string;
    intakeserviceid!: string;
    time!: string;
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
}
export class ResourceConsultUser {
    intakeservicerequestconsultreviewconfigid!: string;
    name!: string;
    consultreviewusertypekey!: string;
    consultreviewusertype!: string;
}
export class DSDSActionSummary {
    da_number!: string;
    da_legalGuardian!: string;
    da_loadnumber!: string;
    da_type!: string;
    da_typeid!: string;
    da_subtypeid!: string;
    da_subtype!: string;
    da_receiveddate!: Date;
    da_focus!: string;
    da_role!: string;
    da_identifier!: string;
    da_region!: string;
    da_county!: string;
    da_zip!: string;
    da_status!: string;
    da_disposition!: string;
    da_assignedto!: string;
    da_completedby!: string;
    da_duedate!: Date;
    da_daystogo!: string;
    da_investigationid!: string;
    da_groupnumber!: string;
    teamtypekey!: string;
    persondob!: string;
    persondod!: string;
    da_reportername!: string;
    intake_jsondata: any;
    da_responsibilitytypekey!: string;
    personid!: string;
    isenablekinship?: any;
    foldertypedescription!: string;
    foldertypekey!: string;
    da_insertedon!: Date;
    cjamspid?: string;
    intakenumber!: string;
    countyid?: string;
    da_communicationid?: string;
}
export class Fim {
    intakeserviceid!: string;
    meetingdate!: Date;
    meetingtypekey!: string;
    persontype!: string;
    personname!: string;
    meetingdescription!: string;
    meetingcomments!: string;
    isfollowupmeeting!: number;
    followmeetingdate!: Date;
    parentmeetingid?: any;
    iscompleted!: number;
    meetingrecordingactor!: MeetingRecordingActor[];
    followmeetingrecordingactor!: MeetingRecordingActor[];
    meetingparticipants!: MeetingParticipant[];
    fimtype!: FimType[];
}

export interface FamilyList {
    intakeserviceid: string;
    meetingdate: string;
    meetingtypekey: string;
    persontype: string;
    personname: string;
    meetingdescription: string;
    meetingcomments: string;
    isfollowupmeeting: number;
    parentmeetingid?: any;
    iscompleted: number;
    recordingactor: Recordingactor[];
    participants: Participant[];
    fimdetails: Fimdetail[];
}
export interface Fimdetail {
    familymeetingtypekey: string;
    familymeetingsubtypekey: string;
}
export interface Recordingactor {
    meetingrecordingid: string;
    personid: string;
    actortype: string;
    firstname: string;
    lastname: string;
    typedescription: string;
}
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
export interface Participant {
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
}
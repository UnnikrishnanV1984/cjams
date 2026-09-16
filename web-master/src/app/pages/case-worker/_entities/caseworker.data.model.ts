import { initializeObject } from '../../../@core/common/initializer';

export class DSDSActionDetails {
    casenumber!: string;
    objectid?: string;
    intakeserviceid!: string;
    servicerequestnumber!: string;
    srtype!: string;
    srsubtype!: string;
    raname!: string;
    county!: string;
    datereceived!: Date;
    duedate!: Date;
    groupnumber!: string;
    assignedto!: string;
    investigationid!: string;
    srstatus!: string;
    focus!: string;
    displayname!: string;
    assignedon?: Date;
    focusperson?: string;
    objecttypekey?: string;
    caseid?: string;
    servicecasenumber!: string;
    adoptioncaseid?: string;
    adoptioncasenumber!: string;
    adoptionplanningid?: string;
    startdate?: string;
    open_closed?: string;
    statustypekey?: string;
    restrictstatus?: string; 
    programareabyservicecase: any;
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
    programarea!: ServiceCaseProgramArea[];
    responsibleworkers!: ServiceCaseResponsbility[];
    teamid?: string;
    da_firstname?: string;
    da_lastname?: string;
    da_suffix?: string;
    caseconnectsent?: number;
    intakeserviceid?: string;
    open_closed?: string;
    da_assignedby?: string;
    servicecasenumber?: string;
    raceList?: string;
    maritalstatus?: string;
    hascisdata?: boolean;
    case_closedate: any;
    da_responsetime!: Date;
    neicecaseid!: string; 
    adoptionproviderid? : number;
    onlyadoptivehomeprovider? : boolean;
}

export class ServiceCaseResponsbility {
    responsibilitytypekey!: string;
    enddate!: string;
    firstname!: string;
    lastname!: string;
    email!: string;
    phonenumber!: string;
    supervisorname?: string;
}

export class ServiceCaseProgramArea {
    programkey!: string;
    subprogramkey!: string;
    subprogramname!: string;
    programname!: string;
}
export class CaseWorkReportSummary {
    intakeserviceid!: string;
    servicerequestincidenttypekey!: string;
    suspiciousdeath!: boolean;
    missingpersons!: boolean;
    activeflag = 1;
    effectivedate!: Date;
    intakeservicerequestillegalactivity?: Illegalactivity[];
}
export class ReportSummary {
    isanonymousreporter?:any;
    intakeserviceid!: string;
    servicerequestnumber!: string;
    servicerequestincidenttypekey!: string;
    narrative!: string;
    description!: string;
    reporteddate!: Date;
    reportedtime!: Date;
    reporterincidentdate!: Date;
    intakeservreqinputtypeid!: string;
    intakeservreqtypeid!: string;
    intakeservicerequestclassid!: string;
    suspiciousdeath!: boolean;
    missingpersons!: boolean;
    monumber!: string;
    intakeservices: any;
    intakeservicerequesttype!: RequestType;
    servicerequestsubtype!: SubType;
    servicerequestincidenttype!: IncidentType;
    intakeservicerequestinputtype!: InputType;
    userprofile!: UserProfile;
    intakeservicerequestillegalactivity?: Illegalactivity[];
    intakeservicerequestactor!: MainActor[];
    intakeservicerequestevaluation?: any;
    reporterfirstname!: string;
    reporterlastname!: string;
    requesterphone!: string;
    isunknownreporter!: boolean;
    insertedon?: string;
    supervisorname?:string;
    offenselocation: any;
    reporterzipcode: any;
    reporterstate: any;
    reportercity: any;
    reporteraddress2: any;
    reporteraddress1: any;
    reporterroletypekey: any;
    reporterorganization: any;
    reportertitle: any;
    reporterphonenumberext: any;
    reporterphonenumber: any;
    intakenumber: any;
    assessments: any;
    reporterRoleName: any;
}

export class Transportation {
    totalcount!: string;
    persontransportationid!: string;
    insertedon!: string;
    notes!: string;
    pickuptime!: string;
    dropofftime!: string;
    pickuplocation!: string;
    dropofflocation!: string;
    appointmentdate!: string;
    workerid!: string;
    county!: string;
    status!: string;
    dateoftransport!: string;
    chargereason!: string;
    courttime!: string;
    courtlocation!: string;
    dob!: string;
    youthname!: string;
    droptime!: string;
    locationfromtypekey!: string;
    locationtotypekey!: string;
    locationtotype!: string;
    intakeserviceid!: string;
    otherlocationto!: string;
    otherlocationfrom!: string;
    day!: string;
    servicerequestnumber!: string;
}

export class TransportationAddEdit {
    intakeserviceid!: string;
    dateoftransport!: string;
    dateoftransportdrop!: Date;
    pickuptimeonly!: string;
    droptimeonly!: string;
    pickuptime!: string;
    droptime!: string;
    youthname!: string;
    courttime!: string;
    courttimeonly!: string;
    dob!: string;
    courtlocation!: string;
    locationfromtypekey!: string;
    lotherlocationto!: string;
    chargereason!: string;
    notes!: string;
    locationtotypekey!: string;
    otherlocationfrom!: string;
    personid!: string;
}

export class RequestType {
    intakeservreqtypeid!: string;
    description!: string;
}
export class SubType {
    servicerequestsubtypeid!: string;
    classkey!: string;
    description!: string;
}
export class IncidentType {
    servicerequestincidenttypekey!: string;
    typedescription!: string;
}
export class InputType {
    intakeservreqinputtypeid!: string;
    intakeservreqinputtypekey!: string;
    description!: string;
}
export class UserProfile {
    securityusersid!: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
    fullname!: string;
}
export class Illegalactivity {
    intakeservicerequestillegalactivityid?: string | null;
    intakeservicerequestillegalactivitytypekey?: string;
    intakeservicerequestid?: string;
    activeflag!: 1;
    expirationdate?: Date;
    effectivedate?: Date;
    insertedby?: string;
    updatedby?: string;
    iscreated?: boolean;
    isdeleted?: boolean;
    constructor(initializer?: Illegalactivity) {
        initializeObject(this, initializer);
    }
}
export class MainActor {
    intakeservicerequestactorid!: string;
    actorid!: string;
    intakeservicerequestpersontypekey!: string;
    rapersontypekey!: string;
    intakeserviceid!: string;
    isheadofhousehold!: boolean;
    actor!: Actor;
}

export class ActivityPlan {
    isSelected!: boolean;
    ammappingid!: string;
    amactivityid!: string;
    rulesetid!: string;
    rulesetsourceid!: string;
    name!: string;
    description!: string;
    activitytypekey!: string;
    helptext!: string;
    effectivedate!: Date;
    expirationdate!: Date;
}

export class DeleteActivityTask {
    isSelected!: boolean;
    objectid!: string;
    activityid!: string;
    description!: string;
    activitytaskid!: string;
}

export class GetSuggestedTask {
    isSelected!: boolean;
    ammappingid!: string;
    intakeserviceid!: string;
    activityid!: string;
    name!: string;
    description!: string;
    helptext!: string;
    amtaskid!: string;
    assignedto!: number;
    activitytaskstatustypekey!: string;
    activitytasktypekey!: string;
    activityprioritytypekey!: string;
    required!: number;
    activeflag!: number;
    activitytypekey!: string;
    amactivityid!: string;
}

export class GetSuggestedGoal {
    activityid!: string;
    name!: string;
    description!: string;
    amgoalid!: string;
    activitygoalstatustypekey!: string;
    activitygoaltypekey!: string;
    activityprioritytypekey!: string;
    required!: number;
    activeflag!: number;
    activitytypekey!: string;
    amactivityid!: string;
}

export class Actor {
    actorid!: string;
    activeflag!: 1;
    personid!: string;
    actortype!: string;
    Person!: Person;
}

export class Person {
    activeflag!: 1;
    dangerlevel!: 1;
    dangerreason!: string;
    firstname!: string;
    lastname!: string;
    middlename!: string;
    suffix!: string;
    personid!: string;
    personaddress!: PersonAddress[];
}

export class PersonAddress {
    personaddressid!: string;
    personid!: string;
    activeflag!: 1;
    personaddresstypekey!: string;
    address!: string;
    zipcode!: string;
    city!: string;
    state!: string;
    country!: string;
    county!: string;
    address2!: string;
    danger!: boolean;
    dangerreason!: string;
}

export class Assessments {
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
    duedays?: string;
    intakassessment?: any[];
    isvisible!: boolean;
    targetroletypekey: any;
}

export class AssessmentSummary {
    totalcount!: number;
    opencount!: number;
    inprogresscount!: number;
    completedcount!: number;
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
    progressnotedetail!: ProgressNoteDetail[];
    progressnoteroletype!: ProgressNoteRoleType[];
    progressnoteactor: any;
    starttime!: Date;
    endtime!: Date;
    progressnoteroletypeview!: string[];
    subtype?: CaseWorkerRecordingType;
    progressnotesubtypeid!: string;
    uploadedfile:any;
    focusperson: any
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
    isaddendum!: number;
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
export class CaseWorkerRecordingType {
    progressnotetypeid!: string;
    progressnotetypekey!: string;
    description!: string;
    progressnotesubtypeid!: string;
}
export class AddRecording {
    progressnotetypeid!: string;
    progressnotesubtypeid!: string;
    // title: string;
    // title: string;
    entitytype!: 'intakeservicerequest';
    entitytypeid!: string;
    // pageurl: string;
    // pageurl: string;
    savemode!: number;
    contactdate!: string;
    contactname!: string;
    progressnotetypekey!: string;
    contactroletypekey!: string;
    contactphone!: number;
    contactemail!: string;
    attemptindicator!: boolean;
    insertedby!: string;
    appendnote!: string;
    appendtitle!: string;
    description!: string;
    documentpropertiesid!: string;
    // progressnoteroletype: ProgressNoteRoleType[];
    // progressnoteroletype: ProgressNoteRoleType[];
    starttime!: Date;
    endtime!: Date;
    progressnotereasontypekey!: string;
    traveltime!: Date;
    totaltime!: Date;
    progressnoteactor!: ProgressNoteActor[];
}

export class ProgressNoteActor {
    intakeservicerequestactorid!: string;
    personname!: string;
}
export class ProgressNoteRoleType {
    contactroletypekey!: string;
}

export class CaseWorkerRecordingEdit {
    title!: string;
    insertedby!: string;
}
export class SearchRecording {
    draft!: string;
    type!: string;
    datefrom!: string;
    dateto!: string;
    contactdatefrom!: string;
    contactdateto!: string;
    note!: string;
    progressnotereasontypekey!: string;
    intakeservicerequestactorids!: string[];
    isExpungementSuperUser!: number;
    iscaseexpunged!: number;
}

export class CaseWorkerHistory {
    totalcount!: number;
    displaydate!: Date;
    dispstatus!: string;
    disposition!: string;
    userrole!: string;
    loadnumber!: string;
    username!: string;
    reviewcomments!: string;
    servicecasedispositionid!: string;
    routingstatus: any;
    approvedon: any;
    approvedby: any;
    supervisorcomment: any;
    reopenreasonkey: any;
    insertedon: any;
}
export class HistoryType {
    historyType!: string;
}
export class HistoryPSScore {
    date!: Date;
    action!: string;
    dateseen!: string;
    score!: string;
    user!: string;
    Title!: string;
    position!: string;
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
    mode?: string;
    ismigration!: number;
    submissiondata?: any;
    updatedusername: any;
    migratedsubmissiondata: any;
    servicerequestnumber: any;
}
export class HistroyDAgroup {
    groupdetlid!: string;
    actiondate!: Date;
    action!: string;
    groupnumber!: string;
    typedescription!: string;
    servicerequestnumber!: string;
    displayname!: string;
    roletypekey!: string;
    positioncode!: string;
}

export class AttachmentUpload {
    index?: number;
    filename!: string;
    mime!: string;
    documentpropertiesid!: string;
    documenttypekey!: string;
    ecmsdocumentid!: string;
    numberofbytes!: number;
    s3bucketpathname!: string;
    originalfilename: any;
    activeflag: any;
}

export class TimeLineView {
    intakeserviceid!: string;
    servicerequestnumber!: string;
    insertedon!: Date;
    datype!: string;
    dasubtype!: string;
    referredto!: string;
    assignedto!: string;
    createdby!: string;
    trantype!: string;
    assignedby: any;
    status: any;
}
export class SaftyPlanAction {
    actiondescription!: string;
}

export class SaftyPlanDangerInfluence {
    dangerinfluencenumber!: string;
    dangerinfluencedesc!: string;
    completiondate!: string;
    partiesname!: string;
    reevaluationdate!: string;
    action!: SaftyPlanAction[];
    constructor(initializer?: SaftyPlanDangerInfluence) {
        initializeObject(this, initializer);
    }
}

export class SaftyPlan {
    safetyplanid!: string;
    savemode!: number;
    intakeserviceid!: string;
    external_templateid!: string;
    plandate!: string;
    submissionid: string | undefined;
    dangerinfluence!: SaftyPlanDangerInfluence[];
}

export class SafetyPlanView {
    caseHeadName!: string;
    caseHeadId!: string;
    childName!: string;
    daNumber!: string;
    planDate!: string;
}

export class SaftyPlanBlob {
    externaltemplateid!: string;
    assessmenttemplatename!: string;
    submissionid?: string;
    submissiondata: any;
    ischildsafe?: boolean;
    assessmentstatustypekey?: string;
    constructor(initializer?: SaftyPlanBlob) {
        initializeObject(this, initializer);
    }
}

// sdm caseworker

export class UserProfileImage {
    filename!: string;
    originalfilename!: string;
    mime!: string;
    numberofbytes!: number;
    s3bucketpathname!: string;
}
export class InvolvedPerson {
    actorid?: string;
    cjamspid!: string;
    index!: number;
    id!: string;
    Pid!: string;
    personid!: string;
    Role!: string;
    rolekeyDesc!: string;
    userPhoto!: string;
    firstname!: string;
    lastname!: string;
    Middlename!: string;
    dob?: Date;
    Gender!: string;
    Race?: string[];
    PrimaryPhoneNumberext!: string;
    TemparoryPhoneNumber!: string;
    TemparoryPhoneNumberext!: string;
    AddressId?: string;
    Address!: string;
    Address2!: string;
    City!: string;
    State!: string;
    Zip!: string;
    intakeservicerequestactorid!: string;
    County!: string;
    ssn!: string;
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
    fullname!: string;
    fullAddress!: string;
    contactsmail?: any[];
    contacts?: any[];
    email!: string;
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
    relationship!: string | undefined | null;
    rolename?: string;
    phonenumber?: number;
    state!: string;
    address2!: string;
    city!: string;
    county!: string;
    zipcode!: string;
    dateofdeath?: Date;
    gender?: string;
    relationshipdescription?: string;
    roles!: any[];
    clientname?: any;
    clientid?: any;
    programarea?: ServiceCaseProgramArea[];
}
export class PersonRole {
    rolekey!: string;
    description!: string;
    relationshiptorakey!: string;
    isprimary!: string;
    hidden!: boolean;
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
    personroleid!: string;
    personroletype!: string;
    personrolesubtype!: string;
    firstname!: string;
    middlename!: string;
    lastname!: string;
    dob!: Date;
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
    daDetails!: DaDetails[];
    daTypeName!: string;
    highLight = false;
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

export class ResourcePermission {
    id?: string;
    parentid?: string;
    name!: string;
    resourceid?: string;
    resourcetype?: number;
    isSelected?: boolean;
    tooltip?: string;
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

export class GeneralNarative {
    formkey!: string;
    controlindex!: number;
    helptext!: string;
}
export class IntakePurpose {
    description!: string;
    intakeservreqtypeid!: string;
    teamtype!: { sequencenumber: number; teamtypekey: string; };
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
    maltreatment!: string;
    childfatality!: string;
    fatalitycomments!: string;
    ischildfatality!: boolean;
    isfcplacementsetting!: boolean;
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
    duplicatereportflag?: any;
    confirmtrafficking!: string;
    selecttrafficking!: string;
    isseriousphysicalinjury!: boolean;
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
    isnoimmed_substantial_risk!: boolean;
    isnoimmed_screeninoverride!: boolean;
    isnoimmed_physicalabuse!: boolean;
    isnoimmed_sexualabuse!: boolean;
    isnoimmed_neglectresponse!: boolean;
    isnoimmed_mentalinjury!: boolean;
    isnoimmed_risk_harm!: boolean;
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
export interface RoutingInfo {
    fromusername: string;
    tousername: string;
    fromrole: string;
    torole: string;
    routingstatustypekey: string;
    routedon: Date;
    purpose: string;
    phonenumber: string;
    address: string;
    intakeservreqservicekey: string;
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

export class Documentproperty {
    documentpropertiesid!: string;
}

export class CompleteAssessment {
    assessmenttemplateid!: string;
    assessmentid!: string;
    objectid!: string;
}

export class CaseCloser {
    caseclosuresummaryid!: string;
    intakeserviceid!: string;
    reason!: string;
    referralreason!: string;
    riskissues!: string;
    recommendation!: string;
    interventionissues!: string;
    servicetypekey!: string;
    notes!: string;
    participants!: Participant[];
}
export class Participant {
    intakeservicerequestactorid!: string;
    ischild!: number;
}
export class ClosureType {
    closuretypekey!: string;
    typedescription!: string;
}
export class CaseCloserValidate {
    task!: Task[];
    assessment!: CaseAssessment[];
}
export class CaseAssessment {
    name!: string;
    status!: string;
}
export class Task {
    name!: string;
    status!: string;
}

export class AssessmentBlob extends SaftyPlanBlob {}

export class AgencyCategories {
    agencycategoryid!: string;
    description!: string;
}

export class AgencyServices {
    agencyserviceid!: string;
    description!: string;
}

export class ClientProgramNames {
    clientprogramnameid!: string;
    description!: string;
}

export class ChoosenAllegation {
    allegationID!: string;
    allegationValue!: string;
    indicators: any[] = [];
}

export class Indicator {
    indicatorid!: string;
}

export class MaltreatmentAllegations {
    investigationallegationid?: any;
    allegationid!: string;
    maltreatoractorid!: string[];
    maltreatorname?: any;
    allegationname!: string;
    maltreatmentid?: any;
    personid!: string;
    intakeservicerequestactorid!: string;
    investigationid!: string;
    outcome!: string;
    investigationalegationstatuskey!: string;
    indicator!: Indicator[];
    isjurisdiction!: string;
    isapproximatedate!: string;
    sextrafficking!: string;
    relationshiptypekey!: string;
}

export class SaveActionLetter {
    effectivedate!: Date;
    program!: Citation[];
    actiontypekey!: string;
    comarvalues!: string[];
    immediateaction!: boolean;
    notice!: boolean;
    workername!: string;
    countyid!: string;
    intakeserviceid!: string;
}

export class Citation {
    programtypekey!: string;
    oasactionletterid!: string;
    actiontypekey!: string;
}

export class ActionLetter {
    headerdescription!: string;
    programconfigid!: string;
    programdescription!: string;
}

export class ListActionLetter {
    oasactionletterid!: string;
    intakeserviceid!: string;
    countyid!: string;
    comarvalues!: string[];
    immediateaction!: boolean;
    notice!: boolean;
    workername!: string;
    activeflag!: boolean;
    effectivedate!: Date;
    oasactionletterprogramactionconfig!: Citation[];
}

export class ListAST {
    intakeservreqadultscreentoolid!: string;
    intakeserviceid!: string;
    astdate!: Date;
    intakeworker!: string;
    countyid!: string;
    referralname!: string;
    referralphone!: string;
    referraladdress1!: string;
    referraladdress2!: string;
    referralremainanonymous!: boolean;
    referralrelationship!: string;
    clientinfoname!: string;
    clientinfodob!: Date;
    clientinfoage!: number;
    gendertypekey!: string;
    racetypekey!: string;
    ethnicitytypekey!: string;
    clientinfoaddress1!: string;
    clientinfoaddress2!: string;
    clientinfophone!: number;
    maritalstatuskey!: string;
    monthlyincome!: string;
    monthlyincomesource!: string;
    totalassets!: string;
    totalassetssource!: string;
    additionalinfo!: string;
    riskaggrpets!: string;
    riskhomehazards!: string;
    riskfireharms!: string;
    riskpsychiatric!: string;
    riskcdsabuse!: string;
    riskmedical!: string;
    riskdomviolence!: string;
    riskother!: string;
    riskcomments!: string;
    detailsofreferralcomments!: string;
    healthcarekey!: string;
    transportationkey!: string;
    cluttertypekey!: string;
    foodtypekey!: string;
    housingtypekey!: string;
    supervisiontypekey!: string;
    individualvulnerable!: string;
    eatingfeedingkey!: string;
    takingmedicationkey!: string;
    walkingkey!: string;
    bathingkey!: string;
    dressingkey!: string;
    toiletkey!: string;
    physicalrisksnotes!: string;
    dementiakey!: string;
    thoughtdisorderskey!: string;
    substanceabusekey!: string;
    mooddisorderskey!: string;
    behavioralissueskey!: string;
    mentalchallengesnotes!: string;
    supportnetworkkey!: string;
    supportnetworknotes!: string;
    riskscore!: string;
    risklevel!: string;
    intakerecommendation!: string;
    householdconfig!: [
        {
            intakeservreqadultscreentoolhouseholdconfigid: string;
            intakeservreqadultscreentoolid: any;
            name: string;
            relationship: string;
            phoneno: number;
        }
    ];
}

export class ActionLetterCitations {
    headerdescription!: string;
    programconfigid!: string;
    programdescription!: string;
}
export class ReferralSupervisourList {
    securityusersid!: string;
    firstname!: string;
    lastname!: string;
    fullname!: string;
    countyname!: string;
    email!: string;
}



export class ProgressReviewList {
    caseevaluationid!: string;
    caseid!: string;
    evaluationdate!: Date;
    nextrecondate!: Date;
    timeframetypekey!: string;
    presentprogramtypekey!: string;
    presentprogramopendate!: Date;
    presentprogramcloseddate!: Date;
    exttilldate!: Date;
    riskassessmentid!: number;
    safetyassessmentid!: string;
    newreferraltext!: string;
    familyperception!: string;
    familyserviceneeds!: string;
    positiveresponsetypekey!: string;
    treatmentissues!: string;
    courtinvolvement!: string;
    ofhplacement!: string;
    totalfund!: number;
    fianotificationtypekey!: string;
    fianotification!: string;
    workerdiscusstypekey!: string;
    workerdiscuss!: string;
    familystrength!: string;
    requestextn!: string;
    extntime!: string;
    approvalstatustypekey!: string;
    extnapprovalstatustypekey!: string;
    extnrequired!: number;
    servicesprovided!: string;
    serviceoutcome!: string;
    serviceplanprogress!: string;
    serviceplanobjectives!: string;
    serviceplandisagreement!: string;
    serviceemployed!: string;
    familyclosingreason!: string;
    providedclosingplantypekey!: string;
    providedclosingplan!: string;
    closinglettercopytypekey!: string;
    closinglettercopy!: string;
    futureservicetypekey!: string;
    futureservice!: string;
    serviceneededflag!: number;
    casetransferflag!: number;
    transfertotypekey!: string;
    transferserviceintensitytypekey!: string;
    caseopenflag!: number;
    aodflag!: number;
    consentformcompleted!: number;
    referralformcompleted!: number;
    providerrefflag!: number;
    noserviceneededflag!: number;
    objectivesachievedflag!: number;
    familyrefusedserviceflag!: number;
    supportservicecomments!: string;
    servivceagreementflag!: number;
    serviceintensitylevel!: string;
    insertedby!: string;
    insertedon!: Date;
    updatedby!: string;
    updatedon!: Date;
    activeflag!: number;
    fmlyclosingreasontypekey!: string;
    fmlyclosingreason!: string;
    concurtypekey!: string;
    concurrecommendation!: string;
    safedate!: Date;
    safetydecisiontypekey!: string;
    safetyplaninitiatedflag!: number;
    riskassessmentdate!: Date;
    overallriskrating!: string;
    summary!: string;
    serviceplanid!: string;
    old_id!: string;
    approvalagencyflag!: number;
    adminextnsinfsflag!: number;
    ssapolicyflag!: number;
    referalmadeagencyflag!: number;
}

export class ServicePlanService {
    title!: string;
    name!: string;
    effectivedate!: Date;
    enddate!: Date;
    targetenddate!: Date;
    serviceplanid!: string;
    serviceplanfocus!: ServicePlanFocus[];
    serviceplanvisitation: any;
    serviceplancandidacy!: JSON;
    serviceplansignatures: any;
    approvalstatustypekey!: string;
    isChecked!: boolean;
    splangoal!: any[];
    visitationplans!: any[];
    childrenHeader!: string;
    legalGuardian!: string;
    personsinvolved: any;
    serviceplanversions!: any[];
    updatedon!: string;
    insertedon!: string;
    serviceplanname: any;
    approvaldate: any;
}
export class ServicePlanFocus {
    focusname!: string;
    serviceplanfocusid!: string;
    splanobjectiveid!: string;
    name!: string;
    strength!: string[];
    needs!: string[];
    enddate!: Date;
    serviceplanaction!: ServicePlanAction[];
    approvalstatustypekey!: string;
    serviceplanstrength!: string[];
    serviceplanneed!: string[];

}

export class ServicePlanObjective {
    objectivename!: string;
    splanobjectiveid!: string;
    strengths!: string[];
    needs!: string[];
    enddate!: Date;
    serviceplanaction!: ServicePlanAction[];
    approvalstatustypekey!: string;

}


export class ServicePlanAction {
    status:any;
    serviceplanactionname!: string;
    serviceplanactionid!: string;
    name!: string;
    involved!: string[];
    serviceplanpersoninvolved!: any[];
    personresponsible!: string[];
    startdate!: Date;
    enddate!: Date;
    outcomes!: string[];
    serviceplanoutcome!: any[];
    approvalstatustypekey!: string;
}

export class ServicePlanOutcome {
    title!: string;
    name!: string;
}
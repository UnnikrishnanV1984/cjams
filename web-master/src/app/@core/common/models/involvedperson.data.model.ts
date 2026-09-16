import { initializeObject } from '../initializer';

export class InvolvedPerson {
    rolename!: string;
    dcn?: string;
    personid!: string;
    assistpid!: string;
    cjamspid!: string;
    firstname!: string;
    lastname!: string;
    gender!: string;
    dob?: string;
    address?: string;
    address2?: string;
    city!: string;
    state!: string;
    zipcode!: string;
    phonenumber?: string;
    dangerous!: string;
    actorid!: string;
    intakeservicerequestactorid!: string;
    priorscount!: string;
    reported!: boolean;
    refusessn!: boolean;
    refusedob!: boolean;
    userphoto?: string;
    email?: string;
    relationshiparray!: any;
    roles!: Role[];
    school!: PersonEducationInfo[];
    relationship?: string;
    stateid!: string;
    ishousehold!: number;
    addendum!: Addendum[];
    medicalinformation!: Medicalinformation[];
    medicationinformation!: Medicationinformation[];
    medicalcondition!: MedicalCondition[];
    behavioralhealth!: BehaviourHealth[];
    ethnicgrouptypekey!: string;
    secondaryphone!: string;
    currentaddress!: string;
    genderText?: string;
    county!: any;
    isSelected!: boolean;
    sortorder!: string | null;
    sortcolumn!: string | null;
    cjisnumber!: any;
    ssn?: string;
    userroles: any;
    fullname: any;
    fullName: any;
    Pid!: string;
    searchtype!: string;
    es_pageNumber!: number;
    es_pageLength!: number;
    es_cjamsFlag!: boolean;
}

export class Addendum {
    alcoholfrequencydetails?: string;
    drugfrequencydetails?: string;
    isusealcohol?: boolean;
    isusedrug?: boolean;
    isusetobacco?: boolean;
}

export class BehaviourHealth {
    behavioraladdress1!: string;
    behavioraladdress2!: string;
    behavioralcity!: string;
    behavioralphone!: string;
    behavioralstate!: string;
    behavioralzip!: string;
    clinicianname!: string;
    currentdiagnoses!: string;
    isbehavioralhealth?: any;
}

export class MedicalCondition {
    description!: string;
    medicalconditiontypekey!: string;
}

export class Medicationinformation {
    dosage!: string;
    medicationname!: string;
    frequency!: string;
    compliant?: any;
    personid!: string;
}

export class Medicalinformation {
    ismedicaidmedicare!: boolean;
    isprimaryphycisian!: boolean;
    isbehavioralhealth!: boolean;
    insurancetype?: any;
    policyname!: string;
    name!: string;
    phone!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    zip!: string;
    currentdiagnoses!: string;
    clinicianname!: string;
    behavioralphone!: string;
    behavioraladdress1!: string;
    behavioraladdress2!: string;
    behavioralcity!: string;
    behavioralstate!: string;
    behavioralzip!: string;
    personid!: string;
}
export class Persons {
    index!: number;
    Dangerousworker!: string;
    testing!: any[];
    Role!: string;
    rolekeyDesc!: string;
    vocation!: any[];
    displayMultipleRole!: string[];
    contactsmail!: any[];
    emailID!: any[];
    mentallyimpaired!: string;
    Firstname!: string;
    contacts!: any[];
    Lastname!: string;
    phoneNumber!: any[];
    DobFormatted!: string;
    Dob!: string;
    Gender!: string;
    RelationshiptoRA!: string;
    address!: any[];
    fullName!: string;
    school!: any[];
    Dangerousself!: string;
    personAddressInput!: any[];
    accomplishment!: any[];
    Pid!: string;
    assistpid!: string;
    cjamspid!: string;
    personRole!: PersonRole[];
    mentalillsign!: string;
    userphoto!: string;
    physicianinfo?: Physician[];
    healthinsurance?: HealthInsuranceInformation[];
    personmedicationphyscotropic?: Medication[];
    personhealthexam?: HealthExamination[];
    personmedicalcondition?: MedicalConditions[];
    personbehavioralhealth?: BehaviouralHealthInfo[];
    personabusehistory?: HistoryofAbuse;
    personabusesubstance?: SubstanceAbuse;
    persondentalinfo?: PersonDentalInfo[];
}
export class PersonRole {
    hidden!: boolean;
    isprimary!: string;
    relationshiptorakey?: string;
    rolekey!: string;
    description!: string;
}

export class PersonSearch {
    personid!: string;
    personroleid!: string;
    personroletype!: string;
    personrolesubtype!: string;
    firstname!: string;
    middlename!: string;
    lastname!: string;
    dob!: Date;
    dangerlevel!: string;
    ssn!: string | undefined | null;
    dcn!: string;
    primaryaddress!: string;
    homephone!: string;
    gendertypekey!: string;
    loadnumber!: string;
    teamname!: string;
    addressJson!: Address;
}

export class Address {
    Id!: string;
    address1!: string;
    address2!: string;
    city!: string;
    zipcode!: string;
    county!: string;
    state!: string;
}

export class PersonSearchRequest {
    firstname!: string;
    lastname!: string;
    gender!: string;
    dob!: Date;
    dcn!: string;
    ssn!: string;
    personflag = 'T';
    activeflag = 1;
}

export class PriorList {
    daDetails!: DaDetails;
    daTypeName!: string;
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
    datecreated!: string;
}

export class DropdownList {
    text!: string;
    value!: string;
}

export class AddPerson {
    People!: People;
    Personrole: Personrole[] = [];
    Personaddresses: PersonAddress[] = [];
    Personphonenumber: PersonPhone[] = [];
    School: School[] = [];
    Vocation: Vocation[] = [];
    Testing: Testing[] = [];
    Accomplishment: Accomplishment[] = [];
    Personemail: PersonEmail[] = [];
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

export class Personrole {
    rolekey!: string;
    isprimary!: boolean;
    relationshipkey!: string;
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

export class Vocation {
    vocationinterest!: string;
    vocationaptitude!: string;
    isvocationaltest!: boolean;
    certificatename!: string;
    certificatepath!: string;
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
    school!: any;
}

export class PersonEmail {
    activeflag = 1;
    personemailtypekey!: string;
    email!: string;
    effectivedate!: string;
    insertedby!: string;
}
export class People {
    ramentalretarted!: string;
    ramentalhealth!: string;
    activeflag!: any;
    personid?: string;
    dangerlevel!: number;
    dangerreason!: string;
    dob!: string;
    dcn?: string;
    effectivedate!: string;
    ethnicgrouptypekey!: string;
    firstname!: string;
    firstnamesoundex!: string;
    gendertypekey!: string;
    incometypekey!: string;
    interpreterrequired!: string;
    lastname!: string;
    lastnamesoundex!: string;
    maritalstatustypekey!: string;
    middlename!: string;
    nameSuffix!: string;
    primarylanguageid!: string;
    racetypekey!: string;
    secondarylanguageid!: string;
    insertedby!: string;
    refusessn!: boolean;
    refusedob!: string;
    ssn!: string;
    alias!: string;
    role!: string;
    relationshiptorA!: string;
    intakeserviceid!: string;
    actorid!: string;
  chessieid!: any;
}
export class Role {
    intakeservicerequestpersontypekey!: string;
    typedescription!: string;
    intakeservicerequestactorid?: string;
}
export class ActorTypeDesc {
    actortype!: string;
    typedescription!: string;
}
export class PersonAddress {
    index?: number;
    personaddressid?: string;
    typedescription?: string;
    statetext?: string;
    countytext?: string;
    countrytext?: string;
    activeflag = 1;
    personaddresstypekey!: string;
    address!: string;
    zipcode!: string;
    city!: string;
    state!: string;
    country!: string;
    county!: string;
    effectivedate!: string;
    address2!: string;
    directions!: string;
    danger!: string;
    dangerreason!: string;
    updatedby?: string;
    insertedby?: string;
    Personaddresstype!: TypeDescription;
    routingAddressidflag?: string;
}
export class PersonPhone {
    activeflag!: number;
    personphonetypekey!: string;
    phonenumber!: string;
    phoneextension!: string;
    effectivedate!: string;
    insertedby!: string;
}
export class ActorRelation {
    index?: number;
    relationshiptypekey!: string;
    insertedby!: string;
}
export class PersonData {
    personbasicdetails!: PersonBasicDetail;
    personroledetails!: PersonRoleDetail;
}

export class PersonRoleDetail {
    actor!: Actor2;
}
export class Actor2 {
    actorid!: string;
    intakeserviceid!: string;
    actortype!: string;
    ishousehold?: any;
    dangerlevel!: number;
    dangerreason?: any;
    iscollateralcontact?: any;
    ismentalillness!: string;
    mentalillnessdetail!: string;
    ismentalimpair!: string;
    mentalimpairdetail!: string;
    intakeservicerequestactor!: IntakeServiceRequestActor[];
}
export class IntakeServiceRequestActor {
    intakeservicerequestactorid!: string;
    intakeservicerequestpersontypekey!: string;
    isprimary!: boolean;
    actorrelationship?: Actorrelationship;
}
//  {
//     intakeservicerequestactorid!: string;
//     actorid!: string;
//     intakeservicerequestpersontypekey!: string;
//     ramentalhealth?: any;
//     ramentalretarted?: any;
//     isprimary!: boolean;
//     actorrelationship!: Actorrelationship;
// }
// export class PersonRole {
//     rolekey!: string;
//     description!: string;
//     relationshiptorakey!: string;
//     isprimary!: string;
//     hidden!: boolean;
// }

export class Actorrelationship {
    relationshiptypekey!: string;
    intakeservicerequestactorid!: string;
}

export class UserRelationship {
    secondaryuserid!: string;
    primaryuserid!: string;
    description!: string;
    firstname!: string;
    updatedon!: string;
}

export class Actortypedesc {
    actortype!: string;
    typedescription!: string;
}

export class PersonBasicDetail {
    activeflag!: number;
    dangerlevel?: string;
    dangerreason?: string;
    tribalassociation!: string;
    deceaseddate?: string;
    personemail!: any[];
    aliasid!: string;
    firstname!: string;
    dob!: string;
    effectivedate!: string;
    ethnicgrouptypekey!: string;
    expirationdate?: string;
    firstnamesoundex!: string;
    gendertypekey!: string;
    incometypekey?: any;
    interpreterrequired!: string;
    lastname!: string;
    lastnamesoundex!: string;
    maritalstatustypekey!: string;
    middlename!: string;
    nameSuffix?: string;
    oldId?: string;
    personid!: string;
    cjamspid!: string;
    assistpid!: string;
    primarylanguageid?: string;
    principalident?: string;
    racetypekey!: string;
    religiontypekey?: string;
    salutation?: string;
    secondarylanguageid?: string;
    ssnverified?: string;
    timestamp?: string;
    userphoto!: string;
    refusessn!: boolean;
    refusedob!: boolean;
    dangertoself?: string;
    dangertoselfreason?: string;
    personphysicalattributetypeid?: string;
    maidenname?: string;
    socialmediasource?: string;
    dateofdeath?: string;
    suffix?: string;
    prefix?: string;
    occupation?: string;
    stateid?: string;
    fein?: string;
    complaintnumber?: string;
    cjisnumber?: string;
    petitionid?: string;
    personaddress!: PersonAddres[];
    personphonenumber!: PersonPhoneNumber[];
    personidentifier!: PersonIdentifier[];
    personphysicalattribute!: PersonPhysicalAttribute[];
    personeducation!: School[];
    personeducationvocation!: Vocation[];
    personeducationtesting!: Testing[];
    personaccomplishment!: Accomplishment[];
    alias!: Alias;
    actor!: Actor[];
    physicianinfo?: Physician[];
    healthinsurance?: HealthInsuranceInformation[];
    personmedicationphyscotropic?: Medication[];
    personhealthexam?: HealthExamination[];
    personmedicalcondition?: MedicalConditions[];
    personbehavioralhealth?: BehaviouralHealthInfo[];
    personabusehistory?: HistoryofAbuse;
    personabusesubstance?: SubstanceAbuse;
    persondentalinfo?: PersonDentalInfo[];
    strengths?: string;
    needs?: string;
    personrelation!: PersonRelation[];
    nationalitytypekey!: string;
}

export class Actor {
    actorid!: string;
    activeflag!: number;
    personid!: string;
    actortype!: string;
    dangerlevel?: string;
    dangerreason?: string;
    expirationdate?: string;
    timestamp?: string;
    primarylanguageid?: string;
    secondarylanguageid?: string;
    employeetypeid?: string;
    employeetypename?: string;
    medicaideligibility!: boolean;
    blockgranteligibility!: boolean;
    recipientstatus!: boolean;
    livingarrangementtypekey?: string;
    interpreterrequired?: string;
    guardianname?: string;
    guardianinfo?: string;
    ramentalhealth?: string;
    ramentalretarted?: string;
    ramentalretartedtype?: string;
}

export class Alias {
    aliasid!: string;
    activeflag!: number;
    personid!: string;
    firstname!: string;
    lastname?: string;
    middlename?: string;
    effectivedate!: string;
    expirationdate?: string;
    timestamp?: string;
    sfxname?: string;
    dcn?: string;
    ssn?: string;
    licenseno?: any;
}

export class PersonAccomplishment {
    highestgradetypekey!: string;
    accomplishmentdate!: string;
    isrecordreceived!: boolean;
    receiveddate!: string;
}

export class PersonEducationTesting {
    testingtypekey!: string;
    readinglevel!: number;
    readingtestdate?: string;
    mathlevel!: number;
    mathtestdate?: string;
    testingprovider!: string;
}

export class PersonEducationVocation {
    vocationinterest!: string;
    vocationaptitude!: string;
    isvocationaltest!: boolean;
    certificatename!: string;
    certificatepath!: string;
}

export class PersonEducation {
    educationname!: string;
    educationtypekey!: string;
    statecode!: string;
    startdate!: string;
    enddate!: string;
    lastgradetypekey!: string;
    currentgradetypekey!: string;
    isspecialeducation!: boolean;
    specialeducationtypekey!: string;
    absentdate?: any;
    isreceived!: boolean;
    isverified!: boolean;
    isexcuesed!: boolean;
}

export class PersonIdentifier {
    personidentifierid!: string;
    personid!: string;
    personidentifiertypekey!: string;
    personidentifiervalue!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate?: any;
    oldId?: any;
    timestamp?: any;
    personidentifiertype!: Personidentifiertype;
}

export class PersonPhysicalAttribute {
    physicalattributetypekey!: string;
    attributevalue!: string;
}

export class Personidentifiertype {
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    effectivedate!: string;
    expirationdate?: any;
    personidentifiertypekey!: string;
    sequencenumber!: number;
    typedescription!: string;
}

export class PersonPhoneNumber {
    personphonenumberid!: string;
    personid!: string;
    activeflag!: number;
    personphonetypekey!: string;
    phonenumber!: string;
    phoneextension!: any;
    reversephonenumber!: any;
    effectivedate!: string;
    expirationdate?: any;
    oldId?: any;
    timestamp?: any;
    Personphonetype!: PersonPhoneType;
    insertedby!: string;
}

export class PersonPhoneType {
    sequencenumber!: number;
    personphonetypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate?: any;
}

export class PersonAddres {
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
    expirationdate?: any;
    oldId?: any;
    address2!: string;
    directions!: string;
    danger!: string;
    dangerreason!: string;
    Personaddresstype!: PersonAddresType;
    routingAddressidflag!: string;
}

export class PersonAddresType {
    sequencenumber!: number;
    personaddresstypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate?: any;
}

/* end */
export class TimeStamp {
    type!: string;
    data!: number[];
}
export class InvolvedPersonAddress {
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
    effectivedate!: Date;
    expirationdate!: Date;
    oldId!: string;
    timestamp!: TimeStamp;
    address2!: string;
    directions!: string;
    danger!: string;
    dangerreason!: string;
    Personaddresstype!: TypeDescription;
}
export class InvolvedActor {
    actorid!: string;
    actortype!: string;
    actortypedesc!: ActorTypeDesc;
}
export class ActorRelationship {
    relationshiptypekey!: string;
    intakeservicerequestactorid!: string;
}

export class TypeDescription {
    typedescription!: string;
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
    source?: string;
    middleName?: string;
    gender?: string;
    city?: string;
    zipcode?: string;
    county?: string;
    priors!: number;
    relationscount!: number;
    relations!: any;
    socialmediasource!: string;
    suffix!: string;
    dod!: Date;
    dateofdeath!: Date;
    prefx!: string;
}
export class UserProfileImage {
    filename!: string;
    originalfilename!: string;
    mime!: string;
    numberofbytes!: number;
    s3bucketpathname!: string;
}
export class PersonEducationInfo {
    currentgradetypekey!: string;
    educationname!: string;
    typedescription!: string;
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
    personbehavioralhealthid: any;
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
    countyname!: string;
    countyid!: string;
    zip!: string;
    startdate!: string;
    enddate!: string;
    physicianspecialtytypekey!: string;
    personphycisianinfoid!: string;
}

export class PersonDentalInfo {
    isdentalinfo!: boolean;
    dentistname!: string;
    dentalspecialtytypekey: any;
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

export class HealthExamination {
    healthdomaintype!: any;
    healthassessmenttype!: any;
    healthexamname!: string;
    healthassessmenttypekey!: string;
    healthdomaintypekey!: string;
    assessmentdate!: string;
    healthprofessiontypekey!: string;
    practitionername!: string;
    outcomeresults!: string;
    notes!: string;
    personhealthexaminationid: any;
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
    updateddate?: string;
    personhealthinsuranceid?: string;
    countyid?: string;
    isinsuranceavailable?: string;
    effectivepolicydate?: string;
    expirationdate?: string;
    insurancetype?: string;
    createddate: any;
}

export class HistoryofAbuse {
    isneglect?: boolean;
    neglectnotes?: string;
    isphysicalabuse?: boolean;
    physicalnotes?: string;
    isemotionalabuse?: boolean;
    emotionalnotes?: string;
    issexualabuse?: boolean;
    sexualnotes?: string;
    personabusehistoryid?: string;
}

export class MedicalConditions {
    medicalconditiontypekey!: string;
    medicalconditionsnotes!: string;
    custommedicalcondition!: string;
    medicalcondition!: any;
    medicalcondition_icd10_desc!: any;
    begindate!: string;
    enddate!: string;
    recordedby!: string;
    personmedicalconditionid: any;
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
    personmedicpshychotropicid: any;
}

export class SubstanceAbuse {
    isusetobacco?: string;
    isusedrugoralcohol?: string;
    isusedrug?: string;
    drugfrequencydetails?: string;
    drugageatfirstuse?: string;
    isusealcohol?: string;
    alcoholfrequencydetails?: string;
    alcoholageatfirstuse?: string;
    drugoralcoholproblems?: string;
    tobaccofrequencydetails?: string;
    tobaccoageatfirstuse?: string;
    tobaccotimes?: string;
    drugtimes?: string;
    alcoholtimes?: string;
    personid?: string;
    personabusesubstanceid?: string;
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
    DRAI!: any;
    MCASP!: any;
}

export class Education {
    school?: School[];
    vocation?: Vocation[];
    testing?: Testing[];
    accomplishment?: Accomplishment[];
    personId?: string;
}

export class SuggestAddress {
    text!: string;
    streetLine!: string;
    city!: string;
    state!: string;
}

export class Relationship {
    relationshiptypekey!: string;
    description!: string;
}
export class RelationshipPerson {
    firstname!: string;
    lastname!: string;
    personid!: string;
    userphoto!: string;
}

export class PersonRelation {
    personid!: string;
    personrelationid!: string;
    personrelativeid!: string | null | undefined;
    relationcategory?: string | null | undefined;
    incustody!: boolean;
    livingwith!: boolean;
    actorrelationshipkey!: string | null | undefined;
    actorrelationship?: Relationship;
    person?: RelationshipPerson;
    onEdit?: boolean;
    personrelative: any;
}

export class ClientEventHistory {
    intakeserviceid!: string;
    servicerequestnumber!: string;
    foldertype!: string;
    teamtypekey!: string;
    businessunit!: string;
    status!: string;
    currentworker!: string;
    worker!: string;
    opendate!: string;
    closeddate!: string;

}

export class Alert {
    personalertid?: string;
    personid!: string | null | undefined;
    alerttype!: string;
    status!: string;
    startdatetime!: string;
    enddatetime!: string;
    notes!: string;
    activeflag!: number;
    personalerttype!: PersonAlertType;
    alertid!: string;
}

export class AlertDisplay {
    alertid!: string;
    alerttype!: string;
    createdid!: string;
    createdname!: string;
    createdpid!: string;
    description!: string;
    enddatetime!: string;
    insertedby!: string;
    notes!: string;
    personalertid!: string;
    startdatetime!: string;
    status!: string;
    updatedby!: string;
    updatedid!: string;
    updatedname!: string;
    totalcount!: number;
    updatedpid!: string;
}

export class LegalActionHistory {
    offensedate!: string;
    allegationname!: string[];
    petition!: string[];
    complaintid!: string;
    intakeservicerequestevaluationid!: string;
    countyname!: string;

}


export class PersonAlertType {
    personalerttypekey!: string;
    activeflag!: string;
    typedescription!: string;
}


export class FamilyInfo {
    personfamilyinfoid!: string;
    personid!: string;
    numofsiblings!: string;
    numofpersons!: string;
    grossincome!: string;
    primarysource!: string;
    titleiveeligible!: boolean;
    amoutwillpay!: string;
    notes!: string;
    placeofbirth!: string;
    historyfamilyprob!: boolean;
    runaway!: boolean;
    ungovernable!: boolean;
    stealing!: boolean;
    truancy!: boolean;
    assaultive!: boolean;
    residential!: boolean;
    outpatient!: boolean;
    personrelativeid!: string;
    maritalstatustypekey!: string;
}

export class PersonDsdsAction {
    personid?: string;
    daDetails!: DaDetails[];
    daTypeName!: string;
    highLight = false;
    InvolvedPersonSearchResponse: any;
    constructor(initializer?: PersonDsdsAction) {
        initializeObject(this, initializer);
    }
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

export class Hospitalization {
    hosptializationType!: string;
    startdate!: string;
    enddate!: string;
    hosptializationReason!: string;
    reasonOrDiagnosis!: string;
    hospitalName!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    zip!: string;
    phoneNumber!: string;
}

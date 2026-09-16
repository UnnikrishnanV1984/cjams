import { initializeObject } from '../../../../../@core/common/initializer';

export class InvolvedPerson {
    childname!: string;
    rolename!: string;
    dcn?: string;
    dateofdeath!: Date;
    isapproxdod!: number;
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
    county!: string;
    state!: string;
    zipcode!: string;
    phonenumber?: string;
    dangerous!: string;
    actorid!: string;
    maritalstatus?: string;
    intakeservicerequestactorid!: string;
    priorscount!: string;
    reported!: boolean;
    refusessn!: boolean;
    refusedob!: boolean;
    userphoto?: string;
    email?: string;
    roles!: Role[];
    isheadofhousehold!: boolean;
    school!: PersonEducationInfo[];
    relationship?: string;
    relationshipdescription!: string;
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
    externaltemplateid?: string;
    assessmenttemplatename?: string;
    submissionid?: string;
    submissiondata?: any;
    ischildsafe?: boolean;
    assessmentstatustypekey?: string;
    activefacility!: string;
    projecteddischargedate!: Date;
    closedfacility!: string;
    closeddischargedate!: Date;
    caseworkercounty!: string;
    ethinicity?: string;
    religion?: string;
    ssn?: string;
    racetypekey!: string;
    race?: any[];
    emergency?: any;
    isalleged?: any;
    guardiacodeinfo?: any;
    guardiafuneralinfo?: any;
    guardianattornyinfo?: any;
    guardianinfo?: any;
    guardianpropertyinfo?: any;
    guardianworkerinfo?: any;
    issafe!: number;
    schoolname: any;
    personracetypemap?: any[];
    education?: any[];
    relationshiparray!: Relationship[];
    middlename?: string;
    suffix?: string;
    prefix?: string;
    prefx?: string;
    fullname?: string;
    removaldate?: any;
    programarea?:[{programkey:string}];
}

export class Relationship {
    description!: string;
    firstname!: string;
    primaryuserid!: string;
    secondaryuserid!: string;
}

export class YouthInvolvedPersons {
    youthname!: string;
    youthdob!: string;
    assistpid!: string;
    cjamspid!: string;
    youthjurisdiction!: string;
    caseworkercounty!: string;
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
    begindate?: string;
    enddate?: string;
    recordedby?: string;
}

export class Medicationinformation {
    dosage!: string;
    medicationname!: string;
    frequency!: string;
    compliant?: any;
    personid!: string;
    monitoring?: string;
    description?: string;
    prescriptionreason?: string;
    medicationeffectivedate?: Date;
    medicationexpirationdate?: Date;
    informationsource?: string;
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
    reportname?: string;
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
    personsupport?: PersonSupport[];
    persondentalinfo?: PersonDentalInfo[];
    personpayee?: PersonPayee[];
    emergency?: ContactPerson[];
    fetalalcoholspctrmdisordflag?: number;
    drugexposednewbornflag?: number;
    probationsearchconductedflag?: number;
    sexoffenderregisteredflag?: number;
    guardian?: Guardian;
}
export class PersonSupport {
    personid!: string;
    intakenumber!: string;
    personsupporttypekey!: string;
    supportername!: string;
    description!: string;
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
    ssn!: string;
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
    danumber!: string;
    description!: string;
    firstname!: string;
    lastname!: string;
    role!: string;
    datereceived!: Date;
    datecompleted!: Date;
    status!: string;
    datype!: string;
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
    highestgradetypekey!: string;
    accomplishmentdate!: string;
    isrecordreceived!: boolean;
    receiveddate!: string;
}

export class Testing {
    testingtypekey!: string;
    readinglevel!: number;
    readingtestdate?: string;
    mathlevel!: number;
    mathtestdate?: string;
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
export class PersonEmail {
    activeflag = 1;
    personemailtypekey!: string;
    email!: string;
    effectivedate!: string;
    insertedby!: string;
}
export class People {
    suffix?: string;
    dateofdeath?: string;
    mdm_id?: string;
    ramentalretarted!: string;
    ramentalhealth!: string;
    activeflag: any;
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
    source!: string;
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
    probationsearchconductedflag?: number;
    intakeservicerequestactor!: IntakeServiceRequestActor[];
}
export class IntakeServiceRequestActor {
    intakeservicerequestactorid!: string;
    intakeservicerequestpersontypekey!: string;
    isprimary!: boolean;
    actorrelationship?: Actorrelationship;
}
//  {
//     intakeservicerequestactorid: string;
//     actorid: string;
//     intakeservicerequestpersontypekey: string;
//     ramentalhealth?: any;
//     ramentalretarted?: any;
//     isprimary: boolean;
//     actorrelationship: Actorrelationship;
// }
// export class PersonRole {
//     rolekey: string;
//     description: string;
//     relationshiptorakey: string;
//     isprimary: string;
//     hidden: boolean;
// }

export class Actorrelationship {
    relationshiptypekey!: string;
    intakeservicerequestactorid!: string;
}

export class Actortypedesc {
    actortype!: string;
    typedescription!: string;
}

export class PersonBasicDetail {
    activeflag!: number;
    licensedfacilitykey!: string;
    livingsituationdesc!: string;
    livingsituationkey!: string;
    otherlicensedfacility!: string;
    isapproxdod!: number;
    dangerlevel?: string;
    dangerreason?: string;
    tribalassociation!: string;
    deceaseddate?: string;
    personemail: any[] = [];
    aliasid!: string;
    firstname!: string;
    dob!: string;
    safehavenbabyflag!: number;
    everbeenadoptedflag!: number;
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
    primarylanguageid?: string;
    otherprimarylanguagetypekey?: string;
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
    personaddress: PersonAddres[] = [];
    personphonenumber: PersonPhoneNumber[] = [];
    personidentifier: PersonIdentifier[] = [];
    personeducation!: School[];
    personeducationvocation!: Vocation[];
    personeducationtesting!: Testing[];
    personaccomplishment!: Accomplishment[];
    alias!: Alias;
    actor!: Actor[];
    personphycisianinfo?: Physician[];
    personhealthinsurance?: HealthInsuranceInformation[];
    personmedicationphyscotropic?: Medication[];
    personhealthexam?: HealthExamination[];
    personmedicalcondition?: MedicalConditions[];
    personbehavioralhealth?: BehaviouralHealthInfo[];
    personabusehistory?: HistoryofAbuse;
    personabusesubstance?: SubstanceAbuse;
    persondentalinfo?: PersonDentalInfo[];
    strengths?: string;
    needs?: string;
    personphysicalattribute!: PersonphysicalAttribute[];
    emergencycontactperson?: EmergencyContactPersons[];
    personguardianfuneral!: Personguardianfuneral[];
    personguardian!: Personguardian[];
    personguardiancode!: Personguardiancode;
    personguardiandetails!: Personguardiandetails;
    otherreligion!: string;
    personsupport?: PersonSupport[];
    citizenalenageflag!: string;
    isqualifiedalien!: string;
    alienstatustypekey!: string;
    alienregistrationtext!: string;
    verificationremarks!: string;
    personrepresentativepayee?: PersonRepresentativeRayee[];
}
export class PersonRepresentativeRayee {
    personrepresentativepayeeid!: string;
    personid!: string;
    personrepresentativepersonid!: string;
    personrepresentativeworkerid?: any;
    entityid?: any;
    persontypekey!: string;
    ref_key!: string;
    startdate!: string;
    enddate!: string;
    effectivedate!: string;
    activeflag!: number;
    oldId?: any;
    payeecontact!: Payeecontact;
    referencevalues!: Referencevalues;
  }
  export class Payeecontact {
    firstname!: string;
    lastname!: string;
    personid!: string;
    personrepresentativepersonid?: string;
  }
  export class Referencevalues {
    ref_key!: string;
    referencetypeid!: number;
    value_text!: string;
    description!: string;
  }
export class EmergencyContactPersons {
    contactperson!: ContactPerson;
    personid!: string;
    contactpersonid!: string;
}
export class ContactPerson {
    firstname!: string;
    lastname!: string;
    contactpersonid!: string;
    personid?: string;
}
export class Personguardianfuneral {
    personguardianfuneralid!: string;
    personid!: string;
    contact!: string;
    contactnumber!: string;
    arrangementsdescription!: string;
    activeflag!: number;
    effectivedate!: string;
    oldId?: any;
}
export class Personguardiancode {
    personguardiancodeid!: string;
    personid!: string;
    codestatustypekey!: string;
    othercodestatus?: any;
    activeflag!: number;
    effectivedate!: string;
    oldId?: any;
}

export class Personguardiandetails {
    personguardiandetailsid!: string;
    personid!: string;
    hhsclientid!: number;
    notes?: any;
    activeflag!: number;
    effectivedate!: string;
    oldId?: any;
}
export class Personguardian {
    personid!: string;
    guadianpersonid!: string;
    guardianpersontypekey!: string;
    guardianperson!: Guardianperson;
}
export class Guardianperson {
    firstname!: string;
    lastname!: string;
    personid!: string;
}
export class PersonphysicalAttribute {
    physicalattributetypekey!: string;
    attributevalue!: string;
    physicalattributetype!: PhysicalAttributeType;
}

export class PhysicalAttributeType {
    physicalattributetypekey!: string;
    description!: string;
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
    phoneextension: any;
    reversephonenumber: any;
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
    insertedon: any;
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
    relations!: string;
    socialmediasource!: string;
    suffix!: string;
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
}

export class Health {
    personAllergies?: PersonAllergies[];
    personBehaviour?: BehaviouralHealthInfo[];
    birthInfo?: BirthInfocw[];
    personChronic?: PersonChronic[];
    personExamination?: PersonExamination[];
    familyHistory?: FamilyHistory[];
    hospitalization?: Hospitalization[];
    personImmunization?: PersonImmunization[];
    healthInsurance?: HealthInsuranceInformation[];
    medicalcondition?: MedicalConditions[];
    medication?: Medication[];
    healthExamination?: HealthExamination[];
    physician?: Physician[];
    persondentalinfo?: PersonDentalInfo[];
    personSexual?: PersonSexual[];
    substanceAbuse?: SubstanceAbuse;
    personUnder5Info?: Under5Info[];
    history?: HistoryofAbuse;
}

export class PersonImmunization {

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

export class Under5Info {
    parentcare!: string;
    gestation!: string;
    deliveryType!: string;
    comments!: string;
    hospitalcomments!: string;
    complications!: string;
    childbornin!: string;
    speciality!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    county!: string;
    zip!: string;
    phone!: string;
    email!: string;
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

export class BirthInfocw {
    mothersuse!: string;
    motherspciality!: string;
    medicalcondition!: string;
    medicalspciality!: string;
    diseases!: string;
    diseasespciality!: string;
    birthdefects!: string;
    comments!: string;
}



export class PersonExamination {
    apptDate!: string;
    nextApptDate!: string;
    natureofexamkey!: string;
    labtestkey!: string;
    specialityexamkey!: string;
    apptkept!: string;
    hivtestreceived!: string;
    speciality!: string;
    affilication!: string;
    physicianName!: string;
    recommendations!: string;
    comments!: string;
    address1!: string;
    address2!: string;
    city!: string;
    state!: string;
    county!: string;
    zip!: string;
    phone!: string;
    email!: string;

}

export class NatureofexamType {
    natureofexamTypeKey!: string;
}

export class FamilyHistory {
    infoclienttypekey!: string;
    relationshiptypekey!: string;
    major_health_problems!: string;
    deathcausetypekey!: string;
    comments!: string;
}
export class PersonAllergies {
    allergieskey!: string;
    allergiessymptoms!: string;
    specialkey!: string;
    specialcomments!: string;
    phobiakey!: string;
    phobiacomments!: string;
    hygienekey!: string;
    hygienecomments!: string;
    medicationcomments!: string;
    comments!: string;
}

export class PersonChronic {
    noknownchronic!: string;
    highriskmentaldisease!: string;
    physicalkey!: string;
    physicalcomments!: string;
    mentalkey!: string;
    mentalcomments!: string;
    comments!: string;
}

export class HealthInsuranceInformation {
    ismedicaidmedicare!: boolean;
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
    policynumber!: string;
    groupnumber!: string;
    startdate!: string;
    enddate!: string;
    updateddate?: string;
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
}

export class MedicalConditions {
    medicalconditiontypekey!: MedicalConditionTypes[];
    medicalconditionsnotes!: string;
    custommedicalcondition!: string;
    begindate!: string;
    enddate!: string;
    recordedby!: string;
}
export class MedicalConditionTypes {
    medicalconditiontypekey!: string;
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
    currentemployer!:string
}

export class AssessmentScores {
    DRAI: any;
    MCASP: any;
}
export class Guardianship {
    guardian!: Guardian;
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
export class PersonPayee {
    personid!: string;
    personrepresentativeworkerid?: string;
    personrepresentativepersonid?: string;
    entityid?: any;
    persontypekey!: string;
    representativetypekey!: string;
    startdate!: string;
    enddate!: string;
  }
  export class PersonPayType {
    firstname!: string;
    lastname!: string;
    personid!: string;
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
export class AssessmentBlob extends SaftyPlanBlob {}

export class PersonSexual {
     numberOfLivingChildren!: string;
      numberOfPregnancies!: string;
      sexuallyTransmittedDiseases!: string;
      birthControlMethod!: string;
      stdspecify!: string;
      bcspecify!: string;
      comments!: string;
      sexuallyActive!: string;
}


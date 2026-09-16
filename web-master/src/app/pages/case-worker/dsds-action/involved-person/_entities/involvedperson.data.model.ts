export class InvolvedPerson {
    dcn!: string;
    rolename!: string;
    firstname!: string;
    lastname!: string;
    personid!: string;
    gender!: string;
    dob!: Date;
    formattedDate!: string;
    address!: string;
    phonenumber!: string;
    dangerous!: string;
    actorid!: string;
    priorscount!: string;
    reported!: boolean;
    intakeservicerequestactorid!: string;
    userroles?: string;
    collateralid: any;
    cjamspid: any;
    fullname: any;
    roles: any;
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
    Personidentifier: PersonIdentifier[] = [];
    Alias: Alias[] = [];
    Actor: Actor[] = [];
    Personaddresses: PersonAddress[] = [];
    Personphonenumber: PersonPhone[] = [];
    Actorrelation: ActorRelation[] = [];
}

export class People {
    personid?: string;
    activeflag = 1;
    dangerlevel!: boolean;
    dangerreason!: string;
    dob!: Date;
    effectivedate!: Date;
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
    refusedob!: boolean;
}
export class DangerWorker {
    dangerlevel!: number;
    dangerreason!: string;
}

export class Actor {
    index?: number;
    actorid?: string;
    typedescription?: string;
    activeflag? = 1;
    actortype!: string;
    dangerlevel?: number;
    dangerreason?: string;
    primarylanguageid!: string;
    secondarylanguageid!: string;
    intakeserviceid!: string;
    intakeservicerequestpersontypekey!: string;
    actortypedesc!: ActorTypeDesc;
    actor!: Role;
}

export class Role {
    actorid!: string;
    actortype!: string;
    actortypedesc!: ActorTypeDesc;
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
    effectivedate!: Date;
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
    index?: number;
    personphonenumberid?: string;
    typedescription?: string;
    activeflag = 1;
    personphonetypekey!: string;
    phonenumber!: string;
    phoneextension!: string;
    effectivedate!: Date;
    insertedby!: string;
    Personphonetype!: TypeDescription;
}
export class ActorRelation {
    index?: number;
    relationshiptypekey!: string;
    insertedby!: string;
}

/* Get Involved Person */

export class PersonDetail {
    data!: PersonData;
}
export class PersonData {
    personbasicdetails!: PersonBasicDetail;
    personroledetails!: PersonRoleDetail[];
}
export class PersonBasicDetail {
    activeflag!: number;
    dangerlevel!: number;
    dangerreason!: string;
    deceaseddate!: Date;
    dob!: Date;
    effectivedate!: Date;
    ethnicgrouptypekey!: string;
    expirationdate!: Date;
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
    oldId!: string;
    personid!: string;
    primarylanguageid!: string;
    principalident!: string;
    racetypekey!: string;
    religiontypekey!: string;
    salutation!: string;
    secondarylanguageid!: string;
    ssnverified!: string;
    timestamp!: TimeStamp;
    refusedob!: boolean;
    refusessn!: boolean;
    personaddress!: InvolvedPersonAddress[];
    personphonenumber!: PersonPhone[];
    personidentifier!: PersonIdentifier[];
    alias!: Alias[];
}

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

export class PersonIdentifier {
    index?: number;
    personidentifierid?: string;
    activeflag!: number;
    typedescription?: string;
    personidentifiertypekey!: string;
    personidentifiervalue!: string;
    updatedby!: string;
    insertedby!: string;
    effectivedate!: Date;
    personidentifiertype!: TypeDescription;
}
export class Alias {
    activeflag!: number;
    aliasid?: string;
    index?: number;
    firstname!: string;
    lastname!: string;
    updatedby!: string;
    insertedby!: string;
    effectivedate!: Date;
}

export class PersonRoleDetail {
    intakeservicerequestactorid!: string;
    actorid!: string;
    intakeservicerequestpersontypekey!: string;
    rapersontypekey!: string;
    expirationdate!: Date;
    timestamp!: TimeStamp;
    intakeserviceid!: string;
    routingaddressid!: string;
    employeetypeid!: string;
    employeetypename!: string;
    medicaideligibility!: string;
    blockgranteligibility!: string;
    livingarrangementtypekey!: string;
    guardianname!: string;
    guardianinfo!: string;
    ramentalhealth!: string;
    ramentalretarted!: string;
    ramentalretartedtype!: string;
    refusessn!: boolean;
    refusedob!: boolean;
    actor!: InvolvedActor;
    actorrelationship!: ActorRelationship[];
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

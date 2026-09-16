import { Injectable } from '@angular/core';
import { initializeObject } from '../../../@core/common/initializer';


@Injectable()
export class PaymentHeader {
    paymentid!: string;
    providerid!: string;
    clientaccountid!: string;
    paymentdate!: string;
    paymenttype!: string;
    paymentstatus!: string;
    paymentmode!: string;
    grossamount!: string;
    offsetamount!: string;
    netamount!: string;

    constructor(initializer?: PaymentHeader) {
        initializeObject(this, initializer);
    }
}

export class PaymentSearchEntity {
    activeflag!: string;
    sortcol!: string;
    sortdir!: string;
    paymentid!: string;
    feintaxid!: string;
    providerid!: string;
    providername!: string;
    clientaccountid!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    city!: string;
    count!: string;
    interfacetype!: string;
    region!: string;
    daterangefrom!: string;
    daterangeto!: string;
    ssn!: string;
    dcn!: string;
    firstname!: string; // REMOVE
 // REMOVE
    id!: 0;

    constructor(initializer?: PaymentSearchEntity) {
        initializeObject(this, initializer);
    }
}

export class PersonSearchEntity {
    activeflag!: string; // Mandatory. default to “1” for active and  “0” for inactive
  // Mandatory. default to “1” for active and  “0” for inactive
    personflag!: string; // Mandatory. default to “T”
 // Mandatory. default to “T”
    sortcol!: string; // Mandatory. Default to “lastname”.
 // Mandatory. Default to “lastname”.
    sortdir!: string; // Mandatory. Default to “asc”
 // Mandatory. Default to “asc”
    firstname!: string;
    lastname!: string;
    age!: string;
    race!: string;
    gender!: string; // “M” for Male & “F” for Female
 // “M” for Male & “F” for Female
    city!: string;
    address!: string;
    zip!: string;
    state!: string;
    county!: string;
    phone!: string;
    dob!: string; // Sample {dob : 2/5/1950}
 // Sample {dob : 2/5/1950}
    roletype!: string;
    rolesubtype!: string;
    count!: string;
    interfacetype!: string;
    commapos!: string;
    dangerous!: string;
    region!: string;
    dobfrom!: string;
    dobto!: string;
    ssn!: string;
    dcn!: string;
    id!: 0;

    constructor(initializer?: PersonSearchEntity) {
        initializeObject(this, initializer);
    }
}

@Injectable()
export class Person {
    personid!: string;
    personroleid!: string;
    personroletype!: string;
    personrolesubtype!: string;
    firstname!: string;
    middlename!: string;
    lastname!: string;
    dob!: string;
    dangerlevel:any= null;
    ssn!: string;
    dcn!: string;
    primaryaddress!: string;
    homephone:any= null;
    gendertypekey!: string;
    loadnumber!: string;
    teamname!: string;
    addressJson?: Address;

    constructor(initializer?: Person) {
        initializeObject(this, initializer);
    }

}

export class PersonDetails {
    activeflag!: 1;
    dangerlevel:any= null;
    dangerreason:any= null;
    deceaseddate:any= null;
    dob!: string;
    effectivedate!: string;
    ethnicgrouptypekey!: string;
    expirationdate!: string;
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
    timestamp: any;

    constructor(initializer?: PersonDetails) {
        initializeObject(this, initializer);
    }
}

export class PersonPhoneNumber {
    personphonenumberid!: string;
    personid!: string;
    activeflag!: number;
    personphonetypekey!: string;
    phonenumber!: string;
    phoneextension!: string;
    reversephonenumber!: string;
    effectivedate!: string;
    expirationdate!: string;
    oldId!: string;
    Personphonetype: any;
    constructor(initializer?: PersonPhoneNumber) {
        initializeObject(this, initializer);
    }
}

export class PersonAddress {
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
    expirationdate!: string;
    oldId!: string;
    address2!: string;
    directions!: string;
    danger!: boolean;
    dangerreason!: string;
    timestamp: any;
    Personaddresstype: any;

    constructor(initializer?: PersonAddress) {
        initializeObject(this, initializer);
    }
}

export class PersonIdentifier {

    personidentifierid!: string;
    personid!: string;
    personidentifiertypekey!: string;
    personidentifiervalue!: string;
    updatedby!: string;
    updatedon!: string;
    insertedby!: string;
    insertedon!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
    oldId!: string;

    constructor(initializer?: PersonIdentifier) {
        initializeObject(this, initializer);
    }
}

export class PersonRole {

    actorid!: string;
    activeflag!: number;
    personid!: string;
    actortype!: string;
    dangerlevel!: number;
    dangerreason!: string;
    expirationdate!: string;
    primarylanguageid!: string;
    secondarylanguageid!: string;
    employeetypeid!: string;
    employeetypename!: string;
    medicaideligibility!: boolean;
    blockgranteligibility!: boolean;
    recipientstatus!: boolean;
    livingarrangementtypekey!: string;
    interpreterrequired!: string;
    guardianname!: string;
    guardianinfo!: string;
    ramentalhealth!: boolean;
    ramentalretarted!: boolean;
    ramentalretartedtype!: string;

    constructor(initializer?: PersonRole) {
        initializeObject(this, initializer);
    }
}

export class PersonAlias {

    aliasid!: string;
    activeflag!: number;
    personid!: string;
    firstname!: string;
    lastname!: number;
    middlename!: string;
    effectivedate!: string;
    expirationdate!: string;
    sfxname!: string;
    dcn!: string;
    ssn!: string;
    licenseno!: string;

    constructor(initializer?: PersonAlias) {
        initializeObject(this, initializer);
    }
}

export class PersonDsdsAction {
    danumber!: string;
    description!: string;
    firstname!: string;
    lastname!: string;
    role!: string;
    datereceived!: string;
    datecompleted!: string;
    status!: string;
    datype!: string;

    constructor(initializer?: PersonDsdsAction) {
        initializeObject(this, initializer);
    }
}




export class Address {
    Id!: number;
    address1!: string;
    address2!: string;
    city!: string;
    zipcode!: string;
    county!: string;
    state!: string;

    constructor(initializer?: Address) {
        initializeObject(this, initializer);
    }
}

export class PersonPhoneNumberDetails {

    personphonenumberid!: string;
    personid!: string;
    activeflag!: number;
    personphonetypekey!: string;
    phonenumber!: string;
    phoneextension!: string;
    reversephonenumber!: string;
    effectivedate!: string;
    expirationdate!: string;
    oldId!: string;
    timestamp: any;
    Personphonetype!: PhoneNumberType;

    constructor(initializer?: PersonPhoneNumberDetails) {
        initializeObject(this, initializer);
    }
}

export class PhoneNumberType {

    sequencenumber!: number;
    personphonetypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate!: string;

    constructor(initializer?: PhoneNumberType) {
        initializeObject(this, initializer);
    }
}

export class PersonClearing {
    constructor(initializer?: PersonClearing) {
        initializeObject(this, initializer);
    }
}

// DSDS Action Entities
export class DsdsActionFilter {
    status!: string[];
    assigned!: string[];
    reporteddate!: string;
    duedate!: string;
    overdue!: string;
    srtype!: string[];
    region!: string;
    county!: string;
    zipCode!: string;
    servicerequestnumber!: string;
    moNumber!: string;
    pagenumber!: number; // Mandatory. Default to 1
 // Mandatory. Default to 1
    pagesize!: number;
    srsubtype!: string;
    disposition!: string;
    receivedFrom!: Date;
    receivedTo!: Date;
    openedFrom!: Date;
    openedTo!: Date;
    closedFrom!: Date;
    closedTo!: Date;
    reportedAdult!: string;
    allegedPerpetrator!: string;
    dsdsProvider!: string;
    reporter!: string;
    dsdsWorker!: string;
    loadNumber!: string;
    activeflag = 1;
    constructor(initializer?: DsdsActionFilter) {
        initializeObject(this, initializer);
    }
}
export class DsdsActionResult {
    daType!: string;
    subType!: string;
    number!: string;
    dateReceived!: Date;
    dateDue!: Date;
    assignedTo!: string;
    focus!: string;
    team!: string;
    status!: string;
    disposition: any;
    countyname?: string;
    countyid?: string;
    regionname?: string;
    regionid?: string;
    description?: string;
    intakeservreqtypekey?: string;
    intakeservreqtypeid?: string;
    intakeserreqstatustypeid?: string;
    dispositioncode?: string;
    srtype: any;
    srsubtype: any;
    intakeserviceid: any;
    servicerequestnumber: any;
    datereceived: any;
    datedue:any;
    assignedto: any;
    raname: any;
    teamname: any;
    srstatus: any;

    constructor(initializer?: DsdsActionResult) {
        initializeObject(this, initializer);
    }
}

// DSDS Action Entities end

// Entities page entities start

export class Entities {
    constructor(initializer?: Entities) {
        initializeObject(this, initializer);
    }
}

export class EntitiesSearchEntity {
    ActiveFlag!: number; // Mandatory. default to “1” for active and  “0” for inactive
  // Mandatory. default to “1” for active and  “0” for inactive
    ActiveFlag1!: number;
    personflag!: string; // Mandatory. default to “T”
 // Mandatory. default to “T”
    pagenumber!: 1; // Mandatory. Default to 1
 // Mandatory. Default to 1
    pagesize!: number; // Mandatory. Default and static  to 10.
 // Mandatory. Default and static  to 10.
    sortcol!: string; // Mandatory. Default to “lastname”.
 // Mandatory. Default to “lastname”.
    sortdir!: string; // Mandatory. Default to “asc”
 // Mandatory. Default to “asc”

    agencyname!: string;
    commonname!: string;
    status!: string;
    phonenumber!: string;
    facid!: string;

    address!: string;
    street2!: string;
    city!: string;
    zipcode!: string;
    state!: string;
    countyid!: string;
    countyname!: string;
    regionid!: string;
    regionname!: string;


    agencycategorykey!: string;
    agencytypekey!: string;
    businesstype!: string;
    servicetypekey!: string;
    areaserviced!: string;

    agencytypedesc!: string;
    agencysubtype!: string;
    agencysubtypedesc!: string;

    serviceprovider!: string;
    areaserved!: string;
    description!: string;
    typedescription!: string;
    servicename!: string;
    ssbg: any;


    constructor(initializer?: EntitiesSearchEntity) {
        initializeObject(this, initializer);
    }

}

export class DocumentsSearchEntity {
    activeflag!: string; // Mandatory. default to “1” for active and  “0” for inactive
  // Mandatory. default to “1” for active and  “0” for inactive
    pagenumber!: 1; // Mandatory. Default to 1
 // Mandatory. Default to 1
    pagesize!: number; // Mandatory. Default and static  to 10.
 // Mandatory. Default and static  to 10.
    sortcol!: string; // Mandatory. Default to “lastname”.
 // Mandatory. Default to “lastname”.
    sortdir!: string; // Mandatory. Default to “asc”
 // Mandatory. Default to “asc”
    doctype!: string[];
    assigned!: string[];
    notificationattachments!: boolean;
    librarydocument!: boolean;
    mergetemplatedocument!: boolean;
    attachment!: boolean;
    formdocument!: boolean;
    receivedfrom!: string;
    receivedto!: string;
    documentidentifer!: string;
    documenttypekey!: string;
    title: any;
    servicerequestnumber: any;
    servicerequesttype: any;
    servicerequestsubtype: any;
    documentidentifier: any;
    receiveddate: any;

    constructor(initializer?: DocumentsSearchEntity) {
        initializeObject(this, initializer);
    }
}

export class DocumentType {
    value!: string;
    constructor(initializer?: DocumentType) {
        initializeObject(this, initializer);
    }
}

export class DocumentsResultsEntity {
    servicerequestnumber!: string;
    servicerequesttype!: string;
    servicerequestsubtype!: string;
    title!: string;
    documentidentifier!: string;
    doctype!: string;
    receiveddate!: string;
    documentpropertyid!: string;

    constructor(initializer?: DocumentsResultsEntity) {
        initializeObject(this, initializer);
    }
}

export class DocumentsViewEntity {
    attachmentclassificationtypekey!: string;
    sourceauthor!: string;
    sourceaddress!: string;
    attachmentsubject!: string;
    acquisitionmethod!: string;
    locationoforiginal!: string;
    sourceposition!: string;
    sourcephonenumber!: string;
    attachmentpurpose!: string;
    attachmenttypekey: any;
    note: any;
    Userprofile: any;
    insertedon: any;
    locationoforigin: any;

    constructor(initializer?: DocumentsViewEntity) {
        initializeObject(this, initializer);
    }
}

// Entities page entities end

// Provider page entities start

export class ProviderAttributeSelector {
    provider!: string;
    providerText!: string;
    agencycategory!: string;
    nameFilter!: { show: boolean; legalName: boolean; officialName: boolean; dbaName: boolean; status: boolean; };
    providerFilter!: { show: boolean; paType: boolean; ssbg: boolean; specialTerms: boolean; };
    seviceFilter!: { show: boolean; category: boolean; type: boolean; businessType: boolean; service: boolean; areaServiced: boolean; };
    locationFilter!: { show: boolean; street: boolean; street2: boolean; city: boolean; zip: boolean; county: boolean; region: boolean; phone: boolean; facid: boolean; };

    constructor(initializer?: ProviderAttributeSelector) {
        initializeObject(this, initializer);
    }
}

export class ProviderSearchParam {
    agencyname!: string;
    name!: string;
    status!: string;
    provideragreementtype!: string;
    specialterms!: string;
    ssbg!: string;
    agencycategory!: string;
    agencytype!: string;
    agencysubtype!: string;
    serviceid!: string;
    county!: string;
    address1!: string;
    address2!: string;
    city!: string;
    zipcode!: string;
    region!: string;
    phonenumber!: string;
    facid!: string;
    activeflag = 1;
    activeflag1 = 1;
    constructor(initializer?: ProviderSearchParam) {
        initializeObject(this, initializer);
    }
}

export class ProviderSearchResult {
    agencyid!: string;
    agencyname!: string;
    status:any= null;
    ssbg:any= null;
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
    agencycategory: any;

    constructor(initializer?: ProviderSearchResult) {
        initializeObject(this, initializer);
    }
}
export class ProviderAgencyListing {
    agencyid!: string;
    activeflag!: number;
    agencytypekey!: string;
    agencyname!: string;
    phonenumber!: string;
    participationstatuskey!: string;
    specialtytypekey!: string;
    facilityid!: string;
    federaltaxid!: string;
    websiteaddress!: string;
    reversephonenumber!: string;
    effectivedate!: string;
    expirationdate!: string;
    oldId!: string;
    timestamp: any;
    agencynumber!: string;
    parentagencyid!: string;
    email!: string;
    facilitytypechangedate!: string;
    officestatustypekey!: string;
    agencystatustypekey!: string;
    agencycategorykey!: string;
    affiliations!: string;
    agencysubtypekey!: string;
    billname!: string;
    mailname!: string;
    agencygroupid!: string;
    Providernonagreementmedicaiddetail!: ProviderNonAgreementMedicailDetail[];
    Providernonagreementdetail!: ProviderNonAgreementDetail[];

    constructor(initializer?: ProviderAgencyListing) {
        initializeObject(this, initializer);
    }

}

export class ProviderNonAgreementMedicailDetail {

    providernonagreementmedicaiddetailid!: string;
    agencyid!: string;
    medicaidtypekey!: string;
    activeflag!: number;
    expirationdate!: string;
    effectivedate!: string;
    value!: string;

    constructor(initializer?: ProviderNonAgreementMedicailDetail) {
        initializeObject(this, initializer);
    }
}

export class ProviderNonAgreementDetail {

    providernonagreementdetailid!: string;
    agencyid!: string;
    activeflag!: number;
    specialtycd1!: string;
    speccd1stdt!: string;
    speccd1endt!: string;
    specialtycd2!: string;
    speccd2stdt!: string;
    speccd2endt!: string;
    specialtycd3!: string;
    speccd3stdt!: string;
    speccd3endt!: string;
    specialtycd4!: string;
    speccd4stdt!: string;
    speccd4endt!: string;
    specialtycd5!: string;
    speccd5stdt!: string;
    speccd5endt!: string;
    countycd!: string;
    licensenumber!: string;
    licensestate!: string;
    enrollstatus1!: string;
    enrollstdate1!: string;
    enrollendate1!: string;
    provacind!: string;
    provnpi!: string;
    expirationdate!: string;
    effectivedate!: string;
    providernonagreementtypekey!: string;
    npi2!: string;
    taxonomy1!: string;
    taxonomy2!: string;
    taxonomy3!: string;
    taxonomy4!: string;
    npi3!: string;
    npi4!: string;
    npi5!: string;

    constructor(initializer?: ProviderNonAgreementDetail) {
        initializeObject(this, initializer);
    }
}

export class ProviderAgencyTaxListing {

    federalTaxID26!: string;
    federalTaxID28!: string;
    federalTaxID29!: string;
    federalTaxID49!: string;
    federalTaxID89!: string;
    npi1!: string;
    npi2!: string;
    npi3!: string;
    npi4!: string;
    npi5!: string;
    providerTaxonomy1!: string;
    providerTaxonomy2!: string;
    providerTaxonomy3!: string;
    providerTaxonomy4!: string;

    constructor(initializer?: ProviderAgencyTaxListing) {
        initializeObject(this, initializer);
    }

}

export class AgencyAddress {
    agencyaddressid!: string;
    agencyid!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
    timestamp: any;
    agencyaddresstypekey!: string;
    address!: string;
    zipcode!: string;
    city!: string;
    state!: string;
    country!: string;
    county!: string;
    direction!: string;
    old_id!: string;
    address2!: string;
    Agencyaddresstype!: AgencyAddressType;

    constructor(initializer?: AgencyAddress) {
        initializeObject(this, initializer);
    }
}

export class AgencyAddressType {
    sequencenumber!: number;
    agencyaddresstypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate!: string;

    constructor(initializer?: AgencyAddressType) {
        initializeObject(this, initializer);
    }
}

export class AgencyServiceListing {
    agencyserviceid!: string;
    agencyid!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate!: string;
    timestamp: any;
    name!: string;
    shortname!: string;
    servicetypekey!: string;
    serviceid!: string;
    startdate!: string;
    enddate!: string;
    Service!: AgencyServiceType;

    constructor(initializer?: AgencyServiceListing) {
        initializeObject(this, initializer);
    }
}

export class AgencyServiceType {
    serviceid!: string;
    activeflag!: number;
    servicename!: string;
    description!: string;
    servicetypekey!: string;
    effectivedate!: string;
    expirationdate!: string;
    provideragreementtypekey!: string;
    timestamp: any;

    constructor(initializer?: AgencyServiceType) {
        initializeObject(this, initializer);
    }
}


// Find regualtion library start
export class RegulationLibrarySearch {
    searchCriteria!: string;
    type!: string;
    status!: string;
    pagenumber!: 1;
    constructor(initializer?: RegulationLibrarySearch) {
        initializeObject(this, initializer);
    }
}
export class RegulationLibraryResult {
    statestatuteskey!: string;
    description!: string;
    statestatutetext!: string;
    librarytype!: string;
    effectivedate!: string;
    expirationedate!: string;
    statustype!: string;
    possiblesanctionflag!: string;
    possiblereferralflag!: string;
    constructor(initializer?: RegulationLibraryResult) {
        initializeObject(this, initializer);
    }
}
// Find regualtion library end
// Find staff n team start
export class StaffSearchCriteria {
    LastName!: string;
    FirstName!: string;
    Position!: string;
    positionTitle!: string;
    orgNumber!: string;
    TeamNo!: string;
    TeamType!: string;
    city!: string;
    zipcode!: string;
    county!: string;
    region!: string;
    UserCity!: string;
    UserZipCode!: string;
    UserCounty!: string;
    ActiveFlag!: 1;

    constructor(initializer?: StaffSearchCriteria) {
        initializeObject(this, initializer);
    }
}

export class UserProfileDetails {
    User!: UserDetails;
    Userprofileidentifier!: Useriddetails[];
    Userprofileaddress!: UserAddressdetails;
    Userprofilephonenumber!: UserPhoneDetails[];

    constructor(initializer?: UserProfileDetails) {
        initializeObject(this, initializer);
    }
}

export class Useriddetails {
    userprofileidentifierid!: string;
    userprofileidentifiertypekey!: string;
    userprofileidentifiervalue!: string;
    securityusersid?: string;
    constructor(initializer?: Useriddetails) {
        initializeObject(this, initializer);
    }
}

export class UserPhoneDetails {
    userprofilephonenumberid!: string;
    userprofiletypekey!: string;
    securityusersid?: string;
    phonenumber!: string;
    phoneextension!: string;
    reversephonenumber!: string;
    constructor(initializer?: UserPhoneDetails) {
        initializeObject(this, initializer);
    }
}

export class UserPositionCode {
    teammemberid!: string;
    activeflag!: number;
    teamid!: string;
    loadnumber!: string;
    roletypekey!: string;
    positioncode!: string;
    description!: string;
    isoncall!: boolean;
    insertedby!: string;
    updatedby!: string;
    effectivedate!: string;
    expirationdate!: string;
    linenumber!: string;
    voidedby!: string;
    voidedon!: string;
    voidreasonid!: string;
    rtfdate!: string;
    coadate!: string;

    constructor(initializer?: UserPositionCode) {
        initializeObject(this, initializer);
    }
}

export class UserProfile {
    userdetails!: UserDetails;
    addressdetails!: UserAddressdetails;
    iddetails!: Useriddetails[];
    phonedetails!: UserPhoneDetails[];
    networkid!: UserNetworkId;
    positioncode!: UserPositionCode;
    teamdetails!: UserTeamDetails;
    countydetails!: {
        fipscode: 201;
        locationcode: null;
    };
    constructor(initializer?: UserProfile) {
        initializeObject(this, initializer);
    }
}

export class Countydetails {
    fipscode?: number;
    locationcode?: string | null;

    constructor(initializer: Countydetails) {
        initializeObject(this, initializer);
    }
}

export class UserNetworkId {
    username!: string;
}

export class UserTeamDetails {
    id!: string;
    activeflag!: number;
    name!: string;
    teamnumber!: string;
    teamtypekey!: string;
    description!: string;
    officetimingfrom!: string;
    officetimingto!: string;
    parentteamid!: string;
    insertedby!: string;
    updatedby!: string;
    effectivedate!: string;
    expirationdate!: string;
    region!: number;
    Teamtypekey!: string;
    constructor(initializer?: UserTeamDetails) {
        initializeObject(this, initializer);
    }
}

export class UserAddressdetails {
    userprofileaddressid!: string;
    address!: string;
    zipcode!: string;
    pobox!: string;
    city!: string;
    state!: string;
    country!: string;
    zipcodeplus!: string;
    county!: string;
    securityusersid?: string;
    userprofileaddresstypekey?: string;

    constructor(initializer?: UserAddressdetails) {
        initializeObject(this, initializer);
    }
}

export class UserDetails {
    securityusersid!: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
    fullname!: string;
    activeflag!: number;
    email!: string;
    title!: string;
    calendarkey!: string;
    orgname!: string;
    orgnumber!: string;
    usertypekey!: string;
    insertedon!: string;
    autonotification!: boolean;
    unavailableflag!: boolean;
    isavailable?: boolean;
    userworkstatustypekey!: string;

    constructor(initializer?: UserDetails) {
        initializeObject(this, initializer);
    }
}

export class Equipment {
    equipmentid!: string;
    activeflag!: number;
    equipmenttypekey!: string;
    description!: string;
    manufacturer!: string;
    locationcode!: string;
    updatedby!: string;
    updatedon?: string;
    insertedby!: string;
    insertedon?: string;
    effectivedate!: string;
    expirationdate!: string;
    model!: string;
    serialnumber!: string;
    whitetagnumber!: string;
    yellowtagnumber!: string;
    sutnumber!: string;
    roomnumber!: string;
    comments!: string;
    primarymachine!: boolean;
    found!: boolean;
    notfound?: boolean;
    transfer!: boolean;
    upforreplacement!: boolean;
    disposed!: boolean;
    dh60date!: string;
    unit!: string;
    timestamp?: string;

    constructor(initializer?: Equipment) {
        initializeObject(this, initializer);
    }
}

export class TeamMemberDetails {
    id!: string;
    positioncode!: string;
    isexpired!: boolean;
    displayname!: string;
    isavailable!: string;
    userworkstatustypekey!: string;
    workstatustype!: string;
    roletype!: string;
    fullname!: string;
    lastname!: string;
    firstname!: string;
    orgname!: string;

    constructor(initializer?: TeamMemberDetails) {
        initializeObject(this, initializer);
    }
}

export class UsersSearchResult {
    firstname!: string;
    lastname!: string;
    title!: string;
    teamname!: string;
    positioncode!: string;
    officephone!: string;
    city!: string;
    county!: string;
    zipcode!: string;
    region!: string;
    count!: number;
    statecellphonenumber!: string;
    securityusersid!: string;
    teammemberid!: string;

    constructor(initializer?: UsersSearchResult) {
        initializeObject(this, initializer);
    }
}

export class UserProfileFormData {
    webtoolid!: string;
    zipcodeplus!: string;
    homePhone!: string;
    personelcell!: string;
    phonenumber!: string;
    officePhone!: string;
    directLine!: string;
    fax!: string;
    businessCell!: string;
    pager!: string;
    availability!: boolean;
    status!: string;
    internalcalenderLink!: boolean;
    enablecalender!: boolean;
    disablecalender!: boolean;
    resetKey!: boolean;
    autonotification!: boolean;
    pobox!: string;
    county!: string;
    prodid!: string;

    constructor(initializer?: UserProfileFormData) {
        initializeObject(this, initializer);
    }
}

export class TeamMemberCountyDetails {
    county!: CountyDetails;
    countyid!: string;
    teammemberid!: string;
    constructor(initializer?: TeamMemberCountyDetails) {
        initializeObject(this, initializer);
    }
}

export class CountyDetails {
    countyid!: string;
    countyname!: string;
    regionid!: string;
    statecountycode!: string;
    fipscode!: number;
    longitude!: number;
    latitude!: number;
    state!: string;
    apsregion!: number;
    ltcregion!: number;
    zipcode!: number;
    city!: string;

    constructor(initializer?: CountyDetails) {
        initializeObject(this, initializer);
    }
}

export class TeamZipCodeDetails {
    countyid!: string;
    activeflag!: number;
    countyname!: string;
    regionid!: string;
    statecountycode!: string;
    fipscode!: number;
    oldcountyid!: string;
    insertedby!: string;
    updatedby!: string;
    expirationdate!: string;
    effectivedate!: string;
    longitude!: number;
    latitude!: number;
    state!: string;
    apsregion!: number;
    ltcregion!: number;
    zipcode!: number;
    city!: string;
    locationcode!: string;

    constructor(initializer?: TeamZipCodeDetails) {
        initializeObject(this, initializer);
    }
}

export class UserRoles {
    username!: string;
    role!: string;

    constructor(initializer?: UserRoles) {
        initializeObject(this, initializer);
    }
}

export class TreeView {
    children?: TreeView[];
    id!: string;
    name!: string;
    parentteamid!: string;
    teamnumber!: string;

    constructor(initializer?: TreeView) {
        initializeObject(this, initializer);
    }
}
// Staff and team end

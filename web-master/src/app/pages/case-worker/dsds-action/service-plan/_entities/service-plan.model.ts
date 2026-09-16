export class ServicePlanGoal {
    serviceplangoalid!: string;
    objecttypekey!: string;
    objectid!: string;
    goaldate!: Date;
    goal!: string;
    strategy!: string;
    activeflag!: number;
    effectivedate!: Date;
}

export class AddServicePlanGoal {
    objecttypekey!: string;
    objectid!: string;
    goaldate!: Date;
    goal!: string;
    strategy!: string;
}
export class RepeatsOn {
    day!: string;
    dayValue!: string;
}

export class AddServicePlanActivity {
    objecttypekey!: string;
    objectid!: string;
    activity!: string;
    servicetypekey!: string;
    servicesubtypekey!: string;
    personinvolved!: string;
    responsibleperson!: string;
    reevaluationdate!: Date;
    completiondate!: Date;
    serviceplangoalid!: string;
    serviceplanactivitystatustypekey!: string;
}

export class ServicePlanActivityRes {
    count!: string;
    data!: ServicePlanActivity;
}

export class ServicePlanActivity {
    serviceplanactivityid!: string;
    objecttypekey!: string;
    objectid!: string;
    activity!: string;
    servicetypekey!: string;
    servicesubtypekey!: string;
    personinvolved!: string;
    responsibleperson!: string;
    reevaluationdate!: Date;
    completiondate!: Date;
    serviceplangoalid!: string;
    serviceplanactivitystatustypekey!: string;
    activeflag!: number;
    effectivedate!: Date;
    // serviceplans: ServicePlan[];
    // serviceplans: ServicePlan[];
    services!: ServicePlan[];
    servicetypedescription!: string;
    servicesubtypedescription!: string;
    goal!: string;
}
export class ServicePlan {
    serviceplanid!: string;
    objecttypekey?: string;
    objectid!: string;
    serviceplanactivityid!: string;
    providerid!: string;
    providercontracttypekey?: string;
    providercontractrateid?: string;
    startdate!: Date;
    enddate!: Date;
    isrepeats!: number;
    noofoccurence!: number;
    rate?: number;
    reason!: string;
    serviceplanstatustypekey!: string;
    activeflag!: number;
    effectivedate!: Date;
    serviceplanlogid!: string;
    providername: any;
    servicename: any;
}

export class SearchPlanRes {
    count!: string;
    data!: SearchPlan;
}

export class SearchPlan {
    providerid!: string;
    providercategorytypekey!: string;
    providername!: string;
    prefix!: string;
    firstname!: string;
    middlename?: string;
    lastname!: string;
    provideraddresstypekey!: string;
    buildingno?: any;
    addressline1!: string;
    addressline2?: string;
    city!: string;
    county!: string;
    state!: string;
    provideraddressid!: string;
    zipcode?: number;
    providercontracttypekey?: string;
    providercontracttypename?: string;
    rate?: string;
    latitude!: number;
    longitude!: number;
    addrcityname: any;
    race: any;
    gender: any;
    age: any;
    services: any;
    approvedbeds: any;
    vacancyno: any;
    addrzipcode: any;
    addrstate: any;
    addrstreetsuffixcode: any;
    addrstreetname: any;
    providercode: any;
    displayname: any;
    providerservice: any;
}
export class Placement {
    totalcount!: string;
    childname?: string;
    dob?: Date;
    placementtype!: string;
    placedatetime!: string;
    placementinformation!: string;
    status!: string;
    placeenddatetime?: string;
    role!: string;
    providerinfo!: Providerinfo1;
    exitreasontypekey?: string;
    placementid?: string;
    iscourtexists!: boolean;
    iseligible!: boolean;
    gender?: string;
    ispermanencyexists?: boolean;
    istempplacement?: boolean;
    clientname: any;
}

export class Providerinfo1 {
    providername!: string;
    addressline1!: string;
    addressline2!: string;
    email!: string;
    work!: number;
    ext!: number;
    fax!: number;
    zipcode!: number;
    phonenumber!: Phonenumber[];
}
export class Phonenumber {
    phonenumber!: number;
    providercontactinfotypekey!: string;
}
export class ActivityStatus {
    serviceplanactivitystatustypeid!: string;
    serviceplanactivitystatustypekey!: string;
    description!: string;
    activeflag!: number;
    effectivedate!: Date;
}
export class AddActivity {
    objecttypekey!: string;
    objectid!: string;
    activity!: string;
    servicetypekey!: string;
    servicesubtypekey!: string;
    personinvolved!: string;
    responsibleperson!: string;
    reevaluationdate!: string;
    completiondate!: string;
    serviceplangoalid!: string;
    serviceplanactivitystatustypekey!: string;
    serviceplanactivityid!: string;
    isAddEdit!: string;
    associatedworker: any;
}
export class DropdownModelActivityPersonInvloved {
    serviceplanactivityid!: string;
    objecttypekey?: string;
    objectid!: string;
    activity!: string;
    servicetypekey?: string;
    servicesubtypekey?: string;
    personinvolved!: string;
    responsibleperson!: string;
    reevaluationdate!: string;
    completiondate?: Date;
    serviceplangoalid!: string;
    serviceplanactivitystatustypekey!: string;
    activeflag!: number;
    effectivedate!: string;
}
export class Repeat {
    repeatdaytypekey!: string;
}

export class Occurence {
    starttime!: string;
    endtime!: string;
}

export class Exemption {
    exemptiondate!: string;
}

export class ServicePlanConfig {
    objecttypekey?: string;
    objectid!: string;
    serviceplanactivityid!: string;
    providerid!: string;
    startdate!: Date;
    enddate!: Date;
    isrepeats!: number;
    rate!: number;
    repeats: any[] = [];
    noofoccurence!: number;
    occurences: any[] = [];
    exemptions: any[] = [];
    reason!: string;
}

export class InvolvedPersonConfig {
    data!: InvolvedPerson[];
    count!: string;
}
export class InvolvedPerson {
    cjamspid?: string;
    totalcount!: string;
    rolename!: string;
    dcn!: null;
    personid!: string;
    firstname!: string;
    lastname!: string;
    gender!: string;
    dob!: Date;
    address!: string;
    phonenumber!: string;
    dangerous!: string;
    actorid!: string;
    intakeservicerequestactorid!: string;
    priorscount!: string;
    reported!: boolean;
    refusessn!: boolean;
    refusedob!: boolean;
    userphoto!: null;
    email!: string;
    roles!: RolesItem[];
    relationship!: string;
}
export class RolesItem {
    intakeservicerequestpersontypekey!: string;
    rolename!: string;
}

export class Providerinfo {
    providerid!: string;
    providercode!: string;
    providercategorytypekey!: string;
    providername!: string;
    prefix!: string;
    firstname!: string;
    middlename?: string;
    lastname!: string;
    provideraddresstypekey!: string;
    buildingno?: string;
    addressline1!: string;
    addressline2?: string;
    city!: string;
    countyid!: string;
    countyname!: string;
    state!: string;
    zipcode!: number;
    phonenumber?: string;
    phoneextension?: string;
    ismobile?: boolean;
    email?: string;
    providercontracttypekey?: string;
    providercontracttypename?: string;
    rate!: number;
    servicetypedescription!: string;
    servicesubtypedescription!: string;
    servicename!: string;
}

export class Ldss {
    securityusersid!: string;
    fullname!: string;
    email!: string;
    orgname?: string;
    orgnumber?: string;
    address?: string;
    city?: string;
    country?: string;
    county?: string;
    zipcode?: string;
    zipcodeplus?: string;
    phonenumber?: string;
    phoneextension?: string;
}

export class ServiceLog {
    serviceplanid!: string;
    objecttypekey?: any;
    objectid!: string;
    requestdate!: Date;
    servicereqid!: string;
    authorizationid!: string;
    fedid!: string;
    providerid!: string;
    providercontracttypekey?: string;
    providercontractrateid?: string;
    startdate!: Date;
    enddate?: Date;
    isrepeats!: number;
    noofoccurence!: number;
    reason!: string;
    serviceplanstatustypekey!: string;
    rate!: number;
    costestimate!: string;
    servicetypedescription!: string;
    servicesubtypedescription!: string;
    providerinfo!: Providerinfo;
    ldss!: Ldss;
    servicerequestnumber!: string;
    actortype!: string;
    clientname!: string;
    casename!: string;
    cisid!: string;
    clientid!: string;
    requestorname!: string;
    requestorphone?: string;
    requestorphoneextn?: string;
    amount!: number;
}

export class PurchaseAuthorization {
    routingstatus!: string;
    status!: number;
    fiscalcode!: string;
    fiscal_description!: string;
    costnot_exceed!: string;
    justification_text!: string;
    voucher_requested!: string;
    authorization_id!: string;
    service_log_id!: string;
    fiscal_category_cd!: string;
    cost_no!: number;
    fundingstatus!: string;
    paymentstatus!: string;
    startdt!: Date;
    enddt!: Date;
    dateofpreapproval!: Date;
    cfeCareDuration: any;
    final_amount_no!: number;
    client_account_no!: string;
    client_id!: number;
    client_account_id!: number;
    justification_tx!: string;
    reason_tx!: string;
    supervisorid: any;
}

export class ServiceLogApproval {
    fiscalcategorycd!: string;
    serviceLogId!: string;
    authorization_id!: string;
    intakeserviceid!: string;
    costno!: string;
    provider_id!: string;
    assignedtoid!: string;
    eventcode!: string;
    status!: number;
}

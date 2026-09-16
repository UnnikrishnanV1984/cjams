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
    goaltypekey!: string;
    description!: string;
    serviceplangoalid!: string;
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
    // services: ServicePlan[];
    // serviceplans: ServicePlan[];
    // services: ServicePlan[];
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
export class AsAddActivity {
    objecttypekey!: string;
    objectid!: string;
    activity!: string;
    servicetypekey!: string;
    activitysubtypekey!: string;
    personinvolved?: string;
    personsinvolvedid?: string;
    responsibleperson?: string;
    responsiblepersonid?: string;
    reevaluationdate!: string;
    completiondate!: string;
    serviceplangoalid!: string;
    serviceplanactivitystatustypekey!: string;
    serviceplanactivityid!: string;
    isAddEdit!: string;
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
    noofhours?: string;
    noofweeks?: string;
}

export class AsOccurence {
    noofhours?: number;
    noofweeks?: number;
}

export class Exemption {
    exemptiondate!: string;
}

export class ServicePlanConfig {
    objecttypekey?: string;
    objectid!: string;
    serviceplanactivityid!: string;
    providerid!: string;
    startdate: any;
    enddate: any;
    isrepeats!: number;
    rate!: number;
    repeats: any[] = [];
    noofoccurence!: number;
    occurences: any[] = [];
    exemptions: any[] = [];
    reason!: string;
    providertypekey!: string;
    familyworkername!: string;
    providertype!: string;
    providersubtype!: string;
    noofweeks!: number;
    noofhours!: number;
    categorysubtypekey!: string;
    servicecategorytypekey!: string;
    serviceplanvendorid!: string;
    securityusersid!: string;
}
export class FamliyService {
  startdate!: string;
  enddate!: string;
  reason!: string;
  rate!: string;
  isrepeats!: number;
  exemptions!: Exemptions[];
  noofweeks!: string;
  noofhours!: string;
  occurences!: any[];
  familyworkername?: any;
  objecttypekey!: string;
  objectid!: string;
  providerid?: any;
  serviceplanvendorid?: any;
  providertypekey!: string;
  repeats!: any[];
  serviceplanactivityid!: string;
  servicecategorytypekey!: string;
  categorysubtypekey!: string;
  providercontracttypekey!: string;
  countyid!: string;
  careworkername!: string;
  securityusersid?: any;
}
export class Exemptions {
    exemptiondate!: string;
}
export class Unmet {
    activity!: string;
    servicetypekey!: string;
    need!: string;
    otherservicetypedescription!: string;
    othersubtypedescription!: string;
    otherreason!: string;
    reasontypekey!: string;
    serviceunavailable!: string;
    activitysubtypekey!: string;
    personinvolved?: any;
    responsibleperson?: any;
    reevaluationdate?: any;
    completiondate?: any;
    serviceplangoalid?: any;
    serviceplanactivitystatustypekey?: any;
    objecttypekey!: string;
    objectid!: string;
}

export class UnmetList {
    totalcount!: string;
    serviceplanactivityid!: string;
    objecttypekey!: string;
    objectid!: string;
    activity!: string;
    servicetypekey!: string;
    need!: string;
    otherservicetypedescription!: string;
    othersubtypedescription!: string;
    otherreason!: string;
    reasontypekey!: string;
    servicetypedescription!: string;
    servicesubtypekey?: any;
    servicesubtypedescription?: any;
    serviceplanactivitystatustypekey?: any;
    activitysubtypekey!: string;
    activitysubtypedescription!: string;
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

export class AsServicePlanActivity {
    servicetypekey!: string;
    teamtypekey!: string;
    activeflag!: boolean;
    sequencenumber!: number;
    servicetypedescription!: string;
    shortname!: string;
    sortseq!: boolean;
    old_id!: string;
    effectivedate!: Date;
    expirationdate!: Date;
    activitysubtypedescription!: string;
    serviceplanactivityid!: string;
    objectid!: string;
    services!: ServicePlanConfig[];
}

export class AssignedActivity {
    totalcount!: number;
    servicereqid!: string;
    servicerequestnumber!: string;
    servreqtype!: string;
    servreqsubtype!: string;
    reporteddate!: Date;
    raname!: string;
    servreqstatus!: string;
    routedon!: string;
    assignedto!: string;
    assigned!: boolean;
    // dadetails: Dadetails;
    // dadetails: Dadetails;
    isgroup!: boolean;
    incidentlocation!: string;
    isCollapsed?: boolean;
    acceptdate!: Date;
    intakeserviceid!: string;
    intakenumber?: string;
    assistid!: string;
    cjamspid!: string;
    youth!: string;
    casecondtions: any;
    offencecounty!: any[];
    // sdm: SDM[];
    appevent?: string;
}
export class ReviewCase {
    totalcount!: string;
    servicerequestnumber!: string;
    intaserviceid!: string;
    services!: Service[];
}

export class Service {
    serviceplanlogid!: string;
    objecttypekey!: string;
    objectid!: string;
    serviceplanactivityid!: string;
    activity!: string;
    personinvolved!: string;
    activitysubtypekey!: string;
    completiondate?: string;
    serviceplanactivitystatustypekey!: string;
    startdate!: string;
    enddate!: string;
    isrepeats!: number;
    noofoccurence!: number;
    reason!: string;
    serviceplanlogstatustypekey?: any;
    familyworkername?: string;
    vendorname?: string;
    servicetypedescription!: string;
    description!: string;
    countyname!: string;
}

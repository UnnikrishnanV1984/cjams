export class IntakeSummary {
    totalcount!: number;
    id!: number;
    intakenumber!: number | undefined | null;
    datereceived!: Date;
    timereceived!: Date;
    narrative!: string;
    raname!: string;
    entityname!: string;
    cruworkername!: string;
    isreview: boolean = false;
    issupervisor: boolean = false;
    datesubmitted!: Date;
    dateclosed!: Date;
    remarks!: string;
    timeleft!: string;
    timeelapsed: boolean = false;
    sdm: SDM[] = [];
    datereceivedeststr!: string;
    jsondata: any;
    purpose: any;
    reviewstatus: any;
    youthcjamspid: any;
    youthname: any;
    isprior: any;
    receivingcountyname: any;
    transferreason: any;
    reporteddatetime: any;
    headofhousehlod: any;
    hoh_name: any;
    sendingcountyname: any;
    requestorname: any;
    transferdate: any;
}

export class SDM {
    ischildfatality: boolean = false;
    ismaltreatment: boolean = false;
}
export class AssignedCase {
    totalcount!: number;
    servicereqid!: string;
    servicecaseid!: string;
    servicecasenumber!: string;
    servicerequestnumber!: string;
    statustypekey!: string;
    adoptionreqid!: string;
    adoptioncaseid!: string;
    adoptioncasenumber!: string;
    adoptionrequestnumber!: string;
    servreqtype!: string;
    servreqsubtype!: string;
    adoptionplanningid!: string;
    reporteddate!: Date;
    startdate!: Date;
    raname!: string;
    servreqstatus!: string;
    routedon!: string;
    assignedto!: string;
    assigneddate!: string;
    assigned: boolean = false;
    dadetails!: Dadetails[];
    isgroup: boolean = false;
    incidentlocation!: string;
    isCollapsed!:  boolean;
    acceptdate!: Date;
    intakeserviceid!: string;
    intakenumber!: string;
    assistid!: string;
    cjamspid!: string;
    youth!: string;
    casecondtions: any;
    offencecounty: any[] = [];
    sdm: SDM[] = [];
    appevent!:  string;
    objectid!:  string;
    typename!:  string;
    intakeservreqtypekey!:  string;
    client_id!: string;
    permanencyplanid!:  string;
    service_log_id!:  any;
    entityid!: string;
    eventdescription!: string;
    datesubmitted!: Date;
    datereceived!: Date;
    cruworkername!: string;
    youthcjamspid: any;
    youthname: any;
    finalfindings: any;
    assignbtn: any;
    appealconame: any;
    placementfostercareapprove: any;
    legalguardian: any;
}

export class ReviewGridModal {
    totalcount!: number;
    servicereqid!: string;
    servicerequestnumber!: string;
    servreqtype!: string;
    servreqsubtype!: string;
    reporteddate!: Date;
    raname!: string;
    servreqstatus!: string;
    submitteon!: Date;
    submitteduser!: string;
    isgroup: boolean = false;
    commets!: string;
    dadetails!: string;
    intakenumber!:  string;
    sdm: SDM[] = [];
}

export class Dadetails {
    assignedon!: string;
    assingeduser!: string;
    classkey!: string;
    clientname!: string;
    intakeserreqstatustypekey!: string;
    intakeserviceid!: string;
    intakeservreqtypekey!: string;
    isrouted: boolean = false;
    reporteddate!: string;
    routeddate!: string;
    servicerequestnumber!: string;
}
export class RoutingUser {
    userid!: string;
    teamname!: string;
    workloads!: string;
    username!: string;
    agencykey!: string;
    userrole!: string;
    loadnumber!: string;
    email!: string;
    available!: string;
    issupervisor: boolean = false;
    zipcode!: number;
    worklocationcode!: string;
    homelocationcode!: string;
    totalcases!: number;
    rolecode!: string;
    cjamspid: any;
    juridiction: any
}

export class ChildList {
    isassignment!: number;
    intakeservicerequestactorid!: string;
    firstname!: string;
    lastname!: string;
    personid!: string;
    isselected!: string;
}

export class AssignedPerson {
    caseworker_name!: string;
    loadnumber!: string;
    teamname!: string;
}
export class BroadCostMessage {
    userannouncementid!: string;
    details!: string;
    isaccepted: boolean = false;
}

export class PreIntakeAssign {
    canreopen!: number;
    totalcount!: number;
    id!: number;
    intakenumber!: string;
    datereceived!: Date;
    timereceived!: Date;
    narrative!: string;
    raname!: string;
    entityname!: string;
    cruworkername!: string;
    isreview: boolean = false;
    issupervisor: boolean = false;
    datesubmitted!: Date;
    dateclosed!: Date;
    remarks!: string;
    reviewstatus!: string;
    disposition!: string;
    intakestatus!: string;
    timeleft!: string;
    jsondata: any;
}
export class Appeal {
    intakenumber!: string;
    appealdate!: Date;
    appealstatus!: string;
    remarks!: string;
    activeflag!: number;
}
export class ReviewCase {
    intakeserviceid!: string;
    servicerequestnumber!: string;
    intakenumber!: string;
    intakeservreqtypekey!: string;
    classkey!: string;
    reporteddate!: string;
    clientname!: string;
    asssignedon!: string;
    assingeduser!: string;
    remarks!: string;
    typename!: string;
    appevent!: string;
    sdm: SDM[] = [];
    cjamspid: any;
    raname: any;
}

export class Servicecas {
    intakeserviceid!: string;
    casenumber!: string;
    intakenumber!: string;
    servicetype!: string;
    dasubtype!: string;
    role!: string;
    datecreated!: Date;
    dateclosed!:  any;
    subservice: any;
}

export class Cpsfinding {
    intakeserviceid!: string;
    casenumber!: string;
    intakenumber!: string;
    servicetype!: string;
    dasubtype!: string;
    datecreated!: Date;
    dateclosed!:  any;
    role: any;
    subservice: any;
}

export class Prior {
    personid!: string;
    firstname!: string;
    lastname!: string;
    dob!: Date;
    gendertypekey!: string;
    dateofdeath!:  any;
    cjamspid!: number;
    role!: string;
    servicecases: Servicecas[] = [];
    cpsfindings: Cpsfinding[] = [];
}

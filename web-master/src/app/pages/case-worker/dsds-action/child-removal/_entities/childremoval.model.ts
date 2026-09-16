export class ChildRemoval {
    intakeserviceid!: string;
    fathername!: string;
    mothername!: string;
    rmvdfrmpersonname!: string;
    removalreason!: RemovalReason[];
    removaladd1!: string;
    removaladd2!: string;
    removalzip!: string;
    removalstatecd!: string;
    removalcity!: string;
    attachment: any;
    familystructuretypekey!: string;
    primarycaregiverid!: string;
    vpabegindate!: Date;
    vpaparentssigneddate!: Date;
    agencysigneddate!: Date;
    isbothparentssigned!: string;
    reasonableeffortsmade!: string;
    childfactorsentry!: string;
    removaltypekey!: string;
    primarycaregiveractorid!: string;
}

export interface ChildRemovalList {
    intakeservreqchildremovalid: string;
    intakeserviceid: string;
    agencytypekey?: any;
    fathername: string;
    mothername: string;
    rmvdfrmpersonname: string;
    removalreasontypeid: string;
    removaladd1: string;
    removaladd2: string;
    removalzip: string;
    removalstatecd: string;
    removalcity: string;
    activeflag: number;
}

export class RemovalReason {
    removalreasontypeid!: string;
    removalreasontypekey!: string;
}

    export interface Role {
        intakeservicerequestpersontypekey: string;
        intakeservicerequestactorid?: string;
    }

    export interface NotificationRole {
        rolename: string;
        dcn?: any;
        personid: string;
        firstname: string;
        lastname: string;
        gender: string;
        dob?: any;
        address?: any;
        address2?: string;
        phonenumber: string;
        dangerous: string;
        actorid: string;
        intakeservicerequestactorid: string;
        priorscount: string;
        reported: boolean;
        refusessn: boolean;
        refusedob: boolean;
        userphoto?: any;
        email: string;
        roles: Role[];
        relationship: string;
        notificationlog: NotificationLog;
    }

    export class EmailNotification {
        objectid?: string;
        objecttypekey?: string;
        intakeserviceid?: string;
        personid?: string;
        userid?: string;
        relationship?: string;
        email!: string;
        firstname?: string;
        lastname?: string;
        message?: string;
        ismailsent?: boolean;
    }



        export class Schoolname {
            educationname!: string;
        }
        export class ChildRoles {
            totalcount!: string;
            firstname!: string;
            lastname!: string;
            dob!: Date;
            roles!: Role[];
            relationship?: string;
            ishousehold?: boolean;
            iscollateralcontact?: boolean;
            schoolname!: Schoolname[];
            personid!: string;
            gender!: string;
            race!: string;
        }
export class PlacementProvider {
    totalcount!: number;
    childname!: string;
    dob!: Date;
    placementtype!: string;
    placedatetime!: Date;
    placeenddatetime!: Date;
    placementinformation!: string;
    status!: string;
    placementid!: string;
    role!: string;
    providerinfo!: Providerinfo;
}

export class Providerinfo {
    providername!: string;
    addressline1!: string;
    addressline2!: string;
    email!: string;
    work!: string;
    fax!: string;
    ext!: string;
    zipcode!: number;
    phonenumber!: Phonenumber[];
    county!: string;
    city!: string;
    state!: string;
}
export class Phonenumber {
    phonenumber!: number;
    providercontactinfotypekey!: string;
}

export class RoutingUserList {
    caseworkerdetails!: CaseworkerDetail[];
    supervisordetails!: SupervisorDetail[];
}


export class CaseworkerDetail {
    caseworkername!: string;
    email!: string;
    address!: string;
    zipcode!: number;
    city!: string;
    state!: string;
    userprofiletypekey!: string;
    phonenumber!: number;
}

export class SupervisorDetail {
    supervisorname!: string;
    email!: string;
    address!: string;
    zipcode!: number;
    city!: string;
    state!: string;
    userprofiletypekey!: string;
    phonenumber!: number;
}
export class NotificationLog {
    ismailsent!: number;
    message!: string;
}

export class NotificationUser {
    childInfo!: string;
    parentInfo: string[] = [];
    parent!: Parent[];
    courtInfo!: string;
    caseworker!: string;
    supervisor!: string;
    providerInfo!: string;
    attorneyInfo!: string;
}
export class Parent {
    role!: string;
    address!: string;
}
export class AssessmentInfo {
    courtaddress1!: string;
    courtaddress2!: string;
    courtcity!: string;
    courtcounty!: string;
    courtstate!: string;
    courtzip!: string;
    courthearingdatatime!: Date;
}

export class JudicialDetermination {
    judicialFlag!: string;
    clientId!: string;
    ctwsanctioningchildremoval!: string;
    childphysicalremovaldate!: string;
    petitionfiledate!: string;
    dateofremovalcourthearing!: string;
    magistrateorjudgename!: string;
    judgesigned!: string;
    ctwdecision!: string;
    dateoffindingctwdecision!: string;
    hearingdate!: string;
    whoisresponsibleforplacementandcare!: string;
    nameofsubjectctwfinding!: string;
    clientidofsubjectctwfinding!: string;
    relationshipofsubjectctwfinding!: string;
    physicalremovalafterdetermination!: string;
    removalcourtorderdate!: string;
    childphysicalremovaladdress!: string;
    courtorderdelayremoval!: string;
    courtorderdelaytimeframe!: string;
    childphysicaladdressafterremoval!: string;
    specifiedrelativephysicaladdressafterremoval!: string;
    specifiedrelativename!: string;
    specifiedrelativeclientid!: string;
    specifiedrelativedatechildlastlivedwith!: string;
    specifiedrelativephysicaladdress!: string;
    specifiedrelativerelationshipid!: string;
    dateofreasonableeffortscourthearing!: string;
    reasonableeffortsmade!: string;
    reasonableEffortsnotnecessaryduetoemergentcircumstances!: string;
    sheltergranted!: string;
}

export interface VoluntaryPlacement {
    vpaFlag: string;
    clientId: string;
    typeofvpa: string;
    eavpaagreementflag: string;
    vpaparentssigneddate: string;
    parent2signeddate: string;
    dateofguardiansignatureonvpa: string;
    primarycaregiverid: string;
    dateofchildsignatureonvpa: string;
    vpadsssigneddate: string;
    vpabegindate: string;
    mandatorynoteonmissing2ndparentsignatureonvpa: string;
    entry_dt: string;
    nameofsubjectctwfinding: string;
    clientidofsubjectctwfinding: string;
    relationshipofsubjectctwfinding: string;
    childphysicalremovaladdress: string;
    childphysicaladdressafterremoval: string;
    specifiedrelativephysicaladdressafterremoval: string;
}

export class ServiceCase {
    isavailable!: number;
    data!: ServiceCaseData[];
}
export class ServiceCaseData {
    servicecaseid!: string;
    servicecasenumber!: string;
    legalguardian?: string;
    startdate!: Date;
    statustypekey!: string;
    enddate?: Date;
    ishouseholdmember!: number;
}
export class CreateCase {
    intakeserviceid!: string;
    servicecaseid?: string | null;
    isnewcase!: number;
}

export interface SharedChildData {
    isNulEndDatPhonNumb: boolean;
    isNulEndDatEmail: boolean;
    age: number;
    dod: string;
    emailIds: any[];
    phoneNumbers: any;
}
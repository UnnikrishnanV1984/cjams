export class PetitionDetails {
    intakeservicerequestpetitionid?: string;
    intakeservicerequestid!: string;
    intakenumber!: string;
    petitionid!: string;
    associatedattorneys!: string;
    complaintid!: string;
    transferpetitionid!: string;
    petitionfiled!: boolean;
    hearingdatetime!: string;
    hearingtypekey!: string;
    hearingnotes!: string;
    hearingDate!: string;
    hearingTime!: string;
    typeofpetitiontypekey!: string;
    petitionname!: string;
    petitiontypekey!: string;
    focusname?: string[];
    petitionfocusname!: string;
    servicecaseid?: string;
    [key: string]: any;
}
export class CourtDetails {
    intakeservicerequestpetitionid?: string;
    legalcounselname!: string;
    magistratename!: string;
    workername!: string;
    hearingdatetime!: string;
    courtactiontypekey!: string;
    courtordertypekey!: string;
    courtorderdatetime!: string;
    conditiontypekey!: string;
    conditiontypedescription!: string;
    conditiontypecompletiondatetime!: string;
    terminationdatetime!: string;
    adjudicationdatetime!: string;
    adjudicationdecision!: string;
    allegationid!: string;
    intakeservicerequestid!: string;
    adjudicationDate!: string;
    adjudicationTime!: string;
    hearingDate!: string;
    hearingTime!: string;
    terminationDate!: string;
    terminationTime!: string;
    orderDate!: string;
    orderTime!: string;
    completionDate!: string;
    completionTime!: string;
    courtaction!: CourtAction[];
    hearingdetails!: any[];
    courtorder!: CourtOrder[];
    courtcondition!: ConditionType[];
}

export class CourtAction {
    courtactiontypekey!: string;
}

export class CourtOrder {
    courtordertypekey!: string;
}

export class ConditionType {
    conditiontypekey!: string;
}

export class PetitionList {
    petitionid!: string;
    associatedattorneys!: string;
    petitiontypekey!: any;
    intakeservicerequestpetitionid?: string;
    actordetails!: PetitionActor[];
    petitiondate?: any;
    clientActordetails: any;
    parentdetails?:any;
}

export class PetitionActor {
    intakeservicerequestpetitionid!: string;
    intakeservicerequestactorid!: string;
    intakeservicerequestactor!: Actor;
    clientActordetails: any;
}

export class Actor {
    intakeservicerequestactorid!: string;
    personid!: string;
    person!: Person;
}

export class Person {
    firstname!: string;
    lastname!: string;
    personid!: string;
    suffix: any;
    middlename: any;
    prefix: any;
}

export class CourtOrderList {
    intakeservreqcourtorderid!: string;
    intakeservicerequestpetitionid!: string;
    courtorderdate!: string;
    hearingoutcome?: any;
    hearingoutcometypekey!: string;
    hearingoutcomedesc!: string;
    status?: string;
    courtdetails!: CourtOrderDetail[];
    comments?: string;
    childpermanencyplankey?: string;
    attachments?: any[];
    intakeservicerequesthearingid!: string;
    intakeservicerequestactorid: any;
    personid!: string;
    dob!: string;
    otherpersonsappeared!: string;
}

export class CourtOrderAdd {
    intakeservreqcourtorderid?: string;
    intakeservicerequestpetitionid!: string;
    intakeserviceid!: string;
    courtorderdate!: Date;
    hearingoutcometypekey!: string;
    hearingoutcome: any;
    courtorderdelayremoval!: boolean;
    courtorderdelaytimeframe!: number;
    courtordercopp!: CourtOrderCoppLag[];
    courtordercolang!: CourtOrderCoppLag[];
    courtordercoho!: CourtOrderCoppLag[];
    intakeservreqcourtorderdetails!: CourtOrderDetail[];
    remarks!: string;
    childpermanencyplankey: any;
    attachment!: any[];
    removalepisode!: string;
}
export class CourtOrderDetail {
    intakeservreqcourtorderdetailsid?: string;
    intakeservreqcourtorderid?: string;
    checklistid!: string;
    checklisttypekey!: string;
    isselected!: number;
    remarks!: string;
    checklistname?: string;
    checklistdesc?: string;
}

export class Checklist {
    checklistid!: string;
    name!: string;
    description!: string;
    checklisttypekey!: string;
    activeflag!: number;
    effectivedate!: Date;
    expirationdate!: Date;
    oldId!: string;
    isselected?: boolean;
    remarks?: string;
    isRequired?: boolean
}
export class CourtOrderCoppLag {
    checklistid!: string;
    description!: string;
    isselected!: string;
    checklisttypekey!: string;
    remarks!: string;
}
export class HearingClientDetails {
    personid!: string;
    casenumber!: string;
    clientname!: string;
    hearingclientid!: string;
    otherclientflag!: number;
    annualnoticebenefitdt!: Date;
    intakeservicerequestactorid!: string;
}
export class HearingDetails {
    [key: string]: any;
    hearingdatetime!: string;
    hearingtypekey!: string;
    hearingstatustypekey!: string;
    hearingnotes!: string;
    intakeservicerequestcourthearingid!: string;
    hearingclientdetails!: HearingClientDetails[];
}
export class PersonDteails {
    actordetails!: PetitionActor[];
}

export class Qrtpcourtorder{
    
            county!: string;
            clientname!: string;
            casenumber!: string;
            dob!: string;
            courtorderdate!: string;
            intakeservicerequesthearingid!: string;
            intakeservicerequestactorid: any;
            personAppeared!: any[];
            courtreview!: string;
            intakeserviceid!: string;
            childsneed!: string;
            childneedcantmet!: string;
            childpermanencyplan!: string;
            qrtpapproval!: string;
            qrtpapprovaldecision!: string;
            servicecaseid!: string;
            intakeservicerequestpetitionid!: string;
            clientDetails!: any[];
            bulkHearing!: any[];
        }


export class DispositionListModal {
    seenwithin!: string;
    dateseen!: string;
    edl!: boolean;
    financial!: boolean;
    jointinvestigation!: boolean;
    investigationsummary!: string;
    duedate!: Date;
    completiondate!: Date;
    statusid!: string;
    dispositionid!: string;
    visitinfo!: string;
    statusdate!: Date;
    dispositionstatus?: string;
    istaskclosed?: boolean;
    isgoalclosed?: boolean;
}

export class DispositionAddModal {
    disposition!: Disposition;
    investigation!: Investigation;
}
export class Investigation {
    summary!: string;
    filelocdesc!: string | null;
    appevent!: string;
}
export class Disposition {
    intakeserviceid?: string;
    servicecaseid?: string;
    adoptioncaseid?: string;
    description!: string;
    intakeserreqstatustypeid?: string;
    intakeserreqstatustypekey?: string;
    dispostionid?: string;
    dispositioncode!: string;
    seenwithin!: Date;
    dateseen!: Date;
    reviewcomments?: string;
    comments?: string;
    intakeservtypekey?: string;
    reqforservstatus?: string;
    reqforservdispostion?: string;
    programtype?: string;
    receiveddate?: Date;
    assignsecurityuserid?: Date;
    notifymsg!: string;
}

export class General {
    reporteddate!: Date;
    servicerequestnumber!: string;
    narrative!: string;
    actiontype!: string;
    sdmdate!: Date;
    supervisorname!: string;
    caseworkername!: string;
    caseworkeraddress?: string;
    caseworkerzipcode?: string;
    caseworkercounty?: string;
    caseworkerphoneno!: number;
}

export class InjuryType {
    injurytypekey!: string;
    injury!: string;
}

export class MaltreatmentCharactersticsTypekey {
    maltreatmentcharactersticstypekey!: string;
    characterstics!: string;
}

export class InjuryCharactersticsType {
    injurycharactersticstypekey!: string;
    investigationallegationactorid!: string;
    injurycharacterstics!: string;
}

export class InvestigationAllegation {
    investigationallegationid!: string;
    maltreatmentid!: string;
    allegationid!: string;
    sextrafficking?: number;
    enddate?: Date;
    isapproximatedate?: number;
    timeofincidence?: Date;
    incidentlocationtypekey?: string;
    name?: string;
    indicators?: any;
    comments!: string;
    injurycomments!: string;
    incidentdate!: Date;
    maltreators?: Maltreator[];
    injurytype!: InjuryType[];
    maltreatmentcharactersticstypekey!: MaltreatmentCharactersticsTypekey[];
    injurycharactersticstype!: InjuryCharactersticsType[];
    findings!: string;
}
export class Finding {
    findingtype!: string;
}
export class Maltreator {
    dob!: Date;
    intakeservicerequestactorid!: string;
    personname!: string;
    relationship!: string;
    role!: string;
}
export class Maltreatment {
    intakeservicerequestactorid!: string;
    maltreatmentid!: string;
    householdkey!: string;
    isjurisdiction!: number;
    countyid!: string;
    personid!: string;
    incidentlocationtypekey?: string;
    personname!: string;
    investigationallegation!: InvestigationAllegation[];
    gendertypekey?: string;
    dob?: Date;
    incidentlocation?: string;
    address?: string;
}

export class Reason {
    description!: string;
}

export class ChildRemoval {
    insertedon!: Date;
    address!: string;
    removedfrom?: string;
    reason!: Reason[];
}

export class Assessment {
    name!: string;
    assessmentstatustypekey!: string;
    ischildsafe!: boolean;
    insertedon!: Date;
    updatedon!: Date;
    titleheadertext!: string;
}

export class AssessmentContactNotes {
    contactdate!: Date;
    description!: string;
    progressnotetypekey!: string;
    progressreasonnote!: string;
}

export class InvestigationSummary {
    general!: General[];
    maltreatment!: Maltreatment[];
    childremoval!: ChildRemoval[];
    assessment!: Assessment[];
    assessmentcontactnotes!: AssessmentContactNotes[];
    l_serviceplanrate?: Rate[];
    inv_summary?: any;
    serviceplan?: any;
    l_serviceplangoal!: any[];
}

export class Rate {
    rate!: number;
    servicetsubtypename!: string;
}

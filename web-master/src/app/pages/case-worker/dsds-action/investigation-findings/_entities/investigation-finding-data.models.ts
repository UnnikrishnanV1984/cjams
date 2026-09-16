export class InvestigationFinding {
    maltreatmentid!: string;
    householdkey!: string;
    isjurisdiction!: number;
    countyid!: string;
    incidentlocationtypekey!: string;
    roles!: string;
    personid!: string;
    personname!: string;
    jointinvestigation!: boolean;
    investigationsummary!: string;
    investigationallegationid!: string;
    allegationid!: string;
    name!: string;
    enddate!: Date;
    comments!: string;
    notes!: string;
    injurycomments!: string;
    incidentdate!: string;
    sextrafficking!: number;
    maltreators!: Maltreators[];
    findings!: Findings[];
    injurytype!: Injurytype[];
    maltreatmentcharacterstics!: Maltreatmentcharacterstics[];
    injurycharacterstics!: Injurycharacterstics[];
    victim_explanation!: string;
    sibling_explanation!: string;
    guardian_explanation!: string;
    maltreator_explanation!: string;
    med_assessmnts!: string;
    expert_assessmnts!: string;
    collateral_interviews!: string;
    home_conditions!: string;
}
export class Findings {
    findingcomments!: string | null | undefined;
    harmdesc!: string | null| undefined;
    intentionalinjurydesc!: string | null| undefined;
    investigationfindingtypekey!: string | null| undefined;
    isharm!: number | null| undefined;
    isharmsubstantial!: number | null| undefined;
    omissiondesc?: string;
    firstname?: string;
    lastname?: string;
    assessorcomments?: string;
    caseworkercomments?: string;
    finalfinding?: string;
    typedescription?: string;
    professiontypekey?: string;
    isassessor?: string;
    assessors?: Assessors[] = [];
    isfindingassessor!: boolean;
    securityusersid!: string;
}

export class Maltreators {
    intakeservicerequestactorid!: string;
    displayname!: string;
    relationship!: string;
    personid!: string;
}

export class Injurytype {
    injurytypekey!: string;
    typedescription!: string;
}
export class Maltreatmentcharacterstics {
    maltreatmentcharactersticstypekey!: string;
    typedescription!: string;
}
export class Injurycharacterstics {
    injurycharactersticstypekey!: string;
    typedescription!: string;
}
export class Indicators {
    indicatorid!: string;
    indicatorname!: string;
}

export class InvestigationFindingType {
    investigationfindingtypeid!: string;
    investigationfindingtypekey!: string;
    description!: string;
    activeflag!: number;
}

export class InvestigationFindings {
    intentionalinjurydesc!: string;
    findingcomments!: string;
    investigationfindingtypekey!: string;
    isharm!: number;
    isharmsubstantial!: number;
    harmdesc!: string;
    firstname?: string;
    lastname?: string;
    assessorcomments?: string;
    caseworkercomments?: string;
    typedescription?: string;
    professiontypekey?: string;
    isassessor?: string;
}

export class SubmitForReview {
    investigationid!: string;
    maltreatmentid!: string;
    summary!: string;
    jointinvestigation!: boolean;
    notes!: string;
    allegedperson!: Allegedperson[];
}

export class Allegedperson {
    personid!: string;
    investigationallegationid!: string;
    investigationfindings?: InvestigationFindings[] = [];
    name?: string;
    intentionalinjurydesc?: string;
    findingcomments?: string;
    investigationfindingtypekey?: string;
    isharm?: number;
    isharmsubstantial?: number;
    harmdesc?: string;
    sextrafficking?: number;
    omissiondesc?: string;
    assessors?: Assessors[] = [];
    firstname?: string;
    lastname?: string;
    assessorcomments?: string;
    caseworkercomments?: string;
    typedescription?: string;
    professiontypekey?: string;
    isassessor?: string;
    isfindingassessor!: boolean;
    securityusersid!: string;
    ischildfatality?: number;
    fatalitycomments?: string;
    showfatality?: boolean;
    victim_explanation?: string;
    sibling_explanation?: string;
    guardian_explanation?: string;
    maltreator_explanation?: string;
    med_assessmnts?: string;
    expert_assessmnts?: string;
    law_enforcement_inv?: string;
    collateral_interviews?: string;
    criminal_history_inv?: string;
    home_conditions?: string;
    expert_assessmnts_attachment?: any;
    med_assessmnts_attachment?: any;
    law_enforcement_attachment?: any;
}
export class Assessors {
    firstname!: string;
    lastname!: string;
    assessorcomments?: string;
    caseworkercomments?: string;
    typedescription!: string;
    professiontypekey!: string;
    isassessor!: string;
    comments?: string;
}

export class InvestigationComar {
    investigationfinding!: InvestigationFinding;
    involvedPerson!: InvolvedPerson[];
    maltreatmentkey!: string;
    isInitialLoad!: boolean;
    displayMode!: string;
}

export class InvolvedPerson {
    rolename!: string;
    dcn?: string;
    personid!: string;
    firstname!: string;
    lastname!: string;
    gender!: string;
    dob?: Date;
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
    roles!: Role[];
    school!: PersonEducationInfo[];
    relationship?: string;
    stateid!: string;
    ishousehold!: number;
    dateofdeath?: Date;
}
export class Role {
    intakeservicerequestpersontypekey!: string;
    typedescription!: string;
    intakeservicerequestactorid?: string;
}
export class PersonEducationInfo {
    currentgradetypekey!: string;
    educationname!: string;
    typedescription!: string;
}

export class PersonComar {
    victimname!: string;
    caretakername!: string;
    victimdob!: Date | null | undefined;
}

export class ProfessionType {
    professiontypeid!: string;
    professiontypekey!: string;
    typedescription!: string;
    activeflag!: number;
    old_id!: string;
}

export class CheckList {
    taskname!: string;
    status!: string;
    displayname?: string;
    isvalid?: number;
    shownoshow!: string;
}
export class InjuryCharacterstics {
    injurycharactersticstypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate?: Date;
    displayorder!: number;
}

export class MaltreatmentCharacterstics {
    maltreatmentcharactersticstypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate?: Date;
    displayorder!: number;
}
export class InjuryType {
    injurytypekey!: string;
    activeflag!: number;
    datavalue!: number;
    editable!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate?: Date;
    displayorder!: number;
}
export class MaltreatmentType {
    allegationid!: string;
    name!: string;
}
export class HouseHoldType {
    displayorder!: number;
    householdtypeid!: string;
    householdtypekey!: string;
    activeflag!: number;
    typedescription!: string;
    effectivedate!: string;
    expirationdate?: Date;
}
export class Indicator {
    indicatorid!: string;
    indicatorname!: string;
    case?: string;
}

export class Injurytype {
    injurytypekey!: string;
}

export class Maltreatmentcharactersticstypekey {
    maltreatmentcharactersticstypekey!: string;
}

export class Injurycharactersticstype {
    injurycharactersticstypekey!: string;
}

export class Investigationallegation {
    incidentdate!: Date;
    investigationallegationid!: string;
    maltreatmentid!: string;
    allegationid!: string;
    relationshiptypekey!: string;
    name!: string;
    indicators?: string;
    indicator!: Indicator[];
    injurytype!: Injurytype[];
    investigationalegationstatuskey!: string;
    maltreatmentcharactersticstypekey!: Maltreatmentcharactersticstypekey[];
    injurycharactersticstype!: Injurycharactersticstype[];
    providermaltreatment!: ProviderMaltreatment[];
    outcome!: string;
    maltreators?: any[];
    auditinfo!: any[];
}

export class MaltreatmentInformation {
    maltreatmentid!: string;
    isjurisdiction!: string;
    countyid?: string;
    personid!: string;
    personname!: string;
    incidentlocationtypekey!: string;
    investigationallegation!: Investigationallegation[];
    actorid? : string;
    intakeservicerequestactorid?: string;
    jurisdictionuser!: Jurisdictionuser[];
    roles!: Roles[];
    isreported?: string;
    relationship?: string;
}
export class Roles {
    role!: string;
    username!: string;
}

export class Jurisdictionuser {
    role!: string;
    name!: string;
}

export class Maltreatment {
    person!: MaltreatmentInformation[];
}

export class Maltreator {
    maltreatoractorid: string | null | undefined;
    indicatorname?: string;
    othermaltreator?: string;
}

export class Areaofinjury {
    injurytypekey!: string;
}

export class Injurycharactertic {
    injurycharactersticstypekey!: string;
}

export class Maltreatmentcharacterstic {
    maltreatmentcharactersticstypekey!: string;
}

export class AddMaltreatment {
    allegationid!: string;
    investigationid!: string;
    isjurisdiction!: string;
    countyid!: string;
    allegationname!: string;
    comments!: string;
    injurycomments!: string;
    incidentdate!: string;
    personid!: string;
    intakeservicerequestactorid!: string;
    maltreators!: Maltreator[];
    areaofinjury!: Areaofinjury[];
    injurycharactertics!: Injurycharactertic[];
    maltreatmentcharacterstics!: Maltreatmentcharacterstic[];
    maltreatmentid!: string | null;
    investigationallegationid!: string | null;
    enddate!: Date;
    isapproximatedate!: string;
    timeofincidence!: string | null;
    sextrafficking!: string;
    incidentlocationtypekey!: string;
    jurisdictionuser: Jurisdictionuser[] = [];
    providermaltreatment!: ProviderMaltreatment[];
    providerMaltreatmentItems!: any[];
    isproviderinvolved: any;
    isnotapplicable: any;
    notapplicablecomments!: string;
    objectid!: string;
    objecttype!: string;
    providername!: string;
    providerid!: number;
    explainReason: any;
    explainReasonList: any;
    oldprovider: any;
    linkschidresid!: boolean;
    intakesdmid: any;
}

export class ProviderMaltreatment {
    providermaltreatmenttypekey!: string;
    typedescription?: string;
}
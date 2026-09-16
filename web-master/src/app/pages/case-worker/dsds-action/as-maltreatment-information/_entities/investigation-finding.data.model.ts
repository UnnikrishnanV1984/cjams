
    export class CountyDetail {
    isSelected = false;
    countyid!: string;
    activeflag!: 1;
    countyname!: string;
    regionid!: string;
    statecountycode!: string;
    fipscode!: number;
    oldcountyid!: string;
    insertedby!: string;
    updatedby!: string;
    expirationdate!: string;
    effectivedate!: string;
    longitude!: DoubleRange;
    latitude!: DoubleRange;
    state!: string;
    apsregion!: number;
    ltcregion!: number;
    zipcode!: number;
    city!: string;
    locationcode!: string;
}

export class IncomeDetail {
    category!: string;
    source!: string;
    clientIncome!: string;
    spouseIncome!: string;
}

export class AssetDetail {
    category!: string;
    source!: string;
    totalValue!: string;
}

export class Investigationfindingtypeperson {
    intakeservicerequestactorid!: string;
    invesfindingpersonname!: string;
    invsfindingpersonsupporttype!: string;
    invesfindingpersondesc!: string;
    investigationfindingpersontype!: string;
    personname!: string;
}

export class Investigationfindingguardian {
    intakeservicerequestactorid!: string;
}

export class InvestigationFinding {
    investigationfindingid?: any;
    intakeserviceid!: string;
    invsfindingjurisdiction!: string;
    invsfindingaddress!: string;
    investigationfindingdate!: string;
    socialhistorydesc!: string;
    familyhistorydesc!: string;
    educationalfactors!: string;
    psychiatricdesc!: string;
    psychiatricimportinfo!: string;
    financialimportinfo!: string;
    assetdetailsdesc!: string;
    legalinfopoa!: string;
    legalinforeppayee!: string;
    legalinfocourtinvolved!: string;
    legalinfodesc!: string;
    clentcapacitydesc!: string;
    reasonclosingdesc!: string;
    apsworkersigndate!: string;
    supervisorsigndate!: string;
    investigationfindingtypeperson!: Investigationfindingtypeperson[];
    investigationfindingguardian!: Investigationfindingguardian[];
}

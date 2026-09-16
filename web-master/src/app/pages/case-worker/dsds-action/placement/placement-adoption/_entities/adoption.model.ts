export class Tprlist {
    tprrecommendationid?: any;
    isrecommended?: any;
    remarks?: any;
    reasontypekey?: any;
    checklistid!: string;
    checklistname!: string;
    description!: string;
    checklisttypekey!: string;
    isvalidated!: number;
}

export class TprRecommendation {
    tprrecommendationid!: string;
    isrecommended!: boolean;
    remarks!: string;
    reasontypekey!: string;
    tprlist!: Tprlist[];
}

export class LegalCustody {
    intakeserviceid!: string;
    intakeservicerequestactorid!: string;
    legalcustodytypekey!: string;
    reason!: string;
    fromdate!: string;
    todate?: any;
}

export class GetAdoptionList {
    getlegalcustody!: Getlegalcustody[];
}

export class Getlegalcustody {
    legalcustodyid!: string;
    intakeserviceid!: string;
    intakeservicerequestactorid!: string;
    legalcustodytypekey!: string;
    reason!: string;
    fromdate!: string;
    todate?: any;
    personid!: string;
    relationshiptypekey!: string;
    personaddress!: string;
    personname!: string;
    phonenumber?: any;
    legalcustodydetail!: Legalcustody[];
    legalcustodytypedesc: any;
}

export class Legalcustody {
    description!: string;
}

export class TprDetails {
    intakeserviceid!: string;
    tprrecommendationid!: string;
    intakeservicerequestactorid!: string;
    serveddate!: string;
    servicetypekey!: string;
    terminationtypekey!: string;
    isappealed!: string;
    isdssappealed!: string;
    appealdate!: string;
    appealdecisiontypekey!: string;
    decisiondate!: string;
    reason!: string;
    singleparent!: boolean;
    parentname!: string;
    actortype!: string;
    tprdetailsid!: string;
    relationship: any;
}

export class Adoptionchecklist {
    checklistid!: string;
    isselected!: number;
    checklistname?: string;
    checklistdesc?: string;
    remarks?: string;
}
export class CheckList {
    checklistid!: string;
    checklistname!: string;
    description!: string;
    checklisttypekey!: string;
    activeflag!: number;
    effectivedate!: string;
    expirationdate?: any;
    oldId?: any;
    isselected?: string;
    remarks?: string;
    isRemarksValid?: boolean;
}

export class Adoption {
    adoptionchecklistid!: string;
    adoptionplanningid!: string;
    disclosuredate!: string;
    personinfomation!: string;
    siblingage!: number;
    siblinginformation!: string;
    remarks!: string;
    status?: any;
    isselected?: number;
    adoptionchecklist!: Adoptionchecklist[];
    intakeserviceid?: string;
}

export class Adoptionemotional {
    adoptionplanningid!: string;
    adoptionemotionalid?: any;
    notes!: string;
    isfosterparents!: number;
    isadoptivefamily!: number;
    adoptionemotionaldetails!: Adoptionemotionaldetail[];
}

export class Adoptionemotionaldetail {
    intakeservicerequestactorid!: string;
    childimportance!: string;
    remarks!: string;
    persontype!: string;
    providerid!: string;
    name?: string;
    fmfirstname?: string;
    fmlastname?: string;
    fmmiddlename?: string;
    fmprefixtypekey?: string;
    fmsuffixtypekey?: string;
    importancetochildtx?: string;
    insertedon: any;
    provider_first_nm?: string;
    provider_last_nm?: string;
    provider_nm?: string;
    relationshiptochildtx: any;
    fullname: any;
}
export class AdoptionNarrative {
  adoptiondate!: string;
  narrative!: string;
  adoptionplanningid!: string;
}

export class ValidateAdoption {
    statuscode!: number;
    status_description!: string;
  }

  export class GetBreakLine {
    getadoptionbreakthelink!: Getadoptionbreakthelink[];
  }
  export class Getadoptionbreakthelink {
    adoptionbreakthelinkid!: string;
    legallyfree!: number;
    adoptiveplacement!: number;
    placementagreement!: number;
    agreementsigneddate!: string;
    adoptionfinalization!: number;
    associatedcourtorderdate!: string;
    finalizationdate!: string;
    adoptionplanningid!: string;
    placementstartdate!: string;
    placementenddate?: any;
    providername!: string;
    placementstructure?: any;
    narrativecheckliststatus!: string;
    placementapprovalstatus!: boolean;
    adoptionplanbegindate!: string;
    tprmotherdate!: string;
    tprfatherdate!: string;
    status: any;
  }
  export class Attachment {
    originalfilename!: string;
    filename!: string;
    Documentproperties!: string;
    Documentattachment!: string;
    documentpropertiesid!: string;
    documenttypekey!: string;
    documentdate!: Date;
    title!: string;
    description!: string;
    mime!: string;
    insertedby!: string;
    insertedon!: Date;
    uplodeddate!: string;
    updatedon!: Date;
    documentattachment!: AttachmentType;
    userprofile!: UserProfile;
    s3bucketpathname!: string;
    numberofbytes!: number;
    actualdocumentdate!: string;
}
export class AttachmentType {
    documentpropertiesid!: string;
    attachmenttypekey!: string;
    attachmentclassificationtypekey!: string;
    updatedby!: string;
    attachmentdate!: Date;
    assessmenttemplateid!: string;
}
export class UserProfile {
    securityusersid!: string;
    firstname!: string;
    lastname!: string;
    displayname!: string;
}
export class PlacementPlanConfig {
    intakeserviceid?: string;
    intakeservicerequestactorid!: string;
    providerid!: string;
    startdatetime!: string;
    enddatetime!: string | null;
    remarks!: string;
    statustypekey!: string;
}
export class PermanencyPlanType {
    permanencyplantypekey!: string;
    permanencyplansubtype!: PermanencyPlanSubType[];
    description: any;
}
export class PermanencyPlanSubType {
    permanencyplansubtypeid?: string;
    permanencyplansubtypekey!: string;
    permanencyplantypekey!: string;
    plantype?: string;
    description: any;
}
export interface PermanencyPlan {
    totalcount: string;
    childname: string;
    dateofbirth: Date;
    primarypermanency: PermanencyPlanSubType[];
    concurrentpermanency: PermanencyPlanSubType[];
    caseworkername: string;
    projecteddate?: Date;
    achieveddate?: Date;
    establisheddate?: Date;
    receiveddate?: Date;
    remarks?: string;
    intakeservicerequestactorid: string;
    status: string;
}

export class GapAssignment {
    gapid!: string;
    suspensionreasontypekey!: string;
    startdate!: Date;
    enddate!: Date;
    notes!: string;
    isdraft!: string;
    suspensiondesc!: string;
}
export class GapAnnualReview {
    gapid!: string;
    reviewdate!: string;
    isguardianresponsible!: string;
    isguardiansupportfinance!: string;
    ischildwithguardian!: string;
    ischildattendingschool!: string;
    isdocumentprovided!: string;
    ischildreacheighteen!: string;
    ischilddisability!: string;
    istrainingenrolled!: string;
    isunemployment!: string;
    isformcomplete!: string;
    cgprimarydate!: string;
    directorsigndate!: string;
    activeflag!: string;
    effectivedate!: string;
    insertedby!: string;
    updatedby!: string;
}
export interface PermanencyPlan {
    totalcount: string;
    childname: string;
    dateofbirth: Date;
    primarypermanency: PermanencyPlanSubType[];
    concurrentpermanency: PermanencyPlanSubType[];
    caseworkername: string;
    projecteddate?: Date;
    achieveddate?: Date;
    establisheddate?: Date;
    receiveddate?: Date;
    remarks?: string;
    intakeservicerequestactorid: string;
}
export class GapDisclosure {
    placementid!: string;
    intakeserviceid!: string;
    guardianonename!: string;
    guardianoneid!: string;
    guardiantwoname!: string;
    guardiantwoid!: string;
    disclosuredate!: Date;
    ischildplacedsixmonths!: boolean;
    isproviderapprovedgap!: boolean;
    iscourthearingcustody!: boolean;
    isreunificationremoved!: boolean;
    isadoptionremoved!: boolean;
    iscgprovidesafe!: boolean;
    isothergapfinsupport!: boolean;
    iscgattendedorientation!: boolean;
    orientationmeetingdate!: Date;
    isrequirementdiscussed!: boolean;
    iscgparticipategap!: boolean;
    iscgenteredagreement!: boolean;
    iscgcompleteauthorization!: boolean;
    iscgaftercareservice!: boolean;
    isneedadditionalservices!: boolean;
    iscgcompleteannualreview!: boolean;
    issuspendedfromguardian!: boolean;
    status!: number;
}
export class GapDisclosurelist {
    totalcount!: number;
    guardianonename!: string;
    guardiantwoname!: string;
    intakeserviceid!: string;
    gapdisclosure!: Disclosure[];
    gapsuspension!: GapSuspension[];
    gapannualreview!: GapAnnualreView[];
    childname!: string;
    dob!: Date;
    placementtype!: string;
    placedatetime!: Date;
    placeenddatetime!: Date;
    placementinformation!: string;
    status!: string;
    placementid!: string;
    key!: string;
    role!: string;
    providerinfo!: ProviderInfo;
}
export class Disclosure {
    gapdisclosureid!: string;
    gapid!: string;
    disclosuredate!: string;
    ischildplacedsixmonths!: boolean;
    isproviderapprovedgap!: boolean;
    iscourthearingcustody!: boolean;
    isreunificationremoved!: boolean;
    isadoptionremoved!: boolean;
    iscgprovidesafe!: boolean;
    isothergapfinsupport!: boolean;
    iscgattendedorientation!: boolean;
    orientationmeetingdate!: Date;
    isrequirementdiscussed!: boolean;
    iscgparticipategap!: boolean;
    iscgenteredagreement!: boolean;
    iscgcompleteauthorization!: boolean;
    iscgaftercareservice!: boolean;
    isneedadditionalservices!: boolean;
    iscgcompleteannualreview!: boolean;
    issuspendedfromguardian!: boolean;
    status!: number;
    activeflag!: number;
    effecteddate!: Date;
    insertedby!: Date;
    insertedon!: Date;
    updatedby!: Date;
    updatedon!: Date;
    old_id!: string;
}
export class GapSuspension {
    suspensionreasontypekey?: string;
    startdate?: Date;
    enddate?: Date;
    typedescription?: string;
    routingstatus?: string;
    gapsuspensionid?: string;
}

export class GapAnnualreView {}
export class ProviderInfo {
    providername!: string;
    addressline1!: string;
    addressline2!: string;
    email!: string;
    work!: string;
    fax!: string;
    ext!: string;
    zipcode!: string;
    county!: string;
    city!: string;
    state!: string;
    phonenumber!: PhoneNumber[];
}
export class PhoneNumber {
    phonenumber!: string;
    providercontactinfotypekey!: string;
}

export interface PermanencyPlan {
    totalcount: string;
    childname: string;
    dateofbirth: Date;
    primarypermanency: PermanencyPlanSubType[];
    concurrentpermanency: PermanencyPlanSubType[];
    caseworkername: string;
    projecteddate?: Date;
    achieveddate?: Date;
    establisheddate?: Date;
    receiveddate?: Date;
    remarks?: string;
    intakeservicerequestactorid: string;
}

export class SuspensionReasonType {
    sequencenumber!: number;
    suspensionreasontypekey!: string;
    datavalue!: number;
    typedescription!: string;
    activeflag!: number;
    old_id!: string;
    effectivedate!: Date;
}

export class GapDetails {
    alternateid!: string;
    guardianonename!: string;
    guardianoneid!: string;
    guardiantwoname!: string;
    guardiantwoid!: string;
    gapid!: string;
    childname!: string;
    dob!: Date;
    role!: string;
    gapdisclosure?: DisclosureCheckList[];
    gapsuspension?: Suspesion[];
    gapannualreview?: AnnualReview[];
    gapagreement?: Agreement[];
    guardianoneproviderid?: string;
}
export class DisclosureCheckList {
    gapdisclosureid!: string;
    disclosuredate!: Date;
    ischildplacedsixmonths!: boolean;
    isproviderapprovedgap!: boolean;
    iscourthearingcustody!: boolean;
    isreunificationremoved!: boolean;
    isadoptionremoved!: boolean;
    iscgprovidesafe!: boolean;
    isothergapfinsupport!: boolean;
    iscgattendedorientation!: boolean;
    orientationmeetingdate!: Date;
    isrequirementdiscussed!: boolean;
    iscgparticipategap!: boolean;
    iscgenteredagreement!: boolean;
    iscgcompleteauthorization!: boolean;
    iscgaftercareservice!: boolean;
    isneedadditionalservices!: boolean;
    iscgcompleteannualreview!: boolean;
    issuspendedfromguardian!: boolean;
    consultationguardianshiparrangement!: boolean;
    strongattachmentprimaryguardian!: boolean;
    strongattachmentsecondaryguardian!: boolean;
    isconsultationchildage!: boolean;
    issuccessorguardianexists!: boolean;
    isguardianattach!: boolean;
    isguardiantwoattach!: boolean;
    routingstatus!: string;
    comments!: string;
    insertdate: any;
    approvedby: any;
    requestedby: any;
}
export class Suspesion {
    gapsuspensionid!: string;
    suspensionreasontypekey!: string;
    startdate!: Date;
    enddate!: Date;
    notes!: string;
    isdraft!: string;
    suspensiondesc!: string;
    routingstatus!: string;
    comments!: string;
}
export class AnnualReview {
    gapid!: string;
    gapannualreviewid!: string;
    reviewdate!: Date;
    isguardianresponsible!: boolean;
    isguardiansupportfinance!: boolean;
    ischildwithguardian!: boolean;
    ischildattendingschool!: boolean;
    isdocumentprovided!: boolean;
    ischildreacheighteen!: boolean;
    ischilddisability!: boolean;
    istrainingenrolled!: boolean;
    isunemployment!: boolean;
    isformcomplete!: boolean;
    cgprimarydate!: Date;
    cgsecondarydate!: Date;
    directorsigndate!: Date;
    routingstatus!: string;
    comments!: string;
    status!: string;
}

export class Agreement {
    gapagreementid!: string;
    reviewdate!: Date;
    isguardianresponsible!: boolean;
    isguardiansupportfinance!: boolean;
    ischildwithguardian!: boolean;
    ischildattendingschool!: boolean;
    isdocumentprovided!: boolean;
    ischildreacheighteen!: boolean;
    ischilddisability!: boolean;
    istrainingenrolled!: boolean;
    isunemployment!: boolean;
    isformcomplete!: boolean;
    cgprimarydate!: Date;
    cgsecondarydate!: Date;
    directorsigndate!: Date;
    routingstatus!: string;
    comments?: string;
    agreementrate?: GapRate[];
    ischildreceivetca?: string;
}
export class GapRate {
    rateenddate!: Date;
    ratestartdate!: Date;
    paymenttypekey!: string;
    notes!: string;
    gapagreementrateid!: string;
    isoverride!: boolean;
    paymentamout!: string;
    providerid!: string;
    providercode!: string;
    rateapprovaldate!: Date;
    status!: string;
}
export class RouteToSupervisor {
    objectid!: string;
    eventcode!: string;
    status!: string;
    comments!: string;
    notifymsg!: string;
    routeddescription!: string;
}
export class Placement {
    totalcount!: string;
    childname?: string;
    dob?: any;
    placementtype!: string;
    placedatetime!: string;
    placementinformation!: string;
    status!: string;
    placeenddatetime!: string;
    role!: string;
    providerinfo!: Providerinfo;
    exitreasontypekey?: string;
    placementid?: string;
    iscourtexists!: boolean;
    iseligible!: boolean;
    gender?: string;
    ispermanencyexists?: boolean;
    placement_id?: number;
    permanencyplanid?: string;
    providerdetails?: Providerinfo;
    enddate?: any;
}

export class Providerinfo {
    providername!: string;
    addressline1!: string;
    addressline2!: string;
    email!: string;
    work!: number;
    ext!: number;
    fax!: number;
    zipcode!: number;
    phonenumber!: Phonenumber[];
    providerid!: string;
    provider_id?: string;
    providercode!: string;
}
export class Phonenumber {
    phonenumber!: number;
    providercontactinfotypekey!: string;
}
export class GapAgreement {
    [key: string]: any;
    gapid!: string;
    iscomprehensivehomestudy!: string;
    iscgawardedcustody!: string;
    isplacementenddate!: string;
    ischildreceivetca!: string;
    tcaamount!: number;
    startdate!: string;
    enddate!: string;
    signaturedate!: string;
    guardianonedate!: string;
    guardiantwodate!: string;
    ldssdate!: string;
    gapagreementrate?: Gapagreementrate[];
    attachment: any;
    status!: string;
    isagreementedit?: any;
    courtstartdt: any;
}

export class Gapagreementrate {
    providerid!: string;
    ratestartdate?: string;
    rateenddate?: string;
    paymentamout!: string;
    isoverride!: string;
    paymenttypekey!: string;
    notes!: string;
    // alternateid: string;
    startdate?: string;
    enddate?: string;
}
export class KinshipListDetails {
    totalcount!: string;
    kinshipcareprogramid!: string;
    programareakey!: string;
    subprogramareakey!: string;
    startdate!: string;
    enddate!: string;
    programdescription!: string;
    subprogramdescription!: string;
}

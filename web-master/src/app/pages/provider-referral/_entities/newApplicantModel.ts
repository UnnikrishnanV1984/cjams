import { } from './existingreferralModel';

export class UserProfileImage {
    filename: string;
    originalfilename: string;
    mime: string;
    numberofbytes: number;
    s3bucketpathname: string;
}

export class MyReferralDetails {
    id: string;
    referralnumber: string;
    datereceived: Date;
    narrative: string;
    raname: string;
    workername: string;
}

export class ProviderReferral {
    provider_referral_id: string;
    provider_referral_nm: string;
    provider_referral_last_nm: string;
    provider_referral_first_nm: string;

    provider_referral_program: string; //RCC, CPA
    provider_program_type: string; // Shelter, Respite
    provider_program_name: string;

    adr_email_tx: string;
    adr_home_phone_tx: string;
    adr_cell_phone_tx: string;
    adr_fax_tx: string;
    adr_street_nm: string;
    adr_street_no: string;
    adr_city_nm: string;
    adr_state_cd: string;
    adr_county_cd: string;
    adr_country_tx: string;
    adr_zip5_no: string;
    
    is_son: string;
    is_taxid: string;
    is_rfp: string;
    parent_entity: string;
    parent_entity_taxid: string;
    corporation_entity: string;
    corporation_entity_taxid: string;
    provider_referral_med: string;
    
    referral_status: string;
    referral_decision: string;
    // Check these
    comment: string;
    narrative: string;
}

export class ProviderSearchResponses {
    alias: string;
    personid: string;
    personroleid: string;
    personroletype: string;
    personrolesubtype: string;
    firstname: string;
    middlename: string;
    lastname: string;
    dob: Date;
    dangerlevel: string;
    ssn: string;
    dcn: string;
    primaryaddress: string;
    homephone: string;
    gendertypekey: string;
    loadnumber: string;
    teamname: string;
    source?: string;
    middleName?: string;
    gender?: string;
    city?: string;
    zipcode?: string;
    county?: string;
    priors: number;
    relationscount: number;
    relations: string;
    socialmediasource: string;
    suffix: string;
    userphoto: string;
}
export class Profile {
    firstName: string;
    lastName: string;
    phoneNumber: string;
    zipCode: string;
    streetName: string;
    streetNo: number;
    cityName: string;
    state: string;
    countyCd: string;
    country: string;
    taxid: number;
    faxNumber: string;
    workNumber: string;
    email: string;
    program: string;
    programType: string;
    gender: string;
    minAge: number;
    maxAge: number;
    bedCapacity:number;
}

export class LicenseInfo {
    license_no: string;
    license_issue_dt: string;
    license_expiry_dt: string;
    program_name: string;
    program_type: string;
    contact_person: string;
    minimum_age_no: string;
    maximum_age_no: string;
    gender_cd: string;
    mailing_address: string;
    children_no: string;

}
export class ApplInfo
{
    applicant_id: string;
    program_name: string;
    corporation_name: string;
    license_type: string;
    contact_person: string;
    mailing_address: string;
    contact_phonenumber: string;
    contact_email: string;
    contact_fax: string;
    program_type: string;
    program_type_other: string;
    prgram_size: string;
    corporation_type: string;
    current_license: string;
    no_of_youth_male: string;
    no_of_youth_female: string;
    age_range_of_youth_from: string;
    age_range_of_youth_to: string;
    population_served: string;
    iq_range_from: string;
    iq_range_to: string;
    licenced_by_dda: string;
    facesheet_dev_by_consultant: string;
    minimum_age_no : string ;
    maximum_age_no : string;
    gender_cd : string;
    children_no : string;
    
    application_status: string;
    license_no: string;
}

export class ReferralNarrative {
    narrative: string;
    }

export class ReferralDecision {
    status: string;
    reason: string;
}

export class ApplicationDecision {
    status: string;
    reason: string;
}

export class GeneratedDocuments {
    id: string;
    key: string;
    title: string;
    generatedBy: string;
    generatedDateTime: string;
    isSelected: boolean;
    isRequired: boolean;
    isInProgress: boolean;
    isGenerated: boolean;
    access: string[];
}

export class AttachmentIntakes {
    AttachmentIntakes: AttachmentIntake[] = [];
}

export class AttachmentIntake {
    filename: string;
    mime: string;
    numberofbytes: string;
    s3bucketpathname: string;
    documentdate: string;
    intakenumber: string;
    objecttypekey: string;
    rootobjecttypekey: string;
    activeflag: number;
    insertedby: string;
    updatedby: string;
    title: string;
    description: string;
    documentattachment: {
        attachmentdate: string;
        sourceauthor: string;
        attachmentsubject: string;
        sourceposition: string;
        attachmentpurpose: string;
        sourcephonenumber: string;
        acquisitionmethod: string;
        sourceaddress: string;
        locationoforiginal: string;
        insertedby: string;
        note: string;
        updatedby: string;
        activeflag: number;
        attachmenttypekey: string;
        attachmentclassificationtypekey: string;
    };
}

export class IntakeAppointment {
    id: number;
    title: string;
    appointmentdate: string;
    servreqaptmtid?: string;
    status: string;
    appointmentworkername: string;
    notes: string;
    isChanged: boolean;
    intakeserviceid?: string;
    intakeWorkerId: string;
    appointmentDate: string;
    appointmentTime: string;
    appointmentworkerid: string;
    actors: { 'actorid': string, 'isoptional': boolean }[];
    history: IntakeAppointment[] = [];
    scheduledBy: string;
}

export class Assessments {
    totalcount: number;
    assessmentid: string;
    assessmenttemplateid: string;
    external_templateid: string;
    submissionid: string;
    description: string;
    updatedon: Date;
    assessmenttype: string;
    assessmentstatustypekey: string;
    assessmentstatustypeid: number;
    name: string;
    duedays?: string;
    intakassessment?: any[];
}
export class Narrative {
    narrative: string;
    }


export class AttachmentUpload {
    index?: number;
    filename: string;
    mime: string;
    numberofbytes: number;
    s3bucketpathname: string;
}

export class ResourcePermission {
    id?: string;
    parentid?: string;
    name: string;
    resourceid?: string;
    resourcetype?: number;
    isSelected?: boolean;
    tooltip?: string;
}

export class ApplicantStaffDetails {
    staff_first_name: string;
    staff_last_name: string;
    staff_role: string;
    staff_email: string;
    staff_phone: string;
    staff_background_status: string;
    staff_clearance_status: string;
    staff_ssn: string;
}
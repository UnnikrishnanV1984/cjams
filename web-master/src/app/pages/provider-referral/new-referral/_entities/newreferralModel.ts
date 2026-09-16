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

    provider_referral_program: string; // RCC, CPA
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
    provider_category: string;
    agency: string;
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
    fullname: string;
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
    programName: string;
    gender: string;
    minAge: number;
    maxAge: number;
    bedCapacity: number;
}

export class ReferralNarrative {
    narrative: string;
    }

export class ReferralDecision {
    status: string;
    reason: string;
}
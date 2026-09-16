
import { } from './existingreferralModel';

export class ApplicantProfileInfo
{
    provider_applicant_profile_id: string;
    applicant_id: string;
    tax_id_no: string;

    provider_applicant_nm: string; //Corporation Name

    dba_name: string;

    provider_applicant_prefix_cd: string;
    provider_applicant_first_nm: string;
    provider_applicant_middle_nm: string;
    provider_applicant_last_nm: string;
    provider_applicant_suffix_cd: string;
    
    adr_url_tx: string;

}

export class Email {
    object_id: string;
    email: string;
    email_unique_id: string;
    email_type: string;
}

export class Phone {
    object_id: string;
    phone_type: string; // Main, Fax, Cell
    phone_id: string;
    phone_no: string;
}

export class ApplicantProgramInfo
{
    applicant_id: string;
    
    prgram: string; // RCC, CPA
    program_type: string; //(license_type) Shelpter, ILP, etc
    program_name: string; // Happy homes
    
    program_tax_id_no: string;

    contact_prefix_cd: string;
    contact_first_nm: string;
    contact_middle_nm: string;
    contact_last_nm: string;
    contact_suffix_cd: string;

    gender_cd: string;
    minimum_age_no: string;
    maximum_age_no: string;

    iq_range_from: string;
    iq_range_to: string;

    children_no: string;
    //addresses:
    addresses: AddressDetails[] = [];
}


export class AddressDetails
{
    applicant_id: string;
    provider_applicant_profile_id:string;

    object_id: string;
    address_id: string;

    adr_street_no: string;
    adr_street_nm: string;
    adr_city_nm: string;
    adr_county_cd: string;
    adr_state_cd: string;
    adr_zip5_no: string;
    adr_direction_tx: string;
    adr_country_tx: string;

    address_type: string;
}
export class ComplaintDetail {
    provider_complaintid: string;
    intakeservreqinputtypeid: string;
    complaint_source: string;
    source_information_type: string;
    complaint_date: string;
    narrative: string;
    complainant_firstname: string;
    complainant_lastname: string;
    complainant_phone: string;
    complainant_email: string;
    complainant_address1: string;
    complainant_address2: string;
    complainant_city: string;
    complainant_state: string;
    complainant_county: string;
    complaint_number: string;
    provider_id: number;
    provider_name: string;
    provider_person_name: string;
    site_id: number;
    is_draft: boolean;
    inserted_on: string;
    updated_on: string;
    updated_by: string;
    inserted_by: string;
    created_on: string | Date;
    created_by: string;
    created_by_name: string;
    status: string;
    statusdescription: string;
    displayname: string;
    outcomes: string;
    summary: string;
}

export class ComplaintDecison {
    complaint_number: string;
    status: string;
    comments: string;
    notification: string;
    assingsecurityuserid? : string;
    agency?:string;
    agency_email?:string;    
}

export class DeficiencyViolation {
    tb_provider_complaint_deficiencyid: string;
    provider_complaintid: string;
    deficiency_violationname: string;
    citation: string;
    comments: string;
    frequencyofdeficiency: string;
    impactofdeficiency: string;
    scopeofdeficiency: string;
    findings: string;
}
export class Contact {
    provider_complaintid: string;
    provider_complaint_contactsid: string;
    complaint_contacts_name: string;
    complaint_contacts_source: string;
    complainant_contacts_phone: string;

}

drop function if exists createkinshipapplicant( character varying,  character varying,  character varying,  character varying,  character varying,  character varying,  character varying,  character varying);
drop function if exists createkinshipapplicant( character varying,  character varying,  character varying,  character varying,  character varying,  character varying,  character varying,  character varying,boolean);
CREATE OR REPLACE FUNCTION cjams.createkinshipapplicant(v_objectid character varying, v_referralid character varying, v_fromsecurityuserid character varying, v_tosecurityuserid character varying, v_approval_type character varying, v_comments character varying, v_communication character varying, v_requesteddate character varying, v_isclosereopen boolean DEFAULT NULL::boolean)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ 

declare

  v_referralold character varying;
 v_returnstatus character varying;
 v_nextno character varying;
 v_applicantoldid character varying;
 v_applicantid character varying;
  v_providerrouting character varying;
 v_prgram character varying;
 v_prgramtype character varying;
v_providerroutingstatus character varying;
v_updateinquiryhousehold character varying;



begin
	
  select referral_id into v_referralold from providerapprovalphaserecord where provider_id=v_objectid;
 raise notice 'v_approval_type%',v_approval_type;
 if (v_approval_type = 'RH') then 
 v_prgramtype := 'Restricted Home';
 v_providerroutingstatus := 'Restricted Home';
elsif (v_approval_type = 'TR') then 
 v_prgramtype := 'Treatment Resource Home';
 v_providerroutingstatus := 'Treatment Resource Home';
elsif (v_approval_type = 'RRH') then 
 v_prgramtype := 'Regular Resource Home';
 v_providerroutingstatus := 'Regular Resource Home';
end if;
  if (v_referralold is not null) then
    select replace(v_referralold,'R','A') into v_applicantoldid;
  select replace(v_referralid,'R','A') into v_applicantid;
  INSERT INTO cjams.tb_public_provider_referral
(referral_id, prgram, create_ts, create_user_id, update_ts, delete_sw, update_user_id, referral_status, organization_first_nm, organization_tax_id, individual_applicant_first_nm, individual_applicant_ssn, individual_applicant_dob, individual_applicant_background_check, co_applicant_first_nm, co_applicant_ssn, co_applicant_dob, co_applicant_background_check, medical_info_license_no, medical_info_speciality, payment_info_medicaid_provider, payment_info_payee_first_nm, payment_info_1099_indicator, individual_applicant_middle_nm, individual_applicant_last_nm, organization_middle_nm, organization_last_nm, co_applicant_middle_nm, co_applicant_last_nm, payment_info_payee_middle_nm, payment_info_payee_last_nm, communication_medium, date_of_contact, referral_decision, provider_program_type, individual_applicant_prefix, individual_applicant_suffix, co_applicant_prefix, co_applicant_suffix, home_info_children_no, home_info_bedroom_no, is_home_water, is_home_swimming_pool, home_info_pool_location, home_is_other_agency, home_info_agency_nm, is_child_care_provider, home_info_child_care_details, individual_applicant_hm_phone, individual_applicant_cell_nm, individual_applicant_email, individual_applicant_employer_nm, individual_applicant_phone_nm, individual_applicant_us_citizen, co_applicant_hm_phone, co_applicant_cell_nm, co_applicant_email, co_applicant_employer_nm, co_applicant_phone_nm, co_applicant_us_citizen, age_group, inquiry_source, inquiry_source_details, jurisdiction)
(select v_referralid, prgram, now()::timestamp,v_fromsecurityuserid, now()::timestamp, NULL, v_fromsecurityuserid, referral_status, organization_first_nm, organization_tax_id, individual_applicant_first_nm, individual_applicant_ssn, individual_applicant_dob, individual_applicant_background_check, co_applicant_first_nm, co_applicant_ssn, co_applicant_dob, co_applicant_background_check, medical_info_license_no, medical_info_speciality, payment_info_medicaid_provider, payment_info_payee_first_nm, payment_info_1099_indicator, individual_applicant_middle_nm, individual_applicant_last_nm, organization_middle_nm, organization_last_nm, co_applicant_middle_nm, co_applicant_last_nm, payment_info_payee_middle_nm, payment_info_payee_last_nm, v_communication, v_requesteddate::date, referral_decision, v_prgramtype, individual_applicant_prefix, individual_applicant_suffix, co_applicant_prefix, co_applicant_suffix, home_info_children_no, home_info_bedroom_no, is_home_water, is_home_swimming_pool, home_info_pool_location, home_is_other_agency, home_info_agency_nm, is_child_care_provider, home_info_child_care_details, individual_applicant_hm_phone, individual_applicant_cell_nm, individual_applicant_email, individual_applicant_employer_nm, individual_applicant_phone_nm, individual_applicant_us_citizen, co_applicant_hm_phone, co_applicant_cell_nm, co_applicant_email, co_applicant_employer_nm, co_applicant_phone_nm, co_applicant_us_citizen, age_group, inquiry_source, inquiry_source_details, jurisdiction from tb_public_provider_referral
where referral_id=v_referralold);

INSERT INTO cjams.tb_public_provider_applicant
(applicant_id, prgram, create_ts, create_user_id, update_ts, delete_sw, update_user_id, organization_first_nm, organization_tax_id, individual_applicant_first_nm, individual_applicant_ssn, individual_applicant_dob, individual_applicant_background_check, co_applicant_first_nm, co_applicant_ssn, co_applicant_dob, co_applicant_background_check, medical_info_license_no, medical_info_speciality, payment_info_medicaid_provider, payment_info_payee_first_nm, payment_info_1099_indicator, individual_applicant_middle_nm, individual_applicant_last_nm, organization_middle_nm, organization_last_nm, co_applicant_middle_nm, co_applicant_last_nm, payment_info_payee_middle_nm, payment_info_payee_last_nm, communication_medium, date_of_contact, provider_program_type, individual_applicant_prefix, individual_applicant_suffix, co_applicant_prefix, co_applicant_suffix, is_home_water, home_info_children_no, home_info_bedroom_no, is_home_swimming_pool, home_info_pool_location, home_is_other_agency, home_info_agency_nm, is_child_care_provider, home_info_child_care_details, individual_applicant_hm_phone, individual_applicant_cell_nm, individual_applicant_email, individual_applicant_employer_nm, individual_applicant_phone_nm, individual_applicant_us_citizen, co_applicant_hm_phone, co_applicant_cell_nm, co_applicant_email, co_applicant_employer_nm, co_applicant_phone_nm, co_applicant_us_citizen, age_group, inquiry_source, inquiry_source_details, jurisdiction, phase,application_status,applicant_decision)
(select v_applicantid,  prgram, create_ts, create_user_id, update_ts, delete_sw, update_user_id, organization_first_nm, organization_tax_id, individual_applicant_first_nm, individual_applicant_ssn, individual_applicant_dob, individual_applicant_background_check, co_applicant_first_nm, co_applicant_ssn, co_applicant_dob, co_applicant_background_check, medical_info_license_no, medical_info_speciality, payment_info_medicaid_provider, payment_info_payee_first_nm, payment_info_1099_indicator, individual_applicant_middle_nm, individual_applicant_last_nm, organization_middle_nm, organization_last_nm, co_applicant_middle_nm, co_applicant_last_nm, payment_info_payee_middle_nm, payment_info_payee_last_nm, communication_medium, date_of_contact, provider_program_type, individual_applicant_prefix, individual_applicant_suffix, co_applicant_prefix, co_applicant_suffix, is_home_water, home_info_children_no, home_info_bedroom_no, is_home_swimming_pool, home_info_pool_location, home_is_other_agency, home_info_agency_nm, is_child_care_provider, home_info_child_care_details, individual_applicant_hm_phone, individual_applicant_cell_nm, individual_applicant_email, individual_applicant_employer_nm, individual_applicant_phone_nm, individual_applicant_us_citizen, co_applicant_hm_phone, co_applicant_cell_nm, co_applicant_email, co_applicant_employer_nm, co_applicant_phone_nm, co_applicant_us_citizen, age_group, 'Other', inquiry_source_details, jurisdiction, 'Pre-app','For Assignment','For Assignment' FROM tb_public_provider_referral WHERE referral_id=v_referralid);

INSERT INTO cjams.providerapprovetypeconfig
( providerid, referralid, applicantid, "comments", activeflag, effectivedate, insertedby, insertedon,approval_type,communication,requested_date,isclosereopen)
VALUES( v_objectid, v_referralid, v_applicantid, v_comments, 1, now(), v_fromsecurityuserid, now(),v_approval_type,v_communication,v_requesteddate::timestamp,v_isclosereopen);

select publicproviderrouting into v_providerrouting from publicproviderrouting(v_applicantid,v_fromsecurityuserid,v_tosecurityuserid,
86,'PRRHSW',v_providerroutingstatus,v_providerroutingstatus);

 select updateinquiryhousehold into v_updateinquiryhousehold from updateinquiryhousehold(v_referralold,v_referralid,v_fromsecurityuserid);
select updateinquiryhousehold into v_updateinquiryhousehold from updateinquiryhousehold(v_referralid,v_applicantid,v_fromsecurityuserid);


raise notice 'v_providerrouting%',v_providerrouting;
  
  v_returnstatus := v_applicantid;
 else 
  v_returnstatus := 'Failure';
  END IF;


RETURN v_returnstatus;
                                                      
END;

$function$;

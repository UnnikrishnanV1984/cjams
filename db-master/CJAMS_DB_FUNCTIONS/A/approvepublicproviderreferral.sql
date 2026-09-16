CREATE OR REPLACE FUNCTION cjams.approvepublicproviderreferral(insertedtlsobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 

declare

v_referralId text;
v_applicantId text;
v_inquiryid text;
returnStatus text;
v_securityuserid text;
addressId text;
addressType text;
response json;
v_counter json;
v_householdmember character varying;
v_approveprovider character varying;
v_referralstatus character varying;
v_comments character varying;


BEGIN

v_referralId := insertedtlsobj->>'referral_id';
v_applicantId := insertedtlsobj->>'applicant_id';
v_securityUserId := insertedtlsobj->>'create_user_id';
v_referralstatus := insertedtlsobj->>'referral_status';
v_comments := insertedtlsobj->>'comments';

RAISE NOTICE '%','v_securityUserId';
select replace(v_applicantId,'A','R') into v_inquiryid;

if length(v_inquiryid)>1 then
select updateinquiryhousehold into  v_householdmember from updateinquiryhousehold(v_inquiryid,v_applicantId,v_securityuserid);
select updateapplicantdetails into v_approveprovider from updateapplicantdetails(v_inquiryid,v_securityuserid);
end if;

IF LENGTH(v_applicantId) > 1
THEN

INSERT INTO tb_public_provider_applicant
(applicant_id, prgram, create_ts, create_user_id, update_ts, delete_sw, update_user_id, organization_first_nm, organization_tax_id, individual_applicant_first_nm, individual_applicant_ssn, individual_applicant_dob, individual_applicant_background_check, co_applicant_first_nm, co_applicant_ssn, co_applicant_dob, co_applicant_background_check, medical_info_license_no, medical_info_speciality, payment_info_medicaid_provider, payment_info_payee_first_nm, payment_info_1099_indicator, individual_applicant_middle_nm, individual_applicant_last_nm, organization_middle_nm, organization_last_nm, co_applicant_middle_nm, co_applicant_last_nm, payment_info_payee_middle_nm, payment_info_payee_last_nm, communication_medium, date_of_contact,provider_program_type,individual_applicant_prefix,individual_applicant_suffix,co_applicant_prefix,co_applicant_suffix,jurisdiction,age_group,inquiry_source,inquiry_source_details,individual_applicant_hm_phone,individual_applicant_cell_nm,individual_applicant_email,individual_applicant_employer_nm,individual_applicant_phone_nm,individual_applicant_us_citizen,co_applicant_hm_phone,co_applicant_cell_nm,co_applicant_email,co_applicant_employer_nm,co_applicant_phone_nm,co_applicant_us_citizen,home_info_children_no,home_info_bedroom_no,is_home_water,is_home_swimming_pool,home_info_pool_location,home_is_other_agency,is_child_care_provider,home_info_child_care_details)
SELECT 
v_applicantId, prgram, create_ts, v_securityUserId, update_ts, delete_sw, v_securityUserId, organization_first_nm, organization_tax_id, individual_applicant_first_nm, individual_applicant_ssn, individual_applicant_dob, individual_applicant_background_check, co_applicant_first_nm, co_applicant_ssn, co_applicant_dob, co_applicant_background_check, medical_info_license_no, medical_info_speciality, payment_info_medicaid_provider, payment_info_payee_first_nm, payment_info_1099_indicator, individual_applicant_middle_nm, individual_applicant_last_nm, organization_middle_nm, organization_last_nm, co_applicant_middle_nm, co_applicant_last_nm, payment_info_payee_middle_nm, payment_info_payee_last_nm, communication_medium, date_of_contact,provider_program_type,individual_applicant_prefix,individual_applicant_suffix,co_applicant_prefix,co_applicant_suffix,jurisdiction,age_group,inquiry_source,inquiry_source_details,individual_applicant_hm_phone,individual_applicant_cell_nm,individual_applicant_email,individual_applicant_employer_nm,individual_applicant_phone_nm,individual_applicant_us_citizen,co_applicant_hm_phone,co_applicant_cell_nm,co_applicant_email,co_applicant_employer_nm,co_applicant_phone_nm,co_applicant_us_citizen,home_info_children_no,home_info_bedroom_no,is_home_water,is_home_swimming_pool,home_info_pool_location,home_is_other_agency,is_child_care_provider,home_info_child_care_details
FROM tb_public_provider_referral WHERE referral_id=v_referralId;

UPDATE tb_public_provider_applicant SET application_status='For Assignment', applicant_decision='For Assignment', phase='Pre-App' WHERE applicant_id=v_applicantId;
--insert into household as individual applicant
INSERT INTO tb_public_provider_applicant_household
(object_id, household_member_relation,household_member_email,household_member_dob, 
household_member_phone, household_member_background_status,household_member_ssn,create_ts, create_user_id,update_ts, update_user_id, delete_sw,household_member_first_name,household_member_middle_name,household_member_last_name)
select 
v_applicantId,'Individual Applicant','',individual_applicant_dob,null,individual_applicant_background_check::boolean,individual_applicant_ssn::numeric,
create_ts,v_securityUserId, update_ts,v_securityUserId, delete_sw,individual_applicant_first_nm,individual_applicant_middle_nm,
individual_applicant_last_nm
FROM tb_public_provider_referral WHERE referral_id=v_referralId;


--insert into household as co applicant
INSERT INTO tb_public_provider_applicant_household
(object_id, household_member_relation,household_member_email,household_member_dob, 
household_member_phone, household_member_background_status,household_member_ssn,create_ts, create_user_id,update_ts, update_user_id, delete_sw,household_member_first_name,household_member_middle_name,household_member_last_name)
select 
v_applicantId,'Co Applicant','',co_applicant_dob,null,co_applicant_background_check::boolean,co_applicant_ssn::numeric,create_ts,v_securityUserId, update_ts,v_securityUserId, delete_sw,co_applicant_first_nm,co_applicant_middle_nm,co_applicant_last_nm
FROM tb_public_provider_referral WHERE referral_id=v_referralId;

--insert addresses with applicant number
select json_agg(x) from (SELECT *  FROM tb_provider_address_mapping where object_id=v_referralId) as X  into response;

raise notice '%s',  response;
 
for v_counter in select * from json_array_elements(response)
loop

raise notice '%s',  v_counter;
 	
		addressId := v_counter ->> 'address_id';
		addressType := v_counter ->> 'address_type';		
		
INSERT INTO tb_provider_address_mapping
(address_mapping_id, object_id, address_id, address_type, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(gen_random_uuid(), v_applicantId, addressId::uuid, addressType , now(), v_securityuserid, now(), v_securityuserid, 'N'::bpchar);
	 END LOOP;
	
--insert into providerapprovalphaserecord
INSERT INTO providerapprovalphaserecord
(provider_approval_record_id, referral_id, applicant_id, provider_id, is_referral_accepted, create_ts, create_user_id, update_ts, update_user_id, delete_sw, active_flag)
VALUES(gen_random_uuid(), v_referralId, v_applicantId, '', true, now(), v_securityUserId, now(), v_securityUserId, 'N'::bpchar, 1);


---insert into publicproviderhomeinfo
INSERT INTO publicproviderhomeinfo
(home_info_id, home_info_children_no, home_info_bedroom_no, is_home_water, is_home_swimming_pool, home_info_pool_location, home_is_other_agency, home_info_agency_nm, is_child_care_provider, home_info_child_care_details, create_ts, create_user_id, update_ts, update_user_id, delete_sw, active_flag, object_id)
select gen_random_uuid(), home_info_children_no, home_info_bedroom_no, is_home_water, is_home_swimming_pool, home_info_pool_location, home_is_other_agency, home_info_agency_nm, is_child_care_provider, home_info_child_care_details,now(), v_securityUserId, now(), v_securityUserId, 'N'::bpchar, 1, v_applicantId
from tb_public_provider_referral WHERE referral_id=v_referralId;


ELSE
returnStatus:= 'Failure';

END IF;
returnStatus:= v_applicantId;

RETURN returnStatus;
                                                      
END;

$function$;

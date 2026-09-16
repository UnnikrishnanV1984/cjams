CREATE OR REPLACE FUNCTION cjams.getdashboarddetails(v_tosecurityusersid character varying, v_status character varying DEFAULT NULL::character varying)
 RETURNS TABLE(objectid character varying, eventcode character varying, fromsecurityusersid character varying, tosecurityusersid character varying, teamid uuid, routingstatustypeid integer, isreviewrequest boolean, remarks text, routeddescription text, servicerequestnumber character varying, objecttypekey character varying, applicant_id character varying, prgram character varying, application_status character varying, organization_first_nm character varying, organization_tax_id integer, individual_applicant_first_nm character varying, individual_applicant_ssn integer, individual_applicant_dob date, individual_applicant_background_check character varying, co_applicant_first_nm character varying, co_applicant_ssn integer, co_applicant_dob date, co_applicant_background_check character varying, medical_info_license_no integer, medical_info_speciality character varying, payment_info_medicaid_provider boolean, payment_info_payee_first_nm character varying, payment_info_1099_indicator character varying, individual_applicant_middle_nm character varying, individual_applicant_last_nm character varying, organization_middle_nm character varying, organization_last_nm character varying, co_applicant_middle_nm character varying, co_applicant_last_nm character varying, payment_info_payee_middle_nm character varying, payment_info_payee_last_nm character varying, applicantion_decision character varying, communication_medium character varying, date_of_contact date, applicant_decision character varying, provider_program_type character varying, individual_applicant_prefix character varying, individual_applicant_suffix character varying, co_applicant_prefix character varying, co_applicant_suffix character varying, is_home_water boolean, home_info_children_no character varying, home_info_bedroom_no character varying, is_home_swimming_pool boolean, home_info_pool_location character varying, home_is_other_agency boolean, home_info_agency_nm character varying, is_child_care_provider boolean, home_info_child_care_details character varying, individual_applicant_hm_phone character varying, individual_applicant_cell_nm character varying, individual_applicant_email character varying, individual_applicant_employer_nm character varying, individual_applicant_phone_nm character varying, individual_applicant_us_citizen boolean, co_applicant_hm_phone character varying, co_applicant_cell_nm character varying, co_applicant_email character varying, co_applicant_employer_nm character varying, co_applicant_phone_nm character varying, insertedon timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
 

DECLARE
    v_rstatus text[];
    
    	
BEGIN
  v_rstatus := v_status;
   
 return query 
select * from (select distinct on (r.objectid) r.objectid,r.eventcode,r.fromsecurityusersid,r.tosecurityusersid,r.teamid,r.routingstatustypeid,r.isreviewrequest,
r.remarks,r.routeddescription,r.servicerequestnumber,r.objecttypekey,tpa.applicant_id,tpa.prgram,tpa.application_status,tpa.organization_first_nm,tpa.organization_tax_id,
tpa.individual_applicant_first_nm,
tpa.individual_applicant_ssn,tpa.individual_applicant_dob,tpa.individual_applicant_background_check, tpa.co_applicant_first_nm,tpa.co_applicant_ssn,tpa.co_applicant_dob,tpa.co_applicant_background_check,
tpa.medical_info_license_no,tpa.medical_info_speciality,tpa.payment_info_medicaid_provider,tpa.payment_info_payee_first_nm,tpa.payment_info_1099_indicator,tpa.individual_applicant_middle_nm,tpa.individual_applicant_last_nm,
tpa.organization_middle_nm,tpa.organization_last_nm,tpa.co_applicant_middle_nm,tpa.co_applicant_last_nm,tpa.payment_info_payee_middle_nm,tpa.payment_info_payee_last_nm,
tpa.applicantion_decision,tpa.communication_medium,tpa.date_of_contact,tpa.applicant_decision,tpa.provider_program_type,tpa.individual_applicant_prefix,
tpa.individual_applicant_suffix,tpa.co_applicant_prefix,tpa.co_applicant_suffix,tpa.is_home_water,tpa.home_info_children_no,tpa.home_info_bedroom_no,
tpa.is_home_swimming_pool,tpa.home_info_pool_location,tpa.home_is_other_agency,tpa.home_info_agency_nm,tpa.is_child_care_provider,
tpa.home_info_child_care_details,tpa.individual_applicant_hm_phone,tpa.individual_applicant_cell_nm,tpa.individual_applicant_email,tpa.individual_applicant_employer_nm,
tpa.individual_applicant_phone_nm,tpa.individual_applicant_us_citizen,tpa.co_applicant_hm_phone,tpa.co_applicant_cell_nm,tpa.co_applicant_email,
tpa.co_applicant_employer_nm,tpa.co_applicant_phone_nm,r.insertedon
from routing r join tb_public_provider_applicant tpa on r.objectid = tpa.applicant_id where
r.tosecurityusersid=v_tosecurityusersid and r.activeflag = 1
and (v_status is null or tpa.application_status = ANY (v_rstatus)))as x
order by x.insertedon desc;


END;   

 
$function$;


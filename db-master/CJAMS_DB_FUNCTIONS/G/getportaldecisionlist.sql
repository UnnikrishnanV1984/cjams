
drop function if exists getportaldecisionlist(json,bigint,bigint);
CREATE OR REPLACE FUNCTION cjams.getportaldecisionlist(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(applicant_id character varying,prgram character varying, program_name character varying, contact_first_nm character varying, mailing_address character varying, 
 contact_phonenumber character varying, contact_email character varying, contact_fax character varying, program_type character varying, program_type_other character varying, prgram_size character varying, current_license character varying, licenced_by_dda character varying, 
 facesheet_dev_by_consultant character varying, create_ts character varying, create_user_id character varying, update_ts character varying,
 update_user_id character varying, delete_sw character, application_status character varying, license_no character varying, provider_id character varying,
 applicant_profile_id uuid, program_tax_id_no int, contact_last_nm character varying, contact_middle_nm character varying, contact_suffix_cd character varying, contact_prefix_cd character varying, requested_license_effective_date timestamp without time zone, requested_license_end_date timestamp without time zone, site_id bigint, application_decision character varying,
 corporation_name character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE
    
	v_applicationid character varying;
    v_applicationstatus character varying;
    v_securityusersid character varying;
	--v_pagenumber int;
	--v_pageoffset int;
    v_status text[];
   
BEGIN

v_applicationid := searchobj ->> 'applicationid';
v_applicationstatus := searchobj ->> 'application_status';
v_securityusersid := searchobj ->> 'securityuserid';
v_status := v_applicationstatus;
--v_pagenumber := v_liPageNumber - 1;
--v_pageoffset := v_pagenumber * v_liPageSize;

RETURN QUERY

SELECT tpa.applicant_id, tpa.prgram, tpa.program_name, tpa.contact_first_nm, tpa.mailing_address, tpa.contact_phonenumber,
tpa.contact_email, tpa.contact_fax, tpa.program_type, tpa.program_type_other, tpa.prgram_size, tpa.current_license, tpa.licenced_by_dda, 
tpa.facesheet_dev_by_consultant, tpa.create_ts, tpa.create_user_id, tpa.update_ts, tpa.update_user_id, tpa.delete_sw, tpa.application_status,
tpa.license_no, tpa.provider_id, tpa.applicant_profile_id, tpa.program_tax_id_no, tpa.contact_last_nm, tpa.contact_middle_nm, tpa.contact_suffix_cd,
tpa.contact_prefix_cd, tpa.requested_license_effective_date, tpa.requested_license_end_date, tpa.site_id, tpa.application_decision, 
tpa.corporation_name
FROM tb_provider_applicant tpa
inner join tb_provider_decision tpd on tpd.objectid = tpa.applicant_id and tpd.tosecurityusersid = v_securityusersid
where tpa.application_status = any (v_status) order by tpa.create_ts desc;


--LIMIT v_liPageSize OFFSET v_pageoffset; 
END 

$function$

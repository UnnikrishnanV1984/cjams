drop function if exists getvendorprofileinfo(character varying);
CREATE OR REPLACE FUNCTION cjams.getvendorprofileinfo(v_vendorid character varying)
 RETURNS TABLE(vendorapplicantid uuid, org_nm character varying, primary_prefix_cd character varying, primary_first_nm character varying, primary_middle_nm character varying, primary_last_nm character varying, primary_suffix_cd character varying, isprimaryadmin boolean, admin_prefix_cd character varying, admin_first_nm character varying, admin_middle_nm character varying, admin_last_nm character varying, admin_suffix_cd character varying, taxidtype character varying, taxid numeric, is1099indicator boolean, ismedicalaidprov boolean, status character varying, vendorid character varying, regularfrom character varying, regularto character varying,narrative text,
 jurisdiction character varying,services json, ismanagevendor boolean,ref_key text,approvalcomments character varying)
 LANGUAGE plpgsql
AS $function$
	
DECLARE

	
BEGIN


return query	

select va.vendorapplicantid, va.org_nm, va.primary_prefix_cd, va.primary_first_nm, va.primary_middle_nm, va.primary_last_nm, va.primary_suffix_cd, va.isprimaryadmin, va.admin_prefix_cd, va.admin_first_nm, va.admin_middle_nm, va.admin_last_nm, va.admin_suffix_cd, va.taxidtype, va.taxid, va.is1099indicator, va.ismedicalaidprov, va.status,va.vendorid,va.regularfrom,va.regularto,va.narrative,va.jurisdiction,
(select json_agg(x) from (select vs.vendorapplicantservicesid,vs.vendorapplicantid,vs.service_id,vs.startdate,vs.enddate,vs.delete_sw from tb_vendor_applicant_services vs where vs.vendorapplicantid=va.vendorapplicantid and delete_sw='N') as x) as services,
case when ((va.providerid is null) or (va.providerid='')) then false else true end, case when va.status='Rejected' then 'REJ' else 'APR' end as ref_key, va.approvalcomments
from tb_vendor_applicant va where va.vendorid=(v_vendorid) and va.delete_sw='N';


END;

$function$

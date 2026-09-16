drop function if exists cjams.listsiteinformation(v_provider_id integer,v_site_id bigint);
CREATE OR REPLACE FUNCTION cjams.listsiteinformation(v_provider_id integer, v_site_id bigint)
	RETURNS TABLE(provider_id integer,providername character varying,email character varying,phone character varying,address character varying,site_id bigint,programname character varying,prgm_app_address character varying,prgm_app_mail character varying,prgm_app_programtype character varying)
	LANGUAGE plpgsql
AS $function$

declare 

BEGIN
	RETURN QUERY
	select pi.provider_id,pap.provider_applicant_nm as providername,pap.adr_email_tx as email,pap.adr_cell_phone_tx as phone,
(cast(initcap(trim(tbpad.adr_street_tx) 
                                        ||' ' 
                                        ||trim(tbpad.adr_street_nm) 
                                        ||' ' 
                                        ||trim(tbpad.adr_city_nm) 
                                        ||' ' 
                                        ||trim(tbpad.adr_state_cd) 
                                        ||' ' 
                                        || trim(tbpad.adr_zip5_no::character VARYING)) AS character VARYING)) AS address,
tbpap.site_id as site_id, tbpap.program_name as programname,tbpap.mailing_address as prgm_app_address,
tbpap.contact_email as prgm_app_mail,tbpap.program_type as prgm_app_programtype
from  tb_provider pi
inner join tb_provider_applicant_profile pap on pap.provider_id = pi.provider_id and pap.delete_sw = 'N'
left join tb_provider_addresses tbpad  on tbpad.parent_key_id = pi.provider_id :: character varying and tbpad.delete_sw ='N'
inner join tb_provider_applicant tbpap on tbpap.provider_id = pi.provider_id :: character varying and tbpap.delete_sw = 'N'
where pi.provider_id = v_provider_id and tbpap.site_id = v_site_id;
	


end;

$function$
;
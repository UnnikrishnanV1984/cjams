CREATE OR REPLACE FUNCTION cjams.getprogramfacilitydetials(v_program_id character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- 07/15/2021 - Vineet Tirodkar - Modifications for DB 10.8 upgrade - Order by & Distinct Issue - B-107196
------------------------------------------------------------------------
DECLARE  

jsondata  json;
BEGIN

SELECT  Json_agg(a) INTO jsondata FROM (  

	SELECT 
		DISTINCT PF.provider_id, 
		PF.facility_id, 
		PF.program_id, 
		PF.start_dt, 
		PF.end_dt, 
		(case when p.provider_nm is not null and btrim(p.provider_nm) <> '' then
			p.provider_nm
			else
			concat(P.provider_first_nm, ' ', P.provider_last_nm)
			end
		) AS providername,
		(select provider_adr::text as paymentaddress from get_provider_address(P.provider_id,trim('{3357}') )) as provideraddress
	FROM 
		tb_prov_program_facility PF
		LEFT JOIN tb_provider P ON P.provider_id = PF.provider_id
	WHERE PF.program_id::text = v_program_id
		AND PF.delete_sw = 'N'
	order by providername asc
)  a;

RETURN  jsondata;
END;

$function$
;

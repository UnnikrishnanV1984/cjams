DROP FUNCTION IF EXISTS cjams.incidentreportupdate(integer, character varying);

CREATE OR REPLACE FUNCTION cjams.incidentreportupdate(
	v_provider_id integer,
	v_uir_no character varying)
    RETURNS TABLE(provider_id integer, incident_date timestamp without time zone, incident_time character varying, classthree_incident integer,
				  uir_no character varying,program_nm character varying,additional_youth_info character varying,
				 class3_brief_desc character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
declare 

BEGIN
	RETURN QUERY
	select pi.provider_id as provider_id,pi.incident_date as incident_date,pi.incident_time as incident_time,pi.is_classthreeincident as classthree_incident,pi.uir_no as uir_no
,pi.program_nm as program_nm,pi.additional_youth_info as additional_youth_info, 
pi.class3_brief_desc as class3_brief_desc from provider_uir pi where pi.uir_no = v_uir_no AND active_flag =1 AND pi.provider_id = v_provider_id;
	
end;
$BODY$;
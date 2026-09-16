-- DROP FUNCTION IF EXISTS cjams.getadoptioncase(userid character varying, casenumber character varying, page integer, pagelimit integer, v_status character varying);

CREATE OR REPLACE FUNCTION cjams.getadoptioncase(userid character varying, casenumber character varying, page integer, pagelimit integer, v_status character varying)
 RETURNS TABLE(totalcount bigint, servicecaseid uuid, adoptioncaseid uuid, servicerequestnumber character varying, adoptioncasenumber character varying, adoptionplanningid uuid, statustypekey character varying, startdate timestamp without time zone, enddate timestamp without time zone, restrictstatus text, providerdetails json, childdetails json)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 11/09/2021 Vineet Tirodkar - Modifications for CJAMS - Performance Issue (CIDM-4060)
-- 01/31/2021 Vineet Tirodkar - Modifications remove routing table check (CDM-20062) 
------------------------------------------------------------------------------------------------------------	
DECLARE  
	v_pageoffset int;
	v_pagenumber int;

BEGIN
	v_pagenumber := (page-1) * 10;

	RETURN QUERY
	SELECT * 
	FROM (   
		SELECT 
			count(1) over(),	
			ac.servicecaseid,
			ac.adoptioncaseid,
			ac.adoptioncasenumber,
			ac.adoptioncasenumber,
			ac.adoptionplanningid,
			case when ac.statustypekey = 'Closed' then 
				'Closed' 
			else 
				'In Progress' 
			end::varchar as statustypekey ,
			ac.startdate,
			ac.enddate,
			(SELECT * FROM getRestrictedCaseStatus( ac.adoptioncaseid::text,userid)) AS restrictStatus,
			(SELECT json_agg(a) 
				from (
						SELECT * FROM adoptioncaseagreement ag   
						WHERE ag.adoptioncaseid = ac.adoptioncaseid 
							and ag.activeflag=1
			) a ) as providerdetails, 
			(SELECT getcasepersonname as child 
				FROM getcasepersonname ('adoptioncase',ac.adoptioncaseid::character varying))
		FROM adoptioncase ac
		WHERE ac.activeflag=1 
			/*
			AND ( SELECT exists 
						( SELECT 1 FROM routing ru 
						  WHERE ru.objectid = ac.adoptioncaseid::character varying 
							AND ru.eventcode = 'ADPC' 
							AND ru.activeflag = 1 
							AND ( ru.routingstatustypeid = 4 or ru.routingstatustypeid = 2 ) 
							AND ru.tosecurityusersid = userid 
						) 
				 )
			*/	 
			AND ( SELECT exists 
						( SELECT 1 FROM caseassignment ca 
						  WHERE ca.objectid = ac.adoptioncaseid 
							AND ca.toworkeridno = userid 
							AND (ca.enddate IS NULL OR ca.enddate > now()) 
						) 
				 )
		AND (casenumber is null or casenumber = '' or ac.adoptioncasenumber like '%' ||   LOWER(casenumber) ||  '%')
		and CASE WHEN v_status is NOT NULL then 
				( lower(ac.statustypekey) = lower(v_status) ) 
			ELSE 
				TRUE 
			end
		ORDER BY ac.startdate DESC
	) AS datav 
	WHERE datav.restrictStatus IN ('INCL','INCLRES','EXCLUDE');	

END;

$function$
;

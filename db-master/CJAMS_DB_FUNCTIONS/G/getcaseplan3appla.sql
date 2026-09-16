DROP  FUNCTION IF EXISTS cjams.getcaseplan3appla(v_caseid character varying, v_caseplanid character varying);
CREATE OR REPLACE FUNCTION cjams.getcaseplan3appla(v_caseid character varying, v_caseplanid character varying)
 RETURNS TABLE(caseplan3appla json)
 LANGUAGE plpgsql
AS $function$ 
DECLARE l_caseplan  json;
BEGIN	
SELECT json_agg(t)  INTO l_caseplan
		FROM (
			SELECT	(select servicecasenumber from servicecase where servicecaseid = cp.caseid) caseid
					, cp.old_id old_id
					, (p.firstname ||' '|| p.lastname) AS childname
					, p.prefx, p.firstname,p.middlename,p.lastname, p.suffix
					, cp.timelyassessment a1
					, cp.permenancyoptions a2
					, cp.permenantplacement a3
					, cp.childpreference a4
					, cp.compellingreason a5
					, cp.justify a6
					, cpa.supportstructures a7
					, cpa.specialneeds a8
					, cpa.accessefforts a9
					, cpa.selfsufficiency a10
					, cpa.adultpeersupport a11
					, cpa.supportiveservices a12
			FROM 	caseplan3 cp 
					LEFT JOIN caseplan3appla2 cpa ON cpa.caseplan3applaid = cp.caseplan3applaid AND cpa.activeflag  = 1 
					INNER JOIN  person p ON p.personid = cp.personid AND p.activeflag =1
			WHERE 	cp.caseplan3id = v_caseplanid::uuid
					AND cp.activeflag  = 1
	) t;	

RETURN QUERY 
SELECT l_caseplan;
END;

$function$
;
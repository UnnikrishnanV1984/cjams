CREATE OR REPLACE FUNCTION cjams.getpersonprogramcasedetails(v_caseid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE
 
declare returnvalue json;

BEGIN
	
     SELECT json_agg(e) INTO returnvalue FROM(
		SELECT cr.casenumber, cr.cisrefid, upn.phonenumber
		FROM 
		cjamscisref cr
		LEFT JOIN caseassignment ca ON ca.objectid = cr.objectid AND ca.activeflag = 1
		LEFT JOIN userprofilephonenumber upn ON upn.securityusersid = ca.toworkeridno
		WHERE casenumber = v_caseid LIMIT 1
      )e ;

  RETURN returnvalue; 
end;
$function$

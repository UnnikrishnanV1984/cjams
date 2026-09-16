DROP FUNCTION IF EXISTS cjams.getlatestreleaseinfo(character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getlatestreleaseinfo(v_securityusersid character varying, v_application character varying)
 RETURNS table (releasedate date, publisheddate timestamp without time zone, lastlogindate timestamp without time zone, releaseflag boolean)
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_record 		json;
	v_releasedate 	date;
	v_releaseversionno character varying;
	v_lastlogindate	timestamp;

BEGIN
	
	SELECT cwlastlogindatetime INTO v_lastlogindate
		FROM cjams.userprofile
		WHERE securityusersid = v_securityusersid;

	UPDATE cjams.userprofile set cwlastlogindatetime = now() where securityusersid = v_securityusersid;
	
	RETURN QUERY
		select r.releasedate, r.insertedon as publisheddate, v_lastlogindate, 
			CASE WHEN v_lastlogindate IS NULL OR v_lastlogindate <= r.insertedon THEN true ELSE false END as releaseflag
			from defecttracking.releasenotes r 
			where r.activeflag = 1
			and r.publish is true
			and r.application = v_application
			order by r.releasedate desc
			limit 1;
END;

$function$;

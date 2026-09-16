DROP FUNCTION IF EXISTS cjams.jirasupportticketslist(character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.jirasupportticketslist(v_jiraenv character varying, v_application character varying)
 RETURNS TABLE(supportlogid uuid, jirarequestno character varying, status character varying,jiraticketresolution character varying, cdmticketno character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE

	
BEGIN

	RETURN QUERY
		SELECT distinct s.supportlogid, s.jirarequestno, s.status, s.jiraticketresolution, s.cdmticketno
				FROM defecttracking.supportlog s
				WHERE CASE WHEN v_application IS NOT NULL THEN s.application = v_application ELSE true END
					AND s.jirarequestsent = 'Approved'
					AND s.jirarequestno IS NOT NULL
				    AND s.status != 'Closed'
					AND CASE WHEN v_jiraenv is not null THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1;
END;

$function$
;

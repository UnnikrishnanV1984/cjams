DROP FUNCTION IF EXISTS cjams.getsupportlogcounts(character varying, character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getsupportlogcounts(v_securityusersid character varying, v_jiraenv character varying, v_application character varying)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_tickets			INTEGER;
	v_pendingapproval 	INTEGER;
	v_approved			INTEGER;
	v_rejected			INTEGER;
	
	v_teamtickets		INTEGER;
	v_countytickets		INTEGER;
	v_countypendingapproval INTEGER;
	v_countyapproved	INTEGER;
	v_countyrejected	INTEGER;
	v_waitingonuser		INTEGER;
	v_waitingonssa		INTEGER;
	v_counts			JSON;
	
BEGIN

		SELECT count(*) INTO v_tickets
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;
	
		SELECT count(*) INTO v_pendingapproval
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.jirarequestsent is null
					AND s.activeflag = 1) e;
				
		SELECT count(*) INTO v_approved
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.jirarequestsent = 'Approved'
					AND s.activeflag = 1) e;
				
		SELECT count(*) INTO v_rejected
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.jirarequestsent = 'Rejected'
					AND s.activeflag = 1) e;

		SELECT distinct count(*) INTO v_teamtickets
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN cjams.county c on c.countyid::character varying = t.countyid and c.activeflag = 1
					JOIN teammember tm1 on tm1.teamid = t.teamid and tm1.activeflag = 1
					JOIN teammemberassignment tma1 on tma1.teammemberid = tm1.teammemberid and tma1.activeflag = 1
					JOIN defecttracking.supportlog s on s.insertedby = tma1.securityusersid and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					and s.ldssregion = c.countyname
					AND s.application = v_application) e;
				
		SELECT distinct count(*) INTO v_countytickets
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.application = v_application) e;
		
		SELECT distinct count(*) INTO v_countypendingapproval
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND s.application = v_application
					AND s.jirarequestsent is null
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;	

		SELECT distinct count(*) INTO v_countyapproved
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND s.application = v_application
					AND s.jirarequestsent = 'Approved'
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;
				
		SELECT distinct count(*) INTO v_countyrejected
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND s.application = v_application
					AND s.jirarequestsent = 'Rejected'
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;
					
		SELECT distinct count(*) INTO v_waitingonuser
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.status ilike '%Waiting for User Response%'
						AND s.application = v_application
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1) e;			
		
		SELECT distinct count(*) INTO v_waitingonssa
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.status like 'Waiting for SSA/Product Owner%'
						AND s.application = v_application
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1) e;		

	
	SELECT row_to_json(a) INTO v_counts 
		FROM (SELECT v_tickets as tickets,
					v_pendingapproval as pendingapproval,
					v_approved as approved,
					v_rejected as rejected,
					v_teamtickets as teamtickets,
					v_countytickets as countytickets,
					v_countypendingapproval as countypendingapproval,
					v_countyapproved as countyapproved,
					v_countyrejected as countyrejected,
					v_waitingonuser as waitingonuser,
					v_waitingonssa as waitingonssa) a;
					
	RETURN v_counts;
					
END;

$function$
;

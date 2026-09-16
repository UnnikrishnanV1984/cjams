DROP FUNCTION IF EXISTS  cjams.assignmentupdate(appeventcode character varying, v_status character varying, v_objectid character varying,  v_fromuserid character varying, v_touserid character varying);
 CREATE OR REPLACE FUNCTION cjams.assignmentupdate(appeventcode character varying, v_status character varying, v_objectid character varying,  v_fromuserid character varying, v_touserid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE l_fromteamid uuid;
		l_fromparentteamid uuid;
		l_toteamid uuid;
		l_fromldssid uuid;
		l_toldssid uuid;
		l_tocount int default 0;
		
BEGIN
SELECT 	tm.teamid, t.parentteamid, t.countyid INTO l_fromteamid, l_fromparentteamid, l_fromldssid
FROM 	teammemberassignment tma
		INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
		INNER JOIN team t ON t.teamid = tm.teamid  AND t.activeflag =1
WHERE tma.securityusersid = v_fromuserid AND tma.activeflag = 1;


SELECT 	count(*) INTO l_tocount
FROM 	teammemberassignment tma
		INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
		INNER JOIN team t ON t.teamid = tm.teamid  AND t.activeflag =1
WHERE tma.securityusersid = v_touserid AND tma.activeflag = 1;

		
SELECT 	tm.teamid, t.countyid INTO l_toteamid, l_toldssid
FROM 	teammemberassignment tma
		INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
		INNER JOIN team t ON t.teamid = tm.teamid  AND t.activeflag =1
WHERE tma.securityusersid = v_touserid AND tma.activeflag = 1 and case when l_tocount > 0 then (t.parentteamid in (l_fromteamid,l_fromparentteamid) OR t.teamid in (l_fromteamid,l_fromparentteamid)) else true end;
				
IF (appeventcode='APPL' AND v_status = 'ASSIGN' ) THEN 
	INSERT INTO caseassignment( fromworkeridno, toworkeridno, effectivetime, effectivedate, insertedby, updatedby, insertedon, updatedon, 
								objecttypekey, objectid, responsibilitytypekey, fromteamid,toteamid,startdate,fromldssid,toldssid,assignmenttype,assigndate)
			VALUES(v_fromuserid, v_touserid, now(), now(), v_fromuserid,v_fromuserid, now(), now(),
								'servicerequest', v_objectid::uuid, NULL, l_fromteamid, l_toteamid, now() ,l_fromldssid,l_toldssid,'W',now()::date);
ELSIF (appeventcode='APPL' AND v_status = 'COMPLETE' ) THEN  
	UPDATE caseassignment SET enddate = now() WHERE objectid::character varying = v_objectid AND toworkeridno = v_touserid AND enddate IS NULL;
END IF;
return 'SUCCESS';
END;
$function$
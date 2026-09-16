create materialized view mv_getworkloadassignmentsummary as
SELECT  
				SUM(1) totalcnt,
				SUM (CASE WHEN CA.enddate IS NULL  AND COALESCE(issupervisor,0) =0 THEN 1 ELSE 0 END ) opencnt,
				SUM (CASE WHEN CA.enddate IS NOT NULL  AND COALESCE(issupervisor,0) =0 THEN 1 ELSE 0 END ) closedcnt,
				SUM (CASE WHEN CA.enddate IS NULL THEN 1 ELSE 0 END) vsumopencnt,
				SUM (CASE WHEN CA.enddate IS NOT NULL THEN 1 ELSE 0 END) vsumclosedcnt,
				SUM(CASE COALESCE(tma.issupervisor,0) WHEN 1 THEN 1 ELSE 0 END ) ytscnt,
				pt.teamid,
			pt.teamname 
	
	FROM (
				SELECT ca.startdate,CA.enddate,null insertedon,ca.toteamid,CA.toworkeridno,ca.activeflag from  caseassignment CA
		 		UNION ALL 
		 		SELECT null startdate,null enddate,R.insertedon,r.teamid toteamid,r.tosecurityusersid toworkeridno,r.activeflag from  routing R 
		 		WHERE r.routingstatustypeid = 1 and r.eventcode = 'INTR'
		) CA  
			INNER JOIN team T ON T.teamid = CA.toteamid AND T.activeflag =1
			INNER JOIN team pt on pt.teamid =t.parentteamid and pt.teamtypekey ='LDSS' AND pt.activeflag =1
			LEFT  JOIN 
				(SELECT tma.securityusersid, 1 issupervisor
				 FROM teammemberassignment tma 
				 INNER join teammember tm ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
				 INNER join teammemberroletype  tmrt ON tmrt.roletypekey = tm.roletypekey  AND tmrt.activeflag= 1 
					and tmrt.isupervisor   = true  and tma.activeflag =1  
				)tma ON tma.securityusersid = ca.toworkeridno
			WHERE CA.activeflag=1  
			group by pt.teamid,pt.teamname;

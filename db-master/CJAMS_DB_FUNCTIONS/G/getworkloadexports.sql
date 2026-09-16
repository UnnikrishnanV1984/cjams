DROP FUNCTION IF EXISTS cjams.getworkloadexports(v_securityuserid character varying, v_servicecasenumber character varying, v_teamid uuid, v_toworkerid character varying, v_countycode character varying, v_startdate date, v_enddate date, v_status character varying, v_localdeptid uuid, pageno integer, pagesize integer, v_casetype character varying, v_sortcol character varying, v_sortorder character varying);
CREATE OR REPLACE FUNCTION cjams.getworkloadexports(v_securityuserid character varying, v_servicecasenumber character varying, v_teamid uuid, v_toworkerid character varying, v_countycode character varying, v_startdate date, v_enddate date, v_status character varying, v_localdeptid uuid, pageno integer, pagesize integer, v_casetype character varying, v_sortcol character varying, v_sortorder character varying)
 RETURNS TABLE(totalcount bigint, responsibilitytypekey character varying, casetype character varying, countyname character varying, teamname character varying, startdate timestamp without time zone, enddate timestamp without time zone, statustypekey character varying, remarks character varying, toteamid character varying, toworkeridno character varying, servicecasenumber character varying, servicecaseid character varying, assignedby character varying, assignedto character varying, cjamspid character varying, localdepartment character varying, actiontype character varying, personname character varying, legalguardian json, isrestricted boolean)
 LANGUAGE plpgsql
AS $function$

BEGIN

	RETURN QUERY 
   SELECT COUNT(1) over(),*
   		, 	(select getcasepersonname as legalguardian FROM getcasepersonname (CA.casetype,CA.caseid::character varying) limit 1)::json,
   			CASE WHEN ca.casetype='intake' THEN false 
			   WHEN v_securityuserid = (SELECT supervisorid FROM userprofile WHERE securityusersid= ca.toworkeridno) THEN false
			   ELSE (SELECT CASE WHEN count(1) > 0 then true else false END FROM restricteditems Rst WHERE Rst.objectid = CA.caseid::character varying and rst.accessuserid = CA.toworkeridno and rst.activeflag=1) end isrestricted
	 
   FROM (
   SELECT 
		DISTINCT
		CA.responsibilitytypekey, 
		CA.objecttypekey as casetype,
		c.countyname ::character varying countyname,
		T.teamname,
		CA.startdate,
		CA.enddate,
		CASE   WHEN CA.enddate IS NULL THEN 'Open' ELSE 'Closed' END :: character varying  statustypekey,
		--case when COALESCE(tma.issupervisor,0) = 1 then 'Pending' when ca.enddate is null then 'Open' else 'Closed' end :: character varying as statustypekey,
		--CA.statustypekey,
		CA.remarks,
		CA.toteamid ::CHARACTER VARYING,
		CA.toworkeridno,
		COALESCE(SC.servicecasenumber) servicecasenumber ,
		SC.caseid ::CHARACTER VARYING,
		(SELECT CAST(UP2.firstname || ' ' || UP2.lastname AS character varying) 
		FROM  userprofile UP2  
		WHERE UP2.securityusersid = CA.fromworkeridno AND UP2.activeflag =1 LIMIT 1) assignedby,		
		(SELECT	CAST(UP.firstname || ' ' || UP.lastname AS character varying)  
		FROM   userprofile UP 
		WHERE UP.securityusersid = CA.toworkeridno AND UP.activeflag =1 LIMIT 1) assignedto,
		(SELECT UP.cjamspid FROM   userprofile UP WHERE UP.securityusersid = CA.toworkeridno AND UP.activeflag =1 LIMIT 1)::character varying  AS cjamspid ,		  
		(CASE COALESCE(ca.toldssid::character varying ,'') 
			WHEN '' THEN c.countyname
			ELSE (SELECT c1.countyname from county c1 WHERE c1.countyid = ca.toldssid LIMIT 1)
		END )::character varying parentteamname,
		/*(SELECT ld.teamname FROM team ld WHERE (ld.teamid = t.parentteamid OR ld.teamid = DT.teamid) AND ld.activeflag =1 AND ld.teamtypekey ='LDSS' LIMIT 1) ::character varying parentteamname,*/
		SC.actiontype ::character varying,
		''::character varying legalguard1
/* COMMENTED OUT FOR PERFORMANCE OPTIMIZATION, THIS IS UNUSED IN UI, 05/21/2020
 		(case
			v_sortcol
			when 'legalguardian' then  (SELECT    concat_ws (' ',coalesce(p.firstname,''),coalesce(p.middlename,''),coalesce(p.lastname,''),coalesce(p.suffix,'') ):: character varying as personname
			FROM  intakeservicerequestactor ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1  
			WHERE	ISRA.activeflag =1   and     ISRA.isheadofhousehold=true  
		--	AND		ISRA.intakeservicerequestpersontypekey = 'LG'  
			AND		CASE lower(CA.objecttypekey) WHEN 'servicecase'  THEN  ISRA.servicecaseid  = objectid ELSE ISRA.intakeserviceid   = objectid END ORDER BY coalesce(p.firstname,'')  LIMIT 1 )
		ELSE
			''
		END):: character varying legalguard1 */
		FROM 	caseassignment CA 
			INNER JOIN   
		  (
		  	SELECT sc.servicecaseid caseid,  sc.servicecasenumber, 'Service Case'::character varying AS actiontype 
					--(select getcasepersonname as legalguardian from getcasepersonname ('servicecase',sc.servicecaseid::character varying))::json legalguardian
			FROM servicecase sc WHERE sc.activeflag =1 AND 
		  	CASE COALESCE(v_casetype,'') WHEN 'servicecase' THEN TRUE WHEN '' THEN TRUE ELSE 1=2 end
		  	UNION ALL
			SELECT ac.adoptioncaseid caseid,  ac.adoptioncasenumber, 'Adoption Case'::character varying AS actiontype 
			FROM adoptioncase ac WHERE ac.activeflag =1 AND 
		  	CASE COALESCE(v_casetype,'') WHEN 'adoptioncase' THEN TRUE WHEN '' THEN TRUE ELSE 1=2 END
		  	UNION ALL 
		  	SELECT isr.intakeserviceid caseid,  isr.servicerequestnumber,
				case isr.actiontype when   'IR' then 'CPS-IR' when  'AR' then 'CPS-AR' else null  end  actiontype
				--(select getcasepersonname as legalguardian from getcasepersonname ('servicerequest',isr.intakeserviceid::character varying))::json			
			FROM intakeservicerequest isr WHERE isr.activeflag =1 
		  		AND teamtypekey ='CW' 
		  		AND isr.actiontype in ('AR','IR') 
				AND 	CASE v_casetype 
	    				WHEN 'IR' THEN isr.actiontype = 'IR' 
	    				WHEN 'AR' THEN isr.actiontype = 'AR' 
	    				WHEN 'intake' THEN false
	    				WHEN 'servicecase' THEN false
	    				WHEN 'adoptioncase' THEN false
	    			ELSE true end
	    	) sc  ON  sc.caseid = ca.objectid 
	--LEFT JOIN team DT on DT.teamid = CA.toldssid AND DT.activeflag =1
	
	LEFT JOIN team T on T.teamid = CA.toteamid AND T.activeflag =1
	LEFT JOIN county c on c.countyid = t.countyid::uuid AND C.activeflag =1
	LEFT JOIN 
		(SELECT tma_inner.securityusersid, 1 issupervisor,tm.teamid
		 FROM teammemberassignment tma_inner 
		 INNER JOIN teammember tm ON tm.teammemberid = tma_inner.teammemberid AND tm.activeflag= 1
		 LEFT JOIN teammemberroletype tmrt ON tmrt.roletypekey = tm.roletypekey AND tmrt.activeflag= 1 
			AND tmrt.isupervisor= true AND tma_inner.activeflag =1  
		) tma ON tma.securityusersid = ca.toworkeridno
	WHERE CA.activeflag=1 --AND COALESCE(CA.assignmenttype,'W') <>'T'
	--AND ca.enddate IS   NULL 
	--AND objecttypekey='servicecase' 
		AND	CASE WHEN v_servicecasenumber IS NOT NULL THEN (SC.servicecasenumber= v_servicecasenumber) ELSE true END
		AND CASE WHEN v_teamid IS NOT NULL THEN (tma.teamid= v_teamid ) ELSE true END
		--AND CASE WHEN v_localdeptid IS NOT NULL THEN (t.parentteamid= v_localdeptid OR DT.teamid = v_localdeptid ) ELSE true END
		AND CASE WHEN v_localdeptid IS NOT NULL THEN (v_localdeptid in (t.countyid::uuid,ca.fromldssid)  ) ELSE true END
		AND CASE WHEN v_toworkerid IS NOT NULL THEN (CA.toworkeridno= v_toworkerid ) ELSE true END
		AND CASE WHEN v_startdate IS NOT null THEN CASE when CA.startdate is not null THEN CA.startdate::date >= v_startdate ELSE false END 
 			 ELSE true END
		AND CASE WHEN v_enddate IS NOT null THEN CASE when CA.enddate is not null THEN CA.enddate::date <= v_enddate ELSE false END
				ELSE true end
		AND CASE WHEN v_status is not null THEN 
    			CASE v_status
    				WHEN 'all' THEN true
    				WHEN 'yts' THEN false
    				WHEN 'open' THEN CA.enddate is null  
    				WHEN 'closed' THEN CA.enddate is not null  
    				WHEN 'review' THEN false
    			ELSE true END
    		 ELSE true end
    --AND CA.fromworkeridno =  v_securityuserid		 
	-- AND COALESCE(tma.issupervisor,0) = (CASE v_status WHEN 'yts' THEN 1 ELSE 0 END )
	-- AND	CASE WHEN v_status='open' THEN CA.enddate IS NULL WHEN v_status='closed' THEN CA.enddate IS NOT NULL ELSE true END 
	
    		 
    UNION ALL
	
	select DISTINCT
		
		CA.responsibilitytypekey,
		 
		'intake' as casetype,
		c.countyname ::character varying countyname,
		T.teamname,
		CA.startdate,
		CA.enddate,
		CASE   WHEN CA.enddate IS NULL   THEN 'Open' ELSE 'Closed' END :: character varying  statustypekey,
		--(CASE COALESCE(IDS.status,0) WHEN 0 THEN 'Pending'  WHEN 1 THEN 'Pending' ELSE 'Closed' END )::character varying statustypekey,
		CA.remarks,
		CA.toteamid  ::CHARACTER VARYING,
		CA.toworkeridno,
	    ids.intakenumber servicecasenumber ,
	    ids.intakenumber  caseid,
	    (SELECT CAST(UP2.firstname || ' ' || UP2.lastname AS character varying) 
		 FROM  userprofile UP2  
		 WHERE UP2.securityusersid = CA.fromworkeridno AND UP2.activeflag =1 LIMIT 1
		) assignedby,		
		(SELECT	CAST(UP.firstname || ' ' || UP.lastname AS character varying)  
		 FROM   userprofile UP 
		 WHERE UP.securityusersid = CA.toworkeridno AND UP.activeflag =1 LIMIT 1
		) assignedto,
		(SELECT UP.cjamspid FROM   userprofile UP WHERE UP.securityusersid = CA.toworkeridno AND UP.activeflag =1 LIMIT 1)::character varying  AS cjamspid ,
		--dt.teamname localdepartment,
		c.countyname localdepartment,
		'Intake' actiontype,
		'' legalguard1
	 FROM 	caseassignment CA 
			INNER JOIN   intakedastatus IDS ON IDS.intakedastatusid = CA.objectid AND IDS.activeflag =1
			INNER JOIN 	 teammemberassignment tma ON tma.securityusersid = CA.toworkeridno AND tma.activeflag =1
			INNER JOIN   teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1			
			INNER JOIN 	 team t on t.teamid = CA.toteamid  and t.activeflag =1
			--LEFT join    team dt on dt.teamid = t.parentteamid and dt.activeflag = 1
			LEFT join    county c on c.countyid = t.countyid::uuid and c.activeflag = 1
     WHERE 	CA.activeflag = 1 --AND COALESCE(CA.assignmenttype,'W') <>'T'
			AND	CASE WHEN v_servicecasenumber IS NOT NULL THEN (IDS.intakenumber = v_servicecasenumber) ELSE true END
			AND CASE WHEN v_teamid IS NOT NULL THEN (tm.teamid= v_teamid ) ELSE true END		
			AND CASE WHEN v_toworkerid IS NOT NULL THEN (CA.toworkeridno= v_toworkerid ) ELSE true END
			--AND CASE WHEN v_localdeptid IS NOT NULL THEN (t.parentteamid= v_localdeptid OR DT.teamid = v_localdeptid ) ELSE true END
			AND CASE WHEN v_localdeptid IS NOT NULL THEN ( v_localdeptid in (t.countyid::uuid,ca.fromldssid) ) ELSE true END
			AND CASE v_casetype 
					WHEN 'intake' THEN true
					WHEN 'IR' THEN false 
					WHEN 'AR' THEN false
					WHEN 'noncps' THEN false
					WHEN 'servicecase' THEN false
					WHEN 'adoptioncase' THEN false
				ELSE true end
			AND CASE WHEN v_status is not null THEN 
					CASE v_status
						WHEN 'all' THEN true
						WHEN 'yts' THEN  false
						WHEN 'open' THEN  CA.enddate is null 
						WHEN 'closed' THEN  CA.enddate is not null 
					ELSE true END
				ELSE true end
    --AND CA.fromworkeridno= v_securityuserid		 
    		 ) CA
    ORDER BY 
    (
	case
		v_sortorder
		when 'asc' then
		case
			v_sortcol
			when 'legalguardian' then   (select (json_array_elements(getcasepersonname) ->> 'personname') :: character varying  FROM getcasepersonname (CA.casetype,CA.caseid::character varying) limit 1) ::character varying 
			when 'servicecasenumber' then CA.servicecasenumber 
			when 'localdepartment' then   COALESCE(CA.parentteamname ,'')
			when 'assignedby' then   COALESCE(CA.assignedby ,'')
			when 'assignedto' then   COALESCE(CA.assignedto ,'')
			when 'responsibilitytypekey' then  COALESCE(CA.responsibilitytypekey ,'') 
			when 'actiontype' then COALESCE(CA.actiontype,'')
			when 'statustypekey' then CA.statustypekey
			when 'teamname' then  COALESCE(CA.teamname ,'')  
			when 'startdate' then  COALESCE(cast( CA.startdate as character varying),'')
			when 'enddate' then  COALESCE(cast( CA.enddate as character varying),'')
			else CA.servicecasenumber 
		end
		else  NULL 
	end) asc nulls last,
	(
	case
		v_sortorder
		when 'desc' then
		case
			v_sortcol
			when 'legalguardian' then  (select json_array_elements(getcasepersonname) ->> 'personname'   FROM getcasepersonname (CA.casetype,CA.caseid::character varying) limit 1 )::character varying 
			when 'servicecasenumber' then CA.servicecasenumber 
			when 'localdepartment' then   COALESCE(CA.parentteamname ,'')
			when 'assignedby' then   COALESCE(CA.assignedby ,'')
			when 'assignedto' then   COALESCE(CA.assignedto ,'')
			when 'responsibilitytypekey' then COALESCE(CA.responsibilitytypekey ,'') 
			when 'actiontype' then COALESCE(CA.actiontype,'')
			when 'statustypekey' then CA.statustypekey
			when 'teamname' then  COALESCE(CA.teamname ,'')  
			when 'startdate' then  COALESCE(cast( CA.startdate as character varying),'')
			when 'enddate' then  COALESCE(cast( CA.enddate as character varying),'')
			else CA.servicecasenumber 
		end
		else NULL
	end ) desc nulls last;
    
	--LIMIT pagesize OFFSET (pageno - 1) * pagesize;

END;

$function$
;


CREATE OR REPLACE FUNCTION cjams.getworkloadassignments(v_securityuserid character varying, v_servicecasenumber character varying, v_teamid uuid, v_toworkerid character varying, v_countycode character varying, v_startdate date, v_enddate date, v_status character varying, v_localdeptid uuid, pageno integer, pagesize integer, v_casetype character varying, v_sortcol character varying, v_sortorder character varying)
 RETURNS TABLE(totalcount bigint, responsibilitytypekey character varying, casetype character varying, countyname character varying, teamname character varying, startdate timestamp without time zone, enddate timestamp without time zone, statustypekey character varying, remarks character varying, toteamid character varying, toworkeridno character varying, servicecasenumber character varying, servicecaseid character varying, assignedby character varying, assignedto character varying, cjamspid character varying, localdepartment character varying, actiontype character varying, personname character varying, legalguardian json, isrestricted boolean)
 LANGUAGE plpgsql
AS $function$

-------------------------------------------
-- CDM-29628 - VEERA Nadimpalli 05-25 Intake workload issue fix
-- CDM-34341 - Manasa Kasula 09-21 Supervisor Workload for type Intake issue fixes
-------------------------------------------

declare 

v_statustext int;
v_parentteamid uuid;

BEGIN
	v_statustext := 1;	

	RETURN QUERY 
		SELECT COUNT(1) over(),*
		, (select getcasepersonname as legalguardian FROM getcasepersonname (CA.casetype,CA.caseid::character varying) limit 1)::json,
			CASE WHEN ca.casetype='intake' THEN false 
				WHEN v_securityuserid = (SELECT supervisorid FROM userprofile WHERE securityusersid= ca.toworkeridno) THEN false
				WHEN  0 = (SELECT count(1) FROM restricteditems rt WHERE rt.objectid = ca.caseid::character varying and rt.activeflag=1) THEN false
				ELSE (SELECT CASE WHEN count(1) > 0 then false else true END FROM restricteditems Rst WHERE Rst.objectid = CA.caseid::character varying
				and rst.accessuserid = v_securityuserid and rst.activeflag=1) end isrestricted	 
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
		SC.actiontype ::character varying,
		''::character varying legalguard1

		FROM 	caseassignment CA 
			INNER JOIN   
			(
			SELECT sc.servicecaseid caseid,  sc.servicecasenumber, 'Service Case'::character varying AS actiontype 
			FROM servicecase sc WHERE sc.activeflag =1 AND 
			CASE COALESCE(v_casetype,'') WHEN 'servicecase' THEN TRUE WHEN '' THEN TRUE ELSE 1=2 end
			UNION ALL
			SELECT ac.adoptioncaseid caseid,  ac.adoptioncasenumber, 'Adoption Case'::character varying AS actiontype 
			FROM adoptioncase ac WHERE ac.activeflag =1 AND 
			CASE COALESCE(v_casetype,'') WHEN 'adoptioncase' THEN TRUE WHEN '' THEN TRUE ELSE 1=2 END
			UNION ALL 
			SELECT isr.intakeserviceid caseid,  isr.servicerequestnumber,
				case isr.actiontype when   'IR' then 'CPS-IR' when  'AR' then 'CPS-AR' else null  end  actiontype
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
	LEFT JOIN team T on T.teamid = CA.toteamid AND T.activeflag =1
	LEFT JOIN county c on c.countyid = t.countyid::uuid AND C.activeflag =1
	LEFT JOIN 
		(SELECT tma_inner.securityusersid, 1 issupervisor,tm.teamid
			FROM teammemberassignment tma_inner 
			INNER JOIN teammember tm ON tm.teammemberid = tma_inner.teammemberid AND tm.activeflag= 1
			LEFT JOIN teammemberroletype tmrt ON tmrt.roletypekey = tm.roletypekey AND tmrt.activeflag= 1 
			AND tmrt.isupervisor= true AND tma_inner.activeflag =1  
		) tma ON tma.securityusersid = ca.toworkeridno
	WHERE CA.activeflag=1 
		AND	CASE WHEN v_servicecasenumber IS NOT NULL THEN (SC.servicecasenumber= v_servicecasenumber) ELSE true END
		AND CASE WHEN v_teamid IS NOT NULL THEN (tma.teamid= v_teamid ) ELSE true END
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
	UNION ALL

	select DISTINCT
		'intake' :: character varying as responsibilitytypekey,	 
		'intake' :: character varying as casetype,
		c.countyname :: character varying as countyname,
		cast (up.teamname as character varying),
		cast (IDAS.DateRecieved as timestamp without time zone) as startdate,
		null :: timestamp without time zone as enddate,
		case when coalesce(IDAS.ispreintake, false) = true then 'Closed' when coalesce(IDAS.ispreintake, false) = false and coalesce (ITDS.Status, 0)in (0, 1) and r.objectid is not null then 'Pending' else 'Open' :: character varying end as statustypekey,
		r.remarks :: character varying,
		null :: character varying as toteamid,
		null :: character varying as toworkeridno,
		ITDS.intakenumber :: character varying as servicecasenumber ,
		ITDS.intakenumber :: character varying as caseid,
		null :: character varying as assignedby,		
		up.fullname :: character varying as assignedto,
		up.cjamspid :: character varying  AS cjamspid,
		c.countyname :: character varying as localdepartment,
		'Intake' :: character varying as actiontype,
		'' :: character varying as legalguard1
		from IntakeDAStaging IDAS
		inner join intakeDAStatus ITDS on ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW'
		left join routing r on r.objectid = IDAS.intakenumber and ((r.activeflag = 1 and r.eventcode in ('INTR','KINR')) or (r.activeflag = 0 and r.eventcode = 'XXXX'))
		left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
		left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
		left join v_userprofile up on up.securityusersid = IDAS.CRUWorkerName  
		left join county c on c.countyid = (IDAS.jsondata->'General'->>'countyid')::uuid and c.activeflag =1
		left join intakeservicerequest ISR on ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1
		where lower(IDAS.Status) in ('pending','closed','complete') and 
		((case when v_toworkerid is not null then IDAS.intakeuser = v_toworkerid
				when (v_toworkerid is null and v_teamid is not null) then IDAS.intakeuser in (select securityusersid from v_userprofile where teamid = v_teamid)
				when (v_toworkerid is null and v_teamid is null and v_localdeptid is not null) then IDAS.intakeuser in (select securityusersid from v_userprofile where parentteamid = v_localdeptid)
			ELSE r.routingstatustypeid = v_statustext
			END)
		or (case when v_toworkerid is not null then r.tosecurityusersid = v_toworkerid
						when (v_toworkerid is null and v_teamid is not null) then r.tosecurityusersid in (select securityusersid from v_userprofile where teamid = v_teamid)
						when (v_toworkerid is null and v_teamid is null and v_localdeptid is not null) then r.tosecurityusersid in (select securityusersid from v_userprofile where parentteamid = v_localdeptid)
					ELSE true
					END)
		or (case when v_toworkerid is not null then ITDS.intakeuser = v_toworkerid
						when (v_toworkerid is null and v_teamid is not null) then ITDS.intakeuser in (select securityusersid from v_userprofile where teamid = v_teamid)
						when (v_toworkerid is null and v_teamid is null and v_localdeptid is not null) then ITDS.intakeuser in (select securityusersid from v_userprofile where parentteamid = v_localdeptid)
					ELSE true
					END))	
		and IDAS.Activeflag = 1
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
					WHEN 'yts' THEN coalesce(IDAS.ispreintake, false) = false and coalesce (ITDS.Status, 0)in (0, 1) and ISR.intakenumber is null and r.objectid is not null
					WHEN 'open' THEN coalesce(IDAS.ispreintake, false) = false and lower(IDAS.Status) in ('pending') and ISR.intakenumber is null and r.objectid is null
					WHEN 'closed' THEN ((coalesce(IDAS.ispreintake, false) = true and lower(IDAS.Status) in ('closed','complete')) or (r.activeflag = 0 and r.eventcode = 'XXXX' and r.routingstatustypeid = 2))
				ELSE true END
			ELSE true end	 
		
		UNION

		select DISTINCT
		'intake' :: character varying as responsibilitytypekey,	 
		'intake' :: character varying as casetype,
		up.countyname :: character varying as countyname,
		cast (up.teamname as character varying),
		cast (IDAS.insertedon as timestamp without time zone) as startdate,
		null :: timestamp without time zone as enddate,
		'Closed' as statustypekey,
		r.remarks :: character varying,
		null :: character varying as toteamid,
		null :: character varying as toworkeridno,
		ITDS.intakenumber :: character varying as servicecasenumber ,
		ITDS.intakenumber :: character varying as caseid,
		null :: character varying as assignedby,		
		up.fullname :: character varying as assignedto,
		up.cjamspid :: character varying  AS cjamspid,
		up.countyname :: character varying as localdepartment,
		'Intake' :: character varying as actiontype,
		'' :: character varying as legalguard1
		from intakeservicerequest IDAS
		inner join intakeDAStatus ITDS on ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW'
		left join routing r on r.objectid = IDAS.intakenumber and r.activeflag = 1 and r.eventcode in ('INTR', 'KINR')
		left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
		left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
		left join v_userprofile up on up.securityusersid = ITDS.intakeuser  
		where IDAS.activeflag = 1 and IDAS.teamtypekey ='CW' and 
		ITDS.intakenumber NOT IN (SELECT ids.intakenumber FROM intakedastaging ids WHERE activeflag =1) and 
		(case when v_toworkerid is not null then ITDS.intakeuser = v_toworkerid
						when (v_toworkerid is null and v_teamid is not null) then ITDS.intakeuser in (select securityusersid from v_userprofile where teamid = v_teamid)
						when (v_toworkerid is null and v_teamid is null and v_localdeptid is not null) then ITDS.intakeuser in (select securityusersid from v_userprofile where parentteamid = v_localdeptid)
					ELSE true
					END)	
		and IDAS.Activeflag = 1 and ITDS.status = 8 
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
					WHEN 'yts' THEN false
					WHEN 'open' THEN false
					WHEN 'closed' THEN true 
				ELSE true END
			ELSE true end
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
	end ) desc nulls last

	LIMIT pagesize OFFSET (pageno - 1) * pagesize;
END;

$function$
;

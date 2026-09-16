-- FUNCTION: cjams.listintakescreenindashboard(character varying, character varying, bigint, bigint, character varying, boolean, character varying, character varying)

-- DROP FUNCTION cjams.listintakescreenindashboard(character varying, character varying, bigint, bigint, character varying, boolean, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.listintakescreenindashboard(
	securityusersid character varying,
	status character varying,
	pagenumber bigint,
	pagesize bigint,
	intakeno character varying,
	bpreintake boolean,
	sortcolumn character varying,
	sortorder character varying)
RETURNS TABLE(totalcount bigint, intakechessieid character varying, id integer, intakenumber character varying, cpsresponse character varying, datereceived timestamp without time zone, timereceived timestamp without time zone, narrative text, raname character varying, entityname character varying, cruworkername character varying, isreview boolean, issupervisor boolean, datesubmitted timestamp without time zone, dateclosed timestamp without time zone, remarks text, reviewstatus character varying, disposition character varying, intakestatus character varying, timeleft character varying, jsondata jsonb, updateddate timestamp without time zone, agencycode character varying, canreopen integer, ispreintake boolean, clwstatus character varying, sdm json, isprior integer, headofhousehlod json, legalguardian json, youthname character varying, victimname character varying, djsyouthname character varying, youthfirstname character varying, youthlastname character varying, youth_suffix character varying, youthcjamspid bigint)
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
    ROWS 1000
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 06/05/2024 Akhil Katukuri  - Fix to display screen in records - commented 2nd union for screen in intake records. - CIDM-8842
-- 10/17/2024 Sundeep Kiran Anugolu  - Records duplicated under screen in/screen out tab. - CIDM-9610
------------------------------------------------------------------------------------------------------------	
declare v_status int;

v_UserSID character varying;

v_activeflag int;

v_pageoffset int;

v_pagenumber int;

v_statustext character varying;

l_disposition character varying;

begin
v_activeflag := 1;

v_UserSID := securityusersid;

v_pagenumber := pagenumber-1;

v_pageoffset = v_pagenumber * pagesize;

v_statustext := status;

if (status = 'intakescreenin') then v_status := 2;
elsif (status = 'intakescreenout') then v_status := 3;

end if;

if (sortcolumn = 'datereceived') then sortcolumn = 'receiveddate';
end if;

	IF (status = 'intakescreenin') THEN
		l_disposition:='SCREENIN';
	ELSIF (status = 'intakescreenout' ) THEN
 		l_disposition:='SCREENOUT';
	else 
		l_disposition:= status;
	END IF;

raise notice 'l_disposition%',l_disposition; 

if (v_status = 2) then 
raise notice 'v_status=2%',v_status; 
return QUERY 

SELECT * FROM (	
(SELECT
	  count(1) over()::bigint as totalcount
	, IDAS.old_id as intakechessieid 
	, 1 as id
	, IDAS.IntakeNumber as intakenumber
	, CAST(CASE ITDS.iscps WHEN true THEN 'CPS' WHEN false THEN 'Non  CPS' ELSE '' END  AS character varying) as cpsresponse
	, IDAS.reporteddate as datereceived
	, (to_char( IDAS.reportedtime::timestamp without time zone, 'YYYYMMDD"T"HH24MISS"Z"' )::timestamptz)::timestamp without time zone as timereceived
	, IDAS.Narrative as narrative
 	, COALESCE(IDAS.title, '') :: character varying raname
	, CAST('' as character varying) entityname
	, CAST(up.firstname || ' ' || up.lastname as character varying)  as cruworkername
	, COALESCE(r.isreviewrequest, false) as isreview
	, COALESCE(r.isupervisor, false) as issupervisor
	, r.insertedon as datesubmitted
	, r.updatedon  as dateclosed
	, r.remarks as remarks
	, CAST(case ITDS.status WHEN 0 THEN 'Draft' ELSE  r.typedescription END  as character varying)   as reviewstatus
	, CAST('' as character varying) disposition
	, CAST('' as character varying) intakestatus
	, CAST( case r.insertedon WHEN null THEN '' else case WHEN age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' THEN cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) end end as character varying) as timeleft
	, json_build_object('General',json_build_object(
								 'Narrative',IDAS.narrative
								 ,'Purpose',IDAS.intakeservreqtypeid ))::jsonb as jsondata
	, IDAS.updatedon as updateddate
	, ITDS.teamtypekey as agencycode 
	, 0 as canreopen 
	, ITDS.ispreintake as ispreintake
	, ''::character varying  as clwstatus
	, NULL  ::json as sdm
	, 0 isprior
	, (SELECT json_agg(x) as headofhousehlod FROM ( 
        SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE    ISRA.activeflag =1  
		AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
		AND ISRA.intakenumber = IDAS.IntakeNumber
		ORDER BY 1 ) as x):: json 
--	, ( SELECT getcasepersonname FROM  getcasepersonname ('servicerequest',IDAS.intakeserviceid:: character varying))
	, null:: json as legalguardian
/* 		, (SELECT json_agg(x)   as legalguardian FROM ( 
        SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE    ISRA.activeflag =1  
	    and ISRA.isheadofhousehold=true 
		AND ISRA.servicecaseid:: character varying = objectid
		ORDER BY 1 ) x):: json   */
	, ''::CHARACTER VARYING as youthname
	, ''::CHARACTER VARYING as  victimname
	, ''::CHARACTER VARYING as djsyouthname
	, ''::CHARACTER VARYING as youthfirstname
	, ''::CHARACTER VARYING as youthlastname
	, ''::CHARACTER VARYING as youth_suffix
	, NULL::bigint as youthcjamspid
FROM 	intakeservicerequest IDAS
		INNER JOIN 	intakeDAStatus ITDS ON 	ITDS.intakenumber = IDAS.intakenumber AND ITDS.activeflag =1 AND ITDS.teamtypekey = 'CW'
		INNER JOIN  (SELECT upf.securityusersid, upf.firstname, upf.lastname from userprofile upf where upf.securityusersid = v_UserSID) up ON up.securityusersid = ITDS.intakeuser
		LEFT JOIN (
					select rou.objectid, rts.typedescription, rt.isupervisor, rou.toroleid, rou.fromsecurityusersid, rou.isreviewrequest, rou.insertedon, rou.tosecurityusersid, rou.updatedon, rou.remarks, rou.routingstatustypeid, rou.toroleid 
					from routing rou 
					inner JOIN routingstatustype RTs ON  RTs.sequencenumber = rou.routingstatustypeid AND rts.activeflag = 1
					inner JOIN	teammemberroletype rt ON rt.roletypekey = rou.toroleid AND rt.activeflag = 1	
					where rou.activeflag = 1 and rou.eventcode in ('INTR','KINR') and (rou.tosecurityusersid = v_UserSID or rou.fromsecurityusersid = v_UserSID)
		) r ON r.objectid = IDAS.intakenumber
		/*LEFT JOIN 	intakereqforservconfig irsc ON irsc.intakenumber = IDAS.intakenumber
 		LEFT JOIN  (SELECT distinct isdc.intakeserviceid , srcd.dispositioncode,isdc.intakeserreqstatustypeid
					FROM 	intakeservicerequestdispositioncode isdc 
							INNER JOIN servicerequesttypeconfigdispositioncode srcd ON  srcd.servicerequesttypeconfigiddispostionid = isdc.servicerequesttypeconfigiddispostionid and srcd.activeflag = 1  
					WHERE	 isdc.activeflag = 1 
					) isd ON isd.intakeserviceid  = IDAS.intakeserviceid
		LEFT JOIN 	intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = isd.intakeserreqstatustypeid and ISRST.activeflag = 1 */
 WHERE 	IDAS.IntakeNumber like intakeno || '%'
		AND ITDS.intakenumber NOT IN (SELECT ids.intakenumber FROM intakedastaging ids WHERE activeflag =1)
		AND CASE v_status WHEN 8 THEN ITDS.status  IN (2,8) WHEN 1 THEN ITDS.status  IN (1,0) ELSE ITDS.status = v_status END
		AND  v_UserSID IN (r.tosecurityusersid,COALESCE(ITDS.intakeuser,r.fromsecurityusersid ))
		AND IDAS.Activeflag = 1 
		AND CASE COALESCE(lower(l_disposition),'') WHEN '' THEN FALSE  
											WHEN 'screenin'  THEN ITDS.status = 2  
											ELSE ITDS.status = 3 END
											)
UNION ALL 
(select
	count(1) over(),
	ISR.old_id as intakechessieid,
	IDAS.id,
	IDAS.IntakeNumber ,
	cast(case ITDS.iscps when true then 'CPS' when false then 'Non  CPS' else '' end as character varying),
	IDAS.DateRecieved,
	IDAS.TimeRecieved ::timestamp without time zone,
	IDAS.Narrative,
 IDAS.raname,
	IDAS.EntityName,
	cast(up.firstname || ' ' || up.lastname as character varying) ,
	coalesce(r.isreviewrequest, false),
	coalesce(rt.isupervisor, false) ,
	r.insertedon,	
	r.updatedon,
	r.remarks,
	cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else (select ISRST.description::character varying as typedescription from intakeservicerequest as ISR inner join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 where ISR.intakenumber = IDAS.intakenumber and (ISR.activeflag = 1 or ISR.actiontype IS NULL OR ISR.actiontype = '') order by ISR.insertedon desc limit 1 ) end end as character varying) ,
	dispositiondescription,
	statusdescription,
	cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
	IDAS.jsondata,
	IDAS.updatedon ,
	ITDS.teamtypekey ,
	case
		when ITDS.teamtypekey = 'DJS'
		and lower(rts.typedescription)= 'closed' then
		case
			coalesce( (select count(1) from IntakeAppeal IP where IP.intakenumber = IDAS.intakenumber ), 0)
			when 0 then
			case
				when now()::date - (r.updatedon :: date + 30 ):: date >0 then 0
				else 1
			end
			else 2
		end
		else 0
	end,
	IDAS.ispreintake,
	(
	select
		''::character varying) as clwstatus,
	(
	select
		json_agg(e) as fatality
	from
		(
		select
			isrs.ischildfatality,
			isrs.ismaltreatment
		from
			intakeservicerequestsdm isrs
		where
			isrs.intakenumber = IDAS.IntakeNumber
			and activeflag = 1 ) as e) ::json,
	0,
	(SELECT json_agg(x) as headofhousehlod FROM ( 
        SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE    ISRA.activeflag =1  
		AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
		AND ISRA.intakenumber = IDAS.IntakeNumber
		ORDER BY 1 ) as x):: json,
	null:: json,
	''::CHARACTER VARYING as youthname,
	''::CHARACTER VARYING as  victimname,
	''::CHARACTER VARYING as DJSyouthname,
	''::CHARACTER VARYING as youthfirstname,
	''::CHARACTER VARYING as youthlastname,
	''::CHARACTER VARYING as youth_suffix,
	NULL::bigint as cjamspid
from
	IntakeDAStaging IDAS
inner join intakeDAStatus ITDS on
	ITDS.intakenumber = IDAS.intakenumber AND ITDS.activeflag =1 AND ITDS.teamtypekey = 'CW'
inner join (select distinct objectid,fromsecurityusersid ,min(routingid::character varying) routingid
 from routing where fromsecurityusersid=v_UserSID 
 --and objectid = IDAS.intakenumber	 
 and activeflag = 1	 
 and eventcode in ('INTR',
'KINR')group by 
  objectid,fromsecurityusersid ) r1 on
  r1.objectid = IDAS.intakenumber	
 inner join routing r on r.routingid=r1.routingid::uuid and
r1.objectid = IDAS.intakenumber	
and r.eventcode in ('INTR',
'KINR')
	and r.fromsecurityusersid=v_UserSID and r.activeflag=1
left join routingstatustype RTs on
	RTs.sequencenumber = r.routingstatustypeid
	and rts.activeflag = 1
left join teammemberroletype rt on
	rt.roletypekey = r.toroleid
	and rt.activeflag = 1
inner join userprofile up on
	up.securityusersid = IDAS.CRUWorkerName
left  join intakeservicerequest as ISR on ISR.intakenumber = IDAS.intakenumber and (ISR.activeflag = 1)
left join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid 
and ISRST.activeflag = 1 

-- inner join intakeservicerequestdispositioncode ISDC on ISDC.intakeserviceid=ISR.intakeserviceid 
-- and ISDC.servicerequesttypeconfigiddispostionid in (select SRCDC.servicerequesttypeconfigiddispostionid from intakeservicerequestdispositioncode ISRDCC 
--     inner join servicerequesttypeconfigdispositioncode SRCDC on 
-- SRCDC.servicerequesttypeconfigiddispostionid=ISRDCC.servicerequesttypeconfigiddispostionid and SRCDC.activeflag=1
-- inner join intakeserreqstatustype ISRSS on ISRSS.intakeserreqstatustypeid=ISDC.intakeserreqstatustypeid
-- where ISRDCC.intakeserviceid=ISR.intakeserviceid and ISRSS.intakeserreqstatustypekey='Approved'
-- and SRCDC.dispositioncode in ('Scrnin','Ovrscrnin')  limit 1)

where
	IDAS.IntakeNumber like intakeno || '%'
	and r.routingstatustypeid in (2,21)
	and IDAS.Activeflag = 1
--and ISDC.insertedby=v_UserSID
 )) d 
order by
	(
	case
		sortorder
		when 'asc' then
		case
			sortcolumn
			when 'receiveddate' then cast( d.datesubmitted as character varying)
			when 'updateddate' then cast( d.updateddate as character varying)
			when 'datesubmitted' then cast( d.datesubmitted as character varying)
			when 'submittedworker' then cast(d.cruworkername as character varying)
			else d.intakenumber
		end
		--else cast( IDAS.EntityName as character varying)
	end) asc,
	(
	case
		sortorder
		when 'desc' then
		case
			sortcolumn
			when 'receiveddate' then cast( d.datesubmitted as character varying)
			when 'updateddate' then cast( d.updateddate as character varying)
			when 'datesubmitted' then cast( d.datesubmitted as character varying)
			when 'submittedworker' then cast(d.cruworkername as character varying)
			else d.intakenumber
		end
		--else cast( IDAS.EntityName as character varying)
	end ) desc
limit pagesize offset v_pageoffset;

elsif (v_status = 3) then
raise notice 'v_status=3%',v_status; 
return QUERY 
SELECT * FROM (	
(SELECT
	  count(1) over()::bigint as totalcount
	, IDAS.old_id as intakechessieid 
	, 1 as id
	, IDAS.IntakeNumber as intakenumber
	, CAST(CASE ITDS.iscps WHEN true THEN 'CPS' WHEN false THEN 'Non  CPS' ELSE '' END  AS character varying) as cpsresponse
	, IDAS.reporteddate as datereceived
	, (to_char( IDAS.reportedtime::timestamp without time zone, 'YYYYMMDD"T"HH24MISS"Z"' )::timestamptz)::timestamp without time zone as timereceived
	, IDAS.Narrative as narrative
 	, COALESCE(IDAS.title, '') :: character varying raname
	, CAST('' as character varying) entityname
	, CAST(up.firstname || ' ' || up.lastname as character varying)  as cruworkername
	, COALESCE(r.isreviewrequest, false) as isreview
	, COALESCE(r.isupervisor, false) as issupervisor
	, r.insertedon as datesubmitted
	, r.updatedon  as dateclosed
	, r.remarks as remarks
	, CAST(case ITDS.status WHEN 0 THEN 'Draft' ELSE  r.typedescription END  as character varying)   as reviewstatus
	, CAST('' as character varying) disposition
	, CAST('' as character varying) intakestatus
	, CAST( case r.insertedon WHEN null THEN '' else case WHEN age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' THEN cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) end end as character varying) as timeleft
	, json_build_object('General',json_build_object( 'Narrative',IDAS.narrative,'Purpose',IDAS.intakeservreqtypeid ))::jsonb as jsondata
	, IDAS.updatedon as updateddate
	, ITDS.teamtypekey as agencycode 
	, 0 as canreopen 
	, ITDS.ispreintake as ispreintake
	, ''::character varying  as clwstatus
	, NULL  ::json as sdm
	, 0 isprior
	, (SELECT json_agg(x) as headofhousehlod FROM ( 
        SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE ISRA.activeflag =1  
		AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
		AND ISRA.intakenumber = IDAS.IntakeNumber
		ORDER BY 1 ) as x):: json 
	, null:: json
	, ''::CHARACTER VARYING as youthname
	, ''::CHARACTER VARYING as  victimname
	, ''::CHARACTER VARYING as djsyouthname
	, ''::CHARACTER VARYING as youthfirstname
	, ''::CHARACTER VARYING as youthlastname
	, ''::CHARACTER VARYING as youth_suffix
	, NULL::bigint as youthcjamspid
FROM 	
	intakeservicerequest IDAS
	INNER JOIN intakeDAStatus ITDS ON 	ITDS.intakenumber = IDAS.intakenumber AND ITDS.activeflag =1 AND ITDS.teamtypekey = 'CW'
	INNER JOIN intakeservicerequestsdm sdm on sdm.intakeserviceid = IDAS.intakeserviceid and sdm.activeflag = 1
	INNER JOIN  (SELECT upf.securityusersid, upf.firstname, upf.lastname from userprofile upf where upf.securityusersid = v_UserSID) up ON up.securityusersid = ITDS.intakeuser
	LEFT JOIN (
				select rou.objectid, rts.typedescription, rt.isupervisor, rou.toroleid, rou.fromsecurityusersid, rou.isreviewrequest, rou.insertedon, rou.tosecurityusersid, rou.updatedon, rou.remarks, rou.routingstatustypeid, rou.toroleid 
				from routing rou 
				inner JOIN routingstatustype RTs ON  RTs.sequencenumber = rou.routingstatustypeid AND rts.activeflag = 1
				inner JOIN	teammemberroletype rt ON rt.roletypekey = rou.toroleid AND rt.activeflag = 1	
				where rou.activeflag = 1 and rou.eventcode in ('INTR','KINR') and (rou.tosecurityusersid = v_UserSID or rou.fromsecurityusersid = v_UserSID)
	) r ON r.objectid = IDAS.intakenumber
	
	/*LEFT JOIN  (SELECT distinct isdc.intakeserviceid , srcd.dispositioncode,isdc.intakeserreqstatustypeid
					FROM 	intakeservicerequestdispositioncode isdc 
							INNER JOIN servicerequesttypeconfigdispositioncode srcd ON  srcd.servicerequesttypeconfigiddispostionid = isdc.servicerequesttypeconfigiddispostionid and srcd.activeflag = 1  
					WHERE	 isdc.activeflag = 1 
				) isd ON isd.intakeserviceid  = IDAS.intakeserviceid
	LEFT JOIN 	intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = isd.intakeserreqstatustypeid and ISRST.activeflag = 1*/ 
 WHERE 	IDAS.IntakeNumber like intakeno || '%'
		AND ITDS.intakenumber NOT IN (SELECT ids.intakenumber FROM intakedastaging ids WHERE activeflag =1)
		AND CASE v_status WHEN 8 THEN ITDS.status  IN (2,8) WHEN 1 THEN ITDS.status  IN (1,0) ELSE ITDS.status = v_status END
		AND  v_UserSID IN (r.tosecurityusersid,COALESCE(ITDS.intakeuser,r.fromsecurityusersid ))
		AND IDAS.Activeflag = 1 
		AND (sdm.noscreeninoverridesflag = 1 or sdm.isfinalscreenin = false or sdm.newnoncpsrefflag = 1 ) )
UNION ALL 
(select
count(1) over(),
	ISR.old_id as intakechessieid,
	IDAS.id,
	IDAS.IntakeNumber ,
	cast(case ITDS.iscps when true then 'CPS' when false then 'Non  CPS' else '' end as character varying),
	IDAS.DateRecieved,
	IDAS.TimeRecieved ::timestamp without time zone,
	IDAS.Narrative,	
 	IDAS.raname,
	IDAS.EntityName,
	cast(up.firstname || ' ' || up.lastname as character varying) ,
	coalesce(r.isreviewrequest, false),
	coalesce(rt.isupervisor, false) ,
	r.insertedon,	
	r.updatedon,
	r.remarks,
	cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else (select ISRST.description::character varying as typedescription from intakeservicerequest as ISR inner join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 where ISR.intakenumber = IDAS.intakenumber and (ISR.activeflag = 1 or ISR.actiontype IS NULL OR ISR.actiontype = '') order by ISR.insertedon desc limit 1 ) end end as character varying) ,
	dispositiondescription,
	statusdescription,
	cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
	IDAS.jsondata,
	IDAS.updatedon ,
	ITDS.teamtypekey ,
	case
		when ITDS.teamtypekey = 'DJS'
		and lower(rts.typedescription)= 'closed' then
		case
			coalesce( (select count(1) from IntakeAppeal IP where IP.intakenumber = IDAS.intakenumber ), 0)
			when 0 then
			case
				when now()::date - (r.updatedon :: date + 30 ):: date >0 then 0
				else 1
			end
			else 2
		end
		else 0
	end,
	IDAS.ispreintake,
	(
	select
		''::character varying) as clwstatus,
	(
	select
		json_agg(e) as fatality
	from
		(
		select
			isrs.ischildfatality,
			isrs.ismaltreatment
		from
			intakeservicerequestsdm isrs
		where
			isrs.intakenumber = IDAS.IntakeNumber
			and activeflag = 1 ) as e) ::json,
	0,
	(SELECT json_agg(x) as headofhousehlod FROM ( 
        SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE    ISRA.activeflag =1  
		AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
		AND ISRA.intakenumber = IDAS.IntakeNumber
		ORDER BY 1 ) as x):: json,
	null:: json,
	(
	select
		cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
	from
		jsonb_array_elements( IDAS.jsondata -> 'persons') persons ,
		jsonb_array_elements(persons -> 'personRole') persl
	where
		persl ->>'rolekey' = 'Youth' ) as youthname,
		(
	select
		cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
	from
		jsonb_array_elements( IDAS.jsondata -> 'persons') persons ,
		jsonb_array_elements(persons -> 'personRole') persl
	where
		persl ->>'rolekey' = 'Victim' limit 1 ) as victimname,
	''::CHARACTER VARYING as DJSyouthname,
/* 	(
	select
		cast(initcap(trim(coalesce(PN.lastname, ''))|| ' ' || trim(coalesce(PN.suffix, '')) || ', ' || trim(coalesce(PN.firstname, ''))) as character varying)
	from
		Person as PN
	where
		--PN.personid = IDAS.focuspersonid
 trim(PN.firstname) = trim(split_part(IDAS.raname, ' ', 1))
		and trim(PN.lastname) = trim(split_part(IDAS.raname, ' ', 2))
	limit 1 ) as DJSyouthname, */
	(
	select
		PN.firstname
	from
		Person as PN
	where
		PN.personid = IDAS.focuspersonid) as youthfirstname,
	(
	select
		PN.lastname
	from
		Person as PN
	where
		PN.personid = IDAS.focuspersonid) as youthlastname,
	(
	select
		PN.suffix
	from
		Person as PN
	where
		PN.personid = IDAS.focuspersonid) as youth_suffix,
	(
	select
		PN.cjamspid
	from
		Person as PN
	where
		PN.personid = IDAS.focuspersonid) as cjamspid
from IntakeDAStaging IDAS
inner join intakeDAStatus ITDS on ITDS.intakenumber = IDAS.intakenumber AND ITDS.activeflag =1 AND ITDS.teamtypekey = 'CW'
inner join (select distinct objectid,fromsecurityusersid ,min(routingid::character varying) routingid
 from routing where fromsecurityusersid=v_UserSID
 and routingstatustypeid=8 and activeflag=0 	 
 and eventcode in ('INTR',
'KINR')group by 
  objectid,fromsecurityusersid ) r1 on
  r1.objectid = IDAS.intakenumber
inner join routing r on r.routingid = r1.routingid::uuid and r.objectid = IDAS.intakenumber and r.eventcode in ('INTR','KINR') and r.routingstatustypeid=8 and r.activeflag=0 
and r.objectid not in (select distinct objectid from routing r1 where 
r1.eventcode in ('INTR','KINR') 
and r1.routingstatustypeid in (2,861)
and r1.activeflag=1 
and
r1.objectid=idas.intakenumber 
)
and r.fromsecurityusersid=v_UserSID
left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
inner join userprofile up on up.securityusersid = IDAS.CRUWorkerName
left  join intakeservicerequest as ISR on ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1
--left join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 
--left join intakeservicerequestdispositioncode ISDC on ISDC.intakeserviceid=ISR.intakeserviceid 
where IDAS.IntakeNumber like intakeno || '%' and IDAS.Activeflag = 1)) d 
order by
	(
	case
		sortorder
		when 'asc' then
		case
			sortcolumn
			when 'receiveddate' then cast( d.datesubmitted as character varying)
			when 'updateddate' then cast( d.updateddate as character varying)
			when 'datesubmitted' then cast( d.datesubmitted as character varying)
			when 'submittedworker' then cast(d.cruworkername as character varying)
			else d.intakenumber
		end
		--else cast( IDAS.EntityName as character varying)
	end) asc,
	(
	case
		sortorder
		when 'desc' then
		case
			sortcolumn
			when 'receiveddate' then cast( d.datesubmitted as character varying)
			when 'updateddate' then cast( d.updateddate as character varying)
			when 'datesubmitted' then cast( d.datesubmitted as character varying)
			when 'submittedworker' then cast(d.cruworkername as character varying)
			else d.intakenumber
		end
		--else cast( IDAS.EntityName as character varying)
	end ) desc
limit pagesize offset v_pageoffset;

end if;

end;

$function$;

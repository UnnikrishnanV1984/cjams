-- FUNCTION: cjams.listintakedetails(character varying, character varying, bigint, bigint, character varying, boolean, character varying, character varying)
DROP FUNCTION  IF EXISTS cjams.listintakedetails(character varying, character varying, bigint, bigint, character varying, boolean, character varying, character varying);
DROP FUNCTION  IF EXISTS cjams.listintakedetails(character varying, character varying, bigint, bigint, character varying, boolean, character varying, character varying, character varying, integer);
DROP FUNCTION  IF EXISTS cjams.listintakedetails(character varying, character varying, bigint, bigint, character varying, boolean, character varying, character varying, character varying, integer, integer);
DROP FUNCTION  IF EXISTS cjams.listintakedetails(character varying, character varying, bigint, bigint, character varying, boolean, character varying, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.listintakedetails(
	securityusersid character varying,
	status character varying,
	pagenumber bigint,
	pagesize bigint,
	intakeno character varying,
	bpreintake boolean,
	sortcolumn character varying,
	sortorder character varying, 
	isExpungementSuperUser integer DEFAULT 0::integer,
	isexpunged integer DEFAULT 0::integer)
RETURNS TABLE(totalcount bigint, intakechessieid character varying, id integer, intakenumber character varying, cpsresponse character varying, datereceived timestamp without time zone, timereceived timestamp without time zone, narrative text, raname character varying, entityname character varying, cruworkername character varying, isreview boolean, issupervisor boolean, datesubmitted timestamp without time zone, dateclosed timestamp without time zone, remarks text, reviewstatus character varying, disposition character varying, intakestatus character varying, timeleft character varying, jsondata jsonb, updateddate timestamp without time zone, agencycode character varying, canreopen integer, ispreintake boolean, clwstatus character varying, sdm json, isprior integer, headofhousehlod json, legalguardian json, youthname character varying, victimname character varying, djsyouthname character varying, youthfirstname character varying, youthlastname character varying, youth_suffix character varying, youthcjamspid bigint) 
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
    ROWS 1000
AS $function$  
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 10/19/2022 Vineet Tirodkar - For performance fix changed the Pending query joins a left  
-- 11/21/2022 Vineet Tirodkar - For performance fix - commented 2nd union for 'Pending' cases (Migrated cases) - CDM-19215
-- 1/9/2025 Agathya - Modified for performance tuning. separated status 1 logic to a elseif condition and created index.
-- 11/17/2025 Amiya Pradhan - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
------------------------------------------------------------------------------------------------------------	
declare v_status int;
--11/19/21:CDM-18459, SJ: to remove the unwanted record from user dashboard
v_UserSID character varying;
v_activeflag int;
v_pageoffset int;
v_pagenumber int;
v_statustext character varying;
v_intakeserviceid uuid;
v_isexpunged integer := 0;

begin

v_activeflag := 1;
v_UserSID := securityusersid;
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;
v_statustext := status;

raise notice 'v_status%', status;

if (status = 'pending' or status = 'pendingreview') then 
	v_status := 1;
elsif (status = 'reopen') then 
	v_status := 7;
	v_activeflag := 0;
elsif (status = 'approved') then
	v_status := 8;
elsif (status = 'closed') then 
	v_status := 8;
elsif (status = 'assigned') then 
	v_status := 10;
elsif (status = 'rejected') then 
	v_status := 3;
elsif (status = 'accepted') then 
	v_status := 2;
elsif (status = 'completed') then 
	v_status := 11;
end if;

if (sortcolumn = 'datereceived') then 
	sortcolumn = 'receiveddate';
end if;

raise notice 'v_status%',v_status;
raise notice 'v_activeflag%', v_activeflag;
v_isexpunged = 0;
IF(intakeno != '') then
	IF (isExpungementSuperUser= 1) THEN
		v_isexpunged = isexpunged;
	END IF;
END IF;
IF v_isexpunged = 1 THEN 
-- fully expunged 
/*Get  Individual  Intake  details  */
IF (lower(status)= 'intake') then 
	return QUERY
		select
		count(1) over(),
		INSR.old_id as intakechessieid,
		IDAS.id,
		IDAS.IntakeNumber ,
		cast(case DAS.iscps when true then 'CPS' when false then 'Non  CPS' else '' end as character varying),
		IDAS.DateRecieved,
		IDAS.TimeRecieved ::timestamp without time zone,
		IDAS.Narrative,
		IDAS.raname,
		IDAS.EntityName,
		IDAS.CRUWorkerName::character varying ,
		false,
		false ,
		(
		select max(insertedon)
		from routing
		where objectid = IDAS.IntakeNumber and isreviewrequest = true and eventcode in ('INTR', 'KINR')
		),
		IDAS.insertedon ::timestamp ,
		cast ('' as text) ,
		cast ((
		select 
		case when r.routingstatustypeid is null then case when 
		ids.status is null then 'Draft' when isr.servicerequestnumber is not null then 'Accepted' end 
		else
		case 
		when r.routingstatustypeid = 1 then 'Review'
		when r.routingstatustypeid in (2,21) then 'Accepted'
		when r.routingstatustypeid = 8 then 'Closed'
		end end
		from expunge.intakedastatus_expunge ids
		left join routing r on ids.intakenumber = r.objectid and r.activeflag = 1
		left join expunge.intakeservicerequest_expunge isr on ids.intakenumber = isr.intakenumber and isr.activeflag = 1
		left join intakeserreqstatustype iss on isr.intakeserreqstatustypeid = iss.intakeserreqstatustypeid and iss.activeflag = 1
		left join routingstatustype rs on rs.sequencenumber = r.routingstatustypeid and rs.activeflag = 1
		where ids.intakenumber = IDAS.IntakeNumber and ids.teamtypekey = 'CW' order by r.insertedon desc limit 1
		) as character varying),
		dispositiondescription,
		cast( statusdescription as character varying),
		cast( case DAS.submitteddate when null then '' else case when age( now() ) - age(DAS.submitteddate + time '02:00' ) > '0:00' then cast( age( now() ) - age( DAS.submitteddate + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		(case
			when (status1 in (2, 8)) then (
			select ISS.jsondata::jsonb as js
			from expunge.intakesnapshot_expunge ISS
			where ISS.IntakeNumber = intakeno and ISS.activeflag=1 order by updatedon desc
			limit 1)
			else IDAS.jsondata::jsonb
		end)::jsonb,
		IDAS.updatedon ,
		'':: character varying,
		0,
		IDAS.ispreintake ,
		(
		select CST.complaintstatustypekey
		from intakeservicerequestevaluation as ISRE
		join complaintstatustype as CST on CST.complaintstatustypekey = ISRE.complaintstatustypekey and CST.activeflag = 1
		where ISRE.intakenumber = IDAS.IntakeNumber and ISRE.activeflag = 1 limit 1
		) as clwstatus,
		(
			select json_agg(e) as fatality from
			( select isrs.ischildfatality, isrs.ismaltreatment
			from expunge.intakeservicerequestsdm_expunge isrs
			where isrs.intakenumber::character varying = IDAS.IntakeNumber and activeflag = 1 ) as e
		) ::json ,
		0,
		(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber::character varying = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
		null:: json,
		(
		select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
		where persl ->>'rolekey' = 'Youth' 
		) as youthname,
		(
		select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
		where persl ->>'rolekey' = 'Victim' limit 1 
		) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
		(select PN.firstname from Person as PN where PN.personid = IDAS.focuspersonid) as youthfirstname,
		(select PN.lastname from Person as PN where PN.personid = IDAS.focuspersonid) as youthlastname,
		(select PN.suffix from Person as PN where PN.personid = IDAS.focuspersonid) as youth_suffix,
		(
			select PN.cjamspid from Person as PN where trim(PN.firstname) = trim(split_part(IDAS.raname, ' ', 1)) 
			and trim(PN.lastname) = trim(split_part(IDAS.raname::character varying, ' ', 2)) limit 1
		) as cjamspid
	from
	(
		select
			submitteddate ,
			DAS1.iscps ,
			DAS1.status as status1,
			DAS1.IntakeNumber,
			rts.typedescription,
			DAS1.teamtypekey
		from expunge.intakedastatus_expunge DAS1
		left join routingstatustype RTs on RTs.sequencenumber = DAS1.status and rts.activeflag = 1 
	) DAS
	inner join expunge.intakedastaging_expunge IDAS on IDAS.IntakeNumber = DAS.IntakeNumber
	left join expunge.intakeservicerequest_expunge INSR on INSR.intakenumber = IDAS.IntakeNumber and INSR.activeflag =1
	where IDAS.IntakeNumber like intakeno || '%' and IDAS.Activeflag = 1 and DAS.teamtypekey = 'CW';

	-- Reopen 
	else if (v_status = 7) then return QUERY select
		count(1) over(),
		INSR.old_id as intakechessieid,
		IDAS.id,
		IDAS.IntakeNumber ,
		cast(case IDS.iscps when true then 'CPS' when false then 'Non  CPS' else '' end as character varying),
		IDAS.DateRecieved,
		IDAS.TimeRecieved ::timestamp without time zone,
		IDAS.Narrative,
		IDAS.raname,
		IDAS.EntityName,
		cast(up.firstname || ' ' || up.lastname as character varying) ,
		coalesce(r.isreviewrequest, false),
		coalesce(rt.isupervisor, false) ,
		r.insertedon,
		r.updatedon ,
		TRIM(IDAS.jsondata::jsonb->'reviewstatus'->>'commenttext'::text) as remarks, 
		cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else rts.typedescription end end as character varying) ,
		dispositiondescription,
		statusdescription,
		cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		null::jsonb ,
		IDAS.updatedon ,
		IDS.teamtypekey ,
		0,
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
				expunge.intakeservicerequestsdm_expunge isrs
			where
				isrs.intakenumber = IDAS.IntakeNumber
				and activeflag = 1 ) as e) ::json,
		0,
		(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
		null:: json,
		(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Youth' ) as youthname,
			(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Victim' limit 1) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
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
		(select PN.suffix from Person as PN where PN.personid = IDAS.focuspersonid) as youth_suffix,
		(select PN.cjamspid from Person as PN where PN.personid = IDAS.focuspersonid) as cjamspid
	from expunge.intakedastaging_expunge IDAS
	inner join expunge.intakedastatus_expunge IDS on ids.intakenumber = IDAS.IntakeNumber and ids.status = v_status and IDS.activeflag = 1 and IDS.teamtypekey = 'CW'
	left join routing r on r.objectid = IDAS.IntakeNumber
		and (r.activeflag = 0 or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR', 'KINR')
		and r.routingid = (select r2.routingid from routing r2 
		where r2.objectid = IDAS.IntakeNumber 
		and  r2.activeflag = 0 and r2.eventcode in ('INTR', 'KINR') order by insertedon desc limit 1)
	left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
	left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
	inner join userprofile up on up.securityusersid = IDAS.CRUWorkerName
	left join expunge.intakeservicerequest_expunge INSR on INSR.intakenumber = IDAS.IntakeNumber and INSR.activeflag =1 
	where
		IDAS.IntakeNumber like intakeno || '%'  
		and IDAS.Activeflag = 1 
		and TRIM(IDAS.jsondata::jsonb->'reviewstatus'->>'status'::text)  = 'Reopen' 
		and (  IDAS.jsondata::IDAS.intakeuser = v_UserSID		 
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID 
		end ) )
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname  as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname  || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset ;

	-- Approved Closed
	elsif (v_status = 8) then  
	RAISE NOTICE 'Closed List';
	return QUERY 
		(SELECT  * 
		FROM listintakedetailsbystatus
		(  securityusersid
		, v_status
		, pagenumber
		, pagesize
		, intakeno
		, false
		, sortcolumn
		, sortorder
		, ''))
		
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
		cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else (select ISRST.description::character varying as typedescription from expunge.intakeservicerequest_expunge as ISR inner join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 where isr.intakenumber = IDAS.IntakeNumber and ISR.activeflag = 1 limit 1 ) end end as character varying) ,
		dispositiondescription,
		statusdescription,
		cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		IDAS.jsondata::jsonb,
		IDAS.updatedon ,
		ITDS.teamtypekey ,
		case
			when ITDS.teamtypekey = 'DJS'
			and lower(rts.typedescription)= 'closed' then
			case
				coalesce( (select count(1) from IntakeAppeal IP where IP.intakenumber = IDAS.IntakeNumber ), 0)
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
				intakeservicerequestsdm_expunge isrs
			where
				isrs.intakenumber = IDAS.IntakeNumber
				and activeflag = 1 ) as e) ::json,
		0,
		(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
		null:: json,
		(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Youth' ) as youthname,
			(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Victim' limit 1 ) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
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
	from expunge.intakedastaging_expunge IDAS
	inner join expunge.intakedastatus_expunge ITDS on ITDS.intakenumber = IDAS.IntakeNumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.IntakeNumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR', 'KINR')
	left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
	left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
	inner join userprofile up on up.securityusersid = IDAS.CRUWorkerName
	left  join expunge.intakeservicerequest_expunge as ISR on isr.intakenumber = IDAS.IntakeNumber and ISR.activeflag = 1
	left join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 

	where
		IDAS.IntakeNumber like intakeno || '%'
		and r.routingstatustypeid in (8,
		2)
		and IDAS.Activeflag = 1
		and ( coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID
			else r.tosecurityusersid = v_UserSID
		end ) ) 
	and Lower(ISRST.description)= v_statustext
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset) ;

	--Completed
	elsif (v_status = 11) then return QUERY select
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
		cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else (select ISRST.description::character varying as typedescription from expunge.intakeservicerequest_expunge as ISR inner join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 where isr.intakenumber = IDAS.IntakeNumber and ISR.activeflag = 1 limit 1 ) end end as character varying) ,
		dispositiondescription,
		statusdescription,
		cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		IDAS.jsondata::jsonb,
		IDAS.updatedon ,
		ITDS.teamtypekey ,
		case
			when ITDS.teamtypekey = 'DJS'
			and lower(rts.typedescription)= 'closed' then
			case
				coalesce( (select count(1) from IntakeAppeal IP where IP.intakenumber = IDAS.IntakeNumber ), 0)
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
				intakeservicerequestsdm_expunge isrs
			where
				isrs.intakenumber = IDAS.IntakeNumber
				and activeflag = 1 ) as e) ::json,
		0,
		(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
		null:: json,
		(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Youth' ) as youthname,
			(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Victim' limit 1 ) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
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
	from
		expunge.intakedastaging_expunge IDAS
	inner join expunge.intakedastatus_expunge ITDS on
		ITDS.intakenumber = IDAS.IntakeNumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.IntakeNumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR',
		'KINR')
	left join routingstatustype RTs on
		RTs.sequencenumber = r.routingstatustypeid
		and rts.activeflag = 1
	left join teammemberroletype rt on
		rt.roletypekey = r.toroleid
		and rt.activeflag = 1
	inner join userprofile up on
		up.securityusersid = IDAS.CRUWorkerName
	left  join expunge.intakeservicerequest_expunge as ISR on isr.intakenumber = IDAS.IntakeNumber and ISR.activeflag = 1
	left join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 

	where
		IDAS.IntakeNumber like intakeno || '%'
		and r.routingstatustypeid in (8,
		2)
		and IDAS.Activeflag = 1
		and ( coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID
			else r.tosecurityusersid = v_UserSID
		end ) ) 
	and Lower(ISRST.description)= v_statustext
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset ;
	-------  Added  by  Gavaskar

	-- Accepted
	elsif (v_status = 2) then return QUERY select
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
		ISRST.description::character varying as typedescription,
		dispositiondescription,
		statusdescription,
		cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		IDAS.jsondata::jsonb,
		IDAS.updatedon ,
		ITDS.teamtypekey ,
		case
			when ITDS.teamtypekey = 'DJS'
			and lower(rts.typedescription)= 'closed' then
			case
				coalesce( (select count(1) from IntakeAppeal IP where IP.intakenumber = IDAS.IntakeNumber ), 0)
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
				expunge.intakeservicerequestsdm_expunge isrs
			where
				isrs.intakenumber = IDAS.IntakeNumber
				and activeflag = 1 ) as e) ::json,
		0,
		(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
		null:: json,
		(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Youth' ) as youthname,
			(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Victim' limit 1) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
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
	from
		expunge.intakedastaging_expunge IDAS
	inner join expunge.intakedastatus_expunge ITDS on
		ITDS.intakenumber = IDAS.IntakeNumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.IntakeNumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR',
		'KINR')
	left join routingstatustype RTs on
		RTs.sequencenumber = r.routingstatustypeid
		and rts.activeflag = 1
	left join teammemberroletype rt on
		rt.roletypekey = r.toroleid
		and rt.activeflag = 1
	inner join userprofile up on
		up.securityusersid = IDAS.CRUWorkerName
	inner join expunge.intakeservicerequest_expunge as ISR on
		isr.intakenumber =ITDS.intakenumber
		and ISR.activeflag = 1
	inner join intakeserreqstatustype as ISRST on
		ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid
		and ISRST.activeflag = 1
	where
		IDAS.IntakeNumber like intakeno || '%'
		and r.routingstatustypeid in (2,21)
		and IDAS.Activeflag = 1
		and lower(ISRST.intakeserreqstatustypekey) not in('rejected','reopen')
		and ( coalesce(r.fromsecurityusersid, IDAS.intakeuser) = v_UserSID
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			else r.tosecurityusersid = v_UserSID
		end ) )
	and Lower(ISRST.description)= Lower(v_statustext)
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset ;

	-- Rejected
	elsif (v_status = 3) then return QUERY select
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
		ISRST.description::character varying as typedescription,
		dispositiondescription,
		statusdescription,
		cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		IDAS.jsondata::jsonb,
		IDAS.updatedon ,
		ITDS.teamtypekey ,
		case
			when ITDS.teamtypekey = 'DJS'
			and lower(rts.typedescription)= 'closed' then
			case
				coalesce((select count(1) from IntakeAppeal IP where IP.intakenumber = IDAS.IntakeNumber ), 0)
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
				intakeservicerequestsdm_expunge isrs
			where
				isrs.intakenumber = IDAS.IntakeNumber
				and activeflag = 1 ) as e) ::json,
		0,
		(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
		null:: json,
		(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Youth' ) as youthname,
			(
		select
			cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from
			jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons ,
			jsonb_array_elements(persons -> 'personRole') persl
		where
			persl ->>'rolekey' = 'Victim' limit 1 ) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
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
	from
		expunge.intakedastaging_expunge IDAS
	inner join expunge.intakedastatus_expunge ITDS on
		ITDS.intakenumber = IDAS.IntakeNumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.IntakeNumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode = 'INTR'
	left join routingstatustype RTs on
		RTs.sequencenumber = r.routingstatustypeid
		and rts.activeflag = 1
	left join teammemberroletype rt on
		rt.roletypekey = r.toroleid
		and rt.activeflag = 1
	inner join userprofile up on
		up.securityusersid = IDAS.CRUWorkerName
	inner join expunge.intakeservicerequest_expunge as ISR on
		isr.intakenumber =ITDS.intakenumber
		and ISR.activeflag = 1
	inner join intakeserreqstatustype as ISRST on
		ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid
		and ISRST.activeflag = 1
	where
		IDAS.IntakeNumber like intakeno || '%'
		and IDAS.Activeflag = 1
		and lower(ISRST.intakeserreqstatustypekey) in('rejected')
		and ( coalesce(r.fromsecurityusersid, IDAS.intakeuser) = v_UserSID
		or
		(case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID
			else r.fromsecurityusersid = v_UserSID
		end ) )
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.IntakeNumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset ;
	
	-- Agathya : Added for pending review flow performance tuning.
	elsif (v_status = 1) then 

	return QUERY select
	count(1) over(), *
	from
		((
		select
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
			r.updatedon ,
			r.remarks,
			cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then case ITDS.status when 10 then 'Assigned' else 'Draft' end else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else rts.typedescription end end as character varying) ,
			dispositiondescription,
			statusdescription,
			cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) end end as character varying),
			(case
				when (ITDS.status in (2, 8)) then (
				select ISS.jsondata as js
				from expunge.intakesnapshot_expunge ISS
				where ISS.IntakeNumber = IDAS.IntakeNumber   limit 1)
				else IDAS.jsondata::jsonb
			end)::jsonb,
			IDAS.updatedon ,
			ITDS.teamtypekey ,
			0,
			IDAS.ispreintake,
			(
			select
				''::character varying) as clwstatus,
			(
			select json_agg(e) as fatality from
				(
				select isrs.ischildfatality, isrs.ismaltreatment
				from expunge.intakeservicerequestsdm_expunge isrs
				where isrs.intakenumber = IDAS.IntakeNumber and activeflag = 1 ) as e) ::json,
			0 isprior,
			(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
			(
			select getcasepersonname
			from getcasepersonname ('intake', IDAS.IntakeNumber:: character varying)),
			(
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements(IDAS.jsondata::jsonb -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Youth' ) as youthname, (
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements(IDAS.jsondata::jsonb -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Victim' limit 1) as victimname,
			''::CHARACTER VARYING as DJSyouthname,
			(
			select PN.firstname
			from Person as PN
			where PN.personid = IDAS.focuspersonid) as youthfirstname,
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
		from expunge.intakedastaging_expunge IDAS
		inner join expunge.intakedastatus_expunge ITDS on ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW' and ITDS.activeflag = 1
		and coalesce(IDAS.ispreintake, false) = false
		and lower(IDAS.Status) = 'pending' and idas.teamtypekey = 'CW'
		and IDAS.Activeflag = 1
		left join routing r on r.objectid = IDAS.intakenumber and (r.activeflag = 1 or r.activeflag = v_activeflag) and r.eventcode in ('INTR', 'KINR')
		left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
		left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
		left join userprofile up on up.securityusersid =  IDAS.CRUWorkerName
		left join expunge.intakeservicerequest_expunge as ISR on ISR.intakenumber = IDAS.intakenumber 
		where
		IDAS.IntakeNumber like intakeno || '%'
		and
		(case
			v_status
			when 1 then lower(IDAS.Status) = 'pending'
			else r.routingstatustypeid = v_status
		end
		or
		case
			IDAS.intakeuser
			when v_UserSID then r.routingstatustypeid=6
			else r.routingstatustypeid = v_status
		end )
		and IDAS.Activeflag = 1
		and coalesce(IDAS.ispreintake, false) = false 
		and ( 	case v_statustext when 'pending'  then ITDS.InsertedBy = v_UserSID  and coalesce(routingstatustypeid,0) != 860
				else coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
				or (
				case right(fromroleid, 2)
					when 'IW' then IDAS.InsertedBy = v_UserSID
					when 'KW' then IDAS.InsertedBy = v_UserSID
					when 'CW' then IDAS.InsertedBy = v_UserSID
					else r.tosecurityusersid = v_UserSID
				end )
			end ) 
		AND  CASE  WHEN  coalesce(lower(v_statustext),'') = 'pendingreview'  THEN  (coalesce(rts.typedescription,'') != '')  ELSE  TRUE  END
		order by
			(
			case
				sortorder
				when 'asc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.intakenumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end) asc,
			(
			case
				sortorder
				when 'desc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.intakenumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end ) desc )
		) t
	limit pagesize offset v_pageoffset ;
	-- Agathya : End pending review flow performance tuning.

	-- Pending and Assigned v_status 1 and 10
	else 
	raise notice 'else %',
	sortcolumn;

	return QUERY select
	count(1) over(), *
	from
		((
		select
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
			r.updatedon ,
			r.remarks,
			cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then case ITDS.status when 10 then 'Assigned' else 'Draft' end else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else rts.typedescription end end as character varying) ,
			dispositiondescription,
			statusdescription,
			cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) end end as character varying),
			(case
				when (ITDS.status in (2, 8)) then (
				select ISS.jsondata as js
				from expunge.intakesnapshot_expunge ISS
				where ISS.IntakeNumber = IDAS.IntakeNumber   limit 1)
				else IDAS.jsondata::jsonb
			end)::jsonb,
			IDAS.updatedon ,
			ITDS.teamtypekey ,
			0,
			IDAS.ispreintake,
			(
			select
				''::character varying) as clwstatus,
			(
			select json_agg(e) as fatality from
				(
				select isrs.ischildfatality, isrs.ismaltreatment
				from expunge.intakeservicerequestsdm_expunge isrs
				where isrs.intakenumber = IDAS.IntakeNumber and activeflag = 1 ) as e) ::json,
			0 isprior,
			(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  expunge.intakeservicerequestactor_expunge ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
			(
			select getcasepersonname
			from getcasepersonname ('intake', IDAS.IntakeNumber:: character varying)),
			(
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Youth' ) as youthname, (
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements( IDAS.jsondata::jsonb -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Victim' limit 1) as victimname,
			''::CHARACTER VARYING as DJSyouthname,
			(
			select PN.firstname
			from Person as PN
			where PN.personid = IDAS.focuspersonid) as youthfirstname,
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
		from expunge.intakedastaging_expunge IDAS
		inner join expunge.intakedastatus_expunge ITDS on ITDS.intakenumber = IDAS.IntakeNumber and ITDS.teamtypekey = 'CW' and ITDS.activeflag = 1
		left join routing r on r.objectid = IDAS.IntakeNumber and (r.activeflag = 1 or r.activeflag = v_activeflag) and r.eventcode in ('INTR', 'KINR')
		left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
		left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
		left join userprofile up on up.securityusersid = IDAS.CRUWorkerName
		left join expunge.intakeservicerequest_expunge ISR on isr.intakenumber = IDAS.IntakeNumber and ISR.activeflag = 1 
		where
		IDAS.IntakeNumber like intakeno || '%'
		and
		(case
			v_status
			when 1 then lower(IDAS.Status) = 'pending'
			else r.routingstatustypeid = v_status
		end
		or
		case
			IDAS.intakeuser
			when v_UserSID then r.routingstatustypeid=6
			else r.routingstatustypeid = v_status
		end )
		and IDAS.Activeflag = 1
		and coalesce(IDAS.ispreintake, false) = false 
		and ( 	case v_statustext when 'pending'  then ITDS.InsertedBy = v_UserSID  and coalesce(routingstatustypeid,0) != 860
				else coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
				or (
				case right(fromroleid, 2)
					when 'IW' then IDAS.InsertedBy = v_UserSID
					when 'KW' then IDAS.InsertedBy = v_UserSID
					when 'CW' then IDAS.InsertedBy = v_UserSID
					else r.tosecurityusersid = v_UserSID
				end )
			end ) 
		AND  CASE  WHEN  coalesce(lower(v_statustext),'') = 'pendingreview'  THEN  (coalesce(rts.typedescription,'') != '')  ELSE  TRUE  END
		order by
			(
			case
				sortorder
				when 'asc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.IntakeNumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end) asc,
			(
			case
				sortorder
				when 'desc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.IntakeNumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end ) desc ) 
		) t
	limit pagesize offset v_pageoffset ;
	end if;
	end if;
ELSE 
-- original query
	/*Get  Individual  Intake  details  */
	if (lower(status)= 'intake') then 
	return QUERY
		select
		count(1) over(),
		INSR.old_id as intakechessieid,
		IDAS.id,
		IDAS.IntakeNumber ,
		cast(case DAS.iscps when true then 'CPS' when false then 'Non  CPS' else '' end as character varying),
		IDAS.DateRecieved,
		IDAS.TimeRecieved ::timestamp without time zone,
		IDAS.Narrative,
		IDAS.raname as raname,
		IDAS.EntityName,
		cast(IDAS.CRUWorkerName as character varying) ,
		false,
		false ,
		(
		select max(insertedon)
		from routing
		where objectid = IDAS.IntakeNumber and isreviewrequest = true and eventcode in ('INTR', 'KINR')
		),
		IDAS.insertedon ::timestamp ,
		cast ('' as text) ,
		cast ((
		select 
		case when r.routingstatustypeid is null then case when 
		ids.status is null then 'Draft' when isr.servicerequestnumber is not null then 'Accepted' end 
		else
		case 
		when r.routingstatustypeid = 1 then 'Review'
		when r.routingstatustypeid in (2,21) then 'Accepted'
		when r.routingstatustypeid = 8 then 'Closed'
		end end
		from intakedastatus ids
		left join routing r on ids.intakenumber = r.objectid and r.activeflag = 1
		left join intakeservicerequest isr on ids.intakenumber = isr.intakenumber and isr.activeflag = 1
		left join intakeserreqstatustype iss on isr.intakeserreqstatustypeid = iss.intakeserreqstatustypeid and iss.activeflag = 1
		left join routingstatustype rs on rs.sequencenumber = r.routingstatustypeid and rs.activeflag = 1
		where ids.intakenumber = IDAS.IntakeNumber and ids.teamtypekey = 'CW' order by r.insertedon desc limit 1
		) as character varying),
		dispositiondescription,
		cast( statusdescription as character varying),
		cast( case DAS.submitteddate when null then '' else case when age( now() ) - age(DAS.submitteddate + time '02:00' ) > '0:00' then cast( age( now() ) - age( DAS.submitteddate + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		(case
			when (status1 in (2, 8)) then (
			select ISS.jsondata as js
			from intakesnapshot ISS
			where ISS.IntakeNumber = intakeno and ISS.activeflag=1 order by updatedon desc
			limit 1)
			else IDAS.jsondata
		end)::jsonb,
		IDAS.updatedon ,
		'':: character varying,
		0,
		IDAS.ispreintake ,
		(
		select CST.complaintstatustypekey
		from intakeservicerequestevaluation as ISRE
		join complaintstatustype as CST on CST.complaintstatustypekey = ISRE.complaintstatustypekey and CST.activeflag = 1
		where ISRE.intakenumber = IDAS.intakenumber and ISRE.activeflag = 1 limit 1
		) as clwstatus,
		(
			select json_agg(e) as fatality from
			( select isrs.ischildfatality, isrs.ismaltreatment
			from intakeservicerequestsdm isrs
			where isrs.intakenumber = IDAS.IntakeNumber and activeflag = 1 ) as e
		) ::json ,
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
		select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from jsonb_array_elements( IDAS.jsondata -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
		where persl ->>'rolekey' = 'Youth' 
		) as youthname,
		(
		select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
		from jsonb_array_elements( IDAS.jsondata -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
		where persl ->>'rolekey' = 'Victim' limit 1 
		) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
		(select PN.firstname from Person as PN where PN.personid = IDAS.focuspersonid) as youthfirstname,
		(select PN.lastname from Person as PN where PN.personid = IDAS.focuspersonid) as youthlastname,
		(select PN.suffix from Person as PN where PN.personid = IDAS.focuspersonid) as youth_suffix,
		(
			select PN.cjamspid from Person as PN where trim(PN.firstname) = trim(split_part(IDAS.raname, ' ', 1)) 
			and trim(PN.lastname) = trim(split_part(IDAS.raname, ' ', 2)) limit 1
		) as cjamspid
	from
	(
		select
			submitteddate ,
			DAS1.iscps ,
			DAS1.status as status1,
			DAS1.IntakeNumber,
			rts.typedescription,
			DAS1.teamtypekey
		from IntakeDAStatus DAS1
		left join routingstatustype RTs on RTs.sequencenumber = DAS1.status and rts.activeflag = 1 
	) DAS
	inner join IntakeDAStaging IDAS on IDAS.IntakeNumber = DAS.IntakeNumber
	left join intakeservicerequest INSR on INSR.intakenumber = IDAS.intakenumber and INSR.activeflag =1
	where IDAS.IntakeNumber like intakeno || '%' and IDAS.Activeflag = 1 and DAS.teamtypekey = 'CW';

	-- Reopen 
	else if (v_status = 7) then return QUERY select
		count(1) over(),
		INSR.old_id as intakechessieid,
		IDAS.id,
		IDAS.IntakeNumber ,
		cast(case IDS.iscps when true then 'CPS' when false then 'Non  CPS' else '' end as character varying),
		IDAS.DateRecieved,
		IDAS.TimeRecieved ::timestamp without time zone,
		IDAS.Narrative,
		IDAS.raname,
		IDAS.EntityName,
		cast(up.firstname || ' ' || up.lastname as character varying) ,
		coalesce(r.isreviewrequest, false),
		coalesce(rt.isupervisor, false) ,
		r.insertedon,
		r.updatedon ,
		TRIM(IDAS.jsondata->'reviewstatus'->>'commenttext'::text) as remarks, 
		cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else rts.typedescription end end as character varying) ,
		dispositiondescription,
		statusdescription,
		cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else 'Overdue' end end as character varying),
		null::jsonb ,
		IDAS.updatedon ,
		IDS.teamtypekey ,
		0,
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
			persl ->>'rolekey' = 'Victim' limit 1) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
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
		(select PN.suffix from Person as PN where PN.personid = IDAS.focuspersonid) as youth_suffix,
		(select PN.cjamspid from Person as PN where PN.personid = IDAS.focuspersonid) as cjamspid
	from IntakeDAStaging IDAS
	inner join IntakeDAStatus IDS on IDS.intakenumber = IDAS.intakenumber and ids.status = v_status and IDS.activeflag = 1 and IDS.teamtypekey = 'CW'
	left join routing r on r.objectid = IDAS.intakenumber
		and (r.activeflag = 0 or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR', 'KINR')
		and r.routingid = (select r2.routingid from routing r2 
		where r2.objectid = IDAS.intakenumber 
		and  r2.activeflag = 0 and r2.eventcode in ('INTR', 'KINR') order by insertedon desc limit 1)
	left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
	left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
	inner join userprofile up on up.securityusersid = IDAS.CRUWorkerName
	left join intakeservicerequest INSR on INSR.intakenumber = IDAS.intakenumber and INSR.activeflag =1 
	where
		IDAS.IntakeNumber like intakeno || '%'  
		and IDAS.Activeflag = 1 
		and TRIM(IDAS.jsondata->'reviewstatus'->>'status'::text)  = 'Reopen' 
		and (  IDAS.intakeuser = v_UserSID		 
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID 
		end ) )
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname  as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname  || ' ' || up.lastname as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset ;

	-- Approved Closed
	elsif (v_status = 8) then  
	RAISE NOTICE 'Closed List';
	return QUERY 
		(SELECT  * 
		FROM listintakedetailsbystatus
		(  securityusersid
		, v_status
		, pagenumber
		, pagesize
		, intakeno
		, false
		, sortcolumn
		, sortorder
		, ''))
		
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
		cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else (select ISRST.description::character varying as typedescription from intakeservicerequest as ISR inner join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 where ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1 limit 1 ) end end as character varying) ,
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
	inner join intakeDAStatus ITDS on ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.intakenumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR', 'KINR')
	left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
	left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
	inner join userprofile up on up.securityusersid = IDAS.CRUWorkerName
	left  join intakeservicerequest as ISR on ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1
	left join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 

	where
		IDAS.IntakeNumber like intakeno || '%'
		and r.routingstatustypeid in (8,
		2)
		and IDAS.Activeflag = 1
		and ( coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID
			else r.tosecurityusersid = v_UserSID
		end ) ) 
	and Lower(ISRST.description)= v_statustext
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset) ;

	--Completed
	elsif (v_status = 11) then return QUERY select
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
		cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then 'Draft' else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else (select ISRST.description::character varying as typedescription from intakeservicerequest as ISR inner join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 where ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1 limit 1 ) end end as character varying) ,
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
	from
		IntakeDAStaging IDAS
	inner join intakeDAStatus ITDS on
		ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.intakenumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR',
		'KINR')
	left join routingstatustype RTs on
		RTs.sequencenumber = r.routingstatustypeid
		and rts.activeflag = 1
	left join teammemberroletype rt on
		rt.roletypekey = r.toroleid
		and rt.activeflag = 1
	inner join userprofile up on
		up.securityusersid = IDAS.CRUWorkerName
	left  join intakeservicerequest as ISR on ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1
	left join intakeserreqstatustype as ISRST on ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and ISRST.activeflag = 1 

	where
		IDAS.IntakeNumber like intakeno || '%'
		and r.routingstatustypeid in (8,
		2)
		and IDAS.Activeflag = 1
		and ( coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID
			else r.tosecurityusersid = v_UserSID
		end ) ) 
	and Lower(ISRST.description)= v_statustext
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset ;
	-------  Added  by  Gavaskar

	-- Accepted
	elsif (v_status = 2) then return QUERY select
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
		ISRST.description::character varying as typedescription,
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
			persl ->>'rolekey' = 'Victim' limit 1) as victimname,
		''::CHARACTER VARYING as DJSyouthname,
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
	from
		IntakeDAStaging IDAS
	inner join intakeDAStatus ITDS on
		ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.intakenumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode in ('INTR',
		'KINR')
	left join routingstatustype RTs on
		RTs.sequencenumber = r.routingstatustypeid
		and rts.activeflag = 1
	left join teammemberroletype rt on
		rt.roletypekey = r.toroleid
		and rt.activeflag = 1
	inner join userprofile up on
		up.securityusersid = IDAS.CRUWorkerName
	inner join intakeservicerequest as ISR on
		ISR.intakenumber = ITDS.intakenumber
		and ISR.activeflag = 1
	inner join intakeserreqstatustype as ISRST on
		ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid
		and ISRST.activeflag = 1
	where
		IDAS.IntakeNumber like intakeno || '%'
		and r.routingstatustypeid in (2,21)
		and IDAS.Activeflag = 1
		and lower(ISRST.intakeserreqstatustypekey) not in('rejected','reopen')
		and ( coalesce(r.fromsecurityusersid, IDAS.intakeuser) = v_UserSID
		or (
		case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			else r.tosecurityusersid = v_UserSID
		end ) )
	and Lower(ISRST.description)= Lower(v_statustext)
	order by
	(
	case
		sortorder
		when 'asc' then
		case
			sortcolumn
			when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
			when 'updateddate' then cast( IDAS.updatedon as character varying)
			when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
			else IDAS.intakenumber
		end
		else cast( IDAS.EntityName as character varying)
	end) asc,
	(
	case
		sortorder
		when 'desc' then
		case
			sortcolumn
			when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
			when 'updateddate' then cast( IDAS.updatedon as character varying)
			when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
			else IDAS.intakenumber
		end
		else cast( IDAS.EntityName as character varying)
	end ) desc
	limit pagesize offset v_pageoffset ;

	-- Rejected
	elsif (v_status = 3) then return QUERY select
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
		ISRST.description::character varying as typedescription,
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
				coalesce((select count(1) from IntakeAppeal IP where IP.intakenumber = IDAS.intakenumber ), 0)
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
	from
		IntakeDAStaging IDAS
	inner join intakeDAStatus ITDS on
		ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW'
	left join routing r on
		r.objectid = IDAS.intakenumber
		and (r.activeflag = 1
		or r.activeflag = v_activeflag)
		and r.eventcode = 'INTR'
	left join routingstatustype RTs on
		RTs.sequencenumber = r.routingstatustypeid
		and rts.activeflag = 1
	left join teammemberroletype rt on
		rt.roletypekey = r.toroleid
		and rt.activeflag = 1
	inner join userprofile up on
		up.securityusersid = IDAS.CRUWorkerName
	inner join intakeservicerequest as ISR on
		ISR.intakenumber = ITDS.intakenumber
		and ISR.activeflag = 1
	inner join intakeserreqstatustype as ISRST on
		ISRST.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid
		and ISRST.activeflag = 1
	where
		IDAS.IntakeNumber like intakeno || '%'
		and IDAS.Activeflag = 1
		and lower(ISRST.intakeserreqstatustypekey) in('rejected')
		and ( coalesce(r.fromsecurityusersid, IDAS.intakeuser) = v_UserSID
		or
		(case
			right(fromroleid, 2)
			when 'IW' then IDAS.InsertedBy = v_UserSID
			when 'KW' then IDAS.InsertedBy = v_UserSID
			else r.fromsecurityusersid = v_UserSID
		end ) )
	order by
		(
		case
			sortorder
			when 'asc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end) asc,
		(
		case
			sortorder
			when 'desc' then
			case
				sortcolumn
				when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
				when 'updateddate' then cast( IDAS.updatedon as character varying)
				when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
				else IDAS.intakenumber
			end
			else cast( IDAS.EntityName as character varying)
		end ) desc
	limit pagesize offset v_pageoffset ;
	
	-- Agathya : Added for pending review flow performance tuning.
	elsif (v_status = 1) then 

	return QUERY select
	count(1) over(), *
	from
		((
		select
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
			r.updatedon ,
			r.remarks,
			cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then case ITDS.status when 10 then 'Assigned' else 'Draft' end else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else rts.typedescription end end as character varying) ,
			dispositiondescription,
			statusdescription,
			cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) end end as character varying),
			(case
				when (ITDS.status in (2, 8)) then (
				select ISS.jsondata as js
				from intakesnapshot ISS
				where ISS.IntakeNumber = idas.intakenumber   limit 1)
				else IDAS.jsondata
			end)::jsonb,
			IDAS.updatedon ,
			ITDS.teamtypekey ,
			0,
			IDAS.ispreintake,
			(
			select
				''::character varying) as clwstatus,
			(
			select json_agg(e) as fatality from
				(
				select isrs.ischildfatality, isrs.ismaltreatment
				from intakeservicerequestsdm isrs
				where isrs.intakenumber = IDAS.IntakeNumber and activeflag = 1 ) as e) ::json,
			0 isprior,
	/* 		case
				coalesce(priors.casecount, 0)
				when 0 then 0
				else 1
			end as isprior, */
			(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  intakeservicerequestactor ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
			(
			select getcasepersonname
			from getcasepersonname ('intake', IDAS.IntakeNumber:: character varying)),
			(
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements( IDAS.jsondata -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Youth' ) as youthname, (
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements( IDAS.jsondata -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Victim' limit 1) as victimname,
			''::CHARACTER VARYING as DJSyouthname,
			(
			select PN.firstname
			from Person as PN
			where PN.personid = IDAS.focuspersonid) as youthfirstname,
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
		inner join intakeDAStatus ITDS on ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW' and ITDS.activeflag = 1
		and coalesce(IDAS.ispreintake, false) = false
		and lower(IDAS.Status) = 'pending' and idas.teamtypekey = 'CW'
		and IDAS.Activeflag = 1
		left join routing r on r.objectid = IDAS.intakenumber and (r.activeflag = 1 or r.activeflag = v_activeflag) and r.eventcode in ('INTR', 'KINR')
		left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
		left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
		left join userprofile up on up.securityusersid = IDAS.CRUWorkerName
		left join intakeservicerequest ISR on ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1
		where
		IDAS.IntakeNumber like intakeno || '%'
		and
		(case
			v_status
			when 1 then lower(IDAS.Status) = 'pending'
			else r.routingstatustypeid = v_status
		end
		or
		case
			IDAS.intakeuser
			when v_UserSID then r.routingstatustypeid=6
			else r.routingstatustypeid = v_status
		end )
		and IDAS.Activeflag = 1
		and coalesce(IDAS.ispreintake, false) = false -- removing this created a new issue, approved intakes started showing up as pending review, adding it back
		-- and coalesce(IDAS.ispreintake, false) = false ; Not required as per Debashish
		and ( 	case v_statustext when 'pending'  then ITDS.InsertedBy = v_UserSID  and coalesce(routingstatustypeid,0) != 860
				else coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
				or (
				case right(fromroleid, 2)
					when 'IW' then IDAS.InsertedBy = v_UserSID
					when 'KW' then IDAS.InsertedBy = v_UserSID
					when 'CW' then IDAS.InsertedBy = v_UserSID
					else r.tosecurityusersid = v_UserSID
				end )
			end ) 
		AND  CASE  WHEN  coalesce(lower(v_statustext),'') = 'pendingreview'  THEN  (coalesce(rts.typedescription,'') != '')  ELSE  TRUE  END
		order by
			(
			case
				sortorder
				when 'asc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.intakenumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end) asc,
			(
			case
				sortorder
				when 'desc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.intakenumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end ) desc )
		) t
	limit pagesize offset v_pageoffset ;
	-- Agathya : End pending review flow performance tuning.

	-- Pending and Assigned v_status 1 and 10
	else 
	raise notice 'else %',
	sortcolumn;

	return QUERY select
	count(1) over(), *
	from
		((
		select
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
			r.updatedon ,
			r.remarks,
			cast(case lower(coalesce(rts.typedescription, 'Pending')) when 'pending' then case ITDS.status when 10 then 'Assigned' else 'Draft' end else case when tosecurityusersid = IDAS.intakeuser and r.routingstatustypeid = 1 then 'Reopen' else rts.typedescription end end as character varying) ,
			dispositiondescription,
			statusdescription,
			cast( case r.insertedon when null then '' else case when age( now() at time zone 'utc') - age(r.insertedon + time '02:00' ) > '0:00' then cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) else cast( age( now() at time zone 'utc') - age( r.insertedon + time '02:00' ) as character varying(5)) end end as character varying),
			(case
				when (ITDS.status in (2, 8)) then (
				select ISS.jsondata as js
				from intakesnapshot ISS
				where ISS.IntakeNumber = idas.intakenumber   limit 1)
				else IDAS.jsondata
			end)::jsonb,
			IDAS.updatedon ,
			ITDS.teamtypekey ,
			0,
			IDAS.ispreintake,
			(
			select
				''::character varying) as clwstatus,
			(
			select json_agg(e) as fatality from
				(
				select isrs.ischildfatality, isrs.ismaltreatment
				from intakeservicerequestsdm isrs
				where isrs.intakenumber = IDAS.IntakeNumber and activeflag = 1 ) as e) ::json,
			0 isprior,
			(SELECT json_agg(x) as headofhousehlod FROM ( 
			SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
			FROM  intakeservicerequestactor ISRA  
			INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
			INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
			WHERE    ISRA.activeflag =1  
			AND ISRA.intakeservicerequestpersontypekey <> 'CHILD' AND ISRA.isheadofhousehold = true
			AND ISRA.intakenumber = IDAS.IntakeNumber
			ORDER BY 1 ) as x):: json,
			(
			select getcasepersonname
			from getcasepersonname ('intake', IDAS.IntakeNumber:: character varying)),
			(
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements( IDAS.jsondata -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Youth' ) as youthname, (
			select cast(concat(initcap(persons ->> 'Lastname'), coalesce(' ' ||(persons ->> 'suffix'), ''), ', ', initcap(persons ->> 'Firstname'))as character varying)
			from jsonb_array_elements( IDAS.jsondata -> 'persons') persons , jsonb_array_elements(persons -> 'personRole') persl
			where persl ->>'rolekey' = 'Victim' limit 1) as victimname,
			''::CHARACTER VARYING as DJSyouthname,
			(
			select PN.firstname
			from Person as PN
			where PN.personid = IDAS.focuspersonid) as youthfirstname,
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
		inner join intakeDAStatus ITDS on ITDS.intakenumber = IDAS.intakenumber and ITDS.teamtypekey = 'CW' and ITDS.activeflag = 1
		left join routing r on r.objectid = IDAS.intakenumber and (r.activeflag = 1 or r.activeflag = v_activeflag) and r.eventcode in ('INTR', 'KINR')
		left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
		left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
		left join userprofile up on up.securityusersid = IDAS.CRUWorkerName
		left join intakeservicerequest ISR on ISR.intakenumber = IDAS.intakenumber and ISR.activeflag = 1 
		where
		IDAS.IntakeNumber like intakeno || '%'
		and
		(case
			v_status
			when 1 then lower(IDAS.Status) = 'pending'
			else r.routingstatustypeid = v_status
		end
		or
		case
			IDAS.intakeuser
			when v_UserSID then r.routingstatustypeid=6
			else r.routingstatustypeid = v_status
		end )
		and IDAS.Activeflag = 1
		and coalesce(IDAS.ispreintake, false) = false 
		and ( 	case v_statustext when 'pending'  then ITDS.InsertedBy = v_UserSID  and coalesce(routingstatustypeid,0) != 860
				else coalesce(r.tosecurityusersid, IDAS.intakeuser) = v_UserSID
				or (
				case right(fromroleid, 2)
					when 'IW' then IDAS.InsertedBy = v_UserSID
					when 'KW' then IDAS.InsertedBy = v_UserSID
					when 'CW' then IDAS.InsertedBy = v_UserSID
					else r.tosecurityusersid = v_UserSID
				end )
			end ) 
		AND  CASE  WHEN  coalesce(lower(v_statustext),'') = 'pendingreview'  THEN  (coalesce(rts.typedescription,'') != '')  ELSE  TRUE  END
		order by
			(
			case
				sortorder
				when 'asc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.intakenumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end) asc,
			(
			case
				sortorder
				when 'desc' then
				case
					sortcolumn
					when 'receiveddate' then cast( IDAS.TimeRecieved as character varying)
					when 'updateddate' then cast( IDAS.updatedon as character varying)
					when 'submittedworker' then cast(up.firstname || ' ' || up.lastname as character varying)
					when 'intakenumber' then IDAS.intakenumber
					else cast(IDAS.id as character varying)
				end
				else cast( IDAS.EntityName as character varying)
			end ) desc ) 
		) t
	limit pagesize offset v_pageoffset ;
	end if;
	end if;
END IF;  
end;

$function$
;

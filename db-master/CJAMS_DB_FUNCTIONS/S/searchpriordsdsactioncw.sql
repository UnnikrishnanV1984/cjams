drop FUNCTION if EXISTS cjams.searchpriordsdsactioncw(v_personid uuid, v_mdmid character varying, v_cisclienid character varying, v_userid character varying, v_cjamspid character varying);
CREATE OR REPLACE FUNCTION cjams.searchpriordsdsactioncw(v_personid uuid, v_mdmid character varying, v_cisclienid character varying, v_userid character varying, v_cjamspid character varying DEFAULT NULL::character varying)
 RETURNS TABLE(objectid character varying, danumber character varying, daplanningid character varying, dasubtype character varying, roles jsonb, datereceived timestamp without time zone, datecreated timestamp without time zone, datecompleted timestamp without time zone, status character varying, datype character varying, county character varying, restrictstatus text, outcomes json, personname text, relationshiparray json, workername character varying, headofhousehlod json, allegedmaltreator json)
 LANGUAGE plpgsql
AS $function$         
BEGIN 

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Sundeep Kiran Anugolu 12/17/2025 - CIDM-10748 Global Person search to get details for Adult services
-- 03/16/2026 SundeepKiran Anugolu- CDM-44739 - person search prior history based on cjamspid if person is null
------------------------------------------------------------------------

IF v_personid IS NULL AND v_cjamspid IS NOT NULL THEN
	SELECT p.personid
          INTO v_personid
        FROM cjams.person p
        WHERE p.cjamspid =  v_cjamspid::bigint
        LIMIT 1;
END IF;

IF v_personid IS NULL THEN 
  IF v_mdmid IS NOT NULL THEN 
       select personid INTO v_personid from personidentifier where personidentifiervalue = v_mdmid and personidentifiertypekey = 'MDM_ID';
  END IF;
END IF;
IF v_personid IS NULL THEN 
  IF v_cisclienid IS NOT NULL THEN 
       select personid INTO v_personid from personidentifier where personidentifiervalue = v_cisclienid and personidentifiertypekey = 'IRN';
  END IF;
END IF;
-- if Person id is still null
IF v_personid IS NULL THEN 
  IF v_cisclienid IS NOT NULL THEN 
      SELECT personid INTO v_personid FROM person where cisclientid = v_cisclienid ;
  END IF;
END IF;

RETURN QUERY	
SELECT * FROM (

	-- CPS cases
	SELECT ISR.IntakeServiceId:: character varying,    
case when ISRT.intakeservreqtypekey='Information and Referral' then
ISR.intakenumber
else ISR.ServiceRequestNumber
end as DANumber,
''::character varying,
SRST.description as dasubtype,
jsonb_agg(ref_role.value_text) as roles,
ISR.Reporteddate as DateReceived,
ISR.Insertedon as DateCreated,
case when ISRST.intakeserreqstatustypekey in ('Completed', 'Closed')  then  
COALESCE(ISR.exitdate, (select statusdate from intakeservicerequestdispositioncode st
where st.IntakeSerReqStatusTypeid = ISRST.IntakeSerReqStatusTypeid
and st.intakeserviceid = ISR.intakeserviceid
order by statusdate desc limit 1))
else
null
end AS DateCompleted,
ISRST.intakeserreqstatustypekey AS Status,
case when ISRT.intakeservreqtypekey = 'Request for services' then
'Service Case'
else
ISRT.description
end as datype,
-- upa.county,
(select c.countyname
from caseassignment a,
county c
where a.toldssid = c.countyid
and a.objectid = ISR.IntakeServiceId
and a.responsibilitytypekey in ('family', 'child' )
and a.activeflag = 1
order by a.enddate desc
limit 1
) as county,
(SELECT * FROM getRestrictedCaseStatus(ISR.intakeserviceid::text,v_userid)) AS restrictStatus,
(
select  json_agg(invst) from
(
select  COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'') as personname,
(select  
COALESCE(p.prefx,'')||' ' ||COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'')
from person p
where p.personid in (select *  from f_getmaltreatorperson(ia.investigationallegationid))) as maltreatorname,
(
SELECT json_agg(finding) FROM
(
SELECT IFN.investigationfindingtypekey,IFN.investigationfindingid,
IFN.findingcomments,IFN.isharm,IFN.isharmsubstantial,IFN.harmdesc,
IFN.intentionalinjurydesc,IFNT.description AS findingdescription, IFN.omissiondesc,IFN.finalfinding,

CASE WHEN iaml.overridefindingtypekey IS NOT NULL THEN
(SELECT IFNT.description FROM investigationfindingtype IFNT WHERE IFNT.investigationfindingtypekey = iaml.overridefindingtypekey AND IFNT.activeflag =1)
WHEN IFN.finalfinding IS NOT NULL THEN
(SELECT IFNT.description FROM investigationfindingtype IFNT WHERE IFNT.investigationfindingtypekey = IFN.finalfinding AND IFNT.activeflag =1)
END AS finalfindingdescription,

CASE WHEN (iaml.oahearingdecision) IS NOT NULL THEN
(SELECT IFNT.description FROM investigationfindingtype IFNT WHERE IFNT.investigationfindingtypekey = iaml.oahearingdecision AND IFNT.activeflag =1)
WHEN(iaml.cchearingdecisiontypekey) IS NOT NULL THEN
(SELECT IFNT.description FROM investigationfindingtype IFNT WHERE IFNT.investigationfindingtypekey = iaml.cchearingdecisiontypekey AND IFNT.activeflag =1)
WHEN (iaml.csahearingdecisiontypekey) IS NOT NULL THEN
(SELECT IFNT.description FROM investigationfindingtype IFNT WHERE IFNT.investigationfindingtypekey = iaml.csahearingdecisiontypekey AND IFNT.activeflag =1)
WHEN (iaml.coahearingdecisiontypekey) IS NOT NULL THEN
(SELECT IFNT.description FROM investigationfindingtype IFNT WHERE IFNT.investigationfindingtypekey = iaml.coahearingdecisiontypekey AND IFNT.activeflag =1)
WHEN (iaml.overridefindingtypekey) IS NOT NULL THEN
(SELECT IFNT.description FROM investigationfindingtype IFNT WHERE IFNT.investigationfindingtypekey = iaml.overridefindingtypekey AND IFNT.activeflag =1)
END AS appealfindingdescription,

--for appeals
iaml.overridefindingtypekey,
iaml.finalizeddate,

  CASE WHEN iaml.expungementflag = 1 THEN true ELSE false END as expungement,
(SELECT json_agg(ass)FROM(
SELECT  
ifna.firstname,ifna.lastname,
ifna.comments,PT.typedescription,ifna.professiontypekey,ifna.isassessor
FROM investigationfindingassessors ifna
LEFT JOIN professiontype PT ON ifna.professiontypekey = PT.professiontypekey
WHERE ifna.investigationfindingid = IFN.investigationfindingid
)ass ):: json as assessors
FROM investigationfinding IFN
join investigationfindingtype IFNT on IFNT.investigationfindingtypekey = IFN.investigationfindingtypekey
INNER JOIN Investigationallegationmaltreators iaml ON iaml.investigationallegationid = IFN.investigationallegationid AND iaml.activeflag =1
WHERE IFN.investigationallegationid  =  IA.investigationallegationid and IFN.activeflag =1 ORDER BY iaml.updatedon desc LIMIT 1
) as finding
) as findings,
(case when (select count(investigationallegationhistoryid) from investigationallegation_history iah where iah.investigationallegationid = ia.investigationallegationid) > 0 then true else false end) maltreatmenttypemanualchange,
isra.intakeservicerequestpersontypekey,
alle."name",
(select rt.description from relationshiptype rt
inner join actorrelationship ar on rt.relationshiptypekey = ar.relationshiptypekey and ar.activeflag = 1 and rt.activeflag = 1
join person up on up.personid = ar.person1id
join person up2 on up2.personid = ar.person2id
where ar.person1id = isra.personid and ar.person2id in (select *  from f_getmaltreatorperson(ia.investigationallegationid))
ORDER BY ar.insertedon DESC LIMIT 1)
from investigation inv  
join Investigationmaltreatment im on im.investigationid= inv.investigationid and im.activeflag =1
JOIN Investigationmaltreatmentactor ima on ima.maltreatmentid = im.maltreatmentid AND ima.activeflag =1        
JOIN intakeservicerequestactor isra on isra.intakeservicerequestactorid = ima.intakeservicerequestactorid
JOIN person p on p.personid = isra.personid
JOIN Investigationallegation ia ON  ia.investigationmaltreatmentactorid = ima.investigationmaltreatmentactorid
JOIN allegation  alle on  alle.allegationid = ia.allegationid AND alle.activeflag = 1
--JOIN investigationallegationmaltreators iam on iam.investigationallegationid = ia.investigationallegationid AND iam.activeflag =1
--JOIN intakeservicerequestactor isra2 ON isra2.intakeservicerequestactorid = iam.intakeservicerequestactorid
where  inv.intakeserviceid = ISR.intakeserviceid
) as  invst
),
concat_ws(' ',coalesce(pr.firstname,null),coalesce(pr.middlename,null),coalesce(pr.lastname,null))::text,
(
select json_agg(x) from (
select ar.person1id as secondaryuserid,ar.person2id as primaryuserid,rt.description,up.firstname,up2.firstname
from relationshiptype rt
inner join actorrelationship ar on rt.relationshiptypekey = ar.relationshiptypekey and ar.activeflag = 1 and rt.activeflag = 1
join person up on up.personid = ar.person1id
join person up2 on up2.personid = ar.person2id
where ar.intakeservicerequestactorid in (
select ina.intakeservicerequestactorid from  intakeservicerequestactor ina
where ina.intakeserviceid =  ISR.intakeserviceid)
) x
) :: json as relationshiparray,
( SELECT cast(UP.firstname || ' ' || UP.lastname as character varying) as workername
FROM routing R
INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
WHERE R.objectid = ISR.intakeserviceid::character varying AND R.activeflag =1
AND R.eventcode = 'INVT' AND R.toroleid = 'CWCW' limit 1
),
(SELECT json_agg(x) as headofhousehlod FROM (
SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
FROM  intakeservicerequestactor ISRA  
INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1
INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1
WHERE    ISRA.activeflag =1 AND ISRA.isheadofhousehold = true
AND ISRA.intakeserviceid = ISR.intakeserviceid
ORDER BY 1)
as x):: json,
(SELECT json_agg(x) as allegedmaltreator FROM (
SELECT DISTINCT P.firstname, P.lastname,P.middlename,P.suffix from person P
INNER JOIN  actor A on A.personid = P.personid  AND A.activeflag = 1
INNER JOIN  intakeservicerequestactor ISRA on ISRA.actorid = A.actorid  AND ISRA.activeflag = 1
WHERE ISRA.intakeserviceid = ISR.intakeserviceid and ISRA.intakeservicerequestpersontypekey = 'AM')
as x):: json
 
FROM person pr
inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid
and Actor.activeflag = 1
left join personidentifier pri on pri.personid = pr.personid
and pri.activeflag = 1
and pri.personidentifiertypekey = 'MDM_ID'
inner join referencevalues ref_role on ref_role.ref_key = actor.intakeservicerequestpersontypekey
and ref_role.referencetypeid in (176) and coalesce(ref_role.teamtypekey,'CW') = 'CW' and ref_role.activeflag = 1
and coalesce(ref_role.teamtypekey,'') <> 'AS'
and ref_role.ref_key not in
(select insa.intakeservicerequestpersontypekey
from intakeservicerequestactor insa
where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid
and insa.spexpungementflag =1)
join IntakeServiceRequest ISR on ISR.intakeserviceid = Actor.intakeserviceid
and ISR.activeflag = 1
and ISR.teamtypekey = 'CW'
left join IntakeSerReqStatusType ISRST ON ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId
--left join intakeservicerequestdispositioncode st on st.IntakeSerReqStatusTypeid = ISRST.IntakeSerReqStatusTypeid and st.intakeserviceid = ISR.intakeserviceid
JOIN  IntakeServiceRequestType ISRT ON ISRT.IntakeServReqTypeId = ISR.IntakeServReqTypeId
and ISRT.intakeservreqtypekey != 'Request for services'
JOIN  ServiceRequestSubType SRST ON SRST.ServiceRequestSubTypeId = ISR.IntakeServiceRequestClassId  
and (case when ISRT.intakeservreqtypekey = 'CHILD' then SRST.description != 'Default' else true end)
where --((pr.personid=v_personid) or (pri.personidentifiervalue = v_mdmid) or (pr.cisclientid = v_cisclienid))
pr.personid=v_personid
and (select count(1) from intakeservicerequestactor insa where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid
and insa.spexpungementflag =1) = 0 and pr.activeflag = 1
  group by
  ISR.IntakeServiceId,
  ISR.ServiceRequestNumber,
  SRST.description,
  ISR.Reporteddate,
  ISR.Insertedon,
  ISRST.intakeserreqstatustypekey,
--  ATMSR.updatedon,
  ISRT.description,
  ISRT.intakeservreqtypekey,
--  upa.county,
  ISRST.IntakeSerReqStatusTypeid,
  pr.firstname,
    pr.lastname,
    pr.middlename
	--  st.insertedon
 
 UNION ALL

	-- Intake / Referrals							   
	 SELECT
		staging.intakenumber,
		staging.intakenumber AS DANumber,
		''::character varying ,
		null AS dasubtype,
		jsonb_agg(ref_role.value_text) AS roles,
		staging.daterecieved AS DateReceived,
		--(to_timestamp(staging.jsondata -> 'General' ->> 'CreatedDate', 'YYYY/MM/DD HH24:MI:SS') at time zone 'EDT') as DateCreated,
		(staging.jsondata -> 'General' ->> 'CreatedDate')::timestamp without time zone as DateCreated,
		null AS DateCompleted,
		coalesce ((CASE 
		  WHEN ISRST.description IS NOT null and ISR.activeflag = 1 then ISRST.description
		  WHEN EXISTS(select 1 FROM routing R where r.routingstatustypeid = 1 AND r.objectid = staging.intakenumber
		      AND r.eventcode = 'INTR' AND r.activeflag = 1 LIMIT 1) THEN 'Pending Approval'
		  ELSE (select r2.typedescription FROM routing r,routingstatustype r2 
			where r.routingstatustypeid = r2.sequencenumber  AND r.objectid = staging.intakenumber
			AND r.eventcode = 'INTR' AND r.activeflag = 1 order by r.insertedon desc limit 1)	 
		  end),'In Progress') AS Status,    
		'Intake' AS datype,
		county.countyname AS county,
		(SELECT * FROM getRestrictedCaseStatus(staging.intakenumber::text,v_userid)) AS restrictStatus,
		null::json,
        concat_ws(' ',coalesce(pr.firstname,null),coalesce(pr.middlename,null),coalesce(pr.lastname,null))::text,
		null::json,
		( 	SELECT cast(UP.firstname || ' ' || UP.lastname as character varying) as workername 
		FROM routing R 
		INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
		WHERE R.objectid = staging.intakenumber::character varying AND R.activeflag =1 limit 1
	),
	(SELECT json_agg(x) as headofhousehlod FROM ( 
        SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE    ISRA.activeflag =1 AND ISRA.isheadofhousehold = true
		AND ISRA.intakenumber = staging.intakenumber
		ORDER BY 1 ) as x):: json,
	(SELECT json_agg(x) as allegedmaltreator FROM (
		SELECT DISTINCT P.firstname, P.lastname,P.middlename,P.suffix from person P
		INNER JOIN  actor A on A.personid = P.personid  AND A.activeflag = 1
		INNER JOIN  intakeservicerequestactor ISRA on ISRA.actorid = A.actorid  AND ISRA.activeflag = 1
		WHERE ISRA.intakenumber = staging.intakenumber and ISRA.intakeservicerequestpersontypekey = 'AM'
		) as x):: json

	FROM person pr
	inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid and Actor.activeflag = 1
	left join personidentifier pri on pri.personid = pr.personid and pri.activeflag = 1 and pri.personidentifiertypekey = 'MDM_ID'
	INNER JOIN referencevalues ref_role ON ref_role.ref_key = actor.intakeservicerequestpersontypekey and ref_role.referencetypeid in (176) and coalesce(ref_role.teamtypekey,'CW') = 'CW' and ref_role.activeflag = 1
    and ref_role.ref_key not in (select insa.intakeservicerequestpersontypekey from intakeservicerequestactor insa where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid and insa.spexpungementflag =1)	
	LEFT JOIN IntakeServiceRequest ISR ON ISR.intakenumber = Actor.intakenumber and ISR.teamtypekey = 'CW' and ISR.activeflag=1
	LEFT JOIN IntakeSerReqStatusType ISRST ON ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId										   
    JOIN (
		SELECT y.intakenumber, y.daterecieved, y.jsondata, y.status
		FROM intakedastaging y
		JOIN (
			SELECT max(a.id) as id, a.intakenumber, max(a.versionnumber) as versionnumber from intakedastaging a where a.activeflag = 1 and a.teamtypekey = 'CW' and lower(a.status) in ('complete','closed','pending') group by a.intakenumber
		) x ON x.id = y.id
	) staging ON staging.intakenumber = Actor.intakenumber
	LEFT JOIN county ON county.countyid::text = (jsondata -> 'General' ->> 'countyid')
	
	WHERE --((pr.personid=v_personid) or (pri.personidentifiervalue = v_mdmid) or (pr.cisclientid = v_cisclienid))
		pr.personid=v_personid
		and  (select count(1) from intakeservicerequestactor insa where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid and insa.spexpungementflag =1) = 0
		AND Actor.activeflag = 1
	GROUP BY 
	 staging.jsondata,
	 staging.intakenumber,
	 staging.daterecieved,
	 ISRST.description,
	 county.countyname,
	 isr.activeflag,
     pr.firstname,
    pr.lastname,
    pr.middlename

UNION ALL

-- Migrated Intake / Referrals

SELECT
	isr.intakenumber,
	isr.intakenumber AS DANumber,
	''::character varying,
	null AS dasubtype,
	jsonb_agg(ref_role.value_text) AS roles,
	isr.reporteddate AS DateReceived,
	isr.effectivedate as DateCreated,
	null AS DateCompleted,
	--	ISRST.description   AS Status,
	(SELECT 
		CASE 
			WHEN ids.status = 2
				THEN 'Accepted'
			WHEN ids.status = 8
				THEN 'Closed'
			ELSE
				'Pending'
		END
	FROM intakedastatus ids WHERE ids.intakenumber = isr.intakenumber AND ids.activeflag = 1 LIMIT 1)  AS status,  
	'Intake' AS datype,
	county.countyname AS county,
	(SELECT * FROM getRestrictedCaseStatus(isr.intakenumber::text, v_userid)) AS restrictStatus,
	null::json,
    concat_ws(' ',coalesce(pr.firstname,null),coalesce(pr.middlename,null),coalesce(pr.lastname,null))::text,
	null::json,
	( 	SELECT cast(UP.firstname || ' ' || UP.lastname as character varying) as workername 
		FROM routing R 
		INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
		WHERE R.objectid = isr.intakenumber::character varying AND R.activeflag =1 limit 1
	),
	(SELECT json_agg(x) as headofhousehlod FROM ( 
		SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE    ISRA.activeflag =1 AND ISRA.isheadofhousehold = true
		AND ISRA.intakenumber = isr.intakenumber
		ORDER BY 1 )
	as x):: json,
	(SELECT json_agg(x) as allegedmaltreator FROM (
		SELECT DISTINCT P.firstname, P.lastname,P.middlename,P.suffix from person P
		INNER JOIN  actor A on A.personid = P.personid  AND A.activeflag = 1
		INNER JOIN  intakeservicerequestactor ISRA on ISRA.actorid = A.actorid  AND ISRA.activeflag = 1
		WHERE ISRA.intakenumber = isr.intakenumber and ISRA.intakeservicerequestpersontypekey = 'AM') 
	as x):: json
	FROM person pr
	inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid and Actor.activeflag = 1
	left join personidentifier pri on pri.personid = pr.personid and pri.activeflag = 1 and pri.personidentifiertypekey = 'MDM_ID'
	INNER JOIN referencevalues ref_role ON ref_role.ref_key = actor.intakeservicerequestpersontypekey and ref_role.referencetypeid in (176) and coalesce(ref_role.teamtypekey,'CW') = 'CW' and ref_role.activeflag = 1
    and ref_role.ref_key not in (select insa.intakeservicerequestpersontypekey from intakeservicerequestactor insa where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid and insa.spexpungementflag =1)	
	JOIN IntakeServiceRequest ISR ON ISR.intakenumber = Actor.intakenumber AND ISR.activeflag = 1 AND ISR.intakenumber ILIKE 'cw%' AND ISR.teamtypekey = 'CW'
	JOIN IntakeSerReqStatusType ISRST ON ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId
	left join county ON isr.countyid = county.countyid

	WHERE --((pr.personid=v_personid) or (pri.personidentifiervalue = v_mdmid) or (pr.cisclientid = v_cisclienid))
		pr.personid=v_personid
		and  (select count(1) from intakeservicerequestactor insa where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid and insa.spexpungementflag =1) = 0
		AND Actor.activeflag = 1
	GROUP BY
	isr.intakenumber,
	isr.reporteddate,
	isr.effectivedate,
	ISRST.description,
	county.countyname,
    pr.firstname,
    pr.lastname,
    pr.middlename
											   
 UNION ALL		
 
	-- Service cases
  SELECT
	 s_c.servicecaseid::character varying,
	 s_c.servicecasenumber as DANumber,
	 ''::character varying,
	 (select scr.programkey || '/' || scr.subprogramkey
		from servicecaserequest scr 
	  where scr.servicecaseid = s_c.servicecaseid 
		and scr.activeflag = 1
	  order by scr.insertedon desc
	  limit 1
	  ) as dasubtype,	
	 -- scr.programkey || '/' || scr.subprogramkey as dasubtype,
	 jsonb_agg(ref_role.value_text) as roles,
	 s_c.startdate as DateReceived,
	 s_c.startdate as DateCreated,
	 case when lower(s_c.dispositioncode) = 'closed' then scd.effectivedate else null end AS DateCompleted,
	 --s_c.statustypekey AS Status,
	 s_c.dispositioncode as Status,
	 'Service Case' as datype,
	(select c.countyname
	from caseassignment a,
	county c
	where a.toldssid = c.countyid
	and a.objectid = s_c.servicecaseid
	and a.responsibilitytypekey in ('family', 'child' )
	and a.activeflag = 1
	order by a.enddate desc
	limit 1
	) as county,
	 (SELECT * FROM getRestrictedCaseStatus(s_c.servicecaseid::text,v_userid)) AS restrictStatus,
	null::json,
    concat_ws(' ',coalesce(pr.firstname,null),coalesce(pr.middlename,null),coalesce(pr.lastname,null))::text,
	null::json,
	( 	SELECT cast(UP.firstname || ' ' || UP.lastname as character varying) as workername 
		FROM routing R 
		INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
		WHERE R.objectid = s_c.servicecaseid::character varying AND R.activeflag =1 limit 1
	),
	(SELECT json_agg(x) as headofhousehlod FROM ( 
        SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
		FROM  intakeservicerequestactor ISRA  
		INNER JOIN person p on p.personid = ISRA.personid AND  p.activeflag =1 
		INNER JOIN actor A ON A.actorid = ISRA.actorid AND A.activeflag =1 
		WHERE    ISRA.activeflag =1 AND ISRA.isheadofhousehold = true
		AND ISRA.servicecaseid = s_c.servicecaseid
		ORDER BY 1 ) as x):: json,
	(SELECT json_agg(x) as allegedmaltreator FROM (
		SELECT DISTINCT P.firstname, P.lastname,P.middlename,P.suffix from person P
		INNER JOIN  actor A on A.personid = P.personid  AND A.activeflag = 1
		INNER JOIN  intakeservicerequestactor ISRA on ISRA.actorid = A.actorid  AND ISRA.activeflag = 1
		WHERE ISRA.servicecaseid = s_c.servicecaseid and ISRA.intakeservicerequestpersontypekey = 'AM'
		) as x):: json
	FROM person pr
	inner join IntakeServiceRequestActor Actor on Actor.personid = pr.personid and Actor.activeflag = 1 and Actor.intakeservicerequestpersontypekey not in ('AM')
	left join personidentifier pri on pri.personid = pr.personid and pri.activeflag = 1 and pri.personidentifiertypekey = 'MDM_ID'
	inner join referencevalues ref_role on ref_role.ref_key = actor.intakeservicerequestpersontypekey and ref_role.referencetypeid in (176) and coalesce(ref_role.teamtypekey,'CW') = 'CW' and ref_role.activeflag = 1
	and ref_role.ref_key not in (select insa.intakeservicerequestpersontypekey from intakeservicerequestactor insa where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid and insa.spexpungementflag =1)
	join servicecase s_c on s_c.servicecaseid = Actor.servicecaseid and s_c.activeflag = 1
	-- left join servicecaserequest scr on scr.servicecaseid = s_c.servicecaseid and scr.activeflag = 1
	LEFT JOIN servicecasedisposition scd  on scd.servicecaseid = s_c.servicecaseid  where  scd.activeflag = 1 and scd.servicecasedispositionid IN (
	 	select servicecasedispositionid from servicecasedisposition scd_i
	    where scd_i.servicecaseid = s_c.servicecaseid
	    and scd_i.activeflag = 1
	    order by effectivedate DESC
	    limit 1
	) 
	and 
	pr.personid=v_personid
	and (select count(1) from intakeservicerequestactor insa where insa.intakeservicerequestactorid= Actor.intakeservicerequestactorid and insa.spexpungementflag =1) = 0 AND Actor.activeflag = 1
	group by 
	 s_c.servicecaseid,
	 s_c.servicecasenumber,
	 -- scr.subprogramkey,
	 s_c.startdate,
	 scd.dispositioncode,
	 scd.effectivedate,
	 scd.intakeserreqstatustypekey,
     pr.firstname,
     pr.lastname,
     pr.middlename
	 -- ,scr.programkey

UNION ALL	
--- Adoption case 
select 
    ac.adoptioncaseid::character varying,
	ac.adoptioncasenumber, 
	ac.adoptionplanningid::character varying,
	'' as dasubtype,
	jsonb_agg(ref_role.value_text) as roles,
	ac.startdate as DateReceived,
	ac.startdate as DateCreated,
	case when lower(acd.dispositioncode) = 'closed' then acd.effectivedate else null end AS DateCompleted,
	ac.statustypekey as Status,
	'Adoption Case' as datype,
	null as county,
	(SELECT * FROM getRestrictedCaseStatus( ac.adoptioncaseid::text,v_userid)) AS restrictStatus,
	null::json,
	concat_ws(' ',coalesce(pr.firstname,null),coalesce(pr.middlename,null),coalesce(pr.lastname,null))::text,
	null::json,
	(SELECT cast(UP.firstname || ' ' || UP.lastname as character varying) as workername 
	FROM routing R 
	INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
	WHERE R.objectid = ac.adoptioncaseid::character varying AND R.activeflag =1 limit 1	),
	(SELECT json_agg(x) as headofhousehlod FROM ( 
     SELECT distinct concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as personname
	 FROM  adoptioncaseactor acar  
	 INNER JOIN person p on p.personid = acar.personid AND  p.activeflag =1
--	 INNER JOIN actor A ON A.actorid = acar.actorid AND A.activeflag =1 
--	 WHERE acar.activeflag =1 AND acar.isheadofhousehold = true
	 AND acar.adoptioncaseid = ac.adoptioncaseid
	 ORDER BY 1 ) as x):: json,
	 null:: json
--    FROM  adoptioncaseactor aca  
--    INNER JOIN person p on p.personid = aca.personid AND  p.activeflag =1 
--    WHERE    aca.activeflag =1  AND aca.actortypekey in( 'PVTADPCHILD','CHILD' )
--    AND aca.adoptioncaseid = ac.adoptioncaseid
--	ORDER BY 1

FROM 	adoptioncase ac 
join adoptioncaseactor acar on ac.adoptioncaseid = acar.adoptioncaseid
join person pr on pr.personid = acar.personid and pr.activeflag =1 
left join personidentifier pri on pri.personid = pr.personid and pri.activeflag = 1 and pri.personidentifiertypekey = 'MDM_ID'
left join personidentifier pri2 on pri2.personid = pr.personid and pri2.activeflag = 1 and pri2.personidentifiertypekey = 'IRN'
left join referencevalues ref_role on ref_role.ref_key = acar.actortypekey  and ref_role.referencetypeid in (176) and coalesce(ref_role.teamtypekey,'CW') = 'CW' and ref_role.activeflag = 1
left join (select * from adoptioncasedisposition acd1 where acd1.adoptioncaseid in (
			select distinct(acar1.adoptioncaseid) from person p1
			left join personidentifier pri1 on pri1.personid = p1.personid and pri1.activeflag = 1 and pri1.personidentifiertypekey = 'MDM_ID'
			left join personidentifier pri3 on pri3.personid = p1.personid and pri3.activeflag = 1 and pri3.personidentifiertypekey = 'IRN'
			join adoptioncaseactor acar1 on acar1.personid = p1.personid
			where p1.personid=v_personid) and acd1.activeflag = 1 order by updatedon desc limit 1) acd on acd.adoptioncaseid = ac.adoptioncaseid
where pr.personid=v_personid
group by ac.adoptioncaseid ,ac.adoptioncasenumber, 
	ac.adoptionplanningid,ac.startdate,ac.statustypekey,
	acd.dispositioncode,acd.effectivedate,
    pr.firstname,
     pr.lastname,
     pr.middlename
 )  AS datav 
WHERE datav.restrictStatus in ('INCL','INCLRES','EXCLUDE')
order by datav.datype, datav.DateReceived desc;

END;

$function$
;
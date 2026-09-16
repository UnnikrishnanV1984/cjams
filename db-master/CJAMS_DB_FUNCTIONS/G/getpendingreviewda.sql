CREATE OR REPLACE FUNCTION cjams.getpendingreviewda(usersid character varying, pagenumber bigint, pagesize bigint, servicereqno character varying)
 RETURNS TABLE(totalcount bigint, servicereqid uuid, servicerequestnumber character varying, intakenumber character varying, servreqtype character varying, servreqsubtype character varying, reporteddate timestamp without time zone, raname character varying, servreqstatus character varying, submitteon timestamp without time zone, submitteduser character varying, isgroup boolean, commets text, appevent character varying, dadetails json, sdm json, eventdescription character varying, objectid character varying, entityid character varying, client_id bigint, service_log_id integer, permanencyplanid uuid, legalguardian json)
 LANGUAGE plpgsql
AS $function$

--------------------------------------------------------------------------------
-- CIDM-4111 02/28 - Veera Nadimpalli
-- CIDM-4111 To get Quick Person Delete Pending Approval Records
-- 10/03/2022 - Vineet Tirodkar - for CPS Response Timer Save Request to Supervisor (CIDM-5447/B-144171)
-- 06/14/2023 - Palaniraj / Chandra Ramasamy - Performance tuning - CIDM-7307 
-- 01/13/2025 - CIDM-10020 - Akhil / Sundeep - Person card updates for approval inbox
-- 01/16/2025 - CIDM-10020 - Sundeep / Akhil - To fix inactive cps case case number unavailability issue
-- 01/30/2025 - CIDM-10020 - Sundeep / Akhil - To Fix Approval Screen for CPS cases
-- 12/02/2025 - CDM-44606 - Parshal Chitrakar - TO prevent populating supervisor dashboard with appeal coordinator(APPL) eventcode request.
-- 03/06/2026 - CIDM-10855- Vinesh Puthan - Added personid lookup for ADPR event code via permanencyplan/actor join
--------------------------------------------------------------------------------


declare
v_pageoffset int;
v_pagenumber int;

begin
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;
return query
SELECT
count(1) over(), *, (select getcasepersonname as legalguardian from getcasepersonname (
CASE
WHEN Assignlist.servreqtype = 'Service Case' THEN 'servicecase'
WHEN Assignlist.servreqtype = 'Adoption Case' THEN 'adoptioncase'
ELSE 'servicerequest'
END,
intakeserviceid::character varying))
FROM
(
SELECT
ISR.intakeserviceid
, cast(ISR.servicerequestnumber || case coalesce(isr.actiontype,'') when '' then '' else ' (' || coalesce(isr.actiontype,'') || ')' end as character varying)
, isr.intakenumber
, (SELECT itsrt.intakeservreqtypekey FROM intakeservicerequesttype as itsrt
WHERE itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid AND itsrt.activeflag=1 limit 1
) AS servreqtype
, (
SELECT srst.classkey
FROM servicerequestsubtype as srst
WHERE srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid AND srst.activeflag=1 limit 1
)
, ISR.reporteddate :: timestamp
-- , cast( (TRIM(PN.lastname) || ',    ' ||TRIM(PN.firstname)) as character varying) clientname
, ' '::character varying clientname
, intakeserreqstatustypekey
, R.Assignedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) assingeduser
, false
, coalesce(r.remarks,'') ::text
, r.eventcode :: character varying
, null ::json
, (
SELECT json_agg(e) as fatality from (
select isrs.ischildfatality, isrs.ismaltreatment
from intakeservicerequestsdm isrs where isrs.intakenumber   = isr.intakenumber and isrs.activeflag =1 ) as e
)::json,
r.eventdesc,
r.objectid,
-- For ADPR, override entityid with the person UUID looked up via adoptionplanning -> actor chain
case
    when r.eventcode in ('ADPR') then
        (select a.personid::character varying from adoptionplanning adp
         join intakeservicerequestactor i on adp.intakeservicerequestactorid = i.intakeservicerequestactorid
         join actor a on a.actorid = i.actorid
         where adp.adoptionplanningid::character varying = r.objectid
           and adp.activeflag = 1
           and a.activeflag = 1
         limit 1)
    else r.entityid
end,
case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then
(select tsl.client_id from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
,case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then  
(select tsl.service_log_id:: integer from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
, (
case when r.eventcode in ('GAAR') then
( select g.permanencyplanid as permanencyplanid from gapagreement ga
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying = r.objectid
and g.activeflag=1 and ga.activeflag=1  limit 1)
when r.eventcode in ('GADR') then  
(select g.permanencyplanid as permanencyplanid from gapdisclosure gd  
inner join guardianship g on g.gapid = gd.gapid  and gd.gapdisclosureid ::character varying =r.objectid
and g.activeflag=1 and gd.activeflag=1   limit 1)
when r.eventcode in ('GAAP') then  
(select g.permanencyplanid as permanencyplanid from gapapplication gp
inner join guardianship g on g.gapid = gp.gapid  and gp.gapapplicationid ::character varying =r.objectid
and g.activeflag=1 and gp.activeflag=1   limit 1)
when r.eventcode in ('GAYR') then
(select g.permanencyplanid as permanencyplanid from gapannualreview ga  
inner join guardianship g on g.gapid = ga.gapid  and ga.gapannualreviewid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1   limit 1)
when r.eventcode in ('GARR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and gr.gapagreementrateid::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
when r.eventcode in ('ADPR') then
( select adp.permanencyplanid as permanencyplanid
FROM adoptionplanning adp where adp.adoptionplanningid ::character varying = r.objectid
and adp.activeflag=1 limit 1)
when r.eventcode in ('ABLR') then
( select ap.permanencyplanid from adoptionbreakthelink abl
join adoptionplanning ap on abl.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and abl.activeflag = 1 and abl.adoptionbreakthelinkid ::character varying = r.objectid limit 1)
when r.eventcode in ('AARR') then
( select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('ASAR') then
(select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid 
union 
select ap.permanencyplanid from adoptionagreementrevision  aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('TPRR') then
( select tpr.permanencyplanid as permanencyplanid
FROM Tprrecommendation tpr where tpr.tprrecommendationid ::character varying = r.objectid
and tpr.activeflag=1 limit 1)
when r.eventcode in ('ADSR') then
( select ap.permanencyplanid from adoptionsuspension ads
join adoptionplanning ap on ads.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and ads.activeflag = 1 and ads.adoptionsuspensionid ::character varying = r.objectid  limit 1)
else null
end )
FROM intakeservicerequest as ISR
-- JOIN
-- (
-- select ISRA.intakeserviceid, (max(ISRA.personid::character varying ))::uuid personid
-- from intakeservicerequestactor as ISRA
-- JOIN actor as AR ON AR.actorid=ISRA.actorid
-- where ISRA.intakeservicerequestpersontypekey in ('RA', 'RC','CLI','CHILD','BIOCHILD','OTHERCHILD')
-- group by ISRA.intakeserviceid
-- )
-- ISRA ON ISRA.intakeserviceid=ISR.intakeserviceid
-- JOIN person as PN ON PN.personid=ISRA.personid
JOIN
(
SELECT    DISTINCT r.servicerequestnumber
, r.insertedon  assignedon
, r.remarks
, r.fromsecurityusersid
, r.eventcode,r.objectid
, r.entityid
, (case when r.eventcode = 'SCDR' and (select reopenreasonkey from servicecasedisposition where servicecasedispositionid::character varying = r.objectid)
is not null then 'Request to Reopen the Service Case' else COALESCE(rf.value_text, 'Code description Not available')  end)  eventdesc
FROM ROUTING R
LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode AND rf.activeflag =1 AND rf.referencetypeid =46
WHERE R.tosecurityusersid = usersid
AND routingstatustypeid in(12, 15, 18,34,39)
AND R.activeflag =1
AND R.eventcode NOT IN ('ASST','APPL') AND length(r.objectid)=36
) R ON (r.servicerequestnumber = ISR.servicerequestnumber::character varying
OR r.objectid::uuid = ISR.intakeserviceid )
--OR (CASE when  length(r.objectid)=36 then  r.objectid::uuid = ISR.intakeserviceid) END )
LEFT JOIN userprofile up on up.securityusersid = r.fromsecurityusersid and up.activeflag  =1
inner JOIN intakeserreqstatustype irst on irst.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid
and irst.activeflag=1 and lower(irst.Intakeserreqstatustypekey) Not in ('closed')
WHERE
ISR.servicerequestnumber LIKE COALESCE(servicereqno, '') ||'%' and ISR.teamtypekey = 'CW'
--and coalesce(ISR.isrouted,false) =true
and ISR.intakeserviceid not in ( select intakeserviceid from IntakeServiceRequestGroupDetails where activeflag =1 )

UNION ALL

SELECT
ISG.groupid
, ISG.GROUPNUMBER
,''
,'' AS servreqtype
,''
, NULL
, ''
,'Approved'
, null
,''
, true
, max(coalesce(r.remarks,'') ) ::text
, r.eventcode :: character varying
, ( select * from getgroupcase( usersid,false,ISG.groupid) ) as casea
, (
SELECT json_agg(e) as fatality
from
(
select isrs.ischildfatality, isrs.ismaltreatment
from intakeservicerequestsdm isrs
where isrs.intakenumber = isr.intakenumber and activeflag    =1
) as e
) ::json,
'',
r.objectid,
case
    when r.eventcode in ('ADPR') then
        (select a.personid::character varying from adoptionplanning adp
         join intakeservicerequestactor i on adp.intakeservicerequestactorid = i.intakeservicerequestactorid
         join actor a on a.actorid = i.actorid
         where adp.adoptionplanningid::character varying = r.objectid
           and adp.activeflag = 1
           and a.activeflag = 1
         limit 1)
    else r.entityid
end,
case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then
(select tsl.client_id from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
,case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then  
(select tsl.service_log_id:: integer from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end

,(
case when r.eventcode in ('GAAR') then
(select g.permanencyplanid as permanencyplanid from gapagreement ga
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying = r.objectid
and g.activeflag=1 and ga.activeflag=1  limit 1 )

when r.eventcode in ('GADR') then  
(select g.permanencyplanid as permanencyplanid from gapdisclosure gd  
inner join guardianship g on g.gapid = gd.gapid  and gd.gapdisclosureid::character varying =r.objectid
and g.activeflag=1 and gd.activeflag=1   limit 1)
when r.eventcode in ('GAAP') then  
(select g.permanencyplanid as permanencyplanid from gapapplication gp
inner join guardianship g on g.gapid = gp.gapid  and gp.gapapplicationid ::character varying =r.objectid
and g.activeflag=1 and gp.activeflag=1   limit 1)
when r.eventcode in ('GAYR') then
(select g.permanencyplanid as permanencyplanid from gapannualreview ga  
inner join guardianship g on g.gapid = ga.gapid  and ga.gapannualreviewid::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1   limit 1)
when r.eventcode in ('GARR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and gr.gapagreementrateid::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
when r.eventcode in ('ADPR') then
( select adp.permanencyplanid as permanencyplanid
FROM adoptionplanning adp where adp.adoptionplanningid ::character varying = r.objectid
and adp.activeflag=1 limit 1)
when r.eventcode in ('ABLR') then
( select ap.permanencyplanid from adoptionbreakthelink abl
join adoptionplanning ap on abl.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and abl.activeflag = 1 and abl.adoptionbreakthelinkid ::character varying = r.objectid limit 1)
when r.eventcode in ( 'AARR') then
( select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('ASAR') then
(select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid 
union 
select ap.permanencyplanid from adoptionagreementrevision  aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('TPRR') then
( select tpr.permanencyplanid as permanencyplanid
FROM Tprrecommendation tpr where tpr.tprrecommendationid ::character varying = r.objectid
and tpr.activeflag=1 limit 1)
when r.eventcode in ('ADSR') then
( select ap.permanencyplanid from adoptionsuspension ads
join adoptionplanning ap on ads.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and ads.activeflag = 1 and ads.adoptionsuspensionid ::character varying = r.objectid  limit 1)
else null
end )
FROM
IntakeServiceRequestGroup ISG
INNER JOIN IntakeServiceRequestGroupDetails ISGD ON ISGD.groupid = ISG.groupid AND ISGD.activeflag =1
INNER JOIN intakeservicerequest as ISR ON ISR.intakeserviceid = ISGD.intakeserviceid and ISR.teamtypekey = 'CW'
JOIN
(
SELECT DISTINCT r.objectid
, r.entityid
, cast(r.insertedon as date) assignedon
, r.remarks
, r.eventcode
FROM ROUTING R
WHERE R.tosecurityusersid = usersid
AND routingstatustypeid in(12, 15, 18,39)
AND R.activeflag =1 AND R.eventcode NOT IN ('ASST','APPL')
) R ON r.objectid = ISR.intakenumber
INNER JOIN intakeserreqstatustype irst on irst.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid
and irst.activeflag = 1 and lower(irst.Intakeserreqstatustypekey) Not in ('closed')
WHERE ISG.GROUPNUMBER LIKE coalesce(servicereqno, '') ||'%' AND coalesce(ISR.isrouted,false) =true
group by
ISG.groupid
, ISG.GROUPNUMBER
, r.eventcode
,r.objectid
, r.entityid
, isr.intakenumber

UNION ALL

SELECT
S.servicecaseid
, S.servicecasenumber
, ''
,    'Service Case'  AS servreqtype
,''
, S.startdate :: timestamp
, cast (caseheadname as character varying) clientname
, statustypekey
, R.Assignedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) assingeduser
, false
, coalesce(r.remarks,'') ::text
, r.eventcode :: character varying
, null ::json
,  null ::json
,r.eventdesc
,r.objectid,
case
    when r.eventcode in ('ADPR') then
        (select a.personid::character varying from adoptionplanning adp
         join intakeservicerequestactor i on adp.intakeservicerequestactorid = i.intakeservicerequestactorid
         join actor a on a.actorid = i.actorid
         where adp.adoptionplanningid::character varying = r.objectid
           and adp.activeflag = 1
           and a.activeflag = 1
         limit 1)
    else r.entityid
end,
case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then
(select tsl.client_id from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
,case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then  
(select tsl.service_log_id:: integer from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
,(
case when r.eventcode in ('GAAR') then
( select g.permanencyplanid as permanencyplanid from gapagreement ga
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying = r.objectid
and g.activeflag=1 and ga.activeflag=1  limit 1 )
when r.eventcode in ('GADR') then  
(select g.permanencyplanid as permanencyplanid from gapdisclosure gd  
inner join guardianship g on g.gapid = gd.gapid  and gd.gapdisclosureid ::character varying =r.objectid
and g.activeflag=1 and gd.activeflag=1   limit 1)
when r.eventcode in ('GAAP') then  
(select g.permanencyplanid as permanencyplanid from gapapplication gp
inner join guardianship g on g.gapid = gp.gapid  and gp.gapapplicationid ::character varying =r.objectid
and g.activeflag=1 and gp.activeflag=1   limit 1)
when r.eventcode in ('GAYR') then
( select g.permanencyplanid as permanencyplanid from gapannualreview ga  
inner join guardianship g on g.gapid = ga.gapid  and ga.gapannualreviewid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1   limit 1)
when r.eventcode in ('GARR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and gr.gapagreementrateid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
when r.eventcode in ('ADPR') then
( select adp.permanencyplanid as permanencyplanid
FROM adoptionplanning adp where adp.adoptionplanningid ::character varying = r.objectid
and adp.activeflag=1 limit 1)
when r.eventcode in ('ABLR') then
( select ap.permanencyplanid from adoptionbreakthelink abl
join adoptionplanning ap on abl.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and abl.activeflag = 1 and abl.adoptionbreakthelinkid ::character varying = r.objectid limit 1)
when r.eventcode in ( 'AARR') then
( select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('ASAR') then
(select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid 
union 
select ap.permanencyplanid from adoptionagreementrevision  aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('TPRR') then
( select tpr.permanencyplanid as permanencyplanid
FROM Tprrecommendation tpr where tpr.tprrecommendationid ::character varying = r.objectid
and tpr.activeflag=1 limit 1)
when r.eventcode in ('ADSR') then
( select ap.permanencyplanid from adoptionsuspension ads
join adoptionplanning ap on ads.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and ads.activeflag = 1 and ads.adoptionsuspensionid ::character varying = r.objectid  limit 1)
else null
end )
FROM servicecase S
INNER JOIN
(
SELECT    DISTINCT r.servicerequestnumber
, r.insertedon  assignedon
, r.remarks
, r.fromsecurityusersid
, r.eventcode
,r.objectid
, r.entityid
, COALESCE(rf.value_text,'Code description Not available')  eventdesc
FROM ROUTING R
LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode AND rf.activeflag =1 AND rf.referencetypeid =46
WHERE R.tosecurityusersid = usersid
AND routingstatustypeid in(15,39)
AND R.activeflag =1
AND R.eventcode NOT IN ('ASST','APPL')
)R ON r.servicerequestnumber = S.servicecasenumber::character varying
LEFT JOIN userprofile up on up.securityusersid = r.fromsecurityusersid  and up.activeflag  =1
WHERE S.servicecasenumber LIKE coalesce(servicereqno, '') ||'%'

UNION ALL
-- To get the fiscal category code 7108 approval records
SELECT
S.servicecaseid
, S.servicecasenumber
, ''
,    'Service Case'  AS servreqtype
,''
, S.startdate :: timestamp
, cast (caseheadname as character varying) clientname
, statustypekey
, R.Assignedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) assingeduser
, false
, coalesce(r.remarks,'') ::text
, r.eventcode :: character varying
, null ::json
,  null ::json
,r.eventdesc
,r.objectid,
case
    when r.eventcode in ('ADPR') then
        (select a.personid::character varying from adoptionplanning adp
         join intakeservicerequestactor i on adp.intakeservicerequestactorid = i.intakeservicerequestactorid
         join actor a on a.actorid = i.actorid
         where adp.adoptionplanningid::character varying = r.objectid
           and adp.activeflag = 1
           and a.activeflag = 1
         limit 1)
    else r.entityid
end,
case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then
(select tsl.client_id from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
,case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then  
(select tsl.service_log_id:: integer from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
,(
case when r.eventcode in ('GAAR') then
( select g.permanencyplanid as permanencyplanid from gapagreement ga
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying = r.objectid
and g.activeflag=1 and ga.activeflag=1  limit 1 )
when r.eventcode in ('GADR') then  
(select g.permanencyplanid as permanencyplanid from gapdisclosure gd  
inner join guardianship g on g.gapid = gd.gapid  and gd.gapdisclosureid ::character varying =r.objectid
and g.activeflag=1 and gd.activeflag=1   limit 1)
when r.eventcode in ('GAAP') then  
(select g.permanencyplanid as permanencyplanid from gapapplication gp
inner join guardianship g on g.gapid = gp.gapid  and gp.gapapplicationid ::character varying =r.objectid
and g.activeflag=1 and gp.activeflag=1   limit 1)
when r.eventcode in ('GAYR') then
( select g.permanencyplanid as permanencyplanid from gapannualreview ga  
inner join guardianship g on g.gapid = ga.gapid  and ga.gapannualreviewid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1   limit 1)
when r.eventcode in ('GARR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and gr.gapagreementrateid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
when r.eventcode in ('ADPR') then
( select adp.permanencyplanid as permanencyplanid
FROM adoptionplanning adp where adp.adoptionplanningid ::character varying = r.objectid
and adp.activeflag=1 limit 1)
when r.eventcode in ('ABLR') then
( select ap.permanencyplanid from adoptionbreakthelink abl
join adoptionplanning ap on abl.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and abl.activeflag = 1 and abl.adoptionbreakthelinkid ::character varying = r.objectid limit 1)
when r.eventcode in ( 'AARR') then
( select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('ASAR') then
(select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid 
union 
select ap.permanencyplanid from adoptionagreementrevision  aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('TPRR') then
( select tpr.permanencyplanid as permanencyplanid
FROM Tprrecommendation tpr where tpr.tprrecommendationid ::character varying = r.objectid
and tpr.activeflag=1 limit 1)
when r.eventcode in ('ADSR') then
( select ap.permanencyplanid from adoptionsuspension ads
join adoptionplanning ap on ads.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and ads.activeflag = 1 and ads.adoptionsuspensionid ::character varying = r.objectid  limit 1)
else null
end )
FROM servicecase S
INNER JOIN
(
SELECT    DISTINCT r.servicerequestnumber
, r.insertedon  assignedon
, r.remarks
, r.fromsecurityusersid
, r.eventcode
,r.objectid
, r.entityid
, COALESCE(rf.value_text,'Code description Not available')  eventdesc
FROM ROUTING R
LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode AND rf.activeflag =1 AND rf.referencetypeid =46
WHERE R.tosecurityusersid is null
AND routingstatustypeid in(39)
AND R.activeflag =1
AND R.eventcode = 'PCAUTHR'
)R ON r.servicerequestnumber = S.servicecasenumber::character varying
JOIN userprofile up on up.securityusersid = r.fromsecurityusersid  and up.activeflag  =1
and ( select count(*) from v_userprofile up
inner join muser m on m.securityusersid= up.securityusersid
inner join userresource ur on m.id = ur.userid
inner join permissiongroup pg on ur.permissiongroupid = pg.permissiongroupid
AND pg.activeflag = 1
      where pg.permissiongroupname = 'SSA Placement Manager Role'
    and  up.securityusersid  = usersid
    ) > 0
WHERE S.servicecasenumber LIKE coalesce(servicereqno, '') ||'%'
-- CIDM-3902

UNION ALL
   -- To get the Delete requests for quick card person
select
qp.caseid
, case when qp.casenumber is not null then qp.casenumber else qp.intakenumber end
, ''
,case when (select i.servicerequestnumber from intakeservicerequest i where i.intakeserviceid = qp.caseid limit 1) is not null then 'Service Request' else 'Service Case' end  AS servreqtype
,''
, qp.updatedon :: timestamp
, cast (qp.firstname as character varying) clientname
, ''
, r.insertedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) assingeduser
, false
, coalesce(r.remarks,'') ::text
, r.eventcode :: character varying
, null ::json
,  null ::json
,'Quick Card Person Delete Review'
,r.objectid,
qp.personid:: character varying,null,null,null
from quickperson qp
inner join routing r on r.objectid::uuid = qp.quickpersonid::uuid
JOIN userprofile up on up.securityusersid = r.fromsecurityusersid  and up.activeflag  =1
--join person p on p.personid = qp.personid and p. activeflag = 1
where r.eventcode = 'QPDR' and r.activeflag = 1 and r.routingstatustypeid = 15 and toroleid = 'CWSP'
and qp.activeflag = 1 and r.tosecurityusersid = usersid
-- QPDR


UNION ALL
-- To get the requests for Inbox for move person
select
case when a.servicecaseid is not null then a.servicecaseid else a.intakeserviceid end,
case when isr.servicerequestnumber is not null then cast(isr.servicerequestnumber || case coalesce(isr.actiontype,'') when '' then '' else ' (' || coalesce(isr.actiontype,'') || ')' end as character varying) else sc.servicecasenumber end,
'',
case when isr.servicerequestnumber is not null then (SELECT itsrt.intakeservreqtypekey FROM intakeservicerequesttype as itsrt
WHERE itsrt.intakeservreqtypeid=isr.intakeservreqtypeid AND itsrt.activeflag=1 limit 1
) else 'Service Case' end AS servreqtype,
case when isr.servicerequestnumber is not null then (
SELECT srst.classkey
FROM servicerequestsubtype as srst
WHERE srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid AND srst.activeflag=1 limit 1
) else '' end,
mph.updatedon :: timestamp,
cast(up.firstname as character varying) clientname,
'',
r.insertedon :: timestamp,
cast(up.lastname ||',    ' ||up.firstname as character varying) assingeduser,
false,
coalesce(r.remarks,'') ::text,
r.eventcode :: character varying,
null ::json,
null ::json,
'Move Person',
r.objectid::character varying,  -- Cast objectid to character varying
a.personid::character varying,
null,
null,
null
from moveperson_history mph
inner join routing r on r.objectid::uuid = mph.objectId::uuid
JOIN actor a on a.actorid::uuid = mph.objectId::uuid and a.activeflag = 1
JOIN userprofile up on up.securityusersid = r.fromsecurityusersid and up.activeflag = 1
left join intakeservicerequest isr on isr.intakeserviceid = a.intakeserviceid and isr.activeflag=1
left join servicecase sc on sc.servicecaseid = a.servicecaseid and sc.activeflag =1
where r.eventcode in ('MPAI', 'MPIA') and r.activeflag = 1 and r.routingstatustypeid = 15 and toroleid = 'CWSP'
and mph.activeflag = 1 and r.tosecurityusersid = usersid and mph.status = 'Review'


UNION ALL

SELECT
apc.adoptioncaseid
, apc.adoptioncasenumber
, ''
,    'Adoption Case'  AS servreqtype
,''
, apc.startdate :: timestamp
, '' AS clientname
, statustypekey
, R.Assignedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) assingeduser
, false
, coalesce(r.remarks,'') ::text
, r.eventcode :: character varying
, null ::json
,  null ::json
, r.eventdesc
, r.objectid
, case
    when r.eventcode in ('ADPR') then
        (select a.personid::character varying from adoptionplanning adp
         join intakeservicerequestactor i on adp.intakeservicerequestactorid = i.intakeservicerequestactorid
         join actor a on a.actorid = i.actorid
         where adp.adoptionplanningid::character varying = r.objectid
           and adp.activeflag = 1
           and a.activeflag = 1
         limit 1)
    else r.entityid
end
, case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then
(select tsl.client_id from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
,case when r.eventcode in  ( 'PCAUTHR', 'PCAUTH' ) then  
(select tsl.service_log_id:: integer from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id  = (case when length(r.objectid)<=7 then r.objectid else null end)::int limit 1) end
, (
case when r.eventcode in ('GAAR') then
( select g.permanencyplanid as permanencyplanid from gapagreement ga
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying = r.objectid
and g.activeflag=1 and ga.activeflag=1  limit 1)
when r.eventcode in ('GADR') then  
(select g.permanencyplanid as permanencyplanid from gapdisclosure gd  
inner join guardianship g on g.gapid = gd.gapid  and gd.gapdisclosureid ::character varying =r.objectid
and g.activeflag=1 and gd.activeflag=1   limit 1)
when r.eventcode in ('GAAP') then  
(select g.permanencyplanid as permanencyplanid from gapapplication gp
inner join guardianship g on g.gapid = gp.gapid  and gp.gapapplicationid ::character varying =r.objectid
and g.activeflag=1 and gp.activeflag=1   limit 1)
when r.eventcode in ('GAYR') then
( select g.permanencyplanid as permanencyplanid from gapannualreview ga  
inner join guardianship g on g.gapid = ga.gapid  and ga.gapannualreviewid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1   limit 1)
when r.eventcode in ('GARR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and gr.gapagreementrateid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
when r.eventcode in ('ADPR') then
( select adp.permanencyplanid as permanencyplanid
FROM adoptionplanning adp where adp.adoptionplanningid ::character varying = r.objectid
and adp.activeflag=1 limit 1)
when r.eventcode in ('ABLR') then
( select ap.permanencyplanid from adoptionbreakthelink abl
join adoptionplanning ap on abl.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and abl.activeflag = 1 and abl.adoptionbreakthelinkid ::character varying = r.objectid limit 1)
when r.eventcode in ('AARR') then
( select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('ASAR') then
(select ap.permanencyplanid from adoptionagreement aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid 
union 
select ap.permanencyplanid from adoptionagreementrevision  aa
join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
when r.eventcode in ('TPRR') then
( select tpr.permanencyplanid as permanencyplanid
FROM Tprrecommendation tpr where tpr.tprrecommendationid ::character varying = r.objectid
and tpr.activeflag=1 limit 1)
when r.eventcode in ('ADSR') then
( select ap.permanencyplanid from adoptionsuspension ads
join adoptionplanning ap on ads.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
and ads.activeflag = 1 and ads.adoptionsuspensionid ::character varying = r.objectid  limit 1)
else null
end )
FROM adoptioncase apc
INNER JOIN
(
SELECT DISTINCT r.servicerequestnumber
, r.insertedon  assignedon
, r.remarks
, r.fromsecurityusersid
, r.eventcode
, r.objectid
, r.entityid
, COALESCE(rf.value_text,'Code description Not available')  eventdesc
FROM ROUTING R
LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode AND rf.activeflag =1 AND rf.referencetypeid =46
WHERE
R.tosecurityusersid = usersid
AND routingstatustypeid in(15,39)
AND R.activeflag = 1
AND R.eventcode NOT IN ('ASST','APPL')
) R ON r.servicerequestnumber = apc.adoptioncasenumber::character varying
LEFT JOIN userprofile up on up.securityusersid = r.fromsecurityusersid  and up.activeflag = 1
WHERE apc.adoptioncasenumber LIKE coalesce(servicereqno, '') ||'%'
 
UNION ALL
--Get all the FORM 1080 review items
--Keeping as a separate stored proc modularized so that this base is clean
-- select * from cjams.getform1080reviews(usersid, servicereqno)
SELECT
  f.caseid,
  f.servicerequestnumber,
  f.intakenumber,
  f.servreqtype,
  f.classkey,
  f.updatedon,
  f.clientname,
  f.intakeserreqstatustypekey,
  f.assignedon,
  f.submitteduser,
  f.isgroup,
  f.comments,
  f.appevent,
  f.dadetails,
  f.sdm,
  f.eventdescription,
  f.objectid,
  f.personid,
  f.client_id,
  f.service_log_id,
  f.permanencyplanid
FROM cjams.getform1080reviews(usersid, servicereqno) f

) as Assignlist
order by assignedon desc LIMIT pagesize OFFSET v_pageoffset;

end;

$function$
;

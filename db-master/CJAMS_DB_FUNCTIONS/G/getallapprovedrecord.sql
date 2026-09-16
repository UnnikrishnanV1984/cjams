-- FUNCTION: cjams.getallapprovedrecord(character varying, bigint, bigint, character varying, timestamp without time zone, timestamp without time zone, character varying)

DROP FUNCTION cjams.getallapprovedrecord(character varying, bigint, bigint, character varying, timestamp without time zone, timestamp without time zone, character varying);

CREATE OR REPLACE FUNCTION cjams.getallapprovedrecord(userid character varying, pagenumber bigint, pagesize bigint, servicereqno character varying, v_datefrom timestamp without time zone, v_dateto timestamp without time zone, v_teamid character varying)
 RETURNS TABLE(totalcount bigint, servicereqid uuid, servicerequestnumber character varying, intakenumber character varying, servreqtype character varying, servreqsubtype character varying, reporteddate timestamp without time zone, raname character varying, servreqstatus character varying, submitteon timestamp without time zone, submitteduser character varying, isgroup boolean, commets text, appevent character varying, dadetails json, sdm json, eventdescription character varying, objectid character varying, entityid character varying, routingstatus text, client_id bigint, service_log_id integer, permanencyplanid uuid, legalguardian json)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- Chandra/Palani - 09/27/2023 - Query tuning (CIDM-8008)
-- Akhil/Vineet - 01/16/2024 Fix for duplicate records with adding event code condition (CIDM- 8008)
-- Manasa/Palani - 04/01/2024: Query optimization and removing the union as there are no records in the tables (CIDM-8310)
------------------------------------------------------------------------------------------------
declare
v_pageoffset int;
v_pagenumber int;
begin
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;
return query
SELECT
count(1) over()
 , *,(select getcasepersonname as legalguardian from getcasepersonname (
CASE
WHEN Assignlist.servreqtype = 'Service Case' THEN 'servicecase'
WHEN Assignlist.servreqtype = 'Adoption Case' THEN 'adoptioncase'
ELSE 'servicerequest'
END,
intakeserviceid::character varying))
from
(
SELECT
ISR.intakeserviceid
 , cast(ISR.servicerequestnumber || case coalesce(isr.actiontype,'') when '' then '' else ' (' || coalesce(isr.actiontype,'') || ')' end as character varying)
 , isr.intakenumber
 , (SELECT
itsrt.intakeservreqtypekey
FROM
intakeservicerequesttype as itsrt
WHERE
itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid
AND itsrt.activeflag     =1 limit 1
) AS servreqtype
 , (
SELECT
srst.classkey
FROM
servicerequestsubtype as srst
WHERE
srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid
AND srst.activeflag         =1 limit 1
)
 , ISR.reporteddate :: timestamp
 , ''::character varying clientname
 , intakeserreqstatustypekey
 , R.Assignedon :: timestamp
 , cast(up.lastname ||',    ' ||up.firstname as character varying) assingeduser
 , false
 , coalesce(r.remarks,'') ::text
 , r.eventcode :: character varying
 , null ::json
 , (
SELECT json_agg(e) as fatality
from
(
select isrs.ischildfatality, isrs.ismaltreatment
from intakeservicerequestsdm isrs
where isrs.intakenumber = isr.intakenumber and isrs.activeflag =1
)
as e
)
::json,
r.eventdesc,
r.objectid,
r.entityid,
r.typedescription,
null::bigint,
null::int,
(
case when r.eventcode in ('GAAR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
    inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1 ) 
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
  when r.eventcode in ('ASAR', 'AARR') then
( select ap.permanencyplanid from adoptionagreement aa
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
JOIN
(
SELECT    DISTINCT r.servicerequestnumber
 , r.insertedon  assignedon
 , r.remarks
 , r.tosecurityusersid
 , r.eventcode,r.objectid
 , r.entityid
, COALESCE(rf.value_text,'Code description Not available')  eventdesc,
 rst.typedescription
FROM
ROUTING R
LEFT JOIN routingstatustype rst ON rst.sequencenumber=R.routingstatustypeid
LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode and rf.referencetypeid = 46
WHERE R.activeflag =1
AND (userid IS NULL OR R.fromsecurityusersid  = userid )  
AND (v_DateFrom IS NULL OR (Date( R.insertedon) between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))
AND (v_teamid IS NULL OR R.teamid=v_teamid::uuid )
AND routingstatustypeid in(13, 16, 19,35,40)
)
R ON r.servicerequestnumber = ISR.servicerequestnumber::character varying
LEFT JOIN userprofile up on up.securityusersid = R.tosecurityusersid and up.activeflag  =1
inner JOIN intakeserreqstatustype irst on irst.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and irst.activeflag =1
and lower(irst.Intakeserreqstatustypekey) Not in ('closed')
WHERE
ISR.teamtypekey = 'CW'
and ISR.servicerequestnumber LIKE servicereqno ||'%'
and coalesce(ISR.isrouted,false) =true
-- and ISR.intakeserviceid not in
-- (
-- select
-- intakeserviceid
-- from
-- IntakeServiceRequestGroupDetails
-- where
-- activeflag =1
-- )
-- union all
-- SElect
-- ISG.groupid
--  , ISG.GROUPNUMBER
--  ,''
--  ,'' AS servreqtype
--  ,''
--  , NULL
--  , ''
--  ,'Approved'
--  , null
--  ,''
--  , true
--  , max(coalesce(r.remarks,'') ) ::text
--  , r.eventcode :: character varying
--  , (
-- select    *
-- from
-- getgroupcase( userid,false,ISG.groupid)
-- )
-- as casea
--  , (
-- SELECT
-- json_agg(e) as fatality
-- from
-- (
-- select
-- isrs.ischildfatality
--  , isrs.ismaltreatment
-- from
-- intakeservicerequestsdm isrs
-- where
-- isrs.intakenumber = isr.intakenumber
-- and activeflag    =1
-- )
-- as e
-- )
-- ::json,
--                 '',
-- r.objectid,
-- r.entityid,
-- r.typedescription,
-- (select tsl.client_id from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id :: character varying = r.objectid limit 1),
-- (select tsl.service_log_id:: integer from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  tspa.authorization_id :: character varying = r.objectid limit 1),
-- (
-- case when r.eventcode in ('GAAR') then
-- ( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
--     inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
-- inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid::character varying =r.objectid
-- and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
 
--  when r.eventcode in ('GADR') then  
-- (select g.permanencyplanid as permanencyplanid from gapdisclosure gd  
-- inner join guardianship g on g.gapid = gd.gapid  and gd.gapdisclosureid::character varying =r.objectid
-- and g.activeflag=1 and gd.activeflag=1   limit 1)
-- when r.eventcode in ('GAAP') then  
-- (select g.permanencyplanid as permanencyplanid from gapapplication gp
-- inner join guardianship g on g.gapid = gp.gapid  and gp.gapapplicationid ::character varying =r.objectid
-- and g.activeflag=1 and gp.activeflag=1   limit 1)
--  when r.eventcode in ('GAYR') then
-- (select g.permanencyplanid as permanencyplanid from gapannualreview ga  
-- inner join guardianship g on g.gapid = ga.gapid  and ga.gapannualreviewid::character varying =r.objectid
-- and g.activeflag=1 and ga.activeflag=1   limit 1)
--  when r.eventcode in ('GARR') then
-- ( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
--     inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
-- inner join guardianship g on g.gapid = ga.gapid  and gr.gapagreementrateid::character varying =r.objectid
-- and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
--   when r.eventcode in ('ADPR') then
-- ( select adp.permanencyplanid as permanencyplanid
-- FROM adoptionplanning adp where adp.adoptionplanningid ::character varying = r.objectid
-- and adp.activeflag=1 limit 1)
--   when r.eventcode in ('ABLR') then
-- ( select ap.permanencyplanid from adoptionbreakthelink abl
-- join adoptionplanning ap on abl.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
-- and abl.activeflag = 1 and abl.adoptionbreakthelinkid ::character varying = r.objectid limit 1)
--   when r.eventcode in ('ASAR', 'AARR') then
-- ( select ap.permanencyplanid from adoptionagreement aa
-- join adoptionplanning ap on aa.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
-- and aa.activeflag = 1 and aa.adoptionagreementid  ::character varying = r.objectid limit 1)
--   when r.eventcode in ('TPRR') then
-- ( select tpr.permanencyplanid as permanencyplanid
-- FROM Tprrecommendation tpr where tpr.tprrecommendationid ::character varying = r.objectid
-- and tpr.activeflag=1 limit 1)
--   when r.eventcode in ('ADSR') then
-- ( select ap.permanencyplanid from adoptionsuspension ads
-- join adoptionplanning ap on ads.adoptionplanningid = ap.adoptionplanningid and ap.activeflag =1
-- and ads.activeflag = 1 and ads.adoptionsuspensionid ::character varying = r.objectid  limit 1)
--    else null
-- end )
-- from
-- IntakeServiceRequestGroup ISG
-- INNER JOIN
-- IntakeServiceRequestGroupDetails ISGD
-- ON
-- ISGD.groupid        = ISG.groupid
-- AND ISGD.activeflag =1
-- INNER JOIN
-- intakeservicerequest as ISR
-- ON
-- ISR.intakeserviceid = ISGD.intakeserviceid
-- JOIN
-- (
-- SELECT    DISTINCT
--                           r.objectid
--  , r.entityid
--  , cast(r.insertedon as date) assignedon
--  , r.remarks
--  , r.eventcode
--  , rst.typedescription
-- FROM
-- ROUTING R
-- LEFT JOIN routingstatustype rst ON rst.sequencenumber=R.routingstatustypeid
-- WHERE R.activeflag =1
-- AND (userid IS NULL OR R.fromsecurityusersid  = userid )  
-- AND (v_DateFrom IS NULL OR (Date( R.insertedon) between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))
-- AND (v_teamid IS NULL OR R.teamid::character varying=v_teamid::character varying )  
-- AND routingstatustypeid in(13, 16, 19,40)
-- AND R.eventcode NOT IN ('ASST')
-- )
-- R
-- ON
-- r.objectid = ISR.intakenumber
-- inner JOIN
-- intakeserreqstatustype irst
-- on
-- irst.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid
-- and irst.activeflag =1
-- and lower(irst.Intakeserreqstatustypekey) Not in ('closed')
-- WHERE
-- ISR.teamtypekey = 'CW'
-- AND ISG.GROUPNUMBER LIKE servicereqno
-- ||'%'
-- AND coalesce(ISR.isrouted,false) =true
-- group by
-- ISG.groupid
--  , ISG.GROUPNUMBER
--  , r.eventcode
--  ,r.objectid
--  , r.entityid
--  , isr.intakenumber
--  , r.typedescription
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
 , cast(up.lastname
||',    '
||up.firstname as character varying) assingeduser
 , false
 , coalesce(r.remarks,'') ::text
 , r.eventcode :: character varying
 , null ::json
 ,  null ::json
 ,r.eventdesc
 ,r.objectid,
 r.entityid,
 r.typedescription,
 null,
 null,
(
case when r.eventcode in ('GAAR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
    inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
 
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
  when r.eventcode in ('ASAR', 'AARR') then
( select ap.permanencyplanid from adoptionagreement aa
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
 , r.tosecurityusersid
 , r.eventcode
 ,r.objectid
 , r.entityid
 , COALESCE(rf.value_text,'Code description Not available')  eventdesc
 , rst.typedescription
FROM
ROUTING R
LEFT JOIN routingstatustype rst ON rst.sequencenumber=R.routingstatustypeid
LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode and rf.referencetypeid = 46
WHERE R.activeflag =1 and 
(userid IS NULL OR R.fromsecurityusersid  = userid )  
AND (v_DateFrom IS NULL OR (Date( R.insertedon) between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))
AND (v_teamid IS NULL OR R.teamid=v_teamid::uuid )
AND R.routingstatustypeid in(13, 16, 19,35,40)
and (case when r.eventcode <> 'PLTR' then true else r.toroleid <> 'IVESV' end)
)R ON r.servicerequestnumber = S.servicecasenumber::character varying
LEFT JOIN userprofile up on up.securityusersid = R.tosecurityusersid  and up.activeflag  =1
WHERE S.servicecasenumber LIKE servicereqno ||'%'
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
 ,r.eventdesc
 ,r.objectid,
 r.entityid,
 r.typedescription,
(select tsl.client_id from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  to_char_int(tspa.authorization_id) = r.objectid limit 1),
(select tsl.service_log_id:: integer from tb_service_log tsl join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id where  to_char_int(tspa.authorization_id) = r.objectid limit 1),
(
case when r.eventcode in ('GAAR') then
( select g.permanencyplanid as permanencyplanid from gapagreementrate gr
    inner join gapagreement ga on gr.gapagreementid=ga.gapagreementid
inner join guardianship g on g.gapid = ga.gapid  and ga.gapagreementid ::character varying =r.objectid
and g.activeflag=1 and ga.activeflag=1 and gr.activeflag=1 limit 1)
 
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
  when r.eventcode in ('ASAR', 'AARR') then
( select ap.permanencyplanid from adoptionagreement aa
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
SELECT    DISTINCT r.servicerequestnumber
 , r.insertedon  assignedon
 , r.remarks
 , r.tosecurityusersid
 , r.eventcode
 ,r.objectid
 ,r.entityid
 , COALESCE(rf.value_text,'Code description Not available')  eventdesc
 ,  rst.typedescription
FROM ROUTING R
LEFT JOIN routingstatustype rst ON rst.sequencenumber=R.routingstatustypeid
LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode and rf.referencetypeid = 46
WHERE R.activeflag =1 and 
(userid IS NULL OR R.fromsecurityusersid  = userid )  
AND (v_DateFrom IS NULL OR (Date( R.insertedon) between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))
AND (v_teamid IS NULL OR R.teamid=v_teamid::uuid )              
AND routingstatustypeid in (16)
)R ON r.servicerequestnumber = apc.adoptioncasenumber::character varying
LEFT JOIN userprofile up on up.securityusersid = R.tosecurityusersid  and up.activeflag  =1
WHERE apc.adoptioncasenumber LIKE servicereqno ||'%'
)
as Assignlist
order by
assignedon desc LIMIT pagesize OFFSET v_pageoffset;

end;

$function$
;
-- FUNCTION: cjams.getplacementbyservicecase(uuid, integer, integer)

DROP FUNCTION cjams.getplacementbyservicecase(uuid, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getplacementbyservicecase(v_servicecaseid uuid, pagenumber integer, pagesize integer)
 RETURNS TABLE(personid uuid, cjamspid bigint, firstname character varying, lastname character varying, middlename character varying, userphoto text, suffix character varying, prefx character varying, dob timestamp without time zone, gender character varying, gendertypekey character varying, removaldate date, age text, clientname text, placements json, tprdetails json, tprstatus json, finalizationdate timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 09/08/2022 Vineet Tirodkar - To change the Person Gender value logic (CDM-24857)
-- 12/30/2022 Umasankar Raavi -- Address fix -Aurora (CDM-27727)
-- 01/24/2023 Prashanth Sampathirao- Added transferagency and otherpublicagency (CDM-6419)
-- 04/25/2023 Smitha Somasekharanv- Added placement/living arrangement placeholder options (CIDM-6996)
-- 07/25/2023 Palani/Chandra- Query optimization (CIDM-7564)
--10/24/2023 Umasankar Raavi -- CPA HOME DEFAULT ADDRESS (CDM-34971)
-- 07/18/2024 Smitha Somasekharan - Modifications for luggage indicator n placement userstory -(CIDM-9031-B-195080)
-- 10/28/2024 Amiya Pradhan - CIDM-9537 - B-206527 - Audit Trail for SAFE-C OOH Assessments in CJAMS
-- CIDM-9160 - Living Arrangement user story
--01/06/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10008-b-210234)
--2/26/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10220-b-214910)
-- 04/28/2025 - CIDM-10434 Living Arrangement 
--01/16/2026--Umasankar Raavi --CIDM-10989--Adding activeflag check to remove duplicate and inactive tpr dates
------------------------------------------------------------------------------------------------------------

DECLARE
totalcount integer;
v_pagenumber integer;
v_pageoffset integer;

BEGIN
    v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
 
RETURN query

SELECT
P.personid,P.cjamspid,P.firstname,P.lastname,P.middlename,P.userphoto,P.suffix,P.prefx,P.dob,
-- G.typedescription AS gender,
(select value_text
from referencevalues
where referencetypeid = 301
and activeflag = 1
and coalesce(teamtypekey, 'CW') = 'CW'
and ref_key =P.gendertypekey
Limit 1
) AS gender ,
P.gendertypekey, isrcr.removaldate::date,
CASE
WHEN EXTRACT(YEAR FROM age(now(), P.dob)) <= 0 THEN
CASE WHEN EXTRACT(MONTH FROM age(now(), P.dob)) <= 0 THEN
CONCAT (EXTRACT(DAY FROM age(now(), P.dob)) :: CHARACTER VARYING, ' ', 'Day(s)')
ELSE CONCAT (EXTRACT(MONTH FROM age(now(), P.dob)) :: CHARACTER VARYING, ' ', 'Month(s)')
END
ELSE CONCAT (EXTRACT(YEAR FROM age(now(), P.dob)) :: CHARACTER VARYING,' ', 'Yrs')
END AS age,
INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname)) AS clientname,
(
SELECT json_agg(e) FROM
(
SELECT PL.ischildplacedoutside,PL.servicecaseid,
(CASE
WHEN PL.servicecaseid IS NOT NULL THEN (SELECT servicecasenumber FROM cjams.servicecase WHERE servicecaseid = PL.servicecaseid)
ELSE NULL END) as servicecasenumber,
PL.intakeservreqchildremovalid,
CASE WHEN PL.intakeservicerequestactorid IS NULL
THEN  (SELECT a.intakeservicerequestactorid FROM intakeservicerequestactor a
WHERE a.personid = PL.personid
AND a.activeflag = 1 AND (a.servicecaseid = v_servicecaseid::uuid OR a.objectid::character varying = v_servicecaseid::character varying
)
ORDER BY coalesce(a.updatedon, a.insertedon) DESC
LIMIT 1)
ELSE PL.intakeservicerequestactorid
END,
PL.providerid,
PL.contractprogramid,
(select btrim(program_nm) || ' (#' || program_id::character varying || ')'
from tb_contract_program
where program_id = PL.contractprogramid
and delete_sw = 'N')
as programname,
PL.remarks,
PL.leastrestrictiveplacement,
CASE
 WHEN (PL.approvalstatustypekey = '3045') THEN 'Pending'
 WHEN (PL.approvalstatustypekey = '3046') THEN 'Un-Requested'
 WHEN (PL.approvalstatustypekey = '3047') THEN 'Approved'
END AS approvalstatustypekey,
PL.old_id,
PL.service_id,
PL.ratestructureid,
PL.startdatetime as startdate,
case when length(PL.starttime) between 5 and 9 then  date(PL.startdatetime) || ' ' || PL.starttime else PL.starttime end as starttime,
PL.enddatetime as enddate,
PL.justification,
case when length(PL.endtime) between 5 and 9 then  date(PL.enddatetime) || ' ' || PL.endtime else PL.endtime end as endtime,
PL.placementtypekey,
PL.providersentdate,
PL.providerdesc,
PL.responseacceptedkey,
PL.rejectreasonkey,
PL.isssaapproval,
PL.ifcapprovaldate,
PL.placementid,
LA.livingarrangementtypekey,
LA.runawayreported,
LA.runawayreportnumber,
rv.value_text livingarrangementtype,
rvfc.value_text  fostercaretext,
rvfcn.value_text fostercarenonfostertext,
PL.personid,
LA.primarycaregiver,
LA.caregiverclientid,
LA.secondarycaregiver,
LA.partnerid,
LA.primaryrelationship,
LA.objectid,
LA.livingstartdate,
LA.livingenddate,
LA.homephone AS contactphone,
LA.workphone AS workphone,
                LA.streetname AS address1 ,
                LA.streettext AS address2,
LA.cityname,
LA.countytypekey,
LA.statetypekey,
LA.country,
LA.whereabouts,
LA.tribalservicearea,
LA.zip5no as zipcode,
LA.fostercarehome,
LA.fostercarenonfoster,
LA.hotelorother,
LA.agency1to1,
LA.agency1to1desc,
LA.agency1to1explaination,
LA.dailyrate,
LA.ratetype,
rvfcc.value_text ratetypetext,
LA.agency1to1rate,
LA.fostercomments,
PL.isvoided,
PL.exittypekey,
PL.voiddate,
PL.alternateid,
PL.ischangepreadoptive,
PL.transferagency,
PL.otherpublicagency ,
PL.primaryrelationship,
LA.livingarrangementluggage,
LA.LAluggagepurchased,
LA.ladisposableortrashbag,
LA.LAluggagecomments,
PL.placementluggage,
PL.plluggagepurchased,
PL.plluggagecomments,
PL.placementdisposableortrashbag,
PL.exitluggage , 
PL.exitluggageprovided, 
PL.exitluggagecomments , 
PL.exitdisposableortrashbag,

(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.transferagency and r.referencetypeid = 350 LIMIT 1) transferagencydescription,
   (select json_agg(x) from (SELECT plr.status, plr.justification, placementrevisionid,plr.placementid, plr.transactiondate, plr.entrydate,
   case when length(plr.entrytime) between 5 and 9 then  date(plr.entrydate) || ' ' || plr.entrytime else plr.entrytime end as entrytime,
plr.exitdate,
case when length(plr.exittime) between 5 and 9 then  date(plr.exitdate) || ' ' || plr.exittime else plr.exittime end as  exittime,
plr.exittypetypkey, plr.exitreasontypkey, plr.exitexplanation,
plr.approvalstatustypkey, plr.approvaldate, plr.insertedon ,
(SELECT row_to_json(y) FROM
(select * from gethospitalizationlistbyid(plr.objectid::uuid) ) as y 
)as hospitalizationdetails,
plr.activeflag, plr.alternateid,plr.voidreasontypekey, plr.voidremarks, plr.enddate, plr.endtime,plr.exittypekey,
plr.remarks, plr.leastrestrictiveplacement, plr.isvoided ,up.fullname
,p.alternateid as placement_id,tp.provider_id,plr.placementluggage,plr.PLluggagepurchased,plr.PLluggagecomments,plr.placementdisposableortrashbag, plr.exitluggage , plr.exitluggageprovided, plr.exitluggagecomments , plr.exitdisposableortrashbag,
CASE COALESCE(tp.provider_nm,'') WHEN '' THEN COALESCE(tp.provider_first_nm ,'') ||' '|| COALESCE(tp.provider_last_nm,'')
ELSE tp.provider_nm  
END providername
,up1.fullname as requestedby , up2.fullname as approvedby , plr.requesteddate ,plr.approveddate, plr.ischangepreadoptive, plr.transferagency, plr.otherpublicagency , plr.primaryrelationship
FROM placementrevision plr
join placement p on p.placementid = plr.placementid
left join tb_provider tp on  tp.provider_id = PL.altproviderid AND tp.delete_sw = 'N'
left join userprofile up1 on plr.requestedby = up1.securityusersid
left join userprofile up2 on plr.approvedby  = up2.securityusersid
left join userprofile up on up.securityusersid = plr.insertedby
where plr.placementid = PL.placementid and Plr.approvalstatustypkey = '3045' and coalesce(Plr.isoriginal,'N') <> 'Y' order by plr.insertedon desc) as x) as placementrevision,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.exitreasontypekey LIMIT 1) exitreasontypedescription,
PL.exitreasontypekey,
               (SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.exittypekey LIMIT 1) exittypedescription,
PL.voidreasontypekey,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.voidreasontypekey LIMIT 1) voidreasontypedescription,
PL.voidremarks,
(SELECT countyname FROM county c WHERE c.activeflag =1 AND c.countyid::character varying = LA.countytypekey)
county ,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.rejectreasonkey LIMIT 1) rejectreason,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.responseacceptedkey LIMIT 1) responseaccepted,
(SELECT service_nm FROM tb_Services WHERE tb_Services.service_id = PL.service_id AND tb_Services.delete_sw ='N' LIMIT 1) placementstructuredesc,
(SELECT service_nm FROM tb_Services WHERE tb_Services.service_id = PL.ratestructureid AND tb_Services.delete_sw ='N' LIMIT 1) comarratedesc,
(SELECT statename FROM state s WHERE s.activeflag =1 AND s.stateabbr::character varying = LA.statetypekey)
statename ,
(
SELECT row_to_json(x) FROM
(
SELECT
p.provider_id ,p.adr_work_phone_tx AS phonenumber, p.adr_work_xtn_tx AS ext, p.adr_fax_tx AS fax, TBPA1.adr_street_no, 
TBPA1.adr_street_tx,TBPA1.adr_street_nm,TBPA1.adr_city_nm,TBPA1.adr_state_cd,
TBPA1.adr_street_suffix_cd, TBPA1.adr_box_no,
TBPA1.adr_zip5_no,
(select f_prvpcklst_cat(p.provider_id::bigint,'PLACEMENT')) as provider_category_cd,
CASE COALESCE(provider_nm,'') WHEN '' THEN COALESCE(provider_first_nm ,'') ||' '|| COALESCE(provider_last_nm,'')
ELSE provider_nm  
END providername,
                                     (CAST(INITCAP(TRIM(coalesce(TBPA1.adr_street_tx,''))||
                                     ' '||TRIM(coalesce(TBPA1.adr_street_nm,''))||
                                     ' '||TRIM(coalesce(TBPA1.adr_street_suffix_cd,''))||
                                     ' '||TRIM(coalesce(TBPA1.adr_unit_type_cd,''))||
                                     ' '||TRIM(coalesce(TBPA1.adr_unit_no_tx,''))||
                                     ' '||TRIM(coalesce(TBPA1.adr_city_nm,'')) ||
                                     ' '||TRIM(coalesce(TBPA1.adr_state_cd,'')) ||
                                     ' '||TRIM((coalesce(TBPA1.adr_zip5_no,0::numeric))::character varying)) AS character varying)) AS address
FROM tb_provider as p
INNER JOIN tb_provider_addresses TBPA1  ON TBPA1.parent_key_id = p.provider_id ::varchar
AND TBPA1.delete_sw = 'N'
WHERE p.provider_id = PL.altproviderid AND p.delete_sw = 'N'
--AND TBPA1.adr_end_dt IS NULL
AND TBPA1.adr_default_sw='Y'
AND TBPA1.adr_type_cd='3357'
LIMIT 1
) as x
) providerdetails,
 
/*
(SELECT rs.typedescription FROM routing r
INNER JOIN routingstatustype  rs ON r.routingstatustypeid = rs.sequencenumber
INNER JOIN teammemberroletype tmr on tmr.roletypekey = r.fromroleid  and tmr.activeflag =1
INNER JOIN teammemberroletype tmrt on tmrt.roletypekey = r.toroleid  and tmrt.activeflag =1
and tmrt.teamtypekey=tmr.teamtypekey
WHERE r.eventcode = 'PLTR' AND r.objectid  =  PL.placementid :: character varying
   AND r.routingstatustypeid not in (69, 70)
AND r.activeflag =1 order by r.insertedon desc limit 1) routingstatus,

*/
/* oct 25 case when (select prv.exitdate from placementrevision prv

where prv.placementid=pl.placementid and prv.approvalstatustypkey='3281' and prv.activeflag=1 ) is not null
then 'Approved' else
(SELECT rs.typedescription FROM routing r
INNER JOIN routingstatustype  rs ON r.routingstatustypeid = rs.sequencenumber
INNER JOIN teammemberroletype tmr on tmr.roletypekey = r.fromroleid  and tmr.activeflag =1
INNER JOIN teammemberroletype tmrt on tmrt.roletypekey = r.toroleid  and tmrt.activeflag =1
and tmrt.teamtypekey=tmr.teamtypekey
WHERE r.eventcode = 'PLTR' AND r.objectid  =  PL.placementid :: character varying
   AND r.routingstatustypeid not in (69, 70)
AND r.activeflag =1 order by r.insertedon desc limit 1) end as  routingstatus,  */

case when (select prv.placementid from placementrevision prv
where prv.placementid=pl.placementid and prv.approvalstatustypkey='3281'
and (prv.voiddate is not null or prv.exitdate is not null ) and prv.activeflag=1 order by prv.insertedon desc limit 1) is not null
then 'Approved' else  
(SELECT rs.typedescription FROM routing r
INNER JOIN routingstatustype  rs ON r.routingstatustypeid = rs.sequencenumber
INNER JOIN teammemberroletype tmr on tmr.roletypekey = r.fromroleid  and tmr.activeflag =1
INNER JOIN teammemberroletype tmrt on tmrt.roletypekey = r.toroleid  and tmrt.activeflag =1
-- and tmrt.teamtypekey=tmr.teamtypekey
WHERE r.eventcode = 'PLTR' AND r.objectid  =  PL.placementid :: character varying
   AND r.routingstatustypeid not in (69, 70)
AND r.activeflag =1 order by r.insertedon desc limit 1) end as  routingstatus,

(select row_to_json(revisionupdate) FROM  (select
--pr.exitdate as enddate,
case when (select prv.placementid from placementrevision prv

where prv.placementid=pr.placementid and prv.approvalstatustypkey='3281' and prv.activeflag=1  ) is not null
then null::timestamp else pr.exitdate end as enddate,

case when length(pr.exittime) between 5 and 9 then  date(pr.exitdate) || ' ' || pr.exittime else pr.exittime end as endtime,
pr.exitreasontypkey,rv.value_text as exitreasontypedescription,
rvs.value_text as exittypekeydescription,pr.remarks,pr.leastrestrictiveplacement,pr.exittypekey,pr.entrydate,
case when length(pr.entrytime) between 5 and 9 then  date(pr.entrydate) || ' ' || pr.entrytime else pr.entrytime end as entrytime,
pr.exittypetypkey,pr.exitexplanation, pr.approvalstatustypkey,pr.approvaldate,
pr.voidreasontypekey,pr.voidremarks,pr.isvoided,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = pr.voidreasontypekey LIMIT 1) voidreasontypedescription,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = pr.voidreasontypekey LIMIT 1) voidreasontypedescription,
ischangepreadoptive, pr.transferagency, pr.otherpublicagency,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = pr.transferagency and r.referencetypeid = 350 LIMIT 1) transferagencydesc , primaryrelationship,
(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = pr.exitreasontypkey and r.referencetypeid = 343 LIMIT 1) exitreasontypkeydesc
from placementrevision pr
left join referencevalues rv on rv.ref_key = pr.exitreasontypkey and (rv.referencetypeid=84 or rv.referencetypeid=85 or rv.referencetypeid=87)
left join referencevalues rvs on rvs.ref_key = pr.exittypekey and rvs.referencetypeid=83
where pr.placementid=pl.placementid and pr.activeflag=1 and  Pr.approvalstatustypkey = '3045' limit 1) as revisionupdate) revisionupdate
, (select rr.remarks
from routing rr
inner join teammemberroletype tmr
on         tmr.roletypekey = rr.fromroleid
and        tmr.activeflag =1
inner join teammemberroletype tmrt
on         tmrt.roletypekey = rr.toroleid
and        tmrt.activeflag =1
and        tmrt.teamtypekey=tmr.teamtypekey
where rr.objectid = PL.placementid :: character varying
and rr.activeflag =1
and rr.routingstatustypeid in (17,16)
order by rr.insertedon desc limit 1) as reason

, (select coalesce (jsonb_agg(cpahome), '[]')::json FROM
                            (select
                                ph.placementcpahomeid as placement_cpa_home_id,
                                ph.placementid as placement_uuid,
                                ph.altplacementid as placement_id,
                                ph.altproviderid as provider_id ,
                                ph.entrydt as entry_dt,
                                ph.entrytm as entry_tm,
                                ph.exitdt as exit_dt,
                                ph.exitreasoncd as exit_reason_cd,
                                ph.exittm as exit_tm,
                                ph.exittypecd exit_type_cd,
                                (
                                    select concat_ws('', PA.adr_street_no, ' ', PA.adr_street_tx, ' ', PA.adr_street_nm, ' ', PA.adr_city_nm, ' ', PA.adr_state_cd, ' ', PA.adr_zip5_no ) AS provideraddres
                                    from tb_provider_addresses PA
                                    where PA.parent_key_id = ph.altproviderid::varchar AND PA.adr_type_cd = '3357'
                                    -- AND PA.adr_end_dt IS NULL 
                                    AND adr_default_sw = 'Y'  order by PA.address_id desc  limit 1 
                                ) as provideraddress,
                                    (case when provider_nm is not null  and btrim(provider_nm) <> ''  then provider_nm                              
                                else
                                    concat(coalesce(prov.provider_prefix_cd, ''), ' ', coalesce(prov.provider_first_nm, ''), ' ', coalesce(prov.provider_middle_nm, ''), ' ', coalesce(prov.provider_last_nm, '') , ' ', coalesce(prov.provider_suffix_cd, ''))
                                end) as providername
                              from  placementcpahomes ph
                              inner join tb_provider prov on prov.provider_id = ph.altproviderid
                              where ph.activeflag = 1 and ph.placementid = PL.placementid
                            ) as cpahome) as cpahomerevision
FROM placement PL   /* Placement list is retrieved based on person */
LEFT JOIN livingarrangement LA ON PL.personid = LA.personid and LA.activeflag=1 and PL.placementid = LA.placementid
LEFT JOIN referencevalues rv ON rv.ref_key = LA.livingarrangementtypekey AND rv.referencetypeid=76
LEFT JOIN referencevalues rvfc on rvfc.ref_key = LA.fostercarehome AND rvfc.referencetypeid = 762
LEFT JOIN referencevalues rvfcn on rvfcn.ref_key = LA.fostercarenonfoster AND rvfcn.referencetypeid = 760
LEFT JOIN referencevalues rvfcc on rvfcc.ref_key = LA.ratetype AND rvfcc.referencetypeid = 942
WHERE PL.personid = P.personid  AND PL.activeflag = 1 order by PL.startdatetime desc
)  e
) :: json AS  placements,
  (
select json_agg( tpr.tprdecisiondate)  from tprdetails tpr  
inner join adoptionplanning ap on
--CASE WHEN ap.intakeserviceid IS NOT NULL THEN tpr.intakeserviceid = ap.intakeserviceid ELSE TRUE END  
--AND
CASE WHEN ap.servicecaseid IS NOT NULL THEN tpr.servicecaseid = ap.servicecaseid
and tpr.servicecaseid=v_servicecaseid ELSE TRUE END  
INNER JOIN tprrecommendation tprr ON tprr.tprrecommendationid = tpr.tprrecommendationid
-- and tprr.intakeservicerequestactorid in
and exists
(select 1 from intakeservicerequestactor i
where i.personid = P.personid and tprr.intakeservicerequestactorid=i.intakeservicerequestactorid)
where coalesce(tpr.activeflag, 1) = 1
) as  tprdates ,
  NULL::json as tprdetails,
(select (ag.finalizationdate at time zone 'utc' at time zone 'est') from adoptionplanning ap
inner join adoptionagreement ag on ag.adoptionplanningid=ap.adoptionplanningid and ag.activeflag=1 and ap.activeflag=1
where ap.servicecaseid=v_servicecaseid LIMIT 1
)
FROM   placement pl
LEFT JOIN intakeservreqchildremoval isrcr on pl.personid = isrcr.personid and isrcr.activeflag = 1
INNER JOIN person P ON P.personid=pl.personid AND P.activeflag=1
-- INNER JOIN gendertype G ON G.gendertypekey=P.gendertypekey AND G.activeflag=1
--LEFT JOIN placementrevision pr on pr.placementid=pl.placementid
WHERE pl.activeflag=1 and --p.personid in (select distinct a.personid from intakeservicerequestactor a
exists (select 1 from intakeservicerequestactor a
where a.personid=p.personid and a.activeflag = 1 and a.intakeservicerequestpersontypekey in ('AV','CHILD','BIOCHILD','OTHERCHILD')  
and a.servicecaseid=v_servicecaseid )
GROUP BY P.personid,clientname,P.firstname,P.lastname,P.middlename,P.userphoto,P.suffix,P.dob, -- G.typedescription,
age,P.gendertypekey, isrcr.removaldate;

END;

$function$
;
CREATE OR REPLACE FUNCTION cjams.getpersoncompletedetail(v_personid uuid, v_servicecaseid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
 
--------------------------------------------------------------------------------
-- 07/13/2023 - Palaniraj / Chandra Ramasamy - Performance tuning - CIDM-7493 
--------------------------------------------------------------------------------

DECLARE    
     
v_result json;
   
BEGIN  
   SELECT json_agg(pms) into v_result FROM    
(
SELECT
(select json_agg(x) from (
SELECT DISTINCT ON (P.personid) count(1) over() AS personcount,
       IAR.intakeserviceid,  P.personid, concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
p.prefx,p.firstname,p.lastname,p.middlename,p.suffix,G.typedescription,p.senstatusflag,p.dob,
CASE WHEN EXTRACT(YEAR FROM age(coalesce(p.dateofdeath, now()), p.dob)) <= 0 THEN
CASE WHEN EXTRACT(MONTH FROM age(coalesce(p.dateofdeath, now()), p.dob)) <= 0 THEN
CONCAT (EXTRACT(DAY FROM age(coalesce(p.dateofdeath, now()), p.dob)) :: CHARACTER varying, ' ', 'Day(s)')
ELSE CONCAT (EXTRACT(MONTH FROM age(coalesce(p.dateofdeath, now()), p.dob)) :: CHARACTER varying, ' ', 'Month(s)')
END
ELSE CONCAT (EXTRACT(YEAR FROM age(coalesce(p.dateofdeath, now()), p.dob)) :: CHARACTER varying,' ', 'Yrs') END AS age,
    EXTRACT(YEAR FROM age(now(), p.dob)) age1,
p.dateofdeath,
(select pa.address  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) address,
(select pa.danger  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) dangeraddress,
(select pa.address2  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) address2,
(select pa.state  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) state,
(select pa.city  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) city,
(select pa.zipcode  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) zipcode,
       (select c.countyname from county c where c.activeflag=1 and c.countyid::character varying  in (select pa.county from personaddress AS pa  
        where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
      order by pa.updatedon desc limit 1)) county,
      ( select max(personemail.email) from personemail where personemail.personid = P.personid and personemail.activeflag = 1 ) email,
      ( select json_agg(contactinfo) from (
select personid, personphonetypekey , phonenumber, ismobile  from personphonenumber  where personid = p.personid and enddate is null) as contactinfo
      )::json as phoneinfo,
(select json_agg(v) as dangerous from (
SELECT prole.dangertoself,prole.isdangertoworker,prole.updatedon
from personrole as prole WHERE activeflag=1
AND  prole.personid = p.personid
order by prole.updatedon desc limit 1
) as v ) ::json,
AC.actorid,
   IAR.Intakeservicerequestactorid AS intakeservicerequestactorid,
( select json_agg(e) as roles from (
select isrpn.intakeservicerequestpersontypekey, at.value_text as typedescription, isrpn.intakeservicerequestactorid
from intakeservicerequestactor ISRPN
inner join referencevalues at on at.ref_key = isrpn.intakeservicerequestpersontypekey
where isrpn.actorid = ac.actorid and (isrpn.servicecaseid = v_servicecaseid ::uuid    )
and isrpn.activeflag = 1 and at.referencetypeid in (175,176) and isrpn.intakeservicerequestpersontypekey not in ('AM')
group by isrpn.intakeservicerequestpersontypekey, at.value_text, isrpn.intakeservicerequestactorid ) as e
) ::json,
CASE
WHEN IAR.intakeservicerequestpersontypekey IN ('RC','CHILD','BIOCHILD')
THEN
(SELECT AT.typedescription FROM Actortype AT WHERE AT.Actortype = IAR.intakeservicerequestpersontypekey AND AT.activeflag=1 LIMIT 1)
ELSE
( SELECT   rt.description
FROM relationshiptype rt
INNER JOIN actorrelationship ar ON rt.relationshiptypekey= ar.relationshiptypekey AND ar.activeflag=1 AND rt.activeflag =1
INNER JOIN intakeservicerequestactor IR on AR.intakeservicerequestactorid = ir.intakeservicerequestactorid AND IR.servicecaseid = SC.servicecaseid  AND IR.activeflag = 1
INNER JOIN Actor a on a.actorid = IR.actorid
WHERE ir.actorid = AC.actorid
GROUP BY rt.description LIMIT 1
)
END AS relationship,
       AC.ishouseholdmember AS ishousehold,  
       AC.iscollateralcontact AS iscollateralcontact,
p.ssnno AS ssnno,
p.cjamspid,
( SELECT icr.removaldate
FROM intakeservreqchildremoval icr  
INNER JOIN intakeservicerequestactor ir ON ir.intakeservicerequestactorid = icr.intakeservicerequestactorid
WHERE icr.servicecaseid = v_servicecaseid ::uuid and ir.personid = p.personid AND icr.exitdate IS NULL AND icr.activeflag =1
ORDER BY 1 DESC LIMIT 1
) AS removaldate,
( select icr.removalid from
intakeservreqchildremoval icr
inner join intakeservicerequestactor ir on ir.intakeservicerequestactorid = icr.intakeservicerequestactorid
where icr.servicecaseid = v_servicecaseid ::uuid and ir.personid = p.personid AND icr.activeflag =1 order by 1 desc limit 1
) AS removalid,
( select icr.removalid from
intakeservreqchildremoval icr
inner join intakeservicerequestactor ir on ir.intakeservicerequestactorid = icr.intakeservicerequestactorid
where icr.servicecaseid = v_servicecaseid ::uuid and ir.personid = p.personid AND icr.activeflag =1 and icr.removalexitreason = 'ADPFIN' order by 1 desc limit 1
) AS adoptionRemovalid,
p.maritalstatustypekey as maritalstatustypekey,
(select typedescription from maritalstatustype where maritalstatustypekey = p.maritalstatustypekey and activeflag = 1 order by effectivedate desc limit 1) as maritalstatus
   FROM servicecase SC      
INNER JOIN Intakeservicerequestactor IAR ON IAR.servicecaseid = SC.servicecaseid AND IAR.isprimary =TRUE  AND IAR.activeflag=1
INNER JOIN actor AS AC ON AC.servicecaseid = IAR.servicecaseid AND AC.actorid = IAR.actorid AND AC.activeflag=1  
INNER JOIN person AS P ON P.personid=AC.personid AND P.activeflag=1
left join personphonenumber phone on phone.personid = p.personid  and phone.enddate is null
INNER JOIN gendertype AS G ON G.gendertypekey=P.gendertypekey                    
WHERE   SC.servicecaseid = v_servicecaseid ::uuid    
GROUP BY IAR.Intakeservicerequestactorid, P.biologicalmothermarriedsw, IAR.intakeservicerequestpersontypekey,SC.caseheadname,SC.statustypekey,SC.servicecaseid,IAR.intakeserviceid,P.personid,G.typedescription,AC.actorid,
address,dangeraddress,address2,state,city,zipcode,county
) as x)::json as realationshipdetails,
(
select json_agg(x) from (
SELECT col.collateralid, col.referralid, col.caseid, col.prefixtypekey, col.firstname,col.middlename, col.lastname, col.suffixtypekey, col.dob,
col.relationshiptypekey,  col.testifyflag,  col.attestableinfo,  col.familyknowledge,   col.workphone,
col.workextn, col.homephone, col.pager, col.email, col.fax, col.mobile, col.url, col.othercontacts, col.insertedon, col.datenotified,  col.legalclientid,
concat_ws(' ',coalesce(col.prefixtypekey,null),coalesce( col.firstname,null),coalesce(col.middlename,null),coalesce(col.lastname,null),coalesce(col.suffixtypekey,null) ):: character varying as fullname,
col.intakenumber,col.title,col.objecttype,
(SELECT  json_agg(address)  as collateraladdress FROM(
select coladd.collateraladdressid, coladd.collateralid, coladd.addresstypekey, coladd.formattypekey, coladd.streetnumber, coladd.boxnumber,
coladd.predirtypekey,coladd.streetnotes,coladd.address1 as address1,coladd.streetsuffixtypekey, coladd.postdirtypekey,coladd.unittypekey,
coladd.unitnumbertx,coladd.cityname,coladd.countytypekey,coladd.statetypekey,coladd.zip5no,coladd.zip4no,coladd.direction,coladd.foreignaddress,coladd.foreignstate,
coladd.country,coladd.postalcode,coladd.defaultflag,coladd.startdate,coladd.enddate,coladd.address2
FROM collateraladdress coladd                      
  where coladd.collateralid=col.collateralid
  and coladd.activeflag=1)
    address  )::json ,
    (SELECT  json_agg(roles)  as collateralroleconfig FROM(
    SELECT colrol.collateralroleconfigid, colrol.collateralid, colrol.actortypekey,rv.description
FROM collateralroleconfig colrol
inner join referencevalues rv on rv.ref_key=colrol.actortypekey and rv.referencetypeid=175
  where colrol.collateralid=col.collateralid
  and colrol.activeflag=1)
roles  )::json  
FROM collateral col
where col.caseid = v_servicecaseid ::uuid and col.activeflag=1
) as x
    )::json as collateral,
    ( select json_agg(x) from
( SELECT p.personid,  ar.actorrelationshipid, ar.caregiverflag, ar.intakeservicerequestactorid,
           ar.relationshiptypekey, COALESCE(rt.description,'Unknown') relation, concat(coalesce(p2.firstname,''),' ',coalesce(p2.lastname,'')) as caregivername,
           p2.dob as caregiverdob, p2.firstname as caregiverfirstname, p2.lastname as caregiverlastname, p2.gendertypekey as caregivergender,
           ar.person1id caregiverpersonid, ar.updatedon,
           ( select max(personemail.email) from personemail where personemail.personid = p2.personid and personemail.activeflag = 1 ) email,
(select pa.address  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) address,
(select pa.address2  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) address2,
(select pa.state  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) state,
(select pa.city  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) city,
(select pa.zipcode  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) zipcode,
       (select c.countyname from county c where c.activeflag=1 and c.countyid::character varying  in (select pa.county from personaddress AS pa  
        where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
      order by pa.updatedon desc limit 1)) county,
      ( select json_agg(contactinfo) from (
select personphonetypekey , phonenumber, ismobile  from personphonenumber  where personid = p2.personid and enddate is null ) as contactinfo
      )::json as phoneinfo
FROM actor a
INNER JOIN intakeservicerequestactor isa ON isa.actorid = a.actorid
INNER JOIN person p ON p.personid = a.personid
LEFT JOIN actorrelationship ar ON isa.intakeservicerequestactorid = ar.intakeservicerequestactorid and ar.person1id = a.personid
LEFT JOIN person p2 on p2.personid = ar.person1id
LEFT JOIN relationshiptype rt on rt.relationshiptypekey= ar.relationshiptypekey  AND rt.activeflag=1
WHERE a.activeflag=1 and isa.activeflag=1 and ar.caregiverflag = 1
AND CASE WHEN v_servicecaseid IS NOT NULL THEN
ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM intakeservicerequestactor WHERE
       (intakeserviceid = v_servicecaseid::uuid OR servicecaseid = v_servicecaseid::uuid) and activeflag=1)
ELSE
ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM intakeservicerequestactor WHERE
       intakenumber::character varying = v_servicecaseid :: CHARACTER varying and activeflag=1)
END
AND ar.person2id = v_personid :: uuid
ORDER BY ar.updatedon  ) as x
)::json as currentcaregiverinfo,
(select json_agg(x) from
(select i.removalid, intakeservreqchildremovalid , removaldate , i.removaltime, exitdate ,
i.removaladd1 as address1, i.removaladd2 as address2, removalcity as city, removalzip as zipcode,
i.agencytypekey , (select typedescription from agencytype  where agencytypekey = i.agencytypekey) as typedescription,
case
when i.exitdate is null then 'open'
else 'exited'
end as ischildremovalopen
from intakeservreqchildremoval i
inner join routing r2 on r2.objectid = i.intakeservreqchildremovalid ::character varying
inner join person p on p.personid = i.primarycaregiveractorid
where i.personid = v_personid ::uuid and i.servicecaseid = v_servicecaseid ::uuid  and r2.routingstatustypeid = 16
order by r2.insertedon desc limit 1 ) as x
)::json as childremovalinfo,
    (select json_agg(x) from (
SELECT DISTINCT ppa.personid, ppa.personprogramid , ppa.programkey, ppa.subprogramkey, ppa.startdate, ppa.activeflag,
(SELECT rv.description  FROM referencevalues rv  WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
(SELECT ap.programname FROM agencyprogramarea ap  WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
FROM personprogramarea ppa
inner join person p on ppa.personid = p.personid
WHERE ppa.personid = v_personid ::uuid and ppa.activeflag=1 AND ppa.enddate IS NULL AND ppa.sourcetype = 'CW'
ORDER BY ppa.programkey,ppa.subprogramkey desc  ) as x
)::json as programassingement,
   ( select json_agg(x) from
( select distinct pl.startdatetime, l.livingarrangementtypekey, r2.value_text as livingarrangementtypedescription ,
l.streetname, l.cityname, l.countytypekey, l.statetypekey , l.zip5no, l.primarycaregiver, l.livingid
from placement pl
inner join livingarrangement l on l.placementid = pl.placementid
inner join routing r on r.objectid = pl.placementid::character varying and r.routingstatustypeid = 16
inner join referencevalues r2 on r2.ref_key = l.livingarrangementtypekey and referencetypeid = 76
where pl.personid = v_personid and pl.servicecaseid = v_servicecaseid and pl.placementtypekey = 'LA'
and r.activeflag = 1 and pl.activeflag = 1 and date(now()) between date(pl.startdatetime) and coalesce (date(pl.enddatetime), date(now()))
) as x
)::json as livingarrangement,
( select json_agg(x) from
( select distinct pl.altproviderid, pl.startdatetime as placementstartdatetime, pl.providerid ,
( select row_to_json(x) from (
select p.provider_id ,p.adr_work_phone_tx as phonenumber,TBPA1.adr_street_no,TBPA1.adr_street_tx,TBPA1.adr_street_nm,TBPA1.adr_city_nm, TBPA1.adr_state_cd,TBPA1.adr_street_suffix_cd,TBPA1.adr_box_no,TBPA1.adr_zip5_no,
( select f_prvpcklst_cat(p.provider_id::bigint, 'PLACEMENT')) as provider_category_cd,
case coalesce(provider_nm, '')
when '' then coalesce(provider_first_nm , '') || ' ' || coalesce(provider_last_nm, '')
else provider_nm
end providername,
(cast(INITCAP(TRIM(coalesce(TBPA1.adr_street_tx, ''))|| ' ' || TRIM(coalesce(TBPA1.adr_street_nm, ''))|| ' ' || TRIM(coalesce(TBPA1.adr_street_suffix_cd, ''))||
                                    ' ' || TRIM(coalesce(TBPA1.adr_unit_type_cd, ''))|| ' ' || TRIM(coalesce(TBPA1.adr_unit_no_tx, ''))|| ' ' || TRIM(coalesce(TBPA1.adr_city_nm, '')) ||
                                    ' ' || TRIM(coalesce(TBPA1.adr_state_cd, '')) || ' ' || TRIM((coalesce(TBPA1.adr_zip5_no, 0::numeric))::character varying)) as character varying)) as address
from tb_provider as p
inner join tb_provider_addresses TBPA1 on TBPA1.parent_key_id::int = p.provider_id and TBPA1.delete_sw = 'N'
where p.provider_id = pl.altproviderid and p.delete_sw = 'N' AND TBPA1.adr_default_sw='Y' AND TBPA1.adr_type_cd='3357'  LIMIT 1
                   ) as x
          )::jsonb providerdetails
from placement pl
inner join routing r on r.objectid = pl.placementid::character varying and r.routingstatustypeid = 16
where pl.personid = v_personid :: uuid and pl.servicecaseid = v_servicecaseid  ::uuid and pl.placementtypekey = 'PRPL'
       and r.activeflag = 1  and pl.activeflag = 1 and date(now()) between date(pl.startdatetime) and coalesce (date(pl.enddatetime), date(now())) limit 1
) as x)::json as providerplacement,
( select json_agg(x) from
( select ph.placementcpahomeid as placement_cpa_home_id,
ph.placementid as placement_uuid,
ph.altplacementid as placement_id,
ph.altproviderid as provider_id ,
ph.entrydt as entry_dt,
ph.entrytm as entry_tm,
(case when provider_nm is not null then provider_nm
else
   concat(coalesce(prov.provider_prefix_cd, ''), ' ', coalesce(prov.provider_first_nm, ''), ' ', coalesce(prov.provider_middle_nm, ''), ' ', coalesce(prov.provider_last_nm, '') , ' ', coalesce(prov.provider_suffix_cd, ''))
   end) as resourceparentname,
(
   select concat_ws('', PA.adr_street_no, ' ', PA.adr_street_tx, ' ', PA.adr_street_nm, ' ', PA.adr_city_nm, ' ', PA.adr_state_cd, ' ', PA.adr_zip5_no ) AS provideraddres
   from tb_provider_addresses PA
   where PA.parent_key_id::int = ph.altproviderid AND PA.adr_type_cd = '3357'
   AND PA.adr_end_dt IS NULL AND adr_default_sw = 'Y'  limit 1
) as resourceparentaddress
from   placementcpahomes ph
inner join placement pl on ph.placementid = pl.placementid
inner join tb_provider prov on prov.provider_id = ph.altproviderid
where pl.personid = v_personid :: uuid and pl.servicecaseid = v_servicecaseid and pl.activeflag = 1 and pl.enddatetime is null and ph.activeflag = 1 and ph.exitdt is null
)as x
)::json as resourceparentsinfo,
(select json_agg(x) from (
select plan.permanencyplanid,
plan.primarypermanencytype,  
(select description from permanencyplantype where permanencyplantypekey  = plan.primarypermanencytype and activeflag = 1 limit 1) as primaryplantypedesc,
plan.projecteddate as primaryplandate,
plan.remarks as primarycomments,
concurrentpermanencytype,
(select description from permanencyplantype where permanencyplantypekey  = plan.concurrentpermanencytype and activeflag = 1 limit 1) as concurrentpermanencytypedesc,
plan.establisheddate,
plan.concurrentcomments,
plan.enddate
from Permanencyplan plan
inner join intakeservicerequestactor isr on plan.intakeservicerequestactorid = isr.intakeservicerequestactorid
inner join routing r on plan.permanencyplanid:: character varying = r.objectid  :: character varying and r.activeflag = 1 and r.routingstatustypeid = 16
where isr.personid  = v_personid ::uuid and plan.servicecaseid = v_servicecaseid ::uuid and plan.activeflag = 1 and plan.enddate is null
order by r.updatedon desc, plan.establisheddate  desc
) as x)::json as permanencyplans,
(select json_agg(x) from (
SELECT lc.legalcustodyid,
  lc.intakeservicerequestactorid,
      lc.legalcustodytypekey, TBPLV.value_text AS legalcustodytypedesc , lc.fromdate, lc.todate,
  (SELECT r2.description
FROM actorrelationship arp, relationshiptype r2
WHERE TRIM(r2.relationshiptypekey) = TRIM(arp.relationshiptypekey) and arp.intakeservicerequestactorid = isra.intakeservicerequestactorid AND arp.activeflag =1 order by arp.updatedon desc LIMIT 1
  ) relationshiptypekey,
--  padd.address As personaddress,
(select pa.address  from personaddress AS pa  where pa.personid=pn.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
        order by updatedon desc limit 1) personaddress,
  concat_ws(' ',coalesce(pn.prefx,null),coalesce(pn.firstname,null),coalesce(pn.middlename,null),coalesce(pn.lastname,null),coalesce(pn.suffix,null) ):: character varying As personname,
(SELECT  json_agg(legalcustodydetail)  AS  legalcustodydetail  FROM  (
   SELECT lcy.legalcustodytypekey, rv.description FROM legalcustody lcy
INNER JOIN referencevalues rv ON rv.ref_key = lcy.legalcustodytypekey AND rv.activeflag =1 AND lcy.activeflag =1
WHERE lcy.legalcustodyid = lc.legalcustodyid
)  legalcustodydetail)
FROM legalcustody lc
INNER JOIN person pn ON pn.personid = lc.personid AND pn.activeflag = 1 AND lc.activeflag = 1
INNER JOIN intakeservicerequestactor isra ON isra.personid = lc.personid and lc.servicecaseid = isra.servicecaseid and lc.intakeservicerequestactorid = isra.intakeservicerequestactorid
/*LEFT JOIN (SELECT max(personaddressid:: character varying) personaddressid, personid FROM personaddress
WHERE personaddresstypekey = 'C' AND activeflag =1 GROUP BY personid) pa
   ON pa.personid = pn.personid
LEFT JOIN personaddress padd ON padd.personaddressid:: character varying = pa.personaddressid*/
LEFT JOIN  referencevalues as TBPLV ON TBPLV.ref_key = lc.legalcustodytypekey and TBPLV.referencetypeid=28
WHERE lc.todate is null and pn.personid = v_personid ::uuid and lc.servicecaseid = v_servicecaseid ::uuid
) as x)::json as legalcustody,
( SELECT json_agg(x) FROM (
select MR.meetingrecordingid,
MR.servicecaseid ,
MR.meetingdate,
MR.meetingtypekey,
MT.typedescription as meetingtype,
MR.persontype,
MR.personname,
MR.meetingdescription,  
(SELECT json_agg(participant) FROM
(SELECT
participanttype,
participantkey,
participantroledesc,
firstname,
lastname,
emailid,
personid,
isinvited,
isattended,
isaccpted,
               electronicsignature
FROM meetingparticipants WHERE meetingrecordingid = MR.meetingrecordingid AND activeflag = 1)participant
) :: json AS participants
FROM meetingrecording MR
left join meetingtype MT on MR.meetingtypekey=MT.meetingtypekey
WHERE MT.meetingtypekey in ('AM', 'FTDM', 'FTM', 'Other', 'YTP') and
MR.activeflag = 1 and MR.servicecaseid = v_servicecaseid ::uuid ) as x
)::json  as meetings,
( select json_agg(x) from (
select concat_ws(' ',coalesce(prefx,null),coalesce(firstname,null),coalesce(middlename,null),coalesce(lastname,null),coalesce(suffix,null) ):: character varying As childname, dob, cjamspid as cjamsid
from person
where personid = v_personid ::uuid
) as x
)::json as childinfo,
( select json_agg(x) from (

SELECT  p.personid,ar.actorrelationshipid,ar.caregiverflag,ar.intakeservicerequestactorid,ar.relationshiptypekey,
       COALESCE(rt.description,'Unknown') relation, p.firstname, p.lastname, concat(coalesce(p2.firstname,''),' ',coalesce(p2.lastname,'')) as person2name,
p2.dob as person2dob, p2.firstname as person2firstname, p2.lastname as person2lastname, p2.gendertypekey as person2gender,
(select pa.address  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) address,
(select pa.address2  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) address2,
(select pa.state  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) state,
(select pa.city  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) city,
(select pa.zipcode  from personaddress AS pa  where pa.personid=p2.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 order by updatedon desc limit 1) zipcode,
( select json_agg(contactinfo) from (
select personphonetypekey , phonenumber, ismobile  from personphonenumber  where personid = p2.personid and enddate is null ) as contactinfo
      )::json as phoneinfo,
( select max(personemail.email) from personemail where personemail.personid = p2.personid and personemail.activeflag = 1 ) email,
ar.person1id person2id, ar.updatedon
FROM actor a
INNER JOIN intakeservicerequestactor isa ON isa.actorid = a.actorid
INNER JOIN person p ON p.personid = a.personid
LEFT JOIN actorrelationship ar ON isa.intakeservicerequestactorid = ar.intakeservicerequestactorid  and ar.person1id = a.personid
LEFT JOIN person p2 on p2.personid = ar.person1id
LEFT JOIN relationshiptype rt on rt.relationshiptypekey= ar.relationshiptypekey  AND rt.activeflag=1
WHERE a.activeflag=1 and isa.activeflag=1
AND CASE WHEN v_servicecaseid::uuid IS NOT NULL THEN
ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM intakeservicerequestactor WHERE
       (intakeserviceid = v_servicecaseid::uuid OR servicecaseid = v_servicecaseid::uuid) and activeflag=1)
ELSE
ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM intakeservicerequestactor WHERE
       intakenumber::character varying = v_servicecaseid ::character varying and activeflag=1)
END
AND ar.person2id = v_personid::uuid
ORDER BY ar.updatedon DESC
) as x

-- select * from getallpersonrelationbyprovidedpersonid (v_servicecaseid ::CHARACTER VARYING, v_personid ::CHARACTER VARYING)

) as relationshipsbyperson
    ) pms;
   

RETURN v_result;

END;  

 
$function$
;
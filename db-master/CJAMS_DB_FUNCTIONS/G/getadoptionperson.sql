DROP FUNCTION IF EXISTS cjams.getadoptionperson(_page integer, _limit integer, v_adoptiocaseid uuid);

CREATE OR REPLACE FUNCTION cjams.getadoptionperson(_page integer, _limit integer, v_adoptiocaseid uuid)
 RETURNS TABLE(totalcount bigint, rolename character varying, finalizationdate timestamp without time zone, dcn character varying, personid uuid, fullname character varying, firstname character varying, lastname character varying, suffix character varying, gender character varying, dob timestamp without time zone, age character varying, incidentage character varying, dobtdiffwithincidentdate integer, timereceived timestamp with time zone, dateofdeath timestamp without time zone, isapproxdod integer, isapproxdob integer, address character varying, dangeraddress boolean, address2 character varying, state character varying, city character varying, zipcode character varying, county character varying, height character varying, weight character varying, haircolortypekey character varying, hairtexturetypekey character varying, eyecolortypekey character varying, physicalbuildtypekey character varying, skintonetypekey character varying, hairtextureotherdesc character varying, haircolorotherdesc character varying, isglasses boolean, employername character varying, clienttitle character varying, race json, phonenumber character varying, phonedetails json, emaildetails json, addressinfo json, dangerous json, actorid uuid, intakeservicerequestactorid uuid, isalleged integer, priorscount bigint, reported boolean, refusessn boolean, refusedob boolean, userphoto text, primarylanguageid character varying, primarylanguage character varying, secondarylanguageid character varying, secondarylanguage character varying, otherprimarylanguagetypekey character varying, otherreligion character varying, email character varying, roles json, relationship character varying, relationshiparray json, relationshipdescription character varying, ishousehold integer, iscollateralcontact integer, schoolname json, ssn character varying, assistpid character varying, cjamspid bigint, strengths character varying, needs character varying, medicalinformation json, medicationinformation json, addendum json, medicalcondition json, emergency json, guardianinfo json, guardianpropertyinfo json, guardianattornyinfo json, guardianworkerinfo json, guardiafuneralinfo json, guardiacodeinfo json, personpayeeinfo json, ethinicity character varying, gendertypedesc character varying, religion character varying, maritalstatus character varying, aliasname character varying, racetypekey character varying, fetalalcoholspctrmdisordflag integer, drugexposednewbornflag integer, probationsearchconductedflag integer, sexoffenderregisteredflag integer, citizenalenageflag integer, isqualifiedalien integer, alienregistrationtext character varying, verificationremarks character varying, alienstatustypekey character varying, issafe integer, programarea json, isheadofhousehold boolean, biologicalmothermarriedsw integer, ivedeterminationdetails json , iverejecteddeterminationdetails json , iveadoptiondetails json, iveadoptionrejecteddetails json, is_mdm_sync boolean, everbeenadoptedflag integer, cferesourcehomechild boolean, limitedenglishproficiency boolean, needtranslatorinterpreter boolean, readingproficiency boolean, writingproficiency boolean, speakingproficiency boolean,
 effectivedate timestamp without time zone,
 senstatusflag integer, clientflag integer, activeremovalservicecase character varying, userroles character varying, rolehistory json, birthmatchdetails json, sennotifications json, preadoptiondate timestamp without time zone, intercountryadoption integer, priorlegalguardianship integer, preplacementguardianshipdate timestamp without time zone, personmovestatus integer,isencryptedpersonrole boolean)
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------------------------
-- 03-01-2022 Veera Nadimpalli - Persons API failing for Adoption Cases
-- 08-08-2022 Vijaya Laxmi Devunoori - New columns added per CIDM-5099
-- 06-30-2023 Chandra/Palani -- Query Optimization (CIDM-7446)
-- 10-18-2023 Smitha Somasekharan - person detail API failing for adoption cases due to multiple row in reference key table
-- 10-12-2023 Veera B97262_CIDM8070_Person Card - Rejected IV-E decision
-- 10-25-2023 Veera B-97263-CIDM-8097 Person Card Rejected status for Adoption cases
-- 02/06/2024 - CIDM-10020 - User story changes to get case id for program area 
-- 10/07/2025 - Veera Nadimpalli - CIDM-10625 -POSC Enhancement userstory changes Fix
---01/08/2026 --CIDM-10981--Umasankar Raavi --Added additional Person table columns for the Limited English Proficiency (LEP) user story
--------------------------------------------------------------------------------------------
 declare
_offset integer;
jsondatas json;
narativeval json;
obj json;
incidentdate timestamp without time zone;
incidentdateval character varying;
begin
_offset := (_page - 1) * _limit;

 
incidentdate := null;
 

RETURN QUERY
 
select
"Person".totalcount,
"Person"."intakeservicerequestpersontypekey",
(select
(ag.finalizationdate at time zone 'utc' at time zone 'est')
from adoptioncase ac
inner join adoptionplanning ap on ap.servicecaseid=ac.servicecaseid and ap.activeflag=1 and ac.activeflag=1
inner join adoptionagreement ag on ag.adoptionplanningid=ap.adoptionplanningid and ag.activeflag=1
where ac.adoptioncaseid=v_adoptiocaseid LIMIT 1
) :: timestamp without time zone  as finalizationdate,
"Person".dcn,
"Person".personid,
"Person".fullname,
"Person".firstname,
"Person".lastname,
"Person".suffix,
"Person".gendertypekey,
"Person".dob,
(CASE WHEN EXTRACT(YEAR FROM age(now(), "Person".dob)) <= 0 THEN
CASE WHEN EXTRACT(MONTH FROM age(now(), "Person".dob)) <= 0 THEN
CONCAT (EXTRACT(DAY FROM age(now(), "Person".dob)) :: CHARACTER varying, ' ', 'Day(s)')
ELSE CONCAT (EXTRACT(MONTH FROM age(now(), "Person".dob)) :: CHARACTER varying, ' ', 'Month(s)')
END
ELSE CONCAT (EXTRACT(YEAR FROM age(now(), "Person".dob)) :: CHARACTER varying,' ', 'Yrs') end)::character varying AS age,

  '' ::character varying  as incidentage,
null::integer as dobtdiffwithincidentdate, 
null ::timestamp  with time zone,
"Person".dateofdeath  ::timestamp,
"Person".isapproxdod,
"Person".isapproxdob,
"Person".address,
null ::boolean  as dangeraddress,
"Person".address2,
"Person".state,
"Person".city,
"Person".zipcode,
"Person".county,
"Person".height,
"Person".weight,
"Person".haircolortypekey,
"Person".hairtexturetypekey,
"Person".eyecolortypekey,
"Person".physicalbuildtypekey,
"Person".skintonetypekey,
"Person".hairtextureotherdesc,
      "Person".haircolorotherdesc,
      "Person".isglasses,
      "Person".employername,
      "Person".clienttitle,
 (select json_agg(x) from (select prt.racetypekey,rv.value_text from personracetypemap prt
 join referencevalues rv on rv.ref_key=prt.racetypekey and rv.referencetypeid=171
 where prt.personid="Person".personid
 ) x)
  as race,
(
select ph.phonenumber
from
personphonenumber ph
where
ph.personid = "Person".personid
--and ph.personphonetypekey = 'P'
and activeflag = 1
order by
insertedon desc
limit 1),
(
select
json_agg(f) as phonedetails
from
(
select  
ph.personphonenumberid, ph.personphonetypekey, ph.phonenumber, ph.phoneextension, ph.reversephonenumber
,ph.ismobile, ph.startdate, ph.enddate,
(select rv.description as personphonetype  from referencevalues rv
where rv.ref_key = ph.personphonetypekey and rv.referencetypeid = 173 and rv.activeflag = 1 limit 1)
from
personphonenumber ph
where
ph.personid = "Person".personid
--and ph.personphonetypekey = 'P'
and activeflag = 1
order by
insertedon desc
) as f )::json,
(
select
json_agg(f) as emaildetails
from
(
select * from
personemail ph
where
ph.personid = "Person".personid
--and ph.personphonetypekey = 'P'
and activeflag = 1
order by
insertedon desc
) as f ) ::json,
(
select
json_agg(f) as addressinfo
from
(
select  
pas.personaddressid, pas.activeflag, pas.personaddresstypekey, pas.address, pas.zipcode, pas.city, pas.state,
pas.country, pas.county,  pas.currentlocationflag,
pas.address2, pas.directions, pas.danger, pas.dangerreason,
pas.adrstreetsuffixtypekey, pas.streetname, pas.changereason, pas.acknowledgement, pas.acknowledgementflag, pas.adrboxno,
pas.formattedcityname, pas.formattedstreetname, pas.incidentlocation, pas.incidentlocationflag,
pas.mergeid, pas.personaddresssubtypekey, pas.personadrstartdate,
pas.personadrenddate, pas.addressstatus, pas.durationday, pas.ishouseholdmember, pas.addressstartdate,
  (select pat.typedescription as addresstype from personaddresstype pat where pat.personaddresstypekey= pas.personaddresstypekey  limit 1)
from
personaddress pas

where
pas.personid = "Person".personid
--and ph.personphonetypekey = 'P'
and activeflag = 1
order by
insertedon desc
) as f ) ::json,
null:: json as dangerous,
"Person".actorid,
"Person".adoptioncaseactorid intakeservicerequestactorid,
0::int isvictim,

0::bigint as "priorscount",
"Person".reported,
"Person".RefuseSSN,
"Person".RefuseDOB,
"Person".userphoto ::text,
"Person".primarylanguageid,
(select description as primarylanguage from referencevalues where ref_key = "Person".primarylanguageid and activeflag = 1 and coalesce(teamtypekey, 'CW') = 'CW'  order by insertedon desc limit 1),
"Person".secondarylanguageid,
(select description as secondarylanguage from referencevalues  where ref_key = "Person".secondarylanguageid and coalesce(teamtypekey, 'CW') = 'CW' order by insertedon desc limit 1),
"Person".otherprimarylanguagetypekey,
"Person".otherreligion,
"Person".email:: character varying,
"Person".roles ::json,
"Person".relationship :: character varying,
"Person".relationshiparray :: json,
"Person".relationshipdescription :: character varying,
1::int ishousehold,
0:: int iscollateralcontact,
"Person".schoolname :: json,
(select pi.personidentifiervalue from personidentifier pi where pi.personid = "Person".personid and pi.activeflag = 1
and pi.personidentifiertypekey = 'SSN' order by insertedon desc limit 1),
"Person".assistpid,
"Person".cjamspid,
"Person".strengths,
"Person".needs,
"Person".medicalinformation ::json,
"Person".medicationinformation ::json,
"Person".addendum ::json,
"Person".medicalcondition ::json,
"Person".emergency ::json,
"Person".guardianinfo::json,
"Person".guardianpropertyinfo::json,
"Person".guardianattornyinfo::json,
"Person".guardianworkerinfo::json,
"Person".guardiafuneralinfo::json,
"Person".guardiacodeinfo::json,
"Person".personpayeeinfo::json,
"Person".ethinicity,
"Person".gendertypedesc,
"Person".religion,
"Person".maritalstatus,
(
select
(CONCAT(a.prefixtypekey , ' ',a.firstname, ' ', a.middlename, ' ', a.lastname, ' ', a.sfxname) )
as aliasname
from
alias a
where
a.personid = "Person".personid
and a.activeflag = 1
limit 1) :: character varying,
"Person".racetypekey,
0::int fetalalcoholspctrmdisordflag,
0::int drugexposednewbornflag,
0::int probationsearchconductedflag,
0::int sexoffenderregisteredflag,
0::int citizenalenageflag,
"Person".isqualifiedalien,
"Person".alienregistrationtext,
"Person".verificationremarks,
"Person".alienstatustypekey,
1 safe,
"Person".programarea::json,
"Person".isheadofhousehold,
"Person".biologicalmothermarriedsw,
"Person".ivedeterminationdetails,
"Person".iverejecteddeterminationdetails,
"Person".iveadoptiondetails,
"Person".iveadoptionrejecteddetails,
"Person".is_mdm_sync,
"Person".everbeenadoptedflag,
"Person".cferesourcehomechild,
"Person".limitedenglishproficiency, 
"Person".needtranslatorinterpreter,
"Person".readingproficiency,
"Person".writingproficiency,
"Person".speakingproficiency,
"Person".effectivedate,
"Person".senstatusflag,
"Person".clientflag,
null::varchar,
        (case when "Person".roles is not null
                then (with roletable as (
                            select 1 id, "Person".roles  js
                                )
                                select string_agg(j.v ->> 'typedescription', ', ') vals
                                from roletable t
                                cross join lateral jsonb_array_elements( (js::jsonb)) j(v)
                                where j.v ->> 'typedescription'  is not null
                                group by t.id
                ) else null end)::character varying,
"Person".rolehistory,
(select json_agg(f) as birthmatchdetails from
(select * from personbirthmatch ph where ph.personid = "Person".personid and activeflag = 1 order by insertedon desc) as f
) ::json,
(select json_agg(x) as sennotifications from
(select * from senhistorynotifications sh where sh.personid = "Person".personid and activeflag = 1 order by insertedon desc) as x
) ::json,
"Person".preadoptiondate,
"Person".intercountryadoption,
"Person".priorlegalguardianship,
"Person".preplacementguardianshipdate,
1::int as personmovestatus,
false as isencryptedpersonrole
from
(
select
count(1) over() as totalcount,
iar.actortypekey as "intakeservicerequestpersontypekey",
false as isheadofhousehold,
p.biologicalmothermarriedsw,
(
SELECT
json_agg(e) AS ivedeterminationdetails
FROM
(select
tbpv.description_tx as IVEstatustype, tpe.eligibility_period_id as IVEtransactionid, tpe.sqnm_sw
from tb_client_eligibility tbce  
inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.delete_sw = 'N' and tpe.approvalstatus in ('PENDING','APPROVED')
inner join tb_picklist_values tbpv on  TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262  
where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2931'
order by tpe.eligibility_period_id desc limit 1
) AS e
) ::json,
(
	SELECT json_agg(e) AS iverejecteddeterminationdetails FROM (
		select tbpv.description_tx as IVEstatustype, tpe.eligibility_period_id as IVEtransactionid, tpe.sqnm_sw, tpe.approvalstatus
		from tb_client_eligibility tbce  
		inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.approvalstatus in ('REJECTED')
		inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262  
		where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2931'
		order by tpe.end_dt desc NULLS LAST) AS e
) ::json,
(
	SELECT json_agg(e) AS iveadoptiondetails FROM (
	select tbpv.description_tx as adoptionstatustype, tpe.eligibility_period_id as adoptiontransactionid, tpe.sqnm_sw, tbce.client_id as adoptionclientid, tpe.approvalstatus
        from tb_client_eligibility tbce  
	inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.delete_sw = 'N' and tpe.approvalstatus in ('PENDING','APPROVED')
        inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262 
	where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2934'
	order by tpe.sqnm_sw  desc NULLS LAST limit 2) AS e
) ::json,
(
	SELECT json_agg(e) AS iveadoptionrejecteddetails FROM (
	select tbpv.description_tx as adoptionstatustype, tpe.eligibility_period_id as adoptiontransactionid, tpe.sqnm_sw, tbce.client_id as adoptionclientid, tpe.approvalstatus
        from tb_client_eligibility tbce  
	inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.delete_sw = 'N' and tpe.approvalstatus = 'REJECTED' 
        inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262 
	where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2934'
	order by tpe.sqnm_sw  desc limit 1 ) AS e
) ::json,
(select mpd.is_mdm_sync from mdmgoldenpersondetails mpd where mpd.personid=p.personid and mpd.activeflag=1 order by mpd.insertedon desc limit 1) as is_mdm_sync,
p.everbeenadoptedflag,
p.cferesourcehomechild,
p.limitedenglishproficiency,
p.needtranslatorinterpreter,
p.readingproficiency,
p.writingproficiency,
p.speakingproficiency,
p.effectivedate,
p.senstatusflag,
p.clientflag,
(
select personidentifiervalue  from personidentifier pid
where pid.personid = p.personid
and personidentifiertypekey = 'DCN'
and activeflag = 1
limit 1) as dcn,
p.personid,
    concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
 
    p.firstname,
p.lastname,
p.suffix,
p.gendertypekey,
p.dob,
p.dateofdeath,
p.isapproxdod,
p.isapproxdob,
p.userphoto,
p.primarylanguageid,
p.secondarylanguageid,
p.otherprimarylanguagetypekey,
p.otherreligion,
/*pa.address,
pa.address2,
pa.state,
pa.city,
pa.zipcode,
pa.county,*/
(select pa.address  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
        order by updatedon desc limit 1) address,
(select pa.address2  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
        order by updatedon desc limit 1) address2,
(select pa.state  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
        order by updatedon desc limit 1) state,
(select pa.city  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
        order by updatedon desc limit 1) city,
(select pa.zipcode  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
        order by updatedon desc limit 1) zipcode,
(select pa.county from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1
       order by pa.updatedon desc limit 1) county,
ppa.attributevalue as height,
ppat.attributevalue as weight,
p.haircolortypekey,
p.hairtexturetypekey,
p.eyecolortypekey,
p.physicalbuildtypekey,
p.skintonetypekey,
p.hairtextureotherdesc,
      p.haircolorotherdesc,
      p.isglasses,
      p.employername,
      p.clienttitle,
null reporterincidentdate,
iar.adoptioncaseactorid actorid,
max(iar.adoptioncaseactorid:: character varying) :: uuid as adoptioncaseactorid,
null isvictim,
false ::bool reported ,
false::bool refusessn,
false ::bool refusedob,
(
select max(personemail.email)
from
personemail
where
personemail.personid = P.personid
and personemail.activeflag = 1 ) email,
(
select
json_agg(e) as roles
from
(
select
isrpn.actortypekey intakeservicerequestpersontypekey,
ISRPN.adoptioncaseactorid intakeservicerequestactorid,
null rcexpungementflag,null spexpungementflag,
rv.value_text as typedescription
from
adoptioncaseactor ISRPN  
inner join referencevalues rv on rv.ref_key = isrpn.actortypekey AND  rv.referencetypeid = 176 AND rv.activeflag =1
where  (isrpn.adoptioncaseid = v_adoptiocaseid  )
and isrpn.activeflag = 1
AND isrpn.personid = p.personid
) as e ) ::json,
'' as relationship,
null :: json as relationshiparray,
'' relationshipdescription,
null as ishousehold,
null as iscollateralcontact,
(

select
json_agg(f) as schoolname
from
(
select
e.personeducationid, e.personid, e.educationname, e.educationtypekey, e.schoolsettingtypekey, e.transportmodetypekey,
e.transportmodetypedetail, e.adrcityname, e.adresscounty, e.statecode, e.startdate, e.enddate,
e.contactname, e.adrworkphone, e.adrworkxtn, e.schoolschedule, e.schooladjustment, e.isspecialeducation,
e.specialeducationtypekey, e.lastiepdate, e.ifsplastdate, e.numberofabsences, e.isreceived, e.isverified,
e.isexcuesed, e.extracurricular,
e.firstqtrabsence, e.firstqtrabsenceexcused, e.firstqtrabsencenotexcused, e.firstqtrabsencetardy,
e.secondqtrabsence, e.secondqtrabsenceexcused, e.secondqtrabsencenotexcused, e.secondqtrabsencetardy,
e.thirdqtrabsence, e.thirdqtrabsenceexcused, e.thirdqtrabsencenotexcused, e.thirdqtrabsencetardy,
e.fourthqtrabsence, e.fourthqtrabsenceexcused, e.fourthqtrabsencenotexcused, e.fourthqtrabsencetardy,
e.summerschoolname, e.highestgradetypekey, e.currentgradetypekey, e.lastgradetypekey,
e.classtypetypekey, e.currentgradelevel, e.functioninggradelevel, e.lastgradelevel,
e.firstqtrperformancetypekey, e.secondqtrperformancetypekey, e.thirdqtrperformancetypekey, e.fourthqtrperformancetypekey,
e.speacialeducationrestrictivekey, e.lastattendeddate, e.schoolexitcomments, e.disciplinaryactioncomments, e.sasidno,
(select rv.description as adresscountydesc  from referencevalues rv where rv.ref_key = e.adresscounty and rv.referencetypeid = 306 and rv.activeflag = 1 limit 1)

from
personeducation e
where
e.personid = p.personid
 ) as f
) ::json,
coalesce((select pii.personidentifiervalue from personidentifier pii where pii.personidentifiertypekey = 'IRN' and pii.personid = p.personid and pii.activeflag = 1 limit 1), p.cisclientid) as assistpid,
p.cjamspid,
p.strengths,
p.needs,
(
select
json_agg(e) as medicalinformation
from
(
select
isra.adoptioncaseid intakeserviceid,
isra.adoptioncaseactorid actorid,
phi.ismedicaidmedicare,
phi.insurancetype,
phi.policyname,
ppi.name ,
ppi.phone,
ppi.address1,
ppi.address2,
ppi.city,
ppi.state,
ppi.zip,
pbh.currentdiagnoses,
pbh.clinicianname,
pbh.phone as behavioralphone,
pbh.address1 as behavioraladdress1,
pbh.address2 as behavioraladdress2,
pbh.city as behavioralcity,
pbh.state as behavioralstate,
pbh.zip as behavioralzip,
phi.personid,
ppi.isprimaryphycisian,
pbh.isbehavioralhealth,
pbh.reportname,
phi.medicarenumber
from  adoptioncaseactor isra
INNER JOIN person per on
per.personid = isra.personid
left JOIN personhealthinsurance as phi on
phi.personid = per.personid
and phi.activeflag = 1
left JOIN personphycisianinfo as ppi on
ppi.personid = per.personid
and ppi.activeflag = 1
left JOIN personbehavioralhealth as pbh on
pbh.personid = per.personid
and pbh.activeflag = 1
where  (isra.adoptioncaseid = v_adoptiocaseid  )
and per.activeflag = 1
 ) as e ) ::json,
(
select
json_agg(e) as medicationinformation
from
(
select
isra.adoptioncaseid intakeserviceid,
isra.adoptioncaseactorid actorid,
pmpt.dosage,
pmpt.medicationname,
pmpt.frequency,
pmpt.compliant,
pmpt.personid,
pmpt.medicationcomments,
pmpt.prescribingdoctor,
pmpt.lastdosetakendate,
pmpt.monitoring,
prt.description as prescriptionreason ,
ist.description as informationsource,
pmpt.medicationeffectivedate,
pmpt.medicationexpirationdate,
pmpt.medicationname
from
adoptioncaseactor isra
INNER JOIN person per on
per.personid = isra.personid
and per.activeflag = 1
left JOIN personmedicpshychotropic as pmpt on
pmpt.personid = per.personid
and pmpt.activeflag = 1
left JOIN prescriptionreasontype prt on
prt.prescriptionreasontypekey = pmpt.prescriptionreasontypekey
and prt.activeflag = 1
left JOIN informationsourcetype ist on
ist.informationsourcetypekey = pmpt.informationsourcetypekey
and ist.activeflag = 1
where
(isra.adoptioncaseid = v_adoptiocaseid  )
) as e ) ::json,
(
select
json_agg(e) as addendum
from
(
select
isra.adoptioncaseid intakeserviceid,
isra.adoptioncaseactorid actorid,
pas.isusealcohol,
pas.isusedrug,
pas.isusetobacco,
pas.alcoholfrequencydetails,
pas.drugfrequencydetails ,
pas.personid
from
adoptioncaseactor isra
INNER JOIN person per on
per.personid = isra.personid
and per.activeflag = 1
left JOIN personabusesubstance as pas on
pas.personid = per.personid
where
pas.activeflag = 1
and (isra.adoptioncaseid = v_adoptiocaseid  )
and isra.activeflag = 1 ) as e ) ::json,
(
select
json_agg(e) as medicalcondition
from
(
select
isra.adoptioncaseid intakeserviceid,
isra.adoptioncaseactorid actorid,

pmci.medicalconditiontypekey,
mct.description,
pmc.begindate,
pmc.enddate,
pmc.recordedby
from
adoptioncaseactor isra

INNER JOIN person per on
per.personid = isra.personid
and per.activeflag = 1
left JOIN personmedicalcondition as pmc on
pmc.personid = per.personid
and pmc.activeflag = 1
left JOIN personmedicalconditioninfo as pmci on
pmc.personmedicalconditionid = pmci.personmedicalconditionid
and pmci.activeflag = 1
left JOIN medicalconditiontype as mct on
mct.medicalconditiontypekey = pmci.medicalconditiontypekey
and mct.activeflag = 1
where
(isra.adoptioncaseid = v_adoptiocaseid )
 ) as e ) ::json,
null   ::json emergency,
null   ::json guardianinfo,
null   ::json guardianpropertyinfo,
null   ::json guardianattornyinfo,
null   ::json guardianworkerinfo,
null   ::json guardiafuneralinfo,
null   ::json guardiacodeinfo,
null   ::json personpayeeinfo,

egt.typedescription as ethinicity,
grt.typedescription as gendertypedesc,
rt.typedescription as religion,
MT.typedescription as maritalstatus,
RAT.typedescription as racetypekey,
null fetalalcoholspctrmdisordflag ,
null drugexposednewbornflag,
null probationsearchconductedflag,
null sexoffenderregisteredflag,
p.citizenalenageflag,
p.isqualifiedalien,
p.alienregistrationtext,
p.verificationremarks,
p.alienstatustypekey,
null timerecieved,
(
SELECT
json_agg(e) AS programarea
FROM
            (
SELECT
ppa.programkey,
ppa.subprogramkey,
ppa.objectid,
(SELECT rv.description  FROM referencevalues rv
WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
(SELECT ap.programname FROM agencyprogramarea ap
WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
FROM personprogramarea ppa
WHERE ppa.personid = p.personid and ppa.sourcetype = 'CW'
--AND ppa.objectid=v_adoptiocaseid ::character varying
AND ppa.activeflag=1  AND ppa.enddate IS NULL
) AS e
) ::json,
(
select coalesce(json_agg(e), '[]') as roles
from
(select u.fullname as username, ph.updatedby, ph.updatedon, ph."comments"
from personrole_history ph
inner join userprofile u on u.securityusersid =  ph.updatedby
where ph.personid = p.personid
order by ph.updatedon desc
) as e
) ::json as rolehistory,
p.preadoptiondate,
p.intercountryadoption,
p.priorlegalguardianship,
p.preplacementguardianshipdate
from adoptioncase  irs
INNER JOIN (
SELECT * FROM  adoptioncaseactor
WHERE adoptioncaseid = v_adoptiocaseid
-- @Simar Data migration from chessie a person can have multiple 'roles' in an adoption case
-- adding this check for restricting the join to be on only thse 2 roles as CJAMS can only have one actor entry
-- We have a sub-query that will retrieve all the other roles of these actors
AND actortypekey IN ('CHILD', 'ADOPTIVEPARENT', 'PVTADPCHILD')
) as iar ON iar.adoptioncaseid =irs.adoptioncaseid AND irs.activeflag =1
LEFT JOIN person as p on
p.personid = iar.personid
and p.activeflag = 1
/*left JOIN (
select
paa.personid,
(max(paa.personaddressid::character varying))::uuid personaddressid
from
personaddress as paa
where
--paa.personaddresstypekey='C' AND
 paa.activeflag = 1
 and paa.currentlocationflag = 1
group by
paa.personid ) pa1 on
pa1.personid = p.personid
 
left JOIN personaddress as pa on
pa.activeflag = 1
and pa.personaddressid = pa1.personaddressid*/
--pa.personaddresstypekey='C' AND
left JOIN personphysicalattribute as ppa on
ppa.personid = P.personid
and ppa.physicalattributetypekey = 'Ht'
and ppa.activeflag = 1
left JOIN personphysicalattribute as ppat on
ppat.personid = P.personid
and ppat.physicalattributetypekey = 'Wt'
and ppat.activeflag = 1
left JOIN ethnicgrouptype egt on
egt.ethnicgrouptypekey = p.ethnicgrouptypekey
and egt.activeflag = 1
LEFT JOIN gendertype grt on grt.gendertypekey = p.gendertypekey and grt.activeflag=1
left JOIN religiontype RT on
rt.religiontypekey = p.religiontypekey
and rt.activeflag = 1
left JOIN racetype RAT on
RAT.racetypekey = P.racetypekey
and RAT.activeflag = 1

left JOIN maritalstatustype MT on
MT.maritalstatustypekey = p.maritalstatustypekey
and MT.activeflag = 1
where
( iar.adoptioncaseid = v_adoptiocaseid
and iar.activeflag = 1
)
group by
iar.actortypekey,
irs.adoptioncaseid,
p.personid,
iar.adoptioncaseactorid,
address,
address2,
state,
city,
zipcode,
county,
ppa.attributevalue,
ppat.attributevalue,
egt.typedescription ,
rt.typedescription,
rat.typedescription,
grt.typedescription,
MT.typedescription
)as "Person"
limit _limit offset _offset;
end;


$function$
;

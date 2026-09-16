

DROP FUNCTION IF exists cjams.getpsychotropiclistbyrequestid(requestid int8);

CREATE OR REPLACE FUNCTION cjams.getpsychotropiclistbyrequestid(requestid int8)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------------------------------
-- 03/13/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard
-- 03/09/2026 vamshikri.byreddy - CIDM-10987 B-236421 : CW-Psychotropic Secondary all request dashboard
-- 08/11/2026 Manasa Kasula - CIDM-11602 Large file upload implementation
-----------------------------------------------------------------------------------------------------
declare 
v_result json;
v_requestid int8;
begin
	v_requestid :=requestid;

select json_agg(a) INTO  v_result from (select  count(1) over(),ps.*,
max(concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname) ) as clientname,
max(p.dob) as dob,
max(p.gendertypekey)  as gender,
max(p.cjamspid) as cjamspid,
max(co.countyname) as county ,
max(r.tosecurityusersid )as edituser,
STRING_AGG(DISTINCT rfv.description, ', ') as race,
max(rf1.description) as ethnicity,
(select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1) as submittedon,
max(up.firstname || ' ' || up.lastname) as submittedby,
MAX( COALESCE(rs.typedescription, 'Draft') ) AS reviewstatus,
( select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r2.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r2.insertedon desc limit 1  ) as pharmacist,
( select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r3.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r3.insertedon desc limit 1  ) as psychiatrist,
(select coalesce (s.servicecasenumber,a.adoptioncasenumber,isr.servicerequestnumber) 
from cjams.psychotropicmedications  ps1
--left join intakeservicerequest isr on isr.servicecaseid=ps1.objectid::uuid and isr.activeflag=1
left join servicecase s on s.servicecaseid=ps1.objectid::uuid and s.activeflag =1 
left join adoptioncase a  on a.adoptioncaseid=ps1.objectid::uuid and a.activeflag =1 
left join intakeservicerequest isr  on isr.intakeserviceid=ps1.objectid::uuid and isr.activeflag =1 
where ps1.objectid=ps.objectid limit 1 ) as casenumber,
(select (firstname || ' ' || lastname) from person where personid in( select personid  from  intakeservicerequestactor 
where (servicecaseid=ps.objectid::uuid or intakeserviceid=ps.objectid::uuid )  and  activeflag =1
and isheadofhousehold =true  order by insertedon desc limit 1) order by insertedon desc limit 1) as HOH,
(select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY'
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) is not null 
then r4.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) else true end
order by r4.updatedon desc limit 1) as reviewdate,
(select json_agg(docs)  from (SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title,dp.additionalobjectid, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
    (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
    dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.uploadstatus, dp.finalstatus,dp.activeflag,
    (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
    SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
    (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
    WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
    ) x)
from documentproperties dp where dp.additionalobjectid = ps.psychotropicid ::character varying and dp.activeflag in (1,3,4,5)
)docs) as uploadedFiles
from cjams.psychotropicmedications  ps
left join routing r on r.objectid=ps.psychotropicid ::character varying and r.activeflag=1 and r.eventcode='PSY'
left join routingstatustype rs on rs.sequencenumber =r.routingstatustypeid
left join person p on p.personid =ps.personid ::uuid

          left join county co on co.countyid = ps.countytypekey ::uuid and co.activeflag =1
           left join personracetypemap  prt on prt.personid=p.personid and prt.activeflag=1
           left join referencevalues rfv on rfv.ref_key::character varying =prt.racetypekey::varchar and rfv.activeflag=1 and rfv.referencetypeid = '171'
          left join referencevalues rf1 on rf1.ref_key=p.ethnicgrouptypekey and rf1.activeflag=1 and rf1.referencetypeid = '300'
left join userprofile up on up.securityusersid=ps.insertedby
where ps.psychotropicrequestid=v_requestid and ps.activeflag=1  

 group by ps.psychotropicid ) a;
	
RETURN v_result;
end;

$function$
;
CREATE OR REPLACE FUNCTION cjams.getappealdashboard(v_securityusersid uuid, v_page integer, v_limit integer, v_servicerequestnumber character varying, v_focusname character varying, sortorder character varying, sortcolumn character varying, actionstatus character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------
--Revision(s)
--09/11/2023 - Palani/Chandra - Query tuning (CIDM-7909)
--09/18/2023 - Palani/Chandra - Query tuning (CIDM-7946)
--09/20/2023 - Palani/Chandra - Query tuning (CIDM-7959)

----------------------------------------------------------
DECLARE l_appeal json;
                   
v_offset    integer;
 

BEGIN
v_offset  :=  (v_page  -  1)  *  v_limit;  
 

IF ( v_securityusersid is not null ) THEN  

RAISE  NOTICE  'v_securityusersid>>>>>>>>>>>%',v_securityusersid;
   
SELECT json_agg(appeal) INTO l_appeal FROM (

SELECT  count(1) OVER() totalcount, ISR.intakeserviceid,
ISR.servicerequestnumber as servicerequestnumber,
(
  SELECT  srst.classkey  FROM  servicerequestsubtype as srst
  WHERE  srst.servicerequestsubtypeid = ISR.intakeservicerequestclassid  AND srst.activeflag = 1  limit  1
),      
-- (
  -- SELECT COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'')as name
  -- FROM intakeservicerequestactor isra
  -- inner join person p on p.personid =  isra.personid and isra.intakeserviceid= isr.intakeserviceid  
  -- and isra.activeflag=1 and p.activeflag=1  and (isra.isheadofhousehold=true) limit 1
-- ) legalguardian,
(select ((getcasepersonname) -> 0 ->> 'personname')  as legalguardian
from getcasepersonname ('servicerequest',isr.intakeserviceid::character varying)
) as legalguardian,
(
  SELECT json_agg(a) FROM(
    select COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'')as name
    from intakeservicerequestactor isra
    inner join person p on p.personid =  isra.personid
    and isra.intakeserviceid= isr.intakeserviceid  
    and isra.activeflag=1 and p.activeflag=1  and isra.intakeservicerequestpersontypekey ='AM' order by name
  ) a  
) maltreators,
(
  select coalesce(
    (
      select r.insertedon from routing r
      WHERE r.eventcode = 'INDR' AND r.objectid=sd.intakeservicerequestdispositioncodeid :: character varying and r.activeflag = 1
      order by insertedon desc limit 1
    ),
    sd.statusdate,
    sd.insertedon
  ) from IntakeServiceRequestDispositionCode sd where IntakeServiceId= ISR.intakeserviceid
  and sd.servicerequesttypeconfigiddispostionid IN ('d90db0d3-f665-49db-b3ad-0edb468bc02d', 'd69ef21e-dce1-4cd4-bda3-76255fc92db3','f9e9779f-a491-4d55-90dd-4ff44d6ce4aa')
  order by  (sd.insertedon)  desc limit 1
) as closeddate,
ISR.reporteddate as reporteddate,
R.Assignedon as assigneddate ,
'' as finding,
(select rst.typedescription  from routingstatustype rst where rst.sequencenumber = R.routingstatustypeid) as status,
R.routingid,
(
  SELECT countyname from county c
  INNER JOIN caseassignment ca on c.countyid = ca.toldssid
  where ca.activeflag = 1 and ca.objectid = isr.intakeserviceid
  order by ca.enddate  desc NULLS FIRST LIMIT 1
) county
 
FROM  
intakeservicerequest as isr
JOIN
(
  SELECT DISTINCT objectid, routingid, cast(r.insertedon as timestamp) assignedon, tosecurityusersid, routingstatustypeid, activeflag
  FROM ROUTING R
  WHERE R.tosecurityusersid =  v_securityusersid::varchar    AND R.eventcode='APPL'
  AND CASE WHEN actionstatus = 'COMPLETED' THEN R.activeflag = 0 AND R.actiondatetime IS NOT NULL ELSE R.routingstatustypeid = 15 AND R.activeflag = 1 END
) R ON r.objectid::uuid = ISR.intakeserviceid
INNER JOIN  intakeservicerequestactor isra on isra.intakeserviceid= isr.intakeserviceid  
INNER JOIN person p on p.personid =  isra.personid  
WHERE isr.activeflag = 1 AND
(CASE WHEN v_servicerequestnumber IS NOT NULL THEN ISR.servicerequestnumber = trim(v_servicerequestnumber) ELSE TRUE END)

AND
/*(
  CASE WHEN v_focusname IS NOT NULL THEN
  replace(concat (coalesce(p.firstname,''),'',coalesce(p.middlename,''),'',coalesce(p.lastname,''),'',coalesce(p.suffix,'')), ' ','')
  ILIKE '%'|| COALESCE(replace(v_focusname,' ','') ,'')|| '%'  and isra.activeflag=1 and p.activeflag=1  and isra.intakeservicerequestpersontypekey ='AM'
  ELSE true
  END
)*/

(
  CASE WHEN v_focusname IS NOT NULL THEN
  replace((coalesce(p.firstname,'')||''||coalesce(p.middlename,'')||''||coalesce(p.lastname,'')||''||coalesce(p.suffix,'')), ' ','')
  ILIKE '%'|| COALESCE(replace(v_focusname,' ','') ,'')|| '%'  and isra.activeflag=1 and p.activeflag=1  and isra.intakeservicerequestpersontypekey ='AM'
  ELSE true
  END
)
group by ISR.intakeserviceid, ISR.reporteddate,R.Assignedon,r.routingstatustypeid,r.routingid
order by (
CASE sortorder
WHEN 'asc'
THEN
                         CASE sortcolumn
--                          WHEN 'classkey' THEN cast(casetype  as character varying)
                          WHEN 'reporteddate' THEN cast(ISR.reporteddate  as character varying)
                          WHEN 'assigneddate' THEN cast(R.Assignedon  as character varying)
                          WHEN 'status' THEN cast(r.routingstatustypeid  as character varying)
                          WHEN 'servicerequestnumber' THEN cast(ISR.servicerequestnumber  as character varying)
                          WHEN 'legalguardian' THEN
(select ((getcasepersonname) -> 0 ->> 'personname')  as legalguardian
from getcasepersonname ('servicerequest',isr.intakeserviceid::character varying)
)::character varying
/*
 cast((select COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'') as name
                                                          from intakeservicerequestactor isra
                                                          inner join person p on p.personid =  isra.personid
                                                          and isra.intakeserviceid= isr.intakeserviceid  
                                                          and isra.activeflag=1 and p.activeflag=1  and( isra.intakeservicerequestpersontypekey ='LG' or isra.isheadofhousehold=true) limit 1)  as character varying)
*/  
                          WHEN 'closeddate' THEN cast( (select coalesce(
                                                          (select r.insertedon from routing r
                                                          WHERE r.eventcode = 'INDR' AND r.objectid=sd.intakeservicerequestdispositioncodeid :: character varying and r.activeflag = 1 order by insertedon desc limit 1),
                                                          sd.statusdate,
                                                          sd.insertedon
                                                          ) from IntakeServiceRequestDispositionCode sd where IntakeServiceId= ISR.intakeserviceid and sd.servicerequesttypeconfigiddispostionid IN ('d90db0d3-f665-49db-b3ad-0edb468bc02d', 'd69ef21e-dce1-4cd4-bda3-76255fc92db3')
                                                        order by  (sd.insertedon)  desc limit 1)
                                                      as character varying)
              ELSE
                  cast(R.Assignedon  as character varying)
              END
              END) ASC NULLS LAST,
                (CASE sortorder
                  WHEN 'desc'
THEN
CASE sortcolumn
--                          WHEN 'classkey' THEN cast(casetype  as character varying)
                            WHEN 'reporteddate' THEN cast(ISR.reporteddate  as character varying)
                          WHEN 'assigneddate' THEN cast(R.Assignedon  as character varying)
                          WHEN 'status' THEN cast(r.routingstatustypeid  as character varying)
                            WHEN 'servicerequestnumber' THEN cast(ISR.servicerequestnumber  as character varying)
                          WHEN 'legalguardian' THEN
(select ((getcasepersonname) -> 0 ->> 'personname')  as legalguardian
from getcasepersonname ('servicerequest',isr.intakeserviceid::character varying)
)::character varying
/*
cast((select COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'') as name
                                                          from intakeservicerequestactor isra
                                                          inner join person p on p.personid =  isra.personid
                                                          and isra.intakeserviceid= isr.intakeserviceid  
                                                          and isra.activeflag=1 and p.activeflag=1  and( isra.intakeservicerequestpersontypekey ='LG' or isra.isheadofhousehold=true) limit 1 ) as character varying)
*/  
                          WHEN 'closeddate' THEN cast( (select coalesce(
                                                          (select r.insertedon from routing r
                                                          WHERE r.eventcode = 'INDR' AND r.objectid=sd.intakeservicerequestdispositioncodeid :: character varying and r.activeflag = 1 order by insertedon desc limit 1),
                                                          sd.statusdate,
                                                          sd.insertedon
                                                          ) from IntakeServiceRequestDispositionCode sd where IntakeServiceId= ISR.intakeserviceid and sd.servicerequesttypeconfigiddispostionid IN ('d90db0d3-f665-49db-b3ad-0edb468bc02d', 'd69ef21e-dce1-4cd4-bda3-76255fc92db3')
                                                        order by  (sd.insertedon)  desc limit 1)
                                                      as character varying)
              ELSE
                  cast(R.Assignedon  as character varying)
              END
                   END) DESC NULLS LAST
LIMIT  v_limit  OFFSET  v_offset
) AS appeal;

RETURN l_appeal;    

end if;


end;

$function$
;
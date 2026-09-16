-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review

DROP FUNCTION IF EXISTS cjams.getothercurrentmedication(psychotropicid character varying,personid character varying,objectid character varying);
CREATE OR REPLACE FUNCTION cjams.getothercurrentmedication(psychotropicid character varying,personid character varying,objectid character varying)
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_psychotropicid character varying;
v_result json;
v_personid character varying;
V_objectid character varying;

BEGIN

v_psychotropicid:=psychotropicid;
v_personid :=personid;
V_objectid :=objectid;

select json_agg(a) INTO  v_result from(
--select currentmedication as medication ,indication as indications,pc.psychotropicid,dosage,psycotrophicothercurrentmedicationid ,'psycotrophicprofile' as source 
--from cjams.psycotrophicothercurrentmedication pc
--where pc.psychotropicid=v_psychotropicid::uuid and activeflag =1
--
--union all


select distinct  pmp.medicationname as medication,pmp.dosage ,personmedicpshychotropicid,'personprofile' as source
from personmedicpshychotropic pmp
--left join cjams.psychotropicmedications pcm on pcm.personid =pmp.personid and pcm.activeflag =1
--inner join intakeservicerequestactor i on i.personid  = pmp.personid 
where activeflag =1 and pmp.personid  = v_personid::uuid and pmp.medicationexpirationdate is null 
--  AND (
--                 v_psychotropicid IS NULL 
--                 OR pmp.insertedon <= (
--                     SELECT R.insertedon 
--                     FROM routing R
--                     WHERE 
--                         R.objectid = v_psychotropicid 
--                         AND R.eventcode = 'PSY' 
--                         AND R.routingstatustypeid = 900 
--                     ORDER BY R.insertedon DESC 
--                     LIMIT 1
--                 )
--             )
--and (i.intakeserviceid = V_objectid::uuid or i.servicecaseid = V_objectid::uuid  )
)a;


RETURN v_result;
END;

$function$;
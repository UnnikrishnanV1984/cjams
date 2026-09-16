
--------------------------------------------------------------------------------------------------
-- 05/07/2025 prasanna sai kommineni - CIDM-10469 healthcare decision-maker record
-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.gethcdminfo( v_personid VARCHAR );
CREATE OR REPLACE FUNCTION cjams.gethcdminfo(v_personid VARCHAR )
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_result json;
v_intakeservreqcourtorderid uuid ;

BEGIN
select intakeservreqcourtorderid  into v_intakeservreqcourtorderid from intakeservreqcourtorder i
left join intakeservicerequestactor ia on ia.intakeservicerequestactorid = i.intakeservicerequestactorid 
where ia.personid =v_personid::uuid and ia.activeflag =1 and i.courtorderdate is not null
order by i.courtorderdate desc limit 1 ;

select json_agg(a) INTO  v_result from(

select healthcaredecisionmakerinformationid,objecttype,objectid,personid,healthcaredecisionmaker,otherhcdm,name,authorizedhcdm,
email,phonenumber,addressline1,addressline2,city,state,zip,hcdmflag from cjams.healthcaredecisionmakerinformation hc
where hc.personid=v_personid and hc.activeflag=1 and objectid=v_intakeservreqcourtorderid ::VARCHAR

)a;


RETURN v_result;
END;

$function$;
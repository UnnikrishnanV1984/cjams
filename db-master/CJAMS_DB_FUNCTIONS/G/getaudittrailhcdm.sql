
--------------------------------------------------------------------------------------------------
-- 06/10/2025 prasanna sai kommineni - CIDM-10469 healthcare decision-maker record
-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.getaudittrailhcdm(  v_intakeservreqcourtorderid VARCHAR );
CREATE OR REPLACE FUNCTION cjams.getaudittrailhcdm( v_intakeservreqcourtorderid VARCHAR)
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_result json;


BEGIN


select json_agg(a) INTO  v_result from(

select max(u.displayname) as updatedby ,max(hcdm.updatedon) as updatedon 
from healthcaredecisionmakerinformation_history hcdm
left join userprofile u on u.securityusersid =hcdm.updatedby 
where hcdm.objectid =v_intakeservreqcourtorderid ::VARCHAR and 
hcdm.objecttype ='courtorder'
group by hcdm.updatedon order by hcdm.updatedon desc

)a;


RETURN v_result;
END;

$function$;
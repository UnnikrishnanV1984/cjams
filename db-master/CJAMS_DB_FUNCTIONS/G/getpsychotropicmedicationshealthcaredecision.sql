DROP FUNCTION IF EXISTS cjams.getpsychotropicmedicationshealthcaredecision( v_personid VARCHAR );
DROP FUNCTION IF EXISTS cjams.getpsychotropicmedicationshealthcaredecision( v_personid VARCHAR  );
--------------------------------------------------------------------------------------------------
-- 05/07/2025 prasanna sai kommineni - CIDM-10469 healthcare decision-maker record
-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.getpsychotropicmedicationshealthcaredecision( v_personid VARCHAR );
CREATE OR REPLACE FUNCTION cjams.getpsychotropicmedicationshealthcaredecision(v_personid VARCHAR )
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_result json;

BEGIN

select json_agg(a) INTO  v_result from(
select  psy.* ,concat(p.firstname , p.lastname) as personname from psychotropicmedications psy
left join routing r on r.objectid  = psy.psychotropicid ::varchar 
left join person p on p.personid = psy.personid
where psy.personid =v_personid ::uuid and psy.activeflag=1 
and r.activeflag=1 and r.routingstatustypeid=16 order by r.insertedon desc 

)a;


RETURN v_result;
END;

$function$;
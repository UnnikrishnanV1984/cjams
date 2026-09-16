DROP FUNCTION IF EXISTS cjams.gethealthcaredecisionmakerinformation( v_objecttype VARCHAR,v_objectid VARCHAR, v_personid VARCHAR );
DROP FUNCTION IF EXISTS cjams.gethealthcaredecisionmakerinformation(v_objecttype VARCHAR,v_objectid VARCHAR, v_personid VARCHAR  );
--------------------------------------------------------------------------------------------------
-- 05/07/2025 prasanna sai kommineni - CIDM-10469 healthcare decision-maker record
-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.gethealthcaredecisionmakerinformation(v_objecttype VARCHAR,v_objectid VARCHAR, v_personid VARCHAR );
CREATE OR REPLACE FUNCTION cjams.gethealthcaredecisionmakerinformation(v_objecttype VARCHAR,v_objectid VARCHAR, v_personid VARCHAR )
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_result json;

BEGIN

select json_agg(a) INTO  v_result from(
select * from cjams.healthcaredecisionmakerinformation hc
where hc.objectid =v_objectid and hc.objecttype =v_objecttype and hc.activeflag=1

)a;


RETURN v_result;
END;

$function$;
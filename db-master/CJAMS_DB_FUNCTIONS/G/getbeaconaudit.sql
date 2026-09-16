-- 12/30/2023 prasanna sai kommineni 

DROP FUNCTION IF EXISTS cjams.getbeaconaudit(user_id character varying,startdate character varying,enddate character varying );
DROP FUNCTION IF EXISTS cjams.getbeaconaudit(startdate character varying,enddate character varying );
--------------------------------------------------------------------------------------------------
-- 03/31/2023 prasanna sai kommineni - CIDM-9736 BEACON Interface
--04/15/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface remove the insertedby from where and updated ssn
-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.getbeaconaudit(startdate character varying,enddate character varying, ssn character varying);
DROP FUNCTION IF EXISTS cjams.getbeaconaudit(startdate character varying,enddate character varying, ssn character varying,v_personid uuid);
CREATE OR REPLACE FUNCTION cjams.getbeaconaudit(v_startdate character varying DEFAULT NULL::character varying,v_enddate character varying DEFAULT NULL::character varying,v_ssn character varying DEFAULT NULL::character varying,v_personid uuid DEFAULT NULL::uuid)
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_result json;

BEGIN

select json_agg(a) INTO  v_result from(
select ba.*,up.fullname as viewby from beaconaudittrail ba
left join v_userprofile up on up.securityusersid= ba.insertedby
where   ba.activeflag=1 and (ba.ssn=v_ssn or ba.personid = v_personid)
 AND (
        (v_startdate IS NULL OR ba.insertedon::date >= v_startdate::date) -- Filter by startdate if provided
        AND (v_enddate IS NULL OR ba.insertedon::date <= v_enddate::date) -- Filter by enddate if provided
    )
order by ba.insertedon desc)a;


RETURN v_result;
END;

$function$;
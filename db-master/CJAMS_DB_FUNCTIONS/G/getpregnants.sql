DROP FUNCTION if exists cjams.getpregnants(v_pids uuid[]);
CREATE OR REPLACE FUNCTION cjams.getpregnants(v_pids uuid[])
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 07/12/2024 Amiya Pradhan - CIDM-9036 - B-195863 - Update Pregnancy Status After Delivery of Child
------------------------------------------------------------------------------------------------------------                                                                                
DECLARE  
v_pregnants json;
BEGIN 
SELECT json_agg(p) into v_pregnants FROM ( 
select concat (coalesce(firstname,null),' ', coalesce(middlename,null), ' ', coalesce(lastname,null), ' ',
coalesce(suffix,null), '(CJAMS PID:', cjamspid,')') as pregnant from person where personid::uuid in (
select distinct personid from personsexualinfo where personid = any(v_pids) 
and activeflag=1 
and ispregnant=true 
and pregnancyduedate is not null 
and date(pregnancyduedate) < current_date 
and current_date <= date(pregnancyduedate + INTERVAL '30 day') 
) 
) p;
RETURN v_pregnants;                     
END;
$function$
;
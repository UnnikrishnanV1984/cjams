-------------------------------------------------------------------------------------------------
-- 03/27/2025 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard

-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.getholidayslist();
CREATE OR REPLACE FUNCTION cjams.getholidayslist()
RETURNS JSON
 LANGUAGE plpgsql
AS $function$
declare 
v_result json;
BEGIN
 select json_agg(a) INTO  v_result from (SELECT year,description,date
               FROM cjams.holidays WHERE year = EXTRACT(YEAR FROM CURRENT_DATE)::TEXT
 order by date asc)a;
              return v_result;
--               WHERE current_day_start::date = holidays.date::date
END;
$function$
;
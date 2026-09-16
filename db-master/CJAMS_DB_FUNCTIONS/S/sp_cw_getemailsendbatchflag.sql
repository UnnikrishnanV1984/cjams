CREATE OR REPLACE FUNCTION cjams.sp_cw_getemailsendbatchflag()
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
/* 
-- 05/07/2026 - Raghavendra Puli - CIDM-11333: Investigation Case Closure Notifications on 45 day & 53 day.
*/
DECLARE
    v_settingvalue VARCHAR;
BEGIN

    SELECT s.settingvalue
    INTO v_settingvalue
    FROM cjams.settings s
    WHERE s.settingname = 'HP-Email-Send-Batch-Flag'
      AND s.activeflag = 1
    LIMIT 1;

    RETURN v_settingvalue;

END;
$function$
;

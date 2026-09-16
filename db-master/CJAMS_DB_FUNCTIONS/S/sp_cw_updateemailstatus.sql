CREATE OR REPLACE FUNCTION cjams.sp_cw_updateemailstatus(p_emailjavabatchnotifyid uuid, p_emailstatus integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
/* 
-- 05/07/2026 - Raghavendra Puli - CIDM-11333: Investigation Case Closure Notifications on 45 day & 53 day.
*/
BEGIN

    UPDATE cjams.emailjavabatchnotify
    SET
        emailstatus = p_emailstatus,
        updatedon = now(),
        updatedby = 'java_batch'
    WHERE emailjavabatchnotifyid = p_emailjavabatchnotifyid;

    return 'Success';

END;
$function$
;
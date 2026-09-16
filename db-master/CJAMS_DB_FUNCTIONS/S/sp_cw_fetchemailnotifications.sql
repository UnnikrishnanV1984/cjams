CREATE OR REPLACE FUNCTION cjams.sp_cw_fetchemailnotifications()
 RETURNS TABLE(emailjavabatchnotifyid uuid, objecttype character varying, objectid uuid, toemail character varying, subject text, body text)
 LANGUAGE plpgsql
AS $function$
/* 
-- 05/07/2026 - Raghavendra Puli - CIDM-11333: Investigation Case Closure Notifications on 45 day & 53 day.
*/
BEGIN
    RETURN QUERY
    SELECT 
        l.emailjavabatchnotifyid,
        l.objecttype,
        l.objectid,
        l.toemail,
        l.subject,
        l.body
    FROM cjams.emailjavabatchnotify l
    WHERE l.activeflag = 1
      AND (l.emailstatus IS NULL OR l.emailstatus = 0);
END;
$function$
;

CREATE OR REPLACE FUNCTION cjams.sp_cw_archiveanddeleteemail(p_emailjavabatchnotifyid uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
/* 
-- 05/07/2026 - Raghavendra Puli - CIDM-11333: Investigation Case Closure Notifications on 45 day & 53 day.
*/
BEGIN

    INSERT INTO cjams.emailjavabatchnotify_history
    (
        emailjavabatchnotifyid,
        objecttype,
        objectid,
        toemail,
        body,
        subject,
        response,
        responsestatus,
        insertedon,
        insertedby,
        updatedon,
        updatedby,
        emailstatus,
        activeflag
    )
    SELECT
        emailjavabatchnotifyid,
        objecttype,
        objectid,
        toemail,
        body,
        subject,
        response,
        responsestatus,
        insertedon,
        insertedby,
        updatedon,
        updatedby,
        emailstatus,
        activeflag
    FROM cjams.emailjavabatchnotify
    WHERE emailjavabatchnotifyid = p_emailjavabatchnotifyid;

    DELETE FROM cjams.emailjavabatchnotify
    WHERE emailjavabatchnotifyid = p_emailjavabatchnotifyid;

    return 'Success';

END;
$function$
;

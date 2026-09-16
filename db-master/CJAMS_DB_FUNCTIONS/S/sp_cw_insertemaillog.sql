CREATE OR REPLACE FUNCTION cjams.sp_cw_insertemaillog(p_emaillogsid uuid, p_objecttype character varying, p_objectid character varying, p_toemail character varying, p_body character varying, p_subject character varying, p_response character varying, p_responsestatus character varying, p_activeflag integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
/* 
-- 05/07/2026 - Raghavendra Puli - CIDM-11333: Investigation Case Closure Notifications on 45 day & 53 day.
*/
BEGIN

    INSERT INTO cjams.emaillogs
    (
        emaillogsid,
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
        activeflag
    )
    VALUES
    (
        p_emaillogsid,
        p_objecttype,
        p_objectid,
        p_toemail,
        p_body,
        p_subject,
        p_response,
        p_responsestatus,
        now(),
        'Java_batch',
        now(),
        'Java_batch',
        p_activeflag
    );

    return 'Success';

END;
$function$
;

DROP FUNCTION IF EXISTS cjams.getintakejsondata(uuid);
DROP FUNCTION IF EXISTS cjams.getintakejsondata(uuid, character varying, integer, integer);
DROP FUNCTION IF EXISTS cjams.getintakejsondata(uuid, character varying, integer, integer, integer);
DROP FUNCTION IF EXISTS cjams.getintakejsondata(uuid, integer, integer);
DROP FUNCTION IF EXISTS cjams.getintakejsondata(uuid, character varying, integer);
CREATE OR REPLACE FUNCTION cjams.getintakejsondata(
    v_intakeserviceid uuid,
    isExpungementSuperUser integer DEFAULT 0,
    isexpunged integer DEFAULT 0::integer
)
RETURNS TABLE(jsondata jsonb)
LANGUAGE plpgsql
AS $function$
DECLARE
    v_isexpunged integer;
BEGIN
    -- Get expungement status for this intake/case
	v_isexpunged = 0;
	IF isExpungementSuperUser = 1 THEN
		v_isexpunged = isexpunged;
	END IF;
	
    RAISE NOTICE 'getintakejsondata -> isExpungementSuperUser=%, v_isexpunged=%',
                 isExpungementSuperUser, v_isexpunged;

    ------------------------------------------------------------------------
    -- FULLY EXPUNGED: use only EXPUNGE tables 
    ------------------------------------------------------------------------
    IF v_isexpunged = 1 THEN
        RAISE NOTICE 'BLOCK: FULLY EXPUNGED';

        RETURN QUERY
        SELECT
           ids.jsondata::jsonb AS jsondata
        FROM expunge.intakeservicerequest_expunge isr
        INNER JOIN expunge.intakedastaging_expunge ids
            ON ids.intakenumber = isr.intakenumber
            AND ids.teamtypekey = 'CW'
        WHERE isr.activeflag = 1
          AND ids.activeflag = 1
          AND isr.intakeserviceid = v_intakeserviceid;

    ------------------------------------------------------------------------
    -- NORMAL: original logic 
    ------------------------------------------------------------------------
    ELSE
        RAISE NOTICE 'BLOCK: NORMAL';

        RETURN QUERY
        SELECT ids.jsondata
        FROM intakeservicerequest isr
        INNER JOIN intakedastaging ids
            ON ids.intakenumber = isr.intakenumber
           AND ids.teamtypekey = 'CW'
        WHERE isr.activeflag = 1
          AND ids.activeflag = 1
          AND isr.intakeserviceid = v_intakeserviceid;

    END IF;
END;
$function$;

CREATE OR REPLACE FUNCTION cjams.iscaseexpunged(v_objecttype character varying, v_objectid character varying)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_isexpunged integer;
BEGIN

    IF(v_objecttype = 'intake') Then 
        -- Fully expunged from intakedastatus
        SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
        INTO v_isexpunged
        FROM intakedastatus i
        WHERE i.intakenumber::text = v_objectid::text
        AND i.isexpunged = 1;
    ELSEIF (v_objecttype = 'Case') then
         -- Fully expunged from intakeservicerequest
        SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
        INTO v_isexpunged
        FROM intakeservicerequest i
        WHERE i.intakeserviceid::text = v_objectid::text
        AND i.isexpunged = 1;
        -- Fully expunged from expungementreport (type 'I')
        IF COALESCE(v_isexpunged, 0) = 0 THEN
            SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
            INTO v_isexpunged
            FROM expungementreport er
            WHERE er.intakeserviceid::text = v_objectid::text
            AND er.expungementtypekey = 'I';
        END IF;
        -- Partial expunged
        IF COALESCE(v_isexpunged, 0) = 0 THEN
            SELECT CASE WHEN COUNT(*) > 0 THEN 2 ELSE 0 END
            INTO v_isexpunged
            FROM expungementreport er
            WHERE er.intakeserviceid::text = v_objectid::text;
        END IF;
    End If;  

    IF v_isexpunged IS NULL THEN
        v_isexpunged := 0;
    END IF;

    RETURN v_isexpunged;
END;
$function$
;

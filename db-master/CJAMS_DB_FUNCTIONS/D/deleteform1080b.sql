DROP FUNCTION IF EXISTS cjams.deleteform1080b(v_formid uuid, v_userid character varying);
CREATE OR REPLACE FUNCTION cjams.deleteform1080b(v_formid uuid, v_userid character varying)
 RETURNS TABLE(message text, code integer)LANGUAGE plpgsql
AS $function$   
-------------------------------------------------------------------------
--  06/10/2025 - CIDM-10539 1080 Form B - Naveenkumar Chemutu 
--  09/16/2025 - CIDM-10473 - validation and exception handling - Simar Singh
-------------------------------------------------------------------------
DECLARE
    v_count integer;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM cjams.form1080b
    WHERE form1080bid = v_formid AND activeflag = 1;

    IF v_count = 0 THEN
        RETURN QUERY
        SELECT 'Form 1080b not found'::text, 404;
    ELSE
        UPDATE cjams.form1080b 
        SET 
            activeflag = 0,
            updatedby = v_userid,
            updatedon = now()
        WHERE form1080bid = v_formid;
        
        RETURN QUERY
        SELECT 'Form 1080b deleted successfully'::text, 200;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RETURN QUERY
        SELECT ('Error deleting Form 1080b: ' || SQLERRM)::text, 500;
END;
$function$;
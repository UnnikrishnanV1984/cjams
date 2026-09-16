
DROP FUNCTION IF EXISTS cjams.deleteform1080c(p_form1080cid uuid, p_userid character varying);
CREATE OR REPLACE FUNCTION cjams.deleteform1080c(
    p_form1080cid uuid,
    p_userid character varying
)
RETURNS TABLE(message text, code integer)
LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------
--  06-19-2025 - CIDM-10473 1080 Form C-Delete the form 1080c stored procedure - Anil Kumar Dharni 
-------------------------------------------------------------------------
DECLARE
    v_count integer;
BEGIN
    -- Check if record exists
    SELECT COUNT(*) INTO v_count
    FROM cjams.form1080c
    WHERE form1080cid = p_form1080cid AND activeflag = 1;
    
    IF v_count = 0 THEN
        RETURN QUERY
        SELECT 'Form 1080c not found'::text, 404;
    ELSE
        -- Soft delete by setting activeflag to 0
        UPDATE cjams.form1080c 
        SET 
            activeflag = 0,
            updatedby = p_userid,
            updatedon = now()
        WHERE form1080cid = p_form1080cid;
        
        RETURN QUERY
        SELECT 'Form 1080c deleted successfully'::text, 200;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN QUERY
        SELECT ('Error deleting Form 1080c: ' || SQLERRM)::text, 500;
END;
$function$;
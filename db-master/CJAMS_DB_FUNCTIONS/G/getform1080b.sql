DROP FUNCTION IF EXISTS cjams.getform1080b(jsonb);
CREATE OR REPLACE FUNCTION cjams.getform1080b(v_objectids jsonb)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------------------------------------
-- 07-01-2025 - Naveenkumar Chemutu - CIDM-10473 1080 Form B-Get all the form 1080b
-- 07-11-2025 - Naveenkumar Chemutu - CIDM-10473 Adding logic load all form1080 list including intake related records.
------------------------------------------------------------------------------------------------------

DECLARE
    _form1080blist JSON;
    _objectids TEXT[];
    
BEGIN
    
    IF v_objectids ? 'objectid' THEN
       SELECT array_agg(value::TEXT)
        INTO _objectids
        FROM jsonb_array_elements_text(
        CASE
            WHEN jsonb_typeof(v_objectids -> 'objectid') = 'array'
            THEN v_objectids -> 'objectid'
            ELSE jsonb_build_array(v_objectids -> 'objectid')
        END);
    END IF;    
        
    SELECT json_agg(e) INTO _form1080blist FROM (
        SELECT 
            cast((SELECT concat_ws(' ', firstname, lastname) FROM cjams.person p WHERE p.personid = frm1080b.personid::uuid) as character varying) as person,
            (SELECT displayname FROM cjams.userprofile u WHERE u.securityusersid = frm1080b.updatedby) as updatedbyuser,
            CASE WHEN frm1080b.status = 'Approved' THEN (
                SELECT  up.firstname || ' ' || up.lastname
                FROM cjams.userprofile up
                WHERE up.securityusersid = frm1080b.updatedby
                AND up.activeflag = 1 LIMIT 1
            ) ELSE null END as approvedby,
            
            -- Expanded columns from form1080b instead of *
            frm1080b.form1080bid,
            frm1080b.objectid,
            frm1080b.objecttype,
            frm1080b.casenumber,
            frm1080b.personid,
            frm1080b.provideasummaryoftheinvestigationandidentifyanybarriestheldss,
            frm1080b.whatisthemedicalexaminerspreliminaryfinding,
            frm1080b.signatureofpersoncompletingthisreport,
            frm1080b.datecompleted,
            frm1080b.submitforapproval,
            frm1080b.supervisorcomments,
            frm1080b.status,
            frm1080b.activeflag,
            frm1080b.insertedby,
            frm1080b.insertedon,
            frm1080b.updatedby,
            frm1080b.updatedon,
            frm1080b.copyofform1080b
            
        FROM cjams.form1080b frm1080b
        WHERE frm1080b.objectid = ANY(_objectids) AND frm1080b.activeflag = 1 
        ORDER BY frm1080b.insertedon DESC
    ) e;
    
    RETURN _form1080blist;
    
END;
$function$;
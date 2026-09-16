DROP FUNCTION IF EXISTS cjams.addorupdatefamilyfindings(json);

CREATE OR REPLACE FUNCTION cjams.addorupdatefamilyfindings(p_familyfinding json)
RETURNS boolean
LANGUAGE plpgsql
AS $function$
/*
    Adds a new family finding record or updates the existing one for a given cjamspid. If an active record exists, it moves the existing record to history and then inserts the new record.
    Revision(s):
    - 05/05/2026 - Yogeshvar - CIDM-11295: Initial creation of the function to handle add/update of family findings with history tracking.
*/
DECLARE
    v_binticasenumber varchar(25);
    v_cjamspid integer;
    v_securityusersid uuid;
    v_agencyid int8;
    v_existing_record cjams.bintifamilyfindings%ROWTYPE;
BEGIN
    v_binticasenumber := p_familyfinding->>'binticasenumber';
    v_cjamspid := (p_familyfinding->>'cjamspid')::integer;
    v_securityusersid := (p_familyfinding->>'caseworkerid')::uuid;
    v_agencyid := (p_familyfinding->>'caseworkeragencyid')::int8;

    RAISE NOTICE 'Starting addorupdatefamilyfindings for binticasenumber: %', v_binticasenumber;

    IF EXISTS (SELECT 1 FROM cjams.bintifamilyfindings WHERE cjamspid = v_cjamspid AND activeflag = 1) THEN
        RAISE NOTICE 'Existing active record found for cjamspid: %, moving to history and deleting from bintifamilyfindings.', v_cjamspid;
        INSERT INTO cjams.bintifamilyfindings_history (
            bintifamilyfindingsid, binticasenumber, binticasestartdate, binticaselastsearchdate, cjamspid, caseworkerid, caseworkeragencyid, externalapilogid, activeflag, insertedby, insertedon, updatedby, updatedon
        )
        SELECT 
            bintifamilyfindingsid, binticasenumber, binticasestartdate, binticaselastsearchdate, cjamspid, caseworkerid, caseworkeragencyid, externalapilogid, activeflag, insertedby, insertedon, updatedby, updatedon
        FROM cjams.bintifamilyfindings WHERE cjamspid = v_cjamspid AND activeflag = 1;
        UPDATE cjams.bintifamilyfindings SET activeflag = 0, updatedby = p_familyfinding->>'updatedby', updatedon = now() WHERE cjamspid = v_cjamspid AND activeflag = 1;
    ELSE
        RAISE NOTICE 'No existing active record found for binticasenumber: %, inserting new record.', v_binticasenumber;
    END IF;

    -- Insert new record
    RAISE NOTICE 'Inserting new record for binticasenumber: %', v_binticasenumber;
    INSERT INTO cjams.bintifamilyfindings (
        binticasenumber, binticasestartdate, binticaselastsearchdate, cjamspid, caseworkerid, caseworkeragencyid, externalapilogid, activeflag, insertedby, insertedon, updatedby, updatedon
    ) VALUES (
        v_binticasenumber,
        (p_familyfinding->>'binticasestartdate')::date,
        now(),
        v_cjamspid,
        v_securityusersid,
        v_agencyid,
        (p_familyfinding->>'externalapilogsid')::uuid,
        1,
        p_familyfinding->>'insertedby',
        now(),
        p_familyfinding->>'updatedby',
        now()
    );

    RAISE NOTICE 'Successfully inserted/updated bintifamilyfindings for binticasenumber: %', v_binticasenumber;
    RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Error in addorupdatefamilyfindings for binticasenumber: % - %', v_binticasenumber, SQLERRM;
    RETURN FALSE;
END;
$function$
;
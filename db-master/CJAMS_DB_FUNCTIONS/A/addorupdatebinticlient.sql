DROP FUNCTION IF EXISTS cjams.addorupdatebinticlient(json);

CREATE OR REPLACE FUNCTION cjams.addorupdatebinticlient(p_client json)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
/*
    Add or update a binti client record. If a record with the same cjamspid exists, it moves the existing record to history and then inserts the new record.
    Revision(s):
    - 05/05/2026 - Yogeshvar - CIDM-11295: Initial creation of the function to handle add/update of binti clients with history tracking.
*/
DECLARE
    v_cjamspid bigint;
    v_existing_record cjams.binticlients%ROWTYPE;
BEGIN
    v_cjamspid := (p_client->>'cjamspid')::bigint;

    RAISE NOTICE 'Starting addorupdatebinticlient for cjamspid: %', v_cjamspid;

    -- Move any existing records to history and update activeflag to 0
    IF EXISTS (SELECT 1 FROM cjams.binticlients WHERE cjamspid = v_cjamspid) THEN
        RAISE NOTICE 'Existing record found for cjamspid: %, moving to history and deleting from binticlients.', v_cjamspid;
        INSERT INTO cjams.binticlients_history (
            cjamspid, binti_clientid, firstname, lastname, dob, gender, county, activeflag, insertedby, insertedon, updatedby, updatedon, externalapilogsid
        )
        SELECT 
            cjamspid, binti_clientid, firstname, lastname, dob, gender, county, activeflag, insertedby, insertedon, updatedby, updatedon, externalapilogsid
        FROM cjams.binticlients WHERE cjamspid = v_cjamspid;
        UPDATE cjams.binticlients SET activeflag = 0, updatedby = p_client->>'updatedby', updatedon = now() WHERE cjamspid = v_cjamspid;
    ELSE
        RAISE NOTICE 'No existing record found for cjamspid: %, inserting new record.', v_cjamspid;
    END IF;

    -- Insert new record
    RAISE NOTICE 'Inserting new record for cjamspid: %', v_cjamspid;
    INSERT INTO cjams.binticlients (
        cjamspid, binti_clientid, firstname, lastname, dob, gender, county, insertedby, insertedon,
        updatedby, updatedon, externalapilogsid
    ) VALUES (
        v_cjamspid,
        p_client->>'binti_client_id',
        p_client->>'firstname',
        p_client->>'lastname',
        (p_client->>'dob')::date,
        p_client->>'gender',
        p_client->>'county',
        p_client->>'insertedby',
        now(),
        p_client->>'updatedby',
        now(),
        (p_client->>'externalapilogsid')::uuid
    );

    RAISE NOTICE 'Successfully inserted/updated binti_client for cjamspid: %', v_cjamspid;
    RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Error in addorupdatebinticlient for cjamspid: % - %', v_cjamspid, SQLERRM;
    RETURN FALSE;
END;
$function$
;
-- 10/28/2023 prasanna sai kommineni --
--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface

-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.addbeaconrequestdetails(beaconrequestdetails json);

CREATE OR REPLACE FUNCTION cjams.addbeaconrequestdetails(beaconrequestdetails json)
RETURNS JSON
LANGUAGE plpgsql
AS $function$
DECLARE
    v_beaconrequestdetails json;
    v_beaconrequestdetailsid uuid;
    v_sequence int;
    v_exists json;
    details jsonb := '[]'::jsonb;
BEGIN
    SELECT INTO v_sequence nextval('beacon_sourcetrackingid_Sequence');
    
    FOR v_beaconrequestdetails IN SELECT * FROM json_array_elements(beaconrequestdetails) LOOP
        SELECT json_build_object('ssn', br.ssn, 'requestedby', vu.fullname)
        INTO v_exists
        FROM cjams.beaconrequestdetails br
        LEFT JOIN v_userprofile vu ON vu.securityusersid = br.insertedby 
        WHERE br.personid = (v_beaconrequestdetails ->> 'personid')::uuid
        AND br.insertedon::date = NOW()::date;
IF v_exists IS NULL THEN
        IF (v_beaconrequestdetails ->> 'beaconrequestdetailsid') IS NOT NULL THEN
            UPDATE cjams.beaconrequestdetails
            SET
                caseobjecttype = v_beaconrequestdetails ->> 'caseobjecttype',
                caseobjectid = v_beaconrequestdetails ->> 'caseobjectid',
                personid = (v_beaconrequestdetails ->> 'personid')::uuid,
                ssn = v_beaconrequestdetails ->> 'ssn',
                updatedon = NOW(),
                sourcesystem ='CJAMS-CW',
                updatedby = v_beaconrequestdetails ->> 'user_id'
            WHERE beaconrequestdetailsid = (v_beaconrequestdetails ->> 'beaconrequestdetailsid')::uuid
            RETURNING beaconrequestdetailsid::uuid INTO v_beaconrequestdetailsid;
        ELSE
            INSERT INTO cjams.beaconrequestdetails (
                caseobjecttype, caseobjectid, personid, ssn,
                insertedon, insertedby, updatedon, updatedby,sourcetrackingid, activeflag
            ) VALUES (
                v_beaconrequestdetails ->> 'caseobjecttype',
                v_beaconrequestdetails ->> 'caseobjectid',
                (v_beaconrequestdetails ->> 'personid')::uuid,
                v_beaconrequestdetails ->> 'ssn',
                NOW(),
                v_beaconrequestdetails ->> 'user_id',
                NOW(),
                v_beaconrequestdetails ->> 'user_id',
                v_sequence,
                1
            ) RETURNING beaconrequestdetailsid::uuid INTO v_beaconrequestdetailsid;
        END IF;
       END IF;
        -- Add current detail to details array
        IF v_exists IS NOT NULL THEN
            details := details || jsonb_build_array(v_exists);
        END IF;
    END LOOP;
    
    RETURN json_build_object(
        'beaconrequestdetailsid', v_beaconrequestdetailsid,
        'sourcetrackingid', v_sequence,
        'existingdetails', details
    )::json;
END;
$function$
;
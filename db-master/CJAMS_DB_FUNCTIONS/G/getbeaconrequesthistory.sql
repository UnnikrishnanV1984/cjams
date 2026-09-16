--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface

-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.getbeaconrequesthistory(v_personid character varying);
CREATE OR REPLACE FUNCTION cjams.getbeaconrequesthistory(v_personid character varying)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
    v_result json;
BEGIN
    SELECT json_agg(a) INTO v_result
    FROM (
        SELECT brd.ssn,brd.insertedon,brd.caseobjecttype,brd.caseobjectid,brd.personid, p.cjamspid,p.cjamspid,p.firstname,p.middlename,p.lastname,p.gendertypekey,p.dob, up.displayname AS requestedby
        FROM cjams.beaconrequestdetails brd
        LEFT JOIN v_userprofile up ON up.securityusersid = brd.insertedby
        LEFT JOIN person p ON p.personid = brd.personid
        WHERE brd.personid = v_personid::uuid
    ) a;
    RETURN v_result;
END;
$function$;
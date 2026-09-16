--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface

-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.getbeaconrequestdetails(v_ssn text[], v_case text, v_requestby text);
CREATE OR REPLACE FUNCTION cjams.getbeaconrequestdetails(v_ssn text[], v_case text, v_requestby text)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_result json;
BEGIN
    -- Handle filtering by v_ssn only
    IF v_ssn IS NOT NULL AND v_case IS NULL AND v_requestby IS NULL THEN 
        SELECT json_agg(a) INTO v_result
        FROM (
            SELECT brd.ssn,brd.insertedon,brd.beaconrequestdetailsid,brd.sourcetrackingid,
             CASE 
        WHEN brd.caseobjecttype = 'servicecase' THEN 'SERVICE_CASE'
        WHEN brd.caseobjecttype = 'adoptioncase' THEN 'ADOPTION_CASE'
        ELSE brd.caseobjecttype 
    END AS caseobjecttype,
            brd.caseobjectid ,brd.personid, p.cjamspid,p.cjamspid,p.firstname,p.middlename,p.lastname,p.gendertypekey,p.dob, max(up.displayname) AS requestedby    
            FROM cjams.beaconrequestdetails brd
            LEFT JOIN v_userprofile up ON up.securityusersid = brd.insertedby
            LEFT JOIN person p ON p.personid = brd.personid
            WHERE brd.ssn = ANY (v_ssn)
            AND brd.activeflag = 1 
            GROUP BY brd.beaconrequestdetailsid, p.personid
            order by brd.insertedon desc 
        ) a;
    END IF;
    
    -- Handle filtering by v_case only
    IF v_case IS NOT NULL AND v_ssn IS NULL AND v_requestby IS NULL THEN
        SELECT json_agg(a) INTO v_result
        FROM (
            SELECT brd.ssn,brd.insertedon,brd.beaconrequestdetailsid,brd.sourcetrackingid,
            CASE 
        WHEN brd.caseobjecttype = 'servicecase' THEN 'SERVICE_CASE'
        WHEN brd.caseobjecttype = 'adoptioncase' THEN 'ADOPTION_CASE'
        ELSE brd.caseobjecttype 
    END AS caseobjecttype,
             brd.caseobjectid,brd.personid, p.cjamspid,p.cjamspid,p.firstname,p.middlename,p.lastname,p.gendertypekey,p.dob, up.displayname AS requestedby  
            FROM cjams.beaconrequestdetails brd
            LEFT JOIN v_userprofile up ON up.securityusersid = brd.insertedby
            LEFT JOIN person p ON p.personid = brd.personid AND p.activeflag = 1
            LEFT JOIN servicecase sc ON sc.servicecasenumber = v_case AND sc.activeflag = 1
            LEFT JOIN adoptioncase ac ON ac.adoptioncasenumber = v_case AND ac.activeflag = 1
            LEFT JOIN intakeservicerequest isr ON isr.servicerequestnumber = v_case AND isr.activeflag = 1
            WHERE brd.caseobjectid IN (sc.servicecaseid::character varying, ac.adoptioncaseid::character varying, isr.intakeserviceid::character varying)
            AND brd.activeflag = 1
            order by brd.insertedon desc
        ) a;
    END IF;

    -- Handle filtering by v_requestby only
    IF v_requestby IS NOT NULL AND v_case IS NULL AND v_ssn IS NULL THEN
        SELECT json_agg(a) INTO v_result
        FROM (
            SELECT brd.ssn,brd.insertedon,brd.beaconrequestdetailsid,brd.sourcetrackingid,
            CASE 
        WHEN brd.caseobjecttype = 'servicecase' THEN 'SERVICE_CASE'
        WHEN brd.caseobjecttype = 'adoptioncase' THEN 'ADOPTION_CASE'
        ELSE brd.caseobjecttype 
    END AS caseobjecttype,
            brd.caseobjectid,brd.personid, p.cjamspid,p.cjamspid,p.firstname,p.middlename,p.lastname,p.gendertypekey,p.dob, up.displayname AS requestedby    
            FROM cjams.beaconrequestdetails brd
            LEFT JOIN v_userprofile up ON up.securityusersid = brd.insertedby
            LEFT JOIN person p ON p.personid = brd.personid
            WHERE brd.insertedby::text = v_requestby
            AND brd.activeflag = 1
            order by brd.insertedon desc
        ) a;
    END IF;
    
    -- Combined case: Handle filtering by v_ssn and v_requestby
    IF v_ssn IS NOT NULL AND v_requestby IS NOT NULL THEN
        SELECT json_agg(a) INTO v_result
        FROM (
            SELECT brd.ssn,brd.insertedon,brd.beaconrequestdetailsid,brd.sourcetrackingid,
                  CASE 
        WHEN brd.caseobjecttype = 'servicecase' THEN 'SERVICE_CASE'
        WHEN brd.caseobjecttype = 'adoptioncase' THEN 'ADOPTION_CASE'
        ELSE brd.caseobjecttype 
    END AS caseobjecttype,
            brd.caseobjectid,brd.personid, p.cjamspid,p.cjamspid,p.firstname,p.middlename,p.lastname,p.gendertypekey,p.dob, max(up.displayname) AS requestedby    
            FROM cjams.beaconrequestdetails brd
            LEFT JOIN v_userprofile up ON up.securityusersid = brd.insertedby
            LEFT JOIN person p ON p.personid = brd.personid
            WHERE brd.ssn = ANY (v_ssn)
            AND ( brd.insertedby::text = v_requestby)
            AND brd.activeflag = 1 
            GROUP BY brd.beaconrequestdetailsid, p.personid
            order by brd.insertedon desc
        ) a;
    END IF;
    
    -- Combined case: Handle filtering by v_case and v_requestby
    IF v_case IS NOT NULL AND v_requestby IS NOT NULL THEN
        SELECT json_agg(a) INTO v_result
        FROM (
            SELECT brd.ssn,brd.insertedon,brd.beaconrequestdetailsid,brd.sourcetrackingid,
                  CASE 
        WHEN brd.caseobjecttype = 'servicecase' THEN 'SERVICE_CASE'
        WHEN brd.caseobjecttype = 'adoptioncase' THEN 'ADOPTION_CASE'
        ELSE brd.caseobjecttype 
    END AS caseobjecttype,
            brd.caseobjectid,brd.personid, p.cjamspid,p.cjamspid,p.firstname,p.middlename,p.lastname,p.gendertypekey,p.dob, up.displayname AS requestedby  
            FROM cjams.beaconrequestdetails brd
            LEFT JOIN v_userprofile up ON up.securityusersid = brd.insertedby
            LEFT JOIN person p ON p.personid = brd.personid AND p.activeflag = 1
            LEFT JOIN servicecase sc ON sc.servicecasenumber = v_case AND sc.activeflag = 1
            LEFT JOIN adoptioncase ac ON ac.adoptioncasenumber = v_case AND ac.activeflag = 1
            LEFT JOIN intakeservicerequest isr ON isr.servicerequestnumber = v_case AND isr.activeflag = 1
            WHERE brd.caseobjectid IN (sc.servicecaseid::character varying, ac.adoptioncaseid::character varying, isr.intakeserviceid::character varying)
            AND ( brd.insertedby::text = v_requestby)
            AND brd.activeflag = 1
            order by brd.insertedon desc
        ) a;
    END IF;

    RAISE NOTICE 'Result: %', v_result;

    RETURN v_result;
END;
$function$;
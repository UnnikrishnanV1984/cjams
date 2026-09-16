DROP FUNCTION IF EXISTS cjams.getcasenumberhealthpassport(caseworkerid character varying);


CREATE OR REPLACE FUNCTION cjams.getcasenumberhealthpassport(caseworkerid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------------
-- Function: getcasenumberhealthpassport
-- Description:
-- This function retrieves case numbers and related person details for a given caseworker.
-- It returns data in JSON format, including the case number, person name, other infomation,
-- and case-related information.

-- Revision(s)
-- CIDM-10298 Umasankar Raavi - getcasenumberhealthpassport function added 
-- CIDM-10298 Umasankar Raavi --Added suffix to the person full name 
-- CIDM-10298 Umasankar Raavi --Pulling roles data based on objecttypekey 

-------------------------------------------------------------------------------
DECLARE 
    v_caseworkerid character varying;
    v_result json;
BEGIN
    v_caseworkerid := caseworkerid;

    SELECT COALESCE(json_agg(a), '[]'::json) 
    INTO v_result 
    FROM (
        SELECT 
            COALESCE(s.servicecasenumber, isr.servicerequestnumber) AS casenumber,
            (p.firstname || ' ' || p.lastname || CASE WHEN p.suffix IS NOT NULL AND TRIM(p.suffix) <> '' THEN ' ' || p.suffix ELSE '' END) AS personname,
            p.cjamspid, 
            p.dob, 
            p.gendertypekey, 
            p.personid,
            MAX(c.objecttypekey) AS objecttypekey,
            c.objectid,
            (SELECT (firstname || ' ' || lastname) 
             FROM person 
             WHERE personid IN (
                SELECT personid FROM intakeservicerequestactor 
                WHERE (servicecaseid IN (c.objectid) OR intakeserviceid IN (c.objectid)) 
                AND activeflag = 1
                AND isheadofhousehold = TRUE 
                ORDER BY insertedon DESC LIMIT 1
             ) 
             ORDER BY insertedon DESC LIMIT 1) AS HOH,
            (SELECT ca.toldssid  
             FROM caseassignment ca  
             WHERE ca.toworkeridno = v_caseworkerid 
             AND LOWER(ca.responsibilitytypekey) = 'family' 
             AND ca.activeflag = 1 
             ORDER BY ca.insertedon DESC LIMIT 1) AS countyid,
            STRING_AGG(DISTINCT rfv.description, ', ') AS race,
            MAX(rf1.description) AS ethnicity,
            COALESCE(s.intakeservreqtypeid, isr.intakeservreqtypeid) AS intakeservreqtypeid,
            MAX(roledata.roles::text)::json AS roles

        FROM caseassignment c 
        LEFT JOIN intakeservicerequest isr ON (
            (c.objecttypekey = 'servicecase' AND isr.servicecaseid = c.objectid)
            OR
            (c.objecttypekey = 'servicerequest' AND isr.intakeserviceid = c.objectid)
        ) AND isr.activeflag = 1
        LEFT JOIN intakeservicerequestactor isa ON (
            (c.objecttypekey = 'servicecase' AND isa.servicecaseid = c.objectid)
            OR
            (c.objecttypekey = 'servicerequest' AND isa.intakeserviceid = c.objectid)
        ) AND isa.activeflag = 1
        LEFT JOIN servicecase s ON s.servicecaseid = c.objectid AND s.activeflag = 1 
        LEFT JOIN person p ON p.personid = isa.personid AND p.activeflag = 1
        LEFT JOIN racetype rt ON rt.racetypekey = p.racetypekey AND rt.activeflag = 1
        LEFT JOIN personracetypemap prt ON prt.personid = p.personid AND prt.activeflag = 1
        LEFT JOIN referencevalues rfv ON rfv.ref_key::character varying = prt.racetypekey::varchar AND rfv.activeflag = 1 AND rfv.referencetypeid = '171'
        LEFT JOIN referencevalues rf1 ON rf1.ref_key = p.ethnicgrouptypekey AND rf1.activeflag = 1 AND rf1.referencetypeid = '300'

        --  Roles join with corrected objecttypekey
        LEFT JOIN LATERAL (
            SELECT json_agg(e) AS roles 
            FROM (
                SELECT DISTINCT ON (isrpn.intakeservicerequestpersontypekey)
                    isrpn.intakeservicerequestpersontypekey,
                    rv.value_text AS typedescription
                FROM intakeservicerequestactor isrpn
                INNER JOIN actor a ON a.actorid = isrpn.actorid AND a.personid = p.personid
                INNER JOIN referencevalues rv ON rv.ref_key = isrpn.intakeservicerequestpersontypekey
                WHERE isrpn.activeflag = 1
                  AND rv.referencetypeid IN (175,176,358)
                  AND (
                      (c.objecttypekey = 'servicecase' AND isrpn.servicecaseid = s.servicecaseid)
                      OR
                      (c.objecttypekey = 'servicerequest' AND isrpn.intakeserviceid = isr.intakeserviceid)
                  )
                ORDER BY isrpn.intakeservicerequestpersontypekey, isrpn.insertedon DESC
            ) e
        ) AS roledata ON true

        WHERE c.toworkeridno = v_caseworkerid 
        AND c.activeflag = 1   
        AND COALESCE(s.servicecasenumber, isr.servicerequestnumber) IS NOT NULL
        AND COALESCE(c.statustypekey, '') NOT IN ('Closed') 
        AND c.enddate IS NULL 
        AND p.personid IS NOT NULL 
        GROUP BY p.personid, COALESCE(s.servicecasenumber, isr.servicerequestnumber), c.objectid, COALESCE(s.intakeservreqtypeid, isr.intakeservreqtypeid)
        ORDER BY personname ASC
    ) a;

    RETURN v_result;
END;
$function$;
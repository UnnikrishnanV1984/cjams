DROP FUNCTION IF EXISTS cjams.beaconssnsearch(searchdata json);
--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface

-----------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION cjams.beaconssnsearch(searchdata json)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
    result json;
    v_searchdata text[];
    v_result json;
BEGIN
    -- Extract the array of SSNs from the JSON input
    v_searchdata := array(select json_array_elements_text(searchdata -> 'ssn'));

    -- Select the records matching the SSNs and aggregate them into JSON
    SELECT json_agg(a) INTO v_result 
    FROM (
        SELECT
    p.personid,
    p.cjamspid,
    p.firstname,
    p.middlename,
    p.lastname,
    p.gendertypekey,
    p.dob,
    p.ssnno,
    COALESCE(
        (SELECT isa.servicecaseid FROM intakeservicerequestactor isa WHERE isa.personid = p.personid AND isa.activeflag = 1 and isa.servicecaseid is not null ORDER BY isa.insertedon LIMIT 1),
        (SELECT isa.intakeserviceid FROM intakeservicerequestactor isa WHERE isa.personid = p.personid AND isa.activeflag = 1 and isa.intakeserviceid is not null ORDER BY isa.insertedon  LIMIT 1),
        (SELECT aca.adoptioncaseid FROM adoptioncaseactor aca WHERE aca.personid = p.personid AND aca.activeflag = 1 and aca.adoptioncaseid is not null ORDER BY aca.insertedon  LIMIT 1)
    ) AS caseobjectid,
    CASE
        WHEN (SELECT isa.servicecaseid FROM intakeservicerequestactor isa WHERE isa.personid = p.personid AND isa.activeflag = 1 and isa.servicecaseid is not null  ORDER BY isa.insertedon LIMIT 1) IS NOT NULL THEN 'servicecase'
        WHEN (SELECT isa.intakeserviceid FROM intakeservicerequestactor isa WHERE isa.personid = p.personid AND isa.activeflag = 1 and isa.intakeserviceid is not null ORDER BY isa.insertedon  LIMIT 1) IS NOT NULL THEN 'servicerequest'
        WHEN (SELECT aca.adoptioncaseid FROM adoptioncaseactor aca WHERE aca.personid = p.personid AND aca.activeflag = 1 and aca.adoptioncaseid is not null ORDER BY aca.insertedon  LIMIT 1) IS NOT NULL THEN 'adoptioncase'
    END AS caseobjecttype
FROM
    cjams.person p
WHERE
    p.ssnno = ANY(v_searchdata)
    AND p.activeflag = 1
ORDER BY
    p.insertedon desc
    ) a;

    RETURN v_result;
END;
$function$;
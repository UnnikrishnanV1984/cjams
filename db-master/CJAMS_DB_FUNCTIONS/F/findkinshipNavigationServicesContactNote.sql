DROP FUNCTION IF EXISTS cjams.findkinshipNavigationServicesContactNote(inputJson json);

CREATE OR REPLACE FUNCTION cjams.findkinshipNavigationServicesContactNote(inputJson json)
RETURNS uuid
LANGUAGE plpgsql
AS $function$
DECLARE 
    v_intakeserviceid uuid;
    v_personid uuid;
    v_output uuid;

BEGIN
    -- Extract values from inputJson
    v_intakeserviceid := (inputJson ->> 'intakeserviceid')::uuid;
    v_personid := (inputJson ->> 'personid')::uuid;

    -- Query to find the required data
    SELECT a.personid INTO v_output
from (
SELECT coalesce(cp.intakeservicerequestactorid,(x.obj->>'intakeservicerequestactorid')::uuid) as intakeservicerequestactorid
FROM progressnote ps
   left JOIN Contactparticipant cp ON ps.progressnoteid = cp.progressnoteid  AND cp.activeflag = 1
    left join lateral
        json_array_elements((ps.focusperson ->> 'focuspersonjson')::json)  as x(obj)
        on true
WHERE ps.servicecaseid = v_intakeserviceid
    and ps.progressnotereasontypekey ilike '%KIN%'  
    AND ps.activeflag = 1 

union 

SELECT coalesce(cp.intakeservicerequestactorid,(x.obj->>'intakeservicerequestactorid')::uuid) as intakeservicerequestactorid
FROM progressnote ps
   left JOIN Contactparticipant cp ON ps.progressnoteid = cp.progressnoteid AND cp.activeflag = 1
    left join lateral
        json_array_elements((ps.focusperson ->> 'focuspersonjson')::json)  as x(obj)
        on true
WHERE ps.entitytypeid
            in (select intakenumber 
                    from intakeservicerequest 
                where servicecaseid=v_intakeserviceid 
                )
      and ps.progressnotereasontypekey ilike '%KIN%'  
      AND ps.activeflag = 1 
) as result
    LEFT JOIN intakeservicerequestactor a ON result.intakeservicerequestactorid = a.intakeservicerequestactorid AND a.activeflag = 1
    WHERE a.personid = v_personid AND a.activeflag = 1
    LIMIT 1;

    RETURN v_output;
END;
$function$
;
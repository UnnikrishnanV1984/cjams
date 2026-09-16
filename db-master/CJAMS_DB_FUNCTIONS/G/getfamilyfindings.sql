DROP FUNCTION IF EXISTS cjams.getfamilyfindings(uuid, int8, int8);

CREATE OR REPLACE FUNCTION cjams.getfamilyfindings(v_servicecaseid uuid, v_pagenumber bigint, v_pagesize bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_pageoffset int;
    l_childremoval json;
    l_totalcount int;
BEGIN
    -- Calculate the offset for pagination
    v_pageoffset := (v_pagenumber - 1) * v_pagesize;

    -- Get the total count of records
    SELECT COUNT(*) 
    INTO l_totalcount
    FROM Intakeservreqchildremoval irl
    JOIN servicecase sc ON sc.servicecaseid= irl.servicecaseid AND sc.activeflag = 1
    WHERE irl.activeflag = 1 AND irl.servicecaseid = v_servicecaseid;

    -- Fetch the paginated data
    SELECT json_agg(e) 
    INTO l_childremoval
    FROM (
                SELECT   
                        irl.intakeservreqchildremovalid,  
                        irl.intakeserviceid,   
                        irl.intakeservicerequestactorid,        
                        irl.removaldate,       
                        irl.removaltime, 
                        irl.exitdate,
                        irl.personid,
                        p.firstname,
                        p.lastname,
                        p.dob::date,
                        p.cjamspid,
                        bc.binti_clientid,
                        (SELECT gr.typedescription from gendertype gr where gr.gendertypekey  = p.gendertypekey limit 1) as gender,
                        (
                                SELECT rs.typedescription 
                                FROM routing r 
                                INNER JOIN routingstatustype rs 
                                        ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag = 1
                                WHERE r.objectid = irl.intakeservreqchildremovalid::character varying 
                                    AND r.activeflag = 1 
                                ORDER BY r.insertedon DESC 
                                LIMIT 1 
                        ) AS approvalstatus,
                        (
                                SELECT string_agg(DISTINCT at.value_text, ', ') 
                                FROM intakeservicerequestactor isrpn
                                INNER JOIN referencevalues at 
                                        ON at.ref_key = isrpn.intakeservicerequestpersontypekey
                                WHERE isrpn.servicecaseid = v_servicecaseid
                                    AND isrpn.activeflag = 1
                                    AND at.referencetypeid IN (176)
                                    and isrpn.personid = irl.personid
                                    AND COALESCE(at.teamtypekey, 'CW') = 'CW'
                                    AND isrpn.intakeservicerequestpersontypekey NOT IN ('AM')
                        ) AS roles,
                        bff.submittedon,
                        bff.submittedby,
                        bff.binticasenumber
                FROM Intakeservreqchildremoval irl 
                JOIN servicecase sc ON sc.servicecaseid = irl.servicecaseid AND sc.activeflag = 1 
                JOIN person p ON p.personid = irl.personid AND p.activeflag = 1
                LEFT JOIN cjams.binticlients bc ON bc.cjamspid = p.cjamspid and bc.activeflag = 1
                LEFT JOIN LATERAL (
                        SELECT 
                                bff.insertedon AS submittedon,
                                (select u.fullname from cjams.v_userprofile u where securityusersid = bff.insertedby limit 1) as submittedby,
                                bff.binticasenumber
                        FROM cjams.bintifamilyfindings bff
                        WHERE bff.cjamspid = p.cjamspid
                            AND bff.activeflag = 1
                        ORDER BY bff.insertedon DESC
                        LIMIT 1
                ) bff ON TRUE
        WHERE irl.activeflag = 1 
          AND irl.servicecaseid = v_servicecaseid
        ORDER BY irl.removaldate DESC
        LIMIT v_pagesize OFFSET v_pageoffset
    ) e;

    -- Return the result as JSON with data and total count
    RETURN json_build_object(
        'totalcount', l_totalcount,
        'data', l_childremoval
    );
END;
$function$
;

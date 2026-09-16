DROP FUNCTION IF EXISTS cjams.healthpassportcollateral(VARCHAR, CHARACTER VARYING);




CREATE OR REPLACE FUNCTION cjams.healthpassportcollateral(
    p_objectid VARCHAR, 
    p_objecttype CHARACTER VARYING
)
RETURNS JSON
LANGUAGE plpgsql
AS $function$
----------------------------------------------------------------------------
-- Function: healthpassportcollateral
-- Description:
-- This function retrieves collateral details and worker names related to a given case or intake.
-- It returns JSON data containing:
--   - A list of collaterals (individuals associated with the case/intake).
--   - A list of workers assigned to the case/intake.
-- The function filters based on `p_objectid` and `p_objecttype` parameters.

-- Revision(s)
-- CIDM-10298 Umasankar Raavi - healthpassportcollateral function added 
-- CIDM-10298 Umasankar Raavi - Getting Collateral roles from collateralroleconfig
-----------------------------------------------------------------------------

DECLARE 
    l_collateraldetails JSON;
    l_workerdetails JSON;
    l_persondetails JSON;
BEGIN
    -- Fetch Collateral Details
    SELECT json_agg(jsonb_build_object(
        'collateralid', col.collateralid,
        'fullname', concat_ws(' ', coalesce(col.prefixtypekey, NULL), coalesce(col.firstname, NULL), coalesce(col.middlename, NULL), coalesce(col.lastname, NULL), coalesce(col.suffixtypekey, NULL))::VARCHAR,
        'roles', (
            SELECT json_agg(roles) FROM (
                SELECT 
                    crc.collateralroleconfigid,
                    crc.collateralid,
                    crc.actortypekey,
                    rv.description
                FROM collateralroleconfig crc
                INNER JOIN referencevalues rv 
                    ON rv.ref_key = crc.actortypekey 
                    AND rv.referencetypeid = 175 
                    AND rv.activeflag = 1
                WHERE crc.collateralid = col.collateralid
                  AND crc.activeflag = 1
            ) roles
        )
    )) 
    INTO l_collateraldetails
    FROM collateral col 
    WHERE col.caseid::VARCHAR = p_objectid AND col.activeflag = 1;

    -- Fetch Person Details
    IF LOWER(p_objecttype) = 'servicecase' THEN
        SELECT COALESCE(json_agg(jsonb_build_object('fullname', p.fullname, 'roles', p.roles)), '[]'::json)
        INTO l_persondetails
        FROM (
            SELECT fullname, roles 
            FROM getpersonsbyservicecase(p_objectid::uuid, NULL::int, NULL::int)
        ) p;

    ELSIF LOWER(p_objecttype) = 'servicerequest' THEN
        SELECT COALESCE(json_agg(jsonb_build_object('fullname', p.fullname, 'roles', p.roles)), '[]'::json)
        INTO l_persondetails
        FROM (
            SELECT fullname, roles 
            FROM getpersonsbyinvestigationcw(NULL::int, NULL::int, p_objectid::uuid, NULL::varchar, NULL::varchar)
        ) p;
    ELSE
        l_persondetails := '[]'::json;
    END IF;

    IF l_persondetails IS NULL THEN
        l_persondetails := '[]'::json;
    END IF;

    -- Fetch Supervisor List with role and caseassignmentid
    SELECT json_agg(jsonb_build_object(
        'fullname', workername,
        'caseassignmentid', caseassignmentid,
        'roles', (
            SELECT json_agg(jsonb_build_object('role', role))
            FROM unnest(roles) AS role
        )
    ))
    INTO l_workerdetails
    FROM (
        SELECT 
            workername,
            array_agg(DISTINCT caseassignmentid) AS caseassignmentid,
            array_agg(DISTINCT role) AS roles
        FROM (
            SELECT 
                NULLIF(fromworkerdetails -> 0 ->> 'fromworkername', '[NULL]') AS workername,
                caseassignmentid,
                'Supervisor' AS role
            FROM cjams.getworkload(p_objectid::UUID)
            WHERE enddate IS NULL

            UNION ALL

            -- Caseworker role
            SELECT 
                NULLIF(toworkerdetails -> 0 ->> 'toworkername', '[NULL]') AS workername,
                caseassignmentid,
                'Caseworker' AS role
            FROM cjams.getworkload(p_objectid::UUID)
            WHERE enddate IS NULL
        ) AS raw
        WHERE workername IS NOT NULL
        GROUP BY workername
    ) AS worker_list;

    IF l_workerdetails IS NULL THEN
        l_workerdetails := '[]'::json;
    END IF;

    -- Final Return
    RETURN jsonb_build_object(
        'collateralList', l_collateraldetails,
        'workerList', l_workerdetails,
        'personList', l_persondetails
    );
END;
$function$; 
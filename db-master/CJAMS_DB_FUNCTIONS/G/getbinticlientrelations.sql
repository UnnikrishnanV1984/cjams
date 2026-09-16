DROP FUNCTION IF EXISTS cjams.getbinticlientrelations(int8, int8, int8);
DROP FUNCTION IF EXISTS cjams.getbinticlientrelations(int8, int8, int8, uuid);

CREATE OR REPLACE FUNCTION cjams.getbinticlientrelations(
  v_cjamspid bigint,
  v_pagenumber bigint,
  v_pagesize bigint,
  v_servicecaseid uuid DEFAULT NULL
)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
    v_pageoffset int;
    l_relationships json;
    l_totalcount int;
BEGIN
    v_pageoffset := (v_pagenumber - 1) * v_pagesize;

    WITH base_person AS (
        SELECT p.personid
        FROM person p
        WHERE p.activeflag = 1
          AND p.cjamspid = v_cjamspid
          AND (
            v_servicecaseid IS NULL
            OR EXISTS (
                SELECT 1
                FROM intakeservicerequestactor isa
                WHERE isa.personid = p.personid
                  AND isa.servicecaseid = v_servicecaseid
                  AND isa.activeflag = 1
            )
          )
        LIMIT 1
    ),
    ranked AS (
        SELECT
            ar.actorrelationshipid,
            ar.relationshiptypekey,
            COALESCE(rt.description, 'Unknown') AS relationshiptype,
            ar.person1id AS relative_personid,
            ar.updatedon,
            ROW_NUMBER() OVER (
                PARTITION BY ar.person1id
                ORDER BY ar.updatedon DESC, ar.actorrelationshipid DESC
            ) AS rn
        FROM actorrelationship ar
        JOIN base_person bp
          ON ar.person2id = bp.personid
        LEFT JOIN relationshiptype rt
          ON rt.relationshiptypekey = ar.relationshiptypekey
         AND rt.activeflag = 1
        WHERE ar.activeflag = 1
          AND (
            v_servicecaseid IS NULL
            OR ar.servicecaseid = v_servicecaseid
            OR EXISTS (
                SELECT 1
                FROM intakeservicerequestactor isa
                WHERE isa.intakeservicerequestactorid = ar.intakeservicerequestactorid
                  AND isa.servicecaseid = v_servicecaseid
                  AND isa.activeflag = 1
            )
          )
    )
    SELECT COUNT(*)
      INTO l_totalcount
      FROM ranked r
      JOIN person rp
        ON rp.personid = r.relative_personid
       AND rp.activeflag = 1
     WHERE r.rn = 1;

    WITH base_person AS (
        SELECT p.personid
        FROM person p
        WHERE p.activeflag = 1
          AND p.cjamspid = v_cjamspid
          AND (
            v_servicecaseid IS NULL
            OR EXISTS (
                SELECT 1
                FROM intakeservicerequestactor isa
                WHERE isa.personid = p.personid
                  AND isa.servicecaseid = v_servicecaseid
                  AND isa.activeflag = 1
            )
          )
        LIMIT 1
    ),
    ranked AS (
        SELECT
            ar.actorrelationshipid,
            ar.relationshiptypekey,
            COALESCE(rt.description, 'Unknown') AS relationshiptype,
            ar.person1id AS relative_personid,
            ar.updatedon,
            ROW_NUMBER() OVER (
                PARTITION BY ar.person1id
                ORDER BY ar.updatedon DESC, ar.actorrelationshipid DESC
            ) AS rn
        FROM actorrelationship ar
        JOIN base_person bp
          ON ar.person2id = bp.personid
        LEFT JOIN relationshiptype rt
          ON rt.relationshiptypekey = ar.relationshiptypekey
         AND rt.activeflag = 1
        WHERE ar.activeflag = 1
          AND (
            v_servicecaseid IS NULL
            OR ar.servicecaseid = v_servicecaseid
            OR EXISTS (
                SELECT 1
                FROM intakeservicerequestactor isa
                WHERE isa.intakeservicerequestactorid = ar.intakeservicerequestactorid
                  AND isa.servicecaseid = v_servicecaseid
                  AND isa.activeflag = 1
            )
          )
    )
    SELECT json_agg(e)
      INTO l_relationships
      FROM (
        SELECT
            r.actorrelationshipid,
            r.relationshiptypekey,
            r.relationshiptype,
          rp.personid AS relativepersonid,
          rp.personid AS relative_personid,
          rp.cjamspid AS relativecjamspid,
          rp.cjamspid AS relative_cjamspid,
            rp.firstname,
            rp.middlename,
            rp.lastname,
            rp.dob,
            rp.gendertypekey,
            r.updatedon,
          bc.binti_clientid AS childbinticlientid,
          bc.binti_clientid AS child_binti_clientid,
            bff.binticasenumber AS binti_case_number,
          bcr.bintikinshiprelationship,
          bcr.bintikinshiprelationship AS binti_kinship_relationship,
          bcr.bintilineagetype,
          bcr.bintilineagetype AS binti_lineage_type,
          bcr.bintirolelabel,
          bcr.bintirolelabel AS binti_role_label,
          bcr.bintisocialconnectionid,
          bcr.bintisocialconnectionid AS binti_social_connection_id,
            COALESCE(bcr.syncstatus, 'NOT_SYNCED') AS syncstatus,
            bcr.syncedon,
            CASE
                WHEN bcr.syncedby ~* '^[0-9a-fA-F-]{36}$' THEN (
                    SELECT u.fullname
                    FROM cjams.v_userprofile u
                    WHERE u.securityusersid::uuid = bcr.syncedby::uuid
                    LIMIT 1
                )
                ELSE bcr.syncedby
            END AS syncedby,
            CASE
                WHEN bc.binti_clientid IS NOT NULL AND bff.binticasenumber IS NOT NULL THEN 1
                ELSE 0
            END AS cansync
        FROM ranked r
        JOIN person rp
          ON rp.personid = r.relative_personid
         AND rp.activeflag = 1
        LEFT JOIN cjams.binticlients bc
          ON bc.cjamspid = v_cjamspid
         AND bc.activeflag = 1
        LEFT JOIN LATERAL (
            SELECT bff1.binticasenumber
            FROM cjams.bintifamilyfindings bff1
            WHERE bff1.cjamspid = v_cjamspid
              AND bff1.activeflag = 1
            ORDER BY bff1.insertedon DESC
            LIMIT 1
        ) bff ON true
        LEFT JOIN LATERAL (
            SELECT bcr1.*
            FROM cjams.binticlientrelations bcr1
            WHERE bcr1.childcjamspid = v_cjamspid
              AND bcr1.relativepersonid = rp.personid::uuid
              AND bcr1.relationshiptypekey = r.relationshiptypekey
              AND bcr1.activeflag = 1
            ORDER BY bcr1.insertedon DESC
            LIMIT 1
        ) bcr ON true
        WHERE r.rn = 1
        ORDER BY r.updatedon DESC
        LIMIT v_pagesize OFFSET v_pageoffset
    ) e;

    RETURN json_build_object(
        'totalcount', l_totalcount,
        'data', COALESCE(l_relationships, '[]'::json)
    );
END;
$function$
;

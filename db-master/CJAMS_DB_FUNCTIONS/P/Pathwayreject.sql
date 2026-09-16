
DROP FUNCTION IF EXISTS cjams.pathwayreject(uuid, uuid, uuid);

CREATE OR REPLACE FUNCTION cjams.pathwayreject(
    v_intakeserviceid UUID,
    v_sdmid UUID,
    v_supervisorid UUID
)
RETURNS TEXT
LANGUAGE plpgsql
AS $function$
-- 6/16/2025 - Umasankar Raavi - CIDM-10541: Simplified SDM rejection update

BEGIN
    -- Update person table
    UPDATE person
    SET dateofdeath = NULL,
        sdmpersonapprovalflag = 0,
        updatedby = v_supervisorid,
        updatedon = now()
    WHERE personid IN (
        SELECT personid
        FROM getpersonsbyinvestigation(v_intakeserviceid, 1, 100) AS gp
        WHERE EXISTS (
            SELECT 1
            FROM jsonb_array_elements(gp.roles::jsonb) AS elem
            WHERE elem->>'intakeservicerequestpersontypekey' IN ('AV', 'CHILD', 'OTHERCHILD')
        )
    )
    AND sdmpersonapprovalflag = 1
    AND (sdmpersonapprovalflag <> 0 OR dateofdeath IS NOT NULL);

    -- Update latest personauditlog row per AV/CHILD/OTHERCHILD role person
    WITH av_persons AS (
        SELECT personid
        FROM getpersonsbyinvestigation(v_intakeserviceid, 1, 100) AS gp
        WHERE EXISTS (
            SELECT 1
            FROM jsonb_array_elements(gp.roles::jsonb) AS elem
            WHERE elem->>'intakeservicerequestpersontypekey' IN ('AV', 'CHILD', 'OTHERCHILD')
        )
    ),
    latest_audit AS (
        SELECT DISTINCT ON (pal.personid)
            pal.personauditlogid
        FROM personauditlog pal
        JOIN av_persons ap ON ap.personid = pal.personid
        ORDER BY pal.personid, pal.insertedon DESC
    )
UPDATE personauditlog
SET personjson = jsonb_set(
                    jsonb_set(personjson::jsonb, '{sdmpersonapprovalflag}', '0', false),
                    '{dateofdeath}', 'null', false)::json
WHERE personauditlogid IN (SELECT personauditlogid FROM latest_audit);

    RETURN 'SUCCESS';
END;
$function$;
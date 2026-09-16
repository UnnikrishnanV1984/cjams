-- DROP FUNCTION if exists cjams.getsafecareplandetails( p_servicecaseid uuid, p_objecttypekey character varying);
DROP FUNCTION if exists cjams.getsafecareplandetails(p_servicecaseid uuid, p_objecttypekey character varying, p_person_ids character varying[]);
CREATE OR REPLACE FUNCTION cjams.getsafecareplandetails(p_servicecaseid uuid, p_objecttypekey character varying, p_person_ids character varying[])
 RETURNS TABLE(safecareplanid uuid, objectid character varying, objecttypekey character varying, safecaredate date, persondetails json, planparticipants json, healthneedsdetails json, otherservices json, planreviewdetails json, comments character varying, justification character varying, case_number character varying, consentform json, recommendedforclosure boolean, insufficientevidencetocourt boolean, familypreservationtransfer boolean, referredtocps boolean, shelterorder boolean, signatures json, approvalstatus character varying, updatedby uuid, updatedon timestamp without time zone, insertedby uuid, insertedon timestamp without time zone, activeflag integer, caseconnected integer, requestedby character varying, requestedon character varying, caseworkername character varying, routingstatus integer, plan_status text)
LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: prasanna sai kommineni
-- Date Created : 08/20/2025 
-- Stored Procedure to CIDM-10625

-- Revision(s)
-- 9/8/2025- Triveni - POSC user story for synchronization of POSC form in all related cases
-- 01/21/2026 - Vineet Tirodkar - To add consider active records only (activeflag = 1) - CIDM-10978
-- 02/17/2026 Vamshikri.byreddy - query tuning - CIDM-11127
------------------------------------------------------------------------  
BEGIN
    RETURN QUERY
    WITH svc_links AS (
        SELECT
            sc.servicecaseid,
            isr.intakeserviceid,
            isr.servicecaseid AS isr_servicecaseid
        FROM cjams.servicecase sc
        LEFT JOIN cjams.intakeservicerequest isr
               ON isr.servicecaseid = sc.servicecaseid
        WHERE sc.activeflag = 1
          AND (sc.servicecaseid = p_servicecaseid
               OR isr.intakeserviceid = p_servicecaseid)
    ),
    safecareplan_ids AS (
        SELECT DISTINCT ON (x.safecareplanid)
               x.safecareplanid,
               x.objectid,
               x.plan_status
        FROM (
            -- current
            SELECT
                scp.safecareplanid,
                scp.objectid,
                'current'::text AS plan_status,
                1 AS priority
            FROM cjams.safecareplan scp
            WHERE scp.objectid = p_servicecaseid::varchar
              AND scp.activeflag = 1

            UNION ALL

            -- connected
            SELECT
                scp.safecareplanid,
                scp.objectid,
                'connected'::text AS plan_status,
                2 AS priority
            FROM cjams.safecareplan scp
            JOIN svc_links sl
              ON scp.objectid IN (
                    sl.intakeserviceid::varchar,
                    sl.isr_servicecaseid::varchar
                 )
            WHERE scp.activeflag = 1

            UNION ALL

            -- other (by person)
            SELECT
                scp.safecareplanid,
                scp.objectid,
                'other'::text AS plan_status,
                3 AS priority
            FROM cjams.safecareplan scp
            WHERE scp.activeflag = 1
              AND EXISTS (
                    SELECT 1
                    FROM json_array_elements(scp.persondetails->'data') AS elem
                    WHERE elem->>'personid' = ANY (p_person_ids)
              )
        ) x
        ORDER BY x.safecareplanid, x.priority
    )
    SELECT 
        scp.safecareplanid,
        scp.objectid,
        scp.objecttypekey,
        scp.safecaredate,
        scp.persondetails,
        scp.planparticipants,
        scp.healthneedsdetails,
        scp.otherservices,
        scp.planreviewdetails,
        scp.comments,
        scp.justification,
        (
            SELECT CASE 
                     WHEN scp.objecttypekey = 'servicecase'
                          THEN sc.servicecasenumber
                     ELSE isr.servicerequestnumber
                   END
            FROM cjams.intakeservicerequest isr
            LEFT JOIN cjams.servicecase sc
                   ON isr.servicecaseid = sc.servicecaseid
            WHERE isr.intakeserviceid = scp.objectid::uuid
               OR isr.servicecaseid   = scp.objectid::uuid
            ORDER BY isr.insertedon DESC
            LIMIT 1
        ) AS case_number,
        scp.consentform,
        scp.recommendedforclosure,
        scp.insufficientevidencetocourt,
        scp.familypreservationtransfer,
        scp.referredtocps,
        scp.shelterorder,
        scp.signatures,
        scp.approvalstatus,
        scp.updatedby,
        scp.updatedon,
        scp.insertedby,
        scp.insertedon,
        scp.activeflag,
        0 AS caseconnected,
        (
            SELECT vu.fullname
            FROM v_userprofile vu
            WHERE vu.securityusersid = scp.updatedby::varchar
            LIMIT 1
        )::varchar AS requestedby,
        TO_CHAR(scp.updatedon, 'MM/DD/YYYY HH:MI AM')::varchar AS requestedon,
        (
            SELECT vu.fullname
            FROM v_userprofile vu
            WHERE vu.securityusersid = scp.insertedby::varchar
            LIMIT 1
        )::varchar AS caseworkername,
        (
            SELECT r.routingstatustypeid
            FROM routing r
            WHERE r.objectid   = scp.safecareplanid::varchar
              AND r.activeflag = 1
            ORDER BY r.insertedon DESC
            LIMIT 1
        ) AS routingstatus,
        scp_ids.plan_status
    FROM cjams.safecareplan scp
    JOIN safecareplan_ids scp_ids
      ON scp_ids.safecareplanid = scp.safecareplanid
    WHERE scp.activeflag = 1;
END;
$function$;

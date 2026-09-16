DROP FUNCTION IF EXISTS cjams.getfamilyfindingshistory(uuid, int8, int8);

CREATE OR REPLACE FUNCTION cjams.getfamilyfindingshistory(v_cjamspid bigint, v_pagenumber bigint, v_pagesize bigint)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
    v_pageoffset int;
    l_familyfindings json;
    l_totalcount int;
BEGIN
    v_pageoffset := (v_pagenumber - 1) * v_pagesize;

    SELECT COUNT(*)
    INTO l_totalcount
    FROM cjams.bintifamilyfindings_history bffh
    WHERE bffh.cjamspid = v_cjamspid
        and bffh.activeflag = 1;

    SELECT json_agg(e)
    INTO l_familyfindings
    FROM (
        SELECT
            bch.firstname,
            bch.lastname,
            bch.dob,
            bffh.cjamspid,
            bch.gender,
            bch.county,
            CASE
                WHEN bffh.binticasenumber IS NOT NULL THEN 'Submitted'
                ELSE 'Not Submitted'
            END AS familyfindingstatus,
            bffh.insertedon AS submitted_on,
            (
                SELECT u.fullname
                FROM cjams.v_userprofile u
                WHERE u.securityusersid = bffh.insertedby
                LIMIT 1
            ) AS submitted_by,
            COALESCE(bch.binti_clientid, bch.binti_clientid, bch.binti_clientid) AS binti_clientid,
            bffh.binticasenumber AS binti_case_number
        FROM cjams.bintifamilyfindings_history bffh
        LEFT JOIN LATERAL (
            SELECT bch1.*
            FROM cjams.binticlients_history bch1
            WHERE bch1.cjamspid = bffh.cjamspid
              AND bch1.activeflag = 1
              AND bch1.insertedon <= bffh.insertedon
            ORDER BY bch1.insertedon DESC
            LIMIT 1
        ) bch ON true
        WHERE bffh.cjamspid = v_cjamspid
          AND bffh.activeflag = 1
        ORDER BY bffh.insertedon DESC
        LIMIT v_pagesize OFFSET v_pageoffset
    ) e;

    RETURN json_build_object(
        'totalcount', l_totalcount,
        'data', COALESCE(l_familyfindings, '[]'::json)
    );
END;
$function$;
DROP FUNCTION IF EXISTS cjams.list_person_healthpassport_filter(request json, pagenumber bigint, pagesize bigint, sortcolumn character varying, sortorder character varying, v_nolimit boolean);

CREATE OR REPLACE FUNCTION cjams.list_person_healthpassport_filter(
    request json, 
    pagenumber bigint, 
    pagesize bigint, 
    sortcolumn character varying, 
    sortorder character varying, 
    v_nolimit boolean DEFAULT false  -- Correctly specifying the default value
)
RETURNS SETOF json
LANGUAGE plpgsql
AS $function$

-- 03/24/2025 Simar Singh -- CIDM-10103 add filter values for searching along with person id

DECLARE
   v_pageoffset   INT;
   v_pagenumber   INT;
   v_personid uuid;
   v_startDate timestamp;
   v_endDate timestamp;
BEGIN
   v_pagenumber := pagenumber - 1;
   v_pageoffset = v_pagenumber * pagesize;
v_startDate := (request ->> 'startDate')::timestamp;
v_endDate := (request ->> 'endDate')::timestamp;
v_personid := (request ->> 'personid')::uuid;

   IF COALESCE (pagesize, 0) < 1
   THEN
      pagesize := 10;
   END IF;

   IF COALESCE (pagenumber, 0) < 1
   THEN
      pagenumber := 1;
   END IF;

   RETURN QUERY
        SELECT COALESCE(json_agg(pe), '[]')::json FROM (
            SELECT COUNT (1) OVER (),
                PHI.personhealthpassportid,
                PHI.placementid,
                PHI.haspassportprovidedtocaregiver,
                PHI.effectivedate,
                PHI.insertedon,
                -- Add the COALESCE(l.primarycaregiver, rv.value_text) here
                COALESCE(l.primarycaregiver, rv.value_text) AS caregiver_info
            FROM personhealthpassport AS PHI
            INNER JOIN placement P on P.placementid = PHI.placementid and P.activeflag = 1
            -- Join the livingarrangement and referencevalues tables
            LEFT JOIN livingarrangement l ON l.placementid = PHI.placementid
            LEFT JOIN referencevalues rv ON rv.ref_key = l.livingarrangementtypekey and rv.referencetypeid = 76
            WHERE PHI.personid = v_personid AND PHI.activeflag = 1 	
            and case when v_startDate is not null then PHI.effectivedate >= v_startDate else true end
            and case when v_endDate is not null then PHI.effectivedate <= v_endDate + INTERVAL '1 day' else true end
            ORDER BY 
                (CASE sortorder
                    WHEN 'asc' THEN
                        CASE sortcolumn
                            WHEN 'createdon' THEN CAST(PHI.insertedon AS CHARACTER VARYING)
                            ELSE CAST(PHI.insertedon AS CHARACTER VARYING)
                        END
                END) ASC,
                (CASE sortorder
                    WHEN 'desc' THEN
                        CASE sortcolumn
                            WHEN 'createdon' THEN CAST(PHI.insertedon AS CHARACTER VARYING)
                            ELSE CAST(PHI.insertedon AS CHARACTER VARYING)
                        END
                END) DESC
            OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END
            LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
        ) pe;
END;
$function$;
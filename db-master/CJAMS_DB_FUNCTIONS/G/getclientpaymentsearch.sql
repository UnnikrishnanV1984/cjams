DROP FUNCTION IF EXISTS cjams.getclientpaymentsearch(json, bigint, bigint);

CREATE OR REPLACE FUNCTION cjams.getclientpaymentsearch(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, client_id bigint, client_name character varying, client_dob timestamp without time zone, ssn character varying, local_dept character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 05/28/2021 Vineet Tirodkar - Modifications to add the missing delete_sw in where clause of Payment tables (CDM-13300)
-- 01/31/2024 Sreekanth Marrikanti - Performance issue fixes (CIDM-8307)
-- 02/12/2026 Narendra -Performance improvements
------------------------------------------------------------------------------------------------------------	
DECLARE
	v_client_id bigint;
	v_pagenumber int;
	v_pageoffset int;
	v_DateFrom   TIMESTAMP(3);
	v_DateTo TIMESTAMP(3);
	v_ssn character varying;
	v_caseworker_name character varying;
	v_localdpt character varying;
	v_firstname character varying;
	v_lastname character varying;


BEGIN
	v_client_id := searchobj ->> 'clientid';
	v_DateFrom 	 := searchobj ->> 'daterangefrom';
	v_DateTo   := searchobj ->> 'daterangeto';
	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;
	v_ssn := searchobj ->> 'ssn';
	v_caseworker_name :=searchobj ->> 'caseworker_name';
	v_localdpt := searchobj ->> 'local_dept';
	v_firstname := searchobj ->> 'v_firstname';
	v_lastname := searchobj ->> 'v_lastname';


RETURN QUERY
    WITH filtered_persons AS (
        SELECT p.personid, p.cjamspid, p.firstname, p.lastname, p.middlename, p.dob
        FROM person p
        WHERE p.activeflag = 1
          AND (v_client_id IS NULL OR p.cjamspid = v_client_id)
          AND (v_ssn IS NULL OR p.ssnno = v_ssn)
          AND (v_firstname IS NULL OR (p.firstname ILIKE v_firstname || '%' OR soundex(p.firstname) = soundex(v_firstname)))
          AND (v_lastname IS NULL OR (p.lastname ILIKE v_lastname || '%' OR soundex(p.lastname) = soundex(v_lastname)))
    ),
    
  latest_payments AS (
        SELECT DISTINCT ON (tpd.client_id)
               tpd.payment_detail_id, 
               tpd.client_id, 
               tpd.county_cd,
               payhead.payment_dt
        FROM tb_payment_detail tpd
        JOIN tb_payment_header payhead ON payhead.payment_id = tpd.payment_id
        JOIN filtered_persons fp ON fp.cjamspid = tpd.client_id
        WHERE tpd.delete_sw = 'N' 
          AND payhead.delete_sw = 'N'
          AND (v_DateFrom IS NULL OR payhead.payment_dt >= v_DateFrom)
          AND (v_DateTo IS NULL OR payhead.payment_dt <= v_DateTo)
        ORDER BY tpd.client_id, tpd.payment_detail_id DESC
    )
   SELECT 
        COUNT(1) OVER() as totalcount,
        fp.cjamspid,
        INITCAP(TRIM(fp.firstname)||' '||TRIM(fp.lastname) || 
            CASE WHEN fp.middlename > '' THEN ', ' || TRIM(fp.middlename) ELSE '' END)::character varying,
        fp.dob,
        (SELECT pid.personidentifiervalue FROM personidentifier pid 
         WHERE pid.personidentifiertypekey = 'SSN' AND pid.personid = fp.personid AND pid.activeflag = 1 LIMIT 1)::character varying,
        c.countyname
    FROM filtered_persons fp
    JOIN latest_payments lp ON fp.cjamspid = lp.client_id
    LEFT JOIN county c ON c.statecountycode = lp.county_cd::character varying
    WHERE (v_localdpt IS NULL OR c.countyname ILIKE '%'||v_localdpt||'%')
    ORDER BY levenshtein((lower(CAST(INITCAP(TRIM(fp.firstname) || ' '||TRIM(fp.lastname) )as character varying))),(lower( trim(v_firstname) || ' ' || trim(v_lastname)  )),1,0,4)
     LIMIT v_liPageSize OFFSET v_pageoffset;

END;

$function$
;

DROP FUNCTION IF EXISTS fostercarecountdetails(character varying,text[],character varying,character varying,bigint,bigint,character varying,character varying,character varying,character varying,timestamp without time zone,character varying,character);
DROP FUNCTION IF EXISTS fostercareineligibledetails(character varying,text[],character varying,character varying,bigint,bigint,character varying,character varying,character varying,character varying,timestamp without time zone,character varying[],character varying,character varying);
CREATE OR REPLACE FUNCTION cjams.fostercareineligibledetails(userid character varying, v_status text[], v_roleid character varying, v_placementtype character varying, pagenumber bigint, pagesize bigint, fname character varying, lname character varying, clientiddata character varying, eligiblestatus character varying, rdate timestamp without time zone, todate timestamp without time zone, county character varying[], v_sortorder character varying, filtertype character varying DEFAULT NULL::character varying, assignedspecialist character varying DEFAULT NULL::character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

---------------------------------------------------------------------------------------
-- CIDM-10835 - Veera To get IVE Dashboard Count - 10/16/2025
--CIDM-11127 - Narendra - API Slowness and secondary node
---------------------------------------------------------------------------------------
 
DECLARE
    v_pageoffset int;
    v_pagenumber int;
    l_ivecasecount json;
    v_result json;
DECLARE 
    totalcount integer;
BEGIN
    v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;

--    DROP  TABLE  IF EXISTS tmp_table;
--	  CREATE TEMP TABLE tmp_table (clientid bigint);
--
--    INSERT into  tmp_table (clientid)  
--    select clientid from listiveplacement_nolimit_count(userid, v_status, v_roleid , v_placementtype,1,null,fname,lname,clientiddata,filtertype,rdate,todate,county,null, null, assignedspecialist);


if(filtertype = 'Ineligible') then

RAISE NOTICE '%','111111111111';
   WITH client_list AS (  
       select clientid from listiveplacement_nolimit_count(userid, v_status, v_roleid , v_placementtype,1,null,fname,lname,clientiddata,filtertype,rdate,todate,county,null, null, assignedspecialist)
)
    
   SELECT json_agg(a) INTO v_result 
FROM (
    SELECT 
        COUNT(*) FILTER (WHERE courtstatus = 'CRITERIA_FAILED') AS courtordercount,
        COUNT(*) FILTER (WHERE removalhome = 'CRITERIA_FAILED') AS removalhomecount,
        COUNT(*) FILTER (WHERE placement = 'CRITERIA_FAILED') AS placementcount,
        COUNT(*) FILTER (WHERE income = 'CRITERIA_FAILED') AS incomecount,
        COUNT(*) FILTER (WHERE deprivation = 'CRITERIA_FAILED') AS deprivationcount,
        COUNT(*) FILTER (WHERE assets = 'CRITERIA_FAILED') AS assetscount,
        COUNT(*) FILTER (WHERE demographic = 'CRITERIA_FAILED') AS demographiccount,
        COUNT(*) FILTER (WHERE removaltype = 'CRITERIA_FAILED') AS removaltypecount
    FROM tb_ive_fostercare_audit tifa
    JOIN tb_eligibility_period tep ON tep.eligibility_period_id = tifa.eligibility_period_id
    WHERE tep.delete_sw = 'N'
      AND tifa.cjamspid IN (SELECT clientid FROM client_list)
) a;
   

  else if(filtertype = 'Eligible Non-Reimbursable') then
   WITH client_list AS (  
       select clientid from listiveplacement_nolimit_count(userid, v_status, v_roleid , v_placementtype,1,null,fname,lname,clientiddata,filtertype,rdate,todate,county,null, null, assignedspecialist)
)

     SELECT json_agg(a) INTO v_result 
FROM (
    SELECT 
        COUNT(*) FILTER (WHERE tifa.courtstatus = 'CRITERIA_FAILED') AS courtordercount,
        COUNT(*) FILTER (WHERE tifa.placement = 'CRITERIA_FAILED') AS placementcount,
        COUNT(*) FILTER (WHERE tifa.demographic = 'CRITERIA_FAILED') AS demographiccount
    FROM tb_ive_fostercare_audit tifa
    INNER JOIN tb_eligibility_period tep 
        ON tep.eligibility_period_id = tifa.eligibility_period_id
    WHERE tep.delete_sw = 'N'
      AND tifa.cjamspid IN (SELECT clientid FROM client_list)
) a;


      end if;  

end if;

  Return v_result;
END;

$function$
;
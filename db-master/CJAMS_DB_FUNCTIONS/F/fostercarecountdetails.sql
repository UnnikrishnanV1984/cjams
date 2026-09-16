DROP FUNCTION IF EXISTS fostercarecountdetails(character varying,text[],character varying,character varying,bigint,bigint,character varying,character varying,character varying,character varying,timestamp without time zone,character varying,character);
DROP FUNCTION IF EXISTS fostercarecountdetails(character varying,text[],character varying,character varying,bigint,bigint,character varying,character varying,character varying,character varying,timestamp without time zone,character varying[],character varying,character varying);
CREATE OR REPLACE FUNCTION cjams.fostercarecountdetails(userid character varying, v_status text[], v_roleid character varying, v_placementtype character varying, pagenumber bigint, pagesize bigint, fname character varying, lname character varying, clientiddata character varying, eligiblestatus character varying, rdate timestamp without time zone, todate timestamp without time zone, county character varying[], v_sortorder character varying, assignedspecialist character varying DEFAULT NULL::character varying, filtertype character varying DEFAULT NULL::character varying, requestedtouser character varying DEFAULT NULL::character varying, requestedfromuser character varying DEFAULT NULL::character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

---------------------------------------------------------------------------------------
-- CIDM-10835 - Veera To get IVE Dashboard Count - 10/16/2025
-- CIDM-11127 - IVE Slowness issue fix - 02-11-2026
---------------------------------------------------------------------------------------
 
DECLARE
    v_pageoffset int;
    v_pagenumber int;
    l_ivecasecount json;
DECLARE 
    totalcount integer;
BEGIN
    v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;

RAISE NOTICE 'v_placementtype : %', v_placementtype ; 
if(v_placementtype = 'IVECCR') then
    select json_agg(a) INTO l_ivecasecount from ( select
           (select count(*) as unassignedcount from ive_caseclosure(null, null::integer, eligiblestatus::CHARACTER VARYING, v_roleid, null::CHARACTER VARYING, null::CHARACTER VARYING, 'assignment'::CHARACTER VARYING, userid, 1, null , county, null)
               where touserid is null)
    ) a;
else if(filtertype = 'Mytasks') then




    WITH tmp_table AS ( 
    select redet_status from sp_ive_alerts_mytasks_count_redet_status(userid,v_roleid)
    )

    select json_agg(a) INTO l_ivecasecount from ( select
           ( select count(*) as overduecount from tmp_table where redet_status <= 0 ),
           ( select count(*) as duecount from tmp_table where redet_status > 0 )       
    ) a;

else if(filtertype = 'Approvals') then

    WITH tmp_table AS (  
    select approval_status from getiveapprovallist(userid, v_roleid, 1, null, clientiddata::character varying, eligiblestatus, v_placementtype, requestedtouser, requestedfromuser)
    )

    select json_agg(a) INTO l_ivecasecount from ( select
           ( select count(*) as approvedcount from tmp_table where approval_status = 'APPROVED'),
           ( select count(*) as pendingcount from tmp_table where approval_status = 'PENDING'),
           ( select count(*) as rejectedcount from tmp_table where approval_status = 'REJECTED')      
    ) a;



else 

    WITH tmp_table AS ( 
    select assignedtouser, fostercareeligibilitystatus from listiveplacement_nolimit_count(userid, v_status, v_roleid , v_placementtype,1,null,fname,lname,clientiddata,eligiblestatus,rdate,todate,county,null, null, assignedspecialist)
)

SELECT json_agg(result) into l_ivecasecount FROM (
    SELECT
        CASE WHEN v_roleid in ('IVESP','IVEEA') 
                 AND (v_status::character varying = '{70}' 
                      OR v_status::character varying = '{67}' 
                      OR v_status::character varying = '{73}') 
            THEN
                json_build_object(
                    'unassignedcount', (SELECT count(*) FROM tmp_table WHERE assignedtouser is null),
                    'ineligibilecount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus = 'Ineligible'),
                    'enrcount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus = 'Eligible Non-Reimbursable'),
                    'ercount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus = 'Eligible Reimbursable'),
                    'unassignedcompletedcount', 0,
                    'assignedcompletedcount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus is not null AND fostercareeligibilitystatus not in ('Pending','Incomplete')),
                    'assignedpendingcount', (SELECT count(*) FROM tmp_table WHERE (fostercareeligibilitystatus is null OR fostercareeligibilitystatus in ('Pending','Incomplete'))),
                    'unassignedpendingcount', 0,
                    'pendingcount', (SELECT count(*) FROM tmp_table WHERE (fostercareeligibilitystatus is null OR fostercareeligibilitystatus in ('Pending','Incomplete')))
                )
            ELSE
                json_build_object(
                    'unassignedcount', (SELECT count(*) FROM tmp_table WHERE assignedtouser is null),
                    'ineligibilecount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus = 'Ineligible'),
                    'enrcount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus = 'Eligible Non-Reimbursable'),
                    'ercount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus = 'Eligible Reimbursable'),
                    'unassignedcompletedcount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus is not null AND fostercareeligibilitystatus not in ('Pending','Incomplete') AND assignedtouser is null),
                    'assignedcompletedcount', (SELECT count(*) FROM tmp_table WHERE fostercareeligibilitystatus is not null AND fostercareeligibilitystatus not in ('Pending','Incomplete') AND assignedtouser is not null),
                    'assignedpendingcount', (SELECT count(*) FROM tmp_table WHERE (fostercareeligibilitystatus is null OR fostercareeligibilitystatus in ('Pending','Incomplete')) AND assignedtouser is not null),
                    'unassignedpendingcount', (SELECT count(*) FROM tmp_table WHERE (fostercareeligibilitystatus is null OR fostercareeligibilitystatus in ('Pending','Incomplete')) AND assignedtouser is null),
                    'pendingcount', (SELECT count(*) FROM tmp_table WHERE (fostercareeligibilitystatus is null OR fostercareeligibilitystatus in ('Pending','Incomplete')))
                )
        END AS result
) a;
end if;

end if;
end if;

  Return l_ivecasecount;
END;

$function$
;
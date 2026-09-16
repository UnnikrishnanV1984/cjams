CREATE OR REPLACE FUNCTION cjams.sp_audit_log_change_history(v_screenid integer, v_lipagenumber bigint, v_lipagesize bigint, v_screen character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$


declare
	v_pagenumber int;
	v_pageoffset int;
	changehistory json;
	
BEGIN 
--	v_pagenumber := v_liPageNumber - 1;
--v_pageoffset := v_pagenumber * v_liPageSize;

IF v_screen = 'placement' THEN -- -- Placement Changes
SELECT json_agg(e) into changehistory from (
select * from sp_audit_log_placement_changes(v_screenid, v_lipagenumber, v_lipagesize)
)e;

ELSIF v_screen = 'gaprate' THEN -- GAP Rate changess
SELECT json_agg(e) into changehistory from (
select * from sp_audit_log_gaprate_changes(v_screenid, v_lipagenumber, v_lipagesize)
)e;

ELSIF v_screen = 'gapsuspension' THEN -- GAP Suspension changes
SELECT json_agg(e) into changehistory from (
select * from sp_audit_log_gapsuspension_changes(v_screenid, v_lipagenumber, v_lipagesize)
)e; 

ELSIF v_screen = 'adoptionrate' THEN -- Adoption Subsidy Rate changes
SELECT json_agg(e) into changehistory from (
select * from sp_audit_log_adoptionrate_changes(v_screenid, v_lipagenumber, v_lipagesize)
)e;

ELSIF v_screen = 'adoptionsuspension' THEN -- Adoption Subsidy Suspension changes
SELECT json_agg(e) into changehistory from (
select * from sp_audit_log_adoptionsuspension_changes(v_screenid, v_lipagenumber, v_lipagesize)
)e;

ELSIF v_screen = 'accountReceivable' THEN -- Receivable
SELECT json_agg(e) into changehistory from (
select * from sp_audit_log_change_history_account_receivable(v_screenid, v_lipagenumber, v_lipagesize)
)e;

END IF;
return changehistory;


 
END;


$function$
;

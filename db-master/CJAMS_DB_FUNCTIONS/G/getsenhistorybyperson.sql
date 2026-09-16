DROP FUNCTION IF EXISTS cjams.getsenhistorybyperson(uuid);
CREATE OR REPLACE FUNCTION cjams.getsenhistorybyperson(p_personid uuid)
 RETURNS TABLE(id uuid, senselectiondetailsid uuid, supervisorid uuid, personid uuid, requested_on timestamp without time zone, requested_by character varying, approved_by character varying, approved_on timestamp without time zone, sen_status boolean, approval_status character varying, reasons text[], other_reason text, actions text[], substance_classes text[], sencriteria character varying, sencriteriadesc character varying , birthinghospital character varying ,othersubstances text, requested_name character varying, approved_name character varying, denialreasonkey character varying, denialreasondesc character varying, objectid uuid, parentteamid uuid)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 05/21/2025 Anil Kumar Dharni - CIDM-10502 Deselect Flag - New proc to fetch the sen_audit history information for a given person
-- 08/27/2025 Sai Tejaswi - CDM-44488  SEN Uncheked Supervior
-- 01-06-2026 - Veera Nadimpalli -- CIDM-10982 - To save Sen Criteria Identification
-- 01-30-2026 - Sushma Bade -- CIDM-10982 -- othersubstances in Sen history
--------------------------------------------------------------------------------------------------------------
BEGIN
  RETURN QUERY
  SELECT 
    sh.senselectiondetailshistoryid,
    sh.senselectiondetailsid,
    r.tosecurityusersid::uuid as supervisorid,
    sh.personid,
    sh.requestedon,
    sh.requestedby,
    sh.approvedby,
    sh.approvedon,
    sh.senstatus,
    sh.approvalstatus,
    sh.reasons,
    sh.otherreason,
    sh.actions,
    sh.substanceclasses,
    sh.sencriteria,
    rv.value_text as sencriteriadesc,
    sh.birthinghospital,
    sh.othersubstances,
    upr.fullname as requested_name,
    upa.fullname as approved_name,
    sh.denialreasonkey,
    sh.denialreasondesc,
    sh.objectid,
    t.parentteamid
  FROM 
    senselectiondetails_history sh
    left join userprofile upr on upr.securityusersid = sh.requestedby
    left join userprofile upa on upa.securityusersid = sh.approvedby
    left join referencevalues rv on rv.ref_key = sh.sencriteria and rv.referencetypeid = 500710 and rv.activeflag = 1
    left join routing r on r.objectid::character varying = sh.senselectiondetailsid::character varying and sh.approvalstatus = 'Pending' and r.activeflag = 1
    left join teammemberassignment ta on r.tosecurityusersid = ta.securityusersid and ta.activeflag = 1
    left join teammember tm on tm.teammemberid = ta.teammemberid and tm.activeflag = 1
    left join team t on t.teamid = tm.teamid and t.activeflag = 1
    WHERE sh.personid::uuid = p_personid
  ORDER BY 
    sh.insertedon DESC;
END;
$function$
;
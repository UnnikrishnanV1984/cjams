--------------------------------------------------------------------------------------------------
-- 04/03/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard
-- 04/08/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard added teamid
-- 11/20/2025 Vinesh Puthan CDM-44596 Psychotropic Med Report filter by county issue fix
-----------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS cjams.getPsychotropiccwlistbycounty(countyid character varying);
DROP FUNCTION IF EXISTS cjams.getPsychotropiccwlistbycounty(countyid character varying,teamid character varying);
CREATE OR REPLACE FUNCTION cjams.getPsychotropiccwlistbycounty(countyid character varying,teamid character varying)
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_countyid character varying;
v_teamid character varying;
v_result json;

BEGIN

v_countyid:=countyid;
v_teamid :=teamid;
select json_agg(a) INTO  v_result from( select up.securityusersid, up.firstname, up.lastname, up.displayname, up.fullname,up.cjamspid  from userprofile up
LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
 where 
 up.teamtypekey ='CW' 
 AND (CASE WHEN v_countyid IS NOT NULL THEN t.countyid = v_countyid ELSE TRUE END)
 AND (CASE WHEN (v_teamid IS NOT NULL and v_teamid != '') THEN t.teamid = v_teamid::uuid ELSE true END)
 order by up.displayname ASC)a;


RETURN v_result;
END;

$function$;

DROP FUNCTION IF EXISTS cjams.getteam(v_securityuserid character varying);


CREATE OR REPLACE FUNCTION cjams.getteam(v_securityuserid character varying)
 RETURNS TABLE(id uuid, name character varying, countyid character varying, description text, parentteamid uuid, teamtypekey character varying, teamnumber character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE 
v_teamid uuid = null;
v_parentteamid uuid = null;
v_teamtypekey character varying ='';
 
BEGIN 

SELECT
	tm.teamid ,t.teamtypekey,t.parentteamid INTO v_teamid,v_teamtypekey,v_parentteamid
FROM teammemberassignment tma 
INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
INNER JOIN team t ON t.teamid = tm.teamid AND t.activeflag =1
WHERE tma.securityusersid = v_securityuserid AND tma.activeflag =1;

RETURN QUERY

SELECT t.teamid  ,  t.teamname ,
 t.countyid,  t.description, t.parentteamid, t.teamtypekey,
 t.teamnumber FROM team t WHERE  t.parentteamid =v_parentteamid AND  t.teamtypekey =  v_teamtypekey AND  t.activeflag =1;

END;

$function$
;

-- view to get user profile details

CREATE OR REPLACE VIEW v_userprofile AS
SELECT 
m.id userid, m.securityusersid, m.email, m.username, 
up.firstname, up.lastname, up.displayname, up.fullname, up.teamtypekey userteamtype, 
--up.supervisorid, 
CASE WHEN up.supervisorid is null OR up.supervisorid = '00000000-0000-0000-0000-000000000000' THEN 
	tm.supervisorid
ELSE 
	up.supervisorid
END AS supervisorid,
up.cjamspid,
cast(case coalesce(up.unavailableflag, false) when true then 'No' else 'Yes' end as character varying) useravailable,
tm.roletypekey, tm.loadnumber, tm.teammemberid,
tmrt.description, tmrt.isupervisor, tmrt.teamtypekey agency,
t.teamid, t.teamname, t.teamnumber, t.teamtypekey teamkey, t.parentteamid, 
t.description teamdescription, t.countyid::uuid,
(SELECT statecountycode FROM county WHERE activeflag = 1 AND countyid = t.countyid::uuid LIMIT 1) statecountycode,
(SELECT countyname FROM county WHERE activeflag = 1 AND countyid = t.countyid::uuid LIMIT 1) countyname
FROM muser m
INNER JOIN userprofile up ON m.securityusersid = up.securityusersid AND m.activeflag = 1 AND up.activeflag = 1
INNER JOIN teammemberassignment tma ON tma.securityusersid = up.securityusersid AND tma.activeflag = 1
INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag = 1
INNER JOIN teammemberroletype tmrt ON tmrt.roletypekey = tm.roletypekey AND tmrt.activeflag = 1
INNER JOIN team t ON t.teamid = tm.teamid AND tm.activeflag = 1 
WHERE (up.expirationdate IS NULL OR up.expirationdate >now() ) ;

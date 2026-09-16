/*
  Issue Description:CJAMS-63574-Request to Add Additional Team Names to SSA Sailpoint Profile
   Category/ Module  :  sail point
   Root cause: user requested to add new teams SSA Sailpoint Profile
   Fix provided: Data fix is done is add new teams SSA Sailpoint Profile
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'SSA Executive Leadership', '3828_46', 'CW', 'SSA Executive Leadership', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'SSA Offices of the Executive Director', '3828_47', 'CW', 'SSA Offices of the Executive Director', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'SSA Child and Familly Well Being', '3828_48', 'CW', 'SSA Child and Familly Well Being', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;


INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Prevention & Child Safety', '3828_49', 'CW', 'Prevention & Child Safety', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Out of Home Care', '3828_50', 'CW', 'Out of Home Care', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'ICPC/ICMA', '3828_51', 'CW', 'ICPC/ICMA', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Emerging Adults', '3828_52', 'CW', 'Emerging Adults', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;


INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Well Being & Clinical Services', '3828_53', 'CW', 'Well Being & Clinical Services', NULL, NULL, '71066c32-2942-4474-91be-55e9207ce4ed', 'CJAMS-63574', now(), 'CJAMS-63574', now(), now(), NULL, NULL, NULL, NULL,null, '71066c32-2942-4474-91be-55e9207ce4ed', NULL) on conflict do nothing;

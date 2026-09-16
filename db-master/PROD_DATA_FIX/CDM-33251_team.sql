/*
   Issue Description: CDM-33251
   Category/ Module  : User Management
   Root cause: User request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Extended Hours #5', '1429_EH5', 'CW', 'Extended Hours #5', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c', 'CDM-33251', now(), 'CDM-33251', now(), now(), NULL, NULL, NULL, NULL,null, '7665ca54-5374-4174-be07-a687b811a82c', NULL) on conflict do nothing;;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Extended Hours #6', '1429_EH6', 'CW', 'Extended Hours #6', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c', 'CDM-33251', now(), 'CDM-33251', now(), now(), NULL, NULL, NULL, NULL, null, '7665ca54-5374-4174-be07-a687b811a82c', NULL) on conflict do nothing;;

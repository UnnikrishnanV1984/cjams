/*
   Issue Description: CDM-39133
   Category/ Module  : User Management
   Root cause: User request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Extended Hours #7', '1429_EH7', 'CW', 'Extended Hours #7', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c', 'CDM-39133', now(), 'CDM-39133', now(), now(), NULL, NULL, NULL, NULL,null, '7665ca54-5374-4174-be07-a687b811a82c', NULL) on conflict do nothing;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Extended Hours #8', '1429_EH8', 'CW', 'Extended Hours #8', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c', 'CDM-39133', now(), 'CDM-39133', now(), now(), NULL, NULL, NULL, NULL, null, '7665ca54-5374-4174-be07-a687b811a82c', NULL) on conflict do nothing;

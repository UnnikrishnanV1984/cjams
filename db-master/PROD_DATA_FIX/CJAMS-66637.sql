/*
  Issue Description:CJAMS-66637-Request to Add Additional Team Names to SSA Sailpoint Profile
   Category/ Module  :  sail point
   Root cause: user requested to add new team to  SSA Sailpoint Profile
   Fix provided: Data fix is done is add new team to SSA Sailpoint Profile
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/




INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'FC Unit #5', '1448_40', 'CW', 'FC Unit #5', NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e', 'CJAMS-66637', now(), 'CJAMS-66637', now(), now(), NULL, NULL, NULL, NULL,null, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e', NULL) on conflict do nothing;



/*
  Issue Description: CDM-22598 Add Team Name
   Category/ Module  :  user management
   Root cause: CPS Unit 7 to the drop down under team name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'CPS Unit 7', '1449_15', 'CW', 'CPS Unit 7', NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CDM-22598', now(), 'CDM-22598', now(), now(), NULL, NULL, NULL, NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', NULL);


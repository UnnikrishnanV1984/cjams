 /*
  Issue Description: CDM-27514 DAM-13342 - SAILPOINT - continued issues with Employees' accounts information reverts back to past information
   Category/ Module  :  User management
   Root cause: New request
   Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

delete from team 
where parentteamid='1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b'
and teamname='SATP-CS';

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'SATP-CS', '1430_SATP-CS', 'CW', 'SATP-CS', NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CDM-27514', now(), 'CDM-27514', now(), now(), NULL, NULL, NULL, NULL, null, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', NULL);


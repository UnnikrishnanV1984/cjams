 /*
  Issue Description: CDM-32630
   Category/ Module  :  Additional Team Request
   Root cause:
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
delete from cjams.team where 
teamname='In Home Unit #9' and teamnumber='1434_In_Home_Unit_9' 
and countyid='817e0751-1fa8-4c31-8233-8fffd6426235' and activeflag=1;

INSERT INTO cjams.team
(activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(1, 'In Home Unit #9', '1434_In_Home_Unit_9', 'CW', '', NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235', 'CDM-32630', now(), 'CDM-32630', now(), now(), NULL, NULL, NULL, NULL, '', '817e0751-1fa8-4c31-8233-8fffd6426235', NULL);

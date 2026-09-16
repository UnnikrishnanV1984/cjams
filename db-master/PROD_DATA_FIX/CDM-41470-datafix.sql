/*
  Issue Description:  CDM-41470
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to insert add new team "CPS-Unit 8"
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'CPS-Unit 8', '1430_58', 'CW', 'CPS-Unit 8', NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CDM-41470', now(),'CDM-41470' , now(),now() , NULL, NULL, NULL, NULL,NULL , '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', NULL);

/*
  Issue Description: CDM-23390 workload issue/upgrade
   Category/ Module  :  user management
   Root cause: "Formal Kinship Care Unit 3" team needs to be added under "Baltimore County"
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

delete from cjams.team where teamname='Formal Kinship Care Unit 3' and  teamnumber='1430_57';
INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Formal Kinship Care Unit 3', '1430_57', 'CW', 'Formal Kinship Care Unit 3', null, null, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CDM-23390', now(), 'CDM-23390', now(), now(), null, null, null, null,null, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', null);

/*
  Issue Description:CJAMS-67130-Request to Add Additional Team Names to SSA Sailpoint Profile
   Category/ Module  :  sail point
   Root cause: user requested to add new teams SSA Sailpoint Profile
                     Application - Child Welfare 

                    County - Baltimore County

                    Update an exisiting team's Team Name from  STAT- Unit 1 to STAT TEAM 1

                    Add two new teams 

                    STAT- TEAM 2

                    Substance Exposed Newborn

   Fix provided: Data fix is done is add new teams SSA Sailpoint Profile
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update team
set teamname='STAT TEAM 1', description='STAT TEAM 1', updatedby='CJAMS-67130', updatedon=now()
where teamid='7f417c3f-e49a-4c46-b4a2-aa1ce54e5ceb' and activeflag = 1;


INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'STAT- TEAM 2', '1430_SU2', 'CW', 'STAT- TEAM 2', NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CJAMS-67130', now(), 'CJAMS-67130', now(), now(), NULL, NULL, NULL, NULL,null, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', NULL) on conflict do nothing;


INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Substance Exposed Newborn', '1430_SEN', 'CW', 'Substance Exposed Newborn', 
NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CJAMS-67130', now(), 'CJAMS-67130', now(), now(), NULL, NULL, NULL, NULL,null, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', NULL) on conflict do nothing;

/*
   Issue Description: CJAMS-20961 -Dual role not working in CJAMS
   Category/ Module  :  Staff management
   Root cause: user added the new role in as.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: teamtypekey='AS'
   teamid='57002c22-7e84-4406-a7dc-084e2fdf3a16'

*/


INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('636319d9-e3a4-49bf-af0d-711c9bb1bff8', 1, 'Services', '1441_CW2', 'CW', 'Services', '08:00:00', '16:00:00', '01511461-8e8f-4c60-85f7-7e8faa3a3266', 'CJAMS-20961', now(), 'CJAMS-20961', now(), now(), NULL, NULL, 0, NULL, NULL, '01511461-8e8f-4c60-85f7-7e8faa3a3266', NULL);

update userprofile set teamtypekey='CW', updatedby='CJAMS-20961',updatedon=now() where email = 'margaret.allen5@maryland.gov';

update teammember set teamid='636319d9-e3a4-49bf-af0d-711c9bb1bff8',updatedby='CJAMS-20961',updatedon=now()  where teammemberid='2bc2493e-1c01-481f-b482-71229d7fd21d' and teamid='57002c22-7e84-4406-a7dc-084e2fdf3a16';


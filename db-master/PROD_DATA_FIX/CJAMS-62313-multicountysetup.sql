/*
   Issue Description: CJAMS-62313
   Category/ Module  : User profile
   Description: Please assign Mallory Churchey (mallory.churchey1@maryland.gov) to each of the below counties in SailPoint. Mallory is the appeals coordinator for all 4 counties. Supervisors need the ability to assign Mallory to appeals cases. For each
                county - Supervisor & Team/Unit name
                Allegany Tracie Wilson Intake & CPS Administration
                Frederick Kristen Dunn LDSS Management
                Garrett Jessica Murray-Savage CPS Unit
                Washington Lindsey Sears CPS Program Manager
   Root cause: Mallory Churchey needs to be assigned to multi county. Data fix needed to run the script to provide multi county access. 
   Fix provided: Data fix needed add case worker role as primary and keep the case management role as secondary in user resource for the user elisha.smithwickbey@maryland.gov 
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint role integration issue and data fix is needed to resolve it. 
*/
-- Please run createmulticountyuser proc before running this sql
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Allegany' and activeflag = 1) and teamname = 'Intake & CPS Administration';
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Garrett' and activeflag = 1) and teamname = 'CPS unit';
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Frederick' and activeflag = 1) and teamname = 'LDSS Management';
--  select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Washington' and activeflag = 1) and teamname = 'CPS Program Manager';
-- Allegany
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'tracie.wilson@maryland.gov','1427_8','CJAMS-62313');
-- Garrett
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'jessica.savage@maryland.gov','1438_2','CJAMS-62313');
-- Federick County
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'kelly.glotfelty@maryland.gov','1437_10','CJAMS-62313');
-- Washington
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'lindsey.sears@maryland.gov','1448_38','CJAMS-62313');

update teammemberassignment
set activeflag = 0, updatedby= 'CJAMS-62313',updatedon = now()
where teammemberassignmentid in ('8dc711f3-409c-4fb2-8e0c-a56fd03704d9','1090a9db-74e8-4eec-a938-db669c13f506','2f08d794-70dc-4e23-95f3-75652db26352','e3b2fb9f-af55-4011-aa59-d8b40b3d1d23') and securityusersid = '8b7692be-2fbc-49fd-9dce-78666f986886';

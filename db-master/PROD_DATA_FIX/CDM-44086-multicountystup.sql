/*
   Issue Description: CDM-44086
   Category/ Module  : User profile
   Root cause: Tri-county user needs added
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Please run createmulticountyuser proc before running this sql
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Allegany' and activeflag = 1) and teamname = 'Intake & CPS Administration';
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Garrett' and activeflag = 1) and teamname = 'CPS unit';
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Frederick' and activeflag = 1) and teamname = 'LDSS Management';
--  select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Washington' and activeflag = 1) and teamname = 'CPS Program Manager';
update teammemberassignment
set activeflag = 0, updatedby= 'CDM-44086',updatedon = now()
where teammemberassignmentid in ('05b4efa1-3adc-4641-a608-b8d1dc028cab','76c5b0ed-eb54-40d7-b706-03892c5ef6e1','43b121d1-e4da-4def-b97c-ab25219e4b89') and securityusersid = '8b7692be-2fbc-49fd-9dce-78666f986886';
-- Allegany
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'tracie.wilson@maryland.gov','1427_8','CDM-44086');
-- Garrett
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'jessica.savage@maryland.gov','1438_2','CDM-44086');
-- Federick County
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'kelly.glotfelty@maryland.gov','1437_10','CDM-44086');
-- Washington
-- select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'lindsey.sears@maryland.gov','1448_38','CDM-44086');
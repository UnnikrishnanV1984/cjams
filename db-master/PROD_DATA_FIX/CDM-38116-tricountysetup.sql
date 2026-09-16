/*
   Issue Description: CDM-38116
   Category/ Module  : User profile
   Root cause: Tri-county user needs added
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Please run createmulticountyuser proc before running this sql
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Allegany' and activeflag = 1) and teamname = 'Intake & CPS Administration';
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Garrett' and activeflag = 1) and teamname = 'CPS unit';

select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'tracie.wilson@maryland.gov','1427_8','CDM-38116');
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'lisa.naumann3@maryland.gov','1438_2','CDM-38116');
-- CDM-38115 Federick County
select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'kristen.dunn@maryland.gov','1437_10','CDM-38115');
-- select * from cjams.createmulticountyuser('mallory.churchey1@maryland.gov', 'andranese.carter@maryland.gov','1448_24','CDM-38116');
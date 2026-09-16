
/*
Issue: CJAMS-68052 Removal End Date incorrect
Category/Module: screen out referral
Root cause: Please carry out data fix to 1. Update the Child Removal End Date as 03/30/2026 instead of 04/03/2026. 2. Update the Program Assignment End Date as 03/30/2026 instead of 04/03/2026 3. Update the Placement End Date as 03/30/2026 12 PM 
Fix provided:  Data fix is done to  1. Update the Child Removal End Date as 03/30/2026 instead of 04/03/2026. 2. Update the Program Assignment End Date as 03/30/2026 instead of 04/03/2026 3. Update the Placement End Date as 03/30/2026 12 PM 
Data/Code fix ticket#: CJAMS-68052
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix
*/
update intakeservreqchildremoval
set exitdate = '2026-03-30 12:00:00', updatedon = now(), updatedby = 'CJAMS-68052'
where intakeservreqchildremovalid='2a921c32-43c7-42ae-8ddb-e4d0ad0c1ad1' and activeflag=1;


update personprogramarea
set enddate = '2026-03-30 00:00:00', updatedon = now(), updatedby = 'CJAMS-68052' where personprogramid='ac2e5515-1998-4092-a840-d772065064d3' and activeflag=1;



update placementrevision
set exitdate='2026-03-30 00:00:00', updatedon = now(), updatedby = 'CJAMS-68052'
where placementrevisionid='f1c63ed2-ad30-4b6c-9eac-ad865a0b4449';


update placement
set enddatetime='2026-03-30 00:00:00', updatedon = now(), updatedby = 'CJAMS-68052'
where placementid='243d5a28-82c6-4a6d-af8d-45e8c23fce55';

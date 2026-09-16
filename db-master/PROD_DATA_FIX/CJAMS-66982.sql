/*
Issue Description: CJAMS-66982-FC Unit #5
Category/Module: Workload 
Root cause: User requested to update FC Unit #5 to FC/Adoption Unit 5 to algin with other out of home units
Fix provided: Data fix has been done to update the team name from FC Unit #5 to FC/Adoption Unit 5
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/





update team 
set teamname='FC/Adoption Unit 5',
updatedby='CJAMS-66982',
updatedon=now()
where teamid='b76ac0d0-238c-438e-bbd8-4423389195a6' and activeflag=1;
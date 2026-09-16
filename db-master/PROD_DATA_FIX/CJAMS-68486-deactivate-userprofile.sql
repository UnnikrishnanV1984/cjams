/*
Issue: Remove former Assignee's name
Category/Module: User Profile
Root cause: Root cause: User requested to deactivate the user in cjams db.
Fix provided: Fix provided: DB query to deactivate the user in all relevant user tables from the backend by setting activeflag = 0. This action will also effectively remove them from the assignee lists/workload units.
Data/Code fix ticket#: CJAMS-68486
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix only, affecting specific user records in the database.
*/


update userprofile 
set activeflag = 0, updatedby = 'CJAMS-68486', updatedon = now()
where securityusersid='2733e86b-62ec-477f-a642-b6d7c4ccd9dc' and activeflag=1;

update muser 
set activeflag = 0, updatedby = 'CJAMS-68486', updatedon = now()
where securityusersid='2733e86b-62ec-477f-a642-b6d7c4ccd9dc' and activeflag=1;

update cjams.securityusers 
set activeflag=0, updatedby='CJAMS-68486', updatedon=now()  
where securityusersid='2733e86b-62ec-477f-a642-b6d7c4ccd9dc' and activeflag=1;

update cjams.teammemberassignment 
set activeflag=0, updatedby='CJAMS-68486', updatedon=now() 
where securityusersid='2733e86b-62ec-477f-a642-b6d7c4ccd9dc' and activeflag = 1;

update teammember 
set activeflag =0,updatedby='CJAMS-68486', updatedon=now() 
where teammemberid='f8e0ed6a-7ad6-4570-8179-fa5fc7209e48' and activeflag =1;

update rolemapping 
set activeflag = 0, updatedby = 'CJAMS-68486', updatedon = now() 
where principalid='78046' and activeflag = 1;

update userprofilephonenumber
set activeflag=0, updatedby = 'CJAMS-68486', updatedon = now() 
where securityusersid='2733e86b-62ec-477f-a642-b6d7c4ccd9dc' and activeflag=1;
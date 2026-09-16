/*
Issue Description:CJAMS-61037 Adoption Date Grayed Out
Category/Module: Person Profile 
Root cause: This is an old migrated Case and adoption date is not available for the person with PID# 1406000.
            Data fix needs to be done to update the adoption date as 10/05/2006
Fix provided: Data fix has been done to update the previous adoption date as  10/05/2006
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:N/A
Reason why no related code fix: This is a migration issue and data was missing for previous adoption date
*/

update person 
set preadoptiondate = '2006-10-05',
    updatedby = 'CJAMS-61037', 
    updatedon = now()
where personid = '25b90b7f-5a45-4058-b0fc-d7060aed6744' 
and activeflag=1;
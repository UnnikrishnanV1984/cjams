/*
Issue Description:CJAMS-61334 Adoption Date Grayed Out
Category/Module: Person Profile 
Root cause: This is an old migrated Case and adoption date is not available for the person with PID# 1278025.
            Data fix needs to be done to update the adoption date as 2003-05-14
Fix provided: Data fix has been done to update the previous adoption date as  2003-05-14
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:N/A
Reason why no related code fix: This is a migration issue and data was missing for previous adoption date
*/

update person 
set preadoptiondate = '2003-05-14',
    updatedby = 'CJAMS-61334', 
    updatedon = now()
where personid = 'df87eeb4-ef1c-4349-affa-4319b269c79a' 
and activeflag=1;
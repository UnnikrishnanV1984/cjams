/* 
Root Cause: This data fix is to activate counties that go live for motivation user story CIDM-11321.
Fix Provided: Data fix has been done to make the Allegany, Washigton and Garret County active for Motivational interview.
Code Fix: Not Required
Regression Impacts : Motivational Interview Feature
Is Code fix needed : No
Reason why no code fix: This is a configuration change made in countygoliveconfig table.
*/ 

update cjams.countygoliveconfig  
set garrett = now(),
    allegany = now(),
    washington = now(),
    updatedby = 'CIDM-11321'
where objecttype = 'motivational-interview'
and activeflag = 1;
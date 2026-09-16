/*
   Issue Description: CDM-43980 The case was assigned when it is closed.
   Category/ Module  : Assignments
   Root cause: This case has been impacted due to recent user story changes CIDM-9543 which created a family assignment for the case
               Below are the rules implemented as the part of user story
                   When opening or reopening a case, family caseworker assignment must be mandatory.
                   No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned
                   Running the script file CIDM-9543-caseselfassignment.sql has cause this issue.
   Fix Provided: Data fix has been done to end date and remove the case assignment record that was created as the part of user story and also close the case.  
   Data/Code fix ticket#: CDM-43980
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: This is impacted due to CIDM-9543 user story and data fix should resolve it.  
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/

--Ending Assignment and closing it

update caseassignment set enddate='2025-01-17 00:00:00', activeflag = 0, updatedby = 'CDM-43980', updatedon = now()
where objectid='65fb61fe-5eaf-437c-9910-3808e90af85c' and caseassignmentid in ('c2734faa-472b-4607-aea6-0aba4ce66924','84058f30-360c-41d8-8844-a0201d90022f','35cadb8c-2bce-4bf3-90b3-21ea6f901d85','40c03c84-e592-4682-bc70-1528c7c1960b') ;


--Closing the case in servicecasedisposition
/*
select * from servicecasedisposition where servicecaseid = '6ef187ec-50f9-4d07-b7c4-5427d545d991';
*/

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed', dispositioncode = 'Closed', "comments" = 'Dev Closed', updatedby = 'CDM-43980', updatedon = now()
where servicecasedispositionid = '317072a0-b5d5-4af7-b4a2-03c80a74d3ad' and activeflag = 1;


UPDATE servicecase
SET statustypekey='Closed', dispositioncode='Closed', enddate='2009-03-26 00:00:00', updatedby='CDM-43980', updatedon=now() 
where servicecasenumber = '3303826'
and activeflag  = 1 ;


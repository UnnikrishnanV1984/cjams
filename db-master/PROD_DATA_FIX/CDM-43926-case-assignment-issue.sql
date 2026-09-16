/*
   Issue Description: CDM-43926 Incorrect case assignment on 1/17/25 Assignment.
   Category/ Module  : Assignments
   Root cause: This is an old dummy case and it has been updated as the part of the user story CIDM-9543 which created a family assignment for the case
               Below are the rules implemented as the part of user story
                   When opening or reopening a case, family caseworker assignment must be mandatory.
                   No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned
                   Running the script file CIDM-9543-caseselfassignment.sql has cause this issue.
   Fix Provided: Data fix has been done to end date and remove the case assignment record that was created as the part of user story and also close the case.  
   Data/Code fix ticket#: CDM-43926
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: This is impacted due to CIDM-9543 user story and data fix should resolve it.  
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/

--Ending Assignment and closing it

update caseassignment set enddate='2025-01-17 00:00:00', activeflag = 0, updatedby = 'CDM-43926', updatedon = now()
where objectid = '6e346571-1e57-4274-896f-5b823b0fb8e2';

update routing set activeflag=0, updatedby = 'CDM-43926', updatedon = now()
where objectid = '6e346571-1e57-4274-896f-5b823b0fb8e2';

--Closing the case in servicecasedisposition
/*
select * from servicecasedisposition where servicecaseid = '6e346571-1e57-4274-896f-5b823b0fb8e2';
*/

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed', dispositioncode = 'Closed', "comments" = 'Dev Closed', updatedby = 'CDM-43926', updatedon = now()
where servicecasedispositionid = 'c85da565-93a3-42d8-93c8-9787fd8bb715' and activeflag = 1;


UPDATE servicecase
SET statustypekey='Closed', dispositioncode='Closed', enddate='2025-01-17 00:00:00', updatedby='CDM-43926', updatedon=now() 
where servicecaseid = '6e346571-1e57-4274-896f-5b823b0fb8e2'
and activeflag  = 1 ;
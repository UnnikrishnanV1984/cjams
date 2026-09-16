-- CDM-42024 - Role change 
/*
-- Issue Description: 
   Alyson is populating in CJAMS in the drop down box of the list of supervisors. She is not a supervisor, she is an active caseworker.
-- Category/ Module: user roles
-- Root cause: Need to deactivate Please deactivate supervisor role for alyson.marshall@maryland.gov and make cwcaseworker as user's primary role
-- Fix Provided: Datafix has been promoted to make the case worker role as primary for Alyson from roles related tables. 
-- Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update rolemapping set roleid=71, updatedby='CDM-42024', updatedon=now() where principalid='48353' and activeflag=1;


update teammember set roletypekey='CWCW',updatedby='CDM-42024', updatedon=now() where teammemberid='640469d9-412a-4970-9563-8f09587a5e0c' and activeflag=1;
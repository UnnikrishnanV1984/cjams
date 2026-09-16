/*
   Issue Description: CDM-34695 -Deactivate central policy role for tousha moses
   Category/ Module  :  User Management
   Root cause: User doesnt have central policy staff role, change done in sailpoint 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userresource
SET activeflag=0, updatedby='CDM-34695', updatedon=now()
WHERE userresourceid='03b503a7-f68b-48d6-8a0f-c9a6cc81db39';

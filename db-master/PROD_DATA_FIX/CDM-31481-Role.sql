/*
   Issue Description: CDM-31481
   Category/ Module  : User Profile 
   Root cause: updating correct role 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.teammember
SET roletypekey='FNSFS', updatedby='CDM-31481', updatedon=now()
WHERE teammemberid='9fcca04e-d97d-42f4-beb9-4765b5d144f6';

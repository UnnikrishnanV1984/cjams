/*
   Issue Description: CDM-29306
   Category/ Module  : User Profile
   Root cause: User should have case supervisor default role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.teammember
SET roletypekey='CWSP', updatedby='CDM-29306', updatedon=now()
WHERE teammemberid='9ea63def-01bf-475c-b1c5-c460f50ac1a3';

UPDATE cjams.rolemapping
SET roleid=36, updatedon=now(), updatedby ='CDM-29306'
WHERE id=49275774 and principalid='13460';


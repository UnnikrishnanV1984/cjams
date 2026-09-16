/*
   Issue Description: CIDM-6874
   Category/ Module  : User Profile 
   Root cause: placement routing is not working as default role was LDSS
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE cjams.teammember
SET roletypekey='CWSP', updatedby='CIDM-6874', updatedon=now()
WHERE teammemberid='7a12013a-46c0-4309-afa2-564f576fd8a5';

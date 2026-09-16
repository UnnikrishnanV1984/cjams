/*
   Issue Description: CDM-29695
   Category/ Module  : User Profile
   Root cause: User should have case supervisor default role(Previous default role was Vendorup)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.teammember
SET roletypekey='CWSP', updatedby='CDM-29695', updatedon=now()
WHERE teammemberid='9994bedf-b6f2-4617-afd2-dc5f272b5304';



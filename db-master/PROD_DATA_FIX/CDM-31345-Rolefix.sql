/*
   Issue Description: CDM-31345
   Category/ Module  : teammember roletypekey updated
   Root cause: superviosr not shown in the supervisor list
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update teammember set roletypekey ='FNSFS', updatedby ='CDM-31345', updatedon = now()

where teammemberid ='d006624e-eac4-40fa-b319-c9978a6de0eb' and teamid ='0f493137-acfb-45a3-aa8a-c2224e383330';
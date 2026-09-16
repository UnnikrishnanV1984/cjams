/*
   Issue Description: CDM-19743
   Category/ Module  : case approval
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update assessment 
set securityusersid = '6b987691-d97b-43f6-a2ea-52fd6baf5bd2',  insertedby = '6b987691-d97b-43f6-a2ea-52fd6baf5bd2',updatedby = 'CDM-19743', updatedon = now()
where assessmentid = '96ea3e8b-727b-4cf3-9d20-0f78c0092498';
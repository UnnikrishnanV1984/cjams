/*
   Issue Description: CDM-15650
   Category/ Module  :  Agent prefex for person person issue
   Root cause: Agent was a added to prefx field
   Pull request# for code fix: 
   Reason why no related code fix: 
    this is a data fix
*/

update person
set
prefx = null,
updatedby = 'CDM-15650',
updatedon = now()
where personid = '51e7a83b-e763-48b0-b2c4-5b7aa7c56cfc';

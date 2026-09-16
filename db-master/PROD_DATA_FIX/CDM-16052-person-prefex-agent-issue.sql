/*
   Issue Description: CDM-16052
   Category/ Module  :  Agent prefex for person person issue
   Root cause: Agent was a added to prefx field
   Pull request# for code fix: 
   Reason why no related code fix: 
    this is a data fix
*/

update person
set
prefx = null,
updatedby = 'CDM-16052',
updatedon = now()
where personid = '772b333b-3f31-4e15-9d6d-5c84da38d19e';
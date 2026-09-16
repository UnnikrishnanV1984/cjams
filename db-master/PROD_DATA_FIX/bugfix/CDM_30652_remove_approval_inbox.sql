/*
   Issue Description: CDM-30652
   Category/ Module  : remove approved case from approval inbox
   Root cause: user wants to remove the case  from approval inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update routing set activeflag = 0, updatedby = 'CDM-30652', updatedon = now() where routingid in (
'03988410-ce9e-4db1-b88e-b721501a1f02' ,
'c1cc1f9b-9f93-4077-9f5b-d9fb6d9f7f88' ,
'ff7a6f22-4d4e-4250-b9f5-d1ca233304ab'
)

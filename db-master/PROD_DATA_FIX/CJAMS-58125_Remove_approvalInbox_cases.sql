/*
   Issue Description: CJAMS-58125
   Category/ Module  : remove approved case from approval inbox
   Root cause: user wants to remove the case  from approval inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update routing set activeflag = 0, 
    updatedby = 'CJAMS-58125',
     updatedon = now()
where routingid in (
'e97df8da-d72f-4577-92f4-dbcf0cdc5ca0',
'6c2e6f99-90ba-441c-b381-477bc1e601bd')
and activeflag = 1;
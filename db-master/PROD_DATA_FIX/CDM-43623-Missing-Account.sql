/*
   Issue Description: CDM-43263
   Category/ Module  : Prod data fix to remove roles from rolemapping table.
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update rolemapping 
set activeflag = 0, updatedby = 'CDM-43623', updatedon = now()
where id in (151963211 , 151969244) and principalid = '12769' and activeflag = 1;
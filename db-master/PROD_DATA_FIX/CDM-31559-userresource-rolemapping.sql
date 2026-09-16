/*
   Issue Description: CDM-31559
   Category/ Module  : Prod data fix to update rolemapping
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update  cjams.userresource
set activeflag = 0, updatedby = 'CDM-31669', updatedon = now()
where userid = '9659' and userresourceid = '9bb84b35-9f48-43aa-99d0-81eba98b8bdd';
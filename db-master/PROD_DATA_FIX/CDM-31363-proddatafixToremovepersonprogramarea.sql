/*
   Issue Description: CDM-31363
   Category/ Module  : Prod data fix to remover person program area
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personprogramarea set activeflag = 0, updatedby = 'CDM-31363', updatedon = now()
where personprogramid = '60d57051-8bef-4774-8726-dfde4080526c' and activeflag = 1;
/*
   Issue Description: CDM-27686
   Category/ Module  : Prod data fix to the person program area
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 2020-10-13 00:00:00
update personprogramarea set enddate = null, updatedby = 'CDM-27686', updatedon =  now()
where personprogramid in ('e81d6ffd-07db-4349-a69c-e3956b8bf8e3','ad0b5b94-b14e-4fab-abf2-cfa61334126d');

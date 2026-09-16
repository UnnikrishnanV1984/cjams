/*
   Issue Description: CDM-233114
   Category/ Module  : Prod data fix to update End Date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personprogramarea set enddate = '2021-09-30 00:05:00.000',
updatedon = now(), updatedby = 'CDM-23114' where personprogramid = 'aeefbf45-ee0f-446e-ad8f-fe4340ce9665'; 
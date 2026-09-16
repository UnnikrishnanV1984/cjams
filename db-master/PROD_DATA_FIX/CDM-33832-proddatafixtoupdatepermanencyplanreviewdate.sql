/*
   Issue Description: CDM-33832
   Category/ Module  : Prod data fix to update permanency plan review date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2023-03-23 04:00:00
update permanencyplan set reviewdate = '2023-02-23 04:00:00', updatedby = 'CDM-33832', updatedon = now()
where permanencyplanid = 'fe3708bc-20f7-4d8c-9409-477e489fa6c7';
 
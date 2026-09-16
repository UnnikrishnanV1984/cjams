/*
   Issue Description: CDM-24966
   Category/ Module  : Prod data fix to remove the permanency plan end date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2022-09-06 00:00:00.000
update permanencyplan set enddate = null, updatedon = now(), updatedby = 'CDM-24966' 
where permanencyplanid = '735ed95b-8cec-4bf4-afe7-eb1ced423dda';
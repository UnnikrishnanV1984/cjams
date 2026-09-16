/*
   Issue Description: CDM-24316
   Category/ Module  : Prod data fix to Remove exit date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2022-07-26 00:00:00.000
update intakeservreqchildremoval i set exitdate = null, updatedby = 'CDM-24316', updatedon = now() 
where intakeservreqchildremovalid  = '3f134dd4-a0f9-4b36-85ed-eabd1664332c';


update personprogramarea set enddate = null, updatedby = 'CDM-24316', updatedon = now() 
where personprogramid = 'cd134d2b-37a1-4d04-98f9-34e5f909c4e4';
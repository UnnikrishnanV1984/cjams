
/*
   Issue Description: CDM-15036
   Category/ Module  :  Update removal information
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



-- 2021-04-05 00:00:00
update personprogramarea set enddate = '2002-06-26 00:00:00', updatedby = 'CDM-15036', updatedon = now() where personprogramid = '59ce7569-5699-4b01-a8d6-a5959c81a7a6';
-- 2021-04-05 12:15:00
update intakeservreqchildremoval i set exitdate = '2002-06-26 00:00:00', updatedby = 'CDM-15036', updatedon = now() where intakeservreqchildremovalid = '5f1cdd2c-7dd5-47cc-8632-db90131e9c0e';
